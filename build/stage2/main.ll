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

@.str.1 = private unnamed_addr constant [13 x i8] c"[typecheck] \00"
@.str.40 = private unnamed_addr constant [3 x i8] c" |\00"
@.str.47 = private unnamed_addr constant [1 x i8] c"\00"
@.str.92 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.105 = private unnamed_addr constant [4 x i8] c" | \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.16 = private unnamed_addr constant [1 x i8] c"\00"
@.str.9 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.11 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [26 x i8] c"def needs_python_fallback\00"
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
  %t3 = call double @lower_to_python(i8* %t2)
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
  %t41 = phi double [ %t26, %then0 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l3
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
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  br label %loop.latch4
loop.latch4:
  %t40 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t42 = load double, double* %l1
  %t43 = insertvalue %LoweredPythonResult undef, i8* null, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = insertvalue %LoweredPythonResult %t43, { i8**, i64 }* %t44, 1
  ret %LoweredPythonResult %t45
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
  %t41 = phi double [ %t26, %then0 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l3
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
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  br label %loop.latch4
loop.latch4:
  %t40 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t42 = load double, double* %l1
  %t43 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = insertvalue %LoweredLLVMResult %t43, { i8**, i64 }* %t44, 1
  %t46 = load double, double* %l1
  %t47 = insertvalue %LoweredLLVMResult %t45, i8* null, 2
  %t48 = load double, double* %l1
  %t49 = insertvalue %LoweredLLVMResult %t47, { i8**, i64 }* null, 3
  %t50 = load double, double* %l1
  %t51 = insertvalue %LoweredLLVMResult %t49, { i8**, i64 }* null, 4
  %t52 = load double, double* %l1
  %t53 = insertvalue %LoweredLLVMResult %t51, i8* null, 5
  %t54 = load double, double* %l1
  %t55 = insertvalue %LoweredLLVMResult %t53, { i8**, i64 }* null, 6
  ret %LoweredLLVMResult %t55
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
  %t41 = phi double [ %t26, %then0 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l3
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
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  br label %loop.latch4
loop.latch4:
  %t40 = load double, double* %l3
  br label %loop.header2
afterloop5:
  br label %merge1
merge1:
  %t42 = load double, double* %l1
  %t43 = insertvalue %LoweredLLVMResult undef, i8* null, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = insertvalue %LoweredLLVMResult %t43, { i8**, i64 }* %t44, 1
  %t46 = load double, double* %l1
  %t47 = insertvalue %LoweredLLVMResult %t45, i8* null, 2
  %t48 = load double, double* %l1
  %t49 = insertvalue %LoweredLLVMResult %t47, { i8**, i64 }* null, 3
  %t50 = load double, double* %l1
  %t51 = insertvalue %LoweredLLVMResult %t49, { i8**, i64 }* null, 4
  %t52 = load double, double* %l1
  %t53 = insertvalue %LoweredLLVMResult %t51, i8* null, 5
  %t54 = load double, double* %l1
  %t55 = insertvalue %LoweredLLVMResult %t53, { i8**, i64 }* null, 6
  %t56 = insertvalue %LLVMCompilationResult undef, i8* null, 0
  %t57 = load %EmitNativeResult, %EmitNativeResult* %l0
  %t58 = extractvalue %EmitNativeResult %t57, 0
  %t59 = insertvalue %LLVMCompilationResult %t56, i8* %t58, 1
  ret %LLVMCompilationResult %t59
}

; fn main effects: ![io]
define void @main() {
entry:
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
  %t23 = icmp ne i8* %t22, null
  %t24 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t25 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t26 = load i8*, i8** %l3
  %t27 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t23, label %then4, label %merge5
then4:
  %t28 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t29 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t30 = extractvalue %ModuleCompilationResult %t29, 0
  %t31 = alloca [1 x i8*]
  %t32 = getelementptr [1 x i8*], [1 x i8*]* %t31, i32 0, i32 0
  %t33 = getelementptr i8*, i8** %t32, i64 0
  store i8* %t30, i8** %t33
  %t34 = alloca { i8**, i64 }
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 0
  store i8** %t32, i8*** %t35
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = bitcast { %CompiledModule*, i64 }* %t28 to { i8**, i64 }*
  %t38 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t37, { i8**, i64 }* %t34)
  %t39 = bitcast { i8**, i64 }* %t38 to { %CompiledModule*, i64 }*
  store { %CompiledModule*, i64 }* %t39, { %CompiledModule*, i64 }** %l0
  br label %merge5
merge5:
  %t40 = phi { %CompiledModule*, i64 }* [ %t39, %then4 ], [ %t24, %forbody1 ]
  store { %CompiledModule*, i64 }* %t40, { %CompiledModule*, i64 }** %l0
  %t41 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t42 = extractvalue %ModuleCompilationResult %t41, 1
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t47 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t48 = load i8*, i8** %l3
  %t49 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br i1 %t45, label %then6, label %merge7
then6:
  %t50 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t51 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t52 = extractvalue %ModuleCompilationResult %t51, 1
  %t53 = bitcast { %ModuleDiagnostics*, i64 }* %t50 to { i8**, i64 }*
  %t54 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t53, { i8**, i64 }* %t52)
  %t55 = bitcast { i8**, i64 }* %t54 to { %ModuleDiagnostics*, i64 }*
  store { %ModuleDiagnostics*, i64 }* %t55, { %ModuleDiagnostics*, i64 }** %l1
  br label %merge7
merge7:
  %t56 = phi { %ModuleDiagnostics*, i64 }* [ %t55, %then6 ], [ %t47, %forbody1 ]
  store { %ModuleDiagnostics*, i64 }* %t56, { %ModuleDiagnostics*, i64 }** %l1
  br label %forinc2
forinc2:
  %t57 = load i64, i64* %l2
  %t58 = add i64 %t57, 1
  store i64 %t58, i64* %l2
  br label %for0
afterfor3:
  %t59 = load { %CompiledModule*, i64 }*, { %CompiledModule*, i64 }** %l0
  %t60 = bitcast { %CompiledModule*, i64 }* %t59 to { i8**, i64 }*
  %t61 = insertvalue %ProjectCompilation undef, { i8**, i64 }* %t60, 0
  %t62 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l1
  %t63 = bitcast { %ModuleDiagnostics*, i64 }* %t62 to { i8**, i64 }*
  %t64 = insertvalue %ProjectCompilation %t61, { i8**, i64 }* %t63, 1
  ret %ProjectCompilation %t64
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
  %t41 = bitcast { %ModuleDiagnostics*, i64 }* %t38 to { i8**, i64 }*
  %t42 = insertvalue %ModuleCompilationResult %t30, { i8**, i64 }* %t41, 1
  ret %ModuleCompilationResult %t42
merge1:
  %t43 = alloca [0 x %ModuleDiagnostics]
  %t44 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* %t43, i32 0, i32 0
  %t45 = alloca { %ModuleDiagnostics*, i64 }
  %t46 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t45, i32 0, i32 0
  store %ModuleDiagnostics* %t44, %ModuleDiagnostics** %t46
  %t47 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t45, i32 0, i32 1
  store i64 0, i64* %t47
  store { %ModuleDiagnostics*, i64 }* %t45, { %ModuleDiagnostics*, i64 }** %l8
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t50 = extractvalue { i8**, i64 } %t49, 1
  %t51 = icmp sgt i64 %t50, 0
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load double, double* %l4
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t58 = load double, double* %l6
  %t59 = load i1, i1* %l7
  %t60 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br i1 %t51, label %then2, label %merge3
then2:
  br label %merge3
merge3:
  %t61 = phi { %ModuleDiagnostics*, i64 }* [ null, %then2 ], [ %t60, %entry ]
  store { %ModuleDiagnostics*, i64 }* %t61, { %ModuleDiagnostics*, i64 }** %l8
  %t62 = insertvalue %CompiledModule undef, i8* %source_path, 0
  %t63 = load double, double* %l6
  %t64 = insertvalue %CompiledModule %t62, i8* null, 1
  %t65 = insertvalue %ModuleCompilationResult undef, i8* null, 0
  %t66 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  %t67 = bitcast { %ModuleDiagnostics*, i64 }* %t66 to { i8**, i64 }*
  %t68 = insertvalue %ModuleCompilationResult %t65, { i8**, i64 }* %t67, 1
  ret %ModuleCompilationResult %t68
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
  %t52 = phi { i8**, i64 }* [ %t23, %entry ], [ %t50, %loop.latch4 ]
  %t53 = phi double [ %t24, %entry ], [ %t51, %loop.latch4 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l2
  store double %t53, double* %l3
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
  %t35 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %entries
  %t36 = extractvalue { %Diagnostic*, i64 } %t35, 0
  %t37 = extractvalue { %Diagnostic*, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr %Diagnostic, %Diagnostic* %t36, i64 %t34
  %t40 = load %Diagnostic, %Diagnostic* %t39
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = call i8* @format_typecheck_diagnostic(%Diagnostic %t40, { i8**, i64 }* %t41, double %t42)
  store i8* %t43, i8** %l4
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load i8*, i8** %l4
  %t46 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t44, i8* %t45)
  store { i8**, i64 }* %t46, { i8**, i64 }** %l2
  %t47 = load double, double* %l3
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l3
  br label %loop.latch4
loop.latch4:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t54
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
  %t4 = sitofp i64 %t3 to double
  %t5 = call i8* @repeat_character(i8* null, double %t4)
  store i8* %t5, i8** %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load i8*, i8** %l2
  %t10 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t84 = phi double [ %t10, %entry ], [ %t83, %loop.latch2 ]
  store double %t84, double* %l3
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l3
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load { i8**, i64 }, { i8**, i64 }* %t12
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t11, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br i1 %t16, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l3
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t21
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  store i8* %t28, i8** %l4
  %t29 = load i8*, i8** %l4
  %t30 = call { i8**, i64 }* @split_source_lines(i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l5
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t32 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = icmp eq i64 %t33, 0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l4
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t34, label %then6, label %merge7
then6:
  %t41 = load double, double* %l3
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l3
  br label %loop.latch2
merge7:
  %t44 = sitofp i64 0 to double
  store double %t44, double* %l6
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l2
  %t48 = load double, double* %l3
  %t49 = load i8*, i8** %l4
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t51 = load double, double* %l6
  br label %loop.header8
loop.header8:
  %t79 = phi double [ %t51, %loop.body1 ], [ %t78, %loop.latch10 ]
  store double %t79, double* %l6
  br label %loop.body9
loop.body9:
  %t52 = load double, double* %l6
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load i8*, i8** %l2
  %t61 = load double, double* %l3
  %t62 = load i8*, i8** %l4
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t64 = load double, double* %l6
  br i1 %t57, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t65 = load double, double* %l6
  %t66 = sitofp i64 0 to double
  %t67 = fcmp oeq double %t65, %t66
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l2
  %t71 = load double, double* %l3
  %t72 = load i8*, i8** %l4
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t74 = load double, double* %l6
  br i1 %t67, label %then14, label %else15
then14:
  br label %merge16
else15:
  br label %merge16
merge16:
  %t75 = load double, double* %l6
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l6
  br label %loop.latch10
loop.latch10:
  %t78 = load double, double* %l6
  br label %loop.header8
afterloop11:
  %t80 = load double, double* %l3
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l3
  br label %loop.latch2
loop.latch2:
  %t83 = load double, double* %l3
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
  %t3 = alloca [0 x i8*]
  %t4 = getelementptr [0 x i8*], [0 x i8*]* %t3, i32 0, i32 0
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t4, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* %t5, { i8**, i64 }** %l0
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
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = sitofp i64 %t49 to double
  %t51 = fsub double %line_padding, %t50
  store double %t51, double* %l9
  %t52 = load double, double* %l9
  %t53 = sitofp i64 0 to double
  %t54 = fcmp olt double %t52, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load double, double* %l4
  %t60 = load double, double* %l5
  %t61 = load i8*, i8** %l6
  %t62 = load i8*, i8** %l7
  %t63 = load i8*, i8** %l8
  %t64 = load double, double* %l9
  br i1 %t54, label %then4, label %merge5
then4:
  %t65 = sitofp i64 0 to double
  store double %t65, double* %l9
  br label %merge5
merge5:
  %t66 = phi double [ %t65, %then4 ], [ %t64, %entry ]
  store double %t66, double* %l9
  %t67 = load double, double* %l9
  %t68 = sitofp i64 0 to double
  %t69 = fcmp ogt double %t67, %t68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = load double, double* %l3
  %t74 = load double, double* %l4
  %t75 = load double, double* %l5
  %t76 = load i8*, i8** %l6
  %t77 = load i8*, i8** %l7
  %t78 = load i8*, i8** %l8
  %t79 = load double, double* %l9
  br i1 %t69, label %then6, label %merge7
then6:
  %t80 = load double, double* %l9
  %t81 = call i8* @repeat_character(i8* null, double %t80)
  store i8* %t81, i8** %l8
  br label %merge7
merge7:
  %t82 = phi i8* [ %t81, %then6 ], [ %t78, %entry ]
  store i8* %t82, i8** %l8
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load i8*, i8** %l8
  %t85 = getelementptr i8, i8* %t84, i64 0
  %t86 = load i8, i8* %t85
  %t87 = add i8 32, %t86
  %t88 = load i8*, i8** %l7
  %t89 = getelementptr i8, i8* %t88, i64 0
  %t90 = load i8, i8* %t89
  %t91 = add i8 %t87, %t90
  %s92 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.92, i32 0, i32 0
  %t93 = getelementptr i8, i8* %s92, i64 0
  %t94 = load i8, i8* %t93
  %t95 = add i8 %t91, %t94
  %t96 = load double, double* %l5
  %t97 = load double, double* %l3
  %t98 = load i8*, i8** %l1
  %t99 = load double, double* %l5
  store double 0.0, double* %l10
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load i8*, i8** %l6
  %t102 = getelementptr i8, i8* %t101, i64 0
  %t103 = load i8, i8* %t102
  %t104 = add i8 32, %t103
  %s105 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.105, i32 0, i32 0
  %t106 = getelementptr i8, i8* %s105, i64 0
  %t107 = load i8, i8* %t106
  %t108 = add i8 %t104, %t107
  %t109 = load double, double* %l10
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = call i8* @join_lines({ i8**, i64 }* %t110)
  ret i8* %t111
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
  %t67 = phi { i8**, i64 }* [ %t7, %entry ], [ %t64, %loop.latch2 ]
  %t68 = phi i8* [ %t8, %entry ], [ %t65, %loop.latch2 ]
  %t69 = phi double [ %t9, %entry ], [ %t66, %loop.latch2 ]
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  store i8* %t68, i8** %l1
  store double %t69, double* %l2
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
  %t18 = getelementptr i8, i8* %source, i64 %t17
  %t19 = load i8, i8* %t18
  store i8 %t19, i8* %l3
  %t20 = load i8, i8* %l3
  %t21 = icmp eq i8 %t20, 13
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  %t25 = load i8, i8* %l3
  br i1 %t21, label %then6, label %merge7
then6:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %s29 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.29, i32 0, i32 0
  store i8* %s29, i8** %l1
  %t30 = load double, double* %l2
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  %t33 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp olt double %t32, %t34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = load double, double* %l2
  %t39 = load i8, i8* %l3
  br i1 %t35, label %then8, label %merge9
then8:
  br label %merge9
merge9:
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l2
  br label %loop.latch2
merge7:
  %t43 = load i8, i8* %l3
  %t44 = icmp eq i8 %t43, 10
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load double, double* %l2
  %t48 = load i8, i8* %l3
  br i1 %t44, label %then10, label %merge11
then10:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load i8*, i8** %l1
  %t51 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t49, i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  %s52 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.52, i32 0, i32 0
  store i8* %s52, i8** %l1
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l2
  br label %loop.latch2
merge11:
  %t56 = load i8*, i8** %l1
  %t57 = load i8, i8* %l3
  %t58 = getelementptr i8, i8* %t56, i64 0
  %t59 = load i8, i8* %t58
  %t60 = add i8 %t59, %t57
  store i8* null, i8** %l1
  %t61 = load double, double* %l2
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l2
  br label %loop.latch2
loop.latch2:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t70, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t73
}

define i8* @build_pointer_line(double %column, i8* %lexeme, i8* %line_text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  store double %column, double* %l0
  %t2 = load double, double* %l0
  %t3 = sitofp i64 1 to double
  %t4 = fcmp olt double %t2, %t3
  %t5 = load double, double* %l0
  br i1 %t4, label %then2, label %merge3
then2:
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l0
  br label %merge3
merge3:
  %t7 = phi double [ %t6, %then2 ], [ %t5, %entry ]
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  %t9 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp ogt double %t8, %t10
  %t12 = load double, double* %l0
  br i1 %t11, label %then4, label %merge5
then4:
  %t13 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t14 = sitofp i64 %t13 to double
  store double %t14, double* %l0
  br label %merge5
merge5:
  %t15 = phi double [ %t14, %then4 ], [ %t12, %entry ]
  store double %t15, double* %l0
  %s16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.16, i32 0, i32 0
  store i8* %s16, i8** %l1
  %t17 = sitofp i64 1 to double
  store double %t17, double* %l2
  %t18 = load double, double* %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t45 = phi i8* [ %t19, %entry ], [ %t43, %loop.latch8 ]
  %t46 = phi double [ %t20, %entry ], [ %t44, %loop.latch8 ]
  store i8* %t45, i8** %l1
  store double %t46, double* %l2
  br label %loop.body7
loop.body7:
  %t21 = load double, double* %l2
  %t22 = load double, double* %l0
  %t23 = fcmp oge double %t21, %t22
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  br i1 %t23, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t27 = load double, double* %l2
  %t28 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp ole double %t27, %t29
  %t31 = load double, double* %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  br i1 %t30, label %then12, label %else13
then12:
  store double 0.0, double* %l3
  %t34 = load double, double* %l3
  br label %merge14
else13:
  %t35 = load i8*, i8** %l1
  %t36 = getelementptr i8, i8* %t35, i64 0
  %t37 = load i8, i8* %t36
  %t38 = add i8 %t37, 32
  store i8* null, i8** %l1
  br label %merge14
merge14:
  %t39 = phi i8* [ %t32, %then12 ], [ null, %else13 ]
  store i8* %t39, i8** %l1
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l2
  br label %loop.latch8
loop.latch8:
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t47 = call i64 @sailfin_runtime_string_length(i8* %lexeme)
  %t48 = sitofp i64 %t47 to double
  store double %t48, double* %l4
  %t49 = load double, double* %l4
  %t50 = sitofp i64 0 to double
  %t51 = fcmp ole double %t49, %t50
  %t52 = load double, double* %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l4
  br i1 %t51, label %then15, label %merge16
then15:
  %t56 = sitofp i64 1 to double
  store double %t56, double* %l4
  br label %merge16
merge16:
  %t57 = phi double [ %t56, %then15 ], [ %t55, %entry ]
  store double %t57, double* %l4
  %t58 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t59 = load double, double* %l0
  %t60 = sitofp i64 1 to double
  %t61 = fsub double %t59, %t60
  %t62 = sitofp i64 %t58 to double
  %t63 = fsub double %t62, %t61
  store double %t63, double* %l5
  %t64 = load double, double* %l5
  %t65 = sitofp i64 0 to double
  %t66 = fcmp ole double %t64, %t65
  %t67 = load double, double* %l0
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l4
  %t71 = load double, double* %l5
  br i1 %t66, label %then17, label %merge18
then17:
  %t72 = sitofp i64 1 to double
  store double %t72, double* %l5
  br label %merge18
merge18:
  %t73 = phi double [ %t72, %then17 ], [ %t71, %entry ]
  store double %t73, double* %l5
  %t74 = load double, double* %l4
  %t75 = load double, double* %l5
  %t76 = fcmp ogt double %t74, %t75
  %t77 = load double, double* %l0
  %t78 = load i8*, i8** %l1
  %t79 = load double, double* %l2
  %t80 = load double, double* %l4
  %t81 = load double, double* %l5
  br i1 %t76, label %then19, label %merge20
then19:
  %t82 = load double, double* %l5
  store double %t82, double* %l4
  br label %merge20
merge20:
  %t83 = phi double [ %t82, %then19 ], [ %t80, %entry ]
  store double %t83, double* %l4
  %t84 = sitofp i64 0 to double
  store double %t84, double* %l6
  %t85 = load double, double* %l0
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l2
  %t88 = load double, double* %l4
  %t89 = load double, double* %l5
  %t90 = load double, double* %l6
  br label %loop.header21
loop.header21:
  %t109 = phi i8* [ %t86, %entry ], [ %t107, %loop.latch23 ]
  %t110 = phi double [ %t90, %entry ], [ %t108, %loop.latch23 ]
  store i8* %t109, i8** %l1
  store double %t110, double* %l6
  br label %loop.body22
loop.body22:
  %t91 = load double, double* %l6
  %t92 = load double, double* %l4
  %t93 = fcmp oge double %t91, %t92
  %t94 = load double, double* %l0
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l2
  %t97 = load double, double* %l4
  %t98 = load double, double* %l5
  %t99 = load double, double* %l6
  br i1 %t93, label %then25, label %merge26
then25:
  br label %afterloop24
merge26:
  %t100 = load i8*, i8** %l1
  %t101 = getelementptr i8, i8* %t100, i64 0
  %t102 = load i8, i8* %t101
  %t103 = add i8 %t102, 94
  store i8* null, i8** %l1
  %t104 = load double, double* %l6
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l6
  br label %loop.latch23
loop.latch23:
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l6
  br label %loop.header21
afterloop24:
  %t111 = load i8*, i8** %l1
  ret i8* %t111
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
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %NativeModule undef, { i8**, i64 }* %t2, 0
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
  %t22 = phi double [ %t4, %entry ], [ %t21, %loop.latch4 ]
  store double %t22, double* %l0
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
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = load double, double* %l0
  %t14 = getelementptr i8, i8* %prefix, i64 %t13
  %t15 = load i8, i8* %t14
  %t16 = icmp ne i8 %t12, %t15
  %t17 = load double, double* %l0
  br i1 %t16, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch4
loop.latch4:
  %t21 = load double, double* %l0
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
  %t39 = phi double [ %t6, %entry ], [ %t38, %loop.latch6 ]
  store double %t39, double* %l0
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
  %t30 = phi double [ %t18, %loop.body5 ], [ %t29, %loop.latch12 ]
  store double %t30, double* %l2
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
  %t26 = load double, double* %l2
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l2
  br label %loop.latch12
loop.latch12:
  %t29 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t31 = load i1, i1* %l1
  %t32 = load double, double* %l0
  %t33 = load i1, i1* %l1
  %t34 = load double, double* %l2
  br i1 %t31, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t35 = load double, double* %l0
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l0
  br label %loop.latch6
loop.latch6:
  %t38 = load double, double* %l0
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
  %t63 = phi i8* [ %t3, %entry ], [ %t61, %loop.latch2 ]
  %t64 = phi double [ %t2, %entry ], [ %t62, %loop.latch2 ]
  store i8* %t63, i8** %l1
  store double %t64, double* %l0
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
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t13 = load i8, i8* %l2
  %t14 = icmp eq i8 %t13, 39
  %t15 = load double, double* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  %t18 = load double, double* %l0
  %t19 = call double @python_quote_length(i8* %value, double %t18, i8* null)
  store double %t19, double* %l3
  %t20 = load double, double* %l3
  %t21 = call i8* @repeat_character(i8* null, double %t20)
  store i8* %t21, i8** %l4
  %t22 = load i8*, i8** %l1
  %t23 = load i8*, i8** %l4
  %t24 = add i8* %t22, %t23
  store i8* %t24, i8** %l1
  %t25 = load double, double* %l0
  %t26 = load double, double* %l3
  %t27 = fadd double %t25, %t26
  %t28 = load double, double* %l3
  %t29 = call double @skip_python_string_literal(i8* %value, double %t27, i8* null, double %t28)
  store double %t29, double* %l0
  %t30 = load i8*, i8** %l1
  %t31 = load i8*, i8** %l4
  %t32 = add i8* %t30, %t31
  store i8* %t32, i8** %l1
  br label %loop.latch2
merge7:
  %t33 = load i8, i8* %l2
  %t34 = icmp eq i8 %t33, 34
  %t35 = load double, double* %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8, i8* %l2
  br i1 %t34, label %then8, label %merge9
then8:
  %t38 = load double, double* %l0
  %t39 = call double @python_quote_length(i8* %value, double %t38, i8* null)
  store double %t39, double* %l5
  %t40 = load double, double* %l5
  %t41 = call i8* @repeat_character(i8* null, double %t40)
  store i8* %t41, i8** %l6
  %t42 = load i8*, i8** %l1
  %t43 = load i8*, i8** %l6
  %t44 = add i8* %t42, %t43
  store i8* %t44, i8** %l1
  %t45 = load double, double* %l0
  %t46 = load double, double* %l5
  %t47 = fadd double %t45, %t46
  %t48 = load double, double* %l5
  %t49 = call double @skip_python_string_literal(i8* %value, double %t47, i8* null, double %t48)
  store double %t49, double* %l0
  %t50 = load i8*, i8** %l1
  %t51 = load i8*, i8** %l6
  %t52 = add i8* %t50, %t51
  store i8* %t52, i8** %l1
  br label %loop.latch2
merge9:
  %t53 = load i8*, i8** %l1
  %t54 = load i8, i8* %l2
  %t55 = getelementptr i8, i8* %t53, i64 0
  %t56 = load i8, i8* %t55
  %t57 = add i8 %t56, %t54
  store i8* null, i8** %l1
  %t58 = load double, double* %l0
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l0
  br label %loop.latch2
loop.latch2:
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t65 = load i8*, i8** %l1
  ret i8* %t65
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
  br label %merge1
merge1:
  %t5 = sitofp i64 1 to double
  ret double %t5
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
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load double, double* %l0
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load double, double* %l0
  %t19 = load i1, i1* %l1
  %t20 = load i8, i8* %l2
  br i1 %t17, label %then8, label %merge9
then8:
  store i1 0, i1* %l1
  br label %loop.latch4
merge9:
  %t21 = load i8, i8* %l2
  %t22 = icmp eq i8 %t21, 92
  %t23 = load double, double* %l0
  %t24 = load i1, i1* %l1
  %t25 = load i8, i8* %l2
  br i1 %t22, label %then10, label %merge11
then10:
  store i1 1, i1* %l1
  br label %loop.latch4
merge11:
  %t26 = load i8, i8* %l2
  %t27 = getelementptr i8, i8* %delimiter, i64 0
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t26, %t28
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
  %t71 = phi double [ %t38, %entry ], [ %t70, %loop.latch16 ]
  store double %t71, double* %l3
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
  %t60 = phi double [ %t50, %loop.body15 ], [ %t59, %loop.latch22 ]
  store double %t60, double* %l5
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
  %t56 = load double, double* %l5
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l5
  br label %loop.latch22
loop.latch22:
  %t59 = load double, double* %l5
  br label %loop.header20
afterloop23:
  %t61 = load i1, i1* %l4
  %t62 = load double, double* %l3
  %t63 = load i1, i1* %l4
  %t64 = load double, double* %l5
  br i1 %t61, label %then26, label %merge27
then26:
  %t65 = load double, double* %l3
  %t66 = fadd double %t65, %quote_length
  ret double %t66
merge27:
  %t67 = load double, double* %l3
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l3
  br label %loop.latch16
loop.latch16:
  %t70 = load double, double* %l3
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
  %t42 = phi double [ %t8, %entry ], [ %t41, %loop.latch6 ]
  store double %t42, double* %l0
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
  %t32 = phi double [ %t20, %loop.body5 ], [ %t31, %loop.latch12 ]
  store double %t32, double* %l2
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
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch12
loop.latch12:
  %t31 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t33 = load i1, i1* %l1
  %t34 = load double, double* %l0
  %t35 = load i1, i1* %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then16, label %merge17
then16:
  %t37 = load double, double* %l0
  ret double %t37
merge17:
  %t38 = load double, double* %l0
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l0
  br label %loop.latch6
loop.latch6:
  %t41 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t43 = sitofp i64 -1 to double
  ret double %t43
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
  %t41 = phi double [ %t7, %entry ], [ %t40, %loop.latch6 ]
  store double %t41, double* %l0
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
  %t31 = phi double [ %t19, %loop.body5 ], [ %t30, %loop.latch12 ]
  store double %t31, double* %l2
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
  %t27 = load double, double* %l2
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l2
  br label %loop.latch12
loop.latch12:
  %t30 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t32 = load i1, i1* %l1
  %t33 = load double, double* %l0
  %t34 = load i1, i1* %l1
  %t35 = load double, double* %l2
  br i1 %t32, label %then16, label %merge17
then16:
  %t36 = load double, double* %l0
  ret double %t36
merge17:
  %t37 = load double, double* %l0
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l0
  br label %loop.latch6
loop.latch6:
  %t40 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t42 = sitofp i64 -1 to double
  ret double %t42
}

define double @advance_to_line_end(i8* %value, double %position) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t17 = phi double [ %t0, %entry ], [ %t16, %loop.latch2 ]
  store double %t17, double* %l0
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
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l1
  %t9 = load double, double* %l0
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %t9, %t10
  store double %t11, double* %l0
  %t12 = load i8, i8* %l1
  %t13 = icmp eq i8 %t12, 10
  %t14 = load double, double* %l0
  %t15 = load i8, i8* %l1
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t18 = load double, double* %l0
  ret double %t18
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
  %t29 = phi i8* [ %t12, %entry ], [ %t27, %loop.latch10 ]
  %t30 = phi double [ %t11, %entry ], [ %t28, %loop.latch10 ]
  store i8* %t29, i8** %l1
  store double %t30, double* %l0
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
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  %t21 = getelementptr i8, i8* %t17, i64 0
  %t22 = load i8, i8* %t21
  %t23 = add i8 %t22, %t20
  store i8* null, i8** %l1
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch10
loop.latch10:
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t31 = load i8*, i8** %l1
  ret i8* %t31
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
