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

%NativeInstruction = type { i32, [48 x i8] }

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.2 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.13 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.13 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.24 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.102 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.8 = private unnamed_addr constant [1 x i8] c"\00"
@.str.13 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.18 = private unnamed_addr constant [2 x i8] c" \00"
@.str.48 = private unnamed_addr constant [2 x i8] c".\00"
@.str.0 = private unnamed_addr constant [6 x i8] c".let \00"
@.str.50 = private unnamed_addr constant [2 x i8] c"=\00"
@.str.2 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.4 = private unnamed_addr constant [2 x i8] c"9\00"
@.str.5 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"\0D\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"\09\00"

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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %NativeFunction*, i64 }* null, { %NativeFunction*, i64 }** %l2
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %NativeImport*, i64 }* null, { %NativeImport*, i64 }** %l3
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { %NativeStruct*, i64 }* null, { %NativeStruct*, i64 }** %l4
  %t21 = alloca [0 x double]
  %t22 = getelementptr [0 x double], [0 x double]* %t21, i32 0, i32 0
  %t23 = alloca { double*, i64 }
  %t24 = getelementptr { double*, i64 }, { double*, i64 }* %t23, i32 0, i32 0
  store double* %t22, double** %t24
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  store { %NativeInterface*, i64 }* null, { %NativeInterface*, i64 }** %l5
  %t26 = alloca [0 x double]
  %t27 = getelementptr [0 x double], [0 x double]* %t26, i32 0, i32 0
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t27, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeEnum*, i64 }* null, { %NativeEnum*, i64 }** %l6
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %NativeBinding*, i64 }* null, { %NativeBinding*, i64 }** %l7
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
  %t924 = phi double [ %t48, %entry ], [ %t915, %loop.latch2 ]
  %t925 = phi { i8**, i64 }* [ %t38, %entry ], [ %t916, %loop.latch2 ]
  %t926 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t917, %loop.latch2 ]
  %t927 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t918, %loop.latch2 ]
  %t928 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t919, %loop.latch2 ]
  %t929 = phi i8* [ %t45, %entry ], [ %t920, %loop.latch2 ]
  %t930 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t921, %loop.latch2 ]
  %t931 = phi i8* [ %t46, %entry ], [ %t922, %loop.latch2 ]
  %t932 = phi i8* [ %t47, %entry ], [ %t923, %loop.latch2 ]
  store double %t924, double* %l11
  store { i8**, i64 }* %t925, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t926, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t927, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t928, { %NativeEnum*, i64 }** %l6
  store i8* %t929, i8** %l8
  store { %NativeFunction*, i64 }* %t930, { %NativeFunction*, i64 }** %l2
  store i8* %t931, i8** %l9
  store i8* %t932, i8** %l10
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
  %s79 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @starts_with(i8* %t78, i8* %s79)
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
  %s99 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.99, i32 0, i32 0
  %t100 = call i1 @starts_with(i8* %t98, i8* %s99)
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t103 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t104 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t105 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t106 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t107 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t108 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t109 = load i8*, i8** %l8
  %t110 = load i8*, i8** %l9
  %t111 = load i8*, i8** %l10
  %t112 = load double, double* %l11
  %t113 = load i8*, i8** %l12
  %t114 = load i8*, i8** %l13
  br i1 %t100, label %then8, label %merge9
then8:
  %t115 = load double, double* %l11
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l11
  br label %loop.latch2
merge9:
  %t118 = load i8*, i8** %l13
  %s119 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.119, i32 0, i32 0
  %t120 = call i1 @starts_with(i8* %t118, i8* %s119)
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t123 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t124 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t125 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t126 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t127 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t128 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t129 = load i8*, i8** %l8
  %t130 = load i8*, i8** %l9
  %t131 = load i8*, i8** %l10
  %t132 = load double, double* %l11
  %t133 = load i8*, i8** %l12
  %t134 = load i8*, i8** %l13
  br i1 %t120, label %then10, label %merge11
then10:
  %s135 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.135, i32 0, i32 0
  %t136 = load i8*, i8** %l13
  %s137 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i8* @strip_prefix(i8* %t136, i8* %s137)
  %t139 = call double @parse_import_entry(i8* %s135, i8* %t138)
  store double %t139, double* %l14
  %t140 = load double, double* %l14
  %t141 = load double, double* %l11
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l11
  br label %loop.latch2
merge11:
  %t144 = load i8*, i8** %l13
  %s145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.145, i32 0, i32 0
  %t146 = call i1 @starts_with(i8* %t144, i8* %s145)
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t150 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t151 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t152 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t153 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t154 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t155 = load i8*, i8** %l8
  %t156 = load i8*, i8** %l9
  %t157 = load i8*, i8** %l10
  %t158 = load double, double* %l11
  %t159 = load i8*, i8** %l12
  %t160 = load i8*, i8** %l13
  br i1 %t146, label %then12, label %merge13
then12:
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.161, i32 0, i32 0
  %t162 = load i8*, i8** %l13
  %s163 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.163, i32 0, i32 0
  %t164 = call i8* @strip_prefix(i8* %t162, i8* %s163)
  %t165 = call double @parse_import_entry(i8* %s161, i8* %t164)
  store double %t165, double* %l15
  %t166 = load double, double* %l15
  %t167 = load double, double* %l11
  %t168 = sitofp i64 1 to double
  %t169 = fadd double %t167, %t168
  store double %t169, double* %l11
  br label %loop.latch2
merge13:
  %t170 = load i8*, i8** %l13
  %s171 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.171, i32 0, i32 0
  %t172 = call i1 @starts_with(i8* %t170, i8* %s171)
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t176 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t177 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t178 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t179 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t180 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t181 = load i8*, i8** %l8
  %t182 = load i8*, i8** %l9
  %t183 = load i8*, i8** %l10
  %t184 = load double, double* %l11
  %t185 = load i8*, i8** %l12
  %t186 = load i8*, i8** %l13
  br i1 %t172, label %then14, label %merge15
then14:
  %t187 = load i8*, i8** %l13
  %s188 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.188, i32 0, i32 0
  %t189 = call i8* @strip_prefix(i8* %t187, i8* %s188)
  %t190 = call double @parse_source_span(i8* %t189)
  store double %t190, double* %l16
  %t191 = load double, double* %l16
  %t192 = load double, double* %l11
  %t193 = sitofp i64 1 to double
  %t194 = fadd double %t192, %t193
  store double %t194, double* %l11
  br label %loop.latch2
merge15:
  %t195 = load i8*, i8** %l13
  %t196 = load i8*, i8** %l13
  %s197 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.197, i32 0, i32 0
  %t198 = call i1 @starts_with(i8* %t196, i8* %s197)
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t201 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t202 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t203 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t204 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t205 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t206 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t207 = load i8*, i8** %l8
  %t208 = load i8*, i8** %l9
  %t209 = load i8*, i8** %l10
  %t210 = load double, double* %l11
  %t211 = load i8*, i8** %l12
  %t212 = load i8*, i8** %l13
  br i1 %t198, label %then16, label %merge17
then16:
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load double, double* %l11
  %t215 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t213, double %t214)
  store %StructParseResult %t215, %StructParseResult* %l17
  %t216 = load %StructParseResult, %StructParseResult* %l17
  %t217 = extractvalue %StructParseResult %t216, 2
  %t218 = call double @diagnosticsconcat({ i8**, i64 }* %t217)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t264 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t265 = extractvalue %InterfaceParseResult %t264, 2
  %t266 = call double @diagnosticsconcat({ i8**, i64 }* %t265)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t267 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t268 = extractvalue %InterfaceParseResult %t267, 0
  %t269 = icmp ne i8* %t268, null
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t272 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t273 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t274 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t275 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t276 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t277 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t278 = load i8*, i8** %l8
  %t279 = load i8*, i8** %l9
  %t280 = load i8*, i8** %l10
  %t281 = load double, double* %l11
  %t282 = load i8*, i8** %l12
  %t283 = load i8*, i8** %l13
  %t284 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  br i1 %t269, label %then22, label %merge23
then22:
  %t285 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t286 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t287 = extractvalue %InterfaceParseResult %t286, 0
  %t288 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t285, %NativeInterface zeroinitializer)
  store { %NativeInterface*, i64 }* %t288, { %NativeInterface*, i64 }** %l5
  br label %merge23
merge23:
  %t289 = phi { %NativeInterface*, i64 }* [ %t288, %then22 ], [ %t275, %then20 ]
  store { %NativeInterface*, i64 }* %t289, { %NativeInterface*, i64 }** %l5
  %t290 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t291 = extractvalue %InterfaceParseResult %t290, 1
  store double %t291, double* %l11
  br label %loop.latch2
merge21:
  %t292 = load i8*, i8** %l13
  %s293 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.293, i32 0, i32 0
  %t294 = call i1 @starts_with(i8* %t292, i8* %s293)
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
  br i1 %t294, label %then24, label %merge25
then24:
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t310 = load double, double* %l11
  %t311 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t309, double %t310)
  store %EnumParseResult %t311, %EnumParseResult* %l19
  %t312 = load %EnumParseResult, %EnumParseResult* %l19
  %t313 = extractvalue %EnumParseResult %t312, 2
  %t314 = call double @diagnosticsconcat({ i8**, i64 }* %t313)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t315 = load %EnumParseResult, %EnumParseResult* %l19
  %t316 = extractvalue %EnumParseResult %t315, 0
  %t317 = icmp ne i8* %t316, null
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t320 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t321 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t322 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t323 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t324 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t325 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t326 = load i8*, i8** %l8
  %t327 = load i8*, i8** %l9
  %t328 = load i8*, i8** %l10
  %t329 = load double, double* %l11
  %t330 = load i8*, i8** %l12
  %t331 = load i8*, i8** %l13
  %t332 = load %EnumParseResult, %EnumParseResult* %l19
  br i1 %t317, label %then26, label %merge27
then26:
  %t333 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t334 = load %EnumParseResult, %EnumParseResult* %l19
  %t335 = extractvalue %EnumParseResult %t334, 0
  %t336 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t333, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t336, { %NativeEnum*, i64 }** %l6
  br label %merge27
merge27:
  %t337 = phi { %NativeEnum*, i64 }* [ %t336, %then26 ], [ %t324, %then24 ]
  store { %NativeEnum*, i64 }* %t337, { %NativeEnum*, i64 }** %l6
  %t338 = load %EnumParseResult, %EnumParseResult* %l19
  %t339 = extractvalue %EnumParseResult %t338, 1
  store double %t339, double* %l11
  br label %loop.latch2
merge25:
  %t340 = load i8*, i8** %l13
  %s341 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.341, i32 0, i32 0
  %t342 = call i1 @starts_with(i8* %t340, i8* %s341)
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t345 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t346 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t347 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t348 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t349 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t350 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t351 = load i8*, i8** %l8
  %t352 = load i8*, i8** %l9
  %t353 = load i8*, i8** %l10
  %t354 = load double, double* %l11
  %t355 = load i8*, i8** %l12
  %t356 = load i8*, i8** %l13
  br i1 %t342, label %then28, label %merge29
then28:
  %t357 = load i8*, i8** %l8
  %t358 = icmp ne i8* %t357, null
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t361 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t362 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t363 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t364 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t365 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t366 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t367 = load i8*, i8** %l8
  %t368 = load i8*, i8** %l9
  %t369 = load i8*, i8** %l10
  %t370 = load double, double* %l11
  %t371 = load i8*, i8** %l12
  %t372 = load i8*, i8** %l13
  br i1 %t358, label %then30, label %merge31
then30:
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s374 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.374, i32 0, i32 0
  %t375 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t373, i8* %s374)
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t376 = phi { i8**, i64 }* [ %t375, %then30 ], [ %t360, %then28 ]
  store { i8**, i64 }* %t376, { i8**, i64 }** %l1
  %t377 = load double, double* %l11
  %t378 = sitofp i64 1 to double
  %t379 = fadd double %t377, %t378
  store double %t379, double* %l11
  br label %loop.latch2
merge29:
  %t380 = load i8*, i8** %l13
  %s381 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.381, i32 0, i32 0
  %t382 = call i1 @starts_with(i8* %t380, i8* %s381)
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t385 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t386 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t387 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t388 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t389 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t390 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t391 = load i8*, i8** %l8
  %t392 = load i8*, i8** %l9
  %t393 = load i8*, i8** %l10
  %t394 = load double, double* %l11
  %t395 = load i8*, i8** %l12
  %t396 = load i8*, i8** %l13
  br i1 %t382, label %then32, label %merge33
then32:
  %t397 = load i8*, i8** %l8
  %t398 = icmp eq i8* %t397, null
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t401 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t402 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t403 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t404 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t405 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t406 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t407 = load i8*, i8** %l8
  %t408 = load i8*, i8** %l9
  %t409 = load i8*, i8** %l10
  %t410 = load double, double* %l11
  %t411 = load i8*, i8** %l12
  %t412 = load i8*, i8** %l13
  br i1 %t398, label %then34, label %else35
then34:
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s414 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.414, i32 0, i32 0
  %t415 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t413, i8* %s414)
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  br label %merge36
else35:
  %t416 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t417 = load i8*, i8** %l8
  %t418 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t416, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t418, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge36
merge36:
  %t419 = phi { i8**, i64 }* [ %t415, %then34 ], [ %t400, %else35 ]
  %t420 = phi { %NativeFunction*, i64 }* [ %t401, %then34 ], [ %t418, %else35 ]
  %t421 = phi i8* [ %t407, %then34 ], [ null, %else35 ]
  store { i8**, i64 }* %t419, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t420, { %NativeFunction*, i64 }** %l2
  store i8* %t421, i8** %l8
  %t422 = load double, double* %l11
  %t423 = sitofp i64 1 to double
  %t424 = fadd double %t422, %t423
  store double %t424, double* %l11
  br label %loop.latch2
merge33:
  %t425 = load i8*, i8** %l13
  %s426 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.426, i32 0, i32 0
  %t427 = call i1 @starts_with(i8* %t425, i8* %s426)
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t430 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t431 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t432 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t433 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t434 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t435 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t436 = load i8*, i8** %l8
  %t437 = load i8*, i8** %l9
  %t438 = load i8*, i8** %l10
  %t439 = load double, double* %l11
  %t440 = load i8*, i8** %l12
  %t441 = load i8*, i8** %l13
  br i1 %t427, label %then37, label %merge38
then37:
  %t442 = load i8*, i8** %l8
  %t443 = icmp ne i8* %t442, null
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t447 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t448 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t449 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t450 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t451 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t452 = load i8*, i8** %l8
  %t453 = load i8*, i8** %l9
  %t454 = load i8*, i8** %l10
  %t455 = load double, double* %l11
  %t456 = load i8*, i8** %l12
  %t457 = load i8*, i8** %l13
  br i1 %t443, label %then39, label %else40
then39:
  %t458 = load i8*, i8** %l8
  %t459 = load i8*, i8** %l13
  %s460 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.460, i32 0, i32 0
  %t461 = call i8* @strip_prefix(i8* %t459, i8* %s460)
  %t462 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t461)
  store i8* null, i8** %l8
  br label %merge41
else40:
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s464 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.464, i32 0, i32 0
  %t465 = load i8*, i8** %l13
  %t466 = add i8* %s464, %t465
  %t467 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t463, i8* %t466)
  store { i8**, i64 }* %t467, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t468 = phi i8* [ null, %then39 ], [ %t452, %else40 ]
  %t469 = phi { i8**, i64 }* [ %t445, %then39 ], [ %t467, %else40 ]
  store i8* %t468, i8** %l8
  store { i8**, i64 }* %t469, { i8**, i64 }** %l1
  %t470 = load double, double* %l11
  %t471 = sitofp i64 1 to double
  %t472 = fadd double %t470, %t471
  store double %t472, double* %l11
  br label %loop.latch2
merge38:
  %t473 = load i8*, i8** %l13
  %s474 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.474, i32 0, i32 0
  %t475 = call i1 @starts_with(i8* %t473, i8* %s474)
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t479 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t480 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t481 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t482 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t483 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t484 = load i8*, i8** %l8
  %t485 = load i8*, i8** %l9
  %t486 = load i8*, i8** %l10
  %t487 = load double, double* %l11
  %t488 = load i8*, i8** %l12
  %t489 = load i8*, i8** %l13
  br i1 %t475, label %then42, label %merge43
then42:
  %t490 = load i8*, i8** %l8
  %t491 = icmp ne i8* %t490, null
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t495 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t496 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t497 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t498 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t499 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t500 = load i8*, i8** %l8
  %t501 = load i8*, i8** %l9
  %t502 = load i8*, i8** %l10
  %t503 = load double, double* %l11
  %t504 = load i8*, i8** %l12
  %t505 = load i8*, i8** %l13
  br i1 %t491, label %then44, label %else45
then44:
  %t506 = load i8*, i8** %l13
  %s507 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.507, i32 0, i32 0
  %t508 = call i8* @strip_prefix(i8* %t506, i8* %s507)
  store i8* %t508, i8** %l20
  %t509 = load double, double* %l11
  %t510 = sitofp i64 1 to double
  %t511 = fadd double %t509, %t510
  store double %t511, double* %l21
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t515 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t516 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t517 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t518 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t519 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t520 = load i8*, i8** %l8
  %t521 = load i8*, i8** %l9
  %t522 = load i8*, i8** %l10
  %t523 = load double, double* %l11
  %t524 = load i8*, i8** %l12
  %t525 = load i8*, i8** %l13
  %t526 = load i8*, i8** %l20
  %t527 = load double, double* %l21
  br label %loop.header47
loop.header47:
  %t593 = phi i8* [ %t526, %then44 ], [ %t591, %loop.latch49 ]
  %t594 = phi double [ %t527, %then44 ], [ %t592, %loop.latch49 ]
  store i8* %t593, i8** %l20
  store double %t594, double* %l21
  br label %loop.body48
loop.body48:
  %t528 = load double, double* %l21
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t530 = load { i8**, i64 }, { i8**, i64 }* %t529
  %t531 = extractvalue { i8**, i64 } %t530, 1
  %t532 = sitofp i64 %t531 to double
  %t533 = fcmp oge double %t528, %t532
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t536 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t537 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t538 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t539 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t540 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t541 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t542 = load i8*, i8** %l8
  %t543 = load i8*, i8** %l9
  %t544 = load i8*, i8** %l10
  %t545 = load double, double* %l11
  %t546 = load i8*, i8** %l12
  %t547 = load i8*, i8** %l13
  %t548 = load i8*, i8** %l20
  %t549 = load double, double* %l21
  br i1 %t533, label %then51, label %merge52
then51:
  br label %afterloop50
merge52:
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t551 = load double, double* %l21
  %t552 = load { i8**, i64 }, { i8**, i64 }* %t550
  %t553 = extractvalue { i8**, i64 } %t552, 0
  %t554 = extractvalue { i8**, i64 } %t552, 1
  %t555 = icmp uge i64 %t551, %t554
  ; bounds check: %t555 (if true, out of bounds)
  %t556 = getelementptr i8*, i8** %t553, i64 %t551
  %t557 = load i8*, i8** %t556
  store i8* %t557, i8** %l22
  %t558 = load i8*, i8** %l22
  %t559 = load i8*, i8** %l22
  %t560 = call i8* @trim_text(i8* %t559)
  store i8* %t560, i8** %l23
  %t561 = load i8*, i8** %l23
  %t562 = load i8*, i8** %l23
  %t563 = call i1 @line_looks_like_parameter_entry(i8* %t562)
  %t564 = xor i1 %t563, 1
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t567 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t568 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t569 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t570 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t571 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t572 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t573 = load i8*, i8** %l8
  %t574 = load i8*, i8** %l9
  %t575 = load i8*, i8** %l10
  %t576 = load double, double* %l11
  %t577 = load i8*, i8** %l12
  %t578 = load i8*, i8** %l13
  %t579 = load i8*, i8** %l20
  %t580 = load double, double* %l21
  %t581 = load i8*, i8** %l22
  %t582 = load i8*, i8** %l23
  br i1 %t564, label %then53, label %merge54
then53:
  br label %afterloop50
merge54:
  %t583 = load i8*, i8** %l20
  %s584 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.584, i32 0, i32 0
  %t585 = add i8* %t583, %s584
  %t586 = load i8*, i8** %l23
  %t587 = add i8* %t585, %t586
  store i8* %t587, i8** %l20
  %t588 = load double, double* %l21
  %t589 = sitofp i64 1 to double
  %t590 = fadd double %t588, %t589
  store double %t590, double* %l21
  br label %loop.latch49
loop.latch49:
  %t591 = load i8*, i8** %l20
  %t592 = load double, double* %l21
  br label %loop.header47
afterloop50:
  %t595 = load i8*, i8** %l20
  %t596 = call { i8**, i64 }* @split_parameter_entries(i8* %t595)
  store { i8**, i64 }* %t596, { i8**, i64 }** %l24
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t598 = load { i8**, i64 }, { i8**, i64 }* %t597
  %t599 = extractvalue { i8**, i64 } %t598, 1
  %t600 = icmp eq i64 %t599, 0
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t602 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t603 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t604 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t605 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t606 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t607 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t608 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t609 = load i8*, i8** %l8
  %t610 = load i8*, i8** %l9
  %t611 = load i8*, i8** %l10
  %t612 = load double, double* %l11
  %t613 = load i8*, i8** %l12
  %t614 = load i8*, i8** %l13
  %t615 = load i8*, i8** %l20
  %t616 = load double, double* %l21
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br i1 %t600, label %then55, label %else56
then55:
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s619 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.619, i32 0, i32 0
  %t620 = load i8*, i8** %l13
  %t621 = add i8* %s619, %t620
  %t622 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t618, i8* %t621)
  store { i8**, i64 }* %t622, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge57
else56:
  %t623 = sitofp i64 0 to double
  store double %t623, double* %l25
  store i1 0, i1* %l26
  %t624 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t626 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t627 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t628 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t629 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t630 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t631 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t632 = load i8*, i8** %l8
  %t633 = load i8*, i8** %l9
  %t634 = load i8*, i8** %l10
  %t635 = load double, double* %l11
  %t636 = load i8*, i8** %l12
  %t637 = load i8*, i8** %l13
  %t638 = load i8*, i8** %l20
  %t639 = load double, double* %l21
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t641 = load double, double* %l25
  %t642 = load i1, i1* %l26
  br label %loop.header58
loop.header58:
  %t708 = phi double [ %t641, %else56 ], [ %t707, %loop.latch60 ]
  store double %t708, double* %l25
  br label %loop.body59
loop.body59:
  %t643 = load double, double* %l25
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t645 = load { i8**, i64 }, { i8**, i64 }* %t644
  %t646 = extractvalue { i8**, i64 } %t645, 1
  %t647 = sitofp i64 %t646 to double
  %t648 = fcmp oge double %t643, %t647
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t652 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t653 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t654 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t655 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t656 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t657 = load i8*, i8** %l8
  %t658 = load i8*, i8** %l9
  %t659 = load i8*, i8** %l10
  %t660 = load double, double* %l11
  %t661 = load i8*, i8** %l12
  %t662 = load i8*, i8** %l13
  %t663 = load i8*, i8** %l20
  %t664 = load double, double* %l21
  %t665 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t666 = load double, double* %l25
  %t667 = load i1, i1* %l26
  br i1 %t648, label %then62, label %merge63
then62:
  br label %afterloop61
merge63:
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t669 = load double, double* %l25
  %t670 = load { i8**, i64 }, { i8**, i64 }* %t668
  %t671 = extractvalue { i8**, i64 } %t670, 0
  %t672 = extractvalue { i8**, i64 } %t670, 1
  %t673 = icmp uge i64 %t669, %t672
  ; bounds check: %t673 (if true, out of bounds)
  %t674 = getelementptr i8*, i8** %t671, i64 %t669
  %t675 = load i8*, i8** %t674
  store i8* %t675, i8** %l27
  %t676 = load i8*, i8** %l9
  store i8* %t676, i8** %l28
  %t677 = load i1, i1* %l26
  %t678 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t680 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t681 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t682 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t683 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t684 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t685 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t686 = load i8*, i8** %l8
  %t687 = load i8*, i8** %l9
  %t688 = load i8*, i8** %l10
  %t689 = load double, double* %l11
  %t690 = load i8*, i8** %l12
  %t691 = load i8*, i8** %l13
  %t692 = load i8*, i8** %l20
  %t693 = load double, double* %l21
  %t694 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t695 = load double, double* %l25
  %t696 = load i1, i1* %l26
  %t697 = load i8*, i8** %l27
  %t698 = load i8*, i8** %l28
  br i1 %t677, label %then64, label %merge65
then64:
  store i8* null, i8** %l28
  br label %merge65
merge65:
  %t699 = phi i8* [ null, %then64 ], [ %t698, %loop.body59 ]
  store i8* %t699, i8** %l28
  %t700 = load i8*, i8** %l27
  %t701 = load i8*, i8** %l28
  %t702 = call double @parse_parameter_entry(i8* %t700, i8* %t701)
  store double %t702, double* %l29
  %t703 = load double, double* %l29
  %t704 = load double, double* %l25
  %t705 = sitofp i64 1 to double
  %t706 = fadd double %t704, %t705
  store double %t706, double* %l25
  br label %loop.latch60
loop.latch60:
  %t707 = load double, double* %l25
  br label %loop.header58
afterloop61:
  store i8* null, i8** %l9
  br label %merge57
merge57:
  %t709 = phi { i8**, i64 }* [ %t622, %then55 ], [ %t602, %else56 ]
  %t710 = phi i8* [ null, %then55 ], [ null, %else56 ]
  store { i8**, i64 }* %t709, { i8**, i64 }** %l1
  store i8* %t710, i8** %l9
  %t711 = load double, double* %l21
  %t712 = sitofp i64 1 to double
  %t713 = fsub double %t711, %t712
  store double %t713, double* %l11
  br label %merge46
else45:
  %t714 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s715 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.715, i32 0, i32 0
  %t716 = load i8*, i8** %l13
  %t717 = add i8* %s715, %t716
  %t718 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t714, i8* %t717)
  store { i8**, i64 }* %t718, { i8**, i64 }** %l1
  br label %merge46
merge46:
  %t719 = phi { i8**, i64 }* [ %t622, %then44 ], [ %t718, %else45 ]
  %t720 = phi i8* [ null, %then44 ], [ %t501, %else45 ]
  %t721 = phi double [ %t713, %then44 ], [ %t503, %else45 ]
  store { i8**, i64 }* %t719, { i8**, i64 }** %l1
  store i8* %t720, i8** %l9
  store double %t721, double* %l11
  %t722 = load double, double* %l11
  %t723 = sitofp i64 1 to double
  %t724 = fadd double %t722, %t723
  store double %t724, double* %l11
  br label %loop.latch2
merge43:
  %t725 = load i8*, i8** %l13
  %t726 = load i8*, i8** %l9
  %t727 = load i8*, i8** %l10
  %t728 = call %InstructionParseResult @parse_instruction(i8* %t725, i8* %t726, i8* %t727)
  store %InstructionParseResult %t728, %InstructionParseResult* %l30
  %t729 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t730 = extractvalue %InstructionParseResult %t729, 0
  store { i8**, i64 }* %t730, { i8**, i64 }** %l31
  %t731 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t732 = extractvalue %InstructionParseResult %t731, 1
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t734 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t735 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t736 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t737 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t738 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t739 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t740 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t741 = load i8*, i8** %l8
  %t742 = load i8*, i8** %l9
  %t743 = load i8*, i8** %l10
  %t744 = load double, double* %l11
  %t745 = load i8*, i8** %l12
  %t746 = load i8*, i8** %l13
  %t747 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t748 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t732, label %then66, label %else67
then66:
  store i8* null, i8** %l9
  br label %merge68
else67:
  %t749 = load i8*, i8** %l9
  %t750 = icmp ne i8* %t749, null
  %t751 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t752 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t753 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t754 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t755 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t756 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t757 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t758 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t759 = load i8*, i8** %l8
  %t760 = load i8*, i8** %l9
  %t761 = load i8*, i8** %l10
  %t762 = load double, double* %l11
  %t763 = load i8*, i8** %l12
  %t764 = load i8*, i8** %l13
  %t765 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t766 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t750, label %then69, label %merge70
then69:
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s768 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.768, i32 0, i32 0
  %t769 = load i8*, i8** %l13
  %t770 = add i8* %s768, %t769
  %t771 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t767, i8* %t770)
  store { i8**, i64 }* %t771, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge70
merge70:
  %t772 = phi { i8**, i64 }* [ %t771, %then69 ], [ %t752, %else67 ]
  %t773 = phi i8* [ null, %then69 ], [ %t760, %else67 ]
  store { i8**, i64 }* %t772, { i8**, i64 }** %l1
  store i8* %t773, i8** %l9
  br label %merge68
merge68:
  %t774 = phi i8* [ null, %then66 ], [ null, %else67 ]
  %t775 = phi { i8**, i64 }* [ %t734, %then66 ], [ %t771, %else67 ]
  store i8* %t774, i8** %l9
  store { i8**, i64 }* %t775, { i8**, i64 }** %l1
  %t776 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t777 = extractvalue %InstructionParseResult %t776, 2
  %t778 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t779 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t780 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t781 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t782 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t783 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t784 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t785 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t786 = load i8*, i8** %l8
  %t787 = load i8*, i8** %l9
  %t788 = load i8*, i8** %l10
  %t789 = load double, double* %l11
  %t790 = load i8*, i8** %l12
  %t791 = load i8*, i8** %l13
  %t792 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t793 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t777, label %then71, label %else72
then71:
  store i8* null, i8** %l10
  br label %merge73
else72:
  %t794 = load i8*, i8** %l10
  %t795 = icmp ne i8* %t794, null
  %t796 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t797 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t798 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t799 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t800 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t801 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t802 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t803 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t804 = load i8*, i8** %l8
  %t805 = load i8*, i8** %l9
  %t806 = load i8*, i8** %l10
  %t807 = load double, double* %l11
  %t808 = load i8*, i8** %l12
  %t809 = load i8*, i8** %l13
  %t810 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t811 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t795, label %then74, label %merge75
then74:
  %t812 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s813 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.813, i32 0, i32 0
  %t814 = load i8*, i8** %l13
  %t815 = add i8* %s813, %t814
  %t816 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t812, i8* %t815)
  store { i8**, i64 }* %t816, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge75
merge75:
  %t817 = phi { i8**, i64 }* [ %t816, %then74 ], [ %t797, %else72 ]
  %t818 = phi i8* [ null, %then74 ], [ %t806, %else72 ]
  store { i8**, i64 }* %t817, { i8**, i64 }** %l1
  store i8* %t818, i8** %l10
  br label %merge73
merge73:
  %t819 = phi i8* [ null, %then71 ], [ null, %else72 ]
  %t820 = phi { i8**, i64 }* [ %t779, %then71 ], [ %t816, %else72 ]
  store i8* %t819, i8** %l10
  store { i8**, i64 }* %t820, { i8**, i64 }** %l1
  %t821 = load i8*, i8** %l8
  %t822 = icmp eq i8* %t821, null
  %t823 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t824 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t825 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t826 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t827 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t828 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t829 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t830 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t831 = load i8*, i8** %l8
  %t832 = load i8*, i8** %l9
  %t833 = load i8*, i8** %l10
  %t834 = load double, double* %l11
  %t835 = load i8*, i8** %l12
  %t836 = load i8*, i8** %l13
  %t837 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t838 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t822, label %then76, label %merge77
then76:
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t841 = load { i8**, i64 }, { i8**, i64 }* %t840
  %t842 = extractvalue { i8**, i64 } %t841, 1
  %t843 = icmp eq i64 %t842, 1
  br label %logical_and_entry_839

logical_and_entry_839:
  br i1 %t843, label %logical_and_right_839, label %logical_and_merge_839

logical_and_right_839:
  %t844 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t845 = load { i8**, i64 }, { i8**, i64 }* %t844
  %t846 = extractvalue { i8**, i64 } %t845, 0
  %t847 = extractvalue { i8**, i64 } %t845, 1
  %t848 = icmp uge i64 0, %t847
  ; bounds check: %t848 (if true, out of bounds)
  %t849 = getelementptr i8*, i8** %t846, i64 0
  %t850 = load i8*, i8** %t849
  %t851 = load double, double* %l11
  %t852 = sitofp i64 1 to double
  %t853 = fadd double %t851, %t852
  store double %t853, double* %l11
  br label %loop.latch2
merge77:
  %t854 = sitofp i64 0 to double
  store double %t854, double* %l32
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
  %t869 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t870 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t871 = load double, double* %l32
  br label %loop.header78
loop.header78:
  %t910 = phi i8* [ %t863, %loop.body1 ], [ %t908, %loop.latch80 ]
  %t911 = phi double [ %t871, %loop.body1 ], [ %t909, %loop.latch80 ]
  store i8* %t910, i8** %l8
  store double %t911, double* %l32
  br label %loop.body79
loop.body79:
  %t872 = load double, double* %l32
  %t873 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t874 = load { i8**, i64 }, { i8**, i64 }* %t873
  %t875 = extractvalue { i8**, i64 } %t874, 1
  %t876 = sitofp i64 %t875 to double
  %t877 = fcmp oge double %t872, %t876
  %t878 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t879 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t880 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t881 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t882 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t883 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t884 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t885 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t886 = load i8*, i8** %l8
  %t887 = load i8*, i8** %l9
  %t888 = load i8*, i8** %l10
  %t889 = load double, double* %l11
  %t890 = load i8*, i8** %l12
  %t891 = load i8*, i8** %l13
  %t892 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t893 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t894 = load double, double* %l32
  br i1 %t877, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t895 = load i8*, i8** %l8
  %t896 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t897 = load double, double* %l32
  %t898 = load { i8**, i64 }, { i8**, i64 }* %t896
  %t899 = extractvalue { i8**, i64 } %t898, 0
  %t900 = extractvalue { i8**, i64 } %t898, 1
  %t901 = icmp uge i64 %t897, %t900
  ; bounds check: %t901 (if true, out of bounds)
  %t902 = getelementptr i8*, i8** %t899, i64 %t897
  %t903 = load i8*, i8** %t902
  %t904 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t905 = load double, double* %l32
  %t906 = sitofp i64 1 to double
  %t907 = fadd double %t905, %t906
  store double %t907, double* %l32
  br label %loop.latch80
loop.latch80:
  %t908 = load i8*, i8** %l8
  %t909 = load double, double* %l32
  br label %loop.header78
afterloop81:
  %t912 = load double, double* %l11
  %t913 = sitofp i64 1 to double
  %t914 = fadd double %t912, %t913
  store double %t914, double* %l11
  br label %loop.latch2
loop.latch2:
  %t915 = load double, double* %l11
  %t916 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t917 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t918 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t919 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t920 = load i8*, i8** %l8
  %t921 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t922 = load i8*, i8** %l9
  %t923 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t933 = load i8*, i8** %l8
  %t934 = icmp ne i8* %t933, null
  %t935 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t936 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t937 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t938 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t939 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t940 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t941 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t942 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t943 = load i8*, i8** %l8
  %t944 = load i8*, i8** %l9
  %t945 = load i8*, i8** %l10
  %t946 = load double, double* %l11
  br i1 %t934, label %then84, label %merge85
then84:
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s948 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.948, i32 0, i32 0
  %t949 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t947, i8* %s948)
  store { i8**, i64 }* %t949, { i8**, i64 }** %l1
  br label %merge85
merge85:
  %t950 = phi { i8**, i64 }* [ %t949, %then84 ], [ %t936, %entry ]
  store { i8**, i64 }* %t950, { i8**, i64 }** %l1
  %t951 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t952 = insertvalue %ParseNativeResult undef, { i8**, i64 }* null, 0
  %t953 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t954 = insertvalue %ParseNativeResult %t952, { i8**, i64 }* null, 1
  %t955 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t956 = insertvalue %ParseNativeResult %t954, { i8**, i64 }* null, 2
  %t957 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t958 = insertvalue %ParseNativeResult %t956, { i8**, i64 }* null, 3
  %t959 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t960 = insertvalue %ParseNativeResult %t958, { i8**, i64 }* null, 4
  %t961 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t962 = insertvalue %ParseNativeResult %t960, { i8**, i64 }* null, 5
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t964 = insertvalue %ParseNativeResult %t962, { i8**, i64 }* %t963, 6
  ret %ParseNativeResult %t964
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l0
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
  %t0 = insertvalue %NativeBinding undef, i8* null, 0
  %t1 = insertvalue %NativeBinding %t0, i1 false, 1
  %t2 = insertvalue %NativeBinding %t1, i8* null, 2
  %t3 = insertvalue %NativeBinding %t2, i8* null, 3
  ret %NativeBinding %t3
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
  %l8 = alloca i8*
  %l9 = alloca i1
  %l10 = alloca %BindingComponents
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %line, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call double @NativeInstructionNoop()
  %t3 = alloca [1 x double]
  %t4 = getelementptr [1 x double], [1 x double]* %t3, i32 0, i32 0
  %t5 = getelementptr double, double* %t4, i64 0
  store double %t2, double* %t5
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t4, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 1, i64* %t8
  %t9 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t10 = insertvalue %InstructionParseResult %t9, i1 0, 1
  %t11 = insertvalue %InstructionParseResult %t10, i1 0, 2
  ret %InstructionParseResult %t11
merge1:
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i1 @starts_with(i8* %line, i8* %s12)
  br i1 %t13, label %then2, label %merge3
then2:
  %s14 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i8* @strip_prefix(i8* %line, i8* %s14)
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = alloca %NativeInstruction
  %t18 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t17, i32 0, i32 0
  store i32 3, i32* %t18
  %t19 = load i8*, i8** %l0
  %t20 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t17, i32 0, i32 1
  %t21 = bitcast [8 x i8]* %t20 to i8*
  %t22 = bitcast i8* %t21 to i8**
  store i8* %t19, i8** %t22
  %t23 = load %NativeInstruction, %NativeInstruction* %t17
  %t24 = alloca [1 x %NativeInstruction]
  %t25 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t24, i32 0, i32 0
  %t26 = getelementptr %NativeInstruction, %NativeInstruction* %t25, i64 0
  store %NativeInstruction %t23, %NativeInstruction* %t26
  %t27 = alloca { %NativeInstruction*, i64 }
  %t28 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t27, i32 0, i32 0
  store %NativeInstruction* %t25, %NativeInstruction** %t28
  %t29 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t27, i32 0, i32 1
  store i64 1, i64* %t29
  %t30 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t31 = insertvalue %InstructionParseResult %t30, i1 0, 1
  %t32 = insertvalue %InstructionParseResult %t31, i1 0, 2
  ret %InstructionParseResult %t32
merge3:
  %s33 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp eq i8* %line, %s33
  br i1 %t34, label %then4, label %merge5
then4:
  %t35 = call double @NativeInstructionElse()
  %t36 = alloca [1 x double]
  %t37 = getelementptr [1 x double], [1 x double]* %t36, i32 0, i32 0
  %t38 = getelementptr double, double* %t37, i64 0
  store double %t35, double* %t38
  %t39 = alloca { double*, i64 }
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 0
  store double* %t37, double** %t40
  %t41 = getelementptr { double*, i64 }, { double*, i64 }* %t39, i32 0, i32 1
  store i64 1, i64* %t41
  %t42 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t43 = insertvalue %InstructionParseResult %t42, i1 0, 1
  %t44 = insertvalue %InstructionParseResult %t43, i1 0, 2
  ret %InstructionParseResult %t44
merge5:
  %s45 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.45, i32 0, i32 0
  %t46 = icmp eq i8* %line, %s45
  br i1 %t46, label %then6, label %merge7
then6:
  %t47 = call double @NativeInstructionEndIf()
  %t48 = alloca [1 x double]
  %t49 = getelementptr [1 x double], [1 x double]* %t48, i32 0, i32 0
  %t50 = getelementptr double, double* %t49, i64 0
  store double %t47, double* %t50
  %t51 = alloca { double*, i64 }
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t51, i32 0, i32 0
  store double* %t49, double** %t52
  %t53 = getelementptr { double*, i64 }, { double*, i64 }* %t51, i32 0, i32 1
  store i64 1, i64* %t53
  %t54 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t55 = insertvalue %InstructionParseResult %t54, i1 0, 1
  %t56 = insertvalue %InstructionParseResult %t55, i1 0, 2
  ret %InstructionParseResult %t56
merge7:
  %s57 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i1 @starts_with(i8* %line, i8* %s57)
  br i1 %t58, label %then8, label %merge9
then8:
  %s59 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.59, i32 0, i32 0
  %t60 = call i8* @strip_prefix(i8* %line, i8* %s59)
  %t61 = call i8* @trim_text(i8* %t60)
  store i8* %t61, i8** %l1
  %s62 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.62, i32 0, i32 0
  store i8* %s62, i8** %l2
  %t63 = load i8*, i8** %l1
  %t64 = load i8*, i8** %l2
  %t65 = call double @index_of(i8* %t63, i8* %t64)
  store double %t65, double* %l3
  %t66 = load double, double* %l3
  %t67 = sitofp i64 0 to double
  %t68 = fcmp oge double %t66, %t67
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l2
  %t71 = load double, double* %l3
  br i1 %t68, label %then10, label %merge11
then10:
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l3
  %t74 = call double @substring(i8* %t72, i64 0, double %t73)
  %t75 = call i8* @trim_text(i8* null)
  store i8* %t75, i8** %l4
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l2
  %t79 = load i8*, i8** %l1
  store double 0.0, double* %l5
  %t80 = alloca %NativeInstruction
  %t81 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t80, i32 0, i32 0
  store i32 6, i32* %t81
  %t82 = load i8*, i8** %l4
  %t83 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t80, i32 0, i32 1
  %t84 = bitcast [16 x i8]* %t83 to i8*
  %t85 = bitcast i8* %t84 to i8**
  store i8* %t82, i8** %t85
  %t86 = load double, double* %l5
  %t87 = call noalias i8* @malloc(i64 8)
  %t88 = bitcast i8* %t87 to double*
  store double %t86, double* %t88
  %t89 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t80, i32 0, i32 1
  %t90 = bitcast [16 x i8]* %t89 to i8*
  %t91 = getelementptr inbounds i8, i8* %t90, i64 8
  %t92 = bitcast i8* %t91 to i8**
  store i8* %t87, i8** %t92
  %t93 = load %NativeInstruction, %NativeInstruction* %t80
  %t94 = alloca [1 x %NativeInstruction]
  %t95 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t94, i32 0, i32 0
  %t96 = getelementptr %NativeInstruction, %NativeInstruction* %t95, i64 0
  store %NativeInstruction %t93, %NativeInstruction* %t96
  %t97 = alloca { %NativeInstruction*, i64 }
  %t98 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t97, i32 0, i32 0
  store %NativeInstruction* %t95, %NativeInstruction** %t98
  %t99 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t97, i32 0, i32 1
  store i64 1, i64* %t99
  %t100 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t101 = insertvalue %InstructionParseResult %t100, i1 0, 1
  %t102 = insertvalue %InstructionParseResult %t101, i1 0, 2
  ret %InstructionParseResult %t102
merge11:
  br label %merge9
merge9:
  %s103 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp eq i8* %line, %s103
  br i1 %t104, label %then12, label %merge13
then12:
  %t105 = call double @NativeInstructionEndFor()
  %t106 = alloca [1 x double]
  %t107 = getelementptr [1 x double], [1 x double]* %t106, i32 0, i32 0
  %t108 = getelementptr double, double* %t107, i64 0
  store double %t105, double* %t108
  %t109 = alloca { double*, i64 }
  %t110 = getelementptr { double*, i64 }, { double*, i64 }* %t109, i32 0, i32 0
  store double* %t107, double** %t110
  %t111 = getelementptr { double*, i64 }, { double*, i64 }* %t109, i32 0, i32 1
  store i64 1, i64* %t111
  %t112 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t113 = insertvalue %InstructionParseResult %t112, i1 0, 1
  %t114 = insertvalue %InstructionParseResult %t113, i1 0, 2
  ret %InstructionParseResult %t114
merge13:
  %s115 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.115, i32 0, i32 0
  %t116 = icmp eq i8* %line, %s115
  br i1 %t116, label %then14, label %merge15
then14:
  %t117 = call double @NativeInstructionLoop()
  %t118 = alloca [1 x double]
  %t119 = getelementptr [1 x double], [1 x double]* %t118, i32 0, i32 0
  %t120 = getelementptr double, double* %t119, i64 0
  store double %t117, double* %t120
  %t121 = alloca { double*, i64 }
  %t122 = getelementptr { double*, i64 }, { double*, i64 }* %t121, i32 0, i32 0
  store double* %t119, double** %t122
  %t123 = getelementptr { double*, i64 }, { double*, i64 }* %t121, i32 0, i32 1
  store i64 1, i64* %t123
  %t124 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t125 = insertvalue %InstructionParseResult %t124, i1 0, 1
  %t126 = insertvalue %InstructionParseResult %t125, i1 0, 2
  ret %InstructionParseResult %t126
merge15:
  %s127 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.127, i32 0, i32 0
  %t128 = icmp eq i8* %line, %s127
  br i1 %t128, label %then16, label %merge17
then16:
  %t129 = call double @NativeInstructionEndLoop()
  %t130 = alloca [1 x double]
  %t131 = getelementptr [1 x double], [1 x double]* %t130, i32 0, i32 0
  %t132 = getelementptr double, double* %t131, i64 0
  store double %t129, double* %t132
  %t133 = alloca { double*, i64 }
  %t134 = getelementptr { double*, i64 }, { double*, i64 }* %t133, i32 0, i32 0
  store double* %t131, double** %t134
  %t135 = getelementptr { double*, i64 }, { double*, i64 }* %t133, i32 0, i32 1
  store i64 1, i64* %t135
  %t136 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t137 = insertvalue %InstructionParseResult %t136, i1 0, 1
  %t138 = insertvalue %InstructionParseResult %t137, i1 0, 2
  ret %InstructionParseResult %t138
merge17:
  %s139 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.139, i32 0, i32 0
  %t140 = icmp eq i8* %line, %s139
  br i1 %t140, label %then18, label %merge19
then18:
  %t141 = call double @NativeInstructionBreak()
  %t142 = alloca [1 x double]
  %t143 = getelementptr [1 x double], [1 x double]* %t142, i32 0, i32 0
  %t144 = getelementptr double, double* %t143, i64 0
  store double %t141, double* %t144
  %t145 = alloca { double*, i64 }
  %t146 = getelementptr { double*, i64 }, { double*, i64 }* %t145, i32 0, i32 0
  store double* %t143, double** %t146
  %t147 = getelementptr { double*, i64 }, { double*, i64 }* %t145, i32 0, i32 1
  store i64 1, i64* %t147
  %t148 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t149 = insertvalue %InstructionParseResult %t148, i1 0, 1
  %t150 = insertvalue %InstructionParseResult %t149, i1 0, 2
  ret %InstructionParseResult %t150
merge19:
  %s151 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.151, i32 0, i32 0
  %t152 = icmp eq i8* %line, %s151
  br i1 %t152, label %then20, label %merge21
then20:
  %t153 = call double @NativeInstructionContinue()
  %t154 = alloca [1 x double]
  %t155 = getelementptr [1 x double], [1 x double]* %t154, i32 0, i32 0
  %t156 = getelementptr double, double* %t155, i64 0
  store double %t153, double* %t156
  %t157 = alloca { double*, i64 }
  %t158 = getelementptr { double*, i64 }, { double*, i64 }* %t157, i32 0, i32 0
  store double* %t155, double** %t158
  %t159 = getelementptr { double*, i64 }, { double*, i64 }* %t157, i32 0, i32 1
  store i64 1, i64* %t159
  %t160 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t161 = insertvalue %InstructionParseResult %t160, i1 0, 1
  %t162 = insertvalue %InstructionParseResult %t161, i1 0, 2
  ret %InstructionParseResult %t162
merge21:
  %s163 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.163, i32 0, i32 0
  %t164 = call i1 @starts_with(i8* %line, i8* %s163)
  br i1 %t164, label %then22, label %merge23
then22:
  %s165 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.165, i32 0, i32 0
  %t166 = call i8* @strip_prefix(i8* %line, i8* %s165)
  %t167 = call i8* @trim_text(i8* %t166)
  store i8* %t167, i8** %l6
  %t168 = alloca %NativeInstruction
  %t169 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t168, i32 0, i32 0
  store i32 12, i32* %t169
  %t170 = load i8*, i8** %l6
  %t171 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t168, i32 0, i32 1
  %t172 = bitcast [8 x i8]* %t171 to i8*
  %t173 = bitcast i8* %t172 to i8**
  store i8* %t170, i8** %t173
  %t174 = load %NativeInstruction, %NativeInstruction* %t168
  %t175 = alloca [1 x %NativeInstruction]
  %t176 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t175, i32 0, i32 0
  %t177 = getelementptr %NativeInstruction, %NativeInstruction* %t176, i64 0
  store %NativeInstruction %t174, %NativeInstruction* %t177
  %t178 = alloca { %NativeInstruction*, i64 }
  %t179 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t178, i32 0, i32 0
  store %NativeInstruction* %t176, %NativeInstruction** %t179
  %t180 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t178, i32 0, i32 1
  store i64 1, i64* %t180
  %t181 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t182 = insertvalue %InstructionParseResult %t181, i1 0, 1
  %t183 = insertvalue %InstructionParseResult %t182, i1 0, 2
  ret %InstructionParseResult %t183
merge23:
  %s184 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.184, i32 0, i32 0
  %t185 = call i1 @starts_with(i8* %line, i8* %s184)
  br i1 %t185, label %then24, label %merge25
then24:
  %t186 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t187 = alloca [1 x %NativeInstruction]
  %t188 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t187, i32 0, i32 0
  %t189 = getelementptr %NativeInstruction, %NativeInstruction* %t188, i64 0
  store %NativeInstruction %t186, %NativeInstruction* %t189
  %t190 = alloca { %NativeInstruction*, i64 }
  %t191 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t190, i32 0, i32 0
  store %NativeInstruction* %t188, %NativeInstruction** %t191
  %t192 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t190, i32 0, i32 1
  store i64 1, i64* %t192
  %t193 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t194 = insertvalue %InstructionParseResult %t193, i1 0, 1
  %t195 = insertvalue %InstructionParseResult %t194, i1 0, 2
  ret %InstructionParseResult %t195
merge25:
  %s196 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.196, i32 0, i32 0
  %t197 = icmp eq i8* %line, %s196
  br i1 %t197, label %then26, label %merge27
then26:
  %t198 = call double @NativeInstructionEndMatch()
  %t199 = alloca [1 x double]
  %t200 = getelementptr [1 x double], [1 x double]* %t199, i32 0, i32 0
  %t201 = getelementptr double, double* %t200, i64 0
  store double %t198, double* %t201
  %t202 = alloca { double*, i64 }
  %t203 = getelementptr { double*, i64 }, { double*, i64 }* %t202, i32 0, i32 0
  store double* %t200, double** %t203
  %t204 = getelementptr { double*, i64 }, { double*, i64 }* %t202, i32 0, i32 1
  store i64 1, i64* %t204
  %t205 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t206 = insertvalue %InstructionParseResult %t205, i1 0, 1
  %t207 = insertvalue %InstructionParseResult %t206, i1 0, 2
  ret %InstructionParseResult %t207
merge27:
  %s208 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.208, i32 0, i32 0
  %t209 = call i1 @starts_with(i8* %line, i8* %s208)
  br i1 %t209, label %then28, label %merge29
then28:
  %t210 = call %NativeInstruction @parse_let_instruction(i8* %line, i8* %span, i8* %value_span)
  %t211 = alloca [1 x %NativeInstruction]
  %t212 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t211, i32 0, i32 0
  %t213 = getelementptr %NativeInstruction, %NativeInstruction* %t212, i64 0
  store %NativeInstruction %t210, %NativeInstruction* %t213
  %t214 = alloca { %NativeInstruction*, i64 }
  %t215 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t214, i32 0, i32 0
  store %NativeInstruction* %t212, %NativeInstruction** %t215
  %t216 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t214, i32 0, i32 1
  store i64 1, i64* %t216
  %t217 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t218 = insertvalue %InstructionParseResult %t217, i1 1, 1
  %t219 = insertvalue %InstructionParseResult %t218, i1 1, 2
  ret %InstructionParseResult %t219
merge29:
  %s220 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.220, i32 0, i32 0
  %t221 = call i1 @starts_with(i8* %line, i8* %s220)
  br i1 %t221, label %then30, label %merge31
then30:
  %t222 = getelementptr i8, i8* %line, i64 3
  %t223 = load i8, i8* %t222
  store i8 %t223, i8* %l7
  %t225 = load i8, i8* %l7
  %s226 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.226, i32 0, i32 0
  br label %merge31
merge31:
  %s227 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.227, i32 0, i32 0
  %t228 = call i1 @starts_with(i8* %line, i8* %s227)
  br i1 %t228, label %then32, label %merge33
then32:
  %s229 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.229, i32 0, i32 0
  %t230 = call i8* @strip_prefix(i8* %line, i8* %s229)
  %t231 = call i8* @trim_text(i8* %t230)
  store i8* %t231, i8** %l8
  store i1 0, i1* %l9
  %t232 = load i8*, i8** %l8
  %s233 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.233, i32 0, i32 0
  %t234 = call i1 @starts_with(i8* %t232, i8* %s233)
  %t235 = load i8*, i8** %l8
  %t236 = load i1, i1* %l9
  br i1 %t234, label %then34, label %merge35
then34:
  store i1 1, i1* %l9
  %t237 = load i8*, i8** %l8
  %s238 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.238, i32 0, i32 0
  %t239 = call i8* @strip_prefix(i8* %t237, i8* %s238)
  %t240 = call i8* @trim_text(i8* %t239)
  store i8* %t240, i8** %l8
  br label %merge35
merge35:
  %t241 = phi i1 [ 1, %then34 ], [ %t236, %then32 ]
  %t242 = phi i8* [ %t240, %then34 ], [ %t235, %then32 ]
  store i1 %t241, i1* %l9
  store i8* %t242, i8** %l8
  %t243 = load i8*, i8** %l8
  %t244 = call %BindingComponents @parse_binding_components(i8* %t243)
  store %BindingComponents %t244, %BindingComponents* %l10
  %t245 = alloca %NativeInstruction
  %t246 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 0
  store i32 2, i32* %t246
  %t247 = load %BindingComponents, %BindingComponents* %l10
  %t248 = extractvalue %BindingComponents %t247, 0
  %t249 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 1
  %t250 = bitcast [48 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to i8**
  store i8* %t248, i8** %t251
  %t252 = load i1, i1* %l9
  %t253 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 1
  %t254 = bitcast [48 x i8]* %t253 to i8*
  %t255 = getelementptr inbounds i8, i8* %t254, i64 8
  %t256 = bitcast i8* %t255 to i1*
  store i1 %t252, i1* %t256
  %t257 = load %BindingComponents, %BindingComponents* %l10
  %t258 = extractvalue %BindingComponents %t257, 1
  %t259 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 1
  %t260 = bitcast [48 x i8]* %t259 to i8*
  %t261 = getelementptr inbounds i8, i8* %t260, i64 16
  %t262 = bitcast i8* %t261 to i8**
  store i8* %t258, i8** %t262
  %t263 = load %BindingComponents, %BindingComponents* %l10
  %t264 = extractvalue %BindingComponents %t263, 2
  %t265 = call double @maybe_trim_trailing(i8* %t264)
  %t266 = call noalias i8* @malloc(i64 8)
  %t267 = bitcast i8* %t266 to double*
  store double %t265, double* %t267
  %t268 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 1
  %t269 = bitcast [48 x i8]* %t268 to i8*
  %t270 = getelementptr inbounds i8, i8* %t269, i64 24
  %t271 = bitcast i8* %t270 to i8**
  store i8* %t266, i8** %t271
  %t272 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 1
  %t273 = bitcast [48 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 32
  %t275 = bitcast i8* %t274 to i8**
  store i8* %span, i8** %t275
  %t276 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t245, i32 0, i32 1
  %t277 = bitcast [48 x i8]* %t276 to i8*
  %t278 = getelementptr inbounds i8, i8* %t277, i64 40
  %t279 = bitcast i8* %t278 to i8**
  store i8* %value_span, i8** %t279
  %t280 = load %NativeInstruction, %NativeInstruction* %t245
  %t281 = alloca [1 x %NativeInstruction]
  %t282 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t281, i32 0, i32 0
  %t283 = getelementptr %NativeInstruction, %NativeInstruction* %t282, i64 0
  store %NativeInstruction %t280, %NativeInstruction* %t283
  %t284 = alloca { %NativeInstruction*, i64 }
  %t285 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t284, i32 0, i32 0
  store %NativeInstruction* %t282, %NativeInstruction** %t285
  %t286 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t284, i32 0, i32 1
  store i64 1, i64* %t286
  %t287 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t288 = insertvalue %InstructionParseResult %t287, i1 1, 1
  %t289 = insertvalue %InstructionParseResult %t288, i1 1, 2
  ret %InstructionParseResult %t289
merge33:
  %s290 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.290, i32 0, i32 0
  %t291 = call i1 @starts_with(i8* %line, i8* %s290)
  br i1 %t291, label %then36, label %merge37
then36:
  %t292 = alloca %NativeInstruction
  %t293 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t292, i32 0, i32 0
  store i32 1, i32* %t293
  %s294 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.294, i32 0, i32 0
  %t295 = call i8* @strip_prefix(i8* %line, i8* %s294)
  %t296 = call i8* @trim_text(i8* %t295)
  %t297 = call i8* @trim_trailing_delimiters(i8* %t296)
  %t298 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t292, i32 0, i32 1
  %t299 = bitcast [16 x i8]* %t298 to i8*
  %t300 = bitcast i8* %t299 to i8**
  store i8* %t297, i8** %t300
  %t301 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t292, i32 0, i32 1
  %t302 = bitcast [16 x i8]* %t301 to i8*
  %t303 = getelementptr inbounds i8, i8* %t302, i64 8
  %t304 = bitcast i8* %t303 to i8**
  store i8* %span, i8** %t304
  %t305 = load %NativeInstruction, %NativeInstruction* %t292
  %t306 = alloca [1 x %NativeInstruction]
  %t307 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t306, i32 0, i32 0
  %t308 = getelementptr %NativeInstruction, %NativeInstruction* %t307, i64 0
  store %NativeInstruction %t305, %NativeInstruction* %t308
  %t309 = alloca { %NativeInstruction*, i64 }
  %t310 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t309, i32 0, i32 0
  store %NativeInstruction* %t307, %NativeInstruction** %t310
  %t311 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t309, i32 0, i32 1
  store i64 1, i64* %t311
  %t312 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t313 = insertvalue %InstructionParseResult %t312, i1 1, 1
  %t314 = insertvalue %InstructionParseResult %t313, i1 0, 2
  ret %InstructionParseResult %t314
merge37:
  %t315 = alloca %NativeInstruction
  %t316 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t315, i32 0, i32 0
  store i32 16, i32* %t316
  %t317 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t315, i32 0, i32 1
  %t318 = bitcast [8 x i8]* %t317 to i8*
  %t319 = bitcast i8* %t318 to i8**
  store i8* %line, i8** %t319
  %t320 = load %NativeInstruction, %NativeInstruction* %t315
  %t321 = alloca [1 x %NativeInstruction]
  %t322 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t321, i32 0, i32 0
  %t323 = getelementptr %NativeInstruction, %NativeInstruction* %t322, i64 0
  store %NativeInstruction %t320, %NativeInstruction* %t323
  %t324 = alloca { %NativeInstruction*, i64 }
  %t325 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t324, i32 0, i32 0
  store %NativeInstruction* %t322, %NativeInstruction** %t325
  %t326 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t324, i32 0, i32 1
  store i64 1, i64* %t326
  %t327 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t328 = insertvalue %InstructionParseResult %t327, i1 0, 1
  %t329 = insertvalue %InstructionParseResult %t328, i1 0, 2
  ret %InstructionParseResult %t329
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
  %t22 = call double @substring(i8* %t20, i64 0, double %t21)
  %t23 = call i8* @trim_text(i8* null)
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 2 to double
  %t27 = fadd double %t25, %t26
  %t28 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t29 = load i8*, i8** %l2
  %t30 = call %CaseComponents @split_case_components(i8* %t29)
  store %CaseComponents %t30, %CaseComponents* %l4
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %NativeInstruction*, i64 }* null, { %NativeInstruction*, i64 }** %l5
  %t36 = alloca %NativeInstruction
  %t37 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t36, i32 0, i32 0
  store i32 13, i32* %t37
  %t38 = load %CaseComponents, %CaseComponents* %l4
  %t39 = extractvalue %CaseComponents %t38, 0
  %t40 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t36, i32 0, i32 1
  %t41 = bitcast [16 x i8]* %t40 to i8*
  %t42 = bitcast i8* %t41 to i8**
  store i8* %t39, i8** %t42
  %t43 = load %CaseComponents, %CaseComponents* %l4
  %t44 = extractvalue %CaseComponents %t43, 1
  %t45 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t36, i32 0, i32 1
  %t46 = bitcast [16 x i8]* %t45 to i8*
  %t47 = getelementptr inbounds i8, i8* %t46, i64 8
  %t48 = bitcast i8* %t47 to i8**
  store i8* %t44, i8** %t48
  %t49 = load %NativeInstruction, %NativeInstruction* %t36
  %t50 = alloca [1 x %NativeInstruction]
  %t51 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t50, i32 0, i32 0
  %t52 = getelementptr %NativeInstruction, %NativeInstruction* %t51, i64 0
  store %NativeInstruction %t49, %NativeInstruction* %t52
  %t53 = alloca { %NativeInstruction*, i64 }
  %t54 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t53, i32 0, i32 0
  store %NativeInstruction* %t51, %NativeInstruction** %t54
  %t55 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t53, i32 0, i32 1
  store i64 1, i64* %t55
  %t56 = call double @instructionsconcat({ %NativeInstruction*, i64 }* %t53)
  store { %NativeInstruction*, i64 }* null, { %NativeInstruction*, i64 }** %l5
  %t57 = load double, double* %l3
  %t58 = load double, double* %l3
  %t59 = call %NativeInstruction @parse_inline_case_body_instruction(i8* null)
  store %NativeInstruction %t59, %NativeInstruction* %l6
  %t60 = load %NativeInstruction, %NativeInstruction* %l6
  %t61 = alloca [1 x %NativeInstruction]
  %t62 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t61, i32 0, i32 0
  %t63 = getelementptr %NativeInstruction, %NativeInstruction* %t62, i64 0
  store %NativeInstruction %t60, %NativeInstruction* %t63
  %t64 = alloca { %NativeInstruction*, i64 }
  %t65 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t64, i32 0, i32 0
  store %NativeInstruction* %t62, %NativeInstruction** %t65
  %t66 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t64, i32 0, i32 1
  store i64 1, i64* %t66
  %t67 = call double @instructionsconcat({ %NativeInstruction*, i64 }* %t64)
  store { %NativeInstruction*, i64 }* null, { %NativeInstruction*, i64 }** %l5
  %t68 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t68
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
  %t17 = call double @substring(i8* %t15, i64 0, double %t16)
  %t18 = call i8* @trim_text(i8* null)
  store i8* %t18, i8** %l3
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l2
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t23 = load double, double* %l4
  %t24 = load i8*, i8** %l3
  %t25 = insertvalue %CaseComponents undef, i8* %t24, 0
  %t26 = load double, double* %l4
  %t27 = insertvalue %CaseComponents %t25, i8* null, 1
  ret %CaseComponents %t27
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { %NativeImportSpecifier*, i64 }* null, { %NativeImportSpecifier*, i64 }** %l2
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
  %t17 = call double @substring(i8* %t15, i64 0, double %t16)
  %t18 = call i8* @trim_text(i8* null)
  store i8* %t18, i8** %l3
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l2
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t23 = load double, double* %l4
  %t24 = load i8*, i8** %l3
  %t25 = insertvalue %NativeImportSpecifier undef, i8* %t24, 0
  %t26 = load double, double* %l4
  %t27 = insertvalue %NativeImportSpecifier %t25, i8* null, 1
  ret %NativeImportSpecifier %t27
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %t26 = alloca [0 x double]
  %t27 = getelementptr [0 x double], [0 x double]* %t26, i32 0, i32 0
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t27, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeStructField*, i64 }* null, { %NativeStructField*, i64 }** %l6
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { %NativeFunction*, i64 }* null, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t36 = alloca [0 x double]
  %t37 = getelementptr [0 x double], [0 x double]* %t36, i32 0, i32 0
  %t38 = alloca { double*, i64 }
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 0
  store double* %t37, double** %t39
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { %NativeStructLayoutField*, i64 }* null, { %NativeStructLayoutField*, i64 }** %l11
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
  %t88 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t84, i8* %t87)
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
  %t185 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t181, i8* %t184)
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
  %t328 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t324, i8* %t327)
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
  %t412 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t408, i8* %t411)
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
  %t463 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t459, i8* %t462)
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
  %t637 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t633, i8* %t636)
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
  %t759 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t753, i8* %t758)
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
  %t774 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t770, i8* %t773)
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
  %t876 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t872, i8* %t875)
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
  %t889 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t885, i8* %t888)
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { %NativeInterfaceSignature*, i64 }* null, { %NativeInterfaceSignature*, i64 }** %l5
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
  %t54 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t50, i8* %t53)
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
  %t152 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t148, i8* %t151)
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
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* null, { i8**, i64 }** %l2
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
  %l10 = alloca double
  %l11 = alloca { %NativeParameter*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  %t25 = call double @index_of(i8* %t23, i8* %s24)
  store double %t25, double* %l5
  %t26 = load double, double* %l5
  %t27 = sitofp i64 0 to double
  %t28 = fcmp olt double %t26, %t27
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  %t32 = load i8*, i8** %l3
  %t33 = load i1, i1* %l4
  %t34 = load double, double* %l5
  br i1 %t28, label %then2, label %merge3
then2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s36 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.36, i32 0, i32 0
  %t37 = add i8* %s36, %interface_name
  %s38 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.38, i32 0, i32 0
  %t39 = add i8* %t37, %s38
  %t40 = load i8*, i8** %l2
  %t41 = add i8* %t39, %t40
  %t42 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t35, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  %t43 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t44 = load double, double* %l1
  %t45 = insertvalue %InterfaceSignatureParse %t43, i8* null, 1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = insertvalue %InterfaceSignatureParse %t45, { i8**, i64 }* %t46, 2
  ret %InterfaceSignatureParse %t47
merge3:
  %t48 = load i8*, i8** %l3
  %t49 = load double, double* %l5
  %t50 = call double @find_matching_paren(i8* %t48, double %t49)
  store double %t50, double* %l6
  %t51 = load double, double* %l6
  %t52 = sitofp i64 0 to double
  %t53 = fcmp olt double %t51, %t52
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = load i8*, i8** %l2
  %t57 = load i8*, i8** %l3
  %t58 = load i1, i1* %l4
  %t59 = load double, double* %l5
  %t60 = load double, double* %l6
  br i1 %t53, label %then4, label %merge5
then4:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s62 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.62, i32 0, i32 0
  %t63 = add i8* %s62, %interface_name
  %s64 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %t63, %s64
  %t66 = load i8*, i8** %l2
  %t67 = add i8* %t65, %t66
  %t68 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t61, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t70 = load double, double* %l1
  %t71 = insertvalue %InterfaceSignatureParse %t69, i8* null, 1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = insertvalue %InterfaceSignatureParse %t71, { i8**, i64 }* %t72, 2
  ret %InterfaceSignatureParse %t73
merge5:
  %t74 = load i8*, i8** %l3
  %t75 = load double, double* %l5
  %t76 = call double @substring(i8* %t74, i64 0, double %t75)
  %t77 = call i8* @trim_text(i8* null)
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
  %t93 = call double @substring(i8* %t88, double %t91, double %t92)
  store double %t93, double* %l10
  %t94 = alloca [0 x double]
  %t95 = getelementptr [0 x double], [0 x double]* %t94, i32 0, i32 0
  %t96 = alloca { double*, i64 }
  %t97 = getelementptr { double*, i64 }, { double*, i64 }* %t96, i32 0, i32 0
  store double* %t95, double** %t97
  %t98 = getelementptr { double*, i64 }, { double*, i64 }* %t96, i32 0, i32 1
  store i64 0, i64* %t98
  store { %NativeParameter*, i64 }* null, { %NativeParameter*, i64 }** %l11
  %t99 = load double, double* %l10
  %t100 = call i8* @trim_text(i8* null)
  store i8* %t100, i8** %l12
  %t101 = load i8*, i8** %l12
  %s102 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.102, i32 0, i32 0
  store i8* %s102, i8** %l13
  %t103 = alloca [0 x double]
  %t104 = getelementptr [0 x double], [0 x double]* %t103, i32 0, i32 0
  %t105 = alloca { double*, i64 }
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t105, i32 0, i32 0
  store double* %t104, double** %t106
  %t107 = getelementptr { double*, i64 }, { double*, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { i8**, i64 }* null, { i8**, i64 }** %l14
  %t108 = load i8*, i8** %l3
  %t109 = load double, double* %l6
  %t110 = sitofp i64 1 to double
  %t111 = fadd double %t109, %t110
  %t112 = load i8*, i8** %l3
  store double 0.0, double* %l15
  %t113 = load double, double* %l15
  store double 0.0, double* %l16
  %t115 = load i8*, i8** %l9
  store double 0.0, double* %l17
  %t116 = load double, double* %l17
  %t117 = fcmp one double %t116, 0.0
  %t118 = insertvalue %InterfaceSignatureParse undef, i1 %t117, 0
  %t119 = load double, double* %l16
  %t120 = insertvalue %InterfaceSignatureParse %t118, i8* null, 1
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = insertvalue %InterfaceSignatureParse %t120, { i8**, i64 }* %t121, 2
  ret %InterfaceSignatureParse %t122
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
  %l7 = alloca double
  %l8 = alloca double
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
  %t7 = load i8*, i8** %l1
  store i8* %t7, i8** %l2
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l3
  %t9 = alloca [0 x double]
  %t10 = getelementptr [0 x double], [0 x double]* %t9, i32 0, i32 0
  %t11 = alloca { double*, i64 }
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 0
  store double* %t10, double** %t12
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* null, { i8**, i64 }** %l4
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
  %t52 = call double @substring(i8* %t50, i64 0, double %t51)
  %t53 = call i8* @trim_text(i8* null)
  store i8* %t53, i8** %l2
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l5
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  %t58 = load double, double* %l6
  %t59 = call double @substring(i8* %t54, double %t57, double %t58)
  store double %t59, double* %l7
  %t60 = load double, double* %l7
  %t61 = call { i8**, i64 }* @parse_type_parameter_entries(i8* null)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l4
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l6
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  %t66 = load i8*, i8** %l1
  br label %merge2
else1:
  %t67 = load i8*, i8** %l1
  %s68 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.68, i32 0, i32 0
  %t69 = call double @index_of(i8* %t67, i8* %s68)
  store double %t69, double* %l8
  %t70 = load double, double* %l8
  %t71 = sitofp i64 0 to double
  %t72 = fcmp oge double %t70, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t78 = load double, double* %l5
  %t79 = load double, double* %l8
  br i1 %t72, label %then5, label %merge6
then5:
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l8
  %t82 = call double @substring(i8* %t80, i64 0, double %t81)
  %t83 = call i8* @trim_text(i8* null)
  store i8* %t83, i8** %l2
  %t84 = load i8*, i8** %l1
  %t85 = load double, double* %l8
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  %t88 = load i8*, i8** %l1
  br label %merge6
merge6:
  %t89 = phi i8* [ %t83, %then5 ], [ %t75, %else1 ]
  %t90 = phi i8* [ null, %then5 ], [ %t76, %else1 ]
  store i8* %t89, i8** %l2
  store i8* %t90, i8** %l3
  br label %merge2
merge2:
  %t91 = phi { i8**, i64 }* [ null, %then0 ], [ %t18, %else1 ]
  %t92 = phi i8* [ %t41, %then0 ], [ %t83, %else1 ]
  %t93 = phi { i8**, i64 }* [ %t61, %then0 ], [ %t22, %else1 ]
  %t94 = phi i8* [ null, %then0 ], [ null, %else1 ]
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  store i8* %t92, i8** %l2
  store { i8**, i64 }* %t93, { i8**, i64 }** %l4
  store i8* %t94, i8** %l3
  %t95 = load i8*, i8** %l2
  %t96 = call i8* @strip_generics(i8* %t95)
  store i8* %t96, i8** %l2
  %t97 = load i8*, i8** %l2
  %t98 = insertvalue %HeaderNameParse undef, i8* %t97, 0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t100 = insertvalue %HeaderNameParse %t98, { i8**, i64 }* %t99, 1
  %t101 = load i8*, i8** %l3
  %t102 = insertvalue %HeaderNameParse %t100, i8* %t101, 2
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = insertvalue %HeaderNameParse %t102, { i8**, i64 }* %t103, 3
  ret %HeaderNameParse %t104
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
  %t51 = phi i8* [ %t13, %entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t14, %entry ], [ %t50, %loop.latch2 ]
  store i8* %t51, i8** %l1
  store double %t52, double* %l2
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l2
  %t21 = load double, double* %l2
  %t22 = getelementptr i8, i8* %text, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l8
  %t24 = load i8*, i8** %l3
  %t26 = load i8, i8* %l8
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = load i8, i8* %l8
  %t29 = load i8, i8* %l8
  %t30 = load i8, i8* %l8
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = load i8, i8* %l8
  %s33 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.33, i32 0, i32 0
  %t34 = load i8, i8* %l8
  %s35 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.35, i32 0, i32 0
  %t36 = load i8, i8* %l8
  %s37 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.37, i32 0, i32 0
  %t38 = load i8, i8* %l8
  %s39 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.39, i32 0, i32 0
  %t40 = load i8, i8* %l8
  %s41 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.41, i32 0, i32 0
  %t42 = load i8, i8* %l8
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  %t44 = load i8*, i8** %l1
  %t45 = load i8, i8* %l8
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l2
  br label %loop.latch2
loop.latch2:
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t53 = load i8*, i8** %l1
  %t54 = call i8* @trim_text(i8* %t53)
  store i8* %t54, i8** %l9
  %t55 = load i8*, i8** %l9
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t56
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
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t14 = phi double [ %t2, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = call double @index_of(i8* %t17, i8* %s18)
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
  %t30 = call double @substring(i8* %t28, i64 0, double %t29)
  %t31 = call i8* @trim_text(i8* null)
  store i8* %t31, i8** %l3
  br label %merge1
merge1:
  %t32 = phi i8* [ %t31, %then0 ], [ %t26, %entry ]
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = call i8* @strip_generics(i8* %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = alloca [0 x double]
  %t37 = getelementptr [0 x double], [0 x double]* %t36, i32 0, i32 0
  %t38 = alloca { double*, i64 }
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 0
  store double* %t37, double** %t39
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { %NativeEnumVariant*, i64 }* null, { %NativeEnumVariant*, i64 }** %l5
  %t41 = alloca [0 x double]
  %t42 = getelementptr [0 x double], [0 x double]* %t41, i32 0, i32 0
  %t43 = alloca { double*, i64 }
  %t44 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 0
  store double* %t42, double** %t44
  %t45 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l6
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
  %t645 = phi { i8**, i64 }* [ %t53, %entry ], [ %t635, %loop.latch4 ]
  %t646 = phi double [ %t67, %entry ], [ %t636, %loop.latch4 ]
  %t647 = phi double [ %t60, %entry ], [ %t637, %loop.latch4 ]
  %t648 = phi double [ %t61, %entry ], [ %t638, %loop.latch4 ]
  %t649 = phi i8* [ %t62, %entry ], [ %t639, %loop.latch4 ]
  %t650 = phi double [ %t63, %entry ], [ %t640, %loop.latch4 ]
  %t651 = phi double [ %t64, %entry ], [ %t641, %loop.latch4 ]
  %t652 = phi i1 [ %t65, %entry ], [ %t642, %loop.latch4 ]
  %t653 = phi { %NativeEnumVariantLayout*, i64 }* [ %t59, %entry ], [ %t643, %loop.latch4 ]
  %t654 = phi i1 [ %t66, %entry ], [ %t644, %loop.latch4 ]
  store { i8**, i64 }* %t645, { i8**, i64 }** %l0
  store double %t646, double* %l14
  store double %t647, double* %l7
  store double %t648, double* %l8
  store i8* %t649, i8** %l9
  store double %t650, double* %l10
  store double %t651, double* %l11
  store i1 %t652, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t653, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t654, i1* %l13
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
  %t92 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t88, i8* %t91)
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
  %t246 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t242, i8* %t245)
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
  %t405 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t399, i8* %t404)
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
  %s500 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.500, i32 0, i32 0
  %t501 = add i8* %t499, %s500
  %t502 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t491, i8* %t501)
  store { i8**, i64 }* %t502, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t503 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t504 = load double, double* %l22
  %t505 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t506 = extractvalue %EnumLayoutPayloadParse %t505, 2
  %t507 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t503, double %t504, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t507, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge38
merge38:
  %t508 = phi { i8**, i64 }* [ %t502, %then36 ], [ %t472, %else37 ]
  %t509 = phi { %NativeEnumVariantLayout*, i64 }* [ %t478, %then36 ], [ %t507, %else37 ]
  store { i8**, i64 }* %t508, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t509, { %NativeEnumVariantLayout*, i64 }** %l6
  %t510 = load i1, i1* %l12
  %t511 = xor i1 %t510, 1
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t513 = load i8*, i8** %l1
  %t514 = load i8*, i8** %l2
  %t515 = load i8*, i8** %l3
  %t516 = load double, double* %l4
  %t517 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t518 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t519 = load double, double* %l7
  %t520 = load double, double* %l8
  %t521 = load i8*, i8** %l9
  %t522 = load double, double* %l10
  %t523 = load double, double* %l11
  %t524 = load i1, i1* %l12
  %t525 = load i1, i1* %l13
  %t526 = load double, double* %l14
  %t527 = load i8*, i8** %l16
  %t528 = load i8*, i8** %l17
  %t529 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t530 = load double, double* %l22
  br i1 %t511, label %then39, label %merge40
then39:
  %t531 = load i1, i1* %l13
  %t532 = xor i1 %t531, 1
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t534 = load i8*, i8** %l1
  %t535 = load i8*, i8** %l2
  %t536 = load i8*, i8** %l3
  %t537 = load double, double* %l4
  %t538 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t539 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t540 = load double, double* %l7
  %t541 = load double, double* %l8
  %t542 = load i8*, i8** %l9
  %t543 = load double, double* %l10
  %t544 = load double, double* %l11
  %t545 = load i1, i1* %l12
  %t546 = load i1, i1* %l13
  %t547 = load double, double* %l14
  %t548 = load i8*, i8** %l16
  %t549 = load i8*, i8** %l17
  %t550 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t551 = load double, double* %l22
  br i1 %t532, label %then41, label %merge42
then41:
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s553 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.553, i32 0, i32 0
  %t554 = load i8*, i8** %l3
  %t555 = add i8* %s553, %t554
  %s556 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.556, i32 0, i32 0
  %t557 = add i8* %t555, %s556
  %t558 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t552, i8* %t557)
  store { i8**, i64 }* %t558, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge42
merge42:
  %t559 = phi { i8**, i64 }* [ %t558, %then41 ], [ %t533, %then39 ]
  %t560 = phi i1 [ 1, %then41 ], [ %t546, %then39 ]
  store { i8**, i64 }* %t559, { i8**, i64 }** %l0
  store i1 %t560, i1* %l13
  br label %merge40
merge40:
  %t561 = phi { i8**, i64 }* [ %t558, %then39 ], [ %t512, %then34 ]
  %t562 = phi i1 [ 1, %then39 ], [ %t525, %then34 ]
  store { i8**, i64 }* %t561, { i8**, i64 }** %l0
  store i1 %t562, i1* %l13
  br label %merge35
merge35:
  %t563 = phi { i8**, i64 }* [ %t502, %then34 ], [ %t447, %then32 ]
  %t564 = phi { %NativeEnumVariantLayout*, i64 }* [ %t507, %then34 ], [ %t453, %then32 ]
  %t565 = phi { i8**, i64 }* [ %t558, %then34 ], [ %t447, %then32 ]
  %t566 = phi i1 [ 1, %then34 ], [ %t460, %then32 ]
  store { i8**, i64 }* %t563, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t564, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t565, { i8**, i64 }** %l0
  store i1 %t566, i1* %l13
  %t567 = load double, double* %l14
  %t568 = sitofp i64 1 to double
  %t569 = fadd double %t567, %t568
  store double %t569, double* %l14
  br label %loop.latch4
merge33:
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s571 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.571, i32 0, i32 0
  %t572 = load i8*, i8** %l16
  %t573 = add i8* %s571, %t572
  %t574 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t570, i8* %t573)
  store { i8**, i64 }* %t574, { i8**, i64 }** %l0
  %t575 = load double, double* %l14
  %t576 = sitofp i64 1 to double
  %t577 = fadd double %t575, %t576
  store double %t577, double* %l14
  br label %loop.latch4
merge13:
  %t578 = load i8*, i8** %l16
  %s579 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.579, i32 0, i32 0
  %t580 = icmp eq i8* %t578, %s579
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t582 = load i8*, i8** %l1
  %t583 = load i8*, i8** %l2
  %t584 = load i8*, i8** %l3
  %t585 = load double, double* %l4
  %t586 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t587 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t588 = load double, double* %l7
  %t589 = load double, double* %l8
  %t590 = load i8*, i8** %l9
  %t591 = load double, double* %l10
  %t592 = load double, double* %l11
  %t593 = load i1, i1* %l12
  %t594 = load i1, i1* %l13
  %t595 = load double, double* %l14
  %t596 = load i8*, i8** %l16
  br i1 %t580, label %then43, label %merge44
then43:
  %t597 = load double, double* %l14
  %t598 = sitofp i64 1 to double
  %t599 = fadd double %t597, %t598
  store double %t599, double* %l14
  br label %afterloop5
merge44:
  %t600 = load i8*, i8** %l16
  %s601 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.601, i32 0, i32 0
  %t602 = call i1 @starts_with(i8* %t600, i8* %s601)
  %t603 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t604 = load i8*, i8** %l1
  %t605 = load i8*, i8** %l2
  %t606 = load i8*, i8** %l3
  %t607 = load double, double* %l4
  %t608 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t609 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t610 = load double, double* %l7
  %t611 = load double, double* %l8
  %t612 = load i8*, i8** %l9
  %t613 = load double, double* %l10
  %t614 = load double, double* %l11
  %t615 = load i1, i1* %l12
  %t616 = load i1, i1* %l13
  %t617 = load double, double* %l14
  %t618 = load i8*, i8** %l16
  br i1 %t602, label %then45, label %merge46
then45:
  %t619 = load i8*, i8** %l16
  %s620 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.620, i32 0, i32 0
  %t621 = call i8* @strip_prefix(i8* %t619, i8* %s620)
  %t622 = call double @parse_enum_variant_line(i8* %t621)
  store double %t622, double* %l23
  %t623 = load double, double* %l23
  %t624 = load double, double* %l14
  %t625 = sitofp i64 1 to double
  %t626 = fadd double %t624, %t625
  store double %t626, double* %l14
  br label %loop.latch4
merge46:
  %t627 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s628 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.628, i32 0, i32 0
  %t629 = load i8*, i8** %l16
  %t630 = add i8* %s628, %t629
  %t631 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t627, i8* %t630)
  store { i8**, i64 }* %t631, { i8**, i64 }** %l0
  %t632 = load double, double* %l14
  %t633 = sitofp i64 1 to double
  %t634 = fadd double %t632, %t633
  store double %t634, double* %l14
  br label %loop.latch4
loop.latch4:
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t636 = load double, double* %l14
  %t637 = load double, double* %l7
  %t638 = load double, double* %l8
  %t639 = load i8*, i8** %l9
  %t640 = load double, double* %l10
  %t641 = load double, double* %l11
  %t642 = load i1, i1* %l12
  %t643 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t644 = load i1, i1* %l13
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l24
  %t655 = load i1, i1* %l12
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t657 = load i8*, i8** %l1
  %t658 = load i8*, i8** %l2
  %t659 = load i8*, i8** %l3
  %t660 = load double, double* %l4
  %t661 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t662 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t663 = load double, double* %l7
  %t664 = load double, double* %l8
  %t665 = load i8*, i8** %l9
  %t666 = load double, double* %l10
  %t667 = load double, double* %l11
  %t668 = load i1, i1* %l12
  %t669 = load i1, i1* %l13
  %t670 = load double, double* %l14
  %t671 = load i8*, i8** %l24
  br i1 %t655, label %then47, label %merge48
then47:
  br label %merge48
merge48:
  %t672 = phi i8* [ null, %then47 ], [ %t671, %entry ]
  store i8* %t672, i8** %l24
  %t673 = load i8*, i8** %l3
  %t674 = insertvalue %NativeEnum undef, i8* %t673, 0
  %t675 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t676 = insertvalue %NativeEnum %t674, { i8**, i64 }* null, 1
  %t677 = load i8*, i8** %l24
  %t678 = insertvalue %NativeEnum %t676, i8* %t677, 2
  %t679 = insertvalue %EnumParseResult undef, i8* null, 0
  %t680 = load double, double* %l14
  %t681 = insertvalue %EnumParseResult %t679, double %t680, 1
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t683 = insertvalue %EnumParseResult %t681, { i8**, i64 }* %t682, 2
  ret %EnumParseResult %t683
}

define { i8**, i64 }* @split_enum_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t11, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l3
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = getelementptr i8, i8* %text, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t18 = load i8, i8* %l4
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t21 = load i8, i8* %l4
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  %t23 = load double, double* %l3
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l3
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t28 = load i8*, i8** %l1
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t29
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
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = call double @substring(i8* %text, i64 0, double %t9)
  ret i8* null
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
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t15 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t13, i8* %s14)
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
  %t187 = phi i8* [ %t34, %entry ], [ %t179, %loop.latch4 ]
  %t188 = phi i1 [ %t31, %entry ], [ %t180, %loop.latch4 ]
  %t189 = phi i1 [ %t32, %entry ], [ %t181, %loop.latch4 ]
  %t190 = phi double [ %t35, %entry ], [ %t182, %loop.latch4 ]
  %t191 = phi { i8**, i64 }* [ %t30, %entry ], [ %t183, %loop.latch4 ]
  %t192 = phi i1 [ %t33, %entry ], [ %t184, %loop.latch4 ]
  %t193 = phi double [ %t36, %entry ], [ %t185, %loop.latch4 ]
  %t194 = phi double [ %t37, %entry ], [ %t186, %loop.latch4 ]
  store i8* %t187, i8** %l5
  store i1 %t188, i1* %l2
  store i1 %t189, i1* %l3
  store double %t190, double* %l6
  store { i8**, i64 }* %t191, { i8**, i64 }** %l1
  store i1 %t192, i1* %l4
  store double %t193, double* %l7
  store double %t194, double* %l8
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
  %s158 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.158, i32 0, i32 0
  %t159 = add i8* %t157, %s158
  %t160 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t154, i8* %t159)
  store { i8**, i64 }* %t160, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t161 = phi i1 [ 1, %then17 ], [ %t122, %else18 ]
  %t162 = phi double [ %t147, %then17 ], [ %t125, %else18 ]
  %t163 = phi { i8**, i64 }* [ null, %then17 ], [ %t160, %else18 ]
  store i1 %t161, i1* %l4
  store double %t162, double* %l7
  store { i8**, i64 }* %t163, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t164 = phi i1 [ 1, %then11 ], [ %t82, %else12 ]
  %t165 = phi double [ %t108, %then11 ], [ %t85, %else12 ]
  %t166 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t167 = phi i1 [ %t83, %then11 ], [ 1, %else12 ]
  %t168 = phi double [ %t86, %then11 ], [ %t147, %else12 ]
  store i1 %t164, i1* %l3
  store double %t165, double* %l6
  store { i8**, i64 }* %t166, { i8**, i64 }** %l1
  store i1 %t167, i1* %l4
  store double %t168, double* %l7
  br label %merge10
merge10:
  %t169 = phi i8* [ null, %then8 ], [ %t69, %else9 ]
  %t170 = phi i1 [ 1, %then8 ], [ %t66, %else9 ]
  %t171 = phi i1 [ %t67, %then8 ], [ 1, %else9 ]
  %t172 = phi double [ %t70, %then8 ], [ %t108, %else9 ]
  %t173 = phi { i8**, i64 }* [ %t65, %then8 ], [ null, %else9 ]
  %t174 = phi i1 [ %t68, %then8 ], [ 1, %else9 ]
  %t175 = phi double [ %t71, %then8 ], [ %t147, %else9 ]
  store i8* %t169, i8** %l5
  store i1 %t170, i1* %l2
  store i1 %t171, i1* %l3
  store double %t172, double* %l6
  store { i8**, i64 }* %t173, { i8**, i64 }** %l1
  store i1 %t174, i1* %l4
  store double %t175, double* %l7
  %t176 = load double, double* %l8
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l8
  br label %loop.latch4
loop.latch4:
  %t179 = load i8*, i8** %l5
  %t180 = load i1, i1* %l2
  %t181 = load i1, i1* %l3
  %t182 = load double, double* %l6
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = load i1, i1* %l4
  %t185 = load double, double* %l7
  %t186 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t195 = load i1, i1* %l3
  %t196 = xor i1 %t195, 1
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t199 = load i1, i1* %l2
  %t200 = load i1, i1* %l3
  %t201 = load i1, i1* %l4
  %t202 = load i8*, i8** %l5
  %t203 = load double, double* %l6
  %t204 = load double, double* %l7
  %t205 = load double, double* %l8
  br i1 %t196, label %then23, label %merge24
then23:
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s207 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.207, i32 0, i32 0
  %t208 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t206, i8* %s207)
  store { i8**, i64 }* %t208, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t209 = phi { i8**, i64 }* [ %t208, %then23 ], [ %t198, %entry ]
  store { i8**, i64 }* %t209, { i8**, i64 }** %l1
  %t210 = load i1, i1* %l4
  %t211 = xor i1 %t210, 1
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t214 = load i1, i1* %l2
  %t215 = load i1, i1* %l3
  %t216 = load i1, i1* %l4
  %t217 = load i8*, i8** %l5
  %t218 = load double, double* %l6
  %t219 = load double, double* %l7
  %t220 = load double, double* %l8
  br i1 %t211, label %then25, label %merge26
then25:
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s222 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.222, i32 0, i32 0
  %t223 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t221, i8* %s222)
  store { i8**, i64 }* %t223, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t224 = phi { i8**, i64 }* [ %t223, %then25 ], [ %t213, %entry ]
  store { i8**, i64 }* %t224, { i8**, i64 }** %l1
  %t227 = load i1, i1* %l3
  br label %logical_and_entry_226

logical_and_entry_226:
  br i1 %t227, label %logical_and_right_226, label %logical_and_merge_226

logical_and_right_226:
  %t228 = load i1, i1* %l4
  br label %logical_and_right_end_226

logical_and_right_end_226:
  br label %logical_and_merge_226

logical_and_merge_226:
  %t229 = phi i1 [ false, %logical_and_entry_226 ], [ %t228, %logical_and_right_end_226 ]
  br label %logical_and_entry_225

logical_and_entry_225:
  br i1 %t229, label %logical_and_right_225, label %logical_and_merge_225

logical_and_right_225:
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t231 = load { i8**, i64 }, { i8**, i64 }* %t230
  %t232 = extractvalue { i8**, i64 } %t231, 1
  %t233 = icmp eq i64 %t232, 0
  br label %logical_and_right_end_225

logical_and_right_end_225:
  br label %logical_and_merge_225

logical_and_merge_225:
  %t234 = phi i1 [ false, %logical_and_entry_225 ], [ %t233, %logical_and_right_end_225 ]
  store i1 %t234, i1* %l14
  %t235 = load i1, i1* %l14
  %t236 = insertvalue %StructLayoutHeaderParse undef, i1 %t235, 0
  %t237 = load i8*, i8** %l5
  %t238 = insertvalue %StructLayoutHeaderParse %t236, i8* %t237, 1
  %t239 = load double, double* %l6
  %t240 = insertvalue %StructLayoutHeaderParse %t238, double %t239, 2
  %t241 = load double, double* %l7
  %t242 = insertvalue %StructLayoutHeaderParse %t240, double %t241, 3
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = insertvalue %StructLayoutHeaderParse %t242, { i8**, i64 }* %t243, 4
  ret %StructLayoutHeaderParse %t244
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t32 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t27, i8* %t31)
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
  %t321 = phi i8* [ %t56, %entry ], [ %t312, %loop.latch4 ]
  %t322 = phi i1 [ %t57, %entry ], [ %t313, %loop.latch4 ]
  %t323 = phi double [ %t60, %entry ], [ %t314, %loop.latch4 ]
  %t324 = phi { i8**, i64 }* [ %t52, %entry ], [ %t315, %loop.latch4 ]
  %t325 = phi i1 [ %t58, %entry ], [ %t316, %loop.latch4 ]
  %t326 = phi double [ %t61, %entry ], [ %t317, %loop.latch4 ]
  %t327 = phi i1 [ %t59, %entry ], [ %t318, %loop.latch4 ]
  %t328 = phi double [ %t62, %entry ], [ %t319, %loop.latch4 ]
  %t329 = phi double [ %t63, %entry ], [ %t320, %loop.latch4 ]
  store i8* %t321, i8** %l5
  store i1 %t322, i1* %l6
  store double %t323, double* %l9
  store { i8**, i64 }* %t324, { i8**, i64 }** %l1
  store i1 %t325, i1* %l7
  store double %t326, double* %l10
  store i1 %t327, i1* %l8
  store double %t328, double* %l11
  store double %t329, double* %l12
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
  %s283 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.283, i32 0, i32 0
  %t284 = add i8* %t282, %s283
  %t285 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t272, i8* %t284)
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t286 = phi i1 [ 1, %then23 ], [ %t229, %else24 ]
  %t287 = phi double [ %t258, %then23 ], [ %t232, %else24 ]
  %t288 = phi { i8**, i64 }* [ null, %then23 ], [ %t285, %else24 ]
  store i1 %t286, i1* %l8
  store double %t287, double* %l11
  store { i8**, i64 }* %t288, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t289 = phi i1 [ 1, %then17 ], [ %t174, %else18 ]
  %t290 = phi double [ %t204, %then17 ], [ %t177, %else18 ]
  %t291 = phi { i8**, i64 }* [ null, %then17 ], [ null, %else18 ]
  %t292 = phi i1 [ %t175, %then17 ], [ 1, %else18 ]
  %t293 = phi double [ %t178, %then17 ], [ %t258, %else18 ]
  store i1 %t289, i1* %l7
  store double %t290, double* %l10
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  store i1 %t292, i1* %l8
  store double %t293, double* %l11
  br label %merge13
merge13:
  %t294 = phi i1 [ 1, %then11 ], [ %t119, %else12 ]
  %t295 = phi double [ %t150, %then11 ], [ %t122, %else12 ]
  %t296 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t297 = phi i1 [ %t120, %then11 ], [ 1, %else12 ]
  %t298 = phi double [ %t123, %then11 ], [ %t204, %else12 ]
  %t299 = phi i1 [ %t121, %then11 ], [ 1, %else12 ]
  %t300 = phi double [ %t124, %then11 ], [ %t258, %else12 ]
  store i1 %t294, i1* %l6
  store double %t295, double* %l9
  store { i8**, i64 }* %t296, { i8**, i64 }** %l1
  store i1 %t297, i1* %l7
  store double %t298, double* %l10
  store i1 %t299, i1* %l8
  store double %t300, double* %l11
  br label %merge10
merge10:
  %t301 = phi i8* [ null, %then8 ], [ %t99, %else9 ]
  %t302 = phi i1 [ %t100, %then8 ], [ 1, %else9 ]
  %t303 = phi double [ %t103, %then8 ], [ %t150, %else9 ]
  %t304 = phi { i8**, i64 }* [ %t95, %then8 ], [ null, %else9 ]
  %t305 = phi i1 [ %t101, %then8 ], [ 1, %else9 ]
  %t306 = phi double [ %t104, %then8 ], [ %t204, %else9 ]
  %t307 = phi i1 [ %t102, %then8 ], [ 1, %else9 ]
  %t308 = phi double [ %t105, %then8 ], [ %t258, %else9 ]
  store i8* %t301, i8** %l5
  store i1 %t302, i1* %l6
  store double %t303, double* %l9
  store { i8**, i64 }* %t304, { i8**, i64 }** %l1
  store i1 %t305, i1* %l7
  store double %t306, double* %l10
  store i1 %t307, i1* %l8
  store double %t308, double* %l11
  %t309 = load double, double* %l12
  %t310 = sitofp i64 1 to double
  %t311 = fadd double %t309, %t310
  store double %t311, double* %l12
  br label %loop.latch4
loop.latch4:
  %t312 = load i8*, i8** %l5
  %t313 = load i1, i1* %l6
  %t314 = load double, double* %l9
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t316 = load i1, i1* %l7
  %t317 = load double, double* %l10
  %t318 = load i1, i1* %l8
  %t319 = load double, double* %l11
  %t320 = load double, double* %l12
  br label %loop.header2
afterloop5:
  %t330 = load i8*, i8** %l5
  %t331 = load i1, i1* %l6
  %t332 = xor i1 %t331, 1
  %t333 = load i8*, i8** %l0
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t335 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t337 = load i8*, i8** %l4
  %t338 = load i8*, i8** %l5
  %t339 = load i1, i1* %l6
  %t340 = load i1, i1* %l7
  %t341 = load i1, i1* %l8
  %t342 = load double, double* %l9
  %t343 = load double, double* %l10
  %t344 = load double, double* %l11
  %t345 = load double, double* %l12
  br i1 %t332, label %then29, label %merge30
then29:
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s347 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.347, i32 0, i32 0
  %t348 = add i8* %s347, %struct_name
  %s349 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.349, i32 0, i32 0
  %t350 = add i8* %t348, %s349
  %t351 = load i8*, i8** %l4
  %t352 = add i8* %t350, %t351
  %s353 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.353, i32 0, i32 0
  %t354 = add i8* %t352, %s353
  %t355 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t346, i8* %t354)
  store { i8**, i64 }* %t355, { i8**, i64 }** %l1
  br label %merge30
merge30:
  %t356 = phi { i8**, i64 }* [ %t355, %then29 ], [ %t334, %entry ]
  store { i8**, i64 }* %t356, { i8**, i64 }** %l1
  %t357 = load i1, i1* %l7
  %t358 = xor i1 %t357, 1
  %t359 = load i8*, i8** %l0
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t361 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t363 = load i8*, i8** %l4
  %t364 = load i8*, i8** %l5
  %t365 = load i1, i1* %l6
  %t366 = load i1, i1* %l7
  %t367 = load i1, i1* %l8
  %t368 = load double, double* %l9
  %t369 = load double, double* %l10
  %t370 = load double, double* %l11
  %t371 = load double, double* %l12
  br i1 %t358, label %then31, label %merge32
then31:
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s373 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.373, i32 0, i32 0
  %t374 = add i8* %s373, %struct_name
  %s375 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.375, i32 0, i32 0
  %t376 = add i8* %t374, %s375
  %t377 = load i8*, i8** %l4
  %t378 = add i8* %t376, %t377
  %s379 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.379, i32 0, i32 0
  %t380 = add i8* %t378, %s379
  %t381 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t372, i8* %t380)
  store { i8**, i64 }* %t381, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t382 = phi { i8**, i64 }* [ %t381, %then31 ], [ %t360, %entry ]
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  %t383 = load i1, i1* %l8
  %t384 = xor i1 %t383, 1
  %t385 = load i8*, i8** %l0
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t387 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t389 = load i8*, i8** %l4
  %t390 = load i8*, i8** %l5
  %t391 = load i1, i1* %l6
  %t392 = load i1, i1* %l7
  %t393 = load i1, i1* %l8
  %t394 = load double, double* %l9
  %t395 = load double, double* %l10
  %t396 = load double, double* %l11
  %t397 = load double, double* %l12
  br i1 %t384, label %then33, label %merge34
then33:
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s399 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.399, i32 0, i32 0
  %t400 = add i8* %s399, %struct_name
  %s401 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.401, i32 0, i32 0
  %t402 = add i8* %t400, %s401
  %t403 = load i8*, i8** %l4
  %t404 = add i8* %t402, %t403
  %s405 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.405, i32 0, i32 0
  %t406 = add i8* %t404, %s405
  %t407 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t398, i8* %t406)
  store { i8**, i64 }* %t407, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t408 = phi { i8**, i64 }* [ %t407, %then33 ], [ %t386, %entry ]
  store { i8**, i64 }* %t408, { i8**, i64 }** %l1
  %t413 = load i8*, i8** %l5
  store double 0.0, double* %l20
  %t414 = load i8*, i8** %l4
  %t415 = insertvalue %NativeStructLayoutField undef, i8* %t414, 0
  %t416 = load i8*, i8** %l5
  %t417 = insertvalue %NativeStructLayoutField %t415, i8* %t416, 1
  %t418 = load double, double* %l9
  %t419 = insertvalue %NativeStructLayoutField %t417, double %t418, 2
  %t420 = load double, double* %l10
  %t421 = insertvalue %NativeStructLayoutField %t419, double %t420, 3
  %t422 = load double, double* %l11
  %t423 = insertvalue %NativeStructLayoutField %t421, double %t422, 4
  store %NativeStructLayoutField %t423, %NativeStructLayoutField* %l21
  %t424 = load double, double* %l20
  %t425 = fcmp one double %t424, 0.0
  %t426 = insertvalue %StructLayoutFieldParse undef, i1 %t425, 0
  %t427 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t428 = insertvalue %StructLayoutFieldParse %t426, i8* null, 1
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t430 = insertvalue %StructLayoutFieldParse %t428, { i8**, i64 }* %t429, 2
  ret %StructLayoutFieldParse %t430
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
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t15 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t13, i8* %s14)
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
  %t383 = phi i8* [ %t43, %entry ], [ %t370, %loop.latch4 ]
  %t384 = phi i1 [ %t40, %entry ], [ %t371, %loop.latch4 ]
  %t385 = phi i1 [ %t41, %entry ], [ %t372, %loop.latch4 ]
  %t386 = phi double [ %t47, %entry ], [ %t373, %loop.latch4 ]
  %t387 = phi { i8**, i64 }* [ %t39, %entry ], [ %t374, %loop.latch4 ]
  %t388 = phi i1 [ %t42, %entry ], [ %t375, %loop.latch4 ]
  %t389 = phi double [ %t48, %entry ], [ %t376, %loop.latch4 ]
  %t390 = phi i8* [ %t44, %entry ], [ %t377, %loop.latch4 ]
  %t391 = phi i1 [ %t45, %entry ], [ %t378, %loop.latch4 ]
  %t392 = phi double [ %t49, %entry ], [ %t379, %loop.latch4 ]
  %t393 = phi i1 [ %t46, %entry ], [ %t380, %loop.latch4 ]
  %t394 = phi double [ %t50, %entry ], [ %t381, %loop.latch4 ]
  %t395 = phi double [ %t51, %entry ], [ %t382, %loop.latch4 ]
  store i8* %t383, i8** %l5
  store i1 %t384, i1* %l2
  store i1 %t385, i1* %l3
  store double %t386, double* %l9
  store { i8**, i64 }* %t387, { i8**, i64 }** %l1
  store i1 %t388, i1* %l4
  store double %t389, double* %l10
  store i8* %t390, i8** %l6
  store i1 %t391, i1* %l7
  store double %t392, double* %l11
  store i1 %t393, i1* %l8
  store double %t394, double* %l12
  store double %t395, double* %l13
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
  %s320 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.320, i32 0, i32 0
  %t321 = add i8* %t319, %s320
  %t322 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t316, i8* %t321)
  store { i8**, i64 }* %t322, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t323 = phi i1 [ 1, %then32 ], [ %t278, %else33 ]
  %t324 = phi double [ %t309, %then32 ], [ %t282, %else33 ]
  %t325 = phi { i8**, i64 }* [ null, %then32 ], [ %t322, %else33 ]
  store i1 %t323, i1* %l8
  store double %t324, double* %l12
  store { i8**, i64 }* %t325, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t326 = phi i1 [ 1, %then26 ], [ %t228, %else27 ]
  %t327 = phi double [ %t260, %then26 ], [ %t232, %else27 ]
  %t328 = phi { i8**, i64 }* [ null, %then26 ], [ null, %else27 ]
  %t329 = phi i1 [ %t229, %then26 ], [ 1, %else27 ]
  %t330 = phi double [ %t233, %then26 ], [ %t309, %else27 ]
  store i1 %t326, i1* %l7
  store double %t327, double* %l11
  store { i8**, i64 }* %t328, { i8**, i64 }** %l1
  store i1 %t329, i1* %l8
  store double %t330, double* %l12
  br label %merge25
merge25:
  %t331 = phi i8* [ null, %then23 ], [ %t207, %else24 ]
  %t332 = phi i1 [ %t208, %then23 ], [ 1, %else24 ]
  %t333 = phi double [ %t212, %then23 ], [ %t260, %else24 ]
  %t334 = phi { i8**, i64 }* [ %t202, %then23 ], [ null, %else24 ]
  %t335 = phi i1 [ %t209, %then23 ], [ 1, %else24 ]
  %t336 = phi double [ %t213, %then23 ], [ %t309, %else24 ]
  store i8* %t331, i8** %l6
  store i1 %t332, i1* %l7
  store double %t333, double* %l11
  store { i8**, i64 }* %t334, { i8**, i64 }** %l1
  store i1 %t335, i1* %l8
  store double %t336, double* %l12
  br label %merge19
merge19:
  %t337 = phi i1 [ 1, %then17 ], [ %t156, %else18 ]
  %t338 = phi double [ %t191, %then17 ], [ %t162, %else18 ]
  %t339 = phi { i8**, i64 }* [ null, %then17 ], [ null, %else18 ]
  %t340 = phi i8* [ %t158, %then17 ], [ null, %else18 ]
  %t341 = phi i1 [ %t159, %then17 ], [ 1, %else18 ]
  %t342 = phi double [ %t163, %then17 ], [ %t260, %else18 ]
  %t343 = phi i1 [ %t160, %then17 ], [ 1, %else18 ]
  %t344 = phi double [ %t164, %then17 ], [ %t309, %else18 ]
  store i1 %t337, i1* %l4
  store double %t338, double* %l10
  store { i8**, i64 }* %t339, { i8**, i64 }** %l1
  store i8* %t340, i8** %l6
  store i1 %t341, i1* %l7
  store double %t342, double* %l11
  store i1 %t343, i1* %l8
  store double %t344, double* %l12
  br label %merge13
merge13:
  %t345 = phi i1 [ 1, %then11 ], [ %t106, %else12 ]
  %t346 = phi double [ %t142, %then11 ], [ %t112, %else12 ]
  %t347 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t348 = phi i1 [ %t107, %then11 ], [ 1, %else12 ]
  %t349 = phi double [ %t113, %then11 ], [ %t191, %else12 ]
  %t350 = phi i8* [ %t109, %then11 ], [ null, %else12 ]
  %t351 = phi i1 [ %t110, %then11 ], [ 1, %else12 ]
  %t352 = phi double [ %t114, %then11 ], [ %t260, %else12 ]
  %t353 = phi i1 [ %t111, %then11 ], [ 1, %else12 ]
  %t354 = phi double [ %t115, %then11 ], [ %t309, %else12 ]
  store i1 %t345, i1* %l3
  store double %t346, double* %l9
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  store i1 %t348, i1* %l4
  store double %t349, double* %l10
  store i8* %t350, i8** %l6
  store i1 %t351, i1* %l7
  store double %t352, double* %l11
  store i1 %t353, i1* %l8
  store double %t354, double* %l12
  br label %merge10
merge10:
  %t355 = phi i8* [ null, %then8 ], [ %t88, %else9 ]
  %t356 = phi i1 [ 1, %then8 ], [ %t85, %else9 ]
  %t357 = phi i1 [ %t86, %then8 ], [ 1, %else9 ]
  %t358 = phi double [ %t92, %then8 ], [ %t142, %else9 ]
  %t359 = phi { i8**, i64 }* [ %t84, %then8 ], [ null, %else9 ]
  %t360 = phi i1 [ %t87, %then8 ], [ 1, %else9 ]
  %t361 = phi double [ %t93, %then8 ], [ %t191, %else9 ]
  %t362 = phi i8* [ %t89, %then8 ], [ null, %else9 ]
  %t363 = phi i1 [ %t90, %then8 ], [ 1, %else9 ]
  %t364 = phi double [ %t94, %then8 ], [ %t260, %else9 ]
  %t365 = phi i1 [ %t91, %then8 ], [ 1, %else9 ]
  %t366 = phi double [ %t95, %then8 ], [ %t309, %else9 ]
  store i8* %t355, i8** %l5
  store i1 %t356, i1* %l2
  store i1 %t357, i1* %l3
  store double %t358, double* %l9
  store { i8**, i64 }* %t359, { i8**, i64 }** %l1
  store i1 %t360, i1* %l4
  store double %t361, double* %l10
  store i8* %t362, i8** %l6
  store i1 %t363, i1* %l7
  store double %t364, double* %l11
  store i1 %t365, i1* %l8
  store double %t366, double* %l12
  %t367 = load double, double* %l13
  %t368 = sitofp i64 1 to double
  %t369 = fadd double %t367, %t368
  store double %t369, double* %l13
  br label %loop.latch4
loop.latch4:
  %t370 = load i8*, i8** %l5
  %t371 = load i1, i1* %l2
  %t372 = load i1, i1* %l3
  %t373 = load double, double* %l9
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t375 = load i1, i1* %l4
  %t376 = load double, double* %l10
  %t377 = load i8*, i8** %l6
  %t378 = load i1, i1* %l7
  %t379 = load double, double* %l11
  %t380 = load i1, i1* %l8
  %t381 = load double, double* %l12
  %t382 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t396 = load i1, i1* %l3
  %t397 = xor i1 %t396, 1
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t400 = load i1, i1* %l2
  %t401 = load i1, i1* %l3
  %t402 = load i1, i1* %l4
  %t403 = load i8*, i8** %l5
  %t404 = load i8*, i8** %l6
  %t405 = load i1, i1* %l7
  %t406 = load i1, i1* %l8
  %t407 = load double, double* %l9
  %t408 = load double, double* %l10
  %t409 = load double, double* %l11
  %t410 = load double, double* %l12
  %t411 = load double, double* %l13
  br i1 %t397, label %then38, label %merge39
then38:
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s413 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.413, i32 0, i32 0
  %t414 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t412, i8* %s413)
  store { i8**, i64 }* %t414, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t415 = phi { i8**, i64 }* [ %t414, %then38 ], [ %t399, %entry ]
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  %t416 = load i1, i1* %l4
  %t417 = xor i1 %t416, 1
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t420 = load i1, i1* %l2
  %t421 = load i1, i1* %l3
  %t422 = load i1, i1* %l4
  %t423 = load i8*, i8** %l5
  %t424 = load i8*, i8** %l6
  %t425 = load i1, i1* %l7
  %t426 = load i1, i1* %l8
  %t427 = load double, double* %l9
  %t428 = load double, double* %l10
  %t429 = load double, double* %l11
  %t430 = load double, double* %l12
  %t431 = load double, double* %l13
  br i1 %t417, label %then40, label %merge41
then40:
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s433 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.433, i32 0, i32 0
  %t434 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t432, i8* %s433)
  store { i8**, i64 }* %t434, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t435 = phi { i8**, i64 }* [ %t434, %then40 ], [ %t419, %entry ]
  store { i8**, i64 }* %t435, { i8**, i64 }** %l1
  %t436 = load i8*, i8** %l6
  %t437 = load i1, i1* %l7
  %t438 = xor i1 %t437, 1
  %t439 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t441 = load i1, i1* %l2
  %t442 = load i1, i1* %l3
  %t443 = load i1, i1* %l4
  %t444 = load i8*, i8** %l5
  %t445 = load i8*, i8** %l6
  %t446 = load i1, i1* %l7
  %t447 = load i1, i1* %l8
  %t448 = load double, double* %l9
  %t449 = load double, double* %l10
  %t450 = load double, double* %l11
  %t451 = load double, double* %l12
  %t452 = load double, double* %l13
  br i1 %t438, label %then42, label %merge43
then42:
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s454 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.454, i32 0, i32 0
  %t455 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t453, i8* %s454)
  store { i8**, i64 }* %t455, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t456 = phi { i8**, i64 }* [ %t455, %then42 ], [ %t440, %entry ]
  store { i8**, i64 }* %t456, { i8**, i64 }** %l1
  %t457 = load i1, i1* %l8
  %t458 = xor i1 %t457, 1
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t461 = load i1, i1* %l2
  %t462 = load i1, i1* %l3
  %t463 = load i1, i1* %l4
  %t464 = load i8*, i8** %l5
  %t465 = load i8*, i8** %l6
  %t466 = load i1, i1* %l7
  %t467 = load i1, i1* %l8
  %t468 = load double, double* %l9
  %t469 = load double, double* %l10
  %t470 = load double, double* %l11
  %t471 = load double, double* %l12
  %t472 = load double, double* %l13
  br i1 %t458, label %then44, label %merge45
then44:
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s474 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.474, i32 0, i32 0
  %t475 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t473, i8* %s474)
  store { i8**, i64 }* %t475, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t476 = phi { i8**, i64 }* [ %t475, %then44 ], [ %t460, %entry ]
  store { i8**, i64 }* %t476, { i8**, i64 }** %l1
  %t482 = load i1, i1* %l3
  br label %logical_and_entry_481

logical_and_entry_481:
  br i1 %t482, label %logical_and_right_481, label %logical_and_merge_481

logical_and_right_481:
  %t483 = load i1, i1* %l4
  br label %logical_and_right_end_481

logical_and_right_end_481:
  br label %logical_and_merge_481

logical_and_merge_481:
  %t484 = phi i1 [ false, %logical_and_entry_481 ], [ %t483, %logical_and_right_end_481 ]
  br label %logical_and_entry_480

logical_and_entry_480:
  br i1 %t484, label %logical_and_right_480, label %logical_and_merge_480

logical_and_right_480:
  %t485 = load i8*, i8** %l6
  store double 0.0, double* %l23
  %t486 = load double, double* %l23
  %t487 = fcmp one double %t486, 0.0
  %t488 = insertvalue %EnumLayoutHeaderParse undef, i1 %t487, 0
  %t489 = load i8*, i8** %l5
  %t490 = insertvalue %EnumLayoutHeaderParse %t488, i8* %t489, 1
  %t491 = load double, double* %l9
  %t492 = insertvalue %EnumLayoutHeaderParse %t490, double %t491, 2
  %t493 = load double, double* %l10
  %t494 = insertvalue %EnumLayoutHeaderParse %t492, double %t493, 3
  %t495 = load i8*, i8** %l6
  %t496 = insertvalue %EnumLayoutHeaderParse %t494, i8* %t495, 4
  %t497 = load double, double* %l11
  %t498 = insertvalue %EnumLayoutHeaderParse %t496, double %t497, 5
  %t499 = load double, double* %l12
  %t500 = insertvalue %EnumLayoutHeaderParse %t498, double %t499, 6
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t502 = insertvalue %EnumLayoutHeaderParse %t500, { i8**, i64 }* %t501, 7
  ret %EnumLayoutHeaderParse %t502
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  %t21 = insertvalue %NativeEnumVariantLayout %t15, { i8**, i64 }* null, 5
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
  %t38 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t33, i8* %t37)
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
  %t374 = phi i1 [ %t62, %entry ], [ %t364, %loop.latch4 ]
  %t375 = phi double [ %t66, %entry ], [ %t365, %loop.latch4 ]
  %t376 = phi { i8**, i64 }* [ %t58, %entry ], [ %t366, %loop.latch4 ]
  %t377 = phi i1 [ %t63, %entry ], [ %t367, %loop.latch4 ]
  %t378 = phi double [ %t67, %entry ], [ %t368, %loop.latch4 ]
  %t379 = phi i1 [ %t64, %entry ], [ %t369, %loop.latch4 ]
  %t380 = phi double [ %t68, %entry ], [ %t370, %loop.latch4 ]
  %t381 = phi i1 [ %t65, %entry ], [ %t371, %loop.latch4 ]
  %t382 = phi double [ %t69, %entry ], [ %t372, %loop.latch4 ]
  %t383 = phi double [ %t70, %entry ], [ %t373, %loop.latch4 ]
  store i1 %t374, i1* %l5
  store double %t375, double* %l9
  store { i8**, i64 }* %t376, { i8**, i64 }** %l1
  store i1 %t377, i1* %l6
  store double %t378, double* %l10
  store i1 %t379, i1* %l7
  store double %t380, double* %l11
  store i1 %t381, i1* %l8
  store double %t382, double* %l12
  store double %t383, double* %l13
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
  %s334 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.334, i32 0, i32 0
  %t335 = add i8* %t333, %s334
  %t336 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t323, i8* %t335)
  store { i8**, i64 }* %t336, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t337 = phi i1 [ 1, %then26 ], [ %t278, %else27 ]
  %t338 = phi double [ %t309, %then26 ], [ %t282, %else27 ]
  %t339 = phi { i8**, i64 }* [ null, %then26 ], [ %t336, %else27 ]
  store i1 %t337, i1* %l8
  store double %t338, double* %l12
  store { i8**, i64 }* %t339, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t340 = phi i1 [ 1, %then20 ], [ %t221, %else21 ]
  %t341 = phi double [ %t253, %then20 ], [ %t225, %else21 ]
  %t342 = phi { i8**, i64 }* [ null, %then20 ], [ null, %else21 ]
  %t343 = phi i1 [ %t222, %then20 ], [ 1, %else21 ]
  %t344 = phi double [ %t226, %then20 ], [ %t309, %else21 ]
  store i1 %t340, i1* %l7
  store double %t341, double* %l11
  store { i8**, i64 }* %t342, { i8**, i64 }** %l1
  store i1 %t343, i1* %l8
  store double %t344, double* %l12
  br label %merge16
merge16:
  %t345 = phi i1 [ 1, %then14 ], [ %t164, %else15 ]
  %t346 = phi double [ %t197, %then14 ], [ %t168, %else15 ]
  %t347 = phi { i8**, i64 }* [ null, %then14 ], [ null, %else15 ]
  %t348 = phi i1 [ %t165, %then14 ], [ 1, %else15 ]
  %t349 = phi double [ %t169, %then14 ], [ %t253, %else15 ]
  %t350 = phi i1 [ %t166, %then14 ], [ 1, %else15 ]
  %t351 = phi double [ %t170, %then14 ], [ %t309, %else15 ]
  store i1 %t345, i1* %l6
  store double %t346, double* %l10
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  store i1 %t348, i1* %l7
  store double %t349, double* %l11
  store i1 %t350, i1* %l8
  store double %t351, double* %l12
  br label %merge10
merge10:
  %t352 = phi i1 [ 1, %then8 ], [ %t107, %else9 ]
  %t353 = phi double [ %t141, %then8 ], [ %t111, %else9 ]
  %t354 = phi { i8**, i64 }* [ null, %then8 ], [ null, %else9 ]
  %t355 = phi i1 [ %t108, %then8 ], [ 1, %else9 ]
  %t356 = phi double [ %t112, %then8 ], [ %t197, %else9 ]
  %t357 = phi i1 [ %t109, %then8 ], [ 1, %else9 ]
  %t358 = phi double [ %t113, %then8 ], [ %t253, %else9 ]
  %t359 = phi i1 [ %t110, %then8 ], [ 1, %else9 ]
  %t360 = phi double [ %t114, %then8 ], [ %t309, %else9 ]
  store i1 %t352, i1* %l5
  store double %t353, double* %l9
  store { i8**, i64 }* %t354, { i8**, i64 }** %l1
  store i1 %t355, i1* %l6
  store double %t356, double* %l10
  store i1 %t357, i1* %l7
  store double %t358, double* %l11
  store i1 %t359, i1* %l8
  store double %t360, double* %l12
  %t361 = load double, double* %l13
  %t362 = sitofp i64 1 to double
  %t363 = fadd double %t361, %t362
  store double %t363, double* %l13
  br label %loop.latch4
loop.latch4:
  %t364 = load i1, i1* %l5
  %t365 = load double, double* %l9
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t367 = load i1, i1* %l6
  %t368 = load double, double* %l10
  %t369 = load i1, i1* %l7
  %t370 = load double, double* %l11
  %t371 = load i1, i1* %l8
  %t372 = load double, double* %l12
  %t373 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t384 = load i1, i1* %l5
  %t385 = xor i1 %t384, 1
  %t386 = load i8*, i8** %l0
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t388 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t390 = load i8*, i8** %l4
  %t391 = load i1, i1* %l5
  %t392 = load i1, i1* %l6
  %t393 = load i1, i1* %l7
  %t394 = load i1, i1* %l8
  %t395 = load double, double* %l9
  %t396 = load double, double* %l10
  %t397 = load double, double* %l11
  %t398 = load double, double* %l12
  %t399 = load double, double* %l13
  br i1 %t385, label %then32, label %merge33
then32:
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s401 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.401, i32 0, i32 0
  %t402 = add i8* %s401, %enum_name
  %s403 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.403, i32 0, i32 0
  %t404 = add i8* %t402, %s403
  %t405 = load i8*, i8** %l4
  %t406 = add i8* %t404, %t405
  %s407 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.407, i32 0, i32 0
  %t408 = add i8* %t406, %s407
  %t409 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t400, i8* %t408)
  store { i8**, i64 }* %t409, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t410 = phi { i8**, i64 }* [ %t409, %then32 ], [ %t387, %entry ]
  store { i8**, i64 }* %t410, { i8**, i64 }** %l1
  %t411 = load i1, i1* %l6
  %t412 = xor i1 %t411, 1
  %t413 = load i8*, i8** %l0
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t415 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t417 = load i8*, i8** %l4
  %t418 = load i1, i1* %l5
  %t419 = load i1, i1* %l6
  %t420 = load i1, i1* %l7
  %t421 = load i1, i1* %l8
  %t422 = load double, double* %l9
  %t423 = load double, double* %l10
  %t424 = load double, double* %l11
  %t425 = load double, double* %l12
  %t426 = load double, double* %l13
  br i1 %t412, label %then34, label %merge35
then34:
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s428 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.428, i32 0, i32 0
  %t429 = add i8* %s428, %enum_name
  %s430 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.430, i32 0, i32 0
  %t431 = add i8* %t429, %s430
  %t432 = load i8*, i8** %l4
  %t433 = add i8* %t431, %t432
  %s434 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.434, i32 0, i32 0
  %t435 = add i8* %t433, %s434
  %t436 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t427, i8* %t435)
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t437 = phi { i8**, i64 }* [ %t436, %then34 ], [ %t414, %entry ]
  store { i8**, i64 }* %t437, { i8**, i64 }** %l1
  %t438 = load i1, i1* %l7
  %t439 = xor i1 %t438, 1
  %t440 = load i8*, i8** %l0
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t442 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t444 = load i8*, i8** %l4
  %t445 = load i1, i1* %l5
  %t446 = load i1, i1* %l6
  %t447 = load i1, i1* %l7
  %t448 = load i1, i1* %l8
  %t449 = load double, double* %l9
  %t450 = load double, double* %l10
  %t451 = load double, double* %l11
  %t452 = load double, double* %l12
  %t453 = load double, double* %l13
  br i1 %t439, label %then36, label %merge37
then36:
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s455 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.455, i32 0, i32 0
  %t456 = add i8* %s455, %enum_name
  %s457 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.457, i32 0, i32 0
  %t458 = add i8* %t456, %s457
  %t459 = load i8*, i8** %l4
  %t460 = add i8* %t458, %t459
  %s461 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.461, i32 0, i32 0
  %t462 = add i8* %t460, %s461
  %t463 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t454, i8* %t462)
  store { i8**, i64 }* %t463, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t464 = phi { i8**, i64 }* [ %t463, %then36 ], [ %t441, %entry ]
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  %t465 = load i1, i1* %l8
  %t466 = xor i1 %t465, 1
  %t467 = load i8*, i8** %l0
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t469 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t471 = load i8*, i8** %l4
  %t472 = load i1, i1* %l5
  %t473 = load i1, i1* %l6
  %t474 = load i1, i1* %l7
  %t475 = load i1, i1* %l8
  %t476 = load double, double* %l9
  %t477 = load double, double* %l10
  %t478 = load double, double* %l11
  %t479 = load double, double* %l12
  %t480 = load double, double* %l13
  br i1 %t466, label %then38, label %merge39
then38:
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s482 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.482, i32 0, i32 0
  %t483 = add i8* %s482, %enum_name
  %s484 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.484, i32 0, i32 0
  %t485 = add i8* %t483, %s484
  %t486 = load i8*, i8** %l4
  %t487 = add i8* %t485, %t486
  %s488 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.488, i32 0, i32 0
  %t489 = add i8* %t487, %s488
  %t490 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t481, i8* %t489)
  store { i8**, i64 }* %t490, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t491 = phi { i8**, i64 }* [ %t490, %then38 ], [ %t468, %entry ]
  store { i8**, i64 }* %t491, { i8**, i64 }** %l1
  %t496 = load i1, i1* %l5
  br label %logical_and_entry_495

logical_and_entry_495:
  br i1 %t496, label %logical_and_right_495, label %logical_and_merge_495

logical_and_right_495:
  %t497 = load i1, i1* %l6
  br label %logical_and_right_end_495

logical_and_right_end_495:
  br label %logical_and_merge_495

logical_and_merge_495:
  %t498 = phi i1 [ false, %logical_and_entry_495 ], [ %t497, %logical_and_right_end_495 ]
  br label %logical_and_entry_494

logical_and_entry_494:
  br i1 %t498, label %logical_and_right_494, label %logical_and_merge_494

logical_and_right_494:
  %t499 = load i1, i1* %l7
  br label %logical_and_right_end_494

logical_and_right_end_494:
  br label %logical_and_merge_494

logical_and_merge_494:
  %t500 = phi i1 [ false, %logical_and_entry_494 ], [ %t499, %logical_and_right_end_494 ]
  br label %logical_and_entry_493

logical_and_entry_493:
  br i1 %t500, label %logical_and_right_493, label %logical_and_merge_493

logical_and_right_493:
  %t501 = load i1, i1* %l8
  br label %logical_and_right_end_493

logical_and_right_end_493:
  br label %logical_and_merge_493

logical_and_merge_493:
  %t502 = phi i1 [ false, %logical_and_entry_493 ], [ %t501, %logical_and_right_end_493 ]
  br label %logical_and_entry_492

logical_and_entry_492:
  br i1 %t502, label %logical_and_right_492, label %logical_and_merge_492

logical_and_right_492:
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t504 = load { i8**, i64 }, { i8**, i64 }* %t503
  %t505 = extractvalue { i8**, i64 } %t504, 1
  %t506 = icmp eq i64 %t505, 0
  br label %logical_and_right_end_492

logical_and_right_end_492:
  br label %logical_and_merge_492

logical_and_merge_492:
  %t507 = phi i1 [ false, %logical_and_entry_492 ], [ %t506, %logical_and_right_end_492 ]
  store i1 %t507, i1* %l23
  %t508 = load i8*, i8** %l4
  %t509 = insertvalue %NativeEnumVariantLayout undef, i8* %t508, 0
  %t510 = load double, double* %l9
  %t511 = insertvalue %NativeEnumVariantLayout %t509, double %t510, 1
  %t512 = load double, double* %l10
  %t513 = insertvalue %NativeEnumVariantLayout %t511, double %t512, 2
  %t514 = load double, double* %l11
  %t515 = insertvalue %NativeEnumVariantLayout %t513, double %t514, 3
  %t516 = load double, double* %l12
  %t517 = insertvalue %NativeEnumVariantLayout %t515, double %t516, 4
  %t518 = alloca [0 x double]
  %t519 = getelementptr [0 x double], [0 x double]* %t518, i32 0, i32 0
  %t520 = alloca { double*, i64 }
  %t521 = getelementptr { double*, i64 }, { double*, i64 }* %t520, i32 0, i32 0
  store double* %t519, double** %t521
  %t522 = getelementptr { double*, i64 }, { double*, i64 }* %t520, i32 0, i32 1
  store i64 0, i64* %t522
  %t523 = insertvalue %NativeEnumVariantLayout %t517, { i8**, i64 }* null, 5
  store %NativeEnumVariantLayout %t523, %NativeEnumVariantLayout* %l24
  %t524 = load i1, i1* %l23
  %t525 = insertvalue %EnumLayoutVariantParse undef, i1 %t524, 0
  %t526 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t527 = insertvalue %EnumLayoutVariantParse %t525, i8* null, 1
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t529 = insertvalue %EnumLayoutVariantParse %t527, { i8**, i64 }* %t528, 2
  ret %EnumLayoutVariantParse %t529
}

define %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t32 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t27, i8* %t31)
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
  %s48 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.48, i32 0, i32 0
  %t49 = call double @index_of(i8* %t47, i8* %s48)
  store double %t49, double* %l5
  %t51 = load double, double* %l5
  %t52 = sitofp i64 0 to double
  %t53 = fcmp ole double %t51, %t52
  br label %logical_or_entry_50

logical_or_entry_50:
  br i1 %t53, label %logical_or_merge_50, label %logical_or_right_50

logical_or_right_50:
  %t54 = load double, double* %l5
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  %t57 = load i8*, i8** %l4
  %t58 = load i8*, i8** %l4
  %t59 = load double, double* %l5
  %t60 = call double @substring(i8* %t58, i64 0, double %t59)
  store double %t60, double* %l6
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
  %t77 = load double, double* %l6
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
  %t368 = phi i8* [ %t79, %entry ], [ %t359, %loop.latch4 ]
  %t369 = phi i1 [ %t80, %entry ], [ %t360, %loop.latch4 ]
  %t370 = phi double [ %t83, %entry ], [ %t361, %loop.latch4 ]
  %t371 = phi { i8**, i64 }* [ %t72, %entry ], [ %t362, %loop.latch4 ]
  %t372 = phi i1 [ %t81, %entry ], [ %t363, %loop.latch4 ]
  %t373 = phi double [ %t84, %entry ], [ %t364, %loop.latch4 ]
  %t374 = phi i1 [ %t82, %entry ], [ %t365, %loop.latch4 ]
  %t375 = phi double [ %t85, %entry ], [ %t366, %loop.latch4 ]
  %t376 = phi double [ %t86, %entry ], [ %t367, %loop.latch4 ]
  store i8* %t368, i8** %l8
  store i1 %t369, i1* %l9
  store double %t370, double* %l12
  store { i8**, i64 }* %t371, { i8**, i64 }** %l1
  store i1 %t372, i1* %l10
  store double %t373, double* %l13
  store i1 %t374, i1* %l11
  store double %t375, double* %l14
  store double %t376, double* %l15
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
  %t99 = load double, double* %l6
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
  %t126 = load double, double* %l6
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
  %t148 = load double, double* %l6
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
  %t171 = load double, double* %l6
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
  %t208 = load double, double* %l6
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
  %t231 = load double, double* %l6
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
  %t268 = load double, double* %l6
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
  %t291 = load double, double* %l6
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
  %s330 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.330, i32 0, i32 0
  %t331 = add i8* %t329, %s330
  %t332 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t319, i8* %t331)
  store { i8**, i64 }* %t332, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t333 = phi i1 [ 1, %then23 ], [ %t273, %else24 ]
  %t334 = phi double [ %t305, %then23 ], [ %t276, %else24 ]
  %t335 = phi { i8**, i64 }* [ null, %then23 ], [ %t332, %else24 ]
  store i1 %t333, i1* %l11
  store double %t334, double* %l14
  store { i8**, i64 }* %t335, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t336 = phi i1 [ 1, %then17 ], [ %t212, %else18 ]
  %t337 = phi double [ %t245, %then17 ], [ %t215, %else18 ]
  %t338 = phi { i8**, i64 }* [ null, %then17 ], [ null, %else18 ]
  %t339 = phi i1 [ %t213, %then17 ], [ 1, %else18 ]
  %t340 = phi double [ %t216, %then17 ], [ %t305, %else18 ]
  store i1 %t336, i1* %l10
  store double %t337, double* %l13
  store { i8**, i64 }* %t338, { i8**, i64 }** %l1
  store i1 %t339, i1* %l11
  store double %t340, double* %l14
  br label %merge13
merge13:
  %t341 = phi i1 [ 1, %then11 ], [ %t151, %else12 ]
  %t342 = phi double [ %t185, %then11 ], [ %t154, %else12 ]
  %t343 = phi { i8**, i64 }* [ null, %then11 ], [ null, %else12 ]
  %t344 = phi i1 [ %t152, %then11 ], [ 1, %else12 ]
  %t345 = phi double [ %t155, %then11 ], [ %t245, %else12 ]
  %t346 = phi i1 [ %t153, %then11 ], [ 1, %else12 ]
  %t347 = phi double [ %t156, %then11 ], [ %t305, %else12 ]
  store i1 %t341, i1* %l9
  store double %t342, double* %l12
  store { i8**, i64 }* %t343, { i8**, i64 }** %l1
  store i1 %t344, i1* %l10
  store double %t345, double* %l13
  store i1 %t346, i1* %l11
  store double %t347, double* %l14
  br label %merge10
merge10:
  %t348 = phi i8* [ null, %then8 ], [ %t128, %else9 ]
  %t349 = phi i1 [ %t129, %then8 ], [ 1, %else9 ]
  %t350 = phi double [ %t132, %then8 ], [ %t185, %else9 ]
  %t351 = phi { i8**, i64 }* [ %t121, %then8 ], [ null, %else9 ]
  %t352 = phi i1 [ %t130, %then8 ], [ 1, %else9 ]
  %t353 = phi double [ %t133, %then8 ], [ %t245, %else9 ]
  %t354 = phi i1 [ %t131, %then8 ], [ 1, %else9 ]
  %t355 = phi double [ %t134, %then8 ], [ %t305, %else9 ]
  store i8* %t348, i8** %l8
  store i1 %t349, i1* %l9
  store double %t350, double* %l12
  store { i8**, i64 }* %t351, { i8**, i64 }** %l1
  store i1 %t352, i1* %l10
  store double %t353, double* %l13
  store i1 %t354, i1* %l11
  store double %t355, double* %l14
  %t356 = load double, double* %l15
  %t357 = sitofp i64 1 to double
  %t358 = fadd double %t356, %t357
  store double %t358, double* %l15
  br label %loop.latch4
loop.latch4:
  %t359 = load i8*, i8** %l8
  %t360 = load i1, i1* %l9
  %t361 = load double, double* %l12
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t363 = load i1, i1* %l10
  %t364 = load double, double* %l13
  %t365 = load i1, i1* %l11
  %t366 = load double, double* %l14
  %t367 = load double, double* %l15
  br label %loop.header2
afterloop5:
  %t377 = load i8*, i8** %l8
  %t378 = load i1, i1* %l9
  %t379 = xor i1 %t378, 1
  %t380 = load i8*, i8** %l0
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t384 = load i8*, i8** %l4
  %t385 = load double, double* %l5
  %t386 = load double, double* %l6
  %t387 = load double, double* %l7
  %t388 = load i8*, i8** %l8
  %t389 = load i1, i1* %l9
  %t390 = load i1, i1* %l10
  %t391 = load i1, i1* %l11
  %t392 = load double, double* %l12
  %t393 = load double, double* %l13
  %t394 = load double, double* %l14
  %t395 = load double, double* %l15
  br i1 %t379, label %then29, label %merge30
then29:
  %t396 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s397 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.397, i32 0, i32 0
  %t398 = add i8* %s397, %enum_name
  %s399 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.399, i32 0, i32 0
  %t400 = add i8* %t398, %s399
  %t401 = load i8*, i8** %l4
  %t402 = add i8* %t400, %t401
  %s403 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.403, i32 0, i32 0
  %t404 = add i8* %t402, %s403
  %t405 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t396, i8* %t404)
  store { i8**, i64 }* %t405, { i8**, i64 }** %l1
  br label %merge30
merge30:
  %t406 = phi { i8**, i64 }* [ %t405, %then29 ], [ %t381, %entry ]
  store { i8**, i64 }* %t406, { i8**, i64 }** %l1
  %t407 = load i1, i1* %l10
  %t408 = xor i1 %t407, 1
  %t409 = load i8*, i8** %l0
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t411 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t413 = load i8*, i8** %l4
  %t414 = load double, double* %l5
  %t415 = load double, double* %l6
  %t416 = load double, double* %l7
  %t417 = load i8*, i8** %l8
  %t418 = load i1, i1* %l9
  %t419 = load i1, i1* %l10
  %t420 = load i1, i1* %l11
  %t421 = load double, double* %l12
  %t422 = load double, double* %l13
  %t423 = load double, double* %l14
  %t424 = load double, double* %l15
  br i1 %t408, label %then31, label %merge32
then31:
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s426 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.426, i32 0, i32 0
  %t427 = add i8* %s426, %enum_name
  %s428 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.428, i32 0, i32 0
  %t429 = add i8* %t427, %s428
  %t430 = load i8*, i8** %l4
  %t431 = add i8* %t429, %t430
  %s432 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.432, i32 0, i32 0
  %t433 = add i8* %t431, %s432
  %t434 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t425, i8* %t433)
  store { i8**, i64 }* %t434, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t435 = phi { i8**, i64 }* [ %t434, %then31 ], [ %t410, %entry ]
  store { i8**, i64 }* %t435, { i8**, i64 }** %l1
  %t436 = load i1, i1* %l11
  %t437 = xor i1 %t436, 1
  %t438 = load i8*, i8** %l0
  %t439 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t440 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t442 = load i8*, i8** %l4
  %t443 = load double, double* %l5
  %t444 = load double, double* %l6
  %t445 = load double, double* %l7
  %t446 = load i8*, i8** %l8
  %t447 = load i1, i1* %l9
  %t448 = load i1, i1* %l10
  %t449 = load i1, i1* %l11
  %t450 = load double, double* %l12
  %t451 = load double, double* %l13
  %t452 = load double, double* %l14
  %t453 = load double, double* %l15
  br i1 %t437, label %then33, label %merge34
then33:
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s455 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.455, i32 0, i32 0
  %t456 = add i8* %s455, %enum_name
  %s457 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.457, i32 0, i32 0
  %t458 = add i8* %t456, %s457
  %t459 = load i8*, i8** %l4
  %t460 = add i8* %t458, %t459
  %s461 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.461, i32 0, i32 0
  %t462 = add i8* %t460, %s461
  %t463 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t454, i8* %t462)
  store { i8**, i64 }* %t463, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t464 = phi { i8**, i64 }* [ %t463, %then33 ], [ %t439, %entry ]
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  %t469 = load i8*, i8** %l8
  store double 0.0, double* %l23
  %t470 = load double, double* %l7
  %t471 = insertvalue %NativeStructLayoutField undef, i8* null, 0
  %t472 = load i8*, i8** %l8
  %t473 = insertvalue %NativeStructLayoutField %t471, i8* %t472, 1
  %t474 = load double, double* %l12
  %t475 = insertvalue %NativeStructLayoutField %t473, double %t474, 2
  %t476 = load double, double* %l13
  %t477 = insertvalue %NativeStructLayoutField %t475, double %t476, 3
  %t478 = load double, double* %l14
  %t479 = insertvalue %NativeStructLayoutField %t477, double %t478, 4
  store %NativeStructLayoutField %t479, %NativeStructLayoutField* %l24
  %t480 = load double, double* %l23
  %t481 = fcmp one double %t480, 0.0
  %t482 = insertvalue %EnumLayoutPayloadParse undef, i1 %t481, 0
  %t483 = load double, double* %l6
  %t484 = insertvalue %EnumLayoutPayloadParse %t482, i8* null, 1
  %t485 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t486 = insertvalue %EnumLayoutPayloadParse %t484, i8* null, 2
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t488 = insertvalue %EnumLayoutPayloadParse %t486, { i8**, i64 }* %t487, 3
  ret %EnumLayoutPayloadParse %t488
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
  %t19 = phi i8* [ %t2, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t3, %entry ], [ %t18, %loop.latch2 ]
  store i8* %t19, i8** %l0
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t10 = load i8, i8* %l2
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8*, i8** %l0
  %t13 = load i8, i8* %l2
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @trim_text(i8* %t21)
  store i8* %t22, i8** %l0
  %s23 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l3
  store i8* null, i8** %l4
  %t24 = load double, double* %l1
  store i8* null, i8** %l5
  %t25 = load i8*, i8** %l5
  %t26 = load i8*, i8** %l0
  %t27 = insertvalue %BindingComponents undef, i8* %t26, 0
  %t28 = load i8*, i8** %l3
  %t29 = insertvalue %BindingComponents %t27, i8* %t28, 1
  %t30 = load i8*, i8** %l4
  %t31 = insertvalue %BindingComponents %t29, i8* %t30, 2
  ret %BindingComponents %t31
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
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = call double @index_of(i8* %t10, i8* %s11)
  store double %t12, double* %l1
  %t13 = load i8*, i8** %l0
  store i8* %t13, i8** %l2
  %t14 = load double, double* %l1
  %t15 = sitofp i64 0 to double
  %t16 = fcmp oge double %t14, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  br i1 %t16, label %then2, label %merge3
then2:
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = call double @substring(i8* %t20, i64 0, double %t21)
  %t23 = call i8* @trim_text(i8* null)
  store i8* %t23, i8** %l2
  br label %merge3
merge3:
  %t24 = phi i8* [ %t23, %then2 ], [ %t19, %entry ]
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = call double @last_index_of(i8* %t25, i8* %s26)
  store double %t27, double* %l3
  %t28 = load double, double* %l3
  %t29 = sitofp i64 0 to double
  %t30 = fcmp oge double %t28, %t29
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then4, label %merge5
then4:
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  %t39 = load i8*, i8** %l2
  br label %merge5
merge5:
  %t40 = phi i8* [ null, %then4 ], [ %t33, %entry ]
  store i8* %t40, i8** %l2
  %t41 = load i8*, i8** %l2
  %t42 = call i8* @strip_generics(i8* %t41)
  ret i8* %t42
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
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @starts_with(i8* %t2, i8* %s3)
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t10 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp oge double %t11, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = call double @substring(i8* %t16, i64 0, double %t17)
  %t19 = call i8* @trim_text(i8* null)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8*, i8** %l2
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @starts_with(i8* %t21, i8* %s22)
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then6, label %merge7
then6:
  %t27 = load i8*, i8** %l2
  %s28 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.28, i32 0, i32 0
  %t29 = call i8* @strip_prefix(i8* %t27, i8* %s28)
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l2
  br label %merge7
merge7:
  %t31 = phi i8* [ %t30, %then6 ], [ %t26, %then4 ]
  store i8* %t31, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = load i8*, i8** %l2
  %s34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.34, i32 0, i32 0
  %t35 = call double @index_of(i8* %t33, i8* %s34)
  %t36 = sitofp i64 0 to double
  %t37 = fcmp oge double %t35, %t36
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  br i1 %t37, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t41 = load i8*, i8** %l2
  %s42 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.42, i32 0, i32 0
  %t43 = call double @index_of(i8* %t41, i8* %s42)
  %t44 = sitofp i64 0 to double
  %t45 = fcmp oge double %t43, %t44
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  br i1 %t45, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  ret i1 1
merge5:
  %t49 = load i8*, i8** %l0
  %s50 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.50, i32 0, i32 0
  %t51 = call double @index_of(i8* %t49, i8* %s50)
  store double %t51, double* %l3
  %t52 = load double, double* %l3
  %t53 = sitofp i64 0 to double
  %t54 = fcmp oge double %t52, %t53
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l3
  br i1 %t54, label %then12, label %merge13
then12:
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l3
  %t60 = call double @substring(i8* %t58, i64 0, double %t59)
  %t61 = call i8* @trim_text(i8* null)
  store i8* %t61, i8** %l4
  %t62 = load i8*, i8** %l4
  %t63 = load i8*, i8** %l4
  %s64 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.64, i32 0, i32 0
  %t65 = call i1 @starts_with(i8* %t63, i8* %s64)
  %t66 = load i8*, i8** %l0
  %t67 = load double, double* %l1
  %t68 = load double, double* %l3
  %t69 = load i8*, i8** %l4
  br i1 %t65, label %then14, label %merge15
then14:
  %t70 = load i8*, i8** %l4
  %s71 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.71, i32 0, i32 0
  %t72 = call i8* @strip_prefix(i8* %t70, i8* %s71)
  %t73 = call i8* @trim_text(i8* %t72)
  store i8* %t73, i8** %l4
  br label %merge15
merge15:
  %t74 = phi i8* [ %t73, %then14 ], [ %t69, %then12 ]
  store i8* %t74, i8** %l4
  %t75 = load i8*, i8** %l4
  %t76 = load i8*, i8** %l4
  %s77 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.77, i32 0, i32 0
  %t78 = call double @index_of(i8* %t76, i8* %s77)
  %t79 = sitofp i64 0 to double
  %t80 = fcmp oge double %t78, %t79
  %t81 = load i8*, i8** %l0
  %t82 = load double, double* %l1
  %t83 = load double, double* %l3
  %t84 = load i8*, i8** %l4
  br i1 %t80, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  %t85 = load i8*, i8** %l4
  %s86 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %t87 = call double @index_of(i8* %t85, i8* %s86)
  %t88 = sitofp i64 0 to double
  %t89 = fcmp oge double %t87, %t88
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l1
  %t92 = load double, double* %l3
  %t93 = load i8*, i8** %l4
  br i1 %t89, label %then18, label %merge19
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
  %t39 = phi i8* [ %t10, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t11, %entry ], [ %t38, %loop.latch2 ]
  store i8* %t39, i8** %l1
  store double %t40, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = getelementptr i8, i8* %body, i64 %t15
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l5
  %t18 = load i8*, i8** %l4
  %t20 = load i8, i8* %l5
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t24 = load i8, i8* %l5
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  %t28 = load i8, i8* %l5
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
  %t30 = load i8, i8* %l5
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = load i8*, i8** %l1
  %t33 = load i8, i8* %l5
  %t34 = load double, double* %l2
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l2
  br label %loop.latch2
loop.latch2:
  %t37 = load i8*, i8** %l1
  %t38 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t41 = load i8*, i8** %l1
  %t42 = call i8* @trim_text(i8* %t41)
  store i8* %t42, i8** %l6
  %t43 = load i8*, i8** %l6
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t44
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
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  ret { i8**, i64 }* null
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
  %l4 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 -1 to double
  store double %t5, double* %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t60 = phi { i8**, i64 }* [ %t7, %entry ], [ %t57, %loop.latch2 ]
  %t61 = phi double [ %t8, %entry ], [ %t58, %loop.latch2 ]
  %t62 = phi double [ %t9, %entry ], [ %t59, %loop.latch2 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  store double %t61, double* %l1
  store double %t62, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t17 = load i8, i8* %l3
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  store double 0.0, double* %l4
  %t19 = load double, double* %l4
  %t20 = fcmp one double %t19, 0.0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = load double, double* %l2
  %t24 = load i8, i8* %l3
  %t25 = load double, double* %l4
  br i1 %t20, label %then4, label %else5
then4:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 0 to double
  %t28 = fcmp oge double %t26, %t27
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load i8, i8* %l3
  %t33 = load double, double* %l4
  br i1 %t28, label %then7, label %merge8
then7:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l2
  %t37 = call double @substring(i8* %value, double %t35, double %t36)
  %t38 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t34, i8* null)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = sitofp i64 -1 to double
  store double %t39, double* %l1
  br label %merge8
merge8:
  %t40 = phi { i8**, i64 }* [ %t38, %then7 ], [ %t29, %then4 ]
  %t41 = phi double [ %t39, %then7 ], [ %t30, %then4 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
  br label %merge6
else5:
  %t42 = load double, double* %l1
  %t43 = sitofp i64 0 to double
  %t44 = fcmp olt double %t42, %t43
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l2
  %t48 = load i8, i8* %l3
  %t49 = load double, double* %l4
  br i1 %t44, label %then9, label %merge10
then9:
  %t50 = load double, double* %l2
  store double %t50, double* %l1
  br label %merge10
merge10:
  %t51 = phi double [ %t50, %then9 ], [ %t46, %else5 ]
  store double %t51, double* %l1
  br label %merge6
merge6:
  %t52 = phi { i8**, i64 }* [ %t38, %then4 ], [ %t21, %else5 ]
  %t53 = phi double [ %t39, %then4 ], [ %t50, %else5 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  store double %t53, double* %l1
  %t54 = load double, double* %l2
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l2
  br label %loop.latch2
loop.latch2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t63 = load double, double* %l1
  %t64 = sitofp i64 0 to double
  %t65 = fcmp oge double %t63, %t64
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = load double, double* %l2
  br i1 %t65, label %then11, label %merge12
then11:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l1
  br label %merge12
merge12:
  %t71 = phi { i8**, i64 }* [ null, %then11 ], [ %t66, %entry ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t72
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
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call double @char_code(i8* %s2)
  store double %t3, double* %l1
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = call double @char_code(i8* %s4)
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  %t12 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t52 = phi double [ %t12, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t11, %entry ], [ %t51, %loop.latch2 ]
  store double %t52, double* %l4
  store double %t53, double* %l3
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l3
  %t17 = getelementptr i8, i8* %t15, i64 %t16
  %t18 = load i8, i8* %t17
  store i8 %t18, i8* %l5
  %t19 = load i8, i8* %l5
  %t20 = call double @char_code(i8 %t19)
  store double %t20, double* %l6
  %t22 = load double, double* %l6
  %t23 = load double, double* %l1
  %t24 = fcmp olt double %t22, %t23
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load double, double* %l6
  %t26 = load double, double* %l2
  %t27 = fcmp ogt double %t25, %t26
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t28 = phi i1 [ true, %logical_or_entry_21 ], [ %t27, %logical_or_right_end_21 ]
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load double, double* %l4
  %t34 = load i8, i8* %l5
  %t35 = load double, double* %l6
  br i1 %t28, label %then4, label %merge5
then4:
  %t36 = insertvalue %NumberParseResult undef, i1 0, 0
  %t37 = sitofp i64 0 to double
  %t38 = insertvalue %NumberParseResult %t36, double %t37, 1
  ret %NumberParseResult %t38
merge5:
  %t39 = load double, double* %l6
  %t40 = load double, double* %l1
  %t41 = fsub double %t39, %t40
  store double %t41, double* %l7
  %t42 = load double, double* %l4
  %t43 = sitofp i64 10 to double
  %t44 = fmul double %t42, %t43
  %t45 = load double, double* %l7
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l4
  %t47 = load double, double* %l3
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l3
  br label %loop.latch2
loop.latch2:
  %t50 = load double, double* %l4
  %t51 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t54 = insertvalue %NumberParseResult undef, i1 1, 0
  %t55 = load double, double* %l4
  %t56 = insertvalue %NumberParseResult %t54, double %t55, 1
  ret %NumberParseResult %t56
}

define { i8**, i64 }* @split_lines(i8* %value) {
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
  %t20 = phi double [ %t9, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l2
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l2
  br label %loop.latch2
loop.latch2:
  %t19 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t21, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t24
}

define { i8**, i64 }* @split_comma_separated(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
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
  %t20 = phi double [ %t9, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l2
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l2
  br label %loop.latch2
loop.latch2:
  %t19 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t21 = load i8*, i8** %l1
  %t22 = alloca [0 x double]
  %t23 = getelementptr [0 x double], [0 x double]* %t22, i32 0, i32 0
  %t24 = alloca { double*, i64 }
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 0
  store double* %t23, double** %t25
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l2
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header4
loop.header4:
  %t55 = phi double [ %t30, %entry ], [ %t54, %loop.latch6 ]
  store double %t55, double* %l2
  br label %loop.body5
loop.body5:
  %t32 = load double, double* %l2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t35 = extractvalue { i8**, i64 } %t34, 1
  %t36 = sitofp i64 %t35 to double
  %t37 = fcmp oge double %t32, %t36
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l2
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t37, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l2
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t45 = extractvalue { i8**, i64 } %t44, 0
  %t46 = extractvalue { i8**, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  %t48 = getelementptr i8*, i8** %t45, i64 %t43
  %t49 = load i8*, i8** %t48
  store i8* %t49, i8** %l5
  %t50 = load i8*, i8** %l5
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  br label %loop.latch6
loop.latch6:
  %t54 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t56
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
  %t27 = phi i8* [ %t3, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t5, %entry ], [ %t26, %loop.latch2 ]
  store i8* %t27, i8** %l0
  store double %t28, double* %l2
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
  br label %merge5
merge5:
  %t21 = phi i8* [ null, %then4 ], [ %t15, %loop.body1 ]
  store i8* %t21, i8** %l0
  %t22 = load double, double* %l2
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l2
  br label %loop.latch2
loop.latch2:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l0
  %t30 = call i8* @trim_text(i8* %t29)
  ret i8* %t30
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { %NativeStruct*, i64 }* null, { %NativeStruct*, i64 }** %l2
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %NativeEnum*, i64 }* null, { %NativeEnum*, i64 }** %l3
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t20 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t21 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t486 = phi double [ %t21, %entry ], [ %t482, %loop.latch2 ]
  %t487 = phi { i8**, i64 }* [ %t18, %entry ], [ %t483, %loop.latch2 ]
  %t488 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t484, %loop.latch2 ]
  %t489 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t485, %loop.latch2 ]
  store double %t486, double* %l4
  store { i8**, i64 }* %t487, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t488, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t489, { %NativeEnum*, i64 }** %l3
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
  %s45 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i1 @starts_with(i8* %t44, i8* %s45)
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
  %s58 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.58, i32 0, i32 0
  %t59 = call i1 @starts_with(i8* %t57, i8* %s58)
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t63 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t64 = load double, double* %l4
  %t65 = load i8*, i8** %l5
  %t66 = load i8*, i8** %l6
  br i1 %t59, label %then8, label %merge9
then8:
  %t67 = load double, double* %l4
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l4
  br label %loop.latch2
merge9:
  %t70 = load i8*, i8** %l6
  %s71 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.71, i32 0, i32 0
  %t72 = call i1 @starts_with(i8* %t70, i8* %s71)
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t76 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t77 = load double, double* %l4
  %t78 = load i8*, i8** %l5
  %t79 = load i8*, i8** %l6
  br i1 %t72, label %then10, label %merge11
then10:
  %t80 = load i8*, i8** %l6
  %s81 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.81, i32 0, i32 0
  %t82 = call i8* @strip_prefix(i8* %t80, i8* %s81)
  store i8* %t82, i8** %l7
  %t83 = load i8*, i8** %l7
  %s84 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.84, i32 0, i32 0
  %t85 = call i8* @strip_prefix(i8* %t83, i8* %s84)
  store i8* %t85, i8** %l8
  %t86 = load i8*, i8** %l8
  %t87 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t86)
  store %StructLayoutHeaderParse %t87, %StructLayoutHeaderParse* %l9
  %t88 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t89 = extractvalue %StructLayoutHeaderParse %t88, 4
  %t90 = call double @diagnosticsconcat({ i8**, i64 }* %t89)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t103 = alloca [0 x double]
  %t104 = getelementptr [0 x double], [0 x double]* %t103, i32 0, i32 0
  %t105 = alloca { double*, i64 }
  %t106 = getelementptr { double*, i64 }, { double*, i64 }* %t105, i32 0, i32 0
  store double* %t104, double** %t106
  %t107 = getelementptr { double*, i64 }, { double*, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { %NativeStructLayoutField*, i64 }* null, { %NativeStructLayoutField*, i64 }** %l10
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
  %t212 = phi i8* [ %t120, %then12 ], [ %t208, %loop.latch16 ]
  %t213 = phi { i8**, i64 }* [ %t114, %then12 ], [ %t209, %loop.latch16 ]
  %t214 = phi { %NativeStructLayoutField*, i64 }* [ %t123, %then12 ], [ %t210, %loop.latch16 ]
  %t215 = phi double [ %t117, %then12 ], [ %t211, %loop.latch16 ]
  store i8* %t212, i8** %l7
  store { i8**, i64 }* %t213, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t214, { %NativeStructLayoutField*, i64 }** %l10
  store double %t215, double* %l4
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
  %t179 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t180 = extractvalue %StructLayoutFieldParse %t179, 2
  %t181 = call double @diagnosticsconcat({ i8**, i64 }* %t180)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t182 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t183 = extractvalue %StructLayoutFieldParse %t182, 0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t187 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t188 = load double, double* %l4
  %t189 = load i8*, i8** %l5
  %t190 = load i8*, i8** %l6
  %t191 = load i8*, i8** %l7
  %t192 = load i8*, i8** %l8
  %t193 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t194 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t195 = load i8*, i8** %l11
  %t196 = load i8*, i8** %l12
  %t197 = load i8*, i8** %l13
  %t198 = load i8*, i8** %l14
  %t199 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t183, label %then22, label %merge23
then22:
  %t200 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t201 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t202 = extractvalue %StructLayoutFieldParse %t201, 1
  %t203 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t200, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t203, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge23
merge23:
  %t204 = phi { %NativeStructLayoutField*, i64 }* [ %t203, %then22 ], [ %t194, %loop.body15 ]
  store { %NativeStructLayoutField*, i64 }* %t204, { %NativeStructLayoutField*, i64 }** %l10
  %t205 = load double, double* %l4
  %t206 = sitofp i64 1 to double
  %t207 = fadd double %t205, %t206
  store double %t207, double* %l4
  br label %loop.latch16
loop.latch16:
  %t208 = load i8*, i8** %l7
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t210 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t211 = load double, double* %l4
  br label %loop.header14
afterloop17:
  store double 0.0, double* %l16
  %t216 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t217 = load double, double* %l16
  %t218 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t216, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t218, { %NativeStruct*, i64 }** %l2
  br label %merge13
merge13:
  %t219 = phi double [ %t112, %then12 ], [ %t97, %then10 ]
  %t220 = phi i8* [ %t172, %then12 ], [ %t100, %then10 ]
  %t221 = phi { i8**, i64 }* [ null, %then12 ], [ %t94, %then10 ]
  %t222 = phi double [ %t207, %then12 ], [ %t97, %then10 ]
  %t223 = phi { %NativeStruct*, i64 }* [ %t218, %then12 ], [ %t95, %then10 ]
  store double %t219, double* %l4
  store i8* %t220, i8** %l7
  store { i8**, i64 }* %t221, { i8**, i64 }** %l1
  store double %t222, double* %l4
  store { %NativeStruct*, i64 }* %t223, { %NativeStruct*, i64 }** %l2
  %t224 = load double, double* %l4
  %t225 = sitofp i64 1 to double
  %t226 = fadd double %t224, %t225
  store double %t226, double* %l4
  br label %loop.latch2
merge11:
  %t227 = load i8*, i8** %l6
  %s228 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.228, i32 0, i32 0
  %t229 = call i1 @starts_with(i8* %t227, i8* %s228)
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t233 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t234 = load double, double* %l4
  %t235 = load i8*, i8** %l5
  %t236 = load i8*, i8** %l6
  br i1 %t229, label %then24, label %merge25
then24:
  %t237 = load i8*, i8** %l6
  %s238 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.238, i32 0, i32 0
  %t239 = call i8* @strip_prefix(i8* %t237, i8* %s238)
  store i8* %t239, i8** %l17
  %t240 = load i8*, i8** %l17
  %s241 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.241, i32 0, i32 0
  %t242 = call i8* @strip_prefix(i8* %t240, i8* %s241)
  store i8* %t242, i8** %l18
  %t243 = load i8*, i8** %l18
  %t244 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t243)
  store %EnumLayoutHeaderParse %t244, %EnumLayoutHeaderParse* %l19
  %t245 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t246 = extractvalue %EnumLayoutHeaderParse %t245, 7
  %t247 = call double @diagnosticsconcat({ i8**, i64 }* %t246)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t248 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t249 = extractvalue %EnumLayoutHeaderParse %t248, 0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t252 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t253 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t254 = load double, double* %l4
  %t255 = load i8*, i8** %l5
  %t256 = load i8*, i8** %l6
  %t257 = load i8*, i8** %l17
  %t258 = load i8*, i8** %l18
  %t259 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t249, label %then26, label %else27
then26:
  %t260 = alloca [0 x double]
  %t261 = getelementptr [0 x double], [0 x double]* %t260, i32 0, i32 0
  %t262 = alloca { double*, i64 }
  %t263 = getelementptr { double*, i64 }, { double*, i64 }* %t262, i32 0, i32 0
  store double* %t261, double** %t263
  %t264 = getelementptr { double*, i64 }, { double*, i64 }* %t262, i32 0, i32 1
  store i64 0, i64* %t264
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l20
  %t265 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t266 = extractvalue %EnumLayoutHeaderParse %t265, 1
  store i8* %t266, i8** %l21
  %t267 = load double, double* %l4
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  store double %t269, double* %l4
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t272 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t273 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t274 = load double, double* %l4
  %t275 = load i8*, i8** %l5
  %t276 = load i8*, i8** %l6
  %t277 = load i8*, i8** %l17
  %t278 = load i8*, i8** %l18
  %t279 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t280 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t281 = load i8*, i8** %l21
  br label %loop.header29
loop.header29:
  %t465 = phi i8* [ %t277, %then26 ], [ %t461, %loop.latch31 ]
  %t466 = phi { i8**, i64 }* [ %t271, %then26 ], [ %t462, %loop.latch31 ]
  %t467 = phi { %NativeEnumVariantLayout*, i64 }* [ %t280, %then26 ], [ %t463, %loop.latch31 ]
  %t468 = phi double [ %t274, %then26 ], [ %t464, %loop.latch31 ]
  store i8* %t465, i8** %l17
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t467, { %NativeEnumVariantLayout*, i64 }** %l20
  store double %t468, double* %l4
  br label %loop.body30
loop.body30:
  %t282 = load double, double* %l4
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t284 = load { i8**, i64 }, { i8**, i64 }* %t283
  %t285 = extractvalue { i8**, i64 } %t284, 1
  %t286 = sitofp i64 %t285 to double
  %t287 = fcmp oge double %t282, %t286
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t290 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t291 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t292 = load double, double* %l4
  %t293 = load i8*, i8** %l5
  %t294 = load i8*, i8** %l6
  %t295 = load i8*, i8** %l17
  %t296 = load i8*, i8** %l18
  %t297 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t298 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t299 = load i8*, i8** %l21
  br i1 %t287, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t301 = load double, double* %l4
  %t302 = load { i8**, i64 }, { i8**, i64 }* %t300
  %t303 = extractvalue { i8**, i64 } %t302, 0
  %t304 = extractvalue { i8**, i64 } %t302, 1
  %t305 = icmp uge i64 %t301, %t304
  ; bounds check: %t305 (if true, out of bounds)
  %t306 = getelementptr i8*, i8** %t303, i64 %t301
  %t307 = load i8*, i8** %t306
  %t308 = call i8* @trim_text(i8* %t307)
  store i8* %t308, i8** %l22
  %t309 = load i8*, i8** %l22
  %t311 = load i8*, i8** %l22
  %s312 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.312, i32 0, i32 0
  %t313 = call i1 @starts_with(i8* %t311, i8* %s312)
  br label %logical_and_entry_310

logical_and_entry_310:
  br i1 %t313, label %logical_and_right_310, label %logical_and_merge_310

logical_and_right_310:
  %t314 = load i8*, i8** %l22
  %s315 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.315, i32 0, i32 0
  %t316 = call i1 @starts_with(i8* %t314, i8* %s315)
  %t317 = xor i1 %t316, 1
  br label %logical_and_right_end_310

logical_and_right_end_310:
  br label %logical_and_merge_310

logical_and_merge_310:
  %t318 = phi i1 [ false, %logical_and_entry_310 ], [ %t317, %logical_and_right_end_310 ]
  %t319 = xor i1 %t318, 1
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t322 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t323 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t324 = load double, double* %l4
  %t325 = load i8*, i8** %l5
  %t326 = load i8*, i8** %l6
  %t327 = load i8*, i8** %l17
  %t328 = load i8*, i8** %l18
  %t329 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t330 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t331 = load i8*, i8** %l21
  %t332 = load i8*, i8** %l22
  br i1 %t319, label %then35, label %merge36
then35:
  br label %afterloop32
merge36:
  %t333 = load i8*, i8** %l22
  %s334 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.334, i32 0, i32 0
  %t335 = call i1 @starts_with(i8* %t333, i8* %s334)
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t338 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t339 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t340 = load double, double* %l4
  %t341 = load i8*, i8** %l5
  %t342 = load i8*, i8** %l6
  %t343 = load i8*, i8** %l17
  %t344 = load i8*, i8** %l18
  %t345 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t346 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t347 = load i8*, i8** %l21
  %t348 = load i8*, i8** %l22
  br i1 %t335, label %then37, label %else38
then37:
  %t349 = load i8*, i8** %l22
  %s350 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.350, i32 0, i32 0
  %t351 = call i8* @strip_prefix(i8* %t349, i8* %s350)
  store i8* %t351, i8** %l23
  %t352 = load i8*, i8** %l17
  %s353 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.353, i32 0, i32 0
  %t354 = call i8* @strip_prefix(i8* %t352, i8* %s353)
  store i8* %t354, i8** %l24
  %t355 = load i8*, i8** %l24
  %t356 = load i8*, i8** %l21
  %t357 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t355, i8* %t356)
  store %EnumLayoutVariantParse %t357, %EnumLayoutVariantParse* %l25
  %t358 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t359 = extractvalue %EnumLayoutVariantParse %t358, 2
  %t360 = call double @diagnosticsconcat({ i8**, i64 }* %t359)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t361 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t362 = extractvalue %EnumLayoutVariantParse %t361, 0
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t365 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t366 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t367 = load double, double* %l4
  %t368 = load i8*, i8** %l5
  %t369 = load i8*, i8** %l6
  %t370 = load i8*, i8** %l17
  %t371 = load i8*, i8** %l18
  %t372 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t373 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t374 = load i8*, i8** %l21
  %t375 = load i8*, i8** %l22
  %t376 = load i8*, i8** %l23
  %t377 = load i8*, i8** %l24
  %t378 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t362, label %then40, label %merge41
then40:
  %t379 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t380 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t381 = extractvalue %EnumLayoutVariantParse %t380, 1
  %t382 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t379, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t382, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge41
merge41:
  %t383 = phi { %NativeEnumVariantLayout*, i64 }* [ %t382, %then40 ], [ %t373, %then37 ]
  store { %NativeEnumVariantLayout*, i64 }* %t383, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge39
else38:
  %t384 = load i8*, i8** %l22
  %s385 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.385, i32 0, i32 0
  %t386 = call i1 @starts_with(i8* %t384, i8* %s385)
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t389 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t390 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t391 = load double, double* %l4
  %t392 = load i8*, i8** %l5
  %t393 = load i8*, i8** %l6
  %t394 = load i8*, i8** %l17
  %t395 = load i8*, i8** %l18
  %t396 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t397 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t398 = load i8*, i8** %l21
  %t399 = load i8*, i8** %l22
  br i1 %t386, label %then42, label %merge43
then42:
  %t400 = load i8*, i8** %l22
  %s401 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.401, i32 0, i32 0
  %t402 = call i8* @strip_prefix(i8* %t400, i8* %s401)
  store i8* %t402, i8** %l26
  %t403 = load i8*, i8** %l17
  %s404 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.404, i32 0, i32 0
  %t405 = call i8* @strip_prefix(i8* %t403, i8* %s404)
  store i8* %t405, i8** %l27
  %t406 = load i8*, i8** %l27
  %t407 = load i8*, i8** %l21
  %t408 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t406, i8* %t407)
  store %EnumLayoutPayloadParse %t408, %EnumLayoutPayloadParse* %l28
  %t409 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t410 = extractvalue %EnumLayoutPayloadParse %t409, 3
  %t411 = call double @diagnosticsconcat({ i8**, i64 }* %t410)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t413 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t414 = extractvalue %EnumLayoutPayloadParse %t413, 0
  br label %logical_and_entry_412

logical_and_entry_412:
  br i1 %t414, label %logical_and_right_412, label %logical_and_merge_412

logical_and_right_412:
  %t415 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t416 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t415
  %t417 = extractvalue { %NativeEnumVariantLayout*, i64 } %t416, 1
  %t418 = icmp sgt i64 %t417, 0
  br label %logical_and_right_end_412

logical_and_right_end_412:
  br label %logical_and_merge_412

logical_and_merge_412:
  %t419 = phi i1 [ false, %logical_and_entry_412 ], [ %t418, %logical_and_right_end_412 ]
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
  %t433 = load i8*, i8** %l26
  %t434 = load i8*, i8** %l27
  %t435 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t419, label %then44, label %merge45
then44:
  %t436 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t437 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t436
  %t438 = extractvalue { %NativeEnumVariantLayout*, i64 } %t437, 1
  %t439 = sub i64 %t438, 1
  store i64 %t439, i64* %l29
  %t440 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t441 = load i64, i64* %l29
  %t442 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t440
  %t443 = extractvalue { %NativeEnumVariantLayout*, i64 } %t442, 0
  %t444 = extractvalue { %NativeEnumVariantLayout*, i64 } %t442, 1
  %t445 = icmp uge i64 %t441, %t444
  ; bounds check: %t445 (if true, out of bounds)
  %t446 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t443, i64 %t441
  %t447 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t446
  store %NativeEnumVariantLayout %t447, %NativeEnumVariantLayout* %l30
  %t448 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t449 = extractvalue %NativeEnumVariantLayout %t448, 5
  %t450 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t451 = extractvalue %EnumLayoutPayloadParse %t450, 2
  %t452 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* null, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t452, { %NativeStructLayoutField*, i64 }** %l31
  br label %merge45
merge45:
  br label %merge43
merge43:
  %t453 = phi i8* [ %t402, %then42 ], [ %t394, %else38 ]
  %t454 = phi { i8**, i64 }* [ null, %then42 ], [ %t388, %else38 ]
  store i8* %t453, i8** %l17
  store { i8**, i64 }* %t454, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t455 = phi i8* [ %t351, %then37 ], [ %t402, %else38 ]
  %t456 = phi { i8**, i64 }* [ null, %then37 ], [ null, %else38 ]
  %t457 = phi { %NativeEnumVariantLayout*, i64 }* [ %t382, %then37 ], [ %t346, %else38 ]
  store i8* %t455, i8** %l17
  store { i8**, i64 }* %t456, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t457, { %NativeEnumVariantLayout*, i64 }** %l20
  %t458 = load double, double* %l4
  %t459 = sitofp i64 1 to double
  %t460 = fadd double %t458, %t459
  store double %t460, double* %l4
  br label %loop.latch31
loop.latch31:
  %t461 = load i8*, i8** %l17
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t463 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t464 = load double, double* %l4
  br label %loop.header29
afterloop32:
  store double 0.0, double* %l32
  %t469 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t470 = load double, double* %l32
  %t471 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t469, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t471, { %NativeEnum*, i64 }** %l3
  br label %merge28
else27:
  %t472 = load double, double* %l4
  %t473 = sitofp i64 1 to double
  %t474 = fadd double %t472, %t473
  store double %t474, double* %l4
  br label %merge28
merge28:
  %t475 = phi double [ %t269, %then26 ], [ %t474, %else27 ]
  %t476 = phi i8* [ %t351, %then26 ], [ %t257, %else27 ]
  %t477 = phi { i8**, i64 }* [ null, %then26 ], [ %t251, %else27 ]
  %t478 = phi { %NativeEnum*, i64 }* [ %t471, %then26 ], [ %t253, %else27 ]
  store double %t475, double* %l4
  store i8* %t476, i8** %l17
  store { i8**, i64 }* %t477, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t478, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge25:
  %t479 = load double, double* %l4
  %t480 = sitofp i64 1 to double
  %t481 = fadd double %t479, %t480
  store double %t481, double* %l4
  br label %loop.latch2
loop.latch2:
  %t482 = load double, double* %l4
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t484 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t485 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t490 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t491 = insertvalue %LayoutManifest undef, { i8**, i64 }* null, 0
  %t492 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t493 = insertvalue %LayoutManifest %t491, { i8**, i64 }* null, 1
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t495 = insertvalue %LayoutManifest %t493, { i8**, i64 }* %t494, 2
  ret %LayoutManifest %t495
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
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t32 = phi { i8**, i64 }* [ %t7, %entry ], [ %t29, %loop.latch2 ]
  %t33 = phi double [ %t8, %entry ], [ %t30, %loop.latch2 ]
  %t34 = phi double [ %t9, %entry ], [ %t31, %loop.latch2 ]
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  store double %t33, double* %l1
  store double %t34, double* %l2
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
  %t25 = call double @substring(i8* %value, double %t23, double %t24)
  %t26 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t22, i8* null)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  %t27 = load double, double* %l4
  %t28 = load double, double* %l1
  store double %t28, double* %l2
  br label %loop.latch2
loop.latch2:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t35 = load double, double* %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t36
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
