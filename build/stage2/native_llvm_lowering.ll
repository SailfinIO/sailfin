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

declare noalias i8* @malloc(i64)

@.str.43 = private unnamed_addr constant [23 x i8] c"; ModuleID = 'sailfin'\00"
@.str.46 = private unnamed_addr constant [28 x i8] c"source_filename = \22sailfin\22\00"
@.str.49 = private unnamed_addr constant [1 x i8] c"\00"
@.str.517 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.123 = private unnamed_addr constant [53 x i8] c"; -- Trait Metadata --------------------------------\00"
@.str.148 = private unnamed_addr constant [50 x i8] c"; -----------------------------------------------\00"
@.str.6 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.8 = private unnamed_addr constant [2 x i8] c",\00"
@.str.11 = private unnamed_addr constant [2 x i8] c";\00"
@.str.14 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.17 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.20 = private unnamed_addr constant [2 x i8] c"=\00"
@.str.6 = private unnamed_addr constant [15 x i8] c"(\22 || ch == \22)\00"
@.str.0 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.2 = private unnamed_addr constant [60 x i8] c"(\22 + render_interface_parameters(signature.parameters) + \22)\00"
@.str.30 = private unnamed_addr constant [8 x i8] c"define \00"
@.str.33 = private unnamed_addr constant [7 x i8] c"entry:\00"
@.str.106 = private unnamed_addr constant [12 x i8] c"loop.header\00"
@.str.113 = private unnamed_addr constant [10 x i8] c"loop.body\00"
@.str.120 = private unnamed_addr constant [11 x i8] c"loop.latch\00"
@.str.127 = private unnamed_addr constant [10 x i8] c"afterloop\00"
@.str.135 = private unnamed_addr constant [13 x i8] c"  br label %\00"
@.str.141 = private unnamed_addr constant [2 x i8] c":\00"
@.str.99 = private unnamed_addr constant [3 x i8] c"  \00"
@.str.102 = private unnamed_addr constant [18 x i8] c" = getelementptr \00"
@.str.118 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.141 = private unnamed_addr constant [9 x i8] c" = load \00"
@.str.151 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.158 = private unnamed_addr constant [8 x i8] c"forbody\00"
@.str.165 = private unnamed_addr constant [7 x i8] c"forinc\00"
@.str.172 = private unnamed_addr constant [9 x i8] c"afterfor\00"
@.str.188 = private unnamed_addr constant [14 x i8] c" = alloca i64\00"
@.str.201 = private unnamed_addr constant [11 x i8] c" = alloca \00"
@.str.205 = private unnamed_addr constant [9 x i8] c"  store \00"
@.str.232 = private unnamed_addr constant [17 x i8] c" = icmp slt i64 \00"
@.str.240 = private unnamed_addr constant [9 x i8] c"  br i1 \00"
@.str.328 = private unnamed_addr constant [12 x i8] c" = add i64 \00"
@.str.336 = private unnamed_addr constant [13 x i8] c"  store i64 \00"
@.str.95 = private unnamed_addr constant [11 x i8] c"matchmerge\00"
@.str.41 = private unnamed_addr constant [44 x i8] c"llvm lowering: unsupported condition type `\00"
@.str.4 = private unnamed_addr constant [8 x i8] c" = phi \00"
@.str.7 = private unnamed_addr constant [2 x i8] c" \00"
@.str.16 = private unnamed_addr constant [3 x i8] c", \00"
@.str.23 = private unnamed_addr constant [5 x i8] c"then\00"
@.str.32 = private unnamed_addr constant [6 x i8] c"merge\00"
@.str.148 = private unnamed_addr constant [7 x i8] c"  ret \00"
@.str.12 = private unnamed_addr constant [3 x i8] c"{ \00"
@.str.388 = private unnamed_addr constant [40 x i8] c"llvm lowering: unsupported expression `\00"
@.str.391 = private unnamed_addr constant [2 x i8] c"`\00"
@.str.20 = private unnamed_addr constant [44 x i8] c" (\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.7 = private unnamed_addr constant [14 x i8] c"ternary_cond_\00"
@.str.10 = private unnamed_addr constant [14 x i8] c"ternary_then_\00"
@.str.13 = private unnamed_addr constant [14 x i8] c"ternary_else_\00"
@.str.16 = private unnamed_addr constant [15 x i8] c"ternary_merge_\00"
@.str.54 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str.152 = private unnamed_addr constant [18 x i8] c"ternary_then_end_\00"
@.str.223 = private unnamed_addr constant [18 x i8] c"ternary_else_end_\00"
@.str.124 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.19 = private unnamed_addr constant [19 x i8] c"logical_and_entry_\00"
@.str.22 = private unnamed_addr constant [19 x i8] c"logical_and_right_\00"
@.str.25 = private unnamed_addr constant [23 x i8] c"logical_and_right_end_\00"
@.str.28 = private unnamed_addr constant [19 x i8] c"logical_and_merge_\00"
@.str.253 = private unnamed_addr constant [21 x i8] c" = phi i1 [ false, %\00"
@.str.19 = private unnamed_addr constant [18 x i8] c"logical_or_entry_\00"
@.str.22 = private unnamed_addr constant [18 x i8] c"logical_or_right_\00"
@.str.25 = private unnamed_addr constant [22 x i8] c"logical_or_right_end_\00"
@.str.28 = private unnamed_addr constant [18 x i8] c"logical_or_merge_\00"
@.str.253 = private unnamed_addr constant [20 x i8] c" = phi i1 [ true, %\00"
@.str.247 = private unnamed_addr constant [7 x i8] c"double\00"
@.str.528 = private unnamed_addr constant [9 x i8] c" = call \00"
@.str.532 = private unnamed_addr constant [3 x i8] c" @\00"
@.str.536 = private unnamed_addr constant [24 x i8] c"(\22 + argument_text + \22)\00"
@.str.98 = private unnamed_addr constant [17 x i8] c" = extractvalue \00"
@.str.221 = private unnamed_addr constant [54 x i8] c"llvm lowering: unsupported array type for indexing: `\00"
@.str.255 = private unnamed_addr constant [2 x i8] c"[\00"
@.str.258 = private unnamed_addr constant [4 x i8] c" x \00"
@.str.262 = private unnamed_addr constant [2 x i8] c"]\00"
@.str.31 = private unnamed_addr constant [2 x i8] c".\00"
@.str.8 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str.24 = private unnamed_addr constant [11 x i8] c" = and i1 \00"
@.str.176 = private unnamed_addr constant [50 x i8] c"llvm lowering: unable to coerce operand of type `\00"
@.str.179 = private unnamed_addr constant [7 x i8] c"` to `\00"
@.str.2 = private unnamed_addr constant [4 x i8] c"add\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"%t\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"%l\00"
@.str.14 = private unnamed_addr constant [16 x i8] c"zeroinitializer\00"
@.str.2 = private unnamed_addr constant [4 x i8] c"fn:\00"
@.str.2 = private unnamed_addr constant [3 x i8] c"::\00"
@.str.3 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.9 = private unnamed_addr constant [3 x i8] c".0\00"
@.str.1 = private unnamed_addr constant [7 x i8] c"@.str.\00"
@.str.12 = private unnamed_addr constant [5 x i8] c"  %s\00"
@.str.15 = private unnamed_addr constant [27 x i8] c" = getelementptr inbounds \00"
@.str.8 = private unnamed_addr constant [2 x i8] c"\0D\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"\09\00"

define %LoweredLLVMResult @lower_to_llvm(i8* %native_module) {
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
  %t19 = call { i8**, i64 }* @collect_runtime_helper_targets({ i8**, i64 }* null)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l8
  %t20 = load double, double* %l7
  %t21 = call { %FunctionEffectEntry*, i64 }* @collect_direct_function_effects({ i8**, i64 }* null)
  store { %FunctionEffectEntry*, i64 }* %t21, { %FunctionEffectEntry*, i64 }** %l9
  %t22 = load double, double* %l7
  %t23 = call { %FunctionCallEntry*, i64 }* @collect_function_call_graph({ i8**, i64 }* null)
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
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = icmp sgt i64 %t55, 0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  %t60 = load double, double* %l3
  %t61 = load double, double* %l4
  %t62 = load double, double* %l5
  %t63 = load double, double* %l6
  %t64 = load double, double* %l7
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t66 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t67 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t68 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t69 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t70 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l15
  br i1 %t56, label %then0, label %merge1
then0:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t74 = call double @linesconcat({ i8**, i64 }* %t73)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s76 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.76, i32 0, i32 0
  %t77 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t75, i8* %s76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l14
  br label %merge1
merge1:
  %t78 = phi { i8**, i64 }* [ null, %then0 ], [ %t71, %entry ]
  %t79 = phi { i8**, i64 }* [ %t77, %then0 ], [ %t71, %entry ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l14
  store { i8**, i64 }* %t79, { i8**, i64 }** %l14
  %t80 = load double, double* %l5
  %t81 = call { i8**, i64 }* @render_struct_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t81, { i8**, i64 }** %l16
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t83 = load { i8**, i64 }, { i8**, i64 }* %t82
  %t84 = extractvalue { i8**, i64 } %t83, 1
  %t85 = icmp sgt i64 %t84, 0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load double, double* %l4
  %t91 = load double, double* %l5
  %t92 = load double, double* %l6
  %t93 = load double, double* %l7
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t95 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t96 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t97 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t98 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t99 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l16
  br i1 %t85, label %then2, label %merge3
then2:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t104 = call double @linesconcat({ i8**, i64 }* %t103)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s106 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.106, i32 0, i32 0
  %t107 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t105, i8* %s106)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l14
  br label %merge3
merge3:
  %t108 = phi { i8**, i64 }* [ null, %then2 ], [ %t100, %entry ]
  %t109 = phi { i8**, i64 }* [ %t107, %then2 ], [ %t100, %entry ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l14
  store { i8**, i64 }* %t109, { i8**, i64 }** %l14
  %t110 = load double, double* %l5
  %t111 = call { i8**, i64 }* @render_enum_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t111, { i8**, i64 }** %l17
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t113 = load { i8**, i64 }, { i8**, i64 }* %t112
  %t114 = extractvalue { i8**, i64 } %t113, 1
  %t115 = icmp sgt i64 %t114, 0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load double, double* %l1
  %t118 = load double, double* %l2
  %t119 = load double, double* %l3
  %t120 = load double, double* %l4
  %t121 = load double, double* %l5
  %t122 = load double, double* %l6
  %t123 = load double, double* %l7
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t125 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t126 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t127 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t128 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t129 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l17
  br i1 %t115, label %then4, label %merge5
then4:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t135 = call double @linesconcat({ i8**, i64 }* %t134)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s137 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.137, i32 0, i32 0
  %t138 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t136, i8* %s137)
  store { i8**, i64 }* %t138, { i8**, i64 }** %l14
  br label %merge5
merge5:
  %t139 = phi { i8**, i64 }* [ null, %then4 ], [ %t130, %entry ]
  %t140 = phi { i8**, i64 }* [ %t138, %then4 ], [ %t130, %entry ]
  store { i8**, i64 }* %t139, { i8**, i64 }** %l14
  store { i8**, i64 }* %t140, { i8**, i64 }** %l14
  %t141 = load double, double* %l5
  %t142 = call { i8**, i64 }* @render_interface_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t142, { i8**, i64 }** %l18
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t144 = load { i8**, i64 }, { i8**, i64 }* %t143
  %t145 = extractvalue { i8**, i64 } %t144, 1
  %t146 = icmp sgt i64 %t145, 0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load double, double* %l1
  %t149 = load double, double* %l2
  %t150 = load double, double* %l3
  %t151 = load double, double* %l4
  %t152 = load double, double* %l5
  %t153 = load double, double* %l6
  %t154 = load double, double* %l7
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t156 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t157 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t158 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t159 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t160 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l18
  br i1 %t146, label %then6, label %merge7
then6:
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t167 = call double @linesconcat({ i8**, i64 }* %t166)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s169 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.169, i32 0, i32 0
  %t170 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t168, i8* %s169)
  store { i8**, i64 }* %t170, { i8**, i64 }** %l14
  br label %merge7
merge7:
  %t171 = phi { i8**, i64 }* [ null, %then6 ], [ %t161, %entry ]
  %t172 = phi { i8**, i64 }* [ %t170, %then6 ], [ %t161, %entry ]
  store { i8**, i64 }* %t171, { i8**, i64 }** %l14
  store { i8**, i64 }* %t172, { i8**, i64 }** %l14
  %t173 = load double, double* %l5
  %t174 = call { i8**, i64 }* @render_vtable_type_definitions(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t174, { i8**, i64 }** %l19
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t176 = load { i8**, i64 }, { i8**, i64 }* %t175
  %t177 = extractvalue { i8**, i64 } %t176, 1
  %t178 = icmp sgt i64 %t177, 0
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load double, double* %l1
  %t181 = load double, double* %l2
  %t182 = load double, double* %l3
  %t183 = load double, double* %l4
  %t184 = load double, double* %l5
  %t185 = load double, double* %l6
  %t186 = load double, double* %l7
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t188 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t189 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t190 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t191 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t192 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l19
  br i1 %t178, label %then8, label %merge9
then8:
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t200 = call double @linesconcat({ i8**, i64 }* %t199)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s202 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.202, i32 0, i32 0
  %t203 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t201, i8* %s202)
  store { i8**, i64 }* %t203, { i8**, i64 }** %l14
  br label %merge9
merge9:
  %t204 = phi { i8**, i64 }* [ null, %then8 ], [ %t193, %entry ]
  %t205 = phi { i8**, i64 }* [ %t203, %then8 ], [ %t193, %entry ]
  store { i8**, i64 }* %t204, { i8**, i64 }** %l14
  store { i8**, i64 }* %t205, { i8**, i64 }** %l14
  %t206 = load double, double* %l5
  %t207 = call { i8**, i64 }* @render_vtable_constants(%TypeContext zeroinitializer)
  store { i8**, i64 }* %t207, { i8**, i64 }** %l20
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t209 = load { i8**, i64 }, { i8**, i64 }* %t208
  %t210 = extractvalue { i8**, i64 } %t209, 1
  %t211 = icmp sgt i64 %t210, 0
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load double, double* %l1
  %t214 = load double, double* %l2
  %t215 = load double, double* %l3
  %t216 = load double, double* %l4
  %t217 = load double, double* %l5
  %t218 = load double, double* %l6
  %t219 = load double, double* %l7
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t221 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t222 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t223 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t224 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t225 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l20
  br i1 %t211, label %then10, label %merge11
then10:
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t234 = call double @linesconcat({ i8**, i64 }* %t233)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s236 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.236, i32 0, i32 0
  %t237 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t235, i8* %s236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l14
  br label %merge11
merge11:
  %t238 = phi { i8**, i64 }* [ null, %then10 ], [ %t226, %entry ]
  %t239 = phi { i8**, i64 }* [ %t237, %then10 ], [ %t226, %entry ]
  store { i8**, i64 }* %t238, { i8**, i64 }** %l14
  store { i8**, i64 }* %t239, { i8**, i64 }** %l14
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t241 = call { i8**, i64 }* @render_runtime_helper_declarations({ i8**, i64 }* %t240)
  store { i8**, i64 }* %t241, { i8**, i64 }** %l21
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t243 = load { i8**, i64 }, { i8**, i64 }* %t242
  %t244 = extractvalue { i8**, i64 } %t243, 1
  %t245 = icmp sgt i64 %t244, 0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t247 = load double, double* %l1
  %t248 = load double, double* %l2
  %t249 = load double, double* %l3
  %t250 = load double, double* %l4
  %t251 = load double, double* %l5
  %t252 = load double, double* %l6
  %t253 = load double, double* %l7
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t255 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t256 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t257 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t258 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t259 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t245, label %then12, label %merge13
then12:
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t269 = call double @linesconcat({ i8**, i64 }* %t268)
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s271 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.271, i32 0, i32 0
  %t272 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t270, i8* %s271)
  store { i8**, i64 }* %t272, { i8**, i64 }** %l14
  br label %merge13
merge13:
  %t273 = phi { i8**, i64 }* [ null, %then12 ], [ %t260, %entry ]
  %t274 = phi { i8**, i64 }* [ %t272, %then12 ], [ %t260, %entry ]
  store { i8**, i64 }* %t273, { i8**, i64 }** %l14
  store { i8**, i64 }* %t274, { i8**, i64 }** %l14
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %s277 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.277, i32 0, i32 0
  %t278 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t276, i8* %s277)
  store { i8**, i64 }* %t278, { i8**, i64 }** %l14
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l14
  store { i8**, i64 }* %t279, { i8**, i64 }** %l22
  %t280 = alloca [0 x double]
  %t281 = getelementptr [0 x double], [0 x double]* %t280, i32 0, i32 0
  %t282 = alloca { double*, i64 }
  %t283 = getelementptr { double*, i64 }, { double*, i64 }* %t282, i32 0, i32 0
  store double* %t281, double** %t283
  %t284 = getelementptr { double*, i64 }, { double*, i64 }* %t282, i32 0, i32 1
  store i64 0, i64* %t284
  store { i8**, i64 }* null, { i8**, i64 }** %l23
  %t285 = sitofp i64 0 to double
  store double %t285, double* %l24
  store i1 0, i1* %l25
  %t286 = alloca [0 x double]
  %t287 = getelementptr [0 x double], [0 x double]* %t286, i32 0, i32 0
  %t288 = alloca { double*, i64 }
  %t289 = getelementptr { double*, i64 }, { double*, i64 }* %t288, i32 0, i32 0
  store double* %t287, double** %t289
  %t290 = getelementptr { double*, i64 }, { double*, i64 }* %t288, i32 0, i32 1
  store i64 0, i64* %t290
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l26
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t292 = load double, double* %l1
  %t293 = load double, double* %l2
  %t294 = load double, double* %l3
  %t295 = load double, double* %l4
  %t296 = load double, double* %l5
  %t297 = load double, double* %l6
  %t298 = load double, double* %l7
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t300 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t301 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t302 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t303 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t304 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t315 = load double, double* %l24
  %t316 = load i1, i1* %l25
  %t317 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  br label %loop.header14
loop.header14:
  %t399 = phi { %FunctionEffectEntry*, i64 }* [ %t303, %entry ], [ %t393, %loop.latch16 ]
  %t400 = phi { i8**, i64 }* [ %t291, %entry ], [ %t394, %loop.latch16 ]
  %t401 = phi { %LifetimeRegionMetadata*, i64 }* [ %t304, %entry ], [ %t395, %loop.latch16 ]
  %t402 = phi { %StringConstant*, i64 }* [ %t317, %entry ], [ %t396, %loop.latch16 ]
  %t403 = phi { i8**, i64 }* [ %t314, %entry ], [ %t397, %loop.latch16 ]
  %t404 = phi double [ %t315, %entry ], [ %t398, %loop.latch16 ]
  store { %FunctionEffectEntry*, i64 }* %t399, { %FunctionEffectEntry*, i64 }** %l12
  store { i8**, i64 }* %t400, { i8**, i64 }** %l0
  store { %LifetimeRegionMetadata*, i64 }* %t401, { %LifetimeRegionMetadata*, i64 }** %l13
  store { %StringConstant*, i64 }* %t402, { %StringConstant*, i64 }** %l26
  store { i8**, i64 }* %t403, { i8**, i64 }** %l23
  store double %t404, double* %l24
  br label %loop.body15
loop.body15:
  %t318 = load double, double* %l24
  %t319 = load double, double* %l7
  %t320 = load double, double* %l7
  %t321 = load double, double* %l24
  store double 0.0, double* %l27
  %t322 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t323 = load double, double* %l27
  store double 0.0, double* %l28
  %t324 = alloca [0 x double]
  %t325 = getelementptr [0 x double], [0 x double]* %t324, i32 0, i32 0
  %t326 = alloca { double*, i64 }
  %t327 = getelementptr { double*, i64 }, { double*, i64 }* %t326, i32 0, i32 0
  store double* %t325, double** %t327
  %t328 = getelementptr { double*, i64 }, { double*, i64 }* %t326, i32 0, i32 1
  store i64 0, i64* %t328
  store { i8**, i64 }* null, { i8**, i64 }** %l29
  %t329 = load double, double* %l28
  %t330 = load double, double* %l27
  %t331 = load double, double* %l7
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t333 = load double, double* %l5
  %t334 = call %LoweredLLVMFunction @emit_function(i8* null, { i8**, i64 }* null, { i8**, i64 }* %t332, %TypeContext zeroinitializer)
  store %LoweredLLVMFunction %t334, %LoweredLLVMFunction* %l30
  %t335 = load double, double* %l27
  %t336 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t337 = extractvalue %LoweredLLVMFunction %t336, 1
  %t338 = call double @diagnosticsconcat({ i8**, i64 }* %t337)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t339 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t340 = extractvalue %LoweredLLVMFunction %t339, 2
  %t341 = call double @lifetime_regionsconcat({ i8**, i64 }* %t340)
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l13
  %t342 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t343 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t344 = extractvalue %LoweredLLVMFunction %t343, 3
  %t345 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t342, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t345, { %StringConstant*, i64 }** %l26
  %t346 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t347 = extractvalue %LoweredLLVMFunction %t346, 0
  %t348 = load { i8**, i64 }, { i8**, i64 }* %t347
  %t349 = extractvalue { i8**, i64 } %t348, 1
  %t350 = icmp sgt i64 %t349, 0
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t352 = load double, double* %l1
  %t353 = load double, double* %l2
  %t354 = load double, double* %l3
  %t355 = load double, double* %l4
  %t356 = load double, double* %l5
  %t357 = load double, double* %l6
  %t358 = load double, double* %l7
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t360 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t361 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t362 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t363 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t364 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t375 = load double, double* %l24
  %t376 = load i1, i1* %l25
  %t377 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t378 = load double, double* %l27
  %t379 = load double, double* %l28
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t381 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  br i1 %t350, label %then18, label %merge19
then18:
  %t382 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t383 = extractvalue %LoweredLLVMFunction %t382, 0
  %t384 = call double @function_linesconcat({ i8**, i64 }* %t383)
  store { i8**, i64 }* null, { i8**, i64 }** %l23
  %t385 = load double, double* %l24
  %t386 = sitofp i64 1 to double
  %t387 = fadd double %t385, %t386
  %t388 = load double, double* %l7
  br label %merge19
merge19:
  %t389 = phi { i8**, i64 }* [ null, %then18 ], [ %t374, %loop.body15 ]
  store { i8**, i64 }* %t389, { i8**, i64 }** %l23
  %t390 = load double, double* %l24
  %t391 = sitofp i64 1 to double
  %t392 = fadd double %t390, %t391
  store double %t392, double* %l24
  br label %loop.latch16
loop.latch16:
  %t393 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t395 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t396 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t398 = load double, double* %l24
  br label %loop.header14
afterloop17:
  %t405 = load i1, i1* %l25
  %t406 = xor i1 %t405, 1
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t408 = load double, double* %l1
  %t409 = load double, double* %l2
  %t410 = load double, double* %l3
  %t411 = load double, double* %l4
  %t412 = load double, double* %l5
  %t413 = load double, double* %l6
  %t414 = load double, double* %l7
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t416 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t417 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t418 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t419 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t420 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t431 = load double, double* %l24
  %t432 = load i1, i1* %l25
  %t433 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  br i1 %t406, label %then20, label %merge21
then20:
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t435 = load { i8**, i64 }, { i8**, i64 }* %t434
  %t436 = extractvalue { i8**, i64 } %t435, 1
  %t437 = icmp sgt i64 %t436, 0
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t439 = load double, double* %l1
  %t440 = load double, double* %l2
  %t441 = load double, double* %l3
  %t442 = load double, double* %l4
  %t443 = load double, double* %l5
  %t444 = load double, double* %l6
  %t445 = load double, double* %l7
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t447 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t448 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t449 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t450 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t451 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t462 = load double, double* %l24
  %t463 = load i1, i1* %l25
  %t464 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  br i1 %t437, label %then22, label %merge23
then22:
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %s466 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.466, i32 0, i32 0
  %t467 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t465, i8* %s466)
  store { i8**, i64 }* %t467, { i8**, i64 }** %l23
  br label %merge23
merge23:
  %t468 = phi { i8**, i64 }* [ %t467, %then22 ], [ %t461, %then20 ]
  store { i8**, i64 }* %t468, { i8**, i64 }** %l23
  br label %merge21
merge21:
  %t469 = phi { i8**, i64 }* [ %t467, %then20 ], [ %t430, %entry ]
  %t470 = phi { i8**, i64 }* [ null, %then20 ], [ %t430, %entry ]
  store { i8**, i64 }* %t469, { i8**, i64 }** %l23
  store { i8**, i64 }* %t470, { i8**, i64 }** %l23
  %t471 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t472 = call { i8**, i64 }* @render_string_constants({ %StringConstant*, i64 }* %t471)
  store { i8**, i64 }* %t472, { i8**, i64 }** %l31
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l22
  store { i8**, i64 }* %t473, { i8**, i64 }** %l32
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t475 = load { i8**, i64 }, { i8**, i64 }* %t474
  %t476 = extractvalue { i8**, i64 } %t475, 1
  %t477 = icmp sgt i64 %t476, 0
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t479 = load double, double* %l1
  %t480 = load double, double* %l2
  %t481 = load double, double* %l3
  %t482 = load double, double* %l4
  %t483 = load double, double* %l5
  %t484 = load double, double* %l6
  %t485 = load double, double* %l7
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t487 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t488 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t489 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t490 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t491 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t499 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t502 = load double, double* %l24
  %t503 = load i1, i1* %l25
  %t504 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t477, label %then24, label %merge25
then24:
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t508 = call double @final_linesconcat({ i8**, i64 }* %t507)
  store { i8**, i64 }* null, { i8**, i64 }** %l32
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %s510 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.510, i32 0, i32 0
  %t511 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t509, i8* %s510)
  store { i8**, i64 }* %t511, { i8**, i64 }** %l32
  br label %merge25
merge25:
  %t512 = phi { i8**, i64 }* [ null, %then24 ], [ %t506, %entry ]
  %t513 = phi { i8**, i64 }* [ %t511, %then24 ], [ %t506, %entry ]
  store { i8**, i64 }* %t512, { i8**, i64 }** %l32
  store { i8**, i64 }* %t513, { i8**, i64 }** %l32
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t515 = call double @final_linesconcat({ i8**, i64 }* %t514)
  store { i8**, i64 }* null, { i8**, i64 }** %l32
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %s517 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.517, i32 0, i32 0
  %t518 = call i8* @join_with_separator({ i8**, i64 }* %t516, i8* %s517)
  store i8* %t518, i8** %l33
  %t519 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  store double 0.0, double* %l34
  %t520 = load i8*, i8** %l33
  store i8* %t520, i8** %l35
  %t521 = load i8*, i8** %l35
  %t522 = load i8*, i8** %l35
  %t523 = insertvalue %LoweredLLVMResult undef, i8* %t522, 0
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t525 = insertvalue %LoweredLLVMResult %t523, { i8**, i64 }* %t524, 1
  %t526 = load double, double* %l3
  %t527 = insertvalue %LoweredLLVMResult %t525, i8* null, 2
  %t528 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t529 = insertvalue %LoweredLLVMResult %t527, { i8**, i64 }* null, 3
  %t530 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t531 = insertvalue %LoweredLLVMResult %t529, { i8**, i64 }* null, 4
  %t532 = load double, double* %l34
  %t533 = insertvalue %LoweredLLVMResult %t531, i8* null, 5
  %t534 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t535 = insertvalue %LoweredLLVMResult %t533, { i8**, i64 }* null, 6
  ret %LoweredLLVMResult %t535
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

define %TraitMetadata @build_trait_metadata({ i8**, i64 }* %interfaces, { i8**, i64 }* %structs) {
entry:
  %l0 = alloca { %TraitDescriptor*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { %TraitImplementationDescriptor*, i64 }*
  %l4 = alloca i8*
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
  %t27 = phi { %TraitDescriptor*, i64 }* [ %t6, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store { %TraitDescriptor*, i64 }* %t27, { %TraitDescriptor*, i64 }** %l0
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { %TraitImplementationDescriptor*, i64 }* null, { %TraitImplementationDescriptor*, i64 }** %l3
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l1
  %t35 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  br label %loop.header6
loop.header6:
  %t58 = phi double [ %t36, %entry ], [ %t57, %loop.latch8 ]
  store double %t58, double* %l1
  br label %loop.body7
loop.body7:
  %t38 = load double, double* %l1
  %t39 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp oge double %t38, %t41
  %t43 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  br i1 %t42, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t46 = load double, double* %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t48 = extractvalue { i8**, i64 } %t47, 0
  %t49 = extractvalue { i8**, i64 } %t47, 1
  %t50 = icmp uge i64 %t46, %t49
  ; bounds check: %t50 (if true, out of bounds)
  %t51 = getelementptr i8*, i8** %t48, i64 %t46
  %t52 = load i8*, i8** %t51
  store i8* %t52, i8** %l4
  %t53 = load i8*, i8** %l4
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  br label %loop.latch8
loop.latch8:
  %t57 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t59 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t60 = insertvalue %TraitMetadata undef, { i8**, i64 }* null, 0
  %t61 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  %t62 = insertvalue %TraitMetadata %t60, { i8**, i64 }* null, 1
  ret %TraitMetadata %t62
}

define { i8**, i64 }* @render_trait_metadata_comments(%TraitMetadata %metadata) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca i8*
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
  %t59 = phi { i8**, i64 }* [ %t6, %entry ], [ %t57, %loop.latch2 ]
  %t60 = phi double [ %t7, %entry ], [ %t58, %loop.latch2 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  store double %t60, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TraitMetadata %metadata, 0
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %TraitMetadata %metadata, 0
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %s24 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.24, i32 0, i32 0
  %t25 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l3
  %t29 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t27, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load i8*, i8** %l3
  %t35 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t51 = phi { i8**, i64 }* [ %t31, %loop.body1 ], [ %t49, %loop.latch8 ]
  %t52 = phi double [ %t35, %loop.body1 ], [ %t50, %loop.latch8 ]
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  store double %t52, double* %l4
  br label %loop.body7
loop.body7:
  %t36 = load double, double* %l4
  %t37 = load i8*, i8** %l2
  %t38 = load i8*, i8** %l2
  store double 0.0, double* %l5
  %t39 = load double, double* %l5
  %t40 = call i8* @render_interface_signature(i8* null)
  store i8* %t40, i8** %l6
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s42 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.42, i32 0, i32 0
  %t43 = load i8*, i8** %l6
  %t44 = add i8* %s42, %t43
  %t45 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t41, i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  %t46 = load double, double* %l4
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l4
  br label %loop.latch8
loop.latch8:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  br label %loop.latch2
loop.latch2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t61 = alloca [0 x double]
  %t62 = getelementptr [0 x double], [0 x double]* %t61, i32 0, i32 0
  %t63 = alloca { double*, i64 }
  %t64 = getelementptr { double*, i64 }, { double*, i64 }* %t63, i32 0, i32 0
  store double* %t62, double** %t64
  %t65 = getelementptr { double*, i64 }, { double*, i64 }* %t63, i32 0, i32 1
  store i64 0, i64* %t65
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t66 = sitofp i64 0 to double
  store double %t66, double* %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l7
  br label %loop.header10
loop.header10:
  %t97 = phi { i8**, i64 }* [ %t69, %entry ], [ %t95, %loop.latch12 ]
  %t98 = phi double [ %t68, %entry ], [ %t96, %loop.latch12 ]
  store { i8**, i64 }* %t97, { i8**, i64 }** %l7
  store double %t98, double* %l1
  br label %loop.body11
loop.body11:
  %t70 = load double, double* %l1
  %t71 = extractvalue %TraitMetadata %metadata, 1
  %t72 = load { i8**, i64 }, { i8**, i64 }* %t71
  %t73 = extractvalue { i8**, i64 } %t72, 1
  %t74 = sitofp i64 %t73 to double
  %t75 = fcmp oge double %t70, %t74
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l7
  br i1 %t75, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t79 = extractvalue %TraitMetadata %metadata, 1
  %t80 = load double, double* %l1
  %t81 = load { i8**, i64 }, { i8**, i64 }* %t79
  %t82 = extractvalue { i8**, i64 } %t81, 0
  %t83 = extractvalue { i8**, i64 } %t81, 1
  %t84 = icmp uge i64 %t80, %t83
  ; bounds check: %t84 (if true, out of bounds)
  %t85 = getelementptr i8*, i8** %t82, i64 %t80
  %t86 = load i8*, i8** %t85
  store i8* %t86, i8** %l8
  %s87 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.87, i32 0, i32 0
  %t88 = load i8*, i8** %l8
  store i8* null, i8** %l9
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t90 = load i8*, i8** %l9
  %t91 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t89, i8* %t90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l7
  %t92 = load double, double* %l1
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l1
  br label %loop.latch12
loop.latch12:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t96 = load double, double* %l1
  br label %loop.header10
afterloop13:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = icmp eq i64 %t102, 0
  br label %logical_and_entry_99

logical_and_entry_99:
  br i1 %t103, label %logical_and_right_99, label %logical_and_merge_99

logical_and_right_99:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t105 = load { i8**, i64 }, { i8**, i64 }* %t104
  %t106 = extractvalue { i8**, i64 } %t105, 1
  %t107 = icmp eq i64 %t106, 0
  br label %logical_and_right_end_99

logical_and_right_end_99:
  br label %logical_and_merge_99

logical_and_merge_99:
  %t108 = phi i1 [ false, %logical_and_entry_99 ], [ %t107, %logical_and_right_end_99 ]
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l7
  br i1 %t108, label %then16, label %merge17
then16:
  %t112 = alloca [0 x double]
  %t113 = getelementptr [0 x double], [0 x double]* %t112, i32 0, i32 0
  %t114 = alloca { double*, i64 }
  %t115 = getelementptr { double*, i64 }, { double*, i64 }* %t114, i32 0, i32 0
  store double* %t113, double** %t115
  %t116 = getelementptr { double*, i64 }, { double*, i64 }* %t114, i32 0, i32 1
  store i64 0, i64* %t116
  ret { i8**, i64 }* null
merge17:
  %t117 = alloca [0 x double]
  %t118 = getelementptr [0 x double], [0 x double]* %t117, i32 0, i32 0
  %t119 = alloca { double*, i64 }
  %t120 = getelementptr { double*, i64 }, { double*, i64 }* %t119, i32 0, i32 0
  store double* %t118, double** %t120
  %t121 = getelementptr { double*, i64 }, { double*, i64 }* %t119, i32 0, i32 1
  store i64 0, i64* %t121
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s123 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.123, i32 0, i32 0
  %t124 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t122, i8* %s123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l10
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = call double @linesconcat({ i8**, i64 }* %t125)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load { i8**, i64 }, { i8**, i64 }* %t128
  %t130 = extractvalue { i8**, i64 } %t129, 1
  %t131 = icmp sgt i64 %t130, 0
  br label %logical_and_entry_127

logical_and_entry_127:
  br i1 %t131, label %logical_and_right_127, label %logical_and_merge_127

logical_and_right_127:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t133 = load { i8**, i64 }, { i8**, i64 }* %t132
  %t134 = extractvalue { i8**, i64 } %t133, 1
  %t135 = icmp sgt i64 %t134, 0
  br label %logical_and_right_end_127

logical_and_right_end_127:
  br label %logical_and_merge_127

logical_and_merge_127:
  %t136 = phi i1 [ false, %logical_and_entry_127 ], [ %t135, %logical_and_right_end_127 ]
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load double, double* %l1
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l10
  br i1 %t136, label %then18, label %merge19
then18:
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s142 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.142, i32 0, i32 0
  %t143 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t141, i8* %s142)
  store { i8**, i64 }* %t143, { i8**, i64 }** %l10
  br label %merge19
merge19:
  %t144 = phi { i8**, i64 }* [ %t143, %then18 ], [ %t140, %entry ]
  store { i8**, i64 }* %t144, { i8**, i64 }** %l10
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t146 = call double @linesconcat({ i8**, i64 }* %t145)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s148 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.148, i32 0, i32 0
  %t149 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t147, i8* %s148)
  store { i8**, i64 }* %t149, { i8**, i64 }** %l10
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l10
  ret { i8**, i64 }* %t150
}

define { i8**, i64 }* @render_runtime_helper_declarations({ i8**, i64 }* %used_targets) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %RuntimeHelperDescriptor*, i64 }*
  %l2 = alloca double
  %l3 = alloca %RuntimeHelperDescriptor
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %used_targets
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  ret { i8**, i64 }* null
merge1:
  %t8 = alloca [0 x double]
  %t9 = getelementptr [0 x double], [0 x double]* %t8, i32 0, i32 0
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t9, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t13 = call { %RuntimeHelperDescriptor*, i64 }* @runtime_helper_descriptors()
  store { %RuntimeHelperDescriptor*, i64 }* %t13, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t17 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t97 = phi { i8**, i64 }* [ %t15, %entry ], [ %t95, %loop.latch4 ]
  %t98 = phi double [ %t17, %entry ], [ %t96, %loop.latch4 ]
  store { i8**, i64 }* %t97, { i8**, i64 }** %l0
  store double %t98, double* %l2
  br label %loop.body3
loop.body3:
  %t18 = load double, double* %l2
  %t19 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t20 = load { %RuntimeHelperDescriptor*, i64 }, { %RuntimeHelperDescriptor*, i64 }* %t19
  %t21 = extractvalue { %RuntimeHelperDescriptor*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t18, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t26 = load double, double* %l2
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t28 = load double, double* %l2
  %t29 = load { %RuntimeHelperDescriptor*, i64 }, { %RuntimeHelperDescriptor*, i64 }* %t27
  %t30 = extractvalue { %RuntimeHelperDescriptor*, i64 } %t29, 0
  %t31 = extractvalue { %RuntimeHelperDescriptor*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  %t33 = getelementptr %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %t30, i64 %t28
  %t34 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %t33
  store %RuntimeHelperDescriptor %t34, %RuntimeHelperDescriptor* %l3
  %t35 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t36 = extractvalue %RuntimeHelperDescriptor %t35, 0
  %t37 = call i1 @string_array_contains({ i8**, i64 }* %used_targets, i8* %t36)
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  br i1 %t37, label %then8, label %merge9
then8:
  %t42 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t43 = extractvalue %RuntimeHelperDescriptor %t42, 4
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t45 = extractvalue { i8**, i64 } %t44, 1
  %t46 = icmp sgt i64 %t45, 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  br i1 %t46, label %then10, label %merge11
then10:
  %t51 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t52 = extractvalue %RuntimeHelperDescriptor %t51, 4
  store double 0.0, double* %l4
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s54 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.54, i32 0, i32 0
  %t55 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t56 = extractvalue %RuntimeHelperDescriptor %t55, 1
  %t57 = add i8* %s54, %t56
  %s58 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.58, i32 0, i32 0
  %t59 = add i8* %t57, %s58
  %t60 = load double, double* %l4
  br label %merge11
merge11:
  %t61 = phi { i8**, i64 }* [ null, %then10 ], [ %t47, %then8 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  %s62 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.62, i32 0, i32 0
  store i8* %s62, i8** %l5
  %t63 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t64 = extractvalue %RuntimeHelperDescriptor %t63, 3
  %t65 = load { i8**, i64 }, { i8**, i64 }* %t64
  %t66 = extractvalue { i8**, i64 } %t65, 1
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t70 = load double, double* %l2
  %t71 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t72 = load i8*, i8** %l5
  br i1 %t67, label %then12, label %merge13
then12:
  %t73 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t74 = extractvalue %RuntimeHelperDescriptor %t73, 3
  br label %merge13
merge13:
  %t75 = phi i8* [ null, %then12 ], [ %t72, %then8 ]
  store i8* %t75, i8** %l5
  %s76 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.76, i32 0, i32 0
  %t77 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t78 = extractvalue %RuntimeHelperDescriptor %t77, 2
  %t79 = add i8* %s76, %t78
  %s80 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.80, i32 0, i32 0
  %t81 = add i8* %t79, %s80
  %t82 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t83 = extractvalue %RuntimeHelperDescriptor %t82, 1
  %t84 = add i8* %t81, %t83
  %s85 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.85, i32 0, i32 0
  %t86 = add i8* %t84, %s85
  store i8* %t86, i8** %l6
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load i8*, i8** %l6
  %t89 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t87, i8* %t88)
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t90 = phi { i8**, i64 }* [ null, %then8 ], [ %t38, %loop.body3 ]
  %t91 = phi { i8**, i64 }* [ %t89, %then8 ], [ %t38, %loop.body3 ]
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  %t92 = load double, double* %l2
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l2
  br label %loop.latch4
loop.latch4:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t99
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

define %TypeContextBuild @build_type_context({ i8**, i64 }* %structs, { i8**, i64 }* %enums, { i8**, i64 }* %interfaces) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %StructTypeInfo*, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
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
  %l15 = alloca i8*
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
  %l30 = alloca i8*
  %l31 = alloca double
  %l32 = alloca double
  %l33 = alloca { %VTableInfo*, i64 }*
  %l34 = alloca double
  %l35 = alloca i8*
  %l36 = alloca double
  %l37 = alloca double
  %l38 = alloca i8*
  %l39 = alloca double
  %l40 = alloca i8*
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
  %t105 = phi { %StructTypeInfo*, i64 }* [ %t12, %entry ], [ %t103, %loop.latch2 ]
  %t106 = phi double [ %t13, %entry ], [ %t104, %loop.latch2 ]
  store { %StructTypeInfo*, i64 }* %t105, { %StructTypeInfo*, i64 }** %l1
  store double %t106, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t14, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l2
  %t23 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  store i8* %t28, i8** %l3
  %t29 = load i8*, i8** %l3
  %t30 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t31 = load i8*, i8** %l3
  store double 0.0, double* %l5
  %s32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.32, i32 0, i32 0
  %t33 = load double, double* %l5
  store double 0.0, double* %l6
  %t34 = alloca [0 x double]
  %t35 = getelementptr [0 x double], [0 x double]* %t34, i32 0, i32 0
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t35, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  store { %StructFieldInfo*, i64 }* null, { %StructFieldInfo*, i64 }** %l7
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l8
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t42 = load double, double* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load double, double* %l4
  %t45 = load double, double* %l5
  %t46 = load double, double* %l6
  %t47 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t48 = load double, double* %l8
  br label %loop.header6
loop.header6:
  %t70 = phi { %StructFieldInfo*, i64 }* [ %t47, %loop.body1 ], [ %t68, %loop.latch8 ]
  %t71 = phi double [ %t48, %loop.body1 ], [ %t69, %loop.latch8 ]
  store { %StructFieldInfo*, i64 }* %t70, { %StructFieldInfo*, i64 }** %l7
  store double %t71, double* %l8
  br label %loop.body7
loop.body7:
  %t49 = load double, double* %l8
  %t50 = load double, double* %l4
  %t51 = load double, double* %l4
  store double 0.0, double* %l9
  %t52 = load double, double* %l9
  store double 0.0, double* %l10
  %t53 = load double, double* %l10
  store i8* null, i8** %l11
  %t54 = load i8*, i8** %l11
  %t55 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t56 = load double, double* %l9
  %t57 = insertvalue %StructFieldInfo undef, i8* null, 0
  %t58 = load i8*, i8** %l11
  %t59 = insertvalue %StructFieldInfo %t57, i8* %t58, 1
  %t60 = load double, double* %l8
  %t61 = insertvalue %StructFieldInfo %t59, double %t60, 2
  %t62 = load double, double* %l9
  %t63 = insertvalue %StructFieldInfo %t61, double 0.0, 3
  %t64 = call { %StructFieldInfo*, i64 }* @append_struct_field_info({ %StructFieldInfo*, i64 }* %t55, %StructFieldInfo %t63)
  store { %StructFieldInfo*, i64 }* %t64, { %StructFieldInfo*, i64 }** %l7
  %t65 = load double, double* %l8
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l8
  br label %loop.latch8
loop.latch8:
  %t68 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t69 = load double, double* %l8
  br label %loop.header6
afterloop9:
  %t72 = load double, double* %l4
  store double 0.0, double* %l12
  %t73 = load double, double* %l12
  %t74 = sitofp i64 0 to double
  %t75 = fcmp ole double %t73, %t74
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t78 = load double, double* %l2
  %t79 = load i8*, i8** %l3
  %t80 = load double, double* %l4
  %t81 = load double, double* %l5
  %t82 = load double, double* %l6
  %t83 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t84 = load double, double* %l8
  %t85 = load double, double* %l12
  br i1 %t75, label %then10, label %merge11
then10:
  %t86 = sitofp i64 1 to double
  store double %t86, double* %l12
  br label %merge11
merge11:
  %t87 = phi double [ %t86, %then10 ], [ %t85, %loop.body1 ]
  store double %t87, double* %l12
  %t88 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t89 = load i8*, i8** %l3
  %t90 = insertvalue %StructTypeInfo undef, i8* null, 0
  %t91 = load double, double* %l6
  %t92 = insertvalue %StructTypeInfo %t90, i8* null, 1
  %t93 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t94 = insertvalue %StructTypeInfo %t92, { i8**, i64 }* null, 2
  %t95 = load double, double* %l4
  %t96 = insertvalue %StructTypeInfo %t94, double 0.0, 3
  %t97 = load double, double* %l12
  %t98 = insertvalue %StructTypeInfo %t96, double %t97, 4
  %t99 = call { %StructTypeInfo*, i64 }* @append_struct_type_info({ %StructTypeInfo*, i64 }* %t88, %StructTypeInfo %t98)
  store { %StructTypeInfo*, i64 }* %t99, { %StructTypeInfo*, i64 }** %l1
  %t100 = load double, double* %l2
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l2
  br label %loop.latch2
loop.latch2:
  %t103 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t104 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t107 = alloca [0 x double]
  %t108 = getelementptr [0 x double], [0 x double]* %t107, i32 0, i32 0
  %t109 = alloca { double*, i64 }
  %t110 = getelementptr { double*, i64 }, { double*, i64 }* %t109, i32 0, i32 0
  store double* %t108, double** %t110
  %t111 = getelementptr { double*, i64 }, { double*, i64 }* %t109, i32 0, i32 1
  store i64 0, i64* %t111
  store { %EnumTypeInfo*, i64 }* null, { %EnumTypeInfo*, i64 }** %l13
  %t112 = sitofp i64 0 to double
  store double %t112, double* %l14
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t115 = load double, double* %l2
  %t116 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t117 = load double, double* %l14
  br label %loop.header12
loop.header12:
  %t233 = phi { %EnumTypeInfo*, i64 }* [ %t116, %entry ], [ %t231, %loop.latch14 ]
  %t234 = phi double [ %t117, %entry ], [ %t232, %loop.latch14 ]
  store { %EnumTypeInfo*, i64 }* %t233, { %EnumTypeInfo*, i64 }** %l13
  store double %t234, double* %l14
  br label %loop.body13
loop.body13:
  %t118 = load double, double* %l14
  %t119 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t120 = extractvalue { i8**, i64 } %t119, 1
  %t121 = sitofp i64 %t120 to double
  %t122 = fcmp oge double %t118, %t121
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t125 = load double, double* %l2
  %t126 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t127 = load double, double* %l14
  br i1 %t122, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t128 = load double, double* %l14
  %t129 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t130 = extractvalue { i8**, i64 } %t129, 0
  %t131 = extractvalue { i8**, i64 } %t129, 1
  %t132 = icmp uge i64 %t128, %t131
  ; bounds check: %t132 (if true, out of bounds)
  %t133 = getelementptr i8*, i8** %t130, i64 %t128
  %t134 = load i8*, i8** %t133
  store i8* %t134, i8** %l15
  %t135 = load i8*, i8** %l15
  %t136 = load i8*, i8** %l15
  store double 0.0, double* %l16
  %t137 = load i8*, i8** %l15
  store double 0.0, double* %l17
  %s138 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.138, i32 0, i32 0
  %t139 = load double, double* %l17
  store double 0.0, double* %l18
  %t140 = alloca [0 x double]
  %t141 = getelementptr [0 x double], [0 x double]* %t140, i32 0, i32 0
  %t142 = alloca { double*, i64 }
  %t143 = getelementptr { double*, i64 }, { double*, i64 }* %t142, i32 0, i32 0
  store double* %t141, double** %t143
  %t144 = getelementptr { double*, i64 }, { double*, i64 }* %t142, i32 0, i32 1
  store i64 0, i64* %t144
  store { %EnumVariantInfo*, i64 }* null, { %EnumVariantInfo*, i64 }** %l19
  %t145 = sitofp i64 0 to double
  store double %t145, double* %l20
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t148 = load double, double* %l2
  %t149 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t150 = load double, double* %l14
  %t151 = load i8*, i8** %l15
  %t152 = load double, double* %l16
  %t153 = load double, double* %l17
  %t154 = load double, double* %l18
  %t155 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t156 = load double, double* %l20
  br label %loop.header18
loop.header18:
  %t208 = phi { %EnumVariantInfo*, i64 }* [ %t155, %loop.body13 ], [ %t206, %loop.latch20 ]
  %t209 = phi double [ %t156, %loop.body13 ], [ %t207, %loop.latch20 ]
  store { %EnumVariantInfo*, i64 }* %t208, { %EnumVariantInfo*, i64 }** %l19
  store double %t209, double* %l20
  br label %loop.body19
loop.body19:
  %t157 = load double, double* %l20
  %t158 = load double, double* %l16
  %t159 = load double, double* %l16
  store double 0.0, double* %l21
  %t160 = alloca [0 x double]
  %t161 = getelementptr [0 x double], [0 x double]* %t160, i32 0, i32 0
  %t162 = alloca { double*, i64 }
  %t163 = getelementptr { double*, i64 }, { double*, i64 }* %t162, i32 0, i32 0
  store double* %t161, double** %t163
  %t164 = getelementptr { double*, i64 }, { double*, i64 }* %t162, i32 0, i32 1
  store i64 0, i64* %t164
  store { %StructFieldInfo*, i64 }* null, { %StructFieldInfo*, i64 }** %l22
  %t165 = sitofp i64 0 to double
  store double %t165, double* %l23
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t168 = load double, double* %l2
  %t169 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t170 = load double, double* %l14
  %t171 = load i8*, i8** %l15
  %t172 = load double, double* %l16
  %t173 = load double, double* %l17
  %t174 = load double, double* %l18
  %t175 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t176 = load double, double* %l20
  %t177 = load double, double* %l21
  %t178 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t179 = load double, double* %l23
  br label %loop.header22
loop.header22:
  %t201 = phi { %StructFieldInfo*, i64 }* [ %t178, %loop.body19 ], [ %t199, %loop.latch24 ]
  %t202 = phi double [ %t179, %loop.body19 ], [ %t200, %loop.latch24 ]
  store { %StructFieldInfo*, i64 }* %t201, { %StructFieldInfo*, i64 }** %l22
  store double %t202, double* %l23
  br label %loop.body23
loop.body23:
  %t180 = load double, double* %l23
  %t181 = load double, double* %l21
  %t182 = load double, double* %l21
  store double 0.0, double* %l24
  %t183 = load double, double* %l24
  store double 0.0, double* %l25
  %t184 = load double, double* %l25
  store i8* null, i8** %l26
  %t185 = load i8*, i8** %l26
  %t186 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t187 = load double, double* %l24
  %t188 = insertvalue %StructFieldInfo undef, i8* null, 0
  %t189 = load i8*, i8** %l26
  %t190 = insertvalue %StructFieldInfo %t188, i8* %t189, 1
  %t191 = load double, double* %l23
  %t192 = insertvalue %StructFieldInfo %t190, double %t191, 2
  %t193 = load double, double* %l24
  %t194 = insertvalue %StructFieldInfo %t192, double 0.0, 3
  %t195 = call { %StructFieldInfo*, i64 }* @append_struct_field_info({ %StructFieldInfo*, i64 }* %t186, %StructFieldInfo %t194)
  store { %StructFieldInfo*, i64 }* %t195, { %StructFieldInfo*, i64 }** %l22
  %t196 = load double, double* %l23
  %t197 = sitofp i64 1 to double
  %t198 = fadd double %t196, %t197
  store double %t198, double* %l23
  br label %loop.latch24
loop.latch24:
  %t199 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t200 = load double, double* %l23
  br label %loop.header22
afterloop25:
  %t203 = load double, double* %l20
  %t204 = sitofp i64 1 to double
  %t205 = fadd double %t203, %t204
  store double %t205, double* %l20
  br label %loop.latch20
loop.latch20:
  %t206 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t207 = load double, double* %l20
  br label %loop.header18
afterloop21:
  %t210 = load double, double* %l16
  store double 0.0, double* %l27
  %t211 = load double, double* %l27
  %t212 = sitofp i64 0 to double
  %t213 = fcmp ole double %t211, %t212
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t216 = load double, double* %l2
  %t217 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t218 = load double, double* %l14
  %t219 = load i8*, i8** %l15
  %t220 = load double, double* %l16
  %t221 = load double, double* %l17
  %t222 = load double, double* %l18
  %t223 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t224 = load double, double* %l20
  %t225 = load double, double* %l27
  br i1 %t213, label %then26, label %merge27
then26:
  %t226 = sitofp i64 1 to double
  store double %t226, double* %l27
  br label %merge27
merge27:
  %t227 = phi double [ %t226, %then26 ], [ %t225, %loop.body13 ]
  store double %t227, double* %l27
  %t228 = load double, double* %l14
  %t229 = sitofp i64 1 to double
  %t230 = fadd double %t228, %t229
  store double %t230, double* %l14
  br label %loop.latch14
loop.latch14:
  %t231 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t232 = load double, double* %l14
  br label %loop.header12
afterloop15:
  %t235 = alloca [0 x double]
  %t236 = getelementptr [0 x double], [0 x double]* %t235, i32 0, i32 0
  %t237 = alloca { double*, i64 }
  %t238 = getelementptr { double*, i64 }, { double*, i64 }* %t237, i32 0, i32 0
  store double* %t236, double** %t238
  %t239 = getelementptr { double*, i64 }, { double*, i64 }* %t237, i32 0, i32 1
  store i64 0, i64* %t239
  store { %InterfaceTypeInfo*, i64 }* null, { %InterfaceTypeInfo*, i64 }** %l28
  %t240 = sitofp i64 0 to double
  store double %t240, double* %l29
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t243 = load double, double* %l2
  %t244 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t245 = load double, double* %l14
  %t246 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t247 = load double, double* %l29
  br label %loop.header28
loop.header28:
  %t275 = phi { %InterfaceTypeInfo*, i64 }* [ %t246, %entry ], [ %t273, %loop.latch30 ]
  %t276 = phi double [ %t247, %entry ], [ %t274, %loop.latch30 ]
  store { %InterfaceTypeInfo*, i64 }* %t275, { %InterfaceTypeInfo*, i64 }** %l28
  store double %t276, double* %l29
  br label %loop.body29
loop.body29:
  %t248 = load double, double* %l29
  %t249 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t250 = extractvalue { i8**, i64 } %t249, 1
  %t251 = sitofp i64 %t250 to double
  %t252 = fcmp oge double %t248, %t251
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t254 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t255 = load double, double* %l2
  %t256 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t257 = load double, double* %l14
  %t258 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t259 = load double, double* %l29
  br i1 %t252, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t260 = load double, double* %l29
  %t261 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t262 = extractvalue { i8**, i64 } %t261, 0
  %t263 = extractvalue { i8**, i64 } %t261, 1
  %t264 = icmp uge i64 %t260, %t263
  ; bounds check: %t264 (if true, out of bounds)
  %t265 = getelementptr i8*, i8** %t262, i64 %t260
  %t266 = load i8*, i8** %t265
  store i8* %t266, i8** %l30
  %t267 = load i8*, i8** %l30
  store double 0.0, double* %l31
  %s268 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.268, i32 0, i32 0
  %t269 = load double, double* %l31
  store double 0.0, double* %l32
  %t270 = load double, double* %l29
  %t271 = sitofp i64 1 to double
  %t272 = fadd double %t270, %t271
  store double %t272, double* %l29
  br label %loop.latch30
loop.latch30:
  %t273 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t274 = load double, double* %l29
  br label %loop.header28
afterloop31:
  %t277 = alloca [0 x double]
  %t278 = getelementptr [0 x double], [0 x double]* %t277, i32 0, i32 0
  %t279 = alloca { double*, i64 }
  %t280 = getelementptr { double*, i64 }, { double*, i64 }* %t279, i32 0, i32 0
  store double* %t278, double** %t280
  %t281 = getelementptr { double*, i64 }, { double*, i64 }* %t279, i32 0, i32 1
  store i64 0, i64* %t281
  store { %VTableInfo*, i64 }* null, { %VTableInfo*, i64 }** %l33
  %t282 = sitofp i64 0 to double
  store double %t282, double* %l34
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t284 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t285 = load double, double* %l2
  %t286 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t287 = load double, double* %l14
  %t288 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t289 = load double, double* %l29
  %t290 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t291 = load double, double* %l34
  br label %loop.header34
loop.header34:
  %t497 = phi { i8**, i64 }* [ %t283, %entry ], [ %t494, %loop.latch36 ]
  %t498 = phi { %VTableInfo*, i64 }* [ %t290, %entry ], [ %t495, %loop.latch36 ]
  %t499 = phi double [ %t291, %entry ], [ %t496, %loop.latch36 ]
  store { i8**, i64 }* %t497, { i8**, i64 }** %l0
  store { %VTableInfo*, i64 }* %t498, { %VTableInfo*, i64 }** %l33
  store double %t499, double* %l34
  br label %loop.body35
loop.body35:
  %t292 = load double, double* %l34
  %t293 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t294 = extractvalue { i8**, i64 } %t293, 1
  %t295 = sitofp i64 %t294 to double
  %t296 = fcmp oge double %t292, %t295
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t299 = load double, double* %l2
  %t300 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t301 = load double, double* %l14
  %t302 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t303 = load double, double* %l29
  %t304 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t305 = load double, double* %l34
  br i1 %t296, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t306 = load double, double* %l34
  %t307 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t308 = extractvalue { i8**, i64 } %t307, 0
  %t309 = extractvalue { i8**, i64 } %t307, 1
  %t310 = icmp uge i64 %t306, %t309
  ; bounds check: %t310 (if true, out of bounds)
  %t311 = getelementptr i8*, i8** %t308, i64 %t306
  %t312 = load i8*, i8** %t311
  store i8* %t312, i8** %l35
  %t313 = sitofp i64 0 to double
  store double %t313, double* %l36
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t315 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t316 = load double, double* %l2
  %t317 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t318 = load double, double* %l14
  %t319 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t320 = load double, double* %l29
  %t321 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t322 = load double, double* %l34
  %t323 = load i8*, i8** %l35
  %t324 = load double, double* %l36
  br label %loop.header40
loop.header40:
  %t488 = phi { i8**, i64 }* [ %t314, %loop.body35 ], [ %t485, %loop.latch42 ]
  %t489 = phi double [ %t324, %loop.body35 ], [ %t486, %loop.latch42 ]
  %t490 = phi { %VTableInfo*, i64 }* [ %t321, %loop.body35 ], [ %t487, %loop.latch42 ]
  store { i8**, i64 }* %t488, { i8**, i64 }** %l0
  store double %t489, double* %l36
  store { %VTableInfo*, i64 }* %t490, { %VTableInfo*, i64 }** %l33
  br label %loop.body41
loop.body41:
  %t325 = load double, double* %l36
  %t326 = load i8*, i8** %l35
  %t327 = load i8*, i8** %l35
  store double 0.0, double* %l37
  store i8* null, i8** %l38
  %t328 = sitofp i64 0 to double
  store double %t328, double* %l39
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t330 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t331 = load double, double* %l2
  %t332 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t333 = load double, double* %l14
  %t334 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t335 = load double, double* %l29
  %t336 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t337 = load double, double* %l34
  %t338 = load i8*, i8** %l35
  %t339 = load double, double* %l36
  %t340 = load double, double* %l37
  %t341 = load i8*, i8** %l38
  %t342 = load double, double* %l39
  br label %loop.header44
loop.header44:
  %t373 = phi double [ %t342, %loop.body41 ], [ %t372, %loop.latch46 ]
  store double %t373, double* %l39
  br label %loop.body45
loop.body45:
  %t343 = load double, double* %l39
  %t344 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t345 = extractvalue { i8**, i64 } %t344, 1
  %t346 = sitofp i64 %t345 to double
  %t347 = fcmp oge double %t343, %t346
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t349 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t350 = load double, double* %l2
  %t351 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t352 = load double, double* %l14
  %t353 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t354 = load double, double* %l29
  %t355 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t356 = load double, double* %l34
  %t357 = load i8*, i8** %l35
  %t358 = load double, double* %l36
  %t359 = load double, double* %l37
  %t360 = load i8*, i8** %l38
  %t361 = load double, double* %l39
  br i1 %t347, label %then48, label %merge49
then48:
  br label %afterloop47
merge49:
  %t362 = load double, double* %l39
  %t363 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t364 = extractvalue { i8**, i64 } %t363, 0
  %t365 = extractvalue { i8**, i64 } %t363, 1
  %t366 = icmp uge i64 %t362, %t365
  ; bounds check: %t366 (if true, out of bounds)
  %t367 = getelementptr i8*, i8** %t364, i64 %t362
  %t368 = load i8*, i8** %t367
  %t369 = load double, double* %l39
  %t370 = sitofp i64 1 to double
  %t371 = fadd double %t369, %t370
  store double %t371, double* %l39
  br label %loop.latch46
loop.latch46:
  %t372 = load double, double* %l39
  br label %loop.header44
afterloop47:
  %t374 = load i8*, i8** %l38
  %t375 = icmp eq i8* %t374, null
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t377 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t378 = load double, double* %l2
  %t379 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t380 = load double, double* %l14
  %t381 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t382 = load double, double* %l29
  %t383 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t384 = load double, double* %l34
  %t385 = load i8*, i8** %l35
  %t386 = load double, double* %l36
  %t387 = load double, double* %l37
  %t388 = load i8*, i8** %l38
  %t389 = load double, double* %l39
  br i1 %t375, label %then50, label %merge51
then50:
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s391 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.391, i32 0, i32 0
  %t392 = load i8*, i8** %l35
  %t393 = load double, double* %l36
  %t394 = sitofp i64 1 to double
  %t395 = fadd double %t393, %t394
  store double %t395, double* %l36
  br label %loop.latch42
merge51:
  %t396 = load i8*, i8** %l38
  store i8* %t396, i8** %l40
  %t397 = load i8*, i8** %l35
  store double 0.0, double* %l41
  %t398 = load double, double* %l37
  %t399 = call i8* @sanitize_symbol(i8* null)
  store i8* %t399, i8** %l42
  %s400 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.400, i32 0, i32 0
  %t401 = load double, double* %l41
  store double 0.0, double* %l43
  %s402 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.402, i32 0, i32 0
  %t403 = load double, double* %l41
  store double 0.0, double* %l44
  %t404 = alloca [0 x double]
  %t405 = getelementptr [0 x double], [0 x double]* %t404, i32 0, i32 0
  %t406 = alloca { double*, i64 }
  %t407 = getelementptr { double*, i64 }, { double*, i64 }* %t406, i32 0, i32 0
  store double* %t405, double** %t407
  %t408 = getelementptr { double*, i64 }, { double*, i64 }* %t406, i32 0, i32 1
  store i64 0, i64* %t408
  store { %VTableEntry*, i64 }* null, { %VTableEntry*, i64 }** %l45
  %t409 = sitofp i64 0 to double
  store double %t409, double* %l46
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t411 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t412 = load double, double* %l2
  %t413 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t414 = load double, double* %l14
  %t415 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t416 = load double, double* %l29
  %t417 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t418 = load double, double* %l34
  %t419 = load i8*, i8** %l35
  %t420 = load double, double* %l36
  %t421 = load double, double* %l37
  %t422 = load i8*, i8** %l38
  %t423 = load double, double* %l39
  %t424 = load i8*, i8** %l40
  %t425 = load double, double* %l41
  %t426 = load i8*, i8** %l42
  %t427 = load double, double* %l43
  %t428 = load double, double* %l44
  %t429 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t430 = load double, double* %l46
  br label %loop.header52
loop.header52:
  %t480 = phi { %VTableEntry*, i64 }* [ %t429, %loop.body41 ], [ %t478, %loop.latch54 ]
  %t481 = phi double [ %t430, %loop.body41 ], [ %t479, %loop.latch54 ]
  store { %VTableEntry*, i64 }* %t480, { %VTableEntry*, i64 }** %l45
  store double %t481, double* %l46
  br label %loop.body53
loop.body53:
  %t431 = load double, double* %l46
  %t432 = load i8*, i8** %l40
  %t433 = load i8*, i8** %l40
  store double 0.0, double* %l47
  store { i8**, i64 }* null, { i8**, i64 }** %l48
  %t434 = sitofp i64 1 to double
  store double %t434, double* %l49
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t436 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t437 = load double, double* %l2
  %t438 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t439 = load double, double* %l14
  %t440 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t441 = load double, double* %l29
  %t442 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t443 = load double, double* %l34
  %t444 = load i8*, i8** %l35
  %t445 = load double, double* %l36
  %t446 = load double, double* %l37
  %t447 = load i8*, i8** %l38
  %t448 = load double, double* %l39
  %t449 = load i8*, i8** %l40
  %t450 = load double, double* %l41
  %t451 = load i8*, i8** %l42
  %t452 = load double, double* %l43
  %t453 = load double, double* %l44
  %t454 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t455 = load double, double* %l46
  %t456 = load double, double* %l47
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t458 = load double, double* %l49
  br label %loop.header56
loop.header56:
  %t471 = phi { i8**, i64 }* [ %t457, %loop.body53 ], [ %t469, %loop.latch58 ]
  %t472 = phi double [ %t458, %loop.body53 ], [ %t470, %loop.latch58 ]
  store { i8**, i64 }* %t471, { i8**, i64 }** %l48
  store double %t472, double* %l49
  br label %loop.body57
loop.body57:
  %t459 = load double, double* %l49
  %t460 = load double, double* %l47
  %t461 = load double, double* %l47
  store double 0.0, double* %l50
  %t462 = load double, double* %l50
  store double 0.0, double* %l51
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t464 = load double, double* %l51
  %t465 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t463, i8* null)
  store { i8**, i64 }* %t465, { i8**, i64 }** %l48
  %t466 = load double, double* %l49
  %t467 = sitofp i64 1 to double
  %t468 = fadd double %t466, %t467
  store double %t468, double* %l49
  br label %loop.latch58
loop.latch58:
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t470 = load double, double* %l49
  br label %loop.header56
afterloop59:
  %t473 = load double, double* %l47
  store double 0.0, double* %l52
  %t474 = load double, double* %l52
  store double 0.0, double* %l53
  %t475 = load double, double* %l46
  %t476 = sitofp i64 1 to double
  %t477 = fadd double %t475, %t476
  store double %t477, double* %l46
  br label %loop.latch54
loop.latch54:
  %t478 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t479 = load double, double* %l46
  br label %loop.header52
afterloop55:
  %t482 = load double, double* %l36
  %t483 = sitofp i64 1 to double
  %t484 = fadd double %t482, %t483
  store double %t484, double* %l36
  br label %loop.latch42
loop.latch42:
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t486 = load double, double* %l36
  %t487 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  br label %loop.header40
afterloop43:
  %t491 = load double, double* %l34
  %t492 = sitofp i64 1 to double
  %t493 = fadd double %t491, %t492
  store double %t493, double* %l34
  br label %loop.latch36
loop.latch36:
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t495 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t496 = load double, double* %l34
  br label %loop.header34
afterloop37:
  %t500 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t501 = insertvalue %TypeContext undef, { i8**, i64 }* null, 0
  %t502 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t503 = insertvalue %TypeContext %t501, { i8**, i64 }* null, 1
  %t504 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t505 = insertvalue %TypeContext %t503, { i8**, i64 }* null, 2
  %t506 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t507 = insertvalue %TypeContext %t505, { i8**, i64 }* null, 3
  %t508 = insertvalue %TypeContextBuild undef, i8* null, 0
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t510 = insertvalue %TypeContextBuild %t508, { i8**, i64 }* %t509, 1
  ret %TypeContextBuild %t510
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

define { i8**, i64 }* @append_native_function({ i8**, i64 }* %values, i8* %value) {
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

define { i8**, i64 }* @concat_native_functions({ i8**, i64 }* %first, { i8**, i64 }* %second) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  store { i8**, i64 }* %first, { i8**, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi { i8**, i64 }* [ %t1, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t2, %entry ], [ %t23, %loop.latch2 ]
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %second
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %second
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  %t18 = call { i8**, i64 }* @append_native_function({ i8**, i64 }* %t10, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t26
}

define { i8**, i64 }* @flatten_struct_methods({ i8**, i64 }* %structs) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t46 = phi { i8**, i64 }* [ %t6, %entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t7, %entry ], [ %t45, %loop.latch2 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  store double %t47, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t39 = phi { i8**, i64 }* [ %t23, %loop.body1 ], [ %t37, %loop.latch8 ]
  %t40 = phi double [ %t26, %loop.body1 ], [ %t38, %loop.latch8 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l3
  br label %loop.body7
loop.body7:
  %t27 = load double, double* %l3
  %t28 = load i8*, i8** %l2
  %t29 = load i8*, i8** %l2
  store double 0.0, double* %l4
  %t30 = load i8*, i8** %l2
  store double 0.0, double* %l5
  store double 0.0, double* %l6
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l6
  %t33 = call { i8**, i64 }* @append_native_function({ i8**, i64 }* %t31, i8* null)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l3
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l3
  br label %loop.latch8
loop.latch8:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t48
}

define { i8**, i64 }* @render_struct_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t68 = phi { i8**, i64 }* [ %t6, %entry ], [ %t66, %loop.latch2 ]
  %t69 = phi double [ %t7, %entry ], [ %t67, %loop.latch2 ]
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  store double %t69, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 0
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %TypeContext %context, 0
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l4
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t34 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t44 = phi { i8**, i64 }* [ %t33, %loop.body1 ], [ %t42, %loop.latch8 ]
  %t45 = phi double [ %t34, %loop.body1 ], [ %t43, %loop.latch8 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l3
  store double %t45, double* %l4
  br label %loop.body7
loop.body7:
  %t35 = load double, double* %l4
  %t36 = load i8*, i8** %l2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l4
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l4
  br label %loop.latch8
loop.latch8:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.46, i32 0, i32 0
  store i8* %s46, i8** %l5
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp eq i64 %t49, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load i8*, i8** %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l4
  %t56 = load i8*, i8** %l5
  br i1 %t50, label %then10, label %else11
then10:
  %s57 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.57, i32 0, i32 0
  store i8* %s57, i8** %l5
  br label %merge12
else11:
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.58, i32 0, i32 0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %merge12
merge12:
  %t60 = phi i8* [ %s57, %then10 ], [ null, %else11 ]
  store i8* %t60, i8** %l5
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l2
  %t63 = load double, double* %l1
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  store double %t65, double* %l1
  br label %loop.latch2
loop.latch2:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t70
}

define { i8**, i64 }* @render_enum_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t78 = phi { i8**, i64 }* [ %t6, %entry ], [ %t76, %loop.latch2 ]
  %t79 = phi double [ %t7, %entry ], [ %t77, %loop.latch2 ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l0
  store double %t79, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %TypeContext %context, 1
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %s24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.24, i32 0, i32 0
  store i8* %s24, i8** %l3
  %t25 = load i8*, i8** %l2
  %t26 = load i8*, i8** %l2
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l2
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l4
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l5
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load i8*, i8** %l3
  %t35 = load double, double* %l4
  %t36 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t45 = phi double [ %t36, %loop.body1 ], [ %t44, %loop.latch8 ]
  store double %t45, double* %l5
  br label %loop.body7
loop.body7:
  %t37 = load double, double* %l5
  %t38 = load i8*, i8** %l2
  %t39 = load i8*, i8** %l2
  store double 0.0, double* %l6
  %t40 = load double, double* %l6
  %t41 = load double, double* %l5
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l5
  br label %loop.latch8
loop.latch8:
  %t44 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.46, i32 0, i32 0
  store i8* %s46, i8** %l7
  %t47 = load double, double* %l4
  %t48 = sitofp i64 0 to double
  %t49 = fcmp ogt double %t47, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load i8*, i8** %l3
  %t54 = load double, double* %l4
  %t55 = load double, double* %l5
  %t56 = load i8*, i8** %l7
  br i1 %t49, label %then10, label %merge11
then10:
  %s57 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.57, i32 0, i32 0
  %t58 = load double, double* %l4
  %t59 = call i8* @number_to_string(double %t58)
  %t60 = add i8* %s57, %t59
  %s61 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.61, i32 0, i32 0
  %t62 = add i8* %t60, %s61
  store i8* %t62, i8** %l7
  br label %merge11
merge11:
  %t63 = phi i8* [ %t62, %then10 ], [ %t56, %loop.body1 ]
  store i8* %t63, i8** %l7
  %s64 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.64, i32 0, i32 0
  %t65 = load i8*, i8** %l3
  %t66 = add i8* %s64, %t65
  %t67 = load i8*, i8** %l7
  %t68 = add i8* %t66, %t67
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.69, i32 0, i32 0
  %t70 = add i8* %t68, %s69
  store i8* %t70, i8** %l8
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l2
  %t73 = load double, double* %l1
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l1
  br label %loop.latch2
loop.latch2:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t80
}

define { i8**, i64 }* @render_interface_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 2
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %TypeContext %context, 2
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  store double 0.0, double* %l3
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t33
}

define { i8**, i64 }* @render_vtable_type_definitions(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t68 = phi { i8**, i64 }* [ %t6, %entry ], [ %t66, %loop.latch2 ]
  %t69 = phi double [ %t7, %entry ], [ %t67, %loop.latch2 ]
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  store double %t69, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 3
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %TypeContext %context, 3
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l4
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t34 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t44 = phi { i8**, i64 }* [ %t33, %loop.body1 ], [ %t42, %loop.latch8 ]
  %t45 = phi double [ %t34, %loop.body1 ], [ %t43, %loop.latch8 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l3
  store double %t45, double* %l4
  br label %loop.body7
loop.body7:
  %t35 = load double, double* %l4
  %t36 = load i8*, i8** %l2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l4
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l4
  br label %loop.latch8
loop.latch8:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.46, i32 0, i32 0
  store i8* %s46, i8** %l5
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp eq i64 %t49, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load i8*, i8** %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l4
  %t56 = load i8*, i8** %l5
  br i1 %t50, label %then10, label %else11
then10:
  %s57 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.57, i32 0, i32 0
  store i8* %s57, i8** %l5
  br label %merge12
else11:
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.58, i32 0, i32 0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %merge12
merge12:
  %t60 = phi i8* [ %s57, %then10 ], [ null, %else11 ]
  store i8* %t60, i8** %l5
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l2
  %t63 = load double, double* %l1
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  store double %t65, double* %l1
  br label %loop.latch2
loop.latch2:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t70
}

define { i8**, i64 }* @render_vtable_constants(%TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t73 = phi { i8**, i64 }* [ %t6, %entry ], [ %t71, %loop.latch2 ]
  %t74 = phi double [ %t7, %entry ], [ %t72, %loop.latch2 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  store double %t74, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 3
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %TypeContext %context, 3
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l4
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t34 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t49 = phi { i8**, i64 }* [ %t33, %loop.body1 ], [ %t47, %loop.latch8 ]
  %t50 = phi double [ %t34, %loop.body1 ], [ %t48, %loop.latch8 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l3
  store double %t50, double* %l4
  br label %loop.body7
loop.body7:
  %t35 = load double, double* %l4
  %t36 = load i8*, i8** %l2
  %t37 = load i8*, i8** %l2
  store double 0.0, double* %l5
  %t38 = load double, double* %l5
  store double 0.0, double* %l6
  %s39 = getelementptr inbounds [111 x i8], [111 x i8]* @.str.39, i32 0, i32 0
  store i8* %s39, i8** %l7
  %t40 = load double, double* %l5
  store double 0.0, double* %l8
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load double, double* %l8
  %t43 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t41, i8* null)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l3
  %t44 = load double, double* %l4
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l4
  br label %loop.latch8
loop.latch8:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %s51 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.51, i32 0, i32 0
  store i8* %s51, i8** %l9
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t53 = load { i8**, i64 }, { i8**, i64 }* %t52
  %t54 = extractvalue { i8**, i64 } %t53, 1
  %t55 = icmp eq i64 %t54, 0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = load i8*, i8** %l2
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t60 = load double, double* %l4
  %t61 = load i8*, i8** %l9
  br i1 %t55, label %then10, label %else11
then10:
  %s62 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.62, i32 0, i32 0
  store i8* %s62, i8** %l9
  br label %merge12
else11:
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %merge12
merge12:
  %t65 = phi i8* [ %s62, %then10 ], [ null, %else11 ]
  store i8* %t65, i8** %l9
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l2
  %t68 = load double, double* %l1
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l1
  br label %loop.latch2
loop.latch2:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t75
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
  %t6 = icmp eq i8* %t4, %s5
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %s9 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
merge1:
  %t11 = load i8*, i8** %l1
  %s12 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.12, i32 0, i32 0
  %t13 = icmp eq i8* %t11, %s12
  br label %logical_or_entry_10

logical_or_entry_10:
  br i1 %t13, label %logical_or_merge_10, label %logical_or_right_10

logical_or_right_10:
  %t14 = load i8*, i8** %l1
  %s15 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.15, i32 0, i32 0
  %t16 = icmp eq i8* %t14, %s15
  br label %logical_or_right_end_10

logical_or_right_end_10:
  br label %logical_or_merge_10

logical_or_merge_10:
  %t17 = phi i1 [ true, %logical_or_entry_10 ], [ %t16, %logical_or_right_end_10 ]
  %t18 = load i8*, i8** %l0
  %t19 = load i8*, i8** %l1
  br i1 %t17, label %then2, label %merge3
then2:
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.20, i32 0, i32 0
  ret i8* %s20
merge3:
  %t22 = load i8*, i8** %l1
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.23, i32 0, i32 0
  %t24 = icmp eq i8* %t22, %s23
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load i8*, i8** %l1
  %s26 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.26, i32 0, i32 0
  %t27 = icmp eq i8* %t25, %s26
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t28 = phi i1 [ true, %logical_or_entry_21 ], [ %t27, %logical_or_right_end_21 ]
  %t29 = load i8*, i8** %l0
  %t30 = load i8*, i8** %l1
  br i1 %t28, label %then4, label %merge5
then4:
  %s31 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.31, i32 0, i32 0
  ret i8* %s31
merge5:
  %t32 = load i8*, i8** %l1
  %s33 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp eq i8* %t32, %s33
  %t35 = load i8*, i8** %l0
  %t36 = load i8*, i8** %l1
  br i1 %t34, label %then6, label %merge7
then6:
  %s37 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.37, i32 0, i32 0
  ret i8* %s37
merge7:
  %t38 = load i8*, i8** %l1
  %s39 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.39, i32 0, i32 0
  %t40 = icmp eq i8* %t38, %s39
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l1
  br i1 %t40, label %then8, label %merge9
then8:
  ret i8* null
merge9:
  %t43 = load i8*, i8** %l1
  %s44 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.44, i32 0, i32 0
  %t45 = icmp eq i8* %t43, %s44
  %t46 = load i8*, i8** %l0
  %t47 = load i8*, i8** %l1
  br i1 %t45, label %then10, label %merge11
then10:
  %s48 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.48, i32 0, i32 0
  ret i8* %s48
merge11:
  %t49 = load i8*, i8** %l1
  ret i8* null
}

define i8* @map_struct_field_annotation(i8* %annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @map_type_annotation(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = icmp eq i8* %t1, %s2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge1:
  %t6 = load i8*, i8** %l0
  ret i8* %t6
}

define { %FunctionEffectEntry*, i64 }* @collect_direct_function_effects({ i8**, i64 }* %functions) {
entry:
  %l0 = alloca { %FunctionEffectEntry*, i64 }*
  %l1 = alloca double
  %l2 = alloca %FunctionEffectEntry
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
  %t31 = phi { %FunctionEffectEntry*, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t31, { %FunctionEffectEntry*, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call %FunctionEffectEntry @collect_function_effect_entry(i8* %t21)
  store %FunctionEffectEntry %t22, %FunctionEffectEntry* %l2
  %t23 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t24 = load %FunctionEffectEntry, %FunctionEffectEntry* %l2
  %t25 = call { %FunctionEffectEntry*, i64 }* @append_function_effect_entry({ %FunctionEffectEntry*, i64 }* %t23, %FunctionEffectEntry %t24)
  store { %FunctionEffectEntry*, i64 }* %t25, { %FunctionEffectEntry*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  ret { %FunctionEffectEntry*, i64 }* %t33
}

define { %FunctionCallEntry*, i64 }* @collect_function_call_graph({ i8**, i64 }* %functions) {
entry:
  %l0 = alloca { %FunctionCallEntry*, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %FunctionCallEntry
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %FunctionCallEntry*, i64 }* null, { %FunctionCallEntry*, i64 }** %l0
  %t5 = call { i8**, i64 }* @collect_function_names({ i8**, i64 }* %functions)
  store { i8**, i64 }* %t5, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t35 = phi { %FunctionCallEntry*, i64 }* [ %t7, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t9, %entry ], [ %t34, %loop.latch2 ]
  store { %FunctionCallEntry*, i64 }* %t35, { %FunctionCallEntry*, i64 }** %l0
  store double %t36, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load double, double* %l2
  %t19 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t20 = extractvalue { i8**, i64 } %t19, 0
  %t21 = extractvalue { i8**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr i8*, i8** %t20, i64 %t18
  %t24 = load i8*, i8** %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = call %FunctionCallEntry @collect_function_call_entry(i8* %t24, { i8**, i64 }* %t25)
  store %FunctionCallEntry %t26, %FunctionCallEntry* %l3
  %t27 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t28 = load %FunctionCallEntry, %FunctionCallEntry* %l3
  %t29 = call { %FunctionCallEntry*, i64 }* @append_function_call_entry({ %FunctionCallEntry*, i64 }* %t27, %FunctionCallEntry %t28)
  store { %FunctionCallEntry*, i64 }* %t29, { %FunctionCallEntry*, i64 }** %l0
  %t30 = load double, double* %l2
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l2
  br label %loop.latch2
loop.latch2:
  %t33 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t34 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t37 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  ret { %FunctionCallEntry*, i64 }* %t37
}

define %FunctionCallEntry @collect_function_call_entry(i8* %function, { i8**, i64 }* %function_names) {
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
  %t18 = phi { i8**, i64 }* [ %t6, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t7, %entry ], [ %t17, %loop.latch2 ]
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = call { i8**, i64 }* @collect_instruction_calls(i8* null, { i8**, i64 }* %function_names)
  %t12 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t9, { i8**, i64 }* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l0
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t20 = insertvalue %FunctionCallEntry undef, i8* null, 0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = insertvalue %FunctionCallEntry %t20, { i8**, i64 }* %t21, 1
  ret %FunctionCallEntry %t22
}

define { i8**, i64 }* @collect_runtime_helper_targets({ i8**, i64 }* %functions) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
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
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call { i8**, i64 }* @collect_function_runtime_helper_targets(i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t23, { i8**, i64 }* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t33
}

define { i8**, i64 }* @collect_function_runtime_helper_targets(i8* %function) {
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
  %t19 = phi { i8**, i64 }* [ %t6, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t7, %entry ], [ %t18, %loop.latch2 ]
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = call { i8**, i64 }* @collect_instruction_runtime_helper_targets(i8* null)
  store { i8**, i64 }* %t10, { i8**, i64 }** %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t13 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t11, { i8**, i64 }* %t12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t21
}

define { i8**, i64 }* @collect_instruction_runtime_helper_targets(i8* %instruction) {
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

define { i8**, i64 }* @collect_instruction_calls(i8* %instruction, { i8**, i64 }* %function_names) {
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

define { i8**, i64 }* @collect_function_names({ i8**, i64 }* %functions) {
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
  %t28 = phi { i8**, i64 }* [ %t6, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi double [ %t7, %entry ], [ %t27, %loop.latch2 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  store double %t29, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t30
}

define { i8**, i64 }* @extract_call_targets(i8* %expression, { i8**, i64 }* %function_names) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8
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
  %t54 = phi double [ %t7, %entry ], [ %t53, %loop.latch2 ]
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = getelementptr i8, i8* %expression, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l2
  %t12 = load i8, i8* %l2
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8, i8* %l2
  %t15 = call i1 @is_identifier_start_char(i8* null)
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  %t19 = load double, double* %l1
  store double %t19, double* %l3
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load i8, i8* %l2
  %t26 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t44 = phi double [ %t24, %then4 ], [ %t43, %loop.latch8 ]
  store double %t44, double* %l1
  br label %loop.body7
loop.body7:
  %t27 = load double, double* %l1
  %t28 = load double, double* %l1
  %t29 = getelementptr i8, i8* %expression, i64 %t28
  %t30 = load i8, i8* %t29
  store i8 %t30, i8* %l4
  %t31 = load i8, i8* %l4
  %t32 = call i1 @is_identifier_part_char(i8* null)
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l3
  %t37 = load i8, i8* %l4
  br i1 %t32, label %then10, label %merge11
then10:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch8
merge11:
  %t41 = load i8, i8* %l4
  %s42 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.42, i32 0, i32 0
  br label %afterloop9
loop.latch8:
  %t43 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t45 = load double, double* %l3
  %t46 = load double, double* %l1
  %t47 = call double @substring(i8* %expression, double %t45, double %t46)
  %t48 = call i8* @trim_text(i8* null)
  store i8* %t48, i8** %l5
  %t49 = load i8*, i8** %l5
  br label %loop.latch2
merge5:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch2
loop.latch2:
  %t53 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t55
}

define { i8**, i64 }* @extract_all_call_targets(i8* %expression) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8
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
  %t55 = phi double [ %t7, %entry ], [ %t54, %loop.latch2 ]
  store double %t55, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = getelementptr i8, i8* %expression, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l2
  %t12 = load i8, i8* %l2
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8, i8* %l2
  %t15 = call i1 @is_identifier_start_char(i8* null)
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  %t19 = load double, double* %l1
  store double %t19, double* %l3
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load i8, i8* %l2
  %t26 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t45 = phi double [ %t24, %then4 ], [ %t44, %loop.latch8 ]
  store double %t45, double* %l1
  br label %loop.body7
loop.body7:
  %t27 = load double, double* %l1
  %t28 = load double, double* %l1
  %t29 = getelementptr i8, i8* %expression, i64 %t28
  %t30 = load i8, i8* %t29
  store i8 %t30, i8* %l4
  %t31 = load i8, i8* %l4
  %t32 = call i1 @is_identifier_part_char(i8* null)
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l3
  %t37 = load i8, i8* %l4
  br i1 %t32, label %then10, label %merge11
then10:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch8
merge11:
  %t42 = load i8, i8* %l4
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  br label %afterloop9
loop.latch8:
  %t44 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t46 = load double, double* %l3
  %t47 = load double, double* %l1
  %t48 = call double @substring(i8* %expression, double %t46, double %t47)
  %t49 = call i8* @trim_text(i8* null)
  store i8* %t49, i8** %l5
  %t50 = load i8*, i8** %l5
  br label %loop.latch2
merge5:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch2
loop.latch2:
  %t54 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t56
}

define { i8**, i64 }* @filter_runtime_helper_targets({ i8**, i64 }* %targets) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t30 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %targets
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %targets
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call i8* @trim_text(i8* %t21)
  store i8* %t22, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = call double @find_runtime_helper(i8* %t23)
  store double %t24, double* %l3
  %t25 = load double, double* %l3
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t31
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
  %l4 = alloca %FunctionCallEntry
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
  %t20 = phi { %FunctionEffectEntry*, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi double [ %t7, %entry ], [ %t19, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t20, { %FunctionEffectEntry*, i64 }** %l0
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %FunctionEffectEntry*, i64 }, { %FunctionEffectEntry*, i64 }* %direct_effects
  %t10 = extractvalue { %FunctionEffectEntry*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header0
afterloop3:
  store i1 1, i1* %l2
  %t22 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load i1, i1* %l2
  br label %loop.header6
loop.header6:
  %t62 = phi i1 [ %t24, %entry ], [ %t61, %loop.latch8 ]
  store i1 %t62, i1* %l2
  br label %loop.body7
loop.body7:
  %t25 = load i1, i1* %l2
  %t26 = xor i1 %t25, 1
  %t27 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = load i1, i1* %l2
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store i1 0, i1* %l2
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l3
  %t31 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load double, double* %l3
  br label %loop.header12
loop.header12:
  %t60 = phi double [ %t34, %loop.body7 ], [ %t59, %loop.latch14 ]
  store double %t60, double* %l3
  br label %loop.body13
loop.body13:
  %t35 = load double, double* %l3
  %t36 = load { %FunctionCallEntry*, i64 }, { %FunctionCallEntry*, i64 }* %call_graph
  %t37 = extractvalue { %FunctionCallEntry*, i64 } %t36, 1
  %t38 = sitofp i64 %t37 to double
  %t39 = fcmp oge double %t35, %t38
  %t40 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load i1, i1* %l2
  %t43 = load double, double* %l3
  br i1 %t39, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t44 = load double, double* %l3
  %t45 = load { %FunctionCallEntry*, i64 }, { %FunctionCallEntry*, i64 }* %call_graph
  %t46 = extractvalue { %FunctionCallEntry*, i64 } %t45, 0
  %t47 = extractvalue { %FunctionCallEntry*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr %FunctionCallEntry, %FunctionCallEntry* %t46, i64 %t44
  %t50 = load %FunctionCallEntry, %FunctionCallEntry* %t49
  store %FunctionCallEntry %t50, %FunctionCallEntry* %l4
  %t51 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t52 = load %FunctionCallEntry, %FunctionCallEntry* %l4
  %t53 = extractvalue %FunctionCallEntry %t52, 0
  %t54 = call double @find_function_effect_entry({ %FunctionEffectEntry*, i64 }* %t51, i8* %t53)
  store double %t54, double* %l5
  %t55 = load double, double* %l5
  %t56 = load double, double* %l3
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l3
  br label %loop.latch14
loop.latch14:
  %t59 = load double, double* %l3
  br label %loop.header12
afterloop15:
  br label %loop.latch8
loop.latch8:
  %t61 = load i1, i1* %l2
  br label %loop.header6
afterloop9:
  %t63 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  ret { %FunctionEffectEntry*, i64 }* %t63
}

define %CapabilityManifest @build_capability_manifest({ i8**, i64 }* %entry_points, { %FunctionEffectEntry*, i64 }* %function_effects) {
entry:
  %l0 = alloca { %CapabilityManifestEntry*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t41 = phi { %CapabilityManifestEntry*, i64 }* [ %t6, %entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t7, %entry ], [ %t40, %loop.latch2 ]
  store { %CapabilityManifestEntry*, i64 }* %t41, { %CapabilityManifestEntry*, i64 }** %l0
  store double %t42, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %entry_points
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %entry_points
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = call double @find_function_effect_entry({ %FunctionEffectEntry*, i64 }* %function_effects, i8* %t22)
  store double %t23, double* %l3
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t29 = load double, double* %l3
  %t30 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t31 = load i8*, i8** %l2
  %t32 = insertvalue %CapabilityManifestEntry undef, i8* %t31, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t34 = insertvalue %CapabilityManifestEntry %t32, { i8**, i64 }* %t33, 1
  %t35 = call { %CapabilityManifestEntry*, i64 }* @append_manifest_entry({ %CapabilityManifestEntry*, i64 }* %t30, %CapabilityManifestEntry %t34)
  store { %CapabilityManifestEntry*, i64 }* %t35, { %CapabilityManifestEntry*, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch2
loop.latch2:
  %t39 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t43 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t44 = insertvalue %CapabilityManifest undef, { i8**, i64 }* null, 0
  ret %CapabilityManifest %t44
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

define %FunctionEffectEntry @collect_function_effect_entry(i8* %function) {
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
  %t6 = call { i8**, i64 }* @collect_function_borrow_effects(i8* %function)
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
  %t24 = phi { i8**, i64 }* [ %t1, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t2, %entry ], [ %t23, %loop.latch2 ]
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %extras
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %extras
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  %t18 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t10, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t26
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

define { i8**, i64 }* @collect_function_borrow_effects(i8* %function) {
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
  %t14 = phi double [ %t7, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t15
}

define { i8**, i64 }* @collect_expression_borrow_effects(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8
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
  %t27 = phi double [ %t10, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l2
  %t15 = getelementptr i8, i8* %t13, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l3
  %t17 = load i8, i8* %l3
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8, i8* %l3
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = load i8, i8* %l3
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  %t23 = load double, double* %l2
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l2
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t28
}

define double @skip_string_literal(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8
  store double %start_index, double* %l0
  store i1 0, i1* %l1
  %t0 = load double, double* %l0
  %t1 = load i1, i1* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi i1 [ %t1, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi double [ %t0, %entry ], [ %t19, %loop.latch2 ]
  store i1 %t20, i1* %l1
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %text, i64 %t3
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l2
  %t6 = load i1, i1* %l1
  %t7 = load double, double* %l0
  %t8 = load i1, i1* %l1
  %t9 = load i8, i8* %l2
  br i1 %t6, label %then4, label %else5
then4:
  store i1 0, i1* %l1
  br label %merge6
else5:
  %t10 = load i8, i8* %l2
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  br label %merge6
merge6:
  %t12 = phi i1 [ 0, %then4 ], [ %t8, %else5 ]
  store i1 %t12, i1* %l1
  %t13 = load i8, i8* %l2
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load i1, i1* %l1
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t22 = load double, double* %l0
  ret double %t22
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
  %t29 = phi { i8**, i64 }* [ %t6, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t7, %entry ], [ %t28, %loop.latch2 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %values
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %values
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t15, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t31
}

define i1 @string_arrays_equal({ i8**, i64 }* %first, { i8**, i64 }* %second) {
entry:
  %l0 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %first
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = load { i8**, i64 }, { i8**, i64 }* %second
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = icmp ne i64 %t1, %t3
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t33 = phi double [ %t6, %entry ], [ %t32, %loop.latch4 ]
  store double %t33, double* %l0
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %first
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp oge double %t7, %t10
  %t12 = load double, double* %l0
  br i1 %t11, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l0
  %t14 = load { i8**, i64 }, { i8**, i64 }* %first
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  %t20 = load double, double* %l0
  %t21 = load { i8**, i64 }, { i8**, i64 }* %second
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  %t27 = icmp ne i8* %t19, %t26
  %t28 = load double, double* %l0
  br i1 %t27, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch4
loop.latch4:
  %t32 = load double, double* %l0
  br label %loop.header2
afterloop5:
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
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %ch, %s6
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t7, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %ch, %s8
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t10 = phi i1 [ true, %logical_or_entry_5 ], [ %t9, %logical_or_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t10, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t13 = phi i1 [ true, %logical_or_entry_4 ], [ %t12, %logical_or_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t13, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = icmp eq i8* %ch, %s14
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t16 = phi i1 [ true, %logical_or_entry_3 ], [ %t15, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t16, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = icmp eq i8* %ch, %s17
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t19 = phi i1 [ true, %logical_or_entry_2 ], [ %t18, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t19, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %ch, %s20
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t22 = phi i1 [ true, %logical_or_entry_1 ], [ %t21, %logical_or_right_end_1 ]
  ret i1 %t22
}

define i1 @is_effect_delimiter(i8* %ch) {
entry:
  %t0 = call i1 @is_trim_char(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s6 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %ch, %s6
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t7, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %ch, %s8
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t10 = phi i1 [ true, %logical_or_entry_5 ], [ %t9, %logical_or_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t10, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t13 = phi i1 [ true, %logical_or_entry_4 ], [ %t12, %logical_or_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t13, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = icmp eq i8* %ch, %s14
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t16 = phi i1 [ true, %logical_or_entry_3 ], [ %t15, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t16, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = icmp eq i8* %ch, %s17
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t19 = phi i1 [ true, %logical_or_entry_2 ], [ %t18, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t19, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %ch, %s20
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t22 = phi i1 [ true, %logical_or_entry_1 ], [ %t21, %logical_or_right_end_1 ]
  ret i1 %t22
}

define i1 @is_identifier_start_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.2, i32 0, i32 0
  %t3 = call double @index_of(i8* %s2, i8* %ch)
  %t4 = sitofp i64 -1 to double
  %t5 = fcmp une double %t3, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s6 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.6, i32 0, i32 0
  %t7 = call double @index_of(i8* %s6, i8* %ch)
  %t8 = sitofp i64 -1 to double
  %t9 = fcmp une double %t7, %t8
  br i1 %t9, label %then4, label %merge5
then4:
  ret i1 1
merge5:
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

define i8* @render_interface_signature(i8* %signature) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [60 x i8], [60 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %t1, %s2
  store i8* %t3, i8** %l0
  %t5 = load i8*, i8** %l0
  ret i8* %t5
}

define i8* @render_interface_parameters({ i8**, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t38 = phi { i8**, i64 }* [ %t10, %entry ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t11, %entry ], [ %t37, %loop.latch4 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l3
  %t32 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t30, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define %LoweredLLVMFunction @emit_function(i8* %function, { i8**, i64 }* %functions, { i8**, i64 }* %effects, %TypeContext %context) {
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
  %t6 = call %ParameterPreparation @prepare_parameters(i8* %function, %TypeContext %context)
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
  %t15 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp sgt i64 %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  %t21 = load %ParameterPreparation, %ParameterPreparation* %l3
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t17, label %then0, label %merge1
then0:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s24 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.24, i32 0, i32 0
  br label %merge1
merge1:
  %t25 = phi { i8**, i64 }* [ null, %then0 ], [ %t22, %entry ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l4
  %t26 = load %ParameterPreparation, %ParameterPreparation* %l3
  %t27 = extractvalue %ParameterPreparation %t26, 0
  store i8* null, i8** %l5
  %t28 = load i8*, i8** %l5
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s30 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.30, i32 0, i32 0
  %t31 = load double, double* %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s33 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.33, i32 0, i32 0
  %t34 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t32, i8* %s33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l4
  %t35 = load double, double* %l2
  %t36 = load %ParameterPreparation, %ParameterPreparation* %l3
  %t37 = extractvalue %ParameterPreparation %t36, 1
  %t38 = call %BodyResult @emit_body(i8* %function, i8* null, { %ParameterBinding*, i64 }* null, { i8**, i64 }* %functions, %TypeContext %context)
  store %BodyResult %t38, %BodyResult* %l6
  %t39 = load %BodyResult, %BodyResult* %l6
  %t40 = extractvalue %BodyResult %t39, 0
  %t41 = call double @linesconcat({ i8**, i64 }* %t40)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t42 = load %BodyResult, %BodyResult* %l6
  %t43 = extractvalue %BodyResult %t42, 1
  %t44 = call double @diagnosticsconcat({ i8**, i64 }* %t43)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t45 = load %BodyResult, %BodyResult* %l6
  %t46 = extractvalue %BodyResult %t45, 2
  %t47 = call { i8**, i64 }* @validate_borrow_lifetimes(i8* %function, { %LifetimeRegionMetadata*, i64 }* null)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l7
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t49 = call double @diagnosticsconcat({ i8**, i64 }* %t48)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s51 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.51, i32 0, i32 0
  %t52 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t50, i8* %s51)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l4
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t54 = insertvalue %LoweredLLVMFunction undef, { i8**, i64 }* %t53, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = insertvalue %LoweredLLVMFunction %t54, { i8**, i64 }* %t55, 1
  %t57 = load %BodyResult, %BodyResult* %l6
  %t58 = extractvalue %BodyResult %t57, 2
  %t59 = insertvalue %LoweredLLVMFunction %t56, { i8**, i64 }* %t58, 2
  %t60 = load %BodyResult, %BodyResult* %l6
  %t61 = extractvalue %BodyResult %t60, 3
  %t62 = insertvalue %LoweredLLVMFunction %t59, { i8**, i64 }* %t61, 3
  ret %LoweredLLVMFunction %t62
}

define %BodyResult @emit_body(i8* %function, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { i8**, i64 }* %functions, %TypeContext %context) {
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
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = insertvalue %BodyResult undef, { i8**, i64 }* %t9, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = insertvalue %BodyResult %t10, { i8**, i64 }* %t11, 1
  %t13 = load double, double* %l0
  %t14 = insertvalue %BodyResult %t12, { i8**, i64 }* null, 2
  %t15 = load double, double* %l0
  %t16 = insertvalue %BodyResult %t14, { i8**, i64 }* null, 3
  ret %BodyResult %t16
}

define { i8**, i64 }* @validate_borrow_lifetimes(i8* %function, { %LifetimeRegionMetadata*, i64 }* %regions) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca %LifetimeRegionMetadata
  %l4 = alloca i8*
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
  %t115 = phi { i8**, i64 }* [ %t6, %entry ], [ %t113, %loop.latch2 ]
  %t116 = phi double [ %t7, %entry ], [ %t114, %loop.latch2 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l0
  store double %t116, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %regions
  %t11 = extractvalue { %LifetimeRegionMetadata*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l1
  %t18 = load { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %regions
  %t19 = extractvalue { %LifetimeRegionMetadata*, i64 } %t18, 0
  %t20 = extractvalue { %LifetimeRegionMetadata*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t19, i64 %t17
  %t23 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t22
  store %LifetimeRegionMetadata %t23, %LifetimeRegionMetadata* %l3
  %t24 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t25 = extractvalue %LifetimeRegionMetadata %t24, 7
  store i8* %t25, i8** %l4
  %t26 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t27 = extractvalue %LifetimeRegionMetadata %t26, 8
  store double %t27, double* %l5
  %t28 = load i8*, i8** %l4
  store i1 0, i1* %l6
  %t29 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t30 = extractvalue %LifetimeRegionMetadata %t29, 11
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  %t34 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l5
  %t37 = load i1, i1* %l6
  br i1 %t30, label %then6, label %else7
then6:
  %t38 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t39 = extractvalue %LifetimeRegionMetadata %t38, 9
  br label %merge8
else7:
  %t40 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t41 = extractvalue %LifetimeRegionMetadata %t40, 6
  %t42 = load double, double* %l5
  %t43 = fcmp olt double %t41, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load i1, i1* %l6
  br i1 %t43, label %then9, label %else10
then9:
  store i1 1, i1* %l6
  br label %merge11
else10:
  %t51 = load i8*, i8** %l4
  %t52 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t53 = extractvalue %LifetimeRegionMetadata %t52, 5
  %t54 = call i1 @is_scope_descendant(i8* %t51, i8* %t53)
  %t55 = xor i1 %t54, 1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = load double, double* %l2
  %t59 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t60 = load i8*, i8** %l4
  %t61 = load double, double* %l5
  %t62 = load i1, i1* %l6
  br i1 %t55, label %then12, label %merge13
then12:
  store i1 1, i1* %l6
  br label %merge13
merge13:
  %t63 = phi i1 [ 1, %then12 ], [ %t62, %else10 ]
  store i1 %t63, i1* %l6
  br label %merge11
merge11:
  %t64 = phi i1 [ 1, %then9 ], [ 1, %else10 ]
  store i1 %t64, i1* %l6
  br label %merge8
merge8:
  %t65 = phi i1 [ %t37, %then6 ], [ 1, %else7 ]
  store i1 %t65, i1* %l6
  %t66 = load i1, i1* %l6
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t71 = load i8*, i8** %l4
  %t72 = load double, double* %l5
  %t73 = load i1, i1* %l6
  br i1 %t66, label %then14, label %merge15
then14:
  %s74 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.74, i32 0, i32 0
  store i8* %s74, i8** %l7
  %t75 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t76 = extractvalue %LifetimeRegionMetadata %t75, 4
  %t77 = icmp ne i8* %t76, null
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t82 = load i8*, i8** %l4
  %t83 = load double, double* %l5
  %t84 = load i1, i1* %l6
  %t85 = load i8*, i8** %l7
  br i1 %t77, label %then16, label %merge17
then16:
  %s86 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.86, i32 0, i32 0
  %t87 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t88 = extractvalue %LifetimeRegionMetadata %t87, 4
  %t89 = call i8* @format_span_location(i8* %t88)
  %t90 = add i8* %s86, %t89
  store i8* %t90, i8** %l7
  br label %merge17
merge17:
  %t91 = phi i8* [ %t90, %then16 ], [ %t85, %then14 ]
  store i8* %t91, i8** %l7
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s93 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.93, i32 0, i32 0
  %t94 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t95 = extractvalue %LifetimeRegionMetadata %t94, 1
  %t96 = add i8* %s93, %t95
  %s97 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.97, i32 0, i32 0
  %t98 = add i8* %t96, %s97
  %t99 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t100 = extractvalue %LifetimeRegionMetadata %t99, 2
  %t101 = add i8* %t98, %t100
  %s102 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %t101, %s102
  %t104 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t105 = extractvalue %LifetimeRegionMetadata %t104, 2
  %t106 = add i8* %t103, %t105
  %s107 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.107, i32 0, i32 0
  %t108 = add i8* %t106, %s107
  br label %merge15
merge15:
  %t109 = phi { i8**, i64 }* [ null, %then14 ], [ %t67, %loop.body1 ]
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l1
  br label %loop.latch2
loop.latch2:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t117
}

define %BlockLoweringResult @lower_instruction_range(i8* %function, double %start_index, double %end, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, { i8**, i64 }* %functions, { %LoopContext*, i64 }* %loop_stack, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
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
  %t57 = phi double [ %t31, %entry ], [ %t56, %loop.latch2 ]
  store double %t57, double* %l11
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
  %t53 = load double, double* %l11
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l11
  br label %loop.latch2
loop.latch2:
  %t56 = load double, double* %l11
  br label %loop.header0
afterloop3:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = insertvalue %BlockLoweringResult undef, { i8**, i64 }* %t58, 0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = insertvalue %BlockLoweringResult %t59, { i8**, i64 }* %t60, 1
  %t62 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t63 = insertvalue %BlockLoweringResult %t61, { i8**, i64 }* null, 2
  %t64 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t65 = insertvalue %BlockLoweringResult %t63, { i8**, i64 }* null, 3
  %t66 = load double, double* %l5
  %t67 = insertvalue %BlockLoweringResult %t65, double %t66, 4
  %t68 = load double, double* %l6
  %t69 = insertvalue %BlockLoweringResult %t67, double %t68, 5
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = insertvalue %BlockLoweringResult %t69, { i8**, i64 }* %t70, 6
  %t72 = load i1, i1* %l9
  %t73 = insertvalue %BlockLoweringResult %t71, i1 %t72, 7
  %t74 = load double, double* %l7
  %t75 = insertvalue %BlockLoweringResult %t73, double %t74, 8
  %t76 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l12
  %t77 = insertvalue %BlockLoweringResult %t75, { i8**, i64 }* null, 9
  %t78 = load double, double* %l8
  %t79 = insertvalue %BlockLoweringResult %t77, double %t78, 10
  %t80 = load double, double* %l11
  %t81 = insertvalue %BlockLoweringResult %t79, double %t80, 11
  %t82 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l13
  %t83 = insertvalue %BlockLoweringResult %t81, { i8**, i64 }* null, 12
  %t84 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l14
  %t85 = insertvalue %BlockLoweringResult %t83, { i8**, i64 }* null, 13
  ret %BlockLoweringResult %t85
}

define %IfStructure @collect_if_structure({ i8**, i64 }* %instructions, double %start_index, double %end, i8* %function_name) {
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
  %l9 = alloca i8*
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
  %t12 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp ogt double %t11, %t14
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load double, double* %l4
  %t21 = load i1, i1* %l5
  %t22 = load double, double* %l6
  %t23 = load double, double* %l7
  %t24 = load double, double* %l8
  br i1 %t15, label %then0, label %merge1
then0:
  %t25 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t26 = extractvalue { i8**, i64 } %t25, 1
  %t27 = sitofp i64 %t26 to double
  store double %t27, double* %l8
  br label %merge1
merge1:
  %t28 = phi double [ %t27, %then0 ], [ %t24, %entry ]
  store double %t28, double* %l8
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load double, double* %l4
  %t34 = load i1, i1* %l5
  %t35 = load double, double* %l6
  %t36 = load double, double* %l7
  %t37 = load double, double* %l8
  br label %loop.header2
loop.header2:
  %t71 = phi { i8**, i64 }* [ %t29, %entry ], [ %t69, %loop.latch4 ]
  %t72 = phi double [ %t36, %entry ], [ %t70, %loop.latch4 ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  store double %t72, double* %l7
  br label %loop.body3
loop.body3:
  %t38 = load double, double* %l7
  %t39 = load double, double* %l8
  %t40 = fcmp oge double %t38, %t39
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  %t46 = load i1, i1* %l5
  %t47 = load double, double* %l6
  %t48 = load double, double* %l7
  %t49 = load double, double* %l8
  br i1 %t40, label %then6, label %merge7
then6:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s51 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.51, i32 0, i32 0
  %t52 = add i8* %s51, %function_name
  %s53 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
  %t55 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t50, i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  ret %IfStructure zeroinitializer
merge7:
  %t56 = load double, double* %l7
  %t57 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  store i8* %t62, i8** %l9
  %t63 = load i8*, i8** %l9
  %t64 = load i8*, i8** %l9
  %t65 = load i8*, i8** %l9
  %t66 = load double, double* %l7
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l7
  br label %loop.latch4
loop.latch4:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l7
  br label %loop.header2
afterloop5:
  ret %IfStructure zeroinitializer
}

define %LoopStructure @collect_loop_structure({ i8**, i64 }* %instructions, double %start_index, double %end, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
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
  %t10 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp ogt double %t9, %t12
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  %t19 = load double, double* %l5
  br i1 %t13, label %then0, label %merge1
then0:
  %t20 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t21 = extractvalue { i8**, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  store double %t22, double* %l5
  br label %merge1
merge1:
  %t23 = phi double [ %t22, %then0 ], [ %t19, %entry ]
  store double %t23, double* %l5
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  %t29 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t73 = phi double [ %t29, %entry ], [ %t70, %loop.latch4 ]
  %t74 = phi { i8**, i64 }* [ %t24, %entry ], [ %t71, %loop.latch4 ]
  %t75 = phi double [ %t28, %entry ], [ %t72, %loop.latch4 ]
  store double %t73, double* %l5
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  store double %t75, double* %l4
  br label %loop.body3
loop.body3:
  %t30 = load double, double* %l4
  %t31 = load double, double* %l5
  %t32 = fcmp oge double %t30, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  %t37 = load double, double* %l4
  %t38 = load double, double* %l5
  br i1 %t32, label %then6, label %merge7
then6:
  %t39 = load double, double* %l5
  %t40 = sitofp i64 0 to double
  %t41 = fcmp ole double %t39, %t40
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load double, double* %l4
  %t47 = load double, double* %l5
  br i1 %t41, label %then8, label %merge9
then8:
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l5
  br label %merge9
merge9:
  %t49 = phi double [ %t48, %then8 ], [ %t47, %then6 ]
  store double %t49, double* %l5
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s51 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.51, i32 0, i32 0
  %t52 = add i8* %s51, %function_name
  %s53 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
  %t55 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t50, i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  ret %LoopStructure zeroinitializer
merge7:
  %t56 = load double, double* %l4
  %t57 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  store i8* %t62, i8** %l6
  %t64 = load i8*, i8** %l6
  %t66 = load i8*, i8** %l6
  %t67 = load double, double* %l4
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l4
  br label %loop.latch4
loop.latch4:
  %t70 = load double, double* %l5
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load double, double* %l4
  br label %loop.header2
afterloop5:
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
  %t0 = load { %LoopContext*, i64 }, { %LoopContext*, i64 }* %values
  %t1 = extractvalue { %LoopContext*, i64 } %t0, 1
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t4 = sitofp i64 0 to double
  %t5 = fcmp ole double %t3, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  %t8 = insertvalue %LoopContext undef, i8* %s7, 0
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  %t10 = insertvalue %LoopContext %t8, i8* %s9, 1
  ret %LoopContext %t10
merge1:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fsub double %t11, %t12
  store double %t13, double* %l0
  %t14 = load double, double* %l0
  %t15 = load { %LoopContext*, i64 }, { %LoopContext*, i64 }* %values
  %t16 = extractvalue { %LoopContext*, i64 } %t15, 0
  %t17 = extractvalue { %LoopContext*, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr %LoopContext, %LoopContext* %t16, i64 %t14
  %t20 = load %LoopContext, %LoopContext* %t19
  ret %LoopContext %t20
}

define %BlockLoweringResult @lower_loop_instruction(i8* %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, { i8**, i64 }* %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
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
  %l15 = alloca %LocalBinding
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
  %l42 = alloca i8*
  %l43 = alloca double
  %l44 = alloca double
  %l45 = alloca i8*
  %l46 = alloca double
  %l47 = alloca { i8**, i64 }*
  %l48 = alloca double
  %l49 = alloca i1
  %l50 = alloca i8*
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
  %t102 = phi double [ %t32, %entry ], [ %t98, %loop.latch2 ]
  %t103 = phi { i8**, i64 }* [ %t28, %entry ], [ %t99, %loop.latch2 ]
  %t104 = phi { i8**, i64 }* [ %t40, %entry ], [ %t100, %loop.latch2 ]
  %t105 = phi double [ %t41, %entry ], [ %t101, %loop.latch2 ]
  store double %t102, double* %l5
  store { i8**, i64 }* %t103, { i8**, i64 }** %l1
  store { i8**, i64 }* %t104, { i8**, i64 }** %l13
  store double %t105, double* %l14
  br label %loop.body1
loop.body1:
  %t42 = load double, double* %l14
  %t43 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t44 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t43
  %t45 = extractvalue { %LocalBinding*, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oge double %t42, %t46
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t52 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t53 = load double, double* %l5
  %t54 = load double, double* %l6
  %t55 = load double, double* %l7
  %t56 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t57 = load double, double* %l9
  %t58 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t59 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t60 = load double, double* %l12
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t62 = load double, double* %l14
  br i1 %t47, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t63 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t64 = load double, double* %l14
  %t65 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t63
  %t66 = extractvalue { %LocalBinding*, i64 } %t65, 0
  %t67 = extractvalue { %LocalBinding*, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  %t69 = getelementptr %LocalBinding, %LocalBinding* %t66, i64 %t64
  %t70 = load %LocalBinding, %LocalBinding* %t69
  store %LocalBinding %t70, %LocalBinding* %l15
  %t71 = load double, double* %l5
  %t72 = call i8* @format_temp_name(double %t71)
  store i8* %t72, i8** %l16
  %t73 = load double, double* %l5
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l5
  %s76 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.76, i32 0, i32 0
  %t77 = load i8*, i8** %l16
  %t78 = add i8* %s76, %t77
  %s79 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.79, i32 0, i32 0
  %t80 = add i8* %t78, %s79
  %t81 = load %LocalBinding, %LocalBinding* %l15
  %t82 = extractvalue %LocalBinding %t81, 2
  %t83 = add i8* %t80, %t82
  %s84 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.84, i32 0, i32 0
  %t85 = add i8* %t83, %s84
  %t86 = load %LocalBinding, %LocalBinding* %l15
  %t87 = extractvalue %LocalBinding %t86, 2
  %t88 = add i8* %t85, %t87
  store double 0.0, double* %l17
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load double, double* %l17
  %t91 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t89, i8* null)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t93 = load i8*, i8** %l16
  %t94 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t92, i8* %t93)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l13
  %t95 = load double, double* %l14
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l14
  br label %loop.latch2
loop.latch2:
  %t98 = load double, double* %l5
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t101 = load double, double* %l14
  br label %loop.header0
afterloop3:
  %s106 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.106, i32 0, i32 0
  %t107 = load double, double* %l6
  %t108 = call %BlockLabelResult @allocate_block_label(i8* %s106, double %t107)
  store %BlockLabelResult %t108, %BlockLabelResult* %l18
  %t109 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t110 = extractvalue %BlockLabelResult %t109, 0
  store i8* %t110, i8** %l19
  %t111 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t112 = extractvalue %BlockLabelResult %t111, 1
  store double %t112, double* %l6
  %s113 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.113, i32 0, i32 0
  %t114 = load double, double* %l6
  %t115 = call %BlockLabelResult @allocate_block_label(i8* %s113, double %t114)
  store %BlockLabelResult %t115, %BlockLabelResult* %l20
  %t116 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t117 = extractvalue %BlockLabelResult %t116, 0
  store i8* %t117, i8** %l21
  %t118 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t119 = extractvalue %BlockLabelResult %t118, 1
  store double %t119, double* %l6
  %s120 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.120, i32 0, i32 0
  %t121 = load double, double* %l6
  %t122 = call %BlockLabelResult @allocate_block_label(i8* %s120, double %t121)
  store %BlockLabelResult %t122, %BlockLabelResult* %l22
  %t123 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t124 = extractvalue %BlockLabelResult %t123, 0
  store i8* %t124, i8** %l23
  %t125 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t126 = extractvalue %BlockLabelResult %t125, 1
  store double %t126, double* %l6
  %s127 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.127, i32 0, i32 0
  %t128 = load double, double* %l6
  %t129 = call %BlockLabelResult @allocate_block_label(i8* %s127, double %t128)
  store %BlockLabelResult %t129, %BlockLabelResult* %l24
  %t130 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t131 = extractvalue %BlockLabelResult %t130, 0
  store i8* %t131, i8** %l25
  %t132 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t133 = extractvalue %BlockLabelResult %t132, 1
  store double %t133, double* %l6
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s135 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.135, i32 0, i32 0
  %t136 = load i8*, i8** %l19
  %t137 = add i8* %s135, %t136
  %t138 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t134, i8* %t137)
  store { i8**, i64 }* %t138, { i8**, i64 }** %l1
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = load i8*, i8** %l19
  %s141 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.141, i32 0, i32 0
  %t142 = add i8* %t140, %s141
  %t143 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t139, i8* %t142)
  store { i8**, i64 }* %t143, { i8**, i64 }** %l1
  %t144 = load i8*, i8** %l25
  %t145 = insertvalue %LoopContext undef, i8* %t144, 0
  %t146 = load i8*, i8** %l23
  %t147 = insertvalue %LoopContext %t145, i8* %t146, 1
  store %LoopContext %t147, %LoopContext* %l26
  %t148 = load %LoopContext, %LoopContext* %l26
  %t149 = call { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }* %loop_stack, %LoopContext %t148)
  store { %LoopContext*, i64 }* %t149, { %LoopContext*, i64 }** %l27
  %t150 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store { %LocalBinding*, i64 }* %t150, { %LocalBinding*, i64 }** %l28
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store { i8**, i64 }* %t151, { i8**, i64 }** %l29
  %t152 = load double, double* %l7
  store double %t152, double* %l30
  %t153 = load i8*, i8** %l21
  %t154 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t153)
  store i8* %t154, i8** %l31
  store double 0.0, double* %l32
  %t155 = load double, double* %l32
  %t156 = load double, double* %l32
  %t157 = load double, double* %l32
  %t158 = load double, double* %l32
  %t159 = load double, double* %l32
  %t160 = load double, double* %l32
  %t161 = load double, double* %l32
  %t162 = load double, double* %l32
  %t163 = load double, double* %l32
  %t164 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t165 = load double, double* %l32
  %t166 = alloca [0 x double]
  %t167 = getelementptr [0 x double], [0 x double]* %t166, i32 0, i32 0
  %t168 = alloca { double*, i64 }
  %t169 = getelementptr { double*, i64 }, { double*, i64 }* %t168, i32 0, i32 0
  store double* %t167, double** %t169
  %t170 = getelementptr { double*, i64 }, { double*, i64 }* %t168, i32 0, i32 1
  store i64 0, i64* %t170
  store { i8**, i64 }* null, { i8**, i64 }** %l33
  %t171 = alloca [0 x double]
  %t172 = getelementptr [0 x double], [0 x double]* %t171, i32 0, i32 0
  %t173 = alloca { double*, i64 }
  %t174 = getelementptr { double*, i64 }, { double*, i64 }* %t173, i32 0, i32 0
  store double* %t172, double** %t174
  %t175 = getelementptr { double*, i64 }, { double*, i64 }* %t173, i32 0, i32 1
  store i64 0, i64* %t175
  store { i8**, i64 }* null, { i8**, i64 }** %l34
  %t176 = alloca [0 x double]
  %t177 = getelementptr [0 x double], [0 x double]* %t176, i32 0, i32 0
  %t178 = alloca { double*, i64 }
  %t179 = getelementptr { double*, i64 }, { double*, i64 }* %t178, i32 0, i32 0
  store double* %t177, double** %t179
  %t180 = getelementptr { double*, i64 }, { double*, i64 }* %t178, i32 0, i32 1
  store i64 0, i64* %t180
  store { i8**, i64 }* null, { i8**, i64 }** %l35
  %t181 = sitofp i64 0 to double
  store double %t181, double* %l36
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t185 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t186 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t187 = load double, double* %l5
  %t188 = load double, double* %l6
  %t189 = load double, double* %l7
  %t190 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t191 = load double, double* %l9
  %t192 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t193 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t194 = load double, double* %l12
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t196 = load double, double* %l14
  %t197 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t198 = load i8*, i8** %l19
  %t199 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t200 = load i8*, i8** %l21
  %t201 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t202 = load i8*, i8** %l23
  %t203 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t204 = load i8*, i8** %l25
  %t205 = load %LoopContext, %LoopContext* %l26
  %t206 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t207 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t209 = load double, double* %l30
  %t210 = load i8*, i8** %l31
  %t211 = load double, double* %l32
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t215 = load double, double* %l36
  br label %loop.header6
loop.header6:
  %t361 = phi { i8**, i64 }* [ %t214, %entry ], [ %t359, %loop.latch8 ]
  %t362 = phi double [ %t215, %entry ], [ %t360, %loop.latch8 ]
  store { i8**, i64 }* %t361, { i8**, i64 }** %l35
  store double %t362, double* %l36
  br label %loop.body7
loop.body7:
  %t216 = load double, double* %l36
  %t217 = load double, double* %l32
  %t218 = load double, double* %l32
  store double 0.0, double* %l37
  store i1 0, i1* %l38
  %t219 = sitofp i64 0 to double
  store double %t219, double* %l39
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t223 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t224 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t225 = load double, double* %l5
  %t226 = load double, double* %l6
  %t227 = load double, double* %l7
  %t228 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t229 = load double, double* %l9
  %t230 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t231 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t232 = load double, double* %l12
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t234 = load double, double* %l14
  %t235 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t236 = load i8*, i8** %l19
  %t237 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t238 = load i8*, i8** %l21
  %t239 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t240 = load i8*, i8** %l23
  %t241 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t242 = load i8*, i8** %l25
  %t243 = load %LoopContext, %LoopContext* %l26
  %t244 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t245 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t247 = load double, double* %l30
  %t248 = load i8*, i8** %l31
  %t249 = load double, double* %l32
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t253 = load double, double* %l36
  %t254 = load double, double* %l37
  %t255 = load i1, i1* %l38
  %t256 = load double, double* %l39
  br label %loop.header10
loop.header10:
  %t313 = phi double [ %t256, %loop.body7 ], [ %t312, %loop.latch12 ]
  store double %t313, double* %l39
  br label %loop.body11
loop.body11:
  %t257 = load double, double* %l39
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t259 = load { i8**, i64 }, { i8**, i64 }* %t258
  %t260 = extractvalue { i8**, i64 } %t259, 1
  %t261 = sitofp i64 %t260 to double
  %t262 = fcmp oge double %t257, %t261
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t266 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t267 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t268 = load double, double* %l5
  %t269 = load double, double* %l6
  %t270 = load double, double* %l7
  %t271 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t272 = load double, double* %l9
  %t273 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t274 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t275 = load double, double* %l12
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t277 = load double, double* %l14
  %t278 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t279 = load i8*, i8** %l19
  %t280 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t281 = load i8*, i8** %l21
  %t282 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t283 = load i8*, i8** %l23
  %t284 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t285 = load i8*, i8** %l25
  %t286 = load %LoopContext, %LoopContext* %l26
  %t287 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t288 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t290 = load double, double* %l30
  %t291 = load i8*, i8** %l31
  %t292 = load double, double* %l32
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t296 = load double, double* %l36
  %t297 = load double, double* %l37
  %t298 = load i1, i1* %l38
  %t299 = load double, double* %l39
  br i1 %t262, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t301 = load double, double* %l39
  %t302 = load { i8**, i64 }, { i8**, i64 }* %t300
  %t303 = extractvalue { i8**, i64 } %t302, 0
  %t304 = extractvalue { i8**, i64 } %t302, 1
  %t305 = icmp uge i64 %t301, %t304
  ; bounds check: %t305 (if true, out of bounds)
  %t306 = getelementptr i8*, i8** %t303, i64 %t301
  %t307 = load i8*, i8** %t306
  %t308 = load double, double* %l37
  %t309 = load double, double* %l39
  %t310 = sitofp i64 1 to double
  %t311 = fadd double %t309, %t310
  store double %t311, double* %l39
  br label %loop.latch12
loop.latch12:
  %t312 = load double, double* %l39
  br label %loop.header10
afterloop13:
  %t314 = load i1, i1* %l38
  %t315 = xor i1 %t314, 1
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t319 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t320 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t321 = load double, double* %l5
  %t322 = load double, double* %l6
  %t323 = load double, double* %l7
  %t324 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t325 = load double, double* %l9
  %t326 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t327 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t328 = load double, double* %l12
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t330 = load double, double* %l14
  %t331 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t332 = load i8*, i8** %l19
  %t333 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t334 = load i8*, i8** %l21
  %t335 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t336 = load i8*, i8** %l23
  %t337 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t338 = load i8*, i8** %l25
  %t339 = load %LoopContext, %LoopContext* %l26
  %t340 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t341 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t343 = load double, double* %l30
  %t344 = load i8*, i8** %l31
  %t345 = load double, double* %l32
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t349 = load double, double* %l36
  %t350 = load double, double* %l37
  %t351 = load i1, i1* %l38
  %t352 = load double, double* %l39
  br i1 %t315, label %then16, label %merge17
then16:
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t354 = load double, double* %l37
  br label %merge17
merge17:
  %t355 = phi { i8**, i64 }* [ null, %then16 ], [ %t348, %loop.body7 ]
  store { i8**, i64 }* %t355, { i8**, i64 }** %l35
  %t356 = load double, double* %l36
  %t357 = sitofp i64 1 to double
  %t358 = fadd double %t356, %t357
  store double %t358, double* %l36
  br label %loop.latch8
loop.latch8:
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t360 = load double, double* %l36
  br label %loop.header6
afterloop9:
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s364 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.364, i32 0, i32 0
  %t365 = load i8*, i8** %l21
  %t366 = add i8* %s364, %t365
  %t367 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t363, i8* %t366)
  store { i8**, i64 }* %t367, { i8**, i64 }** %l1
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t369 = load i8*, i8** %l21
  %s370 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.370, i32 0, i32 0
  %t371 = add i8* %t369, %s370
  %t372 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t368, i8* %t371)
  store { i8**, i64 }* %t372, { i8**, i64 }** %l1
  %t373 = load double, double* %l32
  %t374 = load double, double* %l32
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t376 = load i8*, i8** %l23
  %s377 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.377, i32 0, i32 0
  %t378 = add i8* %t376, %s377
  %t379 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t375, i8* %t378)
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  %t380 = alloca [0 x double]
  %t381 = getelementptr [0 x double], [0 x double]* %t380, i32 0, i32 0
  %t382 = alloca { double*, i64 }
  %t383 = getelementptr { double*, i64 }, { double*, i64 }* %t382, i32 0, i32 0
  store double* %t381, double** %t383
  %t384 = getelementptr { double*, i64 }, { double*, i64 }* %t382, i32 0, i32 1
  store i64 0, i64* %t384
  store { i8**, i64 }* null, { i8**, i64 }** %l40
  %t385 = sitofp i64 0 to double
  store double %t385, double* %l41
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t389 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t390 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t391 = load double, double* %l5
  %t392 = load double, double* %l6
  %t393 = load double, double* %l7
  %t394 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t395 = load double, double* %l9
  %t396 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t397 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t398 = load double, double* %l12
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t400 = load double, double* %l14
  %t401 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t402 = load i8*, i8** %l19
  %t403 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t404 = load i8*, i8** %l21
  %t405 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t406 = load i8*, i8** %l23
  %t407 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t408 = load i8*, i8** %l25
  %t409 = load %LoopContext, %LoopContext* %l26
  %t410 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t411 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t413 = load double, double* %l30
  %t414 = load i8*, i8** %l31
  %t415 = load double, double* %l32
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t419 = load double, double* %l36
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t421 = load double, double* %l41
  br label %loop.header18
loop.header18:
  %t480 = phi double [ %t421, %entry ], [ %t479, %loop.latch20 ]
  store double %t480, double* %l41
  br label %loop.body19
loop.body19:
  %t422 = load double, double* %l41
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t424 = load { i8**, i64 }, { i8**, i64 }* %t423
  %t425 = extractvalue { i8**, i64 } %t424, 1
  %t426 = sitofp i64 %t425 to double
  %t427 = fcmp oge double %t422, %t426
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t431 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t432 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t433 = load double, double* %l5
  %t434 = load double, double* %l6
  %t435 = load double, double* %l7
  %t436 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t437 = load double, double* %l9
  %t438 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t439 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t440 = load double, double* %l12
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t442 = load double, double* %l14
  %t443 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t444 = load i8*, i8** %l19
  %t445 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t446 = load i8*, i8** %l21
  %t447 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t448 = load i8*, i8** %l23
  %t449 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t450 = load i8*, i8** %l25
  %t451 = load %LoopContext, %LoopContext* %l26
  %t452 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t453 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t455 = load double, double* %l30
  %t456 = load i8*, i8** %l31
  %t457 = load double, double* %l32
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t461 = load double, double* %l36
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t463 = load double, double* %l41
  br i1 %t427, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t465 = load double, double* %l41
  %t466 = load { i8**, i64 }, { i8**, i64 }* %t464
  %t467 = extractvalue { i8**, i64 } %t466, 0
  %t468 = extractvalue { i8**, i64 } %t466, 1
  %t469 = icmp uge i64 %t465, %t468
  ; bounds check: %t469 (if true, out of bounds)
  %t470 = getelementptr i8*, i8** %t467, i64 %t465
  %t471 = load i8*, i8** %t470
  store i8* %t471, i8** %l42
  %t472 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t473 = load i8*, i8** %l42
  %t474 = call double @find_local_binding({ %LocalBinding*, i64 }* %t472, i8* %t473)
  store double %t474, double* %l43
  %t475 = load double, double* %l43
  %t476 = load double, double* %l41
  %t477 = sitofp i64 1 to double
  %t478 = fadd double %t476, %t477
  store double %t478, double* %l41
  br label %loop.latch20
loop.latch20:
  %t479 = load double, double* %l41
  br label %loop.header18
afterloop21:
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s482 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.482, i32 0, i32 0
  %t483 = load i8*, i8** %l19
  %t484 = add i8* %s482, %t483
  %t485 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t481, i8* %t484)
  store { i8**, i64 }* %t485, { i8**, i64 }** %l1
  %t486 = sitofp i64 0 to double
  store double %t486, double* %l44
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t490 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t491 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t492 = load double, double* %l5
  %t493 = load double, double* %l6
  %t494 = load double, double* %l7
  %t495 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t496 = load double, double* %l9
  %t497 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t498 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t499 = load double, double* %l12
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t501 = load double, double* %l14
  %t502 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t503 = load i8*, i8** %l19
  %t504 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t505 = load i8*, i8** %l21
  %t506 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t507 = load i8*, i8** %l23
  %t508 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t509 = load i8*, i8** %l25
  %t510 = load %LoopContext, %LoopContext* %l26
  %t511 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t512 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t514 = load double, double* %l30
  %t515 = load i8*, i8** %l31
  %t516 = load double, double* %l32
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t520 = load double, double* %l36
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t522 = load double, double* %l41
  %t523 = load double, double* %l44
  br label %loop.header24
loop.header24:
  %t584 = phi double [ %t523, %entry ], [ %t583, %loop.latch26 ]
  store double %t584, double* %l44
  br label %loop.body25
loop.body25:
  %t524 = load double, double* %l44
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t526 = load { i8**, i64 }, { i8**, i64 }* %t525
  %t527 = extractvalue { i8**, i64 } %t526, 1
  %t528 = sitofp i64 %t527 to double
  %t529 = fcmp oge double %t524, %t528
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t533 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t534 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t535 = load double, double* %l5
  %t536 = load double, double* %l6
  %t537 = load double, double* %l7
  %t538 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t539 = load double, double* %l9
  %t540 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t541 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t542 = load double, double* %l12
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t544 = load double, double* %l14
  %t545 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t546 = load i8*, i8** %l19
  %t547 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t548 = load i8*, i8** %l21
  %t549 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t550 = load i8*, i8** %l23
  %t551 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t552 = load i8*, i8** %l25
  %t553 = load %LoopContext, %LoopContext* %l26
  %t554 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t555 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t557 = load double, double* %l30
  %t558 = load i8*, i8** %l31
  %t559 = load double, double* %l32
  %t560 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t563 = load double, double* %l36
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t565 = load double, double* %l41
  %t566 = load double, double* %l44
  br i1 %t529, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t568 = load double, double* %l44
  %t569 = load { i8**, i64 }, { i8**, i64 }* %t567
  %t570 = extractvalue { i8**, i64 } %t569, 0
  %t571 = extractvalue { i8**, i64 } %t569, 1
  %t572 = icmp uge i64 %t568, %t571
  ; bounds check: %t572 (if true, out of bounds)
  %t573 = getelementptr i8*, i8** %t570, i64 %t568
  %t574 = load i8*, i8** %t573
  store i8* %t574, i8** %l45
  %t575 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t576 = load i8*, i8** %l45
  %t577 = call double @find_local_binding({ %LocalBinding*, i64 }* %t575, i8* %t576)
  store double %t577, double* %l46
  %t579 = load double, double* %l46
  %t580 = load double, double* %l44
  %t581 = sitofp i64 1 to double
  %t582 = fadd double %t580, %t581
  store double %t582, double* %l44
  br label %loop.latch26
loop.latch26:
  %t583 = load double, double* %l44
  br label %loop.header24
afterloop27:
  %t585 = alloca [0 x double]
  %t586 = getelementptr [0 x double], [0 x double]* %t585, i32 0, i32 0
  %t587 = alloca { double*, i64 }
  %t588 = getelementptr { double*, i64 }, { double*, i64 }* %t587, i32 0, i32 0
  store double* %t586, double** %t588
  %t589 = getelementptr { double*, i64 }, { double*, i64 }* %t587, i32 0, i32 1
  store i64 0, i64* %t589
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  %t590 = sitofp i64 0 to double
  store double %t590, double* %l48
  store i1 0, i1* %l49
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t594 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t595 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t596 = load double, double* %l5
  %t597 = load double, double* %l6
  %t598 = load double, double* %l7
  %t599 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t600 = load double, double* %l9
  %t601 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t602 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t603 = load double, double* %l12
  %t604 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t605 = load double, double* %l14
  %t606 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t607 = load i8*, i8** %l19
  %t608 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t609 = load i8*, i8** %l21
  %t610 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t611 = load i8*, i8** %l23
  %t612 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t613 = load i8*, i8** %l25
  %t614 = load %LoopContext, %LoopContext* %l26
  %t615 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t616 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t618 = load double, double* %l30
  %t619 = load i8*, i8** %l31
  %t620 = load double, double* %l32
  %t621 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t622 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t624 = load double, double* %l36
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t626 = load double, double* %l41
  %t627 = load double, double* %l44
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t629 = load double, double* %l48
  %t630 = load i1, i1* %l49
  br label %loop.header30
loop.header30:
  %t751 = phi { i8**, i64 }* [ %t628, %entry ], [ %t748, %loop.latch32 ]
  %t752 = phi i1 [ %t630, %entry ], [ %t749, %loop.latch32 ]
  %t753 = phi double [ %t629, %entry ], [ %t750, %loop.latch32 ]
  store { i8**, i64 }* %t751, { i8**, i64 }** %l47
  store i1 %t752, i1* %l49
  store double %t753, double* %l48
  br label %loop.body31
loop.body31:
  %t631 = load double, double* %l48
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t633 = load { i8**, i64 }, { i8**, i64 }* %t632
  %t634 = extractvalue { i8**, i64 } %t633, 1
  %t635 = sitofp i64 %t634 to double
  %t636 = fcmp oge double %t631, %t635
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t640 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t641 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t642 = load double, double* %l5
  %t643 = load double, double* %l6
  %t644 = load double, double* %l7
  %t645 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t646 = load double, double* %l9
  %t647 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t648 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t649 = load double, double* %l12
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t651 = load double, double* %l14
  %t652 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t653 = load i8*, i8** %l19
  %t654 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t655 = load i8*, i8** %l21
  %t656 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t657 = load i8*, i8** %l23
  %t658 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t659 = load i8*, i8** %l25
  %t660 = load %LoopContext, %LoopContext* %l26
  %t661 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t662 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t663 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t664 = load double, double* %l30
  %t665 = load i8*, i8** %l31
  %t666 = load double, double* %l32
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t670 = load double, double* %l36
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t672 = load double, double* %l41
  %t673 = load double, double* %l44
  %t674 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t675 = load double, double* %l48
  %t676 = load i1, i1* %l49
  br i1 %t636, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t678 = load double, double* %l48
  %t679 = load { i8**, i64 }, { i8**, i64 }* %t677
  %t680 = extractvalue { i8**, i64 } %t679, 0
  %t681 = extractvalue { i8**, i64 } %t679, 1
  %t682 = icmp uge i64 %t678, %t681
  ; bounds check: %t682 (if true, out of bounds)
  %t683 = getelementptr i8*, i8** %t680, i64 %t678
  %t684 = load i8*, i8** %t683
  store i8* %t684, i8** %l50
  %t685 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t686 = load i8*, i8** %l50
  %t687 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t685, i8* %t686)
  store { i8**, i64 }* %t687, { i8**, i64 }** %l47
  %t689 = load i1, i1* %l49
  br label %logical_and_entry_688

logical_and_entry_688:
  br i1 %t689, label %logical_and_right_688, label %logical_and_merge_688

logical_and_right_688:
  %t690 = load i8*, i8** %l50
  %t691 = load i8*, i8** %l19
  %s692 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.692, i32 0, i32 0
  %t693 = add i8* %t691, %s692
  %t694 = icmp eq i8* %t690, %t693
  br label %logical_and_right_end_688

logical_and_right_end_688:
  br label %logical_and_merge_688

logical_and_merge_688:
  %t695 = phi i1 [ false, %logical_and_entry_688 ], [ %t694, %logical_and_right_end_688 ]
  %t696 = xor i1 %t695, 1
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t698 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t700 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t701 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t702 = load double, double* %l5
  %t703 = load double, double* %l6
  %t704 = load double, double* %l7
  %t705 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t706 = load double, double* %l9
  %t707 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t708 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t709 = load double, double* %l12
  %t710 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t711 = load double, double* %l14
  %t712 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t713 = load i8*, i8** %l19
  %t714 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t715 = load i8*, i8** %l21
  %t716 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t717 = load i8*, i8** %l23
  %t718 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t719 = load i8*, i8** %l25
  %t720 = load %LoopContext, %LoopContext* %l26
  %t721 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t722 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t723 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t724 = load double, double* %l30
  %t725 = load i8*, i8** %l31
  %t726 = load double, double* %l32
  %t727 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t728 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t729 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t730 = load double, double* %l36
  %t731 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t732 = load double, double* %l41
  %t733 = load double, double* %l44
  %t734 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t735 = load double, double* %l48
  %t736 = load i1, i1* %l49
  %t737 = load i8*, i8** %l50
  br i1 %t696, label %then36, label %merge37
then36:
  store i1 1, i1* %l49
  %t738 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t739 = call double @final_linesconcat({ i8**, i64 }* %t738)
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  %t740 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t741 = call double @final_linesconcat({ i8**, i64 }* %t740)
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  br label %merge37
merge37:
  %t742 = phi i1 [ 1, %then36 ], [ %t736, %loop.body31 ]
  %t743 = phi { i8**, i64 }* [ null, %then36 ], [ %t734, %loop.body31 ]
  %t744 = phi { i8**, i64 }* [ null, %then36 ], [ %t734, %loop.body31 ]
  store i1 %t742, i1* %l49
  store { i8**, i64 }* %t743, { i8**, i64 }** %l47
  store { i8**, i64 }* %t744, { i8**, i64 }** %l47
  %t745 = load double, double* %l48
  %t746 = sitofp i64 1 to double
  %t747 = fadd double %t745, %t746
  store double %t747, double* %l48
  br label %loop.latch32
loop.latch32:
  %t748 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t749 = load i1, i1* %l49
  %t750 = load double, double* %l48
  br label %loop.header30
afterloop33:
  %t754 = load { i8**, i64 }*, { i8**, i64 }** %l47
  store { i8**, i64 }* %t754, { i8**, i64 }** %l1
  %t755 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t756 = load i8*, i8** %l25
  %s757 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.757, i32 0, i32 0
  %t758 = add i8* %t756, %s757
  %t759 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t755, i8* %t758)
  store { i8**, i64 }* %t759, { i8**, i64 }** %l1
  %t760 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  store { %LocalBinding*, i64 }* %t760, { %LocalBinding*, i64 }** %l3
  ret %BlockLoweringResult zeroinitializer
}

define %BlockLoweringResult @lower_for_instruction(i8* %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, { i8**, i64 }* %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
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
  %t27 = call i1 @is_simple_identifier(i8* null)
  %t28 = xor i1 %t27, 1
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
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l5
  %t109 = load double, double* %l5
  %t110 = call i8* @format_temp_name(double %t109)
  store i8* %t110, i8** %l24
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s112 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.112, i32 0, i32 0
  %t113 = load i8*, i8** %l24
  %t114 = add i8* %s112, %t113
  %t115 = load double, double* %l5
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l5
  %s118 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.118, i32 0, i32 0
  %t119 = insertvalue %LLVMOperand undef, i8* %s118, 0
  %t120 = load i8*, i8** %l24
  %t121 = insertvalue %LLVMOperand %t119, i8* %t120, 1
  store %LLVMOperand %t121, %LLVMOperand* %l25
  %t122 = load double, double* %l5
  %t123 = call i8* @format_temp_name(double %t122)
  store i8* %t123, i8** %l26
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s125 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.125, i32 0, i32 0
  %t126 = load i8*, i8** %l26
  %t127 = add i8* %s125, %t126
  %s128 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.128, i32 0, i32 0
  %t129 = add i8* %t127, %s128
  %t130 = load i8*, i8** %l20
  %t131 = add i8* %t129, %t130
  %t132 = load double, double* %l5
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l5
  %t135 = load double, double* %l5
  %t136 = call i8* @format_temp_name(double %t135)
  store i8* %t136, i8** %l27
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s138 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.138, i32 0, i32 0
  %t139 = load i8*, i8** %l27
  %t140 = add i8* %s138, %t139
  %s141 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.141, i32 0, i32 0
  %t142 = add i8* %t140, %s141
  %t143 = load double, double* %l21
  %t144 = load double, double* %l5
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l5
  %t147 = load double, double* %l21
  %t148 = insertvalue %LLVMOperand undef, i8* null, 0
  %t149 = load i8*, i8** %l27
  %t150 = insertvalue %LLVMOperand %t148, i8* %t149, 1
  store %LLVMOperand %t150, %LLVMOperand* %l28
  %s151 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.151, i32 0, i32 0
  %t152 = load double, double* %l6
  %t153 = call %BlockLabelResult @allocate_block_label(i8* %s151, double %t152)
  store %BlockLabelResult %t153, %BlockLabelResult* %l29
  %t154 = load %BlockLabelResult, %BlockLabelResult* %l29
  %t155 = extractvalue %BlockLabelResult %t154, 0
  store i8* %t155, i8** %l30
  %t156 = load %BlockLabelResult, %BlockLabelResult* %l29
  %t157 = extractvalue %BlockLabelResult %t156, 1
  store double %t157, double* %l6
  %s158 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.158, i32 0, i32 0
  %t159 = load double, double* %l6
  %t160 = call %BlockLabelResult @allocate_block_label(i8* %s158, double %t159)
  store %BlockLabelResult %t160, %BlockLabelResult* %l31
  %t161 = load %BlockLabelResult, %BlockLabelResult* %l31
  %t162 = extractvalue %BlockLabelResult %t161, 0
  store i8* %t162, i8** %l32
  %t163 = load %BlockLabelResult, %BlockLabelResult* %l31
  %t164 = extractvalue %BlockLabelResult %t163, 1
  store double %t164, double* %l6
  %s165 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.165, i32 0, i32 0
  %t166 = load double, double* %l6
  %t167 = call %BlockLabelResult @allocate_block_label(i8* %s165, double %t166)
  store %BlockLabelResult %t167, %BlockLabelResult* %l33
  %t168 = load %BlockLabelResult, %BlockLabelResult* %l33
  %t169 = extractvalue %BlockLabelResult %t168, 0
  store i8* %t169, i8** %l34
  %t170 = load %BlockLabelResult, %BlockLabelResult* %l33
  %t171 = extractvalue %BlockLabelResult %t170, 1
  store double %t171, double* %l6
  %s172 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.172, i32 0, i32 0
  %t173 = load double, double* %l6
  %t174 = call %BlockLabelResult @allocate_block_label(i8* %s172, double %t173)
  store %BlockLabelResult %t174, %BlockLabelResult* %l35
  %t175 = load %BlockLabelResult, %BlockLabelResult* %l35
  %t176 = extractvalue %BlockLabelResult %t175, 0
  store i8* %t176, i8** %l36
  %t177 = load %BlockLabelResult, %BlockLabelResult* %l35
  %t178 = extractvalue %BlockLabelResult %t177, 1
  store double %t178, double* %l6
  %t179 = load double, double* %l7
  %t180 = call i8* @format_local_pointer_name(double %t179)
  store i8* %t180, i8** %l37
  %t181 = load double, double* %l7
  %t182 = sitofp i64 1 to double
  %t183 = fadd double %t181, %t182
  store double %t183, double* %l7
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s185 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.185, i32 0, i32 0
  %t186 = load i8*, i8** %l37
  %t187 = add i8* %s185, %t186
  %s188 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.188, i32 0, i32 0
  %t189 = add i8* %t187, %s188
  %t190 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t184, i8* %t189)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l2
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t192 = load double, double* %l7
  %t193 = call i8* @format_local_pointer_name(double %t192)
  store i8* %t193, i8** %l38
  %t194 = load double, double* %l7
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l7
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s198 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.198, i32 0, i32 0
  %t199 = load i8*, i8** %l38
  %t200 = add i8* %s198, %t199
  %s201 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.201, i32 0, i32 0
  %t202 = add i8* %t200, %s201
  %t203 = load double, double* %l19
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s205 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.205, i32 0, i32 0
  %t206 = load double, double* %l19
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s208 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.208, i32 0, i32 0
  %t209 = load i8*, i8** %l30
  %t210 = add i8* %s208, %t209
  %t211 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t207, i8* %t210)
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = load i8*, i8** %l30
  %s214 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.214, i32 0, i32 0
  %t215 = add i8* %t213, %s214
  %t216 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t212, i8* %t215)
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  %t217 = load double, double* %l5
  %t218 = call i8* @format_temp_name(double %t217)
  store i8* %t218, i8** %l39
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s220 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.220, i32 0, i32 0
  %t221 = load i8*, i8** %l39
  %t222 = add i8* %s220, %t221
  %t223 = load double, double* %l5
  %t224 = sitofp i64 1 to double
  %t225 = fadd double %t223, %t224
  store double %t225, double* %l5
  %t226 = load double, double* %l5
  %t227 = call i8* @format_temp_name(double %t226)
  store i8* %t227, i8** %l40
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s229 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.229, i32 0, i32 0
  %t230 = load i8*, i8** %l40
  %t231 = add i8* %s229, %t230
  %s232 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.232, i32 0, i32 0
  %t233 = add i8* %t231, %s232
  %t234 = load i8*, i8** %l39
  %t235 = add i8* %t233, %t234
  %t236 = load double, double* %l5
  %t237 = sitofp i64 1 to double
  %t238 = fadd double %t236, %t237
  store double %t238, double* %l5
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s240 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.240, i32 0, i32 0
  %t241 = load i8*, i8** %l40
  %t242 = add i8* %s240, %t241
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load i8*, i8** %l32
  %s245 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.245, i32 0, i32 0
  %t246 = add i8* %t244, %s245
  %t247 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t243, i8* %t246)
  store { i8**, i64 }* %t247, { i8**, i64 }** %l1
  %t248 = load double, double* %l5
  %t249 = call i8* @format_temp_name(double %t248)
  store i8* %t249, i8** %l41
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s251 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.251, i32 0, i32 0
  %t252 = load i8*, i8** %l41
  %t253 = add i8* %s251, %t252
  %t254 = load double, double* %l5
  %t255 = sitofp i64 1 to double
  %t256 = fadd double %t254, %t255
  store double %t256, double* %l5
  %t257 = load double, double* %l5
  %t258 = call i8* @format_temp_name(double %t257)
  store i8* %t258, i8** %l42
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s260 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.260, i32 0, i32 0
  %t261 = load i8*, i8** %l42
  %t262 = add i8* %s260, %t261
  %s263 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.263, i32 0, i32 0
  %t264 = add i8* %t262, %s263
  %t265 = load double, double* %l19
  %t266 = load double, double* %l5
  %t267 = sitofp i64 1 to double
  %t268 = fadd double %t266, %t267
  store double %t268, double* %l5
  %t269 = load double, double* %l5
  %t270 = call i8* @format_temp_name(double %t269)
  store i8* %t270, i8** %l43
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s272 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.272, i32 0, i32 0
  %t273 = load i8*, i8** %l43
  %t274 = add i8* %s272, %t273
  %s275 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.275, i32 0, i32 0
  %t276 = add i8* %t274, %s275
  %t277 = load double, double* %l19
  %t278 = load double, double* %l5
  %t279 = sitofp i64 1 to double
  %t280 = fadd double %t278, %t279
  store double %t280, double* %l5
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s282 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.282, i32 0, i32 0
  %t283 = load double, double* %l19
  %t284 = load i8*, i8** %l36
  %t285 = insertvalue %LoopContext undef, i8* %t284, 0
  %t286 = load i8*, i8** %l34
  %t287 = insertvalue %LoopContext %t285, i8* %t286, 1
  store %LoopContext %t287, %LoopContext* %l44
  %t288 = load %LoopContext, %LoopContext* %l44
  %t289 = call { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }* %loop_stack, %LoopContext %t288)
  store { %LoopContext*, i64 }* %t289, { %LoopContext*, i64 }** %l45
  %t290 = load i8*, i8** %l32
  %t291 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t290)
  store i8* %t291, i8** %l46
  store double 0.0, double* %l47
  %t292 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t293 = load double, double* %l47
  %t294 = call { %LocalBinding*, i64 }* @append_local_binding({ %LocalBinding*, i64 }* %t292, %LocalBinding zeroinitializer)
  store { %LocalBinding*, i64 }* %t294, { %LocalBinding*, i64 }** %l48
  store double 0.0, double* %l49
  %t295 = load double, double* %l49
  %t296 = load double, double* %l49
  %t297 = load double, double* %l49
  %t298 = load double, double* %l49
  %t299 = load double, double* %l49
  %t300 = load double, double* %l49
  %t301 = load double, double* %l49
  %t302 = load double, double* %l49
  %t303 = load double, double* %l49
  %t304 = load double, double* %l49
  %t305 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t306 = load double, double* %l49
  %t307 = load double, double* %l49
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t309 = load i8*, i8** %l34
  %s310 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.310, i32 0, i32 0
  %t311 = add i8* %t309, %s310
  %t312 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t308, i8* %t311)
  store { i8**, i64 }* %t312, { i8**, i64 }** %l1
  %t313 = load double, double* %l5
  %t314 = call i8* @format_temp_name(double %t313)
  store i8* %t314, i8** %l50
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s316 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.316, i32 0, i32 0
  %t317 = load i8*, i8** %l50
  %t318 = add i8* %s316, %t317
  %t319 = load double, double* %l5
  %t320 = sitofp i64 1 to double
  %t321 = fadd double %t319, %t320
  store double %t321, double* %l5
  %t322 = load double, double* %l5
  %t323 = call i8* @format_temp_name(double %t322)
  store i8* %t323, i8** %l51
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s325 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.325, i32 0, i32 0
  %t326 = load i8*, i8** %l51
  %t327 = add i8* %s325, %t326
  %s328 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.328, i32 0, i32 0
  %t329 = add i8* %t327, %s328
  %t330 = load i8*, i8** %l50
  %t331 = add i8* %t329, %t330
  %t332 = load double, double* %l5
  %t333 = sitofp i64 1 to double
  %t334 = fadd double %t332, %t333
  store double %t334, double* %l5
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s336 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.336, i32 0, i32 0
  %t337 = load i8*, i8** %l51
  %t338 = add i8* %s336, %t337
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s340 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.340, i32 0, i32 0
  %t341 = load i8*, i8** %l30
  %t342 = add i8* %s340, %t341
  %t343 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t339, i8* %t342)
  store { i8**, i64 }* %t343, { i8**, i64 }** %l1
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t345 = load i8*, i8** %l36
  %s346 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.346, i32 0, i32 0
  %t347 = add i8* %t345, %s346
  %t348 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t344, i8* %t347)
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  store { %LocalBinding*, i64 }* %locals, { %LocalBinding*, i64 }** %l3
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t350 = insertvalue %BlockLoweringResult undef, { i8**, i64 }* %t349, 0
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t352 = insertvalue %BlockLoweringResult %t350, { i8**, i64 }* %t351, 1
  %t353 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t354 = insertvalue %BlockLoweringResult %t352, { i8**, i64 }* null, 2
  %t355 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t356 = insertvalue %BlockLoweringResult %t354, { i8**, i64 }* null, 3
  %t357 = load double, double* %l5
  %t358 = insertvalue %BlockLoweringResult %t356, double %t357, 4
  %t359 = load double, double* %l6
  %t360 = insertvalue %BlockLoweringResult %t358, double %t359, 5
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t362 = insertvalue %BlockLoweringResult %t360, { i8**, i64 }* %t361, 6
  %t363 = insertvalue %BlockLoweringResult %t362, i1 0, 7
  %t364 = load double, double* %l7
  %t365 = insertvalue %BlockLoweringResult %t363, double %t364, 8
  %t366 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t367 = insertvalue %BlockLoweringResult %t365, { i8**, i64 }* null, 9
  %t368 = load double, double* %l9
  %t369 = insertvalue %BlockLoweringResult %t367, double %t368, 10
  %t370 = load double, double* %l13
  %t371 = insertvalue %BlockLoweringResult %t369, double %t370, 11
  %t372 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t373 = insertvalue %BlockLoweringResult %t371, { i8**, i64 }* null, 12
  %t374 = alloca [0 x double]
  %t375 = getelementptr [0 x double], [0 x double]* %t374, i32 0, i32 0
  %t376 = alloca { double*, i64 }
  %t377 = getelementptr { double*, i64 }, { double*, i64 }* %t376, i32 0, i32 0
  store double* %t375, double** %t377
  %t378 = getelementptr { double*, i64 }, { double*, i64 }* %t376, i32 0, i32 1
  store i64 0, i64* %t378
  %t379 = insertvalue %BlockLoweringResult %t373, { i8**, i64 }* null, 13
  ret %BlockLoweringResult %t379
}

define %MatchStructure @collect_match_structure({ i8**, i64 }* %instructions, double %start_index, double %end, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %MatchCaseStructure*, i64 }*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca %MatchCaseStructure
  %l7 = alloca i8*
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
  store i8* null, i8** %l2
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %start_index, %t10
  store double %t11, double* %l3
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l4
  store double %end, double* %l5
  %t13 = load double, double* %l5
  %t14 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp ogt double %t13, %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t20 = load i8*, i8** %l2
  %t21 = load double, double* %l3
  %t22 = load double, double* %l4
  %t23 = load double, double* %l5
  br i1 %t17, label %then0, label %merge1
then0:
  %t24 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  store double %t26, double* %l5
  br label %merge1
merge1:
  %t27 = phi double [ %t26, %then0 ], [ %t23, %entry ]
  store double %t27, double* %l5
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  %t33 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t93 = phi { i8**, i64 }* [ %t28, %entry ], [ %t90, %loop.latch4 ]
  %t94 = phi { %MatchCaseStructure*, i64 }* [ %t29, %entry ], [ %t91, %loop.latch4 ]
  %t95 = phi double [ %t31, %entry ], [ %t92, %loop.latch4 ]
  store { i8**, i64 }* %t93, { i8**, i64 }** %l0
  store { %MatchCaseStructure*, i64 }* %t94, { %MatchCaseStructure*, i64 }** %l1
  store double %t95, double* %l3
  br label %loop.body3
loop.body3:
  %t34 = load double, double* %l3
  %t35 = load double, double* %l5
  %t36 = fcmp oge double %t34, %t35
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  %t42 = load double, double* %l5
  br i1 %t36, label %then6, label %merge7
then6:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s44 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.44, i32 0, i32 0
  %t45 = add i8* %s44, %function_name
  %s46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  %t48 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t43, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l2
  %t50 = icmp ne i8* %t49, null
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l3
  %t55 = load double, double* %l4
  %t56 = load double, double* %l5
  br i1 %t50, label %then8, label %merge9
then8:
  %t57 = load i8*, i8** %l2
  %t58 = load double, double* %l5
  %t59 = call %MatchCaseStructure @finalize_match_case(i8* %t57, double %t58)
  store %MatchCaseStructure %t59, %MatchCaseStructure* %l6
  %t60 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t61 = load %MatchCaseStructure, %MatchCaseStructure* %l6
  %t62 = call { %MatchCaseStructure*, i64 }* @append_match_case({ %MatchCaseStructure*, i64 }* %t60, %MatchCaseStructure %t61)
  store { %MatchCaseStructure*, i64 }* %t62, { %MatchCaseStructure*, i64 }** %l1
  br label %merge9
merge9:
  %t63 = phi { %MatchCaseStructure*, i64 }* [ %t62, %then8 ], [ %t52, %then6 ]
  store { %MatchCaseStructure*, i64 }* %t63, { %MatchCaseStructure*, i64 }** %l1
  ret %MatchStructure zeroinitializer
merge7:
  %t64 = load double, double* %l3
  %t65 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t66 = extractvalue { i8**, i64 } %t65, 0
  %t67 = extractvalue { i8**, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  %t69 = getelementptr i8*, i8** %t66, i64 %t64
  %t70 = load i8*, i8** %t69
  store i8* %t70, i8** %l7
  %t71 = load i8*, i8** %l7
  %t72 = load i8*, i8** %l7
  %t73 = load double, double* %l4
  %t74 = sitofp i64 0 to double
  %t75 = fcmp ogt double %t73, %t74
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t78 = load i8*, i8** %l2
  %t79 = load double, double* %l3
  %t80 = load double, double* %l4
  %t81 = load double, double* %l5
  %t82 = load i8*, i8** %l7
  br i1 %t75, label %then10, label %merge11
then10:
  %t83 = load double, double* %l3
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l3
  br label %loop.latch4
merge11:
  %t86 = load i8*, i8** %l7
  %t87 = load double, double* %l3
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l3
  br label %loop.latch4
loop.latch4:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t92 = load double, double* %l3
  br label %loop.header2
afterloop5:
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

define %MatchCaseStructure @finalize_match_case(i8* %case, double %body_end) {
entry:
  %l0 = alloca i8*
  store i8* %case, i8** %l0
  %t0 = load i8*, i8** %l0
  %t1 = insertvalue %MatchCaseStructure undef, i8* null, 0
  %t2 = load i8*, i8** %l0
  %t3 = insertvalue %MatchCaseStructure %t1, i8* null, 1
  %t4 = load i8*, i8** %l0
  %t5 = insertvalue %MatchCaseStructure %t3, double 0.0, 2
  %t6 = insertvalue %MatchCaseStructure %t5, double %body_end, 3
  %t7 = load i8*, i8** %l0
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
  %t4 = icmp eq i8* %t2, %s3
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  ret i1 0
}

define %BlockLoweringResult @lower_match_instruction(i8* %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, { i8**, i64 }* %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
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
  %l26 = alloca %LocalBinding
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
  %l39 = alloca i1
  %l40 = alloca double
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
  %t91 = phi { i8**, i64 }* [ %t62, %entry ], [ %t87, %loop.latch2 ]
  %t92 = phi { i8**, i64 }* [ %t63, %entry ], [ %t88, %loop.latch2 ]
  %t93 = phi double [ %t50, %entry ], [ %t89, %loop.latch2 ]
  %t94 = phi double [ %t64, %entry ], [ %t90, %loop.latch2 ]
  store { i8**, i64 }* %t91, { i8**, i64 }** %l17
  store { i8**, i64 }* %t92, { i8**, i64 }** %l18
  store double %t93, double* %l5
  store double %t94, double* %l19
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
  %t84 = load double, double* %l19
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l19
  br label %loop.latch2
loop.latch2:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t89 = load double, double* %l5
  %t90 = load double, double* %l19
  br label %loop.header0
afterloop3:
  %s95 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.95, i32 0, i32 0
  %t96 = load double, double* %l5
  %t97 = call %BlockLabelResult @allocate_block_label(i8* %s95, double %t96)
  store %BlockLabelResult %t97, %BlockLabelResult* %l22
  %t98 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t99 = extractvalue %BlockLabelResult %t98, 0
  store i8* %t99, i8** %l23
  %t100 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t101 = extractvalue %BlockLabelResult %t100, 1
  store double %t101, double* %l5
  %t102 = alloca [0 x double]
  %t103 = getelementptr [0 x double], [0 x double]* %t102, i32 0, i32 0
  %t104 = alloca { double*, i64 }
  %t105 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 0
  store double* %t103, double** %t105
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  store { i8**, i64 }* null, { i8**, i64 }** %l24
  %t107 = sitofp i64 0 to double
  store double %t107, double* %l25
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t112 = load double, double* %l4
  %t113 = load double, double* %l5
  %t114 = load double, double* %l6
  %t115 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t116 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t117 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t118 = load double, double* %l10
  %t119 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t120 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t121 = load double, double* %l13
  %t122 = load double, double* %l14
  %t123 = load double, double* %l15
  %t124 = load double, double* %l16
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t127 = load double, double* %l19
  %t128 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t129 = load i8*, i8** %l23
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t131 = load double, double* %l25
  br label %loop.header4
loop.header4:
  %t201 = phi double [ %t112, %entry ], [ %t197, %loop.latch6 ]
  %t202 = phi { i8**, i64 }* [ %t109, %entry ], [ %t198, %loop.latch6 ]
  %t203 = phi { i8**, i64 }* [ %t130, %entry ], [ %t199, %loop.latch6 ]
  %t204 = phi double [ %t131, %entry ], [ %t200, %loop.latch6 ]
  store double %t201, double* %l4
  store { i8**, i64 }* %t202, { i8**, i64 }** %l1
  store { i8**, i64 }* %t203, { i8**, i64 }** %l24
  store double %t204, double* %l25
  br label %loop.body5
loop.body5:
  %t132 = load double, double* %l25
  %t133 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t134 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t133
  %t135 = extractvalue { %LocalBinding*, i64 } %t134, 1
  %t136 = sitofp i64 %t135 to double
  %t137 = fcmp oge double %t132, %t136
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t141 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t142 = load double, double* %l4
  %t143 = load double, double* %l5
  %t144 = load double, double* %l6
  %t145 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t146 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t147 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t148 = load double, double* %l10
  %t149 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t150 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t151 = load double, double* %l13
  %t152 = load double, double* %l14
  %t153 = load double, double* %l15
  %t154 = load double, double* %l16
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t157 = load double, double* %l19
  %t158 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t159 = load i8*, i8** %l23
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t161 = load double, double* %l25
  br i1 %t137, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t162 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t163 = load double, double* %l25
  %t164 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t162
  %t165 = extractvalue { %LocalBinding*, i64 } %t164, 0
  %t166 = extractvalue { %LocalBinding*, i64 } %t164, 1
  %t167 = icmp uge i64 %t163, %t166
  ; bounds check: %t167 (if true, out of bounds)
  %t168 = getelementptr %LocalBinding, %LocalBinding* %t165, i64 %t163
  %t169 = load %LocalBinding, %LocalBinding* %t168
  store %LocalBinding %t169, %LocalBinding* %l26
  %t170 = load double, double* %l4
  %t171 = call i8* @format_temp_name(double %t170)
  store i8* %t171, i8** %l27
  %t172 = load double, double* %l4
  %t173 = sitofp i64 1 to double
  %t174 = fadd double %t172, %t173
  store double %t174, double* %l4
  %s175 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.175, i32 0, i32 0
  %t176 = load i8*, i8** %l27
  %t177 = add i8* %s175, %t176
  %s178 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.178, i32 0, i32 0
  %t179 = add i8* %t177, %s178
  %t180 = load %LocalBinding, %LocalBinding* %l26
  %t181 = extractvalue %LocalBinding %t180, 2
  %t182 = add i8* %t179, %t181
  %s183 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.183, i32 0, i32 0
  %t184 = add i8* %t182, %s183
  %t185 = load %LocalBinding, %LocalBinding* %l26
  %t186 = extractvalue %LocalBinding %t185, 2
  %t187 = add i8* %t184, %t186
  store double 0.0, double* %l28
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t189 = load double, double* %l28
  %t190 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t188, i8* null)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l1
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t192 = load i8*, i8** %l27
  %t193 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t191, i8* %t192)
  store { i8**, i64 }* %t193, { i8**, i64 }** %l24
  %t194 = load double, double* %l25
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l25
  br label %loop.latch6
loop.latch6:
  %t197 = load double, double* %l4
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t200 = load double, double* %l25
  br label %loop.header4
afterloop7:
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s206 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.206, i32 0, i32 0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t208 = load { i8**, i64 }, { i8**, i64 }* %t207
  %t209 = extractvalue { i8**, i64 } %t208, 0
  %t210 = extractvalue { i8**, i64 } %t208, 1
  %t211 = icmp uge i64 0, %t210
  ; bounds check: %t211 (if true, out of bounds)
  %t212 = getelementptr i8*, i8** %t209, i64 0
  %t213 = load i8*, i8** %t212
  %t214 = add i8* %s206, %t213
  %t215 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t205, i8* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l1
  store i1 1, i1* %l29
  store i1 0, i1* %l30
  %t216 = alloca [0 x double]
  %t217 = getelementptr [0 x double], [0 x double]* %t216, i32 0, i32 0
  %t218 = alloca { double*, i64 }
  %t219 = getelementptr { double*, i64 }, { double*, i64 }* %t218, i32 0, i32 0
  store double* %t217, double** %t219
  %t220 = getelementptr { double*, i64 }, { double*, i64 }* %t218, i32 0, i32 1
  store i64 0, i64* %t220
  store { %MatchArmMutations*, i64 }* null, { %MatchArmMutations*, i64 }** %l31
  %t221 = sitofp i64 0 to double
  store double %t221, double* %l19
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t225 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t226 = load double, double* %l4
  %t227 = load double, double* %l5
  %t228 = load double, double* %l6
  %t229 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t230 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t231 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t232 = load double, double* %l10
  %t233 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t234 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t235 = load double, double* %l13
  %t236 = load double, double* %l14
  %t237 = load double, double* %l15
  %t238 = load double, double* %l16
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t241 = load double, double* %l19
  %t242 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t243 = load i8*, i8** %l23
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t245 = load double, double* %l25
  %t246 = load i1, i1* %l29
  %t247 = load i1, i1* %l30
  %t248 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  br label %loop.header10
loop.header10:
  %t323 = phi { i8**, i64 }* [ %t223, %entry ], [ %t310, %loop.latch12 ]
  %t324 = phi { i8**, i64 }* [ %t222, %entry ], [ %t311, %loop.latch12 ]
  %t325 = phi double [ %t226, %entry ], [ %t312, %loop.latch12 ]
  %t326 = phi { %StringConstant*, i64 }* [ %t234, %entry ], [ %t313, %loop.latch12 ]
  %t327 = phi { %LifetimeRegionMetadata*, i64 }* [ %t231, %entry ], [ %t314, %loop.latch12 ]
  %t328 = phi { i8**, i64 }* [ %t224, %entry ], [ %t315, %loop.latch12 ]
  %t329 = phi { %LocalBinding*, i64 }* [ %t225, %entry ], [ %t316, %loop.latch12 ]
  %t330 = phi double [ %t227, %entry ], [ %t317, %loop.latch12 ]
  %t331 = phi double [ %t228, %entry ], [ %t318, %loop.latch12 ]
  %t332 = phi double [ %t232, %entry ], [ %t319, %loop.latch12 ]
  %t333 = phi { %LocalMutation*, i64 }* [ %t233, %entry ], [ %t320, %loop.latch12 ]
  %t334 = phi { %MatchArmMutations*, i64 }* [ %t248, %entry ], [ %t321, %loop.latch12 ]
  %t335 = phi double [ %t241, %entry ], [ %t322, %loop.latch12 ]
  store { i8**, i64 }* %t323, { i8**, i64 }** %l1
  store { i8**, i64 }* %t324, { i8**, i64 }** %l0
  store double %t325, double* %l4
  store { %StringConstant*, i64 }* %t326, { %StringConstant*, i64 }** %l12
  store { %LifetimeRegionMetadata*, i64 }* %t327, { %LifetimeRegionMetadata*, i64 }** %l9
  store { i8**, i64 }* %t328, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %t329, { %LocalBinding*, i64 }** %l3
  store double %t330, double* %l5
  store double %t331, double* %l6
  store double %t332, double* %l10
  store { %LocalMutation*, i64 }* %t333, { %LocalMutation*, i64 }** %l11
  store { %MatchArmMutations*, i64 }* %t334, { %MatchArmMutations*, i64 }** %l31
  store double %t335, double* %l19
  br label %loop.body11
loop.body11:
  %t249 = load double, double* %l19
  %t250 = load double, double* %l13
  %t251 = load double, double* %l13
  store double 0.0, double* %l32
  %t252 = load i8*, i8** %l23
  store i8* %t252, i8** %l33
  %t253 = load double, double* %l19
  %t254 = sitofp i64 1 to double
  %t255 = fadd double %t253, %t254
  %t256 = load double, double* %l13
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t259 = load double, double* %l19
  %t260 = load { i8**, i64 }, { i8**, i64 }* %t258
  %t261 = extractvalue { i8**, i64 } %t260, 0
  %t262 = extractvalue { i8**, i64 } %t260, 1
  %t263 = icmp uge i64 %t259, %t262
  ; bounds check: %t263 (if true, out of bounds)
  %t264 = getelementptr i8*, i8** %t261, i64 %t259
  %t265 = load i8*, i8** %t264
  %s266 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.266, i32 0, i32 0
  %t267 = add i8* %t265, %s266
  %t268 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t257, i8* %t267)
  store { i8**, i64 }* %t268, { i8**, i64 }** %l1
  store double 0.0, double* %l34
  %t269 = load double, double* %l34
  %t270 = load double, double* %l34
  %t271 = load double, double* %l34
  %t272 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t273 = load double, double* %l34
  %t274 = load double, double* %l34
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t277 = load double, double* %l19
  %t278 = load { i8**, i64 }, { i8**, i64 }* %t276
  %t279 = extractvalue { i8**, i64 } %t278, 0
  %t280 = extractvalue { i8**, i64 } %t278, 1
  %t281 = icmp uge i64 %t277, %t280
  ; bounds check: %t281 (if true, out of bounds)
  %t282 = getelementptr i8*, i8** %t279, i64 %t277
  %t283 = load i8*, i8** %t282
  %s284 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.284, i32 0, i32 0
  %t285 = add i8* %t283, %s284
  %t286 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t275, i8* %t285)
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  %t287 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store { %LocalBinding*, i64 }* %t287, { %LocalBinding*, i64 }** %l35
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store { i8**, i64 }* %t288, { i8**, i64 }** %l36
  %t289 = load double, double* %l6
  store double %t289, double* %l37
  %t293 = load double, double* %l34
  store double 0.0, double* %l38
  %t294 = load double, double* %l38
  %t295 = load double, double* %l38
  %t296 = load double, double* %l38
  %t297 = load double, double* %l38
  %t298 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l35
  store { %LocalBinding*, i64 }* %t298, { %LocalBinding*, i64 }** %l3
  %t299 = load double, double* %l38
  %t300 = load double, double* %l38
  %t301 = load double, double* %l38
  %t302 = load double, double* %l38
  %t303 = load double, double* %l38
  %t304 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t305 = load double, double* %l38
  %t306 = load double, double* %l38
  %t307 = load double, double* %l19
  %t308 = sitofp i64 1 to double
  %t309 = fadd double %t307, %t308
  store double %t309, double* %l19
  br label %loop.latch12
loop.latch12:
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t312 = load double, double* %l4
  %t313 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t314 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t316 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t317 = load double, double* %l5
  %t318 = load double, double* %l6
  %t319 = load double, double* %l10
  %t320 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t321 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  %t322 = load double, double* %l19
  br label %loop.header10
afterloop13:
  %t337 = load i1, i1* %l29
  br label %logical_and_entry_336

logical_and_entry_336:
  br i1 %t337, label %logical_and_right_336, label %logical_and_merge_336

logical_and_right_336:
  %t338 = load i1, i1* %l30
  br label %logical_and_right_end_336

logical_and_right_end_336:
  br label %logical_and_merge_336

logical_and_merge_336:
  %t339 = phi i1 [ false, %logical_and_entry_336 ], [ %t338, %logical_and_right_end_336 ]
  store i1 %t339, i1* %l39
  %t340 = load i1, i1* %l39
  %t341 = xor i1 %t340, 1
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t345 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t346 = load double, double* %l4
  %t347 = load double, double* %l5
  %t348 = load double, double* %l6
  %t349 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t350 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t351 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t352 = load double, double* %l10
  %t353 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t354 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t355 = load double, double* %l13
  %t356 = load double, double* %l14
  %t357 = load double, double* %l15
  %t358 = load double, double* %l16
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t361 = load double, double* %l19
  %t362 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t363 = load i8*, i8** %l23
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t365 = load double, double* %l25
  %t366 = load i1, i1* %l29
  %t367 = load i1, i1* %l30
  %t368 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  %t369 = load i1, i1* %l39
  br i1 %t341, label %then14, label %merge15
then14:
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t371 = load i8*, i8** %l23
  %s372 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.372, i32 0, i32 0
  %t373 = add i8* %t371, %s372
  %t374 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t370, i8* %t373)
  store { i8**, i64 }* %t374, { i8**, i64 }** %l1
  store double 0.0, double* %l40
  %t375 = load double, double* %l40
  %t376 = load double, double* %l40
  br label %merge15
merge15:
  %t377 = phi { i8**, i64 }* [ %t374, %then14 ], [ %t343, %entry ]
  %t378 = phi { i8**, i64 }* [ null, %then14 ], [ %t343, %entry ]
  %t379 = phi double [ 0.0, %then14 ], [ %t346, %entry ]
  store { i8**, i64 }* %t377, { i8**, i64 }** %l1
  store { i8**, i64 }* %t378, { i8**, i64 }** %l1
  store double %t379, double* %l4
  ret %BlockLoweringResult zeroinitializer
}

define %MatchCaseCondition @lower_match_case_condition(i8* %function_name, %LLVMOperand %subject_operand, %MatchCaseStructure %case, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca { %MatchFieldBinding*, i64 }*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca { %StringConstant*, i64 }*
  %l8 = alloca %EnumLiteralParse
  %l9 = alloca double
  %l10 = alloca %ExpressionResult
  %l11 = alloca %BinaryAlignmentResult
  %l12 = alloca double
  %l13 = alloca i8*
  %l14 = alloca i1
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
  store i8* null, i8** %l3
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { %MatchFieldBinding*, i64 }* null, { %MatchFieldBinding*, i64 }** %l4
  store i8* null, i8** %l5
  store i8* null, i8** %l6
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l7
  %t15 = extractvalue %MatchCaseStructure %case, 4
  %t16 = xor i1 %t15, 1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load i8*, i8** %l3
  %t21 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t22 = load i8*, i8** %l5
  %t23 = load i8*, i8** %l6
  %t24 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  br i1 %t16, label %then0, label %merge1
then0:
  %t25 = extractvalue %MatchCaseStructure %case, 0
  %t26 = call %EnumLiteralParse @parse_enum_literal(i8* %t25)
  store %EnumLiteralParse %t26, %EnumLiteralParse* %l8
  %t28 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t29 = extractvalue %EnumLiteralParse %t28, 0
  br label %logical_and_entry_27

logical_and_entry_27:
  br i1 %t29, label %logical_and_right_27, label %logical_and_merge_27

logical_and_right_27:
  %t30 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t31 = extractvalue %EnumLiteralParse %t30, 1
  br label %logical_and_right_end_27

logical_and_right_end_27:
  br label %logical_and_merge_27

logical_and_merge_27:
  %t32 = phi i1 [ false, %logical_and_entry_27 ], [ %t31, %logical_and_right_end_27 ]
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  %t36 = load i8*, i8** %l3
  %t37 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t38 = load i8*, i8** %l5
  %t39 = load i8*, i8** %l6
  %t40 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t41 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  br i1 %t32, label %then2, label %else3
then2:
  %t42 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t43 = extractvalue %EnumLiteralParse %t42, 2
  %t44 = call double @resolve_enum_info_for_literal(%TypeContext %context, i8* %t43)
  store double %t44, double* %l9
  %t45 = load double, double* %l9
  br label %merge4
else3:
  %t46 = extractvalue %MatchCaseStructure %case, 0
  %t47 = load double, double* %l2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = call %ExpressionResult @lower_expression(i8* %t46, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t47, { i8**, i64 }* %t48, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t49, %ExpressionResult* %l10
  %t50 = load %ExpressionResult, %ExpressionResult* %l10
  %t51 = extractvalue %ExpressionResult %t50, 3
  %t52 = call double @diagnosticsconcat({ i8**, i64 }* %t51)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t53 = load %ExpressionResult, %ExpressionResult* %l10
  %t54 = extractvalue %ExpressionResult %t53, 0
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  %t55 = load %ExpressionResult, %ExpressionResult* %l10
  %t56 = extractvalue %ExpressionResult %t55, 1
  store double %t56, double* %l2
  %t57 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t58 = load %ExpressionResult, %ExpressionResult* %l10
  %t59 = extractvalue %ExpressionResult %t58, 4
  %t60 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t57, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t60, { %StringConstant*, i64 }** %l7
  %t61 = load %ExpressionResult, %ExpressionResult* %l10
  %t62 = extractvalue %ExpressionResult %t61, 2
  %t63 = icmp ne i8* %t62, null
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load double, double* %l2
  %t67 = load i8*, i8** %l3
  %t68 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t69 = load i8*, i8** %l5
  %t70 = load i8*, i8** %l6
  %t71 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t72 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t73 = load %ExpressionResult, %ExpressionResult* %l10
  br i1 %t63, label %then5, label %else6
then5:
  %t74 = load %ExpressionResult, %ExpressionResult* %l10
  %t75 = extractvalue %ExpressionResult %t74, 2
  %t76 = load double, double* %l2
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = call %BinaryAlignmentResult @harmonise_operands(%LLVMOperand %subject_operand, %LLVMOperand zeroinitializer, double %t76, { i8**, i64 }* %t77)
  store %BinaryAlignmentResult %t78, %BinaryAlignmentResult* %l11
  %t79 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t80 = extractvalue %BinaryAlignmentResult %t79, 4
  %t81 = call double @diagnosticsconcat({ i8**, i64 }* %t80)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t83 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t84 = extractvalue %BinaryAlignmentResult %t83, 2
  %t85 = icmp ne i8* %t84, null
  br label %logical_and_entry_82

logical_and_entry_82:
  br i1 %t85, label %logical_and_right_82, label %logical_and_merge_82

logical_and_right_82:
  %t86 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t87 = extractvalue %BinaryAlignmentResult %t86, 3
  %t88 = icmp ne i8* %t87, null
  br label %logical_and_right_end_82

logical_and_right_end_82:
  br label %logical_and_merge_82

logical_and_merge_82:
  %t89 = phi i1 [ false, %logical_and_entry_82 ], [ %t88, %logical_and_right_end_82 ]
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t92 = load double, double* %l2
  %t93 = load i8*, i8** %l3
  %t94 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t95 = load i8*, i8** %l5
  %t96 = load i8*, i8** %l6
  %t97 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t98 = load %EnumLiteralParse, %EnumLiteralParse* %l8
  %t99 = load %ExpressionResult, %ExpressionResult* %l10
  %t100 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  br i1 %t89, label %then8, label %else9
then8:
  %t101 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t102 = extractvalue %BinaryAlignmentResult %t101, 0
  store { i8**, i64 }* %t102, { i8**, i64 }** %l1
  %t103 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t104 = extractvalue %BinaryAlignmentResult %t103, 1
  store double %t104, double* %l2
  %t105 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t106 = extractvalue %BinaryAlignmentResult %t105, 2
  %t107 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t108 = extractvalue %BinaryAlignmentResult %t107, 3
  %t109 = load double, double* %l2
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l12
  %t111 = load double, double* %l12
  %t112 = load double, double* %l12
  %t113 = load double, double* %l12
  %t114 = load double, double* %l12
  br label %merge10
else9:
  %t115 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t116 = extractvalue %BinaryAlignmentResult %t115, 0
  store { i8**, i64 }* %t116, { i8**, i64 }** %l1
  %t117 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l11
  %t118 = extractvalue %BinaryAlignmentResult %t117, 1
  store double %t118, double* %l2
  br label %merge10
merge10:
  %t119 = phi { i8**, i64 }* [ %t102, %then8 ], [ %t116, %else9 ]
  %t120 = phi double [ %t104, %then8 ], [ %t118, %else9 ]
  %t121 = phi { i8**, i64 }* [ null, %then8 ], [ %t90, %else9 ]
  %t122 = phi i8* [ null, %then8 ], [ %t93, %else9 ]
  store { i8**, i64 }* %t119, { i8**, i64 }** %l1
  store double %t120, double* %l2
  store { i8**, i64 }* %t121, { i8**, i64 }** %l0
  store i8* %t122, i8** %l3
  br label %merge7
else6:
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s124 = getelementptr inbounds [55 x i8], [55 x i8]* @.str.124, i32 0, i32 0
  %t125 = add i8* %s124, %function_name
  %s126 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.126, i32 0, i32 0
  %t127 = add i8* %t125, %s126
  %t128 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t123, i8* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t129 = phi { i8**, i64 }* [ null, %then5 ], [ %t128, %else6 ]
  %t130 = phi { i8**, i64 }* [ %t102, %then5 ], [ %t65, %else6 ]
  %t131 = phi double [ %t104, %then5 ], [ %t66, %else6 ]
  %t132 = phi i8* [ null, %then5 ], [ %t67, %else6 ]
  store { i8**, i64 }* %t129, { i8**, i64 }** %l0
  store { i8**, i64 }* %t130, { i8**, i64 }** %l1
  store double %t131, double* %l2
  store i8* %t132, i8** %l3
  br label %merge4
merge4:
  %t133 = phi { i8**, i64 }* [ %t33, %then2 ], [ null, %else3 ]
  %t134 = phi { i8**, i64 }* [ %t34, %then2 ], [ %t54, %else3 ]
  %t135 = phi double [ %t35, %then2 ], [ %t56, %else3 ]
  %t136 = phi { %StringConstant*, i64 }* [ %t40, %then2 ], [ %t60, %else3 ]
  %t137 = phi i8* [ %t36, %then2 ], [ null, %else3 ]
  store { i8**, i64 }* %t133, { i8**, i64 }** %l0
  store { i8**, i64 }* %t134, { i8**, i64 }** %l1
  store double %t135, double* %l2
  store { %StringConstant*, i64 }* %t136, { %StringConstant*, i64 }** %l7
  store i8* %t137, i8** %l3
  br label %merge1
merge1:
  %t138 = phi { i8**, i64 }* [ null, %then0 ], [ %t17, %entry ]
  %t139 = phi { i8**, i64 }* [ %t54, %then0 ], [ %t18, %entry ]
  %t140 = phi double [ %t56, %then0 ], [ %t19, %entry ]
  %t141 = phi { %StringConstant*, i64 }* [ %t60, %then0 ], [ %t24, %entry ]
  %t142 = phi { i8**, i64 }* [ null, %then0 ], [ %t17, %entry ]
  %t143 = phi { i8**, i64 }* [ %t102, %then0 ], [ %t18, %entry ]
  %t144 = phi double [ %t104, %then0 ], [ %t19, %entry ]
  %t145 = phi { i8**, i64 }* [ null, %then0 ], [ %t17, %entry ]
  %t146 = phi { i8**, i64 }* [ null, %then0 ], [ %t18, %entry ]
  %t147 = phi double [ 0.0, %then0 ], [ %t19, %entry ]
  %t148 = phi i8* [ null, %then0 ], [ %t20, %entry ]
  %t149 = phi { i8**, i64 }* [ %t116, %then0 ], [ %t18, %entry ]
  %t150 = phi double [ %t118, %then0 ], [ %t19, %entry ]
  %t151 = phi { i8**, i64 }* [ %t128, %then0 ], [ %t17, %entry ]
  store { i8**, i64 }* %t138, { i8**, i64 }** %l0
  store { i8**, i64 }* %t139, { i8**, i64 }** %l1
  store double %t140, double* %l2
  store { %StringConstant*, i64 }* %t141, { %StringConstant*, i64 }** %l7
  store { i8**, i64 }* %t142, { i8**, i64 }** %l0
  store { i8**, i64 }* %t143, { i8**, i64 }** %l1
  store double %t144, double* %l2
  store { i8**, i64 }* %t145, { i8**, i64 }** %l0
  store { i8**, i64 }* %t146, { i8**, i64 }** %l1
  store double %t147, double* %l2
  store i8* %t148, i8** %l3
  store { i8**, i64 }* %t149, { i8**, i64 }** %l1
  store double %t150, double* %l2
  store { i8**, i64 }* %t151, { i8**, i64 }** %l0
  %t152 = extractvalue %MatchCaseStructure %case, 1
  %t153 = icmp ne i8* %t152, null
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = load double, double* %l2
  %t157 = load i8*, i8** %l3
  %t158 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t159 = load i8*, i8** %l5
  %t160 = load i8*, i8** %l6
  %t161 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  br i1 %t153, label %then11, label %merge12
then11:
  %t162 = extractvalue %MatchCaseStructure %case, 1
  %t163 = call i8* @trim_text(i8* %t162)
  store i8* %t163, i8** %l13
  %t164 = load i8*, i8** %l13
  br label %merge12
merge12:
  store i1 0, i1* %l14
  %t165 = extractvalue %MatchCaseStructure %case, 4
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load double, double* %l2
  %t169 = load i8*, i8** %l3
  %t170 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t171 = load i8*, i8** %l5
  %t172 = load i8*, i8** %l6
  %t173 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t174 = load i1, i1* %l14
  br i1 %t165, label %then13, label %merge14
then13:
  %t175 = extractvalue %MatchCaseStructure %case, 1
  %t176 = icmp eq i8* %t175, null
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = load double, double* %l2
  %t180 = load i8*, i8** %l3
  %t181 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t182 = load i8*, i8** %l5
  %t183 = load i8*, i8** %l6
  %t184 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t185 = load i1, i1* %l14
  br i1 %t176, label %then15, label %else16
then15:
  store i1 1, i1* %l14
  br label %merge17
else16:
  %t186 = extractvalue %MatchCaseStructure %case, 1
  %t187 = call i8* @trim_text(i8* %t186)
  store i8* %t187, i8** %l15
  %t188 = load i8*, i8** %l15
  br label %merge17
merge17:
  %t189 = phi i1 [ 1, %then15 ], [ %t185, %else16 ]
  store i1 %t189, i1* %l14
  br label %merge14
merge14:
  %t190 = phi i1 [ 1, %then13 ], [ %t174, %entry ]
  store i1 %t190, i1* %l14
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t192 = insertvalue %MatchCaseCondition undef, { i8**, i64 }* %t191, 0
  %t193 = load double, double* %l2
  %t194 = insertvalue %MatchCaseCondition %t192, double %t193, 1
  %t195 = load i8*, i8** %l3
  %t196 = insertvalue %MatchCaseCondition %t194, i8* %t195, 2
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = insertvalue %MatchCaseCondition %t196, { i8**, i64 }* %t197, 3
  %t199 = load i1, i1* %l14
  %t200 = insertvalue %MatchCaseCondition %t198, i1 %t199, 4
  %t201 = load { %MatchFieldBinding*, i64 }*, { %MatchFieldBinding*, i64 }** %l4
  %t202 = insertvalue %MatchCaseCondition %t200, { i8**, i64 }* null, 5
  %t203 = load i8*, i8** %l5
  %t204 = insertvalue %MatchCaseCondition %t202, i8* %t203, 6
  %t205 = load i8*, i8** %l6
  %t206 = insertvalue %MatchCaseCondition %t204, i8* %t205, 7
  %t207 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l7
  %t208 = insertvalue %MatchCaseCondition %t206, { i8**, i64 }* null, 8
  ret %MatchCaseCondition %t208
}

define %BlockLabelResult @allocate_block_label(i8* %prefix, double %counter) {
entry:
  ret %BlockLabelResult zeroinitializer
}

define %ConditionConversion @lower_condition_to_i1(i8* %function_name, i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %ExpressionResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %t0 = call { i8**, i64 }* @detect_suspension_conflicts(i8* %expression, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, i8* null)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = call %ExpressionResult @lower_expression(i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t1, %ExpressionResult* %l1
  %t2 = load %ExpressionResult, %ExpressionResult* %l1
  %t3 = extractvalue %ExpressionResult %t2, 3
  %t4 = call double @diagnosticsconcat({ i8**, i64 }* %t3)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load %ExpressionResult, %ExpressionResult* %l1
  %t6 = extractvalue %ExpressionResult %t5, 0
  store { i8**, i64 }* %t6, { i8**, i64 }** %l2
  %t7 = load %ExpressionResult, %ExpressionResult* %l1
  %t8 = extractvalue %ExpressionResult %t7, 1
  store double %t8, double* %l3
  %t9 = load %ExpressionResult, %ExpressionResult* %l1
  %t10 = extractvalue %ExpressionResult %t9, 4
  store { i8**, i64 }* %t10, { i8**, i64 }** %l4
  %t11 = load %ExpressionResult, %ExpressionResult* %l1
  %t12 = extractvalue %ExpressionResult %t11, 2
  %t13 = icmp eq i8* %t12, null
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load %ExpressionResult, %ExpressionResult* %l1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load double, double* %l3
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t13, label %then0, label %merge1
then0:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s20 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.20, i32 0, i32 0
  %t21 = add i8* %s20, %function_name
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  %t23 = add i8* %t21, %s22
  %t24 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t19, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = insertvalue %ConditionConversion undef, { i8**, i64 }* %t25, 0
  %t27 = load double, double* %l3
  %t28 = insertvalue %ConditionConversion %t26, double %t27, 1
  %t29 = insertvalue %ConditionConversion %t28, i8* null, 2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = insertvalue %ConditionConversion %t29, { i8**, i64 }* %t30, 3
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t33 = insertvalue %ConditionConversion %t31, { i8**, i64 }* %t32, 4
  ret %ConditionConversion %t33
merge1:
  %t34 = load %ExpressionResult, %ExpressionResult* %l1
  %t35 = extractvalue %ExpressionResult %t34, 2
  store i8* %t35, i8** %l5
  %t36 = load i8*, i8** %l5
  %t37 = load i8*, i8** %l5
  %t39 = load i8*, i8** %l5
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s41 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.41, i32 0, i32 0
  %t42 = load i8*, i8** %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t44 = insertvalue %ConditionConversion undef, { i8**, i64 }* %t43, 0
  %t45 = load double, double* %l3
  %t46 = insertvalue %ConditionConversion %t44, double %t45, 1
  %t47 = insertvalue %ConditionConversion %t46, i8* null, 2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = insertvalue %ConditionConversion %t47, { i8**, i64 }* %t48, 3
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t51 = insertvalue %ConditionConversion %t49, { i8**, i64 }* %t50, 4
  ret %ConditionConversion %t51
}

define { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }* %mutations) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %LocalMutation
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
  %t79 = phi { i8**, i64 }* [ %t6, %entry ], [ %t77, %loop.latch2 ]
  %t80 = phi double [ %t7, %entry ], [ %t78, %loop.latch2 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l0
  store double %t80, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LocalMutation*, i64 }, { %LocalMutation*, i64 }* %mutations
  %t10 = extractvalue { %LocalMutation*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %LocalMutation*, i64 }, { %LocalMutation*, i64 }* %mutations
  %t17 = extractvalue { %LocalMutation*, i64 } %t16, 0
  %t18 = extractvalue { %LocalMutation*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %LocalMutation, %LocalMutation* %t17, i64 %t15
  %t21 = load %LocalMutation, %LocalMutation* %t20
  store %LocalMutation %t21, %LocalMutation* %l2
  store i1 0, i1* %l3
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load %LocalMutation, %LocalMutation* %l2
  %t26 = load i1, i1* %l3
  %t27 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t60 = phi i1 [ %t26, %loop.body1 ], [ %t58, %loop.latch8 ]
  %t61 = phi double [ %t27, %loop.body1 ], [ %t59, %loop.latch8 ]
  store i1 %t60, i1* %l3
  store double %t61, double* %l4
  br label %loop.body7
loop.body7:
  %t28 = load double, double* %l4
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t31 = extractvalue { i8**, i64 } %t30, 1
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t28, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = load %LocalMutation, %LocalMutation* %l2
  %t37 = load i1, i1* %l3
  %t38 = load double, double* %l4
  br i1 %t33, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l4
  %t41 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 %t40
  %t46 = load i8*, i8** %t45
  %t47 = load %LocalMutation, %LocalMutation* %l2
  %t48 = extractvalue %LocalMutation %t47, 0
  %t49 = icmp eq i8* %t46, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load %LocalMutation, %LocalMutation* %l2
  %t53 = load i1, i1* %l3
  %t54 = load double, double* %l4
  br i1 %t49, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t55 = load double, double* %l4
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l4
  br label %loop.latch8
loop.latch8:
  %t58 = load i1, i1* %l3
  %t59 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t62 = load i1, i1* %l3
  %t63 = xor i1 %t62, 1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = load %LocalMutation, %LocalMutation* %l2
  %t67 = load i1, i1* %l3
  %t68 = load double, double* %l4
  br i1 %t63, label %then14, label %merge15
then14:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load %LocalMutation, %LocalMutation* %l2
  %t71 = extractvalue %LocalMutation %t70, 0
  %t72 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t69, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t73 = phi { i8**, i64 }* [ %t72, %then14 ], [ %t64, %loop.body1 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  %t74 = load double, double* %l1
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l1
  br label %loop.latch2
loop.latch2:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t81
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
  %t33 = phi i8* [ %t2, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t3, %entry ], [ %t32, %loop.latch2 ]
  store i8* %t33, i8** %l0
  store double %t34, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %strings
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t4, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp ogt double %t11, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then6, label %merge7
then6:
  %t16 = load i8*, i8** %l0
  %t17 = add i8* %t16, %separator
  store i8* %t17, i8** %l0
  br label %merge7
merge7:
  %t18 = phi i8* [ %t17, %then6 ], [ %t14, %loop.body1 ]
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load { i8**, i64 }, { i8**, i64 }* %strings
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  %t27 = add i8* %t19, %t26
  store i8* %t27, i8** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load i8*, i8** %l0
  ret i8* %t35
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
  %l4 = alloca %LocalMutation
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
  %t39 = phi double [ %t14, %entry ], [ %t38, %loop.latch2 ]
  store double %t39, double* %l3
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = load { %LocalMutation*, i64 }, { %LocalMutation*, i64 }* %mutations
  %t17 = extractvalue { %LocalMutation*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l3
  %t25 = load { %LocalMutation*, i64 }, { %LocalMutation*, i64 }* %mutations
  %t26 = extractvalue { %LocalMutation*, i64 } %t25, 0
  %t27 = extractvalue { %LocalMutation*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr %LocalMutation, %LocalMutation* %t26, i64 %t24
  %t30 = load %LocalMutation, %LocalMutation* %t29
  store %LocalMutation %t30, %LocalMutation* %l4
  %t31 = load %LocalMutation, %LocalMutation* %l4
  %t32 = extractvalue %LocalMutation %t31, 0
  %t33 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t32)
  store double %t33, double* %l5
  %t34 = load double, double* %l5
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch2
loop.latch2:
  %t38 = load double, double* %l3
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l6
  %t40 = load double, double* %l6
  %t41 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t42 = load double, double* %l2
  %t43 = insertvalue %PhiMergeResult %t41, double %t42, 1
  ret %PhiMergeResult %t43
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
  %l7 = alloca i8*
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca i8*
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
  %t117 = phi { i8**, i64 }* [ %t19, %entry ], [ %t115, %loop.latch2 ]
  %t118 = phi double [ %t20, %entry ], [ %t116, %loop.latch2 ]
  store { i8**, i64 }* %t117, { i8**, i64 }** %l5
  store double %t118, double* %l6
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l6
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t24 = extractvalue { i8**, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t21, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t33 = load double, double* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t35 = load double, double* %l6
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t34
  %t37 = extractvalue { i8**, i64 } %t36, 0
  %t38 = extractvalue { i8**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr i8*, i8** %t37, i64 %t35
  %t41 = load i8*, i8** %t40
  store i8* %t41, i8** %l7
  store i1 0, i1* %l8
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l9
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = load double, double* %l2
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t49 = load double, double* %l6
  %t50 = load i8*, i8** %l7
  %t51 = load i1, i1* %l8
  %t52 = load double, double* %l9
  br label %loop.header6
loop.header6:
  %t94 = phi i1 [ %t51, %loop.body1 ], [ %t92, %loop.latch8 ]
  %t95 = phi double [ %t52, %loop.body1 ], [ %t93, %loop.latch8 ]
  store i1 %t94, i1* %l8
  store double %t95, double* %l9
  br label %loop.body7
loop.body7:
  %t53 = load double, double* %l9
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t55 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t56 = extractvalue { i8**, i64 } %t55, 1
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp oge double %t53, %t57
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t65 = load double, double* %l6
  %t66 = load i8*, i8** %l7
  %t67 = load i1, i1* %l8
  %t68 = load double, double* %l9
  br i1 %t58, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t70 = load double, double* %l9
  %t71 = load { i8**, i64 }, { i8**, i64 }* %t69
  %t72 = extractvalue { i8**, i64 } %t71, 0
  %t73 = extractvalue { i8**, i64 } %t71, 1
  %t74 = icmp uge i64 %t70, %t73
  ; bounds check: %t74 (if true, out of bounds)
  %t75 = getelementptr i8*, i8** %t72, i64 %t70
  %t76 = load i8*, i8** %t75
  %t77 = load i8*, i8** %l7
  %t78 = icmp eq i8* %t76, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load double, double* %l2
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t85 = load double, double* %l6
  %t86 = load i8*, i8** %l7
  %t87 = load i1, i1* %l8
  %t88 = load double, double* %l9
  br i1 %t78, label %then12, label %merge13
then12:
  store i1 1, i1* %l8
  br label %afterloop9
merge13:
  %t89 = load double, double* %l9
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  store double %t91, double* %l9
  br label %loop.latch8
loop.latch8:
  %t92 = load i1, i1* %l8
  %t93 = load double, double* %l9
  br label %loop.header6
afterloop9:
  %t96 = load i1, i1* %l8
  %t97 = xor i1 %t96, 1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load double, double* %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t104 = load double, double* %l6
  %t105 = load i8*, i8** %l7
  %t106 = load i1, i1* %l8
  %t107 = load double, double* %l9
  br i1 %t97, label %then14, label %merge15
then14:
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t109 = load i8*, i8** %l7
  %t110 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t108, i8* %t109)
  store { i8**, i64 }* %t110, { i8**, i64 }** %l5
  br label %merge15
merge15:
  %t111 = phi { i8**, i64 }* [ %t110, %then14 ], [ %t103, %loop.body1 ]
  store { i8**, i64 }* %t111, { i8**, i64 }** %l5
  %t112 = load double, double* %l6
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  store double %t114, double* %l6
  br label %loop.latch2
loop.latch2:
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t116 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t119 = sitofp i64 0 to double
  store double %t119, double* %l10
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load double, double* %l2
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t126 = load double, double* %l6
  %t127 = load double, double* %l10
  br label %loop.header16
loop.header16:
  %t157 = phi double [ %t127, %entry ], [ %t156, %loop.latch18 ]
  store double %t157, double* %l10
  br label %loop.body17
loop.body17:
  %t128 = load double, double* %l10
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t130 = load { i8**, i64 }, { i8**, i64 }* %t129
  %t131 = extractvalue { i8**, i64 } %t130, 1
  %t132 = sitofp i64 %t131 to double
  %t133 = fcmp oge double %t128, %t132
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t136 = load double, double* %l2
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t140 = load double, double* %l6
  %t141 = load double, double* %l10
  br i1 %t133, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t143 = load double, double* %l10
  %t144 = load { i8**, i64 }, { i8**, i64 }* %t142
  %t145 = extractvalue { i8**, i64 } %t144, 0
  %t146 = extractvalue { i8**, i64 } %t144, 1
  %t147 = icmp uge i64 %t143, %t146
  ; bounds check: %t147 (if true, out of bounds)
  %t148 = getelementptr i8*, i8** %t145, i64 %t143
  %t149 = load i8*, i8** %t148
  store i8* %t149, i8** %l11
  %t150 = load i8*, i8** %l11
  %t151 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t150)
  store double %t151, double* %l12
  %t152 = load double, double* %l12
  %t153 = load double, double* %l10
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l10
  br label %loop.latch18
loop.latch18:
  %t156 = load double, double* %l10
  br label %loop.header16
afterloop19:
  store double 0.0, double* %l13
  %t158 = load double, double* %l13
  %t159 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t160 = load double, double* %l2
  %t161 = insertvalue %PhiMergeResult %t159, double %t160, 1
  ret %PhiMergeResult %t161
}

define %PhiMergeResult @emit_phi_merges_for_match({ %MatchArmMutations*, i64 }* %arm_mutations_list, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %preloaded_values, { i8**, i64 }* %lines, double %temp_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca %MatchArmMutations
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i1
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i8*
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
  %t158 = phi { i8**, i64 }* [ %t19, %entry ], [ %t156, %loop.latch2 ]
  %t159 = phi double [ %t20, %entry ], [ %t157, %loop.latch2 ]
  store { i8**, i64 }* %t158, { i8**, i64 }** %l3
  store double %t159, double* %l4
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l4
  %t22 = load { %MatchArmMutations*, i64 }, { %MatchArmMutations*, i64 }* %arm_mutations_list
  %t23 = extractvalue { %MatchArmMutations*, i64 } %t22, 1
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t21, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load double, double* %l2
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = load double, double* %l4
  br i1 %t25, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t31 = load double, double* %l4
  %t32 = load { %MatchArmMutations*, i64 }, { %MatchArmMutations*, i64 }* %arm_mutations_list
  %t33 = extractvalue { %MatchArmMutations*, i64 } %t32, 0
  %t34 = extractvalue { %MatchArmMutations*, i64 } %t32, 1
  %t35 = icmp uge i64 %t31, %t34
  ; bounds check: %t35 (if true, out of bounds)
  %t36 = getelementptr %MatchArmMutations, %MatchArmMutations* %t33, i64 %t31
  %t37 = load %MatchArmMutations, %MatchArmMutations* %t36
  store %MatchArmMutations %t37, %MatchArmMutations* %l5
  %t38 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t39 = extractvalue %MatchArmMutations %t38, 0
  %t40 = call { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }* null)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l6
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l7
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load double, double* %l2
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t46 = load double, double* %l4
  %t47 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t49 = load double, double* %l7
  br label %loop.header6
loop.header6:
  %t151 = phi { i8**, i64 }* [ %t45, %loop.body1 ], [ %t149, %loop.latch8 ]
  %t152 = phi double [ %t49, %loop.body1 ], [ %t150, %loop.latch8 ]
  store { i8**, i64 }* %t151, { i8**, i64 }** %l3
  store double %t152, double* %l7
  br label %loop.body7
loop.body7:
  %t50 = load double, double* %l7
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t51
  %t53 = extractvalue { i8**, i64 } %t52, 1
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp oge double %t50, %t54
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load double, double* %l2
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t60 = load double, double* %l4
  %t61 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t63 = load double, double* %l7
  br i1 %t55, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t65 = load double, double* %l7
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t64
  %t67 = extractvalue { i8**, i64 } %t66, 0
  %t68 = extractvalue { i8**, i64 } %t66, 1
  %t69 = icmp uge i64 %t65, %t68
  ; bounds check: %t69 (if true, out of bounds)
  %t70 = getelementptr i8*, i8** %t67, i64 %t65
  %t71 = load i8*, i8** %t70
  store i8* %t71, i8** %l8
  store i1 0, i1* %l9
  %t72 = sitofp i64 0 to double
  store double %t72, double* %l10
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load double, double* %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t77 = load double, double* %l4
  %t78 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t80 = load double, double* %l7
  %t81 = load i8*, i8** %l8
  %t82 = load i1, i1* %l9
  %t83 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t127 = phi i1 [ %t82, %loop.body7 ], [ %t125, %loop.latch14 ]
  %t128 = phi double [ %t83, %loop.body7 ], [ %t126, %loop.latch14 ]
  store i1 %t127, i1* %l9
  store double %t128, double* %l10
  br label %loop.body13
loop.body13:
  %t84 = load double, double* %l10
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t85
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = sitofp i64 %t87 to double
  %t89 = fcmp oge double %t84, %t88
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t92 = load double, double* %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t94 = load double, double* %l4
  %t95 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t97 = load double, double* %l7
  %t98 = load i8*, i8** %l8
  %t99 = load i1, i1* %l9
  %t100 = load double, double* %l10
  br i1 %t89, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t102 = load double, double* %l10
  %t103 = load { i8**, i64 }, { i8**, i64 }* %t101
  %t104 = extractvalue { i8**, i64 } %t103, 0
  %t105 = extractvalue { i8**, i64 } %t103, 1
  %t106 = icmp uge i64 %t102, %t105
  ; bounds check: %t106 (if true, out of bounds)
  %t107 = getelementptr i8*, i8** %t104, i64 %t102
  %t108 = load i8*, i8** %t107
  %t109 = load i8*, i8** %l8
  %t110 = icmp eq i8* %t108, %t109
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load double, double* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t115 = load double, double* %l4
  %t116 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t118 = load double, double* %l7
  %t119 = load i8*, i8** %l8
  %t120 = load i1, i1* %l9
  %t121 = load double, double* %l10
  br i1 %t110, label %then18, label %merge19
then18:
  store i1 1, i1* %l9
  br label %afterloop15
merge19:
  %t122 = load double, double* %l10
  %t123 = sitofp i64 1 to double
  %t124 = fadd double %t122, %t123
  store double %t124, double* %l10
  br label %loop.latch14
loop.latch14:
  %t125 = load i1, i1* %l9
  %t126 = load double, double* %l10
  br label %loop.header12
afterloop15:
  %t129 = load i1, i1* %l9
  %t130 = xor i1 %t129, 1
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load double, double* %l2
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t135 = load double, double* %l4
  %t136 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t138 = load double, double* %l7
  %t139 = load i8*, i8** %l8
  %t140 = load i1, i1* %l9
  %t141 = load double, double* %l10
  br i1 %t130, label %then20, label %merge21
then20:
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t143 = load i8*, i8** %l8
  %t144 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t142, i8* %t143)
  store { i8**, i64 }* %t144, { i8**, i64 }** %l3
  br label %merge21
merge21:
  %t145 = phi { i8**, i64 }* [ %t144, %then20 ], [ %t134, %loop.body7 ]
  store { i8**, i64 }* %t145, { i8**, i64 }** %l3
  %t146 = load double, double* %l7
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l7
  br label %loop.latch8
loop.latch8:
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t150 = load double, double* %l7
  br label %loop.header6
afterloop9:
  %t153 = load double, double* %l4
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l4
  br label %loop.latch2
loop.latch2:
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t157 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t160 = sitofp i64 0 to double
  store double %t160, double* %l11
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load double, double* %l2
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t165 = load double, double* %l4
  %t166 = load double, double* %l11
  br label %loop.header22
loop.header22:
  %t194 = phi double [ %t166, %entry ], [ %t193, %loop.latch24 ]
  store double %t194, double* %l11
  br label %loop.body23
loop.body23:
  %t167 = load double, double* %l11
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t169 = load { i8**, i64 }, { i8**, i64 }* %t168
  %t170 = extractvalue { i8**, i64 } %t169, 1
  %t171 = sitofp i64 %t170 to double
  %t172 = fcmp oge double %t167, %t171
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load double, double* %l2
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t177 = load double, double* %l4
  %t178 = load double, double* %l11
  br i1 %t172, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t180 = load double, double* %l11
  %t181 = load { i8**, i64 }, { i8**, i64 }* %t179
  %t182 = extractvalue { i8**, i64 } %t181, 0
  %t183 = extractvalue { i8**, i64 } %t181, 1
  %t184 = icmp uge i64 %t180, %t183
  ; bounds check: %t184 (if true, out of bounds)
  %t185 = getelementptr i8*, i8** %t182, i64 %t180
  %t186 = load i8*, i8** %t185
  store i8* %t186, i8** %l12
  %t187 = load i8*, i8** %l12
  %t188 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t187)
  store double %t188, double* %l13
  %t189 = load double, double* %l13
  %t190 = load double, double* %l11
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l11
  br label %loop.latch24
loop.latch24:
  %t193 = load double, double* %l11
  br label %loop.header22
afterloop25:
  store double 0.0, double* %l14
  %t195 = load double, double* %l14
  %t196 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t197 = load double, double* %l2
  %t198 = insertvalue %PhiMergeResult %t196, double %t197, 1
  ret %PhiMergeResult %t198
}

define %BlockLoweringResult @lower_if_instruction(i8* %function, double %start_index, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %block_counter, double %next_local_id, double %next_region_id, { i8**, i64 }* %functions, { %LoopContext*, i64 }* %loop_stack, double %end, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
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
  %l24 = alloca %LocalBinding
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
  %t140 = phi double [ %t50, %entry ], [ %t136, %loop.latch2 ]
  %t141 = phi { i8**, i64 }* [ %t47, %entry ], [ %t137, %loop.latch2 ]
  %t142 = phi { i8**, i64 }* [ %t69, %entry ], [ %t138, %loop.latch2 ]
  %t143 = phi double [ %t70, %entry ], [ %t139, %loop.latch2 ]
  store double %t140, double* %l3
  store { i8**, i64 }* %t141, { i8**, i64 }** %l0
  store { i8**, i64 }* %t142, { i8**, i64 }** %l22
  store double %t143, double* %l23
  br label %loop.body1
loop.body1:
  %t71 = load double, double* %l23
  %t72 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t73 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t72
  %t74 = extractvalue { %LocalBinding*, i64 } %t73, 1
  %t75 = sitofp i64 %t74 to double
  %t76 = fcmp oge double %t71, %t75
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t80 = load double, double* %l3
  %t81 = load double, double* %l4
  %t82 = load double, double* %l5
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t84 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t85 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t86 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l9
  %t87 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l10
  %t88 = load double, double* %l11
  %t89 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l12
  %t90 = load double, double* %l13
  %t91 = load double, double* %l14
  %t92 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t93 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t94 = load i8*, i8** %l17
  %t95 = load i8*, i8** %l18
  %t96 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t97 = load i8*, i8** %l20
  %t98 = load i8*, i8** %l21
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t100 = load double, double* %l23
  br i1 %t76, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t101 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t102 = load double, double* %l23
  %t103 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t101
  %t104 = extractvalue { %LocalBinding*, i64 } %t103, 0
  %t105 = extractvalue { %LocalBinding*, i64 } %t103, 1
  %t106 = icmp uge i64 %t102, %t105
  ; bounds check: %t106 (if true, out of bounds)
  %t107 = getelementptr %LocalBinding, %LocalBinding* %t104, i64 %t102
  %t108 = load %LocalBinding, %LocalBinding* %t107
  store %LocalBinding %t108, %LocalBinding* %l24
  %t109 = load double, double* %l3
  %t110 = call i8* @format_temp_name(double %t109)
  store i8* %t110, i8** %l25
  %t111 = load double, double* %l3
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l3
  %s114 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.114, i32 0, i32 0
  %t115 = load i8*, i8** %l25
  %t116 = add i8* %s114, %t115
  %s117 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.117, i32 0, i32 0
  %t118 = add i8* %t116, %s117
  %t119 = load %LocalBinding, %LocalBinding* %l24
  %t120 = extractvalue %LocalBinding %t119, 2
  %t121 = add i8* %t118, %t120
  %s122 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.122, i32 0, i32 0
  %t123 = add i8* %t121, %s122
  %t124 = load %LocalBinding, %LocalBinding* %l24
  %t125 = extractvalue %LocalBinding %t124, 2
  %t126 = add i8* %t123, %t125
  store double 0.0, double* %l26
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load double, double* %l26
  %t129 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t127, i8* null)
  store { i8**, i64 }* %t129, { i8**, i64 }** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t131 = load i8*, i8** %l25
  %t132 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t130, i8* %t131)
  store { i8**, i64 }* %t132, { i8**, i64 }** %l22
  %t133 = load double, double* %l23
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l23
  br label %loop.latch2
loop.latch2:
  %t136 = load double, double* %l3
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t139 = load double, double* %l23
  br label %loop.header0
afterloop3:
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.145, i32 0, i32 0
  %t146 = load double, double* %l14
  %t147 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  store { %LocalBinding*, i64 }* %t147, { %LocalBinding*, i64 }** %l27
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store { i8**, i64 }* %t148, { i8**, i64 }** %l28
  %t149 = load double, double* %l3
  store double %t149, double* %l29
  %t150 = load double, double* %l5
  store double %t150, double* %l30
  %t151 = load double, double* %l4
  store double %t151, double* %l31
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l17
  %s154 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.154, i32 0, i32 0
  %t155 = add i8* %t153, %s154
  %t156 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t152, i8* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %t157 = load i8*, i8** %l17
  %t158 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t157)
  store i8* %t158, i8** %l32
  store double 0.0, double* %l33
  %t159 = load double, double* %l33
  %t160 = load double, double* %l33
  %t161 = load double, double* %l33
  %t162 = load double, double* %l33
  %t163 = load double, double* %l33
  %t164 = load double, double* %l33
  %t165 = load double, double* %l33
  %t166 = load double, double* %l33
  %t167 = load double, double* %l33
  %t168 = load double, double* %l33
  %t169 = load double, double* %l33
  store double 0.0, double* %l34
  %t170 = load double, double* %l34
  %t171 = call double @collected_mutationsconcat(double %t170)
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l12
  %t172 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t173 = load double, double* %l33
  %t174 = load double, double* %l33
  store double 0.0, double* %l35
  %t175 = load double, double* %l35
  %t176 = fcmp one double %t175, 0.0
  %t177 = xor i1 %t176, 1
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t180 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t181 = load double, double* %l3
  %t182 = load double, double* %l4
  %t183 = load double, double* %l5
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t185 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t186 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t187 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l9
  %t188 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l10
  %t189 = load double, double* %l11
  %t190 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l12
  %t191 = load double, double* %l13
  %t192 = load double, double* %l14
  %t193 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t194 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t195 = load i8*, i8** %l17
  %t196 = load i8*, i8** %l18
  %t197 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t198 = load i8*, i8** %l20
  %t199 = load i8*, i8** %l21
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t201 = load double, double* %l23
  %t202 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l28
  %t204 = load double, double* %l29
  %t205 = load double, double* %l30
  %t206 = load double, double* %l31
  %t207 = load i8*, i8** %l32
  %t208 = load double, double* %l33
  %t209 = load double, double* %l34
  %t210 = load double, double* %l35
  br i1 %t177, label %then6, label %merge7
then6:
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s212 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.212, i32 0, i32 0
  %t213 = load i8*, i8** %l20
  %t214 = add i8* %s212, %t213
  %t215 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t211, i8* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t216 = phi { i8**, i64 }* [ %t215, %then6 ], [ %t178, %entry ]
  store { i8**, i64 }* %t216, { i8**, i64 }** %l0
  store i1 0, i1* %l36
  %t217 = alloca [0 x double]
  %t218 = getelementptr [0 x double], [0 x double]* %t217, i32 0, i32 0
  %t219 = alloca { double*, i64 }
  %t220 = getelementptr { double*, i64 }, { double*, i64 }* %t219, i32 0, i32 0
  store double* %t218, double** %t220
  %t221 = getelementptr { double*, i64 }, { double*, i64 }* %t219, i32 0, i32 1
  store i64 0, i64* %t221
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l37
  %t222 = load double, double* %l13
  store i1 0, i1* %l38
  %t223 = load double, double* %l13
  %t225 = load i1, i1* %l38
  br label %logical_or_entry_224

logical_or_entry_224:
  br i1 %t225, label %logical_or_merge_224, label %logical_or_right_224

logical_or_right_224:
  %t226 = load double, double* %l13
  %t227 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  store { %LocalBinding*, i64 }* %t227, { %LocalBinding*, i64 }** %l2
  %t228 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store { %ParameterBinding*, i64 }* %t228, { %ParameterBinding*, i64 }** %l39
  %t229 = load double, double* %l35
  %t230 = fcmp one double %t229, 0.0
  %t231 = xor i1 %t230, 1
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t234 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t235 = load double, double* %l3
  %t236 = load double, double* %l4
  %t237 = load double, double* %l5
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t239 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t240 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t241 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l9
  %t242 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l10
  %t243 = load double, double* %l11
  %t244 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l12
  %t245 = load double, double* %l13
  %t246 = load double, double* %l14
  %t247 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t248 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t249 = load i8*, i8** %l17
  %t250 = load i8*, i8** %l18
  %t251 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t252 = load i8*, i8** %l20
  %t253 = load i8*, i8** %l21
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t255 = load double, double* %l23
  %t256 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l28
  %t258 = load double, double* %l29
  %t259 = load double, double* %l30
  %t260 = load double, double* %l31
  %t261 = load i8*, i8** %l32
  %t262 = load double, double* %l33
  %t263 = load double, double* %l34
  %t264 = load double, double* %l35
  %t265 = load i1, i1* %l36
  %t266 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l37
  %t267 = load i1, i1* %l38
  %t268 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l39
  br i1 %t231, label %then8, label %merge9
then8:
  %t269 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l39
  %t270 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t271 = call { %ParameterBinding*, i64 }* @merge_parameter_bindings({ %ParameterBinding*, i64 }* %t269, { %ParameterBinding*, i64 }* %t270)
  store { %ParameterBinding*, i64 }* %t271, { %ParameterBinding*, i64 }** %l39
  br label %merge9
merge9:
  %t272 = phi { %ParameterBinding*, i64 }* [ %t271, %then8 ], [ %t268, %entry ]
  store { %ParameterBinding*, i64 }* %t272, { %ParameterBinding*, i64 }** %l39
  %t273 = load double, double* %l13
  ret %BlockLoweringResult zeroinitializer
}

define %LetLoweringResult @lower_let_instruction(i8* %function, i8* %instruction, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, { i8**, i64 }* %allocas, { i8**, i64 }* %lines, double %temp_index, double %next_local_id, double %next_region_id, { i8**, i64 }* %functions, %TypeContext %context, i8* %scope_id, double %scope_depth, i8* %current_label) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %LocalBinding*, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l9 = alloca { %LifetimeReleaseEvent*, i64 }*
  %l10 = alloca double
  %l11 = alloca { %LocalMutation*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca { %StringConstant*, i64 }*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca i8*
  %l22 = alloca %CoercionResult
  %l23 = alloca i8*
  %l24 = alloca double
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
  store i8* null, i8** %l5
  store i8* null, i8** %l6
  store i8* null, i8** %l7
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
  %t20 = load i8*, i8** %l7
  %t21 = icmp eq i8* %t20, null
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t26 = load double, double* %l4
  %t27 = load i8*, i8** %l5
  %t28 = load i8*, i8** %l6
  %t29 = load i8*, i8** %l7
  %t30 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t31 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l9
  %t32 = load double, double* %l10
  %t33 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  br i1 %t21, label %then0, label %merge1
then0:
  br label %merge1
merge1:
  %t34 = phi i8* [ null, %then0 ], [ %t29, %entry ]
  store i8* %t34, i8** %l7
  %t35 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t36 = load i8*, i8** %l7
  store double 0.0, double* %l12
  %t37 = load double, double* %l12
  %t38 = call double @diagnosticsconcat(double %t37)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double 0.0, double* %l13
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.39, i32 0, i32 0
  store i8* %s39, i8** %l14
  %t40 = load double, double* %l13
  store i8* null, i8** %l15
  %t41 = load i8*, i8** %l7
  %t42 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l16
  %t43 = load double, double* %l16
  %t44 = load double, double* %l16
  %t45 = load double, double* %l16
  %t46 = load i8*, i8** %l5
  %t47 = icmp ne i8* %t46, null
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t52 = load double, double* %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i8*, i8** %l6
  %t55 = load i8*, i8** %l7
  %t56 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t57 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l9
  %t58 = load double, double* %l10
  %t59 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t60 = load double, double* %l12
  %t61 = load double, double* %l13
  %t62 = load i8*, i8** %l14
  %t63 = load i8*, i8** %l15
  %t64 = load double, double* %l16
  br i1 %t47, label %then2, label %merge3
then2:
  %t65 = load i8*, i8** %l5
  %t66 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l17
  %t67 = load double, double* %l17
  %t68 = call double @diagnosticsconcat(double %t67)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l5
  br label %merge3
merge3:
  %t70 = phi { i8**, i64 }* [ null, %then2 ], [ %t48, %entry ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l6
  %t72 = icmp ne i8* %t71, null
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t77 = load double, double* %l4
  %t78 = load i8*, i8** %l5
  %t79 = load i8*, i8** %l6
  %t80 = load i8*, i8** %l7
  %t81 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t82 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l9
  %t83 = load double, double* %l10
  %t84 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t85 = load double, double* %l12
  %t86 = load double, double* %l13
  %t87 = load i8*, i8** %l14
  %t88 = load i8*, i8** %l15
  %t89 = load double, double* %l16
  br i1 %t72, label %then4, label %merge5
then4:
  %t90 = load i8*, i8** %l6
  br label %merge5
merge5:
  %t91 = alloca [0 x double]
  %t92 = getelementptr [0 x double], [0 x double]* %t91, i32 0, i32 0
  %t93 = alloca { double*, i64 }
  %t94 = getelementptr { double*, i64 }, { double*, i64 }* %t93, i32 0, i32 0
  store double* %t92, double** %t94
  %t95 = getelementptr { double*, i64 }, { double*, i64 }* %t93, i32 0, i32 1
  store i64 0, i64* %t95
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l18
  %t97 = load i8*, i8** %l14
  %t98 = load i8*, i8** %l14
  store double 0.0, double* %l19
  %t100 = load double, double* %l19
  %t101 = call i8* @format_local_pointer_name(double %next_local_id)
  store i8* %t101, i8** %l20
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s103 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.103, i32 0, i32 0
  %t104 = load i8*, i8** %l20
  %t105 = add i8* %s103, %t104
  %s106 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.106, i32 0, i32 0
  %t107 = add i8* %t105, %s106
  %t108 = load i8*, i8** %l14
  %t109 = add i8* %t107, %t108
  %t110 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t102, i8* %t109)
  store { i8**, i64 }* %t110, { i8**, i64 }** %l2
  %t111 = load i8*, i8** %l14
  %t112 = call i8* @default_return_literal(i8* %t111)
  store i8* %t112, i8** %l21
  %t113 = load i8*, i8** %l15
  %t114 = icmp ne i8* %t113, null
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t118 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t119 = load double, double* %l4
  %t120 = load i8*, i8** %l5
  %t121 = load i8*, i8** %l6
  %t122 = load i8*, i8** %l7
  %t123 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t124 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l9
  %t125 = load double, double* %l10
  %t126 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t127 = load double, double* %l12
  %t128 = load double, double* %l13
  %t129 = load i8*, i8** %l14
  %t130 = load i8*, i8** %l15
  %t131 = load double, double* %l16
  %t132 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l18
  %t133 = load double, double* %l19
  %t134 = load i8*, i8** %l20
  %t135 = load i8*, i8** %l21
  br i1 %t114, label %then6, label %else7
then6:
  %t136 = load i8*, i8** %l15
  %t137 = load i8*, i8** %l14
  %t138 = load double, double* %l4
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %t137, double %t138, { i8**, i64 }* %t139)
  store %CoercionResult %t140, %CoercionResult* %l22
  %t141 = load %CoercionResult, %CoercionResult* %l22
  %t142 = extractvalue %CoercionResult %t141, 3
  %t143 = call double @diagnosticsconcat({ i8**, i64 }* %t142)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t144 = load %CoercionResult, %CoercionResult* %l22
  %t145 = extractvalue %CoercionResult %t144, 0
  store { i8**, i64 }* %t145, { i8**, i64 }** %l1
  %t146 = load %CoercionResult, %CoercionResult* %l22
  %t147 = extractvalue %CoercionResult %t146, 1
  store double %t147, double* %l4
  %t148 = load %CoercionResult, %CoercionResult* %l22
  %t149 = extractvalue %CoercionResult %t148, 2
  %t150 = icmp eq i8* %t149, null
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t154 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t155 = load double, double* %l4
  %t156 = load i8*, i8** %l5
  %t157 = load i8*, i8** %l6
  %t158 = load i8*, i8** %l7
  %t159 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t160 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l9
  %t161 = load double, double* %l10
  %t162 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t163 = load double, double* %l12
  %t164 = load double, double* %l13
  %t165 = load i8*, i8** %l14
  %t166 = load i8*, i8** %l15
  %t167 = load double, double* %l16
  %t168 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l18
  %t169 = load double, double* %l19
  %t170 = load i8*, i8** %l20
  %t171 = load i8*, i8** %l21
  %t172 = load %CoercionResult, %CoercionResult* %l22
  br i1 %t150, label %then9, label %else10
then9:
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s174 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.174, i32 0, i32 0
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s176 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.176, i32 0, i32 0
  %t177 = load i8*, i8** %l14
  %t178 = add i8* %s176, %t177
  %s179 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.179, i32 0, i32 0
  %t180 = add i8* %t178, %s179
  %t181 = load i8*, i8** %l14
  %t182 = call i8* @default_return_literal(i8* %t181)
  %t183 = add i8* %t180, %t182
  br label %merge11
else10:
  %t184 = load %CoercionResult, %CoercionResult* %l22
  %t185 = extractvalue %CoercionResult %t184, 2
  store i8* %t185, i8** %l23
  %t186 = load i8*, i8** %l23
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s188 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.188, i32 0, i32 0
  %t189 = load i8*, i8** %l14
  %t190 = add i8* %s188, %t189
  %s191 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.191, i32 0, i32 0
  %t192 = add i8* %t190, %s191
  %t193 = load i8*, i8** %l23
  br label %merge11
merge11:
  %t194 = phi { i8**, i64 }* [ null, %then9 ], [ %t151, %else10 ]
  %t195 = phi { i8**, i64 }* [ null, %then9 ], [ null, %else10 ]
  %t196 = phi i8* [ %t171, %then9 ], [ null, %else10 ]
  store { i8**, i64 }* %t194, { i8**, i64 }** %l0
  store { i8**, i64 }* %t195, { i8**, i64 }** %l1
  store i8* %t196, i8** %l21
  br label %merge8
else7:
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s198 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.198, i32 0, i32 0
  %t199 = load i8*, i8** %l14
  %t200 = add i8* %s198, %t199
  %s201 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.201, i32 0, i32 0
  %t202 = add i8* %t200, %s201
  %t203 = load i8*, i8** %l14
  %t204 = call i8* @default_return_literal(i8* %t203)
  %t205 = add i8* %t202, %t204
  br label %merge8
merge8:
  %t206 = phi { i8**, i64 }* [ null, %then6 ], [ %t115, %else7 ]
  %t207 = phi { i8**, i64 }* [ %t145, %then6 ], [ null, %else7 ]
  %t208 = phi double [ %t147, %then6 ], [ %t119, %else7 ]
  %t209 = phi i8* [ null, %then6 ], [ %t135, %else7 ]
  store { i8**, i64 }* %t206, { i8**, i64 }** %l0
  store { i8**, i64 }* %t207, { i8**, i64 }** %l1
  store double %t208, double* %l4
  store i8* %t209, i8** %l21
  %t210 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t211 = insertvalue %LocalBinding undef, i8* null, 0
  %t212 = load i8*, i8** %l20
  %t213 = insertvalue %LocalBinding %t211, i8* %t212, 1
  %t214 = load i8*, i8** %l14
  %t215 = insertvalue %LocalBinding %t213, i8* %t214, 2
  %t216 = insertvalue %LocalBinding %t215, i8* null, 3
  %t217 = load i8*, i8** %l5
  %t218 = insertvalue %LocalBinding %t216, i8* %t217, 4
  %t219 = insertvalue %LocalBinding %t218, i1 0, 5
  %t220 = insertvalue %LocalBinding %t219, i8* %scope_id, 6
  %t221 = insertvalue %LocalBinding %t220, double %scope_depth, 7
  %t222 = call { %LocalBinding*, i64 }* @append_local_binding({ %LocalBinding*, i64 }* %t210, %LocalBinding %t221)
  store { %LocalBinding*, i64 }* %t222, { %LocalBinding*, i64 }** %l3
  store double 0.0, double* %l24
  %t223 = load double, double* %l24
  %t224 = alloca [1 x double]
  %t225 = getelementptr [1 x double], [1 x double]* %t224, i32 0, i32 0
  %t226 = getelementptr double, double* %t225, i64 0
  store double %t223, double* %t226
  %t227 = alloca { double*, i64 }
  %t228 = getelementptr { double*, i64 }, { double*, i64 }* %t227, i32 0, i32 0
  store double* %t225, double** %t228
  %t229 = getelementptr { double*, i64 }, { double*, i64 }* %t227, i32 0, i32 1
  store i64 1, i64* %t229
  %t230 = call double @mutationsconcat({ double*, i64 }* %t227)
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l11
  ret %LetLoweringResult zeroinitializer
}

define %ExpressionStatementResult @lower_expression_statement(i8* %function_name, i8* %instruction, i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %next_region_id, i8* %scope_id, double %scope_depth, { i8**, i64 }* %functions, %TypeContext %context, i8* %current_label) {
entry:
  %l0 = alloca i8*
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
  store i8* null, i8** %l0
  %t0 = load i8*, i8** %l0
  %t1 = call { i8**, i64 }* @detect_suspension_conflicts(i8* %expression, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, i8* %t0)
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
  %t25 = load i8*, i8** %l0
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
  %t70 = call %ExpressionResult @lower_expression(i8* %expression, { %ParameterBinding*, i64 }* %t66, { %LocalBinding*, i64 }* %t67, double %t68, { i8**, i64 }* %t69, { i8**, i64 }* %functions, %TypeContext %context)
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
  %l3 = alloca i8
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
  %t32 = phi double [ %t5, %entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l2
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l2
  %t10 = getelementptr i8, i8* %t8, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l3
  %t12 = load i8, i8* %l3
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8, i8* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l1
  %t17 = sitofp i64 0 to double
  %t18 = fcmp ogt double %t16, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  %t22 = load i8, i8* %l3
  br i1 %t18, label %then4, label %merge5
then4:
  %t23 = load double, double* %l2
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l2
  br label %loop.latch2
merge5:
  %t26 = load i8, i8* %l3
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch2
loop.latch2:
  %t31 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t33 = insertvalue %AssignmentParseResult undef, i1 0, 0
  %s34 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.34, i32 0, i32 0
  %t35 = insertvalue %AssignmentParseResult %t33, i8* %s34, 1
  %s36 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.36, i32 0, i32 0
  %t37 = insertvalue %AssignmentParseResult %t35, i8* %s36, 2
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.38, i32 0, i32 0
  %t39 = insertvalue %AssignmentParseResult %t37, i8* %s38, 3
  ret %AssignmentParseResult %t39
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
  %l7 = alloca i8
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i8*
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
  %t42 = phi i8* [ %t22, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t23, %entry ], [ %t41, %loop.latch2 ]
  store i8* %t42, i8** %l5
  store double %t43, double* %l6
  br label %loop.body1
loop.body1:
  %t24 = load double, double* %l6
  %t25 = load i8*, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = load double, double* %l6
  %t28 = getelementptr i8, i8* %t26, i64 %t27
  %t29 = load i8, i8* %t28
  store i8 %t29, i8* %l7
  %t33 = load i8, i8* %l7
  %s34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.34, i32 0, i32 0
  %t35 = load i8*, i8** %l5
  %t36 = load i8, i8* %l7
  %t37 = load double, double* %l6
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l6
  br label %loop.latch2
loop.latch2:
  %t40 = load i8*, i8** %l5
  %t41 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t44 = load i8*, i8** %l5
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l5
  %t46 = load i8*, i8** %l5
  %t47 = load i8*, i8** %l3
  %t48 = load double, double* %l6
  %t49 = load i8*, i8** %l3
  store i8* null, i8** %l8
  %s50 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.50, i32 0, i32 0
  store i8* %s50, i8** %l9
  store i8* null, i8** %l10
  %t51 = load i8*, i8** %l8
  %t52 = load i8*, i8** %l10
  %t53 = icmp eq i8* %t52, null
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load i8*, i8** %l3
  %t58 = load i1, i1* %l4
  %t59 = load i8*, i8** %l5
  %t60 = load double, double* %l6
  %t61 = load i8*, i8** %l8
  %t62 = load i8*, i8** %l9
  %t63 = load i8*, i8** %l10
  br i1 %t53, label %then4, label %merge5
then4:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s65 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.65, i32 0, i32 0
  %t66 = load i8*, i8** %l5
  %t67 = add i8* %s65, %t66
  %s68 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.68, i32 0, i32 0
  %t69 = add i8* %t67, %s68
  %t70 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t64, i8* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  %t71 = insertvalue %InlineLetParseResult undef, i1 0, 0
  %t72 = load i8*, i8** %l5
  %t73 = insertvalue %InlineLetParseResult %t71, i8* %t72, 1
  %t74 = load i1, i1* %l4
  %t75 = insertvalue %InlineLetParseResult %t73, i1 %t74, 2
  %t76 = load i8*, i8** %l9
  %t77 = insertvalue %InlineLetParseResult %t75, i8* %t76, 3
  %t78 = insertvalue %InlineLetParseResult %t77, i8* null, 4
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = insertvalue %InlineLetParseResult %t78, { i8**, i64 }* %t79, 5
  ret %InlineLetParseResult %t80
merge5:
  %t81 = insertvalue %InlineLetParseResult undef, i1 1, 0
  %t82 = load i8*, i8** %l5
  %t83 = insertvalue %InlineLetParseResult %t81, i8* %t82, 1
  %t84 = load i1, i1* %l4
  %t85 = insertvalue %InlineLetParseResult %t83, i1 %t84, 2
  %t86 = load i8*, i8** %l9
  %t87 = insertvalue %InlineLetParseResult %t85, i8* %t86, 3
  %t88 = load i8*, i8** %l10
  %t89 = insertvalue %InlineLetParseResult %t87, i8* %t88, 4
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = insertvalue %InlineLetParseResult %t89, { i8**, i64 }* %t90, 5
  ret %InlineLetParseResult %t91
}

define %ExpressionStatementResult @lower_return_instruction(i8* %function, i8* %instruction, i8* %llvm_return, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, double %next_region_id, i8* %scope_id, double %scope_depth, { i8**, i64 }* %functions, %TypeContext %context) {
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
  %t16 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t17 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store double 0.0, double* %l8
  %t18 = load double, double* %l8
  %t19 = call double @diagnosticsconcat(double %t18)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t20 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t21 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store double 0.0, double* %l9
  %t22 = load double, double* %l9
  %t23 = load double, double* %l9
  store double 0.0, double* %l10
  %t24 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t25 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t26 = load double, double* %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l11
  %t28 = load double, double* %l11
  %t29 = load double, double* %l11
  %t30 = load double, double* %l11
  %t31 = load double, double* %l11
  store double 0.0, double* %l12
  %t32 = load double, double* %l11
  %t33 = load double, double* %l11
  store double 0.0, double* %l13
  %s34 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.34, i32 0, i32 0
  %t35 = icmp eq i8* %llvm_return, %s34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l3
  %t40 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l4
  %t41 = load double, double* %l5
  %t42 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t43 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t44 = load double, double* %l8
  %t45 = load double, double* %l9
  %t46 = load double, double* %l10
  %t47 = load double, double* %l11
  %t48 = load double, double* %l12
  %t49 = load double, double* %l13
  br i1 %t35, label %then0, label %merge1
then0:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s51 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.51, i32 0, i32 0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s53 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.53, i32 0, i32 0
  %t54 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t52, i8* %s53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = insertvalue %ExpressionStatementResult undef, { i8**, i64 }* %t55, 0
  %t57 = load double, double* %l2
  %t58 = insertvalue %ExpressionStatementResult %t56, double %t57, 1
  %t59 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t60 = insertvalue %ExpressionStatementResult %t58, { i8**, i64 }* null, 2
  %t61 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t62 = insertvalue %ExpressionStatementResult %t60, { i8**, i64 }* null, 3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = insertvalue %ExpressionStatementResult %t62, { i8**, i64 }* %t63, 4
  %t65 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l3
  %t66 = insertvalue %ExpressionStatementResult %t64, { i8**, i64 }* null, 5
  %t67 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l4
  %t68 = insertvalue %ExpressionStatementResult %t66, { i8**, i64 }* null, 6
  %t69 = load double, double* %l5
  %t70 = insertvalue %ExpressionStatementResult %t68, double %t69, 7
  %t71 = alloca [0 x double]
  %t72 = getelementptr [0 x double], [0 x double]* %t71, i32 0, i32 0
  %t73 = alloca { double*, i64 }
  %t74 = getelementptr { double*, i64 }, { double*, i64 }* %t73, i32 0, i32 0
  store double* %t72, double** %t74
  %t75 = getelementptr { double*, i64 }, { double*, i64 }* %t73, i32 0, i32 1
  store i64 0, i64* %t75
  %t76 = insertvalue %ExpressionStatementResult %t70, { i8**, i64 }* null, 8
  %t77 = load double, double* %l12
  %t78 = insertvalue %ExpressionStatementResult %t76, { i8**, i64 }* null, 9
  ret %ExpressionStatementResult %t78
merge1:
  %t79 = load double, double* %l13
  %t80 = load double, double* %l2
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %llvm_return, double %t80, { i8**, i64 }* %t81)
  store %CoercionResult %t82, %CoercionResult* %l14
  %t83 = load %CoercionResult, %CoercionResult* %l14
  %t84 = extractvalue %CoercionResult %t83, 3
  %t85 = call double @diagnosticsconcat({ i8**, i64 }* %t84)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t86 = load %CoercionResult, %CoercionResult* %l14
  %t87 = extractvalue %CoercionResult %t86, 0
  store { i8**, i64 }* %t87, { i8**, i64 }** %l1
  %t88 = load %CoercionResult, %CoercionResult* %l14
  %t89 = extractvalue %CoercionResult %t88, 1
  store double %t89, double* %l2
  %t90 = load %CoercionResult, %CoercionResult* %l14
  %t91 = extractvalue %CoercionResult %t90, 2
  %t92 = icmp eq i8* %t91, null
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load double, double* %l2
  %t96 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l3
  %t97 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l4
  %t98 = load double, double* %l5
  %t99 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t100 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t101 = load double, double* %l8
  %t102 = load double, double* %l9
  %t103 = load double, double* %l10
  %t104 = load double, double* %l11
  %t105 = load double, double* %l12
  %t106 = load double, double* %l13
  %t107 = load %CoercionResult, %CoercionResult* %l14
  br i1 %t92, label %then2, label %merge3
then2:
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s109 = getelementptr inbounds [55 x i8], [55 x i8]* @.str.109, i32 0, i32 0
  %t110 = add i8* %s109, %llvm_return
  %s111 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.111, i32 0, i32 0
  %t112 = add i8* %t110, %s111
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s114 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.114, i32 0, i32 0
  %t115 = add i8* %s114, %llvm_return
  %s116 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.116, i32 0, i32 0
  %t117 = add i8* %t115, %s116
  %t118 = call i8* @default_return_literal(i8* %llvm_return)
  %t119 = add i8* %t117, %t118
  %t120 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t113, i8* %t119)
  store { i8**, i64 }* %t120, { i8**, i64 }** %l1
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = insertvalue %ExpressionStatementResult undef, { i8**, i64 }* %t121, 0
  %t123 = load double, double* %l2
  %t124 = insertvalue %ExpressionStatementResult %t122, double %t123, 1
  %t125 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t126 = insertvalue %ExpressionStatementResult %t124, { i8**, i64 }* null, 2
  %t127 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t128 = insertvalue %ExpressionStatementResult %t126, { i8**, i64 }* null, 3
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = insertvalue %ExpressionStatementResult %t128, { i8**, i64 }* %t129, 4
  %t131 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l3
  %t132 = insertvalue %ExpressionStatementResult %t130, { i8**, i64 }* null, 5
  %t133 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l4
  %t134 = insertvalue %ExpressionStatementResult %t132, { i8**, i64 }* null, 6
  %t135 = load double, double* %l5
  %t136 = insertvalue %ExpressionStatementResult %t134, double %t135, 7
  %t137 = alloca [0 x double]
  %t138 = getelementptr [0 x double], [0 x double]* %t137, i32 0, i32 0
  %t139 = alloca { double*, i64 }
  %t140 = getelementptr { double*, i64 }, { double*, i64 }* %t139, i32 0, i32 0
  store double* %t138, double** %t140
  %t141 = getelementptr { double*, i64 }, { double*, i64 }* %t139, i32 0, i32 1
  store i64 0, i64* %t141
  %t142 = insertvalue %ExpressionStatementResult %t136, { i8**, i64 }* null, 8
  %t143 = load double, double* %l12
  %t144 = insertvalue %ExpressionStatementResult %t142, { i8**, i64 }* null, 9
  ret %ExpressionStatementResult %t144
merge3:
  %t145 = load %CoercionResult, %CoercionResult* %l14
  %t146 = extractvalue %CoercionResult %t145, 2
  store i8* %t146, i8** %l15
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s148 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.148, i32 0, i32 0
  %t149 = load i8*, i8** %l15
  %t150 = load double, double* %l10
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = insertvalue %ExpressionStatementResult undef, { i8**, i64 }* %t151, 0
  %t153 = load double, double* %l2
  %t154 = insertvalue %ExpressionStatementResult %t152, double %t153, 1
  %t155 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l6
  %t156 = insertvalue %ExpressionStatementResult %t154, { i8**, i64 }* null, 2
  %t157 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t158 = insertvalue %ExpressionStatementResult %t156, { i8**, i64 }* null, 3
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = insertvalue %ExpressionStatementResult %t158, { i8**, i64 }* %t159, 4
  %t161 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l3
  %t162 = insertvalue %ExpressionStatementResult %t160, { i8**, i64 }* null, 5
  %t163 = load { %LifetimeReleaseEvent*, i64 }*, { %LifetimeReleaseEvent*, i64 }** %l4
  %t164 = insertvalue %ExpressionStatementResult %t162, { i8**, i64 }* null, 6
  %t165 = load double, double* %l5
  %t166 = insertvalue %ExpressionStatementResult %t164, double %t165, 7
  %t167 = alloca [0 x double]
  %t168 = getelementptr [0 x double], [0 x double]* %t167, i32 0, i32 0
  %t169 = alloca { double*, i64 }
  %t170 = getelementptr { double*, i64 }, { double*, i64 }* %t169, i32 0, i32 0
  store double* %t168, double** %t170
  %t171 = getelementptr { double*, i64 }, { double*, i64 }* %t169, i32 0, i32 1
  store i64 0, i64* %t171
  %t172 = insertvalue %ExpressionStatementResult %t166, { i8**, i64 }* null, 8
  %t173 = load double, double* %l12
  %t174 = insertvalue %ExpressionStatementResult %t172, { i8**, i64 }* null, 9
  ret %ExpressionStatementResult %t174
}

define %ParameterPreparation @prepare_parameters(i8* %function, %TypeContext %context) {
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
  %t38 = phi { i8**, i64 }* [ %t16, %entry ], [ %t35, %loop.latch2 ]
  %t39 = phi { %ParameterBinding*, i64 }* [ %t17, %entry ], [ %t36, %loop.latch2 ]
  %t40 = phi double [ %t19, %entry ], [ %t37, %loop.latch2 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store { %ParameterBinding*, i64 }* %t39, { %ParameterBinding*, i64 }** %l1
  store double %t40, double* %l3
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l3
  store double 0.0, double* %l4
  %t21 = load double, double* %l4
  store double 0.0, double* %l5
  %t24 = load double, double* %l4
  %t25 = load double, double* %l4
  %t26 = load double, double* %l4
  store double 0.0, double* %l6
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = load double, double* %l6
  store double 0.0, double* %l7
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l5
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = load double, double* %l3
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l3
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l1
  %t37 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = insertvalue %ParameterPreparation undef, { i8**, i64 }* %t41, 0
  %t43 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l1
  %t44 = insertvalue %ParameterPreparation %t42, { i8**, i64 }* null, 1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = insertvalue %ParameterPreparation %t44, { i8**, i64 }* %t45, 2
  ret %ParameterPreparation %t46
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
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t4, %entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = extractvalue %TypeContext %context, 1
  %t7 = load { i8**, i64 }, { i8**, i64 }* %t6
  %t8 = extractvalue { i8**, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = extractvalue %TypeContext %context, 1
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t13
  %t16 = extractvalue { i8**, i64 } %t15, 0
  %t17 = extractvalue { i8**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr i8*, i8** %t16, i64 %t14
  %t20 = load i8*, i8** %t19
  store i8* %t20, i8** %l2
  %t21 = load i8*, i8** %l2
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %s27 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.27, i32 0, i32 0
  ret i8* %s27
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
  %t1 = icmp eq i8* %annotation, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s4 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %annotation, %s4
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s6 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %annotation, %s6
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t8 = phi i1 [ true, %logical_or_entry_3 ], [ %t7, %logical_or_right_end_3 ]
  br i1 %t8, label %then2, label %merge3
then2:
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
merge3:
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %annotation, %s11
  br label %logical_or_entry_10

logical_or_entry_10:
  br i1 %t12, label %logical_or_merge_10, label %logical_or_right_10

logical_or_right_10:
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  %t14 = icmp eq i8* %annotation, %s13
  br label %logical_or_right_end_10

logical_or_right_end_10:
  br label %logical_or_merge_10

logical_or_merge_10:
  %t15 = phi i1 [ true, %logical_or_entry_10 ], [ %t14, %logical_or_right_end_10 ]
  br i1 %t15, label %then4, label %merge5
then4:
  %s16 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.16, i32 0, i32 0
  ret i8* %s16
merge5:
  %s17 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.17, i32 0, i32 0
  %t18 = icmp eq i8* %annotation, %s17
  br i1 %t18, label %then6, label %merge7
then6:
  %s19 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.19, i32 0, i32 0
  ret i8* %s19
merge7:
  %t20 = call i8* @map_struct_type_annotation(%TypeContext %context, i8* %annotation)
  store i8* %t20, i8** %l0
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @map_enum_type_annotation(%TypeContext %context, i8* %annotation)
  store i8* %t22, i8** %l1
  %t23 = load i8*, i8** %l1
  %t24 = call i8* @map_interface_type_annotation(%TypeContext %context, i8* %annotation)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %s26 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.26, i32 0, i32 0
  %t27 = icmp eq i8* %annotation, %s26
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then8, label %merge9
then8:
  ret i8* null
merge9:
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.31, i32 0, i32 0
  ret i8* %s31
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
  %t4 = call i1 @starts_with(i8* %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  ret i8* %s7
merge1:
  %t8 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  store i8* null, i8** %l1
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i1 @starts_with(i8* %t12, i8* %s13)
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  br i1 %t14, label %then2, label %merge3
then2:
  %t17 = load i8*, i8** %l1
  %t18 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t19 = load double, double* %l2
  %t20 = call i8* @trim_text(i8* null)
  store i8* %t20, i8** %l1
  br label %merge3
merge3:
  %t21 = phi i8* [ %t20, %then2 ], [ %t16, %entry ]
  store i8* %t21, i8** %l1
  %t22 = load i8*, i8** %l1
  %t23 = load i8*, i8** %l1
  %t24 = getelementptr i8, i8* %t23, i64 0
  %t25 = load i8, i8* %t24
  %s26 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.26, i32 0, i32 0
  %t27 = load i8*, i8** %l1
  %t28 = call i8* @map_reference_inner_type(%TypeContext %context, i8* %t27)
  store i8* %t28, i8** %l3
  %t29 = load i8*, i8** %l3
  %t30 = load i8*, i8** %l3
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
  %t7 = load double, double* %l1
  store double 0.0, double* %l2
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l3
  %t11 = sitofp i64 0 to double
  %t12 = fcmp olt double %t10, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  br i1 %t12, label %then0, label %merge1
then0:
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.17, i32 0, i32 0
  ret i8* %s17
merge1:
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = call double @substring(double %t18, i64 0, double %t19)
  %t21 = call i8* @trim_text(i8* null)
  store i8* %t21, i8** %l4
  %t22 = load i8*, i8** %l4
  %t23 = load i8*, i8** %l4
  %t24 = load i8*, i8** %l4
  store double 0.0, double* %l5
  %t25 = load double, double* %l5
  %t26 = load double, double* %l5
  ret i8* null
}

define i8* @unwrap_move_wrapper(i8* %annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  ret i8* %t4
}

define i1 @contains_keyword_outside_strings(i8* %value, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i8
  %l5 = alloca double
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
  %t91 = phi i1 [ %t4, %entry ], [ %t89, %loop.latch2 ]
  %t92 = phi double [ %t1, %entry ], [ %t90, %loop.latch2 ]
  store i1 %t91, i1* %l3
  store double %t92, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l4
  %t9 = load i1, i1* %l1
  %t10 = load double, double* %l0
  %t11 = load i1, i1* %l1
  %t12 = load i1, i1* %l2
  %t13 = load i1, i1* %l3
  %t14 = load i8, i8* %l4
  br i1 %t9, label %then4, label %merge5
then4:
  %t15 = load i1, i1* %l3
  %t16 = load double, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load i1, i1* %l2
  %t19 = load i1, i1* %l3
  %t20 = load i8, i8* %l4
  br i1 %t15, label %then6, label %else7
then6:
  store i1 0, i1* %l3
  br label %merge8
else7:
  %t21 = load i8, i8* %l4
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  br label %merge8
merge8:
  %t23 = phi i1 [ 0, %then6 ], [ %t19, %else7 ]
  store i1 %t23, i1* %l3
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
merge5:
  %t27 = load i1, i1* %l2
  %t28 = load double, double* %l0
  %t29 = load i1, i1* %l1
  %t30 = load i1, i1* %l2
  %t31 = load i1, i1* %l3
  %t32 = load i8, i8* %l4
  br i1 %t27, label %then9, label %merge10
then9:
  %t33 = load i1, i1* %l3
  %t34 = load double, double* %l0
  %t35 = load i1, i1* %l1
  %t36 = load i1, i1* %l2
  %t37 = load i1, i1* %l3
  %t38 = load i8, i8* %l4
  br i1 %t33, label %then11, label %else12
then11:
  store i1 0, i1* %l3
  br label %merge13
else12:
  %t39 = load i8, i8* %l4
  %s40 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.40, i32 0, i32 0
  br label %merge13
merge13:
  %t41 = phi i1 [ 0, %then11 ], [ %t37, %else12 ]
  store i1 %t41, i1* %l3
  %t42 = load double, double* %l0
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l0
  br label %loop.latch2
merge10:
  %t45 = load i8, i8* %l4
  %s46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.46, i32 0, i32 0
  %t47 = load i8, i8* %l4
  %s48 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.48, i32 0, i32 0
  %t49 = load i8, i8* %l4
  %t50 = getelementptr i8, i8* %keyword, i64 0
  %t51 = load i8, i8* %t50
  %t52 = icmp eq i8 %t49, %t51
  %t53 = load double, double* %l0
  %t54 = load i1, i1* %l1
  %t55 = load i1, i1* %l2
  %t56 = load i1, i1* %l3
  %t57 = load i8, i8* %l4
  br i1 %t52, label %then14, label %merge15
then14:
  %t58 = load double, double* %l0
  %t59 = sitofp i64 0 to double
  %t60 = fcmp ogt double %t58, %t59
  %t61 = load double, double* %l0
  %t62 = load i1, i1* %l1
  %t63 = load i1, i1* %l2
  %t64 = load i1, i1* %l3
  %t65 = load i8, i8* %l4
  br i1 %t60, label %then16, label %merge17
then16:
  store double 0.0, double* %l5
  %t66 = load double, double* %l5
  %t67 = call i1 @is_identifier_part_char(i8* null)
  %t68 = load double, double* %l0
  %t69 = load i1, i1* %l1
  %t70 = load i1, i1* %l2
  %t71 = load i1, i1* %l3
  %t72 = load i8, i8* %l4
  %t73 = load double, double* %l5
  br i1 %t67, label %then18, label %merge19
then18:
  %t74 = load double, double* %l0
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l0
  br label %loop.latch2
merge19:
  br label %merge17
merge17:
  %t77 = phi double [ %t76, %then16 ], [ %t61, %then14 ]
  store double %t77, double* %l0
  %t78 = load double, double* %l0
  %t79 = call i1 @matches_keyword(i8* %value, double %t78, i8* %keyword)
  %t80 = load double, double* %l0
  %t81 = load i1, i1* %l1
  %t82 = load i1, i1* %l2
  %t83 = load i1, i1* %l3
  %t84 = load i8, i8* %l4
  br i1 %t79, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  br label %merge15
merge15:
  %t85 = phi double [ %t76, %then14 ], [ %t53, %loop.body1 ]
  store double %t85, double* %l0
  %t86 = load double, double* %l0
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l0
  br label %loop.latch2
loop.latch2:
  %t89 = load i1, i1* %l3
  %t90 = load double, double* %l0
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
  %t6 = getelementptr i8, i8* %t5, i64 0
  %t7 = load i8, i8* %t6
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l1
  store double 0.0, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i1 @starts_with(i8* null, i8* %s13)
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  ret i1 0
}

define { i8**, i64 }* @collect_suspension_conflicts(i8* %keyword, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, i8* %suspension_span) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %LocalBinding
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %ParameterBinding
  %l6 = alloca i8*
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
  %t41 = phi double [ %t7, %entry ], [ %t40, %loop.latch2 ]
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t10 = extractvalue { %LocalBinding*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t17 = extractvalue { %LocalBinding*, i64 } %t16, 0
  %t18 = extractvalue { %LocalBinding*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %LocalBinding, %LocalBinding* %t17, i64 %t15
  %t21 = load %LocalBinding, %LocalBinding* %t20
  store %LocalBinding %t21, %LocalBinding* %l2
  %t23 = load %LocalBinding, %LocalBinding* %l2
  %t24 = extractvalue %LocalBinding %t23, 5
  br label %logical_and_entry_22

logical_and_entry_22:
  br i1 %t24, label %logical_and_right_22, label %logical_and_merge_22

logical_and_right_22:
  %t25 = load %LocalBinding, %LocalBinding* %l2
  %t26 = extractvalue %LocalBinding %t25, 4
  %t27 = icmp ne i8* %t26, null
  br label %logical_and_right_end_22

logical_and_right_end_22:
  br label %logical_and_merge_22

logical_and_merge_22:
  %t28 = phi i1 [ false, %logical_and_entry_22 ], [ %t27, %logical_and_right_end_22 ]
  %t29 = xor i1 %t28, 1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t29, label %then6, label %merge7
then6:
  %t33 = load %LocalBinding, %LocalBinding* %l2
  %t34 = extractvalue %LocalBinding %t33, 4
  store i8* %t34, i8** %l3
  %t36 = load i8*, i8** %l3
  br label %merge7
merge7:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l4
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t101 = phi { i8**, i64 }* [ %t43, %entry ], [ %t99, %loop.latch10 ]
  %t102 = phi double [ %t45, %entry ], [ %t100, %loop.latch10 ]
  store { i8**, i64 }* %t101, { i8**, i64 }** %l0
  store double %t102, double* %l4
  br label %loop.body9
loop.body9:
  %t46 = load double, double* %l4
  %t47 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %bindings
  %t48 = extractvalue { %ParameterBinding*, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t46, %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l4
  br i1 %t50, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t54 = load double, double* %l4
  %t55 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %bindings
  %t56 = extractvalue { %ParameterBinding*, i64 } %t55, 0
  %t57 = extractvalue { %ParameterBinding*, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  %t59 = getelementptr %ParameterBinding, %ParameterBinding* %t56, i64 %t54
  %t60 = load %ParameterBinding, %ParameterBinding* %t59
  store %ParameterBinding %t60, %ParameterBinding* %l5
  %t61 = load %ParameterBinding, %ParameterBinding* %l5
  %t62 = extractvalue %ParameterBinding %t61, 4
  %t63 = xor i1 %t62, 1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = load double, double* %l4
  %t67 = load %ParameterBinding, %ParameterBinding* %l5
  br i1 %t63, label %then14, label %merge15
then14:
  %t68 = load %ParameterBinding, %ParameterBinding* %l5
  %t69 = extractvalue %ParameterBinding %t68, 3
  %t70 = call i1 @is_mutable_borrow_annotation(i8* %t69)
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load double, double* %l1
  %t73 = load double, double* %l4
  %t74 = load %ParameterBinding, %ParameterBinding* %l5
  br i1 %t70, label %then16, label %merge17
then16:
  %t75 = load %ParameterBinding, %ParameterBinding* %l5
  %t76 = extractvalue %ParameterBinding %t75, 5
  %t77 = call i8* @format_suspension_location(i8* %keyword, i8* %t76, i8* %suspension_span)
  store i8* %t77, i8** %l6
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s79 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.79, i32 0, i32 0
  %t80 = add i8* %s79, %keyword
  %s81 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.81, i32 0, i32 0
  %t82 = add i8* %t80, %s81
  %t83 = load %ParameterBinding, %ParameterBinding* %l5
  %t84 = extractvalue %ParameterBinding %t83, 0
  %t85 = add i8* %t82, %t84
  %s86 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.86, i32 0, i32 0
  %t87 = add i8* %t85, %s86
  %t88 = add i8* %t87, %function_name
  %s89 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.89, i32 0, i32 0
  %t90 = add i8* %t88, %s89
  %t91 = load i8*, i8** %l6
  %t92 = add i8* %t90, %t91
  %t93 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t78, i8* %t92)
  store { i8**, i64 }* %t93, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t94 = phi { i8**, i64 }* [ %t93, %then16 ], [ %t71, %then14 ]
  store { i8**, i64 }* %t94, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t95 = phi { i8**, i64 }* [ %t93, %then14 ], [ %t64, %loop.body9 ]
  store { i8**, i64 }* %t95, { i8**, i64 }** %l0
  %t96 = load double, double* %l4
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  store double %t98, double* %l4
  br label %loop.latch10
loop.latch10:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t103
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
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  ret i8* %t7
}

define { i8**, i64 }* @detect_suspension_conflicts(i8* %expression, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, i8* %suspension_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = icmp eq i8* %expression, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  ret { i8**, i64 }* null
merge1:
  %t6 = call i8* @trim_text(i8* %expression)
  store i8* %t6, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @find_suspension_keyword(i8* %t8)
  store i8* %t9, i8** %l1
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = call { i8**, i64 }* @collect_suspension_conflicts(i8* %t11, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings, i8* %function_name, i8* %suspension_span)
  ret { i8**, i64 }* %t12
}

define i8* @map_return_type(%TypeContext %context, i8* %return_type) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i8* @trim_text(i8* %return_type)
  store i8* %t0, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @unwrap_move_wrapper(i8* %t3)
  store i8* %t4, i8** %l1
  %t5 = load i8*, i8** %l1
  %t6 = call i8* @map_reference_type(%TypeContext %context, i8* %t5)
  store i8* %t6, i8** %l2
  %t7 = load i8*, i8** %l2
  %t8 = load i8*, i8** %l1
  %t9 = call i8* @map_array_pointer_type(%TypeContext %context, i8* %t8)
  store i8* %t9, i8** %l3
  %t10 = load i8*, i8** %l3
  %t11 = load i8*, i8** %l1
  %t12 = call i8* @map_primitive_type(%TypeContext %context, i8* %t11)
  ret i8* %t12
}

define i8* @map_parameter_type(%TypeContext %context, i8* %parameter_type) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  store i8* %t11, i8** %l4
  %t12 = load i8*, i8** %l4
  ret i8* null
}

define i8* @map_local_type(%TypeContext %context, i8* %type_annotation) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  store i8* %t11, i8** %l4
  %t12 = load i8*, i8** %l4
  ret i8* null
}

define { %ParameterBinding*, i64 }* @mark_parameter_consumed({ %ParameterBinding*, i64 }* %bindings, i8* %name) {
entry:
  %l0 = alloca { %ParameterBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca %ParameterBinding
  %l3 = alloca double
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
  %t50 = phi { %ParameterBinding*, i64 }* [ %t6, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t7, %entry ], [ %t49, %loop.latch2 ]
  store { %ParameterBinding*, i64 }* %t50, { %ParameterBinding*, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %bindings
  %t10 = extractvalue { %ParameterBinding*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %bindings
  %t17 = extractvalue { %ParameterBinding*, i64 } %t16, 0
  %t18 = extractvalue { %ParameterBinding*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ParameterBinding, %ParameterBinding* %t17, i64 %t15
  %t21 = load %ParameterBinding, %ParameterBinding* %t20
  store %ParameterBinding %t21, %ParameterBinding* %l2
  %t22 = load %ParameterBinding, %ParameterBinding* %l2
  %t23 = extractvalue %ParameterBinding %t22, 0
  %t24 = icmp eq i8* %t23, %name
  %t25 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %ParameterBinding, %ParameterBinding* %l2
  br i1 %t24, label %then6, label %else7
then6:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = alloca [1 x double]
  %t30 = getelementptr [1 x double], [1 x double]* %t29, i32 0, i32 0
  %t31 = getelementptr double, double* %t30, i64 0
  store double %t28, double* %t31
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t30, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @resultconcat({ double*, i64 }* %t32)
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l0
  br label %merge8
else7:
  %t36 = load %ParameterBinding, %ParameterBinding* %l2
  %t37 = alloca [1 x %ParameterBinding]
  %t38 = getelementptr [1 x %ParameterBinding], [1 x %ParameterBinding]* %t37, i32 0, i32 0
  %t39 = getelementptr %ParameterBinding, %ParameterBinding* %t38, i64 0
  store %ParameterBinding %t36, %ParameterBinding* %t39
  %t40 = alloca { %ParameterBinding*, i64 }
  %t41 = getelementptr { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %t40, i32 0, i32 0
  store %ParameterBinding* %t38, %ParameterBinding** %t41
  %t42 = getelementptr { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = call double @resultconcat({ %ParameterBinding*, i64 }* %t40)
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l0
  br label %merge8
merge8:
  %t44 = phi { %ParameterBinding*, i64 }* [ null, %then6 ], [ null, %else7 ]
  store { %ParameterBinding*, i64 }* %t44, { %ParameterBinding*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  ret { %ParameterBinding*, i64 }* %t52
}

define { %LocalBinding*, i64 }* @mark_local_consumed({ %LocalBinding*, i64 }* %locals, i8* %name) {
entry:
  %l0 = alloca { %LocalBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca %LocalBinding
  %l3 = alloca double
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
  %t50 = phi { %LocalBinding*, i64 }* [ %t6, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t7, %entry ], [ %t49, %loop.latch2 ]
  store { %LocalBinding*, i64 }* %t50, { %LocalBinding*, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t10 = extractvalue { %LocalBinding*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t17 = extractvalue { %LocalBinding*, i64 } %t16, 0
  %t18 = extractvalue { %LocalBinding*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %LocalBinding, %LocalBinding* %t17, i64 %t15
  %t21 = load %LocalBinding, %LocalBinding* %t20
  store %LocalBinding %t21, %LocalBinding* %l2
  %t22 = load %LocalBinding, %LocalBinding* %l2
  %t23 = extractvalue %LocalBinding %t22, 0
  %t24 = icmp eq i8* %t23, %name
  %t25 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t24, label %then6, label %else7
then6:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = alloca [1 x double]
  %t30 = getelementptr [1 x double], [1 x double]* %t29, i32 0, i32 0
  %t31 = getelementptr double, double* %t30, i64 0
  store double %t28, double* %t31
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t30, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @resultconcat({ double*, i64 }* %t32)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge8
else7:
  %t36 = load %LocalBinding, %LocalBinding* %l2
  %t37 = alloca [1 x %LocalBinding]
  %t38 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t37, i32 0, i32 0
  %t39 = getelementptr %LocalBinding, %LocalBinding* %t38, i64 0
  store %LocalBinding %t36, %LocalBinding* %t39
  %t40 = alloca { %LocalBinding*, i64 }
  %t41 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t40, i32 0, i32 0
  store %LocalBinding* %t38, %LocalBinding** %t41
  %t42 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = call double @resultconcat({ %LocalBinding*, i64 }* %t40)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge8
merge8:
  %t44 = phi { %LocalBinding*, i64 }* [ null, %then6 ], [ null, %else7 ]
  store { %LocalBinding*, i64 }* %t44, { %LocalBinding*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t52
}

define { %LocalBinding*, i64 }* @reset_local_consumption({ %LocalBinding*, i64 }* %locals, i8* %name) {
entry:
  %l0 = alloca { %LocalBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca %LocalBinding
  %l3 = alloca double
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
  %t50 = phi { %LocalBinding*, i64 }* [ %t6, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t7, %entry ], [ %t49, %loop.latch2 ]
  store { %LocalBinding*, i64 }* %t50, { %LocalBinding*, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t10 = extractvalue { %LocalBinding*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t17 = extractvalue { %LocalBinding*, i64 } %t16, 0
  %t18 = extractvalue { %LocalBinding*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %LocalBinding, %LocalBinding* %t17, i64 %t15
  %t21 = load %LocalBinding, %LocalBinding* %t20
  store %LocalBinding %t21, %LocalBinding* %l2
  %t22 = load %LocalBinding, %LocalBinding* %l2
  %t23 = extractvalue %LocalBinding %t22, 0
  %t24 = icmp eq i8* %t23, %name
  %t25 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t24, label %then6, label %else7
then6:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = alloca [1 x double]
  %t30 = getelementptr [1 x double], [1 x double]* %t29, i32 0, i32 0
  %t31 = getelementptr double, double* %t30, i64 0
  store double %t28, double* %t31
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t30, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @resultconcat({ double*, i64 }* %t32)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge8
else7:
  %t36 = load %LocalBinding, %LocalBinding* %l2
  %t37 = alloca [1 x %LocalBinding]
  %t38 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t37, i32 0, i32 0
  %t39 = getelementptr %LocalBinding, %LocalBinding* %t38, i64 0
  store %LocalBinding %t36, %LocalBinding* %t39
  %t40 = alloca { %LocalBinding*, i64 }
  %t41 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t40, i32 0, i32 0
  store %LocalBinding* %t38, %LocalBinding** %t41
  %t42 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = call double @resultconcat({ %LocalBinding*, i64 }* %t40)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge8
merge8:
  %t44 = phi { %LocalBinding*, i64 }* [ null, %then6 ], [ null, %else7 ]
  store { %LocalBinding*, i64 }* %t44, { %LocalBinding*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t52
}

define { %LocalBinding*, i64 }* @update_local_ownership({ %LocalBinding*, i64 }* %locals, i8* %name, i8* %ownership) {
entry:
  %l0 = alloca { %LocalBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca %LocalBinding
  %l3 = alloca double
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
  %t50 = phi { %LocalBinding*, i64 }* [ %t6, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t7, %entry ], [ %t49, %loop.latch2 ]
  store { %LocalBinding*, i64 }* %t50, { %LocalBinding*, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t10 = extractvalue { %LocalBinding*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t17 = extractvalue { %LocalBinding*, i64 } %t16, 0
  %t18 = extractvalue { %LocalBinding*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %LocalBinding, %LocalBinding* %t17, i64 %t15
  %t21 = load %LocalBinding, %LocalBinding* %t20
  store %LocalBinding %t21, %LocalBinding* %l2
  %t22 = load %LocalBinding, %LocalBinding* %l2
  %t23 = extractvalue %LocalBinding %t22, 0
  %t24 = icmp eq i8* %t23, %name
  %t25 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t24, label %then6, label %else7
then6:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = alloca [1 x double]
  %t30 = getelementptr [1 x double], [1 x double]* %t29, i32 0, i32 0
  %t31 = getelementptr double, double* %t30, i64 0
  store double %t28, double* %t31
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t30, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = call double @resultconcat({ double*, i64 }* %t32)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge8
else7:
  %t36 = load %LocalBinding, %LocalBinding* %l2
  %t37 = alloca [1 x %LocalBinding]
  %t38 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t37, i32 0, i32 0
  %t39 = getelementptr %LocalBinding, %LocalBinding* %t38, i64 0
  store %LocalBinding %t36, %LocalBinding* %t39
  %t40 = alloca { %LocalBinding*, i64 }
  %t41 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t40, i32 0, i32 0
  store %LocalBinding* %t38, %LocalBinding** %t41
  %t42 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t40, i32 0, i32 1
  store i64 1, i64* %t42
  %t43 = call double @resultconcat({ %LocalBinding*, i64 }* %t40)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge8
merge8:
  %t44 = phi { %LocalBinding*, i64 }* [ null, %then6 ], [ null, %else7 ]
  store { %LocalBinding*, i64 }* %t44, { %LocalBinding*, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t52
}

define %ExpressionResult @lower_expression(i8* %expression, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca %TernaryParseResult
  %l4 = alloca %BorrowParseResult
  %l5 = alloca %OperatorMatch
  %l6 = alloca %OperatorMatch
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca %EnumLiteralParse
  %l11 = alloca double
  %l12 = alloca %StructLiteralParse
  %l13 = alloca %ExpressionResult
  %l14 = alloca double
  %l15 = alloca %IndexExpressionParse
  %l16 = alloca %MemberAccessParse
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca i8*
  %l20 = alloca i8*
  %l21 = alloca %LLVMOperand
  %l22 = alloca double
  %l23 = alloca %LLVMOperand
  %l24 = alloca i8*
  %l25 = alloca %LLVMOperand
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
  %t11 = icmp ne i8* %t9, %t10
  %t12 = load i8*, i8** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t14 = load i8*, i8** %l2
  br i1 %t11, label %then0, label %merge1
then0:
  %t15 = load i8*, i8** %l2
  %t16 = call %ExpressionResult @lower_expression(i8* %t15, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  ret %ExpressionResult %t16
merge1:
  %t17 = load i8*, i8** %l2
  %t18 = call %TernaryParseResult @parse_ternary_expression(i8* %t17)
  store %TernaryParseResult %t18, %TernaryParseResult* %l3
  %t19 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t20 = extractvalue %TernaryParseResult %t19, 0
  %t21 = load i8*, i8** %l0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t23 = load i8*, i8** %l2
  %t24 = load %TernaryParseResult, %TernaryParseResult* %l3
  br i1 %t20, label %then2, label %merge3
then2:
  %t25 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t26 = call %ExpressionResult @lower_ternary_expression(%TernaryParseResult %t25, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  ret %ExpressionResult %t26
merge3:
  %t27 = load i8*, i8** %l2
  %t28 = call %BorrowParseResult @parse_borrow_expression(i8* %t27)
  store %BorrowParseResult %t28, %BorrowParseResult* %l4
  %t29 = load i8*, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = call %OperatorMatch @find_logical_operator(i8* %t30)
  store %OperatorMatch %t31, %OperatorMatch* %l5
  %t32 = load %OperatorMatch, %OperatorMatch* %l5
  %t33 = extractvalue %OperatorMatch %t32, 2
  %t34 = load i8*, i8** %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load i8*, i8** %l2
  %t37 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t38 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t39 = load %OperatorMatch, %OperatorMatch* %l5
  br i1 %t33, label %then4, label %merge5
then4:
  %t41 = load %OperatorMatch, %OperatorMatch* %l5
  %t42 = extractvalue %OperatorMatch %t41, 1
  %t44 = load %OperatorMatch, %OperatorMatch* %l5
  %t45 = extractvalue %OperatorMatch %t44, 1
  br label %merge5
merge5:
  %t46 = load i8*, i8** %l2
  %t47 = call %OperatorMatch @find_comparison_operator(i8* %t46)
  store %OperatorMatch %t47, %OperatorMatch* %l6
  %t48 = load %OperatorMatch, %OperatorMatch* %l6
  %t49 = extractvalue %OperatorMatch %t48, 2
  %t50 = load i8*, i8** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load i8*, i8** %l2
  %t53 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t54 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t55 = load %OperatorMatch, %OperatorMatch* %l5
  %t56 = load %OperatorMatch, %OperatorMatch* %l6
  br i1 %t49, label %then6, label %merge7
then6:
  %t57 = load i8*, i8** %l2
  %t58 = load %OperatorMatch, %OperatorMatch* %l6
  %t59 = call %ExpressionResult @lower_comparison_operation(i8* %t57, %OperatorMatch %t58, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  ret %ExpressionResult %t59
merge7:
  %t60 = load i8*, i8** %l2
  store double 0.0, double* %l7
  %t61 = load double, double* %l7
  %t62 = load i8*, i8** %l2
  store double 0.0, double* %l8
  %t63 = load double, double* %l8
  %t64 = load i8*, i8** %l2
  %t65 = call double @find_call_site(i8* %t64)
  store double %t65, double* %l9
  %t66 = load double, double* %l9
  %t68 = icmp ne i64 0, 0
  br label %logical_and_entry_67

logical_and_entry_67:
  br i1 %t68, label %logical_and_right_67, label %logical_and_merge_67

logical_and_right_67:
  %t69 = load i8*, i8** %l2
  %t70 = load i8*, i8** %l2
  %t71 = call %EnumLiteralParse @parse_enum_literal(i8* %t70)
  store %EnumLiteralParse %t71, %EnumLiteralParse* %l10
  %t73 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t74 = extractvalue %EnumLiteralParse %t73, 0
  br label %logical_and_entry_72

logical_and_entry_72:
  br i1 %t74, label %logical_and_right_72, label %logical_and_merge_72

logical_and_right_72:
  %t75 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t76 = extractvalue %EnumLiteralParse %t75, 1
  br label %logical_and_right_end_72

logical_and_right_end_72:
  br label %logical_and_merge_72

logical_and_merge_72:
  %t77 = phi i1 [ false, %logical_and_entry_72 ], [ %t76, %logical_and_right_end_72 ]
  %t78 = load i8*, i8** %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load i8*, i8** %l2
  %t81 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t82 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t83 = load %OperatorMatch, %OperatorMatch* %l5
  %t84 = load %OperatorMatch, %OperatorMatch* %l6
  %t85 = load double, double* %l7
  %t86 = load double, double* %l8
  %t87 = load double, double* %l9
  %t88 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  br i1 %t77, label %then8, label %merge9
then8:
  %t89 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t90 = extractvalue %EnumLiteralParse %t89, 2
  %t91 = call double @resolve_enum_info_for_literal(%TypeContext %context, i8* %t90)
  store double %t91, double* %l11
  %t92 = load double, double* %l11
  br label %merge9
merge9:
  %t93 = load i8*, i8** %l2
  %t94 = call %StructLiteralParse @parse_struct_literal(i8* %t93)
  store %StructLiteralParse %t94, %StructLiteralParse* %l12
  %t95 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t96 = extractvalue %StructLiteralParse %t95, 0
  %t97 = load i8*, i8** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load i8*, i8** %l2
  %t100 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t101 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t102 = load %OperatorMatch, %OperatorMatch* %l5
  %t103 = load %OperatorMatch, %OperatorMatch* %l6
  %t104 = load double, double* %l7
  %t105 = load double, double* %l8
  %t106 = load double, double* %l9
  %t107 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t108 = load %StructLiteralParse, %StructLiteralParse* %l12
  br i1 %t96, label %then10, label %merge11
then10:
  %t109 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t110 = extractvalue %StructLiteralParse %t109, 1
  %t111 = xor i1 %t110, 1
  %t112 = load i8*, i8** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load i8*, i8** %l2
  %t115 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t116 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t117 = load %OperatorMatch, %OperatorMatch* %l5
  %t118 = load %OperatorMatch, %OperatorMatch* %l6
  %t119 = load double, double* %l7
  %t120 = load double, double* %l8
  %t121 = load double, double* %l9
  %t122 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t123 = load %StructLiteralParse, %StructLiteralParse* %l12
  br i1 %t111, label %then12, label %merge13
then12:
  %t124 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t125 = extractvalue %StructLiteralParse %t124, 4
  %t126 = call double @diagnosticsconcat({ i8**, i64 }* %t125)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t127 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t128 = insertvalue %ExpressionResult %t127, double %temp_index, 1
  %t129 = insertvalue %ExpressionResult %t128, i8* null, 2
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = insertvalue %ExpressionResult %t129, { i8**, i64 }* %t130, 3
  %t132 = alloca [0 x double]
  %t133 = getelementptr [0 x double], [0 x double]* %t132, i32 0, i32 0
  %t134 = alloca { double*, i64 }
  %t135 = getelementptr { double*, i64 }, { double*, i64 }* %t134, i32 0, i32 0
  store double* %t133, double** %t135
  %t136 = getelementptr { double*, i64 }, { double*, i64 }* %t134, i32 0, i32 1
  store i64 0, i64* %t136
  %t137 = insertvalue %ExpressionResult %t131, { i8**, i64 }* null, 4
  ret %ExpressionResult %t137
merge13:
  %t138 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t139 = call %ExpressionResult @lower_struct_literal(%StructLiteralParse %t138, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t139, %ExpressionResult* %l13
  %t140 = load %ExpressionResult, %ExpressionResult* %l13
  %t141 = extractvalue %ExpressionResult %t140, 3
  %t142 = call double @diagnosticsconcat({ i8**, i64 }* %t141)
  store double %t142, double* %l14
  %t143 = load %ExpressionResult, %ExpressionResult* %l13
  %t144 = extractvalue %ExpressionResult %t143, 0
  %t145 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t144, 0
  %t146 = load %ExpressionResult, %ExpressionResult* %l13
  %t147 = extractvalue %ExpressionResult %t146, 1
  %t148 = insertvalue %ExpressionResult %t145, double %t147, 1
  %t149 = load %ExpressionResult, %ExpressionResult* %l13
  %t150 = extractvalue %ExpressionResult %t149, 2
  %t151 = insertvalue %ExpressionResult %t148, i8* %t150, 2
  %t152 = load double, double* %l14
  %t153 = insertvalue %ExpressionResult %t151, { i8**, i64 }* null, 3
  %t154 = load %ExpressionResult, %ExpressionResult* %l13
  %t155 = extractvalue %ExpressionResult %t154, 4
  %t156 = insertvalue %ExpressionResult %t153, { i8**, i64 }* %t155, 4
  ret %ExpressionResult %t156
merge11:
  %t157 = load i8*, i8** %l2
  %t158 = call %IndexExpressionParse @parse_index_expression(i8* %t157)
  store %IndexExpressionParse %t158, %IndexExpressionParse* %l15
  %t159 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t160 = extractvalue %IndexExpressionParse %t159, 0
  %t161 = load i8*, i8** %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load i8*, i8** %l2
  %t164 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t165 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t166 = load %OperatorMatch, %OperatorMatch* %l5
  %t167 = load %OperatorMatch, %OperatorMatch* %l6
  %t168 = load double, double* %l7
  %t169 = load double, double* %l8
  %t170 = load double, double* %l9
  %t171 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t172 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t173 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  br i1 %t160, label %then14, label %merge15
then14:
  %t174 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t175 = call %ExpressionResult @lower_index_expression(%IndexExpressionParse %t174, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  ret %ExpressionResult %t175
merge15:
  %t176 = load i8*, i8** %l2
  %t177 = call %MemberAccessParse @parse_member_access(i8* %t176)
  store %MemberAccessParse %t177, %MemberAccessParse* %l16
  %t178 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t179 = extractvalue %MemberAccessParse %t178, 0
  %t180 = load i8*, i8** %l0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load i8*, i8** %l2
  %t183 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t184 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t185 = load %OperatorMatch, %OperatorMatch* %l5
  %t186 = load %OperatorMatch, %OperatorMatch* %l6
  %t187 = load double, double* %l7
  %t188 = load double, double* %l8
  %t189 = load double, double* %l9
  %t190 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t191 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t192 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t193 = load %MemberAccessParse, %MemberAccessParse* %l16
  br i1 %t179, label %then16, label %merge17
then16:
  %t194 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t195 = call %ExpressionResult @lower_member_access(%MemberAccessParse %t194, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  ret %ExpressionResult %t195
merge17:
  %t196 = load i8*, i8** %l2
  %t197 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %bindings, i8* %t196)
  store double %t197, double* %l17
  %t198 = load double, double* %l17
  %t199 = load i8*, i8** %l2
  %t200 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t199)
  store double %t200, double* %l18
  %t201 = load double, double* %l18
  %t202 = load i8*, i8** %l2
  %t203 = call i8* @trim_text(i8* %t202)
  store i8* %t203, i8** %l19
  %t204 = load i8*, i8** %l19
  %t205 = call i1 @is_string_literal(i8* %t204)
  %t206 = load i8*, i8** %l0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t208 = load i8*, i8** %l2
  %t209 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t210 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t211 = load %OperatorMatch, %OperatorMatch* %l5
  %t212 = load %OperatorMatch, %OperatorMatch* %l6
  %t213 = load double, double* %l7
  %t214 = load double, double* %l8
  %t215 = load double, double* %l9
  %t216 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t217 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t218 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t219 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t220 = load double, double* %l17
  %t221 = load double, double* %l18
  %t222 = load i8*, i8** %l19
  br i1 %t205, label %then18, label %merge19
then18:
  %t223 = load i8*, i8** %l19
  %t224 = call %ExpressionResult @lower_string_literal(i8* %t223, double %temp_index, { i8**, i64 }* %lines)
  ret %ExpressionResult %t224
merge19:
  %t225 = load i8*, i8** %l19
  %t226 = call i1 @is_boolean_literal(i8* %t225)
  %t227 = load i8*, i8** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load i8*, i8** %l2
  %t230 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t231 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t232 = load %OperatorMatch, %OperatorMatch* %l5
  %t233 = load %OperatorMatch, %OperatorMatch* %l6
  %t234 = load double, double* %l7
  %t235 = load double, double* %l8
  %t236 = load double, double* %l9
  %t237 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t238 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t239 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t240 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t241 = load double, double* %l17
  %t242 = load double, double* %l18
  %t243 = load i8*, i8** %l19
  br i1 %t226, label %then20, label %merge21
then20:
  %s244 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.244, i32 0, i32 0
  store i8* %s244, i8** %l20
  %t245 = load i8*, i8** %l19
  %s246 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.246, i32 0, i32 0
  %t247 = call i1 @matches_case_insensitive(i8* %t245, i8* %s246)
  %t248 = load i8*, i8** %l0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t250 = load i8*, i8** %l2
  %t251 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t252 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t253 = load %OperatorMatch, %OperatorMatch* %l5
  %t254 = load %OperatorMatch, %OperatorMatch* %l6
  %t255 = load double, double* %l7
  %t256 = load double, double* %l8
  %t257 = load double, double* %l9
  %t258 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t259 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t260 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t261 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t262 = load double, double* %l17
  %t263 = load double, double* %l18
  %t264 = load i8*, i8** %l19
  %t265 = load i8*, i8** %l20
  br i1 %t247, label %then22, label %merge23
then22:
  %s266 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.266, i32 0, i32 0
  store i8* %s266, i8** %l20
  br label %merge23
merge23:
  %t267 = phi i8* [ %s266, %then22 ], [ %t265, %then20 ]
  store i8* %t267, i8** %l20
  %s268 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.268, i32 0, i32 0
  %t269 = insertvalue %LLVMOperand undef, i8* %s268, 0
  %t270 = load i8*, i8** %l20
  %t271 = insertvalue %LLVMOperand %t269, i8* %t270, 1
  store %LLVMOperand %t271, %LLVMOperand* %l21
  %t272 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t273 = insertvalue %ExpressionResult %t272, double %temp_index, 1
  %t274 = load %LLVMOperand, %LLVMOperand* %l21
  %t275 = insertvalue %ExpressionResult %t273, i8* null, 2
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t277 = insertvalue %ExpressionResult %t275, { i8**, i64 }* %t276, 3
  %t278 = alloca [0 x double]
  %t279 = getelementptr [0 x double], [0 x double]* %t278, i32 0, i32 0
  %t280 = alloca { double*, i64 }
  %t281 = getelementptr { double*, i64 }, { double*, i64 }* %t280, i32 0, i32 0
  store double* %t279, double** %t281
  %t282 = getelementptr { double*, i64 }, { double*, i64 }* %t280, i32 0, i32 1
  store i64 0, i64* %t282
  %t283 = insertvalue %ExpressionResult %t277, { i8**, i64 }* null, 4
  ret %ExpressionResult %t283
merge21:
  %t284 = load i8*, i8** %l19
  %t285 = call i1 @is_null_literal(i8* %t284)
  %t286 = load i8*, i8** %l0
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t288 = load i8*, i8** %l2
  %t289 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t290 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t291 = load %OperatorMatch, %OperatorMatch* %l5
  %t292 = load %OperatorMatch, %OperatorMatch* %l6
  %t293 = load double, double* %l7
  %t294 = load double, double* %l8
  %t295 = load double, double* %l9
  %t296 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t297 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t298 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t299 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t300 = load double, double* %l17
  %t301 = load double, double* %l18
  %t302 = load i8*, i8** %l19
  br i1 %t285, label %then24, label %merge25
then24:
  store double 0.0, double* %l22
  %t303 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t304 = insertvalue %ExpressionResult %t303, double %temp_index, 1
  %t305 = load double, double* %l22
  %t306 = insertvalue %ExpressionResult %t304, i8* null, 2
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t308 = insertvalue %ExpressionResult %t306, { i8**, i64 }* %t307, 3
  %t309 = alloca [0 x double]
  %t310 = getelementptr [0 x double], [0 x double]* %t309, i32 0, i32 0
  %t311 = alloca { double*, i64 }
  %t312 = getelementptr { double*, i64 }, { double*, i64 }* %t311, i32 0, i32 0
  store double* %t310, double** %t312
  %t313 = getelementptr { double*, i64 }, { double*, i64 }* %t311, i32 0, i32 1
  store i64 0, i64* %t313
  %t314 = insertvalue %ExpressionResult %t308, { i8**, i64 }* null, 4
  ret %ExpressionResult %t314
merge25:
  %t315 = load i8*, i8** %l19
  %t316 = call i1 @is_integer_literal(i8* %t315)
  %t317 = load i8*, i8** %l0
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t319 = load i8*, i8** %l2
  %t320 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t321 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t322 = load %OperatorMatch, %OperatorMatch* %l5
  %t323 = load %OperatorMatch, %OperatorMatch* %l6
  %t324 = load double, double* %l7
  %t325 = load double, double* %l8
  %t326 = load double, double* %l9
  %t327 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t328 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t329 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t330 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t331 = load double, double* %l17
  %t332 = load double, double* %l18
  %t333 = load i8*, i8** %l19
  br i1 %t316, label %then26, label %merge27
then26:
  %s334 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.334, i32 0, i32 0
  %t335 = insertvalue %LLVMOperand undef, i8* %s334, 0
  %t336 = load i8*, i8** %l19
  %t337 = insertvalue %LLVMOperand %t335, i8* %t336, 1
  store %LLVMOperand %t337, %LLVMOperand* %l23
  %t338 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t339 = insertvalue %ExpressionResult %t338, double %temp_index, 1
  %t340 = load %LLVMOperand, %LLVMOperand* %l23
  %t341 = insertvalue %ExpressionResult %t339, i8* null, 2
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t343 = insertvalue %ExpressionResult %t341, { i8**, i64 }* %t342, 3
  %t344 = alloca [0 x double]
  %t345 = getelementptr [0 x double], [0 x double]* %t344, i32 0, i32 0
  %t346 = alloca { double*, i64 }
  %t347 = getelementptr { double*, i64 }, { double*, i64 }* %t346, i32 0, i32 0
  store double* %t345, double** %t347
  %t348 = getelementptr { double*, i64 }, { double*, i64 }* %t346, i32 0, i32 1
  store i64 0, i64* %t348
  %t349 = insertvalue %ExpressionResult %t343, { i8**, i64 }* null, 4
  ret %ExpressionResult %t349
merge27:
  %t350 = load i8*, i8** %l19
  %t351 = call i1 @is_number_literal(i8* %t350)
  %t352 = load i8*, i8** %l0
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t354 = load i8*, i8** %l2
  %t355 = load %TernaryParseResult, %TernaryParseResult* %l3
  %t356 = load %BorrowParseResult, %BorrowParseResult* %l4
  %t357 = load %OperatorMatch, %OperatorMatch* %l5
  %t358 = load %OperatorMatch, %OperatorMatch* %l6
  %t359 = load double, double* %l7
  %t360 = load double, double* %l8
  %t361 = load double, double* %l9
  %t362 = load %EnumLiteralParse, %EnumLiteralParse* %l10
  %t363 = load %StructLiteralParse, %StructLiteralParse* %l12
  %t364 = load %IndexExpressionParse, %IndexExpressionParse* %l15
  %t365 = load %MemberAccessParse, %MemberAccessParse* %l16
  %t366 = load double, double* %l17
  %t367 = load double, double* %l18
  %t368 = load i8*, i8** %l19
  br i1 %t351, label %then28, label %merge29
then28:
  %t369 = load i8*, i8** %l19
  %t370 = call i8* @normalise_number_literal(i8* %t369)
  store i8* %t370, i8** %l24
  %s371 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.371, i32 0, i32 0
  %t372 = insertvalue %LLVMOperand undef, i8* %s371, 0
  %t373 = load i8*, i8** %l24
  %t374 = insertvalue %LLVMOperand %t372, i8* %t373, 1
  store %LLVMOperand %t374, %LLVMOperand* %l25
  %t375 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t376 = insertvalue %ExpressionResult %t375, double %temp_index, 1
  %t377 = load %LLVMOperand, %LLVMOperand* %l25
  %t378 = insertvalue %ExpressionResult %t376, i8* null, 2
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = insertvalue %ExpressionResult %t378, { i8**, i64 }* %t379, 3
  %t381 = alloca [0 x double]
  %t382 = getelementptr [0 x double], [0 x double]* %t381, i32 0, i32 0
  %t383 = alloca { double*, i64 }
  %t384 = getelementptr { double*, i64 }, { double*, i64 }* %t383, i32 0, i32 0
  store double* %t382, double** %t384
  %t385 = getelementptr { double*, i64 }, { double*, i64 }* %t383, i32 0, i32 1
  store i64 0, i64* %t385
  %t386 = insertvalue %ExpressionResult %t380, { i8**, i64 }* null, 4
  ret %ExpressionResult %t386
merge29:
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s388 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.388, i32 0, i32 0
  %t389 = load i8*, i8** %l19
  %t390 = add i8* %s388, %t389
  %s391 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.391, i32 0, i32 0
  %t392 = add i8* %t390, %s391
  %t393 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t387, i8* %t392)
  store { i8**, i64 }* %t393, { i8**, i64 }** %l1
  %t394 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t395 = insertvalue %ExpressionResult %t394, double %temp_index, 1
  %t396 = insertvalue %ExpressionResult %t395, i8* null, 2
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t398 = insertvalue %ExpressionResult %t396, { i8**, i64 }* %t397, 3
  %t399 = alloca [0 x double]
  %t400 = getelementptr [0 x double], [0 x double]* %t399, i32 0, i32 0
  %t401 = alloca { double*, i64 }
  %t402 = getelementptr { double*, i64 }, { double*, i64 }* %t401, i32 0, i32 0
  store double* %t400, double** %t402
  %t403 = getelementptr { double*, i64 }, { double*, i64 }* %t401, i32 0, i32 1
  store i64 0, i64* %t403
  %t404 = insertvalue %ExpressionResult %t398, { i8**, i64 }* null, 4
  ret %ExpressionResult %t404
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
  %t16 = getelementptr i8, i8* %t15, i64 0
  %t17 = load i8, i8* %t16
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l2
  %t20 = call %BorrowArgumentParse @extract_borrow_argument(i8* %t19)
  store %BorrowArgumentParse %t20, %BorrowArgumentParse* %l3
  %t21 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t22 = extractvalue %BorrowArgumentParse %t21, 2
  %t23 = call double @diagnosticsconcat({ i8**, i64 }* %t22)
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t24 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t25 = extractvalue %BorrowArgumentParse %t24, 0
  %t26 = xor i1 %t25, 1
  %t27 = load i8*, i8** %l0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t26, label %then2, label %merge3
then2:
  %t32 = insertvalue %BorrowParseResult undef, i1 1, 0
  %t33 = insertvalue %BorrowParseResult %t32, i1 0, 1
  %s34 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.34, i32 0, i32 0
  %t35 = insertvalue %BorrowParseResult %t33, i8* %s34, 2
  %t36 = insertvalue %BorrowParseResult %t35, i1 0, 3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t38 = insertvalue %BorrowParseResult %t36, { i8**, i64 }* %t37, 4
  ret %BorrowParseResult %t38
merge3:
  %t39 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t40 = extractvalue %BorrowArgumentParse %t39, 1
  %t41 = insertvalue %BorrowParseResult undef, i1 1, 0
  %t42 = insertvalue %BorrowParseResult %t41, i1 1, 1
  %t43 = load %BorrowArgumentParse, %BorrowArgumentParse* %l3
  %t44 = extractvalue %BorrowArgumentParse %t43, 1
  %t45 = insertvalue %BorrowParseResult %t42, i8* %t44, 2
  %t46 = insertvalue %BorrowParseResult %t45, i1 0, 3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t48 = insertvalue %BorrowParseResult %t46, { i8**, i64 }* %t47, 4
  ret %BorrowParseResult %t48
merge1:
  %t49 = load i8*, i8** %l0
  %s50 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.50, i32 0, i32 0
  %t51 = call i1 @starts_with(i8* %t49, i8* %s50)
  %t52 = xor i1 %t51, 1
  %t53 = load i8*, i8** %l0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t52, label %then4, label %merge5
then4:
  %t55 = insertvalue %BorrowParseResult undef, i1 0, 0
  %t56 = insertvalue %BorrowParseResult %t55, i1 0, 1
  %s57 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.57, i32 0, i32 0
  %t58 = insertvalue %BorrowParseResult %t56, i8* %s57, 2
  %t59 = insertvalue %BorrowParseResult %t58, i1 0, 3
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = insertvalue %BorrowParseResult %t59, { i8**, i64 }* %t60, 4
  ret %BorrowParseResult %t61
merge5:
  %t62 = load i8*, i8** %l0
  %t64 = load i8*, i8** %l0
  %t65 = load i8*, i8** %l0
  store i8* null, i8** %l5
  store i1 0, i1* %l6
  %t66 = load i8*, i8** %l5
  %s67 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.67, i32 0, i32 0
  %t68 = call i1 @starts_with(i8* %t66, i8* %s67)
  %t69 = load i8*, i8** %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load i8*, i8** %l5
  %t72 = load i1, i1* %l6
  br i1 %t68, label %then6, label %merge7
then6:
  store i1 1, i1* %l6
  %t73 = load i8*, i8** %l5
  %t74 = load i8*, i8** %l5
  store double 0.0, double* %l7
  %t75 = load double, double* %l7
  %t76 = call i8* @trim_text(i8* null)
  store i8* %t76, i8** %l5
  br label %merge7
merge7:
  %t77 = phi i1 [ 1, %then6 ], [ %t72, %entry ]
  %t78 = phi i8* [ %t76, %then6 ], [ %t71, %entry ]
  store i1 %t77, i1* %l6
  store i8* %t78, i8** %l5
  %t79 = load i8*, i8** %l5
  %t80 = insertvalue %BorrowParseResult undef, i1 1, 0
  %t81 = insertvalue %BorrowParseResult %t80, i1 1, 1
  %t82 = load i8*, i8** %l5
  %t83 = call i8* @trim_text(i8* %t82)
  %t84 = insertvalue %BorrowParseResult %t81, i8* %t83, 2
  %t85 = load i1, i1* %l6
  %t86 = insertvalue %BorrowParseResult %t84, i1 %t85, 3
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = insertvalue %BorrowParseResult %t86, { i8**, i64 }* %t87, 4
  ret %BorrowParseResult %t88
}

define %BorrowArgumentParse @extract_borrow_argument(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t24 = phi double [ %t10, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l2
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = getelementptr i8, i8* %text, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t16 = load i8, i8* %l4
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = load i8, i8* %l4
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t20 = load double, double* %l2
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l2
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l3
  %t26 = sitofp i64 0 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then4, label %merge5
then4:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s33 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.33, i32 0, i32 0
  %t34 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t32, i8* %s33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = insertvalue %BorrowArgumentParse undef, i1 0, 0
  %s36 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.36, i32 0, i32 0
  %t37 = insertvalue %BorrowArgumentParse %t35, i8* %s36, 1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = insertvalue %BorrowArgumentParse %t37, { i8**, i64 }* %t38, 2
  ret %BorrowArgumentParse %t39
merge5:
  %t40 = load double, double* %l3
  %t41 = call double @substring(i8* %text, i64 1, double %t40)
  store double %t41, double* %l5
  %t42 = load double, double* %l3
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double 0.0, double* %l6
  %t45 = load double, double* %l6
  %t46 = insertvalue %BorrowArgumentParse undef, i1 1, 0
  %t47 = load double, double* %l5
  %t48 = call i8* @trim_text(i8* null)
  %t49 = insertvalue %BorrowArgumentParse %t46, i8* %t48, 1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = insertvalue %BorrowArgumentParse %t49, { i8**, i64 }* %t50, 2
  ret %BorrowArgumentParse %t51
}

define %TernaryParseResult @parse_ternary_expression(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call i8* @trim_text(i8* %text)
  store i8* %t5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = sitofp i64 -1 to double
  store double %t8, double* %l3
  %t9 = sitofp i64 -1 to double
  store double %t9, double* %l4
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l5
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load i8*, i8** %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  %t15 = load double, double* %l4
  %t16 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t52 = phi double [ %t16, %entry ], [ %t51, %loop.latch2 ]
  store double %t52, double* %l5
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l5
  %t18 = load i8*, i8** %l1
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l5
  %t21 = getelementptr i8, i8* %t19, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l6
  %t25 = load i8, i8* %l6
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t29 = load i8, i8* %l6
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = load double, double* %l2
  %t32 = sitofp i64 0 to double
  %t33 = fcmp oeq double %t31, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load double, double* %l4
  %t39 = load double, double* %l5
  %t40 = load i8, i8* %l6
  br i1 %t33, label %then4, label %merge5
then4:
  %t42 = load i8, i8* %l6
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  %t46 = load i8, i8* %l6
  %s47 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.47, i32 0, i32 0
  br label %merge5
merge5:
  %t48 = load double, double* %l5
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l5
  br label %loop.latch2
loop.latch2:
  %t51 = load double, double* %l5
  br label %loop.header0
afterloop3:
  %t54 = load double, double* %l3
  %t55 = sitofp i64 0 to double
  %t56 = fcmp olt double %t54, %t55
  br label %logical_or_entry_53

logical_or_entry_53:
  br i1 %t56, label %logical_or_merge_53, label %logical_or_right_53

logical_or_right_53:
  %t57 = load double, double* %l4
  %t58 = sitofp i64 0 to double
  %t59 = fcmp olt double %t57, %t58
  br label %logical_or_right_end_53

logical_or_right_end_53:
  br label %logical_or_merge_53

logical_or_merge_53:
  %t60 = phi i1 [ true, %logical_or_entry_53 ], [ %t59, %logical_or_right_end_53 ]
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load double, double* %l4
  %t66 = load double, double* %l5
  br i1 %t60, label %then6, label %merge7
then6:
  %t67 = insertvalue %TernaryParseResult undef, i1 0, 0
  %s68 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.68, i32 0, i32 0
  %t69 = insertvalue %TernaryParseResult %t67, i8* %s68, 1
  %s70 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.70, i32 0, i32 0
  %t71 = insertvalue %TernaryParseResult %t69, i8* %s70, 2
  %s72 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.72, i32 0, i32 0
  %t73 = insertvalue %TernaryParseResult %t71, i8* %s72, 3
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = insertvalue %TernaryParseResult %t73, { i8**, i64 }* %t74, 4
  ret %TernaryParseResult %t75
merge7:
  %t76 = load double, double* %l3
  %t77 = load double, double* %l4
  %t78 = fcmp oge double %t76, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  %t82 = load double, double* %l3
  %t83 = load double, double* %l4
  %t84 = load double, double* %l5
  br i1 %t78, label %then8, label %merge9
then8:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = insertvalue %TernaryParseResult undef, i1 0, 0
  %s87 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.87, i32 0, i32 0
  %t88 = insertvalue %TernaryParseResult %t86, i8* %s87, 1
  %s89 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.89, i32 0, i32 0
  %t90 = insertvalue %TernaryParseResult %t88, i8* %s89, 2
  %s91 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.91, i32 0, i32 0
  %t92 = insertvalue %TernaryParseResult %t90, i8* %s91, 3
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = insertvalue %TernaryParseResult %t92, { i8**, i64 }* %t93, 4
  ret %TernaryParseResult %t94
merge9:
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l3
  %t97 = call double @substring(i8* %t95, i64 0, double %t96)
  %t98 = call i8* @trim_text(i8* null)
  store i8* %t98, i8** %l7
  %t99 = load i8*, i8** %l1
  %t100 = load double, double* %l3
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  %t103 = load double, double* %l4
  %t104 = call double @substring(i8* %t99, double %t102, double %t103)
  %t105 = call i8* @trim_text(i8* null)
  store i8* %t105, i8** %l8
  %t106 = load i8*, i8** %l1
  %t107 = load double, double* %l4
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  %t110 = load i8*, i8** %l1
  store double 0.0, double* %l9
  %t111 = load i8*, i8** %l7
  %t112 = load i8*, i8** %l8
  %t113 = load double, double* %l9
  %t114 = insertvalue %TernaryParseResult undef, i1 1, 0
  %t115 = load i8*, i8** %l7
  %t116 = insertvalue %TernaryParseResult %t114, i8* %t115, 1
  %t117 = load i8*, i8** %l8
  %t118 = insertvalue %TernaryParseResult %t116, i8* %t117, 2
  %t119 = load double, double* %l9
  %t120 = insertvalue %TernaryParseResult %t118, i8* null, 3
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = insertvalue %TernaryParseResult %t120, { i8**, i64 }* %t121, 4
  ret %TernaryParseResult %t122
}

define %OwnershipAnalysis @analyze_value_ownership(i8* %initializer, i8* %span, { %LocalBinding*, i64 }* %locals, { %ParameterBinding*, i64 }* %bindings) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %BorrowParseResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %t0 = icmp eq i8* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = insertvalue %OwnershipAnalysis undef, i8* null, 0
  %t2 = insertvalue %OwnershipAnalysis %t1, i8* null, 1
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  %t8 = insertvalue %OwnershipAnalysis %t2, { i8**, i64 }* null, 2
  ret %OwnershipAnalysis %t8
merge1:
  %t9 = call i8* @trim_text(i8* %initializer)
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = call %BorrowParseResult @parse_borrow_expression(i8* %t11)
  store %BorrowParseResult %t12, %BorrowParseResult* %l1
  %t13 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t14 = extractvalue %BorrowParseResult %t13, 4
  store { i8**, i64 }* %t14, { i8**, i64 }** %l2
  %t15 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t16 = extractvalue %BorrowParseResult %t15, 0
  %t17 = load i8*, i8** %l0
  %t18 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t16, label %then2, label %merge3
then2:
  %t20 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t21 = extractvalue %BorrowParseResult %t20, 1
  %t22 = xor i1 %t21, 1
  %t23 = load i8*, i8** %l0
  %t24 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t22, label %then4, label %merge5
then4:
  %t26 = insertvalue %OwnershipAnalysis undef, i8* null, 0
  %t27 = insertvalue %OwnershipAnalysis %t26, i8* null, 1
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t29 = insertvalue %OwnershipAnalysis %t27, { i8**, i64 }* %t28, 2
  ret %OwnershipAnalysis %t29
merge5:
  %t30 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t31 = extractvalue %BorrowParseResult %t30, 2
  %t32 = call i8* @resolve_borrow_base(i8* %t31, { %LocalBinding*, i64 }* %locals)
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t34 = load double, double* %l4
  %t35 = insertvalue %OwnershipAnalysis undef, i8* null, 0
  %t36 = insertvalue %OwnershipAnalysis %t35, i8* null, 1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = insertvalue %OwnershipAnalysis %t36, { i8**, i64 }* %t37, 2
  ret %OwnershipAnalysis %t38
merge3:
  %t39 = load i8*, i8** %l0
  %t40 = call i1 @is_simple_identifier(i8* %t39)
  %t41 = load i8*, i8** %l0
  %t42 = load %BorrowParseResult, %BorrowParseResult* %l1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t40, label %then6, label %merge7
then6:
  %t44 = load i8*, i8** %l0
  store i8* %t44, i8** %l5
  %t45 = load i8*, i8** %l5
  %t46 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t45)
  store double %t46, double* %l6
  %t47 = load double, double* %l6
  %t48 = load i8*, i8** %l5
  %t49 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %bindings, i8* %t48)
  store double %t49, double* %l7
  %t50 = load double, double* %l7
  br label %merge7
merge7:
  %t51 = insertvalue %OwnershipAnalysis undef, i8* null, 0
  %t52 = insertvalue %OwnershipAnalysis %t51, i8* null, 1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = insertvalue %OwnershipAnalysis %t52, { i8**, i64 }* %t53, 2
  ret %OwnershipAnalysis %t54
}

define i8* @format_use_after_move_message(i8* %name, i8* %span) {
entry:
  %t0 = icmp eq i8* %span, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  ret i8* null
}

define i8* @format_span_location(i8* %span) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  store double 0.0, double* %l1
  %t0 = load double, double* %l0
  ret i8* null
}

define i8* @format_suspension_location(i8* %keyword, i8* %borrow_span, i8* %suspension_span) {
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
  %t5 = icmp ne i8* %suspension_span, null
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = add i8* %keyword, %s8
  %t10 = call i8* @format_span_location(i8* %suspension_span)
  %t11 = add i8* %t9, %t10
  %t12 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t7, i8* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l0
  br label %merge1
merge1:
  %t13 = phi { i8**, i64 }* [ %t12, %then0 ], [ %t6, %entry ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp eq i64 %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t17, label %then2, label %merge3
then2:
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.19, i32 0, i32 0
  ret i8* %s19
merge3:
  %s20 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.20, i32 0, i32 0
  ret i8* %s20
}

define { i8**, i64 }* @detect_borrow_conflicts(i8* %ownership, { %LocalBinding*, i64 }* %locals, i8* %binding_name, i8* %function_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca %LocalBinding
  %l4 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = icmp eq i8* %ownership, null
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t7
merge1:
  store double 0.0, double* %l1
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t41 = phi double [ %t11, %entry ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l2
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l2
  %t13 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t14 = extractvalue { %LocalBinding*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t20 = load double, double* %l2
  %t21 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t22 = extractvalue { %LocalBinding*, i64 } %t21, 0
  %t23 = extractvalue { %LocalBinding*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %LocalBinding, %LocalBinding* %t22, i64 %t20
  %t26 = load %LocalBinding, %LocalBinding* %t25
  store %LocalBinding %t26, %LocalBinding* %l3
  %t27 = load %LocalBinding, %LocalBinding* %l3
  %t28 = extractvalue %LocalBinding %t27, 4
  %t29 = icmp ne i8* %t28, null
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load %LocalBinding, %LocalBinding* %l3
  br i1 %t29, label %then8, label %merge9
then8:
  %t34 = load %LocalBinding, %LocalBinding* %l3
  %t35 = extractvalue %LocalBinding %t34, 4
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l4
  br label %merge9
merge9:
  %t37 = load double, double* %l2
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l2
  br label %loop.latch4
loop.latch4:
  %t40 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t42
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
  %t7 = call i1 @is_simple_identifier(i8* %t6)
  %t8 = xor i1 %t7, 1
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
  %t1 = extractvalue %BorrowParseResult %parse, 1
  %t2 = xor i1 %t1, 1
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t5 = insertvalue %ExpressionResult %t4, double %temp_index, 1
  %t6 = insertvalue %ExpressionResult %t5, i8* null, 2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = insertvalue %ExpressionResult %t6, { i8**, i64 }* %t7, 3
  %t9 = alloca [0 x double]
  %t10 = getelementptr [0 x double], [0 x double]* %t9, i32 0, i32 0
  %t11 = alloca { double*, i64 }
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 0
  store double* %t10, double** %t12
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  %t14 = insertvalue %ExpressionResult %t8, { i8**, i64 }* null, 4
  ret %ExpressionResult %t14
merge1:
  %t15 = extractvalue %BorrowParseResult %parse, 2
  %t16 = call i8* @strip_enclosing_parentheses(i8* %t15)
  store i8* %t16, i8** %l1
  %t17 = load i8*, i8** %l1
  %t18 = call i8* @trim_text(i8* %t17)
  store i8* %t18, i8** %l1
  %t19 = load i8*, i8** %l1
  %t20 = load i8*, i8** %l1
  %t21 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = load double, double* %l2
  store double 0.0, double* %l3
  %t24 = load double, double* %l3
  %t25 = insertvalue %LLVMOperand undef, i8* null, 0
  %t26 = load double, double* %l2
  %t27 = insertvalue %LLVMOperand %t25, i8* null, 1
  store %LLVMOperand %t27, %LLVMOperand* %l4
  %t28 = insertvalue %ExpressionResult undef, { i8**, i64 }* %lines, 0
  %t29 = insertvalue %ExpressionResult %t28, double %temp_index, 1
  %t30 = load %LLVMOperand, %LLVMOperand* %l4
  %t31 = insertvalue %ExpressionResult %t29, i8* null, 2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = insertvalue %ExpressionResult %t31, { i8**, i64 }* %t32, 3
  %t34 = alloca [0 x double]
  %t35 = getelementptr [0 x double], [0 x double]* %t34, i32 0, i32 0
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t35, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  %t39 = insertvalue %ExpressionResult %t33, { i8**, i64 }* null, 4
  ret %ExpressionResult %t39
}

define %ExpressionResult @lower_ternary_expression(%TernaryParseResult %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %StringConstant*, i64 }*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %ExpressionResult
  %l9 = alloca %CoercionResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca %ExpressionResult
  %l12 = alloca i8*
  %l13 = alloca %ExpressionResult
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca double
  %l17 = alloca %LLVMOperand
  %t0 = extractvalue %TernaryParseResult %parse, 4
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l1
  %t6 = call i8* @number_to_string(double %temp_index)
  store i8* %t6, i8** %l2
  %s7 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.7, i32 0, i32 0
  %t8 = load i8*, i8** %l2
  %t9 = add i8* %s7, %t8
  store i8* %t9, i8** %l3
  %s10 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8*, i8** %l2
  %t12 = add i8* %s10, %t11
  store i8* %t12, i8** %l4
  %s13 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8*, i8** %l2
  %t15 = add i8* %s13, %t14
  store i8* %t15, i8** %l5
  %s16 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.16, i32 0, i32 0
  %t17 = load i8*, i8** %l2
  %t18 = add i8* %s16, %t17
  store i8* %t18, i8** %l6
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %temp_index, %t19
  store double %t20, double* %l7
  %t21 = extractvalue %TernaryParseResult %parse, 1
  %t22 = load double, double* %l7
  %t23 = call %ExpressionResult @lower_expression(i8* %t21, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t22, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t23, %ExpressionResult* %l8
  %t24 = load %ExpressionResult, %ExpressionResult* %l8
  %t25 = extractvalue %ExpressionResult %t24, 3
  %t26 = call double @diagnosticsconcat({ i8**, i64 }* %t25)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t27 = load %ExpressionResult, %ExpressionResult* %l8
  %t28 = extractvalue %ExpressionResult %t27, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l1
  %t29 = load %ExpressionResult, %ExpressionResult* %l8
  %t30 = extractvalue %ExpressionResult %t29, 2
  %t31 = icmp eq i8* %t30, null
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t34 = load i8*, i8** %l2
  %t35 = load i8*, i8** %l3
  %t36 = load i8*, i8** %l4
  %t37 = load i8*, i8** %l5
  %t38 = load i8*, i8** %l6
  %t39 = load double, double* %l7
  %t40 = load %ExpressionResult, %ExpressionResult* %l8
  br i1 %t31, label %then0, label %merge1
then0:
  %t41 = load %ExpressionResult, %ExpressionResult* %l8
  %t42 = extractvalue %ExpressionResult %t41, 0
  %t43 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t42, 0
  %t44 = load %ExpressionResult, %ExpressionResult* %l8
  %t45 = extractvalue %ExpressionResult %t44, 1
  %t46 = insertvalue %ExpressionResult %t43, double %t45, 1
  %t47 = insertvalue %ExpressionResult %t46, i8* null, 2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = insertvalue %ExpressionResult %t47, { i8**, i64 }* %t48, 3
  %t50 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t51 = insertvalue %ExpressionResult %t49, { i8**, i64 }* null, 4
  ret %ExpressionResult %t51
merge1:
  %t52 = load %ExpressionResult, %ExpressionResult* %l8
  %t53 = extractvalue %ExpressionResult %t52, 2
  %s54 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.54, i32 0, i32 0
  %t55 = load %ExpressionResult, %ExpressionResult* %l8
  %t56 = extractvalue %ExpressionResult %t55, 1
  %t57 = load %ExpressionResult, %ExpressionResult* %l8
  %t58 = extractvalue %ExpressionResult %t57, 0
  %t59 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %s54, double %t56, { i8**, i64 }* %t58)
  store %CoercionResult %t59, %CoercionResult* %l9
  %t60 = load %CoercionResult, %CoercionResult* %l9
  %t61 = extractvalue %CoercionResult %t60, 3
  %t62 = call double @diagnosticsconcat({ i8**, i64 }* %t61)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t63 = load %CoercionResult, %CoercionResult* %l9
  %t64 = extractvalue %CoercionResult %t63, 2
  %t65 = icmp eq i8* %t64, null
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  %t70 = load i8*, i8** %l4
  %t71 = load i8*, i8** %l5
  %t72 = load i8*, i8** %l6
  %t73 = load double, double* %l7
  %t74 = load %ExpressionResult, %ExpressionResult* %l8
  %t75 = load %CoercionResult, %CoercionResult* %l9
  br i1 %t65, label %then2, label %merge3
then2:
  %t76 = load %CoercionResult, %CoercionResult* %l9
  %t77 = extractvalue %CoercionResult %t76, 0
  %t78 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t77, 0
  %t79 = load %CoercionResult, %CoercionResult* %l9
  %t80 = extractvalue %CoercionResult %t79, 1
  %t81 = insertvalue %ExpressionResult %t78, double %t80, 1
  %t82 = insertvalue %ExpressionResult %t81, i8* null, 2
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = insertvalue %ExpressionResult %t82, { i8**, i64 }* %t83, 3
  %t85 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t86 = insertvalue %ExpressionResult %t84, { i8**, i64 }* null, 4
  ret %ExpressionResult %t86
merge3:
  %t87 = load %CoercionResult, %CoercionResult* %l9
  %t88 = extractvalue %CoercionResult %t87, 0
  store { i8**, i64 }* %t88, { i8**, i64 }** %l10
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s90 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.90, i32 0, i32 0
  %t91 = load i8*, i8** %l3
  %t92 = add i8* %s90, %t91
  %t93 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t89, i8* %t92)
  store { i8**, i64 }* %t93, { i8**, i64 }** %l10
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s95 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.95, i32 0, i32 0
  %t96 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t94, i8* %s95)
  store { i8**, i64 }* %t96, { i8**, i64 }** %l10
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t98 = load i8*, i8** %l3
  %s99 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.99, i32 0, i32 0
  %t100 = add i8* %t98, %s99
  %t101 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t97, i8* %t100)
  store { i8**, i64 }* %t101, { i8**, i64 }** %l10
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s103 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.103, i32 0, i32 0
  %t104 = load %CoercionResult, %CoercionResult* %l9
  %t105 = extractvalue %CoercionResult %t104, 2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s107 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.107, i32 0, i32 0
  %t108 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t106, i8* %s107)
  store { i8**, i64 }* %t108, { i8**, i64 }** %l10
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t110 = load i8*, i8** %l4
  %s111 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.111, i32 0, i32 0
  %t112 = add i8* %t110, %s111
  %t113 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t109, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l10
  %t114 = extractvalue %TernaryParseResult %parse, 2
  %t115 = load %CoercionResult, %CoercionResult* %l9
  %t116 = extractvalue %CoercionResult %t115, 1
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t118 = call %ExpressionResult @lower_expression(i8* %t114, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t116, { i8**, i64 }* %t117, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t118, %ExpressionResult* %l11
  %t119 = load %ExpressionResult, %ExpressionResult* %l11
  %t120 = extractvalue %ExpressionResult %t119, 3
  %t121 = call double @diagnosticsconcat({ i8**, i64 }* %t120)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t122 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t123 = load %ExpressionResult, %ExpressionResult* %l11
  %t124 = extractvalue %ExpressionResult %t123, 4
  %t125 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t122, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t125, { %StringConstant*, i64 }** %l1
  %t126 = load %ExpressionResult, %ExpressionResult* %l11
  %t127 = extractvalue %ExpressionResult %t126, 2
  %t128 = icmp eq i8* %t127, null
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t131 = load i8*, i8** %l2
  %t132 = load i8*, i8** %l3
  %t133 = load i8*, i8** %l4
  %t134 = load i8*, i8** %l5
  %t135 = load i8*, i8** %l6
  %t136 = load double, double* %l7
  %t137 = load %ExpressionResult, %ExpressionResult* %l8
  %t138 = load %CoercionResult, %CoercionResult* %l9
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t140 = load %ExpressionResult, %ExpressionResult* %l11
  br i1 %t128, label %then4, label %merge5
then4:
  %t141 = load %ExpressionResult, %ExpressionResult* %l11
  %t142 = extractvalue %ExpressionResult %t141, 0
  %t143 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t142, 0
  %t144 = load %ExpressionResult, %ExpressionResult* %l11
  %t145 = extractvalue %ExpressionResult %t144, 1
  %t146 = insertvalue %ExpressionResult %t143, double %t145, 1
  %t147 = insertvalue %ExpressionResult %t146, i8* null, 2
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = insertvalue %ExpressionResult %t147, { i8**, i64 }* %t148, 3
  %t150 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t151 = insertvalue %ExpressionResult %t149, { i8**, i64 }* null, 4
  ret %ExpressionResult %t151
merge5:
  %s152 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.152, i32 0, i32 0
  %t153 = load i8*, i8** %l2
  %t154 = add i8* %s152, %t153
  store i8* %t154, i8** %l12
  %t155 = load %ExpressionResult, %ExpressionResult* %l11
  %t156 = extractvalue %ExpressionResult %t155, 0
  store { i8**, i64 }* %t156, { i8**, i64 }** %l10
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s158 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.158, i32 0, i32 0
  %t159 = load i8*, i8** %l12
  %t160 = add i8* %s158, %t159
  %t161 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t157, i8* %t160)
  store { i8**, i64 }* %t161, { i8**, i64 }** %l10
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s163 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.163, i32 0, i32 0
  %t164 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t162, i8* %s163)
  store { i8**, i64 }* %t164, { i8**, i64 }** %l10
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t166 = load i8*, i8** %l12
  %s167 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.167, i32 0, i32 0
  %t168 = add i8* %t166, %s167
  %t169 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t165, i8* %t168)
  store { i8**, i64 }* %t169, { i8**, i64 }** %l10
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s171 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.171, i32 0, i32 0
  %t172 = load i8*, i8** %l6
  %t173 = add i8* %s171, %t172
  %t174 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t170, i8* %t173)
  store { i8**, i64 }* %t174, { i8**, i64 }** %l10
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s176 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.176, i32 0, i32 0
  %t177 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t175, i8* %s176)
  store { i8**, i64 }* %t177, { i8**, i64 }** %l10
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t179 = load i8*, i8** %l5
  %s180 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.180, i32 0, i32 0
  %t181 = add i8* %t179, %s180
  %t182 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t178, i8* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l10
  %t183 = extractvalue %TernaryParseResult %parse, 3
  %t184 = load %ExpressionResult, %ExpressionResult* %l11
  %t185 = extractvalue %ExpressionResult %t184, 1
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t187 = call %ExpressionResult @lower_expression(i8* %t183, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t185, { i8**, i64 }* %t186, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t187, %ExpressionResult* %l13
  %t188 = load %ExpressionResult, %ExpressionResult* %l13
  %t189 = extractvalue %ExpressionResult %t188, 3
  %t190 = call double @diagnosticsconcat({ i8**, i64 }* %t189)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t191 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t192 = load %ExpressionResult, %ExpressionResult* %l13
  %t193 = extractvalue %ExpressionResult %t192, 4
  %t194 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t191, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t194, { %StringConstant*, i64 }** %l1
  %t195 = load %ExpressionResult, %ExpressionResult* %l13
  %t196 = extractvalue %ExpressionResult %t195, 2
  %t197 = icmp eq i8* %t196, null
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t200 = load i8*, i8** %l2
  %t201 = load i8*, i8** %l3
  %t202 = load i8*, i8** %l4
  %t203 = load i8*, i8** %l5
  %t204 = load i8*, i8** %l6
  %t205 = load double, double* %l7
  %t206 = load %ExpressionResult, %ExpressionResult* %l8
  %t207 = load %CoercionResult, %CoercionResult* %l9
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t209 = load %ExpressionResult, %ExpressionResult* %l11
  %t210 = load i8*, i8** %l12
  %t211 = load %ExpressionResult, %ExpressionResult* %l13
  br i1 %t197, label %then6, label %merge7
then6:
  %t212 = load %ExpressionResult, %ExpressionResult* %l13
  %t213 = extractvalue %ExpressionResult %t212, 0
  %t214 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t213, 0
  %t215 = load %ExpressionResult, %ExpressionResult* %l13
  %t216 = extractvalue %ExpressionResult %t215, 1
  %t217 = insertvalue %ExpressionResult %t214, double %t216, 1
  %t218 = insertvalue %ExpressionResult %t217, i8* null, 2
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t220 = insertvalue %ExpressionResult %t218, { i8**, i64 }* %t219, 3
  %t221 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t222 = insertvalue %ExpressionResult %t220, { i8**, i64 }* null, 4
  ret %ExpressionResult %t222
merge7:
  %s223 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.223, i32 0, i32 0
  %t224 = load i8*, i8** %l2
  %t225 = add i8* %s223, %t224
  store i8* %t225, i8** %l14
  %t226 = load %ExpressionResult, %ExpressionResult* %l13
  %t227 = extractvalue %ExpressionResult %t226, 0
  store { i8**, i64 }* %t227, { i8**, i64 }** %l10
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s229 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.229, i32 0, i32 0
  %t230 = load i8*, i8** %l14
  %t231 = add i8* %s229, %t230
  %t232 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t228, i8* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l10
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s234 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.234, i32 0, i32 0
  %t235 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t233, i8* %s234)
  store { i8**, i64 }* %t235, { i8**, i64 }** %l10
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t237 = load i8*, i8** %l14
  %s238 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.238, i32 0, i32 0
  %t239 = add i8* %t237, %s238
  %t240 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t236, i8* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l10
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s242 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.242, i32 0, i32 0
  %t243 = load i8*, i8** %l6
  %t244 = add i8* %s242, %t243
  %t245 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t241, i8* %t244)
  store { i8**, i64 }* %t245, { i8**, i64 }** %l10
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s247 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.247, i32 0, i32 0
  %t248 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t246, i8* %s247)
  store { i8**, i64 }* %t248, { i8**, i64 }** %l10
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t250 = load i8*, i8** %l6
  %s251 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.251, i32 0, i32 0
  %t252 = add i8* %t250, %s251
  %t253 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t249, i8* %t252)
  store { i8**, i64 }* %t253, { i8**, i64 }** %l10
  %t254 = load %ExpressionResult, %ExpressionResult* %l11
  %t255 = extractvalue %ExpressionResult %t254, 2
  %t256 = load %ExpressionResult, %ExpressionResult* %l13
  %t257 = extractvalue %ExpressionResult %t256, 1
  %t258 = call i8* @format_temp_name(double %t257)
  store i8* %t258, i8** %l15
  %t259 = load %ExpressionResult, %ExpressionResult* %l11
  %t260 = extractvalue %ExpressionResult %t259, 2
  store double 0.0, double* %l16
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s262 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.262, i32 0, i32 0
  %t263 = load i8*, i8** %l15
  %t264 = add i8* %s262, %t263
  %s265 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.265, i32 0, i32 0
  %t266 = add i8* %t264, %s265
  %t267 = load double, double* %l16
  %t268 = load double, double* %l16
  %t269 = insertvalue %LLVMOperand undef, i8* null, 0
  %t270 = load i8*, i8** %l15
  %t271 = insertvalue %LLVMOperand %t269, i8* %t270, 1
  store %LLVMOperand %t271, %LLVMOperand* %l17
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_binary_operation(i8* %expression, %OperatorMatch %match, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
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
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = call %ExpressionResult @lower_expression(i8* %t13, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t14, %ExpressionResult* %l3
  %t15 = load %ExpressionResult, %ExpressionResult* %l3
  %t16 = extractvalue %ExpressionResult %t15, 3
  %t17 = call double @diagnosticsconcat({ i8**, i64 }* %t16)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t18 = load %ExpressionResult, %ExpressionResult* %l3
  %t19 = extractvalue %ExpressionResult %t18, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l4
  %t20 = load %ExpressionResult, %ExpressionResult* %l3
  %t21 = extractvalue %ExpressionResult %t20, 2
  %t22 = icmp eq i8* %t21, null
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load %ExpressionResult, %ExpressionResult* %l3
  %t27 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  br i1 %t22, label %then0, label %merge1
then0:
  %t28 = load %ExpressionResult, %ExpressionResult* %l3
  %t29 = extractvalue %ExpressionResult %t28, 0
  %t30 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t29, 0
  %t31 = load %ExpressionResult, %ExpressionResult* %l3
  %t32 = extractvalue %ExpressionResult %t31, 1
  %t33 = insertvalue %ExpressionResult %t30, double %t32, 1
  %t34 = insertvalue %ExpressionResult %t33, i8* null, 2
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = insertvalue %ExpressionResult %t34, { i8**, i64 }* %t35, 3
  %t37 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t38 = insertvalue %ExpressionResult %t36, { i8**, i64 }* null, 4
  ret %ExpressionResult %t38
merge1:
  %t39 = load double, double* %l1
  %t40 = load %ExpressionResult, %ExpressionResult* %l3
  %t41 = extractvalue %ExpressionResult %t40, 1
  %t42 = load %ExpressionResult, %ExpressionResult* %l3
  %t43 = extractvalue %ExpressionResult %t42, 0
  %t44 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t41, { i8**, i64 }* %t43, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t44, %ExpressionResult* %l5
  %t45 = load %ExpressionResult, %ExpressionResult* %l5
  %t46 = extractvalue %ExpressionResult %t45, 3
  %t47 = call double @diagnosticsconcat({ i8**, i64 }* %t46)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t48 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t49 = load %ExpressionResult, %ExpressionResult* %l5
  %t50 = extractvalue %ExpressionResult %t49, 4
  %t51 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t48, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t51, { %StringConstant*, i64 }** %l4
  %t52 = load %ExpressionResult, %ExpressionResult* %l5
  %t53 = extractvalue %ExpressionResult %t52, 2
  %t54 = icmp eq i8* %t53, null
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load %ExpressionResult, %ExpressionResult* %l3
  %t59 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t60 = load %ExpressionResult, %ExpressionResult* %l5
  br i1 %t54, label %then2, label %merge3
then2:
  %t61 = load %ExpressionResult, %ExpressionResult* %l5
  %t62 = extractvalue %ExpressionResult %t61, 0
  %t63 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t62, 0
  %t64 = load %ExpressionResult, %ExpressionResult* %l5
  %t65 = extractvalue %ExpressionResult %t64, 1
  %t66 = insertvalue %ExpressionResult %t63, double %t65, 1
  %t67 = insertvalue %ExpressionResult %t66, i8* null, 2
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = insertvalue %ExpressionResult %t67, { i8**, i64 }* %t68, 3
  %t70 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t71 = insertvalue %ExpressionResult %t69, { i8**, i64 }* null, 4
  ret %ExpressionResult %t71
merge3:
  %t72 = load %ExpressionResult, %ExpressionResult* %l3
  %t73 = extractvalue %ExpressionResult %t72, 2
  %t74 = load %ExpressionResult, %ExpressionResult* %l5
  %t75 = extractvalue %ExpressionResult %t74, 2
  %t76 = load %ExpressionResult, %ExpressionResult* %l5
  %t77 = extractvalue %ExpressionResult %t76, 1
  %t78 = load %ExpressionResult, %ExpressionResult* %l5
  %t79 = extractvalue %ExpressionResult %t78, 0
  %t80 = call %BinaryAlignmentResult @harmonise_operands(%LLVMOperand zeroinitializer, %LLVMOperand zeroinitializer, double %t77, { i8**, i64 }* %t79)
  store %BinaryAlignmentResult %t80, %BinaryAlignmentResult* %l6
  %t81 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t82 = extractvalue %BinaryAlignmentResult %t81, 4
  %t83 = call double @diagnosticsconcat({ i8**, i64 }* %t82)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t85 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t86 = extractvalue %BinaryAlignmentResult %t85, 2
  %t87 = icmp eq i8* %t86, null
  br label %logical_or_entry_84

logical_or_entry_84:
  br i1 %t87, label %logical_or_merge_84, label %logical_or_right_84

logical_or_right_84:
  %t88 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t89 = extractvalue %BinaryAlignmentResult %t88, 3
  %t90 = icmp eq i8* %t89, null
  br label %logical_or_right_end_84

logical_or_right_end_84:
  br label %logical_or_merge_84

logical_or_merge_84:
  %t91 = phi i1 [ true, %logical_or_entry_84 ], [ %t90, %logical_or_right_end_84 ]
  %t92 = load i8*, i8** %l0
  %t93 = load double, double* %l1
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load %ExpressionResult, %ExpressionResult* %l3
  %t96 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t97 = load %ExpressionResult, %ExpressionResult* %l5
  %t98 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  br i1 %t91, label %then4, label %merge5
then4:
  %t99 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t100 = extractvalue %BinaryAlignmentResult %t99, 0
  %t101 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t100, 0
  %t102 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t103 = extractvalue %BinaryAlignmentResult %t102, 1
  %t104 = insertvalue %ExpressionResult %t101, double %t103, 1
  %t105 = insertvalue %ExpressionResult %t104, i8* null, 2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t107 = insertvalue %ExpressionResult %t105, { i8**, i64 }* %t106, 3
  %t108 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l4
  %t109 = insertvalue %ExpressionResult %t107, { i8**, i64 }* null, 4
  ret %ExpressionResult %t109
merge5:
  %t110 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t111 = extractvalue %BinaryAlignmentResult %t110, 2
  store i8* %t111, i8** %l7
  %t112 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t113 = extractvalue %BinaryAlignmentResult %t112, 3
  store i8* %t113, i8** %l8
  %t114 = extractvalue %OperatorMatch %match, 1
  %t115 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t116 = extractvalue %BinaryAlignmentResult %t115, 5
  %t117 = call i8* @operation_name_for_symbol(i8* %t114, i8* %t116)
  store i8* %t117, i8** %l9
  %t118 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t119 = extractvalue %BinaryAlignmentResult %t118, 1
  %t120 = call i8* @format_temp_name(double %t119)
  store i8* %t120, i8** %l10
  %s121 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.121, i32 0, i32 0
  %t122 = load i8*, i8** %l10
  %t123 = add i8* %s121, %t122
  %s124 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.124, i32 0, i32 0
  %t125 = add i8* %t123, %s124
  %t126 = load i8*, i8** %l9
  %t127 = add i8* %t125, %t126
  %s128 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.128, i32 0, i32 0
  %t129 = add i8* %t127, %s128
  %t130 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t131 = extractvalue %BinaryAlignmentResult %t130, 5
  %t132 = add i8* %t129, %t131
  %s133 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.133, i32 0, i32 0
  %t134 = add i8* %t132, %s133
  %t135 = load i8*, i8** %l7
  store double 0.0, double* %l11
  %t136 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t137 = extractvalue %BinaryAlignmentResult %t136, 0
  %t138 = load double, double* %l11
  %t139 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t137, i8* null)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l12
  %t140 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l6
  %t141 = extractvalue %BinaryAlignmentResult %t140, 5
  %t142 = insertvalue %LLVMOperand undef, i8* %t141, 0
  %t143 = load i8*, i8** %l10
  %t144 = insertvalue %LLVMOperand %t142, i8* %t143, 1
  store %LLVMOperand %t144, %LLVMOperand* %l13
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_comparison_operation(i8* %expression, %OperatorMatch %match, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
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
  %t13 = load i8*, i8** %l1
  %t14 = load i8*, i8** %l1
  %t15 = call %ExpressionResult @lower_expression(i8* %t14, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t15, %ExpressionResult* %l4
  %t16 = load %ExpressionResult, %ExpressionResult* %l4
  %t17 = extractvalue %ExpressionResult %t16, 3
  %t18 = call double @diagnosticsconcat({ i8**, i64 }* %t17)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t19 = load %ExpressionResult, %ExpressionResult* %l4
  %t20 = extractvalue %ExpressionResult %t19, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l5
  %t21 = load %ExpressionResult, %ExpressionResult* %l4
  %t22 = extractvalue %ExpressionResult %t21, 2
  %t23 = icmp eq i8* %t22, null
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load %ExpressionResult, %ExpressionResult* %l4
  %t29 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  br i1 %t23, label %then0, label %merge1
then0:
  %t30 = load %ExpressionResult, %ExpressionResult* %l4
  %t31 = extractvalue %ExpressionResult %t30, 0
  %t32 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t31, 0
  %t33 = load %ExpressionResult, %ExpressionResult* %l4
  %t34 = extractvalue %ExpressionResult %t33, 1
  %t35 = insertvalue %ExpressionResult %t32, double %t34, 1
  %t36 = insertvalue %ExpressionResult %t35, i8* null, 2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t38 = insertvalue %ExpressionResult %t36, { i8**, i64 }* %t37, 3
  %t39 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t40 = insertvalue %ExpressionResult %t38, { i8**, i64 }* null, 4
  ret %ExpressionResult %t40
merge1:
  %t41 = load double, double* %l2
  %t42 = load %ExpressionResult, %ExpressionResult* %l4
  %t43 = extractvalue %ExpressionResult %t42, 1
  %t44 = load %ExpressionResult, %ExpressionResult* %l4
  %t45 = extractvalue %ExpressionResult %t44, 0
  %t46 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t43, { i8**, i64 }* %t45, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t46, %ExpressionResult* %l6
  %t47 = load %ExpressionResult, %ExpressionResult* %l6
  %t48 = extractvalue %ExpressionResult %t47, 3
  %t49 = call double @diagnosticsconcat({ i8**, i64 }* %t48)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t50 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t51 = load %ExpressionResult, %ExpressionResult* %l6
  %t52 = extractvalue %ExpressionResult %t51, 4
  %t53 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t50, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t53, { %StringConstant*, i64 }** %l5
  %t54 = load %ExpressionResult, %ExpressionResult* %l6
  %t55 = extractvalue %ExpressionResult %t54, 2
  %t56 = icmp eq i8* %t55, null
  %t57 = load double, double* %l0
  %t58 = load i8*, i8** %l1
  %t59 = load double, double* %l2
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t61 = load %ExpressionResult, %ExpressionResult* %l4
  %t62 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t63 = load %ExpressionResult, %ExpressionResult* %l6
  br i1 %t56, label %then2, label %merge3
then2:
  %t64 = load %ExpressionResult, %ExpressionResult* %l6
  %t65 = extractvalue %ExpressionResult %t64, 0
  %t66 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t65, 0
  %t67 = load %ExpressionResult, %ExpressionResult* %l6
  %t68 = extractvalue %ExpressionResult %t67, 1
  %t69 = insertvalue %ExpressionResult %t66, double %t68, 1
  %t70 = insertvalue %ExpressionResult %t69, i8* null, 2
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t72 = insertvalue %ExpressionResult %t70, { i8**, i64 }* %t71, 3
  %t73 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t74 = insertvalue %ExpressionResult %t72, { i8**, i64 }* null, 4
  ret %ExpressionResult %t74
merge3:
  %t75 = load %ExpressionResult, %ExpressionResult* %l4
  %t76 = extractvalue %ExpressionResult %t75, 2
  %t77 = load %ExpressionResult, %ExpressionResult* %l6
  %t78 = extractvalue %ExpressionResult %t77, 2
  %t79 = load %ExpressionResult, %ExpressionResult* %l6
  %t80 = extractvalue %ExpressionResult %t79, 1
  %t81 = load %ExpressionResult, %ExpressionResult* %l6
  %t82 = extractvalue %ExpressionResult %t81, 0
  %t83 = call %BinaryAlignmentResult @harmonise_operands(%LLVMOperand zeroinitializer, %LLVMOperand zeroinitializer, double %t80, { i8**, i64 }* %t82)
  store %BinaryAlignmentResult %t83, %BinaryAlignmentResult* %l7
  %t84 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t85 = extractvalue %BinaryAlignmentResult %t84, 4
  %t86 = call double @diagnosticsconcat({ i8**, i64 }* %t85)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t88 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t89 = extractvalue %BinaryAlignmentResult %t88, 2
  %t90 = icmp eq i8* %t89, null
  br label %logical_or_entry_87

logical_or_entry_87:
  br i1 %t90, label %logical_or_merge_87, label %logical_or_right_87

logical_or_right_87:
  %t91 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t92 = extractvalue %BinaryAlignmentResult %t91, 3
  %t93 = icmp eq i8* %t92, null
  br label %logical_or_right_end_87

logical_or_right_end_87:
  br label %logical_or_merge_87

logical_or_merge_87:
  %t94 = phi i1 [ true, %logical_or_entry_87 ], [ %t93, %logical_or_right_end_87 ]
  %t95 = load double, double* %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t99 = load %ExpressionResult, %ExpressionResult* %l4
  %t100 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t101 = load %ExpressionResult, %ExpressionResult* %l6
  %t102 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  br i1 %t94, label %then4, label %merge5
then4:
  %t103 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t104 = extractvalue %BinaryAlignmentResult %t103, 0
  %t105 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t104, 0
  %t106 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t107 = extractvalue %BinaryAlignmentResult %t106, 1
  %t108 = insertvalue %ExpressionResult %t105, double %t107, 1
  %t109 = insertvalue %ExpressionResult %t108, i8* null, 2
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t111 = insertvalue %ExpressionResult %t109, { i8**, i64 }* %t110, 3
  %t112 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t113 = insertvalue %ExpressionResult %t111, { i8**, i64 }* null, 4
  ret %ExpressionResult %t113
merge5:
  %t114 = extractvalue %OperatorMatch %match, 1
  %t115 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t116 = extractvalue %BinaryAlignmentResult %t115, 2
  %t117 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t118 = extractvalue %BinaryAlignmentResult %t117, 3
  %t119 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t120 = extractvalue %BinaryAlignmentResult %t119, 1
  %t121 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t122 = extractvalue %BinaryAlignmentResult %t121, 0
  %t123 = call %ComparisonEmission @emit_comparison_instruction(i8* %t114, %LLVMOperand zeroinitializer, %LLVMOperand zeroinitializer, double %t120, { i8**, i64 }* %t122)
  store %ComparisonEmission %t123, %ComparisonEmission* %l8
  %t124 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t125 = extractvalue %ComparisonEmission %t124, 3
  %t126 = call double @diagnosticsconcat({ i8**, i64 }* %t125)
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t127 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t128 = extractvalue %ComparisonEmission %t127, 2
  %t129 = icmp eq i8* %t128, null
  %t130 = load double, double* %l0
  %t131 = load i8*, i8** %l1
  %t132 = load double, double* %l2
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t134 = load %ExpressionResult, %ExpressionResult* %l4
  %t135 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t136 = load %ExpressionResult, %ExpressionResult* %l6
  %t137 = load %BinaryAlignmentResult, %BinaryAlignmentResult* %l7
  %t138 = load %ComparisonEmission, %ComparisonEmission* %l8
  br i1 %t129, label %then6, label %merge7
then6:
  %t139 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t140 = extractvalue %ComparisonEmission %t139, 0
  %t141 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t140, 0
  %t142 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t143 = extractvalue %ComparisonEmission %t142, 1
  %t144 = insertvalue %ExpressionResult %t141, double %t143, 1
  %t145 = insertvalue %ExpressionResult %t144, i8* null, 2
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t147 = insertvalue %ExpressionResult %t145, { i8**, i64 }* %t146, 3
  %t148 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t149 = insertvalue %ExpressionResult %t147, { i8**, i64 }* null, 4
  ret %ExpressionResult %t149
merge7:
  %t150 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t151 = extractvalue %ComparisonEmission %t150, 0
  %t152 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t151, 0
  %t153 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t154 = extractvalue %ComparisonEmission %t153, 1
  %t155 = insertvalue %ExpressionResult %t152, double %t154, 1
  %t156 = load %ComparisonEmission, %ComparisonEmission* %l8
  %t157 = extractvalue %ComparisonEmission %t156, 2
  %t158 = insertvalue %ExpressionResult %t155, i8* %t157, 2
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t160 = insertvalue %ExpressionResult %t158, { i8**, i64 }* %t159, 3
  %t161 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l5
  %t162 = insertvalue %ExpressionResult %t160, { i8**, i64 }* null, 4
  ret %ExpressionResult %t162
}

define %ExpressionResult @lower_logical_and(i8* %expression, %OperatorMatch %match, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %StringConstant*, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca %ExpressionResult
  %l11 = alloca %CoercionResult
  %l12 = alloca { i8**, i64 }*
  %l13 = alloca %ExpressionResult
  %l14 = alloca %CoercionResult
  %l15 = alloca i8*
  %l16 = alloca %LLVMOperand
  %t0 = extractvalue %OperatorMatch %match, 0
  %t1 = call double @substring(i8* %expression, i64 0, double %t0)
  %t2 = call i8* @trim_text(i8* null)
  store i8* %t2, i8** %l0
  %t3 = extractvalue %OperatorMatch %match, 0
  %t4 = sitofp i64 2 to double
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
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l3
  %t17 = load i8*, i8** %l0
  %t18 = call i8* @number_to_string(double %temp_index)
  store i8* %t18, i8** %l4
  %s19 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.19, i32 0, i32 0
  %t20 = load i8*, i8** %l4
  %t21 = add i8* %s19, %t20
  store i8* %t21, i8** %l5
  %s22 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.22, i32 0, i32 0
  %t23 = load i8*, i8** %l4
  %t24 = add i8* %s22, %t23
  store i8* %t24, i8** %l6
  %s25 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.25, i32 0, i32 0
  %t26 = load i8*, i8** %l4
  %t27 = add i8* %s25, %t26
  store i8* %t27, i8** %l7
  %s28 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.28, i32 0, i32 0
  %t29 = load i8*, i8** %l4
  %t30 = add i8* %s28, %t29
  store i8* %t30, i8** %l8
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %temp_index, %t31
  store double %t32, double* %l9
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l9
  %t35 = call %ExpressionResult @lower_expression(i8* %t33, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t34, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t35, %ExpressionResult* %l10
  %t36 = load %ExpressionResult, %ExpressionResult* %l10
  %t37 = extractvalue %ExpressionResult %t36, 3
  %t38 = call double @diagnosticsconcat({ i8**, i64 }* %t37)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t39 = load %ExpressionResult, %ExpressionResult* %l10
  %t40 = extractvalue %ExpressionResult %t39, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l3
  %t41 = load %ExpressionResult, %ExpressionResult* %l10
  %t42 = extractvalue %ExpressionResult %t41, 2
  %t43 = icmp eq i8* %t42, null
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t47 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t48 = load i8*, i8** %l4
  %t49 = load i8*, i8** %l5
  %t50 = load i8*, i8** %l6
  %t51 = load i8*, i8** %l7
  %t52 = load i8*, i8** %l8
  %t53 = load double, double* %l9
  %t54 = load %ExpressionResult, %ExpressionResult* %l10
  br i1 %t43, label %then0, label %merge1
then0:
  %t55 = load %ExpressionResult, %ExpressionResult* %l10
  %t56 = extractvalue %ExpressionResult %t55, 0
  %t57 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t56, 0
  %t58 = load %ExpressionResult, %ExpressionResult* %l10
  %t59 = extractvalue %ExpressionResult %t58, 1
  %t60 = insertvalue %ExpressionResult %t57, double %t59, 1
  %t61 = insertvalue %ExpressionResult %t60, i8* null, 2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t63 = insertvalue %ExpressionResult %t61, { i8**, i64 }* %t62, 3
  %t64 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t65 = insertvalue %ExpressionResult %t63, { i8**, i64 }* null, 4
  ret %ExpressionResult %t65
merge1:
  %t66 = load %ExpressionResult, %ExpressionResult* %l10
  %t67 = extractvalue %ExpressionResult %t66, 2
  %s68 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.68, i32 0, i32 0
  %t69 = load %ExpressionResult, %ExpressionResult* %l10
  %t70 = extractvalue %ExpressionResult %t69, 1
  %t71 = load %ExpressionResult, %ExpressionResult* %l10
  %t72 = extractvalue %ExpressionResult %t71, 0
  %t73 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %s68, double %t70, { i8**, i64 }* %t72)
  store %CoercionResult %t73, %CoercionResult* %l11
  %t74 = load %CoercionResult, %CoercionResult* %l11
  %t75 = extractvalue %CoercionResult %t74, 3
  %t76 = call double @diagnosticsconcat({ i8**, i64 }* %t75)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t77 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t78 = load %ExpressionResult, %ExpressionResult* %l10
  %t79 = extractvalue %ExpressionResult %t78, 4
  %t80 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t77, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t80, { %StringConstant*, i64 }** %l3
  %t81 = load %CoercionResult, %CoercionResult* %l11
  %t82 = extractvalue %CoercionResult %t81, 2
  %t83 = icmp eq i8* %t82, null
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t88 = load i8*, i8** %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  %t91 = load i8*, i8** %l7
  %t92 = load i8*, i8** %l8
  %t93 = load double, double* %l9
  %t94 = load %ExpressionResult, %ExpressionResult* %l10
  %t95 = load %CoercionResult, %CoercionResult* %l11
  br i1 %t83, label %then2, label %merge3
then2:
  %t96 = load %CoercionResult, %CoercionResult* %l11
  %t97 = extractvalue %CoercionResult %t96, 0
  %t98 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t97, 0
  %t99 = load %CoercionResult, %CoercionResult* %l11
  %t100 = extractvalue %CoercionResult %t99, 1
  %t101 = insertvalue %ExpressionResult %t98, double %t100, 1
  %t102 = insertvalue %ExpressionResult %t101, i8* null, 2
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t104 = insertvalue %ExpressionResult %t102, { i8**, i64 }* %t103, 3
  %t105 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t106 = insertvalue %ExpressionResult %t104, { i8**, i64 }* null, 4
  ret %ExpressionResult %t106
merge3:
  %t107 = load %CoercionResult, %CoercionResult* %l11
  %t108 = extractvalue %CoercionResult %t107, 0
  store { i8**, i64 }* %t108, { i8**, i64 }** %l12
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s110 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.110, i32 0, i32 0
  %t111 = load i8*, i8** %l5
  %t112 = add i8* %s110, %t111
  %t113 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t109, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l12
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s115 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.115, i32 0, i32 0
  %t116 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t114, i8* %s115)
  store { i8**, i64 }* %t116, { i8**, i64 }** %l12
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t118 = load i8*, i8** %l5
  %s119 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.119, i32 0, i32 0
  %t120 = add i8* %t118, %s119
  %t121 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t117, i8* %t120)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l12
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s123 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.123, i32 0, i32 0
  %t124 = load %CoercionResult, %CoercionResult* %l11
  %t125 = extractvalue %CoercionResult %t124, 2
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s127 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.127, i32 0, i32 0
  %t128 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t126, i8* %s127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l12
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t130 = load i8*, i8** %l6
  %s131 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.131, i32 0, i32 0
  %t132 = add i8* %t130, %s131
  %t133 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t129, i8* %t132)
  store { i8**, i64 }* %t133, { i8**, i64 }** %l12
  %t134 = load double, double* %l1
  %t135 = load %CoercionResult, %CoercionResult* %l11
  %t136 = extractvalue %CoercionResult %t135, 1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t138 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t136, { i8**, i64 }* %t137, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t138, %ExpressionResult* %l13
  %t139 = load %ExpressionResult, %ExpressionResult* %l13
  %t140 = extractvalue %ExpressionResult %t139, 3
  %t141 = call double @diagnosticsconcat({ i8**, i64 }* %t140)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t142 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t143 = load %ExpressionResult, %ExpressionResult* %l13
  %t144 = extractvalue %ExpressionResult %t143, 4
  %t145 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t142, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t145, { %StringConstant*, i64 }** %l3
  %t146 = load %ExpressionResult, %ExpressionResult* %l13
  %t147 = extractvalue %ExpressionResult %t146, 2
  %t148 = icmp eq i8* %t147, null
  %t149 = load i8*, i8** %l0
  %t150 = load double, double* %l1
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t152 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t153 = load i8*, i8** %l4
  %t154 = load i8*, i8** %l5
  %t155 = load i8*, i8** %l6
  %t156 = load i8*, i8** %l7
  %t157 = load i8*, i8** %l8
  %t158 = load double, double* %l9
  %t159 = load %ExpressionResult, %ExpressionResult* %l10
  %t160 = load %CoercionResult, %CoercionResult* %l11
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t162 = load %ExpressionResult, %ExpressionResult* %l13
  br i1 %t148, label %then4, label %merge5
then4:
  %t163 = load %ExpressionResult, %ExpressionResult* %l13
  %t164 = extractvalue %ExpressionResult %t163, 0
  %t165 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t164, 0
  %t166 = load %ExpressionResult, %ExpressionResult* %l13
  %t167 = extractvalue %ExpressionResult %t166, 1
  %t168 = insertvalue %ExpressionResult %t165, double %t167, 1
  %t169 = insertvalue %ExpressionResult %t168, i8* null, 2
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t171 = insertvalue %ExpressionResult %t169, { i8**, i64 }* %t170, 3
  %t172 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t173 = insertvalue %ExpressionResult %t171, { i8**, i64 }* null, 4
  ret %ExpressionResult %t173
merge5:
  %t174 = load %ExpressionResult, %ExpressionResult* %l13
  %t175 = extractvalue %ExpressionResult %t174, 2
  %s176 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.176, i32 0, i32 0
  %t177 = load %ExpressionResult, %ExpressionResult* %l13
  %t178 = extractvalue %ExpressionResult %t177, 1
  %t179 = load %ExpressionResult, %ExpressionResult* %l13
  %t180 = extractvalue %ExpressionResult %t179, 0
  %t181 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %s176, double %t178, { i8**, i64 }* %t180)
  store %CoercionResult %t181, %CoercionResult* %l14
  %t182 = load %CoercionResult, %CoercionResult* %l14
  %t183 = extractvalue %CoercionResult %t182, 3
  %t184 = call double @diagnosticsconcat({ i8**, i64 }* %t183)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t185 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t186 = load %ExpressionResult, %ExpressionResult* %l13
  %t187 = extractvalue %ExpressionResult %t186, 4
  %t188 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t185, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t188, { %StringConstant*, i64 }** %l3
  %t189 = load %CoercionResult, %CoercionResult* %l14
  %t190 = extractvalue %CoercionResult %t189, 2
  %t191 = icmp eq i8* %t190, null
  %t192 = load i8*, i8** %l0
  %t193 = load double, double* %l1
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t195 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t196 = load i8*, i8** %l4
  %t197 = load i8*, i8** %l5
  %t198 = load i8*, i8** %l6
  %t199 = load i8*, i8** %l7
  %t200 = load i8*, i8** %l8
  %t201 = load double, double* %l9
  %t202 = load %ExpressionResult, %ExpressionResult* %l10
  %t203 = load %CoercionResult, %CoercionResult* %l11
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t205 = load %ExpressionResult, %ExpressionResult* %l13
  %t206 = load %CoercionResult, %CoercionResult* %l14
  br i1 %t191, label %then6, label %merge7
then6:
  %t207 = load %CoercionResult, %CoercionResult* %l14
  %t208 = extractvalue %CoercionResult %t207, 0
  %t209 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t208, 0
  %t210 = load %CoercionResult, %CoercionResult* %l14
  %t211 = extractvalue %CoercionResult %t210, 1
  %t212 = insertvalue %ExpressionResult %t209, double %t211, 1
  %t213 = insertvalue %ExpressionResult %t212, i8* null, 2
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t215 = insertvalue %ExpressionResult %t213, { i8**, i64 }* %t214, 3
  %t216 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t217 = insertvalue %ExpressionResult %t215, { i8**, i64 }* null, 4
  ret %ExpressionResult %t217
merge7:
  %t218 = load %CoercionResult, %CoercionResult* %l14
  %t219 = extractvalue %CoercionResult %t218, 0
  store { i8**, i64 }* %t219, { i8**, i64 }** %l12
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s221 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.221, i32 0, i32 0
  %t222 = load i8*, i8** %l7
  %t223 = add i8* %s221, %t222
  %t224 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t220, i8* %t223)
  store { i8**, i64 }* %t224, { i8**, i64 }** %l12
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s226 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.226, i32 0, i32 0
  %t227 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t225, i8* %s226)
  store { i8**, i64 }* %t227, { i8**, i64 }** %l12
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t229 = load i8*, i8** %l7
  %s230 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.230, i32 0, i32 0
  %t231 = add i8* %t229, %s230
  %t232 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t228, i8* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l12
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s234 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.234, i32 0, i32 0
  %t235 = load i8*, i8** %l8
  %t236 = add i8* %s234, %t235
  %t237 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t233, i8* %t236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l12
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s239 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.239, i32 0, i32 0
  %t240 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t238, i8* %s239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l12
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t242 = load i8*, i8** %l8
  %s243 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.243, i32 0, i32 0
  %t244 = add i8* %t242, %s243
  %t245 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t241, i8* %t244)
  store { i8**, i64 }* %t245, { i8**, i64 }** %l12
  %t246 = load %CoercionResult, %CoercionResult* %l14
  %t247 = extractvalue %CoercionResult %t246, 1
  %t248 = call i8* @format_temp_name(double %t247)
  store i8* %t248, i8** %l15
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s250 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.250, i32 0, i32 0
  %t251 = load i8*, i8** %l15
  %t252 = add i8* %s250, %t251
  %s253 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  %t255 = load i8*, i8** %l5
  %t256 = add i8* %t254, %t255
  %s257 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.257, i32 0, i32 0
  %t258 = insertvalue %LLVMOperand undef, i8* %s257, 0
  %t259 = load i8*, i8** %l15
  %t260 = insertvalue %LLVMOperand %t258, i8* %t259, 1
  store %LLVMOperand %t260, %LLVMOperand* %l16
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_logical_or(i8* %expression, %OperatorMatch %match, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { %StringConstant*, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca %ExpressionResult
  %l11 = alloca %CoercionResult
  %l12 = alloca { i8**, i64 }*
  %l13 = alloca %ExpressionResult
  %l14 = alloca %CoercionResult
  %l15 = alloca i8*
  %l16 = alloca %LLVMOperand
  %t0 = extractvalue %OperatorMatch %match, 0
  %t1 = call double @substring(i8* %expression, i64 0, double %t0)
  %t2 = call i8* @trim_text(i8* null)
  store i8* %t2, i8** %l0
  %t3 = extractvalue %OperatorMatch %match, 0
  %t4 = sitofp i64 2 to double
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
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l3
  %t17 = load i8*, i8** %l0
  %t18 = call i8* @number_to_string(double %temp_index)
  store i8* %t18, i8** %l4
  %s19 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.19, i32 0, i32 0
  %t20 = load i8*, i8** %l4
  %t21 = add i8* %s19, %t20
  store i8* %t21, i8** %l5
  %s22 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.22, i32 0, i32 0
  %t23 = load i8*, i8** %l4
  %t24 = add i8* %s22, %t23
  store i8* %t24, i8** %l6
  %s25 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.25, i32 0, i32 0
  %t26 = load i8*, i8** %l4
  %t27 = add i8* %s25, %t26
  store i8* %t27, i8** %l7
  %s28 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.28, i32 0, i32 0
  %t29 = load i8*, i8** %l4
  %t30 = add i8* %s28, %t29
  store i8* %t30, i8** %l8
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %temp_index, %t31
  store double %t32, double* %l9
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l9
  %t35 = call %ExpressionResult @lower_expression(i8* %t33, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t34, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t35, %ExpressionResult* %l10
  %t36 = load %ExpressionResult, %ExpressionResult* %l10
  %t37 = extractvalue %ExpressionResult %t36, 3
  %t38 = call double @diagnosticsconcat({ i8**, i64 }* %t37)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t39 = load %ExpressionResult, %ExpressionResult* %l10
  %t40 = extractvalue %ExpressionResult %t39, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l3
  %t41 = load %ExpressionResult, %ExpressionResult* %l10
  %t42 = extractvalue %ExpressionResult %t41, 2
  %t43 = icmp eq i8* %t42, null
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t47 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t48 = load i8*, i8** %l4
  %t49 = load i8*, i8** %l5
  %t50 = load i8*, i8** %l6
  %t51 = load i8*, i8** %l7
  %t52 = load i8*, i8** %l8
  %t53 = load double, double* %l9
  %t54 = load %ExpressionResult, %ExpressionResult* %l10
  br i1 %t43, label %then0, label %merge1
then0:
  %t55 = load %ExpressionResult, %ExpressionResult* %l10
  %t56 = extractvalue %ExpressionResult %t55, 0
  %t57 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t56, 0
  %t58 = load %ExpressionResult, %ExpressionResult* %l10
  %t59 = extractvalue %ExpressionResult %t58, 1
  %t60 = insertvalue %ExpressionResult %t57, double %t59, 1
  %t61 = insertvalue %ExpressionResult %t60, i8* null, 2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t63 = insertvalue %ExpressionResult %t61, { i8**, i64 }* %t62, 3
  %t64 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t65 = insertvalue %ExpressionResult %t63, { i8**, i64 }* null, 4
  ret %ExpressionResult %t65
merge1:
  %t66 = load %ExpressionResult, %ExpressionResult* %l10
  %t67 = extractvalue %ExpressionResult %t66, 2
  %s68 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.68, i32 0, i32 0
  %t69 = load %ExpressionResult, %ExpressionResult* %l10
  %t70 = extractvalue %ExpressionResult %t69, 1
  %t71 = load %ExpressionResult, %ExpressionResult* %l10
  %t72 = extractvalue %ExpressionResult %t71, 0
  %t73 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %s68, double %t70, { i8**, i64 }* %t72)
  store %CoercionResult %t73, %CoercionResult* %l11
  %t74 = load %CoercionResult, %CoercionResult* %l11
  %t75 = extractvalue %CoercionResult %t74, 3
  %t76 = call double @diagnosticsconcat({ i8**, i64 }* %t75)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t77 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t78 = load %ExpressionResult, %ExpressionResult* %l10
  %t79 = extractvalue %ExpressionResult %t78, 4
  %t80 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t77, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t80, { %StringConstant*, i64 }** %l3
  %t81 = load %CoercionResult, %CoercionResult* %l11
  %t82 = extractvalue %CoercionResult %t81, 2
  %t83 = icmp eq i8* %t82, null
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t88 = load i8*, i8** %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  %t91 = load i8*, i8** %l7
  %t92 = load i8*, i8** %l8
  %t93 = load double, double* %l9
  %t94 = load %ExpressionResult, %ExpressionResult* %l10
  %t95 = load %CoercionResult, %CoercionResult* %l11
  br i1 %t83, label %then2, label %merge3
then2:
  %t96 = load %CoercionResult, %CoercionResult* %l11
  %t97 = extractvalue %CoercionResult %t96, 0
  %t98 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t97, 0
  %t99 = load %CoercionResult, %CoercionResult* %l11
  %t100 = extractvalue %CoercionResult %t99, 1
  %t101 = insertvalue %ExpressionResult %t98, double %t100, 1
  %t102 = insertvalue %ExpressionResult %t101, i8* null, 2
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t104 = insertvalue %ExpressionResult %t102, { i8**, i64 }* %t103, 3
  %t105 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t106 = insertvalue %ExpressionResult %t104, { i8**, i64 }* null, 4
  ret %ExpressionResult %t106
merge3:
  %t107 = load %CoercionResult, %CoercionResult* %l11
  %t108 = extractvalue %CoercionResult %t107, 0
  store { i8**, i64 }* %t108, { i8**, i64 }** %l12
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s110 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.110, i32 0, i32 0
  %t111 = load i8*, i8** %l5
  %t112 = add i8* %s110, %t111
  %t113 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t109, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l12
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s115 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.115, i32 0, i32 0
  %t116 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t114, i8* %s115)
  store { i8**, i64 }* %t116, { i8**, i64 }** %l12
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t118 = load i8*, i8** %l5
  %s119 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.119, i32 0, i32 0
  %t120 = add i8* %t118, %s119
  %t121 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t117, i8* %t120)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l12
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s123 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.123, i32 0, i32 0
  %t124 = load %CoercionResult, %CoercionResult* %l11
  %t125 = extractvalue %CoercionResult %t124, 2
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s127 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.127, i32 0, i32 0
  %t128 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t126, i8* %s127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l12
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t130 = load i8*, i8** %l6
  %s131 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.131, i32 0, i32 0
  %t132 = add i8* %t130, %s131
  %t133 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t129, i8* %t132)
  store { i8**, i64 }* %t133, { i8**, i64 }** %l12
  %t134 = load double, double* %l1
  %t135 = load %CoercionResult, %CoercionResult* %l11
  %t136 = extractvalue %CoercionResult %t135, 1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t138 = call %ExpressionResult @lower_expression(i8* null, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t136, { i8**, i64 }* %t137, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t138, %ExpressionResult* %l13
  %t139 = load %ExpressionResult, %ExpressionResult* %l13
  %t140 = extractvalue %ExpressionResult %t139, 3
  %t141 = call double @diagnosticsconcat({ i8**, i64 }* %t140)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t142 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t143 = load %ExpressionResult, %ExpressionResult* %l13
  %t144 = extractvalue %ExpressionResult %t143, 4
  %t145 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t142, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t145, { %StringConstant*, i64 }** %l3
  %t146 = load %ExpressionResult, %ExpressionResult* %l13
  %t147 = extractvalue %ExpressionResult %t146, 2
  %t148 = icmp eq i8* %t147, null
  %t149 = load i8*, i8** %l0
  %t150 = load double, double* %l1
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t152 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t153 = load i8*, i8** %l4
  %t154 = load i8*, i8** %l5
  %t155 = load i8*, i8** %l6
  %t156 = load i8*, i8** %l7
  %t157 = load i8*, i8** %l8
  %t158 = load double, double* %l9
  %t159 = load %ExpressionResult, %ExpressionResult* %l10
  %t160 = load %CoercionResult, %CoercionResult* %l11
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t162 = load %ExpressionResult, %ExpressionResult* %l13
  br i1 %t148, label %then4, label %merge5
then4:
  %t163 = load %ExpressionResult, %ExpressionResult* %l13
  %t164 = extractvalue %ExpressionResult %t163, 0
  %t165 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t164, 0
  %t166 = load %ExpressionResult, %ExpressionResult* %l13
  %t167 = extractvalue %ExpressionResult %t166, 1
  %t168 = insertvalue %ExpressionResult %t165, double %t167, 1
  %t169 = insertvalue %ExpressionResult %t168, i8* null, 2
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t171 = insertvalue %ExpressionResult %t169, { i8**, i64 }* %t170, 3
  %t172 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t173 = insertvalue %ExpressionResult %t171, { i8**, i64 }* null, 4
  ret %ExpressionResult %t173
merge5:
  %t174 = load %ExpressionResult, %ExpressionResult* %l13
  %t175 = extractvalue %ExpressionResult %t174, 2
  %s176 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.176, i32 0, i32 0
  %t177 = load %ExpressionResult, %ExpressionResult* %l13
  %t178 = extractvalue %ExpressionResult %t177, 1
  %t179 = load %ExpressionResult, %ExpressionResult* %l13
  %t180 = extractvalue %ExpressionResult %t179, 0
  %t181 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand zeroinitializer, i8* %s176, double %t178, { i8**, i64 }* %t180)
  store %CoercionResult %t181, %CoercionResult* %l14
  %t182 = load %CoercionResult, %CoercionResult* %l14
  %t183 = extractvalue %CoercionResult %t182, 3
  %t184 = call double @diagnosticsconcat({ i8**, i64 }* %t183)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t185 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t186 = load %ExpressionResult, %ExpressionResult* %l13
  %t187 = extractvalue %ExpressionResult %t186, 4
  %t188 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t185, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t188, { %StringConstant*, i64 }** %l3
  %t189 = load %CoercionResult, %CoercionResult* %l14
  %t190 = extractvalue %CoercionResult %t189, 2
  %t191 = icmp eq i8* %t190, null
  %t192 = load i8*, i8** %l0
  %t193 = load double, double* %l1
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t195 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t196 = load i8*, i8** %l4
  %t197 = load i8*, i8** %l5
  %t198 = load i8*, i8** %l6
  %t199 = load i8*, i8** %l7
  %t200 = load i8*, i8** %l8
  %t201 = load double, double* %l9
  %t202 = load %ExpressionResult, %ExpressionResult* %l10
  %t203 = load %CoercionResult, %CoercionResult* %l11
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t205 = load %ExpressionResult, %ExpressionResult* %l13
  %t206 = load %CoercionResult, %CoercionResult* %l14
  br i1 %t191, label %then6, label %merge7
then6:
  %t207 = load %CoercionResult, %CoercionResult* %l14
  %t208 = extractvalue %CoercionResult %t207, 0
  %t209 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t208, 0
  %t210 = load %CoercionResult, %CoercionResult* %l14
  %t211 = extractvalue %CoercionResult %t210, 1
  %t212 = insertvalue %ExpressionResult %t209, double %t211, 1
  %t213 = insertvalue %ExpressionResult %t212, i8* null, 2
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t215 = insertvalue %ExpressionResult %t213, { i8**, i64 }* %t214, 3
  %t216 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t217 = insertvalue %ExpressionResult %t215, { i8**, i64 }* null, 4
  ret %ExpressionResult %t217
merge7:
  %t218 = load %CoercionResult, %CoercionResult* %l14
  %t219 = extractvalue %CoercionResult %t218, 0
  store { i8**, i64 }* %t219, { i8**, i64 }** %l12
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s221 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.221, i32 0, i32 0
  %t222 = load i8*, i8** %l7
  %t223 = add i8* %s221, %t222
  %t224 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t220, i8* %t223)
  store { i8**, i64 }* %t224, { i8**, i64 }** %l12
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s226 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.226, i32 0, i32 0
  %t227 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t225, i8* %s226)
  store { i8**, i64 }* %t227, { i8**, i64 }** %l12
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t229 = load i8*, i8** %l7
  %s230 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.230, i32 0, i32 0
  %t231 = add i8* %t229, %s230
  %t232 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t228, i8* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l12
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s234 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.234, i32 0, i32 0
  %t235 = load i8*, i8** %l8
  %t236 = add i8* %s234, %t235
  %t237 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t233, i8* %t236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l12
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s239 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.239, i32 0, i32 0
  %t240 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t238, i8* %s239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l12
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %t242 = load i8*, i8** %l8
  %s243 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.243, i32 0, i32 0
  %t244 = add i8* %t242, %s243
  %t245 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t241, i8* %t244)
  store { i8**, i64 }* %t245, { i8**, i64 }** %l12
  %t246 = load %CoercionResult, %CoercionResult* %l14
  %t247 = extractvalue %CoercionResult %t246, 1
  %t248 = call i8* @format_temp_name(double %t247)
  store i8* %t248, i8** %l15
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l12
  %s250 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.250, i32 0, i32 0
  %t251 = load i8*, i8** %l15
  %t252 = add i8* %s250, %t251
  %s253 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  %t255 = load i8*, i8** %l5
  %t256 = add i8* %t254, %t255
  %s257 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.257, i32 0, i32 0
  %t258 = insertvalue %LLVMOperand undef, i8* %s257, 0
  %t259 = load i8*, i8** %l15
  %t260 = insertvalue %LLVMOperand %t258, i8* %t259, 1
  store %LLVMOperand %t260, %LLVMOperand* %l16
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_call_expression(i8* %target, { i8**, i64 }* %arguments, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %StringConstant*, i64 }*
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca { %LLVMOperand*, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %MemberAccessParse
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca %ExpressionResult
  %l14 = alloca i8*
  %l15 = alloca { %LLVMOperand*, i64 }*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca i8*
  %l19 = alloca { i8**, i64 }*
  %l20 = alloca i1
  %l21 = alloca double
  %l22 = alloca double
  %l23 = alloca { %LLVMOperand*, i64 }*
  %l24 = alloca %LLVMOperand
  %l25 = alloca i8*
  %l26 = alloca { i8**, i64 }*
  %l27 = alloca double
  %l28 = alloca i8*
  %l29 = alloca i8*
  %l30 = alloca i8*
  %l31 = alloca i8*
  %l32 = alloca %LLVMOperand
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
  store i8* null, i8** %l7
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
  %t29 = load i8*, i8** %l7
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
  %t46 = load i8*, i8** %l7
  %t47 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t48 = load double, double* %l11
  br label %loop.header2
loop.header2:
  %t130 = phi { i8**, i64 }* [ %t39, %entry ], [ %t124, %loop.latch4 ]
  %t131 = phi { %StringConstant*, i64 }* [ %t40, %entry ], [ %t125, %loop.latch4 ]
  %t132 = phi { i8**, i64 }* [ %t42, %entry ], [ %t126, %loop.latch4 ]
  %t133 = phi double [ %t43, %entry ], [ %t127, %loop.latch4 ]
  %t134 = phi { %LLVMOperand*, i64 }* [ %t44, %entry ], [ %t128, %loop.latch4 ]
  %t135 = phi double [ %t48, %entry ], [ %t129, %loop.latch4 ]
  store { i8**, i64 }* %t130, { i8**, i64 }** %l0
  store { %StringConstant*, i64 }* %t131, { %StringConstant*, i64 }** %l1
  store { i8**, i64 }* %t132, { i8**, i64 }** %l3
  store double %t133, double* %l4
  store { %LLVMOperand*, i64 }* %t134, { %LLVMOperand*, i64 }** %l5
  store double %t135, double* %l11
  br label %loop.body3
loop.body3:
  %t49 = load double, double* %l11
  %t50 = load { i8**, i64 }, { i8**, i64 }* %arguments
  %t51 = extractvalue { i8**, i64 } %t50, 1
  %t52 = sitofp i64 %t51 to double
  %t53 = fcmp oge double %t49, %t52
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t56 = load i8*, i8** %l2
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t58 = load double, double* %l4
  %t59 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t60 = load double, double* %l6
  %t61 = load i8*, i8** %l7
  %t62 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t63 = load double, double* %l11
  br i1 %t53, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t64 = load double, double* %l11
  %t65 = load { i8**, i64 }, { i8**, i64 }* %arguments
  %t66 = extractvalue { i8**, i64 } %t65, 0
  %t67 = extractvalue { i8**, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  %t69 = getelementptr i8*, i8** %t66, i64 %t64
  %t70 = load i8*, i8** %t69
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l12
  %t72 = load i8*, i8** %l12
  %t73 = load i8*, i8** %l12
  %t74 = load double, double* %l4
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t76 = call %ExpressionResult @lower_expression(i8* %t73, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t74, { i8**, i64 }* %t75, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t76, %ExpressionResult* %l13
  %t77 = load %ExpressionResult, %ExpressionResult* %l13
  %t78 = extractvalue %ExpressionResult %t77, 3
  %t79 = call double @diagnosticsconcat({ i8**, i64 }* %t78)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t80 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t81 = load %ExpressionResult, %ExpressionResult* %l13
  %t82 = extractvalue %ExpressionResult %t81, 4
  %t83 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t80, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t83, { %StringConstant*, i64 }** %l1
  %t84 = load %ExpressionResult, %ExpressionResult* %l13
  %t85 = extractvalue %ExpressionResult %t84, 0
  store { i8**, i64 }* %t85, { i8**, i64 }** %l3
  %t86 = load %ExpressionResult, %ExpressionResult* %l13
  %t87 = extractvalue %ExpressionResult %t86, 1
  store double %t87, double* %l4
  %t88 = load %ExpressionResult, %ExpressionResult* %l13
  %t89 = extractvalue %ExpressionResult %t88, 2
  %t90 = icmp ne i8* %t89, null
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t93 = load i8*, i8** %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t95 = load double, double* %l4
  %t96 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t97 = load double, double* %l6
  %t98 = load i8*, i8** %l7
  %t99 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t100 = load double, double* %l11
  %t101 = load i8*, i8** %l12
  %t102 = load %ExpressionResult, %ExpressionResult* %l13
  br i1 %t90, label %then8, label %else9
then8:
  %t103 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t104 = load %ExpressionResult, %ExpressionResult* %l13
  %t105 = extractvalue %ExpressionResult %t104, 2
  %t106 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t103, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t106, { %LLVMOperand*, i64 }** %l5
  br label %merge10
else9:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s108 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.108, i32 0, i32 0
  %t109 = load double, double* %l11
  %t110 = call i8* @number_to_string(double %t109)
  %t111 = add i8* %s108, %t110
  %s112 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.112, i32 0, i32 0
  %t113 = add i8* %t111, %s112
  %t114 = load i8*, i8** %l2
  %t115 = add i8* %t113, %t114
  %s116 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.116, i32 0, i32 0
  %t117 = add i8* %t115, %s116
  %t118 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t107, i8* %t117)
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t119 = phi { %LLVMOperand*, i64 }* [ %t106, %then8 ], [ %t96, %else9 ]
  %t120 = phi { i8**, i64 }* [ %t91, %then8 ], [ %t118, %else9 ]
  store { %LLVMOperand*, i64 }* %t119, { %LLVMOperand*, i64 }** %l5
  store { i8**, i64 }* %t120, { i8**, i64 }** %l0
  %t121 = load double, double* %l11
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l11
  br label %loop.latch4
loop.latch4:
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t127 = load double, double* %l4
  %t128 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t129 = load double, double* %l11
  br label %loop.header2
afterloop5:
  %t136 = load i8*, i8** %l7
  %t137 = icmp ne i8* %t136, null
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t140 = load i8*, i8** %l2
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t142 = load double, double* %l4
  %t143 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t144 = load double, double* %l6
  %t145 = load i8*, i8** %l7
  %t146 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t147 = load double, double* %l11
  br i1 %t137, label %then11, label %merge12
then11:
  %t148 = load i8*, i8** %l7
  store i8* %t148, i8** %l14
  %t149 = alloca [0 x double]
  %t150 = getelementptr [0 x double], [0 x double]* %t149, i32 0, i32 0
  %t151 = alloca { double*, i64 }
  %t152 = getelementptr { double*, i64 }, { double*, i64 }* %t151, i32 0, i32 0
  store double* %t150, double** %t152
  %t153 = getelementptr { double*, i64 }, { double*, i64 }* %t151, i32 0, i32 1
  store i64 0, i64* %t153
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l15
  %t154 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t155 = load i8*, i8** %l14
  %t156 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t154, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t156, { %LLVMOperand*, i64 }** %l15
  %t157 = sitofp i64 0 to double
  store double %t157, double* %l16
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t160 = load i8*, i8** %l2
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t162 = load double, double* %l4
  %t163 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t164 = load double, double* %l6
  %t165 = load i8*, i8** %l7
  %t166 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t167 = load double, double* %l11
  %t168 = load i8*, i8** %l14
  %t169 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t170 = load double, double* %l16
  br label %loop.header13
loop.header13:
  %t205 = phi { %LLVMOperand*, i64 }* [ %t169, %then11 ], [ %t203, %loop.latch15 ]
  %t206 = phi double [ %t170, %then11 ], [ %t204, %loop.latch15 ]
  store { %LLVMOperand*, i64 }* %t205, { %LLVMOperand*, i64 }** %l15
  store double %t206, double* %l16
  br label %loop.body14
loop.body14:
  %t171 = load double, double* %l16
  %t172 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t173 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t172
  %t174 = extractvalue { %LLVMOperand*, i64 } %t173, 1
  %t175 = sitofp i64 %t174 to double
  %t176 = fcmp oge double %t171, %t175
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t178 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t179 = load i8*, i8** %l2
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t181 = load double, double* %l4
  %t182 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t183 = load double, double* %l6
  %t184 = load i8*, i8** %l7
  %t185 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t186 = load double, double* %l11
  %t187 = load i8*, i8** %l14
  %t188 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t189 = load double, double* %l16
  br i1 %t176, label %then17, label %merge18
then17:
  br label %afterloop16
merge18:
  %t190 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t191 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t192 = load double, double* %l16
  %t193 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t191
  %t194 = extractvalue { %LLVMOperand*, i64 } %t193, 0
  %t195 = extractvalue { %LLVMOperand*, i64 } %t193, 1
  %t196 = icmp uge i64 %t192, %t195
  ; bounds check: %t196 (if true, out of bounds)
  %t197 = getelementptr %LLVMOperand, %LLVMOperand* %t194, i64 %t192
  %t198 = load %LLVMOperand, %LLVMOperand* %t197
  %t199 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t190, %LLVMOperand %t198)
  store { %LLVMOperand*, i64 }* %t199, { %LLVMOperand*, i64 }** %l15
  %t200 = load double, double* %l16
  %t201 = sitofp i64 1 to double
  %t202 = fadd double %t200, %t201
  store double %t202, double* %l16
  br label %loop.latch15
loop.latch15:
  %t203 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t204 = load double, double* %l16
  br label %loop.header13
afterloop16:
  %t207 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  store { %LLVMOperand*, i64 }* %t207, { %LLVMOperand*, i64 }** %l5
  br label %merge12
merge12:
  %t208 = phi { %LLVMOperand*, i64 }* [ %t207, %then11 ], [ %t143, %entry ]
  store { %LLVMOperand*, i64 }* %t208, { %LLVMOperand*, i64 }** %l5
  %t209 = load { i8**, i64 }, { i8**, i64 }* %arguments
  %t210 = extractvalue { i8**, i64 } %t209, 1
  %t211 = load double, double* %l6
  %t212 = sitofp i64 %t210 to double
  %t213 = fadd double %t212, %t211
  store double %t213, double* %l17
  %t214 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t215 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t214
  %t216 = extractvalue { %LLVMOperand*, i64 } %t215, 1
  %t217 = load double, double* %l17
  %t218 = sitofp i64 %t216 to double
  %t219 = fcmp une double %t218, %t217
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t222 = load i8*, i8** %l2
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t224 = load double, double* %l4
  %t225 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t226 = load double, double* %l6
  %t227 = load i8*, i8** %l7
  %t228 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t229 = load double, double* %l11
  %t230 = load double, double* %l17
  br i1 %t219, label %then19, label %merge20
then19:
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s232 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.232, i32 0, i32 0
  %t233 = load i8*, i8** %l2
  %t234 = add i8* %s232, %t233
  %s235 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.235, i32 0, i32 0
  %t236 = add i8* %t234, %s235
  %t237 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t231, i8* %t236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l0
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t239 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t238, 0
  %t240 = load double, double* %l4
  %t241 = insertvalue %ExpressionResult %t239, double %t240, 1
  %t242 = insertvalue %ExpressionResult %t241, i8* null, 2
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t244 = insertvalue %ExpressionResult %t242, { i8**, i64 }* %t243, 3
  %t245 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t246 = insertvalue %ExpressionResult %t244, { i8**, i64 }* null, 4
  ret %ExpressionResult %t246
merge20:
  %s247 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.247, i32 0, i32 0
  store i8* %s247, i8** %l18
  %t248 = alloca [0 x double]
  %t249 = getelementptr [0 x double], [0 x double]* %t248, i32 0, i32 0
  %t250 = alloca { double*, i64 }
  %t251 = getelementptr { double*, i64 }, { double*, i64 }* %t250, i32 0, i32 0
  store double* %t249, double** %t251
  %t252 = getelementptr { double*, i64 }, { double*, i64 }* %t250, i32 0, i32 1
  store i64 0, i64* %t252
  store { i8**, i64 }* null, { i8**, i64 }** %l19
  store i1 0, i1* %l20
  %t253 = load i8*, i8** %l2
  %t254 = call double @substring(i8* %t253, i64 0, i64 16)
  %s255 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.255, i32 0, i32 0
  %t256 = load i8*, i8** %l2
  %t257 = call double @find_function_by_name({ i8**, i64 }* %functions, i8* %t256)
  store double %t257, double* %l21
  %t258 = load i8*, i8** %l2
  %t259 = call double @find_runtime_helper(i8* %t258)
  store double %t259, double* %l22
  %t260 = load i1, i1* %l20
  %t261 = xor i1 %t260, 1
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t263 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t264 = load i8*, i8** %l2
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t266 = load double, double* %l4
  %t267 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t268 = load double, double* %l6
  %t269 = load i8*, i8** %l7
  %t270 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t271 = load double, double* %l11
  %t272 = load double, double* %l17
  %t273 = load i8*, i8** %l18
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t275 = load i1, i1* %l20
  %t276 = load double, double* %l21
  %t277 = load double, double* %l22
  br i1 %t261, label %then21, label %merge22
then21:
  %t278 = load double, double* %l21
  br label %merge22
merge22:
  %t280 = load double, double* %l21
  %t281 = alloca [0 x double]
  %t282 = getelementptr [0 x double], [0 x double]* %t281, i32 0, i32 0
  %t283 = alloca { double*, i64 }
  %t284 = getelementptr { double*, i64 }, { double*, i64 }* %t283, i32 0, i32 0
  store double* %t282, double** %t284
  %t285 = getelementptr { double*, i64 }, { double*, i64 }* %t283, i32 0, i32 1
  store i64 0, i64* %t285
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l23
  %t286 = sitofp i64 0 to double
  store double %t286, double* %l11
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t288 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t289 = load i8*, i8** %l2
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t291 = load double, double* %l4
  %t292 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t293 = load double, double* %l6
  %t294 = load i8*, i8** %l7
  %t295 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t296 = load double, double* %l11
  %t297 = load double, double* %l17
  %t298 = load i8*, i8** %l18
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t300 = load i1, i1* %l20
  %t301 = load double, double* %l21
  %t302 = load double, double* %l22
  %t303 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  br label %loop.header23
loop.header23:
  %t405 = phi { %LLVMOperand*, i64 }* [ %t303, %entry ], [ %t403, %loop.latch25 ]
  %t406 = phi double [ %t296, %entry ], [ %t404, %loop.latch25 ]
  store { %LLVMOperand*, i64 }* %t405, { %LLVMOperand*, i64 }** %l23
  store double %t406, double* %l11
  br label %loop.body24
loop.body24:
  %t304 = load double, double* %l11
  %t305 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t306 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t305
  %t307 = extractvalue { %LLVMOperand*, i64 } %t306, 1
  %t308 = sitofp i64 %t307 to double
  %t309 = fcmp oge double %t304, %t308
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t311 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t312 = load i8*, i8** %l2
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t314 = load double, double* %l4
  %t315 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t316 = load double, double* %l6
  %t317 = load i8*, i8** %l7
  %t318 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t319 = load double, double* %l11
  %t320 = load double, double* %l17
  %t321 = load i8*, i8** %l18
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t323 = load i1, i1* %l20
  %t324 = load double, double* %l21
  %t325 = load double, double* %l22
  %t326 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  br i1 %t309, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t327 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t328 = load double, double* %l11
  %t329 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t327
  %t330 = extractvalue { %LLVMOperand*, i64 } %t329, 0
  %t331 = extractvalue { %LLVMOperand*, i64 } %t329, 1
  %t332 = icmp uge i64 %t328, %t331
  ; bounds check: %t332 (if true, out of bounds)
  %t333 = getelementptr %LLVMOperand, %LLVMOperand* %t330, i64 %t328
  %t334 = load %LLVMOperand, %LLVMOperand* %t333
  store %LLVMOperand %t334, %LLVMOperand* %l24
  %s335 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.335, i32 0, i32 0
  store i8* %s335, i8** %l25
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t337 = load { i8**, i64 }, { i8**, i64 }* %t336
  %t338 = extractvalue { i8**, i64 } %t337, 1
  %t339 = load double, double* %l11
  %t340 = sitofp i64 %t338 to double
  %t341 = fcmp ogt double %t340, %t339
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t343 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t344 = load i8*, i8** %l2
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t346 = load double, double* %l4
  %t347 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t348 = load double, double* %l6
  %t349 = load i8*, i8** %l7
  %t350 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t351 = load double, double* %l11
  %t352 = load double, double* %l17
  %t353 = load i8*, i8** %l18
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t355 = load i1, i1* %l20
  %t356 = load double, double* %l21
  %t357 = load double, double* %l22
  %t358 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t359 = load %LLVMOperand, %LLVMOperand* %l24
  %t360 = load i8*, i8** %l25
  br i1 %t341, label %then29, label %merge30
then29:
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t362 = load double, double* %l11
  %t363 = load { i8**, i64 }, { i8**, i64 }* %t361
  %t364 = extractvalue { i8**, i64 } %t363, 0
  %t365 = extractvalue { i8**, i64 } %t363, 1
  %t366 = icmp uge i64 %t362, %t365
  ; bounds check: %t366 (if true, out of bounds)
  %t367 = getelementptr i8*, i8** %t364, i64 %t362
  %t368 = load i8*, i8** %t367
  store i8* %t368, i8** %l25
  br label %merge30
merge30:
  %t369 = phi i8* [ %t368, %then29 ], [ %t360, %loop.body24 ]
  store i8* %t369, i8** %l25
  %t371 = load i1, i1* %l20
  br label %logical_and_entry_370

logical_and_entry_370:
  br i1 %t371, label %logical_and_right_370, label %logical_and_merge_370

logical_and_right_370:
  %t372 = load double, double* %l11
  %t373 = sitofp i64 0 to double
  %t374 = fcmp oeq double %t372, %t373
  br label %logical_and_right_end_370

logical_and_right_end_370:
  br label %logical_and_merge_370

logical_and_merge_370:
  %t375 = phi i1 [ false, %logical_and_entry_370 ], [ %t374, %logical_and_right_end_370 ]
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t377 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t378 = load i8*, i8** %l2
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t380 = load double, double* %l4
  %t381 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t382 = load double, double* %l6
  %t383 = load i8*, i8** %l7
  %t384 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t385 = load double, double* %l11
  %t386 = load double, double* %l17
  %t387 = load i8*, i8** %l18
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t389 = load i1, i1* %l20
  %t390 = load double, double* %l21
  %t391 = load double, double* %l22
  %t392 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t393 = load %LLVMOperand, %LLVMOperand* %l24
  %t394 = load i8*, i8** %l25
  br i1 %t375, label %then31, label %else32
then31:
  %t395 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t396 = load %LLVMOperand, %LLVMOperand* %l24
  %t397 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t395, %LLVMOperand %t396)
  store { %LLVMOperand*, i64 }* %t397, { %LLVMOperand*, i64 }** %l23
  br label %merge33
else32:
  %t398 = load i8*, i8** %l25
  br label %merge33
merge33:
  %t399 = phi { %LLVMOperand*, i64 }* [ %t397, %then31 ], [ %t392, %else32 ]
  store { %LLVMOperand*, i64 }* %t399, { %LLVMOperand*, i64 }** %l23
  %t400 = load double, double* %l11
  %t401 = sitofp i64 1 to double
  %t402 = fadd double %t400, %t401
  store double %t402, double* %l11
  br label %loop.latch25
loop.latch25:
  %t403 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t404 = load double, double* %l11
  br label %loop.header23
afterloop26:
  %t407 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  store { %LLVMOperand*, i64 }* %t407, { %LLVMOperand*, i64 }** %l5
  %t409 = load double, double* %l21
  %t410 = alloca [0 x double]
  %t411 = getelementptr [0 x double], [0 x double]* %t410, i32 0, i32 0
  %t412 = alloca { double*, i64 }
  %t413 = getelementptr { double*, i64 }, { double*, i64 }* %t412, i32 0, i32 0
  store double* %t411, double** %t413
  %t414 = getelementptr { double*, i64 }, { double*, i64 }* %t412, i32 0, i32 1
  store i64 0, i64* %t414
  store { i8**, i64 }* null, { i8**, i64 }** %l26
  %t415 = sitofp i64 0 to double
  store double %t415, double* %l11
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t417 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t418 = load i8*, i8** %l2
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t420 = load double, double* %l4
  %t421 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t422 = load double, double* %l6
  %t423 = load i8*, i8** %l7
  %t424 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t425 = load double, double* %l11
  %t426 = load double, double* %l17
  %t427 = load i8*, i8** %l18
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t429 = load i1, i1* %l20
  %t430 = load double, double* %l21
  %t431 = load double, double* %l22
  %t432 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l26
  br label %loop.header34
loop.header34:
  %t474 = phi { i8**, i64 }* [ %t433, %entry ], [ %t472, %loop.latch36 ]
  %t475 = phi double [ %t425, %entry ], [ %t473, %loop.latch36 ]
  store { i8**, i64 }* %t474, { i8**, i64 }** %l26
  store double %t475, double* %l11
  br label %loop.body35
loop.body35:
  %t434 = load double, double* %l11
  %t435 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t436 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t435
  %t437 = extractvalue { %LLVMOperand*, i64 } %t436, 1
  %t438 = sitofp i64 %t437 to double
  %t439 = fcmp oge double %t434, %t438
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t441 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t442 = load i8*, i8** %l2
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t444 = load double, double* %l4
  %t445 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t446 = load double, double* %l6
  %t447 = load i8*, i8** %l7
  %t448 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t449 = load double, double* %l11
  %t450 = load double, double* %l17
  %t451 = load i8*, i8** %l18
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t453 = load i1, i1* %l20
  %t454 = load double, double* %l21
  %t455 = load double, double* %l22
  %t456 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l26
  br i1 %t439, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t459 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t460 = load double, double* %l11
  %t461 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t459
  %t462 = extractvalue { %LLVMOperand*, i64 } %t461, 0
  %t463 = extractvalue { %LLVMOperand*, i64 } %t461, 1
  %t464 = icmp uge i64 %t460, %t463
  ; bounds check: %t464 (if true, out of bounds)
  %t465 = getelementptr %LLVMOperand, %LLVMOperand* %t462, i64 %t460
  %t466 = load %LLVMOperand, %LLVMOperand* %t465
  %t467 = call i8* @format_typed_operand(%LLVMOperand %t466)
  %t468 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t458, i8* %t467)
  store { i8**, i64 }* %t468, { i8**, i64 }** %l26
  %t469 = load double, double* %l11
  %t470 = sitofp i64 1 to double
  %t471 = fadd double %t469, %t470
  store double %t471, double* %l11
  br label %loop.latch36
loop.latch36:
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t473 = load double, double* %l11
  br label %loop.header34
afterloop37:
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l26
  store double 0.0, double* %l27
  %t477 = load i8*, i8** %l2
  %t478 = call double @substring(i8* %t477, i64 0, i64 16)
  %s479 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.479, i32 0, i32 0
  %t480 = load i8*, i8** %l2
  %t481 = call i8* @sanitize_symbol(i8* %t480)
  store i8* %t481, i8** %l28
  %t482 = load double, double* %l22
  %t483 = load i8*, i8** %l18
  %s484 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.484, i32 0, i32 0
  %t485 = icmp eq i8* %t483, %s484
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t487 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t488 = load i8*, i8** %l2
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t490 = load double, double* %l4
  %t491 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t492 = load double, double* %l6
  %t493 = load i8*, i8** %l7
  %t494 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t495 = load double, double* %l11
  %t496 = load double, double* %l17
  %t497 = load i8*, i8** %l18
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t499 = load i1, i1* %l20
  %t500 = load double, double* %l21
  %t501 = load double, double* %l22
  %t502 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t504 = load double, double* %l27
  %t505 = load i8*, i8** %l28
  br i1 %t485, label %then40, label %merge41
then40:
  %s506 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.506, i32 0, i32 0
  %t507 = load i8*, i8** %l28
  %t508 = add i8* %s506, %t507
  %s509 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.509, i32 0, i32 0
  %t510 = add i8* %t508, %s509
  store i8* %t510, i8** %l29
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t512 = load i8*, i8** %l29
  %t513 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t511, i8* %t512)
  store { i8**, i64 }* %t513, { i8**, i64 }** %l3
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t515 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t514, 0
  %t516 = load double, double* %l4
  %t517 = insertvalue %ExpressionResult %t515, double %t516, 1
  %t518 = insertvalue %ExpressionResult %t517, i8* null, 2
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t520 = insertvalue %ExpressionResult %t518, { i8**, i64 }* %t519, 3
  %t521 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t522 = insertvalue %ExpressionResult %t520, { i8**, i64 }* null, 4
  ret %ExpressionResult %t522
merge41:
  %t523 = load double, double* %l4
  %t524 = call i8* @format_temp_name(double %t523)
  store i8* %t524, i8** %l30
  %s525 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.525, i32 0, i32 0
  %t526 = load i8*, i8** %l30
  %t527 = add i8* %s525, %t526
  %s528 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.528, i32 0, i32 0
  %t529 = add i8* %t527, %s528
  %t530 = load i8*, i8** %l18
  %t531 = add i8* %t529, %t530
  %s532 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.532, i32 0, i32 0
  %t533 = add i8* %t531, %s532
  %t534 = load i8*, i8** %l28
  %t535 = add i8* %t533, %t534
  %s536 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.536, i32 0, i32 0
  %t537 = add i8* %t535, %s536
  store i8* %t537, i8** %l31
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t539 = load i8*, i8** %l31
  %t540 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t538, i8* %t539)
  store { i8**, i64 }* %t540, { i8**, i64 }** %l3
  %t541 = load i8*, i8** %l18
  %t542 = insertvalue %LLVMOperand undef, i8* %t541, 0
  %t543 = load i8*, i8** %l30
  %t544 = insertvalue %LLVMOperand %t542, i8* %t543, 1
  store %LLVMOperand %t544, %LLVMOperand* %l32
  ret %ExpressionResult zeroinitializer
}

define %ExpressionResult @lower_member_access(%MemberAccessParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca %ExpressionResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %StringConstant*, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i1
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca %LLVMOperand
  %l15 = alloca i8*
  %l16 = alloca %LLVMOperand
  %t0 = extractvalue %MemberAccessParse %parse, 1
  %t1 = call %ExpressionResult @lower_expression(i8* %t0, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t1, %ExpressionResult* %l0
  %t2 = load %ExpressionResult, %ExpressionResult* %l0
  %t3 = extractvalue %ExpressionResult %t2, 3
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t4 = load %ExpressionResult, %ExpressionResult* %l0
  %t5 = extractvalue %ExpressionResult %t4, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l2
  %t6 = load %ExpressionResult, %ExpressionResult* %l0
  %t7 = extractvalue %ExpressionResult %t6, 2
  %t8 = icmp eq i8* %t7, null
  %t9 = load %ExpressionResult, %ExpressionResult* %l0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t11 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  br i1 %t8, label %then0, label %merge1
then0:
  %t12 = load %ExpressionResult, %ExpressionResult* %l0
  %t13 = extractvalue %ExpressionResult %t12, 0
  %t14 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t13, 0
  %t15 = load %ExpressionResult, %ExpressionResult* %l0
  %t16 = extractvalue %ExpressionResult %t15, 1
  %t17 = insertvalue %ExpressionResult %t14, double %t16, 1
  %t18 = insertvalue %ExpressionResult %t17, i8* null, 2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = insertvalue %ExpressionResult %t18, { i8**, i64 }* %t19, 3
  %t21 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t22 = insertvalue %ExpressionResult %t20, { i8**, i64 }* null, 4
  ret %ExpressionResult %t22
merge1:
  %t23 = load %ExpressionResult, %ExpressionResult* %l0
  %t24 = extractvalue %ExpressionResult %t23, 0
  store { i8**, i64 }* %t24, { i8**, i64 }** %l3
  %t25 = load %ExpressionResult, %ExpressionResult* %l0
  %t26 = extractvalue %ExpressionResult %t25, 1
  store double %t26, double* %l4
  %t27 = load %ExpressionResult, %ExpressionResult* %l0
  %t28 = extractvalue %ExpressionResult %t27, 2
  store i8* %t28, i8** %l5
  %t30 = extractvalue %MemberAccessParse %parse, 2
  %s31 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp eq i8* %t30, %s31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load i8*, i8** %l5
  store i8* null, i8** %l6
  store i1 0, i1* %l7
  %t34 = load i8*, i8** %l5
  store i8* %t34, i8** %l8
  %t35 = load i8*, i8** %l5
  %t36 = load i8*, i8** %l6
  store i8* %t36, i8** %l9
  %t37 = load i8*, i8** %l9
  %t38 = extractvalue %MemberAccessParse %parse, 2
  %t39 = call double @find_struct_field_info(%StructTypeInfo zeroinitializer, i8* %t38)
  store double %t39, double* %l10
  %t40 = load double, double* %l10
  %t41 = load i1, i1* %l7
  %t42 = load %ExpressionResult, %ExpressionResult* %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t46 = load double, double* %l4
  %t47 = load i8*, i8** %l5
  %t48 = load i8*, i8** %l6
  %t49 = load i1, i1* %l7
  %t50 = load i8*, i8** %l8
  %t51 = load i8*, i8** %l9
  %t52 = load double, double* %l10
  br i1 %t41, label %then2, label %merge3
then2:
  %t53 = load i8*, i8** %l9
  store double 0.0, double* %l11
  %t54 = load double, double* %l4
  %t55 = call i8* @format_temp_name(double %t54)
  store i8* %t55, i8** %l12
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s57 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.57, i32 0, i32 0
  %t58 = load i8*, i8** %l12
  %t59 = add i8* %s57, %t58
  %s60 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.60, i32 0, i32 0
  %t61 = add i8* %t59, %s60
  %t62 = load double, double* %l11
  %t63 = load double, double* %l4
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  store double %t65, double* %l4
  %t66 = load double, double* %l4
  %t67 = call i8* @format_temp_name(double %t66)
  store i8* %t67, i8** %l13
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.69, i32 0, i32 0
  %t70 = load i8*, i8** %l13
  %t71 = add i8* %s69, %t70
  %s72 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.72, i32 0, i32 0
  %t73 = add i8* %t71, %s72
  %t74 = load double, double* %l10
  %t75 = load double, double* %l4
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l4
  %t78 = load double, double* %l10
  %t79 = insertvalue %LLVMOperand undef, i8* null, 0
  %t80 = load i8*, i8** %l13
  %t81 = insertvalue %LLVMOperand %t79, i8* %t80, 1
  store %LLVMOperand %t81, %LLVMOperand* %l14
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t83 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t82, 0
  %t84 = load double, double* %l4
  %t85 = insertvalue %ExpressionResult %t83, double %t84, 1
  %t86 = load %LLVMOperand, %LLVMOperand* %l14
  %t87 = insertvalue %ExpressionResult %t85, i8* null, 2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = insertvalue %ExpressionResult %t87, { i8**, i64 }* %t88, 3
  %t90 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t91 = insertvalue %ExpressionResult %t89, { i8**, i64 }* null, 4
  ret %ExpressionResult %t91
merge3:
  %t92 = load double, double* %l4
  %t93 = call i8* @format_temp_name(double %t92)
  store i8* %t93, i8** %l15
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s95 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.95, i32 0, i32 0
  %t96 = load i8*, i8** %l15
  %t97 = add i8* %s95, %t96
  %s98 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.98, i32 0, i32 0
  %t99 = add i8* %t97, %s98
  %t100 = load i8*, i8** %l9
  %t101 = load double, double* %l4
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  store double %t103, double* %l4
  %t104 = load double, double* %l10
  %t105 = insertvalue %LLVMOperand undef, i8* null, 0
  %t106 = load i8*, i8** %l15
  %t107 = insertvalue %LLVMOperand %t105, i8* %t106, 1
  store %LLVMOperand %t107, %LLVMOperand* %l16
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t109 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t108, 0
  %t110 = load double, double* %l4
  %t111 = insertvalue %ExpressionResult %t109, double %t110, 1
  %t112 = load %LLVMOperand, %LLVMOperand* %l16
  %t113 = insertvalue %ExpressionResult %t111, i8* null, 2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = insertvalue %ExpressionResult %t113, { i8**, i64 }* %t114, 3
  %t116 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t117 = insertvalue %ExpressionResult %t115, { i8**, i64 }* null, 4
  ret %ExpressionResult %t117
}

define %ExpressionResult @lower_index_expression(%IndexExpressionParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca %ExpressionResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %StringConstant*, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca %ExpressionResult
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i1
  %l11 = alloca i1
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca i8*
  %l20 = alloca i8*
  %l21 = alloca %LLVMOperand
  %t0 = extractvalue %IndexExpressionParse %parse, 1
  %t1 = call %ExpressionResult @lower_expression(i8* %t0, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t1, %ExpressionResult* %l0
  %t2 = load %ExpressionResult, %ExpressionResult* %l0
  %t3 = extractvalue %ExpressionResult %t2, 3
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t4 = load %ExpressionResult, %ExpressionResult* %l0
  %t5 = extractvalue %ExpressionResult %t4, 4
  store { %StringConstant*, i64 }* null, { %StringConstant*, i64 }** %l2
  %t6 = load %ExpressionResult, %ExpressionResult* %l0
  %t7 = extractvalue %ExpressionResult %t6, 2
  %t8 = icmp eq i8* %t7, null
  %t9 = load %ExpressionResult, %ExpressionResult* %l0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t11 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  br i1 %t8, label %then0, label %merge1
then0:
  %t12 = load %ExpressionResult, %ExpressionResult* %l0
  %t13 = extractvalue %ExpressionResult %t12, 0
  %t14 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t13, 0
  %t15 = load %ExpressionResult, %ExpressionResult* %l0
  %t16 = extractvalue %ExpressionResult %t15, 1
  %t17 = insertvalue %ExpressionResult %t14, double %t16, 1
  %t18 = insertvalue %ExpressionResult %t17, i8* null, 2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = insertvalue %ExpressionResult %t18, { i8**, i64 }* %t19, 3
  %t21 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t22 = insertvalue %ExpressionResult %t20, { i8**, i64 }* null, 4
  ret %ExpressionResult %t22
merge1:
  %t23 = load %ExpressionResult, %ExpressionResult* %l0
  %t24 = extractvalue %ExpressionResult %t23, 0
  store { i8**, i64 }* %t24, { i8**, i64 }** %l3
  %t25 = load %ExpressionResult, %ExpressionResult* %l0
  %t26 = extractvalue %ExpressionResult %t25, 1
  store double %t26, double* %l4
  %t27 = load %ExpressionResult, %ExpressionResult* %l0
  %t28 = extractvalue %ExpressionResult %t27, 2
  store i8* %t28, i8** %l5
  %t29 = extractvalue %IndexExpressionParse %parse, 2
  %t30 = load double, double* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = call %ExpressionResult @lower_expression(i8* %t29, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t30, { i8**, i64 }* %t31, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t32, %ExpressionResult* %l6
  %t33 = load %ExpressionResult, %ExpressionResult* %l6
  %t34 = extractvalue %ExpressionResult %t33, 3
  %t35 = call double @diagnosticsconcat({ i8**, i64 }* %t34)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t36 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t37 = load %ExpressionResult, %ExpressionResult* %l6
  %t38 = extractvalue %ExpressionResult %t37, 4
  %t39 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t36, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t39, { %StringConstant*, i64 }** %l2
  %t40 = load %ExpressionResult, %ExpressionResult* %l6
  %t41 = extractvalue %ExpressionResult %t40, 0
  store { i8**, i64 }* %t41, { i8**, i64 }** %l3
  %t42 = load %ExpressionResult, %ExpressionResult* %l6
  %t43 = extractvalue %ExpressionResult %t42, 1
  store double %t43, double* %l4
  %t44 = load %ExpressionResult, %ExpressionResult* %l6
  %t45 = extractvalue %ExpressionResult %t44, 2
  %t46 = icmp eq i8* %t45, null
  %t47 = load %ExpressionResult, %ExpressionResult* %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t51 = load double, double* %l4
  %t52 = load i8*, i8** %l5
  %t53 = load %ExpressionResult, %ExpressionResult* %l6
  br i1 %t46, label %then2, label %merge3
then2:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s55 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.55, i32 0, i32 0
  %t56 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t54, i8* %s55)
  store { i8**, i64 }* %t56, { i8**, i64 }** %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t58 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t57, 0
  %t59 = load double, double* %l4
  %t60 = insertvalue %ExpressionResult %t58, double %t59, 1
  %t61 = insertvalue %ExpressionResult %t60, i8* null, 2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = insertvalue %ExpressionResult %t61, { i8**, i64 }* %t62, 3
  %t64 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t65 = insertvalue %ExpressionResult %t63, { i8**, i64 }* null, 4
  ret %ExpressionResult %t65
merge3:
  %t66 = load %ExpressionResult, %ExpressionResult* %l6
  %t67 = extractvalue %ExpressionResult %t66, 2
  store i8* %t67, i8** %l7
  %t68 = load i8*, i8** %l5
  store double 0.0, double* %l8
  %s69 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.69, i32 0, i32 0
  store i8* %s69, i8** %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t70 = load double, double* %l8
  %t71 = load i8*, i8** %l9
  %t73 = load i1, i1* %l10
  br label %logical_or_entry_72

logical_or_entry_72:
  br i1 %t73, label %logical_or_merge_72, label %logical_or_right_72

logical_or_right_72:
  %t74 = load i1, i1* %l11
  br label %logical_or_right_end_72

logical_or_right_end_72:
  br label %logical_or_merge_72

logical_or_merge_72:
  %t75 = phi i1 [ true, %logical_or_entry_72 ], [ %t74, %logical_or_right_end_72 ]
  %t76 = load %ExpressionResult, %ExpressionResult* %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = load double, double* %l4
  %t81 = load i8*, i8** %l5
  %t82 = load %ExpressionResult, %ExpressionResult* %l6
  %t83 = load i8*, i8** %l7
  %t84 = load double, double* %l8
  %t85 = load i8*, i8** %l9
  %t86 = load i1, i1* %l10
  %t87 = load i1, i1* %l11
  br i1 %t75, label %then4, label %merge5
then4:
  %s88 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.88, i32 0, i32 0
  store i8* %s88, i8** %l12
  %s89 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.89, i32 0, i32 0
  store i8* %s89, i8** %l13
  %t90 = load i1, i1* %l10
  %t91 = load %ExpressionResult, %ExpressionResult* %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t95 = load double, double* %l4
  %t96 = load i8*, i8** %l5
  %t97 = load %ExpressionResult, %ExpressionResult* %l6
  %t98 = load i8*, i8** %l7
  %t99 = load double, double* %l8
  %t100 = load i8*, i8** %l9
  %t101 = load i1, i1* %l10
  %t102 = load i1, i1* %l11
  %t103 = load i8*, i8** %l12
  %t104 = load i8*, i8** %l13
  br i1 %t90, label %then6, label %else7
then6:
  %t105 = load double, double* %l8
  %t106 = call i8* @strip_pointer_suffix(i8* null)
  store i8* %t106, i8** %l14
  %t107 = load double, double* %l4
  %t108 = call i8* @format_temp_name(double %t107)
  store i8* %t108, i8** %l15
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.110, i32 0, i32 0
  %t111 = load i8*, i8** %l15
  %t112 = add i8* %s110, %t111
  %s113 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.113, i32 0, i32 0
  %t114 = add i8* %t112, %s113
  %t115 = load i8*, i8** %l14
  %t116 = add i8* %t114, %t115
  %t117 = load double, double* %l4
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  store double %t119, double* %l4
  %t120 = load double, double* %l4
  %t121 = call i8* @format_temp_name(double %t120)
  store i8* %t121, i8** %l16
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s123 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.123, i32 0, i32 0
  %t124 = load i8*, i8** %l16
  %t125 = add i8* %s123, %t124
  %s126 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.126, i32 0, i32 0
  %t127 = add i8* %t125, %s126
  %t128 = load i8*, i8** %l14
  %t129 = add i8* %t127, %t128
  %s130 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.130, i32 0, i32 0
  %t131 = add i8* %t129, %s130
  %t132 = load i8*, i8** %l15
  %t133 = add i8* %t131, %t132
  %t134 = load double, double* %l4
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l4
  %t137 = load i8*, i8** %l16
  store i8* %t137, i8** %l12
  %t138 = load double, double* %l4
  %t139 = call i8* @format_temp_name(double %t138)
  store i8* %t139, i8** %l17
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s141 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.141, i32 0, i32 0
  %t142 = load i8*, i8** %l17
  %t143 = add i8* %s141, %t142
  %s144 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.144, i32 0, i32 0
  %t145 = add i8* %t143, %s144
  %t146 = load i8*, i8** %l14
  %t147 = add i8* %t145, %t146
  %s148 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.148, i32 0, i32 0
  %t149 = add i8* %t147, %s148
  %t150 = load i8*, i8** %l15
  %t151 = add i8* %t149, %t150
  %t152 = load double, double* %l4
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l4
  %t155 = load i8*, i8** %l17
  store i8* %t155, i8** %l13
  %t156 = load double, double* %l4
  %t157 = call i8* @format_temp_name(double %t156)
  store i8* %t157, i8** %l18
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s159 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.159, i32 0, i32 0
  %t160 = load i8*, i8** %l18
  %t161 = add i8* %s159, %t160
  %s162 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.162, i32 0, i32 0
  %t163 = add i8* %t161, %s162
  %t164 = load i8*, i8** %l7
  %t165 = load double, double* %l4
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l4
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s169 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.169, i32 0, i32 0
  %t170 = load i8*, i8** %l18
  %t171 = add i8* %s169, %t170
  %s172 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.172, i32 0, i32 0
  %t173 = add i8* %t171, %s172
  %t174 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t168, i8* %t173)
  store { i8**, i64 }* %t174, { i8**, i64 }** %l3
  br label %merge8
else7:
  %t175 = load i8*, i8** %l5
  br label %merge8
merge8:
  %t176 = phi { i8**, i64 }* [ null, %then6 ], [ %t94, %else7 ]
  %t177 = phi double [ %t119, %then6 ], [ %t95, %else7 ]
  %t178 = phi i8* [ %t137, %then6 ], [ null, %else7 ]
  %t179 = phi i8* [ %t155, %then6 ], [ %t104, %else7 ]
  store { i8**, i64 }* %t176, { i8**, i64 }** %l3
  store double %t177, double* %l4
  store i8* %t178, i8** %l12
  store i8* %t179, i8** %l13
  %t180 = load double, double* %l4
  %t181 = call i8* @format_temp_name(double %t180)
  store i8* %t181, i8** %l19
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s183 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.183, i32 0, i32 0
  %t184 = load i8*, i8** %l19
  %t185 = add i8* %s183, %t184
  %s186 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.186, i32 0, i32 0
  %t187 = add i8* %t185, %s186
  %t188 = load i8*, i8** %l9
  %t189 = add i8* %t187, %t188
  %t190 = load double, double* %l4
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l4
  %t193 = load double, double* %l4
  %t194 = call i8* @format_temp_name(double %t193)
  store i8* %t194, i8** %l20
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s196 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.196, i32 0, i32 0
  %t197 = load i8*, i8** %l20
  %t198 = add i8* %s196, %t197
  %s199 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.199, i32 0, i32 0
  %t200 = add i8* %t198, %s199
  %t201 = load i8*, i8** %l9
  %t202 = add i8* %t200, %t201
  %t203 = load double, double* %l4
  %t204 = sitofp i64 1 to double
  %t205 = fadd double %t203, %t204
  store double %t205, double* %l4
  %t206 = load i8*, i8** %l9
  %t207 = insertvalue %LLVMOperand undef, i8* %t206, 0
  %t208 = load i8*, i8** %l20
  %t209 = insertvalue %LLVMOperand %t207, i8* %t208, 1
  store %LLVMOperand %t209, %LLVMOperand* %l21
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t211 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t210, 0
  %t212 = load double, double* %l4
  %t213 = insertvalue %ExpressionResult %t211, double %t212, 1
  %t214 = load %LLVMOperand, %LLVMOperand* %l21
  %t215 = insertvalue %ExpressionResult %t213, i8* null, 2
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = insertvalue %ExpressionResult %t215, { i8**, i64 }* %t216, 3
  %t218 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t219 = insertvalue %ExpressionResult %t217, { i8**, i64 }* null, 4
  ret %ExpressionResult %t219
merge5:
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s221 = getelementptr inbounds [54 x i8], [54 x i8]* @.str.221, i32 0, i32 0
  %t222 = load double, double* %l8
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t224 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t223, 0
  %t225 = load double, double* %l4
  %t226 = insertvalue %ExpressionResult %t224, double %t225, 1
  %t227 = insertvalue %ExpressionResult %t226, i8* null, 2
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = insertvalue %ExpressionResult %t227, { i8**, i64 }* %t228, 3
  %t230 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t231 = insertvalue %ExpressionResult %t229, { i8**, i64 }* null, 4
  ret %ExpressionResult %t231
}

define %ExpressionResult @lower_array_literal(i8* %text, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
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
  %l10 = alloca i8*
  %l11 = alloca %ExpressionResult
  %l12 = alloca i8*
  %l13 = alloca { %LLVMOperand*, i64 }*
  %l14 = alloca %LLVMOperand
  %l15 = alloca %CoercionResult
  %l16 = alloca i64
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
  %t118 = phi { i8**, i64 }* [ %t23, %entry ], [ %t111, %loop.latch2 ]
  %t119 = phi { %StringConstant*, i64 }* [ %t26, %entry ], [ %t112, %loop.latch2 ]
  %t120 = phi { i8**, i64 }* [ %t24, %entry ], [ %t113, %loop.latch2 ]
  %t121 = phi double [ %t25, %entry ], [ %t114, %loop.latch2 ]
  %t122 = phi { %LLVMOperand*, i64 }* [ %t30, %entry ], [ %t115, %loop.latch2 ]
  %t123 = phi i8* [ %t31, %entry ], [ %t116, %loop.latch2 ]
  %t124 = phi double [ %t32, %entry ], [ %t117, %loop.latch2 ]
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  store { %StringConstant*, i64 }* %t119, { %StringConstant*, i64 }** %l3
  store { i8**, i64 }* %t120, { i8**, i64 }** %l1
  store double %t121, double* %l2
  store { %LLVMOperand*, i64 }* %t122, { %LLVMOperand*, i64 }** %l7
  store i8* %t123, i8** %l8
  store double %t124, double* %l9
  br label %loop.body1
loop.body1:
  %t33 = load double, double* %l9
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t34
  %t36 = extractvalue { i8**, i64 } %t35, 1
  %t37 = sitofp i64 %t36 to double
  %t38 = fcmp oge double %t33, %t37
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  %t42 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t43 = load double, double* %l4
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t45 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t46 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t47 = load i8*, i8** %l8
  %t48 = load double, double* %l9
  br i1 %t38, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t50 = load double, double* %l9
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  %t57 = call i8* @trim_text(i8* %t56)
  store i8* %t57, i8** %l10
  %t58 = load i8*, i8** %l10
  %t59 = load i8*, i8** %l10
  %t60 = load double, double* %l2
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = call %ExpressionResult @lower_expression(i8* %t59, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t60, { i8**, i64 }* %t61, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t62, %ExpressionResult* %l11
  %t63 = load %ExpressionResult, %ExpressionResult* %l11
  %t64 = extractvalue %ExpressionResult %t63, 3
  %t65 = call double @diagnosticsconcat({ i8**, i64 }* %t64)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t66 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t67 = load %ExpressionResult, %ExpressionResult* %l11
  %t68 = extractvalue %ExpressionResult %t67, 4
  %t69 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t66, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t69, { %StringConstant*, i64 }** %l3
  %t70 = load %ExpressionResult, %ExpressionResult* %l11
  %t71 = extractvalue %ExpressionResult %t70, 0
  store { i8**, i64 }* %t71, { i8**, i64 }** %l1
  %t72 = load %ExpressionResult, %ExpressionResult* %l11
  %t73 = extractvalue %ExpressionResult %t72, 1
  store double %t73, double* %l2
  %t74 = load %ExpressionResult, %ExpressionResult* %l11
  %t75 = extractvalue %ExpressionResult %t74, 2
  %t76 = icmp eq i8* %t75, null
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = load double, double* %l2
  %t80 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t81 = load double, double* %l4
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t83 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t84 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t85 = load i8*, i8** %l8
  %t86 = load double, double* %l9
  %t87 = load i8*, i8** %l10
  %t88 = load %ExpressionResult, %ExpressionResult* %l11
  br i1 %t76, label %then6, label %merge7
then6:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s90 = getelementptr inbounds [55 x i8], [55 x i8]* @.str.90, i32 0, i32 0
  %t91 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t89, i8* %s90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t92, 0
  %t94 = load double, double* %l2
  %t95 = insertvalue %ExpressionResult %t93, double %t94, 1
  %t96 = insertvalue %ExpressionResult %t95, i8* null, 2
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = insertvalue %ExpressionResult %t96, { i8**, i64 }* %t97, 3
  %t99 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t100 = insertvalue %ExpressionResult %t98, { i8**, i64 }* null, 4
  ret %ExpressionResult %t100
merge7:
  %t101 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t102 = load %ExpressionResult, %ExpressionResult* %l11
  %t103 = extractvalue %ExpressionResult %t102, 2
  %t104 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t101, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t104, { %LLVMOperand*, i64 }** %l7
  %t105 = load i8*, i8** %l8
  %t106 = load %ExpressionResult, %ExpressionResult* %l11
  %t107 = extractvalue %ExpressionResult %t106, 2
  %t108 = load double, double* %l9
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l9
  br label %loop.latch2
loop.latch2:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load double, double* %l2
  %t115 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t116 = load i8*, i8** %l8
  %t117 = load double, double* %l9
  br label %loop.header0
afterloop3:
  %t125 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t126 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t125
  %t127 = extractvalue { %LLVMOperand*, i64 } %t126, 1
  %t128 = icmp eq i64 %t127, 0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load double, double* %l2
  %t132 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t133 = load double, double* %l4
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t135 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t136 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t137 = load i8*, i8** %l8
  %t138 = load double, double* %l9
  br i1 %t128, label %then8, label %merge9
then8:
  %t139 = load i8*, i8** %l8
  br label %merge9
merge9:
  %t140 = load i8*, i8** %l8
  %t141 = load i8*, i8** %l8
  store i8* %t141, i8** %l12
  %t142 = alloca [0 x double]
  %t143 = getelementptr [0 x double], [0 x double]* %t142, i32 0, i32 0
  %t144 = alloca { double*, i64 }
  %t145 = getelementptr { double*, i64 }, { double*, i64 }* %t144, i32 0, i32 0
  store double* %t143, double** %t145
  %t146 = getelementptr { double*, i64 }, { double*, i64 }* %t144, i32 0, i32 1
  store i64 0, i64* %t146
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l13
  %t147 = sitofp i64 0 to double
  store double %t147, double* %l9
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load double, double* %l2
  %t151 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t152 = load double, double* %l4
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t154 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t155 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t156 = load i8*, i8** %l8
  %t157 = load double, double* %l9
  %t158 = load i8*, i8** %l12
  %t159 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  br label %loop.header10
loop.header10:
  %t243 = phi { i8**, i64 }* [ %t148, %entry ], [ %t238, %loop.latch12 ]
  %t244 = phi { i8**, i64 }* [ %t149, %entry ], [ %t239, %loop.latch12 ]
  %t245 = phi double [ %t150, %entry ], [ %t240, %loop.latch12 ]
  %t246 = phi { %LLVMOperand*, i64 }* [ %t159, %entry ], [ %t241, %loop.latch12 ]
  %t247 = phi double [ %t157, %entry ], [ %t242, %loop.latch12 ]
  store { i8**, i64 }* %t243, { i8**, i64 }** %l0
  store { i8**, i64 }* %t244, { i8**, i64 }** %l1
  store double %t245, double* %l2
  store { %LLVMOperand*, i64 }* %t246, { %LLVMOperand*, i64 }** %l13
  store double %t247, double* %l9
  br label %loop.body11
loop.body11:
  %t160 = load double, double* %l9
  %t161 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t162 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t161
  %t163 = extractvalue { %LLVMOperand*, i64 } %t162, 1
  %t164 = sitofp i64 %t163 to double
  %t165 = fcmp oge double %t160, %t164
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load double, double* %l2
  %t169 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t170 = load double, double* %l4
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t172 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t173 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t174 = load i8*, i8** %l8
  %t175 = load double, double* %l9
  %t176 = load i8*, i8** %l12
  %t177 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  br i1 %t165, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t178 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t179 = load double, double* %l9
  %t180 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t178
  %t181 = extractvalue { %LLVMOperand*, i64 } %t180, 0
  %t182 = extractvalue { %LLVMOperand*, i64 } %t180, 1
  %t183 = icmp uge i64 %t179, %t182
  ; bounds check: %t183 (if true, out of bounds)
  %t184 = getelementptr %LLVMOperand, %LLVMOperand* %t181, i64 %t179
  %t185 = load %LLVMOperand, %LLVMOperand* %t184
  store %LLVMOperand %t185, %LLVMOperand* %l14
  %t186 = load %LLVMOperand, %LLVMOperand* %l14
  %t187 = load i8*, i8** %l12
  %t188 = load double, double* %l2
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t190 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand %t186, i8* %t187, double %t188, { i8**, i64 }* %t189)
  store %CoercionResult %t190, %CoercionResult* %l15
  %t191 = load %CoercionResult, %CoercionResult* %l15
  %t192 = extractvalue %CoercionResult %t191, 3
  %t193 = call double @diagnosticsconcat({ i8**, i64 }* %t192)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t194 = load %CoercionResult, %CoercionResult* %l15
  %t195 = extractvalue %CoercionResult %t194, 0
  store { i8**, i64 }* %t195, { i8**, i64 }** %l1
  %t196 = load %CoercionResult, %CoercionResult* %l15
  %t197 = extractvalue %CoercionResult %t196, 1
  store double %t197, double* %l2
  %t198 = load %CoercionResult, %CoercionResult* %l15
  %t199 = extractvalue %CoercionResult %t198, 2
  %t200 = icmp eq i8* %t199, null
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t203 = load double, double* %l2
  %t204 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t205 = load double, double* %l4
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t207 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t208 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t209 = load i8*, i8** %l8
  %t210 = load double, double* %l9
  %t211 = load i8*, i8** %l12
  %t212 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t213 = load %LLVMOperand, %LLVMOperand* %l14
  %t214 = load %CoercionResult, %CoercionResult* %l15
  br i1 %t200, label %then16, label %merge17
then16:
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s216 = getelementptr inbounds [63 x i8], [63 x i8]* @.str.216, i32 0, i32 0
  %t217 = load i8*, i8** %l12
  %t218 = add i8* %s216, %t217
  %s219 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.219, i32 0, i32 0
  %t220 = add i8* %t218, %s219
  %t221 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t215, i8* %t220)
  store { i8**, i64 }* %t221, { i8**, i64 }** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t222, 0
  %t224 = load double, double* %l2
  %t225 = insertvalue %ExpressionResult %t223, double %t224, 1
  %t226 = insertvalue %ExpressionResult %t225, i8* null, 2
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t228 = insertvalue %ExpressionResult %t226, { i8**, i64 }* %t227, 3
  %t229 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t230 = insertvalue %ExpressionResult %t228, { i8**, i64 }* null, 4
  ret %ExpressionResult %t230
merge17:
  %t231 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t232 = load %CoercionResult, %CoercionResult* %l15
  %t233 = extractvalue %CoercionResult %t232, 2
  %t234 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t231, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t234, { %LLVMOperand*, i64 }** %l13
  %t235 = load double, double* %l9
  %t236 = sitofp i64 1 to double
  %t237 = fadd double %t235, %t236
  store double %t237, double* %l9
  br label %loop.latch12
loop.latch12:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t240 = load double, double* %l2
  %t241 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t242 = load double, double* %l9
  br label %loop.header10
afterloop13:
  %t248 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  store { %LLVMOperand*, i64 }* %t248, { %LLVMOperand*, i64 }** %l7
  %t249 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t250 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t249
  %t251 = extractvalue { %LLVMOperand*, i64 } %t250, 1
  store i64 %t251, i64* %l16
  %t252 = load i64, i64* %l16
  %t253 = sitofp i64 %t252 to double
  %t254 = call i8* @number_to_string(double %t253)
  store i8* %t254, i8** %l17
  %s255 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.255, i32 0, i32 0
  %t256 = load i8*, i8** %l17
  %t257 = add i8* %s255, %t256
  %s258 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.258, i32 0, i32 0
  %t259 = add i8* %t257, %s258
  %t260 = load i8*, i8** %l12
  %t261 = add i8* %t259, %t260
  %s262 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.262, i32 0, i32 0
  %t263 = add i8* %t261, %s262
  store i8* %t263, i8** %l18
  %t264 = load double, double* %l2
  %t265 = call i8* @format_temp_name(double %t264)
  store i8* %t265, i8** %l19
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s267 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.267, i32 0, i32 0
  %t268 = load i8*, i8** %l19
  %t269 = add i8* %s267, %t268
  %s270 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.270, i32 0, i32 0
  %t271 = add i8* %t269, %s270
  %t272 = load i8*, i8** %l18
  %t273 = add i8* %t271, %t272
  %t274 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t266, i8* %t273)
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  %t275 = load double, double* %l2
  %t276 = sitofp i64 1 to double
  %t277 = fadd double %t275, %t276
  store double %t277, double* %l2
  %t278 = load double, double* %l2
  %t279 = call i8* @format_temp_name(double %t278)
  store i8* %t279, i8** %l20
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s281 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.281, i32 0, i32 0
  %t282 = load i8*, i8** %l20
  %t283 = add i8* %s281, %t282
  %s284 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.284, i32 0, i32 0
  %t285 = add i8* %t283, %s284
  %t286 = load i8*, i8** %l18
  %t287 = add i8* %t285, %t286
  %t288 = load double, double* %l2
  %t289 = sitofp i64 1 to double
  %t290 = fadd double %t288, %t289
  store double %t290, double* %l2
  %t291 = sitofp i64 0 to double
  store double %t291, double* %l9
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t294 = load double, double* %l2
  %t295 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t296 = load double, double* %l4
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t298 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t299 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t300 = load i8*, i8** %l8
  %t301 = load double, double* %l9
  %t302 = load i8*, i8** %l12
  %t303 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t304 = load i64, i64* %l16
  %t305 = load i8*, i8** %l17
  %t306 = load i8*, i8** %l18
  %t307 = load i8*, i8** %l19
  %t308 = load i8*, i8** %l20
  br label %loop.header18
loop.header18:
  %t367 = phi { i8**, i64 }* [ %t293, %entry ], [ %t364, %loop.latch20 ]
  %t368 = phi double [ %t294, %entry ], [ %t365, %loop.latch20 ]
  %t369 = phi double [ %t301, %entry ], [ %t366, %loop.latch20 ]
  store { i8**, i64 }* %t367, { i8**, i64 }** %l1
  store double %t368, double* %l2
  store double %t369, double* %l9
  br label %loop.body19
loop.body19:
  %t309 = load double, double* %l9
  %t310 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t311 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t310
  %t312 = extractvalue { %LLVMOperand*, i64 } %t311, 1
  %t313 = sitofp i64 %t312 to double
  %t314 = fcmp oge double %t309, %t313
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t317 = load double, double* %l2
  %t318 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t319 = load double, double* %l4
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t321 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t322 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t323 = load i8*, i8** %l8
  %t324 = load double, double* %l9
  %t325 = load i8*, i8** %l12
  %t326 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t327 = load i64, i64* %l16
  %t328 = load i8*, i8** %l17
  %t329 = load i8*, i8** %l18
  %t330 = load i8*, i8** %l19
  %t331 = load i8*, i8** %l20
  br i1 %t314, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t332 = load double, double* %l2
  %t333 = call i8* @format_temp_name(double %t332)
  store i8* %t333, i8** %l21
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s335 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.335, i32 0, i32 0
  %t336 = load i8*, i8** %l21
  %t337 = add i8* %s335, %t336
  %s338 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.338, i32 0, i32 0
  %t339 = add i8* %t337, %s338
  %t340 = load i8*, i8** %l12
  %t341 = add i8* %t339, %t340
  %t342 = load double, double* %l2
  %t343 = sitofp i64 1 to double
  %t344 = fadd double %t342, %t343
  store double %t344, double* %l2
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s346 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.346, i32 0, i32 0
  %t347 = load i8*, i8** %l12
  %t348 = add i8* %s346, %t347
  %s349 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.349, i32 0, i32 0
  %t350 = add i8* %t348, %s349
  %t351 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t352 = load double, double* %l9
  %t353 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t351
  %t354 = extractvalue { %LLVMOperand*, i64 } %t353, 0
  %t355 = extractvalue { %LLVMOperand*, i64 } %t353, 1
  %t356 = icmp uge i64 %t352, %t355
  ; bounds check: %t356 (if true, out of bounds)
  %t357 = getelementptr %LLVMOperand, %LLVMOperand* %t354, i64 %t352
  %t358 = load %LLVMOperand, %LLVMOperand* %t357
  %t359 = extractvalue %LLVMOperand %t358, 1
  %t360 = add i8* %t350, %t359
  %t361 = load double, double* %l9
  %t362 = sitofp i64 1 to double
  %t363 = fadd double %t361, %t362
  store double %t363, double* %l9
  br label %loop.latch20
loop.latch20:
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t365 = load double, double* %l2
  %t366 = load double, double* %l9
  br label %loop.header18
afterloop21:
  %t370 = load i8*, i8** %l12
  %t371 = call i8* @array_struct_type_for_element(i8* %t370)
  store i8* %t371, i8** %l22
  %t372 = load double, double* %l2
  %t373 = call i8* @format_temp_name(double %t372)
  store i8* %t373, i8** %l23
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s375 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.375, i32 0, i32 0
  %t376 = load i8*, i8** %l23
  %t377 = add i8* %s375, %t376
  %s378 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.378, i32 0, i32 0
  %t379 = add i8* %t377, %s378
  %t380 = load i8*, i8** %l22
  %t381 = add i8* %t379, %t380
  %t382 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t374, i8* %t381)
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  %t383 = load double, double* %l2
  %t384 = sitofp i64 1 to double
  %t385 = fadd double %t383, %t384
  store double %t385, double* %l2
  %t386 = load double, double* %l2
  %t387 = call i8* @format_temp_name(double %t386)
  store i8* %t387, i8** %l24
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s389 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.389, i32 0, i32 0
  %t390 = load i8*, i8** %l24
  %t391 = add i8* %s389, %t390
  %s392 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.392, i32 0, i32 0
  %t393 = add i8* %t391, %s392
  %t394 = load i8*, i8** %l22
  %t395 = add i8* %t393, %t394
  %t396 = load double, double* %l2
  %t397 = sitofp i64 1 to double
  %t398 = fadd double %t396, %t397
  store double %t398, double* %l2
  %t399 = load i8*, i8** %l12
  store double 0.0, double* %l25
  %t400 = load double, double* %l25
  store double 0.0, double* %l26
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s402 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.402, i32 0, i32 0
  %t403 = load double, double* %l25
  %t404 = load double, double* %l2
  %t405 = call i8* @format_temp_name(double %t404)
  store i8* %t405, i8** %l27
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s407 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.407, i32 0, i32 0
  %t408 = load i8*, i8** %l27
  %t409 = add i8* %s407, %t408
  %s410 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.410, i32 0, i32 0
  %t411 = add i8* %t409, %s410
  %t412 = load i8*, i8** %l22
  %t413 = add i8* %t411, %t412
  %t414 = load double, double* %l2
  %t415 = sitofp i64 1 to double
  %t416 = fadd double %t414, %t415
  store double %t416, double* %l2
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s418 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.418, i32 0, i32 0
  %t419 = load i8*, i8** %l17
  %t420 = add i8* %s418, %t419
  store double 0.0, double* %l28
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t422 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t421, 0
  %t423 = load double, double* %l2
  %t424 = insertvalue %ExpressionResult %t422, double %t423, 1
  %t425 = load double, double* %l28
  %t426 = insertvalue %ExpressionResult %t424, i8* null, 2
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t428 = insertvalue %ExpressionResult %t426, { i8**, i64 }* %t427, 3
  %t429 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t430 = insertvalue %ExpressionResult %t428, { i8**, i64 }* null, 4
  ret %ExpressionResult %t430
}

define double @find_matching_closing_brace(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8
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
  %t61 = phi i1 [ %t5, %entry ], [ %t59, %loop.latch2 ]
  %t62 = phi double [ %t2, %entry ], [ %t60, %loop.latch2 ]
  store i1 %t61, i1* %l4
  store double %t62, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = load double, double* %l1
  %t8 = getelementptr i8, i8* %text, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l5
  %t10 = load i1, i1* %l3
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  %t13 = load i1, i1* %l2
  %t14 = load i1, i1* %l3
  %t15 = load i1, i1* %l4
  %t16 = load i8, i8* %l5
  br i1 %t10, label %then4, label %merge5
then4:
  %t17 = load i1, i1* %l4
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load i1, i1* %l2
  %t21 = load i1, i1* %l3
  %t22 = load i1, i1* %l4
  %t23 = load i8, i8* %l5
  br i1 %t17, label %then6, label %else7
then6:
  store i1 0, i1* %l4
  br label %merge8
else7:
  %t24 = load i8, i8* %l5
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  br label %merge8
merge8:
  %t26 = phi i1 [ 0, %then6 ], [ %t22, %else7 ]
  store i1 %t26, i1* %l4
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
merge5:
  %t30 = load i1, i1* %l2
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load i1, i1* %l3
  %t35 = load i1, i1* %l4
  %t36 = load i8, i8* %l5
  br i1 %t30, label %then9, label %merge10
then9:
  %t37 = load i1, i1* %l4
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = load i1, i1* %l2
  %t41 = load i1, i1* %l3
  %t42 = load i1, i1* %l4
  %t43 = load i8, i8* %l5
  br i1 %t37, label %then11, label %else12
then11:
  store i1 0, i1* %l4
  br label %merge13
else12:
  %t44 = load i8, i8* %l5
  %s45 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.45, i32 0, i32 0
  br label %merge13
merge13:
  %t46 = phi i1 [ 0, %then11 ], [ %t42, %else12 ]
  store i1 %t46, i1* %l4
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
merge10:
  %t50 = load i8, i8* %l5
  %s51 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.51, i32 0, i32 0
  %t52 = load i8, i8* %l5
  %s53 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.53, i32 0, i32 0
  %t54 = load i8, i8* %l5
  %s55 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.55, i32 0, i32 0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l1
  br label %loop.latch2
loop.latch2:
  %t59 = load i1, i1* %l4
  %t60 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t63 = sitofp i64 -1 to double
  ret double %t63
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
  %l8 = alloca i8
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
  %t94 = phi i1 [ %t11, %entry ], [ %t92, %loop.latch2 ]
  %t95 = phi double [ %t12, %entry ], [ %t93, %loop.latch2 ]
  store i1 %t94, i1* %l6
  store double %t95, double* %l7
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l7
  %t14 = load double, double* %l7
  %t15 = getelementptr i8, i8* %text, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l8
  %t17 = load i1, i1* %l5
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i1, i1* %l4
  %t23 = load i1, i1* %l5
  %t24 = load i1, i1* %l6
  %t25 = load double, double* %l7
  %t26 = load i8, i8* %l8
  br i1 %t17, label %then4, label %merge5
then4:
  %t27 = load i1, i1* %l6
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i1, i1* %l5
  %t34 = load i1, i1* %l6
  %t35 = load double, double* %l7
  %t36 = load i8, i8* %l8
  br i1 %t27, label %then6, label %else7
then6:
  store i1 0, i1* %l6
  br label %merge8
else7:
  %t37 = load i8, i8* %l8
  %s38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.38, i32 0, i32 0
  br label %merge8
merge8:
  %t39 = phi i1 [ 0, %then6 ], [ %t34, %else7 ]
  store i1 %t39, i1* %l6
  %t40 = load double, double* %l7
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l7
  br label %loop.latch2
merge5:
  %t43 = load i1, i1* %l4
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load i1, i1* %l4
  %t49 = load i1, i1* %l5
  %t50 = load i1, i1* %l6
  %t51 = load double, double* %l7
  %t52 = load i8, i8* %l8
  br i1 %t43, label %then9, label %merge10
then9:
  %t53 = load i1, i1* %l6
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load i1, i1* %l4
  %t59 = load i1, i1* %l5
  %t60 = load i1, i1* %l6
  %t61 = load double, double* %l7
  %t62 = load i8, i8* %l8
  br i1 %t53, label %then11, label %else12
then11:
  store i1 0, i1* %l6
  br label %merge13
else12:
  %t63 = load i8, i8* %l8
  %s64 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.64, i32 0, i32 0
  br label %merge13
merge13:
  %t65 = phi i1 [ 0, %then11 ], [ %t60, %else12 ]
  store i1 %t65, i1* %l6
  %t66 = load double, double* %l7
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l7
  br label %loop.latch2
merge10:
  %t69 = load i8, i8* %l8
  %s70 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.70, i32 0, i32 0
  %t71 = load i8, i8* %l8
  %s72 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.72, i32 0, i32 0
  %t73 = load i8, i8* %l8
  %s74 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.74, i32 0, i32 0
  %t75 = load i8, i8* %l8
  %s76 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.76, i32 0, i32 0
  %t77 = load i8, i8* %l8
  %s78 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.78, i32 0, i32 0
  %t79 = load i8, i8* %l8
  %s80 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.80, i32 0, i32 0
  %t81 = load i8, i8* %l8
  %s82 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.82, i32 0, i32 0
  %t83 = load i8, i8* %l8
  %s84 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.84, i32 0, i32 0
  %t85 = load i8, i8* %l8
  %t86 = load i8, i8* %l8
  %t87 = load i8, i8* %l8
  %s88 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.88, i32 0, i32 0
  %t89 = load double, double* %l7
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  store double %t91, double* %l7
  br label %loop.latch2
loop.latch2:
  %t92 = load i1, i1* %l6
  %t93 = load double, double* %l7
  br label %loop.header0
afterloop3:
  %t96 = sitofp i64 -1 to double
  ret double %t96
}

define %StructLiteralParse @parse_struct_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8
  %l9 = alloca i1
  %l10 = alloca double
  %l11 = alloca i8*
  %l12 = alloca { %StructLiteralField*, i64 }*
  %l13 = alloca double
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca { i8**, i64 }*
  %l16 = alloca double
  %l17 = alloca i8*
  %l18 = alloca double
  %l19 = alloca i8*
  %l20 = alloca double
  %l21 = alloca double
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
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = call i1 @is_identifier_start_char(i8* null)
  %t12 = xor i1 %t11, 1
  %t13 = load i8*, i8** %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then0, label %merge1
then0:
  %t16 = insertvalue %StructLiteralParse undef, i1 0, 0
  %t17 = insertvalue %StructLiteralParse %t16, i1 0, 1
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.18, i32 0, i32 0
  %t19 = insertvalue %StructLiteralParse %t17, i8* %s18, 2
  %t20 = alloca [0 x double]
  %t21 = getelementptr [0 x double], [0 x double]* %t20, i32 0, i32 0
  %t22 = alloca { double*, i64 }
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 0
  store double* %t21, double** %t23
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  %t25 = insertvalue %StructLiteralParse %t19, { i8**, i64 }* null, 3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = insertvalue %StructLiteralParse %t25, { i8**, i64 }* %t26, 4
  ret %StructLiteralParse %t27
merge1:
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l3
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l4
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l5
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l6
  %t32 = sitofp i64 -1 to double
  store double %t32, double* %l7
  %t33 = load i8*, i8** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l3
  %t37 = load double, double* %l4
  %t38 = load double, double* %l5
  %t39 = load double, double* %l6
  %t40 = load double, double* %l7
  br label %loop.header2
loop.header2:
  %t53 = phi double [ %t39, %entry ], [ %t52, %loop.latch4 ]
  store double %t53, double* %l6
  br label %loop.body3
loop.body3:
  %t41 = load double, double* %l6
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l6
  %t45 = getelementptr i8, i8* %t43, i64 %t44
  %t46 = load i8, i8* %t45
  store i8 %t46, i8* %l8
  %t47 = load i8, i8* %l8
  %s48 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.48, i32 0, i32 0
  %t49 = load double, double* %l6
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l6
  br label %loop.latch4
loop.latch4:
  %t52 = load double, double* %l6
  br label %loop.header2
afterloop5:
  %t54 = load double, double* %l7
  %t55 = sitofp i64 0 to double
  %t56 = fcmp olt double %t54, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load i8, i8* %l2
  %t60 = load double, double* %l3
  %t61 = load double, double* %l4
  %t62 = load double, double* %l5
  %t63 = load double, double* %l6
  %t64 = load double, double* %l7
  br i1 %t56, label %then6, label %merge7
then6:
  %t65 = insertvalue %StructLiteralParse undef, i1 0, 0
  %t66 = insertvalue %StructLiteralParse %t65, i1 0, 1
  %s67 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.67, i32 0, i32 0
  %t68 = insertvalue %StructLiteralParse %t66, i8* %s67, 2
  %t69 = alloca [0 x double]
  %t70 = getelementptr [0 x double], [0 x double]* %t69, i32 0, i32 0
  %t71 = alloca { double*, i64 }
  %t72 = getelementptr { double*, i64 }, { double*, i64 }* %t71, i32 0, i32 0
  store double* %t70, double** %t72
  %t73 = getelementptr { double*, i64 }, { double*, i64 }* %t71, i32 0, i32 1
  store i64 0, i64* %t73
  %t74 = insertvalue %StructLiteralParse %t68, { i8**, i64 }* null, 3
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = insertvalue %StructLiteralParse %t74, { i8**, i64 }* %t75, 4
  ret %StructLiteralParse %t76
merge7:
  store i1 0, i1* %l9
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l7
  %t79 = call double @find_matching_closing_brace(i8* %t77, double %t78)
  store double %t79, double* %l10
  %t80 = load double, double* %l10
  %t81 = sitofp i64 0 to double
  %t82 = fcmp olt double %t80, %t81
  %t83 = load i8*, i8** %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load i8, i8* %l2
  %t86 = load double, double* %l3
  %t87 = load double, double* %l4
  %t88 = load double, double* %l5
  %t89 = load double, double* %l6
  %t90 = load double, double* %l7
  %t91 = load i1, i1* %l9
  %t92 = load double, double* %l10
  br i1 %t82, label %then8, label %merge9
then8:
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s94 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.94, i32 0, i32 0
  %t95 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t93, i8* %s94)
  store { i8**, i64 }* %t95, { i8**, i64 }** %l1
  store i1 1, i1* %l9
  br label %merge9
merge9:
  %t96 = phi { i8**, i64 }* [ %t95, %then8 ], [ %t84, %entry ]
  %t97 = phi i1 [ 1, %then8 ], [ %t91, %entry ]
  store { i8**, i64 }* %t96, { i8**, i64 }** %l1
  store i1 %t97, i1* %l9
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l7
  %t100 = call double @substring(i8* %t98, i64 0, double %t99)
  %t101 = call i8* @trim_text(i8* null)
  store i8* %t101, i8** %l11
  %t102 = load i8*, i8** %l11
  %t103 = alloca [0 x double]
  %t104 = getelementptr [0 x double], [0 x double]* %t103, i32 0, i32 0
  %t105 = alloca { double*, i64 }
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t105, i32 0, i32 0
  store double* %t104, double** %t106
  %t107 = getelementptr { double*, i64 }, { double*, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  %t109 = load i1, i1* %l9
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t109, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t110 = load double, double* %l10
  %t111 = sitofp i64 0 to double
  %t112 = fcmp oge double %t110, %t111
  br label %logical_and_right_end_108

logical_and_right_end_108:
  br label %logical_and_merge_108

logical_and_merge_108:
  %t113 = phi i1 [ false, %logical_and_entry_108 ], [ %t112, %logical_and_right_end_108 ]
  %t114 = xor i1 %t113, 1
  %t115 = load i8*, i8** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = load i8, i8* %l2
  %t118 = load double, double* %l3
  %t119 = load double, double* %l4
  %t120 = load double, double* %l5
  %t121 = load double, double* %l6
  %t122 = load double, double* %l7
  %t123 = load i1, i1* %l9
  %t124 = load double, double* %l10
  %t125 = load i8*, i8** %l11
  %t126 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br i1 %t114, label %then10, label %merge11
then10:
  %t127 = load i8*, i8** %l0
  %t128 = load double, double* %l7
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  %t131 = load double, double* %l10
  %t132 = call double @substring(i8* %t127, double %t130, double %t131)
  store double %t132, double* %l13
  %t133 = load double, double* %l13
  %t134 = call { i8**, i64 }* @split_array_elements(i8* null)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l14
  %t135 = alloca [0 x double]
  %t136 = getelementptr [0 x double], [0 x double]* %t135, i32 0, i32 0
  %t137 = alloca { double*, i64 }
  %t138 = getelementptr { double*, i64 }, { double*, i64 }* %t137, i32 0, i32 0
  store double* %t136, double** %t138
  %t139 = getelementptr { double*, i64 }, { double*, i64 }* %t137, i32 0, i32 1
  store i64 0, i64* %t139
  store { i8**, i64 }* null, { i8**, i64 }** %l15
  %t140 = sitofp i64 0 to double
  store double %t140, double* %l16
  %t141 = load i8*, i8** %l0
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t143 = load i8, i8* %l2
  %t144 = load double, double* %l3
  %t145 = load double, double* %l4
  %t146 = load double, double* %l5
  %t147 = load double, double* %l6
  %t148 = load double, double* %l7
  %t149 = load i1, i1* %l9
  %t150 = load double, double* %l10
  %t151 = load i8*, i8** %l11
  %t152 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t153 = load double, double* %l13
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t156 = load double, double* %l16
  br label %loop.header12
loop.header12:
  %t281 = phi double [ %t156, %then10 ], [ %t277, %loop.latch14 ]
  %t282 = phi { i8**, i64 }* [ %t142, %then10 ], [ %t278, %loop.latch14 ]
  %t283 = phi { i8**, i64 }* [ %t155, %then10 ], [ %t279, %loop.latch14 ]
  %t284 = phi { %StructLiteralField*, i64 }* [ %t152, %then10 ], [ %t280, %loop.latch14 ]
  store double %t281, double* %l16
  store { i8**, i64 }* %t282, { i8**, i64 }** %l1
  store { i8**, i64 }* %t283, { i8**, i64 }** %l15
  store { %StructLiteralField*, i64 }* %t284, { %StructLiteralField*, i64 }** %l12
  br label %loop.body13
loop.body13:
  %t157 = load double, double* %l16
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t159 = load { i8**, i64 }, { i8**, i64 }* %t158
  %t160 = extractvalue { i8**, i64 } %t159, 1
  %t161 = sitofp i64 %t160 to double
  %t162 = fcmp oge double %t157, %t161
  %t163 = load i8*, i8** %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load i8, i8* %l2
  %t166 = load double, double* %l3
  %t167 = load double, double* %l4
  %t168 = load double, double* %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  %t171 = load i1, i1* %l9
  %t172 = load double, double* %l10
  %t173 = load i8*, i8** %l11
  %t174 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t175 = load double, double* %l13
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t178 = load double, double* %l16
  br i1 %t162, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t180 = load double, double* %l16
  %t181 = load { i8**, i64 }, { i8**, i64 }* %t179
  %t182 = extractvalue { i8**, i64 } %t181, 0
  %t183 = extractvalue { i8**, i64 } %t181, 1
  %t184 = icmp uge i64 %t180, %t183
  ; bounds check: %t184 (if true, out of bounds)
  %t185 = getelementptr i8*, i8** %t182, i64 %t180
  %t186 = load i8*, i8** %t185
  %t187 = call i8* @trim_text(i8* %t186)
  store i8* %t187, i8** %l17
  %t188 = load double, double* %l16
  %t189 = sitofp i64 1 to double
  %t190 = fadd double %t188, %t189
  store double %t190, double* %l16
  %t191 = load i8*, i8** %l17
  %t192 = load i8*, i8** %l17
  %t193 = call double @find_top_level_colon(i8* %t192)
  store double %t193, double* %l18
  %t194 = load double, double* %l18
  %t195 = sitofp i64 0 to double
  %t196 = fcmp olt double %t194, %t195
  %t197 = load i8*, i8** %l0
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t199 = load i8, i8* %l2
  %t200 = load double, double* %l3
  %t201 = load double, double* %l4
  %t202 = load double, double* %l5
  %t203 = load double, double* %l6
  %t204 = load double, double* %l7
  %t205 = load i1, i1* %l9
  %t206 = load double, double* %l10
  %t207 = load i8*, i8** %l11
  %t208 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t209 = load double, double* %l13
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t212 = load double, double* %l16
  %t213 = load i8*, i8** %l17
  %t214 = load double, double* %l18
  br i1 %t196, label %then18, label %merge19
then18:
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s216 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.216, i32 0, i32 0
  %t217 = load i8*, i8** %l17
  %t218 = add i8* %s216, %t217
  %s219 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.219, i32 0, i32 0
  %t220 = add i8* %t218, %s219
  %t221 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t215, i8* %t220)
  store { i8**, i64 }* %t221, { i8**, i64 }** %l1
  br label %loop.latch14
merge19:
  %t222 = load i8*, i8** %l17
  %t223 = load double, double* %l18
  %t224 = call double @substring(i8* %t222, i64 0, double %t223)
  %t225 = call i8* @trim_text(i8* null)
  store i8* %t225, i8** %l19
  %t226 = load i8*, i8** %l17
  %t227 = load double, double* %l18
  %t228 = sitofp i64 1 to double
  %t229 = fadd double %t227, %t228
  %t230 = load i8*, i8** %l17
  store double 0.0, double* %l20
  %t231 = load i8*, i8** %l19
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t233 = load i8*, i8** %l19
  %t234 = call i1 @string_array_contains({ i8**, i64 }* %t232, i8* %t233)
  %t235 = load i8*, i8** %l0
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t237 = load i8, i8* %l2
  %t238 = load double, double* %l3
  %t239 = load double, double* %l4
  %t240 = load double, double* %l5
  %t241 = load double, double* %l6
  %t242 = load double, double* %l7
  %t243 = load i1, i1* %l9
  %t244 = load double, double* %l10
  %t245 = load i8*, i8** %l11
  %t246 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t247 = load double, double* %l13
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t250 = load double, double* %l16
  %t251 = load i8*, i8** %l17
  %t252 = load double, double* %l18
  %t253 = load i8*, i8** %l19
  %t254 = load double, double* %l20
  br i1 %t234, label %then20, label %merge21
then20:
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s256 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.256, i32 0, i32 0
  %t257 = load i8*, i8** %l19
  %t258 = add i8* %s256, %t257
  %s259 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.259, i32 0, i32 0
  %t260 = add i8* %t258, %s259
  %t261 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t255, i8* %t260)
  store { i8**, i64 }* %t261, { i8**, i64 }** %l1
  br label %loop.latch14
merge21:
  %t262 = load double, double* %l20
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t264 = load i8*, i8** %l19
  %t265 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t263, i8* %t264)
  store { i8**, i64 }* %t265, { i8**, i64 }** %l15
  %t266 = load i8*, i8** %l19
  %t267 = insertvalue %StructLiteralField undef, i8* %t266, 0
  %t268 = load double, double* %l20
  %t269 = insertvalue %StructLiteralField %t267, i8* null, 1
  %t270 = alloca [1 x %StructLiteralField]
  %t271 = getelementptr [1 x %StructLiteralField], [1 x %StructLiteralField]* %t270, i32 0, i32 0
  %t272 = getelementptr %StructLiteralField, %StructLiteralField* %t271, i64 0
  store %StructLiteralField %t269, %StructLiteralField* %t272
  %t273 = alloca { %StructLiteralField*, i64 }
  %t274 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t273, i32 0, i32 0
  store %StructLiteralField* %t271, %StructLiteralField** %t274
  %t275 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t273, i32 0, i32 1
  store i64 1, i64* %t275
  %t276 = call double @fieldsconcat({ %StructLiteralField*, i64 }* %t273)
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  br label %loop.latch14
loop.latch14:
  %t277 = load double, double* %l16
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t280 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br label %loop.header12
afterloop15:
  br label %merge11
merge11:
  %t285 = phi { i8**, i64 }* [ %t221, %then10 ], [ %t116, %entry ]
  %t286 = phi { i8**, i64 }* [ %t261, %then10 ], [ %t116, %entry ]
  %t287 = phi { %StructLiteralField*, i64 }* [ null, %then10 ], [ %t126, %entry ]
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  store { %StructLiteralField*, i64 }* %t287, { %StructLiteralField*, i64 }** %l12
  %t289 = load i1, i1* %l9
  br label %logical_and_entry_288

logical_and_entry_288:
  br i1 %t289, label %logical_and_right_288, label %logical_and_merge_288

logical_and_right_288:
  %t290 = load double, double* %l10
  %t291 = sitofp i64 0 to double
  %t292 = fcmp oge double %t290, %t291
  br label %logical_and_right_end_288

logical_and_right_end_288:
  br label %logical_and_merge_288

logical_and_merge_288:
  %t293 = phi i1 [ false, %logical_and_entry_288 ], [ %t292, %logical_and_right_end_288 ]
  %t294 = xor i1 %t293, 1
  %t295 = load i8*, i8** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load i8, i8* %l2
  %t298 = load double, double* %l3
  %t299 = load double, double* %l4
  %t300 = load double, double* %l5
  %t301 = load double, double* %l6
  %t302 = load double, double* %l7
  %t303 = load i1, i1* %l9
  %t304 = load double, double* %l10
  %t305 = load i8*, i8** %l11
  %t306 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br i1 %t294, label %then22, label %merge23
then22:
  %t307 = load i8*, i8** %l0
  %t308 = load double, double* %l10
  %t309 = sitofp i64 1 to double
  %t310 = fadd double %t308, %t309
  %t311 = load i8*, i8** %l0
  store double 0.0, double* %l21
  %t312 = load double, double* %l21
  br label %merge23
merge23:
  %t313 = load i1, i1* %l9
  %t314 = load i8*, i8** %l0
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t316 = load i8, i8* %l2
  %t317 = load double, double* %l3
  %t318 = load double, double* %l4
  %t319 = load double, double* %l5
  %t320 = load double, double* %l6
  %t321 = load double, double* %l7
  %t322 = load i1, i1* %l9
  %t323 = load double, double* %l10
  %t324 = load i8*, i8** %l11
  %t325 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br i1 %t313, label %then24, label %merge25
then24:
  %t326 = alloca [0 x double]
  %t327 = getelementptr [0 x double], [0 x double]* %t326, i32 0, i32 0
  %t328 = alloca { double*, i64 }
  %t329 = getelementptr { double*, i64 }, { double*, i64 }* %t328, i32 0, i32 0
  store double* %t327, double** %t329
  %t330 = getelementptr { double*, i64 }, { double*, i64 }* %t328, i32 0, i32 1
  store i64 0, i64* %t330
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  br label %merge25
merge25:
  %t331 = phi { %StructLiteralField*, i64 }* [ null, %then24 ], [ %t325, %entry ]
  store { %StructLiteralField*, i64 }* %t331, { %StructLiteralField*, i64 }** %l12
  %t332 = insertvalue %StructLiteralParse undef, i1 1, 0
  %t333 = load i1, i1* %l9
  %t334 = xor i1 %t333, 1
  %t335 = insertvalue %StructLiteralParse %t332, i1 %t334, 1
  %t336 = load i8*, i8** %l11
  %t337 = insertvalue %StructLiteralParse %t335, i8* %t336, 2
  %t338 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t339 = insertvalue %StructLiteralParse %t337, { i8**, i64 }* null, 3
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t341 = insertvalue %StructLiteralParse %t339, { i8**, i64 }* %t340, 4
  ret %StructLiteralParse %t341
}

define %EnumLiteralParse @parse_enum_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca i8
  %l11 = alloca double
  %l12 = alloca i1
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca { %StructLiteralField*, i64 }*
  %l16 = alloca double
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca { i8**, i64 }*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca double
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca double
  %l25 = alloca double
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
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = call i1 @is_identifier_start_char(i8* null)
  %t12 = xor i1 %t11, 1
  %t13 = load i8*, i8** %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then0, label %merge1
then0:
  %t16 = insertvalue %EnumLiteralParse undef, i1 0, 0
  %t17 = insertvalue %EnumLiteralParse %t16, i1 0, 1
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.18, i32 0, i32 0
  %t19 = insertvalue %EnumLiteralParse %t17, i8* %s18, 2
  %s20 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.20, i32 0, i32 0
  %t21 = insertvalue %EnumLiteralParse %t19, i8* %s20, 3
  %t22 = alloca [0 x double]
  %t23 = getelementptr [0 x double], [0 x double]* %t22, i32 0, i32 0
  %t24 = alloca { double*, i64 }
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 0
  store double* %t23, double** %t25
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  %t27 = insertvalue %EnumLiteralParse %t21, { i8**, i64 }* null, 4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = insertvalue %EnumLiteralParse %t27, { i8**, i64 }* %t28, 5
  ret %EnumLiteralParse %t29
merge1:
  %t30 = load i8*, i8** %l0
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = call double @index_of(i8* %t30, i8* %s31)
  store double %t32, double* %l3
  %t33 = load double, double* %l3
  %t34 = sitofp i64 0 to double
  %t35 = fcmp olt double %t33, %t34
  %t36 = load i8*, i8** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load i8, i8* %l2
  %t39 = load double, double* %l3
  br i1 %t35, label %then2, label %merge3
then2:
  %t40 = insertvalue %EnumLiteralParse undef, i1 0, 0
  %t41 = insertvalue %EnumLiteralParse %t40, i1 0, 1
  %s42 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.42, i32 0, i32 0
  %t43 = insertvalue %EnumLiteralParse %t41, i8* %s42, 2
  %s44 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.44, i32 0, i32 0
  %t45 = insertvalue %EnumLiteralParse %t43, i8* %s44, 3
  %t46 = alloca [0 x double]
  %t47 = getelementptr [0 x double], [0 x double]* %t46, i32 0, i32 0
  %t48 = alloca { double*, i64 }
  %t49 = getelementptr { double*, i64 }, { double*, i64 }* %t48, i32 0, i32 0
  store double* %t47, double** %t49
  %t50 = getelementptr { double*, i64 }, { double*, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  %t51 = insertvalue %EnumLiteralParse %t45, { i8**, i64 }* null, 4
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = insertvalue %EnumLiteralParse %t51, { i8**, i64 }* %t52, 5
  ret %EnumLiteralParse %t53
merge3:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l3
  %t56 = call double @substring(i8* %t54, i64 0, double %t55)
  %t57 = call i8* @trim_text(i8* null)
  store i8* %t57, i8** %l4
  %t58 = load i8*, i8** %l4
  %t59 = sitofp i64 0 to double
  store double %t59, double* %l5
  %t60 = sitofp i64 0 to double
  store double %t60, double* %l6
  %t61 = sitofp i64 0 to double
  store double %t61, double* %l7
  %t62 = load double, double* %l3
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l8
  %t65 = sitofp i64 -1 to double
  store double %t65, double* %l9
  %t66 = load i8*, i8** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t68 = load i8, i8* %l2
  %t69 = load double, double* %l3
  %t70 = load i8*, i8** %l4
  %t71 = load double, double* %l5
  %t72 = load double, double* %l6
  %t73 = load double, double* %l7
  %t74 = load double, double* %l8
  %t75 = load double, double* %l9
  br label %loop.header4
loop.header4:
  %t88 = phi double [ %t74, %entry ], [ %t87, %loop.latch6 ]
  store double %t88, double* %l8
  br label %loop.body5
loop.body5:
  %t76 = load double, double* %l8
  %t77 = load i8*, i8** %l0
  %t78 = load i8*, i8** %l0
  %t79 = load double, double* %l8
  %t80 = getelementptr i8, i8* %t78, i64 %t79
  %t81 = load i8, i8* %t80
  store i8 %t81, i8* %l10
  %t82 = load i8, i8* %l10
  %s83 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.83, i32 0, i32 0
  %t84 = load double, double* %l8
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l8
  br label %loop.latch6
loop.latch6:
  %t87 = load double, double* %l8
  br label %loop.header4
afterloop7:
  %t89 = load double, double* %l9
  %t90 = sitofp i64 0 to double
  %t91 = fcmp olt double %t89, %t90
  %t92 = load i8*, i8** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load i8, i8* %l2
  %t95 = load double, double* %l3
  %t96 = load i8*, i8** %l4
  %t97 = load double, double* %l5
  %t98 = load double, double* %l6
  %t99 = load double, double* %l7
  %t100 = load double, double* %l8
  %t101 = load double, double* %l9
  br i1 %t91, label %then8, label %merge9
then8:
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l3
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  %t106 = load i8*, i8** %l0
  store double 0.0, double* %l11
  %t107 = load double, double* %l11
  %t108 = insertvalue %EnumLiteralParse undef, i1 1, 0
  %t109 = insertvalue %EnumLiteralParse %t108, i1 1, 1
  %t110 = load i8*, i8** %l4
  %t111 = insertvalue %EnumLiteralParse %t109, i8* %t110, 2
  %t112 = load double, double* %l11
  %t113 = insertvalue %EnumLiteralParse %t111, i8* null, 3
  %t114 = alloca [0 x double]
  %t115 = getelementptr [0 x double], [0 x double]* %t114, i32 0, i32 0
  %t116 = alloca { double*, i64 }
  %t117 = getelementptr { double*, i64 }, { double*, i64 }* %t116, i32 0, i32 0
  store double* %t115, double** %t117
  %t118 = getelementptr { double*, i64 }, { double*, i64 }* %t116, i32 0, i32 1
  store i64 0, i64* %t118
  %t119 = insertvalue %EnumLiteralParse %t113, { i8**, i64 }* null, 4
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = insertvalue %EnumLiteralParse %t119, { i8**, i64 }* %t120, 5
  ret %EnumLiteralParse %t121
merge9:
  store i1 0, i1* %l12
  %t122 = load i8*, i8** %l0
  %t123 = load double, double* %l9
  %t124 = call double @find_matching_closing_brace(i8* %t122, double %t123)
  store double %t124, double* %l13
  %t125 = load double, double* %l13
  %t126 = sitofp i64 0 to double
  %t127 = fcmp olt double %t125, %t126
  %t128 = load i8*, i8** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load i8, i8* %l2
  %t131 = load double, double* %l3
  %t132 = load i8*, i8** %l4
  %t133 = load double, double* %l5
  %t134 = load double, double* %l6
  %t135 = load double, double* %l7
  %t136 = load double, double* %l8
  %t137 = load double, double* %l9
  %t138 = load i1, i1* %l12
  %t139 = load double, double* %l13
  br i1 %t127, label %then10, label %merge11
then10:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s141 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.141, i32 0, i32 0
  %t142 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t140, i8* %s141)
  store { i8**, i64 }* %t142, { i8**, i64 }** %l1
  store i1 1, i1* %l12
  br label %merge11
merge11:
  %t143 = phi { i8**, i64 }* [ %t142, %then10 ], [ %t129, %entry ]
  %t144 = phi i1 [ 1, %then10 ], [ %t138, %entry ]
  store { i8**, i64 }* %t143, { i8**, i64 }** %l1
  store i1 %t144, i1* %l12
  %t145 = load i8*, i8** %l0
  %t146 = load double, double* %l3
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  %t149 = load double, double* %l9
  %t150 = call double @substring(i8* %t145, double %t148, double %t149)
  %t151 = call i8* @trim_text(i8* null)
  store i8* %t151, i8** %l14
  %t152 = load i8*, i8** %l14
  %t153 = alloca [0 x double]
  %t154 = getelementptr [0 x double], [0 x double]* %t153, i32 0, i32 0
  %t155 = alloca { double*, i64 }
  %t156 = getelementptr { double*, i64 }, { double*, i64 }* %t155, i32 0, i32 0
  store double* %t154, double** %t156
  %t157 = getelementptr { double*, i64 }, { double*, i64 }* %t155, i32 0, i32 1
  store i64 0, i64* %t157
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  %t159 = load i1, i1* %l12
  br label %logical_and_entry_158

logical_and_entry_158:
  br i1 %t159, label %logical_and_right_158, label %logical_and_merge_158

logical_and_right_158:
  %t160 = load double, double* %l13
  %t161 = sitofp i64 0 to double
  %t162 = fcmp oge double %t160, %t161
  br label %logical_and_right_end_158

logical_and_right_end_158:
  br label %logical_and_merge_158

logical_and_merge_158:
  %t163 = phi i1 [ false, %logical_and_entry_158 ], [ %t162, %logical_and_right_end_158 ]
  %t164 = xor i1 %t163, 1
  %t165 = load i8*, i8** %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load i8, i8* %l2
  %t168 = load double, double* %l3
  %t169 = load i8*, i8** %l4
  %t170 = load double, double* %l5
  %t171 = load double, double* %l6
  %t172 = load double, double* %l7
  %t173 = load double, double* %l8
  %t174 = load double, double* %l9
  %t175 = load i1, i1* %l12
  %t176 = load double, double* %l13
  %t177 = load i8*, i8** %l14
  %t178 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br i1 %t164, label %then12, label %merge13
then12:
  %t179 = load i8*, i8** %l0
  %t180 = load double, double* %l9
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  %t183 = load double, double* %l13
  %t184 = call double @substring(i8* %t179, double %t182, double %t183)
  store double %t184, double* %l16
  %t185 = load double, double* %l16
  %t186 = call { i8**, i64 }* @split_array_elements(i8* null)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l17
  %t187 = alloca [0 x double]
  %t188 = getelementptr [0 x double], [0 x double]* %t187, i32 0, i32 0
  %t189 = alloca { double*, i64 }
  %t190 = getelementptr { double*, i64 }, { double*, i64 }* %t189, i32 0, i32 0
  store double* %t188, double** %t190
  %t191 = getelementptr { double*, i64 }, { double*, i64 }* %t189, i32 0, i32 1
  store i64 0, i64* %t191
  store { i8**, i64 }* null, { i8**, i64 }** %l18
  %t192 = sitofp i64 0 to double
  store double %t192, double* %l19
  %t193 = load i8*, i8** %l0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load i8, i8* %l2
  %t196 = load double, double* %l3
  %t197 = load i8*, i8** %l4
  %t198 = load double, double* %l5
  %t199 = load double, double* %l6
  %t200 = load double, double* %l7
  %t201 = load double, double* %l8
  %t202 = load double, double* %l9
  %t203 = load i1, i1* %l12
  %t204 = load double, double* %l13
  %t205 = load i8*, i8** %l14
  %t206 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t207 = load double, double* %l16
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t210 = load double, double* %l19
  br label %loop.header14
loop.header14:
  %t382 = phi double [ %t210, %then12 ], [ %t378, %loop.latch16 ]
  %t383 = phi { i8**, i64 }* [ %t194, %then12 ], [ %t379, %loop.latch16 ]
  %t384 = phi { i8**, i64 }* [ %t209, %then12 ], [ %t380, %loop.latch16 ]
  %t385 = phi { %StructLiteralField*, i64 }* [ %t206, %then12 ], [ %t381, %loop.latch16 ]
  store double %t382, double* %l19
  store { i8**, i64 }* %t383, { i8**, i64 }** %l1
  store { i8**, i64 }* %t384, { i8**, i64 }** %l18
  store { %StructLiteralField*, i64 }* %t385, { %StructLiteralField*, i64 }** %l15
  br label %loop.body15
loop.body15:
  %t211 = load double, double* %l19
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t213 = load { i8**, i64 }, { i8**, i64 }* %t212
  %t214 = extractvalue { i8**, i64 } %t213, 1
  %t215 = sitofp i64 %t214 to double
  %t216 = fcmp oge double %t211, %t215
  %t217 = load i8*, i8** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load i8, i8* %l2
  %t220 = load double, double* %l3
  %t221 = load i8*, i8** %l4
  %t222 = load double, double* %l5
  %t223 = load double, double* %l6
  %t224 = load double, double* %l7
  %t225 = load double, double* %l8
  %t226 = load double, double* %l9
  %t227 = load i1, i1* %l12
  %t228 = load double, double* %l13
  %t229 = load i8*, i8** %l14
  %t230 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t231 = load double, double* %l16
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t234 = load double, double* %l19
  br i1 %t216, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t236 = load double, double* %l19
  %t237 = load { i8**, i64 }, { i8**, i64 }* %t235
  %t238 = extractvalue { i8**, i64 } %t237, 0
  %t239 = extractvalue { i8**, i64 } %t237, 1
  %t240 = icmp uge i64 %t236, %t239
  ; bounds check: %t240 (if true, out of bounds)
  %t241 = getelementptr i8*, i8** %t238, i64 %t236
  %t242 = load i8*, i8** %t241
  %t243 = call i8* @trim_text(i8* %t242)
  store i8* %t243, i8** %l20
  %t244 = load double, double* %l19
  %t245 = sitofp i64 1 to double
  %t246 = fadd double %t244, %t245
  store double %t246, double* %l19
  %t247 = load i8*, i8** %l20
  %t248 = load i8*, i8** %l20
  %t249 = call double @find_top_level_colon(i8* %t248)
  store double %t249, double* %l21
  %t250 = load double, double* %l21
  %t251 = sitofp i64 0 to double
  %t252 = fcmp olt double %t250, %t251
  %t253 = load i8*, i8** %l0
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t255 = load i8, i8* %l2
  %t256 = load double, double* %l3
  %t257 = load i8*, i8** %l4
  %t258 = load double, double* %l5
  %t259 = load double, double* %l6
  %t260 = load double, double* %l7
  %t261 = load double, double* %l8
  %t262 = load double, double* %l9
  %t263 = load i1, i1* %l12
  %t264 = load double, double* %l13
  %t265 = load i8*, i8** %l14
  %t266 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t267 = load double, double* %l16
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t270 = load double, double* %l19
  %t271 = load i8*, i8** %l20
  %t272 = load double, double* %l21
  br i1 %t252, label %then20, label %merge21
then20:
  %t273 = load i8*, i8** %l20
  %t274 = call i8* @trim_text(i8* %t273)
  store i8* %t274, i8** %l22
  %t275 = load i8*, i8** %l22
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t277 = load i8*, i8** %l22
  %t278 = call i1 @string_array_contains({ i8**, i64 }* %t276, i8* %t277)
  %t279 = load i8*, i8** %l0
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load i8, i8* %l2
  %t282 = load double, double* %l3
  %t283 = load i8*, i8** %l4
  %t284 = load double, double* %l5
  %t285 = load double, double* %l6
  %t286 = load double, double* %l7
  %t287 = load double, double* %l8
  %t288 = load double, double* %l9
  %t289 = load i1, i1* %l12
  %t290 = load double, double* %l13
  %t291 = load i8*, i8** %l14
  %t292 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t293 = load double, double* %l16
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t296 = load double, double* %l19
  %t297 = load i8*, i8** %l20
  %t298 = load double, double* %l21
  %t299 = load i8*, i8** %l22
  br i1 %t278, label %then22, label %merge23
then22:
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s301 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.301, i32 0, i32 0
  %t302 = load i8*, i8** %l22
  %t303 = add i8* %s301, %t302
  %s304 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.304, i32 0, i32 0
  %t305 = add i8* %t303, %s304
  %t306 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t300, i8* %t305)
  store { i8**, i64 }* %t306, { i8**, i64 }** %l1
  br label %loop.latch16
merge23:
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t308 = load i8*, i8** %l22
  %t309 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t307, i8* %t308)
  store { i8**, i64 }* %t309, { i8**, i64 }** %l18
  %t310 = load i8*, i8** %l22
  %t311 = insertvalue %StructLiteralField undef, i8* %t310, 0
  %s312 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.312, i32 0, i32 0
  %t313 = insertvalue %StructLiteralField %t311, i8* %s312, 1
  %t314 = alloca [1 x %StructLiteralField]
  %t315 = getelementptr [1 x %StructLiteralField], [1 x %StructLiteralField]* %t314, i32 0, i32 0
  %t316 = getelementptr %StructLiteralField, %StructLiteralField* %t315, i64 0
  store %StructLiteralField %t313, %StructLiteralField* %t316
  %t317 = alloca { %StructLiteralField*, i64 }
  %t318 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t317, i32 0, i32 0
  store %StructLiteralField* %t315, %StructLiteralField** %t318
  %t319 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t317, i32 0, i32 1
  store i64 1, i64* %t319
  %t320 = call double @fieldsconcat({ %StructLiteralField*, i64 }* %t317)
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %loop.latch16
merge21:
  %t321 = load i8*, i8** %l20
  %t322 = load double, double* %l21
  %t323 = call double @substring(i8* %t321, i64 0, double %t322)
  %t324 = call i8* @trim_text(i8* null)
  store i8* %t324, i8** %l23
  %t325 = load i8*, i8** %l20
  %t326 = load double, double* %l21
  %t327 = sitofp i64 1 to double
  %t328 = fadd double %t326, %t327
  %t329 = load i8*, i8** %l20
  store double 0.0, double* %l24
  %t330 = load i8*, i8** %l23
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t332 = load i8*, i8** %l23
  %t333 = call i1 @string_array_contains({ i8**, i64 }* %t331, i8* %t332)
  %t334 = load i8*, i8** %l0
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t336 = load i8, i8* %l2
  %t337 = load double, double* %l3
  %t338 = load i8*, i8** %l4
  %t339 = load double, double* %l5
  %t340 = load double, double* %l6
  %t341 = load double, double* %l7
  %t342 = load double, double* %l8
  %t343 = load double, double* %l9
  %t344 = load i1, i1* %l12
  %t345 = load double, double* %l13
  %t346 = load i8*, i8** %l14
  %t347 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t348 = load double, double* %l16
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t351 = load double, double* %l19
  %t352 = load i8*, i8** %l20
  %t353 = load double, double* %l21
  %t354 = load i8*, i8** %l23
  %t355 = load double, double* %l24
  br i1 %t333, label %then24, label %merge25
then24:
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s357 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.357, i32 0, i32 0
  %t358 = load i8*, i8** %l23
  %t359 = add i8* %s357, %t358
  %s360 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.360, i32 0, i32 0
  %t361 = add i8* %t359, %s360
  %t362 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t356, i8* %t361)
  store { i8**, i64 }* %t362, { i8**, i64 }** %l1
  br label %loop.latch16
merge25:
  %t363 = load double, double* %l24
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t365 = load i8*, i8** %l23
  %t366 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t364, i8* %t365)
  store { i8**, i64 }* %t366, { i8**, i64 }** %l18
  %t367 = load i8*, i8** %l23
  %t368 = insertvalue %StructLiteralField undef, i8* %t367, 0
  %t369 = load double, double* %l24
  %t370 = insertvalue %StructLiteralField %t368, i8* null, 1
  %t371 = alloca [1 x %StructLiteralField]
  %t372 = getelementptr [1 x %StructLiteralField], [1 x %StructLiteralField]* %t371, i32 0, i32 0
  %t373 = getelementptr %StructLiteralField, %StructLiteralField* %t372, i64 0
  store %StructLiteralField %t370, %StructLiteralField* %t373
  %t374 = alloca { %StructLiteralField*, i64 }
  %t375 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t374, i32 0, i32 0
  store %StructLiteralField* %t372, %StructLiteralField** %t375
  %t376 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t374, i32 0, i32 1
  store i64 1, i64* %t376
  %t377 = call double @fieldsconcat({ %StructLiteralField*, i64 }* %t374)
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %loop.latch16
loop.latch16:
  %t378 = load double, double* %l19
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t381 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %t386 = phi { i8**, i64 }* [ %t306, %then12 ], [ %t166, %entry ]
  %t387 = phi { %StructLiteralField*, i64 }* [ null, %then12 ], [ %t178, %entry ]
  %t388 = phi { i8**, i64 }* [ %t362, %then12 ], [ %t166, %entry ]
  %t389 = phi { %StructLiteralField*, i64 }* [ null, %then12 ], [ %t178, %entry ]
  store { i8**, i64 }* %t386, { i8**, i64 }** %l1
  store { %StructLiteralField*, i64 }* %t387, { %StructLiteralField*, i64 }** %l15
  store { i8**, i64 }* %t388, { i8**, i64 }** %l1
  store { %StructLiteralField*, i64 }* %t389, { %StructLiteralField*, i64 }** %l15
  %t391 = load i1, i1* %l12
  br label %logical_and_entry_390

logical_and_entry_390:
  br i1 %t391, label %logical_and_right_390, label %logical_and_merge_390

logical_and_right_390:
  %t392 = load double, double* %l13
  %t393 = sitofp i64 0 to double
  %t394 = fcmp oge double %t392, %t393
  br label %logical_and_right_end_390

logical_and_right_end_390:
  br label %logical_and_merge_390

logical_and_merge_390:
  %t395 = phi i1 [ false, %logical_and_entry_390 ], [ %t394, %logical_and_right_end_390 ]
  %t396 = xor i1 %t395, 1
  %t397 = load i8*, i8** %l0
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t399 = load i8, i8* %l2
  %t400 = load double, double* %l3
  %t401 = load i8*, i8** %l4
  %t402 = load double, double* %l5
  %t403 = load double, double* %l6
  %t404 = load double, double* %l7
  %t405 = load double, double* %l8
  %t406 = load double, double* %l9
  %t407 = load i1, i1* %l12
  %t408 = load double, double* %l13
  %t409 = load i8*, i8** %l14
  %t410 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br i1 %t396, label %then26, label %merge27
then26:
  %t411 = load i8*, i8** %l0
  %t412 = load double, double* %l13
  %t413 = sitofp i64 1 to double
  %t414 = fadd double %t412, %t413
  %t415 = load i8*, i8** %l0
  store double 0.0, double* %l25
  %t416 = load double, double* %l25
  br label %merge27
merge27:
  %t417 = load i1, i1* %l12
  %t418 = load i8*, i8** %l0
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t420 = load i8, i8* %l2
  %t421 = load double, double* %l3
  %t422 = load i8*, i8** %l4
  %t423 = load double, double* %l5
  %t424 = load double, double* %l6
  %t425 = load double, double* %l7
  %t426 = load double, double* %l8
  %t427 = load double, double* %l9
  %t428 = load i1, i1* %l12
  %t429 = load double, double* %l13
  %t430 = load i8*, i8** %l14
  %t431 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br i1 %t417, label %then28, label %merge29
then28:
  %t432 = alloca [0 x double]
  %t433 = getelementptr [0 x double], [0 x double]* %t432, i32 0, i32 0
  %t434 = alloca { double*, i64 }
  %t435 = getelementptr { double*, i64 }, { double*, i64 }* %t434, i32 0, i32 0
  store double* %t433, double** %t435
  %t436 = getelementptr { double*, i64 }, { double*, i64 }* %t434, i32 0, i32 1
  store i64 0, i64* %t436
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %merge29
merge29:
  %t437 = phi { %StructLiteralField*, i64 }* [ null, %then28 ], [ %t431, %entry ]
  store { %StructLiteralField*, i64 }* %t437, { %StructLiteralField*, i64 }** %l15
  %t438 = insertvalue %EnumLiteralParse undef, i1 1, 0
  %t439 = load i1, i1* %l12
  %t440 = xor i1 %t439, 1
  %t441 = insertvalue %EnumLiteralParse %t438, i1 %t440, 1
  %t442 = load i8*, i8** %l4
  %t443 = insertvalue %EnumLiteralParse %t441, i8* %t442, 2
  %t444 = load i8*, i8** %l14
  %t445 = insertvalue %EnumLiteralParse %t443, i8* %t444, 3
  %t446 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t447 = insertvalue %EnumLiteralParse %t445, { i8**, i64 }* null, 4
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t449 = insertvalue %EnumLiteralParse %t447, { i8**, i64 }* %t448, 5
  ret %EnumLiteralParse %t449
}

define %ExpressionResult @lower_struct_literal(%StructLiteralParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
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
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca i8*
  %l17 = alloca double
  %l18 = alloca i8*
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
  %t172 = phi { i8**, i64 }* [ %t17, %entry ], [ %t166, %loop.latch2 ]
  %t173 = phi { i8**, i64 }* [ %t18, %entry ], [ %t167, %loop.latch2 ]
  %t174 = phi double [ %t19, %entry ], [ %t168, %loop.latch2 ]
  %t175 = phi { %StringConstant*, i64 }* [ %t20, %entry ], [ %t169, %loop.latch2 ]
  %t176 = phi i8* [ %t23, %entry ], [ %t170, %loop.latch2 ]
  %t177 = phi double [ %t24, %entry ], [ %t171, %loop.latch2 ]
  store { i8**, i64 }* %t172, { i8**, i64 }** %l0
  store { i8**, i64 }* %t173, { i8**, i64 }** %l1
  store double %t174, double* %l2
  store { %StringConstant*, i64 }* %t175, { %StringConstant*, i64 }** %l3
  store i8* %t176, i8** %l6
  store double %t177, double* %l7
  br label %loop.body1
loop.body1:
  %t25 = load double, double* %l7
  %t26 = load double, double* %l4
  %t27 = load double, double* %l4
  store double 0.0, double* %l8
  %t28 = sitofp i64 -1 to double
  store double %t28, double* %l9
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l10
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t34 = load double, double* %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t36 = load i8*, i8** %l6
  %t37 = load double, double* %l7
  %t38 = load double, double* %l8
  %t39 = load double, double* %l9
  %t40 = load double, double* %l10
  br label %loop.header4
loop.header4:
  %t70 = phi double [ %t40, %loop.body1 ], [ %t69, %loop.latch6 ]
  store double %t70, double* %l10
  br label %loop.body5
loop.body5:
  %t41 = load double, double* %l10
  %t42 = extractvalue %StructLiteralParse %parse, 3
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = sitofp i64 %t44 to double
  %t46 = fcmp oge double %t41, %t45
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t51 = load double, double* %l4
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t53 = load i8*, i8** %l6
  %t54 = load double, double* %l7
  %t55 = load double, double* %l8
  %t56 = load double, double* %l9
  %t57 = load double, double* %l10
  br i1 %t46, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t58 = extractvalue %StructLiteralParse %parse, 3
  %t59 = load double, double* %l10
  %t60 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t61 = extractvalue { i8**, i64 } %t60, 0
  %t62 = extractvalue { i8**, i64 } %t60, 1
  %t63 = icmp uge i64 %t59, %t62
  ; bounds check: %t63 (if true, out of bounds)
  %t64 = getelementptr i8*, i8** %t61, i64 %t59
  %t65 = load i8*, i8** %t64
  %t66 = load double, double* %l10
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l10
  br label %loop.latch6
loop.latch6:
  %t69 = load double, double* %l10
  br label %loop.header4
afterloop7:
  store i8* null, i8** %l11
  %t71 = load double, double* %l9
  %t72 = sitofp i64 0 to double
  %t73 = fcmp oge double %t71, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load double, double* %l2
  %t77 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t78 = load double, double* %l4
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t80 = load i8*, i8** %l6
  %t81 = load double, double* %l7
  %t82 = load double, double* %l8
  %t83 = load double, double* %l9
  %t84 = load double, double* %l10
  %t85 = load i8*, i8** %l11
  br i1 %t73, label %then10, label %else11
then10:
  %t86 = extractvalue %StructLiteralParse %parse, 3
  %t87 = load double, double* %l9
  %t88 = load { i8**, i64 }, { i8**, i64 }* %t86
  %t89 = extractvalue { i8**, i64 } %t88, 0
  %t90 = extractvalue { i8**, i64 } %t88, 1
  %t91 = icmp uge i64 %t87, %t90
  ; bounds check: %t91 (if true, out of bounds)
  %t92 = getelementptr i8*, i8** %t89, i64 %t87
  %t93 = load i8*, i8** %t92
  store i8* %t93, i8** %l12
  %t94 = load i8*, i8** %l12
  %t95 = load double, double* %l2
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l13
  %t97 = load double, double* %l13
  %t98 = load double, double* %l13
  %t99 = load double, double* %l13
  %t100 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t101 = load double, double* %l13
  %t102 = load double, double* %l13
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t104 = load double, double* %l8
  br label %merge12
else11:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s106 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.106, i32 0, i32 0
  %t107 = load double, double* %l4
  br label %merge12
merge12:
  %t108 = phi { i8**, i64 }* [ null, %then10 ], [ null, %else11 ]
  %t109 = phi { i8**, i64 }* [ null, %then10 ], [ %t75, %else11 ]
  %t110 = phi double [ 0.0, %then10 ], [ %t76, %else11 ]
  %t111 = phi { %StringConstant*, i64 }* [ null, %then10 ], [ %t77, %else11 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  store { i8**, i64 }* %t109, { i8**, i64 }** %l1
  store double %t110, double* %l2
  store { %StringConstant*, i64 }* %t111, { %StringConstant*, i64 }** %l3
  %t112 = load double, double* %l8
  store i8* null, i8** %l14
  %t113 = load i8*, i8** %l11
  %t114 = icmp ne i8* %t113, null
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = load double, double* %l2
  %t118 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t119 = load double, double* %l4
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t121 = load i8*, i8** %l6
  %t122 = load double, double* %l7
  %t123 = load double, double* %l8
  %t124 = load double, double* %l9
  %t125 = load double, double* %l10
  %t126 = load i8*, i8** %l11
  %t127 = load i8*, i8** %l14
  br i1 %t114, label %then13, label %merge14
then13:
  %t128 = load i8*, i8** %l11
  br label %merge14
merge14:
  %t129 = phi i8* [ null, %then13 ], [ %t127, %loop.body1 ]
  store i8* %t129, i8** %l14
  %s130 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.130, i32 0, i32 0
  store i8* %s130, i8** %l15
  %t131 = load double, double* %l7
  %t132 = sitofp i64 0 to double
  %t133 = fcmp ogt double %t131, %t132
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t136 = load double, double* %l2
  %t137 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t138 = load double, double* %l4
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t140 = load i8*, i8** %l6
  %t141 = load double, double* %l7
  %t142 = load double, double* %l8
  %t143 = load double, double* %l9
  %t144 = load double, double* %l10
  %t145 = load i8*, i8** %l11
  %t146 = load i8*, i8** %l14
  %t147 = load i8*, i8** %l15
  br i1 %t133, label %then15, label %merge16
then15:
  %t148 = load i8*, i8** %l6
  store i8* %t148, i8** %l15
  br label %merge16
merge16:
  %t149 = phi i8* [ %t148, %then15 ], [ %t147, %loop.body1 ]
  store i8* %t149, i8** %l15
  %t150 = load double, double* %l2
  %t151 = call i8* @format_temp_name(double %t150)
  store i8* %t151, i8** %l16
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s153 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.153, i32 0, i32 0
  %t154 = load i8*, i8** %l16
  %t155 = add i8* %s153, %t154
  %s156 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.156, i32 0, i32 0
  %t157 = add i8* %t155, %s156
  %t158 = load double, double* %l4
  %t159 = load double, double* %l2
  %t160 = sitofp i64 1 to double
  %t161 = fadd double %t159, %t160
  store double %t161, double* %l2
  %t162 = load i8*, i8** %l16
  store i8* %t162, i8** %l6
  %t163 = load double, double* %l7
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l7
  br label %loop.latch2
loop.latch2:
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load double, double* %l2
  %t169 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t170 = load i8*, i8** %l6
  %t171 = load double, double* %l7
  br label %loop.header0
afterloop3:
  %t178 = sitofp i64 0 to double
  store double %t178, double* %l17
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t181 = load double, double* %l2
  %t182 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t183 = load double, double* %l4
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t185 = load i8*, i8** %l6
  %t186 = load double, double* %l7
  %t187 = load double, double* %l17
  br label %loop.header17
loop.header17:
  %t217 = phi double [ %t187, %entry ], [ %t216, %loop.latch19 ]
  store double %t217, double* %l17
  br label %loop.body18
loop.body18:
  %t188 = load double, double* %l17
  %t189 = extractvalue %StructLiteralParse %parse, 3
  %t190 = load { i8**, i64 }, { i8**, i64 }* %t189
  %t191 = extractvalue { i8**, i64 } %t190, 1
  %t192 = sitofp i64 %t191 to double
  %t193 = fcmp oge double %t188, %t192
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t196 = load double, double* %l2
  %t197 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t198 = load double, double* %l4
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t200 = load i8*, i8** %l6
  %t201 = load double, double* %l7
  %t202 = load double, double* %l17
  br i1 %t193, label %then21, label %merge22
then21:
  br label %afterloop20
merge22:
  %t203 = extractvalue %StructLiteralParse %parse, 3
  %t204 = load double, double* %l17
  %t205 = load { i8**, i64 }, { i8**, i64 }* %t203
  %t206 = extractvalue { i8**, i64 } %t205, 0
  %t207 = extractvalue { i8**, i64 } %t205, 1
  %t208 = icmp uge i64 %t204, %t207
  ; bounds check: %t208 (if true, out of bounds)
  %t209 = getelementptr i8*, i8** %t206, i64 %t204
  %t210 = load i8*, i8** %t209
  store i8* %t210, i8** %l18
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t212 = load i8*, i8** %l18
  %t213 = load double, double* %l17
  %t214 = sitofp i64 1 to double
  %t215 = fadd double %t213, %t214
  store double %t215, double* %l17
  br label %loop.latch19
loop.latch19:
  %t216 = load double, double* %l17
  br label %loop.header17
afterloop20:
  %t218 = load i8*, i8** %l6
  %t219 = load double, double* %l4
  %t220 = insertvalue %LLVMOperand undef, i8* null, 0
  %t221 = load i8*, i8** %l6
  %t222 = insertvalue %LLVMOperand %t220, i8* %t221, 1
  store %LLVMOperand %t222, %LLVMOperand* %l19
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t223, 0
  %t225 = load double, double* %l2
  %t226 = insertvalue %ExpressionResult %t224, double %t225, 1
  %t227 = load %LLVMOperand, %LLVMOperand* %l19
  %t228 = insertvalue %ExpressionResult %t226, i8* null, 2
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t230 = insertvalue %ExpressionResult %t228, { i8**, i64 }* %t229, 3
  %t231 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t232 = insertvalue %ExpressionResult %t230, { i8**, i64 }* null, 4
  ret %ExpressionResult %t232
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
  %t11 = load double, double* %l2
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8*, i8** %l4
  %t17 = add i8* %s15, %t16
  %t18 = load double, double* %l2
  %t19 = call i8* @format_temp_name(double %t18)
  store i8* %t19, i8** %l5
  %t20 = load double, double* %l2
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.24, i32 0, i32 0
  %t25 = load i8*, i8** %l5
  %t26 = add i8* %s24, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s28 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.28, i32 0, i32 0
  %t29 = extractvalue %LLVMOperand %operand, 0
  %t30 = add i8* %s28, %t29
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = add i8* %t30, %s31
  %t33 = extractvalue %LLVMOperand %operand, 1
  %t34 = add i8* %t32, %t33
  store double 0.0, double* %l6
  %t35 = call i8* @trim_text(i8* %expected_pointer_type)
  store i8* %t35, i8** %l7
  %t37 = load i8*, i8** %l7
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %HeapBoxResult undef, { i8**, i64 }* %t38, 0
  %t40 = load double, double* %l2
  %t41 = insertvalue %HeapBoxResult %t39, double %t40, 1
  %t42 = load double, double* %l6
  %t43 = insertvalue %HeapBoxResult %t41, i8* null, 2
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = insertvalue %HeapBoxResult %t43, { i8**, i64 }* %t44, 3
  ret %HeapBoxResult %t45
}

define %ExpressionResult @lower_enum_literal(%EnumLiteralParse %parse, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %temp_index, { i8**, i64 }* %lines, { i8**, i64 }* %functions, %TypeContext %context) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
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
  store i8* null, i8** %l7
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
  %t7 = icmp ne i8* %t5, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s11 = getelementptr inbounds [59 x i8], [59 x i8]* @.str.11, i32 0, i32 0
  %t12 = extractvalue %LLVMOperand %left_operand, 0
  %t13 = add i8* %s11, %t12
  %s14 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  %t16 = extractvalue %LLVMOperand %right_operand, 0
  %t17 = add i8* %t15, %t16
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = add i8* %t17, %s18
  %t20 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t10, i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  br label %merge1
merge1:
  %t21 = phi { i8**, i64 }* [ %t20, %then0 ], [ %t8, %entry ]
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  %t22 = extractvalue %LLVMOperand %left_operand, 0
  store i8* %t22, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = call i8* @comparison_predicate_for_symbol(i8* %symbol, i8* %t23)
  store i8* %t24, i8** %l3
  %t25 = load i8*, i8** %l3
  %t26 = call i8* @format_temp_name(double %temp_index)
  store i8* %t26, i8** %l4
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s28 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.28, i32 0, i32 0
  %t29 = load i8*, i8** %l4
  %t30 = add i8* %s28, %t29
  %s31 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.31, i32 0, i32 0
  %t32 = add i8* %t30, %s31
  %t33 = load i8*, i8** %l3
  %t34 = add i8* %t32, %t33
  %s35 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.35, i32 0, i32 0
  %t36 = add i8* %t34, %s35
  %t37 = load i8*, i8** %l2
  %t38 = add i8* %t36, %t37
  %s39 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.39, i32 0, i32 0
  %t40 = add i8* %t38, %s39
  %t41 = extractvalue %LLVMOperand %left_operand, 1
  %t42 = add i8* %t40, %t41
  %s43 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.43, i32 0, i32 0
  %t44 = insertvalue %LLVMOperand undef, i8* %s43, 0
  %t45 = load i8*, i8** %l4
  %t46 = insertvalue %LLVMOperand %t44, i8* %t45, 1
  store %LLVMOperand %t46, %LLVMOperand* %l5
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
  %t7 = icmp ne i8* %t5, %s6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge1
merge1:
  %t11 = phi { i8**, i64 }* [ null, %then0 ], [ %t8, %entry ]
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  %t12 = extractvalue %LLVMOperand %right_operand, 0
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = icmp ne i8* %t12, %s13
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t14, label %then2, label %merge3
then2:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge3
merge3:
  %t18 = phi { i8**, i64 }* [ null, %then2 ], [ %t15, %entry ]
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = call i8* @format_temp_name(double %temp_index)
  store i8* %t19, i8** %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.21, i32 0, i32 0
  %t22 = load i8*, i8** %l2
  %t23 = add i8* %s21, %t22
  %s24 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.24, i32 0, i32 0
  %t25 = add i8* %t23, %s24
  %t26 = extractvalue %LLVMOperand %left_operand, 1
  %t27 = add i8* %t25, %t26
  %s28 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.28, i32 0, i32 0
  %t29 = insertvalue %LLVMOperand undef, i8* %s28, 0
  %t30 = load i8*, i8** %l2
  %t31 = insertvalue %LLVMOperand %t29, i8* %t30, 1
  store %LLVMOperand %t31, %LLVMOperand* %l3
  ret %ComparisonEmission zeroinitializer
}

define i8* @comparison_predicate_for_symbol(i8* %symbol, i8* %llvm_type) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %llvm_type, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %llvm_type, %s4
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s6 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %llvm_type, %s6
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t8 = phi i1 [ true, %logical_or_entry_3 ], [ %t7, %logical_or_right_end_3 ]
  br i1 %t8, label %then2, label %merge3
then2:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
merge3:
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.10, i32 0, i32 0
  %t11 = icmp eq i8* %llvm_type, %s10
  br i1 %t11, label %then4, label %merge5
then4:
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.12, i32 0, i32 0
  ret i8* %s12
merge5:
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = icmp eq i8* %llvm_type, %s13
  br i1 %t14, label %then6, label %merge7
then6:
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  ret i8* %s15
merge7:
  %s16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.16, i32 0, i32 0
  ret i8* %s16
}

define { i8**, i64 }* @collect_parameter_types(%TypeContext %context, { i8**, i64 }* %parameters) {
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
  %t27 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store double 0.0, double* %l2
  %t22 = load double, double* %l2
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t28
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
  %l2 = alloca i8*
  %l3 = alloca %LLVMOperand
  %l4 = alloca i8*
  %l5 = alloca %LLVMOperand
  %l6 = alloca i8*
  %l7 = alloca %LLVMOperand
  %l8 = alloca i8*
  %l9 = alloca %LLVMOperand
  %l10 = alloca i8*
  %l11 = alloca %LLVMOperand
  %l12 = alloca i8*
  %l13 = alloca %LLVMOperand
  %l14 = alloca i8*
  %l15 = alloca %LLVMOperand
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
  %t6 = icmp eq i8* %t5, %target_type
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t10 = insertvalue %CoercionResult undef, { i8**, i64 }* %t9, 0
  %t11 = insertvalue %CoercionResult %t10, double %temp_index, 1
  %t12 = insertvalue %CoercionResult %t11, i8* null, 2
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = insertvalue %CoercionResult %t12, { i8**, i64 }* %t13, 3
  ret %CoercionResult %t14
merge1:
  %s15 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.15, i32 0, i32 0
  %t16 = icmp eq i8* %target_type, %s15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t16, label %then2, label %merge3
then2:
  %t19 = extractvalue %LLVMOperand %operand, 0
  %s20 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %t19, %s20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t21, label %then4, label %merge5
then4:
  %t24 = call i8* @format_temp_name(double %temp_index)
  store i8* %t24, i8** %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.26, i32 0, i32 0
  %t27 = load i8*, i8** %l2
  %t28 = add i8* %s26, %t27
  %s29 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %t28, %s29
  %t31 = extractvalue %LLVMOperand %operand, 1
  %t32 = add i8* %t30, %t31
  %s33 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.33, i32 0, i32 0
  %t34 = add i8* %t32, %s33
  %t35 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t25, i8* %t34)
  store { i8**, i64 }* %t35, { i8**, i64 }** %l1
  %s36 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.36, i32 0, i32 0
  %t37 = insertvalue %LLVMOperand undef, i8* %s36, 0
  %t38 = load i8*, i8** %l2
  %t39 = insertvalue %LLVMOperand %t37, i8* %t38, 1
  store %LLVMOperand %t39, %LLVMOperand* %l3
  ret %CoercionResult zeroinitializer
merge5:
  %t40 = extractvalue %LLVMOperand %operand, 0
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.41, i32 0, i32 0
  %t42 = icmp eq i8* %t40, %s41
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t42, label %then6, label %merge7
then6:
  %t45 = call i8* @format_temp_name(double %temp_index)
  store i8* %t45, i8** %l4
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s47 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.47, i32 0, i32 0
  %t48 = load i8*, i8** %l4
  %t49 = add i8* %s47, %t48
  %s50 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.50, i32 0, i32 0
  %t51 = add i8* %t49, %s50
  %t52 = extractvalue %LLVMOperand %operand, 1
  %t53 = add i8* %t51, %t52
  %s54 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.54, i32 0, i32 0
  %t55 = add i8* %t53, %s54
  %t56 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t46, i8* %t55)
  store { i8**, i64 }* %t56, { i8**, i64 }** %l1
  %s57 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.57, i32 0, i32 0
  %t58 = insertvalue %LLVMOperand undef, i8* %s57, 0
  %t59 = load i8*, i8** %l4
  %t60 = insertvalue %LLVMOperand %t58, i8* %t59, 1
  store %LLVMOperand %t60, %LLVMOperand* %l5
  ret %CoercionResult zeroinitializer
merge7:
  br label %merge3
merge3:
  %t61 = phi { i8**, i64 }* [ %t35, %then2 ], [ %t18, %entry ]
  %t62 = phi { i8**, i64 }* [ %t56, %then2 ], [ %t18, %entry ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l1
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  %s63 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.63, i32 0, i32 0
  %t64 = icmp eq i8* %target_type, %s63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t64, label %then8, label %merge9
then8:
  %t67 = extractvalue %LLVMOperand %operand, 0
  %s68 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.68, i32 0, i32 0
  %t69 = icmp eq i8* %t67, %s68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t69, label %then10, label %merge11
then10:
  %t72 = call i8* @format_temp_name(double %temp_index)
  store i8* %t72, i8** %l6
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s74 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.74, i32 0, i32 0
  %t75 = load i8*, i8** %l6
  %t76 = add i8* %s74, %t75
  %s77 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.77, i32 0, i32 0
  %t78 = add i8* %t76, %s77
  %t79 = extractvalue %LLVMOperand %operand, 1
  %t80 = add i8* %t78, %t79
  %s81 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.81, i32 0, i32 0
  %t82 = add i8* %t80, %s81
  %t83 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t73, i8* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l1
  %s84 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.84, i32 0, i32 0
  %t85 = insertvalue %LLVMOperand undef, i8* %s84, 0
  %t86 = load i8*, i8** %l6
  %t87 = insertvalue %LLVMOperand %t85, i8* %t86, 1
  store %LLVMOperand %t87, %LLVMOperand* %l7
  ret %CoercionResult zeroinitializer
merge11:
  %t88 = extractvalue %LLVMOperand %operand, 0
  %s89 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.89, i32 0, i32 0
  %t90 = icmp eq i8* %t88, %s89
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t90, label %then12, label %merge13
then12:
  %t93 = call i8* @format_temp_name(double %temp_index)
  store i8* %t93, i8** %l8
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s95 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.95, i32 0, i32 0
  %t96 = load i8*, i8** %l8
  %t97 = add i8* %s95, %t96
  %s98 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.98, i32 0, i32 0
  %t99 = add i8* %t97, %s98
  %t100 = extractvalue %LLVMOperand %operand, 1
  %t101 = add i8* %t99, %t100
  %s102 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %t101, %s102
  %t104 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t94, i8* %t103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l1
  %s105 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.105, i32 0, i32 0
  %t106 = insertvalue %LLVMOperand undef, i8* %s105, 0
  %t107 = load i8*, i8** %l8
  %t108 = insertvalue %LLVMOperand %t106, i8* %t107, 1
  store %LLVMOperand %t108, %LLVMOperand* %l9
  ret %CoercionResult zeroinitializer
merge13:
  %t109 = extractvalue %LLVMOperand %operand, 0
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.110, i32 0, i32 0
  %t111 = icmp eq i8* %t109, %s110
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t111, label %then14, label %merge15
then14:
  %t114 = call i8* @format_temp_name(double %temp_index)
  store i8* %t114, i8** %l10
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s116 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.116, i32 0, i32 0
  %t117 = load i8*, i8** %l10
  %t118 = add i8* %s116, %t117
  %s119 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.119, i32 0, i32 0
  %t120 = add i8* %t118, %s119
  %t121 = extractvalue %LLVMOperand %operand, 1
  %t122 = add i8* %t120, %t121
  %s123 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.123, i32 0, i32 0
  %t124 = add i8* %t122, %s123
  %t125 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t115, i8* %t124)
  store { i8**, i64 }* %t125, { i8**, i64 }** %l1
  %s126 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.126, i32 0, i32 0
  %t127 = insertvalue %LLVMOperand undef, i8* %s126, 0
  %t128 = load i8*, i8** %l10
  %t129 = insertvalue %LLVMOperand %t127, i8* %t128, 1
  store %LLVMOperand %t129, %LLVMOperand* %l11
  ret %CoercionResult zeroinitializer
merge15:
  br label %merge9
merge9:
  %t130 = phi { i8**, i64 }* [ %t83, %then8 ], [ %t66, %entry ]
  %t131 = phi { i8**, i64 }* [ %t104, %then8 ], [ %t66, %entry ]
  %t132 = phi { i8**, i64 }* [ %t125, %then8 ], [ %t66, %entry ]
  store { i8**, i64 }* %t130, { i8**, i64 }** %l1
  store { i8**, i64 }* %t131, { i8**, i64 }** %l1
  store { i8**, i64 }* %t132, { i8**, i64 }** %l1
  %s133 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.133, i32 0, i32 0
  %t134 = icmp eq i8* %target_type, %s133
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t134, label %then16, label %merge17
then16:
  %t137 = extractvalue %LLVMOperand %operand, 0
  %s138 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.138, i32 0, i32 0
  %t139 = icmp eq i8* %t137, %s138
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t139, label %then18, label %merge19
then18:
  %t142 = call i8* @format_temp_name(double %temp_index)
  store i8* %t142, i8** %l12
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s144 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.144, i32 0, i32 0
  %t145 = load i8*, i8** %l12
  %t146 = add i8* %s144, %t145
  %s147 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.147, i32 0, i32 0
  %t148 = add i8* %t146, %s147
  %t149 = extractvalue %LLVMOperand %operand, 1
  %t150 = add i8* %t148, %t149
  %s151 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.151, i32 0, i32 0
  %t152 = insertvalue %LLVMOperand undef, i8* %s151, 0
  %t153 = load i8*, i8** %l12
  %t154 = insertvalue %LLVMOperand %t152, i8* %t153, 1
  store %LLVMOperand %t154, %LLVMOperand* %l13
  ret %CoercionResult zeroinitializer
merge19:
  %t155 = extractvalue %LLVMOperand %operand, 0
  %s156 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.156, i32 0, i32 0
  %t157 = icmp eq i8* %t155, %s156
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t157, label %then20, label %merge21
then20:
  %t160 = call i8* @format_temp_name(double %temp_index)
  store i8* %t160, i8** %l14
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s162 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.162, i32 0, i32 0
  %t163 = load i8*, i8** %l14
  %t164 = add i8* %s162, %t163
  %s165 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.165, i32 0, i32 0
  %t166 = add i8* %t164, %s165
  %t167 = extractvalue %LLVMOperand %operand, 1
  %t168 = add i8* %t166, %t167
  %s169 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.169, i32 0, i32 0
  %t170 = insertvalue %LLVMOperand undef, i8* %s169, 0
  %t171 = load i8*, i8** %l14
  %t172 = insertvalue %LLVMOperand %t170, i8* %t171, 1
  store %LLVMOperand %t172, %LLVMOperand* %l15
  ret %CoercionResult zeroinitializer
merge21:
  br label %merge17
merge17:
  %t173 = phi { i8**, i64 }* [ null, %then16 ], [ %t136, %entry ]
  %t174 = phi { i8**, i64 }* [ null, %then16 ], [ %t136, %entry ]
  store { i8**, i64 }* %t173, { i8**, i64 }** %l1
  store { i8**, i64 }* %t174, { i8**, i64 }** %l1
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s176 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.176, i32 0, i32 0
  %t177 = extractvalue %LLVMOperand %operand, 0
  %t178 = add i8* %s176, %t177
  %s179 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.179, i32 0, i32 0
  %t180 = add i8* %t178, %s179
  %t181 = add i8* %t180, %target_type
  %s182 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.182, i32 0, i32 0
  %t183 = add i8* %t181, %s182
  %t184 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t175, i8* %t183)
  store { i8**, i64 }* %t184, { i8**, i64 }** %l0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = insertvalue %CoercionResult undef, { i8**, i64 }* %t185, 0
  %t187 = insertvalue %CoercionResult %t186, double %temp_index, 1
  %t188 = insertvalue %CoercionResult %t187, i8* null, 2
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = insertvalue %CoercionResult %t188, { i8**, i64 }* %t189, 3
  ret %CoercionResult %t190
}

define i8* @dominant_type(i8* %first, i8* %second) {
entry:
  %t0 = icmp eq i8* %first, %second
  br i1 %t0, label %then0, label %merge1
then0:
  ret i8* %first
merge1:
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  %t3 = icmp eq i8* %first, %s2
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t3, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s4 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %second, %s4
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t6 = phi i1 [ true, %logical_or_entry_1 ], [ %t5, %logical_or_right_end_1 ]
  br i1 %t6, label %then2, label %merge3
then2:
  %s7 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.7, i32 0, i32 0
  ret i8* %s7
merge3:
  %s9 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %first, %s9
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t10, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %second, %s11
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t13 = phi i1 [ true, %logical_or_entry_8 ], [ %t12, %logical_or_right_end_8 ]
  br i1 %t13, label %then4, label %merge5
then4:
  %s14 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.14, i32 0, i32 0
  ret i8* %s14
merge5:
  %s17 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.17, i32 0, i32 0
  %t18 = icmp eq i8* %first, %s17
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t18, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %s19 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.19, i32 0, i32 0
  %t20 = icmp eq i8* %second, %s19
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t21 = phi i1 [ false, %logical_and_entry_16 ], [ %t20, %logical_and_right_end_16 ]
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t21, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.23, i32 0, i32 0
  %t24 = icmp eq i8* %first, %s23
  br label %logical_and_entry_22

logical_and_entry_22:
  br i1 %t24, label %logical_and_right_22, label %logical_and_merge_22

logical_and_right_22:
  %s25 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.25, i32 0, i32 0
  %t26 = icmp eq i8* %second, %s25
  br label %logical_and_right_end_22

logical_and_right_end_22:
  br label %logical_and_merge_22

logical_and_merge_22:
  %t27 = phi i1 [ false, %logical_and_entry_22 ], [ %t26, %logical_and_right_end_22 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t28 = phi i1 [ true, %logical_or_entry_15 ], [ %t27, %logical_or_right_end_15 ]
  br i1 %t28, label %then6, label %merge7
then6:
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.29, i32 0, i32 0
  ret i8* %s29
merge7:
  %s31 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.31, i32 0, i32 0
  %t32 = icmp eq i8* %first, %s31
  br label %logical_or_entry_30

logical_or_entry_30:
  br i1 %t32, label %logical_or_merge_30, label %logical_or_right_30

logical_or_right_30:
  %s33 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp eq i8* %second, %s33
  br label %logical_or_right_end_30

logical_or_right_end_30:
  br label %logical_or_merge_30

logical_or_merge_30:
  %t35 = phi i1 [ true, %logical_or_entry_30 ], [ %t34, %logical_or_right_end_30 ]
  br i1 %t35, label %then8, label %merge9
then8:
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.36, i32 0, i32 0
  ret i8* %s36
merge9:
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
  %t9 = icmp eq i8* %t6, %t8
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  %t13 = load %LLVMOperand, %LLVMOperand* %l3
  %t14 = load %LLVMOperand, %LLVMOperand* %l4
  br i1 %t9, label %then0, label %merge1
then0:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = insertvalue %BinaryAlignmentResult undef, { i8**, i64 }* %t15, 0
  %t17 = load double, double* %l2
  %t18 = insertvalue %BinaryAlignmentResult %t16, double %t17, 1
  %t19 = load %LLVMOperand, %LLVMOperand* %l3
  %t20 = insertvalue %BinaryAlignmentResult %t18, i8* null, 2
  %t21 = load %LLVMOperand, %LLVMOperand* %l4
  %t22 = insertvalue %BinaryAlignmentResult %t20, i8* null, 3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = insertvalue %BinaryAlignmentResult %t22, { i8**, i64 }* %t23, 4
  %t25 = load %LLVMOperand, %LLVMOperand* %l3
  %t26 = extractvalue %LLVMOperand %t25, 0
  %t27 = insertvalue %BinaryAlignmentResult %t24, i8* %t26, 5
  ret %BinaryAlignmentResult %t27
merge1:
  %t28 = load %LLVMOperand, %LLVMOperand* %l3
  %t29 = extractvalue %LLVMOperand %t28, 0
  %t30 = load %LLVMOperand, %LLVMOperand* %l4
  %t31 = extractvalue %LLVMOperand %t30, 0
  %t32 = call i8* @dominant_type(i8* %t29, i8* %t31)
  store i8* %t32, i8** %l5
  %t33 = load %LLVMOperand, %LLVMOperand* %l3
  %t34 = load i8*, i8** %l5
  %t35 = load double, double* %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand %t33, i8* %t34, double %t35, { i8**, i64 }* %t36)
  store %CoercionResult %t37, %CoercionResult* %l6
  %t38 = load %CoercionResult, %CoercionResult* %l6
  %t39 = extractvalue %CoercionResult %t38, 3
  %t40 = call double @diagnosticsconcat({ i8**, i64 }* %t39)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t41 = load %CoercionResult, %CoercionResult* %l6
  %t42 = extractvalue %CoercionResult %t41, 2
  %t43 = icmp eq i8* %t42, null
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load double, double* %l2
  %t47 = load %LLVMOperand, %LLVMOperand* %l3
  %t48 = load %LLVMOperand, %LLVMOperand* %l4
  %t49 = load i8*, i8** %l5
  %t50 = load %CoercionResult, %CoercionResult* %l6
  br i1 %t43, label %then2, label %merge3
then2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s52 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.52, i32 0, i32 0
  %t53 = load %LLVMOperand, %LLVMOperand* %l3
  %t54 = extractvalue %LLVMOperand %t53, 0
  %t55 = add i8* %s52, %t54
  %s56 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  %t57 = add i8* %t55, %s56
  %t58 = load i8*, i8** %l5
  %t59 = add i8* %t57, %t58
  %s60 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.60, i32 0, i32 0
  %t61 = add i8* %t59, %s60
  %t62 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t51, i8* %t61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  %t63 = load %CoercionResult, %CoercionResult* %l6
  %t64 = extractvalue %CoercionResult %t63, 0
  %t65 = insertvalue %BinaryAlignmentResult undef, { i8**, i64 }* %t64, 0
  %t66 = load %CoercionResult, %CoercionResult* %l6
  %t67 = extractvalue %CoercionResult %t66, 1
  %t68 = insertvalue %BinaryAlignmentResult %t65, double %t67, 1
  %t69 = insertvalue %BinaryAlignmentResult %t68, i8* null, 2
  %t70 = insertvalue %BinaryAlignmentResult %t69, i8* null, 3
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = insertvalue %BinaryAlignmentResult %t70, { i8**, i64 }* %t71, 4
  %t73 = load i8*, i8** %l5
  %t74 = insertvalue %BinaryAlignmentResult %t72, i8* %t73, 5
  ret %BinaryAlignmentResult %t74
merge3:
  %t75 = load %CoercionResult, %CoercionResult* %l6
  %t76 = extractvalue %CoercionResult %t75, 2
  store %LLVMOperand zeroinitializer, %LLVMOperand* %l3
  %t77 = load %CoercionResult, %CoercionResult* %l6
  %t78 = extractvalue %CoercionResult %t77, 0
  store { i8**, i64 }* %t78, { i8**, i64 }** %l1
  %t79 = load %CoercionResult, %CoercionResult* %l6
  %t80 = extractvalue %CoercionResult %t79, 1
  store double %t80, double* %l2
  %t81 = load %LLVMOperand, %LLVMOperand* %l4
  %t82 = load i8*, i8** %l5
  %t83 = load double, double* %l2
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand %t81, i8* %t82, double %t83, { i8**, i64 }* %t84)
  store %CoercionResult %t85, %CoercionResult* %l7
  %t86 = load %CoercionResult, %CoercionResult* %l7
  %t87 = extractvalue %CoercionResult %t86, 3
  %t88 = call double @diagnosticsconcat({ i8**, i64 }* %t87)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t89 = load %CoercionResult, %CoercionResult* %l7
  %t90 = extractvalue %CoercionResult %t89, 2
  %t91 = icmp eq i8* %t90, null
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load double, double* %l2
  %t95 = load %LLVMOperand, %LLVMOperand* %l3
  %t96 = load %LLVMOperand, %LLVMOperand* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load %CoercionResult, %CoercionResult* %l6
  %t99 = load %CoercionResult, %CoercionResult* %l7
  br i1 %t91, label %then4, label %merge5
then4:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s101 = getelementptr inbounds [54 x i8], [54 x i8]* @.str.101, i32 0, i32 0
  %t102 = load %LLVMOperand, %LLVMOperand* %l4
  %t103 = extractvalue %LLVMOperand %t102, 0
  %t104 = add i8* %s101, %t103
  %s105 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.105, i32 0, i32 0
  %t106 = add i8* %t104, %s105
  %t107 = load i8*, i8** %l5
  %t108 = add i8* %t106, %t107
  %s109 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.109, i32 0, i32 0
  %t110 = add i8* %t108, %s109
  %t111 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t100, i8* %t110)
  store { i8**, i64 }* %t111, { i8**, i64 }** %l0
  %t112 = load %CoercionResult, %CoercionResult* %l7
  %t113 = extractvalue %CoercionResult %t112, 0
  %t114 = insertvalue %BinaryAlignmentResult undef, { i8**, i64 }* %t113, 0
  %t115 = load %CoercionResult, %CoercionResult* %l7
  %t116 = extractvalue %CoercionResult %t115, 1
  %t117 = insertvalue %BinaryAlignmentResult %t114, double %t116, 1
  %t118 = insertvalue %BinaryAlignmentResult %t117, i8* null, 2
  %t119 = insertvalue %BinaryAlignmentResult %t118, i8* null, 3
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = insertvalue %BinaryAlignmentResult %t119, { i8**, i64 }* %t120, 4
  %t122 = load i8*, i8** %l5
  %t123 = insertvalue %BinaryAlignmentResult %t121, i8* %t122, 5
  ret %BinaryAlignmentResult %t123
merge5:
  %t124 = load %CoercionResult, %CoercionResult* %l7
  %t125 = extractvalue %CoercionResult %t124, 2
  store %LLVMOperand zeroinitializer, %LLVMOperand* %l4
  %t126 = load %CoercionResult, %CoercionResult* %l7
  %t127 = extractvalue %CoercionResult %t126, 0
  store { i8**, i64 }* %t127, { i8**, i64 }** %l1
  %t128 = load %CoercionResult, %CoercionResult* %l7
  %t129 = extractvalue %CoercionResult %t128, 1
  store double %t129, double* %l2
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = insertvalue %BinaryAlignmentResult undef, { i8**, i64 }* %t130, 0
  %t132 = load double, double* %l2
  %t133 = insertvalue %BinaryAlignmentResult %t131, double %t132, 1
  %t134 = load %LLVMOperand, %LLVMOperand* %l3
  %t135 = insertvalue %BinaryAlignmentResult %t133, i8* null, 2
  %t136 = load %LLVMOperand, %LLVMOperand* %l4
  %t137 = insertvalue %BinaryAlignmentResult %t135, i8* null, 3
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = insertvalue %BinaryAlignmentResult %t137, { i8**, i64 }* %t138, 4
  %t140 = load i8*, i8** %l5
  %t141 = insertvalue %BinaryAlignmentResult %t139, i8* %t140, 5
  ret %BinaryAlignmentResult %t141
}

define i8* @strip_enclosing_parentheses(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = getelementptr i8, i8* %t2, i64 0
  %t4 = load i8, i8* %t3
  %s5 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.5, i32 0, i32 0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l1
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t10, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l2
  %t15 = getelementptr i8, i8* %t13, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l3
  %t17 = load i8, i8* %l3
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load double, double* %l2
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l2
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t24 = load i8*, i8** %l0
  ret i8* %t24
}

define %OperatorMatch @find_top_level_operator(i8* %expression, i8* %operators) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi double [ %t2, %entry ], [ %t39, %loop.latch2 ]
  store double %t40, double* %l1
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
  %t9 = sitofp i64 1 to double
  %t10 = fsub double %t8, %t9
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = getelementptr i8, i8* %expression, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8, i8* %l2
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = load double, double* %l0
  %t19 = sitofp i64 0 to double
  %t20 = fcmp ogt double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t24 = load i8, i8* %l2
  %t25 = call i1 @contains_char(i8* %operators, i8* null)
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = load i8, i8* %l2
  br i1 %t25, label %then8, label %merge9
then8:
  %t29 = load i8, i8* %l2
  %t30 = load double, double* %l1
  %t31 = insertvalue %OperatorMatch undef, double %t30, 0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @substring(i8* %expression, double %t32, double %t35)
  %t37 = insertvalue %OperatorMatch %t31, i8* null, 1
  %t38 = insertvalue %OperatorMatch %t37, i1 1, 2
  ret %OperatorMatch %t38
merge9:
  br label %loop.latch2
loop.latch2:
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret %OperatorMatch zeroinitializer
}

define %OperatorMatch @find_comparison_operator(i8* %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t3, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = load i8, i8* %l2
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load double, double* %l0
  %t13 = sitofp i64 0 to double
  %t14 = fcmp ogt double %t12, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
merge5:
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  %t25 = load i8, i8* %l2
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret %OperatorMatch zeroinitializer
}

define %OperatorMatch @find_logical_operator(i8* %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t2, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = sitofp i64 1 to double
  %t5 = fcmp ole double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l1
  %t9 = sitofp i64 1 to double
  %t10 = fsub double %t8, %t9
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = getelementptr i8, i8* %expression, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8, i8* %l2
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = load double, double* %l0
  %t19 = sitofp i64 0 to double
  %t20 = fcmp ogt double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l0
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t57 = phi double [ %t31, %entry ], [ %t56, %loop.latch10 ]
  store double %t57, double* %l1
  br label %loop.body9
loop.body9:
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fcmp ole double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fsub double %t37, %t38
  store double %t39, double* %l1
  %t40 = load double, double* %l1
  %t41 = getelementptr i8, i8* %expression, i64 %t40
  %t42 = load i8, i8* %t41
  store i8 %t42, i8* %l3
  %t43 = load i8, i8* %l3
  %s44 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.44, i32 0, i32 0
  %t45 = load i8, i8* %l3
  %s46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.46, i32 0, i32 0
  %t47 = load double, double* %l0
  %t48 = sitofp i64 0 to double
  %t49 = fcmp ogt double %t47, %t48
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load i8, i8* %l3
  br i1 %t49, label %then14, label %merge15
then14:
  br label %loop.latch10
merge15:
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  br label %loop.latch10
loop.latch10:
  %t56 = load double, double* %l1
  br label %loop.header8
afterloop11:
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
  %t10 = phi double [ %t1, %entry ], [ %t9, %loop.latch2 ]
  store double %t10, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %set, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %t6, %t7
  store double %t8, double* %l0
  br label %loop.latch2
loop.latch2:
  %t9 = load double, double* %l0
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
  %t9 = load double, double* %l2
  %t10 = load double, double* %l1
  %t11 = load double, double* %l1
  store double %t11, double* %l3
  %t13 = load double, double* %l3
  ret i1 1
}

define double @find_call_site(i8* %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t14 = phi double [ %t3, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t15 = sitofp i64 -1 to double
  ret double %t15
}

define { i8**, i64 }* @split_call_arguments(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8
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
  %t29 = phi double [ %t18, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l6
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l6
  %t20 = load double, double* %l6
  %t21 = getelementptr i8, i8* %text, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l7
  %t23 = load i8, i8* %l7
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  %t25 = load double, double* %l6
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l6
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load i8*, i8** %l2
  %t32 = call i8* @trim_text(i8* %t31)
  %t33 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t30, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t34
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
  %l7 = alloca i8
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca i8*
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
  %t34 = phi double [ %t18, %entry ], [ %t33, %loop.latch2 ]
  store double %t34, double* %l6
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l6
  %t20 = load double, double* %l6
  %t21 = getelementptr i8, i8* %text, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l7
  %t23 = load i8, i8* %l7
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  %t28 = load i8, i8* %l7
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
  %t30 = load double, double* %l6
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l6
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t35 = load i8*, i8** %l2
  %t36 = alloca [0 x double]
  %t37 = getelementptr [0 x double], [0 x double]* %t36, i32 0, i32 0
  %t38 = alloca { double*, i64 }
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 0
  store double* %t37, double** %t39
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l6
  %t42 = load i8*, i8** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load i8*, i8** %l2
  %t45 = load double, double* %l3
  %t46 = load double, double* %l4
  %t47 = load double, double* %l5
  %t48 = load double, double* %l6
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br label %loop.header4
loop.header4:
  %t78 = phi double [ %t48, %entry ], [ %t77, %loop.latch6 ]
  store double %t78, double* %l6
  br label %loop.body5
loop.body5:
  %t50 = load double, double* %l6
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t51
  %t53 = extractvalue { i8**, i64 } %t52, 1
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp oge double %t50, %t54
  %t56 = load i8*, i8** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load i8*, i8** %l2
  %t59 = load double, double* %l3
  %t60 = load double, double* %l4
  %t61 = load double, double* %l5
  %t62 = load double, double* %l6
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br i1 %t55, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = load double, double* %l6
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t64
  %t67 = extractvalue { i8**, i64 } %t66, 0
  %t68 = extractvalue { i8**, i64 } %t66, 1
  %t69 = icmp uge i64 %t65, %t68
  ; bounds check: %t69 (if true, out of bounds)
  %t70 = getelementptr i8*, i8** %t67, i64 %t65
  %t71 = load i8*, i8** %t70
  %t72 = call i8* @trim_text(i8* %t71)
  store i8* %t72, i8** %l9
  %t73 = load i8*, i8** %l9
  %t74 = load double, double* %l6
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l6
  br label %loop.latch6
loop.latch6:
  %t77 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l8
  ret { i8**, i64 }* %t79
}

define %ArrayLiteralMetadata @parse_array_literal_metadata({ i8**, i64 }* %entries, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  %t4 = insertvalue %ArrayLiteralMetadata undef, i8* %s3, 0
  %t5 = sitofp i64 0 to double
  %t6 = insertvalue %ArrayLiteralMetadata %t4, double %t5, 1
  ret %ArrayLiteralMetadata %t6
merge1:
  %t7 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t8 = extractvalue { i8**, i64 } %t7, 0
  %t9 = extractvalue { i8**, i64 } %t7, 1
  %t10 = icmp uge i64 0, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr i8*, i8** %t8, i64 0
  %t12 = load i8*, i8** %t11
  %t13 = call i8* @trim_text(i8* %t12)
  store i8* %t13, i8** %l0
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = call double @substring(i8* %t15, i64 0, i64 9)
  store double %t16, double* %l1
  %t17 = load double, double* %l1
  %s18 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l0
  %t20 = load i8*, i8** %l0
  store double 0.0, double* %l2
  %t21 = load double, double* %l2
  %t22 = load double, double* %l2
  %t23 = call i8* @map_metadata_annotation(%TypeContext %context, i8* null)
  store i8* %t23, i8** %l3
  %t24 = load i8*, i8** %l3
  %t25 = insertvalue %ArrayLiteralMetadata undef, i8* %t24, 0
  %t26 = sitofp i64 1 to double
  %t27 = insertvalue %ArrayLiteralMetadata %t25, double %t26, 1
  ret %ArrayLiteralMetadata %t27
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
  %t1 = icmp eq i8* %llvm_type, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  br label %merge1
merge1:
  %s2 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
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
  %t2 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = icmp eq i8* %t4, %s5
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t6, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8*, i8** %l0
  %s8 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %t7, %s8
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t10 = phi i1 [ true, %logical_or_entry_3 ], [ %t9, %logical_or_right_end_3 ]
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %s12 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.12, i32 0, i32 0
  %t13 = icmp eq i8* %llvm_type, %s12
  %t14 = load i8*, i8** %l0
  br i1 %t13, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s15 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.15, i32 0, i32 0
  %t16 = icmp eq i8* %llvm_type, %s15
  %t17 = load i8*, i8** %l0
  br i1 %t16, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %s18 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.18, i32 0, i32 0
  %t19 = icmp eq i8* %llvm_type, %s18
  %t20 = load i8*, i8** %l0
  br i1 %t19, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.21, i32 0, i32 0
  %t22 = icmp eq i8* %llvm_type, %s21
  %t23 = load i8*, i8** %l0
  br i1 %t22, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t24 = call i1 @ends_with_pointer_suffix(i8* %llvm_type)
  %t25 = load i8*, i8** %l0
  br i1 %t24, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t26 = load i8*, i8** %l0
  %t27 = load i8*, i8** %l0
  %t28 = getelementptr i8, i8* %t27, i64 0
  %t29 = load i8, i8* %t28
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = load i8*, i8** %l0
  %s32 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.32, i32 0, i32 0
  %t33 = call i1 @starts_with(i8* %t31, i8* %s32)
  %t34 = load i8*, i8** %l0
  br i1 %t33, label %then12, label %merge13
then12:
  %t35 = load i8*, i8** %l0
  %t36 = call i8* @strip_mut_prefix(i8* %t35)
  store i8* %t36, i8** %l1
  %t37 = load i8*, i8** %l1
  br label %merge13
merge13:
  ret i1 0
}

define i8* @default_return_literal(i8* %llvm_type) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %llvm_type, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %llvm_type, %s3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %s6 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %llvm_type, %s6
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
merge5:
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %llvm_type, %s9
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
merge7:
  %t12 = call i1 @ends_with_pointer_suffix(i8* %llvm_type)
  br i1 %t12, label %then8, label %merge9
then8:
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  ret i8* %s13
merge9:
  %s14 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.14, i32 0, i32 0
  ret i8* %s14
}

define i1 @starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  ret i1 false
}

define i1 @contains_text(i8* %haystack, i8* %needle) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t10 = phi double [ %t1, %entry ], [ %t9, %loop.latch2 ]
  store double %t10, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %t6 = load double, double* %l0
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %t6, %t7
  store double %t8, double* %l0
  br label %loop.latch2
loop.latch2:
  %t9 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
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
  %l1 = alloca i8
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = getelementptr i8, i8* %t2, i64 0
  %t4 = load i8, i8* %t3
  store i8 %t4, i8* %l1
  %t6 = load i8, i8* %l1
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @sanitize_symbol(i8* %t8)
  store i8* %t9, i8** %l2
  %t10 = load i8*, i8** %l2
  %t11 = load i8*, i8** %l0
  %t12 = icmp ne i8* %t10, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load i8, i8* %l1
  %t15 = load i8*, i8** %l2
  br i1 %t12, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  ret i1 1
}

define double @find_top_level_range_separator(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t30 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l3
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  %t9 = load double, double* %l3
  %t10 = getelementptr i8, i8* %value, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l4
  %t12 = load i8, i8* %l4
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8, i8* %l4
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8, i8* %l4
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = load i8, i8* %l4
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t20 = load i8, i8* %l4
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t22 = load i8, i8* %l4
  %s23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.23, i32 0, i32 0
  %t24 = load i8, i8* %l4
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  %t26 = load double, double* %l3
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l3
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t31 = sitofp i64 -1 to double
  ret double %t31
}

define double @find_top_level_range_separator_from(i8* %value, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t27 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l3
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  %t9 = load double, double* %l3
  %t10 = getelementptr i8, i8* %value, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l4
  %t12 = load i8, i8* %l4
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load double, double* %l3
  %t15 = fcmp oge double %t14, %start_index
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i8, i8* %l4
  br i1 %t15, label %then4, label %merge5
then4:
  %t21 = load i8, i8* %l4
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  br label %merge5
merge5:
  %t23 = load double, double* %l3
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l3
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t28 = sitofp i64 -1 to double
  ret double %t28
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
  %l8 = alloca i8
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
  %t114 = phi i1 [ %t10, %entry ], [ %t112, %loop.latch2 ]
  %t115 = phi double [ %t11, %entry ], [ %t113, %loop.latch2 ]
  store i1 %t114, i1* %l5
  store double %t115, double* %l6
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l6
  %t14 = load double, double* %l6
  %t15 = getelementptr i8, i8* %value, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l8
  %t17 = load i1, i1* %l3
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  %t21 = load i1, i1* %l3
  %t22 = load i1, i1* %l4
  %t23 = load i1, i1* %l5
  %t24 = load double, double* %l6
  %t25 = load double, double* %l7
  %t26 = load i8, i8* %l8
  br i1 %t17, label %then4, label %merge5
then4:
  %t27 = load i1, i1* %l5
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load i1, i1* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i1, i1* %l5
  %t34 = load double, double* %l6
  %t35 = load double, double* %l7
  %t36 = load i8, i8* %l8
  br i1 %t27, label %then6, label %else7
then6:
  store i1 0, i1* %l5
  br label %merge8
else7:
  %t37 = load i8, i8* %l8
  %s38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.38, i32 0, i32 0
  br label %merge8
merge8:
  %t39 = phi i1 [ 0, %then6 ], [ %t33, %else7 ]
  store i1 %t39, i1* %l5
  %t40 = load double, double* %l6
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l6
  br label %loop.latch2
merge5:
  %t43 = load i1, i1* %l4
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load i1, i1* %l3
  %t48 = load i1, i1* %l4
  %t49 = load i1, i1* %l5
  %t50 = load double, double* %l6
  %t51 = load double, double* %l7
  %t52 = load i8, i8* %l8
  br i1 %t43, label %then9, label %merge10
then9:
  %t53 = load i1, i1* %l5
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load i1, i1* %l3
  %t58 = load i1, i1* %l4
  %t59 = load i1, i1* %l5
  %t60 = load double, double* %l6
  %t61 = load double, double* %l7
  %t62 = load i8, i8* %l8
  br i1 %t53, label %then11, label %else12
then11:
  store i1 0, i1* %l5
  br label %merge13
else12:
  %t63 = load i8, i8* %l8
  %s64 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.64, i32 0, i32 0
  br label %merge13
merge13:
  %t65 = phi i1 [ 0, %then11 ], [ %t59, %else12 ]
  store i1 %t65, i1* %l5
  %t66 = load double, double* %l6
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l6
  br label %loop.latch2
merge10:
  %t69 = load i8, i8* %l8
  %s70 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.70, i32 0, i32 0
  %t71 = load i8, i8* %l8
  %s72 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.72, i32 0, i32 0
  %t73 = load i8, i8* %l8
  %s74 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.74, i32 0, i32 0
  %t75 = load i8, i8* %l8
  %s76 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.76, i32 0, i32 0
  %t77 = load i8, i8* %l8
  %s78 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.78, i32 0, i32 0
  %t79 = load i8, i8* %l8
  %s80 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.80, i32 0, i32 0
  %t81 = load i8, i8* %l8
  %s82 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.82, i32 0, i32 0
  %t83 = load i8, i8* %l8
  %s84 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.84, i32 0, i32 0
  %t87 = load double, double* %l0
  %t88 = sitofp i64 0 to double
  %t89 = fcmp oeq double %t87, %t88
  br label %logical_and_entry_86

logical_and_entry_86:
  br i1 %t89, label %logical_and_right_86, label %logical_and_merge_86

logical_and_right_86:
  %t90 = load double, double* %l1
  %t91 = sitofp i64 0 to double
  %t92 = fcmp oeq double %t90, %t91
  br label %logical_and_right_end_86

logical_and_right_end_86:
  br label %logical_and_merge_86

logical_and_merge_86:
  %t93 = phi i1 [ false, %logical_and_entry_86 ], [ %t92, %logical_and_right_end_86 ]
  br label %logical_and_entry_85

logical_and_entry_85:
  br i1 %t93, label %logical_and_right_85, label %logical_and_merge_85

logical_and_right_85:
  %t94 = load double, double* %l2
  %t95 = sitofp i64 0 to double
  %t96 = fcmp oeq double %t94, %t95
  br label %logical_and_right_end_85

logical_and_right_end_85:
  br label %logical_and_merge_85

logical_and_merge_85:
  %t97 = phi i1 [ false, %logical_and_entry_85 ], [ %t96, %logical_and_right_end_85 ]
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load i1, i1* %l3
  %t102 = load i1, i1* %l4
  %t103 = load i1, i1* %l5
  %t104 = load double, double* %l6
  %t105 = load double, double* %l7
  %t106 = load i8, i8* %l8
  br i1 %t97, label %then14, label %merge15
then14:
  %t107 = load i8, i8* %l8
  %s108 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.108, i32 0, i32 0
  br label %merge15
merge15:
  %t109 = load double, double* %l6
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  store double %t111, double* %l6
  br label %loop.latch2
loop.latch2:
  %t112 = load i1, i1* %l5
  %t113 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t116 = load double, double* %l7
  ret double %t116
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
  %t24 = load i8*, i8** %l2
  %t25 = load double, double* %l3
  %t26 = call i1 @is_simple_identifier(i8* null)
  %t27 = xor i1 %t26, 1
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then2, label %merge3
then2:
  %t32 = insertvalue %MemberAccessParse undef, i1 0, 0
  %s33 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.33, i32 0, i32 0
  %t34 = insertvalue %MemberAccessParse %t32, i8* %s33, 1
  %s35 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.35, i32 0, i32 0
  %t36 = insertvalue %MemberAccessParse %t34, i8* %s35, 2
  ret %MemberAccessParse %t36
merge3:
  %t37 = insertvalue %MemberAccessParse undef, i1 1, 0
  %t38 = load i8*, i8** %l2
  %t39 = insertvalue %MemberAccessParse %t37, i8* %t38, 1
  %t40 = load double, double* %l3
  %t41 = insertvalue %MemberAccessParse %t39, i8* null, 2
  ret %MemberAccessParse %t41
}

define %IndexExpressionParse @parse_index_expression(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca i8*
  %l6 = alloca double
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = sitofp i64 -1 to double
  store double %t3, double* %l2
  %t4 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t5 = sitofp i64 1 to double
  store double %t5, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  %t10 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t30 = phi double [ %t10, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l3
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l3
  %t12 = sitofp i64 0 to double
  %t13 = fcmp olt double %t11, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l3
  %t20 = getelementptr i8, i8* %t18, i64 %t19
  %t21 = load i8, i8* %t20
  store i8 %t21, i8* %l4
  %t22 = load i8, i8* %l4
  %s23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.23, i32 0, i32 0
  %t24 = load i8, i8* %l4
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  %t26 = load double, double* %l3
  %t27 = sitofp i64 1 to double
  %t28 = fsub double %t26, %t27
  store double %t28, double* %l3
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t31 = load double, double* %l2
  %t32 = sitofp i64 0 to double
  %t33 = fcmp olt double %t31, %t32
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  br i1 %t33, label %then6, label %merge7
then6:
  %t38 = insertvalue %IndexExpressionParse undef, i1 0, 0
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.39, i32 0, i32 0
  %t40 = insertvalue %IndexExpressionParse %t38, i8* %s39, 1
  %s41 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.41, i32 0, i32 0
  %t42 = insertvalue %IndexExpressionParse %t40, i8* %s41, 2
  ret %IndexExpressionParse %t42
merge7:
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l2
  %t45 = call double @substring(i8* %t43, i64 0, double %t44)
  %t46 = call i8* @trim_text(i8* null)
  store i8* %t46, i8** %l5
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  %t51 = load i8*, i8** %l0
  store double 0.0, double* %l6
  %t53 = load i8*, i8** %l5
  %t54 = insertvalue %IndexExpressionParse undef, i1 1, 0
  %t55 = load i8*, i8** %l5
  %t56 = insertvalue %IndexExpressionParse %t54, i8* %t55, 1
  %t57 = load double, double* %l6
  %t58 = insertvalue %IndexExpressionParse %t56, i8* null, 2
  ret %IndexExpressionParse %t58
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
  %t74 = load i1, i1* %l3
  br label %logical_and_entry_73

logical_and_entry_73:
  br i1 %t74, label %logical_and_right_73, label %logical_and_merge_73

logical_and_right_73:
  %t75 = load i8*, i8** %l4
  %t78 = load i8*, i8** %l6
  store double 0.0, double* %l8
  %t79 = load double, double* %l8
  %t80 = fcmp one double %t79, 0.0
  %t81 = insertvalue %RangeIterableParse undef, i1 %t80, 0
  %t82 = load i8*, i8** %l6
  %t83 = insertvalue %RangeIterableParse %t81, i8* %t82, 1
  %t84 = load double, double* %l7
  %t85 = insertvalue %RangeIterableParse %t83, i8* null, 2
  %t86 = load i8*, i8** %l4
  %t87 = insertvalue %RangeIterableParse %t85, i8* %t86, 3
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = insertvalue %RangeIterableParse %t87, { i8**, i64 }* %t88, 4
  ret %RangeIterableParse %t89
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
  %l2 = alloca %LifetimeRegionMetadata
  %l3 = alloca double
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
  %t40 = phi { %LifetimeRegionMetadata*, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { %LifetimeRegionMetadata*, i64 }* %t40, { %LifetimeRegionMetadata*, i64 }** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %regions
  %t10 = extractvalue { %LifetimeRegionMetadata*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %regions
  %t17 = extractvalue { %LifetimeRegionMetadata*, i64 } %t16, 0
  %t18 = extractvalue { %LifetimeRegionMetadata*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t17, i64 %t15
  %t21 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t20
  store %LifetimeRegionMetadata %t21, %LifetimeRegionMetadata* %l2
  %t22 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l2
  %t23 = extractvalue %LifetimeRegionMetadata %t22, 0
  %t24 = fcmp oeq double %t23, %region_id
  %t25 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l2
  br i1 %t24, label %then6, label %else7
then6:
  store double 0.0, double* %l3
  %t28 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t29 = load double, double* %l3
  %t30 = call { %LifetimeRegionMetadata*, i64 }* @append_lifetime_region({ %LifetimeRegionMetadata*, i64 }* %t28, %LifetimeRegionMetadata zeroinitializer)
  store { %LifetimeRegionMetadata*, i64 }* %t30, { %LifetimeRegionMetadata*, i64 }** %l0
  br label %merge8
else7:
  %t31 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t32 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l2
  %t33 = call { %LifetimeRegionMetadata*, i64 }* @append_lifetime_region({ %LifetimeRegionMetadata*, i64 }* %t31, %LifetimeRegionMetadata %t32)
  store { %LifetimeRegionMetadata*, i64 }* %t33, { %LifetimeRegionMetadata*, i64 }** %l0
  br label %merge8
merge8:
  %t34 = phi { %LifetimeRegionMetadata*, i64 }* [ %t30, %then6 ], [ %t33, %else7 ]
  store { %LifetimeRegionMetadata*, i64 }* %t34, { %LifetimeRegionMetadata*, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  ret { %LifetimeRegionMetadata*, i64 }* %t42
}

define { %LifetimeRegionMetadata*, i64 }* @apply_lifetime_release_events({ %LifetimeRegionMetadata*, i64 }* %regions, { %LifetimeReleaseEvent*, i64 }* %releases) {
entry:
  %l0 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l1 = alloca double
  %l2 = alloca %LifetimeReleaseEvent
  %t0 = load { %LifetimeReleaseEvent*, i64 }, { %LifetimeReleaseEvent*, i64 }* %releases
  %t1 = extractvalue { %LifetimeReleaseEvent*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  ret { %LifetimeRegionMetadata*, i64 }* %regions
merge1:
  store { %LifetimeRegionMetadata*, i64 }* %regions, { %LifetimeRegionMetadata*, i64 }** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t33 = phi { %LifetimeRegionMetadata*, i64 }* [ %t4, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t5, %entry ], [ %t32, %loop.latch4 ]
  store { %LifetimeRegionMetadata*, i64 }* %t33, { %LifetimeRegionMetadata*, i64 }** %l0
  store double %t34, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = load { %LifetimeReleaseEvent*, i64 }, { %LifetimeReleaseEvent*, i64 }* %releases
  %t8 = extractvalue { %LifetimeReleaseEvent*, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t6, %t9
  %t11 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = load { %LifetimeReleaseEvent*, i64 }, { %LifetimeReleaseEvent*, i64 }* %releases
  %t15 = extractvalue { %LifetimeReleaseEvent*, i64 } %t14, 0
  %t16 = extractvalue { %LifetimeReleaseEvent*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %LifetimeReleaseEvent, %LifetimeReleaseEvent* %t15, i64 %t13
  %t19 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %t18
  store %LifetimeReleaseEvent %t19, %LifetimeReleaseEvent* %l2
  %t20 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t21 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %l2
  %t22 = extractvalue %LifetimeReleaseEvent %t21, 0
  %t23 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %l2
  %t24 = extractvalue %LifetimeReleaseEvent %t23, 1
  %t25 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %l2
  %t26 = extractvalue %LifetimeReleaseEvent %t25, 2
  %t27 = call { %LifetimeRegionMetadata*, i64 }* @mark_lifetime_region_released({ %LifetimeRegionMetadata*, i64 }* %t20, double %t22, i8* %t24, double %t26)
  store { %LifetimeRegionMetadata*, i64 }* %t27, { %LifetimeRegionMetadata*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch4
loop.latch4:
  %t31 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t35 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  ret { %LifetimeRegionMetadata*, i64 }* %t35
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
  %t0 = icmp eq i8* %candidate, %parent
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1, i32 0, i32 0
  %t2 = add i8* %parent, %s1
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call i1 @starts_with(i8* %candidate, i8* %t3)
  ret i1 %t4
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
  %t36 = phi { %LLVMOperand*, i64 }* [ %t6, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t7, %entry ], [ %t35, %loop.latch2 ]
  store { %LLVMOperand*, i64 }* %t36, { %LLVMOperand*, i64 }** %l0
  store double %t37, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %values
  %t10 = extractvalue { %LLVMOperand*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fcmp oeq double %t15, %index
  %t17 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %else7
then6:
  %t19 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t20 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t19, %LLVMOperand %value)
  store { %LLVMOperand*, i64 }* %t20, { %LLVMOperand*, i64 }** %l0
  br label %merge8
else7:
  %t21 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %values
  %t24 = extractvalue { %LLVMOperand*, i64 } %t23, 0
  %t25 = extractvalue { %LLVMOperand*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr %LLVMOperand, %LLVMOperand* %t24, i64 %t22
  %t28 = load %LLVMOperand, %LLVMOperand* %t27
  %t29 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t21, %LLVMOperand %t28)
  store { %LLVMOperand*, i64 }* %t29, { %LLVMOperand*, i64 }** %l0
  br label %merge8
merge8:
  %t30 = phi { %LLVMOperand*, i64 }* [ %t20, %then6 ], [ %t29, %else7 ]
  store { %LLVMOperand*, i64 }* %t30, { %LLVMOperand*, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t35 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  ret { %LLVMOperand*, i64 }* %t38
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
  %t51 = phi i8* [ %t7, %entry ], [ %t49, %loop.latch4 ]
  %t52 = phi double [ %t6, %entry ], [ %t50, %loop.latch4 ]
  store i8* %t51, i8** %l2
  store double %t52, double* %l1
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
  %t37 = phi double [ %t19, %loop.body3 ], [ %t35, %loop.latch10 ]
  %t38 = phi double [ %t20, %loop.body3 ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l3
  store double %t38, double* %l4
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
  %t30 = sitofp i64 10 to double
  %t31 = fsub double %t29, %t30
  store double %t31, double* %l3
  %t32 = load double, double* %l4
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l4
  br label %loop.latch10
loop.latch10:
  %t35 = load double, double* %l3
  %t36 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l3
  store double %t39, double* %l5
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l5
  %t42 = load double, double* %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = call double @substring(i8* %t40, double %t41, double %t44)
  store double %t45, double* %l6
  %t46 = load double, double* %l6
  %t47 = load i8*, i8** %l2
  %t48 = load double, double* %l4
  store double %t48, double* %l1
  br label %loop.latch4
loop.latch4:
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t53 = load i8*, i8** %l2
  ret i8* %t53
}

define i8* @sanitize_symbol(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t21 = phi i8* [ %t2, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t3, %entry ], [ %t20, %loop.latch2 ]
  store i8* %t21, i8** %l0
  store double %t22, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %name, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = call i1 @is_symbol_char(i8* null)
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load i8, i8* %l2
  br i1 %t9, label %then4, label %merge5
then4:
  %t13 = load i8*, i8** %l0
  %t14 = load i8, i8* %l2
  br label %merge5
merge5:
  %t15 = phi i8* [ null, %then4 ], [ %t10, %loop.body1 ]
  store i8* %t15, i8** %l0
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l0
  ret i8* %t24
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
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call double @char_code(i8* %ch)
  store double %t2, double* %l0
  %t4 = load double, double* %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = call double @char_code(i8* %s5)
  %t7 = fcmp oge double %t4, %t6
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t7, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t8 = load double, double* %l0
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = call double @char_code(i8* %s9)
  %t11 = fcmp ole double %t8, %t10
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t12 = phi i1 [ false, %logical_and_entry_3 ], [ %t11, %logical_and_right_end_3 ]
  %t13 = load double, double* %l0
  br i1 %t12, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t15 = load double, double* %l0
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = call double @char_code(i8* %s16)
  %t18 = fcmp oge double %t15, %t17
  br label %logical_and_entry_14

logical_and_entry_14:
  br i1 %t18, label %logical_and_right_14, label %logical_and_merge_14

logical_and_right_14:
  %t19 = load double, double* %l0
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = call double @char_code(i8* %s20)
  %t22 = fcmp ole double %t19, %t21
  br label %logical_and_right_end_14

logical_and_right_end_14:
  br label %logical_and_merge_14

logical_and_merge_14:
  %t23 = phi i1 [ false, %logical_and_entry_14 ], [ %t22, %logical_and_right_end_14 ]
  %t24 = load double, double* %l0
  br i1 %t23, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t26 = load double, double* %l0
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = call double @char_code(i8* %s27)
  %t29 = fcmp oge double %t26, %t28
  br label %logical_and_entry_25

logical_and_entry_25:
  br i1 %t29, label %logical_and_right_25, label %logical_and_merge_25

logical_and_right_25:
  %t30 = load double, double* %l0
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = call double @char_code(i8* %s31)
  %t33 = fcmp ole double %t30, %t32
  br label %logical_and_right_end_25

logical_and_right_end_25:
  br label %logical_and_merge_25

logical_and_merge_25:
  %t34 = phi i1 [ false, %logical_and_entry_25 ], [ %t33, %logical_and_right_end_25 ]
  %t35 = load double, double* %l0
  br i1 %t34, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define double @lower_char_code(double %code) {
entry:
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %t2 = call double @char_code(i8* %s1)
  %t3 = fcmp oge double %code, %t2
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t3, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = call double @char_code(i8* %s4)
  %t6 = fcmp ole double %code, %t5
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t7 = phi i1 [ false, %logical_and_entry_0 ], [ %t6, %logical_and_right_end_0 ]
  br i1 %t7, label %then0, label %merge1
then0:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = call double @char_code(i8* %s8)
  %t10 = fadd double %code, %t9
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = call double @char_code(i8* %s11)
  %t13 = fsub double %t10, %t12
  ret double %t13
merge1:
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
  %t23 = phi double [ %t1, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = call double @char_code(i8 %t5)
  %t7 = call double @lower_char_code(double %t6)
  store double %t7, double* %l1
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %expected, i64 %t8
  %t10 = load i8, i8* %t9
  %t11 = call double @char_code(i8 %t10)
  %t12 = call double @lower_char_code(double %t11)
  store double %t12, double* %l2
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = fcmp une double %t13, %t14
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
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

define i1 @is_null_literal(i8* %text) {
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
  ret i1 0
}

define i1 @is_integer_literal(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  store i1 0, i1* %l2
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  %t8 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = getelementptr i8, i8* %t11, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l3
  %t16 = load i8, i8* %l3
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  ret i1 0
loop.latch2:
  br label %loop.header0
afterloop3:
  %t18 = load i1, i1* %l2
  ret i1 %t18
}

define i1 @is_number_literal(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i8*
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  %t1 = call i8* @trim_text(i8* %text)
  store i8* %t1, i8** %l3
  %t2 = load i8*, i8** %l3
  %t3 = load i8*, i8** %l3
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = load i1, i1* %l1
  %t8 = load i1, i1* %l2
  %t9 = load i8*, i8** %l3
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l0
  %t11 = load i8*, i8** %l3
  %t12 = load i8*, i8** %l3
  %t13 = load double, double* %l0
  %t14 = getelementptr i8, i8* %t12, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t17 = load i8, i8* %l4
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8, i8* %l4
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  ret i1 0
loop.latch2:
  br label %loop.header0
afterloop3:
  %t21 = load i1, i1* %l1
  ret i1 %t21
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
  %t2 = load i8*, i8** %l0
  %t3 = getelementptr i8, i8* %t2, i64 0
  %t4 = load i8, i8* %t3
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
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
  %t24 = phi i8* [ %t8, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t9, %entry ], [ %t23, %loop.latch2 ]
  store i8* %t24, i8** %l3
  store double %t25, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l4
  store double 0.0, double* %l5
  %t15 = load double, double* %l5
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = load i8*, i8** %l3
  %t18 = load double, double* %l5
  %t19 = load double, double* %l4
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l4
  br label %loop.latch2
loop.latch2:
  %t22 = load i8*, i8** %l3
  %t23 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t26 = load i8*, i8** %l3
  ret i8* %t26
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi double [ %t1, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
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
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  store i8 %t10, i8* %l2
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_trim_char(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
then6:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t22, %entry ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l1
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l1
  %t24 = load double, double* %l0
  %t25 = fcmp ole double %t23, %t24
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = call i1 @is_trim_char(i8* null)
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t36 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l0
  %t40 = sitofp i64 0 to double
  %t41 = fcmp oeq double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l1
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = call double @substring(i8* %value, double %t43, double %t44)
  ret i8* null
}

define i1 @is_trim_char(i8* %ch) {
entry:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = icmp eq i8* %ch, %s5
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t7 = phi i1 [ true, %logical_or_entry_2 ], [ %t6, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t7, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %ch, %s8
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t10 = phi i1 [ true, %logical_or_entry_1 ], [ %t9, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t10, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
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
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t12 = phi double [ %t5, %loop.body1 ], [ %t11, %loop.latch6 ]
  store double %t12, double* %l1
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l1
  %t8 = load double, double* %l1
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l1
  br label %loop.latch6
loop.latch6:
  %t11 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t13 = load i1, i1* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i1, i1* %l2
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

define double @find_last_index_of_char(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t12 = phi double [ %t0, %entry ], [ %t11, %loop.latch2 ]
  store double %t12, double* %l0
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
  %t6 = sitofp i64 1 to double
  %t7 = fsub double %t5, %t6
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  br label %loop.latch2
loop.latch2:
  %t11 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
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
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %values
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %values
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %target
  %t16 = load double, double* %l0
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
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

define { %ParameterBinding*, i64 }* @merge_parameter_bindings({ %ParameterBinding*, i64 }* %first, { %ParameterBinding*, i64 }* %second) {
entry:
  %l0 = alloca { %ParameterBinding*, i64 }*
  %l1 = alloca double
  %l2 = alloca %ParameterBinding
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
  %t33 = phi { %ParameterBinding*, i64 }* [ %t6, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t7, %entry ], [ %t32, %loop.latch2 ]
  store { %ParameterBinding*, i64 }* %t33, { %ParameterBinding*, i64 }** %l0
  store double %t34, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %first
  %t10 = extractvalue { %ParameterBinding*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %first
  %t17 = extractvalue { %ParameterBinding*, i64 } %t16, 0
  %t18 = extractvalue { %ParameterBinding*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %ParameterBinding, %ParameterBinding* %t17, i64 %t15
  %t21 = load %ParameterBinding, %ParameterBinding* %t20
  store %ParameterBinding %t21, %ParameterBinding* %l2
  %t22 = load %ParameterBinding, %ParameterBinding* %l2
  %t23 = extractvalue %ParameterBinding %t22, 4
  store i1 %t23, i1* %l3
  %t24 = load %ParameterBinding, %ParameterBinding* %l2
  %t25 = extractvalue %ParameterBinding %t24, 0
  %t26 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %second, i8* %t25)
  store double %t26, double* %l4
  %t27 = load double, double* %l4
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  ret { %ParameterBinding*, i64 }* %t35
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
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
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
  %t35 = phi i8* [ %t11, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t12, %entry ], [ %t34, %loop.latch4 ]
  store i8* %t35, i8** %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %values
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
  %t21 = add i8* %t20, %separator
  %t22 = load double, double* %l1
  %t23 = load { i8**, i64 }, { i8**, i64 }* %values
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = add i8* %t21, %t28
  store i8* %t29, i8** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load i8*, i8** %l0
  ret i8* %t37
}

define { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %existing, { %StringConstant*, i64 }* %new_constants) {
entry:
  %l0 = alloca { %StringConstant*, i64 }*
  %l1 = alloca double
  %l2 = alloca %StringConstant
  %l3 = alloca double
  store { %StringConstant*, i64 }* %existing, { %StringConstant*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t26 = phi double [ %t2, %entry ], [ %t25, %loop.latch2 ]
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %StringConstant*, i64 }, { %StringConstant*, i64 }* %new_constants
  %t5 = extractvalue { %StringConstant*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { %StringConstant*, i64 }, { %StringConstant*, i64 }* %new_constants
  %t12 = extractvalue { %StringConstant*, i64 } %t11, 0
  %t13 = extractvalue { %StringConstant*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %StringConstant, %StringConstant* %t12, i64 %t10
  %t16 = load %StringConstant, %StringConstant* %t15
  store %StringConstant %t16, %StringConstant* %l2
  %t17 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  %t18 = load %StringConstant, %StringConstant* %l2
  %t19 = extractvalue %StringConstant %t18, 1
  %t20 = call double @find_string_constant({ %StringConstant*, i64 }* %t17, i8* %t19)
  store double %t20, double* %l3
  %t21 = load double, double* %l3
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  ret { %StringConstant*, i64 }* %t27
}

define { i8**, i64 }* @render_string_constants({ %StringConstant*, i64 }* %constants) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %StringConstant
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  %t50 = phi { i8**, i64 }* [ %t6, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t7, %entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %StringConstant*, i64 }, { %StringConstant*, i64 }* %constants
  %t10 = extractvalue { %StringConstant*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %StringConstant*, i64 }, { %StringConstant*, i64 }* %constants
  %t17 = extractvalue { %StringConstant*, i64 } %t16, 0
  %t18 = extractvalue { %StringConstant*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %StringConstant, %StringConstant* %t17, i64 %t15
  %t21 = load %StringConstant, %StringConstant* %t20
  store %StringConstant %t21, %StringConstant* %l2
  %t22 = load %StringConstant, %StringConstant* %l2
  %t23 = extractvalue %StringConstant %t22, 1
  %t24 = call i8* @escape_string_for_llvm(i8* %t23)
  store i8* %t24, i8** %l3
  %t25 = load %StringConstant, %StringConstant* %l2
  %t26 = extractvalue %StringConstant %t25, 2
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = call i8* @number_to_string(double %t28)
  store i8* %t29, i8** %l4
  %t30 = load %StringConstant, %StringConstant* %l2
  %t31 = extractvalue %StringConstant %t30, 0
  %s32 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.32, i32 0, i32 0
  %t33 = add i8* %t31, %s32
  %t34 = load i8*, i8** %l4
  %t35 = add i8* %t33, %t34
  %s36 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %t35, %s36
  %t38 = load i8*, i8** %l3
  %t39 = add i8* %t37, %t38
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.40, i32 0, i32 0
  %t41 = add i8* %t39, %s40
  store i8* %t41, i8** %l5
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l5
  %t44 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t42, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t52
}

define i8* @escape_string_for_llvm(i8* %content) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t14 = phi double [ %t3, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %content, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t15 = load i8*, i8** %l0
  ret i8* %t15
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
