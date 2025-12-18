; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { %EnumVariantDefinition*, i64 }* }
%EnumInstance = type { %EnumType, i8*, { %EnumField*, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { %TypeDescriptor*, i64 }* }

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
%Token = type { %TokenKind, i8*, double, double }
%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
%TokenKind = type { i32, [8 x i8] }
%DecoratorArgumentInfo = type { i8*, %LiteralValue }
%DecoratorInfo = type { i8*, { %DecoratorArgumentInfo*, i64 }* }
%LiteralValue = type { i32, [8 x i8] }
%EffectRequirement = type { i8*, %Token*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { %EffectRequirement*, i64 }* }
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
%LexerState = type { i8*, double, double, double }
%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { %CompiledModule*, { %ModuleDiagnostics*, i64 }* }
%ProjectCompilation = type { { %CompiledModule*, i64 }*, { %ModuleDiagnostics*, i64 }* }
%LLVMCompilationResult = type { %LoweredLLVMResult, %NativeModule }
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
%PatternCaptureResult = type { %Parser, { %Token*, i64 }*, i1 }
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
%TraitDescriptor = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature*, i64 }* }
%TraitMetadata = type { { %TraitDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }* }
%FunctionEffectEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifestEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifest = type { { %CapabilityManifestEntry*, i64 }* }
%RuntimeHelperDescriptor = type { i8*, i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%FunctionCallEntry = type { i8*, { i8**, i64 }* }
%StringConstant = type { i8*, i8*, double }
%StringPointerResult = type { { i8**, i64 }*, double, i8* }
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
%Diagnostic = type { i8*, i8*, %Token* }
%SymbolEntry = type { i8*, i8*, %SourceSpan* }
%TypecheckResult = type { { %Diagnostic*, i64 }*, { %SymbolEntry*, i64 }* }
%SymbolCollectionResult = type { { %SymbolEntry*, i64 }*, { %Diagnostic*, i64 }* }
%ScopeResult = type { { %SymbolEntry*, i64 }*, { %Diagnostic*, i64 }* }
%NativeInstruction = type { i32, [48 x i8] }
%SelfHostCheckResult = type { i1, double, double, { %ModuleDiagnostics*, i64 }*, { i8**, i64 }* }
; intrinsic sailfin_runtime_sleep requires capabilities: ![clock]
declare void @sailfin_runtime_sleep(double)
; intrinsic sailfin_runtime_channel requires capabilities: ![io]
declare i8* @sailfin_runtime_channel(double)
; intrinsic sailfin_runtime_spawn requires capabilities: ![io]
declare void @sailfin_runtime_spawn(i8*, i8*)
; intrinsic sailfin_runtime_parallel requires capabilities: ![io]
declare i8* @sailfin_runtime_parallel(i8*)
declare i8* @sailfin_runtime_create_capability_grant(i8*)
; intrinsic sailfin_runtime_create_filesystem_bridge requires capabilities: ![io]
declare i8* @sailfin_runtime_create_filesystem_bridge(i8*)
; intrinsic sailfin_runtime_create_http_bridge requires capabilities: ![net]
declare i8* @sailfin_runtime_create_http_bridge(i8*)
; intrinsic sailfin_runtime_create_model_bridge requires capabilities: ![model]
declare i8* @sailfin_runtime_create_model_bridge(i8*)
; intrinsic sailfin_runtime_log_execution requires capabilities: ![io]
declare i8* @sailfin_runtime_log_execution(i8*)
declare i8* @sailfin_runtime_to_debug_string(i8*)
declare void @sailfin_runtime_raise_value_error(i8*)
declare i1 @sailfin_runtime_is_string(i8*)
declare i1 @sailfin_runtime_is_number(i8*)
declare i1 @sailfin_runtime_is_boolean(i8*)
declare i1 @sailfin_runtime_is_void(i8*)
declare void @sailfin_runtime_bounds_check(i64, i64)
declare i1 @sailfin_runtime_is_array(i8*)
declare i1 @sailfin_runtime_is_callable(i8*)
declare i8* @sailfin_runtime_resolve_type(i8*)
declare i1 @sailfin_runtime_instance_of(i8*, i8*)
; intrinsic sailfin_runtime_serve requires capabilities: ![io, net]
declare void @sailfin_runtime_serve(i8*, i8*)
declare double @sailfin_runtime_char_code(i8*)
declare i8* @sailfin_runtime_array_map(i8*, i8*)
declare i8* @sailfin_runtime_array_filter(i8*, i8*)
declare i8* @sailfin_runtime_array_reduce(i8*, i8*, i8*)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @sailfin_runtime_grapheme_count(i8*)
declare i8* @sailfin_runtime_grapheme_at(i8*, double)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len9.h1770336441 = private unnamed_addr constant [10 x i8] c"primitive\00"
@.str.len5.h550282393 = private unnamed_addr constant [6 x i8] c"union\00"
@.str.len12.h22148892 = private unnamed_addr constant [13 x i8] c"intersection\00"
@.str.len5.h1920110414 = private unnamed_addr constant [6 x i8] c"array\00"
@.str.len8.h1603982015 = private unnamed_addr constant [9 x i8] c"function\00"
@.str.len5.h261050197 = private unnamed_addr constant [6 x i8] c"named\00"
@.str.len7.h186837049 = private unnamed_addr constant [8 x i8] c"unknown\00"
@.str.len42.h1658844115 = private unnamed_addr constant [43 x i8] c"Non-exhaustive match for value {{ value }}\00"
@.str.len10.h626550212 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.len26.h287370135 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.len26.h645889856 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define i8* @capability_grant({ i8**, i64 }* %effects) {
block.entry:
  %t0 = bitcast { i8**, i64 }* %effects to i8*
  %t1 = call i8* @sailfin_runtime_create_capability_grant(i8* %t0)
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  ret i8* %t1
}

define i8* @fs_bridge(i8* %grant) {
block.entry:
  %t0 = call i8* @sailfin_runtime_create_filesystem_bridge(i8* %grant)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define i8* @http_bridge(i8* %grant) {
block.entry:
  %t0 = call i8* @sailfin_runtime_create_http_bridge(i8* %grant)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define i8* @model_bridge(i8* %grant) {
block.entry:
  %t0 = call i8* @sailfin_runtime_create_model_bridge(i8* %grant)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

; fn sleep effects: ![clock]
define void @sleep(double %milliseconds) {
block.entry:
  call void @sailfin_runtime_sleep(double %milliseconds)
  ret void
}

; fn channel effects: ![io]
define i8* @channel(double %capacity) {
block.entry:
  %t0 = call i8* @sailfin_runtime_channel(double %capacity)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

; fn parallel effects: ![io]
define { i8**, i64 }* @parallel({ i8**, i64 }* %tasks) {
block.entry:
  %t0 = bitcast { i8**, i64 }* %tasks to i8*
  %t1 = call i8* @sailfin_runtime_parallel(i8* %t0)
  %t2 = bitcast i8* %t1 to { i8**, i64 }*
  ret { i8**, i64 }* %t2
}

; fn spawn effects: ![io]
define void @spawn(i8* %task, i8* %name) {
block.entry:
  call void @sailfin_runtime_spawn(i8* %task, i8* %name)
  ret void
}

define i8* @logExecution(i8* %callable) {
block.entry:
  %t0 = call i8* @sailfin_runtime_log_execution(i8* %callable)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define { i8**, i64 }* @array_map({ i8**, i64 }* %items, i8* %mapper) {
block.entry:
  %t0 = bitcast { i8**, i64 }* %items to i8*
  %t1 = call i8* @sailfin_runtime_array_map(i8* %t0, i8* %mapper)
  %t2 = bitcast i8* %t1 to { i8**, i64 }*
  ret { i8**, i64 }* %t2
}

define { i8**, i64 }* @array_filter({ i8**, i64 }* %items, i8* %predicate) {
block.entry:
  %t0 = bitcast { i8**, i64 }* %items to i8*
  %t1 = call i8* @sailfin_runtime_array_filter(i8* %t0, i8* %predicate)
  %t2 = bitcast i8* %t1 to { i8**, i64 }*
  ret { i8**, i64 }* %t2
}

define i8* @array_reduce({ i8**, i64 }* %items, i8* %initial, i8* %reducer) {
block.entry:
  %t0 = bitcast { i8**, i64 }* %items to i8*
  %t1 = call i8* @sailfin_runtime_array_reduce(i8* %t0, i8* %initial, i8* %reducer)
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  ret i8* %t1
}

define private i8* @char_at(i8* %value, double %index) {
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s2)
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  %t4 = fcmp olt double %index, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s5)
  ret i8* %s5
merge3:
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %index, %t7
  br i1 %t8, label %then4, label %merge5
then4:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s9)
  ret i8* %s9
merge5:
  %t10 = call double @llvm.round.f64(double %index)
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  %t14 = add i64 0, 2
  %t15 = call i8* @malloc(i64 %t14)
  store i8 %t13, i8* %t15
  %t16 = getelementptr i8, i8* %t15, i64 1
  store i8 0, i8* %t16
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
}

define %EnumType @enum_type(i8* %name) {
block.entry:
  %t0 = insertvalue %EnumType undef, i8* %name, 0
  %t1 = getelementptr [0 x %EnumVariantDefinition], [0 x %EnumVariantDefinition]* null, i32 1
  %t2 = ptrtoint [0 x %EnumVariantDefinition]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %EnumVariantDefinition*
  %t7 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* null, i32 1
  %t8 = ptrtoint { %EnumVariantDefinition*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %EnumVariantDefinition*, i64 }*
  %t11 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t10, i32 0, i32 0
  store %EnumVariantDefinition* %t6, %EnumVariantDefinition** %t11
  %t12 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %EnumType %t0, { %EnumVariantDefinition*, i64 }* %t10, 1
  ret %EnumType %t13
}

define %EnumField @enum_field(i8* %name, i8* %value) {
block.entry:
  %t0 = insertvalue %EnumField undef, i8* %name, 0
  %t1 = insertvalue %EnumField %t0, i8* %value, 1
  ret %EnumField %t1
}

define %EnumType @enum_define_variant(%EnumType %enum_type, i8* %variant_name, { i8**, i64 }* %field_names) {
block.entry:
  %l0 = alloca %EnumVariantDefinition
  %l1 = alloca { %EnumVariantDefinition*, i64 }*
  %t0 = insertvalue %EnumVariantDefinition undef, i8* %variant_name, 0
  %t1 = insertvalue %EnumVariantDefinition %t0, { i8**, i64 }* %field_names, 1
  store %EnumVariantDefinition %t1, %EnumVariantDefinition* %l0
  %t2 = extractvalue %EnumType %enum_type, 1
  %t3 = load %EnumVariantDefinition, %EnumVariantDefinition* %l0
  %t4 = getelementptr [1 x %EnumVariantDefinition], [1 x %EnumVariantDefinition]* null, i32 1
  %t5 = ptrtoint [1 x %EnumVariantDefinition]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to %EnumVariantDefinition*
  %t10 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %t9, i64 0
  store %EnumVariantDefinition %t3, %EnumVariantDefinition* %t10
  %t11 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* null, i32 1
  %t12 = ptrtoint { %EnumVariantDefinition*, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { %EnumVariantDefinition*, i64 }*
  %t15 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t14, i32 0, i32 0
  store %EnumVariantDefinition* %t9, %EnumVariantDefinition** %t15
  %t16 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t14, i32 0, i32 1
  store i64 1, i64* %t16
  %t17 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t2, i32 0, i32 0
  %t18 = load %EnumVariantDefinition*, %EnumVariantDefinition** %t17
  %t19 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t2, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t14, i32 0, i32 0
  %t22 = load %EnumVariantDefinition*, %EnumVariantDefinition** %t21
  %t23 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t14, i32 0, i32 1
  %t24 = load i64, i64* %t23
  %t25 = getelementptr [1 x %EnumVariantDefinition], [1 x %EnumVariantDefinition]* null, i32 0, i32 1
  %t26 = ptrtoint %EnumVariantDefinition* %t25 to i64
  %t27 = add i64 %t20, %t24
  %t28 = mul i64 %t26, %t27
  %t29 = call noalias i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to %EnumVariantDefinition*
  %t31 = bitcast %EnumVariantDefinition* %t30 to i8*
  %t32 = mul i64 %t26, %t20
  %t33 = bitcast %EnumVariantDefinition* %t18 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t31, i8* %t33, i64 %t32)
  %t34 = mul i64 %t26, %t24
  %t35 = bitcast %EnumVariantDefinition* %t22 to i8*
  %t36 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %t30, i64 %t20
  %t37 = bitcast %EnumVariantDefinition* %t36 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t37, i8* %t35, i64 %t34)
  %t38 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* null, i32 1
  %t39 = ptrtoint { %EnumVariantDefinition*, i64 }* %t38 to i64
  %t40 = call i8* @malloc(i64 %t39)
  %t41 = bitcast i8* %t40 to { %EnumVariantDefinition*, i64 }*
  %t42 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t41, i32 0, i32 0
  store %EnumVariantDefinition* %t30, %EnumVariantDefinition** %t42
  %t43 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t41, i32 0, i32 1
  store i64 %t27, i64* %t43
  store { %EnumVariantDefinition*, i64 }* %t41, { %EnumVariantDefinition*, i64 }** %l1
  %t44 = extractvalue %EnumType %enum_type, 0
  %t45 = insertvalue %EnumType undef, i8* %t44, 0
  %t46 = load { %EnumVariantDefinition*, i64 }*, { %EnumVariantDefinition*, i64 }** %l1
  %t47 = insertvalue %EnumType %t45, { %EnumVariantDefinition*, i64 }* %t46, 1
  ret %EnumType %t47
}

define %EnumField* @enum_lookup_field({ %EnumField*, i64 }* %fields, i8* %name) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca %EnumField
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi i64 [ %t0, %block.entry ], [ %t22, %loop.latch2 ]
  store i64 %t23, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load { %EnumField*, i64 }, { %EnumField*, i64 }* %fields
  %t3 = extractvalue { %EnumField*, i64 } %t2, 1
  %t4 = icmp sge i64 %t1, %t3
  %t5 = load i64, i64* %l0
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load i64, i64* %l0
  %t7 = load { %EnumField*, i64 }, { %EnumField*, i64 }* %fields
  %t8 = extractvalue { %EnumField*, i64 } %t7, 0
  %t9 = extractvalue { %EnumField*, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t6, i64 %t9)
  %t11 = getelementptr %EnumField, %EnumField* %t8, i64 %t6
  %t12 = load %EnumField, %EnumField* %t11
  store %EnumField %t12, %EnumField* %l1
  %t13 = load %EnumField, %EnumField* %l1
  %t14 = extractvalue %EnumField %t13, 0
  %t15 = call i1 @strings_equal(i8* %t14, i8* %name)
  %t16 = load i64, i64* %l0
  %t17 = load %EnumField, %EnumField* %l1
  br i1 %t15, label %then6, label %merge7
then6:
  %t18 = load %EnumField, %EnumField* %l1
  %t19 = alloca %EnumField
  store %EnumField %t18, %EnumField* %t19
  ret %EnumField* %t19
merge7:
  %t20 = load i64, i64* %l0
  %t21 = add i64 %t20, 1
  store i64 %t21, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t24 = load i64, i64* %l0
  %t25 = bitcast i8* null to %EnumField*
  ret %EnumField* %t25
}

define %EnumVariantDefinition* @enum_find_variant(%EnumType %enum_type, i8* %variant_name) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca %EnumVariantDefinition
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi i64 [ %t0, %block.entry ], [ %t24, %loop.latch2 ]
  store i64 %t25, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = extractvalue %EnumType %enum_type, 1
  %t3 = load { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t2
  %t4 = extractvalue { %EnumVariantDefinition*, i64 } %t3, 1
  %t5 = icmp sge i64 %t1, %t4
  %t6 = load i64, i64* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = extractvalue %EnumType %enum_type, 1
  %t8 = load i64, i64* %l0
  %t9 = load { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t7
  %t10 = extractvalue { %EnumVariantDefinition*, i64 } %t9, 0
  %t11 = extractvalue { %EnumVariantDefinition*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t8, i64 %t11)
  %t13 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %t10, i64 %t8
  %t14 = load %EnumVariantDefinition, %EnumVariantDefinition* %t13
  store %EnumVariantDefinition %t14, %EnumVariantDefinition* %l1
  %t15 = load %EnumVariantDefinition, %EnumVariantDefinition* %l1
  %t16 = extractvalue %EnumVariantDefinition %t15, 0
  %t17 = call i1 @strings_equal(i8* %t16, i8* %variant_name)
  %t18 = load i64, i64* %l0
  %t19 = load %EnumVariantDefinition, %EnumVariantDefinition* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  %t20 = load %EnumVariantDefinition, %EnumVariantDefinition* %l1
  %t21 = alloca %EnumVariantDefinition
  store %EnumVariantDefinition %t20, %EnumVariantDefinition* %t21
  ret %EnumVariantDefinition* %t21
merge7:
  %t22 = load i64, i64* %l0
  %t23 = add i64 %t22, 1
  store i64 %t23, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t24 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t26 = load i64, i64* %l0
  %t27 = bitcast i8* null to %EnumVariantDefinition*
  ret %EnumVariantDefinition* %t27
}

define { %EnumField*, i64 }* @enum_normalize_fields(%EnumVariantDefinition* %definition, { %EnumField*, i64 }* %provided) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %EnumField*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %EnumField*
  %l5 = alloca i8*
  %t0 = icmp eq %EnumVariantDefinition* %definition, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret { %EnumField*, i64 }* %provided
merge1:
  %t1 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %definition, i32 0, i32 1
  %t2 = load { i8**, i64 }*, { i8**, i64 }** %t1
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %t3
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = icmp eq i64 %t5, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  %t8 = getelementptr [0 x %EnumField], [0 x %EnumField]* null, i32 1
  %t9 = ptrtoint [0 x %EnumField]* %t8 to i64
  %t10 = icmp eq i64 %t9, 0
  %t11 = select i1 %t10, i64 1, i64 %t9
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to %EnumField*
  %t14 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* null, i32 1
  %t15 = ptrtoint { %EnumField*, i64 }* %t14 to i64
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to { %EnumField*, i64 }*
  %t18 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t17, i32 0, i32 0
  store %EnumField* %t13, %EnumField** %t18
  %t19 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  ret { %EnumField*, i64 }* %t17
merge3:
  %t20 = getelementptr [0 x %EnumField], [0 x %EnumField]* null, i32 1
  %t21 = ptrtoint [0 x %EnumField]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to %EnumField*
  %t26 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* null, i32 1
  %t27 = ptrtoint { %EnumField*, i64 }* %t26 to i64
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to { %EnumField*, i64 }*
  %t30 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t29, i32 0, i32 0
  store %EnumField* %t25, %EnumField** %t30
  %t31 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { %EnumField*, i64 }* %t29, { %EnumField*, i64 }** %l1
  store i64 0, i64* %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t34 = load i64, i64* %l2
  br label %loop.header4
loop.header4:
  %t115 = phi { %EnumField*, i64 }* [ %t33, %merge3 ], [ %t113, %loop.latch6 ]
  %t116 = phi i64 [ %t34, %merge3 ], [ %t114, %loop.latch6 ]
  store { %EnumField*, i64 }* %t115, { %EnumField*, i64 }** %l1
  store i64 %t116, i64* %l2
  br label %loop.body5
loop.body5:
  %t35 = load i64, i64* %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = icmp sge i64 %t35, %t38
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t42 = load i64, i64* %l2
  br i1 %t39, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i64, i64* %l2
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr i8*, i8** %t46, i64 %t44
  %t50 = load i8*, i8** %t49
  store i8* %t50, i8** %l3
  %t51 = load i8*, i8** %l3
  %t52 = call %EnumField* @enum_lookup_field({ %EnumField*, i64 }* %provided, i8* %t51)
  store %EnumField* %t52, %EnumField** %l4
  store i8* null, i8** %l5
  %t53 = load %EnumField*, %EnumField** %l4
  %t54 = icmp ne %EnumField* %t53, null
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t57 = load i64, i64* %l2
  %t58 = load i8*, i8** %l3
  %t59 = load %EnumField*, %EnumField** %l4
  %t60 = load i8*, i8** %l5
  br i1 %t54, label %then10, label %merge11
then10:
  %t61 = load %EnumField*, %EnumField** %l4
  %t62 = getelementptr %EnumField, %EnumField* %t61, i32 0, i32 1
  %t63 = load i8*, i8** %t62
  store i8* %t63, i8** %l5
  %t64 = load i8*, i8** %l5
  br label %merge11
merge11:
  %t65 = phi i8* [ %t64, %then10 ], [ %t60, %merge9 ]
  store i8* %t65, i8** %l5
  %t66 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t67 = load i8*, i8** %l3
  %t68 = insertvalue %EnumField undef, i8* %t67, 0
  %t69 = load i8*, i8** %l5
  %t70 = insertvalue %EnumField %t68, i8* %t69, 1
  %t71 = getelementptr [1 x %EnumField], [1 x %EnumField]* null, i32 1
  %t72 = ptrtoint [1 x %EnumField]* %t71 to i64
  %t73 = icmp eq i64 %t72, 0
  %t74 = select i1 %t73, i64 1, i64 %t72
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to %EnumField*
  %t77 = getelementptr %EnumField, %EnumField* %t76, i64 0
  store %EnumField %t70, %EnumField* %t77
  %t78 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* null, i32 1
  %t79 = ptrtoint { %EnumField*, i64 }* %t78 to i64
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to { %EnumField*, i64 }*
  %t82 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t81, i32 0, i32 0
  store %EnumField* %t76, %EnumField** %t82
  %t83 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t66, i32 0, i32 0
  %t85 = load %EnumField*, %EnumField** %t84
  %t86 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t66, i32 0, i32 1
  %t87 = load i64, i64* %t86
  %t88 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t81, i32 0, i32 0
  %t89 = load %EnumField*, %EnumField** %t88
  %t90 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t81, i32 0, i32 1
  %t91 = load i64, i64* %t90
  %t92 = getelementptr [1 x %EnumField], [1 x %EnumField]* null, i32 0, i32 1
  %t93 = ptrtoint %EnumField* %t92 to i64
  %t94 = add i64 %t87, %t91
  %t95 = mul i64 %t93, %t94
  %t96 = call noalias i8* @malloc(i64 %t95)
  %t97 = bitcast i8* %t96 to %EnumField*
  %t98 = bitcast %EnumField* %t97 to i8*
  %t99 = mul i64 %t93, %t87
  %t100 = bitcast %EnumField* %t85 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t98, i8* %t100, i64 %t99)
  %t101 = mul i64 %t93, %t91
  %t102 = bitcast %EnumField* %t89 to i8*
  %t103 = getelementptr %EnumField, %EnumField* %t97, i64 %t87
  %t104 = bitcast %EnumField* %t103 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t104, i8* %t102, i64 %t101)
  %t105 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* null, i32 1
  %t106 = ptrtoint { %EnumField*, i64 }* %t105 to i64
  %t107 = call i8* @malloc(i64 %t106)
  %t108 = bitcast i8* %t107 to { %EnumField*, i64 }*
  %t109 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t108, i32 0, i32 0
  store %EnumField* %t97, %EnumField** %t109
  %t110 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t108, i32 0, i32 1
  store i64 %t94, i64* %t110
  store { %EnumField*, i64 }* %t108, { %EnumField*, i64 }** %l1
  %t111 = load i64, i64* %l2
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l2
  br label %loop.latch6
loop.latch6:
  %t113 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t114 = load i64, i64* %l2
  br label %loop.header4
afterloop7:
  %t117 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t118 = load i64, i64* %l2
  %t119 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  ret { %EnumField*, i64 }* %t119
}

define %EnumInstance @enum_instantiate(%EnumType %enum_type, i8* %variant_name, { %EnumField*, i64 }* %provided) {
block.entry:
  %l0 = alloca %EnumVariantDefinition*
  %l1 = alloca { %EnumField*, i64 }*
  %t0 = call %EnumVariantDefinition* @enum_find_variant(%EnumType %enum_type, i8* %variant_name)
  store %EnumVariantDefinition* %t0, %EnumVariantDefinition** %l0
  %t1 = load %EnumVariantDefinition*, %EnumVariantDefinition** %l0
  %t2 = call { %EnumField*, i64 }* @enum_normalize_fields(%EnumVariantDefinition* %t1, { %EnumField*, i64 }* %provided)
  store { %EnumField*, i64 }* %t2, { %EnumField*, i64 }** %l1
  %t3 = insertvalue %EnumInstance undef, %EnumType %enum_type, 0
  %t4 = insertvalue %EnumInstance %t3, i8* %variant_name, 1
  %t5 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t6 = insertvalue %EnumInstance %t4, { %EnumField*, i64 }* %t5, 2
  ret %EnumInstance %t6
}

define i8* @enum_get_field(%EnumInstance %instance, i8* %name) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca %EnumField
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi i64 [ %t0, %block.entry ], [ %t24, %loop.latch2 ]
  store i64 %t25, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = extractvalue %EnumInstance %instance, 2
  %t3 = load { %EnumField*, i64 }, { %EnumField*, i64 }* %t2
  %t4 = extractvalue { %EnumField*, i64 } %t3, 1
  %t5 = icmp sge i64 %t1, %t4
  %t6 = load i64, i64* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = extractvalue %EnumInstance %instance, 2
  %t8 = load i64, i64* %l0
  %t9 = load { %EnumField*, i64 }, { %EnumField*, i64 }* %t7
  %t10 = extractvalue { %EnumField*, i64 } %t9, 0
  %t11 = extractvalue { %EnumField*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t8, i64 %t11)
  %t13 = getelementptr %EnumField, %EnumField* %t10, i64 %t8
  %t14 = load %EnumField, %EnumField* %t13
  store %EnumField %t14, %EnumField* %l1
  %t15 = load %EnumField, %EnumField* %l1
  %t16 = extractvalue %EnumField %t15, 0
  %t17 = call i1 @strings_equal(i8* %t16, i8* %name)
  %t18 = load i64, i64* %l0
  %t19 = load %EnumField, %EnumField* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  %t20 = load %EnumField, %EnumField* %l1
  %t21 = extractvalue %EnumField %t20, 1
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  ret i8* %t21
merge7:
  %t22 = load i64, i64* %l0
  %t23 = add i64 %t22, 1
  store i64 %t23, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t24 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t26 = load i64, i64* %l0
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
}

define %StructField @struct_field(i8* %name, i8* %value) {
block.entry:
  %t0 = insertvalue %StructField undef, i8* %name, 0
  %t1 = insertvalue %StructField %t0, i8* %value, 1
  ret %StructField %t1
}

define i8* @struct_repr(i8* %name, { %StructField*, i64 }* %fields) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca %StructField
  %l3 = alloca i8*
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 40, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %name, i8* %t1)
  store i8* %t3, i8** %l0
  store i64 0, i64* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi i8* [ %t4, %block.entry ], [ %t43, %loop.latch2 ]
  %t46 = phi i64 [ %t5, %block.entry ], [ %t44, %loop.latch2 ]
  store i8* %t45, i8** %l0
  store i64 %t46, i64* %l1
  br label %loop.body1
loop.body1:
  %t6 = load i64, i64* %l1
  %t7 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t8 = extractvalue { %StructField*, i64 } %t7, 1
  %t9 = icmp sge i64 %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load i64, i64* %l1
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t12 = load i64, i64* %l1
  %t13 = icmp sgt i64 %t12, 0
  %t14 = load i8*, i8** %l0
  %t15 = load i64, i64* %l1
  br i1 %t13, label %then6, label %merge7
then6:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t16, i8* %s17)
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  br label %merge7
merge7:
  %t20 = phi i8* [ %t19, %then6 ], [ %t14, %merge5 ]
  store i8* %t20, i8** %l0
  %t21 = load i64, i64* %l1
  %t22 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t23 = extractvalue { %StructField*, i64 } %t22, 0
  %t24 = extractvalue { %StructField*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t21, i64 %t24)
  %t26 = getelementptr %StructField, %StructField* %t23, i64 %t21
  %t27 = load %StructField, %StructField* %t26
  store %StructField %t27, %StructField* %l2
  %t28 = load %StructField, %StructField* %l2
  %t29 = extractvalue %StructField %t28, 1
  %t30 = call i8* @to_debug_string(i8* %t29)
  store i8* %t30, i8** %l3
  %t31 = load i8*, i8** %l0
  %t32 = load %StructField, %StructField* %l2
  %t33 = extractvalue %StructField %t32, 0
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %t33)
  %t35 = add i64 0, 2
  %t36 = call i8* @malloc(i64 %t35)
  store i8 61, i8* %t36
  %t37 = getelementptr i8, i8* %t36, i64 1
  store i8 0, i8* %t37
  call void @sailfin_runtime_mark_persistent(i8* %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t36)
  %t39 = load i8*, i8** %l3
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  store i8* %t40, i8** %l0
  %t41 = load i64, i64* %l1
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load i8*, i8** %l0
  %t44 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t47 = load i8*, i8** %l0
  %t48 = load i64, i64* %l1
  %t49 = load i8*, i8** %l0
  %t50 = add i64 0, 2
  %t51 = call i8* @malloc(i64 %t50)
  store i8 41, i8* %t51
  %t52 = getelementptr i8, i8* %t51, i64 1
  store i8 0, i8* %t52
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t51)
  store i8* %t53, i8** %l0
  %t54 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t54)
  ret i8* %t54
}

define i8* @to_debug_string(i8* %value) {
block.entry:
  %t0 = call i8* @sailfin_runtime_to_debug_string(i8* %value)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define i8* @format_interpolated({ i8**, i64 }* %parts, { i8**, i64 }* %values) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  store i64 0, i64* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi i8* [ %t1, %block.entry ], [ %t38, %loop.latch2 ]
  %t41 = phi i64 [ %t2, %block.entry ], [ %t39, %loop.latch2 ]
  store i8* %t40, i8** %l0
  store i64 %t41, i64* %l1
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = icmp sge i64 %t3, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load i64, i64* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load i64, i64* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t16)
  store i8* %t17, i8** %l0
  %t18 = load i64, i64* %l1
  %t19 = load { i8**, i64 }, { i8**, i64 }* %values
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = icmp slt i64 %t18, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load i64, i64* %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load i8*, i8** %l0
  %t25 = load i64, i64* %l1
  %t26 = load { i8**, i64 }, { i8**, i64 }* %values
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call i8* @to_debug_string(i8* %t31)
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t32)
  store i8* %t33, i8** %l0
  %t34 = load i8*, i8** %l0
  br label %merge7
merge7:
  %t35 = phi i8* [ %t34, %then6 ], [ %t22, %merge5 ]
  store i8* %t35, i8** %l0
  %t36 = load i64, i64* %l1
  %t37 = add i64 %t36, 1
  store i64 %t37, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load i8*, i8** %l0
  %t39 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t42 = load i8*, i8** %l0
  %t43 = load i64, i64* %l1
  %t44 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  ret i8* %t44
}

define %TypeDescriptor @type_descriptor(i8* %kind, i8* %name, { %TypeDescriptor*, i64 }* %items) {
block.entry:
  %t0 = insertvalue %TypeDescriptor undef, i8* %kind, 0
  %t1 = insertvalue %TypeDescriptor %t0, i8* %name, 1
  %t2 = insertvalue %TypeDescriptor %t1, { %TypeDescriptor*, i64 }* %items, 2
  ret %TypeDescriptor %t2
}

define %TypeDescriptor @type_descriptor_primitive(i8* %name) {
block.entry:
  %s0 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1770336441, i32 0, i32 0
  %t1 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* null, i32 1
  %t2 = ptrtoint [0 x %TypeDescriptor]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %TypeDescriptor*
  %t7 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t8 = ptrtoint { %TypeDescriptor*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %TypeDescriptor*, i64 }*
  %t11 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 0
  store %TypeDescriptor* %t6, %TypeDescriptor** %t11
  %t12 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* %t10)
  ret %TypeDescriptor %t13
}

define %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %descriptors) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h550282393, i32 0, i32 0
  %t1 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %descriptors)
  ret %TypeDescriptor %t1
}

define %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %descriptors) {
block.entry:
  %s0 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h22148892, i32 0, i32 0
  %t1 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %descriptors)
  ret %TypeDescriptor %t1
}

define %TypeDescriptor @type_descriptor_array(%TypeDescriptor %inner) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1920110414, i32 0, i32 0
  %t1 = getelementptr [1 x %TypeDescriptor], [1 x %TypeDescriptor]* null, i32 1
  %t2 = ptrtoint [1 x %TypeDescriptor]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %TypeDescriptor*
  %t7 = getelementptr %TypeDescriptor, %TypeDescriptor* %t6, i64 0
  store %TypeDescriptor %inner, %TypeDescriptor* %t7
  %t8 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t9 = ptrtoint { %TypeDescriptor*, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { %TypeDescriptor*, i64 }*
  %t12 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t11, i32 0, i32 0
  store %TypeDescriptor* %t6, %TypeDescriptor** %t12
  %t13 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t11, i32 0, i32 1
  store i64 1, i64* %t13
  %t14 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t11)
  ret %TypeDescriptor %t14
}

define %TypeDescriptor @type_descriptor_function() {
block.entry:
  %s0 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1603982015, i32 0, i32 0
  %t1 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* null, i32 1
  %t2 = ptrtoint [0 x %TypeDescriptor]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %TypeDescriptor*
  %t7 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t8 = ptrtoint { %TypeDescriptor*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %TypeDescriptor*, i64 }*
  %t11 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 0
  store %TypeDescriptor* %t6, %TypeDescriptor** %t11
  %t12 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t10)
  ret %TypeDescriptor %t13
}

define %TypeDescriptor @type_descriptor_named(i8* %name) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261050197, i32 0, i32 0
  %t1 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* null, i32 1
  %t2 = ptrtoint [0 x %TypeDescriptor]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %TypeDescriptor*
  %t7 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t8 = ptrtoint { %TypeDescriptor*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %TypeDescriptor*, i64 }*
  %t11 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 0
  store %TypeDescriptor* %t6, %TypeDescriptor** %t11
  %t12 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* %t10)
  ret %TypeDescriptor %t13
}

define %TypeDescriptor @type_descriptor_unknown() {
block.entry:
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h186837049, i32 0, i32 0
  %t1 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* null, i32 1
  %t2 = ptrtoint [0 x %TypeDescriptor]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %TypeDescriptor*
  %t7 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t8 = ptrtoint { %TypeDescriptor*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %TypeDescriptor*, i64 }*
  %t11 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 0
  store %TypeDescriptor* %t6, %TypeDescriptor** %t11
  %t12 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t10)
  ret %TypeDescriptor %t13
}

define i8* @descriptor_trim(i8* %value) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca i8*
  store i64 0, i64* %l0
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  store i64 %t0, i64* %l1
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi i64 [ %t1, %block.entry ], [ %t34, %loop.latch2 ]
  store i64 %t35, i64* %l0
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l0
  %t4 = load i64, i64* %l1
  %t5 = icmp sge i64 %t3, %t4
  %t6 = load i64, i64* %l0
  %t7 = load i64, i64* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load i64, i64* %l0
  %t9 = sitofp i64 %t8 to double
  %t10 = call i8* @char_at(i8* %value, double %t9)
  store i8* %t10, i8** %l2
  %t12 = load i8*, i8** %l2
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 32
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t16 = load i8*, i8** %l2
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 10
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t18, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 9
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 13
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t27 = phi i1 [ true, %logical_or_entry_15 ], [ %t26, %logical_or_right_end_15 ]
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t28 = phi i1 [ true, %logical_or_entry_11 ], [ %t27, %logical_or_right_end_11 ]
  %t29 = load i64, i64* %l0
  %t30 = load i64, i64* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load i64, i64* %l0
  %t33 = add i64 %t32, 1
  store i64 %t33, i64* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t34 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t36 = load i64, i64* %l0
  %t37 = load i64, i64* %l0
  %t38 = load i64, i64* %l1
  br label %loop.header8
loop.header8:
  %t72 = phi i64 [ %t38, %afterloop3 ], [ %t71, %loop.latch10 ]
  store i64 %t72, i64* %l1
  br label %loop.body9
loop.body9:
  %t39 = load i64, i64* %l1
  %t40 = load i64, i64* %l0
  %t41 = icmp sle i64 %t39, %t40
  %t42 = load i64, i64* %l0
  %t43 = load i64, i64* %l1
  br i1 %t41, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t44 = load i64, i64* %l1
  %t45 = sub i64 %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = call i8* @char_at(i8* %value, double %t46)
  store i8* %t47, i8** %l3
  %t49 = load i8*, i8** %l3
  %t50 = load i8, i8* %t49
  %t51 = icmp eq i8 %t50, 32
  br label %logical_or_entry_48

logical_or_entry_48:
  br i1 %t51, label %logical_or_merge_48, label %logical_or_right_48

logical_or_right_48:
  %t53 = load i8*, i8** %l3
  %t54 = load i8, i8* %t53
  %t55 = icmp eq i8 %t54, 10
  br label %logical_or_entry_52

logical_or_entry_52:
  br i1 %t55, label %logical_or_merge_52, label %logical_or_right_52

logical_or_right_52:
  %t57 = load i8*, i8** %l3
  %t58 = load i8, i8* %t57
  %t59 = icmp eq i8 %t58, 9
  br label %logical_or_entry_56

logical_or_entry_56:
  br i1 %t59, label %logical_or_merge_56, label %logical_or_right_56

logical_or_right_56:
  %t60 = load i8*, i8** %l3
  %t61 = load i8, i8* %t60
  %t62 = icmp eq i8 %t61, 13
  br label %logical_or_right_end_56

logical_or_right_end_56:
  br label %logical_or_merge_56

logical_or_merge_56:
  %t63 = phi i1 [ true, %logical_or_entry_56 ], [ %t62, %logical_or_right_end_56 ]
  br label %logical_or_right_end_52

logical_or_right_end_52:
  br label %logical_or_merge_52

logical_or_merge_52:
  %t64 = phi i1 [ true, %logical_or_entry_52 ], [ %t63, %logical_or_right_end_52 ]
  br label %logical_or_right_end_48

logical_or_right_end_48:
  br label %logical_or_merge_48

logical_or_merge_48:
  %t65 = phi i1 [ true, %logical_or_entry_48 ], [ %t64, %logical_or_right_end_48 ]
  %t66 = load i64, i64* %l0
  %t67 = load i64, i64* %l1
  %t68 = load i8*, i8** %l3
  br i1 %t65, label %then14, label %merge15
then14:
  %t69 = load i64, i64* %l1
  %t70 = sub i64 %t69, 1
  store i64 %t70, i64* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t71 = load i64, i64* %l1
  br label %loop.header8
afterloop11:
  %t73 = load i64, i64* %l1
  %t74 = load i64, i64* %l0
  %t75 = load i64, i64* %l1
  %t76 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t74, i64 %t75)
  call void @sailfin_runtime_mark_persistent(i8* %t76)
  ret i8* %t76
}

define i1 @string_starts_with(i8* %value, i8* %prefix) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i64 0, i64* %l0
  %t3 = load i64, i64* %l0
  br label %loop.header2
loop.header2:
  %t24 = phi i64 [ %t3, %merge1 ], [ %t23, %loop.latch4 ]
  store i64 %t24, i64* %l0
  br label %loop.body3
loop.body3:
  %t4 = load i64, i64* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t6 = icmp sge i64 %t4, %t5
  %t7 = load i64, i64* %l0
  br i1 %t6, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t8 = load i64, i64* %l0
  %t9 = sitofp i64 %t8 to double
  %t10 = call i8* @char_at(i8* %value, double %t9)
  store i8* %t10, i8** %l1
  %t11 = load i64, i64* %l0
  %t12 = sitofp i64 %t11 to double
  %t13 = call i8* @char_at(i8* %prefix, double %t12)
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l1
  %t15 = load i8*, i8** %l2
  %t16 = call i1 @strings_equal(i8* %t14, i8* %t15)
  %t17 = xor i1 %t16, true
  %t18 = load i64, i64* %l0
  %t19 = load i8*, i8** %l1
  %t20 = load i8*, i8** %l2
  br i1 %t17, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t21 = load i64, i64* %l0
  %t22 = add i64 %t21, 1
  store i64 %t22, i64* %l0
  br label %loop.latch4
loop.latch4:
  %t23 = load i64, i64* %l0
  br label %loop.header2
afterloop5:
  %t25 = load i64, i64* %l0
  ret i1 1
}

define i1 @string_ends_with(i8* %value, i8* %suffix) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t5 = sub i64 %t3, %t4
  store i64 %t5, i64* %l0
  store i64 0, i64* %l1
  %t6 = load i64, i64* %l0
  %t7 = load i64, i64* %l1
  br label %loop.header2
loop.header2:
  %t32 = phi i64 [ %t7, %merge1 ], [ %t31, %loop.latch4 ]
  store i64 %t32, i64* %l1
  br label %loop.body3
loop.body3:
  %t8 = load i64, i64* %l1
  %t9 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t10 = icmp sge i64 %t8, %t9
  %t11 = load i64, i64* %l0
  %t12 = load i64, i64* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load i64, i64* %l0
  %t14 = load i64, i64* %l1
  %t15 = add i64 %t13, %t14
  %t16 = sitofp i64 %t15 to double
  %t17 = call i8* @char_at(i8* %value, double %t16)
  store i8* %t17, i8** %l2
  %t18 = load i64, i64* %l1
  %t19 = sitofp i64 %t18 to double
  %t20 = call i8* @char_at(i8* %suffix, double %t19)
  store i8* %t20, i8** %l3
  %t21 = load i8*, i8** %l2
  %t22 = load i8*, i8** %l3
  %t23 = call i1 @strings_equal(i8* %t21, i8* %t22)
  %t24 = xor i1 %t23, true
  %t25 = load i64, i64* %l0
  %t26 = load i64, i64* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l3
  br i1 %t24, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t29 = load i64, i64* %l1
  %t30 = add i64 %t29, 1
  store i64 %t30, i64* %l1
  br label %loop.latch4
loop.latch4:
  %t31 = load i64, i64* %l1
  br label %loop.header2
afterloop5:
  %t33 = load i64, i64* %l1
  ret i1 1
}

define double @descriptor_find_top_level(i8* %value, i8* %needle) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i64
  %l3 = alloca i64
  %l4 = alloca i64
  %l5 = alloca i64
  %l6 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %needle)
  %t2 = icmp ne i64 %t1, 1
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 -1 to double
  ret double %t4
merge1:
  %t5 = sitofp i64 0 to double
  %t6 = call i8* @char_at(i8* %needle, double %t5)
  store i8* %t6, i8** %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load i64, i64* %l2
  %t10 = load i64, i64* %l3
  %t11 = load i64, i64* %l4
  %t12 = load i64, i64* %l5
  br label %loop.header2
loop.header2:
  %t195 = phi i64 [ %t10, %merge1 ], [ %t191, %loop.latch4 ]
  %t196 = phi i64 [ %t11, %merge1 ], [ %t192, %loop.latch4 ]
  %t197 = phi i64 [ %t12, %merge1 ], [ %t193, %loop.latch4 ]
  %t198 = phi i64 [ %t9, %merge1 ], [ %t194, %loop.latch4 ]
  store i64 %t195, i64* %l3
  store i64 %t196, i64* %l4
  store i64 %t197, i64* %l5
  store i64 %t198, i64* %l2
  br label %loop.body3
loop.body3:
  %t13 = load i64, i64* %l2
  %t14 = load i8*, i8** %l0
  %t15 = call i64 @sailfin_runtime_string_length(i8* %t14)
  %t16 = icmp sge i64 %t13, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i64, i64* %l2
  %t20 = load i64, i64* %l3
  %t21 = load i64, i64* %l4
  %t22 = load i64, i64* %l5
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t23 = load i8*, i8** %l0
  %t24 = load i64, i64* %l2
  %t25 = sitofp i64 %t24 to double
  %t26 = call i8* @char_at(i8* %t23, double %t25)
  store i8* %t26, i8** %l6
  %t27 = load i8*, i8** %l6
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 40
  %t30 = load i8*, i8** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i64, i64* %l2
  %t33 = load i64, i64* %l3
  %t34 = load i64, i64* %l4
  %t35 = load i64, i64* %l5
  %t36 = load i8*, i8** %l6
  br i1 %t29, label %then8, label %else9
then8:
  %t37 = load i64, i64* %l3
  %t38 = add i64 %t37, 1
  store i64 %t38, i64* %l3
  %t39 = load i64, i64* %l3
  br label %merge10
else9:
  %t40 = load i8*, i8** %l6
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 41
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load i64, i64* %l2
  %t46 = load i64, i64* %l3
  %t47 = load i64, i64* %l4
  %t48 = load i64, i64* %l5
  %t49 = load i8*, i8** %l6
  br i1 %t42, label %then11, label %else12
then11:
  %t50 = load i64, i64* %l3
  %t51 = icmp sgt i64 %t50, 0
  %t52 = load i8*, i8** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i64, i64* %l2
  %t55 = load i64, i64* %l3
  %t56 = load i64, i64* %l4
  %t57 = load i64, i64* %l5
  %t58 = load i8*, i8** %l6
  br i1 %t51, label %then14, label %merge15
then14:
  %t59 = load i64, i64* %l3
  %t60 = sub i64 %t59, 1
  store i64 %t60, i64* %l3
  %t61 = load i64, i64* %l3
  br label %merge15
merge15:
  %t62 = phi i64 [ %t61, %then14 ], [ %t55, %then11 ]
  store i64 %t62, i64* %l3
  %t63 = load i64, i64* %l3
  br label %merge13
else12:
  %t64 = load i8*, i8** %l6
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 60
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load i64, i64* %l2
  %t70 = load i64, i64* %l3
  %t71 = load i64, i64* %l4
  %t72 = load i64, i64* %l5
  %t73 = load i8*, i8** %l6
  br i1 %t66, label %then16, label %else17
then16:
  %t74 = load i64, i64* %l4
  %t75 = add i64 %t74, 1
  store i64 %t75, i64* %l4
  %t76 = load i64, i64* %l4
  br label %merge18
else17:
  %t77 = load i8*, i8** %l6
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 62
  %t80 = load i8*, i8** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load i64, i64* %l2
  %t83 = load i64, i64* %l3
  %t84 = load i64, i64* %l4
  %t85 = load i64, i64* %l5
  %t86 = load i8*, i8** %l6
  br i1 %t79, label %then19, label %else20
then19:
  %t87 = load i64, i64* %l4
  %t88 = icmp sgt i64 %t87, 0
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load i64, i64* %l2
  %t92 = load i64, i64* %l3
  %t93 = load i64, i64* %l4
  %t94 = load i64, i64* %l5
  %t95 = load i8*, i8** %l6
  br i1 %t88, label %then22, label %merge23
then22:
  %t96 = load i64, i64* %l4
  %t97 = sub i64 %t96, 1
  store i64 %t97, i64* %l4
  %t98 = load i64, i64* %l4
  br label %merge23
merge23:
  %t99 = phi i64 [ %t98, %then22 ], [ %t93, %then19 ]
  store i64 %t99, i64* %l4
  %t100 = load i64, i64* %l4
  br label %merge21
else20:
  %t101 = load i8*, i8** %l6
  %t102 = load i8, i8* %t101
  %t103 = icmp eq i8 %t102, 91
  %t104 = load i8*, i8** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load i64, i64* %l2
  %t107 = load i64, i64* %l3
  %t108 = load i64, i64* %l4
  %t109 = load i64, i64* %l5
  %t110 = load i8*, i8** %l6
  br i1 %t103, label %then24, label %else25
then24:
  %t111 = load i64, i64* %l5
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l5
  %t113 = load i64, i64* %l5
  br label %merge26
else25:
  %t114 = load i8*, i8** %l6
  %t115 = load i8, i8* %t114
  %t116 = icmp eq i8 %t115, 93
  %t117 = load i8*, i8** %l0
  %t118 = load i8*, i8** %l1
  %t119 = load i64, i64* %l2
  %t120 = load i64, i64* %l3
  %t121 = load i64, i64* %l4
  %t122 = load i64, i64* %l5
  %t123 = load i8*, i8** %l6
  br i1 %t116, label %then27, label %merge28
then27:
  %t124 = load i64, i64* %l5
  %t125 = icmp sgt i64 %t124, 0
  %t126 = load i8*, i8** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load i64, i64* %l2
  %t129 = load i64, i64* %l3
  %t130 = load i64, i64* %l4
  %t131 = load i64, i64* %l5
  %t132 = load i8*, i8** %l6
  br i1 %t125, label %then29, label %merge30
then29:
  %t133 = load i64, i64* %l5
  %t134 = sub i64 %t133, 1
  store i64 %t134, i64* %l5
  %t135 = load i64, i64* %l5
  br label %merge30
merge30:
  %t136 = phi i64 [ %t135, %then29 ], [ %t131, %then27 ]
  store i64 %t136, i64* %l5
  %t137 = load i64, i64* %l5
  br label %merge28
merge28:
  %t138 = phi i64 [ %t137, %merge30 ], [ %t122, %else25 ]
  store i64 %t138, i64* %l5
  %t139 = load i64, i64* %l5
  br label %merge26
merge26:
  %t140 = phi i64 [ %t113, %then24 ], [ %t139, %merge28 ]
  store i64 %t140, i64* %l5
  %t141 = load i64, i64* %l5
  %t142 = load i64, i64* %l5
  br label %merge21
merge21:
  %t143 = phi i64 [ %t100, %merge23 ], [ %t84, %merge26 ]
  %t144 = phi i64 [ %t85, %merge23 ], [ %t141, %merge26 ]
  store i64 %t143, i64* %l4
  store i64 %t144, i64* %l5
  %t145 = load i64, i64* %l4
  %t146 = load i64, i64* %l5
  %t147 = load i64, i64* %l5
  br label %merge18
merge18:
  %t148 = phi i64 [ %t76, %then16 ], [ %t145, %merge21 ]
  %t149 = phi i64 [ %t72, %then16 ], [ %t146, %merge21 ]
  store i64 %t148, i64* %l4
  store i64 %t149, i64* %l5
  %t150 = load i64, i64* %l4
  %t151 = load i64, i64* %l4
  %t152 = load i64, i64* %l5
  %t153 = load i64, i64* %l5
  br label %merge13
merge13:
  %t154 = phi i64 [ %t63, %merge15 ], [ %t46, %merge18 ]
  %t155 = phi i64 [ %t47, %merge15 ], [ %t150, %merge18 ]
  %t156 = phi i64 [ %t48, %merge15 ], [ %t152, %merge18 ]
  store i64 %t154, i64* %l3
  store i64 %t155, i64* %l4
  store i64 %t156, i64* %l5
  %t157 = load i64, i64* %l3
  %t158 = load i64, i64* %l4
  %t159 = load i64, i64* %l4
  %t160 = load i64, i64* %l5
  %t161 = load i64, i64* %l5
  br label %merge10
merge10:
  %t162 = phi i64 [ %t39, %then8 ], [ %t157, %merge13 ]
  %t163 = phi i64 [ %t34, %then8 ], [ %t158, %merge13 ]
  %t164 = phi i64 [ %t35, %then8 ], [ %t160, %merge13 ]
  store i64 %t162, i64* %l3
  store i64 %t163, i64* %l4
  store i64 %t164, i64* %l5
  %t166 = load i8*, i8** %l6
  %t167 = load i8*, i8** %l1
  %t168 = call i1 @strings_equal(i8* %t166, i8* %t167)
  br label %logical_and_entry_165

logical_and_entry_165:
  br i1 %t168, label %logical_and_right_165, label %logical_and_merge_165

logical_and_right_165:
  %t170 = load i64, i64* %l3
  %t171 = icmp eq i64 %t170, 0
  br label %logical_and_entry_169

logical_and_entry_169:
  br i1 %t171, label %logical_and_right_169, label %logical_and_merge_169

logical_and_right_169:
  %t173 = load i64, i64* %l4
  %t174 = icmp eq i64 %t173, 0
  br label %logical_and_entry_172

logical_and_entry_172:
  br i1 %t174, label %logical_and_right_172, label %logical_and_merge_172

logical_and_right_172:
  %t175 = load i64, i64* %l5
  %t176 = icmp eq i64 %t175, 0
  br label %logical_and_right_end_172

logical_and_right_end_172:
  br label %logical_and_merge_172

logical_and_merge_172:
  %t177 = phi i1 [ false, %logical_and_entry_172 ], [ %t176, %logical_and_right_end_172 ]
  br label %logical_and_right_end_169

logical_and_right_end_169:
  br label %logical_and_merge_169

logical_and_merge_169:
  %t178 = phi i1 [ false, %logical_and_entry_169 ], [ %t177, %logical_and_right_end_169 ]
  br label %logical_and_right_end_165

logical_and_right_end_165:
  br label %logical_and_merge_165

logical_and_merge_165:
  %t179 = phi i1 [ false, %logical_and_entry_165 ], [ %t178, %logical_and_right_end_165 ]
  %t180 = load i8*, i8** %l0
  %t181 = load i8*, i8** %l1
  %t182 = load i64, i64* %l2
  %t183 = load i64, i64* %l3
  %t184 = load i64, i64* %l4
  %t185 = load i64, i64* %l5
  %t186 = load i8*, i8** %l6
  br i1 %t179, label %then31, label %merge32
then31:
  %t187 = load i64, i64* %l2
  %t188 = sitofp i64 %t187 to double
  ret double %t188
merge32:
  %t189 = load i64, i64* %l2
  %t190 = add i64 %t189, 1
  store i64 %t190, i64* %l2
  br label %loop.latch4
loop.latch4:
  %t191 = load i64, i64* %l3
  %t192 = load i64, i64* %l4
  %t193 = load i64, i64* %l5
  %t194 = load i64, i64* %l2
  br label %loop.header2
afterloop5:
  %t199 = load i64, i64* %l3
  %t200 = load i64, i64* %l4
  %t201 = load i64, i64* %l5
  %t202 = load i64, i64* %l2
  %t203 = sitofp i64 -1 to double
  ret double %t203
}

define i8* @descriptor_strip_outer_parens(i8* %value) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i64
  %l3 = alloca i1
  %l4 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t122 = phi i8* [ %t1, %block.entry ], [ %t121, %loop.latch2 ]
  store i8* %t122, i8** %l0
  br label %loop.body1
loop.body1:
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp slt i64 %t3, 2
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then4, label %merge5
then4:
  %t6 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
merge5:
  %t7 = load i8*, i8** %l0
  %t8 = sitofp i64 0 to double
  %t9 = call i8* @char_at(i8* %t7, double %t8)
  %t10 = load i8, i8* %t9
  %t11 = icmp ne i8 %t10, 40
  %t12 = load i8*, i8** %l0
  br i1 %t11, label %then6, label %merge7
then6:
  %t13 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret i8* %t13
merge7:
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = sub i64 %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = call i8* @char_at(i8* %t14, double %t18)
  %t20 = load i8, i8* %t19
  %t21 = icmp ne i8 %t20, 41
  %t22 = load i8*, i8** %l0
  br i1 %t21, label %then8, label %merge9
then8:
  %t23 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  ret i8* %t23
merge9:
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t24 = load i8*, i8** %l0
  %t25 = load i64, i64* %l1
  %t26 = load i64, i64* %l2
  %t27 = load i1, i1* %l3
  br label %loop.header10
loop.header10:
  %t98 = phi i64 [ %t25, %merge9 ], [ %t95, %loop.latch12 ]
  %t99 = phi i1 [ %t27, %merge9 ], [ %t96, %loop.latch12 ]
  %t100 = phi i64 [ %t26, %merge9 ], [ %t97, %loop.latch12 ]
  store i64 %t98, i64* %l1
  store i1 %t99, i1* %l3
  store i64 %t100, i64* %l2
  br label %loop.body11
loop.body11:
  %t28 = load i64, i64* %l2
  %t29 = load i8*, i8** %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = icmp sge i64 %t28, %t30
  %t32 = load i8*, i8** %l0
  %t33 = load i64, i64* %l1
  %t34 = load i64, i64* %l2
  %t35 = load i1, i1* %l3
  br i1 %t31, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t36 = load i8*, i8** %l0
  %t37 = load i64, i64* %l2
  %t38 = sitofp i64 %t37 to double
  %t39 = call i8* @char_at(i8* %t36, double %t38)
  store i8* %t39, i8** %l4
  %t40 = load i8*, i8** %l4
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 40
  %t43 = load i8*, i8** %l0
  %t44 = load i64, i64* %l1
  %t45 = load i64, i64* %l2
  %t46 = load i1, i1* %l3
  %t47 = load i8*, i8** %l4
  br i1 %t42, label %then16, label %else17
then16:
  %t48 = load i64, i64* %l1
  %t49 = add i64 %t48, 1
  store i64 %t49, i64* %l1
  %t50 = load i64, i64* %l1
  br label %merge18
else17:
  %t51 = load i8*, i8** %l4
  %t52 = load i8, i8* %t51
  %t53 = icmp eq i8 %t52, 41
  %t54 = load i8*, i8** %l0
  %t55 = load i64, i64* %l1
  %t56 = load i64, i64* %l2
  %t57 = load i1, i1* %l3
  %t58 = load i8*, i8** %l4
  br i1 %t53, label %then19, label %merge20
then19:
  %t59 = load i64, i64* %l1
  %t60 = sub i64 %t59, 1
  store i64 %t60, i64* %l1
  %t61 = load i64, i64* %l1
  %t62 = icmp slt i64 %t61, 0
  %t63 = load i8*, i8** %l0
  %t64 = load i64, i64* %l1
  %t65 = load i64, i64* %l2
  %t66 = load i1, i1* %l3
  %t67 = load i8*, i8** %l4
  br i1 %t62, label %then21, label %merge22
then21:
  store i1 0, i1* %l3
  br label %afterloop13
merge22:
  %t69 = load i64, i64* %l1
  %t70 = icmp eq i64 %t69, 0
  br label %logical_and_entry_68

logical_and_entry_68:
  br i1 %t70, label %logical_and_right_68, label %logical_and_merge_68

logical_and_right_68:
  %t71 = load i64, i64* %l2
  %t72 = load i8*, i8** %l0
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = sub i64 %t73, 1
  %t75 = icmp slt i64 %t71, %t74
  br label %logical_and_right_end_68

logical_and_right_end_68:
  br label %logical_and_merge_68

logical_and_merge_68:
  %t76 = phi i1 [ false, %logical_and_entry_68 ], [ %t75, %logical_and_right_end_68 ]
  %t77 = load i8*, i8** %l0
  %t78 = load i64, i64* %l1
  %t79 = load i64, i64* %l2
  %t80 = load i1, i1* %l3
  %t81 = load i8*, i8** %l4
  br i1 %t76, label %then23, label %merge24
then23:
  store i1 0, i1* %l3
  br label %afterloop13
merge24:
  %t82 = load i64, i64* %l1
  %t83 = load i1, i1* %l3
  %t84 = load i1, i1* %l3
  br label %merge20
merge20:
  %t85 = phi i64 [ %t82, %merge24 ], [ %t55, %else17 ]
  %t86 = phi i1 [ %t83, %merge24 ], [ %t57, %else17 ]
  %t87 = phi i1 [ %t84, %merge24 ], [ %t57, %else17 ]
  store i64 %t85, i64* %l1
  store i1 %t86, i1* %l3
  store i1 %t87, i1* %l3
  %t88 = load i64, i64* %l1
  %t89 = load i1, i1* %l3
  %t90 = load i1, i1* %l3
  br label %merge18
merge18:
  %t91 = phi i64 [ %t50, %then16 ], [ %t88, %merge20 ]
  %t92 = phi i1 [ %t46, %then16 ], [ %t89, %merge20 ]
  store i64 %t91, i64* %l1
  store i1 %t92, i1* %l3
  %t93 = load i64, i64* %l2
  %t94 = add i64 %t93, 1
  store i64 %t94, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t95 = load i64, i64* %l1
  %t96 = load i1, i1* %l3
  %t97 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t101 = load i64, i64* %l1
  %t102 = load i1, i1* %l3
  %t103 = load i64, i64* %l2
  %t105 = load i1, i1* %l3
  br label %logical_or_entry_104

logical_or_entry_104:
  br i1 %t105, label %logical_or_merge_104, label %logical_or_right_104

logical_or_right_104:
  %t106 = load i64, i64* %l1
  %t107 = icmp ne i64 %t106, 0
  br label %logical_or_right_end_104

logical_or_right_end_104:
  br label %logical_or_merge_104

logical_or_merge_104:
  %t108 = phi i1 [ true, %logical_or_entry_104 ], [ %t107, %logical_or_right_end_104 ]
  %t109 = xor i1 %t108, 1
  %t110 = load i8*, i8** %l0
  %t111 = load i64, i64* %l1
  %t112 = load i64, i64* %l2
  %t113 = load i1, i1* %l3
  br i1 %t109, label %then25, label %merge26
then25:
  %t114 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t114)
  ret i8* %t114
merge26:
  %t115 = load i8*, i8** %l0
  %t116 = load i8*, i8** %l0
  %t117 = call i64 @sailfin_runtime_string_length(i8* %t116)
  %t118 = sub i64 %t117, 1
  %t119 = call i8* @sailfin_runtime_substring(i8* %t115, i64 1, i64 %t118)
  %t120 = call i8* @descriptor_trim(i8* %t119)
  store i8* %t120, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t121 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t123 = load i8*, i8** %l0
  %t124 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t124)
  ret i8* %t124
}

define { i8**, i64 }* @split_descriptor(i8* %value, i8* %separator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i64
  %l3 = alloca i64
  %l4 = alloca i64
  %l5 = alloca i64
  %l6 = alloca i64
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %separator)
  %t2 = icmp ne i64 %t1, 1
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = load i8*, i8** %l0
  %t5 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t6 = ptrtoint [1 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr i8*, i8** %t10, i64 0
  store i8* %t4, i8** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t13 = ptrtoint { i8**, i64 }* %t12 to i64
  %t14 = call i8* @malloc(i64 %t13)
  %t15 = bitcast i8* %t14 to { i8**, i64 }*
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 0
  store i8** %t10, i8*** %t16
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 1
  store i64 1, i64* %t17
  ret { i8**, i64 }* %t15
merge1:
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
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  store i64 0, i64* %l6
  %t30 = sitofp i64 0 to double
  %t31 = call i8* @char_at(i8* %separator, double %t30)
  store i8* %t31, i8** %l7
  %t32 = load i8*, i8** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load i64, i64* %l2
  %t35 = load i64, i64* %l3
  %t36 = load i64, i64* %l4
  %t37 = load i64, i64* %l5
  %t38 = load i64, i64* %l6
  %t39 = load i8*, i8** %l7
  br label %loop.header2
loop.header2:
  %t271 = phi i64 [ %t36, %merge1 ], [ %t265, %loop.latch4 ]
  %t272 = phi i64 [ %t37, %merge1 ], [ %t266, %loop.latch4 ]
  %t273 = phi i64 [ %t38, %merge1 ], [ %t267, %loop.latch4 ]
  %t274 = phi { i8**, i64 }* [ %t33, %merge1 ], [ %t268, %loop.latch4 ]
  %t275 = phi i64 [ %t34, %merge1 ], [ %t269, %loop.latch4 ]
  %t276 = phi i64 [ %t35, %merge1 ], [ %t270, %loop.latch4 ]
  store i64 %t271, i64* %l4
  store i64 %t272, i64* %l5
  store i64 %t273, i64* %l6
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  store i64 %t275, i64* %l2
  store i64 %t276, i64* %l3
  br label %loop.body3
loop.body3:
  %t40 = load i64, i64* %l3
  %t41 = load i8*, i8** %l0
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = icmp sge i64 %t40, %t42
  %t44 = load i8*, i8** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load i64, i64* %l2
  %t47 = load i64, i64* %l3
  %t48 = load i64, i64* %l4
  %t49 = load i64, i64* %l5
  %t50 = load i64, i64* %l6
  %t51 = load i8*, i8** %l7
  br i1 %t43, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t52 = load i8*, i8** %l0
  %t53 = load i64, i64* %l3
  %t54 = sitofp i64 %t53 to double
  %t55 = call i8* @char_at(i8* %t52, double %t54)
  store i8* %t55, i8** %l8
  %t56 = load i8*, i8** %l8
  %t57 = load i8, i8* %t56
  %t58 = icmp eq i8 %t57, 40
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load i64, i64* %l2
  %t62 = load i64, i64* %l3
  %t63 = load i64, i64* %l4
  %t64 = load i64, i64* %l5
  %t65 = load i64, i64* %l6
  %t66 = load i8*, i8** %l7
  %t67 = load i8*, i8** %l8
  br i1 %t58, label %then8, label %else9
then8:
  %t68 = load i64, i64* %l4
  %t69 = add i64 %t68, 1
  store i64 %t69, i64* %l4
  %t70 = load i64, i64* %l4
  br label %merge10
else9:
  %t71 = load i8*, i8** %l8
  %t72 = load i8, i8* %t71
  %t73 = icmp eq i8 %t72, 41
  %t74 = load i8*, i8** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load i64, i64* %l2
  %t77 = load i64, i64* %l3
  %t78 = load i64, i64* %l4
  %t79 = load i64, i64* %l5
  %t80 = load i64, i64* %l6
  %t81 = load i8*, i8** %l7
  %t82 = load i8*, i8** %l8
  br i1 %t73, label %then11, label %else12
then11:
  %t83 = load i64, i64* %l4
  %t84 = icmp sgt i64 %t83, 0
  %t85 = load i8*, i8** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load i64, i64* %l2
  %t88 = load i64, i64* %l3
  %t89 = load i64, i64* %l4
  %t90 = load i64, i64* %l5
  %t91 = load i64, i64* %l6
  %t92 = load i8*, i8** %l7
  %t93 = load i8*, i8** %l8
  br i1 %t84, label %then14, label %merge15
then14:
  %t94 = load i64, i64* %l4
  %t95 = sub i64 %t94, 1
  store i64 %t95, i64* %l4
  %t96 = load i64, i64* %l4
  br label %merge15
merge15:
  %t97 = phi i64 [ %t96, %then14 ], [ %t89, %then11 ]
  store i64 %t97, i64* %l4
  %t98 = load i64, i64* %l4
  br label %merge13
else12:
  %t99 = load i8*, i8** %l8
  %t100 = load i8, i8* %t99
  %t101 = icmp eq i8 %t100, 60
  %t102 = load i8*, i8** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load i64, i64* %l2
  %t105 = load i64, i64* %l3
  %t106 = load i64, i64* %l4
  %t107 = load i64, i64* %l5
  %t108 = load i64, i64* %l6
  %t109 = load i8*, i8** %l7
  %t110 = load i8*, i8** %l8
  br i1 %t101, label %then16, label %else17
then16:
  %t111 = load i64, i64* %l5
  %t112 = add i64 %t111, 1
  store i64 %t112, i64* %l5
  %t113 = load i64, i64* %l5
  br label %merge18
else17:
  %t114 = load i8*, i8** %l8
  %t115 = load i8, i8* %t114
  %t116 = icmp eq i8 %t115, 62
  %t117 = load i8*, i8** %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load i64, i64* %l2
  %t120 = load i64, i64* %l3
  %t121 = load i64, i64* %l4
  %t122 = load i64, i64* %l5
  %t123 = load i64, i64* %l6
  %t124 = load i8*, i8** %l7
  %t125 = load i8*, i8** %l8
  br i1 %t116, label %then19, label %else20
then19:
  %t126 = load i64, i64* %l5
  %t127 = icmp sgt i64 %t126, 0
  %t128 = load i8*, i8** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load i64, i64* %l2
  %t131 = load i64, i64* %l3
  %t132 = load i64, i64* %l4
  %t133 = load i64, i64* %l5
  %t134 = load i64, i64* %l6
  %t135 = load i8*, i8** %l7
  %t136 = load i8*, i8** %l8
  br i1 %t127, label %then22, label %merge23
then22:
  %t137 = load i64, i64* %l5
  %t138 = sub i64 %t137, 1
  store i64 %t138, i64* %l5
  %t139 = load i64, i64* %l5
  br label %merge23
merge23:
  %t140 = phi i64 [ %t139, %then22 ], [ %t133, %then19 ]
  store i64 %t140, i64* %l5
  %t141 = load i64, i64* %l5
  br label %merge21
else20:
  %t142 = load i8*, i8** %l8
  %t143 = load i8, i8* %t142
  %t144 = icmp eq i8 %t143, 91
  %t145 = load i8*, i8** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load i64, i64* %l2
  %t148 = load i64, i64* %l3
  %t149 = load i64, i64* %l4
  %t150 = load i64, i64* %l5
  %t151 = load i64, i64* %l6
  %t152 = load i8*, i8** %l7
  %t153 = load i8*, i8** %l8
  br i1 %t144, label %then24, label %else25
then24:
  %t154 = load i64, i64* %l6
  %t155 = add i64 %t154, 1
  store i64 %t155, i64* %l6
  %t156 = load i64, i64* %l6
  br label %merge26
else25:
  %t157 = load i8*, i8** %l8
  %t158 = load i8, i8* %t157
  %t159 = icmp eq i8 %t158, 93
  %t160 = load i8*, i8** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load i64, i64* %l2
  %t163 = load i64, i64* %l3
  %t164 = load i64, i64* %l4
  %t165 = load i64, i64* %l5
  %t166 = load i64, i64* %l6
  %t167 = load i8*, i8** %l7
  %t168 = load i8*, i8** %l8
  br i1 %t159, label %then27, label %merge28
then27:
  %t169 = load i64, i64* %l6
  %t170 = icmp sgt i64 %t169, 0
  %t171 = load i8*, i8** %l0
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t173 = load i64, i64* %l2
  %t174 = load i64, i64* %l3
  %t175 = load i64, i64* %l4
  %t176 = load i64, i64* %l5
  %t177 = load i64, i64* %l6
  %t178 = load i8*, i8** %l7
  %t179 = load i8*, i8** %l8
  br i1 %t170, label %then29, label %merge30
then29:
  %t180 = load i64, i64* %l6
  %t181 = sub i64 %t180, 1
  store i64 %t181, i64* %l6
  %t182 = load i64, i64* %l6
  br label %merge30
merge30:
  %t183 = phi i64 [ %t182, %then29 ], [ %t177, %then27 ]
  store i64 %t183, i64* %l6
  %t184 = load i64, i64* %l6
  br label %merge28
merge28:
  %t185 = phi i64 [ %t184, %merge30 ], [ %t166, %else25 ]
  store i64 %t185, i64* %l6
  %t186 = load i64, i64* %l6
  br label %merge26
merge26:
  %t187 = phi i64 [ %t156, %then24 ], [ %t186, %merge28 ]
  store i64 %t187, i64* %l6
  %t188 = load i64, i64* %l6
  %t189 = load i64, i64* %l6
  br label %merge21
merge21:
  %t190 = phi i64 [ %t141, %merge23 ], [ %t122, %merge26 ]
  %t191 = phi i64 [ %t123, %merge23 ], [ %t188, %merge26 ]
  store i64 %t190, i64* %l5
  store i64 %t191, i64* %l6
  %t192 = load i64, i64* %l5
  %t193 = load i64, i64* %l6
  %t194 = load i64, i64* %l6
  br label %merge18
merge18:
  %t195 = phi i64 [ %t113, %then16 ], [ %t192, %merge21 ]
  %t196 = phi i64 [ %t108, %then16 ], [ %t193, %merge21 ]
  store i64 %t195, i64* %l5
  store i64 %t196, i64* %l6
  %t197 = load i64, i64* %l5
  %t198 = load i64, i64* %l5
  %t199 = load i64, i64* %l6
  %t200 = load i64, i64* %l6
  br label %merge13
merge13:
  %t201 = phi i64 [ %t98, %merge15 ], [ %t78, %merge18 ]
  %t202 = phi i64 [ %t79, %merge15 ], [ %t197, %merge18 ]
  %t203 = phi i64 [ %t80, %merge15 ], [ %t199, %merge18 ]
  store i64 %t201, i64* %l4
  store i64 %t202, i64* %l5
  store i64 %t203, i64* %l6
  %t204 = load i64, i64* %l4
  %t205 = load i64, i64* %l5
  %t206 = load i64, i64* %l5
  %t207 = load i64, i64* %l6
  %t208 = load i64, i64* %l6
  br label %merge10
merge10:
  %t209 = phi i64 [ %t70, %then8 ], [ %t204, %merge13 ]
  %t210 = phi i64 [ %t64, %then8 ], [ %t205, %merge13 ]
  %t211 = phi i64 [ %t65, %then8 ], [ %t207, %merge13 ]
  store i64 %t209, i64* %l4
  store i64 %t210, i64* %l5
  store i64 %t211, i64* %l6
  %t213 = load i8*, i8** %l8
  %t214 = load i8*, i8** %l7
  %t215 = call i1 @strings_equal(i8* %t213, i8* %t214)
  br label %logical_and_entry_212

logical_and_entry_212:
  br i1 %t215, label %logical_and_right_212, label %logical_and_merge_212

logical_and_right_212:
  %t217 = load i64, i64* %l4
  %t218 = icmp eq i64 %t217, 0
  br label %logical_and_entry_216

logical_and_entry_216:
  br i1 %t218, label %logical_and_right_216, label %logical_and_merge_216

logical_and_right_216:
  %t220 = load i64, i64* %l5
  %t221 = icmp eq i64 %t220, 0
  br label %logical_and_entry_219

logical_and_entry_219:
  br i1 %t221, label %logical_and_right_219, label %logical_and_merge_219

logical_and_right_219:
  %t222 = load i64, i64* %l6
  %t223 = icmp eq i64 %t222, 0
  br label %logical_and_right_end_219

logical_and_right_end_219:
  br label %logical_and_merge_219

logical_and_merge_219:
  %t224 = phi i1 [ false, %logical_and_entry_219 ], [ %t223, %logical_and_right_end_219 ]
  br label %logical_and_right_end_216

logical_and_right_end_216:
  br label %logical_and_merge_216

logical_and_merge_216:
  %t225 = phi i1 [ false, %logical_and_entry_216 ], [ %t224, %logical_and_right_end_216 ]
  br label %logical_and_right_end_212

logical_and_right_end_212:
  br label %logical_and_merge_212

logical_and_merge_212:
  %t226 = phi i1 [ false, %logical_and_entry_212 ], [ %t225, %logical_and_right_end_212 ]
  %t227 = load i8*, i8** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load i64, i64* %l2
  %t230 = load i64, i64* %l3
  %t231 = load i64, i64* %l4
  %t232 = load i64, i64* %l5
  %t233 = load i64, i64* %l6
  %t234 = load i8*, i8** %l7
  %t235 = load i8*, i8** %l8
  br i1 %t226, label %then31, label %merge32
then31:
  %t236 = load i8*, i8** %l0
  %t237 = load i64, i64* %l2
  %t238 = load i64, i64* %l3
  %t239 = call i8* @sailfin_runtime_substring(i8* %t236, i64 %t237, i64 %t238)
  store i8* %t239, i8** %l9
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t241 = load i8*, i8** %l9
  %t242 = call i8* @descriptor_trim(i8* %t241)
  %t243 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t244 = ptrtoint [1 x i8*]* %t243 to i64
  %t245 = icmp eq i64 %t244, 0
  %t246 = select i1 %t245, i64 1, i64 %t244
  %t247 = call i8* @malloc(i64 %t246)
  %t248 = bitcast i8* %t247 to i8**
  %t249 = getelementptr i8*, i8** %t248, i64 0
  store i8* %t242, i8** %t249
  %t250 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t251 = ptrtoint { i8**, i64 }* %t250 to i64
  %t252 = call i8* @malloc(i64 %t251)
  %t253 = bitcast i8* %t252 to { i8**, i64 }*
  %t254 = getelementptr { i8**, i64 }, { i8**, i64 }* %t253, i32 0, i32 0
  store i8** %t248, i8*** %t254
  %t255 = getelementptr { i8**, i64 }, { i8**, i64 }* %t253, i32 0, i32 1
  store i64 1, i64* %t255
  %t256 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t240, { i8**, i64 }* %t253)
  store { i8**, i64 }* %t256, { i8**, i64 }** %l1
  %t257 = load i64, i64* %l3
  %t258 = add i64 %t257, 1
  store i64 %t258, i64* %l2
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t260 = load i64, i64* %l2
  br label %merge32
merge32:
  %t261 = phi { i8**, i64 }* [ %t259, %then31 ], [ %t228, %logical_and_merge_212 ]
  %t262 = phi i64 [ %t260, %then31 ], [ %t229, %logical_and_merge_212 ]
  store { i8**, i64 }* %t261, { i8**, i64 }** %l1
  store i64 %t262, i64* %l2
  %t263 = load i64, i64* %l3
  %t264 = add i64 %t263, 1
  store i64 %t264, i64* %l3
  br label %loop.latch4
loop.latch4:
  %t265 = load i64, i64* %l4
  %t266 = load i64, i64* %l5
  %t267 = load i64, i64* %l6
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load i64, i64* %l2
  %t270 = load i64, i64* %l3
  br label %loop.header2
afterloop5:
  %t277 = load i64, i64* %l4
  %t278 = load i64, i64* %l5
  %t279 = load i64, i64* %l6
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load i64, i64* %l2
  %t282 = load i64, i64* %l3
  %t283 = load i8*, i8** %l0
  %t284 = load i64, i64* %l2
  %t285 = load i8*, i8** %l0
  %t286 = call i64 @sailfin_runtime_string_length(i8* %t285)
  %t287 = call i8* @sailfin_runtime_substring(i8* %t283, i64 %t284, i64 %t286)
  store i8* %t287, i8** %l10
  %t288 = load i8*, i8** %l10
  %t289 = call i8* @descriptor_trim(i8* %t288)
  store i8* %t289, i8** %l11
  %t291 = load i8*, i8** %l11
  %t292 = call i64 @sailfin_runtime_string_length(i8* %t291)
  %t293 = icmp sgt i64 %t292, 0
  br label %logical_or_entry_290

logical_or_entry_290:
  br i1 %t293, label %logical_or_merge_290, label %logical_or_right_290

logical_or_right_290:
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t295 = load { i8**, i64 }, { i8**, i64 }* %t294
  %t296 = extractvalue { i8**, i64 } %t295, 1
  %t297 = icmp eq i64 %t296, 0
  br label %logical_or_right_end_290

logical_or_right_end_290:
  br label %logical_or_merge_290

logical_or_merge_290:
  %t298 = phi i1 [ true, %logical_or_entry_290 ], [ %t297, %logical_or_right_end_290 ]
  %t299 = load i8*, i8** %l0
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t301 = load i64, i64* %l2
  %t302 = load i64, i64* %l3
  %t303 = load i64, i64* %l4
  %t304 = load i64, i64* %l5
  %t305 = load i64, i64* %l6
  %t306 = load i8*, i8** %l7
  %t307 = load i8*, i8** %l10
  %t308 = load i8*, i8** %l11
  br i1 %t298, label %then33, label %merge34
then33:
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = load i8*, i8** %l11
  %t311 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t312 = ptrtoint [1 x i8*]* %t311 to i64
  %t313 = icmp eq i64 %t312, 0
  %t314 = select i1 %t313, i64 1, i64 %t312
  %t315 = call i8* @malloc(i64 %t314)
  %t316 = bitcast i8* %t315 to i8**
  %t317 = getelementptr i8*, i8** %t316, i64 0
  store i8* %t310, i8** %t317
  %t318 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t319 = ptrtoint { i8**, i64 }* %t318 to i64
  %t320 = call i8* @malloc(i64 %t319)
  %t321 = bitcast i8* %t320 to { i8**, i64 }*
  %t322 = getelementptr { i8**, i64 }, { i8**, i64 }* %t321, i32 0, i32 0
  store i8** %t316, i8*** %t322
  %t323 = getelementptr { i8**, i64 }, { i8**, i64 }* %t321, i32 0, i32 1
  store i64 1, i64* %t323
  %t324 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t309, { i8**, i64 }* %t321)
  store { i8**, i64 }* %t324, { i8**, i64 }** %l1
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t326 = phi { i8**, i64 }* [ %t325, %then33 ], [ %t300, %logical_or_merge_290 ]
  store { i8**, i64 }* %t326, { i8**, i64 }** %l1
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t327
}

define { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %parts) {
block.entry:
  %l0 = alloca { %TypeDescriptor*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %t0 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* null, i32 1
  %t1 = ptrtoint [0 x %TypeDescriptor]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %TypeDescriptor*
  %t6 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t7 = ptrtoint { %TypeDescriptor*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %TypeDescriptor*, i64 }*
  %t10 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t9, i32 0, i32 0
  store %TypeDescriptor* %t5, %TypeDescriptor** %t10
  %t11 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %TypeDescriptor*, i64 }* %t9, { %TypeDescriptor*, i64 }** %l0
  store i64 0, i64* %l1
  %t12 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t13 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t82 = phi { %TypeDescriptor*, i64 }* [ %t12, %block.entry ], [ %t80, %loop.latch2 ]
  %t83 = phi i64 [ %t13, %block.entry ], [ %t81, %loop.latch2 ]
  store { %TypeDescriptor*, i64 }* %t82, { %TypeDescriptor*, i64 }** %l0
  store i64 %t83, i64* %l1
  br label %loop.body1
loop.body1:
  %t14 = load i64, i64* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp sge i64 %t14, %t16
  %t18 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t19 = load i64, i64* %l1
  br i1 %t17, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load i64, i64* %l1
  %t21 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t20, i64 %t23)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l2
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp sgt i64 %t28, 0
  %t30 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t31 = load i64, i64* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then6, label %merge7
then6:
  %t33 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t34 = load i8*, i8** %l2
  %t35 = call %TypeDescriptor @parse_type_descriptor(i8* %t34)
  %t36 = getelementptr [1 x %TypeDescriptor], [1 x %TypeDescriptor]* null, i32 1
  %t37 = ptrtoint [1 x %TypeDescriptor]* %t36 to i64
  %t38 = icmp eq i64 %t37, 0
  %t39 = select i1 %t38, i64 1, i64 %t37
  %t40 = call i8* @malloc(i64 %t39)
  %t41 = bitcast i8* %t40 to %TypeDescriptor*
  %t42 = getelementptr %TypeDescriptor, %TypeDescriptor* %t41, i64 0
  store %TypeDescriptor %t35, %TypeDescriptor* %t42
  %t43 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t44 = ptrtoint { %TypeDescriptor*, i64 }* %t43 to i64
  %t45 = call i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to { %TypeDescriptor*, i64 }*
  %t47 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t46, i32 0, i32 0
  store %TypeDescriptor* %t41, %TypeDescriptor** %t47
  %t48 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t46, i32 0, i32 1
  store i64 1, i64* %t48
  %t49 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t33, i32 0, i32 0
  %t50 = load %TypeDescriptor*, %TypeDescriptor** %t49
  %t51 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t33, i32 0, i32 1
  %t52 = load i64, i64* %t51
  %t53 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t46, i32 0, i32 0
  %t54 = load %TypeDescriptor*, %TypeDescriptor** %t53
  %t55 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t46, i32 0, i32 1
  %t56 = load i64, i64* %t55
  %t57 = getelementptr [1 x %TypeDescriptor], [1 x %TypeDescriptor]* null, i32 0, i32 1
  %t58 = ptrtoint %TypeDescriptor* %t57 to i64
  %t59 = add i64 %t52, %t56
  %t60 = mul i64 %t58, %t59
  %t61 = call noalias i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to %TypeDescriptor*
  %t63 = bitcast %TypeDescriptor* %t62 to i8*
  %t64 = mul i64 %t58, %t52
  %t65 = bitcast %TypeDescriptor* %t50 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t63, i8* %t65, i64 %t64)
  %t66 = mul i64 %t58, %t56
  %t67 = bitcast %TypeDescriptor* %t54 to i8*
  %t68 = getelementptr %TypeDescriptor, %TypeDescriptor* %t62, i64 %t52
  %t69 = bitcast %TypeDescriptor* %t68 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t69, i8* %t67, i64 %t66)
  %t70 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t71 = ptrtoint { %TypeDescriptor*, i64 }* %t70 to i64
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to { %TypeDescriptor*, i64 }*
  %t74 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t73, i32 0, i32 0
  store %TypeDescriptor* %t62, %TypeDescriptor** %t74
  %t75 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t73, i32 0, i32 1
  store i64 %t59, i64* %t75
  store { %TypeDescriptor*, i64 }* %t73, { %TypeDescriptor*, i64 }** %l0
  %t76 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  br label %merge7
merge7:
  %t77 = phi { %TypeDescriptor*, i64 }* [ %t76, %then6 ], [ %t30, %merge5 ]
  store { %TypeDescriptor*, i64 }* %t77, { %TypeDescriptor*, i64 }** %l0
  %t78 = load i64, i64* %l1
  %t79 = add i64 %t78, 1
  store i64 %t79, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t80 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t81 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t84 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t85 = load i64, i64* %l1
  %t86 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  ret { %TypeDescriptor*, i64 }* %t86
}

define %TypeDescriptor @parse_type_descriptor(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca %TypeDescriptor
  %l6 = alloca %TypeDescriptor
  %l7 = alloca double
  %l8 = alloca i8*
  %t0 = call i8* @descriptor_strip_outer_parens(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call %TypeDescriptor @type_descriptor_unknown()
  ret %TypeDescriptor %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = add i64 0, 2
  %t8 = call i8* @malloc(i64 %t7)
  store i8 124, i8* %t8
  %t9 = getelementptr i8, i8* %t8, i64 1
  store i8 0, i8* %t9
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  %t10 = call { i8**, i64 }* @split_descriptor(i8* %t6, i8* %t8)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = icmp sgt i64 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t14, label %then2, label %merge3
then2:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t17)
  %t19 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t18)
  ret %TypeDescriptor %t19
merge3:
  %t20 = load i8*, i8** %l0
  %t21 = add i64 0, 2
  %t22 = call i8* @malloc(i64 %t21)
  store i8 38, i8* %t22
  %t23 = getelementptr i8, i8* %t22, i64 1
  store i8 0, i8* %t23
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  %t24 = call { i8**, i64 }* @split_descriptor(i8* %t20, i8* %t22)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t25
  %t27 = extractvalue { i8**, i64 } %t26, 1
  %t28 = icmp sgt i64 %t27, 1
  %t29 = load i8*, i8** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t28, label %then4, label %merge5
then4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t32)
  %t34 = call %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %t33)
  ret %TypeDescriptor %t34
merge5:
  %t35 = load i8*, i8** %l0
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  %t37 = call i1 @string_ends_with(i8* %t35, i8* %s36)
  %t38 = load i8*, i8** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t37, label %then6, label %merge7
then6:
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l0
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = sub i64 %t43, 2
  %t45 = call i8* @sailfin_runtime_substring(i8* %t41, i64 0, i64 %t44)
  store i8* %t45, i8** %l3
  %t46 = load i8*, i8** %l3
  %t47 = call %TypeDescriptor @parse_type_descriptor(i8* %t46)
  %t48 = call %TypeDescriptor @type_descriptor_array(%TypeDescriptor %t47)
  ret %TypeDescriptor %t48
merge7:
  %t49 = load i8*, i8** %l0
  %s50 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090260294, i32 0, i32 0
  %t51 = call i1 @string_starts_with(i8* %t49, i8* %s50)
  %t52 = load i8*, i8** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t51, label %then8, label %merge9
then8:
  %t55 = call %TypeDescriptor @type_descriptor_function()
  ret %TypeDescriptor %t55
merge9:
  %t56 = load i8*, i8** %l0
  %t57 = load i8*, i8** %l0
  %t58 = call i64 @sailfin_runtime_string_length(i8* %t57)
  %t59 = sub i64 %t58, 1
  %t60 = sitofp i64 %t59 to double
  %t61 = call i8* @char_at(i8* %t56, double %t60)
  %t62 = load i8, i8* %t61
  %t63 = icmp eq i8 %t62, 63
  %t64 = load i8*, i8** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t63, label %then10, label %merge11
then10:
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l0
  %t69 = call i64 @sailfin_runtime_string_length(i8* %t68)
  %t70 = sub i64 %t69, 1
  %t71 = call i8* @sailfin_runtime_substring(i8* %t67, i64 0, i64 %t70)
  store i8* %t71, i8** %l4
  %t72 = load i8*, i8** %l4
  %t73 = call %TypeDescriptor @parse_type_descriptor(i8* %t72)
  store %TypeDescriptor %t73, %TypeDescriptor* %l5
  %s74 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t75 = call %TypeDescriptor @type_descriptor_primitive(i8* %s74)
  store %TypeDescriptor %t75, %TypeDescriptor* %l6
  %t76 = load %TypeDescriptor, %TypeDescriptor* %l5
  %t77 = load %TypeDescriptor, %TypeDescriptor* %l6
  %t78 = getelementptr [2 x %TypeDescriptor], [2 x %TypeDescriptor]* null, i32 1
  %t79 = ptrtoint [2 x %TypeDescriptor]* %t78 to i64
  %t80 = icmp eq i64 %t79, 0
  %t81 = select i1 %t80, i64 1, i64 %t79
  %t82 = call i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to %TypeDescriptor*
  %t84 = getelementptr %TypeDescriptor, %TypeDescriptor* %t83, i64 0
  store %TypeDescriptor %t76, %TypeDescriptor* %t84
  %t85 = getelementptr %TypeDescriptor, %TypeDescriptor* %t83, i64 1
  store %TypeDescriptor %t77, %TypeDescriptor* %t85
  %t86 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* null, i32 1
  %t87 = ptrtoint { %TypeDescriptor*, i64 }* %t86 to i64
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to { %TypeDescriptor*, i64 }*
  %t90 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t89, i32 0, i32 0
  store %TypeDescriptor* %t83, %TypeDescriptor** %t90
  %t91 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t89, i32 0, i32 1
  store i64 2, i64* %t91
  %t92 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t89)
  ret %TypeDescriptor %t92
merge11:
  %t93 = load i8*, i8** %l0
  %t94 = add i64 0, 2
  %t95 = call i8* @malloc(i64 %t94)
  store i8 60, i8* %t95
  %t96 = getelementptr i8, i8* %t95, i64 1
  store i8 0, i8* %t96
  call void @sailfin_runtime_mark_persistent(i8* %t95)
  %t97 = call double @descriptor_find_top_level(i8* %t93, i8* %t95)
  store double %t97, double* %l7
  %t98 = load i8*, i8** %l0
  store i8* %t98, i8** %l8
  %t99 = load double, double* %l7
  %t100 = sitofp i64 0 to double
  %t101 = fcmp oge double %t99, %t100
  %t102 = load i8*, i8** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = load double, double* %l7
  %t106 = load i8*, i8** %l8
  br i1 %t101, label %then12, label %merge13
then12:
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l7
  %t109 = call double @llvm.round.f64(double %t108)
  %t110 = fptosi double %t109 to i64
  %t111 = call i8* @sailfin_runtime_substring(i8* %t107, i64 0, i64 %t110)
  %t112 = call i8* @descriptor_trim(i8* %t111)
  store i8* %t112, i8** %l8
  %t113 = load i8*, i8** %l8
  br label %merge13
merge13:
  %t114 = phi i8* [ %t113, %then12 ], [ %t106, %merge11 ]
  store i8* %t114, i8** %l8
  %t115 = load i8*, i8** %l8
  %s116 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2085806430, i32 0, i32 0
  %t117 = call i1 @string_starts_with(i8* %t115, i8* %s116)
  %t118 = load i8*, i8** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t121 = load double, double* %l7
  %t122 = load i8*, i8** %l8
  br i1 %t117, label %then14, label %merge15
then14:
  %t123 = load i8*, i8** %l8
  %t124 = load i8*, i8** %l8
  %t125 = call i64 @sailfin_runtime_string_length(i8* %t124)
  %t126 = call i8* @sailfin_runtime_substring(i8* %t123, i64 8, i64 %t125)
  %t127 = call i8* @descriptor_trim(i8* %t126)
  store i8* %t127, i8** %l8
  %t128 = load i8*, i8** %l8
  br label %merge15
merge15:
  %t129 = phi i8* [ %t128, %then14 ], [ %t122, %merge13 ]
  store i8* %t129, i8** %l8
  %t131 = load i8*, i8** %l8
  %s132 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789270767, i32 0, i32 0
  %t133 = call i1 @strings_equal(i8* %t131, i8* %s132)
  br label %logical_or_entry_130

logical_or_entry_130:
  br i1 %t133, label %logical_or_merge_130, label %logical_or_right_130

logical_or_right_130:
  %t135 = load i8*, i8** %l8
  %s136 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h807326654, i32 0, i32 0
  %t137 = call i1 @strings_equal(i8* %t135, i8* %s136)
  br label %logical_or_entry_134

logical_or_entry_134:
  br i1 %t137, label %logical_or_merge_134, label %logical_or_right_134

logical_or_right_134:
  %t139 = load i8*, i8** %l8
  %s140 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1483009776, i32 0, i32 0
  %t141 = call i1 @strings_equal(i8* %t139, i8* %s140)
  br label %logical_or_entry_138

logical_or_entry_138:
  br i1 %t141, label %logical_or_merge_138, label %logical_or_right_138

logical_or_right_138:
  %t142 = load i8*, i8** %l8
  %s143 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t144 = call i1 @strings_equal(i8* %t142, i8* %s143)
  br label %logical_or_right_end_138

logical_or_right_end_138:
  br label %logical_or_merge_138

logical_or_merge_138:
  %t145 = phi i1 [ true, %logical_or_entry_138 ], [ %t144, %logical_or_right_end_138 ]
  br label %logical_or_right_end_134

logical_or_right_end_134:
  br label %logical_or_merge_134

logical_or_merge_134:
  %t146 = phi i1 [ true, %logical_or_entry_134 ], [ %t145, %logical_or_right_end_134 ]
  br label %logical_or_right_end_130

logical_or_right_end_130:
  br label %logical_or_merge_130

logical_or_merge_130:
  %t147 = phi i1 [ true, %logical_or_entry_130 ], [ %t146, %logical_or_right_end_130 ]
  %t148 = load i8*, i8** %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t151 = load double, double* %l7
  %t152 = load i8*, i8** %l8
  br i1 %t147, label %then16, label %merge17
then16:
  %t153 = load i8*, i8** %l8
  %t154 = call %TypeDescriptor @type_descriptor_primitive(i8* %t153)
  ret %TypeDescriptor %t154
merge17:
  %t155 = load i8*, i8** %l8
  %t156 = call %TypeDescriptor @type_descriptor_named(i8* %t155)
  ret %TypeDescriptor %t156
}

define i1 @check_type_primitive(i8* %value, i8* %name) {
block.entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789270767, i32 0, i32 0
  %t1 = call i1 @strings_equal(i8* %name, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i1 @sailfin_runtime_is_string(i8* %value)
  ret i1 %t2
merge1:
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h807326654, i32 0, i32 0
  %t4 = call i1 @strings_equal(i8* %name, i8* %s3)
  br i1 %t4, label %then2, label %merge3
then2:
  %t5 = call i1 @sailfin_runtime_is_number(i8* %value)
  ret i1 %t5
merge3:
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1483009776, i32 0, i32 0
  %t7 = call i1 @strings_equal(i8* %name, i8* %s6)
  br i1 %t7, label %then4, label %merge5
then4:
  %t8 = call i1 @sailfin_runtime_is_boolean(i8* %value)
  ret i1 %t8
merge5:
  %s9 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t10 = call i1 @strings_equal(i8* %name, i8* %s9)
  br i1 %t10, label %then6, label %merge7
then6:
  %t11 = call i1 @sailfin_runtime_is_void(i8* %value)
  ret i1 %t11
merge7:
  ret i1 0
}

define i1 @check_type_descriptor(i8* %value, %TypeDescriptor %descriptor) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %l2 = alloca %TypeDescriptor
  %l3 = alloca i64
  %l4 = alloca i8*
  %t0 = extractvalue %TypeDescriptor %descriptor, 0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1770336441, i32 0, i32 0
  %t2 = call i1 @strings_equal(i8* %t0, i8* %s1)
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = extractvalue %TypeDescriptor %descriptor, 1
  %t4 = icmp eq i8* %t3, null
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = extractvalue %TypeDescriptor %descriptor, 1
  %t6 = call i1 @check_type_primitive(i8* %value, i8* %t5)
  ret i1 %t6
merge1:
  %t7 = extractvalue %TypeDescriptor %descriptor, 0
  %s8 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h550282393, i32 0, i32 0
  %t9 = call i1 @strings_equal(i8* %t7, i8* %s8)
  br i1 %t9, label %then4, label %merge5
then4:
  store i64 0, i64* %l0
  %t10 = load i64, i64* %l0
  br label %loop.header6
loop.header6:
  %t30 = phi i64 [ %t10, %then4 ], [ %t29, %loop.latch8 ]
  store i64 %t30, i64* %l0
  br label %loop.body7
loop.body7:
  %t11 = load i64, i64* %l0
  %t12 = extractvalue %TypeDescriptor %descriptor, 2
  %t13 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t12
  %t14 = extractvalue { %TypeDescriptor*, i64 } %t13, 1
  %t15 = icmp sge i64 %t11, %t14
  %t16 = load i64, i64* %l0
  br i1 %t15, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t17 = extractvalue %TypeDescriptor %descriptor, 2
  %t18 = load i64, i64* %l0
  %t19 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t17
  %t20 = extractvalue { %TypeDescriptor*, i64 } %t19, 0
  %t21 = extractvalue { %TypeDescriptor*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t18, i64 %t21)
  %t23 = getelementptr %TypeDescriptor, %TypeDescriptor* %t20, i64 %t18
  %t24 = load %TypeDescriptor, %TypeDescriptor* %t23
  %t25 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor %t24)
  %t26 = load i64, i64* %l0
  br i1 %t25, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t27 = load i64, i64* %l0
  %t28 = add i64 %t27, 1
  store i64 %t28, i64* %l0
  br label %loop.latch8
loop.latch8:
  %t29 = load i64, i64* %l0
  br label %loop.header6
afterloop9:
  %t31 = load i64, i64* %l0
  ret i1 0
merge5:
  %t32 = extractvalue %TypeDescriptor %descriptor, 0
  %s33 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h22148892, i32 0, i32 0
  %t34 = call i1 @strings_equal(i8* %t32, i8* %s33)
  br i1 %t34, label %then14, label %merge15
then14:
  store i64 0, i64* %l1
  %t35 = load i64, i64* %l1
  br label %loop.header16
loop.header16:
  %t56 = phi i64 [ %t35, %then14 ], [ %t55, %loop.latch18 ]
  store i64 %t56, i64* %l1
  br label %loop.body17
loop.body17:
  %t36 = load i64, i64* %l1
  %t37 = extractvalue %TypeDescriptor %descriptor, 2
  %t38 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t37
  %t39 = extractvalue { %TypeDescriptor*, i64 } %t38, 1
  %t40 = icmp sge i64 %t36, %t39
  %t41 = load i64, i64* %l1
  br i1 %t40, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t42 = extractvalue %TypeDescriptor %descriptor, 2
  %t43 = load i64, i64* %l1
  %t44 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t42
  %t45 = extractvalue { %TypeDescriptor*, i64 } %t44, 0
  %t46 = extractvalue { %TypeDescriptor*, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t43, i64 %t46)
  %t48 = getelementptr %TypeDescriptor, %TypeDescriptor* %t45, i64 %t43
  %t49 = load %TypeDescriptor, %TypeDescriptor* %t48
  %t50 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor %t49)
  %t51 = xor i1 %t50, 1
  %t52 = load i64, i64* %l1
  br i1 %t51, label %then22, label %merge23
then22:
  ret i1 0
merge23:
  %t53 = load i64, i64* %l1
  %t54 = add i64 %t53, 1
  store i64 %t54, i64* %l1
  br label %loop.latch18
loop.latch18:
  %t55 = load i64, i64* %l1
  br label %loop.header16
afterloop19:
  %t57 = load i64, i64* %l1
  %t58 = extractvalue %TypeDescriptor %descriptor, 2
  %t59 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t58
  %t60 = extractvalue { %TypeDescriptor*, i64 } %t59, 1
  %t61 = icmp sgt i64 %t60, 0
  ret i1 %t61
merge15:
  %t62 = extractvalue %TypeDescriptor %descriptor, 0
  %s63 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1920110414, i32 0, i32 0
  %t64 = call i1 @strings_equal(i8* %t62, i8* %s63)
  br i1 %t64, label %then24, label %merge25
then24:
  %t65 = extractvalue %TypeDescriptor %descriptor, 2
  %t66 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t65
  %t67 = extractvalue { %TypeDescriptor*, i64 } %t66, 1
  %t68 = icmp eq i64 %t67, 0
  br i1 %t68, label %then26, label %merge27
then26:
  %t69 = call i1 @sailfin_runtime_is_array(i8* %value)
  ret i1 %t69
merge27:
  %t70 = call i1 @sailfin_runtime_is_array(i8* %value)
  %t71 = xor i1 %t70, 1
  br i1 %t71, label %then28, label %merge29
then28:
  ret i1 0
merge29:
  %t72 = extractvalue %TypeDescriptor %descriptor, 2
  %t73 = load { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t72
  %t74 = extractvalue { %TypeDescriptor*, i64 } %t73, 0
  %t75 = extractvalue { %TypeDescriptor*, i64 } %t73, 1
  %t76 = icmp uge i64 0, %t75
  ; bounds check: %t76 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t75)
  %t77 = getelementptr %TypeDescriptor, %TypeDescriptor* %t74, i64 0
  %t78 = load %TypeDescriptor, %TypeDescriptor* %t77
  store %TypeDescriptor %t78, %TypeDescriptor* %l2
  store i64 0, i64* %l3
  %t79 = load %TypeDescriptor, %TypeDescriptor* %l2
  %t80 = load i64, i64* %l3
  br label %loop.header30
loop.header30:
  %t100 = phi i64 [ %t80, %merge29 ], [ %t99, %loop.latch32 ]
  store i64 %t100, i64* %l3
  br label %loop.body31
loop.body31:
  %t81 = load i64, i64* %l3
  %t82 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t83 = icmp sge i64 %t81, %t82
  %t84 = load %TypeDescriptor, %TypeDescriptor* %l2
  %t85 = load i64, i64* %l3
  br i1 %t83, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t86 = load i64, i64* %l3
  %t87 = getelementptr i8, i8* %value, i64 %t86
  %t88 = load i8, i8* %t87
  %t89 = load %TypeDescriptor, %TypeDescriptor* %l2
  %t90 = add i64 0, 2
  %t91 = call i8* @malloc(i64 %t90)
  store i8 %t88, i8* %t91
  %t92 = getelementptr i8, i8* %t91, i64 1
  store i8 0, i8* %t92
  call void @sailfin_runtime_mark_persistent(i8* %t91)
  %t93 = call i1 @check_type_descriptor(i8* %t91, %TypeDescriptor %t89)
  %t94 = xor i1 %t93, 1
  %t95 = load %TypeDescriptor, %TypeDescriptor* %l2
  %t96 = load i64, i64* %l3
  br i1 %t94, label %then36, label %merge37
then36:
  ret i1 0
merge37:
  %t97 = load i64, i64* %l3
  %t98 = add i64 %t97, 1
  store i64 %t98, i64* %l3
  br label %loop.latch32
loop.latch32:
  %t99 = load i64, i64* %l3
  br label %loop.header30
afterloop33:
  %t101 = load i64, i64* %l3
  ret i1 1
merge25:
  %t102 = extractvalue %TypeDescriptor %descriptor, 0
  %s103 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1603982015, i32 0, i32 0
  %t104 = call i1 @strings_equal(i8* %t102, i8* %s103)
  br i1 %t104, label %then38, label %merge39
then38:
  %t105 = call i1 @sailfin_runtime_is_callable(i8* %value)
  ret i1 %t105
merge39:
  %t106 = extractvalue %TypeDescriptor %descriptor, 0
  %s107 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261050197, i32 0, i32 0
  %t108 = call i1 @strings_equal(i8* %t106, i8* %s107)
  br i1 %t108, label %then40, label %merge41
then40:
  %t109 = extractvalue %TypeDescriptor %descriptor, 1
  %t110 = icmp eq i8* %t109, null
  br i1 %t110, label %then42, label %merge43
then42:
  ret i1 0
merge43:
  %t111 = extractvalue %TypeDescriptor %descriptor, 1
  %t112 = call i8* @sailfin_runtime_resolve_type(i8* %t111)
  store i8* %t112, i8** %l4
  %t113 = load i8*, i8** %l4
  %t114 = call i1 @sailfin_runtime_instance_of(i8* %value, i8* %t113)
  ret i1 %t114
merge41:
  %t115 = extractvalue %TypeDescriptor %descriptor, 0
  %s116 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h186837049, i32 0, i32 0
  %t117 = call i1 @strings_equal(i8* %t115, i8* %s116)
  br i1 %t117, label %then44, label %merge45
then44:
  ret i1 0
merge45:
  ret i1 0
}

define i1 @check_type(i8* %value, i8* %descriptor) {
block.entry:
  %l0 = alloca %TypeDescriptor
  %t0 = call %TypeDescriptor @parse_type_descriptor(i8* %descriptor)
  store %TypeDescriptor %t0, %TypeDescriptor* %l0
  %t1 = load %TypeDescriptor, %TypeDescriptor* %l0
  %t2 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor %t1)
  ret i1 %t2
}

; fn serve effects: ![io, net]
define void @serve(i8* %handler, i8* %config) {
block.entry:
  call void @sailfin_runtime_serve(i8* %handler, i8* %config)
  ret void
}

define double @clamp(double %value, double %minimum, double %maximum) {
block.entry:
  %t0 = fcmp olt double %value, %minimum
  br i1 %t0, label %then0, label %merge1
then0:
  ret double %minimum
merge1:
  %t1 = fcmp ogt double %value, %maximum
  br i1 %t1, label %then2, label %merge3
then2:
  ret double %maximum
merge3:
  ret double %value
}

define i8* @substring(i8* %text, double %start, double %end) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  store i64 %t0, i64* %l0
  %t1 = load i64, i64* %l0
  %t2 = icmp eq i64 %t1, 0
  %t3 = load i64, i64* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s4)
  ret i8* %s4
merge1:
  %t5 = load i64, i64* %l0
  %t6 = sitofp i64 0 to double
  %t7 = sitofp i64 %t5 to double
  %t8 = call double @clamp(double %start, double %t6, double %t7)
  store double %t8, double* %l1
  %t9 = load i64, i64* %l0
  %t10 = sitofp i64 0 to double
  %t11 = sitofp i64 %t9 to double
  %t12 = call double @clamp(double %end, double %t10, double %t11)
  store double %t12, double* %l2
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = fcmp oge double %t13, %t14
  %t16 = load i64, i64* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then2, label %merge3
then2:
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s19)
  ret i8* %s19
merge3:
  %t20 = load double, double* %l1
  store double %t20, double* %l3
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s21, i8** %l4
  %t22 = load i64, i64* %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t50 = phi i8* [ %t26, %merge3 ], [ %t48, %loop.latch6 ]
  %t51 = phi double [ %t25, %merge3 ], [ %t49, %loop.latch6 ]
  store i8* %t50, i8** %l4
  store double %t51, double* %l3
  br label %loop.body5
loop.body5:
  %t27 = load double, double* %l3
  %t28 = load double, double* %l2
  %t29 = fcmp oge double %t27, %t28
  %t30 = load i64, i64* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load i8*, i8** %l4
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %text, i64 %t38
  %t40 = load i8, i8* %t39
  %t41 = add i64 0, 2
  %t42 = call i8* @malloc(i64 %t41)
  store i8 %t40, i8* %t42
  %t43 = getelementptr i8, i8* %t42, i64 1
  store i8 0, i8* %t43
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t42)
  store i8* %t44, i8** %l4
  %t45 = load double, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l3
  br label %loop.latch6
loop.latch6:
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t52 = load i8*, i8** %l4
  %t53 = load double, double* %l3
  %t54 = load i8*, i8** %l4
  call void @sailfin_runtime_mark_persistent(i8* %t54)
  ret i8* %t54
}

define private i1 @strings_equal(i8* %left, i8* %right) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %left)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %right)
  %t2 = icmp ne i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i64 0, i64* %l0
  %t3 = load i64, i64* %l0
  br label %loop.header2
loop.header2:
  %t25 = phi i64 [ %t3, %merge1 ], [ %t24, %loop.latch4 ]
  store i64 %t25, i64* %l0
  br label %loop.body3
loop.body3:
  %t4 = load i64, i64* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %left)
  %t6 = icmp sge i64 %t4, %t5
  %t7 = load i64, i64* %l0
  br i1 %t6, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t8 = load i64, i64* %l0
  %t9 = sitofp i64 %t8 to double
  %t10 = call i8* @char_at(i8* %left, double %t9)
  store i8* %t10, i8** %l1
  %t11 = load i64, i64* %l0
  %t12 = sitofp i64 %t11 to double
  %t13 = call i8* @char_at(i8* %right, double %t12)
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l1
  %t15 = call double @sailfin_runtime_char_code(i8* %t14)
  %t16 = load i8*, i8** %l2
  %t17 = call double @sailfin_runtime_char_code(i8* %t16)
  %t18 = fcmp une double %t15, %t17
  %t19 = load i64, i64* %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i8*, i8** %l2
  br i1 %t18, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t22 = load i64, i64* %l0
  %t23 = add i64 %t22, 1
  store i64 %t23, i64* %l0
  br label %loop.latch4
loop.latch4:
  %t24 = load i64, i64* %l0
  br label %loop.header2
afterloop5:
  %t26 = load i64, i64* %l0
  ret i1 1
}

define double @find_char(i8* %text, i8* %character, double %start) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  store i64 %t0, i64* %l0
  %t1 = load i64, i64* %l0
  %t2 = icmp eq i64 %t1, 0
  %t3 = load i64, i64* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 -1 to double
  ret double %t4
merge1:
  store double %start, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i64, i64* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then2, label %merge3
then2:
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  br label %merge3
merge3:
  %t12 = phi double [ %t11, %then2 ], [ %t9, %merge1 ]
  store double %t12, double* %l1
  %t13 = load double, double* %l1
  %t14 = load i64, i64* %l0
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t13, %t15
  %t17 = load i64, i64* %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then4, label %merge5
then4:
  %t19 = sitofp i64 -1 to double
  ret double %t19
merge5:
  store i8* %character, i8** %l2
  %t21 = load i8*, i8** %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %t21)
  %t23 = icmp eq i64 %t22, 2
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t23, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t24 = load i8*, i8** %l2
  %t25 = sitofp i64 0 to double
  %t26 = call i8* @char_at(i8* %t24, double %t25)
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 92
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t29 = phi i1 [ false, %logical_and_entry_20 ], [ %t28, %logical_and_right_end_20 ]
  %t30 = load i64, i64* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then6, label %merge7
then6:
  %t33 = load i8*, i8** %l2
  %t34 = sitofp i64 1 to double
  %t35 = call i8* @char_at(i8* %t33, double %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = load i8, i8* %t36
  %t38 = icmp eq i8 %t37, 110
  %t39 = load i64, i64* %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l2
  %t42 = load i8*, i8** %l3
  br i1 %t38, label %then8, label %else9
then8:
  %t43 = add i64 0, 2
  %t44 = call i8* @malloc(i64 %t43)
  store i8 10, i8* %t44
  %t45 = getelementptr i8, i8* %t44, i64 1
  store i8 0, i8* %t45
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  store i8* %t44, i8** %l2
  %t46 = load i8*, i8** %l2
  br label %merge10
else9:
  %t47 = load i8*, i8** %l3
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t48, 114
  %t50 = load i64, i64* %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load i8*, i8** %l3
  br i1 %t49, label %then11, label %else12
then11:
  %t54 = add i64 0, 2
  %t55 = call i8* @malloc(i64 %t54)
  store i8 13, i8* %t55
  %t56 = getelementptr i8, i8* %t55, i64 1
  store i8 0, i8* %t56
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  store i8* %t55, i8** %l2
  %t57 = load i8*, i8** %l2
  br label %merge13
else12:
  %t58 = load i8*, i8** %l3
  %t59 = load i8, i8* %t58
  %t60 = icmp eq i8 %t59, 116
  %t61 = load i64, i64* %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load i8*, i8** %l3
  br i1 %t60, label %then14, label %merge15
then14:
  %t65 = add i64 0, 2
  %t66 = call i8* @malloc(i64 %t65)
  store i8 9, i8* %t66
  %t67 = getelementptr i8, i8* %t66, i64 1
  store i8 0, i8* %t67
  call void @sailfin_runtime_mark_persistent(i8* %t66)
  store i8* %t66, i8** %l2
  %t68 = load i8*, i8** %l2
  br label %merge15
merge15:
  %t69 = phi i8* [ %t68, %then14 ], [ %t63, %else12 ]
  store i8* %t69, i8** %l2
  %t70 = load i8*, i8** %l2
  br label %merge13
merge13:
  %t71 = phi i8* [ %t57, %then11 ], [ %t70, %merge15 ]
  store i8* %t71, i8** %l2
  %t72 = load i8*, i8** %l2
  %t73 = load i8*, i8** %l2
  br label %merge10
merge10:
  %t74 = phi i8* [ %t46, %then8 ], [ %t72, %merge13 ]
  store i8* %t74, i8** %l2
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l2
  %t77 = load i8*, i8** %l2
  br label %merge7
merge7:
  %t78 = phi i8* [ %t75, %merge10 ], [ %t32, %logical_and_merge_20 ]
  %t79 = phi i8* [ %t76, %merge10 ], [ %t32, %logical_and_merge_20 ]
  %t80 = phi i8* [ %t77, %merge10 ], [ %t32, %logical_and_merge_20 ]
  store i8* %t78, i8** %l2
  store i8* %t79, i8** %l2
  store i8* %t80, i8** %l2
  %t81 = load double, double* %l1
  store double %t81, double* %l4
  %t82 = load i64, i64* %l0
  %t83 = load double, double* %l1
  %t84 = load i8*, i8** %l2
  %t85 = load double, double* %l4
  br label %loop.header16
loop.header16:
  %t107 = phi double [ %t85, %merge7 ], [ %t106, %loop.latch18 ]
  store double %t107, double* %l4
  br label %loop.body17
loop.body17:
  %t86 = load double, double* %l4
  %t87 = load i64, i64* %l0
  %t88 = sitofp i64 %t87 to double
  %t89 = fcmp oge double %t86, %t88
  %t90 = load i64, i64* %l0
  %t91 = load double, double* %l1
  %t92 = load i8*, i8** %l2
  %t93 = load double, double* %l4
  br i1 %t89, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t94 = load double, double* %l4
  %t95 = call i8* @char_at(i8* %text, double %t94)
  %t96 = load i8*, i8** %l2
  %t97 = call i1 @strings_equal(i8* %t95, i8* %t96)
  %t98 = load i64, i64* %l0
  %t99 = load double, double* %l1
  %t100 = load i8*, i8** %l2
  %t101 = load double, double* %l4
  br i1 %t97, label %then22, label %merge23
then22:
  %t102 = load double, double* %l4
  ret double %t102
merge23:
  %t103 = load double, double* %l4
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l4
  br label %loop.latch18
loop.latch18:
  %t106 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t108 = load double, double* %l4
  %t109 = sitofp i64 -1 to double
  ret double %t109
}

define void @match_exhaustive_failed(i8* %value) {
block.entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1658844115, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  call void @sailfin_runtime_raise_value_error(i8* %t1)
  ret void
}

define double @char_code(i8* %character) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %character)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 -1 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  %t4 = call i8* @char_at(i8* %character, double %t3)
  store i8* %t4, i8** %l0
  %s5 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = load i8*, i8** %l0
  %t8 = sitofp i64 0 to double
  %t9 = call double @find_char(i8* %t6, i8* %t7, double %t8)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = sitofp i64 0 to double
  %t12 = fcmp oge double %t10, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load i8*, i8** %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then2, label %merge3
then2:
  %t16 = load double, double* %l2
  %t17 = sitofp i64 48 to double
  %t18 = fadd double %t17, %t16
  ret double %t18
merge3:
  %s19 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h287370135, i32 0, i32 0
  store i8* %s19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = load i8*, i8** %l0
  %t22 = sitofp i64 0 to double
  %t23 = call double @find_char(i8* %t20, i8* %t21, double %t22)
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = sitofp i64 0 to double
  %t26 = fcmp oge double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load i8*, i8** %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then4, label %merge5
then4:
  %t32 = load double, double* %l4
  %t33 = sitofp i64 97 to double
  %t34 = fadd double %t33, %t32
  ret double %t34
merge5:
  %s35 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h645889856, i32 0, i32 0
  store i8* %s35, i8** %l5
  %t36 = load i8*, i8** %l5
  %t37 = load i8*, i8** %l0
  %t38 = sitofp i64 0 to double
  %t39 = call double @find_char(i8* %t36, i8* %t37, double %t38)
  store double %t39, double* %l6
  %t40 = load double, double* %l6
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oge double %t40, %t41
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load double, double* %l2
  %t46 = load i8*, i8** %l3
  %t47 = load double, double* %l4
  %t48 = load i8*, i8** %l5
  %t49 = load double, double* %l6
  br i1 %t42, label %then6, label %merge7
then6:
  %t50 = load double, double* %l6
  %t51 = sitofp i64 65 to double
  %t52 = fadd double %t51, %t50
  ret double %t52
merge7:
  %t53 = load i8*, i8** %l0
  %t54 = load i8, i8* %t53
  %t55 = icmp eq i8 %t54, 32
  %t56 = load i8*, i8** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  %t59 = load i8*, i8** %l3
  %t60 = load double, double* %l4
  %t61 = load i8*, i8** %l5
  %t62 = load double, double* %l6
  br i1 %t55, label %then8, label %merge9
then8:
  %t63 = sitofp i64 32 to double
  ret double %t63
merge9:
  %t64 = load i8*, i8** %l0
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 10
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  %t71 = load double, double* %l4
  %t72 = load i8*, i8** %l5
  %t73 = load double, double* %l6
  br i1 %t66, label %then10, label %merge11
then10:
  %t74 = sitofp i64 10 to double
  ret double %t74
merge11:
  %t75 = load i8*, i8** %l0
  %t76 = load i8, i8* %t75
  %t77 = icmp eq i8 %t76, 13
  %t78 = load i8*, i8** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l2
  %t81 = load i8*, i8** %l3
  %t82 = load double, double* %l4
  %t83 = load i8*, i8** %l5
  %t84 = load double, double* %l6
  br i1 %t77, label %then12, label %merge13
then12:
  %t85 = sitofp i64 13 to double
  ret double %t85
merge13:
  %t86 = load i8*, i8** %l0
  %t87 = load i8, i8* %t86
  %t88 = icmp eq i8 %t87, 9
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load i8*, i8** %l3
  %t93 = load double, double* %l4
  %t94 = load i8*, i8** %l5
  %t95 = load double, double* %l6
  br i1 %t88, label %then14, label %merge15
then14:
  %t96 = sitofp i64 9 to double
  ret double %t96
merge15:
  %t97 = load i8*, i8** %l0
  %t98 = load i8, i8* %t97
  %t99 = icmp eq i8 %t98, 34
  %t100 = load i8*, i8** %l0
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l2
  %t103 = load i8*, i8** %l3
  %t104 = load double, double* %l4
  %t105 = load i8*, i8** %l5
  %t106 = load double, double* %l6
  br i1 %t99, label %then16, label %merge17
then16:
  %t107 = sitofp i64 34 to double
  ret double %t107
merge17:
  %t108 = load i8*, i8** %l0
  %t109 = load i8, i8* %t108
  %t110 = icmp eq i8 %t109, 92
  %t111 = load i8*, i8** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load i8*, i8** %l3
  %t115 = load double, double* %l4
  %t116 = load i8*, i8** %l5
  %t117 = load double, double* %l6
  br i1 %t110, label %then18, label %merge19
then18:
  %t118 = sitofp i64 92 to double
  ret double %t118
merge19:
  %t119 = load i8*, i8** %l0
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 95
  %t122 = load i8*, i8** %l0
  %t123 = load i8*, i8** %l1
  %t124 = load double, double* %l2
  %t125 = load i8*, i8** %l3
  %t126 = load double, double* %l4
  %t127 = load i8*, i8** %l5
  %t128 = load double, double* %l6
  br i1 %t121, label %then20, label %merge21
then20:
  %t129 = sitofp i64 95 to double
  ret double %t129
merge21:
  %t130 = load i8*, i8** %l0
  %t131 = call double @sailfin_runtime_char_code(i8* %t130)
  ret double %t131
}

define double @grapheme_count(i8* %text) {
block.entry:
  %t0 = call double @sailfin_runtime_grapheme_count(i8* %text)
  ret double %t0
}

define i8* @grapheme_at(i8* %text, double %index) {
block.entry:
  %t0 = call i8* @sailfin_runtime_grapheme_at(i8* %text, double %index)
  call void @sailfin_runtime_mark_persistent(i8* %t0)
  ret i8* %t0
}

define private double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.len6.h807326654 = private unnamed_addr constant [7 x i8] c"number\00"
@.str.len3.h2090260294 = private unnamed_addr constant [4 x i8] c"fn(\00"
@.str.len6.h789270767 = private unnamed_addr constant [7 x i8] c"string\00"
@.str.len4.h278197661 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len8.h2085806430 = private unnamed_addr constant [9 x i8] c"runtime.\00"
@.str.len7.h1483009776 = private unnamed_addr constant [8 x i8] c"boolean\00"
@.str.len2.h193495007 = external constant [3 x i8]
@.enum.Expression.Array.variant = external constant [6 x i8]
@.enum.Statement.ImportDeclaration.variant = external constant [18 x i8]
@.str.len5.h2095430042 = external constant [6 x i8]
@.enum.Statement.EnumDeclaration.variant = external constant [16 x i8]
@.enum.Statement.ReturnStatement.variant = external constant [16 x i8]
@.str.len19.h486335986 = external constant [20 x i8]
@.enum.Statement.Unknown.variant = external constant [8 x i8]
@.str.len13.h1570408460 = external constant [14 x i8]
@.enum.Statement.ContinueStatement.variant = external constant [18 x i8]
@.enum.Statement.MatchStatement.variant = external constant [15 x i8]
@.str.len4.h275946731 = external constant [5 x i8]
@.enum.Statement.BreakStatement.variant = external constant [15 x i8]
@.enum.Statement.variant.default = external constant [1 x i8]
@.enum.Statement.TypeAliasDeclaration.variant = external constant [21 x i8]
@.enum.Expression.Object.variant = external constant [7 x i8]
@.enum.Statement.FunctionDeclaration.variant = external constant [20 x i8]
@.enum.Statement.VariableDeclaration.variant = external constant [20 x i8]
@.enum.Statement.ToolDeclaration.variant = external constant [16 x i8]
@.enum.Statement.ExpressionStatement.variant = external constant [20 x i8]
@.str.len5.h515589823 = external constant [6 x i8]
@.enum.Statement.WithStatement.variant = external constant [14 x i8]
@.str.len3.h2089530004 = external constant [4 x i8]
@.enum.Expression.variant.default = external constant [1 x i8]
@.enum.Expression.Range.variant = external constant [6 x i8]
@.str.len11.h1571993816 = external constant [12 x i8]
@.enum.Expression.StringLiteral.variant = external constant [14 x i8]
@.str.len13.h590768815 = external constant [14 x i8]
@.enum.Expression.Binary.variant = external constant [7 x i8]
@.str.len14.h1318614710 = external constant [15 x i8]
@.enum.Expression.Call.variant = external constant [5 x i8]
@.enum.Statement.StructDeclaration.variant = external constant [18 x i8]
@.enum.Expression.BooleanLiteral.variant = external constant [15 x i8]
@.enum.Statement.InterfaceDeclaration.variant = external constant [21 x i8]
@.enum.Expression.Identifier.variant = external constant [11 x i8]
@.str.len17.h1842783069 = external constant [18 x i8]
@.enum.Statement.ExportDeclaration.variant = external constant [18 x i8]
@.enum.Expression.Unary.variant = external constant [6 x i8]
@.enum.Statement.PipelineDeclaration.variant = external constant [20 x i8]
@.enum.Expression.Index.variant = external constant [6 x i8]
@.enum.Statement.TestDeclaration.variant = external constant [16 x i8]
@.enum.Statement.ForStatement.variant = external constant [13 x i8]
@.enum.Statement.LoopStatement.variant = external constant [14 x i8]
@.enum.Expression.Member.variant = external constant [7 x i8]
@.enum.Expression.NumberLiteral.variant = external constant [14 x i8]
@.enum.Statement.PromptStatement.variant = external constant [16 x i8]
@.enum.Expression.Lambda.variant = external constant [7 x i8]
@.str.len12.h1170311443 = external constant [13 x i8]
@.enum.Expression.Struct.variant = external constant [7 x i8]
@.enum.Expression.Raw.variant = external constant [4 x i8]
@.enum.Statement.IfStatement.variant = external constant [12 x i8]
@.enum.Statement.ModelDeclaration.variant = external constant [17 x i8]
@.enum.Expression.NullLiteral.variant = external constant [12 x i8]
@.str.len12.h1147459442 = external constant [13 x i8]
@.str.len2.h193491872 = external constant [3 x i8]
@.str.len23.h509166939 = external constant [24 x i8]
@.str.len5.h359348221 = external constant [6 x i8]
@.str.len18.h166827074 = external constant [19 x i8]
@.str.len7.h1121316919 = external constant [8 x i8]
@.str.len20.h1840566713 = external constant [21 x i8]
@.str.len4.h261786827 = external constant [5 x i8]
@.str.len3.h2090540497 = external constant [4 x i8]
@.str.len17.h959371065 = external constant [18 x i8]
@.str.len9.h6052019 = external constant [10 x i8]
@.str.len22.h857956175 = external constant [23 x i8]
@.str.len5.h474104665 = external constant [6 x i8]
@.str.len10.h1970595328 = external constant [11 x i8]
@.str.len5.h461669077 = external constant [6 x i8]
@.str.len10.h1681046972 = external constant [11 x i8]
@.str.len5.h469485193 = external constant [6 x i8]
@.str.len5.h1991159579 = external constant [6 x i8]
@.str.len10.h881761880 = external constant [11 x i8]
@.enum.TokenKind.variant.default = external constant [1 x i8]
@.enum.TokenKind.Identifier.variant = external constant [11 x i8]
@.enum.TokenKind.NumberLiteral.variant = external constant [14 x i8]
@.enum.TokenKind.StringLiteral.variant = external constant [14 x i8]
@.enum.TokenKind.BooleanLiteral.variant = external constant [15 x i8]
@.enum.TokenKind.Symbol.variant = external constant [7 x i8]
@.enum.TokenKind.Whitespace.variant = external constant [11 x i8]
@.enum.TokenKind.Comment.variant = external constant [8 x i8]
@.enum.TokenKind.EndOfFile.variant = external constant [10 x i8]
@.str.len10.h715288307 = external constant [11 x i8]
@.str.len7.h936649884 = external constant [8 x i8]
@.str.len5.h1312780988 = external constant [6 x i8]
@.str.len5.h975618503 = external constant [6 x i8]
@.str.len4.h217216103 = external constant [5 x i8]
@.str.len13.h1925822000 = external constant [14 x i8]
@.str.len5.h238194529 = external constant [6 x i8]
@.str.len7.h48777630 = external constant [8 x i8]
@.str.len8.h196867800 = external constant [9 x i8]
@.str.len5.h667777838 = external constant [6 x i8]
@.str.len12.h10983220 = external constant [13 x i8]
@.str.len19.h1204027478 = external constant [20 x i8]
@.str.len15.h1067284810 = external constant [16 x i8]
@.str.len10.h1576352120 = external constant [11 x i8]
@.str.len19.h868168677 = external constant [20 x i8]
@.str.len7.h721793546 = external constant [8 x i8]
@.str.len6.h453982107 = external constant [7 x i8]
@.str.len5.h500835952 = external constant [6 x i8]
@.str.len16.h2043328844 = external constant [17 x i8]
@.str.len6.h1211862785 = external constant [7 x i8]
@.str.len19.h479148896 = external constant [20 x i8]
@.str.len15.h571715647 = external constant [16 x i8]
@.str.len6.h512390329 = external constant [7 x i8]
@.str.len12.h84042670 = external constant [13 x i8]
@.str.len6.h826984377 = external constant [7 x i8]
@.str.len6.h264904746 = external constant [7 x i8]
@.str.len11.h1566780570 = external constant [12 x i8]
@.str.len15.h1613933868 = external constant [16 x i8]
@.str.len13.h1678412334 = external constant [14 x i8]
@.str.len5.h512542702 = external constant [6 x i8]
@.str.len14.h196308685 = external constant [15 x i8]
@.str.len15.h889179835 = external constant [16 x i8]
@.str.len6.h1496334143 = external constant [7 x i8]
@.str.len6.h1128151960 = external constant [7 x i8]
@.str.len9.h1700456022 = external constant [10 x i8]
@.str.len5.h1445149598 = external constant [6 x i8]
@.str.len26.h177352073 = external constant [27 x i8]
@.str.len12.h76426699 = external constant [13 x i8]
@.str.len14.h330693139 = external constant [15 x i8]
@.str.len19.h1782433603 = external constant [20 x i8]
@.str.len39.h1281499904 = external constant [40 x i8]
@.str.len4.h175713983 = external constant [5 x i8]
@.str.len6.h1830497006 = external constant [7 x i8]
@.str.len11.h1513373193 = external constant [12 x i8]
@.str.len3.h2087687812 = external constant [4 x i8]
@.str.len3.h2087691079 = external constant [4 x i8]
@.str.len5.h2064124065 = external constant [6 x i8]
@.str.len4.h192491117 = external constant [5 x i8]
@.str.len6.h1280331335 = external constant [7 x i8]
@.str.len10.h730819012 = external constant [11 x i8]
@.str.len12.h1355144398 = external constant [13 x i8]
@.str.len6.h1868947418 = external constant [7 x i8]
@.str.len8.h580693660 = external constant [9 x i8]
@.str.len6.h1857240668 = external constant [7 x i8]
@.str.len8.h580338910 = external constant [9 x i8]
@.str.len7.h1082168422 = external constant [8 x i8]
@.str.len9.h1708674232 = external constant [10 x i8]
@.str.len6.h1880834942 = external constant [7 x i8]
@.str.len11.h599952843 = external constant [12 x i8]
@.str.len13.h1382830532 = external constant [14 x i8]
@.str.len6.h1280947313 = external constant [7 x i8]
@.str.len8.h562875475 = external constant [9 x i8]
@.str.len8.h2093451461 = external constant [9 x i8]
@.str.len10.h2070880298 = external constant [11 x i8]
@.str.len8.h1951948513 = external constant [9 x i8]
@.str.len10.h179409731 = external constant [11 x i8]
@.str.len8.h377779046 = external constant [9 x i8]
@.str.len10.h261858150 = external constant [11 x i8]
@.str.len6.h1979413400 = external constant [7 x i8]
@.str.len8.h584041114 = external constant [9 x i8]
@.str.len5.h2057365731 = external constant [6 x i8]
@.str.len4.h175996034 = external constant [5 x i8]
@.str.len7.h1448749422 = external constant [8 x i8]
@.str.len5.h2064480630 = external constant [6 x i8]
@.str.len8.h571206424 = external constant [9 x i8]
@.str.len7.h553171426 = external constant [8 x i8]
@.str.len9.h1692644020 = external constant [10 x i8]
@.str.len4.h174362534 = external constant [5 x i8]
@.str.len4.h175987322 = external constant [5 x i8]
@.str.len4.h192590216 = external constant [5 x i8]
@.str.len6.h1280334338 = external constant [7 x i8]
@.str.len5.h2056075365 = external constant [6 x i8]
@.str.len4.h273104342 = external constant [5 x i8]
@.str.len5.h2080793783 = external constant [6 x i8]
@.str.len4.h173787542 = external constant [5 x i8]
@.str.len3.h2087758597 = external constant [4 x i8]
@.str.len2.h193442306 = external constant [3 x i8]
@.str.len2.h193415972 = external constant [3 x i8]
@.str.len6.h789690461 = external constant [7 x i8]
@.str.len20.h239636501 = external constant [21 x i8]
@.str.len6.h922402750 = external constant [7 x i8]
@.str.len7.h847788946 = external constant [8 x i8]
@.str.len18.h548024877 = external constant [19 x i8]
@.str.len23.h1863896425 = external constant [24 x i8]
@.str.len11.h1741471221 = external constant [12 x i8]
@.str.len15.h1833630044 = external constant [16 x i8]
@.str.len2.h193415015 = external constant [3 x i8]
@.str.len9.h1449250559 = external constant [10 x i8]
@.str.len25.h9921935 = external constant [26 x i8]
@.str.len31.h2008080495 = external constant [32 x i8]
@.str.len5.h1407544976 = external constant [6 x i8]
@.str.len9.h341064397 = external constant [10 x i8]
@.str.len7.h576672325 = external constant [8 x i8]
@.str.len14.h1988247080 = external constant [15 x i8]
@.str.len13.h898775369 = external constant [14 x i8]
@.str.len5.h699691610 = external constant [6 x i8]
@.str.len10.h302043987 = external constant [11 x i8]
@.str.len10.h1629914700 = external constant [11 x i8]
@.str.len9.h1724213902 = external constant [10 x i8]
@.str.len10.h1381756460 = external constant [11 x i8]
@.str.len11.h259975568 = external constant [12 x i8]
@.str.len10.h83011545 = external constant [11 x i8]
@.str.len9.h355918296 = external constant [10 x i8]
@.str.len9.h1057071035 = external constant [10 x i8]
@.str.len13.h2110552132 = external constant [14 x i8]
@.str.len16.h198095254 = external constant [17 x i8]
@.str.len17.h152073561 = external constant [18 x i8]
@.str.len11.h1508055514 = external constant [12 x i8]
@.str.len17.h2121470532 = external constant [18 x i8]
@.str.len9.h1902764570 = external constant [10 x i8]
@.str.len17.h1620510857 = external constant [18 x i8]
@.str.len14.h1192169574 = external constant [15 x i8]
@.str.len9.h204830940 = external constant [10 x i8]
@.str.len9.h711382918 = external constant [10 x i8]
@.str.len21.h1969606825 = external constant [22 x i8]
@.str.len8.h364122910 = external constant [9 x i8]
@.str.len12.h300877395 = external constant [13 x i8]
@.str.len11.h575661041 = external constant [12 x i8]
@.str.len14.h237087299 = external constant [15 x i8]
@.str.len10.h1720834339 = external constant [11 x i8]
@.str.len25.h403645876 = external constant [26 x i8]
@.str.len19.h2048588885 = external constant [20 x i8]
@.str.len22.h401021290 = external constant [23 x i8]
@.str.len23.h668778749 = external constant [24 x i8]
@.str.len14.h1053492670 = external constant [15 x i8]
@.str.len2.h193480817 = external constant [3 x i8]
@.str.len5.h1958778164 = external constant [6 x i8]
@.str.len3.h2090370613 = external constant [4 x i8]
@.str.len2.h193428611 = external constant [3 x i8]
@.str.len6.h980153509 = external constant [7 x i8]
@.str.len15.h1897143060 = external constant [16 x i8]
@.str.len10.h381722796 = external constant [11 x i8]
@.str.len9.h1814778076 = external constant [10 x i8]
@.str.len12.h2084565287 = external constant [13 x i8]
@.str.len2.h193478309 = external constant [3 x i8]
@.str.len17.h1970266448 = external constant [18 x i8]
@.str.len17.h1813262795 = external constant [18 x i8]
@.str.len13.h1610966039 = external constant [14 x i8]
@.str.len7.h513898090 = external constant [8 x i8]
@.str.len16.h1695010494 = external constant [17 x i8]
@.str.len4.h173287691 = external constant [5 x i8]
@.str.len16.h1290415774 = external constant [17 x i8]
@.str.len3.h2090684245 = external constant [4 x i8]
@.str.len14.h88846349 = external constant [15 x i8]
@.str.len4.h254486039 = external constant [5 x i8]
@.str.len4.h268717223 = external constant [5 x i8]
@.str.len3.h2090307517 = external constant [4 x i8]
@.str.len2.h193441217 = external constant [3 x i8]
@.str.len6.h1134498859 = external constant [7 x i8]
@.str.len17.h1998778048 = external constant [18 x i8]
@.str.len18.h1250048525 = external constant [19 x i8]
@.str.len6.h1061063223 = external constant [7 x i8]
@.str.len20.h666604742 = external constant [21 x i8]
@.str.len20.h1496093543 = external constant [21 x i8]
@.str.len7.h655348872 = external constant [8 x i8]
@.str.len11.h1482555192 = external constant [12 x i8]
@.str.len14.h110444378 = external constant [15 x i8]
@.str.len3.h2090083282 = external constant [4 x i8]
@.str.len70.h1478160845 = external constant [71 x i8]
@.str.len9.h1091414306 = external constant [10 x i8]
@.str.len3.h2087662534 = external constant [4 x i8]
@.str.len3.h2090304184 = external constant [4 x i8]
@.str.len2.h193480223 = external constant [3 x i8]
@.str.len17.h689147423 = external constant [18 x i8]
@.str.len2.h193492961 = external constant [3 x i8]
@.str.len7.h130169768 = external constant [8 x i8]
@.str.len5.h2072555103 = external constant [6 x i8]
@.str.len6.h1187178968 = external constant [7 x i8]
@.str.len2.h193481015 = external constant [3 x i8]
@.str.len7.h398443637 = external constant [8 x i8]
@.str.len4.h268929446 = external constant [5 x i8]
@.str.len15.h579804543 = external constant [16 x i8]
@.str.len5.h1525558983 = external constant [6 x i8]
@.str.len8.h455185518 = external constant [9 x i8]
@.str.len5.h500836810 = external constant [6 x i8]
@.str.len8.h528348603 = external constant [9 x i8]
@.str.len8.h573909064 = external constant [9 x i8]
@.str.len4.h267749729 = external constant [5 x i8]
@.str.len2.h193480949 = external constant [3 x i8]
@.str.len55.h700951597 = external constant [56 x i8]
@.str.len9.h1311191977 = external constant [10 x i8]
@.str.len2.h193512002 = external constant [3 x i8]
@.str.len43.h954579443 = external constant [44 x i8]
@.str.len147.h822490736 = external constant [148 x i8]
@.str.len32.h1114844469 = external constant [33 x i8]
@.str.len9.h727869092 = external constant [10 x i8]
@.str.len9.h1115535080 = external constant [10 x i8]
@.str.len9.h479184799 = external constant [10 x i8]
@.str.len4.h265988816 = external constant [5 x i8]
@.str.len6.h1417969413 = external constant [7 x i8]
@.str.len5.h524430226 = external constant [6 x i8]
@.str.len10.h385719500 = external constant [11 x i8]
@.str.len5.h2072026244 = external constant [6 x i8]
@.str.len7.h289982314 = external constant [8 x i8]
@.str.len38.h803093750 = external constant [39 x i8]
@.str.len5.h623008684 = external constant [6 x i8]
@.str.len3.h2090359129 = external constant [4 x i8]
@.str.len4.h257940116 = external constant [5 x i8]
@.str.len4.h259230482 = external constant [5 x i8]
@.str.len6.h888972417 = external constant [7 x i8]
@.str.len5.h1978257899 = external constant [6 x i8]
@.str.len2.h193491707 = external constant [3 x i8]
@.str.len2.h193415939 = external constant [3 x i8]
@.str.len3.h2090260030 = external constant [4 x i8]
@.str.len2.h193511276 = external constant [3 x i8]
@.str.len2.h193392014 = external constant [3 x i8]
@.str.len39.h1477088561 = external constant [40 x i8]
@.str.len13.h1882501715 = external constant [14 x i8]
@.str.len7.h655349763 = external constant [8 x i8]
@.str.len8.h476784883 = external constant [9 x i8]
@.str.len8.h2003786807 = external constant [9 x i8]
@.str.len13.h1853304565 = external constant [14 x i8]
@.str.len4.h275832617 = external constant [5 x i8]
@.str.len5.h1459000260 = external constant [6 x i8]
@.str.len15.h306395716 = external constant [16 x i8]
@.str.len19.h965279776 = external constant [20 x i8]
@.str.len2.h193428050 = external constant [3 x i8]
@.str.len2.h193445474 = external constant [3 x i8]
@.str.len2.h193445441 = external constant [3 x i8]
@.str.len2.h193414949 = external constant [3 x i8]
@.str.len2.h193444352 = external constant [3 x i8]
@.str.len2.h193446530 = external constant [3 x i8]
@.str.len2.h193419635 = external constant [3 x i8]
@.str.len2.h193516127 = external constant [3 x i8]
@.str.len16.h385769534 = external constant [17 x i8]
@.str.len12.h1402485025 = external constant [13 x i8]
@.str.len11.h1801723778 = external constant [12 x i8]
@.str.len9.h507529196 = external constant [10 x i8]
@.str.len3.h2087759686 = external constant [4 x i8]
@.str.len25.h111080155 = external constant [26 x i8]
@.str.len12.h1175821684 = external constant [13 x i8]
@.str.len14.h2048158982 = external constant [15 x i8]
@.str.len14.h129277126 = external constant [15 x i8]
@.str.len85.h1706301526 = external constant [86 x i8]
@.str.len38.h1073483005 = external constant [39 x i8]
@.str.len23.h2110906862 = external constant [24 x i8]
@.str.len31.h76517386 = external constant [32 x i8]
@.str.len21.h1300292754 = external constant [22 x i8]
@.str.len16.h1337894058 = external constant [17 x i8]
@.str.len39.h459555839 = external constant [40 x i8]
@.str.len35.h1158922578 = external constant [36 x i8]
@.str.len5.h1516228563 = external constant [6 x i8]
@.str.len5.h655249917 = external constant [6 x i8]
@.str.len5.h1517989476 = external constant [6 x i8]
@.str.len9.h2073631692 = external constant [10 x i8]
@.str.len38.h675779786 = external constant [39 x i8]
@.str.len20.h1216366549 = external constant [21 x i8]
@.str.len32.h1767333123 = external constant [33 x i8]
@.str.len39.h943297157 = external constant [40 x i8]
@.str.len37.h2038142650 = external constant [38 x i8]
@.enum.NativeInstruction.Case.variant = external constant [5 x i8]
@.str.len33.h1023685264 = external constant [34 x i8]
@.str.len4.h275319236 = external constant [5 x i8]
@.str.len5.h466680424 = external constant [6 x i8]
@.str.len41.h1384306956 = external constant [42 x i8]
@.str.len9.h1228988541 = external constant [10 x i8]
@.str.len9.h1171237782 = external constant [10 x i8]
@.str.len28.h1471254674 = external constant [29 x i8]
@.str.len15.h87749209 = external constant [16 x i8]
@.str.len8.h787332764 = external constant [9 x i8]
@.str.len30.h829706524 = external constant [31 x i8]
@.str.len17.h1973869273 = external constant [18 x i8]
@.str.len10.h469410318 = external constant [11 x i8]
@.str.len33.h1132321576 = external constant [34 x i8]
@.str.len48.h807033739 = external constant [49 x i8]
@.enum.NativeInstruction.EndMatch.variant = external constant [9 x i8]
@.enum.NativeInstruction.Break.variant = external constant [6 x i8]
@.str.len33.h1134984829 = external constant [34 x i8]
@.enum.NativeInstruction.Continue.variant = external constant [9 x i8]
@.str.len40.h318366654 = external constant [41 x i8]
@.enum.NativeInstruction.Match.variant = external constant [6 x i8]
@.enum.NativeInstruction.Loop.variant = external constant [5 x i8]
@.str.len29.h555082439 = external constant [30 x i8]
@.str.len35.h2058816325 = external constant [36 x i8]
@.str.len38.h1235260132 = external constant [39 x i8]
@.str.len18.h1997941781 = external constant [19 x i8]
@.str.len31.h1868156648 = external constant [32 x i8]
@.str.len6.h483393773 = external constant [7 x i8]
@.enum.NativeInstruction.EndLoop.variant = external constant [8 x i8]
@.str.len8.h1370870284 = external constant [9 x i8]
@.str.len10.h1219235236 = external constant [11 x i8]
@.str.len22.h625556084 = external constant [23 x i8]
@.str.len37.h1152036459 = external constant [38 x i8]
@.str.len33.h712498791 = external constant [34 x i8]
@.str.len21.h1187531435 = external constant [22 x i8]
@.str.len19.h879467198 = external constant [20 x i8]
@.str.len35.h546841458 = external constant [36 x i8]
@.str.len8.h1521657554 = external constant [9 x i8]
@.str.len17.h293109504 = external constant [18 x i8]
@.str.len3.h2089318639 = external constant [4 x i8]
@.str.len5.h1783417286 = external constant [6 x i8]
@.str.len31.h329133056 = external constant [32 x i8]
@.str.len34.h654371835 = external constant [35 x i8]
@.str.len24.h1881287894 = external constant [25 x i8]
@.str.len20.h151690315 = external constant [21 x i8]
@.str.len44.h1623843 = external constant [45 x i8]
@.str.len37.h1581468287 = external constant [38 x i8]
@.str.len20.h1568429285 = external constant [21 x i8]
@.str.len34.h183092327 = external constant [35 x i8]
@.enum.NativeInstruction.Return.variant = external constant [7 x i8]
@.str.len39.h598838653 = external constant [40 x i8]
@.enum.NativeInstruction.EndFor.variant = external constant [7 x i8]
@.str.len28.h1605654048 = external constant [29 x i8]
@.str.len6.h1583308163 = external constant [7 x i8]
@.str.len31.h1924917952 = external constant [32 x i8]
@.str.len27.h237652301 = external constant [28 x i8]
@.str.len41.h35508704 = external constant [42 x i8]
@.str.len34.h1377481172 = external constant [35 x i8]
@.str.len24.h457168017 = external constant [25 x i8]
@.enum.NativeInstruction.variant.default = external constant [1 x i8]
@.str.len29.h668562564 = external constant [30 x i8]
@.enum.NativeInstruction.Else.variant = external constant [5 x i8]
@.str.len6.h42978514 = external constant [7 x i8]
@.str.len11.h908744813 = external constant [12 x i8]
@.str.len23.h1564009733 = external constant [24 x i8]
@.str.len43.h1714227133 = external constant [44 x i8]
@.str.len31.h1478667446 = external constant [32 x i8]
@.str.len21.h2112628887 = external constant [22 x i8]
@.str.len34.h1211676914 = external constant [35 x i8]
@.str.len31.h762677253 = external constant [32 x i8]
@.str.len13.h259593098 = external constant [14 x i8]
@.str.len36.h414094739 = external constant [37 x i8]
@.str.len22.h24304067 = external constant [23 x i8]
@.str.len31.h755263238 = external constant [32 x i8]
@.enum.NativeInstruction.Unknown.variant = external constant [8 x i8]
@.enum.NativeInstruction.Let.variant = external constant [4 x i8]
@.str.len42.h1171387022 = external constant [43 x i8]
@.str.len31.h1960327680 = external constant [32 x i8]
@.str.len19.h1697653870 = external constant [20 x i8]
@.str.len29.h1601547567 = external constant [30 x i8]
@.enum.NativeInstruction.For.variant = external constant [4 x i8]
@.str.len30.h208276320 = external constant [31 x i8]
@.str.len20.h608364678 = external constant [21 x i8]
@.str.len9.h890937508 = external constant [10 x i8]
@.str.len32.h1822658020 = external constant [33 x i8]
@.str.len8.h1926252274 = external constant [9 x i8]
@.str.len41.h1415177535 = external constant [42 x i8]
@.str.len46.h1830585629 = external constant [47 x i8]
@.str.len8.h1074277327 = external constant [9 x i8]
@.str.len8.h575595345 = external constant [9 x i8]
@.str.len8.h1616485352 = external constant [9 x i8]
@.str.len5.h261048910 = external constant [6 x i8]
@.str.len26.h1834305347 = external constant [27 x i8]
@.str.len6.h841337749 = external constant [7 x i8]
@.str.len8.h487238491 = external constant [9 x i8]
@.str.len31.h238974215 = external constant [32 x i8]
@.str.len42.h1518215675 = external constant [43 x i8]
@.str.len57.h1118233133 = external constant [58 x i8]
@.str.len25.h378946335 = external constant [26 x i8]
@.str.len7.h725262232 = external constant [8 x i8]
@.str.len6.h734244628 = external constant [7 x i8]
@.str.len32.h1189086491 = external constant [33 x i8]
@.str.len7.h242296049 = external constant [8 x i8]
@.str.len15.h506269955 = external constant [16 x i8]
@.str.len4.h268715771 = external constant [5 x i8]
@.str.len36.h736848621 = external constant [37 x i8]
@.str.len41.h881857818 = external constant [42 x i8]
@.str.len42.h930606274 = external constant [43 x i8]
@.str.len39.h1399971520 = external constant [40 x i8]
@.str.len40.h1650449248 = external constant [41 x i8]
@.str.len5.h524431183 = external constant [6 x i8]
@.str.len47.h1886628617 = external constant [48 x i8]
@.str.len40.h1512965366 = external constant [41 x i8]
@.str.len14.h1219450488 = external constant [15 x i8]
@.str.len29.h128952257 = external constant [30 x i8]
@.str.len48.h235936117 = external constant [49 x i8]
@.str.len34.h805939531 = external constant [35 x i8]
@.str.len41.h2069276858 = external constant [42 x i8]
@.str.len22.h496289716 = external constant [23 x i8]
@.str.len38.h2050661185 = external constant [39 x i8]
@.enum.NativeInstruction.Noop.variant = external constant [5 x i8]
@.str.len12.h841153022 = external constant [13 x i8]
@.enum.NativeInstruction.If.variant = external constant [3 x i8]
@.str.len28.h497146076 = external constant [29 x i8]
@.enum.NativeInstruction.Expression.variant = external constant [11 x i8]
@.str.len44.h1730891783 = external constant [45 x i8]
@.str.len21.h1297227834 = external constant [22 x i8]
@.str.len26.h130324785 = external constant [27 x i8]
@.str.len30.h211710404 = external constant [31 x i8]
@.str.len26.h1606904140 = external constant [27 x i8]
@.str.len30.h702899578 = external constant [31 x i8]
@.enum.NativeInstruction.EndIf.variant = external constant [6 x i8]
@.str.len9.h1123073249 = external constant [10 x i8]
@.str.len13.h1690231036 = external constant [14 x i8]
@.str.len16.h1302463873 = external constant [17 x i8]
@.str.len8.h950770765 = external constant [9 x i8]
@.str.len9.h1143812295 = external constant [10 x i8]
@.str.len13.h2017570205 = external constant [14 x i8]
@.str.len13.h1526968728 = external constant [14 x i8]
@.str.len20.h669184369 = external constant [21 x i8]
@.str.len15.h1006962406 = external constant [16 x i8]
@.str.len22.h245793879 = external constant [23 x i8]
@.str.len27.h1644152571 = external constant [28 x i8]
@.str.len32.h1338594357 = external constant [33 x i8]
@.str.len52.h1595292989 = external constant [53 x i8]
@.str.len49.h219094687 = external constant [50 x i8]
@.str.len3.h2090309365 = external constant [4 x i8]
@.str.len10.h836783004 = external constant [11 x i8]
@.str.len26.h314381046 = external constant [27 x i8]
@.str.len11.h1692672167 = external constant [12 x i8]
@.str.len27.h1633276217 = external constant [28 x i8]
@.str.len10.h852931752 = external constant [11 x i8]
@.str.len26.h330529794 = external constant [27 x i8]
@.str.len12.h171100416 = external constant [13 x i8]
@.str.len26.h1917791739 = external constant [27 x i8]
@.str.len11.h590971052 = external constant [12 x i8]
@.str.len13.h1199983169 = external constant [14 x i8]
@.str.len7.h692832590 = external constant [8 x i8]
@.str.len25.h1361515669 = external constant [26 x i8]
@.str.len7.h639792804 = external constant [8 x i8]
@.str.len25.h1078626493 = external constant [26 x i8]
@.str.len8.h1997211677 = external constant [9 x i8]
@.str.len26.h1446337309 = external constant [27 x i8]
@.str.len9.h2094168902 = external constant [10 x i8]
@.str.len27.h1095183358 = external constant [28 x i8]
@.str.len12.h1904553766 = external constant [13 x i8]
@.str.len30.h696431873 = external constant [31 x i8]
@.str.len11.h1619400233 = external constant [12 x i8]
@.str.len29.h1322489448 = external constant [30 x i8]
@.str.len8.h1133407189 = external constant [9 x i8]
@.str.len26.h1783221879 = external constant [27 x i8]
@.str.len9.h906250381 = external constant [10 x i8]
@.str.len27.h875298105 = external constant [28 x i8]
@.str.len21.h1185142538 = external constant [22 x i8]
@.str.len6.h552231050 = external constant [7 x i8]
@.str.len16.h1418247987 = external constant [17 x i8]
@.str.len18.h601837497 = external constant [19 x i8]
@.str.len23.h2117993764 = external constant [24 x i8]
@.str.len16.h2071972432 = external constant [17 x i8]
@.str.len21.h1189762010 = external constant [22 x i8]
@.str.len19.h366678430 = external constant [20 x i8]
@.str.len24.h950943994 = external constant [25 x i8]
@.str.len31.h1244627921 = external constant [32 x i8]
@.str.len39.h1419877841 = external constant [40 x i8]
@.str.len32.h1789614400 = external constant [33 x i8]
@.str.len40.h1130410563 = external constant [41 x i8]
@.str.len26.h1479564441 = external constant [27 x i8]
@.str.len34.h406802473 = external constant [35 x i8]
@.str.len27.h1058577960 = external constant [28 x i8]
@.str.len35.h17171112 = external constant [36 x i8]
@.str.len24.h1580518212 = external constant [25 x i8]
@.str.len29.h1288226354 = external constant [30 x i8]
@.str.len26.h108256496 = external constant [27 x i8]
@.str.len31.h991041249 = external constant [32 x i8]
@.str.len28.h851722965 = external constant [29 x i8]
@.str.len33.h290979786 = external constant [34 x i8]
@.str.len20.h882242401 = external constant [21 x i8]
@.str.len25.h1454886232 = external constant [26 x i8]
@.str.len20.h1216592126 = external constant [21 x i8]
@.str.len25.h1472942119 = external constant [26 x i8]
@.str.len21.h2093836775 = external constant [22 x i8]
@.str.len26.h1973483043 = external constant [27 x i8]
@.str.len18.h1066963873 = external constant [19 x i8]
@.str.len23.h1383116374 = external constant [24 x i8]
@.str.len28.h316282295 = external constant [29 x i8]
@.str.len19.h416957735 = external constant [20 x i8]
@.str.len24.h1875205336 = external constant [25 x i8]
@.str.len22.h146500669 = external constant [23 x i8]
@.str.len27.h1265368617 = external constant [28 x i8]
@.str.len31.h675971098 = external constant [32 x i8]
@.str.len28.h491049688 = external constant [29 x i8]
@.str.len22.h1950641286 = external constant [23 x i8]
@.str.len27.h1119910773 = external constant [28 x i8]
@.str.len16.h1850845052 = external constant [17 x i8]
@.str.len21.h1177326422 = external constant [22 x i8]
@.str.len20.h1875832021 = external constant [21 x i8]
@.str.len25.h379468985 = external constant [26 x i8]
@.str.len12.h1759984849 = external constant [13 x i8]
@.str.len28.h927665198 = external constant [29 x i8]
@.str.len11.h1320812749 = external constant [12 x i8]
@.str.len13.h2058676657 = external constant [14 x i8]
@.str.len29.h361931426 = external constant [30 x i8]
@.str.len12.h470417016 = external constant [13 x i8]
@.str.len17.h683556580 = external constant [18 x i8]
@.str.len33.h2073113638 = external constant [34 x i8]
@.str.len16.h1874184589 = external constant [17 x i8]
@.str.len14.h475733264 = external constant [15 x i8]
@.str.len30.h317714951 = external constant [31 x i8]
@.str.len13.h1344565920 = external constant [14 x i8]
@.str.len19.h369389668 = external constant [20 x i8]
@.str.len35.h1768520934 = external constant [36 x i8]
@.str.len18.h345109591 = external constant [19 x i8]
@.str.len8.h1191517318 = external constant [9 x i8]
@.str.len24.h896322988 = external constant [25 x i8]
@.str.len9.h676400991 = external constant [10 x i8]
@.str.len25.h1672405824 = external constant [26 x i8]
@.str.len24.h1636164376 = external constant [25 x i8]
@.str.len40.h627283615 = external constant [41 x i8]
@.str.len11.h46392238 = external constant [12 x i8]
@.str.len27.h216396232 = external constant [28 x i8]
@.str.len22.h1459662539 = external constant [23 x i8]
@.str.len38.h857282947 = external constant [39 x i8]
@.str.len10.h161326040 = external constant [11 x i8]
@.str.len26.h817230312 = external constant [27 x i8]
@.str.len14.h567231592 = external constant [15 x i8]
@.str.len30.h409213279 = external constant [31 x i8]
@.str.len12.h1925940597 = external constant [13 x i8]
@.str.len28.h1093620946 = external constant [29 x i8]
@.str.len7.h156242681 = external constant [8 x i8]
@.str.len15.h1182175778 = external constant [16 x i8]
@.str.len31.h262538231 = external constant [32 x i8]
@.str.len20.h110815000 = external constant [21 x i8]
@.str.len25.h1803725537 = external constant [26 x i8]
@.str.len23.h1548209921 = external constant [24 x i8]
@.str.len28.h699604432 = external constant [29 x i8]
@.str.len23.h539936938 = external constant [24 x i8]
@.str.len28.h998838921 = external constant [29 x i8]
@.str.len9.h1152401931 = external constant [10 x i8]
@.str.len25.h753085145 = external constant [26 x i8]
@.str.len13.h364690157 = external constant [14 x i8]
@.str.len29.h1932015666 = external constant [30 x i8]
@.str.len29.h1437412067 = external constant [30 x i8]
@.str.len9.h778785771 = external constant [10 x i8]
@.str.len25.h1258284707 = external constant [26 x i8]
@.str.len30.h213406005 = external constant [31 x i8]
@.str.len22.h1845927258 = external constant [23 x i8]
@.str.len27.h826800274 = external constant [28 x i8]
@.str.len18.h502407246 = external constant [19 x i8]
@.str.len34.h450484117 = external constant [35 x i8]
@.str.len2.h193493192 = external constant [3 x i8]
@.str.len16.h1418117008 = external constant [17 x i8]
@.str.len32.h2045158233 = external constant [33 x i8]
@.str.len13.h1820730605 = external constant [14 x i8]
@.str.len29.h290971478 = external constant [30 x i8]
@.str.len13.h693205632 = external constant [14 x i8]
@.str.len29.h1310930152 = external constant [30 x i8]
@.str.len14.h1222440456 = external constant [15 x i8]
@.str.len6.h1399969734 = external constant [7 x i8]
@.str.len22.h1394341490 = external constant [23 x i8]
@.str.len10.h1604472959 = external constant [11 x i8]
@.str.len26.h1311920391 = external constant [27 x i8]
@.str.len25.h744495509 = external constant [26 x i8]
@.str.len31.h1546565767 = external constant [32 x i8]
@.str.len11.h1272214119 = external constant [12 x i8]
@.str.len7.h435320957 = external constant [8 x i8]
@.str.len2.h193413959 = external constant [3 x i8]
@.str.len3.h2087985934 = external constant [4 x i8]
@.str.len11.h1643364430 = external constant [12 x i8]
@.str.len9.h1635442161 = external constant [10 x i8]
@.str.len10.h657805353 = external constant [11 x i8]
@.str.len9.h176122555 = external constant [10 x i8]
@.str.len12.h713829895 = external constant [13 x i8]
@.str.len2.h193412903 = external constant [3 x i8]
@.str.len17.h1272356829 = external constant [18 x i8]
@.str.len2.h193423793 = external constant [3 x i8]
@.str.len14.h407487675 = external constant [15 x i8]
@.str.len18.h350015562 = external constant [19 x i8]
@.str.len14.h407487642 = external constant [15 x i8]
@.str.len8.h2005760028 = external constant [9 x i8]
@.str.len3.h2090263825 = external constant [4 x i8]
@.str.len7.h263999893 = external constant [8 x i8]
@.str.len6.h984379249 = external constant [7 x i8]
@.str.len8.h330497730 = external constant [9 x i8]
@.str.len13.h1046883961 = external constant [14 x i8]
@.str.len20.h470548615 = external constant [21 x i8]
@.str.len10.h496967399 = external constant [11 x i8]
@.str.len8.h1005364959 = external constant [9 x i8]
@.str.len16.h1326167175 = external constant [17 x i8]
@.str.len8.h352907350 = external constant [9 x i8]
@.str.len9.h510295053 = external constant [10 x i8]
@.str.len6.h284380843 = external constant [7 x i8]
@.str.len11.h1336949530 = external constant [12 x i8]
@.str.len3.h2088091303 = external constant [4 x i8]
@.str.len12.h613760470 = external constant [13 x i8]
@.str.len7.h794644986 = external constant [8 x i8]
@.str.len10.h778637666 = external constant [11 x i8]
@.str.len43.h2036349551 = external constant [44 x i8]
@.str.len6.h870714978 = external constant [7 x i8]
@.str.len7.h781107057 = external constant [8 x i8]
@.str.len4.h275570234 = external constant [5 x i8]
@.str.len5.h226840384 = external constant [6 x i8]
@.str.len6.h1979066415 = external constant [7 x i8]
@.str.len9.h1714355238 = external constant [10 x i8]
@.str.len8.h1223304841 = external constant [9 x i8]
@.str.len22.h987750175 = external constant [23 x i8]
@.str.len8.h1554574248 = external constant [9 x i8]
@.str.len21.h2015594428 = external constant [22 x i8]
@.str.len12.h160623395 = external constant [13 x i8]
@.str.len7.h1794204779 = external constant [8 x i8]
@.str.len11.h1572253736 = external constant [12 x i8]
@.str.len32.h261520221 = external constant [33 x i8]
@.str.len15.h555306020 = external constant [16 x i8]
@.str.len4.h176392430 = external constant [5 x i8]
@.str.len11.h1291126021 = external constant [12 x i8]
@.str.len7.h1794206627 = external constant [8 x i8]
@.str.len44.h108508049 = external constant [45 x i8]
@.str.len6.h284441827 = external constant [7 x i8]
@.str.len13.h1547407540 = external constant [14 x i8]
@.str.len24.h1094741714 = external constant [25 x i8]
@.str.len2.h193425311 = external constant [3 x i8]
@.str.len3.h2088035368 = external constant [4 x i8]
@.str.len39.h1279329515 = external constant [40 x i8]
@.str.len34.h1466707734 = external constant [35 x i8]
@.str.len5.h1783136324 = external constant [6 x i8]
@.str.len2.h193413167 = external constant [3 x i8]
@.str.len13.h495159268 = external constant [14 x i8]
@.str.len13.h1151846959 = external constant [14 x i8]
@.str.len13.h570053065 = external constant [14 x i8]
@.str.len14.h951154942 = external constant [15 x i8]
@.str.len17.h290419238 = external constant [18 x i8]
@.str.len17.h1567313847 = external constant [18 x i8]
@.str.len3.h2087723749 = external constant [4 x i8]
@.str.len3.h2088090907 = external constant [4 x i8]
@.str.len6.h2133320393 = external constant [7 x i8]
@.str.len2.h193414916 = external constant [3 x i8]
@.str.len18.h1025837137 = external constant [19 x i8]
@.str.len18.h423592805 = external constant [19 x i8]
@.str.len22.h1888237794 = external constant [23 x i8]
@.str.len18.h265155188 = external constant [19 x i8]
@.str.len20.h2041297914 = external constant [21 x i8]
@.str.len17.h731464940 = external constant [18 x i8]
@.str.len17.h129220608 = external constant [18 x i8]
@.str.len21.h1103292538 = external constant [22 x i8]
@.str.len17.h2118266638 = external constant [18 x i8]
@.str.len19.h663429164 = external constant [20 x i8]
@.str.len8.h1637342616 = external constant [9 x i8]
@.str.len16.h277598141 = external constant [17 x i8]
@.str.len16.h846957918 = external constant [17 x i8]
@.str.len43.h1104894761 = external constant [44 x i8]
@.str.len26.h502342009 = external constant [27 x i8]
@.str.len6.h1030848604 = external constant [7 x i8]
@.str.len26.h1393897937 = external constant [27 x i8]
@.str.len53.h1321636270 = external constant [54 x i8]
@.str.len3.h2087755330 = external constant [4 x i8]
@.str.len15.h188153608 = external constant [16 x i8]
@.str.len3.h2088091270 = external constant [4 x i8]
@.str.len13.h1965171556 = external constant [14 x i8]
@.str.len13.h219049573 = external constant [14 x i8]
@.str.len5.h550091554 = external constant [6 x i8]
@.str.len10.h525812137 = external constant [11 x i8]
@.str.len49.h1998300429 = external constant [50 x i8]
@.str.len6.h883796046 = external constant [7 x i8]
@.str.len3.h2090071699 = external constant [4 x i8]
@.str.len2.h193421120 = external constant [3 x i8]
@.str.len2.h193420856 = external constant [3 x i8]
@.str.len15.h2103632386 = external constant [16 x i8]
@.str.len3.h2090260888 = external constant [4 x i8]
@.str.len2.h193442075 = external constant [3 x i8]
@.str.len2.h193428677 = external constant [3 x i8]
@.str.len9.h467830600 = external constant [10 x i8]
@.str.len2.h193430525 = external constant [3 x i8]
@.str.len4.h173295875 = external constant [5 x i8]
@.str.len2.h193421087 = external constant [3 x i8]
@.str.len8.h169883590 = external constant [9 x i8]
@.str.len32.h331553312 = external constant [33 x i8]
@.str.len32.h2027311032 = external constant [33 x i8]
@.str.len55.h1124826835 = external constant [56 x i8]
@.str.len19.h965756485 = external constant [20 x i8]
@.str.len43.h765759141 = external constant [44 x i8]
@.str.len40.h1941426741 = external constant [41 x i8]
@.str.len42.h514999820 = external constant [43 x i8]
@.str.len23.h1217803504 = external constant [24 x i8]
@.str.len6.h1894573333 = external constant [7 x i8]
@.str.len24.h1068290701 = external constant [25 x i8]
@.str.len5.h706445588 = external constant [6 x i8]
@.str.len8.h1809673500 = external constant [9 x i8]
@.str.len4.h259326677 = external constant [5 x i8]
@.str.len3.h2088178324 = external constant [4 x i8]
@.str.len41.h1217234939 = external constant [42 x i8]
@.str.len58.h821437208 = external constant [59 x i8]
@.str.len25.h1696931368 = external constant [26 x i8]
@.str.len49.h1794354414 = external constant [50 x i8]
@.str.len3.h2088031936 = external constant [4 x i8]
@.str.len52.h1115033155 = external constant [53 x i8]
@.str.len8.h1809667560 = external constant [9 x i8]
@.str.len7.h794634657 = external constant [8 x i8]
@.str.len50.h1873110523 = external constant [51 x i8]
@.str.len10.h1663630719 = external constant [11 x i8]
@.str.len65.h1008432364 = external constant [66 x i8]
@.str.len46.h440287758 = external constant [47 x i8]
@.str.len76.h547986414 = external constant [77 x i8]
@.str.len8.h1809744879 = external constant [9 x i8]
@.str.len49.h181712441 = external constant [50 x i8]
@.str.len79.h2027294639 = external constant [80 x i8]
@.str.len21.h799966347 = external constant [22 x i8]
@.str.len44.h288551526 = external constant [45 x i8]
@.str.len8.h3286201 = external constant [9 x i8]
@.str.len23.h301159061 = external constant [24 x i8]
@.str.len24.h1893561446 = external constant [25 x i8]
@.str.len47.h1472191274 = external constant [48 x i8]
@.str.len5.h335299934 = external constant [6 x i8]
@.str.len7.h770651283 = external constant [8 x i8]
@.str.len54.h1022899003 = external constant [55 x i8]
@.str.len31.h1428761244 = external constant [32 x i8]
@.str.len49.h893069065 = external constant [50 x i8]
@.str.len28.h1667882524 = external constant [29 x i8]
@.str.len7.h794634624 = external constant [8 x i8]
@.str.len4.h175715072 = external constant [5 x i8]
@.str.len54.h2016727512 = external constant [55 x i8]
@.str.len20.h819247583 = external constant [21 x i8]
@.str.len35.h364700043 = external constant [36 x i8]
@.str.len9.h2096692279 = external constant [10 x i8]
@.str.len3.h2089833967 = external constant [4 x i8]
@.str.len12.h340562855 = external constant [13 x i8]
@.str.len7.h1614723655 = external constant [8 x i8]
@.str.len32.h1899104257 = external constant [33 x i8]
@.str.len11.h1424822679 = external constant [12 x i8]
@.str.len56.h2066709411 = external constant [57 x i8]
@.str.len26.h549134517 = external constant [27 x i8]
@.str.len14.h1830305299 = external constant [15 x i8]
@.str.len26.h244643851 = external constant [27 x i8]
@.str.len52.h2121219822 = external constant [53 x i8]
@.str.len8.h241552292 = external constant [9 x i8]
@.str.len8.h241550015 = external constant [9 x i8]
@.str.len16.h2138981313 = external constant [17 x i8]
@.str.len4.h259164383 = external constant [5 x i8]
@.str.len10.h759000579 = external constant [11 x i8]
@.str.len39.h33026892 = external constant [40 x i8]
@.str.len36.h828265436 = external constant [37 x i8]
@.str.len3.h2089834231 = external constant [4 x i8]
@.str.len8.h2003785447 = external constant [9 x i8]
@.str.len7.h1755163029 = external constant [8 x i8]
@.str.len33.h1674155807 = external constant [34 x i8]
@.str.len50.h993566140 = external constant [51 x i8]
@.str.len15.h1475196437 = external constant [16 x i8]
@.str.len2.h193477154 = external constant [3 x i8]
@.str.len30.h766090624 = external constant [31 x i8]
@.str.len24.h442937996 = external constant [25 x i8]
@.str.len7.h973697423 = external constant [8 x i8]
@.str.len4.h274743650 = external constant [5 x i8]
@.str.len41.h637692462 = external constant [42 x i8]
@.str.len5.h199018843 = external constant [6 x i8]
@.str.len52.h39804487 = external constant [53 x i8]
@.str.len4.h258828212 = external constant [5 x i8]
@.str.len52.h1898023432 = external constant [53 x i8]
@.str.len53.h409079501 = external constant [54 x i8]
@.str.len43.h1628793500 = external constant [44 x i8]
@.str.len39.h1908765533 = external constant [40 x i8]
@.str.len21.h1816480386 = external constant [22 x i8]
@.str.len66.h2076742536 = external constant [67 x i8]
@.str.len53.h1441489102 = external constant [54 x i8]
@.str.len5.h819045845 = external constant [6 x i8]
@.str.len8.h1809739929 = external constant [9 x i8]
@.str.len24.h1530531128 = external constant [25 x i8]
@.str.len26.h1205961643 = external constant [27 x i8]
@.str.len15.h491517152 = external constant [16 x i8]
@.str.len48.h1275882625 = external constant [49 x i8]
@.str.len3.h2089835914 = external constant [4 x i8]
@.str.len4.h228395909 = external constant [5 x i8]
@.str.len3.h2090521720 = external constant [4 x i8]
@.str.len38.h1274232498 = external constant [39 x i8]
@.str.len42.h1364986286 = external constant [43 x i8]
@.str.len47.h1642247268 = external constant [48 x i8]
@.str.len10.h1616295671 = external constant [11 x i8]
@.str.len39.h176231850 = external constant [40 x i8]
@.str.len51.h577773560 = external constant [52 x i8]
@.str.len42.h78527754 = external constant [43 x i8]
@.str.len49.h640106322 = external constant [50 x i8]
@.str.len38.h1035741733 = external constant [39 x i8]
@.str.len44.h1827416098 = external constant [45 x i8]
@.str.len48.h37492210 = external constant [49 x i8]
@.str.len5.h459182890 = external constant [6 x i8]
@.str.len67.h1243369623 = external constant [68 x i8]
@.str.len6.h877543008 = external constant [7 x i8]
@.str.len40.h1596119513 = external constant [41 x i8]
@.str.len25.h1254414760 = external constant [26 x i8]
@.str.len47.h982576353 = external constant [48 x i8]
@.str.len26.h487122250 = external constant [27 x i8]
@.str.len30.h2098798495 = external constant [31 x i8]
@.str.len17.h1635915066 = external constant [18 x i8]
@.str.len35.h573475662 = external constant [36 x i8]
@.str.len9.h1747065903 = external constant [10 x i8]
@.str.len39.h2032947624 = external constant [40 x i8]
@.str.len33.h1240255260 = external constant [34 x i8]
@.str.len28.h379765914 = external constant [29 x i8]
@.str.len54.h280353426 = external constant [55 x i8]
@.str.len45.h313159578 = external constant [46 x i8]
@.str.len15.h1007423837 = external constant [16 x i8]
@.str.len58.h1022810589 = external constant [59 x i8]
@.str.len67.h845324059 = external constant [68 x i8]
@.str.len24.h91596683 = external constant [25 x i8]
@.str.len52.h432720005 = external constant [53 x i8]
@.str.len12.h35447896 = external constant [13 x i8]
@.str.len14.h1387946067 = external constant [15 x i8]
@.str.len51.h189411679 = external constant [52 x i8]
@.str.len51.h1154611981 = external constant [52 x i8]
@.str.len2.h193423034 = external constant [3 x i8]
@.str.len10.h634268966 = external constant [11 x i8]
@.str.len6.h536277508 = external constant [7 x i8]
@.str.len6.h78255107 = external constant [7 x i8]
@.str.len68.h1804274948 = external constant [69 x i8]
@.str.len6.h886311636 = external constant [7 x i8]
@.str.len4.h245035433 = external constant [5 x i8]
@.str.len21.h860019855 = external constant [22 x i8]
@.str.len30.h747463311 = external constant [31 x i8]
@.str.len40.h975266936 = external constant [41 x i8]
@.str.len8.h1607706290 = external constant [9 x i8]
@.str.len12.h1775642273 = external constant [13 x i8]
@.str.len30.h669837087 = external constant [31 x i8]
@.str.len26.h1631903096 = external constant [27 x i8]
@.str.len6.h1203620195 = external constant [7 x i8]
@.str.len40.h900070345 = external constant [41 x i8]
@.str.len13.h752234821 = external constant [14 x i8]
@.str.len6.h1526236955 = external constant [7 x i8]
@.str.len11.h1295974565 = external constant [12 x i8]
@.str.len12.h1804972052 = external constant [13 x i8]
@.str.len4.h259379675 = external constant [5 x i8]
@.str.len19.h129761630 = external constant [20 x i8]
@.str.len53.h1448111568 = external constant [54 x i8]
@.str.len69.h1474512693 = external constant [70 x i8]
@.str.len43.h372676400 = external constant [44 x i8]
@.str.len8.h183758879 = external constant [9 x i8]
@.str.len60.h1498420593 = external constant [61 x i8]
@.str.len40.h341281823 = external constant [41 x i8]
@.str.len15.h1036821136 = external constant [16 x i8]
@.str.len9.h1385528440 = external constant [10 x i8]
@.str.len5.h1925437637 = external constant [6 x i8]
@.str.len16.h1727760345 = external constant [17 x i8]
@.str.len60.h1664343531 = external constant [61 x i8]
@.str.len3.h2088029758 = external constant [4 x i8]
@.str.len18.h1107402921 = external constant [19 x i8]
@.str.len44.h1570405729 = external constant [45 x i8]
@.str.len3.h2088286201 = external constant [4 x i8]
@.str.len39.h1262256381 = external constant [40 x i8]
@.str.len43.h1411869975 = external constant [44 x i8]
@.str.len3.h2089834330 = external constant [4 x i8]
@.str.len57.h2014856169 = external constant [58 x i8]
@.str.len55.h522772778 = external constant [56 x i8]
@.str.len62.h41486523 = external constant [63 x i8]
@.str.len12.h1213469728 = external constant [13 x i8]
@.str.len48.h1606060438 = external constant [49 x i8]
@.str.len58.h583386627 = external constant [59 x i8]
@.str.len11.h1586125529 = external constant [12 x i8]
@.str.len40.h924126065 = external constant [41 x i8]
@.str.len4.h274245185 = external constant [5 x i8]
@.str.len41.h17849796 = external constant [42 x i8]
@.str.len34.h858864034 = external constant [35 x i8]
@.str.len14.h739705446 = external constant [15 x i8]
@.str.len7.h1558772342 = external constant [8 x i8]
@.str.len16.h1361993478 = external constant [17 x i8]
@.str.len55.h1292034827 = external constant [56 x i8]
@.str.len46.h964824710 = external constant [47 x i8]
@.str.len48.h1208326627 = external constant [49 x i8]
@.str.len18.h871374945 = external constant [19 x i8]
@.str.len13.h142498599 = external constant [14 x i8]
@.str.len12.h603915651 = external constant [13 x i8]
@.str.len15.h202150329 = external constant [16 x i8]
@.str.len9.h769510343 = external constant [10 x i8]
@.str.len12.h255876057 = external constant [13 x i8]
@.str.len52.h382324263 = external constant [53 x i8]
@.str.len7.h739212033 = external constant [8 x i8]
@.str.len23.h96319572 = external constant [24 x i8]
@.str.len13.h601865389 = external constant [14 x i8]
@.str.len8.h1809745374 = external constant [9 x i8]
@.str.len46.h1298670716 = external constant [47 x i8]
@.str.len4.h258714362 = external constant [5 x i8]
@.str.len8.h1809739434 = external constant [9 x i8]
@.str.len3.h2090737012 = external constant [4 x i8]
@.str.len40.h731245554 = external constant [41 x i8]
@.str.len53.h1204093150 = external constant [54 x i8]
@.str.len59.h1700212648 = external constant [60 x i8]
@.str.len16.h418770507 = external constant [17 x i8]
@.str.len65.h1925587422 = external constant [66 x i8]
@.str.len19.h779801773 = external constant [20 x i8]
@.str.len48.h971335843 = external constant [49 x i8]
@.str.len9.h719556312 = external constant [10 x i8]
@.str.len4.h205307558 = external constant [5 x i8]
@.str.len60.h484372876 = external constant [61 x i8]
@.str.len39.h1924108502 = external constant [40 x i8]
@.str.len23.h1424536798 = external constant [24 x i8]
@.str.len51.h535923040 = external constant [52 x i8]
@.str.len7.h770660688 = external constant [8 x i8]
@.str.len20.h93992129 = external constant [21 x i8]
@.str.len20.h1455768642 = external constant [21 x i8]
@.str.len37.h749417010 = external constant [38 x i8]
@.str.len16.h519580441 = external constant [17 x i8]
@.str.len12.h438755048 = external constant [13 x i8]
@.str.len5.h1893742920 = external constant [6 x i8]
@.str.len4.h230767751 = external constant [5 x i8]
@.str.len12.h937346004 = external constant [13 x i8]
@.str.len51.h1951972123 = external constant [52 x i8]
@.str.len49.h95349196 = external constant [50 x i8]
@.str.len35.h317788470 = external constant [36 x i8]
@.str.len8.h241775042 = external constant [9 x i8]
@.str.len54.h445851502 = external constant [55 x i8]
@.str.len6.h299655256 = external constant [7 x i8]
@.str.len7.h332613328 = external constant [8 x i8]
@.str.len4.h274283861 = external constant [5 x i8]
@.str.len47.h859819331 = external constant [48 x i8]
@.str.len55.h463798869 = external constant [56 x i8]
@.str.len18.h1203765633 = external constant [19 x i8]
@.str.len34.h1024520411 = external constant [35 x i8]
@.str.len57.h1542174776 = external constant [58 x i8]
@.str.len60.h550929947 = external constant [61 x i8]
@.str.len70.h134995567 = external constant [71 x i8]
@.str.len28.h1602830880 = external constant [29 x i8]
@.str.len34.h1529470002 = external constant [35 x i8]
@.str.len41.h980447798 = external constant [42 x i8]
@.str.len58.h1744114411 = external constant [59 x i8]
@.str.len47.h1674492337 = external constant [48 x i8]
@.str.len11.h701810522 = external constant [12 x i8]
@.str.len68.h1900616918 = external constant [69 x i8]
@.str.len65.h534894571 = external constant [66 x i8]
@.str.len40.h1039467311 = external constant [41 x i8]
@.str.len23.h675789051 = external constant [24 x i8]
@.str.len4.h273085895 = external constant [5 x i8]
@.str.len9.h1117872508 = external constant [10 x i8]
@.str.len11.h1907450020 = external constant [12 x i8]
@.str.len16.h251499985 = external constant [17 x i8]
@.str.len23.h721422858 = external constant [24 x i8]
@.str.len9.h1117174030 = external constant [10 x i8]
@.str.len16.h1310846896 = external constant [17 x i8]
@.str.len46.h1031183328 = external constant [47 x i8]
@.str.len55.h1287145578 = external constant [56 x i8]
@.str.len25.h2067177893 = external constant [26 x i8]
@.str.len16.h2115533553 = external constant [17 x i8]
@.str.len8.h1809668055 = external constant [9 x i8]
@.str.len8.h241551797 = external constant [9 x i8]
@.str.len48.h839589728 = external constant [49 x i8]
@.str.len3.h2090302138 = external constant [4 x i8]
@.str.len8.h794378208 = external constant [9 x i8]
@.str.len46.h1399920227 = external constant [47 x i8]
@.str.len35.h1273062999 = external constant [36 x i8]
@.str.len9.h1514414502 = external constant [10 x i8]
@.str.len3.h2090521984 = external constant [4 x i8]
@.str.len54.h800459588 = external constant [55 x i8]
@.str.len4.h219990644 = external constant [5 x i8]
@.str.len48.h5787697 = external constant [49 x i8]
@.str.len3.h2088250264 = external constant [4 x i8]
@.str.len50.h440106603 = external constant [51 x i8]
@.str.len43.h396338520 = external constant [44 x i8]
@.str.len8.h1809673005 = external constant [9 x i8]
@.str.len11.h539202395 = external constant [12 x i8]
@.str.len11.h1907139655 = external constant [12 x i8]
@.str.len16.h403825543 = external constant [17 x i8]
@.str.len50.h965784474 = external constant [51 x i8]
@.str.len54.h1866697936 = external constant [55 x i8]
@.str.len57.h1507377927 = external constant [58 x i8]
@.str.len54.h288837174 = external constant [55 x i8]
@.str.len26.h786724930 = external constant [27 x i8]
@.str.len5.h700747015 = external constant [6 x i8]
@.str.len47.h867637971 = external constant [48 x i8]
@.str.len47.h1239048531 = external constant [48 x i8]
@.str.len13.h1278011845 = external constant [14 x i8]
@.str.len7.h505600716 = external constant [8 x i8]
@.str.len29.h538291009 = external constant [30 x i8]
@.str.len48.h887886391 = external constant [49 x i8]
@.str.len5.h1117315388 = external constant [6 x i8]
@.str.len8.h267355070 = external constant [9 x i8]
@.str.len40.h203794297 = external constant [41 x i8]
@.str.len50.h1070755019 = external constant [51 x i8]
@.str.len4.h217223495 = external constant [5 x i8]
@.str.len9.h757580446 = external constant [10 x i8]
@.str.len60.h80215049 = external constant [61 x i8]
@.str.len33.h1306641126 = external constant [34 x i8]
@.str.len15.h1772400708 = external constant [16 x i8]
@.str.len6.h113799849 = external constant [7 x i8]
@.str.len7.h1064168743 = external constant [8 x i8]
@.str.len18.h1375510272 = external constant [19 x i8]
@.str.len49.h756173294 = external constant [50 x i8]
@.str.len17.h1905584788 = external constant [18 x i8]
@.str.len69.h1402407334 = external constant [70 x i8]
@.str.len3.h2089839742 = external constant [4 x i8]
@.str.len10.h1189337400 = external constant [11 x i8]
@.str.len8.h241557242 = external constant [9 x i8]
@.str.len36.h1435214388 = external constant [37 x i8]
@.str.len4.h260733302 = external constant [5 x i8]
@.str.len53.h1836297594 = external constant [54 x i8]
@.str.len2.h193515071 = external constant [3 x i8]
@.str.len52.h1450163979 = external constant [53 x i8]
@.str.len26.h1591462212 = external constant [27 x i8]
@.str.len8.h241557737 = external constant [9 x i8]
@.str.len19.h512381535 = external constant [20 x i8]
@.str.len7.h434936673 = external constant [8 x i8]
@.str.len6.h1803965435 = external constant [7 x i8]
@.str.len47.h769984802 = external constant [48 x i8]
@.str.len15.h1900227975 = external constant [16 x i8]
@.str.len10.h289462685 = external constant [11 x i8]
@.str.len33.h1082729604 = external constant [34 x i8]
@.str.len6.h1258614714 = external constant [7 x i8]
@.str.len17.h1795612323 = external constant [18 x i8]
@.str.len7.h1425458391 = external constant [8 x i8]
@.str.len55.h55260472 = external constant [56 x i8]
@.str.len11.h790843313 = external constant [12 x i8]
@.str.len42.h1019849180 = external constant [43 x i8]
@.str.len3.h2089113841 = external constant [4 x i8]
@.str.len5.h1895800173 = external constant [6 x i8]
@.str.len6.h1736497781 = external constant [7 x i8]
@.str.len40.h400700341 = external constant [41 x i8]
@.str.len2.h193459862 = external constant [3 x i8]
@.str.len3.h2088092689 = external constant [4 x i8]
@.str.len12.h1027822751 = external constant [13 x i8]
@.str.len8.h1230132454 = external constant [9 x i8]
@.str.len31.h852886773 = external constant [32 x i8]
@.str.len14.h165481004 = external constant [15 x i8]
@.str.len46.h744586798 = external constant [47 x i8]
@.str.len23.h225115061 = external constant [24 x i8]
@.str.len21.h464873829 = external constant [22 x i8]
@.str.len25.h1882901628 = external constant [26 x i8]
@.str.len27.h1230134945 = external constant [28 x i8]
@.str.len21.h1480982861 = external constant [22 x i8]
@.str.len15.h2008919863 = external constant [16 x i8]
@.str.len21.h949071414 = external constant [22 x i8]
@.str.len19.h190885179 = external constant [20 x i8]
@.str.len29.h1075519908 = external constant [30 x i8]
@.str.len35.h207688710 = external constant [36 x i8]
@.str.len29.h1468169 = external constant [30 x i8]
@.str.len35.h129830246 = external constant [36 x i8]
@.str.len35.h1076062162 = external constant [36 x i8]
@.str.len29.h29541381 = external constant [30 x i8]
@.str.len31.h1408297199 = external constant [32 x i8]
@.str.len22.h1699428905 = external constant [23 x i8]
@.str.len2.h193420823 = external constant [3 x i8]
@.str.len5.h2115689699 = external constant [6 x i8]
@.str.len8.h1132499314 = external constant [9 x i8]
@.str.len11.h1657754115 = external constant [12 x i8]
@.str.len6.h1267738404 = external constant [7 x i8]
@.str.len17.h215787497 = external constant [18 x i8]
@.str.len19.h1806641125 = external constant [20 x i8]
@.str.len28.h1179318158 = external constant [29 x i8]
@.str.len4.h182022329 = external constant [5 x i8]
@.str.len2.h193479629 = external constant [3 x i8]
@.str.len28.h583209964 = external constant [29 x i8]
@.str.len6.h1719661028 = external constant [7 x i8]
@.str.len8.h645367897 = external constant [9 x i8]
@.str.len4.h256486202 = external constant [5 x i8]
@.str.len2.h193423562 = external constant [3 x i8]
@.str.len14.h1077944870 = external constant [15 x i8]
@.str.len4.h174361445 = external constant [5 x i8]
@.str.len11.h2001621394 = external constant [12 x i8]
@.str.len22.h1038501153 = external constant [23 x i8]
@.str.len26.h1984174475 = external constant [27 x i8]
@.str.len3.h2088090973 = external constant [4 x i8]
@.str.len41.h1804821690 = external constant [42 x i8]
@.str.len2.h193478474 = external constant [3 x i8]
@.str.len15.h1983072220 = external constant [16 x i8]
@.str.len5.h843097466 = external constant [6 x i8]
@.str.len11.h1779553665 = external constant [12 x i8]
@.str.len8.h104511138 = external constant [9 x i8]
@.str.len24.h2028465620 = external constant [25 x i8]
@.str.len3.h2087924125 = external constant [4 x i8]
@.str.len9.h320851598 = external constant [10 x i8]
@.str.len2.h193428644 = external constant [3 x i8]
@.str.len2.h193515005 = external constant [3 x i8]
@.str.len20.h728584192 = external constant [21 x i8]
@.str.len5.h1503489441 = external constant [6 x i8]
@.str.len32.h1370567591 = external constant [33 x i8]
@.str.len4.h268720028 = external constant [5 x i8]
@.str.len10.h1977847647 = external constant [11 x i8]
@.str.len2.h193517249 = external constant [3 x i8]
@.str.len7.h919609845 = external constant [8 x i8]
@.str.len42.h9444846 = external constant [43 x i8]
@.str.len4.h176216012 = external constant [5 x i8]
@.str.len29.h610920064 = external constant [30 x i8]
@.str.len7.h1543377657 = external constant [8 x i8]
@.str.len6.h653919037 = external constant [7 x i8]
@.str.len25.h458257002 = external constant [26 x i8]
@.str.len28.h430828782 = external constant [29 x i8]
@.str.len5.h1776141546 = external constant [6 x i8]
@.str.len5.h2069574674 = external constant [6 x i8]
@.str.len8.h757831264 = external constant [9 x i8]
@.str.len29.h1122035900 = external constant [30 x i8]
@.str.len26.h1088202076 = external constant [27 x i8]
@.str.len4.h230766299 = external constant [5 x i8]
@.str.len18.h1387621460 = external constant [19 x i8]
@.str.len4.h237997259 = external constant [5 x i8]
@.str.len5.h2069215535 = external constant [6 x i8]
@.str.len29.h1409903806 = external constant [30 x i8]
@.str.len11.h1898426375 = external constant [12 x i8]
@.str.len4.h265982546 = external constant [5 x i8]
@.str.len5.h468448796 = external constant [6 x i8]
@.str.len39.h198700275 = external constant [40 x i8]
@.str.len37.h314404344 = external constant [38 x i8]
@.str.len11.h1460619898 = external constant [12 x i8]
@.str.len31.h1736570074 = external constant [32 x i8]
@.str.len4.h270590402 = external constant [5 x i8]
@.str.len25.h117462910 = external constant [26 x i8]
@.str.len5.h461434216 = external constant [6 x i8]
@.str.len39.h2079567388 = external constant [40 x i8]
@.str.len18.h1456282769 = external constant [19 x i8]
@.str.len22.h983476432 = external constant [23 x i8]
@.str.len8.h2085806463 = external constant [9 x i8]
@.str.len15.h1309566598 = external constant [16 x i8]
@.str.len31.h568140000 = external constant [32 x i8]
@.str.len4.h259337567 = external constant [5 x i8]
@.str.len3.h2090468623 = external constant [4 x i8]
@.str.len4.h276192845 = external constant [5 x i8]
@.str.len9.h1313193687 = external constant [10 x i8]
@.str.len4.h258014432 = external constant [5 x i8]
@.str.len4.h275477867 = external constant [5 x i8]
@.str.len10.h1589343988 = external constant [11 x i8]
@.str.len2.h193494974 = external constant [3 x i8]
@.str.len4.h266345381 = external constant [5 x i8]
@.str.len2.h193494710 = external constant [3 x i8]
@.str.len5.h222164317 = external constant [6 x i8]
@.str.len4.h279180071 = external constant [5 x i8]
@.str.len4.h255172967 = external constant [5 x i8]
@.str.len2.h193429568 = external constant [3 x i8]
@.str.len2.h193486427 = external constant [3 x i8]
@.str.len30.h1141851511 = external constant [31 x i8]
@.str.len9.h1021477046 = external constant [10 x i8]
@.str.len15.h1896695889 = external constant [16 x i8]
@.str.len5.h1921561325 = external constant [6 x i8]
@.str.len2.h193429733 = external constant [3 x i8]
@.str.len20.h1863181231 = external constant [21 x i8]
@.str.len14.h1876709041 = external constant [15 x i8]
@.str.len60.h1899438158 = external constant [61 x i8]
@.str.len5.h743728889 = external constant [6 x i8]
@.str.len18.h1304509209 = external constant [19 x i8]
@.str.len15.h1487231025 = external constant [16 x i8]
@.str.len16.h302658750 = external constant [17 x i8]
@.str.len5.h1504944345 = external constant [6 x i8]
@.str.len29.h85694398 = external constant [30 x i8]
@.str.len5.h743621045 = external constant [6 x i8]
@.str.len10.h6072819 = external constant [11 x i8]
@.str.len10.h1855834391 = external constant [11 x i8]
@.str.len5.h743728856 = external constant [6 x i8]
@.str.len24.h680377687 = external constant [25 x i8]
@.str.len14.h812083909 = external constant [15 x i8]
@.str.len14.h980936743 = external constant [15 x i8]
@.str.len14.h513489323 = external constant [15 x i8]
@.str.len16.h994638848 = external constant [17 x i8]
@.str.len8.h1925814595 = external constant [9 x i8]
@.str.len12.h328844387 = external constant [13 x i8]
@.str.len12.h766506979 = external constant [13 x i8]
@.str.len15.h902271367 = external constant [16 x i8]
@.str.len6.h1045703541 = external constant [7 x i8]