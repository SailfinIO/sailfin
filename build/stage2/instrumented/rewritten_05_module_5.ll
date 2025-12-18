; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

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
%Expression = type { i32, [40 x i8] }
%Statement = type { i32, [136 x i8] }
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
%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { %EnumVariantDefinition*, i64 }* }
%EnumInstance = type { %EnumType, i8*, { %EnumField*, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { %TypeDescriptor*, i64 }* }
declare void @stage2_debug_marker(i64)
declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Token @eof_token(double, double)
declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

declare i1 @is_identifier(i8* %value)
@runtime = external global i8**

@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len2.h193445441 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len2.h193444352 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.len2.h193446530 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len2.h193428611 = private unnamed_addr constant [3 x i8] c"..\00"

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define { %Token*, i64 }* @lex(i8* %source) {
block.entry:
  call void @stage2_debug_marker(i64 1000)
  %l0 = alloca %LexerState
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca i8
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca i8*
  %l20 = alloca double
  %l21 = alloca double
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i1
  %l25 = alloca i8
  %l26 = alloca i8*
  %l27 = alloca double
  %l28 = alloca double
  %l29 = alloca double
  %l30 = alloca i1
  %l31 = alloca i8*
  %l32 = alloca double
  %l33 = alloca double
  %l34 = alloca double
  %l35 = alloca i8*
  %l36 = alloca double
  %l37 = alloca double
  %l38 = alloca i8
  %l39 = alloca i8*
  %l40 = alloca i8*
  %t0 = insertvalue %LexerState undef, i8* %source, 0
  %t1 = sitofp i64 0 to double
  %t2 = insertvalue %LexerState %t0, double %t1, 1
  %t3 = sitofp i64 1 to double
  %t4 = insertvalue %LexerState %t2, double %t3, 2
  %t5 = sitofp i64 1 to double
  %t6 = insertvalue %LexerState %t4, double %t5, 3
  store %LexerState %t6, %LexerState* %l0
  %t7 = getelementptr [0 x %Token], [0 x %Token]* null, i32 1
  %t8 = ptrtoint [0 x %Token]* %t7 to i64
  %t9 = icmp eq i64 %t8, 0
  %t10 = select i1 %t9, i64 1, i64 %t8
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to %Token*
  %t13 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t14 = ptrtoint { %Token*, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { %Token*, i64 }*
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t16, i32 0, i32 0
  store %Token* %t12, %Token** %t17
  %t18 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { %Token*, i64 }* %t16, { %Token*, i64 }** %l1
  %t19 = load %LexerState, %LexerState* %l0
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t1105 = phi { %Token*, i64 }* [ %t20, %block.entry ], [ %t1104, %loop.latch2 ]
  store { %Token*, i64 }* %t1105, { %Token*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t21 = load %LexerState, %LexerState* %l0
  %t22 = extractvalue %LexerState %t21, 1
  %t23 = load %LexerState, %LexerState* %l0
  %t24 = extractvalue %LexerState %t23, 0
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load %LexerState, %LexerState* %l0
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br i1 %t27, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  call void @stage2_debug_marker(i64 1001)
  %t30 = load %LexerState, %LexerState* %l0
  %t31 = extractvalue %LexerState %t30, 0
  %t32 = load %LexerState, %LexerState* %l0
  %t33 = extractvalue %LexerState %t32, 1
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = getelementptr i8, i8* %t31, i64 %t35
  %t37 = load i8, i8* %t36
  store i8 %t37, i8* %l2
  %t38 = load i8, i8* %l2
  %t39 = add i64 0, 2
  %t40 = call i8* @malloc(i64 %t39)
  store i8 %t38, i8* %t40
  %t41 = getelementptr i8, i8* %t40, i64 1
  store i8 0, i8* %t41
  call void @sailfin_runtime_mark_persistent(i8* %t40)
  %t42 = call i1 @is_whitespace(i8* %t40)
  %t43 = load %LexerState, %LexerState* %l0
  %t44 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t45 = load i8, i8* %l2
  br i1 %t42, label %then6, label %merge7
then6:
  call void @stage2_debug_marker(i64 1002)
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = extractvalue %LexerState %t46, 1
  store double %t47, double* %l3
  %t48 = load %LexerState, %LexerState* %l0
  %t49 = extractvalue %LexerState %t48, 2
  store double %t49, double* %l4
  %t50 = load %LexerState, %LexerState* %l0
  %t51 = extractvalue %LexerState %t50, 3
  store double %t51, double* %l5
  %t52 = load %LexerState, %LexerState* %l0
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t54 = load i8, i8* %l2
  %t55 = load double, double* %l3
  %t56 = load double, double* %l4
  %t57 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  call void @stage2_debug_marker(i64 1003)
  %t58 = load %LexerState, %LexerState* %l0
  %t59 = extractvalue %LexerState %t58, 1
  %t60 = load %LexerState, %LexerState* %l0
  %t61 = extractvalue %LexerState %t60, 0
  %t62 = call i64 @sailfin_runtime_string_length(i8* %t61)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oge double %t59, %t63
  %t65 = load %LexerState, %LexerState* %l0
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t67 = load i8, i8* %l2
  %t68 = load double, double* %l3
  %t69 = load double, double* %l4
  %t70 = load double, double* %l5
  br i1 %t64, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t71 = load %LexerState, %LexerState* %l0
  %t72 = extractvalue %LexerState %t71, 0
  %t73 = load %LexerState, %LexerState* %l0
  %t74 = extractvalue %LexerState %t73, 1
  %t75 = call double @llvm.round.f64(double %t74)
  %t76 = fptosi double %t75 to i64
  %t77 = getelementptr i8, i8* %t72, i64 %t76
  %t78 = load i8, i8* %t77
  %t79 = add i64 0, 2
  %t80 = call i8* @malloc(i64 %t79)
  store i8 %t78, i8* %t80
  %t81 = getelementptr i8, i8* %t80, i64 1
  store i8 0, i8* %t81
  call void @sailfin_runtime_mark_persistent(i8* %t80)
  %t82 = call i1 @is_whitespace(i8* %t80)
  %t83 = xor i1 %t82, 1
  %t84 = load %LexerState, %LexerState* %l0
  %t85 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t86 = load i8, i8* %l2
  %t87 = load double, double* %l3
  %t88 = load double, double* %l4
  %t89 = load double, double* %l5
  br i1 %t83, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  call void @stage2_debug_marker(i64 1004)
  %t90 = load %LexerState, %LexerState* %l0
  %t91 = extractvalue %LexerState %t90, 0
  %t92 = load %LexerState, %LexerState* %l0
  %t93 = extractvalue %LexerState %t92, 1
  %t94 = call double @llvm.round.f64(double %t93)
  %t95 = fptosi double %t94 to i64
  %t96 = getelementptr i8, i8* %t91, i64 %t95
  %t97 = load i8, i8* %t96
  %t98 = icmp eq i8 %t97, 10
  %t99 = load %LexerState, %LexerState* %l0
  %t100 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t101 = load i8, i8* %l2
  %t102 = load double, double* %l3
  %t103 = load double, double* %l4
  %t104 = load double, double* %l5
  br i1 %t98, label %then16, label %else17
then16:
  %t105 = load %LexerState, %LexerState* %l0
  %t106 = extractvalue %LexerState %t105, 1
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  %t109 = load %LexerState, %LexerState* %l0
  %t110 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t108, double* %t110
  %t111 = load %LexerState, %LexerState* %l0
  %t112 = extractvalue %LexerState %t111, 2
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  %t115 = load %LexerState, %LexerState* %l0
  %t116 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t114, double* %t116
  %t117 = load %LexerState, %LexerState* %l0
  %t118 = sitofp i64 1 to double
  %t119 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t118, double* %t119
  br label %merge18
else17:
  %t120 = load %LexerState, %LexerState* %l0
  %t121 = extractvalue %LexerState %t120, 1
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  %t124 = load %LexerState, %LexerState* %l0
  %t125 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t123, double* %t125
  %t126 = load %LexerState, %LexerState* %l0
  %t127 = extractvalue %LexerState %t126, 3
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  %t130 = load %LexerState, %LexerState* %l0
  %t131 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t129, double* %t131
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t132 = load %LexerState, %LexerState* %l0
  %t133 = extractvalue %LexerState %t132, 0
  %t134 = load double, double* %l3
  %t135 = load %LexerState, %LexerState* %l0
  %t136 = extractvalue %LexerState %t135, 1
  %t137 = call i8* @slice(i8* %t133, double %t134, double %t136)
  store i8* %t137, i8** %l6
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t139 = insertvalue %TokenKind undef, i32 5, 0
  %t140 = insertvalue %Token undef, %TokenKind %t139, 0
  %t141 = load i8*, i8** %l6
  %t142 = insertvalue %Token %t140, i8* %t141, 1
  %t143 = load double, double* %l4
  %t144 = insertvalue %Token %t142, double %t143, 2
  %t145 = load double, double* %l5
  %t146 = insertvalue %Token %t144, double %t145, 3
  %t147 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t138, %Token %t146)
  store { %Token*, i64 }* %t147, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t148 = load i8, i8* %l2
  %t149 = icmp eq i8 %t148, 47
  %t150 = load %LexerState, %LexerState* %l0
  %t151 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t152 = load i8, i8* %l2
  br i1 %t149, label %then19, label %merge20
then19:
  %t153 = load %LexerState, %LexerState* %l0
  %t154 = call i8* @peek_next_char(%LexerState %t153)
  store i8* %t154, i8** %l7
  %t155 = load i8*, i8** %l7
  %t156 = load i8, i8* %t155
  %t157 = icmp eq i8 %t156, 47
  %t158 = load %LexerState, %LexerState* %l0
  %t159 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t160 = load i8, i8* %l2
  %t161 = load i8*, i8** %l7
  br i1 %t157, label %then21, label %merge22
then21:
  %t162 = load %LexerState, %LexerState* %l0
  %t163 = extractvalue %LexerState %t162, 1
  store double %t163, double* %l8
  %t164 = load %LexerState, %LexerState* %l0
  %t165 = extractvalue %LexerState %t164, 2
  store double %t165, double* %l9
  %t166 = load %LexerState, %LexerState* %l0
  %t167 = extractvalue %LexerState %t166, 3
  store double %t167, double* %l10
  %t168 = load %LexerState, %LexerState* %l0
  %t169 = extractvalue %LexerState %t168, 1
  %t170 = sitofp i64 2 to double
  %t171 = fadd double %t169, %t170
  %t172 = load %LexerState, %LexerState* %l0
  %t173 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t171, double* %t173
  %t174 = load %LexerState, %LexerState* %l0
  %t175 = extractvalue %LexerState %t174, 3
  %t176 = sitofp i64 2 to double
  %t177 = fadd double %t175, %t176
  %t178 = load %LexerState, %LexerState* %l0
  %t179 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t177, double* %t179
  %t180 = load %LexerState, %LexerState* %l0
  %t181 = extractvalue %LexerState %t180, 0
  %t182 = call i64 @sailfin_runtime_string_length(i8* %t181)
  %t183 = sitofp i64 %t182 to double
  store double %t183, double* %l11
  %t184 = load %LexerState, %LexerState* %l0
  %t185 = extractvalue %LexerState %t184, 1
  store double %t185, double* %l12
  %t186 = load %LexerState, %LexerState* %l0
  %t187 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t188 = load i8, i8* %l2
  %t189 = load i8*, i8** %l7
  %t190 = load double, double* %l8
  %t191 = load double, double* %l9
  %t192 = load double, double* %l10
  %t193 = load double, double* %l11
  %t194 = load double, double* %l12
  br label %loop.header23
loop.header23:
  %t239 = phi double [ %t193, %then21 ], [ %t237, %loop.latch25 ]
  %t240 = phi double [ %t194, %then21 ], [ %t238, %loop.latch25 ]
  store double %t239, double* %l11
  store double %t240, double* %l12
  br label %loop.body24
loop.body24:
  %t195 = load double, double* %l12
  %t196 = load %LexerState, %LexerState* %l0
  %t197 = extractvalue %LexerState %t196, 0
  %t198 = call i64 @sailfin_runtime_string_length(i8* %t197)
  %t199 = sitofp i64 %t198 to double
  %t200 = fcmp oge double %t195, %t199
  %t201 = load %LexerState, %LexerState* %l0
  %t202 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t203 = load i8, i8* %l2
  %t204 = load i8*, i8** %l7
  %t205 = load double, double* %l8
  %t206 = load double, double* %l9
  %t207 = load double, double* %l10
  %t208 = load double, double* %l11
  %t209 = load double, double* %l12
  br i1 %t200, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = extractvalue %LexerState %t210, 0
  %t212 = load double, double* %l12
  %t213 = call double @llvm.round.f64(double %t212)
  %t214 = fptosi double %t213 to i64
  %t215 = getelementptr i8, i8* %t211, i64 %t214
  %t216 = load i8, i8* %t215
  store i8 %t216, i8* %l13
  %t218 = load i8, i8* %l13
  %t219 = icmp eq i8 %t218, 10
  br label %logical_or_entry_217

logical_or_entry_217:
  br i1 %t219, label %logical_or_merge_217, label %logical_or_right_217

logical_or_right_217:
  %t220 = load i8, i8* %l13
  %t221 = icmp eq i8 %t220, 13
  br label %logical_or_right_end_217

logical_or_right_end_217:
  br label %logical_or_merge_217

logical_or_merge_217:
  %t222 = phi i1 [ true, %logical_or_entry_217 ], [ %t221, %logical_or_right_end_217 ]
  %t223 = load %LexerState, %LexerState* %l0
  %t224 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t225 = load i8, i8* %l2
  %t226 = load i8*, i8** %l7
  %t227 = load double, double* %l8
  %t228 = load double, double* %l9
  %t229 = load double, double* %l10
  %t230 = load double, double* %l11
  %t231 = load double, double* %l12
  %t232 = load i8, i8* %l13
  br i1 %t222, label %then29, label %merge30
then29:
  %t233 = load double, double* %l12
  store double %t233, double* %l11
  br label %afterloop26
merge30:
  %t234 = load double, double* %l12
  %t235 = sitofp i64 1 to double
  %t236 = fadd double %t234, %t235
  store double %t236, double* %l12
  br label %loop.latch25
loop.latch25:
  %t237 = load double, double* %l11
  %t238 = load double, double* %l12
  br label %loop.header23
afterloop26:
  %t241 = load double, double* %l11
  %t242 = load double, double* %l12
  %t243 = load %LexerState, %LexerState* %l0
  %t244 = extractvalue %LexerState %t243, 0
  %t245 = load double, double* %l8
  %t246 = load double, double* %l11
  %t247 = call i8* @slice(i8* %t244, double %t245, double %t246)
  store i8* %t247, i8** %l14
  %t248 = load double, double* %l11
  %t249 = load %LexerState, %LexerState* %l0
  %t250 = extractvalue %LexerState %t249, 1
  %t251 = fsub double %t248, %t250
  store double %t251, double* %l15
  %t252 = load double, double* %l11
  %t253 = load %LexerState, %LexerState* %l0
  %t254 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t252, double* %t254
  %t255 = load %LexerState, %LexerState* %l0
  %t256 = extractvalue %LexerState %t255, 3
  %t257 = load double, double* %l15
  %t258 = fadd double %t256, %t257
  %t259 = load %LexerState, %LexerState* %l0
  %t260 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t258, double* %t260
  %t261 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t262 = insertvalue %TokenKind undef, i32 6, 0
  %t263 = insertvalue %Token undef, %TokenKind %t262, 0
  %t264 = load i8*, i8** %l14
  %t265 = insertvalue %Token %t263, i8* %t264, 1
  %t266 = load double, double* %l9
  %t267 = insertvalue %Token %t265, double %t266, 2
  %t268 = load double, double* %l10
  %t269 = insertvalue %Token %t267, double %t268, 3
  %t270 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t261, %Token %t269)
  store { %Token*, i64 }* %t270, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t271 = load i8*, i8** %l7
  %t272 = load i8, i8* %t271
  %t273 = icmp eq i8 %t272, 42
  %t274 = load %LexerState, %LexerState* %l0
  %t275 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t276 = load i8, i8* %l2
  %t277 = load i8*, i8** %l7
  br i1 %t273, label %then31, label %merge32
then31:
  %t278 = load %LexerState, %LexerState* %l0
  %t279 = extractvalue %LexerState %t278, 1
  store double %t279, double* %l16
  %t280 = load %LexerState, %LexerState* %l0
  %t281 = extractvalue %LexerState %t280, 2
  store double %t281, double* %l17
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = extractvalue %LexerState %t282, 3
  store double %t283, double* %l18
  %t284 = load %LexerState, %LexerState* %l0
  %t285 = extractvalue %LexerState %t284, 1
  %t286 = sitofp i64 2 to double
  %t287 = fadd double %t285, %t286
  %t288 = load %LexerState, %LexerState* %l0
  %t289 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t287, double* %t289
  %t290 = load %LexerState, %LexerState* %l0
  %t291 = extractvalue %LexerState %t290, 3
  %t292 = sitofp i64 2 to double
  %t293 = fadd double %t291, %t292
  %t294 = load %LexerState, %LexerState* %l0
  %t295 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t293, double* %t295
  %t296 = load %LexerState, %LexerState* %l0
  %t297 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t298 = load i8, i8* %l2
  %t299 = load i8*, i8** %l7
  %t300 = load double, double* %l16
  %t301 = load double, double* %l17
  %t302 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t303 = load %LexerState, %LexerState* %l0
  %t304 = extractvalue %LexerState %t303, 1
  %t305 = load %LexerState, %LexerState* %l0
  %t306 = extractvalue %LexerState %t305, 0
  %t307 = call i64 @sailfin_runtime_string_length(i8* %t306)
  %t308 = sitofp i64 %t307 to double
  %t309 = fcmp oge double %t304, %t308
  %t310 = load %LexerState, %LexerState* %l0
  %t311 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t312 = load i8, i8* %l2
  %t313 = load i8*, i8** %l7
  %t314 = load double, double* %l16
  %t315 = load double, double* %l17
  %t316 = load double, double* %l18
  br i1 %t309, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t318 = load %LexerState, %LexerState* %l0
  %t319 = extractvalue %LexerState %t318, 0
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = extractvalue %LexerState %t320, 1
  %t322 = call double @llvm.round.f64(double %t321)
  %t323 = fptosi double %t322 to i64
  %t324 = getelementptr i8, i8* %t319, i64 %t323
  %t325 = load i8, i8* %t324
  %t326 = icmp eq i8 %t325, 42
  br label %logical_and_entry_317

logical_and_entry_317:
  br i1 %t326, label %logical_and_right_317, label %logical_and_merge_317

logical_and_right_317:
  %t327 = load %LexerState, %LexerState* %l0
  %t328 = call i8* @peek_next_char(%LexerState %t327)
  %t329 = load i8, i8* %t328
  %t330 = icmp eq i8 %t329, 47
  br label %logical_and_right_end_317

logical_and_right_end_317:
  br label %logical_and_merge_317

logical_and_merge_317:
  %t331 = phi i1 [ false, %logical_and_entry_317 ], [ %t330, %logical_and_right_end_317 ]
  %t332 = load %LexerState, %LexerState* %l0
  %t333 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t334 = load i8, i8* %l2
  %t335 = load i8*, i8** %l7
  %t336 = load double, double* %l16
  %t337 = load double, double* %l17
  %t338 = load double, double* %l18
  br i1 %t331, label %then39, label %merge40
then39:
  %t339 = load %LexerState, %LexerState* %l0
  %t340 = extractvalue %LexerState %t339, 1
  %t341 = sitofp i64 2 to double
  %t342 = fadd double %t340, %t341
  %t343 = load %LexerState, %LexerState* %l0
  %t344 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t342, double* %t344
  %t345 = load %LexerState, %LexerState* %l0
  %t346 = extractvalue %LexerState %t345, 3
  %t347 = sitofp i64 2 to double
  %t348 = fadd double %t346, %t347
  %t349 = load %LexerState, %LexerState* %l0
  %t350 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t348, double* %t350
  br label %afterloop36
merge40:
  %t351 = load %LexerState, %LexerState* %l0
  %t352 = extractvalue %LexerState %t351, 0
  %t353 = load %LexerState, %LexerState* %l0
  %t354 = extractvalue %LexerState %t353, 1
  %t355 = call double @llvm.round.f64(double %t354)
  %t356 = fptosi double %t355 to i64
  %t357 = getelementptr i8, i8* %t352, i64 %t356
  %t358 = load i8, i8* %t357
  %t359 = icmp eq i8 %t358, 10
  %t360 = load %LexerState, %LexerState* %l0
  %t361 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t362 = load i8, i8* %l2
  %t363 = load i8*, i8** %l7
  %t364 = load double, double* %l16
  %t365 = load double, double* %l17
  %t366 = load double, double* %l18
  br i1 %t359, label %then41, label %else42
then41:
  %t367 = load %LexerState, %LexerState* %l0
  %t368 = extractvalue %LexerState %t367, 1
  %t369 = sitofp i64 1 to double
  %t370 = fadd double %t368, %t369
  %t371 = load %LexerState, %LexerState* %l0
  %t372 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t370, double* %t372
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = extractvalue %LexerState %t373, 2
  %t375 = sitofp i64 1 to double
  %t376 = fadd double %t374, %t375
  %t377 = load %LexerState, %LexerState* %l0
  %t378 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t376, double* %t378
  %t379 = load %LexerState, %LexerState* %l0
  %t380 = sitofp i64 1 to double
  %t381 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t380, double* %t381
  br label %merge43
else42:
  %t382 = load %LexerState, %LexerState* %l0
  %t383 = extractvalue %LexerState %t382, 1
  %t384 = sitofp i64 1 to double
  %t385 = fadd double %t383, %t384
  %t386 = load %LexerState, %LexerState* %l0
  %t387 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t385, double* %t387
  %t388 = load %LexerState, %LexerState* %l0
  %t389 = extractvalue %LexerState %t388, 3
  %t390 = sitofp i64 1 to double
  %t391 = fadd double %t389, %t390
  %t392 = load %LexerState, %LexerState* %l0
  %t393 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t391, double* %t393
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t394 = load %LexerState, %LexerState* %l0
  %t395 = extractvalue %LexerState %t394, 0
  %t396 = load double, double* %l16
  %t397 = load %LexerState, %LexerState* %l0
  %t398 = extractvalue %LexerState %t397, 1
  %t399 = call i8* @slice(i8* %t395, double %t396, double %t398)
  store i8* %t399, i8** %l19
  %t400 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t401 = insertvalue %TokenKind undef, i32 6, 0
  %t402 = insertvalue %Token undef, %TokenKind %t401, 0
  %t403 = load i8*, i8** %l19
  %t404 = insertvalue %Token %t402, i8* %t403, 1
  %t405 = load double, double* %l17
  %t406 = insertvalue %Token %t404, double %t405, 2
  %t407 = load double, double* %l18
  %t408 = insertvalue %Token %t406, double %t407, 3
  %t409 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t400, %Token %t408)
  store { %Token*, i64 }* %t409, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  %t410 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t411 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge20
merge20:
  %t412 = phi { %Token*, i64 }* [ %t410, %merge32 ], [ %t151, %merge7 ]
  %t413 = phi { %Token*, i64 }* [ %t411, %merge32 ], [ %t151, %merge7 ]
  store { %Token*, i64 }* %t412, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t413, { %Token*, i64 }** %l1
  %t414 = load i8, i8* %l2
  %t415 = add i64 0, 2
  %t416 = call i8* @malloc(i64 %t415)
  store i8 %t414, i8* %t416
  %t417 = getelementptr i8, i8* %t416, i64 1
  store i8 0, i8* %t417
  call void @sailfin_runtime_mark_persistent(i8* %t416)
  %t418 = call i1 @is_double_quote(i8* %t416)
  %t419 = load %LexerState, %LexerState* %l0
  %t420 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t421 = load i8, i8* %l2
  br i1 %t418, label %then44, label %merge45
then44:
  %t422 = load %LexerState, %LexerState* %l0
  %t423 = extractvalue %LexerState %t422, 1
  store double %t423, double* %l20
  %t424 = load %LexerState, %LexerState* %l0
  %t425 = extractvalue %LexerState %t424, 2
  store double %t425, double* %l21
  %t426 = load %LexerState, %LexerState* %l0
  %t427 = extractvalue %LexerState %t426, 3
  store double %t427, double* %l22
  %t428 = load %LexerState, %LexerState* %l0
  %t429 = extractvalue %LexerState %t428, 1
  %t430 = sitofp i64 1 to double
  %t431 = fadd double %t429, %t430
  %t432 = load %LexerState, %LexerState* %l0
  %t433 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t431, double* %t433
  %t434 = load %LexerState, %LexerState* %l0
  %t435 = extractvalue %LexerState %t434, 3
  %t436 = sitofp i64 1 to double
  %t437 = fadd double %t435, %t436
  %t438 = load %LexerState, %LexerState* %l0
  %t439 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t437, double* %t439
  %s440 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s440, i8** %l23
  store i1 0, i1* %l24
  %t441 = load %LexerState, %LexerState* %l0
  %t442 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t443 = load i8, i8* %l2
  %t444 = load double, double* %l20
  %t445 = load double, double* %l21
  %t446 = load double, double* %l22
  %t447 = load i8*, i8** %l23
  %t448 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t600 = phi i1 [ %t448, %then44 ], [ %t598, %loop.latch48 ]
  %t601 = phi i8* [ %t447, %then44 ], [ %t599, %loop.latch48 ]
  store i1 %t600, i1* %l24
  store i8* %t601, i8** %l23
  br label %loop.body47
loop.body47:
  %t449 = load %LexerState, %LexerState* %l0
  %t450 = extractvalue %LexerState %t449, 1
  %t451 = load %LexerState, %LexerState* %l0
  %t452 = extractvalue %LexerState %t451, 0
  %t453 = call i64 @sailfin_runtime_string_length(i8* %t452)
  %t454 = sitofp i64 %t453 to double
  %t455 = fcmp oge double %t450, %t454
  %t456 = load %LexerState, %LexerState* %l0
  %t457 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t458 = load i8, i8* %l2
  %t459 = load double, double* %l20
  %t460 = load double, double* %l21
  %t461 = load double, double* %l22
  %t462 = load i8*, i8** %l23
  %t463 = load i1, i1* %l24
  br i1 %t455, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t464 = load %LexerState, %LexerState* %l0
  %t465 = extractvalue %LexerState %t464, 0
  %t466 = load %LexerState, %LexerState* %l0
  %t467 = extractvalue %LexerState %t466, 1
  %t468 = call double @llvm.round.f64(double %t467)
  %t469 = fptosi double %t468 to i64
  %t470 = getelementptr i8, i8* %t465, i64 %t469
  %t471 = load i8, i8* %t470
  store i8 %t471, i8* %l25
  %t473 = load i1, i1* %l24
  br label %logical_and_entry_472

logical_and_entry_472:
  br i1 %t473, label %logical_and_right_472, label %logical_and_merge_472

logical_and_right_472:
  %t474 = load i8, i8* %l25
  %t475 = add i64 0, 2
  %t476 = call i8* @malloc(i64 %t475)
  store i8 %t474, i8* %t476
  %t477 = getelementptr i8, i8* %t476, i64 1
  store i8 0, i8* %t477
  call void @sailfin_runtime_mark_persistent(i8* %t476)
  %t478 = call i1 @is_double_quote(i8* %t476)
  br label %logical_and_right_end_472

logical_and_right_end_472:
  br label %logical_and_merge_472

logical_and_merge_472:
  %t479 = phi i1 [ false, %logical_and_entry_472 ], [ %t478, %logical_and_right_end_472 ]
  %t480 = xor i1 %t479, 1
  %t481 = load %LexerState, %LexerState* %l0
  %t482 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t483 = load i8, i8* %l2
  %t484 = load double, double* %l20
  %t485 = load double, double* %l21
  %t486 = load double, double* %l22
  %t487 = load i8*, i8** %l23
  %t488 = load i1, i1* %l24
  %t489 = load i8, i8* %l25
  br i1 %t480, label %then52, label %merge53
then52:
  %t490 = load %LexerState, %LexerState* %l0
  %t491 = extractvalue %LexerState %t490, 1
  %t492 = sitofp i64 1 to double
  %t493 = fadd double %t491, %t492
  %t494 = load %LexerState, %LexerState* %l0
  %t495 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t493, double* %t495
  %t496 = load %LexerState, %LexerState* %l0
  %t497 = extractvalue %LexerState %t496, 3
  %t498 = sitofp i64 1 to double
  %t499 = fadd double %t497, %t498
  %t500 = load %LexerState, %LexerState* %l0
  %t501 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t499, double* %t501
  br label %afterloop49
merge53:
  %t503 = load i1, i1* %l24
  br label %logical_and_entry_502

logical_and_entry_502:
  br i1 %t503, label %logical_and_right_502, label %logical_and_merge_502

logical_and_right_502:
  %t504 = load i8, i8* %l25
  %t505 = add i64 0, 2
  %t506 = call i8* @malloc(i64 %t505)
  store i8 %t504, i8* %t506
  %t507 = getelementptr i8, i8* %t506, i64 1
  store i8 0, i8* %t507
  call void @sailfin_runtime_mark_persistent(i8* %t506)
  %t508 = call i1 @is_backslash(i8* %t506)
  br label %logical_and_right_end_502

logical_and_right_end_502:
  br label %logical_and_merge_502

logical_and_merge_502:
  %t509 = phi i1 [ false, %logical_and_entry_502 ], [ %t508, %logical_and_right_end_502 ]
  %t510 = xor i1 %t509, 1
  %t511 = load %LexerState, %LexerState* %l0
  %t512 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t513 = load i8, i8* %l2
  %t514 = load double, double* %l20
  %t515 = load double, double* %l21
  %t516 = load double, double* %l22
  %t517 = load i8*, i8** %l23
  %t518 = load i1, i1* %l24
  %t519 = load i8, i8* %l25
  br i1 %t510, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t520 = load %LexerState, %LexerState* %l0
  %t521 = extractvalue %LexerState %t520, 1
  %t522 = sitofp i64 1 to double
  %t523 = fadd double %t521, %t522
  %t524 = load %LexerState, %LexerState* %l0
  %t525 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t523, double* %t525
  %t526 = load %LexerState, %LexerState* %l0
  %t527 = extractvalue %LexerState %t526, 3
  %t528 = sitofp i64 1 to double
  %t529 = fadd double %t527, %t528
  %t530 = load %LexerState, %LexerState* %l0
  %t531 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t529, double* %t531
  br label %loop.latch48
merge55:
  %t532 = load i1, i1* %l24
  %t533 = load %LexerState, %LexerState* %l0
  %t534 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t535 = load i8, i8* %l2
  %t536 = load double, double* %l20
  %t537 = load double, double* %l21
  %t538 = load double, double* %l22
  %t539 = load i8*, i8** %l23
  %t540 = load i1, i1* %l24
  %t541 = load i8, i8* %l25
  br i1 %t532, label %then56, label %else57
then56:
  %t542 = load i8*, i8** %l23
  %t543 = load i8, i8* %l25
  %t544 = add i64 0, 2
  %t545 = call i8* @malloc(i64 %t544)
  store i8 %t543, i8* %t545
  %t546 = getelementptr i8, i8* %t545, i64 1
  store i8 0, i8* %t546
  call void @sailfin_runtime_mark_persistent(i8* %t545)
  %t547 = call i8* @interpret_escape(i8* %t545)
  %t548 = call i8* @sailfin_runtime_string_concat(i8* %t542, i8* %t547)
  store i8* %t548, i8** %l23
  store i1 0, i1* %l24
  %t549 = load i8*, i8** %l23
  %t550 = load i1, i1* %l24
  br label %merge58
else57:
  %t551 = load i8*, i8** %l23
  %t552 = load i8, i8* %l25
  %t553 = add i64 0, 2
  %t554 = call i8* @malloc(i64 %t553)
  store i8 %t552, i8* %t554
  %t555 = getelementptr i8, i8* %t554, i64 1
  store i8 0, i8* %t555
  call void @sailfin_runtime_mark_persistent(i8* %t554)
  %t556 = call i8* @sailfin_runtime_string_concat(i8* %t551, i8* %t554)
  store i8* %t556, i8** %l23
  %t557 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t558 = phi i8* [ %t549, %then56 ], [ %t557, %else57 ]
  %t559 = phi i1 [ %t550, %then56 ], [ %t540, %else57 ]
  store i8* %t558, i8** %l23
  store i1 %t559, i1* %l24
  %t560 = load i8, i8* %l25
  %t561 = icmp eq i8 %t560, 10
  %t562 = load %LexerState, %LexerState* %l0
  %t563 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t564 = load i8, i8* %l2
  %t565 = load double, double* %l20
  %t566 = load double, double* %l21
  %t567 = load double, double* %l22
  %t568 = load i8*, i8** %l23
  %t569 = load i1, i1* %l24
  %t570 = load i8, i8* %l25
  br i1 %t561, label %then59, label %else60
then59:
  %t571 = load %LexerState, %LexerState* %l0
  %t572 = extractvalue %LexerState %t571, 1
  %t573 = sitofp i64 1 to double
  %t574 = fadd double %t572, %t573
  %t575 = load %LexerState, %LexerState* %l0
  %t576 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t574, double* %t576
  %t577 = load %LexerState, %LexerState* %l0
  %t578 = extractvalue %LexerState %t577, 2
  %t579 = sitofp i64 1 to double
  %t580 = fadd double %t578, %t579
  %t581 = load %LexerState, %LexerState* %l0
  %t582 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t580, double* %t582
  %t583 = load %LexerState, %LexerState* %l0
  %t584 = sitofp i64 1 to double
  %t585 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t584, double* %t585
  br label %merge61
else60:
  %t586 = load %LexerState, %LexerState* %l0
  %t587 = extractvalue %LexerState %t586, 1
  %t588 = sitofp i64 1 to double
  %t589 = fadd double %t587, %t588
  %t590 = load %LexerState, %LexerState* %l0
  %t591 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t589, double* %t591
  %t592 = load %LexerState, %LexerState* %l0
  %t593 = extractvalue %LexerState %t592, 3
  %t594 = sitofp i64 1 to double
  %t595 = fadd double %t593, %t594
  %t596 = load %LexerState, %LexerState* %l0
  %t597 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t595, double* %t597
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t598 = load i1, i1* %l24
  %t599 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t602 = load i1, i1* %l24
  %t603 = load i8*, i8** %l23
  %t604 = load %LexerState, %LexerState* %l0
  %t605 = extractvalue %LexerState %t604, 0
  %t606 = load double, double* %l20
  %t607 = load %LexerState, %LexerState* %l0
  %t608 = extractvalue %LexerState %t607, 1
  %t609 = call i8* @slice(i8* %t605, double %t606, double %t608)
  store i8* %t609, i8** %l26
  %t610 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t611 = alloca %TokenKind
  %t612 = getelementptr inbounds %TokenKind, %TokenKind* %t611, i32 0, i32 0
  store i32 2, i32* %t612
  %t613 = load i8*, i8** %l23
  %t614 = getelementptr inbounds %TokenKind, %TokenKind* %t611, i32 0, i32 1
  %t615 = bitcast [8 x i8]* %t614 to i8*
  %t616 = bitcast i8* %t615 to i8**
  store i8* %t613, i8** %t616
  %t617 = load %TokenKind, %TokenKind* %t611
  %t618 = insertvalue %Token undef, %TokenKind %t617, 0
  %t619 = load i8*, i8** %l26
  %t620 = insertvalue %Token %t618, i8* %t619, 1
  %t621 = load double, double* %l21
  %t622 = insertvalue %Token %t620, double %t621, 2
  %t623 = load double, double* %l22
  %t624 = insertvalue %Token %t622, double %t623, 3
  %t625 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t610, %Token %t624)
  store { %Token*, i64 }* %t625, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t626 = load i8, i8* %l2
  %t627 = add i64 0, 2
  %t628 = call i8* @malloc(i64 %t627)
  store i8 %t626, i8* %t628
  %t629 = getelementptr i8, i8* %t628, i64 1
  store i8 0, i8* %t629
  call void @sailfin_runtime_mark_persistent(i8* %t628)
  %t630 = call i1 @is_digit(i8* %t628)
  %t631 = load %LexerState, %LexerState* %l0
  %t632 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t633 = load i8, i8* %l2
  br i1 %t630, label %then62, label %merge63
then62:
  %t634 = load %LexerState, %LexerState* %l0
  %t635 = extractvalue %LexerState %t634, 1
  store double %t635, double* %l27
  %t636 = load %LexerState, %LexerState* %l0
  %t637 = extractvalue %LexerState %t636, 2
  store double %t637, double* %l28
  %t638 = load %LexerState, %LexerState* %l0
  %t639 = extractvalue %LexerState %t638, 3
  store double %t639, double* %l29
  %t640 = load %LexerState, %LexerState* %l0
  %t641 = extractvalue %LexerState %t640, 1
  %t642 = sitofp i64 1 to double
  %t643 = fadd double %t641, %t642
  %t644 = load %LexerState, %LexerState* %l0
  %t645 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t643, double* %t645
  %t646 = load %LexerState, %LexerState* %l0
  %t647 = extractvalue %LexerState %t646, 3
  %t648 = sitofp i64 1 to double
  %t649 = fadd double %t647, %t648
  %t650 = load %LexerState, %LexerState* %l0
  %t651 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t649, double* %t651
  %t652 = load %LexerState, %LexerState* %l0
  %t653 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t654 = load i8, i8* %l2
  %t655 = load double, double* %l27
  %t656 = load double, double* %l28
  %t657 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t658 = load %LexerState, %LexerState* %l0
  %t659 = extractvalue %LexerState %t658, 1
  %t660 = load %LexerState, %LexerState* %l0
  %t661 = extractvalue %LexerState %t660, 0
  %t662 = call i64 @sailfin_runtime_string_length(i8* %t661)
  %t663 = sitofp i64 %t662 to double
  %t664 = fcmp oge double %t659, %t663
  %t665 = load %LexerState, %LexerState* %l0
  %t666 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t667 = load i8, i8* %l2
  %t668 = load double, double* %l27
  %t669 = load double, double* %l28
  %t670 = load double, double* %l29
  br i1 %t664, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t671 = load %LexerState, %LexerState* %l0
  %t672 = extractvalue %LexerState %t671, 0
  %t673 = load %LexerState, %LexerState* %l0
  %t674 = extractvalue %LexerState %t673, 1
  %t675 = call double @llvm.round.f64(double %t674)
  %t676 = fptosi double %t675 to i64
  %t677 = getelementptr i8, i8* %t672, i64 %t676
  %t678 = load i8, i8* %t677
  %t679 = add i64 0, 2
  %t680 = call i8* @malloc(i64 %t679)
  store i8 %t678, i8* %t680
  %t681 = getelementptr i8, i8* %t680, i64 1
  store i8 0, i8* %t681
  call void @sailfin_runtime_mark_persistent(i8* %t680)
  %t682 = call i1 @is_digit(i8* %t680)
  %t683 = xor i1 %t682, 1
  %t684 = load %LexerState, %LexerState* %l0
  %t685 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t686 = load i8, i8* %l2
  %t687 = load double, double* %l27
  %t688 = load double, double* %l28
  %t689 = load double, double* %l29
  br i1 %t683, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t690 = load %LexerState, %LexerState* %l0
  %t691 = extractvalue %LexerState %t690, 1
  %t692 = sitofp i64 1 to double
  %t693 = fadd double %t691, %t692
  %t694 = load %LexerState, %LexerState* %l0
  %t695 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t693, double* %t695
  %t696 = load %LexerState, %LexerState* %l0
  %t697 = extractvalue %LexerState %t696, 3
  %t698 = sitofp i64 1 to double
  %t699 = fadd double %t697, %t698
  %t700 = load %LexerState, %LexerState* %l0
  %t701 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t699, double* %t701
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t703 = load %LexerState, %LexerState* %l0
  %t704 = extractvalue %LexerState %t703, 1
  %t705 = load %LexerState, %LexerState* %l0
  %t706 = extractvalue %LexerState %t705, 0
  %t707 = call i64 @sailfin_runtime_string_length(i8* %t706)
  %t708 = sitofp i64 %t707 to double
  %t709 = fcmp olt double %t704, %t708
  br label %logical_and_entry_702

logical_and_entry_702:
  br i1 %t709, label %logical_and_right_702, label %logical_and_merge_702

logical_and_right_702:
  %t710 = load %LexerState, %LexerState* %l0
  %t711 = extractvalue %LexerState %t710, 0
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = extractvalue %LexerState %t712, 1
  %t714 = call double @llvm.round.f64(double %t713)
  %t715 = fptosi double %t714 to i64
  %t716 = getelementptr i8, i8* %t711, i64 %t715
  %t717 = load i8, i8* %t716
  %t718 = icmp eq i8 %t717, 46
  br label %logical_and_right_end_702

logical_and_right_end_702:
  br label %logical_and_merge_702

logical_and_merge_702:
  %t719 = phi i1 [ false, %logical_and_entry_702 ], [ %t718, %logical_and_right_end_702 ]
  %t720 = load %LexerState, %LexerState* %l0
  %t721 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t722 = load i8, i8* %l2
  %t723 = load double, double* %l27
  %t724 = load double, double* %l28
  %t725 = load double, double* %l29
  br i1 %t719, label %then72, label %merge73
then72:
  %t727 = load %LexerState, %LexerState* %l0
  %t728 = extractvalue %LexerState %t727, 1
  %t729 = sitofp i64 1 to double
  %t730 = fadd double %t728, %t729
  %t731 = load %LexerState, %LexerState* %l0
  %t732 = extractvalue %LexerState %t731, 0
  %t733 = call i64 @sailfin_runtime_string_length(i8* %t732)
  %t734 = sitofp i64 %t733 to double
  %t735 = fcmp olt double %t730, %t734
  br label %logical_and_entry_726

logical_and_entry_726:
  br i1 %t735, label %logical_and_right_726, label %logical_and_merge_726

logical_and_right_726:
  %t736 = load %LexerState, %LexerState* %l0
  %t737 = extractvalue %LexerState %t736, 0
  %t738 = load %LexerState, %LexerState* %l0
  %t739 = extractvalue %LexerState %t738, 1
  %t740 = sitofp i64 1 to double
  %t741 = fadd double %t739, %t740
  %t742 = call double @llvm.round.f64(double %t741)
  %t743 = fptosi double %t742 to i64
  %t744 = getelementptr i8, i8* %t737, i64 %t743
  %t745 = load i8, i8* %t744
  %t746 = add i64 0, 2
  %t747 = call i8* @malloc(i64 %t746)
  store i8 %t745, i8* %t747
  %t748 = getelementptr i8, i8* %t747, i64 1
  store i8 0, i8* %t748
  call void @sailfin_runtime_mark_persistent(i8* %t747)
  %t749 = call i1 @is_digit(i8* %t747)
  br label %logical_and_right_end_726

logical_and_right_end_726:
  br label %logical_and_merge_726

logical_and_merge_726:
  %t750 = phi i1 [ false, %logical_and_entry_726 ], [ %t749, %logical_and_right_end_726 ]
  store i1 %t750, i1* %l30
  %t751 = load i1, i1* %l30
  %t752 = load %LexerState, %LexerState* %l0
  %t753 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t754 = load i8, i8* %l2
  %t755 = load double, double* %l27
  %t756 = load double, double* %l28
  %t757 = load double, double* %l29
  %t758 = load i1, i1* %l30
  br i1 %t751, label %then74, label %merge75
then74:
  %t759 = load %LexerState, %LexerState* %l0
  %t760 = extractvalue %LexerState %t759, 1
  %t761 = sitofp i64 1 to double
  %t762 = fadd double %t760, %t761
  %t763 = load %LexerState, %LexerState* %l0
  %t764 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t762, double* %t764
  %t765 = load %LexerState, %LexerState* %l0
  %t766 = extractvalue %LexerState %t765, 3
  %t767 = sitofp i64 1 to double
  %t768 = fadd double %t766, %t767
  %t769 = load %LexerState, %LexerState* %l0
  %t770 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t768, double* %t770
  %t771 = load %LexerState, %LexerState* %l0
  %t772 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t773 = load i8, i8* %l2
  %t774 = load double, double* %l27
  %t775 = load double, double* %l28
  %t776 = load double, double* %l29
  %t777 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t778 = load %LexerState, %LexerState* %l0
  %t779 = extractvalue %LexerState %t778, 1
  %t780 = load %LexerState, %LexerState* %l0
  %t781 = extractvalue %LexerState %t780, 0
  %t782 = call i64 @sailfin_runtime_string_length(i8* %t781)
  %t783 = sitofp i64 %t782 to double
  %t784 = fcmp oge double %t779, %t783
  %t785 = load %LexerState, %LexerState* %l0
  %t786 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t787 = load i8, i8* %l2
  %t788 = load double, double* %l27
  %t789 = load double, double* %l28
  %t790 = load double, double* %l29
  %t791 = load i1, i1* %l30
  br i1 %t784, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t792 = load %LexerState, %LexerState* %l0
  %t793 = extractvalue %LexerState %t792, 0
  %t794 = load %LexerState, %LexerState* %l0
  %t795 = extractvalue %LexerState %t794, 1
  %t796 = call double @llvm.round.f64(double %t795)
  %t797 = fptosi double %t796 to i64
  %t798 = getelementptr i8, i8* %t793, i64 %t797
  %t799 = load i8, i8* %t798
  %t800 = add i64 0, 2
  %t801 = call i8* @malloc(i64 %t800)
  store i8 %t799, i8* %t801
  %t802 = getelementptr i8, i8* %t801, i64 1
  store i8 0, i8* %t802
  call void @sailfin_runtime_mark_persistent(i8* %t801)
  %t803 = call i1 @is_digit(i8* %t801)
  %t804 = xor i1 %t803, 1
  %t805 = load %LexerState, %LexerState* %l0
  %t806 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t807 = load i8, i8* %l2
  %t808 = load double, double* %l27
  %t809 = load double, double* %l28
  %t810 = load double, double* %l29
  %t811 = load i1, i1* %l30
  br i1 %t804, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t812 = load %LexerState, %LexerState* %l0
  %t813 = extractvalue %LexerState %t812, 1
  %t814 = sitofp i64 1 to double
  %t815 = fadd double %t813, %t814
  %t816 = load %LexerState, %LexerState* %l0
  %t817 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t815, double* %t817
  %t818 = load %LexerState, %LexerState* %l0
  %t819 = extractvalue %LexerState %t818, 3
  %t820 = sitofp i64 1 to double
  %t821 = fadd double %t819, %t820
  %t822 = load %LexerState, %LexerState* %l0
  %t823 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t821, double* %t823
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t824 = load %LexerState, %LexerState* %l0
  %t825 = extractvalue %LexerState %t824, 0
  %t826 = load double, double* %l27
  %t827 = load %LexerState, %LexerState* %l0
  %t828 = extractvalue %LexerState %t827, 1
  %t829 = call i8* @slice(i8* %t825, double %t826, double %t828)
  store i8* %t829, i8** %l31
  %t830 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t831 = alloca %TokenKind
  %t832 = getelementptr inbounds %TokenKind, %TokenKind* %t831, i32 0, i32 0
  store i32 1, i32* %t832
  %t833 = load i8*, i8** %l31
  %t834 = getelementptr inbounds %TokenKind, %TokenKind* %t831, i32 0, i32 1
  %t835 = bitcast [8 x i8]* %t834 to i8*
  %t836 = bitcast i8* %t835 to i8**
  store i8* %t833, i8** %t836
  %t837 = load %TokenKind, %TokenKind* %t831
  %t838 = insertvalue %Token undef, %TokenKind %t837, 0
  %t839 = load i8*, i8** %l31
  %t840 = insertvalue %Token %t838, i8* %t839, 1
  %t841 = load double, double* %l28
  %t842 = insertvalue %Token %t840, double %t841, 2
  %t843 = load double, double* %l29
  %t844 = insertvalue %Token %t842, double %t843, 3
  %t845 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t830, %Token %t844)
  store { %Token*, i64 }* %t845, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t846 = load i8, i8* %l2
  %t847 = add i64 0, 2
  %t848 = call i8* @malloc(i64 %t847)
  store i8 %t846, i8* %t848
  %t849 = getelementptr i8, i8* %t848, i64 1
  store i8 0, i8* %t849
  call void @sailfin_runtime_mark_persistent(i8* %t848)
  %t850 = call i1 @is_identifier_start(i8* %t848)
  %t851 = load %LexerState, %LexerState* %l0
  %t852 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t853 = load i8, i8* %l2
  br i1 %t850, label %then84, label %merge85
then84:
  %t854 = load %LexerState, %LexerState* %l0
  %t855 = extractvalue %LexerState %t854, 1
  store double %t855, double* %l32
  %t856 = load %LexerState, %LexerState* %l0
  %t857 = extractvalue %LexerState %t856, 2
  store double %t857, double* %l33
  %t858 = load %LexerState, %LexerState* %l0
  %t859 = extractvalue %LexerState %t858, 3
  store double %t859, double* %l34
  %t860 = load %LexerState, %LexerState* %l0
  %t861 = extractvalue %LexerState %t860, 1
  %t862 = sitofp i64 1 to double
  %t863 = fadd double %t861, %t862
  %t864 = load %LexerState, %LexerState* %l0
  %t865 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t863, double* %t865
  %t866 = load %LexerState, %LexerState* %l0
  %t867 = extractvalue %LexerState %t866, 3
  %t868 = sitofp i64 1 to double
  %t869 = fadd double %t867, %t868
  %t870 = load %LexerState, %LexerState* %l0
  %t871 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t869, double* %t871
  %t872 = load %LexerState, %LexerState* %l0
  %t873 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t874 = load i8, i8* %l2
  %t875 = load double, double* %l32
  %t876 = load double, double* %l33
  %t877 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t878 = load %LexerState, %LexerState* %l0
  %t879 = extractvalue %LexerState %t878, 1
  %t880 = load %LexerState, %LexerState* %l0
  %t881 = extractvalue %LexerState %t880, 0
  %t882 = call i64 @sailfin_runtime_string_length(i8* %t881)
  %t883 = sitofp i64 %t882 to double
  %t884 = fcmp oge double %t879, %t883
  %t885 = load %LexerState, %LexerState* %l0
  %t886 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t887 = load i8, i8* %l2
  %t888 = load double, double* %l32
  %t889 = load double, double* %l33
  %t890 = load double, double* %l34
  br i1 %t884, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t891 = load %LexerState, %LexerState* %l0
  %t892 = extractvalue %LexerState %t891, 0
  %t893 = load %LexerState, %LexerState* %l0
  %t894 = extractvalue %LexerState %t893, 1
  %t895 = call double @llvm.round.f64(double %t894)
  %t896 = fptosi double %t895 to i64
  %t897 = getelementptr i8, i8* %t892, i64 %t896
  %t898 = load i8, i8* %t897
  %stage2_ident_index_code = add i64 %t896, 5000
  call void @stage2_debug_marker(i64 %stage2_ident_index_code)
  %stage2_ident_char = zext i8 %t898 to i64
  %stage2_ident_char_code = add i64 %stage2_ident_char, 3000
  call void @stage2_debug_marker(i64 %stage2_ident_char_code)
  %t899 = add i64 0, 2
  %t900 = call i8* @malloc(i64 %t899)
  store i8 %t898, i8* %t900
  %t901 = getelementptr i8, i8* %t900, i64 1
  store i8 0, i8* %t901
  call void @sailfin_runtime_mark_persistent(i8* %t900)
  %t902 = call i1 @is_identifier_part(i8* %t900)
  %t903 = xor i1 %t902, 1
  %t904 = load %LexerState, %LexerState* %l0
  %t905 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t906 = load i8, i8* %l2
  %t907 = load double, double* %l32
  %t908 = load double, double* %l33
  %t909 = load double, double* %l34
  br i1 %t903, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t910 = load %LexerState, %LexerState* %l0
  %t911 = extractvalue %LexerState %t910, 1
  %t912 = sitofp i64 1 to double
  %t913 = fadd double %t911, %t912
  %t914 = load %LexerState, %LexerState* %l0
  %t915 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t913, double* %t915
  %t916 = load %LexerState, %LexerState* %l0
  %t917 = extractvalue %LexerState %t916, 3
  %t918 = sitofp i64 1 to double
  %t919 = fadd double %t917, %t918
  %t920 = load %LexerState, %LexerState* %l0
  %t921 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t919, double* %t921
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t922 = load %LexerState, %LexerState* %l0
  %t923 = extractvalue %LexerState %t922, 0
  %t924 = load double, double* %l32
  %t925 = load %LexerState, %LexerState* %l0
  %t926 = extractvalue %LexerState %t925, 1
  %t927 = call i8* @slice(i8* %t923, double %t924, double %t926)
  store i8* %t927, i8** %l35
  %t929 = load i8*, i8** %l35
  %s930 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t931 = call i1 @strings_equal(i8* %t929, i8* %s930)
  br label %logical_or_entry_928

logical_or_entry_928:
  br i1 %t931, label %logical_or_merge_928, label %logical_or_right_928

logical_or_right_928:
  %t932 = load i8*, i8** %l35
  %s933 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t934 = call i1 @strings_equal(i8* %t932, i8* %s933)
  br label %logical_or_right_end_928

logical_or_right_end_928:
  br label %logical_or_merge_928

logical_or_merge_928:
  %t935 = phi i1 [ true, %logical_or_entry_928 ], [ %t934, %logical_or_right_end_928 ]
  %t936 = load %LexerState, %LexerState* %l0
  %t937 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t938 = load i8, i8* %l2
  %t939 = load double, double* %l32
  %t940 = load double, double* %l33
  %t941 = load double, double* %l34
  %t942 = load i8*, i8** %l35
  br i1 %t935, label %then94, label %else95
then94:
  %t943 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t944 = alloca %TokenKind
  %t945 = getelementptr inbounds %TokenKind, %TokenKind* %t944, i32 0, i32 0
  store i32 3, i32* %t945
  %t946 = load i8*, i8** %l35
  %t947 = getelementptr inbounds %TokenKind, %TokenKind* %t944, i32 0, i32 1
  %t948 = bitcast [8 x i8]* %t947 to i8*
  %t949 = bitcast i8* %t948 to i8**
  store i8* %t946, i8** %t949
  %t950 = load %TokenKind, %TokenKind* %t944
  %t951 = insertvalue %Token undef, %TokenKind %t950, 0
  %t952 = load i8*, i8** %l35
  %t953 = insertvalue %Token %t951, i8* %t952, 1
  %t954 = load double, double* %l33
  %t955 = insertvalue %Token %t953, double %t954, 2
  %t956 = load double, double* %l34
  %t957 = insertvalue %Token %t955, double %t956, 3
  %t958 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t943, %Token %t957)
  store { %Token*, i64 }* %t958, { %Token*, i64 }** %l1
  %t959 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t960 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t961 = alloca %TokenKind
  %t962 = getelementptr inbounds %TokenKind, %TokenKind* %t961, i32 0, i32 0
  store i32 0, i32* %t962
  %t963 = load i8*, i8** %l35
  %t964 = getelementptr inbounds %TokenKind, %TokenKind* %t961, i32 0, i32 1
  %t965 = bitcast [8 x i8]* %t964 to i8*
  %t966 = bitcast i8* %t965 to i8**
  store i8* %t963, i8** %t966
  %t967 = load %TokenKind, %TokenKind* %t961
  %t968 = insertvalue %Token undef, %TokenKind %t967, 0
  %t969 = load i8*, i8** %l35
  %t970 = insertvalue %Token %t968, i8* %t969, 1
  %t971 = load double, double* %l33
  %t972 = insertvalue %Token %t970, double %t971, 2
  %t973 = load double, double* %l34
  %t974 = insertvalue %Token %t972, double %t973, 3
  %t975 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t960, %Token %t974)
  store { %Token*, i64 }* %t975, { %Token*, i64 }** %l1
  %t976 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t977 = phi { %Token*, i64 }* [ %t959, %then94 ], [ %t976, %else95 ]
  store { %Token*, i64 }* %t977, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t978 = load %LexerState, %LexerState* %l0
  %t979 = extractvalue %LexerState %t978, 2
  store double %t979, double* %l36
  %t980 = load %LexerState, %LexerState* %l0
  %t981 = extractvalue %LexerState %t980, 3
  store double %t981, double* %l37
  %t982 = load i8, i8* %l2
  store i8 %t982, i8* %l38
  %t983 = load %LexerState, %LexerState* %l0
  %t984 = call i8* @peek_next_char(%LexerState %t983)
  store i8* %t984, i8** %l39
  %t985 = load i8*, i8** %l39
  %s986 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t987 = call i1 @strings_equal(i8* %t985, i8* %s986)
  %t988 = xor i1 %t987, true
  %t989 = load %LexerState, %LexerState* %l0
  %t990 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t991 = load i8, i8* %l2
  %t992 = load double, double* %l36
  %t993 = load double, double* %l37
  %t994 = load i8, i8* %l38
  %t995 = load i8*, i8** %l39
  br i1 %t988, label %then97, label %merge98
then97:
  %t996 = load i8, i8* %l2
  %t997 = load i8*, i8** %l39
  %t998 = add i64 0, 2
  %t999 = call i8* @malloc(i64 %t998)
  store i8 %t996, i8* %t999
  %t1000 = getelementptr i8, i8* %t999, i64 1
  store i8 0, i8* %t1000
  call void @sailfin_runtime_mark_persistent(i8* %t999)
  %t1001 = call i8* @sailfin_runtime_string_concat(i8* %t999, i8* %t997)
  store i8* %t1001, i8** %l40
  %t1002 = load i8*, i8** %l40
  %t1003 = call i1 @is_two_char_symbol(i8* %t1002)
  %t1004 = load %LexerState, %LexerState* %l0
  %t1005 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1006 = load i8, i8* %l2
  %t1007 = load double, double* %l36
  %t1008 = load double, double* %l37
  %t1009 = load i8, i8* %l38
  %t1010 = load i8*, i8** %l39
  %t1011 = load i8*, i8** %l40
  br i1 %t1003, label %then99, label %merge100
then99:
  %t1012 = load i8*, i8** %l40
  %t1013 = load i8, i8* %t1012
  store i8 %t1013, i8* %l38
  %t1014 = load %LexerState, %LexerState* %l0
  %t1015 = extractvalue %LexerState %t1014, 1
  %t1016 = sitofp i64 2 to double
  %t1017 = fadd double %t1015, %t1016
  %t1018 = load %LexerState, %LexerState* %l0
  %t1019 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1017, double* %t1019
  %t1020 = load %LexerState, %LexerState* %l0
  %t1021 = extractvalue %LexerState %t1020, 3
  %t1022 = sitofp i64 2 to double
  %t1023 = fadd double %t1021, %t1022
  %t1024 = load %LexerState, %LexerState* %l0
  %t1025 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1023, double* %t1025
  %t1026 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1027 = alloca %TokenKind
  %t1028 = getelementptr inbounds %TokenKind, %TokenKind* %t1027, i32 0, i32 0
  store i32 4, i32* %t1028
  %t1029 = load i8, i8* %l38
  %t1030 = add i64 0, 2
  %t1031 = call i8* @malloc(i64 %t1030)
  store i8 %t1029, i8* %t1031
  %t1032 = getelementptr i8, i8* %t1031, i64 1
  store i8 0, i8* %t1032
  call void @sailfin_runtime_mark_persistent(i8* %t1031)
  %t1033 = getelementptr inbounds %TokenKind, %TokenKind* %t1027, i32 0, i32 1
  %t1034 = bitcast [8 x i8]* %t1033 to i8*
  %t1035 = bitcast i8* %t1034 to i8**
  store i8* %t1031, i8** %t1035
  %t1036 = load %TokenKind, %TokenKind* %t1027
  %t1037 = insertvalue %Token undef, %TokenKind %t1036, 0
  %t1038 = load i8, i8* %l38
  %t1039 = add i64 0, 2
  %t1040 = call i8* @malloc(i64 %t1039)
  store i8 %t1038, i8* %t1040
  %t1041 = getelementptr i8, i8* %t1040, i64 1
  store i8 0, i8* %t1041
  call void @sailfin_runtime_mark_persistent(i8* %t1040)
  %t1042 = insertvalue %Token %t1037, i8* %t1040, 1
  %t1043 = load double, double* %l36
  %t1044 = insertvalue %Token %t1042, double %t1043, 2
  %t1045 = load double, double* %l37
  %t1046 = insertvalue %Token %t1044, double %t1045, 3
  %t1047 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1026, %Token %t1046)
  store { %Token*, i64 }* %t1047, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t1048 = load i8, i8* %l38
  %t1049 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t1050 = phi i8 [ %t1048, %merge100 ], [ %t994, %merge85 ]
  %t1051 = phi { %Token*, i64 }* [ %t1049, %merge100 ], [ %t990, %merge85 ]
  store i8 %t1050, i8* %l38
  store { %Token*, i64 }* %t1051, { %Token*, i64 }** %l1
  %t1052 = load %LexerState, %LexerState* %l0
  %t1053 = extractvalue %LexerState %t1052, 1
  %t1054 = sitofp i64 1 to double
  %t1055 = fadd double %t1053, %t1054
  %t1056 = load %LexerState, %LexerState* %l0
  %t1057 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1055, double* %t1057
  %t1058 = load i8, i8* %l2
  %t1059 = icmp eq i8 %t1058, 10
  %t1060 = load %LexerState, %LexerState* %l0
  %t1061 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1062 = load i8, i8* %l2
  %t1063 = load double, double* %l36
  %t1064 = load double, double* %l37
  %t1065 = load i8, i8* %l38
  %t1066 = load i8*, i8** %l39
  br i1 %t1059, label %then101, label %else102
then101:
  %t1067 = load %LexerState, %LexerState* %l0
  %t1068 = extractvalue %LexerState %t1067, 2
  %t1069 = sitofp i64 1 to double
  %t1070 = fadd double %t1068, %t1069
  %t1071 = load %LexerState, %LexerState* %l0
  %t1072 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t1070, double* %t1072
  %t1073 = load %LexerState, %LexerState* %l0
  %t1074 = sitofp i64 1 to double
  %t1075 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1074, double* %t1075
  br label %merge103
else102:
  %t1076 = load %LexerState, %LexerState* %l0
  %t1077 = extractvalue %LexerState %t1076, 3
  %t1078 = sitofp i64 1 to double
  %t1079 = fadd double %t1077, %t1078
  %t1080 = load %LexerState, %LexerState* %l0
  %t1081 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1079, double* %t1081
  br label %merge103
merge103:
  %t1082 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1083 = alloca %TokenKind
  %t1084 = getelementptr inbounds %TokenKind, %TokenKind* %t1083, i32 0, i32 0
  store i32 4, i32* %t1084
  %t1085 = load i8, i8* %l38
  %t1086 = add i64 0, 2
  %t1087 = call i8* @malloc(i64 %t1086)
  store i8 %t1085, i8* %t1087
  %t1088 = getelementptr i8, i8* %t1087, i64 1
  store i8 0, i8* %t1088
  call void @sailfin_runtime_mark_persistent(i8* %t1087)
  %t1089 = getelementptr inbounds %TokenKind, %TokenKind* %t1083, i32 0, i32 1
  %t1090 = bitcast [8 x i8]* %t1089 to i8*
  %t1091 = bitcast i8* %t1090 to i8**
  store i8* %t1087, i8** %t1091
  %t1092 = load %TokenKind, %TokenKind* %t1083
  %t1093 = insertvalue %Token undef, %TokenKind %t1092, 0
  %t1094 = load i8, i8* %l38
  %t1095 = add i64 0, 2
  %t1096 = call i8* @malloc(i64 %t1095)
  store i8 %t1094, i8* %t1096
  %t1097 = getelementptr i8, i8* %t1096, i64 1
  store i8 0, i8* %t1097
  call void @sailfin_runtime_mark_persistent(i8* %t1096)
  %t1098 = insertvalue %Token %t1093, i8* %t1096, 1
  %t1099 = load double, double* %l36
  %t1100 = insertvalue %Token %t1098, double %t1099, 2
  %t1101 = load double, double* %l37
  %t1102 = insertvalue %Token %t1100, double %t1101, 3
  %t1103 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1082, %Token %t1102)
  store { %Token*, i64 }* %t1103, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1104 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1106 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1107 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1108 = load %LexerState, %LexerState* %l0
  %t1109 = extractvalue %LexerState %t1108, 2
  %t1110 = load %LexerState, %LexerState* %l0
  %t1111 = extractvalue %LexerState %t1110, 3
  %t1112 = call %Token @eof_token(double %t1109, double %t1111)
  %t1113 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1107, %Token %t1112)
  store { %Token*, i64 }* %t1113, { %Token*, i64 }** %l1
  %t1114 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1114
}

define i1 @is_whitespace(i8* %ch) {
block.entry:
  %t1 = load i8, i8* %ch
  %t2 = icmp eq i8 %t1, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 9
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8, i8* %ch
  %t8 = icmp eq i8 %t7, 10
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 13
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

define private i1 @is_identifier_start(i8* %ch) {
block.entry:
  %t1 = call i1 @is_letter(i8* %ch)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t2 = load i8, i8* %ch
  %t3 = icmp eq i8 %t2, 95
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t4 = phi i1 [ true, %logical_or_entry_0 ], [ %t3, %logical_or_right_end_0 ]
  ret i1 %t4
}

define private i1 @is_identifier_part(i8* %ch) {
block.entry:
  %t1 = call i1 @is_identifier_start(i8* %ch)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t2 = call i1 @is_digit(i8* %ch)
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t3 = phi i1 [ true, %logical_or_entry_0 ], [ %t2, %logical_or_right_end_0 ]
  ret i1 %t3
}

define i1 @is_letter(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t3 = load double, double* %l0
  %t4 = add i64 0, 2
  %t5 = call i8* @malloc(i64 %t4)
  store i8 97, i8* %t5
  %t6 = getelementptr i8, i8* %t5, i64 1
  store i8 0, i8* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  %t7 = call double @char_code(i8* %t5)
  %t8 = fcmp oge double %t3, %t7
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t8, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t9 = load double, double* %l0
  %t10 = add i64 0, 2
  %t11 = call i8* @malloc(i64 %t10)
  store i8 122, i8* %t11
  %t12 = getelementptr i8, i8* %t11, i64 1
  store i8 0, i8* %t12
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  %t13 = call double @char_code(i8* %t11)
  %t14 = fcmp ole double %t9, %t13
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t15 = phi i1 [ false, %logical_and_entry_2 ], [ %t14, %logical_and_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t15, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t17 = load double, double* %l0
  %t18 = add i64 0, 2
  %t19 = call i8* @malloc(i64 %t18)
  store i8 65, i8* %t19
  %t20 = getelementptr i8, i8* %t19, i64 1
  store i8 0, i8* %t20
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  %t21 = call double @char_code(i8* %t19)
  %t22 = fcmp oge double %t17, %t21
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t22, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %t23 = load double, double* %l0
  %t24 = add i64 0, 2
  %t25 = call i8* @malloc(i64 %t24)
  store i8 90, i8* %t25
  %t26 = getelementptr i8, i8* %t25, i64 1
  store i8 0, i8* %t26
  call void @sailfin_runtime_mark_persistent(i8* %t25)
  %t27 = call double @char_code(i8* %t25)
  %t28 = fcmp ole double %t23, %t27
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t29 = phi i1 [ false, %logical_and_entry_16 ], [ %t28, %logical_and_right_end_16 ]
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t30 = phi i1 [ true, %logical_or_entry_1 ], [ %t29, %logical_or_right_end_1 ]
  ret i1 %t30
}

define i1 @is_digit(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = add i64 0, 2
  %t4 = call i8* @malloc(i64 %t3)
  store i8 48, i8* %t4
  %t5 = getelementptr i8, i8* %t4, i64 1
  store i8 0, i8* %t5
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  %t6 = call double @char_code(i8* %t4)
  %t7 = fcmp oge double %t2, %t6
  br label %logical_and_entry_1

logical_and_entry_1:
  br i1 %t7, label %logical_and_right_1, label %logical_and_merge_1

logical_and_right_1:
  %t8 = load double, double* %l0
  %t9 = add i64 0, 2
  %t10 = call i8* @malloc(i64 %t9)
  store i8 57, i8* %t10
  %t11 = getelementptr i8, i8* %t10, i64 1
  store i8 0, i8* %t11
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  %t12 = call double @char_code(i8* %t10)
  %t13 = fcmp ole double %t8, %t12
  br label %logical_and_right_end_1

logical_and_right_end_1:
  br label %logical_and_merge_1

logical_and_merge_1:
  %t14 = phi i1 [ false, %logical_and_entry_1 ], [ %t13, %logical_and_right_end_1 ]
  ret i1 %t14
}

define i1 @is_double_quote(i8* %ch) {
block.entry:
  %t0 = call double @char_code(i8* %ch)
  %t1 = sitofp i64 34 to double
  %t2 = fcmp oeq double %t0, %t1
  ret i1 %t2
}

define i1 @is_backslash(i8* %ch) {
block.entry:
  %t0 = call double @char_code(i8* %ch)
  %t1 = sitofp i64 92 to double
  %t2 = fcmp oeq double %t0, %t1
  ret i1 %t2
}

define i8* @slice(i8* %text, double %start, double %end) {
block.entry:
  %t0 = call double @llvm.round.f64(double %start)
  %t1 = fptosi double %t0 to i64
  %t2 = call double @llvm.round.f64(double %end)
  %t3 = fptosi double %t2 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t1, i64 %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
}

define { %Token*, i64 }* @append({ %Token*, i64 }* %tokens, %Token %token) {
block.entry:
  %t0 = getelementptr [1 x %Token], [1 x %Token]* null, i32 1
  %t1 = ptrtoint [1 x %Token]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %Token*
  %t6 = getelementptr %Token, %Token* %t5, i64 0
  store %Token %token, %Token* %t6
  %t7 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t8 = ptrtoint { %Token*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %Token*, i64 }*
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 0
  store %Token* %t5, %Token** %t11
  %t12 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %tokens, i32 0, i32 0
  %t14 = load %Token*, %Token** %t13
  %t15 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %tokens, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 0
  %t18 = load %Token*, %Token** %t17
  %t19 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %Token], [1 x %Token]* null, i32 0, i32 1
  %t22 = ptrtoint %Token* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %Token*
  %t27 = bitcast %Token* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %Token* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %Token* %t18 to i8*
  %t32 = getelementptr %Token, %Token* %t26, i64 %t16
  %t33 = bitcast %Token* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t35 = ptrtoint { %Token*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %Token*, i64 }*
  %t38 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t37, i32 0, i32 0
  store %Token* %t26, %Token** %t38
  %t39 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %Token*, i64 }* %t37
}

define i8* @peek_next_char(%LexerState %state) {
block.entry:
  %l0 = alloca double
  %t0 = extractvalue %LexerState %state, 1
  %t1 = sitofp i64 1 to double
  %t2 = fadd double %t0, %t1
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t4 = extractvalue %LexerState %state, 0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s9)
  ret i8* %s9
merge1:
  %t10 = extractvalue %LexerState %state, 0
  %t11 = load double, double* %l0
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = getelementptr i8, i8* %t10, i64 %t13
  %t15 = load i8, i8* %t14
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 %t15, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  ret i8* %t17
}

define i8* @interpret_escape(i8* %ch) {
block.entry:
  %t0 = load i8, i8* %ch
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
  %t5 = load i8, i8* %ch
  %t6 = icmp eq i8 %t5, 116
  br i1 %t6, label %then2, label %merge3
then2:
  %t7 = add i64 0, 2
  %t8 = call i8* @malloc(i64 %t7)
  store i8 9, i8* %t8
  %t9 = getelementptr i8, i8* %t8, i64 1
  store i8 0, i8* %t9
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
merge3:
  %t10 = load i8, i8* %ch
  %t11 = icmp eq i8 %t10, 114
  br i1 %t11, label %then4, label %merge5
then4:
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 13, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret i8* %t13
merge5:
  %t15 = call i1 @is_double_quote(i8* %ch)
  br i1 %t15, label %then6, label %merge7
then6:
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 34, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  ret i8* %t17
merge7:
  %t19 = call i1 @is_backslash(i8* %ch)
  br i1 %t19, label %then8, label %merge9
then8:
  %t20 = add i64 0, 2
  %t21 = call i8* @malloc(i64 %t20)
  store i8 92, i8* %t21
  %t22 = getelementptr i8, i8* %t21, i64 1
  store i8 0, i8* %t22
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  ret i8* %t21
merge9:
  call void @sailfin_runtime_mark_persistent(i8* %ch)
  ret i8* %ch
}

define i1 @is_two_char_symbol(i8* %value) {
block.entry:
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t2 = call i1 @strings_equal(i8* %value, i8* %s1)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t5 = call i1 @strings_equal(i8* %value, i8* %s4)
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445441, i32 0, i32 0
  %t8 = call i1 @strings_equal(i8* %value, i8* %s7)
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t11 = call i1 @strings_equal(i8* %value, i8* %s10)
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193444352, i32 0, i32 0
  %t14 = call i1 @strings_equal(i8* %value, i8* %s13)
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193446530, i32 0, i32 0
  %t17 = call i1 @strings_equal(i8* %value, i8* %s16)
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193419635, i32 0, i32 0
  %t20 = call i1 @strings_equal(i8* %value, i8* %s19)
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %s22 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193516127, i32 0, i32 0
  %t23 = call i1 @strings_equal(i8* %value, i8* %s22)
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t23, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428611, i32 0, i32 0
  %t25 = call i1 @strings_equal(i8* %value, i8* %s24)
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t26 = phi i1 [ true, %logical_or_entry_21 ], [ %t25, %logical_or_right_end_21 ]
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t27 = phi i1 [ true, %logical_or_entry_18 ], [ %t26, %logical_or_right_end_18 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t28 = phi i1 [ true, %logical_or_entry_15 ], [ %t27, %logical_or_right_end_15 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t29 = phi i1 [ true, %logical_or_entry_12 ], [ %t28, %logical_or_right_end_12 ]
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t30 = phi i1 [ true, %logical_or_entry_9 ], [ %t29, %logical_or_right_end_9 ]
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t31 = phi i1 [ true, %logical_or_entry_6 ], [ %t30, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t32 = phi i1 [ true, %logical_or_entry_3 ], [ %t31, %logical_or_right_end_3 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t33 = phi i1 [ true, %logical_or_entry_0 ], [ %t32, %logical_or_right_end_0 ]
  ret i1 %t33
}

define private double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len2.h193495007 = external constant [3 x i8]
@.enum.Expression.Array.variant = external constant [6 x i8]
@.enum.Statement.ImportDeclaration.variant = external constant [18 x i8]
@.enum.Statement.EnumDeclaration.variant = external constant [16 x i8]
@.enum.Statement.ReturnStatement.variant = external constant [16 x i8]
@.str.len19.h486335986 = external constant [20 x i8]
@.enum.Statement.Unknown.variant = external constant [8 x i8]
@.str.len13.h1570408460 = external constant [14 x i8]
@.enum.Statement.ContinueStatement.variant = external constant [18 x i8]
@.enum.Statement.MatchStatement.variant = external constant [15 x i8]
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
@.str.len2.h193425971 = external constant [3 x i8]
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
@.str.len2.h193479167 = external constant [3 x i8]
@.str.len10.h626550212 = external constant [11 x i8]
@.str.len10.h1720834339 = external constant [11 x i8]
@.str.len25.h403645876 = external constant [26 x i8]
@.str.len19.h2048588885 = external constant [20 x i8]
@.str.len22.h401021290 = external constant [23 x i8]
@.str.len23.h668778749 = external constant [24 x i8]
@.str.len14.h1053492670 = external constant [15 x i8]
@.str.len6.h807326654 = external constant [7 x i8]
@.str.len2.h193480817 = external constant [3 x i8]
@.str.len5.h1958778164 = external constant [6 x i8]
@.str.len3.h2090370613 = external constant [4 x i8]
@.str.len6.h980153509 = external constant [7 x i8]
@.str.len15.h1897143060 = external constant [16 x i8]
@.str.len10.h381722796 = external constant [11 x i8]
@.str.len9.h1814778076 = external constant [10 x i8]
@.str.len12.h2084565287 = external constant [13 x i8]
@.str.len2.h193478309 = external constant [3 x i8]
@.str.len6.h789270767 = external constant [7 x i8]
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
@.str.len7.h1483009776 = external constant [8 x i8]
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