; ModuleID = 'sailfin'
source_filename = "sailfin"

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

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
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
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

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
  ret i8* %s13
merge1:
  %t14 = load %Program, %Program* %l0
  %t15 = call i8* @emit_program(%Program %t14)
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
  %t61 = phi double [ %t35, %then0 ], [ %t60, %loop.latch4 ]
  store double %t61, double* %l3
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
  %t49 = fptosi double %t48 to i64
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t49, i64 %t52)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %t55)
  call void @sailfin_runtime_print_warn(i8* %t56)
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  br label %loop.latch4
loop.latch4:
  %t60 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t62 = load double, double* %l3
  br label %merge1
merge1:
  %t63 = load %LoweredPythonResult, %LoweredPythonResult* %l1
  %t64 = extractvalue %LoweredPythonResult %t63, 0
  %t65 = insertvalue %LoweredPythonResult undef, i8* %t64, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = insertvalue %LoweredPythonResult %t65, { i8**, i64 }* %t66, 1
  ret %LoweredPythonResult %t67
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
  %t61 = phi double [ %t35, %then0 ], [ %t60, %loop.latch4 ]
  store double %t61, double* %l3
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
  %t49 = fptosi double %t48 to i64
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t49, i64 %t52)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %t55)
  call void @sailfin_runtime_print_warn(i8* %t56)
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  br label %loop.latch4
loop.latch4:
  %t60 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t62 = load double, double* %l3
  br label %merge1
merge1:
  %t63 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t64 = extractvalue %LoweredLLVMResult %t63, 0
  %t65 = insertvalue %LoweredLLVMResult undef, i8* %t64, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = insertvalue %LoweredLLVMResult %t65, { i8**, i64 }* %t66, 1
  %t68 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t69 = extractvalue %LoweredLLVMResult %t68, 2
  %t70 = insertvalue %LoweredLLVMResult %t67, %TraitMetadata %t69, 2
  %t71 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t72 = extractvalue %LoweredLLVMResult %t71, 3
  %t73 = insertvalue %LoweredLLVMResult %t70, { %FunctionEffectEntry**, i64 }* %t72, 3
  %t74 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t75 = extractvalue %LoweredLLVMResult %t74, 4
  %t76 = insertvalue %LoweredLLVMResult %t73, { %LifetimeRegionMetadata**, i64 }* %t75, 4
  %t77 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t78 = extractvalue %LoweredLLVMResult %t77, 5
  %t79 = insertvalue %LoweredLLVMResult %t76, %CapabilityManifest %t78, 5
  %t80 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t81 = extractvalue %LoweredLLVMResult %t80, 6
  %t82 = insertvalue %LoweredLLVMResult %t79, { %StringConstant**, i64 }* %t81, 6
  ret %LoweredLLVMResult %t82
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
  %t61 = phi double [ %t35, %then0 ], [ %t60, %loop.latch4 ]
  store double %t61, double* %l3
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
  %t49 = fptosi double %t48 to i64
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t49, i64 %t52)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %s46, i8* %t55)
  call void @sailfin_runtime_print_warn(i8* %t56)
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  br label %loop.latch4
loop.latch4:
  %t60 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t62 = load double, double* %l3
  br label %merge1
merge1:
  %t63 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t64 = extractvalue %LoweredLLVMResult %t63, 0
  %t65 = insertvalue %LoweredLLVMResult undef, i8* %t64, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = insertvalue %LoweredLLVMResult %t65, { i8**, i64 }* %t66, 1
  %t68 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t69 = extractvalue %LoweredLLVMResult %t68, 2
  %t70 = insertvalue %LoweredLLVMResult %t67, %TraitMetadata %t69, 2
  %t71 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t72 = extractvalue %LoweredLLVMResult %t71, 3
  %t73 = insertvalue %LoweredLLVMResult %t70, { %FunctionEffectEntry**, i64 }* %t72, 3
  %t74 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t75 = extractvalue %LoweredLLVMResult %t74, 4
  %t76 = insertvalue %LoweredLLVMResult %t73, { %LifetimeRegionMetadata**, i64 }* %t75, 4
  %t77 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t78 = extractvalue %LoweredLLVMResult %t77, 5
  %t79 = insertvalue %LoweredLLVMResult %t76, %CapabilityManifest %t78, 5
  %t80 = load %LoweredLLVMResult, %LoweredLLVMResult* %l1
  %t81 = extractvalue %LoweredLLVMResult %t80, 6
  %t82 = insertvalue %LoweredLLVMResult %t79, { %StringConstant**, i64 }* %t81, 6
  %t83 = insertvalue %LLVMCompilationResult undef, %LoweredLLVMResult %t82, 0
  %t84 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t85 = extractvalue %EmitNativeResult %t84, 0
  %t86 = insertvalue %LLVMCompilationResult %t83, %NativeModule %t85, 1
  ret %LLVMCompilationResult %t86
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
  %t146 = phi { %LayoutManifest*, i64 }* [ %t15, %block.entry ], [ %t144, %loop.latch2 ]
  %t147 = phi double [ %t16, %block.entry ], [ %t145, %loop.latch2 ]
  store { %LayoutManifest*, i64 }* %t146, { %LayoutManifest*, i64 }** %l1
  store double %t147, double* %l2
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
  %t26 = fptosi double %t25 to i64
  %t27 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t28 = extractvalue { i8**, i64 } %t27, 0
  %t29 = extractvalue { i8**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr i8*, i8** %t28, i64 %t26
  %t32 = load i8*, i8** %t31
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t37 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = load i8*, i8** %l3
  br i1 %t35, label %then6, label %else7
then6:
  %t40 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t41 = getelementptr [0 x %NativeStruct*], [0 x %NativeStruct*]* null, i32 1
  %t42 = ptrtoint [0 x %NativeStruct*]* %t41 to i64
  %t43 = icmp eq i64 %t42, 0
  %t44 = select i1 %t43, i64 1, i64 %t42
  %t45 = call i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to %NativeStruct**
  %t47 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* null, i32 1
  %t48 = ptrtoint { %NativeStruct**, i64 }* %t47 to i64
  %t49 = call i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to { %NativeStruct**, i64 }*
  %t51 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* %t50, i32 0, i32 0
  store %NativeStruct** %t46, %NativeStruct*** %t51
  %t52 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  %t53 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t50, 0
  %t54 = getelementptr [0 x %NativeEnum*], [0 x %NativeEnum*]* null, i32 1
  %t55 = ptrtoint [0 x %NativeEnum*]* %t54 to i64
  %t56 = icmp eq i64 %t55, 0
  %t57 = select i1 %t56, i64 1, i64 %t55
  %t58 = call i8* @malloc(i64 %t57)
  %t59 = bitcast i8* %t58 to %NativeEnum**
  %t60 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* null, i32 1
  %t61 = ptrtoint { %NativeEnum**, i64 }* %t60 to i64
  %t62 = call i8* @malloc(i64 %t61)
  %t63 = bitcast i8* %t62 to { %NativeEnum**, i64 }*
  %t64 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* %t63, i32 0, i32 0
  store %NativeEnum** %t59, %NativeEnum*** %t64
  %t65 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* %t63, i32 0, i32 1
  store i64 0, i64* %t65
  %t66 = insertvalue %LayoutManifest %t53, { %NativeEnum**, i64 }* %t63, 1
  %t67 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t68 = ptrtoint [0 x i8*]* %t67 to i64
  %t69 = icmp eq i64 %t68, 0
  %t70 = select i1 %t69, i64 1, i64 %t68
  %t71 = call i8* @malloc(i64 %t70)
  %t72 = bitcast i8* %t71 to i8**
  %t73 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t74 = ptrtoint { i8**, i64 }* %t73 to i64
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to { i8**, i64 }*
  %t77 = getelementptr { i8**, i64 }, { i8**, i64 }* %t76, i32 0, i32 0
  store i8** %t72, i8*** %t77
  %t78 = getelementptr { i8**, i64 }, { i8**, i64 }* %t76, i32 0, i32 1
  store i64 0, i64* %t78
  %t79 = insertvalue %LayoutManifest %t66, { i8**, i64 }* %t76, 2
  %t80 = call noalias i8* @malloc(i64 24)
  %t81 = bitcast i8* %t80 to %LayoutManifest*
  store %LayoutManifest %t79, %LayoutManifest* %t81
  %t82 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t83 = ptrtoint [1 x i8*]* %t82 to i64
  %t84 = icmp eq i64 %t83, 0
  %t85 = select i1 %t84, i64 1, i64 %t83
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to i8**
  %t88 = getelementptr i8*, i8** %t87, i64 0
  store i8* %t80, i8** %t88
  %t89 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t90 = ptrtoint { i8**, i64 }* %t89 to i64
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to { i8**, i64 }*
  %t93 = getelementptr { i8**, i64 }, { i8**, i64 }* %t92, i32 0, i32 0
  store i8** %t87, i8*** %t93
  %t94 = getelementptr { i8**, i64 }, { i8**, i64 }* %t92, i32 0, i32 1
  store i64 1, i64* %t94
  %t95 = bitcast { %LayoutManifest*, i64 }* %t40 to { i8**, i64 }*
  %t96 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t95, { i8**, i64 }* %t92)
  %t97 = bitcast { i8**, i64 }* %t96 to { %LayoutManifest*, i64 }*
  store { %LayoutManifest*, i64 }* %t97, { %LayoutManifest*, i64 }** %l1
  %t98 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  br label %merge8
else7:
  %t99 = load i8*, i8** %l3
  %t100 = call %LayoutManifest @parse_layout_manifest(i8* %t99)
  store %LayoutManifest %t100, %LayoutManifest* %l4
  %t101 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t102 = load %LayoutManifest, %LayoutManifest* %l4
  %t103 = extractvalue %LayoutManifest %t102, 0
  %t104 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t103, 0
  %t105 = load %LayoutManifest, %LayoutManifest* %l4
  %t106 = extractvalue %LayoutManifest %t105, 1
  %t107 = insertvalue %LayoutManifest %t104, { %NativeEnum**, i64 }* %t106, 1
  %t108 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t109 = ptrtoint [0 x i8*]* %t108 to i64
  %t110 = icmp eq i64 %t109, 0
  %t111 = select i1 %t110, i64 1, i64 %t109
  %t112 = call i8* @malloc(i64 %t111)
  %t113 = bitcast i8* %t112 to i8**
  %t114 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t115 = ptrtoint { i8**, i64 }* %t114 to i64
  %t116 = call i8* @malloc(i64 %t115)
  %t117 = bitcast i8* %t116 to { i8**, i64 }*
  %t118 = getelementptr { i8**, i64 }, { i8**, i64 }* %t117, i32 0, i32 0
  store i8** %t113, i8*** %t118
  %t119 = getelementptr { i8**, i64 }, { i8**, i64 }* %t117, i32 0, i32 1
  store i64 0, i64* %t119
  %t120 = insertvalue %LayoutManifest %t107, { i8**, i64 }* %t117, 2
  %t121 = call noalias i8* @malloc(i64 24)
  %t122 = bitcast i8* %t121 to %LayoutManifest*
  store %LayoutManifest %t120, %LayoutManifest* %t122
  %t123 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t124 = ptrtoint [1 x i8*]* %t123 to i64
  %t125 = icmp eq i64 %t124, 0
  %t126 = select i1 %t125, i64 1, i64 %t124
  %t127 = call i8* @malloc(i64 %t126)
  %t128 = bitcast i8* %t127 to i8**
  %t129 = getelementptr i8*, i8** %t128, i64 0
  store i8* %t121, i8** %t129
  %t130 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t131 = ptrtoint { i8**, i64 }* %t130 to i64
  %t132 = call i8* @malloc(i64 %t131)
  %t133 = bitcast i8* %t132 to { i8**, i64 }*
  %t134 = getelementptr { i8**, i64 }, { i8**, i64 }* %t133, i32 0, i32 0
  store i8** %t128, i8*** %t134
  %t135 = getelementptr { i8**, i64 }, { i8**, i64 }* %t133, i32 0, i32 1
  store i64 1, i64* %t135
  %t136 = bitcast { %LayoutManifest*, i64 }* %t101 to { i8**, i64 }*
  %t137 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t136, { i8**, i64 }* %t133)
  %t138 = bitcast { i8**, i64 }* %t137 to { %LayoutManifest*, i64 }*
  store { %LayoutManifest*, i64 }* %t138, { %LayoutManifest*, i64 }** %l1
  %t139 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  br label %merge8
merge8:
  %t140 = phi { %LayoutManifest*, i64 }* [ %t98, %then6 ], [ %t139, %else7 ]
  store { %LayoutManifest*, i64 }* %t140, { %LayoutManifest*, i64 }** %l1
  %t141 = load double, double* %l2
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l2
  br label %loop.latch2
loop.latch2:
  %t144 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t145 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t148 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t149 = load double, double* %l2
  %t150 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t151 = extractvalue %EmitNativeResult %t150, 0
  %t152 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t153 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t154 = ptrtoint [0 x i8*]* %t153 to i64
  %t155 = icmp eq i64 %t154, 0
  %t156 = select i1 %t155, i64 1, i64 %t154
  %t157 = call i8* @malloc(i64 %t156)
  %t158 = bitcast i8* %t157 to i8**
  %t159 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t160 = ptrtoint { i8**, i64 }* %t159 to i64
  %t161 = call i8* @malloc(i64 %t160)
  %t162 = bitcast i8* %t161 to { i8**, i64 }*
  %t163 = getelementptr { i8**, i64 }, { i8**, i64 }* %t162, i32 0, i32 0
  store i8** %t158, i8*** %t163
  %t164 = getelementptr { i8**, i64 }, { i8**, i64 }* %t162, i32 0, i32 1
  store i64 0, i64* %t164
  %t165 = call %LoweredLLVMResult @lower_to_llvm_with_context(%NativeModule %t151, { %LayoutManifest*, i64 }* %t152, { i8**, i64 }* %native_artifacts, { i8**, i64 }* %t162)
  store %LoweredLLVMResult %t165, %LoweredLLVMResult* %l5
  %t166 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t167 = ptrtoint [0 x i8*]* %t166 to i64
  %t168 = icmp eq i64 %t167, 0
  %t169 = select i1 %t168, i64 1, i64 %t167
  %t170 = call i8* @malloc(i64 %t169)
  %t171 = bitcast i8* %t170 to i8**
  %t172 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t173 = ptrtoint { i8**, i64 }* %t172 to i64
  %t174 = call i8* @malloc(i64 %t173)
  %t175 = bitcast i8* %t174 to { i8**, i64 }*
  %t176 = getelementptr { i8**, i64 }, { i8**, i64 }* %t175, i32 0, i32 0
  store i8** %t171, i8*** %t176
  %t177 = getelementptr { i8**, i64 }, { i8**, i64 }* %t175, i32 0, i32 1
  store i64 0, i64* %t177
  store { i8**, i64 }* %t175, { i8**, i64 }** %l6
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t179 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t180 = extractvalue %EmitNativeResult %t179, 1
  %t181 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t178, { i8**, i64 }* %t180)
  store { i8**, i64 }* %t181, { i8**, i64 }** %l6
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t183 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t184 = extractvalue %LoweredLLVMResult %t183, 1
  %t185 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t182, { i8**, i64 }* %t184)
  store { i8**, i64 }* %t185, { i8**, i64 }** %l6
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t187 = load { i8**, i64 }, { i8**, i64 }* %t186
  %t188 = extractvalue { i8**, i64 } %t187, 1
  %t189 = icmp sgt i64 %t188, 0
  %t190 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t191 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t192 = load double, double* %l2
  %t193 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t189, label %then9, label %merge10
then9:
  %t195 = sitofp i64 0 to double
  store double %t195, double* %l7
  %t196 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t197 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t198 = load double, double* %l2
  %t199 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t201 = load double, double* %l7
  br label %loop.header11
loop.header11:
  %t229 = phi double [ %t201, %then9 ], [ %t228, %loop.latch13 ]
  store double %t229, double* %l7
  br label %loop.body12
loop.body12:
  %t202 = load double, double* %l7
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t204 = load { i8**, i64 }, { i8**, i64 }* %t203
  %t205 = extractvalue { i8**, i64 } %t204, 1
  %t206 = sitofp i64 %t205 to double
  %t207 = fcmp oge double %t202, %t206
  %t208 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t209 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t210 = load double, double* %l2
  %t211 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t213 = load double, double* %l7
  br i1 %t207, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %s214 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t216 = load double, double* %l7
  %t217 = fptosi double %t216 to i64
  %t218 = load { i8**, i64 }, { i8**, i64 }* %t215
  %t219 = extractvalue { i8**, i64 } %t218, 0
  %t220 = extractvalue { i8**, i64 } %t218, 1
  %t221 = icmp uge i64 %t217, %t220
  ; bounds check: %t221 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t217, i64 %t220)
  %t222 = getelementptr i8*, i8** %t219, i64 %t217
  %t223 = load i8*, i8** %t222
  %t224 = call i8* @sailfin_runtime_string_concat(i8* %s214, i8* %t223)
  call void @sailfin_runtime_print_warn(i8* %t224)
  %t225 = load double, double* %l7
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  store double %t227, double* %l7
  br label %loop.latch13
loop.latch13:
  %t228 = load double, double* %l7
  br label %loop.header11
afterloop14:
  %t230 = load double, double* %l7
  br label %merge10
merge10:
  %t231 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t232 = extractvalue %LoweredLLVMResult %t231, 0
  %t233 = insertvalue %LoweredLLVMResult undef, i8* %t232, 0
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t235 = insertvalue %LoweredLLVMResult %t233, { i8**, i64 }* %t234, 1
  %t236 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t237 = extractvalue %LoweredLLVMResult %t236, 2
  %t238 = insertvalue %LoweredLLVMResult %t235, %TraitMetadata %t237, 2
  %t239 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t240 = extractvalue %LoweredLLVMResult %t239, 3
  %t241 = insertvalue %LoweredLLVMResult %t238, { %FunctionEffectEntry**, i64 }* %t240, 3
  %t242 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t243 = extractvalue %LoweredLLVMResult %t242, 4
  %t244 = insertvalue %LoweredLLVMResult %t241, { %LifetimeRegionMetadata**, i64 }* %t243, 4
  %t245 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t246 = extractvalue %LoweredLLVMResult %t245, 5
  %t247 = insertvalue %LoweredLLVMResult %t244, %CapabilityManifest %t246, 5
  %t248 = load %LoweredLLVMResult, %LoweredLLVMResult* %l5
  %t249 = extractvalue %LoweredLLVMResult %t248, 6
  %t250 = insertvalue %LoweredLLVMResult %t247, { %StringConstant**, i64 }* %t249, 6
  ret %LoweredLLVMResult %t250
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
  %t61 = phi { i8**, i64 }* [ %t31, %merge1 ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t32, %merge1 ], [ %t60, %loop.latch4 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l2
  store double %t62, double* %l3
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
  %t43 = fptosi double %t42 to i64
  %t44 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t45 = extractvalue { %Diagnostic*, i64 } %t44, 0
  %t46 = extractvalue { %Diagnostic*, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t43, i64 %t46)
  %t48 = getelementptr %Diagnostic, %Diagnostic* %t45, i64 %t43
  %t49 = load %Diagnostic, %Diagnostic* %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = call i8* @format_typecheck_diagnostic(%Diagnostic %t49, { i8**, i64 }* %t50, double %t51)
  store i8* %t52, i8** %l4
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load i8*, i8** %l4
  %t55 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t53, i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l2
  %t56 = load double, double* %l3
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l3
  br label %loop.latch4
loop.latch4:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t60 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t64 = load double, double* %l3
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t65
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
  %t113 = phi double [ %t14, %block.entry ], [ %t112, %loop.latch2 ]
  store double %t113, double* %l3
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
  %t27 = fptosi double %t26 to i64
  %t28 = load { i8**, i64 }, { i8**, i64 }* %t25
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  store i8* %t33, i8** %l4
  %t34 = load i8*, i8** %l4
  %t35 = call { i8**, i64 }* @split_source_lines(i8* %t34)
  store { i8**, i64 }* %t35, { i8**, i64 }** %l5
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = icmp eq i64 %t38, 0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  %t44 = load i8*, i8** %l4
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t39, label %then6, label %merge7
then6:
  %t46 = load i8*, i8** %l1
  call void @sailfin_runtime_print_error(i8* %t46)
  %t47 = load double, double* %l3
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l3
  br label %loop.latch2
merge7:
  %t50 = sitofp i64 0 to double
  store double %t50, double* %l6
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l3
  %t55 = load i8*, i8** %l4
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t57 = load double, double* %l6
  br label %loop.header8
loop.header8:
  %t107 = phi double [ %t57, %merge7 ], [ %t106, %loop.latch10 ]
  store double %t107, double* %l6
  br label %loop.body9
loop.body9:
  %t58 = load double, double* %l6
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t60 = load { i8**, i64 }, { i8**, i64 }* %t59
  %t61 = extractvalue { i8**, i64 } %t60, 1
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp oge double %t58, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load i8*, i8** %l2
  %t67 = load double, double* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t70 = load double, double* %l6
  br i1 %t63, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t71 = load double, double* %l6
  %t72 = sitofp i64 0 to double
  %t73 = fcmp oeq double %t71, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load i8*, i8** %l2
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l4
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t80 = load double, double* %l6
  br i1 %t73, label %then14, label %else15
then14:
  %t81 = load i8*, i8** %l1
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t83 = load double, double* %l6
  %t84 = fptosi double %t83 to i64
  %t85 = load { i8**, i64 }, { i8**, i64 }* %t82
  %t86 = extractvalue { i8**, i64 } %t85, 0
  %t87 = extractvalue { i8**, i64 } %t85, 1
  %t88 = icmp uge i64 %t84, %t87
  ; bounds check: %t88 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t84, i64 %t87)
  %t89 = getelementptr i8*, i8** %t86, i64 %t84
  %t90 = load i8*, i8** %t89
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %t90)
  call void @sailfin_runtime_print_error(i8* %t91)
  br label %merge16
else15:
  %t92 = load i8*, i8** %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t94 = load double, double* %l6
  %t95 = fptosi double %t94 to i64
  %t96 = load { i8**, i64 }, { i8**, i64 }* %t93
  %t97 = extractvalue { i8**, i64 } %t96, 0
  %t98 = extractvalue { i8**, i64 } %t96, 1
  %t99 = icmp uge i64 %t95, %t98
  ; bounds check: %t99 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t95, i64 %t98)
  %t100 = getelementptr i8*, i8** %t97, i64 %t95
  %t101 = load i8*, i8** %t100
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %t101)
  call void @sailfin_runtime_print_error(i8* %t102)
  br label %merge16
merge16:
  %t103 = load double, double* %l6
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l6
  br label %loop.latch10
loop.latch10:
  %t106 = load double, double* %l6
  br label %loop.header8
afterloop11:
  %t108 = load double, double* %l6
  %t109 = load double, double* %l3
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  store double %t111, double* %l3
  br label %loop.latch2
loop.latch2:
  %t112 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t114 = load double, double* %l3
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
  ret i8* %t53
merge3:
  %t54 = load double, double* %l2
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  %t57 = fptosi double %t56 to i64
  %t58 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t59 = extractvalue { i8**, i64 } %t58, 0
  %t60 = extractvalue { i8**, i64 } %t58, 1
  %t61 = icmp uge i64 %t57, %t60
  ; bounds check: %t61 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t57, i64 %t60)
  %t62 = getelementptr i8*, i8** %t59, i64 %t57
  %t63 = load i8*, i8** %t62
  store i8* %t63, i8** %l5
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 32, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  %t68 = call i8* @repeat_character(i8* %t67, double %line_padding)
  store i8* %t68, i8** %l6
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l6
  %t71 = alloca [2 x i8], align 1
  %t72 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  store i8 32, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 1
  store i8 0, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  %t75 = call i8* @sailfin_runtime_string_concat(i8* %t74, i8* %t70)
  %s76 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %s76)
  %t78 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t69, i8* %t77)
  store { i8**, i64 }* %t78, { i8**, i64 }** %l0
  %t79 = load double, double* %l2
  %t80 = call i8* @number_to_string(double %t79)
  store i8* %t80, i8** %l7
  %s81 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s81, i8** %l8
  %t82 = load i8*, i8** %l7
  %t83 = call i64 @sailfin_runtime_string_length(i8* %t82)
  %t84 = sitofp i64 %t83 to double
  %t85 = fsub double %line_padding, %t84
  store double %t85, double* %l9
  %t86 = load double, double* %l9
  %t87 = sitofp i64 0 to double
  %t88 = fcmp olt double %t86, %t87
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load %Token*, %Token** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i8*, i8** %l4
  %t94 = load i8*, i8** %l5
  %t95 = load i8*, i8** %l6
  %t96 = load i8*, i8** %l7
  %t97 = load i8*, i8** %l8
  %t98 = load double, double* %l9
  br i1 %t88, label %then4, label %merge5
then4:
  %t99 = sitofp i64 0 to double
  store double %t99, double* %l9
  %t100 = load double, double* %l9
  br label %merge5
merge5:
  %t101 = phi double [ %t100, %then4 ], [ %t98, %merge3 ]
  store double %t101, double* %l9
  %t102 = load double, double* %l9
  %t103 = sitofp i64 0 to double
  %t104 = fcmp ogt double %t102, %t103
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load %Token*, %Token** %l1
  %t107 = load double, double* %l2
  %t108 = load double, double* %l3
  %t109 = load i8*, i8** %l4
  %t110 = load i8*, i8** %l5
  %t111 = load i8*, i8** %l6
  %t112 = load i8*, i8** %l7
  %t113 = load i8*, i8** %l8
  %t114 = load double, double* %l9
  br i1 %t104, label %then6, label %merge7
then6:
  %t115 = load double, double* %l9
  %t116 = alloca [2 x i8], align 1
  %t117 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 0
  store i8 32, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 1
  store i8 0, i8* %t118
  %t119 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 0
  %t120 = call i8* @repeat_character(i8* %t119, double %t115)
  store i8* %t120, i8** %l8
  %t121 = load i8*, i8** %l8
  br label %merge7
merge7:
  %t122 = phi i8* [ %t121, %then6 ], [ %t113, %merge5 ]
  store i8* %t122, i8** %l8
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load i8*, i8** %l8
  %t125 = alloca [2 x i8], align 1
  %t126 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8 32, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 1
  store i8 0, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  %t129 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t124)
  %t130 = load i8*, i8** %l7
  %t131 = call i8* @sailfin_runtime_string_concat(i8* %t129, i8* %t130)
  %s132 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087759686, i32 0, i32 0
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t131, i8* %s132)
  %t134 = load i8*, i8** %l5
  %t135 = call i8* @sailfin_runtime_string_concat(i8* %t133, i8* %t134)
  %t136 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t123, i8* %t135)
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load double, double* %l3
  %t138 = load %Token*, %Token** %l1
  %t139 = getelementptr %Token, %Token* %t138, i32 0, i32 1
  %t140 = load i8*, i8** %t139
  %t141 = load i8*, i8** %l5
  %t142 = call i8* @build_pointer_line(double %t137, i8* %t140, i8* %t141)
  store i8* %t142, i8** %l10
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load i8*, i8** %l6
  %t145 = alloca [2 x i8], align 1
  %t146 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 0
  store i8 32, i8* %t146
  %t147 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 1
  store i8 0, i8* %t147
  %t148 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 0
  %t149 = call i8* @sailfin_runtime_string_concat(i8* %t148, i8* %t144)
  %s150 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087759686, i32 0, i32 0
  %t151 = call i8* @sailfin_runtime_string_concat(i8* %t149, i8* %s150)
  %t152 = load i8*, i8** %l10
  %t153 = call i8* @sailfin_runtime_string_concat(i8* %t151, i8* %t152)
  %t154 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t143, i8* %t153)
  store { i8**, i64 }* %t154, { i8**, i64 }** %l0
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = call i8* @join_lines({ i8**, i64 }* %t155)
  ret i8* %t156
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
  %t100 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t97, %loop.latch2 ]
  %t101 = phi i8* [ %t15, %block.entry ], [ %t98, %loop.latch2 ]
  %t102 = phi double [ %t16, %block.entry ], [ %t99, %loop.latch2 ]
  store { i8**, i64 }* %t100, { i8**, i64 }** %l0
  store i8* %t101, i8** %l1
  store double %t102, double* %l2
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
  %t28 = fptosi double %t24 to i64
  %t29 = fptosi double %t27 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t28, i64 %t29)
  store i8* %t30, i8** %l3
  %t31 = load i8*, i8** %l3
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 13
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load i8*, i8** %l3
  br i1 %t33, label %then6, label %merge7
then6:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  %t40 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t38, i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  %s41 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s41, i8** %l1
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp olt double %t44, %t46
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load i8*, i8** %l3
  br i1 %t47, label %then8, label %merge9
then8:
  %t52 = load double, double* %l2
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  %t55 = load double, double* %l2
  %t56 = sitofp i64 2 to double
  %t57 = fadd double %t55, %t56
  %t58 = fptosi double %t54 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t58, i64 %t59)
  store i8* %t60, i8** %l4
  %t61 = load i8*, i8** %l4
  %t62 = load i8, i8* %t61
  %t63 = icmp eq i8 %t62, 10
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load i8*, i8** %l3
  %t68 = load i8*, i8** %l4
  br i1 %t63, label %then10, label %merge11
then10:
  %t69 = load double, double* %l2
  %t70 = sitofp i64 2 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l2
  br label %loop.latch2
merge11:
  %t72 = load double, double* %l2
  br label %merge9
merge9:
  %t73 = phi double [ %t72, %merge11 ], [ %t50, %then6 ]
  store double %t73, double* %l2
  %t74 = load double, double* %l2
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l2
  br label %loop.latch2
merge7:
  %t77 = load i8*, i8** %l3
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 10
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load i8*, i8** %l3
  br i1 %t79, label %then12, label %merge13
then12:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load i8*, i8** %l1
  %t86 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t84, i8* %t85)
  store { i8**, i64 }* %t86, { i8**, i64 }** %l0
  %s87 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s87, i8** %l1
  %t88 = load double, double* %l2
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l2
  br label %loop.latch2
merge13:
  %t91 = load i8*, i8** %l1
  %t92 = load i8*, i8** %l3
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %t92)
  store i8* %t93, i8** %l1
  %t94 = load double, double* %l2
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l2
  br label %loop.latch2
loop.latch2:
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load i8*, i8** %l1
  %t99 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load double, double* %l2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t106, i8* %t107)
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t109
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
  %t84 = phi i8* [ %t25, %merge5 ], [ %t82, %loop.latch8 ]
  %t85 = phi double [ %t26, %merge5 ], [ %t83, %loop.latch8 ]
  store i8* %t84, i8** %l1
  store double %t85, double* %l2
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
  %t44 = fptosi double %t42 to i64
  %t45 = fptosi double %t43 to i64
  %t46 = call i8* @sailfin_runtime_substring(i8* %line_text, i64 %t44, i64 %t45)
  store i8* %t46, i8** %l3
  %t47 = load i8*, i8** %l3
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t48, 9
  %t50 = load double, double* %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load i8*, i8** %l3
  br i1 %t49, label %then15, label %else16
then15:
  %t54 = load i8*, i8** %l1
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 9, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t58)
  store i8* %t59, i8** %l1
  %t60 = load i8*, i8** %l1
  br label %merge17
else16:
  %t61 = load i8*, i8** %l1
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 32, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t65)
  store i8* %t66, i8** %l1
  %t67 = load i8*, i8** %l1
  br label %merge17
merge17:
  %t68 = phi i8* [ %t60, %then15 ], [ %t67, %else16 ]
  store i8* %t68, i8** %l1
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l1
  br label %merge14
else13:
  %t71 = load i8*, i8** %l1
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 32, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t75)
  store i8* %t76, i8** %l1
  %t77 = load i8*, i8** %l1
  br label %merge14
merge14:
  %t78 = phi i8* [ %t69, %merge17 ], [ %t77, %else13 ]
  store i8* %t78, i8** %l1
  %t79 = load double, double* %l2
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l2
  br label %loop.latch8
loop.latch8:
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l2
  %t88 = call i64 @sailfin_runtime_string_length(i8* %lexeme)
  %t89 = sitofp i64 %t88 to double
  store double %t89, double* %l4
  %t90 = load double, double* %l4
  %t91 = sitofp i64 0 to double
  %t92 = fcmp ole double %t90, %t91
  %t93 = load double, double* %l0
  %t94 = load i8*, i8** %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l4
  br i1 %t92, label %then18, label %merge19
then18:
  %t97 = sitofp i64 1 to double
  store double %t97, double* %l4
  %t98 = load double, double* %l4
  br label %merge19
merge19:
  %t99 = phi double [ %t98, %then18 ], [ %t96, %afterloop9 ]
  store double %t99, double* %l4
  %t100 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t101 = load double, double* %l0
  %t102 = sitofp i64 1 to double
  %t103 = fsub double %t101, %t102
  %t104 = sitofp i64 %t100 to double
  %t105 = fsub double %t104, %t103
  store double %t105, double* %l5
  %t106 = load double, double* %l5
  %t107 = sitofp i64 0 to double
  %t108 = fcmp ole double %t106, %t107
  %t109 = load double, double* %l0
  %t110 = load i8*, i8** %l1
  %t111 = load double, double* %l2
  %t112 = load double, double* %l4
  %t113 = load double, double* %l5
  br i1 %t108, label %then20, label %merge21
then20:
  %t114 = sitofp i64 1 to double
  store double %t114, double* %l5
  %t115 = load double, double* %l5
  br label %merge21
merge21:
  %t116 = phi double [ %t115, %then20 ], [ %t113, %merge19 ]
  store double %t116, double* %l5
  %t117 = load double, double* %l4
  %t118 = load double, double* %l5
  %t119 = fcmp ogt double %t117, %t118
  %t120 = load double, double* %l0
  %t121 = load i8*, i8** %l1
  %t122 = load double, double* %l2
  %t123 = load double, double* %l4
  %t124 = load double, double* %l5
  br i1 %t119, label %then22, label %merge23
then22:
  %t125 = load double, double* %l5
  store double %t125, double* %l4
  %t126 = load double, double* %l4
  br label %merge23
merge23:
  %t127 = phi double [ %t126, %then22 ], [ %t123, %merge21 ]
  store double %t127, double* %l4
  %t128 = sitofp i64 0 to double
  store double %t128, double* %l6
  %t129 = load double, double* %l0
  %t130 = load i8*, i8** %l1
  %t131 = load double, double* %l2
  %t132 = load double, double* %l4
  %t133 = load double, double* %l5
  %t134 = load double, double* %l6
  br label %loop.header24
loop.header24:
  %t155 = phi i8* [ %t130, %merge23 ], [ %t153, %loop.latch26 ]
  %t156 = phi double [ %t134, %merge23 ], [ %t154, %loop.latch26 ]
  store i8* %t155, i8** %l1
  store double %t156, double* %l6
  br label %loop.body25
loop.body25:
  %t135 = load double, double* %l6
  %t136 = load double, double* %l4
  %t137 = fcmp oge double %t135, %t136
  %t138 = load double, double* %l0
  %t139 = load i8*, i8** %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l4
  %t142 = load double, double* %l5
  %t143 = load double, double* %l6
  br i1 %t137, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t144 = load i8*, i8** %l1
  %t145 = alloca [2 x i8], align 1
  %t146 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 0
  store i8 94, i8* %t146
  %t147 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 1
  store i8 0, i8* %t147
  %t148 = getelementptr [2 x i8], [2 x i8]* %t145, i32 0, i32 0
  %t149 = call i8* @sailfin_runtime_string_concat(i8* %t144, i8* %t148)
  store i8* %t149, i8** %l1
  %t150 = load double, double* %l6
  %t151 = sitofp i64 1 to double
  %t152 = fadd double %t150, %t151
  store double %t152, double* %l6
  br label %loop.latch26
loop.latch26:
  %t153 = load i8*, i8** %l1
  %t154 = load double, double* %l6
  br label %loop.header24
afterloop27:
  %t157 = load i8*, i8** %l1
  %t158 = load double, double* %l6
  %t159 = load i8*, i8** %l1
  ret i8* %t159
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
  %t40 = phi i8* [ %t11, %merge1 ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t12, %merge1 ], [ %t39, %loop.latch4 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
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
  %t27 = fptosi double %t26 to i64
  %t28 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t33)
  store i8* %t34, i8** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch4
loop.latch4:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l0
  ret i8* %t44
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
  %t79 = phi i8* [ %t25, %merge3 ], [ %t77, %loop.latch6 ]
  %t80 = phi double [ %t24, %merge3 ], [ %t78, %loop.latch6 ]
  store i8* %t79, i8** %l4
  store double %t80, double* %l3
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
  %t70 = fptosi double %t66 to i64
  %t71 = fptosi double %t69 to i64
  %t72 = call i8* @sailfin_runtime_substring(i8* %t65, i64 %t70, i64 %t71)
  store i8* %t72, i8** %l7
  %t73 = load i8*, i8** %l7
  %t74 = load i8*, i8** %l4
  %t75 = call i8* @sailfin_runtime_string_concat(i8* %t73, i8* %t74)
  store i8* %t75, i8** %l4
  %t76 = load double, double* %l6
  store double %t76, double* %l3
  br label %loop.latch6
loop.latch6:
  %t77 = load i8*, i8** %l4
  %t78 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t81 = load i8*, i8** %l4
  %t82 = load double, double* %l3
  %t83 = load i1, i1* %l1
  %t84 = load double, double* %l0
  %t85 = load i1, i1* %l1
  %t86 = load i8*, i8** %l2
  %t87 = load double, double* %l3
  %t88 = load i8*, i8** %l4
  br i1 %t83, label %then16, label %merge17
then16:
  %t89 = load i8*, i8** %l4
  %t90 = alloca [2 x i8], align 1
  %t91 = getelementptr [2 x i8], [2 x i8]* %t90, i32 0, i32 0
  store i8 45, i8* %t91
  %t92 = getelementptr [2 x i8], [2 x i8]* %t90, i32 0, i32 1
  store i8 0, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t90, i32 0, i32 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t89)
  store i8* %t94, i8** %l4
  %t95 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t96 = phi i8* [ %t95, %then16 ], [ %t88, %afterloop7 ]
  store i8* %t96, i8** %l4
  %t97 = load i8*, i8** %l4
  ret i8* %t97
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
  %t24 = phi double [ %t4, %merge1 ], [ %t23, %loop.latch4 ]
  store double %t24, double* %l0
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
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  %t14 = load double, double* %l0
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %prefix, i64 %t15
  %t17 = load i8, i8* %t16
  %t18 = icmp ne i8 %t13, %t17
  %t19 = load double, double* %l0
  br i1 %t18, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch4
loop.latch4:
  %t23 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t25 = load double, double* %l0
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
  %t57 = phi double [ %t6, %merge3 ], [ %t56, %loop.latch6 ]
  store double %t57, double* %l0
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
  %t45 = phi i1 [ %t17, %merge9 ], [ %t43, %loop.latch12 ]
  %t46 = phi double [ %t18, %merge9 ], [ %t44, %loop.latch12 ]
  store i1 %t45, i1* %l1
  store double %t46, double* %l2
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
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %value, i64 %t29
  %t31 = load i8, i8* %t30
  %t32 = load double, double* %l2
  %t33 = fptosi double %t32 to i64
  %t34 = getelementptr i8, i8* %pattern, i64 %t33
  %t35 = load i8, i8* %t34
  %t36 = icmp ne i8 %t31, %t35
  %t37 = load double, double* %l0
  %t38 = load i1, i1* %l1
  %t39 = load double, double* %l2
  br i1 %t36, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l2
  br label %loop.latch12
loop.latch12:
  %t43 = load i1, i1* %l1
  %t44 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t47 = load i1, i1* %l1
  %t48 = load double, double* %l2
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l0
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t53 = load double, double* %l0
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l0
  br label %loop.latch6
loop.latch6:
  %t56 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t58 = load double, double* %l0
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
  %t27 = fptosi double %t26 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %source, i64 0, i64 %t27)
  store i8* %t28, i8** %l5
  %t29 = load double, double* %l4
  %t30 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t31 = fptosi double %t29 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t31, i64 %t30)
  store i8* %t32, i8** %l6
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l6
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %t34)
  ret i8* %t35
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
  %t91 = phi i8* [ %t3, %block.entry ], [ %t89, %loop.latch2 ]
  %t92 = phi double [ %t2, %block.entry ], [ %t90, %loop.latch2 ]
  store i8* %t91, i8** %l1
  store double %t92, double* %l0
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
  %t14 = fptosi double %t10 to i64
  %t15 = fptosi double %t13 to i64
  %t16 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t14, i64 %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 39
  %t20 = load double, double* %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 39, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  %t28 = call double @python_quote_length(i8* %value, double %t23, i8* %t27)
  store double %t28, double* %l3
  %t29 = load double, double* %l3
  %t30 = alloca [2 x i8], align 1
  %t31 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  store i8 39, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 1
  store i8 0, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  %t34 = call i8* @repeat_character(i8* %t33, double %t29)
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l4
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load double, double* %l0
  %t39 = load double, double* %l3
  %t40 = fadd double %t38, %t39
  %t41 = load double, double* %l3
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 39, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call double @skip_python_string_literal(i8* %value, double %t40, i8* %t45, double %t41)
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
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 34, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call double @python_quote_length(i8* %value, double %t56, i8* %t60)
  store double %t61, double* %l5
  %t62 = load double, double* %l5
  %t63 = alloca [2 x i8], align 1
  %t64 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  store i8 34, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 1
  store i8 0, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  %t67 = call i8* @repeat_character(i8* %t66, double %t62)
  store i8* %t67, i8** %l6
  %t68 = load i8*, i8** %l1
  %t69 = load i8*, i8** %l6
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t68, i8* %t69)
  store i8* %t70, i8** %l1
  %t71 = load double, double* %l0
  %t72 = load double, double* %l5
  %t73 = fadd double %t71, %t72
  %t74 = load double, double* %l5
  %t75 = alloca [2 x i8], align 1
  %t76 = getelementptr [2 x i8], [2 x i8]* %t75, i32 0, i32 0
  store i8 34, i8* %t76
  %t77 = getelementptr [2 x i8], [2 x i8]* %t75, i32 0, i32 1
  store i8 0, i8* %t77
  %t78 = getelementptr [2 x i8], [2 x i8]* %t75, i32 0, i32 0
  %t79 = call double @skip_python_string_literal(i8* %value, double %t73, i8* %t78, double %t74)
  store double %t79, double* %l0
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l6
  %t82 = call i8* @sailfin_runtime_string_concat(i8* %t80, i8* %t81)
  store i8* %t82, i8** %l1
  br label %loop.latch2
merge9:
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t84)
  store i8* %t85, i8** %l1
  %t86 = load double, double* %l0
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l0
  br label %loop.latch2
loop.latch2:
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l0
  %t95 = load i8*, i8** %l1
  ret i8* %t95
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
  %t9 = fptosi double %t6 to i64
  %t10 = fptosi double %t8 to i64
  %t11 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t9, i64 %t10)
  %t12 = icmp eq i8* %t11, %delimiter
  br i1 %t12, label %then2, label %merge3
then2:
  %t13 = sitofp i64 2 to double
  %t14 = fadd double %start, %t13
  %t15 = sitofp i64 3 to double
  %t16 = fadd double %start, %t15
  %t17 = fptosi double %t14 to i64
  %t18 = fptosi double %t16 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t17, i64 %t18)
  %t20 = icmp eq i8* %t19, %delimiter
  br i1 %t20, label %then4, label %merge5
then4:
  %t21 = sitofp i64 3 to double
  ret double %t21
merge5:
  br label %merge3
merge3:
  br label %merge1
merge1:
  %t22 = sitofp i64 1 to double
  ret double %t22
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
  %t39 = phi double [ %t2, %then0 ], [ %t37, %loop.latch4 ]
  %t40 = phi i1 [ %t3, %then0 ], [ %t38, %loop.latch4 ]
  store double %t39, double* %l0
  store i1 %t40, i1* %l1
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
  %t15 = fptosi double %t11 to i64
  %t16 = fptosi double %t14 to i64
  %t17 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t15, i64 %t16)
  store i8* %t17, i8** %l2
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  %t21 = load i1, i1* %l1
  %t22 = load double, double* %l0
  %t23 = load i1, i1* %l1
  %t24 = load i8*, i8** %l2
  br i1 %t21, label %then8, label %merge9
then8:
  store i1 0, i1* %l1
  br label %loop.latch4
merge9:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 92
  %t28 = load double, double* %l0
  %t29 = load i1, i1* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then10, label %merge11
then10:
  store i1 1, i1* %l1
  br label %loop.latch4
merge11:
  %t31 = load i8*, i8** %l2
  %t32 = icmp eq i8* %t31, %delimiter
  %t33 = load double, double* %l0
  %t34 = load i1, i1* %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then12, label %merge13
then12:
  %t36 = load double, double* %l0
  ret double %t36
merge13:
  br label %loop.latch4
loop.latch4:
  %t37 = load double, double* %l0
  %t38 = load i1, i1* %l1
  br label %loop.header2
afterloop5:
  %t41 = load double, double* %l0
  %t42 = load i1, i1* %l1
  br label %merge1
merge1:
  store double %position, double* %l3
  %t43 = load double, double* %l3
  br label %loop.header14
loop.header14:
  %t97 = phi double [ %t43, %merge1 ], [ %t96, %loop.latch16 ]
  store double %t97, double* %l3
  br label %loop.body15
loop.body15:
  %t44 = load double, double* %l3
  %t45 = fadd double %t44, %quote_length
  %t46 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp ogt double %t45, %t47
  %t49 = load double, double* %l3
  br i1 %t48, label %then18, label %merge19
then18:
  %t50 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t51 = sitofp i64 %t50 to double
  ret double %t51
merge19:
  store i1 1, i1* %l4
  %t52 = sitofp i64 0 to double
  store double %t52, double* %l5
  %t53 = load double, double* %l3
  %t54 = load i1, i1* %l4
  %t55 = load double, double* %l5
  br label %loop.header20
loop.header20:
  %t83 = phi i1 [ %t54, %merge19 ], [ %t81, %loop.latch22 ]
  %t84 = phi double [ %t55, %merge19 ], [ %t82, %loop.latch22 ]
  store i1 %t83, i1* %l4
  store double %t84, double* %l5
  br label %loop.body21
loop.body21:
  %t56 = load double, double* %l5
  %t57 = fcmp oge double %t56, %quote_length
  %t58 = load double, double* %l3
  %t59 = load i1, i1* %l4
  %t60 = load double, double* %l5
  br i1 %t57, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t61 = load double, double* %l3
  %t62 = load double, double* %l5
  %t63 = fadd double %t61, %t62
  %t64 = load double, double* %l3
  %t65 = load double, double* %l5
  %t66 = fadd double %t64, %t65
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  %t69 = fptosi double %t63 to i64
  %t70 = fptosi double %t68 to i64
  %t71 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t69, i64 %t70)
  store i8* %t71, i8** %l6
  %t72 = load i8*, i8** %l6
  %t73 = icmp ne i8* %t72, %delimiter
  %t74 = load double, double* %l3
  %t75 = load i1, i1* %l4
  %t76 = load double, double* %l5
  %t77 = load i8*, i8** %l6
  br i1 %t73, label %then26, label %merge27
then26:
  store i1 0, i1* %l4
  br label %afterloop23
merge27:
  %t78 = load double, double* %l5
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l5
  br label %loop.latch22
loop.latch22:
  %t81 = load i1, i1* %l4
  %t82 = load double, double* %l5
  br label %loop.header20
afterloop23:
  %t85 = load i1, i1* %l4
  %t86 = load double, double* %l5
  %t87 = load i1, i1* %l4
  %t88 = load double, double* %l3
  %t89 = load i1, i1* %l4
  %t90 = load double, double* %l5
  br i1 %t87, label %then28, label %merge29
then28:
  %t91 = load double, double* %l3
  %t92 = fadd double %t91, %quote_length
  ret double %t92
merge29:
  %t93 = load double, double* %l3
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l3
  br label %loop.latch16
loop.latch16:
  %t96 = load double, double* %l3
  br label %loop.header14
afterloop17:
  %t98 = load double, double* %l3
  %t99 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t100 = sitofp i64 %t99 to double
  ret double %t100
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
  %t60 = phi double [ %t8, %merge3 ], [ %t59, %loop.latch6 ]
  store double %t60, double* %l0
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
  %t47 = phi i1 [ %t19, %merge9 ], [ %t45, %loop.latch12 ]
  %t48 = phi double [ %t20, %merge9 ], [ %t46, %loop.latch12 ]
  store i1 %t47, i1* %l1
  store double %t48, double* %l2
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
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %value, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = load double, double* %l2
  %t35 = fptosi double %t34 to i64
  %t36 = getelementptr i8, i8* %pattern, i64 %t35
  %t37 = load i8, i8* %t36
  %t38 = icmp ne i8 %t33, %t37
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
  %t55 = load double, double* %l0
  ret double %t55
merge19:
  %t56 = load double, double* %l0
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l0
  br label %loop.latch6
loop.latch6:
  %t59 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t61 = load double, double* %l0
  %t62 = sitofp i64 -1 to double
  ret double %t62
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
  %t59 = phi double [ %t7, %merge3 ], [ %t58, %loop.latch6 ]
  store double %t59, double* %l0
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
  %t46 = phi i1 [ %t18, %merge9 ], [ %t44, %loop.latch12 ]
  %t47 = phi double [ %t19, %merge9 ], [ %t45, %loop.latch12 ]
  store i1 %t46, i1* %l1
  store double %t47, double* %l2
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
  %t30 = fptosi double %t29 to i64
  %t31 = getelementptr i8, i8* %value, i64 %t30
  %t32 = load i8, i8* %t31
  %t33 = load double, double* %l2
  %t34 = fptosi double %t33 to i64
  %t35 = getelementptr i8, i8* %pattern, i64 %t34
  %t36 = load i8, i8* %t35
  %t37 = icmp ne i8 %t32, %t36
  %t38 = load double, double* %l0
  %t39 = load i1, i1* %l1
  %t40 = load double, double* %l2
  br i1 %t37, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l2
  br label %loop.latch12
loop.latch12:
  %t44 = load i1, i1* %l1
  %t45 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t48 = load i1, i1* %l1
  %t49 = load double, double* %l2
  %t50 = load i1, i1* %l1
  %t51 = load double, double* %l0
  %t52 = load i1, i1* %l1
  %t53 = load double, double* %l2
  br i1 %t50, label %then18, label %merge19
then18:
  %t54 = load double, double* %l0
  ret double %t54
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
  %t61 = sitofp i64 -1 to double
  ret double %t61
}

define double @advance_to_line_end(i8* %value, double %position) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t0, %block.entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t10 = fptosi double %t6 to i64
  %t11 = fptosi double %t9 to i64
  %t12 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t10, i64 %t11)
  store i8* %t12, i8** %l1
  %t13 = load double, double* %l0
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 10
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l0
  ret double %t24
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len38.h675779786 = private unnamed_addr constant [39 x i8] c"TokenKind.variant('NumberLiteral', [])\00"
@.str.len38.h1073483005 = private unnamed_addr constant [39 x i8] c"TokenKind.variant('StringLiteral', [])\00"
@.str.len5.h655249917 = private unnamed_addr constant [6 x i8] c"\0Alet \00"
@.str.len14.h129277126 = private unnamed_addr constant [15 x i8] c"ExpressionRaw(\00"
@.str.len9.h2073631692 = private unnamed_addr constant [10 x i8] c"[native] \00"
@.str.len5.h1517989476 = private unnamed_addr constant [6 x i8] c" mut \00"
@.str.len14.h2048158982 = private unnamed_addr constant [15 x i8] c"[native-llvm] \00"
@.str.len39.h459555839 = private unnamed_addr constant [40 x i8] c"TokenKind.variant('BooleanLiteral', [])\00"
@.str.len21.h1300292754 = private unnamed_addr constant [22 x i8] c"ExpressionIdentifier(\00"
@.str.len31.h76517386 = private unnamed_addr constant [32 x i8] c"TokenKind.variant('Symbol', [])\00"
@.str.len85.h1706301526 = private unnamed_addr constant [86 x i8] c"native backend: lowering produced unsupported python output; stage0 fallback disabled\00"
@.str.len35.h1158922578 = private unnamed_addr constant [36 x i8] c"TokenKind.variant('Identifier', [])\00"
@.str.len23.h2110906862 = private unnamed_addr constant [24 x i8] c"Expression.Identifier()\00"
@.str.len5.h1516228563 = private unnamed_addr constant [6 x i8] c" let \00"
@.str.len16.h1337894058 = private unnamed_addr constant [17 x i8] c"Expression.Raw()\00"
