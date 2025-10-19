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
@.str.104 = private unnamed_addr constant [5 x i8] c"void\00"
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
  %t926 = phi double [ %t48, %entry ], [ %t917, %loop.latch2 ]
  %t927 = phi { i8**, i64 }* [ %t38, %entry ], [ %t918, %loop.latch2 ]
  %t928 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t919, %loop.latch2 ]
  %t929 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t920, %loop.latch2 ]
  %t930 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t921, %loop.latch2 ]
  %t931 = phi i8* [ %t45, %entry ], [ %t922, %loop.latch2 ]
  %t932 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t923, %loop.latch2 ]
  %t933 = phi i8* [ %t46, %entry ], [ %t924, %loop.latch2 ]
  %t934 = phi i8* [ %t47, %entry ], [ %t925, %loop.latch2 ]
  store double %t926, double* %l11
  store { i8**, i64 }* %t927, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t928, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t929, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t930, { %NativeEnum*, i64 }** %l6
  store i8* %t931, i8** %l8
  store { %NativeFunction*, i64 }* %t932, { %NativeFunction*, i64 }** %l2
  store i8* %t933, i8** %l9
  store i8* %t934, i8** %l10
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
  %t215 = load %StructParseResult, %StructParseResult* %l17
  %t216 = extractvalue %StructParseResult %t215, 2
  %t217 = call double @diagnosticsconcat({ i8**, i64 }* %t216)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t218 = load %StructParseResult, %StructParseResult* %l17
  %t219 = extractvalue %StructParseResult %t218, 0
  %t220 = icmp ne i8* %t219, null
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t224 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t225 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t226 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t227 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t228 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t229 = load i8*, i8** %l8
  %t230 = load i8*, i8** %l9
  %t231 = load i8*, i8** %l10
  %t232 = load double, double* %l11
  %t233 = load i8*, i8** %l12
  %t234 = load i8*, i8** %l13
  %t235 = load %StructParseResult, %StructParseResult* %l17
  br i1 %t220, label %then18, label %merge19
then18:
  %t236 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t237 = load %StructParseResult, %StructParseResult* %l17
  %t238 = extractvalue %StructParseResult %t237, 0
  %t239 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t236, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t239, { %NativeStruct*, i64 }** %l4
  br label %merge19
merge19:
  %t240 = phi { %NativeStruct*, i64 }* [ %t239, %then18 ], [ %t225, %then16 ]
  store { %NativeStruct*, i64 }* %t240, { %NativeStruct*, i64 }** %l4
  %t241 = load %StructParseResult, %StructParseResult* %l17
  %t242 = extractvalue %StructParseResult %t241, 1
  store double %t242, double* %l11
  br label %loop.latch2
merge17:
  %t243 = load i8*, i8** %l13
  %s244 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.244, i32 0, i32 0
  %t245 = call i1 @starts_with(i8* %t243, i8* %s244)
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
  br i1 %t245, label %then20, label %merge21
then20:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t261 = load double, double* %l11
  %t262 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t260, double %t261)
  store %InterfaceParseResult %t262, %InterfaceParseResult* %l18
  %t263 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t264 = extractvalue %InterfaceParseResult %t263, 2
  %t265 = call double @diagnosticsconcat({ i8**, i64 }* %t264)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t266 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t267 = extractvalue %InterfaceParseResult %t266, 0
  %t268 = icmp ne i8* %t267, null
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t272 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t273 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t274 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t275 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t276 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t277 = load i8*, i8** %l8
  %t278 = load i8*, i8** %l9
  %t279 = load i8*, i8** %l10
  %t280 = load double, double* %l11
  %t281 = load i8*, i8** %l12
  %t282 = load i8*, i8** %l13
  %t283 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  br i1 %t268, label %then22, label %merge23
then22:
  %t284 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t285 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t286 = extractvalue %InterfaceParseResult %t285, 0
  %t287 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t284, %NativeInterface zeroinitializer)
  store { %NativeInterface*, i64 }* %t287, { %NativeInterface*, i64 }** %l5
  br label %merge23
merge23:
  %t288 = phi { %NativeInterface*, i64 }* [ %t287, %then22 ], [ %t274, %then20 ]
  store { %NativeInterface*, i64 }* %t288, { %NativeInterface*, i64 }** %l5
  %t289 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t290 = extractvalue %InterfaceParseResult %t289, 1
  store double %t290, double* %l11
  br label %loop.latch2
merge21:
  %t291 = load i8*, i8** %l13
  %s292 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.292, i32 0, i32 0
  %t293 = call i1 @starts_with(i8* %t291, i8* %s292)
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t297 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t298 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t299 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t300 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t301 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t302 = load i8*, i8** %l8
  %t303 = load i8*, i8** %l9
  %t304 = load i8*, i8** %l10
  %t305 = load double, double* %l11
  %t306 = load i8*, i8** %l12
  %t307 = load i8*, i8** %l13
  br i1 %t293, label %then24, label %merge25
then24:
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t309 = load double, double* %l11
  %t310 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t308, double %t309)
  store %EnumParseResult %t310, %EnumParseResult* %l19
  %t311 = load %EnumParseResult, %EnumParseResult* %l19
  %t312 = extractvalue %EnumParseResult %t311, 2
  %t313 = call double @diagnosticsconcat({ i8**, i64 }* %t312)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t314 = load %EnumParseResult, %EnumParseResult* %l19
  %t315 = extractvalue %EnumParseResult %t314, 0
  %t316 = icmp ne i8* %t315, null
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t319 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t320 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t321 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t322 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t323 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t324 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t325 = load i8*, i8** %l8
  %t326 = load i8*, i8** %l9
  %t327 = load i8*, i8** %l10
  %t328 = load double, double* %l11
  %t329 = load i8*, i8** %l12
  %t330 = load i8*, i8** %l13
  %t331 = load %EnumParseResult, %EnumParseResult* %l19
  br i1 %t316, label %then26, label %merge27
then26:
  %t332 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t333 = load %EnumParseResult, %EnumParseResult* %l19
  %t334 = extractvalue %EnumParseResult %t333, 0
  %t335 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t332, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t335, { %NativeEnum*, i64 }** %l6
  br label %merge27
merge27:
  %t336 = phi { %NativeEnum*, i64 }* [ %t335, %then26 ], [ %t323, %then24 ]
  store { %NativeEnum*, i64 }* %t336, { %NativeEnum*, i64 }** %l6
  %t337 = load %EnumParseResult, %EnumParseResult* %l19
  %t338 = extractvalue %EnumParseResult %t337, 1
  store double %t338, double* %l11
  br label %loop.latch2
merge25:
  %t339 = load i8*, i8** %l13
  %s340 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.340, i32 0, i32 0
  %t341 = call i1 @starts_with(i8* %t339, i8* %s340)
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t344 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t345 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t346 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t347 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t348 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t349 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t350 = load i8*, i8** %l8
  %t351 = load i8*, i8** %l9
  %t352 = load i8*, i8** %l10
  %t353 = load double, double* %l11
  %t354 = load i8*, i8** %l12
  %t355 = load i8*, i8** %l13
  br i1 %t341, label %then28, label %merge29
then28:
  %t356 = load i8*, i8** %l8
  %t357 = icmp ne i8* %t356, null
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t360 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t361 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t362 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t363 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t364 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t365 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t366 = load i8*, i8** %l8
  %t367 = load i8*, i8** %l9
  %t368 = load i8*, i8** %l10
  %t369 = load double, double* %l11
  %t370 = load i8*, i8** %l12
  %t371 = load i8*, i8** %l13
  br i1 %t357, label %then30, label %merge31
then30:
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s373 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.373, i32 0, i32 0
  %t374 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t372, i8* %s373)
  store { i8**, i64 }* %t374, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t375 = phi { i8**, i64 }* [ %t374, %then30 ], [ %t359, %then28 ]
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  %t376 = load double, double* %l11
  %t377 = sitofp i64 1 to double
  %t378 = fadd double %t376, %t377
  store double %t378, double* %l11
  br label %loop.latch2
merge29:
  %t379 = load i8*, i8** %l13
  %s380 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.380, i32 0, i32 0
  %t381 = call i1 @starts_with(i8* %t379, i8* %s380)
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t384 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t385 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t386 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t387 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t388 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t389 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t390 = load i8*, i8** %l8
  %t391 = load i8*, i8** %l9
  %t392 = load i8*, i8** %l10
  %t393 = load double, double* %l11
  %t394 = load i8*, i8** %l12
  %t395 = load i8*, i8** %l13
  br i1 %t381, label %then32, label %merge33
then32:
  %t396 = load i8*, i8** %l8
  %t397 = icmp eq i8* %t396, null
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t400 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t401 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t402 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t403 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t404 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t405 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t406 = load i8*, i8** %l8
  %t407 = load i8*, i8** %l9
  %t408 = load i8*, i8** %l10
  %t409 = load double, double* %l11
  %t410 = load i8*, i8** %l12
  %t411 = load i8*, i8** %l13
  br i1 %t397, label %then34, label %else35
then34:
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s413 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.413, i32 0, i32 0
  %t414 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t412, i8* %s413)
  store { i8**, i64 }* %t414, { i8**, i64 }** %l1
  br label %merge36
else35:
  %t415 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t416 = load i8*, i8** %l8
  %t417 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t415, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t417, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge36
merge36:
  %t418 = phi { i8**, i64 }* [ %t414, %then34 ], [ %t399, %else35 ]
  %t419 = phi { %NativeFunction*, i64 }* [ %t400, %then34 ], [ %t417, %else35 ]
  %t420 = phi i8* [ %t406, %then34 ], [ null, %else35 ]
  store { i8**, i64 }* %t418, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t419, { %NativeFunction*, i64 }** %l2
  store i8* %t420, i8** %l8
  %t421 = load double, double* %l11
  %t422 = sitofp i64 1 to double
  %t423 = fadd double %t421, %t422
  store double %t423, double* %l11
  br label %loop.latch2
merge33:
  %t424 = load i8*, i8** %l13
  %s425 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.425, i32 0, i32 0
  %t426 = call i1 @starts_with(i8* %t424, i8* %s425)
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t429 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t430 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t431 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t432 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t433 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t434 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t435 = load i8*, i8** %l8
  %t436 = load i8*, i8** %l9
  %t437 = load i8*, i8** %l10
  %t438 = load double, double* %l11
  %t439 = load i8*, i8** %l12
  %t440 = load i8*, i8** %l13
  br i1 %t426, label %then37, label %merge38
then37:
  %t441 = load i8*, i8** %l8
  %t442 = icmp ne i8* %t441, null
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t445 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t446 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t447 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t448 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t449 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t450 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t451 = load i8*, i8** %l8
  %t452 = load i8*, i8** %l9
  %t453 = load i8*, i8** %l10
  %t454 = load double, double* %l11
  %t455 = load i8*, i8** %l12
  %t456 = load i8*, i8** %l13
  br i1 %t442, label %then39, label %else40
then39:
  %t457 = load i8*, i8** %l8
  %t458 = load i8*, i8** %l13
  %s459 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.459, i32 0, i32 0
  %t460 = call i8* @strip_prefix(i8* %t458, i8* %s459)
  %t461 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t460)
  store i8* null, i8** %l8
  br label %merge41
else40:
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s463 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.463, i32 0, i32 0
  %t464 = load i8*, i8** %l13
  %t465 = add i8* %s463, %t464
  %t466 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t462, i8* %t465)
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t467 = phi i8* [ null, %then39 ], [ %t451, %else40 ]
  %t468 = phi { i8**, i64 }* [ %t444, %then39 ], [ %t466, %else40 ]
  store i8* %t467, i8** %l8
  store { i8**, i64 }* %t468, { i8**, i64 }** %l1
  %t469 = load double, double* %l11
  %t470 = sitofp i64 1 to double
  %t471 = fadd double %t469, %t470
  store double %t471, double* %l11
  br label %loop.latch2
merge38:
  %t472 = load i8*, i8** %l13
  %s473 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.473, i32 0, i32 0
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
  br i1 %t474, label %then42, label %merge43
then42:
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
  br i1 %t490, label %then44, label %else45
then44:
  %t505 = load i8*, i8** %l13
  %s506 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.506, i32 0, i32 0
  %t507 = call i8* @strip_prefix(i8* %t505, i8* %s506)
  store i8* %t507, i8** %l20
  %t508 = load double, double* %l11
  %t509 = sitofp i64 1 to double
  %t510 = fadd double %t508, %t509
  store double %t510, double* %l21
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t513 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t514 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t515 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t516 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t517 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t518 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t519 = load i8*, i8** %l8
  %t520 = load i8*, i8** %l9
  %t521 = load i8*, i8** %l10
  %t522 = load double, double* %l11
  %t523 = load i8*, i8** %l12
  %t524 = load i8*, i8** %l13
  %t525 = load i8*, i8** %l20
  %t526 = load double, double* %l21
  br label %loop.header47
loop.header47:
  %t595 = phi i8* [ %t525, %then44 ], [ %t593, %loop.latch49 ]
  %t596 = phi double [ %t526, %then44 ], [ %t594, %loop.latch49 ]
  store i8* %t595, i8** %l20
  store double %t596, double* %l21
  br label %loop.body48
loop.body48:
  %t527 = load double, double* %l21
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t529 = load { i8**, i64 }, { i8**, i64 }* %t528
  %t530 = extractvalue { i8**, i64 } %t529, 1
  %t531 = sitofp i64 %t530 to double
  %t532 = fcmp oge double %t527, %t531
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t535 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t536 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t537 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t538 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t539 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t540 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t541 = load i8*, i8** %l8
  %t542 = load i8*, i8** %l9
  %t543 = load i8*, i8** %l10
  %t544 = load double, double* %l11
  %t545 = load i8*, i8** %l12
  %t546 = load i8*, i8** %l13
  %t547 = load i8*, i8** %l20
  %t548 = load double, double* %l21
  br i1 %t532, label %then51, label %merge52
then51:
  br label %afterloop50
merge52:
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t550 = load double, double* %l21
  %t551 = load { i8**, i64 }, { i8**, i64 }* %t549
  %t552 = extractvalue { i8**, i64 } %t551, 0
  %t553 = extractvalue { i8**, i64 } %t551, 1
  %t554 = icmp uge i64 %t550, %t553
  ; bounds check: %t554 (if true, out of bounds)
  %t555 = getelementptr i8*, i8** %t552, i64 %t550
  %t556 = load i8*, i8** %t555
  store i8* %t556, i8** %l22
  %t557 = load i8*, i8** %l22
  %t558 = load i8*, i8** %l22
  %t559 = call i8* @trim_text(i8* %t558)
  store i8* %t559, i8** %l23
  %t560 = load i8*, i8** %l23
  %t561 = load i8*, i8** %l23
  %t562 = call i1 @line_looks_like_parameter_entry(i8* %t561)
  %t563 = xor i1 %t562, 1
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t566 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t567 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t568 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t569 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t570 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t571 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t572 = load i8*, i8** %l8
  %t573 = load i8*, i8** %l9
  %t574 = load i8*, i8** %l10
  %t575 = load double, double* %l11
  %t576 = load i8*, i8** %l12
  %t577 = load i8*, i8** %l13
  %t578 = load i8*, i8** %l20
  %t579 = load double, double* %l21
  %t580 = load i8*, i8** %l22
  %t581 = load i8*, i8** %l23
  br i1 %t563, label %then53, label %merge54
then53:
  br label %afterloop50
merge54:
  %t582 = load i8*, i8** %l20
  %t583 = getelementptr i8, i8* %t582, i64 0
  %t584 = load i8, i8* %t583
  %t585 = add i8 %t584, 32
  %t586 = load i8*, i8** %l23
  %t587 = getelementptr i8, i8* %t586, i64 0
  %t588 = load i8, i8* %t587
  %t589 = add i8 %t585, %t588
  store i8* null, i8** %l20
  %t590 = load double, double* %l21
  %t591 = sitofp i64 1 to double
  %t592 = fadd double %t590, %t591
  store double %t592, double* %l21
  br label %loop.latch49
loop.latch49:
  %t593 = load i8*, i8** %l20
  %t594 = load double, double* %l21
  br label %loop.header47
afterloop50:
  %t597 = load i8*, i8** %l20
  %t598 = call { i8**, i64 }* @split_parameter_entries(i8* %t597)
  store { i8**, i64 }* %t598, { i8**, i64 }** %l24
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t600 = load { i8**, i64 }, { i8**, i64 }* %t599
  %t601 = extractvalue { i8**, i64 } %t600, 1
  %t602 = icmp eq i64 %t601, 0
  %t603 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t604 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t605 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t606 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t607 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t608 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t609 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t610 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t611 = load i8*, i8** %l8
  %t612 = load i8*, i8** %l9
  %t613 = load i8*, i8** %l10
  %t614 = load double, double* %l11
  %t615 = load i8*, i8** %l12
  %t616 = load i8*, i8** %l13
  %t617 = load i8*, i8** %l20
  %t618 = load double, double* %l21
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br i1 %t602, label %then55, label %else56
then55:
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s621 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.621, i32 0, i32 0
  %t622 = load i8*, i8** %l13
  %t623 = add i8* %s621, %t622
  %t624 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t620, i8* %t623)
  store { i8**, i64 }* %t624, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge57
else56:
  %t625 = sitofp i64 0 to double
  store double %t625, double* %l25
  store i1 0, i1* %l26
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t627 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t628 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t629 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t630 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t631 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t632 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t633 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t634 = load i8*, i8** %l8
  %t635 = load i8*, i8** %l9
  %t636 = load i8*, i8** %l10
  %t637 = load double, double* %l11
  %t638 = load i8*, i8** %l12
  %t639 = load i8*, i8** %l13
  %t640 = load i8*, i8** %l20
  %t641 = load double, double* %l21
  %t642 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t643 = load double, double* %l25
  %t644 = load i1, i1* %l26
  br label %loop.header58
loop.header58:
  %t710 = phi double [ %t643, %else56 ], [ %t709, %loop.latch60 ]
  store double %t710, double* %l25
  br label %loop.body59
loop.body59:
  %t645 = load double, double* %l25
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t647 = load { i8**, i64 }, { i8**, i64 }* %t646
  %t648 = extractvalue { i8**, i64 } %t647, 1
  %t649 = sitofp i64 %t648 to double
  %t650 = fcmp oge double %t645, %t649
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t652 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t653 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t654 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t655 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t656 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t657 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t658 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t659 = load i8*, i8** %l8
  %t660 = load i8*, i8** %l9
  %t661 = load i8*, i8** %l10
  %t662 = load double, double* %l11
  %t663 = load i8*, i8** %l12
  %t664 = load i8*, i8** %l13
  %t665 = load i8*, i8** %l20
  %t666 = load double, double* %l21
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t668 = load double, double* %l25
  %t669 = load i1, i1* %l26
  br i1 %t650, label %then62, label %merge63
then62:
  br label %afterloop61
merge63:
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t671 = load double, double* %l25
  %t672 = load { i8**, i64 }, { i8**, i64 }* %t670
  %t673 = extractvalue { i8**, i64 } %t672, 0
  %t674 = extractvalue { i8**, i64 } %t672, 1
  %t675 = icmp uge i64 %t671, %t674
  ; bounds check: %t675 (if true, out of bounds)
  %t676 = getelementptr i8*, i8** %t673, i64 %t671
  %t677 = load i8*, i8** %t676
  store i8* %t677, i8** %l27
  %t678 = load i8*, i8** %l9
  store i8* %t678, i8** %l28
  %t679 = load i1, i1* %l26
  %t680 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t681 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t682 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t683 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t684 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t685 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t686 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t687 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t688 = load i8*, i8** %l8
  %t689 = load i8*, i8** %l9
  %t690 = load i8*, i8** %l10
  %t691 = load double, double* %l11
  %t692 = load i8*, i8** %l12
  %t693 = load i8*, i8** %l13
  %t694 = load i8*, i8** %l20
  %t695 = load double, double* %l21
  %t696 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t697 = load double, double* %l25
  %t698 = load i1, i1* %l26
  %t699 = load i8*, i8** %l27
  %t700 = load i8*, i8** %l28
  br i1 %t679, label %then64, label %merge65
then64:
  store i8* null, i8** %l28
  br label %merge65
merge65:
  %t701 = phi i8* [ null, %then64 ], [ %t700, %loop.body59 ]
  store i8* %t701, i8** %l28
  %t702 = load i8*, i8** %l27
  %t703 = load i8*, i8** %l28
  %t704 = call double @parse_parameter_entry(i8* %t702, i8* %t703)
  store double %t704, double* %l29
  %t705 = load double, double* %l29
  %t706 = load double, double* %l25
  %t707 = sitofp i64 1 to double
  %t708 = fadd double %t706, %t707
  store double %t708, double* %l25
  br label %loop.latch60
loop.latch60:
  %t709 = load double, double* %l25
  br label %loop.header58
afterloop61:
  store i8* null, i8** %l9
  br label %merge57
merge57:
  %t711 = phi { i8**, i64 }* [ %t624, %then55 ], [ %t604, %else56 ]
  %t712 = phi i8* [ null, %then55 ], [ null, %else56 ]
  store { i8**, i64 }* %t711, { i8**, i64 }** %l1
  store i8* %t712, i8** %l9
  %t713 = load double, double* %l21
  %t714 = sitofp i64 1 to double
  %t715 = fsub double %t713, %t714
  store double %t715, double* %l11
  br label %merge46
else45:
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s717 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.717, i32 0, i32 0
  %t718 = load i8*, i8** %l13
  %t719 = add i8* %s717, %t718
  %t720 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t716, i8* %t719)
  store { i8**, i64 }* %t720, { i8**, i64 }** %l1
  br label %merge46
merge46:
  %t721 = phi { i8**, i64 }* [ %t624, %then44 ], [ %t720, %else45 ]
  %t722 = phi i8* [ null, %then44 ], [ %t500, %else45 ]
  %t723 = phi double [ %t715, %then44 ], [ %t502, %else45 ]
  store { i8**, i64 }* %t721, { i8**, i64 }** %l1
  store i8* %t722, i8** %l9
  store double %t723, double* %l11
  %t724 = load double, double* %l11
  %t725 = sitofp i64 1 to double
  %t726 = fadd double %t724, %t725
  store double %t726, double* %l11
  br label %loop.latch2
merge43:
  %t727 = load i8*, i8** %l13
  %t728 = load i8*, i8** %l9
  %t729 = load i8*, i8** %l10
  %t730 = call %InstructionParseResult @parse_instruction(i8* %t727, i8* %t728, i8* %t729)
  store %InstructionParseResult %t730, %InstructionParseResult* %l30
  %t731 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t732 = extractvalue %InstructionParseResult %t731, 0
  store { i8**, i64 }* %t732, { i8**, i64 }** %l31
  %t733 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t734 = extractvalue %InstructionParseResult %t733, 1
  %t735 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t736 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t737 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t738 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t739 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t740 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t741 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t742 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t743 = load i8*, i8** %l8
  %t744 = load i8*, i8** %l9
  %t745 = load i8*, i8** %l10
  %t746 = load double, double* %l11
  %t747 = load i8*, i8** %l12
  %t748 = load i8*, i8** %l13
  %t749 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t750 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t734, label %then66, label %else67
then66:
  store i8* null, i8** %l9
  br label %merge68
else67:
  %t751 = load i8*, i8** %l9
  %t752 = icmp ne i8* %t751, null
  %t753 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t754 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t755 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t756 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t757 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t758 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t759 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t760 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t761 = load i8*, i8** %l8
  %t762 = load i8*, i8** %l9
  %t763 = load i8*, i8** %l10
  %t764 = load double, double* %l11
  %t765 = load i8*, i8** %l12
  %t766 = load i8*, i8** %l13
  %t767 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t768 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t752, label %then69, label %merge70
then69:
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s770 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.770, i32 0, i32 0
  %t771 = load i8*, i8** %l13
  %t772 = add i8* %s770, %t771
  %t773 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t769, i8* %t772)
  store { i8**, i64 }* %t773, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge70
merge70:
  %t774 = phi { i8**, i64 }* [ %t773, %then69 ], [ %t754, %else67 ]
  %t775 = phi i8* [ null, %then69 ], [ %t762, %else67 ]
  store { i8**, i64 }* %t774, { i8**, i64 }** %l1
  store i8* %t775, i8** %l9
  br label %merge68
merge68:
  %t776 = phi i8* [ null, %then66 ], [ null, %else67 ]
  %t777 = phi { i8**, i64 }* [ %t736, %then66 ], [ %t773, %else67 ]
  store i8* %t776, i8** %l9
  store { i8**, i64 }* %t777, { i8**, i64 }** %l1
  %t778 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t779 = extractvalue %InstructionParseResult %t778, 2
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
  %t794 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t795 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t779, label %then71, label %else72
then71:
  store i8* null, i8** %l10
  br label %merge73
else72:
  %t796 = load i8*, i8** %l10
  %t797 = icmp ne i8* %t796, null
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t799 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t800 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t801 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t802 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t803 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t804 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t805 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t806 = load i8*, i8** %l8
  %t807 = load i8*, i8** %l9
  %t808 = load i8*, i8** %l10
  %t809 = load double, double* %l11
  %t810 = load i8*, i8** %l12
  %t811 = load i8*, i8** %l13
  %t812 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t813 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t797, label %then74, label %merge75
then74:
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s815 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.815, i32 0, i32 0
  %t816 = load i8*, i8** %l13
  %t817 = add i8* %s815, %t816
  %t818 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t814, i8* %t817)
  store { i8**, i64 }* %t818, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge75
merge75:
  %t819 = phi { i8**, i64 }* [ %t818, %then74 ], [ %t799, %else72 ]
  %t820 = phi i8* [ null, %then74 ], [ %t808, %else72 ]
  store { i8**, i64 }* %t819, { i8**, i64 }** %l1
  store i8* %t820, i8** %l10
  br label %merge73
merge73:
  %t821 = phi i8* [ null, %then71 ], [ null, %else72 ]
  %t822 = phi { i8**, i64 }* [ %t781, %then71 ], [ %t818, %else72 ]
  store i8* %t821, i8** %l10
  store { i8**, i64 }* %t822, { i8**, i64 }** %l1
  %t823 = load i8*, i8** %l8
  %t824 = icmp eq i8* %t823, null
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t827 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t828 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t829 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t830 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t831 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t832 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t833 = load i8*, i8** %l8
  %t834 = load i8*, i8** %l9
  %t835 = load i8*, i8** %l10
  %t836 = load double, double* %l11
  %t837 = load i8*, i8** %l12
  %t838 = load i8*, i8** %l13
  %t839 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t824, label %then76, label %merge77
then76:
  %t842 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t843 = load { i8**, i64 }, { i8**, i64 }* %t842
  %t844 = extractvalue { i8**, i64 } %t843, 1
  %t845 = icmp eq i64 %t844, 1
  br label %logical_and_entry_841

logical_and_entry_841:
  br i1 %t845, label %logical_and_right_841, label %logical_and_merge_841

logical_and_right_841:
  %t846 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t847 = load { i8**, i64 }, { i8**, i64 }* %t846
  %t848 = extractvalue { i8**, i64 } %t847, 0
  %t849 = extractvalue { i8**, i64 } %t847, 1
  %t850 = icmp uge i64 0, %t849
  ; bounds check: %t850 (if true, out of bounds)
  %t851 = getelementptr i8*, i8** %t848, i64 0
  %t852 = load i8*, i8** %t851
  %t853 = load double, double* %l11
  %t854 = sitofp i64 1 to double
  %t855 = fadd double %t853, %t854
  store double %t855, double* %l11
  br label %loop.latch2
merge77:
  %t856 = sitofp i64 0 to double
  store double %t856, double* %l32
  %t857 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t858 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t859 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t860 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t861 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t862 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t863 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t864 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t865 = load i8*, i8** %l8
  %t866 = load i8*, i8** %l9
  %t867 = load i8*, i8** %l10
  %t868 = load double, double* %l11
  %t869 = load i8*, i8** %l12
  %t870 = load i8*, i8** %l13
  %t871 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t873 = load double, double* %l32
  br label %loop.header78
loop.header78:
  %t912 = phi i8* [ %t865, %loop.body1 ], [ %t910, %loop.latch80 ]
  %t913 = phi double [ %t873, %loop.body1 ], [ %t911, %loop.latch80 ]
  store i8* %t912, i8** %l8
  store double %t913, double* %l32
  br label %loop.body79
loop.body79:
  %t874 = load double, double* %l32
  %t875 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t876 = load { i8**, i64 }, { i8**, i64 }* %t875
  %t877 = extractvalue { i8**, i64 } %t876, 1
  %t878 = sitofp i64 %t877 to double
  %t879 = fcmp oge double %t874, %t878
  %t880 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t881 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t882 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t883 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t884 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t885 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t886 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t887 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t888 = load i8*, i8** %l8
  %t889 = load i8*, i8** %l9
  %t890 = load i8*, i8** %l10
  %t891 = load double, double* %l11
  %t892 = load i8*, i8** %l12
  %t893 = load i8*, i8** %l13
  %t894 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t895 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t896 = load double, double* %l32
  br i1 %t879, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t897 = load i8*, i8** %l8
  %t898 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t899 = load double, double* %l32
  %t900 = load { i8**, i64 }, { i8**, i64 }* %t898
  %t901 = extractvalue { i8**, i64 } %t900, 0
  %t902 = extractvalue { i8**, i64 } %t900, 1
  %t903 = icmp uge i64 %t899, %t902
  ; bounds check: %t903 (if true, out of bounds)
  %t904 = getelementptr i8*, i8** %t901, i64 %t899
  %t905 = load i8*, i8** %t904
  %t906 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t907 = load double, double* %l32
  %t908 = sitofp i64 1 to double
  %t909 = fadd double %t907, %t908
  store double %t909, double* %l32
  br label %loop.latch80
loop.latch80:
  %t910 = load i8*, i8** %l8
  %t911 = load double, double* %l32
  br label %loop.header78
afterloop81:
  %t914 = load double, double* %l11
  %t915 = sitofp i64 1 to double
  %t916 = fadd double %t914, %t915
  store double %t916, double* %l11
  br label %loop.latch2
loop.latch2:
  %t917 = load double, double* %l11
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t919 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t920 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t921 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t922 = load i8*, i8** %l8
  %t923 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t924 = load i8*, i8** %l9
  %t925 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t935 = load i8*, i8** %l8
  %t936 = icmp ne i8* %t935, null
  %t937 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t939 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t940 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t941 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t942 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t943 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t944 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t945 = load i8*, i8** %l8
  %t946 = load i8*, i8** %l9
  %t947 = load i8*, i8** %l10
  %t948 = load double, double* %l11
  br i1 %t936, label %then84, label %merge85
then84:
  %t949 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s950 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.950, i32 0, i32 0
  %t951 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t949, i8* %s950)
  store { i8**, i64 }* %t951, { i8**, i64 }** %l1
  br label %merge85
merge85:
  %t952 = phi { i8**, i64 }* [ %t951, %then84 ], [ %t938, %entry ]
  store { i8**, i64 }* %t952, { i8**, i64 }** %l1
  %t953 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t954 = insertvalue %ParseNativeResult undef, { i8**, i64 }* null, 0
  %t955 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t956 = insertvalue %ParseNativeResult %t954, { i8**, i64 }* null, 1
  %t957 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t958 = insertvalue %ParseNativeResult %t956, { i8**, i64 }* null, 2
  %t959 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t960 = insertvalue %ParseNativeResult %t958, { i8**, i64 }* null, 3
  %t961 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t962 = insertvalue %ParseNativeResult %t960, { i8**, i64 }* null, 4
  %t963 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t964 = insertvalue %ParseNativeResult %t962, { i8**, i64 }* null, 5
  %t965 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t966 = insertvalue %ParseNativeResult %t964, { i8**, i64 }* %t965, 6
  ret %ParseNativeResult %t966
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
  %t6 = call double @functionsconcat({ %NativeFunction*, i64 }* %t3)
  ret { %NativeFunction*, i64 }* null
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
  %t6 = call double @bindingsconcat({ %NativeBinding*, i64 }* %t3)
  ret { %NativeBinding*, i64 }* null
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
  %t6 = call double @importsconcat({ %NativeImport*, i64 }* %t3)
  ret { %NativeImport*, i64 }* null
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
  %t6 = call double @structsconcat({ %NativeStruct*, i64 }* %t3)
  ret { %NativeStruct*, i64 }* null
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
  %t6 = call double @interfacesconcat({ %NativeInterface*, i64 }* %t3)
  ret { %NativeInterface*, i64 }* null
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
  %t6 = call double @enumsconcat({ %NativeEnum*, i64 }* %t3)
  ret { %NativeEnum*, i64 }* null
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
  %t6 = call double @variantsconcat({ %NativeEnumVariant*, i64 }* %t3)
  ret { %NativeEnumVariant*, i64 }* null
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
  %t6 = call double @fieldsconcat({ %NativeEnumVariantField*, i64 }* %t3)
  ret { %NativeEnumVariantField*, i64 }* null
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
  %t6 = call double @fieldsconcat({ %NativeStructField*, i64 }* %t3)
  ret { %NativeStructField*, i64 }* null
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
  %t6 = call double @fieldsconcat({ %NativeStructLayoutField*, i64 }* %t3)
  ret { %NativeStructLayoutField*, i64 }* null
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
  %t6 = call double @variantsconcat({ %NativeEnumVariantLayout*, i64 }* %t3)
  ret { %NativeEnumVariantLayout*, i64 }* null
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
  %t1 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* null, %NativeParameter %parameter)
  store { %NativeParameter*, i64 }* %t1, { %NativeParameter*, i64 }** %l0
  %t2 = extractvalue %NativeFunction %function, 0
  %t3 = insertvalue %NativeFunction undef, i8* %t2, 0
  %t4 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l0
  %t5 = insertvalue %NativeFunction %t3, { i8**, i64 }* null, 1
  %t6 = extractvalue %NativeFunction %function, 2
  %t7 = insertvalue %NativeFunction %t5, i8* %t6, 2
  %t8 = extractvalue %NativeFunction %function, 3
  %t9 = insertvalue %NativeFunction %t7, { i8**, i64 }* %t8, 3
  %t10 = extractvalue %NativeFunction %function, 4
  %t11 = insertvalue %NativeFunction %t9, { i8**, i64 }* %t10, 4
  ret %NativeFunction %t11
}

define %NativeFunction @append_instruction(%NativeFunction %function, %NativeInstruction %instruction) {
entry:
  %l0 = alloca double
  %t0 = alloca [1 x %NativeInstruction]
  %t1 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t0, i32 0, i32 0
  %t2 = getelementptr %NativeInstruction, %NativeInstruction* %t1, i64 0
  store %NativeInstruction %instruction, %NativeInstruction* %t2
  %t3 = alloca { %NativeInstruction*, i64 }
  %t4 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t3, i32 0, i32 0
  store %NativeInstruction* %t1, %NativeInstruction** %t4
  %t5 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @functioninstructionsconcat({ %NativeInstruction*, i64 }* %t3)
  store double %t6, double* %l0
  %t7 = extractvalue %NativeFunction %function, 0
  %t8 = insertvalue %NativeFunction undef, i8* %t7, 0
  %t9 = extractvalue %NativeFunction %function, 1
  %t10 = insertvalue %NativeFunction %t8, { i8**, i64 }* %t9, 1
  %t11 = extractvalue %NativeFunction %function, 2
  %t12 = insertvalue %NativeFunction %t10, i8* %t11, 2
  %t13 = extractvalue %NativeFunction %function, 3
  %t14 = insertvalue %NativeFunction %t12, { i8**, i64 }* %t13, 3
  %t15 = load double, double* %l0
  %t16 = insertvalue %NativeFunction %t14, { i8**, i64 }* null, 4
  ret %NativeFunction %t16
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
  %t24 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t25 = insertvalue %InstructionParseResult %t24, i1 0, 1
  %t26 = insertvalue %InstructionParseResult %t25, i1 0, 2
  ret %InstructionParseResult %t26
merge3:
  %s27 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.27, i32 0, i32 0
  %t28 = icmp eq i8* %line, %s27
  br i1 %t28, label %then4, label %merge5
then4:
  %t29 = insertvalue %NativeInstruction undef, i32 4, 0
  %t30 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t31 = insertvalue %InstructionParseResult %t30, i1 0, 1
  %t32 = insertvalue %InstructionParseResult %t31, i1 0, 2
  ret %InstructionParseResult %t32
merge5:
  %s33 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp eq i8* %line, %s33
  br i1 %t34, label %then6, label %merge7
then6:
  %t35 = insertvalue %NativeInstruction undef, i32 5, 0
  %t36 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t37 = insertvalue %InstructionParseResult %t36, i1 0, 1
  %t38 = insertvalue %InstructionParseResult %t37, i1 0, 2
  ret %InstructionParseResult %t38
merge7:
  %s39 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.39, i32 0, i32 0
  %t40 = call i1 @starts_with(i8* %line, i8* %s39)
  br i1 %t40, label %then8, label %merge9
then8:
  %s41 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.41, i32 0, i32 0
  %t42 = call i8* @strip_prefix(i8* %line, i8* %s41)
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l1
  %s44 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.44, i32 0, i32 0
  store i8* %s44, i8** %l2
  %t45 = load i8*, i8** %l1
  %t46 = load i8*, i8** %l2
  %t47 = call double @index_of(i8* %t45, i8* %t46)
  store double %t47, double* %l3
  %t48 = load double, double* %l3
  %t49 = sitofp i64 0 to double
  %t50 = fcmp oge double %t48, %t49
  %t51 = load i8*, i8** %l1
  %t52 = load i8*, i8** %l2
  %t53 = load double, double* %l3
  br i1 %t50, label %then10, label %merge11
then10:
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l3
  %t56 = fptosi double %t55 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t54, i64 0, i64 %t56)
  %t58 = call i8* @trim_text(i8* %t57)
  store i8* %t58, i8** %l4
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l3
  %t61 = load i8*, i8** %l2
  %t62 = load i8*, i8** %l1
  store double 0.0, double* %l5
  %t63 = alloca %NativeInstruction
  %t64 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t63, i32 0, i32 0
  store i32 6, i32* %t64
  %t65 = load i8*, i8** %l4
  %t66 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t63, i32 0, i32 1
  %t67 = bitcast [16 x i8]* %t66 to i8*
  %t68 = bitcast i8* %t67 to i8**
  store i8* %t65, i8** %t68
  %t69 = load double, double* %l5
  %t70 = call noalias i8* @malloc(i64 8)
  %t71 = bitcast i8* %t70 to double*
  store double %t69, double* %t71
  %t72 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t63, i32 0, i32 1
  %t73 = bitcast [16 x i8]* %t72 to i8*
  %t74 = getelementptr inbounds i8, i8* %t73, i64 8
  %t75 = bitcast i8* %t74 to i8**
  store i8* %t70, i8** %t75
  %t76 = load %NativeInstruction, %NativeInstruction* %t63
  %t77 = alloca [1 x %NativeInstruction]
  %t78 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t77, i32 0, i32 0
  %t79 = getelementptr %NativeInstruction, %NativeInstruction* %t78, i64 0
  store %NativeInstruction %t76, %NativeInstruction* %t79
  %t80 = alloca { %NativeInstruction*, i64 }
  %t81 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t80, i32 0, i32 0
  store %NativeInstruction* %t78, %NativeInstruction** %t81
  %t82 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t80, i32 0, i32 1
  store i64 1, i64* %t82
  %t83 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t84 = insertvalue %InstructionParseResult %t83, i1 0, 1
  %t85 = insertvalue %InstructionParseResult %t84, i1 0, 2
  ret %InstructionParseResult %t85
merge11:
  br label %merge9
merge9:
  %s86 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.86, i32 0, i32 0
  %t87 = icmp eq i8* %line, %s86
  br i1 %t87, label %then12, label %merge13
then12:
  %t88 = insertvalue %NativeInstruction undef, i32 7, 0
  %t89 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t90 = insertvalue %InstructionParseResult %t89, i1 0, 1
  %t91 = insertvalue %InstructionParseResult %t90, i1 0, 2
  ret %InstructionParseResult %t91
merge13:
  %s92 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.92, i32 0, i32 0
  %t93 = icmp eq i8* %line, %s92
  br i1 %t93, label %then14, label %merge15
then14:
  %t94 = insertvalue %NativeInstruction undef, i32 8, 0
  %t95 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t96 = insertvalue %InstructionParseResult %t95, i1 0, 1
  %t97 = insertvalue %InstructionParseResult %t96, i1 0, 2
  ret %InstructionParseResult %t97
merge15:
  %s98 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.98, i32 0, i32 0
  %t99 = icmp eq i8* %line, %s98
  br i1 %t99, label %then16, label %merge17
then16:
  %t100 = insertvalue %NativeInstruction undef, i32 9, 0
  %t101 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t102 = insertvalue %InstructionParseResult %t101, i1 0, 1
  %t103 = insertvalue %InstructionParseResult %t102, i1 0, 2
  ret %InstructionParseResult %t103
merge17:
  %s104 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.104, i32 0, i32 0
  %t105 = icmp eq i8* %line, %s104
  br i1 %t105, label %then18, label %merge19
then18:
  %t106 = insertvalue %NativeInstruction undef, i32 10, 0
  %t107 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t108 = insertvalue %InstructionParseResult %t107, i1 0, 1
  %t109 = insertvalue %InstructionParseResult %t108, i1 0, 2
  ret %InstructionParseResult %t109
merge19:
  %s110 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.110, i32 0, i32 0
  %t111 = icmp eq i8* %line, %s110
  br i1 %t111, label %then20, label %merge21
then20:
  %t112 = insertvalue %NativeInstruction undef, i32 11, 0
  %t113 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t114 = insertvalue %InstructionParseResult %t113, i1 0, 1
  %t115 = insertvalue %InstructionParseResult %t114, i1 0, 2
  ret %InstructionParseResult %t115
merge21:
  %s116 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.116, i32 0, i32 0
  %t117 = call i1 @starts_with(i8* %line, i8* %s116)
  br i1 %t117, label %then22, label %merge23
then22:
  %s118 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.118, i32 0, i32 0
  %t119 = call i8* @strip_prefix(i8* %line, i8* %s118)
  %t120 = call i8* @trim_text(i8* %t119)
  store i8* %t120, i8** %l6
  %t121 = alloca %NativeInstruction
  %t122 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t121, i32 0, i32 0
  store i32 12, i32* %t122
  %t123 = load i8*, i8** %l6
  %t124 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t121, i32 0, i32 1
  %t125 = bitcast [8 x i8]* %t124 to i8*
  %t126 = bitcast i8* %t125 to i8**
  store i8* %t123, i8** %t126
  %t127 = load %NativeInstruction, %NativeInstruction* %t121
  %t128 = alloca [1 x %NativeInstruction]
  %t129 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t128, i32 0, i32 0
  %t130 = getelementptr %NativeInstruction, %NativeInstruction* %t129, i64 0
  store %NativeInstruction %t127, %NativeInstruction* %t130
  %t131 = alloca { %NativeInstruction*, i64 }
  %t132 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t131, i32 0, i32 0
  store %NativeInstruction* %t129, %NativeInstruction** %t132
  %t133 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t131, i32 0, i32 1
  store i64 1, i64* %t133
  %t134 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t135 = insertvalue %InstructionParseResult %t134, i1 0, 1
  %t136 = insertvalue %InstructionParseResult %t135, i1 0, 2
  ret %InstructionParseResult %t136
merge23:
  %s137 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i1 @starts_with(i8* %line, i8* %s137)
  br i1 %t138, label %then24, label %merge25
then24:
  %t139 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t140 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t141 = insertvalue %InstructionParseResult %t140, i1 0, 1
  %t142 = insertvalue %InstructionParseResult %t141, i1 0, 2
  ret %InstructionParseResult %t142
merge25:
  %s143 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.143, i32 0, i32 0
  %t144 = icmp eq i8* %line, %s143
  br i1 %t144, label %then26, label %merge27
then26:
  %t145 = insertvalue %NativeInstruction undef, i32 14, 0
  %t146 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t147 = insertvalue %InstructionParseResult %t146, i1 0, 1
  %t148 = insertvalue %InstructionParseResult %t147, i1 0, 2
  ret %InstructionParseResult %t148
merge27:
  %s149 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.149, i32 0, i32 0
  %t150 = call i1 @starts_with(i8* %line, i8* %s149)
  br i1 %t150, label %then28, label %merge29
then28:
  %t151 = call %NativeInstruction @parse_let_instruction(i8* %line, i8* %span, i8* %value_span)
  %t152 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t153 = insertvalue %InstructionParseResult %t152, i1 1, 1
  %t154 = insertvalue %InstructionParseResult %t153, i1 1, 2
  ret %InstructionParseResult %t154
merge29:
  %s155 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.155, i32 0, i32 0
  %t156 = call i1 @starts_with(i8* %line, i8* %s155)
  br i1 %t156, label %then30, label %merge31
then30:
  %t157 = getelementptr i8, i8* %line, i64 3
  %t158 = load i8, i8* %t157
  store i8 %t158, i8* %l7
  %t160 = load i8, i8* %l7
  %t161 = icmp eq i8 %t160, 32
  br label %logical_or_entry_159

logical_or_entry_159:
  br i1 %t161, label %logical_or_merge_159, label %logical_or_right_159

logical_or_right_159:
  %t162 = load i8, i8* %l7
  %t163 = icmp eq i8 %t162, 9
  br label %logical_or_right_end_159

logical_or_right_end_159:
  br label %logical_or_merge_159

logical_or_merge_159:
  %t164 = phi i1 [ true, %logical_or_entry_159 ], [ %t163, %logical_or_right_end_159 ]
  %t165 = load i8, i8* %l7
  br i1 %t164, label %then32, label %merge33
then32:
  store double 0.0, double* %l8
  %t166 = load double, double* %l8
  %t167 = alloca %NativeInstruction
  %t168 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t167, i32 0, i32 0
  store i32 0, i32* %t168
  %t169 = load double, double* %l8
  %t170 = call i8* @trim_trailing_delimiters(i8* null)
  %t171 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t167, i32 0, i32 1
  %t172 = bitcast [16 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i8**
  store i8* %t170, i8** %t173
  %t174 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t167, i32 0, i32 1
  %t175 = bitcast [16 x i8]* %t174 to i8*
  %t176 = getelementptr inbounds i8, i8* %t175, i64 8
  %t177 = bitcast i8* %t176 to i8**
  store i8* %span, i8** %t177
  %t178 = load %NativeInstruction, %NativeInstruction* %t167
  %t179 = alloca [1 x %NativeInstruction]
  %t180 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t179, i32 0, i32 0
  %t181 = getelementptr %NativeInstruction, %NativeInstruction* %t180, i64 0
  store %NativeInstruction %t178, %NativeInstruction* %t181
  %t182 = alloca { %NativeInstruction*, i64 }
  %t183 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t182, i32 0, i32 0
  store %NativeInstruction* %t180, %NativeInstruction** %t183
  %t184 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t182, i32 0, i32 1
  store i64 1, i64* %t184
  %t185 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t186 = insertvalue %InstructionParseResult %t185, i1 1, 1
  %t187 = insertvalue %InstructionParseResult %t186, i1 0, 2
  ret %InstructionParseResult %t187
merge33:
  br label %merge31
merge31:
  %s188 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.188, i32 0, i32 0
  %t189 = call i1 @starts_with(i8* %line, i8* %s188)
  br i1 %t189, label %then34, label %merge35
then34:
  %s190 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.190, i32 0, i32 0
  %t191 = call i8* @strip_prefix(i8* %line, i8* %s190)
  %t192 = call i8* @trim_text(i8* %t191)
  store i8* %t192, i8** %l9
  store i1 0, i1* %l10
  %t193 = load i8*, i8** %l9
  %s194 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.194, i32 0, i32 0
  %t195 = call i1 @starts_with(i8* %t193, i8* %s194)
  %t196 = load i8*, i8** %l9
  %t197 = load i1, i1* %l10
  br i1 %t195, label %then36, label %merge37
then36:
  store i1 1, i1* %l10
  %t198 = load i8*, i8** %l9
  %s199 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.199, i32 0, i32 0
  %t200 = call i8* @strip_prefix(i8* %t198, i8* %s199)
  %t201 = call i8* @trim_text(i8* %t200)
  store i8* %t201, i8** %l9
  br label %merge37
merge37:
  %t202 = phi i1 [ 1, %then36 ], [ %t197, %then34 ]
  %t203 = phi i8* [ %t201, %then36 ], [ %t196, %then34 ]
  store i1 %t202, i1* %l10
  store i8* %t203, i8** %l9
  %t204 = load i8*, i8** %l9
  %t205 = call %BindingComponents @parse_binding_components(i8* %t204)
  store %BindingComponents %t205, %BindingComponents* %l11
  %t206 = alloca %NativeInstruction
  %t207 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 0
  store i32 2, i32* %t207
  %t208 = load %BindingComponents, %BindingComponents* %l11
  %t209 = extractvalue %BindingComponents %t208, 0
  %t210 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t211 = bitcast [48 x i8]* %t210 to i8*
  %t212 = bitcast i8* %t211 to i8**
  store i8* %t209, i8** %t212
  %t213 = load i1, i1* %l10
  %t214 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t215 = bitcast [48 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to i1*
  store i1 %t213, i1* %t217
  %t218 = load %BindingComponents, %BindingComponents* %l11
  %t219 = extractvalue %BindingComponents %t218, 1
  %t220 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t221 = bitcast [48 x i8]* %t220 to i8*
  %t222 = getelementptr inbounds i8, i8* %t221, i64 16
  %t223 = bitcast i8* %t222 to i8**
  store i8* %t219, i8** %t223
  %t224 = load %BindingComponents, %BindingComponents* %l11
  %t225 = extractvalue %BindingComponents %t224, 2
  %t226 = call double @maybe_trim_trailing(i8* %t225)
  %t227 = call noalias i8* @malloc(i64 8)
  %t228 = bitcast i8* %t227 to double*
  store double %t226, double* %t228
  %t229 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t230 = bitcast [48 x i8]* %t229 to i8*
  %t231 = getelementptr inbounds i8, i8* %t230, i64 24
  %t232 = bitcast i8* %t231 to i8**
  store i8* %t227, i8** %t232
  %t233 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t234 = bitcast [48 x i8]* %t233 to i8*
  %t235 = getelementptr inbounds i8, i8* %t234, i64 32
  %t236 = bitcast i8* %t235 to i8**
  store i8* %span, i8** %t236
  %t237 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t206, i32 0, i32 1
  %t238 = bitcast [48 x i8]* %t237 to i8*
  %t239 = getelementptr inbounds i8, i8* %t238, i64 40
  %t240 = bitcast i8* %t239 to i8**
  store i8* %value_span, i8** %t240
  %t241 = load %NativeInstruction, %NativeInstruction* %t206
  %t242 = alloca [1 x %NativeInstruction]
  %t243 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t242, i32 0, i32 0
  %t244 = getelementptr %NativeInstruction, %NativeInstruction* %t243, i64 0
  store %NativeInstruction %t241, %NativeInstruction* %t244
  %t245 = alloca { %NativeInstruction*, i64 }
  %t246 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t245, i32 0, i32 0
  store %NativeInstruction* %t243, %NativeInstruction** %t246
  %t247 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t245, i32 0, i32 1
  store i64 1, i64* %t247
  %t248 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t249 = insertvalue %InstructionParseResult %t248, i1 1, 1
  %t250 = insertvalue %InstructionParseResult %t249, i1 1, 2
  ret %InstructionParseResult %t250
merge35:
  %s251 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.251, i32 0, i32 0
  %t252 = call i1 @starts_with(i8* %line, i8* %s251)
  br i1 %t252, label %then38, label %merge39
then38:
  %t253 = alloca %NativeInstruction
  %t254 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t253, i32 0, i32 0
  store i32 1, i32* %t254
  %s255 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.255, i32 0, i32 0
  %t256 = call i8* @strip_prefix(i8* %line, i8* %s255)
  %t257 = call i8* @trim_text(i8* %t256)
  %t258 = call i8* @trim_trailing_delimiters(i8* %t257)
  %t259 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t253, i32 0, i32 1
  %t260 = bitcast [16 x i8]* %t259 to i8*
  %t261 = bitcast i8* %t260 to i8**
  store i8* %t258, i8** %t261
  %t262 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t253, i32 0, i32 1
  %t263 = bitcast [16 x i8]* %t262 to i8*
  %t264 = getelementptr inbounds i8, i8* %t263, i64 8
  %t265 = bitcast i8* %t264 to i8**
  store i8* %span, i8** %t265
  %t266 = load %NativeInstruction, %NativeInstruction* %t253
  %t267 = alloca [1 x %NativeInstruction]
  %t268 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t267, i32 0, i32 0
  %t269 = getelementptr %NativeInstruction, %NativeInstruction* %t268, i64 0
  store %NativeInstruction %t266, %NativeInstruction* %t269
  %t270 = alloca { %NativeInstruction*, i64 }
  %t271 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t270, i32 0, i32 0
  store %NativeInstruction* %t268, %NativeInstruction** %t271
  %t272 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t270, i32 0, i32 1
  store i64 1, i64* %t272
  %t273 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t274 = insertvalue %InstructionParseResult %t273, i1 1, 1
  %t275 = insertvalue %InstructionParseResult %t274, i1 0, 2
  ret %InstructionParseResult %t275
merge39:
  %t276 = alloca %NativeInstruction
  %t277 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t276, i32 0, i32 0
  store i32 16, i32* %t277
  %t278 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t276, i32 0, i32 1
  %t279 = bitcast [8 x i8]* %t278 to i8*
  %t280 = bitcast i8* %t279 to i8**
  store i8* %line, i8** %t280
  %t281 = load %NativeInstruction, %NativeInstruction* %t276
  %t282 = alloca [1 x %NativeInstruction]
  %t283 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t282, i32 0, i32 0
  %t284 = getelementptr %NativeInstruction, %NativeInstruction* %t283, i64 0
  store %NativeInstruction %t281, %NativeInstruction* %t284
  %t285 = alloca { %NativeInstruction*, i64 }
  %t286 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t285, i32 0, i32 0
  store %NativeInstruction* %t283, %NativeInstruction** %t286
  %t287 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t285, i32 0, i32 1
  store i64 1, i64* %t287
  %t288 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t289 = insertvalue %InstructionParseResult %t288, i1 0, 1
  %t290 = insertvalue %InstructionParseResult %t289, i1 0, 2
  ret %InstructionParseResult %t290
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
  %t37 = alloca %NativeInstruction
  %t38 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t37, i32 0, i32 0
  store i32 13, i32* %t38
  %t39 = load %CaseComponents, %CaseComponents* %l4
  %t40 = extractvalue %CaseComponents %t39, 0
  %t41 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t37, i32 0, i32 1
  %t42 = bitcast [16 x i8]* %t41 to i8*
  %t43 = bitcast i8* %t42 to i8**
  store i8* %t40, i8** %t43
  %t44 = load %CaseComponents, %CaseComponents* %l4
  %t45 = extractvalue %CaseComponents %t44, 1
  %t46 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t37, i32 0, i32 1
  %t47 = bitcast [16 x i8]* %t46 to i8*
  %t48 = getelementptr inbounds i8, i8* %t47, i64 8
  %t49 = bitcast i8* %t48 to i8**
  store i8* %t45, i8** %t49
  %t50 = load %NativeInstruction, %NativeInstruction* %t37
  %t51 = alloca [1 x %NativeInstruction]
  %t52 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t51, i32 0, i32 0
  %t53 = getelementptr %NativeInstruction, %NativeInstruction* %t52, i64 0
  store %NativeInstruction %t50, %NativeInstruction* %t53
  %t54 = alloca { %NativeInstruction*, i64 }
  %t55 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t54, i32 0, i32 0
  store %NativeInstruction* %t52, %NativeInstruction** %t55
  %t56 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t54, i32 0, i32 1
  store i64 1, i64* %t56
  %t57 = call double @instructionsconcat({ %NativeInstruction*, i64 }* %t54)
  store { %NativeInstruction*, i64 }* null, { %NativeInstruction*, i64 }** %l5
  %t58 = load double, double* %l3
  %t59 = load double, double* %l3
  %t60 = call %NativeInstruction @parse_inline_case_body_instruction(i8* null)
  store %NativeInstruction %t60, %NativeInstruction* %l6
  %t61 = load %NativeInstruction, %NativeInstruction* %l6
  %t62 = alloca [1 x %NativeInstruction]
  %t63 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t62, i32 0, i32 0
  %t64 = getelementptr %NativeInstruction, %NativeInstruction* %t63, i64 0
  store %NativeInstruction %t61, %NativeInstruction* %t64
  %t65 = alloca { %NativeInstruction*, i64 }
  %t66 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t65, i32 0, i32 0
  store %NativeInstruction* %t63, %NativeInstruction** %t66
  %t67 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t65, i32 0, i32 1
  store i64 1, i64* %t67
  %t68 = call double @instructionsconcat({ %NativeInstruction*, i64 }* %t65)
  store { %NativeInstruction*, i64 }* null, { %NativeInstruction*, i64 }** %l5
  %t69 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t69
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
  %t18 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t19 = extractvalue %StructHeaderParse %t18, 2
  %t20 = call double @diagnosticsconcat({ i8**, i64 }* %t19)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t21 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t22 = extractvalue %StructHeaderParse %t21, 0
  store i8* %t22, i8** %l4
  %t23 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t24 = extractvalue %StructHeaderParse %t23, 1
  store { i8**, i64 }* %t24, { i8**, i64 }** %l5
  %t25 = load i8*, i8** %l4
  %t26 = alloca [0 x %NativeStructField]
  %t27 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* %t26, i32 0, i32 0
  %t28 = alloca { %NativeStructField*, i64 }
  %t29 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t28, i32 0, i32 0
  store %NativeStructField* %t27, %NativeStructField** %t29
  %t30 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeStructField*, i64 }* %t28, { %NativeStructField*, i64 }** %l6
  %t31 = alloca [0 x %NativeFunction]
  %t32 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t31, i32 0, i32 0
  %t33 = alloca { %NativeFunction*, i64 }
  %t34 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t33, i32 0, i32 0
  store %NativeFunction* %t32, %NativeFunction** %t34
  %t35 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %NativeFunction*, i64 }* %t33, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t36 = alloca [0 x %NativeStructLayoutField]
  %t37 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t36, i32 0, i32 0
  %t38 = alloca { %NativeStructLayoutField*, i64 }
  %t39 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t38, i32 0, i32 0
  store %NativeStructLayoutField* %t37, %NativeStructLayoutField** %t39
  %t40 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { %NativeStructLayoutField*, i64 }* %t38, { %NativeStructLayoutField*, i64 }** %l11
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l12
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %start_index, %t43
  store double %t44, double* %l16
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l2
  %t48 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t49 = load i8*, i8** %l4
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t51 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t52 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t53 = load i8*, i8** %l8
  %t54 = load i8*, i8** %l9
  %t55 = load i8*, i8** %l10
  %t56 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t57 = load double, double* %l12
  %t58 = load double, double* %l13
  %t59 = load i1, i1* %l14
  %t60 = load i1, i1* %l15
  %t61 = load double, double* %l16
  br label %loop.header0
loop.header0:
  %t904 = phi { i8**, i64 }* [ %t45, %entry ], [ %t893, %loop.latch2 ]
  %t905 = phi { %NativeFunction*, i64 }* [ %t52, %entry ], [ %t894, %loop.latch2 ]
  %t906 = phi i8* [ %t53, %entry ], [ %t895, %loop.latch2 ]
  %t907 = phi i8* [ %t54, %entry ], [ %t896, %loop.latch2 ]
  %t908 = phi i8* [ %t55, %entry ], [ %t897, %loop.latch2 ]
  %t909 = phi double [ %t61, %entry ], [ %t898, %loop.latch2 ]
  %t910 = phi double [ %t57, %entry ], [ %t899, %loop.latch2 ]
  %t911 = phi double [ %t58, %entry ], [ %t900, %loop.latch2 ]
  %t912 = phi i1 [ %t59, %entry ], [ %t901, %loop.latch2 ]
  %t913 = phi { %NativeStructLayoutField*, i64 }* [ %t56, %entry ], [ %t902, %loop.latch2 ]
  %t914 = phi i1 [ %t60, %entry ], [ %t903, %loop.latch2 ]
  store { i8**, i64 }* %t904, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t905, { %NativeFunction*, i64 }** %l7
  store i8* %t906, i8** %l8
  store i8* %t907, i8** %l9
  store i8* %t908, i8** %l10
  store double %t909, double* %l16
  store double %t910, double* %l12
  store double %t911, double* %l13
  store i1 %t912, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t913, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t914, i1* %l15
  br label %loop.body1
loop.body1:
  %t62 = load double, double* %l16
  %t63 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t64 = extractvalue { i8**, i64 } %t63, 1
  %t65 = sitofp i64 %t64 to double
  %t66 = fcmp oge double %t62, %t65
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load i8*, i8** %l2
  %t70 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t71 = load i8*, i8** %l4
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t73 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t74 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t75 = load i8*, i8** %l8
  %t76 = load i8*, i8** %l9
  %t77 = load i8*, i8** %l10
  %t78 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t79 = load double, double* %l12
  %t80 = load double, double* %l13
  %t81 = load i1, i1* %l14
  %t82 = load i1, i1* %l15
  %t83 = load double, double* %l16
  br i1 %t66, label %then4, label %merge5
then4:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s85 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.85, i32 0, i32 0
  %t86 = load i8*, i8** %l4
  %t87 = add i8* %s85, %t86
  %t88 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t84, i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  store i8* null, i8** %l17
  %t89 = load i1, i1* %l14
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load i8*, i8** %l2
  %t93 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t94 = load i8*, i8** %l4
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t97 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t98 = load i8*, i8** %l8
  %t99 = load i8*, i8** %l9
  %t100 = load i8*, i8** %l10
  %t101 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t102 = load double, double* %l12
  %t103 = load double, double* %l13
  %t104 = load i1, i1* %l14
  %t105 = load i1, i1* %l15
  %t106 = load double, double* %l16
  %t107 = load i8*, i8** %l17
  br i1 %t89, label %then6, label %merge7
then6:
  %t108 = load double, double* %l12
  %t109 = insertvalue %NativeStructLayout undef, double %t108, 0
  %t110 = load double, double* %l13
  %t111 = insertvalue %NativeStructLayout %t109, double %t110, 1
  %t112 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t113 = insertvalue %NativeStructLayout %t111, { i8**, i64 }* null, 2
  store i8* null, i8** %l17
  br label %merge7
merge7:
  %t114 = phi i8* [ null, %then6 ], [ %t107, %then4 ]
  store i8* %t114, i8** %l17
  %t115 = load i8*, i8** %l4
  %t116 = insertvalue %NativeStruct undef, i8* %t115, 0
  %t117 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t118 = insertvalue %NativeStruct %t116, { i8**, i64 }* null, 1
  %t119 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t120 = insertvalue %NativeStruct %t118, { i8**, i64 }* null, 2
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t122 = insertvalue %NativeStruct %t120, { i8**, i64 }* %t121, 3
  %t123 = load i8*, i8** %l17
  %t124 = insertvalue %NativeStruct %t122, i8* %t123, 4
  %t125 = insertvalue %StructParseResult undef, i8* null, 0
  %t126 = load double, double* %l16
  %t127 = insertvalue %StructParseResult %t125, double %t126, 1
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = insertvalue %StructParseResult %t127, { i8**, i64 }* %t128, 2
  ret %StructParseResult %t129
merge5:
  %t130 = load double, double* %l16
  %t131 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t132 = extractvalue { i8**, i64 } %t131, 0
  %t133 = extractvalue { i8**, i64 } %t131, 1
  %t134 = icmp uge i64 %t130, %t133
  ; bounds check: %t134 (if true, out of bounds)
  %t135 = getelementptr i8*, i8** %t132, i64 %t130
  %t136 = load i8*, i8** %t135
  %t137 = call i8* @trim_text(i8* %t136)
  store i8* %t137, i8** %l18
  %t139 = load i8*, i8** %l18
  %t140 = load i8*, i8** %l18
  %s141 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.141, i32 0, i32 0
  %t142 = icmp eq i8* %t140, %s141
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load i8*, i8** %l1
  %t145 = load i8*, i8** %l2
  %t146 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t147 = load i8*, i8** %l4
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t149 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t150 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t151 = load i8*, i8** %l8
  %t152 = load i8*, i8** %l9
  %t153 = load i8*, i8** %l10
  %t154 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t155 = load double, double* %l12
  %t156 = load double, double* %l13
  %t157 = load i1, i1* %l14
  %t158 = load i1, i1* %l15
  %t159 = load double, double* %l16
  %t160 = load i8*, i8** %l18
  br i1 %t142, label %then8, label %merge9
then8:
  %t161 = load i8*, i8** %l8
  %t162 = icmp ne i8* %t161, null
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = load i8*, i8** %l1
  %t165 = load i8*, i8** %l2
  %t166 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t167 = load i8*, i8** %l4
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t169 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t170 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t171 = load i8*, i8** %l8
  %t172 = load i8*, i8** %l9
  %t173 = load i8*, i8** %l10
  %t174 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t175 = load double, double* %l12
  %t176 = load double, double* %l13
  %t177 = load i1, i1* %l14
  %t178 = load i1, i1* %l15
  %t179 = load double, double* %l16
  %t180 = load i8*, i8** %l18
  br i1 %t162, label %then10, label %merge11
then10:
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s182 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.182, i32 0, i32 0
  %t183 = load i8*, i8** %l4
  %t184 = add i8* %s182, %t183
  %t185 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t181, i8* %t184)
  store { i8**, i64 }* %t185, { i8**, i64 }** %l0
  %t186 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t187 = load i8*, i8** %l8
  %t188 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t186, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t188, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  br label %merge11
merge11:
  %t189 = phi { i8**, i64 }* [ %t185, %then10 ], [ %t163, %then8 ]
  %t190 = phi { %NativeFunction*, i64 }* [ %t188, %then10 ], [ %t170, %then8 ]
  %t191 = phi i8* [ null, %then10 ], [ %t171, %then8 ]
  %t192 = phi i8* [ null, %then10 ], [ %t172, %then8 ]
  %t193 = phi i8* [ null, %then10 ], [ %t173, %then8 ]
  store { i8**, i64 }* %t189, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t190, { %NativeFunction*, i64 }** %l7
  store i8* %t191, i8** %l8
  store i8* %t192, i8** %l9
  store i8* %t193, i8** %l10
  %t194 = load double, double* %l16
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l16
  br label %afterloop3
merge9:
  %t197 = load i8*, i8** %l8
  %t198 = icmp ne i8* %t197, null
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t200 = load i8*, i8** %l1
  %t201 = load i8*, i8** %l2
  %t202 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t203 = load i8*, i8** %l4
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t205 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t206 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t207 = load i8*, i8** %l8
  %t208 = load i8*, i8** %l9
  %t209 = load i8*, i8** %l10
  %t210 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t211 = load double, double* %l12
  %t212 = load double, double* %l13
  %t213 = load i1, i1* %l14
  %t214 = load i1, i1* %l15
  %t215 = load double, double* %l16
  %t216 = load i8*, i8** %l18
  br i1 %t198, label %then12, label %merge13
then12:
  %t217 = load i8*, i8** %l18
  %s218 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.218, i32 0, i32 0
  %t219 = icmp eq i8* %t217, %s218
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load i8*, i8** %l1
  %t222 = load i8*, i8** %l2
  %t223 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t224 = load i8*, i8** %l4
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t226 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t227 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t228 = load i8*, i8** %l8
  %t229 = load i8*, i8** %l9
  %t230 = load i8*, i8** %l10
  %t231 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t232 = load double, double* %l12
  %t233 = load double, double* %l13
  %t234 = load i1, i1* %l14
  %t235 = load i1, i1* %l15
  %t236 = load double, double* %l16
  %t237 = load i8*, i8** %l18
  br i1 %t219, label %then14, label %merge15
then14:
  %t238 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t239 = load i8*, i8** %l8
  %t240 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t238, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t240, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t241 = load double, double* %l16
  %t242 = sitofp i64 1 to double
  %t243 = fadd double %t241, %t242
  store double %t243, double* %l16
  br label %loop.latch2
merge15:
  %t244 = load i8*, i8** %l18
  %s245 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.245, i32 0, i32 0
  %t246 = call i1 @starts_with(i8* %t244, i8* %s245)
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t248 = load i8*, i8** %l1
  %t249 = load i8*, i8** %l2
  %t250 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t251 = load i8*, i8** %l4
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t253 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t254 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t255 = load i8*, i8** %l8
  %t256 = load i8*, i8** %l9
  %t257 = load i8*, i8** %l10
  %t258 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t259 = load double, double* %l12
  %t260 = load double, double* %l13
  %t261 = load i1, i1* %l14
  %t262 = load i1, i1* %l15
  %t263 = load double, double* %l16
  %t264 = load i8*, i8** %l18
  br i1 %t246, label %then16, label %merge17
then16:
  %t265 = load i8*, i8** %l8
  %t266 = load i8*, i8** %l18
  %s267 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.267, i32 0, i32 0
  %t268 = call i8* @strip_prefix(i8* %t266, i8* %s267)
  %t269 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t268)
  store i8* null, i8** %l8
  %t270 = load double, double* %l16
  %t271 = sitofp i64 1 to double
  %t272 = fadd double %t270, %t271
  store double %t272, double* %l16
  br label %loop.latch2
merge17:
  %t273 = load i8*, i8** %l18
  %s274 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.274, i32 0, i32 0
  %t275 = call i1 @starts_with(i8* %t273, i8* %s274)
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = load i8*, i8** %l1
  %t278 = load i8*, i8** %l2
  %t279 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t280 = load i8*, i8** %l4
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t282 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t283 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t284 = load i8*, i8** %l8
  %t285 = load i8*, i8** %l9
  %t286 = load i8*, i8** %l10
  %t287 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t288 = load double, double* %l12
  %t289 = load double, double* %l13
  %t290 = load i1, i1* %l14
  %t291 = load i1, i1* %l15
  %t292 = load double, double* %l16
  %t293 = load i8*, i8** %l18
  br i1 %t275, label %then18, label %merge19
then18:
  %t294 = load i8*, i8** %l18
  %s295 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.295, i32 0, i32 0
  %t296 = call i8* @strip_prefix(i8* %t294, i8* %s295)
  %t297 = load i8*, i8** %l9
  %t298 = call double @parse_parameter_entry(i8* %t296, i8* %t297)
  store double %t298, double* %l19
  %t299 = load double, double* %l19
  store i8* null, i8** %l9
  %t300 = load double, double* %l16
  %t301 = sitofp i64 1 to double
  %t302 = fadd double %t300, %t301
  store double %t302, double* %l16
  br label %loop.latch2
merge19:
  %t303 = load i8*, i8** %l18
  %s304 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.304, i32 0, i32 0
  %t305 = call i1 @starts_with(i8* %t303, i8* %s304)
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t307 = load i8*, i8** %l1
  %t308 = load i8*, i8** %l2
  %t309 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t310 = load i8*, i8** %l4
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t312 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t313 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t314 = load i8*, i8** %l8
  %t315 = load i8*, i8** %l9
  %t316 = load i8*, i8** %l10
  %t317 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t318 = load double, double* %l12
  %t319 = load double, double* %l13
  %t320 = load i1, i1* %l14
  %t321 = load i1, i1* %l15
  %t322 = load double, double* %l16
  %t323 = load i8*, i8** %l18
  br i1 %t305, label %then20, label %merge21
then20:
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s325 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.325, i32 0, i32 0
  %t326 = load i8*, i8** %l4
  %t327 = add i8* %s325, %t326
  %t328 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t324, i8* %t327)
  store { i8**, i64 }* %t328, { i8**, i64 }** %l0
  %t329 = load double, double* %l16
  %t330 = sitofp i64 1 to double
  %t331 = fadd double %t329, %t330
  store double %t331, double* %l16
  br label %loop.latch2
merge21:
  %t332 = load i8*, i8** %l18
  %s333 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.333, i32 0, i32 0
  %t334 = call i1 @starts_with(i8* %t332, i8* %s333)
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t336 = load i8*, i8** %l1
  %t337 = load i8*, i8** %l2
  %t338 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t339 = load i8*, i8** %l4
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t341 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t342 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t343 = load i8*, i8** %l8
  %t344 = load i8*, i8** %l9
  %t345 = load i8*, i8** %l10
  %t346 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t347 = load double, double* %l12
  %t348 = load double, double* %l13
  %t349 = load i1, i1* %l14
  %t350 = load i1, i1* %l15
  %t351 = load double, double* %l16
  %t352 = load i8*, i8** %l18
  br i1 %t334, label %then22, label %merge23
then22:
  %t353 = load i8*, i8** %l18
  %s354 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.354, i32 0, i32 0
  %t355 = call i8* @strip_prefix(i8* %t353, i8* %s354)
  %t356 = call double @parse_source_span(i8* %t355)
  store double %t356, double* %l20
  %t357 = load double, double* %l20
  %t358 = load double, double* %l16
  %t359 = sitofp i64 1 to double
  %t360 = fadd double %t358, %t359
  store double %t360, double* %l16
  br label %loop.latch2
merge23:
  %t361 = load i8*, i8** %l18
  %t362 = load i8*, i8** %l18
  %t363 = load i8*, i8** %l9
  %t364 = load i8*, i8** %l10
  %t365 = call %InstructionParseResult @parse_instruction(i8* %t362, i8* %t363, i8* %t364)
  store %InstructionParseResult %t365, %InstructionParseResult* %l21
  %t366 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t367 = extractvalue %InstructionParseResult %t366, 1
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t369 = load i8*, i8** %l1
  %t370 = load i8*, i8** %l2
  %t371 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t372 = load i8*, i8** %l4
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t374 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t375 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t376 = load i8*, i8** %l8
  %t377 = load i8*, i8** %l9
  %t378 = load i8*, i8** %l10
  %t379 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t380 = load double, double* %l12
  %t381 = load double, double* %l13
  %t382 = load i1, i1* %l14
  %t383 = load i1, i1* %l15
  %t384 = load double, double* %l16
  %t385 = load i8*, i8** %l18
  %t386 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t367, label %then24, label %else25
then24:
  store i8* null, i8** %l9
  br label %merge26
else25:
  %t387 = load i8*, i8** %l9
  %t388 = icmp ne i8* %t387, null
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t390 = load i8*, i8** %l1
  %t391 = load i8*, i8** %l2
  %t392 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t393 = load i8*, i8** %l4
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t395 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t396 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t397 = load i8*, i8** %l8
  %t398 = load i8*, i8** %l9
  %t399 = load i8*, i8** %l10
  %t400 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t401 = load double, double* %l12
  %t402 = load double, double* %l13
  %t403 = load i1, i1* %l14
  %t404 = load i1, i1* %l15
  %t405 = load double, double* %l16
  %t406 = load i8*, i8** %l18
  %t407 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t388, label %then27, label %merge28
then27:
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s409 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.409, i32 0, i32 0
  %t410 = load i8*, i8** %l18
  %t411 = add i8* %s409, %t410
  %t412 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t408, i8* %t411)
  store { i8**, i64 }* %t412, { i8**, i64 }** %l0
  store i8* null, i8** %l9
  br label %merge28
merge28:
  %t413 = phi { i8**, i64 }* [ %t412, %then27 ], [ %t389, %else25 ]
  %t414 = phi i8* [ null, %then27 ], [ %t398, %else25 ]
  store { i8**, i64 }* %t413, { i8**, i64 }** %l0
  store i8* %t414, i8** %l9
  br label %merge26
merge26:
  %t415 = phi i8* [ null, %then24 ], [ null, %else25 ]
  %t416 = phi { i8**, i64 }* [ %t368, %then24 ], [ %t412, %else25 ]
  store i8* %t415, i8** %l9
  store { i8**, i64 }* %t416, { i8**, i64 }** %l0
  %t417 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t418 = extractvalue %InstructionParseResult %t417, 2
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t420 = load i8*, i8** %l1
  %t421 = load i8*, i8** %l2
  %t422 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t423 = load i8*, i8** %l4
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t425 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t426 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t427 = load i8*, i8** %l8
  %t428 = load i8*, i8** %l9
  %t429 = load i8*, i8** %l10
  %t430 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t431 = load double, double* %l12
  %t432 = load double, double* %l13
  %t433 = load i1, i1* %l14
  %t434 = load i1, i1* %l15
  %t435 = load double, double* %l16
  %t436 = load i8*, i8** %l18
  %t437 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t418, label %then29, label %else30
then29:
  store i8* null, i8** %l10
  br label %merge31
else30:
  %t438 = load i8*, i8** %l10
  %t439 = icmp ne i8* %t438, null
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t441 = load i8*, i8** %l1
  %t442 = load i8*, i8** %l2
  %t443 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t444 = load i8*, i8** %l4
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t446 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t447 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t448 = load i8*, i8** %l8
  %t449 = load i8*, i8** %l9
  %t450 = load i8*, i8** %l10
  %t451 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t452 = load double, double* %l12
  %t453 = load double, double* %l13
  %t454 = load i1, i1* %l14
  %t455 = load i1, i1* %l15
  %t456 = load double, double* %l16
  %t457 = load i8*, i8** %l18
  %t458 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t439, label %then32, label %merge33
then32:
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s460 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.460, i32 0, i32 0
  %t461 = load i8*, i8** %l18
  %t462 = add i8* %s460, %t461
  %t463 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t459, i8* %t462)
  store { i8**, i64 }* %t463, { i8**, i64 }** %l0
  store i8* null, i8** %l10
  br label %merge33
merge33:
  %t464 = phi { i8**, i64 }* [ %t463, %then32 ], [ %t440, %else30 ]
  %t465 = phi i8* [ null, %then32 ], [ %t450, %else30 ]
  store { i8**, i64 }* %t464, { i8**, i64 }** %l0
  store i8* %t465, i8** %l10
  br label %merge31
merge31:
  %t466 = phi i8* [ null, %then29 ], [ null, %else30 ]
  %t467 = phi { i8**, i64 }* [ %t419, %then29 ], [ %t463, %else30 ]
  store i8* %t466, i8** %l10
  store { i8**, i64 }* %t467, { i8**, i64 }** %l0
  %t468 = sitofp i64 0 to double
  store double %t468, double* %l22
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t470 = load i8*, i8** %l1
  %t471 = load i8*, i8** %l2
  %t472 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t473 = load i8*, i8** %l4
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t475 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t476 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t477 = load i8*, i8** %l8
  %t478 = load i8*, i8** %l9
  %t479 = load i8*, i8** %l10
  %t480 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t481 = load double, double* %l12
  %t482 = load double, double* %l13
  %t483 = load i1, i1* %l14
  %t484 = load i1, i1* %l15
  %t485 = load double, double* %l16
  %t486 = load i8*, i8** %l18
  %t487 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t488 = load double, double* %l22
  br label %loop.header34
loop.header34:
  %t532 = phi i8* [ %t477, %then12 ], [ %t530, %loop.latch36 ]
  %t533 = phi double [ %t488, %then12 ], [ %t531, %loop.latch36 ]
  store i8* %t532, i8** %l8
  store double %t533, double* %l22
  br label %loop.body35
loop.body35:
  %t489 = load double, double* %l22
  %t490 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t491 = extractvalue %InstructionParseResult %t490, 0
  %t492 = load { i8**, i64 }, { i8**, i64 }* %t491
  %t493 = extractvalue { i8**, i64 } %t492, 1
  %t494 = sitofp i64 %t493 to double
  %t495 = fcmp oge double %t489, %t494
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t497 = load i8*, i8** %l1
  %t498 = load i8*, i8** %l2
  %t499 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t500 = load i8*, i8** %l4
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t502 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t503 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t504 = load i8*, i8** %l8
  %t505 = load i8*, i8** %l9
  %t506 = load i8*, i8** %l10
  %t507 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t508 = load double, double* %l12
  %t509 = load double, double* %l13
  %t510 = load i1, i1* %l14
  %t511 = load i1, i1* %l15
  %t512 = load double, double* %l16
  %t513 = load i8*, i8** %l18
  %t514 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t515 = load double, double* %l22
  br i1 %t495, label %then38, label %merge39
then38:
  br label %afterloop37
merge39:
  %t516 = load i8*, i8** %l8
  %t517 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t518 = extractvalue %InstructionParseResult %t517, 0
  %t519 = load double, double* %l22
  %t520 = load { i8**, i64 }, { i8**, i64 }* %t518
  %t521 = extractvalue { i8**, i64 } %t520, 0
  %t522 = extractvalue { i8**, i64 } %t520, 1
  %t523 = icmp uge i64 %t519, %t522
  ; bounds check: %t523 (if true, out of bounds)
  %t524 = getelementptr i8*, i8** %t521, i64 %t519
  %t525 = load i8*, i8** %t524
  %t526 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t527 = load double, double* %l22
  %t528 = sitofp i64 1 to double
  %t529 = fadd double %t527, %t528
  store double %t529, double* %l22
  br label %loop.latch36
loop.latch36:
  %t530 = load i8*, i8** %l8
  %t531 = load double, double* %l22
  br label %loop.header34
afterloop37:
  %t534 = load double, double* %l16
  %t535 = sitofp i64 1 to double
  %t536 = fadd double %t534, %t535
  store double %t536, double* %l16
  br label %loop.latch2
merge13:
  %t537 = load i8*, i8** %l18
  %s538 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.538, i32 0, i32 0
  %t539 = call i1 @starts_with(i8* %t537, i8* %s538)
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t541 = load i8*, i8** %l1
  %t542 = load i8*, i8** %l2
  %t543 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t544 = load i8*, i8** %l4
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t546 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t547 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t548 = load i8*, i8** %l8
  %t549 = load i8*, i8** %l9
  %t550 = load i8*, i8** %l10
  %t551 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t552 = load double, double* %l12
  %t553 = load double, double* %l13
  %t554 = load i1, i1* %l14
  %t555 = load i1, i1* %l15
  %t556 = load double, double* %l16
  %t557 = load i8*, i8** %l18
  br i1 %t539, label %then40, label %merge41
then40:
  %t558 = load i8*, i8** %l18
  %s559 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.559, i32 0, i32 0
  %t560 = call i8* @strip_prefix(i8* %t558, i8* %s559)
  store i8* %t560, i8** %l23
  %t561 = load i8*, i8** %l23
  %s562 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.562, i32 0, i32 0
  %t563 = call i1 @starts_with(i8* %t561, i8* %s562)
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t565 = load i8*, i8** %l1
  %t566 = load i8*, i8** %l2
  %t567 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t568 = load i8*, i8** %l4
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t570 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t571 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t572 = load i8*, i8** %l8
  %t573 = load i8*, i8** %l9
  %t574 = load i8*, i8** %l10
  %t575 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t576 = load double, double* %l12
  %t577 = load double, double* %l13
  %t578 = load i1, i1* %l14
  %t579 = load i1, i1* %l15
  %t580 = load double, double* %l16
  %t581 = load i8*, i8** %l18
  %t582 = load i8*, i8** %l23
  br i1 %t563, label %then42, label %merge43
then42:
  %t583 = load i8*, i8** %l23
  %s584 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.584, i32 0, i32 0
  %t585 = call i8* @strip_prefix(i8* %t583, i8* %s584)
  %t586 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t585)
  store %StructLayoutHeaderParse %t586, %StructLayoutHeaderParse* %l24
  %t587 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t588 = extractvalue %StructLayoutHeaderParse %t587, 4
  %t589 = call double @diagnosticsconcat({ i8**, i64 }* %t588)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t590 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t591 = extractvalue %StructLayoutHeaderParse %t590, 0
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t593 = load i8*, i8** %l1
  %t594 = load i8*, i8** %l2
  %t595 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t596 = load i8*, i8** %l4
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t598 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t599 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t600 = load i8*, i8** %l8
  %t601 = load i8*, i8** %l9
  %t602 = load i8*, i8** %l10
  %t603 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t604 = load double, double* %l12
  %t605 = load double, double* %l13
  %t606 = load i1, i1* %l14
  %t607 = load i1, i1* %l15
  %t608 = load double, double* %l16
  %t609 = load i8*, i8** %l18
  %t610 = load i8*, i8** %l23
  %t611 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t591, label %then44, label %merge45
then44:
  %t612 = load i1, i1* %l14
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t614 = load i8*, i8** %l1
  %t615 = load i8*, i8** %l2
  %t616 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t617 = load i8*, i8** %l4
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t619 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t620 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t621 = load i8*, i8** %l8
  %t622 = load i8*, i8** %l9
  %t623 = load i8*, i8** %l10
  %t624 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t625 = load double, double* %l12
  %t626 = load double, double* %l13
  %t627 = load i1, i1* %l14
  %t628 = load i1, i1* %l15
  %t629 = load double, double* %l16
  %t630 = load i8*, i8** %l18
  %t631 = load i8*, i8** %l23
  %t632 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t612, label %then46, label %else47
then46:
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s634 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.634, i32 0, i32 0
  %t635 = load i8*, i8** %l4
  %t636 = add i8* %s634, %t635
  %t637 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t633, i8* %t636)
  store { i8**, i64 }* %t637, { i8**, i64 }** %l0
  br label %merge48
else47:
  %t638 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t639 = extractvalue %StructLayoutHeaderParse %t638, 2
  store double %t639, double* %l12
  %t640 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t641 = extractvalue %StructLayoutHeaderParse %t640, 3
  store double %t641, double* %l13
  store i1 1, i1* %l14
  br label %merge48
merge48:
  %t642 = phi { i8**, i64 }* [ %t637, %then46 ], [ %t613, %else47 ]
  %t643 = phi double [ %t625, %then46 ], [ %t639, %else47 ]
  %t644 = phi double [ %t626, %then46 ], [ %t641, %else47 ]
  %t645 = phi i1 [ %t627, %then46 ], [ 1, %else47 ]
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  store double %t643, double* %l12
  store double %t644, double* %l13
  store i1 %t645, i1* %l14
  br label %merge45
merge45:
  %t646 = phi { i8**, i64 }* [ %t637, %then44 ], [ %t592, %then42 ]
  %t647 = phi double [ %t639, %then44 ], [ %t604, %then42 ]
  %t648 = phi double [ %t641, %then44 ], [ %t605, %then42 ]
  %t649 = phi i1 [ 1, %then44 ], [ %t606, %then42 ]
  store { i8**, i64 }* %t646, { i8**, i64 }** %l0
  store double %t647, double* %l12
  store double %t648, double* %l13
  store i1 %t649, i1* %l14
  %t650 = load double, double* %l16
  %t651 = sitofp i64 1 to double
  %t652 = fadd double %t650, %t651
  store double %t652, double* %l16
  br label %loop.latch2
merge43:
  %t653 = load i8*, i8** %l23
  %s654 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.654, i32 0, i32 0
  %t655 = call i1 @starts_with(i8* %t653, i8* %s654)
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t657 = load i8*, i8** %l1
  %t658 = load i8*, i8** %l2
  %t659 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t660 = load i8*, i8** %l4
  %t661 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t662 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t663 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t664 = load i8*, i8** %l8
  %t665 = load i8*, i8** %l9
  %t666 = load i8*, i8** %l10
  %t667 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t668 = load double, double* %l12
  %t669 = load double, double* %l13
  %t670 = load i1, i1* %l14
  %t671 = load i1, i1* %l15
  %t672 = load double, double* %l16
  %t673 = load i8*, i8** %l18
  %t674 = load i8*, i8** %l23
  br i1 %t655, label %then49, label %merge50
then49:
  %t675 = load i8*, i8** %l23
  %s676 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.676, i32 0, i32 0
  %t677 = call i8* @strip_prefix(i8* %t675, i8* %s676)
  %t678 = load i8*, i8** %l4
  %t679 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t677, i8* %t678)
  store %StructLayoutFieldParse %t679, %StructLayoutFieldParse* %l25
  %t680 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t681 = extractvalue %StructLayoutFieldParse %t680, 2
  %t682 = call double @diagnosticsconcat({ i8**, i64 }* %t681)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t683 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t684 = extractvalue %StructLayoutFieldParse %t683, 0
  %t685 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t686 = load i8*, i8** %l1
  %t687 = load i8*, i8** %l2
  %t688 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t689 = load i8*, i8** %l4
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t691 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t692 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t693 = load i8*, i8** %l8
  %t694 = load i8*, i8** %l9
  %t695 = load i8*, i8** %l10
  %t696 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t697 = load double, double* %l12
  %t698 = load double, double* %l13
  %t699 = load i1, i1* %l14
  %t700 = load i1, i1* %l15
  %t701 = load double, double* %l16
  %t702 = load i8*, i8** %l18
  %t703 = load i8*, i8** %l23
  %t704 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t684, label %then51, label %merge52
then51:
  %t705 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t706 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t707 = extractvalue %StructLayoutFieldParse %t706, 1
  %t708 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t705, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t708, { %NativeStructLayoutField*, i64 }** %l11
  %t709 = load i1, i1* %l14
  %t710 = xor i1 %t709, 1
  %t711 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t712 = load i8*, i8** %l1
  %t713 = load i8*, i8** %l2
  %t714 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t715 = load i8*, i8** %l4
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t717 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t718 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t719 = load i8*, i8** %l8
  %t720 = load i8*, i8** %l9
  %t721 = load i8*, i8** %l10
  %t722 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t723 = load double, double* %l12
  %t724 = load double, double* %l13
  %t725 = load i1, i1* %l14
  %t726 = load i1, i1* %l15
  %t727 = load double, double* %l16
  %t728 = load i8*, i8** %l18
  %t729 = load i8*, i8** %l23
  %t730 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t710, label %then53, label %merge54
then53:
  %t731 = load i1, i1* %l15
  %t732 = xor i1 %t731, 1
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
  %t753 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s754 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.754, i32 0, i32 0
  %t755 = load i8*, i8** %l4
  %t756 = add i8* %s754, %t755
  %s757 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.757, i32 0, i32 0
  %t758 = add i8* %t756, %s757
  %t759 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t753, i8* %t758)
  store { i8**, i64 }* %t759, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge56
merge56:
  %t760 = phi { i8**, i64 }* [ %t759, %then55 ], [ %t733, %then53 ]
  %t761 = phi i1 [ 1, %then55 ], [ %t748, %then53 ]
  store { i8**, i64 }* %t760, { i8**, i64 }** %l0
  store i1 %t761, i1* %l15
  br label %merge54
merge54:
  %t762 = phi { i8**, i64 }* [ %t759, %then53 ], [ %t711, %then51 ]
  %t763 = phi i1 [ 1, %then53 ], [ %t726, %then51 ]
  store { i8**, i64 }* %t762, { i8**, i64 }** %l0
  store i1 %t763, i1* %l15
  br label %merge52
merge52:
  %t764 = phi { %NativeStructLayoutField*, i64 }* [ %t708, %then51 ], [ %t696, %then49 ]
  %t765 = phi { i8**, i64 }* [ %t759, %then51 ], [ %t685, %then49 ]
  %t766 = phi i1 [ 1, %then51 ], [ %t700, %then49 ]
  store { %NativeStructLayoutField*, i64 }* %t764, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t765, { i8**, i64 }** %l0
  store i1 %t766, i1* %l15
  %t767 = load double, double* %l16
  %t768 = sitofp i64 1 to double
  %t769 = fadd double %t767, %t768
  store double %t769, double* %l16
  br label %loop.latch2
merge50:
  %t770 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s771 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.771, i32 0, i32 0
  %t772 = load i8*, i8** %l18
  %t773 = add i8* %s771, %t772
  %t774 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t770, i8* %t773)
  store { i8**, i64 }* %t774, { i8**, i64 }** %l0
  %t775 = load double, double* %l16
  %t776 = sitofp i64 1 to double
  %t777 = fadd double %t775, %t776
  store double %t777, double* %l16
  br label %loop.latch2
merge41:
  %t778 = load i8*, i8** %l18
  %s779 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.779, i32 0, i32 0
  %t780 = icmp eq i8* %t778, %s779
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
  br i1 %t780, label %then57, label %merge58
then57:
  %t799 = load double, double* %l16
  %t800 = sitofp i64 1 to double
  %t801 = fadd double %t799, %t800
  store double %t801, double* %l16
  br label %loop.latch2
merge58:
  %t802 = load i8*, i8** %l18
  %s803 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.803, i32 0, i32 0
  %t804 = call i1 @starts_with(i8* %t802, i8* %s803)
  %t805 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t806 = load i8*, i8** %l1
  %t807 = load i8*, i8** %l2
  %t808 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t809 = load i8*, i8** %l4
  %t810 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t811 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t812 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t813 = load i8*, i8** %l8
  %t814 = load i8*, i8** %l9
  %t815 = load i8*, i8** %l10
  %t816 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t817 = load double, double* %l12
  %t818 = load double, double* %l13
  %t819 = load i1, i1* %l14
  %t820 = load i1, i1* %l15
  %t821 = load double, double* %l16
  %t822 = load i8*, i8** %l18
  br i1 %t804, label %then59, label %merge60
then59:
  %t823 = load i8*, i8** %l18
  %s824 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.824, i32 0, i32 0
  %t825 = call i8* @strip_prefix(i8* %t823, i8* %s824)
  %t826 = call double @parse_struct_field_line(i8* %t825)
  store double %t826, double* %l26
  %t827 = load double, double* %l26
  %t828 = load double, double* %l16
  %t829 = sitofp i64 1 to double
  %t830 = fadd double %t828, %t829
  store double %t830, double* %l16
  br label %loop.latch2
merge60:
  %t831 = load i8*, i8** %l18
  %s832 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.832, i32 0, i32 0
  %t833 = call i1 @starts_with(i8* %t831, i8* %s832)
  %t834 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t835 = load i8*, i8** %l1
  %t836 = load i8*, i8** %l2
  %t837 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t838 = load i8*, i8** %l4
  %t839 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t840 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t841 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t842 = load i8*, i8** %l8
  %t843 = load i8*, i8** %l9
  %t844 = load i8*, i8** %l10
  %t845 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t846 = load double, double* %l12
  %t847 = load double, double* %l13
  %t848 = load i1, i1* %l14
  %t849 = load i1, i1* %l15
  %t850 = load double, double* %l16
  %t851 = load i8*, i8** %l18
  br i1 %t833, label %then61, label %merge62
then61:
  %t852 = load i8*, i8** %l8
  %t853 = icmp ne i8* %t852, null
  %t854 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t855 = load i8*, i8** %l1
  %t856 = load i8*, i8** %l2
  %t857 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t858 = load i8*, i8** %l4
  %t859 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t860 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t861 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t862 = load i8*, i8** %l8
  %t863 = load i8*, i8** %l9
  %t864 = load i8*, i8** %l10
  %t865 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t866 = load double, double* %l12
  %t867 = load double, double* %l13
  %t868 = load i1, i1* %l14
  %t869 = load i1, i1* %l15
  %t870 = load double, double* %l16
  %t871 = load i8*, i8** %l18
  br i1 %t853, label %then63, label %merge64
then63:
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s873 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.873, i32 0, i32 0
  %t874 = load i8*, i8** %l4
  %t875 = add i8* %s873, %t874
  %t876 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t872, i8* %t875)
  store { i8**, i64 }* %t876, { i8**, i64 }** %l0
  br label %merge64
merge64:
  %t877 = phi { i8**, i64 }* [ %t876, %then63 ], [ %t854, %then61 ]
  store { i8**, i64 }* %t877, { i8**, i64 }** %l0
  %t878 = load i8*, i8** %l18
  %s879 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.879, i32 0, i32 0
  %t880 = call i8* @strip_prefix(i8* %t878, i8* %s879)
  %t881 = call i8* @parse_function_name(i8* %t880)
  store i8* %t881, i8** %l27
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t882 = load double, double* %l16
  %t883 = sitofp i64 1 to double
  %t884 = fadd double %t882, %t883
  store double %t884, double* %l16
  br label %loop.latch2
merge62:
  %t885 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s886 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.886, i32 0, i32 0
  %t887 = load i8*, i8** %l18
  %t888 = add i8* %s886, %t887
  %t889 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t885, i8* %t888)
  store { i8**, i64 }* %t889, { i8**, i64 }** %l0
  %t890 = load double, double* %l16
  %t891 = sitofp i64 1 to double
  %t892 = fadd double %t890, %t891
  store double %t892, double* %l16
  br label %loop.latch2
loop.latch2:
  %t893 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t894 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t895 = load i8*, i8** %l8
  %t896 = load i8*, i8** %l9
  %t897 = load i8*, i8** %l10
  %t898 = load double, double* %l16
  %t899 = load double, double* %l12
  %t900 = load double, double* %l13
  %t901 = load i1, i1* %l14
  %t902 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t903 = load i1, i1* %l15
  br label %loop.header0
afterloop3:
  store i8* null, i8** %l28
  %t915 = load i1, i1* %l14
  %t916 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t917 = load i8*, i8** %l1
  %t918 = load i8*, i8** %l2
  %t919 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t920 = load i8*, i8** %l4
  %t921 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t922 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t923 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t924 = load i8*, i8** %l8
  %t925 = load i8*, i8** %l9
  %t926 = load i8*, i8** %l10
  %t927 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t928 = load double, double* %l12
  %t929 = load double, double* %l13
  %t930 = load i1, i1* %l14
  %t931 = load i1, i1* %l15
  %t932 = load double, double* %l16
  %t933 = load i8*, i8** %l28
  br i1 %t915, label %then65, label %merge66
then65:
  %t934 = load double, double* %l12
  %t935 = insertvalue %NativeStructLayout undef, double %t934, 0
  %t936 = load double, double* %l13
  %t937 = insertvalue %NativeStructLayout %t935, double %t936, 1
  %t938 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t939 = insertvalue %NativeStructLayout %t937, { i8**, i64 }* null, 2
  store i8* null, i8** %l28
  br label %merge66
merge66:
  %t940 = phi i8* [ null, %then65 ], [ %t933, %entry ]
  store i8* %t940, i8** %l28
  %t941 = load i8*, i8** %l4
  %t942 = insertvalue %NativeStruct undef, i8* %t941, 0
  %t943 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t944 = insertvalue %NativeStruct %t942, { i8**, i64 }* null, 1
  %t945 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t946 = insertvalue %NativeStruct %t944, { i8**, i64 }* null, 2
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t948 = insertvalue %NativeStruct %t946, { i8**, i64 }* %t947, 3
  %t949 = load i8*, i8** %l28
  %t950 = insertvalue %NativeStruct %t948, i8* %t949, 4
  %t951 = insertvalue %StructParseResult undef, i8* null, 0
  %t952 = load double, double* %l16
  %t953 = insertvalue %StructParseResult %t951, double %t952, 1
  %t954 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t955 = insertvalue %StructParseResult %t953, { i8**, i64 }* %t954, 2
  ret %StructParseResult %t955
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
  %t18 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t19 = extractvalue %InterfaceHeaderParse %t18, 2
  %t20 = call double @diagnosticsconcat({ i8**, i64 }* %t19)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t21 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t22 = extractvalue %InterfaceHeaderParse %t21, 0
  store i8* %t22, i8** %l4
  %t23 = load i8*, i8** %l4
  %t24 = alloca [0 x %NativeInterfaceSignature]
  %t25 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* %t24, i32 0, i32 0
  %t26 = alloca { %NativeInterfaceSignature*, i64 }
  %t27 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t26, i32 0, i32 0
  store %NativeInterfaceSignature* %t25, %NativeInterfaceSignature** %t27
  %t28 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { %NativeInterfaceSignature*, i64 }* %t26, { %NativeInterfaceSignature*, i64 }** %l5
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %start_index, %t29
  store double %t30, double* %l6
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load i8*, i8** %l2
  %t34 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t35 = load i8*, i8** %l4
  %t36 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t37 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t159 = phi { i8**, i64 }* [ %t31, %entry ], [ %t156, %loop.latch2 ]
  %t160 = phi double [ %t37, %entry ], [ %t157, %loop.latch2 ]
  %t161 = phi { %NativeInterfaceSignature*, i64 }* [ %t36, %entry ], [ %t158, %loop.latch2 ]
  store { i8**, i64 }* %t159, { i8**, i64 }** %l0
  store double %t160, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t161, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body1
loop.body1:
  %t38 = load double, double* %l6
  %t39 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp oge double %t38, %t41
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load i8*, i8** %l2
  %t46 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t47 = load i8*, i8** %l4
  %t48 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t49 = load double, double* %l6
  br i1 %t42, label %then4, label %merge5
then4:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s51 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.51, i32 0, i32 0
  %t52 = load i8*, i8** %l4
  %t53 = add i8* %s51, %t52
  %t54 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t50, i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l4
  %t56 = insertvalue %NativeInterface undef, i8* %t55, 0
  %t57 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t58 = extractvalue %InterfaceHeaderParse %t57, 1
  %t59 = insertvalue %NativeInterface %t56, { i8**, i64 }* %t58, 1
  %t60 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t61 = insertvalue %NativeInterface %t59, { i8**, i64 }* null, 2
  %t62 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t63 = load double, double* %l6
  %t64 = insertvalue %InterfaceParseResult %t62, double %t63, 1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = insertvalue %InterfaceParseResult %t64, { i8**, i64 }* %t65, 2
  ret %InterfaceParseResult %t66
merge5:
  %t67 = load double, double* %l6
  %t68 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t69 = extractvalue { i8**, i64 } %t68, 0
  %t70 = extractvalue { i8**, i64 } %t68, 1
  %t71 = icmp uge i64 %t67, %t70
  ; bounds check: %t71 (if true, out of bounds)
  %t72 = getelementptr i8*, i8** %t69, i64 %t67
  %t73 = load i8*, i8** %t72
  %t74 = call i8* @trim_text(i8* %t73)
  store i8* %t74, i8** %l7
  %t76 = load i8*, i8** %l7
  %t77 = load i8*, i8** %l7
  %s78 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.78, i32 0, i32 0
  %t79 = icmp eq i8* %t77, %s78
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load i8*, i8** %l2
  %t83 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t84 = load i8*, i8** %l4
  %t85 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t86 = load double, double* %l6
  %t87 = load i8*, i8** %l7
  br i1 %t79, label %then6, label %merge7
then6:
  %t88 = load double, double* %l6
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l6
  br label %afterloop3
merge7:
  %t91 = load i8*, i8** %l7
  %s92 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.92, i32 0, i32 0
  %t93 = icmp eq i8* %t91, %s92
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load i8*, i8** %l1
  %t96 = load i8*, i8** %l2
  %t97 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t98 = load i8*, i8** %l4
  %t99 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t100 = load double, double* %l6
  %t101 = load i8*, i8** %l7
  br i1 %t93, label %then8, label %merge9
then8:
  %t102 = load double, double* %l6
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l6
  br label %loop.latch2
merge9:
  %t105 = load i8*, i8** %l7
  %s106 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.106, i32 0, i32 0
  %t107 = call i1 @starts_with(i8* %t105, i8* %s106)
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load i8*, i8** %l1
  %t110 = load i8*, i8** %l2
  %t111 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t112 = load i8*, i8** %l4
  %t113 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t114 = load double, double* %l6
  %t115 = load i8*, i8** %l7
  br i1 %t107, label %then10, label %merge11
then10:
  %t116 = load i8*, i8** %l7
  %s117 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.117, i32 0, i32 0
  %t118 = call i8* @strip_prefix(i8* %t116, i8* %s117)
  %t119 = load i8*, i8** %l4
  %t120 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t118, i8* %t119)
  store %InterfaceSignatureParse %t120, %InterfaceSignatureParse* %l8
  %t121 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t122 = extractvalue %InterfaceSignatureParse %t121, 2
  %t123 = call double @diagnosticsconcat({ i8**, i64 }* %t122)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t124 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t125 = extractvalue %InterfaceSignatureParse %t124, 0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load i8*, i8** %l2
  %t129 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t130 = load i8*, i8** %l4
  %t131 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t132 = load double, double* %l6
  %t133 = load i8*, i8** %l7
  %t134 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t125, label %then12, label %merge13
then12:
  %t135 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t136 = extractvalue %InterfaceSignatureParse %t135, 1
  %t137 = alloca [1 x i8*]
  %t138 = getelementptr [1 x i8*], [1 x i8*]* %t137, i32 0, i32 0
  %t139 = getelementptr i8*, i8** %t138, i64 0
  store i8* %t136, i8** %t139
  %t140 = alloca { i8**, i64 }
  %t141 = getelementptr { i8**, i64 }, { i8**, i64 }* %t140, i32 0, i32 0
  store i8** %t138, i8*** %t141
  %t142 = getelementptr { i8**, i64 }, { i8**, i64 }* %t140, i32 0, i32 1
  store i64 1, i64* %t142
  %t143 = call double @signaturesconcat({ i8**, i64 }* %t140)
  store { %NativeInterfaceSignature*, i64 }* null, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge13
merge13:
  %t144 = phi { %NativeInterfaceSignature*, i64 }* [ null, %then12 ], [ %t131, %then10 ]
  store { %NativeInterfaceSignature*, i64 }* %t144, { %NativeInterfaceSignature*, i64 }** %l5
  %t145 = load double, double* %l6
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  store double %t147, double* %l6
  br label %loop.latch2
merge11:
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s149 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.149, i32 0, i32 0
  %t150 = load i8*, i8** %l7
  %t151 = add i8* %s149, %t150
  %t152 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t148, i8* %t151)
  store { i8**, i64 }* %t152, { i8**, i64 }** %l0
  %t153 = load double, double* %l6
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l6
  br label %loop.latch2
loop.latch2:
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load double, double* %l6
  %t158 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t162 = load i8*, i8** %l4
  %t163 = insertvalue %NativeInterface undef, i8* %t162, 0
  %t164 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t165 = extractvalue %InterfaceHeaderParse %t164, 1
  %t166 = insertvalue %NativeInterface %t163, { i8**, i64 }* %t165, 1
  %t167 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t168 = insertvalue %NativeInterface %t166, { i8**, i64 }* null, 2
  %t169 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t170 = load double, double* %l6
  %t171 = insertvalue %InterfaceParseResult %t169, double %t170, 1
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t173 = insertvalue %InterfaceParseResult %t171, { i8**, i64 }* %t172, 2
  ret %InterfaceParseResult %t173
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
  %t80 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t81 = extractvalue %HeaderNameParse %t80, 3
  %t82 = call double @diagnosticsconcat({ i8**, i64 }* %t81)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t83 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t84 = extractvalue %HeaderNameParse %t83, 2
  %t85 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t86 = extractvalue %HeaderNameParse %t85, 0
  store i8* %t86, i8** %l9
  %t87 = load i8*, i8** %l9
  %t88 = load i8*, i8** %l3
  %t89 = load double, double* %l5
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  %t92 = load double, double* %l6
  %t93 = fptosi double %t91 to i64
  %t94 = fptosi double %t92 to i64
  %t95 = call i8* @sailfin_runtime_substring(i8* %t88, i64 %t93, i64 %t94)
  store i8* %t95, i8** %l10
  %t96 = alloca [0 x %NativeParameter]
  %t97 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t96, i32 0, i32 0
  %t98 = alloca { %NativeParameter*, i64 }
  %t99 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t98, i32 0, i32 0
  store %NativeParameter* %t97, %NativeParameter** %t99
  %t100 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t98, i32 0, i32 1
  store i64 0, i64* %t100
  store { %NativeParameter*, i64 }* %t98, { %NativeParameter*, i64 }** %l11
  %t101 = load i8*, i8** %l10
  %t102 = call i8* @trim_text(i8* %t101)
  store i8* %t102, i8** %l12
  %t103 = load i8*, i8** %l12
  %s104 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.104, i32 0, i32 0
  store i8* %s104, i8** %l13
  %t105 = alloca [0 x i8*]
  %t106 = getelementptr [0 x i8*], [0 x i8*]* %t105, i32 0, i32 0
  %t107 = alloca { i8**, i64 }
  %t108 = getelementptr { i8**, i64 }, { i8**, i64 }* %t107, i32 0, i32 0
  store i8** %t106, i8*** %t108
  %t109 = getelementptr { i8**, i64 }, { i8**, i64 }* %t107, i32 0, i32 1
  store i64 0, i64* %t109
  store { i8**, i64 }* %t107, { i8**, i64 }** %l14
  %t110 = load i8*, i8** %l3
  %t111 = load double, double* %l6
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  %t114 = load i8*, i8** %l3
  store double 0.0, double* %l15
  %t115 = load double, double* %l15
  store double 0.0, double* %l16
  %t117 = load i8*, i8** %l9
  store double 0.0, double* %l17
  %t118 = load double, double* %l17
  %t119 = fcmp one double %t118, 0.0
  %t120 = insertvalue %InterfaceSignatureParse undef, i1 %t119, 0
  %t121 = load double, double* %l16
  %t122 = insertvalue %InterfaceSignatureParse %t120, i8* null, 1
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = insertvalue %InterfaceSignatureParse %t122, { i8**, i64 }* %t123, 2
  ret %InterfaceSignatureParse %t124
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
  %t646 = phi { i8**, i64 }* [ %t53, %entry ], [ %t636, %loop.latch4 ]
  %t647 = phi double [ %t67, %entry ], [ %t637, %loop.latch4 ]
  %t648 = phi double [ %t60, %entry ], [ %t638, %loop.latch4 ]
  %t649 = phi double [ %t61, %entry ], [ %t639, %loop.latch4 ]
  %t650 = phi i8* [ %t62, %entry ], [ %t640, %loop.latch4 ]
  %t651 = phi double [ %t63, %entry ], [ %t641, %loop.latch4 ]
  %t652 = phi double [ %t64, %entry ], [ %t642, %loop.latch4 ]
  %t653 = phi i1 [ %t65, %entry ], [ %t643, %loop.latch4 ]
  %t654 = phi { %NativeEnumVariantLayout*, i64 }* [ %t59, %entry ], [ %t644, %loop.latch4 ]
  %t655 = phi i1 [ %t66, %entry ], [ %t645, %loop.latch4 ]
  store { i8**, i64 }* %t646, { i8**, i64 }** %l0
  store double %t647, double* %l14
  store double %t648, double* %l7
  store double %t649, double* %l8
  store i8* %t650, i8** %l9
  store double %t651, double* %l10
  store double %t652, double* %l11
  store i1 %t653, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t654, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t655, i1* %l13
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
  %t114 = insertvalue %NativeEnum %t112, { i8**, i64 }* null, 1
  %t115 = load i8*, i8** %l15
  %t116 = insertvalue %NativeEnum %t114, i8* %t115, 2
  %t117 = insertvalue %EnumParseResult undef, i8* null, 0
  %t118 = load double, double* %l14
  %t119 = insertvalue %EnumParseResult %t117, double %t118, 1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = insertvalue %EnumParseResult %t119, { i8**, i64 }* %t120, 2
  ret %EnumParseResult %t121
merge7:
  %t122 = load double, double* %l14
  %t123 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t124 = extractvalue { i8**, i64 } %t123, 0
  %t125 = extractvalue { i8**, i64 } %t123, 1
  %t126 = icmp uge i64 %t122, %t125
  ; bounds check: %t126 (if true, out of bounds)
  %t127 = getelementptr i8*, i8** %t124, i64 %t122
  %t128 = load i8*, i8** %t127
  %t129 = call i8* @trim_text(i8* %t128)
  store i8* %t129, i8** %l16
  %t131 = load i8*, i8** %l16
  %t132 = load i8*, i8** %l16
  %s133 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.133, i32 0, i32 0
  %t134 = icmp eq i8* %t132, %s133
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load i8*, i8** %l1
  %t137 = load i8*, i8** %l2
  %t138 = load i8*, i8** %l3
  %t139 = load double, double* %l4
  %t140 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t141 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t142 = load double, double* %l7
  %t143 = load double, double* %l8
  %t144 = load i8*, i8** %l9
  %t145 = load double, double* %l10
  %t146 = load double, double* %l11
  %t147 = load i1, i1* %l12
  %t148 = load i1, i1* %l13
  %t149 = load double, double* %l14
  %t150 = load i8*, i8** %l16
  br i1 %t134, label %then10, label %merge11
then10:
  %t151 = load double, double* %l14
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l14
  br label %loop.latch4
merge11:
  %t154 = load i8*, i8** %l16
  %s155 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.155, i32 0, i32 0
  %t156 = call i1 @starts_with(i8* %t154, i8* %s155)
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load i8*, i8** %l2
  %t160 = load i8*, i8** %l3
  %t161 = load double, double* %l4
  %t162 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t163 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t164 = load double, double* %l7
  %t165 = load double, double* %l8
  %t166 = load i8*, i8** %l9
  %t167 = load double, double* %l10
  %t168 = load double, double* %l11
  %t169 = load i1, i1* %l12
  %t170 = load i1, i1* %l13
  %t171 = load double, double* %l14
  %t172 = load i8*, i8** %l16
  br i1 %t156, label %then12, label %merge13
then12:
  %t173 = load i8*, i8** %l16
  %s174 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.174, i32 0, i32 0
  %t175 = call i8* @strip_prefix(i8* %t173, i8* %s174)
  store i8* %t175, i8** %l17
  %t176 = load i8*, i8** %l17
  %s177 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.177, i32 0, i32 0
  %t178 = call i1 @starts_with(i8* %t176, i8* %s177)
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load i8*, i8** %l1
  %t181 = load i8*, i8** %l2
  %t182 = load i8*, i8** %l3
  %t183 = load double, double* %l4
  %t184 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t185 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t186 = load double, double* %l7
  %t187 = load double, double* %l8
  %t188 = load i8*, i8** %l9
  %t189 = load double, double* %l10
  %t190 = load double, double* %l11
  %t191 = load i1, i1* %l12
  %t192 = load i1, i1* %l13
  %t193 = load double, double* %l14
  %t194 = load i8*, i8** %l16
  %t195 = load i8*, i8** %l17
  br i1 %t178, label %then14, label %merge15
then14:
  %t196 = load i8*, i8** %l17
  %s197 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.197, i32 0, i32 0
  %t198 = call i8* @strip_prefix(i8* %t196, i8* %s197)
  %t199 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t198)
  store %EnumLayoutHeaderParse %t199, %EnumLayoutHeaderParse* %l18
  %t200 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t201 = extractvalue %EnumLayoutHeaderParse %t200, 7
  %t202 = call double @diagnosticsconcat({ i8**, i64 }* %t201)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t203 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t204 = extractvalue %EnumLayoutHeaderParse %t203, 0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load i8*, i8** %l1
  %t207 = load i8*, i8** %l2
  %t208 = load i8*, i8** %l3
  %t209 = load double, double* %l4
  %t210 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t211 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t212 = load double, double* %l7
  %t213 = load double, double* %l8
  %t214 = load i8*, i8** %l9
  %t215 = load double, double* %l10
  %t216 = load double, double* %l11
  %t217 = load i1, i1* %l12
  %t218 = load i1, i1* %l13
  %t219 = load double, double* %l14
  %t220 = load i8*, i8** %l16
  %t221 = load i8*, i8** %l17
  %t222 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t204, label %then16, label %merge17
then16:
  %t223 = load i1, i1* %l12
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load i8*, i8** %l1
  %t226 = load i8*, i8** %l2
  %t227 = load i8*, i8** %l3
  %t228 = load double, double* %l4
  %t229 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t230 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t231 = load double, double* %l7
  %t232 = load double, double* %l8
  %t233 = load i8*, i8** %l9
  %t234 = load double, double* %l10
  %t235 = load double, double* %l11
  %t236 = load i1, i1* %l12
  %t237 = load i1, i1* %l13
  %t238 = load double, double* %l14
  %t239 = load i8*, i8** %l16
  %t240 = load i8*, i8** %l17
  %t241 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t223, label %then18, label %else19
then18:
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s243 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.243, i32 0, i32 0
  %t244 = load i8*, i8** %l3
  %t245 = add i8* %s243, %t244
  %t246 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t242, i8* %t245)
  store { i8**, i64 }* %t246, { i8**, i64 }** %l0
  br label %merge20
else19:
  %t247 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t248 = extractvalue %EnumLayoutHeaderParse %t247, 2
  store double %t248, double* %l7
  %t249 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t250 = extractvalue %EnumLayoutHeaderParse %t249, 3
  store double %t250, double* %l8
  %t251 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t252 = extractvalue %EnumLayoutHeaderParse %t251, 4
  store i8* %t252, i8** %l9
  %t253 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t254 = extractvalue %EnumLayoutHeaderParse %t253, 5
  store double %t254, double* %l10
  %t255 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t256 = extractvalue %EnumLayoutHeaderParse %t255, 6
  store double %t256, double* %l11
  store i1 1, i1* %l12
  br label %merge20
merge20:
  %t257 = phi { i8**, i64 }* [ %t246, %then18 ], [ %t224, %else19 ]
  %t258 = phi double [ %t231, %then18 ], [ %t248, %else19 ]
  %t259 = phi double [ %t232, %then18 ], [ %t250, %else19 ]
  %t260 = phi i8* [ %t233, %then18 ], [ %t252, %else19 ]
  %t261 = phi double [ %t234, %then18 ], [ %t254, %else19 ]
  %t262 = phi double [ %t235, %then18 ], [ %t256, %else19 ]
  %t263 = phi i1 [ %t236, %then18 ], [ 1, %else19 ]
  store { i8**, i64 }* %t257, { i8**, i64 }** %l0
  store double %t258, double* %l7
  store double %t259, double* %l8
  store i8* %t260, i8** %l9
  store double %t261, double* %l10
  store double %t262, double* %l11
  store i1 %t263, i1* %l12
  br label %merge17
merge17:
  %t264 = phi { i8**, i64 }* [ %t246, %then16 ], [ %t205, %then14 ]
  %t265 = phi double [ %t248, %then16 ], [ %t212, %then14 ]
  %t266 = phi double [ %t250, %then16 ], [ %t213, %then14 ]
  %t267 = phi i8* [ %t252, %then16 ], [ %t214, %then14 ]
  %t268 = phi double [ %t254, %then16 ], [ %t215, %then14 ]
  %t269 = phi double [ %t256, %then16 ], [ %t216, %then14 ]
  %t270 = phi i1 [ 1, %then16 ], [ %t217, %then14 ]
  store { i8**, i64 }* %t264, { i8**, i64 }** %l0
  store double %t265, double* %l7
  store double %t266, double* %l8
  store i8* %t267, i8** %l9
  store double %t268, double* %l10
  store double %t269, double* %l11
  store i1 %t270, i1* %l12
  %t271 = load double, double* %l14
  %t272 = sitofp i64 1 to double
  %t273 = fadd double %t271, %t272
  store double %t273, double* %l14
  br label %loop.latch4
merge15:
  %t274 = load i8*, i8** %l17
  %s275 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.275, i32 0, i32 0
  %t276 = call i1 @starts_with(i8* %t274, i8* %s275)
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
  br i1 %t276, label %then21, label %merge22
then21:
  %t294 = load i8*, i8** %l17
  %s295 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.295, i32 0, i32 0
  %t296 = call i8* @strip_prefix(i8* %t294, i8* %s295)
  %t297 = load i8*, i8** %l3
  %t298 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t296, i8* %t297)
  store %EnumLayoutVariantParse %t298, %EnumLayoutVariantParse* %l19
  %t299 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t300 = extractvalue %EnumLayoutVariantParse %t299, 2
  %t301 = call double @diagnosticsconcat({ i8**, i64 }* %t300)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t302 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t303 = extractvalue %EnumLayoutVariantParse %t302, 0
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t305 = load i8*, i8** %l1
  %t306 = load i8*, i8** %l2
  %t307 = load i8*, i8** %l3
  %t308 = load double, double* %l4
  %t309 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t310 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t311 = load double, double* %l7
  %t312 = load double, double* %l8
  %t313 = load i8*, i8** %l9
  %t314 = load double, double* %l10
  %t315 = load double, double* %l11
  %t316 = load i1, i1* %l12
  %t317 = load i1, i1* %l13
  %t318 = load double, double* %l14
  %t319 = load i8*, i8** %l16
  %t320 = load i8*, i8** %l17
  %t321 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t303, label %then23, label %merge24
then23:
  %t322 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t323 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t324 = extractvalue %EnumLayoutVariantParse %t323, 1
  store double 0.0, double* %l20
  %t325 = load double, double* %l20
  %t326 = sitofp i64 0 to double
  %t327 = fcmp oge double %t325, %t326
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t329 = load i8*, i8** %l1
  %t330 = load i8*, i8** %l2
  %t331 = load i8*, i8** %l3
  %t332 = load double, double* %l4
  %t333 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t334 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t335 = load double, double* %l7
  %t336 = load double, double* %l8
  %t337 = load i8*, i8** %l9
  %t338 = load double, double* %l10
  %t339 = load double, double* %l11
  %t340 = load i1, i1* %l12
  %t341 = load i1, i1* %l13
  %t342 = load double, double* %l14
  %t343 = load i8*, i8** %l16
  %t344 = load i8*, i8** %l17
  %t345 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t346 = load double, double* %l20
  br i1 %t327, label %then25, label %else26
then25:
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s348 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.348, i32 0, i32 0
  %t349 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t350 = extractvalue %EnumLayoutVariantParse %t349, 1
  br label %merge27
else26:
  %t351 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t352 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t353 = extractvalue %EnumLayoutVariantParse %t352, 1
  %t354 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t351, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t354, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge27
merge27:
  %t355 = phi { i8**, i64 }* [ null, %then25 ], [ %t328, %else26 ]
  %t356 = phi { %NativeEnumVariantLayout*, i64 }* [ %t334, %then25 ], [ %t354, %else26 ]
  store { i8**, i64 }* %t355, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t356, { %NativeEnumVariantLayout*, i64 }** %l6
  %t357 = load i1, i1* %l12
  %t358 = xor i1 %t357, 1
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = load i8*, i8** %l1
  %t361 = load i8*, i8** %l2
  %t362 = load i8*, i8** %l3
  %t363 = load double, double* %l4
  %t364 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t365 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t366 = load double, double* %l7
  %t367 = load double, double* %l8
  %t368 = load i8*, i8** %l9
  %t369 = load double, double* %l10
  %t370 = load double, double* %l11
  %t371 = load i1, i1* %l12
  %t372 = load i1, i1* %l13
  %t373 = load double, double* %l14
  %t374 = load i8*, i8** %l16
  %t375 = load i8*, i8** %l17
  %t376 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t377 = load double, double* %l20
  br i1 %t358, label %then28, label %merge29
then28:
  %t378 = load i1, i1* %l13
  %t379 = xor i1 %t378, 1
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load i8*, i8** %l1
  %t382 = load i8*, i8** %l2
  %t383 = load i8*, i8** %l3
  %t384 = load double, double* %l4
  %t385 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t386 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t387 = load double, double* %l7
  %t388 = load double, double* %l8
  %t389 = load i8*, i8** %l9
  %t390 = load double, double* %l10
  %t391 = load double, double* %l11
  %t392 = load i1, i1* %l12
  %t393 = load i1, i1* %l13
  %t394 = load double, double* %l14
  %t395 = load i8*, i8** %l16
  %t396 = load i8*, i8** %l17
  %t397 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t398 = load double, double* %l20
  br i1 %t379, label %then30, label %merge31
then30:
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s400 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.400, i32 0, i32 0
  %t401 = load i8*, i8** %l3
  %t402 = add i8* %s400, %t401
  %s403 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.403, i32 0, i32 0
  %t404 = add i8* %t402, %s403
  %t405 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t399, i8* %t404)
  store { i8**, i64 }* %t405, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge31
merge31:
  %t406 = phi { i8**, i64 }* [ %t405, %then30 ], [ %t380, %then28 ]
  %t407 = phi i1 [ 1, %then30 ], [ %t393, %then28 ]
  store { i8**, i64 }* %t406, { i8**, i64 }** %l0
  store i1 %t407, i1* %l13
  br label %merge29
merge29:
  %t408 = phi { i8**, i64 }* [ %t405, %then28 ], [ %t359, %then23 ]
  %t409 = phi i1 [ 1, %then28 ], [ %t372, %then23 ]
  store { i8**, i64 }* %t408, { i8**, i64 }** %l0
  store i1 %t409, i1* %l13
  br label %merge24
merge24:
  %t410 = phi { i8**, i64 }* [ null, %then23 ], [ %t304, %then21 ]
  %t411 = phi { %NativeEnumVariantLayout*, i64 }* [ %t354, %then23 ], [ %t310, %then21 ]
  %t412 = phi { i8**, i64 }* [ %t405, %then23 ], [ %t304, %then21 ]
  %t413 = phi i1 [ 1, %then23 ], [ %t317, %then21 ]
  store { i8**, i64 }* %t410, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t411, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t412, { i8**, i64 }** %l0
  store i1 %t413, i1* %l13
  %t414 = load double, double* %l14
  %t415 = sitofp i64 1 to double
  %t416 = fadd double %t414, %t415
  store double %t416, double* %l14
  br label %loop.latch4
merge22:
  %t417 = load i8*, i8** %l17
  %s418 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.418, i32 0, i32 0
  %t419 = call i1 @starts_with(i8* %t417, i8* %s418)
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load i8*, i8** %l1
  %t422 = load i8*, i8** %l2
  %t423 = load i8*, i8** %l3
  %t424 = load double, double* %l4
  %t425 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t426 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t427 = load double, double* %l7
  %t428 = load double, double* %l8
  %t429 = load i8*, i8** %l9
  %t430 = load double, double* %l10
  %t431 = load double, double* %l11
  %t432 = load i1, i1* %l12
  %t433 = load i1, i1* %l13
  %t434 = load double, double* %l14
  %t435 = load i8*, i8** %l16
  %t436 = load i8*, i8** %l17
  br i1 %t419, label %then32, label %merge33
then32:
  %t437 = load i8*, i8** %l17
  %s438 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.438, i32 0, i32 0
  %t439 = call i8* @strip_prefix(i8* %t437, i8* %s438)
  %t440 = load i8*, i8** %l3
  %t441 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t439, i8* %t440)
  store %EnumLayoutPayloadParse %t441, %EnumLayoutPayloadParse* %l21
  %t442 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t443 = extractvalue %EnumLayoutPayloadParse %t442, 3
  %t444 = call double @diagnosticsconcat({ i8**, i64 }* %t443)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t445 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t446 = extractvalue %EnumLayoutPayloadParse %t445, 0
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t448 = load i8*, i8** %l1
  %t449 = load i8*, i8** %l2
  %t450 = load i8*, i8** %l3
  %t451 = load double, double* %l4
  %t452 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t453 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t454 = load double, double* %l7
  %t455 = load double, double* %l8
  %t456 = load i8*, i8** %l9
  %t457 = load double, double* %l10
  %t458 = load double, double* %l11
  %t459 = load i1, i1* %l12
  %t460 = load i1, i1* %l13
  %t461 = load double, double* %l14
  %t462 = load i8*, i8** %l16
  %t463 = load i8*, i8** %l17
  %t464 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t446, label %then34, label %merge35
then34:
  %t465 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t466 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t467 = extractvalue %EnumLayoutPayloadParse %t466, 1
  %t468 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t465, i8* %t467)
  store double %t468, double* %l22
  %t469 = load double, double* %l22
  %t470 = sitofp i64 0 to double
  %t471 = fcmp olt double %t469, %t470
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t473 = load i8*, i8** %l1
  %t474 = load i8*, i8** %l2
  %t475 = load i8*, i8** %l3
  %t476 = load double, double* %l4
  %t477 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t478 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t479 = load double, double* %l7
  %t480 = load double, double* %l8
  %t481 = load i8*, i8** %l9
  %t482 = load double, double* %l10
  %t483 = load double, double* %l11
  %t484 = load i1, i1* %l12
  %t485 = load i1, i1* %l13
  %t486 = load double, double* %l14
  %t487 = load i8*, i8** %l16
  %t488 = load i8*, i8** %l17
  %t489 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t490 = load double, double* %l22
  br i1 %t471, label %then36, label %else37
then36:
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s492 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.492, i32 0, i32 0
  %t493 = load i8*, i8** %l3
  %t494 = add i8* %s492, %t493
  %s495 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.495, i32 0, i32 0
  %t496 = add i8* %t494, %s495
  %t497 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t498 = extractvalue %EnumLayoutPayloadParse %t497, 1
  %t499 = add i8* %t496, %t498
  %t500 = getelementptr i8, i8* %t499, i64 0
  %t501 = load i8, i8* %t500
  %t502 = add i8 %t501, 96
  %t503 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t491, i8* null)
  store { i8**, i64 }* %t503, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t504 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t505 = load double, double* %l22
  %t506 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t507 = extractvalue %EnumLayoutPayloadParse %t506, 2
  %t508 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t504, double %t505, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t508, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge38
merge38:
  %t509 = phi { i8**, i64 }* [ %t503, %then36 ], [ %t472, %else37 ]
  %t510 = phi { %NativeEnumVariantLayout*, i64 }* [ %t478, %then36 ], [ %t508, %else37 ]
  store { i8**, i64 }* %t509, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t510, { %NativeEnumVariantLayout*, i64 }** %l6
  %t511 = load i1, i1* %l12
  %t512 = xor i1 %t511, 1
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t514 = load i8*, i8** %l1
  %t515 = load i8*, i8** %l2
  %t516 = load i8*, i8** %l3
  %t517 = load double, double* %l4
  %t518 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t519 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t520 = load double, double* %l7
  %t521 = load double, double* %l8
  %t522 = load i8*, i8** %l9
  %t523 = load double, double* %l10
  %t524 = load double, double* %l11
  %t525 = load i1, i1* %l12
  %t526 = load i1, i1* %l13
  %t527 = load double, double* %l14
  %t528 = load i8*, i8** %l16
  %t529 = load i8*, i8** %l17
  %t530 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t531 = load double, double* %l22
  br i1 %t512, label %then39, label %merge40
then39:
  %t532 = load i1, i1* %l13
  %t533 = xor i1 %t532, 1
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load i8*, i8** %l1
  %t536 = load i8*, i8** %l2
  %t537 = load i8*, i8** %l3
  %t538 = load double, double* %l4
  %t539 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t540 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t541 = load double, double* %l7
  %t542 = load double, double* %l8
  %t543 = load i8*, i8** %l9
  %t544 = load double, double* %l10
  %t545 = load double, double* %l11
  %t546 = load i1, i1* %l12
  %t547 = load i1, i1* %l13
  %t548 = load double, double* %l14
  %t549 = load i8*, i8** %l16
  %t550 = load i8*, i8** %l17
  %t551 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t552 = load double, double* %l22
  br i1 %t533, label %then41, label %merge42
then41:
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s554 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.554, i32 0, i32 0
  %t555 = load i8*, i8** %l3
  %t556 = add i8* %s554, %t555
  %s557 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.557, i32 0, i32 0
  %t558 = add i8* %t556, %s557
  %t559 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t553, i8* %t558)
  store { i8**, i64 }* %t559, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge42
merge42:
  %t560 = phi { i8**, i64 }* [ %t559, %then41 ], [ %t534, %then39 ]
  %t561 = phi i1 [ 1, %then41 ], [ %t547, %then39 ]
  store { i8**, i64 }* %t560, { i8**, i64 }** %l0
  store i1 %t561, i1* %l13
  br label %merge40
merge40:
  %t562 = phi { i8**, i64 }* [ %t559, %then39 ], [ %t513, %then34 ]
  %t563 = phi i1 [ 1, %then39 ], [ %t526, %then34 ]
  store { i8**, i64 }* %t562, { i8**, i64 }** %l0
  store i1 %t563, i1* %l13
  br label %merge35
merge35:
  %t564 = phi { i8**, i64 }* [ %t503, %then34 ], [ %t447, %then32 ]
  %t565 = phi { %NativeEnumVariantLayout*, i64 }* [ %t508, %then34 ], [ %t453, %then32 ]
  %t566 = phi { i8**, i64 }* [ %t559, %then34 ], [ %t447, %then32 ]
  %t567 = phi i1 [ 1, %then34 ], [ %t460, %then32 ]
  store { i8**, i64 }* %t564, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t565, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t566, { i8**, i64 }** %l0
  store i1 %t567, i1* %l13
  %t568 = load double, double* %l14
  %t569 = sitofp i64 1 to double
  %t570 = fadd double %t568, %t569
  store double %t570, double* %l14
  br label %loop.latch4
merge33:
  %t571 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s572 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.572, i32 0, i32 0
  %t573 = load i8*, i8** %l16
  %t574 = add i8* %s572, %t573
  %t575 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t571, i8* %t574)
  store { i8**, i64 }* %t575, { i8**, i64 }** %l0
  %t576 = load double, double* %l14
  %t577 = sitofp i64 1 to double
  %t578 = fadd double %t576, %t577
  store double %t578, double* %l14
  br label %loop.latch4
merge13:
  %t579 = load i8*, i8** %l16
  %s580 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.580, i32 0, i32 0
  %t581 = icmp eq i8* %t579, %s580
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t583 = load i8*, i8** %l1
  %t584 = load i8*, i8** %l2
  %t585 = load i8*, i8** %l3
  %t586 = load double, double* %l4
  %t587 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t588 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t589 = load double, double* %l7
  %t590 = load double, double* %l8
  %t591 = load i8*, i8** %l9
  %t592 = load double, double* %l10
  %t593 = load double, double* %l11
  %t594 = load i1, i1* %l12
  %t595 = load i1, i1* %l13
  %t596 = load double, double* %l14
  %t597 = load i8*, i8** %l16
  br i1 %t581, label %then43, label %merge44
then43:
  %t598 = load double, double* %l14
  %t599 = sitofp i64 1 to double
  %t600 = fadd double %t598, %t599
  store double %t600, double* %l14
  br label %afterloop5
merge44:
  %t601 = load i8*, i8** %l16
  %s602 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.602, i32 0, i32 0
  %t603 = call i1 @starts_with(i8* %t601, i8* %s602)
  %t604 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t605 = load i8*, i8** %l1
  %t606 = load i8*, i8** %l2
  %t607 = load i8*, i8** %l3
  %t608 = load double, double* %l4
  %t609 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t610 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t611 = load double, double* %l7
  %t612 = load double, double* %l8
  %t613 = load i8*, i8** %l9
  %t614 = load double, double* %l10
  %t615 = load double, double* %l11
  %t616 = load i1, i1* %l12
  %t617 = load i1, i1* %l13
  %t618 = load double, double* %l14
  %t619 = load i8*, i8** %l16
  br i1 %t603, label %then45, label %merge46
then45:
  %t620 = load i8*, i8** %l16
  %s621 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.621, i32 0, i32 0
  %t622 = call i8* @strip_prefix(i8* %t620, i8* %s621)
  %t623 = call double @parse_enum_variant_line(i8* %t622)
  store double %t623, double* %l23
  %t624 = load double, double* %l23
  %t625 = load double, double* %l14
  %t626 = sitofp i64 1 to double
  %t627 = fadd double %t625, %t626
  store double %t627, double* %l14
  br label %loop.latch4
merge46:
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s629 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.629, i32 0, i32 0
  %t630 = load i8*, i8** %l16
  %t631 = add i8* %s629, %t630
  %t632 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t628, i8* %t631)
  store { i8**, i64 }* %t632, { i8**, i64 }** %l0
  %t633 = load double, double* %l14
  %t634 = sitofp i64 1 to double
  %t635 = fadd double %t633, %t634
  store double %t635, double* %l14
  br label %loop.latch4
loop.latch4:
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t637 = load double, double* %l14
  %t638 = load double, double* %l7
  %t639 = load double, double* %l8
  %t640 = load i8*, i8** %l9
  %t641 = load double, double* %l10
  %t642 = load double, double* %l11
  %t643 = load i1, i1* %l12
  %t644 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t645 = load i1, i1* %l13
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l24
  %t656 = load i1, i1* %l12
  %t657 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t658 = load i8*, i8** %l1
  %t659 = load i8*, i8** %l2
  %t660 = load i8*, i8** %l3
  %t661 = load double, double* %l4
  %t662 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t663 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t664 = load double, double* %l7
  %t665 = load double, double* %l8
  %t666 = load i8*, i8** %l9
  %t667 = load double, double* %l10
  %t668 = load double, double* %l11
  %t669 = load i1, i1* %l12
  %t670 = load i1, i1* %l13
  %t671 = load double, double* %l14
  %t672 = load i8*, i8** %l24
  br i1 %t656, label %then47, label %merge48
then47:
  br label %merge48
merge48:
  %t673 = phi i8* [ null, %then47 ], [ %t672, %entry ]
  store i8* %t673, i8** %l24
  %t674 = load i8*, i8** %l3
  %t675 = insertvalue %NativeEnum undef, i8* %t674, 0
  %t676 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t677 = insertvalue %NativeEnum %t675, { i8**, i64 }* null, 1
  %t678 = load i8*, i8** %l24
  %t679 = insertvalue %NativeEnum %t677, i8* %t678, 2
  %t680 = insertvalue %EnumParseResult undef, i8* null, 0
  %t681 = load double, double* %l14
  %t682 = insertvalue %EnumParseResult %t680, double %t681, 1
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t684 = insertvalue %EnumParseResult %t682, { i8**, i64 }* %t683, 2
  ret %EnumParseResult %t684
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
  %t485 = phi double [ %t21, %entry ], [ %t481, %loop.latch2 ]
  %t486 = phi { i8**, i64 }* [ %t18, %entry ], [ %t482, %loop.latch2 ]
  %t487 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t483, %loop.latch2 ]
  %t488 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t484, %loop.latch2 ]
  store double %t485, double* %l4
  store { i8**, i64 }* %t486, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t487, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t488, { %NativeEnum*, i64 }** %l3
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
  %t87 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t88 = extractvalue %StructLayoutHeaderParse %t87, 4
  %t89 = call double @diagnosticsconcat({ i8**, i64 }* %t88)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t90 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t91 = extractvalue %StructLayoutHeaderParse %t90, 0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t95 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t96 = load double, double* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i8*, i8** %l6
  %t99 = load i8*, i8** %l7
  %t100 = load i8*, i8** %l8
  %t101 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t91, label %then12, label %merge13
then12:
  %t102 = alloca [0 x %NativeStructLayoutField]
  %t103 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t102, i32 0, i32 0
  %t104 = alloca { %NativeStructLayoutField*, i64 }
  %t105 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t104, i32 0, i32 0
  store %NativeStructLayoutField* %t103, %NativeStructLayoutField** %t105
  %t106 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t104, i32 0, i32 1
  store i64 0, i64* %t106
  store { %NativeStructLayoutField*, i64 }* %t104, { %NativeStructLayoutField*, i64 }** %l10
  %t107 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t108 = extractvalue %StructLayoutHeaderParse %t107, 1
  store i8* %t108, i8** %l11
  %t109 = load double, double* %l4
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  store double %t111, double* %l4
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t115 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t116 = load double, double* %l4
  %t117 = load i8*, i8** %l5
  %t118 = load i8*, i8** %l6
  %t119 = load i8*, i8** %l7
  %t120 = load i8*, i8** %l8
  %t121 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t122 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t123 = load i8*, i8** %l11
  br label %loop.header14
loop.header14:
  %t211 = phi i8* [ %t119, %then12 ], [ %t207, %loop.latch16 ]
  %t212 = phi { i8**, i64 }* [ %t113, %then12 ], [ %t208, %loop.latch16 ]
  %t213 = phi { %NativeStructLayoutField*, i64 }* [ %t122, %then12 ], [ %t209, %loop.latch16 ]
  %t214 = phi double [ %t116, %then12 ], [ %t210, %loop.latch16 ]
  store i8* %t211, i8** %l7
  store { i8**, i64 }* %t212, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t213, { %NativeStructLayoutField*, i64 }** %l10
  store double %t214, double* %l4
  br label %loop.body15
loop.body15:
  %t124 = load double, double* %l4
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load { i8**, i64 }, { i8**, i64 }* %t125
  %t127 = extractvalue { i8**, i64 } %t126, 1
  %t128 = sitofp i64 %t127 to double
  %t129 = fcmp oge double %t124, %t128
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
  br i1 %t129, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = load double, double* %l4
  %t144 = load { i8**, i64 }, { i8**, i64 }* %t142
  %t145 = extractvalue { i8**, i64 } %t144, 0
  %t146 = extractvalue { i8**, i64 } %t144, 1
  %t147 = icmp uge i64 %t143, %t146
  ; bounds check: %t147 (if true, out of bounds)
  %t148 = getelementptr i8*, i8** %t145, i64 %t143
  %t149 = load i8*, i8** %t148
  %t150 = call i8* @trim_text(i8* %t149)
  store i8* %t150, i8** %l12
  %t151 = load i8*, i8** %l12
  %t152 = load i8*, i8** %l12
  %s153 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.153, i32 0, i32 0
  %t154 = call i1 @starts_with(i8* %t152, i8* %s153)
  %t155 = xor i1 %t154, 1
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t159 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t160 = load double, double* %l4
  %t161 = load i8*, i8** %l5
  %t162 = load i8*, i8** %l6
  %t163 = load i8*, i8** %l7
  %t164 = load i8*, i8** %l8
  %t165 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t166 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t167 = load i8*, i8** %l11
  %t168 = load i8*, i8** %l12
  br i1 %t155, label %then20, label %merge21
then20:
  br label %afterloop17
merge21:
  %t169 = load i8*, i8** %l12
  %s170 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.170, i32 0, i32 0
  %t171 = call i8* @strip_prefix(i8* %t169, i8* %s170)
  store i8* %t171, i8** %l13
  %t172 = load i8*, i8** %l7
  %s173 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.173, i32 0, i32 0
  %t174 = call i8* @strip_prefix(i8* %t172, i8* %s173)
  store i8* %t174, i8** %l14
  %t175 = load i8*, i8** %l14
  %t176 = load i8*, i8** %l11
  %t177 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t175, i8* %t176)
  store %StructLayoutFieldParse %t177, %StructLayoutFieldParse* %l15
  %t178 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t179 = extractvalue %StructLayoutFieldParse %t178, 2
  %t180 = call double @diagnosticsconcat({ i8**, i64 }* %t179)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t181 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t182 = extractvalue %StructLayoutFieldParse %t181, 0
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t186 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t187 = load double, double* %l4
  %t188 = load i8*, i8** %l5
  %t189 = load i8*, i8** %l6
  %t190 = load i8*, i8** %l7
  %t191 = load i8*, i8** %l8
  %t192 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t193 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t194 = load i8*, i8** %l11
  %t195 = load i8*, i8** %l12
  %t196 = load i8*, i8** %l13
  %t197 = load i8*, i8** %l14
  %t198 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t182, label %then22, label %merge23
then22:
  %t199 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t200 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t201 = extractvalue %StructLayoutFieldParse %t200, 1
  %t202 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t199, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t202, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge23
merge23:
  %t203 = phi { %NativeStructLayoutField*, i64 }* [ %t202, %then22 ], [ %t193, %loop.body15 ]
  store { %NativeStructLayoutField*, i64 }* %t203, { %NativeStructLayoutField*, i64 }** %l10
  %t204 = load double, double* %l4
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l4
  br label %loop.latch16
loop.latch16:
  %t207 = load i8*, i8** %l7
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t209 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t210 = load double, double* %l4
  br label %loop.header14
afterloop17:
  store double 0.0, double* %l16
  %t215 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t216 = load double, double* %l16
  %t217 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t215, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t217, { %NativeStruct*, i64 }** %l2
  br label %merge13
merge13:
  %t218 = phi double [ %t111, %then12 ], [ %t96, %then10 ]
  %t219 = phi i8* [ %t171, %then12 ], [ %t99, %then10 ]
  %t220 = phi { i8**, i64 }* [ null, %then12 ], [ %t93, %then10 ]
  %t221 = phi double [ %t206, %then12 ], [ %t96, %then10 ]
  %t222 = phi { %NativeStruct*, i64 }* [ %t217, %then12 ], [ %t94, %then10 ]
  store double %t218, double* %l4
  store i8* %t219, i8** %l7
  store { i8**, i64 }* %t220, { i8**, i64 }** %l1
  store double %t221, double* %l4
  store { %NativeStruct*, i64 }* %t222, { %NativeStruct*, i64 }** %l2
  %t223 = load double, double* %l4
  %t224 = sitofp i64 1 to double
  %t225 = fadd double %t223, %t224
  store double %t225, double* %l4
  br label %loop.latch2
merge11:
  %t226 = load i8*, i8** %l6
  %s227 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.227, i32 0, i32 0
  %t228 = call i1 @starts_with(i8* %t226, i8* %s227)
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t231 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t232 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t233 = load double, double* %l4
  %t234 = load i8*, i8** %l5
  %t235 = load i8*, i8** %l6
  br i1 %t228, label %then24, label %merge25
then24:
  %t236 = load i8*, i8** %l6
  %s237 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.237, i32 0, i32 0
  %t238 = call i8* @strip_prefix(i8* %t236, i8* %s237)
  store i8* %t238, i8** %l17
  %t239 = load i8*, i8** %l17
  %s240 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.240, i32 0, i32 0
  %t241 = call i8* @strip_prefix(i8* %t239, i8* %s240)
  store i8* %t241, i8** %l18
  %t242 = load i8*, i8** %l18
  %t243 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t242)
  store %EnumLayoutHeaderParse %t243, %EnumLayoutHeaderParse* %l19
  %t244 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t245 = extractvalue %EnumLayoutHeaderParse %t244, 7
  %t246 = call double @diagnosticsconcat({ i8**, i64 }* %t245)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t247 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t248 = extractvalue %EnumLayoutHeaderParse %t247, 0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t251 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t252 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t253 = load double, double* %l4
  %t254 = load i8*, i8** %l5
  %t255 = load i8*, i8** %l6
  %t256 = load i8*, i8** %l17
  %t257 = load i8*, i8** %l18
  %t258 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t248, label %then26, label %else27
then26:
  %t259 = alloca [0 x %NativeEnumVariantLayout]
  %t260 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t259, i32 0, i32 0
  %t261 = alloca { %NativeEnumVariantLayout*, i64 }
  %t262 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t261, i32 0, i32 0
  store %NativeEnumVariantLayout* %t260, %NativeEnumVariantLayout** %t262
  %t263 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t261, i32 0, i32 1
  store i64 0, i64* %t263
  store { %NativeEnumVariantLayout*, i64 }* %t261, { %NativeEnumVariantLayout*, i64 }** %l20
  %t264 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t265 = extractvalue %EnumLayoutHeaderParse %t264, 1
  store i8* %t265, i8** %l21
  %t266 = load double, double* %l4
  %t267 = sitofp i64 1 to double
  %t268 = fadd double %t266, %t267
  store double %t268, double* %l4
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t272 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t273 = load double, double* %l4
  %t274 = load i8*, i8** %l5
  %t275 = load i8*, i8** %l6
  %t276 = load i8*, i8** %l17
  %t277 = load i8*, i8** %l18
  %t278 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t279 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t280 = load i8*, i8** %l21
  br label %loop.header29
loop.header29:
  %t464 = phi i8* [ %t276, %then26 ], [ %t460, %loop.latch31 ]
  %t465 = phi { i8**, i64 }* [ %t270, %then26 ], [ %t461, %loop.latch31 ]
  %t466 = phi { %NativeEnumVariantLayout*, i64 }* [ %t279, %then26 ], [ %t462, %loop.latch31 ]
  %t467 = phi double [ %t273, %then26 ], [ %t463, %loop.latch31 ]
  store i8* %t464, i8** %l17
  store { i8**, i64 }* %t465, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t466, { %NativeEnumVariantLayout*, i64 }** %l20
  store double %t467, double* %l4
  br label %loop.body30
loop.body30:
  %t281 = load double, double* %l4
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load { i8**, i64 }, { i8**, i64 }* %t282
  %t284 = extractvalue { i8**, i64 } %t283, 1
  %t285 = sitofp i64 %t284 to double
  %t286 = fcmp oge double %t281, %t285
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t289 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t290 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t291 = load double, double* %l4
  %t292 = load i8*, i8** %l5
  %t293 = load i8*, i8** %l6
  %t294 = load i8*, i8** %l17
  %t295 = load i8*, i8** %l18
  %t296 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t297 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t298 = load i8*, i8** %l21
  br i1 %t286, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t300 = load double, double* %l4
  %t301 = load { i8**, i64 }, { i8**, i64 }* %t299
  %t302 = extractvalue { i8**, i64 } %t301, 0
  %t303 = extractvalue { i8**, i64 } %t301, 1
  %t304 = icmp uge i64 %t300, %t303
  ; bounds check: %t304 (if true, out of bounds)
  %t305 = getelementptr i8*, i8** %t302, i64 %t300
  %t306 = load i8*, i8** %t305
  %t307 = call i8* @trim_text(i8* %t306)
  store i8* %t307, i8** %l22
  %t308 = load i8*, i8** %l22
  %t310 = load i8*, i8** %l22
  %s311 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.311, i32 0, i32 0
  %t312 = call i1 @starts_with(i8* %t310, i8* %s311)
  br label %logical_and_entry_309

logical_and_entry_309:
  br i1 %t312, label %logical_and_right_309, label %logical_and_merge_309

logical_and_right_309:
  %t313 = load i8*, i8** %l22
  %s314 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.314, i32 0, i32 0
  %t315 = call i1 @starts_with(i8* %t313, i8* %s314)
  %t316 = xor i1 %t315, 1
  br label %logical_and_right_end_309

logical_and_right_end_309:
  br label %logical_and_merge_309

logical_and_merge_309:
  %t317 = phi i1 [ false, %logical_and_entry_309 ], [ %t316, %logical_and_right_end_309 ]
  %t318 = xor i1 %t317, 1
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t321 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t322 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t323 = load double, double* %l4
  %t324 = load i8*, i8** %l5
  %t325 = load i8*, i8** %l6
  %t326 = load i8*, i8** %l17
  %t327 = load i8*, i8** %l18
  %t328 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t329 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t330 = load i8*, i8** %l21
  %t331 = load i8*, i8** %l22
  br i1 %t318, label %then35, label %merge36
then35:
  br label %afterloop32
merge36:
  %t332 = load i8*, i8** %l22
  %s333 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.333, i32 0, i32 0
  %t334 = call i1 @starts_with(i8* %t332, i8* %s333)
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
  %t347 = load i8*, i8** %l22
  br i1 %t334, label %then37, label %else38
then37:
  %t348 = load i8*, i8** %l22
  %s349 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.349, i32 0, i32 0
  %t350 = call i8* @strip_prefix(i8* %t348, i8* %s349)
  store i8* %t350, i8** %l23
  %t351 = load i8*, i8** %l17
  %s352 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.352, i32 0, i32 0
  %t353 = call i8* @strip_prefix(i8* %t351, i8* %s352)
  store i8* %t353, i8** %l24
  %t354 = load i8*, i8** %l24
  %t355 = load i8*, i8** %l21
  %t356 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t354, i8* %t355)
  store %EnumLayoutVariantParse %t356, %EnumLayoutVariantParse* %l25
  %t357 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t358 = extractvalue %EnumLayoutVariantParse %t357, 2
  %t359 = call double @diagnosticsconcat({ i8**, i64 }* %t358)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t360 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t361 = extractvalue %EnumLayoutVariantParse %t360, 0
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t364 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t365 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t366 = load double, double* %l4
  %t367 = load i8*, i8** %l5
  %t368 = load i8*, i8** %l6
  %t369 = load i8*, i8** %l17
  %t370 = load i8*, i8** %l18
  %t371 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t372 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t373 = load i8*, i8** %l21
  %t374 = load i8*, i8** %l22
  %t375 = load i8*, i8** %l23
  %t376 = load i8*, i8** %l24
  %t377 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t361, label %then40, label %merge41
then40:
  %t378 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t379 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t380 = extractvalue %EnumLayoutVariantParse %t379, 1
  %t381 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t378, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t381, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge41
merge41:
  %t382 = phi { %NativeEnumVariantLayout*, i64 }* [ %t381, %then40 ], [ %t372, %then37 ]
  store { %NativeEnumVariantLayout*, i64 }* %t382, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge39
else38:
  %t383 = load i8*, i8** %l22
  %s384 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.384, i32 0, i32 0
  %t385 = call i1 @starts_with(i8* %t383, i8* %s384)
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t388 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t389 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t390 = load double, double* %l4
  %t391 = load i8*, i8** %l5
  %t392 = load i8*, i8** %l6
  %t393 = load i8*, i8** %l17
  %t394 = load i8*, i8** %l18
  %t395 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t396 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t397 = load i8*, i8** %l21
  %t398 = load i8*, i8** %l22
  br i1 %t385, label %then42, label %merge43
then42:
  %t399 = load i8*, i8** %l22
  %s400 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.400, i32 0, i32 0
  %t401 = call i8* @strip_prefix(i8* %t399, i8* %s400)
  store i8* %t401, i8** %l26
  %t402 = load i8*, i8** %l17
  %s403 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.403, i32 0, i32 0
  %t404 = call i8* @strip_prefix(i8* %t402, i8* %s403)
  store i8* %t404, i8** %l27
  %t405 = load i8*, i8** %l27
  %t406 = load i8*, i8** %l21
  %t407 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t405, i8* %t406)
  store %EnumLayoutPayloadParse %t407, %EnumLayoutPayloadParse* %l28
  %t408 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t409 = extractvalue %EnumLayoutPayloadParse %t408, 3
  %t410 = call double @diagnosticsconcat({ i8**, i64 }* %t409)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t412 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t413 = extractvalue %EnumLayoutPayloadParse %t412, 0
  br label %logical_and_entry_411

logical_and_entry_411:
  br i1 %t413, label %logical_and_right_411, label %logical_and_merge_411

logical_and_right_411:
  %t414 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t415 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t414
  %t416 = extractvalue { %NativeEnumVariantLayout*, i64 } %t415, 1
  %t417 = icmp sgt i64 %t416, 0
  br label %logical_and_right_end_411

logical_and_right_end_411:
  br label %logical_and_merge_411

logical_and_merge_411:
  %t418 = phi i1 [ false, %logical_and_entry_411 ], [ %t417, %logical_and_right_end_411 ]
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t421 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t422 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t423 = load double, double* %l4
  %t424 = load i8*, i8** %l5
  %t425 = load i8*, i8** %l6
  %t426 = load i8*, i8** %l17
  %t427 = load i8*, i8** %l18
  %t428 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t429 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t430 = load i8*, i8** %l21
  %t431 = load i8*, i8** %l22
  %t432 = load i8*, i8** %l26
  %t433 = load i8*, i8** %l27
  %t434 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t418, label %then44, label %merge45
then44:
  %t435 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t436 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t435
  %t437 = extractvalue { %NativeEnumVariantLayout*, i64 } %t436, 1
  %t438 = sub i64 %t437, 1
  store i64 %t438, i64* %l29
  %t439 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t440 = load i64, i64* %l29
  %t441 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t439
  %t442 = extractvalue { %NativeEnumVariantLayout*, i64 } %t441, 0
  %t443 = extractvalue { %NativeEnumVariantLayout*, i64 } %t441, 1
  %t444 = icmp uge i64 %t440, %t443
  ; bounds check: %t444 (if true, out of bounds)
  %t445 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t442, i64 %t440
  %t446 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t445
  store %NativeEnumVariantLayout %t446, %NativeEnumVariantLayout* %l30
  %t447 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t448 = extractvalue %NativeEnumVariantLayout %t447, 5
  %t449 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t450 = extractvalue %EnumLayoutPayloadParse %t449, 2
  %t451 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* null, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t451, { %NativeStructLayoutField*, i64 }** %l31
  br label %merge45
merge45:
  br label %merge43
merge43:
  %t452 = phi i8* [ %t401, %then42 ], [ %t393, %else38 ]
  %t453 = phi { i8**, i64 }* [ null, %then42 ], [ %t387, %else38 ]
  store i8* %t452, i8** %l17
  store { i8**, i64 }* %t453, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t454 = phi i8* [ %t350, %then37 ], [ %t401, %else38 ]
  %t455 = phi { i8**, i64 }* [ null, %then37 ], [ null, %else38 ]
  %t456 = phi { %NativeEnumVariantLayout*, i64 }* [ %t381, %then37 ], [ %t345, %else38 ]
  store i8* %t454, i8** %l17
  store { i8**, i64 }* %t455, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t456, { %NativeEnumVariantLayout*, i64 }** %l20
  %t457 = load double, double* %l4
  %t458 = sitofp i64 1 to double
  %t459 = fadd double %t457, %t458
  store double %t459, double* %l4
  br label %loop.latch31
loop.latch31:
  %t460 = load i8*, i8** %l17
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t462 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t463 = load double, double* %l4
  br label %loop.header29
afterloop32:
  store double 0.0, double* %l32
  %t468 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t469 = load double, double* %l32
  %t470 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t468, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t470, { %NativeEnum*, i64 }** %l3
  br label %merge28
else27:
  %t471 = load double, double* %l4
  %t472 = sitofp i64 1 to double
  %t473 = fadd double %t471, %t472
  store double %t473, double* %l4
  br label %merge28
merge28:
  %t474 = phi double [ %t268, %then26 ], [ %t473, %else27 ]
  %t475 = phi i8* [ %t350, %then26 ], [ %t256, %else27 ]
  %t476 = phi { i8**, i64 }* [ null, %then26 ], [ %t250, %else27 ]
  %t477 = phi { %NativeEnum*, i64 }* [ %t470, %then26 ], [ %t252, %else27 ]
  store double %t474, double* %l4
  store i8* %t475, i8** %l17
  store { i8**, i64 }* %t476, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t477, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge25:
  %t478 = load double, double* %l4
  %t479 = sitofp i64 1 to double
  %t480 = fadd double %t478, %t479
  store double %t480, double* %l4
  br label %loop.latch2
loop.latch2:
  %t481 = load double, double* %l4
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t484 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t489 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t490 = insertvalue %LayoutManifest undef, { i8**, i64 }* null, 0
  %t491 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t492 = insertvalue %LayoutManifest %t490, { i8**, i64 }* null, 1
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = insertvalue %LayoutManifest %t492, { i8**, i64 }* %t493, 2
  ret %LayoutManifest %t494
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
  %t6 = call double @valuesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
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
  %t6 = call double @valuesconcat({ %NativeParameter*, i64 }* %t3)
  ret { %NativeParameter*, i64 }* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
