; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type opaque
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { %CompiledModule*, { %ModuleDiagnostics**, i64 }* }
%ProjectCompilation = type { { %CompiledModule**, i64 }*, { %ModuleDiagnostics**, i64 }* }
%LLVMCompilationResult = type { %LoweredLLVMResult, %NativeModule }
%Parser = type { { %Token**, i64 }*, double }
%StatementParseResult = type { %Parser, %Statement }
%ParameterParseResult = type { %Parser, %Parameter }
%ParameterListParseResult = type { %Parser, { %Parameter**, i64 }* }
%StructFieldParseResult = type { %Parser, %FieldDeclaration*, i1 }
%ModelPropertyParseResult = type { %Parser, %ModelProperty*, i1 }
%MethodParseResult = type { %Parser, %MethodDeclaration*, i1 }
%InterfaceMemberParseResult = type { %Parser, %FunctionSignature*, i1 }
%SpecifierListParseResult = type { %Parser, { %NamedSpecifier**, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { %Parser, %EnumVariant*, i1 }
%TypeParameterParseResult = type { %Parser, { %TypeParameter**, i64 }* }
%ImplementsParseResult = type { %Parser, { %TypeAnnotation**, i64 }*, i1 }
%DecoratorParseResult = type { %Parser, { %Decorator**, i64 }* }
%BlockStatementParseResult = type { %Parser, %Statement*, i1 }
%ParenthesizedParseResult = type { %Parser, { %Token**, i64 }*, i1 }
%MatchCasesParseResult = type { %Parser, { %MatchCase**, i64 }*, i1 }
%MatchCaseParseResult = type { %Parser, %MatchCase*, i1 }
%MatchCaseTokenSplit = type { { %Token**, i64 }*, { %Token**, i64 }*, i1 }
%ExpressionTokens = type { { %Token**, i64 }*, double }
%ExpressionParseResult = type { %ExpressionTokens, %Expression, i1 }
%LambdaParameterParseResult = type { %ExpressionTokens, %Parameter, i1 }
%LambdaParameterListParseResult = type { %ExpressionTokens, { %Parameter**, i64 }*, i1 }
%ExpressionCollectResult = type { %ExpressionTokens, { %Token**, i64 }*, i1 }
%ExpressionBlockParseResult = type { %ExpressionTokens, { %Token**, i64 }*, i1 }
%CallArgumentsParseResult = type { %ExpressionTokens, { %Expression**, i64 }*, i1 }
%ArrayLiteralParseResult = type { %ExpressionTokens, { %Expression**, i64 }*, i1 }
%ObjectLiteralParseResult = type { %ExpressionTokens, { %ObjectField**, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { %Parser, { %Token**, i64 }* }
%EffectParseResult = type { %Parser, { i8**, i64 }* }
%BlockParseResult = type { %Parser, %Block }
%PatternCaptureResult = type { %Parser, { %Token**, i64 }*, i1 }
%Program = type { { %Statement**, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, %TypeAnnotation*, %SourceSpan* }
%Block = type { { %Token**, i64 }*, i8*, { %Statement**, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, %TypeAnnotation*, %Expression*, i1, %SourceSpan* }
%WithClause = type { %Expression }
%ObjectField = type { i8*, %Expression }
%ElseBranch = type { %Statement*, %Block* }
%ForClause = type { %Expression, %Expression, { %Token**, i64 }* }
%MatchCase = type { %Expression, %Expression*, %Block }
%ModelProperty = type { i8*, %Expression, %SourceSpan* }
%FieldDeclaration = type { i8*, %TypeAnnotation, i1, %SourceSpan* }
%MethodDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%EnumVariant = type { i8*, { %FieldDeclaration**, i64 }*, %SourceSpan* }
%FunctionSignature = type { i8*, i1, { %Parameter**, i64 }*, %TypeAnnotation*, { i8**, i64 }*, { %TypeParameter**, i64 }*, %SourceSpan* }
%PipelineDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%ToolDeclaration = type { %FunctionSignature, %Block, { %Decorator**, i64 }* }
%TestDeclaration = type { i8*, %Block, { i8**, i64 }*, { %Decorator**, i64 }* }
%ModelDeclaration = type { i8*, %TypeAnnotation, { %ModelProperty**, i64 }*, { i8**, i64 }*, { %Decorator**, i64 }* }
%Decorator = type { i8*, { %DecoratorArgument**, i64 }* }
%DecoratorArgument = type { i8*, %Expression }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
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
%TraitImplementationDescriptor = type { i8*, { i8**, i64 }* }
%TraitDescriptor = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature**, i64 }* }
%TraitMetadata = type { { %TraitDescriptor**, i64 }*, { %TraitImplementationDescriptor**, i64 }* }
%FunctionEffectEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifestEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifest = type { { %CapabilityManifestEntry**, i64 }* }
%RuntimeHelperDescriptor = type { i8*, i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%FunctionCallEntry = type { i8*, { i8**, i64 }* }
%StringConstant = type { i8*, i8*, double }
%StringPointerResult = type { { i8**, i64 }*, double, i8* }
%LoweredLLVMResult = type { i8*, { i8**, i64 }*, %TraitMetadata, { %FunctionEffectEntry**, i64 }*, { %LifetimeRegionMetadata**, i64 }*, %CapabilityManifest, { %StringConstant**, i64 }* }
%LayoutManifestApplication = type { { %NativeStruct**, i64 }*, { %NativeEnum**, i64 }*, { i8**, i64 }* }
%ImportedModuleContext = type { { %LayoutManifest**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%LoweredLLVMFunction = type { { i8**, i64 }*, { i8**, i64 }*, { %LifetimeRegionMetadata**, i64 }*, { %StringConstant**, i64 }* }
%BodyResult = type { { i8**, i64 }*, { i8**, i64 }*, { %LifetimeRegionMetadata**, i64 }*, { %StringConstant**, i64 }* }
%ParameterBinding = type { i8*, i8*, i8*, i8*, i1, %NativeSourceSpan* }
%ParameterPreparation = type { { i8**, i64 }*, { %ParameterBinding**, i64 }*, { i8**, i64 }* }
%LLVMOperand = type { i8*, i8* }
%ExpressionResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, { %StringConstant**, i64 }* }
%ArrayLiteralMetadata = type { i8*, double }
%OwnershipInfo = type { i8*, i8*, i1, %NativeSourceSpan*, double }
%OwnershipConsumption = type { i8*, i8* }
%LifetimeRegionMetadata = type { double, i8*, i8*, i1, %NativeSourceSpan*, i8*, double, i8*, double, i8*, double, i1 }
%LifetimeReleaseEvent = type { double, i8*, double }
%ScopeMetadata = type { i8*, double }
%StructFieldInfo = type { i8*, i8*, double, double }
%StructTypeInfo = type { i8*, i8*, { %StructFieldInfo**, i64 }*, double, double }
%EnumVariantInfo = type { i8*, double, double, double, double, { %StructFieldInfo**, i64 }* }
%EnumTypeInfo = type { i8*, i8*, i8*, double, double, double, double, { %EnumVariantInfo**, i64 }* }
%VTableEntry = type { i8*, i8*, i8* }
%VTableInfo = type { i8*, i8*, i8*, i8*, { %VTableEntry**, i64 }* }
%InterfaceTypeInfo = type { i8*, i8*, { i8**, i64 }*, { %NativeInterfaceSignature**, i64 }* }
%TypeContext = type { { %StructTypeInfo**, i64 }*, { %EnumTypeInfo**, i64 }*, { %InterfaceTypeInfo**, i64 }*, { %VTableInfo**, i64 }* }
%TypeContextBuild = type { %TypeContext, { i8**, i64 }* }
%TypeAllocationInfo = type { i8*, double, double }
%HeapBoxResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
%StructLiteralField = type { i8*, i8* }
%StructLiteralParse = type { i1, i1, i8*, { %StructLiteralField**, i64 }*, { i8**, i64 }* }
%EnumLiteralParse = type { i1, i1, i8*, i8*, { %StructLiteralField**, i64 }*, { i8**, i64 }* }
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
%ExpressionStatementResult = type { { i8**, i64 }*, double, { %LocalBinding**, i64 }*, { %ParameterBinding**, i64 }*, { i8**, i64 }*, { %LifetimeRegionMetadata**, i64 }*, { %LifetimeReleaseEvent**, i64 }*, double, { %LocalMutation**, i64 }*, { %StringConstant**, i64 }* }
%LetLoweringResult = type { { i8**, i64 }*, { i8**, i64 }*, { %LocalBinding**, i64 }*, { %ParameterBinding**, i64 }*, double, { i8**, i64 }*, double, { %LifetimeRegionMetadata**, i64 }*, double, { %LocalMutation**, i64 }*, { %StringConstant**, i64 }* }
%InlineLetParseResult = type { i1, i8*, i1, i8*, i8*, { i8**, i64 }* }
%BlockLabelResult = type { i8*, double }
%IfStructure = type { double, double, double, double, i1, double, { i8**, i64 }* }
%LoopContext = type { i8*, i8* }
%LoopStructure = type { double, double, double, { i8**, i64 }* }
%RangeIterableParse = type { i1, i8*, i8*, i8*, { i8**, i64 }* }
%MatchCaseStructure = type { i8*, i8*, double, double, i1 }
%MatchStructure = type { { %MatchCaseStructure**, i64 }*, double, { i8**, i64 }* }
%MatchFieldBinding = type { i8*, i8*, double }
%MatchCaseCondition = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, i1, { %MatchFieldBinding**, i64 }*, %EnumTypeInfo*, %EnumVariantInfo*, { %StringConstant**, i64 }* }
%ConditionConversion = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }*, { %StringConstant**, i64 }* }
%ComparisonEmission = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
%CoercionResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
%BinaryAlignmentResult = type { { i8**, i64 }*, double, %LLVMOperand*, %LLVMOperand*, { i8**, i64 }*, i8* }
%BlockLoweringResult = type { { i8**, i64 }*, { i8**, i64 }*, { %LocalBinding**, i64 }*, { %ParameterBinding**, i64 }*, double, double, { i8**, i64 }*, i1, double, { %LifetimeRegionMetadata**, i64 }*, double, double, { %LocalMutation**, i64 }*, { %StringConstant**, i64 }* }
%PhiMergeResult = type { { i8**, i64 }*, double }
%PhiInputEntry = type { i8*, i8* }
%MutationMaterializationResult = type { { %LocalMutation**, i64 }*, { i8**, i64 }*, double }
%PhiStoreEntry = type { i8*, i8* }
%MatchArmMutations = type { { %LocalMutation**, i64 }*, i8*, i1 }
%LoadLocalResult = type { { i8**, i64 }*, double, %LLVMOperand*, { i8**, i64 }* }
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
%Token = type { %TokenKind, i8*, double, double }
%Diagnostic = type { i8*, i8*, %Token* }
%SymbolEntry = type { i8*, i8*, %SourceSpan* }
%TypecheckResult = type { { %Diagnostic**, i64 }*, { %SymbolEntry**, i64 }* }
%SymbolCollectionResult = type { { %SymbolEntry**, i64 }*, { %Diagnostic**, i64 }* }
%ScopeResult = type { { %SymbolEntry**, i64 }*, { %Diagnostic**, i64 }* }

%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%NativeInstruction = type { i32, [48 x i8] }
%TokenKind = type { i32, [8 x i8] }

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
declare i1 @strings_equal(i8*, i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare %Program @parse_program(i8*)
declare %Program @parse_tokens({ %Token*, i64 }*)
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
declare %Parser @skip_trailing_comma(%Parser)
declare %StatementParseResult @parse_model(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_pipeline(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_tool(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_test(%Parser, { %Decorator*, i64 }*)
declare %StatementParseResult @parse_function(%Parser, i1, { %Decorator*, i64 }*)
declare %ParameterListParseResult @parse_parameter_list(%Parser)
declare %StructFieldParseResult @parse_struct_field(%Parser)
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
declare { i8**, i64 }* @split_token_slices_by_comma({ %Token*, i64 }*)
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
declare { i8**, i64 }* @append_token_array({ i8**, i64 }*, { %Token*, i64 }*)
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
declare %TextBuilder @emit_prompt(%TextBuilder, %Statement)
declare %TextBuilder @emit_with(%TextBuilder, %Statement)
declare %TextBuilder @emit_if(%TextBuilder, %Statement)
declare %TextBuilder @emit_else_branch(%TextBuilder, %ElseBranch)
declare %TextBuilder @emit_for(%TextBuilder, %Statement)
declare %TextBuilder @emit_match(%TextBuilder, %Statement)
declare %TextBuilder @emit_match_case(%TextBuilder, %MatchCase)
declare %TextBuilder @emit_block_start(%TextBuilder)
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
declare i1 @is_integer_literal(i8*)
declare i1 @is_number_literal(i8*)
declare i8* @normalise_number_literal(i8*)
declare i1 @is_string_literal(i8*)
declare i1 @is_character_literal(i8*)
declare double @get_character_literal_value(i8*)
declare i8* @make_string_constant_name(i8*)
declare double @compute_string_constant_hash(i8*)
declare %ExpressionResult @lower_string_literal(i8*, double, { i8**, i64 }*)
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
declare %EffectRequirement* @select_requirement_for_effect({ i8**, i64 }*, i8*)
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

@runtime = external global i8**

@.str.len16.h385769534 = private unnamed_addr constant [17 x i8] c"Sailfin compiler\00"
@.str.len12.h1402485025 = private unnamed_addr constant [13 x i8] c"[typecheck] \00"
@.str.len11.h1801723778 = private unnamed_addr constant [12 x i8] c"  --> line \00"
@.str.len9.h507529196 = private unnamed_addr constant [10 x i8] c", column \00"
@.str.len2.h193415939 = private unnamed_addr constant [3 x i8] c" |\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len3.h2087759686 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.len10.h626550212 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.len25.h111080155 = private unnamed_addr constant [26 x i8] c"def needs_python_fallback\00"
@.str.len12.h1175821684 = private unnamed_addr constant [13 x i8] c"return False\00"

; fn compile_to_sailfin effects: ![io]
declare void @sailfin_runtime_mark_persistent(i8*)

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
  %t5 = load { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t4
  %t6 = extractvalue { %Diagnostic**, i64 } %t5, 1
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load %Program, %Program* %l0
  %t9 = load %TypecheckResult, %TypecheckResult* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load %TypecheckResult, %TypecheckResult* %l1
  %t11 = extractvalue %TypecheckResult %t10, 0
  %t12 = bitcast { %Diagnostic**, i64 }* %t11 to { %Diagnostic*, i64 }*
  call void @report_typecheck_errors({ %Diagnostic*, i64 }* %t12, i8* %source)
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s13)
  ret i8* %s13
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
  %t5 = load { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t4
  %t6 = extractvalue { %Diagnostic**, i64 } %t5, 1
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load %Program, %Program* %l0
  %t9 = load %TypecheckResult, %TypecheckResult* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load %TypecheckResult, %TypecheckResult* %l1
  %t11 = extractvalue %TypecheckResult %t10, 0
  %t12 = bitcast { %Diagnostic**, i64 }* %t11 to { %Diagnostic*, i64 }*
  call void @report_typecheck_errors({ %Diagnostic*, i64 }* %t12, i8* %source)
  %t13 = call %NativeModule @empty_native_module()
  %t14 = insertvalue %EmitNativeResult undef, %NativeModule %t13, 0
  %t15 = load %TypecheckResult, %TypecheckResult* %l1
  %t16 = extractvalue %TypecheckResult %t15, 0
  %t17 = bitcast { %Diagnostic**, i64 }* %t16 to { %Diagnostic*, i64 }*
  %t18 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %t17, i8* %source)
  %t19 = insertvalue %EmitNativeResult %t14, { i8**, i64 }* %t18, 1
  ret %EmitNativeResult %t19
merge1:
  %t20 = load %Program, %Program* %l0
  %t21 = call %EmitNativeResult @emit_native(%Program %t20)
  ret %EmitNativeResult %t21
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
  %t62 = phi double [ %t35, %then0 ], [ %t61, %loop.latch4 ]
  store double %t62, double* %l3
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
  %s46 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h2073631692, i32 0, i32 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  %t49 = call double @llvm.round.f64(double %t48)
  %t50 = fptosi double %t49 to i64
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %t56)
  call void @sailfin_runtime_print_warn(i8* %t57)
  %t58 = load double, double* %l3
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l3
  br label %loop.latch4
loop.latch4:
  %t61 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t63 = load double, double* %l3
  br label %merge1
merge1:
  %t64 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t65 = extractvalue %LoweredPythonResult %t64, 0
  %t66 = insertvalue %LoweredPythonResult undef, i8* %t65, 0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = insertvalue %LoweredPythonResult %t66, { i8**, i64 }* %t67, 1
  ret %LoweredPythonResult %t68
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
  %t62 = phi double [ %t35, %then0 ], [ %t61, %loop.latch4 ]
  store double %t62, double* %l3
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
  %s46 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  %t49 = call double @llvm.round.f64(double %t48)
  %t50 = fptosi double %t49 to i64
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %t56)
  call void @sailfin_runtime_print_warn(i8* %t57)
  %t58 = load double, double* %l3
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l3
  br label %loop.latch4
loop.latch4:
  %t61 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t63 = load double, double* %l3
  br label %merge1
merge1:
  %t64 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t65 = extractvalue %LoweredLLVMResult %t64, 0
  %t66 = insertvalue %LoweredLLVMResult undef, i8* %t65, 0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = insertvalue %LoweredLLVMResult %t66, { i8**, i64 }* %t67, 1
  %t69 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t70 = extractvalue %LoweredLLVMResult %t69, 2
  %t71 = insertvalue %LoweredLLVMResult %t68, %TraitMetadata %t70, 2
  %t72 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t73 = extractvalue %LoweredLLVMResult %t72, 3
  %t74 = insertvalue %LoweredLLVMResult %t71, { %FunctionEffectEntry**, i64 }* %t73, 3
  %t75 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t76 = extractvalue %LoweredLLVMResult %t75, 4
  %t77 = insertvalue %LoweredLLVMResult %t74, { %LifetimeRegionMetadata**, i64 }* %t76, 4
  %t78 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t79 = extractvalue %LoweredLLVMResult %t78, 5
  %t80 = insertvalue %LoweredLLVMResult %t77, %CapabilityManifest %t79, 5
  %t81 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t82 = extractvalue %LoweredLLVMResult %t81, 6
  %t83 = insertvalue %LoweredLLVMResult %t80, { %StringConstant**, i64 }* %t82, 6
  ret %LoweredLLVMResult %t83
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
  %t62 = phi double [ %t35, %then0 ], [ %t61, %loop.latch4 ]
  store double %t62, double* %l3
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
  %s46 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  %t49 = call double @llvm.round.f64(double %t48)
  %t50 = fptosi double %t49 to i64
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %t56)
  call void @sailfin_runtime_print_warn(i8* %t57)
  %t58 = load double, double* %l3
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l3
  br label %loop.latch4
loop.latch4:
  %t61 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t63 = load double, double* %l3
  br label %merge1
merge1:
  %t64 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t65 = extractvalue %LoweredLLVMResult %t64, 0
  %t66 = insertvalue %LoweredLLVMResult undef, i8* %t65, 0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = insertvalue %LoweredLLVMResult %t66, { i8**, i64 }* %t67, 1
  %t69 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t70 = extractvalue %LoweredLLVMResult %t69, 2
  %t71 = insertvalue %LoweredLLVMResult %t68, %TraitMetadata %t70, 2
  %t72 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t73 = extractvalue %LoweredLLVMResult %t72, 3
  %t74 = insertvalue %LoweredLLVMResult %t71, { %FunctionEffectEntry**, i64 }* %t73, 3
  %t75 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t76 = extractvalue %LoweredLLVMResult %t75, 4
  %t77 = insertvalue %LoweredLLVMResult %t74, { %LifetimeRegionMetadata**, i64 }* %t76, 4
  %t78 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t79 = extractvalue %LoweredLLVMResult %t78, 5
  %t80 = insertvalue %LoweredLLVMResult %t77, %CapabilityManifest %t79, 5
  %t81 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t82 = extractvalue %LoweredLLVMResult %t81, 6
  %t83 = insertvalue %LoweredLLVMResult %t80, { %StringConstant**, i64 }* %t82, 6
  %t84 = insertvalue %LLVMCompilationResult undef, %LoweredLLVMResult %t83, 0
  %t85 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t86 = extractvalue %EmitNativeResult %t85, 0
  %t87 = insertvalue %LLVMCompilationResult %t84, %NativeModule %t86, 1
  ret %LLVMCompilationResult %t87
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
  %t147 = phi { %LayoutManifest*, i64 }* [ %t15, %block.entry ], [ %t145, %loop.latch2 ]
  %t148 = phi double [ %t16, %block.entry ], [ %t146, %loop.latch2 ]
  store { %LayoutManifest*, i64 }* %t147, { %LayoutManifest*, i64 }** %l1
  store double %t148, double* %l2
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
  %t42 = getelementptr [0 x %NativeStruct*], [0 x %NativeStruct*]* null, i32 1
  %t43 = ptrtoint [0 x %NativeStruct*]* %t42 to i64
  %t44 = icmp eq i64 %t43, 0
  %t45 = select i1 %t44, i64 1, i64 %t43
  %t46 = call i8* @malloc(i64 %t45)
  %t47 = bitcast i8* %t46 to %NativeStruct**
  %t48 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* null, i32 1
  %t49 = ptrtoint { %NativeStruct**, i64 }* %t48 to i64
  %t50 = call i8* @malloc(i64 %t49)
  %t51 = bitcast i8* %t50 to { %NativeStruct**, i64 }*
  %t52 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* %t51, i32 0, i32 0
  store %NativeStruct** %t47, %NativeStruct*** %t52
  %t53 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* %t51, i32 0, i32 1
  store i64 0, i64* %t53
  %t54 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t51, 0
  %t55 = getelementptr [0 x %NativeEnum*], [0 x %NativeEnum*]* null, i32 1
  %t56 = ptrtoint [0 x %NativeEnum*]* %t55 to i64
  %t57 = icmp eq i64 %t56, 0
  %t58 = select i1 %t57, i64 1, i64 %t56
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to %NativeEnum**
  %t61 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* null, i32 1
  %t62 = ptrtoint { %NativeEnum**, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { %NativeEnum**, i64 }*
  %t65 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* %t64, i32 0, i32 0
  store %NativeEnum** %t60, %NativeEnum*** %t65
  %t66 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  %t67 = insertvalue %LayoutManifest %t54, { %NativeEnum**, i64 }* %t64, 1
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
  %t81 = call noalias i8* @malloc(i64 24)
  %t82 = bitcast i8* %t81 to %LayoutManifest*
  store %LayoutManifest %t80, %LayoutManifest* %t82
  %t83 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t84 = ptrtoint [1 x i8*]* %t83 to i64
  %t85 = icmp eq i64 %t84, 0
  %t86 = select i1 %t85, i64 1, i64 %t84
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to i8**
  %t89 = getelementptr i8*, i8** %t88, i64 0
  store i8* %t81, i8** %t89
  %t90 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t91 = ptrtoint { i8**, i64 }* %t90 to i64
  %t92 = call i8* @malloc(i64 %t91)
  %t93 = bitcast i8* %t92 to { i8**, i64 }*
  %t94 = getelementptr { i8**, i64 }, { i8**, i64 }* %t93, i32 0, i32 0
  store i8** %t88, i8*** %t94
  %t95 = getelementptr { i8**, i64 }, { i8**, i64 }* %t93, i32 0, i32 1
  store i64 1, i64* %t95
  %t96 = bitcast { %LayoutManifest*, i64 }* %t41 to { i8**, i64 }*
  %t97 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t96, { i8**, i64 }* %t93)
  %t98 = bitcast { i8**, i64 }* %t97 to { %LayoutManifest*, i64 }*
  store { %LayoutManifest*, i64 }* %t98, { %LayoutManifest*, i64 }** %l1
  %t99 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  br label %merge8
else7:
  %t100 = load i8*, i8** %l3
  %t101 = call %LayoutManifest @parse_layout_manifest(i8* %t100)
  store %LayoutManifest %t101, %LayoutManifest* %l4
  %t102 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t103 = load %LayoutManifest, %LayoutManifest* %l4
  %t104 = extractvalue %LayoutManifest %t103, 0
  %t105 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t104, 0
  %t106 = load %LayoutManifest, %LayoutManifest* %l4
  %t107 = extractvalue %LayoutManifest %t106, 1
  %t108 = insertvalue %LayoutManifest %t105, { %NativeEnum**, i64 }* %t107, 1
  %t109 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t110 = ptrtoint [0 x i8*]* %t109 to i64
  %t111 = icmp eq i64 %t110, 0
  %t112 = select i1 %t111, i64 1, i64 %t110
  %t113 = call i8* @malloc(i64 %t112)
  %t114 = bitcast i8* %t113 to i8**
  %t115 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t116 = ptrtoint { i8**, i64 }* %t115 to i64
  %t117 = call i8* @malloc(i64 %t116)
  %t118 = bitcast i8* %t117 to { i8**, i64 }*
  %t119 = getelementptr { i8**, i64 }, { i8**, i64 }* %t118, i32 0, i32 0
  store i8** %t114, i8*** %t119
  %t120 = getelementptr { i8**, i64 }, { i8**, i64 }* %t118, i32 0, i32 1
  store i64 0, i64* %t120
  %t121 = insertvalue %LayoutManifest %t108, { i8**, i64 }* %t118, 2
  %t122 = call noalias i8* @malloc(i64 24)
  %t123 = bitcast i8* %t122 to %LayoutManifest*
  store %LayoutManifest %t121, %LayoutManifest* %t123
  %t124 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t125 = ptrtoint [1 x i8*]* %t124 to i64
  %t126 = icmp eq i64 %t125, 0
  %t127 = select i1 %t126, i64 1, i64 %t125
  %t128 = call i8* @malloc(i64 %t127)
  %t129 = bitcast i8* %t128 to i8**
  %t130 = getelementptr i8*, i8** %t129, i64 0
  store i8* %t122, i8** %t130
  %t131 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t132 = ptrtoint { i8**, i64 }* %t131 to i64
  %t133 = call i8* @malloc(i64 %t132)
  %t134 = bitcast i8* %t133 to { i8**, i64 }*
  %t135 = getelementptr { i8**, i64 }, { i8**, i64 }* %t134, i32 0, i32 0
  store i8** %t129, i8*** %t135
  %t136 = getelementptr { i8**, i64 }, { i8**, i64 }* %t134, i32 0, i32 1
  store i64 1, i64* %t136
  %t137 = bitcast { %LayoutManifest*, i64 }* %t102 to { i8**, i64 }*
  %t138 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t137, { i8**, i64 }* %t134)
  %t139 = bitcast { i8**, i64 }* %t138 to { %LayoutManifest*, i64 }*
  store { %LayoutManifest*, i64 }* %t139, { %LayoutManifest*, i64 }** %l1
  %t140 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  br label %merge8
merge8:
  %t141 = phi { %LayoutManifest*, i64 }* [ %t99, %then6 ], [ %t140, %else7 ]
  store { %LayoutManifest*, i64 }* %t141, { %LayoutManifest*, i64 }** %l1
  %t142 = load double, double* %l2
  %t143 = sitofp i64 1 to double
  %t144 = fadd double %t142, %t143
  store double %t144, double* %l2
  br label %loop.latch2
loop.latch2:
  %t145 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t146 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t149 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t150 = load double, double* %l2
  %t151 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t152 = extractvalue %EmitNativeResult %t151, 0
  %t153 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t154 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t155 = ptrtoint [0 x i8*]* %t154 to i64
  %t156 = icmp eq i64 %t155, 0
  %t157 = select i1 %t156, i64 1, i64 %t155
  %t158 = call i8* @malloc(i64 %t157)
  %t159 = bitcast i8* %t158 to i8**
  %t160 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t161 = ptrtoint { i8**, i64 }* %t160 to i64
  %t162 = call i8* @malloc(i64 %t161)
  %t163 = bitcast i8* %t162 to { i8**, i64 }*
  %t164 = getelementptr { i8**, i64 }, { i8**, i64 }* %t163, i32 0, i32 0
  store i8** %t159, i8*** %t164
  %t165 = getelementptr { i8**, i64 }, { i8**, i64 }* %t163, i32 0, i32 1
  store i64 0, i64* %t165
  %t166 = call %LoweredLLVMResult @lower_to_llvm_with_context(%NativeModule %t152, { %LayoutManifest*, i64 }* %t153, { i8**, i64 }* %native_artifacts, { i8**, i64 }* %t163)
  store %LoweredLLVMResult %t166, %LoweredLLVMResult* %l5
  %t167 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t168 = ptrtoint [0 x i8*]* %t167 to i64
  %t169 = icmp eq i64 %t168, 0
  %t170 = select i1 %t169, i64 1, i64 %t168
  %t171 = call i8* @malloc(i64 %t170)
  %t172 = bitcast i8* %t171 to i8**
  %t173 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t174 = ptrtoint { i8**, i64 }* %t173 to i64
  %t175 = call i8* @malloc(i64 %t174)
  %t176 = bitcast i8* %t175 to { i8**, i64 }*
  %t177 = getelementptr { i8**, i64 }, { i8**, i64 }* %t176, i32 0, i32 0
  store i8** %t172, i8*** %t177
  %t178 = getelementptr { i8**, i64 }, { i8**, i64 }* %t176, i32 0, i32 1
  store i64 0, i64* %t178
  store { i8**, i64 }* %t176, { i8**, i64 }** %l6
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t180 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t181 = extractvalue %EmitNativeResult %t180, 1
  %t182 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t179, { i8**, i64 }* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l6
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t184 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t185 = extractvalue %LoweredLLVMResult %t184, 1
  %t186 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t183, { i8**, i64 }* %t185)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l6
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t188 = load { i8**, i64 }, { i8**, i64 }* %t187
  %t189 = extractvalue { i8**, i64 } %t188, 1
  %t190 = icmp sgt i64 %t189, 0
  %t191 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t192 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t193 = load double, double* %l2
  %t194 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t190, label %then9, label %merge10
then9:
  %t196 = sitofp i64 0 to double
  store double %t196, double* %l7
  %t197 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t198 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t199 = load double, double* %l2
  %t200 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t202 = load double, double* %l7
  br label %loop.header11
loop.header11:
  %t231 = phi double [ %t202, %then9 ], [ %t230, %loop.latch13 ]
  store double %t231, double* %l7
  br label %loop.body12
loop.body12:
  %t203 = load double, double* %l7
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t205 = load { i8**, i64 }, { i8**, i64 }* %t204
  %t206 = extractvalue { i8**, i64 } %t205, 1
  %t207 = sitofp i64 %t206 to double
  %t208 = fcmp oge double %t203, %t207
  %t209 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t210 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t211 = load double, double* %l2
  %t212 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t214 = load double, double* %l7
  br i1 %t208, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %s215 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t217 = load double, double* %l7
  %t218 = call double @llvm.round.f64(double %t217)
  %t219 = fptosi double %t218 to i64
  %t220 = load { i8**, i64 }, { i8**, i64 }* %t216
  %t221 = extractvalue { i8**, i64 } %t220, 0
  %t222 = extractvalue { i8**, i64 } %t220, 1
  %t223 = icmp uge i64 %t219, %t222
  ; bounds check: %t223 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t219, i64 %t222)
  %t224 = getelementptr i8*, i8** %t221, i64 %t219
  %t225 = load i8*, i8** %t224
  %t226 = call i8* @sailfin_runtime_string_concat(i8* %s215, i8* %t225)
  call void @sailfin_runtime_print_warn(i8* %t226)
  %t227 = load double, double* %l7
  %t228 = sitofp i64 1 to double
  %t229 = fadd double %t227, %t228
  store double %t229, double* %l7
  br label %loop.latch13
loop.latch13:
  %t230 = load double, double* %l7
  br label %loop.header11
afterloop14:
  %t232 = load double, double* %l7
  br label %merge10
merge10:
  %t233 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t234 = extractvalue %LoweredLLVMResult %t233, 0
  %t235 = insertvalue %LoweredLLVMResult undef, i8* %t234, 0
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t237 = insertvalue %LoweredLLVMResult %t235, { i8**, i64 }* %t236, 1
  %t238 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t239 = extractvalue %LoweredLLVMResult %t238, 2
  %t240 = insertvalue %LoweredLLVMResult %t237, %TraitMetadata %t239, 2
  %t241 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t242 = extractvalue %LoweredLLVMResult %t241, 3
  %t243 = insertvalue %LoweredLLVMResult %t240, { %FunctionEffectEntry**, i64 }* %t242, 3
  %t244 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t245 = extractvalue %LoweredLLVMResult %t244, 4
  %t246 = insertvalue %LoweredLLVMResult %t243, { %LifetimeRegionMetadata**, i64 }* %t245, 4
  %t247 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t248 = extractvalue %LoweredLLVMResult %t247, 5
  %t249 = insertvalue %LoweredLLVMResult %t246, %CapabilityManifest %t248, 5
  %t250 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t251 = extractvalue %LoweredLLVMResult %t250, 6
  %t252 = insertvalue %LoweredLLVMResult %t249, { %StringConstant**, i64 }* %t251, 6
  ret %LoweredLLVMResult %t252
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
define void @main() {
block.entry:
  %s0 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h385769534, i32 0, i32 0
  call void @sailfin_runtime_print_info(i8* %s0)
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
  %t45 = bitcast %CompiledModule* %t44 to i8*
  %t46 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t47 = ptrtoint [1 x i8*]* %t46 to i64
  %t48 = icmp eq i64 %t47, 0
  %t49 = select i1 %t48, i64 1, i64 %t47
  %t50 = call i8* @malloc(i64 %t49)
  %t51 = bitcast i8* %t50 to i8**
  %t52 = getelementptr i8*, i8** %t51, i64 0
  store i8* %t45, i8** %t52
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t54 = ptrtoint { i8**, i64 }* %t53 to i64
  %t55 = call i8* @malloc(i64 %t54)
  %t56 = bitcast i8* %t55 to { i8**, i64 }*
  %t57 = getelementptr { i8**, i64 }, { i8**, i64 }* %t56, i32 0, i32 0
  store i8** %t51, i8*** %t57
  %t58 = getelementptr { i8**, i64 }, { i8**, i64 }* %t56, i32 0, i32 1
  store i64 1, i64* %t58
  %t59 = bitcast { %CompiledModule*, i64 }* %t42 to { i8**, i64 }*
  %t60 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t59, { i8**, i64 }* %t56)
  %t61 = bitcast { i8**, i64 }* %t60 to { %CompiledModule*, i64 }*
  store { %CompiledModule*, i64 }* %t61, { %CompiledModule*, i64 }** %l0
  %t62 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  br label %merge5
merge5:
  %t63 = phi { %CompiledModule*, i64 }* [ %t62, %then4 ], [ %t38, %forbody1 ]
  store { %CompiledModule*, i64 }* %t63, { %CompiledModule*, i64 }** %l0
  %t64 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t65 = extractvalue %ModuleCompilationResult %t64, 1
  %t66 = load { %ModuleDiagnostics**, i64 }, { %ModuleDiagnostics**, i64 }* %t65
  %t67 = extractvalue { %ModuleDiagnostics**, i64 } %t66, 1
  %t68 = icmp sgt i64 %t67, 0
  %t69 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t70 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t71 = load i8*, i8** %l3
  %t72 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t68, label %then6, label %merge7
then6:
  %t73 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t74 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t75 = extractvalue %ModuleCompilationResult %t74, 1
  %t76 = bitcast { %ModuleDiagnostics*, i64 }* %t73 to { i8**, i64 }*
  %t77 = bitcast { %ModuleDiagnostics**, i64 }* %t75 to { i8**, i64 }*
  %t78 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t76, { i8**, i64 }* %t77)
  %t79 = bitcast { i8**, i64 }* %t78 to { %ModuleDiagnostics*, i64 }*
  store { %ModuleDiagnostics*, i64 }* %t79, { %ModuleDiagnostics*, i64 }** %l1
  %t80 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  br label %merge7
merge7:
  %t81 = phi { %ModuleDiagnostics*, i64 }* [ %t80, %then6 ], [ %t70, %merge5 ]
  store { %ModuleDiagnostics*, i64 }* %t81, { %ModuleDiagnostics*, i64 }** %l1
  br label %forinc2
forinc2:
  %t82 = load i64, i64* %l2
  %t83 = add i64 %t82, 1
  store i64 %t83, i64* %l2
  br label %for0
afterfor3:
  %t84 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t85 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t86 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t87 = bitcast { %CompiledModule*, i64 }* %t86 to { %CompiledModule**, i64 }*
  %t88 = insertvalue %ProjectCompilation undef, { %CompiledModule**, i64 }* %t87, 0
  %t89 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t90 = bitcast { %ModuleDiagnostics*, i64 }* %t89 to { %ModuleDiagnostics**, i64 }*
  %t91 = insertvalue %ProjectCompilation %t88, { %ModuleDiagnostics**, i64 }* %t90, 1
  ret %ProjectCompilation %t91
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
  %t7 = load { %Diagnostic**, i64 }, { %Diagnostic**, i64 }* %t6
  %t8 = extractvalue { %Diagnostic**, i64 } %t7, 1
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
  %t19 = bitcast { %Diagnostic**, i64 }* %t17 to { %Diagnostic*, i64 }*
  %t20 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %t19, i8* %t18)
  %t21 = insertvalue %ModuleDiagnostics %t15, { i8**, i64 }* %t20, 1
  %t22 = insertvalue %ModuleDiagnostics %t21, i1 1, 2
  %t23 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t24 = ptrtoint [1 x %ModuleDiagnostics]* %t23 to i64
  %t25 = icmp eq i64 %t24, 0
  %t26 = select i1 %t25, i64 1, i64 %t24
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %ModuleDiagnostics*
  %t29 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t28, i64 0
  store %ModuleDiagnostics %t22, %ModuleDiagnostics* %t29
  %t30 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t31 = ptrtoint { %ModuleDiagnostics*, i64 }* %t30 to i64
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to { %ModuleDiagnostics*, i64 }*
  %t34 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t33, i32 0, i32 0
  store %ModuleDiagnostics* %t28, %ModuleDiagnostics** %t34
  %t35 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = bitcast { %ModuleDiagnostics*, i64 }* %t33 to { %ModuleDiagnostics**, i64 }*
  %t37 = insertvalue %ModuleCompilationResult %t14, { %ModuleDiagnostics**, i64 }* %t36, 1
  ret %ModuleCompilationResult %t37
merge1:
  %t38 = load %Program, %Program* %l1
  %t39 = call %EmitNativeResult @emit_native(%Program %t38)
  store %EmitNativeResult %t39, %EmitNativeResult* %l3
  %t40 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t41 = extractvalue %EmitNativeResult %t40, 0
  %t42 = call %LoweredPythonResult @lower_to_python(%NativeModule %t41)
  store %LoweredPythonResult %t42, %LoweredPythonResult* %l4
  %t43 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t44 = extractvalue %EmitNativeResult %t43, 1
  %t45 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t46 = extractvalue %LoweredPythonResult %t45, 1
  %t47 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l5
  %t48 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t49 = extractvalue %LoweredPythonResult %t48, 0
  store i8* %t49, i8** %l6
  %t50 = load i8*, i8** %l6
  %t51 = call i1 @needs_python_fallback(i8* %t50)
  store i1 %t51, i1* %l7
  %t52 = load i1, i1* %l7
  %t53 = load i8*, i8** %l0
  %t54 = load %Program, %Program* %l1
  %t55 = load %TypecheckResult, %TypecheckResult* %l2
  %t56 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t57 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t59 = load i8*, i8** %l6
  %t60 = load i1, i1* %l7
  br i1 %t52, label %then2, label %merge3
then2:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s62 = getelementptr inbounds [86 x i8], [86 x i8]* @.str.len85.h1706301526, i32 0, i32 0
  %t63 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t64 = ptrtoint [1 x i8*]* %t63 to i64
  %t65 = icmp eq i64 %t64, 0
  %t66 = select i1 %t65, i64 1, i64 %t64
  %t67 = call i8* @malloc(i64 %t66)
  %t68 = bitcast i8* %t67 to i8**
  %t69 = getelementptr i8*, i8** %t68, i64 0
  store i8* %s62, i8** %t69
  %t70 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t71 = ptrtoint { i8**, i64 }* %t70 to i64
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to { i8**, i64 }*
  %t74 = getelementptr { i8**, i64 }, { i8**, i64 }* %t73, i32 0, i32 0
  store i8** %t68, i8*** %t74
  %t75 = getelementptr { i8**, i64 }, { i8**, i64 }* %t73, i32 0, i32 1
  store i64 1, i64* %t75
  %t76 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t61, { i8**, i64 }* %t73)
  store { i8**, i64 }* %t76, { i8**, i64 }** %l5
  %t77 = bitcast i8* null to %CompiledModule*
  %t78 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t77, 0
  %t79 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t81 = insertvalue %ModuleDiagnostics %t79, { i8**, i64 }* %t80, 1
  %t82 = insertvalue %ModuleDiagnostics %t81, i1 1, 2
  %t83 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t84 = ptrtoint [1 x %ModuleDiagnostics]* %t83 to i64
  %t85 = icmp eq i64 %t84, 0
  %t86 = select i1 %t85, i64 1, i64 %t84
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to %ModuleDiagnostics*
  %t89 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t88, i64 0
  store %ModuleDiagnostics %t82, %ModuleDiagnostics* %t89
  %t90 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t91 = ptrtoint { %ModuleDiagnostics*, i64 }* %t90 to i64
  %t92 = call i8* @malloc(i64 %t91)
  %t93 = bitcast i8* %t92 to { %ModuleDiagnostics*, i64 }*
  %t94 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t93, i32 0, i32 0
  store %ModuleDiagnostics* %t88, %ModuleDiagnostics** %t94
  %t95 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t93, i32 0, i32 1
  store i64 1, i64* %t95
  %t96 = bitcast { %ModuleDiagnostics*, i64 }* %t93 to { %ModuleDiagnostics**, i64 }*
  %t97 = insertvalue %ModuleCompilationResult %t78, { %ModuleDiagnostics**, i64 }* %t96, 1
  ret %ModuleCompilationResult %t97
merge3:
  %t98 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* null, i32 1
  %t99 = ptrtoint [0 x %ModuleDiagnostics]* %t98 to i64
  %t100 = icmp eq i64 %t99, 0
  %t101 = select i1 %t100, i64 1, i64 %t99
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to %ModuleDiagnostics*
  %t104 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t105 = ptrtoint { %ModuleDiagnostics*, i64 }* %t104 to i64
  %t106 = call i8* @malloc(i64 %t105)
  %t107 = bitcast i8* %t106 to { %ModuleDiagnostics*, i64 }*
  %t108 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t107, i32 0, i32 0
  store %ModuleDiagnostics* %t103, %ModuleDiagnostics** %t108
  %t109 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t107, i32 0, i32 1
  store i64 0, i64* %t109
  store { %ModuleDiagnostics*, i64 }* %t107, { %ModuleDiagnostics*, i64 }** %l8
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t111 = load { i8**, i64 }, { i8**, i64 }* %t110
  %t112 = extractvalue { i8**, i64 } %t111, 1
  %t113 = icmp sgt i64 %t112, 0
  %t114 = load i8*, i8** %l0
  %t115 = load %Program, %Program* %l1
  %t116 = load %TypecheckResult, %TypecheckResult* %l2
  %t117 = load %EmitNativeResult, %EmitNativeResult* %l3
  %t118 = load %LoweredPythonResult, %LoweredPythonResult* %l4
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t120 = load i8*, i8** %l6
  %t121 = load i1, i1* %l7
  %t122 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br i1 %t113, label %then4, label %merge5
then4:
  %t123 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t125 = insertvalue %ModuleDiagnostics %t123, { i8**, i64 }* %t124, 1
  %t126 = insertvalue %ModuleDiagnostics %t125, i1 0, 2
  %t127 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t128 = ptrtoint [1 x %ModuleDiagnostics]* %t127 to i64
  %t129 = icmp eq i64 %t128, 0
  %t130 = select i1 %t129, i64 1, i64 %t128
  %t131 = call i8* @malloc(i64 %t130)
  %t132 = bitcast i8* %t131 to %ModuleDiagnostics*
  %t133 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t132, i64 0
  store %ModuleDiagnostics %t126, %ModuleDiagnostics* %t133
  %t134 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t135 = ptrtoint { %ModuleDiagnostics*, i64 }* %t134 to i64
  %t136 = call i8* @malloc(i64 %t135)
  %t137 = bitcast i8* %t136 to { %ModuleDiagnostics*, i64 }*
  %t138 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t137, i32 0, i32 0
  store %ModuleDiagnostics* %t132, %ModuleDiagnostics** %t138
  %t139 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t137, i32 0, i32 1
  store i64 1, i64* %t139
  store { %ModuleDiagnostics*, i64 }* %t137, { %ModuleDiagnostics*, i64 }** %l8
  %t140 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br label %merge5
merge5:
  %t141 = phi { %ModuleDiagnostics*, i64 }* [ %t140, %then4 ], [ %t122, %merge3 ]
  store { %ModuleDiagnostics*, i64 }* %t141, { %ModuleDiagnostics*, i64 }** %l8
  %t142 = insertvalue %CompiledModule undef, i8* %source_path, 0
  %t143 = load i8*, i8** %l6
  %t144 = insertvalue %CompiledModule %t142, i8* %t143, 1
  %t145 = alloca %CompiledModule
  store %CompiledModule %t144, %CompiledModule* %t145
  %t146 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t145, 0
  %t147 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  %t148 = bitcast { %ModuleDiagnostics*, i64 }* %t147 to { %ModuleDiagnostics**, i64 }*
  %t149 = insertvalue %ModuleCompilationResult %t146, { %ModuleDiagnostics**, i64 }* %t148, 1
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
  %t5 = call i8* @number_to_string(double %t4)
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
  %s1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1402485025, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l1
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 32, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = sitofp i64 %t3 to double
  %t9 = call i8* @repeat_character(i8* %t7, double %t8)
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
  %s25 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1801723778, i32 0, i32 0
  %t26 = load double, double* %l2
  %t27 = call i8* @number_to_string(double %t26)
  %t28 = call i8* @sailfin_runtime_string_concat(i8* %s25, i8* %t27)
  %s29 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h507529196, i32 0, i32 0
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t28, i8* %s29)
  %t31 = load double, double* %l3
  %t32 = call i8* @number_to_string(double %t31)
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t30, i8* %t32)
  store i8* %t33, i8** %l4
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l4
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fcmp olt double %t38, %t39
  br label %logical_or_entry_37

logical_or_entry_37:
  br i1 %t40, label %logical_or_merge_37, label %logical_or_right_37

logical_or_right_37:
  %t41 = load double, double* %l2
  %t42 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = sitofp i64 %t43 to double
  %t45 = fcmp ogt double %t41, %t44
  br label %logical_or_right_end_37

logical_or_right_end_37:
  br label %logical_or_merge_37

logical_or_merge_37:
  %t46 = phi i1 [ true, %logical_or_entry_37 ], [ %t45, %logical_or_right_end_37 ]
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load %Token*, %Token** %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  br i1 %t46, label %then2, label %merge3
then2:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = call i8* @join_lines({ i8**, i64 }* %t52)
  call void @sailfin_runtime_mark_persistent(i8* %t53)
  ret i8* %t53
merge3:
  %t54 = load double, double* %l2
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  %t57 = call double @llvm.round.f64(double %t56)
  %t58 = fptosi double %t57 to i64
  %t59 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 %t58, %t61
  ; bounds check: %t62 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t58, i64 %t61)
  %t63 = getelementptr i8*, i8** %t60, i64 %t58
  %t64 = load i8*, i8** %t63
  store i8* %t64, i8** %l5
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 32, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call i8* @repeat_character(i8* %t68, double %line_padding)
  store i8* %t69, i8** %l6
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l6
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 32, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %t71)
  %s77 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %s77)
  %t79 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t70, i8* %t78)
  store { i8**, i64 }* %t79, { i8**, i64 }** %l0
  %t80 = load double, double* %l2
  %t81 = call i8* @number_to_string(double %t80)
  store i8* %t81, i8** %l7
  %s82 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s82, i8** %l8
  %t83 = load i8*, i8** %l7
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = sitofp i64 %t84 to double
  %t86 = fsub double %line_padding, %t85
  store double %t86, double* %l9
  %t87 = load double, double* %l9
  %t88 = sitofp i64 0 to double
  %t89 = fcmp olt double %t87, %t88
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load %Token*, %Token** %l1
  %t92 = load double, double* %l2
  %t93 = load double, double* %l3
  %t94 = load i8*, i8** %l4
  %t95 = load i8*, i8** %l5
  %t96 = load i8*, i8** %l6
  %t97 = load i8*, i8** %l7
  %t98 = load i8*, i8** %l8
  %t99 = load double, double* %l9
  br i1 %t89, label %then4, label %merge5
then4:
  %t100 = sitofp i64 0 to double
  store double %t100, double* %l9
  %t101 = load double, double* %l9
  br label %merge5
merge5:
  %t102 = phi double [ %t101, %then4 ], [ %t99, %merge3 ]
  store double %t102, double* %l9
  %t103 = load double, double* %l9
  %t104 = sitofp i64 0 to double
  %t105 = fcmp ogt double %t103, %t104
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load %Token*, %Token** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load i8*, i8** %l4
  %t111 = load i8*, i8** %l5
  %t112 = load i8*, i8** %l6
  %t113 = load i8*, i8** %l7
  %t114 = load i8*, i8** %l8
  %t115 = load double, double* %l9
  br i1 %t105, label %then6, label %merge7
then6:
  %t116 = load double, double* %l9
  %t117 = alloca [2 x i8], align 1
  %t118 = getelementptr [2 x i8], [2 x i8]* %t117, i32 0, i32 0
  store i8 32, i8* %t118
  %t119 = getelementptr [2 x i8], [2 x i8]* %t117, i32 0, i32 1
  store i8 0, i8* %t119
  %t120 = getelementptr [2 x i8], [2 x i8]* %t117, i32 0, i32 0
  %t121 = call i8* @repeat_character(i8* %t120, double %t116)
  store i8* %t121, i8** %l8
  %t122 = load i8*, i8** %l8
  br label %merge7
merge7:
  %t123 = phi i8* [ %t122, %then6 ], [ %t114, %merge5 ]
  store i8* %t123, i8** %l8
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l8
  %t126 = alloca [2 x i8], align 1
  %t127 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  store i8 32, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 1
  store i8 0, i8* %t128
  %t129 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  %t130 = call i8* @sailfin_runtime_string_concat(i8* %t129, i8* %t125)
  %t131 = load i8*, i8** %l7
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %t130, i8* %t131)
  %s133 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087759686, i32 0, i32 0
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %s133)
  %t135 = load i8*, i8** %l5
  %t136 = call i8* @sailfin_runtime_string_concat(i8* %t134, i8* %t135)
  %t137 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t124, i8* %t136)
  store { i8**, i64 }* %t137, { i8**, i64 }** %l0
  %t138 = load double, double* %l3
  %t139 = load %Token*, %Token** %l1
  %t140 = getelementptr %Token, %Token* %t139, i32 0, i32 1
  %t141 = load i8*, i8** %t140
  %t142 = load i8*, i8** %l5
  %t143 = call i8* @build_pointer_line(double %t138, i8* %t141, i8* %t142)
  store i8* %t143, i8** %l10
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8*, i8** %l6
  %t146 = alloca [2 x i8], align 1
  %t147 = getelementptr [2 x i8], [2 x i8]* %t146, i32 0, i32 0
  store i8 32, i8* %t147
  %t148 = getelementptr [2 x i8], [2 x i8]* %t146, i32 0, i32 1
  store i8 0, i8* %t148
  %t149 = getelementptr [2 x i8], [2 x i8]* %t146, i32 0, i32 0
  %t150 = call i8* @sailfin_runtime_string_concat(i8* %t149, i8* %t145)
  %s151 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087759686, i32 0, i32 0
  %t152 = call i8* @sailfin_runtime_string_concat(i8* %t150, i8* %s151)
  %t153 = load i8*, i8** %l10
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t152, i8* %t153)
  %t155 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t144, i8* %t154)
  store { i8**, i64 }* %t155, { i8**, i64 }** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = call i8* @join_lines({ i8**, i64 }* %t156)
  call void @sailfin_runtime_mark_persistent(i8* %t157)
  ret i8* %t157
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
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t104 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t101, %loop.latch2 ]
  %t105 = phi i8* [ %t15, %block.entry ], [ %t102, %loop.latch2 ]
  %t106 = phi double [ %t16, %block.entry ], [ %t103, %loop.latch2 ]
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  store i8* %t105, i8** %l1
  store double %t106, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %source)
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
  %t25 = load double, double* %l2
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @llvm.round.f64(double %t24)
  %t29 = fptosi double %t28 to i64
  %t30 = call double @llvm.round.f64(double %t27)
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t29, i64 %t31)
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = load i8, i8* %t33
  %t35 = icmp eq i8 %t34, 13
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = load double, double* %l2
  %t39 = load i8*, i8** %l3
  br i1 %t35, label %then6, label %merge7
then6:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  %s43 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s43, i8** %l1
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  %t47 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t48 = sitofp i64 %t47 to double
  %t49 = fcmp olt double %t46, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load i8*, i8** %l3
  br i1 %t49, label %then8, label %merge9
then8:
  %t54 = load double, double* %l2
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  %t57 = load double, double* %l2
  %t58 = sitofp i64 2 to double
  %t59 = fadd double %t57, %t58
  %t60 = call double @llvm.round.f64(double %t56)
  %t61 = fptosi double %t60 to i64
  %t62 = call double @llvm.round.f64(double %t59)
  %t63 = fptosi double %t62 to i64
  %t64 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t61, i64 %t63)
  store i8* %t64, i8** %l4
  %t65 = load i8*, i8** %l4
  %t66 = load i8, i8* %t65
  %t67 = icmp eq i8 %t66, 10
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l3
  %t72 = load i8*, i8** %l4
  br i1 %t67, label %then10, label %merge11
then10:
  %t73 = load double, double* %l2
  %t74 = sitofp i64 2 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch2
merge11:
  %t76 = load double, double* %l2
  br label %merge9
merge9:
  %t77 = phi double [ %t76, %merge11 ], [ %t52, %then6 ]
  store double %t77, double* %l2
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch2
merge7:
  %t81 = load i8*, i8** %l3
  %t82 = load i8, i8* %t81
  %t83 = icmp eq i8 %t82, 10
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l2
  %t87 = load i8*, i8** %l3
  br i1 %t83, label %then12, label %merge13
then12:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t88, i8* %t89)
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  %s91 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s91, i8** %l1
  %t92 = load double, double* %l2
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l2
  br label %loop.latch2
merge13:
  %t95 = load i8*, i8** %l1
  %t96 = load i8*, i8** %l3
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %t96)
  store i8* %t97, i8** %l1
  %t98 = load double, double* %l2
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l2
  br label %loop.latch2
loop.latch2:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  %t103 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load i8*, i8** %l1
  %t109 = load double, double* %l2
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t110, i8* %t111)
  store { i8**, i64 }* %t112, { i8**, i64 }** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t113
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
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 94, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  store double %column, double* %l0
  %t6 = load double, double* %l0
  %t7 = sitofp i64 1 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load double, double* %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l0
  %t11 = load double, double* %l0
  br label %merge3
merge3:
  %t12 = phi double [ %t11, %then2 ], [ %t9, %merge1 ]
  store double %t12, double* %l0
  %t13 = load double, double* %l0
  %t14 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp ogt double %t13, %t15
  %t17 = load double, double* %l0
  br i1 %t16, label %then4, label %merge5
then4:
  %t18 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t19 = sitofp i64 %t18 to double
  store double %t19, double* %l0
  %t20 = load double, double* %l0
  br label %merge5
merge5:
  %t21 = phi double [ %t20, %then4 ], [ %t17, %merge3 ]
  store double %t21, double* %l0
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s22, i8** %l1
  %t23 = sitofp i64 1 to double
  store double %t23, double* %l2
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t86 = phi i8* [ %t25, %merge5 ], [ %t84, %loop.latch8 ]
  %t87 = phi double [ %t26, %merge5 ], [ %t85, %loop.latch8 ]
  store i8* %t86, i8** %l1
  store double %t87, double* %l2
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
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 9, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t60)
  store i8* %t61, i8** %l1
  %t62 = load i8*, i8** %l1
  br label %merge17
else16:
  %t63 = load i8*, i8** %l1
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 32, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t67)
  store i8* %t68, i8** %l1
  %t69 = load i8*, i8** %l1
  br label %merge17
merge17:
  %t70 = phi i8* [ %t62, %then15 ], [ %t69, %else16 ]
  store i8* %t70, i8** %l1
  %t71 = load i8*, i8** %l1
  %t72 = load i8*, i8** %l1
  br label %merge14
else13:
  %t73 = load i8*, i8** %l1
  %t74 = alloca [2 x i8], align 1
  %t75 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 0
  store i8 32, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 1
  store i8 0, i8* %t76
  %t77 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 0
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t73, i8* %t77)
  store i8* %t78, i8** %l1
  %t79 = load i8*, i8** %l1
  br label %merge14
merge14:
  %t80 = phi i8* [ %t71, %merge17 ], [ %t79, %else13 ]
  store i8* %t80, i8** %l1
  %t81 = load double, double* %l2
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  store double %t83, double* %l2
  br label %loop.latch8
loop.latch8:
  %t84 = load i8*, i8** %l1
  %t85 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t88 = load i8*, i8** %l1
  %t89 = load double, double* %l2
  %t90 = call i64 @sailfin_runtime_string_length(i8* %lexeme)
  %t91 = sitofp i64 %t90 to double
  store double %t91, double* %l4
  %t92 = load double, double* %l4
  %t93 = sitofp i64 0 to double
  %t94 = fcmp ole double %t92, %t93
  %t95 = load double, double* %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l4
  br i1 %t94, label %then18, label %merge19
then18:
  %t99 = sitofp i64 1 to double
  store double %t99, double* %l4
  %t100 = load double, double* %l4
  br label %merge19
merge19:
  %t101 = phi double [ %t100, %then18 ], [ %t98, %afterloop9 ]
  store double %t101, double* %l4
  %t102 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t103 = load double, double* %l0
  %t104 = sitofp i64 1 to double
  %t105 = fsub double %t103, %t104
  %t106 = sitofp i64 %t102 to double
  %t107 = fsub double %t106, %t105
  store double %t107, double* %l5
  %t108 = load double, double* %l5
  %t109 = sitofp i64 0 to double
  %t110 = fcmp ole double %t108, %t109
  %t111 = load double, double* %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load double, double* %l4
  %t115 = load double, double* %l5
  br i1 %t110, label %then20, label %merge21
then20:
  %t116 = sitofp i64 1 to double
  store double %t116, double* %l5
  %t117 = load double, double* %l5
  br label %merge21
merge21:
  %t118 = phi double [ %t117, %then20 ], [ %t115, %merge19 ]
  store double %t118, double* %l5
  %t119 = load double, double* %l4
  %t120 = load double, double* %l5
  %t121 = fcmp ogt double %t119, %t120
  %t122 = load double, double* %l0
  %t123 = load i8*, i8** %l1
  %t124 = load double, double* %l2
  %t125 = load double, double* %l4
  %t126 = load double, double* %l5
  br i1 %t121, label %then22, label %merge23
then22:
  %t127 = load double, double* %l5
  store double %t127, double* %l4
  %t128 = load double, double* %l4
  br label %merge23
merge23:
  %t129 = phi double [ %t128, %then22 ], [ %t125, %merge21 ]
  store double %t129, double* %l4
  %t130 = sitofp i64 0 to double
  store double %t130, double* %l6
  %t131 = load double, double* %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l4
  %t135 = load double, double* %l5
  %t136 = load double, double* %l6
  br label %loop.header24
loop.header24:
  %t157 = phi i8* [ %t132, %merge23 ], [ %t155, %loop.latch26 ]
  %t158 = phi double [ %t136, %merge23 ], [ %t156, %loop.latch26 ]
  store i8* %t157, i8** %l1
  store double %t158, double* %l6
  br label %loop.body25
loop.body25:
  %t137 = load double, double* %l6
  %t138 = load double, double* %l4
  %t139 = fcmp oge double %t137, %t138
  %t140 = load double, double* %l0
  %t141 = load i8*, i8** %l1
  %t142 = load double, double* %l2
  %t143 = load double, double* %l4
  %t144 = load double, double* %l5
  %t145 = load double, double* %l6
  br i1 %t139, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t146 = load i8*, i8** %l1
  %t147 = alloca [2 x i8], align 1
  %t148 = getelementptr [2 x i8], [2 x i8]* %t147, i32 0, i32 0
  store i8 94, i8* %t148
  %t149 = getelementptr [2 x i8], [2 x i8]* %t147, i32 0, i32 1
  store i8 0, i8* %t149
  %t150 = getelementptr [2 x i8], [2 x i8]* %t147, i32 0, i32 0
  %t151 = call i8* @sailfin_runtime_string_concat(i8* %t146, i8* %t150)
  store i8* %t151, i8** %l1
  %t152 = load double, double* %l6
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l6
  br label %loop.latch26
loop.latch26:
  %t155 = load i8*, i8** %l1
  %t156 = load double, double* %l6
  br label %loop.header24
afterloop27:
  %t159 = load i8*, i8** %l1
  %t160 = load double, double* %l6
  %t161 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t161)
  ret i8* %t161
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %lines
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
  %t41 = phi i8* [ %t11, %merge1 ], [ %t39, %loop.latch4 ]
  %t42 = phi double [ %t12, %merge1 ], [ %t40, %loop.latch4 ]
  store i8* %t41, i8** %l0
  store double %t42, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %lines
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
  %t21 = alloca [2 x i8], align 1
  %t22 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  store i8 10, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 1
  store i8 0, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %t24)
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

define i8* @number_to_string(double %value) {
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
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 48, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  store double %value, double* %l0
  store i1 0, i1* %l1
  %t6 = load double, double* %l0
  %t7 = sitofp i64 0 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load double, double* %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load double, double* %l0
  %t12 = sitofp i64 0 to double
  %t13 = fsub double %t12, %t11
  store double %t13, double* %l0
  %t14 = load i1, i1* %l1
  %t15 = load double, double* %l0
  br label %merge3
merge3:
  %t16 = phi i1 [ %t14, %then2 ], [ %t10, %merge1 ]
  %t17 = phi double [ %t15, %then2 ], [ %t9, %merge1 ]
  store i1 %t16, i1* %l1
  store double %t17, double* %l0
  %s18 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s18, i8** %l2
  %t19 = load double, double* %l0
  store double %t19, double* %l3
  %s20 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s20, i8** %l4
  %t21 = load double, double* %l0
  %t22 = load i1, i1* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  %t25 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t81 = phi i8* [ %t25, %merge3 ], [ %t79, %loop.latch6 ]
  %t82 = phi double [ %t24, %merge3 ], [ %t80, %loop.latch6 ]
  store i8* %t81, i8** %l4
  store double %t82, double* %l3
  br label %loop.body5
loop.body5:
  %t26 = load double, double* %l3
  %t27 = sitofp i64 0 to double
  %t28 = fcmp ole double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load i1, i1* %l1
  %t31 = load i8*, i8** %l2
  %t32 = load double, double* %l3
  %t33 = load i8*, i8** %l4
  br i1 %t28, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t34 = load double, double* %l3
  store double %t34, double* %l5
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l6
  %t36 = load double, double* %l0
  %t37 = load i1, i1* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l3
  %t40 = load i8*, i8** %l4
  %t41 = load double, double* %l5
  %t42 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t61 = phi double [ %t41, %merge9 ], [ %t59, %loop.latch12 ]
  %t62 = phi double [ %t42, %merge9 ], [ %t60, %loop.latch12 ]
  store double %t61, double* %l5
  store double %t62, double* %l6
  br label %loop.body11
loop.body11:
  %t43 = load double, double* %l5
  %t44 = sitofp i64 10 to double
  %t45 = fcmp olt double %t43, %t44
  %t46 = load double, double* %l0
  %t47 = load i1, i1* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load double, double* %l3
  %t50 = load i8*, i8** %l4
  %t51 = load double, double* %l5
  %t52 = load double, double* %l6
  br i1 %t45, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t53 = load double, double* %l5
  %t54 = sitofp i64 10 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l5
  %t56 = load double, double* %l6
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l6
  br label %loop.latch12
loop.latch12:
  %t59 = load double, double* %l5
  %t60 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t63 = load double, double* %l5
  %t64 = load double, double* %l6
  %t65 = load i8*, i8** %l2
  %t66 = load double, double* %l5
  %t67 = load double, double* %l5
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  %t70 = call double @llvm.round.f64(double %t66)
  %t71 = fptosi double %t70 to i64
  %t72 = call double @llvm.round.f64(double %t69)
  %t73 = fptosi double %t72 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %t65, i64 %t71, i64 %t73)
  store i8* %t74, i8** %l7
  %t75 = load i8*, i8** %l7
  %t76 = load i8*, i8** %l4
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %t76)
  store i8* %t77, i8** %l4
  %t78 = load double, double* %l6
  store double %t78, double* %l3
  br label %loop.latch6
loop.latch6:
  %t79 = load i8*, i8** %l4
  %t80 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t83 = load i8*, i8** %l4
  %t84 = load double, double* %l3
  %t85 = load i1, i1* %l1
  %t86 = load double, double* %l0
  %t87 = load i1, i1* %l1
  %t88 = load i8*, i8** %l2
  %t89 = load double, double* %l3
  %t90 = load i8*, i8** %l4
  br i1 %t85, label %then16, label %merge17
then16:
  %t91 = load i8*, i8** %l4
  %t92 = alloca [2 x i8], align 1
  %t93 = getelementptr [2 x i8], [2 x i8]* %t92, i32 0, i32 0
  store i8 45, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t92, i32 0, i32 1
  store i8 0, i8* %t94
  %t95 = getelementptr [2 x i8], [2 x i8]* %t92, i32 0, i32 0
  %t96 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %t91)
  store i8* %t96, i8** %l4
  %t97 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t98 = phi i8* [ %t97, %then16 ], [ %t90, %afterloop7 ]
  store i8* %t98, i8** %l4
  %t99 = load i8*, i8** %l4
  call void @sailfin_runtime_mark_persistent(i8* %t99)
  ret i8* %t99
}

define %NativeModule @empty_native_module() {
block.entry:
  %t0 = getelementptr [0 x %NativeArtifact*], [0 x %NativeArtifact*]* null, i32 1
  %t1 = ptrtoint [0 x %NativeArtifact*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeArtifact**
  %t6 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* null, i32 1
  %t7 = ptrtoint { %NativeArtifact**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %NativeArtifact**, i64 }*
  %t10 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t9, i32 0, i32 0
  store %NativeArtifact** %t5, %NativeArtifact*** %t10
  %t11 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = insertvalue %NativeModule undef, { %NativeArtifact**, i64 }* %t9, 0
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
  %s24 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h655249917, i32 0, i32 0
  %t25 = call i1 @string_contains(i8* %t23, i8* %s24)
  %t26 = load i8*, i8** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load i8*, i8** %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t30 = load i8*, i8** %l3
  %s31 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1516228563, i32 0, i32 0
  %t32 = call i1 @string_contains(i8* %t30, i8* %s31)
  %t33 = load i8*, i8** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load i8*, i8** %l2
  %t36 = load i8*, i8** %l3
  br i1 %t32, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t37 = load i8*, i8** %l3
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1517989476, i32 0, i32 0
  %t39 = call i1 @string_contains(i8* %t37, i8* %s38)
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load i8*, i8** %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t44 = load i8*, i8** %l3
  %s45 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h1158922578, i32 0, i32 0
  %t46 = call i1 @string_contains(i8* %t44, i8* %s45)
  %t47 = load i8*, i8** %l0
  %t48 = load i8*, i8** %l1
  %t49 = load i8*, i8** %l2
  %t50 = load i8*, i8** %l3
  br i1 %t46, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t51 = load i8*, i8** %l3
  %s52 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h675779786, i32 0, i32 0
  %t53 = call i1 @string_contains(i8* %t51, i8* %s52)
  %t54 = load i8*, i8** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load i8*, i8** %l2
  %t57 = load i8*, i8** %l3
  br i1 %t53, label %then14, label %merge15
then14:
  ret i1 1
merge15:
  %t58 = load i8*, i8** %l3
  %s59 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h1073483005, i32 0, i32 0
  %t60 = call i1 @string_contains(i8* %t58, i8* %s59)
  %t61 = load i8*, i8** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load i8*, i8** %l2
  %t64 = load i8*, i8** %l3
  br i1 %t60, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t65 = load i8*, i8** %l3
  %s66 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h459555839, i32 0, i32 0
  %t67 = call i1 @string_contains(i8* %t65, i8* %s66)
  %t68 = load i8*, i8** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t72 = load i8*, i8** %l3
  %s73 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h76517386, i32 0, i32 0
  %t74 = call i1 @string_contains(i8* %t72, i8* %s73)
  %t75 = load i8*, i8** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  %t79 = load i8*, i8** %l3
  %s80 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h2110906862, i32 0, i32 0
  %t81 = call i1 @string_contains(i8* %t79, i8* %s80)
  %t82 = load i8*, i8** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = load i8*, i8** %l3
  br i1 %t81, label %then22, label %merge23
then22:
  ret i1 1
merge23:
  %t86 = load i8*, i8** %l3
  %s87 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1337894058, i32 0, i32 0
  %t88 = call i1 @string_contains(i8* %t86, i8* %s87)
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load i8*, i8** %l2
  %t92 = load i8*, i8** %l3
  br i1 %t88, label %then24, label %merge25
then24:
  ret i1 1
merge25:
  %t93 = load i8*, i8** %l3
  %s94 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1300292754, i32 0, i32 0
  %t95 = call i1 @string_contains(i8* %t93, i8* %s94)
  %t96 = load i8*, i8** %l0
  %t97 = load i8*, i8** %l1
  %t98 = load i8*, i8** %l2
  %t99 = load i8*, i8** %l3
  br i1 %t95, label %then26, label %merge27
then26:
  ret i1 1
merge27:
  %t100 = load i8*, i8** %l3
  %s101 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h129277126, i32 0, i32 0
  %t102 = call i1 @string_contains(i8* %t100, i8* %s101)
  %t103 = load i8*, i8** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load i8*, i8** %l2
  %t106 = load i8*, i8** %l3
  br i1 %t102, label %then28, label %merge29
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
  %s0 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h111080155, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call double @find_substring(i8* %source, i8* %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = sitofp i64 0 to double
  %t5 = fcmp olt double %t3, %t4
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %source)
  ret i8* %source
merge1:
  %s8 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1175821684, i32 0, i32 0
  store i8* %s8, i8** %l2
  %t9 = load i8*, i8** %l2
  %t10 = load double, double* %l1
  %t11 = call double @find_substring_from(i8* %source, i8* %t9, double %t10)
  store double %t11, double* %l3
  %t12 = load double, double* %l3
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  %t18 = load double, double* %l3
  br i1 %t14, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* %source)
  ret i8* %source
merge3:
  %t19 = load double, double* %l3
  %t20 = load i8*, i8** %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = sitofp i64 %t21 to double
  %t23 = fadd double %t19, %t22
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = call double @advance_to_line_end(i8* %source, double %t24)
  store double %t25, double* %l4
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = call i8* @sailfin_runtime_substring(i8* %source, i64 0, i64 %t28)
  store i8* %t29, i8** %l5
  %t30 = load double, double* %l4
  %t31 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t32 = call double @llvm.round.f64(double %t30)
  %t33 = fptosi double %t32 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t33, i64 %t31)
  store i8* %t34, i8** %l6
  %t35 = load i8*, i8** %l5
  %t36 = load i8*, i8** %l6
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  ret i8* %t37
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
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  %t93 = phi i8* [ %t3, %block.entry ], [ %t91, %loop.latch2 ]
  %t94 = phi double [ %t2, %block.entry ], [ %t92, %loop.latch2 ]
  store i8* %t93, i8** %l1
  store double %t94, double* %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
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
  %t19 = load i8*, i8** %l2
  %t20 = load i8, i8* %t19
  %t21 = icmp eq i8 %t20, 39
  %t22 = load double, double* %l0
  %t23 = load i8*, i8** %l1
  %t24 = load i8*, i8** %l2
  br i1 %t21, label %then6, label %merge7
then6:
  %t25 = load double, double* %l0
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 39, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call double @python_quote_length(i8* %value, double %t25, i8* %t29)
  store double %t30, double* %l3
  %t31 = load double, double* %l3
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 39, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  %t36 = call i8* @repeat_character(i8* %t35, double %t31)
  store i8* %t36, i8** %l4
  %t37 = load i8*, i8** %l1
  %t38 = load i8*, i8** %l4
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t38)
  store i8* %t39, i8** %l1
  %t40 = load double, double* %l0
  %t41 = load double, double* %l3
  %t42 = fadd double %t40, %t41
  %t43 = load double, double* %l3
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 39, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  %t48 = call double @skip_python_string_literal(i8* %value, double %t42, i8* %t47, double %t43)
  store double %t48, double* %l0
  %t49 = load i8*, i8** %l1
  %t50 = load i8*, i8** %l4
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t50)
  store i8* %t51, i8** %l1
  br label %loop.latch2
merge7:
  %t52 = load i8*, i8** %l2
  %t53 = load i8, i8* %t52
  %t54 = icmp eq i8 %t53, 34
  %t55 = load double, double* %l0
  %t56 = load i8*, i8** %l1
  %t57 = load i8*, i8** %l2
  br i1 %t54, label %then8, label %merge9
then8:
  %t58 = load double, double* %l0
  %t59 = alloca [2 x i8], align 1
  %t60 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8 34, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 1
  store i8 0, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  %t63 = call double @python_quote_length(i8* %value, double %t58, i8* %t62)
  store double %t63, double* %l5
  %t64 = load double, double* %l5
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 34, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call i8* @repeat_character(i8* %t68, double %t64)
  store i8* %t69, i8** %l6
  %t70 = load i8*, i8** %l1
  %t71 = load i8*, i8** %l6
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load double, double* %l0
  %t74 = load double, double* %l5
  %t75 = fadd double %t73, %t74
  %t76 = load double, double* %l5
  %t77 = alloca [2 x i8], align 1
  %t78 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  store i8 34, i8* %t78
  %t79 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 1
  store i8 0, i8* %t79
  %t80 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  %t81 = call double @skip_python_string_literal(i8* %value, double %t75, i8* %t80, double %t76)
  store double %t81, double* %l0
  %t82 = load i8*, i8** %l1
  %t83 = load i8*, i8** %l6
  %t84 = call i8* @sailfin_runtime_string_concat(i8* %t82, i8* %t83)
  store i8* %t84, i8** %l1
  br label %loop.latch2
merge9:
  %t85 = load i8*, i8** %l1
  %t86 = load i8*, i8** %l2
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t85, i8* %t86)
  store i8* %t87, i8** %l1
  %t88 = load double, double* %l0
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l0
  br label %loop.latch2
loop.latch2:
  %t91 = load i8*, i8** %l1
  %t92 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l0
  %t97 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t97)
  ret i8* %t97
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s2)
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s4, i8** %l1
  %t5 = load double, double* %l0
  %t6 = load i8*, i8** %l1
  br label %loop.header2
loop.header2:
  %t18 = phi i8* [ %t6, %merge1 ], [ %t16, %loop.latch4 ]
  %t19 = phi double [ %t5, %merge1 ], [ %t17, %loop.latch4 ]
  store i8* %t18, i8** %l1
  store double %t19, double* %l0
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l0
  %t8 = fcmp oge double %t7, %count
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t11 = load i8*, i8** %l1
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %ch)
  store i8* %t12, i8** %l1
  %t13 = load double, double* %l0
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l0
  br label %loop.latch4
loop.latch4:
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  ret i8* %t22
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len5.h655249917 = private unnamed_addr constant [6 x i8] c"\0Alet \00"
@.str.len5.h1517989476 = private unnamed_addr constant [6 x i8] c" mut \00"
@.str.len38.h675779786 = private unnamed_addr constant [39 x i8] c"TokenKind.variant('NumberLiteral', [])\00"
@.str.len9.h2073631692 = private unnamed_addr constant [10 x i8] c"[native] \00"
@.str.len14.h2048158982 = private unnamed_addr constant [15 x i8] c"[native-llvm] \00"
@.str.len85.h1706301526 = private unnamed_addr constant [86 x i8] c"native backend: lowering produced unsupported python output; stage0 fallback disabled\00"
@.str.len21.h1300292754 = private unnamed_addr constant [22 x i8] c"ExpressionIdentifier(\00"
@.str.len23.h2110906862 = private unnamed_addr constant [24 x i8] c"Expression.Identifier()\00"
@.str.len31.h76517386 = private unnamed_addr constant [32 x i8] c"TokenKind.variant('Symbol', [])\00"
@.str.len16.h1337894058 = private unnamed_addr constant [17 x i8] c"Expression.Raw()\00"
@.str.len38.h1073483005 = private unnamed_addr constant [39 x i8] c"TokenKind.variant('StringLiteral', [])\00"
@.str.len39.h459555839 = private unnamed_addr constant [40 x i8] c"TokenKind.variant('BooleanLiteral', [])\00"
@.str.len35.h1158922578 = private unnamed_addr constant [36 x i8] c"TokenKind.variant('Identifier', [])\00"
@.str.len5.h1516228563 = private unnamed_addr constant [6 x i8] c" let \00"
@.str.len14.h129277126 = private unnamed_addr constant [15 x i8] c"ExpressionRaw(\00"