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
declare i8* @sailfin_runtime_number_to_string(double)
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

define %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %artifacts) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t33 = phi double [ %t1, %block.entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l0
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
  %t19 = call i8* @malloc(i64 20)
  %t20 = bitcast i8* %t19 to [20 x i8]*
  store [20 x i8] c"sailfin-native-text\00", [20 x i8]* %t20
  %t21 = call i1 @strings_equal(i8* %t18, i8* %t19)
  %t22 = load double, double* %l0
  %t23 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %NativeArtifact, %NativeArtifact* %l1
  %t25 = getelementptr %NativeArtifact, %NativeArtifact* null, i32 1
  %t26 = ptrtoint %NativeArtifact* %t25 to i64
  %t27 = call noalias i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %NativeArtifact*
  store %NativeArtifact %t24, %NativeArtifact* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret %NativeArtifact* %t28
merge7:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t34 = load double, double* %l0
  %t35 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t35
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
  %t33 = phi double [ %t1, %block.entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l0
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
  %t19 = call i8* @malloc(i64 24)
  %t20 = bitcast i8* %t19 to [24 x i8]*
  store [24 x i8] c"sailfin-layout-manifest\00", [24 x i8]* %t20
  %t21 = call i1 @strings_equal(i8* %t18, i8* %t19)
  %t22 = load double, double* %l0
  %t23 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %NativeArtifact, %NativeArtifact* %l1
  %t25 = getelementptr %NativeArtifact, %NativeArtifact* null, i32 1
  %t26 = ptrtoint %NativeArtifact* %t25 to i64
  %t27 = call noalias i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %NativeArtifact*
  store %NativeArtifact %t24, %NativeArtifact* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret %NativeArtifact* %t28
merge7:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t34 = load double, double* %l0
  %t35 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t35
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
  %t1523 = phi double [ %t100, %block.entry ], [ %t1512, %loop.latch2 ]
  %t1524 = phi { i8**, i64 }* [ %t90, %block.entry ], [ %t1513, %loop.latch2 ]
  %t1525 = phi { %NativeImport*, i64 }* [ %t92, %block.entry ], [ %t1514, %loop.latch2 ]
  %t1526 = phi %NativeSourceSpan* [ %t98, %block.entry ], [ %t1515, %loop.latch2 ]
  %t1527 = phi %NativeSourceSpan* [ %t99, %block.entry ], [ %t1516, %loop.latch2 ]
  %t1528 = phi { %NativeStruct*, i64 }* [ %t93, %block.entry ], [ %t1517, %loop.latch2 ]
  %t1529 = phi { %NativeInterface*, i64 }* [ %t94, %block.entry ], [ %t1518, %loop.latch2 ]
  %t1530 = phi { %NativeEnum*, i64 }* [ %t95, %block.entry ], [ %t1519, %loop.latch2 ]
  %t1531 = phi %NativeFunction* [ %t97, %block.entry ], [ %t1520, %loop.latch2 ]
  %t1532 = phi { %NativeFunction*, i64 }* [ %t91, %block.entry ], [ %t1521, %loop.latch2 ]
  %t1533 = phi { %NativeBinding*, i64 }* [ %t96, %block.entry ], [ %t1522, %loop.latch2 ]
  store double %t1523, double* %l11
  store { i8**, i64 }* %t1524, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1525, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1526, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1527, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1528, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1529, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1530, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1531, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1532, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1533, { %NativeBinding*, i64 }** %l7
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
  %t174 = call i8* @malloc(i64 9)
  %t175 = bitcast i8* %t174 to [9 x i8]*
  store [9 x i8] c".module \00", [9 x i8]* %t175
  %t176 = call i1 @starts_with(i8* %t173, i8* %t174)
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
  %t195 = call i8* @malloc(i64 9)
  %t196 = bitcast i8* %t195 to [9 x i8]*
  store [9 x i8] c".import \00", [9 x i8]* %t196
  %t197 = call i1 @starts_with(i8* %t194, i8* %t195)
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t201 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t202 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t203 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t204 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t205 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t206 = load %NativeFunction*, %NativeFunction** %l8
  %t207 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t208 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t209 = load double, double* %l11
  %t210 = load i8*, i8** %l12
  %t211 = load i8*, i8** %l13
  br i1 %t197, label %then12, label %merge13
then12:
  %t212 = call i8* @malloc(i64 7)
  %t213 = bitcast i8* %t212 to [7 x i8]*
  store [7 x i8] c"import\00", [7 x i8]* %t213
  %t214 = load i8*, i8** %l13
  %t215 = call i8* @malloc(i64 9)
  %t216 = bitcast i8* %t215 to [9 x i8]*
  store [9 x i8] c".import \00", [9 x i8]* %t216
  %t217 = call i8* @strip_prefix(i8* %t214, i8* %t215)
  %t218 = call %NativeImport* @parse_import_entry(i8* %t212, i8* %t217)
  store %NativeImport* %t218, %NativeImport** %l14
  %t219 = load %NativeImport*, %NativeImport** %l14
  %t220 = icmp eq %NativeImport* %t219, null
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t224 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t225 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t226 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t227 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t228 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t229 = load %NativeFunction*, %NativeFunction** %l8
  %t230 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t231 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t232 = load double, double* %l11
  %t233 = load i8*, i8** %l12
  %t234 = load i8*, i8** %l13
  %t235 = load %NativeImport*, %NativeImport** %l14
  br i1 %t220, label %then14, label %else15
then14:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t237 = call i8* @malloc(i64 25)
  %t238 = bitcast i8* %t237 to [25 x i8]*
  store [25 x i8] c"unable to parse import: \00", [25 x i8]* %t238
  %t239 = load i8*, i8** %l13
  %t240 = call i8* @sailfin_runtime_string_concat(i8* %t237, i8* %t239)
  %t241 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t236, i8* %t240)
  store { i8**, i64 }* %t241, { i8**, i64 }** %l1
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t243 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t244 = load %NativeImport*, %NativeImport** %l14
  %t245 = load %NativeImport, %NativeImport* %t244
  %t246 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t243, %NativeImport %t245)
  store { %NativeImport*, i64 }* %t246, { %NativeImport*, i64 }** %l3
  %t247 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge16
merge16:
  %t248 = phi { i8**, i64 }* [ %t242, %then14 ], [ %t222, %else15 ]
  %t249 = phi { %NativeImport*, i64 }* [ %t224, %then14 ], [ %t247, %else15 ]
  store { i8**, i64 }* %t248, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t249, { %NativeImport*, i64 }** %l3
  %t250 = load double, double* %l11
  %t251 = sitofp i64 1 to double
  %t252 = fadd double %t250, %t251
  store double %t252, double* %l11
  br label %loop.latch2
merge13:
  %t253 = load i8*, i8** %l13
  %t254 = call i8* @malloc(i64 9)
  %t255 = bitcast i8* %t254 to [9 x i8]*
  store [9 x i8] c".export \00", [9 x i8]* %t255
  %t256 = call i1 @starts_with(i8* %t253, i8* %t254)
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t259 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t260 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t261 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t262 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t263 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t264 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t265 = load %NativeFunction*, %NativeFunction** %l8
  %t266 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t267 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t268 = load double, double* %l11
  %t269 = load i8*, i8** %l12
  %t270 = load i8*, i8** %l13
  br i1 %t256, label %then17, label %merge18
then17:
  %t271 = call i8* @malloc(i64 7)
  %t272 = bitcast i8* %t271 to [7 x i8]*
  store [7 x i8] c"export\00", [7 x i8]* %t272
  %t273 = load i8*, i8** %l13
  %t274 = call i8* @malloc(i64 9)
  %t275 = bitcast i8* %t274 to [9 x i8]*
  store [9 x i8] c".export \00", [9 x i8]* %t275
  %t276 = call i8* @strip_prefix(i8* %t273, i8* %t274)
  %t277 = call %NativeImport* @parse_import_entry(i8* %t271, i8* %t276)
  store %NativeImport* %t277, %NativeImport** %l15
  %t278 = load %NativeImport*, %NativeImport** %l15
  %t279 = icmp eq %NativeImport* %t278, null
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t282 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t283 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t284 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t285 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t286 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t287 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t288 = load %NativeFunction*, %NativeFunction** %l8
  %t289 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t290 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t291 = load double, double* %l11
  %t292 = load i8*, i8** %l12
  %t293 = load i8*, i8** %l13
  %t294 = load %NativeImport*, %NativeImport** %l15
  br i1 %t279, label %then19, label %else20
then19:
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = call i8* @malloc(i64 25)
  %t297 = bitcast i8* %t296 to [25 x i8]*
  store [25 x i8] c"unable to parse export: \00", [25 x i8]* %t297
  %t298 = load i8*, i8** %l13
  %t299 = call i8* @sailfin_runtime_string_concat(i8* %t296, i8* %t298)
  %t300 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t295, i8* %t299)
  store { i8**, i64 }* %t300, { i8**, i64 }** %l1
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t302 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t303 = load %NativeImport*, %NativeImport** %l15
  %t304 = load %NativeImport, %NativeImport* %t303
  %t305 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t302, %NativeImport %t304)
  store { %NativeImport*, i64 }* %t305, { %NativeImport*, i64 }** %l3
  %t306 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge21
merge21:
  %t307 = phi { i8**, i64 }* [ %t301, %then19 ], [ %t281, %else20 ]
  %t308 = phi { %NativeImport*, i64 }* [ %t283, %then19 ], [ %t306, %else20 ]
  store { i8**, i64 }* %t307, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t308, { %NativeImport*, i64 }** %l3
  %t309 = load double, double* %l11
  %t310 = sitofp i64 1 to double
  %t311 = fadd double %t309, %t310
  store double %t311, double* %l11
  br label %loop.latch2
merge18:
  %t312 = load i8*, i8** %l13
  %t313 = call i8* @malloc(i64 7)
  %t314 = bitcast i8* %t313 to [7 x i8]*
  store [7 x i8] c".span \00", [7 x i8]* %t314
  %t315 = call i1 @starts_with(i8* %t312, i8* %t313)
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t318 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t319 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t320 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t321 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t322 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t323 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t324 = load %NativeFunction*, %NativeFunction** %l8
  %t325 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t326 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t327 = load double, double* %l11
  %t328 = load i8*, i8** %l12
  %t329 = load i8*, i8** %l13
  br i1 %t315, label %then22, label %merge23
then22:
  %t330 = load i8*, i8** %l13
  %t331 = call i8* @malloc(i64 7)
  %t332 = bitcast i8* %t331 to [7 x i8]*
  store [7 x i8] c".span \00", [7 x i8]* %t332
  %t333 = call i8* @strip_prefix(i8* %t330, i8* %t331)
  %t334 = call %NativeSourceSpan* @parse_source_span(i8* %t333)
  store %NativeSourceSpan* %t334, %NativeSourceSpan** %l16
  %t335 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  %t336 = icmp eq %NativeSourceSpan* %t335, null
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t339 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t340 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t341 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t342 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t343 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t344 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t345 = load %NativeFunction*, %NativeFunction** %l8
  %t346 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t347 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t348 = load double, double* %l11
  %t349 = load i8*, i8** %l12
  %t350 = load i8*, i8** %l13
  %t351 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  br i1 %t336, label %then24, label %else25
then24:
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t353 = call i8* @malloc(i64 32)
  %t354 = bitcast i8* %t353 to [32 x i8]*
  store [32 x i8] c"unable to parse span metadata: \00", [32 x i8]* %t354
  %t355 = load i8*, i8** %l13
  %t356 = call i8* @sailfin_runtime_string_concat(i8* %t353, i8* %t355)
  %t357 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t352, i8* %t356)
  store { i8**, i64 }* %t357, { i8**, i64 }** %l1
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t359 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  store %NativeSourceSpan* %t359, %NativeSourceSpan** %l9
  %t360 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge26
merge26:
  %t361 = phi { i8**, i64 }* [ %t358, %then24 ], [ %t338, %else25 ]
  %t362 = phi %NativeSourceSpan* [ %t346, %then24 ], [ %t360, %else25 ]
  store { i8**, i64 }* %t361, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t362, %NativeSourceSpan** %l9
  %t363 = load double, double* %l11
  %t364 = sitofp i64 1 to double
  %t365 = fadd double %t363, %t364
  store double %t365, double* %l11
  br label %loop.latch2
merge23:
  %t366 = load i8*, i8** %l13
  %t367 = call i8* @malloc(i64 12)
  %t368 = bitcast i8* %t367 to [12 x i8]*
  store [12 x i8] c".init-span \00", [12 x i8]* %t368
  %t369 = call i1 @starts_with(i8* %t366, i8* %t367)
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t372 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t373 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t374 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t375 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t376 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t377 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t378 = load %NativeFunction*, %NativeFunction** %l8
  %t379 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t380 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t381 = load double, double* %l11
  %t382 = load i8*, i8** %l12
  %t383 = load i8*, i8** %l13
  br i1 %t369, label %then27, label %merge28
then27:
  %t384 = load i8*, i8** %l13
  %t385 = call i8* @malloc(i64 12)
  %t386 = bitcast i8* %t385 to [12 x i8]*
  store [12 x i8] c".init-span \00", [12 x i8]* %t386
  %t387 = call i8* @strip_prefix(i8* %t384, i8* %t385)
  %t388 = call %NativeSourceSpan* @parse_source_span(i8* %t387)
  store %NativeSourceSpan* %t388, %NativeSourceSpan** %l17
  %t389 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  %t390 = icmp eq %NativeSourceSpan* %t389, null
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t393 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t394 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t395 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t396 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t397 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t398 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t399 = load %NativeFunction*, %NativeFunction** %l8
  %t400 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t401 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t402 = load double, double* %l11
  %t403 = load i8*, i8** %l12
  %t404 = load i8*, i8** %l13
  %t405 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  br i1 %t390, label %then29, label %else30
then29:
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t407 = call i8* @malloc(i64 44)
  %t408 = bitcast i8* %t407 to [44 x i8]*
  store [44 x i8] c"unable to parse initializer span metadata: \00", [44 x i8]* %t408
  %t409 = load i8*, i8** %l13
  %t410 = call i8* @sailfin_runtime_string_concat(i8* %t407, i8* %t409)
  %t411 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t406, i8* %t410)
  store { i8**, i64 }* %t411, { i8**, i64 }** %l1
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
else30:
  %t413 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  store %NativeSourceSpan* %t413, %NativeSourceSpan** %l10
  %t414 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge31
merge31:
  %t415 = phi { i8**, i64 }* [ %t412, %then29 ], [ %t392, %else30 ]
  %t416 = phi %NativeSourceSpan* [ %t401, %then29 ], [ %t414, %else30 ]
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t416, %NativeSourceSpan** %l10
  %t417 = load double, double* %l11
  %t418 = sitofp i64 1 to double
  %t419 = fadd double %t417, %t418
  store double %t419, double* %l11
  br label %loop.latch2
merge28:
  %t420 = load i8*, i8** %l13
  %t421 = call i8* @malloc(i64 9)
  %t422 = bitcast i8* %t421 to [9 x i8]*
  store [9 x i8] c".struct \00", [9 x i8]* %t422
  %t423 = call i1 @starts_with(i8* %t420, i8* %t421)
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t426 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t427 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t428 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t429 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t430 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t431 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t432 = load %NativeFunction*, %NativeFunction** %l8
  %t433 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t434 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t435 = load double, double* %l11
  %t436 = load i8*, i8** %l12
  %t437 = load i8*, i8** %l13
  br i1 %t423, label %then32, label %merge33
then32:
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t439 = load double, double* %l11
  %t440 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t438, double %t439)
  store %StructParseResult %t440, %StructParseResult* %l18
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t442 = load %StructParseResult, %StructParseResult* %l18
  %t443 = extractvalue %StructParseResult %t442, 2
  %t444 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t441, { i8**, i64 }* %t443)
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  %t445 = load %StructParseResult, %StructParseResult* %l18
  %t446 = extractvalue %StructParseResult %t445, 0
  %t447 = icmp ne %NativeStruct* %t446, null
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t450 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t451 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t452 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t453 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t454 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t455 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t456 = load %NativeFunction*, %NativeFunction** %l8
  %t457 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t458 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t459 = load double, double* %l11
  %t460 = load i8*, i8** %l12
  %t461 = load i8*, i8** %l13
  %t462 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t447, label %then34, label %merge35
then34:
  %t463 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t464 = load %StructParseResult, %StructParseResult* %l18
  %t465 = extractvalue %StructParseResult %t464, 0
  %t466 = load %NativeStruct, %NativeStruct* %t465
  %t467 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t463, %NativeStruct %t466)
  store { %NativeStruct*, i64 }* %t467, { %NativeStruct*, i64 }** %l4
  %t468 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  br label %merge35
merge35:
  %t469 = phi { %NativeStruct*, i64 }* [ %t468, %then34 ], [ %t452, %then32 ]
  store { %NativeStruct*, i64 }* %t469, { %NativeStruct*, i64 }** %l4
  %t470 = load %StructParseResult, %StructParseResult* %l18
  %t471 = extractvalue %StructParseResult %t470, 1
  store double %t471, double* %l11
  br label %loop.latch2
merge33:
  %t472 = load i8*, i8** %l13
  %t473 = call i8* @malloc(i64 12)
  %t474 = bitcast i8* %t473 to [12 x i8]*
  store [12 x i8] c".interface \00", [12 x i8]* %t474
  %t475 = call i1 @starts_with(i8* %t472, i8* %t473)
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t479 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t480 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t481 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t482 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t483 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t484 = load %NativeFunction*, %NativeFunction** %l8
  %t485 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t486 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t487 = load double, double* %l11
  %t488 = load i8*, i8** %l12
  %t489 = load i8*, i8** %l13
  br i1 %t475, label %then36, label %merge37
then36:
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t491 = load double, double* %l11
  %t492 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t490, double %t491)
  store %InterfaceParseResult %t492, %InterfaceParseResult* %l19
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t495 = extractvalue %InterfaceParseResult %t494, 2
  %t496 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t493, { i8**, i64 }* %t495)
  store { i8**, i64 }* %t496, { i8**, i64 }** %l1
  %t497 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t498 = extractvalue %InterfaceParseResult %t497, 0
  %t499 = icmp ne %NativeInterface* %t498, null
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t502 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t503 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t504 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t505 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t506 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t507 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t508 = load %NativeFunction*, %NativeFunction** %l8
  %t509 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t510 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t511 = load double, double* %l11
  %t512 = load i8*, i8** %l12
  %t513 = load i8*, i8** %l13
  %t514 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t499, label %then38, label %merge39
then38:
  %t515 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t516 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t517 = extractvalue %InterfaceParseResult %t516, 0
  %t518 = load %NativeInterface, %NativeInterface* %t517
  %t519 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t515, %NativeInterface %t518)
  store { %NativeInterface*, i64 }* %t519, { %NativeInterface*, i64 }** %l5
  %t520 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  br label %merge39
merge39:
  %t521 = phi { %NativeInterface*, i64 }* [ %t520, %then38 ], [ %t505, %then36 ]
  store { %NativeInterface*, i64 }* %t521, { %NativeInterface*, i64 }** %l5
  %t522 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t523 = extractvalue %InterfaceParseResult %t522, 1
  store double %t523, double* %l11
  br label %loop.latch2
merge37:
  %t524 = load i8*, i8** %l13
  %t525 = call i8* @malloc(i64 7)
  %t526 = bitcast i8* %t525 to [7 x i8]*
  store [7 x i8] c".enum \00", [7 x i8]* %t526
  %t527 = call i1 @starts_with(i8* %t524, i8* %t525)
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t530 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t531 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t532 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t533 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t534 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t535 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t536 = load %NativeFunction*, %NativeFunction** %l8
  %t537 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t538 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t539 = load double, double* %l11
  %t540 = load i8*, i8** %l12
  %t541 = load i8*, i8** %l13
  br i1 %t527, label %then40, label %merge41
then40:
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t543 = load double, double* %l11
  %t544 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t542, double %t543)
  store %EnumParseResult %t544, %EnumParseResult* %l20
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t546 = load %EnumParseResult, %EnumParseResult* %l20
  %t547 = extractvalue %EnumParseResult %t546, 2
  %t548 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t545, { i8**, i64 }* %t547)
  store { i8**, i64 }* %t548, { i8**, i64 }** %l1
  %t549 = load %EnumParseResult, %EnumParseResult* %l20
  %t550 = extractvalue %EnumParseResult %t549, 0
  %t551 = icmp ne %NativeEnum* %t550, null
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t554 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t555 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t556 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t557 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t558 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t559 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t560 = load %NativeFunction*, %NativeFunction** %l8
  %t561 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t562 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t563 = load double, double* %l11
  %t564 = load i8*, i8** %l12
  %t565 = load i8*, i8** %l13
  %t566 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t551, label %then42, label %merge43
then42:
  %t567 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t568 = load %EnumParseResult, %EnumParseResult* %l20
  %t569 = extractvalue %EnumParseResult %t568, 0
  %t570 = load %NativeEnum, %NativeEnum* %t569
  %t571 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t567, %NativeEnum %t570)
  store { %NativeEnum*, i64 }* %t571, { %NativeEnum*, i64 }** %l6
  %t572 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  br label %merge43
merge43:
  %t573 = phi { %NativeEnum*, i64 }* [ %t572, %then42 ], [ %t558, %then40 ]
  store { %NativeEnum*, i64 }* %t573, { %NativeEnum*, i64 }** %l6
  %t574 = load %EnumParseResult, %EnumParseResult* %l20
  %t575 = extractvalue %EnumParseResult %t574, 1
  store double %t575, double* %l11
  br label %loop.latch2
merge41:
  %t576 = load i8*, i8** %l13
  %t577 = call i8* @malloc(i64 5)
  %t578 = bitcast i8* %t577 to [5 x i8]*
  store [5 x i8] c".fn \00", [5 x i8]* %t578
  %t579 = call i1 @starts_with(i8* %t576, i8* %t577)
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t582 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t583 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t584 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t585 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t586 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t587 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t588 = load %NativeFunction*, %NativeFunction** %l8
  %t589 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t590 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t591 = load double, double* %l11
  %t592 = load i8*, i8** %l12
  %t593 = load i8*, i8** %l13
  br i1 %t579, label %then44, label %merge45
then44:
  %t594 = load %NativeFunction*, %NativeFunction** %l8
  %t595 = icmp ne %NativeFunction* %t594, null
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t598 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t599 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t600 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t601 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t602 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t603 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t604 = load %NativeFunction*, %NativeFunction** %l8
  %t605 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t606 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t607 = load double, double* %l11
  %t608 = load i8*, i8** %l12
  %t609 = load i8*, i8** %l13
  br i1 %t595, label %then46, label %merge47
then46:
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t611 = call i8* @malloc(i64 58)
  %t612 = bitcast i8* %t611 to [58 x i8]*
  store [58 x i8] c"encountered nested .fn while previous function still open\00", [58 x i8]* %t612
  %t613 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t610, i8* %t611)
  store { i8**, i64 }* %t613, { i8**, i64 }** %l1
  %t614 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t615 = phi { i8**, i64 }* [ %t614, %then46 ], [ %t597, %then44 ]
  store { i8**, i64 }* %t615, { i8**, i64 }** %l1
  %t616 = load i8*, i8** %l13
  %t617 = call i8* @malloc(i64 5)
  %t618 = bitcast i8* %t617 to [5 x i8]*
  store [5 x i8] c".fn \00", [5 x i8]* %t618
  %t619 = call i8* @strip_prefix(i8* %t616, i8* %t617)
  %t620 = call i8* @parse_function_name(i8* %t619)
  %t621 = insertvalue %NativeFunction undef, i8* %t620, 0
  %t622 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t623 = ptrtoint [0 x %NativeParameter]* %t622 to i64
  %t624 = icmp eq i64 %t623, 0
  %t625 = select i1 %t624, i64 1, i64 %t623
  %t626 = call i8* @malloc(i64 %t625)
  %t627 = bitcast i8* %t626 to %NativeParameter*
  %t628 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t629 = ptrtoint { %NativeParameter*, i64 }* %t628 to i64
  %t630 = call i8* @malloc(i64 %t629)
  %t631 = bitcast i8* %t630 to { %NativeParameter*, i64 }*
  %t632 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t631, i32 0, i32 0
  store %NativeParameter* %t627, %NativeParameter** %t632
  %t633 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t631, i32 0, i32 1
  store i64 0, i64* %t633
  %t634 = insertvalue %NativeFunction %t621, { %NativeParameter*, i64 }* %t631, 1
  %t635 = call i8* @malloc(i64 5)
  %t636 = bitcast i8* %t635 to [5 x i8]*
  store [5 x i8] c"void\00", [5 x i8]* %t636
  %t637 = insertvalue %NativeFunction %t634, i8* %t635, 2
  %t638 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t639 = ptrtoint [0 x i8*]* %t638 to i64
  %t640 = icmp eq i64 %t639, 0
  %t641 = select i1 %t640, i64 1, i64 %t639
  %t642 = call i8* @malloc(i64 %t641)
  %t643 = bitcast i8* %t642 to i8**
  %t644 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t645 = ptrtoint { i8**, i64 }* %t644 to i64
  %t646 = call i8* @malloc(i64 %t645)
  %t647 = bitcast i8* %t646 to { i8**, i64 }*
  %t648 = getelementptr { i8**, i64 }, { i8**, i64 }* %t647, i32 0, i32 0
  store i8** %t643, i8*** %t648
  %t649 = getelementptr { i8**, i64 }, { i8**, i64 }* %t647, i32 0, i32 1
  store i64 0, i64* %t649
  %t650 = insertvalue %NativeFunction %t637, { i8**, i64 }* %t647, 3
  %t651 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t652 = ptrtoint [0 x %NativeInstruction]* %t651 to i64
  %t653 = icmp eq i64 %t652, 0
  %t654 = select i1 %t653, i64 1, i64 %t652
  %t655 = call i8* @malloc(i64 %t654)
  %t656 = bitcast i8* %t655 to %NativeInstruction*
  %t657 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t658 = ptrtoint { %NativeInstruction*, i64 }* %t657 to i64
  %t659 = call i8* @malloc(i64 %t658)
  %t660 = bitcast i8* %t659 to { %NativeInstruction*, i64 }*
  %t661 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t660, i32 0, i32 0
  store %NativeInstruction* %t656, %NativeInstruction** %t661
  %t662 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t660, i32 0, i32 1
  store i64 0, i64* %t662
  %t663 = insertvalue %NativeFunction %t650, { %NativeInstruction*, i64 }* %t660, 4
  %t664 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t665 = ptrtoint %NativeFunction* %t664 to i64
  %t666 = call noalias i8* @malloc(i64 %t665)
  %t667 = bitcast i8* %t666 to %NativeFunction*
  store %NativeFunction %t663, %NativeFunction* %t667
  call void @sailfin_runtime_mark_persistent(i8* %t666)
  store %NativeFunction* %t667, %NativeFunction** %l8
  %t668 = load double, double* %l11
  %t669 = sitofp i64 1 to double
  %t670 = fadd double %t668, %t669
  store double %t670, double* %l11
  br label %loop.latch2
merge45:
  %t671 = load i8*, i8** %l13
  %t672 = call i8* @malloc(i64 7)
  %t673 = bitcast i8* %t672 to [7 x i8]*
  store [7 x i8] c".endfn\00", [7 x i8]* %t673
  %t674 = call i1 @starts_with(i8* %t671, i8* %t672)
  %t675 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t676 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t677 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t678 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t679 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t680 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t681 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t682 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t683 = load %NativeFunction*, %NativeFunction** %l8
  %t684 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t685 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t686 = load double, double* %l11
  %t687 = load i8*, i8** %l12
  %t688 = load i8*, i8** %l13
  br i1 %t674, label %then48, label %merge49
then48:
  %t689 = load %NativeFunction*, %NativeFunction** %l8
  %t690 = icmp eq %NativeFunction* %t689, null
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t692 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t693 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t694 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t695 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t696 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t697 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t698 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t699 = load %NativeFunction*, %NativeFunction** %l8
  %t700 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t701 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t702 = load double, double* %l11
  %t703 = load i8*, i8** %l12
  %t704 = load i8*, i8** %l13
  br i1 %t690, label %then50, label %else51
then50:
  %t705 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t706 = call i8* @malloc(i64 43)
  %t707 = bitcast i8* %t706 to [43 x i8]*
  store [43 x i8] c"encountered .endfn without active function\00", [43 x i8]* %t707
  %t708 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t705, i8* %t706)
  store { i8**, i64 }* %t708, { i8**, i64 }** %l1
  %t709 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t710 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t711 = load %NativeFunction*, %NativeFunction** %l8
  %t712 = load %NativeFunction, %NativeFunction* %t711
  %t713 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t710, %NativeFunction %t712)
  store { %NativeFunction*, i64 }* %t713, { %NativeFunction*, i64 }** %l2
  %t714 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t714, %NativeFunction** %l8
  %t715 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t716 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge52
merge52:
  %t717 = phi { i8**, i64 }* [ %t709, %then50 ], [ %t692, %else51 ]
  %t718 = phi { %NativeFunction*, i64 }* [ %t693, %then50 ], [ %t715, %else51 ]
  %t719 = phi %NativeFunction* [ %t699, %then50 ], [ %t716, %else51 ]
  store { i8**, i64 }* %t717, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t718, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t719, %NativeFunction** %l8
  %t720 = load double, double* %l11
  %t721 = sitofp i64 1 to double
  %t722 = fadd double %t720, %t721
  store double %t722, double* %l11
  br label %loop.latch2
merge49:
  %t723 = load i8*, i8** %l13
  %t724 = call i8* @malloc(i64 7)
  %t725 = bitcast i8* %t724 to [7 x i8]*
  store [7 x i8] c".meta \00", [7 x i8]* %t725
  %t726 = call i1 @starts_with(i8* %t723, i8* %t724)
  %t727 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t728 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t729 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t730 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t731 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t732 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t733 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t734 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t735 = load %NativeFunction*, %NativeFunction** %l8
  %t736 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t737 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t738 = load double, double* %l11
  %t739 = load i8*, i8** %l12
  %t740 = load i8*, i8** %l13
  br i1 %t726, label %then53, label %merge54
then53:
  %t741 = load %NativeFunction*, %NativeFunction** %l8
  %t742 = icmp ne %NativeFunction* %t741, null
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t744 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t745 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t746 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t747 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t748 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t749 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t750 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t751 = load %NativeFunction*, %NativeFunction** %l8
  %t752 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t753 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t754 = load double, double* %l11
  %t755 = load i8*, i8** %l12
  %t756 = load i8*, i8** %l13
  br i1 %t742, label %then55, label %else56
then55:
  %t757 = load %NativeFunction*, %NativeFunction** %l8
  %t758 = load i8*, i8** %l13
  %t759 = call i8* @malloc(i64 7)
  %t760 = bitcast i8* %t759 to [7 x i8]*
  store [7 x i8] c".meta \00", [7 x i8]* %t760
  %t761 = call i8* @strip_prefix(i8* %t758, i8* %t759)
  %t762 = load %NativeFunction, %NativeFunction* %t757
  %t763 = call %NativeFunction @apply_meta(%NativeFunction %t762, i8* %t761)
  %t764 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t765 = ptrtoint %NativeFunction* %t764 to i64
  %t766 = call noalias i8* @malloc(i64 %t765)
  %t767 = bitcast i8* %t766 to %NativeFunction*
  store %NativeFunction %t763, %NativeFunction* %t767
  call void @sailfin_runtime_mark_persistent(i8* %t766)
  store %NativeFunction* %t767, %NativeFunction** %l8
  %t768 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge57
else56:
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t770 = call i8* @malloc(i64 33)
  %t771 = bitcast i8* %t770 to [33 x i8]*
  store [33 x i8] c"metadata outside function body: \00", [33 x i8]* %t771
  %t772 = load i8*, i8** %l13
  %t773 = call i8* @sailfin_runtime_string_concat(i8* %t770, i8* %t772)
  %t774 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t769, i8* %t773)
  store { i8**, i64 }* %t774, { i8**, i64 }** %l1
  %t775 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t776 = phi %NativeFunction* [ %t768, %then55 ], [ %t751, %else56 ]
  %t777 = phi { i8**, i64 }* [ %t744, %then55 ], [ %t775, %else56 ]
  store %NativeFunction* %t776, %NativeFunction** %l8
  store { i8**, i64 }* %t777, { i8**, i64 }** %l1
  %t778 = load double, double* %l11
  %t779 = sitofp i64 1 to double
  %t780 = fadd double %t778, %t779
  store double %t780, double* %l11
  br label %loop.latch2
merge54:
  %t781 = load i8*, i8** %l13
  %t782 = call i8* @malloc(i64 8)
  %t783 = bitcast i8* %t782 to [8 x i8]*
  store [8 x i8] c".param \00", [8 x i8]* %t783
  %t784 = call i1 @starts_with(i8* %t781, i8* %t782)
  %t785 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t786 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t787 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t788 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t789 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t790 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t791 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t792 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t793 = load %NativeFunction*, %NativeFunction** %l8
  %t794 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t795 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t796 = load double, double* %l11
  %t797 = load i8*, i8** %l12
  %t798 = load i8*, i8** %l13
  br i1 %t784, label %then58, label %merge59
then58:
  %t799 = load %NativeFunction*, %NativeFunction** %l8
  %t800 = icmp ne %NativeFunction* %t799, null
  %t801 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t802 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t803 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t804 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t805 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t806 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t807 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t808 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t809 = load %NativeFunction*, %NativeFunction** %l8
  %t810 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t811 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t812 = load double, double* %l11
  %t813 = load i8*, i8** %l12
  %t814 = load i8*, i8** %l13
  br i1 %t800, label %then60, label %else61
then60:
  %t815 = load i8*, i8** %l13
  %t816 = call i8* @malloc(i64 8)
  %t817 = bitcast i8* %t816 to [8 x i8]*
  store [8 x i8] c".param \00", [8 x i8]* %t817
  %t818 = call i8* @strip_prefix(i8* %t815, i8* %t816)
  store i8* %t818, i8** %l21
  %t819 = load double, double* %l11
  %t820 = sitofp i64 1 to double
  %t821 = fadd double %t819, %t820
  store double %t821, double* %l22
  %t822 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t823 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t824 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t825 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t826 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t827 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t828 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t829 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t830 = load %NativeFunction*, %NativeFunction** %l8
  %t831 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t832 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t833 = load double, double* %l11
  %t834 = load i8*, i8** %l12
  %t835 = load i8*, i8** %l13
  %t836 = load i8*, i8** %l21
  %t837 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t949 = phi double [ %t837, %then60 ], [ %t947, %loop.latch65 ]
  %t950 = phi i8* [ %t836, %then60 ], [ %t948, %loop.latch65 ]
  store double %t949, double* %l22
  store i8* %t950, i8** %l21
  br label %loop.body64
loop.body64:
  %t838 = load double, double* %l22
  %t839 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t840 = load { i8**, i64 }, { i8**, i64 }* %t839
  %t841 = extractvalue { i8**, i64 } %t840, 1
  %t842 = sitofp i64 %t841 to double
  %t843 = fcmp oge double %t838, %t842
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
  br i1 %t843, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t861 = load double, double* %l22
  %t862 = call double @llvm.round.f64(double %t861)
  %t863 = fptosi double %t862 to i64
  %t864 = load { i8**, i64 }, { i8**, i64 }* %t860
  %t865 = extractvalue { i8**, i64 } %t864, 0
  %t866 = extractvalue { i8**, i64 } %t864, 1
  %t867 = icmp uge i64 %t863, %t866
  ; bounds check: %t867 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t863, i64 %t866)
  %t868 = getelementptr i8*, i8** %t865, i64 %t863
  %t869 = load i8*, i8** %t868
  store i8* %t869, i8** %l23
  %t870 = load i8*, i8** %l23
  %t871 = call i64 @sailfin_runtime_string_length(i8* %t870)
  %t872 = icmp eq i64 %t871, 0
  %t873 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t874 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t875 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t876 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t877 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t878 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t879 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t880 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t881 = load %NativeFunction*, %NativeFunction** %l8
  %t882 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t883 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t884 = load double, double* %l11
  %t885 = load i8*, i8** %l12
  %t886 = load i8*, i8** %l13
  %t887 = load i8*, i8** %l21
  %t888 = load double, double* %l22
  %t889 = load i8*, i8** %l23
  br i1 %t872, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t890 = load i8*, i8** %l23
  %t891 = call i8* @trim_text(i8* %t890)
  store i8* %t891, i8** %l24
  %t892 = load i8*, i8** %l24
  %t893 = call i64 @sailfin_runtime_string_length(i8* %t892)
  %t894 = icmp eq i64 %t893, 0
  %t895 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t896 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t897 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t898 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t899 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t900 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t901 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t902 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t903 = load %NativeFunction*, %NativeFunction** %l8
  %t904 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t905 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t906 = load double, double* %l11
  %t907 = load i8*, i8** %l12
  %t908 = load i8*, i8** %l13
  %t909 = load i8*, i8** %l21
  %t910 = load double, double* %l22
  %t911 = load i8*, i8** %l23
  %t912 = load i8*, i8** %l24
  br i1 %t894, label %then71, label %merge72
then71:
  %t913 = load double, double* %l22
  %t914 = sitofp i64 1 to double
  %t915 = fadd double %t913, %t914
  store double %t915, double* %l22
  br label %loop.latch65
merge72:
  %t916 = load i8*, i8** %l24
  %t917 = call i1 @line_looks_like_parameter_entry(i8* %t916)
  %t918 = xor i1 %t917, 1
  %t919 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t921 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t922 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t923 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t924 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t925 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t926 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t927 = load %NativeFunction*, %NativeFunction** %l8
  %t928 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t929 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t930 = load double, double* %l11
  %t931 = load i8*, i8** %l12
  %t932 = load i8*, i8** %l13
  %t933 = load i8*, i8** %l21
  %t934 = load double, double* %l22
  %t935 = load i8*, i8** %l23
  %t936 = load i8*, i8** %l24
  br i1 %t918, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t937 = load i8*, i8** %l21
  %t938 = add i64 0, 2
  %t939 = call i8* @malloc(i64 %t938)
  store i8 32, i8* %t939
  %t940 = getelementptr i8, i8* %t939, i64 1
  store i8 0, i8* %t940
  call void @sailfin_runtime_mark_persistent(i8* %t939)
  %t941 = call i8* @sailfin_runtime_string_concat(i8* %t937, i8* %t939)
  %t942 = load i8*, i8** %l24
  %t943 = call i8* @sailfin_runtime_string_concat(i8* %t941, i8* %t942)
  store i8* %t943, i8** %l21
  %t944 = load double, double* %l22
  %t945 = sitofp i64 1 to double
  %t946 = fadd double %t944, %t945
  store double %t946, double* %l22
  br label %loop.latch65
loop.latch65:
  %t947 = load double, double* %l22
  %t948 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t951 = load double, double* %l22
  %t952 = load i8*, i8** %l21
  %t953 = load i8*, i8** %l21
  %t954 = call { i8**, i64 }* @split_parameter_entries(i8* %t953)
  store { i8**, i64 }* %t954, { i8**, i64 }** %l25
  %t955 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t956 = load { i8**, i64 }, { i8**, i64 }* %t955
  %t957 = extractvalue { i8**, i64 } %t956, 1
  %t958 = icmp eq i64 %t957, 0
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t961 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t962 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t963 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t964 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t965 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t966 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t967 = load %NativeFunction*, %NativeFunction** %l8
  %t968 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t969 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t970 = load double, double* %l11
  %t971 = load i8*, i8** %l12
  %t972 = load i8*, i8** %l13
  %t973 = load i8*, i8** %l21
  %t974 = load double, double* %l22
  %t975 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t958, label %then75, label %else76
then75:
  %t976 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t977 = call i8* @malloc(i64 33)
  %t978 = bitcast i8* %t977 to [33 x i8]*
  store [33 x i8] c"unable to parse parameter line: \00", [33 x i8]* %t978
  %t979 = load i8*, i8** %l13
  %t980 = call i8* @sailfin_runtime_string_concat(i8* %t977, i8* %t979)
  %t981 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t976, i8* %t980)
  store { i8**, i64 }* %t981, { i8**, i64 }** %l1
  %t982 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t982, %NativeSourceSpan** %l9
  %t983 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t984 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t985 = sitofp i64 0 to double
  store double %t985, double* %l26
  store i1 0, i1* %l27
  %t986 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t987 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t988 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t989 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t990 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t991 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t992 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t993 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t994 = load %NativeFunction*, %NativeFunction** %l8
  %t995 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t996 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t997 = load double, double* %l11
  %t998 = load i8*, i8** %l12
  %t999 = load i8*, i8** %l13
  %t1000 = load i8*, i8** %l21
  %t1001 = load double, double* %l22
  %t1002 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1003 = load double, double* %l26
  %t1004 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1149 = phi { i8**, i64 }* [ %t987, %else76 ], [ %t1145, %loop.latch80 ]
  %t1150 = phi %NativeFunction* [ %t994, %else76 ], [ %t1146, %loop.latch80 ]
  %t1151 = phi i1 [ %t1004, %else76 ], [ %t1147, %loop.latch80 ]
  %t1152 = phi double [ %t1003, %else76 ], [ %t1148, %loop.latch80 ]
  store { i8**, i64 }* %t1149, { i8**, i64 }** %l1
  store %NativeFunction* %t1150, %NativeFunction** %l8
  store i1 %t1151, i1* %l27
  store double %t1152, double* %l26
  br label %loop.body79
loop.body79:
  %t1005 = load double, double* %l26
  %t1006 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1007 = load { i8**, i64 }, { i8**, i64 }* %t1006
  %t1008 = extractvalue { i8**, i64 } %t1007, 1
  %t1009 = sitofp i64 %t1008 to double
  %t1010 = fcmp oge double %t1005, %t1009
  %t1011 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1012 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1013 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1014 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1015 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1016 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1017 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1018 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1019 = load %NativeFunction*, %NativeFunction** %l8
  %t1020 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1021 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1022 = load double, double* %l11
  %t1023 = load i8*, i8** %l12
  %t1024 = load i8*, i8** %l13
  %t1025 = load i8*, i8** %l21
  %t1026 = load double, double* %l22
  %t1027 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1028 = load double, double* %l26
  %t1029 = load i1, i1* %l27
  br i1 %t1010, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t1030 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1031 = load double, double* %l26
  %t1032 = call double @llvm.round.f64(double %t1031)
  %t1033 = fptosi double %t1032 to i64
  %t1034 = load { i8**, i64 }, { i8**, i64 }* %t1030
  %t1035 = extractvalue { i8**, i64 } %t1034, 0
  %t1036 = extractvalue { i8**, i64 } %t1034, 1
  %t1037 = icmp uge i64 %t1033, %t1036
  ; bounds check: %t1037 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1033, i64 %t1036)
  %t1038 = getelementptr i8*, i8** %t1035, i64 %t1033
  %t1039 = load i8*, i8** %t1038
  store i8* %t1039, i8** %l28
  %t1040 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1040, %NativeSourceSpan** %l29
  %t1041 = load i1, i1* %l27
  %t1042 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1043 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1044 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1045 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1046 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1047 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1048 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1049 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1050 = load %NativeFunction*, %NativeFunction** %l8
  %t1051 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1052 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1053 = load double, double* %l11
  %t1054 = load i8*, i8** %l12
  %t1055 = load i8*, i8** %l13
  %t1056 = load i8*, i8** %l21
  %t1057 = load double, double* %l22
  %t1058 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1059 = load double, double* %l26
  %t1060 = load i1, i1* %l27
  %t1061 = load i8*, i8** %l28
  %t1062 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t1041, label %then84, label %merge85
then84:
  %t1063 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1063, %NativeSourceSpan** %l29
  %t1064 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t1065 = phi %NativeSourceSpan* [ %t1064, %then84 ], [ %t1062, %merge83 ]
  store %NativeSourceSpan* %t1065, %NativeSourceSpan** %l29
  %t1066 = load i8*, i8** %l28
  %t1067 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1068 = call %NativeParameter* @parse_parameter_entry(i8* %t1066, %NativeSourceSpan* %t1067)
  store %NativeParameter* %t1068, %NativeParameter** %l30
  %t1069 = load %NativeParameter*, %NativeParameter** %l30
  %t1070 = icmp eq %NativeParameter* %t1069, null
  %t1071 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1072 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1073 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1074 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1075 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1076 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1077 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1078 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1079 = load %NativeFunction*, %NativeFunction** %l8
  %t1080 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1081 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1082 = load double, double* %l11
  %t1083 = load i8*, i8** %l12
  %t1084 = load i8*, i8** %l13
  %t1085 = load i8*, i8** %l21
  %t1086 = load double, double* %l22
  %t1087 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1088 = load double, double* %l26
  %t1089 = load i1, i1* %l27
  %t1090 = load i8*, i8** %l28
  %t1091 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1092 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1070, label %then86, label %else87
then86:
  %t1093 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1094 = call i8* @malloc(i64 34)
  %t1095 = bitcast i8* %t1094 to [34 x i8]*
  store [34 x i8] c"unable to parse parameter entry: \00", [34 x i8]* %t1095
  %t1096 = load i8*, i8** %l28
  %t1097 = call i8* @sailfin_runtime_string_concat(i8* %t1094, i8* %t1096)
  %t1098 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1093, i8* %t1097)
  store { i8**, i64 }* %t1098, { i8**, i64 }** %l1
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t1100 = load %NativeFunction*, %NativeFunction** %l8
  %t1101 = load %NativeParameter*, %NativeParameter** %l30
  %t1102 = load %NativeFunction, %NativeFunction* %t1100
  %t1103 = load %NativeParameter, %NativeParameter* %t1101
  %t1104 = call %NativeFunction @append_parameter(%NativeFunction %t1102, %NativeParameter %t1103)
  %t1105 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t1106 = ptrtoint %NativeFunction* %t1105 to i64
  %t1107 = call noalias i8* @malloc(i64 %t1106)
  %t1108 = bitcast i8* %t1107 to %NativeFunction*
  store %NativeFunction %t1104, %NativeFunction* %t1108
  call void @sailfin_runtime_mark_persistent(i8* %t1107)
  store %NativeFunction* %t1108, %NativeFunction** %l8
  %t1109 = load %NativeParameter*, %NativeParameter** %l30
  %t1110 = getelementptr %NativeParameter, %NativeParameter* %t1109, i32 0, i32 4
  %t1111 = load %NativeSourceSpan*, %NativeSourceSpan** %t1110
  %t1112 = icmp ne %NativeSourceSpan* %t1111, null
  %t1113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1115 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1116 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1117 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1118 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1119 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1120 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1121 = load %NativeFunction*, %NativeFunction** %l8
  %t1122 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1123 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1124 = load double, double* %l11
  %t1125 = load i8*, i8** %l12
  %t1126 = load i8*, i8** %l13
  %t1127 = load i8*, i8** %l21
  %t1128 = load double, double* %l22
  %t1129 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1130 = load double, double* %l26
  %t1131 = load i1, i1* %l27
  %t1132 = load i8*, i8** %l28
  %t1133 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1134 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1112, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  %t1135 = load i1, i1* %l27
  br label %merge90
merge90:
  %t1136 = phi i1 [ %t1135, %then89 ], [ %t1131, %else87 ]
  store i1 %t1136, i1* %l27
  %t1137 = load %NativeFunction*, %NativeFunction** %l8
  %t1138 = load i1, i1* %l27
  br label %merge88
merge88:
  %t1139 = phi { i8**, i64 }* [ %t1099, %then86 ], [ %t1072, %merge90 ]
  %t1140 = phi %NativeFunction* [ %t1079, %then86 ], [ %t1137, %merge90 ]
  %t1141 = phi i1 [ %t1089, %then86 ], [ %t1138, %merge90 ]
  store { i8**, i64 }* %t1139, { i8**, i64 }** %l1
  store %NativeFunction* %t1140, %NativeFunction** %l8
  store i1 %t1141, i1* %l27
  %t1142 = load double, double* %l26
  %t1143 = sitofp i64 1 to double
  %t1144 = fadd double %t1142, %t1143
  store double %t1144, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1146 = load %NativeFunction*, %NativeFunction** %l8
  %t1147 = load i1, i1* %l27
  %t1148 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1154 = load %NativeFunction*, %NativeFunction** %l8
  %t1155 = load i1, i1* %l27
  %t1156 = load double, double* %l26
  %t1157 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1157, %NativeSourceSpan** %l9
  %t1158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1159 = load %NativeFunction*, %NativeFunction** %l8
  %t1160 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1161 = phi { i8**, i64 }* [ %t983, %then75 ], [ %t1158, %afterloop81 ]
  %t1162 = phi %NativeSourceSpan* [ %t984, %then75 ], [ %t1160, %afterloop81 ]
  %t1163 = phi %NativeFunction* [ %t967, %then75 ], [ %t1159, %afterloop81 ]
  store { i8**, i64 }* %t1161, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1162, %NativeSourceSpan** %l9
  store %NativeFunction* %t1163, %NativeFunction** %l8
  %t1164 = load double, double* %l22
  %t1165 = sitofp i64 1 to double
  %t1166 = fsub double %t1164, %t1165
  store double %t1166, double* %l11
  %t1167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1168 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1170 = load %NativeFunction*, %NativeFunction** %l8
  %t1171 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1172 = load double, double* %l11
  br label %merge62
else61:
  %t1173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1174 = call i8* @malloc(i64 34)
  %t1175 = bitcast i8* %t1174 to [34 x i8]*
  store [34 x i8] c"parameter outside function body: \00", [34 x i8]* %t1175
  %t1176 = load i8*, i8** %l13
  %t1177 = call i8* @sailfin_runtime_string_concat(i8* %t1174, i8* %t1176)
  %t1178 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1173, i8* %t1177)
  store { i8**, i64 }* %t1178, { i8**, i64 }** %l1
  %t1179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1180 = phi { i8**, i64 }* [ %t1167, %merge77 ], [ %t1179, %else61 ]
  %t1181 = phi %NativeSourceSpan* [ %t1168, %merge77 ], [ %t810, %else61 ]
  %t1182 = phi %NativeFunction* [ %t1170, %merge77 ], [ %t809, %else61 ]
  %t1183 = phi double [ %t1172, %merge77 ], [ %t812, %else61 ]
  store { i8**, i64 }* %t1180, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1181, %NativeSourceSpan** %l9
  store %NativeFunction* %t1182, %NativeFunction** %l8
  store double %t1183, double* %l11
  %t1184 = load double, double* %l11
  %t1185 = sitofp i64 1 to double
  %t1186 = fadd double %t1184, %t1185
  store double %t1186, double* %l11
  br label %loop.latch2
merge59:
  %t1187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1188 = load double, double* %l11
  %t1189 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1187, double %t1188)
  store %InstructionGatherResult %t1189, %InstructionGatherResult* %l31
  %t1190 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1191 = extractvalue %InstructionGatherResult %t1190, 0
  store i8* %t1191, i8** %l13
  %t1192 = load double, double* %l11
  %t1193 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1194 = extractvalue %InstructionGatherResult %t1193, 1
  %t1195 = fadd double %t1192, %t1194
  store double %t1195, double* %l11
  %t1196 = load i8*, i8** %l13
  %t1197 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1198 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1199 = call %InstructionParseResult @parse_instruction(i8* %t1196, %NativeSourceSpan* %t1197, %NativeSourceSpan* %t1198)
  store %InstructionParseResult %t1199, %InstructionParseResult* %l32
  %t1200 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1201 = extractvalue %InstructionParseResult %t1200, 0
  store { %NativeInstruction*, i64 }* %t1201, { %NativeInstruction*, i64 }** %l33
  %t1202 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1203 = extractvalue %InstructionParseResult %t1202, 1
  %t1204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1206 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1207 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1208 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1209 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1210 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1211 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1212 = load %NativeFunction*, %NativeFunction** %l8
  %t1213 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1214 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1215 = load double, double* %l11
  %t1216 = load i8*, i8** %l12
  %t1217 = load i8*, i8** %l13
  %t1218 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1219 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1220 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1203, label %then91, label %else92
then91:
  %t1221 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1221, %NativeSourceSpan** %l9
  %t1222 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1223 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1224 = icmp ne %NativeSourceSpan* %t1223, null
  %t1225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1227 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1228 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1229 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1230 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1231 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1232 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1233 = load %NativeFunction*, %NativeFunction** %l8
  %t1234 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1235 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1236 = load double, double* %l11
  %t1237 = load i8*, i8** %l12
  %t1238 = load i8*, i8** %l13
  %t1239 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1240 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1241 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1224, label %then94, label %merge95
then94:
  %t1242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1243 = call i8* @malloc(i64 30)
  %t1244 = bitcast i8* %t1243 to [30 x i8]*
  store [30 x i8] c"unused span metadata before: \00", [30 x i8]* %t1244
  %t1245 = load i8*, i8** %l13
  %t1246 = call i8* @sailfin_runtime_string_concat(i8* %t1243, i8* %t1245)
  %t1247 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1242, i8* %t1246)
  store { i8**, i64 }* %t1247, { i8**, i64 }** %l1
  %t1248 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1248, %NativeSourceSpan** %l9
  %t1249 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1250 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1251 = phi { i8**, i64 }* [ %t1249, %then94 ], [ %t1226, %else92 ]
  %t1252 = phi %NativeSourceSpan* [ %t1250, %then94 ], [ %t1234, %else92 ]
  store { i8**, i64 }* %t1251, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1252, %NativeSourceSpan** %l9
  %t1253 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1254 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1255 = phi %NativeSourceSpan* [ %t1222, %then91 ], [ %t1254, %merge95 ]
  %t1256 = phi { i8**, i64 }* [ %t1205, %then91 ], [ %t1253, %merge95 ]
  store %NativeSourceSpan* %t1255, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1256, { i8**, i64 }** %l1
  %t1257 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1258 = extractvalue %InstructionParseResult %t1257, 2
  %t1259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1261 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1262 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1263 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1264 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1265 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1266 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1267 = load %NativeFunction*, %NativeFunction** %l8
  %t1268 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1269 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1270 = load double, double* %l11
  %t1271 = load i8*, i8** %l12
  %t1272 = load i8*, i8** %l13
  %t1273 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1274 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1275 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1258, label %then96, label %else97
then96:
  %t1276 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1276, %NativeSourceSpan** %l10
  %t1277 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1278 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1279 = icmp ne %NativeSourceSpan* %t1278, null
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
  br i1 %t1279, label %then99, label %merge100
then99:
  %t1297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1298 = call i8* @malloc(i64 42)
  %t1299 = bitcast i8* %t1298 to [42 x i8]*
  store [42 x i8] c"unused initializer span metadata before: \00", [42 x i8]* %t1299
  %t1300 = load i8*, i8** %l13
  %t1301 = call i8* @sailfin_runtime_string_concat(i8* %t1298, i8* %t1300)
  %t1302 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1297, i8* %t1301)
  store { i8**, i64 }* %t1302, { i8**, i64 }** %l1
  %t1303 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1303, %NativeSourceSpan** %l10
  %t1304 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1305 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1306 = phi { i8**, i64 }* [ %t1304, %then99 ], [ %t1281, %else97 ]
  %t1307 = phi %NativeSourceSpan* [ %t1305, %then99 ], [ %t1290, %else97 ]
  store { i8**, i64 }* %t1306, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1307, %NativeSourceSpan** %l10
  %t1308 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1309 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1310 = phi %NativeSourceSpan* [ %t1277, %then96 ], [ %t1309, %merge100 ]
  %t1311 = phi { i8**, i64 }* [ %t1260, %then96 ], [ %t1308, %merge100 ]
  store %NativeSourceSpan* %t1310, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1311, { i8**, i64 }** %l1
  %t1312 = load %NativeFunction*, %NativeFunction** %l8
  %t1313 = icmp eq %NativeFunction* %t1312, null
  %t1314 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1316 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1317 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1318 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1319 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1320 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1321 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1322 = load %NativeFunction*, %NativeFunction** %l8
  %t1323 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1324 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1325 = load double, double* %l11
  %t1326 = load i8*, i8** %l12
  %t1327 = load i8*, i8** %l13
  %t1328 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1329 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1330 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1313, label %then101, label %merge102
then101:
  %t1332 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1333 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1332
  %t1334 = extractvalue { %NativeInstruction*, i64 } %t1333, 1
  %t1335 = icmp eq i64 %t1334, 1
  br label %logical_and_entry_1331

logical_and_entry_1331:
  br i1 %t1335, label %logical_and_right_1331, label %logical_and_merge_1331

logical_and_right_1331:
  %t1336 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1337 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1336
  %t1338 = extractvalue { %NativeInstruction*, i64 } %t1337, 0
  %t1339 = extractvalue { %NativeInstruction*, i64 } %t1337, 1
  %t1340 = icmp uge i64 0, %t1339
  ; bounds check: %t1340 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1339)
  %t1341 = getelementptr %NativeInstruction, %NativeInstruction* %t1338, i64 0
  %t1342 = load %NativeInstruction, %NativeInstruction* %t1341
  %t1343 = extractvalue %NativeInstruction %t1342, 0
  %t1344 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1345 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1346 = icmp eq i32 %t1343, 0
  %t1347 = select i1 %t1346, i8* %t1345, i8* %t1344
  %t1348 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1349 = icmp eq i32 %t1343, 1
  %t1350 = select i1 %t1349, i8* %t1348, i8* %t1347
  %t1351 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1352 = icmp eq i32 %t1343, 2
  %t1353 = select i1 %t1352, i8* %t1351, i8* %t1350
  %t1354 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1355 = icmp eq i32 %t1343, 3
  %t1356 = select i1 %t1355, i8* %t1354, i8* %t1353
  %t1357 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1358 = icmp eq i32 %t1343, 4
  %t1359 = select i1 %t1358, i8* %t1357, i8* %t1356
  %t1360 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1361 = icmp eq i32 %t1343, 5
  %t1362 = select i1 %t1361, i8* %t1360, i8* %t1359
  %t1363 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1364 = icmp eq i32 %t1343, 6
  %t1365 = select i1 %t1364, i8* %t1363, i8* %t1362
  %t1366 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1367 = icmp eq i32 %t1343, 7
  %t1368 = select i1 %t1367, i8* %t1366, i8* %t1365
  %t1369 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1370 = icmp eq i32 %t1343, 8
  %t1371 = select i1 %t1370, i8* %t1369, i8* %t1368
  %t1372 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1373 = icmp eq i32 %t1343, 9
  %t1374 = select i1 %t1373, i8* %t1372, i8* %t1371
  %t1375 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1376 = icmp eq i32 %t1343, 10
  %t1377 = select i1 %t1376, i8* %t1375, i8* %t1374
  %t1378 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1379 = icmp eq i32 %t1343, 11
  %t1380 = select i1 %t1379, i8* %t1378, i8* %t1377
  %t1381 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1382 = icmp eq i32 %t1343, 12
  %t1383 = select i1 %t1382, i8* %t1381, i8* %t1380
  %t1384 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1385 = icmp eq i32 %t1343, 13
  %t1386 = select i1 %t1385, i8* %t1384, i8* %t1383
  %t1387 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1388 = icmp eq i32 %t1343, 14
  %t1389 = select i1 %t1388, i8* %t1387, i8* %t1386
  %t1390 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1391 = icmp eq i32 %t1343, 15
  %t1392 = select i1 %t1391, i8* %t1390, i8* %t1389
  %t1393 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1394 = icmp eq i32 %t1343, 16
  %t1395 = select i1 %t1394, i8* %t1393, i8* %t1392
  %t1396 = call i8* @malloc(i64 4)
  %t1397 = bitcast i8* %t1396 to [4 x i8]*
  store [4 x i8] c"Let\00", [4 x i8]* %t1397
  %t1398 = call i1 @strings_equal(i8* %t1395, i8* %t1396)
  br label %logical_and_right_end_1331

logical_and_right_end_1331:
  br label %logical_and_merge_1331

logical_and_merge_1331:
  %t1399 = phi i1 [ false, %logical_and_entry_1331 ], [ %t1398, %logical_and_right_end_1331 ]
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
  %t1416 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1399, label %then103, label %else104
then103:
  %t1417 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1418 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1419 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1418
  %t1420 = extractvalue { %NativeInstruction*, i64 } %t1419, 0
  %t1421 = extractvalue { %NativeInstruction*, i64 } %t1419, 1
  %t1422 = icmp uge i64 0, %t1421
  ; bounds check: %t1422 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1421)
  %t1423 = getelementptr %NativeInstruction, %NativeInstruction* %t1420, i64 0
  %t1424 = load %NativeInstruction, %NativeInstruction* %t1423
  %t1425 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1424)
  %t1426 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1417, %NativeBinding %t1425)
  store { %NativeBinding*, i64 }* %t1426, { %NativeBinding*, i64 }** %l7
  %t1427 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1429 = call i8* @malloc(i64 48)
  %t1430 = bitcast i8* %t1429 to [48 x i8]*
  store [48 x i8] c"top-level directive not supported in lowering: \00", [48 x i8]* %t1430
  %t1431 = load i8*, i8** %l13
  %t1432 = call i8* @sailfin_runtime_string_concat(i8* %t1429, i8* %t1431)
  %t1433 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1428, i8* %t1432)
  store { i8**, i64 }* %t1433, { i8**, i64 }** %l1
  %t1434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1435 = phi { %NativeBinding*, i64 }* [ %t1427, %then103 ], [ %t1407, %else104 ]
  %t1436 = phi { i8**, i64 }* [ %t1401, %then103 ], [ %t1434, %else104 ]
  store { %NativeBinding*, i64 }* %t1435, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1436, { i8**, i64 }** %l1
  %t1437 = load double, double* %l11
  %t1438 = sitofp i64 1 to double
  %t1439 = fadd double %t1437, %t1438
  store double %t1439, double* %l11
  br label %loop.latch2
merge102:
  %t1440 = sitofp i64 0 to double
  store double %t1440, double* %l34
  %t1441 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1443 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1444 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1445 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1446 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1447 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1448 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1449 = load %NativeFunction*, %NativeFunction** %l8
  %t1450 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1451 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1452 = load double, double* %l11
  %t1453 = load i8*, i8** %l12
  %t1454 = load i8*, i8** %l13
  %t1455 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1456 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1457 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1458 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1505 = phi %NativeFunction* [ %t1449, %merge102 ], [ %t1503, %loop.latch108 ]
  %t1506 = phi double [ %t1458, %merge102 ], [ %t1504, %loop.latch108 ]
  store %NativeFunction* %t1505, %NativeFunction** %l8
  store double %t1506, double* %l34
  br label %loop.body107
loop.body107:
  %t1459 = load double, double* %l34
  %t1460 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1461 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1460
  %t1462 = extractvalue { %NativeInstruction*, i64 } %t1461, 1
  %t1463 = sitofp i64 %t1462 to double
  %t1464 = fcmp oge double %t1459, %t1463
  %t1465 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1467 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1468 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1469 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1470 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1471 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1472 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1473 = load %NativeFunction*, %NativeFunction** %l8
  %t1474 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1475 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1476 = load double, double* %l11
  %t1477 = load i8*, i8** %l12
  %t1478 = load i8*, i8** %l13
  %t1479 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1480 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1481 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1482 = load double, double* %l34
  br i1 %t1464, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1483 = load %NativeFunction*, %NativeFunction** %l8
  %t1484 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1485 = load double, double* %l34
  %t1486 = call double @llvm.round.f64(double %t1485)
  %t1487 = fptosi double %t1486 to i64
  %t1488 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1484
  %t1489 = extractvalue { %NativeInstruction*, i64 } %t1488, 0
  %t1490 = extractvalue { %NativeInstruction*, i64 } %t1488, 1
  %t1491 = icmp uge i64 %t1487, %t1490
  ; bounds check: %t1491 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1487, i64 %t1490)
  %t1492 = getelementptr %NativeInstruction, %NativeInstruction* %t1489, i64 %t1487
  %t1493 = load %NativeInstruction, %NativeInstruction* %t1492
  %t1494 = load %NativeFunction, %NativeFunction* %t1483
  %t1495 = call %NativeFunction @append_instruction(%NativeFunction %t1494, %NativeInstruction %t1493)
  %t1496 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t1497 = ptrtoint %NativeFunction* %t1496 to i64
  %t1498 = call noalias i8* @malloc(i64 %t1497)
  %t1499 = bitcast i8* %t1498 to %NativeFunction*
  store %NativeFunction %t1495, %NativeFunction* %t1499
  call void @sailfin_runtime_mark_persistent(i8* %t1498)
  store %NativeFunction* %t1499, %NativeFunction** %l8
  %t1500 = load double, double* %l34
  %t1501 = sitofp i64 1 to double
  %t1502 = fadd double %t1500, %t1501
  store double %t1502, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1503 = load %NativeFunction*, %NativeFunction** %l8
  %t1504 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1507 = load %NativeFunction*, %NativeFunction** %l8
  %t1508 = load double, double* %l34
  %t1509 = load double, double* %l11
  %t1510 = sitofp i64 1 to double
  %t1511 = fadd double %t1509, %t1510
  store double %t1511, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1512 = load double, double* %l11
  %t1513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1514 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1515 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1516 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1517 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1518 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1519 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1520 = load %NativeFunction*, %NativeFunction** %l8
  %t1521 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1522 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1534 = load double, double* %l11
  %t1535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1536 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1537 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1538 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1539 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1540 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1541 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1542 = load %NativeFunction*, %NativeFunction** %l8
  %t1543 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1544 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1545 = load %NativeFunction*, %NativeFunction** %l8
  %t1546 = icmp ne %NativeFunction* %t1545, null
  %t1547 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1548 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1549 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1550 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1551 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1552 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1553 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1554 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1555 = load %NativeFunction*, %NativeFunction** %l8
  %t1556 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1557 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1558 = load double, double* %l11
  br i1 %t1546, label %then112, label %merge113
then112:
  %t1559 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1560 = call i8* @malloc(i64 41)
  %t1561 = bitcast i8* %t1560 to [41 x i8]*
  store [41 x i8] c"unterminated function at end of artifact\00", [41 x i8]* %t1561
  %t1562 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1559, i8* %t1560)
  store { i8**, i64 }* %t1562, { i8**, i64 }** %l1
  %t1563 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1564 = phi { i8**, i64 }* [ %t1563, %then112 ], [ %t1548, %afterloop3 ]
  store { i8**, i64 }* %t1564, { i8**, i64 }** %l1
  %t1565 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1566 = insertvalue %ParseNativeResult undef, { %NativeFunction*, i64 }* %t1565, 0
  %t1567 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1568 = insertvalue %ParseNativeResult %t1566, { %NativeImport*, i64 }* %t1567, 1
  %t1569 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1570 = insertvalue %ParseNativeResult %t1568, { %NativeStruct*, i64 }* %t1569, 2
  %t1571 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1572 = insertvalue %ParseNativeResult %t1570, { %NativeInterface*, i64 }* %t1571, 3
  %t1573 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1574 = insertvalue %ParseNativeResult %t1572, { %NativeEnum*, i64 }* %t1573, 4
  %t1575 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1576 = insertvalue %ParseNativeResult %t1574, { %NativeBinding*, i64 }* %t1575, 5
  %t1577 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1578 = insertvalue %ParseNativeResult %t1576, { i8**, i64 }* %t1577, 6
  ret %ParseNativeResult %t1578
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
  %t2 = call i8* @malloc(i64 8)
  %t3 = bitcast i8* %t2 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t3
  %t4 = call i1 @starts_with(i8* %t1, i8* %t2)
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @malloc(i64 8)
  %t8 = bitcast i8* %t7 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t8
  %t9 = call i8* @strip_prefix(i8* %t6, i8* %t7)
  %t10 = call i8* @trim_text(i8* %t9)
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = extractvalue %NativeFunction %function, 3
  %t13 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t11, { i8**, i64 }* %t12)
  ret %NativeFunction %t13
merge1:
  %t14 = load i8*, i8** %l0
  %t15 = call i8* @malloc(i64 9)
  %t16 = bitcast i8* %t15 to [9 x i8]*
  store [9 x i8] c"effects \00", [9 x i8]* %t16
  %t17 = call i1 @starts_with(i8* %t14, i8* %t15)
  %t18 = load i8*, i8** %l0
  br i1 %t17, label %then2, label %merge3
then2:
  %t19 = load i8*, i8** %l0
  %t20 = call i8* @malloc(i64 9)
  %t21 = bitcast i8* %t20 to [9 x i8]*
  store [9 x i8] c"effects \00", [9 x i8]* %t21
  %t22 = call i8* @strip_prefix(i8* %t19, i8* %t20)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = call { i8**, i64 }* @parse_effect_list(i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l3
  %t26 = extractvalue %NativeFunction %function, 2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t26, { i8**, i64 }* %t27)
  ret %NativeFunction %t28
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
  %t4 = call i8* @malloc(i64 1)
  %t5 = bitcast i8* %t4 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t5
  %t6 = insertvalue %InstructionGatherResult undef, i8* %t4, 0
  %t7 = sitofp i64 0 to double
  %t8 = insertvalue %InstructionGatherResult %t6, double %t7, 1
  ret %InstructionGatherResult %t8
merge1:
  %t9 = call double @llvm.round.f64(double %start_index)
  %t10 = fptosi double %t9 to i64
  %t11 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i8* @trim_text(i8* %t16)
  store i8* %t17, i8** %l0
  %t18 = load i8*, i8** %l0
  %t19 = call i64 @sailfin_runtime_string_length(i8* %t18)
  %t20 = icmp eq i64 %t19, 0
  %t21 = load i8*, i8** %l0
  br i1 %t20, label %then2, label %merge3
then2:
  %t22 = load i8*, i8** %l0
  %t23 = insertvalue %InstructionGatherResult undef, i8* %t22, 0
  %t24 = sitofp i64 0 to double
  %t25 = insertvalue %InstructionGatherResult %t23, double %t24, 1
  ret %InstructionGatherResult %t25
merge3:
  %t26 = load i8*, i8** %l0
  %t27 = call i1 @instruction_supports_multiline(i8* %t26)
  %t28 = xor i1 %t27, 1
  %t29 = load i8*, i8** %l0
  br i1 %t28, label %then4, label %merge5
then4:
  %t30 = load i8*, i8** %l0
  %t31 = insertvalue %InstructionGatherResult undef, i8* %t30, 0
  %t32 = sitofp i64 0 to double
  %t33 = insertvalue %InstructionGatherResult %t31, double %t32, 1
  ret %InstructionGatherResult %t33
merge5:
  %t34 = call %InstructionDepthState @initial_instruction_depth_state()
  %t35 = load i8*, i8** %l0
  %t36 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t34, i8* %t35)
  store %InstructionDepthState %t36, %InstructionDepthState* %l1
  %t37 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t38 = call i1 @instruction_requires_continuation(%InstructionDepthState %t37)
  %t39 = xor i1 %t38, 1
  %t40 = load i8*, i8** %l0
  %t41 = load %InstructionDepthState, %InstructionDepthState* %l1
  br i1 %t39, label %then6, label %merge7
then6:
  %t42 = load i8*, i8** %l0
  %t43 = insertvalue %InstructionGatherResult undef, i8* %t42, 0
  %t44 = sitofp i64 0 to double
  %t45 = insertvalue %InstructionGatherResult %t43, double %t44, 1
  ret %InstructionGatherResult %t45
merge7:
  %t46 = load i8*, i8** %l0
  store i8* %t46, i8** %l2
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l3
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %start_index, %t48
  store double %t49, double* %l4
  %t50 = load i8*, i8** %l0
  %t51 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load double, double* %l3
  %t54 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t123 = phi i8* [ %t52, %merge7 ], [ %t119, %loop.latch10 ]
  %t124 = phi %InstructionDepthState [ %t51, %merge7 ], [ %t120, %loop.latch10 ]
  %t125 = phi double [ %t53, %merge7 ], [ %t121, %loop.latch10 ]
  %t126 = phi double [ %t54, %merge7 ], [ %t122, %loop.latch10 ]
  store i8* %t123, i8** %l2
  store %InstructionDepthState %t124, %InstructionDepthState* %l1
  store double %t125, double* %l3
  store double %t126, double* %l4
  br label %loop.body9
loop.body9:
  %t55 = load double, double* %l4
  %t56 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t57 = extractvalue { i8**, i64 } %t56, 1
  %t58 = sitofp i64 %t57 to double
  %t59 = fcmp oge double %t55, %t58
  %t60 = load i8*, i8** %l0
  %t61 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t62 = load i8*, i8** %l2
  %t63 = load double, double* %l3
  %t64 = load double, double* %l4
  br i1 %t59, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t65 = load double, double* %l4
  %t66 = call double @llvm.round.f64(double %t65)
  %t67 = fptosi double %t66 to i64
  %t68 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t69 = extractvalue { i8**, i64 } %t68, 0
  %t70 = extractvalue { i8**, i64 } %t68, 1
  %t71 = icmp uge i64 %t67, %t70
  ; bounds check: %t71 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t67, i64 %t70)
  %t72 = getelementptr i8*, i8** %t69, i64 %t67
  %t73 = load i8*, i8** %t72
  %t74 = call i8* @trim_text(i8* %t73)
  store i8* %t74, i8** %l5
  %t75 = load i8*, i8** %l5
  %t76 = call i64 @sailfin_runtime_string_length(i8* %t75)
  %t77 = icmp eq i64 %t76, 0
  %t78 = load i8*, i8** %l0
  %t79 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t80 = load i8*, i8** %l2
  %t81 = load double, double* %l3
  %t82 = load double, double* %l4
  %t83 = load i8*, i8** %l5
  br i1 %t77, label %then14, label %else15
then14:
  %t84 = load i8*, i8** %l2
  %t85 = add i64 0, 2
  %t86 = call i8* @malloc(i64 %t85)
  store i8 10, i8* %t86
  %t87 = getelementptr i8, i8* %t86, i64 1
  store i8 0, i8* %t87
  call void @sailfin_runtime_mark_persistent(i8* %t86)
  %t88 = call i8* @sailfin_runtime_string_concat(i8* %t84, i8* %t86)
  store i8* %t88, i8** %l2
  %t89 = load i8*, i8** %l2
  br label %merge16
else15:
  %t90 = load i8*, i8** %l2
  %t91 = add i64 0, 2
  %t92 = call i8* @malloc(i64 %t91)
  store i8 10, i8* %t92
  %t93 = getelementptr i8, i8* %t92, i64 1
  store i8 0, i8* %t93
  call void @sailfin_runtime_mark_persistent(i8* %t92)
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t90, i8* %t92)
  %t95 = load i8*, i8** %l5
  %t96 = call i8* @sailfin_runtime_string_concat(i8* %t94, i8* %t95)
  store i8* %t96, i8** %l2
  %t97 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t98 = load i8*, i8** %l5
  %t99 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t97, i8* %t98)
  store %InstructionDepthState %t99, %InstructionDepthState* %l1
  %t100 = load i8*, i8** %l2
  %t101 = load %InstructionDepthState, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t102 = phi i8* [ %t89, %then14 ], [ %t100, %else15 ]
  %t103 = phi %InstructionDepthState [ %t79, %then14 ], [ %t101, %else15 ]
  store i8* %t102, i8** %l2
  store %InstructionDepthState %t103, %InstructionDepthState* %l1
  %t104 = load double, double* %l3
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l3
  %t107 = load double, double* %l4
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  store double %t109, double* %l4
  %t110 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t111 = call i1 @instruction_requires_continuation(%InstructionDepthState %t110)
  %t112 = xor i1 %t111, 1
  %t113 = load i8*, i8** %l0
  %t114 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t115 = load i8*, i8** %l2
  %t116 = load double, double* %l3
  %t117 = load double, double* %l4
  %t118 = load i8*, i8** %l5
  br i1 %t112, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t119 = load i8*, i8** %l2
  %t120 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t121 = load double, double* %l3
  %t122 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t127 = load i8*, i8** %l2
  %t128 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t129 = load double, double* %l3
  %t130 = load double, double* %l4
  %t131 = load i8*, i8** %l2
  %t132 = call i8* @trim_text(i8* %t131)
  store i8* %t132, i8** %l6
  %t133 = load i8*, i8** %l6
  %t134 = insertvalue %InstructionGatherResult undef, i8* %t133, 0
  %t135 = load double, double* %l3
  %t136 = insertvalue %InstructionGatherResult %t134, double %t135, 1
  ret %InstructionGatherResult %t136
}

define i1 @instruction_supports_multiline(i8* %line) {
block.entry:
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c"eval \00", [6 x i8]* %t1
  %t2 = call i1 @starts_with(i8* %line, i8* %t0)
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t3 = call i8* @malloc(i64 5)
  %t4 = bitcast i8* %t3 to [5 x i8]*
  store [5 x i8] c"ret \00", [5 x i8]* %t4
  %t5 = call i1 @starts_with(i8* %line, i8* %t3)
  br i1 %t5, label %then2, label %merge3
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
  %t0 = call i8* @malloc(i64 5)
  %t1 = bitcast i8* %t0 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t1
  %t2 = call i1 @strings_equal(i8* %line, i8* %t0)
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = insertvalue %NativeInstruction undef, i32 15, 0
  %t4 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t5 = ptrtoint [1 x %NativeInstruction]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to %NativeInstruction*
  %t10 = getelementptr %NativeInstruction, %NativeInstruction* %t9, i64 0
  store %NativeInstruction %t3, %NativeInstruction* %t10
  %t11 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t12 = ptrtoint { %NativeInstruction*, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { %NativeInstruction*, i64 }*
  %t15 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t14, i32 0, i32 0
  store %NativeInstruction* %t9, %NativeInstruction** %t15
  %t16 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t14, i32 0, i32 1
  store i64 1, i64* %t16
  %t17 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t14, 0
  %t18 = insertvalue %InstructionParseResult %t17, i1 0, 1
  %t19 = insertvalue %InstructionParseResult %t18, i1 0, 2
  ret %InstructionParseResult %t19
merge1:
  %t20 = call i8* @malloc(i64 5)
  %t21 = bitcast i8* %t20 to [5 x i8]*
  store [5 x i8] c".if \00", [5 x i8]* %t21
  %t22 = call i1 @starts_with(i8* %line, i8* %t20)
  br i1 %t22, label %then2, label %merge3
then2:
  %t23 = call i8* @malloc(i64 5)
  %t24 = bitcast i8* %t23 to [5 x i8]*
  store [5 x i8] c".if \00", [5 x i8]* %t24
  %t25 = call i8* @strip_prefix(i8* %line, i8* %t23)
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
  %t47 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t44, 0
  %t48 = insertvalue %InstructionParseResult %t47, i1 0, 1
  %t49 = insertvalue %InstructionParseResult %t48, i1 0, 2
  ret %InstructionParseResult %t49
merge3:
  %t50 = call i8* @malloc(i64 6)
  %t51 = bitcast i8* %t50 to [6 x i8]*
  store [6 x i8] c".else\00", [6 x i8]* %t51
  %t52 = call i1 @strings_equal(i8* %line, i8* %t50)
  br i1 %t52, label %then4, label %merge5
then4:
  %t53 = insertvalue %NativeInstruction undef, i32 4, 0
  %t54 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t55 = ptrtoint [1 x %NativeInstruction]* %t54 to i64
  %t56 = icmp eq i64 %t55, 0
  %t57 = select i1 %t56, i64 1, i64 %t55
  %t58 = call i8* @malloc(i64 %t57)
  %t59 = bitcast i8* %t58 to %NativeInstruction*
  %t60 = getelementptr %NativeInstruction, %NativeInstruction* %t59, i64 0
  store %NativeInstruction %t53, %NativeInstruction* %t60
  %t61 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t62 = ptrtoint { %NativeInstruction*, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { %NativeInstruction*, i64 }*
  %t65 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t64, i32 0, i32 0
  store %NativeInstruction* %t59, %NativeInstruction** %t65
  %t66 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t64, i32 0, i32 1
  store i64 1, i64* %t66
  %t67 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t64, 0
  %t68 = insertvalue %InstructionParseResult %t67, i1 0, 1
  %t69 = insertvalue %InstructionParseResult %t68, i1 0, 2
  ret %InstructionParseResult %t69
merge5:
  %t70 = call i8* @malloc(i64 7)
  %t71 = bitcast i8* %t70 to [7 x i8]*
  store [7 x i8] c".endif\00", [7 x i8]* %t71
  %t72 = call i1 @strings_equal(i8* %line, i8* %t70)
  br i1 %t72, label %then6, label %merge7
then6:
  %t73 = insertvalue %NativeInstruction undef, i32 5, 0
  %t74 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t75 = ptrtoint [1 x %NativeInstruction]* %t74 to i64
  %t76 = icmp eq i64 %t75, 0
  %t77 = select i1 %t76, i64 1, i64 %t75
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to %NativeInstruction*
  %t80 = getelementptr %NativeInstruction, %NativeInstruction* %t79, i64 0
  store %NativeInstruction %t73, %NativeInstruction* %t80
  %t81 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t82 = ptrtoint { %NativeInstruction*, i64 }* %t81 to i64
  %t83 = call i8* @malloc(i64 %t82)
  %t84 = bitcast i8* %t83 to { %NativeInstruction*, i64 }*
  %t85 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t84, i32 0, i32 0
  store %NativeInstruction* %t79, %NativeInstruction** %t85
  %t86 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t84, i32 0, i32 1
  store i64 1, i64* %t86
  %t87 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t84, 0
  %t88 = insertvalue %InstructionParseResult %t87, i1 0, 1
  %t89 = insertvalue %InstructionParseResult %t88, i1 0, 2
  ret %InstructionParseResult %t89
merge7:
  %t90 = call i8* @malloc(i64 6)
  %t91 = bitcast i8* %t90 to [6 x i8]*
  store [6 x i8] c".for \00", [6 x i8]* %t91
  %t92 = call i1 @starts_with(i8* %line, i8* %t90)
  br i1 %t92, label %then8, label %merge9
then8:
  %t93 = call i8* @malloc(i64 6)
  %t94 = bitcast i8* %t93 to [6 x i8]*
  store [6 x i8] c".for \00", [6 x i8]* %t94
  %t95 = call i8* @strip_prefix(i8* %line, i8* %t93)
  %t96 = call i8* @trim_text(i8* %t95)
  store i8* %t96, i8** %l1
  %t97 = call i8* @malloc(i64 5)
  %t98 = bitcast i8* %t97 to [5 x i8]*
  store [5 x i8] c" in \00", [5 x i8]* %t98
  store i8* %t97, i8** %l2
  %t99 = load i8*, i8** %l1
  %t100 = load i8*, i8** %l2
  %t101 = call double @index_of(i8* %t99, i8* %t100)
  store double %t101, double* %l3
  %t102 = load double, double* %l3
  %t103 = sitofp i64 0 to double
  %t104 = fcmp oge double %t102, %t103
  %t105 = load i8*, i8** %l1
  %t106 = load i8*, i8** %l2
  %t107 = load double, double* %l3
  br i1 %t104, label %then10, label %merge11
then10:
  %t108 = load i8*, i8** %l1
  %t109 = load double, double* %l3
  %t110 = call double @llvm.round.f64(double %t109)
  %t111 = fptosi double %t110 to i64
  %t112 = call i8* @sailfin_runtime_substring(i8* %t108, i64 0, i64 %t111)
  %t113 = call i8* @trim_text(i8* %t112)
  store i8* %t113, i8** %l4
  %t114 = load i8*, i8** %l1
  %t115 = load double, double* %l3
  %t116 = load i8*, i8** %l2
  %t117 = call i64 @sailfin_runtime_string_length(i8* %t116)
  %t118 = sitofp i64 %t117 to double
  %t119 = fadd double %t115, %t118
  %t120 = load i8*, i8** %l1
  %t121 = call i64 @sailfin_runtime_string_length(i8* %t120)
  %t122 = call double @llvm.round.f64(double %t119)
  %t123 = fptosi double %t122 to i64
  %t124 = call i8* @sailfin_runtime_substring(i8* %t114, i64 %t123, i64 %t121)
  %t125 = call i8* @trim_text(i8* %t124)
  store i8* %t125, i8** %l5
  %t126 = alloca %NativeInstruction
  %t127 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t126, i32 0, i32 0
  store i32 6, i32* %t127
  %t128 = load i8*, i8** %l4
  %t129 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t126, i32 0, i32 1
  %t130 = bitcast [16 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  store i8* %t128, i8** %t131
  %t132 = load i8*, i8** %l5
  %t133 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t126, i32 0, i32 1
  %t134 = bitcast [16 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 8
  %t136 = bitcast i8* %t135 to i8**
  store i8* %t132, i8** %t136
  %t137 = load %NativeInstruction, %NativeInstruction* %t126
  %t138 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t139 = ptrtoint [1 x %NativeInstruction]* %t138 to i64
  %t140 = icmp eq i64 %t139, 0
  %t141 = select i1 %t140, i64 1, i64 %t139
  %t142 = call i8* @malloc(i64 %t141)
  %t143 = bitcast i8* %t142 to %NativeInstruction*
  %t144 = getelementptr %NativeInstruction, %NativeInstruction* %t143, i64 0
  store %NativeInstruction %t137, %NativeInstruction* %t144
  %t145 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t146 = ptrtoint { %NativeInstruction*, i64 }* %t145 to i64
  %t147 = call i8* @malloc(i64 %t146)
  %t148 = bitcast i8* %t147 to { %NativeInstruction*, i64 }*
  %t149 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t148, i32 0, i32 0
  store %NativeInstruction* %t143, %NativeInstruction** %t149
  %t150 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t148, i32 0, i32 1
  store i64 1, i64* %t150
  %t151 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t148, 0
  %t152 = insertvalue %InstructionParseResult %t151, i1 0, 1
  %t153 = insertvalue %InstructionParseResult %t152, i1 0, 2
  ret %InstructionParseResult %t153
merge11:
  br label %merge9
merge9:
  %t154 = call i8* @malloc(i64 8)
  %t155 = bitcast i8* %t154 to [8 x i8]*
  store [8 x i8] c".endfor\00", [8 x i8]* %t155
  %t156 = call i1 @strings_equal(i8* %line, i8* %t154)
  br i1 %t156, label %then12, label %merge13
then12:
  %t157 = insertvalue %NativeInstruction undef, i32 7, 0
  %t158 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t159 = ptrtoint [1 x %NativeInstruction]* %t158 to i64
  %t160 = icmp eq i64 %t159, 0
  %t161 = select i1 %t160, i64 1, i64 %t159
  %t162 = call i8* @malloc(i64 %t161)
  %t163 = bitcast i8* %t162 to %NativeInstruction*
  %t164 = getelementptr %NativeInstruction, %NativeInstruction* %t163, i64 0
  store %NativeInstruction %t157, %NativeInstruction* %t164
  %t165 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t166 = ptrtoint { %NativeInstruction*, i64 }* %t165 to i64
  %t167 = call i8* @malloc(i64 %t166)
  %t168 = bitcast i8* %t167 to { %NativeInstruction*, i64 }*
  %t169 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t168, i32 0, i32 0
  store %NativeInstruction* %t163, %NativeInstruction** %t169
  %t170 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t168, i32 0, i32 1
  store i64 1, i64* %t170
  %t171 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t168, 0
  %t172 = insertvalue %InstructionParseResult %t171, i1 0, 1
  %t173 = insertvalue %InstructionParseResult %t172, i1 0, 2
  ret %InstructionParseResult %t173
merge13:
  %t174 = call i8* @malloc(i64 6)
  %t175 = bitcast i8* %t174 to [6 x i8]*
  store [6 x i8] c".loop\00", [6 x i8]* %t175
  %t176 = call i1 @strings_equal(i8* %line, i8* %t174)
  br i1 %t176, label %then14, label %merge15
then14:
  %t177 = insertvalue %NativeInstruction undef, i32 8, 0
  %t178 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t179 = ptrtoint [1 x %NativeInstruction]* %t178 to i64
  %t180 = icmp eq i64 %t179, 0
  %t181 = select i1 %t180, i64 1, i64 %t179
  %t182 = call i8* @malloc(i64 %t181)
  %t183 = bitcast i8* %t182 to %NativeInstruction*
  %t184 = getelementptr %NativeInstruction, %NativeInstruction* %t183, i64 0
  store %NativeInstruction %t177, %NativeInstruction* %t184
  %t185 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t186 = ptrtoint { %NativeInstruction*, i64 }* %t185 to i64
  %t187 = call i8* @malloc(i64 %t186)
  %t188 = bitcast i8* %t187 to { %NativeInstruction*, i64 }*
  %t189 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t188, i32 0, i32 0
  store %NativeInstruction* %t183, %NativeInstruction** %t189
  %t190 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t188, i32 0, i32 1
  store i64 1, i64* %t190
  %t191 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t188, 0
  %t192 = insertvalue %InstructionParseResult %t191, i1 0, 1
  %t193 = insertvalue %InstructionParseResult %t192, i1 0, 2
  ret %InstructionParseResult %t193
merge15:
  %t194 = call i8* @malloc(i64 9)
  %t195 = bitcast i8* %t194 to [9 x i8]*
  store [9 x i8] c".endloop\00", [9 x i8]* %t195
  %t196 = call i1 @strings_equal(i8* %line, i8* %t194)
  br i1 %t196, label %then16, label %merge17
then16:
  %t197 = insertvalue %NativeInstruction undef, i32 9, 0
  %t198 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t199 = ptrtoint [1 x %NativeInstruction]* %t198 to i64
  %t200 = icmp eq i64 %t199, 0
  %t201 = select i1 %t200, i64 1, i64 %t199
  %t202 = call i8* @malloc(i64 %t201)
  %t203 = bitcast i8* %t202 to %NativeInstruction*
  %t204 = getelementptr %NativeInstruction, %NativeInstruction* %t203, i64 0
  store %NativeInstruction %t197, %NativeInstruction* %t204
  %t205 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t206 = ptrtoint { %NativeInstruction*, i64 }* %t205 to i64
  %t207 = call i8* @malloc(i64 %t206)
  %t208 = bitcast i8* %t207 to { %NativeInstruction*, i64 }*
  %t209 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t208, i32 0, i32 0
  store %NativeInstruction* %t203, %NativeInstruction** %t209
  %t210 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t208, i32 0, i32 1
  store i64 1, i64* %t210
  %t211 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t208, 0
  %t212 = insertvalue %InstructionParseResult %t211, i1 0, 1
  %t213 = insertvalue %InstructionParseResult %t212, i1 0, 2
  ret %InstructionParseResult %t213
merge17:
  %t214 = call i8* @malloc(i64 6)
  %t215 = bitcast i8* %t214 to [6 x i8]*
  store [6 x i8] c"break\00", [6 x i8]* %t215
  %t216 = call i1 @strings_equal(i8* %line, i8* %t214)
  br i1 %t216, label %then18, label %merge19
then18:
  %t217 = insertvalue %NativeInstruction undef, i32 10, 0
  %t218 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t219 = ptrtoint [1 x %NativeInstruction]* %t218 to i64
  %t220 = icmp eq i64 %t219, 0
  %t221 = select i1 %t220, i64 1, i64 %t219
  %t222 = call i8* @malloc(i64 %t221)
  %t223 = bitcast i8* %t222 to %NativeInstruction*
  %t224 = getelementptr %NativeInstruction, %NativeInstruction* %t223, i64 0
  store %NativeInstruction %t217, %NativeInstruction* %t224
  %t225 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t226 = ptrtoint { %NativeInstruction*, i64 }* %t225 to i64
  %t227 = call i8* @malloc(i64 %t226)
  %t228 = bitcast i8* %t227 to { %NativeInstruction*, i64 }*
  %t229 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t228, i32 0, i32 0
  store %NativeInstruction* %t223, %NativeInstruction** %t229
  %t230 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t228, i32 0, i32 1
  store i64 1, i64* %t230
  %t231 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t228, 0
  %t232 = insertvalue %InstructionParseResult %t231, i1 0, 1
  %t233 = insertvalue %InstructionParseResult %t232, i1 0, 2
  ret %InstructionParseResult %t233
merge19:
  %t234 = call i8* @malloc(i64 9)
  %t235 = bitcast i8* %t234 to [9 x i8]*
  store [9 x i8] c"continue\00", [9 x i8]* %t235
  %t236 = call i1 @strings_equal(i8* %line, i8* %t234)
  br i1 %t236, label %then20, label %merge21
then20:
  %t237 = insertvalue %NativeInstruction undef, i32 11, 0
  %t238 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t239 = ptrtoint [1 x %NativeInstruction]* %t238 to i64
  %t240 = icmp eq i64 %t239, 0
  %t241 = select i1 %t240, i64 1, i64 %t239
  %t242 = call i8* @malloc(i64 %t241)
  %t243 = bitcast i8* %t242 to %NativeInstruction*
  %t244 = getelementptr %NativeInstruction, %NativeInstruction* %t243, i64 0
  store %NativeInstruction %t237, %NativeInstruction* %t244
  %t245 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t246 = ptrtoint { %NativeInstruction*, i64 }* %t245 to i64
  %t247 = call i8* @malloc(i64 %t246)
  %t248 = bitcast i8* %t247 to { %NativeInstruction*, i64 }*
  %t249 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t248, i32 0, i32 0
  store %NativeInstruction* %t243, %NativeInstruction** %t249
  %t250 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t248, i32 0, i32 1
  store i64 1, i64* %t250
  %t251 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t248, 0
  %t252 = insertvalue %InstructionParseResult %t251, i1 0, 1
  %t253 = insertvalue %InstructionParseResult %t252, i1 0, 2
  ret %InstructionParseResult %t253
merge21:
  %t254 = call i8* @malloc(i64 8)
  %t255 = bitcast i8* %t254 to [8 x i8]*
  store [8 x i8] c".match \00", [8 x i8]* %t255
  %t256 = call i1 @starts_with(i8* %line, i8* %t254)
  br i1 %t256, label %then22, label %merge23
then22:
  %t257 = call i8* @malloc(i64 8)
  %t258 = bitcast i8* %t257 to [8 x i8]*
  store [8 x i8] c".match \00", [8 x i8]* %t258
  %t259 = call i8* @strip_prefix(i8* %line, i8* %t257)
  %t260 = call i8* @trim_text(i8* %t259)
  store i8* %t260, i8** %l6
  %t261 = alloca %NativeInstruction
  %t262 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t261, i32 0, i32 0
  store i32 12, i32* %t262
  %t263 = load i8*, i8** %l6
  %t264 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t261, i32 0, i32 1
  %t265 = bitcast [8 x i8]* %t264 to i8*
  %t266 = bitcast i8* %t265 to i8**
  store i8* %t263, i8** %t266
  %t267 = load %NativeInstruction, %NativeInstruction* %t261
  %t268 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t269 = ptrtoint [1 x %NativeInstruction]* %t268 to i64
  %t270 = icmp eq i64 %t269, 0
  %t271 = select i1 %t270, i64 1, i64 %t269
  %t272 = call i8* @malloc(i64 %t271)
  %t273 = bitcast i8* %t272 to %NativeInstruction*
  %t274 = getelementptr %NativeInstruction, %NativeInstruction* %t273, i64 0
  store %NativeInstruction %t267, %NativeInstruction* %t274
  %t275 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t276 = ptrtoint { %NativeInstruction*, i64 }* %t275 to i64
  %t277 = call i8* @malloc(i64 %t276)
  %t278 = bitcast i8* %t277 to { %NativeInstruction*, i64 }*
  %t279 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t278, i32 0, i32 0
  store %NativeInstruction* %t273, %NativeInstruction** %t279
  %t280 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t278, i32 0, i32 1
  store i64 1, i64* %t280
  %t281 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t278, 0
  %t282 = insertvalue %InstructionParseResult %t281, i1 0, 1
  %t283 = insertvalue %InstructionParseResult %t282, i1 0, 2
  ret %InstructionParseResult %t283
merge23:
  %t284 = call i8* @malloc(i64 7)
  %t285 = bitcast i8* %t284 to [7 x i8]*
  store [7 x i8] c".case \00", [7 x i8]* %t285
  %t286 = call i1 @starts_with(i8* %line, i8* %t284)
  br i1 %t286, label %then24, label %merge25
then24:
  %t287 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t288 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t289 = ptrtoint [1 x %NativeInstruction]* %t288 to i64
  %t290 = icmp eq i64 %t289, 0
  %t291 = select i1 %t290, i64 1, i64 %t289
  %t292 = call i8* @malloc(i64 %t291)
  %t293 = bitcast i8* %t292 to %NativeInstruction*
  %t294 = getelementptr %NativeInstruction, %NativeInstruction* %t293, i64 0
  store %NativeInstruction %t287, %NativeInstruction* %t294
  %t295 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t296 = ptrtoint { %NativeInstruction*, i64 }* %t295 to i64
  %t297 = call i8* @malloc(i64 %t296)
  %t298 = bitcast i8* %t297 to { %NativeInstruction*, i64 }*
  %t299 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t298, i32 0, i32 0
  store %NativeInstruction* %t293, %NativeInstruction** %t299
  %t300 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t298, i32 0, i32 1
  store i64 1, i64* %t300
  %t301 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t298, 0
  %t302 = insertvalue %InstructionParseResult %t301, i1 0, 1
  %t303 = insertvalue %InstructionParseResult %t302, i1 0, 2
  ret %InstructionParseResult %t303
merge25:
  %t304 = call i8* @malloc(i64 10)
  %t305 = bitcast i8* %t304 to [10 x i8]*
  store [10 x i8] c".endmatch\00", [10 x i8]* %t305
  %t306 = call i1 @strings_equal(i8* %line, i8* %t304)
  br i1 %t306, label %then26, label %merge27
then26:
  %t307 = insertvalue %NativeInstruction undef, i32 14, 0
  %t308 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t309 = ptrtoint [1 x %NativeInstruction]* %t308 to i64
  %t310 = icmp eq i64 %t309, 0
  %t311 = select i1 %t310, i64 1, i64 %t309
  %t312 = call i8* @malloc(i64 %t311)
  %t313 = bitcast i8* %t312 to %NativeInstruction*
  %t314 = getelementptr %NativeInstruction, %NativeInstruction* %t313, i64 0
  store %NativeInstruction %t307, %NativeInstruction* %t314
  %t315 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t316 = ptrtoint { %NativeInstruction*, i64 }* %t315 to i64
  %t317 = call i8* @malloc(i64 %t316)
  %t318 = bitcast i8* %t317 to { %NativeInstruction*, i64 }*
  %t319 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t318, i32 0, i32 0
  store %NativeInstruction* %t313, %NativeInstruction** %t319
  %t320 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t318, i32 0, i32 1
  store i64 1, i64* %t320
  %t321 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t318, 0
  %t322 = insertvalue %InstructionParseResult %t321, i1 0, 1
  %t323 = insertvalue %InstructionParseResult %t322, i1 0, 2
  ret %InstructionParseResult %t323
merge27:
  %t324 = call i8* @malloc(i64 6)
  %t325 = bitcast i8* %t324 to [6 x i8]*
  store [6 x i8] c".let \00", [6 x i8]* %t325
  %t326 = call i1 @starts_with(i8* %line, i8* %t324)
  br i1 %t326, label %then28, label %merge29
then28:
  %t327 = call %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span)
  %t328 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t329 = ptrtoint [1 x %NativeInstruction]* %t328 to i64
  %t330 = icmp eq i64 %t329, 0
  %t331 = select i1 %t330, i64 1, i64 %t329
  %t332 = call i8* @malloc(i64 %t331)
  %t333 = bitcast i8* %t332 to %NativeInstruction*
  %t334 = getelementptr %NativeInstruction, %NativeInstruction* %t333, i64 0
  store %NativeInstruction %t327, %NativeInstruction* %t334
  %t335 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t336 = ptrtoint { %NativeInstruction*, i64 }* %t335 to i64
  %t337 = call i8* @malloc(i64 %t336)
  %t338 = bitcast i8* %t337 to { %NativeInstruction*, i64 }*
  %t339 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t338, i32 0, i32 0
  store %NativeInstruction* %t333, %NativeInstruction** %t339
  %t340 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t338, i32 0, i32 1
  store i64 1, i64* %t340
  %t341 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t338, 0
  %t342 = insertvalue %InstructionParseResult %t341, i1 1, 1
  %t343 = insertvalue %InstructionParseResult %t342, i1 1, 2
  ret %InstructionParseResult %t343
merge29:
  %t344 = call i8* @malloc(i64 8)
  %t345 = bitcast i8* %t344 to [8 x i8]*
  store [8 x i8] c".return\00", [8 x i8]* %t345
  %t346 = call i1 @starts_with(i8* %line, i8* %t344)
  br i1 %t346, label %then30, label %merge31
then30:
  %t347 = call i8* @malloc(i64 8)
  %t348 = bitcast i8* %t347 to [8 x i8]*
  store [8 x i8] c".return\00", [8 x i8]* %t348
  %t349 = call i8* @strip_prefix(i8* %line, i8* %t347)
  %t350 = call i8* @trim_text(i8* %t349)
  store i8* %t350, i8** %l7
  %t351 = call i8* @malloc(i64 1)
  %t352 = bitcast i8* %t351 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t352
  store i8* %t351, i8** %l8
  %t353 = load i8*, i8** %l7
  %t354 = call i64 @sailfin_runtime_string_length(i8* %t353)
  %t355 = icmp sgt i64 %t354, 0
  %t356 = load i8*, i8** %l7
  %t357 = load i8*, i8** %l8
  br i1 %t355, label %then32, label %merge33
then32:
  %t358 = load i8*, i8** %l7
  %t359 = call i8* @trim_trailing_delimiters(i8* %t358)
  store i8* %t359, i8** %l8
  %t360 = load i8*, i8** %l8
  br label %merge33
merge33:
  %t361 = phi i8* [ %t360, %then32 ], [ %t357, %then30 ]
  store i8* %t361, i8** %l8
  %t362 = alloca %NativeInstruction
  %t363 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t362, i32 0, i32 0
  store i32 0, i32* %t363
  %t364 = load i8*, i8** %l8
  %t365 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t362, i32 0, i32 1
  %t366 = bitcast [16 x i8]* %t365 to i8*
  %t367 = bitcast i8* %t366 to i8**
  store i8* %t364, i8** %t367
  %t368 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t362, i32 0, i32 1
  %t369 = bitcast [16 x i8]* %t368 to i8*
  %t370 = getelementptr inbounds i8, i8* %t369, i64 8
  %t371 = bitcast i8* %t370 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t371
  %t372 = load %NativeInstruction, %NativeInstruction* %t362
  %t373 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t374 = ptrtoint [1 x %NativeInstruction]* %t373 to i64
  %t375 = icmp eq i64 %t374, 0
  %t376 = select i1 %t375, i64 1, i64 %t374
  %t377 = call i8* @malloc(i64 %t376)
  %t378 = bitcast i8* %t377 to %NativeInstruction*
  %t379 = getelementptr %NativeInstruction, %NativeInstruction* %t378, i64 0
  store %NativeInstruction %t372, %NativeInstruction* %t379
  %t380 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t381 = ptrtoint { %NativeInstruction*, i64 }* %t380 to i64
  %t382 = call i8* @malloc(i64 %t381)
  %t383 = bitcast i8* %t382 to { %NativeInstruction*, i64 }*
  %t384 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t383, i32 0, i32 0
  store %NativeInstruction* %t378, %NativeInstruction** %t384
  %t385 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t383, i32 0, i32 1
  store i64 1, i64* %t385
  %t386 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t383, 0
  %t387 = insertvalue %InstructionParseResult %t386, i1 1, 1
  %t388 = insertvalue %InstructionParseResult %t387, i1 0, 2
  ret %InstructionParseResult %t388
merge31:
  %t389 = call i8* @malloc(i64 4)
  %t390 = bitcast i8* %t389 to [4 x i8]*
  store [4 x i8] c"ret\00", [4 x i8]* %t390
  %t391 = call i1 @starts_with(i8* %line, i8* %t389)
  br i1 %t391, label %then34, label %merge35
then34:
  %t392 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t393 = icmp eq i64 %t392, 3
  br i1 %t393, label %then36, label %merge37
then36:
  %t394 = alloca %NativeInstruction
  %t395 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t394, i32 0, i32 0
  store i32 0, i32* %t395
  %t396 = call i8* @malloc(i64 1)
  %t397 = bitcast i8* %t396 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t397
  %t398 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t394, i32 0, i32 1
  %t399 = bitcast [16 x i8]* %t398 to i8*
  %t400 = bitcast i8* %t399 to i8**
  store i8* %t396, i8** %t400
  %t401 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t394, i32 0, i32 1
  %t402 = bitcast [16 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 8
  %t404 = bitcast i8* %t403 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t404
  %t405 = load %NativeInstruction, %NativeInstruction* %t394
  %t406 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t407 = ptrtoint [1 x %NativeInstruction]* %t406 to i64
  %t408 = icmp eq i64 %t407, 0
  %t409 = select i1 %t408, i64 1, i64 %t407
  %t410 = call i8* @malloc(i64 %t409)
  %t411 = bitcast i8* %t410 to %NativeInstruction*
  %t412 = getelementptr %NativeInstruction, %NativeInstruction* %t411, i64 0
  store %NativeInstruction %t405, %NativeInstruction* %t412
  %t413 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t414 = ptrtoint { %NativeInstruction*, i64 }* %t413 to i64
  %t415 = call i8* @malloc(i64 %t414)
  %t416 = bitcast i8* %t415 to { %NativeInstruction*, i64 }*
  %t417 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t416, i32 0, i32 0
  store %NativeInstruction* %t411, %NativeInstruction** %t417
  %t418 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t416, i32 0, i32 1
  store i64 1, i64* %t418
  %t419 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t416, 0
  %t420 = insertvalue %InstructionParseResult %t419, i1 1, 1
  %t421 = insertvalue %InstructionParseResult %t420, i1 0, 2
  ret %InstructionParseResult %t421
merge37:
  %t422 = getelementptr i8, i8* %line, i64 3
  %t423 = load i8, i8* %t422
  store i8 %t423, i8* %l9
  %t425 = load i8, i8* %l9
  %t426 = icmp eq i8 %t425, 32
  br label %logical_or_entry_424

logical_or_entry_424:
  br i1 %t426, label %logical_or_merge_424, label %logical_or_right_424

logical_or_right_424:
  %t427 = load i8, i8* %l9
  %t428 = icmp eq i8 %t427, 9
  br label %logical_or_right_end_424

logical_or_right_end_424:
  br label %logical_or_merge_424

logical_or_merge_424:
  %t429 = phi i1 [ true, %logical_or_entry_424 ], [ %t428, %logical_or_right_end_424 ]
  %t430 = load i8, i8* %l9
  br i1 %t429, label %then38, label %merge39
then38:
  %t431 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t432 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t431)
  %t433 = call i8* @trim_text(i8* %t432)
  store i8* %t433, i8** %l10
  %t434 = load i8*, i8** %l10
  %t435 = call i64 @sailfin_runtime_string_length(i8* %t434)
  %t436 = icmp eq i64 %t435, 0
  %t437 = load i8, i8* %l9
  %t438 = load i8*, i8** %l10
  br i1 %t436, label %then40, label %merge41
then40:
  %t439 = alloca %NativeInstruction
  %t440 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t439, i32 0, i32 0
  store i32 0, i32* %t440
  %t441 = call i8* @malloc(i64 1)
  %t442 = bitcast i8* %t441 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t442
  %t443 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t439, i32 0, i32 1
  %t444 = bitcast [16 x i8]* %t443 to i8*
  %t445 = bitcast i8* %t444 to i8**
  store i8* %t441, i8** %t445
  %t446 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t439, i32 0, i32 1
  %t447 = bitcast [16 x i8]* %t446 to i8*
  %t448 = getelementptr inbounds i8, i8* %t447, i64 8
  %t449 = bitcast i8* %t448 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t449
  %t450 = load %NativeInstruction, %NativeInstruction* %t439
  %t451 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t452 = ptrtoint [1 x %NativeInstruction]* %t451 to i64
  %t453 = icmp eq i64 %t452, 0
  %t454 = select i1 %t453, i64 1, i64 %t452
  %t455 = call i8* @malloc(i64 %t454)
  %t456 = bitcast i8* %t455 to %NativeInstruction*
  %t457 = getelementptr %NativeInstruction, %NativeInstruction* %t456, i64 0
  store %NativeInstruction %t450, %NativeInstruction* %t457
  %t458 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t459 = ptrtoint { %NativeInstruction*, i64 }* %t458 to i64
  %t460 = call i8* @malloc(i64 %t459)
  %t461 = bitcast i8* %t460 to { %NativeInstruction*, i64 }*
  %t462 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t461, i32 0, i32 0
  store %NativeInstruction* %t456, %NativeInstruction** %t462
  %t463 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t461, i32 0, i32 1
  store i64 1, i64* %t463
  %t464 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t461, 0
  %t465 = insertvalue %InstructionParseResult %t464, i1 1, 1
  %t466 = insertvalue %InstructionParseResult %t465, i1 0, 2
  ret %InstructionParseResult %t466
merge41:
  %t467 = alloca %NativeInstruction
  %t468 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t467, i32 0, i32 0
  store i32 0, i32* %t468
  %t469 = load i8*, i8** %l10
  %t470 = call i8* @trim_trailing_delimiters(i8* %t469)
  %t471 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t467, i32 0, i32 1
  %t472 = bitcast [16 x i8]* %t471 to i8*
  %t473 = bitcast i8* %t472 to i8**
  store i8* %t470, i8** %t473
  %t474 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t467, i32 0, i32 1
  %t475 = bitcast [16 x i8]* %t474 to i8*
  %t476 = getelementptr inbounds i8, i8* %t475, i64 8
  %t477 = bitcast i8* %t476 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t477
  %t478 = load %NativeInstruction, %NativeInstruction* %t467
  %t479 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t480 = ptrtoint [1 x %NativeInstruction]* %t479 to i64
  %t481 = icmp eq i64 %t480, 0
  %t482 = select i1 %t481, i64 1, i64 %t480
  %t483 = call i8* @malloc(i64 %t482)
  %t484 = bitcast i8* %t483 to %NativeInstruction*
  %t485 = getelementptr %NativeInstruction, %NativeInstruction* %t484, i64 0
  store %NativeInstruction %t478, %NativeInstruction* %t485
  %t486 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t487 = ptrtoint { %NativeInstruction*, i64 }* %t486 to i64
  %t488 = call i8* @malloc(i64 %t487)
  %t489 = bitcast i8* %t488 to { %NativeInstruction*, i64 }*
  %t490 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t489, i32 0, i32 0
  store %NativeInstruction* %t484, %NativeInstruction** %t490
  %t491 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t489, i32 0, i32 1
  store i64 1, i64* %t491
  %t492 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t489, 0
  %t493 = insertvalue %InstructionParseResult %t492, i1 1, 1
  %t494 = insertvalue %InstructionParseResult %t493, i1 0, 2
  ret %InstructionParseResult %t494
merge39:
  br label %merge35
merge35:
  %t495 = call i8* @malloc(i64 10)
  %t496 = bitcast i8* %t495 to [10 x i8]*
  store [10 x i8] c"eval let \00", [10 x i8]* %t496
  %t497 = call i1 @starts_with(i8* %line, i8* %t495)
  br i1 %t497, label %then42, label %merge43
then42:
  %t498 = call i8* @malloc(i64 10)
  %t499 = bitcast i8* %t498 to [10 x i8]*
  store [10 x i8] c"eval let \00", [10 x i8]* %t499
  %t500 = call i8* @strip_prefix(i8* %line, i8* %t498)
  %t501 = call i8* @trim_text(i8* %t500)
  store i8* %t501, i8** %l11
  store i1 0, i1* %l12
  %t502 = load i8*, i8** %l11
  %t503 = call i8* @malloc(i64 5)
  %t504 = bitcast i8* %t503 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t504
  %t505 = call i1 @starts_with(i8* %t502, i8* %t503)
  %t506 = load i8*, i8** %l11
  %t507 = load i1, i1* %l12
  br i1 %t505, label %then44, label %merge45
then44:
  store i1 1, i1* %l12
  %t508 = load i8*, i8** %l11
  %t509 = call i8* @malloc(i64 5)
  %t510 = bitcast i8* %t509 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t510
  %t511 = call i8* @strip_prefix(i8* %t508, i8* %t509)
  %t512 = call i8* @trim_text(i8* %t511)
  store i8* %t512, i8** %l11
  %t513 = load i1, i1* %l12
  %t514 = load i8*, i8** %l11
  br label %merge45
merge45:
  %t515 = phi i1 [ %t513, %then44 ], [ %t507, %then42 ]
  %t516 = phi i8* [ %t514, %then44 ], [ %t506, %then42 ]
  store i1 %t515, i1* %l12
  store i8* %t516, i8** %l11
  %t517 = load i8*, i8** %l11
  %t518 = call %BindingComponents @parse_binding_components(i8* %t517)
  store %BindingComponents %t518, %BindingComponents* %l13
  %t519 = alloca %NativeInstruction
  %t520 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 0
  store i32 2, i32* %t520
  %t521 = load %BindingComponents, %BindingComponents* %l13
  %t522 = extractvalue %BindingComponents %t521, 0
  %t523 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 1
  %t524 = bitcast [48 x i8]* %t523 to i8*
  %t525 = bitcast i8* %t524 to i8**
  store i8* %t522, i8** %t525
  %t526 = load i1, i1* %l12
  %t527 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 1
  %t528 = bitcast [48 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 8
  %t530 = bitcast i8* %t529 to i1*
  store i1 %t526, i1* %t530
  %t531 = load %BindingComponents, %BindingComponents* %l13
  %t532 = extractvalue %BindingComponents %t531, 1
  %t533 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 1
  %t534 = bitcast [48 x i8]* %t533 to i8*
  %t535 = getelementptr inbounds i8, i8* %t534, i64 16
  %t536 = bitcast i8* %t535 to i8**
  store i8* %t532, i8** %t536
  %t537 = load %BindingComponents, %BindingComponents* %l13
  %t538 = extractvalue %BindingComponents %t537, 2
  %t539 = call i8* @maybe_trim_trailing(i8* %t538)
  %t540 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 1
  %t541 = bitcast [48 x i8]* %t540 to i8*
  %t542 = getelementptr inbounds i8, i8* %t541, i64 24
  %t543 = bitcast i8* %t542 to i8**
  store i8* %t539, i8** %t543
  %t544 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 1
  %t545 = bitcast [48 x i8]* %t544 to i8*
  %t546 = getelementptr inbounds i8, i8* %t545, i64 32
  %t547 = bitcast i8* %t546 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t547
  %t548 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t519, i32 0, i32 1
  %t549 = bitcast [48 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 40
  %t551 = bitcast i8* %t550 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t551
  %t552 = load %NativeInstruction, %NativeInstruction* %t519
  %t553 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t554 = ptrtoint [1 x %NativeInstruction]* %t553 to i64
  %t555 = icmp eq i64 %t554, 0
  %t556 = select i1 %t555, i64 1, i64 %t554
  %t557 = call i8* @malloc(i64 %t556)
  %t558 = bitcast i8* %t557 to %NativeInstruction*
  %t559 = getelementptr %NativeInstruction, %NativeInstruction* %t558, i64 0
  store %NativeInstruction %t552, %NativeInstruction* %t559
  %t560 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t561 = ptrtoint { %NativeInstruction*, i64 }* %t560 to i64
  %t562 = call i8* @malloc(i64 %t561)
  %t563 = bitcast i8* %t562 to { %NativeInstruction*, i64 }*
  %t564 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t563, i32 0, i32 0
  store %NativeInstruction* %t558, %NativeInstruction** %t564
  %t565 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t563, i32 0, i32 1
  store i64 1, i64* %t565
  %t566 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t563, 0
  %t567 = insertvalue %InstructionParseResult %t566, i1 1, 1
  %t568 = insertvalue %InstructionParseResult %t567, i1 1, 2
  ret %InstructionParseResult %t568
merge43:
  %t569 = call i8* @malloc(i64 6)
  %t570 = bitcast i8* %t569 to [6 x i8]*
  store [6 x i8] c"eval \00", [6 x i8]* %t570
  %t571 = call i1 @starts_with(i8* %line, i8* %t569)
  br i1 %t571, label %then46, label %merge47
then46:
  %t572 = alloca %NativeInstruction
  %t573 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t572, i32 0, i32 0
  store i32 1, i32* %t573
  %t574 = call i8* @malloc(i64 6)
  %t575 = bitcast i8* %t574 to [6 x i8]*
  store [6 x i8] c"eval \00", [6 x i8]* %t575
  %t576 = call i8* @strip_prefix(i8* %line, i8* %t574)
  %t577 = call i8* @trim_text(i8* %t576)
  %t578 = call i8* @trim_trailing_delimiters(i8* %t577)
  %t579 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t572, i32 0, i32 1
  %t580 = bitcast [16 x i8]* %t579 to i8*
  %t581 = bitcast i8* %t580 to i8**
  store i8* %t578, i8** %t581
  %t582 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t572, i32 0, i32 1
  %t583 = bitcast [16 x i8]* %t582 to i8*
  %t584 = getelementptr inbounds i8, i8* %t583, i64 8
  %t585 = bitcast i8* %t584 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t585
  %t586 = load %NativeInstruction, %NativeInstruction* %t572
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
  %t601 = insertvalue %InstructionParseResult %t600, i1 1, 1
  %t602 = insertvalue %InstructionParseResult %t601, i1 0, 2
  ret %InstructionParseResult %t602
merge47:
  %t603 = call i8* @malloc(i64 3)
  %t604 = bitcast i8* %t603 to [3 x i8]*
  store [3 x i8] c"=>\00", [3 x i8]* %t604
  %t605 = call double @index_of(i8* %line, i8* %t603)
  %t606 = sitofp i64 0 to double
  %t607 = fcmp oge double %t605, %t606
  br i1 %t607, label %then48, label %merge49
then48:
  %t608 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t609 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t608, 0
  %t610 = insertvalue %InstructionParseResult %t609, i1 0, 1
  %t611 = insertvalue %InstructionParseResult %t610, i1 0, 2
  ret %InstructionParseResult %t611
merge49:
  %t612 = alloca %NativeInstruction
  %t613 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t612, i32 0, i32 0
  store i32 16, i32* %t613
  %t614 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t612, i32 0, i32 1
  %t615 = bitcast [8 x i8]* %t614 to i8*
  %t616 = bitcast i8* %t615 to i8**
  store i8* %line, i8** %t616
  %t617 = load %NativeInstruction, %NativeInstruction* %t612
  %t618 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t619 = ptrtoint [1 x %NativeInstruction]* %t618 to i64
  %t620 = icmp eq i64 %t619, 0
  %t621 = select i1 %t620, i64 1, i64 %t619
  %t622 = call i8* @malloc(i64 %t621)
  %t623 = bitcast i8* %t622 to %NativeInstruction*
  %t624 = getelementptr %NativeInstruction, %NativeInstruction* %t623, i64 0
  store %NativeInstruction %t617, %NativeInstruction* %t624
  %t625 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t626 = ptrtoint { %NativeInstruction*, i64 }* %t625 to i64
  %t627 = call i8* @malloc(i64 %t626)
  %t628 = bitcast i8* %t627 to { %NativeInstruction*, i64 }*
  %t629 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t628, i32 0, i32 0
  store %NativeInstruction* %t623, %NativeInstruction** %t629
  %t630 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t628, i32 0, i32 1
  store i64 1, i64* %t630
  %t631 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t628, 0
  %t632 = insertvalue %InstructionParseResult %t631, i1 0, 1
  %t633 = insertvalue %InstructionParseResult %t632, i1 0, 2
  ret %InstructionParseResult %t633
}

define %NativeInstruction @parse_case_instruction(i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %CaseComponents
  %t0 = call i8* @malloc(i64 7)
  %t1 = bitcast i8* %t0 to [7 x i8]*
  store [7 x i8] c".case \00", [7 x i8]* %t1
  %t2 = call i8* @strip_prefix(i8* %line, i8* %t0)
  %t3 = call i8* @trim_text(i8* %t2)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call %CaseComponents @split_case_components(i8* %t4)
  store %CaseComponents %t5, %CaseComponents* %l1
  %t6 = alloca %NativeInstruction
  %t7 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t6, i32 0, i32 0
  store i32 13, i32* %t7
  %t8 = load %CaseComponents, %CaseComponents* %l1
  %t9 = extractvalue %CaseComponents %t8, 0
  %t10 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t6, i32 0, i32 1
  %t11 = bitcast [16 x i8]* %t10 to i8*
  %t12 = bitcast i8* %t11 to i8**
  store i8* %t9, i8** %t12
  %t13 = load %CaseComponents, %CaseComponents* %l1
  %t14 = extractvalue %CaseComponents %t13, 1
  %t15 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t6, i32 0, i32 1
  %t16 = bitcast [16 x i8]* %t15 to i8*
  %t17 = getelementptr inbounds i8, i8* %t16, i64 8
  %t18 = bitcast i8* %t17 to i8**
  store i8* %t14, i8** %t18
  %t19 = load %NativeInstruction, %NativeInstruction* %t6
  ret %NativeInstruction %t19
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
  %t3 = call i8* @malloc(i64 3)
  %t4 = bitcast i8* %t3 to [3 x i8]*
  store [3 x i8] c"=>\00", [3 x i8]* %t4
  %t5 = call double @index_of(i8* %t2, i8* %t3)
  store double %t5, double* %l1
  %t6 = load double, double* %l1
  %t7 = sitofp i64 0 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then0, label %merge1
then0:
  %t11 = alloca %NativeInstruction
  %t12 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t11, i32 0, i32 0
  store i32 16, i32* %t12
  %t13 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t11, i32 0, i32 1
  %t14 = bitcast [8 x i8]* %t13 to i8*
  %t15 = bitcast i8* %t14 to i8**
  store i8* %line, i8** %t15
  %t16 = load %NativeInstruction, %NativeInstruction* %t11
  %t17 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t18 = ptrtoint [1 x %NativeInstruction]* %t17 to i64
  %t19 = icmp eq i64 %t18, 0
  %t20 = select i1 %t19, i64 1, i64 %t18
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to %NativeInstruction*
  %t23 = getelementptr %NativeInstruction, %NativeInstruction* %t22, i64 0
  store %NativeInstruction %t16, %NativeInstruction* %t23
  %t24 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t25 = ptrtoint { %NativeInstruction*, i64 }* %t24 to i64
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to { %NativeInstruction*, i64 }*
  %t28 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t27, i32 0, i32 0
  store %NativeInstruction* %t22, %NativeInstruction** %t28
  %t29 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t27, i32 0, i32 1
  store i64 1, i64* %t29
  ret { %NativeInstruction*, i64 }* %t27
merge1:
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = call double @llvm.round.f64(double %t31)
  %t33 = fptosi double %t32 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %t30, i64 0, i64 %t33)
  %t35 = call i8* @trim_text(i8* %t34)
  store i8* %t35, i8** %l2
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 2 to double
  %t39 = fadd double %t37, %t38
  %t40 = load i8*, i8** %l0
  %t41 = call i64 @sailfin_runtime_string_length(i8* %t40)
  %t42 = call double @llvm.round.f64(double %t39)
  %t43 = fptosi double %t42 to i64
  %t44 = call i8* @sailfin_runtime_substring(i8* %t36, i64 %t43, i64 %t41)
  %t45 = call i8* @trim_text(i8* %t44)
  %t46 = call i8* @trim_trailing_delimiters(i8* %t45)
  store i8* %t46, i8** %l3
  %t47 = load i8*, i8** %l2
  %t48 = call %CaseComponents @split_case_components(i8* %t47)
  store %CaseComponents %t48, %CaseComponents* %l4
  %t49 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t50 = ptrtoint [0 x %NativeInstruction]* %t49 to i64
  %t51 = icmp eq i64 %t50, 0
  %t52 = select i1 %t51, i64 1, i64 %t50
  %t53 = call i8* @malloc(i64 %t52)
  %t54 = bitcast i8* %t53 to %NativeInstruction*
  %t55 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t56 = ptrtoint { %NativeInstruction*, i64 }* %t55 to i64
  %t57 = call i8* @malloc(i64 %t56)
  %t58 = bitcast i8* %t57 to { %NativeInstruction*, i64 }*
  %t59 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t58, i32 0, i32 0
  store %NativeInstruction* %t54, %NativeInstruction** %t59
  %t60 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t58, i32 0, i32 1
  store i64 0, i64* %t60
  store { %NativeInstruction*, i64 }* %t58, { %NativeInstruction*, i64 }** %l5
  %t61 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t62 = alloca %NativeInstruction
  %t63 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t62, i32 0, i32 0
  store i32 13, i32* %t63
  %t64 = load %CaseComponents, %CaseComponents* %l4
  %t65 = extractvalue %CaseComponents %t64, 0
  %t66 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t62, i32 0, i32 1
  %t67 = bitcast [16 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  store i8* %t65, i8** %t68
  %t69 = load %CaseComponents, %CaseComponents* %l4
  %t70 = extractvalue %CaseComponents %t69, 1
  %t71 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t62, i32 0, i32 1
  %t72 = bitcast [16 x i8]* %t71 to i8*
  %t73 = getelementptr inbounds i8, i8* %t72, i64 8
  %t74 = bitcast i8* %t73 to i8**
  store i8* %t70, i8** %t74
  %t75 = load %NativeInstruction, %NativeInstruction* %t62
  %t76 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t77 = ptrtoint [1 x %NativeInstruction]* %t76 to i64
  %t78 = icmp eq i64 %t77, 0
  %t79 = select i1 %t78, i64 1, i64 %t77
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to %NativeInstruction*
  %t82 = getelementptr %NativeInstruction, %NativeInstruction* %t81, i64 0
  store %NativeInstruction %t75, %NativeInstruction* %t82
  %t83 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t84 = ptrtoint { %NativeInstruction*, i64 }* %t83 to i64
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to { %NativeInstruction*, i64 }*
  %t87 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t86, i32 0, i32 0
  store %NativeInstruction* %t81, %NativeInstruction** %t87
  %t88 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t86, i32 0, i32 1
  store i64 1, i64* %t88
  %t89 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t61, i32 0, i32 0
  %t90 = load %NativeInstruction*, %NativeInstruction** %t89
  %t91 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t61, i32 0, i32 1
  %t92 = load i64, i64* %t91
  %t93 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t86, i32 0, i32 0
  %t94 = load %NativeInstruction*, %NativeInstruction** %t93
  %t95 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t86, i32 0, i32 1
  %t96 = load i64, i64* %t95
  %t97 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t98 = ptrtoint %NativeInstruction* %t97 to i64
  %t99 = add i64 %t92, %t96
  %t100 = mul i64 %t98, %t99
  %t101 = call noalias i8* @malloc(i64 %t100)
  %t102 = bitcast i8* %t101 to %NativeInstruction*
  %t103 = bitcast %NativeInstruction* %t102 to i8*
  %t104 = mul i64 %t98, %t92
  %t105 = bitcast %NativeInstruction* %t90 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t103, i8* %t105, i64 %t104)
  %t106 = mul i64 %t98, %t96
  %t107 = bitcast %NativeInstruction* %t94 to i8*
  %t108 = getelementptr %NativeInstruction, %NativeInstruction* %t102, i64 %t92
  %t109 = bitcast %NativeInstruction* %t108 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t109, i8* %t107, i64 %t106)
  %t110 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t111 = ptrtoint { %NativeInstruction*, i64 }* %t110 to i64
  %t112 = call i8* @malloc(i64 %t111)
  %t113 = bitcast i8* %t112 to { %NativeInstruction*, i64 }*
  %t114 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t113, i32 0, i32 0
  store %NativeInstruction* %t102, %NativeInstruction** %t114
  %t115 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t113, i32 0, i32 1
  store i64 %t99, i64* %t115
  store { %NativeInstruction*, i64 }* %t113, { %NativeInstruction*, i64 }** %l5
  %t116 = load i8*, i8** %l3
  %t117 = call i64 @sailfin_runtime_string_length(i8* %t116)
  %t118 = icmp eq i64 %t117, 0
  %t119 = load i8*, i8** %l0
  %t120 = load double, double* %l1
  %t121 = load i8*, i8** %l2
  %t122 = load i8*, i8** %l3
  %t123 = load %CaseComponents, %CaseComponents* %l4
  %t124 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t118, label %then2, label %merge3
then2:
  %t125 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t126 = insertvalue %NativeInstruction undef, i32 15, 0
  %t127 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t128 = ptrtoint [1 x %NativeInstruction]* %t127 to i64
  %t129 = icmp eq i64 %t128, 0
  %t130 = select i1 %t129, i64 1, i64 %t128
  %t131 = call i8* @malloc(i64 %t130)
  %t132 = bitcast i8* %t131 to %NativeInstruction*
  %t133 = getelementptr %NativeInstruction, %NativeInstruction* %t132, i64 0
  store %NativeInstruction %t126, %NativeInstruction* %t133
  %t134 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t135 = ptrtoint { %NativeInstruction*, i64 }* %t134 to i64
  %t136 = call i8* @malloc(i64 %t135)
  %t137 = bitcast i8* %t136 to { %NativeInstruction*, i64 }*
  %t138 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t137, i32 0, i32 0
  store %NativeInstruction* %t132, %NativeInstruction** %t138
  %t139 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t137, i32 0, i32 1
  store i64 1, i64* %t139
  %t140 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t125, i32 0, i32 0
  %t141 = load %NativeInstruction*, %NativeInstruction** %t140
  %t142 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t125, i32 0, i32 1
  %t143 = load i64, i64* %t142
  %t144 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t137, i32 0, i32 0
  %t145 = load %NativeInstruction*, %NativeInstruction** %t144
  %t146 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t137, i32 0, i32 1
  %t147 = load i64, i64* %t146
  %t148 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t149 = ptrtoint %NativeInstruction* %t148 to i64
  %t150 = add i64 %t143, %t147
  %t151 = mul i64 %t149, %t150
  %t152 = call noalias i8* @malloc(i64 %t151)
  %t153 = bitcast i8* %t152 to %NativeInstruction*
  %t154 = bitcast %NativeInstruction* %t153 to i8*
  %t155 = mul i64 %t149, %t143
  %t156 = bitcast %NativeInstruction* %t141 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t154, i8* %t156, i64 %t155)
  %t157 = mul i64 %t149, %t147
  %t158 = bitcast %NativeInstruction* %t145 to i8*
  %t159 = getelementptr %NativeInstruction, %NativeInstruction* %t153, i64 %t143
  %t160 = bitcast %NativeInstruction* %t159 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t160, i8* %t158, i64 %t157)
  %t161 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t162 = ptrtoint { %NativeInstruction*, i64 }* %t161 to i64
  %t163 = call i8* @malloc(i64 %t162)
  %t164 = bitcast i8* %t163 to { %NativeInstruction*, i64 }*
  %t165 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t164, i32 0, i32 0
  store %NativeInstruction* %t153, %NativeInstruction** %t165
  %t166 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t164, i32 0, i32 1
  store i64 %t150, i64* %t166
  store { %NativeInstruction*, i64 }* %t164, { %NativeInstruction*, i64 }** %l5
  %t167 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t167
merge3:
  %t168 = load i8*, i8** %l3
  %t169 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t168)
  store %NativeInstruction %t169, %NativeInstruction* %l6
  %t170 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t171 = load %NativeInstruction, %NativeInstruction* %l6
  %t172 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t173 = ptrtoint [1 x %NativeInstruction]* %t172 to i64
  %t174 = icmp eq i64 %t173, 0
  %t175 = select i1 %t174, i64 1, i64 %t173
  %t176 = call i8* @malloc(i64 %t175)
  %t177 = bitcast i8* %t176 to %NativeInstruction*
  %t178 = getelementptr %NativeInstruction, %NativeInstruction* %t177, i64 0
  store %NativeInstruction %t171, %NativeInstruction* %t178
  %t179 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t180 = ptrtoint { %NativeInstruction*, i64 }* %t179 to i64
  %t181 = call i8* @malloc(i64 %t180)
  %t182 = bitcast i8* %t181 to { %NativeInstruction*, i64 }*
  %t183 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t182, i32 0, i32 0
  store %NativeInstruction* %t177, %NativeInstruction** %t183
  %t184 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t182, i32 0, i32 1
  store i64 1, i64* %t184
  %t185 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t170, i32 0, i32 0
  %t186 = load %NativeInstruction*, %NativeInstruction** %t185
  %t187 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t170, i32 0, i32 1
  %t188 = load i64, i64* %t187
  %t189 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t182, i32 0, i32 0
  %t190 = load %NativeInstruction*, %NativeInstruction** %t189
  %t191 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t182, i32 0, i32 1
  %t192 = load i64, i64* %t191
  %t193 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t194 = ptrtoint %NativeInstruction* %t193 to i64
  %t195 = add i64 %t188, %t192
  %t196 = mul i64 %t194, %t195
  %t197 = call noalias i8* @malloc(i64 %t196)
  %t198 = bitcast i8* %t197 to %NativeInstruction*
  %t199 = bitcast %NativeInstruction* %t198 to i8*
  %t200 = mul i64 %t194, %t188
  %t201 = bitcast %NativeInstruction* %t186 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t199, i8* %t201, i64 %t200)
  %t202 = mul i64 %t194, %t192
  %t203 = bitcast %NativeInstruction* %t190 to i8*
  %t204 = getelementptr %NativeInstruction, %NativeInstruction* %t198, i64 %t188
  %t205 = bitcast %NativeInstruction* %t204 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t205, i8* %t203, i64 %t202)
  %t206 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t207 = ptrtoint { %NativeInstruction*, i64 }* %t206 to i64
  %t208 = call i8* @malloc(i64 %t207)
  %t209 = bitcast i8* %t208 to { %NativeInstruction*, i64 }*
  %t210 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t209, i32 0, i32 0
  store %NativeInstruction* %t198, %NativeInstruction** %t210
  %t211 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t209, i32 0, i32 1
  store i64 %t195, i64* %t211
  store { %NativeInstruction*, i64 }* %t209, { %NativeInstruction*, i64 }** %l5
  %t212 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t212
}

define %NativeInstruction @parse_inline_case_body_instruction(i8* %body) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_trailing_delimiters(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i8* @malloc(i64 8)
  %t3 = bitcast i8* %t2 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t3
  %t4 = call i1 @starts_with(i8* %t1, i8* %t2)
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @malloc(i64 8)
  %t8 = bitcast i8* %t7 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t8
  %t9 = call i8* @strip_prefix(i8* %t6, i8* %t7)
  %t10 = call i8* @trim_text(i8* %t9)
  %t11 = call i8* @trim_trailing_delimiters(i8* %t10)
  store i8* %t11, i8** %l1
  %t12 = alloca %NativeInstruction
  %t13 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t12, i32 0, i32 0
  store i32 0, i32* %t13
  %t14 = load i8*, i8** %l1
  %t15 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t12, i32 0, i32 1
  %t16 = bitcast [16 x i8]* %t15 to i8*
  %t17 = bitcast i8* %t16 to i8**
  store i8* %t14, i8** %t17
  %t18 = bitcast i8* null to %NativeSourceSpan*
  %t19 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t12, i32 0, i32 1
  %t20 = bitcast [16 x i8]* %t19 to i8*
  %t21 = getelementptr inbounds i8, i8* %t20, i64 8
  %t22 = bitcast i8* %t21 to %NativeSourceSpan**
  store %NativeSourceSpan* %t18, %NativeSourceSpan** %t22
  %t23 = load %NativeInstruction, %NativeInstruction* %t12
  ret %NativeInstruction %t23
merge1:
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @malloc(i64 6)
  %t26 = bitcast i8* %t25 to [6 x i8]*
  store [6 x i8] c"eval \00", [6 x i8]* %t26
  %t27 = call i1 @starts_with(i8* %t24, i8* %t25)
  %t28 = load i8*, i8** %l0
  br i1 %t27, label %then2, label %merge3
then2:
  %t29 = alloca %NativeInstruction
  %t30 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t29, i32 0, i32 0
  store i32 1, i32* %t30
  %t31 = load i8*, i8** %l0
  %t32 = call i8* @malloc(i64 6)
  %t33 = bitcast i8* %t32 to [6 x i8]*
  store [6 x i8] c"eval \00", [6 x i8]* %t33
  %t34 = call i8* @strip_prefix(i8* %t31, i8* %t32)
  %t35 = call i8* @trim_text(i8* %t34)
  %t36 = call i8* @trim_trailing_delimiters(i8* %t35)
  %t37 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t29, i32 0, i32 1
  %t38 = bitcast [16 x i8]* %t37 to i8*
  %t39 = bitcast i8* %t38 to i8**
  store i8* %t36, i8** %t39
  %t40 = bitcast i8* null to %NativeSourceSpan*
  %t41 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t29, i32 0, i32 1
  %t42 = bitcast [16 x i8]* %t41 to i8*
  %t43 = getelementptr inbounds i8, i8* %t42, i64 8
  %t44 = bitcast i8* %t43 to %NativeSourceSpan**
  store %NativeSourceSpan* %t40, %NativeSourceSpan** %t44
  %t45 = load %NativeInstruction, %NativeInstruction* %t29
  ret %NativeInstruction %t45
merge3:
  %t46 = alloca %NativeInstruction
  %t47 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t46, i32 0, i32 0
  store i32 1, i32* %t47
  %t48 = load i8*, i8** %l0
  %t49 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t46, i32 0, i32 1
  %t50 = bitcast [16 x i8]* %t49 to i8*
  %t51 = bitcast i8* %t50 to i8**
  store i8* %t48, i8** %t51
  %t52 = bitcast i8* null to %NativeSourceSpan*
  %t53 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t46, i32 0, i32 1
  %t54 = bitcast [16 x i8]* %t53 to i8*
  %t55 = getelementptr inbounds i8, i8* %t54, i64 8
  %t56 = bitcast i8* %t55 to %NativeSourceSpan**
  store %NativeSourceSpan* %t52, %NativeSourceSpan** %t56
  %t57 = load %NativeInstruction, %NativeInstruction* %t46
  ret %NativeInstruction %t57
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
  %t8 = call i8* @malloc(i64 5)
  %t9 = bitcast i8* %t8 to [5 x i8]*
  store [5 x i8] c" if \00", [5 x i8]* %t9
  store i8* %t8, i8** %l1
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l1
  %t12 = call double @last_index_of(i8* %t10, i8* %t11)
  store double %t12, double* %l2
  %t13 = load double, double* %l2
  %t14 = sitofp i64 0 to double
  %t15 = fcmp olt double %t13, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then2, label %merge3
then2:
  %t19 = load i8*, i8** %l0
  %t20 = insertvalue %CaseComponents undef, i8* %t19, 0
  %t21 = insertvalue %CaseComponents %t20, i8* null, 1
  ret %CaseComponents %t21
merge3:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l2
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = call i8* @sailfin_runtime_substring(i8* %t22, i64 0, i64 %t25)
  %t27 = call i8* @trim_text(i8* %t26)
  store i8* %t27, i8** %l3
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l2
  %t30 = load i8*, i8** %l1
  %t31 = call i64 @sailfin_runtime_string_length(i8* %t30)
  %t32 = sitofp i64 %t31 to double
  %t33 = fadd double %t29, %t32
  %t34 = load i8*, i8** %l0
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = call double @llvm.round.f64(double %t33)
  %t37 = fptosi double %t36 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %t28, i64 %t37, i64 %t35)
  %t39 = call i8* @trim_text(i8* %t38)
  store i8* %t39, i8** %l4
  %t40 = load i8*, i8** %l4
  %t41 = call i64 @sailfin_runtime_string_length(i8* %t40)
  %t42 = icmp eq i64 %t41, 0
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load double, double* %l2
  %t46 = load i8*, i8** %l3
  %t47 = load i8*, i8** %l4
  br i1 %t42, label %then4, label %merge5
then4:
  %t48 = load i8*, i8** %l3
  %t49 = insertvalue %CaseComponents undef, i8* %t48, 0
  %t50 = insertvalue %CaseComponents %t49, i8* null, 1
  ret %CaseComponents %t50
merge5:
  %t51 = load i8*, i8** %l3
  %t52 = insertvalue %CaseComponents undef, i8* %t51, 0
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %CaseComponents %t52, i8* %t53, 1
  ret %CaseComponents %t54
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
  %t5 = call i8* @malloc(i64 1)
  %t6 = bitcast i8* %t5 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t6
  %t7 = insertvalue %NativeImportSpecifier undef, i8* %t5, 0
  %t8 = insertvalue %NativeImportSpecifier %t7, i8* null, 1
  ret %NativeImportSpecifier %t8
merge1:
  %t9 = call i8* @malloc(i64 5)
  %t10 = bitcast i8* %t9 to [5 x i8]*
  store [5 x i8] c" as \00", [5 x i8]* %t10
  store i8* %t9, i8** %l1
  %t11 = load i8*, i8** %l0
  %t12 = load i8*, i8** %l1
  %t13 = call double @index_of(i8* %t11, i8* %t12)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = sitofp i64 0 to double
  %t16 = fcmp olt double %t14, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load double, double* %l2
  br i1 %t16, label %then2, label %merge3
then2:
  %t20 = load i8*, i8** %l0
  %t21 = insertvalue %NativeImportSpecifier undef, i8* %t20, 0
  %t22 = insertvalue %NativeImportSpecifier %t21, i8* null, 1
  ret %NativeImportSpecifier %t22
merge3:
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l2
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = call i8* @sailfin_runtime_substring(i8* %t23, i64 0, i64 %t26)
  %t28 = call i8* @trim_text(i8* %t27)
  store i8* %t28, i8** %l3
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = load i8*, i8** %l1
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = sitofp i64 %t32 to double
  %t34 = fadd double %t30, %t33
  %t35 = load i8*, i8** %l0
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = call double @llvm.round.f64(double %t34)
  %t38 = fptosi double %t37 to i64
  %t39 = call i8* @sailfin_runtime_substring(i8* %t29, i64 %t38, i64 %t36)
  %t40 = call i8* @trim_text(i8* %t39)
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = icmp eq i64 %t42, 0
  %t44 = load i8*, i8** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l2
  %t47 = load i8*, i8** %l3
  %t48 = load i8*, i8** %l4
  br i1 %t43, label %then4, label %merge5
then4:
  %t49 = load i8*, i8** %l3
  %t50 = insertvalue %NativeImportSpecifier undef, i8* %t49, 0
  %t51 = insertvalue %NativeImportSpecifier %t50, i8* null, 1
  ret %NativeImportSpecifier %t51
merge5:
  %t52 = load i8*, i8** %l3
  %t53 = insertvalue %NativeImportSpecifier undef, i8* %t52, 0
  %t54 = load i8*, i8** %l4
  %t55 = insertvalue %NativeImportSpecifier %t53, i8* %t54, 1
  ret %NativeImportSpecifier %t55
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
  %l26 = alloca i8*
  %l27 = alloca i1
  %l28 = alloca i8
  %l29 = alloca i8*
  %l30 = alloca %StructLayoutHeaderParse
  %l31 = alloca %StructLayoutFieldParse
  %l32 = alloca %NativeStructField*
  %l33 = alloca i8*
  %l34 = alloca %NativeStructLayout*
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
  %t22 = call i8* @malloc(i64 9)
  %t23 = bitcast i8* %t22 to [9 x i8]*
  store [9 x i8] c".struct \00", [9 x i8]* %t23
  %t24 = call i8* @strip_prefix(i8* %t21, i8* %t22)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  %t27 = call %StructHeaderParse @parse_struct_header(i8* %t26)
  store %StructHeaderParse %t27, %StructHeaderParse* %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t30 = extractvalue %StructHeaderParse %t29, 2
  %t31 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t33 = extractvalue %StructHeaderParse %t32, 0
  store i8* %t33, i8** %l4
  %t34 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t35 = extractvalue %StructHeaderParse %t34, 1
  store { i8**, i64 }* %t35, { i8**, i64 }** %l5
  %t36 = load i8*, i8** %l4
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t43 = load i8*, i8** %l4
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t38, label %then0, label %merge1
then0:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = call i8* @malloc(i64 32)
  %t47 = bitcast i8* %t46 to [32 x i8]*
  store [32 x i8] c"unable to parse struct header: \00", [32 x i8]* %t47
  %t48 = load i8*, i8** %l1
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t48)
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t45, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  %t51 = bitcast i8* null to %NativeStruct*
  %t52 = insertvalue %StructParseResult undef, %NativeStruct* %t51, 0
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %start_index, %t53
  %t55 = insertvalue %StructParseResult %t52, double %t54, 1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = insertvalue %StructParseResult %t55, { i8**, i64 }* %t56, 2
  ret %StructParseResult %t57
merge1:
  %t58 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* null, i32 1
  %t59 = ptrtoint [0 x %NativeStructField]* %t58 to i64
  %t60 = icmp eq i64 %t59, 0
  %t61 = select i1 %t60, i64 1, i64 %t59
  %t62 = call i8* @malloc(i64 %t61)
  %t63 = bitcast i8* %t62 to %NativeStructField*
  %t64 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t65 = ptrtoint { %NativeStructField*, i64 }* %t64 to i64
  %t66 = call i8* @malloc(i64 %t65)
  %t67 = bitcast i8* %t66 to { %NativeStructField*, i64 }*
  %t68 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t67, i32 0, i32 0
  store %NativeStructField* %t63, %NativeStructField** %t68
  %t69 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  store { %NativeStructField*, i64 }* %t67, { %NativeStructField*, i64 }** %l6
  %t70 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t71 = ptrtoint [0 x %NativeFunction]* %t70 to i64
  %t72 = icmp eq i64 %t71, 0
  %t73 = select i1 %t72, i64 1, i64 %t71
  %t74 = call i8* @malloc(i64 %t73)
  %t75 = bitcast i8* %t74 to %NativeFunction*
  %t76 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t77 = ptrtoint { %NativeFunction*, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { %NativeFunction*, i64 }*
  %t80 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t79, i32 0, i32 0
  store %NativeFunction* %t75, %NativeFunction** %t80
  %t81 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  store { %NativeFunction*, i64 }* %t79, { %NativeFunction*, i64 }** %l7
  %t82 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t82, %NativeFunction** %l8
  %t83 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t83, %NativeSourceSpan** %l9
  %t84 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t84, %NativeSourceSpan** %l10
  %t85 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t86 = ptrtoint [0 x %NativeStructLayoutField]* %t85 to i64
  %t87 = icmp eq i64 %t86, 0
  %t88 = select i1 %t87, i64 1, i64 %t86
  %t89 = call i8* @malloc(i64 %t88)
  %t90 = bitcast i8* %t89 to %NativeStructLayoutField*
  %t91 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t92 = ptrtoint { %NativeStructLayoutField*, i64 }* %t91 to i64
  %t93 = call i8* @malloc(i64 %t92)
  %t94 = bitcast i8* %t93 to { %NativeStructLayoutField*, i64 }*
  %t95 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t94, i32 0, i32 0
  store %NativeStructLayoutField* %t90, %NativeStructLayoutField** %t95
  %t96 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t94, i32 0, i32 1
  store i64 0, i64* %t96
  store { %NativeStructLayoutField*, i64 }* %t94, { %NativeStructLayoutField*, i64 }** %l11
  %t97 = sitofp i64 0 to double
  store double %t97, double* %l12
  %t98 = sitofp i64 0 to double
  store double %t98, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %start_index, %t99
  store double %t100, double* %l16
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  %t103 = load i8*, i8** %l2
  %t104 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t105 = load i8*, i8** %l4
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t107 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t108 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t109 = load %NativeFunction*, %NativeFunction** %l8
  %t110 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t111 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t112 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t113 = load double, double* %l12
  %t114 = load double, double* %l13
  %t115 = load i1, i1* %l14
  %t116 = load i1, i1* %l15
  %t117 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t1541 = phi { i8**, i64 }* [ %t101, %merge1 ], [ %t1529, %loop.latch4 ]
  %t1542 = phi double [ %t117, %merge1 ], [ %t1530, %loop.latch4 ]
  %t1543 = phi { %NativeFunction*, i64 }* [ %t108, %merge1 ], [ %t1531, %loop.latch4 ]
  %t1544 = phi %NativeFunction* [ %t109, %merge1 ], [ %t1532, %loop.latch4 ]
  %t1545 = phi %NativeSourceSpan* [ %t110, %merge1 ], [ %t1533, %loop.latch4 ]
  %t1546 = phi %NativeSourceSpan* [ %t111, %merge1 ], [ %t1534, %loop.latch4 ]
  %t1547 = phi double [ %t113, %merge1 ], [ %t1535, %loop.latch4 ]
  %t1548 = phi double [ %t114, %merge1 ], [ %t1536, %loop.latch4 ]
  %t1549 = phi i1 [ %t115, %merge1 ], [ %t1537, %loop.latch4 ]
  %t1550 = phi { %NativeStructLayoutField*, i64 }* [ %t112, %merge1 ], [ %t1538, %loop.latch4 ]
  %t1551 = phi i1 [ %t116, %merge1 ], [ %t1539, %loop.latch4 ]
  %t1552 = phi { %NativeStructField*, i64 }* [ %t107, %merge1 ], [ %t1540, %loop.latch4 ]
  store { i8**, i64 }* %t1541, { i8**, i64 }** %l0
  store double %t1542, double* %l16
  store { %NativeFunction*, i64 }* %t1543, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1544, %NativeFunction** %l8
  store %NativeSourceSpan* %t1545, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1546, %NativeSourceSpan** %l10
  store double %t1547, double* %l12
  store double %t1548, double* %l13
  store i1 %t1549, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1550, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1551, i1* %l15
  store { %NativeStructField*, i64 }* %t1552, { %NativeStructField*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t118 = load double, double* %l16
  %t119 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t120 = extractvalue { i8**, i64 } %t119, 1
  %t121 = sitofp i64 %t120 to double
  %t122 = fcmp oge double %t118, %t121
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load i8*, i8** %l1
  %t125 = load i8*, i8** %l2
  %t126 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t127 = load i8*, i8** %l4
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t129 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t130 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t131 = load %NativeFunction*, %NativeFunction** %l8
  %t132 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t133 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t134 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t135 = load double, double* %l12
  %t136 = load double, double* %l13
  %t137 = load i1, i1* %l14
  %t138 = load i1, i1* %l15
  %t139 = load double, double* %l16
  br i1 %t122, label %then6, label %merge7
then6:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = call i8* @malloc(i64 21)
  %t142 = bitcast i8* %t141 to [21 x i8]*
  store [21 x i8] c"unterminated struct \00", [21 x i8]* %t142
  %t143 = load i8*, i8** %l4
  %t144 = call i8* @sailfin_runtime_string_concat(i8* %t141, i8* %t143)
  %t145 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t140, i8* %t144)
  store { i8**, i64 }* %t145, { i8**, i64 }** %l0
  %t146 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t146, %NativeStructLayout** %l17
  %t147 = load i1, i1* %l14
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load i8*, i8** %l1
  %t150 = load i8*, i8** %l2
  %t151 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t152 = load i8*, i8** %l4
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t154 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t155 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t156 = load %NativeFunction*, %NativeFunction** %l8
  %t157 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t158 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t159 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t160 = load double, double* %l12
  %t161 = load double, double* %l13
  %t162 = load i1, i1* %l14
  %t163 = load i1, i1* %l15
  %t164 = load double, double* %l16
  %t165 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br i1 %t147, label %then8, label %merge9
then8:
  %t166 = load double, double* %l12
  %t167 = insertvalue %NativeStructLayout undef, double %t166, 0
  %t168 = load double, double* %l13
  %t169 = insertvalue %NativeStructLayout %t167, double %t168, 1
  %t170 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t171 = insertvalue %NativeStructLayout %t169, { %NativeStructLayoutField*, i64 }* %t170, 2
  %t172 = getelementptr %NativeStructLayout, %NativeStructLayout* null, i32 1
  %t173 = ptrtoint %NativeStructLayout* %t172 to i64
  %t174 = call noalias i8* @malloc(i64 %t173)
  %t175 = bitcast i8* %t174 to %NativeStructLayout*
  store %NativeStructLayout %t171, %NativeStructLayout* %t175
  call void @sailfin_runtime_mark_persistent(i8* %t174)
  store %NativeStructLayout* %t175, %NativeStructLayout** %l17
  %t176 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t177 = phi %NativeStructLayout* [ %t176, %then8 ], [ %t165, %then6 ]
  store %NativeStructLayout* %t177, %NativeStructLayout** %l17
  %t178 = load i8*, i8** %l4
  %t179 = insertvalue %NativeStruct undef, i8* %t178, 0
  %t180 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t181 = insertvalue %NativeStruct %t179, { %NativeStructField*, i64 }* %t180, 1
  %t182 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t183 = insertvalue %NativeStruct %t181, { %NativeFunction*, i64 }* %t182, 2
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t185 = insertvalue %NativeStruct %t183, { i8**, i64 }* %t184, 3
  %t186 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t187 = insertvalue %NativeStruct %t185, %NativeStructLayout* %t186, 4
  %t188 = getelementptr %NativeStruct, %NativeStruct* null, i32 1
  %t189 = ptrtoint %NativeStruct* %t188 to i64
  %t190 = call noalias i8* @malloc(i64 %t189)
  %t191 = bitcast i8* %t190 to %NativeStruct*
  store %NativeStruct %t187, %NativeStruct* %t191
  call void @sailfin_runtime_mark_persistent(i8* %t190)
  %t192 = insertvalue %StructParseResult undef, %NativeStruct* %t191, 0
  %t193 = load double, double* %l16
  %t194 = insertvalue %StructParseResult %t192, double %t193, 1
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t196 = insertvalue %StructParseResult %t194, { i8**, i64 }* %t195, 2
  ret %StructParseResult %t196
merge7:
  %t197 = load double, double* %l16
  %t198 = call double @llvm.round.f64(double %t197)
  %t199 = fptosi double %t198 to i64
  %t200 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t201 = extractvalue { i8**, i64 } %t200, 0
  %t202 = extractvalue { i8**, i64 } %t200, 1
  %t203 = icmp uge i64 %t199, %t202
  ; bounds check: %t203 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t199, i64 %t202)
  %t204 = getelementptr i8*, i8** %t201, i64 %t199
  %t205 = load i8*, i8** %t204
  %t206 = call i8* @trim_text(i8* %t205)
  store i8* %t206, i8** %l18
  %t208 = load i8*, i8** %l18
  %t209 = call i64 @sailfin_runtime_string_length(i8* %t208)
  %t210 = icmp eq i64 %t209, 0
  br label %logical_or_entry_207

logical_or_entry_207:
  br i1 %t210, label %logical_or_merge_207, label %logical_or_right_207

logical_or_right_207:
  %t211 = load i8*, i8** %l18
  %t212 = add i64 0, 2
  %t213 = call i8* @malloc(i64 %t212)
  store i8 59, i8* %t213
  %t214 = getelementptr i8, i8* %t213, i64 1
  store i8 0, i8* %t214
  call void @sailfin_runtime_mark_persistent(i8* %t213)
  %t215 = call i1 @starts_with(i8* %t211, i8* %t213)
  br label %logical_or_right_end_207

logical_or_right_end_207:
  br label %logical_or_merge_207

logical_or_merge_207:
  %t216 = phi i1 [ true, %logical_or_entry_207 ], [ %t215, %logical_or_right_end_207 ]
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l1
  %t219 = load i8*, i8** %l2
  %t220 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t221 = load i8*, i8** %l4
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t223 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t224 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t225 = load %NativeFunction*, %NativeFunction** %l8
  %t226 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t227 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t228 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t229 = load double, double* %l12
  %t230 = load double, double* %l13
  %t231 = load i1, i1* %l14
  %t232 = load i1, i1* %l15
  %t233 = load double, double* %l16
  %t234 = load i8*, i8** %l18
  br i1 %t216, label %then10, label %merge11
then10:
  %t235 = load double, double* %l16
  %t236 = sitofp i64 1 to double
  %t237 = fadd double %t235, %t236
  store double %t237, double* %l16
  br label %loop.latch4
merge11:
  %t238 = load i8*, i8** %l18
  %t239 = call i8* @malloc(i64 11)
  %t240 = bitcast i8* %t239 to [11 x i8]*
  store [11 x i8] c".endstruct\00", [11 x i8]* %t240
  %t241 = call i1 @strings_equal(i8* %t238, i8* %t239)
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load i8*, i8** %l1
  %t244 = load i8*, i8** %l2
  %t245 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t246 = load i8*, i8** %l4
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t248 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t249 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t250 = load %NativeFunction*, %NativeFunction** %l8
  %t251 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t252 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t253 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t254 = load double, double* %l12
  %t255 = load double, double* %l13
  %t256 = load i1, i1* %l14
  %t257 = load i1, i1* %l15
  %t258 = load double, double* %l16
  %t259 = load i8*, i8** %l18
  br i1 %t241, label %then12, label %merge13
then12:
  %t260 = load %NativeFunction*, %NativeFunction** %l8
  %t261 = icmp ne %NativeFunction* %t260, null
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t263 = load i8*, i8** %l1
  %t264 = load i8*, i8** %l2
  %t265 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t266 = load i8*, i8** %l4
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t268 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t269 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t270 = load %NativeFunction*, %NativeFunction** %l8
  %t271 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t272 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t273 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t274 = load double, double* %l12
  %t275 = load double, double* %l13
  %t276 = load i1, i1* %l14
  %t277 = load i1, i1* %l15
  %t278 = load double, double* %l16
  %t279 = load i8*, i8** %l18
  br i1 %t261, label %then14, label %merge15
then14:
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = call i8* @malloc(i64 31)
  %t282 = bitcast i8* %t281 to [31 x i8]*
  store [31 x i8] c"unterminated method in struct \00", [31 x i8]* %t282
  %t283 = load i8*, i8** %l4
  %t284 = call i8* @sailfin_runtime_string_concat(i8* %t281, i8* %t283)
  %t285 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t280, i8* %t284)
  store { i8**, i64 }* %t285, { i8**, i64 }** %l0
  %t286 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t287 = load %NativeFunction*, %NativeFunction** %l8
  %t288 = load %NativeFunction, %NativeFunction* %t287
  %t289 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t286, %NativeFunction %t288)
  store { %NativeFunction*, i64 }* %t289, { %NativeFunction*, i64 }** %l7
  %t290 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t290, %NativeFunction** %l8
  %t291 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t291, %NativeSourceSpan** %l9
  %t292 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t292, %NativeSourceSpan** %l10
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t294 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t295 = load %NativeFunction*, %NativeFunction** %l8
  %t296 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t297 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t298 = phi { i8**, i64 }* [ %t293, %then14 ], [ %t262, %then12 ]
  %t299 = phi { %NativeFunction*, i64 }* [ %t294, %then14 ], [ %t269, %then12 ]
  %t300 = phi %NativeFunction* [ %t295, %then14 ], [ %t270, %then12 ]
  %t301 = phi %NativeSourceSpan* [ %t296, %then14 ], [ %t271, %then12 ]
  %t302 = phi %NativeSourceSpan* [ %t297, %then14 ], [ %t272, %then12 ]
  store { i8**, i64 }* %t298, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t299, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t300, %NativeFunction** %l8
  store %NativeSourceSpan* %t301, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t302, %NativeSourceSpan** %l10
  %t303 = load double, double* %l16
  %t304 = sitofp i64 1 to double
  %t305 = fadd double %t303, %t304
  store double %t305, double* %l16
  br label %afterloop5
merge13:
  %t306 = load %NativeFunction*, %NativeFunction** %l8
  %t307 = icmp ne %NativeFunction* %t306, null
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t309 = load i8*, i8** %l1
  %t310 = load i8*, i8** %l2
  %t311 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t312 = load i8*, i8** %l4
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t314 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t315 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t316 = load %NativeFunction*, %NativeFunction** %l8
  %t317 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t318 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t319 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t320 = load double, double* %l12
  %t321 = load double, double* %l13
  %t322 = load i1, i1* %l14
  %t323 = load i1, i1* %l15
  %t324 = load double, double* %l16
  %t325 = load i8*, i8** %l18
  br i1 %t307, label %then16, label %merge17
then16:
  %t326 = load i8*, i8** %l18
  %t327 = call i8* @malloc(i64 11)
  %t328 = bitcast i8* %t327 to [11 x i8]*
  store [11 x i8] c".endmethod\00", [11 x i8]* %t328
  %t329 = call i1 @strings_equal(i8* %t326, i8* %t327)
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t331 = load i8*, i8** %l1
  %t332 = load i8*, i8** %l2
  %t333 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t334 = load i8*, i8** %l4
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t336 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t337 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t338 = load %NativeFunction*, %NativeFunction** %l8
  %t339 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t340 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t341 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t342 = load double, double* %l12
  %t343 = load double, double* %l13
  %t344 = load i1, i1* %l14
  %t345 = load i1, i1* %l15
  %t346 = load double, double* %l16
  %t347 = load i8*, i8** %l18
  br i1 %t329, label %then18, label %merge19
then18:
  %t348 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t349 = load %NativeFunction*, %NativeFunction** %l8
  %t350 = load %NativeFunction, %NativeFunction* %t349
  %t351 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t348, %NativeFunction %t350)
  store { %NativeFunction*, i64 }* %t351, { %NativeFunction*, i64 }** %l7
  %t352 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t352, %NativeFunction** %l8
  %t353 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t353, %NativeSourceSpan** %l9
  %t354 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t354, %NativeSourceSpan** %l10
  %t355 = load double, double* %l16
  %t356 = sitofp i64 1 to double
  %t357 = fadd double %t355, %t356
  store double %t357, double* %l16
  br label %loop.latch4
merge19:
  %t358 = load i8*, i8** %l18
  %t359 = call i8* @malloc(i64 7)
  %t360 = bitcast i8* %t359 to [7 x i8]*
  store [7 x i8] c".meta \00", [7 x i8]* %t360
  %t361 = call i1 @starts_with(i8* %t358, i8* %t359)
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t363 = load i8*, i8** %l1
  %t364 = load i8*, i8** %l2
  %t365 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t366 = load i8*, i8** %l4
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t368 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t369 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t370 = load %NativeFunction*, %NativeFunction** %l8
  %t371 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t372 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t373 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t374 = load double, double* %l12
  %t375 = load double, double* %l13
  %t376 = load i1, i1* %l14
  %t377 = load i1, i1* %l15
  %t378 = load double, double* %l16
  %t379 = load i8*, i8** %l18
  br i1 %t361, label %then20, label %merge21
then20:
  %t380 = load %NativeFunction*, %NativeFunction** %l8
  %t381 = load i8*, i8** %l18
  %t382 = call i8* @malloc(i64 7)
  %t383 = bitcast i8* %t382 to [7 x i8]*
  store [7 x i8] c".meta \00", [7 x i8]* %t383
  %t384 = call i8* @strip_prefix(i8* %t381, i8* %t382)
  %t385 = load %NativeFunction, %NativeFunction* %t380
  %t386 = call %NativeFunction @apply_meta(%NativeFunction %t385, i8* %t384)
  %t387 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t388 = ptrtoint %NativeFunction* %t387 to i64
  %t389 = call noalias i8* @malloc(i64 %t388)
  %t390 = bitcast i8* %t389 to %NativeFunction*
  store %NativeFunction %t386, %NativeFunction* %t390
  call void @sailfin_runtime_mark_persistent(i8* %t389)
  store %NativeFunction* %t390, %NativeFunction** %l8
  %t391 = load double, double* %l16
  %t392 = sitofp i64 1 to double
  %t393 = fadd double %t391, %t392
  store double %t393, double* %l16
  br label %loop.latch4
merge21:
  %t394 = load i8*, i8** %l18
  %t395 = call i8* @malloc(i64 8)
  %t396 = bitcast i8* %t395 to [8 x i8]*
  store [8 x i8] c".param \00", [8 x i8]* %t396
  %t397 = call i1 @starts_with(i8* %t394, i8* %t395)
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t399 = load i8*, i8** %l1
  %t400 = load i8*, i8** %l2
  %t401 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t402 = load i8*, i8** %l4
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t404 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t405 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t406 = load %NativeFunction*, %NativeFunction** %l8
  %t407 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t408 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t409 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t410 = load double, double* %l12
  %t411 = load double, double* %l13
  %t412 = load i1, i1* %l14
  %t413 = load i1, i1* %l15
  %t414 = load double, double* %l16
  %t415 = load i8*, i8** %l18
  br i1 %t397, label %then22, label %merge23
then22:
  %t416 = load i8*, i8** %l18
  %t417 = call i8* @malloc(i64 8)
  %t418 = bitcast i8* %t417 to [8 x i8]*
  store [8 x i8] c".param \00", [8 x i8]* %t418
  %t419 = call i8* @strip_prefix(i8* %t416, i8* %t417)
  %t420 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t421 = call %NativeParameter* @parse_parameter_entry(i8* %t419, %NativeSourceSpan* %t420)
  store %NativeParameter* %t421, %NativeParameter** %l19
  %t422 = load %NativeParameter*, %NativeParameter** %l19
  %t423 = icmp eq %NativeParameter* %t422, null
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t425 = load i8*, i8** %l1
  %t426 = load i8*, i8** %l2
  %t427 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t428 = load i8*, i8** %l4
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t430 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t431 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t432 = load %NativeFunction*, %NativeFunction** %l8
  %t433 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t434 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t435 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t436 = load double, double* %l12
  %t437 = load double, double* %l13
  %t438 = load i1, i1* %l14
  %t439 = load i1, i1* %l15
  %t440 = load double, double* %l16
  %t441 = load i8*, i8** %l18
  %t442 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t423, label %then24, label %else25
then24:
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t444 = call i8* @malloc(i64 35)
  %t445 = bitcast i8* %t444 to [35 x i8]*
  store [35 x i8] c"unable to parse method parameter: \00", [35 x i8]* %t445
  %t446 = load i8*, i8** %l18
  %t447 = call i8* @sailfin_runtime_string_concat(i8* %t444, i8* %t446)
  %t448 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t443, i8* %t447)
  store { i8**, i64 }* %t448, { i8**, i64 }** %l0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t450 = load %NativeFunction*, %NativeFunction** %l8
  %t451 = load %NativeParameter*, %NativeParameter** %l19
  %t452 = load %NativeFunction, %NativeFunction* %t450
  %t453 = load %NativeParameter, %NativeParameter* %t451
  %t454 = call %NativeFunction @append_parameter(%NativeFunction %t452, %NativeParameter %t453)
  %t455 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t456 = ptrtoint %NativeFunction* %t455 to i64
  %t457 = call noalias i8* @malloc(i64 %t456)
  %t458 = bitcast i8* %t457 to %NativeFunction*
  store %NativeFunction %t454, %NativeFunction* %t458
  call void @sailfin_runtime_mark_persistent(i8* %t457)
  store %NativeFunction* %t458, %NativeFunction** %l8
  %t459 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge26
merge26:
  %t460 = phi { i8**, i64 }* [ %t449, %then24 ], [ %t424, %else25 ]
  %t461 = phi %NativeFunction* [ %t432, %then24 ], [ %t459, %else25 ]
  store { i8**, i64 }* %t460, { i8**, i64 }** %l0
  store %NativeFunction* %t461, %NativeFunction** %l8
  %t462 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t462, %NativeSourceSpan** %l9
  %t463 = load double, double* %l16
  %t464 = sitofp i64 1 to double
  %t465 = fadd double %t463, %t464
  store double %t465, double* %l16
  br label %loop.latch4
merge23:
  %t466 = load i8*, i8** %l18
  %t467 = call i8* @malloc(i64 9)
  %t468 = bitcast i8* %t467 to [9 x i8]*
  store [9 x i8] c".method \00", [9 x i8]* %t468
  %t469 = call i1 @starts_with(i8* %t466, i8* %t467)
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t471 = load i8*, i8** %l1
  %t472 = load i8*, i8** %l2
  %t473 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t474 = load i8*, i8** %l4
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t476 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t477 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t478 = load %NativeFunction*, %NativeFunction** %l8
  %t479 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t480 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t481 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t482 = load double, double* %l12
  %t483 = load double, double* %l13
  %t484 = load i1, i1* %l14
  %t485 = load i1, i1* %l15
  %t486 = load double, double* %l16
  %t487 = load i8*, i8** %l18
  br i1 %t469, label %then27, label %merge28
then27:
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t489 = call i8* @malloc(i64 37)
  %t490 = bitcast i8* %t489 to [37 x i8]*
  store [37 x i8] c"nested method declaration in struct \00", [37 x i8]* %t490
  %t491 = load i8*, i8** %l4
  %t492 = call i8* @sailfin_runtime_string_concat(i8* %t489, i8* %t491)
  %t493 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t488, i8* %t492)
  store { i8**, i64 }* %t493, { i8**, i64 }** %l0
  %t494 = load double, double* %l16
  %t495 = sitofp i64 1 to double
  %t496 = fadd double %t494, %t495
  store double %t496, double* %l16
  br label %loop.latch4
merge28:
  %t497 = load i8*, i8** %l18
  %t498 = call i8* @malloc(i64 7)
  %t499 = bitcast i8* %t498 to [7 x i8]*
  store [7 x i8] c".span \00", [7 x i8]* %t499
  %t500 = call i1 @starts_with(i8* %t497, i8* %t498)
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t502 = load i8*, i8** %l1
  %t503 = load i8*, i8** %l2
  %t504 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t505 = load i8*, i8** %l4
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t507 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t508 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t509 = load %NativeFunction*, %NativeFunction** %l8
  %t510 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t511 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t512 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t513 = load double, double* %l12
  %t514 = load double, double* %l13
  %t515 = load i1, i1* %l14
  %t516 = load i1, i1* %l15
  %t517 = load double, double* %l16
  %t518 = load i8*, i8** %l18
  br i1 %t500, label %then29, label %merge30
then29:
  %t519 = load i8*, i8** %l18
  %t520 = call i8* @malloc(i64 7)
  %t521 = bitcast i8* %t520 to [7 x i8]*
  store [7 x i8] c".span \00", [7 x i8]* %t521
  %t522 = call i8* @strip_prefix(i8* %t519, i8* %t520)
  %t523 = call %NativeSourceSpan* @parse_source_span(i8* %t522)
  store %NativeSourceSpan* %t523, %NativeSourceSpan** %l20
  %t524 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t525 = icmp eq %NativeSourceSpan* %t524, null
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t527 = load i8*, i8** %l1
  %t528 = load i8*, i8** %l2
  %t529 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t530 = load i8*, i8** %l4
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t532 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t533 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t534 = load %NativeFunction*, %NativeFunction** %l8
  %t535 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t536 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t537 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t538 = load double, double* %l12
  %t539 = load double, double* %l13
  %t540 = load i1, i1* %l14
  %t541 = load i1, i1* %l15
  %t542 = load double, double* %l16
  %t543 = load i8*, i8** %l18
  %t544 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t525, label %then31, label %else32
then31:
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t546 = call i8* @malloc(i64 32)
  %t547 = bitcast i8* %t546 to [32 x i8]*
  store [32 x i8] c"unable to parse span metadata: \00", [32 x i8]* %t547
  %t548 = load i8*, i8** %l18
  %t549 = call i8* @sailfin_runtime_string_concat(i8* %t546, i8* %t548)
  %t550 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t545, i8* %t549)
  store { i8**, i64 }* %t550, { i8**, i64 }** %l0
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t552 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t552, %NativeSourceSpan** %l9
  %t553 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t554 = phi { i8**, i64 }* [ %t551, %then31 ], [ %t526, %else32 ]
  %t555 = phi %NativeSourceSpan* [ %t535, %then31 ], [ %t553, %else32 ]
  store { i8**, i64 }* %t554, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t555, %NativeSourceSpan** %l9
  %t556 = load double, double* %l16
  %t557 = sitofp i64 1 to double
  %t558 = fadd double %t556, %t557
  store double %t558, double* %l16
  br label %loop.latch4
merge30:
  %t559 = load i8*, i8** %l18
  %t560 = call i8* @malloc(i64 12)
  %t561 = bitcast i8* %t560 to [12 x i8]*
  store [12 x i8] c".init-span \00", [12 x i8]* %t561
  %t562 = call i1 @starts_with(i8* %t559, i8* %t560)
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t564 = load i8*, i8** %l1
  %t565 = load i8*, i8** %l2
  %t566 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t567 = load i8*, i8** %l4
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t569 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t570 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t571 = load %NativeFunction*, %NativeFunction** %l8
  %t572 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t573 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t574 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t575 = load double, double* %l12
  %t576 = load double, double* %l13
  %t577 = load i1, i1* %l14
  %t578 = load i1, i1* %l15
  %t579 = load double, double* %l16
  %t580 = load i8*, i8** %l18
  br i1 %t562, label %then34, label %merge35
then34:
  %t581 = load i8*, i8** %l18
  %t582 = call i8* @malloc(i64 12)
  %t583 = bitcast i8* %t582 to [12 x i8]*
  store [12 x i8] c".init-span \00", [12 x i8]* %t583
  %t584 = call i8* @strip_prefix(i8* %t581, i8* %t582)
  %t585 = call %NativeSourceSpan* @parse_source_span(i8* %t584)
  store %NativeSourceSpan* %t585, %NativeSourceSpan** %l21
  %t586 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t587 = icmp eq %NativeSourceSpan* %t586, null
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t589 = load i8*, i8** %l1
  %t590 = load i8*, i8** %l2
  %t591 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t592 = load i8*, i8** %l4
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t594 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t595 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t596 = load %NativeFunction*, %NativeFunction** %l8
  %t597 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t598 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t599 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t600 = load double, double* %l12
  %t601 = load double, double* %l13
  %t602 = load i1, i1* %l14
  %t603 = load i1, i1* %l15
  %t604 = load double, double* %l16
  %t605 = load i8*, i8** %l18
  %t606 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t587, label %then36, label %else37
then36:
  %t607 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t608 = call i8* @malloc(i64 44)
  %t609 = bitcast i8* %t608 to [44 x i8]*
  store [44 x i8] c"unable to parse initializer span metadata: \00", [44 x i8]* %t609
  %t610 = load i8*, i8** %l18
  %t611 = call i8* @sailfin_runtime_string_concat(i8* %t608, i8* %t610)
  %t612 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t607, i8* %t611)
  store { i8**, i64 }* %t612, { i8**, i64 }** %l0
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t614 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t614, %NativeSourceSpan** %l10
  %t615 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t616 = phi { i8**, i64 }* [ %t613, %then36 ], [ %t588, %else37 ]
  %t617 = phi %NativeSourceSpan* [ %t598, %then36 ], [ %t615, %else37 ]
  store { i8**, i64 }* %t616, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t617, %NativeSourceSpan** %l10
  %t618 = load double, double* %l16
  %t619 = sitofp i64 1 to double
  %t620 = fadd double %t618, %t619
  store double %t620, double* %l16
  br label %loop.latch4
merge35:
  %t621 = load i8*, i8** %l18
  %t622 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t623 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t624 = call %InstructionParseResult @parse_instruction(i8* %t621, %NativeSourceSpan* %t622, %NativeSourceSpan* %t623)
  store %InstructionParseResult %t624, %InstructionParseResult* %l22
  %t625 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t626 = extractvalue %InstructionParseResult %t625, 1
  %t627 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t628 = load i8*, i8** %l1
  %t629 = load i8*, i8** %l2
  %t630 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t631 = load i8*, i8** %l4
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t633 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t634 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t635 = load %NativeFunction*, %NativeFunction** %l8
  %t636 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t637 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t638 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t639 = load double, double* %l12
  %t640 = load double, double* %l13
  %t641 = load i1, i1* %l14
  %t642 = load i1, i1* %l15
  %t643 = load double, double* %l16
  %t644 = load i8*, i8** %l18
  %t645 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t626, label %then39, label %else40
then39:
  %t646 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t646, %NativeSourceSpan** %l9
  %t647 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t648 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t649 = icmp ne %NativeSourceSpan* %t648, null
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t651 = load i8*, i8** %l1
  %t652 = load i8*, i8** %l2
  %t653 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t654 = load i8*, i8** %l4
  %t655 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t656 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t657 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t658 = load %NativeFunction*, %NativeFunction** %l8
  %t659 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t660 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t661 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t662 = load double, double* %l12
  %t663 = load double, double* %l13
  %t664 = load i1, i1* %l14
  %t665 = load i1, i1* %l15
  %t666 = load double, double* %l16
  %t667 = load i8*, i8** %l18
  %t668 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t649, label %then42, label %merge43
then42:
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t670 = call i8* @malloc(i64 30)
  %t671 = bitcast i8* %t670 to [30 x i8]*
  store [30 x i8] c"unused span metadata before: \00", [30 x i8]* %t671
  %t672 = load i8*, i8** %l18
  %t673 = call i8* @sailfin_runtime_string_concat(i8* %t670, i8* %t672)
  %t674 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t669, i8* %t673)
  store { i8**, i64 }* %t674, { i8**, i64 }** %l0
  %t675 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t675, %NativeSourceSpan** %l9
  %t676 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t677 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t678 = phi { i8**, i64 }* [ %t676, %then42 ], [ %t650, %else40 ]
  %t679 = phi %NativeSourceSpan* [ %t677, %then42 ], [ %t659, %else40 ]
  store { i8**, i64 }* %t678, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t679, %NativeSourceSpan** %l9
  %t680 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t681 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t682 = phi %NativeSourceSpan* [ %t647, %then39 ], [ %t681, %merge43 ]
  %t683 = phi { i8**, i64 }* [ %t627, %then39 ], [ %t680, %merge43 ]
  store %NativeSourceSpan* %t682, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t683, { i8**, i64 }** %l0
  %t684 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t685 = extractvalue %InstructionParseResult %t684, 2
  %t686 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t687 = load i8*, i8** %l1
  %t688 = load i8*, i8** %l2
  %t689 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t690 = load i8*, i8** %l4
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t692 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t693 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t694 = load %NativeFunction*, %NativeFunction** %l8
  %t695 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t696 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t697 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t698 = load double, double* %l12
  %t699 = load double, double* %l13
  %t700 = load i1, i1* %l14
  %t701 = load i1, i1* %l15
  %t702 = load double, double* %l16
  %t703 = load i8*, i8** %l18
  %t704 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t685, label %then44, label %else45
then44:
  %t705 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t705, %NativeSourceSpan** %l10
  %t706 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t707 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t708 = icmp ne %NativeSourceSpan* %t707, null
  %t709 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t710 = load i8*, i8** %l1
  %t711 = load i8*, i8** %l2
  %t712 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t713 = load i8*, i8** %l4
  %t714 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t715 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t716 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t717 = load %NativeFunction*, %NativeFunction** %l8
  %t718 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t719 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t720 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t721 = load double, double* %l12
  %t722 = load double, double* %l13
  %t723 = load i1, i1* %l14
  %t724 = load i1, i1* %l15
  %t725 = load double, double* %l16
  %t726 = load i8*, i8** %l18
  %t727 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t708, label %then47, label %merge48
then47:
  %t728 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t729 = call i8* @malloc(i64 42)
  %t730 = bitcast i8* %t729 to [42 x i8]*
  store [42 x i8] c"unused initializer span metadata before: \00", [42 x i8]* %t730
  %t731 = load i8*, i8** %l18
  %t732 = call i8* @sailfin_runtime_string_concat(i8* %t729, i8* %t731)
  %t733 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t728, i8* %t732)
  store { i8**, i64 }* %t733, { i8**, i64 }** %l0
  %t734 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t734, %NativeSourceSpan** %l10
  %t735 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t736 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t737 = phi { i8**, i64 }* [ %t735, %then47 ], [ %t709, %else45 ]
  %t738 = phi %NativeSourceSpan* [ %t736, %then47 ], [ %t719, %else45 ]
  store { i8**, i64 }* %t737, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t738, %NativeSourceSpan** %l10
  %t739 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t740 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t741 = phi %NativeSourceSpan* [ %t706, %then44 ], [ %t740, %merge48 ]
  %t742 = phi { i8**, i64 }* [ %t686, %then44 ], [ %t739, %merge48 ]
  store %NativeSourceSpan* %t741, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t742, { i8**, i64 }** %l0
  %t743 = sitofp i64 0 to double
  store double %t743, double* %l23
  %t744 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t745 = load i8*, i8** %l1
  %t746 = load i8*, i8** %l2
  %t747 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t748 = load i8*, i8** %l4
  %t749 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t750 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t751 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t752 = load %NativeFunction*, %NativeFunction** %l8
  %t753 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t754 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t755 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t756 = load double, double* %l12
  %t757 = load double, double* %l13
  %t758 = load i1, i1* %l14
  %t759 = load i1, i1* %l15
  %t760 = load double, double* %l16
  %t761 = load i8*, i8** %l18
  %t762 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t763 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t814 = phi %NativeFunction* [ %t752, %merge46 ], [ %t812, %loop.latch51 ]
  %t815 = phi double [ %t763, %merge46 ], [ %t813, %loop.latch51 ]
  store %NativeFunction* %t814, %NativeFunction** %l8
  store double %t815, double* %l23
  br label %loop.body50
loop.body50:
  %t764 = load double, double* %l23
  %t765 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t766 = extractvalue %InstructionParseResult %t765, 0
  %t767 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t766
  %t768 = extractvalue { %NativeInstruction*, i64 } %t767, 1
  %t769 = sitofp i64 %t768 to double
  %t770 = fcmp oge double %t764, %t769
  %t771 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t772 = load i8*, i8** %l1
  %t773 = load i8*, i8** %l2
  %t774 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t775 = load i8*, i8** %l4
  %t776 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t777 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t778 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t779 = load %NativeFunction*, %NativeFunction** %l8
  %t780 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t781 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t782 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t783 = load double, double* %l12
  %t784 = load double, double* %l13
  %t785 = load i1, i1* %l14
  %t786 = load i1, i1* %l15
  %t787 = load double, double* %l16
  %t788 = load i8*, i8** %l18
  %t789 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t790 = load double, double* %l23
  br i1 %t770, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t791 = load %NativeFunction*, %NativeFunction** %l8
  %t792 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t793 = extractvalue %InstructionParseResult %t792, 0
  %t794 = load double, double* %l23
  %t795 = call double @llvm.round.f64(double %t794)
  %t796 = fptosi double %t795 to i64
  %t797 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t793
  %t798 = extractvalue { %NativeInstruction*, i64 } %t797, 0
  %t799 = extractvalue { %NativeInstruction*, i64 } %t797, 1
  %t800 = icmp uge i64 %t796, %t799
  ; bounds check: %t800 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t796, i64 %t799)
  %t801 = getelementptr %NativeInstruction, %NativeInstruction* %t798, i64 %t796
  %t802 = load %NativeInstruction, %NativeInstruction* %t801
  %t803 = load %NativeFunction, %NativeFunction* %t791
  %t804 = call %NativeFunction @append_instruction(%NativeFunction %t803, %NativeInstruction %t802)
  %t805 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t806 = ptrtoint %NativeFunction* %t805 to i64
  %t807 = call noalias i8* @malloc(i64 %t806)
  %t808 = bitcast i8* %t807 to %NativeFunction*
  store %NativeFunction %t804, %NativeFunction* %t808
  call void @sailfin_runtime_mark_persistent(i8* %t807)
  store %NativeFunction* %t808, %NativeFunction** %l8
  %t809 = load double, double* %l23
  %t810 = sitofp i64 1 to double
  %t811 = fadd double %t809, %t810
  store double %t811, double* %l23
  br label %loop.latch51
loop.latch51:
  %t812 = load %NativeFunction*, %NativeFunction** %l8
  %t813 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t816 = load %NativeFunction*, %NativeFunction** %l8
  %t817 = load double, double* %l23
  %t818 = load double, double* %l16
  %t819 = sitofp i64 1 to double
  %t820 = fadd double %t818, %t819
  store double %t820, double* %l16
  br label %loop.latch4
merge17:
  %t821 = load i8*, i8** %l18
  %t822 = call i8* @malloc(i64 9)
  %t823 = bitcast i8* %t822 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t823
  %t824 = call i1 @starts_with(i8* %t821, i8* %t822)
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t826 = load i8*, i8** %l1
  %t827 = load i8*, i8** %l2
  %t828 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t829 = load i8*, i8** %l4
  %t830 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t831 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t832 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t833 = load %NativeFunction*, %NativeFunction** %l8
  %t834 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t835 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t836 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t837 = load double, double* %l12
  %t838 = load double, double* %l13
  %t839 = load i1, i1* %l14
  %t840 = load i1, i1* %l15
  %t841 = load double, double* %l16
  %t842 = load i8*, i8** %l18
  br i1 %t824, label %then55, label %merge56
then55:
  %t843 = load i8*, i8** %l18
  %t844 = call i8* @malloc(i64 9)
  %t845 = bitcast i8* %t844 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t845
  %t846 = call i8* @strip_prefix(i8* %t843, i8* %t844)
  store i8* %t846, i8** %l24
  %t847 = load i8*, i8** %l24
  %t848 = call i8* @malloc(i64 8)
  %t849 = bitcast i8* %t848 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t849
  %t850 = call i1 @starts_with(i8* %t847, i8* %t848)
  %t851 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t852 = load i8*, i8** %l1
  %t853 = load i8*, i8** %l2
  %t854 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t855 = load i8*, i8** %l4
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t857 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t858 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t859 = load %NativeFunction*, %NativeFunction** %l8
  %t860 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t861 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t862 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t863 = load double, double* %l12
  %t864 = load double, double* %l13
  %t865 = load i1, i1* %l14
  %t866 = load i1, i1* %l15
  %t867 = load double, double* %l16
  %t868 = load i8*, i8** %l18
  %t869 = load i8*, i8** %l24
  br i1 %t850, label %then57, label %merge58
then57:
  %t870 = load i8*, i8** %l24
  %t871 = call i8* @malloc(i64 8)
  %t872 = bitcast i8* %t871 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t872
  %t873 = call i8* @strip_prefix(i8* %t870, i8* %t871)
  %t874 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t873)
  store %StructLayoutHeaderParse %t874, %StructLayoutHeaderParse* %l25
  %t875 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t876 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t877 = extractvalue %StructLayoutHeaderParse %t876, 4
  %t878 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t875, { i8**, i64 }* %t877)
  store { i8**, i64 }* %t878, { i8**, i64 }** %l0
  %t879 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t880 = extractvalue %StructLayoutHeaderParse %t879, 0
  %t881 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t882 = load i8*, i8** %l1
  %t883 = load i8*, i8** %l2
  %t884 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t885 = load i8*, i8** %l4
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t887 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t888 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t889 = load %NativeFunction*, %NativeFunction** %l8
  %t890 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t891 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t892 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t893 = load double, double* %l12
  %t894 = load double, double* %l13
  %t895 = load i1, i1* %l14
  %t896 = load i1, i1* %l15
  %t897 = load double, double* %l16
  %t898 = load i8*, i8** %l18
  %t899 = load i8*, i8** %l24
  %t900 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t880, label %then59, label %merge60
then59:
  %t901 = load i1, i1* %l14
  %t902 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t903 = load i8*, i8** %l1
  %t904 = load i8*, i8** %l2
  %t905 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t906 = load i8*, i8** %l4
  %t907 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t908 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t909 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t910 = load %NativeFunction*, %NativeFunction** %l8
  %t911 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t912 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t913 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t914 = load double, double* %l12
  %t915 = load double, double* %l13
  %t916 = load i1, i1* %l14
  %t917 = load i1, i1* %l15
  %t918 = load double, double* %l16
  %t919 = load i8*, i8** %l18
  %t920 = load i8*, i8** %l24
  %t921 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t901, label %then61, label %else62
then61:
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t923 = call i8* @malloc(i64 35)
  %t924 = bitcast i8* %t923 to [35 x i8]*
  store [35 x i8] c"duplicate struct layout header in \00", [35 x i8]* %t924
  %t925 = load i8*, i8** %l4
  %t926 = call i8* @sailfin_runtime_string_concat(i8* %t923, i8* %t925)
  %t927 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t922, i8* %t926)
  store { i8**, i64 }* %t927, { i8**, i64 }** %l0
  %t928 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t929 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t930 = extractvalue %StructLayoutHeaderParse %t929, 2
  store double %t930, double* %l12
  %t931 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t932 = extractvalue %StructLayoutHeaderParse %t931, 3
  store double %t932, double* %l13
  store i1 1, i1* %l14
  %t933 = load double, double* %l12
  %t934 = load double, double* %l13
  %t935 = load i1, i1* %l14
  br label %merge63
merge63:
  %t936 = phi { i8**, i64 }* [ %t928, %then61 ], [ %t902, %else62 ]
  %t937 = phi double [ %t914, %then61 ], [ %t933, %else62 ]
  %t938 = phi double [ %t915, %then61 ], [ %t934, %else62 ]
  %t939 = phi i1 [ %t916, %then61 ], [ %t935, %else62 ]
  store { i8**, i64 }* %t936, { i8**, i64 }** %l0
  store double %t937, double* %l12
  store double %t938, double* %l13
  store i1 %t939, i1* %l14
  %t940 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t941 = load double, double* %l12
  %t942 = load double, double* %l13
  %t943 = load i1, i1* %l14
  br label %merge60
merge60:
  %t944 = phi { i8**, i64 }* [ %t940, %merge63 ], [ %t881, %then57 ]
  %t945 = phi double [ %t941, %merge63 ], [ %t893, %then57 ]
  %t946 = phi double [ %t942, %merge63 ], [ %t894, %then57 ]
  %t947 = phi i1 [ %t943, %merge63 ], [ %t895, %then57 ]
  store { i8**, i64 }* %t944, { i8**, i64 }** %l0
  store double %t945, double* %l12
  store double %t946, double* %l13
  store i1 %t947, i1* %l14
  %t948 = load double, double* %l16
  %t949 = sitofp i64 1 to double
  %t950 = fadd double %t948, %t949
  store double %t950, double* %l16
  br label %loop.latch4
merge58:
  %t951 = load i8*, i8** %l24
  %t952 = call i8* @malloc(i64 7)
  %t953 = bitcast i8* %t952 to [7 x i8]*
  store [7 x i8] c"field \00", [7 x i8]* %t953
  %t954 = call i1 @starts_with(i8* %t951, i8* %t952)
  %t955 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t956 = load i8*, i8** %l1
  %t957 = load i8*, i8** %l2
  %t958 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t959 = load i8*, i8** %l4
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t961 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t962 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t963 = load %NativeFunction*, %NativeFunction** %l8
  %t964 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t965 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t966 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t967 = load double, double* %l12
  %t968 = load double, double* %l13
  %t969 = load i1, i1* %l14
  %t970 = load i1, i1* %l15
  %t971 = load double, double* %l16
  %t972 = load i8*, i8** %l18
  %t973 = load i8*, i8** %l24
  br i1 %t954, label %then64, label %merge65
then64:
  %t974 = load i8*, i8** %l24
  %t975 = call i8* @malloc(i64 7)
  %t976 = bitcast i8* %t975 to [7 x i8]*
  store [7 x i8] c"field \00", [7 x i8]* %t976
  %t977 = call i8* @strip_prefix(i8* %t974, i8* %t975)
  %t978 = call i8* @trim_text(i8* %t977)
  store i8* %t978, i8** %l26
  store i1 0, i1* %l27
  %t979 = load i8*, i8** %l26
  %t980 = call i8* @malloc(i64 7)
  %t981 = bitcast i8* %t980 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t981
  %t982 = call i1 @starts_with(i8* %t979, i8* %t980)
  %t983 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t984 = load i8*, i8** %l1
  %t985 = load i8*, i8** %l2
  %t986 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t987 = load i8*, i8** %l4
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t989 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t990 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t991 = load %NativeFunction*, %NativeFunction** %l8
  %t992 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t993 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t994 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t995 = load double, double* %l12
  %t996 = load double, double* %l13
  %t997 = load i1, i1* %l14
  %t998 = load i1, i1* %l15
  %t999 = load double, double* %l16
  %t1000 = load i8*, i8** %l18
  %t1001 = load i8*, i8** %l24
  %t1002 = load i8*, i8** %l26
  %t1003 = load i1, i1* %l27
  br i1 %t982, label %then66, label %merge67
then66:
  %t1004 = load i8*, i8** %l26
  %t1005 = call i64 @sailfin_runtime_string_length(i8* %t1004)
  %t1006 = icmp eq i64 %t1005, 6
  %t1007 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1008 = load i8*, i8** %l1
  %t1009 = load i8*, i8** %l2
  %t1010 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1011 = load i8*, i8** %l4
  %t1012 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1013 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1014 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1015 = load %NativeFunction*, %NativeFunction** %l8
  %t1016 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1017 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1018 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1019 = load double, double* %l12
  %t1020 = load double, double* %l13
  %t1021 = load i1, i1* %l14
  %t1022 = load i1, i1* %l15
  %t1023 = load double, double* %l16
  %t1024 = load i8*, i8** %l18
  %t1025 = load i8*, i8** %l24
  %t1026 = load i8*, i8** %l26
  %t1027 = load i1, i1* %l27
  br i1 %t1006, label %then68, label %else69
then68:
  store i1 1, i1* %l27
  %t1028 = load i1, i1* %l27
  br label %merge70
else69:
  %t1029 = load i8*, i8** %l26
  %t1030 = call i64 @sailfin_runtime_string_length(i8* %t1029)
  %t1031 = icmp sgt i64 %t1030, 6
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1033 = load i8*, i8** %l1
  %t1034 = load i8*, i8** %l2
  %t1035 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1036 = load i8*, i8** %l4
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1038 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1039 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1040 = load %NativeFunction*, %NativeFunction** %l8
  %t1041 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1042 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1043 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1044 = load double, double* %l12
  %t1045 = load double, double* %l13
  %t1046 = load i1, i1* %l14
  %t1047 = load i1, i1* %l15
  %t1048 = load double, double* %l16
  %t1049 = load i8*, i8** %l18
  %t1050 = load i8*, i8** %l24
  %t1051 = load i8*, i8** %l26
  %t1052 = load i1, i1* %l27
  br i1 %t1031, label %then71, label %merge72
then71:
  %t1053 = load i8*, i8** %l26
  %t1054 = getelementptr i8, i8* %t1053, i64 6
  %t1055 = load i8, i8* %t1054
  store i8 %t1055, i8* %l28
  %t1056 = load i8, i8* %l28
  %t1057 = add i64 0, 2
  %t1058 = call i8* @malloc(i64 %t1057)
  store i8 %t1056, i8* %t1058
  %t1059 = getelementptr i8, i8* %t1058, i64 1
  store i8 0, i8* %t1059
  call void @sailfin_runtime_mark_persistent(i8* %t1058)
  %t1060 = call i1 @is_trim_char(i8* %t1058)
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
  %t1079 = load i8*, i8** %l24
  %t1080 = load i8*, i8** %l26
  %t1081 = load i1, i1* %l27
  %t1082 = load i8, i8* %l28
  br i1 %t1060, label %then73, label %merge74
then73:
  store i1 1, i1* %l27
  %t1083 = load i1, i1* %l27
  br label %merge74
merge74:
  %t1084 = phi i1 [ %t1083, %then73 ], [ %t1081, %then71 ]
  store i1 %t1084, i1* %l27
  %t1085 = load i1, i1* %l27
  br label %merge72
merge72:
  %t1086 = phi i1 [ %t1085, %merge74 ], [ %t1052, %else69 ]
  store i1 %t1086, i1* %l27
  %t1087 = load i1, i1* %l27
  br label %merge70
merge70:
  %t1088 = phi i1 [ %t1028, %then68 ], [ %t1087, %merge72 ]
  store i1 %t1088, i1* %l27
  %t1089 = load i1, i1* %l27
  %t1090 = load i1, i1* %l27
  br label %merge67
merge67:
  %t1091 = phi i1 [ %t1089, %merge70 ], [ %t1003, %then64 ]
  %t1092 = phi i1 [ %t1090, %merge70 ], [ %t1003, %then64 ]
  store i1 %t1091, i1* %l27
  store i1 %t1092, i1* %l27
  %t1093 = load i1, i1* %l27
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
  %t1112 = load i8*, i8** %l24
  %t1113 = load i8*, i8** %l26
  %t1114 = load i1, i1* %l27
  br i1 %t1093, label %then75, label %merge76
then75:
  %t1115 = load i8*, i8** %l26
  %t1116 = call i8* @malloc(i64 7)
  %t1117 = bitcast i8* %t1116 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t1117
  %t1118 = call i8* @strip_prefix(i8* %t1115, i8* %t1116)
  %t1119 = call i8* @trim_text(i8* %t1118)
  store i8* %t1119, i8** %l29
  %t1120 = load i8*, i8** %l29
  %t1121 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t1120)
  store %StructLayoutHeaderParse %t1121, %StructLayoutHeaderParse* %l30
  %t1122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1123 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l30
  %t1124 = extractvalue %StructLayoutHeaderParse %t1123, 4
  %t1125 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1122, { i8**, i64 }* %t1124)
  store { i8**, i64 }* %t1125, { i8**, i64 }** %l0
  %t1126 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l30
  %t1127 = extractvalue %StructLayoutHeaderParse %t1126, 0
  %t1128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1129 = load i8*, i8** %l1
  %t1130 = load i8*, i8** %l2
  %t1131 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1132 = load i8*, i8** %l4
  %t1133 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1134 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1135 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1136 = load %NativeFunction*, %NativeFunction** %l8
  %t1137 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1138 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1139 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1140 = load double, double* %l12
  %t1141 = load double, double* %l13
  %t1142 = load i1, i1* %l14
  %t1143 = load i1, i1* %l15
  %t1144 = load double, double* %l16
  %t1145 = load i8*, i8** %l18
  %t1146 = load i8*, i8** %l24
  %t1147 = load i8*, i8** %l26
  %t1148 = load i1, i1* %l27
  %t1149 = load i8*, i8** %l29
  %t1150 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l30
  br i1 %t1127, label %then77, label %merge78
then77:
  %t1151 = load i1, i1* %l14
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
  %t1170 = load i8*, i8** %l24
  %t1171 = load i8*, i8** %l26
  %t1172 = load i1, i1* %l27
  %t1173 = load i8*, i8** %l29
  %t1174 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l30
  br i1 %t1151, label %then79, label %else80
then79:
  %t1175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1176 = call i8* @malloc(i64 35)
  %t1177 = bitcast i8* %t1176 to [35 x i8]*
  store [35 x i8] c"duplicate struct layout header in \00", [35 x i8]* %t1177
  %t1178 = load i8*, i8** %l4
  %t1179 = call i8* @sailfin_runtime_string_concat(i8* %t1176, i8* %t1178)
  %t1180 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1175, i8* %t1179)
  store { i8**, i64 }* %t1180, { i8**, i64 }** %l0
  %t1181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge81
else80:
  %t1182 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l30
  %t1183 = extractvalue %StructLayoutHeaderParse %t1182, 2
  store double %t1183, double* %l12
  %t1184 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l30
  %t1185 = extractvalue %StructLayoutHeaderParse %t1184, 3
  store double %t1185, double* %l13
  store i1 1, i1* %l14
  %t1186 = load double, double* %l12
  %t1187 = load double, double* %l13
  %t1188 = load i1, i1* %l14
  br label %merge81
merge81:
  %t1189 = phi { i8**, i64 }* [ %t1181, %then79 ], [ %t1152, %else80 ]
  %t1190 = phi double [ %t1164, %then79 ], [ %t1186, %else80 ]
  %t1191 = phi double [ %t1165, %then79 ], [ %t1187, %else80 ]
  %t1192 = phi i1 [ %t1166, %then79 ], [ %t1188, %else80 ]
  store { i8**, i64 }* %t1189, { i8**, i64 }** %l0
  store double %t1190, double* %l12
  store double %t1191, double* %l13
  store i1 %t1192, i1* %l14
  %t1193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1194 = load double, double* %l12
  %t1195 = load double, double* %l13
  %t1196 = load i1, i1* %l14
  br label %merge78
merge78:
  %t1197 = phi { i8**, i64 }* [ %t1193, %merge81 ], [ %t1128, %then75 ]
  %t1198 = phi double [ %t1194, %merge81 ], [ %t1140, %then75 ]
  %t1199 = phi double [ %t1195, %merge81 ], [ %t1141, %then75 ]
  %t1200 = phi i1 [ %t1196, %merge81 ], [ %t1142, %then75 ]
  store { i8**, i64 }* %t1197, { i8**, i64 }** %l0
  store double %t1198, double* %l12
  store double %t1199, double* %l13
  store i1 %t1200, i1* %l14
  %t1201 = load double, double* %l16
  %t1202 = sitofp i64 1 to double
  %t1203 = fadd double %t1201, %t1202
  store double %t1203, double* %l16
  br label %loop.latch4
merge76:
  %t1204 = load i8*, i8** %l26
  %t1205 = load i8*, i8** %l4
  %t1206 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t1204, i8* %t1205)
  store %StructLayoutFieldParse %t1206, %StructLayoutFieldParse* %l31
  %t1207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1208 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l31
  %t1209 = extractvalue %StructLayoutFieldParse %t1208, 2
  %t1210 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t1207, { i8**, i64 }* %t1209)
  store { i8**, i64 }* %t1210, { i8**, i64 }** %l0
  %t1211 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l31
  %t1212 = extractvalue %StructLayoutFieldParse %t1211, 0
  %t1213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1214 = load i8*, i8** %l1
  %t1215 = load i8*, i8** %l2
  %t1216 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1217 = load i8*, i8** %l4
  %t1218 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1219 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1220 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1221 = load %NativeFunction*, %NativeFunction** %l8
  %t1222 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1223 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1224 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1225 = load double, double* %l12
  %t1226 = load double, double* %l13
  %t1227 = load i1, i1* %l14
  %t1228 = load i1, i1* %l15
  %t1229 = load double, double* %l16
  %t1230 = load i8*, i8** %l18
  %t1231 = load i8*, i8** %l24
  %t1232 = load i8*, i8** %l26
  %t1233 = load i1, i1* %l27
  %t1234 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l31
  br i1 %t1212, label %then82, label %merge83
then82:
  %t1235 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1236 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l31
  %t1237 = extractvalue %StructLayoutFieldParse %t1236, 1
  %t1238 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t1235, %NativeStructLayoutField %t1237)
  store { %NativeStructLayoutField*, i64 }* %t1238, { %NativeStructLayoutField*, i64 }** %l11
  %t1239 = load i1, i1* %l14
  %t1240 = xor i1 %t1239, 1
  %t1241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1242 = load i8*, i8** %l1
  %t1243 = load i8*, i8** %l2
  %t1244 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1245 = load i8*, i8** %l4
  %t1246 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1247 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1248 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1249 = load %NativeFunction*, %NativeFunction** %l8
  %t1250 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1251 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1252 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1253 = load double, double* %l12
  %t1254 = load double, double* %l13
  %t1255 = load i1, i1* %l14
  %t1256 = load i1, i1* %l15
  %t1257 = load double, double* %l16
  %t1258 = load i8*, i8** %l18
  %t1259 = load i8*, i8** %l24
  %t1260 = load i8*, i8** %l26
  %t1261 = load i1, i1* %l27
  %t1262 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l31
  br i1 %t1240, label %then84, label %merge85
then84:
  %t1263 = load i1, i1* %l15
  %t1264 = xor i1 %t1263, 1
  %t1265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1266 = load i8*, i8** %l1
  %t1267 = load i8*, i8** %l2
  %t1268 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1269 = load i8*, i8** %l4
  %t1270 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1271 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1272 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1273 = load %NativeFunction*, %NativeFunction** %l8
  %t1274 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1275 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1276 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1277 = load double, double* %l12
  %t1278 = load double, double* %l13
  %t1279 = load i1, i1* %l14
  %t1280 = load i1, i1* %l15
  %t1281 = load double, double* %l16
  %t1282 = load i8*, i8** %l18
  %t1283 = load i8*, i8** %l24
  %t1284 = load i8*, i8** %l26
  %t1285 = load i1, i1* %l27
  %t1286 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l31
  br i1 %t1264, label %then86, label %merge87
then86:
  %t1287 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1288 = call i8* @malloc(i64 8)
  %t1289 = bitcast i8* %t1288 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t1289
  %t1290 = load i8*, i8** %l4
  %t1291 = call i8* @sailfin_runtime_string_concat(i8* %t1288, i8* %t1290)
  %t1292 = call i8* @malloc(i64 47)
  %t1293 = bitcast i8* %t1292 to [47 x i8]*
  store [47 x i8] c" layout field encountered before layout header\00", [47 x i8]* %t1293
  %t1294 = call i8* @sailfin_runtime_string_concat(i8* %t1291, i8* %t1292)
  %t1295 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1287, i8* %t1294)
  store { i8**, i64 }* %t1295, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  %t1296 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1297 = load i1, i1* %l15
  br label %merge87
merge87:
  %t1298 = phi { i8**, i64 }* [ %t1296, %then86 ], [ %t1265, %then84 ]
  %t1299 = phi i1 [ %t1297, %then86 ], [ %t1280, %then84 ]
  store { i8**, i64 }* %t1298, { i8**, i64 }** %l0
  store i1 %t1299, i1* %l15
  %t1300 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1301 = load i1, i1* %l15
  br label %merge85
merge85:
  %t1302 = phi { i8**, i64 }* [ %t1300, %merge87 ], [ %t1241, %then82 ]
  %t1303 = phi i1 [ %t1301, %merge87 ], [ %t1256, %then82 ]
  store { i8**, i64 }* %t1302, { i8**, i64 }** %l0
  store i1 %t1303, i1* %l15
  %t1304 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1305 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1306 = load i1, i1* %l15
  br label %merge83
merge83:
  %t1307 = phi { %NativeStructLayoutField*, i64 }* [ %t1304, %merge85 ], [ %t1224, %merge76 ]
  %t1308 = phi { i8**, i64 }* [ %t1305, %merge85 ], [ %t1213, %merge76 ]
  %t1309 = phi i1 [ %t1306, %merge85 ], [ %t1228, %merge76 ]
  store { %NativeStructLayoutField*, i64 }* %t1307, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t1308, { i8**, i64 }** %l0
  store i1 %t1309, i1* %l15
  %t1310 = load double, double* %l16
  %t1311 = sitofp i64 1 to double
  %t1312 = fadd double %t1310, %t1311
  store double %t1312, double* %l16
  br label %loop.latch4
merge65:
  %t1313 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1314 = call i8* @malloc(i64 38)
  %t1315 = bitcast i8* %t1314 to [38 x i8]*
  store [38 x i8] c"unsupported struct layout directive: \00", [38 x i8]* %t1315
  %t1316 = load i8*, i8** %l18
  %t1317 = call i8* @sailfin_runtime_string_concat(i8* %t1314, i8* %t1316)
  %t1318 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1313, i8* %t1317)
  store { i8**, i64 }* %t1318, { i8**, i64 }** %l0
  %t1319 = load double, double* %l16
  %t1320 = sitofp i64 1 to double
  %t1321 = fadd double %t1319, %t1320
  store double %t1321, double* %l16
  br label %loop.latch4
merge56:
  %t1322 = load i8*, i8** %l18
  %t1323 = call i8* @malloc(i64 5)
  %t1324 = bitcast i8* %t1323 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t1324
  %t1325 = call i1 @strings_equal(i8* %t1322, i8* %t1323)
  %t1326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1327 = load i8*, i8** %l1
  %t1328 = load i8*, i8** %l2
  %t1329 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1330 = load i8*, i8** %l4
  %t1331 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1332 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1333 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1334 = load %NativeFunction*, %NativeFunction** %l8
  %t1335 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1336 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1337 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1338 = load double, double* %l12
  %t1339 = load double, double* %l13
  %t1340 = load i1, i1* %l14
  %t1341 = load i1, i1* %l15
  %t1342 = load double, double* %l16
  %t1343 = load i8*, i8** %l18
  br i1 %t1325, label %then88, label %merge89
then88:
  %t1344 = load double, double* %l16
  %t1345 = sitofp i64 1 to double
  %t1346 = fadd double %t1344, %t1345
  store double %t1346, double* %l16
  br label %loop.latch4
merge89:
  %t1347 = load i8*, i8** %l18
  %t1348 = call i8* @malloc(i64 8)
  %t1349 = bitcast i8* %t1348 to [8 x i8]*
  store [8 x i8] c".field \00", [8 x i8]* %t1349
  %t1350 = call i1 @starts_with(i8* %t1347, i8* %t1348)
  %t1351 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1352 = load i8*, i8** %l1
  %t1353 = load i8*, i8** %l2
  %t1354 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1355 = load i8*, i8** %l4
  %t1356 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1357 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1358 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1359 = load %NativeFunction*, %NativeFunction** %l8
  %t1360 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1361 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1362 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1363 = load double, double* %l12
  %t1364 = load double, double* %l13
  %t1365 = load i1, i1* %l14
  %t1366 = load i1, i1* %l15
  %t1367 = load double, double* %l16
  %t1368 = load i8*, i8** %l18
  br i1 %t1350, label %then90, label %merge91
then90:
  %t1369 = load i8*, i8** %l18
  %t1370 = call i8* @malloc(i64 8)
  %t1371 = bitcast i8* %t1370 to [8 x i8]*
  store [8 x i8] c".field \00", [8 x i8]* %t1371
  %t1372 = call i8* @strip_prefix(i8* %t1369, i8* %t1370)
  %t1373 = call %NativeStructField* @parse_struct_field_line(i8* %t1372)
  store %NativeStructField* %t1373, %NativeStructField** %l32
  %t1374 = load %NativeStructField*, %NativeStructField** %l32
  %t1375 = icmp eq %NativeStructField* %t1374, null
  %t1376 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1377 = load i8*, i8** %l1
  %t1378 = load i8*, i8** %l2
  %t1379 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1380 = load i8*, i8** %l4
  %t1381 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1382 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1383 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1384 = load %NativeFunction*, %NativeFunction** %l8
  %t1385 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1386 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1387 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1388 = load double, double* %l12
  %t1389 = load double, double* %l13
  %t1390 = load i1, i1* %l14
  %t1391 = load i1, i1* %l15
  %t1392 = load double, double* %l16
  %t1393 = load i8*, i8** %l18
  %t1394 = load %NativeStructField*, %NativeStructField** %l32
  br i1 %t1375, label %then92, label %else93
then92:
  %t1395 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1396 = call i8* @malloc(i64 31)
  %t1397 = bitcast i8* %t1396 to [31 x i8]*
  store [31 x i8] c"unable to parse struct field: \00", [31 x i8]* %t1397
  %t1398 = load i8*, i8** %l18
  %t1399 = call i8* @sailfin_runtime_string_concat(i8* %t1396, i8* %t1398)
  %t1400 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1395, i8* %t1399)
  store { i8**, i64 }* %t1400, { i8**, i64 }** %l0
  %t1401 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge94
else93:
  %t1402 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1403 = load %NativeStructField*, %NativeStructField** %l32
  %t1404 = load %NativeStructField, %NativeStructField* %t1403
  %t1405 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1402, %NativeStructField %t1404)
  store { %NativeStructField*, i64 }* %t1405, { %NativeStructField*, i64 }** %l6
  %t1406 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %merge94
merge94:
  %t1407 = phi { i8**, i64 }* [ %t1401, %then92 ], [ %t1376, %else93 ]
  %t1408 = phi { %NativeStructField*, i64 }* [ %t1382, %then92 ], [ %t1406, %else93 ]
  store { i8**, i64 }* %t1407, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1408, { %NativeStructField*, i64 }** %l6
  %t1409 = load double, double* %l16
  %t1410 = sitofp i64 1 to double
  %t1411 = fadd double %t1409, %t1410
  store double %t1411, double* %l16
  br label %loop.latch4
merge91:
  %t1412 = load i8*, i8** %l18
  %t1413 = call i8* @malloc(i64 9)
  %t1414 = bitcast i8* %t1413 to [9 x i8]*
  store [9 x i8] c".method \00", [9 x i8]* %t1414
  %t1415 = call i1 @starts_with(i8* %t1412, i8* %t1413)
  %t1416 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1417 = load i8*, i8** %l1
  %t1418 = load i8*, i8** %l2
  %t1419 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1420 = load i8*, i8** %l4
  %t1421 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1422 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1423 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1424 = load %NativeFunction*, %NativeFunction** %l8
  %t1425 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1426 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1427 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1428 = load double, double* %l12
  %t1429 = load double, double* %l13
  %t1430 = load i1, i1* %l14
  %t1431 = load i1, i1* %l15
  %t1432 = load double, double* %l16
  %t1433 = load i8*, i8** %l18
  br i1 %t1415, label %then95, label %merge96
then95:
  %t1434 = load %NativeFunction*, %NativeFunction** %l8
  %t1435 = icmp ne %NativeFunction* %t1434, null
  %t1436 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1437 = load i8*, i8** %l1
  %t1438 = load i8*, i8** %l2
  %t1439 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1440 = load i8*, i8** %l4
  %t1441 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1442 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1443 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1444 = load %NativeFunction*, %NativeFunction** %l8
  %t1445 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1446 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1447 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1448 = load double, double* %l12
  %t1449 = load double, double* %l13
  %t1450 = load i1, i1* %l14
  %t1451 = load i1, i1* %l15
  %t1452 = load double, double* %l16
  %t1453 = load i8*, i8** %l18
  br i1 %t1435, label %then97, label %merge98
then97:
  %t1454 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1455 = call i8* @malloc(i64 37)
  %t1456 = bitcast i8* %t1455 to [37 x i8]*
  store [37 x i8] c"nested method declaration in struct \00", [37 x i8]* %t1456
  %t1457 = load i8*, i8** %l4
  %t1458 = call i8* @sailfin_runtime_string_concat(i8* %t1455, i8* %t1457)
  %t1459 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1454, i8* %t1458)
  store { i8**, i64 }* %t1459, { i8**, i64 }** %l0
  %t1460 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge98
merge98:
  %t1461 = phi { i8**, i64 }* [ %t1460, %then97 ], [ %t1436, %then95 ]
  store { i8**, i64 }* %t1461, { i8**, i64 }** %l0
  %t1462 = load i8*, i8** %l18
  %t1463 = call i8* @malloc(i64 9)
  %t1464 = bitcast i8* %t1463 to [9 x i8]*
  store [9 x i8] c".method \00", [9 x i8]* %t1464
  %t1465 = call i8* @strip_prefix(i8* %t1462, i8* %t1463)
  %t1466 = call i8* @parse_function_name(i8* %t1465)
  store i8* %t1466, i8** %l33
  %t1467 = load i8*, i8** %l33
  %t1468 = insertvalue %NativeFunction undef, i8* %t1467, 0
  %t1469 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t1470 = ptrtoint [0 x %NativeParameter]* %t1469 to i64
  %t1471 = icmp eq i64 %t1470, 0
  %t1472 = select i1 %t1471, i64 1, i64 %t1470
  %t1473 = call i8* @malloc(i64 %t1472)
  %t1474 = bitcast i8* %t1473 to %NativeParameter*
  %t1475 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t1476 = ptrtoint { %NativeParameter*, i64 }* %t1475 to i64
  %t1477 = call i8* @malloc(i64 %t1476)
  %t1478 = bitcast i8* %t1477 to { %NativeParameter*, i64 }*
  %t1479 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t1478, i32 0, i32 0
  store %NativeParameter* %t1474, %NativeParameter** %t1479
  %t1480 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t1478, i32 0, i32 1
  store i64 0, i64* %t1480
  %t1481 = insertvalue %NativeFunction %t1468, { %NativeParameter*, i64 }* %t1478, 1
  %t1482 = call i8* @malloc(i64 5)
  %t1483 = bitcast i8* %t1482 to [5 x i8]*
  store [5 x i8] c"void\00", [5 x i8]* %t1483
  %t1484 = insertvalue %NativeFunction %t1481, i8* %t1482, 2
  %t1485 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1486 = ptrtoint [0 x i8*]* %t1485 to i64
  %t1487 = icmp eq i64 %t1486, 0
  %t1488 = select i1 %t1487, i64 1, i64 %t1486
  %t1489 = call i8* @malloc(i64 %t1488)
  %t1490 = bitcast i8* %t1489 to i8**
  %t1491 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1492 = ptrtoint { i8**, i64 }* %t1491 to i64
  %t1493 = call i8* @malloc(i64 %t1492)
  %t1494 = bitcast i8* %t1493 to { i8**, i64 }*
  %t1495 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1494, i32 0, i32 0
  store i8** %t1490, i8*** %t1495
  %t1496 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1494, i32 0, i32 1
  store i64 0, i64* %t1496
  %t1497 = insertvalue %NativeFunction %t1484, { i8**, i64 }* %t1494, 3
  %t1498 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t1499 = ptrtoint [0 x %NativeInstruction]* %t1498 to i64
  %t1500 = icmp eq i64 %t1499, 0
  %t1501 = select i1 %t1500, i64 1, i64 %t1499
  %t1502 = call i8* @malloc(i64 %t1501)
  %t1503 = bitcast i8* %t1502 to %NativeInstruction*
  %t1504 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t1505 = ptrtoint { %NativeInstruction*, i64 }* %t1504 to i64
  %t1506 = call i8* @malloc(i64 %t1505)
  %t1507 = bitcast i8* %t1506 to { %NativeInstruction*, i64 }*
  %t1508 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1507, i32 0, i32 0
  store %NativeInstruction* %t1503, %NativeInstruction** %t1508
  %t1509 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1507, i32 0, i32 1
  store i64 0, i64* %t1509
  %t1510 = insertvalue %NativeFunction %t1497, { %NativeInstruction*, i64 }* %t1507, 4
  %t1511 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t1512 = ptrtoint %NativeFunction* %t1511 to i64
  %t1513 = call noalias i8* @malloc(i64 %t1512)
  %t1514 = bitcast i8* %t1513 to %NativeFunction*
  store %NativeFunction %t1510, %NativeFunction* %t1514
  call void @sailfin_runtime_mark_persistent(i8* %t1513)
  store %NativeFunction* %t1514, %NativeFunction** %l8
  %t1515 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1515, %NativeSourceSpan** %l9
  %t1516 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1516, %NativeSourceSpan** %l10
  %t1517 = load double, double* %l16
  %t1518 = sitofp i64 1 to double
  %t1519 = fadd double %t1517, %t1518
  store double %t1519, double* %l16
  br label %loop.latch4
merge96:
  %t1520 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1521 = call i8* @malloc(i64 31)
  %t1522 = bitcast i8* %t1521 to [31 x i8]*
  store [31 x i8] c"unsupported struct directive: \00", [31 x i8]* %t1522
  %t1523 = load i8*, i8** %l18
  %t1524 = call i8* @sailfin_runtime_string_concat(i8* %t1521, i8* %t1523)
  %t1525 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1520, i8* %t1524)
  store { i8**, i64 }* %t1525, { i8**, i64 }** %l0
  %t1526 = load double, double* %l16
  %t1527 = sitofp i64 1 to double
  %t1528 = fadd double %t1526, %t1527
  store double %t1528, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1529 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1530 = load double, double* %l16
  %t1531 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1532 = load %NativeFunction*, %NativeFunction** %l8
  %t1533 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1534 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1535 = load double, double* %l12
  %t1536 = load double, double* %l13
  %t1537 = load i1, i1* %l14
  %t1538 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1539 = load i1, i1* %l15
  %t1540 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1553 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1554 = load double, double* %l16
  %t1555 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1556 = load %NativeFunction*, %NativeFunction** %l8
  %t1557 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1558 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1559 = load double, double* %l12
  %t1560 = load double, double* %l13
  %t1561 = load i1, i1* %l14
  %t1562 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1563 = load i1, i1* %l15
  %t1564 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1565 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1565, %NativeStructLayout** %l34
  %t1566 = load i1, i1* %l14
  %t1567 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1568 = load i8*, i8** %l1
  %t1569 = load i8*, i8** %l2
  %t1570 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1571 = load i8*, i8** %l4
  %t1572 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1573 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1574 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1575 = load %NativeFunction*, %NativeFunction** %l8
  %t1576 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1577 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1578 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1579 = load double, double* %l12
  %t1580 = load double, double* %l13
  %t1581 = load i1, i1* %l14
  %t1582 = load i1, i1* %l15
  %t1583 = load double, double* %l16
  %t1584 = load %NativeStructLayout*, %NativeStructLayout** %l34
  br i1 %t1566, label %then99, label %merge100
then99:
  %t1585 = load double, double* %l12
  %t1586 = insertvalue %NativeStructLayout undef, double %t1585, 0
  %t1587 = load double, double* %l13
  %t1588 = insertvalue %NativeStructLayout %t1586, double %t1587, 1
  %t1589 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1590 = insertvalue %NativeStructLayout %t1588, { %NativeStructLayoutField*, i64 }* %t1589, 2
  %t1591 = getelementptr %NativeStructLayout, %NativeStructLayout* null, i32 1
  %t1592 = ptrtoint %NativeStructLayout* %t1591 to i64
  %t1593 = call noalias i8* @malloc(i64 %t1592)
  %t1594 = bitcast i8* %t1593 to %NativeStructLayout*
  store %NativeStructLayout %t1590, %NativeStructLayout* %t1594
  call void @sailfin_runtime_mark_persistent(i8* %t1593)
  store %NativeStructLayout* %t1594, %NativeStructLayout** %l34
  %t1595 = load %NativeStructLayout*, %NativeStructLayout** %l34
  br label %merge100
merge100:
  %t1596 = phi %NativeStructLayout* [ %t1595, %then99 ], [ %t1584, %afterloop5 ]
  store %NativeStructLayout* %t1596, %NativeStructLayout** %l34
  %t1597 = load i8*, i8** %l4
  %t1598 = insertvalue %NativeStruct undef, i8* %t1597, 0
  %t1599 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1600 = insertvalue %NativeStruct %t1598, { %NativeStructField*, i64 }* %t1599, 1
  %t1601 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1602 = insertvalue %NativeStruct %t1600, { %NativeFunction*, i64 }* %t1601, 2
  %t1603 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1604 = insertvalue %NativeStruct %t1602, { i8**, i64 }* %t1603, 3
  %t1605 = load %NativeStructLayout*, %NativeStructLayout** %l34
  %t1606 = insertvalue %NativeStruct %t1604, %NativeStructLayout* %t1605, 4
  %t1607 = getelementptr %NativeStruct, %NativeStruct* null, i32 1
  %t1608 = ptrtoint %NativeStruct* %t1607 to i64
  %t1609 = call noalias i8* @malloc(i64 %t1608)
  %t1610 = bitcast i8* %t1609 to %NativeStruct*
  store %NativeStruct %t1606, %NativeStruct* %t1610
  call void @sailfin_runtime_mark_persistent(i8* %t1609)
  %t1611 = insertvalue %StructParseResult undef, %NativeStruct* %t1610, 0
  %t1612 = load double, double* %l16
  %t1613 = insertvalue %StructParseResult %t1611, double %t1612, 1
  %t1614 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1615 = insertvalue %StructParseResult %t1613, { i8**, i64 }* %t1614, 2
  ret %StructParseResult %t1615
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
  %t22 = call i8* @malloc(i64 12)
  %t23 = bitcast i8* %t22 to [12 x i8]*
  store [12 x i8] c".interface \00", [12 x i8]* %t23
  %t24 = call i8* @strip_prefix(i8* %t21, i8* %t22)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  %t27 = call %InterfaceHeaderParse @parse_interface_header(i8* %t26)
  store %InterfaceHeaderParse %t27, %InterfaceHeaderParse* %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t30 = extractvalue %InterfaceHeaderParse %t29, 2
  %t31 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t33 = extractvalue %InterfaceHeaderParse %t32, 0
  store i8* %t33, i8** %l4
  %t34 = load i8*, i8** %l4
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load i8*, i8** %l2
  %t40 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t41 = load i8*, i8** %l4
  br i1 %t36, label %then0, label %merge1
then0:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = call i8* @malloc(i64 35)
  %t44 = bitcast i8* %t43 to [35 x i8]*
  store [35 x i8] c"unable to parse interface header: \00", [35 x i8]* %t44
  %t45 = load i8*, i8** %l1
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t45)
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = bitcast i8* null to %NativeInterface*
  %t49 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t48, 0
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %start_index, %t50
  %t52 = insertvalue %InterfaceParseResult %t49, double %t51, 1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = insertvalue %InterfaceParseResult %t52, { i8**, i64 }* %t53, 2
  ret %InterfaceParseResult %t54
merge1:
  %t55 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* null, i32 1
  %t56 = ptrtoint [0 x %NativeInterfaceSignature]* %t55 to i64
  %t57 = icmp eq i64 %t56, 0
  %t58 = select i1 %t57, i64 1, i64 %t56
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to %NativeInterfaceSignature*
  %t61 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t62 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { %NativeInterfaceSignature*, i64 }*
  %t65 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t64, i32 0, i32 0
  store %NativeInterfaceSignature* %t60, %NativeInterfaceSignature** %t65
  %t66 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  store { %NativeInterfaceSignature*, i64 }* %t64, { %NativeInterfaceSignature*, i64 }** %l5
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %start_index, %t67
  store double %t68, double* %l6
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load i8*, i8** %l2
  %t72 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t73 = load i8*, i8** %l4
  %t74 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t75 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t264 = phi { i8**, i64 }* [ %t69, %merge1 ], [ %t261, %loop.latch4 ]
  %t265 = phi double [ %t75, %merge1 ], [ %t262, %loop.latch4 ]
  %t266 = phi { %NativeInterfaceSignature*, i64 }* [ %t74, %merge1 ], [ %t263, %loop.latch4 ]
  store { i8**, i64 }* %t264, { i8**, i64 }** %l0
  store double %t265, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t266, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t76 = load double, double* %l6
  %t77 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t78 = extractvalue { i8**, i64 } %t77, 1
  %t79 = sitofp i64 %t78 to double
  %t80 = fcmp oge double %t76, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load i8*, i8** %l2
  %t84 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t85 = load i8*, i8** %l4
  %t86 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t87 = load double, double* %l6
  br i1 %t80, label %then6, label %merge7
then6:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = call i8* @malloc(i64 24)
  %t90 = bitcast i8* %t89 to [24 x i8]*
  store [24 x i8] c"unterminated interface \00", [24 x i8]* %t90
  %t91 = load i8*, i8** %l4
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t89, i8* %t91)
  %t93 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t88, i8* %t92)
  store { i8**, i64 }* %t93, { i8**, i64 }** %l0
  %t94 = load i8*, i8** %l4
  %t95 = insertvalue %NativeInterface undef, i8* %t94, 0
  %t96 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t97 = extractvalue %InterfaceHeaderParse %t96, 1
  %t98 = insertvalue %NativeInterface %t95, { i8**, i64 }* %t97, 1
  %t99 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t100 = insertvalue %NativeInterface %t98, { %NativeInterfaceSignature*, i64 }* %t99, 2
  %t101 = getelementptr %NativeInterface, %NativeInterface* null, i32 1
  %t102 = ptrtoint %NativeInterface* %t101 to i64
  %t103 = call noalias i8* @malloc(i64 %t102)
  %t104 = bitcast i8* %t103 to %NativeInterface*
  store %NativeInterface %t100, %NativeInterface* %t104
  call void @sailfin_runtime_mark_persistent(i8* %t103)
  %t105 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t104, 0
  %t106 = load double, double* %l6
  %t107 = insertvalue %InterfaceParseResult %t105, double %t106, 1
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = insertvalue %InterfaceParseResult %t107, { i8**, i64 }* %t108, 2
  ret %InterfaceParseResult %t109
merge7:
  %t110 = load double, double* %l6
  %t111 = call double @llvm.round.f64(double %t110)
  %t112 = fptosi double %t111 to i64
  %t113 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t114 = extractvalue { i8**, i64 } %t113, 0
  %t115 = extractvalue { i8**, i64 } %t113, 1
  %t116 = icmp uge i64 %t112, %t115
  ; bounds check: %t116 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t112, i64 %t115)
  %t117 = getelementptr i8*, i8** %t114, i64 %t112
  %t118 = load i8*, i8** %t117
  %t119 = call i8* @trim_text(i8* %t118)
  store i8* %t119, i8** %l7
  %t121 = load i8*, i8** %l7
  %t122 = call i64 @sailfin_runtime_string_length(i8* %t121)
  %t123 = icmp eq i64 %t122, 0
  br label %logical_or_entry_120

logical_or_entry_120:
  br i1 %t123, label %logical_or_merge_120, label %logical_or_right_120

logical_or_right_120:
  %t124 = load i8*, i8** %l7
  %t125 = add i64 0, 2
  %t126 = call i8* @malloc(i64 %t125)
  store i8 59, i8* %t126
  %t127 = getelementptr i8, i8* %t126, i64 1
  store i8 0, i8* %t127
  call void @sailfin_runtime_mark_persistent(i8* %t126)
  %t128 = call i1 @starts_with(i8* %t124, i8* %t126)
  br label %logical_or_right_end_120

logical_or_right_end_120:
  br label %logical_or_merge_120

logical_or_merge_120:
  %t129 = phi i1 [ true, %logical_or_entry_120 ], [ %t128, %logical_or_right_end_120 ]
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load i8*, i8** %l1
  %t132 = load i8*, i8** %l2
  %t133 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t134 = load i8*, i8** %l4
  %t135 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t136 = load double, double* %l6
  %t137 = load i8*, i8** %l7
  br i1 %t129, label %then8, label %merge9
then8:
  %t138 = load double, double* %l6
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l6
  br label %loop.latch4
merge9:
  %t141 = load i8*, i8** %l7
  %t142 = call i8* @malloc(i64 14)
  %t143 = bitcast i8* %t142 to [14 x i8]*
  store [14 x i8] c".endinterface\00", [14 x i8]* %t143
  %t144 = call i1 @strings_equal(i8* %t141, i8* %t142)
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load i8*, i8** %l1
  %t147 = load i8*, i8** %l2
  %t148 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t149 = load i8*, i8** %l4
  %t150 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t151 = load double, double* %l6
  %t152 = load i8*, i8** %l7
  br i1 %t144, label %then10, label %merge11
then10:
  %t153 = load double, double* %l6
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l6
  br label %afterloop5
merge11:
  %t156 = load i8*, i8** %l7
  %t157 = call i8* @malloc(i64 5)
  %t158 = bitcast i8* %t157 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t158
  %t159 = call i1 @strings_equal(i8* %t156, i8* %t157)
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load i8*, i8** %l1
  %t162 = load i8*, i8** %l2
  %t163 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t164 = load i8*, i8** %l4
  %t165 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t166 = load double, double* %l6
  %t167 = load i8*, i8** %l7
  br i1 %t159, label %then12, label %merge13
then12:
  %t168 = load double, double* %l6
  %t169 = sitofp i64 1 to double
  %t170 = fadd double %t168, %t169
  store double %t170, double* %l6
  br label %loop.latch4
merge13:
  %t171 = load i8*, i8** %l7
  %t172 = call i8* @malloc(i64 6)
  %t173 = bitcast i8* %t172 to [6 x i8]*
  store [6 x i8] c".sig \00", [6 x i8]* %t173
  %t174 = call i1 @starts_with(i8* %t171, i8* %t172)
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t176 = load i8*, i8** %l1
  %t177 = load i8*, i8** %l2
  %t178 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t179 = load i8*, i8** %l4
  %t180 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t181 = load double, double* %l6
  %t182 = load i8*, i8** %l7
  br i1 %t174, label %then14, label %merge15
then14:
  %t183 = load i8*, i8** %l7
  %t184 = call i8* @malloc(i64 6)
  %t185 = bitcast i8* %t184 to [6 x i8]*
  store [6 x i8] c".sig \00", [6 x i8]* %t185
  %t186 = call i8* @strip_prefix(i8* %t183, i8* %t184)
  %t187 = load i8*, i8** %l4
  %t188 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t186, i8* %t187)
  store %InterfaceSignatureParse %t188, %InterfaceSignatureParse* %l8
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t191 = extractvalue %InterfaceSignatureParse %t190, 2
  %t192 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t189, { i8**, i64 }* %t191)
  store { i8**, i64 }* %t192, { i8**, i64 }** %l0
  %t193 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t194 = extractvalue %InterfaceSignatureParse %t193, 0
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t196 = load i8*, i8** %l1
  %t197 = load i8*, i8** %l2
  %t198 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t199 = load i8*, i8** %l4
  %t200 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t201 = load double, double* %l6
  %t202 = load i8*, i8** %l7
  %t203 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t194, label %then16, label %merge17
then16:
  %t204 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t205 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t206 = extractvalue %InterfaceSignatureParse %t205, 1
  %t207 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* null, i32 1
  %t208 = ptrtoint [1 x %NativeInterfaceSignature]* %t207 to i64
  %t209 = icmp eq i64 %t208, 0
  %t210 = select i1 %t209, i64 1, i64 %t208
  %t211 = call i8* @malloc(i64 %t210)
  %t212 = bitcast i8* %t211 to %NativeInterfaceSignature*
  %t213 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t212, i64 0
  store %NativeInterfaceSignature %t206, %NativeInterfaceSignature* %t213
  %t214 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t215 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t214 to i64
  %t216 = call i8* @malloc(i64 %t215)
  %t217 = bitcast i8* %t216 to { %NativeInterfaceSignature*, i64 }*
  %t218 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t217, i32 0, i32 0
  store %NativeInterfaceSignature* %t212, %NativeInterfaceSignature** %t218
  %t219 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t217, i32 0, i32 1
  store i64 1, i64* %t219
  %t220 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t204, i32 0, i32 0
  %t221 = load %NativeInterfaceSignature*, %NativeInterfaceSignature** %t220
  %t222 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t204, i32 0, i32 1
  %t223 = load i64, i64* %t222
  %t224 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t217, i32 0, i32 0
  %t225 = load %NativeInterfaceSignature*, %NativeInterfaceSignature** %t224
  %t226 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t217, i32 0, i32 1
  %t227 = load i64, i64* %t226
  %t228 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* null, i32 0, i32 1
  %t229 = ptrtoint %NativeInterfaceSignature* %t228 to i64
  %t230 = add i64 %t223, %t227
  %t231 = mul i64 %t229, %t230
  %t232 = call noalias i8* @malloc(i64 %t231)
  %t233 = bitcast i8* %t232 to %NativeInterfaceSignature*
  %t234 = bitcast %NativeInterfaceSignature* %t233 to i8*
  %t235 = mul i64 %t229, %t223
  %t236 = bitcast %NativeInterfaceSignature* %t221 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t234, i8* %t236, i64 %t235)
  %t237 = mul i64 %t229, %t227
  %t238 = bitcast %NativeInterfaceSignature* %t225 to i8*
  %t239 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t233, i64 %t223
  %t240 = bitcast %NativeInterfaceSignature* %t239 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t240, i8* %t238, i64 %t237)
  %t241 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t242 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t241 to i64
  %t243 = call i8* @malloc(i64 %t242)
  %t244 = bitcast i8* %t243 to { %NativeInterfaceSignature*, i64 }*
  %t245 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t244, i32 0, i32 0
  store %NativeInterfaceSignature* %t233, %NativeInterfaceSignature** %t245
  %t246 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t244, i32 0, i32 1
  store i64 %t230, i64* %t246
  store { %NativeInterfaceSignature*, i64 }* %t244, { %NativeInterfaceSignature*, i64 }** %l5
  %t247 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t248 = phi { %NativeInterfaceSignature*, i64 }* [ %t247, %then16 ], [ %t200, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t248, { %NativeInterfaceSignature*, i64 }** %l5
  %t249 = load double, double* %l6
  %t250 = sitofp i64 1 to double
  %t251 = fadd double %t249, %t250
  store double %t251, double* %l6
  br label %loop.latch4
merge15:
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t253 = call i8* @malloc(i64 34)
  %t254 = bitcast i8* %t253 to [34 x i8]*
  store [34 x i8] c"unsupported interface directive: \00", [34 x i8]* %t254
  %t255 = load i8*, i8** %l7
  %t256 = call i8* @sailfin_runtime_string_concat(i8* %t253, i8* %t255)
  %t257 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t252, i8* %t256)
  store { i8**, i64 }* %t257, { i8**, i64 }** %l0
  %t258 = load double, double* %l6
  %t259 = sitofp i64 1 to double
  %t260 = fadd double %t258, %t259
  store double %t260, double* %l6
  br label %loop.latch4
loop.latch4:
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load double, double* %l6
  %t263 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load double, double* %l6
  %t269 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t270 = load i8*, i8** %l4
  %t271 = insertvalue %NativeInterface undef, i8* %t270, 0
  %t272 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t273 = extractvalue %InterfaceHeaderParse %t272, 1
  %t274 = insertvalue %NativeInterface %t271, { i8**, i64 }* %t273, 1
  %t275 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t276 = insertvalue %NativeInterface %t274, { %NativeInterfaceSignature*, i64 }* %t275, 2
  %t277 = getelementptr %NativeInterface, %NativeInterface* null, i32 1
  %t278 = ptrtoint %NativeInterface* %t277 to i64
  %t279 = call noalias i8* @malloc(i64 %t278)
  %t280 = bitcast i8* %t279 to %NativeInterface*
  store %NativeInterface %t276, %NativeInterface* %t280
  call void @sailfin_runtime_mark_persistent(i8* %t279)
  %t281 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t280, 0
  %t282 = load double, double* %l6
  %t283 = insertvalue %InterfaceParseResult %t281, double %t282, 1
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t285 = insertvalue %InterfaceParseResult %t283, { i8**, i64 }* %t284, 2
  ret %InterfaceParseResult %t285
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
  %t24 = call i8* @malloc(i64 12)
  %t25 = bitcast i8* %t24 to [12 x i8]*
  store [12 x i8] c"implements \00", [12 x i8]* %t25
  %t26 = call i1 @starts_with(i8* %t23, i8* %t24)
  %t27 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t26, label %then2, label %else3
then2:
  %t30 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t31 = extractvalue %HeaderNameParse %t30, 2
  %t32 = call i8* @malloc(i64 12)
  %t33 = bitcast i8* %t32 to [12 x i8]*
  store [12 x i8] c"implements \00", [12 x i8]* %t33
  %t34 = call i8* @strip_prefix(i8* %t31, i8* %t32)
  %t35 = call i8* @trim_text(i8* %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t42 = load i8*, i8** %l3
  br i1 %t38, label %then5, label %else6
then5:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = call i8* @malloc(i64 8)
  %t45 = bitcast i8* %t44 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t45
  %t46 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t47 = extractvalue %HeaderNameParse %t46, 0
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t47)
  %t49 = call i8* @malloc(i64 32)
  %t50 = bitcast i8* %t49 to [32 x i8]*
  store [32 x i8] c" header missing implements list\00", [32 x i8]* %t50
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t49)
  %t52 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t51)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
else6:
  %t54 = load i8*, i8** %l3
  %t55 = call { i8**, i64 }* @parse_implements_list(i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l2
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge7
merge7:
  %t57 = phi { i8**, i64 }* [ %t53, %then5 ], [ %t40, %else6 ]
  %t58 = phi { i8**, i64 }* [ %t41, %then5 ], [ %t56, %else6 ]
  store { i8**, i64 }* %t57, { i8**, i64 }** %l1
  store { i8**, i64 }* %t58, { i8**, i64 }** %l2
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge4
else3:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = call i8* @malloc(i64 8)
  %t63 = bitcast i8* %t62 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t63
  %t64 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t65 = extractvalue %HeaderNameParse %t64, 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t65)
  %t67 = call i8* @malloc(i64 34)
  %t68 = bitcast i8* %t67 to [34 x i8]*
  store [34 x i8] c" header has unsupported segment `\00", [34 x i8]* %t68
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t67)
  %t70 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t71 = extractvalue %HeaderNameParse %t70, 2
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t71)
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 96, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t72, i8* %t74)
  %t77 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t61, i8* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t79 = phi { i8**, i64 }* [ %t59, %merge7 ], [ %t78, %else3 ]
  %t80 = phi { i8**, i64 }* [ %t60, %merge7 ], [ %t29, %else3 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l2
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t84 = phi { i8**, i64 }* [ %t81, %merge4 ], [ %t20, %block.entry ]
  %t85 = phi { i8**, i64 }* [ %t82, %merge4 ], [ %t21, %block.entry ]
  %t86 = phi { i8**, i64 }* [ %t83, %merge4 ], [ %t20, %block.entry ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  store { i8**, i64 }* %t85, { i8**, i64 }** %l2
  store { i8**, i64 }* %t86, { i8**, i64 }** %l1
  %t87 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t88 = extractvalue %HeaderNameParse %t87, 0
  %t89 = insertvalue %StructHeaderParse undef, i8* %t88, 0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t91 = insertvalue %StructHeaderParse %t89, { i8**, i64 }* %t90, 1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = insertvalue %StructHeaderParse %t91, { i8**, i64 }* %t92, 2
  ret %StructHeaderParse %t93
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
  %t10 = call i8* @malloc(i64 11)
  %t11 = bitcast i8* %t10 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t11
  %t12 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t13 = extractvalue %HeaderNameParse %t12, 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t13)
  %t15 = call i8* @malloc(i64 34)
  %t16 = bitcast i8* %t15 to [34 x i8]*
  store [34 x i8] c" header has unsupported segment `\00", [34 x i8]* %t16
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %t15)
  %t18 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t19 = extractvalue %HeaderNameParse %t18, 2
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %t17, i8* %t19)
  %t21 = add i64 0, 2
  %t22 = call i8* @malloc(i64 %t21)
  store i8 96, i8* %t22
  %t23 = getelementptr i8, i8* %t22, i64 1
  store i8 0, i8* %t23
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %t22)
  %t25 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l1
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t27 = phi { i8**, i64 }* [ %t26, %then0 ], [ %t8, %block.entry ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t29 = extractvalue %HeaderNameParse %t28, 0
  %t30 = insertvalue %InterfaceHeaderParse undef, i8* %t29, 0
  %t31 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t32 = extractvalue %HeaderNameParse %t31, 1
  %t33 = insertvalue %InterfaceHeaderParse %t30, { i8**, i64 }* %t32, 1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = insertvalue %InterfaceHeaderParse %t33, { i8**, i64 }* %t34, 2
  ret %InterfaceHeaderParse %t35
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  %t14 = insertvalue %NativeInterfaceSignature undef, i8* %t12, 0
  %t15 = insertvalue %NativeInterfaceSignature %t14, i1 0, 1
  %t16 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t17 = ptrtoint [0 x i8*]* %t16 to i64
  %t18 = icmp eq i64 %t17, 0
  %t19 = select i1 %t18, i64 1, i64 %t17
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to i8**
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t23 = ptrtoint { i8**, i64 }* %t22 to i64
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to { i8**, i64 }*
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 0
  store i8** %t21, i8*** %t26
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  %t28 = insertvalue %NativeInterfaceSignature %t15, { i8**, i64 }* %t25, 2
  %t29 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t30 = ptrtoint [0 x %NativeParameter]* %t29 to i64
  %t31 = icmp eq i64 %t30, 0
  %t32 = select i1 %t31, i64 1, i64 %t30
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to %NativeParameter*
  %t35 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t36 = ptrtoint { %NativeParameter*, i64 }* %t35 to i64
  %t37 = call i8* @malloc(i64 %t36)
  %t38 = bitcast i8* %t37 to { %NativeParameter*, i64 }*
  %t39 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t38, i32 0, i32 0
  store %NativeParameter* %t34, %NativeParameter** %t39
  %t40 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  %t41 = insertvalue %NativeInterfaceSignature %t28, { %NativeParameter*, i64 }* %t38, 3
  %t42 = call i8* @malloc(i64 5)
  %t43 = bitcast i8* %t42 to [5 x i8]*
  store [5 x i8] c"void\00", [5 x i8]* %t43
  %t44 = insertvalue %NativeInterfaceSignature %t41, i8* %t42, 4
  %t45 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t46 = ptrtoint [0 x i8*]* %t45 to i64
  %t47 = icmp eq i64 %t46, 0
  %t48 = select i1 %t47, i64 1, i64 %t46
  %t49 = call i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to i8**
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t52 = ptrtoint { i8**, i64 }* %t51 to i64
  %t53 = call i8* @malloc(i64 %t52)
  %t54 = bitcast i8* %t53 to { i8**, i64 }*
  %t55 = getelementptr { i8**, i64 }, { i8**, i64 }* %t54, i32 0, i32 0
  store i8** %t50, i8*** %t55
  %t56 = getelementptr { i8**, i64 }, { i8**, i64 }* %t54, i32 0, i32 1
  store i64 0, i64* %t56
  %t57 = insertvalue %NativeInterfaceSignature %t44, { i8**, i64 }* %t54, 5
  store %NativeInterfaceSignature %t57, %NativeInterfaceSignature* %l1
  %t58 = call i8* @trim_text(i8* %text)
  %t59 = call i8* @trim_trailing_delimiters(i8* %t58)
  store i8* %t59, i8** %l2
  %t60 = load i8*, i8** %l2
  %t61 = call i64 @sailfin_runtime_string_length(i8* %t60)
  %t62 = icmp eq i64 %t61, 0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t65 = load i8*, i8** %l2
  br i1 %t62, label %then0, label %merge1
then0:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = call i8* @malloc(i64 11)
  %t68 = bitcast i8* %t67 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t68
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %interface_name)
  %t70 = call i8* @malloc(i64 27)
  %t71 = bitcast i8* %t70 to [27 x i8]*
  store [27 x i8] c" signature missing content\00", [27 x i8]* %t71
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t70)
  %t73 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  %t74 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t75 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t76 = insertvalue %InterfaceSignatureParse %t74, %NativeInterfaceSignature %t75, 1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = insertvalue %InterfaceSignatureParse %t76, { i8**, i64 }* %t77, 2
  ret %InterfaceSignatureParse %t78
merge1:
  %t79 = load i8*, i8** %l2
  store i8* %t79, i8** %l3
  store i1 0, i1* %l4
  %t80 = load i8*, i8** %l3
  %t81 = call i8* @malloc(i64 7)
  %t82 = bitcast i8* %t81 to [7 x i8]*
  store [7 x i8] c"async \00", [7 x i8]* %t82
  %t83 = call i1 @starts_with(i8* %t80, i8* %t81)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t86 = load i8*, i8** %l2
  %t87 = load i8*, i8** %l3
  %t88 = load i1, i1* %l4
  br i1 %t83, label %then2, label %merge3
then2:
  store i1 1, i1* %l4
  %t89 = load i8*, i8** %l3
  %t90 = call i8* @malloc(i64 7)
  %t91 = bitcast i8* %t90 to [7 x i8]*
  store [7 x i8] c"async \00", [7 x i8]* %t91
  %t92 = call i8* @strip_prefix(i8* %t89, i8* %t90)
  %t93 = call i8* @trim_text(i8* %t92)
  store i8* %t93, i8** %l3
  %t94 = load i1, i1* %l4
  %t95 = load i8*, i8** %l3
  br label %merge3
merge3:
  %t96 = phi i1 [ %t94, %then2 ], [ %t88, %merge1 ]
  %t97 = phi i8* [ %t95, %then2 ], [ %t87, %merge1 ]
  store i1 %t96, i1* %l4
  store i8* %t97, i8** %l3
  %t98 = load i8*, i8** %l3
  %t99 = add i64 0, 2
  %t100 = call i8* @malloc(i64 %t99)
  store i8 40, i8* %t100
  %t101 = getelementptr i8, i8* %t100, i64 1
  store i8 0, i8* %t101
  call void @sailfin_runtime_mark_persistent(i8* %t100)
  %t102 = call double @index_of(i8* %t98, i8* %t100)
  store double %t102, double* %l5
  %t103 = load double, double* %l5
  %t104 = sitofp i64 0 to double
  %t105 = fcmp olt double %t103, %t104
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t108 = load i8*, i8** %l2
  %t109 = load i8*, i8** %l3
  %t110 = load i1, i1* %l4
  %t111 = load double, double* %l5
  br i1 %t105, label %then4, label %merge5
then4:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = call i8* @malloc(i64 11)
  %t114 = bitcast i8* %t113 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t114
  %t115 = call i8* @sailfin_runtime_string_concat(i8* %t113, i8* %interface_name)
  %t116 = call i8* @malloc(i64 36)
  %t117 = bitcast i8* %t116 to [36 x i8]*
  store [36 x i8] c" signature missing parameter list: \00", [36 x i8]* %t117
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t115, i8* %t116)
  %t119 = load i8*, i8** %l2
  %t120 = call i8* @sailfin_runtime_string_concat(i8* %t118, i8* %t119)
  %t121 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t112, i8* %t120)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l0
  %t122 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t123 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t124 = insertvalue %InterfaceSignatureParse %t122, %NativeInterfaceSignature %t123, 1
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = insertvalue %InterfaceSignatureParse %t124, { i8**, i64 }* %t125, 2
  ret %InterfaceSignatureParse %t126
merge5:
  %t127 = load i8*, i8** %l3
  %t128 = load double, double* %l5
  %t129 = call double @find_matching_paren(i8* %t127, double %t128)
  store double %t129, double* %l6
  %t130 = load double, double* %l6
  %t131 = sitofp i64 0 to double
  %t132 = fcmp olt double %t130, %t131
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t135 = load i8*, i8** %l2
  %t136 = load i8*, i8** %l3
  %t137 = load i1, i1* %l4
  %t138 = load double, double* %l5
  %t139 = load double, double* %l6
  br i1 %t132, label %then6, label %merge7
then6:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = call i8* @malloc(i64 11)
  %t142 = bitcast i8* %t141 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t142
  %t143 = call i8* @sailfin_runtime_string_concat(i8* %t141, i8* %interface_name)
  %t144 = call i8* @malloc(i64 45)
  %t145 = bitcast i8* %t144 to [45 x i8]*
  store [45 x i8] c" signature has unterminated parameter list: \00", [45 x i8]* %t145
  %t146 = call i8* @sailfin_runtime_string_concat(i8* %t143, i8* %t144)
  %t147 = load i8*, i8** %l2
  %t148 = call i8* @sailfin_runtime_string_concat(i8* %t146, i8* %t147)
  %t149 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t140, i8* %t148)
  store { i8**, i64 }* %t149, { i8**, i64 }** %l0
  %t150 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t151 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t152 = insertvalue %InterfaceSignatureParse %t150, %NativeInterfaceSignature %t151, 1
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = insertvalue %InterfaceSignatureParse %t152, { i8**, i64 }* %t153, 2
  ret %InterfaceSignatureParse %t154
merge7:
  %t155 = load i8*, i8** %l3
  %t156 = load double, double* %l5
  %t157 = call double @llvm.round.f64(double %t156)
  %t158 = fptosi double %t157 to i64
  %t159 = call i8* @sailfin_runtime_substring(i8* %t155, i64 0, i64 %t158)
  %t160 = call i8* @trim_text(i8* %t159)
  store i8* %t160, i8** %l7
  %t161 = load i8*, i8** %l7
  %t162 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t161)
  store %HeaderNameParse %t162, %HeaderNameParse* %l8
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t165 = extractvalue %HeaderNameParse %t164, 3
  %t166 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t163, { i8**, i64 }* %t165)
  store { i8**, i64 }* %t166, { i8**, i64 }** %l0
  %t167 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t168 = extractvalue %HeaderNameParse %t167, 2
  %t169 = call i64 @sailfin_runtime_string_length(i8* %t168)
  %t170 = icmp sgt i64 %t169, 0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t173 = load i8*, i8** %l2
  %t174 = load i8*, i8** %l3
  %t175 = load i1, i1* %l4
  %t176 = load double, double* %l5
  %t177 = load double, double* %l6
  %t178 = load i8*, i8** %l7
  %t179 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t170, label %then8, label %merge9
then8:
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = call i8* @malloc(i64 11)
  %t182 = bitcast i8* %t181 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t182
  %t183 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %interface_name)
  %t184 = call i8* @malloc(i64 13)
  %t185 = bitcast i8* %t184 to [13 x i8]*
  store [13 x i8] c" signature `\00", [13 x i8]* %t185
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t183, i8* %t184)
  %t187 = load i8*, i8** %l2
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t186, i8* %t187)
  %t189 = call i8* @malloc(i64 28)
  %t190 = bitcast i8* %t189 to [28 x i8]*
  store [28 x i8] c"` has unsupported segment `\00", [28 x i8]* %t190
  %t191 = call i8* @sailfin_runtime_string_concat(i8* %t188, i8* %t189)
  %t192 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t193 = extractvalue %HeaderNameParse %t192, 2
  %t194 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t193)
  %t195 = add i64 0, 2
  %t196 = call i8* @malloc(i64 %t195)
  store i8 96, i8* %t196
  %t197 = getelementptr i8, i8* %t196, i64 1
  store i8 0, i8* %t197
  call void @sailfin_runtime_mark_persistent(i8* %t196)
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %t194, i8* %t196)
  %t199 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t180, i8* %t198)
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t201 = phi { i8**, i64 }* [ %t200, %then8 ], [ %t171, %merge7 ]
  store { i8**, i64 }* %t201, { i8**, i64 }** %l0
  %t202 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t203 = extractvalue %HeaderNameParse %t202, 0
  store i8* %t203, i8** %l9
  %t204 = load i8*, i8** %l9
  %t205 = call i64 @sailfin_runtime_string_length(i8* %t204)
  %t206 = icmp eq i64 %t205, 0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t209 = load i8*, i8** %l2
  %t210 = load i8*, i8** %l3
  %t211 = load i1, i1* %l4
  %t212 = load double, double* %l5
  %t213 = load double, double* %l6
  %t214 = load i8*, i8** %l7
  %t215 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t216 = load i8*, i8** %l9
  br i1 %t206, label %then10, label %merge11
then10:
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = call i8* @malloc(i64 11)
  %t219 = bitcast i8* %t218 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t219
  %t220 = call i8* @sailfin_runtime_string_concat(i8* %t218, i8* %interface_name)
  %t221 = call i8* @malloc(i64 13)
  %t222 = bitcast i8* %t221 to [13 x i8]*
  store [13 x i8] c" signature `\00", [13 x i8]* %t222
  %t223 = call i8* @sailfin_runtime_string_concat(i8* %t220, i8* %t221)
  %t224 = load i8*, i8** %l2
  %t225 = call i8* @sailfin_runtime_string_concat(i8* %t223, i8* %t224)
  %t226 = call i8* @malloc(i64 15)
  %t227 = bitcast i8* %t226 to [15 x i8]*
  store [15 x i8] c"` missing name\00", [15 x i8]* %t227
  %t228 = call i8* @sailfin_runtime_string_concat(i8* %t225, i8* %t226)
  %t229 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t217, i8* %t228)
  store { i8**, i64 }* %t229, { i8**, i64 }** %l0
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t231 = phi { i8**, i64 }* [ %t230, %then10 ], [ %t207, %merge9 ]
  store { i8**, i64 }* %t231, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l3
  %t233 = load double, double* %l5
  %t234 = sitofp i64 1 to double
  %t235 = fadd double %t233, %t234
  %t236 = load double, double* %l6
  %t237 = call double @llvm.round.f64(double %t235)
  %t238 = fptosi double %t237 to i64
  %t239 = call double @llvm.round.f64(double %t236)
  %t240 = fptosi double %t239 to i64
  %t241 = call i8* @sailfin_runtime_substring(i8* %t232, i64 %t238, i64 %t240)
  store i8* %t241, i8** %l10
  %t242 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t243 = ptrtoint [0 x %NativeParameter]* %t242 to i64
  %t244 = icmp eq i64 %t243, 0
  %t245 = select i1 %t244, i64 1, i64 %t243
  %t246 = call i8* @malloc(i64 %t245)
  %t247 = bitcast i8* %t246 to %NativeParameter*
  %t248 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t249 = ptrtoint { %NativeParameter*, i64 }* %t248 to i64
  %t250 = call i8* @malloc(i64 %t249)
  %t251 = bitcast i8* %t250 to { %NativeParameter*, i64 }*
  %t252 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t251, i32 0, i32 0
  store %NativeParameter* %t247, %NativeParameter** %t252
  %t253 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t251, i32 0, i32 1
  store i64 0, i64* %t253
  store { %NativeParameter*, i64 }* %t251, { %NativeParameter*, i64 }** %l11
  %t254 = load i8*, i8** %l10
  %t255 = call i8* @trim_text(i8* %t254)
  store i8* %t255, i8** %l12
  %t256 = load i8*, i8** %l12
  %t257 = call i64 @sailfin_runtime_string_length(i8* %t256)
  %t258 = icmp sgt i64 %t257, 0
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
  br i1 %t258, label %then12, label %merge13
then12:
  %t272 = load i8*, i8** %l12
  %t273 = call { i8**, i64 }* @split_parameter_entries(i8* %t272)
  store { i8**, i64 }* %t273, { i8**, i64 }** %l13
  %t274 = sitofp i64 0 to double
  store double %t274, double* %l14
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t276 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t277 = load i8*, i8** %l2
  %t278 = load i8*, i8** %l3
  %t279 = load i1, i1* %l4
  %t280 = load double, double* %l5
  %t281 = load double, double* %l6
  %t282 = load i8*, i8** %l7
  %t283 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t284 = load i8*, i8** %l9
  %t285 = load i8*, i8** %l10
  %t286 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t287 = load i8*, i8** %l12
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t289 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t383 = phi { i8**, i64 }* [ %t275, %then12 ], [ %t380, %loop.latch16 ]
  %t384 = phi { %NativeParameter*, i64 }* [ %t286, %then12 ], [ %t381, %loop.latch16 ]
  %t385 = phi double [ %t289, %then12 ], [ %t382, %loop.latch16 ]
  store { i8**, i64 }* %t383, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t384, { %NativeParameter*, i64 }** %l11
  store double %t385, double* %l14
  br label %loop.body15
loop.body15:
  %t290 = load double, double* %l14
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t292 = load { i8**, i64 }, { i8**, i64 }* %t291
  %t293 = extractvalue { i8**, i64 } %t292, 1
  %t294 = sitofp i64 %t293 to double
  %t295 = fcmp oge double %t290, %t294
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t297 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t298 = load i8*, i8** %l2
  %t299 = load i8*, i8** %l3
  %t300 = load i1, i1* %l4
  %t301 = load double, double* %l5
  %t302 = load double, double* %l6
  %t303 = load i8*, i8** %l7
  %t304 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t305 = load i8*, i8** %l9
  %t306 = load i8*, i8** %l10
  %t307 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t308 = load i8*, i8** %l12
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t310 = load double, double* %l14
  br i1 %t295, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t312 = load double, double* %l14
  %t313 = call double @llvm.round.f64(double %t312)
  %t314 = fptosi double %t313 to i64
  %t315 = load { i8**, i64 }, { i8**, i64 }* %t311
  %t316 = extractvalue { i8**, i64 } %t315, 0
  %t317 = extractvalue { i8**, i64 } %t315, 1
  %t318 = icmp uge i64 %t314, %t317
  ; bounds check: %t318 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t314, i64 %t317)
  %t319 = getelementptr i8*, i8** %t316, i64 %t314
  %t320 = load i8*, i8** %t319
  %t321 = bitcast i8* null to %NativeSourceSpan*
  %t322 = call %NativeParameter* @parse_parameter_entry(i8* %t320, %NativeSourceSpan* %t321)
  store %NativeParameter* %t322, %NativeParameter** %l15
  %t323 = load %NativeParameter*, %NativeParameter** %l15
  %t324 = icmp eq %NativeParameter* %t323, null
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t326 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t327 = load i8*, i8** %l2
  %t328 = load i8*, i8** %l3
  %t329 = load i1, i1* %l4
  %t330 = load double, double* %l5
  %t331 = load double, double* %l6
  %t332 = load i8*, i8** %l7
  %t333 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t334 = load i8*, i8** %l9
  %t335 = load i8*, i8** %l10
  %t336 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t337 = load i8*, i8** %l12
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t339 = load double, double* %l14
  %t340 = load %NativeParameter*, %NativeParameter** %l15
  br i1 %t324, label %then20, label %else21
then20:
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t342 = call i8* @malloc(i64 11)
  %t343 = bitcast i8* %t342 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t343
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %t342, i8* %interface_name)
  %t345 = call i8* @malloc(i64 13)
  %t346 = bitcast i8* %t345 to [13 x i8]*
  store [13 x i8] c" signature `\00", [13 x i8]* %t346
  %t347 = call i8* @sailfin_runtime_string_concat(i8* %t344, i8* %t345)
  %t348 = load i8*, i8** %l9
  %t349 = call i8* @sailfin_runtime_string_concat(i8* %t347, i8* %t348)
  %t350 = call i8* @malloc(i64 26)
  %t351 = bitcast i8* %t350 to [26 x i8]*
  store [26 x i8] c"` has invalid parameter `\00", [26 x i8]* %t351
  %t352 = call i8* @sailfin_runtime_string_concat(i8* %t349, i8* %t350)
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t354 = load double, double* %l14
  %t355 = call double @llvm.round.f64(double %t354)
  %t356 = fptosi double %t355 to i64
  %t357 = load { i8**, i64 }, { i8**, i64 }* %t353
  %t358 = extractvalue { i8**, i64 } %t357, 0
  %t359 = extractvalue { i8**, i64 } %t357, 1
  %t360 = icmp uge i64 %t356, %t359
  ; bounds check: %t360 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t356, i64 %t359)
  %t361 = getelementptr i8*, i8** %t358, i64 %t356
  %t362 = load i8*, i8** %t361
  %t363 = call i8* @sailfin_runtime_string_concat(i8* %t352, i8* %t362)
  %t364 = add i64 0, 2
  %t365 = call i8* @malloc(i64 %t364)
  store i8 96, i8* %t365
  %t366 = getelementptr i8, i8* %t365, i64 1
  store i8 0, i8* %t366
  call void @sailfin_runtime_mark_persistent(i8* %t365)
  %t367 = call i8* @sailfin_runtime_string_concat(i8* %t363, i8* %t365)
  %t368 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t341, i8* %t367)
  store { i8**, i64 }* %t368, { i8**, i64 }** %l0
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
else21:
  %t370 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t371 = load %NativeParameter*, %NativeParameter** %l15
  %t372 = load %NativeParameter, %NativeParameter* %t371
  %t373 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t370, %NativeParameter %t372)
  store { %NativeParameter*, i64 }* %t373, { %NativeParameter*, i64 }** %l11
  %t374 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge22
merge22:
  %t375 = phi { i8**, i64 }* [ %t369, %then20 ], [ %t325, %else21 ]
  %t376 = phi { %NativeParameter*, i64 }* [ %t336, %then20 ], [ %t374, %else21 ]
  store { i8**, i64 }* %t375, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t376, { %NativeParameter*, i64 }** %l11
  %t377 = load double, double* %l14
  %t378 = sitofp i64 1 to double
  %t379 = fadd double %t377, %t378
  store double %t379, double* %l14
  br label %loop.latch16
loop.latch16:
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t382 = load double, double* %l14
  br label %loop.header14
afterloop17:
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t387 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t388 = load double, double* %l14
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t390 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge13
merge13:
  %t391 = phi { i8**, i64 }* [ %t389, %afterloop17 ], [ %t259, %merge11 ]
  %t392 = phi { %NativeParameter*, i64 }* [ %t390, %afterloop17 ], [ %t270, %merge11 ]
  store { i8**, i64 }* %t391, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t392, { %NativeParameter*, i64 }** %l11
  %t393 = call i8* @malloc(i64 5)
  %t394 = bitcast i8* %t393 to [5 x i8]*
  store [5 x i8] c"void\00", [5 x i8]* %t394
  store i8* %t393, i8** %l16
  %t395 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t396 = ptrtoint [0 x i8*]* %t395 to i64
  %t397 = icmp eq i64 %t396, 0
  %t398 = select i1 %t397, i64 1, i64 %t396
  %t399 = call i8* @malloc(i64 %t398)
  %t400 = bitcast i8* %t399 to i8**
  %t401 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t402 = ptrtoint { i8**, i64 }* %t401 to i64
  %t403 = call i8* @malloc(i64 %t402)
  %t404 = bitcast i8* %t403 to { i8**, i64 }*
  %t405 = getelementptr { i8**, i64 }, { i8**, i64 }* %t404, i32 0, i32 0
  store i8** %t400, i8*** %t405
  %t406 = getelementptr { i8**, i64 }, { i8**, i64 }* %t404, i32 0, i32 1
  store i64 0, i64* %t406
  store { i8**, i64 }* %t404, { i8**, i64 }** %l17
  %t407 = load i8*, i8** %l3
  %t408 = load double, double* %l6
  %t409 = sitofp i64 1 to double
  %t410 = fadd double %t408, %t409
  %t411 = load i8*, i8** %l3
  %t412 = call i64 @sailfin_runtime_string_length(i8* %t411)
  %t413 = call double @llvm.round.f64(double %t410)
  %t414 = fptosi double %t413 to i64
  %t415 = call i8* @sailfin_runtime_substring(i8* %t407, i64 %t414, i64 %t412)
  %t416 = call i8* @trim_text(i8* %t415)
  store i8* %t416, i8** %l18
  %t417 = load i8*, i8** %l18
  %t418 = call i64 @sailfin_runtime_string_length(i8* %t417)
  %t419 = icmp sgt i64 %t418, 0
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t422 = load i8*, i8** %l2
  %t423 = load i8*, i8** %l3
  %t424 = load i1, i1* %l4
  %t425 = load double, double* %l5
  %t426 = load double, double* %l6
  %t427 = load i8*, i8** %l7
  %t428 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t429 = load i8*, i8** %l9
  %t430 = load i8*, i8** %l10
  %t431 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t432 = load i8*, i8** %l12
  %t433 = load i8*, i8** %l16
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t435 = load i8*, i8** %l18
  br i1 %t419, label %then23, label %merge24
then23:
  %t436 = load i8*, i8** %l18
  %t437 = call i8* @malloc(i64 3)
  %t438 = bitcast i8* %t437 to [3 x i8]*
  store [3 x i8] c"![\00", [3 x i8]* %t438
  %t439 = call double @index_of(i8* %t436, i8* %t437)
  store double %t439, double* %l19
  %t440 = call i8* @malloc(i64 1)
  %t441 = bitcast i8* %t440 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t441
  store i8* %t440, i8** %l20
  %t442 = load double, double* %l19
  %t443 = sitofp i64 0 to double
  %t444 = fcmp oge double %t442, %t443
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t446 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t447 = load i8*, i8** %l2
  %t448 = load i8*, i8** %l3
  %t449 = load i1, i1* %l4
  %t450 = load double, double* %l5
  %t451 = load double, double* %l6
  %t452 = load i8*, i8** %l7
  %t453 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t454 = load i8*, i8** %l9
  %t455 = load i8*, i8** %l10
  %t456 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t457 = load i8*, i8** %l12
  %t458 = load i8*, i8** %l16
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t460 = load i8*, i8** %l18
  %t461 = load double, double* %l19
  %t462 = load i8*, i8** %l20
  br i1 %t444, label %then25, label %merge26
then25:
  %t463 = load i8*, i8** %l18
  %t464 = load double, double* %l19
  %t465 = load i8*, i8** %l18
  %t466 = call i64 @sailfin_runtime_string_length(i8* %t465)
  %t467 = call double @llvm.round.f64(double %t464)
  %t468 = fptosi double %t467 to i64
  %t469 = call i8* @sailfin_runtime_substring(i8* %t463, i64 %t468, i64 %t466)
  %t470 = call i8* @trim_text(i8* %t469)
  store i8* %t470, i8** %l20
  %t471 = load i8*, i8** %l18
  %t472 = load double, double* %l19
  %t473 = call double @llvm.round.f64(double %t472)
  %t474 = fptosi double %t473 to i64
  %t475 = call i8* @sailfin_runtime_substring(i8* %t471, i64 0, i64 %t474)
  %t476 = call i8* @trim_text(i8* %t475)
  store i8* %t476, i8** %l18
  %t477 = load i8*, i8** %l20
  %t478 = load i8*, i8** %l18
  br label %merge26
merge26:
  %t479 = phi i8* [ %t477, %then25 ], [ %t462, %then23 ]
  %t480 = phi i8* [ %t478, %then25 ], [ %t460, %then23 ]
  store i8* %t479, i8** %l20
  store i8* %t480, i8** %l18
  %t481 = load i8*, i8** %l18
  %t482 = call i64 @sailfin_runtime_string_length(i8* %t481)
  %t483 = icmp sgt i64 %t482, 0
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t485 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t486 = load i8*, i8** %l2
  %t487 = load i8*, i8** %l3
  %t488 = load i1, i1* %l4
  %t489 = load double, double* %l5
  %t490 = load double, double* %l6
  %t491 = load i8*, i8** %l7
  %t492 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t493 = load i8*, i8** %l9
  %t494 = load i8*, i8** %l10
  %t495 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t496 = load i8*, i8** %l12
  %t497 = load i8*, i8** %l16
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t499 = load i8*, i8** %l18
  %t500 = load double, double* %l19
  %t501 = load i8*, i8** %l20
  br i1 %t483, label %then27, label %merge28
then27:
  %t502 = load i8*, i8** %l18
  %t503 = call i8* @malloc(i64 3)
  %t504 = bitcast i8* %t503 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t504
  %t505 = call i1 @starts_with(i8* %t502, i8* %t503)
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t507 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t508 = load i8*, i8** %l2
  %t509 = load i8*, i8** %l3
  %t510 = load i1, i1* %l4
  %t511 = load double, double* %l5
  %t512 = load double, double* %l6
  %t513 = load i8*, i8** %l7
  %t514 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t515 = load i8*, i8** %l9
  %t516 = load i8*, i8** %l10
  %t517 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t518 = load i8*, i8** %l12
  %t519 = load i8*, i8** %l16
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t521 = load i8*, i8** %l18
  %t522 = load double, double* %l19
  %t523 = load i8*, i8** %l20
  br i1 %t505, label %then29, label %else30
then29:
  %t524 = load i8*, i8** %l18
  %t525 = call i8* @malloc(i64 3)
  %t526 = bitcast i8* %t525 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t526
  %t527 = call i8* @strip_prefix(i8* %t524, i8* %t525)
  %t528 = call i8* @trim_text(i8* %t527)
  store i8* %t528, i8** %l21
  %t529 = load i8*, i8** %l21
  %t530 = call i64 @sailfin_runtime_string_length(i8* %t529)
  %t531 = icmp sgt i64 %t530, 0
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t533 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t534 = load i8*, i8** %l2
  %t535 = load i8*, i8** %l3
  %t536 = load i1, i1* %l4
  %t537 = load double, double* %l5
  %t538 = load double, double* %l6
  %t539 = load i8*, i8** %l7
  %t540 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t541 = load i8*, i8** %l9
  %t542 = load i8*, i8** %l10
  %t543 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t544 = load i8*, i8** %l12
  %t545 = load i8*, i8** %l16
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t547 = load i8*, i8** %l18
  %t548 = load double, double* %l19
  %t549 = load i8*, i8** %l20
  %t550 = load i8*, i8** %l21
  br i1 %t531, label %then32, label %merge33
then32:
  %t551 = load i8*, i8** %l21
  store i8* %t551, i8** %l16
  %t552 = load i8*, i8** %l16
  br label %merge33
merge33:
  %t553 = phi i8* [ %t552, %then32 ], [ %t545, %then29 ]
  store i8* %t553, i8** %l16
  %t554 = load i8*, i8** %l16
  br label %merge31
else30:
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t556 = call i8* @malloc(i64 11)
  %t557 = bitcast i8* %t556 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t557
  %t558 = call i8* @sailfin_runtime_string_concat(i8* %t556, i8* %interface_name)
  %t559 = call i8* @malloc(i64 13)
  %t560 = bitcast i8* %t559 to [13 x i8]*
  store [13 x i8] c" signature `\00", [13 x i8]* %t560
  %t561 = call i8* @sailfin_runtime_string_concat(i8* %t558, i8* %t559)
  %t562 = load i8*, i8** %l9
  %t563 = call i8* @sailfin_runtime_string_concat(i8* %t561, i8* %t562)
  %t564 = call i8* @malloc(i64 27)
  %t565 = bitcast i8* %t564 to [27 x i8]*
  store [27 x i8] c"` has unsupported suffix `\00", [27 x i8]* %t565
  %t566 = call i8* @sailfin_runtime_string_concat(i8* %t563, i8* %t564)
  %t567 = load i8*, i8** %l18
  %t568 = call i8* @sailfin_runtime_string_concat(i8* %t566, i8* %t567)
  %t569 = add i64 0, 2
  %t570 = call i8* @malloc(i64 %t569)
  store i8 96, i8* %t570
  %t571 = getelementptr i8, i8* %t570, i64 1
  store i8 0, i8* %t571
  call void @sailfin_runtime_mark_persistent(i8* %t570)
  %t572 = call i8* @sailfin_runtime_string_concat(i8* %t568, i8* %t570)
  %t573 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t555, i8* %t572)
  store { i8**, i64 }* %t573, { i8**, i64 }** %l0
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
merge31:
  %t575 = phi i8* [ %t554, %merge33 ], [ %t519, %else30 ]
  %t576 = phi { i8**, i64 }* [ %t506, %merge33 ], [ %t574, %else30 ]
  store i8* %t575, i8** %l16
  store { i8**, i64 }* %t576, { i8**, i64 }** %l0
  %t577 = load i8*, i8** %l16
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t579 = phi i8* [ %t577, %merge31 ], [ %t497, %merge26 ]
  %t580 = phi { i8**, i64 }* [ %t578, %merge31 ], [ %t484, %merge26 ]
  store i8* %t579, i8** %l16
  store { i8**, i64 }* %t580, { i8**, i64 }** %l0
  %t581 = load i8*, i8** %l20
  %t582 = call i64 @sailfin_runtime_string_length(i8* %t581)
  %t583 = icmp sgt i64 %t582, 0
  %t584 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t585 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t586 = load i8*, i8** %l2
  %t587 = load i8*, i8** %l3
  %t588 = load i1, i1* %l4
  %t589 = load double, double* %l5
  %t590 = load double, double* %l6
  %t591 = load i8*, i8** %l7
  %t592 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t593 = load i8*, i8** %l9
  %t594 = load i8*, i8** %l10
  %t595 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t596 = load i8*, i8** %l12
  %t597 = load i8*, i8** %l16
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t599 = load i8*, i8** %l18
  %t600 = load double, double* %l19
  %t601 = load i8*, i8** %l20
  br i1 %t583, label %then34, label %merge35
then34:
  %t603 = load i8*, i8** %l20
  %t604 = call i8* @malloc(i64 3)
  %t605 = bitcast i8* %t604 to [3 x i8]*
  store [3 x i8] c"![\00", [3 x i8]* %t605
  %t606 = call i1 @starts_with(i8* %t603, i8* %t604)
  br label %logical_and_entry_602

logical_and_entry_602:
  br i1 %t606, label %logical_and_right_602, label %logical_and_merge_602

logical_and_right_602:
  %t607 = load i8*, i8** %l20
  %t608 = load i8*, i8** %l20
  %t609 = call i64 @sailfin_runtime_string_length(i8* %t608)
  %t610 = sub i64 %t609, 1
  %t611 = getelementptr i8, i8* %t607, i64 %t610
  %t612 = load i8, i8* %t611
  %t613 = icmp eq i8 %t612, 93
  br label %logical_and_right_end_602

logical_and_right_end_602:
  br label %logical_and_merge_602

logical_and_merge_602:
  %t614 = phi i1 [ false, %logical_and_entry_602 ], [ %t613, %logical_and_right_end_602 ]
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t616 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t617 = load i8*, i8** %l2
  %t618 = load i8*, i8** %l3
  %t619 = load i1, i1* %l4
  %t620 = load double, double* %l5
  %t621 = load double, double* %l6
  %t622 = load i8*, i8** %l7
  %t623 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t624 = load i8*, i8** %l9
  %t625 = load i8*, i8** %l10
  %t626 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t627 = load i8*, i8** %l12
  %t628 = load i8*, i8** %l16
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t630 = load i8*, i8** %l18
  %t631 = load double, double* %l19
  %t632 = load i8*, i8** %l20
  br i1 %t614, label %then36, label %else37
then36:
  %t633 = load i8*, i8** %l20
  %t634 = load i8*, i8** %l20
  %t635 = call i64 @sailfin_runtime_string_length(i8* %t634)
  %t636 = sub i64 %t635, 1
  %t637 = call i8* @sailfin_runtime_substring(i8* %t633, i64 2, i64 %t636)
  store i8* %t637, i8** %l22
  %t638 = load i8*, i8** %l22
  %t639 = call { i8**, i64 }* @parse_effect_list(i8* %t638)
  store { i8**, i64 }* %t639, { i8**, i64 }** %l17
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l17
  br label %merge38
else37:
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t642 = call i8* @malloc(i64 11)
  %t643 = bitcast i8* %t642 to [11 x i8]*
  store [11 x i8] c"interface \00", [11 x i8]* %t643
  %t644 = call i8* @sailfin_runtime_string_concat(i8* %t642, i8* %interface_name)
  %t645 = call i8* @malloc(i64 13)
  %t646 = bitcast i8* %t645 to [13 x i8]*
  store [13 x i8] c" signature `\00", [13 x i8]* %t646
  %t647 = call i8* @sailfin_runtime_string_concat(i8* %t644, i8* %t645)
  %t648 = load i8*, i8** %l9
  %t649 = call i8* @sailfin_runtime_string_concat(i8* %t647, i8* %t648)
  %t650 = call i8* @malloc(i64 35)
  %t651 = bitcast i8* %t650 to [35 x i8]*
  store [35 x i8] c"` has invalid effects annotation `\00", [35 x i8]* %t651
  %t652 = call i8* @sailfin_runtime_string_concat(i8* %t649, i8* %t650)
  %t653 = load i8*, i8** %l20
  %t654 = call i8* @sailfin_runtime_string_concat(i8* %t652, i8* %t653)
  %t655 = add i64 0, 2
  %t656 = call i8* @malloc(i64 %t655)
  store i8 96, i8* %t656
  %t657 = getelementptr i8, i8* %t656, i64 1
  store i8 0, i8* %t657
  call void @sailfin_runtime_mark_persistent(i8* %t656)
  %t658 = call i8* @sailfin_runtime_string_concat(i8* %t654, i8* %t656)
  %t659 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t641, i8* %t658)
  store { i8**, i64 }* %t659, { i8**, i64 }** %l0
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
merge38:
  %t661 = phi { i8**, i64 }* [ %t640, %then36 ], [ %t629, %else37 ]
  %t662 = phi { i8**, i64 }* [ %t615, %then36 ], [ %t660, %else37 ]
  store { i8**, i64 }* %t661, { i8**, i64 }** %l17
  store { i8**, i64 }* %t662, { i8**, i64 }** %l0
  %t663 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t664 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge35
merge35:
  %t665 = phi { i8**, i64 }* [ %t663, %merge38 ], [ %t598, %merge28 ]
  %t666 = phi { i8**, i64 }* [ %t664, %merge38 ], [ %t584, %merge28 ]
  store { i8**, i64 }* %t665, { i8**, i64 }** %l17
  store { i8**, i64 }* %t666, { i8**, i64 }** %l0
  %t667 = load i8*, i8** %l18
  %t668 = load i8*, i8** %l16
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t672 = phi i8* [ %t667, %merge35 ], [ %t435, %merge13 ]
  %t673 = phi i8* [ %t668, %merge35 ], [ %t433, %merge13 ]
  %t674 = phi { i8**, i64 }* [ %t669, %merge35 ], [ %t420, %merge13 ]
  %t675 = phi { i8**, i64 }* [ %t670, %merge35 ], [ %t434, %merge13 ]
  %t676 = phi { i8**, i64 }* [ %t671, %merge35 ], [ %t420, %merge13 ]
  store i8* %t672, i8** %l18
  store i8* %t673, i8** %l16
  store { i8**, i64 }* %t674, { i8**, i64 }** %l0
  store { i8**, i64 }* %t675, { i8**, i64 }** %l17
  store { i8**, i64 }* %t676, { i8**, i64 }** %l0
  %t677 = load i8*, i8** %l9
  %t678 = insertvalue %NativeInterfaceSignature undef, i8* %t677, 0
  %t679 = load i1, i1* %l4
  %t680 = insertvalue %NativeInterfaceSignature %t678, i1 %t679, 1
  %t681 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t682 = extractvalue %HeaderNameParse %t681, 1
  %t683 = insertvalue %NativeInterfaceSignature %t680, { i8**, i64 }* %t682, 2
  %t684 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t685 = insertvalue %NativeInterfaceSignature %t683, { %NativeParameter*, i64 }* %t684, 3
  %t686 = load i8*, i8** %l16
  %t687 = insertvalue %NativeInterfaceSignature %t685, i8* %t686, 4
  %t688 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t689 = insertvalue %NativeInterfaceSignature %t687, { i8**, i64 }* %t688, 5
  store %NativeInterfaceSignature %t689, %NativeInterfaceSignature* %l23
  %t691 = load i8*, i8** %l9
  %t692 = call i64 @sailfin_runtime_string_length(i8* %t691)
  %t693 = icmp sgt i64 %t692, 0
  br label %logical_and_entry_690

logical_and_entry_690:
  br i1 %t693, label %logical_and_right_690, label %logical_and_merge_690

logical_and_right_690:
  %t694 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t695 = load { i8**, i64 }, { i8**, i64 }* %t694
  %t696 = extractvalue { i8**, i64 } %t695, 1
  %t697 = icmp eq i64 %t696, 0
  br label %logical_and_right_end_690

logical_and_right_end_690:
  br label %logical_and_merge_690

logical_and_merge_690:
  %t698 = phi i1 [ false, %logical_and_entry_690 ], [ %t697, %logical_and_right_end_690 ]
  store i1 %t698, i1* %l24
  %t699 = load i1, i1* %l24
  %t700 = insertvalue %InterfaceSignatureParse undef, i1 %t699, 0
  %t701 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l23
  %t702 = insertvalue %InterfaceSignatureParse %t700, %NativeInterfaceSignature %t701, 1
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t704 = insertvalue %InterfaceSignatureParse %t702, { i8**, i64 }* %t703, 2
  ret %InterfaceSignatureParse %t704
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
  %t18 = call i8* @malloc(i64 1)
  %t19 = bitcast i8* %t18 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t19
  %t20 = insertvalue %HeaderNameParse undef, i8* %t18, 0
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
  %t33 = insertvalue %HeaderNameParse %t20, { i8**, i64 }* %t30, 1
  %t34 = call i8* @malloc(i64 1)
  %t35 = bitcast i8* %t34 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t35
  %t36 = insertvalue %HeaderNameParse %t33, i8* %t34, 2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = insertvalue %HeaderNameParse %t36, { i8**, i64 }* %t37, 3
  ret %HeaderNameParse %t38
merge1:
  %t39 = load i8*, i8** %l1
  store i8* %t39, i8** %l2
  %t40 = call i8* @malloc(i64 1)
  %t41 = bitcast i8* %t40 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t41
  store i8* %t40, i8** %l3
  %t42 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t43 = ptrtoint [0 x i8*]* %t42 to i64
  %t44 = icmp eq i64 %t43, 0
  %t45 = select i1 %t44, i64 1, i64 %t43
  %t46 = call i8* @malloc(i64 %t45)
  %t47 = bitcast i8* %t46 to i8**
  %t48 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t49 = ptrtoint { i8**, i64 }* %t48 to i64
  %t50 = call i8* @malloc(i64 %t49)
  %t51 = bitcast i8* %t50 to { i8**, i64 }*
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 0
  store i8** %t47, i8*** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t51, i32 0, i32 1
  store i64 0, i64* %t53
  store { i8**, i64 }* %t51, { i8**, i64 }** %l4
  %t54 = load i8*, i8** %l1
  %t55 = add i64 0, 2
  %t56 = call i8* @malloc(i64 %t55)
  store i8 60, i8* %t56
  %t57 = getelementptr i8, i8* %t56, i64 1
  store i8 0, i8* %t57
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  %t58 = call double @index_of(i8* %t54, i8* %t56)
  store double %t58, double* %l5
  %t59 = load double, double* %l5
  %t60 = sitofp i64 0 to double
  %t61 = fcmp oge double %t59, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load i8*, i8** %l2
  %t65 = load i8*, i8** %l3
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t67 = load double, double* %l5
  br i1 %t61, label %then2, label %else3
then2:
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l5
  %t70 = call double @find_matching_angle(i8* %t68, double %t69)
  store double %t70, double* %l6
  %t71 = load double, double* %l6
  %t72 = sitofp i64 0 to double
  %t73 = fcmp olt double %t71, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load i8*, i8** %l2
  %t77 = load i8*, i8** %l3
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t79 = load double, double* %l5
  %t80 = load double, double* %l6
  br i1 %t73, label %then5, label %merge6
then5:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = call i8* @malloc(i64 9)
  %t83 = bitcast i8* %t82 to [9 x i8]*
  store [9 x i8] c"header `\00", [9 x i8]* %t83
  %t84 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %text)
  %t85 = call i8* @malloc(i64 22)
  %t86 = bitcast i8* %t85 to [22 x i8]*
  store [22 x i8] c"` missing closing `>`\00", [22 x i8]* %t86
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t84, i8* %t85)
  %t88 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t81, i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = call i8* @strip_generics(i8* %t89)
  store i8* %t90, i8** %l2
  %t91 = load i8*, i8** %l2
  %t92 = insertvalue %HeaderNameParse undef, i8* %t91, 0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t94 = insertvalue %HeaderNameParse %t92, { i8**, i64 }* %t93, 1
  %t95 = load i8*, i8** %l3
  %t96 = insertvalue %HeaderNameParse %t94, i8* %t95, 2
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = insertvalue %HeaderNameParse %t96, { i8**, i64 }* %t97, 3
  ret %HeaderNameParse %t98
merge6:
  %t99 = load i8*, i8** %l1
  %t100 = load double, double* %l5
  %t101 = call double @llvm.round.f64(double %t100)
  %t102 = fptosi double %t101 to i64
  %t103 = call i8* @sailfin_runtime_substring(i8* %t99, i64 0, i64 %t102)
  %t104 = call i8* @trim_text(i8* %t103)
  store i8* %t104, i8** %l2
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l5
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  %t109 = load double, double* %l6
  %t110 = call double @llvm.round.f64(double %t108)
  %t111 = fptosi double %t110 to i64
  %t112 = call double @llvm.round.f64(double %t109)
  %t113 = fptosi double %t112 to i64
  %t114 = call i8* @sailfin_runtime_substring(i8* %t105, i64 %t111, i64 %t113)
  store i8* %t114, i8** %l7
  %t115 = load i8*, i8** %l7
  %t116 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t115)
  store { i8**, i64 }* %t116, { i8**, i64 }** %l4
  %t117 = load i8*, i8** %l1
  %t118 = load double, double* %l6
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  %t121 = load i8*, i8** %l1
  %t122 = call i64 @sailfin_runtime_string_length(i8* %t121)
  %t123 = call double @llvm.round.f64(double %t120)
  %t124 = fptosi double %t123 to i64
  %t125 = call i8* @sailfin_runtime_substring(i8* %t117, i64 %t124, i64 %t122)
  %t126 = call i8* @trim_text(i8* %t125)
  store i8* %t126, i8** %l3
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load i8*, i8** %l2
  %t129 = load i8*, i8** %l2
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t131 = load i8*, i8** %l3
  br label %merge4
else3:
  %t132 = load i8*, i8** %l1
  %t133 = add i64 0, 2
  %t134 = call i8* @malloc(i64 %t133)
  store i8 32, i8* %t134
  %t135 = getelementptr i8, i8* %t134, i64 1
  store i8 0, i8* %t135
  call void @sailfin_runtime_mark_persistent(i8* %t134)
  %t136 = call double @index_of(i8* %t132, i8* %t134)
  store double %t136, double* %l8
  %t137 = load double, double* %l8
  %t138 = sitofp i64 0 to double
  %t139 = fcmp oge double %t137, %t138
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load i8*, i8** %l1
  %t142 = load i8*, i8** %l2
  %t143 = load i8*, i8** %l3
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t145 = load double, double* %l5
  %t146 = load double, double* %l8
  br i1 %t139, label %then7, label %merge8
then7:
  %t147 = load i8*, i8** %l1
  %t148 = load double, double* %l8
  %t149 = call double @llvm.round.f64(double %t148)
  %t150 = fptosi double %t149 to i64
  %t151 = call i8* @sailfin_runtime_substring(i8* %t147, i64 0, i64 %t150)
  %t152 = call i8* @trim_text(i8* %t151)
  store i8* %t152, i8** %l2
  %t153 = load i8*, i8** %l1
  %t154 = load double, double* %l8
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  %t157 = load i8*, i8** %l1
  %t158 = call i64 @sailfin_runtime_string_length(i8* %t157)
  %t159 = call double @llvm.round.f64(double %t156)
  %t160 = fptosi double %t159 to i64
  %t161 = call i8* @sailfin_runtime_substring(i8* %t153, i64 %t160, i64 %t158)
  %t162 = call i8* @trim_text(i8* %t161)
  store i8* %t162, i8** %l3
  %t163 = load i8*, i8** %l2
  %t164 = load i8*, i8** %l3
  br label %merge8
merge8:
  %t165 = phi i8* [ %t163, %then7 ], [ %t142, %else3 ]
  %t166 = phi i8* [ %t164, %then7 ], [ %t143, %else3 ]
  store i8* %t165, i8** %l2
  store i8* %t166, i8** %l3
  %t167 = load i8*, i8** %l2
  %t168 = load i8*, i8** %l3
  br label %merge4
merge4:
  %t169 = phi { i8**, i64 }* [ %t127, %merge6 ], [ %t62, %merge8 ]
  %t170 = phi i8* [ %t128, %merge6 ], [ %t167, %merge8 ]
  %t171 = phi { i8**, i64 }* [ %t130, %merge6 ], [ %t66, %merge8 ]
  %t172 = phi i8* [ %t131, %merge6 ], [ %t168, %merge8 ]
  store { i8**, i64 }* %t169, { i8**, i64 }** %l0
  store i8* %t170, i8** %l2
  store { i8**, i64 }* %t171, { i8**, i64 }** %l4
  store i8* %t172, i8** %l3
  %t173 = load i8*, i8** %l2
  %t174 = call i8* @strip_generics(i8* %t173)
  store i8* %t174, i8** %l2
  %t175 = load i8*, i8** %l2
  %t176 = insertvalue %HeaderNameParse undef, i8* %t175, 0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t178 = insertvalue %HeaderNameParse %t176, { i8**, i64 }* %t177, 1
  %t179 = load i8*, i8** %l3
  %t180 = insertvalue %HeaderNameParse %t178, i8* %t179, 2
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = insertvalue %HeaderNameParse %t180, { i8**, i64 }* %t181, 3
  ret %HeaderNameParse %t182
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = call i8* @malloc(i64 1)
  %t16 = bitcast i8* %t15 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t16
  store i8* %t15, i8** %l3
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l4
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l5
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l6
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l7
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  %t24 = load i8*, i8** %l3
  %t25 = load double, double* %l4
  %t26 = load double, double* %l5
  %t27 = load double, double* %l6
  %t28 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t483 = phi i8* [ %t22, %block.entry ], [ %t475, %loop.latch2 ]
  %t484 = phi double [ %t23, %block.entry ], [ %t476, %loop.latch2 ]
  %t485 = phi i8* [ %t24, %block.entry ], [ %t477, %loop.latch2 ]
  %t486 = phi double [ %t25, %block.entry ], [ %t478, %loop.latch2 ]
  %t487 = phi double [ %t26, %block.entry ], [ %t479, %loop.latch2 ]
  %t488 = phi double [ %t27, %block.entry ], [ %t480, %loop.latch2 ]
  %t489 = phi double [ %t28, %block.entry ], [ %t481, %loop.latch2 ]
  %t490 = phi { i8**, i64 }* [ %t21, %block.entry ], [ %t482, %loop.latch2 ]
  store i8* %t483, i8** %l1
  store double %t484, double* %l2
  store i8* %t485, i8** %l3
  store double %t486, double* %l4
  store double %t487, double* %l5
  store double %t488, double* %l6
  store double %t489, double* %l7
  store { i8**, i64 }* %t490, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t29 = load double, double* %l2
  %t30 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t29, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load double, double* %l2
  %t36 = load i8*, i8** %l3
  %t37 = load double, double* %l4
  %t38 = load double, double* %l5
  %t39 = load double, double* %l6
  %t40 = load double, double* %l7
  br i1 %t32, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t41 = load double, double* %l2
  %t42 = call double @llvm.round.f64(double %t41)
  %t43 = fptosi double %t42 to i64
  %t44 = getelementptr i8, i8* %text, i64 %t43
  %t45 = load i8, i8* %t44
  store i8 %t45, i8* %l8
  %t46 = load i8*, i8** %l3
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = icmp sgt i64 %t47, 0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load i8*, i8** %l1
  %t51 = load double, double* %l2
  %t52 = load i8*, i8** %l3
  %t53 = load double, double* %l4
  %t54 = load double, double* %l5
  %t55 = load double, double* %l6
  %t56 = load double, double* %l7
  %t57 = load i8, i8* %l8
  br i1 %t48, label %then6, label %merge7
then6:
  %t58 = load i8*, i8** %l1
  %t59 = load i8, i8* %l8
  %t60 = add i64 0, 2
  %t61 = call i8* @malloc(i64 %t60)
  store i8 %t59, i8* %t61
  %t62 = getelementptr i8, i8* %t61, i64 1
  store i8 0, i8* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t61)
  store i8* %t63, i8** %l1
  %t64 = load i8, i8* %l8
  %t65 = icmp eq i8 %t64, 92
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  %t69 = load i8*, i8** %l3
  %t70 = load double, double* %l4
  %t71 = load double, double* %l5
  %t72 = load double, double* %l6
  %t73 = load double, double* %l7
  %t74 = load i8, i8* %l8
  br i1 %t65, label %then8, label %merge9
then8:
  %t75 = load double, double* %l2
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  %t78 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t79 = sitofp i64 %t78 to double
  %t80 = fcmp olt double %t77, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load i8*, i8** %l3
  %t85 = load double, double* %l4
  %t86 = load double, double* %l5
  %t87 = load double, double* %l6
  %t88 = load double, double* %l7
  %t89 = load i8, i8* %l8
  br i1 %t80, label %then10, label %merge11
then10:
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  %t94 = call double @llvm.round.f64(double %t93)
  %t95 = fptosi double %t94 to i64
  %t96 = getelementptr i8, i8* %text, i64 %t95
  %t97 = load i8, i8* %t96
  %t98 = add i64 0, 2
  %t99 = call i8* @malloc(i64 %t98)
  store i8 %t97, i8* %t99
  %t100 = getelementptr i8, i8* %t99, i64 1
  store i8 0, i8* %t100
  call void @sailfin_runtime_mark_persistent(i8* %t99)
  %t101 = call i8* @sailfin_runtime_string_concat(i8* %t90, i8* %t99)
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
  %t107 = phi i8* [ %t105, %merge11 ], [ %t67, %then6 ]
  %t108 = phi double [ %t106, %merge11 ], [ %t68, %then6 ]
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
  %t122 = call i8* @malloc(i64 1)
  %t123 = bitcast i8* %t122 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t123
  store i8* %t122, i8** %l3
  %t124 = load i8*, i8** %l3
  br label %merge13
merge13:
  %t125 = phi i8* [ %t124, %then12 ], [ %t116, %merge9 ]
  store i8* %t125, i8** %l3
  %t126 = load double, double* %l2
  %t127 = sitofp i64 1 to double
  %t128 = fadd double %t126, %t127
  store double %t128, double* %l2
  br label %loop.latch2
merge7:
  %t130 = load i8, i8* %l8
  %t131 = icmp eq i8 %t130, 34
  br label %logical_or_entry_129

logical_or_entry_129:
  br i1 %t131, label %logical_or_merge_129, label %logical_or_right_129

logical_or_right_129:
  %t132 = load i8, i8* %l8
  %t133 = icmp eq i8 %t132, 39
  br label %logical_or_right_end_129

logical_or_right_end_129:
  br label %logical_or_merge_129

logical_or_merge_129:
  %t134 = phi i1 [ true, %logical_or_entry_129 ], [ %t133, %logical_or_right_end_129 ]
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load i8*, i8** %l1
  %t137 = load double, double* %l2
  %t138 = load i8*, i8** %l3
  %t139 = load double, double* %l4
  %t140 = load double, double* %l5
  %t141 = load double, double* %l6
  %t142 = load double, double* %l7
  %t143 = load i8, i8* %l8
  br i1 %t134, label %then14, label %merge15
then14:
  %t144 = load i8, i8* %l8
  %t145 = add i64 0, 2
  %t146 = call i8* @malloc(i64 %t145)
  store i8 %t144, i8* %t146
  %t147 = getelementptr i8, i8* %t146, i64 1
  store i8 0, i8* %t147
  call void @sailfin_runtime_mark_persistent(i8* %t146)
  store i8* %t146, i8** %l3
  %t148 = load i8*, i8** %l1
  %t149 = load i8, i8* %l8
  %t150 = add i64 0, 2
  %t151 = call i8* @malloc(i64 %t150)
  store i8 %t149, i8* %t151
  %t152 = getelementptr i8, i8* %t151, i64 1
  store i8 0, i8* %t152
  call void @sailfin_runtime_mark_persistent(i8* %t151)
  %t153 = call i8* @sailfin_runtime_string_concat(i8* %t148, i8* %t151)
  store i8* %t153, i8** %l1
  %t154 = load double, double* %l2
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  store double %t156, double* %l2
  br label %loop.latch2
merge15:
  %t157 = load i8, i8* %l8
  %t158 = icmp eq i8 %t157, 60
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = load i8*, i8** %l1
  %t161 = load double, double* %l2
  %t162 = load i8*, i8** %l3
  %t163 = load double, double* %l4
  %t164 = load double, double* %l5
  %t165 = load double, double* %l6
  %t166 = load double, double* %l7
  %t167 = load i8, i8* %l8
  br i1 %t158, label %then16, label %merge17
then16:
  %t168 = load double, double* %l4
  %t169 = sitofp i64 1 to double
  %t170 = fadd double %t168, %t169
  store double %t170, double* %l4
  %t171 = load i8*, i8** %l1
  %t172 = load i8, i8* %l8
  %t173 = add i64 0, 2
  %t174 = call i8* @malloc(i64 %t173)
  store i8 %t172, i8* %t174
  %t175 = getelementptr i8, i8* %t174, i64 1
  store i8 0, i8* %t175
  call void @sailfin_runtime_mark_persistent(i8* %t174)
  %t176 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %t174)
  store i8* %t176, i8** %l1
  %t177 = load double, double* %l2
  %t178 = sitofp i64 1 to double
  %t179 = fadd double %t177, %t178
  store double %t179, double* %l2
  br label %loop.latch2
merge17:
  %t180 = load i8, i8* %l8
  %t181 = icmp eq i8 %t180, 62
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load i8*, i8** %l3
  %t186 = load double, double* %l4
  %t187 = load double, double* %l5
  %t188 = load double, double* %l6
  %t189 = load double, double* %l7
  %t190 = load i8, i8* %l8
  br i1 %t181, label %then18, label %merge19
then18:
  %t191 = load double, double* %l4
  %t192 = sitofp i64 0 to double
  %t193 = fcmp ogt double %t191, %t192
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  %t197 = load i8*, i8** %l3
  %t198 = load double, double* %l4
  %t199 = load double, double* %l5
  %t200 = load double, double* %l6
  %t201 = load double, double* %l7
  %t202 = load i8, i8* %l8
  br i1 %t193, label %then20, label %merge21
then20:
  %t203 = load double, double* %l4
  %t204 = sitofp i64 1 to double
  %t205 = fsub double %t203, %t204
  store double %t205, double* %l4
  %t206 = load double, double* %l4
  br label %merge21
merge21:
  %t207 = phi double [ %t206, %then20 ], [ %t198, %then18 ]
  store double %t207, double* %l4
  %t208 = load i8*, i8** %l1
  %t209 = load i8, i8* %l8
  %t210 = add i64 0, 2
  %t211 = call i8* @malloc(i64 %t210)
  store i8 %t209, i8* %t211
  %t212 = getelementptr i8, i8* %t211, i64 1
  store i8 0, i8* %t212
  call void @sailfin_runtime_mark_persistent(i8* %t211)
  %t213 = call i8* @sailfin_runtime_string_concat(i8* %t208, i8* %t211)
  store i8* %t213, i8** %l1
  %t214 = load double, double* %l2
  %t215 = sitofp i64 1 to double
  %t216 = fadd double %t214, %t215
  store double %t216, double* %l2
  br label %loop.latch2
merge19:
  %t217 = load i8, i8* %l8
  %t218 = icmp eq i8 %t217, 40
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t220 = load i8*, i8** %l1
  %t221 = load double, double* %l2
  %t222 = load i8*, i8** %l3
  %t223 = load double, double* %l4
  %t224 = load double, double* %l5
  %t225 = load double, double* %l6
  %t226 = load double, double* %l7
  %t227 = load i8, i8* %l8
  br i1 %t218, label %then22, label %merge23
then22:
  %t228 = load double, double* %l5
  %t229 = sitofp i64 1 to double
  %t230 = fadd double %t228, %t229
  store double %t230, double* %l5
  %t231 = load i8*, i8** %l1
  %t232 = load i8, i8* %l8
  %t233 = add i64 0, 2
  %t234 = call i8* @malloc(i64 %t233)
  store i8 %t232, i8* %t234
  %t235 = getelementptr i8, i8* %t234, i64 1
  store i8 0, i8* %t235
  call void @sailfin_runtime_mark_persistent(i8* %t234)
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %t231, i8* %t234)
  store i8* %t236, i8** %l1
  %t237 = load double, double* %l2
  %t238 = sitofp i64 1 to double
  %t239 = fadd double %t237, %t238
  store double %t239, double* %l2
  br label %loop.latch2
merge23:
  %t240 = load i8, i8* %l8
  %t241 = icmp eq i8 %t240, 41
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load i8*, i8** %l1
  %t244 = load double, double* %l2
  %t245 = load i8*, i8** %l3
  %t246 = load double, double* %l4
  %t247 = load double, double* %l5
  %t248 = load double, double* %l6
  %t249 = load double, double* %l7
  %t250 = load i8, i8* %l8
  br i1 %t241, label %then24, label %merge25
then24:
  %t251 = load double, double* %l5
  %t252 = sitofp i64 0 to double
  %t253 = fcmp ogt double %t251, %t252
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t255 = load i8*, i8** %l1
  %t256 = load double, double* %l2
  %t257 = load i8*, i8** %l3
  %t258 = load double, double* %l4
  %t259 = load double, double* %l5
  %t260 = load double, double* %l6
  %t261 = load double, double* %l7
  %t262 = load i8, i8* %l8
  br i1 %t253, label %then26, label %merge27
then26:
  %t263 = load double, double* %l5
  %t264 = sitofp i64 1 to double
  %t265 = fsub double %t263, %t264
  store double %t265, double* %l5
  %t266 = load double, double* %l5
  br label %merge27
merge27:
  %t267 = phi double [ %t266, %then26 ], [ %t259, %then24 ]
  store double %t267, double* %l5
  %t268 = load i8*, i8** %l1
  %t269 = load i8, i8* %l8
  %t270 = add i64 0, 2
  %t271 = call i8* @malloc(i64 %t270)
  store i8 %t269, i8* %t271
  %t272 = getelementptr i8, i8* %t271, i64 1
  store i8 0, i8* %t272
  call void @sailfin_runtime_mark_persistent(i8* %t271)
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t268, i8* %t271)
  store i8* %t273, i8** %l1
  %t274 = load double, double* %l2
  %t275 = sitofp i64 1 to double
  %t276 = fadd double %t274, %t275
  store double %t276, double* %l2
  br label %loop.latch2
merge25:
  %t277 = load i8, i8* %l8
  %t278 = icmp eq i8 %t277, 91
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t280 = load i8*, i8** %l1
  %t281 = load double, double* %l2
  %t282 = load i8*, i8** %l3
  %t283 = load double, double* %l4
  %t284 = load double, double* %l5
  %t285 = load double, double* %l6
  %t286 = load double, double* %l7
  %t287 = load i8, i8* %l8
  br i1 %t278, label %then28, label %merge29
then28:
  %t288 = load double, double* %l6
  %t289 = sitofp i64 1 to double
  %t290 = fadd double %t288, %t289
  store double %t290, double* %l6
  %t291 = load i8*, i8** %l1
  %t292 = load i8, i8* %l8
  %t293 = add i64 0, 2
  %t294 = call i8* @malloc(i64 %t293)
  store i8 %t292, i8* %t294
  %t295 = getelementptr i8, i8* %t294, i64 1
  store i8 0, i8* %t295
  call void @sailfin_runtime_mark_persistent(i8* %t294)
  %t296 = call i8* @sailfin_runtime_string_concat(i8* %t291, i8* %t294)
  store i8* %t296, i8** %l1
  %t297 = load double, double* %l2
  %t298 = sitofp i64 1 to double
  %t299 = fadd double %t297, %t298
  store double %t299, double* %l2
  br label %loop.latch2
merge29:
  %t300 = load i8, i8* %l8
  %t301 = icmp eq i8 %t300, 93
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t303 = load i8*, i8** %l1
  %t304 = load double, double* %l2
  %t305 = load i8*, i8** %l3
  %t306 = load double, double* %l4
  %t307 = load double, double* %l5
  %t308 = load double, double* %l6
  %t309 = load double, double* %l7
  %t310 = load i8, i8* %l8
  br i1 %t301, label %then30, label %merge31
then30:
  %t311 = load double, double* %l6
  %t312 = sitofp i64 0 to double
  %t313 = fcmp ogt double %t311, %t312
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t315 = load i8*, i8** %l1
  %t316 = load double, double* %l2
  %t317 = load i8*, i8** %l3
  %t318 = load double, double* %l4
  %t319 = load double, double* %l5
  %t320 = load double, double* %l6
  %t321 = load double, double* %l7
  %t322 = load i8, i8* %l8
  br i1 %t313, label %then32, label %merge33
then32:
  %t323 = load double, double* %l6
  %t324 = sitofp i64 1 to double
  %t325 = fsub double %t323, %t324
  store double %t325, double* %l6
  %t326 = load double, double* %l6
  br label %merge33
merge33:
  %t327 = phi double [ %t326, %then32 ], [ %t320, %then30 ]
  store double %t327, double* %l6
  %t328 = load i8*, i8** %l1
  %t329 = load i8, i8* %l8
  %t330 = add i64 0, 2
  %t331 = call i8* @malloc(i64 %t330)
  store i8 %t329, i8* %t331
  %t332 = getelementptr i8, i8* %t331, i64 1
  store i8 0, i8* %t332
  call void @sailfin_runtime_mark_persistent(i8* %t331)
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t328, i8* %t331)
  store i8* %t333, i8** %l1
  %t334 = load double, double* %l2
  %t335 = sitofp i64 1 to double
  %t336 = fadd double %t334, %t335
  store double %t336, double* %l2
  br label %loop.latch2
merge31:
  %t337 = load i8, i8* %l8
  %t338 = icmp eq i8 %t337, 123
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t340 = load i8*, i8** %l1
  %t341 = load double, double* %l2
  %t342 = load i8*, i8** %l3
  %t343 = load double, double* %l4
  %t344 = load double, double* %l5
  %t345 = load double, double* %l6
  %t346 = load double, double* %l7
  %t347 = load i8, i8* %l8
  br i1 %t338, label %then34, label %merge35
then34:
  %t348 = load double, double* %l7
  %t349 = sitofp i64 1 to double
  %t350 = fadd double %t348, %t349
  store double %t350, double* %l7
  %t351 = load i8*, i8** %l1
  %t352 = load i8, i8* %l8
  %t353 = add i64 0, 2
  %t354 = call i8* @malloc(i64 %t353)
  store i8 %t352, i8* %t354
  %t355 = getelementptr i8, i8* %t354, i64 1
  store i8 0, i8* %t355
  call void @sailfin_runtime_mark_persistent(i8* %t354)
  %t356 = call i8* @sailfin_runtime_string_concat(i8* %t351, i8* %t354)
  store i8* %t356, i8** %l1
  %t357 = load double, double* %l2
  %t358 = sitofp i64 1 to double
  %t359 = fadd double %t357, %t358
  store double %t359, double* %l2
  br label %loop.latch2
merge35:
  %t360 = load i8, i8* %l8
  %t361 = icmp eq i8 %t360, 125
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t363 = load i8*, i8** %l1
  %t364 = load double, double* %l2
  %t365 = load i8*, i8** %l3
  %t366 = load double, double* %l4
  %t367 = load double, double* %l5
  %t368 = load double, double* %l6
  %t369 = load double, double* %l7
  %t370 = load i8, i8* %l8
  br i1 %t361, label %then36, label %merge37
then36:
  %t371 = load double, double* %l7
  %t372 = sitofp i64 0 to double
  %t373 = fcmp ogt double %t371, %t372
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t375 = load i8*, i8** %l1
  %t376 = load double, double* %l2
  %t377 = load i8*, i8** %l3
  %t378 = load double, double* %l4
  %t379 = load double, double* %l5
  %t380 = load double, double* %l6
  %t381 = load double, double* %l7
  %t382 = load i8, i8* %l8
  br i1 %t373, label %then38, label %merge39
then38:
  %t383 = load double, double* %l7
  %t384 = sitofp i64 1 to double
  %t385 = fsub double %t383, %t384
  store double %t385, double* %l7
  %t386 = load double, double* %l7
  br label %merge39
merge39:
  %t387 = phi double [ %t386, %then38 ], [ %t381, %then36 ]
  store double %t387, double* %l7
  %t388 = load i8*, i8** %l1
  %t389 = load i8, i8* %l8
  %t390 = add i64 0, 2
  %t391 = call i8* @malloc(i64 %t390)
  store i8 %t389, i8* %t391
  %t392 = getelementptr i8, i8* %t391, i64 1
  store i8 0, i8* %t392
  call void @sailfin_runtime_mark_persistent(i8* %t391)
  %t393 = call i8* @sailfin_runtime_string_concat(i8* %t388, i8* %t391)
  store i8* %t393, i8** %l1
  %t394 = load double, double* %l2
  %t395 = sitofp i64 1 to double
  %t396 = fadd double %t394, %t395
  store double %t396, double* %l2
  br label %loop.latch2
merge37:
  %t397 = load i8, i8* %l8
  %t398 = icmp eq i8 %t397, 44
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t400 = load i8*, i8** %l1
  %t401 = load double, double* %l2
  %t402 = load i8*, i8** %l3
  %t403 = load double, double* %l4
  %t404 = load double, double* %l5
  %t405 = load double, double* %l6
  %t406 = load double, double* %l7
  %t407 = load i8, i8* %l8
  br i1 %t398, label %then40, label %merge41
then40:
  %t409 = load double, double* %l4
  %t410 = sitofp i64 0 to double
  %t411 = fcmp oeq double %t409, %t410
  br label %logical_and_entry_408

logical_and_entry_408:
  br i1 %t411, label %logical_and_right_408, label %logical_and_merge_408

logical_and_right_408:
  %t413 = load double, double* %l5
  %t414 = sitofp i64 0 to double
  %t415 = fcmp oeq double %t413, %t414
  br label %logical_and_entry_412

logical_and_entry_412:
  br i1 %t415, label %logical_and_right_412, label %logical_and_merge_412

logical_and_right_412:
  %t417 = load double, double* %l6
  %t418 = sitofp i64 0 to double
  %t419 = fcmp oeq double %t417, %t418
  br label %logical_and_entry_416

logical_and_entry_416:
  br i1 %t419, label %logical_and_right_416, label %logical_and_merge_416

logical_and_right_416:
  %t420 = load double, double* %l7
  %t421 = sitofp i64 0 to double
  %t422 = fcmp oeq double %t420, %t421
  br label %logical_and_right_end_416

logical_and_right_end_416:
  br label %logical_and_merge_416

logical_and_merge_416:
  %t423 = phi i1 [ false, %logical_and_entry_416 ], [ %t422, %logical_and_right_end_416 ]
  br label %logical_and_right_end_412

logical_and_right_end_412:
  br label %logical_and_merge_412

logical_and_merge_412:
  %t424 = phi i1 [ false, %logical_and_entry_412 ], [ %t423, %logical_and_right_end_412 ]
  br label %logical_and_right_end_408

logical_and_right_end_408:
  br label %logical_and_merge_408

logical_and_merge_408:
  %t425 = phi i1 [ false, %logical_and_entry_408 ], [ %t424, %logical_and_right_end_408 ]
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t427 = load i8*, i8** %l1
  %t428 = load double, double* %l2
  %t429 = load i8*, i8** %l3
  %t430 = load double, double* %l4
  %t431 = load double, double* %l5
  %t432 = load double, double* %l6
  %t433 = load double, double* %l7
  %t434 = load i8, i8* %l8
  br i1 %t425, label %then42, label %merge43
then42:
  %t435 = load i8*, i8** %l1
  %t436 = call i8* @trim_text(i8* %t435)
  store i8* %t436, i8** %l9
  %t437 = load i8*, i8** %l9
  %t438 = call i64 @sailfin_runtime_string_length(i8* %t437)
  %t439 = icmp sgt i64 %t438, 0
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t441 = load i8*, i8** %l1
  %t442 = load double, double* %l2
  %t443 = load i8*, i8** %l3
  %t444 = load double, double* %l4
  %t445 = load double, double* %l5
  %t446 = load double, double* %l6
  %t447 = load double, double* %l7
  %t448 = load i8, i8* %l8
  %t449 = load i8*, i8** %l9
  br i1 %t439, label %then44, label %merge45
then44:
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t451 = load i8*, i8** %l9
  %t452 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t450, i8* %t451)
  store { i8**, i64 }* %t452, { i8**, i64 }** %l0
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t454 = phi { i8**, i64 }* [ %t453, %then44 ], [ %t440, %then42 ]
  store { i8**, i64 }* %t454, { i8**, i64 }** %l0
  %t455 = call i8* @malloc(i64 1)
  %t456 = bitcast i8* %t455 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t456
  store i8* %t455, i8** %l1
  %t457 = load double, double* %l2
  %t458 = sitofp i64 1 to double
  %t459 = fadd double %t457, %t458
  store double %t459, double* %l2
  br label %loop.latch2
merge43:
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t461 = load i8*, i8** %l1
  %t462 = load double, double* %l2
  br label %merge41
merge41:
  %t463 = phi { i8**, i64 }* [ %t460, %merge43 ], [ %t399, %merge37 ]
  %t464 = phi i8* [ %t461, %merge43 ], [ %t400, %merge37 ]
  %t465 = phi double [ %t462, %merge43 ], [ %t401, %merge37 ]
  store { i8**, i64 }* %t463, { i8**, i64 }** %l0
  store i8* %t464, i8** %l1
  store double %t465, double* %l2
  %t466 = load i8*, i8** %l1
  %t467 = load i8, i8* %l8
  %t468 = add i64 0, 2
  %t469 = call i8* @malloc(i64 %t468)
  store i8 %t467, i8* %t469
  %t470 = getelementptr i8, i8* %t469, i64 1
  store i8 0, i8* %t470
  call void @sailfin_runtime_mark_persistent(i8* %t469)
  %t471 = call i8* @sailfin_runtime_string_concat(i8* %t466, i8* %t469)
  store i8* %t471, i8** %l1
  %t472 = load double, double* %l2
  %t473 = sitofp i64 1 to double
  %t474 = fadd double %t472, %t473
  store double %t474, double* %l2
  br label %loop.latch2
loop.latch2:
  %t475 = load i8*, i8** %l1
  %t476 = load double, double* %l2
  %t477 = load i8*, i8** %l3
  %t478 = load double, double* %l4
  %t479 = load double, double* %l5
  %t480 = load double, double* %l6
  %t481 = load double, double* %l7
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t491 = load i8*, i8** %l1
  %t492 = load double, double* %l2
  %t493 = load i8*, i8** %l3
  %t494 = load double, double* %l4
  %t495 = load double, double* %l5
  %t496 = load double, double* %l6
  %t497 = load double, double* %l7
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t499 = load i8*, i8** %l1
  %t500 = call i8* @trim_text(i8* %t499)
  store i8* %t500, i8** %l10
  %t501 = load i8*, i8** %l10
  %t502 = call i64 @sailfin_runtime_string_length(i8* %t501)
  %t503 = icmp sgt i64 %t502, 0
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t505 = load i8*, i8** %l1
  %t506 = load double, double* %l2
  %t507 = load i8*, i8** %l3
  %t508 = load double, double* %l4
  %t509 = load double, double* %l5
  %t510 = load double, double* %l6
  %t511 = load double, double* %l7
  %t512 = load i8*, i8** %l10
  br i1 %t503, label %then46, label %merge47
then46:
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t514 = load i8*, i8** %l10
  %t515 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t513, i8* %t514)
  store { i8**, i64 }* %t515, { i8**, i64 }** %l0
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t517 = phi { i8**, i64 }* [ %t516, %then46 ], [ %t504, %afterloop3 ]
  store { i8**, i64 }* %t517, { i8**, i64 }** %l0
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t518
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
  %l19 = alloca i8*
  %l20 = alloca %EnumLayoutHeaderParse
  %l21 = alloca %EnumLayoutVariantParse
  %l22 = alloca double
  %l23 = alloca %EnumLayoutPayloadParse
  %l24 = alloca double
  %l25 = alloca %NativeEnumVariant*
  %l26 = alloca %NativeEnumLayout*
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
  %t22 = call i8* @malloc(i64 7)
  %t23 = bitcast i8* %t22 to [7 x i8]*
  store [7 x i8] c".enum \00", [7 x i8]* %t23
  %t24 = call i8* @strip_prefix(i8* %t21, i8* %t22)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  store i8* %t26, i8** %l3
  %t27 = load i8*, i8** %l3
  %t28 = add i64 0, 2
  %t29 = call i8* @malloc(i64 %t28)
  store i8 32, i8* %t29
  %t30 = getelementptr i8, i8* %t29, i64 1
  store i8 0, i8* %t30
  call void @sailfin_runtime_mark_persistent(i8* %t29)
  %t31 = call double @index_of(i8* %t27, i8* %t29)
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
  %t59 = call i8* @malloc(i64 30)
  %t60 = bitcast i8* %t59 to [30 x i8]*
  store [30 x i8] c"unable to parse enum header: \00", [30 x i8]* %t60
  %t61 = load i8*, i8** %l1
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t61)
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  %t64 = bitcast i8* null to %NativeEnum*
  %t65 = insertvalue %EnumParseResult undef, %NativeEnum* %t64, 0
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %start_index, %t66
  %t68 = insertvalue %EnumParseResult %t65, double %t67, 1
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = insertvalue %EnumParseResult %t68, { i8**, i64 }* %t69, 2
  ret %EnumParseResult %t70
merge3:
  %t71 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t72 = ptrtoint [0 x %NativeEnumVariant]* %t71 to i64
  %t73 = icmp eq i64 %t72, 0
  %t74 = select i1 %t73, i64 1, i64 %t72
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to %NativeEnumVariant*
  %t77 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t78 = ptrtoint { %NativeEnumVariant*, i64 }* %t77 to i64
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to { %NativeEnumVariant*, i64 }*
  %t81 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t80, i32 0, i32 0
  store %NativeEnumVariant* %t76, %NativeEnumVariant** %t81
  %t82 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t80, i32 0, i32 1
  store i64 0, i64* %t82
  store { %NativeEnumVariant*, i64 }* %t80, { %NativeEnumVariant*, i64 }** %l5
  %t83 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t84 = ptrtoint [0 x %NativeEnumVariantLayout]* %t83 to i64
  %t85 = icmp eq i64 %t84, 0
  %t86 = select i1 %t85, i64 1, i64 %t84
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to %NativeEnumVariantLayout*
  %t89 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t90 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t89 to i64
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to { %NativeEnumVariantLayout*, i64 }*
  %t93 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t92, i32 0, i32 0
  store %NativeEnumVariantLayout* %t88, %NativeEnumVariantLayout** %t93
  %t94 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t92, i32 0, i32 1
  store i64 0, i64* %t94
  store { %NativeEnumVariantLayout*, i64 }* %t92, { %NativeEnumVariantLayout*, i64 }** %l6
  %t95 = sitofp i64 0 to double
  store double %t95, double* %l7
  %t96 = sitofp i64 0 to double
  store double %t96, double* %l8
  %t97 = call i8* @malloc(i64 1)
  %t98 = bitcast i8* %t97 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t98
  store i8* %t97, i8** %l9
  %t99 = sitofp i64 0 to double
  store double %t99, double* %l10
  %t100 = sitofp i64 0 to double
  store double %t100, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %start_index, %t101
  store double %t102, double* %l14
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load i8*, i8** %l2
  %t106 = load i8*, i8** %l3
  %t107 = load double, double* %l4
  %t108 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t109 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t110 = load double, double* %l7
  %t111 = load double, double* %l8
  %t112 = load i8*, i8** %l9
  %t113 = load double, double* %l10
  %t114 = load double, double* %l11
  %t115 = load i1, i1* %l12
  %t116 = load i1, i1* %l13
  %t117 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t964 = phi { i8**, i64 }* [ %t103, %merge3 ], [ %t953, %loop.latch6 ]
  %t965 = phi double [ %t117, %merge3 ], [ %t954, %loop.latch6 ]
  %t966 = phi double [ %t110, %merge3 ], [ %t955, %loop.latch6 ]
  %t967 = phi double [ %t111, %merge3 ], [ %t956, %loop.latch6 ]
  %t968 = phi i8* [ %t112, %merge3 ], [ %t957, %loop.latch6 ]
  %t969 = phi double [ %t113, %merge3 ], [ %t958, %loop.latch6 ]
  %t970 = phi double [ %t114, %merge3 ], [ %t959, %loop.latch6 ]
  %t971 = phi i1 [ %t115, %merge3 ], [ %t960, %loop.latch6 ]
  %t972 = phi { %NativeEnumVariantLayout*, i64 }* [ %t109, %merge3 ], [ %t961, %loop.latch6 ]
  %t973 = phi i1 [ %t116, %merge3 ], [ %t962, %loop.latch6 ]
  %t974 = phi { %NativeEnumVariant*, i64 }* [ %t108, %merge3 ], [ %t963, %loop.latch6 ]
  store { i8**, i64 }* %t964, { i8**, i64 }** %l0
  store double %t965, double* %l14
  store double %t966, double* %l7
  store double %t967, double* %l8
  store i8* %t968, i8** %l9
  store double %t969, double* %l10
  store double %t970, double* %l11
  store i1 %t971, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t972, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t973, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t974, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t118 = load double, double* %l14
  %t119 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t120 = extractvalue { i8**, i64 } %t119, 1
  %t121 = sitofp i64 %t120 to double
  %t122 = fcmp oge double %t118, %t121
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load i8*, i8** %l1
  %t125 = load i8*, i8** %l2
  %t126 = load i8*, i8** %l3
  %t127 = load double, double* %l4
  %t128 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t129 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t130 = load double, double* %l7
  %t131 = load double, double* %l8
  %t132 = load i8*, i8** %l9
  %t133 = load double, double* %l10
  %t134 = load double, double* %l11
  %t135 = load i1, i1* %l12
  %t136 = load i1, i1* %l13
  %t137 = load double, double* %l14
  br i1 %t122, label %then8, label %merge9
then8:
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = call i8* @malloc(i64 19)
  %t140 = bitcast i8* %t139 to [19 x i8]*
  store [19 x i8] c"unterminated enum \00", [19 x i8]* %t140
  %t141 = load i8*, i8** %l3
  %t142 = call i8* @sailfin_runtime_string_concat(i8* %t139, i8* %t141)
  %t143 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t138, i8* %t142)
  store { i8**, i64 }* %t143, { i8**, i64 }** %l0
  %t144 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t144, %NativeEnumLayout** %l15
  %t145 = load i1, i1* %l12
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load i8*, i8** %l1
  %t148 = load i8*, i8** %l2
  %t149 = load i8*, i8** %l3
  %t150 = load double, double* %l4
  %t151 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t152 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t153 = load double, double* %l7
  %t154 = load double, double* %l8
  %t155 = load i8*, i8** %l9
  %t156 = load double, double* %l10
  %t157 = load double, double* %l11
  %t158 = load i1, i1* %l12
  %t159 = load i1, i1* %l13
  %t160 = load double, double* %l14
  %t161 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br i1 %t145, label %then10, label %merge11
then10:
  %t162 = load double, double* %l7
  %t163 = insertvalue %NativeEnumLayout undef, double %t162, 0
  %t164 = load double, double* %l8
  %t165 = insertvalue %NativeEnumLayout %t163, double %t164, 1
  %t166 = load i8*, i8** %l9
  %t167 = insertvalue %NativeEnumLayout %t165, i8* %t166, 2
  %t168 = load double, double* %l10
  %t169 = insertvalue %NativeEnumLayout %t167, double %t168, 3
  %t170 = load double, double* %l11
  %t171 = insertvalue %NativeEnumLayout %t169, double %t170, 4
  %t172 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t173 = insertvalue %NativeEnumLayout %t171, { %NativeEnumVariantLayout*, i64 }* %t172, 5
  %t174 = getelementptr %NativeEnumLayout, %NativeEnumLayout* null, i32 1
  %t175 = ptrtoint %NativeEnumLayout* %t174 to i64
  %t176 = call noalias i8* @malloc(i64 %t175)
  %t177 = bitcast i8* %t176 to %NativeEnumLayout*
  store %NativeEnumLayout %t173, %NativeEnumLayout* %t177
  call void @sailfin_runtime_mark_persistent(i8* %t176)
  store %NativeEnumLayout* %t177, %NativeEnumLayout** %l15
  %t178 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t179 = phi %NativeEnumLayout* [ %t178, %then10 ], [ %t161, %then8 ]
  store %NativeEnumLayout* %t179, %NativeEnumLayout** %l15
  %t180 = load i8*, i8** %l3
  %t181 = insertvalue %NativeEnum undef, i8* %t180, 0
  %t182 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t183 = insertvalue %NativeEnum %t181, { %NativeEnumVariant*, i64 }* %t182, 1
  %t184 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t185 = insertvalue %NativeEnum %t183, %NativeEnumLayout* %t184, 2
  %t186 = getelementptr %NativeEnum, %NativeEnum* null, i32 1
  %t187 = ptrtoint %NativeEnum* %t186 to i64
  %t188 = call noalias i8* @malloc(i64 %t187)
  %t189 = bitcast i8* %t188 to %NativeEnum*
  store %NativeEnum %t185, %NativeEnum* %t189
  call void @sailfin_runtime_mark_persistent(i8* %t188)
  %t190 = insertvalue %EnumParseResult undef, %NativeEnum* %t189, 0
  %t191 = load double, double* %l14
  %t192 = insertvalue %EnumParseResult %t190, double %t191, 1
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t194 = insertvalue %EnumParseResult %t192, { i8**, i64 }* %t193, 2
  ret %EnumParseResult %t194
merge9:
  %t195 = load double, double* %l14
  %t196 = call double @llvm.round.f64(double %t195)
  %t197 = fptosi double %t196 to i64
  %t198 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t199 = extractvalue { i8**, i64 } %t198, 0
  %t200 = extractvalue { i8**, i64 } %t198, 1
  %t201 = icmp uge i64 %t197, %t200
  ; bounds check: %t201 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t197, i64 %t200)
  %t202 = getelementptr i8*, i8** %t199, i64 %t197
  %t203 = load i8*, i8** %t202
  %t204 = call i8* @trim_text(i8* %t203)
  store i8* %t204, i8** %l16
  %t206 = load i8*, i8** %l16
  %t207 = call i64 @sailfin_runtime_string_length(i8* %t206)
  %t208 = icmp eq i64 %t207, 0
  br label %logical_or_entry_205

logical_or_entry_205:
  br i1 %t208, label %logical_or_merge_205, label %logical_or_right_205

logical_or_right_205:
  %t209 = load i8*, i8** %l16
  %t210 = add i64 0, 2
  %t211 = call i8* @malloc(i64 %t210)
  store i8 59, i8* %t211
  %t212 = getelementptr i8, i8* %t211, i64 1
  store i8 0, i8* %t212
  call void @sailfin_runtime_mark_persistent(i8* %t211)
  %t213 = call i1 @starts_with(i8* %t209, i8* %t211)
  br label %logical_or_right_end_205

logical_or_right_end_205:
  br label %logical_or_merge_205

logical_or_merge_205:
  %t214 = phi i1 [ true, %logical_or_entry_205 ], [ %t213, %logical_or_right_end_205 ]
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t216 = load i8*, i8** %l1
  %t217 = load i8*, i8** %l2
  %t218 = load i8*, i8** %l3
  %t219 = load double, double* %l4
  %t220 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t221 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t222 = load double, double* %l7
  %t223 = load double, double* %l8
  %t224 = load i8*, i8** %l9
  %t225 = load double, double* %l10
  %t226 = load double, double* %l11
  %t227 = load i1, i1* %l12
  %t228 = load i1, i1* %l13
  %t229 = load double, double* %l14
  %t230 = load i8*, i8** %l16
  br i1 %t214, label %then12, label %merge13
then12:
  %t231 = load double, double* %l14
  %t232 = sitofp i64 1 to double
  %t233 = fadd double %t231, %t232
  store double %t233, double* %l14
  br label %loop.latch6
merge13:
  %t234 = load i8*, i8** %l16
  %t235 = call i8* @malloc(i64 5)
  %t236 = bitcast i8* %t235 to [5 x i8]*
  store [5 x i8] c"noop\00", [5 x i8]* %t236
  %t237 = call i1 @strings_equal(i8* %t234, i8* %t235)
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load i8*, i8** %l1
  %t240 = load i8*, i8** %l2
  %t241 = load i8*, i8** %l3
  %t242 = load double, double* %l4
  %t243 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t244 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t245 = load double, double* %l7
  %t246 = load double, double* %l8
  %t247 = load i8*, i8** %l9
  %t248 = load double, double* %l10
  %t249 = load double, double* %l11
  %t250 = load i1, i1* %l12
  %t251 = load i1, i1* %l13
  %t252 = load double, double* %l14
  %t253 = load i8*, i8** %l16
  br i1 %t237, label %then14, label %merge15
then14:
  %t254 = load double, double* %l14
  %t255 = sitofp i64 1 to double
  %t256 = fadd double %t254, %t255
  store double %t256, double* %l14
  br label %loop.latch6
merge15:
  %t257 = load i8*, i8** %l16
  %t258 = call i8* @malloc(i64 9)
  %t259 = bitcast i8* %t258 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t259
  %t260 = call i1 @starts_with(i8* %t257, i8* %t258)
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load i8*, i8** %l1
  %t263 = load i8*, i8** %l2
  %t264 = load i8*, i8** %l3
  %t265 = load double, double* %l4
  %t266 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t267 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t268 = load double, double* %l7
  %t269 = load double, double* %l8
  %t270 = load i8*, i8** %l9
  %t271 = load double, double* %l10
  %t272 = load double, double* %l11
  %t273 = load i1, i1* %l12
  %t274 = load i1, i1* %l13
  %t275 = load double, double* %l14
  %t276 = load i8*, i8** %l16
  br i1 %t260, label %then16, label %merge17
then16:
  %t277 = load i8*, i8** %l16
  %t278 = call i8* @malloc(i64 9)
  %t279 = bitcast i8* %t278 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t279
  %t280 = call i8* @strip_prefix(i8* %t277, i8* %t278)
  store i8* %t280, i8** %l17
  %t281 = load i8*, i8** %l17
  %t282 = call i8* @malloc(i64 6)
  %t283 = bitcast i8* %t282 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t283
  %t284 = call i1 @starts_with(i8* %t281, i8* %t282)
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t286 = load i8*, i8** %l1
  %t287 = load i8*, i8** %l2
  %t288 = load i8*, i8** %l3
  %t289 = load double, double* %l4
  %t290 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t291 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t292 = load double, double* %l7
  %t293 = load double, double* %l8
  %t294 = load i8*, i8** %l9
  %t295 = load double, double* %l10
  %t296 = load double, double* %l11
  %t297 = load i1, i1* %l12
  %t298 = load i1, i1* %l13
  %t299 = load double, double* %l14
  %t300 = load i8*, i8** %l16
  %t301 = load i8*, i8** %l17
  br i1 %t284, label %then18, label %merge19
then18:
  %t302 = load i8*, i8** %l17
  %t303 = call i8* @malloc(i64 6)
  %t304 = bitcast i8* %t303 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t304
  %t305 = call i8* @strip_prefix(i8* %t302, i8* %t303)
  %t306 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t305)
  store %EnumLayoutHeaderParse %t306, %EnumLayoutHeaderParse* %l18
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t308 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t309 = extractvalue %EnumLayoutHeaderParse %t308, 7
  %t310 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t307, { i8**, i64 }* %t309)
  store { i8**, i64 }* %t310, { i8**, i64 }** %l0
  %t311 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t312 = extractvalue %EnumLayoutHeaderParse %t311, 0
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t314 = load i8*, i8** %l1
  %t315 = load i8*, i8** %l2
  %t316 = load i8*, i8** %l3
  %t317 = load double, double* %l4
  %t318 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t319 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t320 = load double, double* %l7
  %t321 = load double, double* %l8
  %t322 = load i8*, i8** %l9
  %t323 = load double, double* %l10
  %t324 = load double, double* %l11
  %t325 = load i1, i1* %l12
  %t326 = load i1, i1* %l13
  %t327 = load double, double* %l14
  %t328 = load i8*, i8** %l16
  %t329 = load i8*, i8** %l17
  %t330 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t312, label %then20, label %merge21
then20:
  %t331 = load i1, i1* %l12
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t333 = load i8*, i8** %l1
  %t334 = load i8*, i8** %l2
  %t335 = load i8*, i8** %l3
  %t336 = load double, double* %l4
  %t337 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t338 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t339 = load double, double* %l7
  %t340 = load double, double* %l8
  %t341 = load i8*, i8** %l9
  %t342 = load double, double* %l10
  %t343 = load double, double* %l11
  %t344 = load i1, i1* %l12
  %t345 = load i1, i1* %l13
  %t346 = load double, double* %l14
  %t347 = load i8*, i8** %l16
  %t348 = load i8*, i8** %l17
  %t349 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t331, label %then22, label %else23
then22:
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t351 = call i8* @malloc(i64 33)
  %t352 = bitcast i8* %t351 to [33 x i8]*
  store [33 x i8] c"duplicate enum layout header in \00", [33 x i8]* %t352
  %t353 = load i8*, i8** %l3
  %t354 = call i8* @sailfin_runtime_string_concat(i8* %t351, i8* %t353)
  %t355 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t350, i8* %t354)
  store { i8**, i64 }* %t355, { i8**, i64 }** %l0
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t357 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t358 = extractvalue %EnumLayoutHeaderParse %t357, 2
  store double %t358, double* %l7
  %t359 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t360 = extractvalue %EnumLayoutHeaderParse %t359, 3
  store double %t360, double* %l8
  %t361 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t362 = extractvalue %EnumLayoutHeaderParse %t361, 4
  store i8* %t362, i8** %l9
  %t363 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t364 = extractvalue %EnumLayoutHeaderParse %t363, 5
  store double %t364, double* %l10
  %t365 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t366 = extractvalue %EnumLayoutHeaderParse %t365, 6
  store double %t366, double* %l11
  store i1 1, i1* %l12
  %t367 = load double, double* %l7
  %t368 = load double, double* %l8
  %t369 = load i8*, i8** %l9
  %t370 = load double, double* %l10
  %t371 = load double, double* %l11
  %t372 = load i1, i1* %l12
  br label %merge24
merge24:
  %t373 = phi { i8**, i64 }* [ %t356, %then22 ], [ %t332, %else23 ]
  %t374 = phi double [ %t339, %then22 ], [ %t367, %else23 ]
  %t375 = phi double [ %t340, %then22 ], [ %t368, %else23 ]
  %t376 = phi i8* [ %t341, %then22 ], [ %t369, %else23 ]
  %t377 = phi double [ %t342, %then22 ], [ %t370, %else23 ]
  %t378 = phi double [ %t343, %then22 ], [ %t371, %else23 ]
  %t379 = phi i1 [ %t344, %then22 ], [ %t372, %else23 ]
  store { i8**, i64 }* %t373, { i8**, i64 }** %l0
  store double %t374, double* %l7
  store double %t375, double* %l8
  store i8* %t376, i8** %l9
  store double %t377, double* %l10
  store double %t378, double* %l11
  store i1 %t379, i1* %l12
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load double, double* %l7
  %t382 = load double, double* %l8
  %t383 = load i8*, i8** %l9
  %t384 = load double, double* %l10
  %t385 = load double, double* %l11
  %t386 = load i1, i1* %l12
  br label %merge21
merge21:
  %t387 = phi { i8**, i64 }* [ %t380, %merge24 ], [ %t313, %then18 ]
  %t388 = phi double [ %t381, %merge24 ], [ %t320, %then18 ]
  %t389 = phi double [ %t382, %merge24 ], [ %t321, %then18 ]
  %t390 = phi i8* [ %t383, %merge24 ], [ %t322, %then18 ]
  %t391 = phi double [ %t384, %merge24 ], [ %t323, %then18 ]
  %t392 = phi double [ %t385, %merge24 ], [ %t324, %then18 ]
  %t393 = phi i1 [ %t386, %merge24 ], [ %t325, %then18 ]
  store { i8**, i64 }* %t387, { i8**, i64 }** %l0
  store double %t388, double* %l7
  store double %t389, double* %l8
  store i8* %t390, i8** %l9
  store double %t391, double* %l10
  store double %t392, double* %l11
  store i1 %t393, i1* %l12
  %t394 = load double, double* %l14
  %t395 = sitofp i64 1 to double
  %t396 = fadd double %t394, %t395
  store double %t396, double* %l14
  br label %loop.latch6
merge19:
  %t397 = load i8*, i8** %l17
  %t398 = call i8* @malloc(i64 9)
  %t399 = bitcast i8* %t398 to [9 x i8]*
  store [9 x i8] c"variant \00", [9 x i8]* %t399
  %t400 = call i1 @starts_with(i8* %t397, i8* %t398)
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t402 = load i8*, i8** %l1
  %t403 = load i8*, i8** %l2
  %t404 = load i8*, i8** %l3
  %t405 = load double, double* %l4
  %t406 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t407 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t408 = load double, double* %l7
  %t409 = load double, double* %l8
  %t410 = load i8*, i8** %l9
  %t411 = load double, double* %l10
  %t412 = load double, double* %l11
  %t413 = load i1, i1* %l12
  %t414 = load i1, i1* %l13
  %t415 = load double, double* %l14
  %t416 = load i8*, i8** %l16
  %t417 = load i8*, i8** %l17
  br i1 %t400, label %then25, label %merge26
then25:
  %t418 = load i8*, i8** %l17
  %t419 = call i8* @malloc(i64 9)
  %t420 = bitcast i8* %t419 to [9 x i8]*
  store [9 x i8] c"variant \00", [9 x i8]* %t420
  %t421 = call i8* @strip_prefix(i8* %t418, i8* %t419)
  store i8* %t421, i8** %l19
  %t422 = load i8*, i8** %l19
  %t423 = call i8* @malloc(i64 6)
  %t424 = bitcast i8* %t423 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t424
  %t425 = call i1 @starts_with(i8* %t422, i8* %t423)
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t427 = load i8*, i8** %l1
  %t428 = load i8*, i8** %l2
  %t429 = load i8*, i8** %l3
  %t430 = load double, double* %l4
  %t431 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t432 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t433 = load double, double* %l7
  %t434 = load double, double* %l8
  %t435 = load i8*, i8** %l9
  %t436 = load double, double* %l10
  %t437 = load double, double* %l11
  %t438 = load i1, i1* %l12
  %t439 = load i1, i1* %l13
  %t440 = load double, double* %l14
  %t441 = load i8*, i8** %l16
  %t442 = load i8*, i8** %l17
  %t443 = load i8*, i8** %l19
  br i1 %t425, label %then27, label %merge28
then27:
  %t444 = load i8*, i8** %l19
  %t445 = call i8* @malloc(i64 6)
  %t446 = bitcast i8* %t445 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t446
  %t447 = call i8* @strip_prefix(i8* %t444, i8* %t445)
  %t448 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t447)
  store %EnumLayoutHeaderParse %t448, %EnumLayoutHeaderParse* %l20
  %t449 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  %t450 = extractvalue %EnumLayoutHeaderParse %t449, 0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t452 = load i8*, i8** %l1
  %t453 = load i8*, i8** %l2
  %t454 = load i8*, i8** %l3
  %t455 = load double, double* %l4
  %t456 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t457 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t458 = load double, double* %l7
  %t459 = load double, double* %l8
  %t460 = load i8*, i8** %l9
  %t461 = load double, double* %l10
  %t462 = load double, double* %l11
  %t463 = load i1, i1* %l12
  %t464 = load i1, i1* %l13
  %t465 = load double, double* %l14
  %t466 = load i8*, i8** %l16
  %t467 = load i8*, i8** %l17
  %t468 = load i8*, i8** %l19
  %t469 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  br i1 %t450, label %then29, label %merge30
then29:
  %t470 = load i1, i1* %l12
  %t471 = xor i1 %t470, 1
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t473 = load i8*, i8** %l1
  %t474 = load i8*, i8** %l2
  %t475 = load i8*, i8** %l3
  %t476 = load double, double* %l4
  %t477 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t478 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t479 = load double, double* %l7
  %t480 = load double, double* %l8
  %t481 = load i8*, i8** %l9
  %t482 = load double, double* %l10
  %t483 = load double, double* %l11
  %t484 = load i1, i1* %l12
  %t485 = load i1, i1* %l13
  %t486 = load double, double* %l14
  %t487 = load i8*, i8** %l16
  %t488 = load i8*, i8** %l17
  %t489 = load i8*, i8** %l19
  %t490 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  br i1 %t471, label %then31, label %merge32
then31:
  %t491 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  %t492 = extractvalue %EnumLayoutHeaderParse %t491, 2
  store double %t492, double* %l7
  %t493 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  %t494 = extractvalue %EnumLayoutHeaderParse %t493, 3
  store double %t494, double* %l8
  %t495 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  %t496 = extractvalue %EnumLayoutHeaderParse %t495, 4
  store i8* %t496, i8** %l9
  %t497 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  %t498 = extractvalue %EnumLayoutHeaderParse %t497, 5
  store double %t498, double* %l10
  %t499 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l20
  %t500 = extractvalue %EnumLayoutHeaderParse %t499, 6
  store double %t500, double* %l11
  store i1 1, i1* %l12
  %t501 = load double, double* %l7
  %t502 = load double, double* %l8
  %t503 = load i8*, i8** %l9
  %t504 = load double, double* %l10
  %t505 = load double, double* %l11
  %t506 = load i1, i1* %l12
  br label %merge32
merge32:
  %t507 = phi double [ %t501, %then31 ], [ %t479, %then29 ]
  %t508 = phi double [ %t502, %then31 ], [ %t480, %then29 ]
  %t509 = phi i8* [ %t503, %then31 ], [ %t481, %then29 ]
  %t510 = phi double [ %t504, %then31 ], [ %t482, %then29 ]
  %t511 = phi double [ %t505, %then31 ], [ %t483, %then29 ]
  %t512 = phi i1 [ %t506, %then31 ], [ %t484, %then29 ]
  store double %t507, double* %l7
  store double %t508, double* %l8
  store i8* %t509, i8** %l9
  store double %t510, double* %l10
  store double %t511, double* %l11
  store i1 %t512, i1* %l12
  %t513 = load double, double* %l14
  %t514 = sitofp i64 1 to double
  %t515 = fadd double %t513, %t514
  store double %t515, double* %l14
  br label %loop.latch6
merge30:
  %t516 = load double, double* %l7
  %t517 = load double, double* %l8
  %t518 = load i8*, i8** %l9
  %t519 = load double, double* %l10
  %t520 = load double, double* %l11
  %t521 = load i1, i1* %l12
  %t522 = load double, double* %l14
  br label %merge28
merge28:
  %t523 = phi double [ %t516, %merge30 ], [ %t433, %then25 ]
  %t524 = phi double [ %t517, %merge30 ], [ %t434, %then25 ]
  %t525 = phi i8* [ %t518, %merge30 ], [ %t435, %then25 ]
  %t526 = phi double [ %t519, %merge30 ], [ %t436, %then25 ]
  %t527 = phi double [ %t520, %merge30 ], [ %t437, %then25 ]
  %t528 = phi i1 [ %t521, %merge30 ], [ %t438, %then25 ]
  %t529 = phi double [ %t522, %merge30 ], [ %t440, %then25 ]
  store double %t523, double* %l7
  store double %t524, double* %l8
  store i8* %t525, i8** %l9
  store double %t526, double* %l10
  store double %t527, double* %l11
  store i1 %t528, i1* %l12
  store double %t529, double* %l14
  %t530 = load i8*, i8** %l19
  %t531 = load i8*, i8** %l3
  %t532 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t530, i8* %t531)
  store %EnumLayoutVariantParse %t532, %EnumLayoutVariantParse* %l21
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t534 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t535 = extractvalue %EnumLayoutVariantParse %t534, 2
  %t536 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t533, { i8**, i64 }* %t535)
  store { i8**, i64 }* %t536, { i8**, i64 }** %l0
  %t537 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t538 = extractvalue %EnumLayoutVariantParse %t537, 0
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t540 = load i8*, i8** %l1
  %t541 = load i8*, i8** %l2
  %t542 = load i8*, i8** %l3
  %t543 = load double, double* %l4
  %t544 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t545 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t546 = load double, double* %l7
  %t547 = load double, double* %l8
  %t548 = load i8*, i8** %l9
  %t549 = load double, double* %l10
  %t550 = load double, double* %l11
  %t551 = load i1, i1* %l12
  %t552 = load i1, i1* %l13
  %t553 = load double, double* %l14
  %t554 = load i8*, i8** %l16
  %t555 = load i8*, i8** %l17
  %t556 = load i8*, i8** %l19
  %t557 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  br i1 %t538, label %then33, label %merge34
then33:
  %t558 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t559 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t560 = extractvalue %EnumLayoutVariantParse %t559, 1
  %t561 = extractvalue %NativeEnumVariantLayout %t560, 0
  %t562 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t558, i8* %t561)
  store double %t562, double* %l22
  %t563 = load double, double* %l22
  %t564 = sitofp i64 0 to double
  %t565 = fcmp oge double %t563, %t564
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t567 = load i8*, i8** %l1
  %t568 = load i8*, i8** %l2
  %t569 = load i8*, i8** %l3
  %t570 = load double, double* %l4
  %t571 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t572 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t573 = load double, double* %l7
  %t574 = load double, double* %l8
  %t575 = load i8*, i8** %l9
  %t576 = load double, double* %l10
  %t577 = load double, double* %l11
  %t578 = load i1, i1* %l12
  %t579 = load i1, i1* %l13
  %t580 = load double, double* %l14
  %t581 = load i8*, i8** %l16
  %t582 = load i8*, i8** %l17
  %t583 = load i8*, i8** %l19
  %t584 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t585 = load double, double* %l22
  br i1 %t565, label %then35, label %else36
then35:
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t587 = call i8* @malloc(i64 32)
  %t588 = bitcast i8* %t587 to [32 x i8]*
  store [32 x i8] c"duplicate enum layout variant `\00", [32 x i8]* %t588
  %t589 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t590 = extractvalue %EnumLayoutVariantParse %t589, 1
  %t591 = extractvalue %NativeEnumVariantLayout %t590, 0
  %t592 = call i8* @sailfin_runtime_string_concat(i8* %t587, i8* %t591)
  %t593 = call i8* @malloc(i64 6)
  %t594 = bitcast i8* %t593 to [6 x i8]*
  store [6 x i8] c"` in \00", [6 x i8]* %t594
  %t595 = call i8* @sailfin_runtime_string_concat(i8* %t592, i8* %t593)
  %t596 = load i8*, i8** %l3
  %t597 = call i8* @sailfin_runtime_string_concat(i8* %t595, i8* %t596)
  %t598 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t586, i8* %t597)
  store { i8**, i64 }* %t598, { i8**, i64 }** %l0
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge37
else36:
  %t600 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t601 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t602 = extractvalue %EnumLayoutVariantParse %t601, 1
  %t603 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t600, %NativeEnumVariantLayout %t602)
  store { %NativeEnumVariantLayout*, i64 }* %t603, { %NativeEnumVariantLayout*, i64 }** %l6
  %t604 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge37
merge37:
  %t605 = phi { i8**, i64 }* [ %t599, %then35 ], [ %t566, %else36 ]
  %t606 = phi { %NativeEnumVariantLayout*, i64 }* [ %t572, %then35 ], [ %t604, %else36 ]
  store { i8**, i64 }* %t605, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t606, { %NativeEnumVariantLayout*, i64 }** %l6
  %t607 = load i1, i1* %l12
  %t608 = xor i1 %t607, 1
  %t609 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t610 = load i8*, i8** %l1
  %t611 = load i8*, i8** %l2
  %t612 = load i8*, i8** %l3
  %t613 = load double, double* %l4
  %t614 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t615 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t616 = load double, double* %l7
  %t617 = load double, double* %l8
  %t618 = load i8*, i8** %l9
  %t619 = load double, double* %l10
  %t620 = load double, double* %l11
  %t621 = load i1, i1* %l12
  %t622 = load i1, i1* %l13
  %t623 = load double, double* %l14
  %t624 = load i8*, i8** %l16
  %t625 = load i8*, i8** %l17
  %t626 = load i8*, i8** %l19
  %t627 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t628 = load double, double* %l22
  br i1 %t608, label %then38, label %merge39
then38:
  %t629 = load i1, i1* %l13
  %t630 = xor i1 %t629, 1
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t632 = load i8*, i8** %l1
  %t633 = load i8*, i8** %l2
  %t634 = load i8*, i8** %l3
  %t635 = load double, double* %l4
  %t636 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t637 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t638 = load double, double* %l7
  %t639 = load double, double* %l8
  %t640 = load i8*, i8** %l9
  %t641 = load double, double* %l10
  %t642 = load double, double* %l11
  %t643 = load i1, i1* %l12
  %t644 = load i1, i1* %l13
  %t645 = load double, double* %l14
  %t646 = load i8*, i8** %l16
  %t647 = load i8*, i8** %l17
  %t648 = load i8*, i8** %l19
  %t649 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l21
  %t650 = load double, double* %l22
  br i1 %t630, label %then40, label %merge41
then40:
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t652 = call i8* @malloc(i64 6)
  %t653 = bitcast i8* %t652 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t653
  %t654 = load i8*, i8** %l3
  %t655 = call i8* @sailfin_runtime_string_concat(i8* %t652, i8* %t654)
  %t656 = call i8* @malloc(i64 49)
  %t657 = bitcast i8* %t656 to [49 x i8]*
  store [49 x i8] c" layout variant encountered before layout header\00", [49 x i8]* %t657
  %t658 = call i8* @sailfin_runtime_string_concat(i8* %t655, i8* %t656)
  %t659 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t651, i8* %t658)
  store { i8**, i64 }* %t659, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t661 = load i1, i1* %l13
  br label %merge41
merge41:
  %t662 = phi { i8**, i64 }* [ %t660, %then40 ], [ %t631, %then38 ]
  %t663 = phi i1 [ %t661, %then40 ], [ %t644, %then38 ]
  store { i8**, i64 }* %t662, { i8**, i64 }** %l0
  store i1 %t663, i1* %l13
  %t664 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t665 = load i1, i1* %l13
  br label %merge39
merge39:
  %t666 = phi { i8**, i64 }* [ %t664, %merge41 ], [ %t609, %merge37 ]
  %t667 = phi i1 [ %t665, %merge41 ], [ %t622, %merge37 ]
  store { i8**, i64 }* %t666, { i8**, i64 }** %l0
  store i1 %t667, i1* %l13
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t669 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t671 = load i1, i1* %l13
  br label %merge34
merge34:
  %t672 = phi { i8**, i64 }* [ %t668, %merge39 ], [ %t539, %merge28 ]
  %t673 = phi { %NativeEnumVariantLayout*, i64 }* [ %t669, %merge39 ], [ %t545, %merge28 ]
  %t674 = phi { i8**, i64 }* [ %t670, %merge39 ], [ %t539, %merge28 ]
  %t675 = phi i1 [ %t671, %merge39 ], [ %t552, %merge28 ]
  store { i8**, i64 }* %t672, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t673, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t674, { i8**, i64 }** %l0
  store i1 %t675, i1* %l13
  %t676 = load double, double* %l14
  %t677 = sitofp i64 1 to double
  %t678 = fadd double %t676, %t677
  store double %t678, double* %l14
  br label %loop.latch6
merge26:
  %t679 = load i8*, i8** %l17
  %t680 = call i8* @malloc(i64 9)
  %t681 = bitcast i8* %t680 to [9 x i8]*
  store [9 x i8] c"payload \00", [9 x i8]* %t681
  %t682 = call i1 @starts_with(i8* %t679, i8* %t680)
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t684 = load i8*, i8** %l1
  %t685 = load i8*, i8** %l2
  %t686 = load i8*, i8** %l3
  %t687 = load double, double* %l4
  %t688 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t689 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t690 = load double, double* %l7
  %t691 = load double, double* %l8
  %t692 = load i8*, i8** %l9
  %t693 = load double, double* %l10
  %t694 = load double, double* %l11
  %t695 = load i1, i1* %l12
  %t696 = load i1, i1* %l13
  %t697 = load double, double* %l14
  %t698 = load i8*, i8** %l16
  %t699 = load i8*, i8** %l17
  br i1 %t682, label %then42, label %merge43
then42:
  %t700 = load i8*, i8** %l17
  %t701 = call i8* @malloc(i64 9)
  %t702 = bitcast i8* %t701 to [9 x i8]*
  store [9 x i8] c"payload \00", [9 x i8]* %t702
  %t703 = call i8* @strip_prefix(i8* %t700, i8* %t701)
  %t704 = load i8*, i8** %l3
  %t705 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t703, i8* %t704)
  store %EnumLayoutPayloadParse %t705, %EnumLayoutPayloadParse* %l23
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t707 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t708 = extractvalue %EnumLayoutPayloadParse %t707, 3
  %t709 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t706, { i8**, i64 }* %t708)
  store { i8**, i64 }* %t709, { i8**, i64 }** %l0
  %t710 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t711 = extractvalue %EnumLayoutPayloadParse %t710, 0
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t713 = load i8*, i8** %l1
  %t714 = load i8*, i8** %l2
  %t715 = load i8*, i8** %l3
  %t716 = load double, double* %l4
  %t717 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t718 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t719 = load double, double* %l7
  %t720 = load double, double* %l8
  %t721 = load i8*, i8** %l9
  %t722 = load double, double* %l10
  %t723 = load double, double* %l11
  %t724 = load i1, i1* %l12
  %t725 = load i1, i1* %l13
  %t726 = load double, double* %l14
  %t727 = load i8*, i8** %l16
  %t728 = load i8*, i8** %l17
  %t729 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  br i1 %t711, label %then44, label %merge45
then44:
  %t730 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t731 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t732 = extractvalue %EnumLayoutPayloadParse %t731, 1
  %t733 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t730, i8* %t732)
  store double %t733, double* %l24
  %t734 = load double, double* %l24
  %t735 = sitofp i64 0 to double
  %t736 = fcmp olt double %t734, %t735
  %t737 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t738 = load i8*, i8** %l1
  %t739 = load i8*, i8** %l2
  %t740 = load i8*, i8** %l3
  %t741 = load double, double* %l4
  %t742 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t743 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t744 = load double, double* %l7
  %t745 = load double, double* %l8
  %t746 = load i8*, i8** %l9
  %t747 = load double, double* %l10
  %t748 = load double, double* %l11
  %t749 = load i1, i1* %l12
  %t750 = load i1, i1* %l13
  %t751 = load double, double* %l14
  %t752 = load i8*, i8** %l16
  %t753 = load i8*, i8** %l17
  %t754 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t755 = load double, double* %l24
  br i1 %t736, label %then46, label %else47
then46:
  %t756 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t757 = call i8* @malloc(i64 6)
  %t758 = bitcast i8* %t757 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t758
  %t759 = load i8*, i8** %l3
  %t760 = call i8* @sailfin_runtime_string_concat(i8* %t757, i8* %t759)
  %t761 = call i8* @malloc(i64 45)
  %t762 = bitcast i8* %t761 to [45 x i8]*
  store [45 x i8] c" layout payload references unknown variant `\00", [45 x i8]* %t762
  %t763 = call i8* @sailfin_runtime_string_concat(i8* %t760, i8* %t761)
  %t764 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t765 = extractvalue %EnumLayoutPayloadParse %t764, 1
  %t766 = call i8* @sailfin_runtime_string_concat(i8* %t763, i8* %t765)
  %t767 = add i64 0, 2
  %t768 = call i8* @malloc(i64 %t767)
  store i8 96, i8* %t768
  %t769 = getelementptr i8, i8* %t768, i64 1
  store i8 0, i8* %t769
  call void @sailfin_runtime_mark_persistent(i8* %t768)
  %t770 = call i8* @sailfin_runtime_string_concat(i8* %t766, i8* %t768)
  %t771 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t756, i8* %t770)
  store { i8**, i64 }* %t771, { i8**, i64 }** %l0
  %t772 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge48
else47:
  %t773 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t774 = load double, double* %l24
  %t775 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t776 = extractvalue %EnumLayoutPayloadParse %t775, 2
  %t777 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t773, double %t774, %NativeStructLayoutField %t776)
  store { %NativeEnumVariantLayout*, i64 }* %t777, { %NativeEnumVariantLayout*, i64 }** %l6
  %t778 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge48
merge48:
  %t779 = phi { i8**, i64 }* [ %t772, %then46 ], [ %t737, %else47 ]
  %t780 = phi { %NativeEnumVariantLayout*, i64 }* [ %t743, %then46 ], [ %t778, %else47 ]
  store { i8**, i64 }* %t779, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t780, { %NativeEnumVariantLayout*, i64 }** %l6
  %t781 = load i1, i1* %l12
  %t782 = xor i1 %t781, 1
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t784 = load i8*, i8** %l1
  %t785 = load i8*, i8** %l2
  %t786 = load i8*, i8** %l3
  %t787 = load double, double* %l4
  %t788 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t789 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t790 = load double, double* %l7
  %t791 = load double, double* %l8
  %t792 = load i8*, i8** %l9
  %t793 = load double, double* %l10
  %t794 = load double, double* %l11
  %t795 = load i1, i1* %l12
  %t796 = load i1, i1* %l13
  %t797 = load double, double* %l14
  %t798 = load i8*, i8** %l16
  %t799 = load i8*, i8** %l17
  %t800 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t801 = load double, double* %l24
  br i1 %t782, label %then49, label %merge50
then49:
  %t802 = load i1, i1* %l13
  %t803 = xor i1 %t802, 1
  %t804 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t805 = load i8*, i8** %l1
  %t806 = load i8*, i8** %l2
  %t807 = load i8*, i8** %l3
  %t808 = load double, double* %l4
  %t809 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t810 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t811 = load double, double* %l7
  %t812 = load double, double* %l8
  %t813 = load i8*, i8** %l9
  %t814 = load double, double* %l10
  %t815 = load double, double* %l11
  %t816 = load i1, i1* %l12
  %t817 = load i1, i1* %l13
  %t818 = load double, double* %l14
  %t819 = load i8*, i8** %l16
  %t820 = load i8*, i8** %l17
  %t821 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l23
  %t822 = load double, double* %l24
  br i1 %t803, label %then51, label %merge52
then51:
  %t823 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t824 = call i8* @malloc(i64 6)
  %t825 = bitcast i8* %t824 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t825
  %t826 = load i8*, i8** %l3
  %t827 = call i8* @sailfin_runtime_string_concat(i8* %t824, i8* %t826)
  %t828 = call i8* @malloc(i64 49)
  %t829 = bitcast i8* %t828 to [49 x i8]*
  store [49 x i8] c" layout payload encountered before layout header\00", [49 x i8]* %t829
  %t830 = call i8* @sailfin_runtime_string_concat(i8* %t827, i8* %t828)
  %t831 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t823, i8* %t830)
  store { i8**, i64 }* %t831, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t832 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t833 = load i1, i1* %l13
  br label %merge52
merge52:
  %t834 = phi { i8**, i64 }* [ %t832, %then51 ], [ %t804, %then49 ]
  %t835 = phi i1 [ %t833, %then51 ], [ %t817, %then49 ]
  store { i8**, i64 }* %t834, { i8**, i64 }** %l0
  store i1 %t835, i1* %l13
  %t836 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t837 = load i1, i1* %l13
  br label %merge50
merge50:
  %t838 = phi { i8**, i64 }* [ %t836, %merge52 ], [ %t783, %merge48 ]
  %t839 = phi i1 [ %t837, %merge52 ], [ %t796, %merge48 ]
  store { i8**, i64 }* %t838, { i8**, i64 }** %l0
  store i1 %t839, i1* %l13
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t841 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t842 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t843 = load i1, i1* %l13
  br label %merge45
merge45:
  %t844 = phi { i8**, i64 }* [ %t840, %merge50 ], [ %t712, %then42 ]
  %t845 = phi { %NativeEnumVariantLayout*, i64 }* [ %t841, %merge50 ], [ %t718, %then42 ]
  %t846 = phi { i8**, i64 }* [ %t842, %merge50 ], [ %t712, %then42 ]
  %t847 = phi i1 [ %t843, %merge50 ], [ %t725, %then42 ]
  store { i8**, i64 }* %t844, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t845, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t846, { i8**, i64 }** %l0
  store i1 %t847, i1* %l13
  %t848 = load double, double* %l14
  %t849 = sitofp i64 1 to double
  %t850 = fadd double %t848, %t849
  store double %t850, double* %l14
  br label %loop.latch6
merge43:
  %t851 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t852 = call i8* @malloc(i64 36)
  %t853 = bitcast i8* %t852 to [36 x i8]*
  store [36 x i8] c"unsupported enum layout directive: \00", [36 x i8]* %t853
  %t854 = load i8*, i8** %l16
  %t855 = call i8* @sailfin_runtime_string_concat(i8* %t852, i8* %t854)
  %t856 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t851, i8* %t855)
  store { i8**, i64 }* %t856, { i8**, i64 }** %l0
  %t857 = load double, double* %l14
  %t858 = sitofp i64 1 to double
  %t859 = fadd double %t857, %t858
  store double %t859, double* %l14
  br label %loop.latch6
merge17:
  %t860 = load i8*, i8** %l16
  %t861 = call i8* @malloc(i64 9)
  %t862 = bitcast i8* %t861 to [9 x i8]*
  store [9 x i8] c".endenum\00", [9 x i8]* %t862
  %t863 = call i1 @strings_equal(i8* %t860, i8* %t861)
  %t864 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t865 = load i8*, i8** %l1
  %t866 = load i8*, i8** %l2
  %t867 = load i8*, i8** %l3
  %t868 = load double, double* %l4
  %t869 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t870 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t871 = load double, double* %l7
  %t872 = load double, double* %l8
  %t873 = load i8*, i8** %l9
  %t874 = load double, double* %l10
  %t875 = load double, double* %l11
  %t876 = load i1, i1* %l12
  %t877 = load i1, i1* %l13
  %t878 = load double, double* %l14
  %t879 = load i8*, i8** %l16
  br i1 %t863, label %then53, label %merge54
then53:
  %t880 = load double, double* %l14
  %t881 = sitofp i64 1 to double
  %t882 = fadd double %t880, %t881
  store double %t882, double* %l14
  br label %afterloop7
merge54:
  %t883 = load i8*, i8** %l16
  %t884 = call i8* @malloc(i64 10)
  %t885 = bitcast i8* %t884 to [10 x i8]*
  store [10 x i8] c".variant \00", [10 x i8]* %t885
  %t886 = call i1 @starts_with(i8* %t883, i8* %t884)
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t888 = load i8*, i8** %l1
  %t889 = load i8*, i8** %l2
  %t890 = load i8*, i8** %l3
  %t891 = load double, double* %l4
  %t892 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t893 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t894 = load double, double* %l7
  %t895 = load double, double* %l8
  %t896 = load i8*, i8** %l9
  %t897 = load double, double* %l10
  %t898 = load double, double* %l11
  %t899 = load i1, i1* %l12
  %t900 = load i1, i1* %l13
  %t901 = load double, double* %l14
  %t902 = load i8*, i8** %l16
  br i1 %t886, label %then55, label %merge56
then55:
  %t903 = load i8*, i8** %l16
  %t904 = call i8* @malloc(i64 10)
  %t905 = bitcast i8* %t904 to [10 x i8]*
  store [10 x i8] c".variant \00", [10 x i8]* %t905
  %t906 = call i8* @strip_prefix(i8* %t903, i8* %t904)
  %t907 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t906)
  store %NativeEnumVariant* %t907, %NativeEnumVariant** %l25
  %t908 = load %NativeEnumVariant*, %NativeEnumVariant** %l25
  %t909 = icmp eq %NativeEnumVariant* %t908, null
  %t910 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t911 = load i8*, i8** %l1
  %t912 = load i8*, i8** %l2
  %t913 = load i8*, i8** %l3
  %t914 = load double, double* %l4
  %t915 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t916 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t917 = load double, double* %l7
  %t918 = load double, double* %l8
  %t919 = load i8*, i8** %l9
  %t920 = load double, double* %l10
  %t921 = load double, double* %l11
  %t922 = load i1, i1* %l12
  %t923 = load i1, i1* %l13
  %t924 = load double, double* %l14
  %t925 = load i8*, i8** %l16
  %t926 = load %NativeEnumVariant*, %NativeEnumVariant** %l25
  br i1 %t909, label %then57, label %else58
then57:
  %t927 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t928 = call i8* @malloc(i64 31)
  %t929 = bitcast i8* %t928 to [31 x i8]*
  store [31 x i8] c"unable to parse enum variant: \00", [31 x i8]* %t929
  %t930 = load i8*, i8** %l16
  %t931 = call i8* @sailfin_runtime_string_concat(i8* %t928, i8* %t930)
  %t932 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t927, i8* %t931)
  store { i8**, i64 }* %t932, { i8**, i64 }** %l0
  %t933 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge59
else58:
  %t934 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t935 = load %NativeEnumVariant*, %NativeEnumVariant** %l25
  %t936 = load %NativeEnumVariant, %NativeEnumVariant* %t935
  %t937 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t934, %NativeEnumVariant %t936)
  store { %NativeEnumVariant*, i64 }* %t937, { %NativeEnumVariant*, i64 }** %l5
  %t938 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %merge59
merge59:
  %t939 = phi { i8**, i64 }* [ %t933, %then57 ], [ %t910, %else58 ]
  %t940 = phi { %NativeEnumVariant*, i64 }* [ %t915, %then57 ], [ %t938, %else58 ]
  store { i8**, i64 }* %t939, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t940, { %NativeEnumVariant*, i64 }** %l5
  %t941 = load double, double* %l14
  %t942 = sitofp i64 1 to double
  %t943 = fadd double %t941, %t942
  store double %t943, double* %l14
  br label %loop.latch6
merge56:
  %t944 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t945 = call i8* @malloc(i64 29)
  %t946 = bitcast i8* %t945 to [29 x i8]*
  store [29 x i8] c"unsupported enum directive: \00", [29 x i8]* %t946
  %t947 = load i8*, i8** %l16
  %t948 = call i8* @sailfin_runtime_string_concat(i8* %t945, i8* %t947)
  %t949 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t944, i8* %t948)
  store { i8**, i64 }* %t949, { i8**, i64 }** %l0
  %t950 = load double, double* %l14
  %t951 = sitofp i64 1 to double
  %t952 = fadd double %t950, %t951
  store double %t952, double* %l14
  br label %loop.latch6
loop.latch6:
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t954 = load double, double* %l14
  %t955 = load double, double* %l7
  %t956 = load double, double* %l8
  %t957 = load i8*, i8** %l9
  %t958 = load double, double* %l10
  %t959 = load double, double* %l11
  %t960 = load i1, i1* %l12
  %t961 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t962 = load i1, i1* %l13
  %t963 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t975 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t976 = load double, double* %l14
  %t977 = load double, double* %l7
  %t978 = load double, double* %l8
  %t979 = load i8*, i8** %l9
  %t980 = load double, double* %l10
  %t981 = load double, double* %l11
  %t982 = load i1, i1* %l12
  %t983 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t984 = load i1, i1* %l13
  %t985 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t986 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t986, %NativeEnumLayout** %l26
  %t987 = load i1, i1* %l12
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t989 = load i8*, i8** %l1
  %t990 = load i8*, i8** %l2
  %t991 = load i8*, i8** %l3
  %t992 = load double, double* %l4
  %t993 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t994 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t995 = load double, double* %l7
  %t996 = load double, double* %l8
  %t997 = load i8*, i8** %l9
  %t998 = load double, double* %l10
  %t999 = load double, double* %l11
  %t1000 = load i1, i1* %l12
  %t1001 = load i1, i1* %l13
  %t1002 = load double, double* %l14
  %t1003 = load %NativeEnumLayout*, %NativeEnumLayout** %l26
  br i1 %t987, label %then60, label %merge61
then60:
  %t1004 = load double, double* %l7
  %t1005 = insertvalue %NativeEnumLayout undef, double %t1004, 0
  %t1006 = load double, double* %l8
  %t1007 = insertvalue %NativeEnumLayout %t1005, double %t1006, 1
  %t1008 = load i8*, i8** %l9
  %t1009 = insertvalue %NativeEnumLayout %t1007, i8* %t1008, 2
  %t1010 = load double, double* %l10
  %t1011 = insertvalue %NativeEnumLayout %t1009, double %t1010, 3
  %t1012 = load double, double* %l11
  %t1013 = insertvalue %NativeEnumLayout %t1011, double %t1012, 4
  %t1014 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t1015 = insertvalue %NativeEnumLayout %t1013, { %NativeEnumVariantLayout*, i64 }* %t1014, 5
  %t1016 = getelementptr %NativeEnumLayout, %NativeEnumLayout* null, i32 1
  %t1017 = ptrtoint %NativeEnumLayout* %t1016 to i64
  %t1018 = call noalias i8* @malloc(i64 %t1017)
  %t1019 = bitcast i8* %t1018 to %NativeEnumLayout*
  store %NativeEnumLayout %t1015, %NativeEnumLayout* %t1019
  call void @sailfin_runtime_mark_persistent(i8* %t1018)
  store %NativeEnumLayout* %t1019, %NativeEnumLayout** %l26
  %t1020 = load %NativeEnumLayout*, %NativeEnumLayout** %l26
  br label %merge61
merge61:
  %t1021 = phi %NativeEnumLayout* [ %t1020, %then60 ], [ %t1003, %afterloop7 ]
  store %NativeEnumLayout* %t1021, %NativeEnumLayout** %l26
  %t1022 = load i8*, i8** %l3
  %t1023 = insertvalue %NativeEnum undef, i8* %t1022, 0
  %t1024 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t1025 = insertvalue %NativeEnum %t1023, { %NativeEnumVariant*, i64 }* %t1024, 1
  %t1026 = load %NativeEnumLayout*, %NativeEnumLayout** %l26
  %t1027 = insertvalue %NativeEnum %t1025, %NativeEnumLayout* %t1026, 2
  %t1028 = getelementptr %NativeEnum, %NativeEnum* null, i32 1
  %t1029 = ptrtoint %NativeEnum* %t1028 to i64
  %t1030 = call noalias i8* @malloc(i64 %t1029)
  %t1031 = bitcast i8* %t1030 to %NativeEnum*
  store %NativeEnum %t1027, %NativeEnum* %t1031
  call void @sailfin_runtime_mark_persistent(i8* %t1030)
  %t1032 = insertvalue %EnumParseResult undef, %NativeEnum* %t1031, 0
  %t1033 = load double, double* %l14
  %t1034 = insertvalue %EnumParseResult %t1032, double %t1033, 1
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1036 = insertvalue %EnumParseResult %t1034, { i8**, i64 }* %t1035, 2
  ret %EnumParseResult %t1036
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t119 = phi double [ %t18, %block.entry ], [ %t115, %loop.latch2 ]
  %t120 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t116, %loop.latch2 ]
  %t121 = phi i8* [ %t17, %block.entry ], [ %t117, %loop.latch2 ]
  %t122 = phi double [ %t19, %block.entry ], [ %t118, %loop.latch2 ]
  store double %t119, double* %l2
  store { i8**, i64 }* %t120, { i8**, i64 }** %l0
  store i8* %t121, i8** %l1
  store double %t122, double* %l3
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l3
  %t21 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t20, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  br i1 %t23, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t28 = load double, double* %l3
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = getelementptr i8, i8* %text, i64 %t30
  %t32 = load i8, i8* %t31
  store i8 %t32, i8* %l4
  %t34 = load i8, i8* %l4
  %t35 = icmp eq i8 %t34, 123
  br label %logical_or_entry_33

logical_or_entry_33:
  br i1 %t35, label %logical_or_merge_33, label %logical_or_right_33

logical_or_right_33:
  %t37 = load i8, i8* %l4
  %t38 = icmp eq i8 %t37, 91
  br label %logical_or_entry_36

logical_or_entry_36:
  br i1 %t38, label %logical_or_merge_36, label %logical_or_right_36

logical_or_right_36:
  %t39 = load i8, i8* %l4
  %t40 = icmp eq i8 %t39, 40
  br label %logical_or_right_end_36

logical_or_right_end_36:
  br label %logical_or_merge_36

logical_or_merge_36:
  %t41 = phi i1 [ true, %logical_or_entry_36 ], [ %t40, %logical_or_right_end_36 ]
  br label %logical_or_right_end_33

logical_or_right_end_33:
  br label %logical_or_merge_33

logical_or_merge_33:
  %t42 = phi i1 [ true, %logical_or_entry_33 ], [ %t41, %logical_or_right_end_33 ]
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load double, double* %l2
  %t46 = load double, double* %l3
  %t47 = load i8, i8* %l4
  br i1 %t42, label %then6, label %else7
then6:
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l2
  %t51 = load double, double* %l2
  br label %merge8
else7:
  %t53 = load i8, i8* %l4
  %t54 = icmp eq i8 %t53, 125
  br label %logical_or_entry_52

logical_or_entry_52:
  br i1 %t54, label %logical_or_merge_52, label %logical_or_right_52

logical_or_right_52:
  %t56 = load i8, i8* %l4
  %t57 = icmp eq i8 %t56, 93
  br label %logical_or_entry_55

logical_or_entry_55:
  br i1 %t57, label %logical_or_merge_55, label %logical_or_right_55

logical_or_right_55:
  %t58 = load i8, i8* %l4
  %t59 = icmp eq i8 %t58, 41
  br label %logical_or_right_end_55

logical_or_right_end_55:
  br label %logical_or_merge_55

logical_or_merge_55:
  %t60 = phi i1 [ true, %logical_or_entry_55 ], [ %t59, %logical_or_right_end_55 ]
  br label %logical_or_right_end_52

logical_or_right_end_52:
  br label %logical_or_merge_52

logical_or_merge_52:
  %t61 = phi i1 [ true, %logical_or_entry_52 ], [ %t60, %logical_or_right_end_52 ]
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load i8, i8* %l4
  br i1 %t61, label %then9, label %merge10
then9:
  %t67 = load double, double* %l2
  %t68 = sitofp i64 0 to double
  %t69 = fcmp ogt double %t67, %t68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = load double, double* %l3
  %t74 = load i8, i8* %l4
  br i1 %t69, label %then11, label %merge12
then11:
  %t75 = load double, double* %l2
  %t76 = sitofp i64 1 to double
  %t77 = fsub double %t75, %t76
  store double %t77, double* %l2
  %t78 = load double, double* %l2
  br label %merge12
merge12:
  %t79 = phi double [ %t78, %then11 ], [ %t72, %then9 ]
  store double %t79, double* %l2
  %t80 = load double, double* %l2
  br label %merge10
merge10:
  %t81 = phi double [ %t80, %merge12 ], [ %t64, %logical_or_merge_52 ]
  store double %t81, double* %l2
  %t82 = load double, double* %l2
  br label %merge8
merge8:
  %t83 = phi double [ %t51, %then6 ], [ %t82, %merge10 ]
  store double %t83, double* %l2
  %t85 = load i8, i8* %l4
  %t86 = icmp eq i8 %t85, 59
  br label %logical_and_entry_84

logical_and_entry_84:
  br i1 %t86, label %logical_and_right_84, label %logical_and_merge_84

logical_and_right_84:
  %t87 = load double, double* %l2
  %t88 = sitofp i64 0 to double
  %t89 = fcmp oeq double %t87, %t88
  br label %logical_and_right_end_84

logical_and_right_end_84:
  br label %logical_and_merge_84

logical_and_merge_84:
  %t90 = phi i1 [ false, %logical_and_entry_84 ], [ %t89, %logical_and_right_end_84 ]
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load double, double* %l2
  %t94 = load double, double* %l3
  %t95 = load i8, i8* %l4
  br i1 %t90, label %then13, label %else14
then13:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = load i8*, i8** %l1
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t96, i8* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l0
  %t99 = call i8* @malloc(i64 1)
  %t100 = bitcast i8* %t99 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t100
  store i8* %t99, i8** %l1
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  br label %merge15
else14:
  %t103 = load i8*, i8** %l1
  %t104 = load i8, i8* %l4
  %t105 = add i64 0, 2
  %t106 = call i8* @malloc(i64 %t105)
  store i8 %t104, i8* %t106
  %t107 = getelementptr i8, i8* %t106, i64 1
  store i8 0, i8* %t107
  call void @sailfin_runtime_mark_persistent(i8* %t106)
  %t108 = call i8* @sailfin_runtime_string_concat(i8* %t103, i8* %t106)
  store i8* %t108, i8** %l1
  %t109 = load i8*, i8** %l1
  br label %merge15
merge15:
  %t110 = phi { i8**, i64 }* [ %t101, %then13 ], [ %t91, %else14 ]
  %t111 = phi i8* [ %t102, %then13 ], [ %t109, %else14 ]
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  store i8* %t111, i8** %l1
  %t112 = load double, double* %l3
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  store double %t114, double* %l3
  br label %loop.latch2
loop.latch2:
  %t115 = load double, double* %l2
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t123 = load double, double* %l2
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load double, double* %l3
  %t127 = load i8*, i8** %l1
  %t128 = call i64 @sailfin_runtime_string_length(i8* %t127)
  %t129 = icmp sgt i64 %t128, 0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load i8*, i8** %l1
  %t132 = load double, double* %l2
  %t133 = load double, double* %l3
  br i1 %t129, label %then16, label %merge17
then16:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load i8*, i8** %l1
  %t136 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t134, i8* %t135)
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t138 = phi { i8**, i64 }* [ %t137, %then16 ], [ %t130, %afterloop3 ]
  store { i8**, i64 }* %t138, { i8**, i64 }** %l0
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t139
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
  %t7 = call i8* @malloc(i64 5)
  %t8 = bitcast i8* %t7 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t8
  %t9 = call i1 @starts_with(i8* %t6, i8* %t7)
  %t10 = load i8*, i8** %l0
  %t11 = load i1, i1* %l1
  br i1 %t9, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call i8* @malloc(i64 5)
  %t14 = bitcast i8* %t13 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t14
  %t15 = call i8* @strip_prefix(i8* %t12, i8* %t13)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = load i1, i1* %l1
  %t18 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t19 = phi i1 [ %t17, %then2 ], [ %t11, %merge1 ]
  %t20 = phi i8* [ %t18, %then2 ], [ %t10, %merge1 ]
  store i1 %t19, i1* %l1
  store i8* %t20, i8** %l0
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @malloc(i64 3)
  %t23 = bitcast i8* %t22 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t23
  %t24 = call double @index_of(i8* %t21, i8* %t22)
  store double %t24, double* %l2
  %t25 = load double, double* %l2
  %t26 = sitofp i64 0 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load i1, i1* %l1
  %t30 = load double, double* %l2
  br i1 %t27, label %then4, label %merge5
then4:
  %t31 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t31
merge5:
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l2
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t35)
  %t37 = call i8* @trim_text(i8* %t36)
  store i8* %t37, i8** %l3
  %t38 = load i8*, i8** %l3
  %t39 = call i64 @sailfin_runtime_string_length(i8* %t38)
  %t40 = icmp eq i64 %t39, 0
  %t41 = load i8*, i8** %l0
  %t42 = load i1, i1* %l1
  %t43 = load double, double* %l2
  %t44 = load i8*, i8** %l3
  br i1 %t40, label %then6, label %merge7
then6:
  %t45 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t45
merge7:
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l2
  %t48 = sitofp i64 2 to double
  %t49 = fadd double %t47, %t48
  %t50 = load i8*, i8** %l0
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = call double @llvm.round.f64(double %t49)
  %t53 = fptosi double %t52 to i64
  %t54 = call i8* @sailfin_runtime_substring(i8* %t46, i64 %t53, i64 %t51)
  %t55 = call i8* @trim_text(i8* %t54)
  store i8* %t55, i8** %l4
  %t56 = load i8*, i8** %l3
  %t57 = insertvalue %NativeEnumVariantField undef, i8* %t56, 0
  %t58 = load i8*, i8** %l4
  %t59 = insertvalue %NativeEnumVariantField %t57, i8* %t58, 1
  %t60 = load i1, i1* %l1
  %t61 = insertvalue %NativeEnumVariantField %t59, i1 %t60, 2
  %t62 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* null, i32 1
  %t63 = ptrtoint %NativeEnumVariantField* %t62 to i64
  %t64 = call noalias i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to %NativeEnumVariantField*
  store %NativeEnumVariantField %t61, %NativeEnumVariantField* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  ret %NativeEnumVariantField* %t65
}

define i8* @text_char_at(i8* %value, double %index) {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
merge1:
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %index, %t5
  br i1 %t6, label %then2, label %merge3
then2:
  %t7 = call i8* @malloc(i64 1)
  %t8 = bitcast i8* %t7 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t8
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  ret i8* %t7
merge3:
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %index, %t9
  %t11 = call double @llvm.round.f64(double %index)
  %t12 = fptosi double %t11 to i64
  %t13 = call double @llvm.round.f64(double %t10)
  %t14 = fptosi double %t13 to i64
  %t15 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t12, i64 %t14)
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
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
  %t7 = call i8* @malloc(i64 5)
  %t8 = bitcast i8* %t7 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t8
  %t9 = call i1 @starts_with(i8* %t6, i8* %t7)
  %t10 = load i8*, i8** %l0
  %t11 = load i1, i1* %l1
  br i1 %t9, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call i8* @malloc(i64 5)
  %t14 = bitcast i8* %t13 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t14
  %t15 = call i8* @strip_prefix(i8* %t12, i8* %t13)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = load i1, i1* %l1
  %t18 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t19 = phi i1 [ %t17, %then2 ], [ %t11, %merge1 ]
  %t20 = phi i8* [ %t18, %then2 ], [ %t10, %merge1 ]
  store i1 %t19, i1* %l1
  store i8* %t20, i8** %l0
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @malloc(i64 3)
  %t23 = bitcast i8* %t22 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t23
  %t24 = call double @index_of(i8* %t21, i8* %t22)
  store double %t24, double* %l2
  %t25 = load double, double* %l2
  %t26 = sitofp i64 0 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load i1, i1* %l1
  %t30 = load double, double* %l2
  br i1 %t27, label %then4, label %merge5
then4:
  %t31 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t31
merge5:
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l2
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t35)
  %t37 = call i8* @trim_text(i8* %t36)
  store i8* %t37, i8** %l3
  %t38 = load i8*, i8** %l3
  %t39 = call i64 @sailfin_runtime_string_length(i8* %t38)
  %t40 = icmp eq i64 %t39, 0
  %t41 = load i8*, i8** %l0
  %t42 = load i1, i1* %l1
  %t43 = load double, double* %l2
  %t44 = load i8*, i8** %l3
  br i1 %t40, label %then6, label %merge7
then6:
  %t45 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t45
merge7:
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l2
  %t48 = sitofp i64 2 to double
  %t49 = fadd double %t47, %t48
  %t50 = load i8*, i8** %l0
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = call double @llvm.round.f64(double %t49)
  %t53 = fptosi double %t52 to i64
  %t54 = call i8* @sailfin_runtime_substring(i8* %t46, i64 %t53, i64 %t51)
  %t55 = call i8* @trim_text(i8* %t54)
  store i8* %t55, i8** %l4
  %t56 = load i8*, i8** %l3
  %t57 = insertvalue %NativeStructField undef, i8* %t56, 0
  %t58 = load i8*, i8** %l4
  %t59 = insertvalue %NativeStructField %t57, i8* %t58, 1
  %t60 = load i1, i1* %l1
  %t61 = insertvalue %NativeStructField %t59, i1 %t60, 2
  %t62 = getelementptr %NativeStructField, %NativeStructField* null, i32 1
  %t63 = ptrtoint %NativeStructField* %t62 to i64
  %t64 = call noalias i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to %NativeStructField*
  store %NativeStructField %t61, %NativeStructField* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  ret %NativeStructField* %t65
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
  %t21 = call i8* @malloc(i64 37)
  %t22 = bitcast i8* %t21 to [37 x i8]*
  store [37 x i8] c"struct layout header missing entries\00", [37 x i8]* %t22
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %t21)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l1
  %t24 = insertvalue %StructLayoutHeaderParse undef, i1 0, 0
  %t25 = call i8* @malloc(i64 1)
  %t26 = bitcast i8* %t25 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t26
  %t27 = insertvalue %StructLayoutHeaderParse %t24, i8* %t25, 1
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %StructLayoutHeaderParse %t27, double %t28, 2
  %t30 = sitofp i64 0 to double
  %t31 = insertvalue %StructLayoutHeaderParse %t29, double %t30, 3
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = insertvalue %StructLayoutHeaderParse %t31, { i8**, i64 }* %t32, 4
  ret %StructLayoutHeaderParse %t33
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %t34 = call i8* @malloc(i64 1)
  %t35 = bitcast i8* %t34 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t35
  store i8* %t34, i8** %l5
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l6
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l7
  %t38 = sitofp i64 0 to double
  store double %t38, double* %l8
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load i1, i1* %l2
  %t42 = load i1, i1* %l3
  %t43 = load i1, i1* %l4
  %t44 = load i8*, i8** %l5
  %t45 = load double, double* %l6
  %t46 = load double, double* %l7
  %t47 = load double, double* %l8
  br label %loop.header2
loop.header2:
  %t251 = phi i8* [ %t44, %merge1 ], [ %t243, %loop.latch4 ]
  %t252 = phi i1 [ %t41, %merge1 ], [ %t244, %loop.latch4 ]
  %t253 = phi i1 [ %t42, %merge1 ], [ %t245, %loop.latch4 ]
  %t254 = phi double [ %t45, %merge1 ], [ %t246, %loop.latch4 ]
  %t255 = phi { i8**, i64 }* [ %t40, %merge1 ], [ %t247, %loop.latch4 ]
  %t256 = phi i1 [ %t43, %merge1 ], [ %t248, %loop.latch4 ]
  %t257 = phi double [ %t46, %merge1 ], [ %t249, %loop.latch4 ]
  %t258 = phi double [ %t47, %merge1 ], [ %t250, %loop.latch4 ]
  store i8* %t251, i8** %l5
  store i1 %t252, i1* %l2
  store i1 %t253, i1* %l3
  store double %t254, double* %l6
  store { i8**, i64 }* %t255, { i8**, i64 }** %l1
  store i1 %t256, i1* %l4
  store double %t257, double* %l7
  store double %t258, double* %l8
  br label %loop.body3
loop.body3:
  %t48 = load double, double* %l8
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t51 = extractvalue { i8**, i64 } %t50, 1
  %t52 = sitofp i64 %t51 to double
  %t53 = fcmp oge double %t48, %t52
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load i1, i1* %l2
  %t57 = load i1, i1* %l3
  %t58 = load i1, i1* %l4
  %t59 = load i8*, i8** %l5
  %t60 = load double, double* %l6
  %t61 = load double, double* %l7
  %t62 = load double, double* %l8
  br i1 %t53, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load double, double* %l8
  %t65 = call double @llvm.round.f64(double %t64)
  %t66 = fptosi double %t65 to i64
  %t67 = load { i8**, i64 }, { i8**, i64 }* %t63
  %t68 = extractvalue { i8**, i64 } %t67, 0
  %t69 = extractvalue { i8**, i64 } %t67, 1
  %t70 = icmp uge i64 %t66, %t69
  ; bounds check: %t70 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t66, i64 %t69)
  %t71 = getelementptr i8*, i8** %t68, i64 %t66
  %t72 = load i8*, i8** %t71
  store i8* %t72, i8** %l9
  %t73 = load i8*, i8** %l9
  %t74 = call i8* @malloc(i64 6)
  %t75 = bitcast i8* %t74 to [6 x i8]*
  store [6 x i8] c"name=\00", [6 x i8]* %t75
  %t76 = call i1 @starts_with(i8* %t73, i8* %t74)
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = load i1, i1* %l2
  %t80 = load i1, i1* %l3
  %t81 = load i1, i1* %l4
  %t82 = load i8*, i8** %l5
  %t83 = load double, double* %l6
  %t84 = load double, double* %l7
  %t85 = load double, double* %l8
  %t86 = load i8*, i8** %l9
  br i1 %t76, label %then8, label %else9
then8:
  %t87 = load i8*, i8** %l9
  %t88 = load i8*, i8** %l9
  %t89 = call i64 @sailfin_runtime_string_length(i8* %t88)
  %t90 = call i8* @sailfin_runtime_substring(i8* %t87, i64 5, i64 %t89)
  store i8* %t90, i8** %l5
  store i1 1, i1* %l2
  %t91 = load i8*, i8** %l5
  %t92 = load i1, i1* %l2
  br label %merge10
else9:
  %t93 = load i8*, i8** %l9
  %t94 = call i8* @malloc(i64 6)
  %t95 = bitcast i8* %t94 to [6 x i8]*
  store [6 x i8] c"size=\00", [6 x i8]* %t95
  %t96 = call i1 @starts_with(i8* %t93, i8* %t94)
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load i1, i1* %l2
  %t100 = load i1, i1* %l3
  %t101 = load i1, i1* %l4
  %t102 = load i8*, i8** %l5
  %t103 = load double, double* %l6
  %t104 = load double, double* %l7
  %t105 = load double, double* %l8
  %t106 = load i8*, i8** %l9
  br i1 %t96, label %then11, label %else12
then11:
  %t107 = load i8*, i8** %l9
  %t108 = load i8*, i8** %l9
  %t109 = call i64 @sailfin_runtime_string_length(i8* %t108)
  %t110 = call i8* @sailfin_runtime_substring(i8* %t107, i64 5, i64 %t109)
  store i8* %t110, i8** %l10
  %t111 = load i8*, i8** %l10
  %t112 = call %NumberParseResult @parse_decimal_number(i8* %t111)
  store %NumberParseResult %t112, %NumberParseResult* %l11
  %t113 = load %NumberParseResult, %NumberParseResult* %l11
  %t114 = extractvalue %NumberParseResult %t113, 0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = load i1, i1* %l2
  %t118 = load i1, i1* %l3
  %t119 = load i1, i1* %l4
  %t120 = load i8*, i8** %l5
  %t121 = load double, double* %l6
  %t122 = load double, double* %l7
  %t123 = load double, double* %l8
  %t124 = load i8*, i8** %l9
  %t125 = load i8*, i8** %l10
  %t126 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t114, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t127 = load %NumberParseResult, %NumberParseResult* %l11
  %t128 = extractvalue %NumberParseResult %t127, 1
  store double %t128, double* %l6
  %t129 = load i1, i1* %l3
  %t130 = load double, double* %l6
  br label %merge16
else15:
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = call i8* @malloc(i64 40)
  %t133 = bitcast i8* %t132 to [40 x i8]*
  store [40 x i8] c"struct layout header has invalid size `\00", [40 x i8]* %t133
  %t134 = load i8*, i8** %l10
  %t135 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %t134)
  %t136 = add i64 0, 2
  %t137 = call i8* @malloc(i64 %t136)
  store i8 96, i8* %t137
  %t138 = getelementptr i8, i8* %t137, i64 1
  store i8 0, i8* %t138
  call void @sailfin_runtime_mark_persistent(i8* %t137)
  %t139 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %t137)
  %t140 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t131, i8* %t139)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l1
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t142 = phi i1 [ %t129, %then14 ], [ %t118, %else15 ]
  %t143 = phi double [ %t130, %then14 ], [ %t121, %else15 ]
  %t144 = phi { i8**, i64 }* [ %t116, %then14 ], [ %t141, %else15 ]
  store i1 %t142, i1* %l3
  store double %t143, double* %l6
  store { i8**, i64 }* %t144, { i8**, i64 }** %l1
  %t145 = load i1, i1* %l3
  %t146 = load double, double* %l6
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t148 = load i8*, i8** %l9
  %t149 = call i8* @malloc(i64 7)
  %t150 = bitcast i8* %t149 to [7 x i8]*
  store [7 x i8] c"align=\00", [7 x i8]* %t150
  %t151 = call i1 @starts_with(i8* %t148, i8* %t149)
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load i1, i1* %l2
  %t155 = load i1, i1* %l3
  %t156 = load i1, i1* %l4
  %t157 = load i8*, i8** %l5
  %t158 = load double, double* %l6
  %t159 = load double, double* %l7
  %t160 = load double, double* %l8
  %t161 = load i8*, i8** %l9
  br i1 %t151, label %then17, label %else18
then17:
  %t162 = load i8*, i8** %l9
  %t163 = load i8*, i8** %l9
  %t164 = call i64 @sailfin_runtime_string_length(i8* %t163)
  %t165 = call i8* @sailfin_runtime_substring(i8* %t162, i64 6, i64 %t164)
  store i8* %t165, i8** %l12
  %t166 = load i8*, i8** %l12
  %t167 = call %NumberParseResult @parse_decimal_number(i8* %t166)
  store %NumberParseResult %t167, %NumberParseResult* %l13
  %t168 = load %NumberParseResult, %NumberParseResult* %l13
  %t169 = extractvalue %NumberParseResult %t168, 0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load i1, i1* %l2
  %t173 = load i1, i1* %l3
  %t174 = load i1, i1* %l4
  %t175 = load i8*, i8** %l5
  %t176 = load double, double* %l6
  %t177 = load double, double* %l7
  %t178 = load double, double* %l8
  %t179 = load i8*, i8** %l9
  %t180 = load i8*, i8** %l12
  %t181 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t169, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t182 = load %NumberParseResult, %NumberParseResult* %l13
  %t183 = extractvalue %NumberParseResult %t182, 1
  store double %t183, double* %l7
  %t184 = load i1, i1* %l4
  %t185 = load double, double* %l7
  br label %merge22
else21:
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = call i8* @malloc(i64 41)
  %t188 = bitcast i8* %t187 to [41 x i8]*
  store [41 x i8] c"struct layout header has invalid align `\00", [41 x i8]* %t188
  %t189 = load i8*, i8** %l12
  %t190 = call i8* @sailfin_runtime_string_concat(i8* %t187, i8* %t189)
  %t191 = add i64 0, 2
  %t192 = call i8* @malloc(i64 %t191)
  store i8 96, i8* %t192
  %t193 = getelementptr i8, i8* %t192, i64 1
  store i8 0, i8* %t193
  call void @sailfin_runtime_mark_persistent(i8* %t192)
  %t194 = call i8* @sailfin_runtime_string_concat(i8* %t190, i8* %t192)
  %t195 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t186, i8* %t194)
  store { i8**, i64 }* %t195, { i8**, i64 }** %l1
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t197 = phi i1 [ %t184, %then20 ], [ %t174, %else21 ]
  %t198 = phi double [ %t185, %then20 ], [ %t177, %else21 ]
  %t199 = phi { i8**, i64 }* [ %t171, %then20 ], [ %t196, %else21 ]
  store i1 %t197, i1* %l4
  store double %t198, double* %l7
  store { i8**, i64 }* %t199, { i8**, i64 }** %l1
  %t200 = load i1, i1* %l4
  %t201 = load double, double* %l7
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = call i8* @malloc(i64 42)
  %t205 = bitcast i8* %t204 to [42 x i8]*
  store [42 x i8] c"struct layout header unrecognized token `\00", [42 x i8]* %t205
  %t206 = load i8*, i8** %l9
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %t204, i8* %t206)
  %t208 = add i64 0, 2
  %t209 = call i8* @malloc(i64 %t208)
  store i8 96, i8* %t209
  %t210 = getelementptr i8, i8* %t209, i64 1
  store i8 0, i8* %t210
  call void @sailfin_runtime_mark_persistent(i8* %t209)
  %t211 = call i8* @sailfin_runtime_string_concat(i8* %t207, i8* %t209)
  %t212 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t203, i8* %t211)
  store { i8**, i64 }* %t212, { i8**, i64 }** %l1
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t214 = phi i1 [ %t200, %merge22 ], [ %t156, %else18 ]
  %t215 = phi double [ %t201, %merge22 ], [ %t159, %else18 ]
  %t216 = phi { i8**, i64 }* [ %t202, %merge22 ], [ %t213, %else18 ]
  store i1 %t214, i1* %l4
  store double %t215, double* %l7
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  %t217 = load i1, i1* %l4
  %t218 = load double, double* %l7
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t221 = phi i1 [ %t145, %merge16 ], [ %t100, %merge19 ]
  %t222 = phi double [ %t146, %merge16 ], [ %t103, %merge19 ]
  %t223 = phi { i8**, i64 }* [ %t147, %merge16 ], [ %t219, %merge19 ]
  %t224 = phi i1 [ %t101, %merge16 ], [ %t217, %merge19 ]
  %t225 = phi double [ %t104, %merge16 ], [ %t218, %merge19 ]
  store i1 %t221, i1* %l3
  store double %t222, double* %l6
  store { i8**, i64 }* %t223, { i8**, i64 }** %l1
  store i1 %t224, i1* %l4
  store double %t225, double* %l7
  %t226 = load i1, i1* %l3
  %t227 = load double, double* %l6
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load i1, i1* %l4
  %t230 = load double, double* %l7
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t233 = phi i8* [ %t91, %then8 ], [ %t82, %merge13 ]
  %t234 = phi i1 [ %t92, %then8 ], [ %t79, %merge13 ]
  %t235 = phi i1 [ %t80, %then8 ], [ %t226, %merge13 ]
  %t236 = phi double [ %t83, %then8 ], [ %t227, %merge13 ]
  %t237 = phi { i8**, i64 }* [ %t78, %then8 ], [ %t228, %merge13 ]
  %t238 = phi i1 [ %t81, %then8 ], [ %t229, %merge13 ]
  %t239 = phi double [ %t84, %then8 ], [ %t230, %merge13 ]
  store i8* %t233, i8** %l5
  store i1 %t234, i1* %l2
  store i1 %t235, i1* %l3
  store double %t236, double* %l6
  store { i8**, i64 }* %t237, { i8**, i64 }** %l1
  store i1 %t238, i1* %l4
  store double %t239, double* %l7
  %t240 = load double, double* %l8
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  store double %t242, double* %l8
  br label %loop.latch4
loop.latch4:
  %t243 = load i8*, i8** %l5
  %t244 = load i1, i1* %l2
  %t245 = load i1, i1* %l3
  %t246 = load double, double* %l6
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load i1, i1* %l4
  %t249 = load double, double* %l7
  %t250 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t259 = load i8*, i8** %l5
  %t260 = load i1, i1* %l2
  %t261 = load i1, i1* %l3
  %t262 = load double, double* %l6
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = load i1, i1* %l4
  %t265 = load double, double* %l7
  %t266 = load double, double* %l8
  %t267 = load i1, i1* %l3
  %t268 = xor i1 %t267, 1
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = load i1, i1* %l2
  %t272 = load i1, i1* %l3
  %t273 = load i1, i1* %l4
  %t274 = load i8*, i8** %l5
  %t275 = load double, double* %l6
  %t276 = load double, double* %l7
  %t277 = load double, double* %l8
  br i1 %t268, label %then23, label %merge24
then23:
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t279 = call i8* @malloc(i64 40)
  %t280 = bitcast i8* %t279 to [40 x i8]*
  store [40 x i8] c"struct layout header missing size entry\00", [40 x i8]* %t280
  %t281 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t278, i8* %t279)
  store { i8**, i64 }* %t281, { i8**, i64 }** %l1
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t283 = phi { i8**, i64 }* [ %t282, %then23 ], [ %t270, %afterloop5 ]
  store { i8**, i64 }* %t283, { i8**, i64 }** %l1
  %t284 = load i1, i1* %l4
  %t285 = xor i1 %t284, 1
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t288 = load i1, i1* %l2
  %t289 = load i1, i1* %l3
  %t290 = load i1, i1* %l4
  %t291 = load i8*, i8** %l5
  %t292 = load double, double* %l6
  %t293 = load double, double* %l7
  %t294 = load double, double* %l8
  br i1 %t285, label %then25, label %merge26
then25:
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = call i8* @malloc(i64 41)
  %t297 = bitcast i8* %t296 to [41 x i8]*
  store [41 x i8] c"struct layout header missing align entry\00", [41 x i8]* %t297
  %t298 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t295, i8* %t296)
  store { i8**, i64 }* %t298, { i8**, i64 }** %l1
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t300 = phi { i8**, i64 }* [ %t299, %then25 ], [ %t287, %merge24 ]
  store { i8**, i64 }* %t300, { i8**, i64 }** %l1
  %t302 = load i1, i1* %l3
  br label %logical_and_entry_301

logical_and_entry_301:
  br i1 %t302, label %logical_and_right_301, label %logical_and_merge_301

logical_and_right_301:
  %t304 = load i1, i1* %l4
  br label %logical_and_entry_303

logical_and_entry_303:
  br i1 %t304, label %logical_and_right_303, label %logical_and_merge_303

logical_and_right_303:
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t306 = load { i8**, i64 }, { i8**, i64 }* %t305
  %t307 = extractvalue { i8**, i64 } %t306, 1
  %t308 = icmp eq i64 %t307, 0
  br label %logical_and_right_end_303

logical_and_right_end_303:
  br label %logical_and_merge_303

logical_and_merge_303:
  %t309 = phi i1 [ false, %logical_and_entry_303 ], [ %t308, %logical_and_right_end_303 ]
  br label %logical_and_right_end_301

logical_and_right_end_301:
  br label %logical_and_merge_301

logical_and_merge_301:
  %t310 = phi i1 [ false, %logical_and_entry_301 ], [ %t309, %logical_and_right_end_301 ]
  store i1 %t310, i1* %l14
  %t311 = load i1, i1* %l14
  %t312 = insertvalue %StructLayoutHeaderParse undef, i1 %t311, 0
  %t313 = load i8*, i8** %l5
  %t314 = insertvalue %StructLayoutHeaderParse %t312, i8* %t313, 1
  %t315 = load double, double* %l6
  %t316 = insertvalue %StructLayoutHeaderParse %t314, double %t315, 2
  %t317 = load double, double* %l7
  %t318 = insertvalue %StructLayoutHeaderParse %t316, double %t317, 3
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t320 = insertvalue %StructLayoutHeaderParse %t318, { i8**, i64 }* %t319, 4
  ret %StructLayoutHeaderParse %t320
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
  %t13 = call i8* @malloc(i64 1)
  %t14 = bitcast i8* %t13 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t14
  %t15 = insertvalue %NativeStructLayoutField undef, i8* %t13, 0
  %t16 = call i8* @malloc(i64 1)
  %t17 = bitcast i8* %t16 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t17
  %t18 = insertvalue %NativeStructLayoutField %t15, i8* %t16, 1
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeStructLayoutField %t18, double %t19, 2
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeStructLayoutField %t20, double %t21, 3
  %t23 = sitofp i64 0 to double
  %t24 = insertvalue %NativeStructLayoutField %t22, double %t23, 4
  store %NativeStructLayoutField %t24, %NativeStructLayoutField* %l2
  %t25 = load i8*, i8** %l0
  %t26 = call i64 @sailfin_runtime_string_length(i8* %t25)
  %t27 = icmp eq i64 %t26, 0
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t27, label %then0, label %merge1
then0:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = call i8* @malloc(i64 8)
  %t33 = bitcast i8* %t32 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t33
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %struct_name)
  %t35 = call i8* @malloc(i64 30)
  %t36 = bitcast i8* %t35 to [30 x i8]*
  store [30 x i8] c" layout field missing content\00", [30 x i8]* %t36
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t35)
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t31, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l1
  %t39 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t40 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t41 = insertvalue %StructLayoutFieldParse %t39, %NativeStructLayoutField %t40, 1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = insertvalue %StructLayoutFieldParse %t41, { i8**, i64 }* %t42, 2
  ret %StructLayoutFieldParse %t43
merge1:
  %t44 = load i8*, i8** %l0
  %t45 = call { i8**, i64 }* @split_whitespace(i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l3
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = icmp eq i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t49, label %then2, label %merge3
then2:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t55 = call i8* @malloc(i64 8)
  %t56 = bitcast i8* %t55 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t56
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %struct_name)
  %t58 = call i8* @malloc(i64 30)
  %t59 = bitcast i8* %t58 to [30 x i8]*
  store [30 x i8] c" layout field missing entries\00", [30 x i8]* %t59
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t58)
  %t61 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l1
  %t62 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t63 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t64 = insertvalue %StructLayoutFieldParse %t62, %NativeStructLayoutField %t63, 1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = insertvalue %StructLayoutFieldParse %t64, { i8**, i64 }* %t65, 2
  ret %StructLayoutFieldParse %t66
merge3:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 0
  %t70 = extractvalue { i8**, i64 } %t68, 1
  %t71 = icmp uge i64 0, %t70
  ; bounds check: %t71 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t70)
  %t72 = getelementptr i8*, i8** %t69, i64 0
  %t73 = load i8*, i8** %t72
  store i8* %t73, i8** %l4
  %t74 = load i8*, i8** %l4
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = icmp eq i64 %t75, 0
  %t77 = load i8*, i8** %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t81 = load i8*, i8** %l4
  br i1 %t76, label %then4, label %merge5
then4:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = call i8* @malloc(i64 8)
  %t84 = bitcast i8* %t83 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t84
  %t85 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %struct_name)
  %t86 = call i8* @malloc(i64 27)
  %t87 = bitcast i8* %t86 to [27 x i8]*
  store [27 x i8] c" layout field missing name\00", [27 x i8]* %t87
  %t88 = call i8* @sailfin_runtime_string_concat(i8* %t85, i8* %t86)
  %t89 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t82, i8* %t88)
  store { i8**, i64 }* %t89, { i8**, i64 }** %l1
  %t90 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t91 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t92 = insertvalue %StructLayoutFieldParse %t90, %NativeStructLayoutField %t91, 1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = insertvalue %StructLayoutFieldParse %t92, { i8**, i64 }* %t93, 2
  ret %StructLayoutFieldParse %t94
merge5:
  %t95 = call i8* @malloc(i64 1)
  %t96 = bitcast i8* %t95 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t96
  store i8* %t95, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t97 = sitofp i64 0 to double
  store double %t97, double* %l9
  %t98 = sitofp i64 0 to double
  store double %t98, double* %l10
  %t99 = sitofp i64 0 to double
  store double %t99, double* %l11
  %t100 = sitofp i64 1 to double
  store double %t100, double* %l12
  %t101 = load i8*, i8** %l0
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t103 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t105 = load i8*, i8** %l4
  %t106 = load i8*, i8** %l5
  %t107 = load i1, i1* %l6
  %t108 = load i1, i1* %l7
  %t109 = load i1, i1* %l8
  %t110 = load double, double* %l9
  %t111 = load double, double* %l10
  %t112 = load double, double* %l11
  %t113 = load double, double* %l12
  br label %loop.header6
loop.header6:
  %t458 = phi i8* [ %t106, %merge5 ], [ %t449, %loop.latch8 ]
  %t459 = phi i1 [ %t107, %merge5 ], [ %t450, %loop.latch8 ]
  %t460 = phi double [ %t110, %merge5 ], [ %t451, %loop.latch8 ]
  %t461 = phi { i8**, i64 }* [ %t102, %merge5 ], [ %t452, %loop.latch8 ]
  %t462 = phi i1 [ %t108, %merge5 ], [ %t453, %loop.latch8 ]
  %t463 = phi double [ %t111, %merge5 ], [ %t454, %loop.latch8 ]
  %t464 = phi i1 [ %t109, %merge5 ], [ %t455, %loop.latch8 ]
  %t465 = phi double [ %t112, %merge5 ], [ %t456, %loop.latch8 ]
  %t466 = phi double [ %t113, %merge5 ], [ %t457, %loop.latch8 ]
  store i8* %t458, i8** %l5
  store i1 %t459, i1* %l6
  store double %t460, double* %l9
  store { i8**, i64 }* %t461, { i8**, i64 }** %l1
  store i1 %t462, i1* %l7
  store double %t463, double* %l10
  store i1 %t464, i1* %l8
  store double %t465, double* %l11
  store double %t466, double* %l12
  br label %loop.body7
loop.body7:
  %t114 = load double, double* %l12
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t116 = load { i8**, i64 }, { i8**, i64 }* %t115
  %t117 = extractvalue { i8**, i64 } %t116, 1
  %t118 = sitofp i64 %t117 to double
  %t119 = fcmp oge double %t114, %t118
  %t120 = load i8*, i8** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t124 = load i8*, i8** %l4
  %t125 = load i8*, i8** %l5
  %t126 = load i1, i1* %l6
  %t127 = load i1, i1* %l7
  %t128 = load i1, i1* %l8
  %t129 = load double, double* %l9
  %t130 = load double, double* %l10
  %t131 = load double, double* %l11
  %t132 = load double, double* %l12
  br i1 %t119, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t134 = load double, double* %l12
  %t135 = call double @llvm.round.f64(double %t134)
  %t136 = fptosi double %t135 to i64
  %t137 = load { i8**, i64 }, { i8**, i64 }* %t133
  %t138 = extractvalue { i8**, i64 } %t137, 0
  %t139 = extractvalue { i8**, i64 } %t137, 1
  %t140 = icmp uge i64 %t136, %t139
  ; bounds check: %t140 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t136, i64 %t139)
  %t141 = getelementptr i8*, i8** %t138, i64 %t136
  %t142 = load i8*, i8** %t141
  store i8* %t142, i8** %l13
  %t143 = load i8*, i8** %l13
  %t144 = call i8* @malloc(i64 6)
  %t145 = bitcast i8* %t144 to [6 x i8]*
  store [6 x i8] c"type=\00", [6 x i8]* %t145
  %t146 = call i1 @starts_with(i8* %t143, i8* %t144)
  %t147 = load i8*, i8** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t151 = load i8*, i8** %l4
  %t152 = load i8*, i8** %l5
  %t153 = load i1, i1* %l6
  %t154 = load i1, i1* %l7
  %t155 = load i1, i1* %l8
  %t156 = load double, double* %l9
  %t157 = load double, double* %l10
  %t158 = load double, double* %l11
  %t159 = load double, double* %l12
  %t160 = load i8*, i8** %l13
  br i1 %t146, label %then12, label %else13
then12:
  %t161 = load i8*, i8** %l13
  %t162 = load i8*, i8** %l13
  %t163 = call i64 @sailfin_runtime_string_length(i8* %t162)
  %t164 = call i8* @sailfin_runtime_substring(i8* %t161, i64 5, i64 %t163)
  store i8* %t164, i8** %l5
  %t165 = load i8*, i8** %l5
  br label %merge14
else13:
  %t166 = load i8*, i8** %l13
  %t167 = call i8* @malloc(i64 8)
  %t168 = bitcast i8* %t167 to [8 x i8]*
  store [8 x i8] c"offset=\00", [8 x i8]* %t168
  %t169 = call i1 @starts_with(i8* %t166, i8* %t167)
  %t170 = load i8*, i8** %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t174 = load i8*, i8** %l4
  %t175 = load i8*, i8** %l5
  %t176 = load i1, i1* %l6
  %t177 = load i1, i1* %l7
  %t178 = load i1, i1* %l8
  %t179 = load double, double* %l9
  %t180 = load double, double* %l10
  %t181 = load double, double* %l11
  %t182 = load double, double* %l12
  %t183 = load i8*, i8** %l13
  br i1 %t169, label %then15, label %else16
then15:
  %t184 = load i8*, i8** %l13
  %t185 = load i8*, i8** %l13
  %t186 = call i64 @sailfin_runtime_string_length(i8* %t185)
  %t187 = call i8* @sailfin_runtime_substring(i8* %t184, i64 7, i64 %t186)
  store i8* %t187, i8** %l14
  %t188 = load i8*, i8** %l14
  %t189 = call %NumberParseResult @parse_decimal_number(i8* %t188)
  store %NumberParseResult %t189, %NumberParseResult* %l15
  %t190 = load %NumberParseResult, %NumberParseResult* %l15
  %t191 = extractvalue %NumberParseResult %t190, 0
  %t192 = load i8*, i8** %l0
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t194 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t196 = load i8*, i8** %l4
  %t197 = load i8*, i8** %l5
  %t198 = load i1, i1* %l6
  %t199 = load i1, i1* %l7
  %t200 = load i1, i1* %l8
  %t201 = load double, double* %l9
  %t202 = load double, double* %l10
  %t203 = load double, double* %l11
  %t204 = load double, double* %l12
  %t205 = load i8*, i8** %l13
  %t206 = load i8*, i8** %l14
  %t207 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t191, label %then18, label %else19
then18:
  store i1 1, i1* %l6
  %t208 = load %NumberParseResult, %NumberParseResult* %l15
  %t209 = extractvalue %NumberParseResult %t208, 1
  store double %t209, double* %l9
  %t210 = load i1, i1* %l6
  %t211 = load double, double* %l9
  br label %merge20
else19:
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = call i8* @malloc(i64 8)
  %t214 = bitcast i8* %t213 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t214
  %t215 = call i8* @sailfin_runtime_string_concat(i8* %t213, i8* %struct_name)
  %t216 = call i8* @malloc(i64 16)
  %t217 = bitcast i8* %t216 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t217
  %t218 = call i8* @sailfin_runtime_string_concat(i8* %t215, i8* %t216)
  %t219 = load i8*, i8** %l4
  %t220 = call i8* @sailfin_runtime_string_concat(i8* %t218, i8* %t219)
  %t221 = call i8* @malloc(i64 23)
  %t222 = bitcast i8* %t221 to [23 x i8]*
  store [23 x i8] c"` has invalid offset `\00", [23 x i8]* %t222
  %t223 = call i8* @sailfin_runtime_string_concat(i8* %t220, i8* %t221)
  %t224 = load i8*, i8** %l14
  %t225 = call i8* @sailfin_runtime_string_concat(i8* %t223, i8* %t224)
  %t226 = add i64 0, 2
  %t227 = call i8* @malloc(i64 %t226)
  store i8 96, i8* %t227
  %t228 = getelementptr i8, i8* %t227, i64 1
  store i8 0, i8* %t228
  call void @sailfin_runtime_mark_persistent(i8* %t227)
  %t229 = call i8* @sailfin_runtime_string_concat(i8* %t225, i8* %t227)
  %t230 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t212, i8* %t229)
  store { i8**, i64 }* %t230, { i8**, i64 }** %l1
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t232 = phi i1 [ %t210, %then18 ], [ %t198, %else19 ]
  %t233 = phi double [ %t211, %then18 ], [ %t201, %else19 ]
  %t234 = phi { i8**, i64 }* [ %t193, %then18 ], [ %t231, %else19 ]
  store i1 %t232, i1* %l6
  store double %t233, double* %l9
  store { i8**, i64 }* %t234, { i8**, i64 }** %l1
  %t235 = load i1, i1* %l6
  %t236 = load double, double* %l9
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t238 = load i8*, i8** %l13
  %t239 = call i8* @malloc(i64 6)
  %t240 = bitcast i8* %t239 to [6 x i8]*
  store [6 x i8] c"size=\00", [6 x i8]* %t240
  %t241 = call i1 @starts_with(i8* %t238, i8* %t239)
  %t242 = load i8*, i8** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t246 = load i8*, i8** %l4
  %t247 = load i8*, i8** %l5
  %t248 = load i1, i1* %l6
  %t249 = load i1, i1* %l7
  %t250 = load i1, i1* %l8
  %t251 = load double, double* %l9
  %t252 = load double, double* %l10
  %t253 = load double, double* %l11
  %t254 = load double, double* %l12
  %t255 = load i8*, i8** %l13
  br i1 %t241, label %then21, label %else22
then21:
  %t256 = load i8*, i8** %l13
  %t257 = load i8*, i8** %l13
  %t258 = call i64 @sailfin_runtime_string_length(i8* %t257)
  %t259 = call i8* @sailfin_runtime_substring(i8* %t256, i64 5, i64 %t258)
  store i8* %t259, i8** %l16
  %t260 = load i8*, i8** %l16
  %t261 = call %NumberParseResult @parse_decimal_number(i8* %t260)
  store %NumberParseResult %t261, %NumberParseResult* %l17
  %t262 = load %NumberParseResult, %NumberParseResult* %l17
  %t263 = extractvalue %NumberParseResult %t262, 0
  %t264 = load i8*, i8** %l0
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t266 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t268 = load i8*, i8** %l4
  %t269 = load i8*, i8** %l5
  %t270 = load i1, i1* %l6
  %t271 = load i1, i1* %l7
  %t272 = load i1, i1* %l8
  %t273 = load double, double* %l9
  %t274 = load double, double* %l10
  %t275 = load double, double* %l11
  %t276 = load double, double* %l12
  %t277 = load i8*, i8** %l13
  %t278 = load i8*, i8** %l16
  %t279 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t263, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t280 = load %NumberParseResult, %NumberParseResult* %l17
  %t281 = extractvalue %NumberParseResult %t280, 1
  store double %t281, double* %l10
  %t282 = load i1, i1* %l7
  %t283 = load double, double* %l10
  br label %merge26
else25:
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t285 = call i8* @malloc(i64 8)
  %t286 = bitcast i8* %t285 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t286
  %t287 = call i8* @sailfin_runtime_string_concat(i8* %t285, i8* %struct_name)
  %t288 = call i8* @malloc(i64 16)
  %t289 = bitcast i8* %t288 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t289
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %t287, i8* %t288)
  %t291 = load i8*, i8** %l4
  %t292 = call i8* @sailfin_runtime_string_concat(i8* %t290, i8* %t291)
  %t293 = call i8* @malloc(i64 21)
  %t294 = bitcast i8* %t293 to [21 x i8]*
  store [21 x i8] c"` has invalid size `\00", [21 x i8]* %t294
  %t295 = call i8* @sailfin_runtime_string_concat(i8* %t292, i8* %t293)
  %t296 = load i8*, i8** %l16
  %t297 = call i8* @sailfin_runtime_string_concat(i8* %t295, i8* %t296)
  %t298 = add i64 0, 2
  %t299 = call i8* @malloc(i64 %t298)
  store i8 96, i8* %t299
  %t300 = getelementptr i8, i8* %t299, i64 1
  store i8 0, i8* %t300
  call void @sailfin_runtime_mark_persistent(i8* %t299)
  %t301 = call i8* @sailfin_runtime_string_concat(i8* %t297, i8* %t299)
  %t302 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t284, i8* %t301)
  store { i8**, i64 }* %t302, { i8**, i64 }** %l1
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t304 = phi i1 [ %t282, %then24 ], [ %t271, %else25 ]
  %t305 = phi double [ %t283, %then24 ], [ %t274, %else25 ]
  %t306 = phi { i8**, i64 }* [ %t265, %then24 ], [ %t303, %else25 ]
  store i1 %t304, i1* %l7
  store double %t305, double* %l10
  store { i8**, i64 }* %t306, { i8**, i64 }** %l1
  %t307 = load i1, i1* %l7
  %t308 = load double, double* %l10
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t310 = load i8*, i8** %l13
  %t311 = call i8* @malloc(i64 7)
  %t312 = bitcast i8* %t311 to [7 x i8]*
  store [7 x i8] c"align=\00", [7 x i8]* %t312
  %t313 = call i1 @starts_with(i8* %t310, i8* %t311)
  %t314 = load i8*, i8** %l0
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t316 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t318 = load i8*, i8** %l4
  %t319 = load i8*, i8** %l5
  %t320 = load i1, i1* %l6
  %t321 = load i1, i1* %l7
  %t322 = load i1, i1* %l8
  %t323 = load double, double* %l9
  %t324 = load double, double* %l10
  %t325 = load double, double* %l11
  %t326 = load double, double* %l12
  %t327 = load i8*, i8** %l13
  br i1 %t313, label %then27, label %else28
then27:
  %t328 = load i8*, i8** %l13
  %t329 = load i8*, i8** %l13
  %t330 = call i64 @sailfin_runtime_string_length(i8* %t329)
  %t331 = call i8* @sailfin_runtime_substring(i8* %t328, i64 6, i64 %t330)
  store i8* %t331, i8** %l18
  %t332 = load i8*, i8** %l18
  %t333 = call %NumberParseResult @parse_decimal_number(i8* %t332)
  store %NumberParseResult %t333, %NumberParseResult* %l19
  %t334 = load %NumberParseResult, %NumberParseResult* %l19
  %t335 = extractvalue %NumberParseResult %t334, 0
  %t336 = load i8*, i8** %l0
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t338 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t340 = load i8*, i8** %l4
  %t341 = load i8*, i8** %l5
  %t342 = load i1, i1* %l6
  %t343 = load i1, i1* %l7
  %t344 = load i1, i1* %l8
  %t345 = load double, double* %l9
  %t346 = load double, double* %l10
  %t347 = load double, double* %l11
  %t348 = load double, double* %l12
  %t349 = load i8*, i8** %l13
  %t350 = load i8*, i8** %l18
  %t351 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t335, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t352 = load %NumberParseResult, %NumberParseResult* %l19
  %t353 = extractvalue %NumberParseResult %t352, 1
  store double %t353, double* %l11
  %t354 = load i1, i1* %l8
  %t355 = load double, double* %l11
  br label %merge32
else31:
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t357 = call i8* @malloc(i64 8)
  %t358 = bitcast i8* %t357 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t358
  %t359 = call i8* @sailfin_runtime_string_concat(i8* %t357, i8* %struct_name)
  %t360 = call i8* @malloc(i64 16)
  %t361 = bitcast i8* %t360 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t361
  %t362 = call i8* @sailfin_runtime_string_concat(i8* %t359, i8* %t360)
  %t363 = load i8*, i8** %l4
  %t364 = call i8* @sailfin_runtime_string_concat(i8* %t362, i8* %t363)
  %t365 = call i8* @malloc(i64 22)
  %t366 = bitcast i8* %t365 to [22 x i8]*
  store [22 x i8] c"` has invalid align `\00", [22 x i8]* %t366
  %t367 = call i8* @sailfin_runtime_string_concat(i8* %t364, i8* %t365)
  %t368 = load i8*, i8** %l18
  %t369 = call i8* @sailfin_runtime_string_concat(i8* %t367, i8* %t368)
  %t370 = add i64 0, 2
  %t371 = call i8* @malloc(i64 %t370)
  store i8 96, i8* %t371
  %t372 = getelementptr i8, i8* %t371, i64 1
  store i8 0, i8* %t372
  call void @sailfin_runtime_mark_persistent(i8* %t371)
  %t373 = call i8* @sailfin_runtime_string_concat(i8* %t369, i8* %t371)
  %t374 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t356, i8* %t373)
  store { i8**, i64 }* %t374, { i8**, i64 }** %l1
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t376 = phi i1 [ %t354, %then30 ], [ %t344, %else31 ]
  %t377 = phi double [ %t355, %then30 ], [ %t347, %else31 ]
  %t378 = phi { i8**, i64 }* [ %t337, %then30 ], [ %t375, %else31 ]
  store i1 %t376, i1* %l8
  store double %t377, double* %l11
  store { i8**, i64 }* %t378, { i8**, i64 }** %l1
  %t379 = load i1, i1* %l8
  %t380 = load double, double* %l11
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t383 = call i8* @malloc(i64 8)
  %t384 = bitcast i8* %t383 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t384
  %t385 = call i8* @sailfin_runtime_string_concat(i8* %t383, i8* %struct_name)
  %t386 = call i8* @malloc(i64 16)
  %t387 = bitcast i8* %t386 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t387
  %t388 = call i8* @sailfin_runtime_string_concat(i8* %t385, i8* %t386)
  %t389 = load i8*, i8** %l4
  %t390 = call i8* @sailfin_runtime_string_concat(i8* %t388, i8* %t389)
  %t391 = call i8* @malloc(i64 23)
  %t392 = bitcast i8* %t391 to [23 x i8]*
  store [23 x i8] c"` unrecognized token `\00", [23 x i8]* %t392
  %t393 = call i8* @sailfin_runtime_string_concat(i8* %t390, i8* %t391)
  %t394 = load i8*, i8** %l13
  %t395 = call i8* @sailfin_runtime_string_concat(i8* %t393, i8* %t394)
  %t396 = add i64 0, 2
  %t397 = call i8* @malloc(i64 %t396)
  store i8 96, i8* %t397
  %t398 = getelementptr i8, i8* %t397, i64 1
  store i8 0, i8* %t398
  call void @sailfin_runtime_mark_persistent(i8* %t397)
  %t399 = call i8* @sailfin_runtime_string_concat(i8* %t395, i8* %t397)
  %t400 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t382, i8* %t399)
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t402 = phi i1 [ %t379, %merge32 ], [ %t322, %else28 ]
  %t403 = phi double [ %t380, %merge32 ], [ %t325, %else28 ]
  %t404 = phi { i8**, i64 }* [ %t381, %merge32 ], [ %t401, %else28 ]
  store i1 %t402, i1* %l8
  store double %t403, double* %l11
  store { i8**, i64 }* %t404, { i8**, i64 }** %l1
  %t405 = load i1, i1* %l8
  %t406 = load double, double* %l11
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t409 = phi i1 [ %t307, %merge26 ], [ %t249, %merge29 ]
  %t410 = phi double [ %t308, %merge26 ], [ %t252, %merge29 ]
  %t411 = phi { i8**, i64 }* [ %t309, %merge26 ], [ %t407, %merge29 ]
  %t412 = phi i1 [ %t250, %merge26 ], [ %t405, %merge29 ]
  %t413 = phi double [ %t253, %merge26 ], [ %t406, %merge29 ]
  store i1 %t409, i1* %l7
  store double %t410, double* %l10
  store { i8**, i64 }* %t411, { i8**, i64 }** %l1
  store i1 %t412, i1* %l8
  store double %t413, double* %l11
  %t414 = load i1, i1* %l7
  %t415 = load double, double* %l10
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t417 = load i1, i1* %l8
  %t418 = load double, double* %l11
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t421 = phi i1 [ %t235, %merge20 ], [ %t176, %merge23 ]
  %t422 = phi double [ %t236, %merge20 ], [ %t179, %merge23 ]
  %t423 = phi { i8**, i64 }* [ %t237, %merge20 ], [ %t416, %merge23 ]
  %t424 = phi i1 [ %t177, %merge20 ], [ %t414, %merge23 ]
  %t425 = phi double [ %t180, %merge20 ], [ %t415, %merge23 ]
  %t426 = phi i1 [ %t178, %merge20 ], [ %t417, %merge23 ]
  %t427 = phi double [ %t181, %merge20 ], [ %t418, %merge23 ]
  store i1 %t421, i1* %l6
  store double %t422, double* %l9
  store { i8**, i64 }* %t423, { i8**, i64 }** %l1
  store i1 %t424, i1* %l7
  store double %t425, double* %l10
  store i1 %t426, i1* %l8
  store double %t427, double* %l11
  %t428 = load i1, i1* %l6
  %t429 = load double, double* %l9
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t431 = load i1, i1* %l7
  %t432 = load double, double* %l10
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t434 = load i1, i1* %l8
  %t435 = load double, double* %l11
  %t436 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t438 = phi i8* [ %t165, %then12 ], [ %t152, %merge17 ]
  %t439 = phi i1 [ %t153, %then12 ], [ %t428, %merge17 ]
  %t440 = phi double [ %t156, %then12 ], [ %t429, %merge17 ]
  %t441 = phi { i8**, i64 }* [ %t148, %then12 ], [ %t430, %merge17 ]
  %t442 = phi i1 [ %t154, %then12 ], [ %t431, %merge17 ]
  %t443 = phi double [ %t157, %then12 ], [ %t432, %merge17 ]
  %t444 = phi i1 [ %t155, %then12 ], [ %t434, %merge17 ]
  %t445 = phi double [ %t158, %then12 ], [ %t435, %merge17 ]
  store i8* %t438, i8** %l5
  store i1 %t439, i1* %l6
  store double %t440, double* %l9
  store { i8**, i64 }* %t441, { i8**, i64 }** %l1
  store i1 %t442, i1* %l7
  store double %t443, double* %l10
  store i1 %t444, i1* %l8
  store double %t445, double* %l11
  %t446 = load double, double* %l12
  %t447 = sitofp i64 1 to double
  %t448 = fadd double %t446, %t447
  store double %t448, double* %l12
  br label %loop.latch8
loop.latch8:
  %t449 = load i8*, i8** %l5
  %t450 = load i1, i1* %l6
  %t451 = load double, double* %l9
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t453 = load i1, i1* %l7
  %t454 = load double, double* %l10
  %t455 = load i1, i1* %l8
  %t456 = load double, double* %l11
  %t457 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t467 = load i8*, i8** %l5
  %t468 = load i1, i1* %l6
  %t469 = load double, double* %l9
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t471 = load i1, i1* %l7
  %t472 = load double, double* %l10
  %t473 = load i1, i1* %l8
  %t474 = load double, double* %l11
  %t475 = load double, double* %l12
  %t476 = load i8*, i8** %l5
  %t477 = call i64 @sailfin_runtime_string_length(i8* %t476)
  %t478 = icmp eq i64 %t477, 0
  %t479 = load i8*, i8** %l0
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t481 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t483 = load i8*, i8** %l4
  %t484 = load i8*, i8** %l5
  %t485 = load i1, i1* %l6
  %t486 = load i1, i1* %l7
  %t487 = load i1, i1* %l8
  %t488 = load double, double* %l9
  %t489 = load double, double* %l10
  %t490 = load double, double* %l11
  %t491 = load double, double* %l12
  br i1 %t478, label %then33, label %merge34
then33:
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t493 = call i8* @malloc(i64 8)
  %t494 = bitcast i8* %t493 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t494
  %t495 = call i8* @sailfin_runtime_string_concat(i8* %t493, i8* %struct_name)
  %t496 = call i8* @malloc(i64 16)
  %t497 = bitcast i8* %t496 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t497
  %t498 = call i8* @sailfin_runtime_string_concat(i8* %t495, i8* %t496)
  %t499 = load i8*, i8** %l4
  %t500 = call i8* @sailfin_runtime_string_concat(i8* %t498, i8* %t499)
  %t501 = call i8* @malloc(i64 21)
  %t502 = bitcast i8* %t501 to [21 x i8]*
  store [21 x i8] c"` missing type entry\00", [21 x i8]* %t502
  %t503 = call i8* @sailfin_runtime_string_concat(i8* %t500, i8* %t501)
  %t504 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t492, i8* %t503)
  store { i8**, i64 }* %t504, { i8**, i64 }** %l1
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t506 = phi { i8**, i64 }* [ %t505, %then33 ], [ %t480, %afterloop9 ]
  store { i8**, i64 }* %t506, { i8**, i64 }** %l1
  %t507 = load i1, i1* %l6
  %t508 = xor i1 %t507, 1
  %t509 = load i8*, i8** %l0
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t511 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t513 = load i8*, i8** %l4
  %t514 = load i8*, i8** %l5
  %t515 = load i1, i1* %l6
  %t516 = load i1, i1* %l7
  %t517 = load i1, i1* %l8
  %t518 = load double, double* %l9
  %t519 = load double, double* %l10
  %t520 = load double, double* %l11
  %t521 = load double, double* %l12
  br i1 %t508, label %then35, label %merge36
then35:
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t523 = call i8* @malloc(i64 8)
  %t524 = bitcast i8* %t523 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t524
  %t525 = call i8* @sailfin_runtime_string_concat(i8* %t523, i8* %struct_name)
  %t526 = call i8* @malloc(i64 16)
  %t527 = bitcast i8* %t526 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t527
  %t528 = call i8* @sailfin_runtime_string_concat(i8* %t525, i8* %t526)
  %t529 = load i8*, i8** %l4
  %t530 = call i8* @sailfin_runtime_string_concat(i8* %t528, i8* %t529)
  %t531 = call i8* @malloc(i64 23)
  %t532 = bitcast i8* %t531 to [23 x i8]*
  store [23 x i8] c"` missing offset entry\00", [23 x i8]* %t532
  %t533 = call i8* @sailfin_runtime_string_concat(i8* %t530, i8* %t531)
  %t534 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t522, i8* %t533)
  store { i8**, i64 }* %t534, { i8**, i64 }** %l1
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t536 = phi { i8**, i64 }* [ %t535, %then35 ], [ %t510, %merge34 ]
  store { i8**, i64 }* %t536, { i8**, i64 }** %l1
  %t537 = load i1, i1* %l7
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
  br i1 %t538, label %then37, label %merge38
then37:
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t553 = call i8* @malloc(i64 8)
  %t554 = bitcast i8* %t553 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t554
  %t555 = call i8* @sailfin_runtime_string_concat(i8* %t553, i8* %struct_name)
  %t556 = call i8* @malloc(i64 16)
  %t557 = bitcast i8* %t556 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t557
  %t558 = call i8* @sailfin_runtime_string_concat(i8* %t555, i8* %t556)
  %t559 = load i8*, i8** %l4
  %t560 = call i8* @sailfin_runtime_string_concat(i8* %t558, i8* %t559)
  %t561 = call i8* @malloc(i64 21)
  %t562 = bitcast i8* %t561 to [21 x i8]*
  store [21 x i8] c"` missing size entry\00", [21 x i8]* %t562
  %t563 = call i8* @sailfin_runtime_string_concat(i8* %t560, i8* %t561)
  %t564 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t552, i8* %t563)
  store { i8**, i64 }* %t564, { i8**, i64 }** %l1
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t566 = phi { i8**, i64 }* [ %t565, %then37 ], [ %t540, %merge36 ]
  store { i8**, i64 }* %t566, { i8**, i64 }** %l1
  %t567 = load i1, i1* %l8
  %t568 = xor i1 %t567, 1
  %t569 = load i8*, i8** %l0
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t571 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t572 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t573 = load i8*, i8** %l4
  %t574 = load i8*, i8** %l5
  %t575 = load i1, i1* %l6
  %t576 = load i1, i1* %l7
  %t577 = load i1, i1* %l8
  %t578 = load double, double* %l9
  %t579 = load double, double* %l10
  %t580 = load double, double* %l11
  %t581 = load double, double* %l12
  br i1 %t568, label %then39, label %merge40
then39:
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t583 = call i8* @malloc(i64 8)
  %t584 = bitcast i8* %t583 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t584
  %t585 = call i8* @sailfin_runtime_string_concat(i8* %t583, i8* %struct_name)
  %t586 = call i8* @malloc(i64 16)
  %t587 = bitcast i8* %t586 to [16 x i8]*
  store [16 x i8] c" layout field `\00", [16 x i8]* %t587
  %t588 = call i8* @sailfin_runtime_string_concat(i8* %t585, i8* %t586)
  %t589 = load i8*, i8** %l4
  %t590 = call i8* @sailfin_runtime_string_concat(i8* %t588, i8* %t589)
  %t591 = call i8* @malloc(i64 22)
  %t592 = bitcast i8* %t591 to [22 x i8]*
  store [22 x i8] c"` missing align entry\00", [22 x i8]* %t592
  %t593 = call i8* @sailfin_runtime_string_concat(i8* %t590, i8* %t591)
  %t594 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t582, i8* %t593)
  store { i8**, i64 }* %t594, { i8**, i64 }** %l1
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t596 = phi { i8**, i64 }* [ %t595, %then39 ], [ %t570, %merge38 ]
  store { i8**, i64 }* %t596, { i8**, i64 }** %l1
  %t598 = load i8*, i8** %l5
  %t599 = call i64 @sailfin_runtime_string_length(i8* %t598)
  %t600 = icmp sgt i64 %t599, 0
  br label %logical_and_entry_597

logical_and_entry_597:
  br i1 %t600, label %logical_and_right_597, label %logical_and_merge_597

logical_and_right_597:
  %t602 = load i1, i1* %l6
  br label %logical_and_entry_601

logical_and_entry_601:
  br i1 %t602, label %logical_and_right_601, label %logical_and_merge_601

logical_and_right_601:
  %t604 = load i1, i1* %l7
  br label %logical_and_entry_603

logical_and_entry_603:
  br i1 %t604, label %logical_and_right_603, label %logical_and_merge_603

logical_and_right_603:
  %t606 = load i1, i1* %l8
  br label %logical_and_entry_605

logical_and_entry_605:
  br i1 %t606, label %logical_and_right_605, label %logical_and_merge_605

logical_and_right_605:
  %t607 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t608 = load { i8**, i64 }, { i8**, i64 }* %t607
  %t609 = extractvalue { i8**, i64 } %t608, 1
  %t610 = icmp eq i64 %t609, 0
  br label %logical_and_right_end_605

logical_and_right_end_605:
  br label %logical_and_merge_605

logical_and_merge_605:
  %t611 = phi i1 [ false, %logical_and_entry_605 ], [ %t610, %logical_and_right_end_605 ]
  br label %logical_and_right_end_603

logical_and_right_end_603:
  br label %logical_and_merge_603

logical_and_merge_603:
  %t612 = phi i1 [ false, %logical_and_entry_603 ], [ %t611, %logical_and_right_end_603 ]
  br label %logical_and_right_end_601

logical_and_right_end_601:
  br label %logical_and_merge_601

logical_and_merge_601:
  %t613 = phi i1 [ false, %logical_and_entry_601 ], [ %t612, %logical_and_right_end_601 ]
  br label %logical_and_right_end_597

logical_and_right_end_597:
  br label %logical_and_merge_597

logical_and_merge_597:
  %t614 = phi i1 [ false, %logical_and_entry_597 ], [ %t613, %logical_and_right_end_597 ]
  store i1 %t614, i1* %l20
  %t615 = load i8*, i8** %l4
  %t616 = insertvalue %NativeStructLayoutField undef, i8* %t615, 0
  %t617 = load i8*, i8** %l5
  %t618 = insertvalue %NativeStructLayoutField %t616, i8* %t617, 1
  %t619 = load double, double* %l9
  %t620 = insertvalue %NativeStructLayoutField %t618, double %t619, 2
  %t621 = load double, double* %l10
  %t622 = insertvalue %NativeStructLayoutField %t620, double %t621, 3
  %t623 = load double, double* %l11
  %t624 = insertvalue %NativeStructLayoutField %t622, double %t623, 4
  store %NativeStructLayoutField %t624, %NativeStructLayoutField* %l21
  %t625 = load i1, i1* %l20
  %t626 = insertvalue %StructLayoutFieldParse undef, i1 %t625, 0
  %t627 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t628 = insertvalue %StructLayoutFieldParse %t626, %NativeStructLayoutField %t627, 1
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t630 = insertvalue %StructLayoutFieldParse %t628, { i8**, i64 }* %t629, 2
  ret %StructLayoutFieldParse %t630
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
  %t21 = call i8* @malloc(i64 35)
  %t22 = bitcast i8* %t21 to [35 x i8]*
  store [35 x i8] c"enum layout header missing entries\00", [35 x i8]* %t22
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %t21)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l1
  %t24 = insertvalue %EnumLayoutHeaderParse undef, i1 0, 0
  %t25 = call i8* @malloc(i64 1)
  %t26 = bitcast i8* %t25 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t26
  %t27 = insertvalue %EnumLayoutHeaderParse %t24, i8* %t25, 1
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %EnumLayoutHeaderParse %t27, double %t28, 2
  %t30 = sitofp i64 0 to double
  %t31 = insertvalue %EnumLayoutHeaderParse %t29, double %t30, 3
  %t32 = call i8* @malloc(i64 1)
  %t33 = bitcast i8* %t32 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t33
  %t34 = insertvalue %EnumLayoutHeaderParse %t31, i8* %t32, 4
  %t35 = sitofp i64 0 to double
  %t36 = insertvalue %EnumLayoutHeaderParse %t34, double %t35, 5
  %t37 = sitofp i64 0 to double
  %t38 = insertvalue %EnumLayoutHeaderParse %t36, double %t37, 6
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = insertvalue %EnumLayoutHeaderParse %t38, { i8**, i64 }* %t39, 7
  ret %EnumLayoutHeaderParse %t40
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %t41 = call i8* @malloc(i64 1)
  %t42 = bitcast i8* %t41 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t42
  store i8* %t41, i8** %l5
  %t43 = call i8* @malloc(i64 1)
  %t44 = bitcast i8* %t43 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t44
  store i8* %t43, i8** %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t45 = sitofp i64 0 to double
  store double %t45, double* %l9
  %t46 = sitofp i64 0 to double
  store double %t46, double* %l10
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l11
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l12
  %t49 = sitofp i64 0 to double
  store double %t49, double* %l13
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load i1, i1* %l2
  %t53 = load i1, i1* %l3
  %t54 = load i1, i1* %l4
  %t55 = load i8*, i8** %l5
  %t56 = load i8*, i8** %l6
  %t57 = load i1, i1* %l7
  %t58 = load i1, i1* %l8
  %t59 = load double, double* %l9
  %t60 = load double, double* %l10
  %t61 = load double, double* %l11
  %t62 = load double, double* %l12
  %t63 = load double, double* %l13
  br label %loop.header2
loop.header2:
  %t518 = phi i8* [ %t55, %merge1 ], [ %t505, %loop.latch4 ]
  %t519 = phi i1 [ %t52, %merge1 ], [ %t506, %loop.latch4 ]
  %t520 = phi i1 [ %t53, %merge1 ], [ %t507, %loop.latch4 ]
  %t521 = phi double [ %t59, %merge1 ], [ %t508, %loop.latch4 ]
  %t522 = phi { i8**, i64 }* [ %t51, %merge1 ], [ %t509, %loop.latch4 ]
  %t523 = phi i1 [ %t54, %merge1 ], [ %t510, %loop.latch4 ]
  %t524 = phi double [ %t60, %merge1 ], [ %t511, %loop.latch4 ]
  %t525 = phi i8* [ %t56, %merge1 ], [ %t512, %loop.latch4 ]
  %t526 = phi i1 [ %t57, %merge1 ], [ %t513, %loop.latch4 ]
  %t527 = phi double [ %t61, %merge1 ], [ %t514, %loop.latch4 ]
  %t528 = phi i1 [ %t58, %merge1 ], [ %t515, %loop.latch4 ]
  %t529 = phi double [ %t62, %merge1 ], [ %t516, %loop.latch4 ]
  %t530 = phi double [ %t63, %merge1 ], [ %t517, %loop.latch4 ]
  store i8* %t518, i8** %l5
  store i1 %t519, i1* %l2
  store i1 %t520, i1* %l3
  store double %t521, double* %l9
  store { i8**, i64 }* %t522, { i8**, i64 }** %l1
  store i1 %t523, i1* %l4
  store double %t524, double* %l10
  store i8* %t525, i8** %l6
  store i1 %t526, i1* %l7
  store double %t527, double* %l11
  store i1 %t528, i1* %l8
  store double %t529, double* %l12
  store double %t530, double* %l13
  br label %loop.body3
loop.body3:
  %t64 = load double, double* %l13
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t67 = extractvalue { i8**, i64 } %t66, 1
  %t68 = sitofp i64 %t67 to double
  %t69 = fcmp oge double %t64, %t68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load i1, i1* %l2
  %t73 = load i1, i1* %l3
  %t74 = load i1, i1* %l4
  %t75 = load i8*, i8** %l5
  %t76 = load i8*, i8** %l6
  %t77 = load i1, i1* %l7
  %t78 = load i1, i1* %l8
  %t79 = load double, double* %l9
  %t80 = load double, double* %l10
  %t81 = load double, double* %l11
  %t82 = load double, double* %l12
  %t83 = load double, double* %l13
  br i1 %t69, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load double, double* %l13
  %t86 = call double @llvm.round.f64(double %t85)
  %t87 = fptosi double %t86 to i64
  %t88 = load { i8**, i64 }, { i8**, i64 }* %t84
  %t89 = extractvalue { i8**, i64 } %t88, 0
  %t90 = extractvalue { i8**, i64 } %t88, 1
  %t91 = icmp uge i64 %t87, %t90
  ; bounds check: %t91 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t87, i64 %t90)
  %t92 = getelementptr i8*, i8** %t89, i64 %t87
  %t93 = load i8*, i8** %t92
  store i8* %t93, i8** %l14
  %t94 = load i8*, i8** %l14
  %t95 = call i8* @malloc(i64 6)
  %t96 = bitcast i8* %t95 to [6 x i8]*
  store [6 x i8] c"name=\00", [6 x i8]* %t96
  %t97 = call i1 @starts_with(i8* %t94, i8* %t95)
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load i1, i1* %l2
  %t101 = load i1, i1* %l3
  %t102 = load i1, i1* %l4
  %t103 = load i8*, i8** %l5
  %t104 = load i8*, i8** %l6
  %t105 = load i1, i1* %l7
  %t106 = load i1, i1* %l8
  %t107 = load double, double* %l9
  %t108 = load double, double* %l10
  %t109 = load double, double* %l11
  %t110 = load double, double* %l12
  %t111 = load double, double* %l13
  %t112 = load i8*, i8** %l14
  br i1 %t97, label %then8, label %else9
then8:
  %t113 = load i8*, i8** %l14
  %t114 = load i8*, i8** %l14
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = call i8* @sailfin_runtime_substring(i8* %t113, i64 5, i64 %t115)
  store i8* %t116, i8** %l5
  store i1 1, i1* %l2
  %t117 = load i8*, i8** %l5
  %t118 = load i1, i1* %l2
  br label %merge10
else9:
  %t119 = load i8*, i8** %l14
  %t120 = call i8* @malloc(i64 6)
  %t121 = bitcast i8* %t120 to [6 x i8]*
  store [6 x i8] c"size=\00", [6 x i8]* %t121
  %t122 = call i1 @starts_with(i8* %t119, i8* %t120)
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t125 = load i1, i1* %l2
  %t126 = load i1, i1* %l3
  %t127 = load i1, i1* %l4
  %t128 = load i8*, i8** %l5
  %t129 = load i8*, i8** %l6
  %t130 = load i1, i1* %l7
  %t131 = load i1, i1* %l8
  %t132 = load double, double* %l9
  %t133 = load double, double* %l10
  %t134 = load double, double* %l11
  %t135 = load double, double* %l12
  %t136 = load double, double* %l13
  %t137 = load i8*, i8** %l14
  br i1 %t122, label %then11, label %else12
then11:
  %t138 = load i8*, i8** %l14
  %t139 = load i8*, i8** %l14
  %t140 = call i64 @sailfin_runtime_string_length(i8* %t139)
  %t141 = call i8* @sailfin_runtime_substring(i8* %t138, i64 5, i64 %t140)
  store i8* %t141, i8** %l15
  %t142 = load i8*, i8** %l15
  %t143 = call %NumberParseResult @parse_decimal_number(i8* %t142)
  store %NumberParseResult %t143, %NumberParseResult* %l16
  %t144 = load %NumberParseResult, %NumberParseResult* %l16
  %t145 = extractvalue %NumberParseResult %t144, 0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t148 = load i1, i1* %l2
  %t149 = load i1, i1* %l3
  %t150 = load i1, i1* %l4
  %t151 = load i8*, i8** %l5
  %t152 = load i8*, i8** %l6
  %t153 = load i1, i1* %l7
  %t154 = load i1, i1* %l8
  %t155 = load double, double* %l9
  %t156 = load double, double* %l10
  %t157 = load double, double* %l11
  %t158 = load double, double* %l12
  %t159 = load double, double* %l13
  %t160 = load i8*, i8** %l14
  %t161 = load i8*, i8** %l15
  %t162 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t145, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t163 = load %NumberParseResult, %NumberParseResult* %l16
  %t164 = extractvalue %NumberParseResult %t163, 1
  store double %t164, double* %l9
  %t165 = load i1, i1* %l3
  %t166 = load double, double* %l9
  br label %merge16
else15:
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = call i8* @malloc(i64 38)
  %t169 = bitcast i8* %t168 to [38 x i8]*
  store [38 x i8] c"enum layout header has invalid size `\00", [38 x i8]* %t169
  %t170 = load i8*, i8** %l15
  %t171 = call i8* @sailfin_runtime_string_concat(i8* %t168, i8* %t170)
  %t172 = add i64 0, 2
  %t173 = call i8* @malloc(i64 %t172)
  store i8 96, i8* %t173
  %t174 = getelementptr i8, i8* %t173, i64 1
  store i8 0, i8* %t174
  call void @sailfin_runtime_mark_persistent(i8* %t173)
  %t175 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %t173)
  %t176 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t167, i8* %t175)
  store { i8**, i64 }* %t176, { i8**, i64 }** %l1
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t178 = phi i1 [ %t165, %then14 ], [ %t149, %else15 ]
  %t179 = phi double [ %t166, %then14 ], [ %t155, %else15 ]
  %t180 = phi { i8**, i64 }* [ %t147, %then14 ], [ %t177, %else15 ]
  store i1 %t178, i1* %l3
  store double %t179, double* %l9
  store { i8**, i64 }* %t180, { i8**, i64 }** %l1
  %t181 = load i1, i1* %l3
  %t182 = load double, double* %l9
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t184 = load i8*, i8** %l14
  %t185 = call i8* @malloc(i64 7)
  %t186 = bitcast i8* %t185 to [7 x i8]*
  store [7 x i8] c"align=\00", [7 x i8]* %t186
  %t187 = call i1 @starts_with(i8* %t184, i8* %t185)
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t190 = load i1, i1* %l2
  %t191 = load i1, i1* %l3
  %t192 = load i1, i1* %l4
  %t193 = load i8*, i8** %l5
  %t194 = load i8*, i8** %l6
  %t195 = load i1, i1* %l7
  %t196 = load i1, i1* %l8
  %t197 = load double, double* %l9
  %t198 = load double, double* %l10
  %t199 = load double, double* %l11
  %t200 = load double, double* %l12
  %t201 = load double, double* %l13
  %t202 = load i8*, i8** %l14
  br i1 %t187, label %then17, label %else18
then17:
  %t203 = load i8*, i8** %l14
  %t204 = load i8*, i8** %l14
  %t205 = call i64 @sailfin_runtime_string_length(i8* %t204)
  %t206 = call i8* @sailfin_runtime_substring(i8* %t203, i64 6, i64 %t205)
  store i8* %t206, i8** %l17
  %t207 = load i8*, i8** %l17
  %t208 = call %NumberParseResult @parse_decimal_number(i8* %t207)
  store %NumberParseResult %t208, %NumberParseResult* %l18
  %t209 = load %NumberParseResult, %NumberParseResult* %l18
  %t210 = extractvalue %NumberParseResult %t209, 0
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = load i1, i1* %l2
  %t214 = load i1, i1* %l3
  %t215 = load i1, i1* %l4
  %t216 = load i8*, i8** %l5
  %t217 = load i8*, i8** %l6
  %t218 = load i1, i1* %l7
  %t219 = load i1, i1* %l8
  %t220 = load double, double* %l9
  %t221 = load double, double* %l10
  %t222 = load double, double* %l11
  %t223 = load double, double* %l12
  %t224 = load double, double* %l13
  %t225 = load i8*, i8** %l14
  %t226 = load i8*, i8** %l17
  %t227 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t210, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t228 = load %NumberParseResult, %NumberParseResult* %l18
  %t229 = extractvalue %NumberParseResult %t228, 1
  store double %t229, double* %l10
  %t230 = load i1, i1* %l4
  %t231 = load double, double* %l10
  br label %merge22
else21:
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t233 = call i8* @malloc(i64 39)
  %t234 = bitcast i8* %t233 to [39 x i8]*
  store [39 x i8] c"enum layout header has invalid align `\00", [39 x i8]* %t234
  %t235 = load i8*, i8** %l17
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %t233, i8* %t235)
  %t237 = add i64 0, 2
  %t238 = call i8* @malloc(i64 %t237)
  store i8 96, i8* %t238
  %t239 = getelementptr i8, i8* %t238, i64 1
  store i8 0, i8* %t239
  call void @sailfin_runtime_mark_persistent(i8* %t238)
  %t240 = call i8* @sailfin_runtime_string_concat(i8* %t236, i8* %t238)
  %t241 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t232, i8* %t240)
  store { i8**, i64 }* %t241, { i8**, i64 }** %l1
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t243 = phi i1 [ %t230, %then20 ], [ %t215, %else21 ]
  %t244 = phi double [ %t231, %then20 ], [ %t221, %else21 ]
  %t245 = phi { i8**, i64 }* [ %t212, %then20 ], [ %t242, %else21 ]
  store i1 %t243, i1* %l4
  store double %t244, double* %l10
  store { i8**, i64 }* %t245, { i8**, i64 }** %l1
  %t246 = load i1, i1* %l4
  %t247 = load double, double* %l10
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t249 = load i8*, i8** %l14
  %t250 = call i8* @malloc(i64 10)
  %t251 = bitcast i8* %t250 to [10 x i8]*
  store [10 x i8] c"tag_type=\00", [10 x i8]* %t251
  %t252 = call i1 @starts_with(i8* %t249, i8* %t250)
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t255 = load i1, i1* %l2
  %t256 = load i1, i1* %l3
  %t257 = load i1, i1* %l4
  %t258 = load i8*, i8** %l5
  %t259 = load i8*, i8** %l6
  %t260 = load i1, i1* %l7
  %t261 = load i1, i1* %l8
  %t262 = load double, double* %l9
  %t263 = load double, double* %l10
  %t264 = load double, double* %l11
  %t265 = load double, double* %l12
  %t266 = load double, double* %l13
  %t267 = load i8*, i8** %l14
  br i1 %t252, label %then23, label %else24
then23:
  %t268 = load i8*, i8** %l14
  %t269 = load i8*, i8** %l14
  %t270 = call i64 @sailfin_runtime_string_length(i8* %t269)
  %t271 = call i8* @sailfin_runtime_substring(i8* %t268, i64 9, i64 %t270)
  store i8* %t271, i8** %l6
  %t272 = load i8*, i8** %l6
  br label %merge25
else24:
  %t273 = load i8*, i8** %l14
  %t274 = call i8* @malloc(i64 10)
  %t275 = bitcast i8* %t274 to [10 x i8]*
  store [10 x i8] c"tag_size=\00", [10 x i8]* %t275
  %t276 = call i1 @starts_with(i8* %t273, i8* %t274)
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t279 = load i1, i1* %l2
  %t280 = load i1, i1* %l3
  %t281 = load i1, i1* %l4
  %t282 = load i8*, i8** %l5
  %t283 = load i8*, i8** %l6
  %t284 = load i1, i1* %l7
  %t285 = load i1, i1* %l8
  %t286 = load double, double* %l9
  %t287 = load double, double* %l10
  %t288 = load double, double* %l11
  %t289 = load double, double* %l12
  %t290 = load double, double* %l13
  %t291 = load i8*, i8** %l14
  br i1 %t276, label %then26, label %else27
then26:
  %t292 = load i8*, i8** %l14
  %t293 = load i8*, i8** %l14
  %t294 = call i64 @sailfin_runtime_string_length(i8* %t293)
  %t295 = call i8* @sailfin_runtime_substring(i8* %t292, i64 9, i64 %t294)
  store i8* %t295, i8** %l19
  %t296 = load i8*, i8** %l19
  %t297 = call %NumberParseResult @parse_decimal_number(i8* %t296)
  store %NumberParseResult %t297, %NumberParseResult* %l20
  %t298 = load %NumberParseResult, %NumberParseResult* %l20
  %t299 = extractvalue %NumberParseResult %t298, 0
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t302 = load i1, i1* %l2
  %t303 = load i1, i1* %l3
  %t304 = load i1, i1* %l4
  %t305 = load i8*, i8** %l5
  %t306 = load i8*, i8** %l6
  %t307 = load i1, i1* %l7
  %t308 = load i1, i1* %l8
  %t309 = load double, double* %l9
  %t310 = load double, double* %l10
  %t311 = load double, double* %l11
  %t312 = load double, double* %l12
  %t313 = load double, double* %l13
  %t314 = load i8*, i8** %l14
  %t315 = load i8*, i8** %l19
  %t316 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t299, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t317 = load %NumberParseResult, %NumberParseResult* %l20
  %t318 = extractvalue %NumberParseResult %t317, 1
  store double %t318, double* %l11
  %t319 = load i1, i1* %l7
  %t320 = load double, double* %l11
  br label %merge31
else30:
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t322 = call i8* @malloc(i64 42)
  %t323 = bitcast i8* %t322 to [42 x i8]*
  store [42 x i8] c"enum layout header has invalid tag_size `\00", [42 x i8]* %t323
  %t324 = load i8*, i8** %l19
  %t325 = call i8* @sailfin_runtime_string_concat(i8* %t322, i8* %t324)
  %t326 = add i64 0, 2
  %t327 = call i8* @malloc(i64 %t326)
  store i8 96, i8* %t327
  %t328 = getelementptr i8, i8* %t327, i64 1
  store i8 0, i8* %t328
  call void @sailfin_runtime_mark_persistent(i8* %t327)
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %t325, i8* %t327)
  %t330 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t321, i8* %t329)
  store { i8**, i64 }* %t330, { i8**, i64 }** %l1
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t332 = phi i1 [ %t319, %then29 ], [ %t307, %else30 ]
  %t333 = phi double [ %t320, %then29 ], [ %t311, %else30 ]
  %t334 = phi { i8**, i64 }* [ %t301, %then29 ], [ %t331, %else30 ]
  store i1 %t332, i1* %l7
  store double %t333, double* %l11
  store { i8**, i64 }* %t334, { i8**, i64 }** %l1
  %t335 = load i1, i1* %l7
  %t336 = load double, double* %l11
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t338 = load i8*, i8** %l14
  %t339 = call i8* @malloc(i64 11)
  %t340 = bitcast i8* %t339 to [11 x i8]*
  store [11 x i8] c"tag_align=\00", [11 x i8]* %t340
  %t341 = call i1 @starts_with(i8* %t338, i8* %t339)
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t344 = load i1, i1* %l2
  %t345 = load i1, i1* %l3
  %t346 = load i1, i1* %l4
  %t347 = load i8*, i8** %l5
  %t348 = load i8*, i8** %l6
  %t349 = load i1, i1* %l7
  %t350 = load i1, i1* %l8
  %t351 = load double, double* %l9
  %t352 = load double, double* %l10
  %t353 = load double, double* %l11
  %t354 = load double, double* %l12
  %t355 = load double, double* %l13
  %t356 = load i8*, i8** %l14
  br i1 %t341, label %then32, label %else33
then32:
  %t357 = load i8*, i8** %l14
  %t358 = load i8*, i8** %l14
  %t359 = call i64 @sailfin_runtime_string_length(i8* %t358)
  %t360 = call i8* @sailfin_runtime_substring(i8* %t357, i64 10, i64 %t359)
  store i8* %t360, i8** %l21
  %t361 = load i8*, i8** %l21
  %t362 = call %NumberParseResult @parse_decimal_number(i8* %t361)
  store %NumberParseResult %t362, %NumberParseResult* %l22
  %t363 = load %NumberParseResult, %NumberParseResult* %l22
  %t364 = extractvalue %NumberParseResult %t363, 0
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t367 = load i1, i1* %l2
  %t368 = load i1, i1* %l3
  %t369 = load i1, i1* %l4
  %t370 = load i8*, i8** %l5
  %t371 = load i8*, i8** %l6
  %t372 = load i1, i1* %l7
  %t373 = load i1, i1* %l8
  %t374 = load double, double* %l9
  %t375 = load double, double* %l10
  %t376 = load double, double* %l11
  %t377 = load double, double* %l12
  %t378 = load double, double* %l13
  %t379 = load i8*, i8** %l14
  %t380 = load i8*, i8** %l21
  %t381 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t364, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t382 = load %NumberParseResult, %NumberParseResult* %l22
  %t383 = extractvalue %NumberParseResult %t382, 1
  store double %t383, double* %l12
  %t384 = load i1, i1* %l8
  %t385 = load double, double* %l12
  br label %merge37
else36:
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t387 = call i8* @malloc(i64 43)
  %t388 = bitcast i8* %t387 to [43 x i8]*
  store [43 x i8] c"enum layout header has invalid tag_align `\00", [43 x i8]* %t388
  %t389 = load i8*, i8** %l21
  %t390 = call i8* @sailfin_runtime_string_concat(i8* %t387, i8* %t389)
  %t391 = add i64 0, 2
  %t392 = call i8* @malloc(i64 %t391)
  store i8 96, i8* %t392
  %t393 = getelementptr i8, i8* %t392, i64 1
  store i8 0, i8* %t393
  call void @sailfin_runtime_mark_persistent(i8* %t392)
  %t394 = call i8* @sailfin_runtime_string_concat(i8* %t390, i8* %t392)
  %t395 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t386, i8* %t394)
  store { i8**, i64 }* %t395, { i8**, i64 }** %l1
  %t396 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t397 = phi i1 [ %t384, %then35 ], [ %t373, %else36 ]
  %t398 = phi double [ %t385, %then35 ], [ %t377, %else36 ]
  %t399 = phi { i8**, i64 }* [ %t366, %then35 ], [ %t396, %else36 ]
  store i1 %t397, i1* %l8
  store double %t398, double* %l12
  store { i8**, i64 }* %t399, { i8**, i64 }** %l1
  %t400 = load i1, i1* %l8
  %t401 = load double, double* %l12
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t404 = call i8* @malloc(i64 40)
  %t405 = bitcast i8* %t404 to [40 x i8]*
  store [40 x i8] c"enum layout header unrecognized token `\00", [40 x i8]* %t405
  %t406 = load i8*, i8** %l14
  %t407 = call i8* @sailfin_runtime_string_concat(i8* %t404, i8* %t406)
  %t408 = add i64 0, 2
  %t409 = call i8* @malloc(i64 %t408)
  store i8 96, i8* %t409
  %t410 = getelementptr i8, i8* %t409, i64 1
  store i8 0, i8* %t410
  call void @sailfin_runtime_mark_persistent(i8* %t409)
  %t411 = call i8* @sailfin_runtime_string_concat(i8* %t407, i8* %t409)
  %t412 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t403, i8* %t411)
  store { i8**, i64 }* %t412, { i8**, i64 }** %l1
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t414 = phi i1 [ %t400, %merge37 ], [ %t350, %else33 ]
  %t415 = phi double [ %t401, %merge37 ], [ %t354, %else33 ]
  %t416 = phi { i8**, i64 }* [ %t402, %merge37 ], [ %t413, %else33 ]
  store i1 %t414, i1* %l8
  store double %t415, double* %l12
  store { i8**, i64 }* %t416, { i8**, i64 }** %l1
  %t417 = load i1, i1* %l8
  %t418 = load double, double* %l12
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t421 = phi i1 [ %t335, %merge31 ], [ %t284, %merge34 ]
  %t422 = phi double [ %t336, %merge31 ], [ %t288, %merge34 ]
  %t423 = phi { i8**, i64 }* [ %t337, %merge31 ], [ %t419, %merge34 ]
  %t424 = phi i1 [ %t285, %merge31 ], [ %t417, %merge34 ]
  %t425 = phi double [ %t289, %merge31 ], [ %t418, %merge34 ]
  store i1 %t421, i1* %l7
  store double %t422, double* %l11
  store { i8**, i64 }* %t423, { i8**, i64 }** %l1
  store i1 %t424, i1* %l8
  store double %t425, double* %l12
  %t426 = load i1, i1* %l7
  %t427 = load double, double* %l11
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t429 = load i1, i1* %l8
  %t430 = load double, double* %l12
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t433 = phi i8* [ %t272, %then23 ], [ %t259, %merge28 ]
  %t434 = phi i1 [ %t260, %then23 ], [ %t426, %merge28 ]
  %t435 = phi double [ %t264, %then23 ], [ %t427, %merge28 ]
  %t436 = phi { i8**, i64 }* [ %t254, %then23 ], [ %t428, %merge28 ]
  %t437 = phi i1 [ %t261, %then23 ], [ %t429, %merge28 ]
  %t438 = phi double [ %t265, %then23 ], [ %t430, %merge28 ]
  store i8* %t433, i8** %l6
  store i1 %t434, i1* %l7
  store double %t435, double* %l11
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  store i1 %t437, i1* %l8
  store double %t438, double* %l12
  %t439 = load i8*, i8** %l6
  %t440 = load i1, i1* %l7
  %t441 = load double, double* %l11
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t443 = load i1, i1* %l8
  %t444 = load double, double* %l12
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t447 = phi i1 [ %t246, %merge22 ], [ %t192, %merge25 ]
  %t448 = phi double [ %t247, %merge22 ], [ %t198, %merge25 ]
  %t449 = phi { i8**, i64 }* [ %t248, %merge22 ], [ %t442, %merge25 ]
  %t450 = phi i8* [ %t194, %merge22 ], [ %t439, %merge25 ]
  %t451 = phi i1 [ %t195, %merge22 ], [ %t440, %merge25 ]
  %t452 = phi double [ %t199, %merge22 ], [ %t441, %merge25 ]
  %t453 = phi i1 [ %t196, %merge22 ], [ %t443, %merge25 ]
  %t454 = phi double [ %t200, %merge22 ], [ %t444, %merge25 ]
  store i1 %t447, i1* %l4
  store double %t448, double* %l10
  store { i8**, i64 }* %t449, { i8**, i64 }** %l1
  store i8* %t450, i8** %l6
  store i1 %t451, i1* %l7
  store double %t452, double* %l11
  store i1 %t453, i1* %l8
  store double %t454, double* %l12
  %t455 = load i1, i1* %l4
  %t456 = load double, double* %l10
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t458 = load i8*, i8** %l6
  %t459 = load i1, i1* %l7
  %t460 = load double, double* %l11
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t462 = load i1, i1* %l8
  %t463 = load double, double* %l12
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t466 = phi i1 [ %t181, %merge16 ], [ %t126, %merge19 ]
  %t467 = phi double [ %t182, %merge16 ], [ %t132, %merge19 ]
  %t468 = phi { i8**, i64 }* [ %t183, %merge16 ], [ %t457, %merge19 ]
  %t469 = phi i1 [ %t127, %merge16 ], [ %t455, %merge19 ]
  %t470 = phi double [ %t133, %merge16 ], [ %t456, %merge19 ]
  %t471 = phi i8* [ %t129, %merge16 ], [ %t458, %merge19 ]
  %t472 = phi i1 [ %t130, %merge16 ], [ %t459, %merge19 ]
  %t473 = phi double [ %t134, %merge16 ], [ %t460, %merge19 ]
  %t474 = phi i1 [ %t131, %merge16 ], [ %t462, %merge19 ]
  %t475 = phi double [ %t135, %merge16 ], [ %t463, %merge19 ]
  store i1 %t466, i1* %l3
  store double %t467, double* %l9
  store { i8**, i64 }* %t468, { i8**, i64 }** %l1
  store i1 %t469, i1* %l4
  store double %t470, double* %l10
  store i8* %t471, i8** %l6
  store i1 %t472, i1* %l7
  store double %t473, double* %l11
  store i1 %t474, i1* %l8
  store double %t475, double* %l12
  %t476 = load i1, i1* %l3
  %t477 = load double, double* %l9
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t479 = load i1, i1* %l4
  %t480 = load double, double* %l10
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t482 = load i8*, i8** %l6
  %t483 = load i1, i1* %l7
  %t484 = load double, double* %l11
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t486 = load i1, i1* %l8
  %t487 = load double, double* %l12
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t490 = phi i8* [ %t117, %then8 ], [ %t103, %merge13 ]
  %t491 = phi i1 [ %t118, %then8 ], [ %t100, %merge13 ]
  %t492 = phi i1 [ %t101, %then8 ], [ %t476, %merge13 ]
  %t493 = phi double [ %t107, %then8 ], [ %t477, %merge13 ]
  %t494 = phi { i8**, i64 }* [ %t99, %then8 ], [ %t478, %merge13 ]
  %t495 = phi i1 [ %t102, %then8 ], [ %t479, %merge13 ]
  %t496 = phi double [ %t108, %then8 ], [ %t480, %merge13 ]
  %t497 = phi i8* [ %t104, %then8 ], [ %t482, %merge13 ]
  %t498 = phi i1 [ %t105, %then8 ], [ %t483, %merge13 ]
  %t499 = phi double [ %t109, %then8 ], [ %t484, %merge13 ]
  %t500 = phi i1 [ %t106, %then8 ], [ %t486, %merge13 ]
  %t501 = phi double [ %t110, %then8 ], [ %t487, %merge13 ]
  store i8* %t490, i8** %l5
  store i1 %t491, i1* %l2
  store i1 %t492, i1* %l3
  store double %t493, double* %l9
  store { i8**, i64 }* %t494, { i8**, i64 }** %l1
  store i1 %t495, i1* %l4
  store double %t496, double* %l10
  store i8* %t497, i8** %l6
  store i1 %t498, i1* %l7
  store double %t499, double* %l11
  store i1 %t500, i1* %l8
  store double %t501, double* %l12
  %t502 = load double, double* %l13
  %t503 = sitofp i64 1 to double
  %t504 = fadd double %t502, %t503
  store double %t504, double* %l13
  br label %loop.latch4
loop.latch4:
  %t505 = load i8*, i8** %l5
  %t506 = load i1, i1* %l2
  %t507 = load i1, i1* %l3
  %t508 = load double, double* %l9
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load i1, i1* %l4
  %t511 = load double, double* %l10
  %t512 = load i8*, i8** %l6
  %t513 = load i1, i1* %l7
  %t514 = load double, double* %l11
  %t515 = load i1, i1* %l8
  %t516 = load double, double* %l12
  %t517 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t531 = load i8*, i8** %l5
  %t532 = load i1, i1* %l2
  %t533 = load i1, i1* %l3
  %t534 = load double, double* %l9
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t536 = load i1, i1* %l4
  %t537 = load double, double* %l10
  %t538 = load i8*, i8** %l6
  %t539 = load i1, i1* %l7
  %t540 = load double, double* %l11
  %t541 = load i1, i1* %l8
  %t542 = load double, double* %l12
  %t543 = load double, double* %l13
  %t544 = load i1, i1* %l3
  %t545 = xor i1 %t544, 1
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t548 = load i1, i1* %l2
  %t549 = load i1, i1* %l3
  %t550 = load i1, i1* %l4
  %t551 = load i8*, i8** %l5
  %t552 = load i8*, i8** %l6
  %t553 = load i1, i1* %l7
  %t554 = load i1, i1* %l8
  %t555 = load double, double* %l9
  %t556 = load double, double* %l10
  %t557 = load double, double* %l11
  %t558 = load double, double* %l12
  %t559 = load double, double* %l13
  br i1 %t545, label %then38, label %merge39
then38:
  %t560 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t561 = call i8* @malloc(i64 38)
  %t562 = bitcast i8* %t561 to [38 x i8]*
  store [38 x i8] c"enum layout header missing size entry\00", [38 x i8]* %t562
  %t563 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t560, i8* %t561)
  store { i8**, i64 }* %t563, { i8**, i64 }** %l1
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t565 = phi { i8**, i64 }* [ %t564, %then38 ], [ %t547, %afterloop5 ]
  store { i8**, i64 }* %t565, { i8**, i64 }** %l1
  %t566 = load i1, i1* %l4
  %t567 = xor i1 %t566, 1
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t570 = load i1, i1* %l2
  %t571 = load i1, i1* %l3
  %t572 = load i1, i1* %l4
  %t573 = load i8*, i8** %l5
  %t574 = load i8*, i8** %l6
  %t575 = load i1, i1* %l7
  %t576 = load i1, i1* %l8
  %t577 = load double, double* %l9
  %t578 = load double, double* %l10
  %t579 = load double, double* %l11
  %t580 = load double, double* %l12
  %t581 = load double, double* %l13
  br i1 %t567, label %then40, label %merge41
then40:
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t583 = call i8* @malloc(i64 39)
  %t584 = bitcast i8* %t583 to [39 x i8]*
  store [39 x i8] c"enum layout header missing align entry\00", [39 x i8]* %t584
  %t585 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t582, i8* %t583)
  store { i8**, i64 }* %t585, { i8**, i64 }** %l1
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t587 = phi { i8**, i64 }* [ %t586, %then40 ], [ %t569, %merge39 ]
  store { i8**, i64 }* %t587, { i8**, i64 }** %l1
  %t588 = load i8*, i8** %l6
  %t589 = call i64 @sailfin_runtime_string_length(i8* %t588)
  %t590 = icmp eq i64 %t589, 0
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = load i1, i1* %l2
  %t594 = load i1, i1* %l3
  %t595 = load i1, i1* %l4
  %t596 = load i8*, i8** %l5
  %t597 = load i8*, i8** %l6
  %t598 = load i1, i1* %l7
  %t599 = load i1, i1* %l8
  %t600 = load double, double* %l9
  %t601 = load double, double* %l10
  %t602 = load double, double* %l11
  %t603 = load double, double* %l12
  %t604 = load double, double* %l13
  br i1 %t590, label %then42, label %merge43
then42:
  %t605 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t606 = call i8* @malloc(i64 42)
  %t607 = bitcast i8* %t606 to [42 x i8]*
  store [42 x i8] c"enum layout header missing tag_type entry\00", [42 x i8]* %t607
  %t608 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t605, i8* %t606)
  store { i8**, i64 }* %t608, { i8**, i64 }** %l1
  %t609 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t610 = phi { i8**, i64 }* [ %t609, %then42 ], [ %t592, %merge41 ]
  store { i8**, i64 }* %t610, { i8**, i64 }** %l1
  %t611 = load i1, i1* %l7
  %t612 = xor i1 %t611, 1
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t614 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t615 = load i1, i1* %l2
  %t616 = load i1, i1* %l3
  %t617 = load i1, i1* %l4
  %t618 = load i8*, i8** %l5
  %t619 = load i8*, i8** %l6
  %t620 = load i1, i1* %l7
  %t621 = load i1, i1* %l8
  %t622 = load double, double* %l9
  %t623 = load double, double* %l10
  %t624 = load double, double* %l11
  %t625 = load double, double* %l12
  %t626 = load double, double* %l13
  br i1 %t612, label %then44, label %merge45
then44:
  %t627 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t628 = call i8* @malloc(i64 42)
  %t629 = bitcast i8* %t628 to [42 x i8]*
  store [42 x i8] c"enum layout header missing tag_size entry\00", [42 x i8]* %t629
  %t630 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t627, i8* %t628)
  store { i8**, i64 }* %t630, { i8**, i64 }** %l1
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t632 = phi { i8**, i64 }* [ %t631, %then44 ], [ %t614, %merge43 ]
  store { i8**, i64 }* %t632, { i8**, i64 }** %l1
  %t633 = load i1, i1* %l8
  %t634 = xor i1 %t633, 1
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t637 = load i1, i1* %l2
  %t638 = load i1, i1* %l3
  %t639 = load i1, i1* %l4
  %t640 = load i8*, i8** %l5
  %t641 = load i8*, i8** %l6
  %t642 = load i1, i1* %l7
  %t643 = load i1, i1* %l8
  %t644 = load double, double* %l9
  %t645 = load double, double* %l10
  %t646 = load double, double* %l11
  %t647 = load double, double* %l12
  %t648 = load double, double* %l13
  br i1 %t634, label %then46, label %merge47
then46:
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t650 = call i8* @malloc(i64 43)
  %t651 = bitcast i8* %t650 to [43 x i8]*
  store [43 x i8] c"enum layout header missing tag_align entry\00", [43 x i8]* %t651
  %t652 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t649, i8* %t650)
  store { i8**, i64 }* %t652, { i8**, i64 }** %l1
  %t653 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t654 = phi { i8**, i64 }* [ %t653, %then46 ], [ %t636, %merge45 ]
  store { i8**, i64 }* %t654, { i8**, i64 }** %l1
  %t656 = load i1, i1* %l3
  br label %logical_and_entry_655

logical_and_entry_655:
  br i1 %t656, label %logical_and_right_655, label %logical_and_merge_655

logical_and_right_655:
  %t658 = load i1, i1* %l4
  br label %logical_and_entry_657

logical_and_entry_657:
  br i1 %t658, label %logical_and_right_657, label %logical_and_merge_657

logical_and_right_657:
  %t660 = load i8*, i8** %l6
  %t661 = call i64 @sailfin_runtime_string_length(i8* %t660)
  %t662 = icmp sgt i64 %t661, 0
  br label %logical_and_entry_659

logical_and_entry_659:
  br i1 %t662, label %logical_and_right_659, label %logical_and_merge_659

logical_and_right_659:
  %t664 = load i1, i1* %l7
  br label %logical_and_entry_663

logical_and_entry_663:
  br i1 %t664, label %logical_and_right_663, label %logical_and_merge_663

logical_and_right_663:
  %t666 = load i1, i1* %l8
  br label %logical_and_entry_665

logical_and_entry_665:
  br i1 %t666, label %logical_and_right_665, label %logical_and_merge_665

logical_and_right_665:
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t668 = load { i8**, i64 }, { i8**, i64 }* %t667
  %t669 = extractvalue { i8**, i64 } %t668, 1
  %t670 = icmp eq i64 %t669, 0
  br label %logical_and_right_end_665

logical_and_right_end_665:
  br label %logical_and_merge_665

logical_and_merge_665:
  %t671 = phi i1 [ false, %logical_and_entry_665 ], [ %t670, %logical_and_right_end_665 ]
  br label %logical_and_right_end_663

logical_and_right_end_663:
  br label %logical_and_merge_663

logical_and_merge_663:
  %t672 = phi i1 [ false, %logical_and_entry_663 ], [ %t671, %logical_and_right_end_663 ]
  br label %logical_and_right_end_659

logical_and_right_end_659:
  br label %logical_and_merge_659

logical_and_merge_659:
  %t673 = phi i1 [ false, %logical_and_entry_659 ], [ %t672, %logical_and_right_end_659 ]
  br label %logical_and_right_end_657

logical_and_right_end_657:
  br label %logical_and_merge_657

logical_and_merge_657:
  %t674 = phi i1 [ false, %logical_and_entry_657 ], [ %t673, %logical_and_right_end_657 ]
  br label %logical_and_right_end_655

logical_and_right_end_655:
  br label %logical_and_merge_655

logical_and_merge_655:
  %t675 = phi i1 [ false, %logical_and_entry_655 ], [ %t674, %logical_and_right_end_655 ]
  store i1 %t675, i1* %l23
  %t676 = load i1, i1* %l23
  %t677 = insertvalue %EnumLayoutHeaderParse undef, i1 %t676, 0
  %t678 = load i8*, i8** %l5
  %t679 = insertvalue %EnumLayoutHeaderParse %t677, i8* %t678, 1
  %t680 = load double, double* %l9
  %t681 = insertvalue %EnumLayoutHeaderParse %t679, double %t680, 2
  %t682 = load double, double* %l10
  %t683 = insertvalue %EnumLayoutHeaderParse %t681, double %t682, 3
  %t684 = load i8*, i8** %l6
  %t685 = insertvalue %EnumLayoutHeaderParse %t683, i8* %t684, 4
  %t686 = load double, double* %l11
  %t687 = insertvalue %EnumLayoutHeaderParse %t685, double %t686, 5
  %t688 = load double, double* %l12
  %t689 = insertvalue %EnumLayoutHeaderParse %t687, double %t688, 6
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t691 = insertvalue %EnumLayoutHeaderParse %t689, { i8**, i64 }* %t690, 7
  ret %EnumLayoutHeaderParse %t691
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
  %t13 = call i8* @malloc(i64 1)
  %t14 = bitcast i8* %t13 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t14
  %t15 = insertvalue %NativeEnumVariantLayout undef, i8* %t13, 0
  %t16 = sitofp i64 0 to double
  %t17 = insertvalue %NativeEnumVariantLayout %t15, double %t16, 1
  %t18 = sitofp i64 0 to double
  %t19 = insertvalue %NativeEnumVariantLayout %t17, double %t18, 2
  %t20 = sitofp i64 0 to double
  %t21 = insertvalue %NativeEnumVariantLayout %t19, double %t20, 3
  %t22 = sitofp i64 0 to double
  %t23 = insertvalue %NativeEnumVariantLayout %t21, double %t22, 4
  %t24 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t25 = ptrtoint [0 x %NativeStructLayoutField]* %t24 to i64
  %t26 = icmp eq i64 %t25, 0
  %t27 = select i1 %t26, i64 1, i64 %t25
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to %NativeStructLayoutField*
  %t30 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t31 = ptrtoint { %NativeStructLayoutField*, i64 }* %t30 to i64
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to { %NativeStructLayoutField*, i64 }*
  %t34 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t33, i32 0, i32 0
  store %NativeStructLayoutField* %t29, %NativeStructLayoutField** %t34
  %t35 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  %t36 = insertvalue %NativeEnumVariantLayout %t23, { %NativeStructLayoutField*, i64 }* %t33, 5
  store %NativeEnumVariantLayout %t36, %NativeEnumVariantLayout* %l2
  %t37 = load i8*, i8** %l0
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  br i1 %t39, label %then0, label %merge1
then0:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = call i8* @malloc(i64 6)
  %t45 = bitcast i8* %t44 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t45
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %enum_name)
  %t47 = call i8* @malloc(i64 32)
  %t48 = bitcast i8* %t47 to [32 x i8]*
  store [32 x i8] c" layout variant missing content\00", [32 x i8]* %t48
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t47)
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l1
  %t51 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t52 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t53 = insertvalue %EnumLayoutVariantParse %t51, %NativeEnumVariantLayout %t52, 1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t55 = insertvalue %EnumLayoutVariantParse %t53, { i8**, i64 }* %t54, 2
  ret %EnumLayoutVariantParse %t55
merge1:
  %t56 = load i8*, i8** %l0
  %t57 = call { i8**, i64 }* @split_whitespace(i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l3
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t60 = extractvalue { i8**, i64 } %t59, 1
  %t61 = icmp eq i64 %t60, 0
  %t62 = load i8*, i8** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t61, label %then2, label %merge3
then2:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = call i8* @malloc(i64 6)
  %t68 = bitcast i8* %t67 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t68
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %enum_name)
  %t70 = call i8* @malloc(i64 32)
  %t71 = bitcast i8* %t70 to [32 x i8]*
  store [32 x i8] c" layout variant missing entries\00", [32 x i8]* %t71
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t70)
  %t73 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l1
  %t74 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t75 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t76 = insertvalue %EnumLayoutVariantParse %t74, %NativeEnumVariantLayout %t75, 1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = insertvalue %EnumLayoutVariantParse %t76, { i8**, i64 }* %t77, 2
  ret %EnumLayoutVariantParse %t78
merge3:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = load { i8**, i64 }, { i8**, i64 }* %t79
  %t81 = extractvalue { i8**, i64 } %t80, 0
  %t82 = extractvalue { i8**, i64 } %t80, 1
  %t83 = icmp uge i64 0, %t82
  ; bounds check: %t83 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t82)
  %t84 = getelementptr i8*, i8** %t81, i64 0
  %t85 = load i8*, i8** %t84
  store i8* %t85, i8** %l4
  %t86 = load i8*, i8** %l4
  %t87 = call i64 @sailfin_runtime_string_length(i8* %t86)
  %t88 = icmp eq i64 %t87, 0
  %t89 = load i8*, i8** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t93 = load i8*, i8** %l4
  br i1 %t88, label %then4, label %merge5
then4:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = call i8* @malloc(i64 6)
  %t96 = bitcast i8* %t95 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t96
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %enum_name)
  %t98 = call i8* @malloc(i64 29)
  %t99 = bitcast i8* %t98 to [29 x i8]*
  store [29 x i8] c" layout variant missing name\00", [29 x i8]* %t99
  %t100 = call i8* @sailfin_runtime_string_concat(i8* %t97, i8* %t98)
  %t101 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t94, i8* %t100)
  store { i8**, i64 }* %t101, { i8**, i64 }** %l1
  %t102 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t103 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t104 = insertvalue %EnumLayoutVariantParse %t102, %NativeEnumVariantLayout %t103, 1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = insertvalue %EnumLayoutVariantParse %t104, { i8**, i64 }* %t105, 2
  ret %EnumLayoutVariantParse %t106
merge5:
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t107 = sitofp i64 0 to double
  store double %t107, double* %l9
  %t108 = sitofp i64 0 to double
  store double %t108, double* %l10
  %t109 = sitofp i64 0 to double
  store double %t109, double* %l11
  %t110 = sitofp i64 0 to double
  store double %t110, double* %l12
  %t111 = sitofp i64 1 to double
  store double %t111, double* %l13
  %t112 = load i8*, i8** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t116 = load i8*, i8** %l4
  %t117 = load i1, i1* %l5
  %t118 = load i1, i1* %l6
  %t119 = load i1, i1* %l7
  %t120 = load i1, i1* %l8
  %t121 = load double, double* %l9
  %t122 = load double, double* %l10
  %t123 = load double, double* %l11
  %t124 = load double, double* %l12
  %t125 = load double, double* %l13
  br label %loop.header6
loop.header6:
  %t530 = phi i1 [ %t117, %merge5 ], [ %t520, %loop.latch8 ]
  %t531 = phi double [ %t121, %merge5 ], [ %t521, %loop.latch8 ]
  %t532 = phi { i8**, i64 }* [ %t113, %merge5 ], [ %t522, %loop.latch8 ]
  %t533 = phi i1 [ %t118, %merge5 ], [ %t523, %loop.latch8 ]
  %t534 = phi double [ %t122, %merge5 ], [ %t524, %loop.latch8 ]
  %t535 = phi i1 [ %t119, %merge5 ], [ %t525, %loop.latch8 ]
  %t536 = phi double [ %t123, %merge5 ], [ %t526, %loop.latch8 ]
  %t537 = phi i1 [ %t120, %merge5 ], [ %t527, %loop.latch8 ]
  %t538 = phi double [ %t124, %merge5 ], [ %t528, %loop.latch8 ]
  %t539 = phi double [ %t125, %merge5 ], [ %t529, %loop.latch8 ]
  store i1 %t530, i1* %l5
  store double %t531, double* %l9
  store { i8**, i64 }* %t532, { i8**, i64 }** %l1
  store i1 %t533, i1* %l6
  store double %t534, double* %l10
  store i1 %t535, i1* %l7
  store double %t536, double* %l11
  store i1 %t537, i1* %l8
  store double %t538, double* %l12
  store double %t539, double* %l13
  br label %loop.body7
loop.body7:
  %t126 = load double, double* %l13
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t128 = load { i8**, i64 }, { i8**, i64 }* %t127
  %t129 = extractvalue { i8**, i64 } %t128, 1
  %t130 = sitofp i64 %t129 to double
  %t131 = fcmp oge double %t126, %t130
  %t132 = load i8*, i8** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t136 = load i8*, i8** %l4
  %t137 = load i1, i1* %l5
  %t138 = load i1, i1* %l6
  %t139 = load i1, i1* %l7
  %t140 = load i1, i1* %l8
  %t141 = load double, double* %l9
  %t142 = load double, double* %l10
  %t143 = load double, double* %l11
  %t144 = load double, double* %l12
  %t145 = load double, double* %l13
  br i1 %t131, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t147 = load double, double* %l13
  %t148 = call double @llvm.round.f64(double %t147)
  %t149 = fptosi double %t148 to i64
  %t150 = load { i8**, i64 }, { i8**, i64 }* %t146
  %t151 = extractvalue { i8**, i64 } %t150, 0
  %t152 = extractvalue { i8**, i64 } %t150, 1
  %t153 = icmp uge i64 %t149, %t152
  ; bounds check: %t153 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t149, i64 %t152)
  %t154 = getelementptr i8*, i8** %t151, i64 %t149
  %t155 = load i8*, i8** %t154
  store i8* %t155, i8** %l14
  %t156 = load i8*, i8** %l14
  %t157 = call i8* @malloc(i64 5)
  %t158 = bitcast i8* %t157 to [5 x i8]*
  store [5 x i8] c"tag=\00", [5 x i8]* %t158
  %t159 = call i1 @starts_with(i8* %t156, i8* %t157)
  %t160 = load i8*, i8** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t164 = load i8*, i8** %l4
  %t165 = load i1, i1* %l5
  %t166 = load i1, i1* %l6
  %t167 = load i1, i1* %l7
  %t168 = load i1, i1* %l8
  %t169 = load double, double* %l9
  %t170 = load double, double* %l10
  %t171 = load double, double* %l11
  %t172 = load double, double* %l12
  %t173 = load double, double* %l13
  %t174 = load i8*, i8** %l14
  br i1 %t159, label %then12, label %else13
then12:
  %t175 = load i8*, i8** %l14
  %t176 = load i8*, i8** %l14
  %t177 = call i64 @sailfin_runtime_string_length(i8* %t176)
  %t178 = call i8* @sailfin_runtime_substring(i8* %t175, i64 4, i64 %t177)
  store i8* %t178, i8** %l15
  %t179 = load i8*, i8** %l15
  %t180 = call %NumberParseResult @parse_decimal_number(i8* %t179)
  store %NumberParseResult %t180, %NumberParseResult* %l16
  %t181 = load %NumberParseResult, %NumberParseResult* %l16
  %t182 = extractvalue %NumberParseResult %t181, 0
  %t183 = load i8*, i8** %l0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t187 = load i8*, i8** %l4
  %t188 = load i1, i1* %l5
  %t189 = load i1, i1* %l6
  %t190 = load i1, i1* %l7
  %t191 = load i1, i1* %l8
  %t192 = load double, double* %l9
  %t193 = load double, double* %l10
  %t194 = load double, double* %l11
  %t195 = load double, double* %l12
  %t196 = load double, double* %l13
  %t197 = load i8*, i8** %l14
  %t198 = load i8*, i8** %l15
  %t199 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t182, label %then15, label %else16
then15:
  store i1 1, i1* %l5
  %t200 = load %NumberParseResult, %NumberParseResult* %l16
  %t201 = extractvalue %NumberParseResult %t200, 1
  store double %t201, double* %l9
  %t202 = load i1, i1* %l5
  %t203 = load double, double* %l9
  br label %merge17
else16:
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = call i8* @malloc(i64 6)
  %t206 = bitcast i8* %t205 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t206
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %enum_name)
  %t208 = call i8* @malloc(i64 18)
  %t209 = bitcast i8* %t208 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t209
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t207, i8* %t208)
  %t211 = load i8*, i8** %l4
  %t212 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %t211)
  %t213 = call i8* @malloc(i64 20)
  %t214 = bitcast i8* %t213 to [20 x i8]*
  store [20 x i8] c"` has invalid tag `\00", [20 x i8]* %t214
  %t215 = call i8* @sailfin_runtime_string_concat(i8* %t212, i8* %t213)
  %t216 = load i8*, i8** %l15
  %t217 = call i8* @sailfin_runtime_string_concat(i8* %t215, i8* %t216)
  %t218 = add i64 0, 2
  %t219 = call i8* @malloc(i64 %t218)
  store i8 96, i8* %t219
  %t220 = getelementptr i8, i8* %t219, i64 1
  store i8 0, i8* %t220
  call void @sailfin_runtime_mark_persistent(i8* %t219)
  %t221 = call i8* @sailfin_runtime_string_concat(i8* %t217, i8* %t219)
  %t222 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t204, i8* %t221)
  store { i8**, i64 }* %t222, { i8**, i64 }** %l1
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t224 = phi i1 [ %t202, %then15 ], [ %t188, %else16 ]
  %t225 = phi double [ %t203, %then15 ], [ %t192, %else16 ]
  %t226 = phi { i8**, i64 }* [ %t184, %then15 ], [ %t223, %else16 ]
  store i1 %t224, i1* %l5
  store double %t225, double* %l9
  store { i8**, i64 }* %t226, { i8**, i64 }** %l1
  %t227 = load i1, i1* %l5
  %t228 = load double, double* %l9
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t230 = load i8*, i8** %l14
  %t231 = call i8* @malloc(i64 8)
  %t232 = bitcast i8* %t231 to [8 x i8]*
  store [8 x i8] c"offset=\00", [8 x i8]* %t232
  %t233 = call i1 @starts_with(i8* %t230, i8* %t231)
  %t234 = load i8*, i8** %l0
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t236 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t238 = load i8*, i8** %l4
  %t239 = load i1, i1* %l5
  %t240 = load i1, i1* %l6
  %t241 = load i1, i1* %l7
  %t242 = load i1, i1* %l8
  %t243 = load double, double* %l9
  %t244 = load double, double* %l10
  %t245 = load double, double* %l11
  %t246 = load double, double* %l12
  %t247 = load double, double* %l13
  %t248 = load i8*, i8** %l14
  br i1 %t233, label %then18, label %else19
then18:
  %t249 = load i8*, i8** %l14
  %t250 = load i8*, i8** %l14
  %t251 = call i64 @sailfin_runtime_string_length(i8* %t250)
  %t252 = call i8* @sailfin_runtime_substring(i8* %t249, i64 7, i64 %t251)
  store i8* %t252, i8** %l17
  %t253 = load i8*, i8** %l17
  %t254 = call %NumberParseResult @parse_decimal_number(i8* %t253)
  store %NumberParseResult %t254, %NumberParseResult* %l18
  %t255 = load %NumberParseResult, %NumberParseResult* %l18
  %t256 = extractvalue %NumberParseResult %t255, 0
  %t257 = load i8*, i8** %l0
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t259 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t261 = load i8*, i8** %l4
  %t262 = load i1, i1* %l5
  %t263 = load i1, i1* %l6
  %t264 = load i1, i1* %l7
  %t265 = load i1, i1* %l8
  %t266 = load double, double* %l9
  %t267 = load double, double* %l10
  %t268 = load double, double* %l11
  %t269 = load double, double* %l12
  %t270 = load double, double* %l13
  %t271 = load i8*, i8** %l14
  %t272 = load i8*, i8** %l17
  %t273 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t256, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t274 = load %NumberParseResult, %NumberParseResult* %l18
  %t275 = extractvalue %NumberParseResult %t274, 1
  store double %t275, double* %l10
  %t276 = load i1, i1* %l6
  %t277 = load double, double* %l10
  br label %merge23
else22:
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t279 = call i8* @malloc(i64 6)
  %t280 = bitcast i8* %t279 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t280
  %t281 = call i8* @sailfin_runtime_string_concat(i8* %t279, i8* %enum_name)
  %t282 = call i8* @malloc(i64 18)
  %t283 = bitcast i8* %t282 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t283
  %t284 = call i8* @sailfin_runtime_string_concat(i8* %t281, i8* %t282)
  %t285 = load i8*, i8** %l4
  %t286 = call i8* @sailfin_runtime_string_concat(i8* %t284, i8* %t285)
  %t287 = call i8* @malloc(i64 23)
  %t288 = bitcast i8* %t287 to [23 x i8]*
  store [23 x i8] c"` has invalid offset `\00", [23 x i8]* %t288
  %t289 = call i8* @sailfin_runtime_string_concat(i8* %t286, i8* %t287)
  %t290 = load i8*, i8** %l17
  %t291 = call i8* @sailfin_runtime_string_concat(i8* %t289, i8* %t290)
  %t292 = add i64 0, 2
  %t293 = call i8* @malloc(i64 %t292)
  store i8 96, i8* %t293
  %t294 = getelementptr i8, i8* %t293, i64 1
  store i8 0, i8* %t294
  call void @sailfin_runtime_mark_persistent(i8* %t293)
  %t295 = call i8* @sailfin_runtime_string_concat(i8* %t291, i8* %t293)
  %t296 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t278, i8* %t295)
  store { i8**, i64 }* %t296, { i8**, i64 }** %l1
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t298 = phi i1 [ %t276, %then21 ], [ %t263, %else22 ]
  %t299 = phi double [ %t277, %then21 ], [ %t267, %else22 ]
  %t300 = phi { i8**, i64 }* [ %t258, %then21 ], [ %t297, %else22 ]
  store i1 %t298, i1* %l6
  store double %t299, double* %l10
  store { i8**, i64 }* %t300, { i8**, i64 }** %l1
  %t301 = load i1, i1* %l6
  %t302 = load double, double* %l10
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t304 = load i8*, i8** %l14
  %t305 = call i8* @malloc(i64 6)
  %t306 = bitcast i8* %t305 to [6 x i8]*
  store [6 x i8] c"size=\00", [6 x i8]* %t306
  %t307 = call i1 @starts_with(i8* %t304, i8* %t305)
  %t308 = load i8*, i8** %l0
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t312 = load i8*, i8** %l4
  %t313 = load i1, i1* %l5
  %t314 = load i1, i1* %l6
  %t315 = load i1, i1* %l7
  %t316 = load i1, i1* %l8
  %t317 = load double, double* %l9
  %t318 = load double, double* %l10
  %t319 = load double, double* %l11
  %t320 = load double, double* %l12
  %t321 = load double, double* %l13
  %t322 = load i8*, i8** %l14
  br i1 %t307, label %then24, label %else25
then24:
  %t323 = load i8*, i8** %l14
  %t324 = load i8*, i8** %l14
  %t325 = call i64 @sailfin_runtime_string_length(i8* %t324)
  %t326 = call i8* @sailfin_runtime_substring(i8* %t323, i64 5, i64 %t325)
  store i8* %t326, i8** %l19
  %t327 = load i8*, i8** %l19
  %t328 = call %NumberParseResult @parse_decimal_number(i8* %t327)
  store %NumberParseResult %t328, %NumberParseResult* %l20
  %t329 = load %NumberParseResult, %NumberParseResult* %l20
  %t330 = extractvalue %NumberParseResult %t329, 0
  %t331 = load i8*, i8** %l0
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t333 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t335 = load i8*, i8** %l4
  %t336 = load i1, i1* %l5
  %t337 = load i1, i1* %l6
  %t338 = load i1, i1* %l7
  %t339 = load i1, i1* %l8
  %t340 = load double, double* %l9
  %t341 = load double, double* %l10
  %t342 = load double, double* %l11
  %t343 = load double, double* %l12
  %t344 = load double, double* %l13
  %t345 = load i8*, i8** %l14
  %t346 = load i8*, i8** %l19
  %t347 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t330, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t348 = load %NumberParseResult, %NumberParseResult* %l20
  %t349 = extractvalue %NumberParseResult %t348, 1
  store double %t349, double* %l11
  %t350 = load i1, i1* %l7
  %t351 = load double, double* %l11
  br label %merge29
else28:
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t353 = call i8* @malloc(i64 6)
  %t354 = bitcast i8* %t353 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t354
  %t355 = call i8* @sailfin_runtime_string_concat(i8* %t353, i8* %enum_name)
  %t356 = call i8* @malloc(i64 18)
  %t357 = bitcast i8* %t356 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t357
  %t358 = call i8* @sailfin_runtime_string_concat(i8* %t355, i8* %t356)
  %t359 = load i8*, i8** %l4
  %t360 = call i8* @sailfin_runtime_string_concat(i8* %t358, i8* %t359)
  %t361 = call i8* @malloc(i64 21)
  %t362 = bitcast i8* %t361 to [21 x i8]*
  store [21 x i8] c"` has invalid size `\00", [21 x i8]* %t362
  %t363 = call i8* @sailfin_runtime_string_concat(i8* %t360, i8* %t361)
  %t364 = load i8*, i8** %l19
  %t365 = call i8* @sailfin_runtime_string_concat(i8* %t363, i8* %t364)
  %t366 = add i64 0, 2
  %t367 = call i8* @malloc(i64 %t366)
  store i8 96, i8* %t367
  %t368 = getelementptr i8, i8* %t367, i64 1
  store i8 0, i8* %t368
  call void @sailfin_runtime_mark_persistent(i8* %t367)
  %t369 = call i8* @sailfin_runtime_string_concat(i8* %t365, i8* %t367)
  %t370 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t352, i8* %t369)
  store { i8**, i64 }* %t370, { i8**, i64 }** %l1
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t372 = phi i1 [ %t350, %then27 ], [ %t338, %else28 ]
  %t373 = phi double [ %t351, %then27 ], [ %t342, %else28 ]
  %t374 = phi { i8**, i64 }* [ %t332, %then27 ], [ %t371, %else28 ]
  store i1 %t372, i1* %l7
  store double %t373, double* %l11
  store { i8**, i64 }* %t374, { i8**, i64 }** %l1
  %t375 = load i1, i1* %l7
  %t376 = load double, double* %l11
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t378 = load i8*, i8** %l14
  %t379 = call i8* @malloc(i64 7)
  %t380 = bitcast i8* %t379 to [7 x i8]*
  store [7 x i8] c"align=\00", [7 x i8]* %t380
  %t381 = call i1 @starts_with(i8* %t378, i8* %t379)
  %t382 = load i8*, i8** %l0
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t384 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t386 = load i8*, i8** %l4
  %t387 = load i1, i1* %l5
  %t388 = load i1, i1* %l6
  %t389 = load i1, i1* %l7
  %t390 = load i1, i1* %l8
  %t391 = load double, double* %l9
  %t392 = load double, double* %l10
  %t393 = load double, double* %l11
  %t394 = load double, double* %l12
  %t395 = load double, double* %l13
  %t396 = load i8*, i8** %l14
  br i1 %t381, label %then30, label %else31
then30:
  %t397 = load i8*, i8** %l14
  %t398 = load i8*, i8** %l14
  %t399 = call i64 @sailfin_runtime_string_length(i8* %t398)
  %t400 = call i8* @sailfin_runtime_substring(i8* %t397, i64 6, i64 %t399)
  store i8* %t400, i8** %l21
  %t401 = load i8*, i8** %l21
  %t402 = call %NumberParseResult @parse_decimal_number(i8* %t401)
  store %NumberParseResult %t402, %NumberParseResult* %l22
  %t403 = load %NumberParseResult, %NumberParseResult* %l22
  %t404 = extractvalue %NumberParseResult %t403, 0
  %t405 = load i8*, i8** %l0
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t407 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t409 = load i8*, i8** %l4
  %t410 = load i1, i1* %l5
  %t411 = load i1, i1* %l6
  %t412 = load i1, i1* %l7
  %t413 = load i1, i1* %l8
  %t414 = load double, double* %l9
  %t415 = load double, double* %l10
  %t416 = load double, double* %l11
  %t417 = load double, double* %l12
  %t418 = load double, double* %l13
  %t419 = load i8*, i8** %l14
  %t420 = load i8*, i8** %l21
  %t421 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t404, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t422 = load %NumberParseResult, %NumberParseResult* %l22
  %t423 = extractvalue %NumberParseResult %t422, 1
  store double %t423, double* %l12
  %t424 = load i1, i1* %l8
  %t425 = load double, double* %l12
  br label %merge35
else34:
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t427 = call i8* @malloc(i64 6)
  %t428 = bitcast i8* %t427 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t428
  %t429 = call i8* @sailfin_runtime_string_concat(i8* %t427, i8* %enum_name)
  %t430 = call i8* @malloc(i64 18)
  %t431 = bitcast i8* %t430 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t431
  %t432 = call i8* @sailfin_runtime_string_concat(i8* %t429, i8* %t430)
  %t433 = load i8*, i8** %l4
  %t434 = call i8* @sailfin_runtime_string_concat(i8* %t432, i8* %t433)
  %t435 = call i8* @malloc(i64 22)
  %t436 = bitcast i8* %t435 to [22 x i8]*
  store [22 x i8] c"` has invalid align `\00", [22 x i8]* %t436
  %t437 = call i8* @sailfin_runtime_string_concat(i8* %t434, i8* %t435)
  %t438 = load i8*, i8** %l21
  %t439 = call i8* @sailfin_runtime_string_concat(i8* %t437, i8* %t438)
  %t440 = add i64 0, 2
  %t441 = call i8* @malloc(i64 %t440)
  store i8 96, i8* %t441
  %t442 = getelementptr i8, i8* %t441, i64 1
  store i8 0, i8* %t442
  call void @sailfin_runtime_mark_persistent(i8* %t441)
  %t443 = call i8* @sailfin_runtime_string_concat(i8* %t439, i8* %t441)
  %t444 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t426, i8* %t443)
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t446 = phi i1 [ %t424, %then33 ], [ %t413, %else34 ]
  %t447 = phi double [ %t425, %then33 ], [ %t417, %else34 ]
  %t448 = phi { i8**, i64 }* [ %t406, %then33 ], [ %t445, %else34 ]
  store i1 %t446, i1* %l8
  store double %t447, double* %l12
  store { i8**, i64 }* %t448, { i8**, i64 }** %l1
  %t449 = load i1, i1* %l8
  %t450 = load double, double* %l12
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t453 = call i8* @malloc(i64 6)
  %t454 = bitcast i8* %t453 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t454
  %t455 = call i8* @sailfin_runtime_string_concat(i8* %t453, i8* %enum_name)
  %t456 = call i8* @malloc(i64 18)
  %t457 = bitcast i8* %t456 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t457
  %t458 = call i8* @sailfin_runtime_string_concat(i8* %t455, i8* %t456)
  %t459 = load i8*, i8** %l4
  %t460 = call i8* @sailfin_runtime_string_concat(i8* %t458, i8* %t459)
  %t461 = call i8* @malloc(i64 23)
  %t462 = bitcast i8* %t461 to [23 x i8]*
  store [23 x i8] c"` unrecognized token `\00", [23 x i8]* %t462
  %t463 = call i8* @sailfin_runtime_string_concat(i8* %t460, i8* %t461)
  %t464 = load i8*, i8** %l14
  %t465 = call i8* @sailfin_runtime_string_concat(i8* %t463, i8* %t464)
  %t466 = add i64 0, 2
  %t467 = call i8* @malloc(i64 %t466)
  store i8 96, i8* %t467
  %t468 = getelementptr i8, i8* %t467, i64 1
  store i8 0, i8* %t468
  call void @sailfin_runtime_mark_persistent(i8* %t467)
  %t469 = call i8* @sailfin_runtime_string_concat(i8* %t465, i8* %t467)
  %t470 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t452, i8* %t469)
  store { i8**, i64 }* %t470, { i8**, i64 }** %l1
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t472 = phi i1 [ %t449, %merge35 ], [ %t390, %else31 ]
  %t473 = phi double [ %t450, %merge35 ], [ %t394, %else31 ]
  %t474 = phi { i8**, i64 }* [ %t451, %merge35 ], [ %t471, %else31 ]
  store i1 %t472, i1* %l8
  store double %t473, double* %l12
  store { i8**, i64 }* %t474, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l8
  %t476 = load double, double* %l12
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t479 = phi i1 [ %t375, %merge29 ], [ %t315, %merge32 ]
  %t480 = phi double [ %t376, %merge29 ], [ %t319, %merge32 ]
  %t481 = phi { i8**, i64 }* [ %t377, %merge29 ], [ %t477, %merge32 ]
  %t482 = phi i1 [ %t316, %merge29 ], [ %t475, %merge32 ]
  %t483 = phi double [ %t320, %merge29 ], [ %t476, %merge32 ]
  store i1 %t479, i1* %l7
  store double %t480, double* %l11
  store { i8**, i64 }* %t481, { i8**, i64 }** %l1
  store i1 %t482, i1* %l8
  store double %t483, double* %l12
  %t484 = load i1, i1* %l7
  %t485 = load double, double* %l11
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t487 = load i1, i1* %l8
  %t488 = load double, double* %l12
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t491 = phi i1 [ %t301, %merge23 ], [ %t240, %merge26 ]
  %t492 = phi double [ %t302, %merge23 ], [ %t244, %merge26 ]
  %t493 = phi { i8**, i64 }* [ %t303, %merge23 ], [ %t486, %merge26 ]
  %t494 = phi i1 [ %t241, %merge23 ], [ %t484, %merge26 ]
  %t495 = phi double [ %t245, %merge23 ], [ %t485, %merge26 ]
  %t496 = phi i1 [ %t242, %merge23 ], [ %t487, %merge26 ]
  %t497 = phi double [ %t246, %merge23 ], [ %t488, %merge26 ]
  store i1 %t491, i1* %l6
  store double %t492, double* %l10
  store { i8**, i64 }* %t493, { i8**, i64 }** %l1
  store i1 %t494, i1* %l7
  store double %t495, double* %l11
  store i1 %t496, i1* %l8
  store double %t497, double* %l12
  %t498 = load i1, i1* %l6
  %t499 = load double, double* %l10
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t501 = load i1, i1* %l7
  %t502 = load double, double* %l11
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t504 = load i1, i1* %l8
  %t505 = load double, double* %l12
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t508 = phi i1 [ %t227, %merge17 ], [ %t165, %merge20 ]
  %t509 = phi double [ %t228, %merge17 ], [ %t169, %merge20 ]
  %t510 = phi { i8**, i64 }* [ %t229, %merge17 ], [ %t500, %merge20 ]
  %t511 = phi i1 [ %t166, %merge17 ], [ %t498, %merge20 ]
  %t512 = phi double [ %t170, %merge17 ], [ %t499, %merge20 ]
  %t513 = phi i1 [ %t167, %merge17 ], [ %t501, %merge20 ]
  %t514 = phi double [ %t171, %merge17 ], [ %t502, %merge20 ]
  %t515 = phi i1 [ %t168, %merge17 ], [ %t504, %merge20 ]
  %t516 = phi double [ %t172, %merge17 ], [ %t505, %merge20 ]
  store i1 %t508, i1* %l5
  store double %t509, double* %l9
  store { i8**, i64 }* %t510, { i8**, i64 }** %l1
  store i1 %t511, i1* %l6
  store double %t512, double* %l10
  store i1 %t513, i1* %l7
  store double %t514, double* %l11
  store i1 %t515, i1* %l8
  store double %t516, double* %l12
  %t517 = load double, double* %l13
  %t518 = sitofp i64 1 to double
  %t519 = fadd double %t517, %t518
  store double %t519, double* %l13
  br label %loop.latch8
loop.latch8:
  %t520 = load i1, i1* %l5
  %t521 = load double, double* %l9
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t523 = load i1, i1* %l6
  %t524 = load double, double* %l10
  %t525 = load i1, i1* %l7
  %t526 = load double, double* %l11
  %t527 = load i1, i1* %l8
  %t528 = load double, double* %l12
  %t529 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t540 = load i1, i1* %l5
  %t541 = load double, double* %l9
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t543 = load i1, i1* %l6
  %t544 = load double, double* %l10
  %t545 = load i1, i1* %l7
  %t546 = load double, double* %l11
  %t547 = load i1, i1* %l8
  %t548 = load double, double* %l12
  %t549 = load double, double* %l13
  %t550 = load i1, i1* %l5
  %t551 = xor i1 %t550, 1
  %t552 = load i8*, i8** %l0
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t554 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t556 = load i8*, i8** %l4
  %t557 = load i1, i1* %l5
  %t558 = load i1, i1* %l6
  %t559 = load i1, i1* %l7
  %t560 = load i1, i1* %l8
  %t561 = load double, double* %l9
  %t562 = load double, double* %l10
  %t563 = load double, double* %l11
  %t564 = load double, double* %l12
  %t565 = load double, double* %l13
  br i1 %t551, label %then36, label %merge37
then36:
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t567 = call i8* @malloc(i64 6)
  %t568 = bitcast i8* %t567 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t568
  %t569 = call i8* @sailfin_runtime_string_concat(i8* %t567, i8* %enum_name)
  %t570 = call i8* @malloc(i64 18)
  %t571 = bitcast i8* %t570 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t571
  %t572 = call i8* @sailfin_runtime_string_concat(i8* %t569, i8* %t570)
  %t573 = load i8*, i8** %l4
  %t574 = call i8* @sailfin_runtime_string_concat(i8* %t572, i8* %t573)
  %t575 = call i8* @malloc(i64 20)
  %t576 = bitcast i8* %t575 to [20 x i8]*
  store [20 x i8] c"` missing tag entry\00", [20 x i8]* %t576
  %t577 = call i8* @sailfin_runtime_string_concat(i8* %t574, i8* %t575)
  %t578 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t566, i8* %t577)
  store { i8**, i64 }* %t578, { i8**, i64 }** %l1
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t580 = phi { i8**, i64 }* [ %t579, %then36 ], [ %t553, %afterloop9 ]
  store { i8**, i64 }* %t580, { i8**, i64 }** %l1
  %t581 = load i1, i1* %l6
  %t582 = xor i1 %t581, 1
  %t583 = load i8*, i8** %l0
  %t584 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t585 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t587 = load i8*, i8** %l4
  %t588 = load i1, i1* %l5
  %t589 = load i1, i1* %l6
  %t590 = load i1, i1* %l7
  %t591 = load i1, i1* %l8
  %t592 = load double, double* %l9
  %t593 = load double, double* %l10
  %t594 = load double, double* %l11
  %t595 = load double, double* %l12
  %t596 = load double, double* %l13
  br i1 %t582, label %then38, label %merge39
then38:
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t598 = call i8* @malloc(i64 6)
  %t599 = bitcast i8* %t598 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t599
  %t600 = call i8* @sailfin_runtime_string_concat(i8* %t598, i8* %enum_name)
  %t601 = call i8* @malloc(i64 18)
  %t602 = bitcast i8* %t601 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t602
  %t603 = call i8* @sailfin_runtime_string_concat(i8* %t600, i8* %t601)
  %t604 = load i8*, i8** %l4
  %t605 = call i8* @sailfin_runtime_string_concat(i8* %t603, i8* %t604)
  %t606 = call i8* @malloc(i64 23)
  %t607 = bitcast i8* %t606 to [23 x i8]*
  store [23 x i8] c"` missing offset entry\00", [23 x i8]* %t607
  %t608 = call i8* @sailfin_runtime_string_concat(i8* %t605, i8* %t606)
  %t609 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t597, i8* %t608)
  store { i8**, i64 }* %t609, { i8**, i64 }** %l1
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t611 = phi { i8**, i64 }* [ %t610, %then38 ], [ %t584, %merge37 ]
  store { i8**, i64 }* %t611, { i8**, i64 }** %l1
  %t612 = load i1, i1* %l7
  %t613 = xor i1 %t612, 1
  %t614 = load i8*, i8** %l0
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t616 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t618 = load i8*, i8** %l4
  %t619 = load i1, i1* %l5
  %t620 = load i1, i1* %l6
  %t621 = load i1, i1* %l7
  %t622 = load i1, i1* %l8
  %t623 = load double, double* %l9
  %t624 = load double, double* %l10
  %t625 = load double, double* %l11
  %t626 = load double, double* %l12
  %t627 = load double, double* %l13
  br i1 %t613, label %then40, label %merge41
then40:
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t629 = call i8* @malloc(i64 6)
  %t630 = bitcast i8* %t629 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t630
  %t631 = call i8* @sailfin_runtime_string_concat(i8* %t629, i8* %enum_name)
  %t632 = call i8* @malloc(i64 18)
  %t633 = bitcast i8* %t632 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t633
  %t634 = call i8* @sailfin_runtime_string_concat(i8* %t631, i8* %t632)
  %t635 = load i8*, i8** %l4
  %t636 = call i8* @sailfin_runtime_string_concat(i8* %t634, i8* %t635)
  %t637 = call i8* @malloc(i64 21)
  %t638 = bitcast i8* %t637 to [21 x i8]*
  store [21 x i8] c"` missing size entry\00", [21 x i8]* %t638
  %t639 = call i8* @sailfin_runtime_string_concat(i8* %t636, i8* %t637)
  %t640 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t628, i8* %t639)
  store { i8**, i64 }* %t640, { i8**, i64 }** %l1
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t642 = phi { i8**, i64 }* [ %t641, %then40 ], [ %t615, %merge39 ]
  store { i8**, i64 }* %t642, { i8**, i64 }** %l1
  %t643 = load i1, i1* %l8
  %t644 = xor i1 %t643, 1
  %t645 = load i8*, i8** %l0
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t647 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t649 = load i8*, i8** %l4
  %t650 = load i1, i1* %l5
  %t651 = load i1, i1* %l6
  %t652 = load i1, i1* %l7
  %t653 = load i1, i1* %l8
  %t654 = load double, double* %l9
  %t655 = load double, double* %l10
  %t656 = load double, double* %l11
  %t657 = load double, double* %l12
  %t658 = load double, double* %l13
  br i1 %t644, label %then42, label %merge43
then42:
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t660 = call i8* @malloc(i64 6)
  %t661 = bitcast i8* %t660 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t661
  %t662 = call i8* @sailfin_runtime_string_concat(i8* %t660, i8* %enum_name)
  %t663 = call i8* @malloc(i64 18)
  %t664 = bitcast i8* %t663 to [18 x i8]*
  store [18 x i8] c" layout variant `\00", [18 x i8]* %t664
  %t665 = call i8* @sailfin_runtime_string_concat(i8* %t662, i8* %t663)
  %t666 = load i8*, i8** %l4
  %t667 = call i8* @sailfin_runtime_string_concat(i8* %t665, i8* %t666)
  %t668 = call i8* @malloc(i64 22)
  %t669 = bitcast i8* %t668 to [22 x i8]*
  store [22 x i8] c"` missing align entry\00", [22 x i8]* %t669
  %t670 = call i8* @sailfin_runtime_string_concat(i8* %t667, i8* %t668)
  %t671 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t659, i8* %t670)
  store { i8**, i64 }* %t671, { i8**, i64 }** %l1
  %t672 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t673 = phi { i8**, i64 }* [ %t672, %then42 ], [ %t646, %merge41 ]
  store { i8**, i64 }* %t673, { i8**, i64 }** %l1
  %t675 = load i1, i1* %l5
  br label %logical_and_entry_674

logical_and_entry_674:
  br i1 %t675, label %logical_and_right_674, label %logical_and_merge_674

logical_and_right_674:
  %t677 = load i1, i1* %l6
  br label %logical_and_entry_676

logical_and_entry_676:
  br i1 %t677, label %logical_and_right_676, label %logical_and_merge_676

logical_and_right_676:
  %t679 = load i1, i1* %l7
  br label %logical_and_entry_678

logical_and_entry_678:
  br i1 %t679, label %logical_and_right_678, label %logical_and_merge_678

logical_and_right_678:
  %t681 = load i1, i1* %l8
  br label %logical_and_entry_680

logical_and_entry_680:
  br i1 %t681, label %logical_and_right_680, label %logical_and_merge_680

logical_and_right_680:
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t683 = load { i8**, i64 }, { i8**, i64 }* %t682
  %t684 = extractvalue { i8**, i64 } %t683, 1
  %t685 = icmp eq i64 %t684, 0
  br label %logical_and_right_end_680

logical_and_right_end_680:
  br label %logical_and_merge_680

logical_and_merge_680:
  %t686 = phi i1 [ false, %logical_and_entry_680 ], [ %t685, %logical_and_right_end_680 ]
  br label %logical_and_right_end_678

logical_and_right_end_678:
  br label %logical_and_merge_678

logical_and_merge_678:
  %t687 = phi i1 [ false, %logical_and_entry_678 ], [ %t686, %logical_and_right_end_678 ]
  br label %logical_and_right_end_676

logical_and_right_end_676:
  br label %logical_and_merge_676

logical_and_merge_676:
  %t688 = phi i1 [ false, %logical_and_entry_676 ], [ %t687, %logical_and_right_end_676 ]
  br label %logical_and_right_end_674

logical_and_right_end_674:
  br label %logical_and_merge_674

logical_and_merge_674:
  %t689 = phi i1 [ false, %logical_and_entry_674 ], [ %t688, %logical_and_right_end_674 ]
  store i1 %t689, i1* %l23
  %t690 = load i8*, i8** %l4
  %t691 = insertvalue %NativeEnumVariantLayout undef, i8* %t690, 0
  %t692 = load double, double* %l9
  %t693 = insertvalue %NativeEnumVariantLayout %t691, double %t692, 1
  %t694 = load double, double* %l10
  %t695 = insertvalue %NativeEnumVariantLayout %t693, double %t694, 2
  %t696 = load double, double* %l11
  %t697 = insertvalue %NativeEnumVariantLayout %t695, double %t696, 3
  %t698 = load double, double* %l12
  %t699 = insertvalue %NativeEnumVariantLayout %t697, double %t698, 4
  %t700 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t701 = ptrtoint [0 x %NativeStructLayoutField]* %t700 to i64
  %t702 = icmp eq i64 %t701, 0
  %t703 = select i1 %t702, i64 1, i64 %t701
  %t704 = call i8* @malloc(i64 %t703)
  %t705 = bitcast i8* %t704 to %NativeStructLayoutField*
  %t706 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t707 = ptrtoint { %NativeStructLayoutField*, i64 }* %t706 to i64
  %t708 = call i8* @malloc(i64 %t707)
  %t709 = bitcast i8* %t708 to { %NativeStructLayoutField*, i64 }*
  %t710 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t709, i32 0, i32 0
  store %NativeStructLayoutField* %t705, %NativeStructLayoutField** %t710
  %t711 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t709, i32 0, i32 1
  store i64 0, i64* %t711
  %t712 = insertvalue %NativeEnumVariantLayout %t699, { %NativeStructLayoutField*, i64 }* %t709, 5
  store %NativeEnumVariantLayout %t712, %NativeEnumVariantLayout* %l24
  %t713 = load i1, i1* %l23
  %t714 = insertvalue %EnumLayoutVariantParse undef, i1 %t713, 0
  %t715 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t716 = insertvalue %EnumLayoutVariantParse %t714, %NativeEnumVariantLayout %t715, 1
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t718 = insertvalue %EnumLayoutVariantParse %t716, { i8**, i64 }* %t717, 2
  ret %EnumLayoutVariantParse %t718
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
  %t13 = call i8* @malloc(i64 1)
  %t14 = bitcast i8* %t13 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t14
  %t15 = insertvalue %NativeStructLayoutField undef, i8* %t13, 0
  %t16 = call i8* @malloc(i64 1)
  %t17 = bitcast i8* %t16 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t17
  %t18 = insertvalue %NativeStructLayoutField %t15, i8* %t16, 1
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeStructLayoutField %t18, double %t19, 2
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeStructLayoutField %t20, double %t21, 3
  %t23 = sitofp i64 0 to double
  %t24 = insertvalue %NativeStructLayoutField %t22, double %t23, 4
  store %NativeStructLayoutField %t24, %NativeStructLayoutField* %l2
  %t25 = load i8*, i8** %l0
  %t26 = call i64 @sailfin_runtime_string_length(i8* %t25)
  %t27 = icmp eq i64 %t26, 0
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t27, label %then0, label %merge1
then0:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = call i8* @malloc(i64 6)
  %t33 = bitcast i8* %t32 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t33
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %enum_name)
  %t35 = call i8* @malloc(i64 32)
  %t36 = bitcast i8* %t35 to [32 x i8]*
  store [32 x i8] c" layout payload missing content\00", [32 x i8]* %t36
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t35)
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t31, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l1
  %t39 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %t40 = call i8* @malloc(i64 1)
  %t41 = bitcast i8* %t40 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t41
  %t42 = insertvalue %EnumLayoutPayloadParse %t39, i8* %t40, 1
  %t43 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t44 = insertvalue %EnumLayoutPayloadParse %t42, %NativeStructLayoutField %t43, 2
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = insertvalue %EnumLayoutPayloadParse %t44, { i8**, i64 }* %t45, 3
  ret %EnumLayoutPayloadParse %t46
merge1:
  %t47 = load i8*, i8** %l0
  %t48 = call { i8**, i64 }* @split_whitespace(i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l3
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t51 = extractvalue { i8**, i64 } %t50, 1
  %t52 = icmp eq i64 %t51, 0
  %t53 = load i8*, i8** %l0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t55 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t52, label %then2, label %merge3
then2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = call i8* @malloc(i64 6)
  %t59 = bitcast i8* %t58 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t59
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %enum_name)
  %t61 = call i8* @malloc(i64 32)
  %t62 = bitcast i8* %t61 to [32 x i8]*
  store [32 x i8] c" layout payload missing entries\00", [32 x i8]* %t62
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t61)
  %t64 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  %t65 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %t66 = call i8* @malloc(i64 1)
  %t67 = bitcast i8* %t66 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t67
  %t68 = insertvalue %EnumLayoutPayloadParse %t65, i8* %t66, 1
  %t69 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t70 = insertvalue %EnumLayoutPayloadParse %t68, %NativeStructLayoutField %t69, 2
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = insertvalue %EnumLayoutPayloadParse %t70, { i8**, i64 }* %t71, 3
  ret %EnumLayoutPayloadParse %t72
merge3:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t74 = load { i8**, i64 }, { i8**, i64 }* %t73
  %t75 = extractvalue { i8**, i64 } %t74, 0
  %t76 = extractvalue { i8**, i64 } %t74, 1
  %t77 = icmp uge i64 0, %t76
  ; bounds check: %t77 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t76)
  %t78 = getelementptr i8*, i8** %t75, i64 0
  %t79 = load i8*, i8** %t78
  store i8* %t79, i8** %l4
  %t80 = load i8*, i8** %l4
  %t81 = add i64 0, 2
  %t82 = call i8* @malloc(i64 %t81)
  store i8 46, i8* %t82
  %t83 = getelementptr i8, i8* %t82, i64 1
  store i8 0, i8* %t83
  call void @sailfin_runtime_mark_persistent(i8* %t82)
  %t84 = call double @index_of(i8* %t80, i8* %t82)
  store double %t84, double* %l5
  %t86 = load double, double* %l5
  %t87 = sitofp i64 0 to double
  %t88 = fcmp ole double %t86, %t87
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t88, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t89 = load double, double* %l5
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  %t92 = load i8*, i8** %l4
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = sitofp i64 %t93 to double
  %t95 = fcmp oge double %t91, %t94
  br label %logical_or_right_end_85

logical_or_right_end_85:
  br label %logical_or_merge_85

logical_or_merge_85:
  %t96 = phi i1 [ true, %logical_or_entry_85 ], [ %t95, %logical_or_right_end_85 ]
  %t97 = load i8*, i8** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t101 = load i8*, i8** %l4
  %t102 = load double, double* %l5
  br i1 %t96, label %then4, label %merge5
then4:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = call i8* @malloc(i64 6)
  %t105 = bitcast i8* %t104 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t105
  %t106 = call i8* @sailfin_runtime_string_concat(i8* %t104, i8* %enum_name)
  %t107 = call i8* @malloc(i64 29)
  %t108 = bitcast i8* %t107 to [29 x i8]*
  store [29 x i8] c" layout payload identifier `\00", [29 x i8]* %t108
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %t106, i8* %t107)
  %t110 = load i8*, i8** %l4
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t110)
  %t112 = call i8* @malloc(i64 10)
  %t113 = bitcast i8* %t112 to [10 x i8]*
  store [10 x i8] c"` invalid\00", [10 x i8]* %t113
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %t112)
  %t115 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t103, i8* %t114)
  store { i8**, i64 }* %t115, { i8**, i64 }** %l1
  %t116 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %t117 = call i8* @malloc(i64 1)
  %t118 = bitcast i8* %t117 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t118
  %t119 = insertvalue %EnumLayoutPayloadParse %t116, i8* %t117, 1
  %t120 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t121 = insertvalue %EnumLayoutPayloadParse %t119, %NativeStructLayoutField %t120, 2
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t123 = insertvalue %EnumLayoutPayloadParse %t121, { i8**, i64 }* %t122, 3
  ret %EnumLayoutPayloadParse %t123
merge5:
  %t124 = load i8*, i8** %l4
  %t125 = load double, double* %l5
  %t126 = call double @llvm.round.f64(double %t125)
  %t127 = fptosi double %t126 to i64
  %t128 = call i8* @sailfin_runtime_substring(i8* %t124, i64 0, i64 %t127)
  store i8* %t128, i8** %l6
  %t129 = load i8*, i8** %l4
  %t130 = load double, double* %l5
  %t131 = sitofp i64 1 to double
  %t132 = fadd double %t130, %t131
  %t133 = load i8*, i8** %l4
  %t134 = call i64 @sailfin_runtime_string_length(i8* %t133)
  %t135 = call double @llvm.round.f64(double %t132)
  %t136 = fptosi double %t135 to i64
  %t137 = call i8* @sailfin_runtime_substring(i8* %t129, i64 %t136, i64 %t134)
  store i8* %t137, i8** %l7
  %t138 = call i8* @malloc(i64 1)
  %t139 = bitcast i8* %t138 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t139
  store i8* %t138, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t140 = sitofp i64 0 to double
  store double %t140, double* %l12
  %t141 = sitofp i64 0 to double
  store double %t141, double* %l13
  %t142 = sitofp i64 0 to double
  store double %t142, double* %l14
  %t143 = sitofp i64 1 to double
  store double %t143, double* %l15
  %t144 = load i8*, i8** %l0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t146 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t148 = load i8*, i8** %l4
  %t149 = load double, double* %l5
  %t150 = load i8*, i8** %l6
  %t151 = load i8*, i8** %l7
  %t152 = load i8*, i8** %l8
  %t153 = load i1, i1* %l9
  %t154 = load i1, i1* %l10
  %t155 = load i1, i1* %l11
  %t156 = load double, double* %l12
  %t157 = load double, double* %l13
  %t158 = load double, double* %l14
  %t159 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t528 = phi i8* [ %t152, %merge5 ], [ %t519, %loop.latch8 ]
  %t529 = phi i1 [ %t153, %merge5 ], [ %t520, %loop.latch8 ]
  %t530 = phi double [ %t156, %merge5 ], [ %t521, %loop.latch8 ]
  %t531 = phi { i8**, i64 }* [ %t145, %merge5 ], [ %t522, %loop.latch8 ]
  %t532 = phi i1 [ %t154, %merge5 ], [ %t523, %loop.latch8 ]
  %t533 = phi double [ %t157, %merge5 ], [ %t524, %loop.latch8 ]
  %t534 = phi i1 [ %t155, %merge5 ], [ %t525, %loop.latch8 ]
  %t535 = phi double [ %t158, %merge5 ], [ %t526, %loop.latch8 ]
  %t536 = phi double [ %t159, %merge5 ], [ %t527, %loop.latch8 ]
  store i8* %t528, i8** %l8
  store i1 %t529, i1* %l9
  store double %t530, double* %l12
  store { i8**, i64 }* %t531, { i8**, i64 }** %l1
  store i1 %t532, i1* %l10
  store double %t533, double* %l13
  store i1 %t534, i1* %l11
  store double %t535, double* %l14
  store double %t536, double* %l15
  br label %loop.body7
loop.body7:
  %t160 = load double, double* %l15
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t162 = load { i8**, i64 }, { i8**, i64 }* %t161
  %t163 = extractvalue { i8**, i64 } %t162, 1
  %t164 = sitofp i64 %t163 to double
  %t165 = fcmp oge double %t160, %t164
  %t166 = load i8*, i8** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t170 = load i8*, i8** %l4
  %t171 = load double, double* %l5
  %t172 = load i8*, i8** %l6
  %t173 = load i8*, i8** %l7
  %t174 = load i8*, i8** %l8
  %t175 = load i1, i1* %l9
  %t176 = load i1, i1* %l10
  %t177 = load i1, i1* %l11
  %t178 = load double, double* %l12
  %t179 = load double, double* %l13
  %t180 = load double, double* %l14
  %t181 = load double, double* %l15
  br i1 %t165, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t183 = load double, double* %l15
  %t184 = call double @llvm.round.f64(double %t183)
  %t185 = fptosi double %t184 to i64
  %t186 = load { i8**, i64 }, { i8**, i64 }* %t182
  %t187 = extractvalue { i8**, i64 } %t186, 0
  %t188 = extractvalue { i8**, i64 } %t186, 1
  %t189 = icmp uge i64 %t185, %t188
  ; bounds check: %t189 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t185, i64 %t188)
  %t190 = getelementptr i8*, i8** %t187, i64 %t185
  %t191 = load i8*, i8** %t190
  store i8* %t191, i8** %l16
  %t192 = load i8*, i8** %l16
  %t193 = call i8* @malloc(i64 6)
  %t194 = bitcast i8* %t193 to [6 x i8]*
  store [6 x i8] c"type=\00", [6 x i8]* %t194
  %t195 = call i1 @starts_with(i8* %t192, i8* %t193)
  %t196 = load i8*, i8** %l0
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t198 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t200 = load i8*, i8** %l4
  %t201 = load double, double* %l5
  %t202 = load i8*, i8** %l6
  %t203 = load i8*, i8** %l7
  %t204 = load i8*, i8** %l8
  %t205 = load i1, i1* %l9
  %t206 = load i1, i1* %l10
  %t207 = load i1, i1* %l11
  %t208 = load double, double* %l12
  %t209 = load double, double* %l13
  %t210 = load double, double* %l14
  %t211 = load double, double* %l15
  %t212 = load i8*, i8** %l16
  br i1 %t195, label %then12, label %else13
then12:
  %t213 = load i8*, i8** %l16
  %t214 = load i8*, i8** %l16
  %t215 = call i64 @sailfin_runtime_string_length(i8* %t214)
  %t216 = call i8* @sailfin_runtime_substring(i8* %t213, i64 5, i64 %t215)
  store i8* %t216, i8** %l8
  %t217 = load i8*, i8** %l8
  br label %merge14
else13:
  %t218 = load i8*, i8** %l16
  %t219 = call i8* @malloc(i64 8)
  %t220 = bitcast i8* %t219 to [8 x i8]*
  store [8 x i8] c"offset=\00", [8 x i8]* %t220
  %t221 = call i1 @starts_with(i8* %t218, i8* %t219)
  %t222 = load i8*, i8** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t226 = load i8*, i8** %l4
  %t227 = load double, double* %l5
  %t228 = load i8*, i8** %l6
  %t229 = load i8*, i8** %l7
  %t230 = load i8*, i8** %l8
  %t231 = load i1, i1* %l9
  %t232 = load i1, i1* %l10
  %t233 = load i1, i1* %l11
  %t234 = load double, double* %l12
  %t235 = load double, double* %l13
  %t236 = load double, double* %l14
  %t237 = load double, double* %l15
  %t238 = load i8*, i8** %l16
  br i1 %t221, label %then15, label %else16
then15:
  %t239 = load i8*, i8** %l16
  %t240 = load i8*, i8** %l16
  %t241 = call i64 @sailfin_runtime_string_length(i8* %t240)
  %t242 = call i8* @sailfin_runtime_substring(i8* %t239, i64 7, i64 %t241)
  store i8* %t242, i8** %l17
  %t243 = load i8*, i8** %l17
  %t244 = call %NumberParseResult @parse_decimal_number(i8* %t243)
  store %NumberParseResult %t244, %NumberParseResult* %l18
  %t245 = load %NumberParseResult, %NumberParseResult* %l18
  %t246 = extractvalue %NumberParseResult %t245, 0
  %t247 = load i8*, i8** %l0
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t249 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t251 = load i8*, i8** %l4
  %t252 = load double, double* %l5
  %t253 = load i8*, i8** %l6
  %t254 = load i8*, i8** %l7
  %t255 = load i8*, i8** %l8
  %t256 = load i1, i1* %l9
  %t257 = load i1, i1* %l10
  %t258 = load i1, i1* %l11
  %t259 = load double, double* %l12
  %t260 = load double, double* %l13
  %t261 = load double, double* %l14
  %t262 = load double, double* %l15
  %t263 = load i8*, i8** %l16
  %t264 = load i8*, i8** %l17
  %t265 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t246, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t266 = load %NumberParseResult, %NumberParseResult* %l18
  %t267 = extractvalue %NumberParseResult %t266, 1
  store double %t267, double* %l12
  %t268 = load i1, i1* %l9
  %t269 = load double, double* %l12
  br label %merge20
else19:
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = call i8* @malloc(i64 6)
  %t272 = bitcast i8* %t271 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t272
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %enum_name)
  %t274 = call i8* @malloc(i64 18)
  %t275 = bitcast i8* %t274 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t275
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t273, i8* %t274)
  %t277 = load i8*, i8** %l4
  %t278 = call i8* @sailfin_runtime_string_concat(i8* %t276, i8* %t277)
  %t279 = call i8* @malloc(i64 23)
  %t280 = bitcast i8* %t279 to [23 x i8]*
  store [23 x i8] c"` has invalid offset `\00", [23 x i8]* %t280
  %t281 = call i8* @sailfin_runtime_string_concat(i8* %t278, i8* %t279)
  %t282 = load i8*, i8** %l17
  %t283 = call i8* @sailfin_runtime_string_concat(i8* %t281, i8* %t282)
  %t284 = add i64 0, 2
  %t285 = call i8* @malloc(i64 %t284)
  store i8 96, i8* %t285
  %t286 = getelementptr i8, i8* %t285, i64 1
  store i8 0, i8* %t286
  call void @sailfin_runtime_mark_persistent(i8* %t285)
  %t287 = call i8* @sailfin_runtime_string_concat(i8* %t283, i8* %t285)
  %t288 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t270, i8* %t287)
  store { i8**, i64 }* %t288, { i8**, i64 }** %l1
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t290 = phi i1 [ %t268, %then18 ], [ %t256, %else19 ]
  %t291 = phi double [ %t269, %then18 ], [ %t259, %else19 ]
  %t292 = phi { i8**, i64 }* [ %t248, %then18 ], [ %t289, %else19 ]
  store i1 %t290, i1* %l9
  store double %t291, double* %l12
  store { i8**, i64 }* %t292, { i8**, i64 }** %l1
  %t293 = load i1, i1* %l9
  %t294 = load double, double* %l12
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t296 = load i8*, i8** %l16
  %t297 = call i8* @malloc(i64 6)
  %t298 = bitcast i8* %t297 to [6 x i8]*
  store [6 x i8] c"size=\00", [6 x i8]* %t298
  %t299 = call i1 @starts_with(i8* %t296, i8* %t297)
  %t300 = load i8*, i8** %l0
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t302 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t304 = load i8*, i8** %l4
  %t305 = load double, double* %l5
  %t306 = load i8*, i8** %l6
  %t307 = load i8*, i8** %l7
  %t308 = load i8*, i8** %l8
  %t309 = load i1, i1* %l9
  %t310 = load i1, i1* %l10
  %t311 = load i1, i1* %l11
  %t312 = load double, double* %l12
  %t313 = load double, double* %l13
  %t314 = load double, double* %l14
  %t315 = load double, double* %l15
  %t316 = load i8*, i8** %l16
  br i1 %t299, label %then21, label %else22
then21:
  %t317 = load i8*, i8** %l16
  %t318 = load i8*, i8** %l16
  %t319 = call i64 @sailfin_runtime_string_length(i8* %t318)
  %t320 = call i8* @sailfin_runtime_substring(i8* %t317, i64 5, i64 %t319)
  store i8* %t320, i8** %l19
  %t321 = load i8*, i8** %l19
  %t322 = call %NumberParseResult @parse_decimal_number(i8* %t321)
  store %NumberParseResult %t322, %NumberParseResult* %l20
  %t323 = load %NumberParseResult, %NumberParseResult* %l20
  %t324 = extractvalue %NumberParseResult %t323, 0
  %t325 = load i8*, i8** %l0
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t327 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t329 = load i8*, i8** %l4
  %t330 = load double, double* %l5
  %t331 = load i8*, i8** %l6
  %t332 = load i8*, i8** %l7
  %t333 = load i8*, i8** %l8
  %t334 = load i1, i1* %l9
  %t335 = load i1, i1* %l10
  %t336 = load i1, i1* %l11
  %t337 = load double, double* %l12
  %t338 = load double, double* %l13
  %t339 = load double, double* %l14
  %t340 = load double, double* %l15
  %t341 = load i8*, i8** %l16
  %t342 = load i8*, i8** %l19
  %t343 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t324, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t344 = load %NumberParseResult, %NumberParseResult* %l20
  %t345 = extractvalue %NumberParseResult %t344, 1
  store double %t345, double* %l13
  %t346 = load i1, i1* %l10
  %t347 = load double, double* %l13
  br label %merge26
else25:
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t349 = call i8* @malloc(i64 6)
  %t350 = bitcast i8* %t349 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t350
  %t351 = call i8* @sailfin_runtime_string_concat(i8* %t349, i8* %enum_name)
  %t352 = call i8* @malloc(i64 18)
  %t353 = bitcast i8* %t352 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t353
  %t354 = call i8* @sailfin_runtime_string_concat(i8* %t351, i8* %t352)
  %t355 = load i8*, i8** %l4
  %t356 = call i8* @sailfin_runtime_string_concat(i8* %t354, i8* %t355)
  %t357 = call i8* @malloc(i64 21)
  %t358 = bitcast i8* %t357 to [21 x i8]*
  store [21 x i8] c"` has invalid size `\00", [21 x i8]* %t358
  %t359 = call i8* @sailfin_runtime_string_concat(i8* %t356, i8* %t357)
  %t360 = load i8*, i8** %l19
  %t361 = call i8* @sailfin_runtime_string_concat(i8* %t359, i8* %t360)
  %t362 = add i64 0, 2
  %t363 = call i8* @malloc(i64 %t362)
  store i8 96, i8* %t363
  %t364 = getelementptr i8, i8* %t363, i64 1
  store i8 0, i8* %t364
  call void @sailfin_runtime_mark_persistent(i8* %t363)
  %t365 = call i8* @sailfin_runtime_string_concat(i8* %t361, i8* %t363)
  %t366 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t348, i8* %t365)
  store { i8**, i64 }* %t366, { i8**, i64 }** %l1
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t368 = phi i1 [ %t346, %then24 ], [ %t335, %else25 ]
  %t369 = phi double [ %t347, %then24 ], [ %t338, %else25 ]
  %t370 = phi { i8**, i64 }* [ %t326, %then24 ], [ %t367, %else25 ]
  store i1 %t368, i1* %l10
  store double %t369, double* %l13
  store { i8**, i64 }* %t370, { i8**, i64 }** %l1
  %t371 = load i1, i1* %l10
  %t372 = load double, double* %l13
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t374 = load i8*, i8** %l16
  %t375 = call i8* @malloc(i64 7)
  %t376 = bitcast i8* %t375 to [7 x i8]*
  store [7 x i8] c"align=\00", [7 x i8]* %t376
  %t377 = call i1 @starts_with(i8* %t374, i8* %t375)
  %t378 = load i8*, i8** %l0
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t382 = load i8*, i8** %l4
  %t383 = load double, double* %l5
  %t384 = load i8*, i8** %l6
  %t385 = load i8*, i8** %l7
  %t386 = load i8*, i8** %l8
  %t387 = load i1, i1* %l9
  %t388 = load i1, i1* %l10
  %t389 = load i1, i1* %l11
  %t390 = load double, double* %l12
  %t391 = load double, double* %l13
  %t392 = load double, double* %l14
  %t393 = load double, double* %l15
  %t394 = load i8*, i8** %l16
  br i1 %t377, label %then27, label %else28
then27:
  %t395 = load i8*, i8** %l16
  %t396 = load i8*, i8** %l16
  %t397 = call i64 @sailfin_runtime_string_length(i8* %t396)
  %t398 = call i8* @sailfin_runtime_substring(i8* %t395, i64 6, i64 %t397)
  store i8* %t398, i8** %l21
  %t399 = load i8*, i8** %l21
  %t400 = call %NumberParseResult @parse_decimal_number(i8* %t399)
  store %NumberParseResult %t400, %NumberParseResult* %l22
  %t401 = load %NumberParseResult, %NumberParseResult* %l22
  %t402 = extractvalue %NumberParseResult %t401, 0
  %t403 = load i8*, i8** %l0
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t405 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t407 = load i8*, i8** %l4
  %t408 = load double, double* %l5
  %t409 = load i8*, i8** %l6
  %t410 = load i8*, i8** %l7
  %t411 = load i8*, i8** %l8
  %t412 = load i1, i1* %l9
  %t413 = load i1, i1* %l10
  %t414 = load i1, i1* %l11
  %t415 = load double, double* %l12
  %t416 = load double, double* %l13
  %t417 = load double, double* %l14
  %t418 = load double, double* %l15
  %t419 = load i8*, i8** %l16
  %t420 = load i8*, i8** %l21
  %t421 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t402, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t422 = load %NumberParseResult, %NumberParseResult* %l22
  %t423 = extractvalue %NumberParseResult %t422, 1
  store double %t423, double* %l14
  %t424 = load i1, i1* %l11
  %t425 = load double, double* %l14
  br label %merge32
else31:
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t427 = call i8* @malloc(i64 6)
  %t428 = bitcast i8* %t427 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t428
  %t429 = call i8* @sailfin_runtime_string_concat(i8* %t427, i8* %enum_name)
  %t430 = call i8* @malloc(i64 18)
  %t431 = bitcast i8* %t430 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t431
  %t432 = call i8* @sailfin_runtime_string_concat(i8* %t429, i8* %t430)
  %t433 = load i8*, i8** %l4
  %t434 = call i8* @sailfin_runtime_string_concat(i8* %t432, i8* %t433)
  %t435 = call i8* @malloc(i64 22)
  %t436 = bitcast i8* %t435 to [22 x i8]*
  store [22 x i8] c"` has invalid align `\00", [22 x i8]* %t436
  %t437 = call i8* @sailfin_runtime_string_concat(i8* %t434, i8* %t435)
  %t438 = load i8*, i8** %l21
  %t439 = call i8* @sailfin_runtime_string_concat(i8* %t437, i8* %t438)
  %t440 = add i64 0, 2
  %t441 = call i8* @malloc(i64 %t440)
  store i8 96, i8* %t441
  %t442 = getelementptr i8, i8* %t441, i64 1
  store i8 0, i8* %t442
  call void @sailfin_runtime_mark_persistent(i8* %t441)
  %t443 = call i8* @sailfin_runtime_string_concat(i8* %t439, i8* %t441)
  %t444 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t426, i8* %t443)
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t446 = phi i1 [ %t424, %then30 ], [ %t414, %else31 ]
  %t447 = phi double [ %t425, %then30 ], [ %t417, %else31 ]
  %t448 = phi { i8**, i64 }* [ %t404, %then30 ], [ %t445, %else31 ]
  store i1 %t446, i1* %l11
  store double %t447, double* %l14
  store { i8**, i64 }* %t448, { i8**, i64 }** %l1
  %t449 = load i1, i1* %l11
  %t450 = load double, double* %l14
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t453 = call i8* @malloc(i64 6)
  %t454 = bitcast i8* %t453 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t454
  %t455 = call i8* @sailfin_runtime_string_concat(i8* %t453, i8* %enum_name)
  %t456 = call i8* @malloc(i64 18)
  %t457 = bitcast i8* %t456 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t457
  %t458 = call i8* @sailfin_runtime_string_concat(i8* %t455, i8* %t456)
  %t459 = load i8*, i8** %l4
  %t460 = call i8* @sailfin_runtime_string_concat(i8* %t458, i8* %t459)
  %t461 = call i8* @malloc(i64 23)
  %t462 = bitcast i8* %t461 to [23 x i8]*
  store [23 x i8] c"` unrecognized token `\00", [23 x i8]* %t462
  %t463 = call i8* @sailfin_runtime_string_concat(i8* %t460, i8* %t461)
  %t464 = load i8*, i8** %l16
  %t465 = call i8* @sailfin_runtime_string_concat(i8* %t463, i8* %t464)
  %t466 = add i64 0, 2
  %t467 = call i8* @malloc(i64 %t466)
  store i8 96, i8* %t467
  %t468 = getelementptr i8, i8* %t467, i64 1
  store i8 0, i8* %t468
  call void @sailfin_runtime_mark_persistent(i8* %t467)
  %t469 = call i8* @sailfin_runtime_string_concat(i8* %t465, i8* %t467)
  %t470 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t452, i8* %t469)
  store { i8**, i64 }* %t470, { i8**, i64 }** %l1
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t472 = phi i1 [ %t449, %merge32 ], [ %t389, %else28 ]
  %t473 = phi double [ %t450, %merge32 ], [ %t392, %else28 ]
  %t474 = phi { i8**, i64 }* [ %t451, %merge32 ], [ %t471, %else28 ]
  store i1 %t472, i1* %l11
  store double %t473, double* %l14
  store { i8**, i64 }* %t474, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l11
  %t476 = load double, double* %l14
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t479 = phi i1 [ %t371, %merge26 ], [ %t310, %merge29 ]
  %t480 = phi double [ %t372, %merge26 ], [ %t313, %merge29 ]
  %t481 = phi { i8**, i64 }* [ %t373, %merge26 ], [ %t477, %merge29 ]
  %t482 = phi i1 [ %t311, %merge26 ], [ %t475, %merge29 ]
  %t483 = phi double [ %t314, %merge26 ], [ %t476, %merge29 ]
  store i1 %t479, i1* %l10
  store double %t480, double* %l13
  store { i8**, i64 }* %t481, { i8**, i64 }** %l1
  store i1 %t482, i1* %l11
  store double %t483, double* %l14
  %t484 = load i1, i1* %l10
  %t485 = load double, double* %l13
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t487 = load i1, i1* %l11
  %t488 = load double, double* %l14
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t491 = phi i1 [ %t293, %merge20 ], [ %t231, %merge23 ]
  %t492 = phi double [ %t294, %merge20 ], [ %t234, %merge23 ]
  %t493 = phi { i8**, i64 }* [ %t295, %merge20 ], [ %t486, %merge23 ]
  %t494 = phi i1 [ %t232, %merge20 ], [ %t484, %merge23 ]
  %t495 = phi double [ %t235, %merge20 ], [ %t485, %merge23 ]
  %t496 = phi i1 [ %t233, %merge20 ], [ %t487, %merge23 ]
  %t497 = phi double [ %t236, %merge20 ], [ %t488, %merge23 ]
  store i1 %t491, i1* %l9
  store double %t492, double* %l12
  store { i8**, i64 }* %t493, { i8**, i64 }** %l1
  store i1 %t494, i1* %l10
  store double %t495, double* %l13
  store i1 %t496, i1* %l11
  store double %t497, double* %l14
  %t498 = load i1, i1* %l9
  %t499 = load double, double* %l12
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t501 = load i1, i1* %l10
  %t502 = load double, double* %l13
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t504 = load i1, i1* %l11
  %t505 = load double, double* %l14
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t508 = phi i8* [ %t217, %then12 ], [ %t204, %merge17 ]
  %t509 = phi i1 [ %t205, %then12 ], [ %t498, %merge17 ]
  %t510 = phi double [ %t208, %then12 ], [ %t499, %merge17 ]
  %t511 = phi { i8**, i64 }* [ %t197, %then12 ], [ %t500, %merge17 ]
  %t512 = phi i1 [ %t206, %then12 ], [ %t501, %merge17 ]
  %t513 = phi double [ %t209, %then12 ], [ %t502, %merge17 ]
  %t514 = phi i1 [ %t207, %then12 ], [ %t504, %merge17 ]
  %t515 = phi double [ %t210, %then12 ], [ %t505, %merge17 ]
  store i8* %t508, i8** %l8
  store i1 %t509, i1* %l9
  store double %t510, double* %l12
  store { i8**, i64 }* %t511, { i8**, i64 }** %l1
  store i1 %t512, i1* %l10
  store double %t513, double* %l13
  store i1 %t514, i1* %l11
  store double %t515, double* %l14
  %t516 = load double, double* %l15
  %t517 = sitofp i64 1 to double
  %t518 = fadd double %t516, %t517
  store double %t518, double* %l15
  br label %loop.latch8
loop.latch8:
  %t519 = load i8*, i8** %l8
  %t520 = load i1, i1* %l9
  %t521 = load double, double* %l12
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t523 = load i1, i1* %l10
  %t524 = load double, double* %l13
  %t525 = load i1, i1* %l11
  %t526 = load double, double* %l14
  %t527 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t537 = load i8*, i8** %l8
  %t538 = load i1, i1* %l9
  %t539 = load double, double* %l12
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t541 = load i1, i1* %l10
  %t542 = load double, double* %l13
  %t543 = load i1, i1* %l11
  %t544 = load double, double* %l14
  %t545 = load double, double* %l15
  %t546 = load i8*, i8** %l8
  %t547 = call i64 @sailfin_runtime_string_length(i8* %t546)
  %t548 = icmp eq i64 %t547, 0
  %t549 = load i8*, i8** %l0
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t551 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t553 = load i8*, i8** %l4
  %t554 = load double, double* %l5
  %t555 = load i8*, i8** %l6
  %t556 = load i8*, i8** %l7
  %t557 = load i8*, i8** %l8
  %t558 = load i1, i1* %l9
  %t559 = load i1, i1* %l10
  %t560 = load i1, i1* %l11
  %t561 = load double, double* %l12
  %t562 = load double, double* %l13
  %t563 = load double, double* %l14
  %t564 = load double, double* %l15
  br i1 %t548, label %then33, label %merge34
then33:
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t566 = call i8* @malloc(i64 6)
  %t567 = bitcast i8* %t566 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t567
  %t568 = call i8* @sailfin_runtime_string_concat(i8* %t566, i8* %enum_name)
  %t569 = call i8* @malloc(i64 18)
  %t570 = bitcast i8* %t569 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t570
  %t571 = call i8* @sailfin_runtime_string_concat(i8* %t568, i8* %t569)
  %t572 = load i8*, i8** %l4
  %t573 = call i8* @sailfin_runtime_string_concat(i8* %t571, i8* %t572)
  %t574 = call i8* @malloc(i64 21)
  %t575 = bitcast i8* %t574 to [21 x i8]*
  store [21 x i8] c"` missing type entry\00", [21 x i8]* %t575
  %t576 = call i8* @sailfin_runtime_string_concat(i8* %t573, i8* %t574)
  %t577 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t565, i8* %t576)
  store { i8**, i64 }* %t577, { i8**, i64 }** %l1
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t579 = phi { i8**, i64 }* [ %t578, %then33 ], [ %t550, %afterloop9 ]
  store { i8**, i64 }* %t579, { i8**, i64 }** %l1
  %t580 = load i1, i1* %l9
  %t581 = xor i1 %t580, 1
  %t582 = load i8*, i8** %l0
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t584 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t586 = load i8*, i8** %l4
  %t587 = load double, double* %l5
  %t588 = load i8*, i8** %l6
  %t589 = load i8*, i8** %l7
  %t590 = load i8*, i8** %l8
  %t591 = load i1, i1* %l9
  %t592 = load i1, i1* %l10
  %t593 = load i1, i1* %l11
  %t594 = load double, double* %l12
  %t595 = load double, double* %l13
  %t596 = load double, double* %l14
  %t597 = load double, double* %l15
  br i1 %t581, label %then35, label %merge36
then35:
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t599 = call i8* @malloc(i64 6)
  %t600 = bitcast i8* %t599 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t600
  %t601 = call i8* @sailfin_runtime_string_concat(i8* %t599, i8* %enum_name)
  %t602 = call i8* @malloc(i64 18)
  %t603 = bitcast i8* %t602 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t603
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t601, i8* %t602)
  %t605 = load i8*, i8** %l4
  %t606 = call i8* @sailfin_runtime_string_concat(i8* %t604, i8* %t605)
  %t607 = call i8* @malloc(i64 23)
  %t608 = bitcast i8* %t607 to [23 x i8]*
  store [23 x i8] c"` missing offset entry\00", [23 x i8]* %t608
  %t609 = call i8* @sailfin_runtime_string_concat(i8* %t606, i8* %t607)
  %t610 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t598, i8* %t609)
  store { i8**, i64 }* %t610, { i8**, i64 }** %l1
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t612 = phi { i8**, i64 }* [ %t611, %then35 ], [ %t583, %merge34 ]
  store { i8**, i64 }* %t612, { i8**, i64 }** %l1
  %t613 = load i1, i1* %l10
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
  br i1 %t614, label %then37, label %merge38
then37:
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t632 = call i8* @malloc(i64 6)
  %t633 = bitcast i8* %t632 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t633
  %t634 = call i8* @sailfin_runtime_string_concat(i8* %t632, i8* %enum_name)
  %t635 = call i8* @malloc(i64 18)
  %t636 = bitcast i8* %t635 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t636
  %t637 = call i8* @sailfin_runtime_string_concat(i8* %t634, i8* %t635)
  %t638 = load i8*, i8** %l4
  %t639 = call i8* @sailfin_runtime_string_concat(i8* %t637, i8* %t638)
  %t640 = call i8* @malloc(i64 21)
  %t641 = bitcast i8* %t640 to [21 x i8]*
  store [21 x i8] c"` missing size entry\00", [21 x i8]* %t641
  %t642 = call i8* @sailfin_runtime_string_concat(i8* %t639, i8* %t640)
  %t643 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t631, i8* %t642)
  store { i8**, i64 }* %t643, { i8**, i64 }** %l1
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t645 = phi { i8**, i64 }* [ %t644, %then37 ], [ %t616, %merge36 ]
  store { i8**, i64 }* %t645, { i8**, i64 }** %l1
  %t646 = load i1, i1* %l11
  %t647 = xor i1 %t646, 1
  %t648 = load i8*, i8** %l0
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t650 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t652 = load i8*, i8** %l4
  %t653 = load double, double* %l5
  %t654 = load i8*, i8** %l6
  %t655 = load i8*, i8** %l7
  %t656 = load i8*, i8** %l8
  %t657 = load i1, i1* %l9
  %t658 = load i1, i1* %l10
  %t659 = load i1, i1* %l11
  %t660 = load double, double* %l12
  %t661 = load double, double* %l13
  %t662 = load double, double* %l14
  %t663 = load double, double* %l15
  br i1 %t647, label %then39, label %merge40
then39:
  %t664 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t665 = call i8* @malloc(i64 6)
  %t666 = bitcast i8* %t665 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t666
  %t667 = call i8* @sailfin_runtime_string_concat(i8* %t665, i8* %enum_name)
  %t668 = call i8* @malloc(i64 18)
  %t669 = bitcast i8* %t668 to [18 x i8]*
  store [18 x i8] c" layout payload `\00", [18 x i8]* %t669
  %t670 = call i8* @sailfin_runtime_string_concat(i8* %t667, i8* %t668)
  %t671 = load i8*, i8** %l4
  %t672 = call i8* @sailfin_runtime_string_concat(i8* %t670, i8* %t671)
  %t673 = call i8* @malloc(i64 22)
  %t674 = bitcast i8* %t673 to [22 x i8]*
  store [22 x i8] c"` missing align entry\00", [22 x i8]* %t674
  %t675 = call i8* @sailfin_runtime_string_concat(i8* %t672, i8* %t673)
  %t676 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t664, i8* %t675)
  store { i8**, i64 }* %t676, { i8**, i64 }** %l1
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t678 = phi { i8**, i64 }* [ %t677, %then39 ], [ %t649, %merge38 ]
  store { i8**, i64 }* %t678, { i8**, i64 }** %l1
  %t680 = load i8*, i8** %l8
  %t681 = call i64 @sailfin_runtime_string_length(i8* %t680)
  %t682 = icmp sgt i64 %t681, 0
  br label %logical_and_entry_679

logical_and_entry_679:
  br i1 %t682, label %logical_and_right_679, label %logical_and_merge_679

logical_and_right_679:
  %t684 = load i1, i1* %l9
  br label %logical_and_entry_683

logical_and_entry_683:
  br i1 %t684, label %logical_and_right_683, label %logical_and_merge_683

logical_and_right_683:
  %t686 = load i1, i1* %l10
  br label %logical_and_entry_685

logical_and_entry_685:
  br i1 %t686, label %logical_and_right_685, label %logical_and_merge_685

logical_and_right_685:
  %t688 = load i1, i1* %l11
  br label %logical_and_entry_687

logical_and_entry_687:
  br i1 %t688, label %logical_and_right_687, label %logical_and_merge_687

logical_and_right_687:
  %t689 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t690 = load { i8**, i64 }, { i8**, i64 }* %t689
  %t691 = extractvalue { i8**, i64 } %t690, 1
  %t692 = icmp eq i64 %t691, 0
  br label %logical_and_right_end_687

logical_and_right_end_687:
  br label %logical_and_merge_687

logical_and_merge_687:
  %t693 = phi i1 [ false, %logical_and_entry_687 ], [ %t692, %logical_and_right_end_687 ]
  br label %logical_and_right_end_685

logical_and_right_end_685:
  br label %logical_and_merge_685

logical_and_merge_685:
  %t694 = phi i1 [ false, %logical_and_entry_685 ], [ %t693, %logical_and_right_end_685 ]
  br label %logical_and_right_end_683

logical_and_right_end_683:
  br label %logical_and_merge_683

logical_and_merge_683:
  %t695 = phi i1 [ false, %logical_and_entry_683 ], [ %t694, %logical_and_right_end_683 ]
  br label %logical_and_right_end_679

logical_and_right_end_679:
  br label %logical_and_merge_679

logical_and_merge_679:
  %t696 = phi i1 [ false, %logical_and_entry_679 ], [ %t695, %logical_and_right_end_679 ]
  store i1 %t696, i1* %l23
  %t697 = load i8*, i8** %l7
  %t698 = insertvalue %NativeStructLayoutField undef, i8* %t697, 0
  %t699 = load i8*, i8** %l8
  %t700 = insertvalue %NativeStructLayoutField %t698, i8* %t699, 1
  %t701 = load double, double* %l12
  %t702 = insertvalue %NativeStructLayoutField %t700, double %t701, 2
  %t703 = load double, double* %l13
  %t704 = insertvalue %NativeStructLayoutField %t702, double %t703, 3
  %t705 = load double, double* %l14
  %t706 = insertvalue %NativeStructLayoutField %t704, double %t705, 4
  store %NativeStructLayoutField %t706, %NativeStructLayoutField* %l24
  %t707 = load i1, i1* %l23
  %t708 = insertvalue %EnumLayoutPayloadParse undef, i1 %t707, 0
  %t709 = load i8*, i8** %l6
  %t710 = insertvalue %EnumLayoutPayloadParse %t708, i8* %t709, 1
  %t711 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t712 = insertvalue %EnumLayoutPayloadParse %t710, %NativeStructLayoutField %t711, 2
  %t713 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t714 = insertvalue %EnumLayoutPayloadParse %t712, { i8**, i64 }* %t713, 3
  ret %EnumLayoutPayloadParse %t714
}

define %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca %BindingComponents
  %t0 = call i8* @malloc(i64 6)
  %t1 = bitcast i8* %t0 to [6 x i8]*
  store [6 x i8] c".let \00", [6 x i8]* %t1
  %t2 = call i8* @strip_prefix(i8* %line, i8* %t0)
  %t3 = call i8* @trim_text(i8* %t2)
  store i8* %t3, i8** %l0
  store i1 0, i1* %l1
  %t4 = load i8*, i8** %l0
  store i8* %t4, i8** %l2
  %t5 = load i8*, i8** %l2
  %t6 = call i8* @malloc(i64 5)
  %t7 = bitcast i8* %t6 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t7
  %t8 = call i1 @starts_with(i8* %t5, i8* %t6)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  %t11 = load i8*, i8** %l2
  br i1 %t8, label %then0, label %merge1
then0:
  store i1 1, i1* %l1
  %t12 = load i8*, i8** %l2
  %t13 = call i8* @malloc(i64 5)
  %t14 = bitcast i8* %t13 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t14
  %t15 = call i8* @strip_prefix(i8* %t12, i8* %t13)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i1, i1* %l1
  %t18 = load i8*, i8** %l2
  br label %merge1
merge1:
  %t19 = phi i1 [ %t17, %then0 ], [ %t10, %block.entry ]
  %t20 = phi i8* [ %t18, %then0 ], [ %t11, %block.entry ]
  store i1 %t19, i1* %l1
  store i8* %t20, i8** %l2
  %t21 = load i8*, i8** %l2
  %t22 = call %BindingComponents @parse_binding_components(i8* %t21)
  store %BindingComponents %t22, %BindingComponents* %l3
  %t23 = alloca %NativeInstruction
  %t24 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 0
  store i32 2, i32* %t24
  %t25 = load %BindingComponents, %BindingComponents* %l3
  %t26 = extractvalue %BindingComponents %t25, 0
  %t27 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 1
  %t28 = bitcast [48 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to i8**
  store i8* %t26, i8** %t29
  %t30 = load i1, i1* %l1
  %t31 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 1
  %t32 = bitcast [48 x i8]* %t31 to i8*
  %t33 = getelementptr inbounds i8, i8* %t32, i64 8
  %t34 = bitcast i8* %t33 to i1*
  store i1 %t30, i1* %t34
  %t35 = load %BindingComponents, %BindingComponents* %l3
  %t36 = extractvalue %BindingComponents %t35, 1
  %t37 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 1
  %t38 = bitcast [48 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 16
  %t40 = bitcast i8* %t39 to i8**
  store i8* %t36, i8** %t40
  %t41 = load %BindingComponents, %BindingComponents* %l3
  %t42 = extractvalue %BindingComponents %t41, 2
  %t43 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 1
  %t44 = bitcast [48 x i8]* %t43 to i8*
  %t45 = getelementptr inbounds i8, i8* %t44, i64 24
  %t46 = bitcast i8* %t45 to i8**
  store i8* %t42, i8** %t46
  %t47 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 1
  %t48 = bitcast [48 x i8]* %t47 to i8*
  %t49 = getelementptr inbounds i8, i8* %t48, i64 32
  %t50 = bitcast i8* %t49 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t50
  %t51 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t23, i32 0, i32 1
  %t52 = bitcast [48 x i8]* %t51 to i8*
  %t53 = getelementptr inbounds i8, i8* %t52, i64 40
  %t54 = bitcast i8* %t53 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t54
  %t55 = load %NativeInstruction, %NativeInstruction* %t23
  ret %NativeInstruction %t55
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
  %t40 = phi i8* [ %t3, %block.entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t4, %block.entry ], [ %t39, %loop.latch2 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %text)
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
  %t14 = getelementptr i8, i8* %text, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l2
  %t17 = load i8, i8* %l2
  %t18 = icmp eq i8 %t17, 32
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t18, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8, i8* %l2
  %t21 = icmp eq i8 %t20, 58
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t21, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t22 = load i8, i8* %l2
  %t23 = icmp eq i8 %t22, 61
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t24 = phi i1 [ true, %logical_or_entry_19 ], [ %t23, %logical_or_right_end_19 ]
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t25 = phi i1 [ true, %logical_or_entry_16 ], [ %t24, %logical_or_right_end_16 ]
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8, i8* %l2
  br i1 %t25, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t29 = load i8*, i8** %l0
  %t30 = load i8, i8* %l2
  %t31 = add i64 0, 2
  %t32 = call i8* @malloc(i64 %t31)
  store i8 %t30, i8* %t32
  %t33 = getelementptr i8, i8* %t32, i64 1
  store i8 0, i8* %t33
  call void @sailfin_runtime_mark_persistent(i8* %t32)
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t29, i8* %t32)
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
  %t46 = call i8* @malloc(i64 1)
  %t47 = bitcast i8* %t46 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t47
  store i8* %t46, i8** %l3
  store i8* null, i8** %l4
  %t48 = load double, double* %l1
  %t49 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t50 = call double @llvm.round.f64(double %t48)
  %t51 = fptosi double %t50 to i64
  %t52 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t51, i64 %t49)
  %t53 = call i8* @trim_text(i8* %t52)
  store i8* %t53, i8** %l5
  %t54 = load i8*, i8** %l5
  %t55 = call i64 @sailfin_runtime_string_length(i8* %t54)
  %t56 = icmp sgt i64 %t55, 0
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load i8*, i8** %l3
  %t60 = load i8*, i8** %l4
  %t61 = load i8*, i8** %l5
  br i1 %t56, label %then8, label %merge9
then8:
  %t62 = load i8*, i8** %l5
  %t63 = call i8* @malloc(i64 3)
  %t64 = bitcast i8* %t63 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t64
  %t65 = call i1 @starts_with(i8* %t62, i8* %t63)
  %t66 = load i8*, i8** %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l3
  %t69 = load i8*, i8** %l4
  %t70 = load i8*, i8** %l5
  br i1 %t65, label %then10, label %else11
then10:
  %t71 = load i8*, i8** %l5
  %t72 = call i8* @malloc(i64 3)
  %t73 = bitcast i8* %t72 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t73
  %t74 = call i8* @strip_prefix(i8* %t71, i8* %t72)
  %t75 = call i8* @trim_text(i8* %t74)
  store i8* %t75, i8** %l5
  %t76 = load i8*, i8** %l5
  %t77 = add i64 0, 2
  %t78 = call i8* @malloc(i64 %t77)
  store i8 61, i8* %t78
  %t79 = getelementptr i8, i8* %t78, i64 1
  store i8 0, i8* %t79
  call void @sailfin_runtime_mark_persistent(i8* %t78)
  %t80 = call double @index_of(i8* %t76, i8* %t78)
  store double %t80, double* %l6
  %t81 = load double, double* %l6
  %t82 = sitofp i64 0 to double
  %t83 = fcmp oge double %t81, %t82
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load i8*, i8** %l3
  %t87 = load i8*, i8** %l4
  %t88 = load i8*, i8** %l5
  %t89 = load double, double* %l6
  br i1 %t83, label %then13, label %else14
then13:
  %t90 = load i8*, i8** %l5
  %t91 = load double, double* %l6
  %t92 = call double @llvm.round.f64(double %t91)
  %t93 = fptosi double %t92 to i64
  %t94 = call i8* @sailfin_runtime_substring(i8* %t90, i64 0, i64 %t93)
  %t95 = call i8* @trim_text(i8* %t94)
  store i8* %t95, i8** %l3
  %t96 = load i8*, i8** %l5
  %t97 = load double, double* %l6
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  %t100 = load i8*, i8** %l5
  %t101 = call i64 @sailfin_runtime_string_length(i8* %t100)
  %t102 = call double @llvm.round.f64(double %t99)
  %t103 = fptosi double %t102 to i64
  %t104 = call i8* @sailfin_runtime_substring(i8* %t96, i64 %t103, i64 %t101)
  %t105 = call i8* @trim_text(i8* %t104)
  store i8* %t105, i8** %l7
  %t106 = load i8*, i8** %l7
  %t107 = call i64 @sailfin_runtime_string_length(i8* %t106)
  %t108 = icmp sgt i64 %t107, 0
  %t109 = load i8*, i8** %l0
  %t110 = load double, double* %l1
  %t111 = load i8*, i8** %l3
  %t112 = load i8*, i8** %l4
  %t113 = load i8*, i8** %l5
  %t114 = load double, double* %l6
  %t115 = load i8*, i8** %l7
  br i1 %t108, label %then16, label %merge17
then16:
  %t116 = load i8*, i8** %l7
  store i8* %t116, i8** %l4
  %t117 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t118 = phi i8* [ %t117, %then16 ], [ %t112, %then13 ]
  store i8* %t118, i8** %l4
  %t119 = load i8*, i8** %l3
  %t120 = load i8*, i8** %l4
  br label %merge15
else14:
  %t121 = load i8*, i8** %l5
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l3
  %t123 = load i8*, i8** %l3
  br label %merge15
merge15:
  %t124 = phi i8* [ %t119, %merge17 ], [ %t123, %else14 ]
  %t125 = phi i8* [ %t120, %merge17 ], [ %t87, %else14 ]
  store i8* %t124, i8** %l3
  store i8* %t125, i8** %l4
  %t126 = load i8*, i8** %l5
  %t127 = load i8*, i8** %l3
  %t128 = load i8*, i8** %l4
  %t129 = load i8*, i8** %l3
  br label %merge12
else11:
  %t130 = load i8*, i8** %l5
  %t131 = add i64 0, 2
  %t132 = call i8* @malloc(i64 %t131)
  store i8 58, i8* %t132
  %t133 = getelementptr i8, i8* %t132, i64 1
  store i8 0, i8* %t133
  call void @sailfin_runtime_mark_persistent(i8* %t132)
  %t134 = call i1 @starts_with(i8* %t130, i8* %t132)
  %t135 = load i8*, i8** %l0
  %t136 = load double, double* %l1
  %t137 = load i8*, i8** %l3
  %t138 = load i8*, i8** %l4
  %t139 = load i8*, i8** %l5
  br i1 %t134, label %then18, label %else19
then18:
  %t140 = load i8*, i8** %l5
  %t141 = add i64 0, 2
  %t142 = call i8* @malloc(i64 %t141)
  store i8 58, i8* %t142
  %t143 = getelementptr i8, i8* %t142, i64 1
  store i8 0, i8* %t143
  call void @sailfin_runtime_mark_persistent(i8* %t142)
  %t144 = call i8* @strip_prefix(i8* %t140, i8* %t142)
  %t145 = call i8* @trim_text(i8* %t144)
  store i8* %t145, i8** %l5
  %t146 = load i8*, i8** %l5
  %t147 = add i64 0, 2
  %t148 = call i8* @malloc(i64 %t147)
  store i8 61, i8* %t148
  %t149 = getelementptr i8, i8* %t148, i64 1
  store i8 0, i8* %t149
  call void @sailfin_runtime_mark_persistent(i8* %t148)
  %t150 = call double @index_of(i8* %t146, i8* %t148)
  store double %t150, double* %l8
  %t151 = load double, double* %l8
  %t152 = sitofp i64 0 to double
  %t153 = fcmp oge double %t151, %t152
  %t154 = load i8*, i8** %l0
  %t155 = load double, double* %l1
  %t156 = load i8*, i8** %l3
  %t157 = load i8*, i8** %l4
  %t158 = load i8*, i8** %l5
  %t159 = load double, double* %l8
  br i1 %t153, label %then21, label %else22
then21:
  %t160 = load i8*, i8** %l5
  %t161 = load double, double* %l8
  %t162 = call double @llvm.round.f64(double %t161)
  %t163 = fptosi double %t162 to i64
  %t164 = call i8* @sailfin_runtime_substring(i8* %t160, i64 0, i64 %t163)
  %t165 = call i8* @trim_text(i8* %t164)
  store i8* %t165, i8** %l3
  %t166 = load i8*, i8** %l5
  %t167 = load double, double* %l8
  %t168 = sitofp i64 1 to double
  %t169 = fadd double %t167, %t168
  %t170 = load i8*, i8** %l5
  %t171 = call i64 @sailfin_runtime_string_length(i8* %t170)
  %t172 = call double @llvm.round.f64(double %t169)
  %t173 = fptosi double %t172 to i64
  %t174 = call i8* @sailfin_runtime_substring(i8* %t166, i64 %t173, i64 %t171)
  %t175 = call i8* @trim_text(i8* %t174)
  store i8* %t175, i8** %l9
  %t176 = load i8*, i8** %l9
  %t177 = call i64 @sailfin_runtime_string_length(i8* %t176)
  %t178 = icmp sgt i64 %t177, 0
  %t179 = load i8*, i8** %l0
  %t180 = load double, double* %l1
  %t181 = load i8*, i8** %l3
  %t182 = load i8*, i8** %l4
  %t183 = load i8*, i8** %l5
  %t184 = load double, double* %l8
  %t185 = load i8*, i8** %l9
  br i1 %t178, label %then24, label %merge25
then24:
  %t186 = load i8*, i8** %l9
  store i8* %t186, i8** %l4
  %t187 = load i8*, i8** %l4
  br label %merge25
merge25:
  %t188 = phi i8* [ %t187, %then24 ], [ %t182, %then21 ]
  store i8* %t188, i8** %l4
  %t189 = load i8*, i8** %l3
  %t190 = load i8*, i8** %l4
  br label %merge23
else22:
  %t191 = load i8*, i8** %l5
  %t192 = call i8* @trim_text(i8* %t191)
  store i8* %t192, i8** %l3
  %t193 = load i8*, i8** %l3
  br label %merge23
merge23:
  %t194 = phi i8* [ %t189, %merge25 ], [ %t193, %else22 ]
  %t195 = phi i8* [ %t190, %merge25 ], [ %t157, %else22 ]
  store i8* %t194, i8** %l3
  store i8* %t195, i8** %l4
  %t196 = load i8*, i8** %l5
  %t197 = load i8*, i8** %l3
  %t198 = load i8*, i8** %l4
  %t199 = load i8*, i8** %l3
  br label %merge20
else19:
  %t200 = load i8*, i8** %l5
  %t201 = add i64 0, 2
  %t202 = call i8* @malloc(i64 %t201)
  store i8 61, i8* %t202
  %t203 = getelementptr i8, i8* %t202, i64 1
  store i8 0, i8* %t203
  call void @sailfin_runtime_mark_persistent(i8* %t202)
  %t204 = call i1 @starts_with(i8* %t200, i8* %t202)
  %t205 = load i8*, i8** %l0
  %t206 = load double, double* %l1
  %t207 = load i8*, i8** %l3
  %t208 = load i8*, i8** %l4
  %t209 = load i8*, i8** %l5
  br i1 %t204, label %then26, label %else27
then26:
  %t210 = load i8*, i8** %l5
  %t211 = add i64 0, 2
  %t212 = call i8* @malloc(i64 %t211)
  store i8 61, i8* %t212
  %t213 = getelementptr i8, i8* %t212, i64 1
  store i8 0, i8* %t213
  call void @sailfin_runtime_mark_persistent(i8* %t212)
  %t214 = call i8* @strip_prefix(i8* %t210, i8* %t212)
  %t215 = call i8* @trim_text(i8* %t214)
  store i8* %t215, i8** %l10
  %t216 = load i8*, i8** %l10
  %t217 = call i64 @sailfin_runtime_string_length(i8* %t216)
  %t218 = icmp sgt i64 %t217, 0
  %t219 = load i8*, i8** %l0
  %t220 = load double, double* %l1
  %t221 = load i8*, i8** %l3
  %t222 = load i8*, i8** %l4
  %t223 = load i8*, i8** %l5
  %t224 = load i8*, i8** %l10
  br i1 %t218, label %then29, label %merge30
then29:
  %t225 = load i8*, i8** %l10
  store i8* %t225, i8** %l4
  %t226 = load i8*, i8** %l4
  br label %merge30
merge30:
  %t227 = phi i8* [ %t226, %then29 ], [ %t222, %then26 ]
  store i8* %t227, i8** %l4
  %t228 = load i8*, i8** %l4
  br label %merge28
else27:
  %t229 = load i8*, i8** %l5
  store i8* %t229, i8** %l4
  %t230 = load i8*, i8** %l4
  br label %merge28
merge28:
  %t231 = phi i8* [ %t228, %merge30 ], [ %t230, %else27 ]
  store i8* %t231, i8** %l4
  %t232 = load i8*, i8** %l4
  %t233 = load i8*, i8** %l4
  br label %merge20
merge20:
  %t234 = phi i8* [ %t196, %merge23 ], [ %t139, %merge28 ]
  %t235 = phi i8* [ %t197, %merge23 ], [ %t137, %merge28 ]
  %t236 = phi i8* [ %t198, %merge23 ], [ %t232, %merge28 ]
  store i8* %t234, i8** %l5
  store i8* %t235, i8** %l3
  store i8* %t236, i8** %l4
  %t237 = load i8*, i8** %l5
  %t238 = load i8*, i8** %l3
  %t239 = load i8*, i8** %l4
  %t240 = load i8*, i8** %l3
  %t241 = load i8*, i8** %l4
  %t242 = load i8*, i8** %l4
  br label %merge12
merge12:
  %t243 = phi i8* [ %t126, %merge15 ], [ %t237, %merge20 ]
  %t244 = phi i8* [ %t127, %merge15 ], [ %t238, %merge20 ]
  %t245 = phi i8* [ %t128, %merge15 ], [ %t239, %merge20 ]
  store i8* %t243, i8** %l5
  store i8* %t244, i8** %l3
  store i8* %t245, i8** %l4
  %t246 = load i8*, i8** %l5
  %t247 = load i8*, i8** %l3
  %t248 = load i8*, i8** %l4
  %t249 = load i8*, i8** %l3
  %t250 = load i8*, i8** %l5
  %t251 = load i8*, i8** %l3
  %t252 = load i8*, i8** %l4
  %t253 = load i8*, i8** %l3
  %t254 = load i8*, i8** %l4
  %t255 = load i8*, i8** %l4
  br label %merge9
merge9:
  %t256 = phi i8* [ %t246, %merge12 ], [ %t61, %afterloop3 ]
  %t257 = phi i8* [ %t247, %merge12 ], [ %t59, %afterloop3 ]
  %t258 = phi i8* [ %t248, %merge12 ], [ %t60, %afterloop3 ]
  %t259 = phi i8* [ %t249, %merge12 ], [ %t59, %afterloop3 ]
  %t260 = phi i8* [ %t250, %merge12 ], [ %t61, %afterloop3 ]
  %t261 = phi i8* [ %t251, %merge12 ], [ %t59, %afterloop3 ]
  %t262 = phi i8* [ %t252, %merge12 ], [ %t60, %afterloop3 ]
  %t263 = phi i8* [ %t253, %merge12 ], [ %t59, %afterloop3 ]
  %t264 = phi i8* [ %t254, %merge12 ], [ %t60, %afterloop3 ]
  %t265 = phi i8* [ %t255, %merge12 ], [ %t60, %afterloop3 ]
  store i8* %t256, i8** %l5
  store i8* %t257, i8** %l3
  store i8* %t258, i8** %l4
  store i8* %t259, i8** %l3
  store i8* %t260, i8** %l5
  store i8* %t261, i8** %l3
  store i8* %t262, i8** %l4
  store i8* %t263, i8** %l3
  store i8* %t264, i8** %l4
  store i8* %t265, i8** %l4
  %t266 = load i8*, i8** %l0
  %t267 = insertvalue %BindingComponents undef, i8* %t266, 0
  %t268 = load i8*, i8** %l3
  %t269 = insertvalue %BindingComponents %t267, i8* %t268, 1
  %t270 = load i8*, i8** %l4
  %t271 = insertvalue %BindingComponents %t269, i8* %t270, 2
  ret %BindingComponents %t271
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
  %t2 = call i8* @malloc(i64 7)
  %t3 = bitcast i8* %t2 to [7 x i8]*
  store [7 x i8] c"async \00", [7 x i8]* %t3
  %t4 = call i1 @starts_with(i8* %t1, i8* %t2)
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @malloc(i64 7)
  %t8 = bitcast i8* %t7 to [7 x i8]*
  store [7 x i8] c"async \00", [7 x i8]* %t8
  %t9 = call i8* @strip_prefix(i8* %t6, i8* %t7)
  %t10 = call i8* @trim_text(i8* %t9)
  store i8* %t10, i8** %l0
  %t11 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t12 = phi i8* [ %t11, %then0 ], [ %t5, %block.entry ]
  store i8* %t12, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = add i64 0, 2
  %t15 = call i8* @malloc(i64 %t14)
  store i8 40, i8* %t15
  %t16 = getelementptr i8, i8* %t15, i64 1
  store i8 0, i8* %t16
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  %t17 = call double @index_of(i8* %t13, i8* %t15)
  store double %t17, double* %l1
  %t18 = load i8*, i8** %l0
  store i8* %t18, i8** %l2
  %t19 = load double, double* %l1
  %t20 = sitofp i64 0 to double
  %t21 = fcmp oge double %t19, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i8*, i8** %l2
  br i1 %t21, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = call i8* @sailfin_runtime_substring(i8* %t25, i64 0, i64 %t28)
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t32 = phi i8* [ %t31, %then2 ], [ %t24, %merge1 ]
  store i8* %t32, i8** %l2
  %t33 = load i8*, i8** %l2
  %t34 = add i64 0, 2
  %t35 = call i8* @malloc(i64 %t34)
  store i8 46, i8* %t35
  %t36 = getelementptr i8, i8* %t35, i64 1
  store i8 0, i8* %t36
  call void @sailfin_runtime_mark_persistent(i8* %t35)
  %t37 = call double @last_index_of(i8* %t33, i8* %t35)
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
  %t7 = call i8* @malloc(i64 5)
  %t8 = bitcast i8* %t7 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t8
  %t9 = call i1 @starts_with(i8* %t6, i8* %t7)
  %t10 = load i8*, i8** %l0
  %t11 = load i1, i1* %l1
  br i1 %t9, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call i8* @malloc(i64 5)
  %t14 = bitcast i8* %t13 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t14
  %t15 = call i8* @strip_prefix(i8* %t12, i8* %t13)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = load i1, i1* %l1
  %t18 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t19 = phi i1 [ %t17, %then2 ], [ %t11, %merge1 ]
  %t20 = phi i8* [ %t18, %then2 ], [ %t10, %merge1 ]
  store i1 %t19, i1* %l1
  store i8* %t20, i8** %l0
  %t21 = call i8* @malloc(i64 1)
  %t22 = bitcast i8* %t21 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t22
  store i8* %t21, i8** %l2
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l3
  %t24 = load i8*, i8** %l0
  %t25 = load i1, i1* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t69 = phi i8* [ %t26, %merge3 ], [ %t67, %loop.latch6 ]
  %t70 = phi double [ %t27, %merge3 ], [ %t68, %loop.latch6 ]
  store i8* %t69, i8** %l2
  store double %t70, double* %l3
  br label %loop.body5
loop.body5:
  %t28 = load double, double* %l3
  %t29 = load i8*, i8** %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t28, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load i1, i1* %l1
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l3
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %t37, i64 %t40
  %t42 = load i8, i8* %t41
  store i8 %t42, i8* %l4
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 32
  br label %logical_or_entry_43

logical_or_entry_43:
  br i1 %t45, label %logical_or_merge_43, label %logical_or_right_43

logical_or_right_43:
  %t47 = load i8, i8* %l4
  %t48 = icmp eq i8 %t47, 45
  br label %logical_or_entry_46

logical_or_entry_46:
  br i1 %t48, label %logical_or_merge_46, label %logical_or_right_46

logical_or_right_46:
  %t49 = load i8, i8* %l4
  %t50 = icmp eq i8 %t49, 61
  br label %logical_or_right_end_46

logical_or_right_end_46:
  br label %logical_or_merge_46

logical_or_merge_46:
  %t51 = phi i1 [ true, %logical_or_entry_46 ], [ %t50, %logical_or_right_end_46 ]
  br label %logical_or_right_end_43

logical_or_right_end_43:
  br label %logical_or_merge_43

logical_or_merge_43:
  %t52 = phi i1 [ true, %logical_or_entry_43 ], [ %t51, %logical_or_right_end_43 ]
  %t53 = load i8*, i8** %l0
  %t54 = load i1, i1* %l1
  %t55 = load i8*, i8** %l2
  %t56 = load double, double* %l3
  %t57 = load i8, i8* %l4
  br i1 %t52, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t58 = load i8*, i8** %l2
  %t59 = load i8, i8* %l4
  %t60 = add i64 0, 2
  %t61 = call i8* @malloc(i64 %t60)
  store i8 %t59, i8* %t61
  %t62 = getelementptr i8, i8* %t61, i64 1
  store i8 0, i8* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t61)
  store i8* %t63, i8** %l2
  %t64 = load double, double* %l3
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l3
  br label %loop.latch6
loop.latch6:
  %t67 = load i8*, i8** %l2
  %t68 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t71 = load i8*, i8** %l2
  %t72 = load double, double* %l3
  %t73 = load i8*, i8** %l2
  %t74 = call i8* @trim_text(i8* %t73)
  store i8* %t74, i8** %l2
  %t75 = load i8*, i8** %l2
  %t76 = call i64 @sailfin_runtime_string_length(i8* %t75)
  %t77 = icmp eq i64 %t76, 0
  %t78 = load i8*, i8** %l0
  %t79 = load i1, i1* %l1
  %t80 = load i8*, i8** %l2
  %t81 = load double, double* %l3
  br i1 %t77, label %then12, label %merge13
then12:
  %t82 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t82
merge13:
  %t83 = call i8* @malloc(i64 1)
  %t84 = bitcast i8* %t83 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t84
  store i8* %t83, i8** %l5
  store i8* null, i8** %l6
  %t85 = load i8*, i8** %l0
  %t86 = load double, double* %l3
  %t87 = load i8*, i8** %l0
  %t88 = call i64 @sailfin_runtime_string_length(i8* %t87)
  %t89 = call double @llvm.round.f64(double %t86)
  %t90 = fptosi double %t89 to i64
  %t91 = call i8* @sailfin_runtime_substring(i8* %t85, i64 %t90, i64 %t88)
  %t92 = call i8* @trim_text(i8* %t91)
  store i8* %t92, i8** %l7
  %t93 = load i8*, i8** %l7
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = icmp sgt i64 %t94, 0
  %t96 = load i8*, i8** %l0
  %t97 = load i1, i1* %l1
  %t98 = load i8*, i8** %l2
  %t99 = load double, double* %l3
  %t100 = load i8*, i8** %l5
  %t101 = load i8*, i8** %l6
  %t102 = load i8*, i8** %l7
  br i1 %t95, label %then14, label %merge15
then14:
  %t103 = load i8*, i8** %l7
  %t104 = call i8* @malloc(i64 3)
  %t105 = bitcast i8* %t104 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t105
  %t106 = call i1 @starts_with(i8* %t103, i8* %t104)
  %t107 = load i8*, i8** %l0
  %t108 = load i1, i1* %l1
  %t109 = load i8*, i8** %l2
  %t110 = load double, double* %l3
  %t111 = load i8*, i8** %l5
  %t112 = load i8*, i8** %l6
  %t113 = load i8*, i8** %l7
  br i1 %t106, label %then16, label %else17
then16:
  %t114 = load i8*, i8** %l7
  %t115 = call i8* @malloc(i64 3)
  %t116 = bitcast i8* %t115 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t116
  %t117 = call i8* @strip_prefix(i8* %t114, i8* %t115)
  %t118 = call i8* @trim_text(i8* %t117)
  store i8* %t118, i8** %l7
  %t119 = load i8*, i8** %l7
  %t120 = add i64 0, 2
  %t121 = call i8* @malloc(i64 %t120)
  store i8 61, i8* %t121
  %t122 = getelementptr i8, i8* %t121, i64 1
  store i8 0, i8* %t122
  call void @sailfin_runtime_mark_persistent(i8* %t121)
  %t123 = call double @index_of(i8* %t119, i8* %t121)
  store double %t123, double* %l8
  %t124 = load double, double* %l8
  %t125 = sitofp i64 0 to double
  %t126 = fcmp oge double %t124, %t125
  %t127 = load i8*, i8** %l0
  %t128 = load i1, i1* %l1
  %t129 = load i8*, i8** %l2
  %t130 = load double, double* %l3
  %t131 = load i8*, i8** %l5
  %t132 = load i8*, i8** %l6
  %t133 = load i8*, i8** %l7
  %t134 = load double, double* %l8
  br i1 %t126, label %then19, label %else20
then19:
  %t135 = load i8*, i8** %l7
  %t136 = load double, double* %l8
  %t137 = call double @llvm.round.f64(double %t136)
  %t138 = fptosi double %t137 to i64
  %t139 = call i8* @sailfin_runtime_substring(i8* %t135, i64 0, i64 %t138)
  %t140 = call i8* @trim_text(i8* %t139)
  store i8* %t140, i8** %l5
  %t141 = load i8*, i8** %l7
  %t142 = load double, double* %l8
  %t143 = sitofp i64 1 to double
  %t144 = fadd double %t142, %t143
  %t145 = load i8*, i8** %l7
  %t146 = call i64 @sailfin_runtime_string_length(i8* %t145)
  %t147 = call double @llvm.round.f64(double %t144)
  %t148 = fptosi double %t147 to i64
  %t149 = call i8* @sailfin_runtime_substring(i8* %t141, i64 %t148, i64 %t146)
  %t150 = call i8* @trim_text(i8* %t149)
  store i8* %t150, i8** %l9
  %t151 = load i8*, i8** %l9
  %t152 = call i64 @sailfin_runtime_string_length(i8* %t151)
  %t153 = icmp sgt i64 %t152, 0
  %t154 = load i8*, i8** %l0
  %t155 = load i1, i1* %l1
  %t156 = load i8*, i8** %l2
  %t157 = load double, double* %l3
  %t158 = load i8*, i8** %l5
  %t159 = load i8*, i8** %l6
  %t160 = load i8*, i8** %l7
  %t161 = load double, double* %l8
  %t162 = load i8*, i8** %l9
  br i1 %t153, label %then22, label %merge23
then22:
  %t163 = load i8*, i8** %l9
  store i8* %t163, i8** %l6
  %t164 = load i8*, i8** %l6
  br label %merge23
merge23:
  %t165 = phi i8* [ %t164, %then22 ], [ %t159, %then19 ]
  store i8* %t165, i8** %l6
  %t166 = load i8*, i8** %l5
  %t167 = load i8*, i8** %l6
  br label %merge21
else20:
  %t168 = load i8*, i8** %l7
  %t169 = call i8* @trim_text(i8* %t168)
  store i8* %t169, i8** %l5
  %t170 = load i8*, i8** %l5
  br label %merge21
merge21:
  %t171 = phi i8* [ %t166, %merge23 ], [ %t170, %else20 ]
  %t172 = phi i8* [ %t167, %merge23 ], [ %t132, %else20 ]
  store i8* %t171, i8** %l5
  store i8* %t172, i8** %l6
  %t173 = load i8*, i8** %l7
  %t174 = load i8*, i8** %l5
  %t175 = load i8*, i8** %l6
  %t176 = load i8*, i8** %l5
  br label %merge18
else17:
  %t177 = load i8*, i8** %l7
  %t178 = add i64 0, 2
  %t179 = call i8* @malloc(i64 %t178)
  store i8 61, i8* %t179
  %t180 = getelementptr i8, i8* %t179, i64 1
  store i8 0, i8* %t180
  call void @sailfin_runtime_mark_persistent(i8* %t179)
  %t181 = call i1 @starts_with(i8* %t177, i8* %t179)
  %t182 = load i8*, i8** %l0
  %t183 = load i1, i1* %l1
  %t184 = load i8*, i8** %l2
  %t185 = load double, double* %l3
  %t186 = load i8*, i8** %l5
  %t187 = load i8*, i8** %l6
  %t188 = load i8*, i8** %l7
  br i1 %t181, label %then24, label %merge25
then24:
  %t189 = load i8*, i8** %l7
  %t190 = add i64 0, 2
  %t191 = call i8* @malloc(i64 %t190)
  store i8 61, i8* %t191
  %t192 = getelementptr i8, i8* %t191, i64 1
  store i8 0, i8* %t192
  call void @sailfin_runtime_mark_persistent(i8* %t191)
  %t193 = call i8* @strip_prefix(i8* %t189, i8* %t191)
  %t194 = call i8* @trim_text(i8* %t193)
  store i8* %t194, i8** %l10
  %t195 = load i8*, i8** %l10
  %t196 = call i64 @sailfin_runtime_string_length(i8* %t195)
  %t197 = icmp sgt i64 %t196, 0
  %t198 = load i8*, i8** %l0
  %t199 = load i1, i1* %l1
  %t200 = load i8*, i8** %l2
  %t201 = load double, double* %l3
  %t202 = load i8*, i8** %l5
  %t203 = load i8*, i8** %l6
  %t204 = load i8*, i8** %l7
  %t205 = load i8*, i8** %l10
  br i1 %t197, label %then26, label %merge27
then26:
  %t206 = load i8*, i8** %l10
  store i8* %t206, i8** %l6
  %t207 = load i8*, i8** %l6
  br label %merge27
merge27:
  %t208 = phi i8* [ %t207, %then26 ], [ %t203, %then24 ]
  store i8* %t208, i8** %l6
  %t209 = load i8*, i8** %l6
  br label %merge25
merge25:
  %t210 = phi i8* [ %t209, %merge27 ], [ %t187, %else17 ]
  store i8* %t210, i8** %l6
  %t211 = load i8*, i8** %l6
  br label %merge18
merge18:
  %t212 = phi i8* [ %t173, %merge21 ], [ %t113, %merge25 ]
  %t213 = phi i8* [ %t174, %merge21 ], [ %t111, %merge25 ]
  %t214 = phi i8* [ %t175, %merge21 ], [ %t211, %merge25 ]
  store i8* %t212, i8** %l7
  store i8* %t213, i8** %l5
  store i8* %t214, i8** %l6
  %t215 = load i8*, i8** %l7
  %t216 = load i8*, i8** %l5
  %t217 = load i8*, i8** %l6
  %t218 = load i8*, i8** %l5
  %t219 = load i8*, i8** %l6
  br label %merge15
merge15:
  %t220 = phi i8* [ %t215, %merge18 ], [ %t102, %merge13 ]
  %t221 = phi i8* [ %t216, %merge18 ], [ %t100, %merge13 ]
  %t222 = phi i8* [ %t217, %merge18 ], [ %t101, %merge13 ]
  %t223 = phi i8* [ %t218, %merge18 ], [ %t100, %merge13 ]
  %t224 = phi i8* [ %t219, %merge18 ], [ %t101, %merge13 ]
  store i8* %t220, i8** %l7
  store i8* %t221, i8** %l5
  store i8* %t222, i8** %l6
  store i8* %t223, i8** %l5
  store i8* %t224, i8** %l6
  %t225 = load i8*, i8** %l2
  %t226 = insertvalue %NativeParameter undef, i8* %t225, 0
  %t227 = load i8*, i8** %l5
  %t228 = insertvalue %NativeParameter %t226, i8* %t227, 1
  %t229 = load i1, i1* %l1
  %t230 = insertvalue %NativeParameter %t228, i1 %t229, 2
  %t231 = load i8*, i8** %l6
  %t232 = insertvalue %NativeParameter %t230, i8* %t231, 3
  %t233 = insertvalue %NativeParameter %t232, %NativeSourceSpan* %span, 4
  %t234 = getelementptr %NativeParameter, %NativeParameter* null, i32 1
  %t235 = ptrtoint %NativeParameter* %t234 to i64
  %t236 = call noalias i8* @malloc(i64 %t235)
  %t237 = bitcast i8* %t236 to %NativeParameter*
  store %NativeParameter %t233, %NativeParameter* %t237
  call void @sailfin_runtime_mark_persistent(i8* %t236)
  ret %NativeParameter* %t237
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
  %t18 = call i8* @malloc(i64 3)
  %t19 = bitcast i8* %t18 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t19
  %t20 = call double @index_of(i8* %t17, i8* %t18)
  store double %t20, double* %l1
  %t21 = load double, double* %l1
  %t22 = sitofp i64 0 to double
  %t23 = fcmp oge double %t21, %t22
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t26, i64 0, i64 %t29)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t38 = load i8*, i8** %l2
  %t39 = call i8* @malloc(i64 5)
  %t40 = bitcast i8* %t39 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t40
  %t41 = call i1 @starts_with(i8* %t38, i8* %t39)
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  br i1 %t41, label %then10, label %merge11
then10:
  %t45 = load i8*, i8** %l2
  %t46 = call i8* @malloc(i64 5)
  %t47 = bitcast i8* %t46 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t47
  %t48 = call i8* @strip_prefix(i8* %t45, i8* %t46)
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l2
  %t50 = load i8*, i8** %l2
  br label %merge11
merge11:
  %t51 = phi i8* [ %t50, %then10 ], [ %t44, %merge9 ]
  store i8* %t51, i8** %l2
  %t52 = load i8*, i8** %l2
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp eq i64 %t53, 0
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l2
  br i1 %t54, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t58 = load i8*, i8** %l2
  %t59 = add i64 0, 2
  %t60 = call i8* @malloc(i64 %t59)
  store i8 32, i8* %t60
  %t61 = getelementptr i8, i8* %t60, i64 1
  store i8 0, i8* %t61
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  %t62 = call double @index_of(i8* %t58, i8* %t60)
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
  %t69 = add i64 0, 2
  %t70 = call i8* @malloc(i64 %t69)
  store i8 9, i8* %t70
  %t71 = getelementptr i8, i8* %t70, i64 1
  store i8 0, i8* %t71
  call void @sailfin_runtime_mark_persistent(i8* %t70)
  %t72 = call double @index_of(i8* %t68, i8* %t70)
  %t73 = sitofp i64 0 to double
  %t74 = fcmp oge double %t72, %t73
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l2
  br i1 %t74, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t78 = load i8*, i8** %l0
  %t79 = add i64 0, 2
  %t80 = call i8* @malloc(i64 %t79)
  store i8 61, i8* %t80
  %t81 = getelementptr i8, i8* %t80, i64 1
  store i8 0, i8* %t81
  call void @sailfin_runtime_mark_persistent(i8* %t80)
  %t82 = call double @index_of(i8* %t78, i8* %t80)
  store double %t82, double* %l3
  %t83 = load double, double* %l3
  %t84 = sitofp i64 0 to double
  %t85 = fcmp oge double %t83, %t84
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l3
  br i1 %t85, label %then18, label %merge19
then18:
  %t89 = load i8*, i8** %l0
  %t90 = load double, double* %l3
  %t91 = call double @llvm.round.f64(double %t90)
  %t92 = fptosi double %t91 to i64
  %t93 = call i8* @sailfin_runtime_substring(i8* %t89, i64 0, i64 %t92)
  %t94 = call i8* @trim_text(i8* %t93)
  store i8* %t94, i8** %l4
  %t95 = load i8*, i8** %l4
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = icmp eq i64 %t96, 0
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l3
  %t101 = load i8*, i8** %l4
  br i1 %t97, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t102 = load i8*, i8** %l4
  %t103 = call i8* @malloc(i64 5)
  %t104 = bitcast i8* %t103 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t104
  %t105 = call i1 @starts_with(i8* %t102, i8* %t103)
  %t106 = load i8*, i8** %l0
  %t107 = load double, double* %l1
  %t108 = load double, double* %l3
  %t109 = load i8*, i8** %l4
  br i1 %t105, label %then22, label %merge23
then22:
  %t110 = load i8*, i8** %l4
  %t111 = call i8* @malloc(i64 5)
  %t112 = bitcast i8* %t111 to [5 x i8]*
  store [5 x i8] c"mut \00", [5 x i8]* %t112
  %t113 = call i8* @strip_prefix(i8* %t110, i8* %t111)
  %t114 = call i8* @trim_text(i8* %t113)
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l4
  br label %merge23
merge23:
  %t116 = phi i8* [ %t115, %then22 ], [ %t109, %merge21 ]
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
  %t125 = add i64 0, 2
  %t126 = call i8* @malloc(i64 %t125)
  store i8 32, i8* %t126
  %t127 = getelementptr i8, i8* %t126, i64 1
  store i8 0, i8* %t127
  call void @sailfin_runtime_mark_persistent(i8* %t126)
  %t128 = call double @index_of(i8* %t124, i8* %t126)
  %t129 = sitofp i64 0 to double
  %t130 = fcmp oge double %t128, %t129
  %t131 = load i8*, i8** %l0
  %t132 = load double, double* %l1
  %t133 = load double, double* %l3
  %t134 = load i8*, i8** %l4
  br i1 %t130, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t135 = load i8*, i8** %l4
  %t136 = add i64 0, 2
  %t137 = call i8* @malloc(i64 %t136)
  store i8 9, i8* %t137
  %t138 = getelementptr i8, i8* %t137, i64 1
  store i8 0, i8* %t138
  call void @sailfin_runtime_mark_persistent(i8* %t137)
  %t139 = call double @index_of(i8* %t135, i8* %t137)
  %t140 = sitofp i64 0 to double
  %t141 = fcmp oge double %t139, %t140
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load double, double* %l3
  %t145 = load i8*, i8** %l4
  br i1 %t141, label %then28, label %merge29
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = call i8* @malloc(i64 1)
  %t17 = bitcast i8* %t16 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t17
  store i8* %t16, i8** %l4
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i8*, i8** %l4
  br label %loop.header0
loop.header0:
  %t259 = phi i8* [ %t19, %block.entry ], [ %t254, %loop.latch2 ]
  %t260 = phi double [ %t20, %block.entry ], [ %t255, %loop.latch2 ]
  %t261 = phi i8* [ %t22, %block.entry ], [ %t256, %loop.latch2 ]
  %t262 = phi double [ %t21, %block.entry ], [ %t257, %loop.latch2 ]
  %t263 = phi { i8**, i64 }* [ %t18, %block.entry ], [ %t258, %loop.latch2 ]
  store i8* %t259, i8** %l1
  store double %t260, double* %l2
  store i8* %t261, i8** %l4
  store double %t262, double* %l3
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t23 = load double, double* %l2
  %t24 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t23, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load i8*, i8** %l4
  br i1 %t26, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l2
  %t33 = call double @llvm.round.f64(double %t32)
  %t34 = fptosi double %t33 to i64
  %t35 = getelementptr i8, i8* %body, i64 %t34
  %t36 = load i8, i8* %t35
  store i8 %t36, i8* %l5
  %t37 = load i8*, i8** %l4
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp sgt i64 %t38, 0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load double, double* %l3
  %t44 = load i8*, i8** %l4
  %t45 = load i8, i8* %l5
  br i1 %t39, label %then6, label %merge7
then6:
  %t46 = load i8*, i8** %l1
  %t47 = load i8, i8* %l5
  %t48 = add i64 0, 2
  %t49 = call i8* @malloc(i64 %t48)
  store i8 %t47, i8* %t49
  %t50 = getelementptr i8, i8* %t49, i64 1
  store i8 0, i8* %t50
  call void @sailfin_runtime_mark_persistent(i8* %t49)
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t49)
  store i8* %t51, i8** %l1
  %t52 = load i8, i8* %l5
  %t53 = icmp eq i8 %t52, 92
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load i8*, i8** %l4
  %t59 = load i8, i8* %l5
  br i1 %t53, label %then8, label %merge9
then8:
  %t60 = load double, double* %l2
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  %t63 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t64 = sitofp i64 %t63 to double
  %t65 = fcmp olt double %t62, %t64
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  %t69 = load double, double* %l3
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %l5
  br i1 %t65, label %then10, label %merge11
then10:
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  %t76 = call double @llvm.round.f64(double %t75)
  %t77 = fptosi double %t76 to i64
  %t78 = getelementptr i8, i8* %body, i64 %t77
  %t79 = load i8, i8* %t78
  %t80 = add i64 0, 2
  %t81 = call i8* @malloc(i64 %t80)
  store i8 %t79, i8* %t81
  %t82 = getelementptr i8, i8* %t81, i64 1
  store i8 0, i8* %t82
  call void @sailfin_runtime_mark_persistent(i8* %t81)
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t72, i8* %t81)
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
  %t89 = phi i8* [ %t87, %merge11 ], [ %t55, %then6 ]
  %t90 = phi double [ %t88, %merge11 ], [ %t56, %then6 ]
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
  %t101 = call i8* @malloc(i64 1)
  %t102 = bitcast i8* %t101 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t102
  store i8* %t101, i8** %l4
  %t103 = load i8*, i8** %l4
  br label %merge13
merge13:
  %t104 = phi i8* [ %t103, %then12 ], [ %t99, %merge9 ]
  store i8* %t104, i8** %l4
  %t105 = load double, double* %l2
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l2
  br label %loop.latch2
merge7:
  %t109 = load i8, i8* %l5
  %t110 = icmp eq i8 %t109, 34
  br label %logical_or_entry_108

logical_or_entry_108:
  br i1 %t110, label %logical_or_merge_108, label %logical_or_right_108

logical_or_right_108:
  %t111 = load i8, i8* %l5
  %t112 = icmp eq i8 %t111, 39
  br label %logical_or_right_end_108

logical_or_right_end_108:
  br label %logical_or_merge_108

logical_or_merge_108:
  %t113 = phi i1 [ true, %logical_or_entry_108 ], [ %t112, %logical_or_right_end_108 ]
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l2
  %t117 = load double, double* %l3
  %t118 = load i8*, i8** %l4
  %t119 = load i8, i8* %l5
  br i1 %t113, label %then14, label %merge15
then14:
  %t120 = load i8, i8* %l5
  %t121 = add i64 0, 2
  %t122 = call i8* @malloc(i64 %t121)
  store i8 %t120, i8* %t122
  %t123 = getelementptr i8, i8* %t122, i64 1
  store i8 0, i8* %t123
  call void @sailfin_runtime_mark_persistent(i8* %t122)
  store i8* %t122, i8** %l4
  %t124 = load i8*, i8** %l1
  %t125 = load i8, i8* %l5
  %t126 = add i64 0, 2
  %t127 = call i8* @malloc(i64 %t126)
  store i8 %t125, i8* %t127
  %t128 = getelementptr i8, i8* %t127, i64 1
  store i8 0, i8* %t128
  call void @sailfin_runtime_mark_persistent(i8* %t127)
  %t129 = call i8* @sailfin_runtime_string_concat(i8* %t124, i8* %t127)
  store i8* %t129, i8** %l1
  %t130 = load double, double* %l2
  %t131 = sitofp i64 1 to double
  %t132 = fadd double %t130, %t131
  store double %t132, double* %l2
  br label %loop.latch2
merge15:
  %t134 = load i8, i8* %l5
  %t135 = icmp eq i8 %t134, 40
  br label %logical_or_entry_133

logical_or_entry_133:
  br i1 %t135, label %logical_or_merge_133, label %logical_or_right_133

logical_or_right_133:
  %t137 = load i8, i8* %l5
  %t138 = icmp eq i8 %t137, 91
  br label %logical_or_entry_136

logical_or_entry_136:
  br i1 %t138, label %logical_or_merge_136, label %logical_or_right_136

logical_or_right_136:
  %t139 = load i8, i8* %l5
  %t140 = icmp eq i8 %t139, 123
  br label %logical_or_right_end_136

logical_or_right_end_136:
  br label %logical_or_merge_136

logical_or_merge_136:
  %t141 = phi i1 [ true, %logical_or_entry_136 ], [ %t140, %logical_or_right_end_136 ]
  br label %logical_or_right_end_133

logical_or_right_end_133:
  br label %logical_or_merge_133

logical_or_merge_133:
  %t142 = phi i1 [ true, %logical_or_entry_133 ], [ %t141, %logical_or_right_end_133 ]
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load i8*, i8** %l1
  %t145 = load double, double* %l2
  %t146 = load double, double* %l3
  %t147 = load i8*, i8** %l4
  %t148 = load i8, i8* %l5
  br i1 %t142, label %then16, label %merge17
then16:
  %t149 = load double, double* %l3
  %t150 = sitofp i64 1 to double
  %t151 = fadd double %t149, %t150
  store double %t151, double* %l3
  %t152 = load i8*, i8** %l1
  %t153 = load i8, i8* %l5
  %t154 = add i64 0, 2
  %t155 = call i8* @malloc(i64 %t154)
  store i8 %t153, i8* %t155
  %t156 = getelementptr i8, i8* %t155, i64 1
  store i8 0, i8* %t156
  call void @sailfin_runtime_mark_persistent(i8* %t155)
  %t157 = call i8* @sailfin_runtime_string_concat(i8* %t152, i8* %t155)
  store i8* %t157, i8** %l1
  %t158 = load double, double* %l2
  %t159 = sitofp i64 1 to double
  %t160 = fadd double %t158, %t159
  store double %t160, double* %l2
  br label %loop.latch2
merge17:
  %t162 = load i8, i8* %l5
  %t163 = icmp eq i8 %t162, 41
  br label %logical_or_entry_161

logical_or_entry_161:
  br i1 %t163, label %logical_or_merge_161, label %logical_or_right_161

logical_or_right_161:
  %t165 = load i8, i8* %l5
  %t166 = icmp eq i8 %t165, 93
  br label %logical_or_entry_164

logical_or_entry_164:
  br i1 %t166, label %logical_or_merge_164, label %logical_or_right_164

logical_or_right_164:
  %t167 = load i8, i8* %l5
  %t168 = icmp eq i8 %t167, 125
  br label %logical_or_right_end_164

logical_or_right_end_164:
  br label %logical_or_merge_164

logical_or_merge_164:
  %t169 = phi i1 [ true, %logical_or_entry_164 ], [ %t168, %logical_or_right_end_164 ]
  br label %logical_or_right_end_161

logical_or_right_end_161:
  br label %logical_or_merge_161

logical_or_merge_161:
  %t170 = phi i1 [ true, %logical_or_entry_161 ], [ %t169, %logical_or_right_end_161 ]
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load i8*, i8** %l1
  %t173 = load double, double* %l2
  %t174 = load double, double* %l3
  %t175 = load i8*, i8** %l4
  %t176 = load i8, i8* %l5
  br i1 %t170, label %then18, label %merge19
then18:
  %t177 = load double, double* %l3
  %t178 = sitofp i64 0 to double
  %t179 = fcmp ogt double %t177, %t178
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load i8*, i8** %l1
  %t182 = load double, double* %l2
  %t183 = load double, double* %l3
  %t184 = load i8*, i8** %l4
  %t185 = load i8, i8* %l5
  br i1 %t179, label %then20, label %merge21
then20:
  %t186 = load double, double* %l3
  %t187 = sitofp i64 1 to double
  %t188 = fsub double %t186, %t187
  store double %t188, double* %l3
  %t189 = load double, double* %l3
  br label %merge21
merge21:
  %t190 = phi double [ %t189, %then20 ], [ %t183, %then18 ]
  store double %t190, double* %l3
  %t191 = load i8*, i8** %l1
  %t192 = load i8, i8* %l5
  %t193 = add i64 0, 2
  %t194 = call i8* @malloc(i64 %t193)
  store i8 %t192, i8* %t194
  %t195 = getelementptr i8, i8* %t194, i64 1
  store i8 0, i8* %t195
  call void @sailfin_runtime_mark_persistent(i8* %t194)
  %t196 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t194)
  store i8* %t196, i8** %l1
  %t197 = load double, double* %l2
  %t198 = sitofp i64 1 to double
  %t199 = fadd double %t197, %t198
  store double %t199, double* %l2
  br label %loop.latch2
merge19:
  %t200 = load i8, i8* %l5
  %t201 = icmp eq i8 %t200, 44
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t203 = load i8*, i8** %l1
  %t204 = load double, double* %l2
  %t205 = load double, double* %l3
  %t206 = load i8*, i8** %l4
  %t207 = load i8, i8* %l5
  br i1 %t201, label %then22, label %merge23
then22:
  %t208 = load double, double* %l3
  %t209 = sitofp i64 0 to double
  %t210 = fcmp oeq double %t208, %t209
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t212 = load i8*, i8** %l1
  %t213 = load double, double* %l2
  %t214 = load double, double* %l3
  %t215 = load i8*, i8** %l4
  %t216 = load i8, i8* %l5
  br i1 %t210, label %then24, label %merge25
then24:
  %t217 = load i8*, i8** %l1
  %t218 = call i8* @trim_text(i8* %t217)
  store i8* %t218, i8** %l6
  %t219 = load i8*, i8** %l6
  %t220 = call i64 @sailfin_runtime_string_length(i8* %t219)
  %t221 = icmp sgt i64 %t220, 0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l2
  %t225 = load double, double* %l3
  %t226 = load i8*, i8** %l4
  %t227 = load i8, i8* %l5
  %t228 = load i8*, i8** %l6
  br i1 %t221, label %then26, label %merge27
then26:
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t230 = load i8*, i8** %l6
  %t231 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t229, i8* %t230)
  store { i8**, i64 }* %t231, { i8**, i64 }** %l0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t233 = phi { i8**, i64 }* [ %t232, %then26 ], [ %t222, %then24 ]
  store { i8**, i64 }* %t233, { i8**, i64 }** %l0
  %t234 = call i8* @malloc(i64 1)
  %t235 = bitcast i8* %t234 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t235
  store i8* %t234, i8** %l1
  %t236 = load double, double* %l2
  %t237 = sitofp i64 1 to double
  %t238 = fadd double %t236, %t237
  store double %t238, double* %l2
  br label %loop.latch2
merge25:
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  br label %merge23
merge23:
  %t242 = phi { i8**, i64 }* [ %t239, %merge25 ], [ %t202, %merge19 ]
  %t243 = phi i8* [ %t240, %merge25 ], [ %t203, %merge19 ]
  %t244 = phi double [ %t241, %merge25 ], [ %t204, %merge19 ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l0
  store i8* %t243, i8** %l1
  store double %t244, double* %l2
  %t245 = load i8*, i8** %l1
  %t246 = load i8, i8* %l5
  %t247 = add i64 0, 2
  %t248 = call i8* @malloc(i64 %t247)
  store i8 %t246, i8* %t248
  %t249 = getelementptr i8, i8* %t248, i64 1
  store i8 0, i8* %t249
  call void @sailfin_runtime_mark_persistent(i8* %t248)
  %t250 = call i8* @sailfin_runtime_string_concat(i8* %t245, i8* %t248)
  store i8* %t250, i8** %l1
  %t251 = load double, double* %l2
  %t252 = sitofp i64 1 to double
  %t253 = fadd double %t251, %t252
  store double %t253, double* %l2
  br label %loop.latch2
loop.latch2:
  %t254 = load i8*, i8** %l1
  %t255 = load double, double* %l2
  %t256 = load i8*, i8** %l4
  %t257 = load double, double* %l3
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t264 = load i8*, i8** %l1
  %t265 = load double, double* %l2
  %t266 = load i8*, i8** %l4
  %t267 = load double, double* %l3
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t269 = load i8*, i8** %l1
  %t270 = call i8* @trim_text(i8* %t269)
  store i8* %t270, i8** %l7
  %t271 = load i8*, i8** %l7
  %t272 = call i64 @sailfin_runtime_string_length(i8* %t271)
  %t273 = icmp sgt i64 %t272, 0
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t275 = load i8*, i8** %l1
  %t276 = load double, double* %l2
  %t277 = load double, double* %l3
  %t278 = load i8*, i8** %l4
  %t279 = load i8*, i8** %l7
  br i1 %t273, label %then28, label %merge29
then28:
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load i8*, i8** %l7
  %t282 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t280, i8* %t281)
  store { i8**, i64 }* %t282, { i8**, i64 }** %l0
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t284 = phi { i8**, i64 }* [ %t283, %then28 ], [ %t274, %afterloop3 ]
  store { i8**, i64 }* %t284, { i8**, i64 }** %l0
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t285
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i8* @malloc(i64 5)
  %t3 = bitcast i8* %t2 to [5 x i8]*
  store [5 x i8] c"none\00", [5 x i8]* %t3
  %t4 = call i1 @strings_equal(i8* %t1, i8* %t2)
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t7 = ptrtoint [0 x i8*]* %t6 to i64
  %t8 = icmp eq i64 %t7, 0
  %t9 = select i1 %t8, i64 1, i64 %t7
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to i8**
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t13 = ptrtoint { i8**, i64 }* %t12 to i64
  %t14 = call i8* @malloc(i64 %t13)
  %t15 = bitcast i8* %t14 to { i8**, i64 }*
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 0
  store i8** %t11, i8*** %t16
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  ret { i8**, i64 }* %t15
merge1:
  %t18 = load i8*, i8** %l0
  %t19 = call { i8**, i64 }* @split_comma_separated(i8* %t18)
  ret { i8**, i64 }* %t19
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t58 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t55, %loop.latch2 ]
  %t59 = phi i8* [ %t16, %block.entry ], [ %t56, %loop.latch2 ]
  %t60 = phi double [ %t17, %block.entry ], [ %t57, %loop.latch2 ]
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  store i8* %t59, i8** %l1
  store double %t60, double* %l2
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l2
  %t19 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t18, %t20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l2
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %value, i64 %t27
  %t29 = load i8, i8* %t28
  store i8 %t29, i8* %l3
  %t30 = load i8, i8* %l3
  %t31 = icmp eq i8 %t30, 10
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l1
  %t34 = load double, double* %l2
  %t35 = load i8, i8* %l3
  br i1 %t31, label %then6, label %else7
then6:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = call i8* @malloc(i64 1)
  %t40 = bitcast i8* %t39 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t40
  store i8* %t39, i8** %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  br label %merge8
else7:
  %t43 = load i8*, i8** %l1
  %t44 = load i8, i8* %l3
  %t45 = add i64 0, 2
  %t46 = call i8* @malloc(i64 %t45)
  store i8 %t44, i8* %t46
  %t47 = getelementptr i8, i8* %t46, i64 1
  store i8 0, i8* %t47
  call void @sailfin_runtime_mark_persistent(i8* %t46)
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t46)
  store i8* %t48, i8** %l1
  %t49 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t50 = phi { i8**, i64 }* [ %t41, %then6 ], [ %t32, %else7 ]
  %t51 = phi i8* [ %t42, %then6 ], [ %t49, %else7 ]
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
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t67
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
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t59 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t56, %loop.latch2 ]
  %t60 = phi i8* [ %t16, %block.entry ], [ %t57, %loop.latch2 ]
  %t61 = phi double [ %t17, %block.entry ], [ %t58, %loop.latch2 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  store i8* %t60, i8** %l1
  store double %t61, double* %l2
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l2
  %t19 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t18, %t20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l2
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %value, i64 %t27
  %t29 = load i8, i8* %t28
  store i8 %t29, i8* %l3
  %t30 = load i8, i8* %l3
  %t31 = icmp eq i8 %t30, 44
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l1
  %t34 = load double, double* %l2
  %t35 = load i8, i8* %l3
  br i1 %t31, label %then6, label %else7
then6:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = call i8* @trim_text(i8* %t37)
  %t39 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t38)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  %t40 = call i8* @malloc(i64 1)
  %t41 = bitcast i8* %t40 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t41
  store i8* %t40, i8** %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l1
  br label %merge8
else7:
  %t44 = load i8*, i8** %l1
  %t45 = load i8, i8* %l3
  %t46 = add i64 0, 2
  %t47 = call i8* @malloc(i64 %t46)
  store i8 %t45, i8* %t47
  %t48 = getelementptr i8, i8* %t47, i64 1
  store i8 0, i8* %t48
  call void @sailfin_runtime_mark_persistent(i8* %t47)
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t47)
  store i8* %t49, i8** %l1
  %t50 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t51 = phi { i8**, i64 }* [ %t42, %then6 ], [ %t32, %else7 ]
  %t52 = phi i8* [ %t43, %then6 ], [ %t50, %else7 ]
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  store i8* %t52, i8** %l1
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l2
  br label %loop.latch2
loop.latch2:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load i8*, i8** %l1
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  br i1 %t67, label %then9, label %merge10
then9:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = call i8* @trim_text(i8* %t72)
  %t74 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t71, i8* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t76 = phi { i8**, i64 }* [ %t75, %then9 ], [ %t68, %afterloop3 ]
  store { i8**, i64 }* %t76, { i8**, i64 }** %l0
  %t77 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t78 = ptrtoint [0 x i8*]* %t77 to i64
  %t79 = icmp eq i64 %t78, 0
  %t80 = select i1 %t79, i64 1, i64 %t78
  %t81 = call i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to i8**
  %t83 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t84 = ptrtoint { i8**, i64 }* %t83 to i64
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to { i8**, i64 }*
  %t87 = getelementptr { i8**, i64 }, { i8**, i64 }* %t86, i32 0, i32 0
  store i8** %t82, i8*** %t87
  %t88 = getelementptr { i8**, i64 }, { i8**, i64 }* %t86, i32 0, i32 1
  store i64 0, i64* %t88
  store { i8**, i64 }* %t86, { i8**, i64 }** %l4
  %t89 = sitofp i64 0 to double
  store double %t89, double* %l2
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load double, double* %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t132 = phi { i8**, i64 }* [ %t93, %merge10 ], [ %t130, %loop.latch13 ]
  %t133 = phi double [ %t92, %merge10 ], [ %t131, %loop.latch13 ]
  store { i8**, i64 }* %t132, { i8**, i64 }** %l4
  store double %t133, double* %l2
  br label %loop.body12
loop.body12:
  %t94 = load double, double* %l2
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load { i8**, i64 }, { i8**, i64 }* %t95
  %t97 = extractvalue { i8**, i64 } %t96, 1
  %t98 = sitofp i64 %t97 to double
  %t99 = fcmp oge double %t94, %t98
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l2
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t99, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load double, double* %l2
  %t106 = call double @llvm.round.f64(double %t105)
  %t107 = fptosi double %t106 to i64
  %t108 = load { i8**, i64 }, { i8**, i64 }* %t104
  %t109 = extractvalue { i8**, i64 } %t108, 0
  %t110 = extractvalue { i8**, i64 } %t108, 1
  %t111 = icmp uge i64 %t107, %t110
  ; bounds check: %t111 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t107, i64 %t110)
  %t112 = getelementptr i8*, i8** %t109, i64 %t107
  %t113 = load i8*, i8** %t112
  store i8* %t113, i8** %l5
  %t114 = load i8*, i8** %l5
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = icmp sgt i64 %t115, 0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t118 = load i8*, i8** %l1
  %t119 = load double, double* %l2
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t121 = load i8*, i8** %l5
  br i1 %t116, label %then17, label %merge18
then17:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t123 = load i8*, i8** %l5
  %t124 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t122, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l4
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t126 = phi { i8**, i64 }* [ %t125, %then17 ], [ %t120, %merge16 ]
  store { i8**, i64 }* %t126, { i8**, i64 }** %l4
  %t127 = load double, double* %l2
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l2
  br label %loop.latch13
loop.latch13:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t131 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t135 = load double, double* %l2
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t136
}

define i8* @strip_generics(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l2
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t73 = phi double [ %t5, %block.entry ], [ %t70, %loop.latch2 ]
  %t74 = phi double [ %t6, %block.entry ], [ %t71, %loop.latch2 ]
  %t75 = phi i8* [ %t4, %block.entry ], [ %t72, %loop.latch2 ]
  store double %t73, double* %l1
  store double %t74, double* %l2
  store i8* %t75, i8** %l0
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l2
  %t8 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load double, double* %l2
  %t15 = call double @llvm.round.f64(double %t14)
  %t16 = fptosi double %t15 to i64
  %t17 = getelementptr i8, i8* %name, i64 %t16
  %t18 = load i8, i8* %t17
  store i8 %t18, i8* %l3
  %t19 = load i8, i8* %l3
  %t20 = icmp eq i8 %t19, 60
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load double, double* %l2
  %t24 = load i8, i8* %l3
  br i1 %t20, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch2
merge7:
  %t31 = load i8, i8* %l3
  %t32 = icmp eq i8 %t31, 62
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load i8, i8* %l3
  br i1 %t32, label %then8, label %merge9
then8:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 0 to double
  %t39 = fcmp ogt double %t37, %t38
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load double, double* %l2
  %t43 = load i8, i8* %l3
  br i1 %t39, label %then10, label %merge11
then10:
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fsub double %t44, %t45
  store double %t46, double* %l1
  %t47 = load double, double* %l1
  br label %merge11
merge11:
  %t48 = phi double [ %t47, %then10 ], [ %t41, %then8 ]
  store double %t48, double* %l1
  %t49 = load double, double* %l2
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l2
  br label %loop.latch2
merge9:
  %t52 = load double, double* %l1
  %t53 = sitofp i64 0 to double
  %t54 = fcmp oeq double %t52, %t53
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load i8, i8* %l3
  br i1 %t54, label %then12, label %merge13
then12:
  %t59 = load i8*, i8** %l0
  %t60 = load i8, i8* %l3
  %t61 = add i64 0, 2
  %t62 = call i8* @malloc(i64 %t61)
  store i8 %t60, i8* %t62
  %t63 = getelementptr i8, i8* %t62, i64 1
  store i8 0, i8* %t63
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t62)
  store i8* %t64, i8** %l0
  %t65 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t66 = phi i8* [ %t65, %then12 ], [ %t55, %merge9 ]
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
  %l8 = alloca i1
  %l9 = alloca i8
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca %StructLayoutHeaderParse
  %l14 = alloca { %NativeStructLayoutField*, i64 }*
  %l15 = alloca i8*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i1
  %l19 = alloca i8
  %l20 = alloca %StructLayoutFieldParse
  %l21 = alloca %NativeStruct
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca %EnumLayoutHeaderParse
  %l25 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l26 = alloca i8*
  %l27 = alloca i8*
  %l28 = alloca i8*
  %l29 = alloca i8*
  %l30 = alloca %EnumLayoutVariantParse
  %l31 = alloca i8*
  %l32 = alloca i8*
  %l33 = alloca %EnumLayoutPayloadParse
  %l34 = alloca i64
  %l35 = alloca %NativeEnumVariantLayout
  %l36 = alloca { %NativeStructLayoutField*, i64 }*
  %l37 = alloca %NativeEnum
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
  %t988 = phi double [ %t42, %block.entry ], [ %t984, %loop.latch2 ]
  %t989 = phi { i8**, i64 }* [ %t39, %block.entry ], [ %t985, %loop.latch2 ]
  %t990 = phi { %NativeStruct*, i64 }* [ %t40, %block.entry ], [ %t986, %loop.latch2 ]
  %t991 = phi { %NativeEnum*, i64 }* [ %t41, %block.entry ], [ %t987, %loop.latch2 ]
  store double %t988, double* %l4
  store { i8**, i64 }* %t989, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t990, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t991, { %NativeEnum*, i64 }** %l3
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
  %t95 = call i8* @malloc(i64 11)
  %t96 = bitcast i8* %t95 to [11 x i8]*
  store [11 x i8] c".manifest \00", [11 x i8]* %t96
  %t97 = call i1 @starts_with(i8* %t94, i8* %t95)
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
  %t109 = call i8* @malloc(i64 15)
  %t110 = bitcast i8* %t109 to [15 x i8]*
  store [15 x i8] c".layout field \00", [15 x i8]* %t110
  %t111 = call i1 @starts_with(i8* %t108, i8* %t109)
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t115 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t116 = load double, double* %l4
  %t117 = load i8*, i8** %l5
  %t118 = load i8*, i8** %l6
  br i1 %t111, label %then12, label %merge13
then12:
  %t119 = load i8*, i8** %l6
  %t120 = call i8* @malloc(i64 15)
  %t121 = bitcast i8* %t120 to [15 x i8]*
  store [15 x i8] c".layout field \00", [15 x i8]* %t121
  %t122 = call i8* @strip_prefix(i8* %t119, i8* %t120)
  %t123 = call i8* @trim_text(i8* %t122)
  store i8* %t123, i8** %l7
  store i1 0, i1* %l8
  %t124 = load i8*, i8** %l7
  %t125 = call i8* @malloc(i64 7)
  %t126 = bitcast i8* %t125 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t126
  %t127 = call i1 @starts_with(i8* %t124, i8* %t125)
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t131 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t132 = load double, double* %l4
  %t133 = load i8*, i8** %l5
  %t134 = load i8*, i8** %l6
  %t135 = load i8*, i8** %l7
  %t136 = load i1, i1* %l8
  br i1 %t127, label %then14, label %merge15
then14:
  %t137 = load i8*, i8** %l7
  %t138 = call i64 @sailfin_runtime_string_length(i8* %t137)
  %t139 = icmp eq i64 %t138, 6
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t142 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t143 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t144 = load double, double* %l4
  %t145 = load i8*, i8** %l5
  %t146 = load i8*, i8** %l6
  %t147 = load i8*, i8** %l7
  %t148 = load i1, i1* %l8
  br i1 %t139, label %then16, label %else17
then16:
  store i1 1, i1* %l8
  %t149 = load i1, i1* %l8
  br label %merge18
else17:
  %t150 = load i8*, i8** %l7
  %t151 = call i64 @sailfin_runtime_string_length(i8* %t150)
  %t152 = icmp sgt i64 %t151, 6
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t155 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t156 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t157 = load double, double* %l4
  %t158 = load i8*, i8** %l5
  %t159 = load i8*, i8** %l6
  %t160 = load i8*, i8** %l7
  %t161 = load i1, i1* %l8
  br i1 %t152, label %then19, label %merge20
then19:
  %t162 = load i8*, i8** %l7
  %t163 = getelementptr i8, i8* %t162, i64 6
  %t164 = load i8, i8* %t163
  store i8 %t164, i8* %l9
  %t165 = load i8, i8* %l9
  %t166 = add i64 0, 2
  %t167 = call i8* @malloc(i64 %t166)
  store i8 %t165, i8* %t167
  %t168 = getelementptr i8, i8* %t167, i64 1
  store i8 0, i8* %t168
  call void @sailfin_runtime_mark_persistent(i8* %t167)
  %t169 = call i1 @is_trim_char(i8* %t167)
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t173 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t174 = load double, double* %l4
  %t175 = load i8*, i8** %l5
  %t176 = load i8*, i8** %l6
  %t177 = load i8*, i8** %l7
  %t178 = load i1, i1* %l8
  %t179 = load i8, i8* %l9
  br i1 %t169, label %then21, label %merge22
then21:
  store i1 1, i1* %l8
  %t180 = load i1, i1* %l8
  br label %merge22
merge22:
  %t181 = phi i1 [ %t180, %then21 ], [ %t178, %then19 ]
  store i1 %t181, i1* %l8
  %t182 = load i1, i1* %l8
  br label %merge20
merge20:
  %t183 = phi i1 [ %t182, %merge22 ], [ %t161, %else17 ]
  store i1 %t183, i1* %l8
  %t184 = load i1, i1* %l8
  br label %merge18
merge18:
  %t185 = phi i1 [ %t149, %then16 ], [ %t184, %merge20 ]
  store i1 %t185, i1* %l8
  %t186 = load i1, i1* %l8
  %t187 = load i1, i1* %l8
  br label %merge15
merge15:
  %t188 = phi i1 [ %t186, %merge18 ], [ %t136, %then12 ]
  %t189 = phi i1 [ %t187, %merge18 ], [ %t136, %then12 ]
  store i1 %t188, i1* %l8
  store i1 %t189, i1* %l8
  %t190 = load i1, i1* %l8
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t193 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t194 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t195 = load double, double* %l4
  %t196 = load i8*, i8** %l5
  %t197 = load i8*, i8** %l6
  %t198 = load i8*, i8** %l7
  %t199 = load i1, i1* %l8
  br i1 %t190, label %then23, label %merge24
then23:
  %t200 = load i8*, i8** %l7
  %t201 = call i8* @malloc(i64 7)
  %t202 = bitcast i8* %t201 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t202
  %t203 = call i8* @strip_prefix(i8* %t200, i8* %t201)
  %t204 = call i8* @trim_text(i8* %t203)
  store i8* %t204, i8** %l10
  %t205 = call i8* @malloc(i64 16)
  %t206 = bitcast i8* %t205 to [16 x i8]*
  store [16 x i8] c".layout struct \00", [16 x i8]* %t206
  %t207 = load i8*, i8** %l10
  %t208 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t207)
  store i8* %t208, i8** %l6
  %t209 = load i8*, i8** %l6
  br label %merge24
merge24:
  %t210 = phi i8* [ %t209, %then23 ], [ %t197, %merge15 ]
  store i8* %t210, i8** %l6
  %t211 = load i8*, i8** %l6
  br label %merge13
merge13:
  %t212 = phi i8* [ %t211, %merge24 ], [ %t118, %merge11 ]
  store i8* %t212, i8** %l6
  %t213 = load i8*, i8** %l6
  %t214 = call i8* @malloc(i64 16)
  %t215 = bitcast i8* %t214 to [16 x i8]*
  store [16 x i8] c".layout struct \00", [16 x i8]* %t215
  %t216 = call i1 @starts_with(i8* %t213, i8* %t214)
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t220 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t221 = load double, double* %l4
  %t222 = load i8*, i8** %l5
  %t223 = load i8*, i8** %l6
  br i1 %t216, label %then25, label %merge26
then25:
  %t224 = load i8*, i8** %l6
  %t225 = call i8* @malloc(i64 9)
  %t226 = bitcast i8* %t225 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t226
  %t227 = call i8* @strip_prefix(i8* %t224, i8* %t225)
  store i8* %t227, i8** %l11
  %t228 = load i8*, i8** %l11
  %t229 = call i8* @malloc(i64 8)
  %t230 = bitcast i8* %t229 to [8 x i8]*
  store [8 x i8] c"struct \00", [8 x i8]* %t230
  %t231 = call i8* @strip_prefix(i8* %t228, i8* %t229)
  store i8* %t231, i8** %l12
  %t232 = load i8*, i8** %l12
  %t233 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t232)
  store %StructLayoutHeaderParse %t233, %StructLayoutHeaderParse* %l13
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t235 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t236 = extractvalue %StructLayoutHeaderParse %t235, 4
  %t237 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t234, { i8**, i64 }* %t236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l1
  %t238 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t239 = extractvalue %StructLayoutHeaderParse %t238, 0
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t242 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t243 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t244 = load double, double* %l4
  %t245 = load i8*, i8** %l5
  %t246 = load i8*, i8** %l6
  %t247 = load i8*, i8** %l11
  %t248 = load i8*, i8** %l12
  %t249 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  br i1 %t239, label %then27, label %merge28
then27:
  %t250 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t251 = ptrtoint [0 x %NativeStructLayoutField]* %t250 to i64
  %t252 = icmp eq i64 %t251, 0
  %t253 = select i1 %t252, i64 1, i64 %t251
  %t254 = call i8* @malloc(i64 %t253)
  %t255 = bitcast i8* %t254 to %NativeStructLayoutField*
  %t256 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t257 = ptrtoint { %NativeStructLayoutField*, i64 }* %t256 to i64
  %t258 = call i8* @malloc(i64 %t257)
  %t259 = bitcast i8* %t258 to { %NativeStructLayoutField*, i64 }*
  %t260 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t259, i32 0, i32 0
  store %NativeStructLayoutField* %t255, %NativeStructLayoutField** %t260
  %t261 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t259, i32 0, i32 1
  store i64 0, i64* %t261
  store { %NativeStructLayoutField*, i64 }* %t259, { %NativeStructLayoutField*, i64 }** %l14
  %t262 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t263 = extractvalue %StructLayoutHeaderParse %t262, 1
  store i8* %t263, i8** %l15
  %t264 = load double, double* %l4
  %t265 = sitofp i64 1 to double
  %t266 = fadd double %t264, %t265
  store double %t266, double* %l4
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t270 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t271 = load double, double* %l4
  %t272 = load i8*, i8** %l5
  %t273 = load i8*, i8** %l6
  %t274 = load i8*, i8** %l11
  %t275 = load i8*, i8** %l12
  %t276 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t277 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t278 = load i8*, i8** %l15
  br label %loop.header29
loop.header29:
  %t516 = phi double [ %t271, %then27 ], [ %t513, %loop.latch31 ]
  %t517 = phi { i8**, i64 }* [ %t268, %then27 ], [ %t514, %loop.latch31 ]
  %t518 = phi { %NativeStructLayoutField*, i64 }* [ %t277, %then27 ], [ %t515, %loop.latch31 ]
  store double %t516, double* %l4
  store { i8**, i64 }* %t517, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t518, { %NativeStructLayoutField*, i64 }** %l14
  br label %loop.body30
loop.body30:
  %t279 = load double, double* %l4
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load { i8**, i64 }, { i8**, i64 }* %t280
  %t282 = extractvalue { i8**, i64 } %t281, 1
  %t283 = sitofp i64 %t282 to double
  %t284 = fcmp oge double %t279, %t283
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t287 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t288 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t289 = load double, double* %l4
  %t290 = load i8*, i8** %l5
  %t291 = load i8*, i8** %l6
  %t292 = load i8*, i8** %l11
  %t293 = load i8*, i8** %l12
  %t294 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t295 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t296 = load i8*, i8** %l15
  br i1 %t284, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load double, double* %l4
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
  %t307 = call i8* @trim_text(i8* %t306)
  store i8* %t307, i8** %l16
  %t308 = load i8*, i8** %l16
  %t309 = call i64 @sailfin_runtime_string_length(i8* %t308)
  %t310 = icmp eq i64 %t309, 0
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t313 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t314 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t315 = load double, double* %l4
  %t316 = load i8*, i8** %l5
  %t317 = load i8*, i8** %l6
  %t318 = load i8*, i8** %l11
  %t319 = load i8*, i8** %l12
  %t320 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t321 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t322 = load i8*, i8** %l15
  %t323 = load i8*, i8** %l16
  br i1 %t310, label %then35, label %merge36
then35:
  %t324 = load double, double* %l4
  %t325 = sitofp i64 1 to double
  %t326 = fadd double %t324, %t325
  store double %t326, double* %l4
  br label %afterloop32
merge36:
  %t328 = load i8*, i8** %l16
  %t329 = call i8* @malloc(i64 16)
  %t330 = bitcast i8* %t329 to [16 x i8]*
  store [16 x i8] c".layout struct \00", [16 x i8]* %t330
  %t331 = call i1 @starts_with(i8* %t328, i8* %t329)
  br label %logical_or_entry_327

logical_or_entry_327:
  br i1 %t331, label %logical_or_merge_327, label %logical_or_right_327

logical_or_right_327:
  %t332 = load i8*, i8** %l16
  %t333 = call i8* @malloc(i64 14)
  %t334 = bitcast i8* %t333 to [14 x i8]*
  store [14 x i8] c".layout enum \00", [14 x i8]* %t334
  %t335 = call i1 @starts_with(i8* %t332, i8* %t333)
  br label %logical_or_right_end_327

logical_or_right_end_327:
  br label %logical_or_merge_327

logical_or_merge_327:
  %t336 = phi i1 [ true, %logical_or_entry_327 ], [ %t335, %logical_or_right_end_327 ]
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t339 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t340 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t341 = load double, double* %l4
  %t342 = load i8*, i8** %l5
  %t343 = load i8*, i8** %l6
  %t344 = load i8*, i8** %l11
  %t345 = load i8*, i8** %l12
  %t346 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t347 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t348 = load i8*, i8** %l15
  %t349 = load i8*, i8** %l16
  br i1 %t336, label %then37, label %merge38
then37:
  br label %afterloop32
merge38:
  %t350 = load i8*, i8** %l16
  %t351 = call i8* @malloc(i64 15)
  %t352 = bitcast i8* %t351 to [15 x i8]*
  store [15 x i8] c".layout field \00", [15 x i8]* %t352
  %t353 = call i1 @starts_with(i8* %t350, i8* %t351)
  %t354 = xor i1 %t353, 1
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t357 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t358 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t359 = load double, double* %l4
  %t360 = load i8*, i8** %l5
  %t361 = load i8*, i8** %l6
  %t362 = load i8*, i8** %l11
  %t363 = load i8*, i8** %l12
  %t364 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t365 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t366 = load i8*, i8** %l15
  %t367 = load i8*, i8** %l16
  br i1 %t354, label %then39, label %merge40
then39:
  br label %afterloop32
merge40:
  %t368 = load i8*, i8** %l16
  %t369 = call i8* @malloc(i64 15)
  %t370 = bitcast i8* %t369 to [15 x i8]*
  store [15 x i8] c".layout field \00", [15 x i8]* %t370
  %t371 = call i8* @strip_prefix(i8* %t368, i8* %t369)
  %t372 = call i8* @trim_text(i8* %t371)
  store i8* %t372, i8** %l17
  store i1 0, i1* %l18
  %t373 = load i8*, i8** %l17
  %t374 = call i8* @malloc(i64 7)
  %t375 = bitcast i8* %t374 to [7 x i8]*
  store [7 x i8] c"struct\00", [7 x i8]* %t375
  %t376 = call i1 @starts_with(i8* %t373, i8* %t374)
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t379 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t380 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t381 = load double, double* %l4
  %t382 = load i8*, i8** %l5
  %t383 = load i8*, i8** %l6
  %t384 = load i8*, i8** %l11
  %t385 = load i8*, i8** %l12
  %t386 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t387 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t388 = load i8*, i8** %l15
  %t389 = load i8*, i8** %l16
  %t390 = load i8*, i8** %l17
  %t391 = load i1, i1* %l18
  br i1 %t376, label %then41, label %merge42
then41:
  %t392 = load i8*, i8** %l17
  %t393 = call i64 @sailfin_runtime_string_length(i8* %t392)
  %t394 = icmp eq i64 %t393, 6
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t396 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t397 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t398 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t399 = load double, double* %l4
  %t400 = load i8*, i8** %l5
  %t401 = load i8*, i8** %l6
  %t402 = load i8*, i8** %l11
  %t403 = load i8*, i8** %l12
  %t404 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t405 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t406 = load i8*, i8** %l15
  %t407 = load i8*, i8** %l16
  %t408 = load i8*, i8** %l17
  %t409 = load i1, i1* %l18
  br i1 %t394, label %then43, label %else44
then43:
  store i1 1, i1* %l18
  %t410 = load i1, i1* %l18
  br label %merge45
else44:
  %t411 = load i8*, i8** %l17
  %t412 = call i64 @sailfin_runtime_string_length(i8* %t411)
  %t413 = icmp sgt i64 %t412, 6
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t416 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t417 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t418 = load double, double* %l4
  %t419 = load i8*, i8** %l5
  %t420 = load i8*, i8** %l6
  %t421 = load i8*, i8** %l11
  %t422 = load i8*, i8** %l12
  %t423 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t424 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t425 = load i8*, i8** %l15
  %t426 = load i8*, i8** %l16
  %t427 = load i8*, i8** %l17
  %t428 = load i1, i1* %l18
  br i1 %t413, label %then46, label %merge47
then46:
  %t429 = load i8*, i8** %l17
  %t430 = getelementptr i8, i8* %t429, i64 6
  %t431 = load i8, i8* %t430
  store i8 %t431, i8* %l19
  %t432 = load i8, i8* %l19
  %t433 = add i64 0, 2
  %t434 = call i8* @malloc(i64 %t433)
  store i8 %t432, i8* %t434
  %t435 = getelementptr i8, i8* %t434, i64 1
  store i8 0, i8* %t435
  call void @sailfin_runtime_mark_persistent(i8* %t434)
  %t436 = call i1 @is_trim_char(i8* %t434)
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t439 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t440 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t441 = load double, double* %l4
  %t442 = load i8*, i8** %l5
  %t443 = load i8*, i8** %l6
  %t444 = load i8*, i8** %l11
  %t445 = load i8*, i8** %l12
  %t446 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t447 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t448 = load i8*, i8** %l15
  %t449 = load i8*, i8** %l16
  %t450 = load i8*, i8** %l17
  %t451 = load i1, i1* %l18
  %t452 = load i8, i8* %l19
  br i1 %t436, label %then48, label %merge49
then48:
  store i1 1, i1* %l18
  %t453 = load i1, i1* %l18
  br label %merge49
merge49:
  %t454 = phi i1 [ %t453, %then48 ], [ %t451, %then46 ]
  store i1 %t454, i1* %l18
  %t455 = load i1, i1* %l18
  br label %merge47
merge47:
  %t456 = phi i1 [ %t455, %merge49 ], [ %t428, %else44 ]
  store i1 %t456, i1* %l18
  %t457 = load i1, i1* %l18
  br label %merge45
merge45:
  %t458 = phi i1 [ %t410, %then43 ], [ %t457, %merge47 ]
  store i1 %t458, i1* %l18
  %t459 = load i1, i1* %l18
  %t460 = load i1, i1* %l18
  br label %merge42
merge42:
  %t461 = phi i1 [ %t459, %merge45 ], [ %t391, %merge40 ]
  %t462 = phi i1 [ %t460, %merge45 ], [ %t391, %merge40 ]
  store i1 %t461, i1* %l18
  store i1 %t462, i1* %l18
  %t463 = load i1, i1* %l18
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t466 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t467 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t468 = load double, double* %l4
  %t469 = load i8*, i8** %l5
  %t470 = load i8*, i8** %l6
  %t471 = load i8*, i8** %l11
  %t472 = load i8*, i8** %l12
  %t473 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t474 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t475 = load i8*, i8** %l15
  %t476 = load i8*, i8** %l16
  %t477 = load i8*, i8** %l17
  %t478 = load i1, i1* %l18
  br i1 %t463, label %then50, label %merge51
then50:
  br label %afterloop32
merge51:
  %t479 = load i8*, i8** %l17
  %t480 = load i8*, i8** %l15
  %t481 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t479, i8* %t480)
  store %StructLayoutFieldParse %t481, %StructLayoutFieldParse* %l20
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t484 = extractvalue %StructLayoutFieldParse %t483, 2
  %t485 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t482, { i8**, i64 }* %t484)
  store { i8**, i64 }* %t485, { i8**, i64 }** %l1
  %t486 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t487 = extractvalue %StructLayoutFieldParse %t486, 0
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t490 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t491 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t492 = load double, double* %l4
  %t493 = load i8*, i8** %l5
  %t494 = load i8*, i8** %l6
  %t495 = load i8*, i8** %l11
  %t496 = load i8*, i8** %l12
  %t497 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t498 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t499 = load i8*, i8** %l15
  %t500 = load i8*, i8** %l16
  %t501 = load i8*, i8** %l17
  %t502 = load i1, i1* %l18
  %t503 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  br i1 %t487, label %then52, label %merge53
then52:
  %t504 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t505 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t506 = extractvalue %StructLayoutFieldParse %t505, 1
  %t507 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t504, %NativeStructLayoutField %t506)
  store { %NativeStructLayoutField*, i64 }* %t507, { %NativeStructLayoutField*, i64 }** %l14
  %t508 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  br label %merge53
merge53:
  %t509 = phi { %NativeStructLayoutField*, i64 }* [ %t508, %then52 ], [ %t498, %merge51 ]
  store { %NativeStructLayoutField*, i64 }* %t509, { %NativeStructLayoutField*, i64 }** %l14
  %t510 = load double, double* %l4
  %t511 = sitofp i64 1 to double
  %t512 = fadd double %t510, %t511
  store double %t512, double* %l4
  br label %loop.latch31
loop.latch31:
  %t513 = load double, double* %l4
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t515 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  br label %loop.header29
afterloop32:
  %t519 = load double, double* %l4
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t521 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t522 = load i8*, i8** %l15
  %t523 = insertvalue %NativeStruct undef, i8* %t522, 0
  %t524 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* null, i32 1
  %t525 = ptrtoint [0 x %NativeStructField]* %t524 to i64
  %t526 = icmp eq i64 %t525, 0
  %t527 = select i1 %t526, i64 1, i64 %t525
  %t528 = call i8* @malloc(i64 %t527)
  %t529 = bitcast i8* %t528 to %NativeStructField*
  %t530 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t531 = ptrtoint { %NativeStructField*, i64 }* %t530 to i64
  %t532 = call i8* @malloc(i64 %t531)
  %t533 = bitcast i8* %t532 to { %NativeStructField*, i64 }*
  %t534 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t533, i32 0, i32 0
  store %NativeStructField* %t529, %NativeStructField** %t534
  %t535 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t533, i32 0, i32 1
  store i64 0, i64* %t535
  %t536 = insertvalue %NativeStruct %t523, { %NativeStructField*, i64 }* %t533, 1
  %t537 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t538 = ptrtoint [0 x %NativeFunction]* %t537 to i64
  %t539 = icmp eq i64 %t538, 0
  %t540 = select i1 %t539, i64 1, i64 %t538
  %t541 = call i8* @malloc(i64 %t540)
  %t542 = bitcast i8* %t541 to %NativeFunction*
  %t543 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t544 = ptrtoint { %NativeFunction*, i64 }* %t543 to i64
  %t545 = call i8* @malloc(i64 %t544)
  %t546 = bitcast i8* %t545 to { %NativeFunction*, i64 }*
  %t547 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t546, i32 0, i32 0
  store %NativeFunction* %t542, %NativeFunction** %t547
  %t548 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t546, i32 0, i32 1
  store i64 0, i64* %t548
  %t549 = insertvalue %NativeStruct %t536, { %NativeFunction*, i64 }* %t546, 2
  %t550 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t551 = ptrtoint [0 x i8*]* %t550 to i64
  %t552 = icmp eq i64 %t551, 0
  %t553 = select i1 %t552, i64 1, i64 %t551
  %t554 = call i8* @malloc(i64 %t553)
  %t555 = bitcast i8* %t554 to i8**
  %t556 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t557 = ptrtoint { i8**, i64 }* %t556 to i64
  %t558 = call i8* @malloc(i64 %t557)
  %t559 = bitcast i8* %t558 to { i8**, i64 }*
  %t560 = getelementptr { i8**, i64 }, { i8**, i64 }* %t559, i32 0, i32 0
  store i8** %t555, i8*** %t560
  %t561 = getelementptr { i8**, i64 }, { i8**, i64 }* %t559, i32 0, i32 1
  store i64 0, i64* %t561
  %t562 = insertvalue %NativeStruct %t549, { i8**, i64 }* %t559, 3
  %t563 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t564 = extractvalue %StructLayoutHeaderParse %t563, 2
  %t565 = insertvalue %NativeStructLayout undef, double %t564, 0
  %t566 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l13
  %t567 = extractvalue %StructLayoutHeaderParse %t566, 3
  %t568 = insertvalue %NativeStructLayout %t565, double %t567, 1
  %t569 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l14
  %t570 = insertvalue %NativeStructLayout %t568, { %NativeStructLayoutField*, i64 }* %t569, 2
  %t571 = getelementptr %NativeStructLayout, %NativeStructLayout* null, i32 1
  %t572 = ptrtoint %NativeStructLayout* %t571 to i64
  %t573 = call noalias i8* @malloc(i64 %t572)
  %t574 = bitcast i8* %t573 to %NativeStructLayout*
  store %NativeStructLayout %t570, %NativeStructLayout* %t574
  call void @sailfin_runtime_mark_persistent(i8* %t573)
  %t575 = insertvalue %NativeStruct %t562, %NativeStructLayout* %t574, 4
  store %NativeStruct %t575, %NativeStruct* %l21
  %t576 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t577 = load %NativeStruct, %NativeStruct* %l21
  %t578 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t576, %NativeStruct %t577)
  store { %NativeStruct*, i64 }* %t578, { %NativeStruct*, i64 }** %l2
  %t579 = load double, double* %l4
  %t580 = load double, double* %l4
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t582 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  br label %merge28
merge28:
  %t583 = phi double [ %t579, %afterloop32 ], [ %t244, %then25 ]
  %t584 = phi double [ %t580, %afterloop32 ], [ %t244, %then25 ]
  %t585 = phi { i8**, i64 }* [ %t581, %afterloop32 ], [ %t241, %then25 ]
  %t586 = phi { %NativeStruct*, i64 }* [ %t582, %afterloop32 ], [ %t242, %then25 ]
  store double %t583, double* %l4
  store double %t584, double* %l4
  store { i8**, i64 }* %t585, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t586, { %NativeStruct*, i64 }** %l2
  br label %loop.latch2
merge26:
  %t587 = load i8*, i8** %l6
  %t588 = call i8* @malloc(i64 14)
  %t589 = bitcast i8* %t588 to [14 x i8]*
  store [14 x i8] c".layout enum \00", [14 x i8]* %t589
  %t590 = call i1 @starts_with(i8* %t587, i8* %t588)
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t594 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t595 = load double, double* %l4
  %t596 = load i8*, i8** %l5
  %t597 = load i8*, i8** %l6
  br i1 %t590, label %then54, label %merge55
then54:
  %t598 = load i8*, i8** %l6
  %t599 = call i8* @malloc(i64 9)
  %t600 = bitcast i8* %t599 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t600
  %t601 = call i8* @strip_prefix(i8* %t598, i8* %t599)
  store i8* %t601, i8** %l22
  %t602 = load i8*, i8** %l22
  %t603 = call i8* @malloc(i64 6)
  %t604 = bitcast i8* %t603 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t604
  %t605 = call i8* @strip_prefix(i8* %t602, i8* %t603)
  store i8* %t605, i8** %l23
  %t606 = load i8*, i8** %l23
  %t607 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t606)
  store %EnumLayoutHeaderParse %t607, %EnumLayoutHeaderParse* %l24
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t609 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t610 = extractvalue %EnumLayoutHeaderParse %t609, 7
  %t611 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t608, { i8**, i64 }* %t610)
  store { i8**, i64 }* %t611, { i8**, i64 }** %l1
  %t612 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t613 = extractvalue %EnumLayoutHeaderParse %t612, 0
  %t614 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t616 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t617 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t618 = load double, double* %l4
  %t619 = load i8*, i8** %l5
  %t620 = load i8*, i8** %l6
  %t621 = load i8*, i8** %l22
  %t622 = load i8*, i8** %l23
  %t623 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  br i1 %t613, label %then56, label %else57
then56:
  %t624 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t625 = ptrtoint [0 x %NativeEnumVariantLayout]* %t624 to i64
  %t626 = icmp eq i64 %t625, 0
  %t627 = select i1 %t626, i64 1, i64 %t625
  %t628 = call i8* @malloc(i64 %t627)
  %t629 = bitcast i8* %t628 to %NativeEnumVariantLayout*
  %t630 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t631 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t630 to i64
  %t632 = call i8* @malloc(i64 %t631)
  %t633 = bitcast i8* %t632 to { %NativeEnumVariantLayout*, i64 }*
  %t634 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t633, i32 0, i32 0
  store %NativeEnumVariantLayout* %t629, %NativeEnumVariantLayout** %t634
  %t635 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t633, i32 0, i32 1
  store i64 0, i64* %t635
  store { %NativeEnumVariantLayout*, i64 }* %t633, { %NativeEnumVariantLayout*, i64 }** %l25
  %t636 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t637 = extractvalue %EnumLayoutHeaderParse %t636, 1
  store i8* %t637, i8** %l26
  %t638 = load double, double* %l4
  %t639 = sitofp i64 1 to double
  %t640 = fadd double %t638, %t639
  store double %t640, double* %l4
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t642 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t643 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t644 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t645 = load double, double* %l4
  %t646 = load i8*, i8** %l5
  %t647 = load i8*, i8** %l6
  %t648 = load i8*, i8** %l22
  %t649 = load i8*, i8** %l23
  %t650 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t651 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t652 = load i8*, i8** %l26
  br label %loop.header59
loop.header59:
  %t920 = phi double [ %t645, %then56 ], [ %t916, %loop.latch61 ]
  %t921 = phi i8* [ %t648, %then56 ], [ %t917, %loop.latch61 ]
  %t922 = phi { i8**, i64 }* [ %t642, %then56 ], [ %t918, %loop.latch61 ]
  %t923 = phi { %NativeEnumVariantLayout*, i64 }* [ %t651, %then56 ], [ %t919, %loop.latch61 ]
  store double %t920, double* %l4
  store i8* %t921, i8** %l22
  store { i8**, i64 }* %t922, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t923, { %NativeEnumVariantLayout*, i64 }** %l25
  br label %loop.body60
loop.body60:
  %t653 = load double, double* %l4
  %t654 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t655 = load { i8**, i64 }, { i8**, i64 }* %t654
  %t656 = extractvalue { i8**, i64 } %t655, 1
  %t657 = sitofp i64 %t656 to double
  %t658 = fcmp oge double %t653, %t657
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t661 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t662 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t663 = load double, double* %l4
  %t664 = load i8*, i8** %l5
  %t665 = load i8*, i8** %l6
  %t666 = load i8*, i8** %l22
  %t667 = load i8*, i8** %l23
  %t668 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t669 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t670 = load i8*, i8** %l26
  br i1 %t658, label %then63, label %merge64
then63:
  br label %afterloop62
merge64:
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t672 = load double, double* %l4
  %t673 = call double @llvm.round.f64(double %t672)
  %t674 = fptosi double %t673 to i64
  %t675 = load { i8**, i64 }, { i8**, i64 }* %t671
  %t676 = extractvalue { i8**, i64 } %t675, 0
  %t677 = extractvalue { i8**, i64 } %t675, 1
  %t678 = icmp uge i64 %t674, %t677
  ; bounds check: %t678 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t674, i64 %t677)
  %t679 = getelementptr i8*, i8** %t676, i64 %t674
  %t680 = load i8*, i8** %t679
  %t681 = call i8* @trim_text(i8* %t680)
  store i8* %t681, i8** %l27
  %t682 = load i8*, i8** %l27
  %t683 = call i64 @sailfin_runtime_string_length(i8* %t682)
  %t684 = icmp eq i64 %t683, 0
  %t685 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t686 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t687 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t688 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t689 = load double, double* %l4
  %t690 = load i8*, i8** %l5
  %t691 = load i8*, i8** %l6
  %t692 = load i8*, i8** %l22
  %t693 = load i8*, i8** %l23
  %t694 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t695 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t696 = load i8*, i8** %l26
  %t697 = load i8*, i8** %l27
  br i1 %t684, label %then65, label %merge66
then65:
  %t698 = load double, double* %l4
  %t699 = sitofp i64 1 to double
  %t700 = fadd double %t698, %t699
  store double %t700, double* %l4
  br label %afterloop62
merge66:
  %t702 = load i8*, i8** %l27
  %t703 = call i8* @malloc(i64 17)
  %t704 = bitcast i8* %t703 to [17 x i8]*
  store [17 x i8] c".layout variant \00", [17 x i8]* %t704
  %t705 = call i1 @starts_with(i8* %t702, i8* %t703)
  %t706 = xor i1 %t705, 1
  br label %logical_and_entry_701

logical_and_entry_701:
  br i1 %t706, label %logical_and_right_701, label %logical_and_merge_701

logical_and_right_701:
  %t707 = load i8*, i8** %l27
  %t708 = call i8* @malloc(i64 17)
  %t709 = bitcast i8* %t708 to [17 x i8]*
  store [17 x i8] c".layout payload \00", [17 x i8]* %t709
  %t710 = call i1 @starts_with(i8* %t707, i8* %t708)
  %t711 = xor i1 %t710, 1
  br label %logical_and_right_end_701

logical_and_right_end_701:
  br label %logical_and_merge_701

logical_and_merge_701:
  %t712 = phi i1 [ false, %logical_and_entry_701 ], [ %t711, %logical_and_right_end_701 ]
  %t713 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t714 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t715 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t716 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t717 = load double, double* %l4
  %t718 = load i8*, i8** %l5
  %t719 = load i8*, i8** %l6
  %t720 = load i8*, i8** %l22
  %t721 = load i8*, i8** %l23
  %t722 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t723 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t724 = load i8*, i8** %l26
  %t725 = load i8*, i8** %l27
  br i1 %t712, label %then67, label %merge68
then67:
  br label %afterloop62
merge68:
  %t726 = load i8*, i8** %l27
  %t727 = call i8* @malloc(i64 17)
  %t728 = bitcast i8* %t727 to [17 x i8]*
  store [17 x i8] c".layout variant \00", [17 x i8]* %t728
  %t729 = call i1 @starts_with(i8* %t726, i8* %t727)
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t731 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t732 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t733 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t734 = load double, double* %l4
  %t735 = load i8*, i8** %l5
  %t736 = load i8*, i8** %l6
  %t737 = load i8*, i8** %l22
  %t738 = load i8*, i8** %l23
  %t739 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t740 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t741 = load i8*, i8** %l26
  %t742 = load i8*, i8** %l27
  br i1 %t729, label %then69, label %else70
then69:
  %t743 = load i8*, i8** %l27
  %t744 = call i8* @malloc(i64 9)
  %t745 = bitcast i8* %t744 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t745
  %t746 = call i8* @strip_prefix(i8* %t743, i8* %t744)
  store i8* %t746, i8** %l28
  %t747 = load i8*, i8** %l22
  %t748 = call i8* @malloc(i64 9)
  %t749 = bitcast i8* %t748 to [9 x i8]*
  store [9 x i8] c"variant \00", [9 x i8]* %t749
  %t750 = call i8* @strip_prefix(i8* %t747, i8* %t748)
  store i8* %t750, i8** %l29
  %t751 = load i8*, i8** %l29
  %t752 = call i8* @malloc(i64 6)
  %t753 = bitcast i8* %t752 to [6 x i8]*
  store [6 x i8] c"enum \00", [6 x i8]* %t753
  %t754 = call i1 @starts_with(i8* %t751, i8* %t752)
  %t755 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t756 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t757 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t758 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t759 = load double, double* %l4
  %t760 = load i8*, i8** %l5
  %t761 = load i8*, i8** %l6
  %t762 = load i8*, i8** %l22
  %t763 = load i8*, i8** %l23
  %t764 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t765 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t766 = load i8*, i8** %l26
  %t767 = load i8*, i8** %l27
  %t768 = load i8*, i8** %l28
  %t769 = load i8*, i8** %l29
  br i1 %t754, label %then72, label %merge73
then72:
  %t770 = load double, double* %l4
  %t771 = sitofp i64 1 to double
  %t772 = fadd double %t770, %t771
  store double %t772, double* %l4
  br label %loop.latch61
merge73:
  %t773 = load i8*, i8** %l29
  %t774 = load i8*, i8** %l26
  %t775 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t773, i8* %t774)
  store %EnumLayoutVariantParse %t775, %EnumLayoutVariantParse* %l30
  %t776 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t777 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l30
  %t778 = extractvalue %EnumLayoutVariantParse %t777, 2
  %t779 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t776, { i8**, i64 }* %t778)
  store { i8**, i64 }* %t779, { i8**, i64 }** %l1
  %t780 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l30
  %t781 = extractvalue %EnumLayoutVariantParse %t780, 0
  %t782 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t784 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t785 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t786 = load double, double* %l4
  %t787 = load i8*, i8** %l5
  %t788 = load i8*, i8** %l6
  %t789 = load i8*, i8** %l22
  %t790 = load i8*, i8** %l23
  %t791 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t792 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t793 = load i8*, i8** %l26
  %t794 = load i8*, i8** %l27
  %t795 = load i8*, i8** %l28
  %t796 = load i8*, i8** %l29
  %t797 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l30
  br i1 %t781, label %then74, label %merge75
then74:
  %t798 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t799 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l30
  %t800 = extractvalue %EnumLayoutVariantParse %t799, 1
  %t801 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t798, %NativeEnumVariantLayout %t800)
  store { %NativeEnumVariantLayout*, i64 }* %t801, { %NativeEnumVariantLayout*, i64 }** %l25
  %t802 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  br label %merge75
merge75:
  %t803 = phi { %NativeEnumVariantLayout*, i64 }* [ %t802, %then74 ], [ %t792, %merge73 ]
  store { %NativeEnumVariantLayout*, i64 }* %t803, { %NativeEnumVariantLayout*, i64 }** %l25
  %t804 = load i8*, i8** %l22
  %t805 = load double, double* %l4
  %t806 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t807 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  br label %merge71
else70:
  %t808 = load i8*, i8** %l27
  %t809 = call i8* @malloc(i64 17)
  %t810 = bitcast i8* %t809 to [17 x i8]*
  store [17 x i8] c".layout payload \00", [17 x i8]* %t810
  %t811 = call i1 @starts_with(i8* %t808, i8* %t809)
  %t812 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t813 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t814 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t815 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t816 = load double, double* %l4
  %t817 = load i8*, i8** %l5
  %t818 = load i8*, i8** %l6
  %t819 = load i8*, i8** %l22
  %t820 = load i8*, i8** %l23
  %t821 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t822 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t823 = load i8*, i8** %l26
  %t824 = load i8*, i8** %l27
  br i1 %t811, label %then76, label %merge77
then76:
  %t825 = load i8*, i8** %l27
  %t826 = call i8* @malloc(i64 9)
  %t827 = bitcast i8* %t826 to [9 x i8]*
  store [9 x i8] c".layout \00", [9 x i8]* %t827
  %t828 = call i8* @strip_prefix(i8* %t825, i8* %t826)
  store i8* %t828, i8** %l31
  %t829 = load i8*, i8** %l22
  %t830 = call i8* @malloc(i64 9)
  %t831 = bitcast i8* %t830 to [9 x i8]*
  store [9 x i8] c"payload \00", [9 x i8]* %t831
  %t832 = call i8* @strip_prefix(i8* %t829, i8* %t830)
  store i8* %t832, i8** %l32
  %t833 = load i8*, i8** %l32
  %t834 = load i8*, i8** %l26
  %t835 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t833, i8* %t834)
  store %EnumLayoutPayloadParse %t835, %EnumLayoutPayloadParse* %l33
  %t836 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t837 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l33
  %t838 = extractvalue %EnumLayoutPayloadParse %t837, 3
  %t839 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t836, { i8**, i64 }* %t838)
  store { i8**, i64 }* %t839, { i8**, i64 }** %l1
  %t841 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l33
  %t842 = extractvalue %EnumLayoutPayloadParse %t841, 0
  br label %logical_and_entry_840

logical_and_entry_840:
  br i1 %t842, label %logical_and_right_840, label %logical_and_merge_840

logical_and_right_840:
  %t843 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t844 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t843
  %t845 = extractvalue { %NativeEnumVariantLayout*, i64 } %t844, 1
  %t846 = icmp sgt i64 %t845, 0
  br label %logical_and_right_end_840

logical_and_right_end_840:
  br label %logical_and_merge_840

logical_and_merge_840:
  %t847 = phi i1 [ false, %logical_and_entry_840 ], [ %t846, %logical_and_right_end_840 ]
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t849 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t850 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t851 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t852 = load double, double* %l4
  %t853 = load i8*, i8** %l5
  %t854 = load i8*, i8** %l6
  %t855 = load i8*, i8** %l22
  %t856 = load i8*, i8** %l23
  %t857 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t858 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t859 = load i8*, i8** %l26
  %t860 = load i8*, i8** %l27
  %t861 = load i8*, i8** %l31
  %t862 = load i8*, i8** %l32
  %t863 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l33
  br i1 %t847, label %then78, label %merge79
then78:
  %t864 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t865 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t864
  %t866 = extractvalue { %NativeEnumVariantLayout*, i64 } %t865, 1
  %t867 = sub i64 %t866, 1
  store i64 %t867, i64* %l34
  %t868 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t869 = load i64, i64* %l34
  %t870 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t868
  %t871 = extractvalue { %NativeEnumVariantLayout*, i64 } %t870, 0
  %t872 = extractvalue { %NativeEnumVariantLayout*, i64 } %t870, 1
  %t873 = icmp uge i64 %t869, %t872
  ; bounds check: %t873 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t869, i64 %t872)
  %t874 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t871, i64 %t869
  %t875 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t874
  store %NativeEnumVariantLayout %t875, %NativeEnumVariantLayout* %l35
  %t876 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l35
  %t877 = extractvalue %NativeEnumVariantLayout %t876, 5
  %t878 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l33
  %t879 = extractvalue %EnumLayoutPayloadParse %t878, 2
  %t880 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t877, %NativeStructLayoutField %t879)
  store { %NativeStructLayoutField*, i64 }* %t880, { %NativeStructLayoutField*, i64 }** %l36
  %t881 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l35
  %t882 = extractvalue %NativeEnumVariantLayout %t881, 0
  %t883 = insertvalue %NativeEnumVariantLayout undef, i8* %t882, 0
  %t884 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l35
  %t885 = extractvalue %NativeEnumVariantLayout %t884, 1
  %t886 = insertvalue %NativeEnumVariantLayout %t883, double %t885, 1
  %t887 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l35
  %t888 = extractvalue %NativeEnumVariantLayout %t887, 2
  %t889 = insertvalue %NativeEnumVariantLayout %t886, double %t888, 2
  %t890 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l35
  %t891 = extractvalue %NativeEnumVariantLayout %t890, 3
  %t892 = insertvalue %NativeEnumVariantLayout %t889, double %t891, 3
  %t893 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l35
  %t894 = extractvalue %NativeEnumVariantLayout %t893, 4
  %t895 = insertvalue %NativeEnumVariantLayout %t892, double %t894, 4
  %t896 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l36
  %t897 = insertvalue %NativeEnumVariantLayout %t895, { %NativeStructLayoutField*, i64 }* %t896, 5
  %t898 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t899 = load i64, i64* %l34
  %t900 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t898, i32 0, i32 0
  %t902 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t900
  %t901 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t902, i64 %t899
  store %NativeEnumVariantLayout %t897, %NativeEnumVariantLayout* %t901
  br label %merge79
merge79:
  %t903 = load i8*, i8** %l22
  %t904 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge77
merge77:
  %t905 = phi i8* [ %t903, %merge79 ], [ %t819, %else70 ]
  %t906 = phi { i8**, i64 }* [ %t904, %merge79 ], [ %t813, %else70 ]
  store i8* %t905, i8** %l22
  store { i8**, i64 }* %t906, { i8**, i64 }** %l1
  %t907 = load i8*, i8** %l22
  %t908 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge71
merge71:
  %t909 = phi i8* [ %t804, %merge75 ], [ %t907, %merge77 ]
  %t910 = phi double [ %t805, %merge75 ], [ %t734, %merge77 ]
  %t911 = phi { i8**, i64 }* [ %t806, %merge75 ], [ %t908, %merge77 ]
  %t912 = phi { %NativeEnumVariantLayout*, i64 }* [ %t807, %merge75 ], [ %t740, %merge77 ]
  store i8* %t909, i8** %l22
  store double %t910, double* %l4
  store { i8**, i64 }* %t911, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t912, { %NativeEnumVariantLayout*, i64 }** %l25
  %t913 = load double, double* %l4
  %t914 = sitofp i64 1 to double
  %t915 = fadd double %t913, %t914
  store double %t915, double* %l4
  br label %loop.latch61
loop.latch61:
  %t916 = load double, double* %l4
  %t917 = load i8*, i8** %l22
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t919 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  br label %loop.header59
afterloop62:
  %t924 = load double, double* %l4
  %t925 = load i8*, i8** %l22
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t927 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t928 = load i8*, i8** %l26
  %t929 = insertvalue %NativeEnum undef, i8* %t928, 0
  %t930 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t931 = ptrtoint [0 x %NativeEnumVariant]* %t930 to i64
  %t932 = icmp eq i64 %t931, 0
  %t933 = select i1 %t932, i64 1, i64 %t931
  %t934 = call i8* @malloc(i64 %t933)
  %t935 = bitcast i8* %t934 to %NativeEnumVariant*
  %t936 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t937 = ptrtoint { %NativeEnumVariant*, i64 }* %t936 to i64
  %t938 = call i8* @malloc(i64 %t937)
  %t939 = bitcast i8* %t938 to { %NativeEnumVariant*, i64 }*
  %t940 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t939, i32 0, i32 0
  store %NativeEnumVariant* %t935, %NativeEnumVariant** %t940
  %t941 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t939, i32 0, i32 1
  store i64 0, i64* %t941
  %t942 = insertvalue %NativeEnum %t929, { %NativeEnumVariant*, i64 }* %t939, 1
  %t943 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t944 = extractvalue %EnumLayoutHeaderParse %t943, 2
  %t945 = insertvalue %NativeEnumLayout undef, double %t944, 0
  %t946 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t947 = extractvalue %EnumLayoutHeaderParse %t946, 3
  %t948 = insertvalue %NativeEnumLayout %t945, double %t947, 1
  %t949 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t950 = extractvalue %EnumLayoutHeaderParse %t949, 4
  %t951 = insertvalue %NativeEnumLayout %t948, i8* %t950, 2
  %t952 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t953 = extractvalue %EnumLayoutHeaderParse %t952, 5
  %t954 = insertvalue %NativeEnumLayout %t951, double %t953, 3
  %t955 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l24
  %t956 = extractvalue %EnumLayoutHeaderParse %t955, 6
  %t957 = insertvalue %NativeEnumLayout %t954, double %t956, 4
  %t958 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l25
  %t959 = insertvalue %NativeEnumLayout %t957, { %NativeEnumVariantLayout*, i64 }* %t958, 5
  %t960 = getelementptr %NativeEnumLayout, %NativeEnumLayout* null, i32 1
  %t961 = ptrtoint %NativeEnumLayout* %t960 to i64
  %t962 = call noalias i8* @malloc(i64 %t961)
  %t963 = bitcast i8* %t962 to %NativeEnumLayout*
  store %NativeEnumLayout %t959, %NativeEnumLayout* %t963
  call void @sailfin_runtime_mark_persistent(i8* %t962)
  %t964 = insertvalue %NativeEnum %t942, %NativeEnumLayout* %t963, 2
  store %NativeEnum %t964, %NativeEnum* %l37
  %t965 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t966 = load %NativeEnum, %NativeEnum* %l37
  %t967 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t965, %NativeEnum %t966)
  store { %NativeEnum*, i64 }* %t967, { %NativeEnum*, i64 }** %l3
  %t968 = load double, double* %l4
  %t969 = load double, double* %l4
  %t970 = load i8*, i8** %l22
  %t971 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t972 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %merge58
else57:
  %t973 = load double, double* %l4
  %t974 = sitofp i64 1 to double
  %t975 = fadd double %t973, %t974
  store double %t975, double* %l4
  %t976 = load double, double* %l4
  br label %merge58
merge58:
  %t977 = phi double [ %t968, %afterloop62 ], [ %t976, %else57 ]
  %t978 = phi i8* [ %t970, %afterloop62 ], [ %t621, %else57 ]
  %t979 = phi { i8**, i64 }* [ %t971, %afterloop62 ], [ %t615, %else57 ]
  %t980 = phi { %NativeEnum*, i64 }* [ %t972, %afterloop62 ], [ %t617, %else57 ]
  store double %t977, double* %l4
  store i8* %t978, i8** %l22
  store { i8**, i64 }* %t979, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t980, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge55:
  %t981 = load double, double* %l4
  %t982 = sitofp i64 1 to double
  %t983 = fadd double %t981, %t982
  store double %t983, double* %l4
  br label %loop.latch2
loop.latch2:
  %t984 = load double, double* %l4
  %t985 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t986 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t987 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t992 = load double, double* %l4
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t994 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t995 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t996 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t997 = insertvalue %LayoutManifest undef, { %NativeStruct*, i64 }* %t996, 0
  %t998 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t999 = insertvalue %LayoutManifest %t997, { %NativeEnum*, i64 }* %t998, 1
  %t1000 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1001 = insertvalue %LayoutManifest %t999, { i8**, i64 }* %t1000, 2
  ret %LayoutManifest %t1001
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
  %t101 = call i8* @malloc(i64 1)
  %t102 = bitcast i8* %t101 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t102
  %t103 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* %t101)
  store { i8**, i64 }* %t103, { i8**, i64 }** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge14
merge14:
  %t105 = phi { i8**, i64 }* [ %t104, %then13 ], [ %t97, %else11 ]
  store { i8**, i64 }* %t105, { i8**, i64 }** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
merge12:
  %t107 = phi { i8**, i64 }* [ %t92, %then10 ], [ %t106, %merge14 ]
  store { i8**, i64 }* %t107, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t108
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