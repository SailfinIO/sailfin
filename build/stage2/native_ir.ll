; ModuleID = 'sailfin'
source_filename = "sailfin"

%NativeSourceSpan = type { double, double, double, double }
%NativeParameter = type { i8*, i8*, i1, i8*, i8* }
%NativeFunction = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%NativeImportSpecifier = type { i8*, i8* }
%NativeImport = type { i8*, i8*, { i8**, i64 }* }
%NativeStructField = type { i8*, i8*, i1 }
%NativeStructLayoutField = type { i8*, i8*, double, double, double }
%NativeStructLayout = type { double, double, { i8**, i64 }* }
%NativeStruct = type { i8*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, i8* }
%NativeInterfaceSignature = type { i8*, i1, { i8**, i64 }*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%NativeInterface = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%NativeEnumVariantField = type { i8*, i8*, i1 }
%NativeEnumVariant = type { i8*, { i8**, i64 }* }
%NativeEnumVariantLayout = type { i8*, double, double, double, double, { i8**, i64 }* }
%NativeEnumLayout = type { double, double, i8*, double, double, { i8**, i64 }* }
%NativeEnum = type { i8*, { i8**, i64 }*, i8* }
%NativeBinding = type { i8*, i1, i8*, i8* }
%EnumParseResult = type { i8*, double, { i8**, i64 }* }
%CaseComponents = type { i8*, i8* }
%InstructionParseResult = type { { i8**, i64 }*, i1, i1 }
%InstructionGatherResult = type { i8*, double }
%InstructionDepthState = type { double, double, double, i1, i1 }
%StructParseResult = type { i8*, double, { i8**, i64 }* }
%InterfaceParseResult = type { i8*, double, { i8**, i64 }* }
%InterfaceSignatureParse = type { i1, i8*, { i8**, i64 }* }
%StructHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%InterfaceHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%HeaderNameParse = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%StructLayoutHeaderParse = type { i1, i8*, double, double, { i8**, i64 }* }
%StructLayoutFieldParse = type { i1, i8*, { i8**, i64 }* }
%ParseNativeResult = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%EnumLayoutHeaderParse = type { i1, i8*, double, double, i8*, double, double, { i8**, i64 }* }
%EnumLayoutVariantParse = type { i1, i8*, { i8**, i64 }* }
%EnumLayoutPayloadParse = type { i1, i8*, i8*, { i8**, i64 }* }
%NumberParseResult = type { i1, double }
%LayoutManifest = type { { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%BindingComponents = type { i8*, i8*, i8* }
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

%NativeInstruction = type { i32, [48 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.8 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.14 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.20 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.265 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.24 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.61 = private unnamed_addr constant [1 x i8] c"\00"
@.str.25 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [1 x i8] c"\00"
@.str.80 = private unnamed_addr constant [1 x i8] c"\00"
@.str.31 = private unnamed_addr constant [1 x i8] c"\00"
@.str.32 = private unnamed_addr constant [1 x i8] c"\00"
@.str.114 = private unnamed_addr constant [1 x i8] c"\00"
@.str.41 = private unnamed_addr constant [1 x i8] c"\00"

define %ParseNativeResult @parse_native_artifact(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeFunction*, i64 }*
  %l3 = alloca { %NativeImport*, i64 }*
  %l4 = alloca { %NativeStruct*, i64 }*
  %l5 = alloca { %NativeInterface*, i64 }*
  %l6 = alloca { %NativeEnum*, i64 }*
  %l7 = alloca { %NativeBinding*, i64 }*
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %StructParseResult
  %l18 = alloca %InterfaceParseResult
  %l19 = alloca %EnumParseResult
  %l20 = alloca i8*
  %l21 = alloca double
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca { i8**, i64 }*
  %l25 = alloca double
  %l26 = alloca i1
  %l27 = alloca i8*
  %l28 = alloca i8*
  %l29 = alloca double
  %l30 = alloca %InstructionGatherResult
  %l31 = alloca %InstructionParseResult
  %l32 = alloca { i8**, i64 }*
  %l33 = alloca double
  %t0 = call { i8**, i64 }* @split_lines(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = alloca [0 x %NativeFunction]
  %t7 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t6, i32 0, i32 0
  %t8 = alloca { %NativeFunction*, i64 }
  %t9 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t8, i32 0, i32 0
  store %NativeFunction* %t7, %NativeFunction** %t9
  %t10 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %NativeFunction*, i64 }* %t8, { %NativeFunction*, i64 }** %l2
  %t11 = alloca [0 x %NativeImport]
  %t12 = getelementptr [0 x %NativeImport], [0 x %NativeImport]* %t11, i32 0, i32 0
  %t13 = alloca { %NativeImport*, i64 }
  %t14 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t13, i32 0, i32 0
  store %NativeImport* %t12, %NativeImport** %t14
  %t15 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %NativeImport*, i64 }* %t13, { %NativeImport*, i64 }** %l3
  %t16 = alloca [0 x %NativeStruct]
  %t17 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* %t16, i32 0, i32 0
  %t18 = alloca { %NativeStruct*, i64 }
  %t19 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t18, i32 0, i32 0
  store %NativeStruct* %t17, %NativeStruct** %t19
  %t20 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %NativeStruct*, i64 }* %t18, { %NativeStruct*, i64 }** %l4
  %t21 = alloca [0 x %NativeInterface]
  %t22 = getelementptr [0 x %NativeInterface], [0 x %NativeInterface]* %t21, i32 0, i32 0
  %t23 = alloca { %NativeInterface*, i64 }
  %t24 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t23, i32 0, i32 0
  store %NativeInterface* %t22, %NativeInterface** %t24
  %t25 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  store { %NativeInterface*, i64 }* %t23, { %NativeInterface*, i64 }** %l5
  %t26 = alloca [0 x %NativeEnum]
  %t27 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* %t26, i32 0, i32 0
  %t28 = alloca { %NativeEnum*, i64 }
  %t29 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t28, i32 0, i32 0
  store %NativeEnum* %t27, %NativeEnum** %t29
  %t30 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeEnum*, i64 }* %t28, { %NativeEnum*, i64 }** %l6
  %t31 = alloca [0 x %NativeBinding]
  %t32 = getelementptr [0 x %NativeBinding], [0 x %NativeBinding]* %t31, i32 0, i32 0
  %t33 = alloca { %NativeBinding*, i64 }
  %t34 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t33, i32 0, i32 0
  store %NativeBinding* %t32, %NativeBinding** %t34
  %t35 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %NativeBinding*, i64 }* %t33, { %NativeBinding*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l11
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t40 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t41 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t42 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t43 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t44 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t45 = load i8*, i8** %l8
  %t46 = load i8*, i8** %l9
  %t47 = load i8*, i8** %l10
  %t48 = load double, double* %l11
  br label %loop.header0
loop.header0:
  %t1035 = phi double [ %t48, %entry ], [ %t1026, %loop.latch2 ]
  %t1036 = phi { i8**, i64 }* [ %t38, %entry ], [ %t1027, %loop.latch2 ]
  %t1037 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t1028, %loop.latch2 ]
  %t1038 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t1029, %loop.latch2 ]
  %t1039 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t1030, %loop.latch2 ]
  %t1040 = phi i8* [ %t45, %entry ], [ %t1031, %loop.latch2 ]
  %t1041 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t1032, %loop.latch2 ]
  %t1042 = phi i8* [ %t46, %entry ], [ %t1033, %loop.latch2 ]
  %t1043 = phi i8* [ %t47, %entry ], [ %t1034, %loop.latch2 ]
  store double %t1035, double* %l11
  store { i8**, i64 }* %t1036, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t1037, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1038, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1039, { %NativeEnum*, i64 }** %l6
  store i8* %t1040, i8** %l8
  store { %NativeFunction*, i64 }* %t1041, { %NativeFunction*, i64 }** %l2
  store i8* %t1042, i8** %l9
  store i8* %t1043, i8** %l10
  br label %loop.body1
loop.body1:
  %t49 = load double, double* %l11
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t50
  %t52 = extractvalue { i8**, i64 } %t51, 1
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp oge double %t49, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t58 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t59 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t60 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t61 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t62 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t63 = load i8*, i8** %l8
  %t64 = load i8*, i8** %l9
  %t65 = load i8*, i8** %l10
  %t66 = load double, double* %l11
  br i1 %t54, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load double, double* %l11
  %t69 = fptosi double %t68 to i64
  %t70 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t71 = extractvalue { i8**, i64 } %t70, 0
  %t72 = extractvalue { i8**, i64 } %t70, 1
  %t73 = icmp uge i64 %t69, %t72
  ; bounds check: %t73 (if true, out of bounds)
  %t74 = getelementptr i8*, i8** %t71, i64 %t69
  %t75 = load i8*, i8** %t74
  store i8* %t75, i8** %l12
  %t76 = load i8*, i8** %l12
  %t77 = call i8* @trim_text(i8* %t76)
  store i8* %t77, i8** %l13
  %t78 = load i8*, i8** %l13
  %t79 = call i64 @sailfin_runtime_string_length(i8* %t78)
  %t80 = icmp eq i64 %t79, 0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t84 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t85 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t86 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t87 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t88 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t89 = load i8*, i8** %l8
  %t90 = load i8*, i8** %l9
  %t91 = load i8*, i8** %l10
  %t92 = load double, double* %l11
  %t93 = load i8*, i8** %l12
  %t94 = load i8*, i8** %l13
  br i1 %t80, label %then6, label %merge7
then6:
  %t95 = load double, double* %l11
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l11
  br label %loop.latch2
merge7:
  %t98 = load i8*, i8** %l13
  %t99 = call i1 @starts_with(i8* %t98, i8* null)
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t102 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t103 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t104 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t105 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t106 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t107 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t108 = load i8*, i8** %l8
  %t109 = load i8*, i8** %l9
  %t110 = load i8*, i8** %l10
  %t111 = load double, double* %l11
  %t112 = load i8*, i8** %l12
  %t113 = load i8*, i8** %l13
  br i1 %t99, label %then8, label %merge9
then8:
  %t114 = load double, double* %l11
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l11
  br label %loop.latch2
merge9:
  %t117 = load i8*, i8** %l13
  %s118 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.118, i32 0, i32 0
  %t119 = call i1 @starts_with(i8* %t117, i8* %s118)
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t123 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t124 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t125 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t126 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t127 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t128 = load i8*, i8** %l8
  %t129 = load i8*, i8** %l9
  %t130 = load i8*, i8** %l10
  %t131 = load double, double* %l11
  %t132 = load i8*, i8** %l12
  %t133 = load i8*, i8** %l13
  br i1 %t119, label %then10, label %merge11
then10:
  %t134 = load double, double* %l11
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l11
  br label %loop.latch2
merge11:
  %t137 = load i8*, i8** %l13
  %s138 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.138, i32 0, i32 0
  %t139 = call i1 @starts_with(i8* %t137, i8* %s138)
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t142 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t143 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t144 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t145 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t146 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t147 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t148 = load i8*, i8** %l8
  %t149 = load i8*, i8** %l9
  %t150 = load i8*, i8** %l10
  %t151 = load double, double* %l11
  %t152 = load i8*, i8** %l12
  %t153 = load i8*, i8** %l13
  br i1 %t139, label %then12, label %merge13
then12:
  %s154 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.154, i32 0, i32 0
  %t155 = load i8*, i8** %l13
  %s156 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.156, i32 0, i32 0
  %t157 = call i8* @strip_prefix(i8* %t155, i8* %s156)
  %t158 = call double @parse_import_entry(i8* %s154, i8* %t157)
  store double %t158, double* %l14
  %t159 = load double, double* %l14
  %t160 = load double, double* %l11
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l11
  br label %loop.latch2
merge13:
  %t163 = load i8*, i8** %l13
  %s164 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.164, i32 0, i32 0
  %t165 = call i1 @starts_with(i8* %t163, i8* %s164)
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t169 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t170 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t171 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t172 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t173 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t174 = load i8*, i8** %l8
  %t175 = load i8*, i8** %l9
  %t176 = load i8*, i8** %l10
  %t177 = load double, double* %l11
  %t178 = load i8*, i8** %l12
  %t179 = load i8*, i8** %l13
  br i1 %t165, label %then14, label %merge15
then14:
  %s180 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.180, i32 0, i32 0
  %t181 = load i8*, i8** %l13
  %s182 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.182, i32 0, i32 0
  %t183 = call i8* @strip_prefix(i8* %t181, i8* %s182)
  %t184 = call double @parse_import_entry(i8* %s180, i8* %t183)
  store double %t184, double* %l15
  %t185 = load double, double* %l15
  %t186 = load double, double* %l11
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  store double %t188, double* %l11
  br label %loop.latch2
merge15:
  %t189 = load i8*, i8** %l13
  %s190 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.190, i32 0, i32 0
  %t191 = call i1 @starts_with(i8* %t189, i8* %s190)
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t194 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t195 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t196 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t197 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t198 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t199 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t200 = load i8*, i8** %l8
  %t201 = load i8*, i8** %l9
  %t202 = load i8*, i8** %l10
  %t203 = load double, double* %l11
  %t204 = load i8*, i8** %l12
  %t205 = load i8*, i8** %l13
  br i1 %t191, label %then16, label %merge17
then16:
  %t206 = load i8*, i8** %l13
  %s207 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.207, i32 0, i32 0
  %t208 = call i8* @strip_prefix(i8* %t206, i8* %s207)
  %t209 = call double @parse_source_span(i8* %t208)
  store double %t209, double* %l16
  %t210 = load double, double* %l16
  %t211 = load double, double* %l11
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l11
  br label %loop.latch2
merge17:
  %t214 = load i8*, i8** %l13
  %t215 = load i8*, i8** %l13
  %s216 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.216, i32 0, i32 0
  %t217 = call i1 @starts_with(i8* %t215, i8* %s216)
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t221 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t222 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t223 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t224 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t225 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t226 = load i8*, i8** %l8
  %t227 = load i8*, i8** %l9
  %t228 = load i8*, i8** %l10
  %t229 = load double, double* %l11
  %t230 = load i8*, i8** %l12
  %t231 = load i8*, i8** %l13
  br i1 %t217, label %then18, label %merge19
then18:
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load double, double* %l11
  %t234 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t232, double %t233)
  store %StructParseResult %t234, %StructParseResult* %l17
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t236 = load %StructParseResult, %StructParseResult* %l17
  %t237 = extractvalue %StructParseResult %t236, 2
  %t238 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t235, { i8**, i64 }* %t237)
  store { i8**, i64 }* %t238, { i8**, i64 }** %l1
  %t239 = load %StructParseResult, %StructParseResult* %l17
  %t240 = extractvalue %StructParseResult %t239, 0
  %t241 = icmp ne i8* %t240, null
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t245 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t246 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t247 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t248 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t249 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t250 = load i8*, i8** %l8
  %t251 = load i8*, i8** %l9
  %t252 = load i8*, i8** %l10
  %t253 = load double, double* %l11
  %t254 = load i8*, i8** %l12
  %t255 = load i8*, i8** %l13
  %t256 = load %StructParseResult, %StructParseResult* %l17
  br i1 %t241, label %then20, label %merge21
then20:
  %t257 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t258 = load %StructParseResult, %StructParseResult* %l17
  %t259 = extractvalue %StructParseResult %t258, 0
  %t260 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t257, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t260, { %NativeStruct*, i64 }** %l4
  br label %merge21
merge21:
  %t261 = phi { %NativeStruct*, i64 }* [ %t260, %then20 ], [ %t246, %then18 ]
  store { %NativeStruct*, i64 }* %t261, { %NativeStruct*, i64 }** %l4
  %t262 = load %StructParseResult, %StructParseResult* %l17
  %t263 = extractvalue %StructParseResult %t262, 1
  store double %t263, double* %l11
  br label %loop.latch2
merge19:
  %t264 = load i8*, i8** %l13
  %s265 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.265, i32 0, i32 0
  %t266 = call i1 @starts_with(i8* %t264, i8* %s265)
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t270 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t271 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t272 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t273 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t274 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t275 = load i8*, i8** %l8
  %t276 = load i8*, i8** %l9
  %t277 = load i8*, i8** %l10
  %t278 = load double, double* %l11
  %t279 = load i8*, i8** %l12
  %t280 = load i8*, i8** %l13
  br i1 %t266, label %then22, label %merge23
then22:
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t282 = load double, double* %l11
  %t283 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t281, double %t282)
  store %InterfaceParseResult %t283, %InterfaceParseResult* %l18
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t285 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t286 = extractvalue %InterfaceParseResult %t285, 2
  %t287 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t284, { i8**, i64 }* %t286)
  store { i8**, i64 }* %t287, { i8**, i64 }** %l1
  %t288 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t289 = extractvalue %InterfaceParseResult %t288, 0
  %t290 = icmp ne i8* %t289, null
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t293 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t294 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t295 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t296 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t297 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t298 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t299 = load i8*, i8** %l8
  %t300 = load i8*, i8** %l9
  %t301 = load i8*, i8** %l10
  %t302 = load double, double* %l11
  %t303 = load i8*, i8** %l12
  %t304 = load i8*, i8** %l13
  %t305 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  br i1 %t290, label %then24, label %merge25
then24:
  %t306 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t307 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t308 = extractvalue %InterfaceParseResult %t307, 0
  %t309 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t306, %NativeInterface zeroinitializer)
  store { %NativeInterface*, i64 }* %t309, { %NativeInterface*, i64 }** %l5
  br label %merge25
merge25:
  %t310 = phi { %NativeInterface*, i64 }* [ %t309, %then24 ], [ %t296, %then22 ]
  store { %NativeInterface*, i64 }* %t310, { %NativeInterface*, i64 }** %l5
  %t311 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t312 = extractvalue %InterfaceParseResult %t311, 1
  store double %t312, double* %l11
  br label %loop.latch2
merge23:
  %t313 = load i8*, i8** %l13
  %s314 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.314, i32 0, i32 0
  %t315 = call i1 @starts_with(i8* %t313, i8* %s314)
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t318 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t319 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t320 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t321 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t322 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t323 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t324 = load i8*, i8** %l8
  %t325 = load i8*, i8** %l9
  %t326 = load i8*, i8** %l10
  %t327 = load double, double* %l11
  %t328 = load i8*, i8** %l12
  %t329 = load i8*, i8** %l13
  br i1 %t315, label %then26, label %merge27
then26:
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t331 = load double, double* %l11
  %t332 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t330, double %t331)
  store %EnumParseResult %t332, %EnumParseResult* %l19
  %t333 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t334 = load %EnumParseResult, %EnumParseResult* %l19
  %t335 = extractvalue %EnumParseResult %t334, 2
  %t336 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t333, { i8**, i64 }* %t335)
  store { i8**, i64 }* %t336, { i8**, i64 }** %l1
  %t337 = load %EnumParseResult, %EnumParseResult* %l19
  %t338 = extractvalue %EnumParseResult %t337, 0
  %t339 = icmp ne i8* %t338, null
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t342 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t343 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t344 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t345 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t346 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t347 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t348 = load i8*, i8** %l8
  %t349 = load i8*, i8** %l9
  %t350 = load i8*, i8** %l10
  %t351 = load double, double* %l11
  %t352 = load i8*, i8** %l12
  %t353 = load i8*, i8** %l13
  %t354 = load %EnumParseResult, %EnumParseResult* %l19
  br i1 %t339, label %then28, label %merge29
then28:
  %t355 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t356 = load %EnumParseResult, %EnumParseResult* %l19
  %t357 = extractvalue %EnumParseResult %t356, 0
  %t358 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t355, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t358, { %NativeEnum*, i64 }** %l6
  br label %merge29
merge29:
  %t359 = phi { %NativeEnum*, i64 }* [ %t358, %then28 ], [ %t346, %then26 ]
  store { %NativeEnum*, i64 }* %t359, { %NativeEnum*, i64 }** %l6
  %t360 = load %EnumParseResult, %EnumParseResult* %l19
  %t361 = extractvalue %EnumParseResult %t360, 1
  store double %t361, double* %l11
  br label %loop.latch2
merge27:
  %t362 = load i8*, i8** %l13
  %s363 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.363, i32 0, i32 0
  %t364 = call i1 @starts_with(i8* %t362, i8* %s363)
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t367 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t368 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t369 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t370 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t371 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t372 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t373 = load i8*, i8** %l8
  %t374 = load i8*, i8** %l9
  %t375 = load i8*, i8** %l10
  %t376 = load double, double* %l11
  %t377 = load i8*, i8** %l12
  %t378 = load i8*, i8** %l13
  br i1 %t364, label %then30, label %merge31
then30:
  %t379 = load i8*, i8** %l8
  %t380 = icmp ne i8* %t379, null
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t383 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t384 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t385 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t386 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t387 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t388 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t389 = load i8*, i8** %l8
  %t390 = load i8*, i8** %l9
  %t391 = load i8*, i8** %l10
  %t392 = load double, double* %l11
  %t393 = load i8*, i8** %l12
  %t394 = load i8*, i8** %l13
  br i1 %t380, label %then32, label %merge33
then32:
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s396 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.396, i32 0, i32 0
  %t397 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t395, i8* %s396)
  store { i8**, i64 }* %t397, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t398 = phi { i8**, i64 }* [ %t397, %then32 ], [ %t382, %then30 ]
  store { i8**, i64 }* %t398, { i8**, i64 }** %l1
  %t399 = load i8*, i8** %l13
  %s400 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.400, i32 0, i32 0
  %t401 = call i8* @strip_prefix(i8* %t399, i8* %s400)
  %t402 = call i8* @parse_function_name(i8* %t401)
  %t403 = insertvalue %NativeFunction undef, i8* %t402, 0
  %t404 = alloca [0 x i8*]
  %t405 = getelementptr [0 x i8*], [0 x i8*]* %t404, i32 0, i32 0
  %t406 = alloca { i8**, i64 }
  %t407 = getelementptr { i8**, i64 }, { i8**, i64 }* %t406, i32 0, i32 0
  store i8** %t405, i8*** %t407
  %t408 = getelementptr { i8**, i64 }, { i8**, i64 }* %t406, i32 0, i32 1
  store i64 0, i64* %t408
  %t409 = insertvalue %NativeFunction %t403, { i8**, i64 }* %t406, 1
  %s410 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.410, i32 0, i32 0
  %t411 = insertvalue %NativeFunction %t409, i8* %s410, 2
  %t412 = alloca [0 x i8*]
  %t413 = getelementptr [0 x i8*], [0 x i8*]* %t412, i32 0, i32 0
  %t414 = alloca { i8**, i64 }
  %t415 = getelementptr { i8**, i64 }, { i8**, i64 }* %t414, i32 0, i32 0
  store i8** %t413, i8*** %t415
  %t416 = getelementptr { i8**, i64 }, { i8**, i64 }* %t414, i32 0, i32 1
  store i64 0, i64* %t416
  %t417 = insertvalue %NativeFunction %t411, { i8**, i64 }* %t414, 3
  %t418 = alloca [0 x i8*]
  %t419 = getelementptr [0 x i8*], [0 x i8*]* %t418, i32 0, i32 0
  %t420 = alloca { i8**, i64 }
  %t421 = getelementptr { i8**, i64 }, { i8**, i64 }* %t420, i32 0, i32 0
  store i8** %t419, i8*** %t421
  %t422 = getelementptr { i8**, i64 }, { i8**, i64 }* %t420, i32 0, i32 1
  store i64 0, i64* %t422
  %t423 = insertvalue %NativeFunction %t417, { i8**, i64 }* %t420, 4
  store i8* null, i8** %l8
  %t424 = load double, double* %l11
  %t425 = sitofp i64 1 to double
  %t426 = fadd double %t424, %t425
  store double %t426, double* %l11
  br label %loop.latch2
merge31:
  %t427 = load i8*, i8** %l13
  %s428 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.428, i32 0, i32 0
  %t429 = call i1 @starts_with(i8* %t427, i8* %s428)
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t432 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t433 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t434 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t435 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t436 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t437 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t438 = load i8*, i8** %l8
  %t439 = load i8*, i8** %l9
  %t440 = load i8*, i8** %l10
  %t441 = load double, double* %l11
  %t442 = load i8*, i8** %l12
  %t443 = load i8*, i8** %l13
  br i1 %t429, label %then34, label %merge35
then34:
  %t444 = load i8*, i8** %l8
  %t445 = icmp eq i8* %t444, null
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t448 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t449 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t450 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t451 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t452 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t453 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t454 = load i8*, i8** %l8
  %t455 = load i8*, i8** %l9
  %t456 = load i8*, i8** %l10
  %t457 = load double, double* %l11
  %t458 = load i8*, i8** %l12
  %t459 = load i8*, i8** %l13
  br i1 %t445, label %then36, label %else37
then36:
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s461 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.461, i32 0, i32 0
  %t462 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t460, i8* %s461)
  store { i8**, i64 }* %t462, { i8**, i64 }** %l1
  br label %merge38
else37:
  %t463 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t464 = load i8*, i8** %l8
  %t465 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t463, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t465, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge38
merge38:
  %t466 = phi { i8**, i64 }* [ %t462, %then36 ], [ %t447, %else37 ]
  %t467 = phi { %NativeFunction*, i64 }* [ %t448, %then36 ], [ %t465, %else37 ]
  %t468 = phi i8* [ %t454, %then36 ], [ null, %else37 ]
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t467, { %NativeFunction*, i64 }** %l2
  store i8* %t468, i8** %l8
  %t469 = load double, double* %l11
  %t470 = sitofp i64 1 to double
  %t471 = fadd double %t469, %t470
  store double %t471, double* %l11
  br label %loop.latch2
merge35:
  %t472 = load i8*, i8** %l13
  %s473 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.473, i32 0, i32 0
  %t474 = call i1 @starts_with(i8* %t472, i8* %s473)
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t478 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t479 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t480 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t481 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t482 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t483 = load i8*, i8** %l8
  %t484 = load i8*, i8** %l9
  %t485 = load i8*, i8** %l10
  %t486 = load double, double* %l11
  %t487 = load i8*, i8** %l12
  %t488 = load i8*, i8** %l13
  br i1 %t474, label %then39, label %merge40
then39:
  %t489 = load i8*, i8** %l8
  %t490 = icmp ne i8* %t489, null
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t493 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t494 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t495 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t496 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t497 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t498 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t499 = load i8*, i8** %l8
  %t500 = load i8*, i8** %l9
  %t501 = load i8*, i8** %l10
  %t502 = load double, double* %l11
  %t503 = load i8*, i8** %l12
  %t504 = load i8*, i8** %l13
  br i1 %t490, label %then41, label %else42
then41:
  %t505 = load i8*, i8** %l8
  %t506 = load i8*, i8** %l13
  %s507 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.507, i32 0, i32 0
  %t508 = call i8* @strip_prefix(i8* %t506, i8* %s507)
  %t509 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t508)
  store i8* null, i8** %l8
  br label %merge43
else42:
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s511 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.511, i32 0, i32 0
  %t512 = load i8*, i8** %l13
  %t513 = add i8* %s511, %t512
  %t514 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t510, i8* %t513)
  store { i8**, i64 }* %t514, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t515 = phi i8* [ null, %then41 ], [ %t499, %else42 ]
  %t516 = phi { i8**, i64 }* [ %t492, %then41 ], [ %t514, %else42 ]
  store i8* %t515, i8** %l8
  store { i8**, i64 }* %t516, { i8**, i64 }** %l1
  %t517 = load double, double* %l11
  %t518 = sitofp i64 1 to double
  %t519 = fadd double %t517, %t518
  store double %t519, double* %l11
  br label %loop.latch2
merge40:
  %t520 = load i8*, i8** %l13
  %s521 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.521, i32 0, i32 0
  %t522 = call i1 @starts_with(i8* %t520, i8* %s521)
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t525 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t526 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t527 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t528 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t529 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t530 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t531 = load i8*, i8** %l8
  %t532 = load i8*, i8** %l9
  %t533 = load i8*, i8** %l10
  %t534 = load double, double* %l11
  %t535 = load i8*, i8** %l12
  %t536 = load i8*, i8** %l13
  br i1 %t522, label %then44, label %merge45
then44:
  %t537 = load i8*, i8** %l8
  %t538 = icmp ne i8* %t537, null
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t541 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t542 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t543 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t544 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t545 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t546 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t547 = load i8*, i8** %l8
  %t548 = load i8*, i8** %l9
  %t549 = load i8*, i8** %l10
  %t550 = load double, double* %l11
  %t551 = load i8*, i8** %l12
  %t552 = load i8*, i8** %l13
  br i1 %t538, label %then46, label %else47
then46:
  %t553 = load i8*, i8** %l13
  %s554 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.554, i32 0, i32 0
  %t555 = call i8* @strip_prefix(i8* %t553, i8* %s554)
  store i8* %t555, i8** %l20
  %t556 = load double, double* %l11
  %t557 = sitofp i64 1 to double
  %t558 = fadd double %t556, %t557
  store double %t558, double* %l21
  %t559 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t560 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t561 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t562 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t563 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t564 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t565 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t566 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t567 = load i8*, i8** %l8
  %t568 = load i8*, i8** %l9
  %t569 = load i8*, i8** %l10
  %t570 = load double, double* %l11
  %t571 = load i8*, i8** %l12
  %t572 = load i8*, i8** %l13
  %t573 = load i8*, i8** %l20
  %t574 = load double, double* %l21
  br label %loop.header49
loop.header49:
  %t686 = phi double [ %t574, %then46 ], [ %t684, %loop.latch51 ]
  %t687 = phi i8* [ %t573, %then46 ], [ %t685, %loop.latch51 ]
  store double %t686, double* %l21
  store i8* %t687, i8** %l20
  br label %loop.body50
loop.body50:
  %t575 = load double, double* %l21
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t577 = load { i8**, i64 }, { i8**, i64 }* %t576
  %t578 = extractvalue { i8**, i64 } %t577, 1
  %t579 = sitofp i64 %t578 to double
  %t580 = fcmp oge double %t575, %t579
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t583 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t584 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t585 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t586 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t587 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t588 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t589 = load i8*, i8** %l8
  %t590 = load i8*, i8** %l9
  %t591 = load i8*, i8** %l10
  %t592 = load double, double* %l11
  %t593 = load i8*, i8** %l12
  %t594 = load i8*, i8** %l13
  %t595 = load i8*, i8** %l20
  %t596 = load double, double* %l21
  br i1 %t580, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t598 = load double, double* %l21
  %t599 = fptosi double %t598 to i64
  %t600 = load { i8**, i64 }, { i8**, i64 }* %t597
  %t601 = extractvalue { i8**, i64 } %t600, 0
  %t602 = extractvalue { i8**, i64 } %t600, 1
  %t603 = icmp uge i64 %t599, %t602
  ; bounds check: %t603 (if true, out of bounds)
  %t604 = getelementptr i8*, i8** %t601, i64 %t599
  %t605 = load i8*, i8** %t604
  store i8* %t605, i8** %l22
  %t606 = load i8*, i8** %l22
  %t607 = call i64 @sailfin_runtime_string_length(i8* %t606)
  %t608 = icmp eq i64 %t607, 0
  %t609 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t611 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t612 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t613 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t614 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t615 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t616 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t617 = load i8*, i8** %l8
  %t618 = load i8*, i8** %l9
  %t619 = load i8*, i8** %l10
  %t620 = load double, double* %l11
  %t621 = load i8*, i8** %l12
  %t622 = load i8*, i8** %l13
  %t623 = load i8*, i8** %l20
  %t624 = load double, double* %l21
  %t625 = load i8*, i8** %l22
  br i1 %t608, label %then55, label %merge56
then55:
  br label %afterloop52
merge56:
  %t626 = load i8*, i8** %l22
  %t627 = call i8* @trim_text(i8* %t626)
  store i8* %t627, i8** %l23
  %t628 = load i8*, i8** %l23
  %t629 = call i64 @sailfin_runtime_string_length(i8* %t628)
  %t630 = icmp eq i64 %t629, 0
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t633 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t634 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t635 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t636 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t637 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t638 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t639 = load i8*, i8** %l8
  %t640 = load i8*, i8** %l9
  %t641 = load i8*, i8** %l10
  %t642 = load double, double* %l11
  %t643 = load i8*, i8** %l12
  %t644 = load i8*, i8** %l13
  %t645 = load i8*, i8** %l20
  %t646 = load double, double* %l21
  %t647 = load i8*, i8** %l22
  %t648 = load i8*, i8** %l23
  br i1 %t630, label %then57, label %merge58
then57:
  %t649 = load double, double* %l21
  %t650 = sitofp i64 1 to double
  %t651 = fadd double %t649, %t650
  store double %t651, double* %l21
  br label %loop.latch51
merge58:
  %t652 = load i8*, i8** %l23
  %t653 = call i1 @line_looks_like_parameter_entry(i8* %t652)
  %t654 = xor i1 %t653, 1
  %t655 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t657 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t658 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t659 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t660 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t661 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t662 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t663 = load i8*, i8** %l8
  %t664 = load i8*, i8** %l9
  %t665 = load i8*, i8** %l10
  %t666 = load double, double* %l11
  %t667 = load i8*, i8** %l12
  %t668 = load i8*, i8** %l13
  %t669 = load i8*, i8** %l20
  %t670 = load double, double* %l21
  %t671 = load i8*, i8** %l22
  %t672 = load i8*, i8** %l23
  br i1 %t654, label %then59, label %merge60
then59:
  br label %afterloop52
merge60:
  %t673 = load i8*, i8** %l20
  %t674 = getelementptr i8, i8* %t673, i64 0
  %t675 = load i8, i8* %t674
  %t676 = add i8 %t675, 32
  %t677 = load i8*, i8** %l23
  %t678 = getelementptr i8, i8* %t677, i64 0
  %t679 = load i8, i8* %t678
  %t680 = add i8 %t676, %t679
  store i8* null, i8** %l20
  %t681 = load double, double* %l21
  %t682 = sitofp i64 1 to double
  %t683 = fadd double %t681, %t682
  store double %t683, double* %l21
  br label %loop.latch51
loop.latch51:
  %t684 = load double, double* %l21
  %t685 = load i8*, i8** %l20
  br label %loop.header49
afterloop52:
  %t688 = load i8*, i8** %l20
  %t689 = call { i8**, i64 }* @split_parameter_entries(i8* %t688)
  store { i8**, i64 }* %t689, { i8**, i64 }** %l24
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t691 = load { i8**, i64 }, { i8**, i64 }* %t690
  %t692 = extractvalue { i8**, i64 } %t691, 1
  %t693 = icmp eq i64 %t692, 0
  %t694 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t695 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t696 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t697 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t698 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t699 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t700 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t701 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t702 = load i8*, i8** %l8
  %t703 = load i8*, i8** %l9
  %t704 = load i8*, i8** %l10
  %t705 = load double, double* %l11
  %t706 = load i8*, i8** %l12
  %t707 = load i8*, i8** %l13
  %t708 = load i8*, i8** %l20
  %t709 = load double, double* %l21
  %t710 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br i1 %t693, label %then61, label %else62
then61:
  %t711 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s712 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.712, i32 0, i32 0
  %t713 = load i8*, i8** %l13
  %t714 = add i8* %s712, %t713
  %t715 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t711, i8* %t714)
  store { i8**, i64 }* %t715, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge63
else62:
  %t716 = sitofp i64 0 to double
  store double %t716, double* %l25
  store i1 0, i1* %l26
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t719 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t720 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t721 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t722 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t723 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t724 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t725 = load i8*, i8** %l8
  %t726 = load i8*, i8** %l9
  %t727 = load i8*, i8** %l10
  %t728 = load double, double* %l11
  %t729 = load i8*, i8** %l12
  %t730 = load i8*, i8** %l13
  %t731 = load i8*, i8** %l20
  %t732 = load double, double* %l21
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t734 = load double, double* %l25
  %t735 = load i1, i1* %l26
  br label %loop.header64
loop.header64:
  %t802 = phi double [ %t734, %else62 ], [ %t801, %loop.latch66 ]
  store double %t802, double* %l25
  br label %loop.body65
loop.body65:
  %t736 = load double, double* %l25
  %t737 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t738 = load { i8**, i64 }, { i8**, i64 }* %t737
  %t739 = extractvalue { i8**, i64 } %t738, 1
  %t740 = sitofp i64 %t739 to double
  %t741 = fcmp oge double %t736, %t740
  %t742 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t744 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t745 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t746 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t747 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t748 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t749 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t750 = load i8*, i8** %l8
  %t751 = load i8*, i8** %l9
  %t752 = load i8*, i8** %l10
  %t753 = load double, double* %l11
  %t754 = load i8*, i8** %l12
  %t755 = load i8*, i8** %l13
  %t756 = load i8*, i8** %l20
  %t757 = load double, double* %l21
  %t758 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t759 = load double, double* %l25
  %t760 = load i1, i1* %l26
  br i1 %t741, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t761 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t762 = load double, double* %l25
  %t763 = fptosi double %t762 to i64
  %t764 = load { i8**, i64 }, { i8**, i64 }* %t761
  %t765 = extractvalue { i8**, i64 } %t764, 0
  %t766 = extractvalue { i8**, i64 } %t764, 1
  %t767 = icmp uge i64 %t763, %t766
  ; bounds check: %t767 (if true, out of bounds)
  %t768 = getelementptr i8*, i8** %t765, i64 %t763
  %t769 = load i8*, i8** %t768
  store i8* %t769, i8** %l27
  %t770 = load i8*, i8** %l9
  store i8* %t770, i8** %l28
  %t771 = load i1, i1* %l26
  %t772 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t773 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t774 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t775 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t776 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t777 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t778 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t779 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t780 = load i8*, i8** %l8
  %t781 = load i8*, i8** %l9
  %t782 = load i8*, i8** %l10
  %t783 = load double, double* %l11
  %t784 = load i8*, i8** %l12
  %t785 = load i8*, i8** %l13
  %t786 = load i8*, i8** %l20
  %t787 = load double, double* %l21
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t789 = load double, double* %l25
  %t790 = load i1, i1* %l26
  %t791 = load i8*, i8** %l27
  %t792 = load i8*, i8** %l28
  br i1 %t771, label %then70, label %merge71
then70:
  store i8* null, i8** %l28
  br label %merge71
merge71:
  %t793 = phi i8* [ null, %then70 ], [ %t792, %loop.body65 ]
  store i8* %t793, i8** %l28
  %t794 = load i8*, i8** %l27
  %t795 = load i8*, i8** %l28
  %t796 = call double @parse_parameter_entry(i8* %t794, i8* %t795)
  store double %t796, double* %l29
  %t797 = load double, double* %l29
  %t798 = load double, double* %l25
  %t799 = sitofp i64 1 to double
  %t800 = fadd double %t798, %t799
  store double %t800, double* %l25
  br label %loop.latch66
loop.latch66:
  %t801 = load double, double* %l25
  br label %loop.header64
afterloop67:
  store i8* null, i8** %l9
  br label %merge63
merge63:
  %t803 = phi { i8**, i64 }* [ %t715, %then61 ], [ %t695, %else62 ]
  %t804 = phi i8* [ null, %then61 ], [ null, %else62 ]
  store { i8**, i64 }* %t803, { i8**, i64 }** %l1
  store i8* %t804, i8** %l9
  %t805 = load double, double* %l21
  %t806 = sitofp i64 1 to double
  %t807 = fsub double %t805, %t806
  store double %t807, double* %l11
  br label %merge48
else47:
  %t808 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s809 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.809, i32 0, i32 0
  %t810 = load i8*, i8** %l13
  %t811 = add i8* %s809, %t810
  %t812 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t808, i8* %t811)
  store { i8**, i64 }* %t812, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t813 = phi { i8**, i64 }* [ %t715, %then46 ], [ %t812, %else47 ]
  %t814 = phi i8* [ null, %then46 ], [ %t548, %else47 ]
  %t815 = phi double [ %t807, %then46 ], [ %t550, %else47 ]
  store { i8**, i64 }* %t813, { i8**, i64 }** %l1
  store i8* %t814, i8** %l9
  store double %t815, double* %l11
  %t816 = load double, double* %l11
  %t817 = sitofp i64 1 to double
  %t818 = fadd double %t816, %t817
  store double %t818, double* %l11
  br label %loop.latch2
merge45:
  %t819 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t820 = load double, double* %l11
  %t821 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t819, double %t820)
  store %InstructionGatherResult %t821, %InstructionGatherResult* %l30
  %t822 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t823 = extractvalue %InstructionGatherResult %t822, 0
  store i8* %t823, i8** %l13
  %t824 = load double, double* %l11
  %t825 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t826 = extractvalue %InstructionGatherResult %t825, 1
  %t827 = fadd double %t824, %t826
  store double %t827, double* %l11
  %t828 = load i8*, i8** %l13
  %t829 = load i8*, i8** %l9
  %t830 = load i8*, i8** %l10
  %t831 = call %InstructionParseResult @parse_instruction(i8* %t828, i8* %t829, i8* %t830)
  store %InstructionParseResult %t831, %InstructionParseResult* %l31
  %t832 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t833 = extractvalue %InstructionParseResult %t832, 0
  store { i8**, i64 }* %t833, { i8**, i64 }** %l32
  %t834 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t835 = extractvalue %InstructionParseResult %t834, 1
  %t836 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t838 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t839 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t840 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t841 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t842 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t843 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t844 = load i8*, i8** %l8
  %t845 = load i8*, i8** %l9
  %t846 = load i8*, i8** %l10
  %t847 = load double, double* %l11
  %t848 = load i8*, i8** %l12
  %t849 = load i8*, i8** %l13
  %t850 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t851 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t852 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t835, label %then72, label %else73
then72:
  store i8* null, i8** %l9
  br label %merge74
else73:
  %t853 = load i8*, i8** %l9
  %t854 = icmp ne i8* %t853, null
  %t855 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t857 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t858 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t859 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t860 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t861 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t862 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t863 = load i8*, i8** %l8
  %t864 = load i8*, i8** %l9
  %t865 = load i8*, i8** %l10
  %t866 = load double, double* %l11
  %t867 = load i8*, i8** %l12
  %t868 = load i8*, i8** %l13
  %t869 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t870 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t871 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t854, label %then75, label %merge76
then75:
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s873 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.873, i32 0, i32 0
  %t874 = load i8*, i8** %l13
  %t875 = add i8* %s873, %t874
  %t876 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t872, i8* %t875)
  store { i8**, i64 }* %t876, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge76
merge76:
  %t877 = phi { i8**, i64 }* [ %t876, %then75 ], [ %t856, %else73 ]
  %t878 = phi i8* [ null, %then75 ], [ %t864, %else73 ]
  store { i8**, i64 }* %t877, { i8**, i64 }** %l1
  store i8* %t878, i8** %l9
  br label %merge74
merge74:
  %t879 = phi i8* [ null, %then72 ], [ null, %else73 ]
  %t880 = phi { i8**, i64 }* [ %t837, %then72 ], [ %t876, %else73 ]
  store i8* %t879, i8** %l9
  store { i8**, i64 }* %t880, { i8**, i64 }** %l1
  %t881 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t882 = extractvalue %InstructionParseResult %t881, 2
  %t883 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t884 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t885 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t886 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t887 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t888 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t889 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t890 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t891 = load i8*, i8** %l8
  %t892 = load i8*, i8** %l9
  %t893 = load i8*, i8** %l10
  %t894 = load double, double* %l11
  %t895 = load i8*, i8** %l12
  %t896 = load i8*, i8** %l13
  %t897 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t898 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t899 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t882, label %then77, label %else78
then77:
  store i8* null, i8** %l10
  br label %merge79
else78:
  %t900 = load i8*, i8** %l10
  %t901 = icmp ne i8* %t900, null
  %t902 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t903 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t904 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t905 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t906 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t907 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t908 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t909 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t910 = load i8*, i8** %l8
  %t911 = load i8*, i8** %l9
  %t912 = load i8*, i8** %l10
  %t913 = load double, double* %l11
  %t914 = load i8*, i8** %l12
  %t915 = load i8*, i8** %l13
  %t916 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t917 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t901, label %then80, label %merge81
then80:
  %t919 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s920 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.920, i32 0, i32 0
  %t921 = load i8*, i8** %l13
  %t922 = add i8* %s920, %t921
  %t923 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t919, i8* %t922)
  store { i8**, i64 }* %t923, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge81
merge81:
  %t924 = phi { i8**, i64 }* [ %t923, %then80 ], [ %t903, %else78 ]
  %t925 = phi i8* [ null, %then80 ], [ %t912, %else78 ]
  store { i8**, i64 }* %t924, { i8**, i64 }** %l1
  store i8* %t925, i8** %l10
  br label %merge79
merge79:
  %t926 = phi i8* [ null, %then77 ], [ null, %else78 ]
  %t927 = phi { i8**, i64 }* [ %t884, %then77 ], [ %t923, %else78 ]
  store i8* %t926, i8** %l10
  store { i8**, i64 }* %t927, { i8**, i64 }** %l1
  %t928 = load i8*, i8** %l8
  %t929 = icmp eq i8* %t928, null
  %t930 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t931 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t932 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t933 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t934 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t935 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t936 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t937 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t938 = load i8*, i8** %l8
  %t939 = load i8*, i8** %l9
  %t940 = load i8*, i8** %l10
  %t941 = load double, double* %l11
  %t942 = load i8*, i8** %l12
  %t943 = load i8*, i8** %l13
  %t944 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t945 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t946 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t929, label %then82, label %merge83
then82:
  %t948 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t949 = load { i8**, i64 }, { i8**, i64 }* %t948
  %t950 = extractvalue { i8**, i64 } %t949, 1
  %t951 = icmp eq i64 %t950, 1
  br label %logical_and_entry_947

logical_and_entry_947:
  br i1 %t951, label %logical_and_right_947, label %logical_and_merge_947

logical_and_right_947:
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t953 = load { i8**, i64 }, { i8**, i64 }* %t952
  %t954 = extractvalue { i8**, i64 } %t953, 0
  %t955 = extractvalue { i8**, i64 } %t953, 1
  %t956 = icmp uge i64 0, %t955
  ; bounds check: %t956 (if true, out of bounds)
  %t957 = getelementptr i8*, i8** %t954, i64 0
  %t958 = load i8*, i8** %t957
  %t959 = load double, double* %l11
  %t960 = sitofp i64 1 to double
  %t961 = fadd double %t959, %t960
  store double %t961, double* %l11
  br label %loop.latch2
merge83:
  %t962 = sitofp i64 0 to double
  store double %t962, double* %l33
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t964 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t965 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t966 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t967 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t968 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t969 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t970 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t971 = load i8*, i8** %l8
  %t972 = load i8*, i8** %l9
  %t973 = load i8*, i8** %l10
  %t974 = load double, double* %l11
  %t975 = load i8*, i8** %l12
  %t976 = load i8*, i8** %l13
  %t977 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t978 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t979 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t980 = load double, double* %l33
  br label %loop.header84
loop.header84:
  %t1021 = phi i8* [ %t971, %loop.body1 ], [ %t1019, %loop.latch86 ]
  %t1022 = phi double [ %t980, %loop.body1 ], [ %t1020, %loop.latch86 ]
  store i8* %t1021, i8** %l8
  store double %t1022, double* %l33
  br label %loop.body85
loop.body85:
  %t981 = load double, double* %l33
  %t982 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t983 = load { i8**, i64 }, { i8**, i64 }* %t982
  %t984 = extractvalue { i8**, i64 } %t983, 1
  %t985 = sitofp i64 %t984 to double
  %t986 = fcmp oge double %t981, %t985
  %t987 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t989 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t990 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t991 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t992 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t993 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t994 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t995 = load i8*, i8** %l8
  %t996 = load i8*, i8** %l9
  %t997 = load i8*, i8** %l10
  %t998 = load double, double* %l11
  %t999 = load i8*, i8** %l12
  %t1000 = load i8*, i8** %l13
  %t1001 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t1002 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t1003 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t1004 = load double, double* %l33
  br i1 %t986, label %then88, label %merge89
then88:
  br label %afterloop87
merge89:
  %t1005 = load i8*, i8** %l8
  %t1006 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t1007 = load double, double* %l33
  %t1008 = fptosi double %t1007 to i64
  %t1009 = load { i8**, i64 }, { i8**, i64 }* %t1006
  %t1010 = extractvalue { i8**, i64 } %t1009, 0
  %t1011 = extractvalue { i8**, i64 } %t1009, 1
  %t1012 = icmp uge i64 %t1008, %t1011
  ; bounds check: %t1012 (if true, out of bounds)
  %t1013 = getelementptr i8*, i8** %t1010, i64 %t1008
  %t1014 = load i8*, i8** %t1013
  %t1015 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t1016 = load double, double* %l33
  %t1017 = sitofp i64 1 to double
  %t1018 = fadd double %t1016, %t1017
  store double %t1018, double* %l33
  br label %loop.latch86
loop.latch86:
  %t1019 = load i8*, i8** %l8
  %t1020 = load double, double* %l33
  br label %loop.header84
afterloop87:
  %t1023 = load double, double* %l11
  %t1024 = sitofp i64 1 to double
  %t1025 = fadd double %t1023, %t1024
  store double %t1025, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1026 = load double, double* %l11
  %t1027 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1028 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1029 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1030 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1031 = load i8*, i8** %l8
  %t1032 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1033 = load i8*, i8** %l9
  %t1034 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t1044 = load i8*, i8** %l8
  %t1045 = icmp ne i8* %t1044, null
  %t1046 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1047 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1048 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1049 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1050 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1051 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1052 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1053 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1054 = load i8*, i8** %l8
  %t1055 = load i8*, i8** %l9
  %t1056 = load i8*, i8** %l10
  %t1057 = load double, double* %l11
  br i1 %t1045, label %then90, label %merge91
then90:
  %t1058 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1059 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.1059, i32 0, i32 0
  %t1060 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1058, i8* %s1059)
  store { i8**, i64 }* %t1060, { i8**, i64 }** %l1
  br label %merge91
merge91:
  %t1061 = phi { i8**, i64 }* [ %t1060, %then90 ], [ %t1047, %entry ]
  store { i8**, i64 }* %t1061, { i8**, i64 }** %l1
  %t1062 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1063 = bitcast { %NativeFunction*, i64 }* %t1062 to { i8**, i64 }*
  %t1064 = insertvalue %ParseNativeResult undef, { i8**, i64 }* %t1063, 0
  %t1065 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1066 = bitcast { %NativeImport*, i64 }* %t1065 to { i8**, i64 }*
  %t1067 = insertvalue %ParseNativeResult %t1064, { i8**, i64 }* %t1066, 1
  %t1068 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1069 = bitcast { %NativeStruct*, i64 }* %t1068 to { i8**, i64 }*
  %t1070 = insertvalue %ParseNativeResult %t1067, { i8**, i64 }* %t1069, 2
  %t1071 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1072 = bitcast { %NativeInterface*, i64 }* %t1071 to { i8**, i64 }*
  %t1073 = insertvalue %ParseNativeResult %t1070, { i8**, i64 }* %t1072, 3
  %t1074 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1075 = bitcast { %NativeEnum*, i64 }* %t1074 to { i8**, i64 }*
  %t1076 = insertvalue %ParseNativeResult %t1073, { i8**, i64 }* %t1075, 4
  %t1077 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1078 = bitcast { %NativeBinding*, i64 }* %t1077 to { i8**, i64 }*
  %t1079 = insertvalue %ParseNativeResult %t1076, { i8**, i64 }* %t1078, 5
  %t1080 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1081 = insertvalue %ParseNativeResult %t1079, { i8**, i64 }* %t1080, 6
  ret %ParseNativeResult %t1081
}

define { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %functions, %NativeFunction %value) {
entry:
  %t0 = alloca [1 x %NativeFunction]
  %t1 = getelementptr [1 x %NativeFunction], [1 x %NativeFunction]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeFunction, %NativeFunction* %t1, i64 0
  store %NativeFunction %value, %NativeFunction* %t2
  %t3 = alloca { %NativeFunction*, i64 }
  %t4 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t3, i32 0, i32 0
  store %NativeFunction* %t1, %NativeFunction** %t4
  %t5 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeFunction*, i64 }* %functions to { i8**, i64 }*
  %t7 = bitcast { %NativeFunction*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeFunction*, i64 }*
  ret { %NativeFunction*, i64 }* %t9
}

define { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %bindings, %NativeBinding %value) {
entry:
  %t0 = alloca [1 x %NativeBinding]
  %t1 = getelementptr [1 x %NativeBinding], [1 x %NativeBinding]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeBinding, %NativeBinding* %t1, i64 0
  store %NativeBinding %value, %NativeBinding* %t2
  %t3 = alloca { %NativeBinding*, i64 }
  %t4 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t3, i32 0, i32 0
  store %NativeBinding* %t1, %NativeBinding** %t4
  %t5 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeBinding*, i64 }* %bindings to { i8**, i64 }*
  %t7 = bitcast { %NativeBinding*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeBinding*, i64 }*
  ret { %NativeBinding*, i64 }* %t9
}

define { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %imports, %NativeImport %value) {
entry:
  %t0 = alloca [1 x %NativeImport]
  %t1 = getelementptr [1 x %NativeImport], [1 x %NativeImport]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeImport, %NativeImport* %t1, i64 0
  store %NativeImport %value, %NativeImport* %t2
  %t3 = alloca { %NativeImport*, i64 }
  %t4 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t3, i32 0, i32 0
  store %NativeImport* %t1, %NativeImport** %t4
  %t5 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeImport*, i64 }* %imports to { i8**, i64 }*
  %t7 = bitcast { %NativeImport*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeImport*, i64 }*
  ret { %NativeImport*, i64 }* %t9
}

define { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %structs, %NativeStruct %value) {
entry:
  %t0 = alloca [1 x %NativeStruct]
  %t1 = getelementptr [1 x %NativeStruct], [1 x %NativeStruct]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeStruct, %NativeStruct* %t1, i64 0
  store %NativeStruct %value, %NativeStruct* %t2
  %t3 = alloca { %NativeStruct*, i64 }
  %t4 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t3, i32 0, i32 0
  store %NativeStruct* %t1, %NativeStruct** %t4
  %t5 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeStruct*, i64 }* %structs to { i8**, i64 }*
  %t7 = bitcast { %NativeStruct*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeStruct*, i64 }*
  ret { %NativeStruct*, i64 }* %t9
}

define { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %interfaces, %NativeInterface %value) {
entry:
  %t0 = alloca [1 x %NativeInterface]
  %t1 = getelementptr [1 x %NativeInterface], [1 x %NativeInterface]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeInterface, %NativeInterface* %t1, i64 0
  store %NativeInterface %value, %NativeInterface* %t2
  %t3 = alloca { %NativeInterface*, i64 }
  %t4 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t3, i32 0, i32 0
  store %NativeInterface* %t1, %NativeInterface** %t4
  %t5 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeInterface*, i64 }* %interfaces to { i8**, i64 }*
  %t7 = bitcast { %NativeInterface*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeInterface*, i64 }*
  ret { %NativeInterface*, i64 }* %t9
}

define { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %enums, %NativeEnum %value) {
entry:
  %t0 = alloca [1 x %NativeEnum]
  %t1 = getelementptr [1 x %NativeEnum], [1 x %NativeEnum]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeEnum, %NativeEnum* %t1, i64 0
  store %NativeEnum %value, %NativeEnum* %t2
  %t3 = alloca { %NativeEnum*, i64 }
  %t4 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t3, i32 0, i32 0
  store %NativeEnum* %t1, %NativeEnum** %t4
  %t5 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeEnum*, i64 }* %enums to { i8**, i64 }*
  %t7 = bitcast { %NativeEnum*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeEnum*, i64 }*
  ret { %NativeEnum*, i64 }* %t9
}

define { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %variants, %NativeEnumVariant %value) {
entry:
  %t0 = alloca [1 x %NativeEnumVariant]
  %t1 = getelementptr [1 x %NativeEnumVariant], [1 x %NativeEnumVariant]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t1, i64 0
  store %NativeEnumVariant %value, %NativeEnumVariant* %t2
  %t3 = alloca { %NativeEnumVariant*, i64 }
  %t4 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t3, i32 0, i32 0
  store %NativeEnumVariant* %t1, %NativeEnumVariant** %t4
  %t5 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeEnumVariant*, i64 }* %variants to { i8**, i64 }*
  %t7 = bitcast { %NativeEnumVariant*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeEnumVariant*, i64 }*
  ret { %NativeEnumVariant*, i64 }* %t9
}

define { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %fields, %NativeEnumVariantField %value) {
entry:
  %t0 = alloca [1 x %NativeEnumVariantField]
  %t1 = getelementptr [1 x %NativeEnumVariantField], [1 x %NativeEnumVariantField]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t1, i64 0
  store %NativeEnumVariantField %value, %NativeEnumVariantField* %t2
  %t3 = alloca { %NativeEnumVariantField*, i64 }
  %t4 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t3, i32 0, i32 0
  store %NativeEnumVariantField* %t1, %NativeEnumVariantField** %t4
  %t5 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeEnumVariantField*, i64 }* %fields to { i8**, i64 }*
  %t7 = bitcast { %NativeEnumVariantField*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeEnumVariantField*, i64 }*
  ret { %NativeEnumVariantField*, i64 }* %t9
}

define { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %fields, %NativeStructField %field) {
entry:
  %t0 = alloca [1 x %NativeStructField]
  %t1 = getelementptr [1 x %NativeStructField], [1 x %NativeStructField]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeStructField, %NativeStructField* %t1, i64 0
  store %NativeStructField %field, %NativeStructField* %t2
  %t3 = alloca { %NativeStructField*, i64 }
  %t4 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t3, i32 0, i32 0
  store %NativeStructField* %t1, %NativeStructField** %t4
  %t5 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeStructField*, i64 }* %fields to { i8**, i64 }*
  %t7 = bitcast { %NativeStructField*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeStructField*, i64 }*
  ret { %NativeStructField*, i64 }* %t9
}

define { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %fields, %NativeStructLayoutField %field) {
entry:
  %t0 = alloca [1 x %NativeStructLayoutField]
  %t1 = getelementptr [1 x %NativeStructLayoutField], [1 x %NativeStructLayoutField]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeStructLayoutField, %NativeStructLayoutField* %t1, i64 0
  store %NativeStructLayoutField %field, %NativeStructLayoutField* %t2
  %t3 = alloca { %NativeStructLayoutField*, i64 }
  %t4 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t3, i32 0, i32 0
  store %NativeStructLayoutField* %t1, %NativeStructLayoutField** %t4
  %t5 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeStructLayoutField*, i64 }* %fields to { i8**, i64 }*
  %t7 = bitcast { %NativeStructLayoutField*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeStructLayoutField*, i64 }*
  ret { %NativeStructLayoutField*, i64 }* %t9
}

define { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, %NativeEnumVariantLayout %value) {
entry:
  %t0 = alloca [1 x %NativeEnumVariantLayout]
  %t1 = getelementptr [1 x %NativeEnumVariantLayout], [1 x %NativeEnumVariantLayout]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t1, i64 0
  store %NativeEnumVariantLayout %value, %NativeEnumVariantLayout* %t2
  %t3 = alloca { %NativeEnumVariantLayout*, i64 }
  %t4 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t3, i32 0, i32 0
  store %NativeEnumVariantLayout* %t1, %NativeEnumVariantLayout** %t4
  %t5 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeEnumVariantLayout*, i64 }* %variants to { i8**, i64 }*
  %t7 = bitcast { %NativeEnumVariantLayout*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeEnumVariantLayout*, i64 }*
  ret { %NativeEnumVariantLayout*, i64 }* %t9
}

define double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, i8* %name) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t1, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t4 = extractvalue { %NativeEnumVariantLayout*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t11 = extractvalue { %NativeEnumVariantLayout*, i64 } %t10, 0
  %t12 = extractvalue { %NativeEnumVariantLayout*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t11, i64 %t9
  %t15 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t14
  %t16 = extractvalue %NativeEnumVariantLayout %t15, 0
  %t17 = icmp eq i8* %t16, %name
  %t18 = load double, double* %l0
  br i1 %t17, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  ret double %t19
merge7:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = sitofp i64 -1 to double
  ret double %t25
}

define { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %variants, double %index, %NativeStructLayoutField %field) {
entry:
  %l0 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca %NativeEnumVariantLayout
  %t0 = alloca [0 x %NativeEnumVariantLayout]
  %t1 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t0, i32 0, i32 0
  %t2 = alloca { %NativeEnumVariantLayout*, i64 }
  %t3 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t2, i32 0, i32 0
  store %NativeEnumVariantLayout* %t1, %NativeEnumVariantLayout** %t3
  %t4 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %NativeEnumVariantLayout*, i64 }* %t2, { %NativeEnumVariantLayout*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t67 = phi { %NativeEnumVariantLayout*, i64 }* [ %t6, %entry ], [ %t65, %loop.latch2 ]
  %t68 = phi double [ %t7, %entry ], [ %t66, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t67, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t68, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t10 = extractvalue { %NativeEnumVariantLayout*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fcmp oeq double %t15, %index
  %t17 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %else7
then6:
  %t19 = load double, double* %l1
  %t20 = fptosi double %t19 to i64
  %t21 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t22 = extractvalue { %NativeEnumVariantLayout*, i64 } %t21, 0
  %t23 = extractvalue { %NativeEnumVariantLayout*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t22, i64 %t20
  %t26 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t25
  store %NativeEnumVariantLayout %t26, %NativeEnumVariantLayout* %l2
  %t27 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t28 = extractvalue %NativeEnumVariantLayout %t27, 0
  %t29 = insertvalue %NativeEnumVariantLayout undef, i8* %t28, 0
  %t30 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t31 = extractvalue %NativeEnumVariantLayout %t30, 1
  %t32 = insertvalue %NativeEnumVariantLayout %t29, double %t31, 1
  %t33 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t34 = extractvalue %NativeEnumVariantLayout %t33, 2
  %t35 = insertvalue %NativeEnumVariantLayout %t32, double %t34, 2
  %t36 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t37 = extractvalue %NativeEnumVariantLayout %t36, 3
  %t38 = insertvalue %NativeEnumVariantLayout %t35, double %t37, 3
  %t39 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t40 = extractvalue %NativeEnumVariantLayout %t39, 4
  %t41 = insertvalue %NativeEnumVariantLayout %t38, double %t40, 4
  %t42 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t43 = extractvalue %NativeEnumVariantLayout %t42, 5
  %t44 = bitcast { i8**, i64 }* %t43 to { %NativeStructLayoutField*, i64 }*
  %t45 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t44, %NativeStructLayoutField %field)
  %t46 = bitcast { %NativeStructLayoutField*, i64 }* %t45 to { i8**, i64 }*
  %t47 = insertvalue %NativeEnumVariantLayout %t41, { i8**, i64 }* %t46, 5
  store %NativeEnumVariantLayout %t47, %NativeEnumVariantLayout* %l3
  %t48 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t49 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l3
  %t50 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t48, %NativeEnumVariantLayout %t49)
  store { %NativeEnumVariantLayout*, i64 }* %t50, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
else7:
  %t51 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = fptosi double %t52 to i64
  %t54 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t55 = extractvalue { %NativeEnumVariantLayout*, i64 } %t54, 0
  %t56 = extractvalue { %NativeEnumVariantLayout*, i64 } %t54, 1
  %t57 = icmp uge i64 %t53, %t56
  ; bounds check: %t57 (if true, out of bounds)
  %t58 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t55, i64 %t53
  %t59 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t58
  %t60 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t51, %NativeEnumVariantLayout %t59)
  store { %NativeEnumVariantLayout*, i64 }* %t60, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
merge8:
  %t61 = phi { %NativeEnumVariantLayout*, i64 }* [ %t50, %then6 ], [ %t60, %else7 ]
  store { %NativeEnumVariantLayout*, i64 }* %t61, { %NativeEnumVariantLayout*, i64 }** %l0
  %t62 = load double, double* %l1
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l1
  br label %loop.latch2
loop.latch2:
  %t65 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t66 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t69 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t69
}

define %NativeFunction @append_parameter(%NativeFunction %function, %NativeParameter %parameter) {
entry:
  %l0 = alloca { %NativeParameter*, i64 }*
  %t0 = extractvalue %NativeFunction %function, 1
  %t1 = bitcast { i8**, i64 }* %t0 to { %NativeParameter*, i64 }*
  %t2 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t1, %NativeParameter %parameter)
  store { %NativeParameter*, i64 }* %t2, { %NativeParameter*, i64 }** %l0
  %t3 = extractvalue %NativeFunction %function, 0
  %t4 = insertvalue %NativeFunction undef, i8* %t3, 0
  %t5 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l0
  %t6 = bitcast { %NativeParameter*, i64 }* %t5 to { i8**, i64 }*
  %t7 = insertvalue %NativeFunction %t4, { i8**, i64 }* %t6, 1
  %t8 = extractvalue %NativeFunction %function, 2
  %t9 = insertvalue %NativeFunction %t7, i8* %t8, 2
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = insertvalue %NativeFunction %t9, { i8**, i64 }* %t10, 3
  %t12 = extractvalue %NativeFunction %function, 4
  %t13 = insertvalue %NativeFunction %t11, { i8**, i64 }* %t12, 4
  ret %NativeFunction %t13
}

define %NativeFunction @append_instruction(%NativeFunction %function, %NativeInstruction %instruction) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeFunction %function, 4
  %t1 = alloca [1 x %NativeInstruction]
  %t2 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t1, i32 0, i32 0
  %t3 = getelementptr %NativeInstruction, %NativeInstruction* %t2, i64 0
  store %NativeInstruction %instruction, %NativeInstruction* %t3
  %t4 = alloca { %NativeInstruction*, i64 }
  %t5 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t4, i32 0, i32 0
  store %NativeInstruction* %t2, %NativeInstruction** %t5
  %t6 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t4, i32 0, i32 1
  store i64 1, i64* %t6
  %t7 = bitcast { %NativeInstruction*, i64 }* %t4 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t0, { i8**, i64 }* %t7)
  store { i8**, i64 }* %t8, { i8**, i64 }** %l0
  %t9 = extractvalue %NativeFunction %function, 0
  %t10 = insertvalue %NativeFunction undef, i8* %t9, 0
  %t11 = extractvalue %NativeFunction %function, 1
  %t12 = insertvalue %NativeFunction %t10, { i8**, i64 }* %t11, 1
  %t13 = extractvalue %NativeFunction %function, 2
  %t14 = insertvalue %NativeFunction %t12, i8* %t13, 2
  %t15 = extractvalue %NativeFunction %function, 3
  %t16 = insertvalue %NativeFunction %t14, { i8**, i64 }* %t15, 3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = insertvalue %NativeFunction %t16, { i8**, i64 }* %t17, 4
  ret %NativeFunction %t18
}

define %NativeBinding @binding_from_instruction(%NativeInstruction %instruction) {
entry:
  %t0 = extractvalue %NativeInstruction %instruction, 0
  %t1 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t1
  %t2 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = bitcast i8* %t3 to i8**
  %t5 = load i8*, i8** %t4
  %t6 = icmp eq i32 %t0, 2
  %t7 = select i1 %t6, i8* %t5, i8* null
  %t8 = insertvalue %NativeBinding undef, i8* %t7, 0
  %t9 = extractvalue %NativeInstruction %instruction, 0
  %t10 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t10
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t12 = bitcast [48 x i8]* %t11 to i8*
  %t13 = getelementptr inbounds i8, i8* %t12, i64 8
  %t14 = bitcast i8* %t13 to i1*
  %t15 = load i1, i1* %t14
  %t16 = icmp eq i32 %t9, 2
  %t17 = select i1 %t16, i1 %t15, i1 false
  %t18 = insertvalue %NativeBinding %t8, i1 %t17, 1
  %t19 = extractvalue %NativeInstruction %instruction, 0
  %t20 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t20
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t22 = bitcast [48 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to i8**
  %t25 = load i8*, i8** %t24
  %t26 = icmp eq i32 %t19, 2
  %t27 = select i1 %t26, i8* %t25, i8* null
  %t28 = insertvalue %NativeBinding %t18, i8* %t27, 2
  %t29 = extractvalue %NativeInstruction %instruction, 0
  %t30 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t30
  %t31 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t30, i32 0, i32 1
  %t32 = bitcast [48 x i8]* %t31 to i8*
  %t33 = getelementptr inbounds i8, i8* %t32, i64 24
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t29, 2
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = insertvalue %NativeBinding %t28, i8* %t37, 3
  ret %NativeBinding %t38
}

define %NativeFunction @apply_meta(%NativeFunction %function, i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t9, { i8**, i64 }* %t10)
  ret %NativeFunction %t11
merge1:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i1 @starts_with(i8* %t12, i8* %s13)
  %t15 = load i8*, i8** %l0
  br i1 %t14, label %then2, label %merge3
then2:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.17, i32 0, i32 0
  %t18 = call i8* @strip_prefix(i8* %t16, i8* %s17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call { i8**, i64 }* @parse_effect_list(i8* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l3
  %t22 = extractvalue %NativeFunction %function, 2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t24 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t22, { i8**, i64 }* %t23)
  ret %NativeFunction %t24
merge3:
  ret %NativeFunction %function
}

define %NativeFunction @update_function_meta(%NativeFunction %function, i8* %return_type, { i8**, i64 }* %effects) {
entry:
  %t0 = extractvalue %NativeFunction %function, 0
  %t1 = insertvalue %NativeFunction undef, i8* %t0, 0
  %t2 = extractvalue %NativeFunction %function, 1
  %t3 = insertvalue %NativeFunction %t1, { i8**, i64 }* %t2, 1
  %t4 = insertvalue %NativeFunction %t3, i8* %return_type, 2
  %t5 = insertvalue %NativeFunction %t4, { i8**, i64 }* %effects, 3
  %t6 = extractvalue %NativeFunction %function, 4
  %t7 = insertvalue %NativeFunction %t5, { i8**, i64 }* %t6, 4
  ret %NativeFunction %t7
}

define %InstructionGatherResult @gather_instruction({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %InstructionDepthState
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = sitofp i64 %t1 to double
  %t3 = fcmp oge double %start_index, %t2
  br i1 %t3, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  %t5 = insertvalue %InstructionGatherResult undef, i8* %s4, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %InstructionGatherResult %t5, double %t6, 1
  ret %InstructionGatherResult %t7
merge1:
  %t8 = fptosi double %start_index to i64
  %t9 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  br i1 %t18, label %then2, label %merge3
then2:
  %t20 = load i8*, i8** %l0
  %t21 = insertvalue %InstructionGatherResult undef, i8* %t20, 0
  %t22 = sitofp i64 0 to double
  %t23 = insertvalue %InstructionGatherResult %t21, double %t22, 1
  ret %InstructionGatherResult %t23
merge3:
  %t24 = load i8*, i8** %l0
  %t25 = call i1 @instruction_supports_multiline(i8* %t24)
  %t26 = xor i1 %t25, 1
  %t27 = load i8*, i8** %l0
  br i1 %t26, label %then4, label %merge5
then4:
  %t28 = load i8*, i8** %l0
  %t29 = insertvalue %InstructionGatherResult undef, i8* %t28, 0
  %t30 = sitofp i64 0 to double
  %t31 = insertvalue %InstructionGatherResult %t29, double %t30, 1
  ret %InstructionGatherResult %t31
merge5:
  %t32 = call %InstructionDepthState @initial_instruction_depth_state()
  %t33 = load i8*, i8** %l0
  %t34 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t32, i8* %t33)
  store %InstructionDepthState %t34, %InstructionDepthState* %l1
  %t35 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t36 = call i1 @instruction_requires_continuation(%InstructionDepthState %t35)
  %t37 = xor i1 %t36, 1
  %t38 = load i8*, i8** %l0
  %t39 = load %InstructionDepthState, %InstructionDepthState* %l1
  br i1 %t37, label %then6, label %merge7
then6:
  %t40 = load i8*, i8** %l0
  %t41 = insertvalue %InstructionGatherResult undef, i8* %t40, 0
  %t42 = sitofp i64 0 to double
  %t43 = insertvalue %InstructionGatherResult %t41, double %t42, 1
  ret %InstructionGatherResult %t43
merge7:
  %t44 = load i8*, i8** %l0
  store i8* %t44, i8** %l2
  %t45 = sitofp i64 0 to double
  store double %t45, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %start_index, %t46
  store double %t47, double* %l4
  %t48 = load i8*, i8** %l0
  %t49 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load double, double* %l3
  %t52 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t117 = phi i8* [ %t50, %entry ], [ %t113, %loop.latch10 ]
  %t118 = phi %InstructionDepthState [ %t49, %entry ], [ %t114, %loop.latch10 ]
  %t119 = phi double [ %t51, %entry ], [ %t115, %loop.latch10 ]
  %t120 = phi double [ %t52, %entry ], [ %t116, %loop.latch10 ]
  store i8* %t117, i8** %l2
  store %InstructionDepthState %t118, %InstructionDepthState* %l1
  store double %t119, double* %l3
  store double %t120, double* %l4
  br label %loop.body9
loop.body9:
  %t53 = load double, double* %l4
  %t54 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t53, %t56
  %t58 = load i8*, i8** %l0
  %t59 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t60 = load i8*, i8** %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  br i1 %t57, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t63 = load double, double* %l4
  %t64 = fptosi double %t63 to i64
  %t65 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t66 = extractvalue { i8**, i64 } %t65, 0
  %t67 = extractvalue { i8**, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  %t69 = getelementptr i8*, i8** %t66, i64 %t64
  %t70 = load i8*, i8** %t69
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l5
  %t72 = load i8*, i8** %l5
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = icmp eq i64 %t73, 0
  %t75 = load i8*, i8** %l0
  %t76 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l3
  %t79 = load double, double* %l4
  %t80 = load i8*, i8** %l5
  br i1 %t74, label %then14, label %else15
then14:
  %t81 = load i8*, i8** %l2
  %t82 = getelementptr i8, i8* %t81, i64 0
  %t83 = load i8, i8* %t82
  %t84 = add i8 %t83, 10
  store i8* null, i8** %l2
  br label %merge16
else15:
  %t85 = load i8*, i8** %l2
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = add i8 %t87, 10
  %t89 = load i8*, i8** %l5
  %t90 = getelementptr i8, i8* %t89, i64 0
  %t91 = load i8, i8* %t90
  %t92 = add i8 %t88, %t91
  store i8* null, i8** %l2
  %t93 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t94 = load i8*, i8** %l5
  %t95 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t93, i8* %t94)
  store %InstructionDepthState %t95, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t96 = phi i8* [ null, %then14 ], [ null, %else15 ]
  %t97 = phi %InstructionDepthState [ %t76, %then14 ], [ %t95, %else15 ]
  store i8* %t96, i8** %l2
  store %InstructionDepthState %t97, %InstructionDepthState* %l1
  %t98 = load double, double* %l3
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l3
  %t101 = load double, double* %l4
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  store double %t103, double* %l4
  %t104 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t105 = call i1 @instruction_requires_continuation(%InstructionDepthState %t104)
  %t106 = xor i1 %t105, 1
  %t107 = load i8*, i8** %l0
  %t108 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t109 = load i8*, i8** %l2
  %t110 = load double, double* %l3
  %t111 = load double, double* %l4
  %t112 = load i8*, i8** %l5
  br i1 %t106, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t113 = load i8*, i8** %l2
  %t114 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t115 = load double, double* %l3
  %t116 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t121 = load i8*, i8** %l2
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l6
  %t123 = load i8*, i8** %l6
  %t124 = insertvalue %InstructionGatherResult undef, i8* %t123, 0
  %t125 = load double, double* %l3
  %t126 = insertvalue %InstructionGatherResult %t124, double %t125, 1
  ret %InstructionGatherResult %t126
}

define i1 @instruction_supports_multiline(i8* %line) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i1 @starts_with(i8* %line, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %line, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i1 @instruction_requires_continuation(%InstructionDepthState %state) {
entry:
  %t0 = extractvalue %InstructionDepthState %state, 3
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = extractvalue %InstructionDepthState %state, 0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = extractvalue %InstructionDepthState %state, 1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp ogt double %t4, %t5
  br i1 %t6, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t7 = extractvalue %InstructionDepthState %state, 2
  %t8 = sitofp i64 0 to double
  %t9 = fcmp ogt double %t7, %t8
  br i1 %t9, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define %InstructionDepthState @initial_instruction_depth_state() {
entry:
  %t0 = sitofp i64 0 to double
  %t1 = insertvalue %InstructionDepthState undef, double %t0, 0
  %t2 = sitofp i64 0 to double
  %t3 = insertvalue %InstructionDepthState %t1, double %t2, 1
  %t4 = sitofp i64 0 to double
  %t5 = insertvalue %InstructionDepthState %t3, double %t4, 2
  %t6 = insertvalue %InstructionDepthState %t5, i1 0, 3
  %t7 = insertvalue %InstructionDepthState %t6, i1 0, 4
  ret %InstructionDepthState %t7
}

define %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %state, i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca i8
  %t0 = extractvalue %InstructionDepthState %state, 0
  store double %t0, double* %l0
  %t1 = extractvalue %InstructionDepthState %state, 1
  store double %t1, double* %l1
  %t2 = extractvalue %InstructionDepthState %state, 2
  store double %t2, double* %l2
  %t3 = extractvalue %InstructionDepthState %state, 3
  store i1 %t3, i1* %l3
  %t4 = extractvalue %InstructionDepthState %state, 4
  store i1 %t4, i1* %l4
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l5
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  %t9 = load i1, i1* %l3
  %t10 = load i1, i1* %l4
  %t11 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t214 = phi i1 [ %t10, %entry ], [ %t208, %loop.latch2 ]
  %t215 = phi double [ %t11, %entry ], [ %t209, %loop.latch2 ]
  %t216 = phi i1 [ %t9, %entry ], [ %t210, %loop.latch2 ]
  %t217 = phi double [ %t6, %entry ], [ %t211, %loop.latch2 ]
  %t218 = phi double [ %t7, %entry ], [ %t212, %loop.latch2 ]
  %t219 = phi double [ %t8, %entry ], [ %t213, %loop.latch2 ]
  store i1 %t214, i1* %l4
  store double %t215, double* %l5
  store i1 %t216, i1* %l3
  store double %t217, double* %l0
  store double %t218, double* %l1
  store double %t219, double* %l2
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l5
  %t13 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t12, %t14
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load i1, i1* %l3
  %t20 = load i1, i1* %l4
  %t21 = load double, double* %l5
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l5
  %t23 = fptosi double %t22 to i64
  %t24 = getelementptr i8, i8* %text, i64 %t23
  %t25 = load i8, i8* %t24
  store i8 %t25, i8* %l6
  %t26 = load i1, i1* %l3
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load i1, i1* %l3
  %t31 = load i1, i1* %l4
  %t32 = load double, double* %l5
  %t33 = load i8, i8* %l6
  br i1 %t26, label %then6, label %merge7
then6:
  %t34 = load i1, i1* %l4
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l2
  %t38 = load i1, i1* %l3
  %t39 = load i1, i1* %l4
  %t40 = load double, double* %l5
  %t41 = load i8, i8* %l6
  br i1 %t34, label %then8, label %merge9
then8:
  store i1 0, i1* %l4
  %t42 = load double, double* %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l5
  br label %loop.latch2
merge9:
  %t45 = load i8, i8* %l6
  %t46 = icmp eq i8 %t45, 92
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load i1, i1* %l3
  %t51 = load i1, i1* %l4
  %t52 = load double, double* %l5
  %t53 = load i8, i8* %l6
  br i1 %t46, label %then10, label %merge11
then10:
  store i1 1, i1* %l4
  %t54 = load double, double* %l5
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l5
  br label %loop.latch2
merge11:
  %t57 = load i8, i8* %l6
  %t58 = icmp eq i8 %t57, 34
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load i1, i1* %l3
  %t63 = load i1, i1* %l4
  %t64 = load double, double* %l5
  %t65 = load i8, i8* %l6
  br i1 %t58, label %then12, label %merge13
then12:
  store i1 0, i1* %l3
  br label %merge13
merge13:
  %t66 = phi i1 [ 0, %then12 ], [ %t62, %then6 ]
  store i1 %t66, i1* %l3
  %t67 = load double, double* %l5
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l5
  br label %loop.latch2
merge7:
  %t70 = load i8, i8* %l6
  %t71 = icmp eq i8 %t70, 34
  %t72 = load double, double* %l0
  %t73 = load double, double* %l1
  %t74 = load double, double* %l2
  %t75 = load i1, i1* %l3
  %t76 = load i1, i1* %l4
  %t77 = load double, double* %l5
  %t78 = load i8, i8* %l6
  br i1 %t71, label %then14, label %merge15
then14:
  store i1 1, i1* %l3
  %t79 = load double, double* %l5
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l5
  br label %loop.latch2
merge15:
  %t82 = load i8, i8* %l6
  %t83 = icmp eq i8 %t82, 40
  %t84 = load double, double* %l0
  %t85 = load double, double* %l1
  %t86 = load double, double* %l2
  %t87 = load i1, i1* %l3
  %t88 = load i1, i1* %l4
  %t89 = load double, double* %l5
  %t90 = load i8, i8* %l6
  br i1 %t83, label %then16, label %merge17
then16:
  %t91 = load double, double* %l0
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l0
  %t94 = load double, double* %l5
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l5
  br label %loop.latch2
merge17:
  %t97 = load i8, i8* %l6
  %t98 = icmp eq i8 %t97, 41
  %t99 = load double, double* %l0
  %t100 = load double, double* %l1
  %t101 = load double, double* %l2
  %t102 = load i1, i1* %l3
  %t103 = load i1, i1* %l4
  %t104 = load double, double* %l5
  %t105 = load i8, i8* %l6
  br i1 %t98, label %then18, label %merge19
then18:
  %t106 = load double, double* %l0
  %t107 = sitofp i64 0 to double
  %t108 = fcmp ogt double %t106, %t107
  %t109 = load double, double* %l0
  %t110 = load double, double* %l1
  %t111 = load double, double* %l2
  %t112 = load i1, i1* %l3
  %t113 = load i1, i1* %l4
  %t114 = load double, double* %l5
  %t115 = load i8, i8* %l6
  br i1 %t108, label %then20, label %merge21
then20:
  %t116 = load double, double* %l0
  %t117 = sitofp i64 1 to double
  %t118 = fsub double %t116, %t117
  store double %t118, double* %l0
  br label %merge21
merge21:
  %t119 = phi double [ %t118, %then20 ], [ %t109, %then18 ]
  store double %t119, double* %l0
  %t120 = load double, double* %l5
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  store double %t122, double* %l5
  br label %loop.latch2
merge19:
  %t123 = load i8, i8* %l6
  %t124 = icmp eq i8 %t123, 91
  %t125 = load double, double* %l0
  %t126 = load double, double* %l1
  %t127 = load double, double* %l2
  %t128 = load i1, i1* %l3
  %t129 = load i1, i1* %l4
  %t130 = load double, double* %l5
  %t131 = load i8, i8* %l6
  br i1 %t124, label %then22, label %merge23
then22:
  %t132 = load double, double* %l1
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l1
  %t135 = load double, double* %l5
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l5
  br label %loop.latch2
merge23:
  %t138 = load i8, i8* %l6
  %t139 = icmp eq i8 %t138, 93
  %t140 = load double, double* %l0
  %t141 = load double, double* %l1
  %t142 = load double, double* %l2
  %t143 = load i1, i1* %l3
  %t144 = load i1, i1* %l4
  %t145 = load double, double* %l5
  %t146 = load i8, i8* %l6
  br i1 %t139, label %then24, label %merge25
then24:
  %t147 = load double, double* %l1
  %t148 = sitofp i64 0 to double
  %t149 = fcmp ogt double %t147, %t148
  %t150 = load double, double* %l0
  %t151 = load double, double* %l1
  %t152 = load double, double* %l2
  %t153 = load i1, i1* %l3
  %t154 = load i1, i1* %l4
  %t155 = load double, double* %l5
  %t156 = load i8, i8* %l6
  br i1 %t149, label %then26, label %merge27
then26:
  %t157 = load double, double* %l1
  %t158 = sitofp i64 1 to double
  %t159 = fsub double %t157, %t158
  store double %t159, double* %l1
  br label %merge27
merge27:
  %t160 = phi double [ %t159, %then26 ], [ %t151, %then24 ]
  store double %t160, double* %l1
  %t161 = load double, double* %l5
  %t162 = sitofp i64 1 to double
  %t163 = fadd double %t161, %t162
  store double %t163, double* %l5
  br label %loop.latch2
merge25:
  %t164 = load i8, i8* %l6
  %t165 = icmp eq i8 %t164, 123
  %t166 = load double, double* %l0
  %t167 = load double, double* %l1
  %t168 = load double, double* %l2
  %t169 = load i1, i1* %l3
  %t170 = load i1, i1* %l4
  %t171 = load double, double* %l5
  %t172 = load i8, i8* %l6
  br i1 %t165, label %then28, label %merge29
then28:
  %t173 = load double, double* %l2
  %t174 = sitofp i64 1 to double
  %t175 = fadd double %t173, %t174
  store double %t175, double* %l2
  %t176 = load double, double* %l5
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l5
  br label %loop.latch2
merge29:
  %t179 = load i8, i8* %l6
  %t180 = icmp eq i8 %t179, 125
  %t181 = load double, double* %l0
  %t182 = load double, double* %l1
  %t183 = load double, double* %l2
  %t184 = load i1, i1* %l3
  %t185 = load i1, i1* %l4
  %t186 = load double, double* %l5
  %t187 = load i8, i8* %l6
  br i1 %t180, label %then30, label %merge31
then30:
  %t188 = load double, double* %l2
  %t189 = sitofp i64 0 to double
  %t190 = fcmp ogt double %t188, %t189
  %t191 = load double, double* %l0
  %t192 = load double, double* %l1
  %t193 = load double, double* %l2
  %t194 = load i1, i1* %l3
  %t195 = load i1, i1* %l4
  %t196 = load double, double* %l5
  %t197 = load i8, i8* %l6
  br i1 %t190, label %then32, label %merge33
then32:
  %t198 = load double, double* %l2
  %t199 = sitofp i64 1 to double
  %t200 = fsub double %t198, %t199
  store double %t200, double* %l2
  br label %merge33
merge33:
  %t201 = phi double [ %t200, %then32 ], [ %t193, %then30 ]
  store double %t201, double* %l2
  %t202 = load double, double* %l5
  %t203 = sitofp i64 1 to double
  %t204 = fadd double %t202, %t203
  store double %t204, double* %l5
  br label %loop.latch2
merge31:
  %t205 = load double, double* %l5
  %t206 = sitofp i64 1 to double
  %t207 = fadd double %t205, %t206
  store double %t207, double* %l5
  br label %loop.latch2
loop.latch2:
  %t208 = load i1, i1* %l4
  %t209 = load double, double* %l5
  %t210 = load i1, i1* %l3
  %t211 = load double, double* %l0
  %t212 = load double, double* %l1
  %t213 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t220 = load double, double* %l0
  %t221 = insertvalue %InstructionDepthState undef, double %t220, 0
  %t222 = load double, double* %l1
  %t223 = insertvalue %InstructionDepthState %t221, double %t222, 1
  %t224 = load double, double* %l2
  %t225 = insertvalue %InstructionDepthState %t223, double %t224, 2
  %t226 = load i1, i1* %l3
  %t227 = insertvalue %InstructionDepthState %t225, i1 %t226, 3
  %t228 = load i1, i1* %l4
  %t229 = insertvalue %InstructionDepthState %t227, i1 %t228, 4
  ret %InstructionDepthState %t229
}

define %InstructionParseResult @parse_instruction(i8* %line, i8* %span, i8* %value_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i1
  %l11 = alloca %BindingComponents
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %line, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = insertvalue %NativeInstruction undef, i32 15, 0
  %t3 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t4 = insertvalue %InstructionParseResult %t3, i1 0, 1
  %t5 = insertvalue %InstructionParseResult %t4, i1 0, 2
  ret %InstructionParseResult %t5
merge1:
  %s6 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i1 @starts_with(i8* %line, i8* %s6)
  br i1 %t7, label %then2, label %merge3
then2:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = call i8* @strip_prefix(i8* %line, i8* %s8)
  %t10 = call i8* @trim_text(i8* %t9)
  store i8* %t10, i8** %l0
  %t11 = alloca %NativeInstruction
  %t12 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t11, i32 0, i32 0
  store i32 3, i32* %t12
  %t13 = load i8*, i8** %l0
  %t14 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t11, i32 0, i32 1
  %t15 = bitcast [8 x i8]* %t14 to i8*
  %t16 = bitcast i8* %t15 to i8**
  store i8* %t13, i8** %t16
  %t17 = load %NativeInstruction, %NativeInstruction* %t11
  %t18 = alloca [1 x %NativeInstruction]
  %t19 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t18, i32 0, i32 0
  %t20 = getelementptr %NativeInstruction, %NativeInstruction* %t19, i64 0
  store %NativeInstruction %t17, %NativeInstruction* %t20
  %t21 = alloca { %NativeInstruction*, i64 }
  %t22 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t21, i32 0, i32 0
  store %NativeInstruction* %t19, %NativeInstruction** %t22
  %t23 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { %NativeInstruction*, i64 }* %t21 to { i8**, i64 }*
  %t25 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t24, 0
  %t26 = insertvalue %InstructionParseResult %t25, i1 0, 1
  %t27 = insertvalue %InstructionParseResult %t26, i1 0, 2
  ret %InstructionParseResult %t27
merge3:
  %s28 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.28, i32 0, i32 0
  %t29 = icmp eq i8* %line, %s28
  br i1 %t29, label %then4, label %merge5
then4:
  %t30 = insertvalue %NativeInstruction undef, i32 4, 0
  %t31 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t32 = insertvalue %InstructionParseResult %t31, i1 0, 1
  %t33 = insertvalue %InstructionParseResult %t32, i1 0, 2
  ret %InstructionParseResult %t33
merge5:
  %s34 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.34, i32 0, i32 0
  %t35 = icmp eq i8* %line, %s34
  br i1 %t35, label %then6, label %merge7
then6:
  %t36 = insertvalue %NativeInstruction undef, i32 5, 0
  %t37 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t38 = insertvalue %InstructionParseResult %t37, i1 0, 1
  %t39 = insertvalue %InstructionParseResult %t38, i1 0, 2
  ret %InstructionParseResult %t39
merge7:
  %s40 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.40, i32 0, i32 0
  %t41 = call i1 @starts_with(i8* %line, i8* %s40)
  br i1 %t41, label %then8, label %merge9
then8:
  %s42 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.42, i32 0, i32 0
  %t43 = call i8* @strip_prefix(i8* %line, i8* %s42)
  %t44 = call i8* @trim_text(i8* %t43)
  store i8* %t44, i8** %l1
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.45, i32 0, i32 0
  store i8* %s45, i8** %l2
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l2
  %t48 = call double @index_of(i8* %t46, i8* %t47)
  store double %t48, double* %l3
  %t49 = load double, double* %l3
  %t50 = sitofp i64 0 to double
  %t51 = fcmp oge double %t49, %t50
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l3
  br i1 %t51, label %then10, label %merge11
then10:
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l3
  %t57 = fptosi double %t56 to i64
  %t58 = call i8* @sailfin_runtime_substring(i8* %t55, i64 0, i64 %t57)
  %t59 = call i8* @trim_text(i8* %t58)
  store i8* %t59, i8** %l4
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l3
  %t62 = load i8*, i8** %l2
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = sitofp i64 %t63 to double
  %t65 = fadd double %t61, %t64
  %t66 = load i8*, i8** %l1
  %t67 = call i64 @sailfin_runtime_string_length(i8* %t66)
  %t68 = fptosi double %t65 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %t60, i64 %t68, i64 %t67)
  %t70 = call i8* @trim_text(i8* %t69)
  store i8* %t70, i8** %l5
  %t71 = alloca %NativeInstruction
  %t72 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t71, i32 0, i32 0
  store i32 6, i32* %t72
  %t73 = load i8*, i8** %l4
  %t74 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t71, i32 0, i32 1
  %t75 = bitcast [16 x i8]* %t74 to i8*
  %t76 = bitcast i8* %t75 to i8**
  store i8* %t73, i8** %t76
  %t77 = load i8*, i8** %l5
  %t78 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t71, i32 0, i32 1
  %t79 = bitcast [16 x i8]* %t78 to i8*
  %t80 = getelementptr inbounds i8, i8* %t79, i64 8
  %t81 = bitcast i8* %t80 to i8**
  store i8* %t77, i8** %t81
  %t82 = load %NativeInstruction, %NativeInstruction* %t71
  %t83 = alloca [1 x %NativeInstruction]
  %t84 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t83, i32 0, i32 0
  %t85 = getelementptr %NativeInstruction, %NativeInstruction* %t84, i64 0
  store %NativeInstruction %t82, %NativeInstruction* %t85
  %t86 = alloca { %NativeInstruction*, i64 }
  %t87 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t86, i32 0, i32 0
  store %NativeInstruction* %t84, %NativeInstruction** %t87
  %t88 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t86, i32 0, i32 1
  store i64 1, i64* %t88
  %t89 = bitcast { %NativeInstruction*, i64 }* %t86 to { i8**, i64 }*
  %t90 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t89, 0
  %t91 = insertvalue %InstructionParseResult %t90, i1 0, 1
  %t92 = insertvalue %InstructionParseResult %t91, i1 0, 2
  ret %InstructionParseResult %t92
merge11:
  br label %merge9
merge9:
  %s93 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.93, i32 0, i32 0
  %t94 = icmp eq i8* %line, %s93
  br i1 %t94, label %then12, label %merge13
then12:
  %t95 = insertvalue %NativeInstruction undef, i32 7, 0
  %t96 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t97 = insertvalue %InstructionParseResult %t96, i1 0, 1
  %t98 = insertvalue %InstructionParseResult %t97, i1 0, 2
  ret %InstructionParseResult %t98
merge13:
  %s99 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.99, i32 0, i32 0
  %t100 = icmp eq i8* %line, %s99
  br i1 %t100, label %then14, label %merge15
then14:
  %t101 = insertvalue %NativeInstruction undef, i32 8, 0
  %t102 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t103 = insertvalue %InstructionParseResult %t102, i1 0, 1
  %t104 = insertvalue %InstructionParseResult %t103, i1 0, 2
  ret %InstructionParseResult %t104
merge15:
  %s105 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.105, i32 0, i32 0
  %t106 = icmp eq i8* %line, %s105
  br i1 %t106, label %then16, label %merge17
then16:
  %t107 = insertvalue %NativeInstruction undef, i32 9, 0
  %t108 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t109 = insertvalue %InstructionParseResult %t108, i1 0, 1
  %t110 = insertvalue %InstructionParseResult %t109, i1 0, 2
  ret %InstructionParseResult %t110
merge17:
  %s111 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.111, i32 0, i32 0
  %t112 = icmp eq i8* %line, %s111
  br i1 %t112, label %then18, label %merge19
then18:
  %t113 = insertvalue %NativeInstruction undef, i32 10, 0
  %t114 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t115 = insertvalue %InstructionParseResult %t114, i1 0, 1
  %t116 = insertvalue %InstructionParseResult %t115, i1 0, 2
  ret %InstructionParseResult %t116
merge19:
  %s117 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.117, i32 0, i32 0
  %t118 = icmp eq i8* %line, %s117
  br i1 %t118, label %then20, label %merge21
then20:
  %t119 = insertvalue %NativeInstruction undef, i32 11, 0
  %t120 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t121 = insertvalue %InstructionParseResult %t120, i1 0, 1
  %t122 = insertvalue %InstructionParseResult %t121, i1 0, 2
  ret %InstructionParseResult %t122
merge21:
  %s123 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.123, i32 0, i32 0
  %t124 = call i1 @starts_with(i8* %line, i8* %s123)
  br i1 %t124, label %then22, label %merge23
then22:
  %s125 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  %t126 = call i8* @strip_prefix(i8* %line, i8* %s125)
  %t127 = call i8* @trim_text(i8* %t126)
  store i8* %t127, i8** %l6
  %t128 = alloca %NativeInstruction
  %t129 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t128, i32 0, i32 0
  store i32 12, i32* %t129
  %t130 = load i8*, i8** %l6
  %t131 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t128, i32 0, i32 1
  %t132 = bitcast [8 x i8]* %t131 to i8*
  %t133 = bitcast i8* %t132 to i8**
  store i8* %t130, i8** %t133
  %t134 = load %NativeInstruction, %NativeInstruction* %t128
  %t135 = alloca [1 x %NativeInstruction]
  %t136 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t135, i32 0, i32 0
  %t137 = getelementptr %NativeInstruction, %NativeInstruction* %t136, i64 0
  store %NativeInstruction %t134, %NativeInstruction* %t137
  %t138 = alloca { %NativeInstruction*, i64 }
  %t139 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t138, i32 0, i32 0
  store %NativeInstruction* %t136, %NativeInstruction** %t139
  %t140 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t138, i32 0, i32 1
  store i64 1, i64* %t140
  %t141 = bitcast { %NativeInstruction*, i64 }* %t138 to { i8**, i64 }*
  %t142 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t141, 0
  %t143 = insertvalue %InstructionParseResult %t142, i1 0, 1
  %t144 = insertvalue %InstructionParseResult %t143, i1 0, 2
  ret %InstructionParseResult %t144
merge23:
  %s145 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.145, i32 0, i32 0
  %t146 = call i1 @starts_with(i8* %line, i8* %s145)
  br i1 %t146, label %then24, label %merge25
then24:
  %t147 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t148 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t149 = insertvalue %InstructionParseResult %t148, i1 0, 1
  %t150 = insertvalue %InstructionParseResult %t149, i1 0, 2
  ret %InstructionParseResult %t150
merge25:
  %s151 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.151, i32 0, i32 0
  %t152 = icmp eq i8* %line, %s151
  br i1 %t152, label %then26, label %merge27
then26:
  %t153 = insertvalue %NativeInstruction undef, i32 14, 0
  %t154 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t155 = insertvalue %InstructionParseResult %t154, i1 0, 1
  %t156 = insertvalue %InstructionParseResult %t155, i1 0, 2
  ret %InstructionParseResult %t156
merge27:
  %s157 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.157, i32 0, i32 0
  %t158 = call i1 @starts_with(i8* %line, i8* %s157)
  br i1 %t158, label %then28, label %merge29
then28:
  %t159 = call %NativeInstruction @parse_let_instruction(i8* %line, i8* %span, i8* %value_span)
  %t160 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t161 = insertvalue %InstructionParseResult %t160, i1 1, 1
  %t162 = insertvalue %InstructionParseResult %t161, i1 1, 2
  ret %InstructionParseResult %t162
merge29:
  %s163 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.163, i32 0, i32 0
  %t164 = call i1 @starts_with(i8* %line, i8* %s163)
  br i1 %t164, label %then30, label %merge31
then30:
  %t165 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t166 = icmp eq i64 %t165, 3
  br i1 %t166, label %then32, label %merge33
then32:
  %t167 = alloca %NativeInstruction
  %t168 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t167, i32 0, i32 0
  store i32 0, i32* %t168
  %s169 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.169, i32 0, i32 0
  %t170 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t167, i32 0, i32 1
  %t171 = bitcast [16 x i8]* %t170 to i8*
  %t172 = bitcast i8* %t171 to i8**
  store i8* %s169, i8** %t172
  %t173 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t167, i32 0, i32 1
  %t174 = bitcast [16 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 8
  %t176 = bitcast i8* %t175 to i8**
  store i8* %span, i8** %t176
  %t177 = load %NativeInstruction, %NativeInstruction* %t167
  %t178 = alloca [1 x %NativeInstruction]
  %t179 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t178, i32 0, i32 0
  %t180 = getelementptr %NativeInstruction, %NativeInstruction* %t179, i64 0
  store %NativeInstruction %t177, %NativeInstruction* %t180
  %t181 = alloca { %NativeInstruction*, i64 }
  %t182 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t181, i32 0, i32 0
  store %NativeInstruction* %t179, %NativeInstruction** %t182
  %t183 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t181, i32 0, i32 1
  store i64 1, i64* %t183
  %t184 = bitcast { %NativeInstruction*, i64 }* %t181 to { i8**, i64 }*
  %t185 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t184, 0
  %t186 = insertvalue %InstructionParseResult %t185, i1 1, 1
  %t187 = insertvalue %InstructionParseResult %t186, i1 0, 2
  ret %InstructionParseResult %t187
merge33:
  %t188 = getelementptr i8, i8* %line, i64 3
  %t189 = load i8, i8* %t188
  store i8 %t189, i8* %l7
  %t191 = load i8, i8* %l7
  %t192 = icmp eq i8 %t191, 32
  br label %logical_or_entry_190

logical_or_entry_190:
  br i1 %t192, label %logical_or_merge_190, label %logical_or_right_190

logical_or_right_190:
  %t193 = load i8, i8* %l7
  %t194 = icmp eq i8 %t193, 9
  br label %logical_or_right_end_190

logical_or_right_end_190:
  br label %logical_or_merge_190

logical_or_merge_190:
  %t195 = phi i1 [ true, %logical_or_entry_190 ], [ %t194, %logical_or_right_end_190 ]
  %t196 = load i8, i8* %l7
  br i1 %t195, label %then34, label %merge35
then34:
  %t197 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t198 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t197)
  %t199 = call i8* @trim_text(i8* %t198)
  store i8* %t199, i8** %l8
  %t200 = load i8*, i8** %l8
  %t201 = call i64 @sailfin_runtime_string_length(i8* %t200)
  %t202 = icmp eq i64 %t201, 0
  %t203 = load i8, i8* %l7
  %t204 = load i8*, i8** %l8
  br i1 %t202, label %then36, label %merge37
then36:
  %t205 = alloca %NativeInstruction
  %t206 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t205, i32 0, i32 0
  store i32 0, i32* %t206
  %s207 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.207, i32 0, i32 0
  %t208 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t205, i32 0, i32 1
  %t209 = bitcast [16 x i8]* %t208 to i8*
  %t210 = bitcast i8* %t209 to i8**
  store i8* %s207, i8** %t210
  %t211 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t205, i32 0, i32 1
  %t212 = bitcast [16 x i8]* %t211 to i8*
  %t213 = getelementptr inbounds i8, i8* %t212, i64 8
  %t214 = bitcast i8* %t213 to i8**
  store i8* %span, i8** %t214
  %t215 = load %NativeInstruction, %NativeInstruction* %t205
  %t216 = alloca [1 x %NativeInstruction]
  %t217 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t216, i32 0, i32 0
  %t218 = getelementptr %NativeInstruction, %NativeInstruction* %t217, i64 0
  store %NativeInstruction %t215, %NativeInstruction* %t218
  %t219 = alloca { %NativeInstruction*, i64 }
  %t220 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t219, i32 0, i32 0
  store %NativeInstruction* %t217, %NativeInstruction** %t220
  %t221 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t219, i32 0, i32 1
  store i64 1, i64* %t221
  %t222 = bitcast { %NativeInstruction*, i64 }* %t219 to { i8**, i64 }*
  %t223 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t222, 0
  %t224 = insertvalue %InstructionParseResult %t223, i1 1, 1
  %t225 = insertvalue %InstructionParseResult %t224, i1 0, 2
  ret %InstructionParseResult %t225
merge37:
  %t226 = alloca %NativeInstruction
  %t227 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t226, i32 0, i32 0
  store i32 0, i32* %t227
  %t228 = load i8*, i8** %l8
  %t229 = call i8* @trim_trailing_delimiters(i8* %t228)
  %t230 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t226, i32 0, i32 1
  %t231 = bitcast [16 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  store i8* %t229, i8** %t232
  %t233 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t226, i32 0, i32 1
  %t234 = bitcast [16 x i8]* %t233 to i8*
  %t235 = getelementptr inbounds i8, i8* %t234, i64 8
  %t236 = bitcast i8* %t235 to i8**
  store i8* %span, i8** %t236
  %t237 = load %NativeInstruction, %NativeInstruction* %t226
  %t238 = alloca [1 x %NativeInstruction]
  %t239 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t238, i32 0, i32 0
  %t240 = getelementptr %NativeInstruction, %NativeInstruction* %t239, i64 0
  store %NativeInstruction %t237, %NativeInstruction* %t240
  %t241 = alloca { %NativeInstruction*, i64 }
  %t242 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t241, i32 0, i32 0
  store %NativeInstruction* %t239, %NativeInstruction** %t242
  %t243 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t241, i32 0, i32 1
  store i64 1, i64* %t243
  %t244 = bitcast { %NativeInstruction*, i64 }* %t241 to { i8**, i64 }*
  %t245 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t244, 0
  %t246 = insertvalue %InstructionParseResult %t245, i1 1, 1
  %t247 = insertvalue %InstructionParseResult %t246, i1 0, 2
  ret %InstructionParseResult %t247
merge35:
  br label %merge31
merge31:
  %s248 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.248, i32 0, i32 0
  %t249 = call i1 @starts_with(i8* %line, i8* %s248)
  br i1 %t249, label %then38, label %merge39
then38:
  %s250 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.250, i32 0, i32 0
  %t251 = call i8* @strip_prefix(i8* %line, i8* %s250)
  %t252 = call i8* @trim_text(i8* %t251)
  store i8* %t252, i8** %l9
  store i1 0, i1* %l10
  %t253 = load i8*, i8** %l9
  %s254 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.254, i32 0, i32 0
  %t255 = call i1 @starts_with(i8* %t253, i8* %s254)
  %t256 = load i8*, i8** %l9
  %t257 = load i1, i1* %l10
  br i1 %t255, label %then40, label %merge41
then40:
  store i1 1, i1* %l10
  %t258 = load i8*, i8** %l9
  %s259 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.259, i32 0, i32 0
  %t260 = call i8* @strip_prefix(i8* %t258, i8* %s259)
  %t261 = call i8* @trim_text(i8* %t260)
  store i8* %t261, i8** %l9
  br label %merge41
merge41:
  %t262 = phi i1 [ 1, %then40 ], [ %t257, %then38 ]
  %t263 = phi i8* [ %t261, %then40 ], [ %t256, %then38 ]
  store i1 %t262, i1* %l10
  store i8* %t263, i8** %l9
  %t264 = load i8*, i8** %l9
  %t265 = call %BindingComponents @parse_binding_components(i8* %t264)
  store %BindingComponents %t265, %BindingComponents* %l11
  %t266 = alloca %NativeInstruction
  %t267 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 0
  store i32 2, i32* %t267
  %t268 = load %BindingComponents, %BindingComponents* %l11
  %t269 = extractvalue %BindingComponents %t268, 0
  %t270 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t271 = bitcast [48 x i8]* %t270 to i8*
  %t272 = bitcast i8* %t271 to i8**
  store i8* %t269, i8** %t272
  %t273 = load i1, i1* %l10
  %t274 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t275 = bitcast [48 x i8]* %t274 to i8*
  %t276 = getelementptr inbounds i8, i8* %t275, i64 8
  %t277 = bitcast i8* %t276 to i1*
  store i1 %t273, i1* %t277
  %t278 = load %BindingComponents, %BindingComponents* %l11
  %t279 = extractvalue %BindingComponents %t278, 1
  %t280 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t281 = bitcast [48 x i8]* %t280 to i8*
  %t282 = getelementptr inbounds i8, i8* %t281, i64 16
  %t283 = bitcast i8* %t282 to i8**
  store i8* %t279, i8** %t283
  %t284 = load %BindingComponents, %BindingComponents* %l11
  %t285 = extractvalue %BindingComponents %t284, 2
  %t286 = call double @maybe_trim_trailing(i8* %t285)
  %t287 = call noalias i8* @malloc(i64 8)
  %t288 = bitcast i8* %t287 to double*
  store double %t286, double* %t288
  %t289 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t290 = bitcast [48 x i8]* %t289 to i8*
  %t291 = getelementptr inbounds i8, i8* %t290, i64 24
  %t292 = bitcast i8* %t291 to i8**
  store i8* %t287, i8** %t292
  %t293 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t294 = bitcast [48 x i8]* %t293 to i8*
  %t295 = getelementptr inbounds i8, i8* %t294, i64 32
  %t296 = bitcast i8* %t295 to i8**
  store i8* %span, i8** %t296
  %t297 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t298 = bitcast [48 x i8]* %t297 to i8*
  %t299 = getelementptr inbounds i8, i8* %t298, i64 40
  %t300 = bitcast i8* %t299 to i8**
  store i8* %value_span, i8** %t300
  %t301 = load %NativeInstruction, %NativeInstruction* %t266
  %t302 = alloca [1 x %NativeInstruction]
  %t303 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t302, i32 0, i32 0
  %t304 = getelementptr %NativeInstruction, %NativeInstruction* %t303, i64 0
  store %NativeInstruction %t301, %NativeInstruction* %t304
  %t305 = alloca { %NativeInstruction*, i64 }
  %t306 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t305, i32 0, i32 0
  store %NativeInstruction* %t303, %NativeInstruction** %t306
  %t307 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t305, i32 0, i32 1
  store i64 1, i64* %t307
  %t308 = bitcast { %NativeInstruction*, i64 }* %t305 to { i8**, i64 }*
  %t309 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t308, 0
  %t310 = insertvalue %InstructionParseResult %t309, i1 1, 1
  %t311 = insertvalue %InstructionParseResult %t310, i1 1, 2
  ret %InstructionParseResult %t311
merge39:
  %s312 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.312, i32 0, i32 0
  %t313 = call i1 @starts_with(i8* %line, i8* %s312)
  br i1 %t313, label %then42, label %merge43
then42:
  %t314 = alloca %NativeInstruction
  %t315 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t314, i32 0, i32 0
  store i32 1, i32* %t315
  %s316 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.316, i32 0, i32 0
  %t317 = call i8* @strip_prefix(i8* %line, i8* %s316)
  %t318 = call i8* @trim_text(i8* %t317)
  %t319 = call i8* @trim_trailing_delimiters(i8* %t318)
  %t320 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t314, i32 0, i32 1
  %t321 = bitcast [16 x i8]* %t320 to i8*
  %t322 = bitcast i8* %t321 to i8**
  store i8* %t319, i8** %t322
  %t323 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t314, i32 0, i32 1
  %t324 = bitcast [16 x i8]* %t323 to i8*
  %t325 = getelementptr inbounds i8, i8* %t324, i64 8
  %t326 = bitcast i8* %t325 to i8**
  store i8* %span, i8** %t326
  %t327 = load %NativeInstruction, %NativeInstruction* %t314
  %t328 = alloca [1 x %NativeInstruction]
  %t329 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t328, i32 0, i32 0
  %t330 = getelementptr %NativeInstruction, %NativeInstruction* %t329, i64 0
  store %NativeInstruction %t327, %NativeInstruction* %t330
  %t331 = alloca { %NativeInstruction*, i64 }
  %t332 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t331, i32 0, i32 0
  store %NativeInstruction* %t329, %NativeInstruction** %t332
  %t333 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t331, i32 0, i32 1
  store i64 1, i64* %t333
  %t334 = bitcast { %NativeInstruction*, i64 }* %t331 to { i8**, i64 }*
  %t335 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t334, 0
  %t336 = insertvalue %InstructionParseResult %t335, i1 1, 1
  %t337 = insertvalue %InstructionParseResult %t336, i1 0, 2
  ret %InstructionParseResult %t337
merge43:
  %t338 = alloca %NativeInstruction
  %t339 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t338, i32 0, i32 0
  store i32 16, i32* %t339
  %t340 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t338, i32 0, i32 1
  %t341 = bitcast [8 x i8]* %t340 to i8*
  %t342 = bitcast i8* %t341 to i8**
  store i8* %line, i8** %t342
  %t343 = load %NativeInstruction, %NativeInstruction* %t338
  %t344 = alloca [1 x %NativeInstruction]
  %t345 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t344, i32 0, i32 0
  %t346 = getelementptr %NativeInstruction, %NativeInstruction* %t345, i64 0
  store %NativeInstruction %t343, %NativeInstruction* %t346
  %t347 = alloca { %NativeInstruction*, i64 }
  %t348 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t347, i32 0, i32 0
  store %NativeInstruction* %t345, %NativeInstruction** %t348
  %t349 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t347, i32 0, i32 1
  store i64 1, i64* %t349
  %t350 = bitcast { %NativeInstruction*, i64 }* %t347 to { i8**, i64 }*
  %t351 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t350, 0
  %t352 = insertvalue %InstructionParseResult %t351, i1 0, 1
  %t353 = insertvalue %InstructionParseResult %t352, i1 0, 2
  ret %InstructionParseResult %t353
}

define %NativeInstruction @parse_case_instruction(i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %CaseComponents
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call %CaseComponents @split_case_components(i8* %t3)
  store %CaseComponents %t4, %CaseComponents* %l1
  %t5 = alloca %NativeInstruction
  %t6 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 0
  store i32 13, i32* %t6
  %t7 = load %CaseComponents, %CaseComponents* %l1
  %t8 = extractvalue %CaseComponents %t7, 0
  %t9 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = bitcast i8* %t10 to i8**
  store i8* %t8, i8** %t11
  %t12 = load %CaseComponents, %CaseComponents* %l1
  %t13 = extractvalue %CaseComponents %t12, 1
  %t14 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 1
  %t15 = bitcast [16 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 8
  %t17 = bitcast i8* %t16 to i8**
  store i8* %t13, i8** %t17
  %t18 = load %NativeInstruction, %NativeInstruction* %t5
  ret %NativeInstruction %t18
}

define { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca %CaseComponents
  %l5 = alloca { %NativeInstruction*, i64 }*
  %l6 = alloca %NativeInstruction
  %t0 = call i8* @trim_text(i8* %line)
  %t1 = call i8* @trim_trailing_delimiters(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t3 = load double, double* %l1
  %t4 = sitofp i64 0 to double
  %t5 = fcmp olt double %t3, %t4
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = alloca %NativeInstruction
  %t9 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t8, i32 0, i32 0
  store i32 16, i32* %t9
  %t10 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t8, i32 0, i32 1
  %t11 = bitcast [8 x i8]* %t10 to i8*
  %t12 = bitcast i8* %t11 to i8**
  store i8* %line, i8** %t12
  %t13 = load %NativeInstruction, %NativeInstruction* %t8
  %t14 = alloca [1 x %NativeInstruction]
  %t15 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t14, i32 0, i32 0
  %t16 = getelementptr %NativeInstruction, %NativeInstruction* %t15, i64 0
  store %NativeInstruction %t13, %NativeInstruction* %t16
  %t17 = alloca { %NativeInstruction*, i64 }
  %t18 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t17, i32 0, i32 0
  store %NativeInstruction* %t15, %NativeInstruction** %t18
  %t19 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t17, i32 0, i32 1
  store i64 1, i64* %t19
  ret { %NativeInstruction*, i64 }* %t17
merge1:
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = fptosi double %t21 to i64
  %t23 = call i8* @sailfin_runtime_substring(i8* %t20, i64 0, i64 %t22)
  %t24 = call i8* @trim_text(i8* %t23)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 2 to double
  %t28 = fadd double %t26, %t27
  %t29 = load i8*, i8** %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = fptosi double %t28 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t25, i64 %t31, i64 %t30)
  %t33 = call i8* @trim_text(i8* %t32)
  %t34 = call i8* @trim_trailing_delimiters(i8* %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l2
  %t36 = call %CaseComponents @split_case_components(i8* %t35)
  store %CaseComponents %t36, %CaseComponents* %l4
  %t37 = alloca [0 x %NativeInstruction]
  %t38 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* %t37, i32 0, i32 0
  %t39 = alloca { %NativeInstruction*, i64 }
  %t40 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t39, i32 0, i32 0
  store %NativeInstruction* %t38, %NativeInstruction** %t40
  %t41 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  store { %NativeInstruction*, i64 }* %t39, { %NativeInstruction*, i64 }** %l5
  %t42 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t43 = alloca %NativeInstruction
  %t44 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t43, i32 0, i32 0
  store i32 13, i32* %t44
  %t45 = load %CaseComponents, %CaseComponents* %l4
  %t46 = extractvalue %CaseComponents %t45, 0
  %t47 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t43, i32 0, i32 1
  %t48 = bitcast [16 x i8]* %t47 to i8*
  %t49 = bitcast i8* %t48 to i8**
  store i8* %t46, i8** %t49
  %t50 = load %CaseComponents, %CaseComponents* %l4
  %t51 = extractvalue %CaseComponents %t50, 1
  %t52 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t43, i32 0, i32 1
  %t53 = bitcast [16 x i8]* %t52 to i8*
  %t54 = getelementptr inbounds i8, i8* %t53, i64 8
  %t55 = bitcast i8* %t54 to i8**
  store i8* %t51, i8** %t55
  %t56 = load %NativeInstruction, %NativeInstruction* %t43
  %t57 = alloca [1 x %NativeInstruction]
  %t58 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t57, i32 0, i32 0
  %t59 = getelementptr %NativeInstruction, %NativeInstruction* %t58, i64 0
  store %NativeInstruction %t56, %NativeInstruction* %t59
  %t60 = alloca { %NativeInstruction*, i64 }
  %t61 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t60, i32 0, i32 0
  store %NativeInstruction* %t58, %NativeInstruction** %t61
  %t62 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = bitcast { %NativeInstruction*, i64 }* %t42 to { i8**, i64 }*
  %t64 = bitcast { %NativeInstruction*, i64 }* %t60 to { i8**, i64 }*
  %t65 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t63, { i8**, i64 }* %t64)
  %t66 = bitcast { i8**, i64 }* %t65 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t66, { %NativeInstruction*, i64 }** %l5
  %t67 = load i8*, i8** %l3
  %t68 = call i64 @sailfin_runtime_string_length(i8* %t67)
  %t69 = icmp eq i64 %t68, 0
  %t70 = load i8*, i8** %l0
  %t71 = load double, double* %l1
  %t72 = load i8*, i8** %l2
  %t73 = load i8*, i8** %l3
  %t74 = load %CaseComponents, %CaseComponents* %l4
  %t75 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t69, label %then2, label %merge3
then2:
  %t76 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t77 = insertvalue %NativeInstruction undef, i32 15, 0
  %t78 = alloca [1 x %NativeInstruction]
  %t79 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t78, i32 0, i32 0
  %t80 = getelementptr %NativeInstruction, %NativeInstruction* %t79, i64 0
  store %NativeInstruction %t77, %NativeInstruction* %t80
  %t81 = alloca { %NativeInstruction*, i64 }
  %t82 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t81, i32 0, i32 0
  store %NativeInstruction* %t79, %NativeInstruction** %t82
  %t83 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = bitcast { %NativeInstruction*, i64 }* %t76 to { i8**, i64 }*
  %t85 = bitcast { %NativeInstruction*, i64 }* %t81 to { i8**, i64 }*
  %t86 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t84, { i8**, i64 }* %t85)
  %t87 = bitcast { i8**, i64 }* %t86 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t87, { %NativeInstruction*, i64 }** %l5
  %t88 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t88
merge3:
  %t89 = load i8*, i8** %l3
  %t90 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t89)
  store %NativeInstruction %t90, %NativeInstruction* %l6
  %t91 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t92 = load %NativeInstruction, %NativeInstruction* %l6
  %t93 = alloca [1 x %NativeInstruction]
  %t94 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t93, i32 0, i32 0
  %t95 = getelementptr %NativeInstruction, %NativeInstruction* %t94, i64 0
  store %NativeInstruction %t92, %NativeInstruction* %t95
  %t96 = alloca { %NativeInstruction*, i64 }
  %t97 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t96, i32 0, i32 0
  store %NativeInstruction* %t94, %NativeInstruction** %t97
  %t98 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t96, i32 0, i32 1
  store i64 1, i64* %t98
  %t99 = bitcast { %NativeInstruction*, i64 }* %t91 to { i8**, i64 }*
  %t100 = bitcast { %NativeInstruction*, i64 }* %t96 to { i8**, i64 }*
  %t101 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t99, { i8**, i64 }* %t100)
  %t102 = bitcast { i8**, i64 }* %t101 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t102, { %NativeInstruction*, i64 }** %l5
  %t103 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t103
}

define %NativeInstruction @parse_inline_case_body_instruction(i8* %body) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_trailing_delimiters(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  %t9 = call i8* @trim_trailing_delimiters(i8* %t8)
  store i8* %t9, i8** %l1
  %t10 = alloca %NativeInstruction
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 0
  store i32 0, i32* %t11
  %t12 = load i8*, i8** %l1
  %t13 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t14 = bitcast [16 x i8]* %t13 to i8*
  %t15 = bitcast i8* %t14 to i8**
  store i8* %t12, i8** %t15
  %t16 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t17 = bitcast [16 x i8]* %t16 to i8*
  %t18 = getelementptr inbounds i8, i8* %t17, i64 8
  %t19 = bitcast i8* %t18 to i8**
  store i8* null, i8** %t19
  %t20 = load %NativeInstruction, %NativeInstruction* %t10
  ret %NativeInstruction %t20
merge1:
  %t21 = load i8*, i8** %l0
  %s22 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @starts_with(i8* %t21, i8* %s22)
  %t24 = load i8*, i8** %l0
  br i1 %t23, label %then2, label %merge3
then2:
  %t25 = alloca %NativeInstruction
  %t26 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t25, i32 0, i32 0
  store i32 1, i32* %t26
  %t27 = load i8*, i8** %l0
  %s28 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.28, i32 0, i32 0
  %t29 = call i8* @strip_prefix(i8* %t27, i8* %s28)
  %t30 = call i8* @trim_text(i8* %t29)
  %t31 = call i8* @trim_trailing_delimiters(i8* %t30)
  %t32 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t25, i32 0, i32 1
  %t33 = bitcast [16 x i8]* %t32 to i8*
  %t34 = bitcast i8* %t33 to i8**
  store i8* %t31, i8** %t34
  %t35 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t25, i32 0, i32 1
  %t36 = bitcast [16 x i8]* %t35 to i8*
  %t37 = getelementptr inbounds i8, i8* %t36, i64 8
  %t38 = bitcast i8* %t37 to i8**
  store i8* null, i8** %t38
  %t39 = load %NativeInstruction, %NativeInstruction* %t25
  ret %NativeInstruction %t39
merge3:
  %t40 = alloca %NativeInstruction
  %t41 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t40, i32 0, i32 0
  store i32 1, i32* %t41
  %t42 = load i8*, i8** %l0
  %t43 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t40, i32 0, i32 1
  %t44 = bitcast [16 x i8]* %t43 to i8*
  %t45 = bitcast i8* %t44 to i8**
  store i8* %t42, i8** %t45
  %t46 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t40, i32 0, i32 1
  %t47 = bitcast [16 x i8]* %t46 to i8*
  %t48 = getelementptr inbounds i8, i8* %t47, i64 8
  %t49 = bitcast i8* %t48 to i8**
  store i8* null, i8** %t49
  %t50 = load %NativeInstruction, %NativeInstruction* %t40
  ret %NativeInstruction %t50
}

define %CaseComponents @split_case_components(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %CaseComponents undef, i8* %t5, 0
  %t7 = insertvalue %CaseComponents %t6, i8* null, 1
  ret %CaseComponents %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l1
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = call double @last_index_of(i8* %t9, i8* %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %CaseComponents undef, i8* %t18, 0
  %t20 = insertvalue %CaseComponents %t19, i8* null, 1
  ret %CaseComponents %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = fptosi double %t22 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %t21, i64 0, i64 %t23)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l2
  %t28 = load i8*, i8** %l1
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = sitofp i64 %t29 to double
  %t31 = fadd double %t27, %t30
  %t32 = load i8*, i8** %l0
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = fptosi double %t31 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %t26, i64 %t34, i64 %t33)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l4
  %t37 = load i8*, i8** %l4
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load i8*, i8** %l4
  br i1 %t39, label %then4, label %merge5
then4:
  %t45 = load i8*, i8** %l3
  %t46 = insertvalue %CaseComponents undef, i8* %t45, 0
  %t47 = insertvalue %CaseComponents %t46, i8* null, 1
  ret %CaseComponents %t47
merge5:
  %t48 = load i8*, i8** %l3
  %t49 = insertvalue %CaseComponents undef, i8* %t48, 0
  %t50 = load i8*, i8** %l4
  %t51 = insertvalue %CaseComponents %t49, i8* %t50, 1
  ret %CaseComponents %t51
}

define { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca %NativeImportSpecifier
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x %NativeImportSpecifier]
  %t6 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t5, i32 0, i32 0
  %t7 = alloca { %NativeImportSpecifier*, i64 }
  %t8 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t7, i32 0, i32 0
  store %NativeImportSpecifier* %t6, %NativeImportSpecifier** %t8
  %t9 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { %NativeImportSpecifier*, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_comma_separated(i8* %t10)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t12 = alloca [0 x %NativeImportSpecifier]
  %t13 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t12, i32 0, i32 0
  %t14 = alloca { %NativeImportSpecifier*, i64 }
  %t15 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 0
  store %NativeImportSpecifier* %t13, %NativeImportSpecifier** %t15
  %t16 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %NativeImportSpecifier*, i64 }* %t14, { %NativeImportSpecifier*, i64 }** %l2
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l3
  %t18 = load i8*, i8** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t21 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t69 = phi { %NativeImportSpecifier*, i64 }* [ %t20, %entry ], [ %t67, %loop.latch4 ]
  %t70 = phi double [ %t21, %entry ], [ %t68, %loop.latch4 ]
  store { %NativeImportSpecifier*, i64 }* %t69, { %NativeImportSpecifier*, i64 }** %l2
  store double %t70, double* %l3
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = load double, double* %l3
  %t34 = fptosi double %t33 to i64
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  %t41 = call %NativeImportSpecifier @parse_single_specifier(i8* %t40)
  store %NativeImportSpecifier %t41, %NativeImportSpecifier* %l4
  %t42 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t43 = extractvalue %NativeImportSpecifier %t42, 0
  %t44 = call i64 @sailfin_runtime_string_length(i8* %t43)
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  br i1 %t45, label %then8, label %merge9
then8:
  %t51 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t52 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t53 = alloca [1 x %NativeImportSpecifier]
  %t54 = getelementptr [1 x %NativeImportSpecifier], [1 x %NativeImportSpecifier]* %t53, i32 0, i32 0
  %t55 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t54, i64 0
  store %NativeImportSpecifier %t52, %NativeImportSpecifier* %t55
  %t56 = alloca { %NativeImportSpecifier*, i64 }
  %t57 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t56, i32 0, i32 0
  store %NativeImportSpecifier* %t54, %NativeImportSpecifier** %t57
  %t58 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t56, i32 0, i32 1
  store i64 1, i64* %t58
  %t59 = bitcast { %NativeImportSpecifier*, i64 }* %t51 to { i8**, i64 }*
  %t60 = bitcast { %NativeImportSpecifier*, i64 }* %t56 to { i8**, i64 }*
  %t61 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t59, { i8**, i64 }* %t60)
  %t62 = bitcast { i8**, i64 }* %t61 to { %NativeImportSpecifier*, i64 }*
  store { %NativeImportSpecifier*, i64 }* %t62, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge9
merge9:
  %t63 = phi { %NativeImportSpecifier*, i64 }* [ %t62, %then8 ], [ %t48, %loop.body3 ]
  store { %NativeImportSpecifier*, i64 }* %t63, { %NativeImportSpecifier*, i64 }** %l2
  %t64 = load double, double* %l3
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l3
  br label %loop.latch4
loop.latch4:
  %t67 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t68 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t71 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t71
}

define %NativeImportSpecifier @parse_single_specifier(i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  %t6 = insertvalue %NativeImportSpecifier undef, i8* %s5, 0
  %t7 = insertvalue %NativeImportSpecifier %t6, i8* null, 1
  ret %NativeImportSpecifier %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l1
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = call double @index_of(i8* %t9, i8* %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %NativeImportSpecifier undef, i8* %t18, 0
  %t20 = insertvalue %NativeImportSpecifier %t19, i8* null, 1
  ret %NativeImportSpecifier %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = fptosi double %t22 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %t21, i64 0, i64 %t23)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l2
  %t28 = load i8*, i8** %l1
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = sitofp i64 %t29 to double
  %t31 = fadd double %t27, %t30
  %t32 = load i8*, i8** %l0
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = fptosi double %t31 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %t26, i64 %t34, i64 %t33)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l4
  %t37 = load i8*, i8** %l4
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load i8*, i8** %l4
  br i1 %t39, label %then4, label %merge5
then4:
  %t45 = load i8*, i8** %l3
  %t46 = insertvalue %NativeImportSpecifier undef, i8* %t45, 0
  %t47 = insertvalue %NativeImportSpecifier %t46, i8* null, 1
  ret %NativeImportSpecifier %t47
merge5:
  %t48 = load i8*, i8** %l3
  %t49 = insertvalue %NativeImportSpecifier undef, i8* %t48, 0
  %t50 = load i8*, i8** %l4
  %t51 = insertvalue %NativeImportSpecifier %t49, i8* %t50, 1
  ret %NativeImportSpecifier %t51
}

define %StructParseResult @parse_struct_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %StructHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %NativeStructField*, i64 }*
  %l7 = alloca { %NativeFunction*, i64 }*
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca { %NativeStructLayoutField*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i1
  %l15 = alloca i1
  %l16 = alloca double
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca double
  %l21 = alloca %InstructionParseResult
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca %StructLayoutHeaderParse
  %l25 = alloca %StructLayoutFieldParse
  %l26 = alloca double
  %l27 = alloca i8*
  %l28 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = fptosi double %start_index to i64
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %t13, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = call %StructHeaderParse @parse_struct_header(i8* %t17)
  store %StructHeaderParse %t18, %StructHeaderParse* %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t21 = extractvalue %StructHeaderParse %t20, 2
  %t22 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t19, { i8**, i64 }* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %t23 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t24 = extractvalue %StructHeaderParse %t23, 0
  store i8* %t24, i8** %l4
  %t25 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t26 = extractvalue %StructHeaderParse %t25, 1
  store { i8**, i64 }* %t26, { i8**, i64 }** %l5
  %t27 = load i8*, i8** %l4
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp eq i64 %t28, 0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i8*, i8** %l2
  %t33 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t34 = load i8*, i8** %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t29, label %then0, label %merge1
then0:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.37, i32 0, i32 0
  %t38 = load i8*, i8** %l1
  %t39 = add i8* %s37, %t38
  %t40 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  ret %StructParseResult zeroinitializer
merge1:
  %t41 = alloca [0 x %NativeStructField]
  %t42 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* %t41, i32 0, i32 0
  %t43 = alloca { %NativeStructField*, i64 }
  %t44 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t43, i32 0, i32 0
  store %NativeStructField* %t42, %NativeStructField** %t44
  %t45 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { %NativeStructField*, i64 }* %t43, { %NativeStructField*, i64 }** %l6
  %t46 = alloca [0 x %NativeFunction]
  %t47 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t46, i32 0, i32 0
  %t48 = alloca { %NativeFunction*, i64 }
  %t49 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t48, i32 0, i32 0
  store %NativeFunction* %t47, %NativeFunction** %t49
  %t50 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  store { %NativeFunction*, i64 }* %t48, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t51 = alloca [0 x %NativeStructLayoutField]
  %t52 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t51, i32 0, i32 0
  %t53 = alloca { %NativeStructLayoutField*, i64 }
  %t54 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t53, i32 0, i32 0
  store %NativeStructLayoutField* %t52, %NativeStructLayoutField** %t54
  %t55 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t53, i32 0, i32 1
  store i64 0, i64* %t55
  store { %NativeStructLayoutField*, i64 }* %t53, { %NativeStructLayoutField*, i64 }** %l11
  %t56 = sitofp i64 0 to double
  store double %t56, double* %l12
  %t57 = sitofp i64 0 to double
  store double %t57, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %start_index, %t58
  store double %t59, double* %l16
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load i8*, i8** %l2
  %t63 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t64 = load i8*, i8** %l4
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t66 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t67 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t68 = load i8*, i8** %l8
  %t69 = load i8*, i8** %l9
  %t70 = load i8*, i8** %l10
  %t71 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t72 = load double, double* %l12
  %t73 = load double, double* %l13
  %t74 = load i1, i1* %l14
  %t75 = load i1, i1* %l15
  %t76 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t974 = phi { i8**, i64 }* [ %t60, %entry ], [ %t963, %loop.latch4 ]
  %t975 = phi double [ %t76, %entry ], [ %t964, %loop.latch4 ]
  %t976 = phi { %NativeFunction*, i64 }* [ %t67, %entry ], [ %t965, %loop.latch4 ]
  %t977 = phi i8* [ %t68, %entry ], [ %t966, %loop.latch4 ]
  %t978 = phi i8* [ %t69, %entry ], [ %t967, %loop.latch4 ]
  %t979 = phi i8* [ %t70, %entry ], [ %t968, %loop.latch4 ]
  %t980 = phi double [ %t72, %entry ], [ %t969, %loop.latch4 ]
  %t981 = phi double [ %t73, %entry ], [ %t970, %loop.latch4 ]
  %t982 = phi i1 [ %t74, %entry ], [ %t971, %loop.latch4 ]
  %t983 = phi { %NativeStructLayoutField*, i64 }* [ %t71, %entry ], [ %t972, %loop.latch4 ]
  %t984 = phi i1 [ %t75, %entry ], [ %t973, %loop.latch4 ]
  store { i8**, i64 }* %t974, { i8**, i64 }** %l0
  store double %t975, double* %l16
  store { %NativeFunction*, i64 }* %t976, { %NativeFunction*, i64 }** %l7
  store i8* %t977, i8** %l8
  store i8* %t978, i8** %l9
  store i8* %t979, i8** %l10
  store double %t980, double* %l12
  store double %t981, double* %l13
  store i1 %t982, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t983, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t984, i1* %l15
  br label %loop.body3
loop.body3:
  %t77 = load double, double* %l16
  %t78 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t79 = extractvalue { i8**, i64 } %t78, 1
  %t80 = sitofp i64 %t79 to double
  %t81 = fcmp oge double %t77, %t80
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t86 = load i8*, i8** %l4
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t88 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t89 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t90 = load i8*, i8** %l8
  %t91 = load i8*, i8** %l9
  %t92 = load i8*, i8** %l10
  %t93 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t94 = load double, double* %l12
  %t95 = load double, double* %l13
  %t96 = load i1, i1* %l14
  %t97 = load i1, i1* %l15
  %t98 = load double, double* %l16
  br i1 %t81, label %then6, label %merge7
then6:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s100 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.100, i32 0, i32 0
  %t101 = load i8*, i8** %l4
  %t102 = add i8* %s100, %t101
  %t103 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t99, i8* %t102)
  store { i8**, i64 }* %t103, { i8**, i64 }** %l0
  store i8* null, i8** %l17
  %t104 = load i1, i1* %l14
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load i8*, i8** %l1
  %t107 = load i8*, i8** %l2
  %t108 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t109 = load i8*, i8** %l4
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t111 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t112 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t113 = load i8*, i8** %l8
  %t114 = load i8*, i8** %l9
  %t115 = load i8*, i8** %l10
  %t116 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t117 = load double, double* %l12
  %t118 = load double, double* %l13
  %t119 = load i1, i1* %l14
  %t120 = load i1, i1* %l15
  %t121 = load double, double* %l16
  %t122 = load i8*, i8** %l17
  br i1 %t104, label %then8, label %merge9
then8:
  %t123 = load double, double* %l12
  %t124 = insertvalue %NativeStructLayout undef, double %t123, 0
  %t125 = load double, double* %l13
  %t126 = insertvalue %NativeStructLayout %t124, double %t125, 1
  %t127 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t128 = bitcast { %NativeStructLayoutField*, i64 }* %t127 to { i8**, i64 }*
  %t129 = insertvalue %NativeStructLayout %t126, { i8**, i64 }* %t128, 2
  store i8* null, i8** %l17
  br label %merge9
merge9:
  %t130 = phi i8* [ null, %then8 ], [ %t122, %then6 ]
  store i8* %t130, i8** %l17
  %t131 = load i8*, i8** %l4
  %t132 = insertvalue %NativeStruct undef, i8* %t131, 0
  %t133 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t134 = bitcast { %NativeStructField*, i64 }* %t133 to { i8**, i64 }*
  %t135 = insertvalue %NativeStruct %t132, { i8**, i64 }* %t134, 1
  %t136 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t137 = bitcast { %NativeFunction*, i64 }* %t136 to { i8**, i64 }*
  %t138 = insertvalue %NativeStruct %t135, { i8**, i64 }* %t137, 2
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t140 = insertvalue %NativeStruct %t138, { i8**, i64 }* %t139, 3
  %t141 = load i8*, i8** %l17
  %t142 = insertvalue %NativeStruct %t140, i8* %t141, 4
  %t143 = insertvalue %StructParseResult undef, i8* null, 0
  %t144 = load double, double* %l16
  %t145 = insertvalue %StructParseResult %t143, double %t144, 1
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = insertvalue %StructParseResult %t145, { i8**, i64 }* %t146, 2
  ret %StructParseResult %t147
merge7:
  %t148 = load double, double* %l16
  %t149 = fptosi double %t148 to i64
  %t150 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t151 = extractvalue { i8**, i64 } %t150, 0
  %t152 = extractvalue { i8**, i64 } %t150, 1
  %t153 = icmp uge i64 %t149, %t152
  ; bounds check: %t153 (if true, out of bounds)
  %t154 = getelementptr i8*, i8** %t151, i64 %t149
  %t155 = load i8*, i8** %t154
  %t156 = call i8* @trim_text(i8* %t155)
  store i8* %t156, i8** %l18
  %t158 = load i8*, i8** %l18
  %t159 = call i64 @sailfin_runtime_string_length(i8* %t158)
  %t160 = icmp eq i64 %t159, 0
  br label %logical_or_entry_157

logical_or_entry_157:
  br i1 %t160, label %logical_or_merge_157, label %logical_or_right_157

logical_or_right_157:
  %t161 = load i8*, i8** %l18
  %t162 = call i1 @starts_with(i8* %t161, i8* null)
  br label %logical_or_right_end_157

logical_or_right_end_157:
  br label %logical_or_merge_157

logical_or_merge_157:
  %t163 = phi i1 [ true, %logical_or_entry_157 ], [ %t162, %logical_or_right_end_157 ]
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t165 = load i8*, i8** %l1
  %t166 = load i8*, i8** %l2
  %t167 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t168 = load i8*, i8** %l4
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t170 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t171 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t172 = load i8*, i8** %l8
  %t173 = load i8*, i8** %l9
  %t174 = load i8*, i8** %l10
  %t175 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t176 = load double, double* %l12
  %t177 = load double, double* %l13
  %t178 = load i1, i1* %l14
  %t179 = load i1, i1* %l15
  %t180 = load double, double* %l16
  %t181 = load i8*, i8** %l18
  br i1 %t163, label %then10, label %merge11
then10:
  %t182 = load double, double* %l16
  %t183 = sitofp i64 1 to double
  %t184 = fadd double %t182, %t183
  store double %t184, double* %l16
  br label %loop.latch4
merge11:
  %t185 = load i8*, i8** %l18
  %s186 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.186, i32 0, i32 0
  %t187 = icmp eq i8* %t185, %s186
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load i8*, i8** %l1
  %t190 = load i8*, i8** %l2
  %t191 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t192 = load i8*, i8** %l4
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t194 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t195 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t196 = load i8*, i8** %l8
  %t197 = load i8*, i8** %l9
  %t198 = load i8*, i8** %l10
  %t199 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t200 = load double, double* %l12
  %t201 = load double, double* %l13
  %t202 = load i1, i1* %l14
  %t203 = load i1, i1* %l15
  %t204 = load double, double* %l16
  %t205 = load i8*, i8** %l18
  br i1 %t187, label %then12, label %merge13
then12:
  %t206 = load i8*, i8** %l8
  %t207 = icmp ne i8* %t206, null
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t209 = load i8*, i8** %l1
  %t210 = load i8*, i8** %l2
  %t211 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t212 = load i8*, i8** %l4
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t214 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t215 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t216 = load i8*, i8** %l8
  %t217 = load i8*, i8** %l9
  %t218 = load i8*, i8** %l10
  %t219 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t220 = load double, double* %l12
  %t221 = load double, double* %l13
  %t222 = load i1, i1* %l14
  %t223 = load i1, i1* %l15
  %t224 = load double, double* %l16
  %t225 = load i8*, i8** %l18
  br i1 %t207, label %then14, label %merge15
then14:
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s227 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.227, i32 0, i32 0
  %t228 = load i8*, i8** %l4
  %t229 = add i8* %s227, %t228
  %t230 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t226, i8* %t229)
  store { i8**, i64 }* %t230, { i8**, i64 }** %l0
  %t231 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t232 = load i8*, i8** %l8
  %t233 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t231, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t233, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  br label %merge15
merge15:
  %t234 = phi { i8**, i64 }* [ %t230, %then14 ], [ %t208, %then12 ]
  %t235 = phi { %NativeFunction*, i64 }* [ %t233, %then14 ], [ %t215, %then12 ]
  %t236 = phi i8* [ null, %then14 ], [ %t216, %then12 ]
  %t237 = phi i8* [ null, %then14 ], [ %t217, %then12 ]
  %t238 = phi i8* [ null, %then14 ], [ %t218, %then12 ]
  store { i8**, i64 }* %t234, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t235, { %NativeFunction*, i64 }** %l7
  store i8* %t236, i8** %l8
  store i8* %t237, i8** %l9
  store i8* %t238, i8** %l10
  %t239 = load double, double* %l16
  %t240 = sitofp i64 1 to double
  %t241 = fadd double %t239, %t240
  store double %t241, double* %l16
  br label %afterloop5
merge13:
  %t242 = load i8*, i8** %l8
  %t243 = icmp ne i8* %t242, null
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t245 = load i8*, i8** %l1
  %t246 = load i8*, i8** %l2
  %t247 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t248 = load i8*, i8** %l4
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t250 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t251 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t252 = load i8*, i8** %l8
  %t253 = load i8*, i8** %l9
  %t254 = load i8*, i8** %l10
  %t255 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t256 = load double, double* %l12
  %t257 = load double, double* %l13
  %t258 = load i1, i1* %l14
  %t259 = load i1, i1* %l15
  %t260 = load double, double* %l16
  %t261 = load i8*, i8** %l18
  br i1 %t243, label %then16, label %merge17
then16:
  %t262 = load i8*, i8** %l18
  %s263 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.263, i32 0, i32 0
  %t264 = icmp eq i8* %t262, %s263
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t266 = load i8*, i8** %l1
  %t267 = load i8*, i8** %l2
  %t268 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t269 = load i8*, i8** %l4
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t271 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t272 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t273 = load i8*, i8** %l8
  %t274 = load i8*, i8** %l9
  %t275 = load i8*, i8** %l10
  %t276 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t277 = load double, double* %l12
  %t278 = load double, double* %l13
  %t279 = load i1, i1* %l14
  %t280 = load i1, i1* %l15
  %t281 = load double, double* %l16
  %t282 = load i8*, i8** %l18
  br i1 %t264, label %then18, label %merge19
then18:
  %t283 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t284 = load i8*, i8** %l8
  %t285 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t283, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t285, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t286 = load double, double* %l16
  %t287 = sitofp i64 1 to double
  %t288 = fadd double %t286, %t287
  store double %t288, double* %l16
  br label %loop.latch4
merge19:
  %t289 = load i8*, i8** %l18
  %s290 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.290, i32 0, i32 0
  %t291 = call i1 @starts_with(i8* %t289, i8* %s290)
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t293 = load i8*, i8** %l1
  %t294 = load i8*, i8** %l2
  %t295 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t296 = load i8*, i8** %l4
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t298 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t299 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t300 = load i8*, i8** %l8
  %t301 = load i8*, i8** %l9
  %t302 = load i8*, i8** %l10
  %t303 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t304 = load double, double* %l12
  %t305 = load double, double* %l13
  %t306 = load i1, i1* %l14
  %t307 = load i1, i1* %l15
  %t308 = load double, double* %l16
  %t309 = load i8*, i8** %l18
  br i1 %t291, label %then20, label %merge21
then20:
  %t310 = load i8*, i8** %l8
  %t311 = load i8*, i8** %l18
  %s312 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.312, i32 0, i32 0
  %t313 = call i8* @strip_prefix(i8* %t311, i8* %s312)
  %t314 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t313)
  store i8* null, i8** %l8
  %t315 = load double, double* %l16
  %t316 = sitofp i64 1 to double
  %t317 = fadd double %t315, %t316
  store double %t317, double* %l16
  br label %loop.latch4
merge21:
  %t318 = load i8*, i8** %l18
  %s319 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.319, i32 0, i32 0
  %t320 = call i1 @starts_with(i8* %t318, i8* %s319)
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t322 = load i8*, i8** %l1
  %t323 = load i8*, i8** %l2
  %t324 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t325 = load i8*, i8** %l4
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t327 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t328 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t329 = load i8*, i8** %l8
  %t330 = load i8*, i8** %l9
  %t331 = load i8*, i8** %l10
  %t332 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t333 = load double, double* %l12
  %t334 = load double, double* %l13
  %t335 = load i1, i1* %l14
  %t336 = load i1, i1* %l15
  %t337 = load double, double* %l16
  %t338 = load i8*, i8** %l18
  br i1 %t320, label %then22, label %merge23
then22:
  %t339 = load i8*, i8** %l18
  %s340 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.340, i32 0, i32 0
  %t341 = call i8* @strip_prefix(i8* %t339, i8* %s340)
  %t342 = load i8*, i8** %l9
  %t343 = call double @parse_parameter_entry(i8* %t341, i8* %t342)
  store double %t343, double* %l19
  %t344 = load double, double* %l19
  store i8* null, i8** %l9
  %t345 = load double, double* %l16
  %t346 = sitofp i64 1 to double
  %t347 = fadd double %t345, %t346
  store double %t347, double* %l16
  br label %loop.latch4
merge23:
  %t348 = load i8*, i8** %l18
  %s349 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.349, i32 0, i32 0
  %t350 = call i1 @starts_with(i8* %t348, i8* %s349)
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t352 = load i8*, i8** %l1
  %t353 = load i8*, i8** %l2
  %t354 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t355 = load i8*, i8** %l4
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t357 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t358 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t359 = load i8*, i8** %l8
  %t360 = load i8*, i8** %l9
  %t361 = load i8*, i8** %l10
  %t362 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t363 = load double, double* %l12
  %t364 = load double, double* %l13
  %t365 = load i1, i1* %l14
  %t366 = load i1, i1* %l15
  %t367 = load double, double* %l16
  %t368 = load i8*, i8** %l18
  br i1 %t350, label %then24, label %merge25
then24:
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s370 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.370, i32 0, i32 0
  %t371 = load i8*, i8** %l4
  %t372 = add i8* %s370, %t371
  %t373 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t369, i8* %t372)
  store { i8**, i64 }* %t373, { i8**, i64 }** %l0
  %t374 = load double, double* %l16
  %t375 = sitofp i64 1 to double
  %t376 = fadd double %t374, %t375
  store double %t376, double* %l16
  br label %loop.latch4
merge25:
  %t377 = load i8*, i8** %l18
  %s378 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.378, i32 0, i32 0
  %t379 = call i1 @starts_with(i8* %t377, i8* %s378)
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load i8*, i8** %l1
  %t382 = load i8*, i8** %l2
  %t383 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t384 = load i8*, i8** %l4
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t386 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t387 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t388 = load i8*, i8** %l8
  %t389 = load i8*, i8** %l9
  %t390 = load i8*, i8** %l10
  %t391 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t392 = load double, double* %l12
  %t393 = load double, double* %l13
  %t394 = load i1, i1* %l14
  %t395 = load i1, i1* %l15
  %t396 = load double, double* %l16
  %t397 = load i8*, i8** %l18
  br i1 %t379, label %then26, label %merge27
then26:
  %t398 = load i8*, i8** %l18
  %s399 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.399, i32 0, i32 0
  %t400 = call i8* @strip_prefix(i8* %t398, i8* %s399)
  %t401 = call double @parse_source_span(i8* %t400)
  store double %t401, double* %l20
  %t402 = load double, double* %l20
  %t403 = load double, double* %l16
  %t404 = sitofp i64 1 to double
  %t405 = fadd double %t403, %t404
  store double %t405, double* %l16
  br label %loop.latch4
merge27:
  %t406 = load i8*, i8** %l18
  %t407 = load i8*, i8** %l18
  %t408 = load i8*, i8** %l9
  %t409 = load i8*, i8** %l10
  %t410 = call %InstructionParseResult @parse_instruction(i8* %t407, i8* %t408, i8* %t409)
  store %InstructionParseResult %t410, %InstructionParseResult* %l21
  %t411 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t412 = extractvalue %InstructionParseResult %t411, 1
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t414 = load i8*, i8** %l1
  %t415 = load i8*, i8** %l2
  %t416 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t417 = load i8*, i8** %l4
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t419 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t420 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t421 = load i8*, i8** %l8
  %t422 = load i8*, i8** %l9
  %t423 = load i8*, i8** %l10
  %t424 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t425 = load double, double* %l12
  %t426 = load double, double* %l13
  %t427 = load i1, i1* %l14
  %t428 = load i1, i1* %l15
  %t429 = load double, double* %l16
  %t430 = load i8*, i8** %l18
  %t431 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t412, label %then28, label %else29
then28:
  store i8* null, i8** %l9
  br label %merge30
else29:
  %t432 = load i8*, i8** %l9
  %t433 = icmp ne i8* %t432, null
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t435 = load i8*, i8** %l1
  %t436 = load i8*, i8** %l2
  %t437 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t438 = load i8*, i8** %l4
  %t439 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t440 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t441 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t442 = load i8*, i8** %l8
  %t443 = load i8*, i8** %l9
  %t444 = load i8*, i8** %l10
  %t445 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t446 = load double, double* %l12
  %t447 = load double, double* %l13
  %t448 = load i1, i1* %l14
  %t449 = load i1, i1* %l15
  %t450 = load double, double* %l16
  %t451 = load i8*, i8** %l18
  %t452 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t433, label %then31, label %merge32
then31:
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s454 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.454, i32 0, i32 0
  %t455 = load i8*, i8** %l18
  %t456 = add i8* %s454, %t455
  %t457 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t453, i8* %t456)
  store { i8**, i64 }* %t457, { i8**, i64 }** %l0
  store i8* null, i8** %l9
  br label %merge32
merge32:
  %t458 = phi { i8**, i64 }* [ %t457, %then31 ], [ %t434, %else29 ]
  %t459 = phi i8* [ null, %then31 ], [ %t443, %else29 ]
  store { i8**, i64 }* %t458, { i8**, i64 }** %l0
  store i8* %t459, i8** %l9
  br label %merge30
merge30:
  %t460 = phi i8* [ null, %then28 ], [ null, %else29 ]
  %t461 = phi { i8**, i64 }* [ %t413, %then28 ], [ %t457, %else29 ]
  store i8* %t460, i8** %l9
  store { i8**, i64 }* %t461, { i8**, i64 }** %l0
  %t462 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t463 = extractvalue %InstructionParseResult %t462, 2
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t465 = load i8*, i8** %l1
  %t466 = load i8*, i8** %l2
  %t467 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t468 = load i8*, i8** %l4
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t470 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t471 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t472 = load i8*, i8** %l8
  %t473 = load i8*, i8** %l9
  %t474 = load i8*, i8** %l10
  %t475 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t476 = load double, double* %l12
  %t477 = load double, double* %l13
  %t478 = load i1, i1* %l14
  %t479 = load i1, i1* %l15
  %t480 = load double, double* %l16
  %t481 = load i8*, i8** %l18
  %t482 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t463, label %then33, label %else34
then33:
  store i8* null, i8** %l10
  br label %merge35
else34:
  %t483 = load i8*, i8** %l10
  %t484 = icmp ne i8* %t483, null
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t486 = load i8*, i8** %l1
  %t487 = load i8*, i8** %l2
  %t488 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t489 = load i8*, i8** %l4
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t491 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t492 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t493 = load i8*, i8** %l8
  %t494 = load i8*, i8** %l9
  %t495 = load i8*, i8** %l10
  %t496 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t497 = load double, double* %l12
  %t498 = load double, double* %l13
  %t499 = load i1, i1* %l14
  %t500 = load i1, i1* %l15
  %t501 = load double, double* %l16
  %t502 = load i8*, i8** %l18
  %t503 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t484, label %then36, label %merge37
then36:
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s505 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.505, i32 0, i32 0
  %t506 = load i8*, i8** %l18
  %t507 = add i8* %s505, %t506
  %t508 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t504, i8* %t507)
  store { i8**, i64 }* %t508, { i8**, i64 }** %l0
  store i8* null, i8** %l10
  br label %merge37
merge37:
  %t509 = phi { i8**, i64 }* [ %t508, %then36 ], [ %t485, %else34 ]
  %t510 = phi i8* [ null, %then36 ], [ %t495, %else34 ]
  store { i8**, i64 }* %t509, { i8**, i64 }** %l0
  store i8* %t510, i8** %l10
  br label %merge35
merge35:
  %t511 = phi i8* [ null, %then33 ], [ null, %else34 ]
  %t512 = phi { i8**, i64 }* [ %t464, %then33 ], [ %t508, %else34 ]
  store i8* %t511, i8** %l10
  store { i8**, i64 }* %t512, { i8**, i64 }** %l0
  %t513 = sitofp i64 0 to double
  store double %t513, double* %l22
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t515 = load i8*, i8** %l1
  %t516 = load i8*, i8** %l2
  %t517 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t518 = load i8*, i8** %l4
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t520 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t521 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t522 = load i8*, i8** %l8
  %t523 = load i8*, i8** %l9
  %t524 = load i8*, i8** %l10
  %t525 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t526 = load double, double* %l12
  %t527 = load double, double* %l13
  %t528 = load i1, i1* %l14
  %t529 = load i1, i1* %l15
  %t530 = load double, double* %l16
  %t531 = load i8*, i8** %l18
  %t532 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t533 = load double, double* %l22
  br label %loop.header38
loop.header38:
  %t578 = phi i8* [ %t522, %then16 ], [ %t576, %loop.latch40 ]
  %t579 = phi double [ %t533, %then16 ], [ %t577, %loop.latch40 ]
  store i8* %t578, i8** %l8
  store double %t579, double* %l22
  br label %loop.body39
loop.body39:
  %t534 = load double, double* %l22
  %t535 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t536 = extractvalue %InstructionParseResult %t535, 0
  %t537 = load { i8**, i64 }, { i8**, i64 }* %t536
  %t538 = extractvalue { i8**, i64 } %t537, 1
  %t539 = sitofp i64 %t538 to double
  %t540 = fcmp oge double %t534, %t539
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t542 = load i8*, i8** %l1
  %t543 = load i8*, i8** %l2
  %t544 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t545 = load i8*, i8** %l4
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t547 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t548 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t549 = load i8*, i8** %l8
  %t550 = load i8*, i8** %l9
  %t551 = load i8*, i8** %l10
  %t552 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t553 = load double, double* %l12
  %t554 = load double, double* %l13
  %t555 = load i1, i1* %l14
  %t556 = load i1, i1* %l15
  %t557 = load double, double* %l16
  %t558 = load i8*, i8** %l18
  %t559 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t560 = load double, double* %l22
  br i1 %t540, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t561 = load i8*, i8** %l8
  %t562 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t563 = extractvalue %InstructionParseResult %t562, 0
  %t564 = load double, double* %l22
  %t565 = fptosi double %t564 to i64
  %t566 = load { i8**, i64 }, { i8**, i64 }* %t563
  %t567 = extractvalue { i8**, i64 } %t566, 0
  %t568 = extractvalue { i8**, i64 } %t566, 1
  %t569 = icmp uge i64 %t565, %t568
  ; bounds check: %t569 (if true, out of bounds)
  %t570 = getelementptr i8*, i8** %t567, i64 %t565
  %t571 = load i8*, i8** %t570
  %t572 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t573 = load double, double* %l22
  %t574 = sitofp i64 1 to double
  %t575 = fadd double %t573, %t574
  store double %t575, double* %l22
  br label %loop.latch40
loop.latch40:
  %t576 = load i8*, i8** %l8
  %t577 = load double, double* %l22
  br label %loop.header38
afterloop41:
  %t580 = load double, double* %l16
  %t581 = sitofp i64 1 to double
  %t582 = fadd double %t580, %t581
  store double %t582, double* %l16
  br label %loop.latch4
merge17:
  %t583 = load i8*, i8** %l18
  %s584 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.584, i32 0, i32 0
  %t585 = call i1 @starts_with(i8* %t583, i8* %s584)
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t587 = load i8*, i8** %l1
  %t588 = load i8*, i8** %l2
  %t589 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t590 = load i8*, i8** %l4
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t592 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t593 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t594 = load i8*, i8** %l8
  %t595 = load i8*, i8** %l9
  %t596 = load i8*, i8** %l10
  %t597 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t598 = load double, double* %l12
  %t599 = load double, double* %l13
  %t600 = load i1, i1* %l14
  %t601 = load i1, i1* %l15
  %t602 = load double, double* %l16
  %t603 = load i8*, i8** %l18
  br i1 %t585, label %then44, label %merge45
then44:
  %t604 = load i8*, i8** %l18
  %s605 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.605, i32 0, i32 0
  %t606 = call i8* @strip_prefix(i8* %t604, i8* %s605)
  store i8* %t606, i8** %l23
  %t607 = load i8*, i8** %l23
  %s608 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.608, i32 0, i32 0
  %t609 = call i1 @starts_with(i8* %t607, i8* %s608)
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t611 = load i8*, i8** %l1
  %t612 = load i8*, i8** %l2
  %t613 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t614 = load i8*, i8** %l4
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t616 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t617 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t618 = load i8*, i8** %l8
  %t619 = load i8*, i8** %l9
  %t620 = load i8*, i8** %l10
  %t621 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t622 = load double, double* %l12
  %t623 = load double, double* %l13
  %t624 = load i1, i1* %l14
  %t625 = load i1, i1* %l15
  %t626 = load double, double* %l16
  %t627 = load i8*, i8** %l18
  %t628 = load i8*, i8** %l23
  br i1 %t609, label %then46, label %merge47
then46:
  %t629 = load i8*, i8** %l23
  %s630 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.630, i32 0, i32 0
  %t631 = call i8* @strip_prefix(i8* %t629, i8* %s630)
  %t632 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t631)
  store %StructLayoutHeaderParse %t632, %StructLayoutHeaderParse* %l24
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t634 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t635 = extractvalue %StructLayoutHeaderParse %t634, 4
  %t636 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t633, { i8**, i64 }* %t635)
  store { i8**, i64 }* %t636, { i8**, i64 }** %l0
  %t637 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t638 = extractvalue %StructLayoutHeaderParse %t637, 0
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t640 = load i8*, i8** %l1
  %t641 = load i8*, i8** %l2
  %t642 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t643 = load i8*, i8** %l4
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t645 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t646 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t647 = load i8*, i8** %l8
  %t648 = load i8*, i8** %l9
  %t649 = load i8*, i8** %l10
  %t650 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t651 = load double, double* %l12
  %t652 = load double, double* %l13
  %t653 = load i1, i1* %l14
  %t654 = load i1, i1* %l15
  %t655 = load double, double* %l16
  %t656 = load i8*, i8** %l18
  %t657 = load i8*, i8** %l23
  %t658 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t638, label %then48, label %merge49
then48:
  %t659 = load i1, i1* %l14
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t661 = load i8*, i8** %l1
  %t662 = load i8*, i8** %l2
  %t663 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t664 = load i8*, i8** %l4
  %t665 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t666 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t667 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t668 = load i8*, i8** %l8
  %t669 = load i8*, i8** %l9
  %t670 = load i8*, i8** %l10
  %t671 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t672 = load double, double* %l12
  %t673 = load double, double* %l13
  %t674 = load i1, i1* %l14
  %t675 = load i1, i1* %l15
  %t676 = load double, double* %l16
  %t677 = load i8*, i8** %l18
  %t678 = load i8*, i8** %l23
  %t679 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t659, label %then50, label %else51
then50:
  %t680 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s681 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.681, i32 0, i32 0
  %t682 = load i8*, i8** %l4
  %t683 = add i8* %s681, %t682
  %t684 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t680, i8* %t683)
  store { i8**, i64 }* %t684, { i8**, i64 }** %l0
  br label %merge52
else51:
  %t685 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t686 = extractvalue %StructLayoutHeaderParse %t685, 2
  store double %t686, double* %l12
  %t687 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t688 = extractvalue %StructLayoutHeaderParse %t687, 3
  store double %t688, double* %l13
  store i1 1, i1* %l14
  br label %merge52
merge52:
  %t689 = phi { i8**, i64 }* [ %t684, %then50 ], [ %t660, %else51 ]
  %t690 = phi double [ %t672, %then50 ], [ %t686, %else51 ]
  %t691 = phi double [ %t673, %then50 ], [ %t688, %else51 ]
  %t692 = phi i1 [ %t674, %then50 ], [ 1, %else51 ]
  store { i8**, i64 }* %t689, { i8**, i64 }** %l0
  store double %t690, double* %l12
  store double %t691, double* %l13
  store i1 %t692, i1* %l14
  br label %merge49
merge49:
  %t693 = phi { i8**, i64 }* [ %t684, %then48 ], [ %t639, %then46 ]
  %t694 = phi double [ %t686, %then48 ], [ %t651, %then46 ]
  %t695 = phi double [ %t688, %then48 ], [ %t652, %then46 ]
  %t696 = phi i1 [ 1, %then48 ], [ %t653, %then46 ]
  store { i8**, i64 }* %t693, { i8**, i64 }** %l0
  store double %t694, double* %l12
  store double %t695, double* %l13
  store i1 %t696, i1* %l14
  %t697 = load double, double* %l16
  %t698 = sitofp i64 1 to double
  %t699 = fadd double %t697, %t698
  store double %t699, double* %l16
  br label %loop.latch4
merge47:
  %t700 = load i8*, i8** %l23
  %s701 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.701, i32 0, i32 0
  %t702 = call i1 @starts_with(i8* %t700, i8* %s701)
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t704 = load i8*, i8** %l1
  %t705 = load i8*, i8** %l2
  %t706 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t707 = load i8*, i8** %l4
  %t708 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t709 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t710 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t711 = load i8*, i8** %l8
  %t712 = load i8*, i8** %l9
  %t713 = load i8*, i8** %l10
  %t714 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t715 = load double, double* %l12
  %t716 = load double, double* %l13
  %t717 = load i1, i1* %l14
  %t718 = load i1, i1* %l15
  %t719 = load double, double* %l16
  %t720 = load i8*, i8** %l18
  %t721 = load i8*, i8** %l23
  br i1 %t702, label %then53, label %merge54
then53:
  %t722 = load i8*, i8** %l23
  %s723 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.723, i32 0, i32 0
  %t724 = call i8* @strip_prefix(i8* %t722, i8* %s723)
  %t725 = load i8*, i8** %l4
  %t726 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t724, i8* %t725)
  store %StructLayoutFieldParse %t726, %StructLayoutFieldParse* %l25
  %t727 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t728 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t729 = extractvalue %StructLayoutFieldParse %t728, 2
  %t730 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t727, { i8**, i64 }* %t729)
  store { i8**, i64 }* %t730, { i8**, i64 }** %l0
  %t731 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t732 = extractvalue %StructLayoutFieldParse %t731, 0
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t734 = load i8*, i8** %l1
  %t735 = load i8*, i8** %l2
  %t736 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t737 = load i8*, i8** %l4
  %t738 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t739 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t740 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t741 = load i8*, i8** %l8
  %t742 = load i8*, i8** %l9
  %t743 = load i8*, i8** %l10
  %t744 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t745 = load double, double* %l12
  %t746 = load double, double* %l13
  %t747 = load i1, i1* %l14
  %t748 = load i1, i1* %l15
  %t749 = load double, double* %l16
  %t750 = load i8*, i8** %l18
  %t751 = load i8*, i8** %l23
  %t752 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t732, label %then55, label %merge56
then55:
  %t753 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t754 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t755 = extractvalue %StructLayoutFieldParse %t754, 1
  %t756 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t753, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t756, { %NativeStructLayoutField*, i64 }** %l11
  %t757 = load i1, i1* %l14
  %t758 = xor i1 %t757, 1
  %t759 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t760 = load i8*, i8** %l1
  %t761 = load i8*, i8** %l2
  %t762 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t763 = load i8*, i8** %l4
  %t764 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t765 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t766 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t767 = load i8*, i8** %l8
  %t768 = load i8*, i8** %l9
  %t769 = load i8*, i8** %l10
  %t770 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t771 = load double, double* %l12
  %t772 = load double, double* %l13
  %t773 = load i1, i1* %l14
  %t774 = load i1, i1* %l15
  %t775 = load double, double* %l16
  %t776 = load i8*, i8** %l18
  %t777 = load i8*, i8** %l23
  %t778 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t758, label %then57, label %merge58
then57:
  %t779 = load i1, i1* %l15
  %t780 = xor i1 %t779, 1
  %t781 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t782 = load i8*, i8** %l1
  %t783 = load i8*, i8** %l2
  %t784 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t785 = load i8*, i8** %l4
  %t786 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t787 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t788 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t789 = load i8*, i8** %l8
  %t790 = load i8*, i8** %l9
  %t791 = load i8*, i8** %l10
  %t792 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t793 = load double, double* %l12
  %t794 = load double, double* %l13
  %t795 = load i1, i1* %l14
  %t796 = load i1, i1* %l15
  %t797 = load double, double* %l16
  %t798 = load i8*, i8** %l18
  %t799 = load i8*, i8** %l23
  %t800 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t780, label %then59, label %merge60
then59:
  %t801 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s802 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.802, i32 0, i32 0
  %t803 = load i8*, i8** %l4
  %t804 = add i8* %s802, %t803
  %s805 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.805, i32 0, i32 0
  %t806 = add i8* %t804, %s805
  %t807 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t801, i8* %t806)
  store { i8**, i64 }* %t807, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge60
merge60:
  %t808 = phi { i8**, i64 }* [ %t807, %then59 ], [ %t781, %then57 ]
  %t809 = phi i1 [ 1, %then59 ], [ %t796, %then57 ]
  store { i8**, i64 }* %t808, { i8**, i64 }** %l0
  store i1 %t809, i1* %l15
  br label %merge58
merge58:
  %t810 = phi { i8**, i64 }* [ %t807, %then57 ], [ %t759, %then55 ]
  %t811 = phi i1 [ 1, %then57 ], [ %t774, %then55 ]
  store { i8**, i64 }* %t810, { i8**, i64 }** %l0
  store i1 %t811, i1* %l15
  br label %merge56
merge56:
  %t812 = phi { %NativeStructLayoutField*, i64 }* [ %t756, %then55 ], [ %t744, %then53 ]
  %t813 = phi { i8**, i64 }* [ %t807, %then55 ], [ %t733, %then53 ]
  %t814 = phi i1 [ 1, %then55 ], [ %t748, %then53 ]
  store { %NativeStructLayoutField*, i64 }* %t812, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t813, { i8**, i64 }** %l0
  store i1 %t814, i1* %l15
  %t815 = load double, double* %l16
  %t816 = sitofp i64 1 to double
  %t817 = fadd double %t815, %t816
  store double %t817, double* %l16
  br label %loop.latch4
merge54:
  %t818 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s819 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.819, i32 0, i32 0
  %t820 = load i8*, i8** %l18
  %t821 = add i8* %s819, %t820
  %t822 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t818, i8* %t821)
  store { i8**, i64 }* %t822, { i8**, i64 }** %l0
  %t823 = load double, double* %l16
  %t824 = sitofp i64 1 to double
  %t825 = fadd double %t823, %t824
  store double %t825, double* %l16
  br label %loop.latch4
merge45:
  %t826 = load i8*, i8** %l18
  %s827 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.827, i32 0, i32 0
  %t828 = icmp eq i8* %t826, %s827
  %t829 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t830 = load i8*, i8** %l1
  %t831 = load i8*, i8** %l2
  %t832 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t833 = load i8*, i8** %l4
  %t834 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t835 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t836 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t837 = load i8*, i8** %l8
  %t838 = load i8*, i8** %l9
  %t839 = load i8*, i8** %l10
  %t840 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t841 = load double, double* %l12
  %t842 = load double, double* %l13
  %t843 = load i1, i1* %l14
  %t844 = load i1, i1* %l15
  %t845 = load double, double* %l16
  %t846 = load i8*, i8** %l18
  br i1 %t828, label %then61, label %merge62
then61:
  %t847 = load double, double* %l16
  %t848 = sitofp i64 1 to double
  %t849 = fadd double %t847, %t848
  store double %t849, double* %l16
  br label %loop.latch4
merge62:
  %t850 = load i8*, i8** %l18
  %s851 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.851, i32 0, i32 0
  %t852 = call i1 @starts_with(i8* %t850, i8* %s851)
  %t853 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t854 = load i8*, i8** %l1
  %t855 = load i8*, i8** %l2
  %t856 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t857 = load i8*, i8** %l4
  %t858 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t859 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t860 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t861 = load i8*, i8** %l8
  %t862 = load i8*, i8** %l9
  %t863 = load i8*, i8** %l10
  %t864 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t865 = load double, double* %l12
  %t866 = load double, double* %l13
  %t867 = load i1, i1* %l14
  %t868 = load i1, i1* %l15
  %t869 = load double, double* %l16
  %t870 = load i8*, i8** %l18
  br i1 %t852, label %then63, label %merge64
then63:
  %t871 = load i8*, i8** %l18
  %s872 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.872, i32 0, i32 0
  %t873 = call i8* @strip_prefix(i8* %t871, i8* %s872)
  %t874 = call double @parse_struct_field_line(i8* %t873)
  store double %t874, double* %l26
  %t875 = load double, double* %l26
  %t876 = load double, double* %l16
  %t877 = sitofp i64 1 to double
  %t878 = fadd double %t876, %t877
  store double %t878, double* %l16
  br label %loop.latch4
merge64:
  %t879 = load i8*, i8** %l18
  %s880 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.880, i32 0, i32 0
  %t881 = call i1 @starts_with(i8* %t879, i8* %s880)
  %t882 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t883 = load i8*, i8** %l1
  %t884 = load i8*, i8** %l2
  %t885 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t886 = load i8*, i8** %l4
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t888 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t889 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t890 = load i8*, i8** %l8
  %t891 = load i8*, i8** %l9
  %t892 = load i8*, i8** %l10
  %t893 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t894 = load double, double* %l12
  %t895 = load double, double* %l13
  %t896 = load i1, i1* %l14
  %t897 = load i1, i1* %l15
  %t898 = load double, double* %l16
  %t899 = load i8*, i8** %l18
  br i1 %t881, label %then65, label %merge66
then65:
  %t900 = load i8*, i8** %l8
  %t901 = icmp ne i8* %t900, null
  %t902 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t903 = load i8*, i8** %l1
  %t904 = load i8*, i8** %l2
  %t905 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t906 = load i8*, i8** %l4
  %t907 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t908 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t909 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t910 = load i8*, i8** %l8
  %t911 = load i8*, i8** %l9
  %t912 = load i8*, i8** %l10
  %t913 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t914 = load double, double* %l12
  %t915 = load double, double* %l13
  %t916 = load i1, i1* %l14
  %t917 = load i1, i1* %l15
  %t918 = load double, double* %l16
  %t919 = load i8*, i8** %l18
  br i1 %t901, label %then67, label %merge68
then67:
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s921 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.921, i32 0, i32 0
  %t922 = load i8*, i8** %l4
  %t923 = add i8* %s921, %t922
  %t924 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t920, i8* %t923)
  store { i8**, i64 }* %t924, { i8**, i64 }** %l0
  br label %merge68
merge68:
  %t925 = phi { i8**, i64 }* [ %t924, %then67 ], [ %t902, %then65 ]
  store { i8**, i64 }* %t925, { i8**, i64 }** %l0
  %t926 = load i8*, i8** %l18
  %s927 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.927, i32 0, i32 0
  %t928 = call i8* @strip_prefix(i8* %t926, i8* %s927)
  %t929 = call i8* @parse_function_name(i8* %t928)
  store i8* %t929, i8** %l27
  %t930 = load i8*, i8** %l27
  %t931 = insertvalue %NativeFunction undef, i8* %t930, 0
  %t932 = alloca [0 x i8*]
  %t933 = getelementptr [0 x i8*], [0 x i8*]* %t932, i32 0, i32 0
  %t934 = alloca { i8**, i64 }
  %t935 = getelementptr { i8**, i64 }, { i8**, i64 }* %t934, i32 0, i32 0
  store i8** %t933, i8*** %t935
  %t936 = getelementptr { i8**, i64 }, { i8**, i64 }* %t934, i32 0, i32 1
  store i64 0, i64* %t936
  %t937 = insertvalue %NativeFunction %t931, { i8**, i64 }* %t934, 1
  %s938 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.938, i32 0, i32 0
  %t939 = insertvalue %NativeFunction %t937, i8* %s938, 2
  %t940 = alloca [0 x i8*]
  %t941 = getelementptr [0 x i8*], [0 x i8*]* %t940, i32 0, i32 0
  %t942 = alloca { i8**, i64 }
  %t943 = getelementptr { i8**, i64 }, { i8**, i64 }* %t942, i32 0, i32 0
  store i8** %t941, i8*** %t943
  %t944 = getelementptr { i8**, i64 }, { i8**, i64 }* %t942, i32 0, i32 1
  store i64 0, i64* %t944
  %t945 = insertvalue %NativeFunction %t939, { i8**, i64 }* %t942, 3
  %t946 = alloca [0 x i8*]
  %t947 = getelementptr [0 x i8*], [0 x i8*]* %t946, i32 0, i32 0
  %t948 = alloca { i8**, i64 }
  %t949 = getelementptr { i8**, i64 }, { i8**, i64 }* %t948, i32 0, i32 0
  store i8** %t947, i8*** %t949
  %t950 = getelementptr { i8**, i64 }, { i8**, i64 }* %t948, i32 0, i32 1
  store i64 0, i64* %t950
  %t951 = insertvalue %NativeFunction %t945, { i8**, i64 }* %t948, 4
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t952 = load double, double* %l16
  %t953 = sitofp i64 1 to double
  %t954 = fadd double %t952, %t953
  store double %t954, double* %l16
  br label %loop.latch4
merge66:
  %t955 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s956 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.956, i32 0, i32 0
  %t957 = load i8*, i8** %l18
  %t958 = add i8* %s956, %t957
  %t959 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t955, i8* %t958)
  store { i8**, i64 }* %t959, { i8**, i64 }** %l0
  %t960 = load double, double* %l16
  %t961 = sitofp i64 1 to double
  %t962 = fadd double %t960, %t961
  store double %t962, double* %l16
  br label %loop.latch4
loop.latch4:
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t964 = load double, double* %l16
  %t965 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t966 = load i8*, i8** %l8
  %t967 = load i8*, i8** %l9
  %t968 = load i8*, i8** %l10
  %t969 = load double, double* %l12
  %t970 = load double, double* %l13
  %t971 = load i1, i1* %l14
  %t972 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t973 = load i1, i1* %l15
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l28
  %t985 = load i1, i1* %l14
  %t986 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t987 = load i8*, i8** %l1
  %t988 = load i8*, i8** %l2
  %t989 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t990 = load i8*, i8** %l4
  %t991 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t992 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t993 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t994 = load i8*, i8** %l8
  %t995 = load i8*, i8** %l9
  %t996 = load i8*, i8** %l10
  %t997 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t998 = load double, double* %l12
  %t999 = load double, double* %l13
  %t1000 = load i1, i1* %l14
  %t1001 = load i1, i1* %l15
  %t1002 = load double, double* %l16
  %t1003 = load i8*, i8** %l28
  br i1 %t985, label %then69, label %merge70
then69:
  %t1004 = load double, double* %l12
  %t1005 = insertvalue %NativeStructLayout undef, double %t1004, 0
  %t1006 = load double, double* %l13
  %t1007 = insertvalue %NativeStructLayout %t1005, double %t1006, 1
  %t1008 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1009 = bitcast { %NativeStructLayoutField*, i64 }* %t1008 to { i8**, i64 }*
  %t1010 = insertvalue %NativeStructLayout %t1007, { i8**, i64 }* %t1009, 2
  store i8* null, i8** %l28
  br label %merge70
merge70:
  %t1011 = phi i8* [ null, %then69 ], [ %t1003, %entry ]
  store i8* %t1011, i8** %l28
  %t1012 = load i8*, i8** %l4
  %t1013 = insertvalue %NativeStruct undef, i8* %t1012, 0
  %t1014 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1015 = bitcast { %NativeStructField*, i64 }* %t1014 to { i8**, i64 }*
  %t1016 = insertvalue %NativeStruct %t1013, { i8**, i64 }* %t1015, 1
  %t1017 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1018 = bitcast { %NativeFunction*, i64 }* %t1017 to { i8**, i64 }*
  %t1019 = insertvalue %NativeStruct %t1016, { i8**, i64 }* %t1018, 2
  %t1020 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1021 = insertvalue %NativeStruct %t1019, { i8**, i64 }* %t1020, 3
  %t1022 = load i8*, i8** %l28
  %t1023 = insertvalue %NativeStruct %t1021, i8* %t1022, 4
  %t1024 = insertvalue %StructParseResult undef, i8* null, 0
  %t1025 = load double, double* %l16
  %t1026 = insertvalue %StructParseResult %t1024, double %t1025, 1
  %t1027 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1028 = insertvalue %StructParseResult %t1026, { i8**, i64 }* %t1027, 2
  ret %StructParseResult %t1028
}

define %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %InterfaceHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { %NativeInterfaceSignature*, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %InterfaceSignatureParse
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = fptosi double %start_index to i64
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %t13, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = call %InterfaceHeaderParse @parse_interface_header(i8* %t17)
  store %InterfaceHeaderParse %t18, %InterfaceHeaderParse* %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t21 = extractvalue %InterfaceHeaderParse %t20, 2
  %t22 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t19, { i8**, i64 }* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %t23 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t24 = extractvalue %InterfaceHeaderParse %t23, 0
  store i8* %t24, i8** %l4
  %t25 = load i8*, i8** %l4
  %t26 = call i64 @sailfin_runtime_string_length(i8* %t25)
  %t27 = icmp eq i64 %t26, 0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then0, label %merge1
then0:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s34 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.34, i32 0, i32 0
  %t35 = load i8*, i8** %l1
  %t36 = add i8* %s34, %t35
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  ret %InterfaceParseResult zeroinitializer
merge1:
  %t38 = alloca [0 x %NativeInterfaceSignature]
  %t39 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* %t38, i32 0, i32 0
  %t40 = alloca { %NativeInterfaceSignature*, i64 }
  %t41 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t40, i32 0, i32 0
  store %NativeInterfaceSignature* %t39, %NativeInterfaceSignature** %t41
  %t42 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t40, i32 0, i32 1
  store i64 0, i64* %t42
  store { %NativeInterfaceSignature*, i64 }* %t40, { %NativeInterfaceSignature*, i64 }** %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %start_index, %t43
  store double %t44, double* %l6
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l2
  %t48 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t49 = load i8*, i8** %l4
  %t50 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t51 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t195 = phi { i8**, i64 }* [ %t45, %entry ], [ %t192, %loop.latch4 ]
  %t196 = phi double [ %t51, %entry ], [ %t193, %loop.latch4 ]
  %t197 = phi { %NativeInterfaceSignature*, i64 }* [ %t50, %entry ], [ %t194, %loop.latch4 ]
  store { i8**, i64 }* %t195, { i8**, i64 }** %l0
  store double %t196, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t197, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t52 = load double, double* %l6
  %t53 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t54 = extractvalue { i8**, i64 } %t53, 1
  %t55 = sitofp i64 %t54 to double
  %t56 = fcmp oge double %t52, %t55
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load i8*, i8** %l1
  %t59 = load i8*, i8** %l2
  %t60 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t61 = load i8*, i8** %l4
  %t62 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t63 = load double, double* %l6
  br i1 %t56, label %then6, label %merge7
then6:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s65 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.65, i32 0, i32 0
  %t66 = load i8*, i8** %l4
  %t67 = add i8* %s65, %t66
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l4
  %t70 = insertvalue %NativeInterface undef, i8* %t69, 0
  %t71 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t72 = extractvalue %InterfaceHeaderParse %t71, 1
  %t73 = insertvalue %NativeInterface %t70, { i8**, i64 }* %t72, 1
  %t74 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t75 = bitcast { %NativeInterfaceSignature*, i64 }* %t74 to { i8**, i64 }*
  %t76 = insertvalue %NativeInterface %t73, { i8**, i64 }* %t75, 2
  %t77 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t78 = load double, double* %l6
  %t79 = insertvalue %InterfaceParseResult %t77, double %t78, 1
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = insertvalue %InterfaceParseResult %t79, { i8**, i64 }* %t80, 2
  ret %InterfaceParseResult %t81
merge7:
  %t82 = load double, double* %l6
  %t83 = fptosi double %t82 to i64
  %t84 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t85 = extractvalue { i8**, i64 } %t84, 0
  %t86 = extractvalue { i8**, i64 } %t84, 1
  %t87 = icmp uge i64 %t83, %t86
  ; bounds check: %t87 (if true, out of bounds)
  %t88 = getelementptr i8*, i8** %t85, i64 %t83
  %t89 = load i8*, i8** %t88
  %t90 = call i8* @trim_text(i8* %t89)
  store i8* %t90, i8** %l7
  %t92 = load i8*, i8** %l7
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = icmp eq i64 %t93, 0
  br label %logical_or_entry_91

logical_or_entry_91:
  br i1 %t94, label %logical_or_merge_91, label %logical_or_right_91

logical_or_right_91:
  %t95 = load i8*, i8** %l7
  %t96 = call i1 @starts_with(i8* %t95, i8* null)
  br label %logical_or_right_end_91

logical_or_right_end_91:
  br label %logical_or_merge_91

logical_or_merge_91:
  %t97 = phi i1 [ true, %logical_or_entry_91 ], [ %t96, %logical_or_right_end_91 ]
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load i8*, i8** %l2
  %t101 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t102 = load i8*, i8** %l4
  %t103 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t104 = load double, double* %l6
  %t105 = load i8*, i8** %l7
  br i1 %t97, label %then8, label %merge9
then8:
  %t106 = load double, double* %l6
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l6
  br label %loop.latch4
merge9:
  %t109 = load i8*, i8** %l7
  %s110 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.110, i32 0, i32 0
  %t111 = icmp eq i8* %t109, %s110
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load i8*, i8** %l1
  %t114 = load i8*, i8** %l2
  %t115 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t116 = load i8*, i8** %l4
  %t117 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t118 = load double, double* %l6
  %t119 = load i8*, i8** %l7
  br i1 %t111, label %then10, label %merge11
then10:
  %t120 = load double, double* %l6
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  store double %t122, double* %l6
  br label %afterloop5
merge11:
  %t123 = load i8*, i8** %l7
  %s124 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.124, i32 0, i32 0
  %t125 = icmp eq i8* %t123, %s124
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load i8*, i8** %l2
  %t129 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t130 = load i8*, i8** %l4
  %t131 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t132 = load double, double* %l6
  %t133 = load i8*, i8** %l7
  br i1 %t125, label %then12, label %merge13
then12:
  %t134 = load double, double* %l6
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l6
  br label %loop.latch4
merge13:
  %t137 = load i8*, i8** %l7
  %s138 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.138, i32 0, i32 0
  %t139 = call i1 @starts_with(i8* %t137, i8* %s138)
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load i8*, i8** %l1
  %t142 = load i8*, i8** %l2
  %t143 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t144 = load i8*, i8** %l4
  %t145 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t146 = load double, double* %l6
  %t147 = load i8*, i8** %l7
  br i1 %t139, label %then14, label %merge15
then14:
  %t148 = load i8*, i8** %l7
  %s149 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.149, i32 0, i32 0
  %t150 = call i8* @strip_prefix(i8* %t148, i8* %s149)
  %t151 = load i8*, i8** %l4
  %t152 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t150, i8* %t151)
  store %InterfaceSignatureParse %t152, %InterfaceSignatureParse* %l8
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t155 = extractvalue %InterfaceSignatureParse %t154, 2
  %t156 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t153, { i8**, i64 }* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %t157 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t158 = extractvalue %InterfaceSignatureParse %t157, 0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = load i8*, i8** %l1
  %t161 = load i8*, i8** %l2
  %t162 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t163 = load i8*, i8** %l4
  %t164 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t165 = load double, double* %l6
  %t166 = load i8*, i8** %l7
  %t167 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t158, label %then16, label %merge17
then16:
  %t168 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t169 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t170 = extractvalue %InterfaceSignatureParse %t169, 1
  %t171 = alloca [1 x i8*]
  %t172 = getelementptr [1 x i8*], [1 x i8*]* %t171, i32 0, i32 0
  %t173 = getelementptr i8*, i8** %t172, i64 0
  store i8* %t170, i8** %t173
  %t174 = alloca { i8**, i64 }
  %t175 = getelementptr { i8**, i64 }, { i8**, i64 }* %t174, i32 0, i32 0
  store i8** %t172, i8*** %t175
  %t176 = getelementptr { i8**, i64 }, { i8**, i64 }* %t174, i32 0, i32 1
  store i64 1, i64* %t176
  %t177 = bitcast { %NativeInterfaceSignature*, i64 }* %t168 to { i8**, i64 }*
  %t178 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t177, { i8**, i64 }* %t174)
  %t179 = bitcast { i8**, i64 }* %t178 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t179, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t180 = phi { %NativeInterfaceSignature*, i64 }* [ %t179, %then16 ], [ %t164, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t180, { %NativeInterfaceSignature*, i64 }** %l5
  %t181 = load double, double* %l6
  %t182 = sitofp i64 1 to double
  %t183 = fadd double %t181, %t182
  store double %t183, double* %l6
  br label %loop.latch4
merge15:
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s185 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.185, i32 0, i32 0
  %t186 = load i8*, i8** %l7
  %t187 = add i8* %s185, %t186
  %t188 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t184, i8* %t187)
  store { i8**, i64 }* %t188, { i8**, i64 }** %l0
  %t189 = load double, double* %l6
  %t190 = sitofp i64 1 to double
  %t191 = fadd double %t189, %t190
  store double %t191, double* %l6
  br label %loop.latch4
loop.latch4:
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t193 = load double, double* %l6
  %t194 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t198 = load i8*, i8** %l4
  %t199 = insertvalue %NativeInterface undef, i8* %t198, 0
  %t200 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t201 = extractvalue %InterfaceHeaderParse %t200, 1
  %t202 = insertvalue %NativeInterface %t199, { i8**, i64 }* %t201, 1
  %t203 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t204 = bitcast { %NativeInterfaceSignature*, i64 }* %t203 to { i8**, i64 }*
  %t205 = insertvalue %NativeInterface %t202, { i8**, i64 }* %t204, 2
  %t206 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t207 = load double, double* %l6
  %t208 = insertvalue %InterfaceParseResult %t206, double %t207, 1
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t210 = insertvalue %InterfaceParseResult %t208, { i8**, i64 }* %t209, 2
  ret %InterfaceParseResult %t210
}

define %StructHeaderParse @parse_struct_header(i8* %text) {
entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t3 = alloca [0 x i8*]
  %t4 = getelementptr [0 x i8*], [0 x i8*]* %t3, i32 0, i32 0
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t4, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* %t5, { i8**, i64 }** %l2
  %t8 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t9 = extractvalue %HeaderNameParse %t8, 2
  %t10 = call i64 @sailfin_runtime_string_length(i8* %t9)
  %t11 = icmp sgt i64 %t10, 0
  %t12 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t11, label %then0, label %merge1
then0:
  %t15 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t16 = extractvalue %HeaderNameParse %t15, 2
  %s17 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.17, i32 0, i32 0
  %t18 = call i1 @starts_with(i8* %t16, i8* %s17)
  %t19 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then2, label %else3
then2:
  %t22 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t23 = extractvalue %HeaderNameParse %t22, 2
  %s24 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.24, i32 0, i32 0
  %t25 = call i8* @strip_prefix(i8* %t23, i8* %s24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l3
  %t27 = load i8*, i8** %l3
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp eq i64 %t28, 0
  %t30 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = load i8*, i8** %l3
  br i1 %t29, label %then5, label %else6
then5:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s35 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.35, i32 0, i32 0
  %t36 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t37 = extractvalue %HeaderNameParse %t36, 0
  %t38 = add i8* %s35, %t37
  %s39 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.39, i32 0, i32 0
  %t40 = add i8* %t38, %s39
  %t41 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l1
  br label %merge7
else6:
  %t42 = load i8*, i8** %l3
  %t43 = call { i8**, i64 }* @parse_implements_list(i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l2
  br label %merge7
merge7:
  %t44 = phi { i8**, i64 }* [ %t41, %then5 ], [ %t31, %else6 ]
  %t45 = phi { i8**, i64 }* [ %t32, %then5 ], [ %t43, %else6 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l1
  store { i8**, i64 }* %t45, { i8**, i64 }** %l2
  br label %merge4
else3:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s47 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.47, i32 0, i32 0
  %t48 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t49 = extractvalue %HeaderNameParse %t48, 0
  %t50 = add i8* %s47, %t49
  %s51 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.51, i32 0, i32 0
  %t52 = add i8* %t50, %s51
  %t53 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t54 = extractvalue %HeaderNameParse %t53, 2
  %t55 = add i8* %t52, %t54
  %t56 = getelementptr i8, i8* %t55, i64 0
  %t57 = load i8, i8* %t56
  %t58 = add i8 %t57, 96
  %t59 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* null)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t60 = phi { i8**, i64 }* [ %t41, %then2 ], [ %t59, %else3 ]
  %t61 = phi { i8**, i64 }* [ %t43, %then2 ], [ %t21, %else3 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  store { i8**, i64 }* %t61, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t62 = phi { i8**, i64 }* [ %t41, %then0 ], [ %t13, %entry ]
  %t63 = phi { i8**, i64 }* [ %t43, %then0 ], [ %t14, %entry ]
  %t64 = phi { i8**, i64 }* [ %t59, %then0 ], [ %t13, %entry ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  store { i8**, i64 }* %t63, { i8**, i64 }** %l2
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  %t65 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t66 = extractvalue %HeaderNameParse %t65, 0
  %t67 = insertvalue %StructHeaderParse undef, i8* %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = insertvalue %StructHeaderParse %t67, { i8**, i64 }* %t68, 1
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = insertvalue %StructHeaderParse %t69, { i8**, i64 }* %t70, 2
  ret %StructHeaderParse %t71
}

define %InterfaceHeaderParse @parse_interface_header(i8* %text) {
entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t3 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t4 = extractvalue %HeaderNameParse %t3, 2
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = icmp sgt i64 %t5, 0
  %t7 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s10 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.10, i32 0, i32 0
  %t11 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t12 = extractvalue %HeaderNameParse %t11, 0
  %t13 = add i8* %s10, %t12
  %s14 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  %t16 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t17 = extractvalue %HeaderNameParse %t16, 2
  %t18 = add i8* %t15, %t17
  %t19 = getelementptr i8, i8* %t18, i64 0
  %t20 = load i8, i8* %t19
  %t21 = add i8 %t20, 96
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* null)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t23 = phi { i8**, i64 }* [ %t22, %then0 ], [ %t8, %entry ]
  store { i8**, i64 }* %t23, { i8**, i64 }** %l1
  %t24 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t25 = extractvalue %HeaderNameParse %t24, 0
  %t26 = insertvalue %InterfaceHeaderParse undef, i8* %t25, 0
  %t27 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t28 = extractvalue %HeaderNameParse %t27, 1
  %t29 = insertvalue %InterfaceHeaderParse %t26, { i8**, i64 }* %t28, 1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = insertvalue %InterfaceHeaderParse %t29, { i8**, i64 }* %t30, 2
  ret %InterfaceHeaderParse %t31
}

define %InterfaceSignatureParse @parse_interface_signature(i8* %text, i8* %interface_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeInterfaceSignature
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %HeaderNameParse
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca { %NativeParameter*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca %NativeInterfaceSignature
  %l22 = alloca i1
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  %t6 = insertvalue %NativeInterfaceSignature undef, i8* %s5, 0
  %t7 = insertvalue %NativeInterfaceSignature %t6, i1 0, 1
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %NativeInterfaceSignature %t7, { i8**, i64 }* %t10, 2
  %t14 = alloca [0 x i8*]
  %t15 = getelementptr [0 x i8*], [0 x i8*]* %t14, i32 0, i32 0
  %t16 = alloca { i8**, i64 }
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t15, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  %t19 = insertvalue %NativeInterfaceSignature %t13, { i8**, i64 }* %t16, 3
  %s20 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.20, i32 0, i32 0
  %t21 = insertvalue %NativeInterfaceSignature %t19, i8* %s20, 4
  %t22 = alloca [0 x i8*]
  %t23 = getelementptr [0 x i8*], [0 x i8*]* %t22, i32 0, i32 0
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t23, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  %t27 = insertvalue %NativeInterfaceSignature %t21, { i8**, i64 }* %t24, 5
  store %NativeInterfaceSignature %t27, %NativeInterfaceSignature* %l1
  %t28 = call i8* @trim_text(i8* %text)
  %t29 = call i8* @trim_trailing_delimiters(i8* %t28)
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %t30)
  %t32 = icmp eq i64 %t31, 0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then0, label %merge1
then0:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %s37, %interface_name
  %s39 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.39, i32 0, i32 0
  %t40 = add i8* %t38, %s39
  %t41 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t36, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  %t42 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t43 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t44 = insertvalue %InterfaceSignatureParse %t42, i8* null, 1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = insertvalue %InterfaceSignatureParse %t44, { i8**, i64 }* %t45, 2
  ret %InterfaceSignatureParse %t46
merge1:
  %t47 = load i8*, i8** %l2
  store i8* %t47, i8** %l3
  store i1 0, i1* %l4
  %t48 = load i8*, i8** %l3
  %s49 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.49, i32 0, i32 0
  %t50 = call i1 @starts_with(i8* %t48, i8* %s49)
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t53 = load i8*, i8** %l2
  %t54 = load i8*, i8** %l3
  %t55 = load i1, i1* %l4
  br i1 %t50, label %then2, label %merge3
then2:
  store i1 1, i1* %l4
  %t56 = load i8*, i8** %l3
  %s57 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i8* @strip_prefix(i8* %t56, i8* %s57)
  %t59 = call i8* @trim_text(i8* %t58)
  store i8* %t59, i8** %l3
  br label %merge3
merge3:
  %t60 = phi i1 [ 1, %then2 ], [ %t55, %entry ]
  %t61 = phi i8* [ %t59, %then2 ], [ %t54, %entry ]
  store i1 %t60, i1* %l4
  store i8* %t61, i8** %l3
  %t62 = load i8*, i8** %l3
  %t63 = call double @index_of(i8* %t62, i8* null)
  store double %t63, double* %l5
  %t64 = load double, double* %l5
  %t65 = sitofp i64 0 to double
  %t66 = fcmp olt double %t64, %t65
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t69 = load i8*, i8** %l2
  %t70 = load i8*, i8** %l3
  %t71 = load i1, i1* %l4
  %t72 = load double, double* %l5
  br i1 %t66, label %then4, label %merge5
then4:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.74, i32 0, i32 0
  %t75 = add i8* %s74, %interface_name
  %s76 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.76, i32 0, i32 0
  %t77 = add i8* %t75, %s76
  %t78 = load i8*, i8** %l2
  %t79 = add i8* %t77, %t78
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t73, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  %t81 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t82 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t83 = insertvalue %InterfaceSignatureParse %t81, i8* null, 1
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = insertvalue %InterfaceSignatureParse %t83, { i8**, i64 }* %t84, 2
  ret %InterfaceSignatureParse %t85
merge5:
  %t86 = load i8*, i8** %l3
  %t87 = load double, double* %l5
  %t88 = call double @find_matching_paren(i8* %t86, double %t87)
  store double %t88, double* %l6
  %t89 = load double, double* %l6
  %t90 = sitofp i64 0 to double
  %t91 = fcmp olt double %t89, %t90
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t94 = load i8*, i8** %l2
  %t95 = load i8*, i8** %l3
  %t96 = load i1, i1* %l4
  %t97 = load double, double* %l5
  %t98 = load double, double* %l6
  br i1 %t91, label %then6, label %merge7
then6:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s100 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.100, i32 0, i32 0
  %t101 = add i8* %s100, %interface_name
  %s102 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %t101, %s102
  %t104 = load i8*, i8** %l2
  %t105 = add i8* %t103, %t104
  %t106 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t99, i8* %t105)
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t108 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t109 = insertvalue %InterfaceSignatureParse %t107, i8* null, 1
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = insertvalue %InterfaceSignatureParse %t109, { i8**, i64 }* %t110, 2
  ret %InterfaceSignatureParse %t111
merge7:
  %t112 = load i8*, i8** %l3
  %t113 = load double, double* %l5
  %t114 = fptosi double %t113 to i64
  %t115 = call i8* @sailfin_runtime_substring(i8* %t112, i64 0, i64 %t114)
  %t116 = call i8* @trim_text(i8* %t115)
  store i8* %t116, i8** %l7
  %t117 = load i8*, i8** %l7
  %t118 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t117)
  store %HeaderNameParse %t118, %HeaderNameParse* %l8
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t121 = extractvalue %HeaderNameParse %t120, 3
  %t122 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t119, { i8**, i64 }* %t121)
  store { i8**, i64 }* %t122, { i8**, i64 }** %l0
  %t123 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t124 = extractvalue %HeaderNameParse %t123, 2
  %t125 = call i64 @sailfin_runtime_string_length(i8* %t124)
  %t126 = icmp sgt i64 %t125, 0
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t129 = load i8*, i8** %l2
  %t130 = load i8*, i8** %l3
  %t131 = load i1, i1* %l4
  %t132 = load double, double* %l5
  %t133 = load double, double* %l6
  %t134 = load i8*, i8** %l7
  %t135 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t126, label %then8, label %merge9
then8:
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s137 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.137, i32 0, i32 0
  %t138 = add i8* %s137, %interface_name
  %s139 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.139, i32 0, i32 0
  %t140 = add i8* %t138, %s139
  %t141 = load i8*, i8** %l2
  %t142 = add i8* %t140, %t141
  %s143 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.143, i32 0, i32 0
  %t144 = add i8* %t142, %s143
  %t145 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t146 = extractvalue %HeaderNameParse %t145, 2
  %t147 = add i8* %t144, %t146
  %t148 = getelementptr i8, i8* %t147, i64 0
  %t149 = load i8, i8* %t148
  %t150 = add i8 %t149, 96
  %t151 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t136, i8* null)
  store { i8**, i64 }* %t151, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t152 = phi { i8**, i64 }* [ %t151, %then8 ], [ %t127, %entry ]
  store { i8**, i64 }* %t152, { i8**, i64 }** %l0
  %t153 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t154 = extractvalue %HeaderNameParse %t153, 0
  store i8* %t154, i8** %l9
  %t155 = load i8*, i8** %l9
  %t156 = call i64 @sailfin_runtime_string_length(i8* %t155)
  %t157 = icmp eq i64 %t156, 0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t160 = load i8*, i8** %l2
  %t161 = load i8*, i8** %l3
  %t162 = load i1, i1* %l4
  %t163 = load double, double* %l5
  %t164 = load double, double* %l6
  %t165 = load i8*, i8** %l7
  %t166 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t167 = load i8*, i8** %l9
  br i1 %t157, label %then10, label %merge11
then10:
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s169 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.169, i32 0, i32 0
  %t170 = add i8* %s169, %interface_name
  %s171 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.171, i32 0, i32 0
  %t172 = add i8* %t170, %s171
  %t173 = load i8*, i8** %l2
  %t174 = add i8* %t172, %t173
  %s175 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.175, i32 0, i32 0
  %t176 = add i8* %t174, %s175
  %t177 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t168, i8* %t176)
  store { i8**, i64 }* %t177, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t178 = phi { i8**, i64 }* [ %t177, %then10 ], [ %t158, %entry ]
  store { i8**, i64 }* %t178, { i8**, i64 }** %l0
  %t179 = load i8*, i8** %l3
  %t180 = load double, double* %l5
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  %t183 = load double, double* %l6
  %t184 = fptosi double %t182 to i64
  %t185 = fptosi double %t183 to i64
  %t186 = call i8* @sailfin_runtime_substring(i8* %t179, i64 %t184, i64 %t185)
  store i8* %t186, i8** %l10
  %t187 = alloca [0 x %NativeParameter]
  %t188 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t187, i32 0, i32 0
  %t189 = alloca { %NativeParameter*, i64 }
  %t190 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t189, i32 0, i32 0
  store %NativeParameter* %t188, %NativeParameter** %t190
  %t191 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t189, i32 0, i32 1
  store i64 0, i64* %t191
  store { %NativeParameter*, i64 }* %t189, { %NativeParameter*, i64 }** %l11
  %t192 = load i8*, i8** %l10
  %t193 = call i8* @trim_text(i8* %t192)
  store i8* %t193, i8** %l12
  %t194 = load i8*, i8** %l12
  %t195 = call i64 @sailfin_runtime_string_length(i8* %t194)
  %t196 = icmp sgt i64 %t195, 0
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t199 = load i8*, i8** %l2
  %t200 = load i8*, i8** %l3
  %t201 = load i1, i1* %l4
  %t202 = load double, double* %l5
  %t203 = load double, double* %l6
  %t204 = load i8*, i8** %l7
  %t205 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t206 = load i8*, i8** %l9
  %t207 = load i8*, i8** %l10
  %t208 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t209 = load i8*, i8** %l12
  br i1 %t196, label %then12, label %merge13
then12:
  %t210 = load i8*, i8** %l12
  %t211 = call { i8**, i64 }* @split_parameter_entries(i8* %t210)
  store { i8**, i64 }* %t211, { i8**, i64 }** %l13
  %t212 = sitofp i64 0 to double
  store double %t212, double* %l14
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t215 = load i8*, i8** %l2
  %t216 = load i8*, i8** %l3
  %t217 = load i1, i1* %l4
  %t218 = load double, double* %l5
  %t219 = load double, double* %l6
  %t220 = load i8*, i8** %l7
  %t221 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t222 = load i8*, i8** %l9
  %t223 = load i8*, i8** %l10
  %t224 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t225 = load i8*, i8** %l12
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t227 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t264 = phi double [ %t227, %then12 ], [ %t263, %loop.latch16 ]
  store double %t264, double* %l14
  br label %loop.body15
loop.body15:
  %t228 = load double, double* %l14
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t230 = load { i8**, i64 }, { i8**, i64 }* %t229
  %t231 = extractvalue { i8**, i64 } %t230, 1
  %t232 = sitofp i64 %t231 to double
  %t233 = fcmp oge double %t228, %t232
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t235 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t236 = load i8*, i8** %l2
  %t237 = load i8*, i8** %l3
  %t238 = load i1, i1* %l4
  %t239 = load double, double* %l5
  %t240 = load double, double* %l6
  %t241 = load i8*, i8** %l7
  %t242 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t243 = load i8*, i8** %l9
  %t244 = load i8*, i8** %l10
  %t245 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t246 = load i8*, i8** %l12
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t248 = load double, double* %l14
  br i1 %t233, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t250 = load double, double* %l14
  %t251 = fptosi double %t250 to i64
  %t252 = load { i8**, i64 }, { i8**, i64 }* %t249
  %t253 = extractvalue { i8**, i64 } %t252, 0
  %t254 = extractvalue { i8**, i64 } %t252, 1
  %t255 = icmp uge i64 %t251, %t254
  ; bounds check: %t255 (if true, out of bounds)
  %t256 = getelementptr i8*, i8** %t253, i64 %t251
  %t257 = load i8*, i8** %t256
  %t258 = call double @parse_parameter_entry(i8* %t257, i8* null)
  store double %t258, double* %l15
  %t259 = load double, double* %l15
  %t260 = load double, double* %l14
  %t261 = sitofp i64 1 to double
  %t262 = fadd double %t260, %t261
  store double %t262, double* %l14
  br label %loop.latch16
loop.latch16:
  %t263 = load double, double* %l14
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %s265 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.265, i32 0, i32 0
  store i8* %s265, i8** %l16
  %t266 = alloca [0 x i8*]
  %t267 = getelementptr [0 x i8*], [0 x i8*]* %t266, i32 0, i32 0
  %t268 = alloca { i8**, i64 }
  %t269 = getelementptr { i8**, i64 }, { i8**, i64 }* %t268, i32 0, i32 0
  store i8** %t267, i8*** %t269
  %t270 = getelementptr { i8**, i64 }, { i8**, i64 }* %t268, i32 0, i32 1
  store i64 0, i64* %t270
  store { i8**, i64 }* %t268, { i8**, i64 }** %l17
  %t271 = load i8*, i8** %l3
  %t272 = load double, double* %l6
  %t273 = sitofp i64 1 to double
  %t274 = fadd double %t272, %t273
  %t275 = load i8*, i8** %l3
  %t276 = call i64 @sailfin_runtime_string_length(i8* %t275)
  %t277 = fptosi double %t274 to i64
  %t278 = call i8* @sailfin_runtime_substring(i8* %t271, i64 %t277, i64 %t276)
  %t279 = call i8* @trim_text(i8* %t278)
  store i8* %t279, i8** %l18
  %t280 = load i8*, i8** %l18
  %t281 = call i64 @sailfin_runtime_string_length(i8* %t280)
  %t282 = icmp sgt i64 %t281, 0
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t284 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t285 = load i8*, i8** %l2
  %t286 = load i8*, i8** %l3
  %t287 = load i1, i1* %l4
  %t288 = load double, double* %l5
  %t289 = load double, double* %l6
  %t290 = load i8*, i8** %l7
  %t291 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t292 = load i8*, i8** %l9
  %t293 = load i8*, i8** %l10
  %t294 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t295 = load i8*, i8** %l12
  %t296 = load i8*, i8** %l16
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t298 = load i8*, i8** %l18
  br i1 %t282, label %then20, label %merge21
then20:
  %t299 = load i8*, i8** %l18
  %s300 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.300, i32 0, i32 0
  %t301 = call double @index_of(i8* %t299, i8* %s300)
  store double %t301, double* %l19
  %s302 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.302, i32 0, i32 0
  store i8* %s302, i8** %l20
  %t303 = load double, double* %l19
  %t304 = sitofp i64 0 to double
  %t305 = fcmp oge double %t303, %t304
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t307 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t308 = load i8*, i8** %l2
  %t309 = load i8*, i8** %l3
  %t310 = load i1, i1* %l4
  %t311 = load double, double* %l5
  %t312 = load double, double* %l6
  %t313 = load i8*, i8** %l7
  %t314 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t315 = load i8*, i8** %l9
  %t316 = load i8*, i8** %l10
  %t317 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t318 = load i8*, i8** %l12
  %t319 = load i8*, i8** %l16
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t321 = load i8*, i8** %l18
  %t322 = load double, double* %l19
  %t323 = load i8*, i8** %l20
  br i1 %t305, label %then22, label %merge23
then22:
  %t324 = load i8*, i8** %l18
  %t325 = load double, double* %l19
  %t326 = load i8*, i8** %l18
  %t327 = call i64 @sailfin_runtime_string_length(i8* %t326)
  %t328 = fptosi double %t325 to i64
  %t329 = call i8* @sailfin_runtime_substring(i8* %t324, i64 %t328, i64 %t327)
  %t330 = call i8* @trim_text(i8* %t329)
  store i8* %t330, i8** %l20
  %t331 = load i8*, i8** %l18
  %t332 = load double, double* %l19
  %t333 = fptosi double %t332 to i64
  %t334 = call i8* @sailfin_runtime_substring(i8* %t331, i64 0, i64 %t333)
  %t335 = call i8* @trim_text(i8* %t334)
  store i8* %t335, i8** %l18
  br label %merge23
merge23:
  %t336 = phi i8* [ %t330, %then22 ], [ %t323, %then20 ]
  %t337 = phi i8* [ %t335, %then22 ], [ %t321, %then20 ]
  store i8* %t336, i8** %l20
  store i8* %t337, i8** %l18
  %t338 = load i8*, i8** %l18
  %t339 = call i64 @sailfin_runtime_string_length(i8* %t338)
  %t340 = icmp sgt i64 %t339, 0
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t342 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t343 = load i8*, i8** %l2
  %t344 = load i8*, i8** %l3
  %t345 = load i1, i1* %l4
  %t346 = load double, double* %l5
  %t347 = load double, double* %l6
  %t348 = load i8*, i8** %l7
  %t349 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t350 = load i8*, i8** %l9
  %t351 = load i8*, i8** %l10
  %t352 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t353 = load i8*, i8** %l12
  %t354 = load i8*, i8** %l16
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t356 = load i8*, i8** %l18
  %t357 = load double, double* %l19
  %t358 = load i8*, i8** %l20
  br i1 %t340, label %then24, label %merge25
then24:
  %t359 = load i8*, i8** %l18
  br label %merge25
merge25:
  %t360 = load i8*, i8** %l20
  %t361 = call i64 @sailfin_runtime_string_length(i8* %t360)
  %t362 = icmp sgt i64 %t361, 0
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t364 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t365 = load i8*, i8** %l2
  %t366 = load i8*, i8** %l3
  %t367 = load i1, i1* %l4
  %t368 = load double, double* %l5
  %t369 = load double, double* %l6
  %t370 = load i8*, i8** %l7
  %t371 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t372 = load i8*, i8** %l9
  %t373 = load i8*, i8** %l10
  %t374 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t375 = load i8*, i8** %l12
  %t376 = load i8*, i8** %l16
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t378 = load i8*, i8** %l18
  %t379 = load double, double* %l19
  %t380 = load i8*, i8** %l20
  br i1 %t362, label %then26, label %merge27
then26:
  %t382 = load i8*, i8** %l20
  %s383 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.383, i32 0, i32 0
  %t384 = call i1 @starts_with(i8* %t382, i8* %s383)
  br label %logical_and_entry_381

logical_and_entry_381:
  br i1 %t384, label %logical_and_right_381, label %logical_and_merge_381

logical_and_right_381:
  br label %merge27
merge27:
  br label %merge21
merge21:
  %t385 = phi i8* [ %t335, %then20 ], [ %t298, %entry ]
  store i8* %t385, i8** %l18
  %t386 = load i8*, i8** %l9
  %t387 = insertvalue %NativeInterfaceSignature undef, i8* %t386, 0
  %t388 = load i1, i1* %l4
  %t389 = insertvalue %NativeInterfaceSignature %t387, i1 %t388, 1
  %t390 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t391 = extractvalue %HeaderNameParse %t390, 1
  %t392 = insertvalue %NativeInterfaceSignature %t389, { i8**, i64 }* %t391, 2
  %t393 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t394 = bitcast { %NativeParameter*, i64 }* %t393 to { i8**, i64 }*
  %t395 = insertvalue %NativeInterfaceSignature %t392, { i8**, i64 }* %t394, 3
  %t396 = load i8*, i8** %l16
  %t397 = insertvalue %NativeInterfaceSignature %t395, i8* %t396, 4
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t399 = insertvalue %NativeInterfaceSignature %t397, { i8**, i64 }* %t398, 5
  store %NativeInterfaceSignature %t399, %NativeInterfaceSignature* %l21
  %t401 = load i8*, i8** %l9
  %t402 = call i64 @sailfin_runtime_string_length(i8* %t401)
  %t403 = icmp sgt i64 %t402, 0
  br label %logical_and_entry_400

logical_and_entry_400:
  br i1 %t403, label %logical_and_right_400, label %logical_and_merge_400

logical_and_right_400:
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t405 = load { i8**, i64 }, { i8**, i64 }* %t404
  %t406 = extractvalue { i8**, i64 } %t405, 1
  %t407 = icmp eq i64 %t406, 0
  br label %logical_and_right_end_400

logical_and_right_end_400:
  br label %logical_and_merge_400

logical_and_merge_400:
  %t408 = phi i1 [ false, %logical_and_entry_400 ], [ %t407, %logical_and_right_end_400 ]
  store i1 %t408, i1* %l22
  %t409 = load i1, i1* %l22
  %t410 = insertvalue %InterfaceSignatureParse undef, i1 %t409, 0
  %t411 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l21
  %t412 = insertvalue %InterfaceSignatureParse %t410, i8* null, 1
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t414 = insertvalue %InterfaceSignatureParse %t412, { i8**, i64 }* %t413, 2
  ret %InterfaceSignatureParse %t414
}

define %HeaderNameParse @parse_header_name_and_remainder(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = call i8* @trim_text(i8* %text)
  store i8* %t5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  br i1 %t8, label %then0, label %merge1
then0:
  %s11 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.11, i32 0, i32 0
  %t12 = insertvalue %HeaderNameParse undef, i8* %s11, 0
  %t13 = alloca [0 x i8*]
  %t14 = getelementptr [0 x i8*], [0 x i8*]* %t13, i32 0, i32 0
  %t15 = alloca { i8**, i64 }
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 0
  store i8** %t14, i8*** %t16
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  %t18 = insertvalue %HeaderNameParse %t12, { i8**, i64 }* %t15, 1
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.19, i32 0, i32 0
  %t20 = insertvalue %HeaderNameParse %t18, i8* %s19, 2
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = insertvalue %HeaderNameParse %t20, { i8**, i64 }* %t21, 3
  ret %HeaderNameParse %t22
merge1:
  %t23 = load i8*, i8** %l1
  store i8* %t23, i8** %l2
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.24, i32 0, i32 0
  store i8* %s24, i8** %l3
  %t25 = alloca [0 x i8*]
  %t26 = getelementptr [0 x i8*], [0 x i8*]* %t25, i32 0, i32 0
  %t27 = alloca { i8**, i64 }
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 0
  store i8** %t26, i8*** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { i8**, i64 }* %t27, { i8**, i64 }** %l4
  %t30 = load i8*, i8** %l1
  store double 0.0, double* %l5
  %t31 = load double, double* %l5
  %t32 = sitofp i64 0 to double
  %t33 = fcmp oge double %t31, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l2
  %t37 = load i8*, i8** %l3
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t39 = load double, double* %l5
  br i1 %t33, label %then2, label %else3
then2:
  %t40 = load i8*, i8** %l1
  %t41 = load double, double* %l5
  %t42 = call double @find_matching_angle(i8* %t40, double %t41)
  store double %t42, double* %l6
  %t43 = load double, double* %l6
  %t44 = sitofp i64 0 to double
  %t45 = fcmp olt double %t43, %t44
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load i8*, i8** %l2
  %t49 = load i8*, i8** %l3
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t51 = load double, double* %l5
  %t52 = load double, double* %l6
  br i1 %t45, label %then5, label %merge6
then5:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s54 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.54, i32 0, i32 0
  %t55 = add i8* %s54, %text
  %t56 = load i8*, i8** %l1
  %t57 = call i8* @strip_generics(i8* %t56)
  store i8* %t57, i8** %l2
  %t58 = load i8*, i8** %l2
  %t59 = insertvalue %HeaderNameParse undef, i8* %t58, 0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t61 = insertvalue %HeaderNameParse %t59, { i8**, i64 }* %t60, 1
  %t62 = load i8*, i8** %l3
  %t63 = insertvalue %HeaderNameParse %t61, i8* %t62, 2
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = insertvalue %HeaderNameParse %t63, { i8**, i64 }* %t64, 3
  ret %HeaderNameParse %t65
merge6:
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l5
  %t68 = fptosi double %t67 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %t66, i64 0, i64 %t68)
  %t70 = call i8* @trim_text(i8* %t69)
  store i8* %t70, i8** %l2
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l5
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  %t75 = load double, double* %l6
  %t76 = fptosi double %t74 to i64
  %t77 = fptosi double %t75 to i64
  %t78 = call i8* @sailfin_runtime_substring(i8* %t71, i64 %t76, i64 %t77)
  store i8* %t78, i8** %l7
  %t79 = load i8*, i8** %l7
  %t80 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l4
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l6
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  %t85 = load i8*, i8** %l1
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = fptosi double %t84 to i64
  %t88 = call i8* @sailfin_runtime_substring(i8* %t81, i64 %t87, i64 %t86)
  %t89 = call i8* @trim_text(i8* %t88)
  store i8* %t89, i8** %l3
  br label %merge4
else3:
  %t90 = load i8*, i8** %l1
  %t91 = call double @index_of(i8* %t90, i8* null)
  store double %t91, double* %l8
  %t92 = load double, double* %l8
  %t93 = sitofp i64 0 to double
  %t94 = fcmp oge double %t92, %t93
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load i8*, i8** %l2
  %t98 = load i8*, i8** %l3
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t100 = load double, double* %l5
  %t101 = load double, double* %l8
  br i1 %t94, label %then7, label %merge8
then7:
  %t102 = load i8*, i8** %l1
  %t103 = load double, double* %l8
  %t104 = fptosi double %t103 to i64
  %t105 = call i8* @sailfin_runtime_substring(i8* %t102, i64 0, i64 %t104)
  %t106 = call i8* @trim_text(i8* %t105)
  store i8* %t106, i8** %l2
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l8
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  %t111 = load i8*, i8** %l1
  %t112 = call i64 @sailfin_runtime_string_length(i8* %t111)
  %t113 = fptosi double %t110 to i64
  %t114 = call i8* @sailfin_runtime_substring(i8* %t107, i64 %t113, i64 %t112)
  %t115 = call i8* @trim_text(i8* %t114)
  store i8* %t115, i8** %l3
  br label %merge8
merge8:
  %t116 = phi i8* [ %t106, %then7 ], [ %t97, %else3 ]
  %t117 = phi i8* [ %t115, %then7 ], [ %t98, %else3 ]
  store i8* %t116, i8** %l2
  store i8* %t117, i8** %l3
  br label %merge4
merge4:
  %t118 = phi { i8**, i64 }* [ null, %then2 ], [ %t34, %else3 ]
  %t119 = phi i8* [ %t57, %then2 ], [ %t106, %else3 ]
  %t120 = phi { i8**, i64 }* [ %t80, %then2 ], [ %t38, %else3 ]
  %t121 = phi i8* [ %t89, %then2 ], [ %t115, %else3 ]
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  store i8* %t119, i8** %l2
  store { i8**, i64 }* %t120, { i8**, i64 }** %l4
  store i8* %t121, i8** %l3
  %t122 = load i8*, i8** %l2
  %t123 = call i8* @strip_generics(i8* %t122)
  store i8* %t123, i8** %l2
  %t124 = load i8*, i8** %l2
  %t125 = insertvalue %HeaderNameParse undef, i8* %t124, 0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t127 = insertvalue %HeaderNameParse %t125, { i8**, i64 }* %t126, 1
  %t128 = load i8*, i8** %l3
  %t129 = insertvalue %HeaderNameParse %t127, i8* %t128, 2
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = insertvalue %HeaderNameParse %t129, { i8**, i64 }* %t130, 3
  ret %HeaderNameParse %t131
}

define { i8**, i64 }* @parse_type_parameter_entries(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_top_level_commas(i8* %t10)
  ret { i8**, i64 }* %t11
}

define { i8**, i64 }* @parse_implements_list(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_top_level_commas(i8* %t10)
  ret { i8**, i64 }* %t11
}

define { i8**, i64 }* @split_top_level_commas(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8
  %l9 = alloca i8*
  %l10 = alloca i8*
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
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
  store i8* %s7, i8** %l3
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l4
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l5
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l6
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l7
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load i8*, i8** %l1
  %t14 = load double, double* %l2
  %t15 = load i8*, i8** %l3
  %t16 = load double, double* %l4
  %t17 = load double, double* %l5
  %t18 = load double, double* %l6
  %t19 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t380 = phi i8* [ %t13, %entry ], [ %t373, %loop.latch2 ]
  %t381 = phi double [ %t14, %entry ], [ %t374, %loop.latch2 ]
  %t382 = phi i8* [ %t15, %entry ], [ %t375, %loop.latch2 ]
  %t383 = phi double [ %t17, %entry ], [ %t376, %loop.latch2 ]
  %t384 = phi double [ %t18, %entry ], [ %t377, %loop.latch2 ]
  %t385 = phi double [ %t19, %entry ], [ %t378, %loop.latch2 ]
  %t386 = phi { i8**, i64 }* [ %t12, %entry ], [ %t379, %loop.latch2 ]
  store i8* %t380, i8** %l1
  store double %t381, double* %l2
  store i8* %t382, i8** %l3
  store double %t383, double* %l5
  store double %t384, double* %l6
  store double %t385, double* %l7
  store { i8**, i64 }* %t386, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t20, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load i8*, i8** %l3
  %t28 = load double, double* %l4
  %t29 = load double, double* %l5
  %t30 = load double, double* %l6
  %t31 = load double, double* %l7
  br i1 %t23, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l2
  %t33 = fptosi double %t32 to i64
  %t34 = getelementptr i8, i8* %text, i64 %t33
  %t35 = load i8, i8* %t34
  store i8 %t35, i8* %l8
  %t36 = load i8*, i8** %l3
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp sgt i64 %t37, 0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load double, double* %l2
  %t42 = load i8*, i8** %l3
  %t43 = load double, double* %l4
  %t44 = load double, double* %l5
  %t45 = load double, double* %l6
  %t46 = load double, double* %l7
  %t47 = load i8, i8* %l8
  br i1 %t38, label %then6, label %merge7
then6:
  %t48 = load i8*, i8** %l1
  %t49 = load i8, i8* %l8
  %t50 = getelementptr i8, i8* %t48, i64 0
  %t51 = load i8, i8* %t50
  %t52 = add i8 %t51, %t49
  store i8* null, i8** %l1
  %t53 = load i8, i8* %l8
  %t54 = icmp eq i8 %t53, 92
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load i8*, i8** %l3
  %t59 = load double, double* %l4
  %t60 = load double, double* %l5
  %t61 = load double, double* %l6
  %t62 = load double, double* %l7
  %t63 = load i8, i8* %l8
  br i1 %t54, label %then8, label %merge9
then8:
  %t64 = load double, double* %l2
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  %t67 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t68 = sitofp i64 %t67 to double
  %t69 = fcmp olt double %t66, %t68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = load i8*, i8** %l3
  %t74 = load double, double* %l4
  %t75 = load double, double* %l5
  %t76 = load double, double* %l6
  %t77 = load double, double* %l7
  %t78 = load i8, i8* %l8
  br i1 %t69, label %then10, label %merge11
then10:
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l2
  %t81 = sitofp i64 2 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t83 = phi i8* [ null, %then8 ], [ %t56, %then6 ]
  %t84 = phi double [ %t82, %then8 ], [ %t57, %then6 ]
  store i8* %t83, i8** %l1
  store double %t84, double* %l2
  %t85 = load i8, i8* %l8
  %t86 = load i8*, i8** %l3
  %t87 = getelementptr i8, i8* %t86, i64 0
  %t88 = load i8, i8* %t87
  %t89 = icmp eq i8 %t85, %t88
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load double, double* %l2
  %t93 = load i8*, i8** %l3
  %t94 = load double, double* %l4
  %t95 = load double, double* %l5
  %t96 = load double, double* %l6
  %t97 = load double, double* %l7
  %t98 = load i8, i8* %l8
  br i1 %t89, label %then12, label %merge13
then12:
  %s99 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.99, i32 0, i32 0
  store i8* %s99, i8** %l3
  br label %merge13
merge13:
  %t100 = phi i8* [ %s99, %then12 ], [ %t93, %then6 ]
  store i8* %t100, i8** %l3
  %t101 = load double, double* %l2
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  store double %t103, double* %l2
  br label %loop.latch2
merge7:
  %t105 = load i8, i8* %l8
  %t106 = icmp eq i8 %t105, 34
  br label %logical_or_entry_104

logical_or_entry_104:
  br i1 %t106, label %logical_or_merge_104, label %logical_or_right_104

logical_or_right_104:
  %t107 = load i8, i8* %l8
  %t108 = icmp eq i8 %t107, 39
  br label %logical_or_right_end_104

logical_or_right_end_104:
  br label %logical_or_merge_104

logical_or_merge_104:
  %t109 = phi i1 [ true, %logical_or_entry_104 ], [ %t108, %logical_or_right_end_104 ]
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load i8*, i8** %l3
  %t114 = load double, double* %l4
  %t115 = load double, double* %l5
  %t116 = load double, double* %l6
  %t117 = load double, double* %l7
  %t118 = load i8, i8* %l8
  br i1 %t109, label %then14, label %merge15
then14:
  %t119 = load i8, i8* %l8
  store i8* null, i8** %l3
  %t120 = load i8*, i8** %l1
  %t121 = load i8, i8* %l8
  %t122 = getelementptr i8, i8* %t120, i64 0
  %t123 = load i8, i8* %t122
  %t124 = add i8 %t123, %t121
  store i8* null, i8** %l1
  %t125 = load double, double* %l2
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l2
  br label %loop.latch2
merge15:
  %t128 = load i8, i8* %l8
  %t129 = load i8, i8* %l8
  %t130 = load i8, i8* %l8
  %t131 = icmp eq i8 %t130, 40
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load i8*, i8** %l1
  %t134 = load double, double* %l2
  %t135 = load i8*, i8** %l3
  %t136 = load double, double* %l4
  %t137 = load double, double* %l5
  %t138 = load double, double* %l6
  %t139 = load double, double* %l7
  %t140 = load i8, i8* %l8
  br i1 %t131, label %then16, label %merge17
then16:
  %t141 = load double, double* %l5
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l5
  %t144 = load i8*, i8** %l1
  %t145 = load i8, i8* %l8
  %t146 = getelementptr i8, i8* %t144, i64 0
  %t147 = load i8, i8* %t146
  %t148 = add i8 %t147, %t145
  store i8* null, i8** %l1
  %t149 = load double, double* %l2
  %t150 = sitofp i64 1 to double
  %t151 = fadd double %t149, %t150
  store double %t151, double* %l2
  br label %loop.latch2
merge17:
  %t152 = load i8, i8* %l8
  %t153 = icmp eq i8 %t152, 41
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8*, i8** %l1
  %t156 = load double, double* %l2
  %t157 = load i8*, i8** %l3
  %t158 = load double, double* %l4
  %t159 = load double, double* %l5
  %t160 = load double, double* %l6
  %t161 = load double, double* %l7
  %t162 = load i8, i8* %l8
  br i1 %t153, label %then18, label %merge19
then18:
  %t163 = load double, double* %l5
  %t164 = sitofp i64 0 to double
  %t165 = fcmp ogt double %t163, %t164
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load i8*, i8** %l1
  %t168 = load double, double* %l2
  %t169 = load i8*, i8** %l3
  %t170 = load double, double* %l4
  %t171 = load double, double* %l5
  %t172 = load double, double* %l6
  %t173 = load double, double* %l7
  %t174 = load i8, i8* %l8
  br i1 %t165, label %then20, label %merge21
then20:
  %t175 = load double, double* %l5
  %t176 = sitofp i64 1 to double
  %t177 = fsub double %t175, %t176
  store double %t177, double* %l5
  br label %merge21
merge21:
  %t178 = phi double [ %t177, %then20 ], [ %t171, %then18 ]
  store double %t178, double* %l5
  %t179 = load i8*, i8** %l1
  %t180 = load i8, i8* %l8
  %t181 = getelementptr i8, i8* %t179, i64 0
  %t182 = load i8, i8* %t181
  %t183 = add i8 %t182, %t180
  store i8* null, i8** %l1
  %t184 = load double, double* %l2
  %t185 = sitofp i64 1 to double
  %t186 = fadd double %t184, %t185
  store double %t186, double* %l2
  br label %loop.latch2
merge19:
  %t187 = load i8, i8* %l8
  %t188 = icmp eq i8 %t187, 91
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load i8*, i8** %l3
  %t193 = load double, double* %l4
  %t194 = load double, double* %l5
  %t195 = load double, double* %l6
  %t196 = load double, double* %l7
  %t197 = load i8, i8* %l8
  br i1 %t188, label %then22, label %merge23
then22:
  %t198 = load double, double* %l6
  %t199 = sitofp i64 1 to double
  %t200 = fadd double %t198, %t199
  store double %t200, double* %l6
  %t201 = load i8*, i8** %l1
  %t202 = load i8, i8* %l8
  %t203 = getelementptr i8, i8* %t201, i64 0
  %t204 = load i8, i8* %t203
  %t205 = add i8 %t204, %t202
  store i8* null, i8** %l1
  %t206 = load double, double* %l2
  %t207 = sitofp i64 1 to double
  %t208 = fadd double %t206, %t207
  store double %t208, double* %l2
  br label %loop.latch2
merge23:
  %t209 = load i8, i8* %l8
  %t210 = icmp eq i8 %t209, 93
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t212 = load i8*, i8** %l1
  %t213 = load double, double* %l2
  %t214 = load i8*, i8** %l3
  %t215 = load double, double* %l4
  %t216 = load double, double* %l5
  %t217 = load double, double* %l6
  %t218 = load double, double* %l7
  %t219 = load i8, i8* %l8
  br i1 %t210, label %then24, label %merge25
then24:
  %t220 = load double, double* %l6
  %t221 = sitofp i64 0 to double
  %t222 = fcmp ogt double %t220, %t221
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load i8*, i8** %l1
  %t225 = load double, double* %l2
  %t226 = load i8*, i8** %l3
  %t227 = load double, double* %l4
  %t228 = load double, double* %l5
  %t229 = load double, double* %l6
  %t230 = load double, double* %l7
  %t231 = load i8, i8* %l8
  br i1 %t222, label %then26, label %merge27
then26:
  %t232 = load double, double* %l6
  %t233 = sitofp i64 1 to double
  %t234 = fsub double %t232, %t233
  store double %t234, double* %l6
  br label %merge27
merge27:
  %t235 = phi double [ %t234, %then26 ], [ %t229, %then24 ]
  store double %t235, double* %l6
  %t236 = load i8*, i8** %l1
  %t237 = load i8, i8* %l8
  %t238 = getelementptr i8, i8* %t236, i64 0
  %t239 = load i8, i8* %t238
  %t240 = add i8 %t239, %t237
  store i8* null, i8** %l1
  %t241 = load double, double* %l2
  %t242 = sitofp i64 1 to double
  %t243 = fadd double %t241, %t242
  store double %t243, double* %l2
  br label %loop.latch2
merge25:
  %t244 = load i8, i8* %l8
  %t245 = icmp eq i8 %t244, 123
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t247 = load i8*, i8** %l1
  %t248 = load double, double* %l2
  %t249 = load i8*, i8** %l3
  %t250 = load double, double* %l4
  %t251 = load double, double* %l5
  %t252 = load double, double* %l6
  %t253 = load double, double* %l7
  %t254 = load i8, i8* %l8
  br i1 %t245, label %then28, label %merge29
then28:
  %t255 = load double, double* %l7
  %t256 = sitofp i64 1 to double
  %t257 = fadd double %t255, %t256
  store double %t257, double* %l7
  %t258 = load i8*, i8** %l1
  %t259 = load i8, i8* %l8
  %t260 = getelementptr i8, i8* %t258, i64 0
  %t261 = load i8, i8* %t260
  %t262 = add i8 %t261, %t259
  store i8* null, i8** %l1
  %t263 = load double, double* %l2
  %t264 = sitofp i64 1 to double
  %t265 = fadd double %t263, %t264
  store double %t265, double* %l2
  br label %loop.latch2
merge29:
  %t266 = load i8, i8* %l8
  %t267 = icmp eq i8 %t266, 125
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t269 = load i8*, i8** %l1
  %t270 = load double, double* %l2
  %t271 = load i8*, i8** %l3
  %t272 = load double, double* %l4
  %t273 = load double, double* %l5
  %t274 = load double, double* %l6
  %t275 = load double, double* %l7
  %t276 = load i8, i8* %l8
  br i1 %t267, label %then30, label %merge31
then30:
  %t277 = load double, double* %l7
  %t278 = sitofp i64 0 to double
  %t279 = fcmp ogt double %t277, %t278
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load i8*, i8** %l1
  %t282 = load double, double* %l2
  %t283 = load i8*, i8** %l3
  %t284 = load double, double* %l4
  %t285 = load double, double* %l5
  %t286 = load double, double* %l6
  %t287 = load double, double* %l7
  %t288 = load i8, i8* %l8
  br i1 %t279, label %then32, label %merge33
then32:
  %t289 = load double, double* %l7
  %t290 = sitofp i64 1 to double
  %t291 = fsub double %t289, %t290
  store double %t291, double* %l7
  br label %merge33
merge33:
  %t292 = phi double [ %t291, %then32 ], [ %t287, %then30 ]
  store double %t292, double* %l7
  %t293 = load i8*, i8** %l1
  %t294 = load i8, i8* %l8
  %t295 = getelementptr i8, i8* %t293, i64 0
  %t296 = load i8, i8* %t295
  %t297 = add i8 %t296, %t294
  store i8* null, i8** %l1
  %t298 = load double, double* %l2
  %t299 = sitofp i64 1 to double
  %t300 = fadd double %t298, %t299
  store double %t300, double* %l2
  br label %loop.latch2
merge31:
  %t301 = load i8, i8* %l8
  %t302 = icmp eq i8 %t301, 44
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t304 = load i8*, i8** %l1
  %t305 = load double, double* %l2
  %t306 = load i8*, i8** %l3
  %t307 = load double, double* %l4
  %t308 = load double, double* %l5
  %t309 = load double, double* %l6
  %t310 = load double, double* %l7
  %t311 = load i8, i8* %l8
  br i1 %t302, label %then34, label %merge35
then34:
  %t315 = load double, double* %l4
  %t316 = sitofp i64 0 to double
  %t317 = fcmp oeq double %t315, %t316
  br label %logical_and_entry_314

logical_and_entry_314:
  br i1 %t317, label %logical_and_right_314, label %logical_and_merge_314

logical_and_right_314:
  %t318 = load double, double* %l5
  %t319 = sitofp i64 0 to double
  %t320 = fcmp oeq double %t318, %t319
  br label %logical_and_right_end_314

logical_and_right_end_314:
  br label %logical_and_merge_314

logical_and_merge_314:
  %t321 = phi i1 [ false, %logical_and_entry_314 ], [ %t320, %logical_and_right_end_314 ]
  br label %logical_and_entry_313

logical_and_entry_313:
  br i1 %t321, label %logical_and_right_313, label %logical_and_merge_313

logical_and_right_313:
  %t322 = load double, double* %l6
  %t323 = sitofp i64 0 to double
  %t324 = fcmp oeq double %t322, %t323
  br label %logical_and_right_end_313

logical_and_right_end_313:
  br label %logical_and_merge_313

logical_and_merge_313:
  %t325 = phi i1 [ false, %logical_and_entry_313 ], [ %t324, %logical_and_right_end_313 ]
  br label %logical_and_entry_312

logical_and_entry_312:
  br i1 %t325, label %logical_and_right_312, label %logical_and_merge_312

logical_and_right_312:
  %t326 = load double, double* %l7
  %t327 = sitofp i64 0 to double
  %t328 = fcmp oeq double %t326, %t327
  br label %logical_and_right_end_312

logical_and_right_end_312:
  br label %logical_and_merge_312

logical_and_merge_312:
  %t329 = phi i1 [ false, %logical_and_entry_312 ], [ %t328, %logical_and_right_end_312 ]
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t331 = load i8*, i8** %l1
  %t332 = load double, double* %l2
  %t333 = load i8*, i8** %l3
  %t334 = load double, double* %l4
  %t335 = load double, double* %l5
  %t336 = load double, double* %l6
  %t337 = load double, double* %l7
  %t338 = load i8, i8* %l8
  br i1 %t329, label %then36, label %merge37
then36:
  %t339 = load i8*, i8** %l1
  %t340 = call i8* @trim_text(i8* %t339)
  store i8* %t340, i8** %l9
  %t341 = load i8*, i8** %l9
  %t342 = call i64 @sailfin_runtime_string_length(i8* %t341)
  %t343 = icmp sgt i64 %t342, 0
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t345 = load i8*, i8** %l1
  %t346 = load double, double* %l2
  %t347 = load i8*, i8** %l3
  %t348 = load double, double* %l4
  %t349 = load double, double* %l5
  %t350 = load double, double* %l6
  %t351 = load double, double* %l7
  %t352 = load i8, i8* %l8
  %t353 = load i8*, i8** %l9
  br i1 %t343, label %then38, label %merge39
then38:
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t355 = load i8*, i8** %l9
  %t356 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t354, i8* %t355)
  store { i8**, i64 }* %t356, { i8**, i64 }** %l0
  br label %merge39
merge39:
  %t357 = phi { i8**, i64 }* [ %t356, %then38 ], [ %t344, %then36 ]
  store { i8**, i64 }* %t357, { i8**, i64 }** %l0
  %s358 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.358, i32 0, i32 0
  store i8* %s358, i8** %l1
  %t359 = load double, double* %l2
  %t360 = sitofp i64 1 to double
  %t361 = fadd double %t359, %t360
  store double %t361, double* %l2
  br label %loop.latch2
merge37:
  br label %merge35
merge35:
  %t362 = phi { i8**, i64 }* [ %t356, %then34 ], [ %t303, %loop.body1 ]
  %t363 = phi i8* [ %s358, %then34 ], [ %t304, %loop.body1 ]
  %t364 = phi double [ %t361, %then34 ], [ %t305, %loop.body1 ]
  store { i8**, i64 }* %t362, { i8**, i64 }** %l0
  store i8* %t363, i8** %l1
  store double %t364, double* %l2
  %t365 = load i8*, i8** %l1
  %t366 = load i8, i8* %l8
  %t367 = getelementptr i8, i8* %t365, i64 0
  %t368 = load i8, i8* %t367
  %t369 = add i8 %t368, %t366
  store i8* null, i8** %l1
  %t370 = load double, double* %l2
  %t371 = sitofp i64 1 to double
  %t372 = fadd double %t370, %t371
  store double %t372, double* %l2
  br label %loop.latch2
loop.latch2:
  %t373 = load i8*, i8** %l1
  %t374 = load double, double* %l2
  %t375 = load i8*, i8** %l3
  %t376 = load double, double* %l5
  %t377 = load double, double* %l6
  %t378 = load double, double* %l7
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t387 = load i8*, i8** %l1
  %t388 = call i8* @trim_text(i8* %t387)
  store i8* %t388, i8** %l10
  %t389 = load i8*, i8** %l10
  %t390 = call i64 @sailfin_runtime_string_length(i8* %t389)
  %t391 = icmp sgt i64 %t390, 0
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t393 = load i8*, i8** %l1
  %t394 = load double, double* %l2
  %t395 = load i8*, i8** %l3
  %t396 = load double, double* %l4
  %t397 = load double, double* %l5
  %t398 = load double, double* %l6
  %t399 = load double, double* %l7
  %t400 = load i8*, i8** %l10
  br i1 %t391, label %then40, label %merge41
then40:
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t402 = load i8*, i8** %l10
  %t403 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t401, i8* %t402)
  store { i8**, i64 }* %t403, { i8**, i64 }** %l0
  br label %merge41
merge41:
  %t404 = phi { i8**, i64 }* [ %t403, %then40 ], [ %t392, %entry ]
  store { i8**, i64 }* %t404, { i8**, i64 }** %l0
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t405
}

define double @find_matching_angle(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load double, double* %l1
  %t10 = fptosi double %t9 to i64
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t13 = load i8, i8* %l2
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = sitofp i64 -1 to double
  ret double %t19
}

define double @find_matching_paren(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t107 = phi double [ %t2, %entry ], [ %t105, %loop.latch2 ]
  %t108 = phi double [ %t1, %entry ], [ %t106, %loop.latch2 ]
  store double %t107, double* %l1
  store double %t108, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load double, double* %l1
  %t10 = fptosi double %t9 to i64
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = icmp eq i8 %t14, 34
  br label %logical_or_entry_13

logical_or_entry_13:
  br i1 %t15, label %logical_or_merge_13, label %logical_or_right_13

logical_or_right_13:
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 39
  br label %logical_or_right_end_13

logical_or_right_end_13:
  br label %logical_or_merge_13

logical_or_merge_13:
  %t18 = phi i1 [ true, %logical_or_entry_13 ], [ %t17, %logical_or_right_end_13 ]
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i8, i8* %l2
  br i1 %t18, label %then6, label %else7
then6:
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l3
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  %t28 = load double, double* %l3
  br label %loop.header9
loop.header9:
  %t66 = phi double [ %t28, %then6 ], [ %t64, %loop.latch11 ]
  %t67 = phi double [ %t26, %then6 ], [ %t65, %loop.latch11 ]
  store double %t66, double* %l3
  store double %t67, double* %l1
  br label %loop.body10
loop.body10:
  %t29 = load double, double* %l3
  %t30 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t29, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then13, label %merge14
then13:
  %t37 = sitofp i64 -1 to double
  ret double %t37
merge14:
  %t38 = load double, double* %l3
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %text, i64 %t39
  %t41 = load i8, i8* %t40
  store i8 %t41, i8* %l4
  %t42 = load i8, i8* %l4
  %t43 = icmp eq i8 %t42, 92
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  %t46 = load i8, i8* %l2
  %t47 = load double, double* %l3
  %t48 = load i8, i8* %l4
  br i1 %t43, label %then15, label %merge16
then15:
  %t49 = load double, double* %l3
  %t50 = sitofp i64 2 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  br label %loop.latch11
merge16:
  %t52 = load i8, i8* %l4
  %t53 = load i8, i8* %l2
  %t54 = icmp eq i8 %t52, %t53
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load i8, i8* %l2
  %t58 = load double, double* %l3
  %t59 = load i8, i8* %l4
  br i1 %t54, label %then17, label %merge18
then17:
  %t60 = load double, double* %l3
  store double %t60, double* %l1
  br label %afterloop12
merge18:
  %t61 = load double, double* %l3
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l3
  br label %loop.latch11
loop.latch11:
  %t64 = load double, double* %l3
  %t65 = load double, double* %l1
  br label %loop.header9
afterloop12:
  br label %merge8
else7:
  %t68 = load i8, i8* %l2
  %t69 = icmp eq i8 %t68, 40
  %t70 = load double, double* %l0
  %t71 = load double, double* %l1
  %t72 = load i8, i8* %l2
  br i1 %t69, label %then19, label %else20
then19:
  %t73 = load double, double* %l0
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l0
  br label %merge21
else20:
  %t76 = load i8, i8* %l2
  %t77 = icmp eq i8 %t76, 41
  %t78 = load double, double* %l0
  %t79 = load double, double* %l1
  %t80 = load i8, i8* %l2
  br i1 %t77, label %then22, label %merge23
then22:
  %t81 = load double, double* %l0
  %t82 = sitofp i64 0 to double
  %t83 = fcmp ogt double %t81, %t82
  %t84 = load double, double* %l0
  %t85 = load double, double* %l1
  %t86 = load i8, i8* %l2
  br i1 %t83, label %then24, label %else25
then24:
  %t87 = load double, double* %l0
  %t88 = sitofp i64 1 to double
  %t89 = fsub double %t87, %t88
  store double %t89, double* %l0
  %t90 = load double, double* %l0
  %t91 = sitofp i64 0 to double
  %t92 = fcmp oeq double %t90, %t91
  %t93 = load double, double* %l0
  %t94 = load double, double* %l1
  %t95 = load i8, i8* %l2
  br i1 %t92, label %then27, label %merge28
then27:
  %t96 = load double, double* %l1
  ret double %t96
merge28:
  br label %merge26
else25:
  %t97 = sitofp i64 -1 to double
  ret double %t97
merge26:
  br label %merge23
merge23:
  %t98 = phi double [ %t89, %then22 ], [ %t78, %else20 ]
  store double %t98, double* %l0
  br label %merge21
merge21:
  %t99 = phi double [ %t75, %then19 ], [ %t89, %else20 ]
  store double %t99, double* %l0
  br label %merge8
merge8:
  %t100 = phi double [ %t60, %then6 ], [ %t20, %else7 ]
  %t101 = phi double [ %t19, %then6 ], [ %t75, %else7 ]
  store double %t100, double* %l1
  store double %t101, double* %l0
  %t102 = load double, double* %l1
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l1
  br label %loop.latch2
loop.latch2:
  %t105 = load double, double* %l1
  %t106 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t109 = sitofp i64 -1 to double
  ret double %t109
}

define %EnumParseResult @parse_enum_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %NativeEnumVariant*, i64 }*
  %l6 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i1
  %l13 = alloca i1
  %l14 = alloca double
  %l15 = alloca i8*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %EnumLayoutHeaderParse
  %l19 = alloca %EnumLayoutVariantParse
  %l20 = alloca double
  %l21 = alloca %EnumLayoutPayloadParse
  %l22 = alloca double
  %l23 = alloca double
  %l24 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = fptosi double %start_index to i64
  %t6 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @trim_text(i8* %t11)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %s14 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %t13, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  store i8* %t17, i8** %l3
  %t18 = load i8*, i8** %l3
  %t19 = call double @index_of(i8* %t18, i8* null)
  store double %t19, double* %l4
  %t20 = load double, double* %l4
  %t21 = sitofp i64 0 to double
  %t22 = fcmp oge double %t20, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load i8*, i8** %l2
  %t26 = load i8*, i8** %l3
  %t27 = load double, double* %l4
  br i1 %t22, label %then0, label %merge1
then0:
  %t28 = load i8*, i8** %l3
  %t29 = load double, double* %l4
  %t30 = fptosi double %t29 to i64
  %t31 = call i8* @sailfin_runtime_substring(i8* %t28, i64 0, i64 %t30)
  %t32 = call i8* @trim_text(i8* %t31)
  store i8* %t32, i8** %l3
  br label %merge1
merge1:
  %t33 = phi i8* [ %t32, %then0 ], [ %t26, %entry ]
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i8* @strip_generics(i8* %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load i8*, i8** %l3
  %t43 = load double, double* %l4
  br i1 %t38, label %then2, label %merge3
then2:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s45 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.45, i32 0, i32 0
  %t46 = load i8*, i8** %l1
  %t47 = add i8* %s45, %t46
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t44, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  ret %EnumParseResult zeroinitializer
merge3:
  %t49 = alloca [0 x %NativeEnumVariant]
  %t50 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* %t49, i32 0, i32 0
  %t51 = alloca { %NativeEnumVariant*, i64 }
  %t52 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t51, i32 0, i32 0
  store %NativeEnumVariant* %t50, %NativeEnumVariant** %t52
  %t53 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t51, i32 0, i32 1
  store i64 0, i64* %t53
  store { %NativeEnumVariant*, i64 }* %t51, { %NativeEnumVariant*, i64 }** %l5
  %t54 = alloca [0 x %NativeEnumVariantLayout]
  %t55 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t54, i32 0, i32 0
  %t56 = alloca { %NativeEnumVariantLayout*, i64 }
  %t57 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t56, i32 0, i32 0
  store %NativeEnumVariantLayout* %t55, %NativeEnumVariantLayout** %t57
  %t58 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t56, i32 0, i32 1
  store i64 0, i64* %t58
  store { %NativeEnumVariantLayout*, i64 }* %t56, { %NativeEnumVariantLayout*, i64 }** %l6
  %t59 = sitofp i64 0 to double
  store double %t59, double* %l7
  %t60 = sitofp i64 0 to double
  store double %t60, double* %l8
  %s61 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.61, i32 0, i32 0
  store i8* %s61, i8** %l9
  %t62 = sitofp i64 0 to double
  store double %t62, double* %l10
  %t63 = sitofp i64 0 to double
  store double %t63, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %start_index, %t64
  store double %t65, double* %l14
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  %t70 = load double, double* %l4
  %t71 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t72 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t73 = load double, double* %l7
  %t74 = load double, double* %l8
  %t75 = load i8*, i8** %l9
  %t76 = load double, double* %l10
  %t77 = load double, double* %l11
  %t78 = load i1, i1* %l12
  %t79 = load i1, i1* %l13
  %t80 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t701 = phi { i8**, i64 }* [ %t66, %entry ], [ %t691, %loop.latch6 ]
  %t702 = phi double [ %t80, %entry ], [ %t692, %loop.latch6 ]
  %t703 = phi double [ %t73, %entry ], [ %t693, %loop.latch6 ]
  %t704 = phi double [ %t74, %entry ], [ %t694, %loop.latch6 ]
  %t705 = phi i8* [ %t75, %entry ], [ %t695, %loop.latch6 ]
  %t706 = phi double [ %t76, %entry ], [ %t696, %loop.latch6 ]
  %t707 = phi double [ %t77, %entry ], [ %t697, %loop.latch6 ]
  %t708 = phi i1 [ %t78, %entry ], [ %t698, %loop.latch6 ]
  %t709 = phi { %NativeEnumVariantLayout*, i64 }* [ %t72, %entry ], [ %t699, %loop.latch6 ]
  %t710 = phi i1 [ %t79, %entry ], [ %t700, %loop.latch6 ]
  store { i8**, i64 }* %t701, { i8**, i64 }** %l0
  store double %t702, double* %l14
  store double %t703, double* %l7
  store double %t704, double* %l8
  store i8* %t705, i8** %l9
  store double %t706, double* %l10
  store double %t707, double* %l11
  store i1 %t708, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t709, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t710, i1* %l13
  br label %loop.body5
loop.body5:
  %t81 = load double, double* %l14
  %t82 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t83 = extractvalue { i8**, i64 } %t82, 1
  %t84 = sitofp i64 %t83 to double
  %t85 = fcmp oge double %t81, %t84
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load i8*, i8** %l2
  %t89 = load i8*, i8** %l3
  %t90 = load double, double* %l4
  %t91 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t92 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t93 = load double, double* %l7
  %t94 = load double, double* %l8
  %t95 = load i8*, i8** %l9
  %t96 = load double, double* %l10
  %t97 = load double, double* %l11
  %t98 = load i1, i1* %l12
  %t99 = load i1, i1* %l13
  %t100 = load double, double* %l14
  br i1 %t85, label %then8, label %merge9
then8:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s102 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.102, i32 0, i32 0
  %t103 = load i8*, i8** %l3
  %t104 = add i8* %s102, %t103
  %t105 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t101, i8* %t104)
  store { i8**, i64 }* %t105, { i8**, i64 }** %l0
  store i8* null, i8** %l15
  %t106 = load i1, i1* %l12
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load i8*, i8** %l1
  %t109 = load i8*, i8** %l2
  %t110 = load i8*, i8** %l3
  %t111 = load double, double* %l4
  %t112 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t113 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t114 = load double, double* %l7
  %t115 = load double, double* %l8
  %t116 = load i8*, i8** %l9
  %t117 = load double, double* %l10
  %t118 = load double, double* %l11
  %t119 = load i1, i1* %l12
  %t120 = load i1, i1* %l13
  %t121 = load double, double* %l14
  %t122 = load i8*, i8** %l15
  br i1 %t106, label %then10, label %merge11
then10:
  %t123 = load double, double* %l7
  %t124 = insertvalue %NativeEnumLayout undef, double %t123, 0
  %t125 = load double, double* %l8
  %t126 = insertvalue %NativeEnumLayout %t124, double %t125, 1
  %t127 = load i8*, i8** %l9
  %t128 = insertvalue %NativeEnumLayout %t126, i8* %t127, 2
  %t129 = load double, double* %l10
  %t130 = insertvalue %NativeEnumLayout %t128, double %t129, 3
  %t131 = load double, double* %l11
  %t132 = insertvalue %NativeEnumLayout %t130, double %t131, 4
  %t133 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t134 = bitcast { %NativeEnumVariantLayout*, i64 }* %t133 to { i8**, i64 }*
  %t135 = insertvalue %NativeEnumLayout %t132, { i8**, i64 }* %t134, 5
  store i8* null, i8** %l15
  br label %merge11
merge11:
  %t136 = phi i8* [ null, %then10 ], [ %t122, %then8 ]
  store i8* %t136, i8** %l15
  %t137 = load i8*, i8** %l3
  %t138 = insertvalue %NativeEnum undef, i8* %t137, 0
  %t139 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t140 = bitcast { %NativeEnumVariant*, i64 }* %t139 to { i8**, i64 }*
  %t141 = insertvalue %NativeEnum %t138, { i8**, i64 }* %t140, 1
  %t142 = load i8*, i8** %l15
  %t143 = insertvalue %NativeEnum %t141, i8* %t142, 2
  %t144 = insertvalue %EnumParseResult undef, i8* null, 0
  %t145 = load double, double* %l14
  %t146 = insertvalue %EnumParseResult %t144, double %t145, 1
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = insertvalue %EnumParseResult %t146, { i8**, i64 }* %t147, 2
  ret %EnumParseResult %t148
merge9:
  %t149 = load double, double* %l14
  %t150 = fptosi double %t149 to i64
  %t151 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t152 = extractvalue { i8**, i64 } %t151, 0
  %t153 = extractvalue { i8**, i64 } %t151, 1
  %t154 = icmp uge i64 %t150, %t153
  ; bounds check: %t154 (if true, out of bounds)
  %t155 = getelementptr i8*, i8** %t152, i64 %t150
  %t156 = load i8*, i8** %t155
  %t157 = call i8* @trim_text(i8* %t156)
  store i8* %t157, i8** %l16
  %t159 = load i8*, i8** %l16
  %t160 = call i64 @sailfin_runtime_string_length(i8* %t159)
  %t161 = icmp eq i64 %t160, 0
  br label %logical_or_entry_158

logical_or_entry_158:
  br i1 %t161, label %logical_or_merge_158, label %logical_or_right_158

logical_or_right_158:
  %t162 = load i8*, i8** %l16
  %t163 = call i1 @starts_with(i8* %t162, i8* null)
  br label %logical_or_right_end_158

logical_or_right_end_158:
  br label %logical_or_merge_158

logical_or_merge_158:
  %t164 = phi i1 [ true, %logical_or_entry_158 ], [ %t163, %logical_or_right_end_158 ]
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load i8*, i8** %l2
  %t168 = load i8*, i8** %l3
  %t169 = load double, double* %l4
  %t170 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t171 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t172 = load double, double* %l7
  %t173 = load double, double* %l8
  %t174 = load i8*, i8** %l9
  %t175 = load double, double* %l10
  %t176 = load double, double* %l11
  %t177 = load i1, i1* %l12
  %t178 = load i1, i1* %l13
  %t179 = load double, double* %l14
  %t180 = load i8*, i8** %l16
  br i1 %t164, label %then12, label %merge13
then12:
  %t181 = load double, double* %l14
  %t182 = sitofp i64 1 to double
  %t183 = fadd double %t181, %t182
  store double %t183, double* %l14
  br label %loop.latch6
merge13:
  %t184 = load i8*, i8** %l16
  %s185 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.185, i32 0, i32 0
  %t186 = icmp eq i8* %t184, %s185
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t188 = load i8*, i8** %l1
  %t189 = load i8*, i8** %l2
  %t190 = load i8*, i8** %l3
  %t191 = load double, double* %l4
  %t192 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t193 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t194 = load double, double* %l7
  %t195 = load double, double* %l8
  %t196 = load i8*, i8** %l9
  %t197 = load double, double* %l10
  %t198 = load double, double* %l11
  %t199 = load i1, i1* %l12
  %t200 = load i1, i1* %l13
  %t201 = load double, double* %l14
  %t202 = load i8*, i8** %l16
  br i1 %t186, label %then14, label %merge15
then14:
  %t203 = load double, double* %l14
  %t204 = sitofp i64 1 to double
  %t205 = fadd double %t203, %t204
  store double %t205, double* %l14
  br label %loop.latch6
merge15:
  %t206 = load i8*, i8** %l16
  %s207 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.207, i32 0, i32 0
  %t208 = call i1 @starts_with(i8* %t206, i8* %s207)
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t210 = load i8*, i8** %l1
  %t211 = load i8*, i8** %l2
  %t212 = load i8*, i8** %l3
  %t213 = load double, double* %l4
  %t214 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t215 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t216 = load double, double* %l7
  %t217 = load double, double* %l8
  %t218 = load i8*, i8** %l9
  %t219 = load double, double* %l10
  %t220 = load double, double* %l11
  %t221 = load i1, i1* %l12
  %t222 = load i1, i1* %l13
  %t223 = load double, double* %l14
  %t224 = load i8*, i8** %l16
  br i1 %t208, label %then16, label %merge17
then16:
  %t225 = load i8*, i8** %l16
  %s226 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.226, i32 0, i32 0
  %t227 = call i8* @strip_prefix(i8* %t225, i8* %s226)
  store i8* %t227, i8** %l17
  %t228 = load i8*, i8** %l17
  %s229 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.229, i32 0, i32 0
  %t230 = call i1 @starts_with(i8* %t228, i8* %s229)
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = load i8*, i8** %l2
  %t234 = load i8*, i8** %l3
  %t235 = load double, double* %l4
  %t236 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t237 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t238 = load double, double* %l7
  %t239 = load double, double* %l8
  %t240 = load i8*, i8** %l9
  %t241 = load double, double* %l10
  %t242 = load double, double* %l11
  %t243 = load i1, i1* %l12
  %t244 = load i1, i1* %l13
  %t245 = load double, double* %l14
  %t246 = load i8*, i8** %l16
  %t247 = load i8*, i8** %l17
  br i1 %t230, label %then18, label %merge19
then18:
  %t248 = load i8*, i8** %l17
  %s249 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.249, i32 0, i32 0
  %t250 = call i8* @strip_prefix(i8* %t248, i8* %s249)
  %t251 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t250)
  store %EnumLayoutHeaderParse %t251, %EnumLayoutHeaderParse* %l18
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t253 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t254 = extractvalue %EnumLayoutHeaderParse %t253, 7
  %t255 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t252, { i8**, i64 }* %t254)
  store { i8**, i64 }* %t255, { i8**, i64 }** %l0
  %t256 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t257 = extractvalue %EnumLayoutHeaderParse %t256, 0
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load i8*, i8** %l1
  %t260 = load i8*, i8** %l2
  %t261 = load i8*, i8** %l3
  %t262 = load double, double* %l4
  %t263 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t264 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t265 = load double, double* %l7
  %t266 = load double, double* %l8
  %t267 = load i8*, i8** %l9
  %t268 = load double, double* %l10
  %t269 = load double, double* %l11
  %t270 = load i1, i1* %l12
  %t271 = load i1, i1* %l13
  %t272 = load double, double* %l14
  %t273 = load i8*, i8** %l16
  %t274 = load i8*, i8** %l17
  %t275 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t257, label %then20, label %merge21
then20:
  %t276 = load i1, i1* %l12
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load i8*, i8** %l1
  %t279 = load i8*, i8** %l2
  %t280 = load i8*, i8** %l3
  %t281 = load double, double* %l4
  %t282 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t283 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t284 = load double, double* %l7
  %t285 = load double, double* %l8
  %t286 = load i8*, i8** %l9
  %t287 = load double, double* %l10
  %t288 = load double, double* %l11
  %t289 = load i1, i1* %l12
  %t290 = load i1, i1* %l13
  %t291 = load double, double* %l14
  %t292 = load i8*, i8** %l16
  %t293 = load i8*, i8** %l17
  %t294 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t276, label %then22, label %else23
then22:
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s296 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.296, i32 0, i32 0
  %t297 = load i8*, i8** %l3
  %t298 = add i8* %s296, %t297
  %t299 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t295, i8* %t298)
  store { i8**, i64 }* %t299, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t300 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t301 = extractvalue %EnumLayoutHeaderParse %t300, 2
  store double %t301, double* %l7
  %t302 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t303 = extractvalue %EnumLayoutHeaderParse %t302, 3
  store double %t303, double* %l8
  %t304 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t305 = extractvalue %EnumLayoutHeaderParse %t304, 4
  store i8* %t305, i8** %l9
  %t306 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t307 = extractvalue %EnumLayoutHeaderParse %t306, 5
  store double %t307, double* %l10
  %t308 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t309 = extractvalue %EnumLayoutHeaderParse %t308, 6
  store double %t309, double* %l11
  store i1 1, i1* %l12
  br label %merge24
merge24:
  %t310 = phi { i8**, i64 }* [ %t299, %then22 ], [ %t277, %else23 ]
  %t311 = phi double [ %t284, %then22 ], [ %t301, %else23 ]
  %t312 = phi double [ %t285, %then22 ], [ %t303, %else23 ]
  %t313 = phi i8* [ %t286, %then22 ], [ %t305, %else23 ]
  %t314 = phi double [ %t287, %then22 ], [ %t307, %else23 ]
  %t315 = phi double [ %t288, %then22 ], [ %t309, %else23 ]
  %t316 = phi i1 [ %t289, %then22 ], [ 1, %else23 ]
  store { i8**, i64 }* %t310, { i8**, i64 }** %l0
  store double %t311, double* %l7
  store double %t312, double* %l8
  store i8* %t313, i8** %l9
  store double %t314, double* %l10
  store double %t315, double* %l11
  store i1 %t316, i1* %l12
  br label %merge21
merge21:
  %t317 = phi { i8**, i64 }* [ %t299, %then20 ], [ %t258, %then18 ]
  %t318 = phi double [ %t301, %then20 ], [ %t265, %then18 ]
  %t319 = phi double [ %t303, %then20 ], [ %t266, %then18 ]
  %t320 = phi i8* [ %t305, %then20 ], [ %t267, %then18 ]
  %t321 = phi double [ %t307, %then20 ], [ %t268, %then18 ]
  %t322 = phi double [ %t309, %then20 ], [ %t269, %then18 ]
  %t323 = phi i1 [ 1, %then20 ], [ %t270, %then18 ]
  store { i8**, i64 }* %t317, { i8**, i64 }** %l0
  store double %t318, double* %l7
  store double %t319, double* %l8
  store i8* %t320, i8** %l9
  store double %t321, double* %l10
  store double %t322, double* %l11
  store i1 %t323, i1* %l12
  %t324 = load double, double* %l14
  %t325 = sitofp i64 1 to double
  %t326 = fadd double %t324, %t325
  store double %t326, double* %l14
  br label %loop.latch6
merge19:
  %t327 = load i8*, i8** %l17
  %s328 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.328, i32 0, i32 0
  %t329 = call i1 @starts_with(i8* %t327, i8* %s328)
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t331 = load i8*, i8** %l1
  %t332 = load i8*, i8** %l2
  %t333 = load i8*, i8** %l3
  %t334 = load double, double* %l4
  %t335 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t336 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t337 = load double, double* %l7
  %t338 = load double, double* %l8
  %t339 = load i8*, i8** %l9
  %t340 = load double, double* %l10
  %t341 = load double, double* %l11
  %t342 = load i1, i1* %l12
  %t343 = load i1, i1* %l13
  %t344 = load double, double* %l14
  %t345 = load i8*, i8** %l16
  %t346 = load i8*, i8** %l17
  br i1 %t329, label %then25, label %merge26
then25:
  %t347 = load i8*, i8** %l17
  %s348 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.348, i32 0, i32 0
  %t349 = call i8* @strip_prefix(i8* %t347, i8* %s348)
  %t350 = load i8*, i8** %l3
  %t351 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t349, i8* %t350)
  store %EnumLayoutVariantParse %t351, %EnumLayoutVariantParse* %l19
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t353 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t354 = extractvalue %EnumLayoutVariantParse %t353, 2
  %t355 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t352, { i8**, i64 }* %t354)
  store { i8**, i64 }* %t355, { i8**, i64 }** %l0
  %t356 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t357 = extractvalue %EnumLayoutVariantParse %t356, 0
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t359 = load i8*, i8** %l1
  %t360 = load i8*, i8** %l2
  %t361 = load i8*, i8** %l3
  %t362 = load double, double* %l4
  %t363 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t364 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t365 = load double, double* %l7
  %t366 = load double, double* %l8
  %t367 = load i8*, i8** %l9
  %t368 = load double, double* %l10
  %t369 = load double, double* %l11
  %t370 = load i1, i1* %l12
  %t371 = load i1, i1* %l13
  %t372 = load double, double* %l14
  %t373 = load i8*, i8** %l16
  %t374 = load i8*, i8** %l17
  %t375 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t357, label %then27, label %merge28
then27:
  %t376 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t377 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t378 = extractvalue %EnumLayoutVariantParse %t377, 1
  store double 0.0, double* %l20
  %t379 = load double, double* %l20
  %t380 = sitofp i64 0 to double
  %t381 = fcmp oge double %t379, %t380
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t383 = load i8*, i8** %l1
  %t384 = load i8*, i8** %l2
  %t385 = load i8*, i8** %l3
  %t386 = load double, double* %l4
  %t387 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t388 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t389 = load double, double* %l7
  %t390 = load double, double* %l8
  %t391 = load i8*, i8** %l9
  %t392 = load double, double* %l10
  %t393 = load double, double* %l11
  %t394 = load i1, i1* %l12
  %t395 = load i1, i1* %l13
  %t396 = load double, double* %l14
  %t397 = load i8*, i8** %l16
  %t398 = load i8*, i8** %l17
  %t399 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t400 = load double, double* %l20
  br i1 %t381, label %then29, label %else30
then29:
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s402 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.402, i32 0, i32 0
  %t403 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t404 = extractvalue %EnumLayoutVariantParse %t403, 1
  br label %merge31
else30:
  %t405 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t406 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t407 = extractvalue %EnumLayoutVariantParse %t406, 1
  %t408 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t405, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t408, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t409 = phi { i8**, i64 }* [ null, %then29 ], [ %t382, %else30 ]
  %t410 = phi { %NativeEnumVariantLayout*, i64 }* [ %t388, %then29 ], [ %t408, %else30 ]
  store { i8**, i64 }* %t409, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t410, { %NativeEnumVariantLayout*, i64 }** %l6
  %t411 = load i1, i1* %l12
  %t412 = xor i1 %t411, 1
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t414 = load i8*, i8** %l1
  %t415 = load i8*, i8** %l2
  %t416 = load i8*, i8** %l3
  %t417 = load double, double* %l4
  %t418 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t419 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t420 = load double, double* %l7
  %t421 = load double, double* %l8
  %t422 = load i8*, i8** %l9
  %t423 = load double, double* %l10
  %t424 = load double, double* %l11
  %t425 = load i1, i1* %l12
  %t426 = load i1, i1* %l13
  %t427 = load double, double* %l14
  %t428 = load i8*, i8** %l16
  %t429 = load i8*, i8** %l17
  %t430 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t431 = load double, double* %l20
  br i1 %t412, label %then32, label %merge33
then32:
  %t432 = load i1, i1* %l13
  %t433 = xor i1 %t432, 1
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t435 = load i8*, i8** %l1
  %t436 = load i8*, i8** %l2
  %t437 = load i8*, i8** %l3
  %t438 = load double, double* %l4
  %t439 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t440 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t441 = load double, double* %l7
  %t442 = load double, double* %l8
  %t443 = load i8*, i8** %l9
  %t444 = load double, double* %l10
  %t445 = load double, double* %l11
  %t446 = load i1, i1* %l12
  %t447 = load i1, i1* %l13
  %t448 = load double, double* %l14
  %t449 = load i8*, i8** %l16
  %t450 = load i8*, i8** %l17
  %t451 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t452 = load double, double* %l20
  br i1 %t433, label %then34, label %merge35
then34:
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s454 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.454, i32 0, i32 0
  %t455 = load i8*, i8** %l3
  %t456 = add i8* %s454, %t455
  %s457 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.457, i32 0, i32 0
  %t458 = add i8* %t456, %s457
  %t459 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t453, i8* %t458)
  store { i8**, i64 }* %t459, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge35
merge35:
  %t460 = phi { i8**, i64 }* [ %t459, %then34 ], [ %t434, %then32 ]
  %t461 = phi i1 [ 1, %then34 ], [ %t447, %then32 ]
  store { i8**, i64 }* %t460, { i8**, i64 }** %l0
  store i1 %t461, i1* %l13
  br label %merge33
merge33:
  %t462 = phi { i8**, i64 }* [ %t459, %then32 ], [ %t413, %then27 ]
  %t463 = phi i1 [ 1, %then32 ], [ %t426, %then27 ]
  store { i8**, i64 }* %t462, { i8**, i64 }** %l0
  store i1 %t463, i1* %l13
  br label %merge28
merge28:
  %t464 = phi { i8**, i64 }* [ null, %then27 ], [ %t358, %then25 ]
  %t465 = phi { %NativeEnumVariantLayout*, i64 }* [ %t408, %then27 ], [ %t364, %then25 ]
  %t466 = phi { i8**, i64 }* [ %t459, %then27 ], [ %t358, %then25 ]
  %t467 = phi i1 [ 1, %then27 ], [ %t371, %then25 ]
  store { i8**, i64 }* %t464, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t465, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t466, { i8**, i64 }** %l0
  store i1 %t467, i1* %l13
  %t468 = load double, double* %l14
  %t469 = sitofp i64 1 to double
  %t470 = fadd double %t468, %t469
  store double %t470, double* %l14
  br label %loop.latch6
merge26:
  %t471 = load i8*, i8** %l17
  %s472 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.472, i32 0, i32 0
  %t473 = call i1 @starts_with(i8* %t471, i8* %s472)
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t475 = load i8*, i8** %l1
  %t476 = load i8*, i8** %l2
  %t477 = load i8*, i8** %l3
  %t478 = load double, double* %l4
  %t479 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t480 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t481 = load double, double* %l7
  %t482 = load double, double* %l8
  %t483 = load i8*, i8** %l9
  %t484 = load double, double* %l10
  %t485 = load double, double* %l11
  %t486 = load i1, i1* %l12
  %t487 = load i1, i1* %l13
  %t488 = load double, double* %l14
  %t489 = load i8*, i8** %l16
  %t490 = load i8*, i8** %l17
  br i1 %t473, label %then36, label %merge37
then36:
  %t491 = load i8*, i8** %l17
  %s492 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.492, i32 0, i32 0
  %t493 = call i8* @strip_prefix(i8* %t491, i8* %s492)
  %t494 = load i8*, i8** %l3
  %t495 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t493, i8* %t494)
  store %EnumLayoutPayloadParse %t495, %EnumLayoutPayloadParse* %l21
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t497 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t498 = extractvalue %EnumLayoutPayloadParse %t497, 3
  %t499 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t496, { i8**, i64 }* %t498)
  store { i8**, i64 }* %t499, { i8**, i64 }** %l0
  %t500 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t501 = extractvalue %EnumLayoutPayloadParse %t500, 0
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t503 = load i8*, i8** %l1
  %t504 = load i8*, i8** %l2
  %t505 = load i8*, i8** %l3
  %t506 = load double, double* %l4
  %t507 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t508 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t509 = load double, double* %l7
  %t510 = load double, double* %l8
  %t511 = load i8*, i8** %l9
  %t512 = load double, double* %l10
  %t513 = load double, double* %l11
  %t514 = load i1, i1* %l12
  %t515 = load i1, i1* %l13
  %t516 = load double, double* %l14
  %t517 = load i8*, i8** %l16
  %t518 = load i8*, i8** %l17
  %t519 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t501, label %then38, label %merge39
then38:
  %t520 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t521 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t522 = extractvalue %EnumLayoutPayloadParse %t521, 1
  %t523 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t520, i8* %t522)
  store double %t523, double* %l22
  %t524 = load double, double* %l22
  %t525 = sitofp i64 0 to double
  %t526 = fcmp olt double %t524, %t525
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t528 = load i8*, i8** %l1
  %t529 = load i8*, i8** %l2
  %t530 = load i8*, i8** %l3
  %t531 = load double, double* %l4
  %t532 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t533 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t534 = load double, double* %l7
  %t535 = load double, double* %l8
  %t536 = load i8*, i8** %l9
  %t537 = load double, double* %l10
  %t538 = load double, double* %l11
  %t539 = load i1, i1* %l12
  %t540 = load i1, i1* %l13
  %t541 = load double, double* %l14
  %t542 = load i8*, i8** %l16
  %t543 = load i8*, i8** %l17
  %t544 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t545 = load double, double* %l22
  br i1 %t526, label %then40, label %else41
then40:
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s547 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.547, i32 0, i32 0
  %t548 = load i8*, i8** %l3
  %t549 = add i8* %s547, %t548
  %s550 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.550, i32 0, i32 0
  %t551 = add i8* %t549, %s550
  %t552 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t553 = extractvalue %EnumLayoutPayloadParse %t552, 1
  %t554 = add i8* %t551, %t553
  %t555 = getelementptr i8, i8* %t554, i64 0
  %t556 = load i8, i8* %t555
  %t557 = add i8 %t556, 96
  %t558 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t546, i8* null)
  store { i8**, i64 }* %t558, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t559 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t560 = load double, double* %l22
  %t561 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t562 = extractvalue %EnumLayoutPayloadParse %t561, 2
  %t563 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t559, double %t560, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t563, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t564 = phi { i8**, i64 }* [ %t558, %then40 ], [ %t527, %else41 ]
  %t565 = phi { %NativeEnumVariantLayout*, i64 }* [ %t533, %then40 ], [ %t563, %else41 ]
  store { i8**, i64 }* %t564, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t565, { %NativeEnumVariantLayout*, i64 }** %l6
  %t566 = load i1, i1* %l12
  %t567 = xor i1 %t566, 1
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t569 = load i8*, i8** %l1
  %t570 = load i8*, i8** %l2
  %t571 = load i8*, i8** %l3
  %t572 = load double, double* %l4
  %t573 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t574 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t575 = load double, double* %l7
  %t576 = load double, double* %l8
  %t577 = load i8*, i8** %l9
  %t578 = load double, double* %l10
  %t579 = load double, double* %l11
  %t580 = load i1, i1* %l12
  %t581 = load i1, i1* %l13
  %t582 = load double, double* %l14
  %t583 = load i8*, i8** %l16
  %t584 = load i8*, i8** %l17
  %t585 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t586 = load double, double* %l22
  br i1 %t567, label %then43, label %merge44
then43:
  %t587 = load i1, i1* %l13
  %t588 = xor i1 %t587, 1
  %t589 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t590 = load i8*, i8** %l1
  %t591 = load i8*, i8** %l2
  %t592 = load i8*, i8** %l3
  %t593 = load double, double* %l4
  %t594 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t595 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t596 = load double, double* %l7
  %t597 = load double, double* %l8
  %t598 = load i8*, i8** %l9
  %t599 = load double, double* %l10
  %t600 = load double, double* %l11
  %t601 = load i1, i1* %l12
  %t602 = load i1, i1* %l13
  %t603 = load double, double* %l14
  %t604 = load i8*, i8** %l16
  %t605 = load i8*, i8** %l17
  %t606 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t607 = load double, double* %l22
  br i1 %t588, label %then45, label %merge46
then45:
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s609 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.609, i32 0, i32 0
  %t610 = load i8*, i8** %l3
  %t611 = add i8* %s609, %t610
  %s612 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.612, i32 0, i32 0
  %t613 = add i8* %t611, %s612
  %t614 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t608, i8* %t613)
  store { i8**, i64 }* %t614, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge46
merge46:
  %t615 = phi { i8**, i64 }* [ %t614, %then45 ], [ %t589, %then43 ]
  %t616 = phi i1 [ 1, %then45 ], [ %t602, %then43 ]
  store { i8**, i64 }* %t615, { i8**, i64 }** %l0
  store i1 %t616, i1* %l13
  br label %merge44
merge44:
  %t617 = phi { i8**, i64 }* [ %t614, %then43 ], [ %t568, %then38 ]
  %t618 = phi i1 [ 1, %then43 ], [ %t581, %then38 ]
  store { i8**, i64 }* %t617, { i8**, i64 }** %l0
  store i1 %t618, i1* %l13
  br label %merge39
merge39:
  %t619 = phi { i8**, i64 }* [ %t558, %then38 ], [ %t502, %then36 ]
  %t620 = phi { %NativeEnumVariantLayout*, i64 }* [ %t563, %then38 ], [ %t508, %then36 ]
  %t621 = phi { i8**, i64 }* [ %t614, %then38 ], [ %t502, %then36 ]
  %t622 = phi i1 [ 1, %then38 ], [ %t515, %then36 ]
  store { i8**, i64 }* %t619, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t620, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t621, { i8**, i64 }** %l0
  store i1 %t622, i1* %l13
  %t623 = load double, double* %l14
  %t624 = sitofp i64 1 to double
  %t625 = fadd double %t623, %t624
  store double %t625, double* %l14
  br label %loop.latch6
merge37:
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s627 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.627, i32 0, i32 0
  %t628 = load i8*, i8** %l16
  %t629 = add i8* %s627, %t628
  %t630 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t626, i8* %t629)
  store { i8**, i64 }* %t630, { i8**, i64 }** %l0
  %t631 = load double, double* %l14
  %t632 = sitofp i64 1 to double
  %t633 = fadd double %t631, %t632
  store double %t633, double* %l14
  br label %loop.latch6
merge17:
  %t634 = load i8*, i8** %l16
  %s635 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.635, i32 0, i32 0
  %t636 = icmp eq i8* %t634, %s635
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t638 = load i8*, i8** %l1
  %t639 = load i8*, i8** %l2
  %t640 = load i8*, i8** %l3
  %t641 = load double, double* %l4
  %t642 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t643 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t644 = load double, double* %l7
  %t645 = load double, double* %l8
  %t646 = load i8*, i8** %l9
  %t647 = load double, double* %l10
  %t648 = load double, double* %l11
  %t649 = load i1, i1* %l12
  %t650 = load i1, i1* %l13
  %t651 = load double, double* %l14
  %t652 = load i8*, i8** %l16
  br i1 %t636, label %then47, label %merge48
then47:
  %t653 = load double, double* %l14
  %t654 = sitofp i64 1 to double
  %t655 = fadd double %t653, %t654
  store double %t655, double* %l14
  br label %afterloop7
merge48:
  %t656 = load i8*, i8** %l16
  %s657 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.657, i32 0, i32 0
  %t658 = call i1 @starts_with(i8* %t656, i8* %s657)
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t660 = load i8*, i8** %l1
  %t661 = load i8*, i8** %l2
  %t662 = load i8*, i8** %l3
  %t663 = load double, double* %l4
  %t664 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t665 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t666 = load double, double* %l7
  %t667 = load double, double* %l8
  %t668 = load i8*, i8** %l9
  %t669 = load double, double* %l10
  %t670 = load double, double* %l11
  %t671 = load i1, i1* %l12
  %t672 = load i1, i1* %l13
  %t673 = load double, double* %l14
  %t674 = load i8*, i8** %l16
  br i1 %t658, label %then49, label %merge50
then49:
  %t675 = load i8*, i8** %l16
  %s676 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.676, i32 0, i32 0
  %t677 = call i8* @strip_prefix(i8* %t675, i8* %s676)
  %t678 = call double @parse_enum_variant_line(i8* %t677)
  store double %t678, double* %l23
  %t679 = load double, double* %l23
  %t680 = load double, double* %l14
  %t681 = sitofp i64 1 to double
  %t682 = fadd double %t680, %t681
  store double %t682, double* %l14
  br label %loop.latch6
merge50:
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s684 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.684, i32 0, i32 0
  %t685 = load i8*, i8** %l16
  %t686 = add i8* %s684, %t685
  %t687 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t683, i8* %t686)
  store { i8**, i64 }* %t687, { i8**, i64 }** %l0
  %t688 = load double, double* %l14
  %t689 = sitofp i64 1 to double
  %t690 = fadd double %t688, %t689
  store double %t690, double* %l14
  br label %loop.latch6
loop.latch6:
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t692 = load double, double* %l14
  %t693 = load double, double* %l7
  %t694 = load double, double* %l8
  %t695 = load i8*, i8** %l9
  %t696 = load double, double* %l10
  %t697 = load double, double* %l11
  %t698 = load i1, i1* %l12
  %t699 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t700 = load i1, i1* %l13
  br label %loop.header4
afterloop7:
  store i8* null, i8** %l24
  %t711 = load i1, i1* %l12
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t713 = load i8*, i8** %l1
  %t714 = load i8*, i8** %l2
  %t715 = load i8*, i8** %l3
  %t716 = load double, double* %l4
  %t717 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t718 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t719 = load double, double* %l7
  %t720 = load double, double* %l8
  %t721 = load i8*, i8** %l9
  %t722 = load double, double* %l10
  %t723 = load double, double* %l11
  %t724 = load i1, i1* %l12
  %t725 = load i1, i1* %l13
  %t726 = load double, double* %l14
  %t727 = load i8*, i8** %l24
  br i1 %t711, label %then51, label %merge52
then51:
  %t728 = load double, double* %l7
  %t729 = insertvalue %NativeEnumLayout undef, double %t728, 0
  %t730 = load double, double* %l8
  %t731 = insertvalue %NativeEnumLayout %t729, double %t730, 1
  %t732 = load i8*, i8** %l9
  %t733 = insertvalue %NativeEnumLayout %t731, i8* %t732, 2
  %t734 = load double, double* %l10
  %t735 = insertvalue %NativeEnumLayout %t733, double %t734, 3
  %t736 = load double, double* %l11
  %t737 = insertvalue %NativeEnumLayout %t735, double %t736, 4
  %t738 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t739 = bitcast { %NativeEnumVariantLayout*, i64 }* %t738 to { i8**, i64 }*
  %t740 = insertvalue %NativeEnumLayout %t737, { i8**, i64 }* %t739, 5
  store i8* null, i8** %l24
  br label %merge52
merge52:
  %t741 = phi i8* [ null, %then51 ], [ %t727, %entry ]
  store i8* %t741, i8** %l24
  %t742 = load i8*, i8** %l3
  %t743 = insertvalue %NativeEnum undef, i8* %t742, 0
  %t744 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t745 = bitcast { %NativeEnumVariant*, i64 }* %t744 to { i8**, i64 }*
  %t746 = insertvalue %NativeEnum %t743, { i8**, i64 }* %t745, 1
  %t747 = load i8*, i8** %l24
  %t748 = insertvalue %NativeEnum %t746, i8* %t747, 2
  %t749 = insertvalue %EnumParseResult undef, i8* null, 0
  %t750 = load double, double* %l14
  %t751 = insertvalue %EnumParseResult %t749, double %t750, 1
  %t752 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t753 = insertvalue %EnumParseResult %t751, { i8**, i64 }* %t752, 2
  ret %EnumParseResult %t753
}

define { i8**, i64 }* @split_enum_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t75 = phi double [ %t10, %entry ], [ %t71, %loop.latch2 ]
  %t76 = phi { i8**, i64 }* [ %t8, %entry ], [ %t72, %loop.latch2 ]
  %t77 = phi i8* [ %t9, %entry ], [ %t73, %loop.latch2 ]
  %t78 = phi double [ %t11, %entry ], [ %t74, %loop.latch2 ]
  store double %t75, double* %l2
  store { i8**, i64 }* %t76, { i8**, i64 }** %l0
  store i8* %t77, i8** %l1
  store double %t78, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t12, %t14
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l3
  %t21 = fptosi double %t20 to i64
  %t22 = getelementptr i8, i8* %text, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l4
  %t26 = load i8, i8* %l4
  %t27 = icmp eq i8 %t26, 123
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t27, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t28 = load i8, i8* %l4
  %t29 = icmp eq i8 %t28, 91
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t30 = phi i1 [ true, %logical_or_entry_25 ], [ %t29, %logical_or_right_end_25 ]
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t30, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t31 = load i8, i8* %l4
  %t32 = icmp eq i8 %t31, 40
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t33 = phi i1 [ true, %logical_or_entry_24 ], [ %t32, %logical_or_right_end_24 ]
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i8, i8* %l4
  br i1 %t33, label %then6, label %else7
then6:
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l2
  br label %merge8
else7:
  %t42 = load i8, i8* %l4
  br label %merge8
merge8:
  %t44 = phi double [ %t41, %then6 ], [ %t36, %else7 ]
  store double %t44, double* %l2
  %t46 = load i8, i8* %l4
  %t47 = icmp eq i8 %t46, 59
  br label %logical_and_entry_45

logical_and_entry_45:
  br i1 %t47, label %logical_and_right_45, label %logical_and_merge_45

logical_and_right_45:
  %t48 = load double, double* %l2
  %t49 = sitofp i64 0 to double
  %t50 = fcmp oeq double %t48, %t49
  br label %logical_and_right_end_45

logical_and_right_end_45:
  br label %logical_and_merge_45

logical_and_merge_45:
  %t51 = phi i1 [ false, %logical_and_entry_45 ], [ %t50, %logical_and_right_end_45 ]
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load i8, i8* %l4
  br i1 %t51, label %then9, label %else10
then9:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load i8*, i8** %l1
  %t59 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  %s60 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.60, i32 0, i32 0
  store i8* %s60, i8** %l1
  br label %merge11
else10:
  %t61 = load i8*, i8** %l1
  %t62 = load i8, i8* %l4
  %t63 = getelementptr i8, i8* %t61, i64 0
  %t64 = load i8, i8* %t63
  %t65 = add i8 %t64, %t62
  store i8* null, i8** %l1
  br label %merge11
merge11:
  %t66 = phi { i8**, i64 }* [ %t59, %then9 ], [ %t52, %else10 ]
  %t67 = phi i8* [ %s60, %then9 ], [ null, %else10 ]
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  store i8* %t67, i8** %l1
  %t68 = load double, double* %l3
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l3
  br label %loop.latch2
loop.latch2:
  %t71 = load double, double* %l2
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load i8*, i8** %l1
  %t74 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t79 = load i8*, i8** %l1
  %t80 = call i64 @sailfin_runtime_string_length(i8* %t79)
  %t81 = icmp sgt i64 %t80, 0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  br i1 %t81, label %then12, label %merge13
then12:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load i8*, i8** %l1
  %t88 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t86, i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  br label %merge13
merge13:
  %t89 = phi { i8**, i64 }* [ %t88, %then12 ], [ %t82, %entry ]
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t90
}

define i8* @trim_trailing_delimiters(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = sitofp i64 0 to double
  %t5 = fcmp ole double %t3, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  store double 0.0, double* %l1
  %t8 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = load double, double* %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oeq double %t9, %t11
  %t13 = load double, double* %l0
  br i1 %t12, label %then6, label %merge7
then6:
  ret i8* %text
merge7:
  %t14 = load double, double* %l0
  %t15 = fptosi double %t14 to i64
  %t16 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t15)
  ret i8* %t16
}

define %StructLayoutHeaderParse @parse_struct_layout_header(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca %NumberParseResult
  %l12 = alloca i8*
  %l13 = alloca %NumberParseResult
  %l14 = alloca i1
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call { i8**, i64 }* @split_whitespace(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* %t4, { i8**, i64 }** %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s14 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.14, i32 0, i32 0
  %t15 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t13, i8* %s14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l1
  %t16 = insertvalue %StructLayoutHeaderParse undef, i1 0, 0
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.17, i32 0, i32 0
  %t18 = insertvalue %StructLayoutHeaderParse %t16, i8* %s17, 1
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %StructLayoutHeaderParse %t18, double %t19, 2
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %StructLayoutHeaderParse %t20, double %t21, 3
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = insertvalue %StructLayoutHeaderParse %t22, { i8**, i64 }* %t23, 4
  ret %StructLayoutHeaderParse %t24
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s25 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.25, i32 0, i32 0
  store i8* %s25, i8** %l5
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l6
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l7
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l8
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load i1, i1* %l2
  %t32 = load i1, i1* %l3
  %t33 = load i1, i1* %l4
  %t34 = load i8*, i8** %l5
  %t35 = load double, double* %l6
  %t36 = load double, double* %l7
  %t37 = load double, double* %l8
  br label %loop.header2
loop.header2:
  %t205 = phi i8* [ %t34, %entry ], [ %t197, %loop.latch4 ]
  %t206 = phi i1 [ %t31, %entry ], [ %t198, %loop.latch4 ]
  %t207 = phi i1 [ %t32, %entry ], [ %t199, %loop.latch4 ]
  %t208 = phi double [ %t35, %entry ], [ %t200, %loop.latch4 ]
  %t209 = phi { i8**, i64 }* [ %t30, %entry ], [ %t201, %loop.latch4 ]
  %t210 = phi i1 [ %t33, %entry ], [ %t202, %loop.latch4 ]
  %t211 = phi double [ %t36, %entry ], [ %t203, %loop.latch4 ]
  %t212 = phi double [ %t37, %entry ], [ %t204, %loop.latch4 ]
  store i8* %t205, i8** %l5
  store i1 %t206, i1* %l2
  store i1 %t207, i1* %l3
  store double %t208, double* %l6
  store { i8**, i64 }* %t209, { i8**, i64 }** %l1
  store i1 %t210, i1* %l4
  store double %t211, double* %l7
  store double %t212, double* %l8
  br label %loop.body3
loop.body3:
  %t38 = load double, double* %l8
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t38, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load i1, i1* %l2
  %t47 = load i1, i1* %l3
  %t48 = load i1, i1* %l4
  %t49 = load i8*, i8** %l5
  %t50 = load double, double* %l6
  %t51 = load double, double* %l7
  %t52 = load double, double* %l8
  br i1 %t43, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l8
  %t55 = fptosi double %t54 to i64
  %t56 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t57 = extractvalue { i8**, i64 } %t56, 0
  %t58 = extractvalue { i8**, i64 } %t56, 1
  %t59 = icmp uge i64 %t55, %t58
  ; bounds check: %t59 (if true, out of bounds)
  %t60 = getelementptr i8*, i8** %t57, i64 %t55
  %t61 = load i8*, i8** %t60
  store i8* %t61, i8** %l9
  %t62 = load i8*, i8** %l9
  %s63 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.63, i32 0, i32 0
  %t64 = call i1 @starts_with(i8* %t62, i8* %s63)
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load i1, i1* %l2
  %t68 = load i1, i1* %l3
  %t69 = load i1, i1* %l4
  %t70 = load i8*, i8** %l5
  %t71 = load double, double* %l6
  %t72 = load double, double* %l7
  %t73 = load double, double* %l8
  %t74 = load i8*, i8** %l9
  br i1 %t64, label %then8, label %else9
then8:
  %t75 = load i8*, i8** %l9
  %t76 = load i8*, i8** %l9
  %t77 = call i64 @sailfin_runtime_string_length(i8* %t76)
  %t78 = call i8* @sailfin_runtime_substring(i8* %t75, i64 5, i64 %t77)
  store i8* %t78, i8** %l5
  store i1 1, i1* %l2
  br label %merge10
else9:
  %t79 = load i8*, i8** %l9
  %s80 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.80, i32 0, i32 0
  %t81 = call i1 @starts_with(i8* %t79, i8* %s80)
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = load i1, i1* %l2
  %t85 = load i1, i1* %l3
  %t86 = load i1, i1* %l4
  %t87 = load i8*, i8** %l5
  %t88 = load double, double* %l6
  %t89 = load double, double* %l7
  %t90 = load double, double* %l8
  %t91 = load i8*, i8** %l9
  br i1 %t81, label %then11, label %else12
then11:
  %t92 = load i8*, i8** %l9
  %t93 = load i8*, i8** %l9
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = call i8* @sailfin_runtime_substring(i8* %t92, i64 5, i64 %t94)
  store i8* %t95, i8** %l10
  %t96 = load i8*, i8** %l10
  %t97 = call %NumberParseResult @parse_decimal_number(i8* %t96)
  store %NumberParseResult %t97, %NumberParseResult* %l11
  %t98 = load %NumberParseResult, %NumberParseResult* %l11
  %t99 = extractvalue %NumberParseResult %t98, 0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t102 = load i1, i1* %l2
  %t103 = load i1, i1* %l3
  %t104 = load i1, i1* %l4
  %t105 = load i8*, i8** %l5
  %t106 = load double, double* %l6
  %t107 = load double, double* %l7
  %t108 = load double, double* %l8
  %t109 = load i8*, i8** %l9
  %t110 = load i8*, i8** %l10
  %t111 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t99, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t112 = load %NumberParseResult, %NumberParseResult* %l11
  %t113 = extractvalue %NumberParseResult %t112, 1
  store double %t113, double* %l6
  br label %merge16
else15:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s115 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.115, i32 0, i32 0
  %t116 = load i8*, i8** %l10
  %t117 = add i8* %s115, %t116
  %t118 = getelementptr i8, i8* %t117, i64 0
  %t119 = load i8, i8* %t118
  %t120 = add i8 %t119, 96
  %t121 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t114, i8* null)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t122 = phi i1 [ 1, %then14 ], [ %t103, %else15 ]
  %t123 = phi double [ %t113, %then14 ], [ %t106, %else15 ]
  %t124 = phi { i8**, i64 }* [ %t101, %then14 ], [ %t121, %else15 ]
  store i1 %t122, i1* %l3
  store double %t123, double* %l6
  store { i8**, i64 }* %t124, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t125 = load i8*, i8** %l9
  %s126 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.126, i32 0, i32 0
  %t127 = call i1 @starts_with(i8* %t125, i8* %s126)
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load i1, i1* %l2
  %t131 = load i1, i1* %l3
  %t132 = load i1, i1* %l4
  %t133 = load i8*, i8** %l5
  %t134 = load double, double* %l6
  %t135 = load double, double* %l7
  %t136 = load double, double* %l8
  %t137 = load i8*, i8** %l9
  br i1 %t127, label %then17, label %else18
then17:
  %t138 = load i8*, i8** %l9
  %t139 = load i8*, i8** %l9
  %t140 = call i64 @sailfin_runtime_string_length(i8* %t139)
  %t141 = call i8* @sailfin_runtime_substring(i8* %t138, i64 6, i64 %t140)
  store i8* %t141, i8** %l12
  %t142 = load i8*, i8** %l12
  %t143 = call %NumberParseResult @parse_decimal_number(i8* %t142)
  store %NumberParseResult %t143, %NumberParseResult* %l13
  %t144 = load %NumberParseResult, %NumberParseResult* %l13
  %t145 = extractvalue %NumberParseResult %t144, 0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t148 = load i1, i1* %l2
  %t149 = load i1, i1* %l3
  %t150 = load i1, i1* %l4
  %t151 = load i8*, i8** %l5
  %t152 = load double, double* %l6
  %t153 = load double, double* %l7
  %t154 = load double, double* %l8
  %t155 = load i8*, i8** %l9
  %t156 = load i8*, i8** %l12
  %t157 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t145, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t158 = load %NumberParseResult, %NumberParseResult* %l13
  %t159 = extractvalue %NumberParseResult %t158, 1
  store double %t159, double* %l7
  br label %merge22
else21:
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s161 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.161, i32 0, i32 0
  %t162 = load i8*, i8** %l12
  %t163 = add i8* %s161, %t162
  %t164 = getelementptr i8, i8* %t163, i64 0
  %t165 = load i8, i8* %t164
  %t166 = add i8 %t165, 96
  %t167 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t160, i8* null)
  store { i8**, i64 }* %t167, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t168 = phi i1 [ 1, %then20 ], [ %t150, %else21 ]
  %t169 = phi double [ %t159, %then20 ], [ %t153, %else21 ]
  %t170 = phi { i8**, i64 }* [ %t147, %then20 ], [ %t167, %else21 ]
  store i1 %t168, i1* %l4
  store double %t169, double* %l7
  store { i8**, i64 }* %t170, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s172 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.172, i32 0, i32 0
  %t173 = load i8*, i8** %l9
  %t174 = add i8* %s172, %t173
  %t175 = getelementptr i8, i8* %t174, i64 0
  %t176 = load i8, i8* %t175
  %t177 = add i8 %t176, 96
  %t178 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t171, i8* null)
  store { i8**, i64 }* %t178, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t179 = phi i1 [ 1, %then17 ], [ %t132, %else18 ]
  %t180 = phi double [ %t159, %then17 ], [ %t135, %else18 ]
  %t181 = phi { i8**, i64 }* [ %t167, %then17 ], [ %t178, %else18 ]
  store i1 %t179, i1* %l4
  store double %t180, double* %l7
  store { i8**, i64 }* %t181, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t182 = phi i1 [ 1, %then11 ], [ %t85, %else12 ]
  %t183 = phi double [ %t113, %then11 ], [ %t88, %else12 ]
  %t184 = phi { i8**, i64 }* [ %t121, %then11 ], [ %t167, %else12 ]
  %t185 = phi i1 [ %t86, %then11 ], [ 1, %else12 ]
  %t186 = phi double [ %t89, %then11 ], [ %t159, %else12 ]
  store i1 %t182, i1* %l3
  store double %t183, double* %l6
  store { i8**, i64 }* %t184, { i8**, i64 }** %l1
  store i1 %t185, i1* %l4
  store double %t186, double* %l7
  br label %merge10
merge10:
  %t187 = phi i8* [ %t78, %then8 ], [ %t70, %else9 ]
  %t188 = phi i1 [ 1, %then8 ], [ %t67, %else9 ]
  %t189 = phi i1 [ %t68, %then8 ], [ 1, %else9 ]
  %t190 = phi double [ %t71, %then8 ], [ %t113, %else9 ]
  %t191 = phi { i8**, i64 }* [ %t66, %then8 ], [ %t121, %else9 ]
  %t192 = phi i1 [ %t69, %then8 ], [ 1, %else9 ]
  %t193 = phi double [ %t72, %then8 ], [ %t159, %else9 ]
  store i8* %t187, i8** %l5
  store i1 %t188, i1* %l2
  store i1 %t189, i1* %l3
  store double %t190, double* %l6
  store { i8**, i64 }* %t191, { i8**, i64 }** %l1
  store i1 %t192, i1* %l4
  store double %t193, double* %l7
  %t194 = load double, double* %l8
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l8
  br label %loop.latch4
loop.latch4:
  %t197 = load i8*, i8** %l5
  %t198 = load i1, i1* %l2
  %t199 = load i1, i1* %l3
  %t200 = load double, double* %l6
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t202 = load i1, i1* %l4
  %t203 = load double, double* %l7
  %t204 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t213 = load i1, i1* %l3
  %t214 = xor i1 %t213, 1
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = load i1, i1* %l2
  %t218 = load i1, i1* %l3
  %t219 = load i1, i1* %l4
  %t220 = load i8*, i8** %l5
  %t221 = load double, double* %l6
  %t222 = load double, double* %l7
  %t223 = load double, double* %l8
  br i1 %t214, label %then23, label %merge24
then23:
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s225 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.225, i32 0, i32 0
  %t226 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t224, i8* %s225)
  store { i8**, i64 }* %t226, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t227 = phi { i8**, i64 }* [ %t226, %then23 ], [ %t216, %entry ]
  store { i8**, i64 }* %t227, { i8**, i64 }** %l1
  %t228 = load i1, i1* %l4
  %t229 = xor i1 %t228, 1
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load i1, i1* %l2
  %t233 = load i1, i1* %l3
  %t234 = load i1, i1* %l4
  %t235 = load i8*, i8** %l5
  %t236 = load double, double* %l6
  %t237 = load double, double* %l7
  %t238 = load double, double* %l8
  br i1 %t229, label %then25, label %merge26
then25:
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s240 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.240, i32 0, i32 0
  %t241 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t239, i8* %s240)
  store { i8**, i64 }* %t241, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t242 = phi { i8**, i64 }* [ %t241, %then25 ], [ %t231, %entry ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l1
  %t245 = load i1, i1* %l3
  br label %logical_and_entry_244

logical_and_entry_244:
  br i1 %t245, label %logical_and_right_244, label %logical_and_merge_244

logical_and_right_244:
  %t246 = load i1, i1* %l4
  br label %logical_and_right_end_244

logical_and_right_end_244:
  br label %logical_and_merge_244

logical_and_merge_244:
  %t247 = phi i1 [ false, %logical_and_entry_244 ], [ %t246, %logical_and_right_end_244 ]
  br label %logical_and_entry_243

logical_and_entry_243:
  br i1 %t247, label %logical_and_right_243, label %logical_and_merge_243

logical_and_right_243:
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t249 = load { i8**, i64 }, { i8**, i64 }* %t248
  %t250 = extractvalue { i8**, i64 } %t249, 1
  %t251 = icmp eq i64 %t250, 0
  br label %logical_and_right_end_243

logical_and_right_end_243:
  br label %logical_and_merge_243

logical_and_merge_243:
  %t252 = phi i1 [ false, %logical_and_entry_243 ], [ %t251, %logical_and_right_end_243 ]
  store i1 %t252, i1* %l14
  %t253 = load i1, i1* %l14
  %t254 = insertvalue %StructLayoutHeaderParse undef, i1 %t253, 0
  %t255 = load i8*, i8** %l5
  %t256 = insertvalue %StructLayoutHeaderParse %t254, i8* %t255, 1
  %t257 = load double, double* %l6
  %t258 = insertvalue %StructLayoutHeaderParse %t256, double %t257, 2
  %t259 = load double, double* %l7
  %t260 = insertvalue %StructLayoutHeaderParse %t258, double %t259, 3
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t262 = insertvalue %StructLayoutHeaderParse %t260, { i8**, i64 }* %t261, 4
  ret %StructLayoutHeaderParse %t262
}

define %StructLayoutFieldParse @parse_struct_layout_field(i8* %text, i8* %struct_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %NumberParseResult
  %l16 = alloca i8*
  %l17 = alloca %NumberParseResult
  %l18 = alloca i8*
  %l19 = alloca %NumberParseResult
  %l20 = alloca i1
  %l21 = alloca %NativeStructLayoutField
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  %t7 = insertvalue %NativeStructLayoutField undef, i8* %s6, 0
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  %t9 = insertvalue %NativeStructLayoutField %t7, i8* %s8, 1
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %NativeStructLayoutField %t9, double %t10, 2
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeStructLayoutField %t11, double %t12, 3
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %NativeStructLayoutField %t13, double %t14, 4
  store %NativeStructLayoutField %t15, %NativeStructLayoutField* %l2
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s23 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.23, i32 0, i32 0
  %t24 = add i8* %s23, %struct_name
  %s25 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.25, i32 0, i32 0
  %t26 = add i8* %t24, %s25
  %t27 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t29 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t30 = insertvalue %StructLayoutFieldParse %t28, i8* null, 1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = insertvalue %StructLayoutFieldParse %t30, { i8**, i64 }* %t31, 2
  ret %StructLayoutFieldParse %t32
merge1:
  %t33 = load i8*, i8** %l0
  %t34 = call { i8**, i64 }* @split_whitespace(i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l3
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t35
  %t37 = extractvalue { i8**, i64 } %t36, 1
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t38, label %then2, label %merge3
then2:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s44 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.44, i32 0, i32 0
  %t45 = add i8* %s44, %struct_name
  %s46 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %t45, %s46
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t50 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t51 = insertvalue %StructLayoutFieldParse %t49, i8* null, 1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = insertvalue %StructLayoutFieldParse %t51, { i8**, i64 }* %t52, 2
  ret %StructLayoutFieldParse %t53
merge3:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t56 = extractvalue { i8**, i64 } %t55, 0
  %t57 = extractvalue { i8**, i64 } %t55, 1
  %t58 = icmp uge i64 0, %t57
  ; bounds check: %t58 (if true, out of bounds)
  %t59 = getelementptr i8*, i8** %t56, i64 0
  %t60 = load i8*, i8** %t59
  store i8* %t60, i8** %l4
  %t61 = load i8*, i8** %l4
  %t62 = call i64 @sailfin_runtime_string_length(i8* %t61)
  %t63 = icmp eq i64 %t62, 0
  %t64 = load i8*, i8** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = load i8*, i8** %l4
  br i1 %t63, label %then4, label %merge5
then4:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s70 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.70, i32 0, i32 0
  %t71 = add i8* %s70, %struct_name
  %s72 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.72, i32 0, i32 0
  %t73 = add i8* %t71, %s72
  %t74 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t69, i8* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  %t75 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t76 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t77 = insertvalue %StructLayoutFieldParse %t75, i8* null, 1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = insertvalue %StructLayoutFieldParse %t77, { i8**, i64 }* %t78, 2
  ret %StructLayoutFieldParse %t79
merge5:
  %s80 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.80, i32 0, i32 0
  store i8* %s80, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t81 = sitofp i64 0 to double
  store double %t81, double* %l9
  %t82 = sitofp i64 0 to double
  store double %t82, double* %l10
  %t83 = sitofp i64 0 to double
  store double %t83, double* %l11
  %t84 = sitofp i64 1 to double
  store double %t84, double* %l12
  %t85 = load i8*, i8** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t89 = load i8*, i8** %l4
  %t90 = load i8*, i8** %l5
  %t91 = load i1, i1* %l6
  %t92 = load i1, i1* %l7
  %t93 = load i1, i1* %l8
  %t94 = load double, double* %l9
  %t95 = load double, double* %l10
  %t96 = load double, double* %l11
  %t97 = load double, double* %l12
  br label %loop.header6
loop.header6:
  %t380 = phi i8* [ %t90, %entry ], [ %t371, %loop.latch8 ]
  %t381 = phi i1 [ %t91, %entry ], [ %t372, %loop.latch8 ]
  %t382 = phi double [ %t94, %entry ], [ %t373, %loop.latch8 ]
  %t383 = phi { i8**, i64 }* [ %t86, %entry ], [ %t374, %loop.latch8 ]
  %t384 = phi i1 [ %t92, %entry ], [ %t375, %loop.latch8 ]
  %t385 = phi double [ %t95, %entry ], [ %t376, %loop.latch8 ]
  %t386 = phi i1 [ %t93, %entry ], [ %t377, %loop.latch8 ]
  %t387 = phi double [ %t96, %entry ], [ %t378, %loop.latch8 ]
  %t388 = phi double [ %t97, %entry ], [ %t379, %loop.latch8 ]
  store i8* %t380, i8** %l5
  store i1 %t381, i1* %l6
  store double %t382, double* %l9
  store { i8**, i64 }* %t383, { i8**, i64 }** %l1
  store i1 %t384, i1* %l7
  store double %t385, double* %l10
  store i1 %t386, i1* %l8
  store double %t387, double* %l11
  store double %t388, double* %l12
  br label %loop.body7
loop.body7:
  %t98 = load double, double* %l12
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t100 = load { i8**, i64 }, { i8**, i64 }* %t99
  %t101 = extractvalue { i8**, i64 } %t100, 1
  %t102 = sitofp i64 %t101 to double
  %t103 = fcmp oge double %t98, %t102
  %t104 = load i8*, i8** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t108 = load i8*, i8** %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i1, i1* %l6
  %t111 = load i1, i1* %l7
  %t112 = load i1, i1* %l8
  %t113 = load double, double* %l9
  %t114 = load double, double* %l10
  %t115 = load double, double* %l11
  %t116 = load double, double* %l12
  br i1 %t103, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t118 = load double, double* %l12
  %t119 = fptosi double %t118 to i64
  %t120 = load { i8**, i64 }, { i8**, i64 }* %t117
  %t121 = extractvalue { i8**, i64 } %t120, 0
  %t122 = extractvalue { i8**, i64 } %t120, 1
  %t123 = icmp uge i64 %t119, %t122
  ; bounds check: %t123 (if true, out of bounds)
  %t124 = getelementptr i8*, i8** %t121, i64 %t119
  %t125 = load i8*, i8** %t124
  store i8* %t125, i8** %l13
  %t126 = load i8*, i8** %l13
  %s127 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.127, i32 0, i32 0
  %t128 = call i1 @starts_with(i8* %t126, i8* %s127)
  %t129 = load i8*, i8** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t133 = load i8*, i8** %l4
  %t134 = load i8*, i8** %l5
  %t135 = load i1, i1* %l6
  %t136 = load i1, i1* %l7
  %t137 = load i1, i1* %l8
  %t138 = load double, double* %l9
  %t139 = load double, double* %l10
  %t140 = load double, double* %l11
  %t141 = load double, double* %l12
  %t142 = load i8*, i8** %l13
  br i1 %t128, label %then12, label %else13
then12:
  %t143 = load i8*, i8** %l13
  %t144 = load i8*, i8** %l13
  %t145 = call i64 @sailfin_runtime_string_length(i8* %t144)
  %t146 = call i8* @sailfin_runtime_substring(i8* %t143, i64 5, i64 %t145)
  store i8* %t146, i8** %l5
  br label %merge14
else13:
  %t147 = load i8*, i8** %l13
  %s148 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.148, i32 0, i32 0
  %t149 = call i1 @starts_with(i8* %t147, i8* %s148)
  %t150 = load i8*, i8** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t154 = load i8*, i8** %l4
  %t155 = load i8*, i8** %l5
  %t156 = load i1, i1* %l6
  %t157 = load i1, i1* %l7
  %t158 = load i1, i1* %l8
  %t159 = load double, double* %l9
  %t160 = load double, double* %l10
  %t161 = load double, double* %l11
  %t162 = load double, double* %l12
  %t163 = load i8*, i8** %l13
  br i1 %t149, label %then15, label %else16
then15:
  %t164 = load i8*, i8** %l13
  %t165 = load i8*, i8** %l13
  %t166 = call i64 @sailfin_runtime_string_length(i8* %t165)
  %t167 = call i8* @sailfin_runtime_substring(i8* %t164, i64 7, i64 %t166)
  store i8* %t167, i8** %l14
  %t168 = load i8*, i8** %l14
  %t169 = call %NumberParseResult @parse_decimal_number(i8* %t168)
  store %NumberParseResult %t169, %NumberParseResult* %l15
  %t170 = load %NumberParseResult, %NumberParseResult* %l15
  %t171 = extractvalue %NumberParseResult %t170, 0
  %t172 = load i8*, i8** %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t176 = load i8*, i8** %l4
  %t177 = load i8*, i8** %l5
  %t178 = load i1, i1* %l6
  %t179 = load i1, i1* %l7
  %t180 = load i1, i1* %l8
  %t181 = load double, double* %l9
  %t182 = load double, double* %l10
  %t183 = load double, double* %l11
  %t184 = load double, double* %l12
  %t185 = load i8*, i8** %l13
  %t186 = load i8*, i8** %l14
  %t187 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t171, label %then18, label %else19
then18:
  store i1 1, i1* %l6
  %t188 = load %NumberParseResult, %NumberParseResult* %l15
  %t189 = extractvalue %NumberParseResult %t188, 1
  store double %t189, double* %l9
  br label %merge20
else19:
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s191 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.191, i32 0, i32 0
  %t192 = add i8* %s191, %struct_name
  %s193 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.193, i32 0, i32 0
  %t194 = add i8* %t192, %s193
  %t195 = load i8*, i8** %l4
  %t196 = add i8* %t194, %t195
  %s197 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.197, i32 0, i32 0
  %t198 = add i8* %t196, %s197
  %t199 = load i8*, i8** %l14
  %t200 = add i8* %t198, %t199
  %t201 = getelementptr i8, i8* %t200, i64 0
  %t202 = load i8, i8* %t201
  %t203 = add i8 %t202, 96
  %t204 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* null)
  store { i8**, i64 }* %t204, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t205 = phi i1 [ 1, %then18 ], [ %t178, %else19 ]
  %t206 = phi double [ %t189, %then18 ], [ %t181, %else19 ]
  %t207 = phi { i8**, i64 }* [ %t173, %then18 ], [ %t204, %else19 ]
  store i1 %t205, i1* %l6
  store double %t206, double* %l9
  store { i8**, i64 }* %t207, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t208 = load i8*, i8** %l13
  %s209 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.209, i32 0, i32 0
  %t210 = call i1 @starts_with(i8* %t208, i8* %s209)
  %t211 = load i8*, i8** %l0
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t215 = load i8*, i8** %l4
  %t216 = load i8*, i8** %l5
  %t217 = load i1, i1* %l6
  %t218 = load i1, i1* %l7
  %t219 = load i1, i1* %l8
  %t220 = load double, double* %l9
  %t221 = load double, double* %l10
  %t222 = load double, double* %l11
  %t223 = load double, double* %l12
  %t224 = load i8*, i8** %l13
  br i1 %t210, label %then21, label %else22
then21:
  %t225 = load i8*, i8** %l13
  %t226 = load i8*, i8** %l13
  %t227 = call i64 @sailfin_runtime_string_length(i8* %t226)
  %t228 = call i8* @sailfin_runtime_substring(i8* %t225, i64 5, i64 %t227)
  store i8* %t228, i8** %l16
  %t229 = load i8*, i8** %l16
  %t230 = call %NumberParseResult @parse_decimal_number(i8* %t229)
  store %NumberParseResult %t230, %NumberParseResult* %l17
  %t231 = load %NumberParseResult, %NumberParseResult* %l17
  %t232 = extractvalue %NumberParseResult %t231, 0
  %t233 = load i8*, i8** %l0
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t235 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t237 = load i8*, i8** %l4
  %t238 = load i8*, i8** %l5
  %t239 = load i1, i1* %l6
  %t240 = load i1, i1* %l7
  %t241 = load i1, i1* %l8
  %t242 = load double, double* %l9
  %t243 = load double, double* %l10
  %t244 = load double, double* %l11
  %t245 = load double, double* %l12
  %t246 = load i8*, i8** %l13
  %t247 = load i8*, i8** %l16
  %t248 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t232, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t249 = load %NumberParseResult, %NumberParseResult* %l17
  %t250 = extractvalue %NumberParseResult %t249, 1
  store double %t250, double* %l10
  br label %merge26
else25:
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s252 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.252, i32 0, i32 0
  %t253 = add i8* %s252, %struct_name
  %s254 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.254, i32 0, i32 0
  %t255 = add i8* %t253, %s254
  %t256 = load i8*, i8** %l4
  %t257 = add i8* %t255, %t256
  %s258 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.258, i32 0, i32 0
  %t259 = add i8* %t257, %s258
  %t260 = load i8*, i8** %l16
  %t261 = add i8* %t259, %t260
  %t262 = getelementptr i8, i8* %t261, i64 0
  %t263 = load i8, i8* %t262
  %t264 = add i8 %t263, 96
  %t265 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t251, i8* null)
  store { i8**, i64 }* %t265, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t266 = phi i1 [ 1, %then24 ], [ %t240, %else25 ]
  %t267 = phi double [ %t250, %then24 ], [ %t243, %else25 ]
  %t268 = phi { i8**, i64 }* [ %t234, %then24 ], [ %t265, %else25 ]
  store i1 %t266, i1* %l7
  store double %t267, double* %l10
  store { i8**, i64 }* %t268, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t269 = load i8*, i8** %l13
  %s270 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.270, i32 0, i32 0
  %t271 = call i1 @starts_with(i8* %t269, i8* %s270)
  %t272 = load i8*, i8** %l0
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t276 = load i8*, i8** %l4
  %t277 = load i8*, i8** %l5
  %t278 = load i1, i1* %l6
  %t279 = load i1, i1* %l7
  %t280 = load i1, i1* %l8
  %t281 = load double, double* %l9
  %t282 = load double, double* %l10
  %t283 = load double, double* %l11
  %t284 = load double, double* %l12
  %t285 = load i8*, i8** %l13
  br i1 %t271, label %then27, label %else28
then27:
  %t286 = load i8*, i8** %l13
  %t287 = load i8*, i8** %l13
  %t288 = call i64 @sailfin_runtime_string_length(i8* %t287)
  %t289 = call i8* @sailfin_runtime_substring(i8* %t286, i64 6, i64 %t288)
  store i8* %t289, i8** %l18
  %t290 = load i8*, i8** %l18
  %t291 = call %NumberParseResult @parse_decimal_number(i8* %t290)
  store %NumberParseResult %t291, %NumberParseResult* %l19
  %t292 = load %NumberParseResult, %NumberParseResult* %l19
  %t293 = extractvalue %NumberParseResult %t292, 0
  %t294 = load i8*, i8** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t298 = load i8*, i8** %l4
  %t299 = load i8*, i8** %l5
  %t300 = load i1, i1* %l6
  %t301 = load i1, i1* %l7
  %t302 = load i1, i1* %l8
  %t303 = load double, double* %l9
  %t304 = load double, double* %l10
  %t305 = load double, double* %l11
  %t306 = load double, double* %l12
  %t307 = load i8*, i8** %l13
  %t308 = load i8*, i8** %l18
  %t309 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t293, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t310 = load %NumberParseResult, %NumberParseResult* %l19
  %t311 = extractvalue %NumberParseResult %t310, 1
  store double %t311, double* %l11
  br label %merge32
else31:
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s313 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.313, i32 0, i32 0
  %t314 = add i8* %s313, %struct_name
  %s315 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.315, i32 0, i32 0
  %t316 = add i8* %t314, %s315
  %t317 = load i8*, i8** %l4
  %t318 = add i8* %t316, %t317
  %s319 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.319, i32 0, i32 0
  %t320 = add i8* %t318, %s319
  %t321 = load i8*, i8** %l18
  %t322 = add i8* %t320, %t321
  %t323 = getelementptr i8, i8* %t322, i64 0
  %t324 = load i8, i8* %t323
  %t325 = add i8 %t324, 96
  %t326 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t312, i8* null)
  store { i8**, i64 }* %t326, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t327 = phi i1 [ 1, %then30 ], [ %t302, %else31 ]
  %t328 = phi double [ %t311, %then30 ], [ %t305, %else31 ]
  %t329 = phi { i8**, i64 }* [ %t295, %then30 ], [ %t326, %else31 ]
  store i1 %t327, i1* %l8
  store double %t328, double* %l11
  store { i8**, i64 }* %t329, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s331 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.331, i32 0, i32 0
  %t332 = add i8* %s331, %struct_name
  %s333 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.333, i32 0, i32 0
  %t334 = add i8* %t332, %s333
  %t335 = load i8*, i8** %l4
  %t336 = add i8* %t334, %t335
  %s337 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.337, i32 0, i32 0
  %t338 = add i8* %t336, %s337
  %t339 = load i8*, i8** %l13
  %t340 = add i8* %t338, %t339
  %t341 = getelementptr i8, i8* %t340, i64 0
  %t342 = load i8, i8* %t341
  %t343 = add i8 %t342, 96
  %t344 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t330, i8* null)
  store { i8**, i64 }* %t344, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t345 = phi i1 [ 1, %then27 ], [ %t280, %else28 ]
  %t346 = phi double [ %t311, %then27 ], [ %t283, %else28 ]
  %t347 = phi { i8**, i64 }* [ %t326, %then27 ], [ %t344, %else28 ]
  store i1 %t345, i1* %l8
  store double %t346, double* %l11
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t348 = phi i1 [ 1, %then21 ], [ %t218, %else22 ]
  %t349 = phi double [ %t250, %then21 ], [ %t221, %else22 ]
  %t350 = phi { i8**, i64 }* [ %t265, %then21 ], [ %t326, %else22 ]
  %t351 = phi i1 [ %t219, %then21 ], [ 1, %else22 ]
  %t352 = phi double [ %t222, %then21 ], [ %t311, %else22 ]
  store i1 %t348, i1* %l7
  store double %t349, double* %l10
  store { i8**, i64 }* %t350, { i8**, i64 }** %l1
  store i1 %t351, i1* %l8
  store double %t352, double* %l11
  br label %merge17
merge17:
  %t353 = phi i1 [ 1, %then15 ], [ %t156, %else16 ]
  %t354 = phi double [ %t189, %then15 ], [ %t159, %else16 ]
  %t355 = phi { i8**, i64 }* [ %t204, %then15 ], [ %t265, %else16 ]
  %t356 = phi i1 [ %t157, %then15 ], [ 1, %else16 ]
  %t357 = phi double [ %t160, %then15 ], [ %t250, %else16 ]
  %t358 = phi i1 [ %t158, %then15 ], [ 1, %else16 ]
  %t359 = phi double [ %t161, %then15 ], [ %t311, %else16 ]
  store i1 %t353, i1* %l6
  store double %t354, double* %l9
  store { i8**, i64 }* %t355, { i8**, i64 }** %l1
  store i1 %t356, i1* %l7
  store double %t357, double* %l10
  store i1 %t358, i1* %l8
  store double %t359, double* %l11
  br label %merge14
merge14:
  %t360 = phi i8* [ %t146, %then12 ], [ %t134, %else13 ]
  %t361 = phi i1 [ %t135, %then12 ], [ 1, %else13 ]
  %t362 = phi double [ %t138, %then12 ], [ %t189, %else13 ]
  %t363 = phi { i8**, i64 }* [ %t130, %then12 ], [ %t204, %else13 ]
  %t364 = phi i1 [ %t136, %then12 ], [ 1, %else13 ]
  %t365 = phi double [ %t139, %then12 ], [ %t250, %else13 ]
  %t366 = phi i1 [ %t137, %then12 ], [ 1, %else13 ]
  %t367 = phi double [ %t140, %then12 ], [ %t311, %else13 ]
  store i8* %t360, i8** %l5
  store i1 %t361, i1* %l6
  store double %t362, double* %l9
  store { i8**, i64 }* %t363, { i8**, i64 }** %l1
  store i1 %t364, i1* %l7
  store double %t365, double* %l10
  store i1 %t366, i1* %l8
  store double %t367, double* %l11
  %t368 = load double, double* %l12
  %t369 = sitofp i64 1 to double
  %t370 = fadd double %t368, %t369
  store double %t370, double* %l12
  br label %loop.latch8
loop.latch8:
  %t371 = load i8*, i8** %l5
  %t372 = load i1, i1* %l6
  %t373 = load double, double* %l9
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t375 = load i1, i1* %l7
  %t376 = load double, double* %l10
  %t377 = load i1, i1* %l8
  %t378 = load double, double* %l11
  %t379 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t389 = load i8*, i8** %l5
  %t390 = call i64 @sailfin_runtime_string_length(i8* %t389)
  %t391 = icmp eq i64 %t390, 0
  %t392 = load i8*, i8** %l0
  %t393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t394 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t396 = load i8*, i8** %l4
  %t397 = load i8*, i8** %l5
  %t398 = load i1, i1* %l6
  %t399 = load i1, i1* %l7
  %t400 = load i1, i1* %l8
  %t401 = load double, double* %l9
  %t402 = load double, double* %l10
  %t403 = load double, double* %l11
  %t404 = load double, double* %l12
  br i1 %t391, label %then33, label %merge34
then33:
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s406 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.406, i32 0, i32 0
  %t407 = add i8* %s406, %struct_name
  %s408 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.408, i32 0, i32 0
  %t409 = add i8* %t407, %s408
  %t410 = load i8*, i8** %l4
  %t411 = add i8* %t409, %t410
  %s412 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.412, i32 0, i32 0
  %t413 = add i8* %t411, %s412
  %t414 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t405, i8* %t413)
  store { i8**, i64 }* %t414, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t415 = phi { i8**, i64 }* [ %t414, %then33 ], [ %t393, %entry ]
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  %t416 = load i1, i1* %l6
  %t417 = xor i1 %t416, 1
  %t418 = load i8*, i8** %l0
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t420 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t422 = load i8*, i8** %l4
  %t423 = load i8*, i8** %l5
  %t424 = load i1, i1* %l6
  %t425 = load i1, i1* %l7
  %t426 = load i1, i1* %l8
  %t427 = load double, double* %l9
  %t428 = load double, double* %l10
  %t429 = load double, double* %l11
  %t430 = load double, double* %l12
  br i1 %t417, label %then35, label %merge36
then35:
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s432 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.432, i32 0, i32 0
  %t433 = add i8* %s432, %struct_name
  %s434 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.434, i32 0, i32 0
  %t435 = add i8* %t433, %s434
  %t436 = load i8*, i8** %l4
  %t437 = add i8* %t435, %t436
  %s438 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.438, i32 0, i32 0
  %t439 = add i8* %t437, %s438
  %t440 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t431, i8* %t439)
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t441 = phi { i8**, i64 }* [ %t440, %then35 ], [ %t419, %entry ]
  store { i8**, i64 }* %t441, { i8**, i64 }** %l1
  %t442 = load i1, i1* %l7
  %t443 = xor i1 %t442, 1
  %t444 = load i8*, i8** %l0
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t448 = load i8*, i8** %l4
  %t449 = load i8*, i8** %l5
  %t450 = load i1, i1* %l6
  %t451 = load i1, i1* %l7
  %t452 = load i1, i1* %l8
  %t453 = load double, double* %l9
  %t454 = load double, double* %l10
  %t455 = load double, double* %l11
  %t456 = load double, double* %l12
  br i1 %t443, label %then37, label %merge38
then37:
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s458 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.458, i32 0, i32 0
  %t459 = add i8* %s458, %struct_name
  %s460 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.460, i32 0, i32 0
  %t461 = add i8* %t459, %s460
  %t462 = load i8*, i8** %l4
  %t463 = add i8* %t461, %t462
  %s464 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.464, i32 0, i32 0
  %t465 = add i8* %t463, %s464
  %t466 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t457, i8* %t465)
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t467 = phi { i8**, i64 }* [ %t466, %then37 ], [ %t445, %entry ]
  store { i8**, i64 }* %t467, { i8**, i64 }** %l1
  %t468 = load i1, i1* %l8
  %t469 = xor i1 %t468, 1
  %t470 = load i8*, i8** %l0
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t472 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t474 = load i8*, i8** %l4
  %t475 = load i8*, i8** %l5
  %t476 = load i1, i1* %l6
  %t477 = load i1, i1* %l7
  %t478 = load i1, i1* %l8
  %t479 = load double, double* %l9
  %t480 = load double, double* %l10
  %t481 = load double, double* %l11
  %t482 = load double, double* %l12
  br i1 %t469, label %then39, label %merge40
then39:
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s484 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.484, i32 0, i32 0
  %t485 = add i8* %s484, %struct_name
  %s486 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.486, i32 0, i32 0
  %t487 = add i8* %t485, %s486
  %t488 = load i8*, i8** %l4
  %t489 = add i8* %t487, %t488
  %s490 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.490, i32 0, i32 0
  %t491 = add i8* %t489, %s490
  %t492 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t483, i8* %t491)
  store { i8**, i64 }* %t492, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t493 = phi { i8**, i64 }* [ %t492, %then39 ], [ %t471, %entry ]
  store { i8**, i64 }* %t493, { i8**, i64 }** %l1
  %t498 = load i8*, i8** %l5
  %t499 = call i64 @sailfin_runtime_string_length(i8* %t498)
  %t500 = icmp sgt i64 %t499, 0
  br label %logical_and_entry_497

logical_and_entry_497:
  br i1 %t500, label %logical_and_right_497, label %logical_and_merge_497

logical_and_right_497:
  %t501 = load i1, i1* %l6
  br label %logical_and_right_end_497

logical_and_right_end_497:
  br label %logical_and_merge_497

logical_and_merge_497:
  %t502 = phi i1 [ false, %logical_and_entry_497 ], [ %t501, %logical_and_right_end_497 ]
  br label %logical_and_entry_496

logical_and_entry_496:
  br i1 %t502, label %logical_and_right_496, label %logical_and_merge_496

logical_and_right_496:
  %t503 = load i1, i1* %l7
  br label %logical_and_right_end_496

logical_and_right_end_496:
  br label %logical_and_merge_496

logical_and_merge_496:
  %t504 = phi i1 [ false, %logical_and_entry_496 ], [ %t503, %logical_and_right_end_496 ]
  br label %logical_and_entry_495

logical_and_entry_495:
  br i1 %t504, label %logical_and_right_495, label %logical_and_merge_495

logical_and_right_495:
  %t505 = load i1, i1* %l8
  br label %logical_and_right_end_495

logical_and_right_end_495:
  br label %logical_and_merge_495

logical_and_merge_495:
  %t506 = phi i1 [ false, %logical_and_entry_495 ], [ %t505, %logical_and_right_end_495 ]
  br label %logical_and_entry_494

logical_and_entry_494:
  br i1 %t506, label %logical_and_right_494, label %logical_and_merge_494

logical_and_right_494:
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t508 = load { i8**, i64 }, { i8**, i64 }* %t507
  %t509 = extractvalue { i8**, i64 } %t508, 1
  %t510 = icmp eq i64 %t509, 0
  br label %logical_and_right_end_494

logical_and_right_end_494:
  br label %logical_and_merge_494

logical_and_merge_494:
  %t511 = phi i1 [ false, %logical_and_entry_494 ], [ %t510, %logical_and_right_end_494 ]
  store i1 %t511, i1* %l20
  %t512 = load i8*, i8** %l4
  %t513 = insertvalue %NativeStructLayoutField undef, i8* %t512, 0
  %t514 = load i8*, i8** %l5
  %t515 = insertvalue %NativeStructLayoutField %t513, i8* %t514, 1
  %t516 = load double, double* %l9
  %t517 = insertvalue %NativeStructLayoutField %t515, double %t516, 2
  %t518 = load double, double* %l10
  %t519 = insertvalue %NativeStructLayoutField %t517, double %t518, 3
  %t520 = load double, double* %l11
  %t521 = insertvalue %NativeStructLayoutField %t519, double %t520, 4
  store %NativeStructLayoutField %t521, %NativeStructLayoutField* %l21
  %t522 = load i1, i1* %l20
  %t523 = insertvalue %StructLayoutFieldParse undef, i1 %t522, 0
  %t524 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t525 = insertvalue %StructLayoutFieldParse %t523, i8* null, 1
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t527 = insertvalue %StructLayoutFieldParse %t525, { i8**, i64 }* %t526, 2
  ret %StructLayoutFieldParse %t527
}

define %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca %NumberParseResult
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call { i8**, i64 }* @split_whitespace(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = alloca [0 x i8*]
  %t3 = getelementptr [0 x i8*], [0 x i8*]* %t2, i32 0, i32 0
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t3, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* %t4, { i8**, i64 }** %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s14 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.14, i32 0, i32 0
  %t15 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t13, i8* %s14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l1
  %t16 = insertvalue %EnumLayoutHeaderParse undef, i1 0, 0
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.17, i32 0, i32 0
  %t18 = insertvalue %EnumLayoutHeaderParse %t16, i8* %s17, 1
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %EnumLayoutHeaderParse %t18, double %t19, 2
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %EnumLayoutHeaderParse %t20, double %t21, 3
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.23, i32 0, i32 0
  %t24 = insertvalue %EnumLayoutHeaderParse %t22, i8* %s23, 4
  %t25 = sitofp i64 0 to double
  %t26 = insertvalue %EnumLayoutHeaderParse %t24, double %t25, 5
  %t27 = sitofp i64 0 to double
  %t28 = insertvalue %EnumLayoutHeaderParse %t26, double %t27, 6
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = insertvalue %EnumLayoutHeaderParse %t28, { i8**, i64 }* %t29, 7
  ret %EnumLayoutHeaderParse %t30
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.31, i32 0, i32 0
  store i8* %s31, i8** %l5
  %s32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.32, i32 0, i32 0
  store i8* %s32, i8** %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t33 = sitofp i64 0 to double
  store double %t33, double* %l9
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l10
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l11
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l12
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l13
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load i1, i1* %l2
  %t41 = load i1, i1* %l3
  %t42 = load i1, i1* %l4
  %t43 = load i8*, i8** %l5
  %t44 = load i8*, i8** %l6
  %t45 = load i1, i1* %l7
  %t46 = load i1, i1* %l8
  %t47 = load double, double* %l9
  %t48 = load double, double* %l10
  %t49 = load double, double* %l11
  %t50 = load double, double* %l12
  %t51 = load double, double* %l13
  br label %loop.header2
loop.header2:
  %t417 = phi i8* [ %t43, %entry ], [ %t404, %loop.latch4 ]
  %t418 = phi i1 [ %t40, %entry ], [ %t405, %loop.latch4 ]
  %t419 = phi i1 [ %t41, %entry ], [ %t406, %loop.latch4 ]
  %t420 = phi double [ %t47, %entry ], [ %t407, %loop.latch4 ]
  %t421 = phi { i8**, i64 }* [ %t39, %entry ], [ %t408, %loop.latch4 ]
  %t422 = phi i1 [ %t42, %entry ], [ %t409, %loop.latch4 ]
  %t423 = phi double [ %t48, %entry ], [ %t410, %loop.latch4 ]
  %t424 = phi i8* [ %t44, %entry ], [ %t411, %loop.latch4 ]
  %t425 = phi i1 [ %t45, %entry ], [ %t412, %loop.latch4 ]
  %t426 = phi double [ %t49, %entry ], [ %t413, %loop.latch4 ]
  %t427 = phi i1 [ %t46, %entry ], [ %t414, %loop.latch4 ]
  %t428 = phi double [ %t50, %entry ], [ %t415, %loop.latch4 ]
  %t429 = phi double [ %t51, %entry ], [ %t416, %loop.latch4 ]
  store i8* %t417, i8** %l5
  store i1 %t418, i1* %l2
  store i1 %t419, i1* %l3
  store double %t420, double* %l9
  store { i8**, i64 }* %t421, { i8**, i64 }** %l1
  store i1 %t422, i1* %l4
  store double %t423, double* %l10
  store i8* %t424, i8** %l6
  store i1 %t425, i1* %l7
  store double %t426, double* %l11
  store i1 %t427, i1* %l8
  store double %t428, double* %l12
  store double %t429, double* %l13
  br label %loop.body3
loop.body3:
  %t52 = load double, double* %l13
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load i1, i1* %l2
  %t61 = load i1, i1* %l3
  %t62 = load i1, i1* %l4
  %t63 = load i8*, i8** %l5
  %t64 = load i8*, i8** %l6
  %t65 = load i1, i1* %l7
  %t66 = load i1, i1* %l8
  %t67 = load double, double* %l9
  %t68 = load double, double* %l10
  %t69 = load double, double* %l11
  %t70 = load double, double* %l12
  %t71 = load double, double* %l13
  br i1 %t57, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load double, double* %l13
  %t74 = fptosi double %t73 to i64
  %t75 = load { i8**, i64 }, { i8**, i64 }* %t72
  %t76 = extractvalue { i8**, i64 } %t75, 0
  %t77 = extractvalue { i8**, i64 } %t75, 1
  %t78 = icmp uge i64 %t74, %t77
  ; bounds check: %t78 (if true, out of bounds)
  %t79 = getelementptr i8*, i8** %t76, i64 %t74
  %t80 = load i8*, i8** %t79
  store i8* %t80, i8** %l14
  %t81 = load i8*, i8** %l14
  %s82 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.82, i32 0, i32 0
  %t83 = call i1 @starts_with(i8* %t81, i8* %s82)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load i1, i1* %l2
  %t87 = load i1, i1* %l3
  %t88 = load i1, i1* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  %t91 = load i1, i1* %l7
  %t92 = load i1, i1* %l8
  %t93 = load double, double* %l9
  %t94 = load double, double* %l10
  %t95 = load double, double* %l11
  %t96 = load double, double* %l12
  %t97 = load double, double* %l13
  %t98 = load i8*, i8** %l14
  br i1 %t83, label %then8, label %else9
then8:
  %t99 = load i8*, i8** %l14
  %t100 = load i8*, i8** %l14
  %t101 = call i64 @sailfin_runtime_string_length(i8* %t100)
  %t102 = call i8* @sailfin_runtime_substring(i8* %t99, i64 5, i64 %t101)
  store i8* %t102, i8** %l5
  store i1 1, i1* %l2
  br label %merge10
else9:
  %t103 = load i8*, i8** %l14
  %s104 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.104, i32 0, i32 0
  %t105 = call i1 @starts_with(i8* %t103, i8* %s104)
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t108 = load i1, i1* %l2
  %t109 = load i1, i1* %l3
  %t110 = load i1, i1* %l4
  %t111 = load i8*, i8** %l5
  %t112 = load i8*, i8** %l6
  %t113 = load i1, i1* %l7
  %t114 = load i1, i1* %l8
  %t115 = load double, double* %l9
  %t116 = load double, double* %l10
  %t117 = load double, double* %l11
  %t118 = load double, double* %l12
  %t119 = load double, double* %l13
  %t120 = load i8*, i8** %l14
  br i1 %t105, label %then11, label %else12
then11:
  %t121 = load i8*, i8** %l14
  %t122 = load i8*, i8** %l14
  %t123 = call i64 @sailfin_runtime_string_length(i8* %t122)
  %t124 = call i8* @sailfin_runtime_substring(i8* %t121, i64 5, i64 %t123)
  store i8* %t124, i8** %l15
  %t125 = load i8*, i8** %l15
  %t126 = call %NumberParseResult @parse_decimal_number(i8* %t125)
  store %NumberParseResult %t126, %NumberParseResult* %l16
  %t127 = load %NumberParseResult, %NumberParseResult* %l16
  %t128 = extractvalue %NumberParseResult %t127, 0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load i1, i1* %l2
  %t132 = load i1, i1* %l3
  %t133 = load i1, i1* %l4
  %t134 = load i8*, i8** %l5
  %t135 = load i8*, i8** %l6
  %t136 = load i1, i1* %l7
  %t137 = load i1, i1* %l8
  %t138 = load double, double* %l9
  %t139 = load double, double* %l10
  %t140 = load double, double* %l11
  %t141 = load double, double* %l12
  %t142 = load double, double* %l13
  %t143 = load i8*, i8** %l14
  %t144 = load i8*, i8** %l15
  %t145 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t128, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t146 = load %NumberParseResult, %NumberParseResult* %l16
  %t147 = extractvalue %NumberParseResult %t146, 1
  store double %t147, double* %l9
  br label %merge16
else15:
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s149 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.149, i32 0, i32 0
  %t150 = load i8*, i8** %l15
  %t151 = add i8* %s149, %t150
  %t152 = getelementptr i8, i8* %t151, i64 0
  %t153 = load i8, i8* %t152
  %t154 = add i8 %t153, 96
  %t155 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t148, i8* null)
  store { i8**, i64 }* %t155, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t156 = phi i1 [ 1, %then14 ], [ %t132, %else15 ]
  %t157 = phi double [ %t147, %then14 ], [ %t138, %else15 ]
  %t158 = phi { i8**, i64 }* [ %t130, %then14 ], [ %t155, %else15 ]
  store i1 %t156, i1* %l3
  store double %t157, double* %l9
  store { i8**, i64 }* %t158, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t159 = load i8*, i8** %l14
  %s160 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.160, i32 0, i32 0
  %t161 = call i1 @starts_with(i8* %t159, i8* %s160)
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t164 = load i1, i1* %l2
  %t165 = load i1, i1* %l3
  %t166 = load i1, i1* %l4
  %t167 = load i8*, i8** %l5
  %t168 = load i8*, i8** %l6
  %t169 = load i1, i1* %l7
  %t170 = load i1, i1* %l8
  %t171 = load double, double* %l9
  %t172 = load double, double* %l10
  %t173 = load double, double* %l11
  %t174 = load double, double* %l12
  %t175 = load double, double* %l13
  %t176 = load i8*, i8** %l14
  br i1 %t161, label %then17, label %else18
then17:
  %t177 = load i8*, i8** %l14
  %t178 = load i8*, i8** %l14
  %t179 = call i64 @sailfin_runtime_string_length(i8* %t178)
  %t180 = call i8* @sailfin_runtime_substring(i8* %t177, i64 6, i64 %t179)
  store i8* %t180, i8** %l17
  %t181 = load i8*, i8** %l17
  %t182 = call %NumberParseResult @parse_decimal_number(i8* %t181)
  store %NumberParseResult %t182, %NumberParseResult* %l18
  %t183 = load %NumberParseResult, %NumberParseResult* %l18
  %t184 = extractvalue %NumberParseResult %t183, 0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = load i1, i1* %l2
  %t188 = load i1, i1* %l3
  %t189 = load i1, i1* %l4
  %t190 = load i8*, i8** %l5
  %t191 = load i8*, i8** %l6
  %t192 = load i1, i1* %l7
  %t193 = load i1, i1* %l8
  %t194 = load double, double* %l9
  %t195 = load double, double* %l10
  %t196 = load double, double* %l11
  %t197 = load double, double* %l12
  %t198 = load double, double* %l13
  %t199 = load i8*, i8** %l14
  %t200 = load i8*, i8** %l17
  %t201 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t184, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t202 = load %NumberParseResult, %NumberParseResult* %l18
  %t203 = extractvalue %NumberParseResult %t202, 1
  store double %t203, double* %l10
  br label %merge22
else21:
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s205 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.205, i32 0, i32 0
  %t206 = load i8*, i8** %l17
  %t207 = add i8* %s205, %t206
  %t208 = getelementptr i8, i8* %t207, i64 0
  %t209 = load i8, i8* %t208
  %t210 = add i8 %t209, 96
  %t211 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t204, i8* null)
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t212 = phi i1 [ 1, %then20 ], [ %t189, %else21 ]
  %t213 = phi double [ %t203, %then20 ], [ %t195, %else21 ]
  %t214 = phi { i8**, i64 }* [ %t186, %then20 ], [ %t211, %else21 ]
  store i1 %t212, i1* %l4
  store double %t213, double* %l10
  store { i8**, i64 }* %t214, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t215 = load i8*, i8** %l14
  %s216 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.216, i32 0, i32 0
  %t217 = call i1 @starts_with(i8* %t215, i8* %s216)
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load i1, i1* %l2
  %t221 = load i1, i1* %l3
  %t222 = load i1, i1* %l4
  %t223 = load i8*, i8** %l5
  %t224 = load i8*, i8** %l6
  %t225 = load i1, i1* %l7
  %t226 = load i1, i1* %l8
  %t227 = load double, double* %l9
  %t228 = load double, double* %l10
  %t229 = load double, double* %l11
  %t230 = load double, double* %l12
  %t231 = load double, double* %l13
  %t232 = load i8*, i8** %l14
  br i1 %t217, label %then23, label %else24
then23:
  %t233 = load i8*, i8** %l14
  %t234 = load i8*, i8** %l14
  %t235 = call i64 @sailfin_runtime_string_length(i8* %t234)
  %t236 = call i8* @sailfin_runtime_substring(i8* %t233, i64 9, i64 %t235)
  store i8* %t236, i8** %l6
  br label %merge25
else24:
  %t237 = load i8*, i8** %l14
  %s238 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.238, i32 0, i32 0
  %t239 = call i1 @starts_with(i8* %t237, i8* %s238)
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t242 = load i1, i1* %l2
  %t243 = load i1, i1* %l3
  %t244 = load i1, i1* %l4
  %t245 = load i8*, i8** %l5
  %t246 = load i8*, i8** %l6
  %t247 = load i1, i1* %l7
  %t248 = load i1, i1* %l8
  %t249 = load double, double* %l9
  %t250 = load double, double* %l10
  %t251 = load double, double* %l11
  %t252 = load double, double* %l12
  %t253 = load double, double* %l13
  %t254 = load i8*, i8** %l14
  br i1 %t239, label %then26, label %else27
then26:
  %t255 = load i8*, i8** %l14
  %t256 = load i8*, i8** %l14
  %t257 = call i64 @sailfin_runtime_string_length(i8* %t256)
  %t258 = call i8* @sailfin_runtime_substring(i8* %t255, i64 9, i64 %t257)
  store i8* %t258, i8** %l19
  %t259 = load i8*, i8** %l19
  %t260 = call %NumberParseResult @parse_decimal_number(i8* %t259)
  store %NumberParseResult %t260, %NumberParseResult* %l20
  %t261 = load %NumberParseResult, %NumberParseResult* %l20
  %t262 = extractvalue %NumberParseResult %t261, 0
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t265 = load i1, i1* %l2
  %t266 = load i1, i1* %l3
  %t267 = load i1, i1* %l4
  %t268 = load i8*, i8** %l5
  %t269 = load i8*, i8** %l6
  %t270 = load i1, i1* %l7
  %t271 = load i1, i1* %l8
  %t272 = load double, double* %l9
  %t273 = load double, double* %l10
  %t274 = load double, double* %l11
  %t275 = load double, double* %l12
  %t276 = load double, double* %l13
  %t277 = load i8*, i8** %l14
  %t278 = load i8*, i8** %l19
  %t279 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t262, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t280 = load %NumberParseResult, %NumberParseResult* %l20
  %t281 = extractvalue %NumberParseResult %t280, 1
  store double %t281, double* %l11
  br label %merge31
else30:
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s283 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.283, i32 0, i32 0
  %t284 = load i8*, i8** %l19
  %t285 = add i8* %s283, %t284
  %t286 = getelementptr i8, i8* %t285, i64 0
  %t287 = load i8, i8* %t286
  %t288 = add i8 %t287, 96
  %t289 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t282, i8* null)
  store { i8**, i64 }* %t289, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t290 = phi i1 [ 1, %then29 ], [ %t270, %else30 ]
  %t291 = phi double [ %t281, %then29 ], [ %t274, %else30 ]
  %t292 = phi { i8**, i64 }* [ %t264, %then29 ], [ %t289, %else30 ]
  store i1 %t290, i1* %l7
  store double %t291, double* %l11
  store { i8**, i64 }* %t292, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t293 = load i8*, i8** %l14
  %s294 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.294, i32 0, i32 0
  %t295 = call i1 @starts_with(i8* %t293, i8* %s294)
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t298 = load i1, i1* %l2
  %t299 = load i1, i1* %l3
  %t300 = load i1, i1* %l4
  %t301 = load i8*, i8** %l5
  %t302 = load i8*, i8** %l6
  %t303 = load i1, i1* %l7
  %t304 = load i1, i1* %l8
  %t305 = load double, double* %l9
  %t306 = load double, double* %l10
  %t307 = load double, double* %l11
  %t308 = load double, double* %l12
  %t309 = load double, double* %l13
  %t310 = load i8*, i8** %l14
  br i1 %t295, label %then32, label %else33
then32:
  %t311 = load i8*, i8** %l14
  %t312 = load i8*, i8** %l14
  %t313 = call i64 @sailfin_runtime_string_length(i8* %t312)
  %t314 = call i8* @sailfin_runtime_substring(i8* %t311, i64 10, i64 %t313)
  store i8* %t314, i8** %l21
  %t315 = load i8*, i8** %l21
  %t316 = call %NumberParseResult @parse_decimal_number(i8* %t315)
  store %NumberParseResult %t316, %NumberParseResult* %l22
  %t317 = load %NumberParseResult, %NumberParseResult* %l22
  %t318 = extractvalue %NumberParseResult %t317, 0
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t321 = load i1, i1* %l2
  %t322 = load i1, i1* %l3
  %t323 = load i1, i1* %l4
  %t324 = load i8*, i8** %l5
  %t325 = load i8*, i8** %l6
  %t326 = load i1, i1* %l7
  %t327 = load i1, i1* %l8
  %t328 = load double, double* %l9
  %t329 = load double, double* %l10
  %t330 = load double, double* %l11
  %t331 = load double, double* %l12
  %t332 = load double, double* %l13
  %t333 = load i8*, i8** %l14
  %t334 = load i8*, i8** %l21
  %t335 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t318, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t336 = load %NumberParseResult, %NumberParseResult* %l22
  %t337 = extractvalue %NumberParseResult %t336, 1
  store double %t337, double* %l12
  br label %merge37
else36:
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s339 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.339, i32 0, i32 0
  %t340 = load i8*, i8** %l21
  %t341 = add i8* %s339, %t340
  %t342 = getelementptr i8, i8* %t341, i64 0
  %t343 = load i8, i8* %t342
  %t344 = add i8 %t343, 96
  %t345 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t338, i8* null)
  store { i8**, i64 }* %t345, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t346 = phi i1 [ 1, %then35 ], [ %t327, %else36 ]
  %t347 = phi double [ %t337, %then35 ], [ %t331, %else36 ]
  %t348 = phi { i8**, i64 }* [ %t320, %then35 ], [ %t345, %else36 ]
  store i1 %t346, i1* %l8
  store double %t347, double* %l12
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s350 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.350, i32 0, i32 0
  %t351 = load i8*, i8** %l14
  %t352 = add i8* %s350, %t351
  %t353 = getelementptr i8, i8* %t352, i64 0
  %t354 = load i8, i8* %t353
  %t355 = add i8 %t354, 96
  %t356 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t349, i8* null)
  store { i8**, i64 }* %t356, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t357 = phi i1 [ 1, %then32 ], [ %t304, %else33 ]
  %t358 = phi double [ %t337, %then32 ], [ %t308, %else33 ]
  %t359 = phi { i8**, i64 }* [ %t345, %then32 ], [ %t356, %else33 ]
  store i1 %t357, i1* %l8
  store double %t358, double* %l12
  store { i8**, i64 }* %t359, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t360 = phi i1 [ 1, %then26 ], [ %t247, %else27 ]
  %t361 = phi double [ %t281, %then26 ], [ %t251, %else27 ]
  %t362 = phi { i8**, i64 }* [ %t289, %then26 ], [ %t345, %else27 ]
  %t363 = phi i1 [ %t248, %then26 ], [ 1, %else27 ]
  %t364 = phi double [ %t252, %then26 ], [ %t337, %else27 ]
  store i1 %t360, i1* %l7
  store double %t361, double* %l11
  store { i8**, i64 }* %t362, { i8**, i64 }** %l1
  store i1 %t363, i1* %l8
  store double %t364, double* %l12
  br label %merge25
merge25:
  %t365 = phi i8* [ %t236, %then23 ], [ %t224, %else24 ]
  %t366 = phi i1 [ %t225, %then23 ], [ 1, %else24 ]
  %t367 = phi double [ %t229, %then23 ], [ %t281, %else24 ]
  %t368 = phi { i8**, i64 }* [ %t219, %then23 ], [ %t289, %else24 ]
  %t369 = phi i1 [ %t226, %then23 ], [ 1, %else24 ]
  %t370 = phi double [ %t230, %then23 ], [ %t337, %else24 ]
  store i8* %t365, i8** %l6
  store i1 %t366, i1* %l7
  store double %t367, double* %l11
  store { i8**, i64 }* %t368, { i8**, i64 }** %l1
  store i1 %t369, i1* %l8
  store double %t370, double* %l12
  br label %merge19
merge19:
  %t371 = phi i1 [ 1, %then17 ], [ %t166, %else18 ]
  %t372 = phi double [ %t203, %then17 ], [ %t172, %else18 ]
  %t373 = phi { i8**, i64 }* [ %t211, %then17 ], [ %t289, %else18 ]
  %t374 = phi i8* [ %t168, %then17 ], [ %t236, %else18 ]
  %t375 = phi i1 [ %t169, %then17 ], [ 1, %else18 ]
  %t376 = phi double [ %t173, %then17 ], [ %t281, %else18 ]
  %t377 = phi i1 [ %t170, %then17 ], [ 1, %else18 ]
  %t378 = phi double [ %t174, %then17 ], [ %t337, %else18 ]
  store i1 %t371, i1* %l4
  store double %t372, double* %l10
  store { i8**, i64 }* %t373, { i8**, i64 }** %l1
  store i8* %t374, i8** %l6
  store i1 %t375, i1* %l7
  store double %t376, double* %l11
  store i1 %t377, i1* %l8
  store double %t378, double* %l12
  br label %merge13
merge13:
  %t379 = phi i1 [ 1, %then11 ], [ %t109, %else12 ]
  %t380 = phi double [ %t147, %then11 ], [ %t115, %else12 ]
  %t381 = phi { i8**, i64 }* [ %t155, %then11 ], [ %t211, %else12 ]
  %t382 = phi i1 [ %t110, %then11 ], [ 1, %else12 ]
  %t383 = phi double [ %t116, %then11 ], [ %t203, %else12 ]
  %t384 = phi i8* [ %t112, %then11 ], [ %t236, %else12 ]
  %t385 = phi i1 [ %t113, %then11 ], [ 1, %else12 ]
  %t386 = phi double [ %t117, %then11 ], [ %t281, %else12 ]
  %t387 = phi i1 [ %t114, %then11 ], [ 1, %else12 ]
  %t388 = phi double [ %t118, %then11 ], [ %t337, %else12 ]
  store i1 %t379, i1* %l3
  store double %t380, double* %l9
  store { i8**, i64 }* %t381, { i8**, i64 }** %l1
  store i1 %t382, i1* %l4
  store double %t383, double* %l10
  store i8* %t384, i8** %l6
  store i1 %t385, i1* %l7
  store double %t386, double* %l11
  store i1 %t387, i1* %l8
  store double %t388, double* %l12
  br label %merge10
merge10:
  %t389 = phi i8* [ %t102, %then8 ], [ %t89, %else9 ]
  %t390 = phi i1 [ 1, %then8 ], [ %t86, %else9 ]
  %t391 = phi i1 [ %t87, %then8 ], [ 1, %else9 ]
  %t392 = phi double [ %t93, %then8 ], [ %t147, %else9 ]
  %t393 = phi { i8**, i64 }* [ %t85, %then8 ], [ %t155, %else9 ]
  %t394 = phi i1 [ %t88, %then8 ], [ 1, %else9 ]
  %t395 = phi double [ %t94, %then8 ], [ %t203, %else9 ]
  %t396 = phi i8* [ %t90, %then8 ], [ %t236, %else9 ]
  %t397 = phi i1 [ %t91, %then8 ], [ 1, %else9 ]
  %t398 = phi double [ %t95, %then8 ], [ %t281, %else9 ]
  %t399 = phi i1 [ %t92, %then8 ], [ 1, %else9 ]
  %t400 = phi double [ %t96, %then8 ], [ %t337, %else9 ]
  store i8* %t389, i8** %l5
  store i1 %t390, i1* %l2
  store i1 %t391, i1* %l3
  store double %t392, double* %l9
  store { i8**, i64 }* %t393, { i8**, i64 }** %l1
  store i1 %t394, i1* %l4
  store double %t395, double* %l10
  store i8* %t396, i8** %l6
  store i1 %t397, i1* %l7
  store double %t398, double* %l11
  store i1 %t399, i1* %l8
  store double %t400, double* %l12
  %t401 = load double, double* %l13
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  store double %t403, double* %l13
  br label %loop.latch4
loop.latch4:
  %t404 = load i8*, i8** %l5
  %t405 = load i1, i1* %l2
  %t406 = load i1, i1* %l3
  %t407 = load double, double* %l9
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t409 = load i1, i1* %l4
  %t410 = load double, double* %l10
  %t411 = load i8*, i8** %l6
  %t412 = load i1, i1* %l7
  %t413 = load double, double* %l11
  %t414 = load i1, i1* %l8
  %t415 = load double, double* %l12
  %t416 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t430 = load i1, i1* %l3
  %t431 = xor i1 %t430, 1
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t434 = load i1, i1* %l2
  %t435 = load i1, i1* %l3
  %t436 = load i1, i1* %l4
  %t437 = load i8*, i8** %l5
  %t438 = load i8*, i8** %l6
  %t439 = load i1, i1* %l7
  %t440 = load i1, i1* %l8
  %t441 = load double, double* %l9
  %t442 = load double, double* %l10
  %t443 = load double, double* %l11
  %t444 = load double, double* %l12
  %t445 = load double, double* %l13
  br i1 %t431, label %then38, label %merge39
then38:
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s447 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.447, i32 0, i32 0
  %t448 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t446, i8* %s447)
  store { i8**, i64 }* %t448, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t449 = phi { i8**, i64 }* [ %t448, %then38 ], [ %t433, %entry ]
  store { i8**, i64 }* %t449, { i8**, i64 }** %l1
  %t450 = load i1, i1* %l4
  %t451 = xor i1 %t450, 1
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t454 = load i1, i1* %l2
  %t455 = load i1, i1* %l3
  %t456 = load i1, i1* %l4
  %t457 = load i8*, i8** %l5
  %t458 = load i8*, i8** %l6
  %t459 = load i1, i1* %l7
  %t460 = load i1, i1* %l8
  %t461 = load double, double* %l9
  %t462 = load double, double* %l10
  %t463 = load double, double* %l11
  %t464 = load double, double* %l12
  %t465 = load double, double* %l13
  br i1 %t451, label %then40, label %merge41
then40:
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s467 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.467, i32 0, i32 0
  %t468 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t466, i8* %s467)
  store { i8**, i64 }* %t468, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t469 = phi { i8**, i64 }* [ %t468, %then40 ], [ %t453, %entry ]
  store { i8**, i64 }* %t469, { i8**, i64 }** %l1
  %t470 = load i8*, i8** %l6
  %t471 = call i64 @sailfin_runtime_string_length(i8* %t470)
  %t472 = icmp eq i64 %t471, 0
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l2
  %t476 = load i1, i1* %l3
  %t477 = load i1, i1* %l4
  %t478 = load i8*, i8** %l5
  %t479 = load i8*, i8** %l6
  %t480 = load i1, i1* %l7
  %t481 = load i1, i1* %l8
  %t482 = load double, double* %l9
  %t483 = load double, double* %l10
  %t484 = load double, double* %l11
  %t485 = load double, double* %l12
  %t486 = load double, double* %l13
  br i1 %t472, label %then42, label %merge43
then42:
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s488 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.488, i32 0, i32 0
  %t489 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t487, i8* %s488)
  store { i8**, i64 }* %t489, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t490 = phi { i8**, i64 }* [ %t489, %then42 ], [ %t474, %entry ]
  store { i8**, i64 }* %t490, { i8**, i64 }** %l1
  %t491 = load i1, i1* %l7
  %t492 = xor i1 %t491, 1
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t495 = load i1, i1* %l2
  %t496 = load i1, i1* %l3
  %t497 = load i1, i1* %l4
  %t498 = load i8*, i8** %l5
  %t499 = load i8*, i8** %l6
  %t500 = load i1, i1* %l7
  %t501 = load i1, i1* %l8
  %t502 = load double, double* %l9
  %t503 = load double, double* %l10
  %t504 = load double, double* %l11
  %t505 = load double, double* %l12
  %t506 = load double, double* %l13
  br i1 %t492, label %then44, label %merge45
then44:
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s508 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.508, i32 0, i32 0
  %t509 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t507, i8* %s508)
  store { i8**, i64 }* %t509, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t510 = phi { i8**, i64 }* [ %t509, %then44 ], [ %t494, %entry ]
  store { i8**, i64 }* %t510, { i8**, i64 }** %l1
  %t511 = load i1, i1* %l8
  %t512 = xor i1 %t511, 1
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t515 = load i1, i1* %l2
  %t516 = load i1, i1* %l3
  %t517 = load i1, i1* %l4
  %t518 = load i8*, i8** %l5
  %t519 = load i8*, i8** %l6
  %t520 = load i1, i1* %l7
  %t521 = load i1, i1* %l8
  %t522 = load double, double* %l9
  %t523 = load double, double* %l10
  %t524 = load double, double* %l11
  %t525 = load double, double* %l12
  %t526 = load double, double* %l13
  br i1 %t512, label %then46, label %merge47
then46:
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s528 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.528, i32 0, i32 0
  %t529 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t527, i8* %s528)
  store { i8**, i64 }* %t529, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t530 = phi { i8**, i64 }* [ %t529, %then46 ], [ %t514, %entry ]
  store { i8**, i64 }* %t530, { i8**, i64 }** %l1
  %t536 = load i1, i1* %l3
  br label %logical_and_entry_535

logical_and_entry_535:
  br i1 %t536, label %logical_and_right_535, label %logical_and_merge_535

logical_and_right_535:
  %t537 = load i1, i1* %l4
  br label %logical_and_right_end_535

logical_and_right_end_535:
  br label %logical_and_merge_535

logical_and_merge_535:
  %t538 = phi i1 [ false, %logical_and_entry_535 ], [ %t537, %logical_and_right_end_535 ]
  br label %logical_and_entry_534

logical_and_entry_534:
  br i1 %t538, label %logical_and_right_534, label %logical_and_merge_534

logical_and_right_534:
  %t539 = load i8*, i8** %l6
  %t540 = call i64 @sailfin_runtime_string_length(i8* %t539)
  %t541 = icmp sgt i64 %t540, 0
  br label %logical_and_right_end_534

logical_and_right_end_534:
  br label %logical_and_merge_534

logical_and_merge_534:
  %t542 = phi i1 [ false, %logical_and_entry_534 ], [ %t541, %logical_and_right_end_534 ]
  br label %logical_and_entry_533

logical_and_entry_533:
  br i1 %t542, label %logical_and_right_533, label %logical_and_merge_533

logical_and_right_533:
  %t543 = load i1, i1* %l7
  br label %logical_and_right_end_533

logical_and_right_end_533:
  br label %logical_and_merge_533

logical_and_merge_533:
  %t544 = phi i1 [ false, %logical_and_entry_533 ], [ %t543, %logical_and_right_end_533 ]
  br label %logical_and_entry_532

logical_and_entry_532:
  br i1 %t544, label %logical_and_right_532, label %logical_and_merge_532

logical_and_right_532:
  %t545 = load i1, i1* %l8
  br label %logical_and_right_end_532

logical_and_right_end_532:
  br label %logical_and_merge_532

logical_and_merge_532:
  %t546 = phi i1 [ false, %logical_and_entry_532 ], [ %t545, %logical_and_right_end_532 ]
  br label %logical_and_entry_531

logical_and_entry_531:
  br i1 %t546, label %logical_and_right_531, label %logical_and_merge_531

logical_and_right_531:
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t548 = load { i8**, i64 }, { i8**, i64 }* %t547
  %t549 = extractvalue { i8**, i64 } %t548, 1
  %t550 = icmp eq i64 %t549, 0
  br label %logical_and_right_end_531

logical_and_right_end_531:
  br label %logical_and_merge_531

logical_and_merge_531:
  %t551 = phi i1 [ false, %logical_and_entry_531 ], [ %t550, %logical_and_right_end_531 ]
  store i1 %t551, i1* %l23
  %t552 = load i1, i1* %l23
  %t553 = insertvalue %EnumLayoutHeaderParse undef, i1 %t552, 0
  %t554 = load i8*, i8** %l5
  %t555 = insertvalue %EnumLayoutHeaderParse %t553, i8* %t554, 1
  %t556 = load double, double* %l9
  %t557 = insertvalue %EnumLayoutHeaderParse %t555, double %t556, 2
  %t558 = load double, double* %l10
  %t559 = insertvalue %EnumLayoutHeaderParse %t557, double %t558, 3
  %t560 = load i8*, i8** %l6
  %t561 = insertvalue %EnumLayoutHeaderParse %t559, i8* %t560, 4
  %t562 = load double, double* %l11
  %t563 = insertvalue %EnumLayoutHeaderParse %t561, double %t562, 5
  %t564 = load double, double* %l12
  %t565 = insertvalue %EnumLayoutHeaderParse %t563, double %t564, 6
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t567 = insertvalue %EnumLayoutHeaderParse %t565, { i8**, i64 }* %t566, 7
  ret %EnumLayoutHeaderParse %t567
}

define %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i1
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca %NumberParseResult
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %l24 = alloca %NativeEnumVariantLayout
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  %t7 = insertvalue %NativeEnumVariantLayout undef, i8* %s6, 0
  %t8 = sitofp i64 0 to double
  %t9 = insertvalue %NativeEnumVariantLayout %t7, double %t8, 1
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %NativeEnumVariantLayout %t9, double %t10, 2
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeEnumVariantLayout %t11, double %t12, 3
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %NativeEnumVariantLayout %t13, double %t14, 4
  %t16 = alloca [0 x i8*]
  %t17 = getelementptr [0 x i8*], [0 x i8*]* %t16, i32 0, i32 0
  %t18 = alloca { i8**, i64 }
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 0
  store i8** %t17, i8*** %t19
  %t20 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  %t21 = insertvalue %NativeEnumVariantLayout %t15, { i8**, i64 }* %t18, 5
  store %NativeEnumVariantLayout %t21, %NativeEnumVariantLayout* %l2
  %t22 = load i8*, i8** %l0
  %t23 = call i64 @sailfin_runtime_string_length(i8* %t22)
  %t24 = icmp eq i64 %t23, 0
  %t25 = load i8*, i8** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  br i1 %t24, label %then0, label %merge1
then0:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %s29, %enum_name
  %s31 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.31, i32 0, i32 0
  %t32 = add i8* %t30, %s31
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  %t34 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t35 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t36 = insertvalue %EnumLayoutVariantParse %t34, i8* null, 1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = insertvalue %EnumLayoutVariantParse %t36, { i8**, i64 }* %t37, 2
  ret %EnumLayoutVariantParse %t38
merge1:
  %t39 = load i8*, i8** %l0
  %t40 = call { i8**, i64 }* @split_whitespace(i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = icmp eq i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t44, label %then2, label %merge3
then2:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s50 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.50, i32 0, i32 0
  %t51 = add i8* %s50, %enum_name
  %s52 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.52, i32 0, i32 0
  %t53 = add i8* %t51, %s52
  %t54 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t49, i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  %t55 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t56 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t57 = insertvalue %EnumLayoutVariantParse %t55, i8* null, 1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = insertvalue %EnumLayoutVariantParse %t57, { i8**, i64 }* %t58, 2
  ret %EnumLayoutVariantParse %t59
merge3:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t61 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t62 = extractvalue { i8**, i64 } %t61, 0
  %t63 = extractvalue { i8**, i64 } %t61, 1
  %t64 = icmp uge i64 0, %t63
  ; bounds check: %t64 (if true, out of bounds)
  %t65 = getelementptr i8*, i8** %t62, i64 0
  %t66 = load i8*, i8** %t65
  store i8* %t66, i8** %l4
  %t67 = load i8*, i8** %l4
  %t68 = call i64 @sailfin_runtime_string_length(i8* %t67)
  %t69 = icmp eq i64 %t68, 0
  %t70 = load i8*, i8** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t74 = load i8*, i8** %l4
  br i1 %t69, label %then4, label %merge5
then4:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s76 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.76, i32 0, i32 0
  %t77 = add i8* %s76, %enum_name
  %s78 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.78, i32 0, i32 0
  %t79 = add i8* %t77, %s78
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l1
  %t81 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t82 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t83 = insertvalue %EnumLayoutVariantParse %t81, i8* null, 1
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = insertvalue %EnumLayoutVariantParse %t83, { i8**, i64 }* %t84, 2
  ret %EnumLayoutVariantParse %t85
merge5:
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t86 = sitofp i64 0 to double
  store double %t86, double* %l9
  %t87 = sitofp i64 0 to double
  store double %t87, double* %l10
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l11
  %t89 = sitofp i64 0 to double
  store double %t89, double* %l12
  %t90 = sitofp i64 1 to double
  store double %t90, double* %l13
  %t91 = load i8*, i8** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t95 = load i8*, i8** %l4
  %t96 = load i1, i1* %l5
  %t97 = load i1, i1* %l6
  %t98 = load i1, i1* %l7
  %t99 = load i1, i1* %l8
  %t100 = load double, double* %l9
  %t101 = load double, double* %l10
  %t102 = load double, double* %l11
  %t103 = load double, double* %l12
  %t104 = load double, double* %l13
  br label %loop.header6
loop.header6:
  %t438 = phi i1 [ %t96, %entry ], [ %t428, %loop.latch8 ]
  %t439 = phi double [ %t100, %entry ], [ %t429, %loop.latch8 ]
  %t440 = phi { i8**, i64 }* [ %t92, %entry ], [ %t430, %loop.latch8 ]
  %t441 = phi i1 [ %t97, %entry ], [ %t431, %loop.latch8 ]
  %t442 = phi double [ %t101, %entry ], [ %t432, %loop.latch8 ]
  %t443 = phi i1 [ %t98, %entry ], [ %t433, %loop.latch8 ]
  %t444 = phi double [ %t102, %entry ], [ %t434, %loop.latch8 ]
  %t445 = phi i1 [ %t99, %entry ], [ %t435, %loop.latch8 ]
  %t446 = phi double [ %t103, %entry ], [ %t436, %loop.latch8 ]
  %t447 = phi double [ %t104, %entry ], [ %t437, %loop.latch8 ]
  store i1 %t438, i1* %l5
  store double %t439, double* %l9
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  store i1 %t441, i1* %l6
  store double %t442, double* %l10
  store i1 %t443, i1* %l7
  store double %t444, double* %l11
  store i1 %t445, i1* %l8
  store double %t446, double* %l12
  store double %t447, double* %l13
  br label %loop.body7
loop.body7:
  %t105 = load double, double* %l13
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t106
  %t108 = extractvalue { i8**, i64 } %t107, 1
  %t109 = sitofp i64 %t108 to double
  %t110 = fcmp oge double %t105, %t109
  %t111 = load i8*, i8** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t115 = load i8*, i8** %l4
  %t116 = load i1, i1* %l5
  %t117 = load i1, i1* %l6
  %t118 = load i1, i1* %l7
  %t119 = load i1, i1* %l8
  %t120 = load double, double* %l9
  %t121 = load double, double* %l10
  %t122 = load double, double* %l11
  %t123 = load double, double* %l12
  %t124 = load double, double* %l13
  br i1 %t110, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t126 = load double, double* %l13
  %t127 = fptosi double %t126 to i64
  %t128 = load { i8**, i64 }, { i8**, i64 }* %t125
  %t129 = extractvalue { i8**, i64 } %t128, 0
  %t130 = extractvalue { i8**, i64 } %t128, 1
  %t131 = icmp uge i64 %t127, %t130
  ; bounds check: %t131 (if true, out of bounds)
  %t132 = getelementptr i8*, i8** %t129, i64 %t127
  %t133 = load i8*, i8** %t132
  store i8* %t133, i8** %l14
  %t134 = load i8*, i8** %l14
  %s135 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.135, i32 0, i32 0
  %t136 = call i1 @starts_with(i8* %t134, i8* %s135)
  %t137 = load i8*, i8** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load i8*, i8** %l4
  %t142 = load i1, i1* %l5
  %t143 = load i1, i1* %l6
  %t144 = load i1, i1* %l7
  %t145 = load i1, i1* %l8
  %t146 = load double, double* %l9
  %t147 = load double, double* %l10
  %t148 = load double, double* %l11
  %t149 = load double, double* %l12
  %t150 = load double, double* %l13
  %t151 = load i8*, i8** %l14
  br i1 %t136, label %then12, label %else13
then12:
  %t152 = load i8*, i8** %l14
  %t153 = load i8*, i8** %l14
  %t154 = call i64 @sailfin_runtime_string_length(i8* %t153)
  %t155 = call i8* @sailfin_runtime_substring(i8* %t152, i64 4, i64 %t154)
  store i8* %t155, i8** %l15
  %t156 = load i8*, i8** %l15
  %t157 = call %NumberParseResult @parse_decimal_number(i8* %t156)
  store %NumberParseResult %t157, %NumberParseResult* %l16
  %t158 = load %NumberParseResult, %NumberParseResult* %l16
  %t159 = extractvalue %NumberParseResult %t158, 0
  %t160 = load i8*, i8** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t164 = load i8*, i8** %l4
  %t165 = load i1, i1* %l5
  %t166 = load i1, i1* %l6
  %t167 = load i1, i1* %l7
  %t168 = load i1, i1* %l8
  %t169 = load double, double* %l9
  %t170 = load double, double* %l10
  %t171 = load double, double* %l11
  %t172 = load double, double* %l12
  %t173 = load double, double* %l13
  %t174 = load i8*, i8** %l14
  %t175 = load i8*, i8** %l15
  %t176 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t159, label %then15, label %else16
then15:
  store i1 1, i1* %l5
  %t177 = load %NumberParseResult, %NumberParseResult* %l16
  %t178 = extractvalue %NumberParseResult %t177, 1
  store double %t178, double* %l9
  br label %merge17
else16:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s180 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.180, i32 0, i32 0
  %t181 = add i8* %s180, %enum_name
  %s182 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.182, i32 0, i32 0
  %t183 = add i8* %t181, %s182
  %t184 = load i8*, i8** %l4
  %t185 = add i8* %t183, %t184
  %s186 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.186, i32 0, i32 0
  %t187 = add i8* %t185, %s186
  %t188 = load i8*, i8** %l15
  %t189 = add i8* %t187, %t188
  %t190 = getelementptr i8, i8* %t189, i64 0
  %t191 = load i8, i8* %t190
  %t192 = add i8 %t191, 96
  %t193 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t179, i8* null)
  store { i8**, i64 }* %t193, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t194 = phi i1 [ 1, %then15 ], [ %t165, %else16 ]
  %t195 = phi double [ %t178, %then15 ], [ %t169, %else16 ]
  %t196 = phi { i8**, i64 }* [ %t161, %then15 ], [ %t193, %else16 ]
  store i1 %t194, i1* %l5
  store double %t195, double* %l9
  store { i8**, i64 }* %t196, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t197 = load i8*, i8** %l14
  %s198 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.198, i32 0, i32 0
  %t199 = call i1 @starts_with(i8* %t197, i8* %s198)
  %t200 = load i8*, i8** %l0
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t202 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t204 = load i8*, i8** %l4
  %t205 = load i1, i1* %l5
  %t206 = load i1, i1* %l6
  %t207 = load i1, i1* %l7
  %t208 = load i1, i1* %l8
  %t209 = load double, double* %l9
  %t210 = load double, double* %l10
  %t211 = load double, double* %l11
  %t212 = load double, double* %l12
  %t213 = load double, double* %l13
  %t214 = load i8*, i8** %l14
  br i1 %t199, label %then18, label %else19
then18:
  %t215 = load i8*, i8** %l14
  %t216 = load i8*, i8** %l14
  %t217 = call i64 @sailfin_runtime_string_length(i8* %t216)
  %t218 = call i8* @sailfin_runtime_substring(i8* %t215, i64 7, i64 %t217)
  store i8* %t218, i8** %l17
  %t219 = load i8*, i8** %l17
  %t220 = call %NumberParseResult @parse_decimal_number(i8* %t219)
  store %NumberParseResult %t220, %NumberParseResult* %l18
  %t221 = load %NumberParseResult, %NumberParseResult* %l18
  %t222 = extractvalue %NumberParseResult %t221, 0
  %t223 = load i8*, i8** %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t227 = load i8*, i8** %l4
  %t228 = load i1, i1* %l5
  %t229 = load i1, i1* %l6
  %t230 = load i1, i1* %l7
  %t231 = load i1, i1* %l8
  %t232 = load double, double* %l9
  %t233 = load double, double* %l10
  %t234 = load double, double* %l11
  %t235 = load double, double* %l12
  %t236 = load double, double* %l13
  %t237 = load i8*, i8** %l14
  %t238 = load i8*, i8** %l17
  %t239 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t222, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t240 = load %NumberParseResult, %NumberParseResult* %l18
  %t241 = extractvalue %NumberParseResult %t240, 1
  store double %t241, double* %l10
  br label %merge23
else22:
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s243 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.243, i32 0, i32 0
  %t244 = add i8* %s243, %enum_name
  %s245 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.245, i32 0, i32 0
  %t246 = add i8* %t244, %s245
  %t247 = load i8*, i8** %l4
  %t248 = add i8* %t246, %t247
  %s249 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.249, i32 0, i32 0
  %t250 = add i8* %t248, %s249
  %t251 = load i8*, i8** %l17
  %t252 = add i8* %t250, %t251
  %t253 = getelementptr i8, i8* %t252, i64 0
  %t254 = load i8, i8* %t253
  %t255 = add i8 %t254, 96
  %t256 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t242, i8* null)
  store { i8**, i64 }* %t256, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t257 = phi i1 [ 1, %then21 ], [ %t229, %else22 ]
  %t258 = phi double [ %t241, %then21 ], [ %t233, %else22 ]
  %t259 = phi { i8**, i64 }* [ %t224, %then21 ], [ %t256, %else22 ]
  store i1 %t257, i1* %l6
  store double %t258, double* %l10
  store { i8**, i64 }* %t259, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t260 = load i8*, i8** %l14
  %s261 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.261, i32 0, i32 0
  %t262 = call i1 @starts_with(i8* %t260, i8* %s261)
  %t263 = load i8*, i8** %l0
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t265 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t267 = load i8*, i8** %l4
  %t268 = load i1, i1* %l5
  %t269 = load i1, i1* %l6
  %t270 = load i1, i1* %l7
  %t271 = load i1, i1* %l8
  %t272 = load double, double* %l9
  %t273 = load double, double* %l10
  %t274 = load double, double* %l11
  %t275 = load double, double* %l12
  %t276 = load double, double* %l13
  %t277 = load i8*, i8** %l14
  br i1 %t262, label %then24, label %else25
then24:
  %t278 = load i8*, i8** %l14
  %t279 = load i8*, i8** %l14
  %t280 = call i64 @sailfin_runtime_string_length(i8* %t279)
  %t281 = call i8* @sailfin_runtime_substring(i8* %t278, i64 5, i64 %t280)
  store i8* %t281, i8** %l19
  %t282 = load i8*, i8** %l19
  %t283 = call %NumberParseResult @parse_decimal_number(i8* %t282)
  store %NumberParseResult %t283, %NumberParseResult* %l20
  %t284 = load %NumberParseResult, %NumberParseResult* %l20
  %t285 = extractvalue %NumberParseResult %t284, 0
  %t286 = load i8*, i8** %l0
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t288 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t290 = load i8*, i8** %l4
  %t291 = load i1, i1* %l5
  %t292 = load i1, i1* %l6
  %t293 = load i1, i1* %l7
  %t294 = load i1, i1* %l8
  %t295 = load double, double* %l9
  %t296 = load double, double* %l10
  %t297 = load double, double* %l11
  %t298 = load double, double* %l12
  %t299 = load double, double* %l13
  %t300 = load i8*, i8** %l14
  %t301 = load i8*, i8** %l19
  %t302 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t285, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t303 = load %NumberParseResult, %NumberParseResult* %l20
  %t304 = extractvalue %NumberParseResult %t303, 1
  store double %t304, double* %l11
  br label %merge29
else28:
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s306 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.306, i32 0, i32 0
  %t307 = add i8* %s306, %enum_name
  %s308 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.308, i32 0, i32 0
  %t309 = add i8* %t307, %s308
  %t310 = load i8*, i8** %l4
  %t311 = add i8* %t309, %t310
  %s312 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.312, i32 0, i32 0
  %t313 = add i8* %t311, %s312
  %t314 = load i8*, i8** %l19
  %t315 = add i8* %t313, %t314
  %t316 = getelementptr i8, i8* %t315, i64 0
  %t317 = load i8, i8* %t316
  %t318 = add i8 %t317, 96
  %t319 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t305, i8* null)
  store { i8**, i64 }* %t319, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t320 = phi i1 [ 1, %then27 ], [ %t293, %else28 ]
  %t321 = phi double [ %t304, %then27 ], [ %t297, %else28 ]
  %t322 = phi { i8**, i64 }* [ %t287, %then27 ], [ %t319, %else28 ]
  store i1 %t320, i1* %l7
  store double %t321, double* %l11
  store { i8**, i64 }* %t322, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t323 = load i8*, i8** %l14
  %s324 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.324, i32 0, i32 0
  %t325 = call i1 @starts_with(i8* %t323, i8* %s324)
  %t326 = load i8*, i8** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t330 = load i8*, i8** %l4
  %t331 = load i1, i1* %l5
  %t332 = load i1, i1* %l6
  %t333 = load i1, i1* %l7
  %t334 = load i1, i1* %l8
  %t335 = load double, double* %l9
  %t336 = load double, double* %l10
  %t337 = load double, double* %l11
  %t338 = load double, double* %l12
  %t339 = load double, double* %l13
  %t340 = load i8*, i8** %l14
  br i1 %t325, label %then30, label %else31
then30:
  %t341 = load i8*, i8** %l14
  %t342 = load i8*, i8** %l14
  %t343 = call i64 @sailfin_runtime_string_length(i8* %t342)
  %t344 = call i8* @sailfin_runtime_substring(i8* %t341, i64 6, i64 %t343)
  store i8* %t344, i8** %l21
  %t345 = load i8*, i8** %l21
  %t346 = call %NumberParseResult @parse_decimal_number(i8* %t345)
  store %NumberParseResult %t346, %NumberParseResult* %l22
  %t347 = load %NumberParseResult, %NumberParseResult* %l22
  %t348 = extractvalue %NumberParseResult %t347, 0
  %t349 = load i8*, i8** %l0
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t351 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t353 = load i8*, i8** %l4
  %t354 = load i1, i1* %l5
  %t355 = load i1, i1* %l6
  %t356 = load i1, i1* %l7
  %t357 = load i1, i1* %l8
  %t358 = load double, double* %l9
  %t359 = load double, double* %l10
  %t360 = load double, double* %l11
  %t361 = load double, double* %l12
  %t362 = load double, double* %l13
  %t363 = load i8*, i8** %l14
  %t364 = load i8*, i8** %l21
  %t365 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t348, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t366 = load %NumberParseResult, %NumberParseResult* %l22
  %t367 = extractvalue %NumberParseResult %t366, 1
  store double %t367, double* %l12
  br label %merge35
else34:
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s369 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.369, i32 0, i32 0
  %t370 = add i8* %s369, %enum_name
  %s371 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.371, i32 0, i32 0
  %t372 = add i8* %t370, %s371
  %t373 = load i8*, i8** %l4
  %t374 = add i8* %t372, %t373
  %s375 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.375, i32 0, i32 0
  %t376 = add i8* %t374, %s375
  %t377 = load i8*, i8** %l21
  %t378 = add i8* %t376, %t377
  %t379 = getelementptr i8, i8* %t378, i64 0
  %t380 = load i8, i8* %t379
  %t381 = add i8 %t380, 96
  %t382 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t368, i8* null)
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t383 = phi i1 [ 1, %then33 ], [ %t357, %else34 ]
  %t384 = phi double [ %t367, %then33 ], [ %t361, %else34 ]
  %t385 = phi { i8**, i64 }* [ %t350, %then33 ], [ %t382, %else34 ]
  store i1 %t383, i1* %l8
  store double %t384, double* %l12
  store { i8**, i64 }* %t385, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s387 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.387, i32 0, i32 0
  %t388 = add i8* %s387, %enum_name
  %s389 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.389, i32 0, i32 0
  %t390 = add i8* %t388, %s389
  %t391 = load i8*, i8** %l4
  %t392 = add i8* %t390, %t391
  %s393 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.393, i32 0, i32 0
  %t394 = add i8* %t392, %s393
  %t395 = load i8*, i8** %l14
  %t396 = add i8* %t394, %t395
  %t397 = getelementptr i8, i8* %t396, i64 0
  %t398 = load i8, i8* %t397
  %t399 = add i8 %t398, 96
  %t400 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t386, i8* null)
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t401 = phi i1 [ 1, %then30 ], [ %t334, %else31 ]
  %t402 = phi double [ %t367, %then30 ], [ %t338, %else31 ]
  %t403 = phi { i8**, i64 }* [ %t382, %then30 ], [ %t400, %else31 ]
  store i1 %t401, i1* %l8
  store double %t402, double* %l12
  store { i8**, i64 }* %t403, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t404 = phi i1 [ 1, %then24 ], [ %t270, %else25 ]
  %t405 = phi double [ %t304, %then24 ], [ %t274, %else25 ]
  %t406 = phi { i8**, i64 }* [ %t319, %then24 ], [ %t382, %else25 ]
  %t407 = phi i1 [ %t271, %then24 ], [ 1, %else25 ]
  %t408 = phi double [ %t275, %then24 ], [ %t367, %else25 ]
  store i1 %t404, i1* %l7
  store double %t405, double* %l11
  store { i8**, i64 }* %t406, { i8**, i64 }** %l1
  store i1 %t407, i1* %l8
  store double %t408, double* %l12
  br label %merge20
merge20:
  %t409 = phi i1 [ 1, %then18 ], [ %t206, %else19 ]
  %t410 = phi double [ %t241, %then18 ], [ %t210, %else19 ]
  %t411 = phi { i8**, i64 }* [ %t256, %then18 ], [ %t319, %else19 ]
  %t412 = phi i1 [ %t207, %then18 ], [ 1, %else19 ]
  %t413 = phi double [ %t211, %then18 ], [ %t304, %else19 ]
  %t414 = phi i1 [ %t208, %then18 ], [ 1, %else19 ]
  %t415 = phi double [ %t212, %then18 ], [ %t367, %else19 ]
  store i1 %t409, i1* %l6
  store double %t410, double* %l10
  store { i8**, i64 }* %t411, { i8**, i64 }** %l1
  store i1 %t412, i1* %l7
  store double %t413, double* %l11
  store i1 %t414, i1* %l8
  store double %t415, double* %l12
  br label %merge14
merge14:
  %t416 = phi i1 [ 1, %then12 ], [ %t142, %else13 ]
  %t417 = phi double [ %t178, %then12 ], [ %t146, %else13 ]
  %t418 = phi { i8**, i64 }* [ %t193, %then12 ], [ %t256, %else13 ]
  %t419 = phi i1 [ %t143, %then12 ], [ 1, %else13 ]
  %t420 = phi double [ %t147, %then12 ], [ %t241, %else13 ]
  %t421 = phi i1 [ %t144, %then12 ], [ 1, %else13 ]
  %t422 = phi double [ %t148, %then12 ], [ %t304, %else13 ]
  %t423 = phi i1 [ %t145, %then12 ], [ 1, %else13 ]
  %t424 = phi double [ %t149, %then12 ], [ %t367, %else13 ]
  store i1 %t416, i1* %l5
  store double %t417, double* %l9
  store { i8**, i64 }* %t418, { i8**, i64 }** %l1
  store i1 %t419, i1* %l6
  store double %t420, double* %l10
  store i1 %t421, i1* %l7
  store double %t422, double* %l11
  store i1 %t423, i1* %l8
  store double %t424, double* %l12
  %t425 = load double, double* %l13
  %t426 = sitofp i64 1 to double
  %t427 = fadd double %t425, %t426
  store double %t427, double* %l13
  br label %loop.latch8
loop.latch8:
  %t428 = load i1, i1* %l5
  %t429 = load double, double* %l9
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t431 = load i1, i1* %l6
  %t432 = load double, double* %l10
  %t433 = load i1, i1* %l7
  %t434 = load double, double* %l11
  %t435 = load i1, i1* %l8
  %t436 = load double, double* %l12
  %t437 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t448 = load i1, i1* %l5
  %t449 = xor i1 %t448, 1
  %t450 = load i8*, i8** %l0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t452 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t454 = load i8*, i8** %l4
  %t455 = load i1, i1* %l5
  %t456 = load i1, i1* %l6
  %t457 = load i1, i1* %l7
  %t458 = load i1, i1* %l8
  %t459 = load double, double* %l9
  %t460 = load double, double* %l10
  %t461 = load double, double* %l11
  %t462 = load double, double* %l12
  %t463 = load double, double* %l13
  br i1 %t449, label %then36, label %merge37
then36:
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s465 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.465, i32 0, i32 0
  %t466 = add i8* %s465, %enum_name
  %s467 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.467, i32 0, i32 0
  %t468 = add i8* %t466, %s467
  %t469 = load i8*, i8** %l4
  %t470 = add i8* %t468, %t469
  %s471 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.471, i32 0, i32 0
  %t472 = add i8* %t470, %s471
  %t473 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t464, i8* %t472)
  store { i8**, i64 }* %t473, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t474 = phi { i8**, i64 }* [ %t473, %then36 ], [ %t451, %entry ]
  store { i8**, i64 }* %t474, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l6
  %t476 = xor i1 %t475, 1
  %t477 = load i8*, i8** %l0
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t479 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t481 = load i8*, i8** %l4
  %t482 = load i1, i1* %l5
  %t483 = load i1, i1* %l6
  %t484 = load i1, i1* %l7
  %t485 = load i1, i1* %l8
  %t486 = load double, double* %l9
  %t487 = load double, double* %l10
  %t488 = load double, double* %l11
  %t489 = load double, double* %l12
  %t490 = load double, double* %l13
  br i1 %t476, label %then38, label %merge39
then38:
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s492 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.492, i32 0, i32 0
  %t493 = add i8* %s492, %enum_name
  %s494 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.494, i32 0, i32 0
  %t495 = add i8* %t493, %s494
  %t496 = load i8*, i8** %l4
  %t497 = add i8* %t495, %t496
  %s498 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.498, i32 0, i32 0
  %t499 = add i8* %t497, %s498
  %t500 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t491, i8* %t499)
  store { i8**, i64 }* %t500, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t501 = phi { i8**, i64 }* [ %t500, %then38 ], [ %t478, %entry ]
  store { i8**, i64 }* %t501, { i8**, i64 }** %l1
  %t502 = load i1, i1* %l7
  %t503 = xor i1 %t502, 1
  %t504 = load i8*, i8** %l0
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t506 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t508 = load i8*, i8** %l4
  %t509 = load i1, i1* %l5
  %t510 = load i1, i1* %l6
  %t511 = load i1, i1* %l7
  %t512 = load i1, i1* %l8
  %t513 = load double, double* %l9
  %t514 = load double, double* %l10
  %t515 = load double, double* %l11
  %t516 = load double, double* %l12
  %t517 = load double, double* %l13
  br i1 %t503, label %then40, label %merge41
then40:
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s519 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.519, i32 0, i32 0
  %t520 = add i8* %s519, %enum_name
  %s521 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.521, i32 0, i32 0
  %t522 = add i8* %t520, %s521
  %t523 = load i8*, i8** %l4
  %t524 = add i8* %t522, %t523
  %s525 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.525, i32 0, i32 0
  %t526 = add i8* %t524, %s525
  %t527 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t518, i8* %t526)
  store { i8**, i64 }* %t527, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t528 = phi { i8**, i64 }* [ %t527, %then40 ], [ %t505, %entry ]
  store { i8**, i64 }* %t528, { i8**, i64 }** %l1
  %t529 = load i1, i1* %l8
  %t530 = xor i1 %t529, 1
  %t531 = load i8*, i8** %l0
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t533 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t535 = load i8*, i8** %l4
  %t536 = load i1, i1* %l5
  %t537 = load i1, i1* %l6
  %t538 = load i1, i1* %l7
  %t539 = load i1, i1* %l8
  %t540 = load double, double* %l9
  %t541 = load double, double* %l10
  %t542 = load double, double* %l11
  %t543 = load double, double* %l12
  %t544 = load double, double* %l13
  br i1 %t530, label %then42, label %merge43
then42:
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s546 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.546, i32 0, i32 0
  %t547 = add i8* %s546, %enum_name
  %s548 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.548, i32 0, i32 0
  %t549 = add i8* %t547, %s548
  %t550 = load i8*, i8** %l4
  %t551 = add i8* %t549, %t550
  %s552 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.552, i32 0, i32 0
  %t553 = add i8* %t551, %s552
  %t554 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t545, i8* %t553)
  store { i8**, i64 }* %t554, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t555 = phi { i8**, i64 }* [ %t554, %then42 ], [ %t532, %entry ]
  store { i8**, i64 }* %t555, { i8**, i64 }** %l1
  %t560 = load i1, i1* %l5
  br label %logical_and_entry_559

logical_and_entry_559:
  br i1 %t560, label %logical_and_right_559, label %logical_and_merge_559

logical_and_right_559:
  %t561 = load i1, i1* %l6
  br label %logical_and_right_end_559

logical_and_right_end_559:
  br label %logical_and_merge_559

logical_and_merge_559:
  %t562 = phi i1 [ false, %logical_and_entry_559 ], [ %t561, %logical_and_right_end_559 ]
  br label %logical_and_entry_558

logical_and_entry_558:
  br i1 %t562, label %logical_and_right_558, label %logical_and_merge_558

logical_and_right_558:
  %t563 = load i1, i1* %l7
  br label %logical_and_right_end_558

logical_and_right_end_558:
  br label %logical_and_merge_558

logical_and_merge_558:
  %t564 = phi i1 [ false, %logical_and_entry_558 ], [ %t563, %logical_and_right_end_558 ]
  br label %logical_and_entry_557

logical_and_entry_557:
  br i1 %t564, label %logical_and_right_557, label %logical_and_merge_557

logical_and_right_557:
  %t565 = load i1, i1* %l8
  br label %logical_and_right_end_557

logical_and_right_end_557:
  br label %logical_and_merge_557

logical_and_merge_557:
  %t566 = phi i1 [ false, %logical_and_entry_557 ], [ %t565, %logical_and_right_end_557 ]
  br label %logical_and_entry_556

logical_and_entry_556:
  br i1 %t566, label %logical_and_right_556, label %logical_and_merge_556

logical_and_right_556:
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t568 = load { i8**, i64 }, { i8**, i64 }* %t567
  %t569 = extractvalue { i8**, i64 } %t568, 1
  %t570 = icmp eq i64 %t569, 0
  br label %logical_and_right_end_556

logical_and_right_end_556:
  br label %logical_and_merge_556

logical_and_merge_556:
  %t571 = phi i1 [ false, %logical_and_entry_556 ], [ %t570, %logical_and_right_end_556 ]
  store i1 %t571, i1* %l23
  %t572 = load i8*, i8** %l4
  %t573 = insertvalue %NativeEnumVariantLayout undef, i8* %t572, 0
  %t574 = load double, double* %l9
  %t575 = insertvalue %NativeEnumVariantLayout %t573, double %t574, 1
  %t576 = load double, double* %l10
  %t577 = insertvalue %NativeEnumVariantLayout %t575, double %t576, 2
  %t578 = load double, double* %l11
  %t579 = insertvalue %NativeEnumVariantLayout %t577, double %t578, 3
  %t580 = load double, double* %l12
  %t581 = insertvalue %NativeEnumVariantLayout %t579, double %t580, 4
  %t582 = alloca [0 x i8*]
  %t583 = getelementptr [0 x i8*], [0 x i8*]* %t582, i32 0, i32 0
  %t584 = alloca { i8**, i64 }
  %t585 = getelementptr { i8**, i64 }, { i8**, i64 }* %t584, i32 0, i32 0
  store i8** %t583, i8*** %t585
  %t586 = getelementptr { i8**, i64 }, { i8**, i64 }* %t584, i32 0, i32 1
  store i64 0, i64* %t586
  %t587 = insertvalue %NativeEnumVariantLayout %t581, { i8**, i64 }* %t584, 5
  store %NativeEnumVariantLayout %t587, %NativeEnumVariantLayout* %l24
  %t588 = load i1, i1* %l23
  %t589 = insertvalue %EnumLayoutVariantParse undef, i1 %t588, 0
  %t590 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t591 = insertvalue %EnumLayoutVariantParse %t589, i8* null, 1
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = insertvalue %EnumLayoutVariantParse %t591, { i8**, i64 }* %t592, 2
  ret %EnumLayoutVariantParse %t593
}

define %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i1
  %l10 = alloca i1
  %l11 = alloca i1
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %l24 = alloca %NativeStructLayoutField
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  %t7 = insertvalue %NativeStructLayoutField undef, i8* %s6, 0
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  %t9 = insertvalue %NativeStructLayoutField %t7, i8* %s8, 1
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %NativeStructLayoutField %t9, double %t10, 2
  %t12 = sitofp i64 0 to double
  %t13 = insertvalue %NativeStructLayoutField %t11, double %t12, 3
  %t14 = sitofp i64 0 to double
  %t15 = insertvalue %NativeStructLayoutField %t13, double %t14, 4
  store %NativeStructLayoutField %t15, %NativeStructLayoutField* %l2
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.23, i32 0, i32 0
  %t24 = add i8* %s23, %enum_name
  %s25 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.25, i32 0, i32 0
  %t26 = add i8* %t24, %s25
  %t27 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s29 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.29, i32 0, i32 0
  %t30 = insertvalue %EnumLayoutPayloadParse %t28, i8* %s29, 1
  %t31 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t32 = insertvalue %EnumLayoutPayloadParse %t30, i8* null, 2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = insertvalue %EnumLayoutPayloadParse %t32, { i8**, i64 }* %t33, 3
  ret %EnumLayoutPayloadParse %t34
merge1:
  %t35 = load i8*, i8** %l0
  %t36 = call { i8**, i64 }* @split_whitespace(i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = icmp eq i64 %t39, 0
  %t41 = load i8*, i8** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t40, label %then2, label %merge3
then2:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s46 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.46, i32 0, i32 0
  %t47 = add i8* %s46, %enum_name
  %s48 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.48, i32 0, i32 0
  %t49 = add i8* %t47, %s48
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t45, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l1
  %t51 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s52 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.52, i32 0, i32 0
  %t53 = insertvalue %EnumLayoutPayloadParse %t51, i8* %s52, 1
  %t54 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t55 = insertvalue %EnumLayoutPayloadParse %t53, i8* null, 2
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = insertvalue %EnumLayoutPayloadParse %t55, { i8**, i64 }* %t56, 3
  ret %EnumLayoutPayloadParse %t57
merge3:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 0, %t61
  ; bounds check: %t62 (if true, out of bounds)
  %t63 = getelementptr i8*, i8** %t60, i64 0
  %t64 = load i8*, i8** %t63
  store i8* %t64, i8** %l4
  %t65 = load i8*, i8** %l4
  %t66 = call double @index_of(i8* %t65, i8* null)
  store double %t66, double* %l5
  %t68 = load double, double* %l5
  %t69 = sitofp i64 0 to double
  %t70 = fcmp ole double %t68, %t69
  br label %logical_or_entry_67

logical_or_entry_67:
  br i1 %t70, label %logical_or_merge_67, label %logical_or_right_67

logical_or_right_67:
  %t71 = load double, double* %l5
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  %t74 = load i8*, i8** %l4
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = sitofp i64 %t75 to double
  %t77 = fcmp oge double %t73, %t76
  br label %logical_or_right_end_67

logical_or_right_end_67:
  br label %logical_or_merge_67

logical_or_merge_67:
  %t78 = phi i1 [ true, %logical_or_entry_67 ], [ %t77, %logical_or_right_end_67 ]
  %t79 = load i8*, i8** %l0
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t83 = load i8*, i8** %l4
  %t84 = load double, double* %l5
  br i1 %t78, label %then4, label %merge5
then4:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s86 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.86, i32 0, i32 0
  %t87 = add i8* %s86, %enum_name
  %s88 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.88, i32 0, i32 0
  %t89 = add i8* %t87, %s88
  %t90 = load i8*, i8** %l4
  %t91 = add i8* %t89, %t90
  %s92 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.92, i32 0, i32 0
  %t93 = add i8* %t91, %s92
  %t94 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t85, i8* %t93)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l1
  %t95 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s96 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.96, i32 0, i32 0
  %t97 = insertvalue %EnumLayoutPayloadParse %t95, i8* %s96, 1
  %t98 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t99 = insertvalue %EnumLayoutPayloadParse %t97, i8* null, 2
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = insertvalue %EnumLayoutPayloadParse %t99, { i8**, i64 }* %t100, 3
  ret %EnumLayoutPayloadParse %t101
merge5:
  %t102 = load i8*, i8** %l4
  %t103 = load double, double* %l5
  %t104 = fptosi double %t103 to i64
  %t105 = call i8* @sailfin_runtime_substring(i8* %t102, i64 0, i64 %t104)
  store i8* %t105, i8** %l6
  %t106 = load i8*, i8** %l4
  %t107 = load double, double* %l5
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  %t110 = load i8*, i8** %l4
  %t111 = call i64 @sailfin_runtime_string_length(i8* %t110)
  %t112 = fptosi double %t109 to i64
  %t113 = call i8* @sailfin_runtime_substring(i8* %t106, i64 %t112, i64 %t111)
  store i8* %t113, i8** %l7
  %s114 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.114, i32 0, i32 0
  store i8* %s114, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t115 = sitofp i64 0 to double
  store double %t115, double* %l12
  %t116 = sitofp i64 0 to double
  store double %t116, double* %l13
  %t117 = sitofp i64 0 to double
  store double %t117, double* %l14
  %t118 = sitofp i64 1 to double
  store double %t118, double* %l15
  %t119 = load i8*, i8** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t123 = load i8*, i8** %l4
  %t124 = load double, double* %l5
  %t125 = load i8*, i8** %l6
  %t126 = load i8*, i8** %l7
  %t127 = load i8*, i8** %l8
  %t128 = load i1, i1* %l9
  %t129 = load i1, i1* %l10
  %t130 = load i1, i1* %l11
  %t131 = load double, double* %l12
  %t132 = load double, double* %l13
  %t133 = load double, double* %l14
  %t134 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t441 = phi i8* [ %t127, %entry ], [ %t432, %loop.latch8 ]
  %t442 = phi i1 [ %t128, %entry ], [ %t433, %loop.latch8 ]
  %t443 = phi double [ %t131, %entry ], [ %t434, %loop.latch8 ]
  %t444 = phi { i8**, i64 }* [ %t120, %entry ], [ %t435, %loop.latch8 ]
  %t445 = phi i1 [ %t129, %entry ], [ %t436, %loop.latch8 ]
  %t446 = phi double [ %t132, %entry ], [ %t437, %loop.latch8 ]
  %t447 = phi i1 [ %t130, %entry ], [ %t438, %loop.latch8 ]
  %t448 = phi double [ %t133, %entry ], [ %t439, %loop.latch8 ]
  %t449 = phi double [ %t134, %entry ], [ %t440, %loop.latch8 ]
  store i8* %t441, i8** %l8
  store i1 %t442, i1* %l9
  store double %t443, double* %l12
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  store i1 %t445, i1* %l10
  store double %t446, double* %l13
  store i1 %t447, i1* %l11
  store double %t448, double* %l14
  store double %t449, double* %l15
  br label %loop.body7
loop.body7:
  %t135 = load double, double* %l15
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t137 = load { i8**, i64 }, { i8**, i64 }* %t136
  %t138 = extractvalue { i8**, i64 } %t137, 1
  %t139 = sitofp i64 %t138 to double
  %t140 = fcmp oge double %t135, %t139
  %t141 = load i8*, i8** %l0
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t143 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t145 = load i8*, i8** %l4
  %t146 = load double, double* %l5
  %t147 = load i8*, i8** %l6
  %t148 = load i8*, i8** %l7
  %t149 = load i8*, i8** %l8
  %t150 = load i1, i1* %l9
  %t151 = load i1, i1* %l10
  %t152 = load i1, i1* %l11
  %t153 = load double, double* %l12
  %t154 = load double, double* %l13
  %t155 = load double, double* %l14
  %t156 = load double, double* %l15
  br i1 %t140, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t158 = load double, double* %l15
  %t159 = fptosi double %t158 to i64
  %t160 = load { i8**, i64 }, { i8**, i64 }* %t157
  %t161 = extractvalue { i8**, i64 } %t160, 0
  %t162 = extractvalue { i8**, i64 } %t160, 1
  %t163 = icmp uge i64 %t159, %t162
  ; bounds check: %t163 (if true, out of bounds)
  %t164 = getelementptr i8*, i8** %t161, i64 %t159
  %t165 = load i8*, i8** %t164
  store i8* %t165, i8** %l16
  %t166 = load i8*, i8** %l16
  %s167 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.167, i32 0, i32 0
  %t168 = call i1 @starts_with(i8* %t166, i8* %s167)
  %t169 = load i8*, i8** %l0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t173 = load i8*, i8** %l4
  %t174 = load double, double* %l5
  %t175 = load i8*, i8** %l6
  %t176 = load i8*, i8** %l7
  %t177 = load i8*, i8** %l8
  %t178 = load i1, i1* %l9
  %t179 = load i1, i1* %l10
  %t180 = load i1, i1* %l11
  %t181 = load double, double* %l12
  %t182 = load double, double* %l13
  %t183 = load double, double* %l14
  %t184 = load double, double* %l15
  %t185 = load i8*, i8** %l16
  br i1 %t168, label %then12, label %else13
then12:
  %t186 = load i8*, i8** %l16
  %t187 = load i8*, i8** %l16
  %t188 = call i64 @sailfin_runtime_string_length(i8* %t187)
  %t189 = call i8* @sailfin_runtime_substring(i8* %t186, i64 5, i64 %t188)
  store i8* %t189, i8** %l8
  br label %merge14
else13:
  %t190 = load i8*, i8** %l16
  %s191 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.191, i32 0, i32 0
  %t192 = call i1 @starts_with(i8* %t190, i8* %s191)
  %t193 = load i8*, i8** %l0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t197 = load i8*, i8** %l4
  %t198 = load double, double* %l5
  %t199 = load i8*, i8** %l6
  %t200 = load i8*, i8** %l7
  %t201 = load i8*, i8** %l8
  %t202 = load i1, i1* %l9
  %t203 = load i1, i1* %l10
  %t204 = load i1, i1* %l11
  %t205 = load double, double* %l12
  %t206 = load double, double* %l13
  %t207 = load double, double* %l14
  %t208 = load double, double* %l15
  %t209 = load i8*, i8** %l16
  br i1 %t192, label %then15, label %else16
then15:
  %t210 = load i8*, i8** %l16
  %t211 = load i8*, i8** %l16
  %t212 = call i64 @sailfin_runtime_string_length(i8* %t211)
  %t213 = call i8* @sailfin_runtime_substring(i8* %t210, i64 7, i64 %t212)
  store i8* %t213, i8** %l17
  %t214 = load i8*, i8** %l17
  %t215 = call %NumberParseResult @parse_decimal_number(i8* %t214)
  store %NumberParseResult %t215, %NumberParseResult* %l18
  %t216 = load %NumberParseResult, %NumberParseResult* %l18
  %t217 = extractvalue %NumberParseResult %t216, 0
  %t218 = load i8*, i8** %l0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t222 = load i8*, i8** %l4
  %t223 = load double, double* %l5
  %t224 = load i8*, i8** %l6
  %t225 = load i8*, i8** %l7
  %t226 = load i8*, i8** %l8
  %t227 = load i1, i1* %l9
  %t228 = load i1, i1* %l10
  %t229 = load i1, i1* %l11
  %t230 = load double, double* %l12
  %t231 = load double, double* %l13
  %t232 = load double, double* %l14
  %t233 = load double, double* %l15
  %t234 = load i8*, i8** %l16
  %t235 = load i8*, i8** %l17
  %t236 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t217, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t237 = load %NumberParseResult, %NumberParseResult* %l18
  %t238 = extractvalue %NumberParseResult %t237, 1
  store double %t238, double* %l12
  br label %merge20
else19:
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s240 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.240, i32 0, i32 0
  %t241 = add i8* %s240, %enum_name
  %s242 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.242, i32 0, i32 0
  %t243 = add i8* %t241, %s242
  %t244 = load i8*, i8** %l4
  %t245 = add i8* %t243, %t244
  %s246 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.246, i32 0, i32 0
  %t247 = add i8* %t245, %s246
  %t248 = load i8*, i8** %l17
  %t249 = add i8* %t247, %t248
  %t250 = getelementptr i8, i8* %t249, i64 0
  %t251 = load i8, i8* %t250
  %t252 = add i8 %t251, 96
  %t253 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t239, i8* null)
  store { i8**, i64 }* %t253, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t254 = phi i1 [ 1, %then18 ], [ %t227, %else19 ]
  %t255 = phi double [ %t238, %then18 ], [ %t230, %else19 ]
  %t256 = phi { i8**, i64 }* [ %t219, %then18 ], [ %t253, %else19 ]
  store i1 %t254, i1* %l9
  store double %t255, double* %l12
  store { i8**, i64 }* %t256, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t257 = load i8*, i8** %l16
  %s258 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.258, i32 0, i32 0
  %t259 = call i1 @starts_with(i8* %t257, i8* %s258)
  %t260 = load i8*, i8** %l0
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t262 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t264 = load i8*, i8** %l4
  %t265 = load double, double* %l5
  %t266 = load i8*, i8** %l6
  %t267 = load i8*, i8** %l7
  %t268 = load i8*, i8** %l8
  %t269 = load i1, i1* %l9
  %t270 = load i1, i1* %l10
  %t271 = load i1, i1* %l11
  %t272 = load double, double* %l12
  %t273 = load double, double* %l13
  %t274 = load double, double* %l14
  %t275 = load double, double* %l15
  %t276 = load i8*, i8** %l16
  br i1 %t259, label %then21, label %else22
then21:
  %t277 = load i8*, i8** %l16
  %t278 = load i8*, i8** %l16
  %t279 = call i64 @sailfin_runtime_string_length(i8* %t278)
  %t280 = call i8* @sailfin_runtime_substring(i8* %t277, i64 5, i64 %t279)
  store i8* %t280, i8** %l19
  %t281 = load i8*, i8** %l19
  %t282 = call %NumberParseResult @parse_decimal_number(i8* %t281)
  store %NumberParseResult %t282, %NumberParseResult* %l20
  %t283 = load %NumberParseResult, %NumberParseResult* %l20
  %t284 = extractvalue %NumberParseResult %t283, 0
  %t285 = load i8*, i8** %l0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t287 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t289 = load i8*, i8** %l4
  %t290 = load double, double* %l5
  %t291 = load i8*, i8** %l6
  %t292 = load i8*, i8** %l7
  %t293 = load i8*, i8** %l8
  %t294 = load i1, i1* %l9
  %t295 = load i1, i1* %l10
  %t296 = load i1, i1* %l11
  %t297 = load double, double* %l12
  %t298 = load double, double* %l13
  %t299 = load double, double* %l14
  %t300 = load double, double* %l15
  %t301 = load i8*, i8** %l16
  %t302 = load i8*, i8** %l19
  %t303 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t284, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t304 = load %NumberParseResult, %NumberParseResult* %l20
  %t305 = extractvalue %NumberParseResult %t304, 1
  store double %t305, double* %l13
  br label %merge26
else25:
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s307 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.307, i32 0, i32 0
  %t308 = add i8* %s307, %enum_name
  %s309 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.309, i32 0, i32 0
  %t310 = add i8* %t308, %s309
  %t311 = load i8*, i8** %l4
  %t312 = add i8* %t310, %t311
  %s313 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.313, i32 0, i32 0
  %t314 = add i8* %t312, %s313
  %t315 = load i8*, i8** %l19
  %t316 = add i8* %t314, %t315
  %t317 = getelementptr i8, i8* %t316, i64 0
  %t318 = load i8, i8* %t317
  %t319 = add i8 %t318, 96
  %t320 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t306, i8* null)
  store { i8**, i64 }* %t320, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t321 = phi i1 [ 1, %then24 ], [ %t295, %else25 ]
  %t322 = phi double [ %t305, %then24 ], [ %t298, %else25 ]
  %t323 = phi { i8**, i64 }* [ %t286, %then24 ], [ %t320, %else25 ]
  store i1 %t321, i1* %l10
  store double %t322, double* %l13
  store { i8**, i64 }* %t323, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t324 = load i8*, i8** %l16
  %s325 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.325, i32 0, i32 0
  %t326 = call i1 @starts_with(i8* %t324, i8* %s325)
  %t327 = load i8*, i8** %l0
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t329 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t331 = load i8*, i8** %l4
  %t332 = load double, double* %l5
  %t333 = load i8*, i8** %l6
  %t334 = load i8*, i8** %l7
  %t335 = load i8*, i8** %l8
  %t336 = load i1, i1* %l9
  %t337 = load i1, i1* %l10
  %t338 = load i1, i1* %l11
  %t339 = load double, double* %l12
  %t340 = load double, double* %l13
  %t341 = load double, double* %l14
  %t342 = load double, double* %l15
  %t343 = load i8*, i8** %l16
  br i1 %t326, label %then27, label %else28
then27:
  %t344 = load i8*, i8** %l16
  %t345 = load i8*, i8** %l16
  %t346 = call i64 @sailfin_runtime_string_length(i8* %t345)
  %t347 = call i8* @sailfin_runtime_substring(i8* %t344, i64 6, i64 %t346)
  store i8* %t347, i8** %l21
  %t348 = load i8*, i8** %l21
  %t349 = call %NumberParseResult @parse_decimal_number(i8* %t348)
  store %NumberParseResult %t349, %NumberParseResult* %l22
  %t350 = load %NumberParseResult, %NumberParseResult* %l22
  %t351 = extractvalue %NumberParseResult %t350, 0
  %t352 = load i8*, i8** %l0
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t354 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t356 = load i8*, i8** %l4
  %t357 = load double, double* %l5
  %t358 = load i8*, i8** %l6
  %t359 = load i8*, i8** %l7
  %t360 = load i8*, i8** %l8
  %t361 = load i1, i1* %l9
  %t362 = load i1, i1* %l10
  %t363 = load i1, i1* %l11
  %t364 = load double, double* %l12
  %t365 = load double, double* %l13
  %t366 = load double, double* %l14
  %t367 = load double, double* %l15
  %t368 = load i8*, i8** %l16
  %t369 = load i8*, i8** %l21
  %t370 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t351, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t371 = load %NumberParseResult, %NumberParseResult* %l22
  %t372 = extractvalue %NumberParseResult %t371, 1
  store double %t372, double* %l14
  br label %merge32
else31:
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s374 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.374, i32 0, i32 0
  %t375 = add i8* %s374, %enum_name
  %s376 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.376, i32 0, i32 0
  %t377 = add i8* %t375, %s376
  %t378 = load i8*, i8** %l4
  %t379 = add i8* %t377, %t378
  %s380 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.380, i32 0, i32 0
  %t381 = add i8* %t379, %s380
  %t382 = load i8*, i8** %l21
  %t383 = add i8* %t381, %t382
  %t384 = getelementptr i8, i8* %t383, i64 0
  %t385 = load i8, i8* %t384
  %t386 = add i8 %t385, 96
  %t387 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t373, i8* null)
  store { i8**, i64 }* %t387, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t388 = phi i1 [ 1, %then30 ], [ %t363, %else31 ]
  %t389 = phi double [ %t372, %then30 ], [ %t366, %else31 ]
  %t390 = phi { i8**, i64 }* [ %t353, %then30 ], [ %t387, %else31 ]
  store i1 %t388, i1* %l11
  store double %t389, double* %l14
  store { i8**, i64 }* %t390, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s392 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.392, i32 0, i32 0
  %t393 = add i8* %s392, %enum_name
  %s394 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.394, i32 0, i32 0
  %t395 = add i8* %t393, %s394
  %t396 = load i8*, i8** %l4
  %t397 = add i8* %t395, %t396
  %s398 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.398, i32 0, i32 0
  %t399 = add i8* %t397, %s398
  %t400 = load i8*, i8** %l16
  %t401 = add i8* %t399, %t400
  %t402 = getelementptr i8, i8* %t401, i64 0
  %t403 = load i8, i8* %t402
  %t404 = add i8 %t403, 96
  %t405 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t391, i8* null)
  store { i8**, i64 }* %t405, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t406 = phi i1 [ 1, %then27 ], [ %t338, %else28 ]
  %t407 = phi double [ %t372, %then27 ], [ %t341, %else28 ]
  %t408 = phi { i8**, i64 }* [ %t387, %then27 ], [ %t405, %else28 ]
  store i1 %t406, i1* %l11
  store double %t407, double* %l14
  store { i8**, i64 }* %t408, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t409 = phi i1 [ 1, %then21 ], [ %t270, %else22 ]
  %t410 = phi double [ %t305, %then21 ], [ %t273, %else22 ]
  %t411 = phi { i8**, i64 }* [ %t320, %then21 ], [ %t387, %else22 ]
  %t412 = phi i1 [ %t271, %then21 ], [ 1, %else22 ]
  %t413 = phi double [ %t274, %then21 ], [ %t372, %else22 ]
  store i1 %t409, i1* %l10
  store double %t410, double* %l13
  store { i8**, i64 }* %t411, { i8**, i64 }** %l1
  store i1 %t412, i1* %l11
  store double %t413, double* %l14
  br label %merge17
merge17:
  %t414 = phi i1 [ 1, %then15 ], [ %t202, %else16 ]
  %t415 = phi double [ %t238, %then15 ], [ %t205, %else16 ]
  %t416 = phi { i8**, i64 }* [ %t253, %then15 ], [ %t320, %else16 ]
  %t417 = phi i1 [ %t203, %then15 ], [ 1, %else16 ]
  %t418 = phi double [ %t206, %then15 ], [ %t305, %else16 ]
  %t419 = phi i1 [ %t204, %then15 ], [ 1, %else16 ]
  %t420 = phi double [ %t207, %then15 ], [ %t372, %else16 ]
  store i1 %t414, i1* %l9
  store double %t415, double* %l12
  store { i8**, i64 }* %t416, { i8**, i64 }** %l1
  store i1 %t417, i1* %l10
  store double %t418, double* %l13
  store i1 %t419, i1* %l11
  store double %t420, double* %l14
  br label %merge14
merge14:
  %t421 = phi i8* [ %t189, %then12 ], [ %t177, %else13 ]
  %t422 = phi i1 [ %t178, %then12 ], [ 1, %else13 ]
  %t423 = phi double [ %t181, %then12 ], [ %t238, %else13 ]
  %t424 = phi { i8**, i64 }* [ %t170, %then12 ], [ %t253, %else13 ]
  %t425 = phi i1 [ %t179, %then12 ], [ 1, %else13 ]
  %t426 = phi double [ %t182, %then12 ], [ %t305, %else13 ]
  %t427 = phi i1 [ %t180, %then12 ], [ 1, %else13 ]
  %t428 = phi double [ %t183, %then12 ], [ %t372, %else13 ]
  store i8* %t421, i8** %l8
  store i1 %t422, i1* %l9
  store double %t423, double* %l12
  store { i8**, i64 }* %t424, { i8**, i64 }** %l1
  store i1 %t425, i1* %l10
  store double %t426, double* %l13
  store i1 %t427, i1* %l11
  store double %t428, double* %l14
  %t429 = load double, double* %l15
  %t430 = sitofp i64 1 to double
  %t431 = fadd double %t429, %t430
  store double %t431, double* %l15
  br label %loop.latch8
loop.latch8:
  %t432 = load i8*, i8** %l8
  %t433 = load i1, i1* %l9
  %t434 = load double, double* %l12
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t436 = load i1, i1* %l10
  %t437 = load double, double* %l13
  %t438 = load i1, i1* %l11
  %t439 = load double, double* %l14
  %t440 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t450 = load i8*, i8** %l8
  %t451 = call i64 @sailfin_runtime_string_length(i8* %t450)
  %t452 = icmp eq i64 %t451, 0
  %t453 = load i8*, i8** %l0
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t455 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t457 = load i8*, i8** %l4
  %t458 = load double, double* %l5
  %t459 = load i8*, i8** %l6
  %t460 = load i8*, i8** %l7
  %t461 = load i8*, i8** %l8
  %t462 = load i1, i1* %l9
  %t463 = load i1, i1* %l10
  %t464 = load i1, i1* %l11
  %t465 = load double, double* %l12
  %t466 = load double, double* %l13
  %t467 = load double, double* %l14
  %t468 = load double, double* %l15
  br i1 %t452, label %then33, label %merge34
then33:
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s470 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.470, i32 0, i32 0
  %t471 = add i8* %s470, %enum_name
  %s472 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.472, i32 0, i32 0
  %t473 = add i8* %t471, %s472
  %t474 = load i8*, i8** %l4
  %t475 = add i8* %t473, %t474
  %s476 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.476, i32 0, i32 0
  %t477 = add i8* %t475, %s476
  %t478 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t469, i8* %t477)
  store { i8**, i64 }* %t478, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t479 = phi { i8**, i64 }* [ %t478, %then33 ], [ %t454, %entry ]
  store { i8**, i64 }* %t479, { i8**, i64 }** %l1
  %t480 = load i1, i1* %l9
  %t481 = xor i1 %t480, 1
  %t482 = load i8*, i8** %l0
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t484 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t486 = load i8*, i8** %l4
  %t487 = load double, double* %l5
  %t488 = load i8*, i8** %l6
  %t489 = load i8*, i8** %l7
  %t490 = load i8*, i8** %l8
  %t491 = load i1, i1* %l9
  %t492 = load i1, i1* %l10
  %t493 = load i1, i1* %l11
  %t494 = load double, double* %l12
  %t495 = load double, double* %l13
  %t496 = load double, double* %l14
  %t497 = load double, double* %l15
  br i1 %t481, label %then35, label %merge36
then35:
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s499 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.499, i32 0, i32 0
  %t500 = add i8* %s499, %enum_name
  %s501 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.501, i32 0, i32 0
  %t502 = add i8* %t500, %s501
  %t503 = load i8*, i8** %l4
  %t504 = add i8* %t502, %t503
  %s505 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.505, i32 0, i32 0
  %t506 = add i8* %t504, %s505
  %t507 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t498, i8* %t506)
  store { i8**, i64 }* %t507, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t508 = phi { i8**, i64 }* [ %t507, %then35 ], [ %t483, %entry ]
  store { i8**, i64 }* %t508, { i8**, i64 }** %l1
  %t509 = load i1, i1* %l10
  %t510 = xor i1 %t509, 1
  %t511 = load i8*, i8** %l0
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t513 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t515 = load i8*, i8** %l4
  %t516 = load double, double* %l5
  %t517 = load i8*, i8** %l6
  %t518 = load i8*, i8** %l7
  %t519 = load i8*, i8** %l8
  %t520 = load i1, i1* %l9
  %t521 = load i1, i1* %l10
  %t522 = load i1, i1* %l11
  %t523 = load double, double* %l12
  %t524 = load double, double* %l13
  %t525 = load double, double* %l14
  %t526 = load double, double* %l15
  br i1 %t510, label %then37, label %merge38
then37:
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s528 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.528, i32 0, i32 0
  %t529 = add i8* %s528, %enum_name
  %s530 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.530, i32 0, i32 0
  %t531 = add i8* %t529, %s530
  %t532 = load i8*, i8** %l4
  %t533 = add i8* %t531, %t532
  %s534 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.534, i32 0, i32 0
  %t535 = add i8* %t533, %s534
  %t536 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t527, i8* %t535)
  store { i8**, i64 }* %t536, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t537 = phi { i8**, i64 }* [ %t536, %then37 ], [ %t512, %entry ]
  store { i8**, i64 }* %t537, { i8**, i64 }** %l1
  %t538 = load i1, i1* %l11
  %t539 = xor i1 %t538, 1
  %t540 = load i8*, i8** %l0
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t542 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t544 = load i8*, i8** %l4
  %t545 = load double, double* %l5
  %t546 = load i8*, i8** %l6
  %t547 = load i8*, i8** %l7
  %t548 = load i8*, i8** %l8
  %t549 = load i1, i1* %l9
  %t550 = load i1, i1* %l10
  %t551 = load i1, i1* %l11
  %t552 = load double, double* %l12
  %t553 = load double, double* %l13
  %t554 = load double, double* %l14
  %t555 = load double, double* %l15
  br i1 %t539, label %then39, label %merge40
then39:
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s557 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.557, i32 0, i32 0
  %t558 = add i8* %s557, %enum_name
  %s559 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.559, i32 0, i32 0
  %t560 = add i8* %t558, %s559
  %t561 = load i8*, i8** %l4
  %t562 = add i8* %t560, %t561
  %s563 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.563, i32 0, i32 0
  %t564 = add i8* %t562, %s563
  %t565 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t556, i8* %t564)
  store { i8**, i64 }* %t565, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t566 = phi { i8**, i64 }* [ %t565, %then39 ], [ %t541, %entry ]
  store { i8**, i64 }* %t566, { i8**, i64 }** %l1
  %t571 = load i8*, i8** %l8
  %t572 = call i64 @sailfin_runtime_string_length(i8* %t571)
  %t573 = icmp sgt i64 %t572, 0
  br label %logical_and_entry_570

logical_and_entry_570:
  br i1 %t573, label %logical_and_right_570, label %logical_and_merge_570

logical_and_right_570:
  %t574 = load i1, i1* %l9
  br label %logical_and_right_end_570

logical_and_right_end_570:
  br label %logical_and_merge_570

logical_and_merge_570:
  %t575 = phi i1 [ false, %logical_and_entry_570 ], [ %t574, %logical_and_right_end_570 ]
  br label %logical_and_entry_569

logical_and_entry_569:
  br i1 %t575, label %logical_and_right_569, label %logical_and_merge_569

logical_and_right_569:
  %t576 = load i1, i1* %l10
  br label %logical_and_right_end_569

logical_and_right_end_569:
  br label %logical_and_merge_569

logical_and_merge_569:
  %t577 = phi i1 [ false, %logical_and_entry_569 ], [ %t576, %logical_and_right_end_569 ]
  br label %logical_and_entry_568

logical_and_entry_568:
  br i1 %t577, label %logical_and_right_568, label %logical_and_merge_568

logical_and_right_568:
  %t578 = load i1, i1* %l11
  br label %logical_and_right_end_568

logical_and_right_end_568:
  br label %logical_and_merge_568

logical_and_merge_568:
  %t579 = phi i1 [ false, %logical_and_entry_568 ], [ %t578, %logical_and_right_end_568 ]
  br label %logical_and_entry_567

logical_and_entry_567:
  br i1 %t579, label %logical_and_right_567, label %logical_and_merge_567

logical_and_right_567:
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t581 = load { i8**, i64 }, { i8**, i64 }* %t580
  %t582 = extractvalue { i8**, i64 } %t581, 1
  %t583 = icmp eq i64 %t582, 0
  br label %logical_and_right_end_567

logical_and_right_end_567:
  br label %logical_and_merge_567

logical_and_merge_567:
  %t584 = phi i1 [ false, %logical_and_entry_567 ], [ %t583, %logical_and_right_end_567 ]
  store i1 %t584, i1* %l23
  %t585 = load i8*, i8** %l7
  %t586 = insertvalue %NativeStructLayoutField undef, i8* %t585, 0
  %t587 = load i8*, i8** %l8
  %t588 = insertvalue %NativeStructLayoutField %t586, i8* %t587, 1
  %t589 = load double, double* %l12
  %t590 = insertvalue %NativeStructLayoutField %t588, double %t589, 2
  %t591 = load double, double* %l13
  %t592 = insertvalue %NativeStructLayoutField %t590, double %t591, 3
  %t593 = load double, double* %l14
  %t594 = insertvalue %NativeStructLayoutField %t592, double %t593, 4
  store %NativeStructLayoutField %t594, %NativeStructLayoutField* %l24
  %t595 = load i1, i1* %l23
  %t596 = insertvalue %EnumLayoutPayloadParse undef, i1 %t595, 0
  %t597 = load i8*, i8** %l6
  %t598 = insertvalue %EnumLayoutPayloadParse %t596, i8* %t597, 1
  %t599 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t600 = insertvalue %EnumLayoutPayloadParse %t598, i8* null, 2
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t602 = insertvalue %EnumLayoutPayloadParse %t600, { i8**, i64 }* %t601, 3
  ret %EnumLayoutPayloadParse %t602
}

define %NativeInstruction @parse_let_instruction(i8* %line, i8* %span, i8* %value_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca %BindingComponents
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  store i1 0, i1* %l1
  %t3 = load i8*, i8** %l0
  store i8* %t3, i8** %l2
  %t4 = load i8*, i8** %l2
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @starts_with(i8* %t4, i8* %s5)
  %t7 = load i8*, i8** %l0
  %t8 = load i1, i1* %l1
  %t9 = load i8*, i8** %l2
  br i1 %t6, label %then0, label %merge1
then0:
  store i1 1, i1* %l1
  %t10 = load i8*, i8** %l2
  %s11 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i8* @strip_prefix(i8* %t10, i8* %s11)
  %t13 = call i8* @trim_text(i8* %t12)
  store i8* %t13, i8** %l2
  br label %merge1
merge1:
  %t14 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t15 = phi i8* [ %t13, %then0 ], [ %t9, %entry ]
  store i1 %t14, i1* %l1
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  %t17 = call %BindingComponents @parse_binding_components(i8* %t16)
  store %BindingComponents %t17, %BindingComponents* %l3
  %t18 = alloca %NativeInstruction
  %t19 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 0
  store i32 2, i32* %t19
  %t20 = load %BindingComponents, %BindingComponents* %l3
  %t21 = extractvalue %BindingComponents %t20, 0
  %t22 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t23 = bitcast [48 x i8]* %t22 to i8*
  %t24 = bitcast i8* %t23 to i8**
  store i8* %t21, i8** %t24
  %t25 = load i1, i1* %l1
  %t26 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t27 = bitcast [48 x i8]* %t26 to i8*
  %t28 = getelementptr inbounds i8, i8* %t27, i64 8
  %t29 = bitcast i8* %t28 to i1*
  store i1 %t25, i1* %t29
  %t30 = load %BindingComponents, %BindingComponents* %l3
  %t31 = extractvalue %BindingComponents %t30, 1
  %t32 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t33 = bitcast [48 x i8]* %t32 to i8*
  %t34 = getelementptr inbounds i8, i8* %t33, i64 16
  %t35 = bitcast i8* %t34 to i8**
  store i8* %t31, i8** %t35
  %t36 = load %BindingComponents, %BindingComponents* %l3
  %t37 = extractvalue %BindingComponents %t36, 2
  %t38 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t39 = bitcast [48 x i8]* %t38 to i8*
  %t40 = getelementptr inbounds i8, i8* %t39, i64 24
  %t41 = bitcast i8* %t40 to i8**
  store i8* %t37, i8** %t41
  %t42 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t43 = bitcast [48 x i8]* %t42 to i8*
  %t44 = getelementptr inbounds i8, i8* %t43, i64 32
  %t45 = bitcast i8* %t44 to i8**
  store i8* %span, i8** %t45
  %t46 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t47 = bitcast [48 x i8]* %t46 to i8*
  %t48 = getelementptr inbounds i8, i8* %t47, i64 40
  %t49 = bitcast i8* %t48 to i8**
  store i8* %value_span, i8** %t49
  %t50 = load %NativeInstruction, %NativeInstruction* %t18
  ret %NativeInstruction %t50
}

define %BindingComponents @parse_binding_components(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t37 = phi i8* [ %t2, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t3, %entry ], [ %t36, %loop.latch2 ]
  store i8* %t37, i8** %l0
  store double %t38, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %text, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 32
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t18 = load i8, i8* %l2
  %t19 = icmp eq i8 %t18, 58
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t20 = phi i1 [ true, %logical_or_entry_15 ], [ %t19, %logical_or_right_end_15 ]
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t20, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t21 = load i8, i8* %l2
  %t22 = icmp eq i8 %t21, 61
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t23 = phi i1 [ true, %logical_or_entry_14 ], [ %t22, %logical_or_right_end_14 ]
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t27 = load i8*, i8** %l0
  %t28 = load i8, i8* %l2
  %t29 = getelementptr i8, i8* %t27, i64 0
  %t30 = load i8, i8* %t29
  %t31 = add i8 %t30, %t28
  store i8* null, i8** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t39 = load i8*, i8** %l0
  %t40 = call i8* @trim_text(i8* %t39)
  store i8* %t40, i8** %l0
  %s41 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.41, i32 0, i32 0
  store i8* %s41, i8** %l3
  store i8* null, i8** %l4
  %t42 = load double, double* %l1
  %t43 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t44 = fptosi double %t42 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t44, i64 %t43)
  %t46 = call i8* @trim_text(i8* %t45)
  store i8* %t46, i8** %l5
  %t47 = load i8*, i8** %l5
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp sgt i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l3
  %t53 = load i8*, i8** %l4
  %t54 = load i8*, i8** %l5
  br i1 %t49, label %then8, label %merge9
then8:
  %t55 = load i8*, i8** %l5
  br label %merge9
merge9:
  %t56 = load i8*, i8** %l0
  %t57 = insertvalue %BindingComponents undef, i8* %t56, 0
  %t58 = load i8*, i8** %l3
  %t59 = insertvalue %BindingComponents %t57, i8* %t58, 1
  %t60 = load i8*, i8** %l4
  %t61 = insertvalue %BindingComponents %t59, i8* %t60, 2
  ret %BindingComponents %t61
}

define i8* @parse_function_name(i8* %header) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %header)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l0
  br label %merge1
merge1:
  %t9 = phi i8* [ %t8, %then0 ], [ %t4, %entry ]
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = call double @index_of(i8* %t10, i8* null)
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  store i8* %t12, i8** %l2
  %t13 = load double, double* %l1
  %t14 = sitofp i64 0 to double
  %t15 = fcmp oge double %t13, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load i8*, i8** %l2
  br i1 %t15, label %then2, label %merge3
then2:
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = call i8* @sailfin_runtime_substring(i8* %t19, i64 0, i64 %t21)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l2
  br label %merge3
merge3:
  %t24 = phi i8* [ %t23, %then2 ], [ %t18, %entry ]
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %t26 = call double @last_index_of(i8* %t25, i8* null)
  store double %t26, double* %l3
  %t27 = load double, double* %l3
  %t28 = sitofp i64 0 to double
  %t29 = fcmp oge double %t27, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then4, label %merge5
then4:
  %t34 = load i8*, i8** %l2
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  %t38 = load i8*, i8** %l2
  %t39 = call i64 @sailfin_runtime_string_length(i8* %t38)
  %t40 = fptosi double %t37 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %t34, i64 %t40, i64 %t39)
  %t42 = call i8* @trim_text(i8* %t41)
  store i8* %t42, i8** %l2
  br label %merge5
merge5:
  %t43 = phi i8* [ %t42, %then4 ], [ %t32, %entry ]
  store i8* %t43, i8** %l2
  %t44 = load i8*, i8** %l2
  %t45 = call i8* @strip_generics(i8* %t44)
  ret i8* %t45
}

define i1 @line_looks_like_parameter_entry(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = call i1 @starts_with(i8* %t5, i8* null)
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t8 = load i8*, i8** %l0
  %t9 = call i1 @starts_with(i8* %t8, i8* null)
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t11 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t12 = load double, double* %l1
  %t13 = sitofp i64 0 to double
  %t14 = fcmp oge double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  %t19 = fptosi double %t18 to i64
  %t20 = call i8* @sailfin_runtime_substring(i8* %t17, i64 0, i64 %t19)
  %t21 = call i8* @trim_text(i8* %t20)
  store i8* %t21, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = call i64 @sailfin_runtime_string_length(i8* %t22)
  %t24 = icmp eq i64 %t23, 0
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  br i1 %t24, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t28 = load i8*, i8** %l2
  %s29 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.29, i32 0, i32 0
  %t30 = call i1 @starts_with(i8* %t28, i8* %s29)
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  br i1 %t30, label %then10, label %merge11
then10:
  %t34 = load i8*, i8** %l2
  %s35 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.35, i32 0, i32 0
  %t36 = call i8* @strip_prefix(i8* %t34, i8* %s35)
  %t37 = call i8* @trim_text(i8* %t36)
  store i8* %t37, i8** %l2
  br label %merge11
merge11:
  %t38 = phi i8* [ %t37, %then10 ], [ %t33, %then6 ]
  store i8* %t38, i8** %l2
  %t39 = load i8*, i8** %l2
  %t40 = call i64 @sailfin_runtime_string_length(i8* %t39)
  %t41 = icmp eq i64 %t40, 0
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  br i1 %t41, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t45 = load i8*, i8** %l2
  %t46 = call double @index_of(i8* %t45, i8* null)
  %t47 = sitofp i64 0 to double
  %t48 = fcmp oge double %t46, %t47
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load i8*, i8** %l2
  br i1 %t48, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t52 = load i8*, i8** %l2
  %t53 = call double @index_of(i8* %t52, i8* null)
  %t54 = sitofp i64 0 to double
  %t55 = fcmp oge double %t53, %t54
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  %t58 = load i8*, i8** %l2
  br i1 %t55, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t59 = load i8*, i8** %l0
  %t60 = call double @index_of(i8* %t59, i8* null)
  store double %t60, double* %l3
  %t61 = load double, double* %l3
  %t62 = sitofp i64 0 to double
  %t63 = fcmp oge double %t61, %t62
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load double, double* %l3
  br i1 %t63, label %then18, label %merge19
then18:
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l3
  %t69 = fptosi double %t68 to i64
  %t70 = call i8* @sailfin_runtime_substring(i8* %t67, i64 0, i64 %t69)
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l4
  %t72 = load i8*, i8** %l4
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = icmp eq i64 %t73, 0
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l1
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l4
  br i1 %t74, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t79 = load i8*, i8** %l4
  %s80 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.80, i32 0, i32 0
  %t81 = call i1 @starts_with(i8* %t79, i8* %s80)
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l1
  %t84 = load double, double* %l3
  %t85 = load i8*, i8** %l4
  br i1 %t81, label %then22, label %merge23
then22:
  %t86 = load i8*, i8** %l4
  %s87 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.87, i32 0, i32 0
  %t88 = call i8* @strip_prefix(i8* %t86, i8* %s87)
  %t89 = call i8* @trim_text(i8* %t88)
  store i8* %t89, i8** %l4
  br label %merge23
merge23:
  %t90 = phi i8* [ %t89, %then22 ], [ %t85, %then18 ]
  store i8* %t90, i8** %l4
  %t91 = load i8*, i8** %l4
  %t92 = call i64 @sailfin_runtime_string_length(i8* %t91)
  %t93 = icmp eq i64 %t92, 0
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load double, double* %l3
  %t97 = load i8*, i8** %l4
  br i1 %t93, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t98 = load i8*, i8** %l4
  %t99 = call double @index_of(i8* %t98, i8* null)
  %t100 = sitofp i64 0 to double
  %t101 = fcmp oge double %t99, %t100
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l1
  %t104 = load double, double* %l3
  %t105 = load i8*, i8** %l4
  br i1 %t101, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t106 = load i8*, i8** %l4
  %t107 = call double @index_of(i8* %t106, i8* null)
  %t108 = sitofp i64 0 to double
  %t109 = fcmp oge double %t107, %t108
  %t110 = load i8*, i8** %l0
  %t111 = load double, double* %l1
  %t112 = load double, double* %l3
  %t113 = load i8*, i8** %l4
  br i1 %t109, label %then28, label %merge29
then28:
  ret i1 0
merge29:
  ret i1 1
merge19:
  ret i1 0
}

define { i8**, i64 }* @split_parameter_entries(i8* %body) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8
  %l6 = alloca i8*
  %l7 = alloca i8*
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
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l4
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i8*, i8** %l4
  br label %loop.header0
loop.header0:
  %t221 = phi i8* [ %t10, %entry ], [ %t216, %loop.latch2 ]
  %t222 = phi double [ %t11, %entry ], [ %t217, %loop.latch2 ]
  %t223 = phi i8* [ %t13, %entry ], [ %t218, %loop.latch2 ]
  %t224 = phi double [ %t12, %entry ], [ %t219, %loop.latch2 ]
  %t225 = phi { i8**, i64 }* [ %t9, %entry ], [ %t220, %loop.latch2 ]
  store i8* %t221, i8** %l1
  store double %t222, double* %l2
  store i8* %t223, i8** %l4
  store double %t224, double* %l3
  store { i8**, i64 }* %t225, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t14, %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i8*, i8** %l4
  br i1 %t17, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = load double, double* %l2
  %t24 = fptosi double %t23 to i64
  %t25 = getelementptr i8, i8* %body, i64 %t24
  %t26 = load i8, i8* %t25
  store i8 %t26, i8* %l5
  %t27 = load i8*, i8** %l4
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp sgt i64 %t28, 0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load i8*, i8** %l4
  %t35 = load i8, i8* %l5
  br i1 %t29, label %then6, label %merge7
then6:
  %t36 = load i8*, i8** %l1
  %t37 = load i8, i8* %l5
  %t38 = getelementptr i8, i8* %t36, i64 0
  %t39 = load i8, i8* %t38
  %t40 = add i8 %t39, %t37
  store i8* null, i8** %l1
  %t41 = load i8, i8* %l5
  %t42 = icmp eq i8 %t41, 92
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load double, double* %l2
  %t46 = load double, double* %l3
  %t47 = load i8*, i8** %l4
  %t48 = load i8, i8* %l5
  br i1 %t42, label %then8, label %merge9
then8:
  %t49 = load double, double* %l2
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  %t52 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp olt double %t51, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load i8*, i8** %l4
  %t60 = load i8, i8* %l5
  br i1 %t54, label %then10, label %merge11
then10:
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  %t63 = sitofp i64 2 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t65 = phi i8* [ null, %then8 ], [ %t44, %then6 ]
  %t66 = phi double [ %t64, %then8 ], [ %t45, %then6 ]
  store i8* %t65, i8** %l1
  store double %t66, double* %l2
  %t67 = load i8, i8* %l5
  %t68 = load i8*, i8** %l4
  %t69 = getelementptr i8, i8* %t68, i64 0
  %t70 = load i8, i8* %t69
  %t71 = icmp eq i8 %t67, %t70
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load i8*, i8** %l1
  %t74 = load double, double* %l2
  %t75 = load double, double* %l3
  %t76 = load i8*, i8** %l4
  %t77 = load i8, i8* %l5
  br i1 %t71, label %then12, label %merge13
then12:
  %s78 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.78, i32 0, i32 0
  store i8* %s78, i8** %l4
  br label %merge13
merge13:
  %t79 = phi i8* [ %s78, %then12 ], [ %t76, %then6 ]
  store i8* %t79, i8** %l4
  %t80 = load double, double* %l2
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l2
  br label %loop.latch2
merge7:
  %t84 = load i8, i8* %l5
  %t85 = icmp eq i8 %t84, 34
  br label %logical_or_entry_83

logical_or_entry_83:
  br i1 %t85, label %logical_or_merge_83, label %logical_or_right_83

logical_or_right_83:
  %t86 = load i8, i8* %l5
  %t87 = icmp eq i8 %t86, 39
  br label %logical_or_right_end_83

logical_or_right_end_83:
  br label %logical_or_merge_83

logical_or_merge_83:
  %t88 = phi i1 [ true, %logical_or_entry_83 ], [ %t87, %logical_or_right_end_83 ]
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i8*, i8** %l4
  %t94 = load i8, i8* %l5
  br i1 %t88, label %then14, label %merge15
then14:
  %t95 = load i8, i8* %l5
  store i8* null, i8** %l4
  %t96 = load i8*, i8** %l1
  %t97 = load i8, i8* %l5
  %t98 = getelementptr i8, i8* %t96, i64 0
  %t99 = load i8, i8* %t98
  %t100 = add i8 %t99, %t97
  store i8* null, i8** %l1
  %t101 = load double, double* %l2
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  store double %t103, double* %l2
  br label %loop.latch2
merge15:
  %t106 = load i8, i8* %l5
  %t107 = icmp eq i8 %t106, 40
  br label %logical_or_entry_105

logical_or_entry_105:
  br i1 %t107, label %logical_or_merge_105, label %logical_or_right_105

logical_or_right_105:
  %t108 = load i8, i8* %l5
  %t109 = icmp eq i8 %t108, 91
  br label %logical_or_right_end_105

logical_or_right_end_105:
  br label %logical_or_merge_105

logical_or_merge_105:
  %t110 = phi i1 [ true, %logical_or_entry_105 ], [ %t109, %logical_or_right_end_105 ]
  br label %logical_or_entry_104

logical_or_entry_104:
  br i1 %t110, label %logical_or_merge_104, label %logical_or_right_104

logical_or_right_104:
  %t111 = load i8, i8* %l5
  %t112 = icmp eq i8 %t111, 123
  br label %logical_or_right_end_104

logical_or_right_end_104:
  br label %logical_or_merge_104

logical_or_merge_104:
  %t113 = phi i1 [ true, %logical_or_entry_104 ], [ %t112, %logical_or_right_end_104 ]
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l2
  %t117 = load double, double* %l3
  %t118 = load i8*, i8** %l4
  %t119 = load i8, i8* %l5
  br i1 %t113, label %then16, label %merge17
then16:
  %t120 = load double, double* %l3
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  store double %t122, double* %l3
  %t123 = load i8*, i8** %l1
  %t124 = load i8, i8* %l5
  %t125 = getelementptr i8, i8* %t123, i64 0
  %t126 = load i8, i8* %t125
  %t127 = add i8 %t126, %t124
  store i8* null, i8** %l1
  %t128 = load double, double* %l2
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  store double %t130, double* %l2
  br label %loop.latch2
merge17:
  %t133 = load i8, i8* %l5
  %t134 = icmp eq i8 %t133, 41
  br label %logical_or_entry_132

logical_or_entry_132:
  br i1 %t134, label %logical_or_merge_132, label %logical_or_right_132

logical_or_right_132:
  %t135 = load i8, i8* %l5
  %t136 = icmp eq i8 %t135, 93
  br label %logical_or_right_end_132

logical_or_right_end_132:
  br label %logical_or_merge_132

logical_or_merge_132:
  %t137 = phi i1 [ true, %logical_or_entry_132 ], [ %t136, %logical_or_right_end_132 ]
  br label %logical_or_entry_131

logical_or_entry_131:
  br i1 %t137, label %logical_or_merge_131, label %logical_or_right_131

logical_or_right_131:
  %t138 = load i8, i8* %l5
  %t139 = icmp eq i8 %t138, 125
  br label %logical_or_right_end_131

logical_or_right_end_131:
  br label %logical_or_merge_131

logical_or_merge_131:
  %t140 = phi i1 [ true, %logical_or_entry_131 ], [ %t139, %logical_or_right_end_131 ]
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t142 = load i8*, i8** %l1
  %t143 = load double, double* %l2
  %t144 = load double, double* %l3
  %t145 = load i8*, i8** %l4
  %t146 = load i8, i8* %l5
  br i1 %t140, label %then18, label %merge19
then18:
  %t147 = load double, double* %l3
  %t148 = sitofp i64 0 to double
  %t149 = fcmp ogt double %t147, %t148
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load i8*, i8** %l1
  %t152 = load double, double* %l2
  %t153 = load double, double* %l3
  %t154 = load i8*, i8** %l4
  %t155 = load i8, i8* %l5
  br i1 %t149, label %then20, label %merge21
then20:
  %t156 = load double, double* %l3
  %t157 = sitofp i64 1 to double
  %t158 = fsub double %t156, %t157
  store double %t158, double* %l3
  br label %merge21
merge21:
  %t159 = phi double [ %t158, %then20 ], [ %t153, %then18 ]
  store double %t159, double* %l3
  %t160 = load i8*, i8** %l1
  %t161 = load i8, i8* %l5
  %t162 = getelementptr i8, i8* %t160, i64 0
  %t163 = load i8, i8* %t162
  %t164 = add i8 %t163, %t161
  store i8* null, i8** %l1
  %t165 = load double, double* %l2
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l2
  br label %loop.latch2
merge19:
  %t168 = load i8, i8* %l5
  %t169 = icmp eq i8 %t168, 44
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t171 = load i8*, i8** %l1
  %t172 = load double, double* %l2
  %t173 = load double, double* %l3
  %t174 = load i8*, i8** %l4
  %t175 = load i8, i8* %l5
  br i1 %t169, label %then22, label %merge23
then22:
  %t176 = load double, double* %l3
  %t177 = sitofp i64 0 to double
  %t178 = fcmp oeq double %t176, %t177
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load i8*, i8** %l1
  %t181 = load double, double* %l2
  %t182 = load double, double* %l3
  %t183 = load i8*, i8** %l4
  %t184 = load i8, i8* %l5
  br i1 %t178, label %then24, label %merge25
then24:
  %t185 = load i8*, i8** %l1
  %t186 = call i8* @trim_text(i8* %t185)
  store i8* %t186, i8** %l6
  %t187 = load i8*, i8** %l6
  %t188 = call i64 @sailfin_runtime_string_length(i8* %t187)
  %t189 = icmp sgt i64 %t188, 0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load i8*, i8** %l1
  %t192 = load double, double* %l2
  %t193 = load double, double* %l3
  %t194 = load i8*, i8** %l4
  %t195 = load i8, i8* %l5
  %t196 = load i8*, i8** %l6
  br i1 %t189, label %then26, label %merge27
then26:
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load i8*, i8** %l6
  %t199 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t197, i8* %t198)
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t200 = phi { i8**, i64 }* [ %t199, %then26 ], [ %t190, %then24 ]
  store { i8**, i64 }* %t200, { i8**, i64 }** %l0
  %s201 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.201, i32 0, i32 0
  store i8* %s201, i8** %l1
  %t202 = load double, double* %l2
  %t203 = sitofp i64 1 to double
  %t204 = fadd double %t202, %t203
  store double %t204, double* %l2
  br label %loop.latch2
merge25:
  br label %merge23
merge23:
  %t205 = phi { i8**, i64 }* [ %t199, %then22 ], [ %t170, %loop.body1 ]
  %t206 = phi i8* [ %s201, %then22 ], [ %t171, %loop.body1 ]
  %t207 = phi double [ %t204, %then22 ], [ %t172, %loop.body1 ]
  store { i8**, i64 }* %t205, { i8**, i64 }** %l0
  store i8* %t206, i8** %l1
  store double %t207, double* %l2
  %t208 = load i8*, i8** %l1
  %t209 = load i8, i8* %l5
  %t210 = getelementptr i8, i8* %t208, i64 0
  %t211 = load i8, i8* %t210
  %t212 = add i8 %t211, %t209
  store i8* null, i8** %l1
  %t213 = load double, double* %l2
  %t214 = sitofp i64 1 to double
  %t215 = fadd double %t213, %t214
  store double %t215, double* %l2
  br label %loop.latch2
loop.latch2:
  %t216 = load i8*, i8** %l1
  %t217 = load double, double* %l2
  %t218 = load i8*, i8** %l4
  %t219 = load double, double* %l3
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t226 = load i8*, i8** %l1
  %t227 = call i8* @trim_text(i8* %t226)
  store i8* %t227, i8** %l7
  %t228 = load i8*, i8** %l7
  %t229 = call i64 @sailfin_runtime_string_length(i8* %t228)
  %t230 = icmp sgt i64 %t229, 0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = load double, double* %l2
  %t234 = load double, double* %l3
  %t235 = load i8*, i8** %l4
  %t236 = load i8*, i8** %l7
  br i1 %t230, label %then28, label %merge29
then28:
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t238 = load i8*, i8** %l7
  %t239 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t237, i8* %t238)
  store { i8**, i64 }* %t239, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t240 = phi { i8**, i64 }* [ %t239, %then28 ], [ %t231, %entry ]
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t241
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = icmp eq i8* %t1, %s2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* %t7
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call { i8**, i64 }* @split_comma_separated(i8* %t10)
  ret { i8**, i64 }* %t11
}

define { i8**, i64 }* @split_whitespace(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca i1
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = icmp eq i64 %t5, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t8
merge1:
  %t9 = sitofp i64 -1 to double
  store double %t9, double* %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t81 = phi { i8**, i64 }* [ %t11, %entry ], [ %t78, %loop.latch4 ]
  %t82 = phi double [ %t12, %entry ], [ %t79, %loop.latch4 ]
  %t83 = phi double [ %t13, %entry ], [ %t80, %loop.latch4 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  store double %t82, double* %l1
  store double %t83, double* %l2
  br label %loop.body3
loop.body3:
  %t14 = load double, double* %l2
  %t15 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t14, %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load double, double* %l2
  %t22 = fptosi double %t21 to i64
  %t23 = getelementptr i8, i8* %value, i64 %t22
  %t24 = load i8, i8* %t23
  store i8 %t24, i8* %l3
  %t28 = load i8, i8* %l3
  %t29 = icmp eq i8 %t28, 32
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t29, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t30 = load i8, i8* %l3
  %t31 = icmp eq i8 %t30, 9
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t32 = phi i1 [ true, %logical_or_entry_27 ], [ %t31, %logical_or_right_end_27 ]
  br label %logical_or_entry_26

logical_or_entry_26:
  br i1 %t32, label %logical_or_merge_26, label %logical_or_right_26

logical_or_right_26:
  %t33 = load i8, i8* %l3
  %t34 = icmp eq i8 %t33, 10
  br label %logical_or_right_end_26

logical_or_right_end_26:
  br label %logical_or_merge_26

logical_or_merge_26:
  %t35 = phi i1 [ true, %logical_or_entry_26 ], [ %t34, %logical_or_right_end_26 ]
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t35, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t36 = load i8, i8* %l3
  %t37 = icmp eq i8 %t36, 13
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t38 = phi i1 [ true, %logical_or_entry_25 ], [ %t37, %logical_or_right_end_25 ]
  store i1 %t38, i1* %l4
  %t39 = load i1, i1* %l4
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load double, double* %l2
  %t43 = load i8, i8* %l3
  %t44 = load i1, i1* %l4
  br i1 %t39, label %then8, label %else9
then8:
  %t45 = load double, double* %l1
  %t46 = sitofp i64 0 to double
  %t47 = fcmp oge double %t45, %t46
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load i8, i8* %l3
  %t52 = load i1, i1* %l4
  br i1 %t47, label %then11, label %merge12
then11:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load double, double* %l2
  %t56 = fptosi double %t54 to i64
  %t57 = fptosi double %t55 to i64
  %t58 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t56, i64 %t57)
  %t59 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t53, i8* %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  %t60 = sitofp i64 -1 to double
  store double %t60, double* %l1
  br label %merge12
merge12:
  %t61 = phi { i8**, i64 }* [ %t59, %then11 ], [ %t48, %then8 ]
  %t62 = phi double [ %t60, %then11 ], [ %t49, %then8 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  store double %t62, double* %l1
  br label %merge10
else9:
  %t63 = load double, double* %l1
  %t64 = sitofp i64 0 to double
  %t65 = fcmp olt double %t63, %t64
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = load double, double* %l2
  %t69 = load i8, i8* %l3
  %t70 = load i1, i1* %l4
  br i1 %t65, label %then13, label %merge14
then13:
  %t71 = load double, double* %l2
  store double %t71, double* %l1
  br label %merge14
merge14:
  %t72 = phi double [ %t71, %then13 ], [ %t67, %else9 ]
  store double %t72, double* %l1
  br label %merge10
merge10:
  %t73 = phi { i8**, i64 }* [ %t59, %then8 ], [ %t40, %else9 ]
  %t74 = phi double [ %t60, %then8 ], [ %t71, %else9 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  store double %t74, double* %l1
  %t75 = load double, double* %l2
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l2
  br label %loop.latch4
loop.latch4:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t84 = load double, double* %l1
  %t85 = sitofp i64 0 to double
  %t86 = fcmp oge double %t84, %t85
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  br i1 %t86, label %then15, label %merge16
then15:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load double, double* %l1
  %t92 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t93 = fptosi double %t91 to i64
  %t94 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t93, i64 %t92)
  %t95 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t90, i8* %t94)
  store { i8**, i64 }* %t95, { i8**, i64 }** %l0
  br label %merge16
merge16:
  %t96 = phi { i8**, i64 }* [ %t95, %then15 ], [ %t87, %entry ]
  store { i8**, i64 }* %t96, { i8**, i64 }** %l0
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t97
}

define %NumberParseResult @parse_decimal_number(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8
  %l6 = alloca double
  %l7 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = insertvalue %NumberParseResult undef, i1 0, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %NumberParseResult %t5, double %t6, 1
  ret %NumberParseResult %t7
merge1:
  %t8 = call double @char_code(i8 48)
  store double %t8, double* %l1
  %t9 = call double @char_code(i8 57)
  store double %t9, double* %l2
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l3
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l4
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = load double, double* %l3
  %t16 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t65 = phi double [ %t16, %entry ], [ %t63, %loop.latch4 ]
  %t66 = phi double [ %t15, %entry ], [ %t64, %loop.latch4 ]
  store double %t65, double* %l4
  store double %t66, double* %l3
  br label %loop.body3
loop.body3:
  %t17 = load double, double* %l3
  %t18 = load i8*, i8** %l0
  %t19 = call i64 @sailfin_runtime_string_length(i8* %t18)
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t17, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  %t25 = load double, double* %l3
  %t26 = load double, double* %l4
  br i1 %t21, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l3
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %t27, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l5
  %t32 = load i8, i8* %l5
  %t33 = call double @char_code(i8 %t32)
  store double %t33, double* %l6
  %t35 = load double, double* %l6
  %t36 = load double, double* %l1
  %t37 = fcmp olt double %t35, %t36
  br label %logical_or_entry_34

logical_or_entry_34:
  br i1 %t37, label %logical_or_merge_34, label %logical_or_right_34

logical_or_right_34:
  %t38 = load double, double* %l6
  %t39 = load double, double* %l2
  %t40 = fcmp ogt double %t38, %t39
  br label %logical_or_right_end_34

logical_or_right_end_34:
  br label %logical_or_merge_34

logical_or_merge_34:
  %t41 = phi i1 [ true, %logical_or_entry_34 ], [ %t40, %logical_or_right_end_34 ]
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load double, double* %l4
  %t47 = load i8, i8* %l5
  %t48 = load double, double* %l6
  br i1 %t41, label %then8, label %merge9
then8:
  %t49 = insertvalue %NumberParseResult undef, i1 0, 0
  %t50 = sitofp i64 0 to double
  %t51 = insertvalue %NumberParseResult %t49, double %t50, 1
  ret %NumberParseResult %t51
merge9:
  %t52 = load double, double* %l6
  %t53 = load double, double* %l1
  %t54 = fsub double %t52, %t53
  store double %t54, double* %l7
  %t55 = load double, double* %l4
  %t56 = sitofp i64 10 to double
  %t57 = fmul double %t55, %t56
  %t58 = load double, double* %l7
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l4
  %t60 = load double, double* %l3
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l3
  br label %loop.latch4
loop.latch4:
  %t63 = load double, double* %l4
  %t64 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t67 = insertvalue %NumberParseResult undef, i1 1, 0
  %t68 = load double, double* %l4
  %t69 = insertvalue %NumberParseResult %t67, double %t68, 1
  ret %NumberParseResult %t69
}

define { i8**, i64 }* @split_lines(i8* %value) {
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
  %t44 = phi { i8**, i64 }* [ %t7, %entry ], [ %t41, %loop.latch2 ]
  %t45 = phi i8* [ %t8, %entry ], [ %t42, %loop.latch2 ]
  %t46 = phi double [ %t9, %entry ], [ %t43, %loop.latch2 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  store i8* %t45, i8** %l1
  store double %t46, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
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
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  store i8 %t20, i8* %l3
  %t21 = load i8, i8* %l3
  %t22 = icmp eq i8 %t21, 10
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load i8, i8* %l3
  br i1 %t22, label %then6, label %else7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.30, i32 0, i32 0
  store i8* %s30, i8** %l1
  br label %merge8
else7:
  %t31 = load i8*, i8** %l1
  %t32 = load i8, i8* %l3
  %t33 = getelementptr i8, i8* %t31, i64 0
  %t34 = load i8, i8* %t33
  %t35 = add i8 %t34, %t32
  store i8* null, i8** %l1
  br label %merge8
merge8:
  %t36 = phi { i8**, i64 }* [ %t29, %then6 ], [ %t23, %else7 ]
  %t37 = phi i8* [ %s30, %then6 ], [ null, %else7 ]
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  store i8* %t37, i8** %l1
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l2
  br label %loop.latch2
loop.latch2:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l1
  %t49 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t47, i8* %t48)
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t50
}

define { i8**, i64 }* @split_comma_separated(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
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
  %t45 = phi { i8**, i64 }* [ %t7, %entry ], [ %t42, %loop.latch2 ]
  %t46 = phi i8* [ %t8, %entry ], [ %t43, %loop.latch2 ]
  %t47 = phi double [ %t9, %entry ], [ %t44, %loop.latch2 ]
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  store i8* %t46, i8** %l1
  store double %t47, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
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
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  store i8 %t20, i8* %l3
  %t21 = load i8, i8* %l3
  %t22 = icmp eq i8 %t21, 44
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load i8, i8* %l3
  br i1 %t22, label %then6, label %else7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = call i8* @trim_text(i8* %t28)
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %s31 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.31, i32 0, i32 0
  store i8* %s31, i8** %l1
  br label %merge8
else7:
  %t32 = load i8*, i8** %l1
  %t33 = load i8, i8* %l3
  %t34 = getelementptr i8, i8* %t32, i64 0
  %t35 = load i8, i8* %t34
  %t36 = add i8 %t35, %t33
  store i8* null, i8** %l1
  br label %merge8
merge8:
  %t37 = phi { i8**, i64 }* [ %t30, %then6 ], [ %t23, %else7 ]
  %t38 = phi i8* [ %s31, %then6 ], [ null, %else7 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store i8* %t38, i8** %l1
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l2
  br label %loop.latch2
loop.latch2:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t48 = load i8*, i8** %l1
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load double, double* %l2
  br i1 %t50, label %then9, label %merge10
then9:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = call i8* @trim_text(i8* %t55)
  %t57 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t58 = phi { i8**, i64 }* [ %t57, %then9 ], [ %t51, %entry ]
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  %t59 = alloca [0 x i8*]
  %t60 = getelementptr [0 x i8*], [0 x i8*]* %t59, i32 0, i32 0
  %t61 = alloca { i8**, i64 }
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 0
  store i8** %t60, i8*** %t62
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 1
  store i64 0, i64* %t63
  store { i8**, i64 }* %t61, { i8**, i64 }** %l4
  %t64 = sitofp i64 0 to double
  store double %t64, double* %l2
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l2
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t105 = phi { i8**, i64 }* [ %t68, %entry ], [ %t103, %loop.latch13 ]
  %t106 = phi double [ %t67, %entry ], [ %t104, %loop.latch13 ]
  store { i8**, i64 }* %t105, { i8**, i64 }** %l4
  store double %t106, double* %l2
  br label %loop.body12
loop.body12:
  %t69 = load double, double* %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }, { i8**, i64 }* %t70
  %t72 = extractvalue { i8**, i64 } %t71, 1
  %t73 = sitofp i64 %t72 to double
  %t74 = fcmp oge double %t69, %t73
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l2
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t74, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l2
  %t81 = fptosi double %t80 to i64
  %t82 = load { i8**, i64 }, { i8**, i64 }* %t79
  %t83 = extractvalue { i8**, i64 } %t82, 0
  %t84 = extractvalue { i8**, i64 } %t82, 1
  %t85 = icmp uge i64 %t81, %t84
  ; bounds check: %t85 (if true, out of bounds)
  %t86 = getelementptr i8*, i8** %t83, i64 %t81
  %t87 = load i8*, i8** %t86
  store i8* %t87, i8** %l5
  %t88 = load i8*, i8** %l5
  %t89 = call i64 @sailfin_runtime_string_length(i8* %t88)
  %t90 = icmp sgt i64 %t89, 0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load double, double* %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t95 = load i8*, i8** %l5
  br i1 %t90, label %then17, label %merge18
then17:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t97 = load i8*, i8** %l5
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t96, i8* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t99 = phi { i8**, i64 }* [ %t98, %then17 ], [ %t94, %loop.body12 ]
  store { i8**, i64 }* %t99, { i8**, i64 }** %l4
  %t100 = load double, double* %l2
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l2
  br label %loop.latch13
loop.latch13:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t104 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t107
}

define i8* @strip_generics(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t37 = phi i8* [ %t3, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t5, %entry ], [ %t36, %loop.latch2 ]
  store i8* %t37, i8** %l0
  store double %t38, double* %l2
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l2
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %name, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l3
  %t17 = load i8, i8* %l3
  %t18 = load i8, i8* %l3
  %t19 = load double, double* %l1
  %t20 = sitofp i64 0 to double
  %t21 = fcmp oeq double %t19, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  %t25 = load i8, i8* %l3
  br i1 %t21, label %then6, label %merge7
then6:
  %t26 = load i8*, i8** %l0
  %t27 = load i8, i8* %l3
  %t28 = getelementptr i8, i8* %t26, i64 0
  %t29 = load i8, i8* %t28
  %t30 = add i8 %t29, %t27
  store i8* null, i8** %l0
  br label %merge7
merge7:
  %t31 = phi i8* [ null, %then6 ], [ %t22, %loop.body1 ]
  store i8* %t31, i8** %l0
  %t32 = load double, double* %l2
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t39 = load i8*, i8** %l0
  %t40 = call i8* @trim_text(i8* %t39)
  ret i8* %t40
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t3, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = fcmp oge double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
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
  %t15 = call i1 @is_trim_char(i8* null)
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t40 = phi double [ %t25, %entry ], [ %t39, %loop.latch10 ]
  store double %t40, double* %l1
  br label %loop.body9
loop.body9:
  %t26 = load double, double* %l1
  %t27 = load double, double* %l0
  %t28 = fcmp ole double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t31 = load double, double* %l3
  %t32 = call i1 @is_trim_char(i8* null)
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l3
  br i1 %t32, label %then14, label %merge15
then14:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fsub double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t39 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t42 = load double, double* %l0
  %t43 = sitofp i64 0 to double
  %t44 = fcmp oeq double %t42, %t43
  br label %logical_and_entry_41

logical_and_entry_41:
  br i1 %t44, label %logical_and_right_41, label %logical_and_merge_41

logical_and_right_41:
  %t45 = load double, double* %l1
  %t46 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oeq double %t45, %t47
  br label %logical_and_right_end_41

logical_and_right_end_41:
  br label %logical_and_merge_41

logical_and_merge_41:
  %t49 = phi i1 [ false, %logical_and_entry_41 ], [ %t48, %logical_and_right_end_41 ]
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  br i1 %t49, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  %t54 = fptosi double %t52 to i64
  %t55 = fptosi double %t53 to i64
  %t56 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t54, i64 %t55)
  ret i8* %t56
}

define %LayoutManifest @parse_layout_manifest(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeStruct*, i64 }*
  %l3 = alloca { %NativeEnum*, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca %StructLayoutHeaderParse
  %l10 = alloca { %NativeStructLayoutField*, i64 }*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %StructLayoutFieldParse
  %l16 = alloca %NativeStruct
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca %EnumLayoutHeaderParse
  %l20 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca %EnumLayoutVariantParse
  %l26 = alloca i8*
  %l27 = alloca i8*
  %l28 = alloca %EnumLayoutPayloadParse
  %l29 = alloca i64
  %l30 = alloca %NativeEnumVariantLayout
  %l31 = alloca { %NativeStructLayoutField*, i64 }*
  %l32 = alloca %NativeEnum
  %t0 = call { i8**, i64 }* @split_lines(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = alloca [0 x %NativeStruct]
  %t7 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* %t6, i32 0, i32 0
  %t8 = alloca { %NativeStruct*, i64 }
  %t9 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t8, i32 0, i32 0
  store %NativeStruct* %t7, %NativeStruct** %t9
  %t10 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %NativeStruct*, i64 }* %t8, { %NativeStruct*, i64 }** %l2
  %t11 = alloca [0 x %NativeEnum]
  %t12 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* %t11, i32 0, i32 0
  %t13 = alloca { %NativeEnum*, i64 }
  %t14 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t13, i32 0, i32 0
  store %NativeEnum* %t12, %NativeEnum** %t14
  %t15 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %NativeEnum*, i64 }* %t13, { %NativeEnum*, i64 }** %l3
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t20 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t21 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t596 = phi double [ %t21, %entry ], [ %t592, %loop.latch2 ]
  %t597 = phi { i8**, i64 }* [ %t18, %entry ], [ %t593, %loop.latch2 ]
  %t598 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t594, %loop.latch2 ]
  %t599 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t595, %loop.latch2 ]
  store double %t596, double* %l4
  store { i8**, i64 }* %t597, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t598, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t599, { %NativeEnum*, i64 }** %l3
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t31 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t32 = load double, double* %l4
  br i1 %t27, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l4
  %t35 = fptosi double %t34 to i64
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t37 = extractvalue { i8**, i64 } %t36, 0
  %t38 = extractvalue { i8**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr i8*, i8** %t37, i64 %t35
  %t41 = load i8*, i8** %t40
  store i8* %t41, i8** %l5
  %t42 = load i8*, i8** %l5
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l6
  %t44 = load i8*, i8** %l6
  %t45 = call i64 @sailfin_runtime_string_length(i8* %t44)
  %t46 = icmp eq i64 %t45, 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t50 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t51 = load double, double* %l4
  %t52 = load i8*, i8** %l5
  %t53 = load i8*, i8** %l6
  br i1 %t46, label %then6, label %merge7
then6:
  %t54 = load double, double* %l4
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l4
  br label %loop.latch2
merge7:
  %t57 = load i8*, i8** %l6
  %t58 = call i1 @starts_with(i8* %t57, i8* null)
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t62 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t63 = load double, double* %l4
  %t64 = load i8*, i8** %l5
  %t65 = load i8*, i8** %l6
  br i1 %t58, label %then8, label %merge9
then8:
  %t66 = load double, double* %l4
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l4
  br label %loop.latch2
merge9:
  %t69 = load i8*, i8** %l6
  %s70 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.70, i32 0, i32 0
  %t71 = call i1 @starts_with(i8* %t69, i8* %s70)
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t75 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t76 = load double, double* %l4
  %t77 = load i8*, i8** %l5
  %t78 = load i8*, i8** %l6
  br i1 %t71, label %then10, label %merge11
then10:
  %t79 = load double, double* %l4
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l4
  br label %loop.latch2
merge11:
  %t82 = load i8*, i8** %l6
  %s83 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.83, i32 0, i32 0
  %t84 = call i1 @starts_with(i8* %t82, i8* %s83)
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t88 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t89 = load double, double* %l4
  %t90 = load i8*, i8** %l5
  %t91 = load i8*, i8** %l6
  br i1 %t84, label %then12, label %merge13
then12:
  %t92 = load i8*, i8** %l6
  %s93 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.93, i32 0, i32 0
  %t94 = call i8* @strip_prefix(i8* %t92, i8* %s93)
  store i8* %t94, i8** %l7
  %t95 = load i8*, i8** %l7
  %s96 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.96, i32 0, i32 0
  %t97 = call i8* @strip_prefix(i8* %t95, i8* %s96)
  store i8* %t97, i8** %l8
  %t98 = load i8*, i8** %l8
  %t99 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t98)
  store %StructLayoutHeaderParse %t99, %StructLayoutHeaderParse* %l9
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t102 = extractvalue %StructLayoutHeaderParse %t101, 4
  %t103 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t100, { i8**, i64 }* %t102)
  store { i8**, i64 }* %t103, { i8**, i64 }** %l1
  %t104 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t105 = extractvalue %StructLayoutHeaderParse %t104, 0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t108 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t109 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t110 = load double, double* %l4
  %t111 = load i8*, i8** %l5
  %t112 = load i8*, i8** %l6
  %t113 = load i8*, i8** %l7
  %t114 = load i8*, i8** %l8
  %t115 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t105, label %then14, label %merge15
then14:
  %t116 = alloca [0 x %NativeStructLayoutField]
  %t117 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t116, i32 0, i32 0
  %t118 = alloca { %NativeStructLayoutField*, i64 }
  %t119 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t118, i32 0, i32 0
  store %NativeStructLayoutField* %t117, %NativeStructLayoutField** %t119
  %t120 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t118, i32 0, i32 1
  store i64 0, i64* %t120
  store { %NativeStructLayoutField*, i64 }* %t118, { %NativeStructLayoutField*, i64 }** %l10
  %t121 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t122 = extractvalue %StructLayoutHeaderParse %t121, 1
  store i8* %t122, i8** %l11
  %t123 = load double, double* %l4
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l4
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t128 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t129 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t130 = load double, double* %l4
  %t131 = load i8*, i8** %l5
  %t132 = load i8*, i8** %l6
  %t133 = load i8*, i8** %l7
  %t134 = load i8*, i8** %l8
  %t135 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t136 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t137 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t242 = phi i8* [ %t133, %then14 ], [ %t238, %loop.latch18 ]
  %t243 = phi { i8**, i64 }* [ %t127, %then14 ], [ %t239, %loop.latch18 ]
  %t244 = phi { %NativeStructLayoutField*, i64 }* [ %t136, %then14 ], [ %t240, %loop.latch18 ]
  %t245 = phi double [ %t130, %then14 ], [ %t241, %loop.latch18 ]
  store i8* %t242, i8** %l7
  store { i8**, i64 }* %t243, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t244, { %NativeStructLayoutField*, i64 }** %l10
  store double %t245, double* %l4
  br label %loop.body17
loop.body17:
  %t138 = load double, double* %l4
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t140 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t141 = extractvalue { i8**, i64 } %t140, 1
  %t142 = sitofp i64 %t141 to double
  %t143 = fcmp oge double %t138, %t142
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t146 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t147 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t148 = load double, double* %l4
  %t149 = load i8*, i8** %l5
  %t150 = load i8*, i8** %l6
  %t151 = load i8*, i8** %l7
  %t152 = load i8*, i8** %l8
  %t153 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t154 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t155 = load i8*, i8** %l11
  br i1 %t143, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load double, double* %l4
  %t158 = fptosi double %t157 to i64
  %t159 = load { i8**, i64 }, { i8**, i64 }* %t156
  %t160 = extractvalue { i8**, i64 } %t159, 0
  %t161 = extractvalue { i8**, i64 } %t159, 1
  %t162 = icmp uge i64 %t158, %t161
  ; bounds check: %t162 (if true, out of bounds)
  %t163 = getelementptr i8*, i8** %t160, i64 %t158
  %t164 = load i8*, i8** %t163
  %t165 = call i8* @trim_text(i8* %t164)
  store i8* %t165, i8** %l12
  %t166 = load i8*, i8** %l12
  %t167 = call i64 @sailfin_runtime_string_length(i8* %t166)
  %t168 = icmp eq i64 %t167, 0
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t172 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t173 = load double, double* %l4
  %t174 = load i8*, i8** %l5
  %t175 = load i8*, i8** %l6
  %t176 = load i8*, i8** %l7
  %t177 = load i8*, i8** %l8
  %t178 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t179 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t180 = load i8*, i8** %l11
  %t181 = load i8*, i8** %l12
  br i1 %t168, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t182 = load i8*, i8** %l12
  %s183 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.183, i32 0, i32 0
  %t184 = call i1 @starts_with(i8* %t182, i8* %s183)
  %t185 = xor i1 %t184, 1
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t188 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t189 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t190 = load double, double* %l4
  %t191 = load i8*, i8** %l5
  %t192 = load i8*, i8** %l6
  %t193 = load i8*, i8** %l7
  %t194 = load i8*, i8** %l8
  %t195 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t196 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t197 = load i8*, i8** %l11
  %t198 = load i8*, i8** %l12
  br i1 %t185, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t199 = load i8*, i8** %l12
  %s200 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.200, i32 0, i32 0
  %t201 = call i8* @strip_prefix(i8* %t199, i8* %s200)
  store i8* %t201, i8** %l13
  %t202 = load i8*, i8** %l7
  %s203 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.203, i32 0, i32 0
  %t204 = call i8* @strip_prefix(i8* %t202, i8* %s203)
  store i8* %t204, i8** %l14
  %t205 = load i8*, i8** %l14
  %t206 = load i8*, i8** %l11
  %t207 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t205, i8* %t206)
  store %StructLayoutFieldParse %t207, %StructLayoutFieldParse* %l15
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t209 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t210 = extractvalue %StructLayoutFieldParse %t209, 2
  %t211 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t208, { i8**, i64 }* %t210)
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  %t212 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t213 = extractvalue %StructLayoutFieldParse %t212, 0
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t216 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t217 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t218 = load double, double* %l4
  %t219 = load i8*, i8** %l5
  %t220 = load i8*, i8** %l6
  %t221 = load i8*, i8** %l7
  %t222 = load i8*, i8** %l8
  %t223 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t224 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t225 = load i8*, i8** %l11
  %t226 = load i8*, i8** %l12
  %t227 = load i8*, i8** %l13
  %t228 = load i8*, i8** %l14
  %t229 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t213, label %then26, label %merge27
then26:
  %t230 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t231 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t232 = extractvalue %StructLayoutFieldParse %t231, 1
  %t233 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t230, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t233, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t234 = phi { %NativeStructLayoutField*, i64 }* [ %t233, %then26 ], [ %t224, %loop.body17 ]
  store { %NativeStructLayoutField*, i64 }* %t234, { %NativeStructLayoutField*, i64 }** %l10
  %t235 = load double, double* %l4
  %t236 = sitofp i64 1 to double
  %t237 = fadd double %t235, %t236
  store double %t237, double* %l4
  br label %loop.latch18
loop.latch18:
  %t238 = load i8*, i8** %l7
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t240 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t241 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t246 = load i8*, i8** %l11
  %t247 = insertvalue %NativeStruct undef, i8* %t246, 0
  %t248 = alloca [0 x i8*]
  %t249 = getelementptr [0 x i8*], [0 x i8*]* %t248, i32 0, i32 0
  %t250 = alloca { i8**, i64 }
  %t251 = getelementptr { i8**, i64 }, { i8**, i64 }* %t250, i32 0, i32 0
  store i8** %t249, i8*** %t251
  %t252 = getelementptr { i8**, i64 }, { i8**, i64 }* %t250, i32 0, i32 1
  store i64 0, i64* %t252
  %t253 = insertvalue %NativeStruct %t247, { i8**, i64 }* %t250, 1
  %t254 = alloca [0 x i8*]
  %t255 = getelementptr [0 x i8*], [0 x i8*]* %t254, i32 0, i32 0
  %t256 = alloca { i8**, i64 }
  %t257 = getelementptr { i8**, i64 }, { i8**, i64 }* %t256, i32 0, i32 0
  store i8** %t255, i8*** %t257
  %t258 = getelementptr { i8**, i64 }, { i8**, i64 }* %t256, i32 0, i32 1
  store i64 0, i64* %t258
  %t259 = insertvalue %NativeStruct %t253, { i8**, i64 }* %t256, 2
  %t260 = alloca [0 x i8*]
  %t261 = getelementptr [0 x i8*], [0 x i8*]* %t260, i32 0, i32 0
  %t262 = alloca { i8**, i64 }
  %t263 = getelementptr { i8**, i64 }, { i8**, i64 }* %t262, i32 0, i32 0
  store i8** %t261, i8*** %t263
  %t264 = getelementptr { i8**, i64 }, { i8**, i64 }* %t262, i32 0, i32 1
  store i64 0, i64* %t264
  %t265 = insertvalue %NativeStruct %t259, { i8**, i64 }* %t262, 3
  %t266 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t267 = extractvalue %StructLayoutHeaderParse %t266, 2
  %t268 = insertvalue %NativeStructLayout undef, double %t267, 0
  %t269 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t270 = extractvalue %StructLayoutHeaderParse %t269, 3
  %t271 = insertvalue %NativeStructLayout %t268, double %t270, 1
  %t272 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t273 = bitcast { %NativeStructLayoutField*, i64 }* %t272 to { i8**, i64 }*
  %t274 = insertvalue %NativeStructLayout %t271, { i8**, i64 }* %t273, 2
  %t275 = insertvalue %NativeStruct %t265, i8* null, 4
  store %NativeStruct %t275, %NativeStruct* %l16
  %t276 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t277 = load %NativeStruct, %NativeStruct* %l16
  %t278 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t276, %NativeStruct %t277)
  store { %NativeStruct*, i64 }* %t278, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t279 = phi double [ %t125, %then14 ], [ %t110, %then12 ]
  %t280 = phi i8* [ %t201, %then14 ], [ %t113, %then12 ]
  %t281 = phi { i8**, i64 }* [ %t211, %then14 ], [ %t107, %then12 ]
  %t282 = phi double [ %t237, %then14 ], [ %t110, %then12 ]
  %t283 = phi { %NativeStruct*, i64 }* [ %t278, %then14 ], [ %t108, %then12 ]
  store double %t279, double* %l4
  store i8* %t280, i8** %l7
  store { i8**, i64 }* %t281, { i8**, i64 }** %l1
  store double %t282, double* %l4
  store { %NativeStruct*, i64 }* %t283, { %NativeStruct*, i64 }** %l2
  %t284 = load double, double* %l4
  %t285 = sitofp i64 1 to double
  %t286 = fadd double %t284, %t285
  store double %t286, double* %l4
  br label %loop.latch2
merge13:
  %t287 = load i8*, i8** %l6
  %s288 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.288, i32 0, i32 0
  %t289 = call i1 @starts_with(i8* %t287, i8* %s288)
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t292 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t293 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t294 = load double, double* %l4
  %t295 = load i8*, i8** %l5
  %t296 = load i8*, i8** %l6
  br i1 %t289, label %then28, label %merge29
then28:
  %t297 = load i8*, i8** %l6
  %s298 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.298, i32 0, i32 0
  %t299 = call i8* @strip_prefix(i8* %t297, i8* %s298)
  store i8* %t299, i8** %l17
  %t300 = load i8*, i8** %l17
  %s301 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.301, i32 0, i32 0
  %t302 = call i8* @strip_prefix(i8* %t300, i8* %s301)
  store i8* %t302, i8** %l18
  %t303 = load i8*, i8** %l18
  %t304 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t303)
  store %EnumLayoutHeaderParse %t304, %EnumLayoutHeaderParse* %l19
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t306 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t307 = extractvalue %EnumLayoutHeaderParse %t306, 7
  %t308 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t305, { i8**, i64 }* %t307)
  store { i8**, i64 }* %t308, { i8**, i64 }** %l1
  %t309 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t310 = extractvalue %EnumLayoutHeaderParse %t309, 0
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t313 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t314 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t315 = load double, double* %l4
  %t316 = load i8*, i8** %l5
  %t317 = load i8*, i8** %l6
  %t318 = load i8*, i8** %l17
  %t319 = load i8*, i8** %l18
  %t320 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t310, label %then30, label %else31
then30:
  %t321 = alloca [0 x %NativeEnumVariantLayout]
  %t322 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t321, i32 0, i32 0
  %t323 = alloca { %NativeEnumVariantLayout*, i64 }
  %t324 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t323, i32 0, i32 0
  store %NativeEnumVariantLayout* %t322, %NativeEnumVariantLayout** %t324
  %t325 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t323, i32 0, i32 1
  store i64 0, i64* %t325
  store { %NativeEnumVariantLayout*, i64 }* %t323, { %NativeEnumVariantLayout*, i64 }** %l20
  %t326 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t327 = extractvalue %EnumLayoutHeaderParse %t326, 1
  store i8* %t327, i8** %l21
  %t328 = load double, double* %l4
  %t329 = sitofp i64 1 to double
  %t330 = fadd double %t328, %t329
  store double %t330, double* %l4
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t333 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t334 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t335 = load double, double* %l4
  %t336 = load i8*, i8** %l5
  %t337 = load i8*, i8** %l6
  %t338 = load i8*, i8** %l17
  %t339 = load i8*, i8** %l18
  %t340 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t341 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t342 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t548 = phi double [ %t335, %then30 ], [ %t544, %loop.latch35 ]
  %t549 = phi i8* [ %t338, %then30 ], [ %t545, %loop.latch35 ]
  %t550 = phi { i8**, i64 }* [ %t332, %then30 ], [ %t546, %loop.latch35 ]
  %t551 = phi { %NativeEnumVariantLayout*, i64 }* [ %t341, %then30 ], [ %t547, %loop.latch35 ]
  store double %t548, double* %l4
  store i8* %t549, i8** %l17
  store { i8**, i64 }* %t550, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t551, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t343 = load double, double* %l4
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t345 = load { i8**, i64 }, { i8**, i64 }* %t344
  %t346 = extractvalue { i8**, i64 } %t345, 1
  %t347 = sitofp i64 %t346 to double
  %t348 = fcmp oge double %t343, %t347
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t351 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t352 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t353 = load double, double* %l4
  %t354 = load i8*, i8** %l5
  %t355 = load i8*, i8** %l6
  %t356 = load i8*, i8** %l17
  %t357 = load i8*, i8** %l18
  %t358 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t359 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t360 = load i8*, i8** %l21
  br i1 %t348, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t362 = load double, double* %l4
  %t363 = fptosi double %t362 to i64
  %t364 = load { i8**, i64 }, { i8**, i64 }* %t361
  %t365 = extractvalue { i8**, i64 } %t364, 0
  %t366 = extractvalue { i8**, i64 } %t364, 1
  %t367 = icmp uge i64 %t363, %t366
  ; bounds check: %t367 (if true, out of bounds)
  %t368 = getelementptr i8*, i8** %t365, i64 %t363
  %t369 = load i8*, i8** %t368
  %t370 = call i8* @trim_text(i8* %t369)
  store i8* %t370, i8** %l22
  %t371 = load i8*, i8** %l22
  %t372 = call i64 @sailfin_runtime_string_length(i8* %t371)
  %t373 = icmp eq i64 %t372, 0
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t376 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t377 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t378 = load double, double* %l4
  %t379 = load i8*, i8** %l5
  %t380 = load i8*, i8** %l6
  %t381 = load i8*, i8** %l17
  %t382 = load i8*, i8** %l18
  %t383 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t384 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t385 = load i8*, i8** %l21
  %t386 = load i8*, i8** %l22
  br i1 %t373, label %then39, label %merge40
then39:
  %t387 = load double, double* %l4
  %t388 = sitofp i64 1 to double
  %t389 = fadd double %t387, %t388
  store double %t389, double* %l4
  br label %afterloop36
merge40:
  %t391 = load i8*, i8** %l22
  %s392 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.392, i32 0, i32 0
  %t393 = call i1 @starts_with(i8* %t391, i8* %s392)
  br label %logical_and_entry_390

logical_and_entry_390:
  br i1 %t393, label %logical_and_right_390, label %logical_and_merge_390

logical_and_right_390:
  %t394 = load i8*, i8** %l22
  %s395 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.395, i32 0, i32 0
  %t396 = call i1 @starts_with(i8* %t394, i8* %s395)
  %t397 = xor i1 %t396, 1
  br label %logical_and_right_end_390

logical_and_right_end_390:
  br label %logical_and_merge_390

logical_and_merge_390:
  %t398 = phi i1 [ false, %logical_and_entry_390 ], [ %t397, %logical_and_right_end_390 ]
  %t399 = xor i1 %t398, 1
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t402 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t403 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t404 = load double, double* %l4
  %t405 = load i8*, i8** %l5
  %t406 = load i8*, i8** %l6
  %t407 = load i8*, i8** %l17
  %t408 = load i8*, i8** %l18
  %t409 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t410 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t411 = load i8*, i8** %l21
  %t412 = load i8*, i8** %l22
  br i1 %t399, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t413 = load i8*, i8** %l22
  %s414 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.414, i32 0, i32 0
  %t415 = call i1 @starts_with(i8* %t413, i8* %s414)
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t418 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t419 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t420 = load double, double* %l4
  %t421 = load i8*, i8** %l5
  %t422 = load i8*, i8** %l6
  %t423 = load i8*, i8** %l17
  %t424 = load i8*, i8** %l18
  %t425 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t426 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t427 = load i8*, i8** %l21
  %t428 = load i8*, i8** %l22
  br i1 %t415, label %then43, label %else44
then43:
  %t429 = load i8*, i8** %l22
  %s430 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.430, i32 0, i32 0
  %t431 = call i8* @strip_prefix(i8* %t429, i8* %s430)
  store i8* %t431, i8** %l23
  %t432 = load i8*, i8** %l17
  %s433 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.433, i32 0, i32 0
  %t434 = call i8* @strip_prefix(i8* %t432, i8* %s433)
  store i8* %t434, i8** %l24
  %t435 = load i8*, i8** %l24
  %t436 = load i8*, i8** %l21
  %t437 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t435, i8* %t436)
  store %EnumLayoutVariantParse %t437, %EnumLayoutVariantParse* %l25
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t439 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t440 = extractvalue %EnumLayoutVariantParse %t439, 2
  %t441 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t438, { i8**, i64 }* %t440)
  store { i8**, i64 }* %t441, { i8**, i64 }** %l1
  %t442 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t443 = extractvalue %EnumLayoutVariantParse %t442, 0
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t447 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t448 = load double, double* %l4
  %t449 = load i8*, i8** %l5
  %t450 = load i8*, i8** %l6
  %t451 = load i8*, i8** %l17
  %t452 = load i8*, i8** %l18
  %t453 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t454 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t455 = load i8*, i8** %l21
  %t456 = load i8*, i8** %l22
  %t457 = load i8*, i8** %l23
  %t458 = load i8*, i8** %l24
  %t459 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t443, label %then46, label %merge47
then46:
  %t460 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t461 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t462 = extractvalue %EnumLayoutVariantParse %t461, 1
  %t463 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t460, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t463, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t464 = phi { %NativeEnumVariantLayout*, i64 }* [ %t463, %then46 ], [ %t454, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t464, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t465 = load i8*, i8** %l22
  %s466 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.466, i32 0, i32 0
  %t467 = call i1 @starts_with(i8* %t465, i8* %s466)
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t470 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t471 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t472 = load double, double* %l4
  %t473 = load i8*, i8** %l5
  %t474 = load i8*, i8** %l6
  %t475 = load i8*, i8** %l17
  %t476 = load i8*, i8** %l18
  %t477 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t478 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t479 = load i8*, i8** %l21
  %t480 = load i8*, i8** %l22
  br i1 %t467, label %then48, label %merge49
then48:
  %t481 = load i8*, i8** %l22
  %s482 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.482, i32 0, i32 0
  %t483 = call i8* @strip_prefix(i8* %t481, i8* %s482)
  store i8* %t483, i8** %l26
  %t484 = load i8*, i8** %l17
  %s485 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.485, i32 0, i32 0
  %t486 = call i8* @strip_prefix(i8* %t484, i8* %s485)
  store i8* %t486, i8** %l27
  %t487 = load i8*, i8** %l27
  %t488 = load i8*, i8** %l21
  %t489 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t487, i8* %t488)
  store %EnumLayoutPayloadParse %t489, %EnumLayoutPayloadParse* %l28
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t491 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t492 = extractvalue %EnumLayoutPayloadParse %t491, 3
  %t493 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t490, { i8**, i64 }* %t492)
  store { i8**, i64 }* %t493, { i8**, i64 }** %l1
  %t495 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t496 = extractvalue %EnumLayoutPayloadParse %t495, 0
  br label %logical_and_entry_494

logical_and_entry_494:
  br i1 %t496, label %logical_and_right_494, label %logical_and_merge_494

logical_and_right_494:
  %t497 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t498 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t497
  %t499 = extractvalue { %NativeEnumVariantLayout*, i64 } %t498, 1
  %t500 = icmp sgt i64 %t499, 0
  br label %logical_and_right_end_494

logical_and_right_end_494:
  br label %logical_and_merge_494

logical_and_merge_494:
  %t501 = phi i1 [ false, %logical_and_entry_494 ], [ %t500, %logical_and_right_end_494 ]
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t504 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t505 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t506 = load double, double* %l4
  %t507 = load i8*, i8** %l5
  %t508 = load i8*, i8** %l6
  %t509 = load i8*, i8** %l17
  %t510 = load i8*, i8** %l18
  %t511 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t512 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t513 = load i8*, i8** %l21
  %t514 = load i8*, i8** %l22
  %t515 = load i8*, i8** %l26
  %t516 = load i8*, i8** %l27
  %t517 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t501, label %then50, label %merge51
then50:
  %t518 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t519 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t518
  %t520 = extractvalue { %NativeEnumVariantLayout*, i64 } %t519, 1
  %t521 = sub i64 %t520, 1
  store i64 %t521, i64* %l29
  %t522 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t523 = load i64, i64* %l29
  %t524 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t522
  %t525 = extractvalue { %NativeEnumVariantLayout*, i64 } %t524, 0
  %t526 = extractvalue { %NativeEnumVariantLayout*, i64 } %t524, 1
  %t527 = icmp uge i64 %t523, %t526
  ; bounds check: %t527 (if true, out of bounds)
  %t528 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t525, i64 %t523
  %t529 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t528
  store %NativeEnumVariantLayout %t529, %NativeEnumVariantLayout* %l30
  %t530 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t531 = extractvalue %NativeEnumVariantLayout %t530, 5
  %t532 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t533 = extractvalue %EnumLayoutPayloadParse %t532, 2
  %t534 = bitcast { i8**, i64 }* %t531 to { %NativeStructLayoutField*, i64 }*
  %t535 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t534, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t535, { %NativeStructLayoutField*, i64 }** %l31
  br label %merge51
merge51:
  br label %merge49
merge49:
  %t536 = phi i8* [ %t483, %then48 ], [ %t475, %else44 ]
  %t537 = phi { i8**, i64 }* [ %t493, %then48 ], [ %t469, %else44 ]
  store i8* %t536, i8** %l17
  store { i8**, i64 }* %t537, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t538 = phi i8* [ %t431, %then43 ], [ %t483, %else44 ]
  %t539 = phi { i8**, i64 }* [ %t441, %then43 ], [ %t493, %else44 ]
  %t540 = phi { %NativeEnumVariantLayout*, i64 }* [ %t463, %then43 ], [ %t426, %else44 ]
  store i8* %t538, i8** %l17
  store { i8**, i64 }* %t539, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t540, { %NativeEnumVariantLayout*, i64 }** %l20
  %t541 = load double, double* %l4
  %t542 = sitofp i64 1 to double
  %t543 = fadd double %t541, %t542
  store double %t543, double* %l4
  br label %loop.latch35
loop.latch35:
  %t544 = load double, double* %l4
  %t545 = load i8*, i8** %l17
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t547 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t552 = load i8*, i8** %l21
  %t553 = insertvalue %NativeEnum undef, i8* %t552, 0
  %t554 = alloca [0 x i8*]
  %t555 = getelementptr [0 x i8*], [0 x i8*]* %t554, i32 0, i32 0
  %t556 = alloca { i8**, i64 }
  %t557 = getelementptr { i8**, i64 }, { i8**, i64 }* %t556, i32 0, i32 0
  store i8** %t555, i8*** %t557
  %t558 = getelementptr { i8**, i64 }, { i8**, i64 }* %t556, i32 0, i32 1
  store i64 0, i64* %t558
  %t559 = insertvalue %NativeEnum %t553, { i8**, i64 }* %t556, 1
  %t560 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t561 = extractvalue %EnumLayoutHeaderParse %t560, 2
  %t562 = insertvalue %NativeEnumLayout undef, double %t561, 0
  %t563 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t564 = extractvalue %EnumLayoutHeaderParse %t563, 3
  %t565 = insertvalue %NativeEnumLayout %t562, double %t564, 1
  %t566 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t567 = extractvalue %EnumLayoutHeaderParse %t566, 4
  %t568 = insertvalue %NativeEnumLayout %t565, i8* %t567, 2
  %t569 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t570 = extractvalue %EnumLayoutHeaderParse %t569, 5
  %t571 = insertvalue %NativeEnumLayout %t568, double %t570, 3
  %t572 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t573 = extractvalue %EnumLayoutHeaderParse %t572, 6
  %t574 = insertvalue %NativeEnumLayout %t571, double %t573, 4
  %t575 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t576 = bitcast { %NativeEnumVariantLayout*, i64 }* %t575 to { i8**, i64 }*
  %t577 = insertvalue %NativeEnumLayout %t574, { i8**, i64 }* %t576, 5
  %t578 = insertvalue %NativeEnum %t559, i8* null, 2
  store %NativeEnum %t578, %NativeEnum* %l32
  %t579 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t580 = load %NativeEnum, %NativeEnum* %l32
  %t581 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t579, %NativeEnum %t580)
  store { %NativeEnum*, i64 }* %t581, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t582 = load double, double* %l4
  %t583 = sitofp i64 1 to double
  %t584 = fadd double %t582, %t583
  store double %t584, double* %l4
  br label %merge32
merge32:
  %t585 = phi double [ %t330, %then30 ], [ %t584, %else31 ]
  %t586 = phi i8* [ %t431, %then30 ], [ %t318, %else31 ]
  %t587 = phi { i8**, i64 }* [ %t441, %then30 ], [ %t312, %else31 ]
  %t588 = phi { %NativeEnum*, i64 }* [ %t581, %then30 ], [ %t314, %else31 ]
  store double %t585, double* %l4
  store i8* %t586, i8** %l17
  store { i8**, i64 }* %t587, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t588, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t589 = load double, double* %l4
  %t590 = sitofp i64 1 to double
  %t591 = fadd double %t589, %t590
  store double %t591, double* %l4
  br label %loop.latch2
loop.latch2:
  %t592 = load double, double* %l4
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t594 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t595 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t600 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t601 = bitcast { %NativeStruct*, i64 }* %t600 to { i8**, i64 }*
  %t602 = insertvalue %LayoutManifest undef, { i8**, i64 }* %t601, 0
  %t603 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t604 = bitcast { %NativeEnum*, i64 }* %t603 to { i8**, i64 }*
  %t605 = insertvalue %LayoutManifest %t602, { i8**, i64 }* %t604, 1
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t607 = insertvalue %LayoutManifest %t605, { i8**, i64 }* %t606, 2
  ret %LayoutManifest %t607
}

define i1 @is_trim_char(i8* %ch) {
entry:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 32
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t5, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 10
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t9 = phi i1 [ true, %logical_or_entry_2 ], [ %t8, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t9, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t10 = getelementptr i8, i8* %ch, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp eq i8 %t11, 13
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t13 = phi i1 [ true, %logical_or_entry_1 ], [ %t12, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t13, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t14 = getelementptr i8, i8* %ch, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 9
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t17 = phi i1 [ true, %logical_or_entry_0 ], [ %t16, %logical_or_right_end_0 ]
  ret i1 %t17
}

define i1 @starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %prefix)
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
  %t26 = phi double [ %t6, %entry ], [ %t25, %loop.latch6 ]
  store double %t26, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  br i1 %t10, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t12 = load double, double* %l0
  %t13 = fptosi double %t12 to i64
  %t14 = getelementptr i8, i8* %value, i64 %t13
  %t15 = load i8, i8* %t14
  %t16 = load double, double* %l0
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %prefix, i64 %t17
  %t19 = load i8, i8* %t18
  %t20 = icmp ne i8 %t15, %t19
  %t21 = load double, double* %l0
  br i1 %t20, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch6
loop.latch6:
  %t25 = load double, double* %l0
  br label %loop.header4
afterloop7:
  ret i1 1
}

define i8* @strip_prefix(i8* %value, i8* %prefix) {
entry:
  %t0 = call i1 @starts_with(i8* %value, i8* %prefix)
  %t1 = xor i1 %t0, 1
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %value
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t2, i64 %t3)
  ret i8* %t4
}

define double @index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t38 = phi double [ %t4, %entry ], [ %t37, %loop.latch4 ]
  store double %t38, double* %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t7 = sitofp i64 %t6 to double
  %t8 = fadd double %t5, %t7
  %t9 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp ogt double %t8, %t10
  %t12 = load double, double* %l0
  br i1 %t11, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  store i1 1, i1* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i1, i1* %l2
  br label %loop.header8
loop.header8:
  %t28 = phi double [ %t15, %loop.body3 ], [ %t27, %loop.latch10 ]
  store double %t28, double* %l1
  br label %loop.body9
loop.body9:
  %t17 = load double, double* %l1
  %t18 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i1, i1* %l2
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch10
loop.latch10:
  %t27 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t29 = load i1, i1* %l2
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i1, i1* %l2
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l0
  ret double %t33
merge15:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch4
loop.latch4:
  %t37 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t39 = sitofp i64 -1 to double
  ret double %t39
}

define double @last_index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  ret double %t3
merge1:
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t6 = sub i64 %t4, %t5
  %t7 = sitofp i64 %t6 to double
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t38 = phi double [ %t8, %entry ], [ %t37, %loop.latch4 ]
  store double %t38, double* %l0
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l0
  %t10 = sitofp i64 0 to double
  %t11 = fcmp olt double %t9, %t10
  %t12 = load double, double* %l0
  br i1 %t11, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  store i1 1, i1* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i1, i1* %l2
  br label %loop.header8
loop.header8:
  %t28 = phi double [ %t15, %loop.body3 ], [ %t27, %loop.latch10 ]
  store double %t28, double* %l1
  br label %loop.body9
loop.body9:
  %t17 = load double, double* %l1
  %t18 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i1, i1* %l2
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch10
loop.latch10:
  %t27 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t29 = load i1, i1* %l2
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i1, i1* %l2
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l0
  ret double %t33
merge15:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch4
loop.latch4:
  %t37 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t39 = sitofp i64 -1 to double
  ret double %t39
}

define i8* @strip_quotes(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp sge i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr i8, i8* %value, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  store double 0.0, double* %l1
  %t5 = load i8, i8* %l0
  %t6 = icmp eq i8 %t5, 34
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t6, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t7 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load i8, i8* %l0
  %t10 = icmp eq i8 %t9, 39
  br label %logical_and_entry_8

logical_and_entry_8:
  br i1 %t10, label %logical_and_right_8, label %logical_and_merge_8

logical_and_right_8:
  %t11 = load double, double* %l1
  store double 0.0, double* %l3
  %t13 = load double, double* %l2
  %t14 = fcmp one double %t13, 0.0
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t15 = load double, double* %l3
  %t16 = fcmp one double %t15, 0.0
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t17 = phi i1 [ true, %logical_or_entry_12 ], [ %t16, %logical_or_right_end_12 ]
  %t18 = load i8, i8* %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  br i1 %t17, label %then2, label %merge3
then2:
  %t22 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t23 = sub i64 %t22, 1
  %t24 = call i8* @sailfin_runtime_substring(i8* %value, i64 1, i64 %t23)
  ret i8* %t24
merge3:
  br label %merge1
merge1:
  ret i8* %value
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

define { i8**, i64 }* @split_text(i8* %value, i8* %delimiter) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %value, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  ret { i8**, i64 }* %t5
merge1:
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l0
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t55 = phi { i8**, i64 }* [ %t15, %entry ], [ %t52, %loop.latch4 ]
  %t56 = phi double [ %t16, %entry ], [ %t53, %loop.latch4 ]
  %t57 = phi double [ %t17, %entry ], [ %t54, %loop.latch4 ]
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  store double %t56, double* %l1
  store double %t57, double* %l2
  br label %loop.body3
loop.body3:
  %t18 = load double, double* %l2
  %t19 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t18, %t20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t25 = load double, double* %l2
  %t26 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t27 = fptosi double %t25 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t27, i64 %t26)
  %t29 = call double @index_of(i8* %t28, i8* %delimiter)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = sitofp i64 0 to double
  %t32 = fcmp olt double %t30, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l4
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load double, double* %l4
  %t43 = fptosi double %t41 to i64
  %t44 = fptosi double %t42 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t43, i64 %t44)
  %t46 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t45)
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  %t47 = load double, double* %l4
  %t48 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t49 = sitofp i64 %t48 to double
  %t50 = fadd double %t47, %t49
  store double %t50, double* %l1
  %t51 = load double, double* %l1
  store double %t51, double* %l2
  br label %loop.latch4
loop.latch4:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t58 = load double, double* %l1
  %t59 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t60 = sitofp i64 %t59 to double
  %t61 = fcmp olt double %t58, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  %t64 = load double, double* %l2
  br i1 %t61, label %then10, label %else11
then10:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t68 = fptosi double %t66 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t68, i64 %t67)
  %t70 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t65, i8* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  br label %merge12
else11:
  %t71 = load double, double* %l1
  %t72 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t73 = sitofp i64 %t72 to double
  %t74 = fcmp oeq double %t71, %t73
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load double, double* %l1
  %t77 = load double, double* %l2
  br i1 %t74, label %then13, label %merge14
then13:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s79 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.79, i32 0, i32 0
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t78, i8* %s79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  br label %merge14
merge14:
  %t81 = phi { i8**, i64 }* [ %t80, %then13 ], [ %t75, %else11 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  br label %merge12
merge12:
  %t82 = phi { i8**, i64 }* [ %t70, %then10 ], [ %t80, %else11 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t83
}

define { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %values, %NativeParameter %parameter) {
entry:
  %t0 = alloca [1 x %NativeParameter]
  %t1 = getelementptr [1 x %NativeParameter], [1 x %NativeParameter]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeParameter, %NativeParameter* %t1, i64 0
  store %NativeParameter %parameter, %NativeParameter* %t2
  %t3 = alloca { %NativeParameter*, i64 }
  %t4 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t3, i32 0, i32 0
  store %NativeParameter* %t1, %NativeParameter** %t4
  %t5 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %NativeParameter*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %NativeParameter*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %NativeParameter*, i64 }*
  ret { %NativeParameter*, i64 }* %t9
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
