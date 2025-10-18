; ModuleID = 'sailfin'
source_filename = "sailfin"

%TraitImplementationDescriptor = type { i8*, { i8**, i64 }* }
%TraitDescriptor = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%TraitMetadata = type { { i8**, i64 }*, { i8**, i64 }* }
%FunctionEffectEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifestEntry = type { i8*, { i8**, i64 }* }
%CapabilityManifest = type { { i8**, i64 }* }
%RuntimeHelperDescriptor = type { i8*, i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%FunctionCallEntry = type { i8*, { i8**, i64 }* }
%StringConstant = type { i8*, i8*, double }
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
%LocalBinding = type { i8*, i8*, i8*, i8*, i8*, i1, i8*, double }
%LocalMutation = type { i8*, i8*, i8*, i8*, i8* }
%OwnershipAnalysis = type { i8*, i8*, { i8**, i64 }* }
%OperatorMatch = type { double, i8*, i1 }
%AssignmentParseResult = type { i1, i8*, i8* }
%BorrowParseResult = type { i1, i1, i8*, i1, { i8**, i64 }* }
%BorrowArgumentParse = type { i1, i8*, { i8**, i64 }* }
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

declare noalias i8* @malloc(i64)

@.str.43 = private unnamed_addr constant [23 x i8] c"; ModuleID = 'sailfin'\00"
@.str.46 = private unnamed_addr constant [28 x i8] c"source_filename = \22sailfin\22\00"
@.str.49 = private unnamed_addr constant [1 x i8] c"\00"
@.str.158 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.61 = private unnamed_addr constant [53 x i8] c"; -- Trait Metadata --------------------------------\00"
@.str.69 = private unnamed_addr constant [50 x i8] c"; -----------------------------------------------\00"
@.str.1 = private unnamed_addr constant [67 x i8] c"(\22 || ch == \22,\22 || ch == \22;\22 || ch == \22{\22 || ch == \22}\22 || ch == \22=\00"
@.str.0 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.2 = private unnamed_addr constant [60 x i8] c"(\22 + render_interface_parameters(signature.parameters) + \22)\00"
@.str.19 = private unnamed_addr constant [8 x i8] c"define \00"
@.str.22 = private unnamed_addr constant [7 x i8] c"entry:\00"
@.str.40 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.62 = private unnamed_addr constant [12 x i8] c"loop.header\00"
@.str.69 = private unnamed_addr constant [10 x i8] c"loop.body\00"
@.str.76 = private unnamed_addr constant [11 x i8] c"loop.latch\00"
@.str.83 = private unnamed_addr constant [10 x i8] c"afterloop\00"
@.str.91 = private unnamed_addr constant [13 x i8] c"  br label %\00"
@.str.97 = private unnamed_addr constant [2 x i8] c":\00"
@.str.99 = private unnamed_addr constant [3 x i8] c"  \00"
@.str.102 = private unnamed_addr constant [18 x i8] c" = getelementptr \00"
@.str.112 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.132 = private unnamed_addr constant [9 x i8] c" = load \00"
@.str.139 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.146 = private unnamed_addr constant [8 x i8] c"forbody\00"
@.str.153 = private unnamed_addr constant [7 x i8] c"forinc\00"
@.str.160 = private unnamed_addr constant [9 x i8] c"afterfor\00"
@.str.173 = private unnamed_addr constant [14 x i8] c" = alloca i64\00"
@.str.183 = private unnamed_addr constant [11 x i8] c" = alloca \00"
@.str.187 = private unnamed_addr constant [9 x i8] c"  store \00"
@.str.211 = private unnamed_addr constant [17 x i8] c" = icmp slt i64 \00"
@.str.216 = private unnamed_addr constant [9 x i8] c"  br i1 \00"
@.str.291 = private unnamed_addr constant [12 x i8] c" = add i64 \00"
@.str.296 = private unnamed_addr constant [13 x i8] c"  store i64 \00"
@.str.90 = private unnamed_addr constant [11 x i8] c"matchmerge\00"
@.str.18 = private unnamed_addr constant [44 x i8] c"llvm lowering: unsupported condition type `\00"
@.str.4 = private unnamed_addr constant [8 x i8] c" = phi \00"
@.str.7 = private unnamed_addr constant [2 x i8] c" \00"
@.str.16 = private unnamed_addr constant [3 x i8] c", \00"
@.str.23 = private unnamed_addr constant [5 x i8] c"then\00"
@.str.32 = private unnamed_addr constant [6 x i8] c"merge\00"
@.str.50 = private unnamed_addr constant [7 x i8] c"  ret \00"
@.str.12 = private unnamed_addr constant [3 x i8] c"{ \00"
@.str.231 = private unnamed_addr constant [40 x i8] c"llvm lowering: unsupported expression `\00"
@.str.234 = private unnamed_addr constant [2 x i8] c"`\00"
@.str.6 = private unnamed_addr constant [44 x i8] c" (\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.64 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.78 = private unnamed_addr constant [7 x i8] c"double\00"
@.str.164 = private unnamed_addr constant [9 x i8] c" = call \00"
@.str.168 = private unnamed_addr constant [3 x i8] c" @\00"
@.str.172 = private unnamed_addr constant [24 x i8] c"(\22 + argument_text + \22)\00"
@.str.72 = private unnamed_addr constant [17 x i8] c" = extractvalue \00"
@.str.125 = private unnamed_addr constant [2 x i8] c"[\00"
@.str.128 = private unnamed_addr constant [4 x i8] c" x \00"
@.str.132 = private unnamed_addr constant [2 x i8] c"]\00"
@.str.28 = private unnamed_addr constant [2 x i8] c".\00"
@.str.8 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str.28 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str.14 = private unnamed_addr constant [11 x i8] c" = and i1 \00"
@.str.10 = private unnamed_addr constant [50 x i8] c"llvm lowering: unable to coerce operand of type `\00"
@.str.13 = private unnamed_addr constant [7 x i8] c"` to `\00"
@.str.1 = private unnamed_addr constant [4 x i8] c"add\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"%t\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"%l\00"
@.str.6 = private unnamed_addr constant [16 x i8] c"zeroinitializer\00"
@.str.2 = private unnamed_addr constant [4 x i8] c"fn:\00"
@.str.2 = private unnamed_addr constant [3 x i8] c"::\00"
@.str.3 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.9 = private unnamed_addr constant [3 x i8] c".0\00"
@.str.1 = private unnamed_addr constant [7 x i8] c"@.str.\00"
@.str.12 = private unnamed_addr constant [5 x i8] c"  %s\00"
@.str.15 = private unnamed_addr constant [27 x i8] c" = getelementptr inbounds \00"

define %LoweredLLVMResult @lower_to_llvm(double %native_module) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca { %FunctionEffectEntry*, i64 }*
  %l10 = alloca { %FunctionCallEntry*, i64 }*
  %l11 = alloca { %FunctionEffectEntry*, i64 }*
  %l12 = alloca { %FunctionEffectEntry*, i64 }*
  %l13 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca { i8**, i64 }*
  %l16 = alloca { i8**, i64 }*
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca { i8**, i64 }*
  %l19 = alloca { i8**, i64 }*
  %l20 = alloca { i8**, i64 }*
  %l21 = alloca { i8**, i64 }*
  %l22 = alloca { i8**, i64 }*
  %l23 = alloca { i8**, i64 }*
  %l24 = alloca double
  %l25 = alloca i1
  %l26 = alloca { %StringConstant*, i64 }*
  %l27 = alloca double
  %l28 = alloca double
  %l29 = alloca { i8**, i64 }*
  %l30 = alloca %LoweredLLVMFunction
  %l31 = alloca { i8**, i64 }*
  %l32 = alloca { i8**, i64 }*
  %l33 = alloca i8*
  %l34 = alloca double
  %l35 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  store double 0.0, double* %l4
  %t13 = load double, double* %l4
  %t14 = load double, double* %l4
  store double 0.0, double* %l5
  %t15 = load double, double* %l2
  store double 0.0, double* %l6
  %t16 = load double, double* %l2
  %t17 = load double, double* %l6
  store double 0.0, double* %l7
  %t18 = load double, double* %l7
  %t19 = call { i8**, i64 }* @collect_runtime_helper_targets(double %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l8
  %t20 = load double, double* %l7
  %t21 = call { %FunctionEffectEntry*, i64 }* @collect_direct_function_effects(double %t20)
  store { %FunctionEffectEntry*, i64 }* %t21, { %FunctionEffectEntry*, i64 }** %l9
  %t22 = load double, double* %l7
  %t23 = call { %FunctionCallEntry*, i64 }* @collect_function_call_graph(double %t22)
  store { %FunctionCallEntry*, i64 }* %t23, { %FunctionCallEntry*, i64 }** %l10
  %t24 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t25 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t26 = call { %FunctionEffectEntry*, i64 }* @propagate_function_effects({ %FunctionEffectEntry*, i64 }* %t24, { %FunctionCallEntry*, i64 }* %t25)
  store { %FunctionEffectEntry*, i64 }* %t26, { %FunctionEffectEntry*, i64 }** %l11
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { %FunctionEffectEntry*, i64 }* null, { %FunctionEffectEntry*, i64 }** %l12
  %t32 = alloca [0 x double]
  %t33 = getelementptr [0 x double], [0 x double]* %t32, i32 0, i32 0
  %t34 = alloca { double*, i64 }
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 0
  store double* %t33, double** %t35
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l13
  %t37 = alloca [0 x double]
  %t38 = getelementptr [0 x double], [0 x double]* %t37, i32 0, i32 0
  %t39 = alloca { double*, i64 }
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 0
  store double* %t38, double** %t40
  %t41 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s43 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.43, i32 0, i32 0
  %t44 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t42, i8* %s43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l14
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s46 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.46, i32 0, i32 0
  %t47 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t45, i8* %s46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l14
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s49 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.49, i32 0, i32 0
  %t50 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t48, i8* %s49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l14
  %t51 = load double, double* %l3
  %t52 = call { i8**, i64 }* @render_trait_metadata_comments(%TraitMetadata zeroinitializer)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l15
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t54 = load double, double* %l5
  %t55 = call { i8**, i64 }* @render_struct_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l16
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t57 = load double, double* %l5
  %t58 = call { i8**, i64 }* @render_enum_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l17
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t60 = load double, double* %l5
  %t61 = call { i8**, i64 }* @render_interface_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l18
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t63 = load double, double* %l5
  %t64 = call { i8**, i64 }* @render_vtable_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l19
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t66 = load double, double* %l5
  %t67 = call { i8**, i64 }* @render_vtable_constants(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l20
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t70 = call { i8**, i64 }* @render_runtime_helper_declarations({ i8**, i64 }* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l21
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s74 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.74, i32 0, i32 0
  %t75 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t73, i8* %s74)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l14
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l14
  store { i8**, i64 }* %t76, { i8**, i64 }** %l22
  %t77 = alloca [0 x double]
  %t78 = getelementptr [0 x double], [0 x double]* %t77, i32 0, i32 0
  %t79 = alloca { double*, i64 }
  %t80 = getelementptr { double*, i64 }, { double*, i64 }* %t79, i32 0, i32 0
  store double* %t78, double** %t80
  %t81 = getelementptr { double*, i64 }, { double*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  store { i8**, i64 }* null, { i8**, i64 }** %l23
  %t82 = sitofp i64 0 to double
  store double %t82, double* %l24
  store i1 0, i1* %l25
  %t83 = alloca [0 x double]
  %t84 = getelementptr [0 x double], [0 x double]* %t83, i32 0, i32 0
  %t85 = alloca { double*, i64 }
  %t86 = getelementptr { double*, i64 }, { double*, i64 }* %t85, i32 0, i32 0
  store double* %t84, double** %t86
  %t87 = getelementptr { double*, i64 }, { double*, i64 }* %t85, i32 0, i32 1
  store i64 0, i64* %t87
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l26
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load double, double* %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load double, double* %l4
  %t93 = load double, double* %l5
  %t94 = load double, double* %l6
  %t95 = load double, double* %l7
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t97 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t98 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t99 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t100 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t101 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t112 = load double, double* %l24
  %t113 = load i1, i1* %l25
  %t114 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  br label %loop.header0
loop.header0:
  %t147 = phi { %FunctionEffectEntry*, i64 }* [ %t100, %entry ], [ %t143, %loop.latch2 ]
  %t148 = phi { i8**, i64 }* [ %t88, %entry ], [ %t144, %loop.latch2 ]
  %t149 = phi { %LifetimeRegionMetadata*, i64 }* [ %t101, %entry ], [ %t145, %loop.latch2 ]
  %t150 = phi { %StringConstant*, i64 }* [ %t114, %entry ], [ %t146, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t147, { %FunctionEffectEntry*, i64 }** %l12
  store { i8**, i64 }* %t148, { i8**, i64 }** %l0
  store { %LifetimeRegionMetadata*, i64 }* %t149, { %LifetimeRegionMetadata*, i64 }** %l13
  store { %StringConstant*, i64 }* %t150, { %StringConstant*, i64 }** %l26
  br label %loop.body1
loop.body1:
  %t115 = load double, double* %l24
  %t116 = load double, double* %l7
  store double 0.0, double* %l27
  %t117 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t118 = load double, double* %l27
  store double 0.0, double* %l28
  %t119 = alloca [0 x double]
  %t120 = getelementptr [0 x double], [0 x double]* %t119, i32 0, i32 0
  %t121 = alloca { double*, i64 }
  %t122 = getelementptr { double*, i64 }, { double*, i64 }* %t121, i32 0, i32 0
  store double* %t120, double** %t122
  %t123 = getelementptr { double*, i64 }, { double*, i64 }* %t121, i32 0, i32 1
  store i64 0, i64* %t123
  store { i8**, i64 }* null, { i8**, i64 }** %l29
  %t124 = load double, double* %l28
  %t125 = load double, double* %l27
  %t126 = load double, double* %l7
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t128 = load double, double* %l5
  %t129 = call %LoweredLLVMFunction @emit_function(double %t125, double %t126, { i8**, i64 }* %t127, %TypeContext zeroinitializer)
  store %LoweredLLVMFunction %t129, %LoweredLLVMFunction* %l30
  %t130 = load double, double* %l27
  %t131 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t132 = extractvalue %LoweredLLVMFunction %t131, 1
  %t133 = call double @diagnosticsconcat({ i8**, i64 }* %t132)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t134 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t135 = extractvalue %LoweredLLVMFunction %t134, 2
  %t136 = call double @lifetime_regionsconcat({ i8**, i64 }* %t135)
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l13
  %t137 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t138 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t139 = extractvalue %LoweredLLVMFunction %t138, 3
  %t140 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t137, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t140, { %StringConstant*, i64 }** %l26
  %t141 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t142 = extractvalue %LoweredLLVMFunction %t141, 0
  br label %loop.latch2
loop.latch2:
  %t143 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t146 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  br label %loop.header0
afterloop3:
  %t151 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t152 = call { i8**, i64 }* @render_string_constants({ %StringConstant*, i64 }* %t151)
  store { i8**, i64 }* %t152, { i8**, i64 }** %l31
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l22
  store { i8**, i64 }* %t153, { i8**, i64 }** %l32
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t156 = call double @final_linesconcat({ i8**, i64 }* %t155)
  store { i8**, i64 }* null, { i8**, i64 }** %l32
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %s158 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.158, i32 0, i32 0
  %t159 = call i8* @join_with_separator({ i8**, i64 }* %t157, i8* %s158)
  store i8* %t159, i8** %l33
  %t160 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  store double 0.0, double* %l34
  %t161 = load i8*, i8** %l33
  store i8* %t161, i8** %l35
  %t162 = load i8*, i8** %l35
  %t163 = load i8*, i8** %l35
  %t164 = insertvalue %LoweredLLVMResult undef, i8* %t163, 0
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = insertvalue %LoweredLLVMResult %t164, { i8**, i64 }* %t165, 1
  %t167 = load double, double* %l3
  %t168 = insertvalue %LoweredLLVMResult %t166, i8* null, 2
  %t169 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t170 = insertvalue %LoweredLLVMResult %t168, { i8**, i64 }* null, 3
  %t171 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t172 = insertvalue %LoweredLLVMResult %t170, { i8**, i64 }* null, 4
  %t173 = load double, double* %l34
  %t174 = insertvalue %LoweredLLVMResult %t172, i8* null, 5
  %t175 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t176 = insertvalue %LoweredLLVMResult %t174, { i8**, i64 }* null, 6
  ret %LoweredLLVMResult %t176
}

define %TraitMetadata @empty_trait_metadata() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %TraitMetadata undef, { i8**, i64 }* null, 0
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %TraitMetadata %t5, { i8**, i64 }* null, 1
  ret %TraitMetadata %t11
}

define %CapabilityManifest @empty_capability_manifest() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %CapabilityManifest undef, { i8**, i64 }* null, 0
  ret %CapabilityManifest %t5
}

define %TraitMetadata @build_trait_metadata(double %interfaces, double %structs) {
entry:
  %l0 = alloca { %TraitDescriptor*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca { %TraitImplementationDescriptor*, i64 }*
  %l4 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %TraitDescriptor*, i64 }* null, { %TraitDescriptor*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t10 = phi { %TraitDescriptor*, i64 }* [ %t6, %entry ], [ %t9, %loop.latch2 ]
  store { %TraitDescriptor*, i64 }* %t10, { %TraitDescriptor*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  br label %loop.latch2
loop.latch2:
  %t9 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %TraitImplementationDescriptor*, i64 }* null, { %TraitImplementationDescriptor*, i64 }** %l3
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l1
  %t17 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t20 = load double, double* %l1
  store double 0.0, double* %l4
  %t21 = load double, double* %l4
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t22 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t23 = insertvalue %TraitMetadata undef, { i8**, i64 }* null, 0
  %t24 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  %t25 = insertvalue %TraitMetadata %t23, { i8**, i64 }* null, 1
  ret %TraitMetadata %t25
}

define { i8**, i64 }* @render_trait_metadata_comments(%TraitMetadata %metadata) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi { i8**, i64 }* [ %t6, %entry ], [ %t34, %loop.latch2 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TraitMetadata %metadata, 0
  store double 0.0, double* %l2
  %s10 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l2
  store i8* null, i8** %l3
  %t12 = load double, double* %l2
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load i8*, i8** %l3
  %t15 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t13, i8* %t14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  %t20 = load i8*, i8** %l3
  %t21 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t32 = phi { i8**, i64 }* [ %t17, %loop.body1 ], [ %t31, %loop.latch6 ]
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  br label %loop.body5
loop.body5:
  %t22 = load double, double* %l4
  %t23 = load double, double* %l2
  store double 0.0, double* %l5
  %t24 = load double, double* %l5
  %t25 = call i8* @render_interface_signature(double %t24)
  store i8* %t25, i8** %l6
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s27 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  %t28 = load i8*, i8** %l6
  %t29 = add i8* %s27, %t28
  %t30 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t26, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  br label %loop.latch6
loop.latch6:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header4
afterloop7:
  %t33 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t36 = alloca [0 x double]
  %t37 = getelementptr [0 x double], [0 x double]* %t36, i32 0, i32 0
  %t38 = alloca { double*, i64 }
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 0
  store double* %t37, double** %t39
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l7
  br label %loop.header8
loop.header8:
  %t53 = phi { i8**, i64 }* [ %t44, %entry ], [ %t52, %loop.latch10 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l7
  br label %loop.body9
loop.body9:
  %t45 = load double, double* %l1
  %t46 = extractvalue %TraitMetadata %metadata, 1
  store double 0.0, double* %l8
  %s47 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.47, i32 0, i32 0
  %t48 = load double, double* %l8
  store i8* null, i8** %l9
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t50 = load i8*, i8** %l9
  %t51 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t49, i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l7
  br label %loop.latch10
loop.latch10:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l7
  br label %loop.header8
afterloop11:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = alloca [0 x double]
  %t56 = getelementptr [0 x double], [0 x double]* %t55, i32 0, i32 0
  %t57 = alloca { double*, i64 }
  %t58 = getelementptr { double*, i64 }, { double*, i64 }* %t57, i32 0, i32 0
  store double* %t56, double** %t58
  %t59 = getelementptr { double*, i64 }, { double*, i64 }* %t57, i32 0, i32 1
  store i64 0, i64* %t59
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s61 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.61, i32 0, i32 0
  %t62 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t60, i8* %s61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l10
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = call double @linesconcat({ i8**, i64 }* %t63)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t67 = call double @linesconcat({ i8**, i64 }* %t66)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s69 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.69, i32 0, i32 0
  %t70 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t68, i8* %s69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l10
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l10
  ret { i8**, i64 }* %t71
}

define { i8**, i64 }* @render_runtime_helper_declarations({ i8**, i64 }* %used_targets) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %RuntimeHelperDescriptor*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call { %RuntimeHelperDescriptor*, i64 }* @runtime_helper_descriptors()
  store { %RuntimeHelperDescriptor*, i64 }* %t5, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  store double 0.0, double* %l3
  %t12 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t13
}

define %TypeContext @empty_type_context() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %TypeContext undef, { i8**, i64 }* null, 0
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %TypeContext %t5, { i8**, i64 }* null, 1
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  %t17 = insertvalue %TypeContext %t11, { i8**, i64 }* null, 2
  %t18 = alloca [0 x double]
  %t19 = getelementptr [0 x double], [0 x double]* %t18, i32 0, i32 0
  %t20 = alloca { double*, i64 }
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 0
  store double* %t19, double** %t21
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  %t23 = insertvalue %TypeContext %t17, { i8**, i64 }* null, 3
  ret %TypeContext %t23
}

define %TypeContextBuild @build_type_context(double %structs, double %enums, double %interfaces) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %StructTypeInfo*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca { %StructFieldInfo*, i64 }*
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca i8*
  %l12 = alloca double
  %l13 = alloca { %EnumTypeInfo*, i64 }*
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca { %EnumVariantInfo*, i64 }*
  %l20 = alloca double
  %l21 = alloca double
  %l22 = alloca { %StructFieldInfo*, i64 }*
  %l23 = alloca double
  %l24 = alloca double
  %l25 = alloca double
  %l26 = alloca i8*
  %l27 = alloca double
  %l28 = alloca { %InterfaceTypeInfo*, i64 }*
  %l29 = alloca double
  %l30 = alloca double
  %l31 = alloca double
  %l32 = alloca double
  %l33 = alloca { %VTableInfo*, i64 }*
  %l34 = alloca double
  %l35 = alloca double
  %l36 = alloca double
  %l37 = alloca double
  %l38 = alloca double
  %l39 = alloca double
  %l40 = alloca double
  %l41 = alloca double
  %l42 = alloca i8*
  %l43 = alloca double
  %l44 = alloca double
  %l45 = alloca { %VTableEntry*, i64 }*
  %l46 = alloca double
  %l47 = alloca double
  %l48 = alloca { i8**, i64 }*
  %l49 = alloca double
  %l50 = alloca double
  %l51 = alloca double
  %l52 = alloca double
  %l53 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %StructTypeInfo*, i64 }* null, { %StructTypeInfo*, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t61 = phi { %StructTypeInfo*, i64 }* [ %t12, %entry ], [ %t60, %loop.latch2 ]
  store { %StructTypeInfo*, i64 }* %t61, { %StructTypeInfo*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  store double 0.0, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  store double 0.0, double* %l4
  %t17 = load double, double* %l3
  store double 0.0, double* %l5
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load double, double* %l5
  store double 0.0, double* %l6
  %t20 = alloca [0 x double]
  %t21 = getelementptr [0 x double], [0 x double]* %t20, i32 0, i32 0
  %t22 = alloca { double*, i64 }
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 0
  store double* %t21, double** %t23
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { %StructFieldInfo*, i64 }* null, { %StructFieldInfo*, i64 }** %l7
  %t25 = sitofp i64 0 to double
  store double %t25, double* %l8
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load double, double* %l4
  %t31 = load double, double* %l5
  %t32 = load double, double* %l6
  %t33 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t34 = load double, double* %l8
  br label %loop.header4
loop.header4:
  %t42 = phi { %StructFieldInfo*, i64 }* [ %t33, %loop.body1 ], [ %t41, %loop.latch6 ]
  store { %StructFieldInfo*, i64 }* %t42, { %StructFieldInfo*, i64 }** %l7
  br label %loop.body5
loop.body5:
  %t35 = load double, double* %l8
  %t36 = load double, double* %l4
  store double 0.0, double* %l9
  %t37 = load double, double* %l9
  store double 0.0, double* %l10
  %t38 = load double, double* %l10
  store i8* null, i8** %l11
  %t39 = load i8*, i8** %l11
  %t40 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  br label %loop.latch6
loop.latch6:
  %t41 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  br label %loop.header4
afterloop7:
  %t43 = load double, double* %l4
  store double 0.0, double* %l12
  %t44 = load double, double* %l12
  %t45 = sitofp i64 0 to double
  %t46 = fcmp ole double %t44, %t45
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load double, double* %l4
  %t52 = load double, double* %l5
  %t53 = load double, double* %l6
  %t54 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t55 = load double, double* %l8
  %t56 = load double, double* %l12
  br i1 %t46, label %then8, label %merge9
then8:
  %t57 = sitofp i64 1 to double
  store double %t57, double* %l12
  br label %merge9
merge9:
  %t58 = phi double [ %t57, %then8 ], [ %t56, %loop.body1 ]
  store double %t58, double* %l12
  %t59 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t60 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t62 = alloca [0 x double]
  %t63 = getelementptr [0 x double], [0 x double]* %t62, i32 0, i32 0
  %t64 = alloca { double*, i64 }
  %t65 = getelementptr { double*, i64 }, { double*, i64 }* %t64, i32 0, i32 0
  store double* %t63, double** %t65
  %t66 = getelementptr { double*, i64 }, { double*, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  store { %EnumTypeInfo*, i64 }* null, { %EnumTypeInfo*, i64 }** %l13
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l14
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t70 = load double, double* %l2
  %t71 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t72 = load double, double* %l14
  br label %loop.header10
loop.header10:
  %t147 = phi { %EnumTypeInfo*, i64 }* [ %t71, %entry ], [ %t146, %loop.latch12 ]
  store { %EnumTypeInfo*, i64 }* %t147, { %EnumTypeInfo*, i64 }** %l13
  br label %loop.body11
loop.body11:
  %t73 = load double, double* %l14
  store double 0.0, double* %l15
  %t74 = load double, double* %l15
  %t75 = load double, double* %l15
  store double 0.0, double* %l16
  %t76 = load double, double* %l15
  store double 0.0, double* %l17
  %s77 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.77, i32 0, i32 0
  %t78 = load double, double* %l17
  store double 0.0, double* %l18
  %t79 = alloca [0 x double]
  %t80 = getelementptr [0 x double], [0 x double]* %t79, i32 0, i32 0
  %t81 = alloca { double*, i64 }
  %t82 = getelementptr { double*, i64 }, { double*, i64 }* %t81, i32 0, i32 0
  store double* %t80, double** %t82
  %t83 = getelementptr { double*, i64 }, { double*, i64 }* %t81, i32 0, i32 1
  store i64 0, i64* %t83
  store { %EnumVariantInfo*, i64 }* null, { %EnumVariantInfo*, i64 }** %l19
  %t84 = sitofp i64 0 to double
  store double %t84, double* %l20
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t87 = load double, double* %l2
  %t88 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t89 = load double, double* %l14
  %t90 = load double, double* %l15
  %t91 = load double, double* %l16
  %t92 = load double, double* %l17
  %t93 = load double, double* %l18
  %t94 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t95 = load double, double* %l20
  br label %loop.header14
loop.header14:
  %t127 = phi { %EnumVariantInfo*, i64 }* [ %t94, %loop.body11 ], [ %t126, %loop.latch16 ]
  store { %EnumVariantInfo*, i64 }* %t127, { %EnumVariantInfo*, i64 }** %l19
  br label %loop.body15
loop.body15:
  %t96 = load double, double* %l20
  %t97 = load double, double* %l16
  store double 0.0, double* %l21
  %t98 = alloca [0 x double]
  %t99 = getelementptr [0 x double], [0 x double]* %t98, i32 0, i32 0
  %t100 = alloca { double*, i64 }
  %t101 = getelementptr { double*, i64 }, { double*, i64 }* %t100, i32 0, i32 0
  store double* %t99, double** %t101
  %t102 = getelementptr { double*, i64 }, { double*, i64 }* %t100, i32 0, i32 1
  store i64 0, i64* %t102
  store { %StructFieldInfo*, i64 }* null, { %StructFieldInfo*, i64 }** %l22
  %t103 = sitofp i64 0 to double
  store double %t103, double* %l23
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t106 = load double, double* %l2
  %t107 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t108 = load double, double* %l14
  %t109 = load double, double* %l15
  %t110 = load double, double* %l16
  %t111 = load double, double* %l17
  %t112 = load double, double* %l18
  %t113 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t114 = load double, double* %l20
  %t115 = load double, double* %l21
  %t116 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t117 = load double, double* %l23
  br label %loop.header18
loop.header18:
  %t125 = phi { %StructFieldInfo*, i64 }* [ %t116, %loop.body15 ], [ %t124, %loop.latch20 ]
  store { %StructFieldInfo*, i64 }* %t125, { %StructFieldInfo*, i64 }** %l22
  br label %loop.body19
loop.body19:
  %t118 = load double, double* %l23
  %t119 = load double, double* %l21
  store double 0.0, double* %l24
  %t120 = load double, double* %l24
  store double 0.0, double* %l25
  %t121 = load double, double* %l25
  store i8* null, i8** %l26
  %t122 = load i8*, i8** %l26
  %t123 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  br label %loop.latch20
loop.latch20:
  %t124 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  br label %loop.header18
afterloop21:
  br label %loop.latch16
loop.latch16:
  %t126 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  br label %loop.header14
afterloop17:
  %t128 = load double, double* %l16
  store double 0.0, double* %l27
  %t129 = load double, double* %l27
  %t130 = sitofp i64 0 to double
  %t131 = fcmp ole double %t129, %t130
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t134 = load double, double* %l2
  %t135 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t136 = load double, double* %l14
  %t137 = load double, double* %l15
  %t138 = load double, double* %l16
  %t139 = load double, double* %l17
  %t140 = load double, double* %l18
  %t141 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t142 = load double, double* %l20
  %t143 = load double, double* %l27
  br i1 %t131, label %then22, label %merge23
then22:
  %t144 = sitofp i64 1 to double
  store double %t144, double* %l27
  br label %merge23
merge23:
  %t145 = phi double [ %t144, %then22 ], [ %t143, %loop.body11 ]
  store double %t145, double* %l27
  br label %loop.latch12
loop.latch12:
  %t146 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  br label %loop.header10
afterloop13:
  %t148 = alloca [0 x double]
  %t149 = getelementptr [0 x double], [0 x double]* %t148, i32 0, i32 0
  %t150 = alloca { double*, i64 }
  %t151 = getelementptr { double*, i64 }, { double*, i64 }* %t150, i32 0, i32 0
  store double* %t149, double** %t151
  %t152 = getelementptr { double*, i64 }, { double*, i64 }* %t150, i32 0, i32 1
  store i64 0, i64* %t152
  store { %InterfaceTypeInfo*, i64 }* null, { %InterfaceTypeInfo*, i64 }** %l28
  %t153 = sitofp i64 0 to double
  store double %t153, double* %l29
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t156 = load double, double* %l2
  %t157 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t158 = load double, double* %l14
  %t159 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t160 = load double, double* %l29
  br label %loop.header24
loop.header24:
  %t166 = phi { %InterfaceTypeInfo*, i64 }* [ %t159, %entry ], [ %t165, %loop.latch26 ]
  store { %InterfaceTypeInfo*, i64 }* %t166, { %InterfaceTypeInfo*, i64 }** %l28
  br label %loop.body25
loop.body25:
  %t161 = load double, double* %l29
  store double 0.0, double* %l30
  %t162 = load double, double* %l30
  store double 0.0, double* %l31
  %s163 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.163, i32 0, i32 0
  %t164 = load double, double* %l31
  store double 0.0, double* %l32
  br label %loop.latch26
loop.latch26:
  %t165 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  br label %loop.header24
afterloop27:
  %t167 = alloca [0 x double]
  %t168 = getelementptr [0 x double], [0 x double]* %t167, i32 0, i32 0
  %t169 = alloca { double*, i64 }
  %t170 = getelementptr { double*, i64 }, { double*, i64 }* %t169, i32 0, i32 0
  store double* %t168, double** %t170
  %t171 = getelementptr { double*, i64 }, { double*, i64 }* %t169, i32 0, i32 1
  store i64 0, i64* %t171
  store { %VTableInfo*, i64 }* null, { %VTableInfo*, i64 }** %l33
  %t172 = sitofp i64 0 to double
  store double %t172, double* %l34
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t175 = load double, double* %l2
  %t176 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t177 = load double, double* %l14
  %t178 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t179 = load double, double* %l29
  %t180 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t181 = load double, double* %l34
  br label %loop.header28
loop.header28:
  %t291 = phi { %VTableInfo*, i64 }* [ %t180, %entry ], [ %t290, %loop.latch30 ]
  store { %VTableInfo*, i64 }* %t291, { %VTableInfo*, i64 }** %l33
  br label %loop.body29
loop.body29:
  %t182 = load double, double* %l34
  store double 0.0, double* %l35
  %t183 = sitofp i64 0 to double
  store double %t183, double* %l36
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t185 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t186 = load double, double* %l2
  %t187 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t188 = load double, double* %l14
  %t189 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t190 = load double, double* %l29
  %t191 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t192 = load double, double* %l34
  %t193 = load double, double* %l35
  %t194 = load double, double* %l36
  br label %loop.header32
loop.header32:
  %t289 = phi { %VTableInfo*, i64 }* [ %t191, %loop.body29 ], [ %t288, %loop.latch34 ]
  store { %VTableInfo*, i64 }* %t289, { %VTableInfo*, i64 }** %l33
  br label %loop.body33
loop.body33:
  %t195 = load double, double* %l36
  %t196 = load double, double* %l35
  store double 0.0, double* %l37
  store double 0.0, double* %l38
  %t197 = sitofp i64 0 to double
  store double %t197, double* %l39
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t200 = load double, double* %l2
  %t201 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t202 = load double, double* %l14
  %t203 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t204 = load double, double* %l29
  %t205 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t206 = load double, double* %l34
  %t207 = load double, double* %l35
  %t208 = load double, double* %l36
  %t209 = load double, double* %l37
  %t210 = load double, double* %l38
  %t211 = load double, double* %l39
  br label %loop.header36
loop.header36:
  br label %loop.body37
loop.body37:
  %t212 = load double, double* %l39
  br label %loop.latch38
loop.latch38:
  br label %loop.header36
afterloop39:
  %t213 = load double, double* %l38
  %t214 = load double, double* %l38
  store double %t214, double* %l40
  %t215 = load double, double* %l35
  store double 0.0, double* %l41
  %t216 = load double, double* %l37
  %t217 = call i8* @sanitize_symbol(i8* null)
  store i8* %t217, i8** %l42
  %s218 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.218, i32 0, i32 0
  %t219 = load double, double* %l41
  store double 0.0, double* %l43
  %s220 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.220, i32 0, i32 0
  %t221 = load double, double* %l41
  store double 0.0, double* %l44
  %t222 = alloca [0 x double]
  %t223 = getelementptr [0 x double], [0 x double]* %t222, i32 0, i32 0
  %t224 = alloca { double*, i64 }
  %t225 = getelementptr { double*, i64 }, { double*, i64 }* %t224, i32 0, i32 0
  store double* %t223, double** %t225
  %t226 = getelementptr { double*, i64 }, { double*, i64 }* %t224, i32 0, i32 1
  store i64 0, i64* %t226
  store { %VTableEntry*, i64 }* null, { %VTableEntry*, i64 }** %l45
  %t227 = sitofp i64 0 to double
  store double %t227, double* %l46
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t230 = load double, double* %l2
  %t231 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t232 = load double, double* %l14
  %t233 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t234 = load double, double* %l29
  %t235 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t236 = load double, double* %l34
  %t237 = load double, double* %l35
  %t238 = load double, double* %l36
  %t239 = load double, double* %l37
  %t240 = load double, double* %l38
  %t241 = load double, double* %l39
  %t242 = load double, double* %l40
  %t243 = load double, double* %l41
  %t244 = load i8*, i8** %l42
  %t245 = load double, double* %l43
  %t246 = load double, double* %l44
  %t247 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t248 = load double, double* %l46
  br label %loop.header40
loop.header40:
  %t287 = phi { %VTableEntry*, i64 }* [ %t247, %loop.body33 ], [ %t286, %loop.latch42 ]
  store { %VTableEntry*, i64 }* %t287, { %VTableEntry*, i64 }** %l45
  br label %loop.body41
loop.body41:
  %t249 = load double, double* %l46
  %t250 = load double, double* %l40
  store double 0.0, double* %l47
  store { i8**, i64 }* null, { i8**, i64 }** %l48
  %t251 = sitofp i64 1 to double
  store double %t251, double* %l49
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t253 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t254 = load double, double* %l2
  %t255 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t256 = load double, double* %l14
  %t257 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t258 = load double, double* %l29
  %t259 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t260 = load double, double* %l34
  %t261 = load double, double* %l35
  %t262 = load double, double* %l36
  %t263 = load double, double* %l37
  %t264 = load double, double* %l38
  %t265 = load double, double* %l39
  %t266 = load double, double* %l40
  %t267 = load double, double* %l41
  %t268 = load i8*, i8** %l42
  %t269 = load double, double* %l43
  %t270 = load double, double* %l44
  %t271 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t272 = load double, double* %l46
  %t273 = load double, double* %l47
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t275 = load double, double* %l49
  br label %loop.header44
loop.header44:
  %t283 = phi { i8**, i64 }* [ %t274, %loop.body41 ], [ %t282, %loop.latch46 ]
  store { i8**, i64 }* %t283, { i8**, i64 }** %l48
  br label %loop.body45
loop.body45:
  %t276 = load double, double* %l49
  %t277 = load double, double* %l47
  store double 0.0, double* %l50
  %t278 = load double, double* %l50
  store double 0.0, double* %l51
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t280 = load double, double* %l51
  %t281 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t279, i8* null)
  store { i8**, i64 }* %t281, { i8**, i64 }** %l48
  br label %loop.latch46
loop.latch46:
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l48
  br label %loop.header44
afterloop47:
  %t284 = load double, double* %l47
  store double 0.0, double* %l52
  %t285 = load double, double* %l52
  store double 0.0, double* %l53
  br label %loop.latch42
loop.latch42:
  %t286 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  br label %loop.header40
afterloop43:
  br label %loop.latch34
loop.latch34:
  %t288 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  br label %loop.header32
afterloop35:
  br label %loop.latch30
loop.latch30:
  %t290 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  br label %loop.header28
afterloop31:
  %t292 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t293 = insertvalue %TypeContext undef, { i8**, i64 }* null, 0
  %t294 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t295 = insertvalue %TypeContext %t293, { i8**, i64 }* null, 1
  %t296 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t297 = insertvalue %TypeContext %t295, { i8**, i64 }* null, 2
  %t298 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t299 = insertvalue %TypeContext %t297, { i8**, i64 }* null, 3
  %t300 = insertvalue %TypeContextBuild undef, i8* null, 0
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t302 = insertvalue %TypeContextBuild %t300, { i8**, i64 }* %t301, 1
  ret %TypeContextBuild %t302
}

define { %StructTypeInfo*, i64 }* @append_struct_type_info({ %StructTypeInfo*, i64 }* %values, %StructTypeInfo %value) {
entry:
  %t0 = alloca [1 x %StructTypeInfo]
  %t1 = getelementptr [1 x %StructTypeInfo], [1 x %StructTypeInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %StructTypeInfo, %StructTypeInfo* %t1, i64 0
  store %StructTypeInfo %value, %StructTypeInfo* %t2
  %t3 = alloca { %StructTypeInfo*, i64 }
  %t4 = getelementptr { %StructTypeInfo*, i64 }, { %StructTypeInfo*, i64 }* %t3, i32 0, i32 0
  store %StructTypeInfo* %t1, %StructTypeInfo** %t4
  %t5 = getelementptr { %StructTypeInfo*, i64 }, { %StructTypeInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %StructTypeInfo*, i64 }* %t3)
  ret { %StructTypeInfo*, i64 }* null
}

define { %StructFieldInfo*, i64 }* @append_struct_field_info({ %StructFieldInfo*, i64 }* %values, %StructFieldInfo %value) {
entry:
  %t0 = alloca [1 x %StructFieldInfo]
  %t1 = getelementptr [1 x %StructFieldInfo], [1 x %StructFieldInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %StructFieldInfo, %StructFieldInfo* %t1, i64 0
  store %StructFieldInfo %value, %StructFieldInfo* %t2
  %t3 = alloca { %StructFieldInfo*, i64 }
  %t4 = getelementptr { %StructFieldInfo*, i64 }, { %StructFieldInfo*, i64 }* %t3, i32 0, i32 0
  store %StructFieldInfo* %t1, %StructFieldInfo** %t4
  %t5 = getelementptr { %StructFieldInfo*, i64 }, { %StructFieldInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %StructFieldInfo*, i64 }* %t3)
  ret { %StructFieldInfo*, i64 }* null
}

define { %EnumVariantInfo*, i64 }* @append_enum_variant_info({ %EnumVariantInfo*, i64 }* %values, %EnumVariantInfo %value) {
entry:
  %t0 = alloca [1 x %EnumVariantInfo]
  %t1 = getelementptr [1 x %EnumVariantInfo], [1 x %EnumVariantInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %EnumVariantInfo, %EnumVariantInfo* %t1, i64 0
  store %EnumVariantInfo %value, %EnumVariantInfo* %t2
  %t3 = alloca { %EnumVariantInfo*, i64 }
  %t4 = getelementptr { %EnumVariantInfo*, i64 }, { %EnumVariantInfo*, i64 }* %t3, i32 0, i32 0
  store %EnumVariantInfo* %t1, %EnumVariantInfo** %t4
  %t5 = getelementptr { %EnumVariantInfo*, i64 }, { %EnumVariantInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %EnumVariantInfo*, i64 }* %t3)
  ret { %EnumVariantInfo*, i64 }* null
}

define { %EnumTypeInfo*, i64 }* @append_enum_type_info({ %EnumTypeInfo*, i64 }* %values, %EnumTypeInfo %value) {
entry:
  %t0 = alloca [1 x %EnumTypeInfo]
  %t1 = getelementptr [1 x %EnumTypeInfo], [1 x %EnumTypeInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %EnumTypeInfo, %EnumTypeInfo* %t1, i64 0
  store %EnumTypeInfo %value, %EnumTypeInfo* %t2
  %t3 = alloca { %EnumTypeInfo*, i64 }
  %t4 = getelementptr { %EnumTypeInfo*, i64 }, { %EnumTypeInfo*, i64 }* %t3, i32 0, i32 0
  store %EnumTypeInfo* %t1, %EnumTypeInfo** %t4
  %t5 = getelementptr { %EnumTypeInfo*, i64 }, { %EnumTypeInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %EnumTypeInfo*, i64 }* %t3)
  ret { %EnumTypeInfo*, i64 }* null
}

define { %InterfaceTypeInfo*, i64 }* @append_interface_type_info({ %InterfaceTypeInfo*, i64 }* %values, %InterfaceTypeInfo %value) {
entry:
  %t0 = alloca [1 x %InterfaceTypeInfo]
  %t1 = getelementptr [1 x %InterfaceTypeInfo], [1 x %InterfaceTypeInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %InterfaceTypeInfo, %InterfaceTypeInfo* %t1, i64 0
  store %InterfaceTypeInfo %value, %InterfaceTypeInfo* %t2
  %t3 = alloca { %InterfaceTypeInfo*, i64 }
  %t4 = getelementptr { %InterfaceTypeInfo*, i64 }, { %InterfaceTypeInfo*, i64 }* %t3, i32 0, i32 0
  store %InterfaceTypeInfo* %t1, %InterfaceTypeInfo** %t4
  %t5 = getelementptr { %InterfaceTypeInfo*, i64 }, { %InterfaceTypeInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %InterfaceTypeInfo*, i64 }* %t3)
  ret { %InterfaceTypeInfo*, i64 }* null
}

define { %VTableInfo*, i64 }* @append_vtable_info({ %VTableInfo*, i64 }* %values, %VTableInfo %value) {
entry:
  %t0 = alloca [1 x %VTableInfo]
  %t1 = getelementptr [1 x %VTableInfo], [1 x %VTableInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %VTableInfo, %VTableInfo* %t1, i64 0
  store %VTableInfo %value, %VTableInfo* %t2
  %t3 = alloca { %VTableInfo*, i64 }
  %t4 = getelementptr { %VTableInfo*, i64 }, { %VTableInfo*, i64 }* %t3, i32 0, i32 0
  store %VTableInfo* %t1, %VTableInfo** %t4
  %t5 = getelementptr { %VTableInfo*, i64 }, { %VTableInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %VTableInfo*, i64 }* %t3)
  ret { %VTableInfo*, i64 }* null
}

define { %VTableEntry*, i64 }* @append_vtable_entry({ %VTableEntry*, i64 }* %values, %VTableEntry %value) {
entry:
  %t0 = alloca [1 x %VTableEntry]
  %t1 = getelementptr [1 x %VTableEntry], [1 x %VTableEntry]* %t0, i32 0, i32 0
  %t2 = getelementptr %VTableEntry, %VTableEntry* %t1, i64 0
  store %VTableEntry %value, %VTableEntry* %t2
  %t3 = alloca { %VTableEntry*, i64 }
  %t4 = getelementptr { %VTableEntry*, i64 }, { %VTableEntry*, i64 }* %t3, i32 0, i32 0
  store %VTableEntry* %t1, %VTableEntry** %t4
  %t5 = getelementptr { %VTableEntry*, i64 }, { %VTableEntry*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %VTableEntry*, i64 }* %t3)
  ret { %VTableEntry*, i64 }* null
}

define { i8**, i64 }* @render_struct_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 0
  store double 0.0, double* %l2
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t25 = phi { i8**, i64 }* [ %t19, %loop.body1 ], [ %t24, %loop.latch6 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l3
  br label %loop.body5
loop.body5:
  %t21 = load double, double* %l4
  %t22 = load double, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %loop.latch6
loop.latch6:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %loop.header4
afterloop7:
  %s26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.26, i32 0, i32 0
  store i8* %s26, i8** %l5
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t32
}

define { i8**, i64 }* @render_enum_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t54 = phi { i8**, i64 }* [ %t6, %entry ], [ %t53, %loop.latch2 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 1
  store double 0.0, double* %l2
  %s10 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10, i32 0, i32 0
  store i8* %s10, i8** %l3
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = load double, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l5
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  %t20 = load i8*, i8** %l3
  %t21 = load double, double* %l4
  %t22 = load double, double* %l5
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t23 = load double, double* %l5
  %t24 = load double, double* %l2
  store double 0.0, double* %l6
  %t25 = load double, double* %l6
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %s26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.26, i32 0, i32 0
  store i8* %s26, i8** %l7
  %t27 = load double, double* %l4
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ogt double %t27, %t28
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load i8*, i8** %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load i8*, i8** %l7
  br i1 %t29, label %then8, label %merge9
then8:
  %s37 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.37, i32 0, i32 0
  %t38 = load double, double* %l4
  %t39 = call i8* @number_to_string(double %t38)
  %t40 = add i8* %s37, %t39
  %s41 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %t40, %s41
  store i8* %t42, i8** %l7
  br label %merge9
merge9:
  %t43 = phi i8* [ %t42, %then8 ], [ %t36, %loop.body1 ]
  store i8* %t43, i8** %l7
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = load i8*, i8** %l3
  %t46 = add i8* %s44, %t45
  %t47 = load i8*, i8** %l7
  %t48 = add i8* %t46, %t47
  %s49 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.49, i32 0, i32 0
  %t50 = add i8* %t48, %s49
  store i8* %t50, i8** %l8
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t55
}

define { i8**, i64 }* @render_interface_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t13 = phi { i8**, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 2
  store double 0.0, double* %l2
  store double 0.0, double* %l3
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t14
}

define { i8**, i64 }* @render_vtable_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 3
  store double 0.0, double* %l2
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t25 = phi { i8**, i64 }* [ %t19, %loop.body1 ], [ %t24, %loop.latch6 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l3
  br label %loop.body5
loop.body5:
  %t21 = load double, double* %l4
  %t22 = load double, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %loop.latch6
loop.latch6:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %loop.header4
afterloop7:
  %s26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.26, i32 0, i32 0
  store i8* %s26, i8** %l5
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t32
}

define { i8**, i64 }* @render_vtable_constants(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t36 = phi { i8**, i64 }* [ %t6, %entry ], [ %t35, %loop.latch2 ]
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 3
  store double 0.0, double* %l2
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t30 = phi { i8**, i64 }* [ %t19, %loop.body1 ], [ %t29, %loop.latch6 ]
  store { i8**, i64 }* %t30, { i8**, i64 }** %l3
  br label %loop.body5
loop.body5:
  %t21 = load double, double* %l4
  %t22 = load double, double* %l2
  store double 0.0, double* %l5
  %t23 = load double, double* %l5
  store double 0.0, double* %l6
  %s24 = getelementptr inbounds [111 x i8], [111 x i8]* @.str.24, i32 0, i32 0
  store i8* %s24, i8** %l7
  %t25 = load double, double* %l5
  store double 0.0, double* %l8
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t27 = load double, double* %l8
  %t28 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t26, i8* null)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  br label %loop.latch6
loop.latch6:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %loop.header4
afterloop7:
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.31, i32 0, i32 0
  store i8* %s31, i8** %l9
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t37
}

define i8* @map_type_annotation(i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @unwrap_move_wrapper(i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = load i8*, i8** %l1
  %t7 = load i8*, i8** %l1
  %t8 = load i8*, i8** %l1
  %s9 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.9, i32 0, i32 0
  %t10 = load i8*, i8** %l1
  %s11 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8*, i8** %l1
  ret i8* null
}

define i8* @map_struct_field_annotation(i8* %annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @map_type_annotation(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  ret i8* %t3
}

define { %FunctionEffectEntry*, i64 }* @collect_direct_function_effects(double %functions) {
entry:
  %l0 = alloca { %FunctionEffectEntry*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %FunctionEffectEntry*, i64 }* null, { %FunctionEffectEntry*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t13 = phi { %FunctionEffectEntry*, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t13, { %FunctionEffectEntry*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = call { %FunctionEffectEntry*, i64 }* @append_function_effect_entry({ %FunctionEffectEntry*, i64 }* %t9, %FunctionEffectEntry zeroinitializer)
  store { %FunctionEffectEntry*, i64 }* %t11, { %FunctionEffectEntry*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t12 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  ret { %FunctionEffectEntry*, i64 }* %t14
}

define { %FunctionCallEntry*, i64 }* @collect_function_call_graph(double %functions) {
entry:
  %l0 = alloca { %FunctionCallEntry*, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %FunctionCallEntry*, i64 }* null, { %FunctionCallEntry*, i64 }** %l0
  %t5 = call { i8**, i64 }* @collect_function_names(double %functions)
  store { i8**, i64 }* %t5, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t16 = phi { %FunctionCallEntry*, i64 }* [ %t7, %entry ], [ %t15, %loop.latch2 ]
  store { %FunctionCallEntry*, i64 }* %t16, { %FunctionCallEntry*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l3
  %t12 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t13 = load double, double* %l3
  %t14 = call { %FunctionCallEntry*, i64 }* @append_function_call_entry({ %FunctionCallEntry*, i64 }* %t12, %FunctionCallEntry zeroinitializer)
  store { %FunctionCallEntry*, i64 }* %t14, { %FunctionCallEntry*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t17 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  ret { %FunctionCallEntry*, i64 }* %t17
}

define %FunctionCallEntry @collect_function_call_entry(double %function, { i8**, i64 }* %function_names) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t14 = phi { i8**, i64 }* [ %t6, %entry ], [ %t13, %loop.latch2 ]
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = call { i8**, i64 }* @collect_instruction_calls(double %t10, { i8**, i64 }* %function_names)
  %t12 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t9, { i8**, i64 }* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t15 = insertvalue %FunctionCallEntry undef, i8* null, 0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = insertvalue %FunctionCallEntry %t15, { i8**, i64 }* %t16, 1
  ret %FunctionCallEntry %t17
}

define { i8**, i64 }* @collect_runtime_helper_targets(double %functions) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t13 = phi { i8**, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t9, { i8**, i64 }* null)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t14
}

define { i8**, i64 }* @collect_function_runtime_helper_targets(double %function) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t15 = phi { i8**, i64 }* [ %t6, %entry ], [ %t14, %loop.latch2 ]
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call { i8**, i64 }* @collect_instruction_runtime_helper_targets(double %t9)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t13 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t11, { i8**, i64 }* %t12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t16
}

define { i8**, i64 }* @collect_instruction_runtime_helper_targets(double %instruction) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @collect_instruction_calls(double %instruction, { i8**, i64 }* %function_names) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t5
}

define { i8**, i64 }* @collect_function_names(double %functions) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t11 = phi { i8**, i64 }* [ %t6, %entry ], [ %t10, %loop.latch2 ]
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t12
}

define { i8**, i64 }* @extract_call_targets(i8* %expression, { i8**, i64 }* %function_names) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l2
  %t12 = call i1 @is_identifier_start_char(i8* null)
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  %t16 = load double, double* %l1
  store double %t16, double* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t21 = load double, double* %l1
  store double 0.0, double* %l4
  %t22 = load double, double* %l4
  %t23 = call i1 @is_identifier_part_char(i8* null)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  br i1 %t23, label %then10, label %merge11
then10:
  br label %loop.latch8
merge11:
  %t29 = load double, double* %l4
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t31 = load double, double* %l3
  %t32 = load double, double* %l1
  %t33 = call double @substring(i8* %expression, double %t31, double %t32)
  %t34 = call i8* @trim_text(i8* null)
  store i8* %t34, i8** %l5
  %t35 = load i8*, i8** %l5
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t36
}

define { i8**, i64 }* @extract_all_call_targets(i8* %expression) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l2
  %t12 = call i1 @is_identifier_start_char(i8* null)
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  %t16 = load double, double* %l1
  store double %t16, double* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t21 = load double, double* %l1
  store double 0.0, double* %l4
  %t22 = load double, double* %l4
  %t23 = call i1 @is_identifier_part_char(i8* null)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  br i1 %t23, label %then10, label %merge11
then10:
  br label %loop.latch8
merge11:
  %t29 = load double, double* %l4
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t30 = load double, double* %l3
  %t31 = load double, double* %l1
  %t32 = call double @substring(i8* %expression, double %t30, double %t31)
  %t33 = call i8* @trim_text(i8* null)
  store i8* %t33, i8** %l5
  %t34 = load i8*, i8** %l5
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t35
}

define { i8**, i64 }* @filter_runtime_helper_targets({ i8**, i64 }* %targets) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call double @find_runtime_helper(i8* null)
  store double %t10, double* %l3
  %t11 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t12
}

define { %FunctionCallEntry*, i64 }* @append_function_call_entry({ %FunctionCallEntry*, i64 }* %entries, %FunctionCallEntry %entry) {
entry:
  %t0 = alloca [1 x %FunctionCallEntry]
  %t1 = getelementptr [1 x %FunctionCallEntry], [1 x %FunctionCallEntry]* %t0, i32 0, i32 0
  %t2 = getelementptr %FunctionCallEntry, %FunctionCallEntry* %t1, i64 0
  store %FunctionCallEntry %entry, %FunctionCallEntry* %t2
  %t3 = alloca { %FunctionCallEntry*, i64 }
  %t4 = getelementptr { %FunctionCallEntry*, i64 }, { %FunctionCallEntry*, i64 }* %t3, i32 0, i32 0
  store %FunctionCallEntry* %t1, %FunctionCallEntry** %t4
  %t5 = getelementptr { %FunctionCallEntry*, i64 }, { %FunctionCallEntry*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @entriesconcat({ %FunctionCallEntry*, i64 }* %t3)
  ret { %FunctionCallEntry*, i64 }* null
}

define { %FunctionEffectEntry*, i64 }* @propagate_function_effects({ %FunctionEffectEntry*, i64 }* %direct_effects, { %FunctionCallEntry*, i64 }* %call_graph) {
entry:
  %l0 = alloca { %FunctionEffectEntry*, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %FunctionEffectEntry*, i64 }* null, { %FunctionEffectEntry*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t10 = phi { %FunctionEffectEntry*, i64 }* [ %t6, %entry ], [ %t9, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t10, { %FunctionEffectEntry*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t9 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  br label %loop.header0
afterloop3:
  store i1 1, i1* %l2
  %t11 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load i1, i1* %l2
  br label %loop.header4
loop.header4:
  %t24 = phi i1 [ %t13, %entry ], [ %t23, %loop.latch6 ]
  store i1 %t24, i1* %l2
  br label %loop.body5
loop.body5:
  store i1 0, i1* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  %t15 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load i1, i1* %l2
  %t18 = load double, double* %l3
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t19 = load double, double* %l3
  store double 0.0, double* %l4
  %t20 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t21 = load double, double* %l4
  store double 0.0, double* %l5
  %t22 = load double, double* %l5
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  br label %loop.latch6
loop.latch6:
  %t23 = load i1, i1* %l2
  br label %loop.header4
afterloop7:
  %t25 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  ret { %FunctionEffectEntry*, i64 }* %t25
}

define %CapabilityManifest @build_capability_manifest({ i8**, i64 }* %entry_points, { %FunctionEffectEntry*, i64 }* %function_effects) {
entry:
  %l0 = alloca { %CapabilityManifestEntry*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %CapabilityManifestEntry*, i64 }* null, { %CapabilityManifestEntry*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi { %CapabilityManifestEntry*, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  store { %CapabilityManifestEntry*, i64 }* %t19, { %CapabilityManifestEntry*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call double @find_function_effect_entry({ %FunctionEffectEntry*, i64 }* %function_effects, i8* null)
  store double %t10, double* %l3
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t16 = load double, double* %l3
  %t17 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t20 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t21 = insertvalue %CapabilityManifest undef, { i8**, i64 }* null, 0
  ret %CapabilityManifest %t21
}

define { %CapabilityManifestEntry*, i64 }* @append_manifest_entry({ %CapabilityManifestEntry*, i64 }* %entries, %CapabilityManifestEntry %entry) {
entry:
  %t0 = alloca [1 x %CapabilityManifestEntry]
  %t1 = getelementptr [1 x %CapabilityManifestEntry], [1 x %CapabilityManifestEntry]* %t0, i32 0, i32 0
  %t2 = getelementptr %CapabilityManifestEntry, %CapabilityManifestEntry* %t1, i64 0
  store %CapabilityManifestEntry %entry, %CapabilityManifestEntry* %t2
  %t3 = alloca { %CapabilityManifestEntry*, i64 }
  %t4 = getelementptr { %CapabilityManifestEntry*, i64 }, { %CapabilityManifestEntry*, i64 }* %t3, i32 0, i32 0
  store %CapabilityManifestEntry* %t1, %CapabilityManifestEntry** %t4
  %t5 = getelementptr { %CapabilityManifestEntry*, i64 }, { %CapabilityManifestEntry*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @entriesconcat({ %CapabilityManifestEntry*, i64 }* %t3)
  ret { %CapabilityManifestEntry*, i64 }* null
}

define { %RuntimeHelperDescriptor*, i64 }* @runtime_helper_descriptors() {
entry:
  %l0 = alloca { %RuntimeHelperDescriptor*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %RuntimeHelperDescriptor*, i64 }* null, { %RuntimeHelperDescriptor*, i64 }** %l0
  %t5 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l0
  ret { %RuntimeHelperDescriptor*, i64 }* %t5
}

define { %RuntimeHelperDescriptor*, i64 }* @append_runtime_helper({ %RuntimeHelperDescriptor*, i64 }* %values, %RuntimeHelperDescriptor %value) {
entry:
  %t0 = alloca [1 x %RuntimeHelperDescriptor]
  %t1 = getelementptr [1 x %RuntimeHelperDescriptor], [1 x %RuntimeHelperDescriptor]* %t0, i32 0, i32 0
  %t2 = getelementptr %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %t1, i64 0
  store %RuntimeHelperDescriptor %value, %RuntimeHelperDescriptor* %t2
  %t3 = alloca { %RuntimeHelperDescriptor*, i64 }
  %t4 = getelementptr { %RuntimeHelperDescriptor*, i64 }, { %RuntimeHelperDescriptor*, i64 }* %t3, i32 0, i32 0
  store %RuntimeHelperDescriptor* %t1, %RuntimeHelperDescriptor** %t4
  %t5 = getelementptr { %RuntimeHelperDescriptor*, i64 }, { %RuntimeHelperDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %RuntimeHelperDescriptor*, i64 }* %t3)
  ret { %RuntimeHelperDescriptor*, i64 }* null
}

define %FunctionEffectEntry @collect_function_effect_entry(double %function) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = call { i8**, i64 }* @collect_function_borrow_effects(double %function)
  store { i8**, i64 }* %t6, { i8**, i64 }** %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = insertvalue %FunctionEffectEntry undef, i8* null, 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = insertvalue %FunctionEffectEntry %t8, { i8**, i64 }* %t9, 1
  ret %FunctionEffectEntry %t10
}

define { %FunctionEffectEntry*, i64 }* @append_function_effect_entry({ %FunctionEffectEntry*, i64 }* %values, %FunctionEffectEntry %entry) {
entry:
  %t0 = alloca [1 x %FunctionEffectEntry]
  %t1 = getelementptr [1 x %FunctionEffectEntry], [1 x %FunctionEffectEntry]* %t0, i32 0, i32 0
  %t2 = getelementptr %FunctionEffectEntry, %FunctionEffectEntry* %t1, i64 0
  store %FunctionEffectEntry %entry, %FunctionEffectEntry* %t2
  %t3 = alloca { %FunctionEffectEntry*, i64 }
  %t4 = getelementptr { %FunctionEffectEntry*, i64 }, { %FunctionEffectEntry*, i64 }* %t3, i32 0, i32 0
  store %FunctionEffectEntry* %t1, %FunctionEffectEntry** %t4
  %t5 = getelementptr { %FunctionEffectEntry*, i64 }, { %FunctionEffectEntry*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %FunctionEffectEntry*, i64 }* %t3)
  ret { %FunctionEffectEntry*, i64 }* null
}

define { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %base, { i8**, i64 }* %extras) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  store { i8**, i64 }* %base, { i8**, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t6 = phi { i8**, i64 }* [ %t1, %entry ], [ %t5, %loop.latch2 ]
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t7
}

define { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %t0 = call i1 @string_array_contains({ i8**, i64 }* %effects, i8* %effect)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %effects
merge1:
  %t1 = alloca [1 x i8*]
  %t2 = getelementptr [1 x i8*], [1 x i8*]* %t1, i32 0, i32 0
  %t3 = getelementptr i8*, i8** %t2, i64 0
  store i8* %effect, i8** %t3
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t2, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 1, i64* %t6
  %t7 = call double @effectsconcat({ i8**, i64 }* %t4)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @collect_function_borrow_effects(double %function) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t10
}

define { i8**, i64 }* @collect_expression_borrow_effects(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load i8*, i8** %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  %t12 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t13 = load double, double* %l3
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load double, double* %l3
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = load double, double* %l3
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t19
}

define double @skip_string_literal(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  store double %start_index, double* %l0
  store i1 0, i1* %l1
  %t0 = load double, double* %l0
  %t1 = load i1, i1* %l1
  br label %loop.header0
loop.header0:
  %t13 = phi i1 [ %t1, %entry ], [ %t12, %loop.latch2 ]
  store i1 %t13, i1* %l1
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  store double 0.0, double* %l2
  %t3 = load i1, i1* %l1
  %t4 = load double, double* %l0
  %t5 = load i1, i1* %l1
  %t6 = load double, double* %l2
  br i1 %t3, label %then4, label %else5
then4:
  store i1 0, i1* %l1
  br label %merge6
else5:
  %t7 = load double, double* %l2
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  br label %merge6
merge6:
  %t9 = phi i1 [ 0, %then4 ], [ %t5, %else5 ]
  store i1 %t9, i1* %l1
  %t10 = load double, double* %l2
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t12 = load i1, i1* %l1
  br label %loop.header0
afterloop3:
  %t14 = load double, double* %l0
  ret double %t14
}

define { i8**, i64 }* @copy_string_array({ i8**, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t11 = phi { i8**, i64 }* [ %t6, %entry ], [ %t10, %loop.latch2 ]
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t12
}

define i1 @string_arrays_equal({ i8**, i64 }* %first, { i8**, i64 }* %second) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @matches_keyword(i8* %value, double %start_index, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l1
  store double 0.0, double* %l2
  %t2 = load double, double* %l2
  %t3 = call i1 @is_identifier_part_char(i8* null)
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  ret i1 1
}

define i1 @is_effect_prefix_char(i8* %ch) {
entry:
  %t0 = call i1 @is_trim_char(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s1 = getelementptr inbounds [67 x i8], [67 x i8]* @.str.1, i32 0, i32 0
  ret i1 false
}

define i1 @is_effect_delimiter(i8* %ch) {
entry:
  %t0 = call i1 @is_trim_char(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  ret i1 false
}

define i1 @is_identifier_start_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.1, i32 0, i32 0
  %t2 = call double @index_of(i8* %s1, i8* %ch)
  %t3 = sitofp i64 -1 to double
  %t4 = fcmp une double %t2, %t3
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s5 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.5, i32 0, i32 0
  %t6 = call double @index_of(i8* %s5, i8* %ch)
  %t7 = sitofp i64 -1 to double
  %t8 = fcmp une double %t6, %t7
  br i1 %t8, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i1 @is_identifier_part_char(i8* %ch) {
entry:
  %t0 = call i1 @is_identifier_start_char(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s1 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.1, i32 0, i32 0
  %t2 = call double @index_of(i8* %s1, i8* %ch)
  %t3 = sitofp i64 -1 to double
  %t4 = fcmp une double %t2, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i8* @render_interface_signature(double %signature) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [60 x i8], [60 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %t1, %s2
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  ret i8* %t4
}

define i8* @render_interface_parameters(double %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t17 = phi { i8**, i64 }* [ %t6, %entry ], [ %t16, %loop.latch2 ]
  store { i8**, i64 }* %t17, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  store i8* null, i8** %l3
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load i8*, i8** %l3
  %t15 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t13, i8* %t14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define %LoweredLLVMFunction @emit_function(double %function, double %functions, { i8**, i64 }* %effects, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca %ParameterPreparation
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca %BodyResult
  %l7 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double 0.0, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %t6 = call %ParameterPreparation @prepare_parameters(double %function, %TypeContext %context)
  store %ParameterPreparation %t6, %ParameterPreparation* %l3
  %t7 = load %ParameterPreparation, %ParameterPreparation* %l3
  %t8 = extractvalue %ParameterPreparation %t7, 2
  %t9 = call double @diagnosticsconcat({ i8**, i64 }* %t8)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t15 = load %ParameterPreparation, %ParameterPreparation* %l3
  %t16 = extractvalue %ParameterPreparation %t15, 0
  store i8* null, i8** %l5
  %t17 = load i8*, i8** %l5
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s19 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.19, i32 0, i32 0
  %t20 = load double, double* %l2
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s22 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.22, i32 0, i32 0
  %t23 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t21, i8* %s22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l4
  %t24 = load double, double* %l2
  %t25 = load %ParameterPreparation, %ParameterPreparation* %l3
  %t26 = extractvalue %ParameterPreparation %t25, 1
  %t27 = call %BodyResult @emit_body(double %function, i8* null, { %ParameterBinding*, i64 }* null, double %functions, %TypeContext %context)
  store %BodyResult %t27, %BodyResult* %l6
  %t28 = load %BodyResult, %BodyResult* %l6
  %t29 = extractvalue %BodyResult %t28, 0
  %t30 = call double @linesconcat({ i8**, i64 }* %t29)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t31 = load %BodyResult, %BodyResult* %l6
  %t32 = extractvalue %BodyResult %t31, 1
  %t33 = call double @diagnosticsconcat({ i8**, i64 }* %t32)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t34 = load %BodyResult, %BodyResult* %l6
  %t35 = extractvalue %BodyResult %t34, 2
  %t36 = call { i8**, i64 }* @validate_borrow_lifetimes(double %function, { %LifetimeRegionMetadata*, i64 }* null)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l7
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t38 = call double @diagnosticsconcat({ i8**, i64 }* %t37)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s40 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.40, i32 0, i32 0
  %t41 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t39, i8* %s40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t43 = insertvalue %LoweredLLVMFunction undef, { i8**, i64 }* %t42, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = insertvalue %LoweredLLVMFunction %t43, { i8**, i64 }* %t44, 1
  %t46 = load %BodyResult, %BodyResult* %l6
  %t47 = extractvalue %BodyResult %t46, 2
  %t48 = insertvalue %LoweredLLVMFunction %t45, { i8**, i64 }* %t47, 2
  %t49 = load %BodyResult, %BodyResult* %l6
  %t50 = extractvalue %BodyResult %t49, 3
  %t51 = insertvalue %LoweredLLVMFunction %t48, { i8**, i64 }* %t50, 3
  ret %LoweredLLVMFunction %t51
}

define %BodyResult @emit_body(double %function, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t9 = insertvalue %BodyResult undef, { i8**, i64 }* %t8, 0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t11 = insertvalue %BodyResult %t9, { i8**, i64 }* %t10, 1
  %t12 = load double, double* %l0
  %t13 = insertvalue %BodyResult %t11, { i8**, i64 }* null, 2
  %t14 = load double, double* %l0
  %t15 = insertvalue %BodyResult %t13, { i8**, i64 }* null, 3
  ret %BodyResult %t15
}

define { i8**, i64 }* @validate_borrow_lifetimes(double %function, { %LifetimeRegionMetadata*, i64 }* %regions) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i1
  %l7 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  store double 0.0, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t29 = phi { i8**, i64 }* [ %t6, %entry ], [ %t28, %loop.latch2 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  store double 0.0, double* %l3
  %t10 = load double, double* %l3
  store double 0.0, double* %l4
  %t11 = load double, double* %l3
  store double 0.0, double* %l5
  %t12 = load double, double* %l4
  store i1 0, i1* %l6
  %t13 = load double, double* %l3
  %t14 = load i1, i1* %l6
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  %t20 = load double, double* %l5
  %t21 = load i1, i1* %l6
  br i1 %t14, label %then4, label %merge5
then4:
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  store i8* %s22, i8** %l7
  %t23 = load double, double* %l3
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s25 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.25, i32 0, i32 0
  %t26 = load double, double* %l3
  br label %merge5
merge5:
  %t27 = phi { i8**, i64 }* [ null, %then4 ], [ %t15, %loop.body1 ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t30
}

define %BlockLoweringResult @lower_instruction_range(double %function, double %start_index, double %end, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, double %functions, { %LoopContext*, i64 }* %loop_stack, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %LocalBinding*, i64 }*
  %l4 = alloca { %ParameterBinding*, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i1
  %l10 = alloca { %LoopContext*, i64 }*
  %l11 = alloca double
  %l12 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l13 = alloca { %LocalMutation*, i64 }*
  %l14 = alloca { %StringConstant*, i64 }*
  %l15 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store { i8**, i64 }* %allocas, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l4
  store double %temp_index, double* %l5
  store double %block_counter, double* %l6
  store double %next_local_id, double* %l7
  store double %next_region_id, double* %l8
  store i1 0, i1* %l9
  store { %LoopContext*, i64 }* %loop_stack, { %LoopContext*, i64 }** %l10
  store double %start_index, double* %l11
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l12
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l13
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l14
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t23 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t24 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t25 = load double, double* %l5
  %t26 = load double, double* %l6
  %t27 = load double, double* %l7
  %t28 = load double, double* %l8
  %t29 = load i1, i1* %l9
  %t30 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l10
  %t31 = load double, double* %l11
  %t32 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l12
  %t33 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l13
  %t34 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l14
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t35 = load double, double* %l11
  %t36 = fcmp oge double %t35, %end
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t41 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t42 = load double, double* %l5
  %t43 = load double, double* %l6
  %t44 = load double, double* %l7
  %t45 = load double, double* %l8
  %t46 = load i1, i1* %l9
  %t47 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l10
  %t48 = load double, double* %l11
  %t49 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l12
  %t50 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l13
  %t51 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l14
  br i1 %t36, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  store double 0.0, double* %l15
  %t52 = load double, double* %l15
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = insertvalue %BlockLoweringResult undef, { i8**, i64 }* %t53, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = insertvalue %BlockLoweringResult %t54, { i8**, i64 }* %t55, 1
  %t57 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t58 = insertvalue %BlockLoweringResult %t56, { i8**, i64 }* null, 2
  %t59 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t60 = insertvalue %BlockLoweringResult %t58, { i8**, i64 }* null, 3
  %t61 = load double, double* %l5
  %t62 = insertvalue %BlockLoweringResult %t60, double %t61, 4
  %t63 = load double, double* %l6
  %t64 = insertvalue %BlockLoweringResult %t62, double %t63, 5
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = insertvalue %BlockLoweringResult %t64, { i8**, i64 }* %t65, 6
  %t67 = load i1, i1* %l9
  %t68 = insertvalue %BlockLoweringResult %t66, i1 %t67, 7
  %t69 = load double, double* %l7
  %t70 = insertvalue %BlockLoweringResult %t68, double %t69, 8
  %t71 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l12
  %t72 = insertvalue %BlockLoweringResult %t70, { i8**, i64 }* null, 9
  %t73 = load double, double* %l8
  %t74 = insertvalue %BlockLoweringResult %t72, double %t73, 10
  %t75 = load double, double* %l11
  %t76 = insertvalue %BlockLoweringResult %t74, double %t75, 11
  %t77 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l13
  %t78 = insertvalue %BlockLoweringResult %t76, { i8**, i64 }* null, 12
  %t79 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l14
  %t80 = insertvalue %BlockLoweringResult %t78, { i8**, i64 }* null, 13
  ret %BlockLoweringResult %t80
}

define %IfStructure @collect_if_structure(double %instructions, double %start_index, double %end, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i1
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %start_index, %t5
  store double %t6, double* %l1
  store double %end, double* %l2
  %t7 = sitofp i64 -1 to double
  store double %t7, double* %l3
  %t8 = sitofp i64 -1 to double
  store double %t8, double* %l4
  store i1 0, i1* %l5
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l6
  %t10 = load double, double* %l1
  store double %t10, double* %l7
  store double %end, double* %l8
  %t11 = load double, double* %l8
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = load double, double* %l3
  %t16 = load double, double* %l4
  %t17 = load i1, i1* %l5
  %t18 = load double, double* %l6
  %t19 = load double, double* %l7
  %t20 = load double, double* %l8
  br label %loop.header0
loop.header0:
  %t43 = phi { i8**, i64 }* [ %t12, %entry ], [ %t42, %loop.latch2 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l7
  %t22 = load double, double* %l8
  %t23 = fcmp oge double %t21, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  %t29 = load i1, i1* %l5
  %t30 = load double, double* %l6
  %t31 = load double, double* %l7
  %t32 = load double, double* %l8
  br i1 %t23, label %then4, label %merge5
then4:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s34 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.34, i32 0, i32 0
  %t35 = add i8* %s34, %function_name
  %s36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %t35, %s36
  %t38 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t33, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  ret %IfStructure zeroinitializer
merge5:
  store double 0.0, double* %l9
  %t39 = load double, double* %l9
  %t40 = load double, double* %l9
  %t41 = load double, double* %l9
  br label %loop.latch2
loop.latch2:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  ret %IfStructure zeroinitializer
}

define %LoopStructure @collect_loop_structure(double %instructions, double %start_index, double %end, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %start_index, %t5
  store double %t6, double* %l1
  store double %end, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  %t8 = load double, double* %l1
  store double %t8, double* %l4
  store double %end, double* %l5
  %t9 = load double, double* %l5
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  %t13 = load double, double* %l3
  %t14 = load double, double* %l4
  %t15 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t46 = phi double [ %t15, %entry ], [ %t44, %loop.latch2 ]
  %t47 = phi { i8**, i64 }* [ %t10, %entry ], [ %t45, %loop.latch2 ]
  store double %t46, double* %l5
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t16 = load double, double* %l4
  %t17 = load double, double* %l5
  %t18 = fcmp oge double %t16, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  %t24 = load double, double* %l5
  br i1 %t18, label %then4, label %merge5
then4:
  %t25 = load double, double* %l5
  %t26 = sitofp i64 0 to double
  %t27 = fcmp ole double %t25, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  %t33 = load double, double* %l5
  br i1 %t27, label %then6, label %merge7
then6:
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l5
  br label %merge7
merge7:
  %t35 = phi double [ %t34, %then6 ], [ %t33, %then4 ]
  store double %t35, double* %l5
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %s37, %function_name
  %s39 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.39, i32 0, i32 0
  %t40 = add i8* %t38, %s39
  %t41 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t36, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  ret %LoopStructure zeroinitializer
merge5:
  store double 0.0, double* %l6
  %t42 = load double, double* %l6
  %t43 = load double, double* %l6
  br label %loop.latch2
loop.latch2:
  %t44 = load double, double* %l5
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  ret %LoopStructure zeroinitializer
}

define { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }* %values, %LoopContext %value) {
entry:
  %t0 = alloca [1 x %LoopContext]
  %t1 = getelementptr [1 x %LoopContext], [1 x %LoopContext]* %t0, i32 0, i32 0
  %t2 = getelementptr %LoopContext, %LoopContext* %t1, i64 0
  store %LoopContext %value, %LoopContext* %t2
  %t3 = alloca { %LoopContext*, i64 }
  %t4 = getelementptr { %LoopContext*, i64 }, { %LoopContext*, i64 }* %t3, i32 0, i32 0
  store %LoopContext* %t1, %LoopContext** %t4
  %t5 = getelementptr { %LoopContext*, i64 }, { %LoopContext*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %LoopContext*, i64 }* %t3)
  ret { %LoopContext*, i64 }* null
}

define %LoopContext @last_loop_context({ %LoopContext*, i64 }* %values) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = sitofp i64 0 to double
  %t2 = fcmp ole double %t0, %t1
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  %t5 = insertvalue %LoopContext undef, i8* %s4, 0
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  %t7 = insertvalue %LoopContext %t5, i8* %s6, 1
  ret %LoopContext %t7
merge1:
  %t8 = load double, double* %l0
  ret %LoopContext zeroinitializer
}

define %BlockLoweringResult @lower_loop_instruction(double %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, double %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %LocalBinding*, i64 }*
  %l4 = alloca { %ParameterBinding*, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l9 = alloca double
  %l10 = alloca { %LocalMutation*, i64 }*
  %l11 = alloca { %StringConstant*, i64 }*
  %l12 = alloca double
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca double
  %l18 = alloca %BlockLabelResult
  %l19 = alloca i8*
  %l20 = alloca %BlockLabelResult
  %l21 = alloca i8*
  %l22 = alloca %BlockLabelResult
  %l23 = alloca i8*
  %l24 = alloca %BlockLabelResult
  %l25 = alloca i8*
  %l26 = alloca %LoopContext
  %l27 = alloca { %LoopContext*, i64 }*
  %l28 = alloca { %LocalBinding*, i64 }*
  %l29 = alloca { i8**, i64 }*
  %l30 = alloca double
  %l31 = alloca i8*
  %l32 = alloca double
  %l33 = alloca { i8**, i64 }*
  %l34 = alloca { i8**, i64 }*
  %l35 = alloca { i8**, i64 }*
  %l36 = alloca double
  %l37 = alloca double
  %l38 = alloca i1
  %l39 = alloca double
  %l40 = alloca { i8**, i64 }*
  %l41 = alloca double
  %l42 = alloca double
  %l43 = alloca double
  %l44 = alloca double
  %l45 = alloca double
  %l46 = alloca double
  %l47 = alloca { i8**, i64 }*
  %l48 = alloca double
  %l49 = alloca i1
  %l50 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store { i8**, i64 }* %allocas, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l4
  store double %temp_index, double* %l5
  store double %block_counter, double* %l6
  store double %next_local_id, double* %l7
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l8
  store double %next_region_id, double* %l9
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l10
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l11
  store double 0.0, double* %l12
  %t20 = load double, double* %l12
  %t21 = alloca [0 x double]
  %t22 = getelementptr [0 x double], [0 x double]* %t21, i32 0, i32 0
  %t23 = alloca { double*, i64 }
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t23, i32 0, i32 0
  store double* %t22, double** %t24
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  store { i8**, i64 }* null, { i8**, i64 }** %l13
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l14
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t31 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t32 = load double, double* %l5
  %t33 = load double, double* %l6
  %t34 = load double, double* %l7
  %t35 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t36 = load double, double* %l9
  %t37 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t38 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t39 = load double, double* %l12
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t41 = load double, double* %l14
  br label %loop.header0
loop.header0:
  %t60 = phi { i8**, i64 }* [ %t28, %entry ], [ %t58, %loop.latch2 ]
  %t61 = phi { i8**, i64 }* [ %t40, %entry ], [ %t59, %loop.latch2 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  store { i8**, i64 }* %t61, { i8**, i64 }** %l13
  br label %loop.body1
loop.body1:
  %t42 = load double, double* %l14
  %t43 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l15
  %t44 = load double, double* %l5
  %t45 = call i8* @format_temp_name(double %t44)
  store i8* %t45, i8** %l16
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = load i8*, i8** %l16
  %t48 = add i8* %s46, %t47
  %s49 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.49, i32 0, i32 0
  %t50 = add i8* %t48, %s49
  %t51 = load double, double* %l15
  store double 0.0, double* %l17
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l17
  %t54 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t52, i8* null)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t56 = load i8*, i8** %l16
  %t57 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t55, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l13
  br label %loop.latch2
loop.latch2:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l13
  br label %loop.header0
afterloop3:
  %s62 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.62, i32 0, i32 0
  %t63 = load double, double* %l6
  %t64 = call %BlockLabelResult @allocate_block_label(i8* %s62, double %t63)
  store %BlockLabelResult %t64, %BlockLabelResult* %l18
  %t65 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t66 = extractvalue %BlockLabelResult %t65, 0
  store i8* %t66, i8** %l19
  %t67 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t68 = extractvalue %BlockLabelResult %t67, 1
  store double %t68, double* %l6
  %s69 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.69, i32 0, i32 0
  %t70 = load double, double* %l6
  %t71 = call %BlockLabelResult @allocate_block_label(i8* %s69, double %t70)
  store %BlockLabelResult %t71, %BlockLabelResult* %l20
  %t72 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t73 = extractvalue %BlockLabelResult %t72, 0
  store i8* %t73, i8** %l21
  %t74 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t75 = extractvalue %BlockLabelResult %t74, 1
  store double %t75, double* %l6
  %s76 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.76, i32 0, i32 0
  %t77 = load double, double* %l6
  %t78 = call %BlockLabelResult @allocate_block_label(i8* %s76, double %t77)
  store %BlockLabelResult %t78, %BlockLabelResult* %l22
  %t79 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t80 = extractvalue %BlockLabelResult %t79, 0
  store i8* %t80, i8** %l23
  %t81 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t82 = extractvalue %BlockLabelResult %t81, 1
  store double %t82, double* %l6
  %s83 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.83, i32 0, i32 0
  %t84 = load double, double* %l6
  %t85 = call %BlockLabelResult @allocate_block_label(i8* %s83, double %t84)
  store %BlockLabelResult %t85, %BlockLabelResult* %l24
  %t86 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t87 = extractvalue %BlockLabelResult %t86, 0
  store i8* %t87, i8** %l25
  %t88 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t89 = extractvalue %BlockLabelResult %t88, 1
  store double %t89, double* %l6
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s91 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.91, i32 0, i32 0
  %t92 = load i8*, i8** %l19
  %t93 = add i8* %s91, %t92
  %t94 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t90, i8* %t93)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t96 = load i8*, i8** %l19
  %s97 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.97, i32 0, i32 0
  %t98 = add i8* %t96, %s97
  %t99 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t95, i8* %t98)
  store { i8**, i64 }* %t99, { i8**, i64 }** %l1
  %t100 = load i8*, i8** %l25
  %t101 = insertvalue %LoopContext undef, i8* %t100, 0
  %t102 = load i8*, i8** %l23
  %t103 = insertvalue %LoopContext %t101, i8* %t102, 1
  store %LoopContext %t103, %LoopContext* %l26
  %t104 = load %LoopContext, %LoopContext* %l26
  %t105 = call { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }* %loop_stack, %LoopContext %t104)
  store { %LoopContext*, i64 }* %t105, { %LoopContext*, i64 }** %l27
  %t106 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store { %LocalBinding*, i64 }* %t106, { %LocalBinding*, i64 }** %l28
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store { i8**, i64 }* %t107, { i8**, i64 }** %l29
  %t108 = load double, double* %l7
  store double %t108, double* %l30
  %t109 = load i8*, i8** %l21
  %t110 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t109)
  store i8* %t110, i8** %l31
  store double 0.0, double* %l32
  %t111 = load double, double* %l32
  %t112 = load double, double* %l32
  %t113 = load double, double* %l32
  %t114 = load double, double* %l32
  %t115 = load double, double* %l32
  %t116 = load double, double* %l32
  %t117 = load double, double* %l32
  %t118 = load double, double* %l32
  %t119 = load double, double* %l32
  %t120 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t121 = load double, double* %l32
  %t122 = alloca [0 x double]
  %t123 = getelementptr [0 x double], [0 x double]* %t122, i32 0, i32 0
  %t124 = alloca { double*, i64 }
  %t125 = getelementptr { double*, i64 }, { double*, i64 }* %t124, i32 0, i32 0
  store double* %t123, double** %t125
  %t126 = getelementptr { double*, i64 }, { double*, i64 }* %t124, i32 0, i32 1
  store i64 0, i64* %t126
  store { i8**, i64 }* null, { i8**, i64 }** %l33
  %t127 = alloca [0 x double]
  %t128 = getelementptr [0 x double], [0 x double]* %t127, i32 0, i32 0
  %t129 = alloca { double*, i64 }
  %t130 = getelementptr { double*, i64 }, { double*, i64 }* %t129, i32 0, i32 0
  store double* %t128, double** %t130
  %t131 = getelementptr { double*, i64 }, { double*, i64 }* %t129, i32 0, i32 1
  store i64 0, i64* %t131
  store { i8**, i64 }* null, { i8**, i64 }** %l34
  %t132 = alloca [0 x double]
  %t133 = getelementptr [0 x double], [0 x double]* %t132, i32 0, i32 0
  %t134 = alloca { double*, i64 }
  %t135 = getelementptr { double*, i64 }, { double*, i64 }* %t134, i32 0, i32 0
  store double* %t133, double** %t135
  %t136 = getelementptr { double*, i64 }, { double*, i64 }* %t134, i32 0, i32 1
  store i64 0, i64* %t136
  store { i8**, i64 }* null, { i8**, i64 }** %l35
  %t137 = sitofp i64 0 to double
  store double %t137, double* %l36
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t141 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t142 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t143 = load double, double* %l5
  %t144 = load double, double* %l6
  %t145 = load double, double* %l7
  %t146 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t147 = load double, double* %l9
  %t148 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t149 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t150 = load double, double* %l12
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t152 = load double, double* %l14
  %t153 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t154 = load i8*, i8** %l19
  %t155 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t156 = load i8*, i8** %l21
  %t157 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t158 = load i8*, i8** %l23
  %t159 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t160 = load i8*, i8** %l25
  %t161 = load %LoopContext, %LoopContext* %l26
  %t162 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t163 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t165 = load double, double* %l30
  %t166 = load i8*, i8** %l31
  %t167 = load double, double* %l32
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t171 = load double, double* %l36
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t172 = load double, double* %l36
  %t173 = load double, double* %l32
  store double 0.0, double* %l37
  store i1 0, i1* %l38
  %t174 = sitofp i64 0 to double
  store double %t174, double* %l39
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t178 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t179 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t180 = load double, double* %l5
  %t181 = load double, double* %l6
  %t182 = load double, double* %l7
  %t183 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t184 = load double, double* %l9
  %t185 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t186 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t187 = load double, double* %l12
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t189 = load double, double* %l14
  %t190 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t191 = load i8*, i8** %l19
  %t192 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t193 = load i8*, i8** %l21
  %t194 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t195 = load i8*, i8** %l23
  %t196 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t197 = load i8*, i8** %l25
  %t198 = load %LoopContext, %LoopContext* %l26
  %t199 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t200 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t202 = load double, double* %l30
  %t203 = load i8*, i8** %l31
  %t204 = load double, double* %l32
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t208 = load double, double* %l36
  %t209 = load double, double* %l37
  %t210 = load i1, i1* %l38
  %t211 = load double, double* %l39
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t212 = load double, double* %l39
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l35
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s215 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.215, i32 0, i32 0
  %t216 = load i8*, i8** %l21
  %t217 = add i8* %s215, %t216
  %t218 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t214, i8* %t217)
  store { i8**, i64 }* %t218, { i8**, i64 }** %l1
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load i8*, i8** %l21
  %s221 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.221, i32 0, i32 0
  %t222 = add i8* %t220, %s221
  %t223 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t219, i8* %t222)
  store { i8**, i64 }* %t223, { i8**, i64 }** %l1
  %t224 = load double, double* %l32
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t226 = load i8*, i8** %l23
  %s227 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.227, i32 0, i32 0
  %t228 = add i8* %t226, %s227
  %t229 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t225, i8* %t228)
  store { i8**, i64 }* %t229, { i8**, i64 }** %l1
  %t230 = alloca [0 x double]
  %t231 = getelementptr [0 x double], [0 x double]* %t230, i32 0, i32 0
  %t232 = alloca { double*, i64 }
  %t233 = getelementptr { double*, i64 }, { double*, i64 }* %t232, i32 0, i32 0
  store double* %t231, double** %t233
  %t234 = getelementptr { double*, i64 }, { double*, i64 }* %t232, i32 0, i32 1
  store i64 0, i64* %t234
  store { i8**, i64 }* null, { i8**, i64 }** %l40
  %t235 = sitofp i64 0 to double
  store double %t235, double* %l41
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t239 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t240 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t241 = load double, double* %l5
  %t242 = load double, double* %l6
  %t243 = load double, double* %l7
  %t244 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t245 = load double, double* %l9
  %t246 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t247 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t248 = load double, double* %l12
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t250 = load double, double* %l14
  %t251 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t252 = load i8*, i8** %l19
  %t253 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t254 = load i8*, i8** %l21
  %t255 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t256 = load i8*, i8** %l23
  %t257 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t258 = load i8*, i8** %l25
  %t259 = load %LoopContext, %LoopContext* %l26
  %t260 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t261 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t263 = load double, double* %l30
  %t264 = load i8*, i8** %l31
  %t265 = load double, double* %l32
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t269 = load double, double* %l36
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t271 = load double, double* %l41
  br label %loop.header12
loop.header12:
  br label %loop.body13
loop.body13:
  %t272 = load double, double* %l41
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l35
  store double 0.0, double* %l42
  %t274 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t275 = load double, double* %l42
  %t276 = call double @find_local_binding({ %LocalBinding*, i64 }* %t274, i8* null)
  store double %t276, double* %l43
  %t277 = load double, double* %l43
  br label %loop.latch14
loop.latch14:
  br label %loop.header12
afterloop15:
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s279 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.279, i32 0, i32 0
  %t280 = load i8*, i8** %l19
  %t281 = add i8* %s279, %t280
  %t282 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t278, i8* %t281)
  store { i8**, i64 }* %t282, { i8**, i64 }** %l1
  %t283 = sitofp i64 0 to double
  store double %t283, double* %l44
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t287 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t288 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t289 = load double, double* %l5
  %t290 = load double, double* %l6
  %t291 = load double, double* %l7
  %t292 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t293 = load double, double* %l9
  %t294 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t295 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t296 = load double, double* %l12
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t298 = load double, double* %l14
  %t299 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t300 = load i8*, i8** %l19
  %t301 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t302 = load i8*, i8** %l21
  %t303 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t304 = load i8*, i8** %l23
  %t305 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t306 = load i8*, i8** %l25
  %t307 = load %LoopContext, %LoopContext* %l26
  %t308 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t309 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t311 = load double, double* %l30
  %t312 = load i8*, i8** %l31
  %t313 = load double, double* %l32
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t317 = load double, double* %l36
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t319 = load double, double* %l41
  %t320 = load double, double* %l44
  br label %loop.header16
loop.header16:
  br label %loop.body17
loop.body17:
  %t321 = load double, double* %l44
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l35
  store double 0.0, double* %l45
  %t323 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t324 = load double, double* %l45
  %t325 = call double @find_local_binding({ %LocalBinding*, i64 }* %t323, i8* null)
  store double %t325, double* %l46
  %t326 = load double, double* %l46
  br label %loop.latch18
loop.latch18:
  br label %loop.header16
afterloop19:
  %t327 = alloca [0 x double]
  %t328 = getelementptr [0 x double], [0 x double]* %t327, i32 0, i32 0
  %t329 = alloca { double*, i64 }
  %t330 = getelementptr { double*, i64 }, { double*, i64 }* %t329, i32 0, i32 0
  store double* %t328, double** %t330
  %t331 = getelementptr { double*, i64 }, { double*, i64 }* %t329, i32 0, i32 1
  store i64 0, i64* %t331
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  %t332 = sitofp i64 0 to double
  store double %t332, double* %l48
  store i1 0, i1* %l49
  %t333 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t336 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t337 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t338 = load double, double* %l5
  %t339 = load double, double* %l6
  %t340 = load double, double* %l7
  %t341 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t342 = load double, double* %l9
  %t343 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t344 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t345 = load double, double* %l12
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t347 = load double, double* %l14
  %t348 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t349 = load i8*, i8** %l19
  %t350 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t351 = load i8*, i8** %l21
  %t352 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t353 = load i8*, i8** %l23
  %t354 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t355 = load i8*, i8** %l25
  %t356 = load %LoopContext, %LoopContext* %l26
  %t357 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t358 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t360 = load double, double* %l30
  %t361 = load i8*, i8** %l31
  %t362 = load double, double* %l32
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t366 = load double, double* %l36
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t368 = load double, double* %l41
  %t369 = load double, double* %l44
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t371 = load double, double* %l48
  %t372 = load i1, i1* %l49
  br label %loop.header20
loop.header20:
  %t379 = phi { i8**, i64 }* [ %t370, %entry ], [ %t378, %loop.latch22 ]
  store { i8**, i64 }* %t379, { i8**, i64 }** %l47
  br label %loop.body21
loop.body21:
  %t373 = load double, double* %l48
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l50
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t376 = load double, double* %l50
  %t377 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t375, i8* null)
  store { i8**, i64 }* %t377, { i8**, i64 }** %l47
  br label %loop.latch22
loop.latch22:
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l47
  br label %loop.header20
afterloop23:
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l47
  store { i8**, i64 }* %t380, { i8**, i64 }** %l1
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = load i8*, i8** %l25
  %s383 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.383, i32 0, i32 0
  %t384 = add i8* %t382, %s383
  %t385 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t381, i8* %t384)
  store { i8**, i64 }* %t385, { i8**, i64 }** %l1
  %t386 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  store { %LocalBinding*, i64 }* %t386, { %LocalBinding*, i64 }** %l3
  ret %BlockLoweringResult zeroinitializer
}

define %BlockLoweringResult @lower_for_instruction(double %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, double %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %LocalBinding*, i64 }*
  %l4 = alloca { %ParameterBinding*, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l9 = alloca double
  %l10 = alloca { %LocalMutation*, i64 }*
  %l11 = alloca { %StringConstant*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca double
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca %LLVMOperand
  %l26 = alloca i8*
  %l27 = alloca i8*
  %l28 = alloca %LLVMOperand
  %l29 = alloca %BlockLabelResult
  %l30 = alloca i8*
  %l31 = alloca %BlockLabelResult
  %l32 = alloca i8*
  %l33 = alloca %BlockLabelResult
  %l34 = alloca i8*
  %l35 = alloca %BlockLabelResult
  %l36 = alloca i8*
  %l37 = alloca i8*
  %l38 = alloca i8*
  %l39 = alloca i8*
  %l40 = alloca i8*
  %l41 = alloca i8*
  %l42 = alloca i8*
  %l43 = alloca i8*
  %l44 = alloca %LoopContext
  %l45 = alloca { %LoopContext*, i64 }*
  %l46 = alloca i8*
  %l47 = alloca double
  %l48 = alloca { %LocalBinding*, i64 }*
  %l49 = alloca double
  %l50 = alloca i8*
  %l51 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store { i8**, i64 }* %allocas, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l4
  store double %temp_index, double* %l5
  store double %block_counter, double* %l6
  store double %next_local_id, double* %l7
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l8
  store double %next_region_id, double* %l9
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l10
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l11
  store double 0.0, double* %l12
  %t20 = load double, double* %l12
  %t21 = load double, double* %l12
  store double 0.0, double* %l13
  store double 0.0, double* %l14
  %t22 = load double, double* %l14
  store double 0.0, double* %l15
  %t23 = load double, double* %l15
  %t24 = call i8* @strip_mut_prefix(i8* null)
  store double 0.0, double* %l15
  %t25 = load double, double* %l15
  %t26 = load double, double* %l15
  %t27 = call double @is_simple_identifier(double %t26)
  %t28 = fcmp one double %t27, 0.0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t32 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t33 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t34 = load double, double* %l5
  %t35 = load double, double* %l6
  %t36 = load double, double* %l7
  %t37 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t38 = load double, double* %l9
  %t39 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t40 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t41 = load double, double* %l12
  %t42 = load double, double* %l13
  %t43 = load double, double* %l14
  %t44 = load double, double* %l15
  br i1 %t28, label %then0, label %merge1
then0:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s46 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.46, i32 0, i32 0
  %t47 = load double, double* %l15
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = insertvalue %BlockLoweringResult undef, { i8**, i64 }* %t48, 0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = insertvalue %BlockLoweringResult %t49, { i8**, i64 }* %t50, 1
  %t52 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t53 = insertvalue %BlockLoweringResult %t51, { i8**, i64 }* null, 2
  %t54 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t55 = insertvalue %BlockLoweringResult %t53, { i8**, i64 }* null, 3
  %t56 = load double, double* %l5
  %t57 = insertvalue %BlockLoweringResult %t55, double %t56, 4
  %t58 = load double, double* %l6
  %t59 = insertvalue %BlockLoweringResult %t57, double %t58, 5
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = insertvalue %BlockLoweringResult %t59, { i8**, i64 }* %t60, 6
  %t62 = insertvalue %BlockLoweringResult %t61, i1 0, 7
  %t63 = load double, double* %l7
  %t64 = insertvalue %BlockLoweringResult %t62, double %t63, 8
  %t65 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t66 = insertvalue %BlockLoweringResult %t64, { i8**, i64 }* null, 9
  %t67 = load double, double* %l9
  %t68 = insertvalue %BlockLoweringResult %t66, double %t67, 10
  %t69 = load double, double* %l13
  %t70 = insertvalue %BlockLoweringResult %t68, double %t69, 11
  %t71 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t72 = insertvalue %BlockLoweringResult %t70, { i8**, i64 }* null, 12
  %t73 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t74 = insertvalue %BlockLoweringResult %t72, { i8**, i64 }* null, 13
  ret %BlockLoweringResult %t74
merge1:
  %t75 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t76 = load double, double* %l15
  %t77 = call double @find_local_binding({ %LocalBinding*, i64 }* %t75, i8* null)
  %t78 = load double, double* %l14
  store double 0.0, double* %l16
  %t79 = load double, double* %l16
  %t80 = load double, double* %l14
  %t81 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t82 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t83 = load double, double* %l5
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l17
  %t85 = load double, double* %l17
  %t86 = load double, double* %l17
  %t87 = load double, double* %l17
  %t88 = load double, double* %l17
  %t89 = load double, double* %l17
  store double 0.0, double* %l18
  %t90 = load double, double* %l18
  store double 0.0, double* %l19
  %t91 = load double, double* %l19
  %t92 = load double, double* %l19
  %t93 = call i8* @array_struct_type_for_element(i8* null)
  store i8* %t93, i8** %l20
  %t94 = load double, double* %l19
  store double 0.0, double* %l21
  %t95 = load double, double* %l21
  store double 0.0, double* %l22
  %t96 = load double, double* %l5
  %t97 = call i8* @format_temp_name(double %t96)
  store i8* %t97, i8** %l23
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s99 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.99, i32 0, i32 0
  %t100 = load i8*, i8** %l23
  %t101 = add i8* %s99, %t100
  %s102 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %t101, %s102
  %t104 = load i8*, i8** %l20
  %t105 = add i8* %t103, %t104
  %t106 = load double, double* %l5
  %t107 = call i8* @format_temp_name(double %t106)
  store i8* %t107, i8** %l24
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s109 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.109, i32 0, i32 0
  %t110 = load i8*, i8** %l24
  %t111 = add i8* %s109, %t110
  %s112 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.112, i32 0, i32 0
  %t113 = insertvalue %LLVMOperand undef, i8* %s112, 0
  %t114 = load i8*, i8** %l24
  %t115 = insertvalue %LLVMOperand %t113, i8* %t114, 1
  store %LLVMOperand %t115, %LLVMOperand* %l25
  %t116 = load double, double* %l5
  %t117 = call i8* @format_temp_name(double %t116)
  store i8* %t117, i8** %l26
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s119 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.119, i32 0, i32 0
  %t120 = load i8*, i8** %l26
  %t121 = add i8* %s119, %t120
  %s122 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.122, i32 0, i32 0
  %t123 = add i8* %t121, %s122
  %t124 = load i8*, i8** %l20
  %t125 = add i8* %t123, %t124
  %t126 = load double, double* %l5
  %t127 = call i8* @format_temp_name(double %t126)
  store i8* %t127, i8** %l27
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s129 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.129, i32 0, i32 0
  %t130 = load i8*, i8** %l27
  %t131 = add i8* %s129, %t130
  %s132 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.132, i32 0, i32 0
  %t133 = add i8* %t131, %s132
  %t134 = load double, double* %l21
  %t135 = load double, double* %l21
  %t136 = insertvalue %LLVMOperand undef, i8* null, 0
  %t137 = load i8*, i8** %l27
  %t138 = insertvalue %LLVMOperand %t136, i8* %t137, 1
  store %LLVMOperand %t138, %LLVMOperand* %l28
  %s139 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.139, i32 0, i32 0
  %t140 = load double, double* %l6
  %t141 = call %BlockLabelResult @allocate_block_label(i8* %s139, double %t140)
  store %BlockLabelResult %t141, %BlockLabelResult* %l29
  %t142 = load %BlockLabelResult, %BlockLabelResult* %l29
  %t143 = extractvalue %BlockLabelResult %t142, 0
  store i8* %t143, i8** %l30
  %t144 = load %BlockLabelResult, %BlockLabelResult* %l29
  %t145 = extractvalue %BlockLabelResult %t144, 1
  store double %t145, double* %l6
  %s146 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.146, i32 0, i32 0
  %t147 = load double, double* %l6
  %t148 = call %BlockLabelResult @allocate_block_label(i8* %s146, double %t147)
  store %BlockLabelResult %t148, %BlockLabelResult* %l31
  %t149 = load %BlockLabelResult, %BlockLabelResult* %l31
  %t150 = extractvalue %BlockLabelResult %t149, 0
  store i8* %t150, i8** %l32
  %t151 = load %BlockLabelResult, %BlockLabelResult* %l31
  %t152 = extractvalue %BlockLabelResult %t151, 1
  store double %t152, double* %l6
  %s153 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.153, i32 0, i32 0
  %t154 = load double, double* %l6
  %t155 = call %BlockLabelResult @allocate_block_label(i8* %s153, double %t154)
  store %BlockLabelResult %t155, %BlockLabelResult* %l33
  %t156 = load %BlockLabelResult, %BlockLabelResult* %l33
  %t157 = extractvalue %BlockLabelResult %t156, 0
  store i8* %t157, i8** %l34
  %t158 = load %BlockLabelResult, %BlockLabelResult* %l33
  %t159 = extractvalue %BlockLabelResult %t158, 1
  store double %t159, double* %l6
  %s160 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.160, i32 0, i32 0
  %t161 = load double, double* %l6
  %t162 = call %BlockLabelResult @allocate_block_label(i8* %s160, double %t161)
  store %BlockLabelResult %t162, %BlockLabelResult* %l35
  %t163 = load %BlockLabelResult, %BlockLabelResult* %l35
  %t164 = extractvalue %BlockLabelResult %t163, 0
  store i8* %t164, i8** %l36
  %t165 = load %BlockLabelResult, %BlockLabelResult* %l35
  %t166 = extractvalue %BlockLabelResult %t165, 1
  store double %t166, double* %l6
  %t167 = load double, double* %l7
  %t168 = call i8* @format_local_pointer_name(double %t167)
  store i8* %t168, i8** %l37
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s170 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.170, i32 0, i32 0
  %t171 = load i8*, i8** %l37
  %t172 = add i8* %s170, %t171
  %s173 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.173, i32 0, i32 0
  %t174 = add i8* %t172, %s173
  %t175 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t169, i8* %t174)
  store { i8**, i64 }* %t175, { i8**, i64 }** %l2
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t177 = load double, double* %l7
  %t178 = call i8* @format_local_pointer_name(double %t177)
  store i8* %t178, i8** %l38
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s180 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.180, i32 0, i32 0
  %t181 = load i8*, i8** %l38
  %t182 = add i8* %s180, %t181
  %s183 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.183, i32 0, i32 0
  %t184 = add i8* %t182, %s183
  %t185 = load double, double* %l19
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s187 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.187, i32 0, i32 0
  %t188 = load double, double* %l19
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s190 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.190, i32 0, i32 0
  %t191 = load i8*, i8** %l30
  %t192 = add i8* %s190, %t191
  %t193 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t189, i8* %t192)
  store { i8**, i64 }* %t193, { i8**, i64 }** %l1
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load i8*, i8** %l30
  %s196 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.196, i32 0, i32 0
  %t197 = add i8* %t195, %s196
  %t198 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t194, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l1
  %t199 = load double, double* %l5
  %t200 = call i8* @format_temp_name(double %t199)
  store i8* %t200, i8** %l39
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s202 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.202, i32 0, i32 0
  %t203 = load i8*, i8** %l39
  %t204 = add i8* %s202, %t203
  %t205 = load double, double* %l5
  %t206 = call i8* @format_temp_name(double %t205)
  store i8* %t206, i8** %l40
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s208 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.208, i32 0, i32 0
  %t209 = load i8*, i8** %l40
  %t210 = add i8* %s208, %t209
  %s211 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.211, i32 0, i32 0
  %t212 = add i8* %t210, %s211
  %t213 = load i8*, i8** %l39
  %t214 = add i8* %t212, %t213
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s216 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.216, i32 0, i32 0
  %t217 = load i8*, i8** %l40
  %t218 = add i8* %s216, %t217
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load i8*, i8** %l32
  %s221 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.221, i32 0, i32 0
  %t222 = add i8* %t220, %s221
  %t223 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t219, i8* %t222)
  store { i8**, i64 }* %t223, { i8**, i64 }** %l1
  %t224 = load double, double* %l5
  %t225 = call i8* @format_temp_name(double %t224)
  store i8* %t225, i8** %l41
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s227 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.227, i32 0, i32 0
  %t228 = load i8*, i8** %l41
  %t229 = add i8* %s227, %t228
  %t230 = load double, double* %l5
  %t231 = call i8* @format_temp_name(double %t230)
  store i8* %t231, i8** %l42
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s233 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.233, i32 0, i32 0
  %t234 = load i8*, i8** %l42
  %t235 = add i8* %s233, %t234
  %s236 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.236, i32 0, i32 0
  %t237 = add i8* %t235, %s236
  %t238 = load double, double* %l19
  %t239 = load double, double* %l5
  %t240 = call i8* @format_temp_name(double %t239)
  store i8* %t240, i8** %l43
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s242 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.242, i32 0, i32 0
  %t243 = load i8*, i8** %l43
  %t244 = add i8* %s242, %t243
  %s245 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.245, i32 0, i32 0
  %t246 = add i8* %t244, %s245
  %t247 = load double, double* %l19
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s249 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.249, i32 0, i32 0
  %t250 = load double, double* %l19
  %t251 = load i8*, i8** %l36
  %t252 = insertvalue %LoopContext undef, i8* %t251, 0
  %t253 = load i8*, i8** %l34
  %t254 = insertvalue %LoopContext %t252, i8* %t253, 1
  store %LoopContext %t254, %LoopContext* %l44
  %t255 = load %LoopContext, %LoopContext* %l44
  %t256 = call { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }* %loop_stack, %LoopContext %t255)
  store { %LoopContext*, i64 }* %t256, { %LoopContext*, i64 }** %l45
  %t257 = load i8*, i8** %l32
  %t258 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t257)
  store i8* %t258, i8** %l46
  store double 0.0, double* %l47
  %t259 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t260 = load double, double* %l47
  %t261 = call { %LocalBinding*, i64 }* @append_local_binding({ %LocalBinding*, i64 }* %t259, %LocalBinding zeroinitializer)
  store { %LocalBinding*, i64 }* %t261, { %LocalBinding*, i64 }** %l48
  store double 0.0, double* %l49
  %t262 = load double, double* %l49
  %t263 = load double, double* %l49
  %t264 = load double, double* %l49
  %t265 = load double, double* %l49
  %t266 = load double, double* %l49
  %t267 = load double, double* %l49
  %t268 = load double, double* %l49
  %t269 = load double, double* %l49
  %t270 = load double, double* %l49
  %t271 = load double, double* %l49
  %t272 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t273 = load double, double* %l49
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t275 = load i8*, i8** %l34
  %s276 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.276, i32 0, i32 0
  %t277 = add i8* %t275, %s276
  %t278 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t274, i8* %t277)
  store { i8**, i64 }* %t278, { i8**, i64 }** %l1
  %t279 = load double, double* %l5
  %t280 = call i8* @format_temp_name(double %t279)
  store i8* %t280, i8** %l50
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s282 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.282, i32 0, i32 0
  %t283 = load i8*, i8** %l50
  %t284 = add i8* %s282, %t283
  %t285 = load double, double* %l5
  %t286 = call i8* @format_temp_name(double %t285)
  store i8* %t286, i8** %l51
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s288 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.288, i32 0, i32 0
  %t289 = load i8*, i8** %l51
  %t290 = add i8* %s288, %t289
  %s291 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.291, i32 0, i32 0
  %t292 = add i8* %t290, %s291
  %t293 = load i8*, i8** %l50
  %t294 = add i8* %t292, %t293
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s296 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.296, i32 0, i32 0
  %t297 = load i8*, i8** %l51
  %t298 = add i8* %s296, %t297
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s300 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.300, i32 0, i32 0
  %t301 = load i8*, i8** %l30
  %t302 = add i8* %s300, %t301
  %t303 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t299, i8* %t302)
  store { i8**, i64 }* %t303, { i8**, i64 }** %l1
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t305 = load i8*, i8** %l36
  %s306 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.306, i32 0, i32 0
  %t307 = add i8* %t305, %s306
  %t308 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t304, i8* %t307)
  store { i8**, i64 }* %t308, { i8**, i64 }** %l1
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = insertvalue %BlockLoweringResult undef, { i8**, i64 }* %t309, 0
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t312 = insertvalue %BlockLoweringResult %t310, { i8**, i64 }* %t311, 1
  %t313 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t314 = insertvalue %BlockLoweringResult %t312, { i8**, i64 }* null, 2
  %t315 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t316 = insertvalue %BlockLoweringResult %t314, { i8**, i64 }* null, 3
  %t317 = load double, double* %l5
  %t318 = insertvalue %BlockLoweringResult %t316, double %t317, 4
  %t319 = load double, double* %l6
  %t320 = insertvalue %BlockLoweringResult %t318, double %t319, 5
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t322 = insertvalue %BlockLoweringResult %t320, { i8**, i64 }* %t321, 6
  %t323 = insertvalue %BlockLoweringResult %t322, i1 0, 7
  %t324 = load double, double* %l7
  %t325 = insertvalue %BlockLoweringResult %t323, double %t324, 8
  %t326 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t327 = insertvalue %BlockLoweringResult %t325, { i8**, i64 }* null, 9
  %t328 = load double, double* %l9
  %t329 = insertvalue %BlockLoweringResult %t327, double %t328, 10
  %t330 = load double, double* %l13
  %t331 = insertvalue %BlockLoweringResult %t329, double %t330, 11
  %t332 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t333 = insertvalue %BlockLoweringResult %t331, { i8**, i64 }* null, 12
  %t334 = alloca [0 x double]
  %t335 = getelementptr [0 x double], [0 x double]* %t334, i32 0, i32 0
  %t336 = alloca { double*, i64 }
  %t337 = getelementptr { double*, i64 }, { double*, i64 }* %t336, i32 0, i32 0
  store double* %t335, double** %t337
  %t338 = getelementptr { double*, i64 }, { double*, i64 }* %t336, i32 0, i32 1
  store i64 0, i64* %t338
  %t339 = insertvalue %BlockLoweringResult %t333, { i8**, i64 }* null, 13
  ret %BlockLoweringResult %t339
}

define %MatchStructure @collect_match_structure(double %instructions, double %start_index, double %end, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %MatchCaseStructure*, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %MatchCaseStructure*, i64 }* null, { %MatchCaseStructure*, i64 }** %l1
  store double 0.0, double* %l2
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %start_index, %t10
  store double %t11, double* %l3
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l4
  store double %end, double* %l5
  %t13 = load double, double* %l5
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  %t19 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t50 = phi { i8**, i64 }* [ %t14, %entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l3
  %t21 = load double, double* %l5
  %t22 = fcmp oge double %t20, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  %t28 = load double, double* %l5
  br i1 %t22, label %then4, label %merge5
then4:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s30 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %s30, %function_name
  %s32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.32, i32 0, i32 0
  %t33 = add i8* %t31, %s32
  %t34 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t29, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l2
  ret %MatchStructure zeroinitializer
merge5:
  store double 0.0, double* %l6
  %t36 = load double, double* %l6
  %t37 = load double, double* %l6
  %t38 = load double, double* %l4
  %t39 = sitofp i64 0 to double
  %t40 = fcmp ogt double %t38, %t39
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  %t46 = load double, double* %l5
  %t47 = load double, double* %l6
  br i1 %t40, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t48 = load double, double* %l6
  br label %loop.latch2
loop.latch2:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  ret %MatchStructure zeroinitializer
}

define { %MatchCaseStructure*, i64 }* @append_match_case({ %MatchCaseStructure*, i64 }* %cases, %MatchCaseStructure %value) {
entry:
  %t0 = alloca [1 x %MatchCaseStructure]
  %t1 = getelementptr [1 x %MatchCaseStructure], [1 x %MatchCaseStructure]* %t0, i32 0, i32 0
  %t2 = getelementptr %MatchCaseStructure, %MatchCaseStructure* %t1, i64 0
  store %MatchCaseStructure %value, %MatchCaseStructure* %t2
  %t3 = alloca { %MatchCaseStructure*, i64 }
  %t4 = getelementptr { %MatchCaseStructure*, i64 }, { %MatchCaseStructure*, i64 }* %t3, i32 0, i32 0
  store %MatchCaseStructure* %t1, %MatchCaseStructure** %t4
  %t5 = getelementptr { %MatchCaseStructure*, i64 }, { %MatchCaseStructure*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @casesconcat({ %MatchCaseStructure*, i64 }* %t3)
  ret { %MatchCaseStructure*, i64 }* null
}

define %MatchCaseStructure @finalize_match_case(double %case, double %body_end) {
entry:
  %l0 = alloca double
  store double %case, double* %l0
  %t0 = load double, double* %l0
  %t1 = insertvalue %MatchCaseStructure undef, i8* null, 0
  %t2 = load double, double* %l0
  %t3 = insertvalue %MatchCaseStructure %t1, i8* null, 1
  %t4 = load double, double* %l0
  %t5 = insertvalue %MatchCaseStructure %t3, double 0.0, 2
  %t6 = insertvalue %MatchCaseStructure %t5, double %body_end, 3
  %t7 = load double, double* %l0
  %t8 = insertvalue %MatchCaseStructure %t6, i1 false, 4
  ret %MatchCaseStructure %t8
}

define i1 @is_default_pattern(i8* %pattern) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %pattern)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  ret i1 0
}

define %BlockLoweringResult @lower_match_instruction(double %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, double %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %LocalBinding*, i64 }*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca { %ParameterBinding*, i64 }*
  %l8 = alloca { %ParameterBinding*, i64 }*
  %l9 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l10 = alloca double
  %l11 = alloca { %LocalMutation*, i64 }*
  %l12 = alloca { %StringConstant*, i64 }*
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca { i8**, i64 }*
  %l19 = alloca double
  %l20 = alloca %BlockLabelResult
  %l21 = alloca %BlockLabelResult
  %l22 = alloca %BlockLabelResult
  %l23 = alloca i8*
  %l24 = alloca { i8**, i64 }*
  %l25 = alloca double
  %l26 = alloca double
  %l27 = alloca i8*
  %l28 = alloca double
  %l29 = alloca i1
  %l30 = alloca i1
  %l31 = alloca { %MatchArmMutations*, i64 }*
  %l32 = alloca double
  %l33 = alloca i8*
  %l34 = alloca double
  %l35 = alloca { %LocalBinding*, i64 }*
  %l36 = alloca { i8**, i64 }*
  %l37 = alloca double
  %l38 = alloca double
  %l39 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store { i8**, i64 }* %allocas, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  store double %temp_index, double* %l4
  store double %block_counter, double* %l5
  store double %next_local_id, double* %l6
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l7
  %t5 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store { %ParameterBinding*, i64 }* %t5, { %ParameterBinding*, i64 }** %l8
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l9
  store double %next_region_id, double* %l10
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l11
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l12
  store double 0.0, double* %l13
  %t21 = load double, double* %l13
  store double 0.0, double* %l14
  %t22 = load double, double* %l14
  %t23 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t24 = load double, double* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l15
  %t26 = load double, double* %l15
  %t27 = load double, double* %l15
  %t28 = load double, double* %l15
  %t29 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t30 = load double, double* %l15
  %t31 = load double, double* %l15
  %t32 = load double, double* %l15
  store double 0.0, double* %l16
  %t33 = load double, double* %l13
  %t34 = alloca [0 x double]
  %t35 = getelementptr [0 x double], [0 x double]* %t34, i32 0, i32 0
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t35, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  store { i8**, i64 }* null, { i8**, i64 }** %l17
  %t39 = alloca [0 x double]
  %t40 = getelementptr [0 x double], [0 x double]* %t39, i32 0, i32 0
  %t41 = alloca { double*, i64 }
  %t42 = getelementptr { double*, i64 }, { double*, i64 }* %t41, i32 0, i32 0
  store double* %t40, double** %t42
  %t43 = getelementptr { double*, i64 }, { double*, i64 }* %t41, i32 0, i32 1
  store i64 0, i64* %t43
  store { i8**, i64 }* null, { i8**, i64 }** %l18
  %t44 = sitofp i64 0 to double
  store double %t44, double* %l19
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t49 = load double, double* %l4
  %t50 = load double, double* %l5
  %t51 = load double, double* %l6
  %t52 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t53 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t54 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t55 = load double, double* %l10
  %t56 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t57 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t58 = load double, double* %l13
  %t59 = load double, double* %l14
  %t60 = load double, double* %l15
  %t61 = load double, double* %l16
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t64 = load double, double* %l19
  br label %loop.header0
loop.header0:
  %t87 = phi { i8**, i64 }* [ %t62, %entry ], [ %t84, %loop.latch2 ]
  %t88 = phi { i8**, i64 }* [ %t63, %entry ], [ %t85, %loop.latch2 ]
  %t89 = phi double [ %t50, %entry ], [ %t86, %loop.latch2 ]
  store { i8**, i64 }* %t87, { i8**, i64 }** %l17
  store { i8**, i64 }* %t88, { i8**, i64 }** %l18
  store double %t89, double* %l5
  br label %loop.body1
loop.body1:
  %t65 = load double, double* %l19
  %t66 = load double, double* %l13
  %s67 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.67, i32 0, i32 0
  %t68 = load double, double* %l5
  %t69 = call %BlockLabelResult @allocate_block_label(i8* %s67, double %t68)
  store %BlockLabelResult %t69, %BlockLabelResult* %l20
  %s70 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.70, i32 0, i32 0
  %t71 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t72 = extractvalue %BlockLabelResult %t71, 1
  %t73 = call %BlockLabelResult @allocate_block_label(i8* %s70, double %t72)
  store %BlockLabelResult %t73, %BlockLabelResult* %l21
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t75 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t76 = extractvalue %BlockLabelResult %t75, 0
  %t77 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t74, i8* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l17
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t79 = load %BlockLabelResult, %BlockLabelResult* %l21
  %t80 = extractvalue %BlockLabelResult %t79, 0
  %t81 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t78, i8* %t80)
  store { i8**, i64 }* %t81, { i8**, i64 }** %l18
  %t82 = load %BlockLabelResult, %BlockLabelResult* %l21
  %t83 = extractvalue %BlockLabelResult %t82, 1
  store double %t83, double* %l5
  br label %loop.latch2
loop.latch2:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t86 = load double, double* %l5
  br label %loop.header0
afterloop3:
  %s90 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.90, i32 0, i32 0
  %t91 = load double, double* %l5
  %t92 = call %BlockLabelResult @allocate_block_label(i8* %s90, double %t91)
  store %BlockLabelResult %t92, %BlockLabelResult* %l22
  %t93 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t94 = extractvalue %BlockLabelResult %t93, 0
  store i8* %t94, i8** %l23
  %t95 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t96 = extractvalue %BlockLabelResult %t95, 1
  store double %t96, double* %l5
  %t97 = alloca [0 x double]
  %t98 = getelementptr [0 x double], [0 x double]* %t97, i32 0, i32 0
  %t99 = alloca { double*, i64 }
  %t100 = getelementptr { double*, i64 }, { double*, i64 }* %t99, i32 0, i32 0
  store double* %t98, double** %t100
  %t101 = getelementptr { double*, i64 }, { double*, i64 }* %t99, i32 0, i32 1
  store i64 0, i64* %t101
  store { i8**, i64 }* null, { i8**, i64 }** %l24
  %t102 = sitofp i64 0 to double
  store double %t102, double* %l25
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t107 = load double, double* %l4
  %t108 = load double, double* %l5
  %t109 = load double, double* %l6
  %t110 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t111 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t112 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t113 = load double, double* %l10
  %t114 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t115 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t116 = load double, double* %l13
  %t117 = load double, double* %l14
  %t118 = load double, double* %l15
  %t119 = load double, double* %l16
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t122 = load double, double* %l19
  %t123 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t124 = load i8*, i8** %l23
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t126 = load double, double* %l25
  br label %loop.header4
loop.header4:
  %t145 = phi { i8**, i64 }* [ %t104, %entry ], [ %t143, %loop.latch6 ]
  %t146 = phi { i8**, i64 }* [ %t125, %entry ], [ %t144, %loop.latch6 ]
  store { i8**, i64 }* %t145, { i8**, i64 }** %l1
  store { i8**, i64 }* %t146, { i8**, i64 }** %l24
  br label %loop.body5
loop.body5:
  %t127 = load double, double* %l25
  %t128 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l26
  %t129 = load double, double* %l4
  %t130 = call i8* @format_temp_name(double %t129)
  store i8* %t130, i8** %l27
  %s131 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.131, i32 0, i32 0
  %t132 = load i8*, i8** %l27
  %t133 = add i8* %s131, %t132
  %s134 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.134, i32 0, i32 0
  %t135 = add i8* %t133, %s134
  %t136 = load double, double* %l26
  store double 0.0, double* %l28
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = load double, double* %l28
  %t139 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t137, i8* null)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l1
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t141 = load i8*, i8** %l27
  %t142 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t140, i8* %t141)
  store { i8**, i64 }* %t142, { i8**, i64 }** %l24
  br label %loop.latch6
loop.latch6:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br label %loop.header4
afterloop7:
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s148 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.148, i32 0, i32 0
  store i1 1, i1* %l29
  store i1 0, i1* %l30
  %t149 = alloca [0 x double]
  %t150 = getelementptr [0 x double], [0 x double]* %t149, i32 0, i32 0
  %t151 = alloca { double*, i64 }
  %t152 = getelementptr { double*, i64 }, { double*, i64 }* %t151, i32 0, i32 0
  store double* %t150, double** %t152
  %t153 = getelementptr { double*, i64 }, { double*, i64 }* %t151, i32 0, i32 1
  store i64 0, i64* %t153
  store { %MatchArmMutations*, i64 }* null, { %MatchArmMutations*, i64 }** %l31
  %t154 = sitofp i64 0 to double
  store double %t154, double* %l19
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t158 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t159 = load double, double* %l4
  %t160 = load double, double* %l5
  %t161 = load double, double* %l6
  %t162 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t163 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t164 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t165 = load double, double* %l10
  %t166 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t167 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t168 = load double, double* %l13
  %t169 = load double, double* %l14
  %t170 = load double, double* %l15
  %t171 = load double, double* %l16
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t174 = load double, double* %l19
  %t175 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t176 = load i8*, i8** %l23
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t178 = load double, double* %l25
  %t179 = load i1, i1* %l29
  %t180 = load i1, i1* %l30
  %t181 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  br label %loop.header8
loop.header8:
  %t225 = phi { i8**, i64 }* [ %t156, %entry ], [ %t213, %loop.latch10 ]
  %t226 = phi { i8**, i64 }* [ %t155, %entry ], [ %t214, %loop.latch10 ]
  %t227 = phi double [ %t159, %entry ], [ %t215, %loop.latch10 ]
  %t228 = phi { %StringConstant*, i64 }* [ %t167, %entry ], [ %t216, %loop.latch10 ]
  %t229 = phi { %LifetimeRegionMetadata*, i64 }* [ %t164, %entry ], [ %t217, %loop.latch10 ]
  %t230 = phi { i8**, i64 }* [ %t157, %entry ], [ %t218, %loop.latch10 ]
  %t231 = phi { %LocalBinding*, i64 }* [ %t158, %entry ], [ %t219, %loop.latch10 ]
  %t232 = phi double [ %t160, %entry ], [ %t220, %loop.latch10 ]
  %t233 = phi double [ %t161, %entry ], [ %t221, %loop.latch10 ]
  %t234 = phi double [ %t165, %entry ], [ %t222, %loop.latch10 ]
  %t235 = phi { %LocalMutation*, i64 }* [ %t166, %entry ], [ %t223, %loop.latch10 ]
  %t236 = phi { %MatchArmMutations*, i64 }* [ %t181, %entry ], [ %t224, %loop.latch10 ]
  store { i8**, i64 }* %t225, { i8**, i64 }** %l1
  store { i8**, i64 }* %t226, { i8**, i64 }** %l0
  store double %t227, double* %l4
  store { %StringConstant*, i64 }* %t228, { %StringConstant*, i64 }** %l12
  store { %LifetimeRegionMetadata*, i64 }* %t229, { %LifetimeRegionMetadata*, i64 }** %l9
  store { i8**, i64 }* %t230, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %t231, { %LocalBinding*, i64 }** %l3
  store double %t232, double* %l5
  store double %t233, double* %l6
  store double %t234, double* %l10
  store { %LocalMutation*, i64 }* %t235, { %LocalMutation*, i64 }** %l11
  store { %MatchArmMutations*, i64 }* %t236, { %MatchArmMutations*, i64 }** %l31
  br label %loop.body9
loop.body9:
  %t182 = load double, double* %l19
  %t183 = load double, double* %l13
  store double 0.0, double* %l32
  %t184 = load i8*, i8** %l23
  store i8* %t184, i8** %l33
  %t185 = load double, double* %l19
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  %t188 = load double, double* %l13
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l34
  %t190 = load double, double* %l34
  %t191 = load double, double* %l34
  %t192 = load double, double* %l34
  %t193 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t194 = load double, double* %l34
  %t195 = load double, double* %l34
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t197 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store { %LocalBinding*, i64 }* %t197, { %LocalBinding*, i64 }** %l35
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store { i8**, i64 }* %t198, { i8**, i64 }** %l36
  %t199 = load double, double* %l6
  store double %t199, double* %l37
  %t200 = load double, double* %l34
  store double 0.0, double* %l38
  %t201 = load double, double* %l38
  %t202 = load double, double* %l38
  %t203 = load double, double* %l38
  %t204 = load double, double* %l38
  %t205 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l35
  store { %LocalBinding*, i64 }* %t205, { %LocalBinding*, i64 }** %l3
  %t206 = load double, double* %l38
  %t207 = load double, double* %l38
  %t208 = load double, double* %l38
  %t209 = load double, double* %l38
  %t210 = load double, double* %l38
  %t211 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t212 = load double, double* %l38
  br label %loop.latch10
loop.latch10:
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load double, double* %l4
  %t216 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t217 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t219 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t220 = load double, double* %l5
  %t221 = load double, double* %l6
  %t222 = load double, double* %l10
  %t223 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t224 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  br label %loop.header8
afterloop11:
  store double 0.0, double* %l39
  ret %BlockLoweringResult zeroinitializer
}

define %MatchCaseCondition @lower_match_case_condition(i8* %function_name, %LLVMOperand %subject_operand, %MatchCaseStructure %case, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca { %MatchFieldBinding*, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca { %StringConstant*, i64 }*
  %l8 = alloca i1
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  store double 0.0, double* %l3
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %MatchFieldBinding*, i64 }* null, { %MatchFieldBinding*, i64 }** %l4
  store double 0.0, double* %l5
  store double 0.0, double* %l6
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l7
  %t15 = extractvalue %MatchCaseStructure %case, 1
  store i1 0, i1* %l8
  %t16 = extractvalue %MatchCaseStructure %case, 4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t22 = load double, double* %l5
  %t23 = load double, double* %l6
  %t24 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t25 = load i1, i1* %l8
  br i1 %t16, label %then0, label %merge1
then0:
  %t26 = extractvalue %MatchCaseStructure %case, 1
  br label %merge1
merge1:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = insertvalue %MatchCaseCondition undef, { i8**, i64 }* %t27, 0
  %t29 = load double, double* %l2
  %t30 = insertvalue %MatchCaseCondition %t28, double %t29, 1
  %t31 = load double, double* %l3
  %t32 = insertvalue %MatchCaseCondition %t30, i8* null, 2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = insertvalue %MatchCaseCondition %t32, { i8**, i64 }* %t33, 3
  %t35 = load i1, i1* %l8
  %t36 = insertvalue %MatchCaseCondition %t34, i1 %t35, 4
  %t37 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t38 = insertvalue %MatchCaseCondition %t36, { i8**, i64 }* null, 5
  %t39 = load double, double* %l5
  %t40 = insertvalue %MatchCaseCondition %t38, i8* null, 6
  %t41 = load double, double* %l6
  %t42 = insertvalue %MatchCaseCondition %t40, i8* null, 7
  %t43 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t44 = insertvalue %MatchCaseCondition %t42, { i8**, i64 }* null, 8
  ret %MatchCaseCondition %t44
}

define %BlockLabelResult @allocate_block_label(i8* %prefix, double %counter) {
entry:
  ret %BlockLabelResult zeroinitializer
}

define %ConditionConversion @lower_condition_to_i1(i8* %function_name, i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %ExpressionResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t0 = call %ExpressionResult @lower_expression(i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  store %ExpressionResult %t0, %ExpressionResult* %l1
  %t1 = load %ExpressionResult, %ExpressionResult* %l1
  %t2 = extractvalue %ExpressionResult %t1, 3
  %t3 = call double @diagnosticsconcat({ i8**, i64 }* %t2)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t4 = load %ExpressionResult, %ExpressionResult* %l1
  %t5 = extractvalue %ExpressionResult %t4, 0
  store { i8**, i64 }* %t5, { i8**, i64 }** %l2
  %t6 = load %ExpressionResult, %ExpressionResult* %l1
  %t7 = extractvalue %ExpressionResult %t6, 1
  store double %t7, double* %l3
  %t8 = load %ExpressionResult, %ExpressionResult* %l1
  %t9 = extractvalue %ExpressionResult %t8, 4
  store { i8**, i64 }* %t9, { i8**, i64 }** %l4
  %t10 = load %ExpressionResult, %ExpressionResult* %l1
  %t11 = extractvalue %ExpressionResult %t10, 2
  %t12 = load %ExpressionResult, %ExpressionResult* %l1
  %t13 = extractvalue %ExpressionResult %t12, 2
  store i8* %t13, i8** %l5
  %t14 = load i8*, i8** %l5
  %t15 = load i8*, i8** %l5
  %t16 = load i8*, i8** %l5
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s18 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l5
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t21 = insertvalue %ConditionConversion undef, { i8**, i64 }* %t20, 0
  %t22 = load double, double* %l3
  %t23 = insertvalue %ConditionConversion %t21, double %t22, 1
  %t24 = insertvalue %ConditionConversion %t23, i8* null, 2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = insertvalue %ConditionConversion %t24, { i8**, i64 }* %t25, 3
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t28 = insertvalue %ConditionConversion %t26, { i8**, i64 }* %t27, 4
  ret %ConditionConversion %t28
}

define { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }* %mutations) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  store i1 0, i1* %l3
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l4
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  %t13 = load i1, i1* %l3
  %t14 = load double, double* %l4
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t15 = load double, double* %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t17
}

define i8* @join_strings({ i8**, i64 }* %strings, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t15 = phi i8* [ %t2, %entry ], [ %t14, %loop.latch2 ]
  store i8* %t15, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp ogt double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %t10, %separator
  store i8* %t11, i8** %l0
  br label %merge5
merge5:
  %t12 = phi i8* [ %t11, %then4 ], [ %t8, %loop.body1 ]
  store i8* %t12, i8** %l0
  %t13 = load i8*, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t16 = load i8*, i8** %l0
  ret i8* %t16
}

define %PhiStoreEntry @build_phi_and_store(%LocalBinding %local, i8* %llvm_type, { i8**, i64 }* %phi_inputs, double %temp_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @format_temp_name(double %temp_index)
  store i8* %t0, i8** %l0
  store double 0.0, double* %l1
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %llvm_type
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %s10 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %s10, %llvm_type
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = add i8* %t11, %s12
  %t14 = load i8*, i8** %l0
  %t15 = add i8* %t13, %t14
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.16, i32 0, i32 0
  %t17 = add i8* %t15, %s16
  %t18 = add i8* %t17, %llvm_type
  store double 0.0, double* %l3
  %t19 = load double, double* %l2
  %t20 = insertvalue %PhiStoreEntry undef, i8* null, 0
  %t21 = load double, double* %l3
  %t22 = insertvalue %PhiStoreEntry %t20, i8* null, 1
  ret %PhiStoreEntry %t22
}

define %PhiMergeResult @emit_phi_merges_for_straight_if({ %LocalMutation*, i64 }* %mutations, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %preloaded_values, i8* %base_label, i8* %then_label, { i8**, i64 }* %lines, double %temp_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  store double 0.0, double* %l4
  %t16 = load double, double* %l4
  store double 0.0, double* %l5
  %t17 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l6
  %t18 = load double, double* %l6
  %t19 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t20 = load double, double* %l2
  %t21 = insertvalue %PhiMergeResult %t19, double %t20, 1
  ret %PhiMergeResult %t21
}

define %PhiMergeResult @emit_phi_merges_for_if_else({ %LocalMutation*, i64 }* %then_mutations, { %LocalMutation*, i64 }* %else_mutations, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %preloaded_values, i8* %then_label, i8* %else_label, i1 %then_terminated, i1 %else_terminated, { i8**, i64 }* %lines, double %temp_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t10 = call { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }* %then_mutations)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l3
  %t11 = call { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }* %else_mutations)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l4
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l3
  store { i8**, i64 }* %t12, { i8**, i64 }** %l5
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l6
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t20 = load double, double* %l6
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l6
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l4
  store double 0.0, double* %l7
  store i1 0, i1* %l8
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l9
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load double, double* %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t30 = load double, double* %l6
  %t31 = load double, double* %l7
  %t32 = load i1, i1* %l8
  %t33 = load double, double* %l9
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t34 = load double, double* %l9
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l10
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load double, double* %l6
  %t44 = load double, double* %l10
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t45 = load double, double* %l10
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l5
  store double 0.0, double* %l11
  %t47 = load double, double* %l11
  %t48 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* null)
  store double %t48, double* %l12
  %t49 = load double, double* %l12
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  store double 0.0, double* %l13
  %t50 = load double, double* %l13
  %t51 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t52 = load double, double* %l2
  %t53 = insertvalue %PhiMergeResult %t51, double %t52, 1
  ret %PhiMergeResult %t53
}

define %PhiMergeResult @emit_phi_merges_for_match({ %MatchArmMutations*, i64 }* %arm_mutations_list, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %preloaded_values, { i8**, i64 }* %lines, double %temp_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i1
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load double, double* %l4
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l4
  store double 0.0, double* %l5
  %t22 = load double, double* %l5
  store double 0.0, double* %l6
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l7
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load double, double* %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load double, double* %l4
  %t29 = load double, double* %l5
  %t30 = load double, double* %l6
  %t31 = load double, double* %l7
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t32 = load double, double* %l7
  %t33 = load double, double* %l6
  store double 0.0, double* %l8
  store i1 0, i1* %l9
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l10
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = load double, double* %l2
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t39 = load double, double* %l4
  %t40 = load double, double* %l5
  %t41 = load double, double* %l6
  %t42 = load double, double* %l7
  %t43 = load double, double* %l8
  %t44 = load i1, i1* %l9
  %t45 = load double, double* %l10
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t46 = load double, double* %l10
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l11
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load double, double* %l2
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t53 = load double, double* %l4
  %t54 = load double, double* %l11
  br label %loop.header12
loop.header12:
  br label %loop.body13
loop.body13:
  %t55 = load double, double* %l11
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l3
  store double 0.0, double* %l12
  %t57 = load double, double* %l12
  %t58 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* null)
  store double %t58, double* %l13
  %t59 = load double, double* %l13
  br label %loop.latch14
loop.latch14:
  br label %loop.header12
afterloop15:
  store double 0.0, double* %l14
  %t60 = load double, double* %l14
  %t61 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t62 = load double, double* %l2
  %t63 = insertvalue %PhiMergeResult %t61, double %t62, 1
  ret %PhiMergeResult %t63
}

define %BlockLoweringResult @lower_if_instruction(double %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, double %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %LocalBinding*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca { %ParameterBinding*, i64 }*
  %l8 = alloca { %ParameterBinding*, i64 }*
  %l9 = alloca { %ParameterBinding*, i64 }*
  %l10 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l11 = alloca double
  %l12 = alloca { %LocalMutation*, i64 }*
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca { %StringConstant*, i64 }*
  %l16 = alloca %BlockLabelResult
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca %BlockLabelResult
  %l20 = alloca i8*
  %l21 = alloca i8*
  %l22 = alloca { i8**, i64 }*
  %l23 = alloca double
  %l24 = alloca double
  %l25 = alloca i8*
  %l26 = alloca double
  %l27 = alloca { %LocalBinding*, i64 }*
  %l28 = alloca { i8**, i64 }*
  %l29 = alloca double
  %l30 = alloca double
  %l31 = alloca double
  %l32 = alloca i8*
  %l33 = alloca double
  %l34 = alloca double
  %l35 = alloca double
  %l36 = alloca i1
  %l37 = alloca { %LocalMutation*, i64 }*
  %l38 = alloca i1
  %l39 = alloca { %ParameterBinding*, i64 }*
  store { i8**, i64 }* %lines, { i8**, i64 }** %l0
  store { i8**, i64 }* %allocas, { i8**, i64 }** %l1
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l2
  store double %temp_index, double* %l3
  store double %block_counter, double* %l4
  store double %next_local_id, double* %l5
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l7
  %t5 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store { %ParameterBinding*, i64 }* %t5, { %ParameterBinding*, i64 }** %l8
  %t6 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store { %ParameterBinding*, i64 }* %t6, { %ParameterBinding*, i64 }** %l9
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l10
  store double %next_region_id, double* %l11
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l12
  store double 0.0, double* %l13
  %t17 = load double, double* %l13
  store double 0.0, double* %l14
  %t18 = load double, double* %l14
  %t19 = load double, double* %l14
  %t20 = load double, double* %l14
  %t21 = load double, double* %l14
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l15
  %t22 = load double, double* %l14
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %t24 = load double, double* %l4
  %t25 = call %BlockLabelResult @allocate_block_label(i8* %s23, double %t24)
  store %BlockLabelResult %t25, %BlockLabelResult* %l16
  %t26 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t27 = extractvalue %BlockLabelResult %t26, 0
  store i8* %t27, i8** %l17
  %t28 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t29 = extractvalue %BlockLabelResult %t28, 1
  store double %t29, double* %l4
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.30, i32 0, i32 0
  store i8* %s30, i8** %l18
  %t31 = load double, double* %l13
  %s32 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.32, i32 0, i32 0
  %t33 = load double, double* %l4
  %t34 = call %BlockLabelResult @allocate_block_label(i8* %s32, double %t33)
  store %BlockLabelResult %t34, %BlockLabelResult* %l19
  %t35 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t36 = extractvalue %BlockLabelResult %t35, 0
  store i8* %t36, i8** %l20
  %t37 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t38 = extractvalue %BlockLabelResult %t37, 1
  store double %t38, double* %l4
  %t39 = load i8*, i8** %l20
  store i8* %t39, i8** %l21
  %t40 = load double, double* %l13
  %t41 = alloca [0 x double]
  %t42 = getelementptr [0 x double], [0 x double]* %t41, i32 0, i32 0
  %t43 = alloca { double*, i64 }
  %t44 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 0
  store double* %t42, double** %t44
  %t45 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { i8**, i64 }* null, { i8**, i64 }** %l22
  %t46 = sitofp i64 0 to double
  store double %t46, double* %l23
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t50 = load double, double* %l3
  %t51 = load double, double* %l4
  %t52 = load double, double* %l5
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t54 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t55 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t56 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l9
  %t57 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l10
  %t58 = load double, double* %l11
  %t59 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l12
  %t60 = load double, double* %l13
  %t61 = load double, double* %l14
  %t62 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t63 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t64 = load i8*, i8** %l17
  %t65 = load i8*, i8** %l18
  %t66 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t67 = load i8*, i8** %l20
  %t68 = load i8*, i8** %l21
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t70 = load double, double* %l23
  br label %loop.header0
loop.header0:
  %t89 = phi { i8**, i64 }* [ %t47, %entry ], [ %t87, %loop.latch2 ]
  %t90 = phi { i8**, i64 }* [ %t69, %entry ], [ %t88, %loop.latch2 ]
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  store { i8**, i64 }* %t90, { i8**, i64 }** %l22
  br label %loop.body1
loop.body1:
  %t71 = load double, double* %l23
  %t72 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  store double 0.0, double* %l24
  %t73 = load double, double* %l3
  %t74 = call i8* @format_temp_name(double %t73)
  store i8* %t74, i8** %l25
  %s75 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.75, i32 0, i32 0
  %t76 = load i8*, i8** %l25
  %t77 = add i8* %s75, %t76
  %s78 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.78, i32 0, i32 0
  %t79 = add i8* %t77, %s78
  %t80 = load double, double* %l24
  store double 0.0, double* %l26
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load double, double* %l26
  %t83 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t81, i8* null)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t85 = load i8*, i8** %l25
  %t86 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t84, i8* %t85)
  store { i8**, i64 }* %t86, { i8**, i64 }** %l22
  br label %loop.latch2
loop.latch2:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l22
  br label %loop.header0
afterloop3:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s92 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.92, i32 0, i32 0
  %t93 = load double, double* %l14
  %t94 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  store { %LocalBinding*, i64 }* %t94, { %LocalBinding*, i64 }** %l27
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store { i8**, i64 }* %t95, { i8**, i64 }** %l28
  %t96 = load double, double* %l3
  store double %t96, double* %l29
  %t97 = load double, double* %l5
  store double %t97, double* %l30
  %t98 = load double, double* %l4
  store double %t98, double* %l31
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l17
  %s101 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.101, i32 0, i32 0
  %t102 = add i8* %t100, %s101
  %t103 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t99, i8* %t102)
  store { i8**, i64 }* %t103, { i8**, i64 }** %l0
  %t104 = load i8*, i8** %l17
  %t105 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t104)
  store i8* %t105, i8** %l32
  store double 0.0, double* %l33
  %t106 = load double, double* %l33
  %t107 = load double, double* %l33
  %t108 = load double, double* %l33
  %t109 = load double, double* %l33
  %t110 = load double, double* %l33
  %t111 = load double, double* %l33
  %t112 = load double, double* %l33
  %t113 = load double, double* %l33
  %t114 = load double, double* %l33
  %t115 = load double, double* %l33
  %t116 = load double, double* %l33
  store double 0.0, double* %l34
  %t117 = load double, double* %l34
  %t118 = call double @collected_mutationsconcat(double %t117)
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l12
  %t119 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t120 = load double, double* %l33
  %t121 = load double, double* %l33
  store double 0.0, double* %l35
  store i1 0, i1* %l36
  %t122 = alloca [0 x double]
  %t123 = getelementptr [0 x double], [0 x double]* %t122, i32 0, i32 0
  %t124 = alloca { double*, i64 }
  %t125 = getelementptr { double*, i64 }, { double*, i64 }* %t124, i32 0, i32 0
  store double* %t123, double** %t125
  %t126 = getelementptr { double*, i64 }, { double*, i64 }* %t124, i32 0, i32 1
  store i64 0, i64* %t126
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l37
  %t127 = load double, double* %l13
  store i1 0, i1* %l38
  %t128 = load double, double* %l13
  %t129 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  store { %LocalBinding*, i64 }* %t129, { %LocalBinding*, i64 }** %l2
  %t130 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store { %ParameterBinding*, i64 }* %t130, { %ParameterBinding*, i64 }** %l39
  %t131 = load double, double* %l13
  ret %BlockLoweringResult zeroinitializer
}

define %LetLoweringResult @lower_let_instruction(double %function, double %instruction, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %next_local_id, double %next_region_id, double %functions, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %LocalBinding*, i64 }*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l9 = alloca { %LifetimeReleaseEvent*, i64 }*
  %l10 = alloca double
  %l11 = alloca { %LocalMutation*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca { %StringConstant*, i64 }*
  %l18 = alloca double
  %l19 = alloca i8*
  %l20 = alloca i8*
  %l21 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store { i8**, i64 }* %allocas, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  store double %temp_index, double* %l4
  store double 0.0, double* %l5
  store double 0.0, double* %l6
  store double 0.0, double* %l7
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l8
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %LifetimeReleaseEvent*, i64 }* null, { %LifetimeReleaseEvent*, i64 }** %l9
  store double %next_region_id, double* %l10
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l11
  %t20 = load double, double* %l7
  %t21 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t22 = load double, double* %l7
  store double 0.0, double* %l12
  %t23 = load double, double* %l12
  %t24 = call double @diagnosticsconcat(double %t23)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double 0.0, double* %l13
  %s25 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.25, i32 0, i32 0
  store i8* %s25, i8** %l14
  %t26 = load double, double* %l13
  store double 0.0, double* %l15
  %t27 = load double, double* %l7
  %t28 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l16
  %t29 = load double, double* %l16
  %t30 = load double, double* %l16
  %t31 = load double, double* %l16
  %t32 = load double, double* %l5
  %t33 = load double, double* %l6
  %t34 = alloca [0 x double]
  %t35 = getelementptr [0 x double], [0 x double]* %t34, i32 0, i32 0
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t35, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l17
  %t39 = load i8*, i8** %l14
  %t40 = load i8*, i8** %l14
  store double 0.0, double* %l18
  %t41 = load double, double* %l18
  %t42 = call i8* @format_local_pointer_name(double %next_local_id)
  store i8* %t42, i8** %l19
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = load i8*, i8** %l19
  %t46 = add i8* %s44, %t45
  %s47 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.47, i32 0, i32 0
  %t48 = add i8* %t46, %s47
  %t49 = load i8*, i8** %l14
  %t50 = add i8* %t48, %t49
  %t51 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t43, i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l2
  %t52 = load i8*, i8** %l14
  %t53 = call i8* @default_return_literal(i8* %t52)
  store i8* %t53, i8** %l20
  %t54 = load double, double* %l15
  %t55 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l21
  %t56 = load double, double* %l21
  %t57 = alloca [1 x double]
  %t58 = getelementptr [1 x double], [1 x double]* %t57, i32 0, i32 0
  %t59 = getelementptr double, double* %t58, i64 0
  store double %t56, double* %t59
  %t60 = alloca { double*, i64 }
  %t61 = getelementptr { double*, i64 }, { double*, i64 }* %t60, i32 0, i32 0
  store double* %t58, double** %t61
  %t62 = getelementptr { double*, i64 }, { double*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = call double @mutationsconcat({ double*, i64 }* %t60)
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l11
  ret %LetLoweringResult zeroinitializer
}

define %ExpressionStatementResult @lower_expression_statement(i8* %function_name, double %instruction, i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %next_region_id, i8* %scope_id, double %scope_depth, double %functions, %TypeContext %context, i8* %current_label) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca { %LocalBinding*, i64 }*
  %l5 = alloca { %ParameterBinding*, i64 }*
  %l6 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l7 = alloca { %LifetimeReleaseEvent*, i64 }*
  %l8 = alloca double
  %l9 = alloca { %LocalMutation*, i64 }*
  %l10 = alloca { %StringConstant*, i64 }*
  %l11 = alloca %AssignmentParseResult
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca %ExpressionResult
  %l16 = alloca { i8**, i64 }*
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = call { i8**, i64 }* @detect_suspension_conflicts(double 0.0, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, double %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l1
  store { i8**, i64 }* %lines, { i8**, i64 }** %l2
  store double %temp_index, double* %l3
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l4
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l5
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l6
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %LifetimeReleaseEvent*, i64 }* null, { %LifetimeReleaseEvent*, i64 }** %l7
  store double %next_region_id, double* %l8
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l9
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l10
  %t22 = call %AssignmentParseResult @parse_assignment_expression(i8* %expression)
  store %AssignmentParseResult %t22, %AssignmentParseResult* %l11
  %t23 = load %AssignmentParseResult, %AssignmentParseResult* %l11
  %t24 = extractvalue %AssignmentParseResult %t23, 0
  %t25 = load double, double* %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load double, double* %l3
  %t29 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l4
  %t30 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l5
  %t31 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l6
  %t32 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l7
  %t33 = load double, double* %l8
  %t34 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l9
  %t35 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l10
  %t36 = load %AssignmentParseResult, %AssignmentParseResult* %l11
  br i1 %t24, label %then0, label %merge1
then0:
  %t37 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l4
  %t38 = load %AssignmentParseResult, %AssignmentParseResult* %l11
  %t39 = extractvalue %AssignmentParseResult %t38, 1
  %t40 = call double @find_local_binding({ %LocalBinding*, i64 }* %t37, i8* %t39)
  store double %t40, double* %l12
  %t41 = load double, double* %l12
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = insertvalue %ExpressionStatementResult undef, { i8**, i64 }* %t42, 0
  %t44 = load double, double* %l3
  %t45 = insertvalue %ExpressionStatementResult %t43, double %t44, 1
  %t46 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l4
  %t47 = insertvalue %ExpressionStatementResult %t45, { i8**, i64 }* null, 2
  %t48 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l5
  %t49 = insertvalue %ExpressionStatementResult %t47, { i8**, i64 }* null, 3
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = insertvalue %ExpressionStatementResult %t49, { i8**, i64 }* %t50, 4
  %t52 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l6
  %t53 = insertvalue %ExpressionStatementResult %t51, { i8**, i64 }* null, 5
  %t54 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l7
  %t55 = insertvalue %ExpressionStatementResult %t53, { i8**, i64 }* null, 6
  %t56 = load double, double* %l8
  %t57 = insertvalue %ExpressionStatementResult %t55, double %t56, 7
  %t58 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l9
  %t59 = insertvalue %ExpressionStatementResult %t57, { i8**, i64 }* null, 8
  %t60 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l10
  %t61 = insertvalue %ExpressionStatementResult %t59, { i8**, i64 }* null, 9
  ret %ExpressionStatementResult %t61
merge1:
  %t62 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l4
  %t63 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l5
  store double 0.0, double* %l13
  %t64 = load double, double* %l13
  %t65 = load double, double* %l13
  store double 0.0, double* %l14
  %t66 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l5
  %t67 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l4
  %t68 = load double, double* %l3
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t70 = call %ExpressionResult @lower_expression(i8* %expression, { %ParameterBinding*, i64 }* %t66, { %LocalBinding*, i64 }* %t67, double %t68, { i8**, i64 }* %t69, double %functions, %TypeContext %context)
  store %ExpressionResult %t70, %ExpressionResult* %l15
  %t71 = load %ExpressionResult, %ExpressionResult* %l15
  %t72 = extractvalue %ExpressionResult %t71, 3
  %t73 = call double @diagnosticsconcat({ i8**, i64 }* %t72)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t74 = load %ExpressionResult, %ExpressionResult* %l15
  %t75 = extractvalue %ExpressionResult %t74, 4
  store { i8**, i64 }* %t75, { i8**, i64 }** %l16
  %t76 = load %ExpressionResult, %ExpressionResult* %l15
  %t77 = extractvalue %ExpressionResult %t76, 0
  store { i8**, i64 }* %t77, { i8**, i64 }** %l2
  %t78 = load %ExpressionResult, %ExpressionResult* %l15
  %t79 = extractvalue %ExpressionResult %t78, 1
  store double %t79, double* %l3
  %t80 = load double, double* %l14
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t82 = insertvalue %ExpressionStatementResult undef, { i8**, i64 }* %t81, 0
  %t83 = load double, double* %l3
  %t84 = insertvalue %ExpressionStatementResult %t82, double %t83, 1
  %t85 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l4
  %t86 = insertvalue %ExpressionStatementResult %t84, { i8**, i64 }* null, 2
  %t87 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l5
  %t88 = insertvalue %ExpressionStatementResult %t86, { i8**, i64 }* null, 3
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = insertvalue %ExpressionStatementResult %t88, { i8**, i64 }* %t89, 4
  %t91 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l6
  %t92 = insertvalue %ExpressionStatementResult %t90, { i8**, i64 }* null, 5
  %t93 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l7
  %t94 = insertvalue %ExpressionStatementResult %t92, { i8**, i64 }* null, 6
  %t95 = load double, double* %l8
  %t96 = insertvalue %ExpressionStatementResult %t94, double %t95, 7
  %t97 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l9
  %t98 = insertvalue %ExpressionStatementResult %t96, { i8**, i64 }* null, 8
  %t99 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l10
  %t100 = insertvalue %ExpressionStatementResult %t98, { i8**, i64 }* null, 9
  ret %ExpressionStatementResult %t100
}

define %AssignmentParseResult @parse_assignment_expression(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t8 = load double, double* %l3
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = load double, double* %l3
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load double, double* %l1
  %t13 = sitofp i64 0 to double
  %t14 = fcmp ogt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  br i1 %t14, label %then4, label %merge5
then4:
  br label %loop.latch2
merge5:
  %t19 = load double, double* %l3
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t21 = insertvalue %AssignmentParseResult undef, i1 0, 0
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  %t23 = insertvalue %AssignmentParseResult %t21, i8* %s22, 1
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.24, i32 0, i32 0
  %t25 = insertvalue %AssignmentParseResult %t23, i8* %s24, 2
  ret %AssignmentParseResult %t25
}

define %InlineLetParseResult @parse_inline_let_expression(i8* %expression) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call i8* @trim_text(i8* %expression)
  store i8* %t5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = load i8*, i8** %l1
  %t8 = call double @substring(i8* %t7, i64 0, i64 4)
  store double %t8, double* %l2
  %t9 = load double, double* %l2
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l1
  store i8* null, i8** %l3
  store i1 0, i1* %l4
  %t13 = load i8*, i8** %l3
  %t14 = load i8*, i8** %l3
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l5
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l6
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load double, double* %l2
  %t20 = load i8*, i8** %l3
  %t21 = load i1, i1* %l4
  %t22 = load i8*, i8** %l5
  %t23 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t30 = phi i8* [ %t22, %entry ], [ %t29, %loop.latch2 ]
  store i8* %t30, i8** %l5
  br label %loop.body1
loop.body1:
  %t24 = load double, double* %l6
  %t25 = load i8*, i8** %l3
  store double 0.0, double* %l7
  %t26 = load double, double* %l7
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l7
  br label %loop.latch2
loop.latch2:
  %t29 = load i8*, i8** %l5
  br label %loop.header0
afterloop3:
  %t31 = load i8*, i8** %l5
  %t32 = call i8* @trim_text(i8* %t31)
  store i8* %t32, i8** %l5
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l3
  %t35 = load double, double* %l6
  %t36 = load i8*, i8** %l3
  store i8* null, i8** %l8
  %s37 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.37, i32 0, i32 0
  store i8* %s37, i8** %l9
  store double 0.0, double* %l10
  %t38 = load i8*, i8** %l8
  %t39 = load double, double* %l10
  %t40 = insertvalue %InlineLetParseResult undef, i1 1, 0
  %t41 = load i8*, i8** %l5
  %t42 = insertvalue %InlineLetParseResult %t40, i8* %t41, 1
  %t43 = load i1, i1* %l4
  %t44 = insertvalue %InlineLetParseResult %t42, i1 %t43, 2
  %t45 = load i8*, i8** %l9
  %t46 = insertvalue %InlineLetParseResult %t44, i8* %t45, 3
  %t47 = load double, double* %l10
  %t48 = insertvalue %InlineLetParseResult %t46, i8* null, 4
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = insertvalue %InlineLetParseResult %t48, { i8**, i64 }* %t49, 5
  ret %InlineLetParseResult %t50
}

define %ExpressionStatementResult @lower_return_instruction(double %function, double %instruction, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %next_region_id, i8* %scope_id, double %scope_depth, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l4 = alloca { %LifetimeReleaseEvent*, i64 }*
  %l5 = alloca double
  %l6 = alloca { %LocalBinding*, i64 }*
  %l7 = alloca { %ParameterBinding*, i64 }*
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca %CoercionResult
  %l15 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l3
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %LifetimeReleaseEvent*, i64 }* null, { %LifetimeReleaseEvent*, i64 }** %l4
  store double %next_region_id, double* %l5
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l6
  store { %ParameterBinding*, i64 }* %bindings, { %ParameterBinding*, i64 }** %l7
  %t15 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t16 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store double 0.0, double* %l8
  %t17 = load double, double* %l8
  %t18 = call double @diagnosticsconcat(double %t17)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t19 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t20 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store double 0.0, double* %l9
  %t21 = load double, double* %l9
  %t22 = load double, double* %l9
  store double 0.0, double* %l10
  %t23 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t24 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t25 = load double, double* %l2
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l11
  %t27 = load double, double* %l11
  %t28 = load double, double* %l11
  %t29 = load double, double* %l11
  %t30 = load double, double* %l11
  store double 0.0, double* %l12
  %t31 = load double, double* %l11
  %t32 = load double, double* %l11
  store double 0.0, double* %l13
  %s33 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.33, i32 0, i32 0
  %t34 = load double, double* %l13
  %t35 = load double, double* %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %llvm_return, double %t35, { i8**, i64 }* %t36)
  store %CoercionResult %t37, %CoercionResult* %l14
  %t38 = load %CoercionResult, %CoercionResult* %l14
  %t39 = extractvalue %CoercionResult %t38, 3
  %t40 = call double @diagnosticsconcat({ i8**, i64 }* %t39)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t41 = load %CoercionResult, %CoercionResult* %l14
  %t42 = extractvalue %CoercionResult %t41, 0
  store { i8**, i64 }* %t42, { i8**, i64 }** %l1
  %t43 = load %CoercionResult, %CoercionResult* %l14
  %t44 = extractvalue %CoercionResult %t43, 1
  store double %t44, double* %l2
  %t45 = load %CoercionResult, %CoercionResult* %l14
  %t46 = extractvalue %CoercionResult %t45, 2
  %t47 = load %CoercionResult, %CoercionResult* %l14
  %t48 = extractvalue %CoercionResult %t47, 2
  store i8* %t48, i8** %l15
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s50 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.50, i32 0, i32 0
  %t51 = load i8*, i8** %l15
  %t52 = load double, double* %l10
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = insertvalue %ExpressionStatementResult undef, { i8**, i64 }* %t53, 0
  %t55 = load double, double* %l2
  %t56 = insertvalue %ExpressionStatementResult %t54, double %t55, 1
  %t57 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t58 = insertvalue %ExpressionStatementResult %t56, { i8**, i64 }* null, 2
  %t59 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t60 = insertvalue %ExpressionStatementResult %t58, { i8**, i64 }* null, 3
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = insertvalue %ExpressionStatementResult %t60, { i8**, i64 }* %t61, 4
  %t63 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l3
  %t64 = insertvalue %ExpressionStatementResult %t62, { i8**, i64 }* null, 5
  %t65 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l4
  %t66 = insertvalue %ExpressionStatementResult %t64, { i8**, i64 }* null, 6
  %t67 = load double, double* %l5
  %t68 = insertvalue %ExpressionStatementResult %t66, double %t67, 7
  %t69 = alloca [0 x double]
  %t70 = getelementptr [0 x double], [0 x double]* %t69, i32 0, i32 0
  %t71 = alloca { double*, i64 }
  %t72 = getelementptr { double*, i64 }, { double*, i64 }* %t71, i32 0, i32 0
  store double* %t70, double** %t72
  %t73 = getelementptr { double*, i64 }, { double*, i64 }* %t71, i32 0, i32 1
  store i64 0, i64* %t73
  %t74 = insertvalue %ExpressionStatementResult %t68, { i8**, i64 }* null, 8
  %t75 = load double, double* %l12
  %t76 = insertvalue %ExpressionStatementResult %t74, { i8**, i64 }* null, 9
  ret %ExpressionStatementResult %t76
}

define %ParameterPreparation @prepare_parameters(double %function, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %ParameterBinding*, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l1
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t19 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t33 = phi { i8**, i64 }* [ %t16, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi { %ParameterBinding*, i64 }* [ %t17, %entry ], [ %t32, %loop.latch2 ]
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  store { %ParameterBinding*, i64 }* %t34, { %ParameterBinding*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l3
  store double 0.0, double* %l4
  %t21 = load double, double* %l4
  store double 0.0, double* %l5
  %t22 = load double, double* %l5
  %t23 = load double, double* %l4
  %t24 = load double, double* %l4
  %t25 = load double, double* %l4
  store double 0.0, double* %l6
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = load double, double* %l6
  store double 0.0, double* %l7
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l5
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = insertvalue %ParameterPreparation undef, { i8**, i64 }* %t35, 0
  %t37 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l1
  %t38 = insertvalue %ParameterPreparation %t36, { i8**, i64 }* null, 1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = insertvalue %ParameterPreparation %t38, { i8**, i64 }* %t39, 2
  ret %ParameterPreparation %t40
}

define i8* @map_struct_type_annotation(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca double
  %t0 = call double @find_struct_info_by_name(%TypeContext %context, i8* %annotation)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
}

define i8* @map_enum_type_annotation(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = extractvalue %TypeContext %context, 1
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
}

define i8* @map_interface_type_annotation(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call double @find_interface_info_by_name(%TypeContext %context, i8* %t2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
}

define i8* @map_primitive_type(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @map_struct_type_annotation(%TypeContext %context, i8* %annotation)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @map_enum_type_annotation(%TypeContext %context, i8* %annotation)
  store i8* %t4, i8** %l1
  %t5 = load i8*, i8** %l1
  %t6 = call i8* @map_interface_type_annotation(%TypeContext %context, i8* %annotation)
  store i8* %t6, i8** %l2
  %t7 = load i8*, i8** %l2
  %s8 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.8, i32 0, i32 0
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
}

define i8* @map_reference_inner_type(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @map_reference_type(%TypeContext %context, i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @map_array_pointer_type(%TypeContext %context, i8* %t5)
  store i8* %t6, i8** %l2
  %t7 = load i8*, i8** %l2
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @map_primitive_type(%TypeContext %context, i8* %t8)
  ret i8* %t9
}

define i8* @map_reference_type(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @starts_with(i8* %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  ret i8* %s7
merge1:
  %t8 = load i8*, i8** %l0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %t10 = call i1 @starts_with(i8* %t8, i8* %s9)
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.12, i32 0, i32 0
  ret i8* %s12
merge3:
  %t13 = load i8*, i8** %l0
  %t14 = load i8*, i8** %l0
  store i8* null, i8** %l1
  %t15 = load i8*, i8** %l1
  %s16 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.16, i32 0, i32 0
  %t17 = call i1 @starts_with(i8* %t15, i8* %s16)
  %t18 = load i8*, i8** %l0
  %t19 = load i8*, i8** %l1
  br i1 %t17, label %then4, label %merge5
then4:
  %t20 = load i8*, i8** %l1
  %t21 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t22 = load double, double* %l2
  %t23 = call i8* @trim_text(i8* null)
  store i8* %t23, i8** %l1
  br label %merge5
merge5:
  %t24 = phi i8* [ %t23, %then4 ], [ %t19, %entry ]
  store i8* %t24, i8** %l1
  %t25 = load i8*, i8** %l1
  %t26 = load i8*, i8** %l1
  %t27 = call i8* @map_reference_inner_type(%TypeContext %context, i8* %t26)
  store i8* %t27, i8** %l3
  %t28 = load i8*, i8** %l3
  %t29 = load i8*, i8** %l3
  ret i8* null
}

define i8* @map_array_pointer_type(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %s6 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.6, i32 0, i32 0
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call i8* @map_primitive_type(%TypeContext %context, i8* null)
  store i8* %t10, i8** %l3
  %t11 = load i8*, i8** %l3
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = load i8*, i8** %l3
  %t14 = add i8* %s12, %t13
  ret i8* null
}

define i8* @array_struct_type_for_element(i8* %element_type) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %s0, %element_type
  ret i8* null
}

define i8* @array_pointer_element_type(i8* %llvm_type) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %t0 = call i8* @trim_text(i8* %llvm_type)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  store double 0.0, double* %l3
  %t9 = load double, double* %l3
  %t10 = sitofp i64 0 to double
  %t11 = fcmp olt double %t9, %t10
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = load double, double* %l3
  br i1 %t11, label %then0, label %merge1
then0:
  %s16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.16, i32 0, i32 0
  ret i8* %s16
merge1:
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = call double @substring(double %t17, i64 0, double %t18)
  %t20 = call i8* @trim_text(i8* null)
  store i8* %t20, i8** %l4
  %t21 = load i8*, i8** %l4
  %t22 = load i8*, i8** %l4
  %t23 = load i8*, i8** %l4
  store double 0.0, double* %l5
  %t24 = load double, double* %l5
  %t25 = load double, double* %l5
  ret i8* null
}

define i8* @unwrap_move_wrapper(i8* %annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  ret i8* %t3
}

define i1 @contains_keyword_outside_strings(i8* %value, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  %t1 = load double, double* %l0
  %t2 = load i1, i1* %l1
  %t3 = load i1, i1* %l2
  %t4 = load i1, i1* %l3
  br label %loop.header0
loop.header0:
  %t42 = phi i1 [ %t4, %entry ], [ %t41, %loop.latch2 ]
  store i1 %t42, i1* %l3
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  store double 0.0, double* %l4
  %t6 = load i1, i1* %l1
  %t7 = load double, double* %l0
  %t8 = load i1, i1* %l1
  %t9 = load i1, i1* %l2
  %t10 = load i1, i1* %l3
  %t11 = load double, double* %l4
  br i1 %t6, label %then4, label %merge5
then4:
  %t12 = load i1, i1* %l3
  %t13 = load double, double* %l0
  %t14 = load i1, i1* %l1
  %t15 = load i1, i1* %l2
  %t16 = load i1, i1* %l3
  %t17 = load double, double* %l4
  br i1 %t12, label %then6, label %else7
then6:
  store i1 0, i1* %l3
  br label %merge8
else7:
  %t18 = load double, double* %l4
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  br label %merge8
merge8:
  %t20 = phi i1 [ 0, %then6 ], [ %t16, %else7 ]
  store i1 %t20, i1* %l3
  br label %loop.latch2
merge5:
  %t21 = load i1, i1* %l2
  %t22 = load double, double* %l0
  %t23 = load i1, i1* %l1
  %t24 = load i1, i1* %l2
  %t25 = load i1, i1* %l3
  %t26 = load double, double* %l4
  br i1 %t21, label %then9, label %merge10
then9:
  %t27 = load i1, i1* %l3
  %t28 = load double, double* %l0
  %t29 = load i1, i1* %l1
  %t30 = load i1, i1* %l2
  %t31 = load i1, i1* %l3
  %t32 = load double, double* %l4
  br i1 %t27, label %then11, label %else12
then11:
  store i1 0, i1* %l3
  br label %merge13
else12:
  %t33 = load double, double* %l4
  %s34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.34, i32 0, i32 0
  br label %merge13
merge13:
  %t35 = phi i1 [ 0, %then11 ], [ %t31, %else12 ]
  store i1 %t35, i1* %l3
  br label %loop.latch2
merge10:
  %t36 = load double, double* %l4
  %s37 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.37, i32 0, i32 0
  %t38 = load double, double* %l4
  %s39 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.39, i32 0, i32 0
  %t40 = load double, double* %l4
  br label %loop.latch2
loop.latch2:
  %t41 = load i1, i1* %l3
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i8* @find_suspension_keyword(i8* %expression) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i1 @contains_keyword_outside_strings(i8* %expression, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @contains_keyword_outside_strings(i8* %expression, i8* %s3)
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
}

define i1 @is_mutable_borrow_annotation(i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @unwrap_move_wrapper(i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = load i8*, i8** %l1
  %t6 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  %s9 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.9, i32 0, i32 0
  %t10 = call i1 @starts_with(i8* null, i8* %s9)
  %t11 = load i8*, i8** %l0
  %t12 = load i8*, i8** %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  ret i1 0
}

define { i8**, i64 }* @collect_suspension_conflicts(i8* %keyword, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, double %suspension_span) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l3
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l3
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t13 = load double, double* %l3
  store double 0.0, double* %l4
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t14
}

define i8* @normalise_borrow_base(i8* %raw_base) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %raw_base)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load i8*, i8** %l0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  ret i8* %t4
}

define { i8**, i64 }* @detect_suspension_conflicts(double %expression, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, double %suspension_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* null)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @find_suspension_keyword(i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = load i8*, i8** %l1
  %t6 = call { i8**, i64 }* @collect_suspension_conflicts(i8* %t5, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, double %suspension_span)
  ret { i8**, i64 }* %t6
}

define i8* @map_return_type(%TypeContext %context, i8* %return_type) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i8* @trim_text(i8* %return_type)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @unwrap_move_wrapper(i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = call i8* @map_reference_type(%TypeContext %context, i8* %t4)
  store i8* %t5, i8** %l2
  %t6 = load i8*, i8** %l2
  %t7 = load i8*, i8** %l1
  %t8 = call i8* @map_array_pointer_type(%TypeContext %context, i8* %t7)
  store i8* %t8, i8** %l3
  %t9 = load i8*, i8** %l3
  %t10 = load i8*, i8** %l1
  %t11 = call i8* @map_primitive_type(%TypeContext %context, i8* %t10)
  ret i8* %t11
}

define i8* @map_parameter_type(%TypeContext %context, i8* %parameter_type) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i8* @trim_text(i8* %parameter_type)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @unwrap_move_wrapper(i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = call i8* @map_reference_type(%TypeContext %context, i8* %t4)
  store i8* %t5, i8** %l2
  %t6 = load i8*, i8** %l2
  %t7 = load i8*, i8** %l1
  %t8 = call i8* @map_array_pointer_type(%TypeContext %context, i8* %t7)
  store i8* %t8, i8** %l3
  %t9 = load i8*, i8** %l3
  %t10 = load i8*, i8** %l1
  %t11 = call i8* @map_primitive_type(%TypeContext %context, i8* %t10)
  ret i8* %t11
}

define i8* @map_local_type(%TypeContext %context, i8* %type_annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @unwrap_move_wrapper(i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = call i8* @map_reference_type(%TypeContext %context, i8* %t4)
  store i8* %t5, i8** %l2
  %t6 = load i8*, i8** %l2
  %t7 = load i8*, i8** %l1
  %t8 = call i8* @map_array_pointer_type(%TypeContext %context, i8* %t7)
  store i8* %t8, i8** %l3
  %t9 = load i8*, i8** %l3
  %t10 = load i8*, i8** %l1
  %t11 = call i8* @map_primitive_type(%TypeContext %context, i8* %t10)
  ret i8* %t11
}

define { %ParameterBinding*, i64 }* @mark_parameter_consumed({ %ParameterBinding*, i64 }* %bindings, i8* %name) {
entry:
  %l0 = alloca { %ParameterBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  ret { %ParameterBinding*, i64 }* %t10
}

define { %LocalBinding*, i64 }* @mark_local_consumed({ %LocalBinding*, i64 }* %locals, i8* %name) {
entry:
  %l0 = alloca { %LocalBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t10
}

define { %LocalBinding*, i64 }* @reset_local_consumption({ %LocalBinding*, i64 }* %locals, i8* %name) {
entry:
  %l0 = alloca { %LocalBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t10
}

define { %LocalBinding*, i64 }* @update_local_ownership({ %LocalBinding*, i64 }* %locals, i8* %name, double %ownership) {
entry:
  %l0 = alloca { %LocalBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t10
}

define %ExpressionResult @lower_expression(i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca %BorrowParseResult
  %l4 = alloca %OperatorMatch
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %EnumLiteralParse
  %l9 = alloca %StructLiteralParse
  %l10 = alloca %ExpressionResult
  %l11 = alloca double
  %l12 = alloca %MemberAccessParse
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca i8*
  %l16 = alloca i8*
  %l17 = alloca %LLVMOperand
  %l18 = alloca %LLVMOperand
  %l19 = alloca i8*
  %l20 = alloca %LLVMOperand
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = call i8* @strip_enclosing_parentheses(i8* %t7)
  store i8* %t8, i8** %l2
  %t9 = load i8*, i8** %l2
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l2
  %t12 = call %BorrowParseResult @parse_borrow_expression(i8* %t11)
  store %BorrowParseResult %t12, %BorrowParseResult* %l3
  %t13 = load i8*, i8** %l2
  %t14 = call %OperatorMatch @find_comparison_operator(i8* %t13)
  store %OperatorMatch %t14, %OperatorMatch* %l4
  %t15 = load %OperatorMatch, %OperatorMatch* %l4
  %t16 = extractvalue %OperatorMatch %t15, 2
  %t17 = load i8*, i8** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load i8*, i8** %l2
  %t20 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t21 = load %OperatorMatch, %OperatorMatch* %l4
  br i1 %t16, label %then0, label %merge1
then0:
  %t22 = load i8*, i8** %l2
  %t23 = load %OperatorMatch, %OperatorMatch* %l4
  %t24 = call %ExpressionResult @lower_comparison_operation(i8* %t22, %OperatorMatch %t23, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  ret %ExpressionResult %t24
merge1:
  %t25 = load i8*, i8** %l2
  store double 0.0, double* %l5
  %t26 = load double, double* %l5
  %t27 = load i8*, i8** %l2
  store double 0.0, double* %l6
  %t28 = load double, double* %l6
  %t29 = load i8*, i8** %l2
  %t30 = call double @find_call_site(i8* %t29)
  store double %t30, double* %l7
  %t31 = load double, double* %l7
  %t32 = load i8*, i8** %l2
  %t33 = load i8*, i8** %l2
  %t34 = call %EnumLiteralParse @parse_enum_literal(i8* %t33)
  store %EnumLiteralParse %t34, %EnumLiteralParse* %l8
  %t35 = load i8*, i8** %l2
  %t36 = call %StructLiteralParse @parse_struct_literal(i8* %t35)
  store %StructLiteralParse %t36, %StructLiteralParse* %l9
  %t37 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t38 = extractvalue %StructLiteralParse %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t43 = load %OperatorMatch, %OperatorMatch* %l4
  %t44 = load double, double* %l5
  %t45 = load double, double* %l6
  %t46 = load double, double* %l7
  %t47 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t48 = load %StructLiteralParse, %StructLiteralParse* %l9
  br i1 %t38, label %then2, label %merge3
then2:
  %t49 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t50 = call %ExpressionResult @lower_struct_literal(%StructLiteralParse %t49, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  store %ExpressionResult %t50, %ExpressionResult* %l10
  %t51 = load %ExpressionResult, %ExpressionResult* %l10
  %t52 = extractvalue %ExpressionResult %t51, 3
  %t53 = call double @diagnosticsconcat({ i8**, i64 }* %t52)
  store double %t53, double* %l11
  %t54 = load %ExpressionResult, %ExpressionResult* %l10
  %t55 = extractvalue %ExpressionResult %t54, 0
  %t56 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t55, 0
  %t57 = load %ExpressionResult, %ExpressionResult* %l10
  %t58 = extractvalue %ExpressionResult %t57, 1
  %t59 = insertvalue %ExpressionResult %t56, double %t58, 1
  %t60 = load %ExpressionResult, %ExpressionResult* %l10
  %t61 = extractvalue %ExpressionResult %t60, 2
  %t62 = insertvalue %ExpressionResult %t59, i8* %t61, 2
  %t63 = load double, double* %l11
  %t64 = insertvalue %ExpressionResult %t62, { i8**, i64 }* null, 3
  %t65 = load %ExpressionResult, %ExpressionResult* %l10
  %t66 = extractvalue %ExpressionResult %t65, 4
  %t67 = insertvalue %ExpressionResult %t64, { i8**, i64 }* %t66, 4
  ret %ExpressionResult %t67
merge3:
  %t68 = load i8*, i8** %l2
  %t69 = call %MemberAccessParse @parse_member_access(i8* %t68)
  store %MemberAccessParse %t69, %MemberAccessParse* %l12
  %t70 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t71 = extractvalue %MemberAccessParse %t70, 0
  %t72 = load i8*, i8** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load i8*, i8** %l2
  %t75 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t76 = load %OperatorMatch, %OperatorMatch* %l4
  %t77 = load double, double* %l5
  %t78 = load double, double* %l6
  %t79 = load double, double* %l7
  %t80 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t81 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t82 = load %MemberAccessParse, %MemberAccessParse* %l12
  br i1 %t71, label %then4, label %merge5
then4:
  %t83 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t84 = call %ExpressionResult @lower_member_access(%MemberAccessParse %t83, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  ret %ExpressionResult %t84
merge5:
  %t85 = load i8*, i8** %l2
  %t86 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %bindings, i8* %t85)
  store double %t86, double* %l13
  %t87 = load double, double* %l13
  %t88 = load i8*, i8** %l2
  %t89 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t88)
  store double %t89, double* %l14
  %t90 = load double, double* %l14
  %t91 = load i8*, i8** %l2
  %t92 = call i8* @trim_text(i8* %t91)
  store i8* %t92, i8** %l15
  %t93 = load i8*, i8** %l15
  %t94 = call i1 @is_string_literal(i8* %t93)
  %t95 = load i8*, i8** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t97 = load i8*, i8** %l2
  %t98 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t99 = load %OperatorMatch, %OperatorMatch* %l4
  %t100 = load double, double* %l5
  %t101 = load double, double* %l6
  %t102 = load double, double* %l7
  %t103 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t104 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t105 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t106 = load double, double* %l13
  %t107 = load double, double* %l14
  %t108 = load i8*, i8** %l15
  br i1 %t94, label %then6, label %merge7
then6:
  %t109 = load i8*, i8** %l15
  %t110 = call %ExpressionResult @lower_string_literal(i8* %t109, double %temp_index, { i8**, i64 }* %lines)
  ret %ExpressionResult %t110
merge7:
  %t111 = load i8*, i8** %l15
  %t112 = call i1 @is_boolean_literal(i8* %t111)
  %t113 = load i8*, i8** %l0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = load i8*, i8** %l2
  %t116 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t117 = load %OperatorMatch, %OperatorMatch* %l4
  %t118 = load double, double* %l5
  %t119 = load double, double* %l6
  %t120 = load double, double* %l7
  %t121 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t122 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t123 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t124 = load double, double* %l13
  %t125 = load double, double* %l14
  %t126 = load i8*, i8** %l15
  br i1 %t112, label %then8, label %merge9
then8:
  %s127 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.127, i32 0, i32 0
  store i8* %s127, i8** %l16
  %t128 = load i8*, i8** %l15
  %s129 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.129, i32 0, i32 0
  %t130 = call i1 @matches_case_insensitive(i8* %t128, i8* %s129)
  %t131 = load i8*, i8** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load i8*, i8** %l2
  %t134 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t135 = load %OperatorMatch, %OperatorMatch* %l4
  %t136 = load double, double* %l5
  %t137 = load double, double* %l6
  %t138 = load double, double* %l7
  %t139 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t140 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t141 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t142 = load double, double* %l13
  %t143 = load double, double* %l14
  %t144 = load i8*, i8** %l15
  %t145 = load i8*, i8** %l16
  br i1 %t130, label %then10, label %merge11
then10:
  %s146 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.146, i32 0, i32 0
  store i8* %s146, i8** %l16
  br label %merge11
merge11:
  %t147 = phi i8* [ %s146, %then10 ], [ %t145, %then8 ]
  store i8* %t147, i8** %l16
  %s148 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.148, i32 0, i32 0
  %t149 = insertvalue %LLVMOperand undef, i8* %s148, 0
  %t150 = load i8*, i8** %l16
  %t151 = insertvalue %LLVMOperand %t149, i8* %t150, 1
  store %LLVMOperand %t151, %LLVMOperand* %l17
  %t152 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t153 = insertvalue %ExpressionResult %t152, double %temp_index, 1
  %t154 = load %LLVMOperand, %LLVMOperand* %l17
  %t155 = insertvalue %ExpressionResult %t153, i8* null, 2
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = insertvalue %ExpressionResult %t155, { i8**, i64 }* %t156, 3
  %t158 = alloca [0 x double]
  %t159 = getelementptr [0 x double], [0 x double]* %t158, i32 0, i32 0
  %t160 = alloca { double*, i64 }
  %t161 = getelementptr { double*, i64 }, { double*, i64 }* %t160, i32 0, i32 0
  store double* %t159, double** %t161
  %t162 = getelementptr { double*, i64 }, { double*, i64 }* %t160, i32 0, i32 1
  store i64 0, i64* %t162
  %t163 = insertvalue %ExpressionResult %t157, { i8**, i64 }* null, 4
  ret %ExpressionResult %t163
merge9:
  %t164 = load i8*, i8** %l15
  %t165 = call i1 @is_integer_literal(i8* %t164)
  %t166 = load i8*, i8** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load i8*, i8** %l2
  %t169 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t170 = load %OperatorMatch, %OperatorMatch* %l4
  %t171 = load double, double* %l5
  %t172 = load double, double* %l6
  %t173 = load double, double* %l7
  %t174 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t175 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t176 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t177 = load double, double* %l13
  %t178 = load double, double* %l14
  %t179 = load i8*, i8** %l15
  br i1 %t165, label %then12, label %merge13
then12:
  %s180 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.180, i32 0, i32 0
  %t181 = insertvalue %LLVMOperand undef, i8* %s180, 0
  %t182 = load i8*, i8** %l15
  %t183 = insertvalue %LLVMOperand %t181, i8* %t182, 1
  store %LLVMOperand %t183, %LLVMOperand* %l18
  %t184 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t185 = insertvalue %ExpressionResult %t184, double %temp_index, 1
  %t186 = load %LLVMOperand, %LLVMOperand* %l18
  %t187 = insertvalue %ExpressionResult %t185, i8* null, 2
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t189 = insertvalue %ExpressionResult %t187, { i8**, i64 }* %t188, 3
  %t190 = alloca [0 x double]
  %t191 = getelementptr [0 x double], [0 x double]* %t190, i32 0, i32 0
  %t192 = alloca { double*, i64 }
  %t193 = getelementptr { double*, i64 }, { double*, i64 }* %t192, i32 0, i32 0
  store double* %t191, double** %t193
  %t194 = getelementptr { double*, i64 }, { double*, i64 }* %t192, i32 0, i32 1
  store i64 0, i64* %t194
  %t195 = insertvalue %ExpressionResult %t189, { i8**, i64 }* null, 4
  ret %ExpressionResult %t195
merge13:
  %t196 = load i8*, i8** %l15
  %t197 = call i1 @is_number_literal(i8* %t196)
  %t198 = load i8*, i8** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load i8*, i8** %l2
  %t201 = load %BorrowParseResult, %BorrowParseResult* %l3
  %t202 = load %OperatorMatch, %OperatorMatch* %l4
  %t203 = load double, double* %l5
  %t204 = load double, double* %l6
  %t205 = load double, double* %l7
  %t206 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t207 = load %StructLiteralParse, %StructLiteralParse* %l9
  %t208 = load %MemberAccessParse, %MemberAccessParse* %l12
  %t209 = load double, double* %l13
  %t210 = load double, double* %l14
  %t211 = load i8*, i8** %l15
  br i1 %t197, label %then14, label %merge15
then14:
  %t212 = load i8*, i8** %l15
  %t213 = call i8* @normalise_number_literal(i8* %t212)
  store i8* %t213, i8** %l19
  %s214 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.214, i32 0, i32 0
  %t215 = insertvalue %LLVMOperand undef, i8* %s214, 0
  %t216 = load i8*, i8** %l19
  %t217 = insertvalue %LLVMOperand %t215, i8* %t216, 1
  store %LLVMOperand %t217, %LLVMOperand* %l20
  %t218 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t219 = insertvalue %ExpressionResult %t218, double %temp_index, 1
  %t220 = load %LLVMOperand, %LLVMOperand* %l20
  %t221 = insertvalue %ExpressionResult %t219, i8* null, 2
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = insertvalue %ExpressionResult %t221, { i8**, i64 }* %t222, 3
  %t224 = alloca [0 x double]
  %t225 = getelementptr [0 x double], [0 x double]* %t224, i32 0, i32 0
  %t226 = alloca { double*, i64 }
  %t227 = getelementptr { double*, i64 }, { double*, i64 }* %t226, i32 0, i32 0
  store double* %t225, double** %t227
  %t228 = getelementptr { double*, i64 }, { double*, i64 }* %t226, i32 0, i32 1
  store i64 0, i64* %t228
  %t229 = insertvalue %ExpressionResult %t223, { i8**, i64 }* null, 4
  ret %ExpressionResult %t229
merge15:
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s231 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.231, i32 0, i32 0
  %t232 = load i8*, i8** %l15
  %t233 = add i8* %s231, %t232
  %s234 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.234, i32 0, i32 0
  %t235 = add i8* %t233, %s234
  %t236 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t230, i8* %t235)
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  %t237 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t238 = insertvalue %ExpressionResult %t237, double %temp_index, 1
  %t239 = insertvalue %ExpressionResult %t238, i8* null, 2
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t241 = insertvalue %ExpressionResult %t239, { i8**, i64 }* %t240, 3
  %t242 = alloca [0 x double]
  %t243 = getelementptr [0 x double], [0 x double]* %t242, i32 0, i32 0
  %t244 = alloca { double*, i64 }
  %t245 = getelementptr { double*, i64 }, { double*, i64 }* %t244, i32 0, i32 0
  store double* %t243, double** %t245
  %t246 = getelementptr { double*, i64 }, { double*, i64 }* %t244, i32 0, i32 1
  store i64 0, i64* %t246
  %t247 = insertvalue %ExpressionResult %t241, { i8**, i64 }* null, 4
  ret %ExpressionResult %t247
}

define %BorrowParseResult @parse_borrow_expression(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca %BorrowArgumentParse
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  %s8 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.8, i32 0, i32 0
  %t9 = call i1 @starts_with(i8* %t7, i8* %s8)
  %t10 = load i8*, i8** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t9, label %then0, label %merge1
then0:
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  store i8* null, i8** %l2
  %t14 = load i8*, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = call %BorrowArgumentParse @extract_borrow_argument(i8* %t15)
  store %BorrowArgumentParse %t16, %BorrowArgumentParse* %l3
  %t17 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t18 = extractvalue %BorrowArgumentParse %t17, 2
  %t19 = call double @diagnosticsconcat({ i8**, i64 }* %t18)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t20 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t21 = extractvalue %BorrowArgumentParse %t20, 1
  %t22 = insertvalue %BorrowParseResult undef, i1 1, 0
  %t23 = insertvalue %BorrowParseResult %t22, i1 1, 1
  %t24 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t25 = extractvalue %BorrowArgumentParse %t24, 1
  %t26 = insertvalue %BorrowParseResult %t23, i8* %t25, 2
  %t27 = insertvalue %BorrowParseResult %t26, i1 0, 3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t29 = insertvalue %BorrowParseResult %t27, { i8**, i64 }* %t28, 4
  ret %BorrowParseResult %t29
merge1:
  %t30 = load i8*, i8** %l0
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = call double @starts_with(i8* %t30, i8* %s31)
  %t33 = fcmp one double %t32, 0.0
  %t34 = load i8*, i8** %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t33, label %then2, label %merge3
then2:
  %t36 = insertvalue %BorrowParseResult undef, i1 0, 0
  %t37 = insertvalue %BorrowParseResult %t36, i1 0, 1
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.38, i32 0, i32 0
  %t39 = insertvalue %BorrowParseResult %t37, i8* %s38, 2
  %t40 = insertvalue %BorrowParseResult %t39, i1 0, 3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = insertvalue %BorrowParseResult %t40, { i8**, i64 }* %t41, 4
  ret %BorrowParseResult %t42
merge3:
  %t43 = load i8*, i8** %l0
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call i1 @starts_with(i8* %t43, i8* %s44)
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t45, label %then4, label %merge5
then4:
  %t48 = insertvalue %BorrowParseResult undef, i1 0, 0
  %t49 = insertvalue %BorrowParseResult %t48, i1 0, 1
  %s50 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.50, i32 0, i32 0
  %t51 = insertvalue %BorrowParseResult %t49, i8* %s50, 2
  %t52 = insertvalue %BorrowParseResult %t51, i1 0, 3
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = insertvalue %BorrowParseResult %t52, { i8**, i64 }* %t53, 4
  ret %BorrowParseResult %t54
merge5:
  %t55 = load i8*, i8** %l0
  %t56 = load i8*, i8** %l0
  store i8* null, i8** %l5
  store i1 0, i1* %l6
  %t57 = load i8*, i8** %l5
  %s58 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.58, i32 0, i32 0
  %t59 = call i1 @starts_with(i8* %t57, i8* %s58)
  %t60 = load i8*, i8** %l0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load i8*, i8** %l5
  %t63 = load i1, i1* %l6
  br i1 %t59, label %then6, label %merge7
then6:
  store i1 1, i1* %l6
  %t64 = load i8*, i8** %l5
  %t65 = load i8*, i8** %l5
  store double 0.0, double* %l7
  %t66 = load double, double* %l7
  %t67 = call i8* @trim_text(i8* null)
  store i8* %t67, i8** %l5
  br label %merge7
merge7:
  %t68 = phi i1 [ 1, %then6 ], [ %t63, %entry ]
  %t69 = phi i8* [ %t67, %then6 ], [ %t62, %entry ]
  store i1 %t68, i1* %l6
  store i8* %t69, i8** %l5
  %t70 = load i8*, i8** %l5
  %t71 = insertvalue %BorrowParseResult undef, i1 1, 0
  %t72 = insertvalue %BorrowParseResult %t71, i1 1, 1
  %t73 = load i8*, i8** %l5
  %t74 = call i8* @trim_text(i8* %t73)
  %t75 = insertvalue %BorrowParseResult %t72, i8* %t74, 2
  %t76 = load i1, i1* %l6
  %t77 = insertvalue %BorrowParseResult %t75, i1 %t76, 3
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = insertvalue %BorrowParseResult %t77, { i8**, i64 }* %t78, 4
  ret %BorrowParseResult %t79
}

define %BorrowArgumentParse @extract_borrow_argument(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 -1 to double
  store double %t7, double* %l3
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l2
  store double 0.0, double* %l4
  %t13 = load double, double* %l4
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load double, double* %l4
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t17 = load double, double* %l3
  %t18 = sitofp i64 0 to double
  %t19 = fcmp olt double %t17, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  br i1 %t19, label %then4, label %merge5
then4:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s25 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.25, i32 0, i32 0
  %t26 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t24, i8* %s25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  %t27 = insertvalue %BorrowArgumentParse undef, i1 0, 0
  %s28 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.28, i32 0, i32 0
  %t29 = insertvalue %BorrowArgumentParse %t27, i8* %s28, 1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = insertvalue %BorrowArgumentParse %t29, { i8**, i64 }* %t30, 2
  ret %BorrowArgumentParse %t31
merge5:
  %t32 = load double, double* %l3
  %t33 = call double @substring(i8* %text, i64 1, double %t32)
  store double %t33, double* %l5
  %t34 = load double, double* %l3
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double 0.0, double* %l6
  %t37 = load double, double* %l6
  %t38 = insertvalue %BorrowArgumentParse undef, i1 1, 0
  %t39 = load double, double* %l5
  %t40 = call i8* @trim_text(i8* null)
  %t41 = insertvalue %BorrowArgumentParse %t38, i8* %t40, 1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = insertvalue %BorrowArgumentParse %t41, { i8**, i64 }* %t42, 2
  ret %BorrowArgumentParse %t43
}

define %OwnershipAnalysis @analyze_value_ownership(double %initializer, double %span, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %BorrowParseResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %t0 = call i8* @trim_text(i8* null)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call %BorrowParseResult @parse_borrow_expression(i8* %t2)
  store %BorrowParseResult %t3, %BorrowParseResult* %l1
  %t4 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t5 = extractvalue %BorrowParseResult %t4, 4
  store { i8**, i64 }* %t5, { i8**, i64 }** %l2
  %t6 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t7 = extractvalue %BorrowParseResult %t6, 0
  %t8 = load i8*, i8** %l0
  %t9 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t7, label %then0, label %merge1
then0:
  %t11 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t12 = extractvalue %BorrowParseResult %t11, 2
  %t13 = call i8* @resolve_borrow_base(i8* %t12, { %LocalBinding*, i64 }* %locals)
  store i8* %t13, i8** %l3
  %t14 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t15 = load double, double* %l4
  %t16 = insertvalue %OwnershipAnalysis undef, i8* null, 0
  %t17 = insertvalue %OwnershipAnalysis %t16, i8* null, 1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t19 = insertvalue %OwnershipAnalysis %t17, { i8**, i64 }* %t18, 2
  ret %OwnershipAnalysis %t19
merge1:
  %t20 = load i8*, i8** %l0
  %t21 = call i1 @is_simple_identifier(i8* %t20)
  %t22 = load i8*, i8** %l0
  %t23 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t21, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l0
  store i8* %t25, i8** %l5
  %t26 = load i8*, i8** %l5
  %t27 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t26)
  store double %t27, double* %l6
  %t28 = load double, double* %l6
  %t29 = load i8*, i8** %l5
  %t30 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %bindings, i8* %t29)
  store double %t30, double* %l7
  %t31 = load double, double* %l7
  br label %merge3
merge3:
  %t32 = insertvalue %OwnershipAnalysis undef, i8* null, 0
  %t33 = insertvalue %OwnershipAnalysis %t32, i8* null, 1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = insertvalue %OwnershipAnalysis %t33, { i8**, i64 }* %t34, 2
  ret %OwnershipAnalysis %t35
}

define i8* @format_use_after_move_message(i8* %name, double %span) {
entry:
  ret i8* null
}

define i8* @format_span_location(double %span) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  store double 0.0, double* %l1
  %t0 = load double, double* %l0
  ret i8* null
}

define i8* @format_suspension_location(i8* %keyword, double %borrow_span, double %suspension_span) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s6 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
}

define { i8**, i64 }* @detect_borrow_conflicts(double %ownership, { %LocalBinding*, i64 }* %locals, i8* %binding_name, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double 0.0, double* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t11
}

define i8* @resolve_borrow_base(i8* %target, { %LocalBinding*, i64 }* %locals) {
entry:
  %t0 = call i8* @trim_text(i8* %target)
  %t1 = sitofp i64 0 to double
  %t2 = call i8* @resolve_borrow_base_inner(i8* %t0, { %LocalBinding*, i64 }* %locals, double %t1)
  ret i8* %t2
}

define i8* @resolve_borrow_base_inner(i8* %target, { %LocalBinding*, i64 }* %locals, double %depth) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = call i8* @trim_text(i8* %target)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 8 to double
  %t3 = fcmp oge double %depth, %t2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  ret i8* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = call double @is_simple_identifier(i8* %t6)
  %t8 = fcmp one double %t7, 0.0
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %t10 = load i8*, i8** %l0
  ret i8* %t10
merge3:
  %t11 = load i8*, i8** %l0
  %t12 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t11)
  store double %t12, double* %l1
  %t13 = load double, double* %l1
  %t14 = load double, double* %l1
  %t15 = load double, double* %l1
  store double 0.0, double* %l2
  %t16 = load double, double* %l2
  %t17 = load double, double* %l2
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %depth, %t18
  ret i8* null
}

define %ExpressionResult @lower_borrow_expression(%BorrowParseResult %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca %LLVMOperand
  %t0 = extractvalue %BorrowParseResult %parse, 4
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = extractvalue %BorrowParseResult %parse, 2
  %t2 = call i8* @strip_enclosing_parentheses(i8* %t1)
  store i8* %t2, i8** %l1
  %t3 = load i8*, i8** %l1
  %t4 = call i8* @trim_text(i8* %t3)
  store i8* %t4, i8** %l1
  %t5 = load i8*, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t6)
  store double %t7, double* %l2
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l3
  %t11 = insertvalue %LLVMOperand undef, i8* null, 0
  %t12 = load double, double* %l2
  %t13 = insertvalue %LLVMOperand %t11, i8* null, 1
  store %LLVMOperand %t13, %LLVMOperand* %l4
  %t14 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t15 = insertvalue %ExpressionResult %t14, double %temp_index, 1
  %t16 = load %LLVMOperand, %LLVMOperand* %l4
  %t17 = insertvalue %ExpressionResult %t15, i8* null, 2
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = insertvalue %ExpressionResult %t17, { i8**, i64 }* %t18, 3
  %t20 = alloca [0 x double]
  %t21 = getelementptr [0 x double], [0 x double]* %t20, i32 0, i32 0
  %t22 = alloca { double*, i64 }
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 0
  store double* %t21, double** %t23
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  %t25 = insertvalue %ExpressionResult %t19, { i8**, i64 }* null, 4
  ret %ExpressionResult %t25
}

define %ExpressionResult @lower_binary_operation(i8* %expression, %OperatorMatch %match, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %ExpressionResult
  %l4 = alloca { %StringConstant*, i64 }*
  %l5 = alloca %ExpressionResult
  %l6 = alloca %BinaryAlignmentResult
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca double
  %l12 = alloca { i8**, i64 }*
  %l13 = alloca %LLVMOperand
  %t0 = extractvalue %OperatorMatch %match, 0
  %t1 = call double @substring(i8* %expression, i64 0, double %t0)
  %t2 = call i8* @trim_text(i8* null)
  store i8* %t2, i8** %l0
  %t3 = extractvalue %OperatorMatch %match, 0
  %t4 = sitofp i64 1 to double
  %t5 = fadd double %t3, %t4
  store double 0.0, double* %l1
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t11 = load i8*, i8** %l0
  %t12 = load i8*, i8** %l0
  %t13 = call %ExpressionResult @lower_expression(i8* %t12, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  store %ExpressionResult %t13, %ExpressionResult* %l3
  %t14 = load %ExpressionResult, %ExpressionResult* %l3
  %t15 = extractvalue %ExpressionResult %t14, 3
  %t16 = call double @diagnosticsconcat({ i8**, i64 }* %t15)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t17 = load %ExpressionResult, %ExpressionResult* %l3
  %t18 = extractvalue %ExpressionResult %t17, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l4
  %t19 = load %ExpressionResult, %ExpressionResult* %l3
  %t20 = extractvalue %ExpressionResult %t19, 2
  %t21 = load double, double* %l1
  %t22 = load %ExpressionResult, %ExpressionResult* %l3
  %t23 = extractvalue %ExpressionResult %t22, 1
  %t24 = load %ExpressionResult, %ExpressionResult* %l3
  %t25 = extractvalue %ExpressionResult %t24, 0
  %t26 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t23, { i8**, i64 }* %t25, double %functions, %TypeContext %context)
  store %ExpressionResult %t26, %ExpressionResult* %l5
  %t27 = load %ExpressionResult, %ExpressionResult* %l5
  %t28 = extractvalue %ExpressionResult %t27, 3
  %t29 = call double @diagnosticsconcat({ i8**, i64 }* %t28)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t30 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t31 = load %ExpressionResult, %ExpressionResult* %l5
  %t32 = extractvalue %ExpressionResult %t31, 4
  %t33 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t30, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t33, { %StringConstant*, i64 }** %l4
  %t34 = load %ExpressionResult, %ExpressionResult* %l5
  %t35 = extractvalue %ExpressionResult %t34, 2
  %t36 = load %ExpressionResult, %ExpressionResult* %l3
  %t37 = extractvalue %ExpressionResult %t36, 2
  %t38 = load %ExpressionResult, %ExpressionResult* %l5
  %t39 = extractvalue %ExpressionResult %t38, 2
  %t40 = load %ExpressionResult, %ExpressionResult* %l5
  %t41 = extractvalue %ExpressionResult %t40, 1
  %t42 = load %ExpressionResult, %ExpressionResult* %l5
  %t43 = extractvalue %ExpressionResult %t42, 0
  %t44 = call %BinaryAlignmentResult @harmonise_operands(%LLVMOperand zeroinitializer, %LLVMOperand zeroinitializer, double %t41, { i8**, i64 }* %t43)
  store %BinaryAlignmentResult %t44, %BinaryAlignmentResult* %l6
  %t45 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t46 = extractvalue %BinaryAlignmentResult %t45, 4
  %t47 = call double @diagnosticsconcat({ i8**, i64 }* %t46)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t48 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t49 = extractvalue %BinaryAlignmentResult %t48, 2
  %t50 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t51 = extractvalue %BinaryAlignmentResult %t50, 2
  store i8* %t51, i8** %l7
  %t52 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t53 = extractvalue %BinaryAlignmentResult %t52, 3
  store i8* %t53, i8** %l8
  %t54 = extractvalue %OperatorMatch %match, 1
  %t55 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t56 = extractvalue %BinaryAlignmentResult %t55, 5
  %t57 = call i8* @operation_name_for_symbol(i8* %t54, i8* %t56)
  store i8* %t57, i8** %l9
  %t58 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t59 = extractvalue %BinaryAlignmentResult %t58, 1
  %t60 = call i8* @format_temp_name(double %t59)
  store i8* %t60, i8** %l10
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.61, i32 0, i32 0
  %t62 = load i8*, i8** %l10
  %t63 = add i8* %s61, %t62
  %s64 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %t63, %s64
  %t66 = load i8*, i8** %l9
  %t67 = add i8* %t65, %t66
  %s68 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.68, i32 0, i32 0
  %t69 = add i8* %t67, %s68
  %t70 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t71 = extractvalue %BinaryAlignmentResult %t70, 5
  %t72 = add i8* %t69, %t71
  %s73 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.73, i32 0, i32 0
  %t74 = add i8* %t72, %s73
  %t75 = load i8*, i8** %l7
  store double 0.0, double* %l11
  %t76 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t77 = extractvalue %BinaryAlignmentResult %t76, 0
  %t78 = load double, double* %l11
  %t79 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t77, i8* null)
  store { i8**, i64 }* %t79, { i8**, i64 }** %l12
  %t80 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t81 = extractvalue %BinaryAlignmentResult %t80, 5
  %t82 = insertvalue %LLVMOperand undef, i8* %t81, 0
  %t83 = load i8*, i8** %l10
  %t84 = insertvalue %LLVMOperand %t82, i8* %t83, 1
  store %LLVMOperand %t84, %LLVMOperand* %l13
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_comparison_operation(i8* %expression, %OperatorMatch %match, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca %ExpressionResult
  %l5 = alloca { %StringConstant*, i64 }*
  %l6 = alloca %ExpressionResult
  %l7 = alloca %BinaryAlignmentResult
  %l8 = alloca %ComparisonEmission
  %t0 = extractvalue %OperatorMatch %match, 1
  store double 0.0, double* %l0
  %t1 = extractvalue %OperatorMatch %match, 0
  %t2 = call double @substring(i8* %expression, i64 0, double %t1)
  %t3 = call i8* @trim_text(i8* null)
  store i8* %t3, i8** %l1
  %t4 = extractvalue %OperatorMatch %match, 0
  %t5 = load double, double* %l0
  %t6 = fadd double %t4, %t5
  store double 0.0, double* %l2
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t12 = load i8*, i8** %l1
  %t13 = load i8*, i8** %l1
  %t14 = call %ExpressionResult @lower_expression(i8* %t13, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  store %ExpressionResult %t14, %ExpressionResult* %l4
  %t15 = load %ExpressionResult, %ExpressionResult* %l4
  %t16 = extractvalue %ExpressionResult %t15, 3
  %t17 = call double @diagnosticsconcat({ i8**, i64 }* %t16)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t18 = load %ExpressionResult, %ExpressionResult* %l4
  %t19 = extractvalue %ExpressionResult %t18, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l5
  %t20 = load %ExpressionResult, %ExpressionResult* %l4
  %t21 = extractvalue %ExpressionResult %t20, 2
  %t22 = load double, double* %l2
  %t23 = load %ExpressionResult, %ExpressionResult* %l4
  %t24 = extractvalue %ExpressionResult %t23, 1
  %t25 = load %ExpressionResult, %ExpressionResult* %l4
  %t26 = extractvalue %ExpressionResult %t25, 0
  %t27 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t24, { i8**, i64 }* %t26, double %functions, %TypeContext %context)
  store %ExpressionResult %t27, %ExpressionResult* %l6
  %t28 = load %ExpressionResult, %ExpressionResult* %l6
  %t29 = extractvalue %ExpressionResult %t28, 3
  %t30 = call double @diagnosticsconcat({ i8**, i64 }* %t29)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t31 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t32 = load %ExpressionResult, %ExpressionResult* %l6
  %t33 = extractvalue %ExpressionResult %t32, 4
  %t34 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t31, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t34, { %StringConstant*, i64 }** %l5
  %t35 = load %ExpressionResult, %ExpressionResult* %l6
  %t36 = extractvalue %ExpressionResult %t35, 2
  %t37 = load %ExpressionResult, %ExpressionResult* %l4
  %t38 = extractvalue %ExpressionResult %t37, 2
  %t39 = load %ExpressionResult, %ExpressionResult* %l6
  %t40 = extractvalue %ExpressionResult %t39, 2
  %t41 = load %ExpressionResult, %ExpressionResult* %l6
  %t42 = extractvalue %ExpressionResult %t41, 1
  %t43 = load %ExpressionResult, %ExpressionResult* %l6
  %t44 = extractvalue %ExpressionResult %t43, 0
  %t45 = call %BinaryAlignmentResult @harmonise_operands(%LLVMOperand zeroinitializer, %LLVMOperand zeroinitializer, double %t42, { i8**, i64 }* %t44)
  store %BinaryAlignmentResult %t45, %BinaryAlignmentResult* %l7
  %t46 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t47 = extractvalue %BinaryAlignmentResult %t46, 4
  %t48 = call double @diagnosticsconcat({ i8**, i64 }* %t47)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t49 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t50 = extractvalue %BinaryAlignmentResult %t49, 2
  %t51 = extractvalue %OperatorMatch %match, 1
  %t52 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t53 = extractvalue %BinaryAlignmentResult %t52, 2
  %t54 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t55 = extractvalue %BinaryAlignmentResult %t54, 3
  %t56 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t57 = extractvalue %BinaryAlignmentResult %t56, 1
  %t58 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t59 = extractvalue %BinaryAlignmentResult %t58, 0
  %t60 = call %ComparisonEmission @emit_comparison_instruction(i8* %t51, %LLVMOperand zeroinitializer, %LLVMOperand zeroinitializer, double %t57, { i8**, i64 }* %t59)
  store %ComparisonEmission %t60, %ComparisonEmission* %l8
  %t61 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t62 = extractvalue %ComparisonEmission %t61, 3
  %t63 = call double @diagnosticsconcat({ i8**, i64 }* %t62)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t64 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t65 = extractvalue %ComparisonEmission %t64, 2
  %t66 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t67 = extractvalue %ComparisonEmission %t66, 0
  %t68 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t67, 0
  %t69 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t70 = extractvalue %ComparisonEmission %t69, 1
  %t71 = insertvalue %ExpressionResult %t68, double %t70, 1
  %t72 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t73 = extractvalue %ComparisonEmission %t72, 2
  %t74 = insertvalue %ExpressionResult %t71, i8* %t73, 2
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t76 = insertvalue %ExpressionResult %t74, { i8**, i64 }* %t75, 3
  %t77 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t78 = insertvalue %ExpressionResult %t76, { i8**, i64 }* null, 4
  ret %ExpressionResult %t78
}

define %ExpressionResult @lower_call_expression(i8* %target, { i8**, i64 }* %arguments, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %StringConstant*, i64 }*
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca { %LLVMOperand*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %MemberAccessParse
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca %ExpressionResult
  %l14 = alloca double
  %l15 = alloca i8*
  %l16 = alloca { i8**, i64 }*
  %l17 = alloca i1
  %l18 = alloca double
  %l19 = alloca double
  %l20 = alloca { %LLVMOperand*, i64 }*
  %l21 = alloca double
  %l22 = alloca i8*
  %l23 = alloca { i8**, i64 }*
  %l24 = alloca double
  %l25 = alloca i8*
  %l26 = alloca i8*
  %l27 = alloca i8*
  %l28 = alloca %LLVMOperand
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l1
  %t10 = call i8* @trim_text(i8* %target)
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  store { i8**, i64 }* %lines, { i8**, i64 }** %l3
  store double %temp_index, double* %l4
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  store double 0.0, double* %l7
  %t18 = load i8*, i8** %l2
  %t19 = call %MemberAccessParse @parse_member_access(i8* %t18)
  store %MemberAccessParse %t19, %MemberAccessParse* %l8
  %t20 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t21 = extractvalue %MemberAccessParse %t20, 0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t24 = load i8*, i8** %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = load double, double* %l4
  %t27 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t28 = load double, double* %l6
  %t29 = load double, double* %l7
  %t30 = load %MemberAccessParse, %MemberAccessParse* %l8
  br i1 %t21, label %then0, label %merge1
then0:
  %t31 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t32 = extractvalue %MemberAccessParse %t31, 1
  %t33 = call double @resolve_struct_info_for_method_target(i8* %t32, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, %TypeContext %context)
  store double %t33, double* %l9
  %t34 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t35 = extractvalue %MemberAccessParse %t34, 1
  %t36 = call double @resolve_interface_info_for_method_target(i8* %t35, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, %TypeContext %context)
  store double %t36, double* %l10
  %t37 = load double, double* %l9
  br label %merge1
merge1:
  %t38 = sitofp i64 0 to double
  store double %t38, double* %l11
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load double, double* %l4
  %t44 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t45 = load double, double* %l6
  %t46 = load double, double* %l7
  %t47 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t48 = load double, double* %l11
  br label %loop.header2
loop.header2:
  %t72 = phi { i8**, i64 }* [ %t39, %entry ], [ %t68, %loop.latch4 ]
  %t73 = phi { %StringConstant*, i64 }* [ %t40, %entry ], [ %t69, %loop.latch4 ]
  %t74 = phi { i8**, i64 }* [ %t42, %entry ], [ %t70, %loop.latch4 ]
  %t75 = phi double [ %t43, %entry ], [ %t71, %loop.latch4 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store { %StringConstant*, i64 }* %t73, { %StringConstant*, i64 }** %l1
  store { i8**, i64 }* %t74, { i8**, i64 }** %l3
  store double %t75, double* %l4
  br label %loop.body3
loop.body3:
  %t49 = load double, double* %l11
  store double 0.0, double* %l12
  %t50 = load double, double* %l12
  %t51 = load double, double* %l12
  %t52 = load double, double* %l4
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t54 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t52, { i8**, i64 }* %t53, double %functions, %TypeContext %context)
  store %ExpressionResult %t54, %ExpressionResult* %l13
  %t55 = load %ExpressionResult, %ExpressionResult* %l13
  %t56 = extractvalue %ExpressionResult %t55, 3
  %t57 = call double @diagnosticsconcat({ i8**, i64 }* %t56)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t58 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t59 = load %ExpressionResult, %ExpressionResult* %l13
  %t60 = extractvalue %ExpressionResult %t59, 4
  %t61 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t58, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t61, { %StringConstant*, i64 }** %l1
  %t62 = load %ExpressionResult, %ExpressionResult* %l13
  %t63 = extractvalue %ExpressionResult %t62, 0
  store { i8**, i64 }* %t63, { i8**, i64 }** %l3
  %t64 = load %ExpressionResult, %ExpressionResult* %l13
  %t65 = extractvalue %ExpressionResult %t64, 1
  store double %t65, double* %l4
  %t66 = load %ExpressionResult, %ExpressionResult* %l13
  %t67 = extractvalue %ExpressionResult %t66, 2
  br label %loop.latch4
loop.latch4:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t71 = load double, double* %l4
  br label %loop.header2
afterloop5:
  %t76 = load double, double* %l7
  store double 0.0, double* %l14
  %t77 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.78, i32 0, i32 0
  store i8* %s78, i8** %l15
  %t79 = alloca [0 x double]
  %t80 = getelementptr [0 x double], [0 x double]* %t79, i32 0, i32 0
  %t81 = alloca { double*, i64 }
  %t82 = getelementptr { double*, i64 }, { double*, i64 }* %t81, i32 0, i32 0
  store double* %t80, double** %t82
  %t83 = getelementptr { double*, i64 }, { double*, i64 }* %t81, i32 0, i32 1
  store i64 0, i64* %t83
  store { i8**, i64 }* null, { i8**, i64 }** %l16
  store i1 0, i1* %l17
  %t84 = load i8*, i8** %l2
  %t85 = call double @substring(i8* %t84, i64 0, i64 16)
  %s86 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.86, i32 0, i32 0
  %t87 = load i8*, i8** %l2
  %t88 = call double @find_function_by_name(double %functions, i8* %t87)
  store double %t88, double* %l18
  %t89 = load i8*, i8** %l2
  %t90 = call double @find_runtime_helper(i8* %t89)
  store double %t90, double* %l19
  %t91 = load double, double* %l18
  %t92 = alloca [0 x double]
  %t93 = getelementptr [0 x double], [0 x double]* %t92, i32 0, i32 0
  %t94 = alloca { double*, i64 }
  %t95 = getelementptr { double*, i64 }, { double*, i64 }* %t94, i32 0, i32 0
  store double* %t93, double** %t95
  %t96 = getelementptr { double*, i64 }, { double*, i64 }* %t94, i32 0, i32 1
  store i64 0, i64* %t96
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l20
  %t97 = sitofp i64 0 to double
  store double %t97, double* %l11
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t100 = load i8*, i8** %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t102 = load double, double* %l4
  %t103 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t104 = load double, double* %l6
  %t105 = load double, double* %l7
  %t106 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t107 = load double, double* %l11
  %t108 = load double, double* %l14
  %t109 = load i8*, i8** %l15
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t111 = load i1, i1* %l17
  %t112 = load double, double* %l18
  %t113 = load double, double* %l19
  %t114 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l20
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t115 = load double, double* %l11
  %t116 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  store double 0.0, double* %l21
  %s117 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.117, i32 0, i32 0
  store i8* %s117, i8** %l22
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l16
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t119 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l20
  store { %LLVMOperand*, i64 }* %t119, { %LLVMOperand*, i64 }** %l5
  %t120 = load double, double* %l18
  %t121 = alloca [0 x double]
  %t122 = getelementptr [0 x double], [0 x double]* %t121, i32 0, i32 0
  %t123 = alloca { double*, i64 }
  %t124 = getelementptr { double*, i64 }, { double*, i64 }* %t123, i32 0, i32 0
  store double* %t122, double** %t124
  %t125 = getelementptr { double*, i64 }, { double*, i64 }* %t123, i32 0, i32 1
  store i64 0, i64* %t125
  store { i8**, i64 }* null, { i8**, i64 }** %l23
  %t126 = sitofp i64 0 to double
  store double %t126, double* %l11
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t129 = load i8*, i8** %l2
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t131 = load double, double* %l4
  %t132 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t133 = load double, double* %l6
  %t134 = load double, double* %l7
  %t135 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t136 = load double, double* %l11
  %t137 = load double, double* %l14
  %t138 = load i8*, i8** %l15
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t140 = load i1, i1* %l17
  %t141 = load double, double* %l18
  %t142 = load double, double* %l19
  %t143 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l20
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l23
  br label %loop.header10
loop.header10:
  %t149 = phi { i8**, i64 }* [ %t144, %entry ], [ %t148, %loop.latch12 ]
  store { i8**, i64 }* %t149, { i8**, i64 }** %l23
  br label %loop.body11
loop.body11:
  %t145 = load double, double* %l11
  %t146 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l23
  br label %loop.latch12
loop.latch12:
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l23
  br label %loop.header10
afterloop13:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l23
  store double 0.0, double* %l24
  %t151 = load i8*, i8** %l2
  %t152 = call double @substring(i8* %t151, i64 0, i64 16)
  %s153 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.153, i32 0, i32 0
  %t154 = load i8*, i8** %l2
  %t155 = call i8* @sanitize_symbol(i8* %t154)
  store i8* %t155, i8** %l25
  %t156 = load double, double* %l19
  %t157 = load i8*, i8** %l15
  %s158 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.158, i32 0, i32 0
  %t159 = load double, double* %l4
  %t160 = call i8* @format_temp_name(double %t159)
  store i8* %t160, i8** %l26
  %s161 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.161, i32 0, i32 0
  %t162 = load i8*, i8** %l26
  %t163 = add i8* %s161, %t162
  %s164 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.164, i32 0, i32 0
  %t165 = add i8* %t163, %s164
  %t166 = load i8*, i8** %l15
  %t167 = add i8* %t165, %t166
  %s168 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.168, i32 0, i32 0
  %t169 = add i8* %t167, %s168
  %t170 = load i8*, i8** %l25
  %t171 = add i8* %t169, %t170
  %s172 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.172, i32 0, i32 0
  %t173 = add i8* %t171, %s172
  store i8* %t173, i8** %l27
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t175 = load i8*, i8** %l27
  %t176 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t174, i8* %t175)
  store { i8**, i64 }* %t176, { i8**, i64 }** %l3
  %t177 = load i8*, i8** %l15
  %t178 = insertvalue %LLVMOperand undef, i8* %t177, 0
  %t179 = load i8*, i8** %l26
  %t180 = insertvalue %LLVMOperand %t178, i8* %t179, 1
  store %LLVMOperand %t180, %LLVMOperand* %l28
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_member_access(%MemberAccessParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca %ExpressionResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %StringConstant*, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca %LLVMOperand
  %l15 = alloca i8*
  %l16 = alloca %LLVMOperand
  %t0 = extractvalue %MemberAccessParse %parse, 1
  %t1 = call %ExpressionResult @lower_expression(i8* %t0, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context)
  store %ExpressionResult %t1, %ExpressionResult* %l0
  %t2 = load %ExpressionResult, %ExpressionResult* %l0
  %t3 = extractvalue %ExpressionResult %t2, 3
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t4 = load %ExpressionResult, %ExpressionResult* %l0
  %t5 = extractvalue %ExpressionResult %t4, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l2
  %t6 = load %ExpressionResult, %ExpressionResult* %l0
  %t7 = extractvalue %ExpressionResult %t6, 2
  %t8 = load %ExpressionResult, %ExpressionResult* %l0
  %t9 = extractvalue %ExpressionResult %t8, 0
  store { i8**, i64 }* %t9, { i8**, i64 }** %l3
  %t10 = load %ExpressionResult, %ExpressionResult* %l0
  %t11 = extractvalue %ExpressionResult %t10, 1
  store double %t11, double* %l4
  %t12 = load %ExpressionResult, %ExpressionResult* %l0
  %t13 = extractvalue %ExpressionResult %t12, 2
  store i8* %t13, i8** %l5
  store double 0.0, double* %l6
  store i1 0, i1* %l7
  %t14 = load i8*, i8** %l5
  store i8* %t14, i8** %l8
  %t15 = load i8*, i8** %l5
  %t16 = load double, double* %l6
  store double %t16, double* %l9
  %t17 = load double, double* %l9
  %t18 = extractvalue %MemberAccessParse %parse, 2
  %t19 = call double @find_struct_field_info(%StructTypeInfo zeroinitializer, i8* %t18)
  store double %t19, double* %l10
  %t20 = load double, double* %l10
  %t21 = load i1, i1* %l7
  %t22 = load %ExpressionResult, %ExpressionResult* %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = load double, double* %l4
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l6
  %t29 = load i1, i1* %l7
  %t30 = load i8*, i8** %l8
  %t31 = load double, double* %l9
  %t32 = load double, double* %l10
  br i1 %t21, label %then0, label %merge1
then0:
  %t33 = load double, double* %l9
  store double 0.0, double* %l11
  %t34 = load double, double* %l4
  %t35 = call i8* @format_temp_name(double %t34)
  store i8* %t35, i8** %l12
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s37 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.37, i32 0, i32 0
  %t38 = load i8*, i8** %l12
  %t39 = add i8* %s37, %t38
  %s40 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.40, i32 0, i32 0
  %t41 = add i8* %t39, %s40
  %t42 = load double, double* %l11
  %t43 = load double, double* %l4
  %t44 = call i8* @format_temp_name(double %t43)
  store i8* %t44, i8** %l13
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = load i8*, i8** %l13
  %t48 = add i8* %s46, %t47
  %s49 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.49, i32 0, i32 0
  %t50 = add i8* %t48, %s49
  %t51 = load double, double* %l10
  %t52 = load double, double* %l10
  %t53 = insertvalue %LLVMOperand undef, i8* null, 0
  %t54 = load i8*, i8** %l13
  %t55 = insertvalue %LLVMOperand %t53, i8* %t54, 1
  store %LLVMOperand %t55, %LLVMOperand* %l14
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t57 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t56, 0
  %t58 = load double, double* %l4
  %t59 = insertvalue %ExpressionResult %t57, double %t58, 1
  %t60 = load %LLVMOperand, %LLVMOperand* %l14
  %t61 = insertvalue %ExpressionResult %t59, i8* null, 2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = insertvalue %ExpressionResult %t61, { i8**, i64 }* %t62, 3
  %t64 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t65 = insertvalue %ExpressionResult %t63, { i8**, i64 }* null, 4
  ret %ExpressionResult %t65
merge1:
  %t66 = load double, double* %l4
  %t67 = call i8* @format_temp_name(double %t66)
  store i8* %t67, i8** %l15
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.69, i32 0, i32 0
  %t70 = load i8*, i8** %l15
  %t71 = add i8* %s69, %t70
  %s72 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.72, i32 0, i32 0
  %t73 = add i8* %t71, %s72
  %t74 = load double, double* %l9
  %t75 = load double, double* %l10
  %t76 = insertvalue %LLVMOperand undef, i8* null, 0
  %t77 = load i8*, i8** %l15
  %t78 = insertvalue %LLVMOperand %t76, i8* %t77, 1
  store %LLVMOperand %t78, %LLVMOperand* %l16
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t79, 0
  %t81 = load double, double* %l4
  %t82 = insertvalue %ExpressionResult %t80, double %t81, 1
  %t83 = load %LLVMOperand, %LLVMOperand* %l16
  %t84 = insertvalue %ExpressionResult %t82, i8* null, 2
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = insertvalue %ExpressionResult %t84, { i8**, i64 }* %t85, 3
  %t87 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t88 = insertvalue %ExpressionResult %t86, { i8**, i64 }* null, 4
  ret %ExpressionResult %t88
}

define %ExpressionResult @lower_array_literal(i8* %text, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca { %StringConstant*, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca %ArrayLiteralMetadata
  %l7 = alloca { %LLVMOperand*, i64 }*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca %ExpressionResult
  %l12 = alloca i8*
  %l13 = alloca { %LLVMOperand*, i64 }*
  %l14 = alloca double
  %l15 = alloca %CoercionResult
  %l16 = alloca double
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca i8*
  %l20 = alloca i8*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca double
  %l26 = alloca double
  %l27 = alloca i8*
  %l28 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l3
  store double 0.0, double* %l4
  %t10 = load double, double* %l4
  %t11 = call { i8**, i64 }* @split_array_elements(i8* null)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l5
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t13 = call %ArrayLiteralMetadata @parse_array_literal_metadata({ i8**, i64 }* %t12, %TypeContext %context)
  store %ArrayLiteralMetadata %t13, %ArrayLiteralMetadata* %l6
  %t14 = alloca [0 x double]
  %t15 = getelementptr [0 x double], [0 x double]* %t14, i32 0, i32 0
  %t16 = alloca { double*, i64 }
  %t17 = getelementptr { double*, i64 }, { double*, i64 }* %t16, i32 0, i32 0
  store double* %t15, double** %t17
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l7
  %t19 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t20 = extractvalue %ArrayLiteralMetadata %t19, 0
  store i8* %t20, i8** %l8
  %t21 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t22 = extractvalue %ArrayLiteralMetadata %t21, 1
  store double %t22, double* %l9
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load double, double* %l2
  %t26 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t27 = load double, double* %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t29 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t30 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t31 = load i8*, i8** %l8
  %t32 = load double, double* %l9
  br label %loop.header0
loop.header0:
  %t66 = phi { i8**, i64 }* [ %t23, %entry ], [ %t60, %loop.latch2 ]
  %t67 = phi { %StringConstant*, i64 }* [ %t26, %entry ], [ %t61, %loop.latch2 ]
  %t68 = phi { i8**, i64 }* [ %t24, %entry ], [ %t62, %loop.latch2 ]
  %t69 = phi double [ %t25, %entry ], [ %t63, %loop.latch2 ]
  %t70 = phi { %LLVMOperand*, i64 }* [ %t30, %entry ], [ %t64, %loop.latch2 ]
  %t71 = phi i8* [ %t31, %entry ], [ %t65, %loop.latch2 ]
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  store { %StringConstant*, i64 }* %t67, { %StringConstant*, i64 }** %l3
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  store double %t69, double* %l2
  store { %LLVMOperand*, i64 }* %t70, { %LLVMOperand*, i64 }** %l7
  store i8* %t71, i8** %l8
  br label %loop.body1
loop.body1:
  %t33 = load double, double* %l9
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l5
  store double 0.0, double* %l10
  %t35 = load double, double* %l10
  %t36 = load double, double* %l10
  %t37 = load double, double* %l2
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t37, { i8**, i64 }* %t38, double %functions, %TypeContext %context)
  store %ExpressionResult %t39, %ExpressionResult* %l11
  %t40 = load %ExpressionResult, %ExpressionResult* %l11
  %t41 = extractvalue %ExpressionResult %t40, 3
  %t42 = call double @diagnosticsconcat({ i8**, i64 }* %t41)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t43 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t44 = load %ExpressionResult, %ExpressionResult* %l11
  %t45 = extractvalue %ExpressionResult %t44, 4
  %t46 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t43, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t46, { %StringConstant*, i64 }** %l3
  %t47 = load %ExpressionResult, %ExpressionResult* %l11
  %t48 = extractvalue %ExpressionResult %t47, 0
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = load %ExpressionResult, %ExpressionResult* %l11
  %t50 = extractvalue %ExpressionResult %t49, 1
  store double %t50, double* %l2
  %t51 = load %ExpressionResult, %ExpressionResult* %l11
  %t52 = extractvalue %ExpressionResult %t51, 2
  %t53 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t54 = load %ExpressionResult, %ExpressionResult* %l11
  %t55 = extractvalue %ExpressionResult %t54, 2
  %t56 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t53, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t56, { %LLVMOperand*, i64 }** %l7
  %t57 = load i8*, i8** %l8
  %t58 = load %ExpressionResult, %ExpressionResult* %l11
  %t59 = extractvalue %ExpressionResult %t58, 2
  br label %loop.latch2
loop.latch2:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = load double, double* %l2
  %t64 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t65 = load i8*, i8** %l8
  br label %loop.header0
afterloop3:
  %t72 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t73 = load i8*, i8** %l8
  %t74 = load i8*, i8** %l8
  store i8* %t74, i8** %l12
  %t75 = alloca [0 x double]
  %t76 = getelementptr [0 x double], [0 x double]* %t75, i32 0, i32 0
  %t77 = alloca { double*, i64 }
  %t78 = getelementptr { double*, i64 }, { double*, i64 }* %t77, i32 0, i32 0
  store double* %t76, double** %t78
  %t79 = getelementptr { double*, i64 }, { double*, i64 }* %t77, i32 0, i32 1
  store i64 0, i64* %t79
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l13
  %t80 = sitofp i64 0 to double
  store double %t80, double* %l9
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load double, double* %l2
  %t84 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t85 = load double, double* %l4
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t87 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t88 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t89 = load i8*, i8** %l8
  %t90 = load double, double* %l9
  %t91 = load i8*, i8** %l12
  %t92 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  br label %loop.header4
loop.header4:
  %t117 = phi { i8**, i64 }* [ %t81, %entry ], [ %t113, %loop.latch6 ]
  %t118 = phi { i8**, i64 }* [ %t82, %entry ], [ %t114, %loop.latch6 ]
  %t119 = phi double [ %t83, %entry ], [ %t115, %loop.latch6 ]
  %t120 = phi { %LLVMOperand*, i64 }* [ %t92, %entry ], [ %t116, %loop.latch6 ]
  store { i8**, i64 }* %t117, { i8**, i64 }** %l0
  store { i8**, i64 }* %t118, { i8**, i64 }** %l1
  store double %t119, double* %l2
  store { %LLVMOperand*, i64 }* %t120, { %LLVMOperand*, i64 }** %l13
  br label %loop.body5
loop.body5:
  %t93 = load double, double* %l9
  %t94 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  store double 0.0, double* %l14
  %t95 = load double, double* %l14
  %t96 = load i8*, i8** %l12
  %t97 = load double, double* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %t96, double %t97, { i8**, i64 }* %t98)
  store %CoercionResult %t99, %CoercionResult* %l15
  %t100 = load %CoercionResult, %CoercionResult* %l15
  %t101 = extractvalue %CoercionResult %t100, 3
  %t102 = call double @diagnosticsconcat({ i8**, i64 }* %t101)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t103 = load %CoercionResult, %CoercionResult* %l15
  %t104 = extractvalue %CoercionResult %t103, 0
  store { i8**, i64 }* %t104, { i8**, i64 }** %l1
  %t105 = load %CoercionResult, %CoercionResult* %l15
  %t106 = extractvalue %CoercionResult %t105, 1
  store double %t106, double* %l2
  %t107 = load %CoercionResult, %CoercionResult* %l15
  %t108 = extractvalue %CoercionResult %t107, 2
  %t109 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t110 = load %CoercionResult, %CoercionResult* %l15
  %t111 = extractvalue %CoercionResult %t110, 2
  %t112 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t109, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t112, { %LLVMOperand*, i64 }** %l13
  br label %loop.latch6
loop.latch6:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = load double, double* %l2
  %t116 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  br label %loop.header4
afterloop7:
  %t121 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  store { %LLVMOperand*, i64 }* %t121, { %LLVMOperand*, i64 }** %l7
  %t122 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  store double 0.0, double* %l16
  %t123 = load double, double* %l16
  %t124 = call i8* @number_to_string(double %t123)
  store i8* %t124, i8** %l17
  %s125 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.125, i32 0, i32 0
  %t126 = load i8*, i8** %l17
  %t127 = add i8* %s125, %t126
  %s128 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.128, i32 0, i32 0
  %t129 = add i8* %t127, %s128
  %t130 = load i8*, i8** %l12
  %t131 = add i8* %t129, %t130
  %s132 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.132, i32 0, i32 0
  %t133 = add i8* %t131, %s132
  store i8* %t133, i8** %l18
  %t134 = load double, double* %l2
  %t135 = call i8* @format_temp_name(double %t134)
  store i8* %t135, i8** %l19
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s137 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.137, i32 0, i32 0
  %t138 = load i8*, i8** %l19
  %t139 = add i8* %s137, %t138
  %s140 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.140, i32 0, i32 0
  %t141 = add i8* %t139, %s140
  %t142 = load i8*, i8** %l18
  %t143 = add i8* %t141, %t142
  %t144 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t136, i8* %t143)
  store { i8**, i64 }* %t144, { i8**, i64 }** %l1
  %t145 = load double, double* %l2
  %t146 = call i8* @format_temp_name(double %t145)
  store i8* %t146, i8** %l20
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s148 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.148, i32 0, i32 0
  %t149 = load i8*, i8** %l20
  %t150 = add i8* %s148, %t149
  %s151 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.151, i32 0, i32 0
  %t152 = add i8* %t150, %s151
  %t153 = load i8*, i8** %l18
  %t154 = add i8* %t152, %t153
  %t155 = sitofp i64 0 to double
  store double %t155, double* %l9
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load double, double* %l2
  %t159 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t160 = load double, double* %l4
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t162 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t163 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t164 = load i8*, i8** %l8
  %t165 = load double, double* %l9
  %t166 = load i8*, i8** %l12
  %t167 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t168 = load double, double* %l16
  %t169 = load i8*, i8** %l17
  %t170 = load i8*, i8** %l18
  %t171 = load i8*, i8** %l19
  %t172 = load i8*, i8** %l20
  br label %loop.header8
loop.header8:
  %t192 = phi { i8**, i64 }* [ %t157, %entry ], [ %t191, %loop.latch10 ]
  store { i8**, i64 }* %t192, { i8**, i64 }** %l1
  br label %loop.body9
loop.body9:
  %t173 = load double, double* %l9
  %t174 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t175 = load double, double* %l2
  %t176 = call i8* @format_temp_name(double %t175)
  store i8* %t176, i8** %l21
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s178 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.178, i32 0, i32 0
  %t179 = load i8*, i8** %l21
  %t180 = add i8* %s178, %t179
  %s181 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.181, i32 0, i32 0
  %t182 = add i8* %t180, %s181
  %t183 = load i8*, i8** %l12
  %t184 = add i8* %t182, %t183
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s186 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.186, i32 0, i32 0
  %t187 = load i8*, i8** %l12
  %t188 = add i8* %s186, %t187
  %s189 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.189, i32 0, i32 0
  %t190 = add i8* %t188, %s189
  br label %loop.latch10
loop.latch10:
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header8
afterloop11:
  %t193 = load i8*, i8** %l12
  %t194 = call i8* @array_struct_type_for_element(i8* %t193)
  store i8* %t194, i8** %l22
  %t195 = load double, double* %l2
  %t196 = call i8* @format_temp_name(double %t195)
  store i8* %t196, i8** %l23
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s198 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.198, i32 0, i32 0
  %t199 = load i8*, i8** %l23
  %t200 = add i8* %s198, %t199
  %s201 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.201, i32 0, i32 0
  %t202 = add i8* %t200, %s201
  %t203 = load i8*, i8** %l22
  %t204 = add i8* %t202, %t203
  %t205 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t197, i8* %t204)
  store { i8**, i64 }* %t205, { i8**, i64 }** %l1
  %t206 = load double, double* %l2
  %t207 = call i8* @format_temp_name(double %t206)
  store i8* %t207, i8** %l24
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s209 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.209, i32 0, i32 0
  %t210 = load i8*, i8** %l24
  %t211 = add i8* %s209, %t210
  %s212 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.212, i32 0, i32 0
  %t213 = add i8* %t211, %s212
  %t214 = load i8*, i8** %l22
  %t215 = add i8* %t213, %t214
  %t216 = load i8*, i8** %l12
  store double 0.0, double* %l25
  %t217 = load double, double* %l25
  store double 0.0, double* %l26
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s219 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.219, i32 0, i32 0
  %t220 = load double, double* %l25
  %t221 = load double, double* %l2
  %t222 = call i8* @format_temp_name(double %t221)
  store i8* %t222, i8** %l27
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s224 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.224, i32 0, i32 0
  %t225 = load i8*, i8** %l27
  %t226 = add i8* %s224, %t225
  %s227 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.227, i32 0, i32 0
  %t228 = add i8* %t226, %s227
  %t229 = load i8*, i8** %l22
  %t230 = add i8* %t228, %t229
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s232 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.232, i32 0, i32 0
  %t233 = load i8*, i8** %l17
  %t234 = add i8* %s232, %t233
  store double 0.0, double* %l28
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t236 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t235, 0
  %t237 = load double, double* %l2
  %t238 = insertvalue %ExpressionResult %t236, double %t237, 1
  %t239 = load double, double* %l28
  %t240 = insertvalue %ExpressionResult %t238, i8* null, 2
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = insertvalue %ExpressionResult %t240, { i8**, i64 }* %t241, 3
  %t243 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t244 = insertvalue %ExpressionResult %t242, { i8**, i64 }* null, 4
  ret %ExpressionResult %t244
}

define double @find_matching_closing_brace(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = load i1, i1* %l2
  %t4 = load i1, i1* %l3
  %t5 = load i1, i1* %l4
  br label %loop.header0
loop.header0:
  %t48 = phi i1 [ %t5, %entry ], [ %t47, %loop.latch2 ]
  store i1 %t48, i1* %l4
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  store double 0.0, double* %l5
  %t7 = load i1, i1* %l3
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  %t10 = load i1, i1* %l2
  %t11 = load i1, i1* %l3
  %t12 = load i1, i1* %l4
  %t13 = load double, double* %l5
  br i1 %t7, label %then4, label %merge5
then4:
  %t14 = load i1, i1* %l4
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i1, i1* %l2
  %t18 = load i1, i1* %l3
  %t19 = load i1, i1* %l4
  %t20 = load double, double* %l5
  br i1 %t14, label %then6, label %else7
then6:
  store i1 0, i1* %l4
  br label %merge8
else7:
  %t21 = load double, double* %l5
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  br label %merge8
merge8:
  %t23 = phi i1 [ 0, %then6 ], [ %t19, %else7 ]
  store i1 %t23, i1* %l4
  br label %loop.latch2
merge5:
  %t24 = load i1, i1* %l2
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i1, i1* %l2
  %t28 = load i1, i1* %l3
  %t29 = load i1, i1* %l4
  %t30 = load double, double* %l5
  br i1 %t24, label %then9, label %merge10
then9:
  %t31 = load i1, i1* %l4
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load i1, i1* %l2
  %t35 = load i1, i1* %l3
  %t36 = load i1, i1* %l4
  %t37 = load double, double* %l5
  br i1 %t31, label %then11, label %else12
then11:
  store i1 0, i1* %l4
  br label %merge13
else12:
  %t38 = load double, double* %l5
  %s39 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.39, i32 0, i32 0
  br label %merge13
merge13:
  %t40 = phi i1 [ 0, %then11 ], [ %t36, %else12 ]
  store i1 %t40, i1* %l4
  br label %loop.latch2
merge10:
  %t41 = load double, double* %l5
  %s42 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.42, i32 0, i32 0
  %t43 = load double, double* %l5
  %s44 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.44, i32 0, i32 0
  %t45 = load double, double* %l5
  %s46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.46, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t47 = load i1, i1* %l4
  br label %loop.header0
afterloop3:
  %t49 = sitofp i64 -1 to double
  ret double %t49
}

define double @find_top_level_colon(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i1
  %l6 = alloca i1
  %l7 = alloca double
  %l8 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  store i1 0, i1* %l4
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l7
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load i1, i1* %l4
  %t10 = load i1, i1* %l5
  %t11 = load i1, i1* %l6
  %t12 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t81 = phi i1 [ %t11, %entry ], [ %t80, %loop.latch2 ]
  store i1 %t81, i1* %l6
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l7
  store double 0.0, double* %l8
  %t14 = load i1, i1* %l5
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load i1, i1* %l4
  %t20 = load i1, i1* %l5
  %t21 = load i1, i1* %l6
  %t22 = load double, double* %l7
  %t23 = load double, double* %l8
  br i1 %t14, label %then4, label %merge5
then4:
  %t24 = load i1, i1* %l6
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  %t28 = load double, double* %l3
  %t29 = load i1, i1* %l4
  %t30 = load i1, i1* %l5
  %t31 = load i1, i1* %l6
  %t32 = load double, double* %l7
  %t33 = load double, double* %l8
  br i1 %t24, label %then6, label %else7
then6:
  store i1 0, i1* %l6
  br label %merge8
else7:
  %t34 = load double, double* %l8
  %s35 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.35, i32 0, i32 0
  br label %merge8
merge8:
  %t36 = phi i1 [ 0, %then6 ], [ %t31, %else7 ]
  store i1 %t36, i1* %l6
  br label %loop.latch2
merge5:
  %t37 = load i1, i1* %l4
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l2
  %t41 = load double, double* %l3
  %t42 = load i1, i1* %l4
  %t43 = load i1, i1* %l5
  %t44 = load i1, i1* %l6
  %t45 = load double, double* %l7
  %t46 = load double, double* %l8
  br i1 %t37, label %then9, label %merge10
then9:
  %t47 = load i1, i1* %l6
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load i1, i1* %l4
  %t53 = load i1, i1* %l5
  %t54 = load i1, i1* %l6
  %t55 = load double, double* %l7
  %t56 = load double, double* %l8
  br i1 %t47, label %then11, label %else12
then11:
  store i1 0, i1* %l6
  br label %merge13
else12:
  %t57 = load double, double* %l8
  %s58 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  br label %merge13
merge13:
  %t59 = phi i1 [ 0, %then11 ], [ %t54, %else12 ]
  store i1 %t59, i1* %l6
  br label %loop.latch2
merge10:
  %t60 = load double, double* %l8
  %s61 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.61, i32 0, i32 0
  %t62 = load double, double* %l8
  %s63 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.63, i32 0, i32 0
  %t64 = load double, double* %l8
  %s65 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.65, i32 0, i32 0
  %t66 = load double, double* %l8
  %s67 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.67, i32 0, i32 0
  %t68 = load double, double* %l8
  %s69 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.69, i32 0, i32 0
  %t70 = load double, double* %l8
  %s71 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.71, i32 0, i32 0
  %t72 = load double, double* %l8
  %s73 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.73, i32 0, i32 0
  %t74 = load double, double* %l8
  %s75 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.75, i32 0, i32 0
  %t76 = load double, double* %l8
  %t77 = load double, double* %l8
  %t78 = load double, double* %l8
  %s79 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.79, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t80 = load i1, i1* %l6
  br label %loop.header0
afterloop3:
  %t82 = sitofp i64 -1 to double
  ret double %t82
}

define %StructLiteralParse @parse_struct_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i1
  %l10 = alloca double
  %l11 = alloca i8*
  %l12 = alloca { %StructLiteralField*, i64 }*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = call double @is_identifier_start_char(double %t7)
  %t9 = fcmp one double %t8, 0.0
  %t10 = load i8*, i8** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then0, label %merge1
then0:
  %t13 = insertvalue %StructLiteralParse undef, i1 0, 0
  %t14 = insertvalue %StructLiteralParse %t13, i1 0, 1
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  %t16 = insertvalue %StructLiteralParse %t14, i8* %s15, 2
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  %t22 = insertvalue %StructLiteralParse %t16, { i8**, i64 }* null, 3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = insertvalue %StructLiteralParse %t22, { i8**, i64 }* %t23, 4
  ret %StructLiteralParse %t24
merge1:
  %t25 = sitofp i64 0 to double
  store double %t25, double* %l3
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l4
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l5
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l6
  %t29 = sitofp i64 -1 to double
  store double %t29, double* %l7
  %t30 = load i8*, i8** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load double, double* %l6
  %t37 = load double, double* %l7
  br label %loop.header2
loop.header2:
  br label %loop.body3
loop.body3:
  %t38 = load double, double* %l6
  %t39 = load i8*, i8** %l0
  store double 0.0, double* %l8
  %t40 = load double, double* %l8
  %s41 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.41, i32 0, i32 0
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  %t42 = load double, double* %l7
  %t43 = sitofp i64 0 to double
  %t44 = fcmp olt double %t42, %t43
  %t45 = load i8*, i8** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load double, double* %l2
  %t48 = load double, double* %l3
  %t49 = load double, double* %l4
  %t50 = load double, double* %l5
  %t51 = load double, double* %l6
  %t52 = load double, double* %l7
  br i1 %t44, label %then6, label %merge7
then6:
  %t53 = insertvalue %StructLiteralParse undef, i1 0, 0
  %t54 = insertvalue %StructLiteralParse %t53, i1 0, 1
  %s55 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.55, i32 0, i32 0
  %t56 = insertvalue %StructLiteralParse %t54, i8* %s55, 2
  %t57 = alloca [0 x double]
  %t58 = getelementptr [0 x double], [0 x double]* %t57, i32 0, i32 0
  %t59 = alloca { double*, i64 }
  %t60 = getelementptr { double*, i64 }, { double*, i64 }* %t59, i32 0, i32 0
  store double* %t58, double** %t60
  %t61 = getelementptr { double*, i64 }, { double*, i64 }* %t59, i32 0, i32 1
  store i64 0, i64* %t61
  %t62 = insertvalue %StructLiteralParse %t56, { i8**, i64 }* null, 3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %StructLiteralParse %t62, { i8**, i64 }* %t63, 4
  ret %StructLiteralParse %t64
merge7:
  store i1 0, i1* %l9
  %t65 = load i8*, i8** %l0
  %t66 = load double, double* %l7
  %t67 = call double @find_matching_closing_brace(i8* %t65, double %t66)
  store double %t67, double* %l10
  %t68 = load double, double* %l10
  %t69 = sitofp i64 0 to double
  %t70 = fcmp olt double %t68, %t69
  %t71 = load i8*, i8** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load double, double* %l4
  %t76 = load double, double* %l5
  %t77 = load double, double* %l6
  %t78 = load double, double* %l7
  %t79 = load i1, i1* %l9
  %t80 = load double, double* %l10
  br i1 %t70, label %then8, label %merge9
then8:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s82 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.82, i32 0, i32 0
  %t83 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t81, i8* %s82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l1
  store i1 1, i1* %l9
  br label %merge9
merge9:
  %t84 = phi { i8**, i64 }* [ %t83, %then8 ], [ %t72, %entry ]
  %t85 = phi i1 [ 1, %then8 ], [ %t79, %entry ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  store i1 %t85, i1* %l9
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l7
  %t88 = call double @substring(i8* %t86, i64 0, double %t87)
  %t89 = call i8* @trim_text(i8* null)
  store i8* %t89, i8** %l11
  %t90 = load i8*, i8** %l11
  %t91 = alloca [0 x double]
  %t92 = getelementptr [0 x double], [0 x double]* %t91, i32 0, i32 0
  %t93 = alloca { double*, i64 }
  %t94 = getelementptr { double*, i64 }, { double*, i64 }* %t93, i32 0, i32 0
  store double* %t92, double** %t94
  %t95 = getelementptr { double*, i64 }, { double*, i64 }* %t93, i32 0, i32 1
  store i64 0, i64* %t95
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  %t96 = load i1, i1* %l9
  %t97 = load i8*, i8** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load double, double* %l2
  %t100 = load double, double* %l3
  %t101 = load double, double* %l4
  %t102 = load double, double* %l5
  %t103 = load double, double* %l6
  %t104 = load double, double* %l7
  %t105 = load i1, i1* %l9
  %t106 = load double, double* %l10
  %t107 = load i8*, i8** %l11
  %t108 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br i1 %t96, label %then10, label %merge11
then10:
  %t109 = alloca [0 x double]
  %t110 = getelementptr [0 x double], [0 x double]* %t109, i32 0, i32 0
  %t111 = alloca { double*, i64 }
  %t112 = getelementptr { double*, i64 }, { double*, i64 }* %t111, i32 0, i32 0
  store double* %t110, double** %t112
  %t113 = getelementptr { double*, i64 }, { double*, i64 }* %t111, i32 0, i32 1
  store i64 0, i64* %t113
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  br label %merge11
merge11:
  %t114 = phi { %StructLiteralField*, i64 }* [ null, %then10 ], [ %t108, %entry ]
  store { %StructLiteralField*, i64 }* %t114, { %StructLiteralField*, i64 }** %l12
  %t115 = insertvalue %StructLiteralParse undef, i1 1, 0
  %t116 = insertvalue %StructLiteralParse %t115, i1 false, 1
  %t117 = load i8*, i8** %l11
  %t118 = insertvalue %StructLiteralParse %t116, i8* %t117, 2
  %t119 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t120 = insertvalue %StructLiteralParse %t118, { i8**, i64 }* null, 3
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = insertvalue %StructLiteralParse %t120, { i8**, i64 }* %t121, 4
  ret %StructLiteralParse %t122
}

define %EnumLiteralParse @parse_enum_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i1
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca { %StructLiteralField*, i64 }*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = call double @is_identifier_start_char(double %t7)
  %t9 = fcmp one double %t8, 0.0
  %t10 = load i8*, i8** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then0, label %merge1
then0:
  %t13 = insertvalue %EnumLiteralParse undef, i1 0, 0
  %t14 = insertvalue %EnumLiteralParse %t13, i1 0, 1
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  %t16 = insertvalue %EnumLiteralParse %t14, i8* %s15, 2
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.17, i32 0, i32 0
  %t18 = insertvalue %EnumLiteralParse %t16, i8* %s17, 3
  %t19 = alloca [0 x double]
  %t20 = getelementptr [0 x double], [0 x double]* %t19, i32 0, i32 0
  %t21 = alloca { double*, i64 }
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t21, i32 0, i32 0
  store double* %t20, double** %t22
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  %t24 = insertvalue %EnumLiteralParse %t18, { i8**, i64 }* null, 4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = insertvalue %EnumLiteralParse %t24, { i8**, i64 }* %t25, 5
  ret %EnumLiteralParse %t26
merge1:
  %t27 = load i8*, i8** %l0
  %s28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.28, i32 0, i32 0
  %t29 = call double @index_of(i8* %t27, i8* %s28)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = sitofp i64 0 to double
  %t32 = fcmp olt double %t30, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then2, label %merge3
then2:
  %t37 = insertvalue %EnumLiteralParse undef, i1 0, 0
  %t38 = insertvalue %EnumLiteralParse %t37, i1 0, 1
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.39, i32 0, i32 0
  %t40 = insertvalue %EnumLiteralParse %t38, i8* %s39, 2
  %s41 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.41, i32 0, i32 0
  %t42 = insertvalue %EnumLiteralParse %t40, i8* %s41, 3
  %t43 = alloca [0 x double]
  %t44 = getelementptr [0 x double], [0 x double]* %t43, i32 0, i32 0
  %t45 = alloca { double*, i64 }
  %t46 = getelementptr { double*, i64 }, { double*, i64 }* %t45, i32 0, i32 0
  store double* %t44, double** %t46
  %t47 = getelementptr { double*, i64 }, { double*, i64 }* %t45, i32 0, i32 1
  store i64 0, i64* %t47
  %t48 = insertvalue %EnumLiteralParse %t42, { i8**, i64 }* null, 4
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = insertvalue %EnumLiteralParse %t48, { i8**, i64 }* %t49, 5
  ret %EnumLiteralParse %t50
merge3:
  %t51 = load i8*, i8** %l0
  %t52 = load double, double* %l3
  %t53 = call double @substring(i8* %t51, i64 0, double %t52)
  %t54 = call i8* @trim_text(i8* null)
  store i8* %t54, i8** %l4
  %t55 = load i8*, i8** %l4
  %t56 = sitofp i64 0 to double
  store double %t56, double* %l5
  %t57 = sitofp i64 0 to double
  store double %t57, double* %l6
  %t58 = sitofp i64 0 to double
  store double %t58, double* %l7
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l8
  %t62 = sitofp i64 -1 to double
  store double %t62, double* %l9
  %t63 = load i8*, i8** %l0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = load double, double* %l2
  %t66 = load double, double* %l3
  %t67 = load i8*, i8** %l4
  %t68 = load double, double* %l5
  %t69 = load double, double* %l6
  %t70 = load double, double* %l7
  %t71 = load double, double* %l8
  %t72 = load double, double* %l9
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t73 = load double, double* %l8
  %t74 = load i8*, i8** %l0
  store double 0.0, double* %l10
  %t75 = load double, double* %l10
  %s76 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.76, i32 0, i32 0
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t77 = load double, double* %l9
  %t78 = sitofp i64 0 to double
  %t79 = fcmp olt double %t77, %t78
  %t80 = load i8*, i8** %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load i8*, i8** %l4
  %t85 = load double, double* %l5
  %t86 = load double, double* %l6
  %t87 = load double, double* %l7
  %t88 = load double, double* %l8
  %t89 = load double, double* %l9
  br i1 %t79, label %then8, label %merge9
then8:
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l3
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  %t94 = load i8*, i8** %l0
  store double 0.0, double* %l11
  %t95 = load double, double* %l11
  %t96 = insertvalue %EnumLiteralParse undef, i1 1, 0
  %t97 = insertvalue %EnumLiteralParse %t96, i1 1, 1
  %t98 = load i8*, i8** %l4
  %t99 = insertvalue %EnumLiteralParse %t97, i8* %t98, 2
  %t100 = load double, double* %l11
  %t101 = insertvalue %EnumLiteralParse %t99, i8* null, 3
  %t102 = alloca [0 x double]
  %t103 = getelementptr [0 x double], [0 x double]* %t102, i32 0, i32 0
  %t104 = alloca { double*, i64 }
  %t105 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 0
  store double* %t103, double** %t105
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  %t107 = insertvalue %EnumLiteralParse %t101, { i8**, i64 }* null, 4
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t109 = insertvalue %EnumLiteralParse %t107, { i8**, i64 }* %t108, 5
  ret %EnumLiteralParse %t109
merge9:
  store i1 0, i1* %l12
  %t110 = load i8*, i8** %l0
  %t111 = load double, double* %l9
  %t112 = call double @find_matching_closing_brace(i8* %t110, double %t111)
  store double %t112, double* %l13
  %t113 = load double, double* %l13
  %t114 = sitofp i64 0 to double
  %t115 = fcmp olt double %t113, %t114
  %t116 = load i8*, i8** %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load double, double* %l2
  %t119 = load double, double* %l3
  %t120 = load i8*, i8** %l4
  %t121 = load double, double* %l5
  %t122 = load double, double* %l6
  %t123 = load double, double* %l7
  %t124 = load double, double* %l8
  %t125 = load double, double* %l9
  %t126 = load i1, i1* %l12
  %t127 = load double, double* %l13
  br i1 %t115, label %then10, label %merge11
then10:
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s129 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.129, i32 0, i32 0
  %t130 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t128, i8* %s129)
  store { i8**, i64 }* %t130, { i8**, i64 }** %l1
  store i1 1, i1* %l12
  br label %merge11
merge11:
  %t131 = phi { i8**, i64 }* [ %t130, %then10 ], [ %t117, %entry ]
  %t132 = phi i1 [ 1, %then10 ], [ %t126, %entry ]
  store { i8**, i64 }* %t131, { i8**, i64 }** %l1
  store i1 %t132, i1* %l12
  %t133 = load i8*, i8** %l0
  %t134 = load double, double* %l3
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  %t137 = load double, double* %l9
  %t138 = call double @substring(i8* %t133, double %t136, double %t137)
  %t139 = call i8* @trim_text(i8* null)
  store i8* %t139, i8** %l14
  %t140 = load i8*, i8** %l14
  %t141 = alloca [0 x double]
  %t142 = getelementptr [0 x double], [0 x double]* %t141, i32 0, i32 0
  %t143 = alloca { double*, i64 }
  %t144 = getelementptr { double*, i64 }, { double*, i64 }* %t143, i32 0, i32 0
  store double* %t142, double** %t144
  %t145 = getelementptr { double*, i64 }, { double*, i64 }* %t143, i32 0, i32 1
  store i64 0, i64* %t145
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  %t146 = load i1, i1* %l12
  %t147 = load i8*, i8** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load double, double* %l2
  %t150 = load double, double* %l3
  %t151 = load i8*, i8** %l4
  %t152 = load double, double* %l5
  %t153 = load double, double* %l6
  %t154 = load double, double* %l7
  %t155 = load double, double* %l8
  %t156 = load double, double* %l9
  %t157 = load i1, i1* %l12
  %t158 = load double, double* %l13
  %t159 = load i8*, i8** %l14
  %t160 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br i1 %t146, label %then12, label %merge13
then12:
  %t161 = alloca [0 x double]
  %t162 = getelementptr [0 x double], [0 x double]* %t161, i32 0, i32 0
  %t163 = alloca { double*, i64 }
  %t164 = getelementptr { double*, i64 }, { double*, i64 }* %t163, i32 0, i32 0
  store double* %t162, double** %t164
  %t165 = getelementptr { double*, i64 }, { double*, i64 }* %t163, i32 0, i32 1
  store i64 0, i64* %t165
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %merge13
merge13:
  %t166 = phi { %StructLiteralField*, i64 }* [ null, %then12 ], [ %t160, %entry ]
  store { %StructLiteralField*, i64 }* %t166, { %StructLiteralField*, i64 }** %l15
  %t167 = insertvalue %EnumLiteralParse undef, i1 1, 0
  %t168 = insertvalue %EnumLiteralParse %t167, i1 false, 1
  %t169 = load i8*, i8** %l4
  %t170 = insertvalue %EnumLiteralParse %t168, i8* %t169, 2
  %t171 = load i8*, i8** %l14
  %t172 = insertvalue %EnumLiteralParse %t170, i8* %t171, 3
  %t173 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t174 = insertvalue %EnumLiteralParse %t172, { i8**, i64 }* null, 4
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t176 = insertvalue %EnumLiteralParse %t174, { i8**, i64 }* %t175, 5
  ret %EnumLiteralParse %t176
}

define %ExpressionResult @lower_struct_literal(%StructLiteralParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca { %StringConstant*, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca i8*
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca %LLVMOperand
  %t0 = extractvalue %StructLiteralParse %parse, 4
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l3
  %t6 = extractvalue %StructLiteralParse %parse, 2
  %t7 = call double @resolve_struct_info_for_literal(%TypeContext %context, i8* %t6)
  store double %t7, double* %l4
  %t8 = load double, double* %l4
  %t9 = load double, double* %l4
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l6
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l7
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t21 = load double, double* %l4
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t23 = load i8*, i8** %l6
  %t24 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t112 = phi { i8**, i64 }* [ %t17, %entry ], [ %t107, %loop.latch2 ]
  %t113 = phi { i8**, i64 }* [ %t18, %entry ], [ %t108, %loop.latch2 ]
  %t114 = phi double [ %t19, %entry ], [ %t109, %loop.latch2 ]
  %t115 = phi { %StringConstant*, i64 }* [ %t20, %entry ], [ %t110, %loop.latch2 ]
  %t116 = phi i8* [ %t23, %entry ], [ %t111, %loop.latch2 ]
  store { i8**, i64 }* %t112, { i8**, i64 }** %l0
  store { i8**, i64 }* %t113, { i8**, i64 }** %l1
  store double %t114, double* %l2
  store { %StringConstant*, i64 }* %t115, { %StringConstant*, i64 }** %l3
  store i8* %t116, i8** %l6
  br label %loop.body1
loop.body1:
  %t25 = load double, double* %l7
  %t26 = load double, double* %l4
  store double 0.0, double* %l8
  %t27 = sitofp i64 -1 to double
  store double %t27, double* %l9
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l10
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t33 = load double, double* %l4
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t35 = load i8*, i8** %l6
  %t36 = load double, double* %l7
  %t37 = load double, double* %l8
  %t38 = load double, double* %l9
  %t39 = load double, double* %l10
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t40 = load double, double* %l10
  %t41 = extractvalue %StructLiteralParse %parse, 3
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  store double 0.0, double* %l11
  %t42 = load double, double* %l9
  %t43 = sitofp i64 0 to double
  %t44 = fcmp oge double %t42, %t43
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load double, double* %l2
  %t48 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t49 = load double, double* %l4
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t51 = load i8*, i8** %l6
  %t52 = load double, double* %l7
  %t53 = load double, double* %l8
  %t54 = load double, double* %l9
  %t55 = load double, double* %l10
  %t56 = load double, double* %l11
  br i1 %t44, label %then8, label %else9
then8:
  store double 0.0, double* %l12
  %t57 = load double, double* %l12
  %t58 = load double, double* %l2
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l13
  %t60 = load double, double* %l13
  %t61 = load double, double* %l13
  %t62 = load double, double* %l13
  %t63 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t64 = load double, double* %l13
  %t65 = load double, double* %l13
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t67 = load double, double* %l8
  br label %merge10
else9:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s69 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.69, i32 0, i32 0
  %t70 = load double, double* %l4
  br label %merge10
merge10:
  %t71 = phi { i8**, i64 }* [ null, %then8 ], [ null, %else9 ]
  %t72 = phi { i8**, i64 }* [ null, %then8 ], [ %t46, %else9 ]
  %t73 = phi double [ 0.0, %then8 ], [ %t47, %else9 ]
  %t74 = phi { %StringConstant*, i64 }* [ null, %then8 ], [ %t48, %else9 ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  store double %t73, double* %l2
  store { %StringConstant*, i64 }* %t74, { %StringConstant*, i64 }** %l3
  %t75 = load double, double* %l8
  store i8* null, i8** %l14
  %t76 = load double, double* %l11
  %s77 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.77, i32 0, i32 0
  store i8* %s77, i8** %l15
  %t78 = load double, double* %l7
  %t79 = sitofp i64 0 to double
  %t80 = fcmp ogt double %t78, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load double, double* %l2
  %t84 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t85 = load double, double* %l4
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t87 = load i8*, i8** %l6
  %t88 = load double, double* %l7
  %t89 = load double, double* %l8
  %t90 = load double, double* %l9
  %t91 = load double, double* %l10
  %t92 = load double, double* %l11
  %t93 = load i8*, i8** %l14
  %t94 = load i8*, i8** %l15
  br i1 %t80, label %then11, label %merge12
then11:
  %t95 = load i8*, i8** %l6
  store i8* %t95, i8** %l15
  br label %merge12
merge12:
  %t96 = phi i8* [ %t95, %then11 ], [ %t94, %loop.body1 ]
  store i8* %t96, i8** %l15
  %t97 = load double, double* %l2
  %t98 = call i8* @format_temp_name(double %t97)
  store i8* %t98, i8** %l16
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s100 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.100, i32 0, i32 0
  %t101 = load i8*, i8** %l16
  %t102 = add i8* %s100, %t101
  %s103 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.103, i32 0, i32 0
  %t104 = add i8* %t102, %s103
  %t105 = load double, double* %l4
  %t106 = load i8*, i8** %l16
  store i8* %t106, i8** %l6
  br label %loop.latch2
loop.latch2:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t109 = load double, double* %l2
  %t110 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t111 = load i8*, i8** %l6
  br label %loop.header0
afterloop3:
  %t117 = sitofp i64 0 to double
  store double %t117, double* %l17
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load double, double* %l2
  %t121 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t122 = load double, double* %l4
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t124 = load i8*, i8** %l6
  %t125 = load double, double* %l7
  %t126 = load double, double* %l17
  br label %loop.header13
loop.header13:
  br label %loop.body14
loop.body14:
  %t127 = load double, double* %l17
  %t128 = extractvalue %StructLiteralParse %parse, 3
  store double 0.0, double* %l18
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t130 = load double, double* %l18
  br label %loop.latch15
loop.latch15:
  br label %loop.header13
afterloop16:
  %t131 = load i8*, i8** %l6
  %t132 = load double, double* %l4
  %t133 = insertvalue %LLVMOperand undef, i8* null, 0
  %t134 = load i8*, i8** %l6
  %t135 = insertvalue %LLVMOperand %t133, i8* %t134, 1
  store %LLVMOperand %t135, %LLVMOperand* %l19
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t137 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t136, 0
  %t138 = load double, double* %l2
  %t139 = insertvalue %ExpressionResult %t137, double %t138, 1
  %t140 = load %LLVMOperand, %LLVMOperand* %l19
  %t141 = insertvalue %ExpressionResult %t139, i8* null, 2
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = insertvalue %ExpressionResult %t141, { i8**, i64 }* %t142, 3
  %t144 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t145 = insertvalue %ExpressionResult %t143, { i8**, i64 }* null, 4
  ret %ExpressionResult %t145
}

define %HeapBoxResult @box_aggregate_operand(%LLVMOperand %operand, i8* %expected_pointer_type, double %temp_index, { i8**, i64 }* %lines, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t5 = extractvalue %LLVMOperand %operand, 0
  %t6 = call double @lookup_allocation_info(%TypeContext %context, i8* %t5)
  store double %t6, double* %l3
  %t7 = load double, double* %l3
  %t8 = load double, double* %l3
  %t9 = load double, double* %l2
  %t10 = call i8* @format_temp_name(double %t9)
  store i8* %t10, i8** %l4
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = load i8*, i8** %l4
  %t14 = add i8* %s12, %t13
  %t15 = load double, double* %l2
  %t16 = call i8* @format_temp_name(double %t15)
  store i8* %t16, i8** %l5
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l5
  %t20 = add i8* %s18, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s22 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.22, i32 0, i32 0
  %t23 = extractvalue %LLVMOperand %operand, 0
  %t24 = add i8* %s22, %t23
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  %t26 = add i8* %t24, %s25
  %t27 = extractvalue %LLVMOperand %operand, 1
  %t28 = add i8* %t26, %t27
  store double 0.0, double* %l6
  %t29 = call i8* @trim_text(i8* %expected_pointer_type)
  store i8* %t29, i8** %l7
  %t30 = load i8*, i8** %l7
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = insertvalue %HeapBoxResult undef, { i8**, i64 }* %t31, 0
  %t33 = load double, double* %l2
  %t34 = insertvalue %HeapBoxResult %t32, double %t33, 1
  %t35 = load double, double* %l6
  %t36 = insertvalue %HeapBoxResult %t34, i8* null, 2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = insertvalue %HeapBoxResult %t36, { i8**, i64 }* %t37, 3
  ret %HeapBoxResult %t38
}

define %ExpressionResult @lower_enum_literal(%EnumLiteralParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %LLVMOperand
  %t0 = extractvalue %EnumLiteralParse %parse, 5
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  %t1 = extractvalue %EnumLiteralParse %parse, 2
  %t2 = call double @resolve_enum_info_for_literal(%TypeContext %context, i8* %t1)
  store double %t2, double* %l3
  %t3 = load double, double* %l3
  %t4 = load double, double* %l3
  %t5 = extractvalue %EnumLiteralParse %parse, 3
  %t6 = call double @resolve_enum_variant_info(%EnumTypeInfo zeroinitializer, i8* %t5)
  store double %t6, double* %l4
  %t7 = load double, double* %l4
  %s8 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load double, double* %l3
  %t10 = load double, double* %l3
  %t11 = load double, double* %l3
  %t12 = load double, double* %l3
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  store i8* %s13, i8** %l6
  store double 0.0, double* %l7
  %t14 = load double, double* %l4
  %t15 = load double, double* %l4
  %t16 = load double, double* %l3
  %t17 = insertvalue %LLVMOperand undef, i8* null, 0
  %t18 = load i8*, i8** %l6
  %t19 = insertvalue %LLVMOperand %t17, i8* %t18, 1
  store %LLVMOperand %t19, %LLVMOperand* %l8
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t20, 0
  %t22 = load double, double* %l2
  %t23 = insertvalue %ExpressionResult %t21, double %t22, 1
  %t24 = load %LLVMOperand, %LLVMOperand* %l8
  %t25 = insertvalue %ExpressionResult %t23, i8* null, 2
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = insertvalue %ExpressionResult %t25, { i8**, i64 }* %t26, 3
  %t28 = alloca [0 x double]
  %t29 = getelementptr [0 x double], [0 x double]* %t28, i32 0, i32 0
  %t30 = alloca { double*, i64 }
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t30, i32 0, i32 0
  store double* %t29, double** %t31
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  %t33 = insertvalue %ExpressionResult %t27, { i8**, i64 }* null, 4
  ret %ExpressionResult %t33
}

define %ComparisonEmission @emit_comparison_instruction(i8* %symbol, %LLVMOperand %left_operand, %LLVMOperand %right_operand, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca %LLVMOperand
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  %t5 = extractvalue %LLVMOperand %left_operand, 0
  %t6 = extractvalue %LLVMOperand %right_operand, 0
  %t7 = extractvalue %LLVMOperand %left_operand, 0
  store i8* %t7, i8** %l2
  %t8 = load i8*, i8** %l2
  %t9 = call i8* @comparison_predicate_for_symbol(i8* %symbol, i8* %t8)
  store i8* %t9, i8** %l3
  %t10 = load i8*, i8** %l3
  %t11 = call i8* @format_temp_name(double %temp_index)
  store i8* %t11, i8** %l4
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8*, i8** %l4
  %t15 = add i8* %s13, %t14
  %s16 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.16, i32 0, i32 0
  %t17 = add i8* %t15, %s16
  %t18 = load i8*, i8** %l3
  %t19 = add i8* %t17, %t18
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = add i8* %t19, %s20
  %t22 = load i8*, i8** %l2
  %t23 = add i8* %t21, %t22
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  %t25 = add i8* %t23, %s24
  %t26 = extractvalue %LLVMOperand %left_operand, 1
  %t27 = add i8* %t25, %t26
  %s28 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.28, i32 0, i32 0
  %t29 = insertvalue %LLVMOperand undef, i8* %s28, 0
  %t30 = load i8*, i8** %l4
  %t31 = insertvalue %LLVMOperand %t29, i8* %t30, 1
  store %LLVMOperand %t31, %LLVMOperand* %l5
  ret %ComparisonEmission zeroinitializer
}

define %ComparisonEmission @emit_boolean_and(%LLVMOperand %left_operand, %LLVMOperand %right_operand, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca %LLVMOperand
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  %t5 = extractvalue %LLVMOperand %left_operand, 0
  %s6 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.6, i32 0, i32 0
  %t7 = extractvalue %LLVMOperand %right_operand, 0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %t9 = call i8* @format_temp_name(double %temp_index)
  store i8* %t9, i8** %l2
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8*, i8** %l2
  %t13 = add i8* %s11, %t12
  %s14 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  %t16 = extractvalue %LLVMOperand %left_operand, 1
  %t17 = add i8* %t15, %t16
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = insertvalue %LLVMOperand undef, i8* %s18, 0
  %t20 = load i8*, i8** %l2
  %t21 = insertvalue %LLVMOperand %t19, i8* %t20, 1
  store %LLVMOperand %t21, %LLVMOperand* %l3
  ret %ComparisonEmission zeroinitializer
}

define i8* @comparison_predicate_for_symbol(i8* %symbol, i8* %llvm_type) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
}

define { i8**, i64 }* @collect_parameter_types(%TypeContext %context, double %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t10
}

define %LoadLocalResult @load_local_operand(%LocalBinding %local, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %LLVMOperand
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call i8* @format_temp_name(double %temp_index)
  store i8* %t5, i8** %l1
  store { i8**, i64 }* %lines, { i8**, i64 }** %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = load i8*, i8** %l1
  %t9 = add i8* %s7, %t8
  %s10 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  %t12 = extractvalue %LocalBinding %local, 2
  %t13 = add i8* %t11, %t12
  %t14 = extractvalue %LocalBinding %local, 2
  %t15 = insertvalue %LLVMOperand undef, i8* %t14, 0
  %t16 = load i8*, i8** %l1
  %t17 = insertvalue %LLVMOperand %t15, i8* %t16, 1
  store %LLVMOperand %t17, %LLVMOperand* %l3
  ret %LoadLocalResult zeroinitializer
}

define %CoercionResult @coerce_operand_to_type(%LLVMOperand %operand, i8* %target_type, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  %t5 = extractvalue %LLVMOperand %operand, 0
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.6, i32 0, i32 0
  %s7 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.7, i32 0, i32 0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s10 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.10, i32 0, i32 0
  %t11 = extractvalue %LLVMOperand %operand, 0
  %t12 = add i8* %s10, %t11
  %s13 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  %t15 = add i8* %t14, %target_type
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = add i8* %t15, %s16
  %t18 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t9, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = insertvalue %CoercionResult undef, { i8**, i64 }* %t19, 0
  %t21 = insertvalue %CoercionResult %t20, double %temp_index, 1
  %t22 = insertvalue %CoercionResult %t21, i8* null, 2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = insertvalue %CoercionResult %t22, { i8**, i64 }* %t23, 3
  ret %CoercionResult %t24
}

define i8* @dominant_type(i8* %first, i8* %second) {
entry:
  ret i8* %first
}

define %BinaryAlignmentResult @harmonise_operands(%LLVMOperand %left, %LLVMOperand %right, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %LLVMOperand
  %l4 = alloca %LLVMOperand
  %l5 = alloca i8*
  %l6 = alloca %CoercionResult
  %l7 = alloca %CoercionResult
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store { i8**, i64 }* %lines, { i8**, i64 }** %l1
  store double %temp_index, double* %l2
  store %LLVMOperand %left, %LLVMOperand* %l3
  store %LLVMOperand %right, %LLVMOperand* %l4
  %t5 = load %LLVMOperand, %LLVMOperand* %l3
  %t6 = extractvalue %LLVMOperand %t5, 0
  %t7 = load %LLVMOperand, %LLVMOperand* %l4
  %t8 = extractvalue %LLVMOperand %t7, 0
  %t9 = load %LLVMOperand, %LLVMOperand* %l3
  %t10 = extractvalue %LLVMOperand %t9, 0
  %t11 = load %LLVMOperand, %LLVMOperand* %l4
  %t12 = extractvalue %LLVMOperand %t11, 0
  %t13 = call i8* @dominant_type(i8* %t10, i8* %t12)
  store i8* %t13, i8** %l5
  %t14 = load %LLVMOperand, %LLVMOperand* %l3
  %t15 = load i8*, i8** %l5
  %t16 = load double, double* %l2
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand %t14, i8* %t15, double %t16, { i8**, i64 }* %t17)
  store %CoercionResult %t18, %CoercionResult* %l6
  %t19 = load %CoercionResult, %CoercionResult* %l6
  %t20 = extractvalue %CoercionResult %t19, 3
  %t21 = call double @diagnosticsconcat({ i8**, i64 }* %t20)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t22 = load %CoercionResult, %CoercionResult* %l6
  %t23 = extractvalue %CoercionResult %t22, 2
  %t24 = load %CoercionResult, %CoercionResult* %l6
  %t25 = extractvalue %CoercionResult %t24, 2
  store %LLVMOperand zeroinitializer, %LLVMOperand* %l3
  %t26 = load %CoercionResult, %CoercionResult* %l6
  %t27 = extractvalue %CoercionResult %t26, 0
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = load %CoercionResult, %CoercionResult* %l6
  %t29 = extractvalue %CoercionResult %t28, 1
  store double %t29, double* %l2
  %t30 = load %LLVMOperand, %LLVMOperand* %l4
  %t31 = load i8*, i8** %l5
  %t32 = load double, double* %l2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand %t30, i8* %t31, double %t32, { i8**, i64 }* %t33)
  store %CoercionResult %t34, %CoercionResult* %l7
  %t35 = load %CoercionResult, %CoercionResult* %l7
  %t36 = extractvalue %CoercionResult %t35, 3
  %t37 = call double @diagnosticsconcat({ i8**, i64 }* %t36)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t38 = load %CoercionResult, %CoercionResult* %l7
  %t39 = extractvalue %CoercionResult %t38, 2
  %t40 = load %CoercionResult, %CoercionResult* %l7
  %t41 = extractvalue %CoercionResult %t40, 2
  store %LLVMOperand zeroinitializer, %LLVMOperand* %l4
  %t42 = load %CoercionResult, %CoercionResult* %l7
  %t43 = extractvalue %CoercionResult %t42, 0
  store { i8**, i64 }* %t43, { i8**, i64 }** %l1
  %t44 = load %CoercionResult, %CoercionResult* %l7
  %t45 = extractvalue %CoercionResult %t44, 1
  store double %t45, double* %l2
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = insertvalue %BinaryAlignmentResult undef, { i8**, i64 }* %t46, 0
  %t48 = load double, double* %l2
  %t49 = insertvalue %BinaryAlignmentResult %t47, double %t48, 1
  %t50 = load %LLVMOperand, %LLVMOperand* %l3
  %t51 = insertvalue %BinaryAlignmentResult %t49, i8* null, 2
  %t52 = load %LLVMOperand, %LLVMOperand* %l4
  %t53 = insertvalue %BinaryAlignmentResult %t51, i8* null, 3
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = insertvalue %BinaryAlignmentResult %t53, { i8**, i64 }* %t54, 4
  %t56 = load i8*, i8** %l5
  %t57 = insertvalue %BinaryAlignmentResult %t55, i8* %t56, 5
  ret %BinaryAlignmentResult %t57
}

define i8* @strip_enclosing_parentheses(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l2
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l2
  %t8 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t9 = load double, double* %l3
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t11 = load i8*, i8** %l0
  ret i8* %t11
}

define %OperatorMatch @find_top_level_operator(i8* %expression, i8* %operators) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = sitofp i64 0 to double
  %t5 = fcmp ole double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l2
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = load double, double* %l0
  %t14 = sitofp i64 0 to double
  %t15 = fcmp ogt double %t13, %t14
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t19 = load double, double* %l2
  %t20 = call i1 @contains_char(i8* %operators, i8* null)
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then8, label %merge9
then8:
  %t24 = load double, double* %l2
  %t25 = load double, double* %l1
  %t26 = insertvalue %OperatorMatch undef, double %t25, 0
  %t27 = load double, double* %l1
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  %t31 = call double @substring(i8* %expression, double %t27, double %t30)
  %t32 = insertvalue %OperatorMatch %t26, i8* null, 1
  %t33 = insertvalue %OperatorMatch %t32, i1 1, 2
  ret %OperatorMatch %t33
merge9:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret %OperatorMatch zeroinitializer
}

define %OperatorMatch @find_comparison_operator(i8* %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = load double, double* %l2
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = load double, double* %l0
  %t10 = sitofp i64 0 to double
  %t11 = fcmp ogt double %t9, %t10
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  br i1 %t11, label %then4, label %merge5
then4:
  br label %loop.latch2
merge5:
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  %t18 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret %OperatorMatch zeroinitializer
}

define i1 @contains_char(i8* %set, i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_binary_minus(i8* %expression, double %index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call double @find_previous_non_space_char(i8* %expression, double %index)
  store double %t0, double* %l0
  %t1 = call double @find_next_non_space_char(i8* %expression, double %index)
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  store double %t3, double* %l2
  %t4 = load double, double* %l2
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  store double %t6, double* %l3
  %t7 = load double, double* %l3
  ret i1 1
}

define double @find_call_site(i8* %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = sitofp i64 -1 to double
  ret double %t7
}

define { i8**, i64 }* @split_call_arguments(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l3
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l4
  %t10 = load i8*, i8** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load i8*, i8** %l2
  %t13 = load double, double* %l3
  %t14 = load double, double* %l4
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l4
  store double 0.0, double* %l5
  %t16 = load double, double* %l5
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load i8*, i8** %l2
  %t20 = call i8* @trim_text(i8* %t19)
  %t21 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t18, i8* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t22
}

define { i8**, i64 }* @split_array_elements(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l3
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l4
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l5
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l6
  %t12 = load i8*, i8** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t14 = load i8*, i8** %l2
  %t15 = load double, double* %l3
  %t16 = load double, double* %l4
  %t17 = load double, double* %l5
  %t18 = load double, double* %l6
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l6
  store double 0.0, double* %l7
  %t20 = load double, double* %l7
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t22 = load double, double* %l7
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t23 = load i8*, i8** %l2
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l6
  %t30 = load i8*, i8** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load double, double* %l6
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t38 = load double, double* %l6
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l9
  %t40 = load double, double* %l9
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l8
  ret { i8**, i64 }* %t41
}

define %ArrayLiteralMetadata @parse_array_literal_metadata({ i8**, i64 }* %entries, %TypeContext %context) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @substring(double %t1, i64 0, i64 9)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  %t9 = call i8* @map_metadata_annotation(%TypeContext %context, i8* null)
  store i8* %t9, i8** %l3
  %t10 = load i8*, i8** %l3
  %t11 = insertvalue %ArrayLiteralMetadata undef, i8* %t10, 0
  %t12 = sitofp i64 1 to double
  %t13 = insertvalue %ArrayLiteralMetadata %t11, double %t12, 1
  ret %ArrayLiteralMetadata %t13
}

define i8* @map_metadata_annotation(%TypeContext %context, i8* %annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @map_primitive_type(%TypeContext %context, i8* %t2)
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
}

define i8* @operation_name_for_symbol(i8* %symbol, i8* %llvm_type) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
}

define i8* @format_temp_name(double %index) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %index)
  %t2 = add i8* %s0, %t1
  ret i8* %t2
}

define i8* @format_local_pointer_name(double %index) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %index)
  %t2 = add i8* %s0, %t1
  ret i8* %t2
}

define i8* @format_typed_operand(%LLVMOperand %operand) {
entry:
  %t0 = extractvalue %LLVMOperand %operand, 0
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %t2 = add i8* %t0, %s1
  %t3 = extractvalue %LLVMOperand %operand, 1
  %t4 = add i8* %t2, %t3
  ret i8* %t4
}

define i1 @ends_with_pointer_suffix(i8* %value) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  ret i1 false
}

define i8* @strip_pointer_suffix(i8* %value) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  ret i8* null
}

define i1 @is_copy_type(i8* %type_annotation, i8* %llvm_type) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %s6 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i1 @ends_with_pointer_suffix(i8* %llvm_type)
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l0
  %s11 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i1 @starts_with(i8* %t10, i8* %s11)
  %t13 = load i8*, i8** %l0
  br i1 %t12, label %then2, label %merge3
then2:
  %t14 = load i8*, i8** %l0
  %t15 = call i8* @strip_mut_prefix(i8* %t14)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  br label %merge3
merge3:
  ret i1 0
}

define i8* @default_return_literal(i8* %llvm_type) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.2, i32 0, i32 0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @ends_with_pointer_suffix(i8* %llvm_type)
  br i1 %t4, label %then0, label %merge1
then0:
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge1:
  %s6 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
}

define i1 @starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  ret i1 false
}

define i8* @strip_mut_prefix(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = call i8* @trim_text(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call double @substring(i8* %t2, i64 0, i64 4)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.5, i32 0, i32 0
  %t6 = load i8*, i8** %l0
  ret i8* %t6
}

define i1 @is_simple_identifier(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t2 = load double, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @sanitize_symbol(i8* %t3)
  store i8* %t4, i8** %l2
  %t5 = load i8*, i8** %l2
  %t6 = load i8*, i8** %l0
  ret i1 1
}

define double @find_top_level_range_separator(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  %t7 = load double, double* %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  store double 0.0, double* %l4
  %t9 = load double, double* %l4
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l4
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = load double, double* %l4
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load double, double* %l4
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = load double, double* %l4
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load double, double* %l4
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = load double, double* %l4
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t23 = sitofp i64 -1 to double
  ret double %t23
}

define double @find_top_level_range_separator_from(i8* %value, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  %t7 = load double, double* %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  store double 0.0, double* %l4
  %t9 = load double, double* %l4
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l3
  %t12 = fcmp oge double %t11, %start_index
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  %t17 = load double, double* %l4
  br i1 %t12, label %then4, label %merge5
then4:
  %t18 = load double, double* %l4
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  br label %merge5
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t20 = sitofp i64 -1 to double
  ret double %t20
}

define double @find_member_access_separator(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i1
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  store i1 0, i1* %l5
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l6
  %t4 = sitofp i64 -1 to double
  store double %t4, double* %l7
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load i1, i1* %l3
  %t9 = load i1, i1* %l4
  %t10 = load i1, i1* %l5
  %t11 = load double, double* %l6
  %t12 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t78 = phi i1 [ %t10, %entry ], [ %t77, %loop.latch2 ]
  store i1 %t78, i1* %l5
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l6
  store double 0.0, double* %l8
  %t14 = load i1, i1* %l3
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load i1, i1* %l3
  %t19 = load i1, i1* %l4
  %t20 = load i1, i1* %l5
  %t21 = load double, double* %l6
  %t22 = load double, double* %l7
  %t23 = load double, double* %l8
  br i1 %t14, label %then4, label %merge5
then4:
  %t24 = load i1, i1* %l5
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  %t28 = load i1, i1* %l3
  %t29 = load i1, i1* %l4
  %t30 = load i1, i1* %l5
  %t31 = load double, double* %l6
  %t32 = load double, double* %l7
  %t33 = load double, double* %l8
  br i1 %t24, label %then6, label %else7
then6:
  store i1 0, i1* %l5
  br label %merge8
else7:
  %t34 = load double, double* %l8
  %s35 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.35, i32 0, i32 0
  br label %merge8
merge8:
  %t36 = phi i1 [ 0, %then6 ], [ %t30, %else7 ]
  store i1 %t36, i1* %l5
  br label %loop.latch2
merge5:
  %t37 = load i1, i1* %l4
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l2
  %t41 = load i1, i1* %l3
  %t42 = load i1, i1* %l4
  %t43 = load i1, i1* %l5
  %t44 = load double, double* %l6
  %t45 = load double, double* %l7
  %t46 = load double, double* %l8
  br i1 %t37, label %then9, label %merge10
then9:
  %t47 = load i1, i1* %l5
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load i1, i1* %l3
  %t52 = load i1, i1* %l4
  %t53 = load i1, i1* %l5
  %t54 = load double, double* %l6
  %t55 = load double, double* %l7
  %t56 = load double, double* %l8
  br i1 %t47, label %then11, label %else12
then11:
  store i1 0, i1* %l5
  br label %merge13
else12:
  %t57 = load double, double* %l8
  %s58 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  br label %merge13
merge13:
  %t59 = phi i1 [ 0, %then11 ], [ %t53, %else12 ]
  store i1 %t59, i1* %l5
  br label %loop.latch2
merge10:
  %t60 = load double, double* %l8
  %s61 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.61, i32 0, i32 0
  %t62 = load double, double* %l8
  %s63 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.63, i32 0, i32 0
  %t64 = load double, double* %l8
  %s65 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.65, i32 0, i32 0
  %t66 = load double, double* %l8
  %s67 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.67, i32 0, i32 0
  %t68 = load double, double* %l8
  %s69 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.69, i32 0, i32 0
  %t70 = load double, double* %l8
  %s71 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.71, i32 0, i32 0
  %t72 = load double, double* %l8
  %s73 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.73, i32 0, i32 0
  %t74 = load double, double* %l8
  %s75 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.75, i32 0, i32 0
  %t76 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  %t77 = load i1, i1* %l5
  br label %loop.header0
afterloop3:
  %t79 = load double, double* %l7
  ret double %t79
}

define %MemberAccessParse @parse_member_access(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call double @find_member_access_separator(i8* %t2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %MemberAccessParse undef, i1 0, 0
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  %t11 = insertvalue %MemberAccessParse %t9, i8* %s10, 1
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.12, i32 0, i32 0
  %t13 = insertvalue %MemberAccessParse %t11, i8* %s12, 2
  ret %MemberAccessParse %t13
merge1:
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = call double @substring(i8* %t14, i64 0, double %t15)
  %t17 = call i8* @trim_text(i8* null)
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  %t25 = call double @is_simple_identifier(double %t24)
  %t26 = fcmp one double %t25, 0.0
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then2, label %merge3
then2:
  %t31 = insertvalue %MemberAccessParse undef, i1 0, 0
  %s32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.32, i32 0, i32 0
  %t33 = insertvalue %MemberAccessParse %t31, i8* %s32, 1
  %s34 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.34, i32 0, i32 0
  %t35 = insertvalue %MemberAccessParse %t33, i8* %s34, 2
  ret %MemberAccessParse %t35
merge3:
  %t36 = insertvalue %MemberAccessParse undef, i1 1, 0
  %t37 = load i8*, i8** %l2
  %t38 = insertvalue %MemberAccessParse %t36, i8* %t37, 1
  %t39 = load double, double* %l3
  %t40 = insertvalue %MemberAccessParse %t38, i8* null, 2
  ret %MemberAccessParse %t40
}

define %RangeIterableParse @parse_range_iterable(i8* %iterable) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca double
  %t0 = call i8* @trim_text(i8* %iterable)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = call double @find_top_level_range_separator(i8* %t7)
  store double %t8, double* %l2
  store i1 0, i1* %l3
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  store i8* %s9, i8** %l4
  %t10 = load double, double* %l2
  %t11 = sitofp i64 0 to double
  %t12 = fcmp olt double %t10, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load double, double* %l2
  %t16 = load i1, i1* %l3
  %t17 = load i8*, i8** %l4
  br i1 %t12, label %then0, label %merge1
then0:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s19 = getelementptr inbounds [66 x i8], [66 x i8]* @.str.19, i32 0, i32 0
  %t20 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t18, i8* %s19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l1
  %t21 = insertvalue %RangeIterableParse undef, i1 0, 0
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.22, i32 0, i32 0
  %t23 = insertvalue %RangeIterableParse %t21, i8* %s22, 1
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.24, i32 0, i32 0
  %t25 = insertvalue %RangeIterableParse %t23, i8* %s24, 2
  %s26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.26, i32 0, i32 0
  %t27 = insertvalue %RangeIterableParse %t25, i8* %s26, 3
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = insertvalue %RangeIterableParse %t27, { i8**, i64 }* %t28, 4
  ret %RangeIterableParse %t29
merge1:
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l2
  %t32 = sitofp i64 2 to double
  %t33 = fadd double %t31, %t32
  %t34 = call double @find_top_level_range_separator_from(i8* %t30, double %t33)
  store double %t34, double* %l5
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l2
  %t37 = call double @substring(i8* %t35, i64 0, double %t36)
  %t38 = call i8* @trim_text(i8* null)
  store i8* %t38, i8** %l6
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l2
  %t41 = sitofp i64 2 to double
  %t42 = fadd double %t40, %t41
  %t43 = load i8*, i8** %l0
  store double 0.0, double* %l7
  %t44 = load double, double* %l5
  %t45 = sitofp i64 0 to double
  %t46 = fcmp oge double %t44, %t45
  %t47 = load i8*, i8** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load i1, i1* %l3
  %t51 = load i8*, i8** %l4
  %t52 = load double, double* %l5
  %t53 = load i8*, i8** %l6
  %t54 = load double, double* %l7
  br i1 %t46, label %then2, label %merge3
then2:
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l2
  %t57 = sitofp i64 2 to double
  %t58 = fadd double %t56, %t57
  %t59 = load double, double* %l5
  %t60 = call double @substring(i8* %t55, double %t58, double %t59)
  %t61 = call i8* @trim_text(i8* null)
  store double 0.0, double* %l7
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l5
  %t64 = sitofp i64 2 to double
  %t65 = fadd double %t63, %t64
  %t66 = load i8*, i8** %l0
  %t67 = load i8*, i8** %l4
  br label %merge3
merge3:
  %t68 = phi double [ 0.0, %then2 ], [ %t54, %entry ]
  %t69 = phi i8* [ null, %then2 ], [ %t51, %entry ]
  %t70 = phi i1 [ false, %then2 ], [ %t50, %entry ]
  store double %t68, double* %l7
  store i8* %t69, i8** %l4
  store i1 %t70, i1* %l3
  %t71 = load i8*, i8** %l6
  %t72 = load double, double* %l7
  %t73 = load i8*, i8** %l6
  store double 0.0, double* %l8
  %t74 = load double, double* %l8
  %t75 = fcmp one double %t74, 0.0
  %t76 = insertvalue %RangeIterableParse undef, i1 %t75, 0
  %t77 = load i8*, i8** %l6
  %t78 = insertvalue %RangeIterableParse %t76, i8* %t77, 1
  %t79 = load double, double* %l7
  %t80 = insertvalue %RangeIterableParse %t78, i8* null, 2
  %t81 = load i8*, i8** %l4
  %t82 = insertvalue %RangeIterableParse %t80, i8* %t81, 3
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = insertvalue %RangeIterableParse %t82, { i8**, i64 }* %t83, 4
  ret %RangeIterableParse %t84
}

define %ScopeMetadata @infer_borrow_base_scope(i8* %base, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %base)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %bindings, i8* %base)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = call i8* @format_root_scope_id(i8* %function_name)
  %t5 = insertvalue %ScopeMetadata undef, i8* %t4, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %ScopeMetadata %t5, double %t6, 1
  ret %ScopeMetadata %t7
}

define { %LifetimeRegionMetadata*, i64 }* @append_lifetime_region({ %LifetimeRegionMetadata*, i64 }* %values, %LifetimeRegionMetadata %value) {
entry:
  %t0 = alloca [1 x %LifetimeRegionMetadata]
  %t1 = getelementptr [1 x %LifetimeRegionMetadata], [1 x %LifetimeRegionMetadata]* %t0, i32 0, i32 0
  %t2 = getelementptr %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t1, i64 0
  store %LifetimeRegionMetadata %value, %LifetimeRegionMetadata* %t2
  %t3 = alloca { %LifetimeRegionMetadata*, i64 }
  %t4 = getelementptr { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %t3, i32 0, i32 0
  store %LifetimeRegionMetadata* %t1, %LifetimeRegionMetadata** %t4
  %t5 = getelementptr { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %LifetimeRegionMetadata*, i64 }* %t3)
  ret { %LifetimeRegionMetadata*, i64 }* null
}

define { %LifetimeReleaseEvent*, i64 }* @append_lifetime_release_event({ %LifetimeReleaseEvent*, i64 }* %events, %LifetimeReleaseEvent %event) {
entry:
  %t0 = alloca [1 x %LifetimeReleaseEvent]
  %t1 = getelementptr [1 x %LifetimeReleaseEvent], [1 x %LifetimeReleaseEvent]* %t0, i32 0, i32 0
  %t2 = getelementptr %LifetimeReleaseEvent, %LifetimeReleaseEvent* %t1, i64 0
  store %LifetimeReleaseEvent %event, %LifetimeReleaseEvent* %t2
  %t3 = alloca { %LifetimeReleaseEvent*, i64 }
  %t4 = getelementptr { %LifetimeReleaseEvent*, i64 }, { %LifetimeReleaseEvent*, i64 }* %t3, i32 0, i32 0
  store %LifetimeReleaseEvent* %t1, %LifetimeReleaseEvent** %t4
  %t5 = getelementptr { %LifetimeReleaseEvent*, i64 }, { %LifetimeReleaseEvent*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @eventsconcat({ %LifetimeReleaseEvent*, i64 }* %t3)
  ret { %LifetimeReleaseEvent*, i64 }* null
}

define { %LifetimeRegionMetadata*, i64 }* @mark_lifetime_region_released({ %LifetimeRegionMetadata*, i64 }* %regions, double %region_id, i8* %scope_id, double %scope_depth) {
entry:
  %l0 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  ret { %LifetimeRegionMetadata*, i64 }* %t10
}

define { %LifetimeRegionMetadata*, i64 }* @apply_lifetime_release_events({ %LifetimeRegionMetadata*, i64 }* %regions, { %LifetimeReleaseEvent*, i64 }* %releases) {
entry:
  %l0 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  store { %LifetimeRegionMetadata*, i64 }* %regions, { %LifetimeRegionMetadata*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t9 = phi { %LifetimeRegionMetadata*, i64 }* [ %t1, %entry ], [ %t8, %loop.latch2 ]
  store { %LifetimeRegionMetadata*, i64 }* %t9, { %LifetimeRegionMetadata*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  store double 0.0, double* %l2
  %t4 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t5 = load double, double* %l2
  %t6 = load double, double* %l2
  %t7 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t8 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t10 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  ret { %LifetimeRegionMetadata*, i64 }* %t10
}

define %LifetimeRegionMetadata @make_lifetime_region_metadata(double %id, i8* %binding, %OwnershipInfo %ownership, i8* %scope_id, double %scope_depth, i8* %base_scope_id, double %base_scope_depth) {
entry:
  %t0 = insertvalue %LifetimeRegionMetadata undef, double %id, 0
  %t1 = insertvalue %LifetimeRegionMetadata %t0, i8* %binding, 1
  %t2 = extractvalue %OwnershipInfo %ownership, 1
  %t3 = insertvalue %LifetimeRegionMetadata %t1, i8* %t2, 2
  %t4 = extractvalue %OwnershipInfo %ownership, 2
  %t5 = insertvalue %LifetimeRegionMetadata %t3, i1 %t4, 3
  %t6 = extractvalue %OwnershipInfo %ownership, 3
  %t7 = insertvalue %LifetimeRegionMetadata %t5, i8* %t6, 4
  %t8 = insertvalue %LifetimeRegionMetadata %t7, i8* %scope_id, 5
  %t9 = insertvalue %LifetimeRegionMetadata %t8, double %scope_depth, 6
  %t10 = insertvalue %LifetimeRegionMetadata %t9, i8* %base_scope_id, 7
  %t11 = insertvalue %LifetimeRegionMetadata %t10, double %base_scope_depth, 8
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.12, i32 0, i32 0
  %t13 = insertvalue %LifetimeRegionMetadata %t11, i8* %s12, 9
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %LifetimeRegionMetadata %t13, double %t14, 10
  %t16 = insertvalue %LifetimeRegionMetadata %t15, i1 0, 11
  ret %LifetimeRegionMetadata %t16
}

define i8* @format_root_scope_id(i8* %function_name) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @sanitize_symbol(i8* %function_name)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.2, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  %t4 = add i8* %s2, %t3
  ret i8* %t4
}

define i8* @make_child_scope_id(i8* %parent, i8* %child) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @sanitize_symbol(i8* %child)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %parent, %s2
  %t4 = load i8*, i8** %l0
  %t5 = add i8* %t3, %t4
  ret i8* %t5
}

define i1 @is_scope_descendant(i8* %parent, i8* %candidate) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %parent, %s0
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i1 @starts_with(i8* %candidate, i8* %t2)
  ret i1 %t3
}

define { %LocalBinding*, i64 }* @append_local_binding({ %LocalBinding*, i64 }* %values, %LocalBinding %value) {
entry:
  %t0 = alloca [1 x %LocalBinding]
  %t1 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t0, i32 0, i32 0
  %t2 = getelementptr %LocalBinding, %LocalBinding* %t1, i64 0
  store %LocalBinding %value, %LocalBinding* %t2
  %t3 = alloca { %LocalBinding*, i64 }
  %t4 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t3, i32 0, i32 0
  store %LocalBinding* %t1, %LocalBinding** %t4
  %t5 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %LocalBinding*, i64 }* %t3)
  ret { %LocalBinding*, i64 }* null
}

define { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %values, %LLVMOperand %value) {
entry:
  %t0 = alloca [1 x %LLVMOperand]
  %t1 = getelementptr [1 x %LLVMOperand], [1 x %LLVMOperand]* %t0, i32 0, i32 0
  %t2 = getelementptr %LLVMOperand, %LLVMOperand* %t1, i64 0
  store %LLVMOperand %value, %LLVMOperand* %t2
  %t3 = alloca { %LLVMOperand*, i64 }
  %t4 = getelementptr { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t3, i32 0, i32 0
  store %LLVMOperand* %t1, %LLVMOperand** %t4
  %t5 = getelementptr { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ %LLVMOperand*, i64 }* %t3)
  ret { %LLVMOperand*, i64 }* null
}

define { %LLVMOperand*, i64 }* @replace_llvm_operand({ %LLVMOperand*, i64 }* %values, double %index, %LLVMOperand %value) {
entry:
  %l0 = alloca { %LLVMOperand*, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi { %LLVMOperand*, i64 }* [ %t6, %entry ], [ %t17, %loop.latch2 ]
  store { %LLVMOperand*, i64 }* %t18, { %LLVMOperand*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = fcmp oeq double %t9, %index
  %t11 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %else5
then4:
  %t13 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t14 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t13, %LLVMOperand %value)
  store { %LLVMOperand*, i64 }* %t14, { %LLVMOperand*, i64 }** %l0
  br label %merge6
else5:
  %t15 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  br label %merge6
merge6:
  %t16 = phi { %LLVMOperand*, i64 }* [ %t14, %then4 ], [ null, %else5 ]
  store { %LLVMOperand*, i64 }* %t16, { %LLVMOperand*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t17 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t19 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  ret { %LLVMOperand*, i64 }* %t19
}

define i8* @number_to_string(double %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l0
  store double %value, double* %l1
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  %t7 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t42 = phi i8* [ %t7, %entry ], [ %t40, %loop.latch4 ]
  %t43 = phi double [ %t6, %entry ], [ %t41, %loop.latch4 ]
  store i8* %t42, i8** %l2
  store double %t43, double* %l1
  br label %loop.body3
loop.body3:
  %t8 = load double, double* %l1
  %t9 = sitofp i64 0 to double
  %t10 = fcmp ole double %t8, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load i8*, i8** %l2
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t14 = load double, double* %l1
  store double %t14, double* %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load i8*, i8** %l2
  %t19 = load double, double* %l3
  %t20 = load double, double* %l4
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t21 = load double, double* %l3
  %t22 = sitofp i64 10 to double
  %t23 = fcmp olt double %t21, %t22
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  br i1 %t23, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t29 = load double, double* %l3
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t30 = load double, double* %l3
  store double %t30, double* %l5
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l5
  %t33 = load double, double* %l5
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @substring(i8* %t31, double %t32, double %t35)
  store double %t36, double* %l6
  %t37 = load double, double* %l6
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l4
  store double %t39, double* %l1
  br label %loop.latch4
loop.latch4:
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t44 = load i8*, i8** %l2
  ret i8* %t44
}

define i8* @sanitize_symbol(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t14 = phi i8* [ %t2, %entry ], [ %t13, %loop.latch2 ]
  store i8* %t14, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %t6 = call i1 @is_symbol_char(i8* null)
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  br i1 %t6, label %then4, label %merge5
then4:
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l2
  br label %merge5
merge5:
  %t12 = phi i8* [ null, %then4 ], [ %t7, %loop.body1 ]
  store i8* %t12, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t13 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l0
  ret i8* %t16
}

define i1 @is_digit_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.0, i32 0, i32 0
  %t1 = call double @index_of(i8* %s0, i8* %ch)
  %t2 = sitofp i64 -1 to double
  %t3 = fcmp une double %t1, %t2
  ret i1 %t3
}

define i1 @is_symbol_char(i8* %ch) {
entry:
  %l0 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = call double @char_code(i8* %ch)
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  ret i1 0
}

define double @lower_char_code(double %code) {
entry:
  ret double %code
}

define i1 @matches_case_insensitive(i8* %value, i8* %expected) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  store double 0.0, double* %l1
  store double 0.0, double* %l2
  %t3 = load double, double* %l1
  %t4 = load double, double* %l2
  %t5 = fcmp une double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @is_boolean_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @matches_case_insensitive(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i1 @matches_case_insensitive(i8* %t5, i8* %s6)
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i1 @is_integer_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  store i1 0, i1* %l2
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  %t5 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t8 = load double, double* %l3
  ret i1 0
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = load i1, i1* %l2
  ret i1 %t9
}

define i1 @is_number_literal(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  %t1 = call i8* @trim_text(i8* %text)
  store i8* %t1, i8** %l3
  %t2 = load i8*, i8** %l3
  %t3 = load double, double* %l0
  %t4 = load i1, i1* %l1
  %t5 = load i1, i1* %l2
  %t6 = load i8*, i8** %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l0
  %t8 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t9 = load double, double* %l4
  %t10 = load double, double* %l4
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  ret i1 0
loop.latch2:
  br label %loop.header0
afterloop3:
  %t12 = load i1, i1* %l1
  ret i1 %t12
}

define i8* @normalise_number_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  %t4 = sitofp i64 0 to double
  %t5 = fcmp oge double %t3, %t4
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load i8*, i8** %l0
  ret i8* %t7
merge1:
  %t8 = load i8*, i8** %l0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %t10 = add i8* %t8, %s9
  ret i8* %t10
}

define i1 @is_string_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  ret i1 1
}

define %ExpressionResult @lower_string_literal(i8* %literal, double %temp_index, { i8**, i64 }* %lines) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca %StringConstant
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %t0 = call i8* @unescape_string_literal(i8* %literal)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @number_to_string(double %temp_index)
  %t3 = add i8* %s1, %t2
  store i8* %t3, i8** %l1
  %t4 = load i8*, i8** %l1
  %t5 = insertvalue %StringConstant undef, i8* %t4, 0
  %t6 = load i8*, i8** %l0
  %t7 = insertvalue %StringConstant %t5, i8* %t6, 1
  %t8 = load i8*, i8** %l0
  %t9 = insertvalue %StringConstant %t7, double 0.0, 2
  store %StringConstant %t9, %StringConstant* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i8* @number_to_string(double %temp_index)
  %t14 = add i8* %s12, %t13
  %s15 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.15, i32 0, i32 0
  %t16 = add i8* %t14, %s15
  %t17 = load double, double* %l3
  store double 0.0, double* %l4
  %t18 = load double, double* %l4
  %t19 = call { i8**, i64 }* @append_string({ i8**, i64 }* %lines, i8* null)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l5
  store double 0.0, double* %l6
  ret %ExpressionResult zeroinitializer
}

define i8* @unescape_string_literal(i8* %literal) {
entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  store i64 1, i64* %l0
  store double 0.0, double* %l1
  %t0 = load i64, i64* %l0
  %t1 = load double, double* %l1
  %t2 = call double @substring(i8* %literal, i64 %t0, double %t1)
  store double %t2, double* %l2
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load i64, i64* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load i8*, i8** %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t16 = phi i8* [ %t8, %entry ], [ %t15, %loop.latch2 ]
  store i8* %t16, i8** %l3
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l2
  store double 0.0, double* %l5
  %t12 = load double, double* %l5
  %t13 = load i8*, i8** %l3
  %t14 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  %t15 = load i8*, i8** %l3
  br label %loop.header0
afterloop3:
  %t17 = load i8*, i8** %l3
  ret i8* %t17
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  %t5 = fcmp oge double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  store double 0.0, double* %l2
  %t8 = load double, double* %l2
  %t9 = call i1 @is_trim_char(i8* null)
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t15 = load double, double* %l1
  %t16 = load double, double* %l0
  %t17 = fcmp ole double %t15, %t16
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t20 = load double, double* %l3
  %t21 = call i1 @is_trim_char(i8* null)
  %t22 = load double, double* %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l3
  br i1 %t21, label %then14, label %merge15
then14:
  %t25 = load double, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = call double @substring(i8* %value, double %t27, double %t28)
  ret i8* null
}

define i1 @is_trim_char(i8* %ch) {
entry:
  ret i1 false
}

define double @index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  store i1 1, i1* %l2
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  %t6 = load i1, i1* %l2
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l1
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t8 = load i1, i1* %l2
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load i1, i1* %l2
  br i1 %t8, label %then8, label %merge9
then8:
  %t12 = load double, double* %l0
  ret double %t12
merge9:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
}

define double @find_last_index_of_char(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ole double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t5 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t6 = sitofp i64 -1 to double
  ret double %t6
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

define { %MatchArmMutations*, i64 }* @append_match_arm_mutations({ %MatchArmMutations*, i64 }* %list, %MatchArmMutations %arm) {
entry:
  %t0 = alloca [1 x %MatchArmMutations]
  %t1 = getelementptr [1 x %MatchArmMutations], [1 x %MatchArmMutations]* %t0, i32 0, i32 0
  %t2 = getelementptr %MatchArmMutations, %MatchArmMutations* %t1, i64 0
  store %MatchArmMutations %arm, %MatchArmMutations* %t2
  %t3 = alloca { %MatchArmMutations*, i64 }
  %t4 = getelementptr { %MatchArmMutations*, i64 }, { %MatchArmMutations*, i64 }* %t3, i32 0, i32 0
  store %MatchArmMutations* %t1, %MatchArmMutations** %t4
  %t5 = getelementptr { %MatchArmMutations*, i64 }, { %MatchArmMutations*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @listconcat({ %MatchArmMutations*, i64 }* %t3)
  ret { %MatchArmMutations*, i64 }* null
}

define i1 @string_array_contains({ i8**, i64 }* %values, i8* %target) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 0
}

define { %ParameterBinding*, i64 }* @merge_parameter_bindings({ %ParameterBinding*, i64 }* %first, { %ParameterBinding*, i64 }* %second) {
entry:
  %l0 = alloca { %ParameterBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t13 = phi { %ParameterBinding*, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { %ParameterBinding*, i64 }* %t13, { %ParameterBinding*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  store i1 false, i1* %l3
  %t10 = load double, double* %l2
  store double 0.0, double* %l4
  %t11 = load double, double* %l4
  br label %loop.latch2
loop.latch2:
  %t12 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  ret { %ParameterBinding*, i64 }* %t14
}

define { %ParameterBinding*, i64 }* @append_parameter_binding({ %ParameterBinding*, i64 }* %bindings, %ParameterBinding %binding) {
entry:
  %t0 = alloca [1 x %ParameterBinding]
  %t1 = getelementptr [1 x %ParameterBinding], [1 x %ParameterBinding]* %t0, i32 0, i32 0
  %t2 = getelementptr %ParameterBinding, %ParameterBinding* %t1, i64 0
  store %ParameterBinding %binding, %ParameterBinding* %t2
  %t3 = alloca { %ParameterBinding*, i64 }
  %t4 = getelementptr { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %t3, i32 0, i32 0
  store %ParameterBinding* %t1, %ParameterBinding** %t4
  %t5 = getelementptr { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @bindingsconcat({ %ParameterBinding*, i64 }* %t3)
  ret { %ParameterBinding*, i64 }* null
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  store i8* null, i8** %l0
  %t0 = sitofp i64 1 to double
  store double %t0, double* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t7 = phi i8* [ %t1, %entry ], [ %t6, %loop.latch2 ]
  store i8* %t7, i8** %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = add i8* %t4, %separator
  br label %loop.latch2
loop.latch2:
  %t6 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t8 = load i8*, i8** %l0
  ret i8* %t8
}

define { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %existing, { %StringConstant*, i64 }* %new_constants) {
entry:
  %l0 = alloca { %StringConstant*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  store { %StringConstant*, i64 }* %existing, { %StringConstant*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  store double 0.0, double* %l2
  %t4 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  %t5 = load double, double* %l2
  store double 0.0, double* %l3
  %t6 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  ret { %StringConstant*, i64 }* %t7
}

define { i8**, i64 }* @render_string_constants({ %StringConstant*, i64 }* %constants) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t16 = phi { i8**, i64 }* [ %t6, %entry ], [ %t15, %loop.latch2 ]
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l2
  store double 0.0, double* %l4
  %t11 = load double, double* %l2
  store double 0.0, double* %l5
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load double, double* %l5
  %t14 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t12, i8* null)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t17
}

define i8* @escape_string_for_llvm(i8* %content) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load i8*, i8** %l0
  ret i8* %t7
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
