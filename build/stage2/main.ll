; ModuleID = 'sailfin'
source_filename = "sailfin"

%CompiledModule = type { i8*, i8* }
%ModuleDiagnostics = type { i8*, { i8**, i64 }*, i1 }
%ModuleCompilationResult = type { i8*, { i8**, i64 }* }
%ProjectCompilation = type { { i8**, i64 }*, { i8**, i64 }* }
%LLVMCompilationResult = type { i8*, i8* }
%Parser = type { { i8**, i64 }*, double }
%StatementParseResult = type { i8*, i8* }
%ParameterParseResult = type { i8*, i8* }
%ParameterListParseResult = type { i8*, { i8**, i64 }* }
%StructFieldParseResult = type { i8*, i8*, i1 }
%ModelPropertyParseResult = type { i8*, i8*, i1 }
%MethodParseResult = type { i8*, i8*, i1 }
%InterfaceMemberParseResult = type { i8*, i8*, i1 }
%SpecifierListParseResult = type { i8*, { i8**, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { i8*, i8*, i1 }
%TypeParameterParseResult = type { i8*, { i8**, i64 }* }
%ImplementsParseResult = type { i8*, { i8**, i64 }*, i1 }
%DecoratorParseResult = type { i8*, { i8**, i64 }* }
%BlockStatementParseResult = type { i8*, i8*, i1 }
%ParenthesizedParseResult = type { i8*, { i8**, i64 }*, i1 }
%MatchCasesParseResult = type { i8*, { i8**, i64 }*, i1 }
%MatchCaseParseResult = type { i8*, i8*, i1 }
%MatchCaseTokenSplit = type { { i8**, i64 }*, { i8**, i64 }*, i1 }
%ExpressionTokens = type { { i8**, i64 }*, double }
%ExpressionParseResult = type { i8*, i8*, i1 }
%LambdaParameterParseResult = type { i8*, i8*, i1 }
%LambdaParameterListParseResult = type { i8*, { i8**, i64 }*, i1 }
%ExpressionCollectResult = type { i8*, { i8**, i64 }*, i1 }
%ExpressionBlockParseResult = type { i8*, { i8**, i64 }*, i1 }
%CallArgumentsParseResult = type { i8*, { i8**, i64 }*, i1 }
%ArrayLiteralParseResult = type { i8*, { i8**, i64 }*, i1 }
%ObjectLiteralParseResult = type { i8*, { i8**, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { i8*, { i8**, i64 }* }
%EffectParseResult = type { i8*, { i8**, i64 }* }
%BlockParseResult = type { i8*, i8* }
%PatternCaptureResult = type { i8*, { i8**, i64 }*, i1 }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { i8**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { i8*, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { i8*, { i8**, i64 }*, i8* }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { i8**, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { i8**, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { i8**, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { i8**, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { i8**, i64 }* }
%LayoutEnumDefinition = type { i8*, { i8**, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { i8**, i64 }*, { i8**, i64 }* }
%LoweredPythonResult = type { i8*, { i8**, i64 }* }
%MatchContext = type { i8*, double, i1 }
%LoweredCaseCondition = type { i8*, i1, i1 }
%PythonModuleEmission = type { i8*, { i8**, i64 }* }
%PythonFunctionEmission = type { i8*, { i8**, i64 }* }
%PythonImportEmission = type { i8*, { i8**, i64 }* }
%PythonStructEmission = type { i8*, { i8**, i64 }* }
%StructLiteralCapture = type { i8*, double, i1 }
%ExpressionContinuationCapture = type { i8*, double, i1 }
%ExtractedSpan = type { i8*, double, double, i1 }
%PythonBuilder = type { { i8**, i64 }*, double }
%TraitImplementationDescriptor = type { i8*, { i8**, i64 }* }
%TraitDescriptor = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%TraitMetadata = type { { i8**, i64 }*, { i8**, i64 }* }
%FunctionEffectEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifestEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifest = type { { i8**, i64 }* }
%RuntimeHelperDescriptor = type { i8*, i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%FunctionCallEntry = type { i8*, { i8**, i64 }* }
%StringConstant = type { i8*, i8*, double }
%StringPointerResult = type { { i8**, i64 }*, double, i8* }
%LoweredLLVMResult = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%LoweredLLVMFunction = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%BodyResult = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%ParameterBinding = type { i8*, i8*, i8*, i8*, i1, i8* }
%ParameterPreparation = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%LLVMOperand = type { i8*, i8* }
%ExpressionResult = type { { i8**, i64 }*, double, i8*, { i8**, i64 }*, { i8**, i64 }* }
%ArrayLiteralMetadata = type { i8*, double }
%OwnershipInfo = type { i8*, i8*, i1, i8*, double }
%OwnershipConsumption = type { i8*, i8* }
%LifetimeRegionMetadata = type { double, i8*, i8*, i1, i8*, i8*, double, i8*, double, i8*, double, i1 }
%LifetimeReleaseEvent = type { double, i8*, double }
%ScopeMetadata = type { i8*, double }
%StructFieldInfo = type { i8*, i8*, double, double }
%StructTypeInfo = type { i8*, i8*, { i8**, i64 }*, double, double }
%EnumVariantInfo = type { i8*, double, double, double, double, { i8**, i64 }* }
%EnumTypeInfo = type { i8*, i8*, i8*, double, double, double, double, { i8**, i64 }* }
%VTableEntry = type { i8*, i8*, i8* }
%VTableInfo = type { i8*, i8*, i8*, i8*, { i8**, i64 }* }
%InterfaceTypeInfo = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%TypeContext = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%TypeContextBuild = type { i8*, { i8**, i64 }* }
%TypeAllocationInfo = type { i8*, double, double }
%HeapBoxResult = type { { i8**, i64 }*, double, i8*, { i8**, i64 }* }
%StructLiteralField = type { i8*, i8* }
%StructLiteralParse = type { i1, i1, i8*, { i8**, i64 }*, { i8**, i64 }* }
%EnumLiteralParse = type { i1, i1, i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%MemberAccessParse = type { i1, i8*, i8* }
%IndexExpressionParse = type { i1, i8*, i8* }
%LocalBinding = type { i8*, i8*, i8*, i8*, i8*, i1, i8*, double }
%LocalMutation = type { i8*, i8*, i8*, i8*, i8* }
%OwnershipAnalysis = type { i8*, i8*, { i8**, i64 }* }
%OperatorMatch = type { double, i8*, i1 }
%AssignmentParseResult = type { i1, i8*, i8*, i8* }
%BorrowParseResult = type { i1, i1, i8*, i1, { i8**, i64 }* }
%BorrowArgumentParse = type { i1, i8*, { i8**, i64 }* }
%TernaryParseResult = type { i1, i8*, i8*, i8*, { i8**, i64 }* }
%ExpressionStatementResult = type { { i8**, i64 }*, double, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, { i8**, i64 }*, { i8**, i64 }* }
%LetLoweringResult = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, { i8**, i64 }*, double, { i8**, i64 }*, double, { i8**, i64 }*, { i8**, i64 }* }
%InlineLetParseResult = type { i1, i8*, i1, i8*, i8*, { i8**, i64 }* }
%BlockLabelResult = type { i8*, double }
%IfStructure = type { double, double, double, double, i1, double, { i8**, i64 }* }
%LoopContext = type { i8*, i8* }
%LoopStructure = type { double, double, double, { i8**, i64 }* }
%RangeIterableParse = type { i1, i8*, i8*, i8*, { i8**, i64 }* }
%MatchCaseStructure = type { i8*, i8*, double, double, i1 }
%MatchStructure = type { { i8**, i64 }*, double, { i8**, i64 }* }
%MatchFieldBinding = type { i8*, i8*, double }
%MatchCaseCondition = type { { i8**, i64 }*, double, i8*, { i8**, i64 }*, i1, { i8**, i64 }*, i8*, i8*, { i8**, i64 }* }
%ConditionConversion = type { { i8**, i64 }*, double, i8*, { i8**, i64 }*, { i8**, i64 }* }
%ComparisonEmission = type { { i8**, i64 }*, double, i8*, { i8**, i64 }* }
%CoercionResult = type { { i8**, i64 }*, double, i8*, { i8**, i64 }* }
%BinaryAlignmentResult = type { { i8**, i64 }*, double, i8*, i8*, { i8**, i64 }*, i8* }
%BlockLoweringResult = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, double, double, { i8**, i64 }*, i1, double, { i8**, i64 }*, double, double, { i8**, i64 }*, { i8**, i64 }* }
%PhiMergeResult = type { { i8**, i64 }*, double }
%PhiInputEntry = type { i8*, i8* }
%PhiStoreEntry = type { i8*, i8* }
%MatchArmMutations = type { { i8**, i64 }*, i8*, i1 }
%LoadLocalResult = type { { i8**, i64 }*, double, i8*, { i8**, i64 }* }
%Diagnostic = type { i8*, i8*, i8* }
%SymbolEntry = type { i8*, i8*, i8* }
%TypecheckResult = type { { i8**, i64 }*, { i8**, i64 }* }
%SymbolCollectionResult = type { { i8**, i64 }*, { i8**, i64 }* }
%ScopeResult = type { { i8**, i64 }*, { i8**, i64 }* }

; intrinsic sailfin_runtime_print_info requires capabilities: ![io]
declare void @sailfin_runtime_print_info(i8*)
; intrinsic sailfin_runtime_print_error requires capabilities: ![io]
declare void @sailfin_runtime_print_error(i8*)
; intrinsic sailfin_runtime_print_warn requires capabilities: ![io]
declare void @sailfin_runtime_print_warn(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [27 x i8] c"Sailfin compiler (stage 0)\00"
@.str.1 = private unnamed_addr constant [13 x i8] c"[typecheck] \00"
@.str.40 = private unnamed_addr constant [3 x i8] c" |\00"
@.str.47 = private unnamed_addr constant [1 x i8] c"\00"
@.str.89 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.102 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.9 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.11 = private unnamed_addr constant [1 x i8] c"\00"
@.str.8 = private unnamed_addr constant [13 x i8] c"return False\00"
@.str.4 = private unnamed_addr constant [1 x i8] c"\00"
@.str.3 = private unnamed_addr constant [1 x i8] c"\00"

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
  %t3 = call double @lower_to_python(i8* %t2)
  store double %t3, double* %l1
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t9 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t10 = extractvalue %EmitNativeResult %t9, 1
  %t11 = call double @combinedconcat({ i8**, i64 }* %t10)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t13
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = icmp sgt i64 %t15, 0
  %t17 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t18 = load double, double* %l1
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t16, label %then0, label %merge1
then0:
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t22 = load double, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t49 = phi double [ %t24, %then0 ], [ %t48, %loop.latch4 ]
  store double %t49, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t26
  %t28 = extractvalue { i8**, i64 } %t27, 1
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t25, %t29
  %t31 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t32 = load double, double* %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %s35 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.35, i32 0, i32 0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t37 = load double, double* %l3
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t39 = extractvalue { i8**, i64 } %t38, 0
  %t40 = extractvalue { i8**, i64 } %t38, 1
  %t41 = icmp uge i64 %t37, %t40
  ; bounds check: %t41 (if true, out of bounds)
  %t42 = getelementptr i8*, i8** %t39, i64 %t37
  %t43 = load i8*, i8** %t42
  %t44 = add i8* %s35, %t43
  call void @sailfin_runtime_print_warn(i8* %t44)
  %t45 = load double, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l3
  br label %loop.latch4
loop.latch4:
  %t48 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t50 = load double, double* %l1
  %t51 = insertvalue %LoweredPythonResult undef, i8* null, 0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = insertvalue %LoweredPythonResult %t51, { i8**, i64 }* %t52, 1
  ret %LoweredPythonResult %t53
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
  %t3 = call double @lower_to_llvm(i8* %t2)
  store double %t3, double* %l1
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t9 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t10 = extractvalue %EmitNativeResult %t9, 1
  %t11 = call double @combinedconcat({ i8**, i64 }* %t10)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t13
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = icmp sgt i64 %t15, 0
  %t17 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t18 = load double, double* %l1
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t16, label %then0, label %merge1
then0:
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t22 = load double, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t39 = phi double [ %t24, %then0 ], [ %t38, %loop.latch4 ]
  store double %t39, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t26
  %t28 = extractvalue { i8**, i64 } %t27, 1
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t25, %t29
  %t31 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t32 = load double, double* %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch4
loop.latch4:
  %t38 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t40 = load double, double* %l1
  %t41 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = insertvalue %LoweredLLVMResult %t41, { i8**, i64 }* %t42, 1
  %t44 = load double, double* %l1
  %t45 = insertvalue %LoweredLLVMResult %t43, i8* null, 2
  %t46 = load double, double* %l1
  %t47 = insertvalue %LoweredLLVMResult %t45, { i8**, i64 }* null, 3
  %t48 = load double, double* %l1
  %t49 = insertvalue %LoweredLLVMResult %t47, { i8**, i64 }* null, 4
  %t50 = load double, double* %l1
  %t51 = insertvalue %LoweredLLVMResult %t49, i8* null, 5
  %t52 = load double, double* %l1
  %t53 = insertvalue %LoweredLLVMResult %t51, { i8**, i64 }* null, 6
  ret %LoweredLLVMResult %t53
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
  %t3 = call double @lower_to_llvm(i8* %t2)
  store double %t3, double* %l1
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t9 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t10 = extractvalue %EmitNativeResult %t9, 1
  %t11 = call double @combinedconcat({ i8**, i64 }* %t10)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t13
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = icmp sgt i64 %t15, 0
  %t17 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t18 = load double, double* %l1
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t16, label %then0, label %merge1
then0:
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t22 = load double, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t39 = phi double [ %t24, %then0 ], [ %t38, %loop.latch4 ]
  store double %t39, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t26
  %t28 = extractvalue { i8**, i64 } %t27, 1
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t25, %t29
  %t31 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t32 = load double, double* %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch4
loop.latch4:
  %t38 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t40 = load double, double* %l1
  %t41 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = insertvalue %LoweredLLVMResult %t41, { i8**, i64 }* %t42, 1
  %t44 = load double, double* %l1
  %t45 = insertvalue %LoweredLLVMResult %t43, i8* null, 2
  %t46 = load double, double* %l1
  %t47 = insertvalue %LoweredLLVMResult %t45, { i8**, i64 }* null, 3
  %t48 = load double, double* %l1
  %t49 = insertvalue %LoweredLLVMResult %t47, { i8**, i64 }* null, 4
  %t50 = load double, double* %l1
  %t51 = insertvalue %LoweredLLVMResult %t49, i8* null, 5
  %t52 = load double, double* %l1
  %t53 = insertvalue %LoweredLLVMResult %t51, { i8**, i64 }* null, 6
  %t54 = insertvalue %LLVMCompilationResult undef, i8* null, 0
  %t55 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t56 = extractvalue %EmitNativeResult %t55, 0
  %t57 = insertvalue %LLVMCompilationResult %t54, i8* %t56, 1
  ret %LLVMCompilationResult %t57
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %CompiledModule*, i64 }* null, { %CompiledModule*, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %ModuleDiagnostics*, i64 }* null, { %ModuleDiagnostics*, i64 }** %l1
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
  %t23 = icmp ne i8* %t22, null
  %t24 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t25 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t26 = load i8*, i8** %l3
  %t27 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t23, label %then4, label %merge5
then4:
  %t28 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t29 = extractvalue %ModuleCompilationResult %t28, 0
  %t30 = alloca [1 x i8*]
  %t31 = getelementptr [1 x i8*], [1 x i8*]* %t30, i32 0, i32 0
  %t32 = getelementptr i8*, i8** %t31, i64 0
  store i8* %t29, i8** %t32
  %t33 = alloca { i8**, i64 }
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 0
  store i8** %t31, i8*** %t34
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t33, i32 0, i32 1
  store i64 1, i64* %t35
  %t36 = call double @modulesconcat({ i8**, i64 }* %t33)
  store { %CompiledModule*, i64 }* null, { %CompiledModule*, i64 }** %l0
  br label %merge5
merge5:
  %t37 = phi { %CompiledModule*, i64 }* [ null, %then4 ], [ %t24, %forbody1 ]
  store { %CompiledModule*, i64 }* %t37, { %CompiledModule*, i64 }** %l0
  %t38 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t39 = extractvalue %ModuleCompilationResult %t38, 1
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = icmp sgt i64 %t41, 0
  %t43 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t44 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t45 = load i8*, i8** %l3
  %t46 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t42, label %then6, label %merge7
then6:
  %t47 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t48 = extractvalue %ModuleCompilationResult %t47, 1
  %t49 = call double @diagnosticsconcat({ i8**, i64 }* %t48)
  store { %ModuleDiagnostics*, i64 }* null, { %ModuleDiagnostics*, i64 }** %l1
  br label %merge7
merge7:
  %t50 = phi { %ModuleDiagnostics*, i64 }* [ null, %then6 ], [ %t44, %forbody1 ]
  store { %ModuleDiagnostics*, i64 }* %t50, { %ModuleDiagnostics*, i64 }** %l1
  br label %forinc2
forinc2:
  %t51 = load i64, i64* %l2
  %t52 = add i64 %t51, 1
  store i64 %t52, i64* %l2
  br label %for0
afterfor3:
  %t53 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t54 = insertvalue %ProjectCompilation undef, { i8**, i64 }* null, 0
  %t55 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t56 = insertvalue %ProjectCompilation %t54, { i8**, i64 }* null, 1
  ret %ProjectCompilation %t56
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
  %t0 = call double @fsreadFile(i8* %source_path)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @parse_program(double %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = call double @typecheck_program(double %t3)
  store double %t4, double* %l2
  %t5 = load double, double* %l2
  %t6 = load double, double* %l1
  %t7 = call double @emit_native(double %t6)
  store double %t7, double* %l3
  %t8 = load double, double* %l3
  store double 0.0, double* %l4
  %t9 = load double, double* %l4
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t10 = load double, double* %l4
  store double 0.0, double* %l6
  %t11 = load double, double* %l6
  %t12 = call i1 @needs_python_fallback(i8* null)
  store i1 %t12, i1* %l7
  %t13 = load i1, i1* %l7
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t20 = load double, double* %l6
  %t21 = load i1, i1* %l7
  br i1 %t13, label %then0, label %merge1
then0:
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
  %t29 = call double @messagesconcat({ i8**, i64 }* %t26)
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t30 = insertvalue %ModuleCompilationResult undef, i8* null, 0
  %t31 = insertvalue %ModuleDiagnostics undef, i8* %source_path, 0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t33 = insertvalue %ModuleDiagnostics %t31, { i8**, i64 }* %t32, 1
  %t34 = insertvalue %ModuleDiagnostics %t33, i1 1, 2
  %t35 = alloca [1 x %ModuleDiagnostics]
  %t36 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* %t35, i32 0, i32 0
  %t37 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t36, i64 0
  store %ModuleDiagnostics %t34, %ModuleDiagnostics* %t37
  %t38 = alloca { %ModuleDiagnostics*, i64 }
  %t39 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t38, i32 0, i32 0
  store %ModuleDiagnostics* %t36, %ModuleDiagnostics** %t39
  %t40 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t38, i32 0, i32 1
  store i64 1, i64* %t40
  %t41 = insertvalue %ModuleCompilationResult %t30, { i8**, i64 }* null, 1
  ret %ModuleCompilationResult %t41
merge1:
  %t42 = alloca [0 x double]
  %t43 = getelementptr [0 x double], [0 x double]* %t42, i32 0, i32 0
  %t44 = alloca { double*, i64 }
  %t45 = getelementptr { double*, i64 }, { double*, i64 }* %t44, i32 0, i32 0
  store double* %t43, double** %t45
  %t46 = getelementptr { double*, i64 }, { double*, i64 }* %t44, i32 0, i32 1
  store i64 0, i64* %t46
  store { %ModuleDiagnostics*, i64 }* null, { %ModuleDiagnostics*, i64 }** %l8
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l2
  %t54 = load double, double* %l3
  %t55 = load double, double* %l4
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t57 = load double, double* %l6
  %t58 = load i1, i1* %l7
  %t59 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br i1 %t50, label %then2, label %merge3
then2:
  br label %merge3
merge3:
  %t60 = phi { %ModuleDiagnostics*, i64 }* [ null, %then2 ], [ %t59, %entry ]
  store { %ModuleDiagnostics*, i64 }* %t60, { %ModuleDiagnostics*, i64 }** %l8
  %t61 = insertvalue %CompiledModule undef, i8* %source_path, 0
  %t62 = load double, double* %l6
  %t63 = insertvalue %CompiledModule %t61, i8* null, 1
  %t64 = insertvalue %ModuleCompilationResult undef, i8* null, 0
  %t65 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  %t66 = insertvalue %ModuleCompilationResult %t64, { i8**, i64 }* null, 1
  ret %ModuleCompilationResult %t66
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
  store double 0.0, double* %l1
  %t6 = load double, double* %l1
  %t7 = sitofp i64 1 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then0, label %merge1
then0:
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l1
  br label %merge1
merge1:
  %t12 = phi double [ %t11, %then0 ], [ %t10, %entry ]
  store double %t12, double* %l1
  %t13 = alloca [0 x double]
  %t14 = getelementptr [0 x double], [0 x double]* %t13, i32 0, i32 0
  %t15 = alloca { double*, i64 }
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t15, i32 0, i32 0
  store double* %t14, double** %t16
  %t17 = getelementptr { double*, i64 }, { double*, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t22 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t50 = phi { i8**, i64 }* [ %t21, %entry ], [ %t48, %loop.latch4 ]
  %t51 = phi double [ %t22, %entry ], [ %t49, %loop.latch4 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l2
  store double %t51, double* %l3
  br label %loop.body3
loop.body3:
  %t23 = load double, double* %l3
  %t24 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t25 = extractvalue { %Diagnostic*, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t23, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t32 = load double, double* %l3
  %t33 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t34 = extractvalue { %Diagnostic*, i64 } %t33, 0
  %t35 = extractvalue { %Diagnostic*, i64 } %t33, 1
  %t36 = icmp uge i64 %t32, %t35
  ; bounds check: %t36 (if true, out of bounds)
  %t37 = getelementptr %Diagnostic, %Diagnostic* %t34, i64 %t32
  %t38 = load %Diagnostic, %Diagnostic* %t37
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = call i8* @format_typecheck_diagnostic(%Diagnostic %t38, { i8**, i64 }* %t39, double %t40)
  store i8* %t41, i8** %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = load i8*, i8** %l4
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l3
  br label %loop.latch4
loop.latch4:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t52
}

; fn report_typecheck_errors effects: ![io]
define void @report_typecheck_errors({ %Diagnostic*, i64 }* %entries, i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %t0 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %entries, i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %s1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t5 = load i8*, i8** %l1
  %t6 = load double, double* %l2
  %t7 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t101 = phi double [ %t7, %entry ], [ %t100, %loop.latch2 ]
  store double %t101, double* %l3
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l3
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l4
  %t26 = load i8*, i8** %l4
  %t27 = call { i8**, i64 }* @split_source_lines(i8* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l5
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t29 = load { i8**, i64 }, { i8**, i64 }* %t28
  %t30 = extractvalue { i8**, i64 } %t29, 1
  %t31 = icmp eq i64 %t30, 0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l1
  %t34 = load double, double* %l2
  %t35 = load double, double* %l3
  %t36 = load i8*, i8** %l4
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t31, label %then6, label %merge7
then6:
  %t38 = load i8*, i8** %l1
  call void @sailfin_runtime_print_error(i8* %t38)
  %t39 = load double, double* %l3
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l3
  br label %loop.latch2
merge7:
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l6
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load double, double* %l2
  %t46 = load double, double* %l3
  %t47 = load i8*, i8** %l4
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t49 = load double, double* %l6
  br label %loop.header8
loop.header8:
  %t96 = phi double [ %t49, %loop.body1 ], [ %t95, %loop.latch10 ]
  store double %t96, double* %l6
  br label %loop.body9
loop.body9:
  %t50 = load double, double* %l6
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t51
  %t53 = extractvalue { i8**, i64 } %t52, 1
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp oge double %t50, %t54
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  %t59 = load double, double* %l3
  %t60 = load i8*, i8** %l4
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t62 = load double, double* %l6
  br i1 %t55, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t63 = load double, double* %l6
  %t64 = sitofp i64 0 to double
  %t65 = fcmp oeq double %t63, %t64
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  %t69 = load double, double* %l3
  %t70 = load i8*, i8** %l4
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t72 = load double, double* %l6
  br i1 %t65, label %then14, label %else15
then14:
  %t73 = load i8*, i8** %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t75 = load double, double* %l6
  %t76 = load { i8**, i64 }, { i8**, i64 }* %t74
  %t77 = extractvalue { i8**, i64 } %t76, 0
  %t78 = extractvalue { i8**, i64 } %t76, 1
  %t79 = icmp uge i64 %t75, %t78
  ; bounds check: %t79 (if true, out of bounds)
  %t80 = getelementptr i8*, i8** %t77, i64 %t75
  %t81 = load i8*, i8** %t80
  %t82 = add i8* %t73, %t81
  call void @sailfin_runtime_print_error(i8* %t82)
  br label %merge16
else15:
  %t83 = load double, double* %l2
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t85 = load double, double* %l6
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t84
  %t87 = extractvalue { i8**, i64 } %t86, 0
  %t88 = extractvalue { i8**, i64 } %t86, 1
  %t89 = icmp uge i64 %t85, %t88
  ; bounds check: %t89 (if true, out of bounds)
  %t90 = getelementptr i8*, i8** %t87, i64 %t85
  %t91 = load i8*, i8** %t90
  br label %merge16
merge16:
  %t92 = load double, double* %l6
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l6
  br label %loop.latch10
loop.latch10:
  %t95 = load double, double* %l6
  br label %loop.header8
afterloop11:
  %t97 = load double, double* %l3
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l3
  br label %loop.latch2
loop.latch2:
  %t100 = load double, double* %l3
  br label %loop.header0
afterloop3:
  ret void
}

define i8* @format_typecheck_diagnostic(%Diagnostic %entry, { i8**, i64 }* %source_lines, double %line_padding) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  %t0 = extractvalue %Diagnostic %entry, 2
  %t1 = icmp eq i8* %t0, null
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = extractvalue %Diagnostic %entry, 1
  ret i8* %t2
merge1:
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = extractvalue %Diagnostic %entry, 1
  %t10 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t8, i8* %t9)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l0
  %t11 = extractvalue %Diagnostic %entry, 2
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t13 = load i8*, i8** %l1
  store double 0.0, double* %l3
  store double 0.0, double* %l4
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l4
  %t16 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t14, i8* null)
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  %t18 = load double, double* %l2
  %t19 = sitofp i64 1 to double
  %t20 = fcmp olt double %t18, %t19
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t20, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t21 = load double, double* %l2
  %t22 = load { i8**, i64 }, { i8**, i64 }* %source_lines
  %t23 = extractvalue { i8**, i64 } %t22, 1
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp ogt double %t21, %t24
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t26 = phi i1 [ true, %logical_or_entry_17 ], [ %t25, %logical_or_right_end_17 ]
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then2, label %merge3
then2:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = call i8* @join_lines({ i8**, i64 }* %t32)
  ret i8* %t33
merge3:
  store double 0.0, double* %l5
  %t34 = call i8* @repeat_character(i8* null, double %line_padding)
  store i8* %t34, i8** %l6
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l6
  %t37 = getelementptr i8, i8* %t36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 32, %t38
  %s40 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.40, i32 0, i32 0
  %t41 = getelementptr i8, i8* %s40, i64 0
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t39, %t42
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t35, i8* null)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l2
  %t46 = call i8* @number_to_string(double %t45)
  store i8* %t46, i8** %l7
  %s47 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.47, i32 0, i32 0
  store i8* %s47, i8** %l8
  %t48 = load i8*, i8** %l7
  store double 0.0, double* %l9
  %t49 = load double, double* %l9
  %t50 = sitofp i64 0 to double
  %t51 = fcmp olt double %t49, %t50
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load double, double* %l4
  %t57 = load double, double* %l5
  %t58 = load i8*, i8** %l6
  %t59 = load i8*, i8** %l7
  %t60 = load i8*, i8** %l8
  %t61 = load double, double* %l9
  br i1 %t51, label %then4, label %merge5
then4:
  %t62 = sitofp i64 0 to double
  store double %t62, double* %l9
  br label %merge5
merge5:
  %t63 = phi double [ %t62, %then4 ], [ %t61, %entry ]
  store double %t63, double* %l9
  %t64 = load double, double* %l9
  %t65 = sitofp i64 0 to double
  %t66 = fcmp ogt double %t64, %t65
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l4
  %t72 = load double, double* %l5
  %t73 = load i8*, i8** %l6
  %t74 = load i8*, i8** %l7
  %t75 = load i8*, i8** %l8
  %t76 = load double, double* %l9
  br i1 %t66, label %then6, label %merge7
then6:
  %t77 = load double, double* %l9
  %t78 = call i8* @repeat_character(i8* null, double %t77)
  store i8* %t78, i8** %l8
  br label %merge7
merge7:
  %t79 = phi i8* [ %t78, %then6 ], [ %t75, %entry ]
  store i8* %t79, i8** %l8
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l8
  %t82 = getelementptr i8, i8* %t81, i64 0
  %t83 = load i8, i8* %t82
  %t84 = add i8 32, %t83
  %t85 = load i8*, i8** %l7
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = add i8 %t84, %t87
  %s89 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.89, i32 0, i32 0
  %t90 = getelementptr i8, i8* %s89, i64 0
  %t91 = load i8, i8* %t90
  %t92 = add i8 %t88, %t91
  %t93 = load double, double* %l5
  %t94 = load double, double* %l3
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l5
  store double 0.0, double* %l10
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load i8*, i8** %l6
  %t99 = getelementptr i8, i8* %t98, i64 0
  %t100 = load i8, i8* %t99
  %t101 = add i8 32, %t100
  %s102 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.102, i32 0, i32 0
  %t103 = getelementptr i8, i8* %s102, i64 0
  %t104 = load i8, i8* %t103
  %t105 = add i8 %t101, %t104
  %t106 = load double, double* %l10
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = call i8* @join_lines({ i8**, i64 }* %t107)
  ret i8* %t108
}

define { i8**, i64 }* @split_source_lines(i8* %source) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t54 = phi { i8**, i64 }* [ %t7, %entry ], [ %t51, %loop.latch2 ]
  %t55 = phi i8* [ %t8, %entry ], [ %t52, %loop.latch2 ]
  %t56 = phi double [ %t9, %entry ], [ %t53, %loop.latch2 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store i8* %t55, i8** %l1
  store double %t56, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %source, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %t15 = icmp eq i8 %t14, 13
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load i8, i8* %l3
  br i1 %t15, label %then4, label %merge5
then4:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l1
  %t24 = load double, double* %l2
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  %t27 = load double, double* %l2
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l2
  br label %loop.latch2
merge5:
  %t30 = load i8, i8* %l3
  %t31 = icmp eq i8 %t30, 10
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l1
  %t34 = load double, double* %l2
  %t35 = load i8, i8* %l3
  br i1 %t31, label %then6, label %merge7
then6:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.39, i32 0, i32 0
  store i8* %s39, i8** %l1
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l2
  br label %loop.latch2
merge7:
  %t43 = load i8*, i8** %l1
  %t44 = load i8, i8* %l3
  %t45 = getelementptr i8, i8* %t43, i64 0
  %t46 = load i8, i8* %t45
  %t47 = add i8 %t46, %t44
  store i8* null, i8** %l1
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l2
  br label %loop.latch2
loop.latch2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load i8*, i8** %l1
  %t59 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t60
}

define i8* @build_pointer_line(double %column, i8* %lexeme, i8* %line_text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  store double %column, double* %l0
  %t0 = load double, double* %l0
  %t1 = sitofp i64 1 to double
  %t2 = fcmp olt double %t0, %t1
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 1 to double
  store double %t4, double* %l0
  br label %merge1
merge1:
  %t5 = phi double [ %t4, %then0 ], [ %t3, %entry ]
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l1
  %t8 = sitofp i64 1 to double
  store double %t8, double* %l2
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t23 = phi double [ %t11, %entry ], [ %t22, %loop.latch4 ]
  store double %t23, double* %l2
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l2
  %t13 = load double, double* %l0
  %t14 = fcmp oge double %t12, %t13
  %t15 = load double, double* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l2
  %t19 = load double, double* %l2
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l2
  br label %loop.latch4
loop.latch4:
  %t22 = load double, double* %l2
  br label %loop.header2
afterloop5:
  store double 0.0, double* %l3
  %t24 = load double, double* %l3
  %t25 = sitofp i64 0 to double
  %t26 = fcmp ole double %t24, %t25
  %t27 = load double, double* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then8, label %merge9
then8:
  %t31 = sitofp i64 1 to double
  store double %t31, double* %l3
  br label %merge9
merge9:
  %t32 = phi double [ %t31, %then8 ], [ %t30, %entry ]
  store double %t32, double* %l3
  store double 0.0, double* %l4
  %t33 = load double, double* %l4
  %t34 = sitofp i64 0 to double
  %t35 = fcmp ole double %t33, %t34
  %t36 = load double, double* %l0
  %t37 = load i8*, i8** %l1
  %t38 = load double, double* %l2
  %t39 = load double, double* %l3
  %t40 = load double, double* %l4
  br i1 %t35, label %then10, label %merge11
then10:
  %t41 = sitofp i64 1 to double
  store double %t41, double* %l4
  br label %merge11
merge11:
  %t42 = phi double [ %t41, %then10 ], [ %t40, %entry ]
  store double %t42, double* %l4
  %t43 = load double, double* %l3
  %t44 = load double, double* %l4
  %t45 = fcmp ogt double %t43, %t44
  %t46 = load double, double* %l0
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  br i1 %t45, label %then12, label %merge13
then12:
  %t51 = load double, double* %l4
  store double %t51, double* %l3
  br label %merge13
merge13:
  %t52 = phi double [ %t51, %then12 ], [ %t49, %entry ]
  store double %t52, double* %l3
  %t53 = sitofp i64 0 to double
  store double %t53, double* %l5
  %t54 = load double, double* %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l4
  %t59 = load double, double* %l5
  br label %loop.header14
loop.header14:
  %t78 = phi i8* [ %t55, %entry ], [ %t76, %loop.latch16 ]
  %t79 = phi double [ %t59, %entry ], [ %t77, %loop.latch16 ]
  store i8* %t78, i8** %l1
  store double %t79, double* %l5
  br label %loop.body15
loop.body15:
  %t60 = load double, double* %l5
  %t61 = load double, double* %l3
  %t62 = fcmp oge double %t60, %t61
  %t63 = load double, double* %l0
  %t64 = load i8*, i8** %l1
  %t65 = load double, double* %l2
  %t66 = load double, double* %l3
  %t67 = load double, double* %l4
  %t68 = load double, double* %l5
  br i1 %t62, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t69 = load i8*, i8** %l1
  %t70 = getelementptr i8, i8* %t69, i64 0
  %t71 = load i8, i8* %t70
  %t72 = add i8 %t71, 94
  store i8* null, i8** %l1
  %t73 = load double, double* %l5
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l5
  br label %loop.latch16
loop.latch16:
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l5
  br label %loop.header14
afterloop17:
  %t80 = load i8*, i8** %l1
  ret i8* %t80
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
  %t39 = phi i8* [ %t11, %entry ], [ %t37, %loop.latch4 ]
  %t40 = phi double [ %t12, %entry ], [ %t38, %loop.latch4 ]
  store i8* %t39, i8** %l0
  store double %t40, double* %l1
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
  %t21 = getelementptr i8, i8* %t20, i64 0
  %t22 = load i8, i8* %t21
  %t23 = add i8 %t22, 10
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = getelementptr i8, i8* %t30, i64 0
  %t32 = load i8, i8* %t31
  %t33 = add i8 %t23, %t32
  store i8* null, i8** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch4
loop.latch4:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t41 = load i8*, i8** %l0
  ret i8* %t41
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
  %t6 = call double @valuesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
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
  ret i8* null
merge1:
  store double %value, double* %l0
  store i1 0, i1* %l1
  %t2 = load double, double* %l0
  %t3 = sitofp i64 0 to double
  %t4 = fcmp olt double %t2, %t3
  %t5 = load double, double* %l0
  %t6 = load i1, i1* %l1
  br i1 %t4, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  br label %merge3
merge3:
  %t7 = phi i1 [ 1, %then2 ], [ %t6, %entry ]
  %t8 = phi double [ 0.0, %then2 ], [ %t5, %entry ]
  store i1 %t7, i1* %l1
  store double %t8, double* %l0
  %s9 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.9, i32 0, i32 0
  store i8* %s9, i8** %l2
  %t10 = load double, double* %l0
  store double %t10, double* %l3
  %s11 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.11, i32 0, i32 0
  store i8* %s11, i8** %l4
  %t12 = load double, double* %l0
  %t13 = load i1, i1* %l1
  %t14 = load i8*, i8** %l2
  %t15 = load double, double* %l3
  %t16 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t66 = phi i8* [ %t16, %entry ], [ %t64, %loop.latch6 ]
  %t67 = phi double [ %t15, %entry ], [ %t65, %loop.latch6 ]
  store i8* %t66, i8** %l4
  store double %t67, double* %l3
  br label %loop.body5
loop.body5:
  %t17 = load double, double* %l3
  %t18 = sitofp i64 0 to double
  %t19 = fcmp ole double %t17, %t18
  %t20 = load double, double* %l0
  %t21 = load i1, i1* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load i8*, i8** %l4
  br i1 %t19, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t25 = load double, double* %l3
  store double %t25, double* %l5
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l6
  %t27 = load double, double* %l0
  %t28 = load i1, i1* %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  %t31 = load i8*, i8** %l4
  %t32 = load double, double* %l5
  %t33 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t52 = phi double [ %t32, %loop.body5 ], [ %t50, %loop.latch12 ]
  %t53 = phi double [ %t33, %loop.body5 ], [ %t51, %loop.latch12 ]
  store double %t52, double* %l5
  store double %t53, double* %l6
  br label %loop.body11
loop.body11:
  %t34 = load double, double* %l5
  %t35 = sitofp i64 10 to double
  %t36 = fcmp olt double %t34, %t35
  %t37 = load double, double* %l0
  %t38 = load i1, i1* %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load double, double* %l5
  %t43 = load double, double* %l6
  br i1 %t36, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t44 = load double, double* %l5
  %t45 = sitofp i64 10 to double
  %t46 = fsub double %t44, %t45
  store double %t46, double* %l5
  %t47 = load double, double* %l6
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l6
  br label %loop.latch12
loop.latch12:
  %t50 = load double, double* %l5
  %t51 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t54 = load i8*, i8** %l2
  %t55 = load double, double* %l5
  %t56 = load double, double* %l5
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  %t59 = call i8* @slice_string(i8* %t54, double %t55, double %t58)
  store i8* %t59, i8** %l7
  %t60 = load i8*, i8** %l7
  %t61 = load i8*, i8** %l4
  %t62 = add i8* %t60, %t61
  store i8* %t62, i8** %l4
  %t63 = load double, double* %l6
  store double %t63, double* %l3
  br label %loop.latch6
loop.latch6:
  %t64 = load i8*, i8** %l4
  %t65 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t68 = load i1, i1* %l1
  %t69 = load double, double* %l0
  %t70 = load i1, i1* %l1
  %t71 = load i8*, i8** %l2
  %t72 = load double, double* %l3
  %t73 = load i8*, i8** %l4
  br i1 %t68, label %then16, label %merge17
then16:
  br label %merge17
merge17:
  %t74 = phi i8* [ null, %then16 ], [ %t73, %entry ]
  store i8* %t74, i8** %l4
  %t75 = load i8*, i8** %l4
  ret i8* %t75
}

define %NativeModule @empty_native_module() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %NativeModule undef, { i8**, i64 }* null, 0
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %NativeModule %t5, { i8**, i64 }* null, 1
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeModule %t11, double %t12, 2
  ret %NativeModule %t13
}

define i1 @has_prefix(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t15 = phi double [ %t1, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = icmp ne i8 %t5, %t8
  %t10 = load double, double* %l0
  br i1 %t9, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @needs_python_fallback(i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i8* @strip_needs_python_fallback_literals(i8* %source)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i8* @strip_python_string_literals(i8* %t1)
  store i8* %t2, i8** %l1
  %t3 = load i8*, i8** %l1
  store i8* %t3, i8** %l2
  %t4 = load i8*, i8** %l2
  %t5 = load i8*, i8** %l2
  store i8* %t5, i8** %l3
  %t6 = load i8*, i8** %l3
  %t7 = load i8*, i8** %l3
  %s8 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.8, i32 0, i32 0
  %t9 = call i1 @string_contains(i8* %t7, i8* %s8)
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  %t13 = load i8*, i8** %l3
  br i1 %t9, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t14 = load i8*, i8** %l3
  %s15 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.15, i32 0, i32 0
  %t16 = call i1 @string_contains(i8* %t14, i8* %s15)
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8*, i8** %l2
  %t20 = load i8*, i8** %l3
  br i1 %t16, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t21 = load i8*, i8** %l3
  %s22 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @string_contains(i8* %t21, i8* %s22)
  %t24 = load i8*, i8** %l0
  %t25 = load i8*, i8** %l1
  %t26 = load i8*, i8** %l2
  %t27 = load i8*, i8** %l3
  br i1 %t23, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t28 = load i8*, i8** %l3
  %s29 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.29, i32 0, i32 0
  %t30 = call i1 @string_contains(i8* %t28, i8* %s29)
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load i8*, i8** %l2
  %t34 = load i8*, i8** %l3
  br i1 %t30, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t35 = load i8*, i8** %l3
  %s36 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.36, i32 0, i32 0
  %t37 = call i1 @string_contains(i8* %t35, i8* %s36)
  %t38 = load i8*, i8** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load i8*, i8** %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t42 = load i8*, i8** %l3
  %s43 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i1 @string_contains(i8* %t42, i8* %s43)
  %t45 = load i8*, i8** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l2
  %t48 = load i8*, i8** %l3
  br i1 %t44, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t49 = load i8*, i8** %l3
  %s50 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.50, i32 0, i32 0
  %t51 = call i1 @string_contains(i8* %t49, i8* %s50)
  %t52 = load i8*, i8** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t56 = load i8*, i8** %l3
  %s57 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i1 @string_contains(i8* %t56, i8* %s57)
  %t59 = load i8*, i8** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load i8*, i8** %l2
  %t62 = load i8*, i8** %l3
  br i1 %t58, label %then14, label %merge15
then14:
  ret i1 1
merge15:
  %t63 = load i8*, i8** %l3
  %s64 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.64, i32 0, i32 0
  %t65 = call i1 @string_contains(i8* %t63, i8* %s64)
  %t66 = load i8*, i8** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  br i1 %t65, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t70 = load i8*, i8** %l3
  %s71 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.71, i32 0, i32 0
  %t72 = call i1 @string_contains(i8* %t70, i8* %s71)
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  br i1 %t72, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t77 = load i8*, i8** %l3
  %s78 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.78, i32 0, i32 0
  %t79 = call i1 @string_contains(i8* %t77, i8* %s78)
  %t80 = load i8*, i8** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load i8*, i8** %l2
  %t83 = load i8*, i8** %l3
  br i1 %t79, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  %t84 = load i8*, i8** %l3
  %s85 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.85, i32 0, i32 0
  %t86 = call i1 @string_contains(i8* %t84, i8* %s85)
  %t87 = load i8*, i8** %l0
  %t88 = load i8*, i8** %l1
  %t89 = load i8*, i8** %l2
  %t90 = load i8*, i8** %l3
  br i1 %t86, label %then22, label %merge23
then22:
  ret i1 1
merge23:
  ret i1 0
}

define i1 @string_contains(i8* %value, i8* %pattern) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  store i1 1, i1* %l1
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l2
  %t4 = load double, double* %l0
  %t5 = load i1, i1* %l1
  %t6 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t12 = phi double [ %t6, %loop.body1 ], [ %t11, %loop.latch6 ]
  store double %t12, double* %l2
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l2
  br label %loop.latch6
loop.latch6:
  %t11 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t13 = load i1, i1* %l1
  %t14 = load double, double* %l0
  %t15 = load i1, i1* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
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
  %l6 = alloca double
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
  store double 0.0, double* %l4
  %t21 = load double, double* %l4
  %t22 = call double @advance_to_line_end(i8* %source, double %t21)
  store double %t22, double* %l4
  %t23 = load double, double* %l1
  %t24 = sitofp i64 0 to double
  %t25 = call i8* @slice_string(i8* %source, double %t24, double %t23)
  store i8* %t25, i8** %l5
  %t26 = load double, double* %l4
  store double 0.0, double* %l6
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l6
  ret i8* null
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
  %t58 = phi i8* [ %t3, %entry ], [ %t56, %loop.latch2 ]
  %t59 = phi double [ %t2, %entry ], [ %t57, %loop.latch2 ]
  store i8* %t58, i8** %l1
  store double %t59, double* %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = icmp eq i8 %t8, 39
  %t10 = load double, double* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8, i8* %l2
  br i1 %t9, label %then4, label %merge5
then4:
  %t13 = load double, double* %l0
  %t14 = call double @python_quote_length(i8* %value, double %t13, i8* null)
  store double %t14, double* %l3
  %t15 = load double, double* %l3
  %t16 = call i8* @repeat_character(i8* null, double %t15)
  store i8* %t16, i8** %l4
  %t17 = load i8*, i8** %l1
  %t18 = load i8*, i8** %l4
  %t19 = add i8* %t17, %t18
  store i8* %t19, i8** %l1
  %t20 = load double, double* %l0
  %t21 = load double, double* %l3
  %t22 = fadd double %t20, %t21
  %t23 = load double, double* %l3
  %t24 = call double @skip_python_string_literal(i8* %value, double %t22, i8* null, double %t23)
  store double %t24, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load i8*, i8** %l4
  %t27 = add i8* %t25, %t26
  store i8* %t27, i8** %l1
  br label %loop.latch2
merge5:
  %t28 = load i8, i8* %l2
  %t29 = icmp eq i8 %t28, 34
  %t30 = load double, double* %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i8, i8* %l2
  br i1 %t29, label %then6, label %merge7
then6:
  %t33 = load double, double* %l0
  %t34 = call double @python_quote_length(i8* %value, double %t33, i8* null)
  store double %t34, double* %l5
  %t35 = load double, double* %l5
  %t36 = call i8* @repeat_character(i8* null, double %t35)
  store i8* %t36, i8** %l6
  %t37 = load i8*, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = add i8* %t37, %t38
  store i8* %t39, i8** %l1
  %t40 = load double, double* %l0
  %t41 = load double, double* %l5
  %t42 = fadd double %t40, %t41
  %t43 = load double, double* %l5
  %t44 = call double @skip_python_string_literal(i8* %value, double %t42, i8* null, double %t43)
  store double %t44, double* %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i8*, i8** %l6
  %t47 = add i8* %t45, %t46
  store i8* %t47, i8** %l1
  br label %loop.latch2
merge7:
  %t48 = load i8*, i8** %l1
  %t49 = load i8, i8* %l2
  %t50 = getelementptr i8, i8* %t48, i64 0
  %t51 = load i8, i8* %t50
  %t52 = add i8 %t51, %t49
  store i8* null, i8** %l1
  %t53 = load double, double* %l0
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l0
  br label %loop.latch2
loop.latch2:
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t60 = load i8*, i8** %l1
  ret i8* %t60
}

define double @python_quote_length(i8* %value, double %start, i8* %delimiter) {
entry:
  %t0 = sitofp i64 2 to double
  %t1 = fadd double %start, %t0
  %t2 = sitofp i64 1 to double
  ret double %t2
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
  %t30 = phi double [ %t2, %then0 ], [ %t28, %loop.latch4 ]
  %t31 = phi i1 [ %t3, %then0 ], [ %t29, %loop.latch4 ]
  store double %t30, double* %l0
  store i1 %t31, i1* %l1
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load double, double* %l0
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l0
  %t11 = load i1, i1* %l1
  %t12 = load double, double* %l0
  %t13 = load i1, i1* %l1
  %t14 = load i8, i8* %l2
  br i1 %t11, label %then6, label %merge7
then6:
  store i1 0, i1* %l1
  br label %loop.latch4
merge7:
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 92
  %t17 = load double, double* %l0
  %t18 = load i1, i1* %l1
  %t19 = load i8, i8* %l2
  br i1 %t16, label %then8, label %merge9
then8:
  store i1 1, i1* %l1
  br label %loop.latch4
merge9:
  %t20 = load i8, i8* %l2
  %t21 = getelementptr i8, i8* %delimiter, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t20, %t22
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then10, label %merge11
then10:
  %t27 = load double, double* %l0
  ret double %t27
merge11:
  br label %loop.latch4
loop.latch4:
  %t28 = load double, double* %l0
  %t29 = load i1, i1* %l1
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  store double %position, double* %l3
  %t32 = load double, double* %l3
  br label %loop.header12
loop.header12:
  %t59 = phi double [ %t32, %entry ], [ %t58, %loop.latch14 ]
  store double %t59, double* %l3
  br label %loop.body13
loop.body13:
  %t33 = load double, double* %l3
  %t34 = fadd double %t33, %quote_length
  store i1 1, i1* %l4
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l5
  %t36 = load double, double* %l3
  %t37 = load i1, i1* %l4
  %t38 = load double, double* %l5
  br label %loop.header16
loop.header16:
  %t48 = phi double [ %t38, %loop.body13 ], [ %t47, %loop.latch18 ]
  store double %t48, double* %l5
  br label %loop.body17
loop.body17:
  %t39 = load double, double* %l5
  %t40 = fcmp oge double %t39, %quote_length
  %t41 = load double, double* %l3
  %t42 = load i1, i1* %l4
  %t43 = load double, double* %l5
  br i1 %t40, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t44 = load double, double* %l5
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l5
  br label %loop.latch18
loop.latch18:
  %t47 = load double, double* %l5
  br label %loop.header16
afterloop19:
  %t49 = load i1, i1* %l4
  %t50 = load double, double* %l3
  %t51 = load i1, i1* %l4
  %t52 = load double, double* %l5
  br i1 %t49, label %then22, label %merge23
then22:
  %t53 = load double, double* %l3
  %t54 = fadd double %t53, %quote_length
  ret double %t54
merge23:
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l3
  br label %loop.latch14
loop.latch14:
  %t58 = load double, double* %l3
  br label %loop.header12
afterloop15:
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
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  store i1 1, i1* %l1
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l2
  %t4 = load double, double* %l0
  %t5 = load i1, i1* %l1
  %t6 = load double, double* %l2
  br label %loop.header4
loop.header4:
  %t12 = phi double [ %t6, %loop.body1 ], [ %t11, %loop.latch6 ]
  store double %t12, double* %l2
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l2
  br label %loop.latch6
loop.latch6:
  %t11 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t13 = load i1, i1* %l1
  %t14 = load double, double* %l0
  %t15 = load i1, i1* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then8, label %merge9
then8:
  %t17 = load double, double* %l0
  ret double %t17
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = sitofp i64 -1 to double
  ret double %t23
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
  store double %start, double* %l0
  %t3 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t24 = phi double [ %t3, %entry ], [ %t23, %loop.latch4 ]
  store double %t24, double* %l0
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  store i1 1, i1* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load double, double* %l0
  %t7 = load i1, i1* %l1
  %t8 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t14 = phi double [ %t8, %loop.body3 ], [ %t13, %loop.latch8 ]
  store double %t14, double* %l2
  br label %loop.body7
loop.body7:
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l2
  br label %loop.latch8
loop.latch8:
  %t13 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t15 = load i1, i1* %l1
  %t16 = load double, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then10, label %merge11
then10:
  %t19 = load double, double* %l0
  ret double %t19
merge11:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch4
loop.latch4:
  %t23 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t25 = sitofp i64 -1 to double
  ret double %t25
}

define double @advance_to_line_end(i8* %value, double %position) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t13 = phi double [ %t0, %entry ], [ %t12, %loop.latch2 ]
  store double %t13, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %t3 = getelementptr i8, i8* %value, i64 %t2
  %t4 = load i8, i8* %t3
  store i8 %t4, i8* %l1
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fadd double %t5, %t6
  store double %t7, double* %l0
  %t8 = load i8, i8* %l1
  %t9 = icmp eq i8 %t8, 10
  %t10 = load double, double* %l0
  %t11 = load i8, i8* %l1
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  br label %loop.latch2
loop.latch2:
  %t12 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t14 = load double, double* %l0
  ret double %t14
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
  store double %start, double* %l0
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l1
  %t4 = load double, double* %l0
  %t5 = load i8*, i8** %l1
  br label %loop.header4
loop.header4:
  %t22 = phi i8* [ %t5, %entry ], [ %t20, %loop.latch6 ]
  %t23 = phi double [ %t4, %entry ], [ %t21, %loop.latch6 ]
  store i8* %t22, i8** %l1
  store double %t23, double* %l0
  br label %loop.body5
loop.body5:
  %t6 = load double, double* %l0
  %t7 = fcmp oge double %t6, %end
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  br i1 %t7, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l0
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  %t14 = getelementptr i8, i8* %t10, i64 0
  %t15 = load i8, i8* %t14
  %t16 = add i8 %t15, %t13
  store i8* null, i8** %l1
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch6
loop.latch6:
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t24 = load i8*, i8** %l1
  ret i8* %t24
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
