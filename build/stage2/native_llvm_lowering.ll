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
@.str.196 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.94 = private unnamed_addr constant [53 x i8] c"; -- Trait Metadata --------------------------------\00"
@.str.103 = private unnamed_addr constant [50 x i8] c"; -----------------------------------------------\00"
@.str.6 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.8 = private unnamed_addr constant [2 x i8] c",\00"
@.str.11 = private unnamed_addr constant [2 x i8] c";\00"
@.str.14 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.17 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.20 = private unnamed_addr constant [2 x i8] c"=\00"
@.str.6 = private unnamed_addr constant [15 x i8] c"(\22 || ch == \22)\00"
@.str.0 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.2 = private unnamed_addr constant [60 x i8] c"(\22 + render_interface_parameters(signature.parameters) + \22)\00"
@.str.19 = private unnamed_addr constant [8 x i8] c"define \00"
@.str.22 = private unnamed_addr constant [7 x i8] c"entry:\00"
@.str.87 = private unnamed_addr constant [12 x i8] c"loop.header\00"
@.str.94 = private unnamed_addr constant [10 x i8] c"loop.body\00"
@.str.101 = private unnamed_addr constant [11 x i8] c"loop.latch\00"
@.str.108 = private unnamed_addr constant [10 x i8] c"afterloop\00"
@.str.116 = private unnamed_addr constant [13 x i8] c"  br label %\00"
@.str.122 = private unnamed_addr constant [2 x i8] c":\00"
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
@.str.15 = private unnamed_addr constant [44 x i8] c" (\22 + join_with_separator(parts, \22, \22) + \22)\00"
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
@.str.179 = private unnamed_addr constant [7 x i8] c"double\00"
@.str.384 = private unnamed_addr constant [9 x i8] c" = call \00"
@.str.388 = private unnamed_addr constant [3 x i8] c" @\00"
@.str.392 = private unnamed_addr constant [24 x i8] c"(\22 + argument_text + \22)\00"
@.str.93 = private unnamed_addr constant [17 x i8] c" = extractvalue \00"
@.str.221 = private unnamed_addr constant [54 x i8] c"llvm lowering: unsupported array type for indexing: `\00"
@.str.208 = private unnamed_addr constant [2 x i8] c"[\00"
@.str.211 = private unnamed_addr constant [4 x i8] c" x \00"
@.str.215 = private unnamed_addr constant [2 x i8] c"]\00"
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
  %t153 = phi { %FunctionEffectEntry*, i64 }* [ %t100, %entry ], [ %t148, %loop.latch2 ]
  %t154 = phi { i8**, i64 }* [ %t88, %entry ], [ %t149, %loop.latch2 ]
  %t155 = phi { %LifetimeRegionMetadata*, i64 }* [ %t101, %entry ], [ %t150, %loop.latch2 ]
  %t156 = phi { %StringConstant*, i64 }* [ %t114, %entry ], [ %t151, %loop.latch2 ]
  %t157 = phi double [ %t112, %entry ], [ %t152, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t153, { %FunctionEffectEntry*, i64 }** %l12
  store { i8**, i64 }* %t154, { i8**, i64 }** %l0
  store { %LifetimeRegionMetadata*, i64 }* %t155, { %LifetimeRegionMetadata*, i64 }** %l13
  store { %StringConstant*, i64 }* %t156, { %StringConstant*, i64 }** %l26
  store double %t157, double* %l24
  br label %loop.body1
loop.body1:
  %t115 = load double, double* %l24
  %t116 = load double, double* %l7
  %t117 = load double, double* %l7
  %t118 = load double, double* %l24
  store double 0.0, double* %l27
  %t119 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t120 = load double, double* %l27
  store double 0.0, double* %l28
  %t121 = alloca [0 x double]
  %t122 = getelementptr [0 x double], [0 x double]* %t121, i32 0, i32 0
  %t123 = alloca { double*, i64 }
  %t124 = getelementptr { double*, i64 }, { double*, i64 }* %t123, i32 0, i32 0
  store double* %t122, double** %t124
  %t125 = getelementptr { double*, i64 }, { double*, i64 }* %t123, i32 0, i32 1
  store i64 0, i64* %t125
  store { i8**, i64 }* null, { i8**, i64 }** %l29
  %t126 = load double, double* %l28
  %t127 = load double, double* %l27
  %t128 = load double, double* %l7
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t130 = load double, double* %l5
  %t131 = call %LoweredLLVMFunction @emit_function(i8* null, { i8**, i64 }* null, { i8**, i64 }* %t129, %TypeContext zeroinitializer)
  store %LoweredLLVMFunction %t131, %LoweredLLVMFunction* %l30
  %t132 = load double, double* %l27
  %t133 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t134 = extractvalue %LoweredLLVMFunction %t133, 1
  %t135 = call double @diagnosticsconcat({ i8**, i64 }* %t134)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t136 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t137 = extractvalue %LoweredLLVMFunction %t136, 2
  %t138 = call double @lifetime_regionsconcat({ i8**, i64 }* %t137)
  store { %LifetimeRegionMetadata*, i64 }* null, { %LifetimeRegionMetadata*, i64 }** %l13
  %t139 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t140 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t141 = extractvalue %LoweredLLVMFunction %t140, 3
  %t142 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t139, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t142, { %StringConstant*, i64 }** %l26
  %t143 = load %LoweredLLVMFunction, %LoweredLLVMFunction* %l30
  %t144 = extractvalue %LoweredLLVMFunction %t143, 0
  %t145 = load double, double* %l24
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  store double %t147, double* %l24
  br label %loop.latch2
loop.latch2:
  %t148 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t150 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t151 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t152 = load double, double* %l24
  br label %loop.header0
afterloop3:
  %t158 = load i1, i1* %l25
  %t159 = xor i1 %t158, 1
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load double, double* %l1
  %t162 = load double, double* %l2
  %t163 = load double, double* %l3
  %t164 = load double, double* %l4
  %t165 = load double, double* %l5
  %t166 = load double, double* %l6
  %t167 = load double, double* %l7
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t169 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l9
  %t170 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l10
  %t171 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l11
  %t172 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t173 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l16
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l20
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t184 = load double, double* %l24
  %t185 = load i1, i1* %l25
  %t186 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  br i1 %t159, label %then4, label %merge5
then4:
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l23
  br label %merge5
merge5:
  %t188 = phi { i8**, i64 }* [ null, %then4 ], [ %t183, %entry ]
  store { i8**, i64 }* %t188, { i8**, i64 }** %l23
  %t189 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t190 = call { i8**, i64 }* @render_string_constants({ %StringConstant*, i64 }* %t189)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l31
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l22
  store { i8**, i64 }* %t191, { i8**, i64 }** %l32
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l23
  %t194 = call double @final_linesconcat({ i8**, i64 }* %t193)
  store { i8**, i64 }* null, { i8**, i64 }** %l32
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %s196 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.196, i32 0, i32 0
  %t197 = call i8* @join_with_separator({ i8**, i64 }* %t195, i8* %s196)
  store i8* %t197, i8** %l33
  %t198 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  store double 0.0, double* %l34
  %t199 = load i8*, i8** %l33
  store i8* %t199, i8** %l35
  %t200 = load i8*, i8** %l35
  %t201 = load i8*, i8** %l35
  %t202 = insertvalue %LoweredLLVMResult undef, i8* %t201, 0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = insertvalue %LoweredLLVMResult %t202, { i8**, i64 }* %t203, 1
  %t205 = load double, double* %l3
  %t206 = insertvalue %LoweredLLVMResult %t204, i8* null, 2
  %t207 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l12
  %t208 = insertvalue %LoweredLLVMResult %t206, { i8**, i64 }* null, 3
  %t209 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l13
  %t210 = insertvalue %LoweredLLVMResult %t208, { i8**, i64 }* null, 4
  %t211 = load double, double* %l34
  %t212 = insertvalue %LoweredLLVMResult %t210, i8* null, 5
  %t213 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l26
  %t214 = insertvalue %LoweredLLVMResult %t212, { i8**, i64 }* null, 6
  ret %LoweredLLVMResult %t214
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
  %t21 = phi { %TraitDescriptor*, i64 }* [ %t6, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store { %TraitDescriptor*, i64 }* %t21, { %TraitDescriptor*, i64 }** %l0
  store double %t22, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t23 = alloca [0 x double]
  %t24 = getelementptr [0 x double], [0 x double]* %t23, i32 0, i32 0
  %t25 = alloca { double*, i64 }
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t25, i32 0, i32 0
  store double* %t24, double** %t26
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  store { %TraitImplementationDescriptor*, i64 }* null, { %TraitImplementationDescriptor*, i64 }** %l3
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l1
  %t29 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  br label %loop.header4
loop.header4:
  %t45 = phi double [ %t30, %entry ], [ %t44, %loop.latch6 ]
  store double %t45, double* %l1
  br label %loop.body5
loop.body5:
  %t32 = load double, double* %l1
  %t33 = load double, double* %l1
  %t34 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  store i8* %t39, i8** %l4
  %t40 = load i8*, i8** %l4
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch6
loop.latch6:
  %t44 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t46 = load { %TraitDescriptor*, i64 }*, { %TraitDescriptor*, i64 }** %l0
  %t47 = insertvalue %TraitMetadata undef, { i8**, i64 }* null, 0
  %t48 = load { %TraitImplementationDescriptor*, i64 }*, { %TraitImplementationDescriptor*, i64 }** %l3
  %t49 = insertvalue %TraitMetadata %t47, { i8**, i64 }* null, 1
  ret %TraitMetadata %t49
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
  %t53 = phi { i8**, i64 }* [ %t6, %entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t7, %entry ], [ %t52, %loop.latch2 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TraitMetadata %metadata, 0
  %t10 = extractvalue %TraitMetadata %metadata, 0
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  %s18 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t20 = load i8*, i8** %l2
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l3
  %t23 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t21, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l3
  %t29 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t45 = phi { i8**, i64 }* [ %t25, %loop.body1 ], [ %t43, %loop.latch6 ]
  %t46 = phi double [ %t29, %loop.body1 ], [ %t44, %loop.latch6 ]
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  store double %t46, double* %l4
  br label %loop.body5
loop.body5:
  %t30 = load double, double* %l4
  %t31 = load i8*, i8** %l2
  %t32 = load i8*, i8** %l2
  store double 0.0, double* %l5
  %t33 = load double, double* %l5
  %t34 = call i8* @render_interface_signature(i8* null)
  store i8* %t34, i8** %l6
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s36 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.36, i32 0, i32 0
  %t37 = load i8*, i8** %l6
  %t38 = add i8* %s36, %t37
  %t39 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t35, i8* %t38)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  %t40 = load double, double* %l4
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l4
  br label %loop.latch6
loop.latch6:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t47 = load i8*, i8** %l2
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = alloca [0 x double]
  %t56 = getelementptr [0 x double], [0 x double]* %t55, i32 0, i32 0
  %t57 = alloca { double*, i64 }
  %t58 = getelementptr { double*, i64 }, { double*, i64 }* %t57, i32 0, i32 0
  store double* %t56, double** %t58
  %t59 = getelementptr { double*, i64 }, { double*, i64 }* %t57, i32 0, i32 1
  store i64 0, i64* %t59
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t60 = sitofp i64 0 to double
  store double %t60, double* %l1
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l7
  br label %loop.header8
loop.header8:
  %t84 = phi { i8**, i64 }* [ %t63, %entry ], [ %t82, %loop.latch10 ]
  %t85 = phi double [ %t62, %entry ], [ %t83, %loop.latch10 ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l7
  store double %t85, double* %l1
  br label %loop.body9
loop.body9:
  %t64 = load double, double* %l1
  %t65 = extractvalue %TraitMetadata %metadata, 1
  %t66 = extractvalue %TraitMetadata %metadata, 1
  %t67 = load double, double* %l1
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t66
  %t69 = extractvalue { i8**, i64 } %t68, 0
  %t70 = extractvalue { i8**, i64 } %t68, 1
  %t71 = icmp uge i64 %t67, %t70
  ; bounds check: %t71 (if true, out of bounds)
  %t72 = getelementptr i8*, i8** %t69, i64 %t67
  %t73 = load i8*, i8** %t72
  store i8* %t73, i8** %l8
  %s74 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.74, i32 0, i32 0
  %t75 = load i8*, i8** %l8
  store i8* null, i8** %l9
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t77 = load i8*, i8** %l9
  %t78 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t76, i8* %t77)
  store { i8**, i64 }* %t78, { i8**, i64 }** %l7
  %t79 = load double, double* %l1
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l1
  br label %loop.latch10
loop.latch10:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t83 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = alloca [0 x double]
  %t89 = getelementptr [0 x double], [0 x double]* %t88, i32 0, i32 0
  %t90 = alloca { double*, i64 }
  %t91 = getelementptr { double*, i64 }, { double*, i64 }* %t90, i32 0, i32 0
  store double* %t89, double** %t91
  %t92 = getelementptr { double*, i64 }, { double*, i64 }* %t90, i32 0, i32 1
  store i64 0, i64* %t92
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s94 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.94, i32 0, i32 0
  %t95 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t93, i8* %s94)
  store { i8**, i64 }* %t95, { i8**, i64 }** %l10
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = call double @linesconcat({ i8**, i64 }* %t96)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t101 = call double @linesconcat({ i8**, i64 }* %t100)
  store { i8**, i64 }* null, { i8**, i64 }** %l10
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %s103 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.103, i32 0, i32 0
  %t104 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t102, i8* %s103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l10
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l10
  ret { i8**, i64 }* %t105
}

define { i8**, i64 }* @render_runtime_helper_declarations({ i8**, i64 }* %used_targets) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %RuntimeHelperDescriptor*, i64 }*
  %l2 = alloca double
  %l3 = alloca %RuntimeHelperDescriptor
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
  %t5 = call { %RuntimeHelperDescriptor*, i64 }* @runtime_helper_descriptors()
  store { %RuntimeHelperDescriptor*, i64 }* %t5, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t52 = phi { i8**, i64 }* [ %t7, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t9, %entry ], [ %t51, %loop.latch2 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  store double %t53, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t12 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t13 = load double, double* %l2
  %t14 = load { %RuntimeHelperDescriptor*, i64 }, { %RuntimeHelperDescriptor*, i64 }* %t12
  %t15 = extractvalue { %RuntimeHelperDescriptor*, i64 } %t14, 0
  %t16 = extractvalue { %RuntimeHelperDescriptor*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %t15, i64 %t13
  %t19 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %t18
  store %RuntimeHelperDescriptor %t19, %RuntimeHelperDescriptor* %l3
  %t20 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t21 = extractvalue %RuntimeHelperDescriptor %t20, 0
  %t22 = call i1 @string_array_contains({ i8**, i64 }* %used_targets, i8* %t21)
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { %RuntimeHelperDescriptor*, i64 }*, { %RuntimeHelperDescriptor*, i64 }** %l1
  %t25 = load double, double* %l2
  %t26 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  br i1 %t22, label %then4, label %merge5
then4:
  %t27 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t28 = extractvalue %RuntimeHelperDescriptor %t27, 4
  %s29 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.29, i32 0, i32 0
  store i8* %s29, i8** %l4
  %t30 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t31 = extractvalue %RuntimeHelperDescriptor %t30, 3
  %s32 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.32, i32 0, i32 0
  %t33 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t34 = extractvalue %RuntimeHelperDescriptor %t33, 2
  %t35 = add i8* %s32, %t34
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %t35, %s36
  %t38 = load %RuntimeHelperDescriptor, %RuntimeHelperDescriptor* %l3
  %t39 = extractvalue %RuntimeHelperDescriptor %t38, 1
  %t40 = add i8* %t37, %t39
  %s41 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %t40, %s41
  store i8* %t42, i8** %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l5
  %t45 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t43, i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  br label %merge5
merge5:
  %t46 = phi { i8**, i64 }* [ %t45, %then4 ], [ %t23, %loop.body1 ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  %t47 = load double, double* %l2
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l2
  br label %loop.latch2
loop.latch2:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t54
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
  %t98 = phi { %StructTypeInfo*, i64 }* [ %t12, %entry ], [ %t96, %loop.latch2 ]
  %t99 = phi double [ %t13, %entry ], [ %t97, %loop.latch2 ]
  store { %StructTypeInfo*, i64 }* %t98, { %StructTypeInfo*, i64 }** %l1
  store double %t99, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l3
  %t22 = load i8*, i8** %l3
  %t23 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t24 = load i8*, i8** %l3
  store double 0.0, double* %l5
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  %t26 = load double, double* %l5
  store double 0.0, double* %l6
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { %StructFieldInfo*, i64 }* null, { %StructFieldInfo*, i64 }** %l7
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l8
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t35 = load double, double* %l2
  %t36 = load i8*, i8** %l3
  %t37 = load double, double* %l4
  %t38 = load double, double* %l5
  %t39 = load double, double* %l6
  %t40 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t41 = load double, double* %l8
  br label %loop.header4
loop.header4:
  %t63 = phi { %StructFieldInfo*, i64 }* [ %t40, %loop.body1 ], [ %t61, %loop.latch6 ]
  %t64 = phi double [ %t41, %loop.body1 ], [ %t62, %loop.latch6 ]
  store { %StructFieldInfo*, i64 }* %t63, { %StructFieldInfo*, i64 }** %l7
  store double %t64, double* %l8
  br label %loop.body5
loop.body5:
  %t42 = load double, double* %l8
  %t43 = load double, double* %l4
  %t44 = load double, double* %l4
  store double 0.0, double* %l9
  %t45 = load double, double* %l9
  store double 0.0, double* %l10
  %t46 = load double, double* %l10
  store i8* null, i8** %l11
  %t47 = load i8*, i8** %l11
  %t48 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t49 = load double, double* %l9
  %t50 = insertvalue %StructFieldInfo undef, i8* null, 0
  %t51 = load i8*, i8** %l11
  %t52 = insertvalue %StructFieldInfo %t50, i8* %t51, 1
  %t53 = load double, double* %l8
  %t54 = insertvalue %StructFieldInfo %t52, double %t53, 2
  %t55 = load double, double* %l9
  %t56 = insertvalue %StructFieldInfo %t54, double 0.0, 3
  %t57 = call { %StructFieldInfo*, i64 }* @append_struct_field_info({ %StructFieldInfo*, i64 }* %t48, %StructFieldInfo %t56)
  store { %StructFieldInfo*, i64 }* %t57, { %StructFieldInfo*, i64 }** %l7
  %t58 = load double, double* %l8
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l8
  br label %loop.latch6
loop.latch6:
  %t61 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t62 = load double, double* %l8
  br label %loop.header4
afterloop7:
  %t65 = load double, double* %l4
  store double 0.0, double* %l12
  %t66 = load double, double* %l12
  %t67 = sitofp i64 0 to double
  %t68 = fcmp ole double %t66, %t67
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l3
  %t73 = load double, double* %l4
  %t74 = load double, double* %l5
  %t75 = load double, double* %l6
  %t76 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t77 = load double, double* %l8
  %t78 = load double, double* %l12
  br i1 %t68, label %then8, label %merge9
then8:
  %t79 = sitofp i64 1 to double
  store double %t79, double* %l12
  br label %merge9
merge9:
  %t80 = phi double [ %t79, %then8 ], [ %t78, %loop.body1 ]
  store double %t80, double* %l12
  %t81 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t82 = load i8*, i8** %l3
  %t83 = insertvalue %StructTypeInfo undef, i8* null, 0
  %t84 = load double, double* %l6
  %t85 = insertvalue %StructTypeInfo %t83, i8* null, 1
  %t86 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l7
  %t87 = insertvalue %StructTypeInfo %t85, { i8**, i64 }* null, 2
  %t88 = load double, double* %l4
  %t89 = insertvalue %StructTypeInfo %t87, double 0.0, 3
  %t90 = load double, double* %l12
  %t91 = insertvalue %StructTypeInfo %t89, double %t90, 4
  %t92 = call { %StructTypeInfo*, i64 }* @append_struct_type_info({ %StructTypeInfo*, i64 }* %t81, %StructTypeInfo %t91)
  store { %StructTypeInfo*, i64 }* %t92, { %StructTypeInfo*, i64 }** %l1
  %t93 = load double, double* %l2
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l2
  br label %loop.latch2
loop.latch2:
  %t96 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t97 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t100 = alloca [0 x double]
  %t101 = getelementptr [0 x double], [0 x double]* %t100, i32 0, i32 0
  %t102 = alloca { double*, i64 }
  %t103 = getelementptr { double*, i64 }, { double*, i64 }* %t102, i32 0, i32 0
  store double* %t101, double** %t103
  %t104 = getelementptr { double*, i64 }, { double*, i64 }* %t102, i32 0, i32 1
  store i64 0, i64* %t104
  store { %EnumTypeInfo*, i64 }* null, { %EnumTypeInfo*, i64 }** %l13
  %t105 = sitofp i64 0 to double
  store double %t105, double* %l14
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t108 = load double, double* %l2
  %t109 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t110 = load double, double* %l14
  br label %loop.header10
loop.header10:
  %t217 = phi { %EnumTypeInfo*, i64 }* [ %t109, %entry ], [ %t215, %loop.latch12 ]
  %t218 = phi double [ %t110, %entry ], [ %t216, %loop.latch12 ]
  store { %EnumTypeInfo*, i64 }* %t217, { %EnumTypeInfo*, i64 }** %l13
  store double %t218, double* %l14
  br label %loop.body11
loop.body11:
  %t111 = load double, double* %l14
  %t112 = load double, double* %l14
  %t113 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t114 = extractvalue { i8**, i64 } %t113, 0
  %t115 = extractvalue { i8**, i64 } %t113, 1
  %t116 = icmp uge i64 %t112, %t115
  ; bounds check: %t116 (if true, out of bounds)
  %t117 = getelementptr i8*, i8** %t114, i64 %t112
  %t118 = load i8*, i8** %t117
  store i8* %t118, i8** %l15
  %t119 = load i8*, i8** %l15
  %t120 = load i8*, i8** %l15
  store double 0.0, double* %l16
  %t121 = load i8*, i8** %l15
  store double 0.0, double* %l17
  %s122 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.122, i32 0, i32 0
  %t123 = load double, double* %l17
  store double 0.0, double* %l18
  %t124 = alloca [0 x double]
  %t125 = getelementptr [0 x double], [0 x double]* %t124, i32 0, i32 0
  %t126 = alloca { double*, i64 }
  %t127 = getelementptr { double*, i64 }, { double*, i64 }* %t126, i32 0, i32 0
  store double* %t125, double** %t127
  %t128 = getelementptr { double*, i64 }, { double*, i64 }* %t126, i32 0, i32 1
  store i64 0, i64* %t128
  store { %EnumVariantInfo*, i64 }* null, { %EnumVariantInfo*, i64 }** %l19
  %t129 = sitofp i64 0 to double
  store double %t129, double* %l20
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t132 = load double, double* %l2
  %t133 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t134 = load double, double* %l14
  %t135 = load i8*, i8** %l15
  %t136 = load double, double* %l16
  %t137 = load double, double* %l17
  %t138 = load double, double* %l18
  %t139 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t140 = load double, double* %l20
  br label %loop.header14
loop.header14:
  %t192 = phi { %EnumVariantInfo*, i64 }* [ %t139, %loop.body11 ], [ %t190, %loop.latch16 ]
  %t193 = phi double [ %t140, %loop.body11 ], [ %t191, %loop.latch16 ]
  store { %EnumVariantInfo*, i64 }* %t192, { %EnumVariantInfo*, i64 }** %l19
  store double %t193, double* %l20
  br label %loop.body15
loop.body15:
  %t141 = load double, double* %l20
  %t142 = load double, double* %l16
  %t143 = load double, double* %l16
  store double 0.0, double* %l21
  %t144 = alloca [0 x double]
  %t145 = getelementptr [0 x double], [0 x double]* %t144, i32 0, i32 0
  %t146 = alloca { double*, i64 }
  %t147 = getelementptr { double*, i64 }, { double*, i64 }* %t146, i32 0, i32 0
  store double* %t145, double** %t147
  %t148 = getelementptr { double*, i64 }, { double*, i64 }* %t146, i32 0, i32 1
  store i64 0, i64* %t148
  store { %StructFieldInfo*, i64 }* null, { %StructFieldInfo*, i64 }** %l22
  %t149 = sitofp i64 0 to double
  store double %t149, double* %l23
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t152 = load double, double* %l2
  %t153 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t154 = load double, double* %l14
  %t155 = load i8*, i8** %l15
  %t156 = load double, double* %l16
  %t157 = load double, double* %l17
  %t158 = load double, double* %l18
  %t159 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t160 = load double, double* %l20
  %t161 = load double, double* %l21
  %t162 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t163 = load double, double* %l23
  br label %loop.header18
loop.header18:
  %t185 = phi { %StructFieldInfo*, i64 }* [ %t162, %loop.body15 ], [ %t183, %loop.latch20 ]
  %t186 = phi double [ %t163, %loop.body15 ], [ %t184, %loop.latch20 ]
  store { %StructFieldInfo*, i64 }* %t185, { %StructFieldInfo*, i64 }** %l22
  store double %t186, double* %l23
  br label %loop.body19
loop.body19:
  %t164 = load double, double* %l23
  %t165 = load double, double* %l21
  %t166 = load double, double* %l21
  store double 0.0, double* %l24
  %t167 = load double, double* %l24
  store double 0.0, double* %l25
  %t168 = load double, double* %l25
  store i8* null, i8** %l26
  %t169 = load i8*, i8** %l26
  %t170 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t171 = load double, double* %l24
  %t172 = insertvalue %StructFieldInfo undef, i8* null, 0
  %t173 = load i8*, i8** %l26
  %t174 = insertvalue %StructFieldInfo %t172, i8* %t173, 1
  %t175 = load double, double* %l23
  %t176 = insertvalue %StructFieldInfo %t174, double %t175, 2
  %t177 = load double, double* %l24
  %t178 = insertvalue %StructFieldInfo %t176, double 0.0, 3
  %t179 = call { %StructFieldInfo*, i64 }* @append_struct_field_info({ %StructFieldInfo*, i64 }* %t170, %StructFieldInfo %t178)
  store { %StructFieldInfo*, i64 }* %t179, { %StructFieldInfo*, i64 }** %l22
  %t180 = load double, double* %l23
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l23
  br label %loop.latch20
loop.latch20:
  %t183 = load { %StructFieldInfo*, i64 }*, { %StructFieldInfo*, i64 }** %l22
  %t184 = load double, double* %l23
  br label %loop.header18
afterloop21:
  %t187 = load double, double* %l20
  %t188 = sitofp i64 1 to double
  %t189 = fadd double %t187, %t188
  store double %t189, double* %l20
  br label %loop.latch16
loop.latch16:
  %t190 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t191 = load double, double* %l20
  br label %loop.header14
afterloop17:
  %t194 = load double, double* %l16
  store double 0.0, double* %l27
  %t195 = load double, double* %l27
  %t196 = sitofp i64 0 to double
  %t197 = fcmp ole double %t195, %t196
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t200 = load double, double* %l2
  %t201 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t202 = load double, double* %l14
  %t203 = load i8*, i8** %l15
  %t204 = load double, double* %l16
  %t205 = load double, double* %l17
  %t206 = load double, double* %l18
  %t207 = load { %EnumVariantInfo*, i64 }*, { %EnumVariantInfo*, i64 }** %l19
  %t208 = load double, double* %l20
  %t209 = load double, double* %l27
  br i1 %t197, label %then22, label %merge23
then22:
  %t210 = sitofp i64 1 to double
  store double %t210, double* %l27
  br label %merge23
merge23:
  %t211 = phi double [ %t210, %then22 ], [ %t209, %loop.body11 ]
  store double %t211, double* %l27
  %t212 = load double, double* %l14
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  store double %t214, double* %l14
  br label %loop.latch12
loop.latch12:
  %t215 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t216 = load double, double* %l14
  br label %loop.header10
afterloop13:
  %t219 = alloca [0 x double]
  %t220 = getelementptr [0 x double], [0 x double]* %t219, i32 0, i32 0
  %t221 = alloca { double*, i64 }
  %t222 = getelementptr { double*, i64 }, { double*, i64 }* %t221, i32 0, i32 0
  store double* %t220, double** %t222
  %t223 = getelementptr { double*, i64 }, { double*, i64 }* %t221, i32 0, i32 1
  store i64 0, i64* %t223
  store { %InterfaceTypeInfo*, i64 }* null, { %InterfaceTypeInfo*, i64 }** %l28
  %t224 = sitofp i64 0 to double
  store double %t224, double* %l29
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t226 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t227 = load double, double* %l2
  %t228 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t229 = load double, double* %l14
  %t230 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t231 = load double, double* %l29
  br label %loop.header24
loop.header24:
  %t248 = phi { %InterfaceTypeInfo*, i64 }* [ %t230, %entry ], [ %t246, %loop.latch26 ]
  %t249 = phi double [ %t231, %entry ], [ %t247, %loop.latch26 ]
  store { %InterfaceTypeInfo*, i64 }* %t248, { %InterfaceTypeInfo*, i64 }** %l28
  store double %t249, double* %l29
  br label %loop.body25
loop.body25:
  %t232 = load double, double* %l29
  %t233 = load double, double* %l29
  %t234 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t235 = extractvalue { i8**, i64 } %t234, 0
  %t236 = extractvalue { i8**, i64 } %t234, 1
  %t237 = icmp uge i64 %t233, %t236
  ; bounds check: %t237 (if true, out of bounds)
  %t238 = getelementptr i8*, i8** %t235, i64 %t233
  %t239 = load i8*, i8** %t238
  store i8* %t239, i8** %l30
  %t240 = load i8*, i8** %l30
  store double 0.0, double* %l31
  %s241 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.241, i32 0, i32 0
  %t242 = load double, double* %l31
  store double 0.0, double* %l32
  %t243 = load double, double* %l29
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l29
  br label %loop.latch26
loop.latch26:
  %t246 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t247 = load double, double* %l29
  br label %loop.header24
afterloop27:
  %t250 = alloca [0 x double]
  %t251 = getelementptr [0 x double], [0 x double]* %t250, i32 0, i32 0
  %t252 = alloca { double*, i64 }
  %t253 = getelementptr { double*, i64 }, { double*, i64 }* %t252, i32 0, i32 0
  store double* %t251, double** %t253
  %t254 = getelementptr { double*, i64 }, { double*, i64 }* %t252, i32 0, i32 1
  store i64 0, i64* %t254
  store { %VTableInfo*, i64 }* null, { %VTableInfo*, i64 }** %l33
  %t255 = sitofp i64 0 to double
  store double %t255, double* %l34
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t257 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t258 = load double, double* %l2
  %t259 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t260 = load double, double* %l14
  %t261 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t262 = load double, double* %l29
  %t263 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t264 = load double, double* %l34
  br label %loop.header28
loop.header28:
  %t439 = phi { i8**, i64 }* [ %t256, %entry ], [ %t436, %loop.latch30 ]
  %t440 = phi { %VTableInfo*, i64 }* [ %t263, %entry ], [ %t437, %loop.latch30 ]
  %t441 = phi double [ %t264, %entry ], [ %t438, %loop.latch30 ]
  store { i8**, i64 }* %t439, { i8**, i64 }** %l0
  store { %VTableInfo*, i64 }* %t440, { %VTableInfo*, i64 }** %l33
  store double %t441, double* %l34
  br label %loop.body29
loop.body29:
  %t265 = load double, double* %l34
  %t266 = load double, double* %l34
  %t267 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t268 = extractvalue { i8**, i64 } %t267, 0
  %t269 = extractvalue { i8**, i64 } %t267, 1
  %t270 = icmp uge i64 %t266, %t269
  ; bounds check: %t270 (if true, out of bounds)
  %t271 = getelementptr i8*, i8** %t268, i64 %t266
  %t272 = load i8*, i8** %t271
  store i8* %t272, i8** %l35
  %t273 = sitofp i64 0 to double
  store double %t273, double* %l36
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t275 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t276 = load double, double* %l2
  %t277 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t278 = load double, double* %l14
  %t279 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t280 = load double, double* %l29
  %t281 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t282 = load double, double* %l34
  %t283 = load i8*, i8** %l35
  %t284 = load double, double* %l36
  br label %loop.header32
loop.header32:
  %t430 = phi { i8**, i64 }* [ %t274, %loop.body29 ], [ %t427, %loop.latch34 ]
  %t431 = phi double [ %t284, %loop.body29 ], [ %t428, %loop.latch34 ]
  %t432 = phi { %VTableInfo*, i64 }* [ %t281, %loop.body29 ], [ %t429, %loop.latch34 ]
  store { i8**, i64 }* %t430, { i8**, i64 }** %l0
  store double %t431, double* %l36
  store { %VTableInfo*, i64 }* %t432, { %VTableInfo*, i64 }** %l33
  br label %loop.body33
loop.body33:
  %t285 = load double, double* %l36
  %t286 = load i8*, i8** %l35
  %t287 = load i8*, i8** %l35
  store double 0.0, double* %l37
  store i8* null, i8** %l38
  %t288 = sitofp i64 0 to double
  store double %t288, double* %l39
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t290 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t291 = load double, double* %l2
  %t292 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t293 = load double, double* %l14
  %t294 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t295 = load double, double* %l29
  %t296 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t297 = load double, double* %l34
  %t298 = load i8*, i8** %l35
  %t299 = load double, double* %l36
  %t300 = load double, double* %l37
  %t301 = load i8*, i8** %l38
  %t302 = load double, double* %l39
  br label %loop.header36
loop.header36:
  %t315 = phi double [ %t302, %loop.body33 ], [ %t314, %loop.latch38 ]
  store double %t315, double* %l39
  br label %loop.body37
loop.body37:
  %t303 = load double, double* %l39
  %t304 = load double, double* %l39
  %t305 = load { i8**, i64 }, { i8**, i64 }* %interfaces
  %t306 = extractvalue { i8**, i64 } %t305, 0
  %t307 = extractvalue { i8**, i64 } %t305, 1
  %t308 = icmp uge i64 %t304, %t307
  ; bounds check: %t308 (if true, out of bounds)
  %t309 = getelementptr i8*, i8** %t306, i64 %t304
  %t310 = load i8*, i8** %t309
  %t311 = load double, double* %l39
  %t312 = sitofp i64 1 to double
  %t313 = fadd double %t311, %t312
  store double %t313, double* %l39
  br label %loop.latch38
loop.latch38:
  %t314 = load double, double* %l39
  br label %loop.header36
afterloop39:
  %t316 = load i8*, i8** %l38
  %t317 = icmp eq i8* %t316, null
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t320 = load double, double* %l2
  %t321 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t322 = load double, double* %l14
  %t323 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t324 = load double, double* %l29
  %t325 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t326 = load double, double* %l34
  %t327 = load i8*, i8** %l35
  %t328 = load double, double* %l36
  %t329 = load double, double* %l37
  %t330 = load i8*, i8** %l38
  %t331 = load double, double* %l39
  br i1 %t317, label %then40, label %merge41
then40:
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s333 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.333, i32 0, i32 0
  %t334 = load i8*, i8** %l35
  %t335 = load double, double* %l36
  %t336 = sitofp i64 1 to double
  %t337 = fadd double %t335, %t336
  store double %t337, double* %l36
  br label %loop.latch34
merge41:
  %t338 = load i8*, i8** %l38
  store i8* %t338, i8** %l40
  %t339 = load i8*, i8** %l35
  store double 0.0, double* %l41
  %t340 = load double, double* %l37
  %t341 = call i8* @sanitize_symbol(i8* null)
  store i8* %t341, i8** %l42
  %s342 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.342, i32 0, i32 0
  %t343 = load double, double* %l41
  store double 0.0, double* %l43
  %s344 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.344, i32 0, i32 0
  %t345 = load double, double* %l41
  store double 0.0, double* %l44
  %t346 = alloca [0 x double]
  %t347 = getelementptr [0 x double], [0 x double]* %t346, i32 0, i32 0
  %t348 = alloca { double*, i64 }
  %t349 = getelementptr { double*, i64 }, { double*, i64 }* %t348, i32 0, i32 0
  store double* %t347, double** %t349
  %t350 = getelementptr { double*, i64 }, { double*, i64 }* %t348, i32 0, i32 1
  store i64 0, i64* %t350
  store { %VTableEntry*, i64 }* null, { %VTableEntry*, i64 }** %l45
  %t351 = sitofp i64 0 to double
  store double %t351, double* %l46
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t353 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t354 = load double, double* %l2
  %t355 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t356 = load double, double* %l14
  %t357 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t358 = load double, double* %l29
  %t359 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t360 = load double, double* %l34
  %t361 = load i8*, i8** %l35
  %t362 = load double, double* %l36
  %t363 = load double, double* %l37
  %t364 = load i8*, i8** %l38
  %t365 = load double, double* %l39
  %t366 = load i8*, i8** %l40
  %t367 = load double, double* %l41
  %t368 = load i8*, i8** %l42
  %t369 = load double, double* %l43
  %t370 = load double, double* %l44
  %t371 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t372 = load double, double* %l46
  br label %loop.header42
loop.header42:
  %t422 = phi { %VTableEntry*, i64 }* [ %t371, %loop.body33 ], [ %t420, %loop.latch44 ]
  %t423 = phi double [ %t372, %loop.body33 ], [ %t421, %loop.latch44 ]
  store { %VTableEntry*, i64 }* %t422, { %VTableEntry*, i64 }** %l45
  store double %t423, double* %l46
  br label %loop.body43
loop.body43:
  %t373 = load double, double* %l46
  %t374 = load i8*, i8** %l40
  %t375 = load i8*, i8** %l40
  store double 0.0, double* %l47
  store { i8**, i64 }* null, { i8**, i64 }** %l48
  %t376 = sitofp i64 1 to double
  store double %t376, double* %l49
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t378 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t379 = load double, double* %l2
  %t380 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t381 = load double, double* %l14
  %t382 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t383 = load double, double* %l29
  %t384 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t385 = load double, double* %l34
  %t386 = load i8*, i8** %l35
  %t387 = load double, double* %l36
  %t388 = load double, double* %l37
  %t389 = load i8*, i8** %l38
  %t390 = load double, double* %l39
  %t391 = load i8*, i8** %l40
  %t392 = load double, double* %l41
  %t393 = load i8*, i8** %l42
  %t394 = load double, double* %l43
  %t395 = load double, double* %l44
  %t396 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t397 = load double, double* %l46
  %t398 = load double, double* %l47
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t400 = load double, double* %l49
  br label %loop.header46
loop.header46:
  %t413 = phi { i8**, i64 }* [ %t399, %loop.body43 ], [ %t411, %loop.latch48 ]
  %t414 = phi double [ %t400, %loop.body43 ], [ %t412, %loop.latch48 ]
  store { i8**, i64 }* %t413, { i8**, i64 }** %l48
  store double %t414, double* %l49
  br label %loop.body47
loop.body47:
  %t401 = load double, double* %l49
  %t402 = load double, double* %l47
  %t403 = load double, double* %l47
  store double 0.0, double* %l50
  %t404 = load double, double* %l50
  store double 0.0, double* %l51
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t406 = load double, double* %l51
  %t407 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t405, i8* null)
  store { i8**, i64 }* %t407, { i8**, i64 }** %l48
  %t408 = load double, double* %l49
  %t409 = sitofp i64 1 to double
  %t410 = fadd double %t408, %t409
  store double %t410, double* %l49
  br label %loop.latch48
loop.latch48:
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l48
  %t412 = load double, double* %l49
  br label %loop.header46
afterloop49:
  %t415 = load double, double* %l47
  store double 0.0, double* %l52
  %t416 = load double, double* %l52
  store double 0.0, double* %l53
  %t417 = load double, double* %l46
  %t418 = sitofp i64 1 to double
  %t419 = fadd double %t417, %t418
  store double %t419, double* %l46
  br label %loop.latch44
loop.latch44:
  %t420 = load { %VTableEntry*, i64 }*, { %VTableEntry*, i64 }** %l45
  %t421 = load double, double* %l46
  br label %loop.header42
afterloop45:
  %t424 = load double, double* %l36
  %t425 = sitofp i64 1 to double
  %t426 = fadd double %t424, %t425
  store double %t426, double* %l36
  br label %loop.latch34
loop.latch34:
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t428 = load double, double* %l36
  %t429 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  br label %loop.header32
afterloop35:
  %t433 = load double, double* %l34
  %t434 = sitofp i64 1 to double
  %t435 = fadd double %t433, %t434
  store double %t435, double* %l34
  br label %loop.latch30
loop.latch30:
  %t436 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t437 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t438 = load double, double* %l34
  br label %loop.header28
afterloop31:
  %t442 = load { %StructTypeInfo*, i64 }*, { %StructTypeInfo*, i64 }** %l1
  %t443 = insertvalue %TypeContext undef, { i8**, i64 }* null, 0
  %t444 = load { %EnumTypeInfo*, i64 }*, { %EnumTypeInfo*, i64 }** %l13
  %t445 = insertvalue %TypeContext %t443, { i8**, i64 }* null, 1
  %t446 = load { %InterfaceTypeInfo*, i64 }*, { %InterfaceTypeInfo*, i64 }** %l28
  %t447 = insertvalue %TypeContext %t445, { i8**, i64 }* null, 2
  %t448 = load { %VTableInfo*, i64 }*, { %VTableInfo*, i64 }** %l33
  %t449 = insertvalue %TypeContext %t447, { i8**, i64 }* null, 3
  %t450 = insertvalue %TypeContextBuild undef, i8* null, 0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t452 = insertvalue %TypeContextBuild %t450, { i8**, i64 }* %t451, 1
  ret %TypeContextBuild %t452
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
  %t18 = phi { i8**, i64 }* [ %t1, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t5 = load double, double* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %second
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call { i8**, i64 }* @append_native_function({ i8**, i64 }* %t4, i8* %t11)
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
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t20
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
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t7, %entry ], [ %t39, %loop.latch2 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t33 = phi { i8**, i64 }* [ %t17, %loop.body1 ], [ %t31, %loop.latch6 ]
  %t34 = phi double [ %t20, %loop.body1 ], [ %t32, %loop.latch6 ]
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  store double %t34, double* %l3
  br label %loop.body5
loop.body5:
  %t21 = load double, double* %l3
  %t22 = load i8*, i8** %l2
  %t23 = load i8*, i8** %l2
  store double 0.0, double* %l4
  %t24 = load i8*, i8** %l2
  store double 0.0, double* %l5
  store double 0.0, double* %l6
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l6
  %t27 = call { i8**, i64 }* @append_native_function({ i8**, i64 }* %t25, i8* null)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l0
  %t28 = load double, double* %l3
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l3
  br label %loop.latch6
loop.latch6:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t42
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
  %t49 = phi { i8**, i64 }* [ %t6, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t7, %entry ], [ %t48, %loop.latch2 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store double %t50, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 0
  %t10 = extractvalue %TypeContext %context, 0
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  %t18 = alloca [0 x double]
  %t19 = getelementptr [0 x double], [0 x double]* %t18, i32 0, i32 0
  %t20 = alloca { double*, i64 }
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 0
  store double* %t19, double** %t21
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t38 = phi { i8**, i64 }* [ %t27, %loop.body1 ], [ %t36, %loop.latch6 ]
  %t39 = phi double [ %t28, %loop.body1 ], [ %t37, %loop.latch6 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l3
  store double %t39, double* %l4
  br label %loop.body5
loop.body5:
  %t29 = load double, double* %l4
  %t30 = load i8*, i8** %l2
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l4
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l4
  br label %loop.latch6
loop.latch6:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t37 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %s40 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.40, i32 0, i32 0
  store i8* %s40, i8** %l5
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t51
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
  %t72 = phi { i8**, i64 }* [ %t6, %entry ], [ %t70, %loop.latch2 ]
  %t73 = phi double [ %t7, %entry ], [ %t71, %loop.latch2 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store double %t73, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 1
  %t10 = extractvalue %TypeContext %context, 1
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  %s18 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.18, i32 0, i32 0
  store i8* %s18, i8** %l3
  %t19 = load i8*, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8*, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l4
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l5
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load i8*, i8** %l3
  %t29 = load double, double* %l4
  %t30 = load double, double* %l5
  br label %loop.header4
loop.header4:
  %t39 = phi double [ %t30, %loop.body1 ], [ %t38, %loop.latch6 ]
  store double %t39, double* %l5
  br label %loop.body5
loop.body5:
  %t31 = load double, double* %l5
  %t32 = load i8*, i8** %l2
  %t33 = load i8*, i8** %l2
  store double 0.0, double* %l6
  %t34 = load double, double* %l6
  %t35 = load double, double* %l5
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l5
  br label %loop.latch6
loop.latch6:
  %t38 = load double, double* %l5
  br label %loop.header4
afterloop7:
  %s40 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.40, i32 0, i32 0
  store i8* %s40, i8** %l7
  %t41 = load double, double* %l4
  %t42 = sitofp i64 0 to double
  %t43 = fcmp ogt double %t41, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load i8*, i8** %l2
  %t47 = load i8*, i8** %l3
  %t48 = load double, double* %l4
  %t49 = load double, double* %l5
  %t50 = load i8*, i8** %l7
  br i1 %t43, label %then8, label %merge9
then8:
  %s51 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.51, i32 0, i32 0
  %t52 = load double, double* %l4
  %t53 = call i8* @number_to_string(double %t52)
  %t54 = add i8* %s51, %t53
  %s55 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.55, i32 0, i32 0
  %t56 = add i8* %t54, %s55
  store i8* %t56, i8** %l7
  br label %merge9
merge9:
  %t57 = phi i8* [ %t56, %then8 ], [ %t50, %loop.body1 ]
  store i8* %t57, i8** %l7
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.58, i32 0, i32 0
  %t59 = load i8*, i8** %l3
  %t60 = add i8* %s58, %t59
  %t61 = load i8*, i8** %l7
  %t62 = add i8* %t60, %t61
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  store i8* %t64, i8** %l8
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l2
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l1
  br label %loop.latch2
loop.latch2:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t74
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
  %t25 = phi { i8**, i64 }* [ %t6, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t7, %entry ], [ %t24, %loop.latch2 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 2
  %t10 = extractvalue %TypeContext %context, 2
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  store double 0.0, double* %l3
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t27
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
  %t49 = phi { i8**, i64 }* [ %t6, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t7, %entry ], [ %t48, %loop.latch2 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store double %t50, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 3
  %t10 = extractvalue %TypeContext %context, 3
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  %t18 = alloca [0 x double]
  %t19 = getelementptr [0 x double], [0 x double]* %t18, i32 0, i32 0
  %t20 = alloca { double*, i64 }
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 0
  store double* %t19, double** %t21
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t38 = phi { i8**, i64 }* [ %t27, %loop.body1 ], [ %t36, %loop.latch6 ]
  %t39 = phi double [ %t28, %loop.body1 ], [ %t37, %loop.latch6 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l3
  store double %t39, double* %l4
  br label %loop.body5
loop.body5:
  %t29 = load double, double* %l4
  %t30 = load i8*, i8** %l2
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l4
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l4
  br label %loop.latch6
loop.latch6:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t37 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %s40 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.40, i32 0, i32 0
  store i8* %s40, i8** %l5
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t51
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
  %t54 = phi { i8**, i64 }* [ %t6, %entry ], [ %t52, %loop.latch2 ]
  %t55 = phi double [ %t7, %entry ], [ %t53, %loop.latch2 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %TypeContext %context, 3
  %t10 = extractvalue %TypeContext %context, 3
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t10
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  %t18 = alloca [0 x double]
  %t19 = getelementptr [0 x double], [0 x double]* %t18, i32 0, i32 0
  %t20 = alloca { double*, i64 }
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 0
  store double* %t19, double** %t21
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t43 = phi { i8**, i64 }* [ %t27, %loop.body1 ], [ %t41, %loop.latch6 ]
  %t44 = phi double [ %t28, %loop.body1 ], [ %t42, %loop.latch6 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l3
  store double %t44, double* %l4
  br label %loop.body5
loop.body5:
  %t29 = load double, double* %l4
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l2
  store double 0.0, double* %l5
  %t32 = load double, double* %l5
  store double 0.0, double* %l6
  %s33 = getelementptr inbounds [111 x i8], [111 x i8]* @.str.33, i32 0, i32 0
  store i8* %s33, i8** %l7
  %t34 = load double, double* %l5
  store double 0.0, double* %l8
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t36 = load double, double* %l8
  %t37 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t35, i8* null)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l3
  %t38 = load double, double* %l4
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l4
  br label %loop.latch6
loop.latch6:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %s45 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.45, i32 0, i32 0
  store i8* %s45, i8** %l9
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l2
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t56
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
  %t25 = phi { %FunctionEffectEntry*, i64 }* [ %t6, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t7, %entry ], [ %t24, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t25, { %FunctionEffectEntry*, i64 }** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call %FunctionEffectEntry @collect_function_effect_entry(i8* %t15)
  store %FunctionEffectEntry %t16, %FunctionEffectEntry* %l2
  %t17 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t18 = load %FunctionEffectEntry, %FunctionEffectEntry* %l2
  %t19 = call { %FunctionEffectEntry*, i64 }* @append_function_effect_entry({ %FunctionEffectEntry*, i64 }* %t17, %FunctionEffectEntry %t18)
  store { %FunctionEffectEntry*, i64 }* %t19, { %FunctionEffectEntry*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  ret { %FunctionEffectEntry*, i64 }* %t27
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
  %t28 = phi { %FunctionCallEntry*, i64 }* [ %t7, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi double [ %t9, %entry ], [ %t27, %loop.latch2 ]
  store { %FunctionCallEntry*, i64 }* %t28, { %FunctionCallEntry*, i64 }** %l0
  store double %t29, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = call %FunctionCallEntry @collect_function_call_entry(i8* %t17, { i8**, i64 }* %t18)
  store %FunctionCallEntry %t19, %FunctionCallEntry* %l3
  %t20 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t21 = load %FunctionCallEntry, %FunctionCallEntry* %l3
  %t22 = call { %FunctionCallEntry*, i64 }* @append_function_call_entry({ %FunctionCallEntry*, i64 }* %t20, %FunctionCallEntry %t21)
  store { %FunctionCallEntry*, i64 }* %t22, { %FunctionCallEntry*, i64 }** %l0
  %t23 = load double, double* %l2
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l2
  br label %loop.latch2
loop.latch2:
  %t26 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  %t27 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t30 = load { %FunctionCallEntry*, i64 }*, { %FunctionCallEntry*, i64 }** %l0
  ret { %FunctionCallEntry*, i64 }* %t30
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
  %t25 = phi { i8**, i64 }* [ %t6, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t7, %entry ], [ %t24, %loop.latch2 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call { i8**, i64 }* @collect_function_runtime_helper_targets(i8* %t15)
  store { i8**, i64 }* %t16, { i8**, i64 }** %l2
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t19 = call { i8**, i64 }* @merge_effect_lists({ i8**, i64 }* %t17, { i8**, i64 }* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t27
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
  %t22 = phi { i8**, i64 }* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t24
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
  %t24 = phi double [ %t7, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %targets
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = call double @find_runtime_helper(i8* %t17)
  store double %t18, double* %l3
  %t19 = load double, double* %l3
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t25
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
  %t14 = phi { %FunctionEffectEntry*, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  %t15 = phi double [ %t7, %entry ], [ %t13, %loop.latch2 ]
  store { %FunctionEffectEntry*, i64 }* %t14, { %FunctionEffectEntry*, i64 }** %l0
  store double %t15, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %t9, %t10
  store double %t11, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  store i1 1, i1* %l2
  %t16 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load i1, i1* %l2
  br label %loop.header4
loop.header4:
  %t48 = phi i1 [ %t18, %entry ], [ %t47, %loop.latch6 ]
  store i1 %t48, i1* %l2
  br label %loop.body5
loop.body5:
  %t19 = load i1, i1* %l2
  %t20 = xor i1 %t19, 1
  %t21 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = load i1, i1* %l2
  br i1 %t20, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 0, i1* %l2
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l3
  %t25 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i1, i1* %l2
  %t28 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t46 = phi double [ %t28, %loop.body5 ], [ %t45, %loop.latch12 ]
  store double %t46, double* %l3
  br label %loop.body11
loop.body11:
  %t29 = load double, double* %l3
  %t30 = load double, double* %l3
  %t31 = load { %FunctionCallEntry*, i64 }, { %FunctionCallEntry*, i64 }* %call_graph
  %t32 = extractvalue { %FunctionCallEntry*, i64 } %t31, 0
  %t33 = extractvalue { %FunctionCallEntry*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr %FunctionCallEntry, %FunctionCallEntry* %t32, i64 %t30
  %t36 = load %FunctionCallEntry, %FunctionCallEntry* %t35
  store %FunctionCallEntry %t36, %FunctionCallEntry* %l4
  %t37 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  %t38 = load %FunctionCallEntry, %FunctionCallEntry* %l4
  %t39 = extractvalue %FunctionCallEntry %t38, 0
  %t40 = call double @find_function_effect_entry({ %FunctionEffectEntry*, i64 }* %t37, i8* %t39)
  store double %t40, double* %l5
  %t41 = load double, double* %l5
  %t42 = load double, double* %l3
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l3
  br label %loop.latch12
loop.latch12:
  %t45 = load double, double* %l3
  br label %loop.header10
afterloop13:
  br label %loop.latch6
loop.latch6:
  %t47 = load i1, i1* %l2
  br label %loop.header4
afterloop7:
  %t49 = load { %FunctionEffectEntry*, i64 }*, { %FunctionEffectEntry*, i64 }** %l0
  ret { %FunctionEffectEntry*, i64 }* %t49
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
  %t35 = phi { %CapabilityManifestEntry*, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store { %CapabilityManifestEntry*, i64 }* %t35, { %CapabilityManifestEntry*, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %entry_points
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  %t17 = call double @find_function_effect_entry({ %FunctionEffectEntry*, i64 }* %function_effects, i8* %t16)
  store double %t17, double* %l3
  %t18 = alloca [0 x double]
  %t19 = getelementptr [0 x double], [0 x double]* %t18, i32 0, i32 0
  %t20 = alloca { double*, i64 }
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 0
  store double* %t19, double** %t21
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t23 = load double, double* %l3
  %t24 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t25 = load i8*, i8** %l2
  %t26 = insertvalue %CapabilityManifestEntry undef, i8* %t25, 0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t28 = insertvalue %CapabilityManifestEntry %t26, { i8**, i64 }* %t27, 1
  %t29 = call { %CapabilityManifestEntry*, i64 }* @append_manifest_entry({ %CapabilityManifestEntry*, i64 }* %t24, %CapabilityManifestEntry %t28)
  store { %CapabilityManifestEntry*, i64 }* %t29, { %CapabilityManifestEntry*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load { %CapabilityManifestEntry*, i64 }*, { %CapabilityManifestEntry*, i64 }** %l0
  %t38 = insertvalue %CapabilityManifest undef, { i8**, i64 }* null, 0
  ret %CapabilityManifest %t38
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
  %t18 = phi { i8**, i64 }* [ %t1, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t5 = load double, double* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %extras
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t4, i8* %t11)
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
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t20
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
  %t23 = phi { i8**, i64 }* [ %t6, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t7, %entry ], [ %t22, %loop.latch2 ]
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  store double %t24, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %values
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t9, i8* %t16)
  store { i8**, i64 }* %t17, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
loop.latch2:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t25
}

define i1 @string_arrays_equal({ i8**, i64 }* %first, { i8**, i64 }* %second) {
entry:
  %l0 = alloca double
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
  %t4 = load { i8**, i64 }, { i8**, i64 }* %first
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  %t10 = load double, double* %l0
  %t11 = load { i8**, i64 }, { i8**, i64 }* %second
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = icmp ne i8* %t9, %t16
  %t18 = load double, double* %l0
  br i1 %t17, label %then4, label %merge5
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
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t17 = load i8*, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = load i8*, i8** %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l3
  %t22 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t20, i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
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
  %t27 = call %BodyResult @emit_body(i8* %function, i8* null, { %ParameterBinding*, i64 }* null, { i8**, i64 }* %functions, %TypeContext %context)
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
  %t36 = call { i8**, i64 }* @validate_borrow_lifetimes(i8* %function, { %LifetimeRegionMetadata*, i64 }* null)
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
  %t108 = phi { i8**, i64 }* [ %t6, %entry ], [ %t106, %loop.latch2 ]
  %t109 = phi double [ %t7, %entry ], [ %t107, %loop.latch2 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  store double %t109, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = load { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %regions
  %t12 = extractvalue { %LifetimeRegionMetadata*, i64 } %t11, 0
  %t13 = extractvalue { %LifetimeRegionMetadata*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t12, i64 %t10
  %t16 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t15
  store %LifetimeRegionMetadata %t16, %LifetimeRegionMetadata* %l3
  %t17 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t18 = extractvalue %LifetimeRegionMetadata %t17, 7
  store i8* %t18, i8** %l4
  %t19 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t20 = extractvalue %LifetimeRegionMetadata %t19, 8
  store double %t20, double* %l5
  %t21 = load i8*, i8** %l4
  store i1 0, i1* %l6
  %t22 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t23 = extractvalue %LifetimeRegionMetadata %t22, 11
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load double, double* %l2
  %t27 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t28 = load i8*, i8** %l4
  %t29 = load double, double* %l5
  %t30 = load i1, i1* %l6
  br i1 %t23, label %then4, label %else5
then4:
  %t31 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t32 = extractvalue %LifetimeRegionMetadata %t31, 9
  br label %merge6
else5:
  %t33 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t34 = extractvalue %LifetimeRegionMetadata %t33, 6
  %t35 = load double, double* %l5
  %t36 = fcmp olt double %t34, %t35
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l2
  %t40 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load double, double* %l5
  %t43 = load i1, i1* %l6
  br i1 %t36, label %then7, label %else8
then7:
  store i1 1, i1* %l6
  br label %merge9
else8:
  %t44 = load i8*, i8** %l4
  %t45 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t46 = extractvalue %LifetimeRegionMetadata %t45, 5
  %t47 = call i1 @is_scope_descendant(i8* %t44, i8* %t46)
  %t48 = xor i1 %t47, 1
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  %t52 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t53 = load i8*, i8** %l4
  %t54 = load double, double* %l5
  %t55 = load i1, i1* %l6
  br i1 %t48, label %then10, label %merge11
then10:
  store i1 1, i1* %l6
  br label %merge11
merge11:
  %t56 = phi i1 [ 1, %then10 ], [ %t55, %else8 ]
  store i1 %t56, i1* %l6
  br label %merge9
merge9:
  %t57 = phi i1 [ 1, %then7 ], [ 1, %else8 ]
  store i1 %t57, i1* %l6
  br label %merge6
merge6:
  %t58 = phi i1 [ %t30, %then4 ], [ 1, %else5 ]
  store i1 %t58, i1* %l6
  %t59 = load i1, i1* %l6
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = load double, double* %l2
  %t63 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t64 = load i8*, i8** %l4
  %t65 = load double, double* %l5
  %t66 = load i1, i1* %l6
  br i1 %t59, label %then12, label %merge13
then12:
  %s67 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.67, i32 0, i32 0
  store i8* %s67, i8** %l7
  %t68 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t69 = extractvalue %LifetimeRegionMetadata %t68, 4
  %t70 = icmp ne i8* %t69, null
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load double, double* %l1
  %t73 = load double, double* %l2
  %t74 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t75 = load i8*, i8** %l4
  %t76 = load double, double* %l5
  %t77 = load i1, i1* %l6
  %t78 = load i8*, i8** %l7
  br i1 %t70, label %then14, label %merge15
then14:
  %s79 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.79, i32 0, i32 0
  %t80 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t81 = extractvalue %LifetimeRegionMetadata %t80, 4
  %t82 = call i8* @format_span_location(i8* %t81)
  %t83 = add i8* %s79, %t82
  store i8* %t83, i8** %l7
  br label %merge15
merge15:
  %t84 = phi i8* [ %t83, %then14 ], [ %t78, %then12 ]
  store i8* %t84, i8** %l7
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s86 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.86, i32 0, i32 0
  %t87 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t88 = extractvalue %LifetimeRegionMetadata %t87, 1
  %t89 = add i8* %s86, %t88
  %s90 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.90, i32 0, i32 0
  %t91 = add i8* %t89, %s90
  %t92 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t93 = extractvalue %LifetimeRegionMetadata %t92, 2
  %t94 = add i8* %t91, %t93
  %s95 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.95, i32 0, i32 0
  %t96 = add i8* %t94, %s95
  %t97 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l3
  %t98 = extractvalue %LifetimeRegionMetadata %t97, 2
  %t99 = add i8* %t96, %t98
  %s100 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.100, i32 0, i32 0
  %t101 = add i8* %t99, %s100
  br label %merge13
merge13:
  %t102 = phi { i8**, i64 }* [ null, %then12 ], [ %t60, %loop.body1 ]
  store { i8**, i64 }* %t102, { i8**, i64 }** %l0
  %t103 = load double, double* %l1
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l1
  br label %loop.latch2
loop.latch2:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t110
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
  %t54 = phi { i8**, i64 }* [ %t12, %entry ], [ %t52, %loop.latch2 ]
  %t55 = phi double [ %t19, %entry ], [ %t53, %loop.latch2 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l7
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
  %t39 = load double, double* %l7
  %t40 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t41 = extractvalue { i8**, i64 } %t40, 0
  %t42 = extractvalue { i8**, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  %t44 = getelementptr i8*, i8** %t41, i64 %t39
  %t45 = load i8*, i8** %t44
  store i8* %t45, i8** %l9
  %t46 = load i8*, i8** %l9
  %t47 = load i8*, i8** %l9
  %t48 = load i8*, i8** %l9
  %t49 = load double, double* %l7
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l7
  br label %loop.latch2
loop.latch2:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l7
  br label %loop.header0
afterloop3:
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
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  %t13 = load double, double* %l3
  %t14 = load double, double* %l4
  %t15 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t59 = phi double [ %t15, %entry ], [ %t56, %loop.latch2 ]
  %t60 = phi { i8**, i64 }* [ %t10, %entry ], [ %t57, %loop.latch2 ]
  %t61 = phi double [ %t14, %entry ], [ %t58, %loop.latch2 ]
  store double %t59, double* %l5
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  store double %t61, double* %l4
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
  %t42 = load double, double* %l4
  %t43 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t44 = extractvalue { i8**, i64 } %t43, 0
  %t45 = extractvalue { i8**, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  %t47 = getelementptr i8*, i8** %t44, i64 %t42
  %t48 = load i8*, i8** %t47
  store i8* %t48, i8** %l6
  %t50 = load i8*, i8** %l6
  %t52 = load i8*, i8** %l6
  %t53 = load double, double* %l4
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l4
  br label %loop.latch2
loop.latch2:
  %t56 = load double, double* %l5
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l4
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
  %t9 = sitofp i64 1 to double
  %t10 = fsub double %t8, %t9
  store double %t10, double* %l0
  %t11 = load double, double* %l0
  %t12 = load { %LoopContext*, i64 }, { %LoopContext*, i64 }* %values
  %t13 = extractvalue { %LoopContext*, i64 } %t12, 0
  %t14 = extractvalue { %LoopContext*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %LoopContext, %LoopContext* %t13, i64 %t11
  %t17 = load %LoopContext, %LoopContext* %t16
  ret %LoopContext %t17
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
  %t83 = phi double [ %t32, %entry ], [ %t79, %loop.latch2 ]
  %t84 = phi { i8**, i64 }* [ %t28, %entry ], [ %t80, %loop.latch2 ]
  %t85 = phi { i8**, i64 }* [ %t40, %entry ], [ %t81, %loop.latch2 ]
  %t86 = phi double [ %t41, %entry ], [ %t82, %loop.latch2 ]
  store double %t83, double* %l5
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  store { i8**, i64 }* %t85, { i8**, i64 }** %l13
  store double %t86, double* %l14
  br label %loop.body1
loop.body1:
  %t42 = load double, double* %l14
  %t43 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t44 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t45 = load double, double* %l14
  %t46 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t44
  %t47 = extractvalue { %LocalBinding*, i64 } %t46, 0
  %t48 = extractvalue { %LocalBinding*, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr %LocalBinding, %LocalBinding* %t47, i64 %t45
  %t51 = load %LocalBinding, %LocalBinding* %t50
  store %LocalBinding %t51, %LocalBinding* %l15
  %t52 = load double, double* %l5
  %t53 = call i8* @format_temp_name(double %t52)
  store i8* %t53, i8** %l16
  %t54 = load double, double* %l5
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l5
  %s57 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.57, i32 0, i32 0
  %t58 = load i8*, i8** %l16
  %t59 = add i8* %s57, %t58
  %s60 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.60, i32 0, i32 0
  %t61 = add i8* %t59, %s60
  %t62 = load %LocalBinding, %LocalBinding* %l15
  %t63 = extractvalue %LocalBinding %t62, 2
  %t64 = add i8* %t61, %t63
  %s65 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.65, i32 0, i32 0
  %t66 = add i8* %t64, %s65
  %t67 = load %LocalBinding, %LocalBinding* %l15
  %t68 = extractvalue %LocalBinding %t67, 2
  %t69 = add i8* %t66, %t68
  store double 0.0, double* %l17
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load double, double* %l17
  %t72 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t70, i8* null)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t74 = load i8*, i8** %l16
  %t75 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t73, i8* %t74)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l13
  %t76 = load double, double* %l14
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l14
  br label %loop.latch2
loop.latch2:
  %t79 = load double, double* %l5
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t82 = load double, double* %l14
  br label %loop.header0
afterloop3:
  %s87 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.87, i32 0, i32 0
  %t88 = load double, double* %l6
  %t89 = call %BlockLabelResult @allocate_block_label(i8* %s87, double %t88)
  store %BlockLabelResult %t89, %BlockLabelResult* %l18
  %t90 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t91 = extractvalue %BlockLabelResult %t90, 0
  store i8* %t91, i8** %l19
  %t92 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t93 = extractvalue %BlockLabelResult %t92, 1
  store double %t93, double* %l6
  %s94 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.94, i32 0, i32 0
  %t95 = load double, double* %l6
  %t96 = call %BlockLabelResult @allocate_block_label(i8* %s94, double %t95)
  store %BlockLabelResult %t96, %BlockLabelResult* %l20
  %t97 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t98 = extractvalue %BlockLabelResult %t97, 0
  store i8* %t98, i8** %l21
  %t99 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t100 = extractvalue %BlockLabelResult %t99, 1
  store double %t100, double* %l6
  %s101 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.101, i32 0, i32 0
  %t102 = load double, double* %l6
  %t103 = call %BlockLabelResult @allocate_block_label(i8* %s101, double %t102)
  store %BlockLabelResult %t103, %BlockLabelResult* %l22
  %t104 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t105 = extractvalue %BlockLabelResult %t104, 0
  store i8* %t105, i8** %l23
  %t106 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t107 = extractvalue %BlockLabelResult %t106, 1
  store double %t107, double* %l6
  %s108 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.108, i32 0, i32 0
  %t109 = load double, double* %l6
  %t110 = call %BlockLabelResult @allocate_block_label(i8* %s108, double %t109)
  store %BlockLabelResult %t110, %BlockLabelResult* %l24
  %t111 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t112 = extractvalue %BlockLabelResult %t111, 0
  store i8* %t112, i8** %l25
  %t113 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t114 = extractvalue %BlockLabelResult %t113, 1
  store double %t114, double* %l6
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s116 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.116, i32 0, i32 0
  %t117 = load i8*, i8** %l19
  %t118 = add i8* %s116, %t117
  %t119 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t115, i8* %t118)
  store { i8**, i64 }* %t119, { i8**, i64 }** %l1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load i8*, i8** %l19
  %s122 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.122, i32 0, i32 0
  %t123 = add i8* %t121, %s122
  %t124 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t120, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l1
  %t125 = load i8*, i8** %l25
  %t126 = insertvalue %LoopContext undef, i8* %t125, 0
  %t127 = load i8*, i8** %l23
  %t128 = insertvalue %LoopContext %t126, i8* %t127, 1
  store %LoopContext %t128, %LoopContext* %l26
  %t129 = load %LoopContext, %LoopContext* %l26
  %t130 = call { %LoopContext*, i64 }* @append_loop_context({ %LoopContext*, i64 }* %loop_stack, %LoopContext %t129)
  store { %LoopContext*, i64 }* %t130, { %LoopContext*, i64 }** %l27
  %t131 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store { %LocalBinding*, i64 }* %t131, { %LocalBinding*, i64 }** %l28
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store { i8**, i64 }* %t132, { i8**, i64 }** %l29
  %t133 = load double, double* %l7
  store double %t133, double* %l30
  %t134 = load i8*, i8** %l21
  %t135 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t134)
  store i8* %t135, i8** %l31
  store double 0.0, double* %l32
  %t136 = load double, double* %l32
  %t137 = load double, double* %l32
  %t138 = load double, double* %l32
  %t139 = load double, double* %l32
  %t140 = load double, double* %l32
  %t141 = load double, double* %l32
  %t142 = load double, double* %l32
  %t143 = load double, double* %l32
  %t144 = load double, double* %l32
  %t145 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t146 = load double, double* %l32
  %t147 = alloca [0 x double]
  %t148 = getelementptr [0 x double], [0 x double]* %t147, i32 0, i32 0
  %t149 = alloca { double*, i64 }
  %t150 = getelementptr { double*, i64 }, { double*, i64 }* %t149, i32 0, i32 0
  store double* %t148, double** %t150
  %t151 = getelementptr { double*, i64 }, { double*, i64 }* %t149, i32 0, i32 1
  store i64 0, i64* %t151
  store { i8**, i64 }* null, { i8**, i64 }** %l33
  %t152 = alloca [0 x double]
  %t153 = getelementptr [0 x double], [0 x double]* %t152, i32 0, i32 0
  %t154 = alloca { double*, i64 }
  %t155 = getelementptr { double*, i64 }, { double*, i64 }* %t154, i32 0, i32 0
  store double* %t153, double** %t155
  %t156 = getelementptr { double*, i64 }, { double*, i64 }* %t154, i32 0, i32 1
  store i64 0, i64* %t156
  store { i8**, i64 }* null, { i8**, i64 }** %l34
  %t157 = alloca [0 x double]
  %t158 = getelementptr [0 x double], [0 x double]* %t157, i32 0, i32 0
  %t159 = alloca { double*, i64 }
  %t160 = getelementptr { double*, i64 }, { double*, i64 }* %t159, i32 0, i32 0
  store double* %t158, double** %t160
  %t161 = getelementptr { double*, i64 }, { double*, i64 }* %t159, i32 0, i32 1
  store i64 0, i64* %t161
  store { i8**, i64 }* null, { i8**, i64 }** %l35
  %t162 = sitofp i64 0 to double
  store double %t162, double* %l36
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t166 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t167 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t168 = load double, double* %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  %t171 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t172 = load double, double* %l9
  %t173 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t174 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t175 = load double, double* %l12
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t177 = load double, double* %l14
  %t178 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t179 = load i8*, i8** %l19
  %t180 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t181 = load i8*, i8** %l21
  %t182 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t183 = load i8*, i8** %l23
  %t184 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t185 = load i8*, i8** %l25
  %t186 = load %LoopContext, %LoopContext* %l26
  %t187 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t188 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t190 = load double, double* %l30
  %t191 = load i8*, i8** %l31
  %t192 = load double, double* %l32
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t196 = load double, double* %l36
  br label %loop.header4
loop.header4:
  %t301 = phi { i8**, i64 }* [ %t195, %entry ], [ %t299, %loop.latch6 ]
  %t302 = phi double [ %t196, %entry ], [ %t300, %loop.latch6 ]
  store { i8**, i64 }* %t301, { i8**, i64 }** %l35
  store double %t302, double* %l36
  br label %loop.body5
loop.body5:
  %t197 = load double, double* %l36
  %t198 = load double, double* %l32
  %t199 = load double, double* %l32
  store double 0.0, double* %l37
  store i1 0, i1* %l38
  %t200 = sitofp i64 0 to double
  store double %t200, double* %l39
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t204 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t205 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t206 = load double, double* %l5
  %t207 = load double, double* %l6
  %t208 = load double, double* %l7
  %t209 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t210 = load double, double* %l9
  %t211 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t212 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t213 = load double, double* %l12
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t215 = load double, double* %l14
  %t216 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t217 = load i8*, i8** %l19
  %t218 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t219 = load i8*, i8** %l21
  %t220 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t221 = load i8*, i8** %l23
  %t222 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t223 = load i8*, i8** %l25
  %t224 = load %LoopContext, %LoopContext* %l26
  %t225 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t226 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t228 = load double, double* %l30
  %t229 = load i8*, i8** %l31
  %t230 = load double, double* %l32
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t234 = load double, double* %l36
  %t235 = load double, double* %l37
  %t236 = load i1, i1* %l38
  %t237 = load double, double* %l39
  br label %loop.header8
loop.header8:
  %t253 = phi double [ %t237, %loop.body5 ], [ %t252, %loop.latch10 ]
  store double %t253, double* %l39
  br label %loop.body9
loop.body9:
  %t238 = load double, double* %l39
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t241 = load double, double* %l39
  %t242 = load { i8**, i64 }, { i8**, i64 }* %t240
  %t243 = extractvalue { i8**, i64 } %t242, 0
  %t244 = extractvalue { i8**, i64 } %t242, 1
  %t245 = icmp uge i64 %t241, %t244
  ; bounds check: %t245 (if true, out of bounds)
  %t246 = getelementptr i8*, i8** %t243, i64 %t241
  %t247 = load i8*, i8** %t246
  %t248 = load double, double* %l37
  %t249 = load double, double* %l39
  %t250 = sitofp i64 1 to double
  %t251 = fadd double %t249, %t250
  store double %t251, double* %l39
  br label %loop.latch10
loop.latch10:
  %t252 = load double, double* %l39
  br label %loop.header8
afterloop11:
  %t254 = load i1, i1* %l38
  %t255 = xor i1 %t254, 1
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t259 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t260 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t261 = load double, double* %l5
  %t262 = load double, double* %l6
  %t263 = load double, double* %l7
  %t264 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t265 = load double, double* %l9
  %t266 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t267 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t268 = load double, double* %l12
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t270 = load double, double* %l14
  %t271 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t272 = load i8*, i8** %l19
  %t273 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t274 = load i8*, i8** %l21
  %t275 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t276 = load i8*, i8** %l23
  %t277 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t278 = load i8*, i8** %l25
  %t279 = load %LoopContext, %LoopContext* %l26
  %t280 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t281 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t283 = load double, double* %l30
  %t284 = load i8*, i8** %l31
  %t285 = load double, double* %l32
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t289 = load double, double* %l36
  %t290 = load double, double* %l37
  %t291 = load i1, i1* %l38
  %t292 = load double, double* %l39
  br i1 %t255, label %then12, label %merge13
then12:
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t294 = load double, double* %l37
  br label %merge13
merge13:
  %t295 = phi { i8**, i64 }* [ null, %then12 ], [ %t288, %loop.body5 ]
  store { i8**, i64 }* %t295, { i8**, i64 }** %l35
  %t296 = load double, double* %l36
  %t297 = sitofp i64 1 to double
  %t298 = fadd double %t296, %t297
  store double %t298, double* %l36
  br label %loop.latch6
loop.latch6:
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t300 = load double, double* %l36
  br label %loop.header4
afterloop7:
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s304 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.304, i32 0, i32 0
  %t305 = load i8*, i8** %l21
  %t306 = add i8* %s304, %t305
  %t307 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t303, i8* %t306)
  store { i8**, i64 }* %t307, { i8**, i64 }** %l1
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t309 = load i8*, i8** %l21
  %s310 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.310, i32 0, i32 0
  %t311 = add i8* %t309, %s310
  %t312 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t308, i8* %t311)
  store { i8**, i64 }* %t312, { i8**, i64 }** %l1
  %t313 = load double, double* %l32
  %t314 = load double, double* %l32
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t316 = load i8*, i8** %l23
  %s317 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.317, i32 0, i32 0
  %t318 = add i8* %t316, %s317
  %t319 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t315, i8* %t318)
  store { i8**, i64 }* %t319, { i8**, i64 }** %l1
  %t320 = alloca [0 x double]
  %t321 = getelementptr [0 x double], [0 x double]* %t320, i32 0, i32 0
  %t322 = alloca { double*, i64 }
  %t323 = getelementptr { double*, i64 }, { double*, i64 }* %t322, i32 0, i32 0
  store double* %t321, double** %t323
  %t324 = getelementptr { double*, i64 }, { double*, i64 }* %t322, i32 0, i32 1
  store i64 0, i64* %t324
  store { i8**, i64 }* null, { i8**, i64 }** %l40
  %t325 = sitofp i64 0 to double
  store double %t325, double* %l41
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t329 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t330 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t331 = load double, double* %l5
  %t332 = load double, double* %l6
  %t333 = load double, double* %l7
  %t334 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t335 = load double, double* %l9
  %t336 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t337 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t338 = load double, double* %l12
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t340 = load double, double* %l14
  %t341 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t342 = load i8*, i8** %l19
  %t343 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t344 = load i8*, i8** %l21
  %t345 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t346 = load i8*, i8** %l23
  %t347 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t348 = load i8*, i8** %l25
  %t349 = load %LoopContext, %LoopContext* %l26
  %t350 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t351 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t353 = load double, double* %l30
  %t354 = load i8*, i8** %l31
  %t355 = load double, double* %l32
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t359 = load double, double* %l36
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t361 = load double, double* %l41
  br label %loop.header14
loop.header14:
  %t380 = phi double [ %t361, %entry ], [ %t379, %loop.latch16 ]
  store double %t380, double* %l41
  br label %loop.body15
loop.body15:
  %t362 = load double, double* %l41
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t365 = load double, double* %l41
  %t366 = load { i8**, i64 }, { i8**, i64 }* %t364
  %t367 = extractvalue { i8**, i64 } %t366, 0
  %t368 = extractvalue { i8**, i64 } %t366, 1
  %t369 = icmp uge i64 %t365, %t368
  ; bounds check: %t369 (if true, out of bounds)
  %t370 = getelementptr i8*, i8** %t367, i64 %t365
  %t371 = load i8*, i8** %t370
  store i8* %t371, i8** %l42
  %t372 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t373 = load i8*, i8** %l42
  %t374 = call double @find_local_binding({ %LocalBinding*, i64 }* %t372, i8* %t373)
  store double %t374, double* %l43
  %t375 = load double, double* %l43
  %t376 = load double, double* %l41
  %t377 = sitofp i64 1 to double
  %t378 = fadd double %t376, %t377
  store double %t378, double* %l41
  br label %loop.latch16
loop.latch16:
  %t379 = load double, double* %l41
  br label %loop.header14
afterloop17:
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s382 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.382, i32 0, i32 0
  %t383 = load i8*, i8** %l19
  %t384 = add i8* %s382, %t383
  %t385 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t381, i8* %t384)
  store { i8**, i64 }* %t385, { i8**, i64 }** %l1
  %t386 = sitofp i64 0 to double
  store double %t386, double* %l44
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t390 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t391 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t392 = load double, double* %l5
  %t393 = load double, double* %l6
  %t394 = load double, double* %l7
  %t395 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t396 = load double, double* %l9
  %t397 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t398 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t399 = load double, double* %l12
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t401 = load double, double* %l14
  %t402 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t403 = load i8*, i8** %l19
  %t404 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t405 = load i8*, i8** %l21
  %t406 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t407 = load i8*, i8** %l23
  %t408 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t409 = load i8*, i8** %l25
  %t410 = load %LoopContext, %LoopContext* %l26
  %t411 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t412 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t414 = load double, double* %l30
  %t415 = load i8*, i8** %l31
  %t416 = load double, double* %l32
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t420 = load double, double* %l36
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t422 = load double, double* %l41
  %t423 = load double, double* %l44
  br label %loop.header18
loop.header18:
  %t443 = phi double [ %t423, %entry ], [ %t442, %loop.latch20 ]
  store double %t443, double* %l44
  br label %loop.body19
loop.body19:
  %t424 = load double, double* %l44
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t427 = load double, double* %l44
  %t428 = load { i8**, i64 }, { i8**, i64 }* %t426
  %t429 = extractvalue { i8**, i64 } %t428, 0
  %t430 = extractvalue { i8**, i64 } %t428, 1
  %t431 = icmp uge i64 %t427, %t430
  ; bounds check: %t431 (if true, out of bounds)
  %t432 = getelementptr i8*, i8** %t429, i64 %t427
  %t433 = load i8*, i8** %t432
  store i8* %t433, i8** %l45
  %t434 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t435 = load i8*, i8** %l45
  %t436 = call double @find_local_binding({ %LocalBinding*, i64 }* %t434, i8* %t435)
  store double %t436, double* %l46
  %t438 = load double, double* %l46
  %t439 = load double, double* %l44
  %t440 = sitofp i64 1 to double
  %t441 = fadd double %t439, %t440
  store double %t441, double* %l44
  br label %loop.latch20
loop.latch20:
  %t442 = load double, double* %l44
  br label %loop.header18
afterloop21:
  %t444 = alloca [0 x double]
  %t445 = getelementptr [0 x double], [0 x double]* %t444, i32 0, i32 0
  %t446 = alloca { double*, i64 }
  %t447 = getelementptr { double*, i64 }, { double*, i64 }* %t446, i32 0, i32 0
  store double* %t445, double** %t447
  %t448 = getelementptr { double*, i64 }, { double*, i64 }* %t446, i32 0, i32 1
  store i64 0, i64* %t448
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  %t449 = sitofp i64 0 to double
  store double %t449, double* %l48
  store i1 0, i1* %l49
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t453 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t454 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t455 = load double, double* %l5
  %t456 = load double, double* %l6
  %t457 = load double, double* %l7
  %t458 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t459 = load double, double* %l9
  %t460 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t461 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t462 = load double, double* %l12
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t464 = load double, double* %l14
  %t465 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t466 = load i8*, i8** %l19
  %t467 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t468 = load i8*, i8** %l21
  %t469 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t470 = load i8*, i8** %l23
  %t471 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t472 = load i8*, i8** %l25
  %t473 = load %LoopContext, %LoopContext* %l26
  %t474 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t475 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t477 = load double, double* %l30
  %t478 = load i8*, i8** %l31
  %t479 = load double, double* %l32
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t483 = load double, double* %l36
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t485 = load double, double* %l41
  %t486 = load double, double* %l44
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t488 = load double, double* %l48
  %t489 = load i1, i1* %l49
  br label %loop.header22
loop.header22:
  %t566 = phi { i8**, i64 }* [ %t487, %entry ], [ %t563, %loop.latch24 ]
  %t567 = phi i1 [ %t489, %entry ], [ %t564, %loop.latch24 ]
  %t568 = phi double [ %t488, %entry ], [ %t565, %loop.latch24 ]
  store { i8**, i64 }* %t566, { i8**, i64 }** %l47
  store i1 %t567, i1* %l49
  store double %t568, double* %l48
  br label %loop.body23
loop.body23:
  %t490 = load double, double* %l48
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t493 = load double, double* %l48
  %t494 = load { i8**, i64 }, { i8**, i64 }* %t492
  %t495 = extractvalue { i8**, i64 } %t494, 0
  %t496 = extractvalue { i8**, i64 } %t494, 1
  %t497 = icmp uge i64 %t493, %t496
  ; bounds check: %t497 (if true, out of bounds)
  %t498 = getelementptr i8*, i8** %t495, i64 %t493
  %t499 = load i8*, i8** %t498
  store i8* %t499, i8** %l50
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t501 = load i8*, i8** %l50
  %t502 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t500, i8* %t501)
  store { i8**, i64 }* %t502, { i8**, i64 }** %l47
  %t504 = load i1, i1* %l49
  br label %logical_and_entry_503

logical_and_entry_503:
  br i1 %t504, label %logical_and_right_503, label %logical_and_merge_503

logical_and_right_503:
  %t505 = load i8*, i8** %l50
  %t506 = load i8*, i8** %l19
  %s507 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.507, i32 0, i32 0
  %t508 = add i8* %t506, %s507
  %t509 = icmp eq i8* %t505, %t508
  br label %logical_and_right_end_503

logical_and_right_end_503:
  br label %logical_and_merge_503

logical_and_merge_503:
  %t510 = phi i1 [ false, %logical_and_entry_503 ], [ %t509, %logical_and_right_end_503 ]
  %t511 = xor i1 %t510, 1
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t515 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t516 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l4
  %t517 = load double, double* %l5
  %t518 = load double, double* %l6
  %t519 = load double, double* %l7
  %t520 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l8
  %t521 = load double, double* %l9
  %t522 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l10
  %t523 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l11
  %t524 = load double, double* %l12
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t526 = load double, double* %l14
  %t527 = load %BlockLabelResult, %BlockLabelResult* %l18
  %t528 = load i8*, i8** %l19
  %t529 = load %BlockLabelResult, %BlockLabelResult* %l20
  %t530 = load i8*, i8** %l21
  %t531 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t532 = load i8*, i8** %l23
  %t533 = load %BlockLabelResult, %BlockLabelResult* %l24
  %t534 = load i8*, i8** %l25
  %t535 = load %LoopContext, %LoopContext* %l26
  %t536 = load { %LoopContext*, i64 }*, { %LoopContext*, i64 }** %l27
  %t537 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l29
  %t539 = load double, double* %l30
  %t540 = load i8*, i8** %l31
  %t541 = load double, double* %l32
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l35
  %t545 = load double, double* %l36
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l40
  %t547 = load double, double* %l41
  %t548 = load double, double* %l44
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t550 = load double, double* %l48
  %t551 = load i1, i1* %l49
  %t552 = load i8*, i8** %l50
  br i1 %t511, label %then26, label %merge27
then26:
  store i1 1, i1* %l49
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l33
  %t554 = call double @final_linesconcat({ i8**, i64 }* %t553)
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l34
  %t556 = call double @final_linesconcat({ i8**, i64 }* %t555)
  store { i8**, i64 }* null, { i8**, i64 }** %l47
  br label %merge27
merge27:
  %t557 = phi i1 [ 1, %then26 ], [ %t551, %loop.body23 ]
  %t558 = phi { i8**, i64 }* [ null, %then26 ], [ %t549, %loop.body23 ]
  %t559 = phi { i8**, i64 }* [ null, %then26 ], [ %t549, %loop.body23 ]
  store i1 %t557, i1* %l49
  store { i8**, i64 }* %t558, { i8**, i64 }** %l47
  store { i8**, i64 }* %t559, { i8**, i64 }** %l47
  %t560 = load double, double* %l48
  %t561 = sitofp i64 1 to double
  %t562 = fadd double %t560, %t561
  store double %t562, double* %l48
  br label %loop.latch24
loop.latch24:
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l47
  %t564 = load i1, i1* %l49
  %t565 = load double, double* %l48
  br label %loop.header22
afterloop25:
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l47
  store { i8**, i64 }* %t569, { i8**, i64 }** %l1
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t571 = load i8*, i8** %l25
  %s572 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.572, i32 0, i32 0
  %t573 = add i8* %t571, %s572
  %t574 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t570, i8* %t573)
  store { i8**, i64 }* %t574, { i8**, i64 }** %l1
  %t575 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l28
  store { %LocalBinding*, i64 }* %t575, { %LocalBinding*, i64 }** %l3
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
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t16 = load i8*, i8** %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  %t19 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t79 = phi { i8**, i64 }* [ %t14, %entry ], [ %t76, %loop.latch2 ]
  %t80 = phi { %MatchCaseStructure*, i64 }* [ %t15, %entry ], [ %t77, %loop.latch2 ]
  %t81 = phi double [ %t17, %entry ], [ %t78, %loop.latch2 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l0
  store { %MatchCaseStructure*, i64 }* %t80, { %MatchCaseStructure*, i64 }** %l1
  store double %t81, double* %l3
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l3
  %t21 = load double, double* %l5
  %t22 = fcmp oge double %t20, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t25 = load i8*, i8** %l2
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
  %t35 = load i8*, i8** %l2
  %t36 = icmp ne i8* %t35, null
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t39 = load i8*, i8** %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  %t42 = load double, double* %l5
  br i1 %t36, label %then6, label %merge7
then6:
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l5
  %t45 = call %MatchCaseStructure @finalize_match_case(i8* %t43, double %t44)
  store %MatchCaseStructure %t45, %MatchCaseStructure* %l6
  %t46 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t47 = load %MatchCaseStructure, %MatchCaseStructure* %l6
  %t48 = call { %MatchCaseStructure*, i64 }* @append_match_case({ %MatchCaseStructure*, i64 }* %t46, %MatchCaseStructure %t47)
  store { %MatchCaseStructure*, i64 }* %t48, { %MatchCaseStructure*, i64 }** %l1
  br label %merge7
merge7:
  %t49 = phi { %MatchCaseStructure*, i64 }* [ %t48, %then6 ], [ %t38, %then4 ]
  store { %MatchCaseStructure*, i64 }* %t49, { %MatchCaseStructure*, i64 }** %l1
  ret %MatchStructure zeroinitializer
merge5:
  %t50 = load double, double* %l3
  %t51 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  store i8* %t56, i8** %l7
  %t57 = load i8*, i8** %l7
  %t58 = load i8*, i8** %l7
  %t59 = load double, double* %l4
  %t60 = sitofp i64 0 to double
  %t61 = fcmp ogt double %t59, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t64 = load i8*, i8** %l2
  %t65 = load double, double* %l3
  %t66 = load double, double* %l4
  %t67 = load double, double* %l5
  %t68 = load i8*, i8** %l7
  br i1 %t61, label %then8, label %merge9
then8:
  %t69 = load double, double* %l3
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l3
  br label %loop.latch2
merge9:
  %t72 = load i8*, i8** %l7
  %t73 = load double, double* %l3
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l3
  br label %loop.latch2
loop.latch2:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load { %MatchCaseStructure*, i64 }*, { %MatchCaseStructure*, i64 }** %l1
  %t78 = load double, double* %l3
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
  %t173 = phi double [ %t112, %entry ], [ %t169, %loop.latch6 ]
  %t174 = phi { i8**, i64 }* [ %t109, %entry ], [ %t170, %loop.latch6 ]
  %t175 = phi { i8**, i64 }* [ %t130, %entry ], [ %t171, %loop.latch6 ]
  %t176 = phi double [ %t131, %entry ], [ %t172, %loop.latch6 ]
  store double %t173, double* %l4
  store { i8**, i64 }* %t174, { i8**, i64 }** %l1
  store { i8**, i64 }* %t175, { i8**, i64 }** %l24
  store double %t176, double* %l25
  br label %loop.body5
loop.body5:
  %t132 = load double, double* %l25
  %t133 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t134 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t135 = load double, double* %l25
  %t136 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t134
  %t137 = extractvalue { %LocalBinding*, i64 } %t136, 0
  %t138 = extractvalue { %LocalBinding*, i64 } %t136, 1
  %t139 = icmp uge i64 %t135, %t138
  ; bounds check: %t139 (if true, out of bounds)
  %t140 = getelementptr %LocalBinding, %LocalBinding* %t137, i64 %t135
  %t141 = load %LocalBinding, %LocalBinding* %t140
  store %LocalBinding %t141, %LocalBinding* %l26
  %t142 = load double, double* %l4
  %t143 = call i8* @format_temp_name(double %t142)
  store i8* %t143, i8** %l27
  %t144 = load double, double* %l4
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l4
  %s147 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.147, i32 0, i32 0
  %t148 = load i8*, i8** %l27
  %t149 = add i8* %s147, %t148
  %s150 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.150, i32 0, i32 0
  %t151 = add i8* %t149, %s150
  %t152 = load %LocalBinding, %LocalBinding* %l26
  %t153 = extractvalue %LocalBinding %t152, 2
  %t154 = add i8* %t151, %t153
  %s155 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.155, i32 0, i32 0
  %t156 = add i8* %t154, %s155
  %t157 = load %LocalBinding, %LocalBinding* %l26
  %t158 = extractvalue %LocalBinding %t157, 2
  %t159 = add i8* %t156, %t158
  store double 0.0, double* %l28
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load double, double* %l28
  %t162 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t160, i8* null)
  store { i8**, i64 }* %t162, { i8**, i64 }** %l1
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t164 = load i8*, i8** %l27
  %t165 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t163, i8* %t164)
  store { i8**, i64 }* %t165, { i8**, i64 }** %l24
  %t166 = load double, double* %l25
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l25
  br label %loop.latch6
loop.latch6:
  %t169 = load double, double* %l4
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t172 = load double, double* %l25
  br label %loop.header4
afterloop7:
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s178 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.178, i32 0, i32 0
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t180 = load { i8**, i64 }, { i8**, i64 }* %t179
  %t181 = extractvalue { i8**, i64 } %t180, 0
  %t182 = extractvalue { i8**, i64 } %t180, 1
  %t183 = icmp uge i64 0, %t182
  ; bounds check: %t183 (if true, out of bounds)
  %t184 = getelementptr i8*, i8** %t181, i64 0
  %t185 = load i8*, i8** %t184
  %t186 = add i8* %s178, %t185
  %t187 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t177, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l1
  store i1 1, i1* %l29
  store i1 0, i1* %l30
  %t188 = alloca [0 x double]
  %t189 = getelementptr [0 x double], [0 x double]* %t188, i32 0, i32 0
  %t190 = alloca { double*, i64 }
  %t191 = getelementptr { double*, i64 }, { double*, i64 }* %t190, i32 0, i32 0
  store double* %t189, double** %t191
  %t192 = getelementptr { double*, i64 }, { double*, i64 }* %t190, i32 0, i32 1
  store i64 0, i64* %t192
  store { %MatchArmMutations*, i64 }* null, { %MatchArmMutations*, i64 }** %l31
  %t193 = sitofp i64 0 to double
  store double %t193, double* %l19
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t197 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t198 = load double, double* %l4
  %t199 = load double, double* %l5
  %t200 = load double, double* %l6
  %t201 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t202 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t203 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t204 = load double, double* %l10
  %t205 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t206 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t207 = load double, double* %l13
  %t208 = load double, double* %l14
  %t209 = load double, double* %l15
  %t210 = load double, double* %l16
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t213 = load double, double* %l19
  %t214 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t215 = load i8*, i8** %l23
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t217 = load double, double* %l25
  %t218 = load i1, i1* %l29
  %t219 = load i1, i1* %l30
  %t220 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  br label %loop.header8
loop.header8:
  %t295 = phi { i8**, i64 }* [ %t195, %entry ], [ %t282, %loop.latch10 ]
  %t296 = phi { i8**, i64 }* [ %t194, %entry ], [ %t283, %loop.latch10 ]
  %t297 = phi double [ %t198, %entry ], [ %t284, %loop.latch10 ]
  %t298 = phi { %StringConstant*, i64 }* [ %t206, %entry ], [ %t285, %loop.latch10 ]
  %t299 = phi { %LifetimeRegionMetadata*, i64 }* [ %t203, %entry ], [ %t286, %loop.latch10 ]
  %t300 = phi { i8**, i64 }* [ %t196, %entry ], [ %t287, %loop.latch10 ]
  %t301 = phi { %LocalBinding*, i64 }* [ %t197, %entry ], [ %t288, %loop.latch10 ]
  %t302 = phi double [ %t199, %entry ], [ %t289, %loop.latch10 ]
  %t303 = phi double [ %t200, %entry ], [ %t290, %loop.latch10 ]
  %t304 = phi double [ %t204, %entry ], [ %t291, %loop.latch10 ]
  %t305 = phi { %LocalMutation*, i64 }* [ %t205, %entry ], [ %t292, %loop.latch10 ]
  %t306 = phi { %MatchArmMutations*, i64 }* [ %t220, %entry ], [ %t293, %loop.latch10 ]
  %t307 = phi double [ %t213, %entry ], [ %t294, %loop.latch10 ]
  store { i8**, i64 }* %t295, { i8**, i64 }** %l1
  store { i8**, i64 }* %t296, { i8**, i64 }** %l0
  store double %t297, double* %l4
  store { %StringConstant*, i64 }* %t298, { %StringConstant*, i64 }** %l12
  store { %LifetimeRegionMetadata*, i64 }* %t299, { %LifetimeRegionMetadata*, i64 }** %l9
  store { i8**, i64 }* %t300, { i8**, i64 }** %l2
  store { %LocalBinding*, i64 }* %t301, { %LocalBinding*, i64 }** %l3
  store double %t302, double* %l5
  store double %t303, double* %l6
  store double %t304, double* %l10
  store { %LocalMutation*, i64 }* %t305, { %LocalMutation*, i64 }** %l11
  store { %MatchArmMutations*, i64 }* %t306, { %MatchArmMutations*, i64 }** %l31
  store double %t307, double* %l19
  br label %loop.body9
loop.body9:
  %t221 = load double, double* %l19
  %t222 = load double, double* %l13
  %t223 = load double, double* %l13
  store double 0.0, double* %l32
  %t224 = load i8*, i8** %l23
  store i8* %t224, i8** %l33
  %t225 = load double, double* %l19
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  %t228 = load double, double* %l13
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t231 = load double, double* %l19
  %t232 = load { i8**, i64 }, { i8**, i64 }* %t230
  %t233 = extractvalue { i8**, i64 } %t232, 0
  %t234 = extractvalue { i8**, i64 } %t232, 1
  %t235 = icmp uge i64 %t231, %t234
  ; bounds check: %t235 (if true, out of bounds)
  %t236 = getelementptr i8*, i8** %t233, i64 %t231
  %t237 = load i8*, i8** %t236
  %s238 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.238, i32 0, i32 0
  %t239 = add i8* %t237, %s238
  %t240 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t229, i8* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l1
  store double 0.0, double* %l34
  %t241 = load double, double* %l34
  %t242 = load double, double* %l34
  %t243 = load double, double* %l34
  %t244 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t245 = load double, double* %l34
  %t246 = load double, double* %l34
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t249 = load double, double* %l19
  %t250 = load { i8**, i64 }, { i8**, i64 }* %t248
  %t251 = extractvalue { i8**, i64 } %t250, 0
  %t252 = extractvalue { i8**, i64 } %t250, 1
  %t253 = icmp uge i64 %t249, %t252
  ; bounds check: %t253 (if true, out of bounds)
  %t254 = getelementptr i8*, i8** %t251, i64 %t249
  %t255 = load i8*, i8** %t254
  %s256 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.256, i32 0, i32 0
  %t257 = add i8* %t255, %s256
  %t258 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t247, i8* %t257)
  store { i8**, i64 }* %t258, { i8**, i64 }** %l1
  %t259 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  store { %LocalBinding*, i64 }* %t259, { %LocalBinding*, i64 }** %l35
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l2
  store { i8**, i64 }* %t260, { i8**, i64 }** %l36
  %t261 = load double, double* %l6
  store double %t261, double* %l37
  %t265 = load double, double* %l34
  store double 0.0, double* %l38
  %t266 = load double, double* %l38
  %t267 = load double, double* %l38
  %t268 = load double, double* %l38
  %t269 = load double, double* %l38
  %t270 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l35
  store { %LocalBinding*, i64 }* %t270, { %LocalBinding*, i64 }** %l3
  %t271 = load double, double* %l38
  %t272 = load double, double* %l38
  %t273 = load double, double* %l38
  %t274 = load double, double* %l38
  %t275 = load double, double* %l38
  %t276 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t277 = load double, double* %l38
  %t278 = load double, double* %l38
  %t279 = load double, double* %l19
  %t280 = sitofp i64 1 to double
  %t281 = fadd double %t279, %t280
  store double %t281, double* %l19
  br label %loop.latch10
loop.latch10:
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t284 = load double, double* %l4
  %t285 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t286 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t288 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t289 = load double, double* %l5
  %t290 = load double, double* %l6
  %t291 = load double, double* %l10
  %t292 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t293 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  %t294 = load double, double* %l19
  br label %loop.header8
afterloop11:
  %t309 = load i1, i1* %l29
  br label %logical_and_entry_308

logical_and_entry_308:
  br i1 %t309, label %logical_and_right_308, label %logical_and_merge_308

logical_and_right_308:
  %t310 = load i1, i1* %l30
  br label %logical_and_right_end_308

logical_and_right_end_308:
  br label %logical_and_merge_308

logical_and_merge_308:
  %t311 = phi i1 [ false, %logical_and_entry_308 ], [ %t310, %logical_and_right_end_308 ]
  store i1 %t311, i1* %l39
  %t312 = load i1, i1* %l39
  %t313 = xor i1 %t312, 1
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t317 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l3
  %t318 = load double, double* %l4
  %t319 = load double, double* %l5
  %t320 = load double, double* %l6
  %t321 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t322 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t323 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l9
  %t324 = load double, double* %l10
  %t325 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l11
  %t326 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l12
  %t327 = load double, double* %l13
  %t328 = load double, double* %l14
  %t329 = load double, double* %l15
  %t330 = load double, double* %l16
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t333 = load double, double* %l19
  %t334 = load %BlockLabelResult, %BlockLabelResult* %l22
  %t335 = load i8*, i8** %l23
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t337 = load double, double* %l25
  %t338 = load i1, i1* %l29
  %t339 = load i1, i1* %l30
  %t340 = load { %MatchArmMutations*, i64 }*, { %MatchArmMutations*, i64 }** %l31
  %t341 = load i1, i1* %l39
  br i1 %t313, label %then12, label %merge13
then12:
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t343 = load i8*, i8** %l23
  %s344 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.344, i32 0, i32 0
  %t345 = add i8* %t343, %s344
  %t346 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t342, i8* %t345)
  store { i8**, i64 }* %t346, { i8**, i64 }** %l1
  store double 0.0, double* %l40
  %t347 = load double, double* %l40
  %t348 = load double, double* %l40
  br label %merge13
merge13:
  %t349 = phi { i8**, i64 }* [ %t346, %then12 ], [ %t315, %entry ]
  %t350 = phi { i8**, i64 }* [ null, %then12 ], [ %t315, %entry ]
  %t351 = phi double [ 0.0, %then12 ], [ %t318, %entry ]
  store { i8**, i64 }* %t349, { i8**, i64 }** %l1
  store { i8**, i64 }* %t350, { i8**, i64 }** %l1
  store double %t351, double* %l4
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
  %t64 = phi { i8**, i64 }* [ %t6, %entry ], [ %t62, %loop.latch2 ]
  %t65 = phi double [ %t7, %entry ], [ %t63, %loop.latch2 ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  store double %t65, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %LocalMutation*, i64 }, { %LocalMutation*, i64 }* %mutations
  %t11 = extractvalue { %LocalMutation*, i64 } %t10, 0
  %t12 = extractvalue { %LocalMutation*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %LocalMutation, %LocalMutation* %t11, i64 %t9
  %t15 = load %LocalMutation, %LocalMutation* %t14
  store %LocalMutation %t15, %LocalMutation* %l2
  store i1 0, i1* %l3
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load %LocalMutation, %LocalMutation* %l2
  %t20 = load i1, i1* %l3
  %t21 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t45 = phi i1 [ %t20, %loop.body1 ], [ %t43, %loop.latch6 ]
  %t46 = phi double [ %t21, %loop.body1 ], [ %t44, %loop.latch6 ]
  store i1 %t45, i1* %l3
  store double %t46, double* %l4
  br label %loop.body5
loop.body5:
  %t22 = load double, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l4
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = load %LocalMutation, %LocalMutation* %l2
  %t33 = extractvalue %LocalMutation %t32, 0
  %t34 = icmp eq i8* %t31, %t33
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load %LocalMutation, %LocalMutation* %l2
  %t38 = load i1, i1* %l3
  %t39 = load double, double* %l4
  br i1 %t34, label %then8, label %merge9
then8:
  store i1 1, i1* %l3
  br label %afterloop7
merge9:
  %t40 = load double, double* %l4
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l4
  br label %loop.latch6
loop.latch6:
  %t43 = load i1, i1* %l3
  %t44 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t47 = load i1, i1* %l3
  %t48 = xor i1 %t47, 1
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load %LocalMutation, %LocalMutation* %l2
  %t52 = load i1, i1* %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then10, label %merge11
then10:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load %LocalMutation, %LocalMutation* %l2
  %t56 = extractvalue %LocalMutation %t55, 0
  %t57 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t54, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t58 = phi { i8**, i64 }* [ %t57, %then10 ], [ %t49, %loop.body1 ]
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l1
  br label %loop.latch2
loop.latch2:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t66
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
  %t27 = phi i8* [ %t2, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t3, %entry ], [ %t26, %loop.latch2 ]
  store i8* %t27, i8** %l0
  store double %t28, double* %l1
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
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %strings
  %t16 = extractvalue { i8**, i64 } %t15, 0
  %t17 = extractvalue { i8**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr i8*, i8** %t16, i64 %t14
  %t20 = load i8*, i8** %t19
  %t21 = add i8* %t13, %t20
  store i8* %t21, i8** %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l0
  ret i8* %t29
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
  %t31 = phi double [ %t14, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l3
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  %t17 = load { %LocalMutation*, i64 }, { %LocalMutation*, i64 }* %mutations
  %t18 = extractvalue { %LocalMutation*, i64 } %t17, 0
  %t19 = extractvalue { %LocalMutation*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %LocalMutation, %LocalMutation* %t18, i64 %t16
  %t22 = load %LocalMutation, %LocalMutation* %t21
  store %LocalMutation %t22, %LocalMutation* %l4
  %t23 = load %LocalMutation, %LocalMutation* %l4
  %t24 = extractvalue %LocalMutation %t23, 0
  %t25 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t24)
  store double %t25, double* %l5
  %t26 = load double, double* %l5
  %t27 = load double, double* %l3
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l3
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l3
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l6
  %t32 = load double, double* %l6
  %t33 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t34 = load double, double* %l2
  %t35 = insertvalue %PhiMergeResult %t33, double %t34, 1
  ret %PhiMergeResult %t35
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
  %t92 = phi { i8**, i64 }* [ %t19, %entry ], [ %t90, %loop.latch2 ]
  %t93 = phi double [ %t20, %entry ], [ %t91, %loop.latch2 ]
  store { i8**, i64 }* %t92, { i8**, i64 }** %l5
  store double %t93, double* %l6
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l6
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t24 = load double, double* %l6
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  store i8* %t30, i8** %l7
  store i1 0, i1* %l8
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l9
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load double, double* %l2
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t38 = load double, double* %l6
  %t39 = load i8*, i8** %l7
  %t40 = load i1, i1* %l8
  %t41 = load double, double* %l9
  br label %loop.header4
loop.header4:
  %t69 = phi i1 [ %t40, %loop.body1 ], [ %t67, %loop.latch6 ]
  %t70 = phi double [ %t41, %loop.body1 ], [ %t68, %loop.latch6 ]
  store i1 %t69, i1* %l8
  store double %t70, double* %l9
  br label %loop.body5
loop.body5:
  %t42 = load double, double* %l9
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t45 = load double, double* %l9
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t47 = extractvalue { i8**, i64 } %t46, 0
  %t48 = extractvalue { i8**, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr i8*, i8** %t47, i64 %t45
  %t51 = load i8*, i8** %t50
  %t52 = load i8*, i8** %l7
  %t53 = icmp eq i8* %t51, %t52
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load double, double* %l2
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t60 = load double, double* %l6
  %t61 = load i8*, i8** %l7
  %t62 = load i1, i1* %l8
  %t63 = load double, double* %l9
  br i1 %t53, label %then8, label %merge9
then8:
  store i1 1, i1* %l8
  br label %afterloop7
merge9:
  %t64 = load double, double* %l9
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l9
  br label %loop.latch6
loop.latch6:
  %t67 = load i1, i1* %l8
  %t68 = load double, double* %l9
  br label %loop.header4
afterloop7:
  %t71 = load i1, i1* %l8
  %t72 = xor i1 %t71, 1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load double, double* %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t79 = load double, double* %l6
  %t80 = load i8*, i8** %l7
  %t81 = load i1, i1* %l8
  %t82 = load double, double* %l9
  br i1 %t72, label %then10, label %merge11
then10:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t84 = load i8*, i8** %l7
  %t85 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t83, i8* %t84)
  store { i8**, i64 }* %t85, { i8**, i64 }** %l5
  br label %merge11
merge11:
  %t86 = phi { i8**, i64 }* [ %t85, %then10 ], [ %t78, %loop.body1 ]
  store { i8**, i64 }* %t86, { i8**, i64 }** %l5
  %t87 = load double, double* %l6
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l6
  br label %loop.latch2
loop.latch2:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t91 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t94 = sitofp i64 0 to double
  store double %t94, double* %l10
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t97 = load double, double* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t101 = load double, double* %l6
  %t102 = load double, double* %l10
  br label %loop.header12
loop.header12:
  %t120 = phi double [ %t102, %entry ], [ %t119, %loop.latch14 ]
  store double %t120, double* %l10
  br label %loop.body13
loop.body13:
  %t103 = load double, double* %l10
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t106 = load double, double* %l10
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t105
  %t108 = extractvalue { i8**, i64 } %t107, 0
  %t109 = extractvalue { i8**, i64 } %t107, 1
  %t110 = icmp uge i64 %t106, %t109
  ; bounds check: %t110 (if true, out of bounds)
  %t111 = getelementptr i8*, i8** %t108, i64 %t106
  %t112 = load i8*, i8** %t111
  store i8* %t112, i8** %l11
  %t113 = load i8*, i8** %l11
  %t114 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t113)
  store double %t114, double* %l12
  %t115 = load double, double* %l12
  %t116 = load double, double* %l10
  %t117 = sitofp i64 1 to double
  %t118 = fadd double %t116, %t117
  store double %t118, double* %l10
  br label %loop.latch14
loop.latch14:
  %t119 = load double, double* %l10
  br label %loop.header12
afterloop15:
  store double 0.0, double* %l13
  %t121 = load double, double* %l13
  %t122 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t123 = load double, double* %l2
  %t124 = insertvalue %PhiMergeResult %t122, double %t123, 1
  ret %PhiMergeResult %t124
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
  %t122 = phi { i8**, i64 }* [ %t19, %entry ], [ %t120, %loop.latch2 ]
  %t123 = phi double [ %t20, %entry ], [ %t121, %loop.latch2 ]
  store { i8**, i64 }* %t122, { i8**, i64 }** %l3
  store double %t123, double* %l4
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l4
  %t22 = load double, double* %l4
  %t23 = load { %MatchArmMutations*, i64 }, { %MatchArmMutations*, i64 }* %arm_mutations_list
  %t24 = extractvalue { %MatchArmMutations*, i64 } %t23, 0
  %t25 = extractvalue { %MatchArmMutations*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr %MatchArmMutations, %MatchArmMutations* %t24, i64 %t22
  %t28 = load %MatchArmMutations, %MatchArmMutations* %t27
  store %MatchArmMutations %t28, %MatchArmMutations* %l5
  %t29 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t30 = extractvalue %MatchArmMutations %t29, 0
  %t31 = call { i8**, i64 }* @collect_mutation_names({ %LocalMutation*, i64 }* null)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l6
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l7
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t37 = load double, double* %l4
  %t38 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t40 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t115 = phi { i8**, i64 }* [ %t36, %loop.body1 ], [ %t113, %loop.latch6 ]
  %t116 = phi double [ %t40, %loop.body1 ], [ %t114, %loop.latch6 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l3
  store double %t116, double* %l7
  br label %loop.body5
loop.body5:
  %t41 = load double, double* %l7
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t44 = load double, double* %l7
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr i8*, i8** %t46, i64 %t44
  %t50 = load i8*, i8** %t49
  store i8* %t50, i8** %l8
  store i1 0, i1* %l9
  %t51 = sitofp i64 0 to double
  store double %t51, double* %l10
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l2
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load double, double* %l4
  %t57 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t59 = load double, double* %l7
  %t60 = load i8*, i8** %l8
  %t61 = load i1, i1* %l9
  %t62 = load double, double* %l10
  br label %loop.header8
loop.header8:
  %t91 = phi i1 [ %t61, %loop.body5 ], [ %t89, %loop.latch10 ]
  %t92 = phi double [ %t62, %loop.body5 ], [ %t90, %loop.latch10 ]
  store i1 %t91, i1* %l9
  store double %t92, double* %l10
  br label %loop.body9
loop.body9:
  %t63 = load double, double* %l10
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t66 = load double, double* %l10
  %t67 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t68 = extractvalue { i8**, i64 } %t67, 0
  %t69 = extractvalue { i8**, i64 } %t67, 1
  %t70 = icmp uge i64 %t66, %t69
  ; bounds check: %t70 (if true, out of bounds)
  %t71 = getelementptr i8*, i8** %t68, i64 %t66
  %t72 = load i8*, i8** %t71
  %t73 = load i8*, i8** %l8
  %t74 = icmp eq i8* %t72, %t73
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load double, double* %l2
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t79 = load double, double* %l4
  %t80 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t82 = load double, double* %l7
  %t83 = load i8*, i8** %l8
  %t84 = load i1, i1* %l9
  %t85 = load double, double* %l10
  br i1 %t74, label %then12, label %merge13
then12:
  store i1 1, i1* %l9
  br label %afterloop11
merge13:
  %t86 = load double, double* %l10
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l10
  br label %loop.latch10
loop.latch10:
  %t89 = load i1, i1* %l9
  %t90 = load double, double* %l10
  br label %loop.header8
afterloop11:
  %t93 = load i1, i1* %l9
  %t94 = xor i1 %t93, 1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t97 = load double, double* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t99 = load double, double* %l4
  %t100 = load %MatchArmMutations, %MatchArmMutations* %l5
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t102 = load double, double* %l7
  %t103 = load i8*, i8** %l8
  %t104 = load i1, i1* %l9
  %t105 = load double, double* %l10
  br i1 %t94, label %then14, label %merge15
then14:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load i8*, i8** %l8
  %t108 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t106, i8* %t107)
  store { i8**, i64 }* %t108, { i8**, i64 }** %l3
  br label %merge15
merge15:
  %t109 = phi { i8**, i64 }* [ %t108, %then14 ], [ %t98, %loop.body5 ]
  store { i8**, i64 }* %t109, { i8**, i64 }** %l3
  %t110 = load double, double* %l7
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l7
  br label %loop.latch6
loop.latch6:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t114 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t117 = load double, double* %l4
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  store double %t119, double* %l4
  br label %loop.latch2
loop.latch2:
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t121 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t124 = sitofp i64 0 to double
  store double %t124, double* %l11
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load double, double* %l2
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t129 = load double, double* %l4
  %t130 = load double, double* %l11
  br label %loop.header16
loop.header16:
  %t148 = phi double [ %t130, %entry ], [ %t147, %loop.latch18 ]
  store double %t148, double* %l11
  br label %loop.body17
loop.body17:
  %t131 = load double, double* %l11
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t134 = load double, double* %l11
  %t135 = load { i8**, i64 }, { i8**, i64 }* %t133
  %t136 = extractvalue { i8**, i64 } %t135, 0
  %t137 = extractvalue { i8**, i64 } %t135, 1
  %t138 = icmp uge i64 %t134, %t137
  ; bounds check: %t138 (if true, out of bounds)
  %t139 = getelementptr i8*, i8** %t136, i64 %t134
  %t140 = load i8*, i8** %t139
  store i8* %t140, i8** %l12
  %t141 = load i8*, i8** %l12
  %t142 = call double @find_local_binding({ %LocalBinding*, i64 }* %locals, i8* %t141)
  store double %t142, double* %l13
  %t143 = load double, double* %l13
  %t144 = load double, double* %l11
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l11
  br label %loop.latch18
loop.latch18:
  %t147 = load double, double* %l11
  br label %loop.header16
afterloop19:
  store double 0.0, double* %l14
  %t149 = load double, double* %l14
  %t150 = insertvalue %PhiMergeResult undef, { i8**, i64 }* null, 0
  %t151 = load double, double* %l2
  %t152 = insertvalue %PhiMergeResult %t150, double %t151, 1
  ret %PhiMergeResult %t152
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
  %t112 = phi double [ %t50, %entry ], [ %t108, %loop.latch2 ]
  %t113 = phi { i8**, i64 }* [ %t47, %entry ], [ %t109, %loop.latch2 ]
  %t114 = phi { i8**, i64 }* [ %t69, %entry ], [ %t110, %loop.latch2 ]
  %t115 = phi double [ %t70, %entry ], [ %t111, %loop.latch2 ]
  store double %t112, double* %l3
  store { i8**, i64 }* %t113, { i8**, i64 }** %l0
  store { i8**, i64 }* %t114, { i8**, i64 }** %l22
  store double %t115, double* %l23
  br label %loop.body1
loop.body1:
  %t71 = load double, double* %l23
  %t72 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t73 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t74 = load double, double* %l23
  %t75 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t73
  %t76 = extractvalue { %LocalBinding*, i64 } %t75, 0
  %t77 = extractvalue { %LocalBinding*, i64 } %t75, 1
  %t78 = icmp uge i64 %t74, %t77
  ; bounds check: %t78 (if true, out of bounds)
  %t79 = getelementptr %LocalBinding, %LocalBinding* %t76, i64 %t74
  %t80 = load %LocalBinding, %LocalBinding* %t79
  store %LocalBinding %t80, %LocalBinding* %l24
  %t81 = load double, double* %l3
  %t82 = call i8* @format_temp_name(double %t81)
  store i8* %t82, i8** %l25
  %t83 = load double, double* %l3
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l3
  %s86 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.86, i32 0, i32 0
  %t87 = load i8*, i8** %l25
  %t88 = add i8* %s86, %t87
  %s89 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.89, i32 0, i32 0
  %t90 = add i8* %t88, %s89
  %t91 = load %LocalBinding, %LocalBinding* %l24
  %t92 = extractvalue %LocalBinding %t91, 2
  %t93 = add i8* %t90, %t92
  %s94 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.94, i32 0, i32 0
  %t95 = add i8* %t93, %s94
  %t96 = load %LocalBinding, %LocalBinding* %l24
  %t97 = extractvalue %LocalBinding %t96, 2
  %t98 = add i8* %t95, %t97
  store double 0.0, double* %l26
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load double, double* %l26
  %t101 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t99, i8* null)
  store { i8**, i64 }* %t101, { i8**, i64 }** %l0
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t103 = load i8*, i8** %l25
  %t104 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t102, i8* %t103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l22
  %t105 = load double, double* %l23
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l23
  br label %loop.latch2
loop.latch2:
  %t108 = load double, double* %l3
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t111 = load double, double* %l23
  br label %loop.header0
afterloop3:
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s117 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.117, i32 0, i32 0
  %t118 = load double, double* %l14
  %t119 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  store { %LocalBinding*, i64 }* %t119, { %LocalBinding*, i64 }** %l27
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store { i8**, i64 }* %t120, { i8**, i64 }** %l28
  %t121 = load double, double* %l3
  store double %t121, double* %l29
  %t122 = load double, double* %l5
  store double %t122, double* %l30
  %t123 = load double, double* %l4
  store double %t123, double* %l31
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l17
  %s126 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.126, i32 0, i32 0
  %t127 = add i8* %t125, %s126
  %t128 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t124, i8* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l0
  %t129 = load i8*, i8** %l17
  %t130 = call i8* @make_child_scope_id(i8* %scope_id, i8* %t129)
  store i8* %t130, i8** %l32
  store double 0.0, double* %l33
  %t131 = load double, double* %l33
  %t132 = load double, double* %l33
  %t133 = load double, double* %l33
  %t134 = load double, double* %l33
  %t135 = load double, double* %l33
  %t136 = load double, double* %l33
  %t137 = load double, double* %l33
  %t138 = load double, double* %l33
  %t139 = load double, double* %l33
  %t140 = load double, double* %l33
  %t141 = load double, double* %l33
  store double 0.0, double* %l34
  %t142 = load double, double* %l34
  %t143 = call double @collected_mutationsconcat(double %t142)
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l12
  %t144 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t145 = load double, double* %l33
  %t146 = load double, double* %l33
  store double 0.0, double* %l35
  %t147 = load double, double* %l35
  %t148 = fcmp one double %t147, 0.0
  %t149 = xor i1 %t148, 1
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t153 = load double, double* %l3
  %t154 = load double, double* %l4
  %t155 = load double, double* %l5
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t157 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t158 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t159 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l9
  %t160 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l10
  %t161 = load double, double* %l11
  %t162 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l12
  %t163 = load double, double* %l13
  %t164 = load double, double* %l14
  %t165 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t166 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t167 = load i8*, i8** %l17
  %t168 = load i8*, i8** %l18
  %t169 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t170 = load i8*, i8** %l20
  %t171 = load i8*, i8** %l21
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t173 = load double, double* %l23
  %t174 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l28
  %t176 = load double, double* %l29
  %t177 = load double, double* %l30
  %t178 = load double, double* %l31
  %t179 = load i8*, i8** %l32
  %t180 = load double, double* %l33
  %t181 = load double, double* %l34
  %t182 = load double, double* %l35
  br i1 %t149, label %then4, label %merge5
then4:
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s184 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.184, i32 0, i32 0
  %t185 = load i8*, i8** %l20
  %t186 = add i8* %s184, %t185
  %t187 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t183, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l0
  br label %merge5
merge5:
  %t188 = phi { i8**, i64 }* [ %t187, %then4 ], [ %t150, %entry ]
  store { i8**, i64 }* %t188, { i8**, i64 }** %l0
  store i1 0, i1* %l36
  %t189 = alloca [0 x double]
  %t190 = getelementptr [0 x double], [0 x double]* %t189, i32 0, i32 0
  %t191 = alloca { double*, i64 }
  %t192 = getelementptr { double*, i64 }, { double*, i64 }* %t191, i32 0, i32 0
  store double* %t190, double** %t192
  %t193 = getelementptr { double*, i64 }, { double*, i64 }* %t191, i32 0, i32 1
  store i64 0, i64* %t193
  store { %LocalMutation*, i64 }* null, { %LocalMutation*, i64 }** %l37
  %t194 = load double, double* %l13
  store i1 0, i1* %l38
  %t195 = load double, double* %l13
  %t197 = load i1, i1* %l38
  br label %logical_or_entry_196

logical_or_entry_196:
  br i1 %t197, label %logical_or_merge_196, label %logical_or_right_196

logical_or_right_196:
  %t198 = load double, double* %l13
  %t199 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  store { %LocalBinding*, i64 }* %t199, { %LocalBinding*, i64 }** %l2
  %t200 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  store { %ParameterBinding*, i64 }* %t200, { %ParameterBinding*, i64 }** %l39
  %t201 = load double, double* %l35
  %t202 = fcmp one double %t201, 0.0
  %t203 = xor i1 %t202, 1
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t206 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l2
  %t207 = load double, double* %l3
  %t208 = load double, double* %l4
  %t209 = load double, double* %l5
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t211 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l7
  %t212 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t213 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l9
  %t214 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l10
  %t215 = load double, double* %l11
  %t216 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l12
  %t217 = load double, double* %l13
  %t218 = load double, double* %l14
  %t219 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l15
  %t220 = load %BlockLabelResult, %BlockLabelResult* %l16
  %t221 = load i8*, i8** %l17
  %t222 = load i8*, i8** %l18
  %t223 = load %BlockLabelResult, %BlockLabelResult* %l19
  %t224 = load i8*, i8** %l20
  %t225 = load i8*, i8** %l21
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l22
  %t227 = load double, double* %l23
  %t228 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l27
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l28
  %t230 = load double, double* %l29
  %t231 = load double, double* %l30
  %t232 = load double, double* %l31
  %t233 = load i8*, i8** %l32
  %t234 = load double, double* %l33
  %t235 = load double, double* %l34
  %t236 = load double, double* %l35
  %t237 = load i1, i1* %l36
  %t238 = load { %LocalMutation*, i64 }*, { %LocalMutation*, i64 }** %l37
  %t239 = load i1, i1* %l38
  %t240 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l39
  br i1 %t203, label %then6, label %merge7
then6:
  %t241 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l39
  %t242 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l8
  %t243 = call { %ParameterBinding*, i64 }* @merge_parameter_bindings({ %ParameterBinding*, i64 }* %t241, { %ParameterBinding*, i64 }* %t242)
  store { %ParameterBinding*, i64 }* %t243, { %ParameterBinding*, i64 }** %l39
  br label %merge7
merge7:
  %t244 = phi { %ParameterBinding*, i64 }* [ %t243, %then6 ], [ %t240, %entry ]
  store { %ParameterBinding*, i64 }* %t244, { %ParameterBinding*, i64 }** %l39
  %t245 = load double, double* %l13
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
  %t20 = phi double [ %t4, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = extractvalue %TypeContext %context, 1
  %t7 = extractvalue %TypeContext %context, 1
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  ret i8* %s21
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
  %t35 = phi double [ %t7, %entry ], [ %t34, %loop.latch2 ]
  store double %t35, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t11 = extractvalue { %LocalBinding*, i64 } %t10, 0
  %t12 = extractvalue { %LocalBinding*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %LocalBinding, %LocalBinding* %t11, i64 %t9
  %t15 = load %LocalBinding, %LocalBinding* %t14
  store %LocalBinding %t15, %LocalBinding* %l2
  %t17 = load %LocalBinding, %LocalBinding* %l2
  %t18 = extractvalue %LocalBinding %t17, 5
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t18, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %t19 = load %LocalBinding, %LocalBinding* %l2
  %t20 = extractvalue %LocalBinding %t19, 4
  %t21 = icmp ne i8* %t20, null
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t22 = phi i1 [ false, %logical_and_entry_16 ], [ %t21, %logical_and_right_end_16 ]
  %t23 = xor i1 %t22, 1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t23, label %then4, label %merge5
then4:
  %t27 = load %LocalBinding, %LocalBinding* %l2
  %t28 = extractvalue %LocalBinding %t27, 4
  store i8* %t28, i8** %l3
  %t30 = load i8*, i8** %l3
  br label %merge5
merge5:
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l4
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t88 = phi { i8**, i64 }* [ %t37, %entry ], [ %t86, %loop.latch8 ]
  %t89 = phi double [ %t39, %entry ], [ %t87, %loop.latch8 ]
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  store double %t89, double* %l4
  br label %loop.body7
loop.body7:
  %t40 = load double, double* %l4
  %t41 = load double, double* %l4
  %t42 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %bindings
  %t43 = extractvalue { %ParameterBinding*, i64 } %t42, 0
  %t44 = extractvalue { %ParameterBinding*, i64 } %t42, 1
  %t45 = icmp uge i64 %t41, %t44
  ; bounds check: %t45 (if true, out of bounds)
  %t46 = getelementptr %ParameterBinding, %ParameterBinding* %t43, i64 %t41
  %t47 = load %ParameterBinding, %ParameterBinding* %t46
  store %ParameterBinding %t47, %ParameterBinding* %l5
  %t48 = load %ParameterBinding, %ParameterBinding* %l5
  %t49 = extractvalue %ParameterBinding %t48, 4
  %t50 = xor i1 %t49, 1
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l4
  %t54 = load %ParameterBinding, %ParameterBinding* %l5
  br i1 %t50, label %then10, label %merge11
then10:
  %t55 = load %ParameterBinding, %ParameterBinding* %l5
  %t56 = extractvalue %ParameterBinding %t55, 3
  %t57 = call i1 @is_mutable_borrow_annotation(i8* %t56)
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l4
  %t61 = load %ParameterBinding, %ParameterBinding* %l5
  br i1 %t57, label %then12, label %merge13
then12:
  %t62 = load %ParameterBinding, %ParameterBinding* %l5
  %t63 = extractvalue %ParameterBinding %t62, 5
  %t64 = call i8* @format_suspension_location(i8* %keyword, i8* %t63, i8* %suspension_span)
  store i8* %t64, i8** %l6
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s66 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.66, i32 0, i32 0
  %t67 = add i8* %s66, %keyword
  %s68 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.68, i32 0, i32 0
  %t69 = add i8* %t67, %s68
  %t70 = load %ParameterBinding, %ParameterBinding* %l5
  %t71 = extractvalue %ParameterBinding %t70, 0
  %t72 = add i8* %t69, %t71
  %s73 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.73, i32 0, i32 0
  %t74 = add i8* %t72, %s73
  %t75 = add i8* %t74, %function_name
  %s76 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.76, i32 0, i32 0
  %t77 = add i8* %t75, %s76
  %t78 = load i8*, i8** %l6
  %t79 = add i8* %t77, %t78
  %t80 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t65, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  br label %merge13
merge13:
  %t81 = phi { i8**, i64 }* [ %t80, %then12 ], [ %t58, %then10 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t82 = phi { i8**, i64 }* [ %t80, %then10 ], [ %t51, %loop.body7 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l0
  %t83 = load double, double* %l4
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l4
  br label %loop.latch8
loop.latch8:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t90
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
  %t44 = phi { %ParameterBinding*, i64 }* [ %t6, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t7, %entry ], [ %t43, %loop.latch2 ]
  store { %ParameterBinding*, i64 }* %t44, { %ParameterBinding*, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %bindings
  %t11 = extractvalue { %ParameterBinding*, i64 } %t10, 0
  %t12 = extractvalue { %ParameterBinding*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %ParameterBinding, %ParameterBinding* %t11, i64 %t9
  %t15 = load %ParameterBinding, %ParameterBinding* %t14
  store %ParameterBinding %t15, %ParameterBinding* %l2
  %t16 = load %ParameterBinding, %ParameterBinding* %l2
  %t17 = extractvalue %ParameterBinding %t16, 0
  %t18 = icmp eq i8* %t17, %name
  %t19 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load %ParameterBinding, %ParameterBinding* %l2
  br i1 %t18, label %then4, label %else5
then4:
  store double 0.0, double* %l3
  %t22 = load double, double* %l3
  %t23 = alloca [1 x double]
  %t24 = getelementptr [1 x double], [1 x double]* %t23, i32 0, i32 0
  %t25 = getelementptr double, double* %t24, i64 0
  store double %t22, double* %t25
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t24, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  %t29 = call double @resultconcat({ double*, i64 }* %t26)
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l0
  br label %merge6
else5:
  %t30 = load %ParameterBinding, %ParameterBinding* %l2
  %t31 = alloca [1 x %ParameterBinding]
  %t32 = getelementptr [1 x %ParameterBinding], [1 x %ParameterBinding]* %t31, i32 0, i32 0
  %t33 = getelementptr %ParameterBinding, %ParameterBinding* %t32, i64 0
  store %ParameterBinding %t30, %ParameterBinding* %t33
  %t34 = alloca { %ParameterBinding*, i64 }
  %t35 = getelementptr { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %t34, i32 0, i32 0
  store %ParameterBinding* %t32, %ParameterBinding** %t35
  %t36 = getelementptr { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = call double @resultconcat({ %ParameterBinding*, i64 }* %t34)
  store { %ParameterBinding*, i64 }* null, { %ParameterBinding*, i64 }** %l0
  br label %merge6
merge6:
  %t38 = phi { %ParameterBinding*, i64 }* [ null, %then4 ], [ null, %else5 ]
  store { %ParameterBinding*, i64 }* %t38, { %ParameterBinding*, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  ret { %ParameterBinding*, i64 }* %t46
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
  %t44 = phi { %LocalBinding*, i64 }* [ %t6, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t7, %entry ], [ %t43, %loop.latch2 ]
  store { %LocalBinding*, i64 }* %t44, { %LocalBinding*, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t11 = extractvalue { %LocalBinding*, i64 } %t10, 0
  %t12 = extractvalue { %LocalBinding*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %LocalBinding, %LocalBinding* %t11, i64 %t9
  %t15 = load %LocalBinding, %LocalBinding* %t14
  store %LocalBinding %t15, %LocalBinding* %l2
  %t16 = load %LocalBinding, %LocalBinding* %l2
  %t17 = extractvalue %LocalBinding %t16, 0
  %t18 = icmp eq i8* %t17, %name
  %t19 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t18, label %then4, label %else5
then4:
  store double 0.0, double* %l3
  %t22 = load double, double* %l3
  %t23 = alloca [1 x double]
  %t24 = getelementptr [1 x double], [1 x double]* %t23, i32 0, i32 0
  %t25 = getelementptr double, double* %t24, i64 0
  store double %t22, double* %t25
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t24, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  %t29 = call double @resultconcat({ double*, i64 }* %t26)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge6
else5:
  %t30 = load %LocalBinding, %LocalBinding* %l2
  %t31 = alloca [1 x %LocalBinding]
  %t32 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t31, i32 0, i32 0
  %t33 = getelementptr %LocalBinding, %LocalBinding* %t32, i64 0
  store %LocalBinding %t30, %LocalBinding* %t33
  %t34 = alloca { %LocalBinding*, i64 }
  %t35 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t34, i32 0, i32 0
  store %LocalBinding* %t32, %LocalBinding** %t35
  %t36 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = call double @resultconcat({ %LocalBinding*, i64 }* %t34)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge6
merge6:
  %t38 = phi { %LocalBinding*, i64 }* [ null, %then4 ], [ null, %else5 ]
  store { %LocalBinding*, i64 }* %t38, { %LocalBinding*, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t46
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
  %t44 = phi { %LocalBinding*, i64 }* [ %t6, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t7, %entry ], [ %t43, %loop.latch2 ]
  store { %LocalBinding*, i64 }* %t44, { %LocalBinding*, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t11 = extractvalue { %LocalBinding*, i64 } %t10, 0
  %t12 = extractvalue { %LocalBinding*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %LocalBinding, %LocalBinding* %t11, i64 %t9
  %t15 = load %LocalBinding, %LocalBinding* %t14
  store %LocalBinding %t15, %LocalBinding* %l2
  %t16 = load %LocalBinding, %LocalBinding* %l2
  %t17 = extractvalue %LocalBinding %t16, 0
  %t18 = icmp eq i8* %t17, %name
  %t19 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t18, label %then4, label %else5
then4:
  store double 0.0, double* %l3
  %t22 = load double, double* %l3
  %t23 = alloca [1 x double]
  %t24 = getelementptr [1 x double], [1 x double]* %t23, i32 0, i32 0
  %t25 = getelementptr double, double* %t24, i64 0
  store double %t22, double* %t25
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t24, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  %t29 = call double @resultconcat({ double*, i64 }* %t26)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge6
else5:
  %t30 = load %LocalBinding, %LocalBinding* %l2
  %t31 = alloca [1 x %LocalBinding]
  %t32 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t31, i32 0, i32 0
  %t33 = getelementptr %LocalBinding, %LocalBinding* %t32, i64 0
  store %LocalBinding %t30, %LocalBinding* %t33
  %t34 = alloca { %LocalBinding*, i64 }
  %t35 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t34, i32 0, i32 0
  store %LocalBinding* %t32, %LocalBinding** %t35
  %t36 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = call double @resultconcat({ %LocalBinding*, i64 }* %t34)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge6
merge6:
  %t38 = phi { %LocalBinding*, i64 }* [ null, %then4 ], [ null, %else5 ]
  store { %LocalBinding*, i64 }* %t38, { %LocalBinding*, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t46
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
  %t44 = phi { %LocalBinding*, i64 }* [ %t6, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t7, %entry ], [ %t43, %loop.latch2 ]
  store { %LocalBinding*, i64 }* %t44, { %LocalBinding*, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t11 = extractvalue { %LocalBinding*, i64 } %t10, 0
  %t12 = extractvalue { %LocalBinding*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %LocalBinding, %LocalBinding* %t11, i64 %t9
  %t15 = load %LocalBinding, %LocalBinding* %t14
  store %LocalBinding %t15, %LocalBinding* %l2
  %t16 = load %LocalBinding, %LocalBinding* %l2
  %t17 = extractvalue %LocalBinding %t16, 0
  %t18 = icmp eq i8* %t17, %name
  %t19 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load %LocalBinding, %LocalBinding* %l2
  br i1 %t18, label %then4, label %else5
then4:
  store double 0.0, double* %l3
  %t22 = load double, double* %l3
  %t23 = alloca [1 x double]
  %t24 = getelementptr [1 x double], [1 x double]* %t23, i32 0, i32 0
  %t25 = getelementptr double, double* %t24, i64 0
  store double %t22, double* %t25
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t24, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  %t29 = call double @resultconcat({ double*, i64 }* %t26)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge6
else5:
  %t30 = load %LocalBinding, %LocalBinding* %l2
  %t31 = alloca [1 x %LocalBinding]
  %t32 = getelementptr [1 x %LocalBinding], [1 x %LocalBinding]* %t31, i32 0, i32 0
  %t33 = getelementptr %LocalBinding, %LocalBinding* %t32, i64 0
  store %LocalBinding %t30, %LocalBinding* %t33
  %t34 = alloca { %LocalBinding*, i64 }
  %t35 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t34, i32 0, i32 0
  store %LocalBinding* %t32, %LocalBinding** %t35
  %t36 = getelementptr { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = call double @resultconcat({ %LocalBinding*, i64 }* %t34)
  store { %LocalBinding*, i64 }* null, { %LocalBinding*, i64 }** %l0
  br label %merge6
merge6:
  %t38 = phi { %LocalBinding*, i64 }* [ null, %then4 ], [ null, %else5 ]
  store { %LocalBinding*, i64 }* %t38, { %LocalBinding*, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { %LocalBinding*, i64 }*, { %LocalBinding*, i64 }** %l0
  ret { %LocalBinding*, i64 }* %t46
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
  %s15 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.15, i32 0, i32 0
  ret i8* %s15
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
  %t34 = phi double [ %t11, %entry ], [ %t33, %loop.latch4 ]
  store double %t34, double* %l2
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = load { %LocalBinding*, i64 }, { %LocalBinding*, i64 }* %locals
  %t15 = extractvalue { %LocalBinding*, i64 } %t14, 0
  %t16 = extractvalue { %LocalBinding*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %LocalBinding, %LocalBinding* %t15, i64 %t13
  %t19 = load %LocalBinding, %LocalBinding* %t18
  store %LocalBinding %t19, %LocalBinding* %l3
  %t20 = load %LocalBinding, %LocalBinding* %l3
  %t21 = extractvalue %LocalBinding %t20, 4
  %t22 = icmp ne i8* %t21, null
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load double, double* %l2
  %t26 = load %LocalBinding, %LocalBinding* %l3
  br i1 %t22, label %then6, label %merge7
then6:
  %t27 = load %LocalBinding, %LocalBinding* %l3
  %t28 = extractvalue %LocalBinding %t27, 4
  store i8* %t28, i8** %l4
  %t29 = load i8*, i8** %l4
  br label %merge7
merge7:
  %t30 = load double, double* %l2
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l2
  br label %loop.latch4
loop.latch4:
  %t33 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t35
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
  %t116 = phi { i8**, i64 }* [ %t39, %entry ], [ %t110, %loop.latch4 ]
  %t117 = phi { %StringConstant*, i64 }* [ %t40, %entry ], [ %t111, %loop.latch4 ]
  %t118 = phi { i8**, i64 }* [ %t42, %entry ], [ %t112, %loop.latch4 ]
  %t119 = phi double [ %t43, %entry ], [ %t113, %loop.latch4 ]
  %t120 = phi { %LLVMOperand*, i64 }* [ %t44, %entry ], [ %t114, %loop.latch4 ]
  %t121 = phi double [ %t48, %entry ], [ %t115, %loop.latch4 ]
  store { i8**, i64 }* %t116, { i8**, i64 }** %l0
  store { %StringConstant*, i64 }* %t117, { %StringConstant*, i64 }** %l1
  store { i8**, i64 }* %t118, { i8**, i64 }** %l3
  store double %t119, double* %l4
  store { %LLVMOperand*, i64 }* %t120, { %LLVMOperand*, i64 }** %l5
  store double %t121, double* %l11
  br label %loop.body3
loop.body3:
  %t49 = load double, double* %l11
  %t50 = load double, double* %l11
  %t51 = load { i8**, i64 }, { i8**, i64 }* %arguments
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  %t57 = call i8* @trim_text(i8* %t56)
  store i8* %t57, i8** %l12
  %t58 = load i8*, i8** %l12
  %t59 = load i8*, i8** %l12
  %t60 = load double, double* %l4
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = call %ExpressionResult @lower_expression(i8* %t59, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t60, { i8**, i64 }* %t61, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t62, %ExpressionResult* %l13
  %t63 = load %ExpressionResult, %ExpressionResult* %l13
  %t64 = extractvalue %ExpressionResult %t63, 3
  %t65 = call double @diagnosticsconcat({ i8**, i64 }* %t64)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t66 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t67 = load %ExpressionResult, %ExpressionResult* %l13
  %t68 = extractvalue %ExpressionResult %t67, 4
  %t69 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t66, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t69, { %StringConstant*, i64 }** %l1
  %t70 = load %ExpressionResult, %ExpressionResult* %l13
  %t71 = extractvalue %ExpressionResult %t70, 0
  store { i8**, i64 }* %t71, { i8**, i64 }** %l3
  %t72 = load %ExpressionResult, %ExpressionResult* %l13
  %t73 = extractvalue %ExpressionResult %t72, 1
  store double %t73, double* %l4
  %t74 = load %ExpressionResult, %ExpressionResult* %l13
  %t75 = extractvalue %ExpressionResult %t74, 2
  %t76 = icmp ne i8* %t75, null
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t79 = load i8*, i8** %l2
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t81 = load double, double* %l4
  %t82 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t83 = load double, double* %l6
  %t84 = load i8*, i8** %l7
  %t85 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t86 = load double, double* %l11
  %t87 = load i8*, i8** %l12
  %t88 = load %ExpressionResult, %ExpressionResult* %l13
  br i1 %t76, label %then6, label %else7
then6:
  %t89 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t90 = load %ExpressionResult, %ExpressionResult* %l13
  %t91 = extractvalue %ExpressionResult %t90, 2
  %t92 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t89, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t92, { %LLVMOperand*, i64 }** %l5
  br label %merge8
else7:
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s94 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.94, i32 0, i32 0
  %t95 = load double, double* %l11
  %t96 = call i8* @number_to_string(double %t95)
  %t97 = add i8* %s94, %t96
  %s98 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.98, i32 0, i32 0
  %t99 = add i8* %t97, %s98
  %t100 = load i8*, i8** %l2
  %t101 = add i8* %t99, %t100
  %s102 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %t101, %s102
  %t104 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t93, i8* %t103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t105 = phi { %LLVMOperand*, i64 }* [ %t92, %then6 ], [ %t82, %else7 ]
  %t106 = phi { i8**, i64 }* [ %t77, %then6 ], [ %t104, %else7 ]
  store { %LLVMOperand*, i64 }* %t105, { %LLVMOperand*, i64 }** %l5
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load double, double* %l11
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  store double %t109, double* %l11
  br label %loop.latch4
loop.latch4:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t113 = load double, double* %l4
  %t114 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t115 = load double, double* %l11
  br label %loop.header2
afterloop5:
  %t122 = load i8*, i8** %l7
  %t123 = icmp ne i8* %t122, null
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t126 = load i8*, i8** %l2
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t128 = load double, double* %l4
  %t129 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load i8*, i8** %l7
  %t132 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t133 = load double, double* %l11
  br i1 %t123, label %then9, label %merge10
then9:
  %t134 = load i8*, i8** %l7
  store i8* %t134, i8** %l14
  %t135 = alloca [0 x double]
  %t136 = getelementptr [0 x double], [0 x double]* %t135, i32 0, i32 0
  %t137 = alloca { double*, i64 }
  %t138 = getelementptr { double*, i64 }, { double*, i64 }* %t137, i32 0, i32 0
  store double* %t136, double** %t138
  %t139 = getelementptr { double*, i64 }, { double*, i64 }* %t137, i32 0, i32 1
  store i64 0, i64* %t139
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l15
  %t140 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t141 = load i8*, i8** %l14
  %t142 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t140, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t142, { %LLVMOperand*, i64 }** %l15
  %t143 = sitofp i64 0 to double
  store double %t143, double* %l16
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t146 = load i8*, i8** %l2
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t148 = load double, double* %l4
  %t149 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t150 = load double, double* %l6
  %t151 = load i8*, i8** %l7
  %t152 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t153 = load double, double* %l11
  %t154 = load i8*, i8** %l14
  %t155 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t156 = load double, double* %l16
  br label %loop.header11
loop.header11:
  %t174 = phi { %LLVMOperand*, i64 }* [ %t155, %then9 ], [ %t172, %loop.latch13 ]
  %t175 = phi double [ %t156, %then9 ], [ %t173, %loop.latch13 ]
  store { %LLVMOperand*, i64 }* %t174, { %LLVMOperand*, i64 }** %l15
  store double %t175, double* %l16
  br label %loop.body12
loop.body12:
  %t157 = load double, double* %l16
  %t158 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t159 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t160 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t161 = load double, double* %l16
  %t162 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t160
  %t163 = extractvalue { %LLVMOperand*, i64 } %t162, 0
  %t164 = extractvalue { %LLVMOperand*, i64 } %t162, 1
  %t165 = icmp uge i64 %t161, %t164
  ; bounds check: %t165 (if true, out of bounds)
  %t166 = getelementptr %LLVMOperand, %LLVMOperand* %t163, i64 %t161
  %t167 = load %LLVMOperand, %LLVMOperand* %t166
  %t168 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t159, %LLVMOperand %t167)
  store { %LLVMOperand*, i64 }* %t168, { %LLVMOperand*, i64 }** %l15
  %t169 = load double, double* %l16
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l16
  br label %loop.latch13
loop.latch13:
  %t172 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  %t173 = load double, double* %l16
  br label %loop.header11
afterloop14:
  %t176 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l15
  store { %LLVMOperand*, i64 }* %t176, { %LLVMOperand*, i64 }** %l5
  br label %merge10
merge10:
  %t177 = phi { %LLVMOperand*, i64 }* [ %t176, %then9 ], [ %t129, %entry ]
  store { %LLVMOperand*, i64 }* %t177, { %LLVMOperand*, i64 }** %l5
  store double 0.0, double* %l17
  %t178 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %s179 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.179, i32 0, i32 0
  store i8* %s179, i8** %l18
  %t180 = alloca [0 x double]
  %t181 = getelementptr [0 x double], [0 x double]* %t180, i32 0, i32 0
  %t182 = alloca { double*, i64 }
  %t183 = getelementptr { double*, i64 }, { double*, i64 }* %t182, i32 0, i32 0
  store double* %t181, double** %t183
  %t184 = getelementptr { double*, i64 }, { double*, i64 }* %t182, i32 0, i32 1
  store i64 0, i64* %t184
  store { i8**, i64 }* null, { i8**, i64 }** %l19
  store i1 0, i1* %l20
  %t185 = load i8*, i8** %l2
  %t186 = call double @substring(i8* %t185, i64 0, i64 16)
  %s187 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.187, i32 0, i32 0
  %t188 = load i8*, i8** %l2
  %t189 = call double @find_function_by_name({ i8**, i64 }* %functions, i8* %t188)
  store double %t189, double* %l21
  %t190 = load i8*, i8** %l2
  %t191 = call double @find_runtime_helper(i8* %t190)
  store double %t191, double* %l22
  %t192 = load i1, i1* %l20
  %t193 = xor i1 %t192, 1
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t196 = load i8*, i8** %l2
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t198 = load double, double* %l4
  %t199 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t200 = load double, double* %l6
  %t201 = load i8*, i8** %l7
  %t202 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t203 = load double, double* %l11
  %t204 = load double, double* %l17
  %t205 = load i8*, i8** %l18
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t207 = load i1, i1* %l20
  %t208 = load double, double* %l21
  %t209 = load double, double* %l22
  br i1 %t193, label %then15, label %merge16
then15:
  %t210 = load double, double* %l21
  br label %merge16
merge16:
  %t212 = load double, double* %l21
  %t213 = alloca [0 x double]
  %t214 = getelementptr [0 x double], [0 x double]* %t213, i32 0, i32 0
  %t215 = alloca { double*, i64 }
  %t216 = getelementptr { double*, i64 }, { double*, i64 }* %t215, i32 0, i32 0
  store double* %t214, double** %t216
  %t217 = getelementptr { double*, i64 }, { double*, i64 }* %t215, i32 0, i32 1
  store i64 0, i64* %t217
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l23
  %t218 = sitofp i64 0 to double
  store double %t218, double* %l11
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t220 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t221 = load i8*, i8** %l2
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t223 = load double, double* %l4
  %t224 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t225 = load double, double* %l6
  %t226 = load i8*, i8** %l7
  %t227 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t228 = load double, double* %l11
  %t229 = load double, double* %l17
  %t230 = load i8*, i8** %l18
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t232 = load i1, i1* %l20
  %t233 = load double, double* %l21
  %t234 = load double, double* %l22
  %t235 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  br label %loop.header17
loop.header17:
  %t283 = phi { %LLVMOperand*, i64 }* [ %t235, %entry ], [ %t281, %loop.latch19 ]
  %t284 = phi double [ %t228, %entry ], [ %t282, %loop.latch19 ]
  store { %LLVMOperand*, i64 }* %t283, { %LLVMOperand*, i64 }** %l23
  store double %t284, double* %l11
  br label %loop.body18
loop.body18:
  %t236 = load double, double* %l11
  %t237 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t238 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t239 = load double, double* %l11
  %t240 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t238
  %t241 = extractvalue { %LLVMOperand*, i64 } %t240, 0
  %t242 = extractvalue { %LLVMOperand*, i64 } %t240, 1
  %t243 = icmp uge i64 %t239, %t242
  ; bounds check: %t243 (if true, out of bounds)
  %t244 = getelementptr %LLVMOperand, %LLVMOperand* %t241, i64 %t239
  %t245 = load %LLVMOperand, %LLVMOperand* %t244
  store %LLVMOperand %t245, %LLVMOperand* %l24
  %s246 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.246, i32 0, i32 0
  store i8* %s246, i8** %l25
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t249 = load i1, i1* %l20
  br label %logical_and_entry_248

logical_and_entry_248:
  br i1 %t249, label %logical_and_right_248, label %logical_and_merge_248

logical_and_right_248:
  %t250 = load double, double* %l11
  %t251 = sitofp i64 0 to double
  %t252 = fcmp oeq double %t250, %t251
  br label %logical_and_right_end_248

logical_and_right_end_248:
  br label %logical_and_merge_248

logical_and_merge_248:
  %t253 = phi i1 [ false, %logical_and_entry_248 ], [ %t252, %logical_and_right_end_248 ]
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t255 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t256 = load i8*, i8** %l2
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t258 = load double, double* %l4
  %t259 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t260 = load double, double* %l6
  %t261 = load i8*, i8** %l7
  %t262 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t263 = load double, double* %l11
  %t264 = load double, double* %l17
  %t265 = load i8*, i8** %l18
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t267 = load i1, i1* %l20
  %t268 = load double, double* %l21
  %t269 = load double, double* %l22
  %t270 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t271 = load %LLVMOperand, %LLVMOperand* %l24
  %t272 = load i8*, i8** %l25
  br i1 %t253, label %then21, label %else22
then21:
  %t273 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t274 = load %LLVMOperand, %LLVMOperand* %l24
  %t275 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t273, %LLVMOperand %t274)
  store { %LLVMOperand*, i64 }* %t275, { %LLVMOperand*, i64 }** %l23
  br label %merge23
else22:
  %t276 = load i8*, i8** %l25
  br label %merge23
merge23:
  %t277 = phi { %LLVMOperand*, i64 }* [ %t275, %then21 ], [ %t270, %else22 ]
  store { %LLVMOperand*, i64 }* %t277, { %LLVMOperand*, i64 }** %l23
  %t278 = load double, double* %l11
  %t279 = sitofp i64 1 to double
  %t280 = fadd double %t278, %t279
  store double %t280, double* %l11
  br label %loop.latch19
loop.latch19:
  %t281 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t282 = load double, double* %l11
  br label %loop.header17
afterloop20:
  %t285 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  store { %LLVMOperand*, i64 }* %t285, { %LLVMOperand*, i64 }** %l5
  %t287 = load double, double* %l21
  %t288 = alloca [0 x double]
  %t289 = getelementptr [0 x double], [0 x double]* %t288, i32 0, i32 0
  %t290 = alloca { double*, i64 }
  %t291 = getelementptr { double*, i64 }, { double*, i64 }* %t290, i32 0, i32 0
  store double* %t289, double** %t291
  %t292 = getelementptr { double*, i64 }, { double*, i64 }* %t290, i32 0, i32 1
  store i64 0, i64* %t292
  store { i8**, i64 }* null, { i8**, i64 }** %l26
  %t293 = sitofp i64 0 to double
  store double %t293, double* %l11
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t295 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t296 = load i8*, i8** %l2
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t298 = load double, double* %l4
  %t299 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t300 = load double, double* %l6
  %t301 = load i8*, i8** %l7
  %t302 = load %MemberAccessParse, %MemberAccessParse* %l8
  %t303 = load double, double* %l11
  %t304 = load double, double* %l17
  %t305 = load i8*, i8** %l18
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l19
  %t307 = load i1, i1* %l20
  %t308 = load double, double* %l21
  %t309 = load double, double* %l22
  %t310 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l23
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l26
  br label %loop.header24
loop.header24:
  %t330 = phi { i8**, i64 }* [ %t311, %entry ], [ %t328, %loop.latch26 ]
  %t331 = phi double [ %t303, %entry ], [ %t329, %loop.latch26 ]
  store { i8**, i64 }* %t330, { i8**, i64 }** %l26
  store double %t331, double* %l11
  br label %loop.body25
loop.body25:
  %t312 = load double, double* %l11
  %t313 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t315 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l5
  %t316 = load double, double* %l11
  %t317 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t315
  %t318 = extractvalue { %LLVMOperand*, i64 } %t317, 0
  %t319 = extractvalue { %LLVMOperand*, i64 } %t317, 1
  %t320 = icmp uge i64 %t316, %t319
  ; bounds check: %t320 (if true, out of bounds)
  %t321 = getelementptr %LLVMOperand, %LLVMOperand* %t318, i64 %t316
  %t322 = load %LLVMOperand, %LLVMOperand* %t321
  %t323 = call i8* @format_typed_operand(%LLVMOperand %t322)
  %t324 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t314, i8* %t323)
  store { i8**, i64 }* %t324, { i8**, i64 }** %l26
  %t325 = load double, double* %l11
  %t326 = sitofp i64 1 to double
  %t327 = fadd double %t325, %t326
  store double %t327, double* %l11
  br label %loop.latch26
loop.latch26:
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t329 = load double, double* %l11
  br label %loop.header24
afterloop27:
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l26
  store double 0.0, double* %l27
  %t333 = load i8*, i8** %l2
  %t334 = call double @substring(i8* %t333, i64 0, i64 16)
  %s335 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.335, i32 0, i32 0
  %t336 = load i8*, i8** %l2
  %t337 = call i8* @sanitize_symbol(i8* %t336)
  store i8* %t337, i8** %l28
  %t338 = load double, double* %l22
  %t339 = load i8*, i8** %l18
  %s340 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.340, i32 0, i32 0
  %t341 = icmp eq i8* %t339, %s340
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
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l26
  %t360 = load double, double* %l27
  %t361 = load i8*, i8** %l28
  br i1 %t341, label %then28, label %merge29
then28:
  %s362 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.362, i32 0, i32 0
  %t363 = load i8*, i8** %l28
  %t364 = add i8* %s362, %t363
  %s365 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.365, i32 0, i32 0
  %t366 = add i8* %t364, %s365
  store i8* %t366, i8** %l29
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t368 = load i8*, i8** %l29
  %t369 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t367, i8* %t368)
  store { i8**, i64 }* %t369, { i8**, i64 }** %l3
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t371 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t370, 0
  %t372 = load double, double* %l4
  %t373 = insertvalue %ExpressionResult %t371, double %t372, 1
  %t374 = insertvalue %ExpressionResult %t373, i8* null, 2
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t376 = insertvalue %ExpressionResult %t374, { i8**, i64 }* %t375, 3
  %t377 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l1
  %t378 = insertvalue %ExpressionResult %t376, { i8**, i64 }* null, 4
  ret %ExpressionResult %t378
merge29:
  %t379 = load double, double* %l4
  %t380 = call i8* @format_temp_name(double %t379)
  store i8* %t380, i8** %l30
  %s381 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.381, i32 0, i32 0
  %t382 = load i8*, i8** %l30
  %t383 = add i8* %s381, %t382
  %s384 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.384, i32 0, i32 0
  %t385 = add i8* %t383, %s384
  %t386 = load i8*, i8** %l18
  %t387 = add i8* %t385, %t386
  %s388 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.388, i32 0, i32 0
  %t389 = add i8* %t387, %s388
  %t390 = load i8*, i8** %l28
  %t391 = add i8* %t389, %t390
  %s392 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.392, i32 0, i32 0
  %t393 = add i8* %t391, %s392
  store i8* %t393, i8** %l31
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t395 = load i8*, i8** %l31
  %t396 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t394, i8* %t395)
  store { i8**, i64 }* %t396, { i8**, i64 }** %l3
  %t397 = load i8*, i8** %l18
  %t398 = insertvalue %LLVMOperand undef, i8* %t397, 0
  %t399 = load i8*, i8** %l30
  %t400 = insertvalue %LLVMOperand %t398, i8* %t399, 1
  store %LLVMOperand %t400, %LLVMOperand* %l32
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
  store i8* null, i8** %l6
  store i1 0, i1* %l7
  %t29 = load i8*, i8** %l5
  store i8* %t29, i8** %l8
  %t30 = load i8*, i8** %l5
  %t31 = load i8*, i8** %l6
  store i8* %t31, i8** %l9
  %t32 = load i8*, i8** %l9
  %t33 = extractvalue %MemberAccessParse %parse, 2
  %t34 = call double @find_struct_field_info(%StructTypeInfo zeroinitializer, i8* %t33)
  store double %t34, double* %l10
  %t35 = load double, double* %l10
  %t36 = load i1, i1* %l7
  %t37 = load %ExpressionResult, %ExpressionResult* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load double, double* %l4
  %t42 = load i8*, i8** %l5
  %t43 = load i8*, i8** %l6
  %t44 = load i1, i1* %l7
  %t45 = load i8*, i8** %l8
  %t46 = load i8*, i8** %l9
  %t47 = load double, double* %l10
  br i1 %t36, label %then2, label %merge3
then2:
  %t48 = load i8*, i8** %l9
  store double 0.0, double* %l11
  %t49 = load double, double* %l4
  %t50 = call i8* @format_temp_name(double %t49)
  store i8* %t50, i8** %l12
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s52 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.52, i32 0, i32 0
  %t53 = load i8*, i8** %l12
  %t54 = add i8* %s52, %t53
  %s55 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.55, i32 0, i32 0
  %t56 = add i8* %t54, %s55
  %t57 = load double, double* %l11
  %t58 = load double, double* %l4
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l4
  %t61 = load double, double* %l4
  %t62 = call i8* @format_temp_name(double %t61)
  store i8* %t62, i8** %l13
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s64 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.64, i32 0, i32 0
  %t65 = load i8*, i8** %l13
  %t66 = add i8* %s64, %t65
  %s67 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.67, i32 0, i32 0
  %t68 = add i8* %t66, %s67
  %t69 = load double, double* %l10
  %t70 = load double, double* %l4
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l4
  %t73 = load double, double* %l10
  %t74 = insertvalue %LLVMOperand undef, i8* null, 0
  %t75 = load i8*, i8** %l13
  %t76 = insertvalue %LLVMOperand %t74, i8* %t75, 1
  store %LLVMOperand %t76, %LLVMOperand* %l14
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t78 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t77, 0
  %t79 = load double, double* %l4
  %t80 = insertvalue %ExpressionResult %t78, double %t79, 1
  %t81 = load %LLVMOperand, %LLVMOperand* %l14
  %t82 = insertvalue %ExpressionResult %t80, i8* null, 2
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = insertvalue %ExpressionResult %t82, { i8**, i64 }* %t83, 3
  %t85 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t86 = insertvalue %ExpressionResult %t84, { i8**, i64 }* null, 4
  ret %ExpressionResult %t86
merge3:
  %t87 = load double, double* %l4
  %t88 = call i8* @format_temp_name(double %t87)
  store i8* %t88, i8** %l15
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s90 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.90, i32 0, i32 0
  %t91 = load i8*, i8** %l15
  %t92 = add i8* %s90, %t91
  %s93 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.93, i32 0, i32 0
  %t94 = add i8* %t92, %s93
  %t95 = load i8*, i8** %l9
  %t96 = load double, double* %l4
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  store double %t98, double* %l4
  %t99 = load double, double* %l10
  %t100 = insertvalue %LLVMOperand undef, i8* null, 0
  %t101 = load i8*, i8** %l15
  %t102 = insertvalue %LLVMOperand %t100, i8* %t101, 1
  store %LLVMOperand %t102, %LLVMOperand* %l16
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t104 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t103, 0
  %t105 = load double, double* %l4
  %t106 = insertvalue %ExpressionResult %t104, double %t105, 1
  %t107 = load %LLVMOperand, %LLVMOperand* %l16
  %t108 = insertvalue %ExpressionResult %t106, i8* null, 2
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t110 = insertvalue %ExpressionResult %t108, { i8**, i64 }* %t109, 3
  %t111 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l2
  %t112 = insertvalue %ExpressionResult %t110, { i8**, i64 }* null, 4
  ret %ExpressionResult %t112
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
  %t104 = phi { i8**, i64 }* [ %t23, %entry ], [ %t97, %loop.latch2 ]
  %t105 = phi { %StringConstant*, i64 }* [ %t26, %entry ], [ %t98, %loop.latch2 ]
  %t106 = phi { i8**, i64 }* [ %t24, %entry ], [ %t99, %loop.latch2 ]
  %t107 = phi double [ %t25, %entry ], [ %t100, %loop.latch2 ]
  %t108 = phi { %LLVMOperand*, i64 }* [ %t30, %entry ], [ %t101, %loop.latch2 ]
  %t109 = phi i8* [ %t31, %entry ], [ %t102, %loop.latch2 ]
  %t110 = phi double [ %t32, %entry ], [ %t103, %loop.latch2 ]
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  store { %StringConstant*, i64 }* %t105, { %StringConstant*, i64 }** %l3
  store { i8**, i64 }* %t106, { i8**, i64 }** %l1
  store double %t107, double* %l2
  store { %LLVMOperand*, i64 }* %t108, { %LLVMOperand*, i64 }** %l7
  store i8* %t109, i8** %l8
  store double %t110, double* %l9
  br label %loop.body1
loop.body1:
  %t33 = load double, double* %l9
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t36 = load double, double* %l9
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t35
  %t38 = extractvalue { i8**, i64 } %t37, 0
  %t39 = extractvalue { i8**, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  %t41 = getelementptr i8*, i8** %t38, i64 %t36
  %t42 = load i8*, i8** %t41
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l10
  %t44 = load i8*, i8** %l10
  %t45 = load i8*, i8** %l10
  %t46 = load double, double* %l2
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = call %ExpressionResult @lower_expression(i8* %t45, { %ParameterBinding*, i64 }* %bindings, { %LocalBinding*, i64 }* %locals, double %t46, { i8**, i64 }* %t47, { i8**, i64 }* %functions, %TypeContext %context)
  store %ExpressionResult %t48, %ExpressionResult* %l11
  %t49 = load %ExpressionResult, %ExpressionResult* %l11
  %t50 = extractvalue %ExpressionResult %t49, 3
  %t51 = call double @diagnosticsconcat({ i8**, i64 }* %t50)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t52 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t53 = load %ExpressionResult, %ExpressionResult* %l11
  %t54 = extractvalue %ExpressionResult %t53, 4
  %t55 = call { %StringConstant*, i64 }* @merge_string_constants({ %StringConstant*, i64 }* %t52, { %StringConstant*, i64 }* null)
  store { %StringConstant*, i64 }* %t55, { %StringConstant*, i64 }** %l3
  %t56 = load %ExpressionResult, %ExpressionResult* %l11
  %t57 = extractvalue %ExpressionResult %t56, 0
  store { i8**, i64 }* %t57, { i8**, i64 }** %l1
  %t58 = load %ExpressionResult, %ExpressionResult* %l11
  %t59 = extractvalue %ExpressionResult %t58, 1
  store double %t59, double* %l2
  %t60 = load %ExpressionResult, %ExpressionResult* %l11
  %t61 = extractvalue %ExpressionResult %t60, 2
  %t62 = icmp eq i8* %t61, null
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = load double, double* %l2
  %t66 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t67 = load double, double* %l4
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t69 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t70 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t71 = load i8*, i8** %l8
  %t72 = load double, double* %l9
  %t73 = load i8*, i8** %l10
  %t74 = load %ExpressionResult, %ExpressionResult* %l11
  br i1 %t62, label %then4, label %merge5
then4:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s76 = getelementptr inbounds [55 x i8], [55 x i8]* @.str.76, i32 0, i32 0
  %t77 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t75, i8* %s76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t78, 0
  %t80 = load double, double* %l2
  %t81 = insertvalue %ExpressionResult %t79, double %t80, 1
  %t82 = insertvalue %ExpressionResult %t81, i8* null, 2
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = insertvalue %ExpressionResult %t82, { i8**, i64 }* %t83, 3
  %t85 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t86 = insertvalue %ExpressionResult %t84, { i8**, i64 }* null, 4
  ret %ExpressionResult %t86
merge5:
  %t87 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t88 = load %ExpressionResult, %ExpressionResult* %l11
  %t89 = extractvalue %ExpressionResult %t88, 2
  %t90 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t87, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t90, { %LLVMOperand*, i64 }** %l7
  %t91 = load i8*, i8** %l8
  %t92 = load %ExpressionResult, %ExpressionResult* %l11
  %t93 = extractvalue %ExpressionResult %t92, 2
  %t94 = load double, double* %l9
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l9
  br label %loop.latch2
loop.latch2:
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load double, double* %l2
  %t101 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t102 = load i8*, i8** %l8
  %t103 = load double, double* %l9
  br label %loop.header0
afterloop3:
  %t111 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t112 = load i8*, i8** %l8
  %t113 = load i8*, i8** %l8
  store i8* %t113, i8** %l12
  %t114 = alloca [0 x double]
  %t115 = getelementptr [0 x double], [0 x double]* %t114, i32 0, i32 0
  %t116 = alloca { double*, i64 }
  %t117 = getelementptr { double*, i64 }, { double*, i64 }* %t116, i32 0, i32 0
  store double* %t115, double** %t117
  %t118 = getelementptr { double*, i64 }, { double*, i64 }* %t116, i32 0, i32 1
  store i64 0, i64* %t118
  store { %LLVMOperand*, i64 }* null, { %LLVMOperand*, i64 }** %l13
  %t119 = sitofp i64 0 to double
  store double %t119, double* %l9
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load double, double* %l2
  %t123 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t124 = load double, double* %l4
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t126 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t127 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t128 = load i8*, i8** %l8
  %t129 = load double, double* %l9
  %t130 = load i8*, i8** %l12
  %t131 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  br label %loop.header6
loop.header6:
  %t199 = phi { i8**, i64 }* [ %t120, %entry ], [ %t194, %loop.latch8 ]
  %t200 = phi { i8**, i64 }* [ %t121, %entry ], [ %t195, %loop.latch8 ]
  %t201 = phi double [ %t122, %entry ], [ %t196, %loop.latch8 ]
  %t202 = phi { %LLVMOperand*, i64 }* [ %t131, %entry ], [ %t197, %loop.latch8 ]
  %t203 = phi double [ %t129, %entry ], [ %t198, %loop.latch8 ]
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  store { i8**, i64 }* %t200, { i8**, i64 }** %l1
  store double %t201, double* %l2
  store { %LLVMOperand*, i64 }* %t202, { %LLVMOperand*, i64 }** %l13
  store double %t203, double* %l9
  br label %loop.body7
loop.body7:
  %t132 = load double, double* %l9
  %t133 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t134 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t135 = load double, double* %l9
  %t136 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t134
  %t137 = extractvalue { %LLVMOperand*, i64 } %t136, 0
  %t138 = extractvalue { %LLVMOperand*, i64 } %t136, 1
  %t139 = icmp uge i64 %t135, %t138
  ; bounds check: %t139 (if true, out of bounds)
  %t140 = getelementptr %LLVMOperand, %LLVMOperand* %t137, i64 %t135
  %t141 = load %LLVMOperand, %LLVMOperand* %t140
  store %LLVMOperand %t141, %LLVMOperand* %l14
  %t142 = load %LLVMOperand, %LLVMOperand* %l14
  %t143 = load i8*, i8** %l12
  %t144 = load double, double* %l2
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t146 = call %CoercionResult @coerce_operand_to_type(%LLVMOperand %t142, i8* %t143, double %t144, { i8**, i64 }* %t145)
  store %CoercionResult %t146, %CoercionResult* %l15
  %t147 = load %CoercionResult, %CoercionResult* %l15
  %t148 = extractvalue %CoercionResult %t147, 3
  %t149 = call double @diagnosticsconcat({ i8**, i64 }* %t148)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t150 = load %CoercionResult, %CoercionResult* %l15
  %t151 = extractvalue %CoercionResult %t150, 0
  store { i8**, i64 }* %t151, { i8**, i64 }** %l1
  %t152 = load %CoercionResult, %CoercionResult* %l15
  %t153 = extractvalue %CoercionResult %t152, 1
  store double %t153, double* %l2
  %t154 = load %CoercionResult, %CoercionResult* %l15
  %t155 = extractvalue %CoercionResult %t154, 2
  %t156 = icmp eq i8* %t155, null
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load double, double* %l2
  %t160 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t161 = load double, double* %l4
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t163 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t164 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t165 = load i8*, i8** %l8
  %t166 = load double, double* %l9
  %t167 = load i8*, i8** %l12
  %t168 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t169 = load %LLVMOperand, %LLVMOperand* %l14
  %t170 = load %CoercionResult, %CoercionResult* %l15
  br i1 %t156, label %then10, label %merge11
then10:
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s172 = getelementptr inbounds [63 x i8], [63 x i8]* @.str.172, i32 0, i32 0
  %t173 = load i8*, i8** %l12
  %t174 = add i8* %s172, %t173
  %s175 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.175, i32 0, i32 0
  %t176 = add i8* %t174, %s175
  %t177 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t171, i8* %t176)
  store { i8**, i64 }* %t177, { i8**, i64 }** %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t178, 0
  %t180 = load double, double* %l2
  %t181 = insertvalue %ExpressionResult %t179, double %t180, 1
  %t182 = insertvalue %ExpressionResult %t181, i8* null, 2
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = insertvalue %ExpressionResult %t182, { i8**, i64 }* %t183, 3
  %t185 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t186 = insertvalue %ExpressionResult %t184, { i8**, i64 }* null, 4
  ret %ExpressionResult %t186
merge11:
  %t187 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t188 = load %CoercionResult, %CoercionResult* %l15
  %t189 = extractvalue %CoercionResult %t188, 2
  %t190 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t187, %LLVMOperand zeroinitializer)
  store { %LLVMOperand*, i64 }* %t190, { %LLVMOperand*, i64 }** %l13
  %t191 = load double, double* %l9
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %t191, %t192
  store double %t193, double* %l9
  br label %loop.latch8
loop.latch8:
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t196 = load double, double* %l2
  %t197 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t198 = load double, double* %l9
  br label %loop.header6
afterloop9:
  %t204 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  store { %LLVMOperand*, i64 }* %t204, { %LLVMOperand*, i64 }** %l7
  %t205 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  store double 0.0, double* %l16
  %t206 = load double, double* %l16
  %t207 = call i8* @number_to_string(double %t206)
  store i8* %t207, i8** %l17
  %s208 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.208, i32 0, i32 0
  %t209 = load i8*, i8** %l17
  %t210 = add i8* %s208, %t209
  %s211 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.211, i32 0, i32 0
  %t212 = add i8* %t210, %s211
  %t213 = load i8*, i8** %l12
  %t214 = add i8* %t212, %t213
  %s215 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.215, i32 0, i32 0
  %t216 = add i8* %t214, %s215
  store i8* %t216, i8** %l18
  %t217 = load double, double* %l2
  %t218 = call i8* @format_temp_name(double %t217)
  store i8* %t218, i8** %l19
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s220 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.220, i32 0, i32 0
  %t221 = load i8*, i8** %l19
  %t222 = add i8* %s220, %t221
  %s223 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.223, i32 0, i32 0
  %t224 = add i8* %t222, %s223
  %t225 = load i8*, i8** %l18
  %t226 = add i8* %t224, %t225
  %t227 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t219, i8* %t226)
  store { i8**, i64 }* %t227, { i8**, i64 }** %l1
  %t228 = load double, double* %l2
  %t229 = sitofp i64 1 to double
  %t230 = fadd double %t228, %t229
  store double %t230, double* %l2
  %t231 = load double, double* %l2
  %t232 = call i8* @format_temp_name(double %t231)
  store i8* %t232, i8** %l20
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s234 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.234, i32 0, i32 0
  %t235 = load i8*, i8** %l20
  %t236 = add i8* %s234, %t235
  %s237 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.237, i32 0, i32 0
  %t238 = add i8* %t236, %s237
  %t239 = load i8*, i8** %l18
  %t240 = add i8* %t238, %t239
  %t241 = load double, double* %l2
  %t242 = sitofp i64 1 to double
  %t243 = fadd double %t241, %t242
  store double %t243, double* %l2
  %t244 = sitofp i64 0 to double
  store double %t244, double* %l9
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load double, double* %l2
  %t248 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t249 = load double, double* %l4
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t251 = load %ArrayLiteralMetadata, %ArrayLiteralMetadata* %l6
  %t252 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t253 = load i8*, i8** %l8
  %t254 = load double, double* %l9
  %t255 = load i8*, i8** %l12
  %t256 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l13
  %t257 = load double, double* %l16
  %t258 = load i8*, i8** %l17
  %t259 = load i8*, i8** %l18
  %t260 = load i8*, i8** %l19
  %t261 = load i8*, i8** %l20
  br label %loop.header12
loop.header12:
  %t299 = phi { i8**, i64 }* [ %t246, %entry ], [ %t296, %loop.latch14 ]
  %t300 = phi double [ %t247, %entry ], [ %t297, %loop.latch14 ]
  %t301 = phi double [ %t254, %entry ], [ %t298, %loop.latch14 ]
  store { i8**, i64 }* %t299, { i8**, i64 }** %l1
  store double %t300, double* %l2
  store double %t301, double* %l9
  br label %loop.body13
loop.body13:
  %t262 = load double, double* %l9
  %t263 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t264 = load double, double* %l2
  %t265 = call i8* @format_temp_name(double %t264)
  store i8* %t265, i8** %l21
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s267 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.267, i32 0, i32 0
  %t268 = load i8*, i8** %l21
  %t269 = add i8* %s267, %t268
  %s270 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.270, i32 0, i32 0
  %t271 = add i8* %t269, %s270
  %t272 = load i8*, i8** %l12
  %t273 = add i8* %t271, %t272
  %t274 = load double, double* %l2
  %t275 = sitofp i64 1 to double
  %t276 = fadd double %t274, %t275
  store double %t276, double* %l2
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s278 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.278, i32 0, i32 0
  %t279 = load i8*, i8** %l12
  %t280 = add i8* %s278, %t279
  %s281 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.281, i32 0, i32 0
  %t282 = add i8* %t280, %s281
  %t283 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l7
  %t284 = load double, double* %l9
  %t285 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %t283
  %t286 = extractvalue { %LLVMOperand*, i64 } %t285, 0
  %t287 = extractvalue { %LLVMOperand*, i64 } %t285, 1
  %t288 = icmp uge i64 %t284, %t287
  ; bounds check: %t288 (if true, out of bounds)
  %t289 = getelementptr %LLVMOperand, %LLVMOperand* %t286, i64 %t284
  %t290 = load %LLVMOperand, %LLVMOperand* %t289
  %t291 = extractvalue %LLVMOperand %t290, 1
  %t292 = add i8* %t282, %t291
  %t293 = load double, double* %l9
  %t294 = sitofp i64 1 to double
  %t295 = fadd double %t293, %t294
  store double %t295, double* %l9
  br label %loop.latch14
loop.latch14:
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load double, double* %l2
  %t298 = load double, double* %l9
  br label %loop.header12
afterloop15:
  %t302 = load i8*, i8** %l12
  %t303 = call i8* @array_struct_type_for_element(i8* %t302)
  store i8* %t303, i8** %l22
  %t304 = load double, double* %l2
  %t305 = call i8* @format_temp_name(double %t304)
  store i8* %t305, i8** %l23
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s307 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.307, i32 0, i32 0
  %t308 = load i8*, i8** %l23
  %t309 = add i8* %s307, %t308
  %s310 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.310, i32 0, i32 0
  %t311 = add i8* %t309, %s310
  %t312 = load i8*, i8** %l22
  %t313 = add i8* %t311, %t312
  %t314 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t306, i8* %t313)
  store { i8**, i64 }* %t314, { i8**, i64 }** %l1
  %t315 = load double, double* %l2
  %t316 = sitofp i64 1 to double
  %t317 = fadd double %t315, %t316
  store double %t317, double* %l2
  %t318 = load double, double* %l2
  %t319 = call i8* @format_temp_name(double %t318)
  store i8* %t319, i8** %l24
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s321 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.321, i32 0, i32 0
  %t322 = load i8*, i8** %l24
  %t323 = add i8* %s321, %t322
  %s324 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.324, i32 0, i32 0
  %t325 = add i8* %t323, %s324
  %t326 = load i8*, i8** %l22
  %t327 = add i8* %t325, %t326
  %t328 = load double, double* %l2
  %t329 = sitofp i64 1 to double
  %t330 = fadd double %t328, %t329
  store double %t330, double* %l2
  %t331 = load i8*, i8** %l12
  store double 0.0, double* %l25
  %t332 = load double, double* %l25
  store double 0.0, double* %l26
  %t333 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s334 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.334, i32 0, i32 0
  %t335 = load double, double* %l25
  %t336 = load double, double* %l2
  %t337 = call i8* @format_temp_name(double %t336)
  store i8* %t337, i8** %l27
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s339 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.339, i32 0, i32 0
  %t340 = load i8*, i8** %l27
  %t341 = add i8* %s339, %t340
  %s342 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.342, i32 0, i32 0
  %t343 = add i8* %t341, %s342
  %t344 = load i8*, i8** %l22
  %t345 = add i8* %t343, %t344
  %t346 = load double, double* %l2
  %t347 = sitofp i64 1 to double
  %t348 = fadd double %t346, %t347
  store double %t348, double* %l2
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s350 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.350, i32 0, i32 0
  %t351 = load i8*, i8** %l17
  %t352 = add i8* %s350, %t351
  store double 0.0, double* %l28
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t354 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t353, 0
  %t355 = load double, double* %l2
  %t356 = insertvalue %ExpressionResult %t354, double %t355, 1
  %t357 = load double, double* %l28
  %t358 = insertvalue %ExpressionResult %t356, i8* null, 2
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = insertvalue %ExpressionResult %t358, { i8**, i64 }* %t359, 3
  %t361 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t362 = insertvalue %ExpressionResult %t360, { i8**, i64 }* null, 4
  ret %ExpressionResult %t362
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
  %t261 = phi double [ %t156, %then10 ], [ %t257, %loop.latch14 ]
  %t262 = phi { i8**, i64 }* [ %t142, %then10 ], [ %t258, %loop.latch14 ]
  %t263 = phi { i8**, i64 }* [ %t155, %then10 ], [ %t259, %loop.latch14 ]
  %t264 = phi { %StructLiteralField*, i64 }* [ %t152, %then10 ], [ %t260, %loop.latch14 ]
  store double %t261, double* %l16
  store { i8**, i64 }* %t262, { i8**, i64 }** %l1
  store { i8**, i64 }* %t263, { i8**, i64 }** %l15
  store { %StructLiteralField*, i64 }* %t264, { %StructLiteralField*, i64 }** %l12
  br label %loop.body13
loop.body13:
  %t157 = load double, double* %l16
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t160 = load double, double* %l16
  %t161 = load { i8**, i64 }, { i8**, i64 }* %t159
  %t162 = extractvalue { i8**, i64 } %t161, 0
  %t163 = extractvalue { i8**, i64 } %t161, 1
  %t164 = icmp uge i64 %t160, %t163
  ; bounds check: %t164 (if true, out of bounds)
  %t165 = getelementptr i8*, i8** %t162, i64 %t160
  %t166 = load i8*, i8** %t165
  %t167 = call i8* @trim_text(i8* %t166)
  store i8* %t167, i8** %l17
  %t168 = load double, double* %l16
  %t169 = sitofp i64 1 to double
  %t170 = fadd double %t168, %t169
  store double %t170, double* %l16
  %t171 = load i8*, i8** %l17
  %t172 = load i8*, i8** %l17
  %t173 = call double @find_top_level_colon(i8* %t172)
  store double %t173, double* %l18
  %t174 = load double, double* %l18
  %t175 = sitofp i64 0 to double
  %t176 = fcmp olt double %t174, %t175
  %t177 = load i8*, i8** %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = load i8, i8* %l2
  %t180 = load double, double* %l3
  %t181 = load double, double* %l4
  %t182 = load double, double* %l5
  %t183 = load double, double* %l6
  %t184 = load double, double* %l7
  %t185 = load i1, i1* %l9
  %t186 = load double, double* %l10
  %t187 = load i8*, i8** %l11
  %t188 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t189 = load double, double* %l13
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t192 = load double, double* %l16
  %t193 = load i8*, i8** %l17
  %t194 = load double, double* %l18
  br i1 %t176, label %then16, label %merge17
then16:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s196 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.196, i32 0, i32 0
  %t197 = load i8*, i8** %l17
  %t198 = add i8* %s196, %t197
  %s199 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.199, i32 0, i32 0
  %t200 = add i8* %t198, %s199
  %t201 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t195, i8* %t200)
  store { i8**, i64 }* %t201, { i8**, i64 }** %l1
  br label %loop.latch14
merge17:
  %t202 = load i8*, i8** %l17
  %t203 = load double, double* %l18
  %t204 = call double @substring(i8* %t202, i64 0, double %t203)
  %t205 = call i8* @trim_text(i8* null)
  store i8* %t205, i8** %l19
  %t206 = load i8*, i8** %l17
  %t207 = load double, double* %l18
  %t208 = sitofp i64 1 to double
  %t209 = fadd double %t207, %t208
  %t210 = load i8*, i8** %l17
  store double 0.0, double* %l20
  %t211 = load i8*, i8** %l19
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t213 = load i8*, i8** %l19
  %t214 = call i1 @string_array_contains({ i8**, i64 }* %t212, i8* %t213)
  %t215 = load i8*, i8** %l0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = load i8, i8* %l2
  %t218 = load double, double* %l3
  %t219 = load double, double* %l4
  %t220 = load double, double* %l5
  %t221 = load double, double* %l6
  %t222 = load double, double* %l7
  %t223 = load i1, i1* %l9
  %t224 = load double, double* %l10
  %t225 = load i8*, i8** %l11
  %t226 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t227 = load double, double* %l13
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t230 = load double, double* %l16
  %t231 = load i8*, i8** %l17
  %t232 = load double, double* %l18
  %t233 = load i8*, i8** %l19
  %t234 = load double, double* %l20
  br i1 %t214, label %then18, label %merge19
then18:
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s236 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.236, i32 0, i32 0
  %t237 = load i8*, i8** %l19
  %t238 = add i8* %s236, %t237
  %s239 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.239, i32 0, i32 0
  %t240 = add i8* %t238, %s239
  %t241 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t235, i8* %t240)
  store { i8**, i64 }* %t241, { i8**, i64 }** %l1
  br label %loop.latch14
merge19:
  %t242 = load double, double* %l20
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t244 = load i8*, i8** %l19
  %t245 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t243, i8* %t244)
  store { i8**, i64 }* %t245, { i8**, i64 }** %l15
  %t246 = load i8*, i8** %l19
  %t247 = insertvalue %StructLiteralField undef, i8* %t246, 0
  %t248 = load double, double* %l20
  %t249 = insertvalue %StructLiteralField %t247, i8* null, 1
  %t250 = alloca [1 x %StructLiteralField]
  %t251 = getelementptr [1 x %StructLiteralField], [1 x %StructLiteralField]* %t250, i32 0, i32 0
  %t252 = getelementptr %StructLiteralField, %StructLiteralField* %t251, i64 0
  store %StructLiteralField %t249, %StructLiteralField* %t252
  %t253 = alloca { %StructLiteralField*, i64 }
  %t254 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t253, i32 0, i32 0
  store %StructLiteralField* %t251, %StructLiteralField** %t254
  %t255 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t253, i32 0, i32 1
  store i64 1, i64* %t255
  %t256 = call double @fieldsconcat({ %StructLiteralField*, i64 }* %t253)
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  br label %loop.latch14
loop.latch14:
  %t257 = load double, double* %l16
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t260 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br label %loop.header12
afterloop15:
  br label %merge11
merge11:
  %t265 = phi { i8**, i64 }* [ %t201, %then10 ], [ %t116, %entry ]
  %t266 = phi { i8**, i64 }* [ %t241, %then10 ], [ %t116, %entry ]
  %t267 = phi { %StructLiteralField*, i64 }* [ null, %then10 ], [ %t126, %entry ]
  store { i8**, i64 }* %t265, { i8**, i64 }** %l1
  store { i8**, i64 }* %t266, { i8**, i64 }** %l1
  store { %StructLiteralField*, i64 }* %t267, { %StructLiteralField*, i64 }** %l12
  %t269 = load i1, i1* %l9
  br label %logical_and_entry_268

logical_and_entry_268:
  br i1 %t269, label %logical_and_right_268, label %logical_and_merge_268

logical_and_right_268:
  %t270 = load double, double* %l10
  %t271 = sitofp i64 0 to double
  %t272 = fcmp oge double %t270, %t271
  br label %logical_and_right_end_268

logical_and_right_end_268:
  br label %logical_and_merge_268

logical_and_merge_268:
  %t273 = phi i1 [ false, %logical_and_entry_268 ], [ %t272, %logical_and_right_end_268 ]
  %t274 = xor i1 %t273, 1
  %t275 = load i8*, i8** %l0
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t277 = load i8, i8* %l2
  %t278 = load double, double* %l3
  %t279 = load double, double* %l4
  %t280 = load double, double* %l5
  %t281 = load double, double* %l6
  %t282 = load double, double* %l7
  %t283 = load i1, i1* %l9
  %t284 = load double, double* %l10
  %t285 = load i8*, i8** %l11
  %t286 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br i1 %t274, label %then20, label %merge21
then20:
  %t287 = load i8*, i8** %l0
  %t288 = load double, double* %l10
  %t289 = sitofp i64 1 to double
  %t290 = fadd double %t288, %t289
  %t291 = load i8*, i8** %l0
  store double 0.0, double* %l21
  %t292 = load double, double* %l21
  br label %merge21
merge21:
  %t293 = load i1, i1* %l9
  %t294 = load i8*, i8** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load i8, i8* %l2
  %t297 = load double, double* %l3
  %t298 = load double, double* %l4
  %t299 = load double, double* %l5
  %t300 = load double, double* %l6
  %t301 = load double, double* %l7
  %t302 = load i1, i1* %l9
  %t303 = load double, double* %l10
  %t304 = load i8*, i8** %l11
  %t305 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  br i1 %t293, label %then22, label %merge23
then22:
  %t306 = alloca [0 x double]
  %t307 = getelementptr [0 x double], [0 x double]* %t306, i32 0, i32 0
  %t308 = alloca { double*, i64 }
  %t309 = getelementptr { double*, i64 }, { double*, i64 }* %t308, i32 0, i32 0
  store double* %t307, double** %t309
  %t310 = getelementptr { double*, i64 }, { double*, i64 }* %t308, i32 0, i32 1
  store i64 0, i64* %t310
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l12
  br label %merge23
merge23:
  %t311 = phi { %StructLiteralField*, i64 }* [ null, %then22 ], [ %t305, %entry ]
  store { %StructLiteralField*, i64 }* %t311, { %StructLiteralField*, i64 }** %l12
  %t312 = insertvalue %StructLiteralParse undef, i1 1, 0
  %t313 = load i1, i1* %l9
  %t314 = xor i1 %t313, 1
  %t315 = insertvalue %StructLiteralParse %t312, i1 %t314, 1
  %t316 = load i8*, i8** %l11
  %t317 = insertvalue %StructLiteralParse %t315, i8* %t316, 2
  %t318 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l12
  %t319 = insertvalue %StructLiteralParse %t317, { i8**, i64 }* null, 3
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t321 = insertvalue %StructLiteralParse %t319, { i8**, i64 }* %t320, 4
  ret %StructLiteralParse %t321
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
  %t360 = phi double [ %t210, %then12 ], [ %t356, %loop.latch16 ]
  %t361 = phi { i8**, i64 }* [ %t194, %then12 ], [ %t357, %loop.latch16 ]
  %t362 = phi { i8**, i64 }* [ %t209, %then12 ], [ %t358, %loop.latch16 ]
  %t363 = phi { %StructLiteralField*, i64 }* [ %t206, %then12 ], [ %t359, %loop.latch16 ]
  store double %t360, double* %l19
  store { i8**, i64 }* %t361, { i8**, i64 }** %l1
  store { i8**, i64 }* %t362, { i8**, i64 }** %l18
  store { %StructLiteralField*, i64 }* %t363, { %StructLiteralField*, i64 }** %l15
  br label %loop.body15
loop.body15:
  %t211 = load double, double* %l19
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t214 = load double, double* %l19
  %t215 = load { i8**, i64 }, { i8**, i64 }* %t213
  %t216 = extractvalue { i8**, i64 } %t215, 0
  %t217 = extractvalue { i8**, i64 } %t215, 1
  %t218 = icmp uge i64 %t214, %t217
  ; bounds check: %t218 (if true, out of bounds)
  %t219 = getelementptr i8*, i8** %t216, i64 %t214
  %t220 = load i8*, i8** %t219
  %t221 = call i8* @trim_text(i8* %t220)
  store i8* %t221, i8** %l20
  %t222 = load double, double* %l19
  %t223 = sitofp i64 1 to double
  %t224 = fadd double %t222, %t223
  store double %t224, double* %l19
  %t225 = load i8*, i8** %l20
  %t226 = load i8*, i8** %l20
  %t227 = call double @find_top_level_colon(i8* %t226)
  store double %t227, double* %l21
  %t228 = load double, double* %l21
  %t229 = sitofp i64 0 to double
  %t230 = fcmp olt double %t228, %t229
  %t231 = load i8*, i8** %l0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t233 = load i8, i8* %l2
  %t234 = load double, double* %l3
  %t235 = load i8*, i8** %l4
  %t236 = load double, double* %l5
  %t237 = load double, double* %l6
  %t238 = load double, double* %l7
  %t239 = load double, double* %l8
  %t240 = load double, double* %l9
  %t241 = load i1, i1* %l12
  %t242 = load double, double* %l13
  %t243 = load i8*, i8** %l14
  %t244 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t245 = load double, double* %l16
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t248 = load double, double* %l19
  %t249 = load i8*, i8** %l20
  %t250 = load double, double* %l21
  br i1 %t230, label %then18, label %merge19
then18:
  %t251 = load i8*, i8** %l20
  %t252 = call i8* @trim_text(i8* %t251)
  store i8* %t252, i8** %l22
  %t253 = load i8*, i8** %l22
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t255 = load i8*, i8** %l22
  %t256 = call i1 @string_array_contains({ i8**, i64 }* %t254, i8* %t255)
  %t257 = load i8*, i8** %l0
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t259 = load i8, i8* %l2
  %t260 = load double, double* %l3
  %t261 = load i8*, i8** %l4
  %t262 = load double, double* %l5
  %t263 = load double, double* %l6
  %t264 = load double, double* %l7
  %t265 = load double, double* %l8
  %t266 = load double, double* %l9
  %t267 = load i1, i1* %l12
  %t268 = load double, double* %l13
  %t269 = load i8*, i8** %l14
  %t270 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t271 = load double, double* %l16
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t274 = load double, double* %l19
  %t275 = load i8*, i8** %l20
  %t276 = load double, double* %l21
  %t277 = load i8*, i8** %l22
  br i1 %t256, label %then20, label %merge21
then20:
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s279 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.279, i32 0, i32 0
  %t280 = load i8*, i8** %l22
  %t281 = add i8* %s279, %t280
  %s282 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.282, i32 0, i32 0
  %t283 = add i8* %t281, %s282
  %t284 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t278, i8* %t283)
  store { i8**, i64 }* %t284, { i8**, i64 }** %l1
  br label %loop.latch16
merge21:
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t286 = load i8*, i8** %l22
  %t287 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t285, i8* %t286)
  store { i8**, i64 }* %t287, { i8**, i64 }** %l18
  %t288 = load i8*, i8** %l22
  %t289 = insertvalue %StructLiteralField undef, i8* %t288, 0
  %s290 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.290, i32 0, i32 0
  %t291 = insertvalue %StructLiteralField %t289, i8* %s290, 1
  %t292 = alloca [1 x %StructLiteralField]
  %t293 = getelementptr [1 x %StructLiteralField], [1 x %StructLiteralField]* %t292, i32 0, i32 0
  %t294 = getelementptr %StructLiteralField, %StructLiteralField* %t293, i64 0
  store %StructLiteralField %t291, %StructLiteralField* %t294
  %t295 = alloca { %StructLiteralField*, i64 }
  %t296 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t295, i32 0, i32 0
  store %StructLiteralField* %t293, %StructLiteralField** %t296
  %t297 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t295, i32 0, i32 1
  store i64 1, i64* %t297
  %t298 = call double @fieldsconcat({ %StructLiteralField*, i64 }* %t295)
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %loop.latch16
merge19:
  %t299 = load i8*, i8** %l20
  %t300 = load double, double* %l21
  %t301 = call double @substring(i8* %t299, i64 0, double %t300)
  %t302 = call i8* @trim_text(i8* null)
  store i8* %t302, i8** %l23
  %t303 = load i8*, i8** %l20
  %t304 = load double, double* %l21
  %t305 = sitofp i64 1 to double
  %t306 = fadd double %t304, %t305
  %t307 = load i8*, i8** %l20
  store double 0.0, double* %l24
  %t308 = load i8*, i8** %l23
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t310 = load i8*, i8** %l23
  %t311 = call i1 @string_array_contains({ i8**, i64 }* %t309, i8* %t310)
  %t312 = load i8*, i8** %l0
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t314 = load i8, i8* %l2
  %t315 = load double, double* %l3
  %t316 = load i8*, i8** %l4
  %t317 = load double, double* %l5
  %t318 = load double, double* %l6
  %t319 = load double, double* %l7
  %t320 = load double, double* %l8
  %t321 = load double, double* %l9
  %t322 = load i1, i1* %l12
  %t323 = load double, double* %l13
  %t324 = load i8*, i8** %l14
  %t325 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t326 = load double, double* %l16
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t329 = load double, double* %l19
  %t330 = load i8*, i8** %l20
  %t331 = load double, double* %l21
  %t332 = load i8*, i8** %l23
  %t333 = load double, double* %l24
  br i1 %t311, label %then22, label %merge23
then22:
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s335 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.335, i32 0, i32 0
  %t336 = load i8*, i8** %l23
  %t337 = add i8* %s335, %t336
  %s338 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.338, i32 0, i32 0
  %t339 = add i8* %t337, %s338
  %t340 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t334, i8* %t339)
  store { i8**, i64 }* %t340, { i8**, i64 }** %l1
  br label %loop.latch16
merge23:
  %t341 = load double, double* %l24
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t343 = load i8*, i8** %l23
  %t344 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t342, i8* %t343)
  store { i8**, i64 }* %t344, { i8**, i64 }** %l18
  %t345 = load i8*, i8** %l23
  %t346 = insertvalue %StructLiteralField undef, i8* %t345, 0
  %t347 = load double, double* %l24
  %t348 = insertvalue %StructLiteralField %t346, i8* null, 1
  %t349 = alloca [1 x %StructLiteralField]
  %t350 = getelementptr [1 x %StructLiteralField], [1 x %StructLiteralField]* %t349, i32 0, i32 0
  %t351 = getelementptr %StructLiteralField, %StructLiteralField* %t350, i64 0
  store %StructLiteralField %t348, %StructLiteralField* %t351
  %t352 = alloca { %StructLiteralField*, i64 }
  %t353 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t352, i32 0, i32 0
  store %StructLiteralField* %t350, %StructLiteralField** %t353
  %t354 = getelementptr { %StructLiteralField*, i64 }, { %StructLiteralField*, i64 }* %t352, i32 0, i32 1
  store i64 1, i64* %t354
  %t355 = call double @fieldsconcat({ %StructLiteralField*, i64 }* %t352)
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %loop.latch16
loop.latch16:
  %t356 = load double, double* %l19
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l18
  %t359 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %t364 = phi { i8**, i64 }* [ %t284, %then12 ], [ %t166, %entry ]
  %t365 = phi { %StructLiteralField*, i64 }* [ null, %then12 ], [ %t178, %entry ]
  %t366 = phi { i8**, i64 }* [ %t340, %then12 ], [ %t166, %entry ]
  %t367 = phi { %StructLiteralField*, i64 }* [ null, %then12 ], [ %t178, %entry ]
  store { i8**, i64 }* %t364, { i8**, i64 }** %l1
  store { %StructLiteralField*, i64 }* %t365, { %StructLiteralField*, i64 }** %l15
  store { i8**, i64 }* %t366, { i8**, i64 }** %l1
  store { %StructLiteralField*, i64 }* %t367, { %StructLiteralField*, i64 }** %l15
  %t369 = load i1, i1* %l12
  br label %logical_and_entry_368

logical_and_entry_368:
  br i1 %t369, label %logical_and_right_368, label %logical_and_merge_368

logical_and_right_368:
  %t370 = load double, double* %l13
  %t371 = sitofp i64 0 to double
  %t372 = fcmp oge double %t370, %t371
  br label %logical_and_right_end_368

logical_and_right_end_368:
  br label %logical_and_merge_368

logical_and_merge_368:
  %t373 = phi i1 [ false, %logical_and_entry_368 ], [ %t372, %logical_and_right_end_368 ]
  %t374 = xor i1 %t373, 1
  %t375 = load i8*, i8** %l0
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t377 = load i8, i8* %l2
  %t378 = load double, double* %l3
  %t379 = load i8*, i8** %l4
  %t380 = load double, double* %l5
  %t381 = load double, double* %l6
  %t382 = load double, double* %l7
  %t383 = load double, double* %l8
  %t384 = load double, double* %l9
  %t385 = load i1, i1* %l12
  %t386 = load double, double* %l13
  %t387 = load i8*, i8** %l14
  %t388 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br i1 %t374, label %then24, label %merge25
then24:
  %t389 = load i8*, i8** %l0
  %t390 = load double, double* %l13
  %t391 = sitofp i64 1 to double
  %t392 = fadd double %t390, %t391
  %t393 = load i8*, i8** %l0
  store double 0.0, double* %l25
  %t394 = load double, double* %l25
  br label %merge25
merge25:
  %t395 = load i1, i1* %l12
  %t396 = load i8*, i8** %l0
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t398 = load i8, i8* %l2
  %t399 = load double, double* %l3
  %t400 = load i8*, i8** %l4
  %t401 = load double, double* %l5
  %t402 = load double, double* %l6
  %t403 = load double, double* %l7
  %t404 = load double, double* %l8
  %t405 = load double, double* %l9
  %t406 = load i1, i1* %l12
  %t407 = load double, double* %l13
  %t408 = load i8*, i8** %l14
  %t409 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  br i1 %t395, label %then26, label %merge27
then26:
  %t410 = alloca [0 x double]
  %t411 = getelementptr [0 x double], [0 x double]* %t410, i32 0, i32 0
  %t412 = alloca { double*, i64 }
  %t413 = getelementptr { double*, i64 }, { double*, i64 }* %t412, i32 0, i32 0
  store double* %t411, double** %t413
  %t414 = getelementptr { double*, i64 }, { double*, i64 }* %t412, i32 0, i32 1
  store i64 0, i64* %t414
  store { %StructLiteralField*, i64 }* null, { %StructLiteralField*, i64 }** %l15
  br label %merge27
merge27:
  %t415 = phi { %StructLiteralField*, i64 }* [ null, %then26 ], [ %t409, %entry ]
  store { %StructLiteralField*, i64 }* %t415, { %StructLiteralField*, i64 }** %l15
  %t416 = insertvalue %EnumLiteralParse undef, i1 1, 0
  %t417 = load i1, i1* %l12
  %t418 = xor i1 %t417, 1
  %t419 = insertvalue %EnumLiteralParse %t416, i1 %t418, 1
  %t420 = load i8*, i8** %l4
  %t421 = insertvalue %EnumLiteralParse %t419, i8* %t420, 2
  %t422 = load i8*, i8** %l14
  %t423 = insertvalue %EnumLiteralParse %t421, i8* %t422, 3
  %t424 = load { %StructLiteralField*, i64 }*, { %StructLiteralField*, i64 }** %l15
  %t425 = insertvalue %EnumLiteralParse %t423, { i8**, i64 }* null, 4
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t427 = insertvalue %EnumLiteralParse %t425, { i8**, i64 }* %t426, 5
  ret %EnumLiteralParse %t427
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
  %t157 = phi { i8**, i64 }* [ %t17, %entry ], [ %t151, %loop.latch2 ]
  %t158 = phi { i8**, i64 }* [ %t18, %entry ], [ %t152, %loop.latch2 ]
  %t159 = phi double [ %t19, %entry ], [ %t153, %loop.latch2 ]
  %t160 = phi { %StringConstant*, i64 }* [ %t20, %entry ], [ %t154, %loop.latch2 ]
  %t161 = phi i8* [ %t23, %entry ], [ %t155, %loop.latch2 ]
  %t162 = phi double [ %t24, %entry ], [ %t156, %loop.latch2 ]
  store { i8**, i64 }* %t157, { i8**, i64 }** %l0
  store { i8**, i64 }* %t158, { i8**, i64 }** %l1
  store double %t159, double* %l2
  store { %StringConstant*, i64 }* %t160, { %StringConstant*, i64 }** %l3
  store i8* %t161, i8** %l6
  store double %t162, double* %l7
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
  %t55 = phi double [ %t40, %loop.body1 ], [ %t54, %loop.latch6 ]
  store double %t55, double* %l10
  br label %loop.body5
loop.body5:
  %t41 = load double, double* %l10
  %t42 = extractvalue %StructLiteralParse %parse, 3
  %t43 = extractvalue %StructLiteralParse %parse, 3
  %t44 = load double, double* %l10
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr i8*, i8** %t46, i64 %t44
  %t50 = load i8*, i8** %t49
  %t51 = load double, double* %l10
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l10
  br label %loop.latch6
loop.latch6:
  %t54 = load double, double* %l10
  br label %loop.header4
afterloop7:
  store i8* null, i8** %l11
  %t56 = load double, double* %l9
  %t57 = sitofp i64 0 to double
  %t58 = fcmp oge double %t56, %t57
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  %t62 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t63 = load double, double* %l4
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t65 = load i8*, i8** %l6
  %t66 = load double, double* %l7
  %t67 = load double, double* %l8
  %t68 = load double, double* %l9
  %t69 = load double, double* %l10
  %t70 = load i8*, i8** %l11
  br i1 %t58, label %then8, label %else9
then8:
  %t71 = extractvalue %StructLiteralParse %parse, 3
  %t72 = load double, double* %l9
  %t73 = load { i8**, i64 }, { i8**, i64 }* %t71
  %t74 = extractvalue { i8**, i64 } %t73, 0
  %t75 = extractvalue { i8**, i64 } %t73, 1
  %t76 = icmp uge i64 %t72, %t75
  ; bounds check: %t76 (if true, out of bounds)
  %t77 = getelementptr i8*, i8** %t74, i64 %t72
  %t78 = load i8*, i8** %t77
  store i8* %t78, i8** %l12
  %t79 = load i8*, i8** %l12
  %t80 = load double, double* %l2
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l13
  %t82 = load double, double* %l13
  %t83 = load double, double* %l13
  %t84 = load double, double* %l13
  %t85 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t86 = load double, double* %l13
  %t87 = load double, double* %l13
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t89 = load double, double* %l8
  br label %merge10
else9:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s91 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.91, i32 0, i32 0
  %t92 = load double, double* %l4
  br label %merge10
merge10:
  %t93 = phi { i8**, i64 }* [ null, %then8 ], [ null, %else9 ]
  %t94 = phi { i8**, i64 }* [ null, %then8 ], [ %t60, %else9 ]
  %t95 = phi double [ 0.0, %then8 ], [ %t61, %else9 ]
  %t96 = phi { %StringConstant*, i64 }* [ null, %then8 ], [ %t62, %else9 ]
  store { i8**, i64 }* %t93, { i8**, i64 }** %l0
  store { i8**, i64 }* %t94, { i8**, i64 }** %l1
  store double %t95, double* %l2
  store { %StringConstant*, i64 }* %t96, { %StringConstant*, i64 }** %l3
  %t97 = load double, double* %l8
  store i8* null, i8** %l14
  %t98 = load i8*, i8** %l11
  %t99 = icmp ne i8* %t98, null
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t102 = load double, double* %l2
  %t103 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t104 = load double, double* %l4
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t106 = load i8*, i8** %l6
  %t107 = load double, double* %l7
  %t108 = load double, double* %l8
  %t109 = load double, double* %l9
  %t110 = load double, double* %l10
  %t111 = load i8*, i8** %l11
  %t112 = load i8*, i8** %l14
  br i1 %t99, label %then11, label %merge12
then11:
  %t113 = load i8*, i8** %l11
  br label %merge12
merge12:
  %t114 = phi i8* [ null, %then11 ], [ %t112, %loop.body1 ]
  store i8* %t114, i8** %l14
  %s115 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.115, i32 0, i32 0
  store i8* %s115, i8** %l15
  %t116 = load double, double* %l7
  %t117 = sitofp i64 0 to double
  %t118 = fcmp ogt double %t116, %t117
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load double, double* %l2
  %t122 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t123 = load double, double* %l4
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t125 = load i8*, i8** %l6
  %t126 = load double, double* %l7
  %t127 = load double, double* %l8
  %t128 = load double, double* %l9
  %t129 = load double, double* %l10
  %t130 = load i8*, i8** %l11
  %t131 = load i8*, i8** %l14
  %t132 = load i8*, i8** %l15
  br i1 %t118, label %then13, label %merge14
then13:
  %t133 = load i8*, i8** %l6
  store i8* %t133, i8** %l15
  br label %merge14
merge14:
  %t134 = phi i8* [ %t133, %then13 ], [ %t132, %loop.body1 ]
  store i8* %t134, i8** %l15
  %t135 = load double, double* %l2
  %t136 = call i8* @format_temp_name(double %t135)
  store i8* %t136, i8** %l16
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s138 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.138, i32 0, i32 0
  %t139 = load i8*, i8** %l16
  %t140 = add i8* %s138, %t139
  %s141 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.141, i32 0, i32 0
  %t142 = add i8* %t140, %s141
  %t143 = load double, double* %l4
  %t144 = load double, double* %l2
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l2
  %t147 = load i8*, i8** %l16
  store i8* %t147, i8** %l6
  %t148 = load double, double* %l7
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l7
  br label %loop.latch2
loop.latch2:
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t153 = load double, double* %l2
  %t154 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t155 = load i8*, i8** %l6
  %t156 = load double, double* %l7
  br label %loop.header0
afterloop3:
  %t163 = sitofp i64 0 to double
  store double %t163, double* %l17
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t166 = load double, double* %l2
  %t167 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t168 = load double, double* %l4
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t170 = load i8*, i8** %l6
  %t171 = load double, double* %l7
  %t172 = load double, double* %l17
  br label %loop.header15
loop.header15:
  %t189 = phi double [ %t172, %entry ], [ %t188, %loop.latch17 ]
  store double %t189, double* %l17
  br label %loop.body16
loop.body16:
  %t173 = load double, double* %l17
  %t174 = extractvalue %StructLiteralParse %parse, 3
  %t175 = extractvalue %StructLiteralParse %parse, 3
  %t176 = load double, double* %l17
  %t177 = load { i8**, i64 }, { i8**, i64 }* %t175
  %t178 = extractvalue { i8**, i64 } %t177, 0
  %t179 = extractvalue { i8**, i64 } %t177, 1
  %t180 = icmp uge i64 %t176, %t179
  ; bounds check: %t180 (if true, out of bounds)
  %t181 = getelementptr i8*, i8** %t178, i64 %t176
  %t182 = load i8*, i8** %t181
  store i8* %t182, i8** %l18
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t184 = load i8*, i8** %l18
  %t185 = load double, double* %l17
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  store double %t187, double* %l17
  br label %loop.latch17
loop.latch17:
  %t188 = load double, double* %l17
  br label %loop.header15
afterloop18:
  %t190 = load i8*, i8** %l6
  %t191 = load double, double* %l4
  %t192 = insertvalue %LLVMOperand undef, i8* null, 0
  %t193 = load i8*, i8** %l6
  %t194 = insertvalue %LLVMOperand %t192, i8* %t193, 1
  store %LLVMOperand %t194, %LLVMOperand* %l19
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t196 = insertvalue %ExpressionResult undef, { i8**, i64 }* %t195, 0
  %t197 = load double, double* %l2
  %t198 = insertvalue %ExpressionResult %t196, double %t197, 1
  %t199 = load %LLVMOperand, %LLVMOperand* %l19
  %t200 = insertvalue %ExpressionResult %t198, i8* null, 2
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = insertvalue %ExpressionResult %t200, { i8**, i64 }* %t201, 3
  %t203 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l3
  %t204 = insertvalue %ExpressionResult %t202, { i8**, i64 }* null, 4
  ret %ExpressionResult %t204
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
  %t21 = phi double [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store double 0.0, double* %l2
  %t16 = load double, double* %l2
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t22
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
  %t66 = phi double [ %t48, %entry ], [ %t65, %loop.latch6 ]
  store double %t66, double* %l6
  br label %loop.body5
loop.body5:
  %t50 = load double, double* %l6
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l6
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t52
  %t55 = extractvalue { i8**, i64 } %t54, 0
  %t56 = extractvalue { i8**, i64 } %t54, 1
  %t57 = icmp uge i64 %t53, %t56
  ; bounds check: %t57 (if true, out of bounds)
  %t58 = getelementptr i8*, i8** %t55, i64 %t53
  %t59 = load i8*, i8** %t58
  %t60 = call i8* @trim_text(i8* %t59)
  store i8* %t60, i8** %l9
  %t61 = load i8*, i8** %l9
  %t62 = load double, double* %l6
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l6
  br label %loop.latch6
loop.latch6:
  %t65 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l8
  ret { i8**, i64 }* %t67
}

define %ArrayLiteralMetadata @parse_array_literal_metadata({ i8**, i64 }* %entries, %TypeContext %context) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t1 = extractvalue { i8**, i64 } %t0, 0
  %t2 = extractvalue { i8**, i64 } %t0, 1
  %t3 = icmp uge i64 0, %t2
  ; bounds check: %t3 (if true, out of bounds)
  %t4 = getelementptr i8*, i8** %t1, i64 0
  %t5 = load i8*, i8** %t4
  %t6 = call i8* @trim_text(i8* %t5)
  store i8* %t6, i8** %l0
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call double @substring(i8* %t8, i64 0, i64 9)
  store double %t9, double* %l1
  %t10 = load double, double* %l1
  %s11 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  store double 0.0, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = call i8* @map_metadata_annotation(%TypeContext %context, i8* null)
  store i8* %t16, i8** %l3
  %t17 = load i8*, i8** %l3
  %t18 = insertvalue %ArrayLiteralMetadata undef, i8* %t17, 0
  %t19 = sitofp i64 1 to double
  %t20 = insertvalue %ArrayLiteralMetadata %t18, double %t19, 1
  ret %ArrayLiteralMetadata %t20
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
  %t34 = phi { %LifetimeRegionMetadata*, i64 }* [ %t6, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t7, %entry ], [ %t33, %loop.latch2 ]
  store { %LifetimeRegionMetadata*, i64 }* %t34, { %LifetimeRegionMetadata*, i64 }** %l0
  store double %t35, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %LifetimeRegionMetadata*, i64 }, { %LifetimeRegionMetadata*, i64 }* %regions
  %t11 = extractvalue { %LifetimeRegionMetadata*, i64 } %t10, 0
  %t12 = extractvalue { %LifetimeRegionMetadata*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t11, i64 %t9
  %t15 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %t14
  store %LifetimeRegionMetadata %t15, %LifetimeRegionMetadata* %l2
  %t16 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l2
  %t17 = extractvalue %LifetimeRegionMetadata %t16, 0
  %t18 = fcmp oeq double %t17, %region_id
  %t19 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l2
  br i1 %t18, label %then4, label %else5
then4:
  store double 0.0, double* %l3
  %t22 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t23 = load double, double* %l3
  %t24 = call { %LifetimeRegionMetadata*, i64 }* @append_lifetime_region({ %LifetimeRegionMetadata*, i64 }* %t22, %LifetimeRegionMetadata zeroinitializer)
  store { %LifetimeRegionMetadata*, i64 }* %t24, { %LifetimeRegionMetadata*, i64 }** %l0
  br label %merge6
else5:
  %t25 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t26 = load %LifetimeRegionMetadata, %LifetimeRegionMetadata* %l2
  %t27 = call { %LifetimeRegionMetadata*, i64 }* @append_lifetime_region({ %LifetimeRegionMetadata*, i64 }* %t25, %LifetimeRegionMetadata %t26)
  store { %LifetimeRegionMetadata*, i64 }* %t27, { %LifetimeRegionMetadata*, i64 }** %l0
  br label %merge6
merge6:
  %t28 = phi { %LifetimeRegionMetadata*, i64 }* [ %t24, %then4 ], [ %t27, %else5 ]
  store { %LifetimeRegionMetadata*, i64 }* %t28, { %LifetimeRegionMetadata*, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t36 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  ret { %LifetimeRegionMetadata*, i64 }* %t36
}

define { %LifetimeRegionMetadata*, i64 }* @apply_lifetime_release_events({ %LifetimeRegionMetadata*, i64 }* %regions, { %LifetimeReleaseEvent*, i64 }* %releases) {
entry:
  %l0 = alloca { %LifetimeRegionMetadata*, i64 }*
  %l1 = alloca double
  %l2 = alloca %LifetimeReleaseEvent
  store { %LifetimeRegionMetadata*, i64 }* %regions, { %LifetimeRegionMetadata*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi { %LifetimeRegionMetadata*, i64 }* [ %t1, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t2, %entry ], [ %t23, %loop.latch2 ]
  store { %LifetimeRegionMetadata*, i64 }* %t24, { %LifetimeRegionMetadata*, i64 }** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { %LifetimeReleaseEvent*, i64 }, { %LifetimeReleaseEvent*, i64 }* %releases
  %t6 = extractvalue { %LifetimeReleaseEvent*, i64 } %t5, 0
  %t7 = extractvalue { %LifetimeReleaseEvent*, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr %LifetimeReleaseEvent, %LifetimeReleaseEvent* %t6, i64 %t4
  %t10 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %t9
  store %LifetimeReleaseEvent %t10, %LifetimeReleaseEvent* %l2
  %t11 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t12 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %l2
  %t13 = extractvalue %LifetimeReleaseEvent %t12, 0
  %t14 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %l2
  %t15 = extractvalue %LifetimeReleaseEvent %t14, 1
  %t16 = load %LifetimeReleaseEvent, %LifetimeReleaseEvent* %l2
  %t17 = extractvalue %LifetimeReleaseEvent %t16, 2
  %t18 = call { %LifetimeRegionMetadata*, i64 }* @mark_lifetime_region_released({ %LifetimeRegionMetadata*, i64 }* %t11, double %t13, i8* %t15, double %t17)
  store { %LifetimeRegionMetadata*, i64 }* %t18, { %LifetimeRegionMetadata*, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load { %LifetimeRegionMetadata*, i64 }*, { %LifetimeRegionMetadata*, i64 }** %l0
  ret { %LifetimeRegionMetadata*, i64 }* %t26
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
  %t30 = phi { %LLVMOperand*, i64 }* [ %t6, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store { %LLVMOperand*, i64 }* %t30, { %LLVMOperand*, i64 }** %l0
  store double %t31, double* %l1
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
  %t16 = load double, double* %l1
  %t17 = load { %LLVMOperand*, i64 }, { %LLVMOperand*, i64 }* %values
  %t18 = extractvalue { %LLVMOperand*, i64 } %t17, 0
  %t19 = extractvalue { %LLVMOperand*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %LLVMOperand, %LLVMOperand* %t18, i64 %t16
  %t22 = load %LLVMOperand, %LLVMOperand* %t21
  %t23 = call { %LLVMOperand*, i64 }* @append_llvm_operand({ %LLVMOperand*, i64 }* %t15, %LLVMOperand %t22)
  store { %LLVMOperand*, i64 }* %t23, { %LLVMOperand*, i64 }** %l0
  br label %merge6
merge6:
  %t24 = phi { %LLVMOperand*, i64 }* [ %t14, %then4 ], [ %t23, %else5 ]
  store { %LLVMOperand*, i64 }* %t24, { %LLVMOperand*, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { %LLVMOperand*, i64 }*, { %LLVMOperand*, i64 }** %l0
  ret { %LLVMOperand*, i64 }* %t32
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
  %t16 = phi double [ %t1, %entry ], [ %t15, %loop.latch2 ]
  store double %t16, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  %t10 = icmp eq i8* %t9, %target
  %t11 = load double, double* %l0
  br i1 %t10, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load double, double* %l0
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
  %t27 = phi { %ParameterBinding*, i64 }* [ %t6, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store { %ParameterBinding*, i64 }* %t27, { %ParameterBinding*, i64 }** %l0
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %ParameterBinding*, i64 }, { %ParameterBinding*, i64 }* %first
  %t11 = extractvalue { %ParameterBinding*, i64 } %t10, 0
  %t12 = extractvalue { %ParameterBinding*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %ParameterBinding, %ParameterBinding* %t11, i64 %t9
  %t15 = load %ParameterBinding, %ParameterBinding* %t14
  store %ParameterBinding %t15, %ParameterBinding* %l2
  %t16 = load %ParameterBinding, %ParameterBinding* %l2
  %t17 = extractvalue %ParameterBinding %t16, 4
  store i1 %t17, i1* %l3
  %t18 = load %ParameterBinding, %ParameterBinding* %l2
  %t19 = extractvalue %ParameterBinding %t18, 0
  %t20 = call double @find_parameter_binding({ %ParameterBinding*, i64 }* %second, i8* %t19)
  store double %t20, double* %l4
  %t21 = load double, double* %l4
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load { %ParameterBinding*, i64 }*, { %ParameterBinding*, i64 }** %l0
  ret { %ParameterBinding*, i64 }* %t29
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
  %t1 = extractvalue { i8**, i64 } %t0, 0
  %t2 = extractvalue { i8**, i64 } %t0, 1
  %t3 = icmp uge i64 0, %t2
  ; bounds check: %t3 (if true, out of bounds)
  %t4 = getelementptr i8*, i8** %t1, i64 0
  %t5 = load i8*, i8** %t4
  store i8* %t5, i8** %l0
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi i8* [ %t7, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t8, %entry ], [ %t24, %loop.latch2 ]
  store i8* %t25, i8** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %t10, %separator
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %values
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = add i8* %t11, %t18
  store i8* %t19, i8** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load i8*, i8** %l0
  ret i8* %t27
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
  %t20 = phi double [ %t2, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { %StringConstant*, i64 }, { %StringConstant*, i64 }* %new_constants
  %t6 = extractvalue { %StringConstant*, i64 } %t5, 0
  %t7 = extractvalue { %StringConstant*, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr %StringConstant, %StringConstant* %t6, i64 %t4
  %t10 = load %StringConstant, %StringConstant* %t9
  store %StringConstant %t10, %StringConstant* %l2
  %t11 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  %t12 = load %StringConstant, %StringConstant* %l2
  %t13 = extractvalue %StringConstant %t12, 1
  %t14 = call double @find_string_constant({ %StringConstant*, i64 }* %t11, i8* %t13)
  store double %t14, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = load { %StringConstant*, i64 }*, { %StringConstant*, i64 }** %l0
  ret { %StringConstant*, i64 }* %t21
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
  %t44 = phi { i8**, i64 }* [ %t6, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t7, %entry ], [ %t43, %loop.latch2 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { %StringConstant*, i64 }, { %StringConstant*, i64 }* %constants
  %t11 = extractvalue { %StringConstant*, i64 } %t10, 0
  %t12 = extractvalue { %StringConstant*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %StringConstant, %StringConstant* %t11, i64 %t9
  %t15 = load %StringConstant, %StringConstant* %t14
  store %StringConstant %t15, %StringConstant* %l2
  %t16 = load %StringConstant, %StringConstant* %l2
  %t17 = extractvalue %StringConstant %t16, 1
  %t18 = call i8* @escape_string_for_llvm(i8* %t17)
  store i8* %t18, i8** %l3
  %t19 = load %StringConstant, %StringConstant* %l2
  %t20 = extractvalue %StringConstant %t19, 2
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  %t23 = call i8* @number_to_string(double %t22)
  store i8* %t23, i8** %l4
  %t24 = load %StringConstant, %StringConstant* %l2
  %t25 = extractvalue %StringConstant %t24, 0
  %s26 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.26, i32 0, i32 0
  %t27 = add i8* %t25, %s26
  %t28 = load i8*, i8** %l4
  %t29 = add i8* %t27, %t28
  %s30 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %t29, %s30
  %t32 = load i8*, i8** %l3
  %t33 = add i8* %t31, %t32
  %s34 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.34, i32 0, i32 0
  %t35 = add i8* %t33, %s34
  store i8* %t35, i8** %l5
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l5
  %t38 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t36, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t46
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
