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
@.str.273 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.24 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.65 = private unnamed_addr constant [1 x i8] c"\00"
@.str.25 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [1 x i8] c"\00"
@.str.80 = private unnamed_addr constant [1 x i8] c"\00"
@.str.31 = private unnamed_addr constant [1 x i8] c"\00"
@.str.32 = private unnamed_addr constant [1 x i8] c"\00"
@.str.118 = private unnamed_addr constant [1 x i8] c"\00"
@.str.45 = private unnamed_addr constant [1 x i8] c"\00"

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
  %t1043 = phi double [ %t48, %entry ], [ %t1034, %loop.latch2 ]
  %t1044 = phi { i8**, i64 }* [ %t38, %entry ], [ %t1035, %loop.latch2 ]
  %t1045 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t1036, %loop.latch2 ]
  %t1046 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t1037, %loop.latch2 ]
  %t1047 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t1038, %loop.latch2 ]
  %t1048 = phi i8* [ %t45, %entry ], [ %t1039, %loop.latch2 ]
  %t1049 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t1040, %loop.latch2 ]
  %t1050 = phi i8* [ %t46, %entry ], [ %t1041, %loop.latch2 ]
  %t1051 = phi i8* [ %t47, %entry ], [ %t1042, %loop.latch2 ]
  store double %t1043, double* %l11
  store { i8**, i64 }* %t1044, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t1045, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1046, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1047, { %NativeEnum*, i64 }** %l6
  store i8* %t1048, i8** %l8
  store { %NativeFunction*, i64 }* %t1049, { %NativeFunction*, i64 }** %l2
  store i8* %t1050, i8** %l9
  store i8* %t1051, i8** %l10
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
  %t99 = alloca [2 x i8], align 1
  %t100 = getelementptr [2 x i8], [2 x i8]* %t99, i32 0, i32 0
  store i8 59, i8* %t100
  %t101 = getelementptr [2 x i8], [2 x i8]* %t99, i32 0, i32 1
  store i8 0, i8* %t101
  %t102 = getelementptr [2 x i8], [2 x i8]* %t99, i32 0, i32 0
  %t103 = call i1 @starts_with(i8* %t98, i8* %t102)
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t107 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t108 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t109 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t110 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t111 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t112 = load i8*, i8** %l8
  %t113 = load i8*, i8** %l9
  %t114 = load i8*, i8** %l10
  %t115 = load double, double* %l11
  %t116 = load i8*, i8** %l12
  %t117 = load i8*, i8** %l13
  br i1 %t103, label %then8, label %merge9
then8:
  %t118 = load double, double* %l11
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l11
  br label %loop.latch2
merge9:
  %t121 = load i8*, i8** %l13
  %s122 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.122, i32 0, i32 0
  %t123 = call i1 @starts_with(i8* %t121, i8* %s122)
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t127 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t128 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t129 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t130 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t131 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t132 = load i8*, i8** %l8
  %t133 = load i8*, i8** %l9
  %t134 = load i8*, i8** %l10
  %t135 = load double, double* %l11
  %t136 = load i8*, i8** %l12
  %t137 = load i8*, i8** %l13
  br i1 %t123, label %then10, label %merge11
then10:
  %t138 = load double, double* %l11
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l11
  br label %loop.latch2
merge11:
  %t141 = load i8*, i8** %l13
  %s142 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.142, i32 0, i32 0
  %t143 = call i1 @starts_with(i8* %t141, i8* %s142)
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t146 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t147 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t148 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t149 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t150 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t151 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t152 = load i8*, i8** %l8
  %t153 = load i8*, i8** %l9
  %t154 = load i8*, i8** %l10
  %t155 = load double, double* %l11
  %t156 = load i8*, i8** %l12
  %t157 = load i8*, i8** %l13
  br i1 %t143, label %then12, label %merge13
then12:
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.158, i32 0, i32 0
  %t159 = load i8*, i8** %l13
  %s160 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.160, i32 0, i32 0
  %t161 = call i8* @strip_prefix(i8* %t159, i8* %s160)
  %t162 = call double @parse_import_entry(i8* %s158, i8* %t161)
  store double %t162, double* %l14
  %t163 = load double, double* %l14
  %t164 = load double, double* %l11
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l11
  br label %loop.latch2
merge13:
  %t167 = load i8*, i8** %l13
  %s168 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.168, i32 0, i32 0
  %t169 = call i1 @starts_with(i8* %t167, i8* %s168)
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t173 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t174 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t175 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t176 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t177 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t178 = load i8*, i8** %l8
  %t179 = load i8*, i8** %l9
  %t180 = load i8*, i8** %l10
  %t181 = load double, double* %l11
  %t182 = load i8*, i8** %l12
  %t183 = load i8*, i8** %l13
  br i1 %t169, label %then14, label %merge15
then14:
  %s184 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.184, i32 0, i32 0
  %t185 = load i8*, i8** %l13
  %s186 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.186, i32 0, i32 0
  %t187 = call i8* @strip_prefix(i8* %t185, i8* %s186)
  %t188 = call double @parse_import_entry(i8* %s184, i8* %t187)
  store double %t188, double* %l15
  %t189 = load double, double* %l15
  %t190 = load double, double* %l11
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l11
  br label %loop.latch2
merge15:
  %t193 = load i8*, i8** %l13
  %s194 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.194, i32 0, i32 0
  %t195 = call i1 @starts_with(i8* %t193, i8* %s194)
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t198 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t199 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t200 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t201 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t202 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t203 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t204 = load i8*, i8** %l8
  %t205 = load i8*, i8** %l9
  %t206 = load i8*, i8** %l10
  %t207 = load double, double* %l11
  %t208 = load i8*, i8** %l12
  %t209 = load i8*, i8** %l13
  br i1 %t195, label %then16, label %merge17
then16:
  %t210 = load i8*, i8** %l13
  %s211 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.211, i32 0, i32 0
  %t212 = call i8* @strip_prefix(i8* %t210, i8* %s211)
  %t213 = call double @parse_source_span(i8* %t212)
  store double %t213, double* %l16
  %t214 = load double, double* %l16
  %t215 = load double, double* %l11
  %t216 = sitofp i64 1 to double
  %t217 = fadd double %t215, %t216
  store double %t217, double* %l11
  br label %loop.latch2
merge17:
  %t218 = load i8*, i8** %l13
  %t219 = load i8*, i8** %l13
  %s220 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.220, i32 0, i32 0
  %t221 = call i1 @starts_with(i8* %t219, i8* %s220)
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t225 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t226 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t227 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t228 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t229 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t230 = load i8*, i8** %l8
  %t231 = load i8*, i8** %l9
  %t232 = load i8*, i8** %l10
  %t233 = load double, double* %l11
  %t234 = load i8*, i8** %l12
  %t235 = load i8*, i8** %l13
  br i1 %t221, label %then18, label %merge19
then18:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load double, double* %l11
  %t238 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t236, double %t237)
  store %StructParseResult %t238, %StructParseResult* %l17
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t240 = load %StructParseResult, %StructParseResult* %l17
  %t241 = extractvalue %StructParseResult %t240, 2
  %t242 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t239, { i8**, i64 }* %t241)
  store { i8**, i64 }* %t242, { i8**, i64 }** %l1
  %t243 = load %StructParseResult, %StructParseResult* %l17
  %t244 = extractvalue %StructParseResult %t243, 0
  %t245 = icmp ne i8* %t244, null
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t249 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t250 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t251 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t252 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t253 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t254 = load i8*, i8** %l8
  %t255 = load i8*, i8** %l9
  %t256 = load i8*, i8** %l10
  %t257 = load double, double* %l11
  %t258 = load i8*, i8** %l12
  %t259 = load i8*, i8** %l13
  %t260 = load %StructParseResult, %StructParseResult* %l17
  br i1 %t245, label %then20, label %merge21
then20:
  %t261 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t262 = load %StructParseResult, %StructParseResult* %l17
  %t263 = extractvalue %StructParseResult %t262, 0
  %t264 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t261, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t264, { %NativeStruct*, i64 }** %l4
  br label %merge21
merge21:
  %t265 = phi { %NativeStruct*, i64 }* [ %t264, %then20 ], [ %t250, %then18 ]
  store { %NativeStruct*, i64 }* %t265, { %NativeStruct*, i64 }** %l4
  %t266 = load %StructParseResult, %StructParseResult* %l17
  %t267 = extractvalue %StructParseResult %t266, 1
  store double %t267, double* %l11
  br label %loop.latch2
merge19:
  %t268 = load i8*, i8** %l13
  %s269 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.269, i32 0, i32 0
  %t270 = call i1 @starts_with(i8* %t268, i8* %s269)
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t274 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t275 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t276 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t277 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t278 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t279 = load i8*, i8** %l8
  %t280 = load i8*, i8** %l9
  %t281 = load i8*, i8** %l10
  %t282 = load double, double* %l11
  %t283 = load i8*, i8** %l12
  %t284 = load i8*, i8** %l13
  br i1 %t270, label %then22, label %merge23
then22:
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t286 = load double, double* %l11
  %t287 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t285, double %t286)
  store %InterfaceParseResult %t287, %InterfaceParseResult* %l18
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t289 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t290 = extractvalue %InterfaceParseResult %t289, 2
  %t291 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t288, { i8**, i64 }* %t290)
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  %t292 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t293 = extractvalue %InterfaceParseResult %t292, 0
  %t294 = icmp ne i8* %t293, null
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t298 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t299 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t300 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t301 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t302 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t303 = load i8*, i8** %l8
  %t304 = load i8*, i8** %l9
  %t305 = load i8*, i8** %l10
  %t306 = load double, double* %l11
  %t307 = load i8*, i8** %l12
  %t308 = load i8*, i8** %l13
  %t309 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  br i1 %t294, label %then24, label %merge25
then24:
  %t310 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t311 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t312 = extractvalue %InterfaceParseResult %t311, 0
  %t313 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t310, %NativeInterface zeroinitializer)
  store { %NativeInterface*, i64 }* %t313, { %NativeInterface*, i64 }** %l5
  br label %merge25
merge25:
  %t314 = phi { %NativeInterface*, i64 }* [ %t313, %then24 ], [ %t300, %then22 ]
  store { %NativeInterface*, i64 }* %t314, { %NativeInterface*, i64 }** %l5
  %t315 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t316 = extractvalue %InterfaceParseResult %t315, 1
  store double %t316, double* %l11
  br label %loop.latch2
merge23:
  %t317 = load i8*, i8** %l13
  %s318 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.318, i32 0, i32 0
  %t319 = call i1 @starts_with(i8* %t317, i8* %s318)
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t322 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t323 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t324 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t325 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t326 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t327 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t328 = load i8*, i8** %l8
  %t329 = load i8*, i8** %l9
  %t330 = load i8*, i8** %l10
  %t331 = load double, double* %l11
  %t332 = load i8*, i8** %l12
  %t333 = load i8*, i8** %l13
  br i1 %t319, label %then26, label %merge27
then26:
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t335 = load double, double* %l11
  %t336 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t334, double %t335)
  store %EnumParseResult %t336, %EnumParseResult* %l19
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t338 = load %EnumParseResult, %EnumParseResult* %l19
  %t339 = extractvalue %EnumParseResult %t338, 2
  %t340 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t337, { i8**, i64 }* %t339)
  store { i8**, i64 }* %t340, { i8**, i64 }** %l1
  %t341 = load %EnumParseResult, %EnumParseResult* %l19
  %t342 = extractvalue %EnumParseResult %t341, 0
  %t343 = icmp ne i8* %t342, null
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t346 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t347 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t348 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t349 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t350 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t351 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t352 = load i8*, i8** %l8
  %t353 = load i8*, i8** %l9
  %t354 = load i8*, i8** %l10
  %t355 = load double, double* %l11
  %t356 = load i8*, i8** %l12
  %t357 = load i8*, i8** %l13
  %t358 = load %EnumParseResult, %EnumParseResult* %l19
  br i1 %t343, label %then28, label %merge29
then28:
  %t359 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t360 = load %EnumParseResult, %EnumParseResult* %l19
  %t361 = extractvalue %EnumParseResult %t360, 0
  %t362 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t359, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t362, { %NativeEnum*, i64 }** %l6
  br label %merge29
merge29:
  %t363 = phi { %NativeEnum*, i64 }* [ %t362, %then28 ], [ %t350, %then26 ]
  store { %NativeEnum*, i64 }* %t363, { %NativeEnum*, i64 }** %l6
  %t364 = load %EnumParseResult, %EnumParseResult* %l19
  %t365 = extractvalue %EnumParseResult %t364, 1
  store double %t365, double* %l11
  br label %loop.latch2
merge27:
  %t366 = load i8*, i8** %l13
  %s367 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.367, i32 0, i32 0
  %t368 = call i1 @starts_with(i8* %t366, i8* %s367)
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t371 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t372 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t373 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t374 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t375 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t376 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t377 = load i8*, i8** %l8
  %t378 = load i8*, i8** %l9
  %t379 = load i8*, i8** %l10
  %t380 = load double, double* %l11
  %t381 = load i8*, i8** %l12
  %t382 = load i8*, i8** %l13
  br i1 %t368, label %then30, label %merge31
then30:
  %t383 = load i8*, i8** %l8
  %t384 = icmp ne i8* %t383, null
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t387 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t388 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t389 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t390 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t391 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t392 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t393 = load i8*, i8** %l8
  %t394 = load i8*, i8** %l9
  %t395 = load i8*, i8** %l10
  %t396 = load double, double* %l11
  %t397 = load i8*, i8** %l12
  %t398 = load i8*, i8** %l13
  br i1 %t384, label %then32, label %merge33
then32:
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s400 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.400, i32 0, i32 0
  %t401 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t399, i8* %s400)
  store { i8**, i64 }* %t401, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t402 = phi { i8**, i64 }* [ %t401, %then32 ], [ %t386, %then30 ]
  store { i8**, i64 }* %t402, { i8**, i64 }** %l1
  %t403 = load i8*, i8** %l13
  %s404 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.404, i32 0, i32 0
  %t405 = call i8* @strip_prefix(i8* %t403, i8* %s404)
  %t406 = call i8* @parse_function_name(i8* %t405)
  %t407 = insertvalue %NativeFunction undef, i8* %t406, 0
  %t408 = alloca [0 x i8*]
  %t409 = getelementptr [0 x i8*], [0 x i8*]* %t408, i32 0, i32 0
  %t410 = alloca { i8**, i64 }
  %t411 = getelementptr { i8**, i64 }, { i8**, i64 }* %t410, i32 0, i32 0
  store i8** %t409, i8*** %t411
  %t412 = getelementptr { i8**, i64 }, { i8**, i64 }* %t410, i32 0, i32 1
  store i64 0, i64* %t412
  %t413 = insertvalue %NativeFunction %t407, { i8**, i64 }* %t410, 1
  %s414 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.414, i32 0, i32 0
  %t415 = insertvalue %NativeFunction %t413, i8* %s414, 2
  %t416 = alloca [0 x i8*]
  %t417 = getelementptr [0 x i8*], [0 x i8*]* %t416, i32 0, i32 0
  %t418 = alloca { i8**, i64 }
  %t419 = getelementptr { i8**, i64 }, { i8**, i64 }* %t418, i32 0, i32 0
  store i8** %t417, i8*** %t419
  %t420 = getelementptr { i8**, i64 }, { i8**, i64 }* %t418, i32 0, i32 1
  store i64 0, i64* %t420
  %t421 = insertvalue %NativeFunction %t415, { i8**, i64 }* %t418, 3
  %t422 = alloca [0 x i8*]
  %t423 = getelementptr [0 x i8*], [0 x i8*]* %t422, i32 0, i32 0
  %t424 = alloca { i8**, i64 }
  %t425 = getelementptr { i8**, i64 }, { i8**, i64 }* %t424, i32 0, i32 0
  store i8** %t423, i8*** %t425
  %t426 = getelementptr { i8**, i64 }, { i8**, i64 }* %t424, i32 0, i32 1
  store i64 0, i64* %t426
  %t427 = insertvalue %NativeFunction %t421, { i8**, i64 }* %t424, 4
  store i8* null, i8** %l8
  %t428 = load double, double* %l11
  %t429 = sitofp i64 1 to double
  %t430 = fadd double %t428, %t429
  store double %t430, double* %l11
  br label %loop.latch2
merge31:
  %t431 = load i8*, i8** %l13
  %s432 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.432, i32 0, i32 0
  %t433 = call i1 @starts_with(i8* %t431, i8* %s432)
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t436 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t437 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t438 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t439 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t440 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t441 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t442 = load i8*, i8** %l8
  %t443 = load i8*, i8** %l9
  %t444 = load i8*, i8** %l10
  %t445 = load double, double* %l11
  %t446 = load i8*, i8** %l12
  %t447 = load i8*, i8** %l13
  br i1 %t433, label %then34, label %merge35
then34:
  %t448 = load i8*, i8** %l8
  %t449 = icmp eq i8* %t448, null
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t452 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t453 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t454 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t455 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t456 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t457 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t458 = load i8*, i8** %l8
  %t459 = load i8*, i8** %l9
  %t460 = load i8*, i8** %l10
  %t461 = load double, double* %l11
  %t462 = load i8*, i8** %l12
  %t463 = load i8*, i8** %l13
  br i1 %t449, label %then36, label %else37
then36:
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s465 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.465, i32 0, i32 0
  %t466 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t464, i8* %s465)
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  br label %merge38
else37:
  %t467 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t468 = load i8*, i8** %l8
  %t469 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t467, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t469, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge38
merge38:
  %t470 = phi { i8**, i64 }* [ %t466, %then36 ], [ %t451, %else37 ]
  %t471 = phi { %NativeFunction*, i64 }* [ %t452, %then36 ], [ %t469, %else37 ]
  %t472 = phi i8* [ %t458, %then36 ], [ null, %else37 ]
  store { i8**, i64 }* %t470, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t471, { %NativeFunction*, i64 }** %l2
  store i8* %t472, i8** %l8
  %t473 = load double, double* %l11
  %t474 = sitofp i64 1 to double
  %t475 = fadd double %t473, %t474
  store double %t475, double* %l11
  br label %loop.latch2
merge35:
  %t476 = load i8*, i8** %l13
  %s477 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.477, i32 0, i32 0
  %t478 = call i1 @starts_with(i8* %t476, i8* %s477)
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t481 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t482 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t483 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t484 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t485 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t486 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t487 = load i8*, i8** %l8
  %t488 = load i8*, i8** %l9
  %t489 = load i8*, i8** %l10
  %t490 = load double, double* %l11
  %t491 = load i8*, i8** %l12
  %t492 = load i8*, i8** %l13
  br i1 %t478, label %then39, label %merge40
then39:
  %t493 = load i8*, i8** %l8
  %t494 = icmp ne i8* %t493, null
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t497 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t498 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t499 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t500 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t501 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t502 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t503 = load i8*, i8** %l8
  %t504 = load i8*, i8** %l9
  %t505 = load i8*, i8** %l10
  %t506 = load double, double* %l11
  %t507 = load i8*, i8** %l12
  %t508 = load i8*, i8** %l13
  br i1 %t494, label %then41, label %else42
then41:
  %t509 = load i8*, i8** %l8
  %t510 = load i8*, i8** %l13
  %s511 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.511, i32 0, i32 0
  %t512 = call i8* @strip_prefix(i8* %t510, i8* %s511)
  %t513 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t512)
  store i8* null, i8** %l8
  br label %merge43
else42:
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s515 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.515, i32 0, i32 0
  %t516 = load i8*, i8** %l13
  %t517 = add i8* %s515, %t516
  %t518 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t514, i8* %t517)
  store { i8**, i64 }* %t518, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t519 = phi i8* [ null, %then41 ], [ %t503, %else42 ]
  %t520 = phi { i8**, i64 }* [ %t496, %then41 ], [ %t518, %else42 ]
  store i8* %t519, i8** %l8
  store { i8**, i64 }* %t520, { i8**, i64 }** %l1
  %t521 = load double, double* %l11
  %t522 = sitofp i64 1 to double
  %t523 = fadd double %t521, %t522
  store double %t523, double* %l11
  br label %loop.latch2
merge40:
  %t524 = load i8*, i8** %l13
  %s525 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.525, i32 0, i32 0
  %t526 = call i1 @starts_with(i8* %t524, i8* %s525)
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t529 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t530 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t531 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t532 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t533 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t534 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t535 = load i8*, i8** %l8
  %t536 = load i8*, i8** %l9
  %t537 = load i8*, i8** %l10
  %t538 = load double, double* %l11
  %t539 = load i8*, i8** %l12
  %t540 = load i8*, i8** %l13
  br i1 %t526, label %then44, label %merge45
then44:
  %t541 = load i8*, i8** %l8
  %t542 = icmp ne i8* %t541, null
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t545 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t546 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t547 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t548 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t549 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t550 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t551 = load i8*, i8** %l8
  %t552 = load i8*, i8** %l9
  %t553 = load i8*, i8** %l10
  %t554 = load double, double* %l11
  %t555 = load i8*, i8** %l12
  %t556 = load i8*, i8** %l13
  br i1 %t542, label %then46, label %else47
then46:
  %t557 = load i8*, i8** %l13
  %s558 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.558, i32 0, i32 0
  %t559 = call i8* @strip_prefix(i8* %t557, i8* %s558)
  store i8* %t559, i8** %l20
  %t560 = load double, double* %l11
  %t561 = sitofp i64 1 to double
  %t562 = fadd double %t560, %t561
  store double %t562, double* %l21
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t565 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t566 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t567 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t568 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t569 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t570 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t571 = load i8*, i8** %l8
  %t572 = load i8*, i8** %l9
  %t573 = load i8*, i8** %l10
  %t574 = load double, double* %l11
  %t575 = load i8*, i8** %l12
  %t576 = load i8*, i8** %l13
  %t577 = load i8*, i8** %l20
  %t578 = load double, double* %l21
  br label %loop.header49
loop.header49:
  %t694 = phi double [ %t578, %then46 ], [ %t692, %loop.latch51 ]
  %t695 = phi i8* [ %t577, %then46 ], [ %t693, %loop.latch51 ]
  store double %t694, double* %l21
  store i8* %t695, i8** %l20
  br label %loop.body50
loop.body50:
  %t579 = load double, double* %l21
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t581 = load { i8**, i64 }, { i8**, i64 }* %t580
  %t582 = extractvalue { i8**, i64 } %t581, 1
  %t583 = sitofp i64 %t582 to double
  %t584 = fcmp oge double %t579, %t583
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t587 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t588 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t589 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t590 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t591 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t592 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t593 = load i8*, i8** %l8
  %t594 = load i8*, i8** %l9
  %t595 = load i8*, i8** %l10
  %t596 = load double, double* %l11
  %t597 = load i8*, i8** %l12
  %t598 = load i8*, i8** %l13
  %t599 = load i8*, i8** %l20
  %t600 = load double, double* %l21
  br i1 %t584, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t602 = load double, double* %l21
  %t603 = fptosi double %t602 to i64
  %t604 = load { i8**, i64 }, { i8**, i64 }* %t601
  %t605 = extractvalue { i8**, i64 } %t604, 0
  %t606 = extractvalue { i8**, i64 } %t604, 1
  %t607 = icmp uge i64 %t603, %t606
  ; bounds check: %t607 (if true, out of bounds)
  %t608 = getelementptr i8*, i8** %t605, i64 %t603
  %t609 = load i8*, i8** %t608
  store i8* %t609, i8** %l22
  %t610 = load i8*, i8** %l22
  %t611 = call i64 @sailfin_runtime_string_length(i8* %t610)
  %t612 = icmp eq i64 %t611, 0
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t614 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t615 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t616 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t617 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t618 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t619 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t620 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t621 = load i8*, i8** %l8
  %t622 = load i8*, i8** %l9
  %t623 = load i8*, i8** %l10
  %t624 = load double, double* %l11
  %t625 = load i8*, i8** %l12
  %t626 = load i8*, i8** %l13
  %t627 = load i8*, i8** %l20
  %t628 = load double, double* %l21
  %t629 = load i8*, i8** %l22
  br i1 %t612, label %then55, label %merge56
then55:
  br label %afterloop52
merge56:
  %t630 = load i8*, i8** %l22
  %t631 = call i8* @trim_text(i8* %t630)
  store i8* %t631, i8** %l23
  %t632 = load i8*, i8** %l23
  %t633 = call i64 @sailfin_runtime_string_length(i8* %t632)
  %t634 = icmp eq i64 %t633, 0
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t637 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t638 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t639 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t640 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t641 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t642 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t643 = load i8*, i8** %l8
  %t644 = load i8*, i8** %l9
  %t645 = load i8*, i8** %l10
  %t646 = load double, double* %l11
  %t647 = load i8*, i8** %l12
  %t648 = load i8*, i8** %l13
  %t649 = load i8*, i8** %l20
  %t650 = load double, double* %l21
  %t651 = load i8*, i8** %l22
  %t652 = load i8*, i8** %l23
  br i1 %t634, label %then57, label %merge58
then57:
  %t653 = load double, double* %l21
  %t654 = sitofp i64 1 to double
  %t655 = fadd double %t653, %t654
  store double %t655, double* %l21
  br label %loop.latch51
merge58:
  %t656 = load i8*, i8** %l23
  %t657 = call i1 @line_looks_like_parameter_entry(i8* %t656)
  %t658 = xor i1 %t657, 1
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t661 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t662 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t663 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t664 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t665 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t666 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t667 = load i8*, i8** %l8
  %t668 = load i8*, i8** %l9
  %t669 = load i8*, i8** %l10
  %t670 = load double, double* %l11
  %t671 = load i8*, i8** %l12
  %t672 = load i8*, i8** %l13
  %t673 = load i8*, i8** %l20
  %t674 = load double, double* %l21
  %t675 = load i8*, i8** %l22
  %t676 = load i8*, i8** %l23
  br i1 %t658, label %then59, label %merge60
then59:
  br label %afterloop52
merge60:
  %t677 = load i8*, i8** %l20
  %t678 = getelementptr i8, i8* %t677, i64 0
  %t679 = load i8, i8* %t678
  %t680 = add i8 %t679, 32
  %t681 = load i8*, i8** %l23
  %t682 = getelementptr i8, i8* %t681, i64 0
  %t683 = load i8, i8* %t682
  %t684 = add i8 %t680, %t683
  %t685 = alloca [2 x i8], align 1
  %t686 = getelementptr [2 x i8], [2 x i8]* %t685, i32 0, i32 0
  store i8 %t684, i8* %t686
  %t687 = getelementptr [2 x i8], [2 x i8]* %t685, i32 0, i32 1
  store i8 0, i8* %t687
  %t688 = getelementptr [2 x i8], [2 x i8]* %t685, i32 0, i32 0
  store i8* %t688, i8** %l20
  %t689 = load double, double* %l21
  %t690 = sitofp i64 1 to double
  %t691 = fadd double %t689, %t690
  store double %t691, double* %l21
  br label %loop.latch51
loop.latch51:
  %t692 = load double, double* %l21
  %t693 = load i8*, i8** %l20
  br label %loop.header49
afterloop52:
  %t696 = load i8*, i8** %l20
  %t697 = call { i8**, i64 }* @split_parameter_entries(i8* %t696)
  store { i8**, i64 }* %t697, { i8**, i64 }** %l24
  %t698 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t699 = load { i8**, i64 }, { i8**, i64 }* %t698
  %t700 = extractvalue { i8**, i64 } %t699, 1
  %t701 = icmp eq i64 %t700, 0
  %t702 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t704 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t705 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t706 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t707 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t708 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t709 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t710 = load i8*, i8** %l8
  %t711 = load i8*, i8** %l9
  %t712 = load i8*, i8** %l10
  %t713 = load double, double* %l11
  %t714 = load i8*, i8** %l12
  %t715 = load i8*, i8** %l13
  %t716 = load i8*, i8** %l20
  %t717 = load double, double* %l21
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br i1 %t701, label %then61, label %else62
then61:
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s720 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.720, i32 0, i32 0
  %t721 = load i8*, i8** %l13
  %t722 = add i8* %s720, %t721
  %t723 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t719, i8* %t722)
  store { i8**, i64 }* %t723, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge63
else62:
  %t724 = sitofp i64 0 to double
  store double %t724, double* %l25
  store i1 0, i1* %l26
  %t725 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t726 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t727 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t728 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t729 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t730 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t731 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t732 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t733 = load i8*, i8** %l8
  %t734 = load i8*, i8** %l9
  %t735 = load i8*, i8** %l10
  %t736 = load double, double* %l11
  %t737 = load i8*, i8** %l12
  %t738 = load i8*, i8** %l13
  %t739 = load i8*, i8** %l20
  %t740 = load double, double* %l21
  %t741 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t742 = load double, double* %l25
  %t743 = load i1, i1* %l26
  br label %loop.header64
loop.header64:
  %t810 = phi double [ %t742, %else62 ], [ %t809, %loop.latch66 ]
  store double %t810, double* %l25
  br label %loop.body65
loop.body65:
  %t744 = load double, double* %l25
  %t745 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t746 = load { i8**, i64 }, { i8**, i64 }* %t745
  %t747 = extractvalue { i8**, i64 } %t746, 1
  %t748 = sitofp i64 %t747 to double
  %t749 = fcmp oge double %t744, %t748
  %t750 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t751 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t752 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t753 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t754 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t755 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t756 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t757 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t758 = load i8*, i8** %l8
  %t759 = load i8*, i8** %l9
  %t760 = load i8*, i8** %l10
  %t761 = load double, double* %l11
  %t762 = load i8*, i8** %l12
  %t763 = load i8*, i8** %l13
  %t764 = load i8*, i8** %l20
  %t765 = load double, double* %l21
  %t766 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t767 = load double, double* %l25
  %t768 = load i1, i1* %l26
  br i1 %t749, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t770 = load double, double* %l25
  %t771 = fptosi double %t770 to i64
  %t772 = load { i8**, i64 }, { i8**, i64 }* %t769
  %t773 = extractvalue { i8**, i64 } %t772, 0
  %t774 = extractvalue { i8**, i64 } %t772, 1
  %t775 = icmp uge i64 %t771, %t774
  ; bounds check: %t775 (if true, out of bounds)
  %t776 = getelementptr i8*, i8** %t773, i64 %t771
  %t777 = load i8*, i8** %t776
  store i8* %t777, i8** %l27
  %t778 = load i8*, i8** %l9
  store i8* %t778, i8** %l28
  %t779 = load i1, i1* %l26
  %t780 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t781 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t782 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t783 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t784 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t785 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t786 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t787 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t788 = load i8*, i8** %l8
  %t789 = load i8*, i8** %l9
  %t790 = load i8*, i8** %l10
  %t791 = load double, double* %l11
  %t792 = load i8*, i8** %l12
  %t793 = load i8*, i8** %l13
  %t794 = load i8*, i8** %l20
  %t795 = load double, double* %l21
  %t796 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t797 = load double, double* %l25
  %t798 = load i1, i1* %l26
  %t799 = load i8*, i8** %l27
  %t800 = load i8*, i8** %l28
  br i1 %t779, label %then70, label %merge71
then70:
  store i8* null, i8** %l28
  br label %merge71
merge71:
  %t801 = phi i8* [ null, %then70 ], [ %t800, %loop.body65 ]
  store i8* %t801, i8** %l28
  %t802 = load i8*, i8** %l27
  %t803 = load i8*, i8** %l28
  %t804 = call double @parse_parameter_entry(i8* %t802, i8* %t803)
  store double %t804, double* %l29
  %t805 = load double, double* %l29
  %t806 = load double, double* %l25
  %t807 = sitofp i64 1 to double
  %t808 = fadd double %t806, %t807
  store double %t808, double* %l25
  br label %loop.latch66
loop.latch66:
  %t809 = load double, double* %l25
  br label %loop.header64
afterloop67:
  store i8* null, i8** %l9
  br label %merge63
merge63:
  %t811 = phi { i8**, i64 }* [ %t723, %then61 ], [ %t703, %else62 ]
  %t812 = phi i8* [ null, %then61 ], [ null, %else62 ]
  store { i8**, i64 }* %t811, { i8**, i64 }** %l1
  store i8* %t812, i8** %l9
  %t813 = load double, double* %l21
  %t814 = sitofp i64 1 to double
  %t815 = fsub double %t813, %t814
  store double %t815, double* %l11
  br label %merge48
else47:
  %t816 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s817 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.817, i32 0, i32 0
  %t818 = load i8*, i8** %l13
  %t819 = add i8* %s817, %t818
  %t820 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t816, i8* %t819)
  store { i8**, i64 }* %t820, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t821 = phi { i8**, i64 }* [ %t723, %then46 ], [ %t820, %else47 ]
  %t822 = phi i8* [ null, %then46 ], [ %t552, %else47 ]
  %t823 = phi double [ %t815, %then46 ], [ %t554, %else47 ]
  store { i8**, i64 }* %t821, { i8**, i64 }** %l1
  store i8* %t822, i8** %l9
  store double %t823, double* %l11
  %t824 = load double, double* %l11
  %t825 = sitofp i64 1 to double
  %t826 = fadd double %t824, %t825
  store double %t826, double* %l11
  br label %loop.latch2
merge45:
  %t827 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t828 = load double, double* %l11
  %t829 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t827, double %t828)
  store %InstructionGatherResult %t829, %InstructionGatherResult* %l30
  %t830 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t831 = extractvalue %InstructionGatherResult %t830, 0
  store i8* %t831, i8** %l13
  %t832 = load double, double* %l11
  %t833 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t834 = extractvalue %InstructionGatherResult %t833, 1
  %t835 = fadd double %t832, %t834
  store double %t835, double* %l11
  %t836 = load i8*, i8** %l13
  %t837 = load i8*, i8** %l9
  %t838 = load i8*, i8** %l10
  %t839 = call %InstructionParseResult @parse_instruction(i8* %t836, i8* %t837, i8* %t838)
  store %InstructionParseResult %t839, %InstructionParseResult* %l31
  %t840 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t841 = extractvalue %InstructionParseResult %t840, 0
  store { i8**, i64 }* %t841, { i8**, i64 }** %l32
  %t842 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t843 = extractvalue %InstructionParseResult %t842, 1
  %t844 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t845 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t846 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t847 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t848 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t849 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t850 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t851 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t852 = load i8*, i8** %l8
  %t853 = load i8*, i8** %l9
  %t854 = load i8*, i8** %l10
  %t855 = load double, double* %l11
  %t856 = load i8*, i8** %l12
  %t857 = load i8*, i8** %l13
  %t858 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t859 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t843, label %then72, label %else73
then72:
  store i8* null, i8** %l9
  br label %merge74
else73:
  %t861 = load i8*, i8** %l9
  %t862 = icmp ne i8* %t861, null
  %t863 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t864 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t865 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t866 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t867 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t868 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t869 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t870 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t871 = load i8*, i8** %l8
  %t872 = load i8*, i8** %l9
  %t873 = load i8*, i8** %l10
  %t874 = load double, double* %l11
  %t875 = load i8*, i8** %l12
  %t876 = load i8*, i8** %l13
  %t877 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t878 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t879 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t862, label %then75, label %merge76
then75:
  %t880 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s881 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.881, i32 0, i32 0
  %t882 = load i8*, i8** %l13
  %t883 = add i8* %s881, %t882
  %t884 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t880, i8* %t883)
  store { i8**, i64 }* %t884, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge76
merge76:
  %t885 = phi { i8**, i64 }* [ %t884, %then75 ], [ %t864, %else73 ]
  %t886 = phi i8* [ null, %then75 ], [ %t872, %else73 ]
  store { i8**, i64 }* %t885, { i8**, i64 }** %l1
  store i8* %t886, i8** %l9
  br label %merge74
merge74:
  %t887 = phi i8* [ null, %then72 ], [ null, %else73 ]
  %t888 = phi { i8**, i64 }* [ %t845, %then72 ], [ %t884, %else73 ]
  store i8* %t887, i8** %l9
  store { i8**, i64 }* %t888, { i8**, i64 }** %l1
  %t889 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t890 = extractvalue %InstructionParseResult %t889, 2
  %t891 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t892 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t893 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t894 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t895 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t896 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t897 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t898 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t899 = load i8*, i8** %l8
  %t900 = load i8*, i8** %l9
  %t901 = load i8*, i8** %l10
  %t902 = load double, double* %l11
  %t903 = load i8*, i8** %l12
  %t904 = load i8*, i8** %l13
  %t905 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t906 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t907 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t890, label %then77, label %else78
then77:
  store i8* null, i8** %l10
  br label %merge79
else78:
  %t908 = load i8*, i8** %l10
  %t909 = icmp ne i8* %t908, null
  %t910 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t912 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t913 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t914 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t915 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t916 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t917 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t918 = load i8*, i8** %l8
  %t919 = load i8*, i8** %l9
  %t920 = load i8*, i8** %l10
  %t921 = load double, double* %l11
  %t922 = load i8*, i8** %l12
  %t923 = load i8*, i8** %l13
  %t924 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t925 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t909, label %then80, label %merge81
then80:
  %t927 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s928 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.928, i32 0, i32 0
  %t929 = load i8*, i8** %l13
  %t930 = add i8* %s928, %t929
  %t931 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t927, i8* %t930)
  store { i8**, i64 }* %t931, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge81
merge81:
  %t932 = phi { i8**, i64 }* [ %t931, %then80 ], [ %t911, %else78 ]
  %t933 = phi i8* [ null, %then80 ], [ %t920, %else78 ]
  store { i8**, i64 }* %t932, { i8**, i64 }** %l1
  store i8* %t933, i8** %l10
  br label %merge79
merge79:
  %t934 = phi i8* [ null, %then77 ], [ null, %else78 ]
  %t935 = phi { i8**, i64 }* [ %t892, %then77 ], [ %t931, %else78 ]
  store i8* %t934, i8** %l10
  store { i8**, i64 }* %t935, { i8**, i64 }** %l1
  %t936 = load i8*, i8** %l8
  %t937 = icmp eq i8* %t936, null
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t939 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t940 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t941 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t942 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t943 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t944 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t945 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t946 = load i8*, i8** %l8
  %t947 = load i8*, i8** %l9
  %t948 = load i8*, i8** %l10
  %t949 = load double, double* %l11
  %t950 = load i8*, i8** %l12
  %t951 = load i8*, i8** %l13
  %t952 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t953 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t954 = load { i8**, i64 }*, { i8**, i64 }** %l32
  br i1 %t937, label %then82, label %merge83
then82:
  %t956 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t957 = load { i8**, i64 }, { i8**, i64 }* %t956
  %t958 = extractvalue { i8**, i64 } %t957, 1
  %t959 = icmp eq i64 %t958, 1
  br label %logical_and_entry_955

logical_and_entry_955:
  br i1 %t959, label %logical_and_right_955, label %logical_and_merge_955

logical_and_right_955:
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t961 = load { i8**, i64 }, { i8**, i64 }* %t960
  %t962 = extractvalue { i8**, i64 } %t961, 0
  %t963 = extractvalue { i8**, i64 } %t961, 1
  %t964 = icmp uge i64 0, %t963
  ; bounds check: %t964 (if true, out of bounds)
  %t965 = getelementptr i8*, i8** %t962, i64 0
  %t966 = load i8*, i8** %t965
  %t967 = load double, double* %l11
  %t968 = sitofp i64 1 to double
  %t969 = fadd double %t967, %t968
  store double %t969, double* %l11
  br label %loop.latch2
merge83:
  %t970 = sitofp i64 0 to double
  store double %t970, double* %l33
  %t971 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t972 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t973 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t974 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t975 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t976 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t977 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t978 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t979 = load i8*, i8** %l8
  %t980 = load i8*, i8** %l9
  %t981 = load i8*, i8** %l10
  %t982 = load double, double* %l11
  %t983 = load i8*, i8** %l12
  %t984 = load i8*, i8** %l13
  %t985 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t986 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t987 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t988 = load double, double* %l33
  br label %loop.header84
loop.header84:
  %t1029 = phi i8* [ %t979, %loop.body1 ], [ %t1027, %loop.latch86 ]
  %t1030 = phi double [ %t988, %loop.body1 ], [ %t1028, %loop.latch86 ]
  store i8* %t1029, i8** %l8
  store double %t1030, double* %l33
  br label %loop.body85
loop.body85:
  %t989 = load double, double* %l33
  %t990 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t991 = load { i8**, i64 }, { i8**, i64 }* %t990
  %t992 = extractvalue { i8**, i64 } %t991, 1
  %t993 = sitofp i64 %t992 to double
  %t994 = fcmp oge double %t989, %t993
  %t995 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t996 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t997 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t998 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t999 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1000 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1001 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1002 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1003 = load i8*, i8** %l8
  %t1004 = load i8*, i8** %l9
  %t1005 = load i8*, i8** %l10
  %t1006 = load double, double* %l11
  %t1007 = load i8*, i8** %l12
  %t1008 = load i8*, i8** %l13
  %t1009 = load %InstructionGatherResult, %InstructionGatherResult* %l30
  %t1010 = load %InstructionParseResult, %InstructionParseResult* %l31
  %t1011 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t1012 = load double, double* %l33
  br i1 %t994, label %then88, label %merge89
then88:
  br label %afterloop87
merge89:
  %t1013 = load i8*, i8** %l8
  %t1014 = load { i8**, i64 }*, { i8**, i64 }** %l32
  %t1015 = load double, double* %l33
  %t1016 = fptosi double %t1015 to i64
  %t1017 = load { i8**, i64 }, { i8**, i64 }* %t1014
  %t1018 = extractvalue { i8**, i64 } %t1017, 0
  %t1019 = extractvalue { i8**, i64 } %t1017, 1
  %t1020 = icmp uge i64 %t1016, %t1019
  ; bounds check: %t1020 (if true, out of bounds)
  %t1021 = getelementptr i8*, i8** %t1018, i64 %t1016
  %t1022 = load i8*, i8** %t1021
  %t1023 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t1024 = load double, double* %l33
  %t1025 = sitofp i64 1 to double
  %t1026 = fadd double %t1024, %t1025
  store double %t1026, double* %l33
  br label %loop.latch86
loop.latch86:
  %t1027 = load i8*, i8** %l8
  %t1028 = load double, double* %l33
  br label %loop.header84
afterloop87:
  %t1031 = load double, double* %l11
  %t1032 = sitofp i64 1 to double
  %t1033 = fadd double %t1031, %t1032
  store double %t1033, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1034 = load double, double* %l11
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1036 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1037 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1038 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1039 = load i8*, i8** %l8
  %t1040 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1041 = load i8*, i8** %l9
  %t1042 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t1052 = load i8*, i8** %l8
  %t1053 = icmp ne i8* %t1052, null
  %t1054 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1055 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1056 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1057 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1058 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1059 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1060 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1061 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1062 = load i8*, i8** %l8
  %t1063 = load i8*, i8** %l9
  %t1064 = load i8*, i8** %l10
  %t1065 = load double, double* %l11
  br i1 %t1053, label %then90, label %merge91
then90:
  %t1066 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1067 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.1067, i32 0, i32 0
  %t1068 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1066, i8* %s1067)
  store { i8**, i64 }* %t1068, { i8**, i64 }** %l1
  br label %merge91
merge91:
  %t1069 = phi { i8**, i64 }* [ %t1068, %then90 ], [ %t1055, %entry ]
  store { i8**, i64 }* %t1069, { i8**, i64 }** %l1
  %t1070 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1071 = bitcast { %NativeFunction*, i64 }* %t1070 to { i8**, i64 }*
  %t1072 = insertvalue %ParseNativeResult undef, { i8**, i64 }* %t1071, 0
  %t1073 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1074 = bitcast { %NativeImport*, i64 }* %t1073 to { i8**, i64 }*
  %t1075 = insertvalue %ParseNativeResult %t1072, { i8**, i64 }* %t1074, 1
  %t1076 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1077 = bitcast { %NativeStruct*, i64 }* %t1076 to { i8**, i64 }*
  %t1078 = insertvalue %ParseNativeResult %t1075, { i8**, i64 }* %t1077, 2
  %t1079 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1080 = bitcast { %NativeInterface*, i64 }* %t1079 to { i8**, i64 }*
  %t1081 = insertvalue %ParseNativeResult %t1078, { i8**, i64 }* %t1080, 3
  %t1082 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1083 = bitcast { %NativeEnum*, i64 }* %t1082 to { i8**, i64 }*
  %t1084 = insertvalue %ParseNativeResult %t1081, { i8**, i64 }* %t1083, 4
  %t1085 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1086 = bitcast { %NativeBinding*, i64 }* %t1085 to { i8**, i64 }*
  %t1087 = insertvalue %ParseNativeResult %t1084, { i8**, i64 }* %t1086, 5
  %t1088 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1089 = insertvalue %ParseNativeResult %t1087, { i8**, i64 }* %t1088, 6
  ret %ParseNativeResult %t1089
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
  %t125 = phi i8* [ %t50, %entry ], [ %t121, %loop.latch10 ]
  %t126 = phi %InstructionDepthState [ %t49, %entry ], [ %t122, %loop.latch10 ]
  %t127 = phi double [ %t51, %entry ], [ %t123, %loop.latch10 ]
  %t128 = phi double [ %t52, %entry ], [ %t124, %loop.latch10 ]
  store i8* %t125, i8** %l2
  store %InstructionDepthState %t126, %InstructionDepthState* %l1
  store double %t127, double* %l3
  store double %t128, double* %l4
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
  %t85 = alloca [2 x i8], align 1
  %t86 = getelementptr [2 x i8], [2 x i8]* %t85, i32 0, i32 0
  store i8 %t84, i8* %t86
  %t87 = getelementptr [2 x i8], [2 x i8]* %t85, i32 0, i32 1
  store i8 0, i8* %t87
  %t88 = getelementptr [2 x i8], [2 x i8]* %t85, i32 0, i32 0
  store i8* %t88, i8** %l2
  br label %merge16
else15:
  %t89 = load i8*, i8** %l2
  %t90 = getelementptr i8, i8* %t89, i64 0
  %t91 = load i8, i8* %t90
  %t92 = add i8 %t91, 10
  %t93 = load i8*, i8** %l5
  %t94 = getelementptr i8, i8* %t93, i64 0
  %t95 = load i8, i8* %t94
  %t96 = add i8 %t92, %t95
  %t97 = alloca [2 x i8], align 1
  %t98 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8 %t96, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 1
  store i8 0, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8* %t100, i8** %l2
  %t101 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t102 = load i8*, i8** %l5
  %t103 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t101, i8* %t102)
  store %InstructionDepthState %t103, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t104 = phi i8* [ %t88, %then14 ], [ %t100, %else15 ]
  %t105 = phi %InstructionDepthState [ %t76, %then14 ], [ %t103, %else15 ]
  store i8* %t104, i8** %l2
  store %InstructionDepthState %t105, %InstructionDepthState* %l1
  %t106 = load double, double* %l3
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l3
  %t109 = load double, double* %l4
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  store double %t111, double* %l4
  %t112 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t113 = call i1 @instruction_requires_continuation(%InstructionDepthState %t112)
  %t114 = xor i1 %t113, 1
  %t115 = load i8*, i8** %l0
  %t116 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t117 = load i8*, i8** %l2
  %t118 = load double, double* %l3
  %t119 = load double, double* %l4
  %t120 = load i8*, i8** %l5
  br i1 %t114, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t121 = load i8*, i8** %l2
  %t122 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t123 = load double, double* %l3
  %t124 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t129 = load i8*, i8** %l2
  %t130 = call i8* @trim_text(i8* %t129)
  store i8* %t130, i8** %l6
  %t131 = load i8*, i8** %l6
  %t132 = insertvalue %InstructionGatherResult undef, i8* %t131, 0
  %t133 = load double, double* %l3
  %t134 = insertvalue %InstructionGatherResult %t132, double %t133, 1
  ret %InstructionGatherResult %t134
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
  %t978 = phi { i8**, i64 }* [ %t60, %entry ], [ %t967, %loop.latch4 ]
  %t979 = phi double [ %t76, %entry ], [ %t968, %loop.latch4 ]
  %t980 = phi { %NativeFunction*, i64 }* [ %t67, %entry ], [ %t969, %loop.latch4 ]
  %t981 = phi i8* [ %t68, %entry ], [ %t970, %loop.latch4 ]
  %t982 = phi i8* [ %t69, %entry ], [ %t971, %loop.latch4 ]
  %t983 = phi i8* [ %t70, %entry ], [ %t972, %loop.latch4 ]
  %t984 = phi double [ %t72, %entry ], [ %t973, %loop.latch4 ]
  %t985 = phi double [ %t73, %entry ], [ %t974, %loop.latch4 ]
  %t986 = phi i1 [ %t74, %entry ], [ %t975, %loop.latch4 ]
  %t987 = phi { %NativeStructLayoutField*, i64 }* [ %t71, %entry ], [ %t976, %loop.latch4 ]
  %t988 = phi i1 [ %t75, %entry ], [ %t977, %loop.latch4 ]
  store { i8**, i64 }* %t978, { i8**, i64 }** %l0
  store double %t979, double* %l16
  store { %NativeFunction*, i64 }* %t980, { %NativeFunction*, i64 }** %l7
  store i8* %t981, i8** %l8
  store i8* %t982, i8** %l9
  store i8* %t983, i8** %l10
  store double %t984, double* %l12
  store double %t985, double* %l13
  store i1 %t986, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t987, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t988, i1* %l15
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
  %t162 = alloca [2 x i8], align 1
  %t163 = getelementptr [2 x i8], [2 x i8]* %t162, i32 0, i32 0
  store i8 59, i8* %t163
  %t164 = getelementptr [2 x i8], [2 x i8]* %t162, i32 0, i32 1
  store i8 0, i8* %t164
  %t165 = getelementptr [2 x i8], [2 x i8]* %t162, i32 0, i32 0
  %t166 = call i1 @starts_with(i8* %t161, i8* %t165)
  br label %logical_or_right_end_157

logical_or_right_end_157:
  br label %logical_or_merge_157

logical_or_merge_157:
  %t167 = phi i1 [ true, %logical_or_entry_157 ], [ %t166, %logical_or_right_end_157 ]
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load i8*, i8** %l1
  %t170 = load i8*, i8** %l2
  %t171 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t172 = load i8*, i8** %l4
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t174 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t175 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t176 = load i8*, i8** %l8
  %t177 = load i8*, i8** %l9
  %t178 = load i8*, i8** %l10
  %t179 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t180 = load double, double* %l12
  %t181 = load double, double* %l13
  %t182 = load i1, i1* %l14
  %t183 = load i1, i1* %l15
  %t184 = load double, double* %l16
  %t185 = load i8*, i8** %l18
  br i1 %t167, label %then10, label %merge11
then10:
  %t186 = load double, double* %l16
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  store double %t188, double* %l16
  br label %loop.latch4
merge11:
  %t189 = load i8*, i8** %l18
  %s190 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.190, i32 0, i32 0
  %t191 = icmp eq i8* %t189, %s190
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t193 = load i8*, i8** %l1
  %t194 = load i8*, i8** %l2
  %t195 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t196 = load i8*, i8** %l4
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t198 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t199 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t200 = load i8*, i8** %l8
  %t201 = load i8*, i8** %l9
  %t202 = load i8*, i8** %l10
  %t203 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t204 = load double, double* %l12
  %t205 = load double, double* %l13
  %t206 = load i1, i1* %l14
  %t207 = load i1, i1* %l15
  %t208 = load double, double* %l16
  %t209 = load i8*, i8** %l18
  br i1 %t191, label %then12, label %merge13
then12:
  %t210 = load i8*, i8** %l8
  %t211 = icmp ne i8* %t210, null
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load i8*, i8** %l1
  %t214 = load i8*, i8** %l2
  %t215 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t216 = load i8*, i8** %l4
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t218 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t219 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t220 = load i8*, i8** %l8
  %t221 = load i8*, i8** %l9
  %t222 = load i8*, i8** %l10
  %t223 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t224 = load double, double* %l12
  %t225 = load double, double* %l13
  %t226 = load i1, i1* %l14
  %t227 = load i1, i1* %l15
  %t228 = load double, double* %l16
  %t229 = load i8*, i8** %l18
  br i1 %t211, label %then14, label %merge15
then14:
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s231 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.231, i32 0, i32 0
  %t232 = load i8*, i8** %l4
  %t233 = add i8* %s231, %t232
  %t234 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t230, i8* %t233)
  store { i8**, i64 }* %t234, { i8**, i64 }** %l0
  %t235 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t236 = load i8*, i8** %l8
  %t237 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t235, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t237, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  br label %merge15
merge15:
  %t238 = phi { i8**, i64 }* [ %t234, %then14 ], [ %t212, %then12 ]
  %t239 = phi { %NativeFunction*, i64 }* [ %t237, %then14 ], [ %t219, %then12 ]
  %t240 = phi i8* [ null, %then14 ], [ %t220, %then12 ]
  %t241 = phi i8* [ null, %then14 ], [ %t221, %then12 ]
  %t242 = phi i8* [ null, %then14 ], [ %t222, %then12 ]
  store { i8**, i64 }* %t238, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t239, { %NativeFunction*, i64 }** %l7
  store i8* %t240, i8** %l8
  store i8* %t241, i8** %l9
  store i8* %t242, i8** %l10
  %t243 = load double, double* %l16
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l16
  br label %afterloop5
merge13:
  %t246 = load i8*, i8** %l8
  %t247 = icmp ne i8* %t246, null
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t249 = load i8*, i8** %l1
  %t250 = load i8*, i8** %l2
  %t251 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t252 = load i8*, i8** %l4
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t254 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t255 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t256 = load i8*, i8** %l8
  %t257 = load i8*, i8** %l9
  %t258 = load i8*, i8** %l10
  %t259 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t260 = load double, double* %l12
  %t261 = load double, double* %l13
  %t262 = load i1, i1* %l14
  %t263 = load i1, i1* %l15
  %t264 = load double, double* %l16
  %t265 = load i8*, i8** %l18
  br i1 %t247, label %then16, label %merge17
then16:
  %t266 = load i8*, i8** %l18
  %s267 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.267, i32 0, i32 0
  %t268 = icmp eq i8* %t266, %s267
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load i8*, i8** %l1
  %t271 = load i8*, i8** %l2
  %t272 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t273 = load i8*, i8** %l4
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t275 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t276 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t277 = load i8*, i8** %l8
  %t278 = load i8*, i8** %l9
  %t279 = load i8*, i8** %l10
  %t280 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t281 = load double, double* %l12
  %t282 = load double, double* %l13
  %t283 = load i1, i1* %l14
  %t284 = load i1, i1* %l15
  %t285 = load double, double* %l16
  %t286 = load i8*, i8** %l18
  br i1 %t268, label %then18, label %merge19
then18:
  %t287 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t288 = load i8*, i8** %l8
  %t289 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t287, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t289, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t290 = load double, double* %l16
  %t291 = sitofp i64 1 to double
  %t292 = fadd double %t290, %t291
  store double %t292, double* %l16
  br label %loop.latch4
merge19:
  %t293 = load i8*, i8** %l18
  %s294 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.294, i32 0, i32 0
  %t295 = call i1 @starts_with(i8* %t293, i8* %s294)
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t297 = load i8*, i8** %l1
  %t298 = load i8*, i8** %l2
  %t299 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t300 = load i8*, i8** %l4
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t302 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t303 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t304 = load i8*, i8** %l8
  %t305 = load i8*, i8** %l9
  %t306 = load i8*, i8** %l10
  %t307 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t308 = load double, double* %l12
  %t309 = load double, double* %l13
  %t310 = load i1, i1* %l14
  %t311 = load i1, i1* %l15
  %t312 = load double, double* %l16
  %t313 = load i8*, i8** %l18
  br i1 %t295, label %then20, label %merge21
then20:
  %t314 = load i8*, i8** %l8
  %t315 = load i8*, i8** %l18
  %s316 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.316, i32 0, i32 0
  %t317 = call i8* @strip_prefix(i8* %t315, i8* %s316)
  %t318 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t317)
  store i8* null, i8** %l8
  %t319 = load double, double* %l16
  %t320 = sitofp i64 1 to double
  %t321 = fadd double %t319, %t320
  store double %t321, double* %l16
  br label %loop.latch4
merge21:
  %t322 = load i8*, i8** %l18
  %s323 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.323, i32 0, i32 0
  %t324 = call i1 @starts_with(i8* %t322, i8* %s323)
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t326 = load i8*, i8** %l1
  %t327 = load i8*, i8** %l2
  %t328 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t329 = load i8*, i8** %l4
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t331 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t332 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t333 = load i8*, i8** %l8
  %t334 = load i8*, i8** %l9
  %t335 = load i8*, i8** %l10
  %t336 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t337 = load double, double* %l12
  %t338 = load double, double* %l13
  %t339 = load i1, i1* %l14
  %t340 = load i1, i1* %l15
  %t341 = load double, double* %l16
  %t342 = load i8*, i8** %l18
  br i1 %t324, label %then22, label %merge23
then22:
  %t343 = load i8*, i8** %l18
  %s344 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.344, i32 0, i32 0
  %t345 = call i8* @strip_prefix(i8* %t343, i8* %s344)
  %t346 = load i8*, i8** %l9
  %t347 = call double @parse_parameter_entry(i8* %t345, i8* %t346)
  store double %t347, double* %l19
  %t348 = load double, double* %l19
  store i8* null, i8** %l9
  %t349 = load double, double* %l16
  %t350 = sitofp i64 1 to double
  %t351 = fadd double %t349, %t350
  store double %t351, double* %l16
  br label %loop.latch4
merge23:
  %t352 = load i8*, i8** %l18
  %s353 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.353, i32 0, i32 0
  %t354 = call i1 @starts_with(i8* %t352, i8* %s353)
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t356 = load i8*, i8** %l1
  %t357 = load i8*, i8** %l2
  %t358 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t359 = load i8*, i8** %l4
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t361 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t362 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t363 = load i8*, i8** %l8
  %t364 = load i8*, i8** %l9
  %t365 = load i8*, i8** %l10
  %t366 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t367 = load double, double* %l12
  %t368 = load double, double* %l13
  %t369 = load i1, i1* %l14
  %t370 = load i1, i1* %l15
  %t371 = load double, double* %l16
  %t372 = load i8*, i8** %l18
  br i1 %t354, label %then24, label %merge25
then24:
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s374 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.374, i32 0, i32 0
  %t375 = load i8*, i8** %l4
  %t376 = add i8* %s374, %t375
  %t377 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t373, i8* %t376)
  store { i8**, i64 }* %t377, { i8**, i64 }** %l0
  %t378 = load double, double* %l16
  %t379 = sitofp i64 1 to double
  %t380 = fadd double %t378, %t379
  store double %t380, double* %l16
  br label %loop.latch4
merge25:
  %t381 = load i8*, i8** %l18
  %s382 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.382, i32 0, i32 0
  %t383 = call i1 @starts_with(i8* %t381, i8* %s382)
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t385 = load i8*, i8** %l1
  %t386 = load i8*, i8** %l2
  %t387 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t388 = load i8*, i8** %l4
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t390 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t391 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t392 = load i8*, i8** %l8
  %t393 = load i8*, i8** %l9
  %t394 = load i8*, i8** %l10
  %t395 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t396 = load double, double* %l12
  %t397 = load double, double* %l13
  %t398 = load i1, i1* %l14
  %t399 = load i1, i1* %l15
  %t400 = load double, double* %l16
  %t401 = load i8*, i8** %l18
  br i1 %t383, label %then26, label %merge27
then26:
  %t402 = load i8*, i8** %l18
  %s403 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.403, i32 0, i32 0
  %t404 = call i8* @strip_prefix(i8* %t402, i8* %s403)
  %t405 = call double @parse_source_span(i8* %t404)
  store double %t405, double* %l20
  %t406 = load double, double* %l20
  %t407 = load double, double* %l16
  %t408 = sitofp i64 1 to double
  %t409 = fadd double %t407, %t408
  store double %t409, double* %l16
  br label %loop.latch4
merge27:
  %t410 = load i8*, i8** %l18
  %t411 = load i8*, i8** %l18
  %t412 = load i8*, i8** %l9
  %t413 = load i8*, i8** %l10
  %t414 = call %InstructionParseResult @parse_instruction(i8* %t411, i8* %t412, i8* %t413)
  store %InstructionParseResult %t414, %InstructionParseResult* %l21
  %t415 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t416 = extractvalue %InstructionParseResult %t415, 1
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t418 = load i8*, i8** %l1
  %t419 = load i8*, i8** %l2
  %t420 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t421 = load i8*, i8** %l4
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t423 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t424 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t425 = load i8*, i8** %l8
  %t426 = load i8*, i8** %l9
  %t427 = load i8*, i8** %l10
  %t428 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t429 = load double, double* %l12
  %t430 = load double, double* %l13
  %t431 = load i1, i1* %l14
  %t432 = load i1, i1* %l15
  %t433 = load double, double* %l16
  %t434 = load i8*, i8** %l18
  %t435 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t416, label %then28, label %else29
then28:
  store i8* null, i8** %l9
  br label %merge30
else29:
  %t436 = load i8*, i8** %l9
  %t437 = icmp ne i8* %t436, null
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t439 = load i8*, i8** %l1
  %t440 = load i8*, i8** %l2
  %t441 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t442 = load i8*, i8** %l4
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t444 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t445 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t446 = load i8*, i8** %l8
  %t447 = load i8*, i8** %l9
  %t448 = load i8*, i8** %l10
  %t449 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t450 = load double, double* %l12
  %t451 = load double, double* %l13
  %t452 = load i1, i1* %l14
  %t453 = load i1, i1* %l15
  %t454 = load double, double* %l16
  %t455 = load i8*, i8** %l18
  %t456 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t437, label %then31, label %merge32
then31:
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s458 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.458, i32 0, i32 0
  %t459 = load i8*, i8** %l18
  %t460 = add i8* %s458, %t459
  %t461 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t457, i8* %t460)
  store { i8**, i64 }* %t461, { i8**, i64 }** %l0
  store i8* null, i8** %l9
  br label %merge32
merge32:
  %t462 = phi { i8**, i64 }* [ %t461, %then31 ], [ %t438, %else29 ]
  %t463 = phi i8* [ null, %then31 ], [ %t447, %else29 ]
  store { i8**, i64 }* %t462, { i8**, i64 }** %l0
  store i8* %t463, i8** %l9
  br label %merge30
merge30:
  %t464 = phi i8* [ null, %then28 ], [ null, %else29 ]
  %t465 = phi { i8**, i64 }* [ %t417, %then28 ], [ %t461, %else29 ]
  store i8* %t464, i8** %l9
  store { i8**, i64 }* %t465, { i8**, i64 }** %l0
  %t466 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t467 = extractvalue %InstructionParseResult %t466, 2
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t469 = load i8*, i8** %l1
  %t470 = load i8*, i8** %l2
  %t471 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t472 = load i8*, i8** %l4
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t474 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t475 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t476 = load i8*, i8** %l8
  %t477 = load i8*, i8** %l9
  %t478 = load i8*, i8** %l10
  %t479 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t480 = load double, double* %l12
  %t481 = load double, double* %l13
  %t482 = load i1, i1* %l14
  %t483 = load i1, i1* %l15
  %t484 = load double, double* %l16
  %t485 = load i8*, i8** %l18
  %t486 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t467, label %then33, label %else34
then33:
  store i8* null, i8** %l10
  br label %merge35
else34:
  %t487 = load i8*, i8** %l10
  %t488 = icmp ne i8* %t487, null
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t490 = load i8*, i8** %l1
  %t491 = load i8*, i8** %l2
  %t492 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t493 = load i8*, i8** %l4
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t495 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t496 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t497 = load i8*, i8** %l8
  %t498 = load i8*, i8** %l9
  %t499 = load i8*, i8** %l10
  %t500 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t501 = load double, double* %l12
  %t502 = load double, double* %l13
  %t503 = load i1, i1* %l14
  %t504 = load i1, i1* %l15
  %t505 = load double, double* %l16
  %t506 = load i8*, i8** %l18
  %t507 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t488, label %then36, label %merge37
then36:
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s509 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.509, i32 0, i32 0
  %t510 = load i8*, i8** %l18
  %t511 = add i8* %s509, %t510
  %t512 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t508, i8* %t511)
  store { i8**, i64 }* %t512, { i8**, i64 }** %l0
  store i8* null, i8** %l10
  br label %merge37
merge37:
  %t513 = phi { i8**, i64 }* [ %t512, %then36 ], [ %t489, %else34 ]
  %t514 = phi i8* [ null, %then36 ], [ %t499, %else34 ]
  store { i8**, i64 }* %t513, { i8**, i64 }** %l0
  store i8* %t514, i8** %l10
  br label %merge35
merge35:
  %t515 = phi i8* [ null, %then33 ], [ null, %else34 ]
  %t516 = phi { i8**, i64 }* [ %t468, %then33 ], [ %t512, %else34 ]
  store i8* %t515, i8** %l10
  store { i8**, i64 }* %t516, { i8**, i64 }** %l0
  %t517 = sitofp i64 0 to double
  store double %t517, double* %l22
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t519 = load i8*, i8** %l1
  %t520 = load i8*, i8** %l2
  %t521 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t522 = load i8*, i8** %l4
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t524 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t525 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t526 = load i8*, i8** %l8
  %t527 = load i8*, i8** %l9
  %t528 = load i8*, i8** %l10
  %t529 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t530 = load double, double* %l12
  %t531 = load double, double* %l13
  %t532 = load i1, i1* %l14
  %t533 = load i1, i1* %l15
  %t534 = load double, double* %l16
  %t535 = load i8*, i8** %l18
  %t536 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t537 = load double, double* %l22
  br label %loop.header38
loop.header38:
  %t582 = phi i8* [ %t526, %then16 ], [ %t580, %loop.latch40 ]
  %t583 = phi double [ %t537, %then16 ], [ %t581, %loop.latch40 ]
  store i8* %t582, i8** %l8
  store double %t583, double* %l22
  br label %loop.body39
loop.body39:
  %t538 = load double, double* %l22
  %t539 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t540 = extractvalue %InstructionParseResult %t539, 0
  %t541 = load { i8**, i64 }, { i8**, i64 }* %t540
  %t542 = extractvalue { i8**, i64 } %t541, 1
  %t543 = sitofp i64 %t542 to double
  %t544 = fcmp oge double %t538, %t543
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t546 = load i8*, i8** %l1
  %t547 = load i8*, i8** %l2
  %t548 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t549 = load i8*, i8** %l4
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t551 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t552 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t553 = load i8*, i8** %l8
  %t554 = load i8*, i8** %l9
  %t555 = load i8*, i8** %l10
  %t556 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t557 = load double, double* %l12
  %t558 = load double, double* %l13
  %t559 = load i1, i1* %l14
  %t560 = load i1, i1* %l15
  %t561 = load double, double* %l16
  %t562 = load i8*, i8** %l18
  %t563 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t564 = load double, double* %l22
  br i1 %t544, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t565 = load i8*, i8** %l8
  %t566 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t567 = extractvalue %InstructionParseResult %t566, 0
  %t568 = load double, double* %l22
  %t569 = fptosi double %t568 to i64
  %t570 = load { i8**, i64 }, { i8**, i64 }* %t567
  %t571 = extractvalue { i8**, i64 } %t570, 0
  %t572 = extractvalue { i8**, i64 } %t570, 1
  %t573 = icmp uge i64 %t569, %t572
  ; bounds check: %t573 (if true, out of bounds)
  %t574 = getelementptr i8*, i8** %t571, i64 %t569
  %t575 = load i8*, i8** %t574
  %t576 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t577 = load double, double* %l22
  %t578 = sitofp i64 1 to double
  %t579 = fadd double %t577, %t578
  store double %t579, double* %l22
  br label %loop.latch40
loop.latch40:
  %t580 = load i8*, i8** %l8
  %t581 = load double, double* %l22
  br label %loop.header38
afterloop41:
  %t584 = load double, double* %l16
  %t585 = sitofp i64 1 to double
  %t586 = fadd double %t584, %t585
  store double %t586, double* %l16
  br label %loop.latch4
merge17:
  %t587 = load i8*, i8** %l18
  %s588 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.588, i32 0, i32 0
  %t589 = call i1 @starts_with(i8* %t587, i8* %s588)
  %t590 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t591 = load i8*, i8** %l1
  %t592 = load i8*, i8** %l2
  %t593 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t594 = load i8*, i8** %l4
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t596 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t597 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t598 = load i8*, i8** %l8
  %t599 = load i8*, i8** %l9
  %t600 = load i8*, i8** %l10
  %t601 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t602 = load double, double* %l12
  %t603 = load double, double* %l13
  %t604 = load i1, i1* %l14
  %t605 = load i1, i1* %l15
  %t606 = load double, double* %l16
  %t607 = load i8*, i8** %l18
  br i1 %t589, label %then44, label %merge45
then44:
  %t608 = load i8*, i8** %l18
  %s609 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.609, i32 0, i32 0
  %t610 = call i8* @strip_prefix(i8* %t608, i8* %s609)
  store i8* %t610, i8** %l23
  %t611 = load i8*, i8** %l23
  %s612 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.612, i32 0, i32 0
  %t613 = call i1 @starts_with(i8* %t611, i8* %s612)
  %t614 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t615 = load i8*, i8** %l1
  %t616 = load i8*, i8** %l2
  %t617 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t618 = load i8*, i8** %l4
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t620 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t621 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t622 = load i8*, i8** %l8
  %t623 = load i8*, i8** %l9
  %t624 = load i8*, i8** %l10
  %t625 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t626 = load double, double* %l12
  %t627 = load double, double* %l13
  %t628 = load i1, i1* %l14
  %t629 = load i1, i1* %l15
  %t630 = load double, double* %l16
  %t631 = load i8*, i8** %l18
  %t632 = load i8*, i8** %l23
  br i1 %t613, label %then46, label %merge47
then46:
  %t633 = load i8*, i8** %l23
  %s634 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.634, i32 0, i32 0
  %t635 = call i8* @strip_prefix(i8* %t633, i8* %s634)
  %t636 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t635)
  store %StructLayoutHeaderParse %t636, %StructLayoutHeaderParse* %l24
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t638 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t639 = extractvalue %StructLayoutHeaderParse %t638, 4
  %t640 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t637, { i8**, i64 }* %t639)
  store { i8**, i64 }* %t640, { i8**, i64 }** %l0
  %t641 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t642 = extractvalue %StructLayoutHeaderParse %t641, 0
  %t643 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t644 = load i8*, i8** %l1
  %t645 = load i8*, i8** %l2
  %t646 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t647 = load i8*, i8** %l4
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t649 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t650 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t651 = load i8*, i8** %l8
  %t652 = load i8*, i8** %l9
  %t653 = load i8*, i8** %l10
  %t654 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t655 = load double, double* %l12
  %t656 = load double, double* %l13
  %t657 = load i1, i1* %l14
  %t658 = load i1, i1* %l15
  %t659 = load double, double* %l16
  %t660 = load i8*, i8** %l18
  %t661 = load i8*, i8** %l23
  %t662 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t642, label %then48, label %merge49
then48:
  %t663 = load i1, i1* %l14
  %t664 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t665 = load i8*, i8** %l1
  %t666 = load i8*, i8** %l2
  %t667 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t668 = load i8*, i8** %l4
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t670 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t671 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t672 = load i8*, i8** %l8
  %t673 = load i8*, i8** %l9
  %t674 = load i8*, i8** %l10
  %t675 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t676 = load double, double* %l12
  %t677 = load double, double* %l13
  %t678 = load i1, i1* %l14
  %t679 = load i1, i1* %l15
  %t680 = load double, double* %l16
  %t681 = load i8*, i8** %l18
  %t682 = load i8*, i8** %l23
  %t683 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t663, label %then50, label %else51
then50:
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s685 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.685, i32 0, i32 0
  %t686 = load i8*, i8** %l4
  %t687 = add i8* %s685, %t686
  %t688 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t684, i8* %t687)
  store { i8**, i64 }* %t688, { i8**, i64 }** %l0
  br label %merge52
else51:
  %t689 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t690 = extractvalue %StructLayoutHeaderParse %t689, 2
  store double %t690, double* %l12
  %t691 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t692 = extractvalue %StructLayoutHeaderParse %t691, 3
  store double %t692, double* %l13
  store i1 1, i1* %l14
  br label %merge52
merge52:
  %t693 = phi { i8**, i64 }* [ %t688, %then50 ], [ %t664, %else51 ]
  %t694 = phi double [ %t676, %then50 ], [ %t690, %else51 ]
  %t695 = phi double [ %t677, %then50 ], [ %t692, %else51 ]
  %t696 = phi i1 [ %t678, %then50 ], [ 1, %else51 ]
  store { i8**, i64 }* %t693, { i8**, i64 }** %l0
  store double %t694, double* %l12
  store double %t695, double* %l13
  store i1 %t696, i1* %l14
  br label %merge49
merge49:
  %t697 = phi { i8**, i64 }* [ %t688, %then48 ], [ %t643, %then46 ]
  %t698 = phi double [ %t690, %then48 ], [ %t655, %then46 ]
  %t699 = phi double [ %t692, %then48 ], [ %t656, %then46 ]
  %t700 = phi i1 [ 1, %then48 ], [ %t657, %then46 ]
  store { i8**, i64 }* %t697, { i8**, i64 }** %l0
  store double %t698, double* %l12
  store double %t699, double* %l13
  store i1 %t700, i1* %l14
  %t701 = load double, double* %l16
  %t702 = sitofp i64 1 to double
  %t703 = fadd double %t701, %t702
  store double %t703, double* %l16
  br label %loop.latch4
merge47:
  %t704 = load i8*, i8** %l23
  %s705 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.705, i32 0, i32 0
  %t706 = call i1 @starts_with(i8* %t704, i8* %s705)
  %t707 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t708 = load i8*, i8** %l1
  %t709 = load i8*, i8** %l2
  %t710 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t711 = load i8*, i8** %l4
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t713 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t714 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t715 = load i8*, i8** %l8
  %t716 = load i8*, i8** %l9
  %t717 = load i8*, i8** %l10
  %t718 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t719 = load double, double* %l12
  %t720 = load double, double* %l13
  %t721 = load i1, i1* %l14
  %t722 = load i1, i1* %l15
  %t723 = load double, double* %l16
  %t724 = load i8*, i8** %l18
  %t725 = load i8*, i8** %l23
  br i1 %t706, label %then53, label %merge54
then53:
  %t726 = load i8*, i8** %l23
  %s727 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.727, i32 0, i32 0
  %t728 = call i8* @strip_prefix(i8* %t726, i8* %s727)
  %t729 = load i8*, i8** %l4
  %t730 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t728, i8* %t729)
  store %StructLayoutFieldParse %t730, %StructLayoutFieldParse* %l25
  %t731 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t732 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t733 = extractvalue %StructLayoutFieldParse %t732, 2
  %t734 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t731, { i8**, i64 }* %t733)
  store { i8**, i64 }* %t734, { i8**, i64 }** %l0
  %t735 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t736 = extractvalue %StructLayoutFieldParse %t735, 0
  %t737 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t738 = load i8*, i8** %l1
  %t739 = load i8*, i8** %l2
  %t740 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t741 = load i8*, i8** %l4
  %t742 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t743 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t744 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t745 = load i8*, i8** %l8
  %t746 = load i8*, i8** %l9
  %t747 = load i8*, i8** %l10
  %t748 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t749 = load double, double* %l12
  %t750 = load double, double* %l13
  %t751 = load i1, i1* %l14
  %t752 = load i1, i1* %l15
  %t753 = load double, double* %l16
  %t754 = load i8*, i8** %l18
  %t755 = load i8*, i8** %l23
  %t756 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t736, label %then55, label %merge56
then55:
  %t757 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t758 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t759 = extractvalue %StructLayoutFieldParse %t758, 1
  %t760 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t757, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t760, { %NativeStructLayoutField*, i64 }** %l11
  %t761 = load i1, i1* %l14
  %t762 = xor i1 %t761, 1
  %t763 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t764 = load i8*, i8** %l1
  %t765 = load i8*, i8** %l2
  %t766 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t767 = load i8*, i8** %l4
  %t768 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t769 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t770 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t771 = load i8*, i8** %l8
  %t772 = load i8*, i8** %l9
  %t773 = load i8*, i8** %l10
  %t774 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t775 = load double, double* %l12
  %t776 = load double, double* %l13
  %t777 = load i1, i1* %l14
  %t778 = load i1, i1* %l15
  %t779 = load double, double* %l16
  %t780 = load i8*, i8** %l18
  %t781 = load i8*, i8** %l23
  %t782 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t762, label %then57, label %merge58
then57:
  %t783 = load i1, i1* %l15
  %t784 = xor i1 %t783, 1
  %t785 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t786 = load i8*, i8** %l1
  %t787 = load i8*, i8** %l2
  %t788 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t789 = load i8*, i8** %l4
  %t790 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t791 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t792 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t793 = load i8*, i8** %l8
  %t794 = load i8*, i8** %l9
  %t795 = load i8*, i8** %l10
  %t796 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t797 = load double, double* %l12
  %t798 = load double, double* %l13
  %t799 = load i1, i1* %l14
  %t800 = load i1, i1* %l15
  %t801 = load double, double* %l16
  %t802 = load i8*, i8** %l18
  %t803 = load i8*, i8** %l23
  %t804 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t784, label %then59, label %merge60
then59:
  %t805 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s806 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.806, i32 0, i32 0
  %t807 = load i8*, i8** %l4
  %t808 = add i8* %s806, %t807
  %s809 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.809, i32 0, i32 0
  %t810 = add i8* %t808, %s809
  %t811 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t805, i8* %t810)
  store { i8**, i64 }* %t811, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge60
merge60:
  %t812 = phi { i8**, i64 }* [ %t811, %then59 ], [ %t785, %then57 ]
  %t813 = phi i1 [ 1, %then59 ], [ %t800, %then57 ]
  store { i8**, i64 }* %t812, { i8**, i64 }** %l0
  store i1 %t813, i1* %l15
  br label %merge58
merge58:
  %t814 = phi { i8**, i64 }* [ %t811, %then57 ], [ %t763, %then55 ]
  %t815 = phi i1 [ 1, %then57 ], [ %t778, %then55 ]
  store { i8**, i64 }* %t814, { i8**, i64 }** %l0
  store i1 %t815, i1* %l15
  br label %merge56
merge56:
  %t816 = phi { %NativeStructLayoutField*, i64 }* [ %t760, %then55 ], [ %t748, %then53 ]
  %t817 = phi { i8**, i64 }* [ %t811, %then55 ], [ %t737, %then53 ]
  %t818 = phi i1 [ 1, %then55 ], [ %t752, %then53 ]
  store { %NativeStructLayoutField*, i64 }* %t816, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t817, { i8**, i64 }** %l0
  store i1 %t818, i1* %l15
  %t819 = load double, double* %l16
  %t820 = sitofp i64 1 to double
  %t821 = fadd double %t819, %t820
  store double %t821, double* %l16
  br label %loop.latch4
merge54:
  %t822 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s823 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.823, i32 0, i32 0
  %t824 = load i8*, i8** %l18
  %t825 = add i8* %s823, %t824
  %t826 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t822, i8* %t825)
  store { i8**, i64 }* %t826, { i8**, i64 }** %l0
  %t827 = load double, double* %l16
  %t828 = sitofp i64 1 to double
  %t829 = fadd double %t827, %t828
  store double %t829, double* %l16
  br label %loop.latch4
merge45:
  %t830 = load i8*, i8** %l18
  %s831 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.831, i32 0, i32 0
  %t832 = icmp eq i8* %t830, %s831
  %t833 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t834 = load i8*, i8** %l1
  %t835 = load i8*, i8** %l2
  %t836 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t837 = load i8*, i8** %l4
  %t838 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t839 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t840 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t841 = load i8*, i8** %l8
  %t842 = load i8*, i8** %l9
  %t843 = load i8*, i8** %l10
  %t844 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t845 = load double, double* %l12
  %t846 = load double, double* %l13
  %t847 = load i1, i1* %l14
  %t848 = load i1, i1* %l15
  %t849 = load double, double* %l16
  %t850 = load i8*, i8** %l18
  br i1 %t832, label %then61, label %merge62
then61:
  %t851 = load double, double* %l16
  %t852 = sitofp i64 1 to double
  %t853 = fadd double %t851, %t852
  store double %t853, double* %l16
  br label %loop.latch4
merge62:
  %t854 = load i8*, i8** %l18
  %s855 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.855, i32 0, i32 0
  %t856 = call i1 @starts_with(i8* %t854, i8* %s855)
  %t857 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t858 = load i8*, i8** %l1
  %t859 = load i8*, i8** %l2
  %t860 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t861 = load i8*, i8** %l4
  %t862 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t863 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t864 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t865 = load i8*, i8** %l8
  %t866 = load i8*, i8** %l9
  %t867 = load i8*, i8** %l10
  %t868 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t869 = load double, double* %l12
  %t870 = load double, double* %l13
  %t871 = load i1, i1* %l14
  %t872 = load i1, i1* %l15
  %t873 = load double, double* %l16
  %t874 = load i8*, i8** %l18
  br i1 %t856, label %then63, label %merge64
then63:
  %t875 = load i8*, i8** %l18
  %s876 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.876, i32 0, i32 0
  %t877 = call i8* @strip_prefix(i8* %t875, i8* %s876)
  %t878 = call double @parse_struct_field_line(i8* %t877)
  store double %t878, double* %l26
  %t879 = load double, double* %l26
  %t880 = load double, double* %l16
  %t881 = sitofp i64 1 to double
  %t882 = fadd double %t880, %t881
  store double %t882, double* %l16
  br label %loop.latch4
merge64:
  %t883 = load i8*, i8** %l18
  %s884 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.884, i32 0, i32 0
  %t885 = call i1 @starts_with(i8* %t883, i8* %s884)
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t887 = load i8*, i8** %l1
  %t888 = load i8*, i8** %l2
  %t889 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t890 = load i8*, i8** %l4
  %t891 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t892 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t893 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t894 = load i8*, i8** %l8
  %t895 = load i8*, i8** %l9
  %t896 = load i8*, i8** %l10
  %t897 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t898 = load double, double* %l12
  %t899 = load double, double* %l13
  %t900 = load i1, i1* %l14
  %t901 = load i1, i1* %l15
  %t902 = load double, double* %l16
  %t903 = load i8*, i8** %l18
  br i1 %t885, label %then65, label %merge66
then65:
  %t904 = load i8*, i8** %l8
  %t905 = icmp ne i8* %t904, null
  %t906 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t907 = load i8*, i8** %l1
  %t908 = load i8*, i8** %l2
  %t909 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t910 = load i8*, i8** %l4
  %t911 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t912 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t913 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t914 = load i8*, i8** %l8
  %t915 = load i8*, i8** %l9
  %t916 = load i8*, i8** %l10
  %t917 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t918 = load double, double* %l12
  %t919 = load double, double* %l13
  %t920 = load i1, i1* %l14
  %t921 = load i1, i1* %l15
  %t922 = load double, double* %l16
  %t923 = load i8*, i8** %l18
  br i1 %t905, label %then67, label %merge68
then67:
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s925 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.925, i32 0, i32 0
  %t926 = load i8*, i8** %l4
  %t927 = add i8* %s925, %t926
  %t928 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t924, i8* %t927)
  store { i8**, i64 }* %t928, { i8**, i64 }** %l0
  br label %merge68
merge68:
  %t929 = phi { i8**, i64 }* [ %t928, %then67 ], [ %t906, %then65 ]
  store { i8**, i64 }* %t929, { i8**, i64 }** %l0
  %t930 = load i8*, i8** %l18
  %s931 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.931, i32 0, i32 0
  %t932 = call i8* @strip_prefix(i8* %t930, i8* %s931)
  %t933 = call i8* @parse_function_name(i8* %t932)
  store i8* %t933, i8** %l27
  %t934 = load i8*, i8** %l27
  %t935 = insertvalue %NativeFunction undef, i8* %t934, 0
  %t936 = alloca [0 x i8*]
  %t937 = getelementptr [0 x i8*], [0 x i8*]* %t936, i32 0, i32 0
  %t938 = alloca { i8**, i64 }
  %t939 = getelementptr { i8**, i64 }, { i8**, i64 }* %t938, i32 0, i32 0
  store i8** %t937, i8*** %t939
  %t940 = getelementptr { i8**, i64 }, { i8**, i64 }* %t938, i32 0, i32 1
  store i64 0, i64* %t940
  %t941 = insertvalue %NativeFunction %t935, { i8**, i64 }* %t938, 1
  %s942 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.942, i32 0, i32 0
  %t943 = insertvalue %NativeFunction %t941, i8* %s942, 2
  %t944 = alloca [0 x i8*]
  %t945 = getelementptr [0 x i8*], [0 x i8*]* %t944, i32 0, i32 0
  %t946 = alloca { i8**, i64 }
  %t947 = getelementptr { i8**, i64 }, { i8**, i64 }* %t946, i32 0, i32 0
  store i8** %t945, i8*** %t947
  %t948 = getelementptr { i8**, i64 }, { i8**, i64 }* %t946, i32 0, i32 1
  store i64 0, i64* %t948
  %t949 = insertvalue %NativeFunction %t943, { i8**, i64 }* %t946, 3
  %t950 = alloca [0 x i8*]
  %t951 = getelementptr [0 x i8*], [0 x i8*]* %t950, i32 0, i32 0
  %t952 = alloca { i8**, i64 }
  %t953 = getelementptr { i8**, i64 }, { i8**, i64 }* %t952, i32 0, i32 0
  store i8** %t951, i8*** %t953
  %t954 = getelementptr { i8**, i64 }, { i8**, i64 }* %t952, i32 0, i32 1
  store i64 0, i64* %t954
  %t955 = insertvalue %NativeFunction %t949, { i8**, i64 }* %t952, 4
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t956 = load double, double* %l16
  %t957 = sitofp i64 1 to double
  %t958 = fadd double %t956, %t957
  store double %t958, double* %l16
  br label %loop.latch4
merge66:
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s960 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.960, i32 0, i32 0
  %t961 = load i8*, i8** %l18
  %t962 = add i8* %s960, %t961
  %t963 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t959, i8* %t962)
  store { i8**, i64 }* %t963, { i8**, i64 }** %l0
  %t964 = load double, double* %l16
  %t965 = sitofp i64 1 to double
  %t966 = fadd double %t964, %t965
  store double %t966, double* %l16
  br label %loop.latch4
loop.latch4:
  %t967 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t968 = load double, double* %l16
  %t969 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t970 = load i8*, i8** %l8
  %t971 = load i8*, i8** %l9
  %t972 = load i8*, i8** %l10
  %t973 = load double, double* %l12
  %t974 = load double, double* %l13
  %t975 = load i1, i1* %l14
  %t976 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t977 = load i1, i1* %l15
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l28
  %t989 = load i1, i1* %l14
  %t990 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t991 = load i8*, i8** %l1
  %t992 = load i8*, i8** %l2
  %t993 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t994 = load i8*, i8** %l4
  %t995 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t996 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t997 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t998 = load i8*, i8** %l8
  %t999 = load i8*, i8** %l9
  %t1000 = load i8*, i8** %l10
  %t1001 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1002 = load double, double* %l12
  %t1003 = load double, double* %l13
  %t1004 = load i1, i1* %l14
  %t1005 = load i1, i1* %l15
  %t1006 = load double, double* %l16
  %t1007 = load i8*, i8** %l28
  br i1 %t989, label %then69, label %merge70
then69:
  %t1008 = load double, double* %l12
  %t1009 = insertvalue %NativeStructLayout undef, double %t1008, 0
  %t1010 = load double, double* %l13
  %t1011 = insertvalue %NativeStructLayout %t1009, double %t1010, 1
  %t1012 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1013 = bitcast { %NativeStructLayoutField*, i64 }* %t1012 to { i8**, i64 }*
  %t1014 = insertvalue %NativeStructLayout %t1011, { i8**, i64 }* %t1013, 2
  store i8* null, i8** %l28
  br label %merge70
merge70:
  %t1015 = phi i8* [ null, %then69 ], [ %t1007, %entry ]
  store i8* %t1015, i8** %l28
  %t1016 = load i8*, i8** %l4
  %t1017 = insertvalue %NativeStruct undef, i8* %t1016, 0
  %t1018 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1019 = bitcast { %NativeStructField*, i64 }* %t1018 to { i8**, i64 }*
  %t1020 = insertvalue %NativeStruct %t1017, { i8**, i64 }* %t1019, 1
  %t1021 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1022 = bitcast { %NativeFunction*, i64 }* %t1021 to { i8**, i64 }*
  %t1023 = insertvalue %NativeStruct %t1020, { i8**, i64 }* %t1022, 2
  %t1024 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1025 = insertvalue %NativeStruct %t1023, { i8**, i64 }* %t1024, 3
  %t1026 = load i8*, i8** %l28
  %t1027 = insertvalue %NativeStruct %t1025, i8* %t1026, 4
  %t1028 = insertvalue %StructParseResult undef, i8* null, 0
  %t1029 = load double, double* %l16
  %t1030 = insertvalue %StructParseResult %t1028, double %t1029, 1
  %t1031 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1032 = insertvalue %StructParseResult %t1030, { i8**, i64 }* %t1031, 2
  ret %StructParseResult %t1032
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
  %t199 = phi { i8**, i64 }* [ %t45, %entry ], [ %t196, %loop.latch4 ]
  %t200 = phi double [ %t51, %entry ], [ %t197, %loop.latch4 ]
  %t201 = phi { %NativeInterfaceSignature*, i64 }* [ %t50, %entry ], [ %t198, %loop.latch4 ]
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  store double %t200, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t201, { %NativeInterfaceSignature*, i64 }** %l5
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
  %t96 = alloca [2 x i8], align 1
  %t97 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 0
  store i8 59, i8* %t97
  %t98 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 1
  store i8 0, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 0
  %t100 = call i1 @starts_with(i8* %t95, i8* %t99)
  br label %logical_or_right_end_91

logical_or_right_end_91:
  br label %logical_or_merge_91

logical_or_merge_91:
  %t101 = phi i1 [ true, %logical_or_entry_91 ], [ %t100, %logical_or_right_end_91 ]
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load i8*, i8** %l1
  %t104 = load i8*, i8** %l2
  %t105 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t106 = load i8*, i8** %l4
  %t107 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t108 = load double, double* %l6
  %t109 = load i8*, i8** %l7
  br i1 %t101, label %then8, label %merge9
then8:
  %t110 = load double, double* %l6
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l6
  br label %loop.latch4
merge9:
  %t113 = load i8*, i8** %l7
  %s114 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.114, i32 0, i32 0
  %t115 = icmp eq i8* %t113, %s114
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load i8*, i8** %l2
  %t119 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t120 = load i8*, i8** %l4
  %t121 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t122 = load double, double* %l6
  %t123 = load i8*, i8** %l7
  br i1 %t115, label %then10, label %merge11
then10:
  %t124 = load double, double* %l6
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  store double %t126, double* %l6
  br label %afterloop5
merge11:
  %t127 = load i8*, i8** %l7
  %s128 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.128, i32 0, i32 0
  %t129 = icmp eq i8* %t127, %s128
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load i8*, i8** %l1
  %t132 = load i8*, i8** %l2
  %t133 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t134 = load i8*, i8** %l4
  %t135 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t136 = load double, double* %l6
  %t137 = load i8*, i8** %l7
  br i1 %t129, label %then12, label %merge13
then12:
  %t138 = load double, double* %l6
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l6
  br label %loop.latch4
merge13:
  %t141 = load i8*, i8** %l7
  %s142 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.142, i32 0, i32 0
  %t143 = call i1 @starts_with(i8* %t141, i8* %s142)
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8*, i8** %l1
  %t146 = load i8*, i8** %l2
  %t147 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t148 = load i8*, i8** %l4
  %t149 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t150 = load double, double* %l6
  %t151 = load i8*, i8** %l7
  br i1 %t143, label %then14, label %merge15
then14:
  %t152 = load i8*, i8** %l7
  %s153 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.153, i32 0, i32 0
  %t154 = call i8* @strip_prefix(i8* %t152, i8* %s153)
  %t155 = load i8*, i8** %l4
  %t156 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t154, i8* %t155)
  store %InterfaceSignatureParse %t156, %InterfaceSignatureParse* %l8
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t159 = extractvalue %InterfaceSignatureParse %t158, 2
  %t160 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t157, { i8**, i64 }* %t159)
  store { i8**, i64 }* %t160, { i8**, i64 }** %l0
  %t161 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t162 = extractvalue %InterfaceSignatureParse %t161, 0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = load i8*, i8** %l1
  %t165 = load i8*, i8** %l2
  %t166 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t167 = load i8*, i8** %l4
  %t168 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t169 = load double, double* %l6
  %t170 = load i8*, i8** %l7
  %t171 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t162, label %then16, label %merge17
then16:
  %t172 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t173 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t174 = extractvalue %InterfaceSignatureParse %t173, 1
  %t175 = alloca [1 x i8*]
  %t176 = getelementptr [1 x i8*], [1 x i8*]* %t175, i32 0, i32 0
  %t177 = getelementptr i8*, i8** %t176, i64 0
  store i8* %t174, i8** %t177
  %t178 = alloca { i8**, i64 }
  %t179 = getelementptr { i8**, i64 }, { i8**, i64 }* %t178, i32 0, i32 0
  store i8** %t176, i8*** %t179
  %t180 = getelementptr { i8**, i64 }, { i8**, i64 }* %t178, i32 0, i32 1
  store i64 1, i64* %t180
  %t181 = bitcast { %NativeInterfaceSignature*, i64 }* %t172 to { i8**, i64 }*
  %t182 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t181, { i8**, i64 }* %t178)
  %t183 = bitcast { i8**, i64 }* %t182 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t183, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t184 = phi { %NativeInterfaceSignature*, i64 }* [ %t183, %then16 ], [ %t168, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t184, { %NativeInterfaceSignature*, i64 }** %l5
  %t185 = load double, double* %l6
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  store double %t187, double* %l6
  br label %loop.latch4
merge15:
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s189 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.189, i32 0, i32 0
  %t190 = load i8*, i8** %l7
  %t191 = add i8* %s189, %t190
  %t192 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t188, i8* %t191)
  store { i8**, i64 }* %t192, { i8**, i64 }** %l0
  %t193 = load double, double* %l6
  %t194 = sitofp i64 1 to double
  %t195 = fadd double %t193, %t194
  store double %t195, double* %l6
  br label %loop.latch4
loop.latch4:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load double, double* %l6
  %t198 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t202 = load i8*, i8** %l4
  %t203 = insertvalue %NativeInterface undef, i8* %t202, 0
  %t204 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t205 = extractvalue %InterfaceHeaderParse %t204, 1
  %t206 = insertvalue %NativeInterface %t203, { i8**, i64 }* %t205, 1
  %t207 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t208 = bitcast { %NativeInterfaceSignature*, i64 }* %t207 to { i8**, i64 }*
  %t209 = insertvalue %NativeInterface %t206, { i8**, i64 }* %t208, 2
  %t210 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t211 = load double, double* %l6
  %t212 = insertvalue %InterfaceParseResult %t210, double %t211, 1
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = insertvalue %InterfaceParseResult %t212, { i8**, i64 }* %t213, 2
  ret %InterfaceParseResult %t214
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
  %t59 = alloca [2 x i8], align 1
  %t60 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8 %t58, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 1
  store i8 0, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t64 = phi { i8**, i64 }* [ %t41, %then2 ], [ %t63, %else3 ]
  %t65 = phi { i8**, i64 }* [ %t43, %then2 ], [ %t21, %else3 ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  store { i8**, i64 }* %t65, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t66 = phi { i8**, i64 }* [ %t41, %then0 ], [ %t13, %entry ]
  %t67 = phi { i8**, i64 }* [ %t43, %then0 ], [ %t14, %entry ]
  %t68 = phi { i8**, i64 }* [ %t63, %then0 ], [ %t13, %entry ]
  store { i8**, i64 }* %t66, { i8**, i64 }** %l1
  store { i8**, i64 }* %t67, { i8**, i64 }** %l2
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  %t69 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t70 = extractvalue %HeaderNameParse %t69, 0
  %t71 = insertvalue %StructHeaderParse undef, i8* %t70, 0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t73 = insertvalue %StructHeaderParse %t71, { i8**, i64 }* %t72, 1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = insertvalue %StructHeaderParse %t73, { i8**, i64 }* %t74, 2
  ret %StructHeaderParse %t75
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
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 %t21, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  %t26 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t27 = phi { i8**, i64 }* [ %t26, %then0 ], [ %t8, %entry ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t28 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t29 = extractvalue %HeaderNameParse %t28, 0
  %t30 = insertvalue %InterfaceHeaderParse undef, i8* %t29, 0
  %t31 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t32 = extractvalue %HeaderNameParse %t31, 1
  %t33 = insertvalue %InterfaceHeaderParse %t30, { i8**, i64 }* %t32, 1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = insertvalue %InterfaceHeaderParse %t33, { i8**, i64 }* %t34, 2
  ret %InterfaceHeaderParse %t35
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
  %t63 = alloca [2 x i8], align 1
  %t64 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  store i8 40, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 1
  store i8 0, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  %t67 = call double @index_of(i8* %t62, i8* %t66)
  store double %t67, double* %l5
  %t68 = load double, double* %l5
  %t69 = sitofp i64 0 to double
  %t70 = fcmp olt double %t68, %t69
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load i8*, i8** %l3
  %t75 = load i1, i1* %l4
  %t76 = load double, double* %l5
  br i1 %t70, label %then4, label %merge5
then4:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s78 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.78, i32 0, i32 0
  %t79 = add i8* %s78, %interface_name
  %s80 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.80, i32 0, i32 0
  %t81 = add i8* %t79, %s80
  %t82 = load i8*, i8** %l2
  %t83 = add i8* %t81, %t82
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t77, i8* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t86 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t87 = insertvalue %InterfaceSignatureParse %t85, i8* null, 1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = insertvalue %InterfaceSignatureParse %t87, { i8**, i64 }* %t88, 2
  ret %InterfaceSignatureParse %t89
merge5:
  %t90 = load i8*, i8** %l3
  %t91 = load double, double* %l5
  %t92 = call double @find_matching_paren(i8* %t90, double %t91)
  store double %t92, double* %l6
  %t93 = load double, double* %l6
  %t94 = sitofp i64 0 to double
  %t95 = fcmp olt double %t93, %t94
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t98 = load i8*, i8** %l2
  %t99 = load i8*, i8** %l3
  %t100 = load i1, i1* %l4
  %t101 = load double, double* %l5
  %t102 = load double, double* %l6
  br i1 %t95, label %then6, label %merge7
then6:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s104 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.104, i32 0, i32 0
  %t105 = add i8* %s104, %interface_name
  %s106 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.106, i32 0, i32 0
  %t107 = add i8* %t105, %s106
  %t108 = load i8*, i8** %l2
  %t109 = add i8* %t107, %t108
  %t110 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t103, i8* %t109)
  store { i8**, i64 }* %t110, { i8**, i64 }** %l0
  %t111 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t112 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t113 = insertvalue %InterfaceSignatureParse %t111, i8* null, 1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = insertvalue %InterfaceSignatureParse %t113, { i8**, i64 }* %t114, 2
  ret %InterfaceSignatureParse %t115
merge7:
  %t116 = load i8*, i8** %l3
  %t117 = load double, double* %l5
  %t118 = fptosi double %t117 to i64
  %t119 = call i8* @sailfin_runtime_substring(i8* %t116, i64 0, i64 %t118)
  %t120 = call i8* @trim_text(i8* %t119)
  store i8* %t120, i8** %l7
  %t121 = load i8*, i8** %l7
  %t122 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t121)
  store %HeaderNameParse %t122, %HeaderNameParse* %l8
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t125 = extractvalue %HeaderNameParse %t124, 3
  %t126 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t123, { i8**, i64 }* %t125)
  store { i8**, i64 }* %t126, { i8**, i64 }** %l0
  %t127 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t128 = extractvalue %HeaderNameParse %t127, 2
  %t129 = call i64 @sailfin_runtime_string_length(i8* %t128)
  %t130 = icmp sgt i64 %t129, 0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t133 = load i8*, i8** %l2
  %t134 = load i8*, i8** %l3
  %t135 = load i1, i1* %l4
  %t136 = load double, double* %l5
  %t137 = load double, double* %l6
  %t138 = load i8*, i8** %l7
  %t139 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t130, label %then8, label %merge9
then8:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s141 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.141, i32 0, i32 0
  %t142 = add i8* %s141, %interface_name
  %s143 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.143, i32 0, i32 0
  %t144 = add i8* %t142, %s143
  %t145 = load i8*, i8** %l2
  %t146 = add i8* %t144, %t145
  %s147 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.147, i32 0, i32 0
  %t148 = add i8* %t146, %s147
  %t149 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t150 = extractvalue %HeaderNameParse %t149, 2
  %t151 = add i8* %t148, %t150
  %t152 = getelementptr i8, i8* %t151, i64 0
  %t153 = load i8, i8* %t152
  %t154 = add i8 %t153, 96
  %t155 = alloca [2 x i8], align 1
  %t156 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  store i8 %t154, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 1
  store i8 0, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  %t159 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t140, i8* %t158)
  store { i8**, i64 }* %t159, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t160 = phi { i8**, i64 }* [ %t159, %then8 ], [ %t131, %entry ]
  store { i8**, i64 }* %t160, { i8**, i64 }** %l0
  %t161 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t162 = extractvalue %HeaderNameParse %t161, 0
  store i8* %t162, i8** %l9
  %t163 = load i8*, i8** %l9
  %t164 = call i64 @sailfin_runtime_string_length(i8* %t163)
  %t165 = icmp eq i64 %t164, 0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t168 = load i8*, i8** %l2
  %t169 = load i8*, i8** %l3
  %t170 = load i1, i1* %l4
  %t171 = load double, double* %l5
  %t172 = load double, double* %l6
  %t173 = load i8*, i8** %l7
  %t174 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t175 = load i8*, i8** %l9
  br i1 %t165, label %then10, label %merge11
then10:
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s177 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.177, i32 0, i32 0
  %t178 = add i8* %s177, %interface_name
  %s179 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.179, i32 0, i32 0
  %t180 = add i8* %t178, %s179
  %t181 = load i8*, i8** %l2
  %t182 = add i8* %t180, %t181
  %s183 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.183, i32 0, i32 0
  %t184 = add i8* %t182, %s183
  %t185 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t176, i8* %t184)
  store { i8**, i64 }* %t185, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t186 = phi { i8**, i64 }* [ %t185, %then10 ], [ %t166, %entry ]
  store { i8**, i64 }* %t186, { i8**, i64 }** %l0
  %t187 = load i8*, i8** %l3
  %t188 = load double, double* %l5
  %t189 = sitofp i64 1 to double
  %t190 = fadd double %t188, %t189
  %t191 = load double, double* %l6
  %t192 = fptosi double %t190 to i64
  %t193 = fptosi double %t191 to i64
  %t194 = call i8* @sailfin_runtime_substring(i8* %t187, i64 %t192, i64 %t193)
  store i8* %t194, i8** %l10
  %t195 = alloca [0 x %NativeParameter]
  %t196 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t195, i32 0, i32 0
  %t197 = alloca { %NativeParameter*, i64 }
  %t198 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t197, i32 0, i32 0
  store %NativeParameter* %t196, %NativeParameter** %t198
  %t199 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t197, i32 0, i32 1
  store i64 0, i64* %t199
  store { %NativeParameter*, i64 }* %t197, { %NativeParameter*, i64 }** %l11
  %t200 = load i8*, i8** %l10
  %t201 = call i8* @trim_text(i8* %t200)
  store i8* %t201, i8** %l12
  %t202 = load i8*, i8** %l12
  %t203 = call i64 @sailfin_runtime_string_length(i8* %t202)
  %t204 = icmp sgt i64 %t203, 0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t207 = load i8*, i8** %l2
  %t208 = load i8*, i8** %l3
  %t209 = load i1, i1* %l4
  %t210 = load double, double* %l5
  %t211 = load double, double* %l6
  %t212 = load i8*, i8** %l7
  %t213 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t214 = load i8*, i8** %l9
  %t215 = load i8*, i8** %l10
  %t216 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t217 = load i8*, i8** %l12
  br i1 %t204, label %then12, label %merge13
then12:
  %t218 = load i8*, i8** %l12
  %t219 = call { i8**, i64 }* @split_parameter_entries(i8* %t218)
  store { i8**, i64 }* %t219, { i8**, i64 }** %l13
  %t220 = sitofp i64 0 to double
  store double %t220, double* %l14
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t223 = load i8*, i8** %l2
  %t224 = load i8*, i8** %l3
  %t225 = load i1, i1* %l4
  %t226 = load double, double* %l5
  %t227 = load double, double* %l6
  %t228 = load i8*, i8** %l7
  %t229 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t230 = load i8*, i8** %l9
  %t231 = load i8*, i8** %l10
  %t232 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t233 = load i8*, i8** %l12
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t235 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t272 = phi double [ %t235, %then12 ], [ %t271, %loop.latch16 ]
  store double %t272, double* %l14
  br label %loop.body15
loop.body15:
  %t236 = load double, double* %l14
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t238 = load { i8**, i64 }, { i8**, i64 }* %t237
  %t239 = extractvalue { i8**, i64 } %t238, 1
  %t240 = sitofp i64 %t239 to double
  %t241 = fcmp oge double %t236, %t240
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t244 = load i8*, i8** %l2
  %t245 = load i8*, i8** %l3
  %t246 = load i1, i1* %l4
  %t247 = load double, double* %l5
  %t248 = load double, double* %l6
  %t249 = load i8*, i8** %l7
  %t250 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t251 = load i8*, i8** %l9
  %t252 = load i8*, i8** %l10
  %t253 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t254 = load i8*, i8** %l12
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t256 = load double, double* %l14
  br i1 %t241, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t258 = load double, double* %l14
  %t259 = fptosi double %t258 to i64
  %t260 = load { i8**, i64 }, { i8**, i64 }* %t257
  %t261 = extractvalue { i8**, i64 } %t260, 0
  %t262 = extractvalue { i8**, i64 } %t260, 1
  %t263 = icmp uge i64 %t259, %t262
  ; bounds check: %t263 (if true, out of bounds)
  %t264 = getelementptr i8*, i8** %t261, i64 %t259
  %t265 = load i8*, i8** %t264
  %t266 = call double @parse_parameter_entry(i8* %t265, i8* null)
  store double %t266, double* %l15
  %t267 = load double, double* %l15
  %t268 = load double, double* %l14
  %t269 = sitofp i64 1 to double
  %t270 = fadd double %t268, %t269
  store double %t270, double* %l14
  br label %loop.latch16
loop.latch16:
  %t271 = load double, double* %l14
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %s273 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.273, i32 0, i32 0
  store i8* %s273, i8** %l16
  %t274 = alloca [0 x i8*]
  %t275 = getelementptr [0 x i8*], [0 x i8*]* %t274, i32 0, i32 0
  %t276 = alloca { i8**, i64 }
  %t277 = getelementptr { i8**, i64 }, { i8**, i64 }* %t276, i32 0, i32 0
  store i8** %t275, i8*** %t277
  %t278 = getelementptr { i8**, i64 }, { i8**, i64 }* %t276, i32 0, i32 1
  store i64 0, i64* %t278
  store { i8**, i64 }* %t276, { i8**, i64 }** %l17
  %t279 = load i8*, i8** %l3
  %t280 = load double, double* %l6
  %t281 = sitofp i64 1 to double
  %t282 = fadd double %t280, %t281
  %t283 = load i8*, i8** %l3
  %t284 = call i64 @sailfin_runtime_string_length(i8* %t283)
  %t285 = fptosi double %t282 to i64
  %t286 = call i8* @sailfin_runtime_substring(i8* %t279, i64 %t285, i64 %t284)
  %t287 = call i8* @trim_text(i8* %t286)
  store i8* %t287, i8** %l18
  %t288 = load i8*, i8** %l18
  %t289 = call i64 @sailfin_runtime_string_length(i8* %t288)
  %t290 = icmp sgt i64 %t289, 0
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t292 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t293 = load i8*, i8** %l2
  %t294 = load i8*, i8** %l3
  %t295 = load i1, i1* %l4
  %t296 = load double, double* %l5
  %t297 = load double, double* %l6
  %t298 = load i8*, i8** %l7
  %t299 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t300 = load i8*, i8** %l9
  %t301 = load i8*, i8** %l10
  %t302 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t303 = load i8*, i8** %l12
  %t304 = load i8*, i8** %l16
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t306 = load i8*, i8** %l18
  br i1 %t290, label %then20, label %merge21
then20:
  %t307 = load i8*, i8** %l18
  %s308 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.308, i32 0, i32 0
  %t309 = call double @index_of(i8* %t307, i8* %s308)
  store double %t309, double* %l19
  %s310 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.310, i32 0, i32 0
  store i8* %s310, i8** %l20
  %t311 = load double, double* %l19
  %t312 = sitofp i64 0 to double
  %t313 = fcmp oge double %t311, %t312
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t315 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t316 = load i8*, i8** %l2
  %t317 = load i8*, i8** %l3
  %t318 = load i1, i1* %l4
  %t319 = load double, double* %l5
  %t320 = load double, double* %l6
  %t321 = load i8*, i8** %l7
  %t322 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t323 = load i8*, i8** %l9
  %t324 = load i8*, i8** %l10
  %t325 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t326 = load i8*, i8** %l12
  %t327 = load i8*, i8** %l16
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t329 = load i8*, i8** %l18
  %t330 = load double, double* %l19
  %t331 = load i8*, i8** %l20
  br i1 %t313, label %then22, label %merge23
then22:
  %t332 = load i8*, i8** %l18
  %t333 = load double, double* %l19
  %t334 = load i8*, i8** %l18
  %t335 = call i64 @sailfin_runtime_string_length(i8* %t334)
  %t336 = fptosi double %t333 to i64
  %t337 = call i8* @sailfin_runtime_substring(i8* %t332, i64 %t336, i64 %t335)
  %t338 = call i8* @trim_text(i8* %t337)
  store i8* %t338, i8** %l20
  %t339 = load i8*, i8** %l18
  %t340 = load double, double* %l19
  %t341 = fptosi double %t340 to i64
  %t342 = call i8* @sailfin_runtime_substring(i8* %t339, i64 0, i64 %t341)
  %t343 = call i8* @trim_text(i8* %t342)
  store i8* %t343, i8** %l18
  br label %merge23
merge23:
  %t344 = phi i8* [ %t338, %then22 ], [ %t331, %then20 ]
  %t345 = phi i8* [ %t343, %then22 ], [ %t329, %then20 ]
  store i8* %t344, i8** %l20
  store i8* %t345, i8** %l18
  %t346 = load i8*, i8** %l18
  %t347 = call i64 @sailfin_runtime_string_length(i8* %t346)
  %t348 = icmp sgt i64 %t347, 0
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t350 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t351 = load i8*, i8** %l2
  %t352 = load i8*, i8** %l3
  %t353 = load i1, i1* %l4
  %t354 = load double, double* %l5
  %t355 = load double, double* %l6
  %t356 = load i8*, i8** %l7
  %t357 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t358 = load i8*, i8** %l9
  %t359 = load i8*, i8** %l10
  %t360 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t361 = load i8*, i8** %l12
  %t362 = load i8*, i8** %l16
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t364 = load i8*, i8** %l18
  %t365 = load double, double* %l19
  %t366 = load i8*, i8** %l20
  br i1 %t348, label %then24, label %merge25
then24:
  %t367 = load i8*, i8** %l18
  br label %merge25
merge25:
  %t368 = load i8*, i8** %l20
  %t369 = call i64 @sailfin_runtime_string_length(i8* %t368)
  %t370 = icmp sgt i64 %t369, 0
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t372 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t373 = load i8*, i8** %l2
  %t374 = load i8*, i8** %l3
  %t375 = load i1, i1* %l4
  %t376 = load double, double* %l5
  %t377 = load double, double* %l6
  %t378 = load i8*, i8** %l7
  %t379 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t380 = load i8*, i8** %l9
  %t381 = load i8*, i8** %l10
  %t382 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t383 = load i8*, i8** %l12
  %t384 = load i8*, i8** %l16
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t386 = load i8*, i8** %l18
  %t387 = load double, double* %l19
  %t388 = load i8*, i8** %l20
  br i1 %t370, label %then26, label %merge27
then26:
  %t390 = load i8*, i8** %l20
  %s391 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.391, i32 0, i32 0
  %t392 = call i1 @starts_with(i8* %t390, i8* %s391)
  br label %logical_and_entry_389

logical_and_entry_389:
  br i1 %t392, label %logical_and_right_389, label %logical_and_merge_389

logical_and_right_389:
  br label %merge27
merge27:
  br label %merge21
merge21:
  %t393 = phi i8* [ %t343, %then20 ], [ %t306, %entry ]
  store i8* %t393, i8** %l18
  %t394 = load i8*, i8** %l9
  %t395 = insertvalue %NativeInterfaceSignature undef, i8* %t394, 0
  %t396 = load i1, i1* %l4
  %t397 = insertvalue %NativeInterfaceSignature %t395, i1 %t396, 1
  %t398 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t399 = extractvalue %HeaderNameParse %t398, 1
  %t400 = insertvalue %NativeInterfaceSignature %t397, { i8**, i64 }* %t399, 2
  %t401 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t402 = bitcast { %NativeParameter*, i64 }* %t401 to { i8**, i64 }*
  %t403 = insertvalue %NativeInterfaceSignature %t400, { i8**, i64 }* %t402, 3
  %t404 = load i8*, i8** %l16
  %t405 = insertvalue %NativeInterfaceSignature %t403, i8* %t404, 4
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t407 = insertvalue %NativeInterfaceSignature %t405, { i8**, i64 }* %t406, 5
  store %NativeInterfaceSignature %t407, %NativeInterfaceSignature* %l21
  %t409 = load i8*, i8** %l9
  %t410 = call i64 @sailfin_runtime_string_length(i8* %t409)
  %t411 = icmp sgt i64 %t410, 0
  br label %logical_and_entry_408

logical_and_entry_408:
  br i1 %t411, label %logical_and_right_408, label %logical_and_merge_408

logical_and_right_408:
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t413 = load { i8**, i64 }, { i8**, i64 }* %t412
  %t414 = extractvalue { i8**, i64 } %t413, 1
  %t415 = icmp eq i64 %t414, 0
  br label %logical_and_right_end_408

logical_and_right_end_408:
  br label %logical_and_merge_408

logical_and_merge_408:
  %t416 = phi i1 [ false, %logical_and_entry_408 ], [ %t415, %logical_and_right_end_408 ]
  store i1 %t416, i1* %l22
  %t417 = load i1, i1* %l22
  %t418 = insertvalue %InterfaceSignatureParse undef, i1 %t417, 0
  %t419 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l21
  %t420 = insertvalue %InterfaceSignatureParse %t418, i8* null, 1
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t422 = insertvalue %InterfaceSignatureParse %t420, { i8**, i64 }* %t421, 2
  ret %InterfaceSignatureParse %t422
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
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 32, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  %t95 = call double @index_of(i8* %t90, i8* %t94)
  store double %t95, double* %l8
  %t96 = load double, double* %l8
  %t97 = sitofp i64 0 to double
  %t98 = fcmp oge double %t96, %t97
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l1
  %t101 = load i8*, i8** %l2
  %t102 = load i8*, i8** %l3
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t104 = load double, double* %l5
  %t105 = load double, double* %l8
  br i1 %t98, label %then7, label %merge8
then7:
  %t106 = load i8*, i8** %l1
  %t107 = load double, double* %l8
  %t108 = fptosi double %t107 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %t106, i64 0, i64 %t108)
  %t110 = call i8* @trim_text(i8* %t109)
  store i8* %t110, i8** %l2
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l8
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  %t115 = load i8*, i8** %l1
  %t116 = call i64 @sailfin_runtime_string_length(i8* %t115)
  %t117 = fptosi double %t114 to i64
  %t118 = call i8* @sailfin_runtime_substring(i8* %t111, i64 %t117, i64 %t116)
  %t119 = call i8* @trim_text(i8* %t118)
  store i8* %t119, i8** %l3
  br label %merge8
merge8:
  %t120 = phi i8* [ %t110, %then7 ], [ %t101, %else3 ]
  %t121 = phi i8* [ %t119, %then7 ], [ %t102, %else3 ]
  store i8* %t120, i8** %l2
  store i8* %t121, i8** %l3
  br label %merge4
merge4:
  %t122 = phi { i8**, i64 }* [ null, %then2 ], [ %t34, %else3 ]
  %t123 = phi i8* [ %t57, %then2 ], [ %t110, %else3 ]
  %t124 = phi { i8**, i64 }* [ %t80, %then2 ], [ %t38, %else3 ]
  %t125 = phi i8* [ %t89, %then2 ], [ %t119, %else3 ]
  store { i8**, i64 }* %t122, { i8**, i64 }** %l0
  store i8* %t123, i8** %l2
  store { i8**, i64 }* %t124, { i8**, i64 }** %l4
  store i8* %t125, i8** %l3
  %t126 = load i8*, i8** %l2
  %t127 = call i8* @strip_generics(i8* %t126)
  store i8* %t127, i8** %l2
  %t128 = load i8*, i8** %l2
  %t129 = insertvalue %HeaderNameParse undef, i8* %t128, 0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t131 = insertvalue %HeaderNameParse %t129, { i8**, i64 }* %t130, 1
  %t132 = load i8*, i8** %l3
  %t133 = insertvalue %HeaderNameParse %t131, i8* %t132, 2
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = insertvalue %HeaderNameParse %t133, { i8**, i64 }* %t134, 3
  ret %HeaderNameParse %t135
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
  %t420 = phi i8* [ %t13, %entry ], [ %t413, %loop.latch2 ]
  %t421 = phi double [ %t14, %entry ], [ %t414, %loop.latch2 ]
  %t422 = phi i8* [ %t15, %entry ], [ %t415, %loop.latch2 ]
  %t423 = phi double [ %t17, %entry ], [ %t416, %loop.latch2 ]
  %t424 = phi double [ %t18, %entry ], [ %t417, %loop.latch2 ]
  %t425 = phi double [ %t19, %entry ], [ %t418, %loop.latch2 ]
  %t426 = phi { i8**, i64 }* [ %t12, %entry ], [ %t419, %loop.latch2 ]
  store i8* %t420, i8** %l1
  store double %t421, double* %l2
  store i8* %t422, i8** %l3
  store double %t423, double* %l5
  store double %t424, double* %l6
  store double %t425, double* %l7
  store { i8**, i64 }* %t426, { i8**, i64 }** %l0
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
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 %t52, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8* %t56, i8** %l1
  %t57 = load i8, i8* %l8
  %t58 = icmp eq i8 %t57, 92
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l2
  %t62 = load i8*, i8** %l3
  %t63 = load double, double* %l4
  %t64 = load double, double* %l5
  %t65 = load double, double* %l6
  %t66 = load double, double* %l7
  %t67 = load i8, i8* %l8
  br i1 %t58, label %then8, label %merge9
then8:
  %t68 = load double, double* %l2
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  %t71 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t72 = sitofp i64 %t71 to double
  %t73 = fcmp olt double %t70, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load double, double* %l2
  %t77 = load i8*, i8** %l3
  %t78 = load double, double* %l4
  %t79 = load double, double* %l5
  %t80 = load double, double* %l6
  %t81 = load double, double* %l7
  %t82 = load i8, i8* %l8
  br i1 %t73, label %then10, label %merge11
then10:
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = sitofp i64 2 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t87 = phi i8* [ null, %then8 ], [ %t60, %then6 ]
  %t88 = phi double [ %t86, %then8 ], [ %t61, %then6 ]
  store i8* %t87, i8** %l1
  store double %t88, double* %l2
  %t89 = load i8, i8* %l8
  %t90 = load i8*, i8** %l3
  %t91 = getelementptr i8, i8* %t90, i64 0
  %t92 = load i8, i8* %t91
  %t93 = icmp eq i8 %t89, %t92
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l2
  %t97 = load i8*, i8** %l3
  %t98 = load double, double* %l4
  %t99 = load double, double* %l5
  %t100 = load double, double* %l6
  %t101 = load double, double* %l7
  %t102 = load i8, i8* %l8
  br i1 %t93, label %then12, label %merge13
then12:
  %s103 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.103, i32 0, i32 0
  store i8* %s103, i8** %l3
  br label %merge13
merge13:
  %t104 = phi i8* [ %s103, %then12 ], [ %t97, %then6 ]
  store i8* %t104, i8** %l3
  %t105 = load double, double* %l2
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l2
  br label %loop.latch2
merge7:
  %t109 = load i8, i8* %l8
  %t110 = icmp eq i8 %t109, 34
  br label %logical_or_entry_108

logical_or_entry_108:
  br i1 %t110, label %logical_or_merge_108, label %logical_or_right_108

logical_or_right_108:
  %t111 = load i8, i8* %l8
  %t112 = icmp eq i8 %t111, 39
  br label %logical_or_right_end_108

logical_or_right_end_108:
  br label %logical_or_merge_108

logical_or_merge_108:
  %t113 = phi i1 [ true, %logical_or_entry_108 ], [ %t112, %logical_or_right_end_108 ]
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l2
  %t117 = load i8*, i8** %l3
  %t118 = load double, double* %l4
  %t119 = load double, double* %l5
  %t120 = load double, double* %l6
  %t121 = load double, double* %l7
  %t122 = load i8, i8* %l8
  br i1 %t113, label %then14, label %merge15
then14:
  %t123 = load i8, i8* %l8
  %t124 = alloca [2 x i8], align 1
  %t125 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 0
  store i8 %t123, i8* %t125
  %t126 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 1
  store i8 0, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 0
  store i8* %t127, i8** %l3
  %t128 = load i8*, i8** %l1
  %t129 = load i8, i8* %l8
  %t130 = getelementptr i8, i8* %t128, i64 0
  %t131 = load i8, i8* %t130
  %t132 = add i8 %t131, %t129
  %t133 = alloca [2 x i8], align 1
  %t134 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  store i8 %t132, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 1
  store i8 0, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  store i8* %t136, i8** %l1
  %t137 = load double, double* %l2
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l2
  br label %loop.latch2
merge15:
  %t140 = load i8, i8* %l8
  %t141 = load i8, i8* %l8
  %t142 = load i8, i8* %l8
  %t143 = icmp eq i8 %t142, 40
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8*, i8** %l1
  %t146 = load double, double* %l2
  %t147 = load i8*, i8** %l3
  %t148 = load double, double* %l4
  %t149 = load double, double* %l5
  %t150 = load double, double* %l6
  %t151 = load double, double* %l7
  %t152 = load i8, i8* %l8
  br i1 %t143, label %then16, label %merge17
then16:
  %t153 = load double, double* %l5
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l5
  %t156 = load i8*, i8** %l1
  %t157 = load i8, i8* %l8
  %t158 = getelementptr i8, i8* %t156, i64 0
  %t159 = load i8, i8* %t158
  %t160 = add i8 %t159, %t157
  %t161 = alloca [2 x i8], align 1
  %t162 = getelementptr [2 x i8], [2 x i8]* %t161, i32 0, i32 0
  store i8 %t160, i8* %t162
  %t163 = getelementptr [2 x i8], [2 x i8]* %t161, i32 0, i32 1
  store i8 0, i8* %t163
  %t164 = getelementptr [2 x i8], [2 x i8]* %t161, i32 0, i32 0
  store i8* %t164, i8** %l1
  %t165 = load double, double* %l2
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l2
  br label %loop.latch2
merge17:
  %t168 = load i8, i8* %l8
  %t169 = icmp eq i8 %t168, 41
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t171 = load i8*, i8** %l1
  %t172 = load double, double* %l2
  %t173 = load i8*, i8** %l3
  %t174 = load double, double* %l4
  %t175 = load double, double* %l5
  %t176 = load double, double* %l6
  %t177 = load double, double* %l7
  %t178 = load i8, i8* %l8
  br i1 %t169, label %then18, label %merge19
then18:
  %t179 = load double, double* %l5
  %t180 = sitofp i64 0 to double
  %t181 = fcmp ogt double %t179, %t180
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load i8*, i8** %l3
  %t186 = load double, double* %l4
  %t187 = load double, double* %l5
  %t188 = load double, double* %l6
  %t189 = load double, double* %l7
  %t190 = load i8, i8* %l8
  br i1 %t181, label %then20, label %merge21
then20:
  %t191 = load double, double* %l5
  %t192 = sitofp i64 1 to double
  %t193 = fsub double %t191, %t192
  store double %t193, double* %l5
  br label %merge21
merge21:
  %t194 = phi double [ %t193, %then20 ], [ %t187, %then18 ]
  store double %t194, double* %l5
  %t195 = load i8*, i8** %l1
  %t196 = load i8, i8* %l8
  %t197 = getelementptr i8, i8* %t195, i64 0
  %t198 = load i8, i8* %t197
  %t199 = add i8 %t198, %t196
  %t200 = alloca [2 x i8], align 1
  %t201 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  store i8 %t199, i8* %t201
  %t202 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 1
  store i8 0, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  store i8* %t203, i8** %l1
  %t204 = load double, double* %l2
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l2
  br label %loop.latch2
merge19:
  %t207 = load i8, i8* %l8
  %t208 = icmp eq i8 %t207, 91
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t210 = load i8*, i8** %l1
  %t211 = load double, double* %l2
  %t212 = load i8*, i8** %l3
  %t213 = load double, double* %l4
  %t214 = load double, double* %l5
  %t215 = load double, double* %l6
  %t216 = load double, double* %l7
  %t217 = load i8, i8* %l8
  br i1 %t208, label %then22, label %merge23
then22:
  %t218 = load double, double* %l6
  %t219 = sitofp i64 1 to double
  %t220 = fadd double %t218, %t219
  store double %t220, double* %l6
  %t221 = load i8*, i8** %l1
  %t222 = load i8, i8* %l8
  %t223 = getelementptr i8, i8* %t221, i64 0
  %t224 = load i8, i8* %t223
  %t225 = add i8 %t224, %t222
  %t226 = alloca [2 x i8], align 1
  %t227 = getelementptr [2 x i8], [2 x i8]* %t226, i32 0, i32 0
  store i8 %t225, i8* %t227
  %t228 = getelementptr [2 x i8], [2 x i8]* %t226, i32 0, i32 1
  store i8 0, i8* %t228
  %t229 = getelementptr [2 x i8], [2 x i8]* %t226, i32 0, i32 0
  store i8* %t229, i8** %l1
  %t230 = load double, double* %l2
  %t231 = sitofp i64 1 to double
  %t232 = fadd double %t230, %t231
  store double %t232, double* %l2
  br label %loop.latch2
merge23:
  %t233 = load i8, i8* %l8
  %t234 = icmp eq i8 %t233, 93
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t236 = load i8*, i8** %l1
  %t237 = load double, double* %l2
  %t238 = load i8*, i8** %l3
  %t239 = load double, double* %l4
  %t240 = load double, double* %l5
  %t241 = load double, double* %l6
  %t242 = load double, double* %l7
  %t243 = load i8, i8* %l8
  br i1 %t234, label %then24, label %merge25
then24:
  %t244 = load double, double* %l6
  %t245 = sitofp i64 0 to double
  %t246 = fcmp ogt double %t244, %t245
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t248 = load i8*, i8** %l1
  %t249 = load double, double* %l2
  %t250 = load i8*, i8** %l3
  %t251 = load double, double* %l4
  %t252 = load double, double* %l5
  %t253 = load double, double* %l6
  %t254 = load double, double* %l7
  %t255 = load i8, i8* %l8
  br i1 %t246, label %then26, label %merge27
then26:
  %t256 = load double, double* %l6
  %t257 = sitofp i64 1 to double
  %t258 = fsub double %t256, %t257
  store double %t258, double* %l6
  br label %merge27
merge27:
  %t259 = phi double [ %t258, %then26 ], [ %t253, %then24 ]
  store double %t259, double* %l6
  %t260 = load i8*, i8** %l1
  %t261 = load i8, i8* %l8
  %t262 = getelementptr i8, i8* %t260, i64 0
  %t263 = load i8, i8* %t262
  %t264 = add i8 %t263, %t261
  %t265 = alloca [2 x i8], align 1
  %t266 = getelementptr [2 x i8], [2 x i8]* %t265, i32 0, i32 0
  store i8 %t264, i8* %t266
  %t267 = getelementptr [2 x i8], [2 x i8]* %t265, i32 0, i32 1
  store i8 0, i8* %t267
  %t268 = getelementptr [2 x i8], [2 x i8]* %t265, i32 0, i32 0
  store i8* %t268, i8** %l1
  %t269 = load double, double* %l2
  %t270 = sitofp i64 1 to double
  %t271 = fadd double %t269, %t270
  store double %t271, double* %l2
  br label %loop.latch2
merge25:
  %t272 = load i8, i8* %l8
  %t273 = icmp eq i8 %t272, 123
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t275 = load i8*, i8** %l1
  %t276 = load double, double* %l2
  %t277 = load i8*, i8** %l3
  %t278 = load double, double* %l4
  %t279 = load double, double* %l5
  %t280 = load double, double* %l6
  %t281 = load double, double* %l7
  %t282 = load i8, i8* %l8
  br i1 %t273, label %then28, label %merge29
then28:
  %t283 = load double, double* %l7
  %t284 = sitofp i64 1 to double
  %t285 = fadd double %t283, %t284
  store double %t285, double* %l7
  %t286 = load i8*, i8** %l1
  %t287 = load i8, i8* %l8
  %t288 = getelementptr i8, i8* %t286, i64 0
  %t289 = load i8, i8* %t288
  %t290 = add i8 %t289, %t287
  %t291 = alloca [2 x i8], align 1
  %t292 = getelementptr [2 x i8], [2 x i8]* %t291, i32 0, i32 0
  store i8 %t290, i8* %t292
  %t293 = getelementptr [2 x i8], [2 x i8]* %t291, i32 0, i32 1
  store i8 0, i8* %t293
  %t294 = getelementptr [2 x i8], [2 x i8]* %t291, i32 0, i32 0
  store i8* %t294, i8** %l1
  %t295 = load double, double* %l2
  %t296 = sitofp i64 1 to double
  %t297 = fadd double %t295, %t296
  store double %t297, double* %l2
  br label %loop.latch2
merge29:
  %t298 = load i8, i8* %l8
  %t299 = icmp eq i8 %t298, 125
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t301 = load i8*, i8** %l1
  %t302 = load double, double* %l2
  %t303 = load i8*, i8** %l3
  %t304 = load double, double* %l4
  %t305 = load double, double* %l5
  %t306 = load double, double* %l6
  %t307 = load double, double* %l7
  %t308 = load i8, i8* %l8
  br i1 %t299, label %then30, label %merge31
then30:
  %t309 = load double, double* %l7
  %t310 = sitofp i64 0 to double
  %t311 = fcmp ogt double %t309, %t310
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t313 = load i8*, i8** %l1
  %t314 = load double, double* %l2
  %t315 = load i8*, i8** %l3
  %t316 = load double, double* %l4
  %t317 = load double, double* %l5
  %t318 = load double, double* %l6
  %t319 = load double, double* %l7
  %t320 = load i8, i8* %l8
  br i1 %t311, label %then32, label %merge33
then32:
  %t321 = load double, double* %l7
  %t322 = sitofp i64 1 to double
  %t323 = fsub double %t321, %t322
  store double %t323, double* %l7
  br label %merge33
merge33:
  %t324 = phi double [ %t323, %then32 ], [ %t319, %then30 ]
  store double %t324, double* %l7
  %t325 = load i8*, i8** %l1
  %t326 = load i8, i8* %l8
  %t327 = getelementptr i8, i8* %t325, i64 0
  %t328 = load i8, i8* %t327
  %t329 = add i8 %t328, %t326
  %t330 = alloca [2 x i8], align 1
  %t331 = getelementptr [2 x i8], [2 x i8]* %t330, i32 0, i32 0
  store i8 %t329, i8* %t331
  %t332 = getelementptr [2 x i8], [2 x i8]* %t330, i32 0, i32 1
  store i8 0, i8* %t332
  %t333 = getelementptr [2 x i8], [2 x i8]* %t330, i32 0, i32 0
  store i8* %t333, i8** %l1
  %t334 = load double, double* %l2
  %t335 = sitofp i64 1 to double
  %t336 = fadd double %t334, %t335
  store double %t336, double* %l2
  br label %loop.latch2
merge31:
  %t337 = load i8, i8* %l8
  %t338 = icmp eq i8 %t337, 44
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t340 = load i8*, i8** %l1
  %t341 = load double, double* %l2
  %t342 = load i8*, i8** %l3
  %t343 = load double, double* %l4
  %t344 = load double, double* %l5
  %t345 = load double, double* %l6
  %t346 = load double, double* %l7
  %t347 = load i8, i8* %l8
  br i1 %t338, label %then34, label %merge35
then34:
  %t351 = load double, double* %l4
  %t352 = sitofp i64 0 to double
  %t353 = fcmp oeq double %t351, %t352
  br label %logical_and_entry_350

logical_and_entry_350:
  br i1 %t353, label %logical_and_right_350, label %logical_and_merge_350

logical_and_right_350:
  %t354 = load double, double* %l5
  %t355 = sitofp i64 0 to double
  %t356 = fcmp oeq double %t354, %t355
  br label %logical_and_right_end_350

logical_and_right_end_350:
  br label %logical_and_merge_350

logical_and_merge_350:
  %t357 = phi i1 [ false, %logical_and_entry_350 ], [ %t356, %logical_and_right_end_350 ]
  br label %logical_and_entry_349

logical_and_entry_349:
  br i1 %t357, label %logical_and_right_349, label %logical_and_merge_349

logical_and_right_349:
  %t358 = load double, double* %l6
  %t359 = sitofp i64 0 to double
  %t360 = fcmp oeq double %t358, %t359
  br label %logical_and_right_end_349

logical_and_right_end_349:
  br label %logical_and_merge_349

logical_and_merge_349:
  %t361 = phi i1 [ false, %logical_and_entry_349 ], [ %t360, %logical_and_right_end_349 ]
  br label %logical_and_entry_348

logical_and_entry_348:
  br i1 %t361, label %logical_and_right_348, label %logical_and_merge_348

logical_and_right_348:
  %t362 = load double, double* %l7
  %t363 = sitofp i64 0 to double
  %t364 = fcmp oeq double %t362, %t363
  br label %logical_and_right_end_348

logical_and_right_end_348:
  br label %logical_and_merge_348

logical_and_merge_348:
  %t365 = phi i1 [ false, %logical_and_entry_348 ], [ %t364, %logical_and_right_end_348 ]
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t367 = load i8*, i8** %l1
  %t368 = load double, double* %l2
  %t369 = load i8*, i8** %l3
  %t370 = load double, double* %l4
  %t371 = load double, double* %l5
  %t372 = load double, double* %l6
  %t373 = load double, double* %l7
  %t374 = load i8, i8* %l8
  br i1 %t365, label %then36, label %merge37
then36:
  %t375 = load i8*, i8** %l1
  %t376 = call i8* @trim_text(i8* %t375)
  store i8* %t376, i8** %l9
  %t377 = load i8*, i8** %l9
  %t378 = call i64 @sailfin_runtime_string_length(i8* %t377)
  %t379 = icmp sgt i64 %t378, 0
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load i8*, i8** %l1
  %t382 = load double, double* %l2
  %t383 = load i8*, i8** %l3
  %t384 = load double, double* %l4
  %t385 = load double, double* %l5
  %t386 = load double, double* %l6
  %t387 = load double, double* %l7
  %t388 = load i8, i8* %l8
  %t389 = load i8*, i8** %l9
  br i1 %t379, label %then38, label %merge39
then38:
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t391 = load i8*, i8** %l9
  %t392 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t390, i8* %t391)
  store { i8**, i64 }* %t392, { i8**, i64 }** %l0
  br label %merge39
merge39:
  %t393 = phi { i8**, i64 }* [ %t392, %then38 ], [ %t380, %then36 ]
  store { i8**, i64 }* %t393, { i8**, i64 }** %l0
  %s394 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.394, i32 0, i32 0
  store i8* %s394, i8** %l1
  %t395 = load double, double* %l2
  %t396 = sitofp i64 1 to double
  %t397 = fadd double %t395, %t396
  store double %t397, double* %l2
  br label %loop.latch2
merge37:
  br label %merge35
merge35:
  %t398 = phi { i8**, i64 }* [ %t392, %then34 ], [ %t339, %loop.body1 ]
  %t399 = phi i8* [ %s394, %then34 ], [ %t340, %loop.body1 ]
  %t400 = phi double [ %t397, %then34 ], [ %t341, %loop.body1 ]
  store { i8**, i64 }* %t398, { i8**, i64 }** %l0
  store i8* %t399, i8** %l1
  store double %t400, double* %l2
  %t401 = load i8*, i8** %l1
  %t402 = load i8, i8* %l8
  %t403 = getelementptr i8, i8* %t401, i64 0
  %t404 = load i8, i8* %t403
  %t405 = add i8 %t404, %t402
  %t406 = alloca [2 x i8], align 1
  %t407 = getelementptr [2 x i8], [2 x i8]* %t406, i32 0, i32 0
  store i8 %t405, i8* %t407
  %t408 = getelementptr [2 x i8], [2 x i8]* %t406, i32 0, i32 1
  store i8 0, i8* %t408
  %t409 = getelementptr [2 x i8], [2 x i8]* %t406, i32 0, i32 0
  store i8* %t409, i8** %l1
  %t410 = load double, double* %l2
  %t411 = sitofp i64 1 to double
  %t412 = fadd double %t410, %t411
  store double %t412, double* %l2
  br label %loop.latch2
loop.latch2:
  %t413 = load i8*, i8** %l1
  %t414 = load double, double* %l2
  %t415 = load i8*, i8** %l3
  %t416 = load double, double* %l5
  %t417 = load double, double* %l6
  %t418 = load double, double* %l7
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t427 = load i8*, i8** %l1
  %t428 = call i8* @trim_text(i8* %t427)
  store i8* %t428, i8** %l10
  %t429 = load i8*, i8** %l10
  %t430 = call i64 @sailfin_runtime_string_length(i8* %t429)
  %t431 = icmp sgt i64 %t430, 0
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load i8*, i8** %l1
  %t434 = load double, double* %l2
  %t435 = load i8*, i8** %l3
  %t436 = load double, double* %l4
  %t437 = load double, double* %l5
  %t438 = load double, double* %l6
  %t439 = load double, double* %l7
  %t440 = load i8*, i8** %l10
  br i1 %t431, label %then40, label %merge41
then40:
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t442 = load i8*, i8** %l10
  %t443 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t441, i8* %t442)
  store { i8**, i64 }* %t443, { i8**, i64 }** %l0
  br label %merge41
merge41:
  %t444 = phi { i8**, i64 }* [ %t443, %then40 ], [ %t432, %entry ]
  store { i8**, i64 }* %t444, { i8**, i64 }** %l0
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t445
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
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 32, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  %t23 = call double @index_of(i8* %t18, i8* %t22)
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = sitofp i64 0 to double
  %t26 = fcmp oge double %t24, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load i8*, i8** %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then0, label %merge1
then0:
  %t32 = load i8*, i8** %l3
  %t33 = load double, double* %l4
  %t34 = fptosi double %t33 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t34)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l3
  br label %merge1
merge1:
  %t37 = phi i8* [ %t36, %then0 ], [ %t30, %entry ]
  store i8* %t37, i8** %l3
  %t38 = load i8*, i8** %l3
  %t39 = call i8* @strip_generics(i8* %t38)
  store i8* %t39, i8** %l3
  %t40 = load i8*, i8** %l3
  %t41 = call i64 @sailfin_runtime_string_length(i8* %t40)
  %t42 = icmp eq i64 %t41, 0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load i8*, i8** %l2
  %t46 = load i8*, i8** %l3
  %t47 = load double, double* %l4
  br i1 %t42, label %then2, label %merge3
then2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s49 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.49, i32 0, i32 0
  %t50 = load i8*, i8** %l1
  %t51 = add i8* %s49, %t50
  %t52 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t48, i8* %t51)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  ret %EnumParseResult zeroinitializer
merge3:
  %t53 = alloca [0 x %NativeEnumVariant]
  %t54 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* %t53, i32 0, i32 0
  %t55 = alloca { %NativeEnumVariant*, i64 }
  %t56 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t55, i32 0, i32 0
  store %NativeEnumVariant* %t54, %NativeEnumVariant** %t56
  %t57 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %NativeEnumVariant*, i64 }* %t55, { %NativeEnumVariant*, i64 }** %l5
  %t58 = alloca [0 x %NativeEnumVariantLayout]
  %t59 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t58, i32 0, i32 0
  %t60 = alloca { %NativeEnumVariantLayout*, i64 }
  %t61 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t60, i32 0, i32 0
  store %NativeEnumVariantLayout* %t59, %NativeEnumVariantLayout** %t61
  %t62 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t60, i32 0, i32 1
  store i64 0, i64* %t62
  store { %NativeEnumVariantLayout*, i64 }* %t60, { %NativeEnumVariantLayout*, i64 }** %l6
  %t63 = sitofp i64 0 to double
  store double %t63, double* %l7
  %t64 = sitofp i64 0 to double
  store double %t64, double* %l8
  %s65 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.65, i32 0, i32 0
  store i8* %s65, i8** %l9
  %t66 = sitofp i64 0 to double
  store double %t66, double* %l10
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %start_index, %t68
  store double %t69, double* %l14
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load i8*, i8** %l2
  %t73 = load i8*, i8** %l3
  %t74 = load double, double* %l4
  %t75 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t76 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t77 = load double, double* %l7
  %t78 = load double, double* %l8
  %t79 = load i8*, i8** %l9
  %t80 = load double, double* %l10
  %t81 = load double, double* %l11
  %t82 = load i1, i1* %l12
  %t83 = load i1, i1* %l13
  %t84 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t713 = phi { i8**, i64 }* [ %t70, %entry ], [ %t703, %loop.latch6 ]
  %t714 = phi double [ %t84, %entry ], [ %t704, %loop.latch6 ]
  %t715 = phi double [ %t77, %entry ], [ %t705, %loop.latch6 ]
  %t716 = phi double [ %t78, %entry ], [ %t706, %loop.latch6 ]
  %t717 = phi i8* [ %t79, %entry ], [ %t707, %loop.latch6 ]
  %t718 = phi double [ %t80, %entry ], [ %t708, %loop.latch6 ]
  %t719 = phi double [ %t81, %entry ], [ %t709, %loop.latch6 ]
  %t720 = phi i1 [ %t82, %entry ], [ %t710, %loop.latch6 ]
  %t721 = phi { %NativeEnumVariantLayout*, i64 }* [ %t76, %entry ], [ %t711, %loop.latch6 ]
  %t722 = phi i1 [ %t83, %entry ], [ %t712, %loop.latch6 ]
  store { i8**, i64 }* %t713, { i8**, i64 }** %l0
  store double %t714, double* %l14
  store double %t715, double* %l7
  store double %t716, double* %l8
  store i8* %t717, i8** %l9
  store double %t718, double* %l10
  store double %t719, double* %l11
  store i1 %t720, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t721, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t722, i1* %l13
  br label %loop.body5
loop.body5:
  %t85 = load double, double* %l14
  %t86 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = sitofp i64 %t87 to double
  %t89 = fcmp oge double %t85, %t88
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load i8*, i8** %l2
  %t93 = load i8*, i8** %l3
  %t94 = load double, double* %l4
  %t95 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t96 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t97 = load double, double* %l7
  %t98 = load double, double* %l8
  %t99 = load i8*, i8** %l9
  %t100 = load double, double* %l10
  %t101 = load double, double* %l11
  %t102 = load i1, i1* %l12
  %t103 = load i1, i1* %l13
  %t104 = load double, double* %l14
  br i1 %t89, label %then8, label %merge9
then8:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s106 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.106, i32 0, i32 0
  %t107 = load i8*, i8** %l3
  %t108 = add i8* %s106, %t107
  %t109 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t105, i8* %t108)
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  store i8* null, i8** %l15
  %t110 = load i1, i1* %l12
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load i8*, i8** %l2
  %t114 = load i8*, i8** %l3
  %t115 = load double, double* %l4
  %t116 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t117 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t118 = load double, double* %l7
  %t119 = load double, double* %l8
  %t120 = load i8*, i8** %l9
  %t121 = load double, double* %l10
  %t122 = load double, double* %l11
  %t123 = load i1, i1* %l12
  %t124 = load i1, i1* %l13
  %t125 = load double, double* %l14
  %t126 = load i8*, i8** %l15
  br i1 %t110, label %then10, label %merge11
then10:
  %t127 = load double, double* %l7
  %t128 = insertvalue %NativeEnumLayout undef, double %t127, 0
  %t129 = load double, double* %l8
  %t130 = insertvalue %NativeEnumLayout %t128, double %t129, 1
  %t131 = load i8*, i8** %l9
  %t132 = insertvalue %NativeEnumLayout %t130, i8* %t131, 2
  %t133 = load double, double* %l10
  %t134 = insertvalue %NativeEnumLayout %t132, double %t133, 3
  %t135 = load double, double* %l11
  %t136 = insertvalue %NativeEnumLayout %t134, double %t135, 4
  %t137 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t138 = bitcast { %NativeEnumVariantLayout*, i64 }* %t137 to { i8**, i64 }*
  %t139 = insertvalue %NativeEnumLayout %t136, { i8**, i64 }* %t138, 5
  store i8* null, i8** %l15
  br label %merge11
merge11:
  %t140 = phi i8* [ null, %then10 ], [ %t126, %then8 ]
  store i8* %t140, i8** %l15
  %t141 = load i8*, i8** %l3
  %t142 = insertvalue %NativeEnum undef, i8* %t141, 0
  %t143 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t144 = bitcast { %NativeEnumVariant*, i64 }* %t143 to { i8**, i64 }*
  %t145 = insertvalue %NativeEnum %t142, { i8**, i64 }* %t144, 1
  %t146 = load i8*, i8** %l15
  %t147 = insertvalue %NativeEnum %t145, i8* %t146, 2
  %t148 = insertvalue %EnumParseResult undef, i8* null, 0
  %t149 = load double, double* %l14
  %t150 = insertvalue %EnumParseResult %t148, double %t149, 1
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = insertvalue %EnumParseResult %t150, { i8**, i64 }* %t151, 2
  ret %EnumParseResult %t152
merge9:
  %t153 = load double, double* %l14
  %t154 = fptosi double %t153 to i64
  %t155 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t156 = extractvalue { i8**, i64 } %t155, 0
  %t157 = extractvalue { i8**, i64 } %t155, 1
  %t158 = icmp uge i64 %t154, %t157
  ; bounds check: %t158 (if true, out of bounds)
  %t159 = getelementptr i8*, i8** %t156, i64 %t154
  %t160 = load i8*, i8** %t159
  %t161 = call i8* @trim_text(i8* %t160)
  store i8* %t161, i8** %l16
  %t163 = load i8*, i8** %l16
  %t164 = call i64 @sailfin_runtime_string_length(i8* %t163)
  %t165 = icmp eq i64 %t164, 0
  br label %logical_or_entry_162

logical_or_entry_162:
  br i1 %t165, label %logical_or_merge_162, label %logical_or_right_162

logical_or_right_162:
  %t166 = load i8*, i8** %l16
  %t167 = alloca [2 x i8], align 1
  %t168 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  store i8 59, i8* %t168
  %t169 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 1
  store i8 0, i8* %t169
  %t170 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  %t171 = call i1 @starts_with(i8* %t166, i8* %t170)
  br label %logical_or_right_end_162

logical_or_right_end_162:
  br label %logical_or_merge_162

logical_or_merge_162:
  %t172 = phi i1 [ true, %logical_or_entry_162 ], [ %t171, %logical_or_right_end_162 ]
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load i8*, i8** %l1
  %t175 = load i8*, i8** %l2
  %t176 = load i8*, i8** %l3
  %t177 = load double, double* %l4
  %t178 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t179 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t180 = load double, double* %l7
  %t181 = load double, double* %l8
  %t182 = load i8*, i8** %l9
  %t183 = load double, double* %l10
  %t184 = load double, double* %l11
  %t185 = load i1, i1* %l12
  %t186 = load i1, i1* %l13
  %t187 = load double, double* %l14
  %t188 = load i8*, i8** %l16
  br i1 %t172, label %then12, label %merge13
then12:
  %t189 = load double, double* %l14
  %t190 = sitofp i64 1 to double
  %t191 = fadd double %t189, %t190
  store double %t191, double* %l14
  br label %loop.latch6
merge13:
  %t192 = load i8*, i8** %l16
  %s193 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.193, i32 0, i32 0
  %t194 = icmp eq i8* %t192, %s193
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t196 = load i8*, i8** %l1
  %t197 = load i8*, i8** %l2
  %t198 = load i8*, i8** %l3
  %t199 = load double, double* %l4
  %t200 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t201 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t202 = load double, double* %l7
  %t203 = load double, double* %l8
  %t204 = load i8*, i8** %l9
  %t205 = load double, double* %l10
  %t206 = load double, double* %l11
  %t207 = load i1, i1* %l12
  %t208 = load i1, i1* %l13
  %t209 = load double, double* %l14
  %t210 = load i8*, i8** %l16
  br i1 %t194, label %then14, label %merge15
then14:
  %t211 = load double, double* %l14
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l14
  br label %loop.latch6
merge15:
  %t214 = load i8*, i8** %l16
  %s215 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.215, i32 0, i32 0
  %t216 = call i1 @starts_with(i8* %t214, i8* %s215)
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l1
  %t219 = load i8*, i8** %l2
  %t220 = load i8*, i8** %l3
  %t221 = load double, double* %l4
  %t222 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t223 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t224 = load double, double* %l7
  %t225 = load double, double* %l8
  %t226 = load i8*, i8** %l9
  %t227 = load double, double* %l10
  %t228 = load double, double* %l11
  %t229 = load i1, i1* %l12
  %t230 = load i1, i1* %l13
  %t231 = load double, double* %l14
  %t232 = load i8*, i8** %l16
  br i1 %t216, label %then16, label %merge17
then16:
  %t233 = load i8*, i8** %l16
  %s234 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.234, i32 0, i32 0
  %t235 = call i8* @strip_prefix(i8* %t233, i8* %s234)
  store i8* %t235, i8** %l17
  %t236 = load i8*, i8** %l17
  %s237 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.237, i32 0, i32 0
  %t238 = call i1 @starts_with(i8* %t236, i8* %s237)
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load i8*, i8** %l1
  %t241 = load i8*, i8** %l2
  %t242 = load i8*, i8** %l3
  %t243 = load double, double* %l4
  %t244 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t245 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t246 = load double, double* %l7
  %t247 = load double, double* %l8
  %t248 = load i8*, i8** %l9
  %t249 = load double, double* %l10
  %t250 = load double, double* %l11
  %t251 = load i1, i1* %l12
  %t252 = load i1, i1* %l13
  %t253 = load double, double* %l14
  %t254 = load i8*, i8** %l16
  %t255 = load i8*, i8** %l17
  br i1 %t238, label %then18, label %merge19
then18:
  %t256 = load i8*, i8** %l17
  %s257 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.257, i32 0, i32 0
  %t258 = call i8* @strip_prefix(i8* %t256, i8* %s257)
  %t259 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t258)
  store %EnumLayoutHeaderParse %t259, %EnumLayoutHeaderParse* %l18
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t261 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t262 = extractvalue %EnumLayoutHeaderParse %t261, 7
  %t263 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t260, { i8**, i64 }* %t262)
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  %t264 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t265 = extractvalue %EnumLayoutHeaderParse %t264, 0
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t267 = load i8*, i8** %l1
  %t268 = load i8*, i8** %l2
  %t269 = load i8*, i8** %l3
  %t270 = load double, double* %l4
  %t271 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t272 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t273 = load double, double* %l7
  %t274 = load double, double* %l8
  %t275 = load i8*, i8** %l9
  %t276 = load double, double* %l10
  %t277 = load double, double* %l11
  %t278 = load i1, i1* %l12
  %t279 = load i1, i1* %l13
  %t280 = load double, double* %l14
  %t281 = load i8*, i8** %l16
  %t282 = load i8*, i8** %l17
  %t283 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t265, label %then20, label %merge21
then20:
  %t284 = load i1, i1* %l12
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t286 = load i8*, i8** %l1
  %t287 = load i8*, i8** %l2
  %t288 = load i8*, i8** %l3
  %t289 = load double, double* %l4
  %t290 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t291 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t292 = load double, double* %l7
  %t293 = load double, double* %l8
  %t294 = load i8*, i8** %l9
  %t295 = load double, double* %l10
  %t296 = load double, double* %l11
  %t297 = load i1, i1* %l12
  %t298 = load i1, i1* %l13
  %t299 = load double, double* %l14
  %t300 = load i8*, i8** %l16
  %t301 = load i8*, i8** %l17
  %t302 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t284, label %then22, label %else23
then22:
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s304 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.304, i32 0, i32 0
  %t305 = load i8*, i8** %l3
  %t306 = add i8* %s304, %t305
  %t307 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t303, i8* %t306)
  store { i8**, i64 }* %t307, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t308 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t309 = extractvalue %EnumLayoutHeaderParse %t308, 2
  store double %t309, double* %l7
  %t310 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t311 = extractvalue %EnumLayoutHeaderParse %t310, 3
  store double %t311, double* %l8
  %t312 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t313 = extractvalue %EnumLayoutHeaderParse %t312, 4
  store i8* %t313, i8** %l9
  %t314 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t315 = extractvalue %EnumLayoutHeaderParse %t314, 5
  store double %t315, double* %l10
  %t316 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t317 = extractvalue %EnumLayoutHeaderParse %t316, 6
  store double %t317, double* %l11
  store i1 1, i1* %l12
  br label %merge24
merge24:
  %t318 = phi { i8**, i64 }* [ %t307, %then22 ], [ %t285, %else23 ]
  %t319 = phi double [ %t292, %then22 ], [ %t309, %else23 ]
  %t320 = phi double [ %t293, %then22 ], [ %t311, %else23 ]
  %t321 = phi i8* [ %t294, %then22 ], [ %t313, %else23 ]
  %t322 = phi double [ %t295, %then22 ], [ %t315, %else23 ]
  %t323 = phi double [ %t296, %then22 ], [ %t317, %else23 ]
  %t324 = phi i1 [ %t297, %then22 ], [ 1, %else23 ]
  store { i8**, i64 }* %t318, { i8**, i64 }** %l0
  store double %t319, double* %l7
  store double %t320, double* %l8
  store i8* %t321, i8** %l9
  store double %t322, double* %l10
  store double %t323, double* %l11
  store i1 %t324, i1* %l12
  br label %merge21
merge21:
  %t325 = phi { i8**, i64 }* [ %t307, %then20 ], [ %t266, %then18 ]
  %t326 = phi double [ %t309, %then20 ], [ %t273, %then18 ]
  %t327 = phi double [ %t311, %then20 ], [ %t274, %then18 ]
  %t328 = phi i8* [ %t313, %then20 ], [ %t275, %then18 ]
  %t329 = phi double [ %t315, %then20 ], [ %t276, %then18 ]
  %t330 = phi double [ %t317, %then20 ], [ %t277, %then18 ]
  %t331 = phi i1 [ 1, %then20 ], [ %t278, %then18 ]
  store { i8**, i64 }* %t325, { i8**, i64 }** %l0
  store double %t326, double* %l7
  store double %t327, double* %l8
  store i8* %t328, i8** %l9
  store double %t329, double* %l10
  store double %t330, double* %l11
  store i1 %t331, i1* %l12
  %t332 = load double, double* %l14
  %t333 = sitofp i64 1 to double
  %t334 = fadd double %t332, %t333
  store double %t334, double* %l14
  br label %loop.latch6
merge19:
  %t335 = load i8*, i8** %l17
  %s336 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.336, i32 0, i32 0
  %t337 = call i1 @starts_with(i8* %t335, i8* %s336)
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t339 = load i8*, i8** %l1
  %t340 = load i8*, i8** %l2
  %t341 = load i8*, i8** %l3
  %t342 = load double, double* %l4
  %t343 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t344 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t345 = load double, double* %l7
  %t346 = load double, double* %l8
  %t347 = load i8*, i8** %l9
  %t348 = load double, double* %l10
  %t349 = load double, double* %l11
  %t350 = load i1, i1* %l12
  %t351 = load i1, i1* %l13
  %t352 = load double, double* %l14
  %t353 = load i8*, i8** %l16
  %t354 = load i8*, i8** %l17
  br i1 %t337, label %then25, label %merge26
then25:
  %t355 = load i8*, i8** %l17
  %s356 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.356, i32 0, i32 0
  %t357 = call i8* @strip_prefix(i8* %t355, i8* %s356)
  %t358 = load i8*, i8** %l3
  %t359 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t357, i8* %t358)
  store %EnumLayoutVariantParse %t359, %EnumLayoutVariantParse* %l19
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t361 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t362 = extractvalue %EnumLayoutVariantParse %t361, 2
  %t363 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t360, { i8**, i64 }* %t362)
  store { i8**, i64 }* %t363, { i8**, i64 }** %l0
  %t364 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t365 = extractvalue %EnumLayoutVariantParse %t364, 0
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t367 = load i8*, i8** %l1
  %t368 = load i8*, i8** %l2
  %t369 = load i8*, i8** %l3
  %t370 = load double, double* %l4
  %t371 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t372 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t373 = load double, double* %l7
  %t374 = load double, double* %l8
  %t375 = load i8*, i8** %l9
  %t376 = load double, double* %l10
  %t377 = load double, double* %l11
  %t378 = load i1, i1* %l12
  %t379 = load i1, i1* %l13
  %t380 = load double, double* %l14
  %t381 = load i8*, i8** %l16
  %t382 = load i8*, i8** %l17
  %t383 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t365, label %then27, label %merge28
then27:
  %t384 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t385 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t386 = extractvalue %EnumLayoutVariantParse %t385, 1
  store double 0.0, double* %l20
  %t387 = load double, double* %l20
  %t388 = sitofp i64 0 to double
  %t389 = fcmp oge double %t387, %t388
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t391 = load i8*, i8** %l1
  %t392 = load i8*, i8** %l2
  %t393 = load i8*, i8** %l3
  %t394 = load double, double* %l4
  %t395 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t396 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t397 = load double, double* %l7
  %t398 = load double, double* %l8
  %t399 = load i8*, i8** %l9
  %t400 = load double, double* %l10
  %t401 = load double, double* %l11
  %t402 = load i1, i1* %l12
  %t403 = load i1, i1* %l13
  %t404 = load double, double* %l14
  %t405 = load i8*, i8** %l16
  %t406 = load i8*, i8** %l17
  %t407 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t408 = load double, double* %l20
  br i1 %t389, label %then29, label %else30
then29:
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s410 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.410, i32 0, i32 0
  %t411 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t412 = extractvalue %EnumLayoutVariantParse %t411, 1
  br label %merge31
else30:
  %t413 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t414 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t415 = extractvalue %EnumLayoutVariantParse %t414, 1
  %t416 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t413, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t416, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t417 = phi { i8**, i64 }* [ null, %then29 ], [ %t390, %else30 ]
  %t418 = phi { %NativeEnumVariantLayout*, i64 }* [ %t396, %then29 ], [ %t416, %else30 ]
  store { i8**, i64 }* %t417, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t418, { %NativeEnumVariantLayout*, i64 }** %l6
  %t419 = load i1, i1* %l12
  %t420 = xor i1 %t419, 1
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t422 = load i8*, i8** %l1
  %t423 = load i8*, i8** %l2
  %t424 = load i8*, i8** %l3
  %t425 = load double, double* %l4
  %t426 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t427 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t428 = load double, double* %l7
  %t429 = load double, double* %l8
  %t430 = load i8*, i8** %l9
  %t431 = load double, double* %l10
  %t432 = load double, double* %l11
  %t433 = load i1, i1* %l12
  %t434 = load i1, i1* %l13
  %t435 = load double, double* %l14
  %t436 = load i8*, i8** %l16
  %t437 = load i8*, i8** %l17
  %t438 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t439 = load double, double* %l20
  br i1 %t420, label %then32, label %merge33
then32:
  %t440 = load i1, i1* %l13
  %t441 = xor i1 %t440, 1
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t443 = load i8*, i8** %l1
  %t444 = load i8*, i8** %l2
  %t445 = load i8*, i8** %l3
  %t446 = load double, double* %l4
  %t447 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t448 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t449 = load double, double* %l7
  %t450 = load double, double* %l8
  %t451 = load i8*, i8** %l9
  %t452 = load double, double* %l10
  %t453 = load double, double* %l11
  %t454 = load i1, i1* %l12
  %t455 = load i1, i1* %l13
  %t456 = load double, double* %l14
  %t457 = load i8*, i8** %l16
  %t458 = load i8*, i8** %l17
  %t459 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t460 = load double, double* %l20
  br i1 %t441, label %then34, label %merge35
then34:
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s462 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.462, i32 0, i32 0
  %t463 = load i8*, i8** %l3
  %t464 = add i8* %s462, %t463
  %s465 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.465, i32 0, i32 0
  %t466 = add i8* %t464, %s465
  %t467 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t461, i8* %t466)
  store { i8**, i64 }* %t467, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge35
merge35:
  %t468 = phi { i8**, i64 }* [ %t467, %then34 ], [ %t442, %then32 ]
  %t469 = phi i1 [ 1, %then34 ], [ %t455, %then32 ]
  store { i8**, i64 }* %t468, { i8**, i64 }** %l0
  store i1 %t469, i1* %l13
  br label %merge33
merge33:
  %t470 = phi { i8**, i64 }* [ %t467, %then32 ], [ %t421, %then27 ]
  %t471 = phi i1 [ 1, %then32 ], [ %t434, %then27 ]
  store { i8**, i64 }* %t470, { i8**, i64 }** %l0
  store i1 %t471, i1* %l13
  br label %merge28
merge28:
  %t472 = phi { i8**, i64 }* [ null, %then27 ], [ %t366, %then25 ]
  %t473 = phi { %NativeEnumVariantLayout*, i64 }* [ %t416, %then27 ], [ %t372, %then25 ]
  %t474 = phi { i8**, i64 }* [ %t467, %then27 ], [ %t366, %then25 ]
  %t475 = phi i1 [ 1, %then27 ], [ %t379, %then25 ]
  store { i8**, i64 }* %t472, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t473, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t474, { i8**, i64 }** %l0
  store i1 %t475, i1* %l13
  %t476 = load double, double* %l14
  %t477 = sitofp i64 1 to double
  %t478 = fadd double %t476, %t477
  store double %t478, double* %l14
  br label %loop.latch6
merge26:
  %t479 = load i8*, i8** %l17
  %s480 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.480, i32 0, i32 0
  %t481 = call i1 @starts_with(i8* %t479, i8* %s480)
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t483 = load i8*, i8** %l1
  %t484 = load i8*, i8** %l2
  %t485 = load i8*, i8** %l3
  %t486 = load double, double* %l4
  %t487 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t488 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t489 = load double, double* %l7
  %t490 = load double, double* %l8
  %t491 = load i8*, i8** %l9
  %t492 = load double, double* %l10
  %t493 = load double, double* %l11
  %t494 = load i1, i1* %l12
  %t495 = load i1, i1* %l13
  %t496 = load double, double* %l14
  %t497 = load i8*, i8** %l16
  %t498 = load i8*, i8** %l17
  br i1 %t481, label %then36, label %merge37
then36:
  %t499 = load i8*, i8** %l17
  %s500 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.500, i32 0, i32 0
  %t501 = call i8* @strip_prefix(i8* %t499, i8* %s500)
  %t502 = load i8*, i8** %l3
  %t503 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t501, i8* %t502)
  store %EnumLayoutPayloadParse %t503, %EnumLayoutPayloadParse* %l21
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t505 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t506 = extractvalue %EnumLayoutPayloadParse %t505, 3
  %t507 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t504, { i8**, i64 }* %t506)
  store { i8**, i64 }* %t507, { i8**, i64 }** %l0
  %t508 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t509 = extractvalue %EnumLayoutPayloadParse %t508, 0
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t511 = load i8*, i8** %l1
  %t512 = load i8*, i8** %l2
  %t513 = load i8*, i8** %l3
  %t514 = load double, double* %l4
  %t515 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t516 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t517 = load double, double* %l7
  %t518 = load double, double* %l8
  %t519 = load i8*, i8** %l9
  %t520 = load double, double* %l10
  %t521 = load double, double* %l11
  %t522 = load i1, i1* %l12
  %t523 = load i1, i1* %l13
  %t524 = load double, double* %l14
  %t525 = load i8*, i8** %l16
  %t526 = load i8*, i8** %l17
  %t527 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t509, label %then38, label %merge39
then38:
  %t528 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t529 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t530 = extractvalue %EnumLayoutPayloadParse %t529, 1
  %t531 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t528, i8* %t530)
  store double %t531, double* %l22
  %t532 = load double, double* %l22
  %t533 = sitofp i64 0 to double
  %t534 = fcmp olt double %t532, %t533
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t536 = load i8*, i8** %l1
  %t537 = load i8*, i8** %l2
  %t538 = load i8*, i8** %l3
  %t539 = load double, double* %l4
  %t540 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t541 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t542 = load double, double* %l7
  %t543 = load double, double* %l8
  %t544 = load i8*, i8** %l9
  %t545 = load double, double* %l10
  %t546 = load double, double* %l11
  %t547 = load i1, i1* %l12
  %t548 = load i1, i1* %l13
  %t549 = load double, double* %l14
  %t550 = load i8*, i8** %l16
  %t551 = load i8*, i8** %l17
  %t552 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t553 = load double, double* %l22
  br i1 %t534, label %then40, label %else41
then40:
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s555 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.555, i32 0, i32 0
  %t556 = load i8*, i8** %l3
  %t557 = add i8* %s555, %t556
  %s558 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.558, i32 0, i32 0
  %t559 = add i8* %t557, %s558
  %t560 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t561 = extractvalue %EnumLayoutPayloadParse %t560, 1
  %t562 = add i8* %t559, %t561
  %t563 = getelementptr i8, i8* %t562, i64 0
  %t564 = load i8, i8* %t563
  %t565 = add i8 %t564, 96
  %t566 = alloca [2 x i8], align 1
  %t567 = getelementptr [2 x i8], [2 x i8]* %t566, i32 0, i32 0
  store i8 %t565, i8* %t567
  %t568 = getelementptr [2 x i8], [2 x i8]* %t566, i32 0, i32 1
  store i8 0, i8* %t568
  %t569 = getelementptr [2 x i8], [2 x i8]* %t566, i32 0, i32 0
  %t570 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t554, i8* %t569)
  store { i8**, i64 }* %t570, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t571 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t572 = load double, double* %l22
  %t573 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t574 = extractvalue %EnumLayoutPayloadParse %t573, 2
  %t575 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t571, double %t572, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t575, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t576 = phi { i8**, i64 }* [ %t570, %then40 ], [ %t535, %else41 ]
  %t577 = phi { %NativeEnumVariantLayout*, i64 }* [ %t541, %then40 ], [ %t575, %else41 ]
  store { i8**, i64 }* %t576, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t577, { %NativeEnumVariantLayout*, i64 }** %l6
  %t578 = load i1, i1* %l12
  %t579 = xor i1 %t578, 1
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t581 = load i8*, i8** %l1
  %t582 = load i8*, i8** %l2
  %t583 = load i8*, i8** %l3
  %t584 = load double, double* %l4
  %t585 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t586 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t587 = load double, double* %l7
  %t588 = load double, double* %l8
  %t589 = load i8*, i8** %l9
  %t590 = load double, double* %l10
  %t591 = load double, double* %l11
  %t592 = load i1, i1* %l12
  %t593 = load i1, i1* %l13
  %t594 = load double, double* %l14
  %t595 = load i8*, i8** %l16
  %t596 = load i8*, i8** %l17
  %t597 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t598 = load double, double* %l22
  br i1 %t579, label %then43, label %merge44
then43:
  %t599 = load i1, i1* %l13
  %t600 = xor i1 %t599, 1
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t602 = load i8*, i8** %l1
  %t603 = load i8*, i8** %l2
  %t604 = load i8*, i8** %l3
  %t605 = load double, double* %l4
  %t606 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t607 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t608 = load double, double* %l7
  %t609 = load double, double* %l8
  %t610 = load i8*, i8** %l9
  %t611 = load double, double* %l10
  %t612 = load double, double* %l11
  %t613 = load i1, i1* %l12
  %t614 = load i1, i1* %l13
  %t615 = load double, double* %l14
  %t616 = load i8*, i8** %l16
  %t617 = load i8*, i8** %l17
  %t618 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t619 = load double, double* %l22
  br i1 %t600, label %then45, label %merge46
then45:
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s621 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.621, i32 0, i32 0
  %t622 = load i8*, i8** %l3
  %t623 = add i8* %s621, %t622
  %s624 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.624, i32 0, i32 0
  %t625 = add i8* %t623, %s624
  %t626 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t620, i8* %t625)
  store { i8**, i64 }* %t626, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge46
merge46:
  %t627 = phi { i8**, i64 }* [ %t626, %then45 ], [ %t601, %then43 ]
  %t628 = phi i1 [ 1, %then45 ], [ %t614, %then43 ]
  store { i8**, i64 }* %t627, { i8**, i64 }** %l0
  store i1 %t628, i1* %l13
  br label %merge44
merge44:
  %t629 = phi { i8**, i64 }* [ %t626, %then43 ], [ %t580, %then38 ]
  %t630 = phi i1 [ 1, %then43 ], [ %t593, %then38 ]
  store { i8**, i64 }* %t629, { i8**, i64 }** %l0
  store i1 %t630, i1* %l13
  br label %merge39
merge39:
  %t631 = phi { i8**, i64 }* [ %t570, %then38 ], [ %t510, %then36 ]
  %t632 = phi { %NativeEnumVariantLayout*, i64 }* [ %t575, %then38 ], [ %t516, %then36 ]
  %t633 = phi { i8**, i64 }* [ %t626, %then38 ], [ %t510, %then36 ]
  %t634 = phi i1 [ 1, %then38 ], [ %t523, %then36 ]
  store { i8**, i64 }* %t631, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t632, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t633, { i8**, i64 }** %l0
  store i1 %t634, i1* %l13
  %t635 = load double, double* %l14
  %t636 = sitofp i64 1 to double
  %t637 = fadd double %t635, %t636
  store double %t637, double* %l14
  br label %loop.latch6
merge37:
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s639 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.639, i32 0, i32 0
  %t640 = load i8*, i8** %l16
  %t641 = add i8* %s639, %t640
  %t642 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t638, i8* %t641)
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  %t643 = load double, double* %l14
  %t644 = sitofp i64 1 to double
  %t645 = fadd double %t643, %t644
  store double %t645, double* %l14
  br label %loop.latch6
merge17:
  %t646 = load i8*, i8** %l16
  %s647 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.647, i32 0, i32 0
  %t648 = icmp eq i8* %t646, %s647
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t650 = load i8*, i8** %l1
  %t651 = load i8*, i8** %l2
  %t652 = load i8*, i8** %l3
  %t653 = load double, double* %l4
  %t654 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t655 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t656 = load double, double* %l7
  %t657 = load double, double* %l8
  %t658 = load i8*, i8** %l9
  %t659 = load double, double* %l10
  %t660 = load double, double* %l11
  %t661 = load i1, i1* %l12
  %t662 = load i1, i1* %l13
  %t663 = load double, double* %l14
  %t664 = load i8*, i8** %l16
  br i1 %t648, label %then47, label %merge48
then47:
  %t665 = load double, double* %l14
  %t666 = sitofp i64 1 to double
  %t667 = fadd double %t665, %t666
  store double %t667, double* %l14
  br label %afterloop7
merge48:
  %t668 = load i8*, i8** %l16
  %s669 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.669, i32 0, i32 0
  %t670 = call i1 @starts_with(i8* %t668, i8* %s669)
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t672 = load i8*, i8** %l1
  %t673 = load i8*, i8** %l2
  %t674 = load i8*, i8** %l3
  %t675 = load double, double* %l4
  %t676 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t677 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t678 = load double, double* %l7
  %t679 = load double, double* %l8
  %t680 = load i8*, i8** %l9
  %t681 = load double, double* %l10
  %t682 = load double, double* %l11
  %t683 = load i1, i1* %l12
  %t684 = load i1, i1* %l13
  %t685 = load double, double* %l14
  %t686 = load i8*, i8** %l16
  br i1 %t670, label %then49, label %merge50
then49:
  %t687 = load i8*, i8** %l16
  %s688 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.688, i32 0, i32 0
  %t689 = call i8* @strip_prefix(i8* %t687, i8* %s688)
  %t690 = call double @parse_enum_variant_line(i8* %t689)
  store double %t690, double* %l23
  %t691 = load double, double* %l23
  %t692 = load double, double* %l14
  %t693 = sitofp i64 1 to double
  %t694 = fadd double %t692, %t693
  store double %t694, double* %l14
  br label %loop.latch6
merge50:
  %t695 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s696 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.696, i32 0, i32 0
  %t697 = load i8*, i8** %l16
  %t698 = add i8* %s696, %t697
  %t699 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t695, i8* %t698)
  store { i8**, i64 }* %t699, { i8**, i64 }** %l0
  %t700 = load double, double* %l14
  %t701 = sitofp i64 1 to double
  %t702 = fadd double %t700, %t701
  store double %t702, double* %l14
  br label %loop.latch6
loop.latch6:
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t704 = load double, double* %l14
  %t705 = load double, double* %l7
  %t706 = load double, double* %l8
  %t707 = load i8*, i8** %l9
  %t708 = load double, double* %l10
  %t709 = load double, double* %l11
  %t710 = load i1, i1* %l12
  %t711 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t712 = load i1, i1* %l13
  br label %loop.header4
afterloop7:
  store i8* null, i8** %l24
  %t723 = load i1, i1* %l12
  %t724 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t725 = load i8*, i8** %l1
  %t726 = load i8*, i8** %l2
  %t727 = load i8*, i8** %l3
  %t728 = load double, double* %l4
  %t729 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t730 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t731 = load double, double* %l7
  %t732 = load double, double* %l8
  %t733 = load i8*, i8** %l9
  %t734 = load double, double* %l10
  %t735 = load double, double* %l11
  %t736 = load i1, i1* %l12
  %t737 = load i1, i1* %l13
  %t738 = load double, double* %l14
  %t739 = load i8*, i8** %l24
  br i1 %t723, label %then51, label %merge52
then51:
  %t740 = load double, double* %l7
  %t741 = insertvalue %NativeEnumLayout undef, double %t740, 0
  %t742 = load double, double* %l8
  %t743 = insertvalue %NativeEnumLayout %t741, double %t742, 1
  %t744 = load i8*, i8** %l9
  %t745 = insertvalue %NativeEnumLayout %t743, i8* %t744, 2
  %t746 = load double, double* %l10
  %t747 = insertvalue %NativeEnumLayout %t745, double %t746, 3
  %t748 = load double, double* %l11
  %t749 = insertvalue %NativeEnumLayout %t747, double %t748, 4
  %t750 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t751 = bitcast { %NativeEnumVariantLayout*, i64 }* %t750 to { i8**, i64 }*
  %t752 = insertvalue %NativeEnumLayout %t749, { i8**, i64 }* %t751, 5
  store i8* null, i8** %l24
  br label %merge52
merge52:
  %t753 = phi i8* [ null, %then51 ], [ %t739, %entry ]
  store i8* %t753, i8** %l24
  %t754 = load i8*, i8** %l3
  %t755 = insertvalue %NativeEnum undef, i8* %t754, 0
  %t756 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t757 = bitcast { %NativeEnumVariant*, i64 }* %t756 to { i8**, i64 }*
  %t758 = insertvalue %NativeEnum %t755, { i8**, i64 }* %t757, 1
  %t759 = load i8*, i8** %l24
  %t760 = insertvalue %NativeEnum %t758, i8* %t759, 2
  %t761 = insertvalue %EnumParseResult undef, i8* null, 0
  %t762 = load double, double* %l14
  %t763 = insertvalue %EnumParseResult %t761, double %t762, 1
  %t764 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t765 = insertvalue %EnumParseResult %t763, { i8**, i64 }* %t764, 2
  ret %EnumParseResult %t765
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
  %t79 = phi double [ %t10, %entry ], [ %t75, %loop.latch2 ]
  %t80 = phi { i8**, i64 }* [ %t8, %entry ], [ %t76, %loop.latch2 ]
  %t81 = phi i8* [ %t9, %entry ], [ %t77, %loop.latch2 ]
  %t82 = phi double [ %t11, %entry ], [ %t78, %loop.latch2 ]
  store double %t79, double* %l2
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  store i8* %t81, i8** %l1
  store double %t82, double* %l3
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
  %t66 = alloca [2 x i8], align 1
  %t67 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8 %t65, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 1
  store i8 0, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8* %t69, i8** %l1
  br label %merge11
merge11:
  %t70 = phi { i8**, i64 }* [ %t59, %then9 ], [ %t52, %else10 ]
  %t71 = phi i8* [ %s60, %then9 ], [ %t69, %else10 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  store i8* %t71, i8** %l1
  %t72 = load double, double* %l3
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l3
  br label %loop.latch2
loop.latch2:
  %t75 = load double, double* %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load i8*, i8** %l1
  %t78 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t83 = load i8*, i8** %l1
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = icmp sgt i64 %t84, 0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  br i1 %t85, label %then12, label %merge13
then12:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t90, i8* %t91)
  store { i8**, i64 }* %t92, { i8**, i64 }** %l0
  br label %merge13
merge13:
  %t93 = phi { i8**, i64 }* [ %t92, %then12 ], [ %t86, %entry ]
  store { i8**, i64 }* %t93, { i8**, i64 }** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t94
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
  %t217 = phi i8* [ %t34, %entry ], [ %t209, %loop.latch4 ]
  %t218 = phi i1 [ %t31, %entry ], [ %t210, %loop.latch4 ]
  %t219 = phi i1 [ %t32, %entry ], [ %t211, %loop.latch4 ]
  %t220 = phi double [ %t35, %entry ], [ %t212, %loop.latch4 ]
  %t221 = phi { i8**, i64 }* [ %t30, %entry ], [ %t213, %loop.latch4 ]
  %t222 = phi i1 [ %t33, %entry ], [ %t214, %loop.latch4 ]
  %t223 = phi double [ %t36, %entry ], [ %t215, %loop.latch4 ]
  %t224 = phi double [ %t37, %entry ], [ %t216, %loop.latch4 ]
  store i8* %t217, i8** %l5
  store i1 %t218, i1* %l2
  store i1 %t219, i1* %l3
  store double %t220, double* %l6
  store { i8**, i64 }* %t221, { i8**, i64 }** %l1
  store i1 %t222, i1* %l4
  store double %t223, double* %l7
  store double %t224, double* %l8
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
  %t121 = alloca [2 x i8], align 1
  %t122 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8 %t120, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 1
  store i8 0, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  %t125 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t114, i8* %t124)
  store { i8**, i64 }* %t125, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t126 = phi i1 [ 1, %then14 ], [ %t103, %else15 ]
  %t127 = phi double [ %t113, %then14 ], [ %t106, %else15 ]
  %t128 = phi { i8**, i64 }* [ %t101, %then14 ], [ %t125, %else15 ]
  store i1 %t126, i1* %l3
  store double %t127, double* %l6
  store { i8**, i64 }* %t128, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t129 = load i8*, i8** %l9
  %s130 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.130, i32 0, i32 0
  %t131 = call i1 @starts_with(i8* %t129, i8* %s130)
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load i1, i1* %l2
  %t135 = load i1, i1* %l3
  %t136 = load i1, i1* %l4
  %t137 = load i8*, i8** %l5
  %t138 = load double, double* %l6
  %t139 = load double, double* %l7
  %t140 = load double, double* %l8
  %t141 = load i8*, i8** %l9
  br i1 %t131, label %then17, label %else18
then17:
  %t142 = load i8*, i8** %l9
  %t143 = load i8*, i8** %l9
  %t144 = call i64 @sailfin_runtime_string_length(i8* %t143)
  %t145 = call i8* @sailfin_runtime_substring(i8* %t142, i64 6, i64 %t144)
  store i8* %t145, i8** %l12
  %t146 = load i8*, i8** %l12
  %t147 = call %NumberParseResult @parse_decimal_number(i8* %t146)
  store %NumberParseResult %t147, %NumberParseResult* %l13
  %t148 = load %NumberParseResult, %NumberParseResult* %l13
  %t149 = extractvalue %NumberParseResult %t148, 0
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load i1, i1* %l2
  %t153 = load i1, i1* %l3
  %t154 = load i1, i1* %l4
  %t155 = load i8*, i8** %l5
  %t156 = load double, double* %l6
  %t157 = load double, double* %l7
  %t158 = load double, double* %l8
  %t159 = load i8*, i8** %l9
  %t160 = load i8*, i8** %l12
  %t161 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t149, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t162 = load %NumberParseResult, %NumberParseResult* %l13
  %t163 = extractvalue %NumberParseResult %t162, 1
  store double %t163, double* %l7
  br label %merge22
else21:
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s165 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.165, i32 0, i32 0
  %t166 = load i8*, i8** %l12
  %t167 = add i8* %s165, %t166
  %t168 = getelementptr i8, i8* %t167, i64 0
  %t169 = load i8, i8* %t168
  %t170 = add i8 %t169, 96
  %t171 = alloca [2 x i8], align 1
  %t172 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 0
  store i8 %t170, i8* %t172
  %t173 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 1
  store i8 0, i8* %t173
  %t174 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 0
  %t175 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t164, i8* %t174)
  store { i8**, i64 }* %t175, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t176 = phi i1 [ 1, %then20 ], [ %t154, %else21 ]
  %t177 = phi double [ %t163, %then20 ], [ %t157, %else21 ]
  %t178 = phi { i8**, i64 }* [ %t151, %then20 ], [ %t175, %else21 ]
  store i1 %t176, i1* %l4
  store double %t177, double* %l7
  store { i8**, i64 }* %t178, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s180 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.180, i32 0, i32 0
  %t181 = load i8*, i8** %l9
  %t182 = add i8* %s180, %t181
  %t183 = getelementptr i8, i8* %t182, i64 0
  %t184 = load i8, i8* %t183
  %t185 = add i8 %t184, 96
  %t186 = alloca [2 x i8], align 1
  %t187 = getelementptr [2 x i8], [2 x i8]* %t186, i32 0, i32 0
  store i8 %t185, i8* %t187
  %t188 = getelementptr [2 x i8], [2 x i8]* %t186, i32 0, i32 1
  store i8 0, i8* %t188
  %t189 = getelementptr [2 x i8], [2 x i8]* %t186, i32 0, i32 0
  %t190 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t179, i8* %t189)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t191 = phi i1 [ 1, %then17 ], [ %t136, %else18 ]
  %t192 = phi double [ %t163, %then17 ], [ %t139, %else18 ]
  %t193 = phi { i8**, i64 }* [ %t175, %then17 ], [ %t190, %else18 ]
  store i1 %t191, i1* %l4
  store double %t192, double* %l7
  store { i8**, i64 }* %t193, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t194 = phi i1 [ 1, %then11 ], [ %t85, %else12 ]
  %t195 = phi double [ %t113, %then11 ], [ %t88, %else12 ]
  %t196 = phi { i8**, i64 }* [ %t125, %then11 ], [ %t175, %else12 ]
  %t197 = phi i1 [ %t86, %then11 ], [ 1, %else12 ]
  %t198 = phi double [ %t89, %then11 ], [ %t163, %else12 ]
  store i1 %t194, i1* %l3
  store double %t195, double* %l6
  store { i8**, i64 }* %t196, { i8**, i64 }** %l1
  store i1 %t197, i1* %l4
  store double %t198, double* %l7
  br label %merge10
merge10:
  %t199 = phi i8* [ %t78, %then8 ], [ %t70, %else9 ]
  %t200 = phi i1 [ 1, %then8 ], [ %t67, %else9 ]
  %t201 = phi i1 [ %t68, %then8 ], [ 1, %else9 ]
  %t202 = phi double [ %t71, %then8 ], [ %t113, %else9 ]
  %t203 = phi { i8**, i64 }* [ %t66, %then8 ], [ %t125, %else9 ]
  %t204 = phi i1 [ %t69, %then8 ], [ 1, %else9 ]
  %t205 = phi double [ %t72, %then8 ], [ %t163, %else9 ]
  store i8* %t199, i8** %l5
  store i1 %t200, i1* %l2
  store i1 %t201, i1* %l3
  store double %t202, double* %l6
  store { i8**, i64 }* %t203, { i8**, i64 }** %l1
  store i1 %t204, i1* %l4
  store double %t205, double* %l7
  %t206 = load double, double* %l8
  %t207 = sitofp i64 1 to double
  %t208 = fadd double %t206, %t207
  store double %t208, double* %l8
  br label %loop.latch4
loop.latch4:
  %t209 = load i8*, i8** %l5
  %t210 = load i1, i1* %l2
  %t211 = load i1, i1* %l3
  %t212 = load double, double* %l6
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t214 = load i1, i1* %l4
  %t215 = load double, double* %l7
  %t216 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t225 = load i1, i1* %l3
  %t226 = xor i1 %t225, 1
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load i1, i1* %l2
  %t230 = load i1, i1* %l3
  %t231 = load i1, i1* %l4
  %t232 = load i8*, i8** %l5
  %t233 = load double, double* %l6
  %t234 = load double, double* %l7
  %t235 = load double, double* %l8
  br i1 %t226, label %then23, label %merge24
then23:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s237 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.237, i32 0, i32 0
  %t238 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t236, i8* %s237)
  store { i8**, i64 }* %t238, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t239 = phi { i8**, i64 }* [ %t238, %then23 ], [ %t228, %entry ]
  store { i8**, i64 }* %t239, { i8**, i64 }** %l1
  %t240 = load i1, i1* %l4
  %t241 = xor i1 %t240, 1
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load i1, i1* %l2
  %t245 = load i1, i1* %l3
  %t246 = load i1, i1* %l4
  %t247 = load i8*, i8** %l5
  %t248 = load double, double* %l6
  %t249 = load double, double* %l7
  %t250 = load double, double* %l8
  br i1 %t241, label %then25, label %merge26
then25:
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s252 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.252, i32 0, i32 0
  %t253 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t251, i8* %s252)
  store { i8**, i64 }* %t253, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t254 = phi { i8**, i64 }* [ %t253, %then25 ], [ %t243, %entry ]
  store { i8**, i64 }* %t254, { i8**, i64 }** %l1
  %t257 = load i1, i1* %l3
  br label %logical_and_entry_256

logical_and_entry_256:
  br i1 %t257, label %logical_and_right_256, label %logical_and_merge_256

logical_and_right_256:
  %t258 = load i1, i1* %l4
  br label %logical_and_right_end_256

logical_and_right_end_256:
  br label %logical_and_merge_256

logical_and_merge_256:
  %t259 = phi i1 [ false, %logical_and_entry_256 ], [ %t258, %logical_and_right_end_256 ]
  br label %logical_and_entry_255

logical_and_entry_255:
  br i1 %t259, label %logical_and_right_255, label %logical_and_merge_255

logical_and_right_255:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t261 = load { i8**, i64 }, { i8**, i64 }* %t260
  %t262 = extractvalue { i8**, i64 } %t261, 1
  %t263 = icmp eq i64 %t262, 0
  br label %logical_and_right_end_255

logical_and_right_end_255:
  br label %logical_and_merge_255

logical_and_merge_255:
  %t264 = phi i1 [ false, %logical_and_entry_255 ], [ %t263, %logical_and_right_end_255 ]
  store i1 %t264, i1* %l14
  %t265 = load i1, i1* %l14
  %t266 = insertvalue %StructLayoutHeaderParse undef, i1 %t265, 0
  %t267 = load i8*, i8** %l5
  %t268 = insertvalue %StructLayoutHeaderParse %t266, i8* %t267, 1
  %t269 = load double, double* %l6
  %t270 = insertvalue %StructLayoutHeaderParse %t268, double %t269, 2
  %t271 = load double, double* %l7
  %t272 = insertvalue %StructLayoutHeaderParse %t270, double %t271, 3
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = insertvalue %StructLayoutHeaderParse %t272, { i8**, i64 }* %t273, 4
  ret %StructLayoutHeaderParse %t274
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
  %t396 = phi i8* [ %t90, %entry ], [ %t387, %loop.latch8 ]
  %t397 = phi i1 [ %t91, %entry ], [ %t388, %loop.latch8 ]
  %t398 = phi double [ %t94, %entry ], [ %t389, %loop.latch8 ]
  %t399 = phi { i8**, i64 }* [ %t86, %entry ], [ %t390, %loop.latch8 ]
  %t400 = phi i1 [ %t92, %entry ], [ %t391, %loop.latch8 ]
  %t401 = phi double [ %t95, %entry ], [ %t392, %loop.latch8 ]
  %t402 = phi i1 [ %t93, %entry ], [ %t393, %loop.latch8 ]
  %t403 = phi double [ %t96, %entry ], [ %t394, %loop.latch8 ]
  %t404 = phi double [ %t97, %entry ], [ %t395, %loop.latch8 ]
  store i8* %t396, i8** %l5
  store i1 %t397, i1* %l6
  store double %t398, double* %l9
  store { i8**, i64 }* %t399, { i8**, i64 }** %l1
  store i1 %t400, i1* %l7
  store double %t401, double* %l10
  store i1 %t402, i1* %l8
  store double %t403, double* %l11
  store double %t404, double* %l12
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
  %t204 = alloca [2 x i8], align 1
  %t205 = getelementptr [2 x i8], [2 x i8]* %t204, i32 0, i32 0
  store i8 %t203, i8* %t205
  %t206 = getelementptr [2 x i8], [2 x i8]* %t204, i32 0, i32 1
  store i8 0, i8* %t206
  %t207 = getelementptr [2 x i8], [2 x i8]* %t204, i32 0, i32 0
  %t208 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* %t207)
  store { i8**, i64 }* %t208, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t209 = phi i1 [ 1, %then18 ], [ %t178, %else19 ]
  %t210 = phi double [ %t189, %then18 ], [ %t181, %else19 ]
  %t211 = phi { i8**, i64 }* [ %t173, %then18 ], [ %t208, %else19 ]
  store i1 %t209, i1* %l6
  store double %t210, double* %l9
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t212 = load i8*, i8** %l13
  %s213 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.213, i32 0, i32 0
  %t214 = call i1 @starts_with(i8* %t212, i8* %s213)
  %t215 = load i8*, i8** %l0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t219 = load i8*, i8** %l4
  %t220 = load i8*, i8** %l5
  %t221 = load i1, i1* %l6
  %t222 = load i1, i1* %l7
  %t223 = load i1, i1* %l8
  %t224 = load double, double* %l9
  %t225 = load double, double* %l10
  %t226 = load double, double* %l11
  %t227 = load double, double* %l12
  %t228 = load i8*, i8** %l13
  br i1 %t214, label %then21, label %else22
then21:
  %t229 = load i8*, i8** %l13
  %t230 = load i8*, i8** %l13
  %t231 = call i64 @sailfin_runtime_string_length(i8* %t230)
  %t232 = call i8* @sailfin_runtime_substring(i8* %t229, i64 5, i64 %t231)
  store i8* %t232, i8** %l16
  %t233 = load i8*, i8** %l16
  %t234 = call %NumberParseResult @parse_decimal_number(i8* %t233)
  store %NumberParseResult %t234, %NumberParseResult* %l17
  %t235 = load %NumberParseResult, %NumberParseResult* %l17
  %t236 = extractvalue %NumberParseResult %t235, 0
  %t237 = load i8*, i8** %l0
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t239 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t241 = load i8*, i8** %l4
  %t242 = load i8*, i8** %l5
  %t243 = load i1, i1* %l6
  %t244 = load i1, i1* %l7
  %t245 = load i1, i1* %l8
  %t246 = load double, double* %l9
  %t247 = load double, double* %l10
  %t248 = load double, double* %l11
  %t249 = load double, double* %l12
  %t250 = load i8*, i8** %l13
  %t251 = load i8*, i8** %l16
  %t252 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t236, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t253 = load %NumberParseResult, %NumberParseResult* %l17
  %t254 = extractvalue %NumberParseResult %t253, 1
  store double %t254, double* %l10
  br label %merge26
else25:
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s256 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.256, i32 0, i32 0
  %t257 = add i8* %s256, %struct_name
  %s258 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.258, i32 0, i32 0
  %t259 = add i8* %t257, %s258
  %t260 = load i8*, i8** %l4
  %t261 = add i8* %t259, %t260
  %s262 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.262, i32 0, i32 0
  %t263 = add i8* %t261, %s262
  %t264 = load i8*, i8** %l16
  %t265 = add i8* %t263, %t264
  %t266 = getelementptr i8, i8* %t265, i64 0
  %t267 = load i8, i8* %t266
  %t268 = add i8 %t267, 96
  %t269 = alloca [2 x i8], align 1
  %t270 = getelementptr [2 x i8], [2 x i8]* %t269, i32 0, i32 0
  store i8 %t268, i8* %t270
  %t271 = getelementptr [2 x i8], [2 x i8]* %t269, i32 0, i32 1
  store i8 0, i8* %t271
  %t272 = getelementptr [2 x i8], [2 x i8]* %t269, i32 0, i32 0
  %t273 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t255, i8* %t272)
  store { i8**, i64 }* %t273, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t274 = phi i1 [ 1, %then24 ], [ %t244, %else25 ]
  %t275 = phi double [ %t254, %then24 ], [ %t247, %else25 ]
  %t276 = phi { i8**, i64 }* [ %t238, %then24 ], [ %t273, %else25 ]
  store i1 %t274, i1* %l7
  store double %t275, double* %l10
  store { i8**, i64 }* %t276, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t277 = load i8*, i8** %l13
  %s278 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.278, i32 0, i32 0
  %t279 = call i1 @starts_with(i8* %t277, i8* %s278)
  %t280 = load i8*, i8** %l0
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t282 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t284 = load i8*, i8** %l4
  %t285 = load i8*, i8** %l5
  %t286 = load i1, i1* %l6
  %t287 = load i1, i1* %l7
  %t288 = load i1, i1* %l8
  %t289 = load double, double* %l9
  %t290 = load double, double* %l10
  %t291 = load double, double* %l11
  %t292 = load double, double* %l12
  %t293 = load i8*, i8** %l13
  br i1 %t279, label %then27, label %else28
then27:
  %t294 = load i8*, i8** %l13
  %t295 = load i8*, i8** %l13
  %t296 = call i64 @sailfin_runtime_string_length(i8* %t295)
  %t297 = call i8* @sailfin_runtime_substring(i8* %t294, i64 6, i64 %t296)
  store i8* %t297, i8** %l18
  %t298 = load i8*, i8** %l18
  %t299 = call %NumberParseResult @parse_decimal_number(i8* %t298)
  store %NumberParseResult %t299, %NumberParseResult* %l19
  %t300 = load %NumberParseResult, %NumberParseResult* %l19
  %t301 = extractvalue %NumberParseResult %t300, 0
  %t302 = load i8*, i8** %l0
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t304 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t306 = load i8*, i8** %l4
  %t307 = load i8*, i8** %l5
  %t308 = load i1, i1* %l6
  %t309 = load i1, i1* %l7
  %t310 = load i1, i1* %l8
  %t311 = load double, double* %l9
  %t312 = load double, double* %l10
  %t313 = load double, double* %l11
  %t314 = load double, double* %l12
  %t315 = load i8*, i8** %l13
  %t316 = load i8*, i8** %l18
  %t317 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t301, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t318 = load %NumberParseResult, %NumberParseResult* %l19
  %t319 = extractvalue %NumberParseResult %t318, 1
  store double %t319, double* %l11
  br label %merge32
else31:
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s321 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.321, i32 0, i32 0
  %t322 = add i8* %s321, %struct_name
  %s323 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.323, i32 0, i32 0
  %t324 = add i8* %t322, %s323
  %t325 = load i8*, i8** %l4
  %t326 = add i8* %t324, %t325
  %s327 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.327, i32 0, i32 0
  %t328 = add i8* %t326, %s327
  %t329 = load i8*, i8** %l18
  %t330 = add i8* %t328, %t329
  %t331 = getelementptr i8, i8* %t330, i64 0
  %t332 = load i8, i8* %t331
  %t333 = add i8 %t332, 96
  %t334 = alloca [2 x i8], align 1
  %t335 = getelementptr [2 x i8], [2 x i8]* %t334, i32 0, i32 0
  store i8 %t333, i8* %t335
  %t336 = getelementptr [2 x i8], [2 x i8]* %t334, i32 0, i32 1
  store i8 0, i8* %t336
  %t337 = getelementptr [2 x i8], [2 x i8]* %t334, i32 0, i32 0
  %t338 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t320, i8* %t337)
  store { i8**, i64 }* %t338, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t339 = phi i1 [ 1, %then30 ], [ %t310, %else31 ]
  %t340 = phi double [ %t319, %then30 ], [ %t313, %else31 ]
  %t341 = phi { i8**, i64 }* [ %t303, %then30 ], [ %t338, %else31 ]
  store i1 %t339, i1* %l8
  store double %t340, double* %l11
  store { i8**, i64 }* %t341, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s343 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.343, i32 0, i32 0
  %t344 = add i8* %s343, %struct_name
  %s345 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.345, i32 0, i32 0
  %t346 = add i8* %t344, %s345
  %t347 = load i8*, i8** %l4
  %t348 = add i8* %t346, %t347
  %s349 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.349, i32 0, i32 0
  %t350 = add i8* %t348, %s349
  %t351 = load i8*, i8** %l13
  %t352 = add i8* %t350, %t351
  %t353 = getelementptr i8, i8* %t352, i64 0
  %t354 = load i8, i8* %t353
  %t355 = add i8 %t354, 96
  %t356 = alloca [2 x i8], align 1
  %t357 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 0
  store i8 %t355, i8* %t357
  %t358 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 1
  store i8 0, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 0
  %t360 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t342, i8* %t359)
  store { i8**, i64 }* %t360, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t361 = phi i1 [ 1, %then27 ], [ %t288, %else28 ]
  %t362 = phi double [ %t319, %then27 ], [ %t291, %else28 ]
  %t363 = phi { i8**, i64 }* [ %t338, %then27 ], [ %t360, %else28 ]
  store i1 %t361, i1* %l8
  store double %t362, double* %l11
  store { i8**, i64 }* %t363, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t364 = phi i1 [ 1, %then21 ], [ %t222, %else22 ]
  %t365 = phi double [ %t254, %then21 ], [ %t225, %else22 ]
  %t366 = phi { i8**, i64 }* [ %t273, %then21 ], [ %t338, %else22 ]
  %t367 = phi i1 [ %t223, %then21 ], [ 1, %else22 ]
  %t368 = phi double [ %t226, %then21 ], [ %t319, %else22 ]
  store i1 %t364, i1* %l7
  store double %t365, double* %l10
  store { i8**, i64 }* %t366, { i8**, i64 }** %l1
  store i1 %t367, i1* %l8
  store double %t368, double* %l11
  br label %merge17
merge17:
  %t369 = phi i1 [ 1, %then15 ], [ %t156, %else16 ]
  %t370 = phi double [ %t189, %then15 ], [ %t159, %else16 ]
  %t371 = phi { i8**, i64 }* [ %t208, %then15 ], [ %t273, %else16 ]
  %t372 = phi i1 [ %t157, %then15 ], [ 1, %else16 ]
  %t373 = phi double [ %t160, %then15 ], [ %t254, %else16 ]
  %t374 = phi i1 [ %t158, %then15 ], [ 1, %else16 ]
  %t375 = phi double [ %t161, %then15 ], [ %t319, %else16 ]
  store i1 %t369, i1* %l6
  store double %t370, double* %l9
  store { i8**, i64 }* %t371, { i8**, i64 }** %l1
  store i1 %t372, i1* %l7
  store double %t373, double* %l10
  store i1 %t374, i1* %l8
  store double %t375, double* %l11
  br label %merge14
merge14:
  %t376 = phi i8* [ %t146, %then12 ], [ %t134, %else13 ]
  %t377 = phi i1 [ %t135, %then12 ], [ 1, %else13 ]
  %t378 = phi double [ %t138, %then12 ], [ %t189, %else13 ]
  %t379 = phi { i8**, i64 }* [ %t130, %then12 ], [ %t208, %else13 ]
  %t380 = phi i1 [ %t136, %then12 ], [ 1, %else13 ]
  %t381 = phi double [ %t139, %then12 ], [ %t254, %else13 ]
  %t382 = phi i1 [ %t137, %then12 ], [ 1, %else13 ]
  %t383 = phi double [ %t140, %then12 ], [ %t319, %else13 ]
  store i8* %t376, i8** %l5
  store i1 %t377, i1* %l6
  store double %t378, double* %l9
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  store i1 %t380, i1* %l7
  store double %t381, double* %l10
  store i1 %t382, i1* %l8
  store double %t383, double* %l11
  %t384 = load double, double* %l12
  %t385 = sitofp i64 1 to double
  %t386 = fadd double %t384, %t385
  store double %t386, double* %l12
  br label %loop.latch8
loop.latch8:
  %t387 = load i8*, i8** %l5
  %t388 = load i1, i1* %l6
  %t389 = load double, double* %l9
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t391 = load i1, i1* %l7
  %t392 = load double, double* %l10
  %t393 = load i1, i1* %l8
  %t394 = load double, double* %l11
  %t395 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t405 = load i8*, i8** %l5
  %t406 = call i64 @sailfin_runtime_string_length(i8* %t405)
  %t407 = icmp eq i64 %t406, 0
  %t408 = load i8*, i8** %l0
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t410 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t412 = load i8*, i8** %l4
  %t413 = load i8*, i8** %l5
  %t414 = load i1, i1* %l6
  %t415 = load i1, i1* %l7
  %t416 = load i1, i1* %l8
  %t417 = load double, double* %l9
  %t418 = load double, double* %l10
  %t419 = load double, double* %l11
  %t420 = load double, double* %l12
  br i1 %t407, label %then33, label %merge34
then33:
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s422 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.422, i32 0, i32 0
  %t423 = add i8* %s422, %struct_name
  %s424 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.424, i32 0, i32 0
  %t425 = add i8* %t423, %s424
  %t426 = load i8*, i8** %l4
  %t427 = add i8* %t425, %t426
  %s428 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.428, i32 0, i32 0
  %t429 = add i8* %t427, %s428
  %t430 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t421, i8* %t429)
  store { i8**, i64 }* %t430, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t431 = phi { i8**, i64 }* [ %t430, %then33 ], [ %t409, %entry ]
  store { i8**, i64 }* %t431, { i8**, i64 }** %l1
  %t432 = load i1, i1* %l6
  %t433 = xor i1 %t432, 1
  %t434 = load i8*, i8** %l0
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t436 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t438 = load i8*, i8** %l4
  %t439 = load i8*, i8** %l5
  %t440 = load i1, i1* %l6
  %t441 = load i1, i1* %l7
  %t442 = load i1, i1* %l8
  %t443 = load double, double* %l9
  %t444 = load double, double* %l10
  %t445 = load double, double* %l11
  %t446 = load double, double* %l12
  br i1 %t433, label %then35, label %merge36
then35:
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s448 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.448, i32 0, i32 0
  %t449 = add i8* %s448, %struct_name
  %s450 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.450, i32 0, i32 0
  %t451 = add i8* %t449, %s450
  %t452 = load i8*, i8** %l4
  %t453 = add i8* %t451, %t452
  %s454 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.454, i32 0, i32 0
  %t455 = add i8* %t453, %s454
  %t456 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t447, i8* %t455)
  store { i8**, i64 }* %t456, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t457 = phi { i8**, i64 }* [ %t456, %then35 ], [ %t435, %entry ]
  store { i8**, i64 }* %t457, { i8**, i64 }** %l1
  %t458 = load i1, i1* %l7
  %t459 = xor i1 %t458, 1
  %t460 = load i8*, i8** %l0
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t462 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t464 = load i8*, i8** %l4
  %t465 = load i8*, i8** %l5
  %t466 = load i1, i1* %l6
  %t467 = load i1, i1* %l7
  %t468 = load i1, i1* %l8
  %t469 = load double, double* %l9
  %t470 = load double, double* %l10
  %t471 = load double, double* %l11
  %t472 = load double, double* %l12
  br i1 %t459, label %then37, label %merge38
then37:
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s474 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.474, i32 0, i32 0
  %t475 = add i8* %s474, %struct_name
  %s476 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.476, i32 0, i32 0
  %t477 = add i8* %t475, %s476
  %t478 = load i8*, i8** %l4
  %t479 = add i8* %t477, %t478
  %s480 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.480, i32 0, i32 0
  %t481 = add i8* %t479, %s480
  %t482 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t473, i8* %t481)
  store { i8**, i64 }* %t482, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t483 = phi { i8**, i64 }* [ %t482, %then37 ], [ %t461, %entry ]
  store { i8**, i64 }* %t483, { i8**, i64 }** %l1
  %t484 = load i1, i1* %l8
  %t485 = xor i1 %t484, 1
  %t486 = load i8*, i8** %l0
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t488 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t490 = load i8*, i8** %l4
  %t491 = load i8*, i8** %l5
  %t492 = load i1, i1* %l6
  %t493 = load i1, i1* %l7
  %t494 = load i1, i1* %l8
  %t495 = load double, double* %l9
  %t496 = load double, double* %l10
  %t497 = load double, double* %l11
  %t498 = load double, double* %l12
  br i1 %t485, label %then39, label %merge40
then39:
  %t499 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s500 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.500, i32 0, i32 0
  %t501 = add i8* %s500, %struct_name
  %s502 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.502, i32 0, i32 0
  %t503 = add i8* %t501, %s502
  %t504 = load i8*, i8** %l4
  %t505 = add i8* %t503, %t504
  %s506 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.506, i32 0, i32 0
  %t507 = add i8* %t505, %s506
  %t508 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t499, i8* %t507)
  store { i8**, i64 }* %t508, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t509 = phi { i8**, i64 }* [ %t508, %then39 ], [ %t487, %entry ]
  store { i8**, i64 }* %t509, { i8**, i64 }** %l1
  %t514 = load i8*, i8** %l5
  %t515 = call i64 @sailfin_runtime_string_length(i8* %t514)
  %t516 = icmp sgt i64 %t515, 0
  br label %logical_and_entry_513

logical_and_entry_513:
  br i1 %t516, label %logical_and_right_513, label %logical_and_merge_513

logical_and_right_513:
  %t517 = load i1, i1* %l6
  br label %logical_and_right_end_513

logical_and_right_end_513:
  br label %logical_and_merge_513

logical_and_merge_513:
  %t518 = phi i1 [ false, %logical_and_entry_513 ], [ %t517, %logical_and_right_end_513 ]
  br label %logical_and_entry_512

logical_and_entry_512:
  br i1 %t518, label %logical_and_right_512, label %logical_and_merge_512

logical_and_right_512:
  %t519 = load i1, i1* %l7
  br label %logical_and_right_end_512

logical_and_right_end_512:
  br label %logical_and_merge_512

logical_and_merge_512:
  %t520 = phi i1 [ false, %logical_and_entry_512 ], [ %t519, %logical_and_right_end_512 ]
  br label %logical_and_entry_511

logical_and_entry_511:
  br i1 %t520, label %logical_and_right_511, label %logical_and_merge_511

logical_and_right_511:
  %t521 = load i1, i1* %l8
  br label %logical_and_right_end_511

logical_and_right_end_511:
  br label %logical_and_merge_511

logical_and_merge_511:
  %t522 = phi i1 [ false, %logical_and_entry_511 ], [ %t521, %logical_and_right_end_511 ]
  br label %logical_and_entry_510

logical_and_entry_510:
  br i1 %t522, label %logical_and_right_510, label %logical_and_merge_510

logical_and_right_510:
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t524 = load { i8**, i64 }, { i8**, i64 }* %t523
  %t525 = extractvalue { i8**, i64 } %t524, 1
  %t526 = icmp eq i64 %t525, 0
  br label %logical_and_right_end_510

logical_and_right_end_510:
  br label %logical_and_merge_510

logical_and_merge_510:
  %t527 = phi i1 [ false, %logical_and_entry_510 ], [ %t526, %logical_and_right_end_510 ]
  store i1 %t527, i1* %l20
  %t528 = load i8*, i8** %l4
  %t529 = insertvalue %NativeStructLayoutField undef, i8* %t528, 0
  %t530 = load i8*, i8** %l5
  %t531 = insertvalue %NativeStructLayoutField %t529, i8* %t530, 1
  %t532 = load double, double* %l9
  %t533 = insertvalue %NativeStructLayoutField %t531, double %t532, 2
  %t534 = load double, double* %l10
  %t535 = insertvalue %NativeStructLayoutField %t533, double %t534, 3
  %t536 = load double, double* %l11
  %t537 = insertvalue %NativeStructLayoutField %t535, double %t536, 4
  store %NativeStructLayoutField %t537, %NativeStructLayoutField* %l21
  %t538 = load i1, i1* %l20
  %t539 = insertvalue %StructLayoutFieldParse undef, i1 %t538, 0
  %t540 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t541 = insertvalue %StructLayoutFieldParse %t539, i8* null, 1
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t543 = insertvalue %StructLayoutFieldParse %t541, { i8**, i64 }* %t542, 2
  ret %StructLayoutFieldParse %t543
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
  %t437 = phi i8* [ %t43, %entry ], [ %t424, %loop.latch4 ]
  %t438 = phi i1 [ %t40, %entry ], [ %t425, %loop.latch4 ]
  %t439 = phi i1 [ %t41, %entry ], [ %t426, %loop.latch4 ]
  %t440 = phi double [ %t47, %entry ], [ %t427, %loop.latch4 ]
  %t441 = phi { i8**, i64 }* [ %t39, %entry ], [ %t428, %loop.latch4 ]
  %t442 = phi i1 [ %t42, %entry ], [ %t429, %loop.latch4 ]
  %t443 = phi double [ %t48, %entry ], [ %t430, %loop.latch4 ]
  %t444 = phi i8* [ %t44, %entry ], [ %t431, %loop.latch4 ]
  %t445 = phi i1 [ %t45, %entry ], [ %t432, %loop.latch4 ]
  %t446 = phi double [ %t49, %entry ], [ %t433, %loop.latch4 ]
  %t447 = phi i1 [ %t46, %entry ], [ %t434, %loop.latch4 ]
  %t448 = phi double [ %t50, %entry ], [ %t435, %loop.latch4 ]
  %t449 = phi double [ %t51, %entry ], [ %t436, %loop.latch4 ]
  store i8* %t437, i8** %l5
  store i1 %t438, i1* %l2
  store i1 %t439, i1* %l3
  store double %t440, double* %l9
  store { i8**, i64 }* %t441, { i8**, i64 }** %l1
  store i1 %t442, i1* %l4
  store double %t443, double* %l10
  store i8* %t444, i8** %l6
  store i1 %t445, i1* %l7
  store double %t446, double* %l11
  store i1 %t447, i1* %l8
  store double %t448, double* %l12
  store double %t449, double* %l13
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
  %t155 = alloca [2 x i8], align 1
  %t156 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  store i8 %t154, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 1
  store i8 0, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  %t159 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t148, i8* %t158)
  store { i8**, i64 }* %t159, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t160 = phi i1 [ 1, %then14 ], [ %t132, %else15 ]
  %t161 = phi double [ %t147, %then14 ], [ %t138, %else15 ]
  %t162 = phi { i8**, i64 }* [ %t130, %then14 ], [ %t159, %else15 ]
  store i1 %t160, i1* %l3
  store double %t161, double* %l9
  store { i8**, i64 }* %t162, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t163 = load i8*, i8** %l14
  %s164 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.164, i32 0, i32 0
  %t165 = call i1 @starts_with(i8* %t163, i8* %s164)
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load i1, i1* %l2
  %t169 = load i1, i1* %l3
  %t170 = load i1, i1* %l4
  %t171 = load i8*, i8** %l5
  %t172 = load i8*, i8** %l6
  %t173 = load i1, i1* %l7
  %t174 = load i1, i1* %l8
  %t175 = load double, double* %l9
  %t176 = load double, double* %l10
  %t177 = load double, double* %l11
  %t178 = load double, double* %l12
  %t179 = load double, double* %l13
  %t180 = load i8*, i8** %l14
  br i1 %t165, label %then17, label %else18
then17:
  %t181 = load i8*, i8** %l14
  %t182 = load i8*, i8** %l14
  %t183 = call i64 @sailfin_runtime_string_length(i8* %t182)
  %t184 = call i8* @sailfin_runtime_substring(i8* %t181, i64 6, i64 %t183)
  store i8* %t184, i8** %l17
  %t185 = load i8*, i8** %l17
  %t186 = call %NumberParseResult @parse_decimal_number(i8* %t185)
  store %NumberParseResult %t186, %NumberParseResult* %l18
  %t187 = load %NumberParseResult, %NumberParseResult* %l18
  %t188 = extractvalue %NumberParseResult %t187, 0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t191 = load i1, i1* %l2
  %t192 = load i1, i1* %l3
  %t193 = load i1, i1* %l4
  %t194 = load i8*, i8** %l5
  %t195 = load i8*, i8** %l6
  %t196 = load i1, i1* %l7
  %t197 = load i1, i1* %l8
  %t198 = load double, double* %l9
  %t199 = load double, double* %l10
  %t200 = load double, double* %l11
  %t201 = load double, double* %l12
  %t202 = load double, double* %l13
  %t203 = load i8*, i8** %l14
  %t204 = load i8*, i8** %l17
  %t205 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t188, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t206 = load %NumberParseResult, %NumberParseResult* %l18
  %t207 = extractvalue %NumberParseResult %t206, 1
  store double %t207, double* %l10
  br label %merge22
else21:
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s209 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.209, i32 0, i32 0
  %t210 = load i8*, i8** %l17
  %t211 = add i8* %s209, %t210
  %t212 = getelementptr i8, i8* %t211, i64 0
  %t213 = load i8, i8* %t212
  %t214 = add i8 %t213, 96
  %t215 = alloca [2 x i8], align 1
  %t216 = getelementptr [2 x i8], [2 x i8]* %t215, i32 0, i32 0
  store i8 %t214, i8* %t216
  %t217 = getelementptr [2 x i8], [2 x i8]* %t215, i32 0, i32 1
  store i8 0, i8* %t217
  %t218 = getelementptr [2 x i8], [2 x i8]* %t215, i32 0, i32 0
  %t219 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t208, i8* %t218)
  store { i8**, i64 }* %t219, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t220 = phi i1 [ 1, %then20 ], [ %t193, %else21 ]
  %t221 = phi double [ %t207, %then20 ], [ %t199, %else21 ]
  %t222 = phi { i8**, i64 }* [ %t190, %then20 ], [ %t219, %else21 ]
  store i1 %t220, i1* %l4
  store double %t221, double* %l10
  store { i8**, i64 }* %t222, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t223 = load i8*, i8** %l14
  %s224 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.224, i32 0, i32 0
  %t225 = call i1 @starts_with(i8* %t223, i8* %s224)
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t228 = load i1, i1* %l2
  %t229 = load i1, i1* %l3
  %t230 = load i1, i1* %l4
  %t231 = load i8*, i8** %l5
  %t232 = load i8*, i8** %l6
  %t233 = load i1, i1* %l7
  %t234 = load i1, i1* %l8
  %t235 = load double, double* %l9
  %t236 = load double, double* %l10
  %t237 = load double, double* %l11
  %t238 = load double, double* %l12
  %t239 = load double, double* %l13
  %t240 = load i8*, i8** %l14
  br i1 %t225, label %then23, label %else24
then23:
  %t241 = load i8*, i8** %l14
  %t242 = load i8*, i8** %l14
  %t243 = call i64 @sailfin_runtime_string_length(i8* %t242)
  %t244 = call i8* @sailfin_runtime_substring(i8* %t241, i64 9, i64 %t243)
  store i8* %t244, i8** %l6
  br label %merge25
else24:
  %t245 = load i8*, i8** %l14
  %s246 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.246, i32 0, i32 0
  %t247 = call i1 @starts_with(i8* %t245, i8* %s246)
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t250 = load i1, i1* %l2
  %t251 = load i1, i1* %l3
  %t252 = load i1, i1* %l4
  %t253 = load i8*, i8** %l5
  %t254 = load i8*, i8** %l6
  %t255 = load i1, i1* %l7
  %t256 = load i1, i1* %l8
  %t257 = load double, double* %l9
  %t258 = load double, double* %l10
  %t259 = load double, double* %l11
  %t260 = load double, double* %l12
  %t261 = load double, double* %l13
  %t262 = load i8*, i8** %l14
  br i1 %t247, label %then26, label %else27
then26:
  %t263 = load i8*, i8** %l14
  %t264 = load i8*, i8** %l14
  %t265 = call i64 @sailfin_runtime_string_length(i8* %t264)
  %t266 = call i8* @sailfin_runtime_substring(i8* %t263, i64 9, i64 %t265)
  store i8* %t266, i8** %l19
  %t267 = load i8*, i8** %l19
  %t268 = call %NumberParseResult @parse_decimal_number(i8* %t267)
  store %NumberParseResult %t268, %NumberParseResult* %l20
  %t269 = load %NumberParseResult, %NumberParseResult* %l20
  %t270 = extractvalue %NumberParseResult %t269, 0
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = load i1, i1* %l2
  %t274 = load i1, i1* %l3
  %t275 = load i1, i1* %l4
  %t276 = load i8*, i8** %l5
  %t277 = load i8*, i8** %l6
  %t278 = load i1, i1* %l7
  %t279 = load i1, i1* %l8
  %t280 = load double, double* %l9
  %t281 = load double, double* %l10
  %t282 = load double, double* %l11
  %t283 = load double, double* %l12
  %t284 = load double, double* %l13
  %t285 = load i8*, i8** %l14
  %t286 = load i8*, i8** %l19
  %t287 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t270, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t288 = load %NumberParseResult, %NumberParseResult* %l20
  %t289 = extractvalue %NumberParseResult %t288, 1
  store double %t289, double* %l11
  br label %merge31
else30:
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s291 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.291, i32 0, i32 0
  %t292 = load i8*, i8** %l19
  %t293 = add i8* %s291, %t292
  %t294 = getelementptr i8, i8* %t293, i64 0
  %t295 = load i8, i8* %t294
  %t296 = add i8 %t295, 96
  %t297 = alloca [2 x i8], align 1
  %t298 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 0
  store i8 %t296, i8* %t298
  %t299 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 1
  store i8 0, i8* %t299
  %t300 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 0
  %t301 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t290, i8* %t300)
  store { i8**, i64 }* %t301, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t302 = phi i1 [ 1, %then29 ], [ %t278, %else30 ]
  %t303 = phi double [ %t289, %then29 ], [ %t282, %else30 ]
  %t304 = phi { i8**, i64 }* [ %t272, %then29 ], [ %t301, %else30 ]
  store i1 %t302, i1* %l7
  store double %t303, double* %l11
  store { i8**, i64 }* %t304, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t305 = load i8*, i8** %l14
  %s306 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.306, i32 0, i32 0
  %t307 = call i1 @starts_with(i8* %t305, i8* %s306)
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = load i1, i1* %l2
  %t311 = load i1, i1* %l3
  %t312 = load i1, i1* %l4
  %t313 = load i8*, i8** %l5
  %t314 = load i8*, i8** %l6
  %t315 = load i1, i1* %l7
  %t316 = load i1, i1* %l8
  %t317 = load double, double* %l9
  %t318 = load double, double* %l10
  %t319 = load double, double* %l11
  %t320 = load double, double* %l12
  %t321 = load double, double* %l13
  %t322 = load i8*, i8** %l14
  br i1 %t307, label %then32, label %else33
then32:
  %t323 = load i8*, i8** %l14
  %t324 = load i8*, i8** %l14
  %t325 = call i64 @sailfin_runtime_string_length(i8* %t324)
  %t326 = call i8* @sailfin_runtime_substring(i8* %t323, i64 10, i64 %t325)
  store i8* %t326, i8** %l21
  %t327 = load i8*, i8** %l21
  %t328 = call %NumberParseResult @parse_decimal_number(i8* %t327)
  store %NumberParseResult %t328, %NumberParseResult* %l22
  %t329 = load %NumberParseResult, %NumberParseResult* %l22
  %t330 = extractvalue %NumberParseResult %t329, 0
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t333 = load i1, i1* %l2
  %t334 = load i1, i1* %l3
  %t335 = load i1, i1* %l4
  %t336 = load i8*, i8** %l5
  %t337 = load i8*, i8** %l6
  %t338 = load i1, i1* %l7
  %t339 = load i1, i1* %l8
  %t340 = load double, double* %l9
  %t341 = load double, double* %l10
  %t342 = load double, double* %l11
  %t343 = load double, double* %l12
  %t344 = load double, double* %l13
  %t345 = load i8*, i8** %l14
  %t346 = load i8*, i8** %l21
  %t347 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t330, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t348 = load %NumberParseResult, %NumberParseResult* %l22
  %t349 = extractvalue %NumberParseResult %t348, 1
  store double %t349, double* %l12
  br label %merge37
else36:
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s351 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.351, i32 0, i32 0
  %t352 = load i8*, i8** %l21
  %t353 = add i8* %s351, %t352
  %t354 = getelementptr i8, i8* %t353, i64 0
  %t355 = load i8, i8* %t354
  %t356 = add i8 %t355, 96
  %t357 = alloca [2 x i8], align 1
  %t358 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  store i8 %t356, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 1
  store i8 0, i8* %t359
  %t360 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  %t361 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t350, i8* %t360)
  store { i8**, i64 }* %t361, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t362 = phi i1 [ 1, %then35 ], [ %t339, %else36 ]
  %t363 = phi double [ %t349, %then35 ], [ %t343, %else36 ]
  %t364 = phi { i8**, i64 }* [ %t332, %then35 ], [ %t361, %else36 ]
  store i1 %t362, i1* %l8
  store double %t363, double* %l12
  store { i8**, i64 }* %t364, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s366 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.366, i32 0, i32 0
  %t367 = load i8*, i8** %l14
  %t368 = add i8* %s366, %t367
  %t369 = getelementptr i8, i8* %t368, i64 0
  %t370 = load i8, i8* %t369
  %t371 = add i8 %t370, 96
  %t372 = alloca [2 x i8], align 1
  %t373 = getelementptr [2 x i8], [2 x i8]* %t372, i32 0, i32 0
  store i8 %t371, i8* %t373
  %t374 = getelementptr [2 x i8], [2 x i8]* %t372, i32 0, i32 1
  store i8 0, i8* %t374
  %t375 = getelementptr [2 x i8], [2 x i8]* %t372, i32 0, i32 0
  %t376 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t365, i8* %t375)
  store { i8**, i64 }* %t376, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t377 = phi i1 [ 1, %then32 ], [ %t316, %else33 ]
  %t378 = phi double [ %t349, %then32 ], [ %t320, %else33 ]
  %t379 = phi { i8**, i64 }* [ %t361, %then32 ], [ %t376, %else33 ]
  store i1 %t377, i1* %l8
  store double %t378, double* %l12
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t380 = phi i1 [ 1, %then26 ], [ %t255, %else27 ]
  %t381 = phi double [ %t289, %then26 ], [ %t259, %else27 ]
  %t382 = phi { i8**, i64 }* [ %t301, %then26 ], [ %t361, %else27 ]
  %t383 = phi i1 [ %t256, %then26 ], [ 1, %else27 ]
  %t384 = phi double [ %t260, %then26 ], [ %t349, %else27 ]
  store i1 %t380, i1* %l7
  store double %t381, double* %l11
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  store i1 %t383, i1* %l8
  store double %t384, double* %l12
  br label %merge25
merge25:
  %t385 = phi i8* [ %t244, %then23 ], [ %t232, %else24 ]
  %t386 = phi i1 [ %t233, %then23 ], [ 1, %else24 ]
  %t387 = phi double [ %t237, %then23 ], [ %t289, %else24 ]
  %t388 = phi { i8**, i64 }* [ %t227, %then23 ], [ %t301, %else24 ]
  %t389 = phi i1 [ %t234, %then23 ], [ 1, %else24 ]
  %t390 = phi double [ %t238, %then23 ], [ %t349, %else24 ]
  store i8* %t385, i8** %l6
  store i1 %t386, i1* %l7
  store double %t387, double* %l11
  store { i8**, i64 }* %t388, { i8**, i64 }** %l1
  store i1 %t389, i1* %l8
  store double %t390, double* %l12
  br label %merge19
merge19:
  %t391 = phi i1 [ 1, %then17 ], [ %t170, %else18 ]
  %t392 = phi double [ %t207, %then17 ], [ %t176, %else18 ]
  %t393 = phi { i8**, i64 }* [ %t219, %then17 ], [ %t301, %else18 ]
  %t394 = phi i8* [ %t172, %then17 ], [ %t244, %else18 ]
  %t395 = phi i1 [ %t173, %then17 ], [ 1, %else18 ]
  %t396 = phi double [ %t177, %then17 ], [ %t289, %else18 ]
  %t397 = phi i1 [ %t174, %then17 ], [ 1, %else18 ]
  %t398 = phi double [ %t178, %then17 ], [ %t349, %else18 ]
  store i1 %t391, i1* %l4
  store double %t392, double* %l10
  store { i8**, i64 }* %t393, { i8**, i64 }** %l1
  store i8* %t394, i8** %l6
  store i1 %t395, i1* %l7
  store double %t396, double* %l11
  store i1 %t397, i1* %l8
  store double %t398, double* %l12
  br label %merge13
merge13:
  %t399 = phi i1 [ 1, %then11 ], [ %t109, %else12 ]
  %t400 = phi double [ %t147, %then11 ], [ %t115, %else12 ]
  %t401 = phi { i8**, i64 }* [ %t159, %then11 ], [ %t219, %else12 ]
  %t402 = phi i1 [ %t110, %then11 ], [ 1, %else12 ]
  %t403 = phi double [ %t116, %then11 ], [ %t207, %else12 ]
  %t404 = phi i8* [ %t112, %then11 ], [ %t244, %else12 ]
  %t405 = phi i1 [ %t113, %then11 ], [ 1, %else12 ]
  %t406 = phi double [ %t117, %then11 ], [ %t289, %else12 ]
  %t407 = phi i1 [ %t114, %then11 ], [ 1, %else12 ]
  %t408 = phi double [ %t118, %then11 ], [ %t349, %else12 ]
  store i1 %t399, i1* %l3
  store double %t400, double* %l9
  store { i8**, i64 }* %t401, { i8**, i64 }** %l1
  store i1 %t402, i1* %l4
  store double %t403, double* %l10
  store i8* %t404, i8** %l6
  store i1 %t405, i1* %l7
  store double %t406, double* %l11
  store i1 %t407, i1* %l8
  store double %t408, double* %l12
  br label %merge10
merge10:
  %t409 = phi i8* [ %t102, %then8 ], [ %t89, %else9 ]
  %t410 = phi i1 [ 1, %then8 ], [ %t86, %else9 ]
  %t411 = phi i1 [ %t87, %then8 ], [ 1, %else9 ]
  %t412 = phi double [ %t93, %then8 ], [ %t147, %else9 ]
  %t413 = phi { i8**, i64 }* [ %t85, %then8 ], [ %t159, %else9 ]
  %t414 = phi i1 [ %t88, %then8 ], [ 1, %else9 ]
  %t415 = phi double [ %t94, %then8 ], [ %t207, %else9 ]
  %t416 = phi i8* [ %t90, %then8 ], [ %t244, %else9 ]
  %t417 = phi i1 [ %t91, %then8 ], [ 1, %else9 ]
  %t418 = phi double [ %t95, %then8 ], [ %t289, %else9 ]
  %t419 = phi i1 [ %t92, %then8 ], [ 1, %else9 ]
  %t420 = phi double [ %t96, %then8 ], [ %t349, %else9 ]
  store i8* %t409, i8** %l5
  store i1 %t410, i1* %l2
  store i1 %t411, i1* %l3
  store double %t412, double* %l9
  store { i8**, i64 }* %t413, { i8**, i64 }** %l1
  store i1 %t414, i1* %l4
  store double %t415, double* %l10
  store i8* %t416, i8** %l6
  store i1 %t417, i1* %l7
  store double %t418, double* %l11
  store i1 %t419, i1* %l8
  store double %t420, double* %l12
  %t421 = load double, double* %l13
  %t422 = sitofp i64 1 to double
  %t423 = fadd double %t421, %t422
  store double %t423, double* %l13
  br label %loop.latch4
loop.latch4:
  %t424 = load i8*, i8** %l5
  %t425 = load i1, i1* %l2
  %t426 = load i1, i1* %l3
  %t427 = load double, double* %l9
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t429 = load i1, i1* %l4
  %t430 = load double, double* %l10
  %t431 = load i8*, i8** %l6
  %t432 = load i1, i1* %l7
  %t433 = load double, double* %l11
  %t434 = load i1, i1* %l8
  %t435 = load double, double* %l12
  %t436 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t450 = load i1, i1* %l3
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
  br i1 %t451, label %then38, label %merge39
then38:
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s467 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.467, i32 0, i32 0
  %t468 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t466, i8* %s467)
  store { i8**, i64 }* %t468, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t469 = phi { i8**, i64 }* [ %t468, %then38 ], [ %t453, %entry ]
  store { i8**, i64 }* %t469, { i8**, i64 }** %l1
  %t470 = load i1, i1* %l4
  %t471 = xor i1 %t470, 1
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t474 = load i1, i1* %l2
  %t475 = load i1, i1* %l3
  %t476 = load i1, i1* %l4
  %t477 = load i8*, i8** %l5
  %t478 = load i8*, i8** %l6
  %t479 = load i1, i1* %l7
  %t480 = load i1, i1* %l8
  %t481 = load double, double* %l9
  %t482 = load double, double* %l10
  %t483 = load double, double* %l11
  %t484 = load double, double* %l12
  %t485 = load double, double* %l13
  br i1 %t471, label %then40, label %merge41
then40:
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s487 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.487, i32 0, i32 0
  %t488 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t486, i8* %s487)
  store { i8**, i64 }* %t488, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t489 = phi { i8**, i64 }* [ %t488, %then40 ], [ %t473, %entry ]
  store { i8**, i64 }* %t489, { i8**, i64 }** %l1
  %t490 = load i8*, i8** %l6
  %t491 = call i64 @sailfin_runtime_string_length(i8* %t490)
  %t492 = icmp eq i64 %t491, 0
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
  br i1 %t492, label %then42, label %merge43
then42:
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s508 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.508, i32 0, i32 0
  %t509 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t507, i8* %s508)
  store { i8**, i64 }* %t509, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t510 = phi { i8**, i64 }* [ %t509, %then42 ], [ %t494, %entry ]
  store { i8**, i64 }* %t510, { i8**, i64 }** %l1
  %t511 = load i1, i1* %l7
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
  br i1 %t512, label %then44, label %merge45
then44:
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s528 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.528, i32 0, i32 0
  %t529 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t527, i8* %s528)
  store { i8**, i64 }* %t529, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t530 = phi { i8**, i64 }* [ %t529, %then44 ], [ %t514, %entry ]
  store { i8**, i64 }* %t530, { i8**, i64 }** %l1
  %t531 = load i1, i1* %l8
  %t532 = xor i1 %t531, 1
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t535 = load i1, i1* %l2
  %t536 = load i1, i1* %l3
  %t537 = load i1, i1* %l4
  %t538 = load i8*, i8** %l5
  %t539 = load i8*, i8** %l6
  %t540 = load i1, i1* %l7
  %t541 = load i1, i1* %l8
  %t542 = load double, double* %l9
  %t543 = load double, double* %l10
  %t544 = load double, double* %l11
  %t545 = load double, double* %l12
  %t546 = load double, double* %l13
  br i1 %t532, label %then46, label %merge47
then46:
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s548 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.548, i32 0, i32 0
  %t549 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t547, i8* %s548)
  store { i8**, i64 }* %t549, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t550 = phi { i8**, i64 }* [ %t549, %then46 ], [ %t534, %entry ]
  store { i8**, i64 }* %t550, { i8**, i64 }** %l1
  %t556 = load i1, i1* %l3
  br label %logical_and_entry_555

logical_and_entry_555:
  br i1 %t556, label %logical_and_right_555, label %logical_and_merge_555

logical_and_right_555:
  %t557 = load i1, i1* %l4
  br label %logical_and_right_end_555

logical_and_right_end_555:
  br label %logical_and_merge_555

logical_and_merge_555:
  %t558 = phi i1 [ false, %logical_and_entry_555 ], [ %t557, %logical_and_right_end_555 ]
  br label %logical_and_entry_554

logical_and_entry_554:
  br i1 %t558, label %logical_and_right_554, label %logical_and_merge_554

logical_and_right_554:
  %t559 = load i8*, i8** %l6
  %t560 = call i64 @sailfin_runtime_string_length(i8* %t559)
  %t561 = icmp sgt i64 %t560, 0
  br label %logical_and_right_end_554

logical_and_right_end_554:
  br label %logical_and_merge_554

logical_and_merge_554:
  %t562 = phi i1 [ false, %logical_and_entry_554 ], [ %t561, %logical_and_right_end_554 ]
  br label %logical_and_entry_553

logical_and_entry_553:
  br i1 %t562, label %logical_and_right_553, label %logical_and_merge_553

logical_and_right_553:
  %t563 = load i1, i1* %l7
  br label %logical_and_right_end_553

logical_and_right_end_553:
  br label %logical_and_merge_553

logical_and_merge_553:
  %t564 = phi i1 [ false, %logical_and_entry_553 ], [ %t563, %logical_and_right_end_553 ]
  br label %logical_and_entry_552

logical_and_entry_552:
  br i1 %t564, label %logical_and_right_552, label %logical_and_merge_552

logical_and_right_552:
  %t565 = load i1, i1* %l8
  br label %logical_and_right_end_552

logical_and_right_end_552:
  br label %logical_and_merge_552

logical_and_merge_552:
  %t566 = phi i1 [ false, %logical_and_entry_552 ], [ %t565, %logical_and_right_end_552 ]
  br label %logical_and_entry_551

logical_and_entry_551:
  br i1 %t566, label %logical_and_right_551, label %logical_and_merge_551

logical_and_right_551:
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t568 = load { i8**, i64 }, { i8**, i64 }* %t567
  %t569 = extractvalue { i8**, i64 } %t568, 1
  %t570 = icmp eq i64 %t569, 0
  br label %logical_and_right_end_551

logical_and_right_end_551:
  br label %logical_and_merge_551

logical_and_merge_551:
  %t571 = phi i1 [ false, %logical_and_entry_551 ], [ %t570, %logical_and_right_end_551 ]
  store i1 %t571, i1* %l23
  %t572 = load i1, i1* %l23
  %t573 = insertvalue %EnumLayoutHeaderParse undef, i1 %t572, 0
  %t574 = load i8*, i8** %l5
  %t575 = insertvalue %EnumLayoutHeaderParse %t573, i8* %t574, 1
  %t576 = load double, double* %l9
  %t577 = insertvalue %EnumLayoutHeaderParse %t575, double %t576, 2
  %t578 = load double, double* %l10
  %t579 = insertvalue %EnumLayoutHeaderParse %t577, double %t578, 3
  %t580 = load i8*, i8** %l6
  %t581 = insertvalue %EnumLayoutHeaderParse %t579, i8* %t580, 4
  %t582 = load double, double* %l11
  %t583 = insertvalue %EnumLayoutHeaderParse %t581, double %t582, 5
  %t584 = load double, double* %l12
  %t585 = insertvalue %EnumLayoutHeaderParse %t583, double %t584, 6
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t587 = insertvalue %EnumLayoutHeaderParse %t585, { i8**, i64 }* %t586, 7
  ret %EnumLayoutHeaderParse %t587
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
  %t458 = phi i1 [ %t96, %entry ], [ %t448, %loop.latch8 ]
  %t459 = phi double [ %t100, %entry ], [ %t449, %loop.latch8 ]
  %t460 = phi { i8**, i64 }* [ %t92, %entry ], [ %t450, %loop.latch8 ]
  %t461 = phi i1 [ %t97, %entry ], [ %t451, %loop.latch8 ]
  %t462 = phi double [ %t101, %entry ], [ %t452, %loop.latch8 ]
  %t463 = phi i1 [ %t98, %entry ], [ %t453, %loop.latch8 ]
  %t464 = phi double [ %t102, %entry ], [ %t454, %loop.latch8 ]
  %t465 = phi i1 [ %t99, %entry ], [ %t455, %loop.latch8 ]
  %t466 = phi double [ %t103, %entry ], [ %t456, %loop.latch8 ]
  %t467 = phi double [ %t104, %entry ], [ %t457, %loop.latch8 ]
  store i1 %t458, i1* %l5
  store double %t459, double* %l9
  store { i8**, i64 }* %t460, { i8**, i64 }** %l1
  store i1 %t461, i1* %l6
  store double %t462, double* %l10
  store i1 %t463, i1* %l7
  store double %t464, double* %l11
  store i1 %t465, i1* %l8
  store double %t466, double* %l12
  store double %t467, double* %l13
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
  %t193 = alloca [2 x i8], align 1
  %t194 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  store i8 %t192, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 1
  store i8 0, i8* %t195
  %t196 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  %t197 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t179, i8* %t196)
  store { i8**, i64 }* %t197, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t198 = phi i1 [ 1, %then15 ], [ %t165, %else16 ]
  %t199 = phi double [ %t178, %then15 ], [ %t169, %else16 ]
  %t200 = phi { i8**, i64 }* [ %t161, %then15 ], [ %t197, %else16 ]
  store i1 %t198, i1* %l5
  store double %t199, double* %l9
  store { i8**, i64 }* %t200, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t201 = load i8*, i8** %l14
  %s202 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.202, i32 0, i32 0
  %t203 = call i1 @starts_with(i8* %t201, i8* %s202)
  %t204 = load i8*, i8** %l0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t206 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t208 = load i8*, i8** %l4
  %t209 = load i1, i1* %l5
  %t210 = load i1, i1* %l6
  %t211 = load i1, i1* %l7
  %t212 = load i1, i1* %l8
  %t213 = load double, double* %l9
  %t214 = load double, double* %l10
  %t215 = load double, double* %l11
  %t216 = load double, double* %l12
  %t217 = load double, double* %l13
  %t218 = load i8*, i8** %l14
  br i1 %t203, label %then18, label %else19
then18:
  %t219 = load i8*, i8** %l14
  %t220 = load i8*, i8** %l14
  %t221 = call i64 @sailfin_runtime_string_length(i8* %t220)
  %t222 = call i8* @sailfin_runtime_substring(i8* %t219, i64 7, i64 %t221)
  store i8* %t222, i8** %l17
  %t223 = load i8*, i8** %l17
  %t224 = call %NumberParseResult @parse_decimal_number(i8* %t223)
  store %NumberParseResult %t224, %NumberParseResult* %l18
  %t225 = load %NumberParseResult, %NumberParseResult* %l18
  %t226 = extractvalue %NumberParseResult %t225, 0
  %t227 = load i8*, i8** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t231 = load i8*, i8** %l4
  %t232 = load i1, i1* %l5
  %t233 = load i1, i1* %l6
  %t234 = load i1, i1* %l7
  %t235 = load i1, i1* %l8
  %t236 = load double, double* %l9
  %t237 = load double, double* %l10
  %t238 = load double, double* %l11
  %t239 = load double, double* %l12
  %t240 = load double, double* %l13
  %t241 = load i8*, i8** %l14
  %t242 = load i8*, i8** %l17
  %t243 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t226, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t244 = load %NumberParseResult, %NumberParseResult* %l18
  %t245 = extractvalue %NumberParseResult %t244, 1
  store double %t245, double* %l10
  br label %merge23
else22:
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.247, i32 0, i32 0
  %t248 = add i8* %s247, %enum_name
  %s249 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.249, i32 0, i32 0
  %t250 = add i8* %t248, %s249
  %t251 = load i8*, i8** %l4
  %t252 = add i8* %t250, %t251
  %s253 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  %t255 = load i8*, i8** %l17
  %t256 = add i8* %t254, %t255
  %t257 = getelementptr i8, i8* %t256, i64 0
  %t258 = load i8, i8* %t257
  %t259 = add i8 %t258, 96
  %t260 = alloca [2 x i8], align 1
  %t261 = getelementptr [2 x i8], [2 x i8]* %t260, i32 0, i32 0
  store i8 %t259, i8* %t261
  %t262 = getelementptr [2 x i8], [2 x i8]* %t260, i32 0, i32 1
  store i8 0, i8* %t262
  %t263 = getelementptr [2 x i8], [2 x i8]* %t260, i32 0, i32 0
  %t264 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t246, i8* %t263)
  store { i8**, i64 }* %t264, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t265 = phi i1 [ 1, %then21 ], [ %t233, %else22 ]
  %t266 = phi double [ %t245, %then21 ], [ %t237, %else22 ]
  %t267 = phi { i8**, i64 }* [ %t228, %then21 ], [ %t264, %else22 ]
  store i1 %t265, i1* %l6
  store double %t266, double* %l10
  store { i8**, i64 }* %t267, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t268 = load i8*, i8** %l14
  %s269 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.269, i32 0, i32 0
  %t270 = call i1 @starts_with(i8* %t268, i8* %s269)
  %t271 = load i8*, i8** %l0
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t275 = load i8*, i8** %l4
  %t276 = load i1, i1* %l5
  %t277 = load i1, i1* %l6
  %t278 = load i1, i1* %l7
  %t279 = load i1, i1* %l8
  %t280 = load double, double* %l9
  %t281 = load double, double* %l10
  %t282 = load double, double* %l11
  %t283 = load double, double* %l12
  %t284 = load double, double* %l13
  %t285 = load i8*, i8** %l14
  br i1 %t270, label %then24, label %else25
then24:
  %t286 = load i8*, i8** %l14
  %t287 = load i8*, i8** %l14
  %t288 = call i64 @sailfin_runtime_string_length(i8* %t287)
  %t289 = call i8* @sailfin_runtime_substring(i8* %t286, i64 5, i64 %t288)
  store i8* %t289, i8** %l19
  %t290 = load i8*, i8** %l19
  %t291 = call %NumberParseResult @parse_decimal_number(i8* %t290)
  store %NumberParseResult %t291, %NumberParseResult* %l20
  %t292 = load %NumberParseResult, %NumberParseResult* %l20
  %t293 = extractvalue %NumberParseResult %t292, 0
  %t294 = load i8*, i8** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t298 = load i8*, i8** %l4
  %t299 = load i1, i1* %l5
  %t300 = load i1, i1* %l6
  %t301 = load i1, i1* %l7
  %t302 = load i1, i1* %l8
  %t303 = load double, double* %l9
  %t304 = load double, double* %l10
  %t305 = load double, double* %l11
  %t306 = load double, double* %l12
  %t307 = load double, double* %l13
  %t308 = load i8*, i8** %l14
  %t309 = load i8*, i8** %l19
  %t310 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t293, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t311 = load %NumberParseResult, %NumberParseResult* %l20
  %t312 = extractvalue %NumberParseResult %t311, 1
  store double %t312, double* %l11
  br label %merge29
else28:
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s314 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.314, i32 0, i32 0
  %t315 = add i8* %s314, %enum_name
  %s316 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.316, i32 0, i32 0
  %t317 = add i8* %t315, %s316
  %t318 = load i8*, i8** %l4
  %t319 = add i8* %t317, %t318
  %s320 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.320, i32 0, i32 0
  %t321 = add i8* %t319, %s320
  %t322 = load i8*, i8** %l19
  %t323 = add i8* %t321, %t322
  %t324 = getelementptr i8, i8* %t323, i64 0
  %t325 = load i8, i8* %t324
  %t326 = add i8 %t325, 96
  %t327 = alloca [2 x i8], align 1
  %t328 = getelementptr [2 x i8], [2 x i8]* %t327, i32 0, i32 0
  store i8 %t326, i8* %t328
  %t329 = getelementptr [2 x i8], [2 x i8]* %t327, i32 0, i32 1
  store i8 0, i8* %t329
  %t330 = getelementptr [2 x i8], [2 x i8]* %t327, i32 0, i32 0
  %t331 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t313, i8* %t330)
  store { i8**, i64 }* %t331, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t332 = phi i1 [ 1, %then27 ], [ %t301, %else28 ]
  %t333 = phi double [ %t312, %then27 ], [ %t305, %else28 ]
  %t334 = phi { i8**, i64 }* [ %t295, %then27 ], [ %t331, %else28 ]
  store i1 %t332, i1* %l7
  store double %t333, double* %l11
  store { i8**, i64 }* %t334, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t335 = load i8*, i8** %l14
  %s336 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.336, i32 0, i32 0
  %t337 = call i1 @starts_with(i8* %t335, i8* %s336)
  %t338 = load i8*, i8** %l0
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t340 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t342 = load i8*, i8** %l4
  %t343 = load i1, i1* %l5
  %t344 = load i1, i1* %l6
  %t345 = load i1, i1* %l7
  %t346 = load i1, i1* %l8
  %t347 = load double, double* %l9
  %t348 = load double, double* %l10
  %t349 = load double, double* %l11
  %t350 = load double, double* %l12
  %t351 = load double, double* %l13
  %t352 = load i8*, i8** %l14
  br i1 %t337, label %then30, label %else31
then30:
  %t353 = load i8*, i8** %l14
  %t354 = load i8*, i8** %l14
  %t355 = call i64 @sailfin_runtime_string_length(i8* %t354)
  %t356 = call i8* @sailfin_runtime_substring(i8* %t353, i64 6, i64 %t355)
  store i8* %t356, i8** %l21
  %t357 = load i8*, i8** %l21
  %t358 = call %NumberParseResult @parse_decimal_number(i8* %t357)
  store %NumberParseResult %t358, %NumberParseResult* %l22
  %t359 = load %NumberParseResult, %NumberParseResult* %l22
  %t360 = extractvalue %NumberParseResult %t359, 0
  %t361 = load i8*, i8** %l0
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t363 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t365 = load i8*, i8** %l4
  %t366 = load i1, i1* %l5
  %t367 = load i1, i1* %l6
  %t368 = load i1, i1* %l7
  %t369 = load i1, i1* %l8
  %t370 = load double, double* %l9
  %t371 = load double, double* %l10
  %t372 = load double, double* %l11
  %t373 = load double, double* %l12
  %t374 = load double, double* %l13
  %t375 = load i8*, i8** %l14
  %t376 = load i8*, i8** %l21
  %t377 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t360, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t378 = load %NumberParseResult, %NumberParseResult* %l22
  %t379 = extractvalue %NumberParseResult %t378, 1
  store double %t379, double* %l12
  br label %merge35
else34:
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s381 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.381, i32 0, i32 0
  %t382 = add i8* %s381, %enum_name
  %s383 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.383, i32 0, i32 0
  %t384 = add i8* %t382, %s383
  %t385 = load i8*, i8** %l4
  %t386 = add i8* %t384, %t385
  %s387 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.387, i32 0, i32 0
  %t388 = add i8* %t386, %s387
  %t389 = load i8*, i8** %l21
  %t390 = add i8* %t388, %t389
  %t391 = getelementptr i8, i8* %t390, i64 0
  %t392 = load i8, i8* %t391
  %t393 = add i8 %t392, 96
  %t394 = alloca [2 x i8], align 1
  %t395 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 0
  store i8 %t393, i8* %t395
  %t396 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 1
  store i8 0, i8* %t396
  %t397 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 0
  %t398 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t380, i8* %t397)
  store { i8**, i64 }* %t398, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t399 = phi i1 [ 1, %then33 ], [ %t369, %else34 ]
  %t400 = phi double [ %t379, %then33 ], [ %t373, %else34 ]
  %t401 = phi { i8**, i64 }* [ %t362, %then33 ], [ %t398, %else34 ]
  store i1 %t399, i1* %l8
  store double %t400, double* %l12
  store { i8**, i64 }* %t401, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s403 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.403, i32 0, i32 0
  %t404 = add i8* %s403, %enum_name
  %s405 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.405, i32 0, i32 0
  %t406 = add i8* %t404, %s405
  %t407 = load i8*, i8** %l4
  %t408 = add i8* %t406, %t407
  %s409 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.409, i32 0, i32 0
  %t410 = add i8* %t408, %s409
  %t411 = load i8*, i8** %l14
  %t412 = add i8* %t410, %t411
  %t413 = getelementptr i8, i8* %t412, i64 0
  %t414 = load i8, i8* %t413
  %t415 = add i8 %t414, 96
  %t416 = alloca [2 x i8], align 1
  %t417 = getelementptr [2 x i8], [2 x i8]* %t416, i32 0, i32 0
  store i8 %t415, i8* %t417
  %t418 = getelementptr [2 x i8], [2 x i8]* %t416, i32 0, i32 1
  store i8 0, i8* %t418
  %t419 = getelementptr [2 x i8], [2 x i8]* %t416, i32 0, i32 0
  %t420 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t402, i8* %t419)
  store { i8**, i64 }* %t420, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t421 = phi i1 [ 1, %then30 ], [ %t346, %else31 ]
  %t422 = phi double [ %t379, %then30 ], [ %t350, %else31 ]
  %t423 = phi { i8**, i64 }* [ %t398, %then30 ], [ %t420, %else31 ]
  store i1 %t421, i1* %l8
  store double %t422, double* %l12
  store { i8**, i64 }* %t423, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t424 = phi i1 [ 1, %then24 ], [ %t278, %else25 ]
  %t425 = phi double [ %t312, %then24 ], [ %t282, %else25 ]
  %t426 = phi { i8**, i64 }* [ %t331, %then24 ], [ %t398, %else25 ]
  %t427 = phi i1 [ %t279, %then24 ], [ 1, %else25 ]
  %t428 = phi double [ %t283, %then24 ], [ %t379, %else25 ]
  store i1 %t424, i1* %l7
  store double %t425, double* %l11
  store { i8**, i64 }* %t426, { i8**, i64 }** %l1
  store i1 %t427, i1* %l8
  store double %t428, double* %l12
  br label %merge20
merge20:
  %t429 = phi i1 [ 1, %then18 ], [ %t210, %else19 ]
  %t430 = phi double [ %t245, %then18 ], [ %t214, %else19 ]
  %t431 = phi { i8**, i64 }* [ %t264, %then18 ], [ %t331, %else19 ]
  %t432 = phi i1 [ %t211, %then18 ], [ 1, %else19 ]
  %t433 = phi double [ %t215, %then18 ], [ %t312, %else19 ]
  %t434 = phi i1 [ %t212, %then18 ], [ 1, %else19 ]
  %t435 = phi double [ %t216, %then18 ], [ %t379, %else19 ]
  store i1 %t429, i1* %l6
  store double %t430, double* %l10
  store { i8**, i64 }* %t431, { i8**, i64 }** %l1
  store i1 %t432, i1* %l7
  store double %t433, double* %l11
  store i1 %t434, i1* %l8
  store double %t435, double* %l12
  br label %merge14
merge14:
  %t436 = phi i1 [ 1, %then12 ], [ %t142, %else13 ]
  %t437 = phi double [ %t178, %then12 ], [ %t146, %else13 ]
  %t438 = phi { i8**, i64 }* [ %t197, %then12 ], [ %t264, %else13 ]
  %t439 = phi i1 [ %t143, %then12 ], [ 1, %else13 ]
  %t440 = phi double [ %t147, %then12 ], [ %t245, %else13 ]
  %t441 = phi i1 [ %t144, %then12 ], [ 1, %else13 ]
  %t442 = phi double [ %t148, %then12 ], [ %t312, %else13 ]
  %t443 = phi i1 [ %t145, %then12 ], [ 1, %else13 ]
  %t444 = phi double [ %t149, %then12 ], [ %t379, %else13 ]
  store i1 %t436, i1* %l5
  store double %t437, double* %l9
  store { i8**, i64 }* %t438, { i8**, i64 }** %l1
  store i1 %t439, i1* %l6
  store double %t440, double* %l10
  store i1 %t441, i1* %l7
  store double %t442, double* %l11
  store i1 %t443, i1* %l8
  store double %t444, double* %l12
  %t445 = load double, double* %l13
  %t446 = sitofp i64 1 to double
  %t447 = fadd double %t445, %t446
  store double %t447, double* %l13
  br label %loop.latch8
loop.latch8:
  %t448 = load i1, i1* %l5
  %t449 = load double, double* %l9
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load i1, i1* %l6
  %t452 = load double, double* %l10
  %t453 = load i1, i1* %l7
  %t454 = load double, double* %l11
  %t455 = load i1, i1* %l8
  %t456 = load double, double* %l12
  %t457 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t468 = load i1, i1* %l5
  %t469 = xor i1 %t468, 1
  %t470 = load i8*, i8** %l0
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t472 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t474 = load i8*, i8** %l4
  %t475 = load i1, i1* %l5
  %t476 = load i1, i1* %l6
  %t477 = load i1, i1* %l7
  %t478 = load i1, i1* %l8
  %t479 = load double, double* %l9
  %t480 = load double, double* %l10
  %t481 = load double, double* %l11
  %t482 = load double, double* %l12
  %t483 = load double, double* %l13
  br i1 %t469, label %then36, label %merge37
then36:
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s485 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.485, i32 0, i32 0
  %t486 = add i8* %s485, %enum_name
  %s487 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.487, i32 0, i32 0
  %t488 = add i8* %t486, %s487
  %t489 = load i8*, i8** %l4
  %t490 = add i8* %t488, %t489
  %s491 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.491, i32 0, i32 0
  %t492 = add i8* %t490, %s491
  %t493 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t484, i8* %t492)
  store { i8**, i64 }* %t493, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t494 = phi { i8**, i64 }* [ %t493, %then36 ], [ %t471, %entry ]
  store { i8**, i64 }* %t494, { i8**, i64 }** %l1
  %t495 = load i1, i1* %l6
  %t496 = xor i1 %t495, 1
  %t497 = load i8*, i8** %l0
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t499 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t501 = load i8*, i8** %l4
  %t502 = load i1, i1* %l5
  %t503 = load i1, i1* %l6
  %t504 = load i1, i1* %l7
  %t505 = load i1, i1* %l8
  %t506 = load double, double* %l9
  %t507 = load double, double* %l10
  %t508 = load double, double* %l11
  %t509 = load double, double* %l12
  %t510 = load double, double* %l13
  br i1 %t496, label %then38, label %merge39
then38:
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s512 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.512, i32 0, i32 0
  %t513 = add i8* %s512, %enum_name
  %s514 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.514, i32 0, i32 0
  %t515 = add i8* %t513, %s514
  %t516 = load i8*, i8** %l4
  %t517 = add i8* %t515, %t516
  %s518 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.518, i32 0, i32 0
  %t519 = add i8* %t517, %s518
  %t520 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t511, i8* %t519)
  store { i8**, i64 }* %t520, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t521 = phi { i8**, i64 }* [ %t520, %then38 ], [ %t498, %entry ]
  store { i8**, i64 }* %t521, { i8**, i64 }** %l1
  %t522 = load i1, i1* %l7
  %t523 = xor i1 %t522, 1
  %t524 = load i8*, i8** %l0
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t526 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t528 = load i8*, i8** %l4
  %t529 = load i1, i1* %l5
  %t530 = load i1, i1* %l6
  %t531 = load i1, i1* %l7
  %t532 = load i1, i1* %l8
  %t533 = load double, double* %l9
  %t534 = load double, double* %l10
  %t535 = load double, double* %l11
  %t536 = load double, double* %l12
  %t537 = load double, double* %l13
  br i1 %t523, label %then40, label %merge41
then40:
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s539 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.539, i32 0, i32 0
  %t540 = add i8* %s539, %enum_name
  %s541 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.541, i32 0, i32 0
  %t542 = add i8* %t540, %s541
  %t543 = load i8*, i8** %l4
  %t544 = add i8* %t542, %t543
  %s545 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.545, i32 0, i32 0
  %t546 = add i8* %t544, %s545
  %t547 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t538, i8* %t546)
  store { i8**, i64 }* %t547, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t548 = phi { i8**, i64 }* [ %t547, %then40 ], [ %t525, %entry ]
  store { i8**, i64 }* %t548, { i8**, i64 }** %l1
  %t549 = load i1, i1* %l8
  %t550 = xor i1 %t549, 1
  %t551 = load i8*, i8** %l0
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t553 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t555 = load i8*, i8** %l4
  %t556 = load i1, i1* %l5
  %t557 = load i1, i1* %l6
  %t558 = load i1, i1* %l7
  %t559 = load i1, i1* %l8
  %t560 = load double, double* %l9
  %t561 = load double, double* %l10
  %t562 = load double, double* %l11
  %t563 = load double, double* %l12
  %t564 = load double, double* %l13
  br i1 %t550, label %then42, label %merge43
then42:
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s566 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.566, i32 0, i32 0
  %t567 = add i8* %s566, %enum_name
  %s568 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.568, i32 0, i32 0
  %t569 = add i8* %t567, %s568
  %t570 = load i8*, i8** %l4
  %t571 = add i8* %t569, %t570
  %s572 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.572, i32 0, i32 0
  %t573 = add i8* %t571, %s572
  %t574 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t565, i8* %t573)
  store { i8**, i64 }* %t574, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t575 = phi { i8**, i64 }* [ %t574, %then42 ], [ %t552, %entry ]
  store { i8**, i64 }* %t575, { i8**, i64 }** %l1
  %t580 = load i1, i1* %l5
  br label %logical_and_entry_579

logical_and_entry_579:
  br i1 %t580, label %logical_and_right_579, label %logical_and_merge_579

logical_and_right_579:
  %t581 = load i1, i1* %l6
  br label %logical_and_right_end_579

logical_and_right_end_579:
  br label %logical_and_merge_579

logical_and_merge_579:
  %t582 = phi i1 [ false, %logical_and_entry_579 ], [ %t581, %logical_and_right_end_579 ]
  br label %logical_and_entry_578

logical_and_entry_578:
  br i1 %t582, label %logical_and_right_578, label %logical_and_merge_578

logical_and_right_578:
  %t583 = load i1, i1* %l7
  br label %logical_and_right_end_578

logical_and_right_end_578:
  br label %logical_and_merge_578

logical_and_merge_578:
  %t584 = phi i1 [ false, %logical_and_entry_578 ], [ %t583, %logical_and_right_end_578 ]
  br label %logical_and_entry_577

logical_and_entry_577:
  br i1 %t584, label %logical_and_right_577, label %logical_and_merge_577

logical_and_right_577:
  %t585 = load i1, i1* %l8
  br label %logical_and_right_end_577

logical_and_right_end_577:
  br label %logical_and_merge_577

logical_and_merge_577:
  %t586 = phi i1 [ false, %logical_and_entry_577 ], [ %t585, %logical_and_right_end_577 ]
  br label %logical_and_entry_576

logical_and_entry_576:
  br i1 %t586, label %logical_and_right_576, label %logical_and_merge_576

logical_and_right_576:
  %t587 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t588 = load { i8**, i64 }, { i8**, i64 }* %t587
  %t589 = extractvalue { i8**, i64 } %t588, 1
  %t590 = icmp eq i64 %t589, 0
  br label %logical_and_right_end_576

logical_and_right_end_576:
  br label %logical_and_merge_576

logical_and_merge_576:
  %t591 = phi i1 [ false, %logical_and_entry_576 ], [ %t590, %logical_and_right_end_576 ]
  store i1 %t591, i1* %l23
  %t592 = load i8*, i8** %l4
  %t593 = insertvalue %NativeEnumVariantLayout undef, i8* %t592, 0
  %t594 = load double, double* %l9
  %t595 = insertvalue %NativeEnumVariantLayout %t593, double %t594, 1
  %t596 = load double, double* %l10
  %t597 = insertvalue %NativeEnumVariantLayout %t595, double %t596, 2
  %t598 = load double, double* %l11
  %t599 = insertvalue %NativeEnumVariantLayout %t597, double %t598, 3
  %t600 = load double, double* %l12
  %t601 = insertvalue %NativeEnumVariantLayout %t599, double %t600, 4
  %t602 = alloca [0 x i8*]
  %t603 = getelementptr [0 x i8*], [0 x i8*]* %t602, i32 0, i32 0
  %t604 = alloca { i8**, i64 }
  %t605 = getelementptr { i8**, i64 }, { i8**, i64 }* %t604, i32 0, i32 0
  store i8** %t603, i8*** %t605
  %t606 = getelementptr { i8**, i64 }, { i8**, i64 }* %t604, i32 0, i32 1
  store i64 0, i64* %t606
  %t607 = insertvalue %NativeEnumVariantLayout %t601, { i8**, i64 }* %t604, 5
  store %NativeEnumVariantLayout %t607, %NativeEnumVariantLayout* %l24
  %t608 = load i1, i1* %l23
  %t609 = insertvalue %EnumLayoutVariantParse undef, i1 %t608, 0
  %t610 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t611 = insertvalue %EnumLayoutVariantParse %t609, i8* null, 1
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t613 = insertvalue %EnumLayoutVariantParse %t611, { i8**, i64 }* %t612, 2
  ret %EnumLayoutVariantParse %t613
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
  %t66 = alloca [2 x i8], align 1
  %t67 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  store i8 46, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 1
  store i8 0, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t66, i32 0, i32 0
  %t70 = call double @index_of(i8* %t65, i8* %t69)
  store double %t70, double* %l5
  %t72 = load double, double* %l5
  %t73 = sitofp i64 0 to double
  %t74 = fcmp ole double %t72, %t73
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t74, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t75 = load double, double* %l5
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  %t78 = load i8*, i8** %l4
  %t79 = call i64 @sailfin_runtime_string_length(i8* %t78)
  %t80 = sitofp i64 %t79 to double
  %t81 = fcmp oge double %t77, %t80
  br label %logical_or_right_end_71

logical_or_right_end_71:
  br label %logical_or_merge_71

logical_or_merge_71:
  %t82 = phi i1 [ true, %logical_or_entry_71 ], [ %t81, %logical_or_right_end_71 ]
  %t83 = load i8*, i8** %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t87 = load i8*, i8** %l4
  %t88 = load double, double* %l5
  br i1 %t82, label %then4, label %merge5
then4:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.90, i32 0, i32 0
  %t91 = add i8* %s90, %enum_name
  %s92 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.92, i32 0, i32 0
  %t93 = add i8* %t91, %s92
  %t94 = load i8*, i8** %l4
  %t95 = add i8* %t93, %t94
  %s96 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.96, i32 0, i32 0
  %t97 = add i8* %t95, %s96
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l1
  %t99 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s100 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.100, i32 0, i32 0
  %t101 = insertvalue %EnumLayoutPayloadParse %t99, i8* %s100, 1
  %t102 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t103 = insertvalue %EnumLayoutPayloadParse %t101, i8* null, 2
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = insertvalue %EnumLayoutPayloadParse %t103, { i8**, i64 }* %t104, 3
  ret %EnumLayoutPayloadParse %t105
merge5:
  %t106 = load i8*, i8** %l4
  %t107 = load double, double* %l5
  %t108 = fptosi double %t107 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %t106, i64 0, i64 %t108)
  store i8* %t109, i8** %l6
  %t110 = load i8*, i8** %l4
  %t111 = load double, double* %l5
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  %t114 = load i8*, i8** %l4
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = fptosi double %t113 to i64
  %t117 = call i8* @sailfin_runtime_substring(i8* %t110, i64 %t116, i64 %t115)
  store i8* %t117, i8** %l7
  %s118 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.118, i32 0, i32 0
  store i8* %s118, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t119 = sitofp i64 0 to double
  store double %t119, double* %l12
  %t120 = sitofp i64 0 to double
  store double %t120, double* %l13
  %t121 = sitofp i64 0 to double
  store double %t121, double* %l14
  %t122 = sitofp i64 1 to double
  store double %t122, double* %l15
  %t123 = load i8*, i8** %l0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t125 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t127 = load i8*, i8** %l4
  %t128 = load double, double* %l5
  %t129 = load i8*, i8** %l6
  %t130 = load i8*, i8** %l7
  %t131 = load i8*, i8** %l8
  %t132 = load i1, i1* %l9
  %t133 = load i1, i1* %l10
  %t134 = load i1, i1* %l11
  %t135 = load double, double* %l12
  %t136 = load double, double* %l13
  %t137 = load double, double* %l14
  %t138 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t461 = phi i8* [ %t131, %entry ], [ %t452, %loop.latch8 ]
  %t462 = phi i1 [ %t132, %entry ], [ %t453, %loop.latch8 ]
  %t463 = phi double [ %t135, %entry ], [ %t454, %loop.latch8 ]
  %t464 = phi { i8**, i64 }* [ %t124, %entry ], [ %t455, %loop.latch8 ]
  %t465 = phi i1 [ %t133, %entry ], [ %t456, %loop.latch8 ]
  %t466 = phi double [ %t136, %entry ], [ %t457, %loop.latch8 ]
  %t467 = phi i1 [ %t134, %entry ], [ %t458, %loop.latch8 ]
  %t468 = phi double [ %t137, %entry ], [ %t459, %loop.latch8 ]
  %t469 = phi double [ %t138, %entry ], [ %t460, %loop.latch8 ]
  store i8* %t461, i8** %l8
  store i1 %t462, i1* %l9
  store double %t463, double* %l12
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  store i1 %t465, i1* %l10
  store double %t466, double* %l13
  store i1 %t467, i1* %l11
  store double %t468, double* %l14
  store double %t469, double* %l15
  br label %loop.body7
loop.body7:
  %t139 = load double, double* %l15
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load { i8**, i64 }, { i8**, i64 }* %t140
  %t142 = extractvalue { i8**, i64 } %t141, 1
  %t143 = sitofp i64 %t142 to double
  %t144 = fcmp oge double %t139, %t143
  %t145 = load i8*, i8** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t149 = load i8*, i8** %l4
  %t150 = load double, double* %l5
  %t151 = load i8*, i8** %l6
  %t152 = load i8*, i8** %l7
  %t153 = load i8*, i8** %l8
  %t154 = load i1, i1* %l9
  %t155 = load i1, i1* %l10
  %t156 = load i1, i1* %l11
  %t157 = load double, double* %l12
  %t158 = load double, double* %l13
  %t159 = load double, double* %l14
  %t160 = load double, double* %l15
  br i1 %t144, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t162 = load double, double* %l15
  %t163 = fptosi double %t162 to i64
  %t164 = load { i8**, i64 }, { i8**, i64 }* %t161
  %t165 = extractvalue { i8**, i64 } %t164, 0
  %t166 = extractvalue { i8**, i64 } %t164, 1
  %t167 = icmp uge i64 %t163, %t166
  ; bounds check: %t167 (if true, out of bounds)
  %t168 = getelementptr i8*, i8** %t165, i64 %t163
  %t169 = load i8*, i8** %t168
  store i8* %t169, i8** %l16
  %t170 = load i8*, i8** %l16
  %s171 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.171, i32 0, i32 0
  %t172 = call i1 @starts_with(i8* %t170, i8* %s171)
  %t173 = load i8*, i8** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t177 = load i8*, i8** %l4
  %t178 = load double, double* %l5
  %t179 = load i8*, i8** %l6
  %t180 = load i8*, i8** %l7
  %t181 = load i8*, i8** %l8
  %t182 = load i1, i1* %l9
  %t183 = load i1, i1* %l10
  %t184 = load i1, i1* %l11
  %t185 = load double, double* %l12
  %t186 = load double, double* %l13
  %t187 = load double, double* %l14
  %t188 = load double, double* %l15
  %t189 = load i8*, i8** %l16
  br i1 %t172, label %then12, label %else13
then12:
  %t190 = load i8*, i8** %l16
  %t191 = load i8*, i8** %l16
  %t192 = call i64 @sailfin_runtime_string_length(i8* %t191)
  %t193 = call i8* @sailfin_runtime_substring(i8* %t190, i64 5, i64 %t192)
  store i8* %t193, i8** %l8
  br label %merge14
else13:
  %t194 = load i8*, i8** %l16
  %s195 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.195, i32 0, i32 0
  %t196 = call i1 @starts_with(i8* %t194, i8* %s195)
  %t197 = load i8*, i8** %l0
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t199 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t201 = load i8*, i8** %l4
  %t202 = load double, double* %l5
  %t203 = load i8*, i8** %l6
  %t204 = load i8*, i8** %l7
  %t205 = load i8*, i8** %l8
  %t206 = load i1, i1* %l9
  %t207 = load i1, i1* %l10
  %t208 = load i1, i1* %l11
  %t209 = load double, double* %l12
  %t210 = load double, double* %l13
  %t211 = load double, double* %l14
  %t212 = load double, double* %l15
  %t213 = load i8*, i8** %l16
  br i1 %t196, label %then15, label %else16
then15:
  %t214 = load i8*, i8** %l16
  %t215 = load i8*, i8** %l16
  %t216 = call i64 @sailfin_runtime_string_length(i8* %t215)
  %t217 = call i8* @sailfin_runtime_substring(i8* %t214, i64 7, i64 %t216)
  store i8* %t217, i8** %l17
  %t218 = load i8*, i8** %l17
  %t219 = call %NumberParseResult @parse_decimal_number(i8* %t218)
  store %NumberParseResult %t219, %NumberParseResult* %l18
  %t220 = load %NumberParseResult, %NumberParseResult* %l18
  %t221 = extractvalue %NumberParseResult %t220, 0
  %t222 = load i8*, i8** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t226 = load i8*, i8** %l4
  %t227 = load double, double* %l5
  %t228 = load i8*, i8** %l6
  %t229 = load i8*, i8** %l7
  %t230 = load i8*, i8** %l8
  %t231 = load i1, i1* %l9
  %t232 = load i1, i1* %l10
  %t233 = load i1, i1* %l11
  %t234 = load double, double* %l12
  %t235 = load double, double* %l13
  %t236 = load double, double* %l14
  %t237 = load double, double* %l15
  %t238 = load i8*, i8** %l16
  %t239 = load i8*, i8** %l17
  %t240 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t221, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t241 = load %NumberParseResult, %NumberParseResult* %l18
  %t242 = extractvalue %NumberParseResult %t241, 1
  store double %t242, double* %l12
  br label %merge20
else19:
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s244 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.244, i32 0, i32 0
  %t245 = add i8* %s244, %enum_name
  %s246 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.246, i32 0, i32 0
  %t247 = add i8* %t245, %s246
  %t248 = load i8*, i8** %l4
  %t249 = add i8* %t247, %t248
  %s250 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.250, i32 0, i32 0
  %t251 = add i8* %t249, %s250
  %t252 = load i8*, i8** %l17
  %t253 = add i8* %t251, %t252
  %t254 = getelementptr i8, i8* %t253, i64 0
  %t255 = load i8, i8* %t254
  %t256 = add i8 %t255, 96
  %t257 = alloca [2 x i8], align 1
  %t258 = getelementptr [2 x i8], [2 x i8]* %t257, i32 0, i32 0
  store i8 %t256, i8* %t258
  %t259 = getelementptr [2 x i8], [2 x i8]* %t257, i32 0, i32 1
  store i8 0, i8* %t259
  %t260 = getelementptr [2 x i8], [2 x i8]* %t257, i32 0, i32 0
  %t261 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t243, i8* %t260)
  store { i8**, i64 }* %t261, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t262 = phi i1 [ 1, %then18 ], [ %t231, %else19 ]
  %t263 = phi double [ %t242, %then18 ], [ %t234, %else19 ]
  %t264 = phi { i8**, i64 }* [ %t223, %then18 ], [ %t261, %else19 ]
  store i1 %t262, i1* %l9
  store double %t263, double* %l12
  store { i8**, i64 }* %t264, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t265 = load i8*, i8** %l16
  %s266 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.266, i32 0, i32 0
  %t267 = call i1 @starts_with(i8* %t265, i8* %s266)
  %t268 = load i8*, i8** %l0
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t270 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t272 = load i8*, i8** %l4
  %t273 = load double, double* %l5
  %t274 = load i8*, i8** %l6
  %t275 = load i8*, i8** %l7
  %t276 = load i8*, i8** %l8
  %t277 = load i1, i1* %l9
  %t278 = load i1, i1* %l10
  %t279 = load i1, i1* %l11
  %t280 = load double, double* %l12
  %t281 = load double, double* %l13
  %t282 = load double, double* %l14
  %t283 = load double, double* %l15
  %t284 = load i8*, i8** %l16
  br i1 %t267, label %then21, label %else22
then21:
  %t285 = load i8*, i8** %l16
  %t286 = load i8*, i8** %l16
  %t287 = call i64 @sailfin_runtime_string_length(i8* %t286)
  %t288 = call i8* @sailfin_runtime_substring(i8* %t285, i64 5, i64 %t287)
  store i8* %t288, i8** %l19
  %t289 = load i8*, i8** %l19
  %t290 = call %NumberParseResult @parse_decimal_number(i8* %t289)
  store %NumberParseResult %t290, %NumberParseResult* %l20
  %t291 = load %NumberParseResult, %NumberParseResult* %l20
  %t292 = extractvalue %NumberParseResult %t291, 0
  %t293 = load i8*, i8** %l0
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t295 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t297 = load i8*, i8** %l4
  %t298 = load double, double* %l5
  %t299 = load i8*, i8** %l6
  %t300 = load i8*, i8** %l7
  %t301 = load i8*, i8** %l8
  %t302 = load i1, i1* %l9
  %t303 = load i1, i1* %l10
  %t304 = load i1, i1* %l11
  %t305 = load double, double* %l12
  %t306 = load double, double* %l13
  %t307 = load double, double* %l14
  %t308 = load double, double* %l15
  %t309 = load i8*, i8** %l16
  %t310 = load i8*, i8** %l19
  %t311 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t292, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t312 = load %NumberParseResult, %NumberParseResult* %l20
  %t313 = extractvalue %NumberParseResult %t312, 1
  store double %t313, double* %l13
  br label %merge26
else25:
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s315 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.315, i32 0, i32 0
  %t316 = add i8* %s315, %enum_name
  %s317 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.317, i32 0, i32 0
  %t318 = add i8* %t316, %s317
  %t319 = load i8*, i8** %l4
  %t320 = add i8* %t318, %t319
  %s321 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.321, i32 0, i32 0
  %t322 = add i8* %t320, %s321
  %t323 = load i8*, i8** %l19
  %t324 = add i8* %t322, %t323
  %t325 = getelementptr i8, i8* %t324, i64 0
  %t326 = load i8, i8* %t325
  %t327 = add i8 %t326, 96
  %t328 = alloca [2 x i8], align 1
  %t329 = getelementptr [2 x i8], [2 x i8]* %t328, i32 0, i32 0
  store i8 %t327, i8* %t329
  %t330 = getelementptr [2 x i8], [2 x i8]* %t328, i32 0, i32 1
  store i8 0, i8* %t330
  %t331 = getelementptr [2 x i8], [2 x i8]* %t328, i32 0, i32 0
  %t332 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t314, i8* %t331)
  store { i8**, i64 }* %t332, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t333 = phi i1 [ 1, %then24 ], [ %t303, %else25 ]
  %t334 = phi double [ %t313, %then24 ], [ %t306, %else25 ]
  %t335 = phi { i8**, i64 }* [ %t294, %then24 ], [ %t332, %else25 ]
  store i1 %t333, i1* %l10
  store double %t334, double* %l13
  store { i8**, i64 }* %t335, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t336 = load i8*, i8** %l16
  %s337 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.337, i32 0, i32 0
  %t338 = call i1 @starts_with(i8* %t336, i8* %s337)
  %t339 = load i8*, i8** %l0
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t341 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t343 = load i8*, i8** %l4
  %t344 = load double, double* %l5
  %t345 = load i8*, i8** %l6
  %t346 = load i8*, i8** %l7
  %t347 = load i8*, i8** %l8
  %t348 = load i1, i1* %l9
  %t349 = load i1, i1* %l10
  %t350 = load i1, i1* %l11
  %t351 = load double, double* %l12
  %t352 = load double, double* %l13
  %t353 = load double, double* %l14
  %t354 = load double, double* %l15
  %t355 = load i8*, i8** %l16
  br i1 %t338, label %then27, label %else28
then27:
  %t356 = load i8*, i8** %l16
  %t357 = load i8*, i8** %l16
  %t358 = call i64 @sailfin_runtime_string_length(i8* %t357)
  %t359 = call i8* @sailfin_runtime_substring(i8* %t356, i64 6, i64 %t358)
  store i8* %t359, i8** %l21
  %t360 = load i8*, i8** %l21
  %t361 = call %NumberParseResult @parse_decimal_number(i8* %t360)
  store %NumberParseResult %t361, %NumberParseResult* %l22
  %t362 = load %NumberParseResult, %NumberParseResult* %l22
  %t363 = extractvalue %NumberParseResult %t362, 0
  %t364 = load i8*, i8** %l0
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t366 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t368 = load i8*, i8** %l4
  %t369 = load double, double* %l5
  %t370 = load i8*, i8** %l6
  %t371 = load i8*, i8** %l7
  %t372 = load i8*, i8** %l8
  %t373 = load i1, i1* %l9
  %t374 = load i1, i1* %l10
  %t375 = load i1, i1* %l11
  %t376 = load double, double* %l12
  %t377 = load double, double* %l13
  %t378 = load double, double* %l14
  %t379 = load double, double* %l15
  %t380 = load i8*, i8** %l16
  %t381 = load i8*, i8** %l21
  %t382 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t363, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t383 = load %NumberParseResult, %NumberParseResult* %l22
  %t384 = extractvalue %NumberParseResult %t383, 1
  store double %t384, double* %l14
  br label %merge32
else31:
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s386 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.386, i32 0, i32 0
  %t387 = add i8* %s386, %enum_name
  %s388 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.388, i32 0, i32 0
  %t389 = add i8* %t387, %s388
  %t390 = load i8*, i8** %l4
  %t391 = add i8* %t389, %t390
  %s392 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.392, i32 0, i32 0
  %t393 = add i8* %t391, %s392
  %t394 = load i8*, i8** %l21
  %t395 = add i8* %t393, %t394
  %t396 = getelementptr i8, i8* %t395, i64 0
  %t397 = load i8, i8* %t396
  %t398 = add i8 %t397, 96
  %t399 = alloca [2 x i8], align 1
  %t400 = getelementptr [2 x i8], [2 x i8]* %t399, i32 0, i32 0
  store i8 %t398, i8* %t400
  %t401 = getelementptr [2 x i8], [2 x i8]* %t399, i32 0, i32 1
  store i8 0, i8* %t401
  %t402 = getelementptr [2 x i8], [2 x i8]* %t399, i32 0, i32 0
  %t403 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t385, i8* %t402)
  store { i8**, i64 }* %t403, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t404 = phi i1 [ 1, %then30 ], [ %t375, %else31 ]
  %t405 = phi double [ %t384, %then30 ], [ %t378, %else31 ]
  %t406 = phi { i8**, i64 }* [ %t365, %then30 ], [ %t403, %else31 ]
  store i1 %t404, i1* %l11
  store double %t405, double* %l14
  store { i8**, i64 }* %t406, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s408 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.408, i32 0, i32 0
  %t409 = add i8* %s408, %enum_name
  %s410 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.410, i32 0, i32 0
  %t411 = add i8* %t409, %s410
  %t412 = load i8*, i8** %l4
  %t413 = add i8* %t411, %t412
  %s414 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.414, i32 0, i32 0
  %t415 = add i8* %t413, %s414
  %t416 = load i8*, i8** %l16
  %t417 = add i8* %t415, %t416
  %t418 = getelementptr i8, i8* %t417, i64 0
  %t419 = load i8, i8* %t418
  %t420 = add i8 %t419, 96
  %t421 = alloca [2 x i8], align 1
  %t422 = getelementptr [2 x i8], [2 x i8]* %t421, i32 0, i32 0
  store i8 %t420, i8* %t422
  %t423 = getelementptr [2 x i8], [2 x i8]* %t421, i32 0, i32 1
  store i8 0, i8* %t423
  %t424 = getelementptr [2 x i8], [2 x i8]* %t421, i32 0, i32 0
  %t425 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t407, i8* %t424)
  store { i8**, i64 }* %t425, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t426 = phi i1 [ 1, %then27 ], [ %t350, %else28 ]
  %t427 = phi double [ %t384, %then27 ], [ %t353, %else28 ]
  %t428 = phi { i8**, i64 }* [ %t403, %then27 ], [ %t425, %else28 ]
  store i1 %t426, i1* %l11
  store double %t427, double* %l14
  store { i8**, i64 }* %t428, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t429 = phi i1 [ 1, %then21 ], [ %t278, %else22 ]
  %t430 = phi double [ %t313, %then21 ], [ %t281, %else22 ]
  %t431 = phi { i8**, i64 }* [ %t332, %then21 ], [ %t403, %else22 ]
  %t432 = phi i1 [ %t279, %then21 ], [ 1, %else22 ]
  %t433 = phi double [ %t282, %then21 ], [ %t384, %else22 ]
  store i1 %t429, i1* %l10
  store double %t430, double* %l13
  store { i8**, i64 }* %t431, { i8**, i64 }** %l1
  store i1 %t432, i1* %l11
  store double %t433, double* %l14
  br label %merge17
merge17:
  %t434 = phi i1 [ 1, %then15 ], [ %t206, %else16 ]
  %t435 = phi double [ %t242, %then15 ], [ %t209, %else16 ]
  %t436 = phi { i8**, i64 }* [ %t261, %then15 ], [ %t332, %else16 ]
  %t437 = phi i1 [ %t207, %then15 ], [ 1, %else16 ]
  %t438 = phi double [ %t210, %then15 ], [ %t313, %else16 ]
  %t439 = phi i1 [ %t208, %then15 ], [ 1, %else16 ]
  %t440 = phi double [ %t211, %then15 ], [ %t384, %else16 ]
  store i1 %t434, i1* %l9
  store double %t435, double* %l12
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  store i1 %t437, i1* %l10
  store double %t438, double* %l13
  store i1 %t439, i1* %l11
  store double %t440, double* %l14
  br label %merge14
merge14:
  %t441 = phi i8* [ %t193, %then12 ], [ %t181, %else13 ]
  %t442 = phi i1 [ %t182, %then12 ], [ 1, %else13 ]
  %t443 = phi double [ %t185, %then12 ], [ %t242, %else13 ]
  %t444 = phi { i8**, i64 }* [ %t174, %then12 ], [ %t261, %else13 ]
  %t445 = phi i1 [ %t183, %then12 ], [ 1, %else13 ]
  %t446 = phi double [ %t186, %then12 ], [ %t313, %else13 ]
  %t447 = phi i1 [ %t184, %then12 ], [ 1, %else13 ]
  %t448 = phi double [ %t187, %then12 ], [ %t384, %else13 ]
  store i8* %t441, i8** %l8
  store i1 %t442, i1* %l9
  store double %t443, double* %l12
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  store i1 %t445, i1* %l10
  store double %t446, double* %l13
  store i1 %t447, i1* %l11
  store double %t448, double* %l14
  %t449 = load double, double* %l15
  %t450 = sitofp i64 1 to double
  %t451 = fadd double %t449, %t450
  store double %t451, double* %l15
  br label %loop.latch8
loop.latch8:
  %t452 = load i8*, i8** %l8
  %t453 = load i1, i1* %l9
  %t454 = load double, double* %l12
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t456 = load i1, i1* %l10
  %t457 = load double, double* %l13
  %t458 = load i1, i1* %l11
  %t459 = load double, double* %l14
  %t460 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t470 = load i8*, i8** %l8
  %t471 = call i64 @sailfin_runtime_string_length(i8* %t470)
  %t472 = icmp eq i64 %t471, 0
  %t473 = load i8*, i8** %l0
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t477 = load i8*, i8** %l4
  %t478 = load double, double* %l5
  %t479 = load i8*, i8** %l6
  %t480 = load i8*, i8** %l7
  %t481 = load i8*, i8** %l8
  %t482 = load i1, i1* %l9
  %t483 = load i1, i1* %l10
  %t484 = load i1, i1* %l11
  %t485 = load double, double* %l12
  %t486 = load double, double* %l13
  %t487 = load double, double* %l14
  %t488 = load double, double* %l15
  br i1 %t472, label %then33, label %merge34
then33:
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s490 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.490, i32 0, i32 0
  %t491 = add i8* %s490, %enum_name
  %s492 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.492, i32 0, i32 0
  %t493 = add i8* %t491, %s492
  %t494 = load i8*, i8** %l4
  %t495 = add i8* %t493, %t494
  %s496 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.496, i32 0, i32 0
  %t497 = add i8* %t495, %s496
  %t498 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t489, i8* %t497)
  store { i8**, i64 }* %t498, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t499 = phi { i8**, i64 }* [ %t498, %then33 ], [ %t474, %entry ]
  store { i8**, i64 }* %t499, { i8**, i64 }** %l1
  %t500 = load i1, i1* %l9
  %t501 = xor i1 %t500, 1
  %t502 = load i8*, i8** %l0
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t504 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t506 = load i8*, i8** %l4
  %t507 = load double, double* %l5
  %t508 = load i8*, i8** %l6
  %t509 = load i8*, i8** %l7
  %t510 = load i8*, i8** %l8
  %t511 = load i1, i1* %l9
  %t512 = load i1, i1* %l10
  %t513 = load i1, i1* %l11
  %t514 = load double, double* %l12
  %t515 = load double, double* %l13
  %t516 = load double, double* %l14
  %t517 = load double, double* %l15
  br i1 %t501, label %then35, label %merge36
then35:
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s519 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.519, i32 0, i32 0
  %t520 = add i8* %s519, %enum_name
  %s521 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.521, i32 0, i32 0
  %t522 = add i8* %t520, %s521
  %t523 = load i8*, i8** %l4
  %t524 = add i8* %t522, %t523
  %s525 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.525, i32 0, i32 0
  %t526 = add i8* %t524, %s525
  %t527 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t518, i8* %t526)
  store { i8**, i64 }* %t527, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t528 = phi { i8**, i64 }* [ %t527, %then35 ], [ %t503, %entry ]
  store { i8**, i64 }* %t528, { i8**, i64 }** %l1
  %t529 = load i1, i1* %l10
  %t530 = xor i1 %t529, 1
  %t531 = load i8*, i8** %l0
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t533 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t535 = load i8*, i8** %l4
  %t536 = load double, double* %l5
  %t537 = load i8*, i8** %l6
  %t538 = load i8*, i8** %l7
  %t539 = load i8*, i8** %l8
  %t540 = load i1, i1* %l9
  %t541 = load i1, i1* %l10
  %t542 = load i1, i1* %l11
  %t543 = load double, double* %l12
  %t544 = load double, double* %l13
  %t545 = load double, double* %l14
  %t546 = load double, double* %l15
  br i1 %t530, label %then37, label %merge38
then37:
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s548 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.548, i32 0, i32 0
  %t549 = add i8* %s548, %enum_name
  %s550 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.550, i32 0, i32 0
  %t551 = add i8* %t549, %s550
  %t552 = load i8*, i8** %l4
  %t553 = add i8* %t551, %t552
  %s554 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.554, i32 0, i32 0
  %t555 = add i8* %t553, %s554
  %t556 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t547, i8* %t555)
  store { i8**, i64 }* %t556, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t557 = phi { i8**, i64 }* [ %t556, %then37 ], [ %t532, %entry ]
  store { i8**, i64 }* %t557, { i8**, i64 }** %l1
  %t558 = load i1, i1* %l11
  %t559 = xor i1 %t558, 1
  %t560 = load i8*, i8** %l0
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t562 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t564 = load i8*, i8** %l4
  %t565 = load double, double* %l5
  %t566 = load i8*, i8** %l6
  %t567 = load i8*, i8** %l7
  %t568 = load i8*, i8** %l8
  %t569 = load i1, i1* %l9
  %t570 = load i1, i1* %l10
  %t571 = load i1, i1* %l11
  %t572 = load double, double* %l12
  %t573 = load double, double* %l13
  %t574 = load double, double* %l14
  %t575 = load double, double* %l15
  br i1 %t559, label %then39, label %merge40
then39:
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s577 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.577, i32 0, i32 0
  %t578 = add i8* %s577, %enum_name
  %s579 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.579, i32 0, i32 0
  %t580 = add i8* %t578, %s579
  %t581 = load i8*, i8** %l4
  %t582 = add i8* %t580, %t581
  %s583 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.583, i32 0, i32 0
  %t584 = add i8* %t582, %s583
  %t585 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t576, i8* %t584)
  store { i8**, i64 }* %t585, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t586 = phi { i8**, i64 }* [ %t585, %then39 ], [ %t561, %entry ]
  store { i8**, i64 }* %t586, { i8**, i64 }** %l1
  %t591 = load i8*, i8** %l8
  %t592 = call i64 @sailfin_runtime_string_length(i8* %t591)
  %t593 = icmp sgt i64 %t592, 0
  br label %logical_and_entry_590

logical_and_entry_590:
  br i1 %t593, label %logical_and_right_590, label %logical_and_merge_590

logical_and_right_590:
  %t594 = load i1, i1* %l9
  br label %logical_and_right_end_590

logical_and_right_end_590:
  br label %logical_and_merge_590

logical_and_merge_590:
  %t595 = phi i1 [ false, %logical_and_entry_590 ], [ %t594, %logical_and_right_end_590 ]
  br label %logical_and_entry_589

logical_and_entry_589:
  br i1 %t595, label %logical_and_right_589, label %logical_and_merge_589

logical_and_right_589:
  %t596 = load i1, i1* %l10
  br label %logical_and_right_end_589

logical_and_right_end_589:
  br label %logical_and_merge_589

logical_and_merge_589:
  %t597 = phi i1 [ false, %logical_and_entry_589 ], [ %t596, %logical_and_right_end_589 ]
  br label %logical_and_entry_588

logical_and_entry_588:
  br i1 %t597, label %logical_and_right_588, label %logical_and_merge_588

logical_and_right_588:
  %t598 = load i1, i1* %l11
  br label %logical_and_right_end_588

logical_and_right_end_588:
  br label %logical_and_merge_588

logical_and_merge_588:
  %t599 = phi i1 [ false, %logical_and_entry_588 ], [ %t598, %logical_and_right_end_588 ]
  br label %logical_and_entry_587

logical_and_entry_587:
  br i1 %t599, label %logical_and_right_587, label %logical_and_merge_587

logical_and_right_587:
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t601 = load { i8**, i64 }, { i8**, i64 }* %t600
  %t602 = extractvalue { i8**, i64 } %t601, 1
  %t603 = icmp eq i64 %t602, 0
  br label %logical_and_right_end_587

logical_and_right_end_587:
  br label %logical_and_merge_587

logical_and_merge_587:
  %t604 = phi i1 [ false, %logical_and_entry_587 ], [ %t603, %logical_and_right_end_587 ]
  store i1 %t604, i1* %l23
  %t605 = load i8*, i8** %l7
  %t606 = insertvalue %NativeStructLayoutField undef, i8* %t605, 0
  %t607 = load i8*, i8** %l8
  %t608 = insertvalue %NativeStructLayoutField %t606, i8* %t607, 1
  %t609 = load double, double* %l12
  %t610 = insertvalue %NativeStructLayoutField %t608, double %t609, 2
  %t611 = load double, double* %l13
  %t612 = insertvalue %NativeStructLayoutField %t610, double %t611, 3
  %t613 = load double, double* %l14
  %t614 = insertvalue %NativeStructLayoutField %t612, double %t613, 4
  store %NativeStructLayoutField %t614, %NativeStructLayoutField* %l24
  %t615 = load i1, i1* %l23
  %t616 = insertvalue %EnumLayoutPayloadParse undef, i1 %t615, 0
  %t617 = load i8*, i8** %l6
  %t618 = insertvalue %EnumLayoutPayloadParse %t616, i8* %t617, 1
  %t619 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t620 = insertvalue %EnumLayoutPayloadParse %t618, i8* null, 2
  %t621 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t622 = insertvalue %EnumLayoutPayloadParse %t620, { i8**, i64 }* %t621, 3
  ret %EnumLayoutPayloadParse %t622
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
  %t41 = phi i8* [ %t2, %entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t3, %entry ], [ %t40, %loop.latch2 ]
  store i8* %t41, i8** %l0
  store double %t42, double* %l1
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
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 %t31, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8* %t35, i8** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch2
loop.latch2:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t43 = load i8*, i8** %l0
  %t44 = call i8* @trim_text(i8* %t43)
  store i8* %t44, i8** %l0
  %s45 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.45, i32 0, i32 0
  store i8* %s45, i8** %l3
  store i8* null, i8** %l4
  %t46 = load double, double* %l1
  %t47 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t48 = fptosi double %t46 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t48, i64 %t47)
  %t50 = call i8* @trim_text(i8* %t49)
  store i8* %t50, i8** %l5
  %t51 = load i8*, i8** %l5
  %t52 = call i64 @sailfin_runtime_string_length(i8* %t51)
  %t53 = icmp sgt i64 %t52, 0
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load i8*, i8** %l3
  %t57 = load i8*, i8** %l4
  %t58 = load i8*, i8** %l5
  br i1 %t53, label %then8, label %merge9
then8:
  %t59 = load i8*, i8** %l5
  br label %merge9
merge9:
  %t60 = load i8*, i8** %l0
  %t61 = insertvalue %BindingComponents undef, i8* %t60, 0
  %t62 = load i8*, i8** %l3
  %t63 = insertvalue %BindingComponents %t61, i8* %t62, 1
  %t64 = load i8*, i8** %l4
  %t65 = insertvalue %BindingComponents %t63, i8* %t64, 2
  ret %BindingComponents %t65
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
  %t11 = alloca [2 x i8], align 1
  %t12 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  store i8 40, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 1
  store i8 0, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  %t15 = call double @index_of(i8* %t10, i8* %t14)
  store double %t15, double* %l1
  %t16 = load i8*, i8** %l0
  store i8* %t16, i8** %l2
  %t17 = load double, double* %l1
  %t18 = sitofp i64 0 to double
  %t19 = fcmp oge double %t17, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then2, label %merge3
then2:
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = fptosi double %t24 to i64
  %t26 = call i8* @sailfin_runtime_substring(i8* %t23, i64 0, i64 %t25)
  %t27 = call i8* @trim_text(i8* %t26)
  store i8* %t27, i8** %l2
  br label %merge3
merge3:
  %t28 = phi i8* [ %t27, %then2 ], [ %t22, %entry ]
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = alloca [2 x i8], align 1
  %t31 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  store i8 46, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 1
  store i8 0, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  %t34 = call double @last_index_of(i8* %t29, i8* %t33)
  store double %t34, double* %l3
  %t35 = load double, double* %l3
  %t36 = sitofp i64 0 to double
  %t37 = fcmp oge double %t35, %t36
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  br i1 %t37, label %then4, label %merge5
then4:
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  %t46 = load i8*, i8** %l2
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = fptosi double %t45 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t42, i64 %t48, i64 %t47)
  %t50 = call i8* @trim_text(i8* %t49)
  store i8* %t50, i8** %l2
  br label %merge5
merge5:
  %t51 = phi i8* [ %t50, %then4 ], [ %t40, %entry ]
  store i8* %t51, i8** %l2
  %t52 = load i8*, i8** %l2
  %t53 = call i8* @strip_generics(i8* %t52)
  ret i8* %t53
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
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 46, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i1 @starts_with(i8* %t5, i8* %t9)
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t12 = load i8*, i8** %l0
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 59, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call i1 @starts_with(i8* %t12, i8* %t16)
  %t18 = load i8*, i8** %l0
  br i1 %t17, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t19 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t20 = load double, double* %l1
  %t21 = sitofp i64 0 to double
  %t22 = fcmp oge double %t20, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = fptosi double %t26 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %t25, i64 0, i64 %t27)
  %t29 = call i8* @trim_text(i8* %t28)
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %t30)
  %t32 = icmp eq i64 %t31, 0
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t36 = load i8*, i8** %l2
  %s37 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.37, i32 0, i32 0
  %t38 = call i1 @starts_with(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l2
  br i1 %t38, label %then10, label %merge11
then10:
  %t42 = load i8*, i8** %l2
  %s43 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.43, i32 0, i32 0
  %t44 = call i8* @strip_prefix(i8* %t42, i8* %s43)
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l2
  br label %merge11
merge11:
  %t46 = phi i8* [ %t45, %then10 ], [ %t41, %then6 ]
  store i8* %t46, i8** %l2
  %t47 = load i8*, i8** %l2
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp eq i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  br i1 %t49, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t53 = load i8*, i8** %l2
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 32, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = call double @index_of(i8* %t53, i8* %t57)
  %t59 = sitofp i64 0 to double
  %t60 = fcmp oge double %t58, %t59
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  br i1 %t60, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t64 = load i8*, i8** %l2
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 9, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call double @index_of(i8* %t64, i8* %t68)
  %t70 = sitofp i64 0 to double
  %t71 = fcmp oge double %t69, %t70
  %t72 = load i8*, i8** %l0
  %t73 = load double, double* %l1
  %t74 = load i8*, i8** %l2
  br i1 %t71, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t75 = load i8*, i8** %l0
  %t76 = alloca [2 x i8], align 1
  %t77 = getelementptr [2 x i8], [2 x i8]* %t76, i32 0, i32 0
  store i8 61, i8* %t77
  %t78 = getelementptr [2 x i8], [2 x i8]* %t76, i32 0, i32 1
  store i8 0, i8* %t78
  %t79 = getelementptr [2 x i8], [2 x i8]* %t76, i32 0, i32 0
  %t80 = call double @index_of(i8* %t75, i8* %t79)
  store double %t80, double* %l3
  %t81 = load double, double* %l3
  %t82 = sitofp i64 0 to double
  %t83 = fcmp oge double %t81, %t82
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load double, double* %l3
  br i1 %t83, label %then18, label %merge19
then18:
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l3
  %t89 = fptosi double %t88 to i64
  %t90 = call i8* @sailfin_runtime_substring(i8* %t87, i64 0, i64 %t89)
  %t91 = call i8* @trim_text(i8* %t90)
  store i8* %t91, i8** %l4
  %t92 = load i8*, i8** %l4
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = icmp eq i64 %t93, 0
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l3
  %t98 = load i8*, i8** %l4
  br i1 %t94, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t99 = load i8*, i8** %l4
  %s100 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l1
  %t104 = load double, double* %l3
  %t105 = load i8*, i8** %l4
  br i1 %t101, label %then22, label %merge23
then22:
  %t106 = load i8*, i8** %l4
  %s107 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.107, i32 0, i32 0
  %t108 = call i8* @strip_prefix(i8* %t106, i8* %s107)
  %t109 = call i8* @trim_text(i8* %t108)
  store i8* %t109, i8** %l4
  br label %merge23
merge23:
  %t110 = phi i8* [ %t109, %then22 ], [ %t105, %then18 ]
  store i8* %t110, i8** %l4
  %t111 = load i8*, i8** %l4
  %t112 = call i64 @sailfin_runtime_string_length(i8* %t111)
  %t113 = icmp eq i64 %t112, 0
  %t114 = load i8*, i8** %l0
  %t115 = load double, double* %l1
  %t116 = load double, double* %l3
  %t117 = load i8*, i8** %l4
  br i1 %t113, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t118 = load i8*, i8** %l4
  %t119 = alloca [2 x i8], align 1
  %t120 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  store i8 32, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 1
  store i8 0, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  %t123 = call double @index_of(i8* %t118, i8* %t122)
  %t124 = sitofp i64 0 to double
  %t125 = fcmp oge double %t123, %t124
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  %t128 = load double, double* %l3
  %t129 = load i8*, i8** %l4
  br i1 %t125, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t130 = load i8*, i8** %l4
  %t131 = alloca [2 x i8], align 1
  %t132 = getelementptr [2 x i8], [2 x i8]* %t131, i32 0, i32 0
  store i8 9, i8* %t132
  %t133 = getelementptr [2 x i8], [2 x i8]* %t131, i32 0, i32 1
  store i8 0, i8* %t133
  %t134 = getelementptr [2 x i8], [2 x i8]* %t131, i32 0, i32 0
  %t135 = call double @index_of(i8* %t130, i8* %t134)
  %t136 = sitofp i64 0 to double
  %t137 = fcmp oge double %t135, %t136
  %t138 = load i8*, i8** %l0
  %t139 = load double, double* %l1
  %t140 = load double, double* %l3
  %t141 = load i8*, i8** %l4
  br i1 %t137, label %then28, label %merge29
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
  %t245 = phi i8* [ %t10, %entry ], [ %t240, %loop.latch2 ]
  %t246 = phi double [ %t11, %entry ], [ %t241, %loop.latch2 ]
  %t247 = phi i8* [ %t13, %entry ], [ %t242, %loop.latch2 ]
  %t248 = phi double [ %t12, %entry ], [ %t243, %loop.latch2 ]
  %t249 = phi { i8**, i64 }* [ %t9, %entry ], [ %t244, %loop.latch2 ]
  store i8* %t245, i8** %l1
  store double %t246, double* %l2
  store i8* %t247, i8** %l4
  store double %t248, double* %l3
  store { i8**, i64 }* %t249, { i8**, i64 }** %l0
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
  %t41 = alloca [2 x i8], align 1
  %t42 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8 %t40, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 1
  store i8 0, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8* %t44, i8** %l1
  %t45 = load i8, i8* %l5
  %t46 = icmp eq i8 %t45, 92
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  %t52 = load i8, i8* %l5
  br i1 %t46, label %then8, label %merge9
then8:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  %t56 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp olt double %t55, %t57
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load i8*, i8** %l4
  %t64 = load i8, i8* %l5
  br i1 %t58, label %then10, label %merge11
then10:
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = sitofp i64 2 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t69 = phi i8* [ null, %then8 ], [ %t48, %then6 ]
  %t70 = phi double [ %t68, %then8 ], [ %t49, %then6 ]
  store i8* %t69, i8** %l1
  store double %t70, double* %l2
  %t71 = load i8, i8* %l5
  %t72 = load i8*, i8** %l4
  %t73 = getelementptr i8, i8* %t72, i64 0
  %t74 = load i8, i8* %t73
  %t75 = icmp eq i8 %t71, %t74
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load i8*, i8** %l1
  %t78 = load double, double* %l2
  %t79 = load double, double* %l3
  %t80 = load i8*, i8** %l4
  %t81 = load i8, i8* %l5
  br i1 %t75, label %then12, label %merge13
then12:
  %s82 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.82, i32 0, i32 0
  store i8* %s82, i8** %l4
  br label %merge13
merge13:
  %t83 = phi i8* [ %s82, %then12 ], [ %t80, %then6 ]
  store i8* %t83, i8** %l4
  %t84 = load double, double* %l2
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l2
  br label %loop.latch2
merge7:
  %t88 = load i8, i8* %l5
  %t89 = icmp eq i8 %t88, 34
  br label %logical_or_entry_87

logical_or_entry_87:
  br i1 %t89, label %logical_or_merge_87, label %logical_or_right_87

logical_or_right_87:
  %t90 = load i8, i8* %l5
  %t91 = icmp eq i8 %t90, 39
  br label %logical_or_right_end_87

logical_or_right_end_87:
  br label %logical_or_merge_87

logical_or_merge_87:
  %t92 = phi i1 [ true, %logical_or_entry_87 ], [ %t91, %logical_or_right_end_87 ]
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load i8*, i8** %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l3
  %t97 = load i8*, i8** %l4
  %t98 = load i8, i8* %l5
  br i1 %t92, label %then14, label %merge15
then14:
  %t99 = load i8, i8* %l5
  %t100 = alloca [2 x i8], align 1
  %t101 = getelementptr [2 x i8], [2 x i8]* %t100, i32 0, i32 0
  store i8 %t99, i8* %t101
  %t102 = getelementptr [2 x i8], [2 x i8]* %t100, i32 0, i32 1
  store i8 0, i8* %t102
  %t103 = getelementptr [2 x i8], [2 x i8]* %t100, i32 0, i32 0
  store i8* %t103, i8** %l4
  %t104 = load i8*, i8** %l1
  %t105 = load i8, i8* %l5
  %t106 = getelementptr i8, i8* %t104, i64 0
  %t107 = load i8, i8* %t106
  %t108 = add i8 %t107, %t105
  %t109 = alloca [2 x i8], align 1
  %t110 = getelementptr [2 x i8], [2 x i8]* %t109, i32 0, i32 0
  store i8 %t108, i8* %t110
  %t111 = getelementptr [2 x i8], [2 x i8]* %t109, i32 0, i32 1
  store i8 0, i8* %t111
  %t112 = getelementptr [2 x i8], [2 x i8]* %t109, i32 0, i32 0
  store i8* %t112, i8** %l1
  %t113 = load double, double* %l2
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l2
  br label %loop.latch2
merge15:
  %t118 = load i8, i8* %l5
  %t119 = icmp eq i8 %t118, 40
  br label %logical_or_entry_117

logical_or_entry_117:
  br i1 %t119, label %logical_or_merge_117, label %logical_or_right_117

logical_or_right_117:
  %t120 = load i8, i8* %l5
  %t121 = icmp eq i8 %t120, 91
  br label %logical_or_right_end_117

logical_or_right_end_117:
  br label %logical_or_merge_117

logical_or_merge_117:
  %t122 = phi i1 [ true, %logical_or_entry_117 ], [ %t121, %logical_or_right_end_117 ]
  br label %logical_or_entry_116

logical_or_entry_116:
  br i1 %t122, label %logical_or_merge_116, label %logical_or_right_116

logical_or_right_116:
  %t123 = load i8, i8* %l5
  %t124 = icmp eq i8 %t123, 123
  br label %logical_or_right_end_116

logical_or_right_end_116:
  br label %logical_or_merge_116

logical_or_merge_116:
  %t125 = phi i1 [ true, %logical_or_entry_116 ], [ %t124, %logical_or_right_end_116 ]
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load double, double* %l2
  %t129 = load double, double* %l3
  %t130 = load i8*, i8** %l4
  %t131 = load i8, i8* %l5
  br i1 %t125, label %then16, label %merge17
then16:
  %t132 = load double, double* %l3
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l3
  %t135 = load i8*, i8** %l1
  %t136 = load i8, i8* %l5
  %t137 = getelementptr i8, i8* %t135, i64 0
  %t138 = load i8, i8* %t137
  %t139 = add i8 %t138, %t136
  %t140 = alloca [2 x i8], align 1
  %t141 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 0
  store i8 %t139, i8* %t141
  %t142 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 1
  store i8 0, i8* %t142
  %t143 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 0
  store i8* %t143, i8** %l1
  %t144 = load double, double* %l2
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l2
  br label %loop.latch2
merge17:
  %t149 = load i8, i8* %l5
  %t150 = icmp eq i8 %t149, 41
  br label %logical_or_entry_148

logical_or_entry_148:
  br i1 %t150, label %logical_or_merge_148, label %logical_or_right_148

logical_or_right_148:
  %t151 = load i8, i8* %l5
  %t152 = icmp eq i8 %t151, 93
  br label %logical_or_right_end_148

logical_or_right_end_148:
  br label %logical_or_merge_148

logical_or_merge_148:
  %t153 = phi i1 [ true, %logical_or_entry_148 ], [ %t152, %logical_or_right_end_148 ]
  br label %logical_or_entry_147

logical_or_entry_147:
  br i1 %t153, label %logical_or_merge_147, label %logical_or_right_147

logical_or_right_147:
  %t154 = load i8, i8* %l5
  %t155 = icmp eq i8 %t154, 125
  br label %logical_or_right_end_147

logical_or_right_end_147:
  br label %logical_or_merge_147

logical_or_merge_147:
  %t156 = phi i1 [ true, %logical_or_entry_147 ], [ %t155, %logical_or_right_end_147 ]
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  %t160 = load double, double* %l3
  %t161 = load i8*, i8** %l4
  %t162 = load i8, i8* %l5
  br i1 %t156, label %then18, label %merge19
then18:
  %t163 = load double, double* %l3
  %t164 = sitofp i64 0 to double
  %t165 = fcmp ogt double %t163, %t164
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load i8*, i8** %l1
  %t168 = load double, double* %l2
  %t169 = load double, double* %l3
  %t170 = load i8*, i8** %l4
  %t171 = load i8, i8* %l5
  br i1 %t165, label %then20, label %merge21
then20:
  %t172 = load double, double* %l3
  %t173 = sitofp i64 1 to double
  %t174 = fsub double %t172, %t173
  store double %t174, double* %l3
  br label %merge21
merge21:
  %t175 = phi double [ %t174, %then20 ], [ %t169, %then18 ]
  store double %t175, double* %l3
  %t176 = load i8*, i8** %l1
  %t177 = load i8, i8* %l5
  %t178 = getelementptr i8, i8* %t176, i64 0
  %t179 = load i8, i8* %t178
  %t180 = add i8 %t179, %t177
  %t181 = alloca [2 x i8], align 1
  %t182 = getelementptr [2 x i8], [2 x i8]* %t181, i32 0, i32 0
  store i8 %t180, i8* %t182
  %t183 = getelementptr [2 x i8], [2 x i8]* %t181, i32 0, i32 1
  store i8 0, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t181, i32 0, i32 0
  store i8* %t184, i8** %l1
  %t185 = load double, double* %l2
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  store double %t187, double* %l2
  br label %loop.latch2
merge19:
  %t188 = load i8, i8* %l5
  %t189 = icmp eq i8 %t188, 44
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load i8*, i8** %l1
  %t192 = load double, double* %l2
  %t193 = load double, double* %l3
  %t194 = load i8*, i8** %l4
  %t195 = load i8, i8* %l5
  br i1 %t189, label %then22, label %merge23
then22:
  %t196 = load double, double* %l3
  %t197 = sitofp i64 0 to double
  %t198 = fcmp oeq double %t196, %t197
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t200 = load i8*, i8** %l1
  %t201 = load double, double* %l2
  %t202 = load double, double* %l3
  %t203 = load i8*, i8** %l4
  %t204 = load i8, i8* %l5
  br i1 %t198, label %then24, label %merge25
then24:
  %t205 = load i8*, i8** %l1
  %t206 = call i8* @trim_text(i8* %t205)
  store i8* %t206, i8** %l6
  %t207 = load i8*, i8** %l6
  %t208 = call i64 @sailfin_runtime_string_length(i8* %t207)
  %t209 = icmp sgt i64 %t208, 0
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l2
  %t213 = load double, double* %l3
  %t214 = load i8*, i8** %l4
  %t215 = load i8, i8* %l5
  %t216 = load i8*, i8** %l6
  br i1 %t209, label %then26, label %merge27
then26:
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l6
  %t219 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t217, i8* %t218)
  store { i8**, i64 }* %t219, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t220 = phi { i8**, i64 }* [ %t219, %then26 ], [ %t210, %then24 ]
  store { i8**, i64 }* %t220, { i8**, i64 }** %l0
  %s221 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.221, i32 0, i32 0
  store i8* %s221, i8** %l1
  %t222 = load double, double* %l2
  %t223 = sitofp i64 1 to double
  %t224 = fadd double %t222, %t223
  store double %t224, double* %l2
  br label %loop.latch2
merge25:
  br label %merge23
merge23:
  %t225 = phi { i8**, i64 }* [ %t219, %then22 ], [ %t190, %loop.body1 ]
  %t226 = phi i8* [ %s221, %then22 ], [ %t191, %loop.body1 ]
  %t227 = phi double [ %t224, %then22 ], [ %t192, %loop.body1 ]
  store { i8**, i64 }* %t225, { i8**, i64 }** %l0
  store i8* %t226, i8** %l1
  store double %t227, double* %l2
  %t228 = load i8*, i8** %l1
  %t229 = load i8, i8* %l5
  %t230 = getelementptr i8, i8* %t228, i64 0
  %t231 = load i8, i8* %t230
  %t232 = add i8 %t231, %t229
  %t233 = alloca [2 x i8], align 1
  %t234 = getelementptr [2 x i8], [2 x i8]* %t233, i32 0, i32 0
  store i8 %t232, i8* %t234
  %t235 = getelementptr [2 x i8], [2 x i8]* %t233, i32 0, i32 1
  store i8 0, i8* %t235
  %t236 = getelementptr [2 x i8], [2 x i8]* %t233, i32 0, i32 0
  store i8* %t236, i8** %l1
  %t237 = load double, double* %l2
  %t238 = sitofp i64 1 to double
  %t239 = fadd double %t237, %t238
  store double %t239, double* %l2
  br label %loop.latch2
loop.latch2:
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  %t242 = load i8*, i8** %l4
  %t243 = load double, double* %l3
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t250 = load i8*, i8** %l1
  %t251 = call i8* @trim_text(i8* %t250)
  store i8* %t251, i8** %l7
  %t252 = load i8*, i8** %l7
  %t253 = call i64 @sailfin_runtime_string_length(i8* %t252)
  %t254 = icmp sgt i64 %t253, 0
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t256 = load i8*, i8** %l1
  %t257 = load double, double* %l2
  %t258 = load double, double* %l3
  %t259 = load i8*, i8** %l4
  %t260 = load i8*, i8** %l7
  br i1 %t254, label %then28, label %merge29
then28:
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load i8*, i8** %l7
  %t263 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t261, i8* %t262)
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t264 = phi { i8**, i64 }* [ %t263, %then28 ], [ %t255, %entry ]
  store { i8**, i64 }* %t264, { i8**, i64 }** %l0
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t265
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
  %t48 = phi { i8**, i64 }* [ %t7, %entry ], [ %t45, %loop.latch2 ]
  %t49 = phi i8* [ %t8, %entry ], [ %t46, %loop.latch2 ]
  %t50 = phi double [ %t9, %entry ], [ %t47, %loop.latch2 ]
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  store i8* %t49, i8** %l1
  store double %t50, double* %l2
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
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 %t35, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8* %t39, i8** %l1
  br label %merge8
merge8:
  %t40 = phi { i8**, i64 }* [ %t29, %then6 ], [ %t23, %else7 ]
  %t41 = phi i8* [ %s30, %then6 ], [ %t39, %else7 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store i8* %t41, i8** %l1
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l2
  br label %loop.latch2
loop.latch2:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t51, i8* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t54
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
  %t49 = phi { i8**, i64 }* [ %t7, %entry ], [ %t46, %loop.latch2 ]
  %t50 = phi i8* [ %t8, %entry ], [ %t47, %loop.latch2 ]
  %t51 = phi double [ %t9, %entry ], [ %t48, %loop.latch2 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store i8* %t50, i8** %l1
  store double %t51, double* %l2
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
  %t37 = alloca [2 x i8], align 1
  %t38 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  store i8 %t36, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 1
  store i8 0, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  store i8* %t40, i8** %l1
  br label %merge8
merge8:
  %t41 = phi { i8**, i64 }* [ %t30, %then6 ], [ %t23, %else7 ]
  %t42 = phi i8* [ %s31, %then6 ], [ %t40, %else7 ]
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  store i8* %t42, i8** %l1
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l2
  br label %loop.latch2
loop.latch2:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t52 = load i8*, i8** %l1
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp sgt i64 %t53, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  br i1 %t54, label %then9, label %merge10
then9:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = call i8* @trim_text(i8* %t59)
  %t61 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t62 = phi { i8**, i64 }* [ %t61, %then9 ], [ %t55, %entry ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  %t63 = alloca [0 x i8*]
  %t64 = getelementptr [0 x i8*], [0 x i8*]* %t63, i32 0, i32 0
  %t65 = alloca { i8**, i64 }
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t64, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 0, i64* %t67
  store { i8**, i64 }* %t65, { i8**, i64 }** %l4
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l2
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t109 = phi { i8**, i64 }* [ %t72, %entry ], [ %t107, %loop.latch13 ]
  %t110 = phi double [ %t71, %entry ], [ %t108, %loop.latch13 ]
  store { i8**, i64 }* %t109, { i8**, i64 }** %l4
  store double %t110, double* %l2
  br label %loop.body12
loop.body12:
  %t73 = load double, double* %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load { i8**, i64 }, { i8**, i64 }* %t74
  %t76 = extractvalue { i8**, i64 } %t75, 1
  %t77 = sitofp i64 %t76 to double
  %t78 = fcmp oge double %t73, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t78, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load double, double* %l2
  %t85 = fptosi double %t84 to i64
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t83
  %t87 = extractvalue { i8**, i64 } %t86, 0
  %t88 = extractvalue { i8**, i64 } %t86, 1
  %t89 = icmp uge i64 %t85, %t88
  ; bounds check: %t89 (if true, out of bounds)
  %t90 = getelementptr i8*, i8** %t87, i64 %t85
  %t91 = load i8*, i8** %t90
  store i8* %t91, i8** %l5
  %t92 = load i8*, i8** %l5
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = icmp sgt i64 %t93, 0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t99 = load i8*, i8** %l5
  br i1 %t94, label %then17, label %merge18
then17:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t101 = load i8*, i8** %l5
  %t102 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* %t101)
  store { i8**, i64 }* %t102, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t103 = phi { i8**, i64 }* [ %t102, %then17 ], [ %t98, %loop.body12 ]
  store { i8**, i64 }* %t103, { i8**, i64 }** %l4
  %t104 = load double, double* %l2
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l2
  br label %loop.latch13
loop.latch13:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t108 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t111
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
  %t41 = phi i8* [ %t3, %entry ], [ %t39, %loop.latch2 ]
  %t42 = phi double [ %t5, %entry ], [ %t40, %loop.latch2 ]
  store i8* %t41, i8** %l0
  store double %t42, double* %l2
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
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t30, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8* %t34, i8** %l0
  br label %merge7
merge7:
  %t35 = phi i8* [ %t34, %then6 ], [ %t22, %loop.body1 ]
  store i8* %t35, i8** %l0
  %t36 = load double, double* %l2
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l2
  br label %loop.latch2
loop.latch2:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t43 = load i8*, i8** %l0
  %t44 = call i8* @trim_text(i8* %t43)
  ret i8* %t44
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
  %t27 = phi double [ %t3, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
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
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i1 @is_trim_char(i8* %t18)
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t44 = phi double [ %t29, %entry ], [ %t43, %loop.latch10 ]
  store double %t44, double* %l1
  br label %loop.body9
loop.body9:
  %t30 = load double, double* %l1
  %t31 = load double, double* %l0
  %t32 = fcmp ole double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br i1 %t32, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t35 = load double, double* %l3
  %t36 = call i1 @is_trim_char(i8* null)
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l3
  br i1 %t36, label %then14, label %merge15
then14:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fsub double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t43 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t46 = load double, double* %l0
  %t47 = sitofp i64 0 to double
  %t48 = fcmp oeq double %t46, %t47
  br label %logical_and_entry_45

logical_and_entry_45:
  br i1 %t48, label %logical_and_right_45, label %logical_and_merge_45

logical_and_right_45:
  %t49 = load double, double* %l1
  %t50 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t51 = sitofp i64 %t50 to double
  %t52 = fcmp oeq double %t49, %t51
  br label %logical_and_right_end_45

logical_and_right_end_45:
  br label %logical_and_merge_45

logical_and_merge_45:
  %t53 = phi i1 [ false, %logical_and_entry_45 ], [ %t52, %logical_and_right_end_45 ]
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  br i1 %t53, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t56 = load double, double* %l0
  %t57 = load double, double* %l1
  %t58 = fptosi double %t56 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t58, i64 %t59)
  ret i8* %t60
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
  %t600 = phi double [ %t21, %entry ], [ %t596, %loop.latch2 ]
  %t601 = phi { i8**, i64 }* [ %t18, %entry ], [ %t597, %loop.latch2 ]
  %t602 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t598, %loop.latch2 ]
  %t603 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t599, %loop.latch2 ]
  store double %t600, double* %l4
  store { i8**, i64 }* %t601, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t602, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t603, { %NativeEnum*, i64 }** %l3
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
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 59, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* %t57, i8* %t61)
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t66 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t67 = load double, double* %l4
  %t68 = load i8*, i8** %l5
  %t69 = load i8*, i8** %l6
  br i1 %t62, label %then8, label %merge9
then8:
  %t70 = load double, double* %l4
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l4
  br label %loop.latch2
merge9:
  %t73 = load i8*, i8** %l6
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.74, i32 0, i32 0
  %t75 = call i1 @starts_with(i8* %t73, i8* %s74)
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t79 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t80 = load double, double* %l4
  %t81 = load i8*, i8** %l5
  %t82 = load i8*, i8** %l6
  br i1 %t75, label %then10, label %merge11
then10:
  %t83 = load double, double* %l4
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l4
  br label %loop.latch2
merge11:
  %t86 = load i8*, i8** %l6
  %s87 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.87, i32 0, i32 0
  %t88 = call i1 @starts_with(i8* %t86, i8* %s87)
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t92 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t93 = load double, double* %l4
  %t94 = load i8*, i8** %l5
  %t95 = load i8*, i8** %l6
  br i1 %t88, label %then12, label %merge13
then12:
  %t96 = load i8*, i8** %l6
  %s97 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.97, i32 0, i32 0
  %t98 = call i8* @strip_prefix(i8* %t96, i8* %s97)
  store i8* %t98, i8** %l7
  %t99 = load i8*, i8** %l7
  %s100 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i8* @strip_prefix(i8* %t99, i8* %s100)
  store i8* %t101, i8** %l8
  %t102 = load i8*, i8** %l8
  %t103 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t102)
  store %StructLayoutHeaderParse %t103, %StructLayoutHeaderParse* %l9
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t106 = extractvalue %StructLayoutHeaderParse %t105, 4
  %t107 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t104, { i8**, i64 }* %t106)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l1
  %t108 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t109 = extractvalue %StructLayoutHeaderParse %t108, 0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l5
  %t116 = load i8*, i8** %l6
  %t117 = load i8*, i8** %l7
  %t118 = load i8*, i8** %l8
  %t119 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t109, label %then14, label %merge15
then14:
  %t120 = alloca [0 x %NativeStructLayoutField]
  %t121 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t120, i32 0, i32 0
  %t122 = alloca { %NativeStructLayoutField*, i64 }
  %t123 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t122, i32 0, i32 0
  store %NativeStructLayoutField* %t121, %NativeStructLayoutField** %t123
  %t124 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t122, i32 0, i32 1
  store i64 0, i64* %t124
  store { %NativeStructLayoutField*, i64 }* %t122, { %NativeStructLayoutField*, i64 }** %l10
  %t125 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t126 = extractvalue %StructLayoutHeaderParse %t125, 1
  store i8* %t126, i8** %l11
  %t127 = load double, double* %l4
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l4
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t133 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t134 = load double, double* %l4
  %t135 = load i8*, i8** %l5
  %t136 = load i8*, i8** %l6
  %t137 = load i8*, i8** %l7
  %t138 = load i8*, i8** %l8
  %t139 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t140 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t141 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t246 = phi i8* [ %t137, %then14 ], [ %t242, %loop.latch18 ]
  %t247 = phi { i8**, i64 }* [ %t131, %then14 ], [ %t243, %loop.latch18 ]
  %t248 = phi { %NativeStructLayoutField*, i64 }* [ %t140, %then14 ], [ %t244, %loop.latch18 ]
  %t249 = phi double [ %t134, %then14 ], [ %t245, %loop.latch18 ]
  store i8* %t246, i8** %l7
  store { i8**, i64 }* %t247, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t248, { %NativeStructLayoutField*, i64 }** %l10
  store double %t249, double* %l4
  br label %loop.body17
loop.body17:
  %t142 = load double, double* %l4
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load { i8**, i64 }, { i8**, i64 }* %t143
  %t145 = extractvalue { i8**, i64 } %t144, 1
  %t146 = sitofp i64 %t145 to double
  %t147 = fcmp oge double %t142, %t146
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t151 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t152 = load double, double* %l4
  %t153 = load i8*, i8** %l5
  %t154 = load i8*, i8** %l6
  %t155 = load i8*, i8** %l7
  %t156 = load i8*, i8** %l8
  %t157 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t158 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t159 = load i8*, i8** %l11
  br i1 %t147, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load double, double* %l4
  %t162 = fptosi double %t161 to i64
  %t163 = load { i8**, i64 }, { i8**, i64 }* %t160
  %t164 = extractvalue { i8**, i64 } %t163, 0
  %t165 = extractvalue { i8**, i64 } %t163, 1
  %t166 = icmp uge i64 %t162, %t165
  ; bounds check: %t166 (if true, out of bounds)
  %t167 = getelementptr i8*, i8** %t164, i64 %t162
  %t168 = load i8*, i8** %t167
  %t169 = call i8* @trim_text(i8* %t168)
  store i8* %t169, i8** %l12
  %t170 = load i8*, i8** %l12
  %t171 = call i64 @sailfin_runtime_string_length(i8* %t170)
  %t172 = icmp eq i64 %t171, 0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t176 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t177 = load double, double* %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i8*, i8** %l6
  %t180 = load i8*, i8** %l7
  %t181 = load i8*, i8** %l8
  %t182 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t183 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t184 = load i8*, i8** %l11
  %t185 = load i8*, i8** %l12
  br i1 %t172, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t186 = load i8*, i8** %l12
  %s187 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.187, i32 0, i32 0
  %t188 = call i1 @starts_with(i8* %t186, i8* %s187)
  %t189 = xor i1 %t188, 1
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t192 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t193 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t194 = load double, double* %l4
  %t195 = load i8*, i8** %l5
  %t196 = load i8*, i8** %l6
  %t197 = load i8*, i8** %l7
  %t198 = load i8*, i8** %l8
  %t199 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t200 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t201 = load i8*, i8** %l11
  %t202 = load i8*, i8** %l12
  br i1 %t189, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t203 = load i8*, i8** %l12
  %s204 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.204, i32 0, i32 0
  %t205 = call i8* @strip_prefix(i8* %t203, i8* %s204)
  store i8* %t205, i8** %l13
  %t206 = load i8*, i8** %l7
  %s207 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.207, i32 0, i32 0
  %t208 = call i8* @strip_prefix(i8* %t206, i8* %s207)
  store i8* %t208, i8** %l14
  %t209 = load i8*, i8** %l14
  %t210 = load i8*, i8** %l11
  %t211 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t209, i8* %t210)
  store %StructLayoutFieldParse %t211, %StructLayoutFieldParse* %l15
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t214 = extractvalue %StructLayoutFieldParse %t213, 2
  %t215 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t212, { i8**, i64 }* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l1
  %t216 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t217 = extractvalue %StructLayoutFieldParse %t216, 0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t221 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t222 = load double, double* %l4
  %t223 = load i8*, i8** %l5
  %t224 = load i8*, i8** %l6
  %t225 = load i8*, i8** %l7
  %t226 = load i8*, i8** %l8
  %t227 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t228 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t229 = load i8*, i8** %l11
  %t230 = load i8*, i8** %l12
  %t231 = load i8*, i8** %l13
  %t232 = load i8*, i8** %l14
  %t233 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t217, label %then26, label %merge27
then26:
  %t234 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t235 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t236 = extractvalue %StructLayoutFieldParse %t235, 1
  %t237 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t234, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t237, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t238 = phi { %NativeStructLayoutField*, i64 }* [ %t237, %then26 ], [ %t228, %loop.body17 ]
  store { %NativeStructLayoutField*, i64 }* %t238, { %NativeStructLayoutField*, i64 }** %l10
  %t239 = load double, double* %l4
  %t240 = sitofp i64 1 to double
  %t241 = fadd double %t239, %t240
  store double %t241, double* %l4
  br label %loop.latch18
loop.latch18:
  %t242 = load i8*, i8** %l7
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t245 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t250 = load i8*, i8** %l11
  %t251 = insertvalue %NativeStruct undef, i8* %t250, 0
  %t252 = alloca [0 x i8*]
  %t253 = getelementptr [0 x i8*], [0 x i8*]* %t252, i32 0, i32 0
  %t254 = alloca { i8**, i64 }
  %t255 = getelementptr { i8**, i64 }, { i8**, i64 }* %t254, i32 0, i32 0
  store i8** %t253, i8*** %t255
  %t256 = getelementptr { i8**, i64 }, { i8**, i64 }* %t254, i32 0, i32 1
  store i64 0, i64* %t256
  %t257 = insertvalue %NativeStruct %t251, { i8**, i64 }* %t254, 1
  %t258 = alloca [0 x i8*]
  %t259 = getelementptr [0 x i8*], [0 x i8*]* %t258, i32 0, i32 0
  %t260 = alloca { i8**, i64 }
  %t261 = getelementptr { i8**, i64 }, { i8**, i64 }* %t260, i32 0, i32 0
  store i8** %t259, i8*** %t261
  %t262 = getelementptr { i8**, i64 }, { i8**, i64 }* %t260, i32 0, i32 1
  store i64 0, i64* %t262
  %t263 = insertvalue %NativeStruct %t257, { i8**, i64 }* %t260, 2
  %t264 = alloca [0 x i8*]
  %t265 = getelementptr [0 x i8*], [0 x i8*]* %t264, i32 0, i32 0
  %t266 = alloca { i8**, i64 }
  %t267 = getelementptr { i8**, i64 }, { i8**, i64 }* %t266, i32 0, i32 0
  store i8** %t265, i8*** %t267
  %t268 = getelementptr { i8**, i64 }, { i8**, i64 }* %t266, i32 0, i32 1
  store i64 0, i64* %t268
  %t269 = insertvalue %NativeStruct %t263, { i8**, i64 }* %t266, 3
  %t270 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t271 = extractvalue %StructLayoutHeaderParse %t270, 2
  %t272 = insertvalue %NativeStructLayout undef, double %t271, 0
  %t273 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t274 = extractvalue %StructLayoutHeaderParse %t273, 3
  %t275 = insertvalue %NativeStructLayout %t272, double %t274, 1
  %t276 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t277 = bitcast { %NativeStructLayoutField*, i64 }* %t276 to { i8**, i64 }*
  %t278 = insertvalue %NativeStructLayout %t275, { i8**, i64 }* %t277, 2
  %t279 = insertvalue %NativeStruct %t269, i8* null, 4
  store %NativeStruct %t279, %NativeStruct* %l16
  %t280 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t281 = load %NativeStruct, %NativeStruct* %l16
  %t282 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t280, %NativeStruct %t281)
  store { %NativeStruct*, i64 }* %t282, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t283 = phi double [ %t129, %then14 ], [ %t114, %then12 ]
  %t284 = phi i8* [ %t205, %then14 ], [ %t117, %then12 ]
  %t285 = phi { i8**, i64 }* [ %t215, %then14 ], [ %t111, %then12 ]
  %t286 = phi double [ %t241, %then14 ], [ %t114, %then12 ]
  %t287 = phi { %NativeStruct*, i64 }* [ %t282, %then14 ], [ %t112, %then12 ]
  store double %t283, double* %l4
  store i8* %t284, i8** %l7
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  store double %t286, double* %l4
  store { %NativeStruct*, i64 }* %t287, { %NativeStruct*, i64 }** %l2
  %t288 = load double, double* %l4
  %t289 = sitofp i64 1 to double
  %t290 = fadd double %t288, %t289
  store double %t290, double* %l4
  br label %loop.latch2
merge13:
  %t291 = load i8*, i8** %l6
  %s292 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.292, i32 0, i32 0
  %t293 = call i1 @starts_with(i8* %t291, i8* %s292)
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t297 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t298 = load double, double* %l4
  %t299 = load i8*, i8** %l5
  %t300 = load i8*, i8** %l6
  br i1 %t293, label %then28, label %merge29
then28:
  %t301 = load i8*, i8** %l6
  %s302 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.302, i32 0, i32 0
  %t303 = call i8* @strip_prefix(i8* %t301, i8* %s302)
  store i8* %t303, i8** %l17
  %t304 = load i8*, i8** %l17
  %s305 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.305, i32 0, i32 0
  %t306 = call i8* @strip_prefix(i8* %t304, i8* %s305)
  store i8* %t306, i8** %l18
  %t307 = load i8*, i8** %l18
  %t308 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t307)
  store %EnumLayoutHeaderParse %t308, %EnumLayoutHeaderParse* %l19
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t311 = extractvalue %EnumLayoutHeaderParse %t310, 7
  %t312 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t309, { i8**, i64 }* %t311)
  store { i8**, i64 }* %t312, { i8**, i64 }** %l1
  %t313 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t314 = extractvalue %EnumLayoutHeaderParse %t313, 0
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t317 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t318 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t319 = load double, double* %l4
  %t320 = load i8*, i8** %l5
  %t321 = load i8*, i8** %l6
  %t322 = load i8*, i8** %l17
  %t323 = load i8*, i8** %l18
  %t324 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t314, label %then30, label %else31
then30:
  %t325 = alloca [0 x %NativeEnumVariantLayout]
  %t326 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t325, i32 0, i32 0
  %t327 = alloca { %NativeEnumVariantLayout*, i64 }
  %t328 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t327, i32 0, i32 0
  store %NativeEnumVariantLayout* %t326, %NativeEnumVariantLayout** %t328
  %t329 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t327, i32 0, i32 1
  store i64 0, i64* %t329
  store { %NativeEnumVariantLayout*, i64 }* %t327, { %NativeEnumVariantLayout*, i64 }** %l20
  %t330 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t331 = extractvalue %EnumLayoutHeaderParse %t330, 1
  store i8* %t331, i8** %l21
  %t332 = load double, double* %l4
  %t333 = sitofp i64 1 to double
  %t334 = fadd double %t332, %t333
  store double %t334, double* %l4
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t337 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t338 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t339 = load double, double* %l4
  %t340 = load i8*, i8** %l5
  %t341 = load i8*, i8** %l6
  %t342 = load i8*, i8** %l17
  %t343 = load i8*, i8** %l18
  %t344 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t345 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t346 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t552 = phi double [ %t339, %then30 ], [ %t548, %loop.latch35 ]
  %t553 = phi i8* [ %t342, %then30 ], [ %t549, %loop.latch35 ]
  %t554 = phi { i8**, i64 }* [ %t336, %then30 ], [ %t550, %loop.latch35 ]
  %t555 = phi { %NativeEnumVariantLayout*, i64 }* [ %t345, %then30 ], [ %t551, %loop.latch35 ]
  store double %t552, double* %l4
  store i8* %t553, i8** %l17
  store { i8**, i64 }* %t554, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t555, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t347 = load double, double* %l4
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t349 = load { i8**, i64 }, { i8**, i64 }* %t348
  %t350 = extractvalue { i8**, i64 } %t349, 1
  %t351 = sitofp i64 %t350 to double
  %t352 = fcmp oge double %t347, %t351
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t355 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t356 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t357 = load double, double* %l4
  %t358 = load i8*, i8** %l5
  %t359 = load i8*, i8** %l6
  %t360 = load i8*, i8** %l17
  %t361 = load i8*, i8** %l18
  %t362 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t363 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t364 = load i8*, i8** %l21
  br i1 %t352, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load double, double* %l4
  %t367 = fptosi double %t366 to i64
  %t368 = load { i8**, i64 }, { i8**, i64 }* %t365
  %t369 = extractvalue { i8**, i64 } %t368, 0
  %t370 = extractvalue { i8**, i64 } %t368, 1
  %t371 = icmp uge i64 %t367, %t370
  ; bounds check: %t371 (if true, out of bounds)
  %t372 = getelementptr i8*, i8** %t369, i64 %t367
  %t373 = load i8*, i8** %t372
  %t374 = call i8* @trim_text(i8* %t373)
  store i8* %t374, i8** %l22
  %t375 = load i8*, i8** %l22
  %t376 = call i64 @sailfin_runtime_string_length(i8* %t375)
  %t377 = icmp eq i64 %t376, 0
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t381 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t382 = load double, double* %l4
  %t383 = load i8*, i8** %l5
  %t384 = load i8*, i8** %l6
  %t385 = load i8*, i8** %l17
  %t386 = load i8*, i8** %l18
  %t387 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t388 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t389 = load i8*, i8** %l21
  %t390 = load i8*, i8** %l22
  br i1 %t377, label %then39, label %merge40
then39:
  %t391 = load double, double* %l4
  %t392 = sitofp i64 1 to double
  %t393 = fadd double %t391, %t392
  store double %t393, double* %l4
  br label %afterloop36
merge40:
  %t395 = load i8*, i8** %l22
  %s396 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.396, i32 0, i32 0
  %t397 = call i1 @starts_with(i8* %t395, i8* %s396)
  br label %logical_and_entry_394

logical_and_entry_394:
  br i1 %t397, label %logical_and_right_394, label %logical_and_merge_394

logical_and_right_394:
  %t398 = load i8*, i8** %l22
  %s399 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.399, i32 0, i32 0
  %t400 = call i1 @starts_with(i8* %t398, i8* %s399)
  %t401 = xor i1 %t400, 1
  br label %logical_and_right_end_394

logical_and_right_end_394:
  br label %logical_and_merge_394

logical_and_merge_394:
  %t402 = phi i1 [ false, %logical_and_entry_394 ], [ %t401, %logical_and_right_end_394 ]
  %t403 = xor i1 %t402, 1
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t407 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t408 = load double, double* %l4
  %t409 = load i8*, i8** %l5
  %t410 = load i8*, i8** %l6
  %t411 = load i8*, i8** %l17
  %t412 = load i8*, i8** %l18
  %t413 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t414 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t415 = load i8*, i8** %l21
  %t416 = load i8*, i8** %l22
  br i1 %t403, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t417 = load i8*, i8** %l22
  %s418 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.418, i32 0, i32 0
  %t419 = call i1 @starts_with(i8* %t417, i8* %s418)
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t422 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t423 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t424 = load double, double* %l4
  %t425 = load i8*, i8** %l5
  %t426 = load i8*, i8** %l6
  %t427 = load i8*, i8** %l17
  %t428 = load i8*, i8** %l18
  %t429 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t430 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t431 = load i8*, i8** %l21
  %t432 = load i8*, i8** %l22
  br i1 %t419, label %then43, label %else44
then43:
  %t433 = load i8*, i8** %l22
  %s434 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.434, i32 0, i32 0
  %t435 = call i8* @strip_prefix(i8* %t433, i8* %s434)
  store i8* %t435, i8** %l23
  %t436 = load i8*, i8** %l17
  %s437 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.437, i32 0, i32 0
  %t438 = call i8* @strip_prefix(i8* %t436, i8* %s437)
  store i8* %t438, i8** %l24
  %t439 = load i8*, i8** %l24
  %t440 = load i8*, i8** %l21
  %t441 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t439, i8* %t440)
  store %EnumLayoutVariantParse %t441, %EnumLayoutVariantParse* %l25
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t443 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t444 = extractvalue %EnumLayoutVariantParse %t443, 2
  %t445 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t442, { i8**, i64 }* %t444)
  store { i8**, i64 }* %t445, { i8**, i64 }** %l1
  %t446 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t447 = extractvalue %EnumLayoutVariantParse %t446, 0
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t450 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t451 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t452 = load double, double* %l4
  %t453 = load i8*, i8** %l5
  %t454 = load i8*, i8** %l6
  %t455 = load i8*, i8** %l17
  %t456 = load i8*, i8** %l18
  %t457 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t458 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t459 = load i8*, i8** %l21
  %t460 = load i8*, i8** %l22
  %t461 = load i8*, i8** %l23
  %t462 = load i8*, i8** %l24
  %t463 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t447, label %then46, label %merge47
then46:
  %t464 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t465 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t466 = extractvalue %EnumLayoutVariantParse %t465, 1
  %t467 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t464, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t467, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t468 = phi { %NativeEnumVariantLayout*, i64 }* [ %t467, %then46 ], [ %t458, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t468, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t469 = load i8*, i8** %l22
  %s470 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.470, i32 0, i32 0
  %t471 = call i1 @starts_with(i8* %t469, i8* %s470)
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t474 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t475 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t476 = load double, double* %l4
  %t477 = load i8*, i8** %l5
  %t478 = load i8*, i8** %l6
  %t479 = load i8*, i8** %l17
  %t480 = load i8*, i8** %l18
  %t481 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t482 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t483 = load i8*, i8** %l21
  %t484 = load i8*, i8** %l22
  br i1 %t471, label %then48, label %merge49
then48:
  %t485 = load i8*, i8** %l22
  %s486 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.486, i32 0, i32 0
  %t487 = call i8* @strip_prefix(i8* %t485, i8* %s486)
  store i8* %t487, i8** %l26
  %t488 = load i8*, i8** %l17
  %s489 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.489, i32 0, i32 0
  %t490 = call i8* @strip_prefix(i8* %t488, i8* %s489)
  store i8* %t490, i8** %l27
  %t491 = load i8*, i8** %l27
  %t492 = load i8*, i8** %l21
  %t493 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t491, i8* %t492)
  store %EnumLayoutPayloadParse %t493, %EnumLayoutPayloadParse* %l28
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t495 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t496 = extractvalue %EnumLayoutPayloadParse %t495, 3
  %t497 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t494, { i8**, i64 }* %t496)
  store { i8**, i64 }* %t497, { i8**, i64 }** %l1
  %t499 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t500 = extractvalue %EnumLayoutPayloadParse %t499, 0
  br label %logical_and_entry_498

logical_and_entry_498:
  br i1 %t500, label %logical_and_right_498, label %logical_and_merge_498

logical_and_right_498:
  %t501 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t502 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t501
  %t503 = extractvalue { %NativeEnumVariantLayout*, i64 } %t502, 1
  %t504 = icmp sgt i64 %t503, 0
  br label %logical_and_right_end_498

logical_and_right_end_498:
  br label %logical_and_merge_498

logical_and_merge_498:
  %t505 = phi i1 [ false, %logical_and_entry_498 ], [ %t504, %logical_and_right_end_498 ]
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t508 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t509 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t510 = load double, double* %l4
  %t511 = load i8*, i8** %l5
  %t512 = load i8*, i8** %l6
  %t513 = load i8*, i8** %l17
  %t514 = load i8*, i8** %l18
  %t515 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t516 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t517 = load i8*, i8** %l21
  %t518 = load i8*, i8** %l22
  %t519 = load i8*, i8** %l26
  %t520 = load i8*, i8** %l27
  %t521 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t505, label %then50, label %merge51
then50:
  %t522 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t523 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t522
  %t524 = extractvalue { %NativeEnumVariantLayout*, i64 } %t523, 1
  %t525 = sub i64 %t524, 1
  store i64 %t525, i64* %l29
  %t526 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t527 = load i64, i64* %l29
  %t528 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t526
  %t529 = extractvalue { %NativeEnumVariantLayout*, i64 } %t528, 0
  %t530 = extractvalue { %NativeEnumVariantLayout*, i64 } %t528, 1
  %t531 = icmp uge i64 %t527, %t530
  ; bounds check: %t531 (if true, out of bounds)
  %t532 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t529, i64 %t527
  %t533 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t532
  store %NativeEnumVariantLayout %t533, %NativeEnumVariantLayout* %l30
  %t534 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t535 = extractvalue %NativeEnumVariantLayout %t534, 5
  %t536 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t537 = extractvalue %EnumLayoutPayloadParse %t536, 2
  %t538 = bitcast { i8**, i64 }* %t535 to { %NativeStructLayoutField*, i64 }*
  %t539 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t538, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t539, { %NativeStructLayoutField*, i64 }** %l31
  br label %merge51
merge51:
  br label %merge49
merge49:
  %t540 = phi i8* [ %t487, %then48 ], [ %t479, %else44 ]
  %t541 = phi { i8**, i64 }* [ %t497, %then48 ], [ %t473, %else44 ]
  store i8* %t540, i8** %l17
  store { i8**, i64 }* %t541, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t542 = phi i8* [ %t435, %then43 ], [ %t487, %else44 ]
  %t543 = phi { i8**, i64 }* [ %t445, %then43 ], [ %t497, %else44 ]
  %t544 = phi { %NativeEnumVariantLayout*, i64 }* [ %t467, %then43 ], [ %t430, %else44 ]
  store i8* %t542, i8** %l17
  store { i8**, i64 }* %t543, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t544, { %NativeEnumVariantLayout*, i64 }** %l20
  %t545 = load double, double* %l4
  %t546 = sitofp i64 1 to double
  %t547 = fadd double %t545, %t546
  store double %t547, double* %l4
  br label %loop.latch35
loop.latch35:
  %t548 = load double, double* %l4
  %t549 = load i8*, i8** %l17
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t551 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t556 = load i8*, i8** %l21
  %t557 = insertvalue %NativeEnum undef, i8* %t556, 0
  %t558 = alloca [0 x i8*]
  %t559 = getelementptr [0 x i8*], [0 x i8*]* %t558, i32 0, i32 0
  %t560 = alloca { i8**, i64 }
  %t561 = getelementptr { i8**, i64 }, { i8**, i64 }* %t560, i32 0, i32 0
  store i8** %t559, i8*** %t561
  %t562 = getelementptr { i8**, i64 }, { i8**, i64 }* %t560, i32 0, i32 1
  store i64 0, i64* %t562
  %t563 = insertvalue %NativeEnum %t557, { i8**, i64 }* %t560, 1
  %t564 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t565 = extractvalue %EnumLayoutHeaderParse %t564, 2
  %t566 = insertvalue %NativeEnumLayout undef, double %t565, 0
  %t567 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t568 = extractvalue %EnumLayoutHeaderParse %t567, 3
  %t569 = insertvalue %NativeEnumLayout %t566, double %t568, 1
  %t570 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t571 = extractvalue %EnumLayoutHeaderParse %t570, 4
  %t572 = insertvalue %NativeEnumLayout %t569, i8* %t571, 2
  %t573 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t574 = extractvalue %EnumLayoutHeaderParse %t573, 5
  %t575 = insertvalue %NativeEnumLayout %t572, double %t574, 3
  %t576 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t577 = extractvalue %EnumLayoutHeaderParse %t576, 6
  %t578 = insertvalue %NativeEnumLayout %t575, double %t577, 4
  %t579 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t580 = bitcast { %NativeEnumVariantLayout*, i64 }* %t579 to { i8**, i64 }*
  %t581 = insertvalue %NativeEnumLayout %t578, { i8**, i64 }* %t580, 5
  %t582 = insertvalue %NativeEnum %t563, i8* null, 2
  store %NativeEnum %t582, %NativeEnum* %l32
  %t583 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t584 = load %NativeEnum, %NativeEnum* %l32
  %t585 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t583, %NativeEnum %t584)
  store { %NativeEnum*, i64 }* %t585, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t586 = load double, double* %l4
  %t587 = sitofp i64 1 to double
  %t588 = fadd double %t586, %t587
  store double %t588, double* %l4
  br label %merge32
merge32:
  %t589 = phi double [ %t334, %then30 ], [ %t588, %else31 ]
  %t590 = phi i8* [ %t435, %then30 ], [ %t322, %else31 ]
  %t591 = phi { i8**, i64 }* [ %t445, %then30 ], [ %t316, %else31 ]
  %t592 = phi { %NativeEnum*, i64 }* [ %t585, %then30 ], [ %t318, %else31 ]
  store double %t589, double* %l4
  store i8* %t590, i8** %l17
  store { i8**, i64 }* %t591, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t592, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t593 = load double, double* %l4
  %t594 = sitofp i64 1 to double
  %t595 = fadd double %t593, %t594
  store double %t595, double* %l4
  br label %loop.latch2
loop.latch2:
  %t596 = load double, double* %l4
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t598 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t599 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t604 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t605 = bitcast { %NativeStruct*, i64 }* %t604 to { i8**, i64 }*
  %t606 = insertvalue %LayoutManifest undef, { i8**, i64 }* %t605, 0
  %t607 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t608 = bitcast { %NativeEnum*, i64 }* %t607 to { i8**, i64 }*
  %t609 = insertvalue %LayoutManifest %t606, { i8**, i64 }* %t608, 1
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t611 = insertvalue %LayoutManifest %t609, { i8**, i64 }* %t610, 2
  ret %LayoutManifest %t611
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
