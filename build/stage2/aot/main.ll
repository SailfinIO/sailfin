; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type opaque
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { %CompiledModule*, { %ModuleDiagnostics*, i64 }* }
%ProjectCompilation = type { { %CompiledModule*, i64 }*, { %ModuleDiagnostics*, i64 }* }
%LLVMCompilationResult = type { i8*, i8* }
%Parser = type { { %Token*, i64 }*, double }
%StatementParseResult = type { %Parser, %Statement }
%ParameterParseResult = type { %Parser, %Parameter }
%ParameterListParseResult = type { %Parser, { %Parameter*, i64 }* }
%StructFieldParseResult = type { %Parser, %FieldDeclaration*, i1 }
%ModelPropertyParseResult = type { %Parser, %ModelProperty*, i1 }
%MethodParseResult = type { %Parser, %MethodDeclaration*, i1 }
%InterfaceMemberParseResult = type { %Parser, %FunctionSignature*, i1 }
%SpecifierListParseResult = type { %Parser, { %NamedSpecifier*, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { %Parser, %EnumVariant*, i1 }
%TypeParameterParseResult = type { %Parser, { %TypeParameter*, i64 }* }
%ImplementsParseResult = type { %Parser, { %TypeAnnotation*, i64 }*, i1 }
%DecoratorParseResult = type { %Parser, { %Decorator*, i64 }* }
%BlockStatementParseResult = type { %Parser, %Statement*, i1 }
%ParenthesizedParseResult = type { %Parser, { %Token*, i64 }*, i1 }
%MatchCasesParseResult = type { %Parser, { %MatchCase*, i64 }*, i1 }
%MatchCaseParseResult = type { %Parser, %MatchCase*, i1 }
%MatchCaseTokenSplit = type { { %Token*, i64 }*, { %Token*, i64 }*, i1 }
%ExpressionTokens = type { { %Token*, i64 }*, double }
%ExpressionParseResult = type { %ExpressionTokens, %Expression, i1 }
%LambdaParameterParseResult = type { %ExpressionTokens, %Parameter, i1 }
%LambdaParameterListParseResult = type { %ExpressionTokens, { %Parameter*, i64 }*, i1 }
%ExpressionCollectResult = type { %ExpressionTokens, { %Token*, i64 }*, i1 }
%ExpressionBlockParseResult = type { %ExpressionTokens, { %Token*, i64 }*, i1 }
%CallArgumentsParseResult = type { %ExpressionTokens, { %Expression*, i64 }*, i1 }
%ArrayLiteralParseResult = type { %ExpressionTokens, { %Expression*, i64 }*, i1 }
%ObjectLiteralParseResult = type { %ExpressionTokens, { %ObjectField*, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { %Parser, { %Token*, i64 }* }
%EffectParseResult = type { %Parser, { i8**, i64 }* }
%BlockParseResult = type { %Parser, %Block }
%ExpressionTypeSeparatorParseResult = type { %ExpressionTokens, i8*, i1 }
%TypeSeparatorParseResult = type { %Parser, i1 }
%PatternCaptureResult = type { %Parser, { %Token*, i64 }*, i1 }
%Program = type { { %Statement*, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, %TypeAnnotation*, %SourceSpan* }
%Block = type { { %Token*, i64 }*, i8*, { %Statement*, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, %TypeAnnotation*, %Expression*, i1, %SourceSpan* }
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token*, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration*, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter*, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter*, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator*, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator*, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty*, i64 }*, { i8**, i64 }*, { %Decorator*, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument*, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact*, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
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
%EnumLayoutFixupResult = type { { %NativeEnum*, i64 }*, { i8**, i64 }* }
%TraitImplementationDescriptor = type { i8*, { i8**, i64 }* }
%TraitDescriptor = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature*, i64 }* }
%TraitMetadata = type { { %TraitDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }* }
%FunctionEffectEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifestEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifest = type { { %CapabilityManifestEntry*, i64 }* }
%RuntimeHelperDescriptor = type { i8*, i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%FunctionCallEntry = type { i8*, { i8**, i64 }* }
%StringConstant = type { i8*, i8*, double }
%StringPointerResult = type { { i8**, i64 }*, double, i8* }
%InterpolatedTemplateParse = type { { i8**, i64 }*, { i8**, i64 }*, i1 }
%LoweredLLVMResult = type { i8*, { i8**, i64 }*, %TraitMetadata, { %FunctionEffectEntry*, i64 }*, { %LifetimeRegionMetadata*, i64 }*, %CapabilityManifest, { %StringConstant*, i64 }* }
%LayoutManifestApplication = type { { %NativeStruct*, i64 }*, { %NativeEnum*, i64 }*, { i8**, i64 }* }
%ImportedModuleContext = type { { %LayoutManifest*, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%LoweredLLVMFunction = type { { i8**, i64 }*, { i8**, i64 }*, { %LifetimeRegionMetadata*, i64 }*, { %StringConstant*, i64 }* }
%BodyResult = type { { i8**, i64 }*, { i8**, i64 }*, { %LifetimeRegionMetadata*, i64 }*, { %StringConstant*, i64 }* }
%ParameterBinding = type { i8*, i8*, i8*, i8*, i1, %NativeSourceSpan* }
%ParameterPreparation = type { { i8**, i64 }*, { %ParameterBinding*, i64 }*, { i8**, i64 }* }
%LLVMOperand = type { i8*, i8* }
%ExpressionResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, { %StringConstant*, i64 }* }
%ArrayLiteralMetadata = type { i8*, double }
%OwnershipInfo = type { i8*, i8*, i1, %NativeSourceSpan*, double }
%OwnershipConsumption = type { i8*, i8* }
%LifetimeRegionMetadata = type { double, i8*, i8*, i1, %NativeSourceSpan*, i8*, double, i8*, double, i8*, double, i1 }
%LifetimeReleaseEvent = type { double, i8*, double }
%ScopeMetadata = type { i8*, double }
%StructFieldInfo = type { i8*, i8*, double, double }
%StructTypeInfo = type { i8*, i8*, { %StructFieldInfo*, i64 }*, double, double }
%EnumVariantInfo = type { i8*, double, double, double, double, { %StructFieldInfo*, i64 }* }
%EnumTypeInfo = type { i8*, i8*, i8*, double, double, double, double, { %EnumVariantInfo*, i64 }* }
%VTableEntry = type { i8*, i8*, i8* }
%VTableInfo = type { i8*, i8*, i8*, i8*, { %VTableEntry*, i64 }* }
%InterfaceTypeInfo = type { i8*, i8*, { i8**, i64 }*, { %NativeInterfaceSignature*, i64 }* }
%TypeContext = type { { %StructTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }*, { %VTableInfo*, i64 }* }
%TypeContextBuild = type { %TypeContext, { i8**, i64 }* }
%TypeAllocationInfo = type { i8*, double, double }
%HeapBoxResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
%StructLiteralField = type { i8*, i8* }
%StructLiteralParse = type { i1, i1, i8*, { %StructLiteralField*, i64 }*, { i8**, i64 }* }
%EnumLiteralParse = type { i1, i1, i8*, i8*, { %StructLiteralField*, i64 }*, { i8**, i64 }* }
%MemberAccessParse = type { i1, i8*, i8* }
%IndexExpressionParse = type { i1, i8*, i8* }
%LocalBinding = type { i8*, i8*, i8*, i8*, %OwnershipInfo*, i1, i8*, double }
%LocalMutation = type { i8*, i8*, i8*, %NativeSourceSpan*, i8* }
%OwnershipAnalysis = type { %OwnershipInfo*, %OwnershipConsumption*, { i8**, i64 }* }
%OperatorMatch = type { double, i8*, i1 }
%AssignmentParseResult = type { i1, i8*, i8*, i8* }
%BorrowParseResult = type { i1, i1, i8*, i1, { i8**, i64 }* }
%BorrowArgumentParse = type { i1, i8*, { i8**, i64 }* }
%TernaryParseResult = type { i1, i8*, i8*, i8*, { i8**, i64 }* }
%ExpressionStatementResult = type { { i8**, i64 }*, double, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*, { i8**, i64 }*, { %LifetimeRegionMetadata*, i64 }*, { %LifetimeReleaseEvent*, i64 }*, double, { %LocalMutation*, i64 }*, { %StringConstant*, i64 }* }
%LetLoweringResult = type { { i8**, i64 }*, { i8**, i64 }*, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*, double, { i8**, i64 }*, double, { %LifetimeRegionMetadata*, i64 }*, double, { %LocalMutation*, i64 }*, { %StringConstant*, i64 }* }
%InlineLetParseResult = type { i1, i8*, i1, i8*, i8*, { i8**, i64 }* }
%BlockLabelResult = type { i8*, double }
%IfStructure = type { double, double, double, double, i1, double, { i8**, i64 }* }
%LoopContext = type { i8*, i8* }
%LoopStructure = type { double, double, double, { i8**, i64 }* }
%RangeIterableParse = type { i1, i8*, i8*, i8*, { i8**, i64 }* }
%MatchCaseStructure = type { i8*, i8*, double, double, i1 }
%MatchStructure = type { { %MatchCaseStructure*, i64 }*, double, { i8**, i64 }* }
%MatchFieldBinding = type { i8*, i8*, double }
%MatchCaseCondition = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, i1, { %MatchFieldBinding*, i64 }*, %EnumTypeInfo*, %EnumVariantInfo*, { %StringConstant*, i64 }* }
%ConditionConversion = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, { %StringConstant*, i64 }* }
%ComparisonEmission = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
%CoercionResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
%BinaryAlignmentResult = type { { i8**, i64 }*, double, %LLVMOperand*, %LLVMOperand*, { i8**, i64 }*, i8* }
%BlockLoweringResult = type { { i8**, i64 }*, { i8**, i64 }*, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*, double, double, { i8**, i64 }*, i1, double, { %LifetimeRegionMetadata*, i64 }*, double, double, { %LocalMutation*, i64 }*, { %StringConstant*, i64 }* }
%PhiMergeResult = type { { i8**, i64 }*, double }
%PhiInputEntry = type { i8*, i8* }
%MutationMaterializationResult = type { { %LocalMutation*, i64 }*, { i8**, i64 }*, double }
%PhiStoreEntry = type { i8*, i8* }
%MatchArmMutations = type { { %LocalMutation*, i64 }*, i8*, i1 }
%LoadLocalResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
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
%Token = type { %TokenKind, i8*, double, double }
%Diagnostic = type { i8*, i8*, %Token* }
%SymbolEntry = type { i8*, i8*, %SourceSpan* }
%TypecheckResult = type { { %Diagnostic*, i64 }*, { %SymbolEntry*, i64 }* }
%SymbolCollectionResult = type { { %SymbolEntry*, i64 }*, { %Diagnostic*, i64 }* }
%ScopeResult = type { { %SymbolEntry*, i64 }*, { %Diagnostic*, i64 }* }

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%NativeInstruction = type { i32, [48 x i8] }
%TokenKind = type { i32 }

; intrinsic sailfin_runtime_print_info requires capabilities: ![io]
declare void @sailfin_runtime_print_info(i8*)
; intrinsic sailfin_runtime_print_error requires capabilities: ![io]
declare void @sailfin_runtime_print_error(i8*)
; intrinsic sailfin_runtime_print_warn requires capabilities: ![io]
declare void @sailfin_runtime_print_warn(i8*)
declare void @sailfin_runtime_bounds_check(i64, i64)
; intrinsic sailfin_adapter_fs_read_file requires capabilities: ![io]
declare i8* @sailfin_adapter_fs_read_file(i8*)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i8* @sailfin_runtime_number_to_string(double)
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Program @parse_program(i8*)
declare %Program @parse_tokens({ %Token*, i64 }*)
declare i1 @is_end_of_file(%Parser, %Token)
declare %StatementParseResult @parse_statement(%Parser)
declare %StatementParseResult @parse_import(%Parser)
declare %StatementParseResult @parse_export(%Parser)
declare %StatementParseResult @parse_variable(%Parser)
declare %SpecifierListParseResult @parse_specifier_list(%Parser)
declare { %ImportSpecifier*, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }*)
declare { %ExportSpecifier*, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }*)
declare %StatementParseResult @parse_struct(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_type_alias(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_interface(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_enum(%Parser, { %Decorator*, i64 }*)
declare %InterfaceMemberParseResult @parse_interface_member(%Parser, { %Decorator*, i64 }*)
declare %EnumVariantParseResult @parse_enum_variant(%Parser)
declare %StructFieldParseResult @parse_enum_variant_field(%Parser)
declare %ExpressionTypeSeparatorParseResult @expression_tokens_consume_type_separator(%ExpressionTokens, i1, i1)
declare %Parser @skip_trailing_comma(%Parser)
declare %StatementParseResult @parse_model(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_pipeline(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_tool(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_test(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_function(%Parser, i1, { %Decorator*, i64 }*)
declare %ParameterListParseResult @parse_parameter_list(%Parser)
declare %StructFieldParseResult @parse_struct_field(%Parser)
declare %TypeSeparatorParseResult @consume_type_separator(%Parser)
declare %ModelPropertyParseResult @parse_model_property(%Parser)
declare %MethodParseResult @parse_struct_method(%Parser, { %Decorator*, i64 }*)
declare %DecoratorParseResult @parse_decorators(%Parser)
declare %TypeParameterParseResult @parse_type_parameter_clause(%Parser)
declare %ImplementsParseResult @parse_implements_clause(%Parser)
declare %ParameterParseResult @parse_single_parameter(%Parser)
declare %EffectParseResult @parse_effect_list(%Parser)
declare %BlockParseResult @parse_block(%Parser)
declare %BlockStatementParseResult @parse_block_statement(%Parser)
declare %BlockStatementParseResult @parse_for_statement(%Parser, { %Decorator*, i64 }*)
declare %BlockStatementParseResult @parse_loop_statement(%Parser, { %Decorator*, i64 }*)
declare %BlockStatementParseResult @parse_break_statement(%Parser)
declare %BlockStatementParseResult @parse_continue_statement(%Parser)
declare %BlockStatementParseResult @parse_if_statement(%Parser, { %Decorator*, i64 }*)
declare %BlockStatementParseResult @parse_match_statement(%Parser, { %Decorator*, i64 }*)
declare %MatchCasesParseResult @parse_match_cases(%Parser)
declare %MatchCaseParseResult @parse_match_case(%Parser)
declare %BlockStatementParseResult @parse_prompt_statement(%Parser, { %Decorator*, i64 }*)
declare %BlockStatementParseResult @parse_with_statement(%Parser, { %Decorator*, i64 }*)
declare %BlockStatementParseResult @parse_return_statement(%Parser)
declare %BlockStatementParseResult @parse_expression_statement(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_unknown(%Parser)
declare i1 @identifier_matches(%Token, i8*)
declare i1 @symbol_matches(%Token, i8*)
declare i8* @decode_string_literal_escapes(i8*)
declare i8* @strip_loose_quotes(i8*)
declare i8* @identifier_text(%Token)
declare i8* @string_literal_value(%Token)
declare %Parser @skip_trivia(%Parser)
declare %Token @parser_peek_raw(%Parser)
declare %Parser @parser_advance_raw(%Parser)
declare %Parser @consume_keyword(%Parser, i8*)
declare %Parser @consume_symbol(%Parser, i8*)
declare %CaptureResult @collect_until(%Parser, { i8**, i64 }*)
declare %ParenthesizedParseResult @collect_parenthesized(%Parser)
declare %PatternCaptureResult @collect_pattern_until_arrow(%Parser)
declare %MatchCaseTokenSplit @split_match_case_tokens({ %Token*, i64 }*)
declare %DecoratorArgument* @parse_decorator_argument({ %Token*, i64 }*)
declare %Expression @normalize_expression({ %Token*, i64 }*, %Expression)
declare i1 @looks_like_number(i8*)
declare i1 @is_decimal_digit(i8*)
declare { %Token*, i64 }* @trim_token_edges({ %Token*, i64 }*)
declare { %Token*, i64 }* @token_slice({ %Token*, i64 }*, double, double)
declare %SourceSpan* @source_span_from_tokens({ %Token*, i64 }*)
declare { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }*)
declare double @find_top_level_colon({ %Token*, i64 }*)
declare %Expression @expression_from_tokens({ %Token*, i64 }*)
declare %Expression* @expression_from_single_token(%Token)
declare %ExpressionCollectResult @expression_tokens_collect_until(%ExpressionTokens, { i8**, i64 }*)
declare %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens)
declare %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens)
declare %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens)
declare %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens)
declare %ExpressionParseResult @parse_expression_bp(%ExpressionTokens, double)
declare %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens)
declare %ExpressionParseResult @parse_primary_expression(%ExpressionTokens)
declare %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens, %Expression)
declare %CallArgumentsParseResult @parse_call_arguments(%ExpressionTokens)
declare %ArrayLiteralParseResult @parse_array_literal(%ExpressionTokens)
declare %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens)
declare %ExpressionParseResult @parse_struct_literal(%ExpressionTokens, %Expression)
declare %ExpressionParseResult @expression_parse_failure(%ExpressionTokens)
declare i1 @expression_tokens_is_at_end(%ExpressionTokens)
declare %Token @expression_tokens_peek(%ExpressionTokens)
declare %ExpressionTokens @expression_tokens_advance(%ExpressionTokens)
declare i1 @expression_is_struct_target(%Expression)
declare %StructTypeNameResult @collect_struct_type_name(%Expression)
declare double @binary_precedence(i8*)
declare double @unary_precedence()
declare { %Token*, i64 }* @filter_trivia({ %Token*, i64 }*)
declare i8* @tokens_to_text({ %Token*, i64 }*)
declare i8* @trim_text(i8*)
declare i1 @is_trim_whitespace(i8*)
declare i1 @string_array_contains({ i8**, i64 }*, i8*)
declare i1 @is_trivia_token(%Token)
declare i1 @is_whitespace_lexeme(i8*)
declare %Parser @advance_to_symbol(%Parser, i8*)
declare %Parser @skip_struct_member(%Parser)
declare %Parser @skip_enum_variant_entry(%Parser)
declare i8* @strip_surrounding_quotes(i8*)
declare i8* @normalize_test_name(i8*)
declare { i8**, i64 }* @split_tokens_by_comma({ %Token*, i64 }*)
declare { { %Token*, i64 }**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }*)
declare double @find_top_level_symbol({ %Token*, i64 }*, i8*)
declare double @find_top_level_identifier({ %Token*, i64 }*, i8*)
declare { %Statement*, i64 }* @append_statement({ %Statement*, i64 }*, %Statement)
declare { %Parameter*, i64 }* @append_parameter({ %Parameter*, i64 }*, %Parameter)
declare { %ModelProperty*, i64 }* @append_model_property({ %ModelProperty*, i64 }*, %ModelProperty)
declare { %FieldDeclaration*, i64 }* @append_field({ %FieldDeclaration*, i64 }*, %FieldDeclaration)
declare { %MethodDeclaration*, i64 }* @append_method({ %MethodDeclaration*, i64 }*, %MethodDeclaration)
declare { %FunctionSignature*, i64 }* @append_signature({ %FunctionSignature*, i64 }*, %FunctionSignature)
declare { %EnumVariant*, i64 }* @append_enum_variant({ %EnumVariant*, i64 }*, %EnumVariant)
declare { %TypeAnnotation*, i64 }* @append_type_annotation({ %TypeAnnotation*, i64 }*, %TypeAnnotation)
declare { %TypeParameter*, i64 }* @append_type_parameter({ %TypeParameter*, i64 }*, %TypeParameter)
declare { %Decorator*, i64 }* @append_decorator({ %Decorator*, i64 }*, %Decorator)
declare { %DecoratorArgument*, i64 }* @append_decorator_argument({ %DecoratorArgument*, i64 }*, %DecoratorArgument)
declare { %WithClause*, i64 }* @append_with_clause({ %WithClause*, i64 }*, %WithClause)
declare { %MatchCase*, i64 }* @append_match_case({ %MatchCase*, i64 }*, %MatchCase)
declare { %Expression*, i64 }* @append_expression({ %Expression*, i64 }*, %Expression)
declare { %ObjectField*, i64 }* @append_object_field({ %ObjectField*, i64 }*, %ObjectField)
declare { %Token*, i64 }* @append_token({ %Token*, i64 }*, %Token)
declare { { %Token*, i64 }**, i64 }* @append_token_array({ { %Token*, i64 }**, i64 }*, { %Token*, i64 }*)
declare i1 @is_import_like(%Statement)
declare %TextBuilder @maybe_emit_blank(%TextBuilder, i1)
declare i8* @emit_program(%Program)
declare %TextBuilder @emit_statement(%TextBuilder, %Statement)
declare %TextBuilder @emit_import(%TextBuilder, { %ImportSpecifier*, i64 }*, i8*)
declare %TextBuilder @emit_export(%TextBuilder, { %ExportSpecifier*, i64 }*, i8*)
declare %TextBuilder @emit_variable(%TextBuilder, %Statement)
declare %TextBuilder @emit_function(%TextBuilder, %FunctionSignature, %Block, { %Decorator*, i64 }*)
declare %TextBuilder @emit_callable(%TextBuilder, i8*, %FunctionSignature, %Block, { %Decorator*, i64 }*)
declare %TextBuilder @emit_test(%TextBuilder, %Statement)
declare %TextBuilder @emit_model(%TextBuilder, %Statement)
declare i8* @format_import_specifiers({ %ImportSpecifier*, i64 }*)
declare i8* @format_export_specifiers({ %ExportSpecifier*, i64 }*)
declare i8* @format_specifier_entry(i8*, i8*)
declare %TextBuilder @emit_type_alias(%TextBuilder, %Statement)
declare %TextBuilder @emit_interface(%TextBuilder, %Statement)
declare %TextBuilder @emit_enum(%TextBuilder, %Statement)
declare %TextBuilder @emit_struct(%TextBuilder, %Statement)
declare %TextBuilder @emit_block(%TextBuilder, %Block)
declare %TextBuilder @emit_block_body(%TextBuilder, %Block)
declare %TextBuilder @emit_block_statement(%TextBuilder, %Statement)
declare i8* @format_optional_expression(%Expression*)
declare %TextBuilder @emit_prompt(%TextBuilder, %Statement)
declare %TextBuilder @emit_with(%TextBuilder, %Statement)
declare %TextBuilder @emit_if(%TextBuilder, %Statement)
declare %TextBuilder @emit_else_branch(%TextBuilder, %ElseBranch)
declare %TextBuilder @emit_for(%TextBuilder, %Statement)
declare %TextBuilder @emit_match(%TextBuilder, %Statement)
declare %TextBuilder @emit_match_case(%TextBuilder, %MatchCase)
declare %TextBuilder @emit_block_start(%TextBuilder)
declare %TextBuilder @emit_block_header(%TextBuilder, i8*)
declare %TextBuilder @emit_block_with_header(%TextBuilder, i8*, %Block)
declare %TextBuilder @emit_block_end(%TextBuilder)
declare %TextBuilder @emit_decorators_then_line(%TextBuilder, { %Decorator*, i64 }*, i8*)
declare %TextBuilder @emit_decorators(%TextBuilder, { %Decorator*, i64 }*)
declare i8* @format_decorator(%Decorator)
declare i8* @format_decorator_argument(%DecoratorArgument)
declare i8* @format_for_clause(%ForClause)
declare i8* @format_function_header(%FunctionSignature)
declare i8* @format_method_header(%FunctionSignature)
declare i8* @format_callable_header(i8*, %FunctionSignature)
declare i8* @format_signature_line(i8*, %FunctionSignature)
declare i8* @format_field(%FieldDeclaration)
declare i8* @format_enum_variant(%EnumVariant)
declare i8* @format_parameters({ %Parameter*, i64 }*)
declare i8* @format_parameter(%Parameter)
declare i8* @format_type_parameters({ %TypeParameter*, i64 }*)
declare i8* @format_type_annotation(%TypeAnnotation*)
declare i8* @format_initializer(%Expression*)
declare i8* @format_effects({ i8**, i64 }*)
declare i8* @join_type_annotations({ %TypeAnnotation*, i64 }*)
declare i8* @format_expression(%Expression)
declare i8* @format_lambda_expression(%Expression)
declare i8* @format_lambda_parameters({ %Parameter*, i64 }*)
declare i8* @format_lambda_body(%Block)
declare i8* @format_lambda_statement(%Statement)
declare { i8**, i64 }* @indent_lines({ i8**, i64 }*, double)
declare i8* @quote_string(i8*)
declare i8* @escape_string_char(i8*)
declare i8* @format_test_name(i8*)
declare i1 @is_identifier(i8*)
declare i1 @is_identifier_start(i8*)
declare i1 @is_identifier_part(i8*)
declare i8* @trim_block_body(i8*)
declare i8* @collapse_whitespace(i8*)
declare i8* @tokens_to_source({ %Token*, i64 }*)
declare %TextBuilder @builder_new()
declare %TextBuilder @builder_emit_line(%TextBuilder, i8*)
declare %TextBuilder @builder_emit_blank(%TextBuilder)
declare %TextBuilder @builder_push_indent(%TextBuilder)
declare %TextBuilder @builder_pop_indent(%TextBuilder)
declare i8* @builder_to_string(%TextBuilder)
declare i8* @trim_right(i8*)
declare i8* @join_with_separator({ i8**, i64 }*, i8*)
declare i1 @is_trim_char(i8*)
declare %LayoutContext @build_layout_context(%Program)
declare %EmitNativeResult @emit_native(%Program)
declare i8* @render_native_specifiers({ %ImportSpecifier*, i64 }*)
declare i8* @render_export_specifiers({ %ExportSpecifier*, i64 }*)
declare i8* @format_native_specifier(i8*, i8*)
declare %NativeState @emit_span_if_present(%NativeState, %SourceSpan*)
declare %NativeState @emit_initializer_span_if_present(%NativeState, %SourceSpan*)
declare i8* @append_optional_type_annotation(i8*, %TypeAnnotation*)
declare i8* @append_optional_initializer(i8*, %Expression*)
declare i8* @format_span(%SourceSpan)
declare %NativeState @emit_pipeline(%NativeState, %Statement)
declare %NativeState @emit_tool(%NativeState, %Statement)
declare %NativeState @emit_method(%NativeState, %MethodDeclaration)
declare %NativeState @emit_loop(%NativeState, %Statement)
declare %Statement* @select_inline_match_case_statement(%Block)
declare %NativeState @emit_inline_match_case(%NativeState, %MatchCase, %Statement)
declare i8* @format_match_case_head(%MatchCase)
declare i8* @format_inline_case_body(%Statement)
declare %NativeState @emit_return(%NativeState, %Statement)
declare %NativeState @emit_expression_statement(%NativeState, %Statement)
declare %NativeState @emit_signature_metadata(%NativeState, %FunctionSignature)
declare %NativeState @emit_parameter_metadata(%NativeState, { %Parameter*, i64 }*)
declare i8* @format_function_signature(%FunctionSignature)
declare %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext, i8*, { %FieldDeclaration*, i64 }*)
declare %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext, %Statement)
declare %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext, i8*, { %LayoutEnumVariantDefinition*, i64 }*, { i8**, i64 }*)
declare %RecordLayoutResult @calculate_record_layout(%LayoutContext, { %LayoutFieldInput*, i64 }*, i8*, i8*, { i8**, i64 }*)
declare %TypeLayoutInfo @analyze_type_layout(%LayoutContext, { i8**, i64 }*, i8*, i8*, i8*, i8*)
declare { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }*)
declare { %LayoutFieldInput*, i64 }* @convert_variant_fields(%EnumVariant)
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
declare i1 @ends_with(i8*, i8*)
declare i8* @format_array_expression({ %Expression*, i64 }*)
declare i8* @infer_array_element_type({ %Expression*, i64 }*)
declare i8* @infer_expression_type(%Expression)
declare { i8**, i64 }* @collect_entry_points(%Program)
declare double @count_exported_symbols(%Program)
declare { i8**, i64 }* @append_unique({ i8**, i64 }*, i8*)
declare i1 @contains_string({ i8**, i64 }*, i8*)
declare %NativeState @state_new(%LayoutContext)
declare %NativeState @state_emit_line(%NativeState, i8*)
declare %NativeState @state_emit_blank(%NativeState)
declare %NativeState @state_push_indent(%NativeState)
declare %NativeState @state_pop_indent(%NativeState)
declare %NativeState @state_add_diagnostic(%NativeState, i8*)
declare %NativeState @state_merge_diagnostics(%NativeState, { i8**, i64 }*)
declare %NativeArtifact @generate_layout_manifest(%Program, %LayoutContext)
declare %NativeState @emit_layout_lines(%NativeState, { i8**, i64 }*)
declare %LoweredPythonResult @lower_to_python(%NativeModule)
declare %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }*, { %NativeImport*, i64 }*, { %NativeStruct*, i64 }*, { %NativeEnum*, i64 }*, { %NativeBinding*, i64 }*)
declare %PythonBuilder @emit_runtime_aliases(%PythonBuilder)
declare %PythonBuilder @emit_top_level_bindings(%PythonBuilder, { %NativeBinding*, i64 }*)
declare %PythonImportEmission @emit_python_imports(%PythonBuilder, { %NativeImport*, i64 }*)
declare %PythonBuilder @emit_enum_definitions(%PythonBuilder, { %NativeEnum*, i64 }*)
declare %PythonBuilder @emit_single_enum(%PythonBuilder, %NativeEnum)
declare i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }*)
declare i8* @render_python_import(%NativeImport)
declare i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }*)
declare i8* @render_python_specifier(%NativeImportSpecifier)
declare i8* @normalize_import_module(i8*)
declare %PythonStructEmission @emit_struct_definitions(%PythonBuilder, { %NativeStruct*, i64 }*)
declare %PythonBuilder @emit_export_list(%PythonBuilder, { i8**, i64 }*)
declare { i8**, i64 }* @collect_export_names({ i8**, i64 }*, { %NativeImportSpecifier*, i64 }*)
declare i8* @select_export_name(%NativeImportSpecifier)
declare %PythonStructEmission @emit_single_struct(%PythonBuilder, %NativeStruct)
declare { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }*)
declare i8* @render_struct_repr_fields(i8*, { %NativeStructField*, i64 }*)
declare i1 @is_optional_type(i8*)
declare i8* @lower_expression(i8*)
declare i8* @lower_expression_with_depth(i8*, double)
declare i8* @rewrite_interpolated_string_literal(i8*)
declare i8* @decode_string_literal(i8*)
declare i8* @decode_escape_sequence(i8*, i8*)
declare i8* @python_string_literal(i8*)
declare i8* @lower_struct_literal_expression(i8*, double)
declare i1 @is_struct_literal_type_candidate(i8*)
declare i8* @lower_array_literal_expression(i8*, double)
declare double @array_literal_start_index({ i8**, i64 }*)
declare i1 @is_array_metadata_entry(i8*)
declare i8* @rewrite_array_literals_inline(i8*, double)
declare i8* @rewrite_struct_literals_inline(i8*, double)
declare %StructLiteralCapture @capture_struct_literal_expression(i8*, { %NativeInstruction*, i64 }*, double)
declare i8* @rewrite_expression_intrinsics(i8*)
declare i8* @rewrite_logical_operators(i8*)
declare i8* @rewrite_literal_tokens(i8*)
declare i8* @rewrite_push_calls(i8*)
declare i8* @rewrite_concat_calls(i8*)
declare i8* @rewrite_length_accesses(i8*)
declare %ExtractedSpan @extract_object_span(i8*, double)
declare %ExtractedSpan @extract_parenthesized_span(i8*, double)
declare double @skip_string_literal(i8*, double)
declare %ExpressionContinuationCapture @capture_expression_continuation(i8*, { %NativeInstruction*, i64 }*, double)
declare i8* @continuation_segment_text(%NativeInstruction)
declare i1 @segment_signals_expression_continuation(i8*)
declare double @compute_brace_balance(i8*)
declare double @compute_parenthesis_balance(i8*)
declare double @compute_bracket_balance(i8*)
declare double @compute_symbol_balance(i8*, i8*, i8*)
declare { i8**, i64 }* @split_struct_field_entries(i8*)
declare { i8**, i64 }* @split_array_entries(i8*)
declare i8* @trim_trailing_delimiters(i8*)
declare double @index_of(i8*, i8*)
declare double @find_matching_brace(i8*, double)
declare i1 @is_escaped_quote(i8*, double)
declare double @find_next_square_open(i8*, double)
declare double @find_matching_square(i8*, double)
declare %PythonFunctionEmission @emit_python_function(%PythonBuilder, %NativeFunction)
declare { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }*, %MatchContext)
declare { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }*, double, %MatchContext)
declare { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }*, double)
declare i8* @generate_match_subject_name(double)
declare %LoweredCaseCondition @lower_match_case_condition(i8*, i8*, i8*)
declare { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }*)
declare %PythonBuilder @builder_emit(%PythonBuilder, i8*)
declare i8* @sanitize_identifier(i8*)
declare i8* @sanitize_qualified_identifier(i8*)
declare i1 @is_identifier_char(i8*)
declare i1 @is_whitespace_char(i8*)
declare i1 @starts_with(i8*, i8*)
declare i8* @replace_all(i8*, i8*, i8*)
declare { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }*, i8*, i8*)
declare i8* @char_at(i8*, double)
declare i1 @is_unit_enum(%NativeEnum)
declare %NativeEnumLayout @synthesize_unit_enum_layout(%NativeEnum)
declare i1 @enum_layout_matches_variants(%NativeEnum, %NativeEnumLayout)
declare %EnumLayoutFixupResult @fixup_enum_layouts({ %NativeEnum*, i64 }*)
declare { %LayoutManifest*, i64 }* @load_imported_layout_manifests({ %NativeImport*, i64 }*)
declare %ImportedModuleContext @collect_imported_module_context({ %NativeImport*, i64 }*)
declare i8* @resolve_import_module_slug(i8*)
declare i8* @layout_manifest_path_for_slug(i8*)
declare i8* @native_text_path_for_slug(i8*)
declare i8* @normalize_import_module_path(i8*)
declare %LayoutManifestApplication @apply_layout_manifest_to_module({ %NativeStruct*, i64 }*, { %NativeEnum*, i64 }*, %LayoutManifest*)
declare %LayoutManifestApplication @apply_layout_manifest_entries({ %NativeStruct*, i64 }*, { %NativeEnum*, i64 }*, %LayoutManifest)
declare %LoweredLLVMResult @lower_to_llvm(%NativeModule)
declare %LoweredLLVMResult @lower_to_llvm_with_manifests(%NativeModule, { %LayoutManifest*, i64 }*)
declare %LoweredLLVMResult @lower_to_llvm_with_context(%NativeModule, { %LayoutManifest*, i64 }*, { i8**, i64 }*, { i8**, i64 }*)
declare %TraitMetadata @empty_trait_metadata()
declare %CapabilityManifest @empty_capability_manifest()
declare %TraitMetadata @build_trait_metadata({ %NativeInterface*, i64 }*, { %NativeStruct*, i64 }*)
declare { i8**, i64 }* @render_trait_metadata_comments(%TraitMetadata)
declare { i8**, i64 }* @render_runtime_helper_declarations({ i8**, i64 }*, { %NativeFunction*, i64 }*)
declare { i8**, i64 }* @render_imported_function_declarations({ %NativeFunction*, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %TypeContext @empty_type_context()
declare %TypeContextBuild @build_type_context({ %NativeStruct*, i64 }*, { %NativeEnum*, i64 }*, { %NativeInterface*, i64 }*)
declare { %StructTypeInfo*, i64 }* @append_struct_type_info({ %StructTypeInfo*, i64 }*, %StructTypeInfo)
declare { %StructFieldInfo*, i64 }* @append_struct_field_info({ %StructFieldInfo*, i64 }*, %StructFieldInfo)
declare { %EnumVariantInfo*, i64 }* @append_enum_variant_info({ %EnumVariantInfo*, i64 }*, %EnumVariantInfo)
declare { %EnumTypeInfo*, i64 }* @append_enum_type_info({ %EnumTypeInfo*, i64 }*, %EnumTypeInfo)
declare { %InterfaceTypeInfo*, i64 }* @append_interface_type_info({ %InterfaceTypeInfo*, i64 }*, %InterfaceTypeInfo)
declare { %VTableInfo*, i64 }* @append_vtable_info({ %VTableInfo*, i64 }*, %VTableInfo)
declare { %VTableEntry*, i64 }* @append_vtable_entry({ %VTableEntry*, i64 }*, %VTableEntry)
declare { %NativeFunction*, i64 }* @append_native_function({ %NativeFunction*, i64 }*, %NativeFunction)
declare { %NativeFunction*, i64 }* @concat_native_functions({ %NativeFunction*, i64 }*, { %NativeFunction*, i64 }*)
declare { %NativeFunction*, i64 }* @flatten_struct_methods({ %NativeStruct*, i64 }*)
declare i8* @extract_struct_type_from_llvm(i8*)
declare { i8**, i64 }* @render_struct_type_definitions(%TypeContext, { %NativeFunction*, i64 }*)
declare { i8**, i64 }* @render_enum_type_definitions(%TypeContext)
declare { i8**, i64 }* @render_interface_type_definitions(%TypeContext)
declare { i8**, i64 }* @render_vtable_type_definitions(%TypeContext)
declare { i8**, i64 }* @render_vtable_constants(%TypeContext)
declare i1 @is_ascii_uppercase(i8*)
declare i1 @looks_like_user_type(i8*)
declare i8* @map_type_annotation(i8*)
declare i8* @map_struct_field_annotation(i8*)
declare i1 @layout_annotation_requires_pointer(i8*)
declare i8* @layout_annotation_base_type(i8*)
declare i1 @annotation_is_array(i8*)
declare i1 @layout_annotation_represents_user_value(i8*)
declare %StructTypeInfo* @find_struct_info_by_name(%TypeContext, i8*)
declare %InterfaceTypeInfo* @find_interface_info_by_name(%TypeContext, i8*)
declare %VTableInfo* @find_vtable_for_struct_interface(%TypeContext, i8*, i8*)
declare %StructTypeInfo* @find_struct_info_by_llvm_type(%TypeContext, i8*)
declare double @find_struct_field_index(%StructTypeInfo, i8*)
declare %EnumTypeInfo* @find_enum_info_by_llvm_type(%TypeContext, i8*)
declare %StructTypeInfo* @resolve_struct_info_from_llvm_type(%TypeContext, i8*)
declare %TypeAllocationInfo* @lookup_allocation_info(%TypeContext, i8*)
declare %StructTypeInfo* @resolve_struct_info_for_method_target(i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, %TypeContext)
declare %InterfaceTypeInfo* @resolve_interface_info_for_method_target(i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, %TypeContext)
declare %StructFieldInfo* @find_struct_field_info(%StructTypeInfo, i8*)
declare %StructFieldInfo* @find_variant_field_info(%EnumVariantInfo, i8*)
declare %StructTypeInfo* @resolve_struct_info_for_literal(%TypeContext, i8*)
declare %EnumTypeInfo* @resolve_enum_info_for_literal(%TypeContext, i8*)
declare %EnumVariantInfo* @resolve_enum_variant_info(%EnumTypeInfo, i8*)
declare { %FunctionEffectEntry*, i64 }* @collect_direct_function_effects({ %NativeFunction*, i64 }*)
declare { %FunctionCallEntry*, i64 }* @collect_function_call_graph({ %NativeFunction*, i64 }*)
declare %FunctionCallEntry @collect_function_call_entry(%NativeFunction, { i8**, i64 }*)
declare { i8**, i64 }* @collect_runtime_helper_targets({ %NativeFunction*, i64 }*)
declare { i8**, i64 }* @collect_function_runtime_helper_targets(%NativeFunction)
declare { i8**, i64 }* @collect_instruction_runtime_helper_targets(%NativeInstruction)
declare { i8**, i64 }* @collect_instruction_calls(%NativeInstruction, { i8**, i64 }*)
declare { i8**, i64 }* @collect_function_names({ %NativeFunction*, i64 }*)
declare { i8**, i64 }* @extract_call_targets(i8*, { i8**, i64 }*)
declare { i8**, i64 }* @extract_all_call_targets(i8*)
declare { i8**, i64 }* @filter_runtime_helper_targets({ i8**, i64 }*)
declare { i8**, i64 }* @collect_runtime_property_targets(i8*)
declare i1 @contains_dot_property(i8*, i8*)
declare { %FunctionCallEntry*, i64 }* @append_function_call_entry({ %FunctionCallEntry*, i64 }*, %FunctionCallEntry)
declare { %FunctionEffectEntry*, i64 }* @replace_function_effect_entry({ %FunctionEffectEntry*, i64 }*, double, %FunctionEffectEntry)
declare double @find_function_effect_entry_index({ %FunctionEffectEntry*, i64 }*, i8*)
declare { %FunctionEffectEntry*, i64 }* @propagate_function_effects({ %FunctionEffectEntry*, i64 }*, { %FunctionCallEntry*, i64 }*)
declare %FunctionEffectEntry* @find_function_effect_entry({ %FunctionEffectEntry*, i64 }*, i8*)
declare %CapabilityManifest @build_capability_manifest({ i8**, i64 }*, { %FunctionEffectEntry*, i64 }*)
declare { %CapabilityManifestEntry*, i64 }* @append_manifest_entry({ %CapabilityManifestEntry*, i64 }*, %CapabilityManifestEntry)
declare { %RuntimeHelperDescriptor*, i64 }* @runtime_helper_descriptors()
declare { %RuntimeHelperDescriptor*, i64 }* @append_runtime_helper({ %RuntimeHelperDescriptor*, i64 }*, %RuntimeHelperDescriptor)
declare %RuntimeHelperDescriptor* @find_runtime_helper(i8*)
declare %FunctionEffectEntry @collect_function_effect_entry(%NativeFunction)
declare { %FunctionEffectEntry*, i64 }* @append_function_effect_entry({ %FunctionEffectEntry*, i64 }*, %FunctionEffectEntry)
declare { i8**, i64 }* @merge_effect_lists({ i8**, i64 }*, { i8**, i64 }*)
declare { i8**, i64 }* @append_unique_effect({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @collect_function_borrow_effects(%NativeFunction)
declare { i8**, i64 }* @collect_expression_borrow_effects(i8*)
declare { i8**, i64 }* @copy_string_array({ i8**, i64 }*)
declare i1 @string_arrays_equal({ i8**, i64 }*, { i8**, i64 }*)
declare i1 @matches_keyword(i8*, double, i8*)
declare i1 @is_effect_prefix_char(i8*)
declare i1 @is_effect_delimiter(i8*)
declare i1 @is_identifier_start_char(i8*)
declare i1 @is_identifier_part_char(i8*)
declare i8* @render_interface_signature(%NativeInterfaceSignature)
declare i8* @render_interface_parameters({ %NativeParameter*, i64 }*)
declare %BodyResult @emit_body(%NativeFunction, i8*, { %ParameterBinding*, i64 }*, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare { i8**, i64 }* @validate_borrow_lifetimes(%NativeFunction, { %LifetimeRegionMetadata*, i64 }*)
declare %BlockLoweringResult @lower_instruction_range(%NativeFunction, double, double, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, double, double, { %NativeFunction*, i64 }*, { %LoopContext*, i64 }*, %TypeContext, i8*, double, i8*)
declare %IfStructure @collect_if_structure({ %NativeInstruction*, i64 }*, double, double, i8*)
declare %LoopStructure @collect_loop_structure({ %NativeInstruction*, i64 }*, double, double, i8*)
declare { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }*, %LoopContext)
declare %LoopContext @last_loop_context({ %LoopContext*, i64 }*)
declare %BlockLoweringResult @lower_loop_instruction(%NativeFunction, double, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, double, double, { %NativeFunction*, i64 }*, { %LoopContext*, i64 }*, double, %TypeContext, i8*, double, i8*)
declare %BlockLoweringResult @lower_for_instruction(%NativeFunction, double, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, double, double, { %NativeFunction*, i64 }*, { %LoopContext*, i64 }*, double, %TypeContext, i8*, double, i8*)
declare %MatchStructure @collect_match_structure({ %NativeInstruction*, i64 }*, double, double, i8*)
declare %MatchCaseStructure @finalize_match_case(%MatchCaseStructure*, double)
declare i1 @is_default_pattern(i8*)
declare %BlockLoweringResult @lower_match_instruction(%NativeFunction, double, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, double, double, { %NativeFunction*, i64 }*, { %LoopContext*, i64 }*, double, %TypeContext, i8*, double, i8*)
declare %BlockLabelResult @allocate_block_label(i8*, double)
declare %ConditionConversion @lower_condition_to_i1(i8*, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare i8* @find_preloaded_value({ %LocalBinding*, i64 }*, { i8**, i64 }*, i8*)
declare { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }*)
declare %LocalMutation* @find_mutation_for_name({ %LocalMutation*, i64 }*, i8*)
declare i8* @join_strings({ i8**, i64 }*, i8*)
declare %PhiStoreEntry @build_phi_and_store(%LocalBinding, i8*, { i8**, i64 }*, double)
declare i8* @find_last_label({ i8**, i64 }*, i8*)
declare { %LocalMutation*, i64 }* @retarget_recent_mutations({ %LocalMutation*, i64 }*, double, i8*)
declare %MutationMaterializationResult @materialize_mutation_values_at_exit({ %LocalMutation*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, double)
declare %PhiMergeResult @emit_phi_merges_for_straight_if({ %LocalMutation*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, i8*, i8*, { i8**, i64 }*, double)
declare %PhiMergeResult @emit_phi_merges_for_if_else({ %LocalMutation*, i64 }*, { %LocalMutation*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, i8*, i8*, i8*, i8*, i1, i1, { i8**, i64 }*, double)
declare %PhiMergeResult @emit_phi_merges_for_match({ %MatchArmMutations*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double)
declare %BlockLoweringResult @lower_if_instruction(%NativeFunction, double, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, double, double, { %NativeFunction*, i64 }*, { %LoopContext*, i64 }*, double, %TypeContext, i8*, double, i8*)
declare %LetLoweringResult @lower_let_instruction(%NativeFunction, %NativeInstruction, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, double, { %NativeFunction*, i64 }*, %TypeContext, i8*, double, i8*)
declare %ExpressionStatementResult @lower_expression_statement(i8*, %NativeInstruction, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, double, i8*, double, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare %AssignmentParseResult @parse_assignment_expression(i8*)
declare %InlineLetParseResult @parse_inline_let_expression(i8*)
declare %ExpressionStatementResult @lower_return_instruction(%NativeFunction, %NativeInstruction, i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, double, i8*, double, { %NativeFunction*, i64 }*, %TypeContext)
declare %ParameterPreparation @prepare_parameters(%NativeFunction, %TypeContext)
declare i8* @map_struct_type_annotation(%TypeContext, i8*)
declare i8* @map_enum_type_annotation(%TypeContext, i8*)
declare i8* @map_interface_type_annotation(%TypeContext, i8*)
declare i8* @map_primitive_type(%TypeContext, i8*)
declare i8* @map_optional_type(%TypeContext, i8*)
declare i8* @map_reference_inner_type(%TypeContext, i8*)
declare i8* @map_reference_type(%TypeContext, i8*)
declare i8* @map_array_pointer_type(%TypeContext, i8*)
declare i8* @array_struct_type_for_element(i8*)
declare %ExpressionResult @lower_struct_array_concat(%LLVMOperand, %LLVMOperand, i8*, { i8**, i64 }*, double)
declare double @find_top_level_comma_in_llvm_type(i8*)
declare i8* @array_pointer_element_type(i8*)
declare i8* @unwrap_move_wrapper(i8*)
declare i1 @contains_keyword_outside_strings(i8*, i8*)
declare i8* @find_suspension_keyword(i8*)
declare i1 @is_mutable_borrow_annotation(i8*)
declare { i8**, i64 }* @collect_suspension_conflicts(i8*, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*, i8*, %NativeSourceSpan*)
declare i8* @normalise_borrow_base(i8*)
declare { i8**, i64 }* @detect_suspension_conflicts(i8*, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*, i8*, %NativeSourceSpan*)
declare i8* @map_return_type(%TypeContext, i8*)
declare i8* @map_parameter_type(%TypeContext, i8*)
declare i8* @map_local_type(%TypeContext, i8*)
declare %ParameterBinding* @find_parameter_binding({ %ParameterBinding*, i64 }*, i8*)
declare { %ParameterBinding*, i64 }* @mark_parameter_consumed({ %ParameterBinding*, i64 }*, i8*)
declare { %LocalBinding*, i64 }* @mark_local_consumed({ %LocalBinding*, i64 }*, i8*)
declare { %LocalBinding*, i64 }* @reset_local_consumption({ %LocalBinding*, i64 }*, i8*)
declare { %LocalBinding*, i64 }* @update_local_ownership({ %LocalBinding*, i64 }*, i8*, %OwnershipInfo*)
declare %ExpressionResult @lower_logical_not_with_operand(%LLVMOperand, double, { i8**, i64 }*, { i8**, i64 }*, { %StringConstant*, i64 }*)
declare %ExpressionResult @lower_logical_not_result(%ExpressionResult, { i8**, i64 }*)
declare %BorrowParseResult @parse_borrow_expression(i8*)
declare %BorrowArgumentParse @extract_borrow_argument(i8*)
declare %BorrowArgumentParse @extract_simple_borrow_target(i8*)
declare i1 @is_valid_borrow_target(i8*)
declare %TernaryParseResult @parse_ternary_expression(i8*)
declare %OwnershipAnalysis @analyze_value_ownership(i8*, %NativeSourceSpan*, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*)
declare i8* @format_use_after_move_message(i8*, %NativeSourceSpan*)
declare i8* @format_span_location(%NativeSourceSpan)
declare i8* @format_suspension_location(i8*, %NativeSourceSpan*, %NativeSourceSpan*)
declare { i8**, i64 }* @detect_borrow_conflicts(%OwnershipInfo*, { %LocalBinding*, i64 }*, i8*, i8*)
declare i8* @resolve_borrow_base(i8*, { %LocalBinding*, i64 }*)
declare i8* @resolve_borrow_base_inner(i8*, { %LocalBinding*, i64 }*, double)
declare %ExpressionResult @lower_borrow_expression(%BorrowParseResult, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*)
declare %ExpressionResult @lower_ternary_expression(%TernaryParseResult, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare %ExpressionResult @lower_binary_operation(i8*, %OperatorMatch, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %ExpressionResult @lower_comparison_operation(i8*, %OperatorMatch, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %ExpressionResult @lower_logical_and(i8*, %OperatorMatch, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %ExpressionResult @lower_logical_or(i8*, %OperatorMatch, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %ExpressionResult @lower_call_expression(i8*, { i8**, i64 }*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %ExpressionResult @lower_member_access(%MemberAccessParse, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare %ExpressionResult @make_expression_result({ i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, { %StringConstant*, i64 }*)
declare %ExpressionResult @lower_dynamic_member_access(i8*, %LLVMOperand, double, { i8**, i64 }*, { i8**, i64 }*, { %StringConstant*, i64 }*)
declare %ExpressionResult @lower_runtime_global_reference(double, { i8**, i64 }*)
declare %ExpressionResult @lower_enum_member_access(%MemberAccessParse, %EnumTypeInfo, %LLVMOperand, i1, double, { i8**, i64 }*, { i8**, i64 }*, { %StringConstant*, i64 }*, i8*)
declare %StringPointerResult @emit_string_constant_pointer(%StringConstant, double, { i8**, i64 }*)
declare %ExpressionResult @lower_index_expression(%IndexExpressionParse, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %ExpressionResult @lower_array_literal(i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare double @find_matching_closing_brace(i8*, double)
declare %EnumLiteralParse @parse_enum_literal(i8*)
declare %ExpressionResult @lower_struct_literal(%StructLiteralParse, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare %HeapBoxResult @box_aggregate_operand(%LLVMOperand, i8*, double, { i8**, i64 }*, %TypeContext)
declare %ExpressionResult @lower_enum_literal(%EnumLiteralParse, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext, i8*)
declare %ComparisonEmission @emit_comparison_instruction(i8*, %LLVMOperand, %LLVMOperand, double, { i8**, i64 }*)
declare %ComparisonEmission @emit_boolean_and(%LLVMOperand, %LLVMOperand, double, { i8**, i64 }*)
declare i8* @comparison_predicate_for_symbol(i8*, i8*)
declare i1 @is_string_pointer_type(i8*)
declare { i8**, i64 }* @collect_parameter_types(%TypeContext, { %NativeParameter*, i64 }*)
declare %LoadLocalResult @load_local_operand(%LocalBinding, double, { i8**, i64 }*)
declare %CoercionResult @coerce_operand_to_type(%LLVMOperand, i8*, double, { i8**, i64 }*)
declare i8* @dominant_type(i8*, i8*)
declare %BinaryAlignmentResult @harmonise_operands(%LLVMOperand, %LLVMOperand, double, { i8**, i64 }*)
declare i8* @strip_enclosing_parentheses(i8*)
declare %OperatorMatch @find_top_level_operator(i8*, i8*)
declare %OperatorMatch @find_comparison_operator(i8*)
declare %OperatorMatch @find_logical_operator(i8*)
declare i1 @contains_char(i8*, i8*)
declare i1 @is_binary_minus(i8*, double)
declare i8* @find_previous_non_space_char(i8*, double)
declare i8* @find_next_non_space_char(i8*, double)
declare double @find_call_site(i8*)
declare { i8**, i64 }* @split_call_arguments(i8*)
declare { i8**, i64 }* @split_array_elements(i8*)
declare %ArrayLiteralMetadata @parse_array_literal_metadata({ i8**, i64 }*, %TypeContext)
declare i8* @map_metadata_annotation(%TypeContext, i8*)
declare i8* @operation_name_for_symbol(i8*, i8*)
declare i8* @format_temp_name(double)
declare i8* @format_local_pointer_name(double)
declare i8* @format_typed_operand(%LLVMOperand)
declare i1 @ends_with_pointer_suffix(i8*)
declare i8* @strip_pointer_suffix(i8*)
declare i1 @is_copy_type(i8*, i8*)
declare i8* @default_return_literal(i8*)
declare i1 @contains_text(i8*, i8*)
declare i8* @strip_mut_prefix(i8*)
declare i1 @is_simple_identifier(i8*)
declare double @find_top_level_range_separator(i8*)
declare double @find_top_level_range_separator_from(i8*, double)
declare double @find_member_access_separator(i8*)
declare %MemberAccessParse @parse_member_access(i8*)
declare %IndexExpressionParse @parse_index_expression(i8*)
declare %RangeIterableParse @parse_range_iterable(i8*)
declare %LocalBinding* @find_local_binding({ %LocalBinding*, i64 }*, i8*)
declare %ScopeMetadata @infer_borrow_base_scope(i8*, { %LocalBinding*, i64 }*, { %ParameterBinding*, i64 }*, i8*)
declare { %LifetimeRegionMetadata*, i64 }* @append_lifetime_region({ %LifetimeRegionMetadata*, i64 }*, %LifetimeRegionMetadata)
declare { %LifetimeReleaseEvent*, i64 }* @append_lifetime_release_event({ %LifetimeReleaseEvent*, i64 }*, %LifetimeReleaseEvent)
declare { %LifetimeRegionMetadata*, i64 }* @mark_lifetime_region_released({ %LifetimeRegionMetadata*, i64 }*, double, i8*, double)
declare { %LifetimeRegionMetadata*, i64 }* @apply_lifetime_release_events({ %LifetimeRegionMetadata*, i64 }*, { %LifetimeReleaseEvent*, i64 }*)
declare %LifetimeRegionMetadata @make_lifetime_region_metadata(double, i8*, %OwnershipInfo, i8*, double, i8*, double)
declare i8* @format_root_scope_id(i8*)
declare i8* @make_child_scope_id(i8*, i8*)
declare i1 @is_scope_descendant(i8*, i8*)
declare { %LocalBinding*, i64 }* @append_local_binding({ %LocalBinding*, i64 }*, %LocalBinding)
declare { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }*, %LLVMOperand)
declare { %StructLiteralField*, i64 }* @append_struct_literal_field({ %StructLiteralField*, i64 }*, %StructLiteralField)
declare { %NativeStruct*, i64 }* @append_native_struct({ %NativeStruct*, i64 }*, %NativeStruct)
declare { %NativeEnum*, i64 }* @append_native_enum({ %NativeEnum*, i64 }*, %NativeEnum)
declare { %LLVMOperand*, i64 }* @replace_llvm_operand({ %LLVMOperand*, i64 }*, double, %LLVMOperand)
declare { %NativeStruct*, i64 }* @replace_native_struct({ %NativeStruct*, i64 }*, double, %NativeStruct)
declare { %NativeEnum*, i64 }* @replace_native_enum({ %NativeEnum*, i64 }*, double, %NativeEnum)
declare %NativeFunction* @find_function_by_name({ %NativeFunction*, i64 }*, i8*)
declare double @find_struct_index({ %NativeStruct*, i64 }*, i8*)
declare double @find_enum_index({ %NativeEnum*, i64 }*, i8*)
declare double @lower_char_code(double)
declare i1 @matches_case_insensitive(i8*, i8*)
declare i1 @is_boolean_literal(i8*)
declare i1 @is_null_literal(i8*)
declare i1 @is_digit_char(i8*)
declare double @char_code_at_text(i8*, double)
declare i1 @is_integer_literal(i8*)
declare i1 @is_number_literal(i8*)
declare i8* @normalise_number_literal(i8*)
declare i1 @is_string_literal(i8*)
declare i1 @is_character_literal(i8*)
declare double @get_character_literal_value(i8*)
declare i8* @make_string_constant_name(i8*)
declare double @compute_string_constant_hash(i8*)
declare %ExpressionResult @lower_string_literal(i8*, double, { i8**, i64 }*)
declare %ExpressionResult* @try_lower_interpolated_string_literal(i8*, { %ParameterBinding*, i64 }*, { %LocalBinding*, i64 }*, double, { i8**, i64 }*, { %NativeFunction*, i64 }*, %TypeContext)
declare %InterpolatedTemplateParse @parse_interpolated_template(i8*)
declare i8* @encode_string_literal_for_sailfin(i8*)
declare i8* @escape_string_for_sailfin_literal(i8*)
declare %ExpressionResult @emit_string_concat(%LLVMOperand, %LLVMOperand, double, { i8**, i64 }*)
declare %ExpressionResult @coerce_operand_to_string(%LLVMOperand, double, { i8**, i64 }*)
declare i8* @unescape_string_literal(i8*)
declare double @find_last_index_of_char(i8*, i8*)
declare { %MatchArmMutations*, i64 }* @append_match_arm_mutations({ %MatchArmMutations*, i64 }*, %MatchArmMutations)
declare { %ParameterBinding*, i64 }* @merge_parameter_bindings({ %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }*)
declare { %ParameterBinding*, i64 }* @append_parameter_binding({ %ParameterBinding*, i64 }*, %ParameterBinding)
declare { %StringConstant*, i64 }* @empty_string_constant_set()
declare { %StringConstant*, i64 }* @string_constant_singleton(%StringConstant)
declare { %StringConstant*, i64 }* @clone_string_constants({ %StringConstant*, i64 }*)
declare { %StringConstant*, i64 }* @append_string_constant({ %StringConstant*, i64 }*, %StringConstant)
declare { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }*, { %StringConstant*, i64 }*)
declare %StringConstant* @find_string_constant({ %StringConstant*, i64 }*, i8*)
declare %StringConstant* @find_string_constant_by_name({ %StringConstant*, i64 }*, i8*)
declare { i8**, i64 }* @render_string_constants({ %StringConstant*, i64 }*)
declare i8* @escape_string_for_llvm(i8*)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)
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
declare { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }*, %NativeEnumVariantField)
declare { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }*, %NativeStructField)
declare { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }*, %NativeStructLayoutField)
declare double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }*, i8*)
declare { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }*, double, %NativeStructLayoutField)
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
declare %Token @eof_token(double, double)
declare %TypecheckResult @typecheck_program(%Program)
declare { %Statement*, i64 }* @collect_interface_definitions(%Program)
declare %SymbolCollectionResult @collect_top_level_symbols(%Program)
declare %SymbolCollectionResult @register_top_level_symbol(%Statement, { %SymbolEntry*, i64 }*)
declare { %Diagnostic*, i64 }* @check_program_scopes(%Program, { %Statement*, i64 }*)
declare %ScopeResult @check_statement(%Statement, { %SymbolEntry*, i64 }*, { %Statement*, i64 }*)
declare { %Diagnostic*, i64 }* @check_function_body(%FunctionSignature, %Block, { %Statement*, i64 }*)
declare %ScopeResult @seed_parameter_scope(%FunctionSignature)
declare { %Diagnostic*, i64 }* @check_block(%Block, { %SymbolEntry*, i64 }*, { %Statement*, i64 }*)
declare { %Diagnostic*, i64 }* @check_struct_implements_interfaces(%Statement, { %Statement*, i64 }*)
declare %Statement* @resolve_interface_annotation(%TypeAnnotation, { %Statement*, i64 }*)
declare { %Diagnostic*, i64 }* @check_struct_fields({ %FieldDeclaration*, i64 }*)
declare { %Diagnostic*, i64 }* @validate_interface_annotation(i8*, %Statement, %TypeAnnotation)
declare i8* @format_interface_signature(%Statement)
declare { i8**, i64 }* @parse_type_arguments(i8*)
declare i8* @extract_generic_argument_block(i8*)
declare { i8**, i64 }* @split_generic_argument_list(i8*)
declare i8* @slice_text(i8*, double, double)
declare i1 @is_whitespace(i8*)
declare { %Diagnostic*, i64 }* @check_struct_methods({ %MethodDeclaration*, i64 }*)
declare { %Diagnostic*, i64 }* @check_enum_variants({ %EnumVariant*, i64 }*)
declare { %Diagnostic*, i64 }* @check_interface_members({ %FunctionSignature*, i64 }*)
declare { %Diagnostic*, i64 }* @check_model_properties({ %ModelProperty*, i64 }*)
declare { %Diagnostic*, i64 }* @check_function_signature(%FunctionSignature)
declare { %Diagnostic*, i64 }* @check_type_parameters({ %TypeParameter*, i64 }*)
declare { %Diagnostic*, i64 }* @build_effect_diagnostics(%Program)
declare %EffectRequirement* @select_requirement_for_effect({ %EffectRequirement*, i64 }*, i8*)
declare %Token* @requirement_primary_token(%EffectRequirement*)
declare i8* @format_effect_message(i8*, i8*, %EffectRequirement*)
declare %ScopeResult @register_local_symbol({ %SymbolEntry*, i64 }*, i8*, i8*, %SourceSpan*)
declare %SymbolCollectionResult @register_symbol(i8*, i8*, %SourceSpan*, { %SymbolEntry*, i64 }*)
declare { %SymbolEntry*, i64 }* @append_symbol({ %SymbolEntry*, i64 }*, i8*, i8*, %SourceSpan*)
declare { %SymbolEntry*, i64 }* @clone_bindings({ %SymbolEntry*, i64 }*)
declare i1 @has_symbol({ %SymbolEntry*, i64 }*, i8*)
declare %Diagnostic @make_interface_missing_type_arguments_diagnostic(i8*, i8*, i8*)
declare %Diagnostic @make_interface_type_argument_mismatch_diagnostic(i8*, i8*, i8*)
declare %Diagnostic @make_interface_no_type_arguments_diagnostic(i8*, i8*, i8*)
declare %Token* @token_from_name(i8*, %SourceSpan*)
declare %Diagnostic @make_duplicate_symbol_diagnostic(i8*, i8*, %Token*)
declare %Diagnostic @make_missing_interface_member_diagnostic(i8*, i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime__main = external global i8**

; fn compile_to_sailfin effects: ![io]
declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define i8* @compile_to_sailfin(i8* %source) {
block.entry:
  %l0 = alloca %Program
  %l1 = alloca %TypecheckResult
  %t0 = call %Program @parse_program(i8* %source)
  store %Program %t0, %Program* %l0
  %t1 = load %Program, %Program* %l0
  %t2 = call %TypecheckResult @typecheck_program(%Program %t1)
  store %TypecheckResult %t2, %TypecheckResult* %l1
  %t3 = load %TypecheckResult, %TypecheckResult* %l1
  %t4 = extractvalue %TypecheckResult %t3, 0
  %t5 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t4
  %t6 = extractvalue { %Diagnostic*, i64 } %t5, 1
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load %Program, %Program* %l0
  %t9 = load %TypecheckResult, %TypecheckResult* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load %TypecheckResult, %TypecheckResult* %l1
  %t11 = extractvalue %TypecheckResult %t10, 0
  call void @report_typecheck_errors({ %Diagnostic*, i64 }* %t11, i8* %source)
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  ret i8* %t12
merge1:
  %t14 = load %Program, %Program* %l0
  %t15 = call i8* @emit_program(%Program %t14)
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
}

; fn compile_to_native effects: ![io]
define %EmitNativeResult @compile_to_native(i8* %source) {
block.entry:
  %l0 = alloca %Program
  %l1 = alloca %TypecheckResult
  %t0 = call %Program @parse_program(i8* %source)
  store %Program %t0, %Program* %l0
  %t1 = load %Program, %Program* %l0
  %t2 = call %TypecheckResult @typecheck_program(%Program %t1)
  store %TypecheckResult %t2, %TypecheckResult* %l1
  %t3 = load %TypecheckResult, %TypecheckResult* %l1
  %t4 = extractvalue %TypecheckResult %t3, 0
  %t5 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t4
  %t6 = extractvalue { %Diagnostic*, i64 } %t5, 1
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load %Program, %Program* %l0
  %t9 = load %TypecheckResult, %TypecheckResult* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load %TypecheckResult, %TypecheckResult* %l1
  %t11 = extractvalue %TypecheckResult %t10, 0
  call void @report_typecheck_errors({ %Diagnostic*, i64 }* %t11, i8* %source)
  %t12 = call %NativeModule @empty_native_module()
  %t13 = insertvalue %EmitNativeResult undef, %NativeModule %t12, 0
  %t14 = load %TypecheckResult, %TypecheckResult* %l1
  %t15 = extractvalue %TypecheckResult %t14, 0
  %t16 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %t15, i8* %source)
  %t17 = insertvalue %EmitNativeResult %t13, { i8**, i64 }* %t16, 1
  ret %EmitNativeResult %t17
merge1:
  %t18 = load %Program, %Program* %l0
  %t19 = call %EmitNativeResult @emit_native(%Program %t18)
  ret %EmitNativeResult %t19
}

; fn compile_to_native_python effects: ![io]
define %LoweredPythonResult @compile_to_native_python(i8* %source) {
block.entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca %LoweredPythonResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t2 = extractvalue %EmitNativeResult %t1, 0
  %t3 = call %LoweredPythonResult @lower_to_python(%NativeModule %t2)
  store %LoweredPythonResult %t3, %LoweredPythonResult* %l1
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
  store { i8**, i64 }* %t13, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t18 = extractvalue %EmitNativeResult %t17, 1
  %t19 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t16, { i8**, i64 }* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t21 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t22 = extractvalue %LoweredPythonResult %t21, 1
  %t23 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t20, { i8**, i64 }* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t26 = extractvalue { i8**, i64 } %t25, 1
  %t27 = icmp sgt i64 %t26, 0
  %t28 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t29 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t27, label %then0, label %merge1
then0:
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l3
  %t32 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t33 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t63 = phi double [ %t35, %then0 ], [ %t62, %loop.latch4 ]
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t36 = load double, double* %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = sitofp i64 %t39 to double
  %t41 = fcmp oge double %t36, %t40
  %t42 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t43 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  br i1 %t41, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t46 = call i8* @malloc(i64 10)
  %t47 = bitcast i8* %t46 to [10 x i8]*
  store [10 x i8] c"[native] \00", [10 x i8]* %t47
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = call double @llvm.round.f64(double %t49)
  %t51 = fptosi double %t50 to i64
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t53 = extractvalue { i8**, i64 } %t52, 0
  %t54 = extractvalue { i8**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t51, i64 %t54)
  %t56 = getelementptr i8*, i8** %t53, i64 %t51
  %t57 = load i8*, i8** %t56
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t57)
  call void @sailfin_runtime_print_warn(i8* %t58)
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch4
loop.latch4:
  %t62 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load double, double* %l3
  br label %merge1
merge1:
  %t65 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t66 = extractvalue %LoweredPythonResult %t65, 0
  %t67 = insertvalue %LoweredPythonResult undef, i8* %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = insertvalue %LoweredPythonResult %t67, { i8**, i64 }* %t68, 1
  ret %LoweredPythonResult %t69
}

; fn compile_to_native_llvm effects: ![io]
define %LoweredLLVMResult @compile_to_native_llvm(i8* %source) {
block.entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca %LoweredLLVMResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t2 = extractvalue %EmitNativeResult %t1, 0
  %t3 = call %LoweredLLVMResult @lower_to_llvm(%NativeModule %t2)
  store %LoweredLLVMResult %t3, %LoweredLLVMResult* %l1
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
  store { i8**, i64 }* %t13, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t18 = extractvalue %EmitNativeResult %t17, 1
  %t19 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t16, { i8**, i64 }* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t21 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t22 = extractvalue %LoweredLLVMResult %t21, 1
  %t23 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t20, { i8**, i64 }* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t26 = extractvalue { i8**, i64 } %t25, 1
  %t27 = icmp sgt i64 %t26, 0
  %t28 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t29 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t27, label %then0, label %merge1
then0:
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l3
  %t32 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t33 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t63 = phi double [ %t35, %then0 ], [ %t62, %loop.latch4 ]
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t36 = load double, double* %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = sitofp i64 %t39 to double
  %t41 = fcmp oge double %t36, %t40
  %t42 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t43 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  br i1 %t41, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t46 = call i8* @malloc(i64 15)
  %t47 = bitcast i8* %t46 to [15 x i8]*
  store [15 x i8] c"[native-llvm] \00", [15 x i8]* %t47
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = call double @llvm.round.f64(double %t49)
  %t51 = fptosi double %t50 to i64
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t53 = extractvalue { i8**, i64 } %t52, 0
  %t54 = extractvalue { i8**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t51, i64 %t54)
  %t56 = getelementptr i8*, i8** %t53, i64 %t51
  %t57 = load i8*, i8** %t56
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t57)
  call void @sailfin_runtime_print_warn(i8* %t58)
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch4
loop.latch4:
  %t62 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load double, double* %l3
  br label %merge1
merge1:
  %t65 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t66 = extractvalue %LoweredLLVMResult %t65, 0
  %t67 = insertvalue %LoweredLLVMResult undef, i8* %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = insertvalue %LoweredLLVMResult %t67, { i8**, i64 }* %t68, 1
  %t70 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t71 = extractvalue %LoweredLLVMResult %t70, 2
  %t72 = insertvalue %LoweredLLVMResult %t69, %TraitMetadata %t71, 2
  %t73 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t74 = extractvalue %LoweredLLVMResult %t73, 3
  %t75 = insertvalue %LoweredLLVMResult %t72, { %FunctionEffectEntry*, i64 }* %t74, 3
  %t76 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t77 = extractvalue %LoweredLLVMResult %t76, 4
  %t78 = insertvalue %LoweredLLVMResult %t75, { %LifetimeRegionMetadata*, i64 }* %t77, 4
  %t79 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t80 = extractvalue %LoweredLLVMResult %t79, 5
  %t81 = insertvalue %LoweredLLVMResult %t78, %CapabilityManifest %t80, 5
  %t82 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t83 = extractvalue %LoweredLLVMResult %t82, 6
  %t84 = insertvalue %LoweredLLVMResult %t81, { %StringConstant*, i64 }* %t83, 6
  ret %LoweredLLVMResult %t84
}

; fn compile_to_llvm effects: ![io]
define i8* @compile_to_llvm(i8* %source) {
block.entry:
  %l0 = alloca %LoweredLLVMResult
  %t0 = call %LoweredLLVMResult @compile_to_native_llvm(i8* %source)
  store %LoweredLLVMResult %t0, %LoweredLLVMResult* %l0
  %t1 = load %LoweredLLVMResult, %LoweredLLVMResult* %l0
  %t2 = extractvalue %LoweredLLVMResult %t1, 0
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
}

; fn compile_to_native_llvm_full effects: ![io]
define %LLVMCompilationResult @compile_to_native_llvm_full(i8* %source) {
block.entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca %LoweredLLVMResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t2 = extractvalue %EmitNativeResult %t1, 0
  %t3 = call %LoweredLLVMResult @lower_to_llvm(%NativeModule %t2)
  store %LoweredLLVMResult %t3, %LoweredLLVMResult* %l1
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
  store { i8**, i64 }* %t13, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t18 = extractvalue %EmitNativeResult %t17, 1
  %t19 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t16, { i8**, i64 }* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t21 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t22 = extractvalue %LoweredLLVMResult %t21, 1
  %t23 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t20, { i8**, i64 }* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t26 = extractvalue { i8**, i64 } %t25, 1
  %t27 = icmp sgt i64 %t26, 0
  %t28 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t29 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t27, label %then0, label %merge1
then0:
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l3
  %t32 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t33 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t63 = phi double [ %t35, %then0 ], [ %t62, %loop.latch4 ]
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t36 = load double, double* %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = sitofp i64 %t39 to double
  %t41 = fcmp oge double %t36, %t40
  %t42 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t43 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  br i1 %t41, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t46 = call i8* @malloc(i64 15)
  %t47 = bitcast i8* %t46 to [15 x i8]*
  store [15 x i8] c"[native-llvm] \00", [15 x i8]* %t47
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = call double @llvm.round.f64(double %t49)
  %t51 = fptosi double %t50 to i64
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t53 = extractvalue { i8**, i64 } %t52, 0
  %t54 = extractvalue { i8**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t51, i64 %t54)
  %t56 = getelementptr i8*, i8** %t53, i64 %t51
  %t57 = load i8*, i8** %t56
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t57)
  call void @sailfin_runtime_print_warn(i8* %t58)
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch4
loop.latch4:
  %t62 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load double, double* %l3
  br label %merge1
merge1:
  %t65 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t66 = extractvalue %LoweredLLVMResult %t65, 0
  %t67 = insertvalue %LoweredLLVMResult undef, i8* %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = insertvalue %LoweredLLVMResult %t67, { i8**, i64 }* %t68, 1
  %t70 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t71 = extractvalue %LoweredLLVMResult %t70, 2
  %t72 = insertvalue %LoweredLLVMResult %t69, %TraitMetadata %t71, 2
  %t73 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t74 = extractvalue %LoweredLLVMResult %t73, 3
  %t75 = insertvalue %LoweredLLVMResult %t72, { %FunctionEffectEntry*, i64 }* %t74, 3
  %t76 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t77 = extractvalue %LoweredLLVMResult %t76, 4
  %t78 = insertvalue %LoweredLLVMResult %t75, { %LifetimeRegionMetadata*, i64 }* %t77, 4
  %t79 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t80 = extractvalue %LoweredLLVMResult %t79, 5
  %t81 = insertvalue %LoweredLLVMResult %t78, %CapabilityManifest %t80, 5
  %t82 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t83 = extractvalue %LoweredLLVMResult %t82, 6
  %t84 = insertvalue %LoweredLLVMResult %t81, { %StringConstant*, i64 }* %t83, 6
  %t85 = getelementptr %LoweredLLVMResult, %LoweredLLVMResult* null, i32 1
  %t86 = ptrtoint %LoweredLLVMResult* %t85 to i64
  %t87 = call noalias i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to %LoweredLLVMResult*
  store %LoweredLLVMResult %t84, %LoweredLLVMResult* %t88
  call void @sailfin_runtime_mark_persistent(i8* %t87)
  %t89 = insertvalue %LLVMCompilationResult undef, i8* %t87, 0
  %t90 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t91 = extractvalue %EmitNativeResult %t90, 0
  %t92 = getelementptr %NativeModule, %NativeModule* null, i32 1
  %t93 = ptrtoint %NativeModule* %t92 to i64
  %t94 = call noalias i8* @malloc(i64 %t93)
  %t95 = bitcast i8* %t94 to %NativeModule*
  store %NativeModule %t91, %NativeModule* %t95
  call void @sailfin_runtime_mark_persistent(i8* %t94)
  %t96 = insertvalue %LLVMCompilationResult %t89, i8* %t94, 1
  ret %LLVMCompilationResult %t96
}

; fn compile_to_native_llvm_with_context effects: ![io]
define %LoweredLLVMResult @compile_to_native_llvm_with_context(i8* %source, { i8**, i64 }* %manifest_contents, { i8**, i64 }* %native_artifacts) {
block.entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca { %LayoutManifest*, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca %LayoutManifest
  %l5 = alloca %LoweredLLVMResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = getelementptr [0 x %LayoutManifest], [0 x %LayoutManifest]* null, i32 1
  %t2 = ptrtoint [0 x %LayoutManifest]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %LayoutManifest*
  %t7 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* null, i32 1
  %t8 = ptrtoint { %LayoutManifest*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %LayoutManifest*, i64 }*
  %t11 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t10, i32 0, i32 0
  store %LayoutManifest* %t6, %LayoutManifest** %t11
  %t12 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { %LayoutManifest*, i64 }* %t10, { %LayoutManifest*, i64 }** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t15 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t191 = phi { %LayoutManifest*, i64 }* [ %t15, %block.entry ], [ %t189, %loop.latch2 ]
  %t192 = phi double [ %t16, %block.entry ], [ %t190, %loop.latch2 ]
  store { %LayoutManifest*, i64 }* %t191, { %LayoutManifest*, i64 }** %l1
  store double %t192, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t19 = extractvalue { i8**, i64 } %t18, 1
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t17, %t20
  %t22 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t23 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l2
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t38 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %else7
then6:
  %t41 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t42 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* null, i32 1
  %t43 = ptrtoint [0 x %NativeStruct]* %t42 to i64
  %t44 = icmp eq i64 %t43, 0
  %t45 = select i1 %t44, i64 1, i64 %t43
  %t46 = call i8* @malloc(i64 %t45)
  %t47 = bitcast i8* %t46 to %NativeStruct*
  %t48 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t49 = ptrtoint { %NativeStruct*, i64 }* %t48 to i64
  %t50 = call i8* @malloc(i64 %t49)
  %t51 = bitcast i8* %t50 to { %NativeStruct*, i64 }*
  %t52 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t51, i32 0, i32 0
  store %NativeStruct* %t47, %NativeStruct** %t52
  %t53 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t51, i32 0, i32 1
  store i64 0, i64* %t53
  %t54 = insertvalue %LayoutManifest undef, { %NativeStruct*, i64 }* %t51, 0
  %t55 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* null, i32 1
  %t56 = ptrtoint [0 x %NativeEnum]* %t55 to i64
  %t57 = icmp eq i64 %t56, 0
  %t58 = select i1 %t57, i64 1, i64 %t56
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to %NativeEnum*
  %t61 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t62 = ptrtoint { %NativeEnum*, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { %NativeEnum*, i64 }*
  %t65 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t64, i32 0, i32 0
  store %NativeEnum* %t60, %NativeEnum** %t65
  %t66 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  %t67 = insertvalue %LayoutManifest %t54, { %NativeEnum*, i64 }* %t64, 1
  %t68 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t69 = ptrtoint [0 x i8*]* %t68 to i64
  %t70 = icmp eq i64 %t69, 0
  %t71 = select i1 %t70, i64 1, i64 %t69
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to i8**
  %t74 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t75 = ptrtoint { i8**, i64 }* %t74 to i64
  %t76 = call i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to { i8**, i64 }*
  %t78 = getelementptr { i8**, i64 }, { i8**, i64 }* %t77, i32 0, i32 0
  store i8** %t73, i8*** %t78
  %t79 = getelementptr { i8**, i64 }, { i8**, i64 }* %t77, i32 0, i32 1
  store i64 0, i64* %t79
  %t80 = insertvalue %LayoutManifest %t67, { i8**, i64 }* %t77, 2
  %t81 = getelementptr [1 x %LayoutManifest], [1 x %LayoutManifest]* null, i32 1
  %t82 = ptrtoint [1 x %LayoutManifest]* %t81 to i64
  %t83 = icmp eq i64 %t82, 0
  %t84 = select i1 %t83, i64 1, i64 %t82
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to %LayoutManifest*
  %t87 = getelementptr %LayoutManifest, %LayoutManifest* %t86, i64 0
  store %LayoutManifest %t80, %LayoutManifest* %t87
  %t88 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* null, i32 1
  %t89 = ptrtoint { %LayoutManifest*, i64 }* %t88 to i64
  %t90 = call i8* @malloc(i64 %t89)
  %t91 = bitcast i8* %t90 to { %LayoutManifest*, i64 }*
  %t92 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t91, i32 0, i32 0
  store %LayoutManifest* %t86, %LayoutManifest** %t92
  %t93 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t91, i32 0, i32 1
  store i64 1, i64* %t93
  %t94 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t41, i32 0, i32 0
  %t95 = load %LayoutManifest*, %LayoutManifest** %t94
  %t96 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t41, i32 0, i32 1
  %t97 = load i64, i64* %t96
  %t98 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t91, i32 0, i32 0
  %t99 = load %LayoutManifest*, %LayoutManifest** %t98
  %t100 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t91, i32 0, i32 1
  %t101 = load i64, i64* %t100
  %t102 = getelementptr [1 x %LayoutManifest], [1 x %LayoutManifest]* null, i32 0, i32 1
  %t103 = ptrtoint %LayoutManifest* %t102 to i64
  %t104 = add i64 %t97, %t101
  %t105 = mul i64 %t103, %t104
  %t106 = call noalias i8* @malloc(i64 %t105)
  %t107 = bitcast i8* %t106 to %LayoutManifest*
  %t108 = bitcast %LayoutManifest* %t107 to i8*
  %t109 = mul i64 %t103, %t97
  %t110 = bitcast %LayoutManifest* %t95 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t108, i8* %t110, i64 %t109)
  %t111 = mul i64 %t103, %t101
  %t112 = bitcast %LayoutManifest* %t99 to i8*
  %t113 = getelementptr %LayoutManifest, %LayoutManifest* %t107, i64 %t97
  %t114 = bitcast %LayoutManifest* %t113 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t114, i8* %t112, i64 %t111)
  %t115 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* null, i32 1
  %t116 = ptrtoint { %LayoutManifest*, i64 }* %t115 to i64
  %t117 = call i8* @malloc(i64 %t116)
  %t118 = bitcast i8* %t117 to { %LayoutManifest*, i64 }*
  %t119 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t118, i32 0, i32 0
  store %LayoutManifest* %t107, %LayoutManifest** %t119
  %t120 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t118, i32 0, i32 1
  store i64 %t104, i64* %t120
  store { %LayoutManifest*, i64 }* %t118, { %LayoutManifest*, i64 }** %l1
  %t121 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  br label %merge8
else7:
  %t122 = load i8*, i8** %l3
  %t123 = call %LayoutManifest @parse_layout_manifest(i8* %t122)
  store %LayoutManifest %t123, %LayoutManifest* %l4
  %t124 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t125 = load %LayoutManifest, %LayoutManifest* %l4
  %t126 = extractvalue %LayoutManifest %t125, 0
  %t127 = insertvalue %LayoutManifest undef, { %NativeStruct*, i64 }* %t126, 0
  %t128 = load %LayoutManifest, %LayoutManifest* %l4
  %t129 = extractvalue %LayoutManifest %t128, 1
  %t130 = insertvalue %LayoutManifest %t127, { %NativeEnum*, i64 }* %t129, 1
  %t131 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t132 = ptrtoint [0 x i8*]* %t131 to i64
  %t133 = icmp eq i64 %t132, 0
  %t134 = select i1 %t133, i64 1, i64 %t132
  %t135 = call i8* @malloc(i64 %t134)
  %t136 = bitcast i8* %t135 to i8**
  %t137 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t138 = ptrtoint { i8**, i64 }* %t137 to i64
  %t139 = call i8* @malloc(i64 %t138)
  %t140 = bitcast i8* %t139 to { i8**, i64 }*
  %t141 = getelementptr { i8**, i64 }, { i8**, i64 }* %t140, i32 0, i32 0
  store i8** %t136, i8*** %t141
  %t142 = getelementptr { i8**, i64 }, { i8**, i64 }* %t140, i32 0, i32 1
  store i64 0, i64* %t142
  %t143 = insertvalue %LayoutManifest %t130, { i8**, i64 }* %t140, 2
  %t144 = getelementptr [1 x %LayoutManifest], [1 x %LayoutManifest]* null, i32 1
  %t145 = ptrtoint [1 x %LayoutManifest]* %t144 to i64
  %t146 = icmp eq i64 %t145, 0
  %t147 = select i1 %t146, i64 1, i64 %t145
  %t148 = call i8* @malloc(i64 %t147)
  %t149 = bitcast i8* %t148 to %LayoutManifest*
  %t150 = getelementptr %LayoutManifest, %LayoutManifest* %t149, i64 0
  store %LayoutManifest %t143, %LayoutManifest* %t150
  %t151 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* null, i32 1
  %t152 = ptrtoint { %LayoutManifest*, i64 }* %t151 to i64
  %t153 = call i8* @malloc(i64 %t152)
  %t154 = bitcast i8* %t153 to { %LayoutManifest*, i64 }*
  %t155 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t154, i32 0, i32 0
  store %LayoutManifest* %t149, %LayoutManifest** %t155
  %t156 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t154, i32 0, i32 1
  store i64 1, i64* %t156
  %t157 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t124, i32 0, i32 0
  %t158 = load %LayoutManifest*, %LayoutManifest** %t157
  %t159 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t124, i32 0, i32 1
  %t160 = load i64, i64* %t159
  %t161 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t154, i32 0, i32 0
  %t162 = load %LayoutManifest*, %LayoutManifest** %t161
  %t163 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t154, i32 0, i32 1
  %t164 = load i64, i64* %t163
  %t165 = getelementptr [1 x %LayoutManifest], [1 x %LayoutManifest]* null, i32 0, i32 1
  %t166 = ptrtoint %LayoutManifest* %t165 to i64
  %t167 = add i64 %t160, %t164
  %t168 = mul i64 %t166, %t167
  %t169 = call noalias i8* @malloc(i64 %t168)
  %t170 = bitcast i8* %t169 to %LayoutManifest*
  %t171 = bitcast %LayoutManifest* %t170 to i8*
  %t172 = mul i64 %t166, %t160
  %t173 = bitcast %LayoutManifest* %t158 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t171, i8* %t173, i64 %t172)
  %t174 = mul i64 %t166, %t164
  %t175 = bitcast %LayoutManifest* %t162 to i8*
  %t176 = getelementptr %LayoutManifest, %LayoutManifest* %t170, i64 %t160
  %t177 = bitcast %LayoutManifest* %t176 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t177, i8* %t175, i64 %t174)
  %t178 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* null, i32 1
  %t179 = ptrtoint { %LayoutManifest*, i64 }* %t178 to i64
  %t180 = call i8* @malloc(i64 %t179)
  %t181 = bitcast i8* %t180 to { %LayoutManifest*, i64 }*
  %t182 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t181, i32 0, i32 0
  store %LayoutManifest* %t170, %LayoutManifest** %t182
  %t183 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t181, i32 0, i32 1
  store i64 %t167, i64* %t183
  store { %LayoutManifest*, i64 }* %t181, { %LayoutManifest*, i64 }** %l1
  %t184 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  br label %merge8
merge8:
  %t185 = phi { %LayoutManifest*, i64 }* [ %t121, %then6 ], [ %t184, %else7 ]
  store { %LayoutManifest*, i64 }* %t185, { %LayoutManifest*, i64 }** %l1
  %t186 = load double, double* %l2
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  store double %t188, double* %l2
  br label %loop.latch2
loop.latch2:
  %t189 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t190 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t193 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t194 = load double, double* %l2
  %t195 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t196 = extractvalue %EmitNativeResult %t195, 0
  %t197 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t198 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t199 = ptrtoint [0 x i8*]* %t198 to i64
  %t200 = icmp eq i64 %t199, 0
  %t201 = select i1 %t200, i64 1, i64 %t199
  %t202 = call i8* @malloc(i64 %t201)
  %t203 = bitcast i8* %t202 to i8**
  %t204 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t205 = ptrtoint { i8**, i64 }* %t204 to i64
  %t206 = call i8* @malloc(i64 %t205)
  %t207 = bitcast i8* %t206 to { i8**, i64 }*
  %t208 = getelementptr { i8**, i64 }, { i8**, i64 }* %t207, i32 0, i32 0
  store i8** %t203, i8*** %t208
  %t209 = getelementptr { i8**, i64 }, { i8**, i64 }* %t207, i32 0, i32 1
  store i64 0, i64* %t209
  %t210 = call %LoweredLLVMResult @lower_to_llvm_with_context(%NativeModule %t196, { %LayoutManifest*, i64 }* %t197, { i8**, i64 }* %native_artifacts, { i8**, i64 }* %t207)
  store %LoweredLLVMResult %t210, %LoweredLLVMResult* %l5
  %t211 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t212 = ptrtoint [0 x i8*]* %t211 to i64
  %t213 = icmp eq i64 %t212, 0
  %t214 = select i1 %t213, i64 1, i64 %t212
  %t215 = call i8* @malloc(i64 %t214)
  %t216 = bitcast i8* %t215 to i8**
  %t217 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t218 = ptrtoint { i8**, i64 }* %t217 to i64
  %t219 = call i8* @malloc(i64 %t218)
  %t220 = bitcast i8* %t219 to { i8**, i64 }*
  %t221 = getelementptr { i8**, i64 }, { i8**, i64 }* %t220, i32 0, i32 0
  store i8** %t216, i8*** %t221
  %t222 = getelementptr { i8**, i64 }, { i8**, i64 }* %t220, i32 0, i32 1
  store i64 0, i64* %t222
  store { i8**, i64 }* %t220, { i8**, i64 }** %l6
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t224 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t225 = extractvalue %EmitNativeResult %t224, 1
  %t226 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t223, { i8**, i64 }* %t225)
  store { i8**, i64 }* %t226, { i8**, i64 }** %l6
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t228 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t229 = extractvalue %LoweredLLVMResult %t228, 1
  %t230 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t227, { i8**, i64 }* %t229)
  store { i8**, i64 }* %t230, { i8**, i64 }** %l6
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t232 = load { i8**, i64 }, { i8**, i64 }* %t231
  %t233 = extractvalue { i8**, i64 } %t232, 1
  %t234 = icmp sgt i64 %t233, 0
  %t235 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t236 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t237 = load double, double* %l2
  %t238 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t234, label %then9, label %merge10
then9:
  %t240 = sitofp i64 0 to double
  store double %t240, double* %l7
  %t241 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t242 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t243 = load double, double* %l2
  %t244 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t246 = load double, double* %l7
  br label %loop.header11
loop.header11:
  %t276 = phi double [ %t246, %then9 ], [ %t275, %loop.latch13 ]
  store double %t276, double* %l7
  br label %loop.body12
loop.body12:
  %t247 = load double, double* %l7
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t249 = load { i8**, i64 }, { i8**, i64 }* %t248
  %t250 = extractvalue { i8**, i64 } %t249, 1
  %t251 = sitofp i64 %t250 to double
  %t252 = fcmp oge double %t247, %t251
  %t253 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t254 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t255 = load double, double* %l2
  %t256 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t258 = load double, double* %l7
  br i1 %t252, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t259 = call i8* @malloc(i64 15)
  %t260 = bitcast i8* %t259 to [15 x i8]*
  store [15 x i8] c"[native-llvm] \00", [15 x i8]* %t260
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t262 = load double, double* %l7
  %t263 = call double @llvm.round.f64(double %t262)
  %t264 = fptosi double %t263 to i64
  %t265 = load { i8**, i64 }, { i8**, i64 }* %t261
  %t266 = extractvalue { i8**, i64 } %t265, 0
  %t267 = extractvalue { i8**, i64 } %t265, 1
  %t268 = icmp uge i64 %t264, %t267
  ; bounds check: %t268 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t264, i64 %t267)
  %t269 = getelementptr i8*, i8** %t266, i64 %t264
  %t270 = load i8*, i8** %t269
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t259, i8* %t270)
  call void @sailfin_runtime_print_warn(i8* %t271)
  %t272 = load double, double* %l7
  %t273 = sitofp i64 1 to double
  %t274 = fadd double %t272, %t273
  store double %t274, double* %l7
  br label %loop.latch13
loop.latch13:
  %t275 = load double, double* %l7
  br label %loop.header11
afterloop14:
  %t277 = load double, double* %l7
  br label %merge10
merge10:
  %t278 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t279 = extractvalue %LoweredLLVMResult %t278, 0
  %t280 = insertvalue %LoweredLLVMResult undef, i8* %t279, 0
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t282 = insertvalue %LoweredLLVMResult %t280, { i8**, i64 }* %t281, 1
  %t283 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t284 = extractvalue %LoweredLLVMResult %t283, 2
  %t285 = insertvalue %LoweredLLVMResult %t282, %TraitMetadata %t284, 2
  %t286 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t287 = extractvalue %LoweredLLVMResult %t286, 3
  %t288 = insertvalue %LoweredLLVMResult %t285, { %FunctionEffectEntry*, i64 }* %t287, 3
  %t289 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t290 = extractvalue %LoweredLLVMResult %t289, 4
  %t291 = insertvalue %LoweredLLVMResult %t288, { %LifetimeRegionMetadata*, i64 }* %t290, 4
  %t292 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t293 = extractvalue %LoweredLLVMResult %t292, 5
  %t294 = insertvalue %LoweredLLVMResult %t291, %CapabilityManifest %t293, 5
  %t295 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t296 = extractvalue %LoweredLLVMResult %t295, 6
  %t297 = insertvalue %LoweredLLVMResult %t294, { %StringConstant*, i64 }* %t296, 6
  ret %LoweredLLVMResult %t297
}

; fn compile_to_native_llvm_with_manifests effects: ![io]
define %LoweredLLVMResult @compile_to_native_llvm_with_manifests(i8* %source, { i8**, i64 }* %manifest_contents) {
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
  %t12 = call %LoweredLLVMResult @compile_to_native_llvm_with_context(i8* %source, { i8**, i64 }* %manifest_contents, { i8**, i64 }* %t9)
  ret %LoweredLLVMResult %t12
}

; fn main effects: ![io]
define void @stage2_compiler_main() {
block.entry:
  %t0 = call i8* @malloc(i64 17)
  %t1 = bitcast i8* %t0 to [17 x i8]*
  store [17 x i8] c"Sailfin compiler\00", [17 x i8]* %t1
  call void @sailfin_runtime_print_info(i8* %t0)
  ret void
}

; fn compile_project effects: ![io]
define %ProjectCompilation @compile_project({ i8**, i64 }* %sources) {
block.entry:
  %l0 = alloca { %CompiledModule*, i64 }*
  %l1 = alloca { %ModuleDiagnostics*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %ModuleCompilationResult
  %t0 = getelementptr [0 x %CompiledModule], [0 x %CompiledModule]* null, i32 1
  %t1 = ptrtoint [0 x %CompiledModule]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %CompiledModule*
  %t6 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* null, i32 1
  %t7 = ptrtoint { %CompiledModule*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %CompiledModule*, i64 }*
  %t10 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t9, i32 0, i32 0
  store %CompiledModule* %t5, %CompiledModule** %t10
  %t11 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %CompiledModule*, i64 }* %t9, { %CompiledModule*, i64 }** %l0
  %t12 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* null, i32 1
  %t13 = ptrtoint [0 x %ModuleDiagnostics]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %ModuleDiagnostics*
  %t18 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t19 = ptrtoint { %ModuleDiagnostics*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %ModuleDiagnostics*, i64 }*
  %t22 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t21, i32 0, i32 0
  store %ModuleDiagnostics* %t17, %ModuleDiagnostics** %t22
  %t23 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %ModuleDiagnostics*, i64 }* %t21, { %ModuleDiagnostics*, i64 }** %l1
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 0
  %t27 = load i8**, i8*** %t26
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr i8*, i8** %t27, i64 %t30
  %t32 = load i8*, i8** %t31
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = call %ModuleCompilationResult @compile_source_at_path(i8* %t33)
  store %ModuleCompilationResult %t34, %ModuleCompilationResult* %l4
  %t35 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t36 = extractvalue %ModuleCompilationResult %t35, 0
  %t37 = icmp ne %CompiledModule* %t36, null
  %t38 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t39 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t40 = load i8*, i8** %l3
  %t41 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t37, label %then4, label %merge5
then4:
  %t42 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t43 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t44 = extractvalue %ModuleCompilationResult %t43, 0
  %t45 = getelementptr [1 x %CompiledModule*], [1 x %CompiledModule*]* null, i32 1
  %t46 = ptrtoint [1 x %CompiledModule*]* %t45 to i64
  %t47 = icmp eq i64 %t46, 0
  %t48 = select i1 %t47, i64 1, i64 %t46
  %t49 = call i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to %CompiledModule**
  %t51 = getelementptr %CompiledModule*, %CompiledModule** %t50, i64 0
  store %CompiledModule* %t44, %CompiledModule** %t51
  %t52 = getelementptr { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* null, i32 1
  %t53 = ptrtoint { %CompiledModule**, i64 }* %t52 to i64
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to { %CompiledModule**, i64 }*
  %t56 = getelementptr { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* %t55, i32 0, i32 0
  store %CompiledModule** %t50, %CompiledModule*** %t56
  %t57 = getelementptr { %CompiledModule**, i64 }, { %CompiledModule**, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = bitcast { %CompiledModule**, i64 }* %t55 to { %CompiledModule*, i64 }*
  %t59 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t42, i32 0, i32 0
  %t60 = load %CompiledModule*, %CompiledModule** %t59
  %t61 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t42, i32 0, i32 1
  %t62 = load i64, i64* %t61
  %t63 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t58, i32 0, i32 0
  %t64 = load %CompiledModule*, %CompiledModule** %t63
  %t65 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t58, i32 0, i32 1
  %t66 = load i64, i64* %t65
  %t67 = getelementptr [1 x %CompiledModule], [1 x %CompiledModule]* null, i32 0, i32 1
  %t68 = ptrtoint %CompiledModule* %t67 to i64
  %t69 = add i64 %t62, %t66
  %t70 = mul i64 %t68, %t69
  %t71 = call noalias i8* @malloc(i64 %t70)
  %t72 = bitcast i8* %t71 to %CompiledModule*
  %t73 = bitcast %CompiledModule* %t72 to i8*
  %t74 = mul i64 %t68, %t62
  %t75 = bitcast %CompiledModule* %t60 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t73, i8* %t75, i64 %t74)
  %t76 = mul i64 %t68, %t66
  %t77 = bitcast %CompiledModule* %t64 to i8*
  %t78 = getelementptr %CompiledModule, %CompiledModule* %t72, i64 %t62
  %t79 = bitcast %CompiledModule* %t78 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t79, i8* %t77, i64 %t76)
  %t80 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* null, i32 1
  %t81 = ptrtoint { %CompiledModule*, i64 }* %t80 to i64
  %t82 = call i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to { %CompiledModule*, i64 }*
  %t84 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t83, i32 0, i32 0
  store %CompiledModule* %t72, %CompiledModule** %t84
  %t85 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t83, i32 0, i32 1
  store i64 %t69, i64* %t85
  store { %CompiledModule*, i64 }* %t83, { %CompiledModule*, i64 }** %l0
  %t86 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  br label %merge5
merge5:
  %t87 = phi { %CompiledModule*, i64 }* [ %t86, %then4 ], [ %t38, %forbody1 ]
  store { %CompiledModule*, i64 }* %t87, { %CompiledModule*, i64 }** %l0
  %t88 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t89 = extractvalue %ModuleCompilationResult %t88, 1
  %t90 = load { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t89
  %t91 = extractvalue { %ModuleDiagnostics*, i64 } %t90, 1
  %t92 = icmp sgt i64 %t91, 0
  %t93 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t94 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t95 = load i8*, i8** %l3
  %t96 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t92, label %then6, label %merge7
then6:
  %t97 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t98 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t99 = extractvalue %ModuleCompilationResult %t98, 1
  %t100 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t97, i32 0, i32 0
  %t101 = load %ModuleDiagnostics*, %ModuleDiagnostics** %t100
  %t102 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t97, i32 0, i32 1
  %t103 = load i64, i64* %t102
  %t104 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t99, i32 0, i32 0
  %t105 = load %ModuleDiagnostics*, %ModuleDiagnostics** %t104
  %t106 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t99, i32 0, i32 1
  %t107 = load i64, i64* %t106
  %t108 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 0, i32 1
  %t109 = ptrtoint %ModuleDiagnostics* %t108 to i64
  %t110 = add i64 %t103, %t107
  %t111 = mul i64 %t109, %t110
  %t112 = call noalias i8* @malloc(i64 %t111)
  %t113 = bitcast i8* %t112 to %ModuleDiagnostics*
  %t114 = bitcast %ModuleDiagnostics* %t113 to i8*
  %t115 = mul i64 %t109, %t103
  %t116 = bitcast %ModuleDiagnostics* %t101 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t114, i8* %t116, i64 %t115)
  %t117 = mul i64 %t109, %t107
  %t118 = bitcast %ModuleDiagnostics* %t105 to i8*
  %t119 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t113, i64 %t103
  %t120 = bitcast %ModuleDiagnostics* %t119 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t120, i8* %t118, i64 %t117)
  %t121 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t122 = ptrtoint { %ModuleDiagnostics*, i64 }* %t121 to i64
  %t123 = call i8* @malloc(i64 %t122)
  %t124 = bitcast i8* %t123 to { %ModuleDiagnostics*, i64 }*
  %t125 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t124, i32 0, i32 0
  store %ModuleDiagnostics* %t113, %ModuleDiagnostics** %t125
  %t126 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t124, i32 0, i32 1
  store i64 %t110, i64* %t126
  store { %ModuleDiagnostics*, i64 }* %t124, { %ModuleDiagnostics*, i64 }** %l1
  %t127 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  br label %merge7
merge7:
  %t128 = phi { %ModuleDiagnostics*, i64 }* [ %t127, %then6 ], [ %t94, %merge5 ]
  store { %ModuleDiagnostics*, i64 }* %t128, { %ModuleDiagnostics*, i64 }** %l1
  br label %forinc2
forinc2:
  %t129 = load i64, i64* %l2
  %t130 = add i64 %t129, 1
  store i64 %t130, i64* %l2
  br label %for0
afterfor3:
  %t131 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t132 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t133 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t134 = insertvalue %ProjectCompilation undef, { %CompiledModule*, i64 }* %t133, 0
  %t135 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t136 = insertvalue %ProjectCompilation %t134, { %ModuleDiagnostics*, i64 }* %t135, 1
  ret %ProjectCompilation %t136
}

; fn compile_source_at_path effects: ![io]
define %ModuleCompilationResult @compile_source_at_path(i8* %source_path) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %Program
  %l2 = alloca %TypecheckResult
  %l3 = alloca %EmitNativeResult
  %l4 = alloca %LoweredPythonResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca i1
  %l8 = alloca { %ModuleDiagnostics*, i64 }*
  %t0 = call i8* @sailfin_adapter_fs_read_file(i8* %source_path)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call %Program @parse_program(i8* %t1)
  store %Program %t2, %Program* %l1
  %t3 = load %Program, %Program* %l1
  %t4 = call %TypecheckResult @typecheck_program(%Program %t3)
  store %TypecheckResult %t4, %TypecheckResult* %l2
  %t5 = load %TypecheckResult, %TypecheckResult* %l2
  %t6 = extractvalue %TypecheckResult %t5, 0
  %t7 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t6
  %t8 = extractvalue { %Diagnostic*, i64 } %t7, 1
  %t9 = icmp sgt i64 %t8, 0
  %t10 = load i8*, i8** %l0
  %t11 = load %Program, %Program* %l1
  %t12 = load %TypecheckResult, %TypecheckResult* %l2
  br i1 %t9, label %then0, label %merge1
then0:
  %t13 = bitcast i8* null to %CompiledModule*
  %t14 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t13, 0
  %t15 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t16 = load %TypecheckResult, %TypecheckResult* %l2
  %t17 = extractvalue %TypecheckResult %t16, 0
  %t18 = load i8*, i8** %l0
  %t19 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %t17, i8* %t18)
  %t20 = insertvalue %ModuleDiagnostics %t15, { i8**, i64 }* %t19, 1
  %t21 = insertvalue %ModuleDiagnostics %t20, i1 1, 2
  %t22 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t23 = ptrtoint [1 x %ModuleDiagnostics]* %t22 to i64
  %t24 = icmp eq i64 %t23, 0
  %t25 = select i1 %t24, i64 1, i64 %t23
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to %ModuleDiagnostics*
  %t28 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t27, i64 0
  store %ModuleDiagnostics %t21, %ModuleDiagnostics* %t28
  %t29 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t30 = ptrtoint { %ModuleDiagnostics*, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { %ModuleDiagnostics*, i64 }*
  %t33 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t32, i32 0, i32 0
  store %ModuleDiagnostics* %t27, %ModuleDiagnostics** %t33
  %t34 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = insertvalue %ModuleCompilationResult %t14, { %ModuleDiagnostics*, i64 }* %t32, 1
  ret %ModuleCompilationResult %t35
merge1:
  %t36 = load %Program, %Program* %l1
  %t37 = call %EmitNativeResult @emit_native(%Program %t36)
  store %EmitNativeResult %t37, %EmitNativeResult* %l3
  %t38 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t39 = extractvalue %EmitNativeResult %t38, 0
  %t40 = call %LoweredPythonResult @lower_to_python(%NativeModule %t39)
  store %LoweredPythonResult %t40, %LoweredPythonResult* %l4
  %t41 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t42 = extractvalue %EmitNativeResult %t41, 1
  %t43 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t44 = extractvalue %LoweredPythonResult %t43, 1
  %t45 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t42, { i8**, i64 }* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l5
  %t46 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t47 = extractvalue %LoweredPythonResult %t46, 0
  store i8* %t47, i8** %l6
  %t48 = load i8*, i8** %l6
  %t49 = call i1 @needs_python_fallback(i8* %t48)
  store i1 %t49, i1* %l7
  %t50 = load i1, i1* %l7
  %t51 = load i8*, i8** %l0
  %t52 = load %Program, %Program* %l1
  %t53 = load %TypecheckResult, %TypecheckResult* %l2
  %t54 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t55 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t57 = load i8*, i8** %l6
  %t58 = load i1, i1* %l7
  br i1 %t50, label %then2, label %merge3
then2:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t60 = call i8* @malloc(i64 86)
  %t61 = bitcast i8* %t60 to [86 x i8]*
  store [86 x i8] c"native backend: lowering produced unsupported python output; stage0 fallback disabled\00", [86 x i8]* %t61
  %t62 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t63 = ptrtoint [1 x i8*]* %t62 to i64
  %t64 = icmp eq i64 %t63, 0
  %t65 = select i1 %t64, i64 1, i64 %t63
  %t66 = call i8* @malloc(i64 %t65)
  %t67 = bitcast i8* %t66 to i8**
  %t68 = getelementptr i8*, i8** %t67, i64 0
  store i8* %t60, i8** %t68
  %t69 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t70 = ptrtoint { i8**, i64 }* %t69 to i64
  %t71 = call i8* @malloc(i64 %t70)
  %t72 = bitcast i8* %t71 to { i8**, i64 }*
  %t73 = getelementptr { i8**, i64 }, { i8**, i64 }* %t72, i32 0, i32 0
  store i8** %t67, i8*** %t73
  %t74 = getelementptr { i8**, i64 }, { i8**, i64 }* %t72, i32 0, i32 1
  store i64 1, i64* %t74
  %t75 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t59, { i8**, i64 }* %t72)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l5
  %t76 = bitcast i8* null to %CompiledModule*
  %t77 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t76, 0
  %t78 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t80 = insertvalue %ModuleDiagnostics %t78, { i8**, i64 }* %t79, 1
  %t81 = insertvalue %ModuleDiagnostics %t80, i1 1, 2
  %t82 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t83 = ptrtoint [1 x %ModuleDiagnostics]* %t82 to i64
  %t84 = icmp eq i64 %t83, 0
  %t85 = select i1 %t84, i64 1, i64 %t83
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to %ModuleDiagnostics*
  %t88 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t87, i64 0
  store %ModuleDiagnostics %t81, %ModuleDiagnostics* %t88
  %t89 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t90 = ptrtoint { %ModuleDiagnostics*, i64 }* %t89 to i64
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to { %ModuleDiagnostics*, i64 }*
  %t93 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t92, i32 0, i32 0
  store %ModuleDiagnostics* %t87, %ModuleDiagnostics** %t93
  %t94 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t92, i32 0, i32 1
  store i64 1, i64* %t94
  %t95 = insertvalue %ModuleCompilationResult %t77, { %ModuleDiagnostics*, i64 }* %t92, 1
  ret %ModuleCompilationResult %t95
merge3:
  %t96 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* null, i32 1
  %t97 = ptrtoint [0 x %ModuleDiagnostics]* %t96 to i64
  %t98 = icmp eq i64 %t97, 0
  %t99 = select i1 %t98, i64 1, i64 %t97
  %t100 = call i8* @malloc(i64 %t99)
  %t101 = bitcast i8* %t100 to %ModuleDiagnostics*
  %t102 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t103 = ptrtoint { %ModuleDiagnostics*, i64 }* %t102 to i64
  %t104 = call i8* @malloc(i64 %t103)
  %t105 = bitcast i8* %t104 to { %ModuleDiagnostics*, i64 }*
  %t106 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t105, i32 0, i32 0
  store %ModuleDiagnostics* %t101, %ModuleDiagnostics** %t106
  %t107 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { %ModuleDiagnostics*, i64 }* %t105, { %ModuleDiagnostics*, i64 }** %l8
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t109 = load { i8**, i64 }, { i8**, i64 }* %t108
  %t110 = extractvalue { i8**, i64 } %t109, 1
  %t111 = icmp sgt i64 %t110, 0
  %t112 = load i8*, i8** %l0
  %t113 = load %Program, %Program* %l1
  %t114 = load %TypecheckResult, %TypecheckResult* %l2
  %t115 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t116 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t118 = load i8*, i8** %l6
  %t119 = load i1, i1* %l7
  %t120 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br i1 %t111, label %then4, label %merge5
then4:
  %t121 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t123 = insertvalue %ModuleDiagnostics %t121, { i8**, i64 }* %t122, 1
  %t124 = insertvalue %ModuleDiagnostics %t123, i1 0, 2
  %t125 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t126 = ptrtoint [1 x %ModuleDiagnostics]* %t125 to i64
  %t127 = icmp eq i64 %t126, 0
  %t128 = select i1 %t127, i64 1, i64 %t126
  %t129 = call i8* @malloc(i64 %t128)
  %t130 = bitcast i8* %t129 to %ModuleDiagnostics*
  %t131 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t130, i64 0
  store %ModuleDiagnostics %t124, %ModuleDiagnostics* %t131
  %t132 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t133 = ptrtoint { %ModuleDiagnostics*, i64 }* %t132 to i64
  %t134 = call i8* @malloc(i64 %t133)
  %t135 = bitcast i8* %t134 to { %ModuleDiagnostics*, i64 }*
  %t136 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t135, i32 0, i32 0
  store %ModuleDiagnostics* %t130, %ModuleDiagnostics** %t136
  %t137 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t135, i32 0, i32 1
  store i64 1, i64* %t137
  store { %ModuleDiagnostics*, i64 }* %t135, { %ModuleDiagnostics*, i64 }** %l8
  %t138 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br label %merge5
merge5:
  %t139 = phi { %ModuleDiagnostics*, i64 }* [ %t138, %then4 ], [ %t120, %merge3 ]
  store { %ModuleDiagnostics*, i64 }* %t139, { %ModuleDiagnostics*, i64 }** %l8
  %t140 = insertvalue %CompiledModule undef, i8* %source_path, 0
  %t141 = load i8*, i8** %l6
  %t142 = insertvalue %CompiledModule %t140, i8* %t141, 1
  %t143 = getelementptr %CompiledModule, %CompiledModule* null, i32 1
  %t144 = ptrtoint %CompiledModule* %t143 to i64
  %t145 = call noalias i8* @malloc(i64 %t144)
  %t146 = bitcast i8* %t145 to %CompiledModule*
  store %CompiledModule %t142, %CompiledModule* %t146
  call void @sailfin_runtime_mark_persistent(i8* %t145)
  %t147 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t146, 0
  %t148 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  %t149 = insertvalue %ModuleCompilationResult %t147, { %ModuleDiagnostics*, i64 }* %t148, 1
  ret %ModuleCompilationResult %t149
}

define { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %entries, i8* %source) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call { i8**, i64 }* @split_source_lines(i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = call i8* @number_to_string__main(double %t4)
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = sitofp i64 %t6 to double
  store double %t7, double* %l1
  %t8 = load double, double* %l1
  %t9 = sitofp i64 1 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = sitofp i64 1 to double
  store double %t13, double* %l1
  %t14 = load double, double* %l1
  br label %merge1
merge1:
  %t15 = phi double [ %t14, %then0 ], [ %t12, %block.entry ]
  store double %t15, double* %l1
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
  store { i8**, i64 }* %t25, { i8**, i64 }** %l2
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t32 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t62 = phi { i8**, i64 }* [ %t31, %merge1 ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t32, %merge1 ], [ %t61, %loop.latch4 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l2
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t33 = load double, double* %l3
  %t34 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t35 = extractvalue { %Diagnostic*, i64 } %t34, 1
  %t36 = sitofp i64 %t35 to double
  %t37 = fcmp oge double %t33, %t36
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load double, double* %l3
  br i1 %t37, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t42 = load double, double* %l3
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t46 = extractvalue { %Diagnostic*, i64 } %t45, 0
  %t47 = extractvalue { %Diagnostic*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr %Diagnostic, %Diagnostic* %t46, i64 %t44
  %t50 = load %Diagnostic, %Diagnostic* %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = call i8* @format_typecheck_diagnostic(%Diagnostic %t50, { i8**, i64 }* %t51, double %t52)
  store i8* %t53, i8** %l4
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t55 = load i8*, i8** %l4
  %t56 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t55)
  store { i8**, i64 }* %t56, { i8**, i64 }** %l2
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  br label %loop.latch4
loop.latch4:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load double, double* %l3
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t66
}

; fn report_typecheck_errors effects: ![io]
define void @report_typecheck_errors({ %Diagnostic*, i64 }* %entries, i8* %source) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %t0 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %entries, i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = call i8* @malloc(i64 13)
  %t2 = bitcast i8* %t1 to [13 x i8]*
  store [13 x i8] c"[typecheck] \00", [13 x i8]* %t2
  store i8* %t1, i8** %l1
  %t3 = load i8*, i8** %l1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %t3)
  %t5 = add i64 0, 2
  %t6 = call i8* @malloc(i64 %t5)
  store i8 32, i8* %t6
  %t7 = getelementptr i8, i8* %t6, i64 1
  store i8 0, i8* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  %t8 = sitofp i64 %t4 to double
  %t9 = call i8* @repeat_character(i8* %t6, double %t8)
  store i8* %t9, i8** %l2
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load i8*, i8** %l1
  %t13 = load i8*, i8** %l2
  %t14 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t116 = phi double [ %t14, %block.entry ], [ %t115, %loop.latch2 ]
  store double %t116, double* %l3
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t18 = extractvalue { i8**, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l3
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { i8**, i64 }, { i8**, i64 }* %t25
  %t30 = extractvalue { i8**, i64 } %t29, 0
  %t31 = extractvalue { i8**, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr i8*, i8** %t30, i64 %t28
  %t34 = load i8*, i8** %t33
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l4
  %t36 = call { i8**, i64 }* @split_source_lines(i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l5
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = icmp eq i64 %t39, 0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l3
  %t45 = load i8*, i8** %l4
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t40, label %then6, label %merge7
then6:
  %t47 = load i8*, i8** %l1
  call void @sailfin_runtime_print_error(i8* %t47)
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  br label %loop.latch2
merge7:
  %t51 = sitofp i64 0 to double
  store double %t51, double* %l6
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load double, double* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t58 = load double, double* %l6
  br label %loop.header8
loop.header8:
  %t110 = phi double [ %t58, %merge7 ], [ %t109, %loop.latch10 ]
  store double %t110, double* %l6
  br label %loop.body9
loop.body9:
  %t59 = load double, double* %l6
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t61 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t62 = extractvalue { i8**, i64 } %t61, 1
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oge double %t59, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l1
  %t67 = load i8*, i8** %l2
  %t68 = load double, double* %l3
  %t69 = load i8*, i8** %l4
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t71 = load double, double* %l6
  br i1 %t64, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t72 = load double, double* %l6
  %t73 = sitofp i64 0 to double
  %t74 = fcmp oeq double %t72, %t73
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l3
  %t79 = load i8*, i8** %l4
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t81 = load double, double* %l6
  br i1 %t74, label %then14, label %else15
then14:
  %t82 = load i8*, i8** %l1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t84 = load double, double* %l6
  %t85 = call double @llvm.round.f64(double %t84)
  %t86 = fptosi double %t85 to i64
  %t87 = load { i8**, i64 }, { i8**, i64 }* %t83
  %t88 = extractvalue { i8**, i64 } %t87, 0
  %t89 = extractvalue { i8**, i64 } %t87, 1
  %t90 = icmp uge i64 %t86, %t89
  ; bounds check: %t90 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t86, i64 %t89)
  %t91 = getelementptr i8*, i8** %t88, i64 %t86
  %t92 = load i8*, i8** %t91
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t92)
  call void @sailfin_runtime_print_error(i8* %t93)
  br label %merge16
else15:
  %t94 = load i8*, i8** %l2
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load double, double* %l6
  %t97 = call double @llvm.round.f64(double %t96)
  %t98 = fptosi double %t97 to i64
  %t99 = load { i8**, i64 }, { i8**, i64 }* %t95
  %t100 = extractvalue { i8**, i64 } %t99, 0
  %t101 = extractvalue { i8**, i64 } %t99, 1
  %t102 = icmp uge i64 %t98, %t101
  ; bounds check: %t102 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t98, i64 %t101)
  %t103 = getelementptr i8*, i8** %t100, i64 %t98
  %t104 = load i8*, i8** %t103
  %t105 = call i8* @sailfin_runtime_string_concat(i8* %t94, i8* %t104)
  call void @sailfin_runtime_print_error(i8* %t105)
  br label %merge16
merge16:
  %t106 = load double, double* %l6
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l6
  br label %loop.latch10
loop.latch10:
  %t109 = load double, double* %l6
  br label %loop.header8
afterloop11:
  %t111 = load double, double* %l6
  %t112 = load double, double* %l3
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  store double %t114, double* %l3
  br label %loop.latch2
loop.latch2:
  %t115 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t117 = load double, double* %l3
  ret void
}

define i8* @format_typecheck_diagnostic(%Diagnostic %entry, { i8**, i64 }* %source_lines, double %line_padding) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %Token*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %t0 = extractvalue %Diagnostic %entry, 2
  %t1 = icmp eq %Token* %t0, null
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = extractvalue %Diagnostic %entry, 1
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
merge1:
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
  store { i8**, i64 }* %t12, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = extractvalue %Diagnostic %entry, 1
  %t17 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t16)
  store { i8**, i64 }* %t17, { i8**, i64 }** %l0
  %t18 = extractvalue %Diagnostic %entry, 2
  store %Token* %t18, %Token** %l1
  %t19 = load %Token*, %Token** %l1
  %t20 = getelementptr %Token, %Token* %t19, i32 0, i32 2
  %t21 = load double, double* %t20
  store double %t21, double* %l2
  %t22 = load %Token*, %Token** %l1
  %t23 = getelementptr %Token, %Token* %t22, i32 0, i32 3
  %t24 = load double, double* %t23
  store double %t24, double* %l3
  %t25 = call i8* @malloc(i64 12)
  %t26 = bitcast i8* %t25 to [12 x i8]*
  store [12 x i8] c"  --> line \00", [12 x i8]* %t26
  %t27 = load double, double* %l2
  %t28 = call i8* @number_to_string__main(double %t27)
  %t29 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t28)
  %t30 = call i8* @malloc(i64 10)
  %t31 = bitcast i8* %t30 to [10 x i8]*
  store [10 x i8] c", column \00", [10 x i8]* %t31
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t29, i8* %t30)
  %t33 = load double, double* %l3
  %t34 = call i8* @number_to_string__main(double %t33)
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %t34)
  store i8* %t35, i8** %l4
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l4
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fcmp olt double %t40, %t41
  br label %logical_or_entry_39

logical_or_entry_39:
  br i1 %t42, label %logical_or_merge_39, label %logical_or_right_39

logical_or_right_39:
  %t43 = load double, double* %l2
  %t44 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t45 = extractvalue { i8**, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp ogt double %t43, %t46
  br label %logical_or_right_end_39

logical_or_right_end_39:
  br label %logical_or_merge_39

logical_or_merge_39:
  %t48 = phi i1 [ true, %logical_or_entry_39 ], [ %t47, %logical_or_right_end_39 ]
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load %Token*, %Token** %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load i8*, i8** %l4
  br i1 %t48, label %then2, label %merge3
then2:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = call i8* @join_lines({ i8**, i64 }* %t54)
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  ret i8* %t55
merge3:
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fsub double %t56, %t57
  %t59 = call double @llvm.round.f64(double %t58)
  %t60 = fptosi double %t59 to i64
  %t61 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t62 = extractvalue { i8**, i64 } %t61, 0
  %t63 = extractvalue { i8**, i64 } %t61, 1
  %t64 = icmp uge i64 %t60, %t63
  ; bounds check: %t64 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t60, i64 %t63)
  %t65 = getelementptr i8*, i8** %t62, i64 %t60
  %t66 = load i8*, i8** %t65
  store i8* %t66, i8** %l5
  %t67 = add i64 0, 2
  %t68 = call i8* @malloc(i64 %t67)
  store i8 32, i8* %t68
  %t69 = getelementptr i8, i8* %t68, i64 1
  store i8 0, i8* %t69
  call void @sailfin_runtime_mark_persistent(i8* %t68)
  %t70 = call i8* @repeat_character(i8* %t68, double %line_padding)
  store i8* %t70, i8** %l6
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l6
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 32, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t74, i8* %t72)
  %t77 = call i8* @malloc(i64 3)
  %t78 = bitcast i8* %t77 to [3 x i8]*
  store [3 x i8] c" |\00", [3 x i8]* %t78
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %t77)
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t71, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  %t81 = load double, double* %l2
  %t82 = call i8* @number_to_string__main(double %t81)
  store i8* %t82, i8** %l7
  %t83 = call i8* @malloc(i64 1)
  %t84 = bitcast i8* %t83 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t84
  store i8* %t83, i8** %l8
  %t85 = load i8*, i8** %l7
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = sitofp i64 %t86 to double
  %t88 = fsub double %line_padding, %t87
  store double %t88, double* %l9
  %t89 = load double, double* %l9
  %t90 = sitofp i64 0 to double
  %t91 = fcmp olt double %t89, %t90
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load %Token*, %Token** %l1
  %t94 = load double, double* %l2
  %t95 = load double, double* %l3
  %t96 = load i8*, i8** %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i8*, i8** %l6
  %t99 = load i8*, i8** %l7
  %t100 = load i8*, i8** %l8
  %t101 = load double, double* %l9
  br i1 %t91, label %then4, label %merge5
then4:
  %t102 = sitofp i64 0 to double
  store double %t102, double* %l9
  %t103 = load double, double* %l9
  br label %merge5
merge5:
  %t104 = phi double [ %t103, %then4 ], [ %t101, %merge3 ]
  store double %t104, double* %l9
  %t105 = load double, double* %l9
  %t106 = sitofp i64 0 to double
  %t107 = fcmp ogt double %t105, %t106
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load %Token*, %Token** %l1
  %t110 = load double, double* %l2
  %t111 = load double, double* %l3
  %t112 = load i8*, i8** %l4
  %t113 = load i8*, i8** %l5
  %t114 = load i8*, i8** %l6
  %t115 = load i8*, i8** %l7
  %t116 = load i8*, i8** %l8
  %t117 = load double, double* %l9
  br i1 %t107, label %then6, label %merge7
then6:
  %t118 = load double, double* %l9
  %t119 = add i64 0, 2
  %t120 = call i8* @malloc(i64 %t119)
  store i8 32, i8* %t120
  %t121 = getelementptr i8, i8* %t120, i64 1
  store i8 0, i8* %t121
  call void @sailfin_runtime_mark_persistent(i8* %t120)
  %t122 = call i8* @repeat_character(i8* %t120, double %t118)
  store i8* %t122, i8** %l8
  %t123 = load i8*, i8** %l8
  br label %merge7
merge7:
  %t124 = phi i8* [ %t123, %then6 ], [ %t116, %merge5 ]
  store i8* %t124, i8** %l8
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8*, i8** %l8
  %t127 = add i64 0, 2
  %t128 = call i8* @malloc(i64 %t127)
  store i8 32, i8* %t128
  %t129 = getelementptr i8, i8* %t128, i64 1
  store i8 0, i8* %t129
  call void @sailfin_runtime_mark_persistent(i8* %t128)
  %t130 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t126)
  %t131 = load i8*, i8** %l7
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %t130, i8* %t131)
  %t133 = call i8* @malloc(i64 4)
  %t134 = bitcast i8* %t133 to [4 x i8]*
  store [4 x i8] c" | \00", [4 x i8]* %t134
  %t135 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %t133)
  %t136 = load i8*, i8** %l5
  %t137 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %t136)
  %t138 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t125, i8* %t137)
  store { i8**, i64 }* %t138, { i8**, i64 }** %l0
  %t139 = load double, double* %l3
  %t140 = load %Token*, %Token** %l1
  %t141 = getelementptr %Token, %Token* %t140, i32 0, i32 1
  %t142 = load i8*, i8** %t141
  %t143 = load i8*, i8** %l5
  %t144 = call i8* @build_pointer_line(double %t139, i8* %t142, i8* %t143)
  store i8* %t144, i8** %l10
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load i8*, i8** %l6
  %t147 = add i64 0, 2
  %t148 = call i8* @malloc(i64 %t147)
  store i8 32, i8* %t148
  %t149 = getelementptr i8, i8* %t148, i64 1
  store i8 0, i8* %t149
  call void @sailfin_runtime_mark_persistent(i8* %t148)
  %t150 = call i8* @sailfin_runtime_string_concat(i8* %t148, i8* %t146)
  %t151 = call i8* @malloc(i64 4)
  %t152 = bitcast i8* %t151 to [4 x i8]*
  store [4 x i8] c" | \00", [4 x i8]* %t152
  %t153 = call i8* @sailfin_runtime_string_concat(i8* %t150, i8* %t151)
  %t154 = load i8*, i8** %l10
  %t155 = call i8* @sailfin_runtime_string_concat(i8* %t153, i8* %t154)
  %t156 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t145, i8* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = call i8* @join_lines({ i8**, i64 }* %t157)
  call void @sailfin_runtime_mark_persistent(i8* %t158)
  ret i8* %t158
}

define { i8**, i64 }* @split_source_lines(i8* %source) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
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
  %t107 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t104, %loop.latch2 ]
  %t108 = phi i8* [ %t16, %block.entry ], [ %t105, %loop.latch2 ]
  %t109 = phi double [ %t17, %block.entry ], [ %t106, %loop.latch2 ]
  store { i8**, i64 }* %t107, { i8**, i64 }** %l0
  store i8* %t108, i8** %l1
  store double %t109, double* %l2
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l2
  %t19 = call i64 @sailfin_runtime_string_length(i8* %source)
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
  %t26 = load double, double* %l2
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call double @llvm.round.f64(double %t25)
  %t30 = fptosi double %t29 to i64
  %t31 = call double @llvm.round.f64(double %t28)
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t30, i64 %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = load i8, i8* %t34
  %t36 = icmp eq i8 %t35, 13
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  %t44 = call i8* @malloc(i64 1)
  %t45 = bitcast i8* %t44 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t45
  store i8* %t44, i8** %l1
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t50 = sitofp i64 %t49 to double
  %t51 = fcmp olt double %t48, %t50
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then8, label %merge9
then8:
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  %t59 = load double, double* %l2
  %t60 = sitofp i64 2 to double
  %t61 = fadd double %t59, %t60
  %t62 = call double @llvm.round.f64(double %t58)
  %t63 = fptosi double %t62 to i64
  %t64 = call double @llvm.round.f64(double %t61)
  %t65 = fptosi double %t64 to i64
  %t66 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t63, i64 %t65)
  store i8* %t66, i8** %l4
  %t67 = load i8*, i8** %l4
  %t68 = load i8, i8* %t67
  %t69 = icmp eq i8 %t68, 10
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = load i8*, i8** %l3
  %t74 = load i8*, i8** %l4
  br i1 %t69, label %then10, label %merge11
then10:
  %t75 = load double, double* %l2
  %t76 = sitofp i64 2 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l2
  br label %loop.latch2
merge11:
  %t78 = load double, double* %l2
  br label %merge9
merge9:
  %t79 = phi double [ %t78, %merge11 ], [ %t54, %then6 ]
  store double %t79, double* %l2
  %t80 = load double, double* %l2
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l2
  br label %loop.latch2
merge7:
  %t83 = load i8*, i8** %l3
  %t84 = load i8, i8* %t83
  %t85 = icmp eq i8 %t84, 10
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l2
  %t89 = load i8*, i8** %l3
  br i1 %t85, label %then12, label %merge13
then12:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t90, i8* %t91)
  store { i8**, i64 }* %t92, { i8**, i64 }** %l0
  %t93 = call i8* @malloc(i64 1)
  %t94 = bitcast i8* %t93 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t94
  store i8* %t93, i8** %l1
  %t95 = load double, double* %l2
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l2
  br label %loop.latch2
merge13:
  %t98 = load i8*, i8** %l1
  %t99 = load i8*, i8** %l3
  %t100 = call i8* @sailfin_runtime_string_concat(i8* %t98, i8* %t99)
  store i8* %t100, i8** %l1
  %t101 = load double, double* %l2
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  store double %t103, double* %l2
  br label %loop.latch2
loop.latch2:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load i8*, i8** %l1
  %t115 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t113, i8* %t114)
  store { i8**, i64 }* %t115, { i8**, i64 }** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t116
}

define i8* @build_pointer_line(double %column, i8* %lexeme, i8* %line_text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 94, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  store double %column, double* %l0
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then2, label %merge3
then2:
  %t9 = sitofp i64 1 to double
  store double %t9, double* %l0
  %t10 = load double, double* %l0
  br label %merge3
merge3:
  %t11 = phi double [ %t10, %then2 ], [ %t8, %merge1 ]
  store double %t11, double* %l0
  %t12 = load double, double* %l0
  %t13 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp ogt double %t12, %t14
  %t16 = load double, double* %l0
  br i1 %t15, label %then4, label %merge5
then4:
  %t17 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t18 = sitofp i64 %t17 to double
  store double %t18, double* %l0
  %t19 = load double, double* %l0
  br label %merge5
merge5:
  %t20 = phi double [ %t19, %then4 ], [ %t16, %merge3 ]
  store double %t20, double* %l0
  %t21 = call i8* @malloc(i64 1)
  %t22 = bitcast i8* %t21 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t22
  store i8* %t21, i8** %l1
  %t23 = sitofp i64 1 to double
  store double %t23, double* %l2
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t83 = phi i8* [ %t25, %merge5 ], [ %t81, %loop.latch8 ]
  %t84 = phi double [ %t26, %merge5 ], [ %t82, %loop.latch8 ]
  store i8* %t83, i8** %l1
  store double %t84, double* %l2
  br label %loop.body7
loop.body7:
  %t27 = load double, double* %l2
  %t28 = load double, double* %l0
  %t29 = fcmp oge double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l2
  br i1 %t29, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t33 = load double, double* %l2
  %t34 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t35 = sitofp i64 %t34 to double
  %t36 = fcmp ole double %t33, %t35
  %t37 = load double, double* %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  br i1 %t36, label %then12, label %else13
then12:
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fsub double %t40, %t41
  %t43 = load double, double* %l2
  %t44 = call double @llvm.round.f64(double %t42)
  %t45 = fptosi double %t44 to i64
  %t46 = call double @llvm.round.f64(double %t43)
  %t47 = fptosi double %t46 to i64
  %t48 = call i8* @sailfin_runtime_substring(i8* %line_text, i64 %t45, i64 %t47)
  store i8* %t48, i8** %l3
  %t49 = load i8*, i8** %l3
  %t50 = load i8, i8* %t49
  %t51 = icmp eq i8 %t50, 9
  %t52 = load double, double* %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then15, label %else16
then15:
  %t56 = load i8*, i8** %l1
  %t57 = add i64 0, 2
  %t58 = call i8* @malloc(i64 %t57)
  store i8 9, i8* %t58
  %t59 = getelementptr i8, i8* %t58, i64 1
  store i8 0, i8* %t59
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t58)
  store i8* %t60, i8** %l1
  %t61 = load i8*, i8** %l1
  br label %merge17
else16:
  %t62 = load i8*, i8** %l1
  %t63 = add i64 0, 2
  %t64 = call i8* @malloc(i64 %t63)
  store i8 32, i8* %t64
  %t65 = getelementptr i8, i8* %t64, i64 1
  store i8 0, i8* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  store i8* %t66, i8** %l1
  %t67 = load i8*, i8** %l1
  br label %merge17
merge17:
  %t68 = phi i8* [ %t61, %then15 ], [ %t67, %else16 ]
  store i8* %t68, i8** %l1
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l1
  br label %merge14
else13:
  %t71 = load i8*, i8** %l1
  %t72 = add i64 0, 2
  %t73 = call i8* @malloc(i64 %t72)
  store i8 32, i8* %t73
  %t74 = getelementptr i8, i8* %t73, i64 1
  store i8 0, i8* %t74
  call void @sailfin_runtime_mark_persistent(i8* %t73)
  %t75 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t73)
  store i8* %t75, i8** %l1
  %t76 = load i8*, i8** %l1
  br label %merge14
merge14:
  %t77 = phi i8* [ %t69, %merge17 ], [ %t76, %else13 ]
  store i8* %t77, i8** %l1
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch8
loop.latch8:
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l2
  %t87 = call i64 @sailfin_runtime_string_length(i8* %lexeme)
  %t88 = sitofp i64 %t87 to double
  store double %t88, double* %l4
  %t89 = load double, double* %l4
  %t90 = sitofp i64 0 to double
  %t91 = fcmp ole double %t89, %t90
  %t92 = load double, double* %l0
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l2
  %t95 = load double, double* %l4
  br i1 %t91, label %then18, label %merge19
then18:
  %t96 = sitofp i64 1 to double
  store double %t96, double* %l4
  %t97 = load double, double* %l4
  br label %merge19
merge19:
  %t98 = phi double [ %t97, %then18 ], [ %t95, %afterloop9 ]
  store double %t98, double* %l4
  %t99 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t100 = load double, double* %l0
  %t101 = sitofp i64 1 to double
  %t102 = fsub double %t100, %t101
  %t103 = sitofp i64 %t99 to double
  %t104 = fsub double %t103, %t102
  store double %t104, double* %l5
  %t105 = load double, double* %l5
  %t106 = sitofp i64 0 to double
  %t107 = fcmp ole double %t105, %t106
  %t108 = load double, double* %l0
  %t109 = load i8*, i8** %l1
  %t110 = load double, double* %l2
  %t111 = load double, double* %l4
  %t112 = load double, double* %l5
  br i1 %t107, label %then20, label %merge21
then20:
  %t113 = sitofp i64 1 to double
  store double %t113, double* %l5
  %t114 = load double, double* %l5
  br label %merge21
merge21:
  %t115 = phi double [ %t114, %then20 ], [ %t112, %merge19 ]
  store double %t115, double* %l5
  %t116 = load double, double* %l4
  %t117 = load double, double* %l5
  %t118 = fcmp ogt double %t116, %t117
  %t119 = load double, double* %l0
  %t120 = load i8*, i8** %l1
  %t121 = load double, double* %l2
  %t122 = load double, double* %l4
  %t123 = load double, double* %l5
  br i1 %t118, label %then22, label %merge23
then22:
  %t124 = load double, double* %l5
  store double %t124, double* %l4
  %t125 = load double, double* %l4
  br label %merge23
merge23:
  %t126 = phi double [ %t125, %then22 ], [ %t122, %merge21 ]
  store double %t126, double* %l4
  %t127 = sitofp i64 0 to double
  store double %t127, double* %l6
  %t128 = load double, double* %l0
  %t129 = load i8*, i8** %l1
  %t130 = load double, double* %l2
  %t131 = load double, double* %l4
  %t132 = load double, double* %l5
  %t133 = load double, double* %l6
  br label %loop.header24
loop.header24:
  %t153 = phi i8* [ %t129, %merge23 ], [ %t151, %loop.latch26 ]
  %t154 = phi double [ %t133, %merge23 ], [ %t152, %loop.latch26 ]
  store i8* %t153, i8** %l1
  store double %t154, double* %l6
  br label %loop.body25
loop.body25:
  %t134 = load double, double* %l6
  %t135 = load double, double* %l4
  %t136 = fcmp oge double %t134, %t135
  %t137 = load double, double* %l0
  %t138 = load i8*, i8** %l1
  %t139 = load double, double* %l2
  %t140 = load double, double* %l4
  %t141 = load double, double* %l5
  %t142 = load double, double* %l6
  br i1 %t136, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t143 = load i8*, i8** %l1
  %t144 = add i64 0, 2
  %t145 = call i8* @malloc(i64 %t144)
  store i8 94, i8* %t145
  %t146 = getelementptr i8, i8* %t145, i64 1
  store i8 0, i8* %t146
  call void @sailfin_runtime_mark_persistent(i8* %t145)
  %t147 = call i8* @sailfin_runtime_string_concat(i8* %t143, i8* %t145)
  store i8* %t147, i8** %l1
  %t148 = load double, double* %l6
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l6
  br label %loop.latch26
loop.latch26:
  %t151 = load i8*, i8** %l1
  %t152 = load double, double* %l6
  br label %loop.header24
afterloop27:
  %t155 = load i8*, i8** %l1
  %t156 = load double, double* %l6
  %t157 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t157)
  ret i8* %t157
}

define i8* @join_lines({ i8**, i64 }* %lines) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
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
  %t5 = load { i8**, i64 }, { i8**, i64 }* %lines
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
  %t41 = phi i8* [ %t12, %merge1 ], [ %t39, %loop.latch4 ]
  %t42 = phi double [ %t13, %merge1 ], [ %t40, %loop.latch4 ]
  store i8* %t41, i8** %l0
  store double %t42, double* %l1
  br label %loop.body3
loop.body3:
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %lines
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
  %t22 = add i64 0, 2
  %t23 = call i8* @malloc(i64 %t22)
  store i8 10, i8* %t23
  %t24 = getelementptr i8, i8* %t23, i64 1
  store i8 0, i8* %t24
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t23)
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t30 = extractvalue { i8**, i64 } %t29, 0
  %t31 = extractvalue { i8**, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr i8*, i8** %t30, i64 %t28
  %t34 = load i8*, i8** %t33
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t34)
  store i8* %t35, i8** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch4
loop.latch4:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  ret i8* %t45
}

define { i8**, i64 }* @append_string__main({ i8**, i64 }* %values, i8* %value) {
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

define i8* @number_to_string__main(double %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
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
  store double %value, double* %l0
  store i1 0, i1* %l1
  %t5 = load double, double* %l0
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load i1, i1* %l1
  br i1 %t7, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t10 = load double, double* %l0
  %t11 = sitofp i64 0 to double
  %t12 = fsub double %t11, %t10
  store double %t12, double* %l0
  %t13 = load i1, i1* %l1
  %t14 = load double, double* %l0
  br label %merge3
merge3:
  %t15 = phi i1 [ %t13, %then2 ], [ %t9, %merge1 ]
  %t16 = phi double [ %t14, %then2 ], [ %t8, %merge1 ]
  store i1 %t15, i1* %l1
  store double %t16, double* %l0
  %t17 = call i8* @malloc(i64 11)
  %t18 = bitcast i8* %t17 to [11 x i8]*
  store [11 x i8] c"0123456789\00", [11 x i8]* %t18
  store i8* %t17, i8** %l2
  %t19 = load double, double* %l0
  store double %t19, double* %l3
  %t20 = call i8* @malloc(i64 1)
  %t21 = bitcast i8* %t20 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t21
  store i8* %t20, i8** %l4
  %t22 = load double, double* %l0
  %t23 = load i1, i1* %l1
  %t24 = load i8*, i8** %l2
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t82 = phi i8* [ %t26, %merge3 ], [ %t80, %loop.latch6 ]
  %t83 = phi double [ %t25, %merge3 ], [ %t81, %loop.latch6 ]
  store i8* %t82, i8** %l4
  store double %t83, double* %l3
  br label %loop.body5
loop.body5:
  %t27 = load double, double* %l3
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ole double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  %t34 = load i8*, i8** %l4
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t35 = load double, double* %l3
  store double %t35, double* %l5
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l6
  %t37 = load double, double* %l0
  %t38 = load i1, i1* %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load double, double* %l5
  %t43 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t62 = phi double [ %t42, %merge9 ], [ %t60, %loop.latch12 ]
  %t63 = phi double [ %t43, %merge9 ], [ %t61, %loop.latch12 ]
  store double %t62, double* %l5
  store double %t63, double* %l6
  br label %loop.body11
loop.body11:
  %t44 = load double, double* %l5
  %t45 = sitofp i64 10 to double
  %t46 = fcmp olt double %t44, %t45
  %t47 = load double, double* %l0
  %t48 = load i1, i1* %l1
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  %t52 = load double, double* %l5
  %t53 = load double, double* %l6
  br i1 %t46, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t54 = load double, double* %l5
  %t55 = sitofp i64 10 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l5
  %t57 = load double, double* %l6
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l6
  br label %loop.latch12
loop.latch12:
  %t60 = load double, double* %l5
  %t61 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t64 = load double, double* %l5
  %t65 = load double, double* %l6
  %t66 = load i8*, i8** %l2
  %t67 = load double, double* %l5
  %t68 = load double, double* %l5
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  %t71 = call double @llvm.round.f64(double %t67)
  %t72 = fptosi double %t71 to i64
  %t73 = call double @llvm.round.f64(double %t70)
  %t74 = fptosi double %t73 to i64
  %t75 = call i8* @sailfin_runtime_substring(i8* %t66, i64 %t72, i64 %t74)
  store i8* %t75, i8** %l7
  %t76 = load i8*, i8** %l7
  %t77 = load i8*, i8** %l4
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %t77)
  store i8* %t78, i8** %l4
  %t79 = load double, double* %l6
  store double %t79, double* %l3
  br label %loop.latch6
loop.latch6:
  %t80 = load i8*, i8** %l4
  %t81 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t84 = load i8*, i8** %l4
  %t85 = load double, double* %l3
  %t86 = load i1, i1* %l1
  %t87 = load double, double* %l0
  %t88 = load i1, i1* %l1
  %t89 = load i8*, i8** %l2
  %t90 = load double, double* %l3
  %t91 = load i8*, i8** %l4
  br i1 %t86, label %then16, label %merge17
then16:
  %t92 = load i8*, i8** %l4
  %t93 = add i64 0, 2
  %t94 = call i8* @malloc(i64 %t93)
  store i8 45, i8* %t94
  %t95 = getelementptr i8, i8* %t94, i64 1
  store i8 0, i8* %t95
  call void @sailfin_runtime_mark_persistent(i8* %t94)
  %t96 = call i8* @sailfin_runtime_string_concat(i8* %t94, i8* %t92)
  store i8* %t96, i8** %l4
  %t97 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t98 = phi i8* [ %t97, %then16 ], [ %t91, %afterloop7 ]
  store i8* %t98, i8** %l4
  %t99 = load i8*, i8** %l4
  call void @sailfin_runtime_mark_persistent(i8* %t99)
  ret i8* %t99
}

define %NativeModule @empty_native_module() {
block.entry:
  %t0 = getelementptr [0 x %NativeArtifact], [0 x %NativeArtifact]* null, i32 1
  %t1 = ptrtoint [0 x %NativeArtifact]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeArtifact*
  %t6 = getelementptr { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* null, i32 1
  %t7 = ptrtoint { %NativeArtifact*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %NativeArtifact*, i64 }*
  %t10 = getelementptr { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %t9, i32 0, i32 0
  store %NativeArtifact* %t5, %NativeArtifact** %t10
  %t11 = getelementptr { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = insertvalue %NativeModule undef, { %NativeArtifact*, i64 }* %t9, 0
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
  %t25 = insertvalue %NativeModule %t12, { i8**, i64 }* %t22, 1
  %t26 = sitofp i64 0 to double
  %t27 = insertvalue %NativeModule %t25, double %t26, 2
  ret %NativeModule %t27
}

define i1 @has_prefix(i8* %value, i8* %prefix) {
block.entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t26 = phi double [ %t4, %merge1 ], [ %t25, %loop.latch4 ]
  store double %t26, double* %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t10 = load double, double* %l0
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load double, double* %l0
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %prefix, i64 %t17
  %t19 = load i8, i8* %t18
  %t20 = icmp ne i8 %t14, %t19
  %t21 = load double, double* %l0
  br i1 %t20, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch4
loop.latch4:
  %t25 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t27 = load double, double* %l0
  ret i1 1
}

define i1 @needs_python_fallback(i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i8* @strip_needs_python_fallback_literals(i8* %source)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @strip_python_string_literals(i8* %t3)
  store i8* %t4, i8** %l1
  %t5 = load i8*, i8** %l1
  store i8* %t5, i8** %l2
  %t6 = load i8*, i8** %l2
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l2
  br i1 %t8, label %then2, label %merge3
then2:
  %t12 = load i8*, i8** %l0
  store i8* %t12, i8** %l2
  %t13 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t14 = phi i8* [ %t13, %then2 ], [ %t11, %merge1 ]
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i8*, i8** %l2
  %t22 = load i8*, i8** %l3
  br i1 %t18, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t23 = load i8*, i8** %l3
  %t24 = call i8* @malloc(i64 6)
  %t25 = bitcast i8* %t24 to [6 x i8]*
  store [6 x i8] c"\0Alet \00", [6 x i8]* %t25
  %t26 = call i1 @string_contains(i8* %t23, i8* %t24)
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t31 = load i8*, i8** %l3
  %t32 = call i8* @malloc(i64 6)
  %t33 = bitcast i8* %t32 to [6 x i8]*
  store [6 x i8] c" let \00", [6 x i8]* %t33
  %t34 = call i1 @string_contains(i8* %t31, i8* %t32)
  %t35 = load i8*, i8** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load i8*, i8** %l3
  br i1 %t34, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t39 = load i8*, i8** %l3
  %t40 = call i8* @malloc(i64 6)
  %t41 = bitcast i8* %t40 to [6 x i8]*
  store [6 x i8] c" mut \00", [6 x i8]* %t41
  %t42 = call i1 @string_contains(i8* %t39, i8* %t40)
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load i8*, i8** %l2
  %t46 = load i8*, i8** %l3
  br i1 %t42, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t47 = load i8*, i8** %l3
  %t48 = call i8* @malloc(i64 36)
  %t49 = bitcast i8* %t48 to [36 x i8]*
  store [36 x i8] c"TokenKind.variant('Identifier', [])\00", [36 x i8]* %t49
  %t50 = call i1 @string_contains(i8* %t47, i8* %t48)
  %t51 = load i8*, i8** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t55 = load i8*, i8** %l3
  %t56 = call i8* @malloc(i64 39)
  %t57 = bitcast i8* %t56 to [39 x i8]*
  store [39 x i8] c"TokenKind.variant('NumberLiteral', [])\00", [39 x i8]* %t57
  %t58 = call i1 @string_contains(i8* %t55, i8* %t56)
  %t59 = load i8*, i8** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load i8*, i8** %l2
  %t62 = load i8*, i8** %l3
  br i1 %t58, label %then14, label %merge15
then14:
  ret i1 1
merge15:
  %t63 = load i8*, i8** %l3
  %t64 = call i8* @malloc(i64 39)
  %t65 = bitcast i8* %t64 to [39 x i8]*
  store [39 x i8] c"TokenKind.variant('StringLiteral', [])\00", [39 x i8]* %t65
  %t66 = call i1 @string_contains(i8* %t63, i8* %t64)
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load i8*, i8** %l2
  %t70 = load i8*, i8** %l3
  br i1 %t66, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t71 = load i8*, i8** %l3
  %t72 = call i8* @malloc(i64 40)
  %t73 = bitcast i8* %t72 to [40 x i8]*
  store [40 x i8] c"TokenKind.variant('BooleanLiteral', [])\00", [40 x i8]* %t73
  %t74 = call i1 @string_contains(i8* %t71, i8* %t72)
  %t75 = load i8*, i8** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t79 = load i8*, i8** %l3
  %t80 = call i8* @malloc(i64 32)
  %t81 = bitcast i8* %t80 to [32 x i8]*
  store [32 x i8] c"TokenKind.variant('Symbol', [])\00", [32 x i8]* %t81
  %t82 = call i1 @string_contains(i8* %t79, i8* %t80)
  %t83 = load i8*, i8** %l0
  %t84 = load i8*, i8** %l1
  %t85 = load i8*, i8** %l2
  %t86 = load i8*, i8** %l3
  br i1 %t82, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  %t87 = load i8*, i8** %l3
  %t88 = call i8* @malloc(i64 24)
  %t89 = bitcast i8* %t88 to [24 x i8]*
  store [24 x i8] c"Expression.Identifier()\00", [24 x i8]* %t89
  %t90 = call i1 @string_contains(i8* %t87, i8* %t88)
  %t91 = load i8*, i8** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load i8*, i8** %l2
  %t94 = load i8*, i8** %l3
  br i1 %t90, label %then22, label %merge23
then22:
  ret i1 1
merge23:
  %t95 = load i8*, i8** %l3
  %t96 = call i8* @malloc(i64 17)
  %t97 = bitcast i8* %t96 to [17 x i8]*
  store [17 x i8] c"Expression.Raw()\00", [17 x i8]* %t97
  %t98 = call i1 @string_contains(i8* %t95, i8* %t96)
  %t99 = load i8*, i8** %l0
  %t100 = load i8*, i8** %l1
  %t101 = load i8*, i8** %l2
  %t102 = load i8*, i8** %l3
  br i1 %t98, label %then24, label %merge25
then24:
  ret i1 1
merge25:
  %t103 = load i8*, i8** %l3
  %t104 = call i8* @malloc(i64 22)
  %t105 = bitcast i8* %t104 to [22 x i8]*
  store [22 x i8] c"ExpressionIdentifier(\00", [22 x i8]* %t105
  %t106 = call i1 @string_contains(i8* %t103, i8* %t104)
  %t107 = load i8*, i8** %l0
  %t108 = load i8*, i8** %l1
  %t109 = load i8*, i8** %l2
  %t110 = load i8*, i8** %l3
  br i1 %t106, label %then26, label %merge27
then26:
  ret i1 1
merge27:
  %t111 = load i8*, i8** %l3
  %t112 = call i8* @malloc(i64 15)
  %t113 = bitcast i8* %t112 to [15 x i8]*
  store [15 x i8] c"ExpressionRaw(\00", [15 x i8]* %t113
  %t114 = call i1 @string_contains(i8* %t111, i8* %t112)
  %t115 = load i8*, i8** %l0
  %t116 = load i8*, i8** %l1
  %t117 = load i8*, i8** %l2
  %t118 = load i8*, i8** %l3
  br i1 %t114, label %then28, label %merge29
then28:
  ret i1 1
merge29:
  ret i1 0
}

define i1 @string_contains(i8* %value, i8* %pattern) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %pattern)
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
  %t59 = phi double [ %t6, %merge3 ], [ %t58, %loop.latch6 ]
  store double %t59, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t9 = sitofp i64 %t8 to double
  %t10 = fadd double %t7, %t9
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp ogt double %t10, %t12
  %t14 = load double, double* %l0
  br i1 %t13, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l2
  %t16 = load double, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load double, double* %l2
  br label %loop.header10
loop.header10:
  %t47 = phi i1 [ %t17, %merge9 ], [ %t45, %loop.latch12 ]
  %t48 = phi double [ %t18, %merge9 ], [ %t46, %loop.latch12 ]
  store i1 %t47, i1* %l1
  store double %t48, double* %l2
  br label %loop.body11
loop.body11:
  %t19 = load double, double* %l2
  %t20 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t19, %t21
  %t23 = load double, double* %l0
  %t24 = load i1, i1* %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l2
  %t28 = fadd double %t26, %t27
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = getelementptr i8, i8* %value, i64 %t30
  %t32 = load i8, i8* %t31
  %t33 = load double, double* %l2
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = getelementptr i8, i8* %pattern, i64 %t35
  %t37 = load i8, i8* %t36
  %t38 = icmp ne i8 %t32, %t37
  %t39 = load double, double* %l0
  %t40 = load i1, i1* %l1
  %t41 = load double, double* %l2
  br i1 %t38, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l2
  br label %loop.latch12
loop.latch12:
  %t45 = load i1, i1* %l1
  %t46 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l2
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l0
  %t53 = load i1, i1* %l1
  %t54 = load double, double* %l2
  br i1 %t51, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t55 = load double, double* %l0
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l0
  br label %loop.latch6
loop.latch6:
  %t58 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t60 = load double, double* %l0
  ret i1 0
}

define i8* @strip_needs_python_fallback_literals(i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i8* @malloc(i64 26)
  %t1 = bitcast i8* %t0 to [26 x i8]*
  store [26 x i8] c"def needs_python_fallback\00", [26 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call double @find_substring(i8* %source, i8* %t2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %source)
  ret i8* %source
merge1:
  %t9 = call i8* @malloc(i64 13)
  %t10 = bitcast i8* %t9 to [13 x i8]*
  store [13 x i8] c"return False\00", [13 x i8]* %t10
  store i8* %t9, i8** %l2
  %t11 = load i8*, i8** %l2
  %t12 = load double, double* %l1
  %t13 = call double @find_substring_from(i8* %source, i8* %t11, double %t12)
  store double %t13, double* %l3
  %t14 = load double, double* %l3
  %t15 = sitofp i64 0 to double
  %t16 = fcmp olt double %t14, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br i1 %t16, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* %source)
  ret i8* %source
merge3:
  %t21 = load double, double* %l3
  %t22 = load i8*, i8** %l2
  %t23 = call i64 @sailfin_runtime_string_length(i8* %t22)
  %t24 = sitofp i64 %t23 to double
  %t25 = fadd double %t21, %t24
  store double %t25, double* %l4
  %t26 = load double, double* %l4
  %t27 = call double @advance_to_line_end(i8* %source, double %t26)
  store double %t27, double* %l4
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = call i8* @sailfin_runtime_substring(i8* %source, i64 0, i64 %t30)
  store i8* %t31, i8** %l5
  %t32 = load double, double* %l4
  %t33 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t34 = call double @llvm.round.f64(double %t32)
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t35, i64 %t33)
  store i8* %t36, i8** %l6
  %t37 = load i8*, i8** %l5
  %t38 = load i8*, i8** %l6
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t38)
  call void @sailfin_runtime_mark_persistent(i8* %t39)
  ret i8* %t39
}

define i8* @strip_python_string_literals(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i8* @malloc(i64 1)
  %t2 = bitcast i8* %t1 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t2
  store i8* %t1, i8** %l1
  %t3 = load double, double* %l0
  %t4 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  %t88 = phi i8* [ %t4, %block.entry ], [ %t86, %loop.latch2 ]
  %t89 = phi double [ %t3, %block.entry ], [ %t87, %loop.latch2 ]
  store i8* %t88, i8** %l1
  store double %t89, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  %t15 = call double @llvm.round.f64(double %t11)
  %t16 = fptosi double %t15 to i64
  %t17 = call double @llvm.round.f64(double %t14)
  %t18 = fptosi double %t17 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t16, i64 %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 39
  %t23 = load double, double* %l0
  %t24 = load i8*, i8** %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then6, label %merge7
then6:
  %t26 = load double, double* %l0
  %t27 = add i64 0, 2
  %t28 = call i8* @malloc(i64 %t27)
  store i8 39, i8* %t28
  %t29 = getelementptr i8, i8* %t28, i64 1
  store i8 0, i8* %t29
  call void @sailfin_runtime_mark_persistent(i8* %t28)
  %t30 = call double @python_quote_length(i8* %value, double %t26, i8* %t28)
  store double %t30, double* %l3
  %t31 = load double, double* %l3
  %t32 = add i64 0, 2
  %t33 = call i8* @malloc(i64 %t32)
  store i8 39, i8* %t33
  %t34 = getelementptr i8, i8* %t33, i64 1
  store i8 0, i8* %t34
  call void @sailfin_runtime_mark_persistent(i8* %t33)
  %t35 = call i8* @repeat_character(i8* %t33, double %t31)
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l4
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t37)
  store i8* %t38, i8** %l1
  %t39 = load double, double* %l0
  %t40 = load double, double* %l3
  %t41 = fadd double %t39, %t40
  %t42 = load double, double* %l3
  %t43 = add i64 0, 2
  %t44 = call i8* @malloc(i64 %t43)
  store i8 39, i8* %t44
  %t45 = getelementptr i8, i8* %t44, i64 1
  store i8 0, i8* %t45
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  %t46 = call double @skip_python_string_literal(i8* %value, double %t41, i8* %t44, double %t42)
  store double %t46, double* %l0
  %t47 = load i8*, i8** %l1
  %t48 = load i8*, i8** %l4
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t48)
  store i8* %t49, i8** %l1
  br label %loop.latch2
merge7:
  %t50 = load i8*, i8** %l2
  %t51 = load i8, i8* %t50
  %t52 = icmp eq i8 %t51, 34
  %t53 = load double, double* %l0
  %t54 = load i8*, i8** %l1
  %t55 = load i8*, i8** %l2
  br i1 %t52, label %then8, label %merge9
then8:
  %t56 = load double, double* %l0
  %t57 = add i64 0, 2
  %t58 = call i8* @malloc(i64 %t57)
  store i8 34, i8* %t58
  %t59 = getelementptr i8, i8* %t58, i64 1
  store i8 0, i8* %t59
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  %t60 = call double @python_quote_length(i8* %value, double %t56, i8* %t58)
  store double %t60, double* %l5
  %t61 = load double, double* %l5
  %t62 = add i64 0, 2
  %t63 = call i8* @malloc(i64 %t62)
  store i8 34, i8* %t63
  %t64 = getelementptr i8, i8* %t63, i64 1
  store i8 0, i8* %t64
  call void @sailfin_runtime_mark_persistent(i8* %t63)
  %t65 = call i8* @repeat_character(i8* %t63, double %t61)
  store i8* %t65, i8** %l6
  %t66 = load i8*, i8** %l1
  %t67 = load i8*, i8** %l6
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t67)
  store i8* %t68, i8** %l1
  %t69 = load double, double* %l0
  %t70 = load double, double* %l5
  %t71 = fadd double %t69, %t70
  %t72 = load double, double* %l5
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 34, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call double @skip_python_string_literal(i8* %value, double %t71, i8* %t74, double %t72)
  store double %t76, double* %l0
  %t77 = load i8*, i8** %l1
  %t78 = load i8*, i8** %l6
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %t78)
  store i8* %t79, i8** %l1
  br label %loop.latch2
merge9:
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l2
  %t82 = call i8* @sailfin_runtime_string_concat(i8* %t80, i8* %t81)
  store i8* %t82, i8** %l1
  %t83 = load double, double* %l0
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l0
  br label %loop.latch2
loop.latch2:
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l0
  %t92 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t92)
  ret i8* %t92
}

define double @python_quote_length(i8* %value, double %start, i8* %delimiter) {
block.entry:
  %t0 = sitofp i64 2 to double
  %t1 = fadd double %start, %t0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  %t4 = fcmp olt double %t1, %t3
  br i1 %t4, label %then0, label %merge1
then0:
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %start, %t5
  %t7 = sitofp i64 2 to double
  %t8 = fadd double %start, %t7
  %t9 = call double @llvm.round.f64(double %t6)
  %t10 = fptosi double %t9 to i64
  %t11 = call double @llvm.round.f64(double %t8)
  %t12 = fptosi double %t11 to i64
  %t13 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t10, i64 %t12)
  %t14 = call i1 @strings_equal(i8* %t13, i8* %delimiter)
  br i1 %t14, label %then2, label %merge3
then2:
  %t15 = sitofp i64 2 to double
  %t16 = fadd double %start, %t15
  %t17 = sitofp i64 3 to double
  %t18 = fadd double %start, %t17
  %t19 = call double @llvm.round.f64(double %t16)
  %t20 = fptosi double %t19 to i64
  %t21 = call double @llvm.round.f64(double %t18)
  %t22 = fptosi double %t21 to i64
  %t23 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t20, i64 %t22)
  %t24 = call i1 @strings_equal(i8* %t23, i8* %delimiter)
  br i1 %t24, label %then4, label %merge5
then4:
  %t25 = sitofp i64 3 to double
  ret double %t25
merge5:
  br label %merge3
merge3:
  br label %merge1
merge1:
  %t26 = sitofp i64 1 to double
  ret double %t26
}

define double @skip_python_string_literal(i8* %value, double %position, i8* %delimiter, double %quote_length) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 1 to double
  %t1 = fcmp oeq double %quote_length, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  store double %position, double* %l0
  store i1 0, i1* %l1
  %t2 = load double, double* %l0
  %t3 = load i1, i1* %l1
  br label %loop.header2
loop.header2:
  %t41 = phi double [ %t2, %then0 ], [ %t39, %loop.latch4 ]
  %t42 = phi i1 [ %t3, %then0 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l0
  store i1 %t42, i1* %l1
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load double, double* %l0
  %t9 = load i1, i1* %l1
  br i1 %t7, label %then6, label %merge7
then6:
  %t10 = load double, double* %l0
  ret double %t10
merge7:
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  %t15 = call double @llvm.round.f64(double %t11)
  %t16 = fptosi double %t15 to i64
  %t17 = call double @llvm.round.f64(double %t14)
  %t18 = fptosi double %t17 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t16, i64 %t18)
  store i8* %t19, i8** %l2
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  %t23 = load i1, i1* %l1
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then8, label %merge9
then8:
  store i1 0, i1* %l1
  br label %loop.latch4
merge9:
  %t27 = load i8*, i8** %l2
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 92
  %t30 = load double, double* %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then10, label %merge11
then10:
  store i1 1, i1* %l1
  br label %loop.latch4
merge11:
  %t33 = load i8*, i8** %l2
  %t34 = call i1 @strings_equal(i8* %t33, i8* %delimiter)
  %t35 = load double, double* %l0
  %t36 = load i1, i1* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then12, label %merge13
then12:
  %t38 = load double, double* %l0
  ret double %t38
merge13:
  br label %loop.latch4
loop.latch4:
  %t39 = load double, double* %l0
  %t40 = load i1, i1* %l1
  br label %loop.header2
afterloop5:
  %t43 = load double, double* %l0
  %t44 = load i1, i1* %l1
  br label %merge1
merge1:
  store double %position, double* %l3
  %t45 = load double, double* %l3
  br label %loop.header14
loop.header14:
  %t102 = phi double [ %t45, %merge1 ], [ %t101, %loop.latch16 ]
  store double %t102, double* %l3
  br label %loop.body15
loop.body15:
  %t46 = load double, double* %l3
  %t47 = fadd double %t46, %quote_length
  %t48 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp ogt double %t47, %t49
  %t51 = load double, double* %l3
  br i1 %t50, label %then18, label %merge19
then18:
  %t52 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t53 = sitofp i64 %t52 to double
  ret double %t53
merge19:
  store i1 1, i1* %l4
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l5
  %t55 = load double, double* %l3
  %t56 = load i1, i1* %l4
  %t57 = load double, double* %l5
  br label %loop.header20
loop.header20:
  %t88 = phi i1 [ %t56, %merge19 ], [ %t86, %loop.latch22 ]
  %t89 = phi double [ %t57, %merge19 ], [ %t87, %loop.latch22 ]
  store i1 %t88, i1* %l4
  store double %t89, double* %l5
  br label %loop.body21
loop.body21:
  %t58 = load double, double* %l5
  %t59 = fcmp oge double %t58, %quote_length
  %t60 = load double, double* %l3
  %t61 = load i1, i1* %l4
  %t62 = load double, double* %l5
  br i1 %t59, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t63 = load double, double* %l3
  %t64 = load double, double* %l5
  %t65 = fadd double %t63, %t64
  %t66 = load double, double* %l3
  %t67 = load double, double* %l5
  %t68 = fadd double %t66, %t67
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  %t71 = call double @llvm.round.f64(double %t65)
  %t72 = fptosi double %t71 to i64
  %t73 = call double @llvm.round.f64(double %t70)
  %t74 = fptosi double %t73 to i64
  %t75 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t72, i64 %t74)
  store i8* %t75, i8** %l6
  %t76 = load i8*, i8** %l6
  %t77 = call i1 @strings_equal(i8* %t76, i8* %delimiter)
  %t78 = xor i1 %t77, true
  %t79 = load double, double* %l3
  %t80 = load i1, i1* %l4
  %t81 = load double, double* %l5
  %t82 = load i8*, i8** %l6
  br i1 %t78, label %then26, label %merge27
then26:
  store i1 0, i1* %l4
  br label %afterloop23
merge27:
  %t83 = load double, double* %l5
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l5
  br label %loop.latch22
loop.latch22:
  %t86 = load i1, i1* %l4
  %t87 = load double, double* %l5
  br label %loop.header20
afterloop23:
  %t90 = load i1, i1* %l4
  %t91 = load double, double* %l5
  %t92 = load i1, i1* %l4
  %t93 = load double, double* %l3
  %t94 = load i1, i1* %l4
  %t95 = load double, double* %l5
  br i1 %t92, label %then28, label %merge29
then28:
  %t96 = load double, double* %l3
  %t97 = fadd double %t96, %quote_length
  ret double %t97
merge29:
  %t98 = load double, double* %l3
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l3
  br label %loop.latch16
loop.latch16:
  %t101 = load double, double* %l3
  br label %loop.header14
afterloop17:
  %t103 = load double, double* %l3
  %t104 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t105 = sitofp i64 %t104 to double
  ret double %t105
}

define i8* @repeat_character(i8* %ch, double %count) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %count, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
merge1:
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l0
  %t5 = call i8* @malloc(i64 1)
  %t6 = bitcast i8* %t5 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t6
  store i8* %t5, i8** %l1
  %t7 = load double, double* %l0
  %t8 = load i8*, i8** %l1
  br label %loop.header2
loop.header2:
  %t20 = phi i8* [ %t8, %merge1 ], [ %t18, %loop.latch4 ]
  %t21 = phi double [ %t7, %merge1 ], [ %t19, %loop.latch4 ]
  store i8* %t20, i8** %l1
  store double %t21, double* %l0
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l0
  %t10 = fcmp oge double %t9, %count
  %t11 = load double, double* %l0
  %t12 = load i8*, i8** %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load i8*, i8** %l1
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %ch)
  store i8* %t14, i8** %l1
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  br label %loop.latch4
loop.latch4:
  %t18 = load i8*, i8** %l1
  %t19 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l0
  %t24 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t24)
  ret i8* %t24
}

define double @find_substring(i8* %value, i8* %pattern) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
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
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t62 = phi double [ %t8, %merge3 ], [ %t61, %loop.latch6 ]
  store double %t62, double* %l0
  br label %loop.body5
loop.body5:
  %t9 = load double, double* %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t11 = sitofp i64 %t10 to double
  %t12 = fadd double %t9, %t11
  %t13 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp ogt double %t12, %t14
  %t16 = load double, double* %l0
  br i1 %t15, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l2
  %t18 = load double, double* %l0
  %t19 = load i1, i1* %l1
  %t20 = load double, double* %l2
  br label %loop.header10
loop.header10:
  %t49 = phi i1 [ %t19, %merge9 ], [ %t47, %loop.latch12 ]
  %t50 = phi double [ %t20, %merge9 ], [ %t48, %loop.latch12 ]
  store i1 %t49, i1* %l1
  store double %t50, double* %l2
  br label %loop.body11
loop.body11:
  %t21 = load double, double* %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t21, %t23
  %t25 = load double, double* %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l2
  %t30 = fadd double %t28, %t29
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = getelementptr i8, i8* %value, i64 %t32
  %t34 = load i8, i8* %t33
  %t35 = load double, double* %l2
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %pattern, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = icmp ne i8 %t34, %t39
  %t41 = load double, double* %l0
  %t42 = load i1, i1* %l1
  %t43 = load double, double* %l2
  br i1 %t40, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l2
  br label %loop.latch12
loop.latch12:
  %t47 = load i1, i1* %l1
  %t48 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l2
  %t53 = load i1, i1* %l1
  %t54 = load double, double* %l0
  %t55 = load i1, i1* %l1
  %t56 = load double, double* %l2
  br i1 %t53, label %then18, label %merge19
then18:
  %t57 = load double, double* %l0
  ret double %t57
merge19:
  %t58 = load double, double* %l0
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l0
  br label %loop.latch6
loop.latch6:
  %t61 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t63 = load double, double* %l0
  %t64 = sitofp i64 -1 to double
  ret double %t64
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call double @find_substring(i8* %value, i8* %pattern)
  ret double %t2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %start, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = sitofp i64 -1 to double
  ret double %t6
merge3:
  store double %start, double* %l0
  %t7 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t61 = phi double [ %t7, %merge3 ], [ %t60, %loop.latch6 ]
  store double %t61, double* %l0
  br label %loop.body5
loop.body5:
  %t8 = load double, double* %l0
  %t9 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t10 = sitofp i64 %t9 to double
  %t11 = fadd double %t8, %t10
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp ogt double %t11, %t13
  %t15 = load double, double* %l0
  br i1 %t14, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l2
  %t17 = load double, double* %l0
  %t18 = load i1, i1* %l1
  %t19 = load double, double* %l2
  br label %loop.header10
loop.header10:
  %t48 = phi i1 [ %t18, %merge9 ], [ %t46, %loop.latch12 ]
  %t49 = phi double [ %t19, %merge9 ], [ %t47, %loop.latch12 ]
  store i1 %t48, i1* %l1
  store double %t49, double* %l2
  br label %loop.body11
loop.body11:
  %t20 = load double, double* %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t20, %t22
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load double, double* %l2
  br i1 %t23, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t27 = load double, double* %l0
  %t28 = load double, double* %l2
  %t29 = fadd double %t27, %t28
  %t30 = call double @llvm.round.f64(double %t29)
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %value, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = load double, double* %l2
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %pattern, i64 %t36
  %t38 = load i8, i8* %t37
  %t39 = icmp ne i8 %t33, %t38
  %t40 = load double, double* %l0
  %t41 = load i1, i1* %l1
  %t42 = load double, double* %l2
  br i1 %t39, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l2
  br label %loop.latch12
loop.latch12:
  %t46 = load i1, i1* %l1
  %t47 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t50 = load i1, i1* %l1
  %t51 = load double, double* %l2
  %t52 = load i1, i1* %l1
  %t53 = load double, double* %l0
  %t54 = load i1, i1* %l1
  %t55 = load double, double* %l2
  br i1 %t52, label %then18, label %merge19
then18:
  %t56 = load double, double* %l0
  ret double %t56
merge19:
  %t57 = load double, double* %l0
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l0
  br label %loop.latch6
loop.latch6:
  %t60 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t62 = load double, double* %l0
  %t63 = sitofp i64 -1 to double
  ret double %t63
}

define double @advance_to_line_end(i8* %value, double %position) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t0, %block.entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  %t4 = fcmp oge double %t1, %t3
  %t5 = load double, double* %l0
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = sitofp i64 1 to double
  %t9 = fadd double %t7, %t8
  %t10 = call double @llvm.round.f64(double %t6)
  %t11 = fptosi double %t10 to i64
  %t12 = call double @llvm.round.f64(double %t9)
  %t13 = fptosi double %t12 to i64
  %t14 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t11, i64 %t13)
  store i8* %t14, i8** %l1
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 10
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  br i1 %t20, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = load double, double* %l0
  ret double %t26
}

define double @add__main(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}