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
@.str.2 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.13 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.105 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.8 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.48 = private unnamed_addr constant [1 x i8] c"\00"
@.str.25 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [1 x i8] c"\00"
@.str.46 = private unnamed_addr constant [1 x i8] c"\00"
@.str.31 = private unnamed_addr constant [1 x i8] c"\00"
@.str.32 = private unnamed_addr constant [1 x i8] c"\00"
@.str.66 = private unnamed_addr constant [1 x i8] c"\00"
@.str.35 = private unnamed_addr constant [1 x i8] c"\00"

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
  %l30 = alloca %InstructionParseResult
  %l31 = alloca { i8**, i64 }*
  %l32 = alloca double
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
  %t929 = phi double [ %t48, %entry ], [ %t920, %loop.latch2 ]
  %t930 = phi { i8**, i64 }* [ %t38, %entry ], [ %t921, %loop.latch2 ]
  %t931 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t922, %loop.latch2 ]
  %t932 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t923, %loop.latch2 ]
  %t933 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t924, %loop.latch2 ]
  %t934 = phi i8* [ %t45, %entry ], [ %t925, %loop.latch2 ]
  %t935 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t926, %loop.latch2 ]
  %t936 = phi i8* [ %t46, %entry ], [ %t927, %loop.latch2 ]
  %t937 = phi i8* [ %t47, %entry ], [ %t928, %loop.latch2 ]
  store double %t929, double* %l11
  store { i8**, i64 }* %t930, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t931, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t932, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t933, { %NativeEnum*, i64 }** %l6
  store i8* %t934, i8** %l8
  store { %NativeFunction*, i64 }* %t935, { %NativeFunction*, i64 }** %l2
  store i8* %t936, i8** %l9
  store i8* %t937, i8** %l10
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
  %t69 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t70 = extractvalue { i8**, i64 } %t69, 0
  %t71 = extractvalue { i8**, i64 } %t69, 1
  %t72 = icmp uge i64 %t68, %t71
  ; bounds check: %t72 (if true, out of bounds)
  %t73 = getelementptr i8*, i8** %t70, i64 %t68
  %t74 = load i8*, i8** %t73
  store i8* %t74, i8** %l12
  %t75 = load i8*, i8** %l12
  %t76 = call i8* @trim_text(i8* %t75)
  store i8* %t76, i8** %l13
  %t77 = load i8*, i8** %l13
  %t78 = load i8*, i8** %l13
  %t79 = call i1 @starts_with(i8* %t78, i8* null)
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t83 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t84 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t85 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t86 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t87 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t88 = load i8*, i8** %l8
  %t89 = load i8*, i8** %l9
  %t90 = load i8*, i8** %l10
  %t91 = load double, double* %l11
  %t92 = load i8*, i8** %l12
  %t93 = load i8*, i8** %l13
  br i1 %t79, label %then6, label %merge7
then6:
  %t94 = load double, double* %l11
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l11
  br label %loop.latch2
merge7:
  %t97 = load i8*, i8** %l13
  %s98 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.98, i32 0, i32 0
  %t99 = call i1 @starts_with(i8* %t97, i8* %s98)
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
  %s134 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.134, i32 0, i32 0
  %t135 = load i8*, i8** %l13
  %s136 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.136, i32 0, i32 0
  %t137 = call i8* @strip_prefix(i8* %t135, i8* %s136)
  %t138 = call double @parse_import_entry(i8* %s134, i8* %t137)
  store double %t138, double* %l14
  %t139 = load double, double* %l14
  %t140 = load double, double* %l11
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l11
  br label %loop.latch2
merge11:
  %t143 = load i8*, i8** %l13
  %s144 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.144, i32 0, i32 0
  %t145 = call i1 @starts_with(i8* %t143, i8* %s144)
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t148 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t149 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t150 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t151 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t152 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t153 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t154 = load i8*, i8** %l8
  %t155 = load i8*, i8** %l9
  %t156 = load i8*, i8** %l10
  %t157 = load double, double* %l11
  %t158 = load i8*, i8** %l12
  %t159 = load i8*, i8** %l13
  br i1 %t145, label %then12, label %merge13
then12:
  %s160 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.160, i32 0, i32 0
  %t161 = load i8*, i8** %l13
  %s162 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.162, i32 0, i32 0
  %t163 = call i8* @strip_prefix(i8* %t161, i8* %s162)
  %t164 = call double @parse_import_entry(i8* %s160, i8* %t163)
  store double %t164, double* %l15
  %t165 = load double, double* %l15
  %t166 = load double, double* %l11
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l11
  br label %loop.latch2
merge13:
  %t169 = load i8*, i8** %l13
  %s170 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.170, i32 0, i32 0
  %t171 = call i1 @starts_with(i8* %t169, i8* %s170)
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t175 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t176 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t177 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t178 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t179 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t180 = load i8*, i8** %l8
  %t181 = load i8*, i8** %l9
  %t182 = load i8*, i8** %l10
  %t183 = load double, double* %l11
  %t184 = load i8*, i8** %l12
  %t185 = load i8*, i8** %l13
  br i1 %t171, label %then14, label %merge15
then14:
  %t186 = load i8*, i8** %l13
  %s187 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.187, i32 0, i32 0
  %t188 = call i8* @strip_prefix(i8* %t186, i8* %s187)
  %t189 = call double @parse_source_span(i8* %t188)
  store double %t189, double* %l16
  %t190 = load double, double* %l16
  %t191 = load double, double* %l11
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %t191, %t192
  store double %t193, double* %l11
  br label %loop.latch2
merge15:
  %t194 = load i8*, i8** %l13
  %t195 = load i8*, i8** %l13
  %s196 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.196, i32 0, i32 0
  %t197 = call i1 @starts_with(i8* %t195, i8* %s196)
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t201 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t202 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t203 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t204 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t205 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t206 = load i8*, i8** %l8
  %t207 = load i8*, i8** %l9
  %t208 = load i8*, i8** %l10
  %t209 = load double, double* %l11
  %t210 = load i8*, i8** %l12
  %t211 = load i8*, i8** %l13
  br i1 %t197, label %then16, label %merge17
then16:
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load double, double* %l11
  %t214 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t212, double %t213)
  store %StructParseResult %t214, %StructParseResult* %l17
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t216 = load %StructParseResult, %StructParseResult* %l17
  %t217 = extractvalue %StructParseResult %t216, 2
  %t218 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t215, { i8**, i64 }* %t217)
  store { i8**, i64 }* %t218, { i8**, i64 }** %l1
  %t219 = load %StructParseResult, %StructParseResult* %l17
  %t220 = extractvalue %StructParseResult %t219, 0
  %t221 = icmp ne i8* %t220, null
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
  %t236 = load %StructParseResult, %StructParseResult* %l17
  br i1 %t221, label %then18, label %merge19
then18:
  %t237 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t238 = load %StructParseResult, %StructParseResult* %l17
  %t239 = extractvalue %StructParseResult %t238, 0
  %t240 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t237, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t240, { %NativeStruct*, i64 }** %l4
  br label %merge19
merge19:
  %t241 = phi { %NativeStruct*, i64 }* [ %t240, %then18 ], [ %t226, %then16 ]
  store { %NativeStruct*, i64 }* %t241, { %NativeStruct*, i64 }** %l4
  %t242 = load %StructParseResult, %StructParseResult* %l17
  %t243 = extractvalue %StructParseResult %t242, 1
  store double %t243, double* %l11
  br label %loop.latch2
merge17:
  %t244 = load i8*, i8** %l13
  %s245 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.245, i32 0, i32 0
  %t246 = call i1 @starts_with(i8* %t244, i8* %s245)
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t249 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t250 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t251 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t252 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t253 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t254 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t255 = load i8*, i8** %l8
  %t256 = load i8*, i8** %l9
  %t257 = load i8*, i8** %l10
  %t258 = load double, double* %l11
  %t259 = load i8*, i8** %l12
  %t260 = load i8*, i8** %l13
  br i1 %t246, label %then20, label %merge21
then20:
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load double, double* %l11
  %t263 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t261, double %t262)
  store %InterfaceParseResult %t263, %InterfaceParseResult* %l18
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t265 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t266 = extractvalue %InterfaceParseResult %t265, 2
  %t267 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t264, { i8**, i64 }* %t266)
  store { i8**, i64 }* %t267, { i8**, i64 }** %l1
  %t268 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t269 = extractvalue %InterfaceParseResult %t268, 0
  %t270 = icmp ne i8* %t269, null
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
  %t285 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  br i1 %t270, label %then22, label %merge23
then22:
  %t286 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t287 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t288 = extractvalue %InterfaceParseResult %t287, 0
  %t289 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t286, %NativeInterface zeroinitializer)
  store { %NativeInterface*, i64 }* %t289, { %NativeInterface*, i64 }** %l5
  br label %merge23
merge23:
  %t290 = phi { %NativeInterface*, i64 }* [ %t289, %then22 ], [ %t276, %then20 ]
  store { %NativeInterface*, i64 }* %t290, { %NativeInterface*, i64 }** %l5
  %t291 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t292 = extractvalue %InterfaceParseResult %t291, 1
  store double %t292, double* %l11
  br label %loop.latch2
merge21:
  %t293 = load i8*, i8** %l13
  %s294 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.294, i32 0, i32 0
  %t295 = call i1 @starts_with(i8* %t293, i8* %s294)
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t298 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t299 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t300 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t301 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t302 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t303 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t304 = load i8*, i8** %l8
  %t305 = load i8*, i8** %l9
  %t306 = load i8*, i8** %l10
  %t307 = load double, double* %l11
  %t308 = load i8*, i8** %l12
  %t309 = load i8*, i8** %l13
  br i1 %t295, label %then24, label %merge25
then24:
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t311 = load double, double* %l11
  %t312 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t310, double %t311)
  store %EnumParseResult %t312, %EnumParseResult* %l19
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t314 = load %EnumParseResult, %EnumParseResult* %l19
  %t315 = extractvalue %EnumParseResult %t314, 2
  %t316 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t313, { i8**, i64 }* %t315)
  store { i8**, i64 }* %t316, { i8**, i64 }** %l1
  %t317 = load %EnumParseResult, %EnumParseResult* %l19
  %t318 = extractvalue %EnumParseResult %t317, 0
  %t319 = icmp ne i8* %t318, null
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
  %t334 = load %EnumParseResult, %EnumParseResult* %l19
  br i1 %t319, label %then26, label %merge27
then26:
  %t335 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t336 = load %EnumParseResult, %EnumParseResult* %l19
  %t337 = extractvalue %EnumParseResult %t336, 0
  %t338 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t335, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t338, { %NativeEnum*, i64 }** %l6
  br label %merge27
merge27:
  %t339 = phi { %NativeEnum*, i64 }* [ %t338, %then26 ], [ %t326, %then24 ]
  store { %NativeEnum*, i64 }* %t339, { %NativeEnum*, i64 }** %l6
  %t340 = load %EnumParseResult, %EnumParseResult* %l19
  %t341 = extractvalue %EnumParseResult %t340, 1
  store double %t341, double* %l11
  br label %loop.latch2
merge25:
  %t342 = load i8*, i8** %l13
  %s343 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.343, i32 0, i32 0
  %t344 = call i1 @starts_with(i8* %t342, i8* %s343)
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t347 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t348 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t349 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t350 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t351 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t352 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t353 = load i8*, i8** %l8
  %t354 = load i8*, i8** %l9
  %t355 = load i8*, i8** %l10
  %t356 = load double, double* %l11
  %t357 = load i8*, i8** %l12
  %t358 = load i8*, i8** %l13
  br i1 %t344, label %then28, label %merge29
then28:
  %t359 = load i8*, i8** %l8
  %t360 = icmp ne i8* %t359, null
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t363 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t364 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t365 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t366 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t367 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t368 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t369 = load i8*, i8** %l8
  %t370 = load i8*, i8** %l9
  %t371 = load i8*, i8** %l10
  %t372 = load double, double* %l11
  %t373 = load i8*, i8** %l12
  %t374 = load i8*, i8** %l13
  br i1 %t360, label %then30, label %merge31
then30:
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s376 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.376, i32 0, i32 0
  %t377 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t375, i8* %s376)
  store { i8**, i64 }* %t377, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t378 = phi { i8**, i64 }* [ %t377, %then30 ], [ %t362, %then28 ]
  store { i8**, i64 }* %t378, { i8**, i64 }** %l1
  %t379 = load double, double* %l11
  %t380 = sitofp i64 1 to double
  %t381 = fadd double %t379, %t380
  store double %t381, double* %l11
  br label %loop.latch2
merge29:
  %t382 = load i8*, i8** %l13
  %s383 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.383, i32 0, i32 0
  %t384 = call i1 @starts_with(i8* %t382, i8* %s383)
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
  %t399 = load i8*, i8** %l8
  %t400 = icmp eq i8* %t399, null
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t403 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t404 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t405 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t406 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t407 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t408 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t409 = load i8*, i8** %l8
  %t410 = load i8*, i8** %l9
  %t411 = load i8*, i8** %l10
  %t412 = load double, double* %l11
  %t413 = load i8*, i8** %l12
  %t414 = load i8*, i8** %l13
  br i1 %t400, label %then34, label %else35
then34:
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s416 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.416, i32 0, i32 0
  %t417 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t415, i8* %s416)
  store { i8**, i64 }* %t417, { i8**, i64 }** %l1
  br label %merge36
else35:
  %t418 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t419 = load i8*, i8** %l8
  %t420 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t418, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t420, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge36
merge36:
  %t421 = phi { i8**, i64 }* [ %t417, %then34 ], [ %t402, %else35 ]
  %t422 = phi { %NativeFunction*, i64 }* [ %t403, %then34 ], [ %t420, %else35 ]
  %t423 = phi i8* [ %t409, %then34 ], [ null, %else35 ]
  store { i8**, i64 }* %t421, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t422, { %NativeFunction*, i64 }** %l2
  store i8* %t423, i8** %l8
  %t424 = load double, double* %l11
  %t425 = sitofp i64 1 to double
  %t426 = fadd double %t424, %t425
  store double %t426, double* %l11
  br label %loop.latch2
merge33:
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
  br i1 %t429, label %then37, label %merge38
then37:
  %t444 = load i8*, i8** %l8
  %t445 = icmp ne i8* %t444, null
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
  br i1 %t445, label %then39, label %else40
then39:
  %t460 = load i8*, i8** %l8
  %t461 = load i8*, i8** %l13
  %s462 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.462, i32 0, i32 0
  %t463 = call i8* @strip_prefix(i8* %t461, i8* %s462)
  %t464 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t463)
  store i8* null, i8** %l8
  br label %merge41
else40:
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s466 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.466, i32 0, i32 0
  %t467 = load i8*, i8** %l13
  %t468 = add i8* %s466, %t467
  %t469 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t465, i8* %t468)
  store { i8**, i64 }* %t469, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t470 = phi i8* [ null, %then39 ], [ %t454, %else40 ]
  %t471 = phi { i8**, i64 }* [ %t447, %then39 ], [ %t469, %else40 ]
  store i8* %t470, i8** %l8
  store { i8**, i64 }* %t471, { i8**, i64 }** %l1
  %t472 = load double, double* %l11
  %t473 = sitofp i64 1 to double
  %t474 = fadd double %t472, %t473
  store double %t474, double* %l11
  br label %loop.latch2
merge38:
  %t475 = load i8*, i8** %l13
  %s476 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.476, i32 0, i32 0
  %t477 = call i1 @starts_with(i8* %t475, i8* %s476)
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t480 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t481 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t482 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t483 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t484 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t485 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t486 = load i8*, i8** %l8
  %t487 = load i8*, i8** %l9
  %t488 = load i8*, i8** %l10
  %t489 = load double, double* %l11
  %t490 = load i8*, i8** %l12
  %t491 = load i8*, i8** %l13
  br i1 %t477, label %then42, label %merge43
then42:
  %t492 = load i8*, i8** %l8
  %t493 = icmp ne i8* %t492, null
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t496 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t497 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t498 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t499 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t500 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t501 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t502 = load i8*, i8** %l8
  %t503 = load i8*, i8** %l9
  %t504 = load i8*, i8** %l10
  %t505 = load double, double* %l11
  %t506 = load i8*, i8** %l12
  %t507 = load i8*, i8** %l13
  br i1 %t493, label %then44, label %else45
then44:
  %t508 = load i8*, i8** %l13
  %s509 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.509, i32 0, i32 0
  %t510 = call i8* @strip_prefix(i8* %t508, i8* %s509)
  store i8* %t510, i8** %l20
  %t511 = load double, double* %l11
  %t512 = sitofp i64 1 to double
  %t513 = fadd double %t511, %t512
  store double %t513, double* %l21
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t515 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t516 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t517 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t518 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t519 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t520 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t521 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t522 = load i8*, i8** %l8
  %t523 = load i8*, i8** %l9
  %t524 = load i8*, i8** %l10
  %t525 = load double, double* %l11
  %t526 = load i8*, i8** %l12
  %t527 = load i8*, i8** %l13
  %t528 = load i8*, i8** %l20
  %t529 = load double, double* %l21
  br label %loop.header47
loop.header47:
  %t598 = phi i8* [ %t528, %then44 ], [ %t596, %loop.latch49 ]
  %t599 = phi double [ %t529, %then44 ], [ %t597, %loop.latch49 ]
  store i8* %t598, i8** %l20
  store double %t599, double* %l21
  br label %loop.body48
loop.body48:
  %t530 = load double, double* %l21
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t532 = load { i8**, i64 }, { i8**, i64 }* %t531
  %t533 = extractvalue { i8**, i64 } %t532, 1
  %t534 = sitofp i64 %t533 to double
  %t535 = fcmp oge double %t530, %t534
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t537 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t538 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t539 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t540 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t541 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t542 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t543 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t544 = load i8*, i8** %l8
  %t545 = load i8*, i8** %l9
  %t546 = load i8*, i8** %l10
  %t547 = load double, double* %l11
  %t548 = load i8*, i8** %l12
  %t549 = load i8*, i8** %l13
  %t550 = load i8*, i8** %l20
  %t551 = load double, double* %l21
  br i1 %t535, label %then51, label %merge52
then51:
  br label %afterloop50
merge52:
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t553 = load double, double* %l21
  %t554 = load { i8**, i64 }, { i8**, i64 }* %t552
  %t555 = extractvalue { i8**, i64 } %t554, 0
  %t556 = extractvalue { i8**, i64 } %t554, 1
  %t557 = icmp uge i64 %t553, %t556
  ; bounds check: %t557 (if true, out of bounds)
  %t558 = getelementptr i8*, i8** %t555, i64 %t553
  %t559 = load i8*, i8** %t558
  store i8* %t559, i8** %l22
  %t560 = load i8*, i8** %l22
  %t561 = load i8*, i8** %l22
  %t562 = call i8* @trim_text(i8* %t561)
  store i8* %t562, i8** %l23
  %t563 = load i8*, i8** %l23
  %t564 = load i8*, i8** %l23
  %t565 = call i1 @line_looks_like_parameter_entry(i8* %t564)
  %t566 = xor i1 %t565, 1
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t569 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t570 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t571 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t572 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t573 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t574 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t575 = load i8*, i8** %l8
  %t576 = load i8*, i8** %l9
  %t577 = load i8*, i8** %l10
  %t578 = load double, double* %l11
  %t579 = load i8*, i8** %l12
  %t580 = load i8*, i8** %l13
  %t581 = load i8*, i8** %l20
  %t582 = load double, double* %l21
  %t583 = load i8*, i8** %l22
  %t584 = load i8*, i8** %l23
  br i1 %t566, label %then53, label %merge54
then53:
  br label %afterloop50
merge54:
  %t585 = load i8*, i8** %l20
  %t586 = getelementptr i8, i8* %t585, i64 0
  %t587 = load i8, i8* %t586
  %t588 = add i8 %t587, 32
  %t589 = load i8*, i8** %l23
  %t590 = getelementptr i8, i8* %t589, i64 0
  %t591 = load i8, i8* %t590
  %t592 = add i8 %t588, %t591
  store i8* null, i8** %l20
  %t593 = load double, double* %l21
  %t594 = sitofp i64 1 to double
  %t595 = fadd double %t593, %t594
  store double %t595, double* %l21
  br label %loop.latch49
loop.latch49:
  %t596 = load i8*, i8** %l20
  %t597 = load double, double* %l21
  br label %loop.header47
afterloop50:
  %t600 = load i8*, i8** %l20
  %t601 = call { i8**, i64 }* @split_parameter_entries(i8* %t600)
  store { i8**, i64 }* %t601, { i8**, i64 }** %l24
  %t602 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t603 = load { i8**, i64 }, { i8**, i64 }* %t602
  %t604 = extractvalue { i8**, i64 } %t603, 1
  %t605 = icmp eq i64 %t604, 0
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t607 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t608 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t609 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t610 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t611 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t612 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t613 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t614 = load i8*, i8** %l8
  %t615 = load i8*, i8** %l9
  %t616 = load i8*, i8** %l10
  %t617 = load double, double* %l11
  %t618 = load i8*, i8** %l12
  %t619 = load i8*, i8** %l13
  %t620 = load i8*, i8** %l20
  %t621 = load double, double* %l21
  %t622 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br i1 %t605, label %then55, label %else56
then55:
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s624 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.624, i32 0, i32 0
  %t625 = load i8*, i8** %l13
  %t626 = add i8* %s624, %t625
  %t627 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t623, i8* %t626)
  store { i8**, i64 }* %t627, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge57
else56:
  %t628 = sitofp i64 0 to double
  store double %t628, double* %l25
  store i1 0, i1* %l26
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t630 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t631 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t632 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t633 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t634 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t635 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t636 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t637 = load i8*, i8** %l8
  %t638 = load i8*, i8** %l9
  %t639 = load i8*, i8** %l10
  %t640 = load double, double* %l11
  %t641 = load i8*, i8** %l12
  %t642 = load i8*, i8** %l13
  %t643 = load i8*, i8** %l20
  %t644 = load double, double* %l21
  %t645 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t646 = load double, double* %l25
  %t647 = load i1, i1* %l26
  br label %loop.header58
loop.header58:
  %t713 = phi double [ %t646, %else56 ], [ %t712, %loop.latch60 ]
  store double %t713, double* %l25
  br label %loop.body59
loop.body59:
  %t648 = load double, double* %l25
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t650 = load { i8**, i64 }, { i8**, i64 }* %t649
  %t651 = extractvalue { i8**, i64 } %t650, 1
  %t652 = sitofp i64 %t651 to double
  %t653 = fcmp oge double %t648, %t652
  %t654 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t655 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t656 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t657 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t658 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t659 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t660 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t661 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t662 = load i8*, i8** %l8
  %t663 = load i8*, i8** %l9
  %t664 = load i8*, i8** %l10
  %t665 = load double, double* %l11
  %t666 = load i8*, i8** %l12
  %t667 = load i8*, i8** %l13
  %t668 = load i8*, i8** %l20
  %t669 = load double, double* %l21
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t671 = load double, double* %l25
  %t672 = load i1, i1* %l26
  br i1 %t653, label %then62, label %merge63
then62:
  br label %afterloop61
merge63:
  %t673 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t674 = load double, double* %l25
  %t675 = load { i8**, i64 }, { i8**, i64 }* %t673
  %t676 = extractvalue { i8**, i64 } %t675, 0
  %t677 = extractvalue { i8**, i64 } %t675, 1
  %t678 = icmp uge i64 %t674, %t677
  ; bounds check: %t678 (if true, out of bounds)
  %t679 = getelementptr i8*, i8** %t676, i64 %t674
  %t680 = load i8*, i8** %t679
  store i8* %t680, i8** %l27
  %t681 = load i8*, i8** %l9
  store i8* %t681, i8** %l28
  %t682 = load i1, i1* %l26
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t685 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t686 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t687 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t688 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t689 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t690 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t691 = load i8*, i8** %l8
  %t692 = load i8*, i8** %l9
  %t693 = load i8*, i8** %l10
  %t694 = load double, double* %l11
  %t695 = load i8*, i8** %l12
  %t696 = load i8*, i8** %l13
  %t697 = load i8*, i8** %l20
  %t698 = load double, double* %l21
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t700 = load double, double* %l25
  %t701 = load i1, i1* %l26
  %t702 = load i8*, i8** %l27
  %t703 = load i8*, i8** %l28
  br i1 %t682, label %then64, label %merge65
then64:
  store i8* null, i8** %l28
  br label %merge65
merge65:
  %t704 = phi i8* [ null, %then64 ], [ %t703, %loop.body59 ]
  store i8* %t704, i8** %l28
  %t705 = load i8*, i8** %l27
  %t706 = load i8*, i8** %l28
  %t707 = call double @parse_parameter_entry(i8* %t705, i8* %t706)
  store double %t707, double* %l29
  %t708 = load double, double* %l29
  %t709 = load double, double* %l25
  %t710 = sitofp i64 1 to double
  %t711 = fadd double %t709, %t710
  store double %t711, double* %l25
  br label %loop.latch60
loop.latch60:
  %t712 = load double, double* %l25
  br label %loop.header58
afterloop61:
  store i8* null, i8** %l9
  br label %merge57
merge57:
  %t714 = phi { i8**, i64 }* [ %t627, %then55 ], [ %t607, %else56 ]
  %t715 = phi i8* [ null, %then55 ], [ null, %else56 ]
  store { i8**, i64 }* %t714, { i8**, i64 }** %l1
  store i8* %t715, i8** %l9
  %t716 = load double, double* %l21
  %t717 = sitofp i64 1 to double
  %t718 = fsub double %t716, %t717
  store double %t718, double* %l11
  br label %merge46
else45:
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s720 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.720, i32 0, i32 0
  %t721 = load i8*, i8** %l13
  %t722 = add i8* %s720, %t721
  %t723 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t719, i8* %t722)
  store { i8**, i64 }* %t723, { i8**, i64 }** %l1
  br label %merge46
merge46:
  %t724 = phi { i8**, i64 }* [ %t627, %then44 ], [ %t723, %else45 ]
  %t725 = phi i8* [ null, %then44 ], [ %t503, %else45 ]
  %t726 = phi double [ %t718, %then44 ], [ %t505, %else45 ]
  store { i8**, i64 }* %t724, { i8**, i64 }** %l1
  store i8* %t725, i8** %l9
  store double %t726, double* %l11
  %t727 = load double, double* %l11
  %t728 = sitofp i64 1 to double
  %t729 = fadd double %t727, %t728
  store double %t729, double* %l11
  br label %loop.latch2
merge43:
  %t730 = load i8*, i8** %l13
  %t731 = load i8*, i8** %l9
  %t732 = load i8*, i8** %l10
  %t733 = call %InstructionParseResult @parse_instruction(i8* %t730, i8* %t731, i8* %t732)
  store %InstructionParseResult %t733, %InstructionParseResult* %l30
  %t734 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t735 = extractvalue %InstructionParseResult %t734, 0
  store { i8**, i64 }* %t735, { i8**, i64 }** %l31
  %t736 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t737 = extractvalue %InstructionParseResult %t736, 1
  %t738 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t739 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t740 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t741 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t742 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t743 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t744 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t745 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t746 = load i8*, i8** %l8
  %t747 = load i8*, i8** %l9
  %t748 = load i8*, i8** %l10
  %t749 = load double, double* %l11
  %t750 = load i8*, i8** %l12
  %t751 = load i8*, i8** %l13
  %t752 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t753 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t737, label %then66, label %else67
then66:
  store i8* null, i8** %l9
  br label %merge68
else67:
  %t754 = load i8*, i8** %l9
  %t755 = icmp ne i8* %t754, null
  %t756 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t757 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t758 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t759 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t760 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t761 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t762 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t763 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t764 = load i8*, i8** %l8
  %t765 = load i8*, i8** %l9
  %t766 = load i8*, i8** %l10
  %t767 = load double, double* %l11
  %t768 = load i8*, i8** %l12
  %t769 = load i8*, i8** %l13
  %t770 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t771 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t755, label %then69, label %merge70
then69:
  %t772 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s773 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.773, i32 0, i32 0
  %t774 = load i8*, i8** %l13
  %t775 = add i8* %s773, %t774
  %t776 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t772, i8* %t775)
  store { i8**, i64 }* %t776, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge70
merge70:
  %t777 = phi { i8**, i64 }* [ %t776, %then69 ], [ %t757, %else67 ]
  %t778 = phi i8* [ null, %then69 ], [ %t765, %else67 ]
  store { i8**, i64 }* %t777, { i8**, i64 }** %l1
  store i8* %t778, i8** %l9
  br label %merge68
merge68:
  %t779 = phi i8* [ null, %then66 ], [ null, %else67 ]
  %t780 = phi { i8**, i64 }* [ %t739, %then66 ], [ %t776, %else67 ]
  store i8* %t779, i8** %l9
  store { i8**, i64 }* %t780, { i8**, i64 }** %l1
  %t781 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t782 = extractvalue %InstructionParseResult %t781, 2
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t784 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t785 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t786 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t787 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t788 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t789 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t790 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t791 = load i8*, i8** %l8
  %t792 = load i8*, i8** %l9
  %t793 = load i8*, i8** %l10
  %t794 = load double, double* %l11
  %t795 = load i8*, i8** %l12
  %t796 = load i8*, i8** %l13
  %t797 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t782, label %then71, label %else72
then71:
  store i8* null, i8** %l10
  br label %merge73
else72:
  %t799 = load i8*, i8** %l10
  %t800 = icmp ne i8* %t799, null
  %t801 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t802 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t803 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t804 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t805 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t806 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t807 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t808 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t809 = load i8*, i8** %l8
  %t810 = load i8*, i8** %l9
  %t811 = load i8*, i8** %l10
  %t812 = load double, double* %l11
  %t813 = load i8*, i8** %l12
  %t814 = load i8*, i8** %l13
  %t815 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t816 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t800, label %then74, label %merge75
then74:
  %t817 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s818 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.818, i32 0, i32 0
  %t819 = load i8*, i8** %l13
  %t820 = add i8* %s818, %t819
  %t821 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t817, i8* %t820)
  store { i8**, i64 }* %t821, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge75
merge75:
  %t822 = phi { i8**, i64 }* [ %t821, %then74 ], [ %t802, %else72 ]
  %t823 = phi i8* [ null, %then74 ], [ %t811, %else72 ]
  store { i8**, i64 }* %t822, { i8**, i64 }** %l1
  store i8* %t823, i8** %l10
  br label %merge73
merge73:
  %t824 = phi i8* [ null, %then71 ], [ null, %else72 ]
  %t825 = phi { i8**, i64 }* [ %t784, %then71 ], [ %t821, %else72 ]
  store i8* %t824, i8** %l10
  store { i8**, i64 }* %t825, { i8**, i64 }** %l1
  %t826 = load i8*, i8** %l8
  %t827 = icmp eq i8* %t826, null
  %t828 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t829 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t830 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t831 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t832 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t833 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t834 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t835 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t836 = load i8*, i8** %l8
  %t837 = load i8*, i8** %l9
  %t838 = load i8*, i8** %l10
  %t839 = load double, double* %l11
  %t840 = load i8*, i8** %l12
  %t841 = load i8*, i8** %l13
  %t842 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t843 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t827, label %then76, label %merge77
then76:
  %t845 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t846 = load { i8**, i64 }, { i8**, i64 }* %t845
  %t847 = extractvalue { i8**, i64 } %t846, 1
  %t848 = icmp eq i64 %t847, 1
  br label %logical_and_entry_844

logical_and_entry_844:
  br i1 %t848, label %logical_and_right_844, label %logical_and_merge_844

logical_and_right_844:
  %t849 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t850 = load { i8**, i64 }, { i8**, i64 }* %t849
  %t851 = extractvalue { i8**, i64 } %t850, 0
  %t852 = extractvalue { i8**, i64 } %t850, 1
  %t853 = icmp uge i64 0, %t852
  ; bounds check: %t853 (if true, out of bounds)
  %t854 = getelementptr i8*, i8** %t851, i64 0
  %t855 = load i8*, i8** %t854
  %t856 = load double, double* %l11
  %t857 = sitofp i64 1 to double
  %t858 = fadd double %t856, %t857
  store double %t858, double* %l11
  br label %loop.latch2
merge77:
  %t859 = sitofp i64 0 to double
  store double %t859, double* %l32
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t861 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t862 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t863 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t864 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t865 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t866 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t867 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t868 = load i8*, i8** %l8
  %t869 = load i8*, i8** %l9
  %t870 = load i8*, i8** %l10
  %t871 = load double, double* %l11
  %t872 = load i8*, i8** %l12
  %t873 = load i8*, i8** %l13
  %t874 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t875 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t876 = load double, double* %l32
  br label %loop.header78
loop.header78:
  %t915 = phi i8* [ %t868, %loop.body1 ], [ %t913, %loop.latch80 ]
  %t916 = phi double [ %t876, %loop.body1 ], [ %t914, %loop.latch80 ]
  store i8* %t915, i8** %l8
  store double %t916, double* %l32
  br label %loop.body79
loop.body79:
  %t877 = load double, double* %l32
  %t878 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t879 = load { i8**, i64 }, { i8**, i64 }* %t878
  %t880 = extractvalue { i8**, i64 } %t879, 1
  %t881 = sitofp i64 %t880 to double
  %t882 = fcmp oge double %t877, %t881
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
  %t897 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t898 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t899 = load double, double* %l32
  br i1 %t882, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t900 = load i8*, i8** %l8
  %t901 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t902 = load double, double* %l32
  %t903 = load { i8**, i64 }, { i8**, i64 }* %t901
  %t904 = extractvalue { i8**, i64 } %t903, 0
  %t905 = extractvalue { i8**, i64 } %t903, 1
  %t906 = icmp uge i64 %t902, %t905
  ; bounds check: %t906 (if true, out of bounds)
  %t907 = getelementptr i8*, i8** %t904, i64 %t902
  %t908 = load i8*, i8** %t907
  %t909 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t910 = load double, double* %l32
  %t911 = sitofp i64 1 to double
  %t912 = fadd double %t910, %t911
  store double %t912, double* %l32
  br label %loop.latch80
loop.latch80:
  %t913 = load i8*, i8** %l8
  %t914 = load double, double* %l32
  br label %loop.header78
afterloop81:
  %t917 = load double, double* %l11
  %t918 = sitofp i64 1 to double
  %t919 = fadd double %t917, %t918
  store double %t919, double* %l11
  br label %loop.latch2
loop.latch2:
  %t920 = load double, double* %l11
  %t921 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t922 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t923 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t924 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t925 = load i8*, i8** %l8
  %t926 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t927 = load i8*, i8** %l9
  %t928 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t938 = load i8*, i8** %l8
  %t939 = icmp ne i8* %t938, null
  %t940 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t941 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t942 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t943 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t944 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t945 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t946 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t947 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t948 = load i8*, i8** %l8
  %t949 = load i8*, i8** %l9
  %t950 = load i8*, i8** %l10
  %t951 = load double, double* %l11
  br i1 %t939, label %then84, label %merge85
then84:
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s953 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.953, i32 0, i32 0
  %t954 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t952, i8* %s953)
  store { i8**, i64 }* %t954, { i8**, i64 }** %l1
  br label %merge85
merge85:
  %t955 = phi { i8**, i64 }* [ %t954, %then84 ], [ %t941, %entry ]
  store { i8**, i64 }* %t955, { i8**, i64 }** %l1
  %t956 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t957 = bitcast { %NativeFunction*, i64 }* %t956 to { i8**, i64 }*
  %t958 = insertvalue %ParseNativeResult undef, { i8**, i64 }* %t957, 0
  %t959 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t960 = bitcast { %NativeImport*, i64 }* %t959 to { i8**, i64 }*
  %t961 = insertvalue %ParseNativeResult %t958, { i8**, i64 }* %t960, 1
  %t962 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t963 = bitcast { %NativeStruct*, i64 }* %t962 to { i8**, i64 }*
  %t964 = insertvalue %ParseNativeResult %t961, { i8**, i64 }* %t963, 2
  %t965 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t966 = bitcast { %NativeInterface*, i64 }* %t965 to { i8**, i64 }*
  %t967 = insertvalue %ParseNativeResult %t964, { i8**, i64 }* %t966, 3
  %t968 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t969 = bitcast { %NativeEnum*, i64 }* %t968 to { i8**, i64 }*
  %t970 = insertvalue %ParseNativeResult %t967, { i8**, i64 }* %t969, 4
  %t971 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t972 = bitcast { %NativeBinding*, i64 }* %t971 to { i8**, i64 }*
  %t973 = insertvalue %ParseNativeResult %t970, { i8**, i64 }* %t972, 5
  %t974 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t975 = insertvalue %ParseNativeResult %t973, { i8**, i64 }* %t974, 6
  ret %ParseNativeResult %t975
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
  %t23 = phi double [ %t1, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
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
  %t9 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t10 = extractvalue { %NativeEnumVariantLayout*, i64 } %t9, 0
  %t11 = extractvalue { %NativeEnumVariantLayout*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t10, i64 %t8
  %t14 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t13
  %t15 = extractvalue %NativeEnumVariantLayout %t14, 0
  %t16 = icmp eq i8* %t15, %name
  %t17 = load double, double* %l0
  br i1 %t16, label %then6, label %merge7
then6:
  %t18 = load double, double* %l0
  ret double %t18
merge7:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t24 = sitofp i64 -1 to double
  ret double %t24
}

define { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %variants, double %index, %NativeStructLayoutField %field) {
entry:
  %l0 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca double
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
  %t44 = phi { %NativeEnumVariantLayout*, i64 }* [ %t6, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t7, %entry ], [ %t43, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t44, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t45, double* %l1
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
  %t20 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t21 = extractvalue { %NativeEnumVariantLayout*, i64 } %t20, 0
  %t22 = extractvalue { %NativeEnumVariantLayout*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t21, i64 %t19
  %t25 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t24
  store %NativeEnumVariantLayout %t25, %NativeEnumVariantLayout* %l2
  store double 0.0, double* %l3
  %t26 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t27 = load double, double* %l3
  %t28 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t26, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t28, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
else7:
  %t29 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t32 = extractvalue { %NativeEnumVariantLayout*, i64 } %t31, 0
  %t33 = extractvalue { %NativeEnumVariantLayout*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t32, i64 %t30
  %t36 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t35
  %t37 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t29, %NativeEnumVariantLayout %t36)
  store { %NativeEnumVariantLayout*, i64 }* %t37, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
merge8:
  %t38 = phi { %NativeEnumVariantLayout*, i64 }* [ %t28, %then6 ], [ %t37, %else7 ]
  store { %NativeEnumVariantLayout*, i64 }* %t38, { %NativeEnumVariantLayout*, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t46
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

define %InstructionParseResult @parse_instruction(i8* %line, i8* %span, i8* %value_span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8
  %l8 = alloca double
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
  %t63 = load i8*, i8** %l1
  store double 0.0, double* %l5
  %t64 = alloca %NativeInstruction
  %t65 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t64, i32 0, i32 0
  store i32 6, i32* %t65
  %t66 = load i8*, i8** %l4
  %t67 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t64, i32 0, i32 1
  %t68 = bitcast [16 x i8]* %t67 to i8*
  %t69 = bitcast i8* %t68 to i8**
  store i8* %t66, i8** %t69
  %t70 = load double, double* %l5
  %t71 = call noalias i8* @malloc(i64 8)
  %t72 = bitcast i8* %t71 to double*
  store double %t70, double* %t72
  %t73 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t64, i32 0, i32 1
  %t74 = bitcast [16 x i8]* %t73 to i8*
  %t75 = getelementptr inbounds i8, i8* %t74, i64 8
  %t76 = bitcast i8* %t75 to i8**
  store i8* %t71, i8** %t76
  %t77 = load %NativeInstruction, %NativeInstruction* %t64
  %t78 = alloca [1 x %NativeInstruction]
  %t79 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t78, i32 0, i32 0
  %t80 = getelementptr %NativeInstruction, %NativeInstruction* %t79, i64 0
  store %NativeInstruction %t77, %NativeInstruction* %t80
  %t81 = alloca { %NativeInstruction*, i64 }
  %t82 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t81, i32 0, i32 0
  store %NativeInstruction* %t79, %NativeInstruction** %t82
  %t83 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t81, i32 0, i32 1
  store i64 1, i64* %t83
  %t84 = bitcast { %NativeInstruction*, i64 }* %t81 to { i8**, i64 }*
  %t85 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t84, 0
  %t86 = insertvalue %InstructionParseResult %t85, i1 0, 1
  %t87 = insertvalue %InstructionParseResult %t86, i1 0, 2
  ret %InstructionParseResult %t87
merge11:
  br label %merge9
merge9:
  %s88 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.88, i32 0, i32 0
  %t89 = icmp eq i8* %line, %s88
  br i1 %t89, label %then12, label %merge13
then12:
  %t90 = insertvalue %NativeInstruction undef, i32 7, 0
  %t91 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t92 = insertvalue %InstructionParseResult %t91, i1 0, 1
  %t93 = insertvalue %InstructionParseResult %t92, i1 0, 2
  ret %InstructionParseResult %t93
merge13:
  %s94 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.94, i32 0, i32 0
  %t95 = icmp eq i8* %line, %s94
  br i1 %t95, label %then14, label %merge15
then14:
  %t96 = insertvalue %NativeInstruction undef, i32 8, 0
  %t97 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t98 = insertvalue %InstructionParseResult %t97, i1 0, 1
  %t99 = insertvalue %InstructionParseResult %t98, i1 0, 2
  ret %InstructionParseResult %t99
merge15:
  %s100 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.100, i32 0, i32 0
  %t101 = icmp eq i8* %line, %s100
  br i1 %t101, label %then16, label %merge17
then16:
  %t102 = insertvalue %NativeInstruction undef, i32 9, 0
  %t103 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t104 = insertvalue %InstructionParseResult %t103, i1 0, 1
  %t105 = insertvalue %InstructionParseResult %t104, i1 0, 2
  ret %InstructionParseResult %t105
merge17:
  %s106 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.106, i32 0, i32 0
  %t107 = icmp eq i8* %line, %s106
  br i1 %t107, label %then18, label %merge19
then18:
  %t108 = insertvalue %NativeInstruction undef, i32 10, 0
  %t109 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t110 = insertvalue %InstructionParseResult %t109, i1 0, 1
  %t111 = insertvalue %InstructionParseResult %t110, i1 0, 2
  ret %InstructionParseResult %t111
merge19:
  %s112 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.112, i32 0, i32 0
  %t113 = icmp eq i8* %line, %s112
  br i1 %t113, label %then20, label %merge21
then20:
  %t114 = insertvalue %NativeInstruction undef, i32 11, 0
  %t115 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t116 = insertvalue %InstructionParseResult %t115, i1 0, 1
  %t117 = insertvalue %InstructionParseResult %t116, i1 0, 2
  ret %InstructionParseResult %t117
merge21:
  %s118 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.118, i32 0, i32 0
  %t119 = call i1 @starts_with(i8* %line, i8* %s118)
  br i1 %t119, label %then22, label %merge23
then22:
  %s120 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i8* @strip_prefix(i8* %line, i8* %s120)
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l6
  %t123 = alloca %NativeInstruction
  %t124 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t123, i32 0, i32 0
  store i32 12, i32* %t124
  %t125 = load i8*, i8** %l6
  %t126 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t123, i32 0, i32 1
  %t127 = bitcast [8 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  store i8* %t125, i8** %t128
  %t129 = load %NativeInstruction, %NativeInstruction* %t123
  %t130 = alloca [1 x %NativeInstruction]
  %t131 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t130, i32 0, i32 0
  %t132 = getelementptr %NativeInstruction, %NativeInstruction* %t131, i64 0
  store %NativeInstruction %t129, %NativeInstruction* %t132
  %t133 = alloca { %NativeInstruction*, i64 }
  %t134 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t133, i32 0, i32 0
  store %NativeInstruction* %t131, %NativeInstruction** %t134
  %t135 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t133, i32 0, i32 1
  store i64 1, i64* %t135
  %t136 = bitcast { %NativeInstruction*, i64 }* %t133 to { i8**, i64 }*
  %t137 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t136, 0
  %t138 = insertvalue %InstructionParseResult %t137, i1 0, 1
  %t139 = insertvalue %InstructionParseResult %t138, i1 0, 2
  ret %InstructionParseResult %t139
merge23:
  %s140 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.140, i32 0, i32 0
  %t141 = call i1 @starts_with(i8* %line, i8* %s140)
  br i1 %t141, label %then24, label %merge25
then24:
  %t142 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t143 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t144 = insertvalue %InstructionParseResult %t143, i1 0, 1
  %t145 = insertvalue %InstructionParseResult %t144, i1 0, 2
  ret %InstructionParseResult %t145
merge25:
  %s146 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.146, i32 0, i32 0
  %t147 = icmp eq i8* %line, %s146
  br i1 %t147, label %then26, label %merge27
then26:
  %t148 = insertvalue %NativeInstruction undef, i32 14, 0
  %t149 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t150 = insertvalue %InstructionParseResult %t149, i1 0, 1
  %t151 = insertvalue %InstructionParseResult %t150, i1 0, 2
  ret %InstructionParseResult %t151
merge27:
  %s152 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.152, i32 0, i32 0
  %t153 = call i1 @starts_with(i8* %line, i8* %s152)
  br i1 %t153, label %then28, label %merge29
then28:
  %t154 = call %NativeInstruction @parse_let_instruction(i8* %line, i8* %span, i8* %value_span)
  %t155 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t156 = insertvalue %InstructionParseResult %t155, i1 1, 1
  %t157 = insertvalue %InstructionParseResult %t156, i1 1, 2
  ret %InstructionParseResult %t157
merge29:
  %s158 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.158, i32 0, i32 0
  %t159 = call i1 @starts_with(i8* %line, i8* %s158)
  br i1 %t159, label %then30, label %merge31
then30:
  %t160 = getelementptr i8, i8* %line, i64 3
  %t161 = load i8, i8* %t160
  store i8 %t161, i8* %l7
  %t163 = load i8, i8* %l7
  %t164 = icmp eq i8 %t163, 32
  br label %logical_or_entry_162

logical_or_entry_162:
  br i1 %t164, label %logical_or_merge_162, label %logical_or_right_162

logical_or_right_162:
  %t165 = load i8, i8* %l7
  %t166 = icmp eq i8 %t165, 9
  br label %logical_or_right_end_162

logical_or_right_end_162:
  br label %logical_or_merge_162

logical_or_merge_162:
  %t167 = phi i1 [ true, %logical_or_entry_162 ], [ %t166, %logical_or_right_end_162 ]
  %t168 = load i8, i8* %l7
  br i1 %t167, label %then32, label %merge33
then32:
  store double 0.0, double* %l8
  %t169 = load double, double* %l8
  %t170 = alloca %NativeInstruction
  %t171 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 0
  store i32 0, i32* %t171
  %t172 = load double, double* %l8
  %t173 = call i8* @trim_trailing_delimiters(i8* null)
  %t174 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 1
  %t175 = bitcast [16 x i8]* %t174 to i8*
  %t176 = bitcast i8* %t175 to i8**
  store i8* %t173, i8** %t176
  %t177 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t170, i32 0, i32 1
  %t178 = bitcast [16 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 8
  %t180 = bitcast i8* %t179 to i8**
  store i8* %span, i8** %t180
  %t181 = load %NativeInstruction, %NativeInstruction* %t170
  %t182 = alloca [1 x %NativeInstruction]
  %t183 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t182, i32 0, i32 0
  %t184 = getelementptr %NativeInstruction, %NativeInstruction* %t183, i64 0
  store %NativeInstruction %t181, %NativeInstruction* %t184
  %t185 = alloca { %NativeInstruction*, i64 }
  %t186 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t185, i32 0, i32 0
  store %NativeInstruction* %t183, %NativeInstruction** %t186
  %t187 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t185, i32 0, i32 1
  store i64 1, i64* %t187
  %t188 = bitcast { %NativeInstruction*, i64 }* %t185 to { i8**, i64 }*
  %t189 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t188, 0
  %t190 = insertvalue %InstructionParseResult %t189, i1 1, 1
  %t191 = insertvalue %InstructionParseResult %t190, i1 0, 2
  ret %InstructionParseResult %t191
merge33:
  br label %merge31
merge31:
  %s192 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.192, i32 0, i32 0
  %t193 = call i1 @starts_with(i8* %line, i8* %s192)
  br i1 %t193, label %then34, label %merge35
then34:
  %s194 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.194, i32 0, i32 0
  %t195 = call i8* @strip_prefix(i8* %line, i8* %s194)
  %t196 = call i8* @trim_text(i8* %t195)
  store i8* %t196, i8** %l9
  store i1 0, i1* %l10
  %t197 = load i8*, i8** %l9
  %s198 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.198, i32 0, i32 0
  %t199 = call i1 @starts_with(i8* %t197, i8* %s198)
  %t200 = load i8*, i8** %l9
  %t201 = load i1, i1* %l10
  br i1 %t199, label %then36, label %merge37
then36:
  store i1 1, i1* %l10
  %t202 = load i8*, i8** %l9
  %s203 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.203, i32 0, i32 0
  %t204 = call i8* @strip_prefix(i8* %t202, i8* %s203)
  %t205 = call i8* @trim_text(i8* %t204)
  store i8* %t205, i8** %l9
  br label %merge37
merge37:
  %t206 = phi i1 [ 1, %then36 ], [ %t201, %then34 ]
  %t207 = phi i8* [ %t205, %then36 ], [ %t200, %then34 ]
  store i1 %t206, i1* %l10
  store i8* %t207, i8** %l9
  %t208 = load i8*, i8** %l9
  %t209 = call %BindingComponents @parse_binding_components(i8* %t208)
  store %BindingComponents %t209, %BindingComponents* %l11
  %t210 = alloca %NativeInstruction
  %t211 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 0
  store i32 2, i32* %t211
  %t212 = load %BindingComponents, %BindingComponents* %l11
  %t213 = extractvalue %BindingComponents %t212, 0
  %t214 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 1
  %t215 = bitcast [48 x i8]* %t214 to i8*
  %t216 = bitcast i8* %t215 to i8**
  store i8* %t213, i8** %t216
  %t217 = load i1, i1* %l10
  %t218 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 1
  %t219 = bitcast [48 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 8
  %t221 = bitcast i8* %t220 to i1*
  store i1 %t217, i1* %t221
  %t222 = load %BindingComponents, %BindingComponents* %l11
  %t223 = extractvalue %BindingComponents %t222, 1
  %t224 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 1
  %t225 = bitcast [48 x i8]* %t224 to i8*
  %t226 = getelementptr inbounds i8, i8* %t225, i64 16
  %t227 = bitcast i8* %t226 to i8**
  store i8* %t223, i8** %t227
  %t228 = load %BindingComponents, %BindingComponents* %l11
  %t229 = extractvalue %BindingComponents %t228, 2
  %t230 = call double @maybe_trim_trailing(i8* %t229)
  %t231 = call noalias i8* @malloc(i64 8)
  %t232 = bitcast i8* %t231 to double*
  store double %t230, double* %t232
  %t233 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 1
  %t234 = bitcast [48 x i8]* %t233 to i8*
  %t235 = getelementptr inbounds i8, i8* %t234, i64 24
  %t236 = bitcast i8* %t235 to i8**
  store i8* %t231, i8** %t236
  %t237 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 1
  %t238 = bitcast [48 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 32
  %t240 = bitcast i8* %t239 to i8**
  store i8* %span, i8** %t240
  %t241 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t210, i32 0, i32 1
  %t242 = bitcast [48 x i8]* %t241 to i8*
  %t243 = getelementptr inbounds i8, i8* %t242, i64 40
  %t244 = bitcast i8* %t243 to i8**
  store i8* %value_span, i8** %t244
  %t245 = load %NativeInstruction, %NativeInstruction* %t210
  %t246 = alloca [1 x %NativeInstruction]
  %t247 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t246, i32 0, i32 0
  %t248 = getelementptr %NativeInstruction, %NativeInstruction* %t247, i64 0
  store %NativeInstruction %t245, %NativeInstruction* %t248
  %t249 = alloca { %NativeInstruction*, i64 }
  %t250 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t249, i32 0, i32 0
  store %NativeInstruction* %t247, %NativeInstruction** %t250
  %t251 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t249, i32 0, i32 1
  store i64 1, i64* %t251
  %t252 = bitcast { %NativeInstruction*, i64 }* %t249 to { i8**, i64 }*
  %t253 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t252, 0
  %t254 = insertvalue %InstructionParseResult %t253, i1 1, 1
  %t255 = insertvalue %InstructionParseResult %t254, i1 1, 2
  ret %InstructionParseResult %t255
merge35:
  %s256 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.256, i32 0, i32 0
  %t257 = call i1 @starts_with(i8* %line, i8* %s256)
  br i1 %t257, label %then38, label %merge39
then38:
  %t258 = alloca %NativeInstruction
  %t259 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t258, i32 0, i32 0
  store i32 1, i32* %t259
  %s260 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.260, i32 0, i32 0
  %t261 = call i8* @strip_prefix(i8* %line, i8* %s260)
  %t262 = call i8* @trim_text(i8* %t261)
  %t263 = call i8* @trim_trailing_delimiters(i8* %t262)
  %t264 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t258, i32 0, i32 1
  %t265 = bitcast [16 x i8]* %t264 to i8*
  %t266 = bitcast i8* %t265 to i8**
  store i8* %t263, i8** %t266
  %t267 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t258, i32 0, i32 1
  %t268 = bitcast [16 x i8]* %t267 to i8*
  %t269 = getelementptr inbounds i8, i8* %t268, i64 8
  %t270 = bitcast i8* %t269 to i8**
  store i8* %span, i8** %t270
  %t271 = load %NativeInstruction, %NativeInstruction* %t258
  %t272 = alloca [1 x %NativeInstruction]
  %t273 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t272, i32 0, i32 0
  %t274 = getelementptr %NativeInstruction, %NativeInstruction* %t273, i64 0
  store %NativeInstruction %t271, %NativeInstruction* %t274
  %t275 = alloca { %NativeInstruction*, i64 }
  %t276 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t275, i32 0, i32 0
  store %NativeInstruction* %t273, %NativeInstruction** %t276
  %t277 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t275, i32 0, i32 1
  store i64 1, i64* %t277
  %t278 = bitcast { %NativeInstruction*, i64 }* %t275 to { i8**, i64 }*
  %t279 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t278, 0
  %t280 = insertvalue %InstructionParseResult %t279, i1 1, 1
  %t281 = insertvalue %InstructionParseResult %t280, i1 0, 2
  ret %InstructionParseResult %t281
merge39:
  %t282 = alloca %NativeInstruction
  %t283 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t282, i32 0, i32 0
  store i32 16, i32* %t283
  %t284 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t282, i32 0, i32 1
  %t285 = bitcast [8 x i8]* %t284 to i8*
  %t286 = bitcast i8* %t285 to i8**
  store i8* %line, i8** %t286
  %t287 = load %NativeInstruction, %NativeInstruction* %t282
  %t288 = alloca [1 x %NativeInstruction]
  %t289 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t288, i32 0, i32 0
  %t290 = getelementptr %NativeInstruction, %NativeInstruction* %t289, i64 0
  store %NativeInstruction %t287, %NativeInstruction* %t290
  %t291 = alloca { %NativeInstruction*, i64 }
  %t292 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t291, i32 0, i32 0
  store %NativeInstruction* %t289, %NativeInstruction** %t292
  %t293 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t291, i32 0, i32 1
  store i64 1, i64* %t293
  %t294 = bitcast { %NativeInstruction*, i64 }* %t291 to { i8**, i64 }*
  %t295 = insertvalue %InstructionParseResult undef, { i8**, i64 }* %t294, 0
  %t296 = insertvalue %InstructionParseResult %t295, i1 0, 1
  %t297 = insertvalue %InstructionParseResult %t296, i1 0, 2
  ret %InstructionParseResult %t297
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
  %l3 = alloca double
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
  store double 0.0, double* %l3
  %t30 = load i8*, i8** %l2
  %t31 = call %CaseComponents @split_case_components(i8* %t30)
  store %CaseComponents %t31, %CaseComponents* %l4
  %t32 = alloca [0 x %NativeInstruction]
  %t33 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* %t32, i32 0, i32 0
  %t34 = alloca { %NativeInstruction*, i64 }
  %t35 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t34, i32 0, i32 0
  store %NativeInstruction* %t33, %NativeInstruction** %t35
  %t36 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %NativeInstruction*, i64 }* %t34, { %NativeInstruction*, i64 }** %l5
  %t37 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t38 = alloca %NativeInstruction
  %t39 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t38, i32 0, i32 0
  store i32 13, i32* %t39
  %t40 = load %CaseComponents, %CaseComponents* %l4
  %t41 = extractvalue %CaseComponents %t40, 0
  %t42 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t38, i32 0, i32 1
  %t43 = bitcast [16 x i8]* %t42 to i8*
  %t44 = bitcast i8* %t43 to i8**
  store i8* %t41, i8** %t44
  %t45 = load %CaseComponents, %CaseComponents* %l4
  %t46 = extractvalue %CaseComponents %t45, 1
  %t47 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t38, i32 0, i32 1
  %t48 = bitcast [16 x i8]* %t47 to i8*
  %t49 = getelementptr inbounds i8, i8* %t48, i64 8
  %t50 = bitcast i8* %t49 to i8**
  store i8* %t46, i8** %t50
  %t51 = load %NativeInstruction, %NativeInstruction* %t38
  %t52 = alloca [1 x %NativeInstruction]
  %t53 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t52, i32 0, i32 0
  %t54 = getelementptr %NativeInstruction, %NativeInstruction* %t53, i64 0
  store %NativeInstruction %t51, %NativeInstruction* %t54
  %t55 = alloca { %NativeInstruction*, i64 }
  %t56 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t55, i32 0, i32 0
  store %NativeInstruction* %t53, %NativeInstruction** %t56
  %t57 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = bitcast { %NativeInstruction*, i64 }* %t37 to { i8**, i64 }*
  %t59 = bitcast { %NativeInstruction*, i64 }* %t55 to { i8**, i64 }*
  %t60 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t58, { i8**, i64 }* %t59)
  %t61 = bitcast { i8**, i64 }* %t60 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t61, { %NativeInstruction*, i64 }** %l5
  %t62 = load double, double* %l3
  %t63 = load double, double* %l3
  %t64 = call %NativeInstruction @parse_inline_case_body_instruction(i8* null)
  store %NativeInstruction %t64, %NativeInstruction* %l6
  %t65 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t66 = load %NativeInstruction, %NativeInstruction* %l6
  %t67 = alloca [1 x %NativeInstruction]
  %t68 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t67, i32 0, i32 0
  %t69 = getelementptr %NativeInstruction, %NativeInstruction* %t68, i64 0
  store %NativeInstruction %t66, %NativeInstruction* %t69
  %t70 = alloca { %NativeInstruction*, i64 }
  %t71 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t70, i32 0, i32 0
  store %NativeInstruction* %t68, %NativeInstruction** %t71
  %t72 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t70, i32 0, i32 1
  store i64 1, i64* %t72
  %t73 = bitcast { %NativeInstruction*, i64 }* %t65 to { i8**, i64 }*
  %t74 = bitcast { %NativeInstruction*, i64 }* %t70 to { i8**, i64 }*
  %t75 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t73, { i8**, i64 }* %t74)
  %t76 = bitcast { i8**, i64 }* %t75 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t76, { %NativeInstruction*, i64 }** %l5
  %t77 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t77
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
  %l4 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l1
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l1
  %t5 = call double @last_index_of(i8* %t3, i8* %t4)
  store double %t5, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 0 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then0, label %merge1
then0:
  %t12 = load i8*, i8** %l0
  %t13 = insertvalue %CaseComponents undef, i8* %t12, 0
  %t14 = insertvalue %CaseComponents %t13, i8* null, 1
  ret %CaseComponents %t14
merge1:
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l2
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %t15, i64 0, i64 %t17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l2
  %t22 = load i8*, i8** %l1
  %t23 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t24 = load double, double* %l4
  %t25 = load i8*, i8** %l3
  %t26 = insertvalue %CaseComponents undef, i8* %t25, 0
  %t27 = load double, double* %l4
  %t28 = insertvalue %CaseComponents %t26, i8* null, 1
  ret %CaseComponents %t28
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
  %t2 = load i8*, i8** %l0
  %t3 = call { i8**, i64 }* @split_comma_separated(i8* %t2)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t4 = alloca [0 x %NativeImportSpecifier]
  %t5 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t4, i32 0, i32 0
  %t6 = alloca { %NativeImportSpecifier*, i64 }
  %t7 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t6, i32 0, i32 0
  store %NativeImportSpecifier* %t5, %NativeImportSpecifier** %t7
  %t8 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { %NativeImportSpecifier*, i64 }* %t6, { %NativeImportSpecifier*, i64 }** %l2
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l3
  %t10 = load i8*, i8** %l0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t13 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t39 = phi double [ %t13, %entry ], [ %t38, %loop.latch2 ]
  store double %t39, double* %l3
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t23 = load double, double* %l3
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load double, double* %l3
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call %NativeImportSpecifier @parse_single_specifier(i8* %t31)
  store %NativeImportSpecifier %t32, %NativeImportSpecifier* %l4
  %t33 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t34 = extractvalue %NativeImportSpecifier %t33, 0
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch2
loop.latch2:
  %t38 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t40 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t40
}

define %NativeImportSpecifier @parse_single_specifier(i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l1
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l1
  %t5 = call double @index_of(i8* %t3, i8* %t4)
  store double %t5, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 0 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then0, label %merge1
then0:
  %t12 = load i8*, i8** %l0
  %t13 = insertvalue %NativeImportSpecifier undef, i8* %t12, 0
  %t14 = insertvalue %NativeImportSpecifier %t13, i8* null, 1
  ret %NativeImportSpecifier %t14
merge1:
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l2
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %t15, i64 0, i64 %t17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l2
  %t22 = load i8*, i8** %l1
  %t23 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t24 = load double, double* %l4
  %t25 = load i8*, i8** %l3
  %t26 = insertvalue %NativeImportSpecifier undef, i8* %t25, 0
  %t27 = load double, double* %l4
  %t28 = insertvalue %NativeImportSpecifier %t26, i8* null, 1
  ret %NativeImportSpecifier %t28
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
  %t5 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %start_index, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %start_index
  %t10 = load i8*, i8** %t9
  %t11 = call i8* @trim_text(i8* %t10)
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i8* @strip_prefix(i8* %t12, i8* %s13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  %t17 = call %StructHeaderParse @parse_struct_header(i8* %t16)
  store %StructHeaderParse %t17, %StructHeaderParse* %l3
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t20 = extractvalue %StructHeaderParse %t19, 2
  %t21 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t18, { i8**, i64 }* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  %t22 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t23 = extractvalue %StructHeaderParse %t22, 0
  store i8* %t23, i8** %l4
  %t24 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t25 = extractvalue %StructHeaderParse %t24, 1
  store { i8**, i64 }* %t25, { i8**, i64 }** %l5
  %t26 = load i8*, i8** %l4
  %t27 = alloca [0 x %NativeStructField]
  %t28 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* %t27, i32 0, i32 0
  %t29 = alloca { %NativeStructField*, i64 }
  %t30 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t29, i32 0, i32 0
  store %NativeStructField* %t28, %NativeStructField** %t30
  %t31 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { %NativeStructField*, i64 }* %t29, { %NativeStructField*, i64 }** %l6
  %t32 = alloca [0 x %NativeFunction]
  %t33 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t32, i32 0, i32 0
  %t34 = alloca { %NativeFunction*, i64 }
  %t35 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t34, i32 0, i32 0
  store %NativeFunction* %t33, %NativeFunction** %t35
  %t36 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %NativeFunction*, i64 }* %t34, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t37 = alloca [0 x %NativeStructLayoutField]
  %t38 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t37, i32 0, i32 0
  %t39 = alloca { %NativeStructLayoutField*, i64 }
  %t40 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t39, i32 0, i32 0
  store %NativeStructLayoutField* %t38, %NativeStructLayoutField** %t40
  %t41 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  store { %NativeStructLayoutField*, i64 }* %t39, { %NativeStructLayoutField*, i64 }** %l11
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l12
  %t43 = sitofp i64 0 to double
  store double %t43, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %start_index, %t44
  store double %t45, double* %l16
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load i8*, i8** %l2
  %t49 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t50 = load i8*, i8** %l4
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t52 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t53 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t54 = load i8*, i8** %l8
  %t55 = load i8*, i8** %l9
  %t56 = load i8*, i8** %l10
  %t57 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t58 = load double, double* %l12
  %t59 = load double, double* %l13
  %t60 = load i1, i1* %l14
  %t61 = load i1, i1* %l15
  %t62 = load double, double* %l16
  br label %loop.header0
loop.header0:
  %t910 = phi { i8**, i64 }* [ %t46, %entry ], [ %t899, %loop.latch2 ]
  %t911 = phi { %NativeFunction*, i64 }* [ %t53, %entry ], [ %t900, %loop.latch2 ]
  %t912 = phi i8* [ %t54, %entry ], [ %t901, %loop.latch2 ]
  %t913 = phi i8* [ %t55, %entry ], [ %t902, %loop.latch2 ]
  %t914 = phi i8* [ %t56, %entry ], [ %t903, %loop.latch2 ]
  %t915 = phi double [ %t62, %entry ], [ %t904, %loop.latch2 ]
  %t916 = phi double [ %t58, %entry ], [ %t905, %loop.latch2 ]
  %t917 = phi double [ %t59, %entry ], [ %t906, %loop.latch2 ]
  %t918 = phi i1 [ %t60, %entry ], [ %t907, %loop.latch2 ]
  %t919 = phi { %NativeStructLayoutField*, i64 }* [ %t57, %entry ], [ %t908, %loop.latch2 ]
  %t920 = phi i1 [ %t61, %entry ], [ %t909, %loop.latch2 ]
  store { i8**, i64 }* %t910, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t911, { %NativeFunction*, i64 }** %l7
  store i8* %t912, i8** %l8
  store i8* %t913, i8** %l9
  store i8* %t914, i8** %l10
  store double %t915, double* %l16
  store double %t916, double* %l12
  store double %t917, double* %l13
  store i1 %t918, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t919, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t920, i1* %l15
  br label %loop.body1
loop.body1:
  %t63 = load double, double* %l16
  %t64 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t65 = extractvalue { i8**, i64 } %t64, 1
  %t66 = sitofp i64 %t65 to double
  %t67 = fcmp oge double %t63, %t66
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l2
  %t71 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t72 = load i8*, i8** %l4
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t74 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t75 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t76 = load i8*, i8** %l8
  %t77 = load i8*, i8** %l9
  %t78 = load i8*, i8** %l10
  %t79 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t80 = load double, double* %l12
  %t81 = load double, double* %l13
  %t82 = load i1, i1* %l14
  %t83 = load i1, i1* %l15
  %t84 = load double, double* %l16
  br i1 %t67, label %then4, label %merge5
then4:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s86 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.86, i32 0, i32 0
  %t87 = load i8*, i8** %l4
  %t88 = add i8* %s86, %t87
  %t89 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t85, i8* %t88)
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  store i8* null, i8** %l17
  %t90 = load i1, i1* %l14
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load i8*, i8** %l2
  %t94 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t95 = load i8*, i8** %l4
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t97 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t98 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t99 = load i8*, i8** %l8
  %t100 = load i8*, i8** %l9
  %t101 = load i8*, i8** %l10
  %t102 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t103 = load double, double* %l12
  %t104 = load double, double* %l13
  %t105 = load i1, i1* %l14
  %t106 = load i1, i1* %l15
  %t107 = load double, double* %l16
  %t108 = load i8*, i8** %l17
  br i1 %t90, label %then6, label %merge7
then6:
  %t109 = load double, double* %l12
  %t110 = insertvalue %NativeStructLayout undef, double %t109, 0
  %t111 = load double, double* %l13
  %t112 = insertvalue %NativeStructLayout %t110, double %t111, 1
  %t113 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t114 = bitcast { %NativeStructLayoutField*, i64 }* %t113 to { i8**, i64 }*
  %t115 = insertvalue %NativeStructLayout %t112, { i8**, i64 }* %t114, 2
  store i8* null, i8** %l17
  br label %merge7
merge7:
  %t116 = phi i8* [ null, %then6 ], [ %t108, %then4 ]
  store i8* %t116, i8** %l17
  %t117 = load i8*, i8** %l4
  %t118 = insertvalue %NativeStruct undef, i8* %t117, 0
  %t119 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t120 = bitcast { %NativeStructField*, i64 }* %t119 to { i8**, i64 }*
  %t121 = insertvalue %NativeStruct %t118, { i8**, i64 }* %t120, 1
  %t122 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t123 = bitcast { %NativeFunction*, i64 }* %t122 to { i8**, i64 }*
  %t124 = insertvalue %NativeStruct %t121, { i8**, i64 }* %t123, 2
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t126 = insertvalue %NativeStruct %t124, { i8**, i64 }* %t125, 3
  %t127 = load i8*, i8** %l17
  %t128 = insertvalue %NativeStruct %t126, i8* %t127, 4
  %t129 = insertvalue %StructParseResult undef, i8* null, 0
  %t130 = load double, double* %l16
  %t131 = insertvalue %StructParseResult %t129, double %t130, 1
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = insertvalue %StructParseResult %t131, { i8**, i64 }* %t132, 2
  ret %StructParseResult %t133
merge5:
  %t134 = load double, double* %l16
  %t135 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t136 = extractvalue { i8**, i64 } %t135, 0
  %t137 = extractvalue { i8**, i64 } %t135, 1
  %t138 = icmp uge i64 %t134, %t137
  ; bounds check: %t138 (if true, out of bounds)
  %t139 = getelementptr i8*, i8** %t136, i64 %t134
  %t140 = load i8*, i8** %t139
  %t141 = call i8* @trim_text(i8* %t140)
  store i8* %t141, i8** %l18
  %t143 = load i8*, i8** %l18
  %t144 = load i8*, i8** %l18
  %s145 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.145, i32 0, i32 0
  %t146 = icmp eq i8* %t144, %s145
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load i8*, i8** %l1
  %t149 = load i8*, i8** %l2
  %t150 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t151 = load i8*, i8** %l4
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t153 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t154 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t155 = load i8*, i8** %l8
  %t156 = load i8*, i8** %l9
  %t157 = load i8*, i8** %l10
  %t158 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t159 = load double, double* %l12
  %t160 = load double, double* %l13
  %t161 = load i1, i1* %l14
  %t162 = load i1, i1* %l15
  %t163 = load double, double* %l16
  %t164 = load i8*, i8** %l18
  br i1 %t146, label %then8, label %merge9
then8:
  %t165 = load i8*, i8** %l8
  %t166 = icmp ne i8* %t165, null
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t168 = load i8*, i8** %l1
  %t169 = load i8*, i8** %l2
  %t170 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t171 = load i8*, i8** %l4
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t173 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t174 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t175 = load i8*, i8** %l8
  %t176 = load i8*, i8** %l9
  %t177 = load i8*, i8** %l10
  %t178 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t179 = load double, double* %l12
  %t180 = load double, double* %l13
  %t181 = load i1, i1* %l14
  %t182 = load i1, i1* %l15
  %t183 = load double, double* %l16
  %t184 = load i8*, i8** %l18
  br i1 %t166, label %then10, label %merge11
then10:
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s186 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.186, i32 0, i32 0
  %t187 = load i8*, i8** %l4
  %t188 = add i8* %s186, %t187
  %t189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t185, i8* %t188)
  store { i8**, i64 }* %t189, { i8**, i64 }** %l0
  %t190 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t191 = load i8*, i8** %l8
  %t192 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t190, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t192, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  br label %merge11
merge11:
  %t193 = phi { i8**, i64 }* [ %t189, %then10 ], [ %t167, %then8 ]
  %t194 = phi { %NativeFunction*, i64 }* [ %t192, %then10 ], [ %t174, %then8 ]
  %t195 = phi i8* [ null, %then10 ], [ %t175, %then8 ]
  %t196 = phi i8* [ null, %then10 ], [ %t176, %then8 ]
  %t197 = phi i8* [ null, %then10 ], [ %t177, %then8 ]
  store { i8**, i64 }* %t193, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t194, { %NativeFunction*, i64 }** %l7
  store i8* %t195, i8** %l8
  store i8* %t196, i8** %l9
  store i8* %t197, i8** %l10
  %t198 = load double, double* %l16
  %t199 = sitofp i64 1 to double
  %t200 = fadd double %t198, %t199
  store double %t200, double* %l16
  br label %afterloop3
merge9:
  %t201 = load i8*, i8** %l8
  %t202 = icmp ne i8* %t201, null
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load i8*, i8** %l1
  %t205 = load i8*, i8** %l2
  %t206 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t207 = load i8*, i8** %l4
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t209 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t210 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t211 = load i8*, i8** %l8
  %t212 = load i8*, i8** %l9
  %t213 = load i8*, i8** %l10
  %t214 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t215 = load double, double* %l12
  %t216 = load double, double* %l13
  %t217 = load i1, i1* %l14
  %t218 = load i1, i1* %l15
  %t219 = load double, double* %l16
  %t220 = load i8*, i8** %l18
  br i1 %t202, label %then12, label %merge13
then12:
  %t221 = load i8*, i8** %l18
  %s222 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.222, i32 0, i32 0
  %t223 = icmp eq i8* %t221, %s222
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load i8*, i8** %l1
  %t226 = load i8*, i8** %l2
  %t227 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t228 = load i8*, i8** %l4
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t230 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t231 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t232 = load i8*, i8** %l8
  %t233 = load i8*, i8** %l9
  %t234 = load i8*, i8** %l10
  %t235 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t236 = load double, double* %l12
  %t237 = load double, double* %l13
  %t238 = load i1, i1* %l14
  %t239 = load i1, i1* %l15
  %t240 = load double, double* %l16
  %t241 = load i8*, i8** %l18
  br i1 %t223, label %then14, label %merge15
then14:
  %t242 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t243 = load i8*, i8** %l8
  %t244 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t242, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t244, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t245 = load double, double* %l16
  %t246 = sitofp i64 1 to double
  %t247 = fadd double %t245, %t246
  store double %t247, double* %l16
  br label %loop.latch2
merge15:
  %t248 = load i8*, i8** %l18
  %s249 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.249, i32 0, i32 0
  %t250 = call i1 @starts_with(i8* %t248, i8* %s249)
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load i8*, i8** %l1
  %t253 = load i8*, i8** %l2
  %t254 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t255 = load i8*, i8** %l4
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t257 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t258 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t259 = load i8*, i8** %l8
  %t260 = load i8*, i8** %l9
  %t261 = load i8*, i8** %l10
  %t262 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t263 = load double, double* %l12
  %t264 = load double, double* %l13
  %t265 = load i1, i1* %l14
  %t266 = load i1, i1* %l15
  %t267 = load double, double* %l16
  %t268 = load i8*, i8** %l18
  br i1 %t250, label %then16, label %merge17
then16:
  %t269 = load i8*, i8** %l8
  %t270 = load i8*, i8** %l18
  %s271 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.271, i32 0, i32 0
  %t272 = call i8* @strip_prefix(i8* %t270, i8* %s271)
  %t273 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t272)
  store i8* null, i8** %l8
  %t274 = load double, double* %l16
  %t275 = sitofp i64 1 to double
  %t276 = fadd double %t274, %t275
  store double %t276, double* %l16
  br label %loop.latch2
merge17:
  %t277 = load i8*, i8** %l18
  %s278 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.278, i32 0, i32 0
  %t279 = call i1 @starts_with(i8* %t277, i8* %s278)
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load i8*, i8** %l1
  %t282 = load i8*, i8** %l2
  %t283 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t284 = load i8*, i8** %l4
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t286 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t287 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t288 = load i8*, i8** %l8
  %t289 = load i8*, i8** %l9
  %t290 = load i8*, i8** %l10
  %t291 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t292 = load double, double* %l12
  %t293 = load double, double* %l13
  %t294 = load i1, i1* %l14
  %t295 = load i1, i1* %l15
  %t296 = load double, double* %l16
  %t297 = load i8*, i8** %l18
  br i1 %t279, label %then18, label %merge19
then18:
  %t298 = load i8*, i8** %l18
  %s299 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.299, i32 0, i32 0
  %t300 = call i8* @strip_prefix(i8* %t298, i8* %s299)
  %t301 = load i8*, i8** %l9
  %t302 = call double @parse_parameter_entry(i8* %t300, i8* %t301)
  store double %t302, double* %l19
  %t303 = load double, double* %l19
  store i8* null, i8** %l9
  %t304 = load double, double* %l16
  %t305 = sitofp i64 1 to double
  %t306 = fadd double %t304, %t305
  store double %t306, double* %l16
  br label %loop.latch2
merge19:
  %t307 = load i8*, i8** %l18
  %s308 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.308, i32 0, i32 0
  %t309 = call i1 @starts_with(i8* %t307, i8* %s308)
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t311 = load i8*, i8** %l1
  %t312 = load i8*, i8** %l2
  %t313 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t314 = load i8*, i8** %l4
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t316 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t317 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t318 = load i8*, i8** %l8
  %t319 = load i8*, i8** %l9
  %t320 = load i8*, i8** %l10
  %t321 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t322 = load double, double* %l12
  %t323 = load double, double* %l13
  %t324 = load i1, i1* %l14
  %t325 = load i1, i1* %l15
  %t326 = load double, double* %l16
  %t327 = load i8*, i8** %l18
  br i1 %t309, label %then20, label %merge21
then20:
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s329 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.329, i32 0, i32 0
  %t330 = load i8*, i8** %l4
  %t331 = add i8* %s329, %t330
  %t332 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t328, i8* %t331)
  store { i8**, i64 }* %t332, { i8**, i64 }** %l0
  %t333 = load double, double* %l16
  %t334 = sitofp i64 1 to double
  %t335 = fadd double %t333, %t334
  store double %t335, double* %l16
  br label %loop.latch2
merge21:
  %t336 = load i8*, i8** %l18
  %s337 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.337, i32 0, i32 0
  %t338 = call i1 @starts_with(i8* %t336, i8* %s337)
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t340 = load i8*, i8** %l1
  %t341 = load i8*, i8** %l2
  %t342 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t343 = load i8*, i8** %l4
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t345 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t346 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t347 = load i8*, i8** %l8
  %t348 = load i8*, i8** %l9
  %t349 = load i8*, i8** %l10
  %t350 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t351 = load double, double* %l12
  %t352 = load double, double* %l13
  %t353 = load i1, i1* %l14
  %t354 = load i1, i1* %l15
  %t355 = load double, double* %l16
  %t356 = load i8*, i8** %l18
  br i1 %t338, label %then22, label %merge23
then22:
  %t357 = load i8*, i8** %l18
  %s358 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.358, i32 0, i32 0
  %t359 = call i8* @strip_prefix(i8* %t357, i8* %s358)
  %t360 = call double @parse_source_span(i8* %t359)
  store double %t360, double* %l20
  %t361 = load double, double* %l20
  %t362 = load double, double* %l16
  %t363 = sitofp i64 1 to double
  %t364 = fadd double %t362, %t363
  store double %t364, double* %l16
  br label %loop.latch2
merge23:
  %t365 = load i8*, i8** %l18
  %t366 = load i8*, i8** %l18
  %t367 = load i8*, i8** %l9
  %t368 = load i8*, i8** %l10
  %t369 = call %InstructionParseResult @parse_instruction(i8* %t366, i8* %t367, i8* %t368)
  store %InstructionParseResult %t369, %InstructionParseResult* %l21
  %t370 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t371 = extractvalue %InstructionParseResult %t370, 1
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t373 = load i8*, i8** %l1
  %t374 = load i8*, i8** %l2
  %t375 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t376 = load i8*, i8** %l4
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t378 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t379 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t380 = load i8*, i8** %l8
  %t381 = load i8*, i8** %l9
  %t382 = load i8*, i8** %l10
  %t383 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t384 = load double, double* %l12
  %t385 = load double, double* %l13
  %t386 = load i1, i1* %l14
  %t387 = load i1, i1* %l15
  %t388 = load double, double* %l16
  %t389 = load i8*, i8** %l18
  %t390 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t371, label %then24, label %else25
then24:
  store i8* null, i8** %l9
  br label %merge26
else25:
  %t391 = load i8*, i8** %l9
  %t392 = icmp ne i8* %t391, null
  %t393 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t394 = load i8*, i8** %l1
  %t395 = load i8*, i8** %l2
  %t396 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t397 = load i8*, i8** %l4
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t399 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t400 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t401 = load i8*, i8** %l8
  %t402 = load i8*, i8** %l9
  %t403 = load i8*, i8** %l10
  %t404 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t405 = load double, double* %l12
  %t406 = load double, double* %l13
  %t407 = load i1, i1* %l14
  %t408 = load i1, i1* %l15
  %t409 = load double, double* %l16
  %t410 = load i8*, i8** %l18
  %t411 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t392, label %then27, label %merge28
then27:
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s413 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.413, i32 0, i32 0
  %t414 = load i8*, i8** %l18
  %t415 = add i8* %s413, %t414
  %t416 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t412, i8* %t415)
  store { i8**, i64 }* %t416, { i8**, i64 }** %l0
  store i8* null, i8** %l9
  br label %merge28
merge28:
  %t417 = phi { i8**, i64 }* [ %t416, %then27 ], [ %t393, %else25 ]
  %t418 = phi i8* [ null, %then27 ], [ %t402, %else25 ]
  store { i8**, i64 }* %t417, { i8**, i64 }** %l0
  store i8* %t418, i8** %l9
  br label %merge26
merge26:
  %t419 = phi i8* [ null, %then24 ], [ null, %else25 ]
  %t420 = phi { i8**, i64 }* [ %t372, %then24 ], [ %t416, %else25 ]
  store i8* %t419, i8** %l9
  store { i8**, i64 }* %t420, { i8**, i64 }** %l0
  %t421 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t422 = extractvalue %InstructionParseResult %t421, 2
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t424 = load i8*, i8** %l1
  %t425 = load i8*, i8** %l2
  %t426 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t427 = load i8*, i8** %l4
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t429 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t430 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t431 = load i8*, i8** %l8
  %t432 = load i8*, i8** %l9
  %t433 = load i8*, i8** %l10
  %t434 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t435 = load double, double* %l12
  %t436 = load double, double* %l13
  %t437 = load i1, i1* %l14
  %t438 = load i1, i1* %l15
  %t439 = load double, double* %l16
  %t440 = load i8*, i8** %l18
  %t441 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t422, label %then29, label %else30
then29:
  store i8* null, i8** %l10
  br label %merge31
else30:
  %t442 = load i8*, i8** %l10
  %t443 = icmp ne i8* %t442, null
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t445 = load i8*, i8** %l1
  %t446 = load i8*, i8** %l2
  %t447 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t448 = load i8*, i8** %l4
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t450 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t451 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t452 = load i8*, i8** %l8
  %t453 = load i8*, i8** %l9
  %t454 = load i8*, i8** %l10
  %t455 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t456 = load double, double* %l12
  %t457 = load double, double* %l13
  %t458 = load i1, i1* %l14
  %t459 = load i1, i1* %l15
  %t460 = load double, double* %l16
  %t461 = load i8*, i8** %l18
  %t462 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t443, label %then32, label %merge33
then32:
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s464 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.464, i32 0, i32 0
  %t465 = load i8*, i8** %l18
  %t466 = add i8* %s464, %t465
  %t467 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t463, i8* %t466)
  store { i8**, i64 }* %t467, { i8**, i64 }** %l0
  store i8* null, i8** %l10
  br label %merge33
merge33:
  %t468 = phi { i8**, i64 }* [ %t467, %then32 ], [ %t444, %else30 ]
  %t469 = phi i8* [ null, %then32 ], [ %t454, %else30 ]
  store { i8**, i64 }* %t468, { i8**, i64 }** %l0
  store i8* %t469, i8** %l10
  br label %merge31
merge31:
  %t470 = phi i8* [ null, %then29 ], [ null, %else30 ]
  %t471 = phi { i8**, i64 }* [ %t423, %then29 ], [ %t467, %else30 ]
  store i8* %t470, i8** %l10
  store { i8**, i64 }* %t471, { i8**, i64 }** %l0
  %t472 = sitofp i64 0 to double
  store double %t472, double* %l22
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load i8*, i8** %l1
  %t475 = load i8*, i8** %l2
  %t476 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t477 = load i8*, i8** %l4
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t479 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t480 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t481 = load i8*, i8** %l8
  %t482 = load i8*, i8** %l9
  %t483 = load i8*, i8** %l10
  %t484 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t485 = load double, double* %l12
  %t486 = load double, double* %l13
  %t487 = load i1, i1* %l14
  %t488 = load i1, i1* %l15
  %t489 = load double, double* %l16
  %t490 = load i8*, i8** %l18
  %t491 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t492 = load double, double* %l22
  br label %loop.header34
loop.header34:
  %t536 = phi i8* [ %t481, %then12 ], [ %t534, %loop.latch36 ]
  %t537 = phi double [ %t492, %then12 ], [ %t535, %loop.latch36 ]
  store i8* %t536, i8** %l8
  store double %t537, double* %l22
  br label %loop.body35
loop.body35:
  %t493 = load double, double* %l22
  %t494 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t495 = extractvalue %InstructionParseResult %t494, 0
  %t496 = load { i8**, i64 }, { i8**, i64 }* %t495
  %t497 = extractvalue { i8**, i64 } %t496, 1
  %t498 = sitofp i64 %t497 to double
  %t499 = fcmp oge double %t493, %t498
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t501 = load i8*, i8** %l1
  %t502 = load i8*, i8** %l2
  %t503 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t504 = load i8*, i8** %l4
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t506 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t507 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t508 = load i8*, i8** %l8
  %t509 = load i8*, i8** %l9
  %t510 = load i8*, i8** %l10
  %t511 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t512 = load double, double* %l12
  %t513 = load double, double* %l13
  %t514 = load i1, i1* %l14
  %t515 = load i1, i1* %l15
  %t516 = load double, double* %l16
  %t517 = load i8*, i8** %l18
  %t518 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t519 = load double, double* %l22
  br i1 %t499, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t520 = load i8*, i8** %l8
  %t521 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t522 = extractvalue %InstructionParseResult %t521, 0
  %t523 = load double, double* %l22
  %t524 = load { i8**, i64 }, { i8**, i64 }* %t522
  %t525 = extractvalue { i8**, i64 } %t524, 0
  %t526 = extractvalue { i8**, i64 } %t524, 1
  %t527 = icmp uge i64 %t523, %t526
  ; bounds check: %t527 (if true, out of bounds)
  %t528 = getelementptr i8*, i8** %t525, i64 %t523
  %t529 = load i8*, i8** %t528
  %t530 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t531 = load double, double* %l22
  %t532 = sitofp i64 1 to double
  %t533 = fadd double %t531, %t532
  store double %t533, double* %l22
  br label %loop.latch36
loop.latch36:
  %t534 = load i8*, i8** %l8
  %t535 = load double, double* %l22
  br label %loop.header34
afterloop37:
  %t538 = load double, double* %l16
  %t539 = sitofp i64 1 to double
  %t540 = fadd double %t538, %t539
  store double %t540, double* %l16
  br label %loop.latch2
merge13:
  %t541 = load i8*, i8** %l18
  %s542 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.542, i32 0, i32 0
  %t543 = call i1 @starts_with(i8* %t541, i8* %s542)
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t545 = load i8*, i8** %l1
  %t546 = load i8*, i8** %l2
  %t547 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t548 = load i8*, i8** %l4
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t550 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t551 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t552 = load i8*, i8** %l8
  %t553 = load i8*, i8** %l9
  %t554 = load i8*, i8** %l10
  %t555 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t556 = load double, double* %l12
  %t557 = load double, double* %l13
  %t558 = load i1, i1* %l14
  %t559 = load i1, i1* %l15
  %t560 = load double, double* %l16
  %t561 = load i8*, i8** %l18
  br i1 %t543, label %then40, label %merge41
then40:
  %t562 = load i8*, i8** %l18
  %s563 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.563, i32 0, i32 0
  %t564 = call i8* @strip_prefix(i8* %t562, i8* %s563)
  store i8* %t564, i8** %l23
  %t565 = load i8*, i8** %l23
  %s566 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.566, i32 0, i32 0
  %t567 = call i1 @starts_with(i8* %t565, i8* %s566)
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t569 = load i8*, i8** %l1
  %t570 = load i8*, i8** %l2
  %t571 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t572 = load i8*, i8** %l4
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t574 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t575 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t576 = load i8*, i8** %l8
  %t577 = load i8*, i8** %l9
  %t578 = load i8*, i8** %l10
  %t579 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t580 = load double, double* %l12
  %t581 = load double, double* %l13
  %t582 = load i1, i1* %l14
  %t583 = load i1, i1* %l15
  %t584 = load double, double* %l16
  %t585 = load i8*, i8** %l18
  %t586 = load i8*, i8** %l23
  br i1 %t567, label %then42, label %merge43
then42:
  %t587 = load i8*, i8** %l23
  %s588 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.588, i32 0, i32 0
  %t589 = call i8* @strip_prefix(i8* %t587, i8* %s588)
  %t590 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t589)
  store %StructLayoutHeaderParse %t590, %StructLayoutHeaderParse* %l24
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t592 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t593 = extractvalue %StructLayoutHeaderParse %t592, 4
  %t594 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t591, { i8**, i64 }* %t593)
  store { i8**, i64 }* %t594, { i8**, i64 }** %l0
  %t595 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t596 = extractvalue %StructLayoutHeaderParse %t595, 0
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t598 = load i8*, i8** %l1
  %t599 = load i8*, i8** %l2
  %t600 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t601 = load i8*, i8** %l4
  %t602 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t603 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t604 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t605 = load i8*, i8** %l8
  %t606 = load i8*, i8** %l9
  %t607 = load i8*, i8** %l10
  %t608 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t609 = load double, double* %l12
  %t610 = load double, double* %l13
  %t611 = load i1, i1* %l14
  %t612 = load i1, i1* %l15
  %t613 = load double, double* %l16
  %t614 = load i8*, i8** %l18
  %t615 = load i8*, i8** %l23
  %t616 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t596, label %then44, label %merge45
then44:
  %t617 = load i1, i1* %l14
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t619 = load i8*, i8** %l1
  %t620 = load i8*, i8** %l2
  %t621 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t622 = load i8*, i8** %l4
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t624 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t625 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t626 = load i8*, i8** %l8
  %t627 = load i8*, i8** %l9
  %t628 = load i8*, i8** %l10
  %t629 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t630 = load double, double* %l12
  %t631 = load double, double* %l13
  %t632 = load i1, i1* %l14
  %t633 = load i1, i1* %l15
  %t634 = load double, double* %l16
  %t635 = load i8*, i8** %l18
  %t636 = load i8*, i8** %l23
  %t637 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t617, label %then46, label %else47
then46:
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s639 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.639, i32 0, i32 0
  %t640 = load i8*, i8** %l4
  %t641 = add i8* %s639, %t640
  %t642 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t638, i8* %t641)
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  br label %merge48
else47:
  %t643 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t644 = extractvalue %StructLayoutHeaderParse %t643, 2
  store double %t644, double* %l12
  %t645 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t646 = extractvalue %StructLayoutHeaderParse %t645, 3
  store double %t646, double* %l13
  store i1 1, i1* %l14
  br label %merge48
merge48:
  %t647 = phi { i8**, i64 }* [ %t642, %then46 ], [ %t618, %else47 ]
  %t648 = phi double [ %t630, %then46 ], [ %t644, %else47 ]
  %t649 = phi double [ %t631, %then46 ], [ %t646, %else47 ]
  %t650 = phi i1 [ %t632, %then46 ], [ 1, %else47 ]
  store { i8**, i64 }* %t647, { i8**, i64 }** %l0
  store double %t648, double* %l12
  store double %t649, double* %l13
  store i1 %t650, i1* %l14
  br label %merge45
merge45:
  %t651 = phi { i8**, i64 }* [ %t642, %then44 ], [ %t597, %then42 ]
  %t652 = phi double [ %t644, %then44 ], [ %t609, %then42 ]
  %t653 = phi double [ %t646, %then44 ], [ %t610, %then42 ]
  %t654 = phi i1 [ 1, %then44 ], [ %t611, %then42 ]
  store { i8**, i64 }* %t651, { i8**, i64 }** %l0
  store double %t652, double* %l12
  store double %t653, double* %l13
  store i1 %t654, i1* %l14
  %t655 = load double, double* %l16
  %t656 = sitofp i64 1 to double
  %t657 = fadd double %t655, %t656
  store double %t657, double* %l16
  br label %loop.latch2
merge43:
  %t658 = load i8*, i8** %l23
  %s659 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.659, i32 0, i32 0
  %t660 = call i1 @starts_with(i8* %t658, i8* %s659)
  %t661 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t662 = load i8*, i8** %l1
  %t663 = load i8*, i8** %l2
  %t664 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t665 = load i8*, i8** %l4
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t667 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t668 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t669 = load i8*, i8** %l8
  %t670 = load i8*, i8** %l9
  %t671 = load i8*, i8** %l10
  %t672 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t673 = load double, double* %l12
  %t674 = load double, double* %l13
  %t675 = load i1, i1* %l14
  %t676 = load i1, i1* %l15
  %t677 = load double, double* %l16
  %t678 = load i8*, i8** %l18
  %t679 = load i8*, i8** %l23
  br i1 %t660, label %then49, label %merge50
then49:
  %t680 = load i8*, i8** %l23
  %s681 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.681, i32 0, i32 0
  %t682 = call i8* @strip_prefix(i8* %t680, i8* %s681)
  %t683 = load i8*, i8** %l4
  %t684 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t682, i8* %t683)
  store %StructLayoutFieldParse %t684, %StructLayoutFieldParse* %l25
  %t685 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t686 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t687 = extractvalue %StructLayoutFieldParse %t686, 2
  %t688 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t685, { i8**, i64 }* %t687)
  store { i8**, i64 }* %t688, { i8**, i64 }** %l0
  %t689 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t690 = extractvalue %StructLayoutFieldParse %t689, 0
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t692 = load i8*, i8** %l1
  %t693 = load i8*, i8** %l2
  %t694 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t695 = load i8*, i8** %l4
  %t696 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t697 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t698 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t699 = load i8*, i8** %l8
  %t700 = load i8*, i8** %l9
  %t701 = load i8*, i8** %l10
  %t702 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t703 = load double, double* %l12
  %t704 = load double, double* %l13
  %t705 = load i1, i1* %l14
  %t706 = load i1, i1* %l15
  %t707 = load double, double* %l16
  %t708 = load i8*, i8** %l18
  %t709 = load i8*, i8** %l23
  %t710 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t690, label %then51, label %merge52
then51:
  %t711 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t712 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t713 = extractvalue %StructLayoutFieldParse %t712, 1
  %t714 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t711, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t714, { %NativeStructLayoutField*, i64 }** %l11
  %t715 = load i1, i1* %l14
  %t716 = xor i1 %t715, 1
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t718 = load i8*, i8** %l1
  %t719 = load i8*, i8** %l2
  %t720 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t721 = load i8*, i8** %l4
  %t722 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t723 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t724 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t725 = load i8*, i8** %l8
  %t726 = load i8*, i8** %l9
  %t727 = load i8*, i8** %l10
  %t728 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t729 = load double, double* %l12
  %t730 = load double, double* %l13
  %t731 = load i1, i1* %l14
  %t732 = load i1, i1* %l15
  %t733 = load double, double* %l16
  %t734 = load i8*, i8** %l18
  %t735 = load i8*, i8** %l23
  %t736 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t716, label %then53, label %merge54
then53:
  %t737 = load i1, i1* %l15
  %t738 = xor i1 %t737, 1
  %t739 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t740 = load i8*, i8** %l1
  %t741 = load i8*, i8** %l2
  %t742 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t743 = load i8*, i8** %l4
  %t744 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t745 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t746 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t747 = load i8*, i8** %l8
  %t748 = load i8*, i8** %l9
  %t749 = load i8*, i8** %l10
  %t750 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t751 = load double, double* %l12
  %t752 = load double, double* %l13
  %t753 = load i1, i1* %l14
  %t754 = load i1, i1* %l15
  %t755 = load double, double* %l16
  %t756 = load i8*, i8** %l18
  %t757 = load i8*, i8** %l23
  %t758 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t738, label %then55, label %merge56
then55:
  %t759 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s760 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.760, i32 0, i32 0
  %t761 = load i8*, i8** %l4
  %t762 = add i8* %s760, %t761
  %s763 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.763, i32 0, i32 0
  %t764 = add i8* %t762, %s763
  %t765 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t759, i8* %t764)
  store { i8**, i64 }* %t765, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge56
merge56:
  %t766 = phi { i8**, i64 }* [ %t765, %then55 ], [ %t739, %then53 ]
  %t767 = phi i1 [ 1, %then55 ], [ %t754, %then53 ]
  store { i8**, i64 }* %t766, { i8**, i64 }** %l0
  store i1 %t767, i1* %l15
  br label %merge54
merge54:
  %t768 = phi { i8**, i64 }* [ %t765, %then53 ], [ %t717, %then51 ]
  %t769 = phi i1 [ 1, %then53 ], [ %t732, %then51 ]
  store { i8**, i64 }* %t768, { i8**, i64 }** %l0
  store i1 %t769, i1* %l15
  br label %merge52
merge52:
  %t770 = phi { %NativeStructLayoutField*, i64 }* [ %t714, %then51 ], [ %t702, %then49 ]
  %t771 = phi { i8**, i64 }* [ %t765, %then51 ], [ %t691, %then49 ]
  %t772 = phi i1 [ 1, %then51 ], [ %t706, %then49 ]
  store { %NativeStructLayoutField*, i64 }* %t770, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t771, { i8**, i64 }** %l0
  store i1 %t772, i1* %l15
  %t773 = load double, double* %l16
  %t774 = sitofp i64 1 to double
  %t775 = fadd double %t773, %t774
  store double %t775, double* %l16
  br label %loop.latch2
merge50:
  %t776 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s777 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.777, i32 0, i32 0
  %t778 = load i8*, i8** %l18
  %t779 = add i8* %s777, %t778
  %t780 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t776, i8* %t779)
  store { i8**, i64 }* %t780, { i8**, i64 }** %l0
  %t781 = load double, double* %l16
  %t782 = sitofp i64 1 to double
  %t783 = fadd double %t781, %t782
  store double %t783, double* %l16
  br label %loop.latch2
merge41:
  %t784 = load i8*, i8** %l18
  %s785 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.785, i32 0, i32 0
  %t786 = icmp eq i8* %t784, %s785
  %t787 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t788 = load i8*, i8** %l1
  %t789 = load i8*, i8** %l2
  %t790 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t791 = load i8*, i8** %l4
  %t792 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t793 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t794 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t795 = load i8*, i8** %l8
  %t796 = load i8*, i8** %l9
  %t797 = load i8*, i8** %l10
  %t798 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t799 = load double, double* %l12
  %t800 = load double, double* %l13
  %t801 = load i1, i1* %l14
  %t802 = load i1, i1* %l15
  %t803 = load double, double* %l16
  %t804 = load i8*, i8** %l18
  br i1 %t786, label %then57, label %merge58
then57:
  %t805 = load double, double* %l16
  %t806 = sitofp i64 1 to double
  %t807 = fadd double %t805, %t806
  store double %t807, double* %l16
  br label %loop.latch2
merge58:
  %t808 = load i8*, i8** %l18
  %s809 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.809, i32 0, i32 0
  %t810 = call i1 @starts_with(i8* %t808, i8* %s809)
  %t811 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t812 = load i8*, i8** %l1
  %t813 = load i8*, i8** %l2
  %t814 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t815 = load i8*, i8** %l4
  %t816 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t817 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t818 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t819 = load i8*, i8** %l8
  %t820 = load i8*, i8** %l9
  %t821 = load i8*, i8** %l10
  %t822 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t823 = load double, double* %l12
  %t824 = load double, double* %l13
  %t825 = load i1, i1* %l14
  %t826 = load i1, i1* %l15
  %t827 = load double, double* %l16
  %t828 = load i8*, i8** %l18
  br i1 %t810, label %then59, label %merge60
then59:
  %t829 = load i8*, i8** %l18
  %s830 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.830, i32 0, i32 0
  %t831 = call i8* @strip_prefix(i8* %t829, i8* %s830)
  %t832 = call double @parse_struct_field_line(i8* %t831)
  store double %t832, double* %l26
  %t833 = load double, double* %l26
  %t834 = load double, double* %l16
  %t835 = sitofp i64 1 to double
  %t836 = fadd double %t834, %t835
  store double %t836, double* %l16
  br label %loop.latch2
merge60:
  %t837 = load i8*, i8** %l18
  %s838 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.838, i32 0, i32 0
  %t839 = call i1 @starts_with(i8* %t837, i8* %s838)
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t841 = load i8*, i8** %l1
  %t842 = load i8*, i8** %l2
  %t843 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t844 = load i8*, i8** %l4
  %t845 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t846 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t847 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t848 = load i8*, i8** %l8
  %t849 = load i8*, i8** %l9
  %t850 = load i8*, i8** %l10
  %t851 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t852 = load double, double* %l12
  %t853 = load double, double* %l13
  %t854 = load i1, i1* %l14
  %t855 = load i1, i1* %l15
  %t856 = load double, double* %l16
  %t857 = load i8*, i8** %l18
  br i1 %t839, label %then61, label %merge62
then61:
  %t858 = load i8*, i8** %l8
  %t859 = icmp ne i8* %t858, null
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t861 = load i8*, i8** %l1
  %t862 = load i8*, i8** %l2
  %t863 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t864 = load i8*, i8** %l4
  %t865 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t866 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t867 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t868 = load i8*, i8** %l8
  %t869 = load i8*, i8** %l9
  %t870 = load i8*, i8** %l10
  %t871 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t872 = load double, double* %l12
  %t873 = load double, double* %l13
  %t874 = load i1, i1* %l14
  %t875 = load i1, i1* %l15
  %t876 = load double, double* %l16
  %t877 = load i8*, i8** %l18
  br i1 %t859, label %then63, label %merge64
then63:
  %t878 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s879 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.879, i32 0, i32 0
  %t880 = load i8*, i8** %l4
  %t881 = add i8* %s879, %t880
  %t882 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t878, i8* %t881)
  store { i8**, i64 }* %t882, { i8**, i64 }** %l0
  br label %merge64
merge64:
  %t883 = phi { i8**, i64 }* [ %t882, %then63 ], [ %t860, %then61 ]
  store { i8**, i64 }* %t883, { i8**, i64 }** %l0
  %t884 = load i8*, i8** %l18
  %s885 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.885, i32 0, i32 0
  %t886 = call i8* @strip_prefix(i8* %t884, i8* %s885)
  %t887 = call i8* @parse_function_name(i8* %t886)
  store i8* %t887, i8** %l27
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t888 = load double, double* %l16
  %t889 = sitofp i64 1 to double
  %t890 = fadd double %t888, %t889
  store double %t890, double* %l16
  br label %loop.latch2
merge62:
  %t891 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s892 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.892, i32 0, i32 0
  %t893 = load i8*, i8** %l18
  %t894 = add i8* %s892, %t893
  %t895 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t891, i8* %t894)
  store { i8**, i64 }* %t895, { i8**, i64 }** %l0
  %t896 = load double, double* %l16
  %t897 = sitofp i64 1 to double
  %t898 = fadd double %t896, %t897
  store double %t898, double* %l16
  br label %loop.latch2
loop.latch2:
  %t899 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t900 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t901 = load i8*, i8** %l8
  %t902 = load i8*, i8** %l9
  %t903 = load i8*, i8** %l10
  %t904 = load double, double* %l16
  %t905 = load double, double* %l12
  %t906 = load double, double* %l13
  %t907 = load i1, i1* %l14
  %t908 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t909 = load i1, i1* %l15
  br label %loop.header0
afterloop3:
  store i8* null, i8** %l28
  %t921 = load i1, i1* %l14
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t923 = load i8*, i8** %l1
  %t924 = load i8*, i8** %l2
  %t925 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t926 = load i8*, i8** %l4
  %t927 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t928 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t929 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t930 = load i8*, i8** %l8
  %t931 = load i8*, i8** %l9
  %t932 = load i8*, i8** %l10
  %t933 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t934 = load double, double* %l12
  %t935 = load double, double* %l13
  %t936 = load i1, i1* %l14
  %t937 = load i1, i1* %l15
  %t938 = load double, double* %l16
  %t939 = load i8*, i8** %l28
  br i1 %t921, label %then65, label %merge66
then65:
  %t940 = load double, double* %l12
  %t941 = insertvalue %NativeStructLayout undef, double %t940, 0
  %t942 = load double, double* %l13
  %t943 = insertvalue %NativeStructLayout %t941, double %t942, 1
  %t944 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t945 = bitcast { %NativeStructLayoutField*, i64 }* %t944 to { i8**, i64 }*
  %t946 = insertvalue %NativeStructLayout %t943, { i8**, i64 }* %t945, 2
  store i8* null, i8** %l28
  br label %merge66
merge66:
  %t947 = phi i8* [ null, %then65 ], [ %t939, %entry ]
  store i8* %t947, i8** %l28
  %t948 = load i8*, i8** %l4
  %t949 = insertvalue %NativeStruct undef, i8* %t948, 0
  %t950 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t951 = bitcast { %NativeStructField*, i64 }* %t950 to { i8**, i64 }*
  %t952 = insertvalue %NativeStruct %t949, { i8**, i64 }* %t951, 1
  %t953 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t954 = bitcast { %NativeFunction*, i64 }* %t953 to { i8**, i64 }*
  %t955 = insertvalue %NativeStruct %t952, { i8**, i64 }* %t954, 2
  %t956 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t957 = insertvalue %NativeStruct %t955, { i8**, i64 }* %t956, 3
  %t958 = load i8*, i8** %l28
  %t959 = insertvalue %NativeStruct %t957, i8* %t958, 4
  %t960 = insertvalue %StructParseResult undef, i8* null, 0
  %t961 = load double, double* %l16
  %t962 = insertvalue %StructParseResult %t960, double %t961, 1
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t964 = insertvalue %StructParseResult %t962, { i8**, i64 }* %t963, 2
  ret %StructParseResult %t964
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
  %t5 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %start_index, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %start_index
  %t10 = load i8*, i8** %t9
  %t11 = call i8* @trim_text(i8* %t10)
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i8* @strip_prefix(i8* %t12, i8* %s13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  %t17 = call %InterfaceHeaderParse @parse_interface_header(i8* %t16)
  store %InterfaceHeaderParse %t17, %InterfaceHeaderParse* %l3
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t20 = extractvalue %InterfaceHeaderParse %t19, 2
  %t21 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t18, { i8**, i64 }* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  %t22 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t23 = extractvalue %InterfaceHeaderParse %t22, 0
  store i8* %t23, i8** %l4
  %t24 = load i8*, i8** %l4
  %t25 = alloca [0 x %NativeInterfaceSignature]
  %t26 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* %t25, i32 0, i32 0
  %t27 = alloca { %NativeInterfaceSignature*, i64 }
  %t28 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t27, i32 0, i32 0
  store %NativeInterfaceSignature* %t26, %NativeInterfaceSignature** %t28
  %t29 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { %NativeInterfaceSignature*, i64 }* %t27, { %NativeInterfaceSignature*, i64 }** %l5
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %start_index, %t30
  store double %t31, double* %l6
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l1
  %t34 = load i8*, i8** %l2
  %t35 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t36 = load i8*, i8** %l4
  %t37 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t38 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t165 = phi { i8**, i64 }* [ %t32, %entry ], [ %t162, %loop.latch2 ]
  %t166 = phi double [ %t38, %entry ], [ %t163, %loop.latch2 ]
  %t167 = phi { %NativeInterfaceSignature*, i64 }* [ %t37, %entry ], [ %t164, %loop.latch2 ]
  store { i8**, i64 }* %t165, { i8**, i64 }** %l0
  store double %t166, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t167, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body1
loop.body1:
  %t39 = load double, double* %l6
  %t40 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t39, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i8*, i8** %l2
  %t47 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t50 = load double, double* %l6
  br i1 %t43, label %then4, label %merge5
then4:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s52 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.52, i32 0, i32 0
  %t53 = load i8*, i8** %l4
  %t54 = add i8* %s52, %t53
  %t55 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t51, i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l4
  %t57 = insertvalue %NativeInterface undef, i8* %t56, 0
  %t58 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t59 = extractvalue %InterfaceHeaderParse %t58, 1
  %t60 = insertvalue %NativeInterface %t57, { i8**, i64 }* %t59, 1
  %t61 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t62 = bitcast { %NativeInterfaceSignature*, i64 }* %t61 to { i8**, i64 }*
  %t63 = insertvalue %NativeInterface %t60, { i8**, i64 }* %t62, 2
  %t64 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t65 = load double, double* %l6
  %t66 = insertvalue %InterfaceParseResult %t64, double %t65, 1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = insertvalue %InterfaceParseResult %t66, { i8**, i64 }* %t67, 2
  ret %InterfaceParseResult %t68
merge5:
  %t69 = load double, double* %l6
  %t70 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t71 = extractvalue { i8**, i64 } %t70, 0
  %t72 = extractvalue { i8**, i64 } %t70, 1
  %t73 = icmp uge i64 %t69, %t72
  ; bounds check: %t73 (if true, out of bounds)
  %t74 = getelementptr i8*, i8** %t71, i64 %t69
  %t75 = load i8*, i8** %t74
  %t76 = call i8* @trim_text(i8* %t75)
  store i8* %t76, i8** %l7
  %t78 = load i8*, i8** %l7
  %t79 = load i8*, i8** %l7
  %s80 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.80, i32 0, i32 0
  %t81 = icmp eq i8* %t79, %s80
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t86 = load i8*, i8** %l4
  %t87 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t88 = load double, double* %l6
  %t89 = load i8*, i8** %l7
  br i1 %t81, label %then6, label %merge7
then6:
  %t90 = load double, double* %l6
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l6
  br label %afterloop3
merge7:
  %t93 = load i8*, i8** %l7
  %s94 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.94, i32 0, i32 0
  %t95 = icmp eq i8* %t93, %s94
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = load i8*, i8** %l1
  %t98 = load i8*, i8** %l2
  %t99 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t100 = load i8*, i8** %l4
  %t101 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t102 = load double, double* %l6
  %t103 = load i8*, i8** %l7
  br i1 %t95, label %then8, label %merge9
then8:
  %t104 = load double, double* %l6
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l6
  br label %loop.latch2
merge9:
  %t107 = load i8*, i8** %l7
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.108, i32 0, i32 0
  %t109 = call i1 @starts_with(i8* %t107, i8* %s108)
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load i8*, i8** %l2
  %t113 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t114 = load i8*, i8** %l4
  %t115 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t116 = load double, double* %l6
  %t117 = load i8*, i8** %l7
  br i1 %t109, label %then10, label %merge11
then10:
  %t118 = load i8*, i8** %l7
  %s119 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.119, i32 0, i32 0
  %t120 = call i8* @strip_prefix(i8* %t118, i8* %s119)
  %t121 = load i8*, i8** %l4
  %t122 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t120, i8* %t121)
  store %InterfaceSignatureParse %t122, %InterfaceSignatureParse* %l8
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t125 = extractvalue %InterfaceSignatureParse %t124, 2
  %t126 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t123, { i8**, i64 }* %t125)
  store { i8**, i64 }* %t126, { i8**, i64 }** %l0
  %t127 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t128 = extractvalue %InterfaceSignatureParse %t127, 0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = load i8*, i8** %l1
  %t131 = load i8*, i8** %l2
  %t132 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t133 = load i8*, i8** %l4
  %t134 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t135 = load double, double* %l6
  %t136 = load i8*, i8** %l7
  %t137 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t128, label %then12, label %merge13
then12:
  %t138 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t139 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t140 = extractvalue %InterfaceSignatureParse %t139, 1
  %t141 = alloca [1 x i8*]
  %t142 = getelementptr [1 x i8*], [1 x i8*]* %t141, i32 0, i32 0
  %t143 = getelementptr i8*, i8** %t142, i64 0
  store i8* %t140, i8** %t143
  %t144 = alloca { i8**, i64 }
  %t145 = getelementptr { i8**, i64 }, { i8**, i64 }* %t144, i32 0, i32 0
  store i8** %t142, i8*** %t145
  %t146 = getelementptr { i8**, i64 }, { i8**, i64 }* %t144, i32 0, i32 1
  store i64 1, i64* %t146
  %t147 = bitcast { %NativeInterfaceSignature*, i64 }* %t138 to { i8**, i64 }*
  %t148 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t147, { i8**, i64 }* %t144)
  %t149 = bitcast { i8**, i64 }* %t148 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t149, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge13
merge13:
  %t150 = phi { %NativeInterfaceSignature*, i64 }* [ %t149, %then12 ], [ %t134, %then10 ]
  store { %NativeInterfaceSignature*, i64 }* %t150, { %NativeInterfaceSignature*, i64 }** %l5
  %t151 = load double, double* %l6
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l6
  br label %loop.latch2
merge11:
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s155 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.155, i32 0, i32 0
  %t156 = load i8*, i8** %l7
  %t157 = add i8* %s155, %t156
  %t158 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t154, i8* %t157)
  store { i8**, i64 }* %t158, { i8**, i64 }** %l0
  %t159 = load double, double* %l6
  %t160 = sitofp i64 1 to double
  %t161 = fadd double %t159, %t160
  store double %t161, double* %l6
  br label %loop.latch2
loop.latch2:
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load double, double* %l6
  %t164 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t168 = load i8*, i8** %l4
  %t169 = insertvalue %NativeInterface undef, i8* %t168, 0
  %t170 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t171 = extractvalue %InterfaceHeaderParse %t170, 1
  %t172 = insertvalue %NativeInterface %t169, { i8**, i64 }* %t171, 1
  %t173 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t174 = bitcast { %NativeInterfaceSignature*, i64 }* %t173 to { i8**, i64 }*
  %t175 = insertvalue %NativeInterface %t172, { i8**, i64 }* %t174, 2
  %t176 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t177 = load double, double* %l6
  %t178 = insertvalue %InterfaceParseResult %t176, double %t177, 1
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = insertvalue %InterfaceParseResult %t178, { i8**, i64 }* %t179, 2
  ret %InterfaceParseResult %t180
}

define %StructHeaderParse @parse_struct_header(i8* %text) {
entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
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
  %t10 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t11 = extractvalue %HeaderNameParse %t10, 0
  %t12 = insertvalue %StructHeaderParse undef, i8* %t11, 0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t14 = insertvalue %StructHeaderParse %t12, { i8**, i64 }* %t13, 1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = insertvalue %StructHeaderParse %t14, { i8**, i64 }* %t15, 2
  ret %StructHeaderParse %t16
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
  %t5 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t6 = extractvalue %HeaderNameParse %t5, 0
  %t7 = insertvalue %InterfaceHeaderParse undef, i8* %t6, 0
  %t8 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t9 = extractvalue %HeaderNameParse %t8, 1
  %t10 = insertvalue %InterfaceHeaderParse %t7, { i8**, i64 }* %t9, 1
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = insertvalue %InterfaceHeaderParse %t10, { i8**, i64 }* %t11, 2
  ret %InterfaceHeaderParse %t12
}

define %InterfaceSignatureParse @parse_interface_signature(i8* %text, i8* %interface_name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %l13 = alloca i8*
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  store double 0.0, double* %l1
  %t5 = call i8* @trim_text(i8* %text)
  %t6 = call i8* @trim_trailing_delimiters(i8* %t5)
  store i8* %t6, i8** %l2
  %t7 = load i8*, i8** %l2
  %t8 = load i8*, i8** %l2
  store i8* %t8, i8** %l3
  store i1 0, i1* %l4
  %t9 = load i8*, i8** %l3
  %s10 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i1 @starts_with(i8* %t9, i8* %s10)
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load double, double* %l1
  %t14 = load i8*, i8** %l2
  %t15 = load i8*, i8** %l3
  %t16 = load i1, i1* %l4
  br i1 %t11, label %then0, label %merge1
then0:
  store i1 1, i1* %l4
  %t17 = load i8*, i8** %l3
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.18, i32 0, i32 0
  %t19 = call i8* @strip_prefix(i8* %t17, i8* %s18)
  %t20 = call i8* @trim_text(i8* %t19)
  store i8* %t20, i8** %l3
  br label %merge1
merge1:
  %t21 = phi i1 [ 1, %then0 ], [ %t16, %entry ]
  %t22 = phi i8* [ %t20, %then0 ], [ %t15, %entry ]
  store i1 %t21, i1* %l4
  store i8* %t22, i8** %l3
  %t23 = load i8*, i8** %l3
  %t24 = call double @index_of(i8* %t23, i8* null)
  store double %t24, double* %l5
  %t25 = load double, double* %l5
  %t26 = sitofp i64 0 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l3
  %t32 = load i1, i1* %l4
  %t33 = load double, double* %l5
  br i1 %t27, label %then2, label %merge3
then2:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = add i8* %s35, %interface_name
  %s37 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %t36, %s37
  %t39 = load i8*, i8** %l2
  %t40 = add i8* %t38, %t39
  %t41 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  %t42 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t43 = load double, double* %l1
  %t44 = insertvalue %InterfaceSignatureParse %t42, i8* null, 1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = insertvalue %InterfaceSignatureParse %t44, { i8**, i64 }* %t45, 2
  ret %InterfaceSignatureParse %t46
merge3:
  %t47 = load i8*, i8** %l3
  %t48 = load double, double* %l5
  %t49 = call double @find_matching_paren(i8* %t47, double %t48)
  store double %t49, double* %l6
  %t50 = load double, double* %l6
  %t51 = sitofp i64 0 to double
  %t52 = fcmp olt double %t50, %t51
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l2
  %t56 = load i8*, i8** %l3
  %t57 = load i1, i1* %l4
  %t58 = load double, double* %l5
  %t59 = load double, double* %l6
  br i1 %t52, label %then4, label %merge5
then4:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s61 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.61, i32 0, i32 0
  %t62 = add i8* %s61, %interface_name
  %s63 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.63, i32 0, i32 0
  %t64 = add i8* %t62, %s63
  %t65 = load i8*, i8** %l2
  %t66 = add i8* %t64, %t65
  %t67 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t60, i8* %t66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t69 = load double, double* %l1
  %t70 = insertvalue %InterfaceSignatureParse %t68, i8* null, 1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = insertvalue %InterfaceSignatureParse %t70, { i8**, i64 }* %t71, 2
  ret %InterfaceSignatureParse %t72
merge5:
  %t73 = load i8*, i8** %l3
  %t74 = load double, double* %l5
  %t75 = fptosi double %t74 to i64
  %t76 = call i8* @sailfin_runtime_substring(i8* %t73, i64 0, i64 %t75)
  %t77 = call i8* @trim_text(i8* %t76)
  store i8* %t77, i8** %l7
  %t78 = load i8*, i8** %l7
  %t79 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t78)
  store %HeaderNameParse %t79, %HeaderNameParse* %l8
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t82 = extractvalue %HeaderNameParse %t81, 3
  %t83 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t80, { i8**, i64 }* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  %t84 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t85 = extractvalue %HeaderNameParse %t84, 2
  %t86 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t87 = extractvalue %HeaderNameParse %t86, 0
  store i8* %t87, i8** %l9
  %t88 = load i8*, i8** %l9
  %t89 = load i8*, i8** %l3
  %t90 = load double, double* %l5
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  %t93 = load double, double* %l6
  %t94 = fptosi double %t92 to i64
  %t95 = fptosi double %t93 to i64
  %t96 = call i8* @sailfin_runtime_substring(i8* %t89, i64 %t94, i64 %t95)
  store i8* %t96, i8** %l10
  %t97 = alloca [0 x %NativeParameter]
  %t98 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t97, i32 0, i32 0
  %t99 = alloca { %NativeParameter*, i64 }
  %t100 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t99, i32 0, i32 0
  store %NativeParameter* %t98, %NativeParameter** %t100
  %t101 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t99, i32 0, i32 1
  store i64 0, i64* %t101
  store { %NativeParameter*, i64 }* %t99, { %NativeParameter*, i64 }** %l11
  %t102 = load i8*, i8** %l10
  %t103 = call i8* @trim_text(i8* %t102)
  store i8* %t103, i8** %l12
  %t104 = load i8*, i8** %l12
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.105, i32 0, i32 0
  store i8* %s105, i8** %l13
  %t106 = alloca [0 x i8*]
  %t107 = getelementptr [0 x i8*], [0 x i8*]* %t106, i32 0, i32 0
  %t108 = alloca { i8**, i64 }
  %t109 = getelementptr { i8**, i64 }, { i8**, i64 }* %t108, i32 0, i32 0
  store i8** %t107, i8*** %t109
  %t110 = getelementptr { i8**, i64 }, { i8**, i64 }* %t108, i32 0, i32 1
  store i64 0, i64* %t110
  store { i8**, i64 }* %t108, { i8**, i64 }** %l14
  %t111 = load i8*, i8** %l3
  %t112 = load double, double* %l6
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  %t115 = load i8*, i8** %l3
  store double 0.0, double* %l15
  %t116 = load double, double* %l15
  store double 0.0, double* %l16
  %t118 = load i8*, i8** %l9
  store double 0.0, double* %l17
  %t119 = load double, double* %l17
  %t120 = fcmp one double %t119, 0.0
  %t121 = insertvalue %InterfaceSignatureParse undef, i1 %t120, 0
  %t122 = load double, double* %l16
  %t123 = insertvalue %InterfaceSignatureParse %t121, i8* null, 1
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = insertvalue %InterfaceSignatureParse %t123, { i8**, i64 }* %t124, 2
  ret %InterfaceSignatureParse %t125
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
  %t7 = load i8*, i8** %l1
  store i8* %t7, i8** %l2
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l3
  %t9 = alloca [0 x i8*]
  %t10 = getelementptr [0 x i8*], [0 x i8*]* %t9, i32 0, i32 0
  %t11 = alloca { i8**, i64 }
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t10, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* %t11, { i8**, i64 }** %l4
  %t14 = load i8*, i8** %l1
  store double 0.0, double* %l5
  %t15 = load double, double* %l5
  %t16 = sitofp i64 0 to double
  %t17 = fcmp oge double %t15, %t16
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load i8*, i8** %l2
  %t21 = load i8*, i8** %l3
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t23 = load double, double* %l5
  br i1 %t17, label %then0, label %else1
then0:
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l5
  %t26 = call double @find_matching_angle(i8* %t24, double %t25)
  store double %t26, double* %l6
  %t27 = load double, double* %l6
  %t28 = sitofp i64 0 to double
  %t29 = fcmp olt double %t27, %t28
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i8*, i8** %l2
  %t33 = load i8*, i8** %l3
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t35 = load double, double* %l5
  %t36 = load double, double* %l6
  br i1 %t29, label %then3, label %merge4
then3:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s38 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.38, i32 0, i32 0
  %t39 = add i8* %s38, %text
  %t40 = load i8*, i8** %l1
  %t41 = call i8* @strip_generics(i8* %t40)
  store i8* %t41, i8** %l2
  %t42 = load i8*, i8** %l2
  %t43 = insertvalue %HeaderNameParse undef, i8* %t42, 0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t45 = insertvalue %HeaderNameParse %t43, { i8**, i64 }* %t44, 1
  %t46 = load i8*, i8** %l3
  %t47 = insertvalue %HeaderNameParse %t45, i8* %t46, 2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = insertvalue %HeaderNameParse %t47, { i8**, i64 }* %t48, 3
  ret %HeaderNameParse %t49
merge4:
  %t50 = load i8*, i8** %l1
  %t51 = load double, double* %l5
  %t52 = fptosi double %t51 to i64
  %t53 = call i8* @sailfin_runtime_substring(i8* %t50, i64 0, i64 %t52)
  %t54 = call i8* @trim_text(i8* %t53)
  store i8* %t54, i8** %l2
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l5
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  %t59 = load double, double* %l6
  %t60 = fptosi double %t58 to i64
  %t61 = fptosi double %t59 to i64
  %t62 = call i8* @sailfin_runtime_substring(i8* %t55, i64 %t60, i64 %t61)
  store i8* %t62, i8** %l7
  %t63 = load i8*, i8** %l7
  %t64 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l4
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l6
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  %t69 = load i8*, i8** %l1
  br label %merge2
else1:
  %t70 = load i8*, i8** %l1
  %t71 = call double @index_of(i8* %t70, i8* null)
  store double %t71, double* %l8
  %t72 = load double, double* %l8
  %t73 = sitofp i64 0 to double
  %t74 = fcmp oge double %t72, %t73
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l2
  %t78 = load i8*, i8** %l3
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t80 = load double, double* %l5
  %t81 = load double, double* %l8
  br i1 %t74, label %then5, label %merge6
then5:
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l8
  %t84 = fptosi double %t83 to i64
  %t85 = call i8* @sailfin_runtime_substring(i8* %t82, i64 0, i64 %t84)
  %t86 = call i8* @trim_text(i8* %t85)
  store i8* %t86, i8** %l2
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l8
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  %t91 = load i8*, i8** %l1
  br label %merge6
merge6:
  %t92 = phi i8* [ %t86, %then5 ], [ %t77, %else1 ]
  %t93 = phi i8* [ null, %then5 ], [ %t78, %else1 ]
  store i8* %t92, i8** %l2
  store i8* %t93, i8** %l3
  br label %merge2
merge2:
  %t94 = phi { i8**, i64 }* [ null, %then0 ], [ %t18, %else1 ]
  %t95 = phi i8* [ %t41, %then0 ], [ %t86, %else1 ]
  %t96 = phi { i8**, i64 }* [ %t64, %then0 ], [ %t22, %else1 ]
  %t97 = phi i8* [ null, %then0 ], [ null, %else1 ]
  store { i8**, i64 }* %t94, { i8**, i64 }** %l0
  store i8* %t95, i8** %l2
  store { i8**, i64 }* %t96, { i8**, i64 }** %l4
  store i8* %t97, i8** %l3
  %t98 = load i8*, i8** %l2
  %t99 = call i8* @strip_generics(i8* %t98)
  store i8* %t99, i8** %l2
  %t100 = load i8*, i8** %l2
  %t101 = insertvalue %HeaderNameParse undef, i8* %t100, 0
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t103 = insertvalue %HeaderNameParse %t101, { i8**, i64 }* %t102, 1
  %t104 = load i8*, i8** %l3
  %t105 = insertvalue %HeaderNameParse %t103, i8* %t104, 2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = insertvalue %HeaderNameParse %t105, { i8**, i64 }* %t106, 3
  ret %HeaderNameParse %t107
}

define { i8**, i64 }* @parse_type_parameter_entries(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call { i8**, i64 }* @split_top_level_commas(i8* %t2)
  ret { i8**, i64 }* %t3
}

define { i8**, i64 }* @parse_implements_list(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call { i8**, i64 }* @split_top_level_commas(i8* %t2)
  ret { i8**, i64 }* %t3
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
  %t283 = phi i8* [ %t15, %entry ], [ %t277, %loop.latch2 ]
  %t284 = phi i8* [ %t13, %entry ], [ %t278, %loop.latch2 ]
  %t285 = phi double [ %t14, %entry ], [ %t279, %loop.latch2 ]
  %t286 = phi double [ %t17, %entry ], [ %t280, %loop.latch2 ]
  %t287 = phi double [ %t18, %entry ], [ %t281, %loop.latch2 ]
  %t288 = phi double [ %t19, %entry ], [ %t282, %loop.latch2 ]
  store i8* %t283, i8** %l3
  store i8* %t284, i8** %l1
  store double %t285, double* %l2
  store double %t286, double* %l5
  store double %t287, double* %l6
  store double %t288, double* %l7
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l2
  %t21 = load double, double* %l2
  %t22 = getelementptr i8, i8* %text, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l8
  %t24 = load i8*, i8** %l3
  %t26 = load i8, i8* %l8
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t27, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t28 = load i8, i8* %l8
  %t29 = icmp eq i8 %t28, 39
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t30 = phi i1 [ true, %logical_or_entry_25 ], [ %t29, %logical_or_right_end_25 ]
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load i8*, i8** %l3
  %t35 = load double, double* %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  %t38 = load double, double* %l7
  %t39 = load i8, i8* %l8
  br i1 %t30, label %then4, label %merge5
then4:
  %t40 = load i8, i8* %l8
  store i8* null, i8** %l3
  %t41 = load i8*, i8** %l1
  %t42 = load i8, i8* %l8
  %t43 = getelementptr i8, i8* %t41, i64 0
  %t44 = load i8, i8* %t43
  %t45 = add i8 %t44, %t42
  store i8* null, i8** %l1
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l2
  br label %loop.latch2
merge5:
  %t49 = load i8, i8* %l8
  %t50 = load i8, i8* %l8
  %t51 = load i8, i8* %l8
  %t52 = icmp eq i8 %t51, 40
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  %t56 = load i8*, i8** %l3
  %t57 = load double, double* %l4
  %t58 = load double, double* %l5
  %t59 = load double, double* %l6
  %t60 = load double, double* %l7
  %t61 = load i8, i8* %l8
  br i1 %t52, label %then6, label %merge7
then6:
  %t62 = load double, double* %l5
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l5
  %t65 = load i8*, i8** %l1
  %t66 = load i8, i8* %l8
  %t67 = getelementptr i8, i8* %t65, i64 0
  %t68 = load i8, i8* %t67
  %t69 = add i8 %t68, %t66
  store i8* null, i8** %l1
  %t70 = load double, double* %l2
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l2
  br label %loop.latch2
merge7:
  %t73 = load i8, i8* %l8
  %t74 = icmp eq i8 %t73, 41
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l2
  %t78 = load i8*, i8** %l3
  %t79 = load double, double* %l4
  %t80 = load double, double* %l5
  %t81 = load double, double* %l6
  %t82 = load double, double* %l7
  %t83 = load i8, i8* %l8
  br i1 %t74, label %then8, label %merge9
then8:
  %t84 = load double, double* %l5
  %t85 = sitofp i64 0 to double
  %t86 = fcmp ogt double %t84, %t85
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load i8*, i8** %l1
  %t89 = load double, double* %l2
  %t90 = load i8*, i8** %l3
  %t91 = load double, double* %l4
  %t92 = load double, double* %l5
  %t93 = load double, double* %l6
  %t94 = load double, double* %l7
  %t95 = load i8, i8* %l8
  br i1 %t86, label %then10, label %merge11
then10:
  %t96 = load double, double* %l5
  %t97 = sitofp i64 1 to double
  %t98 = fsub double %t96, %t97
  store double %t98, double* %l5
  br label %merge11
merge11:
  %t99 = phi double [ %t98, %then10 ], [ %t92, %then8 ]
  store double %t99, double* %l5
  %t100 = load i8*, i8** %l1
  %t101 = load i8, i8* %l8
  %t102 = getelementptr i8, i8* %t100, i64 0
  %t103 = load i8, i8* %t102
  %t104 = add i8 %t103, %t101
  store i8* null, i8** %l1
  %t105 = load double, double* %l2
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l2
  br label %loop.latch2
merge9:
  %t108 = load i8, i8* %l8
  %t109 = icmp eq i8 %t108, 91
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load i8*, i8** %l3
  %t114 = load double, double* %l4
  %t115 = load double, double* %l5
  %t116 = load double, double* %l6
  %t117 = load double, double* %l7
  %t118 = load i8, i8* %l8
  br i1 %t109, label %then12, label %merge13
then12:
  %t119 = load double, double* %l6
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l6
  %t122 = load i8*, i8** %l1
  %t123 = load i8, i8* %l8
  %t124 = getelementptr i8, i8* %t122, i64 0
  %t125 = load i8, i8* %t124
  %t126 = add i8 %t125, %t123
  store i8* null, i8** %l1
  %t127 = load double, double* %l2
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l2
  br label %loop.latch2
merge13:
  %t130 = load i8, i8* %l8
  %t131 = icmp eq i8 %t130, 93
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load i8*, i8** %l1
  %t134 = load double, double* %l2
  %t135 = load i8*, i8** %l3
  %t136 = load double, double* %l4
  %t137 = load double, double* %l5
  %t138 = load double, double* %l6
  %t139 = load double, double* %l7
  %t140 = load i8, i8* %l8
  br i1 %t131, label %then14, label %merge15
then14:
  %t141 = load double, double* %l6
  %t142 = sitofp i64 0 to double
  %t143 = fcmp ogt double %t141, %t142
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
  %t153 = load double, double* %l6
  %t154 = sitofp i64 1 to double
  %t155 = fsub double %t153, %t154
  store double %t155, double* %l6
  br label %merge17
merge17:
  %t156 = phi double [ %t155, %then16 ], [ %t150, %then14 ]
  store double %t156, double* %l6
  %t157 = load i8*, i8** %l1
  %t158 = load i8, i8* %l8
  %t159 = getelementptr i8, i8* %t157, i64 0
  %t160 = load i8, i8* %t159
  %t161 = add i8 %t160, %t158
  store i8* null, i8** %l1
  %t162 = load double, double* %l2
  %t163 = sitofp i64 1 to double
  %t164 = fadd double %t162, %t163
  store double %t164, double* %l2
  br label %loop.latch2
merge15:
  %t165 = load i8, i8* %l8
  %t166 = icmp eq i8 %t165, 123
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l2
  %t170 = load i8*, i8** %l3
  %t171 = load double, double* %l4
  %t172 = load double, double* %l5
  %t173 = load double, double* %l6
  %t174 = load double, double* %l7
  %t175 = load i8, i8* %l8
  br i1 %t166, label %then18, label %merge19
then18:
  %t176 = load double, double* %l7
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l7
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
  %t188 = icmp eq i8 %t187, 125
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load i8*, i8** %l3
  %t193 = load double, double* %l4
  %t194 = load double, double* %l5
  %t195 = load double, double* %l6
  %t196 = load double, double* %l7
  %t197 = load i8, i8* %l8
  br i1 %t188, label %then20, label %merge21
then20:
  %t198 = load double, double* %l7
  %t199 = sitofp i64 0 to double
  %t200 = fcmp ogt double %t198, %t199
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load i8*, i8** %l1
  %t203 = load double, double* %l2
  %t204 = load i8*, i8** %l3
  %t205 = load double, double* %l4
  %t206 = load double, double* %l5
  %t207 = load double, double* %l6
  %t208 = load double, double* %l7
  %t209 = load i8, i8* %l8
  br i1 %t200, label %then22, label %merge23
then22:
  %t210 = load double, double* %l7
  %t211 = sitofp i64 1 to double
  %t212 = fsub double %t210, %t211
  store double %t212, double* %l7
  br label %merge23
merge23:
  %t213 = phi double [ %t212, %then22 ], [ %t208, %then20 ]
  store double %t213, double* %l7
  %t214 = load i8*, i8** %l1
  %t215 = load i8, i8* %l8
  %t216 = getelementptr i8, i8* %t214, i64 0
  %t217 = load i8, i8* %t216
  %t218 = add i8 %t217, %t215
  store i8* null, i8** %l1
  %t219 = load double, double* %l2
  %t220 = sitofp i64 1 to double
  %t221 = fadd double %t219, %t220
  store double %t221, double* %l2
  br label %loop.latch2
merge21:
  %t222 = load i8, i8* %l8
  %t223 = icmp eq i8 %t222, 44
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load i8*, i8** %l1
  %t226 = load double, double* %l2
  %t227 = load i8*, i8** %l3
  %t228 = load double, double* %l4
  %t229 = load double, double* %l5
  %t230 = load double, double* %l6
  %t231 = load double, double* %l7
  %t232 = load i8, i8* %l8
  br i1 %t223, label %then24, label %merge25
then24:
  %t236 = load double, double* %l4
  %t237 = sitofp i64 0 to double
  %t238 = fcmp oeq double %t236, %t237
  br label %logical_and_entry_235

logical_and_entry_235:
  br i1 %t238, label %logical_and_right_235, label %logical_and_merge_235

logical_and_right_235:
  %t239 = load double, double* %l5
  %t240 = sitofp i64 0 to double
  %t241 = fcmp oeq double %t239, %t240
  br label %logical_and_right_end_235

logical_and_right_end_235:
  br label %logical_and_merge_235

logical_and_merge_235:
  %t242 = phi i1 [ false, %logical_and_entry_235 ], [ %t241, %logical_and_right_end_235 ]
  br label %logical_and_entry_234

logical_and_entry_234:
  br i1 %t242, label %logical_and_right_234, label %logical_and_merge_234

logical_and_right_234:
  %t243 = load double, double* %l6
  %t244 = sitofp i64 0 to double
  %t245 = fcmp oeq double %t243, %t244
  br label %logical_and_right_end_234

logical_and_right_end_234:
  br label %logical_and_merge_234

logical_and_merge_234:
  %t246 = phi i1 [ false, %logical_and_entry_234 ], [ %t245, %logical_and_right_end_234 ]
  br label %logical_and_entry_233

logical_and_entry_233:
  br i1 %t246, label %logical_and_right_233, label %logical_and_merge_233

logical_and_right_233:
  %t247 = load double, double* %l7
  %t248 = sitofp i64 0 to double
  %t249 = fcmp oeq double %t247, %t248
  br label %logical_and_right_end_233

logical_and_right_end_233:
  br label %logical_and_merge_233

logical_and_merge_233:
  %t250 = phi i1 [ false, %logical_and_entry_233 ], [ %t249, %logical_and_right_end_233 ]
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load i8*, i8** %l1
  %t253 = load double, double* %l2
  %t254 = load i8*, i8** %l3
  %t255 = load double, double* %l4
  %t256 = load double, double* %l5
  %t257 = load double, double* %l6
  %t258 = load double, double* %l7
  %t259 = load i8, i8* %l8
  br i1 %t250, label %then26, label %merge27
then26:
  %t260 = load i8*, i8** %l1
  %t261 = call i8* @trim_text(i8* %t260)
  store i8* %t261, i8** %l9
  %t262 = load i8*, i8** %l9
  %s263 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.263, i32 0, i32 0
  store i8* %s263, i8** %l1
  %t264 = load double, double* %l2
  %t265 = sitofp i64 1 to double
  %t266 = fadd double %t264, %t265
  store double %t266, double* %l2
  br label %loop.latch2
merge27:
  br label %merge25
merge25:
  %t267 = phi i8* [ %s263, %then24 ], [ %t225, %loop.body1 ]
  %t268 = phi double [ %t266, %then24 ], [ %t226, %loop.body1 ]
  store i8* %t267, i8** %l1
  store double %t268, double* %l2
  %t269 = load i8*, i8** %l1
  %t270 = load i8, i8* %l8
  %t271 = getelementptr i8, i8* %t269, i64 0
  %t272 = load i8, i8* %t271
  %t273 = add i8 %t272, %t270
  store i8* null, i8** %l1
  %t274 = load double, double* %l2
  %t275 = sitofp i64 1 to double
  %t276 = fadd double %t274, %t275
  store double %t276, double* %l2
  br label %loop.latch2
loop.latch2:
  %t277 = load i8*, i8** %l3
  %t278 = load i8*, i8** %l1
  %t279 = load double, double* %l2
  %t280 = load double, double* %l5
  %t281 = load double, double* %l6
  %t282 = load double, double* %l7
  br label %loop.header0
afterloop3:
  %t289 = load i8*, i8** %l1
  %t290 = call i8* @trim_text(i8* %t289)
  store i8* %t290, i8** %l10
  %t291 = load i8*, i8** %l10
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t292
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
  %t12 = phi double [ %t2, %entry ], [ %t11, %loop.latch2 ]
  store double %t12, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  %t8 = load double, double* %l1
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l1
  br label %loop.latch2
loop.latch2:
  %t11 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
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
  %t92 = phi double [ %t2, %entry ], [ %t90, %loop.latch2 ]
  %t93 = phi double [ %t1, %entry ], [ %t91, %loop.latch2 ]
  store double %t92, double* %l1
  store double %t93, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = icmp eq i8 %t8, 34
  br label %logical_or_entry_7

logical_or_entry_7:
  br i1 %t9, label %logical_or_merge_7, label %logical_or_right_7

logical_or_right_7:
  %t10 = load i8, i8* %l2
  %t11 = icmp eq i8 %t10, 39
  br label %logical_or_right_end_7

logical_or_right_end_7:
  br label %logical_or_merge_7

logical_or_merge_7:
  %t12 = phi i1 [ true, %logical_or_entry_7 ], [ %t11, %logical_or_right_end_7 ]
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then4, label %else5
then4:
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l3
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i8, i8* %l2
  %t22 = load double, double* %l3
  br label %loop.header7
loop.header7:
  %t51 = phi double [ %t22, %then4 ], [ %t49, %loop.latch9 ]
  %t52 = phi double [ %t20, %then4 ], [ %t50, %loop.latch9 ]
  store double %t51, double* %l3
  store double %t52, double* %l1
  br label %loop.body8
loop.body8:
  %t23 = load double, double* %l3
  %t24 = load double, double* %l3
  %t25 = getelementptr i8, i8* %text, i64 %t24
  %t26 = load i8, i8* %t25
  store i8 %t26, i8* %l4
  %t27 = load i8, i8* %l4
  %t28 = icmp eq i8 %t27, 92
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8, i8* %l2
  %t32 = load double, double* %l3
  %t33 = load i8, i8* %l4
  br i1 %t28, label %then11, label %merge12
then11:
  %t34 = load double, double* %l3
  %t35 = sitofp i64 2 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l3
  br label %loop.latch9
merge12:
  %t37 = load i8, i8* %l4
  %t38 = load i8, i8* %l2
  %t39 = icmp eq i8 %t37, %t38
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  %t42 = load i8, i8* %l2
  %t43 = load double, double* %l3
  %t44 = load i8, i8* %l4
  br i1 %t39, label %then13, label %merge14
then13:
  %t45 = load double, double* %l3
  store double %t45, double* %l1
  br label %afterloop10
merge14:
  %t46 = load double, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l3
  br label %loop.latch9
loop.latch9:
  %t49 = load double, double* %l3
  %t50 = load double, double* %l1
  br label %loop.header7
afterloop10:
  br label %merge6
else5:
  %t53 = load i8, i8* %l2
  %t54 = icmp eq i8 %t53, 40
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load i8, i8* %l2
  br i1 %t54, label %then15, label %else16
then15:
  %t58 = load double, double* %l0
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l0
  br label %merge17
else16:
  %t61 = load i8, i8* %l2
  %t62 = icmp eq i8 %t61, 41
  %t63 = load double, double* %l0
  %t64 = load double, double* %l1
  %t65 = load i8, i8* %l2
  br i1 %t62, label %then18, label %merge19
then18:
  %t66 = load double, double* %l0
  %t67 = sitofp i64 0 to double
  %t68 = fcmp ogt double %t66, %t67
  %t69 = load double, double* %l0
  %t70 = load double, double* %l1
  %t71 = load i8, i8* %l2
  br i1 %t68, label %then20, label %else21
then20:
  %t72 = load double, double* %l0
  %t73 = sitofp i64 1 to double
  %t74 = fsub double %t72, %t73
  store double %t74, double* %l0
  %t75 = load double, double* %l0
  %t76 = sitofp i64 0 to double
  %t77 = fcmp oeq double %t75, %t76
  %t78 = load double, double* %l0
  %t79 = load double, double* %l1
  %t80 = load i8, i8* %l2
  br i1 %t77, label %then23, label %merge24
then23:
  %t81 = load double, double* %l1
  ret double %t81
merge24:
  br label %merge22
else21:
  %t82 = sitofp i64 -1 to double
  ret double %t82
merge22:
  br label %merge19
merge19:
  %t83 = phi double [ %t74, %then18 ], [ %t63, %else16 ]
  store double %t83, double* %l0
  br label %merge17
merge17:
  %t84 = phi double [ %t60, %then15 ], [ %t74, %else16 ]
  store double %t84, double* %l0
  br label %merge6
merge6:
  %t85 = phi double [ %t45, %then4 ], [ %t14, %else5 ]
  %t86 = phi double [ %t13, %then4 ], [ %t60, %else5 ]
  store double %t85, double* %l1
  store double %t86, double* %l0
  %t87 = load double, double* %l1
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l1
  br label %loop.latch2
loop.latch2:
  %t90 = load double, double* %l1
  %t91 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t94 = sitofp i64 -1 to double
  ret double %t94
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
  %t5 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %start_index, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %start_index
  %t10 = load i8*, i8** %t9
  %t11 = call i8* @trim_text(i8* %t10)
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.13, i32 0, i32 0
  %t14 = call i8* @strip_prefix(i8* %t12, i8* %s13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  store i8* %t16, i8** %l3
  %t17 = load i8*, i8** %l3
  %t18 = call double @index_of(i8* %t17, i8* null)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = sitofp i64 0 to double
  %t21 = fcmp oge double %t19, %t20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load i8*, i8** %l2
  %t25 = load i8*, i8** %l3
  %t26 = load double, double* %l4
  br i1 %t21, label %then0, label %merge1
then0:
  %t27 = load i8*, i8** %l3
  %t28 = load double, double* %l4
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 0, i64 %t29)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l3
  br label %merge1
merge1:
  %t32 = phi i8* [ %t31, %then0 ], [ %t25, %entry ]
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = call i8* @strip_generics(i8* %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = alloca [0 x %NativeEnumVariant]
  %t37 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* %t36, i32 0, i32 0
  %t38 = alloca { %NativeEnumVariant*, i64 }
  %t39 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t38, i32 0, i32 0
  store %NativeEnumVariant* %t37, %NativeEnumVariant** %t39
  %t40 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { %NativeEnumVariant*, i64 }* %t38, { %NativeEnumVariant*, i64 }** %l5
  %t41 = alloca [0 x %NativeEnumVariantLayout]
  %t42 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t41, i32 0, i32 0
  %t43 = alloca { %NativeEnumVariantLayout*, i64 }
  %t44 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t43, i32 0, i32 0
  store %NativeEnumVariantLayout* %t42, %NativeEnumVariantLayout** %t44
  %t45 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { %NativeEnumVariantLayout*, i64 }* %t43, { %NativeEnumVariantLayout*, i64 }** %l6
  %t46 = sitofp i64 0 to double
  store double %t46, double* %l7
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l8
  %s48 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.48, i32 0, i32 0
  store i8* %s48, i8** %l9
  %t49 = sitofp i64 0 to double
  store double %t49, double* %l10
  %t50 = sitofp i64 0 to double
  store double %t50, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %start_index, %t51
  store double %t52, double* %l14
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load i8*, i8** %l2
  %t56 = load i8*, i8** %l3
  %t57 = load double, double* %l4
  %t58 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t59 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t60 = load double, double* %l7
  %t61 = load double, double* %l8
  %t62 = load i8*, i8** %l9
  %t63 = load double, double* %l10
  %t64 = load double, double* %l11
  %t65 = load i1, i1* %l12
  %t66 = load i1, i1* %l13
  %t67 = load double, double* %l14
  br label %loop.header2
loop.header2:
  %t650 = phi { i8**, i64 }* [ %t53, %entry ], [ %t640, %loop.latch4 ]
  %t651 = phi double [ %t67, %entry ], [ %t641, %loop.latch4 ]
  %t652 = phi double [ %t60, %entry ], [ %t642, %loop.latch4 ]
  %t653 = phi double [ %t61, %entry ], [ %t643, %loop.latch4 ]
  %t654 = phi i8* [ %t62, %entry ], [ %t644, %loop.latch4 ]
  %t655 = phi double [ %t63, %entry ], [ %t645, %loop.latch4 ]
  %t656 = phi double [ %t64, %entry ], [ %t646, %loop.latch4 ]
  %t657 = phi i1 [ %t65, %entry ], [ %t647, %loop.latch4 ]
  %t658 = phi { %NativeEnumVariantLayout*, i64 }* [ %t59, %entry ], [ %t648, %loop.latch4 ]
  %t659 = phi i1 [ %t66, %entry ], [ %t649, %loop.latch4 ]
  store { i8**, i64 }* %t650, { i8**, i64 }** %l0
  store double %t651, double* %l14
  store double %t652, double* %l7
  store double %t653, double* %l8
  store i8* %t654, i8** %l9
  store double %t655, double* %l10
  store double %t656, double* %l11
  store i1 %t657, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t658, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t659, i1* %l13
  br label %loop.body3
loop.body3:
  %t68 = load double, double* %l14
  %t69 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t70 = extractvalue { i8**, i64 } %t69, 1
  %t71 = sitofp i64 %t70 to double
  %t72 = fcmp oge double %t68, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  %t77 = load double, double* %l4
  %t78 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t79 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t80 = load double, double* %l7
  %t81 = load double, double* %l8
  %t82 = load i8*, i8** %l9
  %t83 = load double, double* %l10
  %t84 = load double, double* %l11
  %t85 = load i1, i1* %l12
  %t86 = load i1, i1* %l13
  %t87 = load double, double* %l14
  br i1 %t72, label %then6, label %merge7
then6:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s89 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.89, i32 0, i32 0
  %t90 = load i8*, i8** %l3
  %t91 = add i8* %s89, %t90
  %t92 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t88, i8* %t91)
  store { i8**, i64 }* %t92, { i8**, i64 }** %l0
  store i8* null, i8** %l15
  %t93 = load i1, i1* %l12
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load i8*, i8** %l1
  %t96 = load i8*, i8** %l2
  %t97 = load i8*, i8** %l3
  %t98 = load double, double* %l4
  %t99 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t100 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t101 = load double, double* %l7
  %t102 = load double, double* %l8
  %t103 = load i8*, i8** %l9
  %t104 = load double, double* %l10
  %t105 = load double, double* %l11
  %t106 = load i1, i1* %l12
  %t107 = load i1, i1* %l13
  %t108 = load double, double* %l14
  %t109 = load i8*, i8** %l15
  br i1 %t93, label %then8, label %merge9
then8:
  br label %merge9
merge9:
  %t110 = phi i8* [ null, %then8 ], [ %t109, %then6 ]
  store i8* %t110, i8** %l15
  %t111 = load i8*, i8** %l3
  %t112 = insertvalue %NativeEnum undef, i8* %t111, 0
  %t113 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t114 = bitcast { %NativeEnumVariant*, i64 }* %t113 to { i8**, i64 }*
  %t115 = insertvalue %NativeEnum %t112, { i8**, i64 }* %t114, 1
  %t116 = load i8*, i8** %l15
  %t117 = insertvalue %NativeEnum %t115, i8* %t116, 2
  %t118 = insertvalue %EnumParseResult undef, i8* null, 0
  %t119 = load double, double* %l14
  %t120 = insertvalue %EnumParseResult %t118, double %t119, 1
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = insertvalue %EnumParseResult %t120, { i8**, i64 }* %t121, 2
  ret %EnumParseResult %t122
merge7:
  %t123 = load double, double* %l14
  %t124 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t125 = extractvalue { i8**, i64 } %t124, 0
  %t126 = extractvalue { i8**, i64 } %t124, 1
  %t127 = icmp uge i64 %t123, %t126
  ; bounds check: %t127 (if true, out of bounds)
  %t128 = getelementptr i8*, i8** %t125, i64 %t123
  %t129 = load i8*, i8** %t128
  %t130 = call i8* @trim_text(i8* %t129)
  store i8* %t130, i8** %l16
  %t132 = load i8*, i8** %l16
  %t133 = load i8*, i8** %l16
  %s134 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.134, i32 0, i32 0
  %t135 = icmp eq i8* %t133, %s134
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t137 = load i8*, i8** %l1
  %t138 = load i8*, i8** %l2
  %t139 = load i8*, i8** %l3
  %t140 = load double, double* %l4
  %t141 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t142 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t143 = load double, double* %l7
  %t144 = load double, double* %l8
  %t145 = load i8*, i8** %l9
  %t146 = load double, double* %l10
  %t147 = load double, double* %l11
  %t148 = load i1, i1* %l12
  %t149 = load i1, i1* %l13
  %t150 = load double, double* %l14
  %t151 = load i8*, i8** %l16
  br i1 %t135, label %then10, label %merge11
then10:
  %t152 = load double, double* %l14
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l14
  br label %loop.latch4
merge11:
  %t155 = load i8*, i8** %l16
  %s156 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.156, i32 0, i32 0
  %t157 = call i1 @starts_with(i8* %t155, i8* %s156)
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load i8*, i8** %l1
  %t160 = load i8*, i8** %l2
  %t161 = load i8*, i8** %l3
  %t162 = load double, double* %l4
  %t163 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t164 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t165 = load double, double* %l7
  %t166 = load double, double* %l8
  %t167 = load i8*, i8** %l9
  %t168 = load double, double* %l10
  %t169 = load double, double* %l11
  %t170 = load i1, i1* %l12
  %t171 = load i1, i1* %l13
  %t172 = load double, double* %l14
  %t173 = load i8*, i8** %l16
  br i1 %t157, label %then12, label %merge13
then12:
  %t174 = load i8*, i8** %l16
  %s175 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.175, i32 0, i32 0
  %t176 = call i8* @strip_prefix(i8* %t174, i8* %s175)
  store i8* %t176, i8** %l17
  %t177 = load i8*, i8** %l17
  %s178 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.178, i32 0, i32 0
  %t179 = call i1 @starts_with(i8* %t177, i8* %s178)
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load i8*, i8** %l1
  %t182 = load i8*, i8** %l2
  %t183 = load i8*, i8** %l3
  %t184 = load double, double* %l4
  %t185 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t186 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t187 = load double, double* %l7
  %t188 = load double, double* %l8
  %t189 = load i8*, i8** %l9
  %t190 = load double, double* %l10
  %t191 = load double, double* %l11
  %t192 = load i1, i1* %l12
  %t193 = load i1, i1* %l13
  %t194 = load double, double* %l14
  %t195 = load i8*, i8** %l16
  %t196 = load i8*, i8** %l17
  br i1 %t179, label %then14, label %merge15
then14:
  %t197 = load i8*, i8** %l17
  %s198 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.198, i32 0, i32 0
  %t199 = call i8* @strip_prefix(i8* %t197, i8* %s198)
  %t200 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t199)
  store %EnumLayoutHeaderParse %t200, %EnumLayoutHeaderParse* %l18
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t203 = extractvalue %EnumLayoutHeaderParse %t202, 7
  %t204 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t201, { i8**, i64 }* %t203)
  store { i8**, i64 }* %t204, { i8**, i64 }** %l0
  %t205 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t206 = extractvalue %EnumLayoutHeaderParse %t205, 0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = load i8*, i8** %l1
  %t209 = load i8*, i8** %l2
  %t210 = load i8*, i8** %l3
  %t211 = load double, double* %l4
  %t212 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t213 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t214 = load double, double* %l7
  %t215 = load double, double* %l8
  %t216 = load i8*, i8** %l9
  %t217 = load double, double* %l10
  %t218 = load double, double* %l11
  %t219 = load i1, i1* %l12
  %t220 = load i1, i1* %l13
  %t221 = load double, double* %l14
  %t222 = load i8*, i8** %l16
  %t223 = load i8*, i8** %l17
  %t224 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t206, label %then16, label %merge17
then16:
  %t225 = load i1, i1* %l12
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t227 = load i8*, i8** %l1
  %t228 = load i8*, i8** %l2
  %t229 = load i8*, i8** %l3
  %t230 = load double, double* %l4
  %t231 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t232 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t233 = load double, double* %l7
  %t234 = load double, double* %l8
  %t235 = load i8*, i8** %l9
  %t236 = load double, double* %l10
  %t237 = load double, double* %l11
  %t238 = load i1, i1* %l12
  %t239 = load i1, i1* %l13
  %t240 = load double, double* %l14
  %t241 = load i8*, i8** %l16
  %t242 = load i8*, i8** %l17
  %t243 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t225, label %then18, label %else19
then18:
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s245 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.245, i32 0, i32 0
  %t246 = load i8*, i8** %l3
  %t247 = add i8* %s245, %t246
  %t248 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t244, i8* %t247)
  store { i8**, i64 }* %t248, { i8**, i64 }** %l0
  br label %merge20
else19:
  %t249 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t250 = extractvalue %EnumLayoutHeaderParse %t249, 2
  store double %t250, double* %l7
  %t251 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t252 = extractvalue %EnumLayoutHeaderParse %t251, 3
  store double %t252, double* %l8
  %t253 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t254 = extractvalue %EnumLayoutHeaderParse %t253, 4
  store i8* %t254, i8** %l9
  %t255 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t256 = extractvalue %EnumLayoutHeaderParse %t255, 5
  store double %t256, double* %l10
  %t257 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t258 = extractvalue %EnumLayoutHeaderParse %t257, 6
  store double %t258, double* %l11
  store i1 1, i1* %l12
  br label %merge20
merge20:
  %t259 = phi { i8**, i64 }* [ %t248, %then18 ], [ %t226, %else19 ]
  %t260 = phi double [ %t233, %then18 ], [ %t250, %else19 ]
  %t261 = phi double [ %t234, %then18 ], [ %t252, %else19 ]
  %t262 = phi i8* [ %t235, %then18 ], [ %t254, %else19 ]
  %t263 = phi double [ %t236, %then18 ], [ %t256, %else19 ]
  %t264 = phi double [ %t237, %then18 ], [ %t258, %else19 ]
  %t265 = phi i1 [ %t238, %then18 ], [ 1, %else19 ]
  store { i8**, i64 }* %t259, { i8**, i64 }** %l0
  store double %t260, double* %l7
  store double %t261, double* %l8
  store i8* %t262, i8** %l9
  store double %t263, double* %l10
  store double %t264, double* %l11
  store i1 %t265, i1* %l12
  br label %merge17
merge17:
  %t266 = phi { i8**, i64 }* [ %t248, %then16 ], [ %t207, %then14 ]
  %t267 = phi double [ %t250, %then16 ], [ %t214, %then14 ]
  %t268 = phi double [ %t252, %then16 ], [ %t215, %then14 ]
  %t269 = phi i8* [ %t254, %then16 ], [ %t216, %then14 ]
  %t270 = phi double [ %t256, %then16 ], [ %t217, %then14 ]
  %t271 = phi double [ %t258, %then16 ], [ %t218, %then14 ]
  %t272 = phi i1 [ 1, %then16 ], [ %t219, %then14 ]
  store { i8**, i64 }* %t266, { i8**, i64 }** %l0
  store double %t267, double* %l7
  store double %t268, double* %l8
  store i8* %t269, i8** %l9
  store double %t270, double* %l10
  store double %t271, double* %l11
  store i1 %t272, i1* %l12
  %t273 = load double, double* %l14
  %t274 = sitofp i64 1 to double
  %t275 = fadd double %t273, %t274
  store double %t275, double* %l14
  br label %loop.latch4
merge15:
  %t276 = load i8*, i8** %l17
  %s277 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.277, i32 0, i32 0
  %t278 = call i1 @starts_with(i8* %t276, i8* %s277)
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t280 = load i8*, i8** %l1
  %t281 = load i8*, i8** %l2
  %t282 = load i8*, i8** %l3
  %t283 = load double, double* %l4
  %t284 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t285 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t286 = load double, double* %l7
  %t287 = load double, double* %l8
  %t288 = load i8*, i8** %l9
  %t289 = load double, double* %l10
  %t290 = load double, double* %l11
  %t291 = load i1, i1* %l12
  %t292 = load i1, i1* %l13
  %t293 = load double, double* %l14
  %t294 = load i8*, i8** %l16
  %t295 = load i8*, i8** %l17
  br i1 %t278, label %then21, label %merge22
then21:
  %t296 = load i8*, i8** %l17
  %s297 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.297, i32 0, i32 0
  %t298 = call i8* @strip_prefix(i8* %t296, i8* %s297)
  %t299 = load i8*, i8** %l3
  %t300 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t298, i8* %t299)
  store %EnumLayoutVariantParse %t300, %EnumLayoutVariantParse* %l19
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t302 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t303 = extractvalue %EnumLayoutVariantParse %t302, 2
  %t304 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t301, { i8**, i64 }* %t303)
  store { i8**, i64 }* %t304, { i8**, i64 }** %l0
  %t305 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t306 = extractvalue %EnumLayoutVariantParse %t305, 0
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t308 = load i8*, i8** %l1
  %t309 = load i8*, i8** %l2
  %t310 = load i8*, i8** %l3
  %t311 = load double, double* %l4
  %t312 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t313 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t314 = load double, double* %l7
  %t315 = load double, double* %l8
  %t316 = load i8*, i8** %l9
  %t317 = load double, double* %l10
  %t318 = load double, double* %l11
  %t319 = load i1, i1* %l12
  %t320 = load i1, i1* %l13
  %t321 = load double, double* %l14
  %t322 = load i8*, i8** %l16
  %t323 = load i8*, i8** %l17
  %t324 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t306, label %then23, label %merge24
then23:
  %t325 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t326 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t327 = extractvalue %EnumLayoutVariantParse %t326, 1
  store double 0.0, double* %l20
  %t328 = load double, double* %l20
  %t329 = sitofp i64 0 to double
  %t330 = fcmp oge double %t328, %t329
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t332 = load i8*, i8** %l1
  %t333 = load i8*, i8** %l2
  %t334 = load i8*, i8** %l3
  %t335 = load double, double* %l4
  %t336 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t337 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t338 = load double, double* %l7
  %t339 = load double, double* %l8
  %t340 = load i8*, i8** %l9
  %t341 = load double, double* %l10
  %t342 = load double, double* %l11
  %t343 = load i1, i1* %l12
  %t344 = load i1, i1* %l13
  %t345 = load double, double* %l14
  %t346 = load i8*, i8** %l16
  %t347 = load i8*, i8** %l17
  %t348 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t349 = load double, double* %l20
  br i1 %t330, label %then25, label %else26
then25:
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s351 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.351, i32 0, i32 0
  %t352 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t353 = extractvalue %EnumLayoutVariantParse %t352, 1
  br label %merge27
else26:
  %t354 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t355 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t356 = extractvalue %EnumLayoutVariantParse %t355, 1
  %t357 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t354, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t357, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge27
merge27:
  %t358 = phi { i8**, i64 }* [ null, %then25 ], [ %t331, %else26 ]
  %t359 = phi { %NativeEnumVariantLayout*, i64 }* [ %t337, %then25 ], [ %t357, %else26 ]
  store { i8**, i64 }* %t358, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t359, { %NativeEnumVariantLayout*, i64 }** %l6
  %t360 = load i1, i1* %l12
  %t361 = xor i1 %t360, 1
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t363 = load i8*, i8** %l1
  %t364 = load i8*, i8** %l2
  %t365 = load i8*, i8** %l3
  %t366 = load double, double* %l4
  %t367 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t368 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t369 = load double, double* %l7
  %t370 = load double, double* %l8
  %t371 = load i8*, i8** %l9
  %t372 = load double, double* %l10
  %t373 = load double, double* %l11
  %t374 = load i1, i1* %l12
  %t375 = load i1, i1* %l13
  %t376 = load double, double* %l14
  %t377 = load i8*, i8** %l16
  %t378 = load i8*, i8** %l17
  %t379 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t380 = load double, double* %l20
  br i1 %t361, label %then28, label %merge29
then28:
  %t381 = load i1, i1* %l13
  %t382 = xor i1 %t381, 1
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t384 = load i8*, i8** %l1
  %t385 = load i8*, i8** %l2
  %t386 = load i8*, i8** %l3
  %t387 = load double, double* %l4
  %t388 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t389 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t390 = load double, double* %l7
  %t391 = load double, double* %l8
  %t392 = load i8*, i8** %l9
  %t393 = load double, double* %l10
  %t394 = load double, double* %l11
  %t395 = load i1, i1* %l12
  %t396 = load i1, i1* %l13
  %t397 = load double, double* %l14
  %t398 = load i8*, i8** %l16
  %t399 = load i8*, i8** %l17
  %t400 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t401 = load double, double* %l20
  br i1 %t382, label %then30, label %merge31
then30:
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s403 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.403, i32 0, i32 0
  %t404 = load i8*, i8** %l3
  %t405 = add i8* %s403, %t404
  %s406 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.406, i32 0, i32 0
  %t407 = add i8* %t405, %s406
  %t408 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t402, i8* %t407)
  store { i8**, i64 }* %t408, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge31
merge31:
  %t409 = phi { i8**, i64 }* [ %t408, %then30 ], [ %t383, %then28 ]
  %t410 = phi i1 [ 1, %then30 ], [ %t396, %then28 ]
  store { i8**, i64 }* %t409, { i8**, i64 }** %l0
  store i1 %t410, i1* %l13
  br label %merge29
merge29:
  %t411 = phi { i8**, i64 }* [ %t408, %then28 ], [ %t362, %then23 ]
  %t412 = phi i1 [ 1, %then28 ], [ %t375, %then23 ]
  store { i8**, i64 }* %t411, { i8**, i64 }** %l0
  store i1 %t412, i1* %l13
  br label %merge24
merge24:
  %t413 = phi { i8**, i64 }* [ null, %then23 ], [ %t307, %then21 ]
  %t414 = phi { %NativeEnumVariantLayout*, i64 }* [ %t357, %then23 ], [ %t313, %then21 ]
  %t415 = phi { i8**, i64 }* [ %t408, %then23 ], [ %t307, %then21 ]
  %t416 = phi i1 [ 1, %then23 ], [ %t320, %then21 ]
  store { i8**, i64 }* %t413, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t414, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t415, { i8**, i64 }** %l0
  store i1 %t416, i1* %l13
  %t417 = load double, double* %l14
  %t418 = sitofp i64 1 to double
  %t419 = fadd double %t417, %t418
  store double %t419, double* %l14
  br label %loop.latch4
merge22:
  %t420 = load i8*, i8** %l17
  %s421 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.421, i32 0, i32 0
  %t422 = call i1 @starts_with(i8* %t420, i8* %s421)
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t424 = load i8*, i8** %l1
  %t425 = load i8*, i8** %l2
  %t426 = load i8*, i8** %l3
  %t427 = load double, double* %l4
  %t428 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t429 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t430 = load double, double* %l7
  %t431 = load double, double* %l8
  %t432 = load i8*, i8** %l9
  %t433 = load double, double* %l10
  %t434 = load double, double* %l11
  %t435 = load i1, i1* %l12
  %t436 = load i1, i1* %l13
  %t437 = load double, double* %l14
  %t438 = load i8*, i8** %l16
  %t439 = load i8*, i8** %l17
  br i1 %t422, label %then32, label %merge33
then32:
  %t440 = load i8*, i8** %l17
  %s441 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.441, i32 0, i32 0
  %t442 = call i8* @strip_prefix(i8* %t440, i8* %s441)
  %t443 = load i8*, i8** %l3
  %t444 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t442, i8* %t443)
  store %EnumLayoutPayloadParse %t444, %EnumLayoutPayloadParse* %l21
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t446 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t447 = extractvalue %EnumLayoutPayloadParse %t446, 3
  %t448 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t445, { i8**, i64 }* %t447)
  store { i8**, i64 }* %t448, { i8**, i64 }** %l0
  %t449 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t450 = extractvalue %EnumLayoutPayloadParse %t449, 0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t452 = load i8*, i8** %l1
  %t453 = load i8*, i8** %l2
  %t454 = load i8*, i8** %l3
  %t455 = load double, double* %l4
  %t456 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t457 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t458 = load double, double* %l7
  %t459 = load double, double* %l8
  %t460 = load i8*, i8** %l9
  %t461 = load double, double* %l10
  %t462 = load double, double* %l11
  %t463 = load i1, i1* %l12
  %t464 = load i1, i1* %l13
  %t465 = load double, double* %l14
  %t466 = load i8*, i8** %l16
  %t467 = load i8*, i8** %l17
  %t468 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t450, label %then34, label %merge35
then34:
  %t469 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t470 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t471 = extractvalue %EnumLayoutPayloadParse %t470, 1
  %t472 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t469, i8* %t471)
  store double %t472, double* %l22
  %t473 = load double, double* %l22
  %t474 = sitofp i64 0 to double
  %t475 = fcmp olt double %t473, %t474
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t477 = load i8*, i8** %l1
  %t478 = load i8*, i8** %l2
  %t479 = load i8*, i8** %l3
  %t480 = load double, double* %l4
  %t481 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t482 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t483 = load double, double* %l7
  %t484 = load double, double* %l8
  %t485 = load i8*, i8** %l9
  %t486 = load double, double* %l10
  %t487 = load double, double* %l11
  %t488 = load i1, i1* %l12
  %t489 = load i1, i1* %l13
  %t490 = load double, double* %l14
  %t491 = load i8*, i8** %l16
  %t492 = load i8*, i8** %l17
  %t493 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t494 = load double, double* %l22
  br i1 %t475, label %then36, label %else37
then36:
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s496 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.496, i32 0, i32 0
  %t497 = load i8*, i8** %l3
  %t498 = add i8* %s496, %t497
  %s499 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.499, i32 0, i32 0
  %t500 = add i8* %t498, %s499
  %t501 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t502 = extractvalue %EnumLayoutPayloadParse %t501, 1
  %t503 = add i8* %t500, %t502
  %t504 = getelementptr i8, i8* %t503, i64 0
  %t505 = load i8, i8* %t504
  %t506 = add i8 %t505, 96
  %t507 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t495, i8* null)
  store { i8**, i64 }* %t507, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t508 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t509 = load double, double* %l22
  %t510 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t511 = extractvalue %EnumLayoutPayloadParse %t510, 2
  %t512 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t508, double %t509, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t512, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge38
merge38:
  %t513 = phi { i8**, i64 }* [ %t507, %then36 ], [ %t476, %else37 ]
  %t514 = phi { %NativeEnumVariantLayout*, i64 }* [ %t482, %then36 ], [ %t512, %else37 ]
  store { i8**, i64 }* %t513, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t514, { %NativeEnumVariantLayout*, i64 }** %l6
  %t515 = load i1, i1* %l12
  %t516 = xor i1 %t515, 1
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t518 = load i8*, i8** %l1
  %t519 = load i8*, i8** %l2
  %t520 = load i8*, i8** %l3
  %t521 = load double, double* %l4
  %t522 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t523 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t524 = load double, double* %l7
  %t525 = load double, double* %l8
  %t526 = load i8*, i8** %l9
  %t527 = load double, double* %l10
  %t528 = load double, double* %l11
  %t529 = load i1, i1* %l12
  %t530 = load i1, i1* %l13
  %t531 = load double, double* %l14
  %t532 = load i8*, i8** %l16
  %t533 = load i8*, i8** %l17
  %t534 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t535 = load double, double* %l22
  br i1 %t516, label %then39, label %merge40
then39:
  %t536 = load i1, i1* %l13
  %t537 = xor i1 %t536, 1
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t539 = load i8*, i8** %l1
  %t540 = load i8*, i8** %l2
  %t541 = load i8*, i8** %l3
  %t542 = load double, double* %l4
  %t543 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t544 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t545 = load double, double* %l7
  %t546 = load double, double* %l8
  %t547 = load i8*, i8** %l9
  %t548 = load double, double* %l10
  %t549 = load double, double* %l11
  %t550 = load i1, i1* %l12
  %t551 = load i1, i1* %l13
  %t552 = load double, double* %l14
  %t553 = load i8*, i8** %l16
  %t554 = load i8*, i8** %l17
  %t555 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t556 = load double, double* %l22
  br i1 %t537, label %then41, label %merge42
then41:
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s558 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.558, i32 0, i32 0
  %t559 = load i8*, i8** %l3
  %t560 = add i8* %s558, %t559
  %s561 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.561, i32 0, i32 0
  %t562 = add i8* %t560, %s561
  %t563 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t557, i8* %t562)
  store { i8**, i64 }* %t563, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge42
merge42:
  %t564 = phi { i8**, i64 }* [ %t563, %then41 ], [ %t538, %then39 ]
  %t565 = phi i1 [ 1, %then41 ], [ %t551, %then39 ]
  store { i8**, i64 }* %t564, { i8**, i64 }** %l0
  store i1 %t565, i1* %l13
  br label %merge40
merge40:
  %t566 = phi { i8**, i64 }* [ %t563, %then39 ], [ %t517, %then34 ]
  %t567 = phi i1 [ 1, %then39 ], [ %t530, %then34 ]
  store { i8**, i64 }* %t566, { i8**, i64 }** %l0
  store i1 %t567, i1* %l13
  br label %merge35
merge35:
  %t568 = phi { i8**, i64 }* [ %t507, %then34 ], [ %t451, %then32 ]
  %t569 = phi { %NativeEnumVariantLayout*, i64 }* [ %t512, %then34 ], [ %t457, %then32 ]
  %t570 = phi { i8**, i64 }* [ %t563, %then34 ], [ %t451, %then32 ]
  %t571 = phi i1 [ 1, %then34 ], [ %t464, %then32 ]
  store { i8**, i64 }* %t568, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t569, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t570, { i8**, i64 }** %l0
  store i1 %t571, i1* %l13
  %t572 = load double, double* %l14
  %t573 = sitofp i64 1 to double
  %t574 = fadd double %t572, %t573
  store double %t574, double* %l14
  br label %loop.latch4
merge33:
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s576 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.576, i32 0, i32 0
  %t577 = load i8*, i8** %l16
  %t578 = add i8* %s576, %t577
  %t579 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t575, i8* %t578)
  store { i8**, i64 }* %t579, { i8**, i64 }** %l0
  %t580 = load double, double* %l14
  %t581 = sitofp i64 1 to double
  %t582 = fadd double %t580, %t581
  store double %t582, double* %l14
  br label %loop.latch4
merge13:
  %t583 = load i8*, i8** %l16
  %s584 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.584, i32 0, i32 0
  %t585 = icmp eq i8* %t583, %s584
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t587 = load i8*, i8** %l1
  %t588 = load i8*, i8** %l2
  %t589 = load i8*, i8** %l3
  %t590 = load double, double* %l4
  %t591 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t592 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t593 = load double, double* %l7
  %t594 = load double, double* %l8
  %t595 = load i8*, i8** %l9
  %t596 = load double, double* %l10
  %t597 = load double, double* %l11
  %t598 = load i1, i1* %l12
  %t599 = load i1, i1* %l13
  %t600 = load double, double* %l14
  %t601 = load i8*, i8** %l16
  br i1 %t585, label %then43, label %merge44
then43:
  %t602 = load double, double* %l14
  %t603 = sitofp i64 1 to double
  %t604 = fadd double %t602, %t603
  store double %t604, double* %l14
  br label %afterloop5
merge44:
  %t605 = load i8*, i8** %l16
  %s606 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.606, i32 0, i32 0
  %t607 = call i1 @starts_with(i8* %t605, i8* %s606)
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t609 = load i8*, i8** %l1
  %t610 = load i8*, i8** %l2
  %t611 = load i8*, i8** %l3
  %t612 = load double, double* %l4
  %t613 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t614 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t615 = load double, double* %l7
  %t616 = load double, double* %l8
  %t617 = load i8*, i8** %l9
  %t618 = load double, double* %l10
  %t619 = load double, double* %l11
  %t620 = load i1, i1* %l12
  %t621 = load i1, i1* %l13
  %t622 = load double, double* %l14
  %t623 = load i8*, i8** %l16
  br i1 %t607, label %then45, label %merge46
then45:
  %t624 = load i8*, i8** %l16
  %s625 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.625, i32 0, i32 0
  %t626 = call i8* @strip_prefix(i8* %t624, i8* %s625)
  %t627 = call double @parse_enum_variant_line(i8* %t626)
  store double %t627, double* %l23
  %t628 = load double, double* %l23
  %t629 = load double, double* %l14
  %t630 = sitofp i64 1 to double
  %t631 = fadd double %t629, %t630
  store double %t631, double* %l14
  br label %loop.latch4
merge46:
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s633 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.633, i32 0, i32 0
  %t634 = load i8*, i8** %l16
  %t635 = add i8* %s633, %t634
  %t636 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t632, i8* %t635)
  store { i8**, i64 }* %t636, { i8**, i64 }** %l0
  %t637 = load double, double* %l14
  %t638 = sitofp i64 1 to double
  %t639 = fadd double %t637, %t638
  store double %t639, double* %l14
  br label %loop.latch4
loop.latch4:
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t641 = load double, double* %l14
  %t642 = load double, double* %l7
  %t643 = load double, double* %l8
  %t644 = load i8*, i8** %l9
  %t645 = load double, double* %l10
  %t646 = load double, double* %l11
  %t647 = load i1, i1* %l12
  %t648 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t649 = load i1, i1* %l13
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l24
  %t660 = load i1, i1* %l12
  %t661 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t662 = load i8*, i8** %l1
  %t663 = load i8*, i8** %l2
  %t664 = load i8*, i8** %l3
  %t665 = load double, double* %l4
  %t666 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t667 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t668 = load double, double* %l7
  %t669 = load double, double* %l8
  %t670 = load i8*, i8** %l9
  %t671 = load double, double* %l10
  %t672 = load double, double* %l11
  %t673 = load i1, i1* %l12
  %t674 = load i1, i1* %l13
  %t675 = load double, double* %l14
  %t676 = load i8*, i8** %l24
  br i1 %t660, label %then47, label %merge48
then47:
  br label %merge48
merge48:
  %t677 = phi i8* [ null, %then47 ], [ %t676, %entry ]
  store i8* %t677, i8** %l24
  %t678 = load i8*, i8** %l3
  %t679 = insertvalue %NativeEnum undef, i8* %t678, 0
  %t680 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t681 = bitcast { %NativeEnumVariant*, i64 }* %t680 to { i8**, i64 }*
  %t682 = insertvalue %NativeEnum %t679, { i8**, i64 }* %t681, 1
  %t683 = load i8*, i8** %l24
  %t684 = insertvalue %NativeEnum %t682, i8* %t683, 2
  %t685 = insertvalue %EnumParseResult undef, i8* null, 0
  %t686 = load double, double* %l14
  %t687 = insertvalue %EnumParseResult %t685, double %t686, 1
  %t688 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t689 = insertvalue %EnumParseResult %t687, { i8**, i64 }* %t688, 2
  ret %EnumParseResult %t689
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
  %t67 = phi double [ %t10, %entry ], [ %t63, %loop.latch2 ]
  %t68 = phi { i8**, i64 }* [ %t8, %entry ], [ %t64, %loop.latch2 ]
  %t69 = phi i8* [ %t9, %entry ], [ %t65, %loop.latch2 ]
  %t70 = phi double [ %t11, %entry ], [ %t66, %loop.latch2 ]
  store double %t67, double* %l2
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  store i8* %t69, i8** %l1
  store double %t70, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = getelementptr i8, i8* %text, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t18 = load i8, i8* %l4
  %t19 = icmp eq i8 %t18, 123
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t19, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t20 = load i8, i8* %l4
  %t21 = icmp eq i8 %t20, 91
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t22 = phi i1 [ true, %logical_or_entry_17 ], [ %t21, %logical_or_right_end_17 ]
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t22, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t23 = load i8, i8* %l4
  %t24 = icmp eq i8 %t23, 40
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t25 = phi i1 [ true, %logical_or_entry_16 ], [ %t24, %logical_or_right_end_16 ]
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load i8, i8* %l4
  br i1 %t25, label %then4, label %else5
then4:
  %t31 = load double, double* %l2
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l2
  br label %merge6
else5:
  %t34 = load i8, i8* %l4
  br label %merge6
merge6:
  %t36 = phi double [ %t33, %then4 ], [ %t28, %else5 ]
  store double %t36, double* %l2
  %t38 = load i8, i8* %l4
  %t39 = icmp eq i8 %t38, 59
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t39, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t40 = load double, double* %l2
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oeq double %t40, %t41
  br label %logical_and_right_end_37

logical_and_right_end_37:
  br label %logical_and_merge_37

logical_and_merge_37:
  %t43 = phi i1 [ false, %logical_and_entry_37 ], [ %t42, %logical_and_right_end_37 ]
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load i8, i8* %l4
  br i1 %t43, label %then7, label %else8
then7:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load i8*, i8** %l1
  %t51 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t49, i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  %s52 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.52, i32 0, i32 0
  store i8* %s52, i8** %l1
  br label %merge9
else8:
  %t53 = load i8*, i8** %l1
  %t54 = load i8, i8* %l4
  %t55 = getelementptr i8, i8* %t53, i64 0
  %t56 = load i8, i8* %t55
  %t57 = add i8 %t56, %t54
  store i8* null, i8** %l1
  br label %merge9
merge9:
  %t58 = phi { i8**, i64 }* [ %t51, %then7 ], [ %t44, %else8 ]
  %t59 = phi i8* [ %s52, %then7 ], [ null, %else8 ]
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  store i8* %t59, i8** %l1
  %t60 = load double, double* %l3
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l3
  br label %loop.latch2
loop.latch2:
  %t63 = load double, double* %l2
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t71 = load i8*, i8** %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t72
}

define i8* @trim_trailing_delimiters(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
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
  store double 0.0, double* %l1
  %t6 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load double, double* %l0
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t9)
  ret i8* %t10
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
  %l10 = alloca double
  %l11 = alloca %NumberParseResult
  %l12 = alloca double
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
  %t188 = phi i8* [ %t34, %entry ], [ %t180, %loop.latch4 ]
  %t189 = phi i1 [ %t31, %entry ], [ %t181, %loop.latch4 ]
  %t190 = phi i1 [ %t32, %entry ], [ %t182, %loop.latch4 ]
  %t191 = phi double [ %t35, %entry ], [ %t183, %loop.latch4 ]
  %t192 = phi { i8**, i64 }* [ %t30, %entry ], [ %t184, %loop.latch4 ]
  %t193 = phi i1 [ %t33, %entry ], [ %t185, %loop.latch4 ]
  %t194 = phi double [ %t36, %entry ], [ %t186, %loop.latch4 ]
  %t195 = phi double [ %t37, %entry ], [ %t187, %loop.latch4 ]
  store i8* %t188, i8** %l5
  store i1 %t189, i1* %l2
  store i1 %t190, i1* %l3
  store double %t191, double* %l6
  store { i8**, i64 }* %t192, { i8**, i64 }** %l1
  store i1 %t193, i1* %l4
  store double %t194, double* %l7
  store double %t195, double* %l8
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
  %t55 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t56 = extractvalue { i8**, i64 } %t55, 0
  %t57 = extractvalue { i8**, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  %t59 = getelementptr i8*, i8** %t56, i64 %t54
  %t60 = load i8*, i8** %t59
  store i8* %t60, i8** %l9
  %t61 = load i8*, i8** %l9
  %s62 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.62, i32 0, i32 0
  %t63 = call i1 @starts_with(i8* %t61, i8* %s62)
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load i1, i1* %l2
  %t67 = load i1, i1* %l3
  %t68 = load i1, i1* %l4
  %t69 = load i8*, i8** %l5
  %t70 = load double, double* %l6
  %t71 = load double, double* %l7
  %t72 = load double, double* %l8
  %t73 = load i8*, i8** %l9
  br i1 %t63, label %then8, label %else9
then8:
  %t74 = load i8*, i8** %l9
  %t75 = load i8*, i8** %l9
  store i1 1, i1* %l2
  br label %merge10
else9:
  %t76 = load i8*, i8** %l9
  %s77 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.77, i32 0, i32 0
  %t78 = call i1 @starts_with(i8* %t76, i8* %s77)
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load i1, i1* %l2
  %t82 = load i1, i1* %l3
  %t83 = load i1, i1* %l4
  %t84 = load i8*, i8** %l5
  %t85 = load double, double* %l6
  %t86 = load double, double* %l7
  %t87 = load double, double* %l8
  %t88 = load i8*, i8** %l9
  br i1 %t78, label %then11, label %else12
then11:
  %t89 = load i8*, i8** %l9
  %t90 = load i8*, i8** %l9
  store double 0.0, double* %l10
  %t91 = load double, double* %l10
  %t92 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t92, %NumberParseResult* %l11
  %t93 = load %NumberParseResult, %NumberParseResult* %l11
  %t94 = extractvalue %NumberParseResult %t93, 0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t97 = load i1, i1* %l2
  %t98 = load i1, i1* %l3
  %t99 = load i1, i1* %l4
  %t100 = load i8*, i8** %l5
  %t101 = load double, double* %l6
  %t102 = load double, double* %l7
  %t103 = load double, double* %l8
  %t104 = load i8*, i8** %l9
  %t105 = load double, double* %l10
  %t106 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t94, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t107 = load %NumberParseResult, %NumberParseResult* %l11
  %t108 = extractvalue %NumberParseResult %t107, 1
  store double %t108, double* %l6
  br label %merge16
else15:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s110 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.110, i32 0, i32 0
  %t111 = load double, double* %l10
  br label %merge16
merge16:
  %t112 = phi i1 [ 1, %then14 ], [ %t98, %else15 ]
  %t113 = phi double [ %t108, %then14 ], [ %t101, %else15 ]
  %t114 = phi { i8**, i64 }* [ %t96, %then14 ], [ null, %else15 ]
  store i1 %t112, i1* %l3
  store double %t113, double* %l6
  store { i8**, i64 }* %t114, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t115 = load i8*, i8** %l9
  %s116 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.116, i32 0, i32 0
  %t117 = call i1 @starts_with(i8* %t115, i8* %s116)
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load i1, i1* %l2
  %t121 = load i1, i1* %l3
  %t122 = load i1, i1* %l4
  %t123 = load i8*, i8** %l5
  %t124 = load double, double* %l6
  %t125 = load double, double* %l7
  %t126 = load double, double* %l8
  %t127 = load i8*, i8** %l9
  br i1 %t117, label %then17, label %else18
then17:
  %t128 = load i8*, i8** %l9
  %t129 = load i8*, i8** %l9
  store double 0.0, double* %l12
  %t130 = load double, double* %l12
  %t131 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t131, %NumberParseResult* %l13
  %t132 = load %NumberParseResult, %NumberParseResult* %l13
  %t133 = extractvalue %NumberParseResult %t132, 0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t136 = load i1, i1* %l2
  %t137 = load i1, i1* %l3
  %t138 = load i1, i1* %l4
  %t139 = load i8*, i8** %l5
  %t140 = load double, double* %l6
  %t141 = load double, double* %l7
  %t142 = load double, double* %l8
  %t143 = load i8*, i8** %l9
  %t144 = load double, double* %l12
  %t145 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t133, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t146 = load %NumberParseResult, %NumberParseResult* %l13
  %t147 = extractvalue %NumberParseResult %t146, 1
  store double %t147, double* %l7
  br label %merge22
else21:
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s149 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.149, i32 0, i32 0
  %t150 = load double, double* %l12
  br label %merge22
merge22:
  %t151 = phi i1 [ 1, %then20 ], [ %t138, %else21 ]
  %t152 = phi double [ %t147, %then20 ], [ %t141, %else21 ]
  %t153 = phi { i8**, i64 }* [ %t135, %then20 ], [ null, %else21 ]
  store i1 %t151, i1* %l4
  store double %t152, double* %l7
  store { i8**, i64 }* %t153, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s155 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.155, i32 0, i32 0
  %t156 = load i8*, i8** %l9
  %t157 = add i8* %s155, %t156
  %t158 = getelementptr i8, i8* %t157, i64 0
  %t159 = load i8, i8* %t158
  %t160 = add i8 %t159, 96
  %t161 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t154, i8* null)
  store { i8**, i64 }* %t161, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t162 = phi i1 [ 1, %then17 ], [ %t122, %else18 ]
  %t163 = phi double [ %t147, %then17 ], [ %t125, %else18 ]
  %t164 = phi { i8**, i64 }* [ null, %then17 ], [ %t161, %else18 ]
  store i1 %t162, i1* %l4
  store double %t163, double* %l7
  store { i8**, i64 }* %t164, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t165 = phi i1 [ 1, %then11 ], [ %t82, %else12 ]
  %t166 = phi double [ %t108, %then11 ], [ %t85, %else12 ]
  %t167 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t168 = phi i1 [ %t83, %then11 ], [ 1, %else12 ]
  %t169 = phi double [ %t86, %then11 ], [ %t147, %else12 ]
  store i1 %t165, i1* %l3
  store double %t166, double* %l6
  store { i8**, i64 }* %t167, { i8**, i64 }** %l1
  store i1 %t168, i1* %l4
  store double %t169, double* %l7
  br label %merge10
merge10:
  %t170 = phi i8* [ null, %then8 ], [ %t69, %else9 ]
  %t171 = phi i1 [ 1, %then8 ], [ %t66, %else9 ]
  %t172 = phi i1 [ %t67, %then8 ], [ 1, %else9 ]
  %t173 = phi double [ %t70, %then8 ], [ %t108, %else9 ]
  %t174 = phi { i8**, i64 }* [ %t65, %then8 ], [ null, %else9 ]
  %t175 = phi i1 [ %t68, %then8 ], [ 1, %else9 ]
  %t176 = phi double [ %t71, %then8 ], [ %t147, %else9 ]
  store i8* %t170, i8** %l5
  store i1 %t171, i1* %l2
  store i1 %t172, i1* %l3
  store double %t173, double* %l6
  store { i8**, i64 }* %t174, { i8**, i64 }** %l1
  store i1 %t175, i1* %l4
  store double %t176, double* %l7
  %t177 = load double, double* %l8
  %t178 = sitofp i64 1 to double
  %t179 = fadd double %t177, %t178
  store double %t179, double* %l8
  br label %loop.latch4
loop.latch4:
  %t180 = load i8*, i8** %l5
  %t181 = load i1, i1* %l2
  %t182 = load i1, i1* %l3
  %t183 = load double, double* %l6
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load i1, i1* %l4
  %t186 = load double, double* %l7
  %t187 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t196 = load i1, i1* %l3
  %t197 = xor i1 %t196, 1
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t200 = load i1, i1* %l2
  %t201 = load i1, i1* %l3
  %t202 = load i1, i1* %l4
  %t203 = load i8*, i8** %l5
  %t204 = load double, double* %l6
  %t205 = load double, double* %l7
  %t206 = load double, double* %l8
  br i1 %t197, label %then23, label %merge24
then23:
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s208 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.208, i32 0, i32 0
  %t209 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t207, i8* %s208)
  store { i8**, i64 }* %t209, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t210 = phi { i8**, i64 }* [ %t209, %then23 ], [ %t199, %entry ]
  store { i8**, i64 }* %t210, { i8**, i64 }** %l1
  %t211 = load i1, i1* %l4
  %t212 = xor i1 %t211, 1
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t215 = load i1, i1* %l2
  %t216 = load i1, i1* %l3
  %t217 = load i1, i1* %l4
  %t218 = load i8*, i8** %l5
  %t219 = load double, double* %l6
  %t220 = load double, double* %l7
  %t221 = load double, double* %l8
  br i1 %t212, label %then25, label %merge26
then25:
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s223 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.223, i32 0, i32 0
  %t224 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t222, i8* %s223)
  store { i8**, i64 }* %t224, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t225 = phi { i8**, i64 }* [ %t224, %then25 ], [ %t214, %entry ]
  store { i8**, i64 }* %t225, { i8**, i64 }** %l1
  %t228 = load i1, i1* %l3
  br label %logical_and_entry_227

logical_and_entry_227:
  br i1 %t228, label %logical_and_right_227, label %logical_and_merge_227

logical_and_right_227:
  %t229 = load i1, i1* %l4
  br label %logical_and_right_end_227

logical_and_right_end_227:
  br label %logical_and_merge_227

logical_and_merge_227:
  %t230 = phi i1 [ false, %logical_and_entry_227 ], [ %t229, %logical_and_right_end_227 ]
  br label %logical_and_entry_226

logical_and_entry_226:
  br i1 %t230, label %logical_and_right_226, label %logical_and_merge_226

logical_and_right_226:
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load { i8**, i64 }, { i8**, i64 }* %t231
  %t233 = extractvalue { i8**, i64 } %t232, 1
  %t234 = icmp eq i64 %t233, 0
  br label %logical_and_right_end_226

logical_and_right_end_226:
  br label %logical_and_merge_226

logical_and_merge_226:
  %t235 = phi i1 [ false, %logical_and_entry_226 ], [ %t234, %logical_and_right_end_226 ]
  store i1 %t235, i1* %l14
  %t236 = load i1, i1* %l14
  %t237 = insertvalue %StructLayoutHeaderParse undef, i1 %t236, 0
  %t238 = load i8*, i8** %l5
  %t239 = insertvalue %StructLayoutHeaderParse %t237, i8* %t238, 1
  %t240 = load double, double* %l6
  %t241 = insertvalue %StructLayoutHeaderParse %t239, double %t240, 2
  %t242 = load double, double* %l7
  %t243 = insertvalue %StructLayoutHeaderParse %t241, double %t242, 3
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t245 = insertvalue %StructLayoutHeaderParse %t243, { i8**, i64 }* %t244, 4
  ret %StructLayoutHeaderParse %t245
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
  %l14 = alloca double
  %l15 = alloca %NumberParseResult
  %l16 = alloca double
  %l17 = alloca %NumberParseResult
  %l18 = alloca double
  %l19 = alloca %NumberParseResult
  %l20 = alloca double
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
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_whitespace(i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t21 = extractvalue { i8**, i64 } %t20, 1
  %t22 = icmp eq i64 %t21, 0
  %t23 = load i8*, i8** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t22, label %then0, label %merge1
then0:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s28 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.28, i32 0, i32 0
  %t29 = add i8* %s28, %struct_name
  %s30 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %t29, %s30
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l1
  %t33 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t34 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t35 = insertvalue %StructLayoutFieldParse %t33, i8* null, 1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = insertvalue %StructLayoutFieldParse %t35, { i8**, i64 }* %t36, 2
  ret %StructLayoutFieldParse %t37
merge1:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 0
  %t41 = extractvalue { i8**, i64 } %t39, 1
  %t42 = icmp uge i64 0, %t41
  ; bounds check: %t42 (if true, out of bounds)
  %t43 = getelementptr i8*, i8** %t40, i64 0
  %t44 = load i8*, i8** %t43
  store i8* %t44, i8** %l4
  %t45 = load i8*, i8** %l4
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.46, i32 0, i32 0
  store i8* %s46, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l9
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l10
  %t49 = sitofp i64 0 to double
  store double %t49, double* %l11
  %t50 = sitofp i64 1 to double
  store double %t50, double* %l12
  %t51 = load i8*, i8** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load i8*, i8** %l4
  %t56 = load i8*, i8** %l5
  %t57 = load i1, i1* %l6
  %t58 = load i1, i1* %l7
  %t59 = load i1, i1* %l8
  %t60 = load double, double* %l9
  %t61 = load double, double* %l10
  %t62 = load double, double* %l11
  %t63 = load double, double* %l12
  br label %loop.header2
loop.header2:
  %t322 = phi i8* [ %t56, %entry ], [ %t313, %loop.latch4 ]
  %t323 = phi i1 [ %t57, %entry ], [ %t314, %loop.latch4 ]
  %t324 = phi double [ %t60, %entry ], [ %t315, %loop.latch4 ]
  %t325 = phi { i8**, i64 }* [ %t52, %entry ], [ %t316, %loop.latch4 ]
  %t326 = phi i1 [ %t58, %entry ], [ %t317, %loop.latch4 ]
  %t327 = phi double [ %t61, %entry ], [ %t318, %loop.latch4 ]
  %t328 = phi i1 [ %t59, %entry ], [ %t319, %loop.latch4 ]
  %t329 = phi double [ %t62, %entry ], [ %t320, %loop.latch4 ]
  %t330 = phi double [ %t63, %entry ], [ %t321, %loop.latch4 ]
  store i8* %t322, i8** %l5
  store i1 %t323, i1* %l6
  store double %t324, double* %l9
  store { i8**, i64 }* %t325, { i8**, i64 }** %l1
  store i1 %t326, i1* %l7
  store double %t327, double* %l10
  store i1 %t328, i1* %l8
  store double %t329, double* %l11
  store double %t330, double* %l12
  br label %loop.body3
loop.body3:
  %t64 = load double, double* %l12
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t67 = extractvalue { i8**, i64 } %t66, 1
  %t68 = sitofp i64 %t67 to double
  %t69 = fcmp oge double %t64, %t68
  %t70 = load i8*, i8** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t74 = load i8*, i8** %l4
  %t75 = load i8*, i8** %l5
  %t76 = load i1, i1* %l6
  %t77 = load i1, i1* %l7
  %t78 = load i1, i1* %l8
  %t79 = load double, double* %l9
  %t80 = load double, double* %l10
  %t81 = load double, double* %l11
  %t82 = load double, double* %l12
  br i1 %t69, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t84 = load double, double* %l12
  %t85 = load { i8**, i64 }, { i8**, i64 }* %t83
  %t86 = extractvalue { i8**, i64 } %t85, 0
  %t87 = extractvalue { i8**, i64 } %t85, 1
  %t88 = icmp uge i64 %t84, %t87
  ; bounds check: %t88 (if true, out of bounds)
  %t89 = getelementptr i8*, i8** %t86, i64 %t84
  %t90 = load i8*, i8** %t89
  store i8* %t90, i8** %l13
  %t91 = load i8*, i8** %l13
  %s92 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.92, i32 0, i32 0
  %t93 = call i1 @starts_with(i8* %t91, i8* %s92)
  %t94 = load i8*, i8** %l0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t96 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t98 = load i8*, i8** %l4
  %t99 = load i8*, i8** %l5
  %t100 = load i1, i1* %l6
  %t101 = load i1, i1* %l7
  %t102 = load i1, i1* %l8
  %t103 = load double, double* %l9
  %t104 = load double, double* %l10
  %t105 = load double, double* %l11
  %t106 = load double, double* %l12
  %t107 = load i8*, i8** %l13
  br i1 %t93, label %then8, label %else9
then8:
  %t108 = load i8*, i8** %l13
  %t109 = load i8*, i8** %l13
  br label %merge10
else9:
  %t110 = load i8*, i8** %l13
  %s111 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.111, i32 0, i32 0
  %t112 = call i1 @starts_with(i8* %t110, i8* %s111)
  %t113 = load i8*, i8** %l0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t117 = load i8*, i8** %l4
  %t118 = load i8*, i8** %l5
  %t119 = load i1, i1* %l6
  %t120 = load i1, i1* %l7
  %t121 = load i1, i1* %l8
  %t122 = load double, double* %l9
  %t123 = load double, double* %l10
  %t124 = load double, double* %l11
  %t125 = load double, double* %l12
  %t126 = load i8*, i8** %l13
  br i1 %t112, label %then11, label %else12
then11:
  %t127 = load i8*, i8** %l13
  %t128 = load i8*, i8** %l13
  store double 0.0, double* %l14
  %t129 = load double, double* %l14
  %t130 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t130, %NumberParseResult* %l15
  %t131 = load %NumberParseResult, %NumberParseResult* %l15
  %t132 = extractvalue %NumberParseResult %t131, 0
  %t133 = load i8*, i8** %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t137 = load i8*, i8** %l4
  %t138 = load i8*, i8** %l5
  %t139 = load i1, i1* %l6
  %t140 = load i1, i1* %l7
  %t141 = load i1, i1* %l8
  %t142 = load double, double* %l9
  %t143 = load double, double* %l10
  %t144 = load double, double* %l11
  %t145 = load double, double* %l12
  %t146 = load i8*, i8** %l13
  %t147 = load double, double* %l14
  %t148 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t132, label %then14, label %else15
then14:
  store i1 1, i1* %l6
  %t149 = load %NumberParseResult, %NumberParseResult* %l15
  %t150 = extractvalue %NumberParseResult %t149, 1
  store double %t150, double* %l9
  br label %merge16
else15:
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s152 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.152, i32 0, i32 0
  %t153 = add i8* %s152, %struct_name
  %s154 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.154, i32 0, i32 0
  %t155 = add i8* %t153, %s154
  %t156 = load i8*, i8** %l4
  %t157 = add i8* %t155, %t156
  %s158 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.158, i32 0, i32 0
  %t159 = add i8* %t157, %s158
  %t160 = load double, double* %l14
  br label %merge16
merge16:
  %t161 = phi i1 [ 1, %then14 ], [ %t139, %else15 ]
  %t162 = phi double [ %t150, %then14 ], [ %t142, %else15 ]
  %t163 = phi { i8**, i64 }* [ %t134, %then14 ], [ null, %else15 ]
  store i1 %t161, i1* %l6
  store double %t162, double* %l9
  store { i8**, i64 }* %t163, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t164 = load i8*, i8** %l13
  %s165 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.165, i32 0, i32 0
  %t166 = call i1 @starts_with(i8* %t164, i8* %s165)
  %t167 = load i8*, i8** %l0
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t169 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t171 = load i8*, i8** %l4
  %t172 = load i8*, i8** %l5
  %t173 = load i1, i1* %l6
  %t174 = load i1, i1* %l7
  %t175 = load i1, i1* %l8
  %t176 = load double, double* %l9
  %t177 = load double, double* %l10
  %t178 = load double, double* %l11
  %t179 = load double, double* %l12
  %t180 = load i8*, i8** %l13
  br i1 %t166, label %then17, label %else18
then17:
  %t181 = load i8*, i8** %l13
  %t182 = load i8*, i8** %l13
  store double 0.0, double* %l16
  %t183 = load double, double* %l16
  %t184 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t184, %NumberParseResult* %l17
  %t185 = load %NumberParseResult, %NumberParseResult* %l17
  %t186 = extractvalue %NumberParseResult %t185, 0
  %t187 = load i8*, i8** %l0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t189 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t191 = load i8*, i8** %l4
  %t192 = load i8*, i8** %l5
  %t193 = load i1, i1* %l6
  %t194 = load i1, i1* %l7
  %t195 = load i1, i1* %l8
  %t196 = load double, double* %l9
  %t197 = load double, double* %l10
  %t198 = load double, double* %l11
  %t199 = load double, double* %l12
  %t200 = load i8*, i8** %l13
  %t201 = load double, double* %l16
  %t202 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t186, label %then20, label %else21
then20:
  store i1 1, i1* %l7
  %t203 = load %NumberParseResult, %NumberParseResult* %l17
  %t204 = extractvalue %NumberParseResult %t203, 1
  store double %t204, double* %l10
  br label %merge22
else21:
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s206 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.206, i32 0, i32 0
  %t207 = add i8* %s206, %struct_name
  %s208 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.208, i32 0, i32 0
  %t209 = add i8* %t207, %s208
  %t210 = load i8*, i8** %l4
  %t211 = add i8* %t209, %t210
  %s212 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.212, i32 0, i32 0
  %t213 = add i8* %t211, %s212
  %t214 = load double, double* %l16
  br label %merge22
merge22:
  %t215 = phi i1 [ 1, %then20 ], [ %t194, %else21 ]
  %t216 = phi double [ %t204, %then20 ], [ %t197, %else21 ]
  %t217 = phi { i8**, i64 }* [ %t188, %then20 ], [ null, %else21 ]
  store i1 %t215, i1* %l7
  store double %t216, double* %l10
  store { i8**, i64 }* %t217, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t218 = load i8*, i8** %l13
  %s219 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.219, i32 0, i32 0
  %t220 = call i1 @starts_with(i8* %t218, i8* %s219)
  %t221 = load i8*, i8** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t225 = load i8*, i8** %l4
  %t226 = load i8*, i8** %l5
  %t227 = load i1, i1* %l6
  %t228 = load i1, i1* %l7
  %t229 = load i1, i1* %l8
  %t230 = load double, double* %l9
  %t231 = load double, double* %l10
  %t232 = load double, double* %l11
  %t233 = load double, double* %l12
  %t234 = load i8*, i8** %l13
  br i1 %t220, label %then23, label %else24
then23:
  %t235 = load i8*, i8** %l13
  %t236 = load i8*, i8** %l13
  store double 0.0, double* %l18
  %t237 = load double, double* %l18
  %t238 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t238, %NumberParseResult* %l19
  %t239 = load %NumberParseResult, %NumberParseResult* %l19
  %t240 = extractvalue %NumberParseResult %t239, 0
  %t241 = load i8*, i8** %l0
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t245 = load i8*, i8** %l4
  %t246 = load i8*, i8** %l5
  %t247 = load i1, i1* %l6
  %t248 = load i1, i1* %l7
  %t249 = load i1, i1* %l8
  %t250 = load double, double* %l9
  %t251 = load double, double* %l10
  %t252 = load double, double* %l11
  %t253 = load double, double* %l12
  %t254 = load i8*, i8** %l13
  %t255 = load double, double* %l18
  %t256 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t240, label %then26, label %else27
then26:
  store i1 1, i1* %l8
  %t257 = load %NumberParseResult, %NumberParseResult* %l19
  %t258 = extractvalue %NumberParseResult %t257, 1
  store double %t258, double* %l11
  br label %merge28
else27:
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s260 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.260, i32 0, i32 0
  %t261 = add i8* %s260, %struct_name
  %s262 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.262, i32 0, i32 0
  %t263 = add i8* %t261, %s262
  %t264 = load i8*, i8** %l4
  %t265 = add i8* %t263, %t264
  %s266 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.266, i32 0, i32 0
  %t267 = add i8* %t265, %s266
  %t268 = load double, double* %l18
  br label %merge28
merge28:
  %t269 = phi i1 [ 1, %then26 ], [ %t249, %else27 ]
  %t270 = phi double [ %t258, %then26 ], [ %t252, %else27 ]
  %t271 = phi { i8**, i64 }* [ %t242, %then26 ], [ null, %else27 ]
  store i1 %t269, i1* %l8
  store double %t270, double* %l11
  store { i8**, i64 }* %t271, { i8**, i64 }** %l1
  br label %merge25
else24:
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s273 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.273, i32 0, i32 0
  %t274 = add i8* %s273, %struct_name
  %s275 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.275, i32 0, i32 0
  %t276 = add i8* %t274, %s275
  %t277 = load i8*, i8** %l4
  %t278 = add i8* %t276, %t277
  %s279 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.279, i32 0, i32 0
  %t280 = add i8* %t278, %s279
  %t281 = load i8*, i8** %l13
  %t282 = add i8* %t280, %t281
  %t283 = getelementptr i8, i8* %t282, i64 0
  %t284 = load i8, i8* %t283
  %t285 = add i8 %t284, 96
  %t286 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t272, i8* null)
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t287 = phi i1 [ 1, %then23 ], [ %t229, %else24 ]
  %t288 = phi double [ %t258, %then23 ], [ %t232, %else24 ]
  %t289 = phi { i8**, i64 }* [ null, %then23 ], [ %t286, %else24 ]
  store i1 %t287, i1* %l8
  store double %t288, double* %l11
  store { i8**, i64 }* %t289, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t290 = phi i1 [ 1, %then17 ], [ %t174, %else18 ]
  %t291 = phi double [ %t204, %then17 ], [ %t177, %else18 ]
  %t292 = phi { i8**, i64 }* [ null, %then17 ], [ null, %else18 ]
  %t293 = phi i1 [ %t175, %then17 ], [ 1, %else18 ]
  %t294 = phi double [ %t178, %then17 ], [ %t258, %else18 ]
  store i1 %t290, i1* %l7
  store double %t291, double* %l10
  store { i8**, i64 }* %t292, { i8**, i64 }** %l1
  store i1 %t293, i1* %l8
  store double %t294, double* %l11
  br label %merge13
merge13:
  %t295 = phi i1 [ 1, %then11 ], [ %t119, %else12 ]
  %t296 = phi double [ %t150, %then11 ], [ %t122, %else12 ]
  %t297 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t298 = phi i1 [ %t120, %then11 ], [ 1, %else12 ]
  %t299 = phi double [ %t123, %then11 ], [ %t204, %else12 ]
  %t300 = phi i1 [ %t121, %then11 ], [ 1, %else12 ]
  %t301 = phi double [ %t124, %then11 ], [ %t258, %else12 ]
  store i1 %t295, i1* %l6
  store double %t296, double* %l9
  store { i8**, i64 }* %t297, { i8**, i64 }** %l1
  store i1 %t298, i1* %l7
  store double %t299, double* %l10
  store i1 %t300, i1* %l8
  store double %t301, double* %l11
  br label %merge10
merge10:
  %t302 = phi i8* [ null, %then8 ], [ %t99, %else9 ]
  %t303 = phi i1 [ %t100, %then8 ], [ 1, %else9 ]
  %t304 = phi double [ %t103, %then8 ], [ %t150, %else9 ]
  %t305 = phi { i8**, i64 }* [ %t95, %then8 ], [ null, %else9 ]
  %t306 = phi i1 [ %t101, %then8 ], [ 1, %else9 ]
  %t307 = phi double [ %t104, %then8 ], [ %t204, %else9 ]
  %t308 = phi i1 [ %t102, %then8 ], [ 1, %else9 ]
  %t309 = phi double [ %t105, %then8 ], [ %t258, %else9 ]
  store i8* %t302, i8** %l5
  store i1 %t303, i1* %l6
  store double %t304, double* %l9
  store { i8**, i64 }* %t305, { i8**, i64 }** %l1
  store i1 %t306, i1* %l7
  store double %t307, double* %l10
  store i1 %t308, i1* %l8
  store double %t309, double* %l11
  %t310 = load double, double* %l12
  %t311 = sitofp i64 1 to double
  %t312 = fadd double %t310, %t311
  store double %t312, double* %l12
  br label %loop.latch4
loop.latch4:
  %t313 = load i8*, i8** %l5
  %t314 = load i1, i1* %l6
  %t315 = load double, double* %l9
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t317 = load i1, i1* %l7
  %t318 = load double, double* %l10
  %t319 = load i1, i1* %l8
  %t320 = load double, double* %l11
  %t321 = load double, double* %l12
  br label %loop.header2
afterloop5:
  %t331 = load i8*, i8** %l5
  %t332 = load i1, i1* %l6
  %t333 = xor i1 %t332, 1
  %t334 = load i8*, i8** %l0
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t336 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t338 = load i8*, i8** %l4
  %t339 = load i8*, i8** %l5
  %t340 = load i1, i1* %l6
  %t341 = load i1, i1* %l7
  %t342 = load i1, i1* %l8
  %t343 = load double, double* %l9
  %t344 = load double, double* %l10
  %t345 = load double, double* %l11
  %t346 = load double, double* %l12
  br i1 %t333, label %then29, label %merge30
then29:
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s348 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.348, i32 0, i32 0
  %t349 = add i8* %s348, %struct_name
  %s350 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.350, i32 0, i32 0
  %t351 = add i8* %t349, %s350
  %t352 = load i8*, i8** %l4
  %t353 = add i8* %t351, %t352
  %s354 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.354, i32 0, i32 0
  %t355 = add i8* %t353, %s354
  %t356 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t347, i8* %t355)
  store { i8**, i64 }* %t356, { i8**, i64 }** %l1
  br label %merge30
merge30:
  %t357 = phi { i8**, i64 }* [ %t356, %then29 ], [ %t335, %entry ]
  store { i8**, i64 }* %t357, { i8**, i64 }** %l1
  %t358 = load i1, i1* %l7
  %t359 = xor i1 %t358, 1
  %t360 = load i8*, i8** %l0
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t362 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t364 = load i8*, i8** %l4
  %t365 = load i8*, i8** %l5
  %t366 = load i1, i1* %l6
  %t367 = load i1, i1* %l7
  %t368 = load i1, i1* %l8
  %t369 = load double, double* %l9
  %t370 = load double, double* %l10
  %t371 = load double, double* %l11
  %t372 = load double, double* %l12
  br i1 %t359, label %then31, label %merge32
then31:
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s374 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.374, i32 0, i32 0
  %t375 = add i8* %s374, %struct_name
  %s376 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.376, i32 0, i32 0
  %t377 = add i8* %t375, %s376
  %t378 = load i8*, i8** %l4
  %t379 = add i8* %t377, %t378
  %s380 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.380, i32 0, i32 0
  %t381 = add i8* %t379, %s380
  %t382 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t373, i8* %t381)
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t383 = phi { i8**, i64 }* [ %t382, %then31 ], [ %t361, %entry ]
  store { i8**, i64 }* %t383, { i8**, i64 }** %l1
  %t384 = load i1, i1* %l8
  %t385 = xor i1 %t384, 1
  %t386 = load i8*, i8** %l0
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t388 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t390 = load i8*, i8** %l4
  %t391 = load i8*, i8** %l5
  %t392 = load i1, i1* %l6
  %t393 = load i1, i1* %l7
  %t394 = load i1, i1* %l8
  %t395 = load double, double* %l9
  %t396 = load double, double* %l10
  %t397 = load double, double* %l11
  %t398 = load double, double* %l12
  br i1 %t385, label %then33, label %merge34
then33:
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s400 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.400, i32 0, i32 0
  %t401 = add i8* %s400, %struct_name
  %s402 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.402, i32 0, i32 0
  %t403 = add i8* %t401, %s402
  %t404 = load i8*, i8** %l4
  %t405 = add i8* %t403, %t404
  %s406 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.406, i32 0, i32 0
  %t407 = add i8* %t405, %s406
  %t408 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t399, i8* %t407)
  store { i8**, i64 }* %t408, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t409 = phi { i8**, i64 }* [ %t408, %then33 ], [ %t387, %entry ]
  store { i8**, i64 }* %t409, { i8**, i64 }** %l1
  %t414 = load i8*, i8** %l5
  store double 0.0, double* %l20
  %t415 = load i8*, i8** %l4
  %t416 = insertvalue %NativeStructLayoutField undef, i8* %t415, 0
  %t417 = load i8*, i8** %l5
  %t418 = insertvalue %NativeStructLayoutField %t416, i8* %t417, 1
  %t419 = load double, double* %l9
  %t420 = insertvalue %NativeStructLayoutField %t418, double %t419, 2
  %t421 = load double, double* %l10
  %t422 = insertvalue %NativeStructLayoutField %t420, double %t421, 3
  %t423 = load double, double* %l11
  %t424 = insertvalue %NativeStructLayoutField %t422, double %t423, 4
  store %NativeStructLayoutField %t424, %NativeStructLayoutField* %l21
  %t425 = load double, double* %l20
  %t426 = fcmp one double %t425, 0.0
  %t427 = insertvalue %StructLayoutFieldParse undef, i1 %t426, 0
  %t428 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t429 = insertvalue %StructLayoutFieldParse %t427, i8* null, 1
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t431 = insertvalue %StructLayoutFieldParse %t429, { i8**, i64 }* %t430, 2
  ret %StructLayoutFieldParse %t431
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
  %l15 = alloca double
  %l16 = alloca %NumberParseResult
  %l17 = alloca double
  %l18 = alloca %NumberParseResult
  %l19 = alloca double
  %l20 = alloca %NumberParseResult
  %l21 = alloca double
  %l22 = alloca %NumberParseResult
  %l23 = alloca double
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
  %t384 = phi i8* [ %t43, %entry ], [ %t371, %loop.latch4 ]
  %t385 = phi i1 [ %t40, %entry ], [ %t372, %loop.latch4 ]
  %t386 = phi i1 [ %t41, %entry ], [ %t373, %loop.latch4 ]
  %t387 = phi double [ %t47, %entry ], [ %t374, %loop.latch4 ]
  %t388 = phi { i8**, i64 }* [ %t39, %entry ], [ %t375, %loop.latch4 ]
  %t389 = phi i1 [ %t42, %entry ], [ %t376, %loop.latch4 ]
  %t390 = phi double [ %t48, %entry ], [ %t377, %loop.latch4 ]
  %t391 = phi i8* [ %t44, %entry ], [ %t378, %loop.latch4 ]
  %t392 = phi i1 [ %t45, %entry ], [ %t379, %loop.latch4 ]
  %t393 = phi double [ %t49, %entry ], [ %t380, %loop.latch4 ]
  %t394 = phi i1 [ %t46, %entry ], [ %t381, %loop.latch4 ]
  %t395 = phi double [ %t50, %entry ], [ %t382, %loop.latch4 ]
  %t396 = phi double [ %t51, %entry ], [ %t383, %loop.latch4 ]
  store i8* %t384, i8** %l5
  store i1 %t385, i1* %l2
  store i1 %t386, i1* %l3
  store double %t387, double* %l9
  store { i8**, i64 }* %t388, { i8**, i64 }** %l1
  store i1 %t389, i1* %l4
  store double %t390, double* %l10
  store i8* %t391, i8** %l6
  store i1 %t392, i1* %l7
  store double %t393, double* %l11
  store i1 %t394, i1* %l8
  store double %t395, double* %l12
  store double %t396, double* %l13
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
  %t74 = load { i8**, i64 }, { i8**, i64 }* %t72
  %t75 = extractvalue { i8**, i64 } %t74, 0
  %t76 = extractvalue { i8**, i64 } %t74, 1
  %t77 = icmp uge i64 %t73, %t76
  ; bounds check: %t77 (if true, out of bounds)
  %t78 = getelementptr i8*, i8** %t75, i64 %t73
  %t79 = load i8*, i8** %t78
  store i8* %t79, i8** %l14
  %t80 = load i8*, i8** %l14
  %s81 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.81, i32 0, i32 0
  %t82 = call i1 @starts_with(i8* %t80, i8* %s81)
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load i1, i1* %l2
  %t86 = load i1, i1* %l3
  %t87 = load i1, i1* %l4
  %t88 = load i8*, i8** %l5
  %t89 = load i8*, i8** %l6
  %t90 = load i1, i1* %l7
  %t91 = load i1, i1* %l8
  %t92 = load double, double* %l9
  %t93 = load double, double* %l10
  %t94 = load double, double* %l11
  %t95 = load double, double* %l12
  %t96 = load double, double* %l13
  %t97 = load i8*, i8** %l14
  br i1 %t82, label %then8, label %else9
then8:
  %t98 = load i8*, i8** %l14
  %t99 = load i8*, i8** %l14
  store i1 1, i1* %l2
  br label %merge10
else9:
  %t100 = load i8*, i8** %l14
  %s101 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.101, i32 0, i32 0
  %t102 = call i1 @starts_with(i8* %t100, i8* %s101)
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load i1, i1* %l2
  %t106 = load i1, i1* %l3
  %t107 = load i1, i1* %l4
  %t108 = load i8*, i8** %l5
  %t109 = load i8*, i8** %l6
  %t110 = load i1, i1* %l7
  %t111 = load i1, i1* %l8
  %t112 = load double, double* %l9
  %t113 = load double, double* %l10
  %t114 = load double, double* %l11
  %t115 = load double, double* %l12
  %t116 = load double, double* %l13
  %t117 = load i8*, i8** %l14
  br i1 %t102, label %then11, label %else12
then11:
  %t118 = load i8*, i8** %l14
  %t119 = load i8*, i8** %l14
  store double 0.0, double* %l15
  %t120 = load double, double* %l15
  %t121 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t121, %NumberParseResult* %l16
  %t122 = load %NumberParseResult, %NumberParseResult* %l16
  %t123 = extractvalue %NumberParseResult %t122, 0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = load i1, i1* %l2
  %t127 = load i1, i1* %l3
  %t128 = load i1, i1* %l4
  %t129 = load i8*, i8** %l5
  %t130 = load i8*, i8** %l6
  %t131 = load i1, i1* %l7
  %t132 = load i1, i1* %l8
  %t133 = load double, double* %l9
  %t134 = load double, double* %l10
  %t135 = load double, double* %l11
  %t136 = load double, double* %l12
  %t137 = load double, double* %l13
  %t138 = load i8*, i8** %l14
  %t139 = load double, double* %l15
  %t140 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t123, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t141 = load %NumberParseResult, %NumberParseResult* %l16
  %t142 = extractvalue %NumberParseResult %t141, 1
  store double %t142, double* %l9
  br label %merge16
else15:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s144 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.144, i32 0, i32 0
  %t145 = load double, double* %l15
  br label %merge16
merge16:
  %t146 = phi i1 [ 1, %then14 ], [ %t127, %else15 ]
  %t147 = phi double [ %t142, %then14 ], [ %t133, %else15 ]
  %t148 = phi { i8**, i64 }* [ %t125, %then14 ], [ null, %else15 ]
  store i1 %t146, i1* %l3
  store double %t147, double* %l9
  store { i8**, i64 }* %t148, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t149 = load i8*, i8** %l14
  %s150 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.150, i32 0, i32 0
  %t151 = call i1 @starts_with(i8* %t149, i8* %s150)
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load i1, i1* %l2
  %t155 = load i1, i1* %l3
  %t156 = load i1, i1* %l4
  %t157 = load i8*, i8** %l5
  %t158 = load i8*, i8** %l6
  %t159 = load i1, i1* %l7
  %t160 = load i1, i1* %l8
  %t161 = load double, double* %l9
  %t162 = load double, double* %l10
  %t163 = load double, double* %l11
  %t164 = load double, double* %l12
  %t165 = load double, double* %l13
  %t166 = load i8*, i8** %l14
  br i1 %t151, label %then17, label %else18
then17:
  %t167 = load i8*, i8** %l14
  %t168 = load i8*, i8** %l14
  store double 0.0, double* %l17
  %t169 = load double, double* %l17
  %t170 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t170, %NumberParseResult* %l18
  %t171 = load %NumberParseResult, %NumberParseResult* %l18
  %t172 = extractvalue %NumberParseResult %t171, 0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load i1, i1* %l2
  %t176 = load i1, i1* %l3
  %t177 = load i1, i1* %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i8*, i8** %l6
  %t180 = load i1, i1* %l7
  %t181 = load i1, i1* %l8
  %t182 = load double, double* %l9
  %t183 = load double, double* %l10
  %t184 = load double, double* %l11
  %t185 = load double, double* %l12
  %t186 = load double, double* %l13
  %t187 = load i8*, i8** %l14
  %t188 = load double, double* %l17
  %t189 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t172, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t190 = load %NumberParseResult, %NumberParseResult* %l18
  %t191 = extractvalue %NumberParseResult %t190, 1
  store double %t191, double* %l10
  br label %merge22
else21:
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s193 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.193, i32 0, i32 0
  %t194 = load double, double* %l17
  br label %merge22
merge22:
  %t195 = phi i1 [ 1, %then20 ], [ %t177, %else21 ]
  %t196 = phi double [ %t191, %then20 ], [ %t183, %else21 ]
  %t197 = phi { i8**, i64 }* [ %t174, %then20 ], [ null, %else21 ]
  store i1 %t195, i1* %l4
  store double %t196, double* %l10
  store { i8**, i64 }* %t197, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t198 = load i8*, i8** %l14
  %s199 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.199, i32 0, i32 0
  %t200 = call i1 @starts_with(i8* %t198, i8* %s199)
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t203 = load i1, i1* %l2
  %t204 = load i1, i1* %l3
  %t205 = load i1, i1* %l4
  %t206 = load i8*, i8** %l5
  %t207 = load i8*, i8** %l6
  %t208 = load i1, i1* %l7
  %t209 = load i1, i1* %l8
  %t210 = load double, double* %l9
  %t211 = load double, double* %l10
  %t212 = load double, double* %l11
  %t213 = load double, double* %l12
  %t214 = load double, double* %l13
  %t215 = load i8*, i8** %l14
  br i1 %t200, label %then23, label %else24
then23:
  %t216 = load i8*, i8** %l14
  %t217 = load i8*, i8** %l14
  br label %merge25
else24:
  %t218 = load i8*, i8** %l14
  %s219 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.219, i32 0, i32 0
  %t220 = call i1 @starts_with(i8* %t218, i8* %s219)
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load i1, i1* %l2
  %t224 = load i1, i1* %l3
  %t225 = load i1, i1* %l4
  %t226 = load i8*, i8** %l5
  %t227 = load i8*, i8** %l6
  %t228 = load i1, i1* %l7
  %t229 = load i1, i1* %l8
  %t230 = load double, double* %l9
  %t231 = load double, double* %l10
  %t232 = load double, double* %l11
  %t233 = load double, double* %l12
  %t234 = load double, double* %l13
  %t235 = load i8*, i8** %l14
  br i1 %t220, label %then26, label %else27
then26:
  %t236 = load i8*, i8** %l14
  %t237 = load i8*, i8** %l14
  store double 0.0, double* %l19
  %t238 = load double, double* %l19
  %t239 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t239, %NumberParseResult* %l20
  %t240 = load %NumberParseResult, %NumberParseResult* %l20
  %t241 = extractvalue %NumberParseResult %t240, 0
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load i1, i1* %l2
  %t245 = load i1, i1* %l3
  %t246 = load i1, i1* %l4
  %t247 = load i8*, i8** %l5
  %t248 = load i8*, i8** %l6
  %t249 = load i1, i1* %l7
  %t250 = load i1, i1* %l8
  %t251 = load double, double* %l9
  %t252 = load double, double* %l10
  %t253 = load double, double* %l11
  %t254 = load double, double* %l12
  %t255 = load double, double* %l13
  %t256 = load i8*, i8** %l14
  %t257 = load double, double* %l19
  %t258 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t241, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t259 = load %NumberParseResult, %NumberParseResult* %l20
  %t260 = extractvalue %NumberParseResult %t259, 1
  store double %t260, double* %l11
  br label %merge31
else30:
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s262 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.262, i32 0, i32 0
  %t263 = load double, double* %l19
  br label %merge31
merge31:
  %t264 = phi i1 [ 1, %then29 ], [ %t249, %else30 ]
  %t265 = phi double [ %t260, %then29 ], [ %t253, %else30 ]
  %t266 = phi { i8**, i64 }* [ %t243, %then29 ], [ null, %else30 ]
  store i1 %t264, i1* %l7
  store double %t265, double* %l11
  store { i8**, i64 }* %t266, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t267 = load i8*, i8** %l14
  %s268 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.268, i32 0, i32 0
  %t269 = call i1 @starts_with(i8* %t267, i8* %s268)
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t272 = load i1, i1* %l2
  %t273 = load i1, i1* %l3
  %t274 = load i1, i1* %l4
  %t275 = load i8*, i8** %l5
  %t276 = load i8*, i8** %l6
  %t277 = load i1, i1* %l7
  %t278 = load i1, i1* %l8
  %t279 = load double, double* %l9
  %t280 = load double, double* %l10
  %t281 = load double, double* %l11
  %t282 = load double, double* %l12
  %t283 = load double, double* %l13
  %t284 = load i8*, i8** %l14
  br i1 %t269, label %then32, label %else33
then32:
  %t285 = load i8*, i8** %l14
  %t286 = load i8*, i8** %l14
  store double 0.0, double* %l21
  %t287 = load double, double* %l21
  %t288 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t288, %NumberParseResult* %l22
  %t289 = load %NumberParseResult, %NumberParseResult* %l22
  %t290 = extractvalue %NumberParseResult %t289, 0
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t293 = load i1, i1* %l2
  %t294 = load i1, i1* %l3
  %t295 = load i1, i1* %l4
  %t296 = load i8*, i8** %l5
  %t297 = load i8*, i8** %l6
  %t298 = load i1, i1* %l7
  %t299 = load i1, i1* %l8
  %t300 = load double, double* %l9
  %t301 = load double, double* %l10
  %t302 = load double, double* %l11
  %t303 = load double, double* %l12
  %t304 = load double, double* %l13
  %t305 = load i8*, i8** %l14
  %t306 = load double, double* %l21
  %t307 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t290, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t308 = load %NumberParseResult, %NumberParseResult* %l22
  %t309 = extractvalue %NumberParseResult %t308, 1
  store double %t309, double* %l12
  br label %merge37
else36:
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s311 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.311, i32 0, i32 0
  %t312 = load double, double* %l21
  br label %merge37
merge37:
  %t313 = phi i1 [ 1, %then35 ], [ %t299, %else36 ]
  %t314 = phi double [ %t309, %then35 ], [ %t303, %else36 ]
  %t315 = phi { i8**, i64 }* [ %t292, %then35 ], [ null, %else36 ]
  store i1 %t313, i1* %l8
  store double %t314, double* %l12
  store { i8**, i64 }* %t315, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s317 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.317, i32 0, i32 0
  %t318 = load i8*, i8** %l14
  %t319 = add i8* %s317, %t318
  %t320 = getelementptr i8, i8* %t319, i64 0
  %t321 = load i8, i8* %t320
  %t322 = add i8 %t321, 96
  %t323 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t316, i8* null)
  store { i8**, i64 }* %t323, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t324 = phi i1 [ 1, %then32 ], [ %t278, %else33 ]
  %t325 = phi double [ %t309, %then32 ], [ %t282, %else33 ]
  %t326 = phi { i8**, i64 }* [ null, %then32 ], [ %t323, %else33 ]
  store i1 %t324, i1* %l8
  store double %t325, double* %l12
  store { i8**, i64 }* %t326, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t327 = phi i1 [ 1, %then26 ], [ %t228, %else27 ]
  %t328 = phi double [ %t260, %then26 ], [ %t232, %else27 ]
  %t329 = phi { i8**, i64 }* [ null, %then26 ], [ null, %else27 ]
  %t330 = phi i1 [ %t229, %then26 ], [ 1, %else27 ]
  %t331 = phi double [ %t233, %then26 ], [ %t309, %else27 ]
  store i1 %t327, i1* %l7
  store double %t328, double* %l11
  store { i8**, i64 }* %t329, { i8**, i64 }** %l1
  store i1 %t330, i1* %l8
  store double %t331, double* %l12
  br label %merge25
merge25:
  %t332 = phi i8* [ null, %then23 ], [ %t207, %else24 ]
  %t333 = phi i1 [ %t208, %then23 ], [ 1, %else24 ]
  %t334 = phi double [ %t212, %then23 ], [ %t260, %else24 ]
  %t335 = phi { i8**, i64 }* [ %t202, %then23 ], [ null, %else24 ]
  %t336 = phi i1 [ %t209, %then23 ], [ 1, %else24 ]
  %t337 = phi double [ %t213, %then23 ], [ %t309, %else24 ]
  store i8* %t332, i8** %l6
  store i1 %t333, i1* %l7
  store double %t334, double* %l11
  store { i8**, i64 }* %t335, { i8**, i64 }** %l1
  store i1 %t336, i1* %l8
  store double %t337, double* %l12
  br label %merge19
merge19:
  %t338 = phi i1 [ 1, %then17 ], [ %t156, %else18 ]
  %t339 = phi double [ %t191, %then17 ], [ %t162, %else18 ]
  %t340 = phi { i8**, i64 }* [ null, %then17 ], [ null, %else18 ]
  %t341 = phi i8* [ %t158, %then17 ], [ null, %else18 ]
  %t342 = phi i1 [ %t159, %then17 ], [ 1, %else18 ]
  %t343 = phi double [ %t163, %then17 ], [ %t260, %else18 ]
  %t344 = phi i1 [ %t160, %then17 ], [ 1, %else18 ]
  %t345 = phi double [ %t164, %then17 ], [ %t309, %else18 ]
  store i1 %t338, i1* %l4
  store double %t339, double* %l10
  store { i8**, i64 }* %t340, { i8**, i64 }** %l1
  store i8* %t341, i8** %l6
  store i1 %t342, i1* %l7
  store double %t343, double* %l11
  store i1 %t344, i1* %l8
  store double %t345, double* %l12
  br label %merge13
merge13:
  %t346 = phi i1 [ 1, %then11 ], [ %t106, %else12 ]
  %t347 = phi double [ %t142, %then11 ], [ %t112, %else12 ]
  %t348 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t349 = phi i1 [ %t107, %then11 ], [ 1, %else12 ]
  %t350 = phi double [ %t113, %then11 ], [ %t191, %else12 ]
  %t351 = phi i8* [ %t109, %then11 ], [ null, %else12 ]
  %t352 = phi i1 [ %t110, %then11 ], [ 1, %else12 ]
  %t353 = phi double [ %t114, %then11 ], [ %t260, %else12 ]
  %t354 = phi i1 [ %t111, %then11 ], [ 1, %else12 ]
  %t355 = phi double [ %t115, %then11 ], [ %t309, %else12 ]
  store i1 %t346, i1* %l3
  store double %t347, double* %l9
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  store i1 %t349, i1* %l4
  store double %t350, double* %l10
  store i8* %t351, i8** %l6
  store i1 %t352, i1* %l7
  store double %t353, double* %l11
  store i1 %t354, i1* %l8
  store double %t355, double* %l12
  br label %merge10
merge10:
  %t356 = phi i8* [ null, %then8 ], [ %t88, %else9 ]
  %t357 = phi i1 [ 1, %then8 ], [ %t85, %else9 ]
  %t358 = phi i1 [ %t86, %then8 ], [ 1, %else9 ]
  %t359 = phi double [ %t92, %then8 ], [ %t142, %else9 ]
  %t360 = phi { i8**, i64 }* [ %t84, %then8 ], [ null, %else9 ]
  %t361 = phi i1 [ %t87, %then8 ], [ 1, %else9 ]
  %t362 = phi double [ %t93, %then8 ], [ %t191, %else9 ]
  %t363 = phi i8* [ %t89, %then8 ], [ null, %else9 ]
  %t364 = phi i1 [ %t90, %then8 ], [ 1, %else9 ]
  %t365 = phi double [ %t94, %then8 ], [ %t260, %else9 ]
  %t366 = phi i1 [ %t91, %then8 ], [ 1, %else9 ]
  %t367 = phi double [ %t95, %then8 ], [ %t309, %else9 ]
  store i8* %t356, i8** %l5
  store i1 %t357, i1* %l2
  store i1 %t358, i1* %l3
  store double %t359, double* %l9
  store { i8**, i64 }* %t360, { i8**, i64 }** %l1
  store i1 %t361, i1* %l4
  store double %t362, double* %l10
  store i8* %t363, i8** %l6
  store i1 %t364, i1* %l7
  store double %t365, double* %l11
  store i1 %t366, i1* %l8
  store double %t367, double* %l12
  %t368 = load double, double* %l13
  %t369 = sitofp i64 1 to double
  %t370 = fadd double %t368, %t369
  store double %t370, double* %l13
  br label %loop.latch4
loop.latch4:
  %t371 = load i8*, i8** %l5
  %t372 = load i1, i1* %l2
  %t373 = load i1, i1* %l3
  %t374 = load double, double* %l9
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t376 = load i1, i1* %l4
  %t377 = load double, double* %l10
  %t378 = load i8*, i8** %l6
  %t379 = load i1, i1* %l7
  %t380 = load double, double* %l11
  %t381 = load i1, i1* %l8
  %t382 = load double, double* %l12
  %t383 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t397 = load i1, i1* %l3
  %t398 = xor i1 %t397, 1
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t401 = load i1, i1* %l2
  %t402 = load i1, i1* %l3
  %t403 = load i1, i1* %l4
  %t404 = load i8*, i8** %l5
  %t405 = load i8*, i8** %l6
  %t406 = load i1, i1* %l7
  %t407 = load i1, i1* %l8
  %t408 = load double, double* %l9
  %t409 = load double, double* %l10
  %t410 = load double, double* %l11
  %t411 = load double, double* %l12
  %t412 = load double, double* %l13
  br i1 %t398, label %then38, label %merge39
then38:
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s414 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.414, i32 0, i32 0
  %t415 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t413, i8* %s414)
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t416 = phi { i8**, i64 }* [ %t415, %then38 ], [ %t400, %entry ]
  store { i8**, i64 }* %t416, { i8**, i64 }** %l1
  %t417 = load i1, i1* %l4
  %t418 = xor i1 %t417, 1
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t421 = load i1, i1* %l2
  %t422 = load i1, i1* %l3
  %t423 = load i1, i1* %l4
  %t424 = load i8*, i8** %l5
  %t425 = load i8*, i8** %l6
  %t426 = load i1, i1* %l7
  %t427 = load i1, i1* %l8
  %t428 = load double, double* %l9
  %t429 = load double, double* %l10
  %t430 = load double, double* %l11
  %t431 = load double, double* %l12
  %t432 = load double, double* %l13
  br i1 %t418, label %then40, label %merge41
then40:
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s434 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.434, i32 0, i32 0
  %t435 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t433, i8* %s434)
  store { i8**, i64 }* %t435, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t436 = phi { i8**, i64 }* [ %t435, %then40 ], [ %t420, %entry ]
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  %t437 = load i8*, i8** %l6
  %t438 = load i1, i1* %l7
  %t439 = xor i1 %t438, 1
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t442 = load i1, i1* %l2
  %t443 = load i1, i1* %l3
  %t444 = load i1, i1* %l4
  %t445 = load i8*, i8** %l5
  %t446 = load i8*, i8** %l6
  %t447 = load i1, i1* %l7
  %t448 = load i1, i1* %l8
  %t449 = load double, double* %l9
  %t450 = load double, double* %l10
  %t451 = load double, double* %l11
  %t452 = load double, double* %l12
  %t453 = load double, double* %l13
  br i1 %t439, label %then42, label %merge43
then42:
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s455 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.455, i32 0, i32 0
  %t456 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t454, i8* %s455)
  store { i8**, i64 }* %t456, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t457 = phi { i8**, i64 }* [ %t456, %then42 ], [ %t441, %entry ]
  store { i8**, i64 }* %t457, { i8**, i64 }** %l1
  %t458 = load i1, i1* %l8
  %t459 = xor i1 %t458, 1
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t462 = load i1, i1* %l2
  %t463 = load i1, i1* %l3
  %t464 = load i1, i1* %l4
  %t465 = load i8*, i8** %l5
  %t466 = load i8*, i8** %l6
  %t467 = load i1, i1* %l7
  %t468 = load i1, i1* %l8
  %t469 = load double, double* %l9
  %t470 = load double, double* %l10
  %t471 = load double, double* %l11
  %t472 = load double, double* %l12
  %t473 = load double, double* %l13
  br i1 %t459, label %then44, label %merge45
then44:
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s475 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.475, i32 0, i32 0
  %t476 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t474, i8* %s475)
  store { i8**, i64 }* %t476, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t477 = phi { i8**, i64 }* [ %t476, %then44 ], [ %t461, %entry ]
  store { i8**, i64 }* %t477, { i8**, i64 }** %l1
  %t483 = load i1, i1* %l3
  br label %logical_and_entry_482

logical_and_entry_482:
  br i1 %t483, label %logical_and_right_482, label %logical_and_merge_482

logical_and_right_482:
  %t484 = load i1, i1* %l4
  br label %logical_and_right_end_482

logical_and_right_end_482:
  br label %logical_and_merge_482

logical_and_merge_482:
  %t485 = phi i1 [ false, %logical_and_entry_482 ], [ %t484, %logical_and_right_end_482 ]
  br label %logical_and_entry_481

logical_and_entry_481:
  br i1 %t485, label %logical_and_right_481, label %logical_and_merge_481

logical_and_right_481:
  %t486 = load i8*, i8** %l6
  store double 0.0, double* %l23
  %t487 = load double, double* %l23
  %t488 = fcmp one double %t487, 0.0
  %t489 = insertvalue %EnumLayoutHeaderParse undef, i1 %t488, 0
  %t490 = load i8*, i8** %l5
  %t491 = insertvalue %EnumLayoutHeaderParse %t489, i8* %t490, 1
  %t492 = load double, double* %l9
  %t493 = insertvalue %EnumLayoutHeaderParse %t491, double %t492, 2
  %t494 = load double, double* %l10
  %t495 = insertvalue %EnumLayoutHeaderParse %t493, double %t494, 3
  %t496 = load i8*, i8** %l6
  %t497 = insertvalue %EnumLayoutHeaderParse %t495, i8* %t496, 4
  %t498 = load double, double* %l11
  %t499 = insertvalue %EnumLayoutHeaderParse %t497, double %t498, 5
  %t500 = load double, double* %l12
  %t501 = insertvalue %EnumLayoutHeaderParse %t499, double %t500, 6
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t503 = insertvalue %EnumLayoutHeaderParse %t501, { i8**, i64 }* %t502, 7
  ret %EnumLayoutHeaderParse %t503
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
  %l15 = alloca double
  %l16 = alloca %NumberParseResult
  %l17 = alloca double
  %l18 = alloca %NumberParseResult
  %l19 = alloca double
  %l20 = alloca %NumberParseResult
  %l21 = alloca double
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
  %t23 = load i8*, i8** %l0
  %t24 = call { i8**, i64 }* @split_whitespace(i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l3
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t25
  %t27 = extractvalue { i8**, i64 } %t26, 1
  %t28 = icmp eq i64 %t27, 0
  %t29 = load i8*, i8** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t28, label %then0, label %merge1
then0:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s34 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.34, i32 0, i32 0
  %t35 = add i8* %s34, %enum_name
  %s36 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %t35, %s36
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l1
  %t39 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t40 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t41 = insertvalue %EnumLayoutVariantParse %t39, i8* null, 1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = insertvalue %EnumLayoutVariantParse %t41, { i8**, i64 }* %t42, 2
  ret %EnumLayoutVariantParse %t43
merge1:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 0, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr i8*, i8** %t46, i64 0
  %t50 = load i8*, i8** %t49
  store i8* %t50, i8** %l4
  %t51 = load i8*, i8** %l4
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t52 = sitofp i64 0 to double
  store double %t52, double* %l9
  %t53 = sitofp i64 0 to double
  store double %t53, double* %l10
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l11
  %t55 = sitofp i64 0 to double
  store double %t55, double* %l12
  %t56 = sitofp i64 1 to double
  store double %t56, double* %l13
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t61 = load i8*, i8** %l4
  %t62 = load i1, i1* %l5
  %t63 = load i1, i1* %l6
  %t64 = load i1, i1* %l7
  %t65 = load i1, i1* %l8
  %t66 = load double, double* %l9
  %t67 = load double, double* %l10
  %t68 = load double, double* %l11
  %t69 = load double, double* %l12
  %t70 = load double, double* %l13
  br label %loop.header2
loop.header2:
  %t375 = phi i1 [ %t62, %entry ], [ %t365, %loop.latch4 ]
  %t376 = phi double [ %t66, %entry ], [ %t366, %loop.latch4 ]
  %t377 = phi { i8**, i64 }* [ %t58, %entry ], [ %t367, %loop.latch4 ]
  %t378 = phi i1 [ %t63, %entry ], [ %t368, %loop.latch4 ]
  %t379 = phi double [ %t67, %entry ], [ %t369, %loop.latch4 ]
  %t380 = phi i1 [ %t64, %entry ], [ %t370, %loop.latch4 ]
  %t381 = phi double [ %t68, %entry ], [ %t371, %loop.latch4 ]
  %t382 = phi i1 [ %t65, %entry ], [ %t372, %loop.latch4 ]
  %t383 = phi double [ %t69, %entry ], [ %t373, %loop.latch4 ]
  %t384 = phi double [ %t70, %entry ], [ %t374, %loop.latch4 ]
  store i1 %t375, i1* %l5
  store double %t376, double* %l9
  store { i8**, i64 }* %t377, { i8**, i64 }** %l1
  store i1 %t378, i1* %l6
  store double %t379, double* %l10
  store i1 %t380, i1* %l7
  store double %t381, double* %l11
  store i1 %t382, i1* %l8
  store double %t383, double* %l12
  store double %t384, double* %l13
  br label %loop.body3
loop.body3:
  %t71 = load double, double* %l13
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t73 = load { i8**, i64 }, { i8**, i64 }* %t72
  %t74 = extractvalue { i8**, i64 } %t73, 1
  %t75 = sitofp i64 %t74 to double
  %t76 = fcmp oge double %t71, %t75
  %t77 = load i8*, i8** %l0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t81 = load i8*, i8** %l4
  %t82 = load i1, i1* %l5
  %t83 = load i1, i1* %l6
  %t84 = load i1, i1* %l7
  %t85 = load i1, i1* %l8
  %t86 = load double, double* %l9
  %t87 = load double, double* %l10
  %t88 = load double, double* %l11
  %t89 = load double, double* %l12
  %t90 = load double, double* %l13
  br i1 %t76, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t92 = load double, double* %l13
  %t93 = load { i8**, i64 }, { i8**, i64 }* %t91
  %t94 = extractvalue { i8**, i64 } %t93, 0
  %t95 = extractvalue { i8**, i64 } %t93, 1
  %t96 = icmp uge i64 %t92, %t95
  ; bounds check: %t96 (if true, out of bounds)
  %t97 = getelementptr i8*, i8** %t94, i64 %t92
  %t98 = load i8*, i8** %t97
  store i8* %t98, i8** %l14
  %t99 = load i8*, i8** %l14
  %s100 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t106 = load i8*, i8** %l4
  %t107 = load i1, i1* %l5
  %t108 = load i1, i1* %l6
  %t109 = load i1, i1* %l7
  %t110 = load i1, i1* %l8
  %t111 = load double, double* %l9
  %t112 = load double, double* %l10
  %t113 = load double, double* %l11
  %t114 = load double, double* %l12
  %t115 = load double, double* %l13
  %t116 = load i8*, i8** %l14
  br i1 %t101, label %then8, label %else9
then8:
  %t117 = load i8*, i8** %l14
  %t118 = load i8*, i8** %l14
  store double 0.0, double* %l15
  %t119 = load double, double* %l15
  %t120 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t120, %NumberParseResult* %l16
  %t121 = load %NumberParseResult, %NumberParseResult* %l16
  %t122 = extractvalue %NumberParseResult %t121, 0
  %t123 = load i8*, i8** %l0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t125 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t127 = load i8*, i8** %l4
  %t128 = load i1, i1* %l5
  %t129 = load i1, i1* %l6
  %t130 = load i1, i1* %l7
  %t131 = load i1, i1* %l8
  %t132 = load double, double* %l9
  %t133 = load double, double* %l10
  %t134 = load double, double* %l11
  %t135 = load double, double* %l12
  %t136 = load double, double* %l13
  %t137 = load i8*, i8** %l14
  %t138 = load double, double* %l15
  %t139 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t122, label %then11, label %else12
then11:
  store i1 1, i1* %l5
  %t140 = load %NumberParseResult, %NumberParseResult* %l16
  %t141 = extractvalue %NumberParseResult %t140, 1
  store double %t141, double* %l9
  br label %merge13
else12:
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s143 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.143, i32 0, i32 0
  %t144 = add i8* %s143, %enum_name
  %s145 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.145, i32 0, i32 0
  %t146 = add i8* %t144, %s145
  %t147 = load i8*, i8** %l4
  %t148 = add i8* %t146, %t147
  %s149 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.149, i32 0, i32 0
  %t150 = add i8* %t148, %s149
  %t151 = load double, double* %l15
  br label %merge13
merge13:
  %t152 = phi i1 [ 1, %then11 ], [ %t128, %else12 ]
  %t153 = phi double [ %t141, %then11 ], [ %t132, %else12 ]
  %t154 = phi { i8**, i64 }* [ %t124, %then11 ], [ null, %else12 ]
  store i1 %t152, i1* %l5
  store double %t153, double* %l9
  store { i8**, i64 }* %t154, { i8**, i64 }** %l1
  br label %merge10
else9:
  %t155 = load i8*, i8** %l14
  %s156 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.156, i32 0, i32 0
  %t157 = call i1 @starts_with(i8* %t155, i8* %s156)
  %t158 = load i8*, i8** %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t160 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t162 = load i8*, i8** %l4
  %t163 = load i1, i1* %l5
  %t164 = load i1, i1* %l6
  %t165 = load i1, i1* %l7
  %t166 = load i1, i1* %l8
  %t167 = load double, double* %l9
  %t168 = load double, double* %l10
  %t169 = load double, double* %l11
  %t170 = load double, double* %l12
  %t171 = load double, double* %l13
  %t172 = load i8*, i8** %l14
  br i1 %t157, label %then14, label %else15
then14:
  %t173 = load i8*, i8** %l14
  %t174 = load i8*, i8** %l14
  store double 0.0, double* %l17
  %t175 = load double, double* %l17
  %t176 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t176, %NumberParseResult* %l18
  %t177 = load %NumberParseResult, %NumberParseResult* %l18
  %t178 = extractvalue %NumberParseResult %t177, 0
  %t179 = load i8*, i8** %l0
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t181 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t183 = load i8*, i8** %l4
  %t184 = load i1, i1* %l5
  %t185 = load i1, i1* %l6
  %t186 = load i1, i1* %l7
  %t187 = load i1, i1* %l8
  %t188 = load double, double* %l9
  %t189 = load double, double* %l10
  %t190 = load double, double* %l11
  %t191 = load double, double* %l12
  %t192 = load double, double* %l13
  %t193 = load i8*, i8** %l14
  %t194 = load double, double* %l17
  %t195 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t178, label %then17, label %else18
then17:
  store i1 1, i1* %l6
  %t196 = load %NumberParseResult, %NumberParseResult* %l18
  %t197 = extractvalue %NumberParseResult %t196, 1
  store double %t197, double* %l10
  br label %merge19
else18:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s199 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.199, i32 0, i32 0
  %t200 = add i8* %s199, %enum_name
  %s201 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.201, i32 0, i32 0
  %t202 = add i8* %t200, %s201
  %t203 = load i8*, i8** %l4
  %t204 = add i8* %t202, %t203
  %s205 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.205, i32 0, i32 0
  %t206 = add i8* %t204, %s205
  %t207 = load double, double* %l17
  br label %merge19
merge19:
  %t208 = phi i1 [ 1, %then17 ], [ %t185, %else18 ]
  %t209 = phi double [ %t197, %then17 ], [ %t189, %else18 ]
  %t210 = phi { i8**, i64 }* [ %t180, %then17 ], [ null, %else18 ]
  store i1 %t208, i1* %l6
  store double %t209, double* %l10
  store { i8**, i64 }* %t210, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t211 = load i8*, i8** %l14
  %s212 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.212, i32 0, i32 0
  %t213 = call i1 @starts_with(i8* %t211, i8* %s212)
  %t214 = load i8*, i8** %l0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t216 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t218 = load i8*, i8** %l4
  %t219 = load i1, i1* %l5
  %t220 = load i1, i1* %l6
  %t221 = load i1, i1* %l7
  %t222 = load i1, i1* %l8
  %t223 = load double, double* %l9
  %t224 = load double, double* %l10
  %t225 = load double, double* %l11
  %t226 = load double, double* %l12
  %t227 = load double, double* %l13
  %t228 = load i8*, i8** %l14
  br i1 %t213, label %then20, label %else21
then20:
  %t229 = load i8*, i8** %l14
  %t230 = load i8*, i8** %l14
  store double 0.0, double* %l19
  %t231 = load double, double* %l19
  %t232 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t232, %NumberParseResult* %l20
  %t233 = load %NumberParseResult, %NumberParseResult* %l20
  %t234 = extractvalue %NumberParseResult %t233, 0
  %t235 = load i8*, i8** %l0
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t237 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t239 = load i8*, i8** %l4
  %t240 = load i1, i1* %l5
  %t241 = load i1, i1* %l6
  %t242 = load i1, i1* %l7
  %t243 = load i1, i1* %l8
  %t244 = load double, double* %l9
  %t245 = load double, double* %l10
  %t246 = load double, double* %l11
  %t247 = load double, double* %l12
  %t248 = load double, double* %l13
  %t249 = load i8*, i8** %l14
  %t250 = load double, double* %l19
  %t251 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t234, label %then23, label %else24
then23:
  store i1 1, i1* %l7
  %t252 = load %NumberParseResult, %NumberParseResult* %l20
  %t253 = extractvalue %NumberParseResult %t252, 1
  store double %t253, double* %l11
  br label %merge25
else24:
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s255 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.255, i32 0, i32 0
  %t256 = add i8* %s255, %enum_name
  %s257 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.257, i32 0, i32 0
  %t258 = add i8* %t256, %s257
  %t259 = load i8*, i8** %l4
  %t260 = add i8* %t258, %t259
  %s261 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.261, i32 0, i32 0
  %t262 = add i8* %t260, %s261
  %t263 = load double, double* %l19
  br label %merge25
merge25:
  %t264 = phi i1 [ 1, %then23 ], [ %t242, %else24 ]
  %t265 = phi double [ %t253, %then23 ], [ %t246, %else24 ]
  %t266 = phi { i8**, i64 }* [ %t236, %then23 ], [ null, %else24 ]
  store i1 %t264, i1* %l7
  store double %t265, double* %l11
  store { i8**, i64 }* %t266, { i8**, i64 }** %l1
  br label %merge22
else21:
  %t267 = load i8*, i8** %l14
  %s268 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.268, i32 0, i32 0
  %t269 = call i1 @starts_with(i8* %t267, i8* %s268)
  %t270 = load i8*, i8** %l0
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t272 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t274 = load i8*, i8** %l4
  %t275 = load i1, i1* %l5
  %t276 = load i1, i1* %l6
  %t277 = load i1, i1* %l7
  %t278 = load i1, i1* %l8
  %t279 = load double, double* %l9
  %t280 = load double, double* %l10
  %t281 = load double, double* %l11
  %t282 = load double, double* %l12
  %t283 = load double, double* %l13
  %t284 = load i8*, i8** %l14
  br i1 %t269, label %then26, label %else27
then26:
  %t285 = load i8*, i8** %l14
  %t286 = load i8*, i8** %l14
  store double 0.0, double* %l21
  %t287 = load double, double* %l21
  %t288 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t288, %NumberParseResult* %l22
  %t289 = load %NumberParseResult, %NumberParseResult* %l22
  %t290 = extractvalue %NumberParseResult %t289, 0
  %t291 = load i8*, i8** %l0
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t293 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t295 = load i8*, i8** %l4
  %t296 = load i1, i1* %l5
  %t297 = load i1, i1* %l6
  %t298 = load i1, i1* %l7
  %t299 = load i1, i1* %l8
  %t300 = load double, double* %l9
  %t301 = load double, double* %l10
  %t302 = load double, double* %l11
  %t303 = load double, double* %l12
  %t304 = load double, double* %l13
  %t305 = load i8*, i8** %l14
  %t306 = load double, double* %l21
  %t307 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t290, label %then29, label %else30
then29:
  store i1 1, i1* %l8
  %t308 = load %NumberParseResult, %NumberParseResult* %l22
  %t309 = extractvalue %NumberParseResult %t308, 1
  store double %t309, double* %l12
  br label %merge31
else30:
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s311 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.311, i32 0, i32 0
  %t312 = add i8* %s311, %enum_name
  %s313 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.313, i32 0, i32 0
  %t314 = add i8* %t312, %s313
  %t315 = load i8*, i8** %l4
  %t316 = add i8* %t314, %t315
  %s317 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.317, i32 0, i32 0
  %t318 = add i8* %t316, %s317
  %t319 = load double, double* %l21
  br label %merge31
merge31:
  %t320 = phi i1 [ 1, %then29 ], [ %t299, %else30 ]
  %t321 = phi double [ %t309, %then29 ], [ %t303, %else30 ]
  %t322 = phi { i8**, i64 }* [ %t292, %then29 ], [ null, %else30 ]
  store i1 %t320, i1* %l8
  store double %t321, double* %l12
  store { i8**, i64 }* %t322, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s324 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.324, i32 0, i32 0
  %t325 = add i8* %s324, %enum_name
  %s326 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.326, i32 0, i32 0
  %t327 = add i8* %t325, %s326
  %t328 = load i8*, i8** %l4
  %t329 = add i8* %t327, %t328
  %s330 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.330, i32 0, i32 0
  %t331 = add i8* %t329, %s330
  %t332 = load i8*, i8** %l14
  %t333 = add i8* %t331, %t332
  %t334 = getelementptr i8, i8* %t333, i64 0
  %t335 = load i8, i8* %t334
  %t336 = add i8 %t335, 96
  %t337 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t323, i8* null)
  store { i8**, i64 }* %t337, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t338 = phi i1 [ 1, %then26 ], [ %t278, %else27 ]
  %t339 = phi double [ %t309, %then26 ], [ %t282, %else27 ]
  %t340 = phi { i8**, i64 }* [ null, %then26 ], [ %t337, %else27 ]
  store i1 %t338, i1* %l8
  store double %t339, double* %l12
  store { i8**, i64 }* %t340, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t341 = phi i1 [ 1, %then20 ], [ %t221, %else21 ]
  %t342 = phi double [ %t253, %then20 ], [ %t225, %else21 ]
  %t343 = phi { i8**, i64 }* [ null, %then20 ], [ null, %else21 ]
  %t344 = phi i1 [ %t222, %then20 ], [ 1, %else21 ]
  %t345 = phi double [ %t226, %then20 ], [ %t309, %else21 ]
  store i1 %t341, i1* %l7
  store double %t342, double* %l11
  store { i8**, i64 }* %t343, { i8**, i64 }** %l1
  store i1 %t344, i1* %l8
  store double %t345, double* %l12
  br label %merge16
merge16:
  %t346 = phi i1 [ 1, %then14 ], [ %t164, %else15 ]
  %t347 = phi double [ %t197, %then14 ], [ %t168, %else15 ]
  %t348 = phi { i8**, i64 }* [ null, %then14 ], [ null, %else15 ]
  %t349 = phi i1 [ %t165, %then14 ], [ 1, %else15 ]
  %t350 = phi double [ %t169, %then14 ], [ %t253, %else15 ]
  %t351 = phi i1 [ %t166, %then14 ], [ 1, %else15 ]
  %t352 = phi double [ %t170, %then14 ], [ %t309, %else15 ]
  store i1 %t346, i1* %l6
  store double %t347, double* %l10
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  store i1 %t349, i1* %l7
  store double %t350, double* %l11
  store i1 %t351, i1* %l8
  store double %t352, double* %l12
  br label %merge10
merge10:
  %t353 = phi i1 [ 1, %then8 ], [ %t107, %else9 ]
  %t354 = phi double [ %t141, %then8 ], [ %t111, %else9 ]
  %t355 = phi { i8**, i64 }* [ null, %then8 ], [ null, %else9 ]
  %t356 = phi i1 [ %t108, %then8 ], [ 1, %else9 ]
  %t357 = phi double [ %t112, %then8 ], [ %t197, %else9 ]
  %t358 = phi i1 [ %t109, %then8 ], [ 1, %else9 ]
  %t359 = phi double [ %t113, %then8 ], [ %t253, %else9 ]
  %t360 = phi i1 [ %t110, %then8 ], [ 1, %else9 ]
  %t361 = phi double [ %t114, %then8 ], [ %t309, %else9 ]
  store i1 %t353, i1* %l5
  store double %t354, double* %l9
  store { i8**, i64 }* %t355, { i8**, i64 }** %l1
  store i1 %t356, i1* %l6
  store double %t357, double* %l10
  store i1 %t358, i1* %l7
  store double %t359, double* %l11
  store i1 %t360, i1* %l8
  store double %t361, double* %l12
  %t362 = load double, double* %l13
  %t363 = sitofp i64 1 to double
  %t364 = fadd double %t362, %t363
  store double %t364, double* %l13
  br label %loop.latch4
loop.latch4:
  %t365 = load i1, i1* %l5
  %t366 = load double, double* %l9
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t368 = load i1, i1* %l6
  %t369 = load double, double* %l10
  %t370 = load i1, i1* %l7
  %t371 = load double, double* %l11
  %t372 = load i1, i1* %l8
  %t373 = load double, double* %l12
  %t374 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t385 = load i1, i1* %l5
  %t386 = xor i1 %t385, 1
  %t387 = load i8*, i8** %l0
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t389 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t391 = load i8*, i8** %l4
  %t392 = load i1, i1* %l5
  %t393 = load i1, i1* %l6
  %t394 = load i1, i1* %l7
  %t395 = load i1, i1* %l8
  %t396 = load double, double* %l9
  %t397 = load double, double* %l10
  %t398 = load double, double* %l11
  %t399 = load double, double* %l12
  %t400 = load double, double* %l13
  br i1 %t386, label %then32, label %merge33
then32:
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s402 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.402, i32 0, i32 0
  %t403 = add i8* %s402, %enum_name
  %s404 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.404, i32 0, i32 0
  %t405 = add i8* %t403, %s404
  %t406 = load i8*, i8** %l4
  %t407 = add i8* %t405, %t406
  %s408 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.408, i32 0, i32 0
  %t409 = add i8* %t407, %s408
  %t410 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t401, i8* %t409)
  store { i8**, i64 }* %t410, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t411 = phi { i8**, i64 }* [ %t410, %then32 ], [ %t388, %entry ]
  store { i8**, i64 }* %t411, { i8**, i64 }** %l1
  %t412 = load i1, i1* %l6
  %t413 = xor i1 %t412, 1
  %t414 = load i8*, i8** %l0
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t416 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t418 = load i8*, i8** %l4
  %t419 = load i1, i1* %l5
  %t420 = load i1, i1* %l6
  %t421 = load i1, i1* %l7
  %t422 = load i1, i1* %l8
  %t423 = load double, double* %l9
  %t424 = load double, double* %l10
  %t425 = load double, double* %l11
  %t426 = load double, double* %l12
  %t427 = load double, double* %l13
  br i1 %t413, label %then34, label %merge35
then34:
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s429 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.429, i32 0, i32 0
  %t430 = add i8* %s429, %enum_name
  %s431 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.431, i32 0, i32 0
  %t432 = add i8* %t430, %s431
  %t433 = load i8*, i8** %l4
  %t434 = add i8* %t432, %t433
  %s435 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.435, i32 0, i32 0
  %t436 = add i8* %t434, %s435
  %t437 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t428, i8* %t436)
  store { i8**, i64 }* %t437, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t438 = phi { i8**, i64 }* [ %t437, %then34 ], [ %t415, %entry ]
  store { i8**, i64 }* %t438, { i8**, i64 }** %l1
  %t439 = load i1, i1* %l7
  %t440 = xor i1 %t439, 1
  %t441 = load i8*, i8** %l0
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t443 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t445 = load i8*, i8** %l4
  %t446 = load i1, i1* %l5
  %t447 = load i1, i1* %l6
  %t448 = load i1, i1* %l7
  %t449 = load i1, i1* %l8
  %t450 = load double, double* %l9
  %t451 = load double, double* %l10
  %t452 = load double, double* %l11
  %t453 = load double, double* %l12
  %t454 = load double, double* %l13
  br i1 %t440, label %then36, label %merge37
then36:
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s456 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.456, i32 0, i32 0
  %t457 = add i8* %s456, %enum_name
  %s458 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.458, i32 0, i32 0
  %t459 = add i8* %t457, %s458
  %t460 = load i8*, i8** %l4
  %t461 = add i8* %t459, %t460
  %s462 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.462, i32 0, i32 0
  %t463 = add i8* %t461, %s462
  %t464 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t455, i8* %t463)
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t465 = phi { i8**, i64 }* [ %t464, %then36 ], [ %t442, %entry ]
  store { i8**, i64 }* %t465, { i8**, i64 }** %l1
  %t466 = load i1, i1* %l8
  %t467 = xor i1 %t466, 1
  %t468 = load i8*, i8** %l0
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t470 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t472 = load i8*, i8** %l4
  %t473 = load i1, i1* %l5
  %t474 = load i1, i1* %l6
  %t475 = load i1, i1* %l7
  %t476 = load i1, i1* %l8
  %t477 = load double, double* %l9
  %t478 = load double, double* %l10
  %t479 = load double, double* %l11
  %t480 = load double, double* %l12
  %t481 = load double, double* %l13
  br i1 %t467, label %then38, label %merge39
then38:
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s483 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.483, i32 0, i32 0
  %t484 = add i8* %s483, %enum_name
  %s485 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.485, i32 0, i32 0
  %t486 = add i8* %t484, %s485
  %t487 = load i8*, i8** %l4
  %t488 = add i8* %t486, %t487
  %s489 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.489, i32 0, i32 0
  %t490 = add i8* %t488, %s489
  %t491 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t482, i8* %t490)
  store { i8**, i64 }* %t491, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t492 = phi { i8**, i64 }* [ %t491, %then38 ], [ %t469, %entry ]
  store { i8**, i64 }* %t492, { i8**, i64 }** %l1
  %t497 = load i1, i1* %l5
  br label %logical_and_entry_496

logical_and_entry_496:
  br i1 %t497, label %logical_and_right_496, label %logical_and_merge_496

logical_and_right_496:
  %t498 = load i1, i1* %l6
  br label %logical_and_right_end_496

logical_and_right_end_496:
  br label %logical_and_merge_496

logical_and_merge_496:
  %t499 = phi i1 [ false, %logical_and_entry_496 ], [ %t498, %logical_and_right_end_496 ]
  br label %logical_and_entry_495

logical_and_entry_495:
  br i1 %t499, label %logical_and_right_495, label %logical_and_merge_495

logical_and_right_495:
  %t500 = load i1, i1* %l7
  br label %logical_and_right_end_495

logical_and_right_end_495:
  br label %logical_and_merge_495

logical_and_merge_495:
  %t501 = phi i1 [ false, %logical_and_entry_495 ], [ %t500, %logical_and_right_end_495 ]
  br label %logical_and_entry_494

logical_and_entry_494:
  br i1 %t501, label %logical_and_right_494, label %logical_and_merge_494

logical_and_right_494:
  %t502 = load i1, i1* %l8
  br label %logical_and_right_end_494

logical_and_right_end_494:
  br label %logical_and_merge_494

logical_and_merge_494:
  %t503 = phi i1 [ false, %logical_and_entry_494 ], [ %t502, %logical_and_right_end_494 ]
  br label %logical_and_entry_493

logical_and_entry_493:
  br i1 %t503, label %logical_and_right_493, label %logical_and_merge_493

logical_and_right_493:
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t505 = load { i8**, i64 }, { i8**, i64 }* %t504
  %t506 = extractvalue { i8**, i64 } %t505, 1
  %t507 = icmp eq i64 %t506, 0
  br label %logical_and_right_end_493

logical_and_right_end_493:
  br label %logical_and_merge_493

logical_and_merge_493:
  %t508 = phi i1 [ false, %logical_and_entry_493 ], [ %t507, %logical_and_right_end_493 ]
  store i1 %t508, i1* %l23
  %t509 = load i8*, i8** %l4
  %t510 = insertvalue %NativeEnumVariantLayout undef, i8* %t509, 0
  %t511 = load double, double* %l9
  %t512 = insertvalue %NativeEnumVariantLayout %t510, double %t511, 1
  %t513 = load double, double* %l10
  %t514 = insertvalue %NativeEnumVariantLayout %t512, double %t513, 2
  %t515 = load double, double* %l11
  %t516 = insertvalue %NativeEnumVariantLayout %t514, double %t515, 3
  %t517 = load double, double* %l12
  %t518 = insertvalue %NativeEnumVariantLayout %t516, double %t517, 4
  %t519 = alloca [0 x i8*]
  %t520 = getelementptr [0 x i8*], [0 x i8*]* %t519, i32 0, i32 0
  %t521 = alloca { i8**, i64 }
  %t522 = getelementptr { i8**, i64 }, { i8**, i64 }* %t521, i32 0, i32 0
  store i8** %t520, i8*** %t522
  %t523 = getelementptr { i8**, i64 }, { i8**, i64 }* %t521, i32 0, i32 1
  store i64 0, i64* %t523
  %t524 = insertvalue %NativeEnumVariantLayout %t518, { i8**, i64 }* %t521, 5
  store %NativeEnumVariantLayout %t524, %NativeEnumVariantLayout* %l24
  %t525 = load i1, i1* %l23
  %t526 = insertvalue %EnumLayoutVariantParse undef, i1 %t525, 0
  %t527 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t528 = insertvalue %EnumLayoutVariantParse %t526, i8* null, 1
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t530 = insertvalue %EnumLayoutVariantParse %t528, { i8**, i64 }* %t529, 2
  ret %EnumLayoutVariantParse %t530
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
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i1
  %l10 = alloca i1
  %l11 = alloca i1
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca double
  %l18 = alloca %NumberParseResult
  %l19 = alloca double
  %l20 = alloca %NumberParseResult
  %l21 = alloca double
  %l22 = alloca %NumberParseResult
  %l23 = alloca double
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
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_whitespace(i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t21 = extractvalue { i8**, i64 } %t20, 1
  %t22 = icmp eq i64 %t21, 0
  %t23 = load i8*, i8** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t22, label %then0, label %merge1
then0:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s28 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.28, i32 0, i32 0
  %t29 = add i8* %s28, %enum_name
  %s30 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %t29, %s30
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l1
  %t33 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s34 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.34, i32 0, i32 0
  %t35 = insertvalue %EnumLayoutPayloadParse %t33, i8* %s34, 1
  %t36 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t37 = insertvalue %EnumLayoutPayloadParse %t35, i8* null, 2
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %EnumLayoutPayloadParse %t37, { i8**, i64 }* %t38, 3
  ret %EnumLayoutPayloadParse %t39
merge1:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load { i8**, i64 }, { i8**, i64 }* %t40
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 0, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 0
  %t46 = load i8*, i8** %t45
  store i8* %t46, i8** %l4
  %t47 = load i8*, i8** %l4
  %t48 = call double @index_of(i8* %t47, i8* null)
  store double %t48, double* %l5
  %t50 = load double, double* %l5
  %t51 = sitofp i64 0 to double
  %t52 = fcmp ole double %t50, %t51
  br label %logical_or_entry_49

logical_or_entry_49:
  br i1 %t52, label %logical_or_merge_49, label %logical_or_right_49

logical_or_right_49:
  %t53 = load double, double* %l5
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  %t56 = load i8*, i8** %l4
  %t57 = load i8*, i8** %l4
  %t58 = load double, double* %l5
  %t59 = fptosi double %t58 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %t57, i64 0, i64 %t59)
  store i8* %t60, i8** %l6
  %t61 = load i8*, i8** %l4
  %t62 = load double, double* %l5
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  %t65 = load i8*, i8** %l4
  store double 0.0, double* %l7
  %s66 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.66, i32 0, i32 0
  store i8* %s66, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l12
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l13
  %t69 = sitofp i64 0 to double
  store double %t69, double* %l14
  %t70 = sitofp i64 1 to double
  store double %t70, double* %l15
  %t71 = load i8*, i8** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load i8*, i8** %l4
  %t76 = load double, double* %l5
  %t77 = load i8*, i8** %l6
  %t78 = load double, double* %l7
  %t79 = load i8*, i8** %l8
  %t80 = load i1, i1* %l9
  %t81 = load i1, i1* %l10
  %t82 = load i1, i1* %l11
  %t83 = load double, double* %l12
  %t84 = load double, double* %l13
  %t85 = load double, double* %l14
  %t86 = load double, double* %l15
  br label %loop.header2
loop.header2:
  %t369 = phi i8* [ %t79, %entry ], [ %t360, %loop.latch4 ]
  %t370 = phi i1 [ %t80, %entry ], [ %t361, %loop.latch4 ]
  %t371 = phi double [ %t83, %entry ], [ %t362, %loop.latch4 ]
  %t372 = phi { i8**, i64 }* [ %t72, %entry ], [ %t363, %loop.latch4 ]
  %t373 = phi i1 [ %t81, %entry ], [ %t364, %loop.latch4 ]
  %t374 = phi double [ %t84, %entry ], [ %t365, %loop.latch4 ]
  %t375 = phi i1 [ %t82, %entry ], [ %t366, %loop.latch4 ]
  %t376 = phi double [ %t85, %entry ], [ %t367, %loop.latch4 ]
  %t377 = phi double [ %t86, %entry ], [ %t368, %loop.latch4 ]
  store i8* %t369, i8** %l8
  store i1 %t370, i1* %l9
  store double %t371, double* %l12
  store { i8**, i64 }* %t372, { i8**, i64 }** %l1
  store i1 %t373, i1* %l10
  store double %t374, double* %l13
  store i1 %t375, i1* %l11
  store double %t376, double* %l14
  store double %t377, double* %l15
  br label %loop.body3
loop.body3:
  %t87 = load double, double* %l15
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t89 = load { i8**, i64 }, { i8**, i64 }* %t88
  %t90 = extractvalue { i8**, i64 } %t89, 1
  %t91 = sitofp i64 %t90 to double
  %t92 = fcmp oge double %t87, %t91
  %t93 = load i8*, i8** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t97 = load i8*, i8** %l4
  %t98 = load double, double* %l5
  %t99 = load i8*, i8** %l6
  %t100 = load double, double* %l7
  %t101 = load i8*, i8** %l8
  %t102 = load i1, i1* %l9
  %t103 = load i1, i1* %l10
  %t104 = load i1, i1* %l11
  %t105 = load double, double* %l12
  %t106 = load double, double* %l13
  %t107 = load double, double* %l14
  %t108 = load double, double* %l15
  br i1 %t92, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t110 = load double, double* %l15
  %t111 = load { i8**, i64 }, { i8**, i64 }* %t109
  %t112 = extractvalue { i8**, i64 } %t111, 0
  %t113 = extractvalue { i8**, i64 } %t111, 1
  %t114 = icmp uge i64 %t110, %t113
  ; bounds check: %t114 (if true, out of bounds)
  %t115 = getelementptr i8*, i8** %t112, i64 %t110
  %t116 = load i8*, i8** %t115
  store i8* %t116, i8** %l16
  %t117 = load i8*, i8** %l16
  %s118 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.118, i32 0, i32 0
  %t119 = call i1 @starts_with(i8* %t117, i8* %s118)
  %t120 = load i8*, i8** %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t124 = load i8*, i8** %l4
  %t125 = load double, double* %l5
  %t126 = load i8*, i8** %l6
  %t127 = load double, double* %l7
  %t128 = load i8*, i8** %l8
  %t129 = load i1, i1* %l9
  %t130 = load i1, i1* %l10
  %t131 = load i1, i1* %l11
  %t132 = load double, double* %l12
  %t133 = load double, double* %l13
  %t134 = load double, double* %l14
  %t135 = load double, double* %l15
  %t136 = load i8*, i8** %l16
  br i1 %t119, label %then8, label %else9
then8:
  %t137 = load i8*, i8** %l16
  %t138 = load i8*, i8** %l16
  br label %merge10
else9:
  %t139 = load i8*, i8** %l16
  %s140 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.140, i32 0, i32 0
  %t141 = call i1 @starts_with(i8* %t139, i8* %s140)
  %t142 = load i8*, i8** %l0
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t144 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t146 = load i8*, i8** %l4
  %t147 = load double, double* %l5
  %t148 = load i8*, i8** %l6
  %t149 = load double, double* %l7
  %t150 = load i8*, i8** %l8
  %t151 = load i1, i1* %l9
  %t152 = load i1, i1* %l10
  %t153 = load i1, i1* %l11
  %t154 = load double, double* %l12
  %t155 = load double, double* %l13
  %t156 = load double, double* %l14
  %t157 = load double, double* %l15
  %t158 = load i8*, i8** %l16
  br i1 %t141, label %then11, label %else12
then11:
  %t159 = load i8*, i8** %l16
  %t160 = load i8*, i8** %l16
  store double 0.0, double* %l17
  %t161 = load double, double* %l17
  %t162 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t162, %NumberParseResult* %l18
  %t163 = load %NumberParseResult, %NumberParseResult* %l18
  %t164 = extractvalue %NumberParseResult %t163, 0
  %t165 = load i8*, i8** %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t169 = load i8*, i8** %l4
  %t170 = load double, double* %l5
  %t171 = load i8*, i8** %l6
  %t172 = load double, double* %l7
  %t173 = load i8*, i8** %l8
  %t174 = load i1, i1* %l9
  %t175 = load i1, i1* %l10
  %t176 = load i1, i1* %l11
  %t177 = load double, double* %l12
  %t178 = load double, double* %l13
  %t179 = load double, double* %l14
  %t180 = load double, double* %l15
  %t181 = load i8*, i8** %l16
  %t182 = load double, double* %l17
  %t183 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t164, label %then14, label %else15
then14:
  store i1 1, i1* %l9
  %t184 = load %NumberParseResult, %NumberParseResult* %l18
  %t185 = extractvalue %NumberParseResult %t184, 1
  store double %t185, double* %l12
  br label %merge16
else15:
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s187 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.187, i32 0, i32 0
  %t188 = add i8* %s187, %enum_name
  %s189 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.189, i32 0, i32 0
  %t190 = add i8* %t188, %s189
  %t191 = load i8*, i8** %l4
  %t192 = add i8* %t190, %t191
  %s193 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.193, i32 0, i32 0
  %t194 = add i8* %t192, %s193
  %t195 = load double, double* %l17
  br label %merge16
merge16:
  %t196 = phi i1 [ 1, %then14 ], [ %t174, %else15 ]
  %t197 = phi double [ %t185, %then14 ], [ %t177, %else15 ]
  %t198 = phi { i8**, i64 }* [ %t166, %then14 ], [ null, %else15 ]
  store i1 %t196, i1* %l9
  store double %t197, double* %l12
  store { i8**, i64 }* %t198, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t199 = load i8*, i8** %l16
  %s200 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.200, i32 0, i32 0
  %t201 = call i1 @starts_with(i8* %t199, i8* %s200)
  %t202 = load i8*, i8** %l0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t206 = load i8*, i8** %l4
  %t207 = load double, double* %l5
  %t208 = load i8*, i8** %l6
  %t209 = load double, double* %l7
  %t210 = load i8*, i8** %l8
  %t211 = load i1, i1* %l9
  %t212 = load i1, i1* %l10
  %t213 = load i1, i1* %l11
  %t214 = load double, double* %l12
  %t215 = load double, double* %l13
  %t216 = load double, double* %l14
  %t217 = load double, double* %l15
  %t218 = load i8*, i8** %l16
  br i1 %t201, label %then17, label %else18
then17:
  %t219 = load i8*, i8** %l16
  %t220 = load i8*, i8** %l16
  store double 0.0, double* %l19
  %t221 = load double, double* %l19
  %t222 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t222, %NumberParseResult* %l20
  %t223 = load %NumberParseResult, %NumberParseResult* %l20
  %t224 = extractvalue %NumberParseResult %t223, 0
  %t225 = load i8*, i8** %l0
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t227 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t229 = load i8*, i8** %l4
  %t230 = load double, double* %l5
  %t231 = load i8*, i8** %l6
  %t232 = load double, double* %l7
  %t233 = load i8*, i8** %l8
  %t234 = load i1, i1* %l9
  %t235 = load i1, i1* %l10
  %t236 = load i1, i1* %l11
  %t237 = load double, double* %l12
  %t238 = load double, double* %l13
  %t239 = load double, double* %l14
  %t240 = load double, double* %l15
  %t241 = load i8*, i8** %l16
  %t242 = load double, double* %l19
  %t243 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t224, label %then20, label %else21
then20:
  store i1 1, i1* %l10
  %t244 = load %NumberParseResult, %NumberParseResult* %l20
  %t245 = extractvalue %NumberParseResult %t244, 1
  store double %t245, double* %l13
  br label %merge22
else21:
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.247, i32 0, i32 0
  %t248 = add i8* %s247, %enum_name
  %s249 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.249, i32 0, i32 0
  %t250 = add i8* %t248, %s249
  %t251 = load i8*, i8** %l4
  %t252 = add i8* %t250, %t251
  %s253 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  %t255 = load double, double* %l19
  br label %merge22
merge22:
  %t256 = phi i1 [ 1, %then20 ], [ %t235, %else21 ]
  %t257 = phi double [ %t245, %then20 ], [ %t238, %else21 ]
  %t258 = phi { i8**, i64 }* [ %t226, %then20 ], [ null, %else21 ]
  store i1 %t256, i1* %l10
  store double %t257, double* %l13
  store { i8**, i64 }* %t258, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t259 = load i8*, i8** %l16
  %s260 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.260, i32 0, i32 0
  %t261 = call i1 @starts_with(i8* %t259, i8* %s260)
  %t262 = load i8*, i8** %l0
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t266 = load i8*, i8** %l4
  %t267 = load double, double* %l5
  %t268 = load i8*, i8** %l6
  %t269 = load double, double* %l7
  %t270 = load i8*, i8** %l8
  %t271 = load i1, i1* %l9
  %t272 = load i1, i1* %l10
  %t273 = load i1, i1* %l11
  %t274 = load double, double* %l12
  %t275 = load double, double* %l13
  %t276 = load double, double* %l14
  %t277 = load double, double* %l15
  %t278 = load i8*, i8** %l16
  br i1 %t261, label %then23, label %else24
then23:
  %t279 = load i8*, i8** %l16
  %t280 = load i8*, i8** %l16
  store double 0.0, double* %l21
  %t281 = load double, double* %l21
  %t282 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t282, %NumberParseResult* %l22
  %t283 = load %NumberParseResult, %NumberParseResult* %l22
  %t284 = extractvalue %NumberParseResult %t283, 0
  %t285 = load i8*, i8** %l0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t287 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t289 = load i8*, i8** %l4
  %t290 = load double, double* %l5
  %t291 = load i8*, i8** %l6
  %t292 = load double, double* %l7
  %t293 = load i8*, i8** %l8
  %t294 = load i1, i1* %l9
  %t295 = load i1, i1* %l10
  %t296 = load i1, i1* %l11
  %t297 = load double, double* %l12
  %t298 = load double, double* %l13
  %t299 = load double, double* %l14
  %t300 = load double, double* %l15
  %t301 = load i8*, i8** %l16
  %t302 = load double, double* %l21
  %t303 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t284, label %then26, label %else27
then26:
  store i1 1, i1* %l11
  %t304 = load %NumberParseResult, %NumberParseResult* %l22
  %t305 = extractvalue %NumberParseResult %t304, 1
  store double %t305, double* %l14
  br label %merge28
else27:
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s307 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.307, i32 0, i32 0
  %t308 = add i8* %s307, %enum_name
  %s309 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.309, i32 0, i32 0
  %t310 = add i8* %t308, %s309
  %t311 = load i8*, i8** %l4
  %t312 = add i8* %t310, %t311
  %s313 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.313, i32 0, i32 0
  %t314 = add i8* %t312, %s313
  %t315 = load double, double* %l21
  br label %merge28
merge28:
  %t316 = phi i1 [ 1, %then26 ], [ %t296, %else27 ]
  %t317 = phi double [ %t305, %then26 ], [ %t299, %else27 ]
  %t318 = phi { i8**, i64 }* [ %t286, %then26 ], [ null, %else27 ]
  store i1 %t316, i1* %l11
  store double %t317, double* %l14
  store { i8**, i64 }* %t318, { i8**, i64 }** %l1
  br label %merge25
else24:
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s320 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.320, i32 0, i32 0
  %t321 = add i8* %s320, %enum_name
  %s322 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.322, i32 0, i32 0
  %t323 = add i8* %t321, %s322
  %t324 = load i8*, i8** %l4
  %t325 = add i8* %t323, %t324
  %s326 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.326, i32 0, i32 0
  %t327 = add i8* %t325, %s326
  %t328 = load i8*, i8** %l16
  %t329 = add i8* %t327, %t328
  %t330 = getelementptr i8, i8* %t329, i64 0
  %t331 = load i8, i8* %t330
  %t332 = add i8 %t331, 96
  %t333 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t319, i8* null)
  store { i8**, i64 }* %t333, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t334 = phi i1 [ 1, %then23 ], [ %t273, %else24 ]
  %t335 = phi double [ %t305, %then23 ], [ %t276, %else24 ]
  %t336 = phi { i8**, i64 }* [ null, %then23 ], [ %t333, %else24 ]
  store i1 %t334, i1* %l11
  store double %t335, double* %l14
  store { i8**, i64 }* %t336, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t337 = phi i1 [ 1, %then17 ], [ %t212, %else18 ]
  %t338 = phi double [ %t245, %then17 ], [ %t215, %else18 ]
  %t339 = phi { i8**, i64 }* [ null, %then17 ], [ null, %else18 ]
  %t340 = phi i1 [ %t213, %then17 ], [ 1, %else18 ]
  %t341 = phi double [ %t216, %then17 ], [ %t305, %else18 ]
  store i1 %t337, i1* %l10
  store double %t338, double* %l13
  store { i8**, i64 }* %t339, { i8**, i64 }** %l1
  store i1 %t340, i1* %l11
  store double %t341, double* %l14
  br label %merge13
merge13:
  %t342 = phi i1 [ 1, %then11 ], [ %t151, %else12 ]
  %t343 = phi double [ %t185, %then11 ], [ %t154, %else12 ]
  %t344 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t345 = phi i1 [ %t152, %then11 ], [ 1, %else12 ]
  %t346 = phi double [ %t155, %then11 ], [ %t245, %else12 ]
  %t347 = phi i1 [ %t153, %then11 ], [ 1, %else12 ]
  %t348 = phi double [ %t156, %then11 ], [ %t305, %else12 ]
  store i1 %t342, i1* %l9
  store double %t343, double* %l12
  store { i8**, i64 }* %t344, { i8**, i64 }** %l1
  store i1 %t345, i1* %l10
  store double %t346, double* %l13
  store i1 %t347, i1* %l11
  store double %t348, double* %l14
  br label %merge10
merge10:
  %t349 = phi i8* [ null, %then8 ], [ %t128, %else9 ]
  %t350 = phi i1 [ %t129, %then8 ], [ 1, %else9 ]
  %t351 = phi double [ %t132, %then8 ], [ %t185, %else9 ]
  %t352 = phi { i8**, i64 }* [ %t121, %then8 ], [ null, %else9 ]
  %t353 = phi i1 [ %t130, %then8 ], [ 1, %else9 ]
  %t354 = phi double [ %t133, %then8 ], [ %t245, %else9 ]
  %t355 = phi i1 [ %t131, %then8 ], [ 1, %else9 ]
  %t356 = phi double [ %t134, %then8 ], [ %t305, %else9 ]
  store i8* %t349, i8** %l8
  store i1 %t350, i1* %l9
  store double %t351, double* %l12
  store { i8**, i64 }* %t352, { i8**, i64 }** %l1
  store i1 %t353, i1* %l10
  store double %t354, double* %l13
  store i1 %t355, i1* %l11
  store double %t356, double* %l14
  %t357 = load double, double* %l15
  %t358 = sitofp i64 1 to double
  %t359 = fadd double %t357, %t358
  store double %t359, double* %l15
  br label %loop.latch4
loop.latch4:
  %t360 = load i8*, i8** %l8
  %t361 = load i1, i1* %l9
  %t362 = load double, double* %l12
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t364 = load i1, i1* %l10
  %t365 = load double, double* %l13
  %t366 = load i1, i1* %l11
  %t367 = load double, double* %l14
  %t368 = load double, double* %l15
  br label %loop.header2
afterloop5:
  %t378 = load i8*, i8** %l8
  %t379 = load i1, i1* %l9
  %t380 = xor i1 %t379, 1
  %t381 = load i8*, i8** %l0
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t383 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t385 = load i8*, i8** %l4
  %t386 = load double, double* %l5
  %t387 = load i8*, i8** %l6
  %t388 = load double, double* %l7
  %t389 = load i8*, i8** %l8
  %t390 = load i1, i1* %l9
  %t391 = load i1, i1* %l10
  %t392 = load i1, i1* %l11
  %t393 = load double, double* %l12
  %t394 = load double, double* %l13
  %t395 = load double, double* %l14
  %t396 = load double, double* %l15
  br i1 %t380, label %then29, label %merge30
then29:
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s398 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.398, i32 0, i32 0
  %t399 = add i8* %s398, %enum_name
  %s400 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.400, i32 0, i32 0
  %t401 = add i8* %t399, %s400
  %t402 = load i8*, i8** %l4
  %t403 = add i8* %t401, %t402
  %s404 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.404, i32 0, i32 0
  %t405 = add i8* %t403, %s404
  %t406 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t397, i8* %t405)
  store { i8**, i64 }* %t406, { i8**, i64 }** %l1
  br label %merge30
merge30:
  %t407 = phi { i8**, i64 }* [ %t406, %then29 ], [ %t382, %entry ]
  store { i8**, i64 }* %t407, { i8**, i64 }** %l1
  %t408 = load i1, i1* %l10
  %t409 = xor i1 %t408, 1
  %t410 = load i8*, i8** %l0
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t412 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t414 = load i8*, i8** %l4
  %t415 = load double, double* %l5
  %t416 = load i8*, i8** %l6
  %t417 = load double, double* %l7
  %t418 = load i8*, i8** %l8
  %t419 = load i1, i1* %l9
  %t420 = load i1, i1* %l10
  %t421 = load i1, i1* %l11
  %t422 = load double, double* %l12
  %t423 = load double, double* %l13
  %t424 = load double, double* %l14
  %t425 = load double, double* %l15
  br i1 %t409, label %then31, label %merge32
then31:
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s427 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.427, i32 0, i32 0
  %t428 = add i8* %s427, %enum_name
  %s429 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.429, i32 0, i32 0
  %t430 = add i8* %t428, %s429
  %t431 = load i8*, i8** %l4
  %t432 = add i8* %t430, %t431
  %s433 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.433, i32 0, i32 0
  %t434 = add i8* %t432, %s433
  %t435 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t426, i8* %t434)
  store { i8**, i64 }* %t435, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t436 = phi { i8**, i64 }* [ %t435, %then31 ], [ %t411, %entry ]
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  %t437 = load i1, i1* %l11
  %t438 = xor i1 %t437, 1
  %t439 = load i8*, i8** %l0
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t441 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t443 = load i8*, i8** %l4
  %t444 = load double, double* %l5
  %t445 = load i8*, i8** %l6
  %t446 = load double, double* %l7
  %t447 = load i8*, i8** %l8
  %t448 = load i1, i1* %l9
  %t449 = load i1, i1* %l10
  %t450 = load i1, i1* %l11
  %t451 = load double, double* %l12
  %t452 = load double, double* %l13
  %t453 = load double, double* %l14
  %t454 = load double, double* %l15
  br i1 %t438, label %then33, label %merge34
then33:
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s456 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.456, i32 0, i32 0
  %t457 = add i8* %s456, %enum_name
  %s458 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.458, i32 0, i32 0
  %t459 = add i8* %t457, %s458
  %t460 = load i8*, i8** %l4
  %t461 = add i8* %t459, %t460
  %s462 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.462, i32 0, i32 0
  %t463 = add i8* %t461, %s462
  %t464 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t455, i8* %t463)
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t465 = phi { i8**, i64 }* [ %t464, %then33 ], [ %t440, %entry ]
  store { i8**, i64 }* %t465, { i8**, i64 }** %l1
  %t470 = load i8*, i8** %l8
  store double 0.0, double* %l23
  %t471 = load double, double* %l7
  %t472 = insertvalue %NativeStructLayoutField undef, i8* null, 0
  %t473 = load i8*, i8** %l8
  %t474 = insertvalue %NativeStructLayoutField %t472, i8* %t473, 1
  %t475 = load double, double* %l12
  %t476 = insertvalue %NativeStructLayoutField %t474, double %t475, 2
  %t477 = load double, double* %l13
  %t478 = insertvalue %NativeStructLayoutField %t476, double %t477, 3
  %t479 = load double, double* %l14
  %t480 = insertvalue %NativeStructLayoutField %t478, double %t479, 4
  store %NativeStructLayoutField %t480, %NativeStructLayoutField* %l24
  %t481 = load double, double* %l23
  %t482 = fcmp one double %t481, 0.0
  %t483 = insertvalue %EnumLayoutPayloadParse undef, i1 %t482, 0
  %t484 = load i8*, i8** %l6
  %t485 = insertvalue %EnumLayoutPayloadParse %t483, i8* %t484, 1
  %t486 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t487 = insertvalue %EnumLayoutPayloadParse %t485, i8* null, 2
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t489 = insertvalue %EnumLayoutPayloadParse %t487, { i8**, i64 }* %t488, 3
  ret %EnumLayoutPayloadParse %t489
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
  %t31 = phi i8* [ %t2, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t3, %entry ], [ %t30, %loop.latch2 ]
  store i8* %t31, i8** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = icmp eq i8 %t10, 32
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %t12 = load i8, i8* %l2
  %t13 = icmp eq i8 %t12, 58
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t14 = phi i1 [ true, %logical_or_entry_9 ], [ %t13, %logical_or_right_end_9 ]
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t14, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 61
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t17 = phi i1 [ true, %logical_or_entry_8 ], [ %t16, %logical_or_right_end_8 ]
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = load i8, i8* %l2
  br i1 %t17, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t21 = load i8*, i8** %l0
  %t22 = load i8, i8* %l2
  %t23 = getelementptr i8, i8* %t21, i64 0
  %t24 = load i8, i8* %t23
  %t25 = add i8 %t24, %t22
  store i8* null, i8** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load i8*, i8** %l0
  %t34 = call i8* @trim_text(i8* %t33)
  store i8* %t34, i8** %l0
  %s35 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.35, i32 0, i32 0
  store i8* %s35, i8** %l3
  store i8* null, i8** %l4
  %t36 = load double, double* %l1
  store i8* null, i8** %l5
  %t37 = load i8*, i8** %l5
  %t38 = load i8*, i8** %l0
  %t39 = insertvalue %BindingComponents undef, i8* %t38, 0
  %t40 = load i8*, i8** %l3
  %t41 = insertvalue %BindingComponents %t39, i8* %t40, 1
  %t42 = load i8*, i8** %l4
  %t43 = insertvalue %BindingComponents %t41, i8* %t42, 2
  ret %BindingComponents %t43
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
  br label %merge5
merge5:
  %t39 = phi i8* [ null, %then4 ], [ %t32, %entry ]
  store i8* %t39, i8** %l2
  %t40 = load i8*, i8** %l2
  %t41 = call i8* @strip_generics(i8* %t40)
  ret i8* %t41
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
  %t2 = load i8*, i8** %l0
  %t3 = call i1 @starts_with(i8* %t2, i8* null)
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
  store double 0.0, double* %l1
  %t9 = load double, double* %l1
  %t10 = sitofp i64 0 to double
  %t11 = fcmp oge double %t9, %t10
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then4, label %merge5
then4:
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = call i8* @sailfin_runtime_substring(i8* %t14, i64 0, i64 %t16)
  %t18 = call i8* @trim_text(i8* %t17)
  store i8* %t18, i8** %l2
  %t19 = load i8*, i8** %l2
  %t20 = load i8*, i8** %l2
  %s21 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.21, i32 0, i32 0
  %t22 = call i1 @starts_with(i8* %t20, i8* %s21)
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then6, label %merge7
then6:
  %t26 = load i8*, i8** %l2
  %s27 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  %t28 = call i8* @strip_prefix(i8* %t26, i8* %s27)
  %t29 = call i8* @trim_text(i8* %t28)
  store i8* %t29, i8** %l2
  br label %merge7
merge7:
  %t30 = phi i8* [ %t29, %then6 ], [ %t25, %then4 ]
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = call double @index_of(i8* %t32, i8* null)
  %t34 = sitofp i64 0 to double
  %t35 = fcmp oge double %t33, %t34
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l2
  br i1 %t35, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t39 = load i8*, i8** %l2
  %t40 = call double @index_of(i8* %t39, i8* null)
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oge double %t40, %t41
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l2
  br i1 %t42, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  ret i1 1
merge5:
  %t46 = load i8*, i8** %l0
  %t47 = call double @index_of(i8* %t46, i8* null)
  store double %t47, double* %l3
  %t48 = load double, double* %l3
  %t49 = sitofp i64 0 to double
  %t50 = fcmp oge double %t48, %t49
  %t51 = load i8*, i8** %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l3
  br i1 %t50, label %then12, label %merge13
then12:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l3
  %t56 = fptosi double %t55 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t54, i64 0, i64 %t56)
  %t58 = call i8* @trim_text(i8* %t57)
  store i8* %t58, i8** %l4
  %t59 = load i8*, i8** %l4
  %t60 = load i8*, i8** %l4
  %s61 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* %t60, i8* %s61)
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load double, double* %l3
  %t66 = load i8*, i8** %l4
  br i1 %t62, label %then14, label %merge15
then14:
  %t67 = load i8*, i8** %l4
  %s68 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.68, i32 0, i32 0
  %t69 = call i8* @strip_prefix(i8* %t67, i8* %s68)
  %t70 = call i8* @trim_text(i8* %t69)
  store i8* %t70, i8** %l4
  br label %merge15
merge15:
  %t71 = phi i8* [ %t70, %then14 ], [ %t66, %then12 ]
  store i8* %t71, i8** %l4
  %t72 = load i8*, i8** %l4
  %t73 = load i8*, i8** %l4
  %t74 = call double @index_of(i8* %t73, i8* null)
  %t75 = sitofp i64 0 to double
  %t76 = fcmp oge double %t74, %t75
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l3
  %t80 = load i8*, i8** %l4
  br i1 %t76, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  %t81 = load i8*, i8** %l4
  %t82 = call double @index_of(i8* %t81, i8* null)
  %t83 = sitofp i64 0 to double
  %t84 = fcmp oge double %t82, %t83
  %t85 = load i8*, i8** %l0
  %t86 = load double, double* %l1
  %t87 = load double, double* %l3
  %t88 = load i8*, i8** %l4
  br i1 %t84, label %then18, label %merge19
then18:
  ret i1 0
merge19:
  ret i1 1
merge13:
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
  %t142 = phi i8* [ %t13, %entry ], [ %t138, %loop.latch2 ]
  %t143 = phi i8* [ %t10, %entry ], [ %t139, %loop.latch2 ]
  %t144 = phi double [ %t11, %entry ], [ %t140, %loop.latch2 ]
  %t145 = phi double [ %t12, %entry ], [ %t141, %loop.latch2 ]
  store i8* %t142, i8** %l4
  store i8* %t143, i8** %l1
  store double %t144, double* %l2
  store double %t145, double* %l3
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = getelementptr i8, i8* %body, i64 %t15
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l5
  %t18 = load i8*, i8** %l4
  %t20 = load i8, i8* %l5
  %t21 = icmp eq i8 %t20, 34
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t21, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t22 = load i8, i8* %l5
  %t23 = icmp eq i8 %t22, 39
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t24 = phi i1 [ true, %logical_or_entry_19 ], [ %t23, %logical_or_right_end_19 ]
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load i8*, i8** %l1
  %t27 = load double, double* %l2
  %t28 = load double, double* %l3
  %t29 = load i8*, i8** %l4
  %t30 = load i8, i8* %l5
  br i1 %t24, label %then4, label %merge5
then4:
  %t31 = load i8, i8* %l5
  store i8* null, i8** %l4
  %t32 = load i8*, i8** %l1
  %t33 = load i8, i8* %l5
  %t34 = getelementptr i8, i8* %t32, i64 0
  %t35 = load i8, i8* %t34
  %t36 = add i8 %t35, %t33
  store i8* null, i8** %l1
  %t37 = load double, double* %l2
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l2
  br label %loop.latch2
merge5:
  %t42 = load i8, i8* %l5
  %t43 = icmp eq i8 %t42, 40
  br label %logical_or_entry_41

logical_or_entry_41:
  br i1 %t43, label %logical_or_merge_41, label %logical_or_right_41

logical_or_right_41:
  %t44 = load i8, i8* %l5
  %t45 = icmp eq i8 %t44, 91
  br label %logical_or_right_end_41

logical_or_right_end_41:
  br label %logical_or_merge_41

logical_or_merge_41:
  %t46 = phi i1 [ true, %logical_or_entry_41 ], [ %t45, %logical_or_right_end_41 ]
  br label %logical_or_entry_40

logical_or_entry_40:
  br i1 %t46, label %logical_or_merge_40, label %logical_or_right_40

logical_or_right_40:
  %t47 = load i8, i8* %l5
  %t48 = icmp eq i8 %t47, 123
  br label %logical_or_right_end_40

logical_or_right_end_40:
  br label %logical_or_merge_40

logical_or_merge_40:
  %t49 = phi i1 [ true, %logical_or_entry_40 ], [ %t48, %logical_or_right_end_40 ]
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load i8*, i8** %l4
  %t55 = load i8, i8* %l5
  br i1 %t49, label %then6, label %merge7
then6:
  %t56 = load double, double* %l3
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l3
  %t59 = load i8*, i8** %l1
  %t60 = load i8, i8* %l5
  %t61 = getelementptr i8, i8* %t59, i64 0
  %t62 = load i8, i8* %t61
  %t63 = add i8 %t62, %t60
  store i8* null, i8** %l1
  %t64 = load double, double* %l2
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l2
  br label %loop.latch2
merge7:
  %t69 = load i8, i8* %l5
  %t70 = icmp eq i8 %t69, 41
  br label %logical_or_entry_68

logical_or_entry_68:
  br i1 %t70, label %logical_or_merge_68, label %logical_or_right_68

logical_or_right_68:
  %t71 = load i8, i8* %l5
  %t72 = icmp eq i8 %t71, 93
  br label %logical_or_right_end_68

logical_or_right_end_68:
  br label %logical_or_merge_68

logical_or_merge_68:
  %t73 = phi i1 [ true, %logical_or_entry_68 ], [ %t72, %logical_or_right_end_68 ]
  br label %logical_or_entry_67

logical_or_entry_67:
  br i1 %t73, label %logical_or_merge_67, label %logical_or_right_67

logical_or_right_67:
  %t74 = load i8, i8* %l5
  %t75 = icmp eq i8 %t74, 125
  br label %logical_or_right_end_67

logical_or_right_end_67:
  br label %logical_or_merge_67

logical_or_merge_67:
  %t76 = phi i1 [ true, %logical_or_entry_67 ], [ %t75, %logical_or_right_end_67 ]
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load i8*, i8** %l1
  %t79 = load double, double* %l2
  %t80 = load double, double* %l3
  %t81 = load i8*, i8** %l4
  %t82 = load i8, i8* %l5
  br i1 %t76, label %then8, label %merge9
then8:
  %t83 = load double, double* %l3
  %t84 = sitofp i64 0 to double
  %t85 = fcmp ogt double %t83, %t84
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load i8*, i8** %l4
  %t91 = load i8, i8* %l5
  br i1 %t85, label %then10, label %merge11
then10:
  %t92 = load double, double* %l3
  %t93 = sitofp i64 1 to double
  %t94 = fsub double %t92, %t93
  store double %t94, double* %l3
  br label %merge11
merge11:
  %t95 = phi double [ %t94, %then10 ], [ %t89, %then8 ]
  store double %t95, double* %l3
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
merge9:
  %t104 = load i8, i8* %l5
  %t105 = icmp eq i8 %t104, 44
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load i8*, i8** %l4
  %t111 = load i8, i8* %l5
  br i1 %t105, label %then12, label %merge13
then12:
  %t112 = load double, double* %l3
  %t113 = sitofp i64 0 to double
  %t114 = fcmp oeq double %t112, %t113
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l2
  %t118 = load double, double* %l3
  %t119 = load i8*, i8** %l4
  %t120 = load i8, i8* %l5
  br i1 %t114, label %then14, label %merge15
then14:
  %t121 = load i8*, i8** %l1
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l6
  %t123 = load i8*, i8** %l6
  %s124 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.124, i32 0, i32 0
  store i8* %s124, i8** %l1
  %t125 = load double, double* %l2
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l2
  br label %loop.latch2
merge15:
  br label %merge13
merge13:
  %t128 = phi i8* [ %s124, %then12 ], [ %t107, %loop.body1 ]
  %t129 = phi double [ %t127, %then12 ], [ %t108, %loop.body1 ]
  store i8* %t128, i8** %l1
  store double %t129, double* %l2
  %t130 = load i8*, i8** %l1
  %t131 = load i8, i8* %l5
  %t132 = getelementptr i8, i8* %t130, i64 0
  %t133 = load i8, i8* %t132
  %t134 = add i8 %t133, %t131
  store i8* null, i8** %l1
  %t135 = load double, double* %l2
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l2
  br label %loop.latch2
loop.latch2:
  %t138 = load i8*, i8** %l4
  %t139 = load i8*, i8** %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t146 = load i8*, i8** %l1
  %t147 = call i8* @trim_text(i8* %t146)
  store i8* %t147, i8** %l7
  %t148 = load i8*, i8** %l7
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t149
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
  %t5 = sitofp i64 -1 to double
  store double %t5, double* %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t70 = phi { i8**, i64 }* [ %t7, %entry ], [ %t67, %loop.latch2 ]
  %t71 = phi double [ %t8, %entry ], [ %t68, %loop.latch2 ]
  %t72 = phi double [ %t9, %entry ], [ %t69, %loop.latch2 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  store double %t71, double* %l1
  store double %t72, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t17 = load i8, i8* %l3
  %t18 = icmp eq i8 %t17, 32
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t18, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t19 = load i8, i8* %l3
  %t20 = icmp eq i8 %t19, 9
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t21 = phi i1 [ true, %logical_or_entry_16 ], [ %t20, %logical_or_right_end_16 ]
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t21, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t22 = load i8, i8* %l3
  %t23 = icmp eq i8 %t22, 10
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t24 = phi i1 [ true, %logical_or_entry_15 ], [ %t23, %logical_or_right_end_15 ]
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t24, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t25 = load i8, i8* %l3
  %t26 = icmp eq i8 %t25, 13
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t27 = phi i1 [ true, %logical_or_entry_14 ], [ %t26, %logical_or_right_end_14 ]
  store i1 %t27, i1* %l4
  %t28 = load i1, i1* %l4
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load i8, i8* %l3
  %t33 = load i1, i1* %l4
  br i1 %t28, label %then4, label %else5
then4:
  %t34 = load double, double* %l1
  %t35 = sitofp i64 0 to double
  %t36 = fcmp oge double %t34, %t35
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l2
  %t40 = load i8, i8* %l3
  %t41 = load i1, i1* %l4
  br i1 %t36, label %then7, label %merge8
then7:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  %t45 = fptosi double %t43 to i64
  %t46 = fptosi double %t44 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t45, i64 %t46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = sitofp i64 -1 to double
  store double %t49, double* %l1
  br label %merge8
merge8:
  %t50 = phi { i8**, i64 }* [ %t48, %then7 ], [ %t37, %then4 ]
  %t51 = phi double [ %t49, %then7 ], [ %t38, %then4 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store double %t51, double* %l1
  br label %merge6
else5:
  %t52 = load double, double* %l1
  %t53 = sitofp i64 0 to double
  %t54 = fcmp olt double %t52, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load i8, i8* %l3
  %t59 = load i1, i1* %l4
  br i1 %t54, label %then9, label %merge10
then9:
  %t60 = load double, double* %l2
  store double %t60, double* %l1
  br label %merge10
merge10:
  %t61 = phi double [ %t60, %then9 ], [ %t56, %else5 ]
  store double %t61, double* %l1
  br label %merge6
merge6:
  %t62 = phi { i8**, i64 }* [ %t48, %then4 ], [ %t29, %else5 ]
  %t63 = phi double [ %t49, %then4 ], [ %t60, %else5 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  store double %t63, double* %l1
  %t64 = load double, double* %l2
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l2
  br label %loop.latch2
loop.latch2:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t73 = load double, double* %l1
  %t74 = sitofp i64 0 to double
  %t75 = fcmp oge double %t73, %t74
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l1
  %t78 = load double, double* %l2
  br i1 %t75, label %then11, label %merge12
then11:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l1
  br label %merge12
merge12:
  %t81 = phi { i8**, i64 }* [ null, %then11 ], [ %t76, %entry ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t82
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
  %t2 = call double @char_code(i8 48)
  store double %t2, double* %l1
  %t3 = call double @char_code(i8 57)
  store double %t3, double* %l2
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l3
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l4
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  %t9 = load double, double* %l3
  %t10 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t50 = phi double [ %t10, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t9, %entry ], [ %t49, %loop.latch2 ]
  store double %t50, double* %l4
  store double %t51, double* %l3
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l3
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l3
  %t15 = getelementptr i8, i8* %t13, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l5
  %t17 = load i8, i8* %l5
  %t18 = call double @char_code(i8 %t17)
  store double %t18, double* %l6
  %t20 = load double, double* %l6
  %t21 = load double, double* %l1
  %t22 = fcmp olt double %t20, %t21
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load double, double* %l6
  %t24 = load double, double* %l2
  %t25 = fcmp ogt double %t23, %t24
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  %t32 = load i8, i8* %l5
  %t33 = load double, double* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  %t34 = insertvalue %NumberParseResult undef, i1 0, 0
  %t35 = sitofp i64 0 to double
  %t36 = insertvalue %NumberParseResult %t34, double %t35, 1
  ret %NumberParseResult %t36
merge5:
  %t37 = load double, double* %l6
  %t38 = load double, double* %l1
  %t39 = fsub double %t37, %t38
  store double %t39, double* %l7
  %t40 = load double, double* %l4
  %t41 = sitofp i64 10 to double
  %t42 = fmul double %t40, %t41
  %t43 = load double, double* %l7
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l4
  %t45 = load double, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l3
  br label %loop.latch2
loop.latch2:
  %t48 = load double, double* %l4
  %t49 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t52 = insertvalue %NumberParseResult undef, i1 1, 0
  %t53 = load double, double* %l4
  %t54 = insertvalue %NumberParseResult %t52, double %t53, 1
  ret %NumberParseResult %t54
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
  %t37 = phi { i8**, i64 }* [ %t7, %entry ], [ %t34, %loop.latch2 ]
  %t38 = phi i8* [ %t8, %entry ], [ %t35, %loop.latch2 ]
  %t39 = phi double [ %t9, %entry ], [ %t36, %loop.latch2 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store i8* %t38, i8** %l1
  store double %t39, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %t15 = icmp eq i8 %t14, 10
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load i8, i8* %l3
  br i1 %t15, label %then4, label %else5
then4:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l1
  br label %merge6
else5:
  %t24 = load i8*, i8** %l1
  %t25 = load i8, i8* %l3
  %t26 = getelementptr i8, i8* %t24, i64 0
  %t27 = load i8, i8* %t26
  %t28 = add i8 %t27, %t25
  store i8* null, i8** %l1
  br label %merge6
merge6:
  %t29 = phi { i8**, i64 }* [ %t22, %then4 ], [ %t16, %else5 ]
  %t30 = phi i8* [ %s23, %then4 ], [ null, %else5 ]
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  store i8* %t30, i8** %l1
  %t31 = load double, double* %l2
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l2
  br label %loop.latch2
loop.latch2:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t43
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
  %t38 = phi { i8**, i64 }* [ %t7, %entry ], [ %t35, %loop.latch2 ]
  %t39 = phi i8* [ %t8, %entry ], [ %t36, %loop.latch2 ]
  %t40 = phi double [ %t9, %entry ], [ %t37, %loop.latch2 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store i8* %t39, i8** %l1
  store double %t40, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %t15 = icmp eq i8 %t14, 44
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load i8, i8* %l3
  br i1 %t15, label %then4, label %else5
then4:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = call i8* @trim_text(i8* %t21)
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.24, i32 0, i32 0
  store i8* %s24, i8** %l1
  br label %merge6
else5:
  %t25 = load i8*, i8** %l1
  %t26 = load i8, i8* %l3
  %t27 = getelementptr i8, i8* %t25, i64 0
  %t28 = load i8, i8* %t27
  %t29 = add i8 %t28, %t26
  store i8* null, i8** %l1
  br label %merge6
merge6:
  %t30 = phi { i8**, i64 }* [ %t23, %then4 ], [ %t16, %else5 ]
  %t31 = phi i8* [ %s24, %then4 ], [ null, %else5 ]
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  store i8* %t31, i8** %l1
  %t32 = load double, double* %l2
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t41 = load i8*, i8** %l1
  %t42 = alloca [0 x i8*]
  %t43 = getelementptr [0 x i8*], [0 x i8*]* %t42, i32 0, i32 0
  %t44 = alloca { i8**, i64 }
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* %t44, i32 0, i32 0
  store i8** %t43, i8*** %t45
  %t46 = getelementptr { i8**, i64 }, { i8**, i64 }* %t44, i32 0, i32 1
  store i64 0, i64* %t46
  store { i8**, i64 }* %t44, { i8**, i64 }** %l4
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header7
loop.header7:
  %t75 = phi double [ %t50, %entry ], [ %t74, %loop.latch9 ]
  store double %t75, double* %l2
  br label %loop.body8
loop.body8:
  %t52 = load double, double* %l2
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l2
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t57, label %then11, label %merge12
then11:
  br label %afterloop10
merge12:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l2
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t62
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  %t68 = getelementptr i8*, i8** %t65, i64 %t63
  %t69 = load i8*, i8** %t68
  store i8* %t69, i8** %l5
  %t70 = load i8*, i8** %l5
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l2
  br label %loop.latch9
loop.latch9:
  %t74 = load double, double* %l2
  br label %loop.header7
afterloop10:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t76
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
  %t30 = phi i8* [ %t3, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t5, %entry ], [ %t29, %loop.latch2 ]
  store i8* %t30, i8** %l0
  store double %t31, double* %l2
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = load double, double* %l2
  %t8 = getelementptr i8, i8* %name, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l3
  %t10 = load i8, i8* %l3
  %t11 = load i8, i8* %l3
  %t12 = load double, double* %l1
  %t13 = sitofp i64 0 to double
  %t14 = fcmp oeq double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load i8, i8* %l3
  br i1 %t14, label %then4, label %merge5
then4:
  %t19 = load i8*, i8** %l0
  %t20 = load i8, i8* %l3
  %t21 = getelementptr i8, i8* %t19, i64 0
  %t22 = load i8, i8* %t21
  %t23 = add i8 %t22, %t20
  store i8* null, i8** %l0
  br label %merge5
merge5:
  %t24 = phi i8* [ null, %then4 ], [ %t15, %loop.body1 ]
  store i8* %t24, i8** %l0
  %t25 = load double, double* %l2
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l2
  br label %loop.latch2
loop.latch2:
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t32 = load i8*, i8** %l0
  %t33 = call i8* @trim_text(i8* %t32)
  ret i8* %t33
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
  %t45 = fptosi double %t43 to i64
  %t46 = fptosi double %t44 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t45, i64 %t46)
  ret i8* %t47
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
  %l16 = alloca double
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
  %l32 = alloca double
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
  %t491 = phi double [ %t21, %entry ], [ %t487, %loop.latch2 ]
  %t492 = phi { i8**, i64 }* [ %t18, %entry ], [ %t488, %loop.latch2 ]
  %t493 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t489, %loop.latch2 ]
  %t494 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t490, %loop.latch2 ]
  store double %t491, double* %l4
  store { i8**, i64 }* %t492, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t493, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t494, { %NativeEnum*, i64 }** %l3
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
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  store i8* %t40, i8** %l5
  %t41 = load i8*, i8** %l5
  %t42 = call i8* @trim_text(i8* %t41)
  store i8* %t42, i8** %l6
  %t43 = load i8*, i8** %l6
  %t44 = load i8*, i8** %l6
  %t45 = call i1 @starts_with(i8* %t44, i8* null)
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t49 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t50 = load double, double* %l4
  %t51 = load i8*, i8** %l5
  %t52 = load i8*, i8** %l6
  br i1 %t45, label %then6, label %merge7
then6:
  %t53 = load double, double* %l4
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l4
  br label %loop.latch2
merge7:
  %t56 = load i8*, i8** %l6
  %s57 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i1 @starts_with(i8* %t56, i8* %s57)
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
  %s70 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.70, i32 0, i32 0
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
  %t79 = load i8*, i8** %l6
  %s80 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.80, i32 0, i32 0
  %t81 = call i8* @strip_prefix(i8* %t79, i8* %s80)
  store i8* %t81, i8** %l7
  %t82 = load i8*, i8** %l7
  %s83 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.83, i32 0, i32 0
  %t84 = call i8* @strip_prefix(i8* %t82, i8* %s83)
  store i8* %t84, i8** %l8
  %t85 = load i8*, i8** %l8
  %t86 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t85)
  store %StructLayoutHeaderParse %t86, %StructLayoutHeaderParse* %l9
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t89 = extractvalue %StructLayoutHeaderParse %t88, 4
  %t90 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t87, { i8**, i64 }* %t89)
  store { i8**, i64 }* %t90, { i8**, i64 }** %l1
  %t91 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t92 = extractvalue %StructLayoutHeaderParse %t91, 0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t96 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t97 = load double, double* %l4
  %t98 = load i8*, i8** %l5
  %t99 = load i8*, i8** %l6
  %t100 = load i8*, i8** %l7
  %t101 = load i8*, i8** %l8
  %t102 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t92, label %then12, label %merge13
then12:
  %t103 = alloca [0 x %NativeStructLayoutField]
  %t104 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t103, i32 0, i32 0
  %t105 = alloca { %NativeStructLayoutField*, i64 }
  %t106 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t105, i32 0, i32 0
  store %NativeStructLayoutField* %t104, %NativeStructLayoutField** %t106
  %t107 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { %NativeStructLayoutField*, i64 }* %t105, { %NativeStructLayoutField*, i64 }** %l10
  %t108 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t109 = extractvalue %StructLayoutHeaderParse %t108, 1
  store i8* %t109, i8** %l11
  %t110 = load double, double* %l4
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l4
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t116 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t117 = load double, double* %l4
  %t118 = load i8*, i8** %l5
  %t119 = load i8*, i8** %l6
  %t120 = load i8*, i8** %l7
  %t121 = load i8*, i8** %l8
  %t122 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t123 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t124 = load i8*, i8** %l11
  br label %loop.header14
loop.header14:
  %t213 = phi i8* [ %t120, %then12 ], [ %t209, %loop.latch16 ]
  %t214 = phi { i8**, i64 }* [ %t114, %then12 ], [ %t210, %loop.latch16 ]
  %t215 = phi { %NativeStructLayoutField*, i64 }* [ %t123, %then12 ], [ %t211, %loop.latch16 ]
  %t216 = phi double [ %t117, %then12 ], [ %t212, %loop.latch16 ]
  store i8* %t213, i8** %l7
  store { i8**, i64 }* %t214, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t215, { %NativeStructLayoutField*, i64 }** %l10
  store double %t216, double* %l4
  br label %loop.body15
loop.body15:
  %t125 = load double, double* %l4
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load { i8**, i64 }, { i8**, i64 }* %t126
  %t128 = extractvalue { i8**, i64 } %t127, 1
  %t129 = sitofp i64 %t128 to double
  %t130 = fcmp oge double %t125, %t129
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t134 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t135 = load double, double* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  %t138 = load i8*, i8** %l7
  %t139 = load i8*, i8** %l8
  %t140 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t141 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t142 = load i8*, i8** %l11
  br i1 %t130, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load double, double* %l4
  %t145 = load { i8**, i64 }, { i8**, i64 }* %t143
  %t146 = extractvalue { i8**, i64 } %t145, 0
  %t147 = extractvalue { i8**, i64 } %t145, 1
  %t148 = icmp uge i64 %t144, %t147
  ; bounds check: %t148 (if true, out of bounds)
  %t149 = getelementptr i8*, i8** %t146, i64 %t144
  %t150 = load i8*, i8** %t149
  %t151 = call i8* @trim_text(i8* %t150)
  store i8* %t151, i8** %l12
  %t152 = load i8*, i8** %l12
  %t153 = load i8*, i8** %l12
  %s154 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.154, i32 0, i32 0
  %t155 = call i1 @starts_with(i8* %t153, i8* %s154)
  %t156 = xor i1 %t155, 1
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t160 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t161 = load double, double* %l4
  %t162 = load i8*, i8** %l5
  %t163 = load i8*, i8** %l6
  %t164 = load i8*, i8** %l7
  %t165 = load i8*, i8** %l8
  %t166 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t167 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t168 = load i8*, i8** %l11
  %t169 = load i8*, i8** %l12
  br i1 %t156, label %then20, label %merge21
then20:
  br label %afterloop17
merge21:
  %t170 = load i8*, i8** %l12
  %s171 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.171, i32 0, i32 0
  %t172 = call i8* @strip_prefix(i8* %t170, i8* %s171)
  store i8* %t172, i8** %l13
  %t173 = load i8*, i8** %l7
  %s174 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.174, i32 0, i32 0
  %t175 = call i8* @strip_prefix(i8* %t173, i8* %s174)
  store i8* %t175, i8** %l14
  %t176 = load i8*, i8** %l14
  %t177 = load i8*, i8** %l11
  %t178 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t176, i8* %t177)
  store %StructLayoutFieldParse %t178, %StructLayoutFieldParse* %l15
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t180 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t181 = extractvalue %StructLayoutFieldParse %t180, 2
  %t182 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t179, { i8**, i64 }* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l1
  %t183 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t184 = extractvalue %StructLayoutFieldParse %t183, 0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t188 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t189 = load double, double* %l4
  %t190 = load i8*, i8** %l5
  %t191 = load i8*, i8** %l6
  %t192 = load i8*, i8** %l7
  %t193 = load i8*, i8** %l8
  %t194 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t195 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t196 = load i8*, i8** %l11
  %t197 = load i8*, i8** %l12
  %t198 = load i8*, i8** %l13
  %t199 = load i8*, i8** %l14
  %t200 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t184, label %then22, label %merge23
then22:
  %t201 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t202 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t203 = extractvalue %StructLayoutFieldParse %t202, 1
  %t204 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t201, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t204, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge23
merge23:
  %t205 = phi { %NativeStructLayoutField*, i64 }* [ %t204, %then22 ], [ %t195, %loop.body15 ]
  store { %NativeStructLayoutField*, i64 }* %t205, { %NativeStructLayoutField*, i64 }** %l10
  %t206 = load double, double* %l4
  %t207 = sitofp i64 1 to double
  %t208 = fadd double %t206, %t207
  store double %t208, double* %l4
  br label %loop.latch16
loop.latch16:
  %t209 = load i8*, i8** %l7
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t211 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t212 = load double, double* %l4
  br label %loop.header14
afterloop17:
  store double 0.0, double* %l16
  %t217 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t218 = load double, double* %l16
  %t219 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t217, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t219, { %NativeStruct*, i64 }** %l2
  br label %merge13
merge13:
  %t220 = phi double [ %t112, %then12 ], [ %t97, %then10 ]
  %t221 = phi i8* [ %t172, %then12 ], [ %t100, %then10 ]
  %t222 = phi { i8**, i64 }* [ %t182, %then12 ], [ %t94, %then10 ]
  %t223 = phi double [ %t208, %then12 ], [ %t97, %then10 ]
  %t224 = phi { %NativeStruct*, i64 }* [ %t219, %then12 ], [ %t95, %then10 ]
  store double %t220, double* %l4
  store i8* %t221, i8** %l7
  store { i8**, i64 }* %t222, { i8**, i64 }** %l1
  store double %t223, double* %l4
  store { %NativeStruct*, i64 }* %t224, { %NativeStruct*, i64 }** %l2
  %t225 = load double, double* %l4
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  store double %t227, double* %l4
  br label %loop.latch2
merge11:
  %t228 = load i8*, i8** %l6
  %s229 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.229, i32 0, i32 0
  %t230 = call i1 @starts_with(i8* %t228, i8* %s229)
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t233 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t234 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t235 = load double, double* %l4
  %t236 = load i8*, i8** %l5
  %t237 = load i8*, i8** %l6
  br i1 %t230, label %then24, label %merge25
then24:
  %t238 = load i8*, i8** %l6
  %s239 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.239, i32 0, i32 0
  %t240 = call i8* @strip_prefix(i8* %t238, i8* %s239)
  store i8* %t240, i8** %l17
  %t241 = load i8*, i8** %l17
  %s242 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.242, i32 0, i32 0
  %t243 = call i8* @strip_prefix(i8* %t241, i8* %s242)
  store i8* %t243, i8** %l18
  %t244 = load i8*, i8** %l18
  %t245 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t244)
  store %EnumLayoutHeaderParse %t245, %EnumLayoutHeaderParse* %l19
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t248 = extractvalue %EnumLayoutHeaderParse %t247, 7
  %t249 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t246, { i8**, i64 }* %t248)
  store { i8**, i64 }* %t249, { i8**, i64 }** %l1
  %t250 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t251 = extractvalue %EnumLayoutHeaderParse %t250, 0
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t254 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t255 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t256 = load double, double* %l4
  %t257 = load i8*, i8** %l5
  %t258 = load i8*, i8** %l6
  %t259 = load i8*, i8** %l17
  %t260 = load i8*, i8** %l18
  %t261 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t251, label %then26, label %else27
then26:
  %t262 = alloca [0 x %NativeEnumVariantLayout]
  %t263 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t262, i32 0, i32 0
  %t264 = alloca { %NativeEnumVariantLayout*, i64 }
  %t265 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t264, i32 0, i32 0
  store %NativeEnumVariantLayout* %t263, %NativeEnumVariantLayout** %t265
  %t266 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t264, i32 0, i32 1
  store i64 0, i64* %t266
  store { %NativeEnumVariantLayout*, i64 }* %t264, { %NativeEnumVariantLayout*, i64 }** %l20
  %t267 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t268 = extractvalue %EnumLayoutHeaderParse %t267, 1
  store i8* %t268, i8** %l21
  %t269 = load double, double* %l4
  %t270 = sitofp i64 1 to double
  %t271 = fadd double %t269, %t270
  store double %t271, double* %l4
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t275 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t276 = load double, double* %l4
  %t277 = load i8*, i8** %l5
  %t278 = load i8*, i8** %l6
  %t279 = load i8*, i8** %l17
  %t280 = load i8*, i8** %l18
  %t281 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t282 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t283 = load i8*, i8** %l21
  br label %loop.header29
loop.header29:
  %t470 = phi i8* [ %t279, %then26 ], [ %t466, %loop.latch31 ]
  %t471 = phi { i8**, i64 }* [ %t273, %then26 ], [ %t467, %loop.latch31 ]
  %t472 = phi { %NativeEnumVariantLayout*, i64 }* [ %t282, %then26 ], [ %t468, %loop.latch31 ]
  %t473 = phi double [ %t276, %then26 ], [ %t469, %loop.latch31 ]
  store i8* %t470, i8** %l17
  store { i8**, i64 }* %t471, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t472, { %NativeEnumVariantLayout*, i64 }** %l20
  store double %t473, double* %l4
  br label %loop.body30
loop.body30:
  %t284 = load double, double* %l4
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t286 = load { i8**, i64 }, { i8**, i64 }* %t285
  %t287 = extractvalue { i8**, i64 } %t286, 1
  %t288 = sitofp i64 %t287 to double
  %t289 = fcmp oge double %t284, %t288
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t292 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t293 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t294 = load double, double* %l4
  %t295 = load i8*, i8** %l5
  %t296 = load i8*, i8** %l6
  %t297 = load i8*, i8** %l17
  %t298 = load i8*, i8** %l18
  %t299 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t300 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t301 = load i8*, i8** %l21
  br i1 %t289, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t303 = load double, double* %l4
  %t304 = load { i8**, i64 }, { i8**, i64 }* %t302
  %t305 = extractvalue { i8**, i64 } %t304, 0
  %t306 = extractvalue { i8**, i64 } %t304, 1
  %t307 = icmp uge i64 %t303, %t306
  ; bounds check: %t307 (if true, out of bounds)
  %t308 = getelementptr i8*, i8** %t305, i64 %t303
  %t309 = load i8*, i8** %t308
  %t310 = call i8* @trim_text(i8* %t309)
  store i8* %t310, i8** %l22
  %t311 = load i8*, i8** %l22
  %t313 = load i8*, i8** %l22
  %s314 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.314, i32 0, i32 0
  %t315 = call i1 @starts_with(i8* %t313, i8* %s314)
  br label %logical_and_entry_312

logical_and_entry_312:
  br i1 %t315, label %logical_and_right_312, label %logical_and_merge_312

logical_and_right_312:
  %t316 = load i8*, i8** %l22
  %s317 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.317, i32 0, i32 0
  %t318 = call i1 @starts_with(i8* %t316, i8* %s317)
  %t319 = xor i1 %t318, 1
  br label %logical_and_right_end_312

logical_and_right_end_312:
  br label %logical_and_merge_312

logical_and_merge_312:
  %t320 = phi i1 [ false, %logical_and_entry_312 ], [ %t319, %logical_and_right_end_312 ]
  %t321 = xor i1 %t320, 1
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t324 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t325 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t326 = load double, double* %l4
  %t327 = load i8*, i8** %l5
  %t328 = load i8*, i8** %l6
  %t329 = load i8*, i8** %l17
  %t330 = load i8*, i8** %l18
  %t331 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t332 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t333 = load i8*, i8** %l21
  %t334 = load i8*, i8** %l22
  br i1 %t321, label %then35, label %merge36
then35:
  br label %afterloop32
merge36:
  %t335 = load i8*, i8** %l22
  %s336 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.336, i32 0, i32 0
  %t337 = call i1 @starts_with(i8* %t335, i8* %s336)
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t340 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t341 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t342 = load double, double* %l4
  %t343 = load i8*, i8** %l5
  %t344 = load i8*, i8** %l6
  %t345 = load i8*, i8** %l17
  %t346 = load i8*, i8** %l18
  %t347 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t348 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t349 = load i8*, i8** %l21
  %t350 = load i8*, i8** %l22
  br i1 %t337, label %then37, label %else38
then37:
  %t351 = load i8*, i8** %l22
  %s352 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.352, i32 0, i32 0
  %t353 = call i8* @strip_prefix(i8* %t351, i8* %s352)
  store i8* %t353, i8** %l23
  %t354 = load i8*, i8** %l17
  %s355 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.355, i32 0, i32 0
  %t356 = call i8* @strip_prefix(i8* %t354, i8* %s355)
  store i8* %t356, i8** %l24
  %t357 = load i8*, i8** %l24
  %t358 = load i8*, i8** %l21
  %t359 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t357, i8* %t358)
  store %EnumLayoutVariantParse %t359, %EnumLayoutVariantParse* %l25
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t361 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t362 = extractvalue %EnumLayoutVariantParse %t361, 2
  %t363 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t360, { i8**, i64 }* %t362)
  store { i8**, i64 }* %t363, { i8**, i64 }** %l1
  %t364 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t365 = extractvalue %EnumLayoutVariantParse %t364, 0
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t368 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t369 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t370 = load double, double* %l4
  %t371 = load i8*, i8** %l5
  %t372 = load i8*, i8** %l6
  %t373 = load i8*, i8** %l17
  %t374 = load i8*, i8** %l18
  %t375 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t376 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t377 = load i8*, i8** %l21
  %t378 = load i8*, i8** %l22
  %t379 = load i8*, i8** %l23
  %t380 = load i8*, i8** %l24
  %t381 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t365, label %then40, label %merge41
then40:
  %t382 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t383 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t384 = extractvalue %EnumLayoutVariantParse %t383, 1
  %t385 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t382, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t385, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge41
merge41:
  %t386 = phi { %NativeEnumVariantLayout*, i64 }* [ %t385, %then40 ], [ %t376, %then37 ]
  store { %NativeEnumVariantLayout*, i64 }* %t386, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge39
else38:
  %t387 = load i8*, i8** %l22
  %s388 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.388, i32 0, i32 0
  %t389 = call i1 @starts_with(i8* %t387, i8* %s388)
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t392 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t393 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t394 = load double, double* %l4
  %t395 = load i8*, i8** %l5
  %t396 = load i8*, i8** %l6
  %t397 = load i8*, i8** %l17
  %t398 = load i8*, i8** %l18
  %t399 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t400 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t401 = load i8*, i8** %l21
  %t402 = load i8*, i8** %l22
  br i1 %t389, label %then42, label %merge43
then42:
  %t403 = load i8*, i8** %l22
  %s404 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.404, i32 0, i32 0
  %t405 = call i8* @strip_prefix(i8* %t403, i8* %s404)
  store i8* %t405, i8** %l26
  %t406 = load i8*, i8** %l17
  %s407 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.407, i32 0, i32 0
  %t408 = call i8* @strip_prefix(i8* %t406, i8* %s407)
  store i8* %t408, i8** %l27
  %t409 = load i8*, i8** %l27
  %t410 = load i8*, i8** %l21
  %t411 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t409, i8* %t410)
  store %EnumLayoutPayloadParse %t411, %EnumLayoutPayloadParse* %l28
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t413 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t414 = extractvalue %EnumLayoutPayloadParse %t413, 3
  %t415 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t412, { i8**, i64 }* %t414)
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  %t417 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t418 = extractvalue %EnumLayoutPayloadParse %t417, 0
  br label %logical_and_entry_416

logical_and_entry_416:
  br i1 %t418, label %logical_and_right_416, label %logical_and_merge_416

logical_and_right_416:
  %t419 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t420 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t419
  %t421 = extractvalue { %NativeEnumVariantLayout*, i64 } %t420, 1
  %t422 = icmp sgt i64 %t421, 0
  br label %logical_and_right_end_416

logical_and_right_end_416:
  br label %logical_and_merge_416

logical_and_merge_416:
  %t423 = phi i1 [ false, %logical_and_entry_416 ], [ %t422, %logical_and_right_end_416 ]
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t426 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t427 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t428 = load double, double* %l4
  %t429 = load i8*, i8** %l5
  %t430 = load i8*, i8** %l6
  %t431 = load i8*, i8** %l17
  %t432 = load i8*, i8** %l18
  %t433 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t434 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t435 = load i8*, i8** %l21
  %t436 = load i8*, i8** %l22
  %t437 = load i8*, i8** %l26
  %t438 = load i8*, i8** %l27
  %t439 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t423, label %then44, label %merge45
then44:
  %t440 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t441 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t440
  %t442 = extractvalue { %NativeEnumVariantLayout*, i64 } %t441, 1
  %t443 = sub i64 %t442, 1
  store i64 %t443, i64* %l29
  %t444 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t445 = load i64, i64* %l29
  %t446 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t444
  %t447 = extractvalue { %NativeEnumVariantLayout*, i64 } %t446, 0
  %t448 = extractvalue { %NativeEnumVariantLayout*, i64 } %t446, 1
  %t449 = icmp uge i64 %t445, %t448
  ; bounds check: %t449 (if true, out of bounds)
  %t450 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t447, i64 %t445
  %t451 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t450
  store %NativeEnumVariantLayout %t451, %NativeEnumVariantLayout* %l30
  %t452 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t453 = extractvalue %NativeEnumVariantLayout %t452, 5
  %t454 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t455 = extractvalue %EnumLayoutPayloadParse %t454, 2
  %t456 = bitcast { i8**, i64 }* %t453 to { %NativeStructLayoutField*, i64 }*
  %t457 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t456, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t457, { %NativeStructLayoutField*, i64 }** %l31
  br label %merge45
merge45:
  br label %merge43
merge43:
  %t458 = phi i8* [ %t405, %then42 ], [ %t397, %else38 ]
  %t459 = phi { i8**, i64 }* [ %t415, %then42 ], [ %t391, %else38 ]
  store i8* %t458, i8** %l17
  store { i8**, i64 }* %t459, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t460 = phi i8* [ %t353, %then37 ], [ %t405, %else38 ]
  %t461 = phi { i8**, i64 }* [ %t363, %then37 ], [ %t415, %else38 ]
  %t462 = phi { %NativeEnumVariantLayout*, i64 }* [ %t385, %then37 ], [ %t348, %else38 ]
  store i8* %t460, i8** %l17
  store { i8**, i64 }* %t461, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t462, { %NativeEnumVariantLayout*, i64 }** %l20
  %t463 = load double, double* %l4
  %t464 = sitofp i64 1 to double
  %t465 = fadd double %t463, %t464
  store double %t465, double* %l4
  br label %loop.latch31
loop.latch31:
  %t466 = load i8*, i8** %l17
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t468 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t469 = load double, double* %l4
  br label %loop.header29
afterloop32:
  store double 0.0, double* %l32
  %t474 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t475 = load double, double* %l32
  %t476 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t474, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t476, { %NativeEnum*, i64 }** %l3
  br label %merge28
else27:
  %t477 = load double, double* %l4
  %t478 = sitofp i64 1 to double
  %t479 = fadd double %t477, %t478
  store double %t479, double* %l4
  br label %merge28
merge28:
  %t480 = phi double [ %t271, %then26 ], [ %t479, %else27 ]
  %t481 = phi i8* [ %t353, %then26 ], [ %t259, %else27 ]
  %t482 = phi { i8**, i64 }* [ %t363, %then26 ], [ %t253, %else27 ]
  %t483 = phi { %NativeEnum*, i64 }* [ %t476, %then26 ], [ %t255, %else27 ]
  store double %t480, double* %l4
  store i8* %t481, i8** %l17
  store { i8**, i64 }* %t482, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t483, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge25:
  %t484 = load double, double* %l4
  %t485 = sitofp i64 1 to double
  %t486 = fadd double %t484, %t485
  store double %t486, double* %l4
  br label %loop.latch2
loop.latch2:
  %t487 = load double, double* %l4
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t489 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t490 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t495 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t496 = bitcast { %NativeStruct*, i64 }* %t495 to { i8**, i64 }*
  %t497 = insertvalue %LayoutManifest undef, { i8**, i64 }* %t496, 0
  %t498 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t499 = bitcast { %NativeEnum*, i64 }* %t498 to { i8**, i64 }*
  %t500 = insertvalue %LayoutManifest %t497, { i8**, i64 }* %t499, 1
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t502 = insertvalue %LayoutManifest %t500, { i8**, i64 }* %t501, 2
  ret %LayoutManifest %t502
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

define i8* @strip_prefix(i8* %value, i8* %prefix) {
entry:
  %t0 = call i1 @starts_with(i8* %value, i8* %prefix)
  %t1 = xor i1 %t0, 1
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %value
merge1:
  ret i8* null
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

define double @last_index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t0, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp olt double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  store i1 1, i1* %l2
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = load i1, i1* %l2
  br label %loop.header6
loop.header6:
  %t14 = phi double [ %t7, %loop.body1 ], [ %t13, %loop.latch8 ]
  store double %t14, double* %l1
  br label %loop.body7
loop.body7:
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch8
loop.latch8:
  %t13 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t15 = load i1, i1* %l2
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load i1, i1* %l2
  br i1 %t15, label %then10, label %merge11
then10:
  %t19 = load double, double* %l0
  ret double %t19
merge11:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fsub double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = sitofp i64 -1 to double
  ret double %t25
}

define i8* @strip_quotes(i8* %value) {
entry:
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
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t34 = phi { i8**, i64 }* [ %t7, %entry ], [ %t31, %loop.latch2 ]
  %t35 = phi double [ %t8, %entry ], [ %t32, %loop.latch2 ]
  %t36 = phi double [ %t9, %entry ], [ %t33, %loop.latch2 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  store double %t35, double* %l1
  store double %t36, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l3
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l4
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l4
  %t25 = fptosi double %t23 to i64
  %t26 = fptosi double %t24 to i64
  %t27 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t25, i64 %t26)
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load double, double* %l4
  %t30 = load double, double* %l1
  store double %t30, double* %l2
  br label %loop.latch2
loop.latch2:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t37 = load double, double* %l1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t38
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
