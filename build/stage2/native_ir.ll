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
@.str.28 = private unnamed_addr constant [2 x i8] c".\00"
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
  %l20 = alloca %InstructionParseResult
  %l21 = alloca { i8**, i64 }*
  %l22 = alloca double
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
  %t437 = phi double [ %t48, %entry ], [ %t432, %loop.latch2 ]
  %t438 = phi { i8**, i64 }* [ %t38, %entry ], [ %t433, %loop.latch2 ]
  %t439 = phi i8* [ %t45, %entry ], [ %t434, %loop.latch2 ]
  %t440 = phi i8* [ %t46, %entry ], [ %t435, %loop.latch2 ]
  %t441 = phi i8* [ %t47, %entry ], [ %t436, %loop.latch2 ]
  store double %t437, double* %l11
  store { i8**, i64 }* %t438, { i8**, i64 }** %l1
  store i8* %t439, i8** %l8
  store i8* %t440, i8** %l9
  store i8* %t441, i8** %l10
  br label %loop.body1
loop.body1:
  %t49 = load double, double* %l11
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l11
  %t53 = load { i8**, i64 }, { i8**, i64 }* %t51
  %t54 = extractvalue { i8**, i64 } %t53, 0
  %t55 = extractvalue { i8**, i64 } %t53, 1
  %t56 = icmp uge i64 %t52, %t55
  ; bounds check: %t56 (if true, out of bounds)
  %t57 = getelementptr i8*, i8** %t54, i64 %t52
  %t58 = load i8*, i8** %t57
  store i8* %t58, i8** %l12
  %t59 = load i8*, i8** %l12
  %t60 = call i8* @trim_text(i8* %t59)
  store i8* %t60, i8** %l13
  %t61 = load i8*, i8** %l13
  %t62 = load i8*, i8** %l13
  %s63 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.63, i32 0, i32 0
  %t64 = call i1 @starts_with(i8* %t62, i8* %s63)
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t68 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t69 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t70 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t71 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t72 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t73 = load i8*, i8** %l8
  %t74 = load i8*, i8** %l9
  %t75 = load i8*, i8** %l10
  %t76 = load double, double* %l11
  %t77 = load i8*, i8** %l12
  %t78 = load i8*, i8** %l13
  br i1 %t64, label %then4, label %merge5
then4:
  %t79 = load double, double* %l11
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l11
  br label %loop.latch2
merge5:
  %t82 = load i8*, i8** %l13
  %s83 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.83, i32 0, i32 0
  %t84 = call i1 @starts_with(i8* %t82, i8* %s83)
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t88 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t89 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t90 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t91 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t92 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t93 = load i8*, i8** %l8
  %t94 = load i8*, i8** %l9
  %t95 = load i8*, i8** %l10
  %t96 = load double, double* %l11
  %t97 = load i8*, i8** %l12
  %t98 = load i8*, i8** %l13
  br i1 %t84, label %then6, label %merge7
then6:
  %t99 = load double, double* %l11
  %t100 = sitofp i64 1 to double
  %t101 = fadd double %t99, %t100
  store double %t101, double* %l11
  br label %loop.latch2
merge7:
  %t102 = load i8*, i8** %l13
  %s103 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.103, i32 0, i32 0
  %t104 = call i1 @starts_with(i8* %t102, i8* %s103)
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t108 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t109 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t110 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t111 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t112 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t113 = load i8*, i8** %l8
  %t114 = load i8*, i8** %l9
  %t115 = load i8*, i8** %l10
  %t116 = load double, double* %l11
  %t117 = load i8*, i8** %l12
  %t118 = load i8*, i8** %l13
  br i1 %t104, label %then8, label %merge9
then8:
  %s119 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.119, i32 0, i32 0
  %t120 = load i8*, i8** %l13
  %s121 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.121, i32 0, i32 0
  %t122 = call i8* @strip_prefix(i8* %t120, i8* %s121)
  %t123 = call double @parse_import_entry(i8* %s119, i8* %t122)
  store double %t123, double* %l14
  %t124 = load double, double* %l14
  %t125 = load double, double* %l11
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l11
  br label %loop.latch2
merge9:
  %t128 = load i8*, i8** %l13
  %s129 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.129, i32 0, i32 0
  %t130 = call i1 @starts_with(i8* %t128, i8* %s129)
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t134 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t135 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t136 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t137 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t138 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t139 = load i8*, i8** %l8
  %t140 = load i8*, i8** %l9
  %t141 = load i8*, i8** %l10
  %t142 = load double, double* %l11
  %t143 = load i8*, i8** %l12
  %t144 = load i8*, i8** %l13
  br i1 %t130, label %then10, label %merge11
then10:
  %s145 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.145, i32 0, i32 0
  %t146 = load i8*, i8** %l13
  %s147 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.147, i32 0, i32 0
  %t148 = call i8* @strip_prefix(i8* %t146, i8* %s147)
  %t149 = call double @parse_import_entry(i8* %s145, i8* %t148)
  store double %t149, double* %l15
  %t150 = load double, double* %l15
  %t151 = load double, double* %l11
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l11
  br label %loop.latch2
merge11:
  %t154 = load i8*, i8** %l13
  %s155 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.155, i32 0, i32 0
  %t156 = call i1 @starts_with(i8* %t154, i8* %s155)
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t160 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t161 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t162 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t163 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t164 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t165 = load i8*, i8** %l8
  %t166 = load i8*, i8** %l9
  %t167 = load i8*, i8** %l10
  %t168 = load double, double* %l11
  %t169 = load i8*, i8** %l12
  %t170 = load i8*, i8** %l13
  br i1 %t156, label %then12, label %merge13
then12:
  %t171 = load i8*, i8** %l13
  %s172 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.172, i32 0, i32 0
  %t173 = call i8* @strip_prefix(i8* %t171, i8* %s172)
  %t174 = call double @parse_source_span(i8* %t173)
  store double %t174, double* %l16
  %t175 = load double, double* %l16
  %t176 = load double, double* %l11
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l11
  br label %loop.latch2
merge13:
  %t179 = load i8*, i8** %l13
  %t180 = load i8*, i8** %l13
  %s181 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.181, i32 0, i32 0
  %t182 = call i1 @starts_with(i8* %t180, i8* %s181)
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t186 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t187 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t188 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t189 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t190 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t191 = load i8*, i8** %l8
  %t192 = load i8*, i8** %l9
  %t193 = load i8*, i8** %l10
  %t194 = load double, double* %l11
  %t195 = load i8*, i8** %l12
  %t196 = load i8*, i8** %l13
  br i1 %t182, label %then14, label %merge15
then14:
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load double, double* %l11
  %t199 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t197, double %t198)
  store %StructParseResult %t199, %StructParseResult* %l17
  %t200 = load %StructParseResult, %StructParseResult* %l17
  %t201 = extractvalue %StructParseResult %t200, 2
  %t202 = call double @diagnosticsconcat({ i8**, i64 }* %t201)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t203 = load %StructParseResult, %StructParseResult* %l17
  %t204 = extractvalue %StructParseResult %t203, 0
  %t205 = load %StructParseResult, %StructParseResult* %l17
  %t206 = extractvalue %StructParseResult %t205, 1
  store double %t206, double* %l11
  br label %loop.latch2
merge15:
  %t207 = load i8*, i8** %l13
  %s208 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.208, i32 0, i32 0
  %t209 = call i1 @starts_with(i8* %t207, i8* %s208)
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t212 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t213 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t214 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t215 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t216 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t217 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t218 = load i8*, i8** %l8
  %t219 = load i8*, i8** %l9
  %t220 = load i8*, i8** %l10
  %t221 = load double, double* %l11
  %t222 = load i8*, i8** %l12
  %t223 = load i8*, i8** %l13
  br i1 %t209, label %then16, label %merge17
then16:
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load double, double* %l11
  %t226 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t224, double %t225)
  store %InterfaceParseResult %t226, %InterfaceParseResult* %l18
  %t227 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t228 = extractvalue %InterfaceParseResult %t227, 2
  %t229 = call double @diagnosticsconcat({ i8**, i64 }* %t228)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t230 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t231 = extractvalue %InterfaceParseResult %t230, 0
  %t232 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t233 = extractvalue %InterfaceParseResult %t232, 1
  store double %t233, double* %l11
  br label %loop.latch2
merge17:
  %t234 = load i8*, i8** %l13
  %s235 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.235, i32 0, i32 0
  %t236 = call i1 @starts_with(i8* %t234, i8* %s235)
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t239 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t240 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t241 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t242 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t243 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t244 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t245 = load i8*, i8** %l8
  %t246 = load i8*, i8** %l9
  %t247 = load i8*, i8** %l10
  %t248 = load double, double* %l11
  %t249 = load i8*, i8** %l12
  %t250 = load i8*, i8** %l13
  br i1 %t236, label %then18, label %merge19
then18:
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load double, double* %l11
  %t253 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t251, double %t252)
  store %EnumParseResult %t253, %EnumParseResult* %l19
  %t254 = load %EnumParseResult, %EnumParseResult* %l19
  %t255 = extractvalue %EnumParseResult %t254, 2
  %t256 = call double @diagnosticsconcat({ i8**, i64 }* %t255)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t257 = load %EnumParseResult, %EnumParseResult* %l19
  %t258 = extractvalue %EnumParseResult %t257, 0
  %t259 = load %EnumParseResult, %EnumParseResult* %l19
  %t260 = extractvalue %EnumParseResult %t259, 1
  store double %t260, double* %l11
  br label %loop.latch2
merge19:
  %t261 = load i8*, i8** %l13
  %s262 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.262, i32 0, i32 0
  %t263 = call i1 @starts_with(i8* %t261, i8* %s262)
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t266 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t267 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t268 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t269 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t270 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t271 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t272 = load i8*, i8** %l8
  %t273 = load i8*, i8** %l9
  %t274 = load i8*, i8** %l10
  %t275 = load double, double* %l11
  %t276 = load i8*, i8** %l12
  %t277 = load i8*, i8** %l13
  br i1 %t263, label %then20, label %merge21
then20:
  %t278 = load i8*, i8** %l8
  %t279 = load double, double* %l11
  %t280 = sitofp i64 1 to double
  %t281 = fadd double %t279, %t280
  store double %t281, double* %l11
  br label %loop.latch2
merge21:
  %t282 = load i8*, i8** %l13
  %s283 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.283, i32 0, i32 0
  %t284 = call i1 @starts_with(i8* %t282, i8* %s283)
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t287 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t288 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t289 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t290 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t291 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t292 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t293 = load i8*, i8** %l8
  %t294 = load i8*, i8** %l9
  %t295 = load i8*, i8** %l10
  %t296 = load double, double* %l11
  %t297 = load i8*, i8** %l12
  %t298 = load i8*, i8** %l13
  br i1 %t284, label %then22, label %merge23
then22:
  %t299 = load i8*, i8** %l8
  %t300 = load double, double* %l11
  %t301 = sitofp i64 1 to double
  %t302 = fadd double %t300, %t301
  store double %t302, double* %l11
  br label %loop.latch2
merge23:
  %t303 = load i8*, i8** %l13
  %s304 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.304, i32 0, i32 0
  %t305 = call i1 @starts_with(i8* %t303, i8* %s304)
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t308 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t309 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t310 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t311 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t312 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t313 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t314 = load i8*, i8** %l8
  %t315 = load i8*, i8** %l9
  %t316 = load i8*, i8** %l10
  %t317 = load double, double* %l11
  %t318 = load i8*, i8** %l12
  %t319 = load i8*, i8** %l13
  br i1 %t305, label %then24, label %merge25
then24:
  %t320 = load i8*, i8** %l8
  %t321 = load double, double* %l11
  %t322 = sitofp i64 1 to double
  %t323 = fadd double %t321, %t322
  store double %t323, double* %l11
  br label %loop.latch2
merge25:
  %t324 = load i8*, i8** %l13
  %s325 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.325, i32 0, i32 0
  %t326 = call i1 @starts_with(i8* %t324, i8* %s325)
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t329 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t330 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t331 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t332 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t333 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t334 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t335 = load i8*, i8** %l8
  %t336 = load i8*, i8** %l9
  %t337 = load i8*, i8** %l10
  %t338 = load double, double* %l11
  %t339 = load i8*, i8** %l12
  %t340 = load i8*, i8** %l13
  br i1 %t326, label %then26, label %merge27
then26:
  %t341 = load i8*, i8** %l8
  %t342 = load double, double* %l11
  %t343 = sitofp i64 1 to double
  %t344 = fadd double %t342, %t343
  store double %t344, double* %l11
  br label %loop.latch2
merge27:
  %t345 = load i8*, i8** %l13
  %t346 = load i8*, i8** %l9
  %t347 = load i8*, i8** %l10
  %t348 = call %InstructionParseResult @parse_instruction(i8* %t345, i8* %t346, i8* %t347)
  store %InstructionParseResult %t348, %InstructionParseResult* %l20
  %t349 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t350 = extractvalue %InstructionParseResult %t349, 0
  store { i8**, i64 }* %t350, { i8**, i64 }** %l21
  %t351 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t352 = extractvalue %InstructionParseResult %t351, 1
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t355 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t356 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t357 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t358 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t359 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t360 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t361 = load i8*, i8** %l8
  %t362 = load i8*, i8** %l9
  %t363 = load i8*, i8** %l10
  %t364 = load double, double* %l11
  %t365 = load i8*, i8** %l12
  %t366 = load i8*, i8** %l13
  %t367 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t352, label %then28, label %else29
then28:
  br label %merge30
else29:
  %t369 = load i8*, i8** %l9
  br label %merge30
merge30:
  %t370 = phi i8* [ null, %then28 ], [ %t362, %else29 ]
  store i8* %t370, i8** %l9
  %t371 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t372 = extractvalue %InstructionParseResult %t371, 2
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t375 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t376 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t377 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t378 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t379 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t380 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t381 = load i8*, i8** %l8
  %t382 = load i8*, i8** %l9
  %t383 = load i8*, i8** %l10
  %t384 = load double, double* %l11
  %t385 = load i8*, i8** %l12
  %t386 = load i8*, i8** %l13
  %t387 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t372, label %then31, label %else32
then31:
  br label %merge33
else32:
  %t389 = load i8*, i8** %l10
  br label %merge33
merge33:
  %t390 = phi i8* [ null, %then31 ], [ %t383, %else32 ]
  store i8* %t390, i8** %l10
  %t391 = load i8*, i8** %l8
  %t392 = sitofp i64 0 to double
  store double %t392, double* %l22
  %t393 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t395 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t396 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t397 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t398 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t399 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t400 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t401 = load i8*, i8** %l8
  %t402 = load i8*, i8** %l9
  %t403 = load i8*, i8** %l10
  %t404 = load double, double* %l11
  %t405 = load i8*, i8** %l12
  %t406 = load i8*, i8** %l13
  %t407 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t409 = load double, double* %l22
  br label %loop.header34
loop.header34:
  %t427 = phi i8* [ %t401, %loop.body1 ], [ %t425, %loop.latch36 ]
  %t428 = phi double [ %t409, %loop.body1 ], [ %t426, %loop.latch36 ]
  store i8* %t427, i8** %l8
  store double %t428, double* %l22
  br label %loop.body35
loop.body35:
  %t410 = load double, double* %l22
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t412 = load i8*, i8** %l8
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t414 = load double, double* %l22
  %t415 = load { i8**, i64 }, { i8**, i64 }* %t413
  %t416 = extractvalue { i8**, i64 } %t415, 0
  %t417 = extractvalue { i8**, i64 } %t415, 1
  %t418 = icmp uge i64 %t414, %t417
  ; bounds check: %t418 (if true, out of bounds)
  %t419 = getelementptr i8*, i8** %t416, i64 %t414
  %t420 = load i8*, i8** %t419
  %t421 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t422 = load double, double* %l22
  %t423 = sitofp i64 1 to double
  %t424 = fadd double %t422, %t423
  store double %t424, double* %l22
  br label %loop.latch36
loop.latch36:
  %t425 = load i8*, i8** %l8
  %t426 = load double, double* %l22
  br label %loop.header34
afterloop37:
  %t429 = load double, double* %l11
  %t430 = sitofp i64 1 to double
  %t431 = fadd double %t429, %t430
  store double %t431, double* %l11
  br label %loop.latch2
loop.latch2:
  %t432 = load double, double* %l11
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t434 = load i8*, i8** %l8
  %t435 = load i8*, i8** %l9
  %t436 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t442 = load i8*, i8** %l8
  %t443 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t444 = insertvalue %ParseNativeResult undef, { i8**, i64 }* null, 0
  %t445 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t446 = insertvalue %ParseNativeResult %t444, { i8**, i64 }* null, 1
  %t447 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t448 = insertvalue %ParseNativeResult %t446, { i8**, i64 }* null, 2
  %t449 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t450 = insertvalue %ParseNativeResult %t448, { i8**, i64 }* null, 3
  %t451 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t452 = insertvalue %ParseNativeResult %t450, { i8**, i64 }* null, 4
  %t453 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t454 = insertvalue %ParseNativeResult %t452, { i8**, i64 }* null, 5
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t456 = insertvalue %ParseNativeResult %t454, { i8**, i64 }* %t455, 6
  ret %ParseNativeResult %t456
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
  %t18 = phi double [ %t1, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t5 = extractvalue { %NativeEnumVariantLayout*, i64 } %t4, 0
  %t6 = extractvalue { %NativeEnumVariantLayout*, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t5, i64 %t3
  %t9 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t8
  %t10 = extractvalue %NativeEnumVariantLayout %t9, 0
  %t11 = icmp eq i8* %t10, %name
  %t12 = load double, double* %l0
  br i1 %t11, label %then4, label %merge5
then4:
  %t13 = load double, double* %l0
  ret double %t13
merge5:
  %t14 = load double, double* %l0
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l0
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t19 = sitofp i64 -1 to double
  ret double %t19
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
  %t38 = phi { %NativeEnumVariantLayout*, i64 }* [ %t6, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t7, %entry ], [ %t37, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t38, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = fcmp oeq double %t9, %index
  %t11 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %else5
then4:
  %t13 = load double, double* %l1
  %t14 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t15 = extractvalue { %NativeEnumVariantLayout*, i64 } %t14, 0
  %t16 = extractvalue { %NativeEnumVariantLayout*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t15, i64 %t13
  %t19 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t18
  store %NativeEnumVariantLayout %t19, %NativeEnumVariantLayout* %l2
  store double 0.0, double* %l3
  %t20 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t21 = load double, double* %l3
  %t22 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t20, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t22, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge6
else5:
  %t23 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t26 = extractvalue { %NativeEnumVariantLayout*, i64 } %t25, 0
  %t27 = extractvalue { %NativeEnumVariantLayout*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t26, i64 %t24
  %t30 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t29
  %t31 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t23, %NativeEnumVariantLayout %t30)
  store { %NativeEnumVariantLayout*, i64 }* %t31, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge6
merge6:
  %t32 = phi { %NativeEnumVariantLayout*, i64 }* [ %t22, %then4 ], [ %t31, %else5 ]
  store { %NativeEnumVariantLayout*, i64 }* %t32, { %NativeEnumVariantLayout*, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t40
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
  %t36 = load double, double* %l3
  %t37 = load double, double* %l3
  %t38 = call %NativeInstruction @parse_inline_case_body_instruction(i8* null)
  store %NativeInstruction %t38, %NativeInstruction* %l6
  %t39 = load %NativeInstruction, %NativeInstruction* %l6
  %t40 = alloca [1 x %NativeInstruction]
  %t41 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t40, i32 0, i32 0
  %t42 = getelementptr %NativeInstruction, %NativeInstruction* %t41, i64 0
  store %NativeInstruction %t39, %NativeInstruction* %t42
  %t43 = alloca { %NativeInstruction*, i64 }
  %t44 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t43, i32 0, i32 0
  store %NativeInstruction* %t41, %NativeInstruction** %t44
  %t45 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t43, i32 0, i32 1
  store i64 1, i64* %t45
  %t46 = call double @instructionsconcat({ %NativeInstruction*, i64 }* %t43)
  store { %NativeInstruction*, i64 }* null, { %NativeInstruction*, i64 }** %l5
  %t47 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t47
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
  %t16 = load %NativeInstruction, %NativeInstruction* %t10
  ret %NativeInstruction %t16
merge1:
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.18, i32 0, i32 0
  %t19 = call i1 @starts_with(i8* %t17, i8* %s18)
  %t20 = load i8*, i8** %l0
  br i1 %t19, label %then2, label %merge3
then2:
  %t21 = alloca %NativeInstruction
  %t22 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t21, i32 0, i32 0
  store i32 1, i32* %t22
  %t23 = load i8*, i8** %l0
  %s24 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.24, i32 0, i32 0
  %t25 = call i8* @strip_prefix(i8* %t23, i8* %s24)
  %t26 = call i8* @trim_text(i8* %t25)
  %t27 = call i8* @trim_trailing_delimiters(i8* %t26)
  %t28 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t21, i32 0, i32 1
  %t29 = bitcast [16 x i8]* %t28 to i8*
  %t30 = bitcast i8* %t29 to i8**
  store i8* %t27, i8** %t30
  %t31 = load %NativeInstruction, %NativeInstruction* %t21
  ret %NativeInstruction %t31
merge3:
  %t32 = alloca %NativeInstruction
  %t33 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t32, i32 0, i32 0
  store i32 1, i32* %t33
  %t34 = load i8*, i8** %l0
  %t35 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t32, i32 0, i32 1
  %t36 = bitcast [16 x i8]* %t35 to i8*
  %t37 = bitcast i8* %t36 to i8**
  store i8* %t34, i8** %t37
  %t38 = load %NativeInstruction, %NativeInstruction* %t32
  ret %NativeInstruction %t38
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
  %t31 = phi double [ %t13, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l3
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load double, double* %l3
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  %t24 = call %NativeImportSpecifier @parse_single_specifier(i8* %t23)
  store %NativeImportSpecifier %t24, %NativeImportSpecifier* %l4
  %t25 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t26 = extractvalue %NativeImportSpecifier %t25, 0
  %t27 = load double, double* %l3
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l3
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t32 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t32
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
  %l19 = alloca %StructLayoutHeaderParse
  %l20 = alloca %StructLayoutFieldParse
  %l21 = alloca double
  %l22 = alloca i8*
  %l23 = alloca i8*
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
  %t382 = phi double [ %t61, %entry ], [ %t373, %loop.latch2 ]
  %t383 = phi { i8**, i64 }* [ %t45, %entry ], [ %t374, %loop.latch2 ]
  %t384 = phi double [ %t57, %entry ], [ %t375, %loop.latch2 ]
  %t385 = phi double [ %t58, %entry ], [ %t376, %loop.latch2 ]
  %t386 = phi i1 [ %t59, %entry ], [ %t377, %loop.latch2 ]
  %t387 = phi { %NativeStructLayoutField*, i64 }* [ %t56, %entry ], [ %t378, %loop.latch2 ]
  %t388 = phi i8* [ %t53, %entry ], [ %t379, %loop.latch2 ]
  %t389 = phi i8* [ %t54, %entry ], [ %t380, %loop.latch2 ]
  %t390 = phi i8* [ %t55, %entry ], [ %t381, %loop.latch2 ]
  store double %t382, double* %l16
  store { i8**, i64 }* %t383, { i8**, i64 }** %l0
  store double %t384, double* %l12
  store double %t385, double* %l13
  store i1 %t386, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t387, { %NativeStructLayoutField*, i64 }** %l11
  store i8* %t388, i8** %l8
  store i8* %t389, i8** %l9
  store i8* %t390, i8** %l10
  br label %loop.body1
loop.body1:
  %t62 = load double, double* %l16
  %t63 = load double, double* %l16
  %t64 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  %t68 = getelementptr i8*, i8** %t65, i64 %t63
  %t69 = load i8*, i8** %t68
  %t70 = call i8* @trim_text(i8* %t69)
  store i8* %t70, i8** %l17
  %t72 = load i8*, i8** %l17
  %t73 = load i8*, i8** %l17
  %s74 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.74, i32 0, i32 0
  %t75 = icmp eq i8* %t73, %s74
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load i8*, i8** %l1
  %t78 = load i8*, i8** %l2
  %t79 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t80 = load i8*, i8** %l4
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t82 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t83 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t84 = load i8*, i8** %l8
  %t85 = load i8*, i8** %l9
  %t86 = load i8*, i8** %l10
  %t87 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t88 = load double, double* %l12
  %t89 = load double, double* %l13
  %t90 = load i1, i1* %l14
  %t91 = load i1, i1* %l15
  %t92 = load double, double* %l16
  %t93 = load i8*, i8** %l17
  br i1 %t75, label %then4, label %merge5
then4:
  %t94 = load i8*, i8** %l8
  %t95 = load double, double* %l16
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l16
  br label %afterloop3
merge5:
  %t98 = load i8*, i8** %l8
  %t99 = load i8*, i8** %l17
  %s100 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load i8*, i8** %l1
  %t104 = load i8*, i8** %l2
  %t105 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t106 = load i8*, i8** %l4
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t108 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t109 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t110 = load i8*, i8** %l8
  %t111 = load i8*, i8** %l9
  %t112 = load i8*, i8** %l10
  %t113 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t114 = load double, double* %l12
  %t115 = load double, double* %l13
  %t116 = load i1, i1* %l14
  %t117 = load i1, i1* %l15
  %t118 = load double, double* %l16
  %t119 = load i8*, i8** %l17
  br i1 %t101, label %then6, label %merge7
then6:
  %t120 = load i8*, i8** %l17
  %s121 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.121, i32 0, i32 0
  %t122 = call i8* @strip_prefix(i8* %t120, i8* %s121)
  store i8* %t122, i8** %l18
  %t123 = load i8*, i8** %l18
  %s124 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.124, i32 0, i32 0
  %t125 = call i1 @starts_with(i8* %t123, i8* %s124)
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load i8*, i8** %l2
  %t129 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t130 = load i8*, i8** %l4
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t132 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t133 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t134 = load i8*, i8** %l8
  %t135 = load i8*, i8** %l9
  %t136 = load i8*, i8** %l10
  %t137 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t138 = load double, double* %l12
  %t139 = load double, double* %l13
  %t140 = load i1, i1* %l14
  %t141 = load i1, i1* %l15
  %t142 = load double, double* %l16
  %t143 = load i8*, i8** %l17
  %t144 = load i8*, i8** %l18
  br i1 %t125, label %then8, label %merge9
then8:
  %t145 = load i8*, i8** %l18
  %s146 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.146, i32 0, i32 0
  %t147 = call i8* @strip_prefix(i8* %t145, i8* %s146)
  %t148 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t147)
  store %StructLayoutHeaderParse %t148, %StructLayoutHeaderParse* %l19
  %t149 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t150 = extractvalue %StructLayoutHeaderParse %t149, 4
  %t151 = call double @diagnosticsconcat({ i8**, i64 }* %t150)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t152 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t153 = extractvalue %StructLayoutHeaderParse %t152, 0
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8*, i8** %l1
  %t156 = load i8*, i8** %l2
  %t157 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t158 = load i8*, i8** %l4
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t160 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t161 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t162 = load i8*, i8** %l8
  %t163 = load i8*, i8** %l9
  %t164 = load i8*, i8** %l10
  %t165 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t166 = load double, double* %l12
  %t167 = load double, double* %l13
  %t168 = load i1, i1* %l14
  %t169 = load i1, i1* %l15
  %t170 = load double, double* %l16
  %t171 = load i8*, i8** %l17
  %t172 = load i8*, i8** %l18
  %t173 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  br i1 %t153, label %then10, label %merge11
then10:
  %t174 = load i1, i1* %l14
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t176 = load i8*, i8** %l1
  %t177 = load i8*, i8** %l2
  %t178 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t179 = load i8*, i8** %l4
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t181 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t182 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t183 = load i8*, i8** %l8
  %t184 = load i8*, i8** %l9
  %t185 = load i8*, i8** %l10
  %t186 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t187 = load double, double* %l12
  %t188 = load double, double* %l13
  %t189 = load i1, i1* %l14
  %t190 = load i1, i1* %l15
  %t191 = load double, double* %l16
  %t192 = load i8*, i8** %l17
  %t193 = load i8*, i8** %l18
  %t194 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  br i1 %t174, label %then12, label %else13
then12:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s196 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.196, i32 0, i32 0
  %t197 = load i8*, i8** %l4
  %t198 = add i8* %s196, %t197
  %t199 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t195, i8* %t198)
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  br label %merge14
else13:
  %t200 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t201 = extractvalue %StructLayoutHeaderParse %t200, 2
  store double %t201, double* %l12
  %t202 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t203 = extractvalue %StructLayoutHeaderParse %t202, 3
  store double %t203, double* %l13
  store i1 1, i1* %l14
  br label %merge14
merge14:
  %t204 = phi { i8**, i64 }* [ %t199, %then12 ], [ %t175, %else13 ]
  %t205 = phi double [ %t187, %then12 ], [ %t201, %else13 ]
  %t206 = phi double [ %t188, %then12 ], [ %t203, %else13 ]
  %t207 = phi i1 [ %t189, %then12 ], [ 1, %else13 ]
  store { i8**, i64 }* %t204, { i8**, i64 }** %l0
  store double %t205, double* %l12
  store double %t206, double* %l13
  store i1 %t207, i1* %l14
  br label %merge11
merge11:
  %t208 = phi { i8**, i64 }* [ %t199, %then10 ], [ %t154, %then8 ]
  %t209 = phi double [ %t201, %then10 ], [ %t166, %then8 ]
  %t210 = phi double [ %t203, %then10 ], [ %t167, %then8 ]
  %t211 = phi i1 [ 1, %then10 ], [ %t168, %then8 ]
  store { i8**, i64 }* %t208, { i8**, i64 }** %l0
  store double %t209, double* %l12
  store double %t210, double* %l13
  store i1 %t211, i1* %l14
  %t212 = load double, double* %l16
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  store double %t214, double* %l16
  br label %loop.latch2
merge9:
  %t215 = load i8*, i8** %l18
  %s216 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.216, i32 0, i32 0
  %t217 = call i1 @starts_with(i8* %t215, i8* %s216)
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load i8*, i8** %l1
  %t220 = load i8*, i8** %l2
  %t221 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t222 = load i8*, i8** %l4
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t224 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t225 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t226 = load i8*, i8** %l8
  %t227 = load i8*, i8** %l9
  %t228 = load i8*, i8** %l10
  %t229 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t230 = load double, double* %l12
  %t231 = load double, double* %l13
  %t232 = load i1, i1* %l14
  %t233 = load i1, i1* %l15
  %t234 = load double, double* %l16
  %t235 = load i8*, i8** %l17
  %t236 = load i8*, i8** %l18
  br i1 %t217, label %then15, label %merge16
then15:
  %t237 = load i8*, i8** %l18
  %s238 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.238, i32 0, i32 0
  %t239 = call i8* @strip_prefix(i8* %t237, i8* %s238)
  %t240 = load i8*, i8** %l4
  %t241 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t239, i8* %t240)
  store %StructLayoutFieldParse %t241, %StructLayoutFieldParse* %l20
  %t242 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t243 = extractvalue %StructLayoutFieldParse %t242, 2
  %t244 = call double @diagnosticsconcat({ i8**, i64 }* %t243)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t245 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t246 = extractvalue %StructLayoutFieldParse %t245, 0
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
  %t264 = load i8*, i8** %l17
  %t265 = load i8*, i8** %l18
  %t266 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  br i1 %t246, label %then17, label %merge18
then17:
  %t267 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t268 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t269 = extractvalue %StructLayoutFieldParse %t268, 1
  %t270 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t267, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t270, { %NativeStructLayoutField*, i64 }** %l11
  br label %merge18
merge18:
  %t271 = phi { %NativeStructLayoutField*, i64 }* [ %t270, %then17 ], [ %t258, %then15 ]
  store { %NativeStructLayoutField*, i64 }* %t271, { %NativeStructLayoutField*, i64 }** %l11
  %t272 = load double, double* %l16
  %t273 = sitofp i64 1 to double
  %t274 = fadd double %t272, %t273
  store double %t274, double* %l16
  br label %loop.latch2
merge16:
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s276 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.276, i32 0, i32 0
  %t277 = load i8*, i8** %l17
  %t278 = add i8* %s276, %t277
  %t279 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t275, i8* %t278)
  store { i8**, i64 }* %t279, { i8**, i64 }** %l0
  %t280 = load double, double* %l16
  %t281 = sitofp i64 1 to double
  %t282 = fadd double %t280, %t281
  store double %t282, double* %l16
  br label %loop.latch2
merge7:
  %t283 = load i8*, i8** %l17
  %s284 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.284, i32 0, i32 0
  %t285 = icmp eq i8* %t283, %s284
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t287 = load i8*, i8** %l1
  %t288 = load i8*, i8** %l2
  %t289 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t290 = load i8*, i8** %l4
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t292 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t293 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t294 = load i8*, i8** %l8
  %t295 = load i8*, i8** %l9
  %t296 = load i8*, i8** %l10
  %t297 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t298 = load double, double* %l12
  %t299 = load double, double* %l13
  %t300 = load i1, i1* %l14
  %t301 = load i1, i1* %l15
  %t302 = load double, double* %l16
  %t303 = load i8*, i8** %l17
  br i1 %t285, label %then19, label %merge20
then19:
  %t304 = load double, double* %l16
  %t305 = sitofp i64 1 to double
  %t306 = fadd double %t304, %t305
  store double %t306, double* %l16
  br label %loop.latch2
merge20:
  %t307 = load i8*, i8** %l17
  %s308 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.308, i32 0, i32 0
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
  %t327 = load i8*, i8** %l17
  br i1 %t309, label %then21, label %merge22
then21:
  %t328 = load i8*, i8** %l17
  %s329 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.329, i32 0, i32 0
  %t330 = call i8* @strip_prefix(i8* %t328, i8* %s329)
  %t331 = call double @parse_struct_field_line(i8* %t330)
  store double %t331, double* %l21
  %t332 = load double, double* %l21
  %t333 = load double, double* %l16
  %t334 = sitofp i64 1 to double
  %t335 = fadd double %t333, %t334
  store double %t335, double* %l16
  br label %loop.latch2
merge22:
  %t336 = load i8*, i8** %l17
  %s337 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.337, i32 0, i32 0
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
  %t356 = load i8*, i8** %l17
  br i1 %t338, label %then23, label %merge24
then23:
  %t357 = load i8*, i8** %l8
  %t358 = load i8*, i8** %l17
  %s359 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.359, i32 0, i32 0
  %t360 = call i8* @strip_prefix(i8* %t358, i8* %s359)
  %t361 = call i8* @parse_function_name(i8* %t360)
  store i8* %t361, i8** %l22
  %t362 = load double, double* %l16
  %t363 = sitofp i64 1 to double
  %t364 = fadd double %t362, %t363
  store double %t364, double* %l16
  br label %loop.latch2
merge24:
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s366 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.366, i32 0, i32 0
  %t367 = load i8*, i8** %l17
  %t368 = add i8* %s366, %t367
  %t369 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t365, i8* %t368)
  store { i8**, i64 }* %t369, { i8**, i64 }** %l0
  %t370 = load double, double* %l16
  %t371 = sitofp i64 1 to double
  %t372 = fadd double %t370, %t371
  store double %t372, double* %l16
  br label %loop.latch2
loop.latch2:
  %t373 = load double, double* %l16
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t375 = load double, double* %l12
  %t376 = load double, double* %l13
  %t377 = load i1, i1* %l14
  %t378 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t379 = load i8*, i8** %l8
  %t380 = load i8*, i8** %l9
  %t381 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  store i8* null, i8** %l23
  %t391 = load i1, i1* %l14
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t393 = load i8*, i8** %l1
  %t394 = load i8*, i8** %l2
  %t395 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t396 = load i8*, i8** %l4
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t398 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t399 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t400 = load i8*, i8** %l8
  %t401 = load i8*, i8** %l9
  %t402 = load i8*, i8** %l10
  %t403 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t404 = load double, double* %l12
  %t405 = load double, double* %l13
  %t406 = load i1, i1* %l14
  %t407 = load i1, i1* %l15
  %t408 = load double, double* %l16
  %t409 = load i8*, i8** %l23
  br i1 %t391, label %then25, label %merge26
then25:
  %t410 = load double, double* %l12
  %t411 = insertvalue %NativeStructLayout undef, double %t410, 0
  %t412 = load double, double* %l13
  %t413 = insertvalue %NativeStructLayout %t411, double %t412, 1
  %t414 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t415 = insertvalue %NativeStructLayout %t413, { i8**, i64 }* null, 2
  store i8* null, i8** %l23
  br label %merge26
merge26:
  %t416 = phi i8* [ null, %then25 ], [ %t409, %entry ]
  store i8* %t416, i8** %l23
  %t417 = load i8*, i8** %l4
  %t418 = insertvalue %NativeStruct undef, i8* %t417, 0
  %t419 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t420 = insertvalue %NativeStruct %t418, { i8**, i64 }* null, 1
  %t421 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t422 = insertvalue %NativeStruct %t420, { i8**, i64 }* null, 2
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t424 = insertvalue %NativeStruct %t422, { i8**, i64 }* %t423, 3
  %t425 = load i8*, i8** %l23
  %t426 = insertvalue %NativeStruct %t424, i8* %t425, 4
  %t427 = insertvalue %StructParseResult undef, i8* null, 0
  %t428 = load double, double* %l16
  %t429 = insertvalue %StructParseResult %t427, double %t428, 1
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t431 = insertvalue %StructParseResult %t429, { i8**, i64 }* %t430, 2
  ret %StructParseResult %t431
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
  %t131 = phi double [ %t37, %entry ], [ %t128, %loop.latch2 ]
  %t132 = phi { i8**, i64 }* [ %t31, %entry ], [ %t129, %loop.latch2 ]
  %t133 = phi { %NativeInterfaceSignature*, i64 }* [ %t36, %entry ], [ %t130, %loop.latch2 ]
  store double %t131, double* %l6
  store { i8**, i64 }* %t132, { i8**, i64 }** %l0
  store { %NativeInterfaceSignature*, i64 }* %t133, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body1
loop.body1:
  %t38 = load double, double* %l6
  %t39 = load double, double* %l6
  %t40 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t41 = extractvalue { i8**, i64 } %t40, 0
  %t42 = extractvalue { i8**, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  %t44 = getelementptr i8*, i8** %t41, i64 %t39
  %t45 = load i8*, i8** %t44
  %t46 = call i8* @trim_text(i8* %t45)
  store i8* %t46, i8** %l7
  %t48 = load i8*, i8** %l7
  %t49 = load i8*, i8** %l7
  %s50 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t58 = load double, double* %l6
  %t59 = load i8*, i8** %l7
  br i1 %t51, label %then4, label %merge5
then4:
  %t60 = load double, double* %l6
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l6
  br label %afterloop3
merge5:
  %t63 = load i8*, i8** %l7
  %s64 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.64, i32 0, i32 0
  %t65 = icmp eq i8* %t63, %s64
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load i8*, i8** %l2
  %t69 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t70 = load i8*, i8** %l4
  %t71 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t72 = load double, double* %l6
  %t73 = load i8*, i8** %l7
  br i1 %t65, label %then6, label %merge7
then6:
  %t74 = load double, double* %l6
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l6
  br label %loop.latch2
merge7:
  %t77 = load i8*, i8** %l7
  %s78 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.78, i32 0, i32 0
  %t79 = call i1 @starts_with(i8* %t77, i8* %s78)
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load i8*, i8** %l2
  %t83 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t84 = load i8*, i8** %l4
  %t85 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t86 = load double, double* %l6
  %t87 = load i8*, i8** %l7
  br i1 %t79, label %then8, label %merge9
then8:
  %t88 = load i8*, i8** %l7
  %s89 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.89, i32 0, i32 0
  %t90 = call i8* @strip_prefix(i8* %t88, i8* %s89)
  %t91 = load i8*, i8** %l4
  %t92 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t90, i8* %t91)
  store %InterfaceSignatureParse %t92, %InterfaceSignatureParse* %l8
  %t93 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t94 = extractvalue %InterfaceSignatureParse %t93, 2
  %t95 = call double @diagnosticsconcat({ i8**, i64 }* %t94)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t96 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t97 = extractvalue %InterfaceSignatureParse %t96, 0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load i8*, i8** %l2
  %t101 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t102 = load i8*, i8** %l4
  %t103 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t104 = load double, double* %l6
  %t105 = load i8*, i8** %l7
  %t106 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t97, label %then10, label %merge11
then10:
  %t107 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t108 = extractvalue %InterfaceSignatureParse %t107, 1
  %t109 = alloca [1 x i8*]
  %t110 = getelementptr [1 x i8*], [1 x i8*]* %t109, i32 0, i32 0
  %t111 = getelementptr i8*, i8** %t110, i64 0
  store i8* %t108, i8** %t111
  %t112 = alloca { i8**, i64 }
  %t113 = getelementptr { i8**, i64 }, { i8**, i64 }* %t112, i32 0, i32 0
  store i8** %t110, i8*** %t113
  %t114 = getelementptr { i8**, i64 }, { i8**, i64 }* %t112, i32 0, i32 1
  store i64 1, i64* %t114
  %t115 = call double @signaturesconcat({ i8**, i64 }* %t112)
  store { %NativeInterfaceSignature*, i64 }* null, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge11
merge11:
  %t116 = phi { %NativeInterfaceSignature*, i64 }* [ null, %then10 ], [ %t103, %then8 ]
  store { %NativeInterfaceSignature*, i64 }* %t116, { %NativeInterfaceSignature*, i64 }** %l5
  %t117 = load double, double* %l6
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  store double %t119, double* %l6
  br label %loop.latch2
merge9:
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s121 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.121, i32 0, i32 0
  %t122 = load i8*, i8** %l7
  %t123 = add i8* %s121, %t122
  %t124 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t120, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l0
  %t125 = load double, double* %l6
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l6
  br label %loop.latch2
loop.latch2:
  %t128 = load double, double* %l6
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t134 = load i8*, i8** %l4
  %t135 = insertvalue %NativeInterface undef, i8* %t134, 0
  %t136 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t137 = extractvalue %InterfaceHeaderParse %t136, 1
  %t138 = insertvalue %NativeInterface %t135, { i8**, i64 }* %t137, 1
  %t139 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t140 = insertvalue %NativeInterface %t138, { i8**, i64 }* null, 2
  %t141 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t142 = load double, double* %l6
  %t143 = insertvalue %InterfaceParseResult %t141, double %t142, 1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = insertvalue %InterfaceParseResult %t143, { i8**, i64 }* %t144, 2
  ret %InterfaceParseResult %t145
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
  %l17 = alloca %EnumLayoutHeaderParse
  %l18 = alloca %EnumLayoutVariantParse
  %l19 = alloca double
  %l20 = alloca %EnumLayoutPayloadParse
  %l21 = alloca double
  %l22 = alloca double
  %l23 = alloca i8*
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
  %t481 = phi double [ %t67, %entry ], [ %t472, %loop.latch4 ]
  %t482 = phi { i8**, i64 }* [ %t53, %entry ], [ %t473, %loop.latch4 ]
  %t483 = phi double [ %t60, %entry ], [ %t474, %loop.latch4 ]
  %t484 = phi double [ %t61, %entry ], [ %t475, %loop.latch4 ]
  %t485 = phi i8* [ %t62, %entry ], [ %t476, %loop.latch4 ]
  %t486 = phi double [ %t63, %entry ], [ %t477, %loop.latch4 ]
  %t487 = phi double [ %t64, %entry ], [ %t478, %loop.latch4 ]
  %t488 = phi i1 [ %t65, %entry ], [ %t479, %loop.latch4 ]
  %t489 = phi { %NativeEnumVariantLayout*, i64 }* [ %t59, %entry ], [ %t480, %loop.latch4 ]
  store double %t481, double* %l14
  store { i8**, i64 }* %t482, { i8**, i64 }** %l0
  store double %t483, double* %l7
  store double %t484, double* %l8
  store i8* %t485, i8** %l9
  store double %t486, double* %l10
  store double %t487, double* %l11
  store i1 %t488, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t489, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t68 = load double, double* %l14
  %t69 = load double, double* %l14
  %t70 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t71 = extractvalue { i8**, i64 } %t70, 0
  %t72 = extractvalue { i8**, i64 } %t70, 1
  %t73 = icmp uge i64 %t69, %t72
  ; bounds check: %t73 (if true, out of bounds)
  %t74 = getelementptr i8*, i8** %t71, i64 %t69
  %t75 = load i8*, i8** %t74
  %t76 = call i8* @trim_text(i8* %t75)
  store i8* %t76, i8** %l15
  %t78 = load i8*, i8** %l15
  %t79 = load i8*, i8** %l15
  %s80 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.80, i32 0, i32 0
  %t81 = icmp eq i8* %t79, %s80
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = load i8*, i8** %l3
  %t86 = load double, double* %l4
  %t87 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t88 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t89 = load double, double* %l7
  %t90 = load double, double* %l8
  %t91 = load i8*, i8** %l9
  %t92 = load double, double* %l10
  %t93 = load double, double* %l11
  %t94 = load i1, i1* %l12
  %t95 = load i1, i1* %l13
  %t96 = load double, double* %l14
  %t97 = load i8*, i8** %l15
  br i1 %t81, label %then6, label %merge7
then6:
  %t98 = load double, double* %l14
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l14
  br label %loop.latch4
merge7:
  %t101 = load i8*, i8** %l15
  %s102 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.102, i32 0, i32 0
  %t103 = call i1 @starts_with(i8* %t101, i8* %s102)
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load i8*, i8** %l2
  %t107 = load i8*, i8** %l3
  %t108 = load double, double* %l4
  %t109 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t110 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t111 = load double, double* %l7
  %t112 = load double, double* %l8
  %t113 = load i8*, i8** %l9
  %t114 = load double, double* %l10
  %t115 = load double, double* %l11
  %t116 = load i1, i1* %l12
  %t117 = load i1, i1* %l13
  %t118 = load double, double* %l14
  %t119 = load i8*, i8** %l15
  br i1 %t103, label %then8, label %merge9
then8:
  %t120 = load i8*, i8** %l15
  %s121 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.121, i32 0, i32 0
  %t122 = call i8* @strip_prefix(i8* %t120, i8* %s121)
  store i8* %t122, i8** %l16
  %t123 = load i8*, i8** %l16
  %s124 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.124, i32 0, i32 0
  %t125 = call i1 @starts_with(i8* %t123, i8* %s124)
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load i8*, i8** %l2
  %t129 = load i8*, i8** %l3
  %t130 = load double, double* %l4
  %t131 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t132 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t133 = load double, double* %l7
  %t134 = load double, double* %l8
  %t135 = load i8*, i8** %l9
  %t136 = load double, double* %l10
  %t137 = load double, double* %l11
  %t138 = load i1, i1* %l12
  %t139 = load i1, i1* %l13
  %t140 = load double, double* %l14
  %t141 = load i8*, i8** %l15
  %t142 = load i8*, i8** %l16
  br i1 %t125, label %then10, label %merge11
then10:
  %t143 = load i8*, i8** %l16
  %s144 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.144, i32 0, i32 0
  %t145 = call i8* @strip_prefix(i8* %t143, i8* %s144)
  %t146 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t145)
  store %EnumLayoutHeaderParse %t146, %EnumLayoutHeaderParse* %l17
  %t147 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t148 = extractvalue %EnumLayoutHeaderParse %t147, 7
  %t149 = call double @diagnosticsconcat({ i8**, i64 }* %t148)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t150 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t151 = extractvalue %EnumLayoutHeaderParse %t150, 0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load i8*, i8** %l2
  %t155 = load i8*, i8** %l3
  %t156 = load double, double* %l4
  %t157 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t158 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t159 = load double, double* %l7
  %t160 = load double, double* %l8
  %t161 = load i8*, i8** %l9
  %t162 = load double, double* %l10
  %t163 = load double, double* %l11
  %t164 = load i1, i1* %l12
  %t165 = load i1, i1* %l13
  %t166 = load double, double* %l14
  %t167 = load i8*, i8** %l15
  %t168 = load i8*, i8** %l16
  %t169 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  br i1 %t151, label %then12, label %merge13
then12:
  %t170 = load i1, i1* %l12
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load i8*, i8** %l1
  %t173 = load i8*, i8** %l2
  %t174 = load i8*, i8** %l3
  %t175 = load double, double* %l4
  %t176 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t177 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t178 = load double, double* %l7
  %t179 = load double, double* %l8
  %t180 = load i8*, i8** %l9
  %t181 = load double, double* %l10
  %t182 = load double, double* %l11
  %t183 = load i1, i1* %l12
  %t184 = load i1, i1* %l13
  %t185 = load double, double* %l14
  %t186 = load i8*, i8** %l15
  %t187 = load i8*, i8** %l16
  %t188 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  br i1 %t170, label %then14, label %else15
then14:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s190 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.190, i32 0, i32 0
  %t191 = load i8*, i8** %l3
  %t192 = add i8* %s190, %t191
  %t193 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t189, i8* %t192)
  store { i8**, i64 }* %t193, { i8**, i64 }** %l0
  br label %merge16
else15:
  %t194 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t195 = extractvalue %EnumLayoutHeaderParse %t194, 2
  store double %t195, double* %l7
  %t196 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t197 = extractvalue %EnumLayoutHeaderParse %t196, 3
  store double %t197, double* %l8
  %t198 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t199 = extractvalue %EnumLayoutHeaderParse %t198, 4
  store i8* %t199, i8** %l9
  %t200 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t201 = extractvalue %EnumLayoutHeaderParse %t200, 5
  store double %t201, double* %l10
  %t202 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t203 = extractvalue %EnumLayoutHeaderParse %t202, 6
  store double %t203, double* %l11
  store i1 1, i1* %l12
  br label %merge16
merge16:
  %t204 = phi { i8**, i64 }* [ %t193, %then14 ], [ %t171, %else15 ]
  %t205 = phi double [ %t178, %then14 ], [ %t195, %else15 ]
  %t206 = phi double [ %t179, %then14 ], [ %t197, %else15 ]
  %t207 = phi i8* [ %t180, %then14 ], [ %t199, %else15 ]
  %t208 = phi double [ %t181, %then14 ], [ %t201, %else15 ]
  %t209 = phi double [ %t182, %then14 ], [ %t203, %else15 ]
  %t210 = phi i1 [ %t183, %then14 ], [ 1, %else15 ]
  store { i8**, i64 }* %t204, { i8**, i64 }** %l0
  store double %t205, double* %l7
  store double %t206, double* %l8
  store i8* %t207, i8** %l9
  store double %t208, double* %l10
  store double %t209, double* %l11
  store i1 %t210, i1* %l12
  br label %merge13
merge13:
  %t211 = phi { i8**, i64 }* [ %t193, %then12 ], [ %t152, %then10 ]
  %t212 = phi double [ %t195, %then12 ], [ %t159, %then10 ]
  %t213 = phi double [ %t197, %then12 ], [ %t160, %then10 ]
  %t214 = phi i8* [ %t199, %then12 ], [ %t161, %then10 ]
  %t215 = phi double [ %t201, %then12 ], [ %t162, %then10 ]
  %t216 = phi double [ %t203, %then12 ], [ %t163, %then10 ]
  %t217 = phi i1 [ 1, %then12 ], [ %t164, %then10 ]
  store { i8**, i64 }* %t211, { i8**, i64 }** %l0
  store double %t212, double* %l7
  store double %t213, double* %l8
  store i8* %t214, i8** %l9
  store double %t215, double* %l10
  store double %t216, double* %l11
  store i1 %t217, i1* %l12
  %t218 = load double, double* %l14
  %t219 = sitofp i64 1 to double
  %t220 = fadd double %t218, %t219
  store double %t220, double* %l14
  br label %loop.latch4
merge11:
  %t221 = load i8*, i8** %l16
  %s222 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.222, i32 0, i32 0
  %t223 = call i1 @starts_with(i8* %t221, i8* %s222)
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
  %t239 = load i8*, i8** %l15
  %t240 = load i8*, i8** %l16
  br i1 %t223, label %then17, label %merge18
then17:
  %t241 = load i8*, i8** %l16
  %s242 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.242, i32 0, i32 0
  %t243 = call i8* @strip_prefix(i8* %t241, i8* %s242)
  %t244 = load i8*, i8** %l3
  %t245 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t243, i8* %t244)
  store %EnumLayoutVariantParse %t245, %EnumLayoutVariantParse* %l18
  %t246 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t247 = extractvalue %EnumLayoutVariantParse %t246, 2
  %t248 = call double @diagnosticsconcat({ i8**, i64 }* %t247)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t249 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t250 = extractvalue %EnumLayoutVariantParse %t249, 0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load i8*, i8** %l1
  %t253 = load i8*, i8** %l2
  %t254 = load i8*, i8** %l3
  %t255 = load double, double* %l4
  %t256 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t257 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t258 = load double, double* %l7
  %t259 = load double, double* %l8
  %t260 = load i8*, i8** %l9
  %t261 = load double, double* %l10
  %t262 = load double, double* %l11
  %t263 = load i1, i1* %l12
  %t264 = load i1, i1* %l13
  %t265 = load double, double* %l14
  %t266 = load i8*, i8** %l15
  %t267 = load i8*, i8** %l16
  %t268 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  br i1 %t250, label %then19, label %merge20
then19:
  %t269 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t270 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t271 = extractvalue %EnumLayoutVariantParse %t270, 1
  store double 0.0, double* %l19
  %t272 = load double, double* %l19
  %t273 = sitofp i64 0 to double
  %t274 = fcmp oge double %t272, %t273
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t276 = load i8*, i8** %l1
  %t277 = load i8*, i8** %l2
  %t278 = load i8*, i8** %l3
  %t279 = load double, double* %l4
  %t280 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t281 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t282 = load double, double* %l7
  %t283 = load double, double* %l8
  %t284 = load i8*, i8** %l9
  %t285 = load double, double* %l10
  %t286 = load double, double* %l11
  %t287 = load i1, i1* %l12
  %t288 = load i1, i1* %l13
  %t289 = load double, double* %l14
  %t290 = load i8*, i8** %l15
  %t291 = load i8*, i8** %l16
  %t292 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t293 = load double, double* %l19
  br i1 %t274, label %then21, label %else22
then21:
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s295 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.295, i32 0, i32 0
  %t296 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t297 = extractvalue %EnumLayoutVariantParse %t296, 1
  br label %merge23
else22:
  %t298 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t299 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t300 = extractvalue %EnumLayoutVariantParse %t299, 1
  %t301 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t298, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t301, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge23
merge23:
  %t302 = phi { i8**, i64 }* [ null, %then21 ], [ %t275, %else22 ]
  %t303 = phi { %NativeEnumVariantLayout*, i64 }* [ %t281, %then21 ], [ %t301, %else22 ]
  store { i8**, i64 }* %t302, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t303, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge20
merge20:
  %t304 = phi { i8**, i64 }* [ null, %then19 ], [ %t251, %then17 ]
  %t305 = phi { %NativeEnumVariantLayout*, i64 }* [ %t301, %then19 ], [ %t257, %then17 ]
  store { i8**, i64 }* %t304, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t305, { %NativeEnumVariantLayout*, i64 }** %l6
  %t306 = load double, double* %l14
  %t307 = sitofp i64 1 to double
  %t308 = fadd double %t306, %t307
  store double %t308, double* %l14
  br label %loop.latch4
merge18:
  %t309 = load i8*, i8** %l16
  %s310 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.310, i32 0, i32 0
  %t311 = call i1 @starts_with(i8* %t309, i8* %s310)
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t313 = load i8*, i8** %l1
  %t314 = load i8*, i8** %l2
  %t315 = load i8*, i8** %l3
  %t316 = load double, double* %l4
  %t317 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t318 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t319 = load double, double* %l7
  %t320 = load double, double* %l8
  %t321 = load i8*, i8** %l9
  %t322 = load double, double* %l10
  %t323 = load double, double* %l11
  %t324 = load i1, i1* %l12
  %t325 = load i1, i1* %l13
  %t326 = load double, double* %l14
  %t327 = load i8*, i8** %l15
  %t328 = load i8*, i8** %l16
  br i1 %t311, label %then24, label %merge25
then24:
  %t329 = load i8*, i8** %l16
  %s330 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.330, i32 0, i32 0
  %t331 = call i8* @strip_prefix(i8* %t329, i8* %s330)
  %t332 = load i8*, i8** %l3
  %t333 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t331, i8* %t332)
  store %EnumLayoutPayloadParse %t333, %EnumLayoutPayloadParse* %l20
  %t334 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t335 = extractvalue %EnumLayoutPayloadParse %t334, 3
  %t336 = call double @diagnosticsconcat({ i8**, i64 }* %t335)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t337 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t338 = extractvalue %EnumLayoutPayloadParse %t337, 0
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t340 = load i8*, i8** %l1
  %t341 = load i8*, i8** %l2
  %t342 = load i8*, i8** %l3
  %t343 = load double, double* %l4
  %t344 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t345 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t346 = load double, double* %l7
  %t347 = load double, double* %l8
  %t348 = load i8*, i8** %l9
  %t349 = load double, double* %l10
  %t350 = load double, double* %l11
  %t351 = load i1, i1* %l12
  %t352 = load i1, i1* %l13
  %t353 = load double, double* %l14
  %t354 = load i8*, i8** %l15
  %t355 = load i8*, i8** %l16
  %t356 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  br i1 %t338, label %then26, label %merge27
then26:
  %t357 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t358 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t359 = extractvalue %EnumLayoutPayloadParse %t358, 1
  %t360 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t357, i8* %t359)
  store double %t360, double* %l21
  %t361 = load double, double* %l21
  %t362 = sitofp i64 0 to double
  %t363 = fcmp olt double %t361, %t362
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = load i8*, i8** %l1
  %t366 = load i8*, i8** %l2
  %t367 = load i8*, i8** %l3
  %t368 = load double, double* %l4
  %t369 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t370 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t371 = load double, double* %l7
  %t372 = load double, double* %l8
  %t373 = load i8*, i8** %l9
  %t374 = load double, double* %l10
  %t375 = load double, double* %l11
  %t376 = load i1, i1* %l12
  %t377 = load i1, i1* %l13
  %t378 = load double, double* %l14
  %t379 = load i8*, i8** %l15
  %t380 = load i8*, i8** %l16
  %t381 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t382 = load double, double* %l21
  br i1 %t363, label %then28, label %else29
then28:
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s384 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.384, i32 0, i32 0
  %t385 = load i8*, i8** %l3
  %t386 = add i8* %s384, %t385
  %s387 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.387, i32 0, i32 0
  %t388 = add i8* %t386, %s387
  %t389 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t390 = extractvalue %EnumLayoutPayloadParse %t389, 1
  %t391 = add i8* %t388, %t390
  %s392 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.392, i32 0, i32 0
  %t393 = add i8* %t391, %s392
  %t394 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t383, i8* %t393)
  store { i8**, i64 }* %t394, { i8**, i64 }** %l0
  br label %merge30
else29:
  %t395 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t396 = load double, double* %l21
  %t397 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t398 = extractvalue %EnumLayoutPayloadParse %t397, 2
  %t399 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t395, double %t396, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t399, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge30
merge30:
  %t400 = phi { i8**, i64 }* [ %t394, %then28 ], [ %t364, %else29 ]
  %t401 = phi { %NativeEnumVariantLayout*, i64 }* [ %t370, %then28 ], [ %t399, %else29 ]
  store { i8**, i64 }* %t400, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t401, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge27
merge27:
  %t402 = phi { i8**, i64 }* [ %t394, %then26 ], [ %t339, %then24 ]
  %t403 = phi { %NativeEnumVariantLayout*, i64 }* [ %t399, %then26 ], [ %t345, %then24 ]
  store { i8**, i64 }* %t402, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t403, { %NativeEnumVariantLayout*, i64 }** %l6
  %t404 = load double, double* %l14
  %t405 = sitofp i64 1 to double
  %t406 = fadd double %t404, %t405
  store double %t406, double* %l14
  br label %loop.latch4
merge25:
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s408 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.408, i32 0, i32 0
  %t409 = load i8*, i8** %l15
  %t410 = add i8* %s408, %t409
  %t411 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t407, i8* %t410)
  store { i8**, i64 }* %t411, { i8**, i64 }** %l0
  %t412 = load double, double* %l14
  %t413 = sitofp i64 1 to double
  %t414 = fadd double %t412, %t413
  store double %t414, double* %l14
  br label %loop.latch4
merge9:
  %t415 = load i8*, i8** %l15
  %s416 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.416, i32 0, i32 0
  %t417 = icmp eq i8* %t415, %s416
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t419 = load i8*, i8** %l1
  %t420 = load i8*, i8** %l2
  %t421 = load i8*, i8** %l3
  %t422 = load double, double* %l4
  %t423 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t424 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t425 = load double, double* %l7
  %t426 = load double, double* %l8
  %t427 = load i8*, i8** %l9
  %t428 = load double, double* %l10
  %t429 = load double, double* %l11
  %t430 = load i1, i1* %l12
  %t431 = load i1, i1* %l13
  %t432 = load double, double* %l14
  %t433 = load i8*, i8** %l15
  br i1 %t417, label %then31, label %merge32
then31:
  %t434 = load double, double* %l14
  %t435 = sitofp i64 1 to double
  %t436 = fadd double %t434, %t435
  store double %t436, double* %l14
  br label %afterloop5
merge32:
  %t437 = load i8*, i8** %l15
  %s438 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.438, i32 0, i32 0
  %t439 = call i1 @starts_with(i8* %t437, i8* %s438)
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t441 = load i8*, i8** %l1
  %t442 = load i8*, i8** %l2
  %t443 = load i8*, i8** %l3
  %t444 = load double, double* %l4
  %t445 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t446 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t447 = load double, double* %l7
  %t448 = load double, double* %l8
  %t449 = load i8*, i8** %l9
  %t450 = load double, double* %l10
  %t451 = load double, double* %l11
  %t452 = load i1, i1* %l12
  %t453 = load i1, i1* %l13
  %t454 = load double, double* %l14
  %t455 = load i8*, i8** %l15
  br i1 %t439, label %then33, label %merge34
then33:
  %t456 = load i8*, i8** %l15
  %s457 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.457, i32 0, i32 0
  %t458 = call i8* @strip_prefix(i8* %t456, i8* %s457)
  %t459 = call double @parse_enum_variant_line(i8* %t458)
  store double %t459, double* %l22
  %t460 = load double, double* %l22
  %t461 = load double, double* %l14
  %t462 = sitofp i64 1 to double
  %t463 = fadd double %t461, %t462
  store double %t463, double* %l14
  br label %loop.latch4
merge34:
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s465 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.465, i32 0, i32 0
  %t466 = load i8*, i8** %l15
  %t467 = add i8* %s465, %t466
  %t468 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t464, i8* %t467)
  store { i8**, i64 }* %t468, { i8**, i64 }** %l0
  %t469 = load double, double* %l14
  %t470 = sitofp i64 1 to double
  %t471 = fadd double %t469, %t470
  store double %t471, double* %l14
  br label %loop.latch4
loop.latch4:
  %t472 = load double, double* %l14
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load double, double* %l7
  %t475 = load double, double* %l8
  %t476 = load i8*, i8** %l9
  %t477 = load double, double* %l10
  %t478 = load double, double* %l11
  %t479 = load i1, i1* %l12
  %t480 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l23
  %t490 = load i1, i1* %l12
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t492 = load i8*, i8** %l1
  %t493 = load i8*, i8** %l2
  %t494 = load i8*, i8** %l3
  %t495 = load double, double* %l4
  %t496 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t497 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t498 = load double, double* %l7
  %t499 = load double, double* %l8
  %t500 = load i8*, i8** %l9
  %t501 = load double, double* %l10
  %t502 = load double, double* %l11
  %t503 = load i1, i1* %l12
  %t504 = load i1, i1* %l13
  %t505 = load double, double* %l14
  %t506 = load i8*, i8** %l23
  br i1 %t490, label %then35, label %merge36
then35:
  br label %merge36
merge36:
  %t507 = phi i8* [ null, %then35 ], [ %t506, %entry ]
  store i8* %t507, i8** %l23
  %t508 = load i8*, i8** %l3
  %t509 = insertvalue %NativeEnum undef, i8* %t508, 0
  %t510 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t511 = insertvalue %NativeEnum %t509, { i8**, i64 }* null, 1
  %t512 = load i8*, i8** %l23
  %t513 = insertvalue %NativeEnum %t511, i8* %t512, 2
  %t514 = insertvalue %EnumParseResult undef, i8* null, 0
  %t515 = load double, double* %l14
  %t516 = insertvalue %EnumParseResult %t514, double %t515, 1
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t518 = insertvalue %EnumParseResult %t516, { i8**, i64 }* %t517, 2
  ret %EnumParseResult %t518
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
  %l14 = alloca double
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
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l6
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l7
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l8
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t14 = load i1, i1* %l2
  %t15 = load i1, i1* %l3
  %t16 = load i1, i1* %l4
  %t17 = load i8*, i8** %l5
  %t18 = load double, double* %l6
  %t19 = load double, double* %l7
  %t20 = load double, double* %l8
  br label %loop.header0
loop.header0:
  %t157 = phi i8* [ %t17, %entry ], [ %t149, %loop.latch2 ]
  %t158 = phi i1 [ %t14, %entry ], [ %t150, %loop.latch2 ]
  %t159 = phi i1 [ %t15, %entry ], [ %t151, %loop.latch2 ]
  %t160 = phi double [ %t18, %entry ], [ %t152, %loop.latch2 ]
  %t161 = phi { i8**, i64 }* [ %t13, %entry ], [ %t153, %loop.latch2 ]
  %t162 = phi i1 [ %t16, %entry ], [ %t154, %loop.latch2 ]
  %t163 = phi double [ %t19, %entry ], [ %t155, %loop.latch2 ]
  %t164 = phi double [ %t20, %entry ], [ %t156, %loop.latch2 ]
  store i8* %t157, i8** %l5
  store i1 %t158, i1* %l2
  store i1 %t159, i1* %l3
  store double %t160, double* %l6
  store { i8**, i64 }* %t161, { i8**, i64 }** %l1
  store i1 %t162, i1* %l4
  store double %t163, double* %l7
  store double %t164, double* %l8
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l8
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l8
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  store i8* %t30, i8** %l9
  %t31 = load i8*, i8** %l9
  %s32 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.32, i32 0, i32 0
  %t33 = call i1 @starts_with(i8* %t31, i8* %s32)
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load i1, i1* %l2
  %t37 = load i1, i1* %l3
  %t38 = load i1, i1* %l4
  %t39 = load i8*, i8** %l5
  %t40 = load double, double* %l6
  %t41 = load double, double* %l7
  %t42 = load double, double* %l8
  %t43 = load i8*, i8** %l9
  br i1 %t33, label %then4, label %else5
then4:
  %t44 = load i8*, i8** %l9
  %t45 = load i8*, i8** %l9
  store i1 1, i1* %l2
  br label %merge6
else5:
  %t46 = load i8*, i8** %l9
  %s47 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.47, i32 0, i32 0
  %t48 = call i1 @starts_with(i8* %t46, i8* %s47)
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load i1, i1* %l2
  %t52 = load i1, i1* %l3
  %t53 = load i1, i1* %l4
  %t54 = load i8*, i8** %l5
  %t55 = load double, double* %l6
  %t56 = load double, double* %l7
  %t57 = load double, double* %l8
  %t58 = load i8*, i8** %l9
  br i1 %t48, label %then7, label %else8
then7:
  %t59 = load i8*, i8** %l9
  %t60 = load i8*, i8** %l9
  store double 0.0, double* %l10
  %t61 = load double, double* %l10
  %t62 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t62, %NumberParseResult* %l11
  %t63 = load %NumberParseResult, %NumberParseResult* %l11
  %t64 = extractvalue %NumberParseResult %t63, 0
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
  %t75 = load double, double* %l10
  %t76 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t64, label %then10, label %else11
then10:
  store i1 1, i1* %l3
  %t77 = load %NumberParseResult, %NumberParseResult* %l11
  %t78 = extractvalue %NumberParseResult %t77, 1
  store double %t78, double* %l6
  br label %merge12
else11:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s80 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.80, i32 0, i32 0
  %t81 = load double, double* %l10
  br label %merge12
merge12:
  %t82 = phi i1 [ 1, %then10 ], [ %t68, %else11 ]
  %t83 = phi double [ %t78, %then10 ], [ %t71, %else11 ]
  %t84 = phi { i8**, i64 }* [ %t66, %then10 ], [ null, %else11 ]
  store i1 %t82, i1* %l3
  store double %t83, double* %l6
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t85 = load i8*, i8** %l9
  %s86 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.86, i32 0, i32 0
  %t87 = call i1 @starts_with(i8* %t85, i8* %s86)
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load i1, i1* %l2
  %t91 = load i1, i1* %l3
  %t92 = load i1, i1* %l4
  %t93 = load i8*, i8** %l5
  %t94 = load double, double* %l6
  %t95 = load double, double* %l7
  %t96 = load double, double* %l8
  %t97 = load i8*, i8** %l9
  br i1 %t87, label %then13, label %else14
then13:
  %t98 = load i8*, i8** %l9
  %t99 = load i8*, i8** %l9
  store double 0.0, double* %l12
  %t100 = load double, double* %l12
  %t101 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t101, %NumberParseResult* %l13
  %t102 = load %NumberParseResult, %NumberParseResult* %l13
  %t103 = extractvalue %NumberParseResult %t102, 0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load i1, i1* %l2
  %t107 = load i1, i1* %l3
  %t108 = load i1, i1* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load double, double* %l6
  %t111 = load double, double* %l7
  %t112 = load double, double* %l8
  %t113 = load i8*, i8** %l9
  %t114 = load double, double* %l12
  %t115 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t103, label %then16, label %else17
then16:
  store i1 1, i1* %l4
  %t116 = load %NumberParseResult, %NumberParseResult* %l13
  %t117 = extractvalue %NumberParseResult %t116, 1
  store double %t117, double* %l7
  br label %merge18
else17:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s119 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.119, i32 0, i32 0
  %t120 = load double, double* %l12
  br label %merge18
merge18:
  %t121 = phi i1 [ 1, %then16 ], [ %t108, %else17 ]
  %t122 = phi double [ %t117, %then16 ], [ %t111, %else17 ]
  %t123 = phi { i8**, i64 }* [ %t105, %then16 ], [ null, %else17 ]
  store i1 %t121, i1* %l4
  store double %t122, double* %l7
  store { i8**, i64 }* %t123, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s125 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.125, i32 0, i32 0
  %t126 = load i8*, i8** %l9
  %t127 = add i8* %s125, %t126
  %s128 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.128, i32 0, i32 0
  %t129 = add i8* %t127, %s128
  %t130 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t124, i8* %t129)
  store { i8**, i64 }* %t130, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t131 = phi i1 [ 1, %then13 ], [ %t92, %else14 ]
  %t132 = phi double [ %t117, %then13 ], [ %t95, %else14 ]
  %t133 = phi { i8**, i64 }* [ null, %then13 ], [ %t130, %else14 ]
  store i1 %t131, i1* %l4
  store double %t132, double* %l7
  store { i8**, i64 }* %t133, { i8**, i64 }** %l1
  br label %merge9
merge9:
  %t134 = phi i1 [ 1, %then7 ], [ %t52, %else8 ]
  %t135 = phi double [ %t78, %then7 ], [ %t55, %else8 ]
  %t136 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t137 = phi i1 [ %t53, %then7 ], [ 1, %else8 ]
  %t138 = phi double [ %t56, %then7 ], [ %t117, %else8 ]
  store i1 %t134, i1* %l3
  store double %t135, double* %l6
  store { i8**, i64 }* %t136, { i8**, i64 }** %l1
  store i1 %t137, i1* %l4
  store double %t138, double* %l7
  br label %merge6
merge6:
  %t139 = phi i8* [ null, %then4 ], [ %t39, %else5 ]
  %t140 = phi i1 [ 1, %then4 ], [ %t36, %else5 ]
  %t141 = phi i1 [ %t37, %then4 ], [ 1, %else5 ]
  %t142 = phi double [ %t40, %then4 ], [ %t78, %else5 ]
  %t143 = phi { i8**, i64 }* [ %t35, %then4 ], [ null, %else5 ]
  %t144 = phi i1 [ %t38, %then4 ], [ 1, %else5 ]
  %t145 = phi double [ %t41, %then4 ], [ %t117, %else5 ]
  store i8* %t139, i8** %l5
  store i1 %t140, i1* %l2
  store i1 %t141, i1* %l3
  store double %t142, double* %l6
  store { i8**, i64 }* %t143, { i8**, i64 }** %l1
  store i1 %t144, i1* %l4
  store double %t145, double* %l7
  %t146 = load double, double* %l8
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l8
  br label %loop.latch2
loop.latch2:
  %t149 = load i8*, i8** %l5
  %t150 = load i1, i1* %l2
  %t151 = load i1, i1* %l3
  %t152 = load double, double* %l6
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load i1, i1* %l4
  %t155 = load double, double* %l7
  %t156 = load double, double* %l8
  br label %loop.header0
afterloop3:
  %t167 = load i1, i1* %l3
  br label %logical_and_entry_166

logical_and_entry_166:
  br i1 %t167, label %logical_and_right_166, label %logical_and_merge_166

logical_and_right_166:
  %t168 = load i1, i1* %l4
  br label %logical_and_right_end_166

logical_and_right_end_166:
  br label %logical_and_merge_166

logical_and_merge_166:
  %t169 = phi i1 [ false, %logical_and_entry_166 ], [ %t168, %logical_and_right_end_166 ]
  br label %logical_and_entry_165

logical_and_entry_165:
  br i1 %t169, label %logical_and_right_165, label %logical_and_merge_165

logical_and_right_165:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l14
  %t171 = load double, double* %l14
  %t172 = fcmp one double %t171, 0.0
  %t173 = insertvalue %StructLayoutHeaderParse undef, i1 %t172, 0
  %t174 = load i8*, i8** %l5
  %t175 = insertvalue %StructLayoutHeaderParse %t173, i8* %t174, 1
  %t176 = load double, double* %l6
  %t177 = insertvalue %StructLayoutHeaderParse %t175, double %t176, 2
  %t178 = load double, double* %l7
  %t179 = insertvalue %StructLayoutHeaderParse %t177, double %t178, 3
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t181 = insertvalue %StructLayoutHeaderParse %t179, { i8**, i64 }* %t180, 4
  ret %StructLayoutHeaderParse %t181
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
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 0, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 0
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l4
  %t27 = load i8*, i8** %l4
  %s28 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.28, i32 0, i32 0
  store i8* %s28, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l9
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l10
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l11
  %t32 = sitofp i64 1 to double
  store double %t32, double* %l12
  %t33 = load i8*, i8** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t37 = load i8*, i8** %l4
  %t38 = load i8*, i8** %l5
  %t39 = load i1, i1* %l6
  %t40 = load i1, i1* %l7
  %t41 = load i1, i1* %l8
  %t42 = load double, double* %l9
  %t43 = load double, double* %l10
  %t44 = load double, double* %l11
  %t45 = load double, double* %l12
  br label %loop.header0
loop.header0:
  %t286 = phi i8* [ %t38, %entry ], [ %t277, %loop.latch2 ]
  %t287 = phi i1 [ %t39, %entry ], [ %t278, %loop.latch2 ]
  %t288 = phi double [ %t42, %entry ], [ %t279, %loop.latch2 ]
  %t289 = phi { i8**, i64 }* [ %t34, %entry ], [ %t280, %loop.latch2 ]
  %t290 = phi i1 [ %t40, %entry ], [ %t281, %loop.latch2 ]
  %t291 = phi double [ %t43, %entry ], [ %t282, %loop.latch2 ]
  %t292 = phi i1 [ %t41, %entry ], [ %t283, %loop.latch2 ]
  %t293 = phi double [ %t44, %entry ], [ %t284, %loop.latch2 ]
  %t294 = phi double [ %t45, %entry ], [ %t285, %loop.latch2 ]
  store i8* %t286, i8** %l5
  store i1 %t287, i1* %l6
  store double %t288, double* %l9
  store { i8**, i64 }* %t289, { i8**, i64 }** %l1
  store i1 %t290, i1* %l7
  store double %t291, double* %l10
  store i1 %t292, i1* %l8
  store double %t293, double* %l11
  store double %t294, double* %l12
  br label %loop.body1
loop.body1:
  %t46 = load double, double* %l12
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t49 = load double, double* %l12
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  store i8* %t55, i8** %l13
  %t56 = load i8*, i8** %l13
  %s57 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.57, i32 0, i32 0
  %t58 = call i1 @starts_with(i8* %t56, i8* %s57)
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t63 = load i8*, i8** %l4
  %t64 = load i8*, i8** %l5
  %t65 = load i1, i1* %l6
  %t66 = load i1, i1* %l7
  %t67 = load i1, i1* %l8
  %t68 = load double, double* %l9
  %t69 = load double, double* %l10
  %t70 = load double, double* %l11
  %t71 = load double, double* %l12
  %t72 = load i8*, i8** %l13
  br i1 %t58, label %then4, label %else5
then4:
  %t73 = load i8*, i8** %l13
  %t74 = load i8*, i8** %l13
  br label %merge6
else5:
  %t75 = load i8*, i8** %l13
  %s76 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.76, i32 0, i32 0
  %t77 = call i1 @starts_with(i8* %t75, i8* %s76)
  %t78 = load i8*, i8** %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t82 = load i8*, i8** %l4
  %t83 = load i8*, i8** %l5
  %t84 = load i1, i1* %l6
  %t85 = load i1, i1* %l7
  %t86 = load i1, i1* %l8
  %t87 = load double, double* %l9
  %t88 = load double, double* %l10
  %t89 = load double, double* %l11
  %t90 = load double, double* %l12
  %t91 = load i8*, i8** %l13
  br i1 %t77, label %then7, label %else8
then7:
  %t92 = load i8*, i8** %l13
  %t93 = load i8*, i8** %l13
  store double 0.0, double* %l14
  %t94 = load double, double* %l14
  %t95 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t95, %NumberParseResult* %l15
  %t96 = load %NumberParseResult, %NumberParseResult* %l15
  %t97 = extractvalue %NumberParseResult %t96, 0
  %t98 = load i8*, i8** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t102 = load i8*, i8** %l4
  %t103 = load i8*, i8** %l5
  %t104 = load i1, i1* %l6
  %t105 = load i1, i1* %l7
  %t106 = load i1, i1* %l8
  %t107 = load double, double* %l9
  %t108 = load double, double* %l10
  %t109 = load double, double* %l11
  %t110 = load double, double* %l12
  %t111 = load i8*, i8** %l13
  %t112 = load double, double* %l14
  %t113 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t97, label %then10, label %else11
then10:
  store i1 1, i1* %l6
  %t114 = load %NumberParseResult, %NumberParseResult* %l15
  %t115 = extractvalue %NumberParseResult %t114, 1
  store double %t115, double* %l9
  br label %merge12
else11:
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s117 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.117, i32 0, i32 0
  %t118 = add i8* %s117, %struct_name
  %s119 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.119, i32 0, i32 0
  %t120 = add i8* %t118, %s119
  %t121 = load i8*, i8** %l4
  %t122 = add i8* %t120, %t121
  %s123 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.123, i32 0, i32 0
  %t124 = add i8* %t122, %s123
  %t125 = load double, double* %l14
  br label %merge12
merge12:
  %t126 = phi i1 [ 1, %then10 ], [ %t104, %else11 ]
  %t127 = phi double [ %t115, %then10 ], [ %t107, %else11 ]
  %t128 = phi { i8**, i64 }* [ %t99, %then10 ], [ null, %else11 ]
  store i1 %t126, i1* %l6
  store double %t127, double* %l9
  store { i8**, i64 }* %t128, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t129 = load i8*, i8** %l13
  %s130 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.130, i32 0, i32 0
  %t131 = call i1 @starts_with(i8* %t129, i8* %s130)
  %t132 = load i8*, i8** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t136 = load i8*, i8** %l4
  %t137 = load i8*, i8** %l5
  %t138 = load i1, i1* %l6
  %t139 = load i1, i1* %l7
  %t140 = load i1, i1* %l8
  %t141 = load double, double* %l9
  %t142 = load double, double* %l10
  %t143 = load double, double* %l11
  %t144 = load double, double* %l12
  %t145 = load i8*, i8** %l13
  br i1 %t131, label %then13, label %else14
then13:
  %t146 = load i8*, i8** %l13
  %t147 = load i8*, i8** %l13
  store double 0.0, double* %l16
  %t148 = load double, double* %l16
  %t149 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t149, %NumberParseResult* %l17
  %t150 = load %NumberParseResult, %NumberParseResult* %l17
  %t151 = extractvalue %NumberParseResult %t150, 0
  %t152 = load i8*, i8** %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t156 = load i8*, i8** %l4
  %t157 = load i8*, i8** %l5
  %t158 = load i1, i1* %l6
  %t159 = load i1, i1* %l7
  %t160 = load i1, i1* %l8
  %t161 = load double, double* %l9
  %t162 = load double, double* %l10
  %t163 = load double, double* %l11
  %t164 = load double, double* %l12
  %t165 = load i8*, i8** %l13
  %t166 = load double, double* %l16
  %t167 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t151, label %then16, label %else17
then16:
  store i1 1, i1* %l7
  %t168 = load %NumberParseResult, %NumberParseResult* %l17
  %t169 = extractvalue %NumberParseResult %t168, 1
  store double %t169, double* %l10
  br label %merge18
else17:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s171 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.171, i32 0, i32 0
  %t172 = add i8* %s171, %struct_name
  %s173 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.173, i32 0, i32 0
  %t174 = add i8* %t172, %s173
  %t175 = load i8*, i8** %l4
  %t176 = add i8* %t174, %t175
  %s177 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.177, i32 0, i32 0
  %t178 = add i8* %t176, %s177
  %t179 = load double, double* %l16
  br label %merge18
merge18:
  %t180 = phi i1 [ 1, %then16 ], [ %t159, %else17 ]
  %t181 = phi double [ %t169, %then16 ], [ %t162, %else17 ]
  %t182 = phi { i8**, i64 }* [ %t153, %then16 ], [ null, %else17 ]
  store i1 %t180, i1* %l7
  store double %t181, double* %l10
  store { i8**, i64 }* %t182, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t183 = load i8*, i8** %l13
  %s184 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.184, i32 0, i32 0
  %t185 = call i1 @starts_with(i8* %t183, i8* %s184)
  %t186 = load i8*, i8** %l0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t188 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t190 = load i8*, i8** %l4
  %t191 = load i8*, i8** %l5
  %t192 = load i1, i1* %l6
  %t193 = load i1, i1* %l7
  %t194 = load i1, i1* %l8
  %t195 = load double, double* %l9
  %t196 = load double, double* %l10
  %t197 = load double, double* %l11
  %t198 = load double, double* %l12
  %t199 = load i8*, i8** %l13
  br i1 %t185, label %then19, label %else20
then19:
  %t200 = load i8*, i8** %l13
  %t201 = load i8*, i8** %l13
  store double 0.0, double* %l18
  %t202 = load double, double* %l18
  %t203 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t203, %NumberParseResult* %l19
  %t204 = load %NumberParseResult, %NumberParseResult* %l19
  %t205 = extractvalue %NumberParseResult %t204, 0
  %t206 = load i8*, i8** %l0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t208 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t210 = load i8*, i8** %l4
  %t211 = load i8*, i8** %l5
  %t212 = load i1, i1* %l6
  %t213 = load i1, i1* %l7
  %t214 = load i1, i1* %l8
  %t215 = load double, double* %l9
  %t216 = load double, double* %l10
  %t217 = load double, double* %l11
  %t218 = load double, double* %l12
  %t219 = load i8*, i8** %l13
  %t220 = load double, double* %l18
  %t221 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t205, label %then22, label %else23
then22:
  store i1 1, i1* %l8
  %t222 = load %NumberParseResult, %NumberParseResult* %l19
  %t223 = extractvalue %NumberParseResult %t222, 1
  store double %t223, double* %l11
  br label %merge24
else23:
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s225 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.225, i32 0, i32 0
  %t226 = add i8* %s225, %struct_name
  %s227 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.227, i32 0, i32 0
  %t228 = add i8* %t226, %s227
  %t229 = load i8*, i8** %l4
  %t230 = add i8* %t228, %t229
  %s231 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.231, i32 0, i32 0
  %t232 = add i8* %t230, %s231
  %t233 = load double, double* %l18
  br label %merge24
merge24:
  %t234 = phi i1 [ 1, %then22 ], [ %t214, %else23 ]
  %t235 = phi double [ %t223, %then22 ], [ %t217, %else23 ]
  %t236 = phi { i8**, i64 }* [ %t207, %then22 ], [ null, %else23 ]
  store i1 %t234, i1* %l8
  store double %t235, double* %l11
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s238 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.238, i32 0, i32 0
  %t239 = add i8* %s238, %struct_name
  %s240 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.240, i32 0, i32 0
  %t241 = add i8* %t239, %s240
  %t242 = load i8*, i8** %l4
  %t243 = add i8* %t241, %t242
  %s244 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.244, i32 0, i32 0
  %t245 = add i8* %t243, %s244
  %t246 = load i8*, i8** %l13
  %t247 = add i8* %t245, %t246
  %s248 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.248, i32 0, i32 0
  %t249 = add i8* %t247, %s248
  %t250 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t237, i8* %t249)
  store { i8**, i64 }* %t250, { i8**, i64 }** %l1
  br label %merge21
merge21:
  %t251 = phi i1 [ 1, %then19 ], [ %t194, %else20 ]
  %t252 = phi double [ %t223, %then19 ], [ %t197, %else20 ]
  %t253 = phi { i8**, i64 }* [ null, %then19 ], [ %t250, %else20 ]
  store i1 %t251, i1* %l8
  store double %t252, double* %l11
  store { i8**, i64 }* %t253, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t254 = phi i1 [ 1, %then13 ], [ %t139, %else14 ]
  %t255 = phi double [ %t169, %then13 ], [ %t142, %else14 ]
  %t256 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t257 = phi i1 [ %t140, %then13 ], [ 1, %else14 ]
  %t258 = phi double [ %t143, %then13 ], [ %t223, %else14 ]
  store i1 %t254, i1* %l7
  store double %t255, double* %l10
  store { i8**, i64 }* %t256, { i8**, i64 }** %l1
  store i1 %t257, i1* %l8
  store double %t258, double* %l11
  br label %merge9
merge9:
  %t259 = phi i1 [ 1, %then7 ], [ %t84, %else8 ]
  %t260 = phi double [ %t115, %then7 ], [ %t87, %else8 ]
  %t261 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t262 = phi i1 [ %t85, %then7 ], [ 1, %else8 ]
  %t263 = phi double [ %t88, %then7 ], [ %t169, %else8 ]
  %t264 = phi i1 [ %t86, %then7 ], [ 1, %else8 ]
  %t265 = phi double [ %t89, %then7 ], [ %t223, %else8 ]
  store i1 %t259, i1* %l6
  store double %t260, double* %l9
  store { i8**, i64 }* %t261, { i8**, i64 }** %l1
  store i1 %t262, i1* %l7
  store double %t263, double* %l10
  store i1 %t264, i1* %l8
  store double %t265, double* %l11
  br label %merge6
merge6:
  %t266 = phi i8* [ null, %then4 ], [ %t64, %else5 ]
  %t267 = phi i1 [ %t65, %then4 ], [ 1, %else5 ]
  %t268 = phi double [ %t68, %then4 ], [ %t115, %else5 ]
  %t269 = phi { i8**, i64 }* [ %t60, %then4 ], [ null, %else5 ]
  %t270 = phi i1 [ %t66, %then4 ], [ 1, %else5 ]
  %t271 = phi double [ %t69, %then4 ], [ %t169, %else5 ]
  %t272 = phi i1 [ %t67, %then4 ], [ 1, %else5 ]
  %t273 = phi double [ %t70, %then4 ], [ %t223, %else5 ]
  store i8* %t266, i8** %l5
  store i1 %t267, i1* %l6
  store double %t268, double* %l9
  store { i8**, i64 }* %t269, { i8**, i64 }** %l1
  store i1 %t270, i1* %l7
  store double %t271, double* %l10
  store i1 %t272, i1* %l8
  store double %t273, double* %l11
  %t274 = load double, double* %l12
  %t275 = sitofp i64 1 to double
  %t276 = fadd double %t274, %t275
  store double %t276, double* %l12
  br label %loop.latch2
loop.latch2:
  %t277 = load i8*, i8** %l5
  %t278 = load i1, i1* %l6
  %t279 = load double, double* %l9
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load i1, i1* %l7
  %t282 = load double, double* %l10
  %t283 = load i1, i1* %l8
  %t284 = load double, double* %l11
  %t285 = load double, double* %l12
  br label %loop.header0
afterloop3:
  %t295 = load i8*, i8** %l5
  %t300 = load i8*, i8** %l5
  store double 0.0, double* %l20
  %t301 = load i8*, i8** %l4
  %t302 = insertvalue %NativeStructLayoutField undef, i8* %t301, 0
  %t303 = load i8*, i8** %l5
  %t304 = insertvalue %NativeStructLayoutField %t302, i8* %t303, 1
  %t305 = load double, double* %l9
  %t306 = insertvalue %NativeStructLayoutField %t304, double %t305, 2
  %t307 = load double, double* %l10
  %t308 = insertvalue %NativeStructLayoutField %t306, double %t307, 3
  %t309 = load double, double* %l11
  %t310 = insertvalue %NativeStructLayoutField %t308, double %t309, 4
  store %NativeStructLayoutField %t310, %NativeStructLayoutField* %l21
  %t311 = load double, double* %l20
  %t312 = fcmp one double %t311, 0.0
  %t313 = insertvalue %StructLayoutFieldParse undef, i1 %t312, 0
  %t314 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t315 = insertvalue %StructLayoutFieldParse %t313, i8* null, 1
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t317 = insertvalue %StructLayoutFieldParse %t315, { i8**, i64 }* %t316, 2
  ret %StructLayoutFieldParse %t317
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
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l5
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  store i8* %s9, i8** %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l9
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l10
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l11
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l12
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l13
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load i1, i1* %l2
  %t18 = load i1, i1* %l3
  %t19 = load i1, i1* %l4
  %t20 = load i8*, i8** %l5
  %t21 = load i8*, i8** %l6
  %t22 = load i1, i1* %l7
  %t23 = load i1, i1* %l8
  %t24 = load double, double* %l9
  %t25 = load double, double* %l10
  %t26 = load double, double* %l11
  %t27 = load double, double* %l12
  %t28 = load double, double* %l13
  br label %loop.header0
loop.header0:
  %t342 = phi i8* [ %t20, %entry ], [ %t329, %loop.latch2 ]
  %t343 = phi i1 [ %t17, %entry ], [ %t330, %loop.latch2 ]
  %t344 = phi i1 [ %t18, %entry ], [ %t331, %loop.latch2 ]
  %t345 = phi double [ %t24, %entry ], [ %t332, %loop.latch2 ]
  %t346 = phi { i8**, i64 }* [ %t16, %entry ], [ %t333, %loop.latch2 ]
  %t347 = phi i1 [ %t19, %entry ], [ %t334, %loop.latch2 ]
  %t348 = phi double [ %t25, %entry ], [ %t335, %loop.latch2 ]
  %t349 = phi i8* [ %t21, %entry ], [ %t336, %loop.latch2 ]
  %t350 = phi i1 [ %t22, %entry ], [ %t337, %loop.latch2 ]
  %t351 = phi double [ %t26, %entry ], [ %t338, %loop.latch2 ]
  %t352 = phi i1 [ %t23, %entry ], [ %t339, %loop.latch2 ]
  %t353 = phi double [ %t27, %entry ], [ %t340, %loop.latch2 ]
  %t354 = phi double [ %t28, %entry ], [ %t341, %loop.latch2 ]
  store i8* %t342, i8** %l5
  store i1 %t343, i1* %l2
  store i1 %t344, i1* %l3
  store double %t345, double* %l9
  store { i8**, i64 }* %t346, { i8**, i64 }** %l1
  store i1 %t347, i1* %l4
  store double %t348, double* %l10
  store i8* %t349, i8** %l6
  store i1 %t350, i1* %l7
  store double %t351, double* %l11
  store i1 %t352, i1* %l8
  store double %t353, double* %l12
  store double %t354, double* %l13
  br label %loop.body1
loop.body1:
  %t29 = load double, double* %l13
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l13
  %t33 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t34 = extractvalue { i8**, i64 } %t33, 0
  %t35 = extractvalue { i8**, i64 } %t33, 1
  %t36 = icmp uge i64 %t32, %t35
  ; bounds check: %t36 (if true, out of bounds)
  %t37 = getelementptr i8*, i8** %t34, i64 %t32
  %t38 = load i8*, i8** %t37
  store i8* %t38, i8** %l14
  %t39 = load i8*, i8** %l14
  %s40 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.40, i32 0, i32 0
  %t41 = call i1 @starts_with(i8* %t39, i8* %s40)
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load i1, i1* %l2
  %t45 = load i1, i1* %l3
  %t46 = load i1, i1* %l4
  %t47 = load i8*, i8** %l5
  %t48 = load i8*, i8** %l6
  %t49 = load i1, i1* %l7
  %t50 = load i1, i1* %l8
  %t51 = load double, double* %l9
  %t52 = load double, double* %l10
  %t53 = load double, double* %l11
  %t54 = load double, double* %l12
  %t55 = load double, double* %l13
  %t56 = load i8*, i8** %l14
  br i1 %t41, label %then4, label %else5
then4:
  %t57 = load i8*, i8** %l14
  %t58 = load i8*, i8** %l14
  store i1 1, i1* %l2
  br label %merge6
else5:
  %t59 = load i8*, i8** %l14
  %s60 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.60, i32 0, i32 0
  %t61 = call i1 @starts_with(i8* %t59, i8* %s60)
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load i1, i1* %l2
  %t65 = load i1, i1* %l3
  %t66 = load i1, i1* %l4
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l6
  %t69 = load i1, i1* %l7
  %t70 = load i1, i1* %l8
  %t71 = load double, double* %l9
  %t72 = load double, double* %l10
  %t73 = load double, double* %l11
  %t74 = load double, double* %l12
  %t75 = load double, double* %l13
  %t76 = load i8*, i8** %l14
  br i1 %t61, label %then7, label %else8
then7:
  %t77 = load i8*, i8** %l14
  %t78 = load i8*, i8** %l14
  store double 0.0, double* %l15
  %t79 = load double, double* %l15
  %t80 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t80, %NumberParseResult* %l16
  %t81 = load %NumberParseResult, %NumberParseResult* %l16
  %t82 = extractvalue %NumberParseResult %t81, 0
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
  %t98 = load double, double* %l15
  %t99 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t82, label %then10, label %else11
then10:
  store i1 1, i1* %l3
  %t100 = load %NumberParseResult, %NumberParseResult* %l16
  %t101 = extractvalue %NumberParseResult %t100, 1
  store double %t101, double* %l9
  br label %merge12
else11:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s103 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.103, i32 0, i32 0
  %t104 = load double, double* %l15
  br label %merge12
merge12:
  %t105 = phi i1 [ 1, %then10 ], [ %t86, %else11 ]
  %t106 = phi double [ %t101, %then10 ], [ %t92, %else11 ]
  %t107 = phi { i8**, i64 }* [ %t84, %then10 ], [ null, %else11 ]
  store i1 %t105, i1* %l3
  store double %t106, double* %l9
  store { i8**, i64 }* %t107, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t108 = load i8*, i8** %l14
  %s109 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.109, i32 0, i32 0
  %t110 = call i1 @starts_with(i8* %t108, i8* %s109)
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load i1, i1* %l2
  %t114 = load i1, i1* %l3
  %t115 = load i1, i1* %l4
  %t116 = load i8*, i8** %l5
  %t117 = load i8*, i8** %l6
  %t118 = load i1, i1* %l7
  %t119 = load i1, i1* %l8
  %t120 = load double, double* %l9
  %t121 = load double, double* %l10
  %t122 = load double, double* %l11
  %t123 = load double, double* %l12
  %t124 = load double, double* %l13
  %t125 = load i8*, i8** %l14
  br i1 %t110, label %then13, label %else14
then13:
  %t126 = load i8*, i8** %l14
  %t127 = load i8*, i8** %l14
  store double 0.0, double* %l17
  %t128 = load double, double* %l17
  %t129 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t129, %NumberParseResult* %l18
  %t130 = load %NumberParseResult, %NumberParseResult* %l18
  %t131 = extractvalue %NumberParseResult %t130, 0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load i1, i1* %l2
  %t135 = load i1, i1* %l3
  %t136 = load i1, i1* %l4
  %t137 = load i8*, i8** %l5
  %t138 = load i8*, i8** %l6
  %t139 = load i1, i1* %l7
  %t140 = load i1, i1* %l8
  %t141 = load double, double* %l9
  %t142 = load double, double* %l10
  %t143 = load double, double* %l11
  %t144 = load double, double* %l12
  %t145 = load double, double* %l13
  %t146 = load i8*, i8** %l14
  %t147 = load double, double* %l17
  %t148 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t131, label %then16, label %else17
then16:
  store i1 1, i1* %l4
  %t149 = load %NumberParseResult, %NumberParseResult* %l18
  %t150 = extractvalue %NumberParseResult %t149, 1
  store double %t150, double* %l10
  br label %merge18
else17:
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s152 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.152, i32 0, i32 0
  %t153 = load double, double* %l17
  br label %merge18
merge18:
  %t154 = phi i1 [ 1, %then16 ], [ %t136, %else17 ]
  %t155 = phi double [ %t150, %then16 ], [ %t142, %else17 ]
  %t156 = phi { i8**, i64 }* [ %t133, %then16 ], [ null, %else17 ]
  store i1 %t154, i1* %l4
  store double %t155, double* %l10
  store { i8**, i64 }* %t156, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t157 = load i8*, i8** %l14
  %s158 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.158, i32 0, i32 0
  %t159 = call i1 @starts_with(i8* %t157, i8* %s158)
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load i1, i1* %l2
  %t163 = load i1, i1* %l3
  %t164 = load i1, i1* %l4
  %t165 = load i8*, i8** %l5
  %t166 = load i8*, i8** %l6
  %t167 = load i1, i1* %l7
  %t168 = load i1, i1* %l8
  %t169 = load double, double* %l9
  %t170 = load double, double* %l10
  %t171 = load double, double* %l11
  %t172 = load double, double* %l12
  %t173 = load double, double* %l13
  %t174 = load i8*, i8** %l14
  br i1 %t159, label %then19, label %else20
then19:
  %t175 = load i8*, i8** %l14
  %t176 = load i8*, i8** %l14
  br label %merge21
else20:
  %t177 = load i8*, i8** %l14
  %s178 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.178, i32 0, i32 0
  %t179 = call i1 @starts_with(i8* %t177, i8* %s178)
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load i1, i1* %l2
  %t183 = load i1, i1* %l3
  %t184 = load i1, i1* %l4
  %t185 = load i8*, i8** %l5
  %t186 = load i8*, i8** %l6
  %t187 = load i1, i1* %l7
  %t188 = load i1, i1* %l8
  %t189 = load double, double* %l9
  %t190 = load double, double* %l10
  %t191 = load double, double* %l11
  %t192 = load double, double* %l12
  %t193 = load double, double* %l13
  %t194 = load i8*, i8** %l14
  br i1 %t179, label %then22, label %else23
then22:
  %t195 = load i8*, i8** %l14
  %t196 = load i8*, i8** %l14
  store double 0.0, double* %l19
  %t197 = load double, double* %l19
  %t198 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t198, %NumberParseResult* %l20
  %t199 = load %NumberParseResult, %NumberParseResult* %l20
  %t200 = extractvalue %NumberParseResult %t199, 0
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
  %t216 = load double, double* %l19
  %t217 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t200, label %then25, label %else26
then25:
  store i1 1, i1* %l7
  %t218 = load %NumberParseResult, %NumberParseResult* %l20
  %t219 = extractvalue %NumberParseResult %t218, 1
  store double %t219, double* %l11
  br label %merge27
else26:
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s221 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.221, i32 0, i32 0
  %t222 = load double, double* %l19
  br label %merge27
merge27:
  %t223 = phi i1 [ 1, %then25 ], [ %t208, %else26 ]
  %t224 = phi double [ %t219, %then25 ], [ %t212, %else26 ]
  %t225 = phi { i8**, i64 }* [ %t202, %then25 ], [ null, %else26 ]
  store i1 %t223, i1* %l7
  store double %t224, double* %l11
  store { i8**, i64 }* %t225, { i8**, i64 }** %l1
  br label %merge24
else23:
  %t226 = load i8*, i8** %l14
  %s227 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.227, i32 0, i32 0
  %t228 = call i1 @starts_with(i8* %t226, i8* %s227)
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t231 = load i1, i1* %l2
  %t232 = load i1, i1* %l3
  %t233 = load i1, i1* %l4
  %t234 = load i8*, i8** %l5
  %t235 = load i8*, i8** %l6
  %t236 = load i1, i1* %l7
  %t237 = load i1, i1* %l8
  %t238 = load double, double* %l9
  %t239 = load double, double* %l10
  %t240 = load double, double* %l11
  %t241 = load double, double* %l12
  %t242 = load double, double* %l13
  %t243 = load i8*, i8** %l14
  br i1 %t228, label %then28, label %else29
then28:
  %t244 = load i8*, i8** %l14
  %t245 = load i8*, i8** %l14
  store double 0.0, double* %l21
  %t246 = load double, double* %l21
  %t247 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t247, %NumberParseResult* %l22
  %t248 = load %NumberParseResult, %NumberParseResult* %l22
  %t249 = extractvalue %NumberParseResult %t248, 0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t252 = load i1, i1* %l2
  %t253 = load i1, i1* %l3
  %t254 = load i1, i1* %l4
  %t255 = load i8*, i8** %l5
  %t256 = load i8*, i8** %l6
  %t257 = load i1, i1* %l7
  %t258 = load i1, i1* %l8
  %t259 = load double, double* %l9
  %t260 = load double, double* %l10
  %t261 = load double, double* %l11
  %t262 = load double, double* %l12
  %t263 = load double, double* %l13
  %t264 = load i8*, i8** %l14
  %t265 = load double, double* %l21
  %t266 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t249, label %then31, label %else32
then31:
  store i1 1, i1* %l8
  %t267 = load %NumberParseResult, %NumberParseResult* %l22
  %t268 = extractvalue %NumberParseResult %t267, 1
  store double %t268, double* %l12
  br label %merge33
else32:
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s270 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.270, i32 0, i32 0
  %t271 = load double, double* %l21
  br label %merge33
merge33:
  %t272 = phi i1 [ 1, %then31 ], [ %t258, %else32 ]
  %t273 = phi double [ %t268, %then31 ], [ %t262, %else32 ]
  %t274 = phi { i8**, i64 }* [ %t251, %then31 ], [ null, %else32 ]
  store i1 %t272, i1* %l8
  store double %t273, double* %l12
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  br label %merge30
else29:
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s276 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.276, i32 0, i32 0
  %t277 = load i8*, i8** %l14
  %t278 = add i8* %s276, %t277
  %s279 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.279, i32 0, i32 0
  %t280 = add i8* %t278, %s279
  %t281 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t275, i8* %t280)
  store { i8**, i64 }* %t281, { i8**, i64 }** %l1
  br label %merge30
merge30:
  %t282 = phi i1 [ 1, %then28 ], [ %t237, %else29 ]
  %t283 = phi double [ %t268, %then28 ], [ %t241, %else29 ]
  %t284 = phi { i8**, i64 }* [ null, %then28 ], [ %t281, %else29 ]
  store i1 %t282, i1* %l8
  store double %t283, double* %l12
  store { i8**, i64 }* %t284, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t285 = phi i1 [ 1, %then22 ], [ %t187, %else23 ]
  %t286 = phi double [ %t219, %then22 ], [ %t191, %else23 ]
  %t287 = phi { i8**, i64 }* [ null, %then22 ], [ null, %else23 ]
  %t288 = phi i1 [ %t188, %then22 ], [ 1, %else23 ]
  %t289 = phi double [ %t192, %then22 ], [ %t268, %else23 ]
  store i1 %t285, i1* %l7
  store double %t286, double* %l11
  store { i8**, i64 }* %t287, { i8**, i64 }** %l1
  store i1 %t288, i1* %l8
  store double %t289, double* %l12
  br label %merge21
merge21:
  %t290 = phi i8* [ null, %then19 ], [ %t166, %else20 ]
  %t291 = phi i1 [ %t167, %then19 ], [ 1, %else20 ]
  %t292 = phi double [ %t171, %then19 ], [ %t219, %else20 ]
  %t293 = phi { i8**, i64 }* [ %t161, %then19 ], [ null, %else20 ]
  %t294 = phi i1 [ %t168, %then19 ], [ 1, %else20 ]
  %t295 = phi double [ %t172, %then19 ], [ %t268, %else20 ]
  store i8* %t290, i8** %l6
  store i1 %t291, i1* %l7
  store double %t292, double* %l11
  store { i8**, i64 }* %t293, { i8**, i64 }** %l1
  store i1 %t294, i1* %l8
  store double %t295, double* %l12
  br label %merge15
merge15:
  %t296 = phi i1 [ 1, %then13 ], [ %t115, %else14 ]
  %t297 = phi double [ %t150, %then13 ], [ %t121, %else14 ]
  %t298 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t299 = phi i8* [ %t117, %then13 ], [ null, %else14 ]
  %t300 = phi i1 [ %t118, %then13 ], [ 1, %else14 ]
  %t301 = phi double [ %t122, %then13 ], [ %t219, %else14 ]
  %t302 = phi i1 [ %t119, %then13 ], [ 1, %else14 ]
  %t303 = phi double [ %t123, %then13 ], [ %t268, %else14 ]
  store i1 %t296, i1* %l4
  store double %t297, double* %l10
  store { i8**, i64 }* %t298, { i8**, i64 }** %l1
  store i8* %t299, i8** %l6
  store i1 %t300, i1* %l7
  store double %t301, double* %l11
  store i1 %t302, i1* %l8
  store double %t303, double* %l12
  br label %merge9
merge9:
  %t304 = phi i1 [ 1, %then7 ], [ %t65, %else8 ]
  %t305 = phi double [ %t101, %then7 ], [ %t71, %else8 ]
  %t306 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t307 = phi i1 [ %t66, %then7 ], [ 1, %else8 ]
  %t308 = phi double [ %t72, %then7 ], [ %t150, %else8 ]
  %t309 = phi i8* [ %t68, %then7 ], [ null, %else8 ]
  %t310 = phi i1 [ %t69, %then7 ], [ 1, %else8 ]
  %t311 = phi double [ %t73, %then7 ], [ %t219, %else8 ]
  %t312 = phi i1 [ %t70, %then7 ], [ 1, %else8 ]
  %t313 = phi double [ %t74, %then7 ], [ %t268, %else8 ]
  store i1 %t304, i1* %l3
  store double %t305, double* %l9
  store { i8**, i64 }* %t306, { i8**, i64 }** %l1
  store i1 %t307, i1* %l4
  store double %t308, double* %l10
  store i8* %t309, i8** %l6
  store i1 %t310, i1* %l7
  store double %t311, double* %l11
  store i1 %t312, i1* %l8
  store double %t313, double* %l12
  br label %merge6
merge6:
  %t314 = phi i8* [ null, %then4 ], [ %t47, %else5 ]
  %t315 = phi i1 [ 1, %then4 ], [ %t44, %else5 ]
  %t316 = phi i1 [ %t45, %then4 ], [ 1, %else5 ]
  %t317 = phi double [ %t51, %then4 ], [ %t101, %else5 ]
  %t318 = phi { i8**, i64 }* [ %t43, %then4 ], [ null, %else5 ]
  %t319 = phi i1 [ %t46, %then4 ], [ 1, %else5 ]
  %t320 = phi double [ %t52, %then4 ], [ %t150, %else5 ]
  %t321 = phi i8* [ %t48, %then4 ], [ null, %else5 ]
  %t322 = phi i1 [ %t49, %then4 ], [ 1, %else5 ]
  %t323 = phi double [ %t53, %then4 ], [ %t219, %else5 ]
  %t324 = phi i1 [ %t50, %then4 ], [ 1, %else5 ]
  %t325 = phi double [ %t54, %then4 ], [ %t268, %else5 ]
  store i8* %t314, i8** %l5
  store i1 %t315, i1* %l2
  store i1 %t316, i1* %l3
  store double %t317, double* %l9
  store { i8**, i64 }* %t318, { i8**, i64 }** %l1
  store i1 %t319, i1* %l4
  store double %t320, double* %l10
  store i8* %t321, i8** %l6
  store i1 %t322, i1* %l7
  store double %t323, double* %l11
  store i1 %t324, i1* %l8
  store double %t325, double* %l12
  %t326 = load double, double* %l13
  %t327 = sitofp i64 1 to double
  %t328 = fadd double %t326, %t327
  store double %t328, double* %l13
  br label %loop.latch2
loop.latch2:
  %t329 = load i8*, i8** %l5
  %t330 = load i1, i1* %l2
  %t331 = load i1, i1* %l3
  %t332 = load double, double* %l9
  %t333 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t334 = load i1, i1* %l4
  %t335 = load double, double* %l10
  %t336 = load i8*, i8** %l6
  %t337 = load i1, i1* %l7
  %t338 = load double, double* %l11
  %t339 = load i1, i1* %l8
  %t340 = load double, double* %l12
  %t341 = load double, double* %l13
  br label %loop.header0
afterloop3:
  %t355 = load i8*, i8** %l6
  %t361 = load i1, i1* %l3
  br label %logical_and_entry_360

logical_and_entry_360:
  br i1 %t361, label %logical_and_right_360, label %logical_and_merge_360

logical_and_right_360:
  %t362 = load i1, i1* %l4
  br label %logical_and_right_end_360

logical_and_right_end_360:
  br label %logical_and_merge_360

logical_and_merge_360:
  %t363 = phi i1 [ false, %logical_and_entry_360 ], [ %t362, %logical_and_right_end_360 ]
  br label %logical_and_entry_359

logical_and_entry_359:
  br i1 %t363, label %logical_and_right_359, label %logical_and_merge_359

logical_and_right_359:
  %t364 = load i8*, i8** %l6
  store double 0.0, double* %l23
  %t365 = load double, double* %l23
  %t366 = fcmp one double %t365, 0.0
  %t367 = insertvalue %EnumLayoutHeaderParse undef, i1 %t366, 0
  %t368 = load i8*, i8** %l5
  %t369 = insertvalue %EnumLayoutHeaderParse %t367, i8* %t368, 1
  %t370 = load double, double* %l9
  %t371 = insertvalue %EnumLayoutHeaderParse %t369, double %t370, 2
  %t372 = load double, double* %l10
  %t373 = insertvalue %EnumLayoutHeaderParse %t371, double %t372, 3
  %t374 = load i8*, i8** %l6
  %t375 = insertvalue %EnumLayoutHeaderParse %t373, i8* %t374, 4
  %t376 = load double, double* %l11
  %t377 = insertvalue %EnumLayoutHeaderParse %t375, double %t376, 5
  %t378 = load double, double* %l12
  %t379 = insertvalue %EnumLayoutHeaderParse %t377, double %t378, 6
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t381 = insertvalue %EnumLayoutHeaderParse %t379, { i8**, i64 }* %t380, 7
  ret %EnumLayoutHeaderParse %t381
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
  %l23 = alloca double
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
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t26
  %t28 = extractvalue { i8**, i64 } %t27, 0
  %t29 = extractvalue { i8**, i64 } %t27, 1
  %t30 = icmp uge i64 0, %t29
  ; bounds check: %t30 (if true, out of bounds)
  %t31 = getelementptr i8*, i8** %t28, i64 0
  %t32 = load i8*, i8** %t31
  store i8* %t32, i8** %l4
  %t33 = load i8*, i8** %l4
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l9
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l10
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l11
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l12
  %t38 = sitofp i64 1 to double
  store double %t38, double* %l13
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load i8*, i8** %l4
  %t44 = load i1, i1* %l5
  %t45 = load i1, i1* %l6
  %t46 = load i1, i1* %l7
  %t47 = load i1, i1* %l8
  %t48 = load double, double* %l9
  %t49 = load double, double* %l10
  %t50 = load double, double* %l11
  %t51 = load double, double* %l12
  %t52 = load double, double* %l13
  br label %loop.header0
loop.header0:
  %t338 = phi i1 [ %t44, %entry ], [ %t328, %loop.latch2 ]
  %t339 = phi double [ %t48, %entry ], [ %t329, %loop.latch2 ]
  %t340 = phi { i8**, i64 }* [ %t40, %entry ], [ %t330, %loop.latch2 ]
  %t341 = phi i1 [ %t45, %entry ], [ %t331, %loop.latch2 ]
  %t342 = phi double [ %t49, %entry ], [ %t332, %loop.latch2 ]
  %t343 = phi i1 [ %t46, %entry ], [ %t333, %loop.latch2 ]
  %t344 = phi double [ %t50, %entry ], [ %t334, %loop.latch2 ]
  %t345 = phi i1 [ %t47, %entry ], [ %t335, %loop.latch2 ]
  %t346 = phi double [ %t51, %entry ], [ %t336, %loop.latch2 ]
  %t347 = phi double [ %t52, %entry ], [ %t337, %loop.latch2 ]
  store i1 %t338, i1* %l5
  store double %t339, double* %l9
  store { i8**, i64 }* %t340, { i8**, i64 }** %l1
  store i1 %t341, i1* %l6
  store double %t342, double* %l10
  store i1 %t343, i1* %l7
  store double %t344, double* %l11
  store i1 %t345, i1* %l8
  store double %t346, double* %l12
  store double %t347, double* %l13
  br label %loop.body1
loop.body1:
  %t53 = load double, double* %l13
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load double, double* %l13
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t55
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  store i8* %t62, i8** %l14
  %t63 = load i8*, i8** %l14
  %s64 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.64, i32 0, i32 0
  %t65 = call i1 @starts_with(i8* %t63, i8* %s64)
  %t66 = load i8*, i8** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t68 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t70 = load i8*, i8** %l4
  %t71 = load i1, i1* %l5
  %t72 = load i1, i1* %l6
  %t73 = load i1, i1* %l7
  %t74 = load i1, i1* %l8
  %t75 = load double, double* %l9
  %t76 = load double, double* %l10
  %t77 = load double, double* %l11
  %t78 = load double, double* %l12
  %t79 = load double, double* %l13
  %t80 = load i8*, i8** %l14
  br i1 %t65, label %then4, label %else5
then4:
  %t81 = load i8*, i8** %l14
  %t82 = load i8*, i8** %l14
  store double 0.0, double* %l15
  %t83 = load double, double* %l15
  %t84 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t84, %NumberParseResult* %l16
  %t85 = load %NumberParseResult, %NumberParseResult* %l16
  %t86 = extractvalue %NumberParseResult %t85, 0
  %t87 = load i8*, i8** %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t91 = load i8*, i8** %l4
  %t92 = load i1, i1* %l5
  %t93 = load i1, i1* %l6
  %t94 = load i1, i1* %l7
  %t95 = load i1, i1* %l8
  %t96 = load double, double* %l9
  %t97 = load double, double* %l10
  %t98 = load double, double* %l11
  %t99 = load double, double* %l12
  %t100 = load double, double* %l13
  %t101 = load i8*, i8** %l14
  %t102 = load double, double* %l15
  %t103 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t86, label %then7, label %else8
then7:
  store i1 1, i1* %l5
  %t104 = load %NumberParseResult, %NumberParseResult* %l16
  %t105 = extractvalue %NumberParseResult %t104, 1
  store double %t105, double* %l9
  br label %merge9
else8:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s107 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.107, i32 0, i32 0
  %t108 = add i8* %s107, %enum_name
  %s109 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.109, i32 0, i32 0
  %t110 = add i8* %t108, %s109
  %t111 = load i8*, i8** %l4
  %t112 = add i8* %t110, %t111
  %s113 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.113, i32 0, i32 0
  %t114 = add i8* %t112, %s113
  %t115 = load double, double* %l15
  br label %merge9
merge9:
  %t116 = phi i1 [ 1, %then7 ], [ %t92, %else8 ]
  %t117 = phi double [ %t105, %then7 ], [ %t96, %else8 ]
  %t118 = phi { i8**, i64 }* [ %t88, %then7 ], [ null, %else8 ]
  store i1 %t116, i1* %l5
  store double %t117, double* %l9
  store { i8**, i64 }* %t118, { i8**, i64 }** %l1
  br label %merge6
else5:
  %t119 = load i8*, i8** %l14
  %s120 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i1 @starts_with(i8* %t119, i8* %s120)
  %t122 = load i8*, i8** %l0
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t124 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t126 = load i8*, i8** %l4
  %t127 = load i1, i1* %l5
  %t128 = load i1, i1* %l6
  %t129 = load i1, i1* %l7
  %t130 = load i1, i1* %l8
  %t131 = load double, double* %l9
  %t132 = load double, double* %l10
  %t133 = load double, double* %l11
  %t134 = load double, double* %l12
  %t135 = load double, double* %l13
  %t136 = load i8*, i8** %l14
  br i1 %t121, label %then10, label %else11
then10:
  %t137 = load i8*, i8** %l14
  %t138 = load i8*, i8** %l14
  store double 0.0, double* %l17
  %t139 = load double, double* %l17
  %t140 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t140, %NumberParseResult* %l18
  %t141 = load %NumberParseResult, %NumberParseResult* %l18
  %t142 = extractvalue %NumberParseResult %t141, 0
  %t143 = load i8*, i8** %l0
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t145 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t147 = load i8*, i8** %l4
  %t148 = load i1, i1* %l5
  %t149 = load i1, i1* %l6
  %t150 = load i1, i1* %l7
  %t151 = load i1, i1* %l8
  %t152 = load double, double* %l9
  %t153 = load double, double* %l10
  %t154 = load double, double* %l11
  %t155 = load double, double* %l12
  %t156 = load double, double* %l13
  %t157 = load i8*, i8** %l14
  %t158 = load double, double* %l17
  %t159 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t142, label %then13, label %else14
then13:
  store i1 1, i1* %l6
  %t160 = load %NumberParseResult, %NumberParseResult* %l18
  %t161 = extractvalue %NumberParseResult %t160, 1
  store double %t161, double* %l10
  br label %merge15
else14:
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s163 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.163, i32 0, i32 0
  %t164 = add i8* %s163, %enum_name
  %s165 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.165, i32 0, i32 0
  %t166 = add i8* %t164, %s165
  %t167 = load i8*, i8** %l4
  %t168 = add i8* %t166, %t167
  %s169 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.169, i32 0, i32 0
  %t170 = add i8* %t168, %s169
  %t171 = load double, double* %l17
  br label %merge15
merge15:
  %t172 = phi i1 [ 1, %then13 ], [ %t149, %else14 ]
  %t173 = phi double [ %t161, %then13 ], [ %t153, %else14 ]
  %t174 = phi { i8**, i64 }* [ %t144, %then13 ], [ null, %else14 ]
  store i1 %t172, i1* %l6
  store double %t173, double* %l10
  store { i8**, i64 }* %t174, { i8**, i64 }** %l1
  br label %merge12
else11:
  %t175 = load i8*, i8** %l14
  %s176 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.176, i32 0, i32 0
  %t177 = call i1 @starts_with(i8* %t175, i8* %s176)
  %t178 = load i8*, i8** %l0
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t180 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t182 = load i8*, i8** %l4
  %t183 = load i1, i1* %l5
  %t184 = load i1, i1* %l6
  %t185 = load i1, i1* %l7
  %t186 = load i1, i1* %l8
  %t187 = load double, double* %l9
  %t188 = load double, double* %l10
  %t189 = load double, double* %l11
  %t190 = load double, double* %l12
  %t191 = load double, double* %l13
  %t192 = load i8*, i8** %l14
  br i1 %t177, label %then16, label %else17
then16:
  %t193 = load i8*, i8** %l14
  %t194 = load i8*, i8** %l14
  store double 0.0, double* %l19
  %t195 = load double, double* %l19
  %t196 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t196, %NumberParseResult* %l20
  %t197 = load %NumberParseResult, %NumberParseResult* %l20
  %t198 = extractvalue %NumberParseResult %t197, 0
  %t199 = load i8*, i8** %l0
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t201 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t203 = load i8*, i8** %l4
  %t204 = load i1, i1* %l5
  %t205 = load i1, i1* %l6
  %t206 = load i1, i1* %l7
  %t207 = load i1, i1* %l8
  %t208 = load double, double* %l9
  %t209 = load double, double* %l10
  %t210 = load double, double* %l11
  %t211 = load double, double* %l12
  %t212 = load double, double* %l13
  %t213 = load i8*, i8** %l14
  %t214 = load double, double* %l19
  %t215 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t198, label %then19, label %else20
then19:
  store i1 1, i1* %l7
  %t216 = load %NumberParseResult, %NumberParseResult* %l20
  %t217 = extractvalue %NumberParseResult %t216, 1
  store double %t217, double* %l11
  br label %merge21
else20:
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s219 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.219, i32 0, i32 0
  %t220 = add i8* %s219, %enum_name
  %s221 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.221, i32 0, i32 0
  %t222 = add i8* %t220, %s221
  %t223 = load i8*, i8** %l4
  %t224 = add i8* %t222, %t223
  %s225 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.225, i32 0, i32 0
  %t226 = add i8* %t224, %s225
  %t227 = load double, double* %l19
  br label %merge21
merge21:
  %t228 = phi i1 [ 1, %then19 ], [ %t206, %else20 ]
  %t229 = phi double [ %t217, %then19 ], [ %t210, %else20 ]
  %t230 = phi { i8**, i64 }* [ %t200, %then19 ], [ null, %else20 ]
  store i1 %t228, i1* %l7
  store double %t229, double* %l11
  store { i8**, i64 }* %t230, { i8**, i64 }** %l1
  br label %merge18
else17:
  %t231 = load i8*, i8** %l14
  %s232 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.232, i32 0, i32 0
  %t233 = call i1 @starts_with(i8* %t231, i8* %s232)
  %t234 = load i8*, i8** %l0
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t236 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t238 = load i8*, i8** %l4
  %t239 = load i1, i1* %l5
  %t240 = load i1, i1* %l6
  %t241 = load i1, i1* %l7
  %t242 = load i1, i1* %l8
  %t243 = load double, double* %l9
  %t244 = load double, double* %l10
  %t245 = load double, double* %l11
  %t246 = load double, double* %l12
  %t247 = load double, double* %l13
  %t248 = load i8*, i8** %l14
  br i1 %t233, label %then22, label %else23
then22:
  %t249 = load i8*, i8** %l14
  %t250 = load i8*, i8** %l14
  store double 0.0, double* %l21
  %t251 = load double, double* %l21
  %t252 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t252, %NumberParseResult* %l22
  %t253 = load %NumberParseResult, %NumberParseResult* %l22
  %t254 = extractvalue %NumberParseResult %t253, 0
  %t255 = load i8*, i8** %l0
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t257 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t259 = load i8*, i8** %l4
  %t260 = load i1, i1* %l5
  %t261 = load i1, i1* %l6
  %t262 = load i1, i1* %l7
  %t263 = load i1, i1* %l8
  %t264 = load double, double* %l9
  %t265 = load double, double* %l10
  %t266 = load double, double* %l11
  %t267 = load double, double* %l12
  %t268 = load double, double* %l13
  %t269 = load i8*, i8** %l14
  %t270 = load double, double* %l21
  %t271 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t254, label %then25, label %else26
then25:
  store i1 1, i1* %l8
  %t272 = load %NumberParseResult, %NumberParseResult* %l22
  %t273 = extractvalue %NumberParseResult %t272, 1
  store double %t273, double* %l12
  br label %merge27
else26:
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s275 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.275, i32 0, i32 0
  %t276 = add i8* %s275, %enum_name
  %s277 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.277, i32 0, i32 0
  %t278 = add i8* %t276, %s277
  %t279 = load i8*, i8** %l4
  %t280 = add i8* %t278, %t279
  %s281 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.281, i32 0, i32 0
  %t282 = add i8* %t280, %s281
  %t283 = load double, double* %l21
  br label %merge27
merge27:
  %t284 = phi i1 [ 1, %then25 ], [ %t263, %else26 ]
  %t285 = phi double [ %t273, %then25 ], [ %t267, %else26 ]
  %t286 = phi { i8**, i64 }* [ %t256, %then25 ], [ null, %else26 ]
  store i1 %t284, i1* %l8
  store double %t285, double* %l12
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  br label %merge24
else23:
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s288 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.288, i32 0, i32 0
  %t289 = add i8* %s288, %enum_name
  %s290 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.290, i32 0, i32 0
  %t291 = add i8* %t289, %s290
  %t292 = load i8*, i8** %l4
  %t293 = add i8* %t291, %t292
  %s294 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.294, i32 0, i32 0
  %t295 = add i8* %t293, %s294
  %t296 = load i8*, i8** %l14
  %t297 = add i8* %t295, %t296
  %s298 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.298, i32 0, i32 0
  %t299 = add i8* %t297, %s298
  %t300 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t287, i8* %t299)
  store { i8**, i64 }* %t300, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t301 = phi i1 [ 1, %then22 ], [ %t242, %else23 ]
  %t302 = phi double [ %t273, %then22 ], [ %t246, %else23 ]
  %t303 = phi { i8**, i64 }* [ null, %then22 ], [ %t300, %else23 ]
  store i1 %t301, i1* %l8
  store double %t302, double* %l12
  store { i8**, i64 }* %t303, { i8**, i64 }** %l1
  br label %merge18
merge18:
  %t304 = phi i1 [ 1, %then16 ], [ %t185, %else17 ]
  %t305 = phi double [ %t217, %then16 ], [ %t189, %else17 ]
  %t306 = phi { i8**, i64 }* [ null, %then16 ], [ null, %else17 ]
  %t307 = phi i1 [ %t186, %then16 ], [ 1, %else17 ]
  %t308 = phi double [ %t190, %then16 ], [ %t273, %else17 ]
  store i1 %t304, i1* %l7
  store double %t305, double* %l11
  store { i8**, i64 }* %t306, { i8**, i64 }** %l1
  store i1 %t307, i1* %l8
  store double %t308, double* %l12
  br label %merge12
merge12:
  %t309 = phi i1 [ 1, %then10 ], [ %t128, %else11 ]
  %t310 = phi double [ %t161, %then10 ], [ %t132, %else11 ]
  %t311 = phi { i8**, i64 }* [ null, %then10 ], [ null, %else11 ]
  %t312 = phi i1 [ %t129, %then10 ], [ 1, %else11 ]
  %t313 = phi double [ %t133, %then10 ], [ %t217, %else11 ]
  %t314 = phi i1 [ %t130, %then10 ], [ 1, %else11 ]
  %t315 = phi double [ %t134, %then10 ], [ %t273, %else11 ]
  store i1 %t309, i1* %l6
  store double %t310, double* %l10
  store { i8**, i64 }* %t311, { i8**, i64 }** %l1
  store i1 %t312, i1* %l7
  store double %t313, double* %l11
  store i1 %t314, i1* %l8
  store double %t315, double* %l12
  br label %merge6
merge6:
  %t316 = phi i1 [ 1, %then4 ], [ %t71, %else5 ]
  %t317 = phi double [ %t105, %then4 ], [ %t75, %else5 ]
  %t318 = phi { i8**, i64 }* [ null, %then4 ], [ null, %else5 ]
  %t319 = phi i1 [ %t72, %then4 ], [ 1, %else5 ]
  %t320 = phi double [ %t76, %then4 ], [ %t161, %else5 ]
  %t321 = phi i1 [ %t73, %then4 ], [ 1, %else5 ]
  %t322 = phi double [ %t77, %then4 ], [ %t217, %else5 ]
  %t323 = phi i1 [ %t74, %then4 ], [ 1, %else5 ]
  %t324 = phi double [ %t78, %then4 ], [ %t273, %else5 ]
  store i1 %t316, i1* %l5
  store double %t317, double* %l9
  store { i8**, i64 }* %t318, { i8**, i64 }** %l1
  store i1 %t319, i1* %l6
  store double %t320, double* %l10
  store i1 %t321, i1* %l7
  store double %t322, double* %l11
  store i1 %t323, i1* %l8
  store double %t324, double* %l12
  %t325 = load double, double* %l13
  %t326 = sitofp i64 1 to double
  %t327 = fadd double %t325, %t326
  store double %t327, double* %l13
  br label %loop.latch2
loop.latch2:
  %t328 = load i1, i1* %l5
  %t329 = load double, double* %l9
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t331 = load i1, i1* %l6
  %t332 = load double, double* %l10
  %t333 = load i1, i1* %l7
  %t334 = load double, double* %l11
  %t335 = load i1, i1* %l8
  %t336 = load double, double* %l12
  %t337 = load double, double* %l13
  br label %loop.header0
afterloop3:
  %t352 = load i1, i1* %l5
  br label %logical_and_entry_351

logical_and_entry_351:
  br i1 %t352, label %logical_and_right_351, label %logical_and_merge_351

logical_and_right_351:
  %t353 = load i1, i1* %l6
  br label %logical_and_right_end_351

logical_and_right_end_351:
  br label %logical_and_merge_351

logical_and_merge_351:
  %t354 = phi i1 [ false, %logical_and_entry_351 ], [ %t353, %logical_and_right_end_351 ]
  br label %logical_and_entry_350

logical_and_entry_350:
  br i1 %t354, label %logical_and_right_350, label %logical_and_merge_350

logical_and_right_350:
  %t355 = load i1, i1* %l7
  br label %logical_and_right_end_350

logical_and_right_end_350:
  br label %logical_and_merge_350

logical_and_merge_350:
  %t356 = phi i1 [ false, %logical_and_entry_350 ], [ %t355, %logical_and_right_end_350 ]
  br label %logical_and_entry_349

logical_and_entry_349:
  br i1 %t356, label %logical_and_right_349, label %logical_and_merge_349

logical_and_right_349:
  %t357 = load i1, i1* %l8
  br label %logical_and_right_end_349

logical_and_right_end_349:
  br label %logical_and_merge_349

logical_and_merge_349:
  %t358 = phi i1 [ false, %logical_and_entry_349 ], [ %t357, %logical_and_right_end_349 ]
  br label %logical_and_entry_348

logical_and_entry_348:
  br i1 %t358, label %logical_and_right_348, label %logical_and_merge_348

logical_and_right_348:
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  store double 0.0, double* %l23
  %t360 = load i8*, i8** %l4
  %t361 = insertvalue %NativeEnumVariantLayout undef, i8* %t360, 0
  %t362 = load double, double* %l9
  %t363 = insertvalue %NativeEnumVariantLayout %t361, double %t362, 1
  %t364 = load double, double* %l10
  %t365 = insertvalue %NativeEnumVariantLayout %t363, double %t364, 2
  %t366 = load double, double* %l11
  %t367 = insertvalue %NativeEnumVariantLayout %t365, double %t366, 3
  %t368 = load double, double* %l12
  %t369 = insertvalue %NativeEnumVariantLayout %t367, double %t368, 4
  %t370 = alloca [0 x double]
  %t371 = getelementptr [0 x double], [0 x double]* %t370, i32 0, i32 0
  %t372 = alloca { double*, i64 }
  %t373 = getelementptr { double*, i64 }, { double*, i64 }* %t372, i32 0, i32 0
  store double* %t371, double** %t373
  %t374 = getelementptr { double*, i64 }, { double*, i64 }* %t372, i32 0, i32 1
  store i64 0, i64* %t374
  %t375 = insertvalue %NativeEnumVariantLayout %t369, { i8**, i64 }* null, 5
  store %NativeEnumVariantLayout %t375, %NativeEnumVariantLayout* %l24
  %t376 = load double, double* %l23
  %t377 = fcmp one double %t376, 0.0
  %t378 = insertvalue %EnumLayoutVariantParse undef, i1 %t377, 0
  %t379 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t380 = insertvalue %EnumLayoutVariantParse %t378, i8* null, 1
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = insertvalue %EnumLayoutVariantParse %t380, { i8**, i64 }* %t381, 2
  ret %EnumLayoutVariantParse %t382
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
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 0, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 0
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l4
  %t27 = load i8*, i8** %l4
  %s28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.28, i32 0, i32 0
  %t29 = call double @index_of(i8* %t27, i8* %s28)
  store double %t29, double* %l5
  %t31 = load double, double* %l5
  %t32 = sitofp i64 0 to double
  %t33 = fcmp ole double %t31, %t32
  br label %logical_or_entry_30

logical_or_entry_30:
  br i1 %t33, label %logical_or_merge_30, label %logical_or_right_30

logical_or_right_30:
  %t34 = load double, double* %l5
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  %t37 = load i8*, i8** %l4
  %t38 = load i8*, i8** %l4
  %t39 = load double, double* %l5
  %t40 = call double @substring(i8* %t38, i64 0, double %t39)
  store double %t40, double* %l6
  %t41 = load i8*, i8** %l4
  %t42 = load double, double* %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = load i8*, i8** %l4
  store double 0.0, double* %l7
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.46, i32 0, i32 0
  store i8* %s46, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l12
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l13
  %t49 = sitofp i64 0 to double
  store double %t49, double* %l14
  %t50 = sitofp i64 1 to double
  store double %t50, double* %l15
  %t51 = load i8*, i8** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load i8*, i8** %l4
  %t56 = load double, double* %l5
  %t57 = load double, double* %l6
  %t58 = load double, double* %l7
  %t59 = load i8*, i8** %l8
  %t60 = load i1, i1* %l9
  %t61 = load i1, i1* %l10
  %t62 = load i1, i1* %l11
  %t63 = load double, double* %l12
  %t64 = load double, double* %l13
  %t65 = load double, double* %l14
  %t66 = load double, double* %l15
  br label %loop.header0
loop.header0:
  %t328 = phi i8* [ %t59, %entry ], [ %t319, %loop.latch2 ]
  %t329 = phi i1 [ %t60, %entry ], [ %t320, %loop.latch2 ]
  %t330 = phi double [ %t63, %entry ], [ %t321, %loop.latch2 ]
  %t331 = phi { i8**, i64 }* [ %t52, %entry ], [ %t322, %loop.latch2 ]
  %t332 = phi i1 [ %t61, %entry ], [ %t323, %loop.latch2 ]
  %t333 = phi double [ %t64, %entry ], [ %t324, %loop.latch2 ]
  %t334 = phi i1 [ %t62, %entry ], [ %t325, %loop.latch2 ]
  %t335 = phi double [ %t65, %entry ], [ %t326, %loop.latch2 ]
  %t336 = phi double [ %t66, %entry ], [ %t327, %loop.latch2 ]
  store i8* %t328, i8** %l8
  store i1 %t329, i1* %l9
  store double %t330, double* %l12
  store { i8**, i64 }* %t331, { i8**, i64 }** %l1
  store i1 %t332, i1* %l10
  store double %t333, double* %l13
  store i1 %t334, i1* %l11
  store double %t335, double* %l14
  store double %t336, double* %l15
  br label %loop.body1
loop.body1:
  %t67 = load double, double* %l15
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t70 = load double, double* %l15
  %t71 = load { i8**, i64 }, { i8**, i64 }* %t69
  %t72 = extractvalue { i8**, i64 } %t71, 0
  %t73 = extractvalue { i8**, i64 } %t71, 1
  %t74 = icmp uge i64 %t70, %t73
  ; bounds check: %t74 (if true, out of bounds)
  %t75 = getelementptr i8*, i8** %t72, i64 %t70
  %t76 = load i8*, i8** %t75
  store i8* %t76, i8** %l16
  %t77 = load i8*, i8** %l16
  %s78 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.78, i32 0, i32 0
  %t79 = call i1 @starts_with(i8* %t77, i8* %s78)
  %t80 = load i8*, i8** %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t84 = load i8*, i8** %l4
  %t85 = load double, double* %l5
  %t86 = load double, double* %l6
  %t87 = load double, double* %l7
  %t88 = load i8*, i8** %l8
  %t89 = load i1, i1* %l9
  %t90 = load i1, i1* %l10
  %t91 = load i1, i1* %l11
  %t92 = load double, double* %l12
  %t93 = load double, double* %l13
  %t94 = load double, double* %l14
  %t95 = load double, double* %l15
  %t96 = load i8*, i8** %l16
  br i1 %t79, label %then4, label %else5
then4:
  %t97 = load i8*, i8** %l16
  %t98 = load i8*, i8** %l16
  br label %merge6
else5:
  %t99 = load i8*, i8** %l16
  %s100 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t106 = load i8*, i8** %l4
  %t107 = load double, double* %l5
  %t108 = load double, double* %l6
  %t109 = load double, double* %l7
  %t110 = load i8*, i8** %l8
  %t111 = load i1, i1* %l9
  %t112 = load i1, i1* %l10
  %t113 = load i1, i1* %l11
  %t114 = load double, double* %l12
  %t115 = load double, double* %l13
  %t116 = load double, double* %l14
  %t117 = load double, double* %l15
  %t118 = load i8*, i8** %l16
  br i1 %t101, label %then7, label %else8
then7:
  %t119 = load i8*, i8** %l16
  %t120 = load i8*, i8** %l16
  store double 0.0, double* %l17
  %t121 = load double, double* %l17
  %t122 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t122, %NumberParseResult* %l18
  %t123 = load %NumberParseResult, %NumberParseResult* %l18
  %t124 = extractvalue %NumberParseResult %t123, 0
  %t125 = load i8*, i8** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t129 = load i8*, i8** %l4
  %t130 = load double, double* %l5
  %t131 = load double, double* %l6
  %t132 = load double, double* %l7
  %t133 = load i8*, i8** %l8
  %t134 = load i1, i1* %l9
  %t135 = load i1, i1* %l10
  %t136 = load i1, i1* %l11
  %t137 = load double, double* %l12
  %t138 = load double, double* %l13
  %t139 = load double, double* %l14
  %t140 = load double, double* %l15
  %t141 = load i8*, i8** %l16
  %t142 = load double, double* %l17
  %t143 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t124, label %then10, label %else11
then10:
  store i1 1, i1* %l9
  %t144 = load %NumberParseResult, %NumberParseResult* %l18
  %t145 = extractvalue %NumberParseResult %t144, 1
  store double %t145, double* %l12
  br label %merge12
else11:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s147 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.147, i32 0, i32 0
  %t148 = add i8* %s147, %enum_name
  %s149 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.149, i32 0, i32 0
  %t150 = add i8* %t148, %s149
  %t151 = load i8*, i8** %l4
  %t152 = add i8* %t150, %t151
  %s153 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.153, i32 0, i32 0
  %t154 = add i8* %t152, %s153
  %t155 = load double, double* %l17
  br label %merge12
merge12:
  %t156 = phi i1 [ 1, %then10 ], [ %t134, %else11 ]
  %t157 = phi double [ %t145, %then10 ], [ %t137, %else11 ]
  %t158 = phi { i8**, i64 }* [ %t126, %then10 ], [ null, %else11 ]
  store i1 %t156, i1* %l9
  store double %t157, double* %l12
  store { i8**, i64 }* %t158, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t159 = load i8*, i8** %l16
  %s160 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.160, i32 0, i32 0
  %t161 = call i1 @starts_with(i8* %t159, i8* %s160)
  %t162 = load i8*, i8** %l0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t164 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t166 = load i8*, i8** %l4
  %t167 = load double, double* %l5
  %t168 = load double, double* %l6
  %t169 = load double, double* %l7
  %t170 = load i8*, i8** %l8
  %t171 = load i1, i1* %l9
  %t172 = load i1, i1* %l10
  %t173 = load i1, i1* %l11
  %t174 = load double, double* %l12
  %t175 = load double, double* %l13
  %t176 = load double, double* %l14
  %t177 = load double, double* %l15
  %t178 = load i8*, i8** %l16
  br i1 %t161, label %then13, label %else14
then13:
  %t179 = load i8*, i8** %l16
  %t180 = load i8*, i8** %l16
  store double 0.0, double* %l19
  %t181 = load double, double* %l19
  %t182 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t182, %NumberParseResult* %l20
  %t183 = load %NumberParseResult, %NumberParseResult* %l20
  %t184 = extractvalue %NumberParseResult %t183, 0
  %t185 = load i8*, i8** %l0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t189 = load i8*, i8** %l4
  %t190 = load double, double* %l5
  %t191 = load double, double* %l6
  %t192 = load double, double* %l7
  %t193 = load i8*, i8** %l8
  %t194 = load i1, i1* %l9
  %t195 = load i1, i1* %l10
  %t196 = load i1, i1* %l11
  %t197 = load double, double* %l12
  %t198 = load double, double* %l13
  %t199 = load double, double* %l14
  %t200 = load double, double* %l15
  %t201 = load i8*, i8** %l16
  %t202 = load double, double* %l19
  %t203 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t184, label %then16, label %else17
then16:
  store i1 1, i1* %l10
  %t204 = load %NumberParseResult, %NumberParseResult* %l20
  %t205 = extractvalue %NumberParseResult %t204, 1
  store double %t205, double* %l13
  br label %merge18
else17:
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s207 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.207, i32 0, i32 0
  %t208 = add i8* %s207, %enum_name
  %s209 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.209, i32 0, i32 0
  %t210 = add i8* %t208, %s209
  %t211 = load i8*, i8** %l4
  %t212 = add i8* %t210, %t211
  %s213 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.213, i32 0, i32 0
  %t214 = add i8* %t212, %s213
  %t215 = load double, double* %l19
  br label %merge18
merge18:
  %t216 = phi i1 [ 1, %then16 ], [ %t195, %else17 ]
  %t217 = phi double [ %t205, %then16 ], [ %t198, %else17 ]
  %t218 = phi { i8**, i64 }* [ %t186, %then16 ], [ null, %else17 ]
  store i1 %t216, i1* %l10
  store double %t217, double* %l13
  store { i8**, i64 }* %t218, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t219 = load i8*, i8** %l16
  %s220 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.220, i32 0, i32 0
  %t221 = call i1 @starts_with(i8* %t219, i8* %s220)
  %t222 = load i8*, i8** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t226 = load i8*, i8** %l4
  %t227 = load double, double* %l5
  %t228 = load double, double* %l6
  %t229 = load double, double* %l7
  %t230 = load i8*, i8** %l8
  %t231 = load i1, i1* %l9
  %t232 = load i1, i1* %l10
  %t233 = load i1, i1* %l11
  %t234 = load double, double* %l12
  %t235 = load double, double* %l13
  %t236 = load double, double* %l14
  %t237 = load double, double* %l15
  %t238 = load i8*, i8** %l16
  br i1 %t221, label %then19, label %else20
then19:
  %t239 = load i8*, i8** %l16
  %t240 = load i8*, i8** %l16
  store double 0.0, double* %l21
  %t241 = load double, double* %l21
  %t242 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t242, %NumberParseResult* %l22
  %t243 = load %NumberParseResult, %NumberParseResult* %l22
  %t244 = extractvalue %NumberParseResult %t243, 0
  %t245 = load i8*, i8** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t249 = load i8*, i8** %l4
  %t250 = load double, double* %l5
  %t251 = load double, double* %l6
  %t252 = load double, double* %l7
  %t253 = load i8*, i8** %l8
  %t254 = load i1, i1* %l9
  %t255 = load i1, i1* %l10
  %t256 = load i1, i1* %l11
  %t257 = load double, double* %l12
  %t258 = load double, double* %l13
  %t259 = load double, double* %l14
  %t260 = load double, double* %l15
  %t261 = load i8*, i8** %l16
  %t262 = load double, double* %l21
  %t263 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t244, label %then22, label %else23
then22:
  store i1 1, i1* %l11
  %t264 = load %NumberParseResult, %NumberParseResult* %l22
  %t265 = extractvalue %NumberParseResult %t264, 1
  store double %t265, double* %l14
  br label %merge24
else23:
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s267 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.267, i32 0, i32 0
  %t268 = add i8* %s267, %enum_name
  %s269 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.269, i32 0, i32 0
  %t270 = add i8* %t268, %s269
  %t271 = load i8*, i8** %l4
  %t272 = add i8* %t270, %t271
  %s273 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.273, i32 0, i32 0
  %t274 = add i8* %t272, %s273
  %t275 = load double, double* %l21
  br label %merge24
merge24:
  %t276 = phi i1 [ 1, %then22 ], [ %t256, %else23 ]
  %t277 = phi double [ %t265, %then22 ], [ %t259, %else23 ]
  %t278 = phi { i8**, i64 }* [ %t246, %then22 ], [ null, %else23 ]
  store i1 %t276, i1* %l11
  store double %t277, double* %l14
  store { i8**, i64 }* %t278, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s280 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.280, i32 0, i32 0
  %t281 = add i8* %s280, %enum_name
  %s282 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.282, i32 0, i32 0
  %t283 = add i8* %t281, %s282
  %t284 = load i8*, i8** %l4
  %t285 = add i8* %t283, %t284
  %s286 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.286, i32 0, i32 0
  %t287 = add i8* %t285, %s286
  %t288 = load i8*, i8** %l16
  %t289 = add i8* %t287, %t288
  %s290 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.290, i32 0, i32 0
  %t291 = add i8* %t289, %s290
  %t292 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t279, i8* %t291)
  store { i8**, i64 }* %t292, { i8**, i64 }** %l1
  br label %merge21
merge21:
  %t293 = phi i1 [ 1, %then19 ], [ %t233, %else20 ]
  %t294 = phi double [ %t265, %then19 ], [ %t236, %else20 ]
  %t295 = phi { i8**, i64 }* [ null, %then19 ], [ %t292, %else20 ]
  store i1 %t293, i1* %l11
  store double %t294, double* %l14
  store { i8**, i64 }* %t295, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t296 = phi i1 [ 1, %then13 ], [ %t172, %else14 ]
  %t297 = phi double [ %t205, %then13 ], [ %t175, %else14 ]
  %t298 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t299 = phi i1 [ %t173, %then13 ], [ 1, %else14 ]
  %t300 = phi double [ %t176, %then13 ], [ %t265, %else14 ]
  store i1 %t296, i1* %l10
  store double %t297, double* %l13
  store { i8**, i64 }* %t298, { i8**, i64 }** %l1
  store i1 %t299, i1* %l11
  store double %t300, double* %l14
  br label %merge9
merge9:
  %t301 = phi i1 [ 1, %then7 ], [ %t111, %else8 ]
  %t302 = phi double [ %t145, %then7 ], [ %t114, %else8 ]
  %t303 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t304 = phi i1 [ %t112, %then7 ], [ 1, %else8 ]
  %t305 = phi double [ %t115, %then7 ], [ %t205, %else8 ]
  %t306 = phi i1 [ %t113, %then7 ], [ 1, %else8 ]
  %t307 = phi double [ %t116, %then7 ], [ %t265, %else8 ]
  store i1 %t301, i1* %l9
  store double %t302, double* %l12
  store { i8**, i64 }* %t303, { i8**, i64 }** %l1
  store i1 %t304, i1* %l10
  store double %t305, double* %l13
  store i1 %t306, i1* %l11
  store double %t307, double* %l14
  br label %merge6
merge6:
  %t308 = phi i8* [ null, %then4 ], [ %t88, %else5 ]
  %t309 = phi i1 [ %t89, %then4 ], [ 1, %else5 ]
  %t310 = phi double [ %t92, %then4 ], [ %t145, %else5 ]
  %t311 = phi { i8**, i64 }* [ %t81, %then4 ], [ null, %else5 ]
  %t312 = phi i1 [ %t90, %then4 ], [ 1, %else5 ]
  %t313 = phi double [ %t93, %then4 ], [ %t205, %else5 ]
  %t314 = phi i1 [ %t91, %then4 ], [ 1, %else5 ]
  %t315 = phi double [ %t94, %then4 ], [ %t265, %else5 ]
  store i8* %t308, i8** %l8
  store i1 %t309, i1* %l9
  store double %t310, double* %l12
  store { i8**, i64 }* %t311, { i8**, i64 }** %l1
  store i1 %t312, i1* %l10
  store double %t313, double* %l13
  store i1 %t314, i1* %l11
  store double %t315, double* %l14
  %t316 = load double, double* %l15
  %t317 = sitofp i64 1 to double
  %t318 = fadd double %t316, %t317
  store double %t318, double* %l15
  br label %loop.latch2
loop.latch2:
  %t319 = load i8*, i8** %l8
  %t320 = load i1, i1* %l9
  %t321 = load double, double* %l12
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t323 = load i1, i1* %l10
  %t324 = load double, double* %l13
  %t325 = load i1, i1* %l11
  %t326 = load double, double* %l14
  %t327 = load double, double* %l15
  br label %loop.header0
afterloop3:
  %t337 = load i8*, i8** %l8
  %t342 = load i8*, i8** %l8
  store double 0.0, double* %l23
  %t343 = load double, double* %l7
  %t344 = insertvalue %NativeStructLayoutField undef, i8* null, 0
  %t345 = load i8*, i8** %l8
  %t346 = insertvalue %NativeStructLayoutField %t344, i8* %t345, 1
  %t347 = load double, double* %l12
  %t348 = insertvalue %NativeStructLayoutField %t346, double %t347, 2
  %t349 = load double, double* %l13
  %t350 = insertvalue %NativeStructLayoutField %t348, double %t349, 3
  %t351 = load double, double* %l14
  %t352 = insertvalue %NativeStructLayoutField %t350, double %t351, 4
  store %NativeStructLayoutField %t352, %NativeStructLayoutField* %l24
  %t353 = load double, double* %l23
  %t354 = fcmp one double %t353, 0.0
  %t355 = insertvalue %EnumLayoutPayloadParse undef, i1 %t354, 0
  %t356 = load double, double* %l6
  %t357 = insertvalue %EnumLayoutPayloadParse %t355, i8* null, 1
  %t358 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t359 = insertvalue %EnumLayoutPayloadParse %t357, i8* null, 2
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t361 = insertvalue %EnumLayoutPayloadParse %t359, { i8**, i64 }* %t360, 3
  ret %EnumLayoutPayloadParse %t361
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
  %t47 = phi double [ %t30, %entry ], [ %t46, %loop.latch6 ]
  store double %t47, double* %l2
  br label %loop.body5
loop.body5:
  %t32 = load double, double* %l2
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load double, double* %l2
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t34
  %t37 = extractvalue { i8**, i64 } %t36, 0
  %t38 = extractvalue { i8**, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  %t40 = getelementptr i8*, i8** %t37, i64 %t35
  %t41 = load i8*, i8** %t40
  store i8* %t41, i8** %l5
  %t42 = load i8*, i8** %l5
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l2
  br label %loop.latch6
loop.latch6:
  %t46 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t48
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
  %l29 = alloca double
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
  %t408 = phi double [ %t21, %entry ], [ %t404, %loop.latch2 ]
  %t409 = phi { i8**, i64 }* [ %t18, %entry ], [ %t405, %loop.latch2 ]
  %t410 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t406, %loop.latch2 ]
  %t411 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t407, %loop.latch2 ]
  store double %t408, double* %l4
  store { i8**, i64 }* %t409, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t410, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t411, { %NativeEnum*, i64 }** %l3
  br label %loop.body1
loop.body1:
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
  store i8* %t31, i8** %l5
  %t32 = load i8*, i8** %l5
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l6
  %t34 = load i8*, i8** %l6
  %t35 = load i8*, i8** %l6
  %s36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.36, i32 0, i32 0
  %t37 = call i1 @starts_with(i8* %t35, i8* %s36)
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t41 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t42 = load double, double* %l4
  %t43 = load i8*, i8** %l5
  %t44 = load i8*, i8** %l6
  br i1 %t37, label %then4, label %merge5
then4:
  %t45 = load double, double* %l4
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l4
  br label %loop.latch2
merge5:
  %t48 = load i8*, i8** %l6
  %s49 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.49, i32 0, i32 0
  %t50 = call i1 @starts_with(i8* %t48, i8* %s49)
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t54 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t55 = load double, double* %l4
  %t56 = load i8*, i8** %l5
  %t57 = load i8*, i8** %l6
  br i1 %t50, label %then6, label %merge7
then6:
  %t58 = load double, double* %l4
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l4
  br label %loop.latch2
merge7:
  %t61 = load i8*, i8** %l6
  %s62 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.62, i32 0, i32 0
  %t63 = call i1 @starts_with(i8* %t61, i8* %s62)
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t67 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t68 = load double, double* %l4
  %t69 = load i8*, i8** %l5
  %t70 = load i8*, i8** %l6
  br i1 %t63, label %then8, label %merge9
then8:
  %t71 = load i8*, i8** %l6
  %s72 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.72, i32 0, i32 0
  %t73 = call i8* @strip_prefix(i8* %t71, i8* %s72)
  store i8* %t73, i8** %l7
  %t74 = load i8*, i8** %l7
  %s75 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.75, i32 0, i32 0
  %t76 = call i8* @strip_prefix(i8* %t74, i8* %s75)
  store i8* %t76, i8** %l8
  %t77 = load i8*, i8** %l8
  %t78 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t77)
  store %StructLayoutHeaderParse %t78, %StructLayoutHeaderParse* %l9
  %t79 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t80 = extractvalue %StructLayoutHeaderParse %t79, 4
  %t81 = call double @diagnosticsconcat({ i8**, i64 }* %t80)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t82 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t83 = extractvalue %StructLayoutHeaderParse %t82, 0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t87 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t88 = load double, double* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  %t91 = load i8*, i8** %l7
  %t92 = load i8*, i8** %l8
  %t93 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t83, label %then10, label %merge11
then10:
  %t94 = alloca [0 x double]
  %t95 = getelementptr [0 x double], [0 x double]* %t94, i32 0, i32 0
  %t96 = alloca { double*, i64 }
  %t97 = getelementptr { double*, i64 }, { double*, i64 }* %t96, i32 0, i32 0
  store double* %t95, double** %t97
  %t98 = getelementptr { double*, i64 }, { double*, i64 }* %t96, i32 0, i32 1
  store i64 0, i64* %t98
  store { %NativeStructLayoutField*, i64 }* null, { %NativeStructLayoutField*, i64 }** %l10
  %t99 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t100 = extractvalue %StructLayoutHeaderParse %t99, 1
  store i8* %t100, i8** %l11
  %t101 = load double, double* %l4
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  store double %t103, double* %l4
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t107 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t108 = load double, double* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i8*, i8** %l6
  %t111 = load i8*, i8** %l7
  %t112 = load i8*, i8** %l8
  %t113 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t114 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t115 = load i8*, i8** %l11
  br label %loop.header12
loop.header12:
  %t187 = phi i8* [ %t111, %then10 ], [ %t183, %loop.latch14 ]
  %t188 = phi { i8**, i64 }* [ %t105, %then10 ], [ %t184, %loop.latch14 ]
  %t189 = phi { %NativeStructLayoutField*, i64 }* [ %t114, %then10 ], [ %t185, %loop.latch14 ]
  %t190 = phi double [ %t108, %then10 ], [ %t186, %loop.latch14 ]
  store i8* %t187, i8** %l7
  store { i8**, i64 }* %t188, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t189, { %NativeStructLayoutField*, i64 }** %l10
  store double %t190, double* %l4
  br label %loop.body13
loop.body13:
  %t116 = load double, double* %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load double, double* %l4
  %t120 = load { i8**, i64 }, { i8**, i64 }* %t118
  %t121 = extractvalue { i8**, i64 } %t120, 0
  %t122 = extractvalue { i8**, i64 } %t120, 1
  %t123 = icmp uge i64 %t119, %t122
  ; bounds check: %t123 (if true, out of bounds)
  %t124 = getelementptr i8*, i8** %t121, i64 %t119
  %t125 = load i8*, i8** %t124
  %t126 = call i8* @trim_text(i8* %t125)
  store i8* %t126, i8** %l12
  %t127 = load i8*, i8** %l12
  %t128 = load i8*, i8** %l12
  %s129 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.129, i32 0, i32 0
  %t130 = call double @starts_with(i8* %t128, i8* %s129)
  %t131 = fcmp one double %t130, 0.0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t135 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t136 = load double, double* %l4
  %t137 = load i8*, i8** %l5
  %t138 = load i8*, i8** %l6
  %t139 = load i8*, i8** %l7
  %t140 = load i8*, i8** %l8
  %t141 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t142 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t143 = load i8*, i8** %l11
  %t144 = load i8*, i8** %l12
  br i1 %t131, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t145 = load i8*, i8** %l12
  %s146 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.146, i32 0, i32 0
  %t147 = call i8* @strip_prefix(i8* %t145, i8* %s146)
  store i8* %t147, i8** %l13
  %t148 = load i8*, i8** %l7
  %s149 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.149, i32 0, i32 0
  %t150 = call i8* @strip_prefix(i8* %t148, i8* %s149)
  store i8* %t150, i8** %l14
  %t151 = load i8*, i8** %l14
  %t152 = load i8*, i8** %l11
  %t153 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t151, i8* %t152)
  store %StructLayoutFieldParse %t153, %StructLayoutFieldParse* %l15
  %t154 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t155 = extractvalue %StructLayoutFieldParse %t154, 2
  %t156 = call double @diagnosticsconcat({ i8**, i64 }* %t155)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t157 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t158 = extractvalue %StructLayoutFieldParse %t157, 0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t162 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t163 = load double, double* %l4
  %t164 = load i8*, i8** %l5
  %t165 = load i8*, i8** %l6
  %t166 = load i8*, i8** %l7
  %t167 = load i8*, i8** %l8
  %t168 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t169 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t170 = load i8*, i8** %l11
  %t171 = load i8*, i8** %l12
  %t172 = load i8*, i8** %l13
  %t173 = load i8*, i8** %l14
  %t174 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t158, label %then18, label %merge19
then18:
  %t175 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t176 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t177 = extractvalue %StructLayoutFieldParse %t176, 1
  %t178 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t175, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t178, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge19
merge19:
  %t179 = phi { %NativeStructLayoutField*, i64 }* [ %t178, %then18 ], [ %t169, %loop.body13 ]
  store { %NativeStructLayoutField*, i64 }* %t179, { %NativeStructLayoutField*, i64 }** %l10
  %t180 = load double, double* %l4
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l4
  br label %loop.latch14
loop.latch14:
  %t183 = load i8*, i8** %l7
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t186 = load double, double* %l4
  br label %loop.header12
afterloop15:
  store double 0.0, double* %l16
  %t191 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t192 = load double, double* %l16
  %t193 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t191, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t193, { %NativeStruct*, i64 }** %l2
  br label %merge11
merge11:
  %t194 = phi double [ %t103, %then10 ], [ %t88, %then8 ]
  %t195 = phi i8* [ %t147, %then10 ], [ %t91, %then8 ]
  %t196 = phi { i8**, i64 }* [ null, %then10 ], [ %t85, %then8 ]
  %t197 = phi double [ %t182, %then10 ], [ %t88, %then8 ]
  %t198 = phi { %NativeStruct*, i64 }* [ %t193, %then10 ], [ %t86, %then8 ]
  store double %t194, double* %l4
  store i8* %t195, i8** %l7
  store { i8**, i64 }* %t196, { i8**, i64 }** %l1
  store double %t197, double* %l4
  store { %NativeStruct*, i64 }* %t198, { %NativeStruct*, i64 }** %l2
  %t199 = load double, double* %l4
  %t200 = sitofp i64 1 to double
  %t201 = fadd double %t199, %t200
  store double %t201, double* %l4
  br label %loop.latch2
merge9:
  %t202 = load i8*, i8** %l6
  %s203 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.203, i32 0, i32 0
  %t204 = call i1 @starts_with(i8* %t202, i8* %s203)
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t207 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t208 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t209 = load double, double* %l4
  %t210 = load i8*, i8** %l5
  %t211 = load i8*, i8** %l6
  br i1 %t204, label %then20, label %merge21
then20:
  %t212 = load i8*, i8** %l6
  %s213 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.213, i32 0, i32 0
  %t214 = call i8* @strip_prefix(i8* %t212, i8* %s213)
  store i8* %t214, i8** %l17
  %t215 = load i8*, i8** %l17
  %s216 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.216, i32 0, i32 0
  %t217 = call i8* @strip_prefix(i8* %t215, i8* %s216)
  store i8* %t217, i8** %l18
  %t218 = load i8*, i8** %l18
  %t219 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t218)
  store %EnumLayoutHeaderParse %t219, %EnumLayoutHeaderParse* %l19
  %t220 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t221 = extractvalue %EnumLayoutHeaderParse %t220, 7
  %t222 = call double @diagnosticsconcat({ i8**, i64 }* %t221)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t223 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t224 = extractvalue %EnumLayoutHeaderParse %t223, 0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t227 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t228 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t229 = load double, double* %l4
  %t230 = load i8*, i8** %l5
  %t231 = load i8*, i8** %l6
  %t232 = load i8*, i8** %l17
  %t233 = load i8*, i8** %l18
  %t234 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t224, label %then22, label %else23
then22:
  %t235 = alloca [0 x double]
  %t236 = getelementptr [0 x double], [0 x double]* %t235, i32 0, i32 0
  %t237 = alloca { double*, i64 }
  %t238 = getelementptr { double*, i64 }, { double*, i64 }* %t237, i32 0, i32 0
  store double* %t236, double** %t238
  %t239 = getelementptr { double*, i64 }, { double*, i64 }* %t237, i32 0, i32 1
  store i64 0, i64* %t239
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l20
  %t240 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t241 = extractvalue %EnumLayoutHeaderParse %t240, 1
  store i8* %t241, i8** %l21
  %t242 = load double, double* %l4
  %t243 = sitofp i64 1 to double
  %t244 = fadd double %t242, %t243
  store double %t244, double* %l4
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t248 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t249 = load double, double* %l4
  %t250 = load i8*, i8** %l5
  %t251 = load i8*, i8** %l6
  %t252 = load i8*, i8** %l17
  %t253 = load i8*, i8** %l18
  %t254 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t255 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t256 = load i8*, i8** %l21
  br label %loop.header25
loop.header25:
  %t387 = phi i8* [ %t252, %then22 ], [ %t383, %loop.latch27 ]
  %t388 = phi { i8**, i64 }* [ %t246, %then22 ], [ %t384, %loop.latch27 ]
  %t389 = phi { %NativeEnumVariantLayout*, i64 }* [ %t255, %then22 ], [ %t385, %loop.latch27 ]
  %t390 = phi double [ %t249, %then22 ], [ %t386, %loop.latch27 ]
  store i8* %t387, i8** %l17
  store { i8**, i64 }* %t388, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t389, { %NativeEnumVariantLayout*, i64 }** %l20
  store double %t390, double* %l4
  br label %loop.body26
loop.body26:
  %t257 = load double, double* %l4
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t260 = load double, double* %l4
  %t261 = load { i8**, i64 }, { i8**, i64 }* %t259
  %t262 = extractvalue { i8**, i64 } %t261, 0
  %t263 = extractvalue { i8**, i64 } %t261, 1
  %t264 = icmp uge i64 %t260, %t263
  ; bounds check: %t264 (if true, out of bounds)
  %t265 = getelementptr i8*, i8** %t262, i64 %t260
  %t266 = load i8*, i8** %t265
  %t267 = call i8* @trim_text(i8* %t266)
  store i8* %t267, i8** %l22
  %t268 = load i8*, i8** %l22
  %t270 = load i8*, i8** %l22
  %s271 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.271, i32 0, i32 0
  %t272 = call double @starts_with(i8* %t270, i8* %s271)
  %t273 = fcmp one double %t272, 0.0
  br label %logical_and_entry_269

logical_and_entry_269:
  br i1 %t273, label %logical_and_right_269, label %logical_and_merge_269

logical_and_right_269:
  %t274 = load i8*, i8** %l22
  %s275 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.275, i32 0, i32 0
  %t276 = call double @starts_with(i8* %t274, i8* %s275)
  %t277 = fcmp one double %t276, 0.0
  br label %logical_and_right_end_269

logical_and_right_end_269:
  br label %logical_and_merge_269

logical_and_merge_269:
  %t278 = phi i1 [ false, %logical_and_entry_269 ], [ %t277, %logical_and_right_end_269 ]
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t282 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t283 = load double, double* %l4
  %t284 = load i8*, i8** %l5
  %t285 = load i8*, i8** %l6
  %t286 = load i8*, i8** %l17
  %t287 = load i8*, i8** %l18
  %t288 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t289 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t290 = load i8*, i8** %l21
  %t291 = load i8*, i8** %l22
  br i1 %t278, label %then29, label %merge30
then29:
  br label %afterloop28
merge30:
  %t292 = load i8*, i8** %l22
  %s293 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.293, i32 0, i32 0
  %t294 = call i1 @starts_with(i8* %t292, i8* %s293)
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t298 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t299 = load double, double* %l4
  %t300 = load i8*, i8** %l5
  %t301 = load i8*, i8** %l6
  %t302 = load i8*, i8** %l17
  %t303 = load i8*, i8** %l18
  %t304 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t305 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t306 = load i8*, i8** %l21
  %t307 = load i8*, i8** %l22
  br i1 %t294, label %then31, label %else32
then31:
  %t308 = load i8*, i8** %l22
  %s309 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.309, i32 0, i32 0
  %t310 = call i8* @strip_prefix(i8* %t308, i8* %s309)
  store i8* %t310, i8** %l23
  %t311 = load i8*, i8** %l17
  %s312 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.312, i32 0, i32 0
  %t313 = call i8* @strip_prefix(i8* %t311, i8* %s312)
  store i8* %t313, i8** %l24
  %t314 = load i8*, i8** %l24
  %t315 = load i8*, i8** %l21
  %t316 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t314, i8* %t315)
  store %EnumLayoutVariantParse %t316, %EnumLayoutVariantParse* %l25
  %t317 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t318 = extractvalue %EnumLayoutVariantParse %t317, 2
  %t319 = call double @diagnosticsconcat({ i8**, i64 }* %t318)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t320 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t321 = extractvalue %EnumLayoutVariantParse %t320, 0
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
  %t335 = load i8*, i8** %l23
  %t336 = load i8*, i8** %l24
  %t337 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t321, label %then34, label %merge35
then34:
  %t338 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t339 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t340 = extractvalue %EnumLayoutVariantParse %t339, 1
  %t341 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t338, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t341, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge35
merge35:
  %t342 = phi { %NativeEnumVariantLayout*, i64 }* [ %t341, %then34 ], [ %t332, %then31 ]
  store { %NativeEnumVariantLayout*, i64 }* %t342, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge33
else32:
  %t343 = load i8*, i8** %l22
  %s344 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.344, i32 0, i32 0
  %t345 = call i1 @starts_with(i8* %t343, i8* %s344)
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t348 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t349 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t350 = load double, double* %l4
  %t351 = load i8*, i8** %l5
  %t352 = load i8*, i8** %l6
  %t353 = load i8*, i8** %l17
  %t354 = load i8*, i8** %l18
  %t355 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t356 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t357 = load i8*, i8** %l21
  %t358 = load i8*, i8** %l22
  br i1 %t345, label %then36, label %merge37
then36:
  %t359 = load i8*, i8** %l22
  %s360 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.360, i32 0, i32 0
  %t361 = call i8* @strip_prefix(i8* %t359, i8* %s360)
  store i8* %t361, i8** %l26
  %t362 = load i8*, i8** %l17
  %s363 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.363, i32 0, i32 0
  %t364 = call i8* @strip_prefix(i8* %t362, i8* %s363)
  store i8* %t364, i8** %l27
  %t365 = load i8*, i8** %l27
  %t366 = load i8*, i8** %l21
  %t367 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t365, i8* %t366)
  store %EnumLayoutPayloadParse %t367, %EnumLayoutPayloadParse* %l28
  %t368 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t369 = extractvalue %EnumLayoutPayloadParse %t368, 3
  %t370 = call double @diagnosticsconcat({ i8**, i64 }* %t369)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t372 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t373 = extractvalue %EnumLayoutPayloadParse %t372, 0
  br label %logical_and_entry_371

logical_and_entry_371:
  br i1 %t373, label %logical_and_right_371, label %logical_and_merge_371

logical_and_right_371:
  %t374 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge37
merge37:
  %t375 = phi i8* [ %t361, %then36 ], [ %t353, %else32 ]
  %t376 = phi { i8**, i64 }* [ null, %then36 ], [ %t347, %else32 ]
  store i8* %t375, i8** %l17
  store { i8**, i64 }* %t376, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t377 = phi i8* [ %t310, %then31 ], [ %t361, %else32 ]
  %t378 = phi { i8**, i64 }* [ null, %then31 ], [ null, %else32 ]
  %t379 = phi { %NativeEnumVariantLayout*, i64 }* [ %t341, %then31 ], [ %t305, %else32 ]
  store i8* %t377, i8** %l17
  store { i8**, i64 }* %t378, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t379, { %NativeEnumVariantLayout*, i64 }** %l20
  %t380 = load double, double* %l4
  %t381 = sitofp i64 1 to double
  %t382 = fadd double %t380, %t381
  store double %t382, double* %l4
  br label %loop.latch27
loop.latch27:
  %t383 = load i8*, i8** %l17
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t385 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t386 = load double, double* %l4
  br label %loop.header25
afterloop28:
  store double 0.0, double* %l29
  %t391 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t392 = load double, double* %l29
  %t393 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t391, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t393, { %NativeEnum*, i64 }** %l3
  br label %merge24
else23:
  %t394 = load double, double* %l4
  %t395 = sitofp i64 1 to double
  %t396 = fadd double %t394, %t395
  store double %t396, double* %l4
  br label %merge24
merge24:
  %t397 = phi double [ %t244, %then22 ], [ %t396, %else23 ]
  %t398 = phi i8* [ %t310, %then22 ], [ %t232, %else23 ]
  %t399 = phi { i8**, i64 }* [ null, %then22 ], [ %t226, %else23 ]
  %t400 = phi { %NativeEnum*, i64 }* [ %t393, %then22 ], [ %t228, %else23 ]
  store double %t397, double* %l4
  store i8* %t398, i8** %l17
  store { i8**, i64 }* %t399, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t400, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge21:
  %t401 = load double, double* %l4
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  store double %t403, double* %l4
  br label %loop.latch2
loop.latch2:
  %t404 = load double, double* %l4
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t407 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t412 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t413 = insertvalue %LayoutManifest undef, { i8**, i64 }* null, 0
  %t414 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t415 = insertvalue %LayoutManifest %t413, { i8**, i64 }* null, 1
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t417 = insertvalue %LayoutManifest %t415, { i8**, i64 }* %t416, 2
  ret %LayoutManifest %t417
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
  %t0 = call double @starts_with(i8* %value, i8* %prefix)
  %t1 = fcmp one double %t0, 0.0
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
