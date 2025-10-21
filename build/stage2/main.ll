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
%Diagnostic = type { i8*, i8*, %Token* }
%SymbolEntry = type { i8*, i8*, %SourceSpan* }
%TypecheckResult = type { { %Diagnostic**, i64 }*, { %SymbolEntry**, i64 }* }
%SymbolCollectionResult = type { { %SymbolEntry**, i64 }*, { %Diagnostic**, i64 }* }
%ScopeResult = type { { %SymbolEntry**, i64 }*, { %Diagnostic**, i64 }* }

%NativeInstruction = type { i32, [48 x i8] }

; intrinsic sailfin_runtime_print_info requires capabilities: ![io]
declare void @sailfin_runtime_print_info(i8*)
; intrinsic sailfin_runtime_print_error requires capabilities: ![io]
declare void @sailfin_runtime_print_error(i8*)
; intrinsic sailfin_runtime_print_warn requires capabilities: ![io]
declare void @sailfin_runtime_print_warn(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.0 = private unnamed_addr constant [27 x i8] c"Sailfin compiler (stage 0)\00"
@.str.1 = private unnamed_addr constant [13 x i8] c"[typecheck] \00"
@.str.15 = private unnamed_addr constant [12 x i8] c"  --> line \00"
@.str.19 = private unnamed_addr constant [10 x i8] c", column \00"
@.str.63 = private unnamed_addr constant [3 x i8] c" |\00"
@.str.73 = private unnamed_addr constant [1 x i8] c"\00"
@.str.120 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.138 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.20 = private unnamed_addr constant [1 x i8] c"\00"
@.str.13 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.8 = private unnamed_addr constant [13 x i8] c"return False\00"
@.str.4 = private unnamed_addr constant [1 x i8] c"\00"
@.str.10 = private unnamed_addr constant [1 x i8] c"\00"

; fn compile_to_sailfin effects: ![io]
define i8* @compile_to_sailfin(i8* %source) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call double @parse_program(i8* %source)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @typecheck_program(double %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load double, double* %l0
  %t5 = call double @emit_program(double %t4)
  ret i8* null
}

; fn compile_to_native effects: ![io]
define %EmitNativeResult @compile_to_native(i8* %source) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call double @parse_program(i8* %source)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @typecheck_program(double %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load double, double* %l0
  %t5 = call double @emit_native(double %t4)
  ret %EmitNativeResult zeroinitializer
}

; fn compile_to_native_python effects: ![io]
define %LoweredPythonResult @compile_to_native_python(i8* %source) {
entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t2 = extractvalue %EmitNativeResult %t1, 0
  %t3 = call double @lower_to_python(%NativeModule %t2)
  store double %t3, double* %l1
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t11 = extractvalue %EmitNativeResult %t10, 1
  %t12 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t9, { i8**, i64 }* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l2
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = icmp sgt i64 %t17, 0
  %t19 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t20 = load double, double* %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t52 = phi double [ %t26, %then0 ], [ %t51, %loop.latch4 ]
  store double %t52, double* %l3
  br label %loop.body3
loop.body3:
  %t27 = load double, double* %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t29 = load { i8**, i64 }, { i8**, i64 }* %t28
  %t30 = extractvalue { i8**, i64 } %t29, 1
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t27, %t31
  %t33 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t34 = load double, double* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %s37 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.37, i32 0, i32 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load double, double* %l3
  %t40 = fptosi double %t39 to i64
  %t41 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 %t40
  %t46 = load i8*, i8** %t45
  %t47 = add i8* %s37, %t46
  call void @sailfin_runtime_print_warn(i8* %t47)
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  br label %loop.latch4
loop.latch4:
  %t51 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t53 = load double, double* %l1
  %t54 = insertvalue %LoweredPythonResult undef, i8* null, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = insertvalue %LoweredPythonResult %t54, { i8**, i64 }* %t55, 1
  ret %LoweredPythonResult %t56
}

; fn compile_to_native_llvm effects: ![io]
define %LoweredLLVMResult @compile_to_native_llvm(i8* %source) {
entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t2 = extractvalue %EmitNativeResult %t1, 0
  %t3 = call double @lower_to_llvm(%NativeModule %t2)
  store double %t3, double* %l1
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t11 = extractvalue %EmitNativeResult %t10, 1
  %t12 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t9, { i8**, i64 }* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l2
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = icmp sgt i64 %t17, 0
  %t19 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t20 = load double, double* %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t52 = phi double [ %t26, %then0 ], [ %t51, %loop.latch4 ]
  store double %t52, double* %l3
  br label %loop.body3
loop.body3:
  %t27 = load double, double* %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t29 = load { i8**, i64 }, { i8**, i64 }* %t28
  %t30 = extractvalue { i8**, i64 } %t29, 1
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t27, %t31
  %t33 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t34 = load double, double* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %s37 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.37, i32 0, i32 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load double, double* %l3
  %t40 = fptosi double %t39 to i64
  %t41 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 %t40
  %t46 = load i8*, i8** %t45
  %t47 = add i8* %s37, %t46
  call void @sailfin_runtime_print_warn(i8* %t47)
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  br label %loop.latch4
loop.latch4:
  %t51 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t53 = load double, double* %l1
  %t54 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = insertvalue %LoweredLLVMResult %t54, { i8**, i64 }* %t55, 1
  %t57 = load double, double* %l1
  %t58 = insertvalue %LoweredLLVMResult %t56, %TraitMetadata zeroinitializer, 2
  %t59 = load double, double* %l1
  %t60 = insertvalue %LoweredLLVMResult %t58, { %FunctionEffectEntry**, i64 }* null, 3
  %t61 = load double, double* %l1
  %t62 = insertvalue %LoweredLLVMResult %t60, { %LifetimeRegionMetadata**, i64 }* null, 4
  %t63 = load double, double* %l1
  %t64 = insertvalue %LoweredLLVMResult %t62, %CapabilityManifest zeroinitializer, 5
  %t65 = load double, double* %l1
  %t66 = insertvalue %LoweredLLVMResult %t64, { %StringConstant**, i64 }* null, 6
  ret %LoweredLLVMResult %t66
}

; fn compile_to_native_llvm_full effects: ![io]
define %LLVMCompilationResult @compile_to_native_llvm_full(i8* %source) {
entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t2 = extractvalue %EmitNativeResult %t1, 0
  %t3 = call double @lower_to_llvm(%NativeModule %t2)
  store double %t3, double* %l1
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t11 = extractvalue %EmitNativeResult %t10, 1
  %t12 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t9, { i8**, i64 }* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l2
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = icmp sgt i64 %t17, 0
  %t19 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t20 = load double, double* %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t52 = phi double [ %t26, %then0 ], [ %t51, %loop.latch4 ]
  store double %t52, double* %l3
  br label %loop.body3
loop.body3:
  %t27 = load double, double* %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t29 = load { i8**, i64 }, { i8**, i64 }* %t28
  %t30 = extractvalue { i8**, i64 } %t29, 1
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t27, %t31
  %t33 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t34 = load double, double* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %s37 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.37, i32 0, i32 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load double, double* %l3
  %t40 = fptosi double %t39 to i64
  %t41 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 %t40
  %t46 = load i8*, i8** %t45
  %t47 = add i8* %s37, %t46
  call void @sailfin_runtime_print_warn(i8* %t47)
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  br label %loop.latch4
loop.latch4:
  %t51 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t53 = load double, double* %l1
  %t54 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = insertvalue %LoweredLLVMResult %t54, { i8**, i64 }* %t55, 1
  %t57 = load double, double* %l1
  %t58 = insertvalue %LoweredLLVMResult %t56, %TraitMetadata zeroinitializer, 2
  %t59 = load double, double* %l1
  %t60 = insertvalue %LoweredLLVMResult %t58, { %FunctionEffectEntry**, i64 }* null, 3
  %t61 = load double, double* %l1
  %t62 = insertvalue %LoweredLLVMResult %t60, { %LifetimeRegionMetadata**, i64 }* null, 4
  %t63 = load double, double* %l1
  %t64 = insertvalue %LoweredLLVMResult %t62, %CapabilityManifest zeroinitializer, 5
  %t65 = load double, double* %l1
  %t66 = insertvalue %LoweredLLVMResult %t64, { %StringConstant**, i64 }* null, 6
  %t67 = insertvalue %LLVMCompilationResult undef, %LoweredLLVMResult %t66, 0
  %t68 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t69 = extractvalue %EmitNativeResult %t68, 0
  %t70 = insertvalue %LLVMCompilationResult %t67, %NativeModule %t69, 1
  ret %LLVMCompilationResult %t70
}

; fn compile_to_native_llvm_with_context effects: ![io]
define %LoweredLLVMResult @compile_to_native_llvm_with_context(i8* %source, { i8**, i64 }* %manifest_contents, { i8**, i64 }* %native_artifacts) {
entry:
  %l0 = alloca %EmitNativeResult
  %l1 = alloca { %LayoutManifest*, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %t0 = call %EmitNativeResult @compile_to_native(i8* %source)
  store %EmitNativeResult %t0, %EmitNativeResult* %l0
  %t1 = alloca [0 x %LayoutManifest]
  %t2 = getelementptr [0 x %LayoutManifest], [0 x %LayoutManifest]* %t1, i32 0, i32 0
  %t3 = alloca { %LayoutManifest*, i64 }
  %t4 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t3, i32 0, i32 0
  store %LayoutManifest* %t2, %LayoutManifest** %t4
  %t5 = getelementptr { %LayoutManifest*, i64 }, { %LayoutManifest*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %LayoutManifest*, i64 }* %t3, { %LayoutManifest*, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t8 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t83 = phi { %LayoutManifest*, i64 }* [ %t8, %entry ], [ %t81, %loop.latch2 ]
  %t84 = phi double [ %t9, %entry ], [ %t82, %loop.latch2 ]
  store { %LayoutManifest*, i64 }* %t83, { %LayoutManifest*, i64 }** %l1
  store double %t84, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t16 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load double, double* %l2
  %t19 = fptosi double %t18 to i64
  %t20 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = icmp eq i64 %t27, 0
  %t29 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t30 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = load i8*, i8** %l3
  br i1 %t28, label %then6, label %else7
then6:
  %t33 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t34 = alloca [0 x %NativeStruct*]
  %t35 = getelementptr [0 x %NativeStruct*], [0 x %NativeStruct*]* %t34, i32 0, i32 0
  %t36 = alloca { %NativeStruct**, i64 }
  %t37 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* %t36, i32 0, i32 0
  store %NativeStruct** %t35, %NativeStruct*** %t37
  %t38 = getelementptr { %NativeStruct**, i64 }, { %NativeStruct**, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  %t39 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t36, 0
  %t40 = alloca [0 x %NativeEnum*]
  %t41 = getelementptr [0 x %NativeEnum*], [0 x %NativeEnum*]* %t40, i32 0, i32 0
  %t42 = alloca { %NativeEnum**, i64 }
  %t43 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* %t42, i32 0, i32 0
  store %NativeEnum** %t41, %NativeEnum*** %t43
  %t44 = getelementptr { %NativeEnum**, i64 }, { %NativeEnum**, i64 }* %t42, i32 0, i32 1
  store i64 0, i64* %t44
  %t45 = insertvalue %LayoutManifest %t39, { %NativeEnum**, i64 }* %t42, 1
  %t46 = alloca [0 x i8*]
  %t47 = getelementptr [0 x i8*], [0 x i8*]* %t46, i32 0, i32 0
  %t48 = alloca { i8**, i64 }
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t47, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  %t51 = insertvalue %LayoutManifest %t45, { i8**, i64 }* %t48, 2
  %t52 = call noalias i8* @malloc(i64 24)
  %t53 = bitcast i8* %t52 to %LayoutManifest*
  store %LayoutManifest %t51, %LayoutManifest* %t53
  %t54 = alloca [1 x i8*]
  %t55 = getelementptr [1 x i8*], [1 x i8*]* %t54, i32 0, i32 0
  %t56 = getelementptr i8*, i8** %t55, i64 0
  store i8* %t52, i8** %t56
  %t57 = alloca { i8**, i64 }
  %t58 = getelementptr { i8**, i64 }, { i8**, i64 }* %t57, i32 0, i32 0
  store i8** %t55, i8*** %t58
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* %t57, i32 0, i32 1
  store i64 1, i64* %t59
  %t60 = bitcast { %LayoutManifest*, i64 }* %t33 to { i8**, i64 }*
  %t61 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t60, { i8**, i64 }* %t57)
  %t62 = bitcast { i8**, i64 }* %t61 to { %LayoutManifest*, i64 }*
  store { %LayoutManifest*, i64 }* %t62, { %LayoutManifest*, i64 }** %l1
  br label %merge8
else7:
  %t63 = load i8*, i8** %l3
  %t64 = call double @parse_layout_manifest(i8* %t63)
  store double %t64, double* %l4
  %t65 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t66 = load double, double* %l4
  %t67 = alloca [1 x double]
  %t68 = getelementptr [1 x double], [1 x double]* %t67, i32 0, i32 0
  %t69 = getelementptr double, double* %t68, i64 0
  store double %t66, double* %t69
  %t70 = alloca { double*, i64 }
  %t71 = getelementptr { double*, i64 }, { double*, i64 }* %t70, i32 0, i32 0
  store double* %t68, double** %t71
  %t72 = getelementptr { double*, i64 }, { double*, i64 }* %t70, i32 0, i32 1
  store i64 1, i64* %t72
  %t73 = bitcast { %LayoutManifest*, i64 }* %t65 to { i8**, i64 }*
  %t74 = bitcast { double*, i64 }* %t70 to { i8**, i64 }*
  %t75 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t73, { i8**, i64 }* %t74)
  %t76 = bitcast { i8**, i64 }* %t75 to { %LayoutManifest*, i64 }*
  store { %LayoutManifest*, i64 }* %t76, { %LayoutManifest*, i64 }** %l1
  br label %merge8
merge8:
  %t77 = phi { %LayoutManifest*, i64 }* [ %t62, %then6 ], [ %t76, %else7 ]
  store { %LayoutManifest*, i64 }* %t77, { %LayoutManifest*, i64 }** %l1
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch2
loop.latch2:
  %t81 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t82 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t85 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t86 = extractvalue %EmitNativeResult %t85, 0
  %t87 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t88 = call double @lower_to_llvm_with_context(%NativeModule %t86, { %LayoutManifest*, i64 }* %t87, { i8**, i64 }* %native_artifacts)
  store double %t88, double* %l5
  %t89 = alloca [0 x i8*]
  %t90 = getelementptr [0 x i8*], [0 x i8*]* %t89, i32 0, i32 0
  %t91 = alloca { i8**, i64 }
  %t92 = getelementptr { i8**, i64 }, { i8**, i64 }* %t91, i32 0, i32 0
  store i8** %t90, i8*** %t92
  %t93 = getelementptr { i8**, i64 }, { i8**, i64 }* %t91, i32 0, i32 1
  store i64 0, i64* %t93
  store { i8**, i64 }* %t91, { i8**, i64 }** %l6
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t95 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t96 = extractvalue %EmitNativeResult %t95, 1
  %t97 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t94, { i8**, i64 }* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l6
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t99 = load double, double* %l5
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = icmp sgt i64 %t102, 0
  %t104 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t105 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l5
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t103, label %then9, label %merge10
then9:
  %t109 = sitofp i64 0 to double
  store double %t109, double* %l7
  %t110 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t111 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l5
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t115 = load double, double* %l7
  br label %loop.header11
loop.header11:
  %t143 = phi double [ %t115, %then9 ], [ %t142, %loop.latch13 ]
  store double %t143, double* %l7
  br label %loop.body12
loop.body12:
  %t116 = load double, double* %l7
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t118 = load { i8**, i64 }, { i8**, i64 }* %t117
  %t119 = extractvalue { i8**, i64 } %t118, 1
  %t120 = sitofp i64 %t119 to double
  %t121 = fcmp oge double %t116, %t120
  %t122 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t123 = load { %LayoutManifest*, i64 }*, { %LayoutManifest*, i64 }** %l1
  %t124 = load double, double* %l2
  %t125 = load double, double* %l5
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t127 = load double, double* %l7
  br i1 %t121, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %s128 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.128, i32 0, i32 0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t130 = load double, double* %l7
  %t131 = fptosi double %t130 to i64
  %t132 = load { i8**, i64 }, { i8**, i64 }* %t129
  %t133 = extractvalue { i8**, i64 } %t132, 0
  %t134 = extractvalue { i8**, i64 } %t132, 1
  %t135 = icmp uge i64 %t131, %t134
  ; bounds check: %t135 (if true, out of bounds)
  %t136 = getelementptr i8*, i8** %t133, i64 %t131
  %t137 = load i8*, i8** %t136
  %t138 = add i8* %s128, %t137
  call void @sailfin_runtime_print_warn(i8* %t138)
  %t139 = load double, double* %l7
  %t140 = sitofp i64 1 to double
  %t141 = fadd double %t139, %t140
  store double %t141, double* %l7
  br label %loop.latch13
loop.latch13:
  %t142 = load double, double* %l7
  br label %loop.header11
afterloop14:
  br label %merge10
merge10:
  %t144 = load double, double* %l5
  %t145 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t147 = insertvalue %LoweredLLVMResult %t145, { i8**, i64 }* %t146, 1
  %t148 = load double, double* %l5
  %t149 = insertvalue %LoweredLLVMResult %t147, %TraitMetadata zeroinitializer, 2
  %t150 = load double, double* %l5
  %t151 = insertvalue %LoweredLLVMResult %t149, { %FunctionEffectEntry**, i64 }* null, 3
  %t152 = load double, double* %l5
  %t153 = insertvalue %LoweredLLVMResult %t151, { %LifetimeRegionMetadata**, i64 }* null, 4
  %t154 = load double, double* %l5
  %t155 = insertvalue %LoweredLLVMResult %t153, %CapabilityManifest zeroinitializer, 5
  %t156 = load double, double* %l5
  %t157 = insertvalue %LoweredLLVMResult %t155, { %StringConstant**, i64 }* null, 6
  ret %LoweredLLVMResult %t157
}

; fn compile_to_native_llvm_with_manifests effects: ![io]
define %LoweredLLVMResult @compile_to_native_llvm_with_manifests(i8* %source, { i8**, i64 }* %manifest_contents) {
entry:
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = call %LoweredLLVMResult @compile_to_native_llvm_with_context(i8* %source, { i8**, i64 }* %manifest_contents, { i8**, i64 }* %t2)
  ret %LoweredLLVMResult %t5
}

; fn main effects: ![io]
define void @main() {
entry:
  %s0 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.0, i32 0, i32 0
  call void @sailfin_runtime_print_info(i8* %s0)
  ret void
}

; fn compile_project effects: ![io]
define %ProjectCompilation @compile_project({ i8**, i64 }* %sources) {
entry:
  %l0 = alloca { %CompiledModule*, i64 }*
  %l1 = alloca { %ModuleDiagnostics*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %ModuleCompilationResult
  %t0 = alloca [0 x %CompiledModule]
  %t1 = getelementptr [0 x %CompiledModule], [0 x %CompiledModule]* %t0, i32 0, i32 0
  %t2 = alloca { %CompiledModule*, i64 }
  %t3 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t2, i32 0, i32 0
  store %CompiledModule* %t1, %CompiledModule** %t3
  %t4 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %CompiledModule*, i64 }* %t2, { %CompiledModule*, i64 }** %l0
  %t5 = alloca [0 x %ModuleDiagnostics]
  %t6 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* %t5, i32 0, i32 0
  %t7 = alloca { %ModuleDiagnostics*, i64 }
  %t8 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t7, i32 0, i32 0
  store %ModuleDiagnostics* %t6, %ModuleDiagnostics** %t8
  %t9 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %ModuleDiagnostics*, i64 }* %t7, { %ModuleDiagnostics*, i64 }** %l1
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 1
  %t11 = load i64, i64* %t10
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 0
  %t13 = load i8**, i8*** %t12
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t14 = load i64, i64* %l2
  %t15 = icmp slt i64 %t14, %t11
  br i1 %t15, label %forbody1, label %afterfor3
forbody1:
  %t16 = load i64, i64* %l2
  %t17 = getelementptr i8*, i8** %t13, i64 %t16
  %t18 = load i8*, i8** %t17
  store i8* %t18, i8** %l3
  %t19 = load i8*, i8** %l3
  %t20 = call %ModuleCompilationResult @compile_source_at_path(i8* %t19)
  store %ModuleCompilationResult %t20, %ModuleCompilationResult* %l4
  %t21 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t22 = extractvalue %ModuleCompilationResult %t21, 0
  %t23 = bitcast i8* null to %CompiledModule*
  %t24 = icmp ne %CompiledModule* %t22, %t23
  %t25 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t26 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t27 = load i8*, i8** %l3
  %t28 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t24, label %then4, label %merge5
then4:
  %t29 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t30 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t31 = extractvalue %ModuleCompilationResult %t30, 0
  %t32 = bitcast %CompiledModule* %t31 to i8*
  %t33 = alloca [1 x i8*]
  %t34 = getelementptr [1 x i8*], [1 x i8*]* %t33, i32 0, i32 0
  %t35 = getelementptr i8*, i8** %t34, i64 0
  store i8* %t32, i8** %t35
  %t36 = alloca { i8**, i64 }
  %t37 = getelementptr { i8**, i64 }, { i8**, i64 }* %t36, i32 0, i32 0
  store i8** %t34, i8*** %t37
  %t38 = getelementptr { i8**, i64 }, { i8**, i64 }* %t36, i32 0, i32 1
  store i64 1, i64* %t38
  %t39 = bitcast { %CompiledModule*, i64 }* %t29 to { i8**, i64 }*
  %t40 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t39, { i8**, i64 }* %t36)
  %t41 = bitcast { i8**, i64 }* %t40 to { %CompiledModule*, i64 }*
  store { %CompiledModule*, i64 }* %t41, { %CompiledModule*, i64 }** %l0
  br label %merge5
merge5:
  %t42 = phi { %CompiledModule*, i64 }* [ %t41, %then4 ], [ %t25, %forbody1 ]
  store { %CompiledModule*, i64 }* %t42, { %CompiledModule*, i64 }** %l0
  %t43 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t44 = extractvalue %ModuleCompilationResult %t43, 1
  %t45 = load { %ModuleDiagnostics**, i64 }, { %ModuleDiagnostics**, i64 }* %t44
  %t46 = extractvalue { %ModuleDiagnostics**, i64 } %t45, 1
  %t47 = icmp sgt i64 %t46, 0
  %t48 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t49 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t50 = load i8*, i8** %l3
  %t51 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t47, label %then6, label %merge7
then6:
  %t52 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t53 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t54 = extractvalue %ModuleCompilationResult %t53, 1
  %t55 = bitcast { %ModuleDiagnostics*, i64 }* %t52 to { i8**, i64 }*
  %t56 = bitcast { %ModuleDiagnostics**, i64 }* %t54 to { i8**, i64 }*
  %t57 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t55, { i8**, i64 }* %t56)
  %t58 = bitcast { i8**, i64 }* %t57 to { %ModuleDiagnostics*, i64 }*
  store { %ModuleDiagnostics*, i64 }* %t58, { %ModuleDiagnostics*, i64 }** %l1
  br label %merge7
merge7:
  %t59 = phi { %ModuleDiagnostics*, i64 }* [ %t58, %then6 ], [ %t49, %forbody1 ]
  store { %ModuleDiagnostics*, i64 }* %t59, { %ModuleDiagnostics*, i64 }** %l1
  br label %forinc2
forinc2:
  %t60 = load i64, i64* %l2
  %t61 = add i64 %t60, 1
  store i64 %t61, i64* %l2
  br label %for0
afterfor3:
  %t62 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t63 = bitcast { %CompiledModule*, i64 }* %t62 to { %CompiledModule**, i64 }*
  %t64 = insertvalue %ProjectCompilation undef, { %CompiledModule**, i64 }* %t63, 0
  %t65 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t66 = bitcast { %ModuleDiagnostics*, i64 }* %t65 to { %ModuleDiagnostics**, i64 }*
  %t67 = insertvalue %ProjectCompilation %t64, { %ModuleDiagnostics**, i64 }* %t66, 1
  ret %ProjectCompilation %t67
}

; fn compile_source_at_path effects: ![io]
define %ModuleCompilationResult @compile_source_at_path(i8* %source_path) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca { %ModuleDiagnostics*, i64 }*
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = call double @parse_program(double %t0)
  store double %t1, double* %l1
  %t2 = load double, double* %l1
  %t3 = call double @typecheck_program(double %t2)
  store double %t3, double* %l2
  %t4 = load double, double* %l2
  %t5 = load double, double* %l1
  %t6 = call double @emit_native(double %t5)
  store double %t6, double* %l3
  %t7 = load double, double* %l3
  store double 0.0, double* %l4
  %t8 = load double, double* %l3
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t9 = load double, double* %l4
  store double 0.0, double* %l6
  %t10 = load double, double* %l6
  %t11 = call i1 @needs_python_fallback(i8* null)
  store i1 %t11, i1* %l7
  %t12 = load i1, i1* %l7
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  %t17 = load double, double* %l4
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t19 = load double, double* %l6
  %t20 = load i1, i1* %l7
  br i1 %t12, label %then0, label %merge1
then0:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s22 = getelementptr inbounds [86 x i8], [86 x i8]* @.str.22, i32 0, i32 0
  %t23 = alloca [1 x i8*]
  %t24 = getelementptr [1 x i8*], [1 x i8*]* %t23, i32 0, i32 0
  %t25 = getelementptr i8*, i8** %t24, i64 0
  store i8* %s22, i8** %t25
  %t26 = alloca { i8**, i64 }
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t26, i32 0, i32 0
  store i8** %t24, i8*** %t27
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  %t29 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t21, { i8**, i64 }* %t26)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l5
  %t30 = bitcast i8* null to %CompiledModule*
  %t31 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t30, 0
  %t32 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t34 = insertvalue %ModuleDiagnostics %t32, { i8**, i64 }* %t33, 1
  %t35 = insertvalue %ModuleDiagnostics %t34, i1 1, 2
  %t36 = alloca [1 x %ModuleDiagnostics]
  %t37 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* %t36, i32 0, i32 0
  %t38 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t37, i64 0
  store %ModuleDiagnostics %t35, %ModuleDiagnostics* %t38
  %t39 = alloca { %ModuleDiagnostics*, i64 }
  %t40 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t39, i32 0, i32 0
  store %ModuleDiagnostics* %t37, %ModuleDiagnostics** %t40
  %t41 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = bitcast { %ModuleDiagnostics*, i64 }* %t39 to { %ModuleDiagnostics**, i64 }*
  %t43 = insertvalue %ModuleCompilationResult %t31, { %ModuleDiagnostics**, i64 }* %t42, 1
  ret %ModuleCompilationResult %t43
merge1:
  %t44 = alloca [0 x %ModuleDiagnostics]
  %t45 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* %t44, i32 0, i32 0
  %t46 = alloca { %ModuleDiagnostics*, i64 }
  %t47 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t46, i32 0, i32 0
  store %ModuleDiagnostics* %t45, %ModuleDiagnostics** %t47
  %t48 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t46, i32 0, i32 1
  store i64 0, i64* %t48
  store { %ModuleDiagnostics*, i64 }* %t46, { %ModuleDiagnostics*, i64 }** %l8
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t51 = extractvalue { i8**, i64 } %t50, 1
  %t52 = icmp sgt i64 %t51, 0
  %t53 = load double, double* %l0
  %t54 = load double, double* %l1
  %t55 = load double, double* %l2
  %t56 = load double, double* %l3
  %t57 = load double, double* %l4
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t59 = load double, double* %l6
  %t60 = load i1, i1* %l7
  %t61 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br i1 %t52, label %then2, label %merge3
then2:
  %t62 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t64 = insertvalue %ModuleDiagnostics %t62, { i8**, i64 }* %t63, 1
  %t65 = insertvalue %ModuleDiagnostics %t64, i1 0, 2
  %t66 = alloca [1 x %ModuleDiagnostics]
  %t67 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* %t66, i32 0, i32 0
  %t68 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t67, i64 0
  store %ModuleDiagnostics %t65, %ModuleDiagnostics* %t68
  %t69 = alloca { %ModuleDiagnostics*, i64 }
  %t70 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t69, i32 0, i32 0
  store %ModuleDiagnostics* %t67, %ModuleDiagnostics** %t70
  %t71 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t69, i32 0, i32 1
  store i64 1, i64* %t71
  store { %ModuleDiagnostics*, i64 }* %t69, { %ModuleDiagnostics*, i64 }** %l8
  br label %merge3
merge3:
  %t72 = phi { %ModuleDiagnostics*, i64 }* [ %t69, %then2 ], [ %t61, %entry ]
  store { %ModuleDiagnostics*, i64 }* %t72, { %ModuleDiagnostics*, i64 }** %l8
  %t73 = insertvalue %CompiledModule undef, i8* %source_path, 0
  %t74 = load double, double* %l6
  %t75 = insertvalue %CompiledModule %t73, i8* null, 1
  %t76 = alloca %CompiledModule
  store %CompiledModule %t75, %CompiledModule* %t76
  %t77 = insertvalue %ModuleCompilationResult undef, %CompiledModule* %t76, 0
  %t78 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  %t79 = bitcast { %ModuleDiagnostics*, i64 }* %t78 to { %ModuleDiagnostics**, i64 }*
  %t80 = insertvalue %ModuleCompilationResult %t77, { %ModuleDiagnostics**, i64 }* %t79, 1
  ret %ModuleCompilationResult %t80
}

define { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %entries, i8* %source) {
entry:
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
  br label %merge1
merge1:
  %t14 = phi double [ %t13, %then0 ], [ %t12, %entry ]
  store double %t14, double* %l1
  %t15 = alloca [0 x i8*]
  %t16 = getelementptr [0 x i8*], [0 x i8*]* %t15, i32 0, i32 0
  %t17 = alloca { i8**, i64 }
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 0
  store i8** %t16, i8*** %t18
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* %t17, { i8**, i64 }** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t53 = phi { i8**, i64 }* [ %t23, %entry ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t24, %entry ], [ %t52, %loop.latch4 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l2
  store double %t54, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t27 = extractvalue { %Diagnostic*, i64 } %t26, 1
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t34 = load double, double* %l3
  %t35 = fptosi double %t34 to i64
  %t36 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t37 = extractvalue { %Diagnostic*, i64 } %t36, 0
  %t38 = extractvalue { %Diagnostic*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr %Diagnostic, %Diagnostic* %t37, i64 %t35
  %t41 = load %Diagnostic, %Diagnostic* %t40
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = call i8* @format_typecheck_diagnostic(%Diagnostic %t41, { i8**, i64 }* %t42, double %t43)
  store i8* %t44, i8** %l4
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load i8*, i8** %l4
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t45, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  br label %loop.latch4
loop.latch4:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t52 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t55
}

; fn report_typecheck_errors effects: ![io]
define void @report_typecheck_errors({ %Diagnostic*, i64 }* %entries, i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %t0 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %entries, i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %s1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1, i32 0, i32 0
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
  %t112 = phi double [ %t14, %entry ], [ %t111, %loop.latch2 ]
  store double %t112, double* %l3
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
  %t107 = phi double [ %t57, %loop.body1 ], [ %t106, %loop.latch10 ]
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
  %t89 = getelementptr i8*, i8** %t86, i64 %t84
  %t90 = load i8*, i8** %t89
  %t91 = add i8* %t81, %t90
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
  %t100 = getelementptr i8*, i8** %t97, i64 %t95
  %t101 = load i8*, i8** %t100
  %t102 = add i8* %t92, %t101
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
  %t108 = load double, double* %l3
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l3
  br label %loop.latch2
loop.latch2:
  %t111 = load double, double* %l3
  br label %loop.header0
afterloop3:
  ret void
}

define i8* @format_typecheck_diagnostic(%Diagnostic %entry, { i8**, i64 }* %source_lines, double %line_padding) {
entry:
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
  %l10 = alloca double
  %t0 = extractvalue %Diagnostic %entry, 2
  %t1 = bitcast i8* null to %Token*
  %t2 = icmp eq %Token* %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = extractvalue %Diagnostic %entry, 1
  ret i8* %t3
merge1:
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = extractvalue %Diagnostic %entry, 1
  %t11 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t10)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  %t12 = extractvalue %Diagnostic %entry, 2
  store %Token* %t12, %Token** %l1
  %t13 = load %Token*, %Token** %l1
  store double 0.0, double* %l2
  %t14 = load %Token*, %Token** %l1
  store double 0.0, double* %l3
  %s15 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l2
  %t17 = call i8* @number_to_string(double %t16)
  %t18 = add i8* %s15, %t17
  %s19 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  %t21 = load double, double* %l3
  %t22 = call i8* @number_to_string(double %t21)
  %t23 = add i8* %t20, %t22
  store i8* %t23, i8** %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l4
  %t26 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t24, i8* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fcmp olt double %t28, %t29
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t31 = load double, double* %l2
  %t32 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp ogt double %t31, %t34
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t36 = phi i1 [ true, %logical_or_entry_27 ], [ %t35, %logical_or_right_end_27 ]
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load %Token*, %Token** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load i8*, i8** %l4
  br i1 %t36, label %then2, label %merge3
then2:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = call i8* @join_lines({ i8**, i64 }* %t42)
  ret i8* %t43
merge3:
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fsub double %t44, %t45
  %t47 = fptosi double %t46 to i64
  %t48 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t49 = extractvalue { i8**, i64 } %t48, 0
  %t50 = extractvalue { i8**, i64 } %t48, 1
  %t51 = icmp uge i64 %t47, %t50
  ; bounds check: %t51 (if true, out of bounds)
  %t52 = getelementptr i8*, i8** %t49, i64 %t47
  %t53 = load i8*, i8** %t52
  store i8* %t53, i8** %l5
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 32, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = call i8* @repeat_character(i8* %t57, double %line_padding)
  store i8* %t58, i8** %l6
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l6
  %t61 = load i8, i8* %t60
  %t62 = add i8 32, %t61
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = load i8, i8* %s63
  %t65 = add i8 %t62, %t64
  %t66 = alloca [2 x i8], align 1
  %t67 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8 %t65, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 1
  store i8 0, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  %t70 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t59, i8* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  %t71 = load double, double* %l2
  %t72 = call i8* @number_to_string(double %t71)
  store i8* %t72, i8** %l7
  %s73 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.73, i32 0, i32 0
  store i8* %s73, i8** %l8
  %t74 = load i8*, i8** %l7
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = sitofp i64 %t75 to double
  %t77 = fsub double %line_padding, %t76
  store double %t77, double* %l9
  %t78 = load double, double* %l9
  %t79 = sitofp i64 0 to double
  %t80 = fcmp olt double %t78, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load %Token*, %Token** %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load i8*, i8** %l4
  %t86 = load i8*, i8** %l5
  %t87 = load i8*, i8** %l6
  %t88 = load i8*, i8** %l7
  %t89 = load i8*, i8** %l8
  %t90 = load double, double* %l9
  br i1 %t80, label %then4, label %merge5
then4:
  %t91 = sitofp i64 0 to double
  store double %t91, double* %l9
  br label %merge5
merge5:
  %t92 = phi double [ %t91, %then4 ], [ %t90, %entry ]
  store double %t92, double* %l9
  %t93 = load double, double* %l9
  %t94 = sitofp i64 0 to double
  %t95 = fcmp ogt double %t93, %t94
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = load %Token*, %Token** %l1
  %t98 = load double, double* %l2
  %t99 = load double, double* %l3
  %t100 = load i8*, i8** %l4
  %t101 = load i8*, i8** %l5
  %t102 = load i8*, i8** %l6
  %t103 = load i8*, i8** %l7
  %t104 = load i8*, i8** %l8
  %t105 = load double, double* %l9
  br i1 %t95, label %then6, label %merge7
then6:
  %t106 = load double, double* %l9
  %t107 = alloca [2 x i8], align 1
  %t108 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 0
  store i8 32, i8* %t108
  %t109 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 1
  store i8 0, i8* %t109
  %t110 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 0
  %t111 = call i8* @repeat_character(i8* %t110, double %t106)
  store i8* %t111, i8** %l8
  br label %merge7
merge7:
  %t112 = phi i8* [ %t111, %then6 ], [ %t104, %entry ]
  store i8* %t112, i8** %l8
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load i8*, i8** %l8
  %t115 = load i8, i8* %t114
  %t116 = add i8 32, %t115
  %t117 = load i8*, i8** %l7
  %t118 = load i8, i8* %t117
  %t119 = add i8 %t116, %t118
  %s120 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.120, i32 0, i32 0
  %t121 = load i8, i8* %s120
  %t122 = add i8 %t119, %t121
  %t123 = load i8*, i8** %l5
  %t124 = load i8, i8* %t123
  %t125 = add i8 %t122, %t124
  %t126 = alloca [2 x i8], align 1
  %t127 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  store i8 %t125, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 1
  store i8 0, i8* %t128
  %t129 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  %t130 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t113, i8* %t129)
  store { i8**, i64 }* %t130, { i8**, i64 }** %l0
  %t131 = load double, double* %l3
  %t132 = load %Token*, %Token** %l1
  %t133 = load i8*, i8** %l5
  store double 0.0, double* %l10
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load i8*, i8** %l6
  %t136 = load i8, i8* %t135
  %t137 = add i8 32, %t136
  %s138 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.138, i32 0, i32 0
  %t139 = load i8, i8* %s138
  %t140 = add i8 %t137, %t139
  %t141 = load double, double* %l10
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = call i8* @join_lines({ i8**, i64 }* %t142)
  ret i8* %t143
}

define { i8**, i64 }* @split_source_lines(i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t86 = phi { i8**, i64 }* [ %t7, %entry ], [ %t83, %loop.latch2 ]
  %t87 = phi i8* [ %t8, %entry ], [ %t84, %loop.latch2 ]
  %t88 = phi double [ %t9, %entry ], [ %t85, %loop.latch2 ]
  store { i8**, i64 }* %t86, { i8**, i64 }** %l0
  store i8* %t87, i8** %l1
  store double %t88, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l2
  %t18 = fptosi double %t17 to i64
  %t19 = getelementptr i8, i8* %source, i64 %t18
  %t20 = load i8, i8* %t19
  store i8 %t20, i8* %l3
  %t21 = load i8, i8* %l3
  %t22 = icmp eq i8 %t21, 13
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load i8, i8* %l3
  br i1 %t22, label %then6, label %merge7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.30, i32 0, i32 0
  store i8* %s30, i8** %l1
  %t31 = load double, double* %l2
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  %t34 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t35 = sitofp i64 %t34 to double
  %t36 = fcmp olt double %t33, %t35
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  %t40 = load i8, i8* %l3
  br i1 %t36, label %then8, label %merge9
then8:
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  %t44 = fptosi double %t43 to i64
  %t45 = getelementptr i8, i8* %source, i64 %t44
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 10
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load i8, i8* %l3
  br i1 %t47, label %then10, label %merge11
then10:
  %t52 = load double, double* %l2
  %t53 = sitofp i64 2 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t55 = phi double [ %t54, %then8 ], [ %t39, %then6 ]
  store double %t55, double* %l2
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch2
merge7:
  %t59 = load i8, i8* %l3
  %t60 = icmp eq i8 %t59, 10
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l2
  %t64 = load i8, i8* %l3
  br i1 %t60, label %then12, label %merge13
then12:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l1
  %t67 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t65, i8* %t66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %s68 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.68, i32 0, i32 0
  store i8* %s68, i8** %l1
  %t69 = load double, double* %l2
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l2
  br label %loop.latch2
merge13:
  %t72 = load i8*, i8** %l1
  %t73 = load i8, i8* %l3
  %t74 = load i8, i8* %t72
  %t75 = add i8 %t74, %t73
  %t76 = alloca [2 x i8], align 1
  %t77 = getelementptr [2 x i8], [2 x i8]* %t76, i32 0, i32 0
  store i8 %t75, i8* %t77
  %t78 = getelementptr [2 x i8], [2 x i8]* %t76, i32 0, i32 1
  store i8 0, i8* %t78
  %t79 = getelementptr [2 x i8], [2 x i8]* %t76, i32 0, i32 0
  store i8* %t79, i8** %l1
  %t80 = load double, double* %l2
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l2
  br label %loop.latch2
loop.latch2:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load i8*, i8** %l1
  %t85 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t92
}

define i8* @build_pointer_line(double %column, i8* %lexeme, i8* %line_text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
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
  br label %merge3
merge3:
  %t11 = phi double [ %t10, %then2 ], [ %t9, %entry ]
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
  br label %merge5
merge5:
  %t19 = phi double [ %t18, %then4 ], [ %t16, %entry ]
  store double %t19, double* %l0
  %s20 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.20, i32 0, i32 0
  store i8* %s20, i8** %l1
  %t21 = sitofp i64 1 to double
  store double %t21, double* %l2
  %t22 = load double, double* %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t78 = phi i8* [ %t23, %entry ], [ %t76, %loop.latch8 ]
  %t79 = phi double [ %t24, %entry ], [ %t77, %loop.latch8 ]
  store i8* %t78, i8** %l1
  store double %t79, double* %l2
  br label %loop.body7
loop.body7:
  %t25 = load double, double* %l2
  %t26 = load double, double* %l0
  %t27 = fcmp oge double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  br i1 %t27, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t31 = load double, double* %l2
  %t32 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t33 = sitofp i64 %t32 to double
  %t34 = fcmp ole double %t31, %t33
  %t35 = load double, double* %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  br i1 %t34, label %then12, label %else13
then12:
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fsub double %t38, %t39
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %line_text, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l3
  %t44 = load i8, i8* %l3
  %t45 = icmp eq i8 %t44, 9
  %t46 = load double, double* %l0
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l2
  %t49 = load i8, i8* %l3
  br i1 %t45, label %then15, label %else16
then15:
  %t50 = load i8*, i8** %l1
  %t51 = load i8, i8* %t50
  %t52 = add i8 %t51, 9
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 %t52, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8* %t56, i8** %l1
  br label %merge17
else16:
  %t57 = load i8*, i8** %l1
  %t58 = load i8, i8* %t57
  %t59 = add i8 %t58, 32
  %t60 = alloca [2 x i8], align 1
  %t61 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8 %t59, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 1
  store i8 0, i8* %t62
  %t63 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8* %t63, i8** %l1
  br label %merge17
merge17:
  %t64 = phi i8* [ %t56, %then15 ], [ %t63, %else16 ]
  store i8* %t64, i8** %l1
  br label %merge14
else13:
  %t65 = load i8*, i8** %l1
  %t66 = load i8, i8* %t65
  %t67 = add i8 %t66, 32
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 %t67, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8* %t71, i8** %l1
  br label %merge14
merge14:
  %t72 = phi i8* [ %t56, %then12 ], [ %t71, %else13 ]
  store i8* %t72, i8** %l1
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch8
loop.latch8:
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t80 = call i64 @sailfin_runtime_string_length(i8* %lexeme)
  %t81 = sitofp i64 %t80 to double
  store double %t81, double* %l4
  %t82 = load double, double* %l4
  %t83 = sitofp i64 0 to double
  %t84 = fcmp ole double %t82, %t83
  %t85 = load double, double* %l0
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l2
  %t88 = load double, double* %l4
  br i1 %t84, label %then18, label %merge19
then18:
  %t89 = sitofp i64 1 to double
  store double %t89, double* %l4
  br label %merge19
merge19:
  %t90 = phi double [ %t89, %then18 ], [ %t88, %entry ]
  store double %t90, double* %l4
  %t91 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t92 = load double, double* %l0
  %t93 = sitofp i64 1 to double
  %t94 = fsub double %t92, %t93
  %t95 = sitofp i64 %t91 to double
  %t96 = fsub double %t95, %t94
  store double %t96, double* %l5
  %t97 = load double, double* %l5
  %t98 = sitofp i64 0 to double
  %t99 = fcmp ole double %t97, %t98
  %t100 = load double, double* %l0
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l2
  %t103 = load double, double* %l4
  %t104 = load double, double* %l5
  br i1 %t99, label %then20, label %merge21
then20:
  %t105 = sitofp i64 1 to double
  store double %t105, double* %l5
  br label %merge21
merge21:
  %t106 = phi double [ %t105, %then20 ], [ %t104, %entry ]
  store double %t106, double* %l5
  %t107 = load double, double* %l4
  %t108 = load double, double* %l5
  %t109 = fcmp ogt double %t107, %t108
  %t110 = load double, double* %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l4
  %t114 = load double, double* %l5
  br i1 %t109, label %then22, label %merge23
then22:
  %t115 = load double, double* %l5
  store double %t115, double* %l4
  br label %merge23
merge23:
  %t116 = phi double [ %t115, %then22 ], [ %t113, %entry ]
  store double %t116, double* %l4
  %t117 = sitofp i64 0 to double
  store double %t117, double* %l6
  %t118 = load double, double* %l0
  %t119 = load i8*, i8** %l1
  %t120 = load double, double* %l2
  %t121 = load double, double* %l4
  %t122 = load double, double* %l5
  %t123 = load double, double* %l6
  br label %loop.header24
loop.header24:
  %t145 = phi i8* [ %t119, %entry ], [ %t143, %loop.latch26 ]
  %t146 = phi double [ %t123, %entry ], [ %t144, %loop.latch26 ]
  store i8* %t145, i8** %l1
  store double %t146, double* %l6
  br label %loop.body25
loop.body25:
  %t124 = load double, double* %l6
  %t125 = load double, double* %l4
  %t126 = fcmp oge double %t124, %t125
  %t127 = load double, double* %l0
  %t128 = load i8*, i8** %l1
  %t129 = load double, double* %l2
  %t130 = load double, double* %l4
  %t131 = load double, double* %l5
  %t132 = load double, double* %l6
  br i1 %t126, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t133 = load i8*, i8** %l1
  %t134 = load i8, i8* %t133
  %t135 = add i8 %t134, 94
  %t136 = alloca [2 x i8], align 1
  %t137 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8 %t135, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 1
  store i8 0, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8* %t139, i8** %l1
  %t140 = load double, double* %l6
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l6
  br label %loop.latch26
loop.latch26:
  %t143 = load i8*, i8** %l1
  %t144 = load double, double* %l6
  br label %loop.header24
afterloop27:
  %t147 = load i8*, i8** %l1
  ret i8* %t147
}

define i8* @join_lines({ i8**, i64 }* %lines) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t42 = phi i8* [ %t11, %entry ], [ %t40, %loop.latch4 ]
  %t43 = phi double [ %t12, %entry ], [ %t41, %loop.latch4 ]
  store i8* %t42, i8** %l0
  store double %t43, double* %l1
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
  %t21 = load i8, i8* %t20
  %t22 = add i8 %t21, 10
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = load i8, i8* %t30
  %t32 = add i8 %t22, %t31
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 %t32, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8* %t36, i8** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch4
loop.latch4:
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t44 = load i8*, i8** %l0
  ret i8* %t44
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %value, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t3)
  ret { i8**, i64 }* %t6
}

define i8* @number_to_string(double %value) {
entry:
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
  br label %merge3
merge3:
  %t11 = phi i1 [ 1, %then2 ], [ %t10, %entry ]
  %t12 = phi double [ 0.0, %then2 ], [ %t9, %entry ]
  store i1 %t11, i1* %l1
  store double %t12, double* %l0
  %s13 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.13, i32 0, i32 0
  store i8* %s13, i8** %l2
  %t14 = load double, double* %l0
  store double %t14, double* %l3
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l4
  %t16 = load double, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load i8*, i8** %l2
  %t19 = load double, double* %l3
  %t20 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t70 = phi i8* [ %t20, %entry ], [ %t68, %loop.latch6 ]
  %t71 = phi double [ %t19, %entry ], [ %t69, %loop.latch6 ]
  store i8* %t70, i8** %l4
  store double %t71, double* %l3
  br label %loop.body5
loop.body5:
  %t21 = load double, double* %l3
  %t22 = sitofp i64 0 to double
  %t23 = fcmp ole double %t21, %t22
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l3
  %t28 = load i8*, i8** %l4
  br i1 %t23, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t29 = load double, double* %l3
  store double %t29, double* %l5
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l6
  %t31 = load double, double* %l0
  %t32 = load i1, i1* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t56 = phi double [ %t36, %loop.body5 ], [ %t54, %loop.latch12 ]
  %t57 = phi double [ %t37, %loop.body5 ], [ %t55, %loop.latch12 ]
  store double %t56, double* %l5
  store double %t57, double* %l6
  br label %loop.body11
loop.body11:
  %t38 = load double, double* %l5
  %t39 = sitofp i64 10 to double
  %t40 = fcmp olt double %t38, %t39
  %t41 = load double, double* %l0
  %t42 = load i1, i1* %l1
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l3
  %t45 = load i8*, i8** %l4
  %t46 = load double, double* %l5
  %t47 = load double, double* %l6
  br i1 %t40, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t48 = load double, double* %l5
  %t49 = sitofp i64 10 to double
  %t50 = fsub double %t48, %t49
  store double %t50, double* %l5
  %t51 = load double, double* %l6
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l6
  br label %loop.latch12
loop.latch12:
  %t54 = load double, double* %l5
  %t55 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t58 = load i8*, i8** %l2
  %t59 = load double, double* %l5
  %t60 = load double, double* %l5
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  %t63 = call i8* @slice_string(i8* %t58, double %t59, double %t62)
  store i8* %t63, i8** %l7
  %t64 = load i8*, i8** %l7
  %t65 = load i8*, i8** %l4
  %t66 = add i8* %t64, %t65
  store i8* %t66, i8** %l4
  %t67 = load double, double* %l6
  store double %t67, double* %l3
  br label %loop.latch6
loop.latch6:
  %t68 = load i8*, i8** %l4
  %t69 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t72 = load i1, i1* %l1
  %t73 = load double, double* %l0
  %t74 = load i1, i1* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load double, double* %l3
  %t77 = load i8*, i8** %l4
  br i1 %t72, label %then16, label %merge17
then16:
  %t78 = load i8*, i8** %l4
  %t79 = load i8, i8* %t78
  %t80 = add i8 45, %t79
  %t81 = alloca [2 x i8], align 1
  %t82 = getelementptr [2 x i8], [2 x i8]* %t81, i32 0, i32 0
  store i8 %t80, i8* %t82
  %t83 = getelementptr [2 x i8], [2 x i8]* %t81, i32 0, i32 1
  store i8 0, i8* %t83
  %t84 = getelementptr [2 x i8], [2 x i8]* %t81, i32 0, i32 0
  store i8* %t84, i8** %l4
  br label %merge17
merge17:
  %t85 = phi i8* [ %t84, %then16 ], [ %t77, %entry ]
  store i8* %t85, i8** %l4
  %t86 = load i8*, i8** %l4
  ret i8* %t86
}

define %NativeModule @empty_native_module() {
entry:
  %t0 = alloca [0 x %NativeArtifact*]
  %t1 = getelementptr [0 x %NativeArtifact*], [0 x %NativeArtifact*]* %t0, i32 0, i32 0
  %t2 = alloca { %NativeArtifact**, i64 }
  %t3 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t2, i32 0, i32 0
  store %NativeArtifact** %t1, %NativeArtifact*** %t3
  %t4 = getelementptr { %NativeArtifact**, i64 }, { %NativeArtifact**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %NativeModule undef, { %NativeArtifact**, i64 }* %t2, 0
  %t6 = alloca [0 x i8*]
  %t7 = getelementptr [0 x i8*], [0 x i8*]* %t6, i32 0, i32 0
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t7, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %NativeModule %t5, { i8**, i64 }* %t8, 1
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeModule %t11, double %t12, 2
  ret %NativeModule %t13
}

define i1 @has_prefix(i8* %value, i8* %prefix) {
entry:
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
  %t24 = phi double [ %t4, %entry ], [ %t23, %loop.latch4 ]
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
  ret i1 1
}

define i1 @needs_python_fallback(i8* %source) {
entry:
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
  br label %merge3
merge3:
  %t13 = phi i8* [ %t12, %then2 ], [ %t11, %entry ]
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l2
  store i8* %t14, i8** %l3
  %t15 = load i8*, i8** %l3
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = icmp eq i64 %t16, 0
  %t18 = load i8*, i8** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load i8*, i8** %l2
  %t21 = load i8*, i8** %l3
  br i1 %t17, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t22 = load i8*, i8** %l3
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @string_contains(i8* %t22, i8* %s23)
  %t25 = load i8*, i8** %l0
  %t26 = load i8*, i8** %l1
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l3
  br i1 %t24, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t29 = load i8*, i8** %l3
  %s30 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.30, i32 0, i32 0
  %t31 = call i1 @string_contains(i8* %t29, i8* %s30)
  %t32 = load i8*, i8** %l0
  %t33 = load i8*, i8** %l1
  %t34 = load i8*, i8** %l2
  %t35 = load i8*, i8** %l3
  br i1 %t31, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t36 = load i8*, i8** %l3
  %s37 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.37, i32 0, i32 0
  %t38 = call i1 @string_contains(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load i8*, i8** %l3
  br i1 %t38, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t43 = load i8*, i8** %l3
  %s44 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.44, i32 0, i32 0
  %t45 = call i1 @string_contains(i8* %t43, i8* %s44)
  %t46 = load i8*, i8** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load i8*, i8** %l2
  %t49 = load i8*, i8** %l3
  br i1 %t45, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t50 = load i8*, i8** %l3
  %s51 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.51, i32 0, i32 0
  %t52 = call i1 @string_contains(i8* %t50, i8* %s51)
  %t53 = load i8*, i8** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load i8*, i8** %l2
  %t56 = load i8*, i8** %l3
  br i1 %t52, label %then14, label %merge15
then14:
  ret i1 1
merge15:
  %t57 = load i8*, i8** %l3
  %s58 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.58, i32 0, i32 0
  %t59 = call i1 @string_contains(i8* %t57, i8* %s58)
  %t60 = load i8*, i8** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load i8*, i8** %l2
  %t63 = load i8*, i8** %l3
  br i1 %t59, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t64 = load i8*, i8** %l3
  %s65 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.65, i32 0, i32 0
  %t66 = call i1 @string_contains(i8* %t64, i8* %s65)
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load i8*, i8** %l2
  %t70 = load i8*, i8** %l3
  br i1 %t66, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t71 = load i8*, i8** %l3
  %s72 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.72, i32 0, i32 0
  %t73 = call i1 @string_contains(i8* %t71, i8* %s72)
  %t74 = load i8*, i8** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load i8*, i8** %l2
  %t77 = load i8*, i8** %l3
  br i1 %t73, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  %t78 = load i8*, i8** %l3
  %s79 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @string_contains(i8* %t78, i8* %s79)
  %t81 = load i8*, i8** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load i8*, i8** %l2
  %t84 = load i8*, i8** %l3
  br i1 %t80, label %then22, label %merge23
then22:
  ret i1 1
merge23:
  %t85 = load i8*, i8** %l3
  %s86 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.86, i32 0, i32 0
  %t87 = call i1 @string_contains(i8* %t85, i8* %s86)
  %t88 = load i8*, i8** %l0
  %t89 = load i8*, i8** %l1
  %t90 = load i8*, i8** %l2
  %t91 = load i8*, i8** %l3
  br i1 %t87, label %then24, label %merge25
then24:
  ret i1 1
merge25:
  %t92 = load i8*, i8** %l3
  %s93 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.93, i32 0, i32 0
  %t94 = call i1 @string_contains(i8* %t92, i8* %s93)
  %t95 = load i8*, i8** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load i8*, i8** %l2
  %t98 = load i8*, i8** %l3
  br i1 %t94, label %then26, label %merge27
then26:
  ret i1 1
merge27:
  %t99 = load i8*, i8** %l3
  %s100 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i1 @string_contains(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load i8*, i8** %l1
  %t104 = load i8*, i8** %l2
  %t105 = load i8*, i8** %l3
  br i1 %t101, label %then28, label %merge29
then28:
  ret i1 1
merge29:
  ret i1 0
}

define i1 @string_contains(i8* %value, i8* %pattern) {
entry:
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
  %t55 = phi double [ %t6, %entry ], [ %t54, %loop.latch6 ]
  store double %t55, double* %l0
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
  %t45 = phi i1 [ %t17, %loop.body5 ], [ %t43, %loop.latch12 ]
  %t46 = phi double [ %t18, %loop.body5 ], [ %t44, %loop.latch12 ]
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
  %t48 = load double, double* %l0
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t51 = load double, double* %l0
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l0
  br label %loop.latch6
loop.latch6:
  %t54 = load double, double* %l0
  br label %loop.header4
afterloop7:
  ret i1 0
}

define i8* @strip_needs_python_fallback_literals(i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %s0 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.0, i32 0, i32 0
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
  %s8 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.8, i32 0, i32 0
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
  %t27 = sitofp i64 0 to double
  %t28 = call i8* @slice_string(i8* %source, double %t27, double %t26)
  store i8* %t28, i8** %l5
  %t29 = load double, double* %l4
  %t30 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t31 = sitofp i64 %t30 to double
  %t32 = call i8* @slice_string(i8* %source, double %t29, double %t31)
  store i8* %t32, i8** %l6
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l6
  %t35 = add i8* %t33, %t34
  ret i8* %t35
}

define i8* @strip_python_string_literals(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  %t91 = phi i8* [ %t3, %entry ], [ %t89, %loop.latch2 ]
  %t92 = phi double [ %t2, %entry ], [ %t90, %loop.latch2 ]
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
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = icmp eq i8 %t14, 39
  %t16 = load double, double* %l0
  %t17 = load i8*, i8** %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 39, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  %t24 = call double @python_quote_length(i8* %value, double %t19, i8* %t23)
  store double %t24, double* %l3
  %t25 = load double, double* %l3
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 39, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call i8* @repeat_character(i8* %t29, double %t25)
  store i8* %t30, i8** %l4
  %t31 = load i8*, i8** %l1
  %t32 = load i8*, i8** %l4
  %t33 = add i8* %t31, %t32
  store i8* %t33, i8** %l1
  %t34 = load double, double* %l0
  %t35 = load double, double* %l3
  %t36 = fadd double %t34, %t35
  %t37 = load double, double* %l3
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 39, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t42 = call double @skip_python_string_literal(i8* %value, double %t36, i8* %t41, double %t37)
  store double %t42, double* %l0
  %t43 = load i8*, i8** %l1
  %t44 = load i8*, i8** %l4
  %t45 = add i8* %t43, %t44
  store i8* %t45, i8** %l1
  br label %loop.latch2
merge7:
  %t46 = load i8, i8* %l2
  %t47 = icmp eq i8 %t46, 34
  %t48 = load double, double* %l0
  %t49 = load i8*, i8** %l1
  %t50 = load i8, i8* %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %t51 = load double, double* %l0
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 34, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  %t56 = call double @python_quote_length(i8* %value, double %t51, i8* %t55)
  store double %t56, double* %l5
  %t57 = load double, double* %l5
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 34, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i8* @repeat_character(i8* %t61, double %t57)
  store i8* %t62, i8** %l6
  %t63 = load i8*, i8** %l1
  %t64 = load i8*, i8** %l6
  %t65 = add i8* %t63, %t64
  store i8* %t65, i8** %l1
  %t66 = load double, double* %l0
  %t67 = load double, double* %l5
  %t68 = fadd double %t66, %t67
  %t69 = load double, double* %l5
  %t70 = alloca [2 x i8], align 1
  %t71 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  store i8 34, i8* %t71
  %t72 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 1
  store i8 0, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  %t74 = call double @skip_python_string_literal(i8* %value, double %t68, i8* %t73, double %t69)
  store double %t74, double* %l0
  %t75 = load i8*, i8** %l1
  %t76 = load i8*, i8** %l6
  %t77 = add i8* %t75, %t76
  store i8* %t77, i8** %l1
  br label %loop.latch2
merge9:
  %t78 = load i8*, i8** %l1
  %t79 = load i8, i8* %l2
  %t80 = load i8, i8* %t78
  %t81 = add i8 %t80, %t79
  %t82 = alloca [2 x i8], align 1
  %t83 = getelementptr [2 x i8], [2 x i8]* %t82, i32 0, i32 0
  store i8 %t81, i8* %t83
  %t84 = getelementptr [2 x i8], [2 x i8]* %t82, i32 0, i32 1
  store i8 0, i8* %t84
  %t85 = getelementptr [2 x i8], [2 x i8]* %t82, i32 0, i32 0
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
  ret i8* %t93
}

define double @python_quote_length(i8* %value, double %start, i8* %delimiter) {
entry:
  %t0 = sitofp i64 2 to double
  %t1 = fadd double %start, %t0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  %t4 = fcmp olt double %t1, %t3
  br i1 %t4, label %then0, label %merge1
then0:
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %start, %t5
  %t7 = fptosi double %t6 to i64
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  %t10 = load i8, i8* %delimiter
  %t11 = icmp eq i8 %t9, %t10
  br i1 %t11, label %then2, label %merge3
then2:
  %t12 = sitofp i64 2 to double
  %t13 = fadd double %start, %t12
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %value, i64 %t14
  %t16 = load i8, i8* %t15
  %t17 = load i8, i8* %delimiter
  %t18 = icmp eq i8 %t16, %t17
  br i1 %t18, label %then4, label %merge5
then4:
  %t19 = sitofp i64 3 to double
  ret double %t19
merge5:
  br label %merge3
merge3:
  br label %merge1
merge1:
  %t20 = sitofp i64 1 to double
  ret double %t20
}

define double @skip_python_string_literal(i8* %value, double %position, i8* %delimiter, double %quote_length) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca double
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
  %t36 = phi double [ %t2, %then0 ], [ %t34, %loop.latch4 ]
  %t37 = phi i1 [ %t3, %then0 ], [ %t35, %loop.latch4 ]
  store double %t36, double* %l0
  store i1 %t37, i1* %l1
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
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  %t18 = load i1, i1* %l1
  %t19 = load double, double* %l0
  %t20 = load i1, i1* %l1
  %t21 = load i8, i8* %l2
  br i1 %t18, label %then8, label %merge9
then8:
  store i1 0, i1* %l1
  br label %loop.latch4
merge9:
  %t22 = load i8, i8* %l2
  %t23 = icmp eq i8 %t22, 92
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then10, label %merge11
then10:
  store i1 1, i1* %l1
  br label %loop.latch4
merge11:
  %t27 = load i8, i8* %l2
  %t28 = load i8, i8* %delimiter
  %t29 = icmp eq i8 %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8, i8* %l2
  br i1 %t29, label %then12, label %merge13
then12:
  %t33 = load double, double* %l0
  ret double %t33
merge13:
  br label %loop.latch4
loop.latch4:
  %t34 = load double, double* %l0
  %t35 = load i1, i1* %l1
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  store double %position, double* %l3
  %t38 = load double, double* %l3
  br label %loop.header14
loop.header14:
  %t84 = phi double [ %t38, %entry ], [ %t83, %loop.latch16 ]
  store double %t84, double* %l3
  br label %loop.body15
loop.body15:
  %t39 = load double, double* %l3
  %t40 = fadd double %t39, %quote_length
  %t41 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp ogt double %t40, %t42
  %t44 = load double, double* %l3
  br i1 %t43, label %then18, label %merge19
then18:
  %t45 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t46 = sitofp i64 %t45 to double
  ret double %t46
merge19:
  store i1 1, i1* %l4
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l5
  %t48 = load double, double* %l3
  %t49 = load i1, i1* %l4
  %t50 = load double, double* %l5
  br label %loop.header20
loop.header20:
  %t72 = phi i1 [ %t49, %loop.body15 ], [ %t70, %loop.latch22 ]
  %t73 = phi double [ %t50, %loop.body15 ], [ %t71, %loop.latch22 ]
  store i1 %t72, i1* %l4
  store double %t73, double* %l5
  br label %loop.body21
loop.body21:
  %t51 = load double, double* %l5
  %t52 = fcmp oge double %t51, %quote_length
  %t53 = load double, double* %l3
  %t54 = load i1, i1* %l4
  %t55 = load double, double* %l5
  br i1 %t52, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t56 = load double, double* %l3
  %t57 = load double, double* %l5
  %t58 = fadd double %t56, %t57
  %t59 = fptosi double %t58 to i64
  %t60 = getelementptr i8, i8* %value, i64 %t59
  %t61 = load i8, i8* %t60
  %t62 = load i8, i8* %delimiter
  %t63 = icmp ne i8 %t61, %t62
  %t64 = load double, double* %l3
  %t65 = load i1, i1* %l4
  %t66 = load double, double* %l5
  br i1 %t63, label %then26, label %merge27
then26:
  store i1 0, i1* %l4
  br label %afterloop23
merge27:
  %t67 = load double, double* %l5
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l5
  br label %loop.latch22
loop.latch22:
  %t70 = load i1, i1* %l4
  %t71 = load double, double* %l5
  br label %loop.header20
afterloop23:
  %t74 = load i1, i1* %l4
  %t75 = load double, double* %l3
  %t76 = load i1, i1* %l4
  %t77 = load double, double* %l5
  br i1 %t74, label %then28, label %merge29
then28:
  %t78 = load double, double* %l3
  %t79 = fadd double %t78, %quote_length
  ret double %t79
merge29:
  %t80 = load double, double* %l3
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l3
  br label %loop.latch16
loop.latch16:
  %t83 = load double, double* %l3
  br label %loop.header14
afterloop17:
  ret double 0.0
}

define i8* @repeat_character(i8* %ch, double %count) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %count, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l1
  %t5 = load double, double* %l0
  %t6 = load i8*, i8** %l1
  br label %loop.header2
loop.header2:
  %t18 = phi i8* [ %t6, %entry ], [ %t16, %loop.latch4 ]
  %t19 = phi double [ %t5, %entry ], [ %t17, %loop.latch4 ]
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
  %t12 = add i8* %t11, %ch
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
  ret i8* %t20
}

define double @find_substring(i8* %value, i8* %pattern) {
entry:
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
  %t58 = phi double [ %t8, %entry ], [ %t57, %loop.latch6 ]
  store double %t58, double* %l0
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
  %t47 = phi i1 [ %t19, %loop.body5 ], [ %t45, %loop.latch12 ]
  %t48 = phi double [ %t20, %loop.body5 ], [ %t46, %loop.latch12 ]
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
  %t50 = load double, double* %l0
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then18, label %merge19
then18:
  %t53 = load double, double* %l0
  ret double %t53
merge19:
  %t54 = load double, double* %l0
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l0
  br label %loop.latch6
loop.latch6:
  %t57 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t59 = sitofp i64 -1 to double
  ret double %t59
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
entry:
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
  %t57 = phi double [ %t7, %entry ], [ %t56, %loop.latch6 ]
  store double %t57, double* %l0
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
  %t46 = phi i1 [ %t18, %loop.body5 ], [ %t44, %loop.latch12 ]
  %t47 = phi double [ %t19, %loop.body5 ], [ %t45, %loop.latch12 ]
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
  %t49 = load double, double* %l0
  %t50 = load i1, i1* %l1
  %t51 = load double, double* %l2
  br i1 %t48, label %then18, label %merge19
then18:
  %t52 = load double, double* %l0
  ret double %t52
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
  %t58 = sitofp i64 -1 to double
  ret double %t58
}

define double @advance_to_line_end(i8* %value, double %position) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t0, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
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
  %t7 = fptosi double %t6 to i64
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l1
  %t10 = load double, double* %l0
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l0
  %t13 = load i8, i8* %l1
  %t14 = icmp eq i8 %t13, 10
  %t15 = load double, double* %l0
  %t16 = load i8, i8* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l0
  ret double %t19
}

define i8* @slice_string(i8* %value, double %start, double %end) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  br label %merge1
merge1:
  %t2 = fcmp olt double %end, %start
  br i1 %t2, label %then2, label %merge3
then2:
  br label %merge3
merge3:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %start, %t4
  br i1 %t5, label %then4, label %merge5
then4:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge5:
  %t7 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp ogt double %end, %t8
  br i1 %t9, label %then6, label %merge7
then6:
  br label %merge7
merge7:
  store double %start, double* %l0
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  store i8* %s10, i8** %l1
  %t11 = load double, double* %l0
  %t12 = load i8*, i8** %l1
  br label %loop.header8
loop.header8:
  %t33 = phi i8* [ %t12, %entry ], [ %t31, %loop.latch10 ]
  %t34 = phi double [ %t11, %entry ], [ %t32, %loop.latch10 ]
  store i8* %t33, i8** %l1
  store double %t34, double* %l0
  br label %loop.body9
loop.body9:
  %t13 = load double, double* %l0
  %t14 = fcmp oge double %t13, %end
  %t15 = load double, double* %l0
  %t16 = load i8*, i8** %l1
  br i1 %t14, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l0
  %t19 = fptosi double %t18 to i64
  %t20 = getelementptr i8, i8* %value, i64 %t19
  %t21 = load i8, i8* %t20
  %t22 = load i8, i8* %t17
  %t23 = add i8 %t22, %t21
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 %t23, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8* %t27, i8** %l1
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l0
  br label %loop.latch10
loop.latch10:
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t35 = load i8*, i8** %l1
  ret i8* %t35
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
