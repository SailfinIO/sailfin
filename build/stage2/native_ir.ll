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
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
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
  store double 0.0, double* %l8
  store double 0.0, double* %l9
  store double 0.0, double* %l10
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
  %t45 = load double, double* %l8
  %t46 = load double, double* %l9
  %t47 = load double, double* %l10
  %t48 = load double, double* %l11
  br label %loop.header0
loop.header0:
  %t402 = phi { i8**, i64 }* [ %t38, %entry ], [ %t397, %loop.latch2 ]
  %t403 = phi double [ %t48, %entry ], [ %t398, %loop.latch2 ]
  %t404 = phi double [ %t45, %entry ], [ %t399, %loop.latch2 ]
  %t405 = phi double [ %t46, %entry ], [ %t400, %loop.latch2 ]
  %t406 = phi double [ %t47, %entry ], [ %t401, %loop.latch2 ]
  store { i8**, i64 }* %t402, { i8**, i64 }** %l1
  store double %t403, double* %l11
  store double %t404, double* %l8
  store double %t405, double* %l9
  store double %t406, double* %l10
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
  %t73 = load double, double* %l8
  %t74 = load double, double* %l9
  %t75 = load double, double* %l10
  %t76 = load double, double* %l11
  %t77 = load i8*, i8** %l12
  %t78 = load i8*, i8** %l13
  br i1 %t64, label %then4, label %merge5
then4:
  br label %loop.latch2
merge5:
  %t79 = load i8*, i8** %l13
  %s80 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.80, i32 0, i32 0
  %t81 = call i1 @starts_with(i8* %t79, i8* %s80)
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t85 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t86 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t87 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t88 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t89 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t90 = load double, double* %l8
  %t91 = load double, double* %l9
  %t92 = load double, double* %l10
  %t93 = load double, double* %l11
  %t94 = load i8*, i8** %l12
  %t95 = load i8*, i8** %l13
  br i1 %t81, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t96 = load i8*, i8** %l13
  %s97 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.97, i32 0, i32 0
  %t98 = call i1 @starts_with(i8* %t96, i8* %s97)
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t102 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t103 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t104 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t105 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t106 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t107 = load double, double* %l8
  %t108 = load double, double* %l9
  %t109 = load double, double* %l10
  %t110 = load double, double* %l11
  %t111 = load i8*, i8** %l12
  %t112 = load i8*, i8** %l13
  br i1 %t98, label %then8, label %merge9
then8:
  %s113 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.113, i32 0, i32 0
  %t114 = load i8*, i8** %l13
  %s115 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.115, i32 0, i32 0
  %t116 = call i8* @strip_prefix(i8* %t114, i8* %s115)
  %t117 = call double @parse_import_entry(i8* %s113, i8* %t116)
  store double %t117, double* %l14
  %t118 = load double, double* %l14
  br label %loop.latch2
merge9:
  %t119 = load i8*, i8** %l13
  %s120 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i1 @starts_with(i8* %t119, i8* %s120)
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t124 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t125 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t126 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t127 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t128 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t129 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t130 = load double, double* %l8
  %t131 = load double, double* %l9
  %t132 = load double, double* %l10
  %t133 = load double, double* %l11
  %t134 = load i8*, i8** %l12
  %t135 = load i8*, i8** %l13
  br i1 %t121, label %then10, label %merge11
then10:
  %s136 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.136, i32 0, i32 0
  %t137 = load i8*, i8** %l13
  %s138 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.138, i32 0, i32 0
  %t139 = call i8* @strip_prefix(i8* %t137, i8* %s138)
  %t140 = call double @parse_import_entry(i8* %s136, i8* %t139)
  store double %t140, double* %l15
  %t141 = load double, double* %l15
  br label %loop.latch2
merge11:
  %t142 = load i8*, i8** %l13
  %s143 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.143, i32 0, i32 0
  %t144 = call i1 @starts_with(i8* %t142, i8* %s143)
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t148 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t149 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t150 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t151 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t152 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t153 = load double, double* %l8
  %t154 = load double, double* %l9
  %t155 = load double, double* %l10
  %t156 = load double, double* %l11
  %t157 = load i8*, i8** %l12
  %t158 = load i8*, i8** %l13
  br i1 %t144, label %then12, label %merge13
then12:
  %t159 = load i8*, i8** %l13
  %s160 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.160, i32 0, i32 0
  %t161 = call i8* @strip_prefix(i8* %t159, i8* %s160)
  %t162 = call double @parse_source_span(i8* %t161)
  store double %t162, double* %l16
  %t163 = load double, double* %l16
  br label %loop.latch2
merge13:
  %t164 = load i8*, i8** %l13
  %t165 = load i8*, i8** %l13
  %s166 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.166, i32 0, i32 0
  %t167 = call i1 @starts_with(i8* %t165, i8* %s166)
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t170 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t171 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t172 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t173 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t174 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t175 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t176 = load double, double* %l8
  %t177 = load double, double* %l9
  %t178 = load double, double* %l10
  %t179 = load double, double* %l11
  %t180 = load i8*, i8** %l12
  %t181 = load i8*, i8** %l13
  br i1 %t167, label %then14, label %merge15
then14:
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load double, double* %l11
  %t184 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t182, double %t183)
  store %StructParseResult %t184, %StructParseResult* %l17
  %t185 = load %StructParseResult, %StructParseResult* %l17
  %t186 = extractvalue %StructParseResult %t185, 2
  %t187 = call double @diagnosticsconcat({ i8**, i64 }* %t186)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t188 = load %StructParseResult, %StructParseResult* %l17
  %t189 = extractvalue %StructParseResult %t188, 0
  %t190 = load %StructParseResult, %StructParseResult* %l17
  %t191 = extractvalue %StructParseResult %t190, 1
  store double %t191, double* %l11
  br label %loop.latch2
merge15:
  %t192 = load i8*, i8** %l13
  %s193 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.193, i32 0, i32 0
  %t194 = call i1 @starts_with(i8* %t192, i8* %s193)
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t197 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t198 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t199 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t200 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t201 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t202 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t203 = load double, double* %l8
  %t204 = load double, double* %l9
  %t205 = load double, double* %l10
  %t206 = load double, double* %l11
  %t207 = load i8*, i8** %l12
  %t208 = load i8*, i8** %l13
  br i1 %t194, label %then16, label %merge17
then16:
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t210 = load double, double* %l11
  %t211 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t209, double %t210)
  store %InterfaceParseResult %t211, %InterfaceParseResult* %l18
  %t212 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t213 = extractvalue %InterfaceParseResult %t212, 2
  %t214 = call double @diagnosticsconcat({ i8**, i64 }* %t213)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t215 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t216 = extractvalue %InterfaceParseResult %t215, 0
  %t217 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t218 = extractvalue %InterfaceParseResult %t217, 1
  store double %t218, double* %l11
  br label %loop.latch2
merge17:
  %t219 = load i8*, i8** %l13
  %s220 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.220, i32 0, i32 0
  %t221 = call i1 @starts_with(i8* %t219, i8* %s220)
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t225 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t226 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t227 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t228 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t229 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t230 = load double, double* %l8
  %t231 = load double, double* %l9
  %t232 = load double, double* %l10
  %t233 = load double, double* %l11
  %t234 = load i8*, i8** %l12
  %t235 = load i8*, i8** %l13
  br i1 %t221, label %then18, label %merge19
then18:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load double, double* %l11
  %t238 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t236, double %t237)
  store %EnumParseResult %t238, %EnumParseResult* %l19
  %t239 = load %EnumParseResult, %EnumParseResult* %l19
  %t240 = extractvalue %EnumParseResult %t239, 2
  %t241 = call double @diagnosticsconcat({ i8**, i64 }* %t240)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t242 = load %EnumParseResult, %EnumParseResult* %l19
  %t243 = extractvalue %EnumParseResult %t242, 0
  %t244 = load %EnumParseResult, %EnumParseResult* %l19
  %t245 = extractvalue %EnumParseResult %t244, 1
  store double %t245, double* %l11
  br label %loop.latch2
merge19:
  %t246 = load i8*, i8** %l13
  %s247 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.247, i32 0, i32 0
  %t248 = call i1 @starts_with(i8* %t246, i8* %s247)
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t251 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t252 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t253 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t254 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t255 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t256 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t257 = load double, double* %l8
  %t258 = load double, double* %l9
  %t259 = load double, double* %l10
  %t260 = load double, double* %l11
  %t261 = load i8*, i8** %l12
  %t262 = load i8*, i8** %l13
  br i1 %t248, label %then20, label %merge21
then20:
  %t263 = load double, double* %l8
  br label %loop.latch2
merge21:
  %t264 = load i8*, i8** %l13
  %s265 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.265, i32 0, i32 0
  %t266 = call i1 @starts_with(i8* %t264, i8* %s265)
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t270 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t271 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t272 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t273 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t274 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t275 = load double, double* %l8
  %t276 = load double, double* %l9
  %t277 = load double, double* %l10
  %t278 = load double, double* %l11
  %t279 = load i8*, i8** %l12
  %t280 = load i8*, i8** %l13
  br i1 %t266, label %then22, label %merge23
then22:
  %t281 = load double, double* %l8
  br label %loop.latch2
merge23:
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
  %t293 = load double, double* %l8
  %t294 = load double, double* %l9
  %t295 = load double, double* %l10
  %t296 = load double, double* %l11
  %t297 = load i8*, i8** %l12
  %t298 = load i8*, i8** %l13
  br i1 %t284, label %then24, label %merge25
then24:
  %t299 = load double, double* %l8
  br label %loop.latch2
merge25:
  %t300 = load i8*, i8** %l13
  %s301 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.301, i32 0, i32 0
  %t302 = call i1 @starts_with(i8* %t300, i8* %s301)
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t305 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t306 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t307 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t308 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t309 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t310 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t311 = load double, double* %l8
  %t312 = load double, double* %l9
  %t313 = load double, double* %l10
  %t314 = load double, double* %l11
  %t315 = load i8*, i8** %l12
  %t316 = load i8*, i8** %l13
  br i1 %t302, label %then26, label %merge27
then26:
  %t317 = load double, double* %l8
  br label %loop.latch2
merge27:
  %t318 = load i8*, i8** %l13
  %t319 = load double, double* %l9
  %t320 = load double, double* %l10
  %t321 = call %InstructionParseResult @parse_instruction(i8* %t318, double %t319, double %t320)
  store %InstructionParseResult %t321, %InstructionParseResult* %l20
  %t322 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t323 = extractvalue %InstructionParseResult %t322, 0
  store { i8**, i64 }* %t323, { i8**, i64 }** %l21
  %t324 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t325 = extractvalue %InstructionParseResult %t324, 1
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t329 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t330 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t331 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t332 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t333 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t334 = load double, double* %l8
  %t335 = load double, double* %l9
  %t336 = load double, double* %l10
  %t337 = load double, double* %l11
  %t338 = load i8*, i8** %l12
  %t339 = load i8*, i8** %l13
  %t340 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t325, label %then28, label %else29
then28:
  br label %merge30
else29:
  %t342 = load double, double* %l9
  br label %merge30
merge30:
  %t343 = phi double [ 0.0, %then28 ], [ %t335, %else29 ]
  store double %t343, double* %l9
  %t344 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t345 = extractvalue %InstructionParseResult %t344, 2
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t348 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t349 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t350 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t351 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t352 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t353 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t354 = load double, double* %l8
  %t355 = load double, double* %l9
  %t356 = load double, double* %l10
  %t357 = load double, double* %l11
  %t358 = load i8*, i8** %l12
  %t359 = load i8*, i8** %l13
  %t360 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t345, label %then31, label %else32
then31:
  br label %merge33
else32:
  %t362 = load double, double* %l10
  br label %merge33
merge33:
  %t363 = phi double [ 0.0, %then31 ], [ %t356, %else32 ]
  store double %t363, double* %l10
  %t364 = load double, double* %l8
  %t365 = sitofp i64 0 to double
  store double %t365, double* %l22
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t368 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t369 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t370 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t371 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t372 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t373 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t374 = load double, double* %l8
  %t375 = load double, double* %l9
  %t376 = load double, double* %l10
  %t377 = load double, double* %l11
  %t378 = load i8*, i8** %l12
  %t379 = load i8*, i8** %l13
  %t380 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t382 = load double, double* %l22
  br label %loop.header34
loop.header34:
  %t396 = phi double [ %t374, %loop.body1 ], [ %t395, %loop.latch36 ]
  store double %t396, double* %l8
  br label %loop.body35
loop.body35:
  %t383 = load double, double* %l22
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t385 = load double, double* %l8
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t387 = load double, double* %l22
  %t388 = load { i8**, i64 }, { i8**, i64 }* %t386
  %t389 = extractvalue { i8**, i64 } %t388, 0
  %t390 = extractvalue { i8**, i64 } %t388, 1
  %t391 = icmp uge i64 %t387, %t390
  ; bounds check: %t391 (if true, out of bounds)
  %t392 = getelementptr i8*, i8** %t389, i64 %t387
  %t393 = load i8*, i8** %t392
  %t394 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store double 0.0, double* %l8
  br label %loop.latch36
loop.latch36:
  %t395 = load double, double* %l8
  br label %loop.header34
afterloop37:
  br label %loop.latch2
loop.latch2:
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t398 = load double, double* %l11
  %t399 = load double, double* %l8
  %t400 = load double, double* %l9
  %t401 = load double, double* %l10
  br label %loop.header0
afterloop3:
  %t407 = load double, double* %l8
  %t408 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t409 = insertvalue %ParseNativeResult undef, { i8**, i64 }* null, 0
  %t410 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t411 = insertvalue %ParseNativeResult %t409, { i8**, i64 }* null, 1
  %t412 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t413 = insertvalue %ParseNativeResult %t411, { i8**, i64 }* null, 2
  %t414 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t415 = insertvalue %ParseNativeResult %t413, { i8**, i64 }* null, 3
  %t416 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t417 = insertvalue %ParseNativeResult %t415, { i8**, i64 }* null, 4
  %t418 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t419 = insertvalue %ParseNativeResult %t417, { i8**, i64 }* null, 5
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t421 = insertvalue %ParseNativeResult %t419, { i8**, i64 }* %t420, 6
  ret %ParseNativeResult %t421
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t11 = sitofp i64 -1 to double
  ret double %t11
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
  %t34 = phi { %NativeEnumVariantLayout*, i64 }* [ %t6, %entry ], [ %t33, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t34, { %NativeEnumVariantLayout*, i64 }** %l0
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
  br label %loop.latch2
loop.latch2:
  %t33 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t35 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t35
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

define %InstructionParseResult @parse_instruction(i8* %line, double %span, double %value_span) {
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
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i1 @starts_with(i8* %line, i8* %s1)
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i8* @strip_prefix(i8* %line, i8* %s3)
  %t5 = call i8* @trim_text(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = alloca %NativeInstruction
  %t7 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t6, i32 0, i32 0
  store i32 3, i32* %t7
  %t8 = load i8*, i8** %l0
  %t9 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t6, i32 0, i32 1
  %t10 = bitcast [8 x i8]* %t9 to i8*
  %t11 = bitcast i8* %t10 to i8**
  store i8* %t8, i8** %t11
  %t12 = load %NativeInstruction, %NativeInstruction* %t6
  %t13 = alloca [1 x %NativeInstruction]
  %t14 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t13, i32 0, i32 0
  %t15 = getelementptr %NativeInstruction, %NativeInstruction* %t14, i64 0
  store %NativeInstruction %t12, %NativeInstruction* %t15
  %t16 = alloca { %NativeInstruction*, i64 }
  %t17 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t16, i32 0, i32 0
  store %NativeInstruction* %t14, %NativeInstruction** %t17
  %t18 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t16, i32 0, i32 1
  store i64 1, i64* %t18
  %t19 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t20 = insertvalue %InstructionParseResult %t19, i1 0, 1
  %t21 = insertvalue %InstructionParseResult %t20, i1 0, 2
  ret %InstructionParseResult %t21
merge1:
  %s22 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.22, i32 0, i32 0
  %s23 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.23, i32 0, i32 0
  %s24 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.24, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* %line, i8* %s24)
  br i1 %t25, label %then2, label %merge3
then2:
  %s26 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.26, i32 0, i32 0
  %t27 = call i8* @strip_prefix(i8* %line, i8* %s26)
  %t28 = call i8* @trim_text(i8* %t27)
  store i8* %t28, i8** %l1
  %s29 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.29, i32 0, i32 0
  store i8* %s29, i8** %l2
  %t30 = load i8*, i8** %l1
  %t31 = load i8*, i8** %l2
  %t32 = call double @index_of(i8* %t30, i8* %t31)
  store double %t32, double* %l3
  %t33 = load double, double* %l3
  %t34 = sitofp i64 0 to double
  %t35 = fcmp oge double %t33, %t34
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  br i1 %t35, label %then4, label %merge5
then4:
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l3
  %t41 = call double @substring(i8* %t39, i64 0, double %t40)
  %t42 = call i8* @trim_text(i8* null)
  store i8* %t42, i8** %l4
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l3
  %t45 = load i8*, i8** %l2
  %t46 = load i8*, i8** %l1
  store double 0.0, double* %l5
  %t47 = alloca %NativeInstruction
  %t48 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t47, i32 0, i32 0
  store i32 6, i32* %t48
  %t49 = load i8*, i8** %l4
  %t50 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t47, i32 0, i32 1
  %t51 = bitcast [16 x i8]* %t50 to i8*
  %t52 = bitcast i8* %t51 to i8**
  store i8* %t49, i8** %t52
  %t53 = load double, double* %l5
  %t54 = call noalias i8* @malloc(i64 8)
  %t55 = bitcast i8* %t54 to double*
  store double %t53, double* %t55
  %t56 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t47, i32 0, i32 1
  %t57 = bitcast [16 x i8]* %t56 to i8*
  %t58 = getelementptr inbounds i8, i8* %t57, i64 8
  %t59 = bitcast i8* %t58 to i8**
  store i8* %t54, i8** %t59
  %t60 = load %NativeInstruction, %NativeInstruction* %t47
  %t61 = alloca [1 x %NativeInstruction]
  %t62 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t61, i32 0, i32 0
  %t63 = getelementptr %NativeInstruction, %NativeInstruction* %t62, i64 0
  store %NativeInstruction %t60, %NativeInstruction* %t63
  %t64 = alloca { %NativeInstruction*, i64 }
  %t65 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t64, i32 0, i32 0
  store %NativeInstruction* %t62, %NativeInstruction** %t65
  %t66 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t64, i32 0, i32 1
  store i64 1, i64* %t66
  %t67 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t68 = insertvalue %InstructionParseResult %t67, i1 0, 1
  %t69 = insertvalue %InstructionParseResult %t68, i1 0, 2
  ret %InstructionParseResult %t69
merge5:
  br label %merge3
merge3:
  %s70 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.70, i32 0, i32 0
  %s71 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.71, i32 0, i32 0
  %s72 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.72, i32 0, i32 0
  %s73 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.73, i32 0, i32 0
  %s74 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.74, i32 0, i32 0
  %s75 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.75, i32 0, i32 0
  %t76 = call i1 @starts_with(i8* %line, i8* %s75)
  br i1 %t76, label %then6, label %merge7
then6:
  %s77 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.77, i32 0, i32 0
  %t78 = call i8* @strip_prefix(i8* %line, i8* %s77)
  %t79 = call i8* @trim_text(i8* %t78)
  store i8* %t79, i8** %l6
  %t80 = alloca %NativeInstruction
  %t81 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t80, i32 0, i32 0
  store i32 12, i32* %t81
  %t82 = load i8*, i8** %l6
  %t83 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t80, i32 0, i32 1
  %t84 = bitcast [8 x i8]* %t83 to i8*
  %t85 = bitcast i8* %t84 to i8**
  store i8* %t82, i8** %t85
  %t86 = load %NativeInstruction, %NativeInstruction* %t80
  %t87 = alloca [1 x %NativeInstruction]
  %t88 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t87, i32 0, i32 0
  %t89 = getelementptr %NativeInstruction, %NativeInstruction* %t88, i64 0
  store %NativeInstruction %t86, %NativeInstruction* %t89
  %t90 = alloca { %NativeInstruction*, i64 }
  %t91 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t90, i32 0, i32 0
  store %NativeInstruction* %t88, %NativeInstruction** %t91
  %t92 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t90, i32 0, i32 1
  store i64 1, i64* %t92
  %t93 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t94 = insertvalue %InstructionParseResult %t93, i1 0, 1
  %t95 = insertvalue %InstructionParseResult %t94, i1 0, 2
  ret %InstructionParseResult %t95
merge7:
  %s96 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.96, i32 0, i32 0
  %t97 = call i1 @starts_with(i8* %line, i8* %s96)
  br i1 %t97, label %then8, label %merge9
then8:
  %t98 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t99 = alloca [1 x %NativeInstruction]
  %t100 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t99, i32 0, i32 0
  %t101 = getelementptr %NativeInstruction, %NativeInstruction* %t100, i64 0
  store %NativeInstruction %t98, %NativeInstruction* %t101
  %t102 = alloca { %NativeInstruction*, i64 }
  %t103 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t102, i32 0, i32 0
  store %NativeInstruction* %t100, %NativeInstruction** %t103
  %t104 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t102, i32 0, i32 1
  store i64 1, i64* %t104
  %t105 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t106 = insertvalue %InstructionParseResult %t105, i1 0, 1
  %t107 = insertvalue %InstructionParseResult %t106, i1 0, 2
  ret %InstructionParseResult %t107
merge9:
  %s108 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.108, i32 0, i32 0
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.109, i32 0, i32 0
  %t110 = call i1 @starts_with(i8* %line, i8* %s109)
  br i1 %t110, label %then10, label %merge11
then10:
  %t111 = call %NativeInstruction @parse_let_instruction(i8* %line, double %span, double %value_span)
  %t112 = alloca [1 x %NativeInstruction]
  %t113 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t112, i32 0, i32 0
  %t114 = getelementptr %NativeInstruction, %NativeInstruction* %t113, i64 0
  store %NativeInstruction %t111, %NativeInstruction* %t114
  %t115 = alloca { %NativeInstruction*, i64 }
  %t116 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t115, i32 0, i32 0
  store %NativeInstruction* %t113, %NativeInstruction** %t116
  %t117 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t115, i32 0, i32 1
  store i64 1, i64* %t117
  %t118 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t119 = insertvalue %InstructionParseResult %t118, i1 1, 1
  %t120 = insertvalue %InstructionParseResult %t119, i1 1, 2
  ret %InstructionParseResult %t120
merge11:
  %s121 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.121, i32 0, i32 0
  %t122 = call i1 @starts_with(i8* %line, i8* %s121)
  br i1 %t122, label %then12, label %merge13
then12:
  %t123 = getelementptr i8, i8* %line, i64 3
  %t124 = load i8, i8* %t123
  store i8 %t124, i8* %l7
  %t125 = load i8, i8* %l7
  br label %merge13
merge13:
  %s126 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %t127 = call i1 @starts_with(i8* %line, i8* %s126)
  br i1 %t127, label %then14, label %merge15
then14:
  %s128 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.128, i32 0, i32 0
  %t129 = call i8* @strip_prefix(i8* %line, i8* %s128)
  %t130 = call i8* @trim_text(i8* %t129)
  store i8* %t130, i8** %l8
  store i1 0, i1* %l9
  %t131 = load i8*, i8** %l8
  %s132 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.132, i32 0, i32 0
  %t133 = call i1 @starts_with(i8* %t131, i8* %s132)
  %t134 = load i8*, i8** %l8
  %t135 = load i1, i1* %l9
  br i1 %t133, label %then16, label %merge17
then16:
  store i1 1, i1* %l9
  %t136 = load i8*, i8** %l8
  %s137 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i8* @strip_prefix(i8* %t136, i8* %s137)
  %t139 = call i8* @trim_text(i8* %t138)
  store i8* %t139, i8** %l8
  br label %merge17
merge17:
  %t140 = phi i1 [ 1, %then16 ], [ %t135, %then14 ]
  %t141 = phi i8* [ %t139, %then16 ], [ %t134, %then14 ]
  store i1 %t140, i1* %l9
  store i8* %t141, i8** %l8
  %t142 = load i8*, i8** %l8
  %t143 = call %BindingComponents @parse_binding_components(i8* %t142)
  store %BindingComponents %t143, %BindingComponents* %l10
  %t144 = alloca %NativeInstruction
  %t145 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 0
  store i32 2, i32* %t145
  %t146 = load %BindingComponents, %BindingComponents* %l10
  %t147 = extractvalue %BindingComponents %t146, 0
  %t148 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 1
  %t149 = bitcast [48 x i8]* %t148 to i8*
  %t150 = bitcast i8* %t149 to i8**
  store i8* %t147, i8** %t150
  %t151 = load i1, i1* %l9
  %t152 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 1
  %t153 = bitcast [48 x i8]* %t152 to i8*
  %t154 = getelementptr inbounds i8, i8* %t153, i64 8
  %t155 = bitcast i8* %t154 to i1*
  store i1 %t151, i1* %t155
  %t156 = load %BindingComponents, %BindingComponents* %l10
  %t157 = extractvalue %BindingComponents %t156, 1
  %t158 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 1
  %t159 = bitcast [48 x i8]* %t158 to i8*
  %t160 = getelementptr inbounds i8, i8* %t159, i64 16
  %t161 = bitcast i8* %t160 to i8**
  store i8* %t157, i8** %t161
  %t162 = load %BindingComponents, %BindingComponents* %l10
  %t163 = extractvalue %BindingComponents %t162, 2
  %t164 = call double @maybe_trim_trailing(double 0.0)
  %t165 = call noalias i8* @malloc(i64 8)
  %t166 = bitcast i8* %t165 to double*
  store double %t164, double* %t166
  %t167 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 1
  %t168 = bitcast [48 x i8]* %t167 to i8*
  %t169 = getelementptr inbounds i8, i8* %t168, i64 24
  %t170 = bitcast i8* %t169 to i8**
  store i8* %t165, i8** %t170
  %t171 = call noalias i8* @malloc(i64 8)
  %t172 = bitcast i8* %t171 to double*
  store double %span, double* %t172
  %t173 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 1
  %t174 = bitcast [48 x i8]* %t173 to i8*
  %t175 = getelementptr inbounds i8, i8* %t174, i64 32
  %t176 = bitcast i8* %t175 to i8**
  store i8* %t171, i8** %t176
  %t177 = call noalias i8* @malloc(i64 8)
  %t178 = bitcast i8* %t177 to double*
  store double %value_span, double* %t178
  %t179 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t144, i32 0, i32 1
  %t180 = bitcast [48 x i8]* %t179 to i8*
  %t181 = getelementptr inbounds i8, i8* %t180, i64 40
  %t182 = bitcast i8* %t181 to i8**
  store i8* %t177, i8** %t182
  %t183 = load %NativeInstruction, %NativeInstruction* %t144
  %t184 = alloca [1 x %NativeInstruction]
  %t185 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t184, i32 0, i32 0
  %t186 = getelementptr %NativeInstruction, %NativeInstruction* %t185, i64 0
  store %NativeInstruction %t183, %NativeInstruction* %t186
  %t187 = alloca { %NativeInstruction*, i64 }
  %t188 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t187, i32 0, i32 0
  store %NativeInstruction* %t185, %NativeInstruction** %t188
  %t189 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t187, i32 0, i32 1
  store i64 1, i64* %t189
  %t190 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t191 = insertvalue %InstructionParseResult %t190, i1 1, 1
  %t192 = insertvalue %InstructionParseResult %t191, i1 1, 2
  ret %InstructionParseResult %t192
merge15:
  %s193 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.193, i32 0, i32 0
  %t194 = call i1 @starts_with(i8* %line, i8* %s193)
  br i1 %t194, label %then18, label %merge19
then18:
  %t195 = alloca %NativeInstruction
  %t196 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t195, i32 0, i32 0
  store i32 1, i32* %t196
  %s197 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.197, i32 0, i32 0
  %t198 = call i8* @strip_prefix(i8* %line, i8* %s197)
  %t199 = call i8* @trim_text(i8* %t198)
  %t200 = call i8* @trim_trailing_delimiters(i8* %t199)
  %t201 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t195, i32 0, i32 1
  %t202 = bitcast [16 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  store i8* %t200, i8** %t203
  %t204 = call noalias i8* @malloc(i64 8)
  %t205 = bitcast i8* %t204 to double*
  store double %span, double* %t205
  %t206 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t195, i32 0, i32 1
  %t207 = bitcast [16 x i8]* %t206 to i8*
  %t208 = getelementptr inbounds i8, i8* %t207, i64 8
  %t209 = bitcast i8* %t208 to i8**
  store i8* %t204, i8** %t209
  %t210 = load %NativeInstruction, %NativeInstruction* %t195
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
  %t219 = insertvalue %InstructionParseResult %t218, i1 0, 2
  ret %InstructionParseResult %t219
merge19:
  %t220 = alloca %NativeInstruction
  %t221 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t220, i32 0, i32 0
  store i32 16, i32* %t221
  %t222 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t220, i32 0, i32 1
  %t223 = bitcast [8 x i8]* %t222 to i8*
  %t224 = bitcast i8* %t223 to i8**
  store i8* %line, i8** %t224
  %t225 = load %NativeInstruction, %NativeInstruction* %t220
  %t226 = alloca [1 x %NativeInstruction]
  %t227 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t226, i32 0, i32 0
  %t228 = getelementptr %NativeInstruction, %NativeInstruction* %t227, i64 0
  store %NativeInstruction %t225, %NativeInstruction* %t228
  %t229 = alloca { %NativeInstruction*, i64 }
  %t230 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t229, i32 0, i32 0
  store %NativeInstruction* %t227, %NativeInstruction** %t230
  %t231 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t229, i32 0, i32 1
  store i64 1, i64* %t231
  %t232 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t233 = insertvalue %InstructionParseResult %t232, i1 0, 1
  %t234 = insertvalue %InstructionParseResult %t233, i1 0, 2
  ret %InstructionParseResult %t234
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t27 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t27
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
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
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
  %l23 = alloca double
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
  store double 0.0, double* %l8
  store double 0.0, double* %l9
  store double 0.0, double* %l10
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
  %t53 = load double, double* %l8
  %t54 = load double, double* %l9
  %t55 = load double, double* %l10
  %t56 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t57 = load double, double* %l12
  %t58 = load double, double* %l13
  %t59 = load i1, i1* %l14
  %t60 = load i1, i1* %l15
  %t61 = load double, double* %l16
  br label %loop.header0
loop.header0:
  %t317 = phi { i8**, i64 }* [ %t45, %entry ], [ %t309, %loop.latch2 ]
  %t318 = phi double [ %t57, %entry ], [ %t310, %loop.latch2 ]
  %t319 = phi double [ %t58, %entry ], [ %t311, %loop.latch2 ]
  %t320 = phi i1 [ %t59, %entry ], [ %t312, %loop.latch2 ]
  %t321 = phi { %NativeStructLayoutField*, i64 }* [ %t56, %entry ], [ %t313, %loop.latch2 ]
  %t322 = phi double [ %t53, %entry ], [ %t314, %loop.latch2 ]
  %t323 = phi double [ %t54, %entry ], [ %t315, %loop.latch2 ]
  %t324 = phi double [ %t55, %entry ], [ %t316, %loop.latch2 ]
  store { i8**, i64 }* %t317, { i8**, i64 }** %l0
  store double %t318, double* %l12
  store double %t319, double* %l13
  store i1 %t320, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t321, { %NativeStructLayoutField*, i64 }** %l11
  store double %t322, double* %l8
  store double %t323, double* %l9
  store double %t324, double* %l10
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
  %t71 = load i8*, i8** %l17
  %t72 = load i8*, i8** %l17
  %s73 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.73, i32 0, i32 0
  %t74 = load double, double* %l8
  %t75 = load i8*, i8** %l17
  %s76 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.76, i32 0, i32 0
  %t77 = call i1 @starts_with(i8* %t75, i8* %s76)
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load i8*, i8** %l2
  %t81 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t82 = load i8*, i8** %l4
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t84 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t85 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t86 = load double, double* %l8
  %t87 = load double, double* %l9
  %t88 = load double, double* %l10
  %t89 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t90 = load double, double* %l12
  %t91 = load double, double* %l13
  %t92 = load i1, i1* %l14
  %t93 = load i1, i1* %l15
  %t94 = load double, double* %l16
  %t95 = load i8*, i8** %l17
  br i1 %t77, label %then4, label %merge5
then4:
  %t96 = load i8*, i8** %l17
  %s97 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.97, i32 0, i32 0
  %t98 = call i8* @strip_prefix(i8* %t96, i8* %s97)
  store i8* %t98, i8** %l18
  %t99 = load i8*, i8** %l18
  %s100 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load i8*, i8** %l1
  %t104 = load i8*, i8** %l2
  %t105 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t106 = load i8*, i8** %l4
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t108 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t109 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t110 = load double, double* %l8
  %t111 = load double, double* %l9
  %t112 = load double, double* %l10
  %t113 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t114 = load double, double* %l12
  %t115 = load double, double* %l13
  %t116 = load i1, i1* %l14
  %t117 = load i1, i1* %l15
  %t118 = load double, double* %l16
  %t119 = load i8*, i8** %l17
  %t120 = load i8*, i8** %l18
  br i1 %t101, label %then6, label %merge7
then6:
  %t121 = load i8*, i8** %l18
  %s122 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.122, i32 0, i32 0
  %t123 = call i8* @strip_prefix(i8* %t121, i8* %s122)
  %t124 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t123)
  store %StructLayoutHeaderParse %t124, %StructLayoutHeaderParse* %l19
  %t125 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t126 = extractvalue %StructLayoutHeaderParse %t125, 4
  %t127 = call double @diagnosticsconcat({ i8**, i64 }* %t126)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t128 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t129 = extractvalue %StructLayoutHeaderParse %t128, 0
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t131 = load i8*, i8** %l1
  %t132 = load i8*, i8** %l2
  %t133 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t134 = load i8*, i8** %l4
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t136 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t137 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t138 = load double, double* %l8
  %t139 = load double, double* %l9
  %t140 = load double, double* %l10
  %t141 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t142 = load double, double* %l12
  %t143 = load double, double* %l13
  %t144 = load i1, i1* %l14
  %t145 = load i1, i1* %l15
  %t146 = load double, double* %l16
  %t147 = load i8*, i8** %l17
  %t148 = load i8*, i8** %l18
  %t149 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  br i1 %t129, label %then8, label %merge9
then8:
  %t150 = load i1, i1* %l14
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load i8*, i8** %l1
  %t153 = load i8*, i8** %l2
  %t154 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t155 = load i8*, i8** %l4
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t157 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t158 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t159 = load double, double* %l8
  %t160 = load double, double* %l9
  %t161 = load double, double* %l10
  %t162 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t163 = load double, double* %l12
  %t164 = load double, double* %l13
  %t165 = load i1, i1* %l14
  %t166 = load i1, i1* %l15
  %t167 = load double, double* %l16
  %t168 = load i8*, i8** %l17
  %t169 = load i8*, i8** %l18
  %t170 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  br i1 %t150, label %then10, label %else11
then10:
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s172 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.172, i32 0, i32 0
  %t173 = load i8*, i8** %l4
  %t174 = add i8* %s172, %t173
  %t175 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t171, i8* %t174)
  store { i8**, i64 }* %t175, { i8**, i64 }** %l0
  br label %merge12
else11:
  %t176 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t177 = extractvalue %StructLayoutHeaderParse %t176, 2
  store double %t177, double* %l12
  %t178 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t179 = extractvalue %StructLayoutHeaderParse %t178, 3
  store double %t179, double* %l13
  store i1 1, i1* %l14
  br label %merge12
merge12:
  %t180 = phi { i8**, i64 }* [ %t175, %then10 ], [ %t151, %else11 ]
  %t181 = phi double [ %t163, %then10 ], [ %t177, %else11 ]
  %t182 = phi double [ %t164, %then10 ], [ %t179, %else11 ]
  %t183 = phi i1 [ %t165, %then10 ], [ 1, %else11 ]
  store { i8**, i64 }* %t180, { i8**, i64 }** %l0
  store double %t181, double* %l12
  store double %t182, double* %l13
  store i1 %t183, i1* %l14
  br label %merge9
merge9:
  %t184 = phi { i8**, i64 }* [ %t175, %then8 ], [ %t130, %then6 ]
  %t185 = phi double [ %t177, %then8 ], [ %t142, %then6 ]
  %t186 = phi double [ %t179, %then8 ], [ %t143, %then6 ]
  %t187 = phi i1 [ 1, %then8 ], [ %t144, %then6 ]
  store { i8**, i64 }* %t184, { i8**, i64 }** %l0
  store double %t185, double* %l12
  store double %t186, double* %l13
  store i1 %t187, i1* %l14
  br label %loop.latch2
merge7:
  %t188 = load i8*, i8** %l18
  %s189 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.189, i32 0, i32 0
  %t190 = call i1 @starts_with(i8* %t188, i8* %s189)
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load i8*, i8** %l1
  %t193 = load i8*, i8** %l2
  %t194 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t195 = load i8*, i8** %l4
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t197 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t198 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t199 = load double, double* %l8
  %t200 = load double, double* %l9
  %t201 = load double, double* %l10
  %t202 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t203 = load double, double* %l12
  %t204 = load double, double* %l13
  %t205 = load i1, i1* %l14
  %t206 = load i1, i1* %l15
  %t207 = load double, double* %l16
  %t208 = load i8*, i8** %l17
  %t209 = load i8*, i8** %l18
  br i1 %t190, label %then13, label %merge14
then13:
  %t210 = load i8*, i8** %l18
  %s211 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.211, i32 0, i32 0
  %t212 = call i8* @strip_prefix(i8* %t210, i8* %s211)
  %t213 = load i8*, i8** %l4
  %t214 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t212, i8* %t213)
  store %StructLayoutFieldParse %t214, %StructLayoutFieldParse* %l20
  %t215 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t216 = extractvalue %StructLayoutFieldParse %t215, 2
  %t217 = call double @diagnosticsconcat({ i8**, i64 }* %t216)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t218 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t219 = extractvalue %StructLayoutFieldParse %t218, 0
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load i8*, i8** %l1
  %t222 = load i8*, i8** %l2
  %t223 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t224 = load i8*, i8** %l4
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t226 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t227 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t228 = load double, double* %l8
  %t229 = load double, double* %l9
  %t230 = load double, double* %l10
  %t231 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t232 = load double, double* %l12
  %t233 = load double, double* %l13
  %t234 = load i1, i1* %l14
  %t235 = load i1, i1* %l15
  %t236 = load double, double* %l16
  %t237 = load i8*, i8** %l17
  %t238 = load i8*, i8** %l18
  %t239 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  br i1 %t219, label %then15, label %merge16
then15:
  %t240 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t241 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t242 = extractvalue %StructLayoutFieldParse %t241, 1
  %t243 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t240, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t243, { %NativeStructLayoutField*, i64 }** %l11
  br label %merge16
merge16:
  %t244 = phi { %NativeStructLayoutField*, i64 }* [ %t243, %then15 ], [ %t231, %then13 ]
  store { %NativeStructLayoutField*, i64 }* %t244, { %NativeStructLayoutField*, i64 }** %l11
  br label %loop.latch2
merge14:
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s246 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.246, i32 0, i32 0
  %t247 = load i8*, i8** %l17
  %t248 = add i8* %s246, %t247
  %t249 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t245, i8* %t248)
  store { i8**, i64 }* %t249, { i8**, i64 }** %l0
  br label %loop.latch2
merge5:
  %t250 = load i8*, i8** %l17
  %s251 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.251, i32 0, i32 0
  %t252 = load i8*, i8** %l17
  %s253 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.253, i32 0, i32 0
  %t254 = call i1 @starts_with(i8* %t252, i8* %s253)
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t256 = load i8*, i8** %l1
  %t257 = load i8*, i8** %l2
  %t258 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t259 = load i8*, i8** %l4
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t261 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t262 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t263 = load double, double* %l8
  %t264 = load double, double* %l9
  %t265 = load double, double* %l10
  %t266 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t267 = load double, double* %l12
  %t268 = load double, double* %l13
  %t269 = load i1, i1* %l14
  %t270 = load i1, i1* %l15
  %t271 = load double, double* %l16
  %t272 = load i8*, i8** %l17
  br i1 %t254, label %then17, label %merge18
then17:
  %t273 = load i8*, i8** %l17
  %s274 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.274, i32 0, i32 0
  %t275 = call i8* @strip_prefix(i8* %t273, i8* %s274)
  %t276 = call double @parse_struct_field_line(i8* %t275)
  store double %t276, double* %l21
  %t277 = load double, double* %l21
  br label %loop.latch2
merge18:
  %t278 = load i8*, i8** %l17
  %s279 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.279, i32 0, i32 0
  %t280 = call i1 @starts_with(i8* %t278, i8* %s279)
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t282 = load i8*, i8** %l1
  %t283 = load i8*, i8** %l2
  %t284 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t285 = load i8*, i8** %l4
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t287 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t288 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t289 = load double, double* %l8
  %t290 = load double, double* %l9
  %t291 = load double, double* %l10
  %t292 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t293 = load double, double* %l12
  %t294 = load double, double* %l13
  %t295 = load i1, i1* %l14
  %t296 = load i1, i1* %l15
  %t297 = load double, double* %l16
  %t298 = load i8*, i8** %l17
  br i1 %t280, label %then19, label %merge20
then19:
  %t299 = load double, double* %l8
  %t300 = load i8*, i8** %l17
  %s301 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.301, i32 0, i32 0
  %t302 = call i8* @strip_prefix(i8* %t300, i8* %s301)
  %t303 = call i8* @parse_function_name(i8* %t302)
  store i8* %t303, i8** %l22
  br label %loop.latch2
merge20:
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s305 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.305, i32 0, i32 0
  %t306 = load i8*, i8** %l17
  %t307 = add i8* %s305, %t306
  %t308 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t304, i8* %t307)
  store { i8**, i64 }* %t308, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t310 = load double, double* %l12
  %t311 = load double, double* %l13
  %t312 = load i1, i1* %l14
  %t313 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t314 = load double, double* %l8
  %t315 = load double, double* %l9
  %t316 = load double, double* %l10
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l23
  %t325 = load i1, i1* %l14
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load i8*, i8** %l1
  %t328 = load i8*, i8** %l2
  %t329 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t330 = load i8*, i8** %l4
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t332 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t333 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t334 = load double, double* %l8
  %t335 = load double, double* %l9
  %t336 = load double, double* %l10
  %t337 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t338 = load double, double* %l12
  %t339 = load double, double* %l13
  %t340 = load i1, i1* %l14
  %t341 = load i1, i1* %l15
  %t342 = load double, double* %l16
  %t343 = load double, double* %l23
  br i1 %t325, label %then21, label %merge22
then21:
  %t344 = load double, double* %l12
  %t345 = insertvalue %NativeStructLayout undef, double %t344, 0
  %t346 = load double, double* %l13
  %t347 = insertvalue %NativeStructLayout %t345, double %t346, 1
  %t348 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t349 = insertvalue %NativeStructLayout %t347, { i8**, i64 }* null, 2
  store double 0.0, double* %l23
  br label %merge22
merge22:
  %t350 = phi double [ 0.0, %then21 ], [ %t343, %entry ]
  store double %t350, double* %l23
  %t351 = load i8*, i8** %l4
  %t352 = insertvalue %NativeStruct undef, i8* %t351, 0
  %t353 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t354 = insertvalue %NativeStruct %t352, { i8**, i64 }* null, 1
  %t355 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t356 = insertvalue %NativeStruct %t354, { i8**, i64 }* null, 2
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t358 = insertvalue %NativeStruct %t356, { i8**, i64 }* %t357, 3
  %t359 = load double, double* %l23
  %t360 = insertvalue %NativeStruct %t358, i8* null, 4
  %t361 = insertvalue %StructParseResult undef, i8* null, 0
  %t362 = load double, double* %l16
  %t363 = insertvalue %StructParseResult %t361, double %t362, 1
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = insertvalue %StructParseResult %t363, { i8**, i64 }* %t364, 2
  ret %StructParseResult %t365
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
  %t99 = phi { i8**, i64 }* [ %t31, %entry ], [ %t97, %loop.latch2 ]
  %t100 = phi { %NativeInterfaceSignature*, i64 }* [ %t36, %entry ], [ %t98, %loop.latch2 ]
  store { i8**, i64 }* %t99, { i8**, i64 }** %l0
  store { %NativeInterfaceSignature*, i64 }* %t100, { %NativeInterfaceSignature*, i64 }** %l5
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
  %t47 = load i8*, i8** %l7
  %t48 = load i8*, i8** %l7
  %s49 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.49, i32 0, i32 0
  %t50 = load i8*, i8** %l7
  %s51 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.51, i32 0, i32 0
  %t52 = load i8*, i8** %l7
  %s53 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.53, i32 0, i32 0
  %t54 = call i1 @starts_with(i8* %t52, i8* %s53)
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load i8*, i8** %l2
  %t58 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t59 = load i8*, i8** %l4
  %t60 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t61 = load double, double* %l6
  %t62 = load i8*, i8** %l7
  br i1 %t54, label %then4, label %merge5
then4:
  %t63 = load i8*, i8** %l7
  %s64 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.64, i32 0, i32 0
  %t65 = call i8* @strip_prefix(i8* %t63, i8* %s64)
  %t66 = load i8*, i8** %l4
  %t67 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t65, i8* %t66)
  store %InterfaceSignatureParse %t67, %InterfaceSignatureParse* %l8
  %t68 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t69 = extractvalue %InterfaceSignatureParse %t68, 2
  %t70 = call double @diagnosticsconcat({ i8**, i64 }* %t69)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t71 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t72 = extractvalue %InterfaceSignatureParse %t71, 0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t77 = load i8*, i8** %l4
  %t78 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t79 = load double, double* %l6
  %t80 = load i8*, i8** %l7
  %t81 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t72, label %then6, label %merge7
then6:
  %t82 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t83 = extractvalue %InterfaceSignatureParse %t82, 1
  %t84 = alloca [1 x i8*]
  %t85 = getelementptr [1 x i8*], [1 x i8*]* %t84, i32 0, i32 0
  %t86 = getelementptr i8*, i8** %t85, i64 0
  store i8* %t83, i8** %t86
  %t87 = alloca { i8**, i64 }
  %t88 = getelementptr { i8**, i64 }, { i8**, i64 }* %t87, i32 0, i32 0
  store i8** %t85, i8*** %t88
  %t89 = getelementptr { i8**, i64 }, { i8**, i64 }* %t87, i32 0, i32 1
  store i64 1, i64* %t89
  %t90 = call double @signaturesconcat({ i8**, i64 }* %t87)
  store { %NativeInterfaceSignature*, i64 }* null, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge7
merge7:
  %t91 = phi { %NativeInterfaceSignature*, i64 }* [ null, %then6 ], [ %t78, %then4 ]
  store { %NativeInterfaceSignature*, i64 }* %t91, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.latch2
merge5:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s93 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.93, i32 0, i32 0
  %t94 = load i8*, i8** %l7
  %t95 = add i8* %s93, %t94
  %t96 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t92, i8* %t95)
  store { i8**, i64 }* %t96, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t101 = load i8*, i8** %l4
  %t102 = insertvalue %NativeInterface undef, i8* %t101, 0
  %t103 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t104 = extractvalue %InterfaceHeaderParse %t103, 1
  %t105 = insertvalue %NativeInterface %t102, { i8**, i64 }* %t104, 1
  %t106 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t107 = insertvalue %NativeInterface %t105, { i8**, i64 }* null, 2
  %t108 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t109 = load double, double* %l6
  %t110 = insertvalue %InterfaceParseResult %t108, double %t109, 1
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = insertvalue %InterfaceParseResult %t110, { i8**, i64 }* %t111, 2
  ret %InterfaceParseResult %t112
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
  %t114 = load i8*, i8** %l9
  store double 0.0, double* %l17
  %t115 = load double, double* %l17
  %t116 = fcmp one double %t115, 0.0
  %t117 = insertvalue %InterfaceSignatureParse undef, i1 %t116, 0
  %t118 = load double, double* %l16
  %t119 = insertvalue %InterfaceSignatureParse %t117, i8* null, 1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = insertvalue %InterfaceSignatureParse %t119, { i8**, i64 }* %t120, 2
  ret %InterfaceSignatureParse %t121
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
  %t45 = phi i8* [ %t13, %entry ], [ %t44, %loop.latch2 ]
  store i8* %t45, i8** %l1
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l2
  %t21 = load double, double* %l2
  %t22 = getelementptr i8, i8* %text, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l8
  %t24 = load i8*, i8** %l3
  %t25 = load i8, i8* %l8
  %t26 = load i8, i8* %l8
  %t27 = load i8, i8* %l8
  %t28 = load i8, i8* %l8
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
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
  %t42 = load i8*, i8** %l1
  %t43 = load i8, i8* %l8
  br label %loop.latch2
loop.latch2:
  %t44 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t46 = load i8*, i8** %l1
  %t47 = call i8* @trim_text(i8* %t46)
  store i8* %t47, i8** %l9
  %t48 = load i8*, i8** %l9
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t49
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
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = sitofp i64 -1 to double
  ret double %t8
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
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = sitofp i64 -1 to double
  ret double %t8
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
  %l23 = alloca double
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
  %t421 = phi { i8**, i64 }* [ %t53, %entry ], [ %t413, %loop.latch4 ]
  %t422 = phi double [ %t60, %entry ], [ %t414, %loop.latch4 ]
  %t423 = phi double [ %t61, %entry ], [ %t415, %loop.latch4 ]
  %t424 = phi i8* [ %t62, %entry ], [ %t416, %loop.latch4 ]
  %t425 = phi double [ %t63, %entry ], [ %t417, %loop.latch4 ]
  %t426 = phi double [ %t64, %entry ], [ %t418, %loop.latch4 ]
  %t427 = phi i1 [ %t65, %entry ], [ %t419, %loop.latch4 ]
  %t428 = phi { %NativeEnumVariantLayout*, i64 }* [ %t59, %entry ], [ %t420, %loop.latch4 ]
  store { i8**, i64 }* %t421, { i8**, i64 }** %l0
  store double %t422, double* %l7
  store double %t423, double* %l8
  store i8* %t424, i8** %l9
  store double %t425, double* %l10
  store double %t426, double* %l11
  store i1 %t427, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t428, { %NativeEnumVariantLayout*, i64 }** %l6
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
  %t77 = load i8*, i8** %l15
  %t78 = load i8*, i8** %l15
  %s79 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.79, i32 0, i32 0
  %t80 = load i8*, i8** %l15
  %s81 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.81, i32 0, i32 0
  %t82 = call i1 @starts_with(i8* %t80, i8* %s81)
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load i8*, i8** %l1
  %t85 = load i8*, i8** %l2
  %t86 = load i8*, i8** %l3
  %t87 = load double, double* %l4
  %t88 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t89 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t90 = load double, double* %l7
  %t91 = load double, double* %l8
  %t92 = load i8*, i8** %l9
  %t93 = load double, double* %l10
  %t94 = load double, double* %l11
  %t95 = load i1, i1* %l12
  %t96 = load i1, i1* %l13
  %t97 = load double, double* %l14
  %t98 = load i8*, i8** %l15
  br i1 %t82, label %then6, label %merge7
then6:
  %t99 = load i8*, i8** %l15
  %s100 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.100, i32 0, i32 0
  %t101 = call i8* @strip_prefix(i8* %t99, i8* %s100)
  store i8* %t101, i8** %l16
  %t102 = load i8*, i8** %l16
  %s103 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.103, i32 0, i32 0
  %t104 = call i1 @starts_with(i8* %t102, i8* %s103)
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load i8*, i8** %l1
  %t107 = load i8*, i8** %l2
  %t108 = load i8*, i8** %l3
  %t109 = load double, double* %l4
  %t110 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t111 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t112 = load double, double* %l7
  %t113 = load double, double* %l8
  %t114 = load i8*, i8** %l9
  %t115 = load double, double* %l10
  %t116 = load double, double* %l11
  %t117 = load i1, i1* %l12
  %t118 = load i1, i1* %l13
  %t119 = load double, double* %l14
  %t120 = load i8*, i8** %l15
  %t121 = load i8*, i8** %l16
  br i1 %t104, label %then8, label %merge9
then8:
  %t122 = load i8*, i8** %l16
  %s123 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.123, i32 0, i32 0
  %t124 = call i8* @strip_prefix(i8* %t122, i8* %s123)
  %t125 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t124)
  store %EnumLayoutHeaderParse %t125, %EnumLayoutHeaderParse* %l17
  %t126 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t127 = extractvalue %EnumLayoutHeaderParse %t126, 7
  %t128 = call double @diagnosticsconcat({ i8**, i64 }* %t127)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t129 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t130 = extractvalue %EnumLayoutHeaderParse %t129, 0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load i8*, i8** %l2
  %t134 = load i8*, i8** %l3
  %t135 = load double, double* %l4
  %t136 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t137 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t138 = load double, double* %l7
  %t139 = load double, double* %l8
  %t140 = load i8*, i8** %l9
  %t141 = load double, double* %l10
  %t142 = load double, double* %l11
  %t143 = load i1, i1* %l12
  %t144 = load i1, i1* %l13
  %t145 = load double, double* %l14
  %t146 = load i8*, i8** %l15
  %t147 = load i8*, i8** %l16
  %t148 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  br i1 %t130, label %then10, label %merge11
then10:
  %t149 = load i1, i1* %l12
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load i8*, i8** %l1
  %t152 = load i8*, i8** %l2
  %t153 = load i8*, i8** %l3
  %t154 = load double, double* %l4
  %t155 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t156 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t157 = load double, double* %l7
  %t158 = load double, double* %l8
  %t159 = load i8*, i8** %l9
  %t160 = load double, double* %l10
  %t161 = load double, double* %l11
  %t162 = load i1, i1* %l12
  %t163 = load i1, i1* %l13
  %t164 = load double, double* %l14
  %t165 = load i8*, i8** %l15
  %t166 = load i8*, i8** %l16
  %t167 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  br i1 %t149, label %then12, label %else13
then12:
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s169 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.169, i32 0, i32 0
  %t170 = load i8*, i8** %l3
  %t171 = add i8* %s169, %t170
  %t172 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t168, i8* %t171)
  store { i8**, i64 }* %t172, { i8**, i64 }** %l0
  br label %merge14
else13:
  %t173 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t174 = extractvalue %EnumLayoutHeaderParse %t173, 2
  store double %t174, double* %l7
  %t175 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t176 = extractvalue %EnumLayoutHeaderParse %t175, 3
  store double %t176, double* %l8
  %t177 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t178 = extractvalue %EnumLayoutHeaderParse %t177, 4
  store i8* %t178, i8** %l9
  %t179 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t180 = extractvalue %EnumLayoutHeaderParse %t179, 5
  store double %t180, double* %l10
  %t181 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t182 = extractvalue %EnumLayoutHeaderParse %t181, 6
  store double %t182, double* %l11
  store i1 1, i1* %l12
  br label %merge14
merge14:
  %t183 = phi { i8**, i64 }* [ %t172, %then12 ], [ %t150, %else13 ]
  %t184 = phi double [ %t157, %then12 ], [ %t174, %else13 ]
  %t185 = phi double [ %t158, %then12 ], [ %t176, %else13 ]
  %t186 = phi i8* [ %t159, %then12 ], [ %t178, %else13 ]
  %t187 = phi double [ %t160, %then12 ], [ %t180, %else13 ]
  %t188 = phi double [ %t161, %then12 ], [ %t182, %else13 ]
  %t189 = phi i1 [ %t162, %then12 ], [ 1, %else13 ]
  store { i8**, i64 }* %t183, { i8**, i64 }** %l0
  store double %t184, double* %l7
  store double %t185, double* %l8
  store i8* %t186, i8** %l9
  store double %t187, double* %l10
  store double %t188, double* %l11
  store i1 %t189, i1* %l12
  br label %merge11
merge11:
  %t190 = phi { i8**, i64 }* [ %t172, %then10 ], [ %t131, %then8 ]
  %t191 = phi double [ %t174, %then10 ], [ %t138, %then8 ]
  %t192 = phi double [ %t176, %then10 ], [ %t139, %then8 ]
  %t193 = phi i8* [ %t178, %then10 ], [ %t140, %then8 ]
  %t194 = phi double [ %t180, %then10 ], [ %t141, %then8 ]
  %t195 = phi double [ %t182, %then10 ], [ %t142, %then8 ]
  %t196 = phi i1 [ 1, %then10 ], [ %t143, %then8 ]
  store { i8**, i64 }* %t190, { i8**, i64 }** %l0
  store double %t191, double* %l7
  store double %t192, double* %l8
  store i8* %t193, i8** %l9
  store double %t194, double* %l10
  store double %t195, double* %l11
  store i1 %t196, i1* %l12
  br label %loop.latch4
merge9:
  %t197 = load i8*, i8** %l16
  %s198 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.198, i32 0, i32 0
  %t199 = call i1 @starts_with(i8* %t197, i8* %s198)
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t201 = load i8*, i8** %l1
  %t202 = load i8*, i8** %l2
  %t203 = load i8*, i8** %l3
  %t204 = load double, double* %l4
  %t205 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t206 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t207 = load double, double* %l7
  %t208 = load double, double* %l8
  %t209 = load i8*, i8** %l9
  %t210 = load double, double* %l10
  %t211 = load double, double* %l11
  %t212 = load i1, i1* %l12
  %t213 = load i1, i1* %l13
  %t214 = load double, double* %l14
  %t215 = load i8*, i8** %l15
  %t216 = load i8*, i8** %l16
  br i1 %t199, label %then15, label %merge16
then15:
  %t217 = load i8*, i8** %l16
  %s218 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.218, i32 0, i32 0
  %t219 = call i8* @strip_prefix(i8* %t217, i8* %s218)
  %t220 = load i8*, i8** %l3
  %t221 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t219, i8* %t220)
  store %EnumLayoutVariantParse %t221, %EnumLayoutVariantParse* %l18
  %t222 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t223 = extractvalue %EnumLayoutVariantParse %t222, 2
  %t224 = call double @diagnosticsconcat({ i8**, i64 }* %t223)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t225 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t226 = extractvalue %EnumLayoutVariantParse %t225, 0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t228 = load i8*, i8** %l1
  %t229 = load i8*, i8** %l2
  %t230 = load i8*, i8** %l3
  %t231 = load double, double* %l4
  %t232 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t233 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t234 = load double, double* %l7
  %t235 = load double, double* %l8
  %t236 = load i8*, i8** %l9
  %t237 = load double, double* %l10
  %t238 = load double, double* %l11
  %t239 = load i1, i1* %l12
  %t240 = load i1, i1* %l13
  %t241 = load double, double* %l14
  %t242 = load i8*, i8** %l15
  %t243 = load i8*, i8** %l16
  %t244 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  br i1 %t226, label %then17, label %merge18
then17:
  %t245 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t246 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t247 = extractvalue %EnumLayoutVariantParse %t246, 1
  store double 0.0, double* %l19
  %t248 = load double, double* %l19
  %t249 = sitofp i64 0 to double
  %t250 = fcmp oge double %t248, %t249
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
  %t269 = load double, double* %l19
  br i1 %t250, label %then19, label %else20
then19:
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s271 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.271, i32 0, i32 0
  %t272 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t273 = extractvalue %EnumLayoutVariantParse %t272, 1
  br label %merge21
else20:
  %t274 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t275 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t276 = extractvalue %EnumLayoutVariantParse %t275, 1
  %t277 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t274, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t277, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge21
merge21:
  %t278 = phi { i8**, i64 }* [ null, %then19 ], [ %t251, %else20 ]
  %t279 = phi { %NativeEnumVariantLayout*, i64 }* [ %t257, %then19 ], [ %t277, %else20 ]
  store { i8**, i64 }* %t278, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t279, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge18
merge18:
  %t280 = phi { i8**, i64 }* [ null, %then17 ], [ %t227, %then15 ]
  %t281 = phi { %NativeEnumVariantLayout*, i64 }* [ %t277, %then17 ], [ %t233, %then15 ]
  store { i8**, i64 }* %t280, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t281, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.latch4
merge16:
  %t282 = load i8*, i8** %l16
  %s283 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.283, i32 0, i32 0
  %t284 = call i1 @starts_with(i8* %t282, i8* %s283)
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
  %t300 = load i8*, i8** %l15
  %t301 = load i8*, i8** %l16
  br i1 %t284, label %then22, label %merge23
then22:
  %t302 = load i8*, i8** %l16
  %s303 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.303, i32 0, i32 0
  %t304 = call i8* @strip_prefix(i8* %t302, i8* %s303)
  %t305 = load i8*, i8** %l3
  %t306 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t304, i8* %t305)
  store %EnumLayoutPayloadParse %t306, %EnumLayoutPayloadParse* %l20
  %t307 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t308 = extractvalue %EnumLayoutPayloadParse %t307, 3
  %t309 = call double @diagnosticsconcat({ i8**, i64 }* %t308)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t310 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t311 = extractvalue %EnumLayoutPayloadParse %t310, 0
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
  %t329 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  br i1 %t311, label %then24, label %merge25
then24:
  %t330 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t331 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t332 = extractvalue %EnumLayoutPayloadParse %t331, 1
  %t333 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t330, i8* %t332)
  store double %t333, double* %l21
  %t334 = load double, double* %l21
  %t335 = sitofp i64 0 to double
  %t336 = fcmp olt double %t334, %t335
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t338 = load i8*, i8** %l1
  %t339 = load i8*, i8** %l2
  %t340 = load i8*, i8** %l3
  %t341 = load double, double* %l4
  %t342 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t343 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t344 = load double, double* %l7
  %t345 = load double, double* %l8
  %t346 = load i8*, i8** %l9
  %t347 = load double, double* %l10
  %t348 = load double, double* %l11
  %t349 = load i1, i1* %l12
  %t350 = load i1, i1* %l13
  %t351 = load double, double* %l14
  %t352 = load i8*, i8** %l15
  %t353 = load i8*, i8** %l16
  %t354 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t355 = load double, double* %l21
  br i1 %t336, label %then26, label %else27
then26:
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s357 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.357, i32 0, i32 0
  %t358 = load i8*, i8** %l3
  %t359 = add i8* %s357, %t358
  %s360 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.360, i32 0, i32 0
  %t361 = add i8* %t359, %s360
  %t362 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t363 = extractvalue %EnumLayoutPayloadParse %t362, 1
  %t364 = add i8* %t361, %t363
  %s365 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.365, i32 0, i32 0
  %t366 = add i8* %t364, %s365
  %t367 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t356, i8* %t366)
  store { i8**, i64 }* %t367, { i8**, i64 }** %l0
  br label %merge28
else27:
  %t368 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t369 = load double, double* %l21
  %t370 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t371 = extractvalue %EnumLayoutPayloadParse %t370, 2
  %t372 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t368, double %t369, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t372, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge28
merge28:
  %t373 = phi { i8**, i64 }* [ %t367, %then26 ], [ %t337, %else27 ]
  %t374 = phi { %NativeEnumVariantLayout*, i64 }* [ %t343, %then26 ], [ %t372, %else27 ]
  store { i8**, i64 }* %t373, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t374, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge25
merge25:
  %t375 = phi { i8**, i64 }* [ %t367, %then24 ], [ %t312, %then22 ]
  %t376 = phi { %NativeEnumVariantLayout*, i64 }* [ %t372, %then24 ], [ %t318, %then22 ]
  store { i8**, i64 }* %t375, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t376, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.latch4
merge23:
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s378 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.378, i32 0, i32 0
  %t379 = load i8*, i8** %l15
  %t380 = add i8* %s378, %t379
  %t381 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t377, i8* %t380)
  store { i8**, i64 }* %t381, { i8**, i64 }** %l0
  br label %loop.latch4
merge7:
  %t382 = load i8*, i8** %l15
  %s383 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.383, i32 0, i32 0
  %t384 = load i8*, i8** %l15
  %s385 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.385, i32 0, i32 0
  %t386 = call i1 @starts_with(i8* %t384, i8* %s385)
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t388 = load i8*, i8** %l1
  %t389 = load i8*, i8** %l2
  %t390 = load i8*, i8** %l3
  %t391 = load double, double* %l4
  %t392 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t393 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t394 = load double, double* %l7
  %t395 = load double, double* %l8
  %t396 = load i8*, i8** %l9
  %t397 = load double, double* %l10
  %t398 = load double, double* %l11
  %t399 = load i1, i1* %l12
  %t400 = load i1, i1* %l13
  %t401 = load double, double* %l14
  %t402 = load i8*, i8** %l15
  br i1 %t386, label %then29, label %merge30
then29:
  %t403 = load i8*, i8** %l15
  %s404 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.404, i32 0, i32 0
  %t405 = call i8* @strip_prefix(i8* %t403, i8* %s404)
  %t406 = call double @parse_enum_variant_line(i8* %t405)
  store double %t406, double* %l22
  %t407 = load double, double* %l22
  br label %loop.latch4
merge30:
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s409 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.409, i32 0, i32 0
  %t410 = load i8*, i8** %l15
  %t411 = add i8* %s409, %t410
  %t412 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t408, i8* %t411)
  store { i8**, i64 }* %t412, { i8**, i64 }** %l0
  br label %loop.latch4
loop.latch4:
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t414 = load double, double* %l7
  %t415 = load double, double* %l8
  %t416 = load i8*, i8** %l9
  %t417 = load double, double* %l10
  %t418 = load double, double* %l11
  %t419 = load i1, i1* %l12
  %t420 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.header2
afterloop5:
  store double 0.0, double* %l23
  %t429 = load i1, i1* %l12
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t431 = load i8*, i8** %l1
  %t432 = load i8*, i8** %l2
  %t433 = load i8*, i8** %l3
  %t434 = load double, double* %l4
  %t435 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t436 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t437 = load double, double* %l7
  %t438 = load double, double* %l8
  %t439 = load i8*, i8** %l9
  %t440 = load double, double* %l10
  %t441 = load double, double* %l11
  %t442 = load i1, i1* %l12
  %t443 = load i1, i1* %l13
  %t444 = load double, double* %l14
  %t445 = load double, double* %l23
  br i1 %t429, label %then31, label %merge32
then31:
  br label %merge32
merge32:
  %t446 = phi double [ 0.0, %then31 ], [ %t445, %entry ]
  store double %t446, double* %l23
  %t447 = load i8*, i8** %l3
  %t448 = insertvalue %NativeEnum undef, i8* %t447, 0
  %t449 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t450 = insertvalue %NativeEnum %t448, { i8**, i64 }* null, 1
  %t451 = load double, double* %l23
  %t452 = insertvalue %NativeEnum %t450, i8* null, 2
  %t453 = insertvalue %EnumParseResult undef, i8* null, 0
  %t454 = load double, double* %l14
  %t455 = insertvalue %EnumParseResult %t453, double %t454, 1
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t457 = insertvalue %EnumParseResult %t455, { i8**, i64 }* %t456, 2
  ret %EnumParseResult %t457
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
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = getelementptr i8, i8* %text, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l4
  %t16 = load i8, i8* %l4
  %t17 = load i8, i8* %l4
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t18 = load i8*, i8** %l1
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t19
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
  %t5 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call double @substring(i8* %text, i64 0, double %t7)
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
  %t153 = phi i8* [ %t17, %entry ], [ %t146, %loop.latch2 ]
  %t154 = phi i1 [ %t14, %entry ], [ %t147, %loop.latch2 ]
  %t155 = phi i1 [ %t15, %entry ], [ %t148, %loop.latch2 ]
  %t156 = phi double [ %t18, %entry ], [ %t149, %loop.latch2 ]
  %t157 = phi { i8**, i64 }* [ %t13, %entry ], [ %t150, %loop.latch2 ]
  %t158 = phi i1 [ %t16, %entry ], [ %t151, %loop.latch2 ]
  %t159 = phi double [ %t19, %entry ], [ %t152, %loop.latch2 ]
  store i8* %t153, i8** %l5
  store i1 %t154, i1* %l2
  store i1 %t155, i1* %l3
  store double %t156, double* %l6
  store { i8**, i64 }* %t157, { i8**, i64 }** %l1
  store i1 %t158, i1* %l4
  store double %t159, double* %l7
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
  br label %loop.latch2
loop.latch2:
  %t146 = load i8*, i8** %l5
  %t147 = load i1, i1* %l2
  %t148 = load i1, i1* %l3
  %t149 = load double, double* %l6
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t151 = load i1, i1* %l4
  %t152 = load double, double* %l7
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l14
  %t160 = load double, double* %l14
  %t161 = fcmp one double %t160, 0.0
  %t162 = insertvalue %StructLayoutHeaderParse undef, i1 %t161, 0
  %t163 = load i8*, i8** %l5
  %t164 = insertvalue %StructLayoutHeaderParse %t162, i8* %t163, 1
  %t165 = load double, double* %l6
  %t166 = insertvalue %StructLayoutHeaderParse %t164, double %t165, 2
  %t167 = load double, double* %l7
  %t168 = insertvalue %StructLayoutHeaderParse %t166, double %t167, 3
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t170 = insertvalue %StructLayoutHeaderParse %t168, { i8**, i64 }* %t169, 4
  ret %StructLayoutHeaderParse %t170
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
  %t282 = phi i8* [ %t38, %entry ], [ %t274, %loop.latch2 ]
  %t283 = phi i1 [ %t39, %entry ], [ %t275, %loop.latch2 ]
  %t284 = phi double [ %t42, %entry ], [ %t276, %loop.latch2 ]
  %t285 = phi { i8**, i64 }* [ %t34, %entry ], [ %t277, %loop.latch2 ]
  %t286 = phi i1 [ %t40, %entry ], [ %t278, %loop.latch2 ]
  %t287 = phi double [ %t43, %entry ], [ %t279, %loop.latch2 ]
  %t288 = phi i1 [ %t41, %entry ], [ %t280, %loop.latch2 ]
  %t289 = phi double [ %t44, %entry ], [ %t281, %loop.latch2 ]
  store i8* %t282, i8** %l5
  store i1 %t283, i1* %l6
  store double %t284, double* %l9
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  store i1 %t286, i1* %l7
  store double %t287, double* %l10
  store i1 %t288, i1* %l8
  store double %t289, double* %l11
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
  br label %loop.latch2
loop.latch2:
  %t274 = load i8*, i8** %l5
  %t275 = load i1, i1* %l6
  %t276 = load double, double* %l9
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t278 = load i1, i1* %l7
  %t279 = load double, double* %l10
  %t280 = load i1, i1* %l8
  %t281 = load double, double* %l11
  br label %loop.header0
afterloop3:
  %t290 = load i8*, i8** %l5
  %t291 = load i8*, i8** %l5
  store double 0.0, double* %l20
  %t292 = load i8*, i8** %l4
  %t293 = insertvalue %NativeStructLayoutField undef, i8* %t292, 0
  %t294 = load i8*, i8** %l5
  %t295 = insertvalue %NativeStructLayoutField %t293, i8* %t294, 1
  %t296 = load double, double* %l9
  %t297 = insertvalue %NativeStructLayoutField %t295, double %t296, 2
  %t298 = load double, double* %l10
  %t299 = insertvalue %NativeStructLayoutField %t297, double %t298, 3
  %t300 = load double, double* %l11
  %t301 = insertvalue %NativeStructLayoutField %t299, double %t300, 4
  store %NativeStructLayoutField %t301, %NativeStructLayoutField* %l21
  %t302 = load double, double* %l20
  %t303 = fcmp one double %t302, 0.0
  %t304 = insertvalue %StructLayoutFieldParse undef, i1 %t303, 0
  %t305 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t306 = insertvalue %StructLayoutFieldParse %t304, i8* null, 1
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t308 = insertvalue %StructLayoutFieldParse %t306, { i8**, i64 }* %t307, 2
  ret %StructLayoutFieldParse %t308
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
  %t338 = phi i8* [ %t20, %entry ], [ %t326, %loop.latch2 ]
  %t339 = phi i1 [ %t17, %entry ], [ %t327, %loop.latch2 ]
  %t340 = phi i1 [ %t18, %entry ], [ %t328, %loop.latch2 ]
  %t341 = phi double [ %t24, %entry ], [ %t329, %loop.latch2 ]
  %t342 = phi { i8**, i64 }* [ %t16, %entry ], [ %t330, %loop.latch2 ]
  %t343 = phi i1 [ %t19, %entry ], [ %t331, %loop.latch2 ]
  %t344 = phi double [ %t25, %entry ], [ %t332, %loop.latch2 ]
  %t345 = phi i8* [ %t21, %entry ], [ %t333, %loop.latch2 ]
  %t346 = phi i1 [ %t22, %entry ], [ %t334, %loop.latch2 ]
  %t347 = phi double [ %t26, %entry ], [ %t335, %loop.latch2 ]
  %t348 = phi i1 [ %t23, %entry ], [ %t336, %loop.latch2 ]
  %t349 = phi double [ %t27, %entry ], [ %t337, %loop.latch2 ]
  store i8* %t338, i8** %l5
  store i1 %t339, i1* %l2
  store i1 %t340, i1* %l3
  store double %t341, double* %l9
  store { i8**, i64 }* %t342, { i8**, i64 }** %l1
  store i1 %t343, i1* %l4
  store double %t344, double* %l10
  store i8* %t345, i8** %l6
  store i1 %t346, i1* %l7
  store double %t347, double* %l11
  store i1 %t348, i1* %l8
  store double %t349, double* %l12
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
  br label %loop.latch2
loop.latch2:
  %t326 = load i8*, i8** %l5
  %t327 = load i1, i1* %l2
  %t328 = load i1, i1* %l3
  %t329 = load double, double* %l9
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t331 = load i1, i1* %l4
  %t332 = load double, double* %l10
  %t333 = load i8*, i8** %l6
  %t334 = load i1, i1* %l7
  %t335 = load double, double* %l11
  %t336 = load i1, i1* %l8
  %t337 = load double, double* %l12
  br label %loop.header0
afterloop3:
  %t350 = load i8*, i8** %l6
  store double 0.0, double* %l23
  %t351 = load double, double* %l23
  %t352 = fcmp one double %t351, 0.0
  %t353 = insertvalue %EnumLayoutHeaderParse undef, i1 %t352, 0
  %t354 = load i8*, i8** %l5
  %t355 = insertvalue %EnumLayoutHeaderParse %t353, i8* %t354, 1
  %t356 = load double, double* %l9
  %t357 = insertvalue %EnumLayoutHeaderParse %t355, double %t356, 2
  %t358 = load double, double* %l10
  %t359 = insertvalue %EnumLayoutHeaderParse %t357, double %t358, 3
  %t360 = load i8*, i8** %l6
  %t361 = insertvalue %EnumLayoutHeaderParse %t359, i8* %t360, 4
  %t362 = load double, double* %l11
  %t363 = insertvalue %EnumLayoutHeaderParse %t361, double %t362, 5
  %t364 = load double, double* %l12
  %t365 = insertvalue %EnumLayoutHeaderParse %t363, double %t364, 6
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t367 = insertvalue %EnumLayoutHeaderParse %t365, { i8**, i64 }* %t366, 7
  ret %EnumLayoutHeaderParse %t367
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
  %t334 = phi i1 [ %t44, %entry ], [ %t325, %loop.latch2 ]
  %t335 = phi double [ %t48, %entry ], [ %t326, %loop.latch2 ]
  %t336 = phi { i8**, i64 }* [ %t40, %entry ], [ %t327, %loop.latch2 ]
  %t337 = phi i1 [ %t45, %entry ], [ %t328, %loop.latch2 ]
  %t338 = phi double [ %t49, %entry ], [ %t329, %loop.latch2 ]
  %t339 = phi i1 [ %t46, %entry ], [ %t330, %loop.latch2 ]
  %t340 = phi double [ %t50, %entry ], [ %t331, %loop.latch2 ]
  %t341 = phi i1 [ %t47, %entry ], [ %t332, %loop.latch2 ]
  %t342 = phi double [ %t51, %entry ], [ %t333, %loop.latch2 ]
  store i1 %t334, i1* %l5
  store double %t335, double* %l9
  store { i8**, i64 }* %t336, { i8**, i64 }** %l1
  store i1 %t337, i1* %l6
  store double %t338, double* %l10
  store i1 %t339, i1* %l7
  store double %t340, double* %l11
  store i1 %t341, i1* %l8
  store double %t342, double* %l12
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
  br label %loop.latch2
loop.latch2:
  %t325 = load i1, i1* %l5
  %t326 = load double, double* %l9
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load i1, i1* %l6
  %t329 = load double, double* %l10
  %t330 = load i1, i1* %l7
  %t331 = load double, double* %l11
  %t332 = load i1, i1* %l8
  %t333 = load double, double* %l12
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l23
  %t343 = load i8*, i8** %l4
  %t344 = insertvalue %NativeEnumVariantLayout undef, i8* %t343, 0
  %t345 = load double, double* %l9
  %t346 = insertvalue %NativeEnumVariantLayout %t344, double %t345, 1
  %t347 = load double, double* %l10
  %t348 = insertvalue %NativeEnumVariantLayout %t346, double %t347, 2
  %t349 = load double, double* %l11
  %t350 = insertvalue %NativeEnumVariantLayout %t348, double %t349, 3
  %t351 = load double, double* %l12
  %t352 = insertvalue %NativeEnumVariantLayout %t350, double %t351, 4
  %t353 = alloca [0 x double]
  %t354 = getelementptr [0 x double], [0 x double]* %t353, i32 0, i32 0
  %t355 = alloca { double*, i64 }
  %t356 = getelementptr { double*, i64 }, { double*, i64 }* %t355, i32 0, i32 0
  store double* %t354, double** %t356
  %t357 = getelementptr { double*, i64 }, { double*, i64 }* %t355, i32 0, i32 1
  store i64 0, i64* %t357
  %t358 = insertvalue %NativeEnumVariantLayout %t352, { i8**, i64 }* null, 5
  store %NativeEnumVariantLayout %t358, %NativeEnumVariantLayout* %l24
  %t359 = load double, double* %l23
  %t360 = fcmp one double %t359, 0.0
  %t361 = insertvalue %EnumLayoutVariantParse undef, i1 %t360, 0
  %t362 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t363 = insertvalue %EnumLayoutVariantParse %t361, i8* null, 1
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t365 = insertvalue %EnumLayoutVariantParse %t363, { i8**, i64 }* %t364, 2
  ret %EnumLayoutVariantParse %t365
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
  %t30 = load double, double* %l5
  %t31 = load i8*, i8** %l4
  %t32 = load double, double* %l5
  %t33 = call double @substring(i8* %t31, i64 0, double %t32)
  store double %t33, double* %l6
  %t34 = load i8*, i8** %l4
  %t35 = load double, double* %l5
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  %t38 = load i8*, i8** %l4
  store double 0.0, double* %l7
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.39, i32 0, i32 0
  store i8* %s39, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t40 = sitofp i64 0 to double
  store double %t40, double* %l12
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l13
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l14
  %t43 = sitofp i64 1 to double
  store double %t43, double* %l15
  %t44 = load i8*, i8** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load double, double* %l6
  %t51 = load double, double* %l7
  %t52 = load i8*, i8** %l8
  %t53 = load i1, i1* %l9
  %t54 = load i1, i1* %l10
  %t55 = load i1, i1* %l11
  %t56 = load double, double* %l12
  %t57 = load double, double* %l13
  %t58 = load double, double* %l14
  %t59 = load double, double* %l15
  br label %loop.header0
loop.header0:
  %t317 = phi i8* [ %t52, %entry ], [ %t309, %loop.latch2 ]
  %t318 = phi i1 [ %t53, %entry ], [ %t310, %loop.latch2 ]
  %t319 = phi double [ %t56, %entry ], [ %t311, %loop.latch2 ]
  %t320 = phi { i8**, i64 }* [ %t45, %entry ], [ %t312, %loop.latch2 ]
  %t321 = phi i1 [ %t54, %entry ], [ %t313, %loop.latch2 ]
  %t322 = phi double [ %t57, %entry ], [ %t314, %loop.latch2 ]
  %t323 = phi i1 [ %t55, %entry ], [ %t315, %loop.latch2 ]
  %t324 = phi double [ %t58, %entry ], [ %t316, %loop.latch2 ]
  store i8* %t317, i8** %l8
  store i1 %t318, i1* %l9
  store double %t319, double* %l12
  store { i8**, i64 }* %t320, { i8**, i64 }** %l1
  store i1 %t321, i1* %l10
  store double %t322, double* %l13
  store i1 %t323, i1* %l11
  store double %t324, double* %l14
  br label %loop.body1
loop.body1:
  %t60 = load double, double* %l15
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t63 = load double, double* %l15
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t62
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  %t68 = getelementptr i8*, i8** %t65, i64 %t63
  %t69 = load i8*, i8** %t68
  store i8* %t69, i8** %l16
  %t70 = load i8*, i8** %l16
  %s71 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.71, i32 0, i32 0
  %t72 = call i1 @starts_with(i8* %t70, i8* %s71)
  %t73 = load i8*, i8** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t77 = load i8*, i8** %l4
  %t78 = load double, double* %l5
  %t79 = load double, double* %l6
  %t80 = load double, double* %l7
  %t81 = load i8*, i8** %l8
  %t82 = load i1, i1* %l9
  %t83 = load i1, i1* %l10
  %t84 = load i1, i1* %l11
  %t85 = load double, double* %l12
  %t86 = load double, double* %l13
  %t87 = load double, double* %l14
  %t88 = load double, double* %l15
  %t89 = load i8*, i8** %l16
  br i1 %t72, label %then4, label %else5
then4:
  %t90 = load i8*, i8** %l16
  %t91 = load i8*, i8** %l16
  br label %merge6
else5:
  %t92 = load i8*, i8** %l16
  %s93 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.93, i32 0, i32 0
  %t94 = call i1 @starts_with(i8* %t92, i8* %s93)
  %t95 = load i8*, i8** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t97 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t99 = load i8*, i8** %l4
  %t100 = load double, double* %l5
  %t101 = load double, double* %l6
  %t102 = load double, double* %l7
  %t103 = load i8*, i8** %l8
  %t104 = load i1, i1* %l9
  %t105 = load i1, i1* %l10
  %t106 = load i1, i1* %l11
  %t107 = load double, double* %l12
  %t108 = load double, double* %l13
  %t109 = load double, double* %l14
  %t110 = load double, double* %l15
  %t111 = load i8*, i8** %l16
  br i1 %t94, label %then7, label %else8
then7:
  %t112 = load i8*, i8** %l16
  %t113 = load i8*, i8** %l16
  store double 0.0, double* %l17
  %t114 = load double, double* %l17
  %t115 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t115, %NumberParseResult* %l18
  %t116 = load %NumberParseResult, %NumberParseResult* %l18
  %t117 = extractvalue %NumberParseResult %t116, 0
  %t118 = load i8*, i8** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t122 = load i8*, i8** %l4
  %t123 = load double, double* %l5
  %t124 = load double, double* %l6
  %t125 = load double, double* %l7
  %t126 = load i8*, i8** %l8
  %t127 = load i1, i1* %l9
  %t128 = load i1, i1* %l10
  %t129 = load i1, i1* %l11
  %t130 = load double, double* %l12
  %t131 = load double, double* %l13
  %t132 = load double, double* %l14
  %t133 = load double, double* %l15
  %t134 = load i8*, i8** %l16
  %t135 = load double, double* %l17
  %t136 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t117, label %then10, label %else11
then10:
  store i1 1, i1* %l9
  %t137 = load %NumberParseResult, %NumberParseResult* %l18
  %t138 = extractvalue %NumberParseResult %t137, 1
  store double %t138, double* %l12
  br label %merge12
else11:
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s140 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.140, i32 0, i32 0
  %t141 = add i8* %s140, %enum_name
  %s142 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.142, i32 0, i32 0
  %t143 = add i8* %t141, %s142
  %t144 = load i8*, i8** %l4
  %t145 = add i8* %t143, %t144
  %s146 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.146, i32 0, i32 0
  %t147 = add i8* %t145, %s146
  %t148 = load double, double* %l17
  br label %merge12
merge12:
  %t149 = phi i1 [ 1, %then10 ], [ %t127, %else11 ]
  %t150 = phi double [ %t138, %then10 ], [ %t130, %else11 ]
  %t151 = phi { i8**, i64 }* [ %t119, %then10 ], [ null, %else11 ]
  store i1 %t149, i1* %l9
  store double %t150, double* %l12
  store { i8**, i64 }* %t151, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t152 = load i8*, i8** %l16
  %s153 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.153, i32 0, i32 0
  %t154 = call i1 @starts_with(i8* %t152, i8* %s153)
  %t155 = load i8*, i8** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t159 = load i8*, i8** %l4
  %t160 = load double, double* %l5
  %t161 = load double, double* %l6
  %t162 = load double, double* %l7
  %t163 = load i8*, i8** %l8
  %t164 = load i1, i1* %l9
  %t165 = load i1, i1* %l10
  %t166 = load i1, i1* %l11
  %t167 = load double, double* %l12
  %t168 = load double, double* %l13
  %t169 = load double, double* %l14
  %t170 = load double, double* %l15
  %t171 = load i8*, i8** %l16
  br i1 %t154, label %then13, label %else14
then13:
  %t172 = load i8*, i8** %l16
  %t173 = load i8*, i8** %l16
  store double 0.0, double* %l19
  %t174 = load double, double* %l19
  %t175 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t175, %NumberParseResult* %l20
  %t176 = load %NumberParseResult, %NumberParseResult* %l20
  %t177 = extractvalue %NumberParseResult %t176, 0
  %t178 = load i8*, i8** %l0
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t180 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t182 = load i8*, i8** %l4
  %t183 = load double, double* %l5
  %t184 = load double, double* %l6
  %t185 = load double, double* %l7
  %t186 = load i8*, i8** %l8
  %t187 = load i1, i1* %l9
  %t188 = load i1, i1* %l10
  %t189 = load i1, i1* %l11
  %t190 = load double, double* %l12
  %t191 = load double, double* %l13
  %t192 = load double, double* %l14
  %t193 = load double, double* %l15
  %t194 = load i8*, i8** %l16
  %t195 = load double, double* %l19
  %t196 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t177, label %then16, label %else17
then16:
  store i1 1, i1* %l10
  %t197 = load %NumberParseResult, %NumberParseResult* %l20
  %t198 = extractvalue %NumberParseResult %t197, 1
  store double %t198, double* %l13
  br label %merge18
else17:
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s200 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.200, i32 0, i32 0
  %t201 = add i8* %s200, %enum_name
  %s202 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.202, i32 0, i32 0
  %t203 = add i8* %t201, %s202
  %t204 = load i8*, i8** %l4
  %t205 = add i8* %t203, %t204
  %s206 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.206, i32 0, i32 0
  %t207 = add i8* %t205, %s206
  %t208 = load double, double* %l19
  br label %merge18
merge18:
  %t209 = phi i1 [ 1, %then16 ], [ %t188, %else17 ]
  %t210 = phi double [ %t198, %then16 ], [ %t191, %else17 ]
  %t211 = phi { i8**, i64 }* [ %t179, %then16 ], [ null, %else17 ]
  store i1 %t209, i1* %l10
  store double %t210, double* %l13
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t212 = load i8*, i8** %l16
  %s213 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.213, i32 0, i32 0
  %t214 = call i1 @starts_with(i8* %t212, i8* %s213)
  %t215 = load i8*, i8** %l0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t219 = load i8*, i8** %l4
  %t220 = load double, double* %l5
  %t221 = load double, double* %l6
  %t222 = load double, double* %l7
  %t223 = load i8*, i8** %l8
  %t224 = load i1, i1* %l9
  %t225 = load i1, i1* %l10
  %t226 = load i1, i1* %l11
  %t227 = load double, double* %l12
  %t228 = load double, double* %l13
  %t229 = load double, double* %l14
  %t230 = load double, double* %l15
  %t231 = load i8*, i8** %l16
  br i1 %t214, label %then19, label %else20
then19:
  %t232 = load i8*, i8** %l16
  %t233 = load i8*, i8** %l16
  store double 0.0, double* %l21
  %t234 = load double, double* %l21
  %t235 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t235, %NumberParseResult* %l22
  %t236 = load %NumberParseResult, %NumberParseResult* %l22
  %t237 = extractvalue %NumberParseResult %t236, 0
  %t238 = load i8*, i8** %l0
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t240 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t242 = load i8*, i8** %l4
  %t243 = load double, double* %l5
  %t244 = load double, double* %l6
  %t245 = load double, double* %l7
  %t246 = load i8*, i8** %l8
  %t247 = load i1, i1* %l9
  %t248 = load i1, i1* %l10
  %t249 = load i1, i1* %l11
  %t250 = load double, double* %l12
  %t251 = load double, double* %l13
  %t252 = load double, double* %l14
  %t253 = load double, double* %l15
  %t254 = load i8*, i8** %l16
  %t255 = load double, double* %l21
  %t256 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t237, label %then22, label %else23
then22:
  store i1 1, i1* %l11
  %t257 = load %NumberParseResult, %NumberParseResult* %l22
  %t258 = extractvalue %NumberParseResult %t257, 1
  store double %t258, double* %l14
  br label %merge24
else23:
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s260 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.260, i32 0, i32 0
  %t261 = add i8* %s260, %enum_name
  %s262 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.262, i32 0, i32 0
  %t263 = add i8* %t261, %s262
  %t264 = load i8*, i8** %l4
  %t265 = add i8* %t263, %t264
  %s266 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.266, i32 0, i32 0
  %t267 = add i8* %t265, %s266
  %t268 = load double, double* %l21
  br label %merge24
merge24:
  %t269 = phi i1 [ 1, %then22 ], [ %t249, %else23 ]
  %t270 = phi double [ %t258, %then22 ], [ %t252, %else23 ]
  %t271 = phi { i8**, i64 }* [ %t239, %then22 ], [ null, %else23 ]
  store i1 %t269, i1* %l11
  store double %t270, double* %l14
  store { i8**, i64 }* %t271, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s273 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.273, i32 0, i32 0
  %t274 = add i8* %s273, %enum_name
  %s275 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.275, i32 0, i32 0
  %t276 = add i8* %t274, %s275
  %t277 = load i8*, i8** %l4
  %t278 = add i8* %t276, %t277
  %s279 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.279, i32 0, i32 0
  %t280 = add i8* %t278, %s279
  %t281 = load i8*, i8** %l16
  %t282 = add i8* %t280, %t281
  %s283 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.283, i32 0, i32 0
  %t284 = add i8* %t282, %s283
  %t285 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t272, i8* %t284)
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  br label %merge21
merge21:
  %t286 = phi i1 [ 1, %then19 ], [ %t226, %else20 ]
  %t287 = phi double [ %t258, %then19 ], [ %t229, %else20 ]
  %t288 = phi { i8**, i64 }* [ null, %then19 ], [ %t285, %else20 ]
  store i1 %t286, i1* %l11
  store double %t287, double* %l14
  store { i8**, i64 }* %t288, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t289 = phi i1 [ 1, %then13 ], [ %t165, %else14 ]
  %t290 = phi double [ %t198, %then13 ], [ %t168, %else14 ]
  %t291 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t292 = phi i1 [ %t166, %then13 ], [ 1, %else14 ]
  %t293 = phi double [ %t169, %then13 ], [ %t258, %else14 ]
  store i1 %t289, i1* %l10
  store double %t290, double* %l13
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  store i1 %t292, i1* %l11
  store double %t293, double* %l14
  br label %merge9
merge9:
  %t294 = phi i1 [ 1, %then7 ], [ %t104, %else8 ]
  %t295 = phi double [ %t138, %then7 ], [ %t107, %else8 ]
  %t296 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t297 = phi i1 [ %t105, %then7 ], [ 1, %else8 ]
  %t298 = phi double [ %t108, %then7 ], [ %t198, %else8 ]
  %t299 = phi i1 [ %t106, %then7 ], [ 1, %else8 ]
  %t300 = phi double [ %t109, %then7 ], [ %t258, %else8 ]
  store i1 %t294, i1* %l9
  store double %t295, double* %l12
  store { i8**, i64 }* %t296, { i8**, i64 }** %l1
  store i1 %t297, i1* %l10
  store double %t298, double* %l13
  store i1 %t299, i1* %l11
  store double %t300, double* %l14
  br label %merge6
merge6:
  %t301 = phi i8* [ null, %then4 ], [ %t81, %else5 ]
  %t302 = phi i1 [ %t82, %then4 ], [ 1, %else5 ]
  %t303 = phi double [ %t85, %then4 ], [ %t138, %else5 ]
  %t304 = phi { i8**, i64 }* [ %t74, %then4 ], [ null, %else5 ]
  %t305 = phi i1 [ %t83, %then4 ], [ 1, %else5 ]
  %t306 = phi double [ %t86, %then4 ], [ %t198, %else5 ]
  %t307 = phi i1 [ %t84, %then4 ], [ 1, %else5 ]
  %t308 = phi double [ %t87, %then4 ], [ %t258, %else5 ]
  store i8* %t301, i8** %l8
  store i1 %t302, i1* %l9
  store double %t303, double* %l12
  store { i8**, i64 }* %t304, { i8**, i64 }** %l1
  store i1 %t305, i1* %l10
  store double %t306, double* %l13
  store i1 %t307, i1* %l11
  store double %t308, double* %l14
  br label %loop.latch2
loop.latch2:
  %t309 = load i8*, i8** %l8
  %t310 = load i1, i1* %l9
  %t311 = load double, double* %l12
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t313 = load i1, i1* %l10
  %t314 = load double, double* %l13
  %t315 = load i1, i1* %l11
  %t316 = load double, double* %l14
  br label %loop.header0
afterloop3:
  %t325 = load i8*, i8** %l8
  %t326 = load i8*, i8** %l8
  store double 0.0, double* %l23
  %t327 = load double, double* %l7
  %t328 = insertvalue %NativeStructLayoutField undef, i8* null, 0
  %t329 = load i8*, i8** %l8
  %t330 = insertvalue %NativeStructLayoutField %t328, i8* %t329, 1
  %t331 = load double, double* %l12
  %t332 = insertvalue %NativeStructLayoutField %t330, double %t331, 2
  %t333 = load double, double* %l13
  %t334 = insertvalue %NativeStructLayoutField %t332, double %t333, 3
  %t335 = load double, double* %l14
  %t336 = insertvalue %NativeStructLayoutField %t334, double %t335, 4
  store %NativeStructLayoutField %t336, %NativeStructLayoutField* %l24
  %t337 = load double, double* %l23
  %t338 = fcmp one double %t337, 0.0
  %t339 = insertvalue %EnumLayoutPayloadParse undef, i1 %t338, 0
  %t340 = load double, double* %l6
  %t341 = insertvalue %EnumLayoutPayloadParse %t339, i8* null, 1
  %t342 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t343 = insertvalue %EnumLayoutPayloadParse %t341, i8* null, 2
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t345 = insertvalue %EnumLayoutPayloadParse %t343, { i8**, i64 }* %t344, 3
  ret %EnumLayoutPayloadParse %t345
}

define %NativeInstruction @parse_let_instruction(i8* %line, double %span, double %value_span) {
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
  %t42 = call noalias i8* @malloc(i64 8)
  %t43 = bitcast i8* %t42 to double*
  store double %span, double* %t43
  %t44 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t45 = bitcast [48 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to i8**
  store i8* %t42, i8** %t47
  %t48 = call noalias i8* @malloc(i64 8)
  %t49 = bitcast i8* %t48 to double*
  store double %value_span, double* %t49
  %t50 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t51 = bitcast [48 x i8]* %t50 to i8*
  %t52 = getelementptr inbounds i8, i8* %t51, i64 40
  %t53 = bitcast i8* %t52 to i8**
  store i8* %t48, i8** %t53
  %t54 = load %NativeInstruction, %NativeInstruction* %t18
  ret %NativeInstruction %t54
}

define %BindingComponents @parse_binding_components(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t12 = phi i8* [ %t2, %entry ], [ %t11, %loop.latch2 ]
  store i8* %t12, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = load i8*, i8** %l0
  %t10 = load i8, i8* %l2
  br label %loop.latch2
loop.latch2:
  %t11 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l3
  store double 0.0, double* %l4
  %t16 = load double, double* %l1
  store i8* null, i8** %l5
  %t17 = load i8*, i8** %l5
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %BindingComponents undef, i8* %t18, 0
  %t20 = load i8*, i8** %l3
  %t21 = insertvalue %BindingComponents %t19, i8* %t20, 1
  %t22 = load double, double* %l4
  %t23 = insertvalue %BindingComponents %t21, i8* null, 2
  ret %BindingComponents %t23
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
  %t28 = phi i8* [ %t10, %entry ], [ %t27, %loop.latch2 ]
  store i8* %t28, i8** %l1
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = getelementptr i8, i8* %body, i64 %t15
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l5
  %t18 = load i8*, i8** %l4
  %t19 = load i8, i8* %l5
  %t20 = load i8, i8* %l5
  %s21 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.21, i32 0, i32 0
  %t22 = load i8, i8* %l5
  %t23 = load i8, i8* %l5
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  %t25 = load i8*, i8** %l1
  %t26 = load i8, i8* %l5
  br label %loop.latch2
loop.latch2:
  %t27 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l1
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l6
  %t31 = load i8*, i8** %l6
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t32
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  %t4 = call { i8**, i64 }* @split_comma_separated(i8* %t3)
  ret { i8**, i64 }* %t4
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
  %t52 = phi { i8**, i64 }* [ %t7, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t8, %entry ], [ %t51, %loop.latch2 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  store double %t53, double* %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  store double 0.0, double* %l4
  %t15 = load double, double* %l4
  %t16 = fcmp one double %t15, 0.0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load double, double* %l2
  %t20 = load i8, i8* %l3
  %t21 = load double, double* %l4
  br i1 %t16, label %then4, label %else5
then4:
  %t22 = load double, double* %l1
  %t23 = sitofp i64 0 to double
  %t24 = fcmp oge double %t22, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  %t28 = load i8, i8* %l3
  %t29 = load double, double* %l4
  br i1 %t24, label %then7, label %merge8
then7:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = call double @substring(i8* %value, double %t31, double %t32)
  %t34 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t30, i8* null)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = sitofp i64 -1 to double
  store double %t35, double* %l1
  br label %merge8
merge8:
  %t36 = phi { i8**, i64 }* [ %t34, %then7 ], [ %t25, %then4 ]
  %t37 = phi double [ %t35, %then7 ], [ %t26, %then4 ]
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  store double %t37, double* %l1
  br label %merge6
else5:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 0 to double
  %t40 = fcmp olt double %t38, %t39
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load i8, i8* %l3
  %t45 = load double, double* %l4
  br i1 %t40, label %then9, label %merge10
then9:
  %t46 = load double, double* %l2
  store double %t46, double* %l1
  br label %merge10
merge10:
  %t47 = phi double [ %t46, %then9 ], [ %t42, %else5 ]
  store double %t47, double* %l1
  br label %merge6
merge6:
  %t48 = phi { i8**, i64 }* [ %t34, %then4 ], [ %t17, %else5 ]
  %t49 = phi double [ %t35, %then4 ], [ %t46, %else5 ]
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 0 to double
  %t56 = fcmp oge double %t54, %t55
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  br i1 %t56, label %then11, label %merge12
then11:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load double, double* %l1
  br label %merge12
merge12:
  %t62 = phi { i8**, i64 }* [ null, %then11 ], [ %t57, %entry ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t63
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
  %t31 = phi double [ %t12, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l4
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
  %t21 = load double, double* %l6
  %t22 = load double, double* %l6
  %t23 = load double, double* %l1
  %t24 = fsub double %t22, %t23
  store double %t24, double* %l7
  %t25 = load double, double* %l4
  %t26 = sitofp i64 10 to double
  %t27 = fmul double %t25, %t26
  %t28 = load double, double* %l7
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l4
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t32 = insertvalue %NumberParseResult undef, i1 1, 0
  %t33 = load double, double* %l4
  %t34 = insertvalue %NumberParseResult %t32, double %t33, 1
  ret %NumberParseResult %t34
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
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t16, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t19
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
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = getelementptr i8, i8* %value, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l3
  %t14 = load i8, i8* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load i8*, i8** %l1
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t27 = load double, double* %l2
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l2
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l5
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t38
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
  %t23 = phi i8* [ %t3, %entry ], [ %t22, %loop.latch2 ]
  store i8* %t23, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t22 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @trim_text(i8* %t24)
  ret i8* %t25
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
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l1
  %t19 = load double, double* %l0
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t23 = load double, double* %l3
  %t24 = call i1 @is_trim_char(i8* null)
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l3
  br i1 %t24, label %then14, label %merge15
then14:
  %t28 = load double, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = call double @substring(i8* %value, double %t30, double %t31)
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
  %t363 = phi { i8**, i64 }* [ %t18, %entry ], [ %t360, %loop.latch2 ]
  %t364 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t361, %loop.latch2 ]
  %t365 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t362, %loop.latch2 ]
  store { i8**, i64 }* %t363, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t364, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t365, { %NativeEnum*, i64 }** %l3
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
  br label %loop.latch2
merge5:
  %t45 = load i8*, i8** %l6
  %s46 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.46, i32 0, i32 0
  %t47 = call i1 @starts_with(i8* %t45, i8* %s46)
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t51 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t52 = load double, double* %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i8*, i8** %l6
  br i1 %t47, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t55 = load i8*, i8** %l6
  %s56 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.56, i32 0, i32 0
  %t57 = call i1 @starts_with(i8* %t55, i8* %s56)
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t61 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t62 = load double, double* %l4
  %t63 = load i8*, i8** %l5
  %t64 = load i8*, i8** %l6
  br i1 %t57, label %then8, label %merge9
then8:
  %t65 = load i8*, i8** %l6
  %s66 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.66, i32 0, i32 0
  %t67 = call i8* @strip_prefix(i8* %t65, i8* %s66)
  store i8* %t67, i8** %l7
  %t68 = load i8*, i8** %l7
  %s69 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.69, i32 0, i32 0
  %t70 = call i8* @strip_prefix(i8* %t68, i8* %s69)
  store i8* %t70, i8** %l8
  %t71 = load i8*, i8** %l8
  %t72 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t71)
  store %StructLayoutHeaderParse %t72, %StructLayoutHeaderParse* %l9
  %t73 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t74 = extractvalue %StructLayoutHeaderParse %t73, 4
  %t75 = call double @diagnosticsconcat({ i8**, i64 }* %t74)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t76 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t77 = extractvalue %StructLayoutHeaderParse %t76, 0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t81 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t82 = load double, double* %l4
  %t83 = load i8*, i8** %l5
  %t84 = load i8*, i8** %l6
  %t85 = load i8*, i8** %l7
  %t86 = load i8*, i8** %l8
  %t87 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t77, label %then10, label %merge11
then10:
  %t88 = alloca [0 x double]
  %t89 = getelementptr [0 x double], [0 x double]* %t88, i32 0, i32 0
  %t90 = alloca { double*, i64 }
  %t91 = getelementptr { double*, i64 }, { double*, i64 }* %t90, i32 0, i32 0
  store double* %t89, double** %t91
  %t92 = getelementptr { double*, i64 }, { double*, i64 }* %t90, i32 0, i32 1
  store i64 0, i64* %t92
  store { %NativeStructLayoutField*, i64 }* null, { %NativeStructLayoutField*, i64 }** %l10
  %t93 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t94 = extractvalue %StructLayoutHeaderParse %t93, 1
  store i8* %t94, i8** %l11
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t97 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t98 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t99 = load double, double* %l4
  %t100 = load i8*, i8** %l5
  %t101 = load i8*, i8** %l6
  %t102 = load i8*, i8** %l7
  %t103 = load i8*, i8** %l8
  %t104 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t105 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t106 = load i8*, i8** %l11
  br label %loop.header12
loop.header12:
  %t174 = phi i8* [ %t102, %then10 ], [ %t171, %loop.latch14 ]
  %t175 = phi { i8**, i64 }* [ %t96, %then10 ], [ %t172, %loop.latch14 ]
  %t176 = phi { %NativeStructLayoutField*, i64 }* [ %t105, %then10 ], [ %t173, %loop.latch14 ]
  store i8* %t174, i8** %l7
  store { i8**, i64 }* %t175, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t176, { %NativeStructLayoutField*, i64 }** %l10
  br label %loop.body13
loop.body13:
  %t107 = load double, double* %l4
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load double, double* %l4
  %t111 = load { i8**, i64 }, { i8**, i64 }* %t109
  %t112 = extractvalue { i8**, i64 } %t111, 0
  %t113 = extractvalue { i8**, i64 } %t111, 1
  %t114 = icmp uge i64 %t110, %t113
  ; bounds check: %t114 (if true, out of bounds)
  %t115 = getelementptr i8*, i8** %t112, i64 %t110
  %t116 = load i8*, i8** %t115
  %t117 = call i8* @trim_text(i8* %t116)
  store i8* %t117, i8** %l12
  %t118 = load i8*, i8** %l12
  %t119 = load i8*, i8** %l12
  %s120 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.120, i32 0, i32 0
  %t121 = call double @starts_with(i8* %t119, i8* %s120)
  %t122 = fcmp one double %t121, 0.0
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t125 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t126 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t127 = load double, double* %l4
  %t128 = load i8*, i8** %l5
  %t129 = load i8*, i8** %l6
  %t130 = load i8*, i8** %l7
  %t131 = load i8*, i8** %l8
  %t132 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t133 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t134 = load i8*, i8** %l11
  %t135 = load i8*, i8** %l12
  br i1 %t122, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t136 = load i8*, i8** %l12
  %s137 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i8* @strip_prefix(i8* %t136, i8* %s137)
  store i8* %t138, i8** %l13
  %t139 = load i8*, i8** %l7
  %s140 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.140, i32 0, i32 0
  %t141 = call i8* @strip_prefix(i8* %t139, i8* %s140)
  store i8* %t141, i8** %l14
  %t142 = load i8*, i8** %l14
  %t143 = load i8*, i8** %l11
  %t144 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t142, i8* %t143)
  store %StructLayoutFieldParse %t144, %StructLayoutFieldParse* %l15
  %t145 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t146 = extractvalue %StructLayoutFieldParse %t145, 2
  %t147 = call double @diagnosticsconcat({ i8**, i64 }* %t146)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t148 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t149 = extractvalue %StructLayoutFieldParse %t148, 0
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t153 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t154 = load double, double* %l4
  %t155 = load i8*, i8** %l5
  %t156 = load i8*, i8** %l6
  %t157 = load i8*, i8** %l7
  %t158 = load i8*, i8** %l8
  %t159 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t160 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t161 = load i8*, i8** %l11
  %t162 = load i8*, i8** %l12
  %t163 = load i8*, i8** %l13
  %t164 = load i8*, i8** %l14
  %t165 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t149, label %then18, label %merge19
then18:
  %t166 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t167 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t168 = extractvalue %StructLayoutFieldParse %t167, 1
  %t169 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t166, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t169, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge19
merge19:
  %t170 = phi { %NativeStructLayoutField*, i64 }* [ %t169, %then18 ], [ %t160, %loop.body13 ]
  store { %NativeStructLayoutField*, i64 }* %t170, { %NativeStructLayoutField*, i64 }** %l10
  br label %loop.latch14
loop.latch14:
  %t171 = load i8*, i8** %l7
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t173 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  br label %loop.header12
afterloop15:
  store double 0.0, double* %l16
  %t177 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t178 = load double, double* %l16
  %t179 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t177, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t179, { %NativeStruct*, i64 }** %l2
  br label %merge11
merge11:
  %t180 = phi i8* [ %t138, %then10 ], [ %t85, %then8 ]
  %t181 = phi { i8**, i64 }* [ null, %then10 ], [ %t79, %then8 ]
  %t182 = phi { %NativeStruct*, i64 }* [ %t179, %then10 ], [ %t80, %then8 ]
  store i8* %t180, i8** %l7
  store { i8**, i64 }* %t181, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t182, { %NativeStruct*, i64 }** %l2
  br label %loop.latch2
merge9:
  %t183 = load i8*, i8** %l6
  %s184 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.184, i32 0, i32 0
  %t185 = call i1 @starts_with(i8* %t183, i8* %s184)
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t188 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t189 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t190 = load double, double* %l4
  %t191 = load i8*, i8** %l5
  %t192 = load i8*, i8** %l6
  br i1 %t185, label %then20, label %merge21
then20:
  %t193 = load i8*, i8** %l6
  %s194 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.194, i32 0, i32 0
  %t195 = call i8* @strip_prefix(i8* %t193, i8* %s194)
  store i8* %t195, i8** %l17
  %t196 = load i8*, i8** %l17
  %s197 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.197, i32 0, i32 0
  %t198 = call i8* @strip_prefix(i8* %t196, i8* %s197)
  store i8* %t198, i8** %l18
  %t199 = load i8*, i8** %l18
  %t200 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t199)
  store %EnumLayoutHeaderParse %t200, %EnumLayoutHeaderParse* %l19
  %t201 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t202 = extractvalue %EnumLayoutHeaderParse %t201, 7
  %t203 = call double @diagnosticsconcat({ i8**, i64 }* %t202)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t204 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t205 = extractvalue %EnumLayoutHeaderParse %t204, 0
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t208 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t209 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t210 = load double, double* %l4
  %t211 = load i8*, i8** %l5
  %t212 = load i8*, i8** %l6
  %t213 = load i8*, i8** %l17
  %t214 = load i8*, i8** %l18
  %t215 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t205, label %then22, label %else23
then22:
  %t216 = alloca [0 x double]
  %t217 = getelementptr [0 x double], [0 x double]* %t216, i32 0, i32 0
  %t218 = alloca { double*, i64 }
  %t219 = getelementptr { double*, i64 }, { double*, i64 }* %t218, i32 0, i32 0
  store double* %t217, double** %t219
  %t220 = getelementptr { double*, i64 }, { double*, i64 }* %t218, i32 0, i32 1
  store i64 0, i64* %t220
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l20
  %t221 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t222 = extractvalue %EnumLayoutHeaderParse %t221, 1
  store i8* %t222, i8** %l21
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t226 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t227 = load double, double* %l4
  %t228 = load i8*, i8** %l5
  %t229 = load i8*, i8** %l6
  %t230 = load i8*, i8** %l17
  %t231 = load i8*, i8** %l18
  %t232 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t233 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t234 = load i8*, i8** %l21
  br label %loop.header25
loop.header25:
  %t351 = phi i8* [ %t230, %then22 ], [ %t348, %loop.latch27 ]
  %t352 = phi { i8**, i64 }* [ %t224, %then22 ], [ %t349, %loop.latch27 ]
  %t353 = phi { %NativeEnumVariantLayout*, i64 }* [ %t233, %then22 ], [ %t350, %loop.latch27 ]
  store i8* %t351, i8** %l17
  store { i8**, i64 }* %t352, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t353, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body26
loop.body26:
  %t235 = load double, double* %l4
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t238 = load double, double* %l4
  %t239 = load { i8**, i64 }, { i8**, i64 }* %t237
  %t240 = extractvalue { i8**, i64 } %t239, 0
  %t241 = extractvalue { i8**, i64 } %t239, 1
  %t242 = icmp uge i64 %t238, %t241
  ; bounds check: %t242 (if true, out of bounds)
  %t243 = getelementptr i8*, i8** %t240, i64 %t238
  %t244 = load i8*, i8** %t243
  %t245 = call i8* @trim_text(i8* %t244)
  store i8* %t245, i8** %l22
  %t246 = load i8*, i8** %l22
  %t247 = load i8*, i8** %l22
  %s248 = getelementptr inbounds [67 x i8], [67 x i8]* @.str.248, i32 0, i32 0
  %t249 = call double @starts_with(i8* %t247, i8* %s248)
  %t250 = fcmp one double %t249, 0.0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t254 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t255 = load double, double* %l4
  %t256 = load i8*, i8** %l5
  %t257 = load i8*, i8** %l6
  %t258 = load i8*, i8** %l17
  %t259 = load i8*, i8** %l18
  %t260 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t261 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t262 = load i8*, i8** %l21
  %t263 = load i8*, i8** %l22
  br i1 %t250, label %then29, label %merge30
then29:
  br label %afterloop28
merge30:
  %t264 = load i8*, i8** %l22
  %s265 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.265, i32 0, i32 0
  %t266 = call i1 @starts_with(i8* %t264, i8* %s265)
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t270 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t271 = load double, double* %l4
  %t272 = load i8*, i8** %l5
  %t273 = load i8*, i8** %l6
  %t274 = load i8*, i8** %l17
  %t275 = load i8*, i8** %l18
  %t276 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t277 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t278 = load i8*, i8** %l21
  %t279 = load i8*, i8** %l22
  br i1 %t266, label %then31, label %else32
then31:
  %t280 = load i8*, i8** %l22
  %s281 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.281, i32 0, i32 0
  %t282 = call i8* @strip_prefix(i8* %t280, i8* %s281)
  store i8* %t282, i8** %l23
  %t283 = load i8*, i8** %l17
  %s284 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.284, i32 0, i32 0
  %t285 = call i8* @strip_prefix(i8* %t283, i8* %s284)
  store i8* %t285, i8** %l24
  %t286 = load i8*, i8** %l24
  %t287 = load i8*, i8** %l21
  %t288 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t286, i8* %t287)
  store %EnumLayoutVariantParse %t288, %EnumLayoutVariantParse* %l25
  %t289 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t290 = extractvalue %EnumLayoutVariantParse %t289, 2
  %t291 = call double @diagnosticsconcat({ i8**, i64 }* %t290)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t292 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t293 = extractvalue %EnumLayoutVariantParse %t292, 0
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t297 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t298 = load double, double* %l4
  %t299 = load i8*, i8** %l5
  %t300 = load i8*, i8** %l6
  %t301 = load i8*, i8** %l17
  %t302 = load i8*, i8** %l18
  %t303 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t304 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t305 = load i8*, i8** %l21
  %t306 = load i8*, i8** %l22
  %t307 = load i8*, i8** %l23
  %t308 = load i8*, i8** %l24
  %t309 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t293, label %then34, label %merge35
then34:
  %t310 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t311 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t312 = extractvalue %EnumLayoutVariantParse %t311, 1
  %t313 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t310, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t313, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge35
merge35:
  %t314 = phi { %NativeEnumVariantLayout*, i64 }* [ %t313, %then34 ], [ %t304, %then31 ]
  store { %NativeEnumVariantLayout*, i64 }* %t314, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge33
else32:
  %t315 = load i8*, i8** %l22
  %s316 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.316, i32 0, i32 0
  %t317 = call i1 @starts_with(i8* %t315, i8* %s316)
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t320 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t321 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t322 = load double, double* %l4
  %t323 = load i8*, i8** %l5
  %t324 = load i8*, i8** %l6
  %t325 = load i8*, i8** %l17
  %t326 = load i8*, i8** %l18
  %t327 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t328 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t329 = load i8*, i8** %l21
  %t330 = load i8*, i8** %l22
  br i1 %t317, label %then36, label %merge37
then36:
  %t331 = load i8*, i8** %l22
  %s332 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.332, i32 0, i32 0
  %t333 = call i8* @strip_prefix(i8* %t331, i8* %s332)
  store i8* %t333, i8** %l26
  %t334 = load i8*, i8** %l17
  %s335 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.335, i32 0, i32 0
  %t336 = call i8* @strip_prefix(i8* %t334, i8* %s335)
  store i8* %t336, i8** %l27
  %t337 = load i8*, i8** %l27
  %t338 = load i8*, i8** %l21
  %t339 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t337, i8* %t338)
  store %EnumLayoutPayloadParse %t339, %EnumLayoutPayloadParse* %l28
  %t340 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t341 = extractvalue %EnumLayoutPayloadParse %t340, 3
  %t342 = call double @diagnosticsconcat({ i8**, i64 }* %t341)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t343 = phi i8* [ %t333, %then36 ], [ %t325, %else32 ]
  %t344 = phi { i8**, i64 }* [ null, %then36 ], [ %t319, %else32 ]
  store i8* %t343, i8** %l17
  store { i8**, i64 }* %t344, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t345 = phi i8* [ %t282, %then31 ], [ %t333, %else32 ]
  %t346 = phi { i8**, i64 }* [ null, %then31 ], [ null, %else32 ]
  %t347 = phi { %NativeEnumVariantLayout*, i64 }* [ %t313, %then31 ], [ %t277, %else32 ]
  store i8* %t345, i8** %l17
  store { i8**, i64 }* %t346, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t347, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.latch27
loop.latch27:
  %t348 = load i8*, i8** %l17
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t350 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header25
afterloop28:
  store double 0.0, double* %l29
  %t354 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t355 = load double, double* %l29
  %t356 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t354, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t356, { %NativeEnum*, i64 }** %l3
  br label %merge24
else23:
  br label %merge24
merge24:
  %t357 = phi i8* [ %t282, %then22 ], [ %t213, %else23 ]
  %t358 = phi { i8**, i64 }* [ null, %then22 ], [ %t207, %else23 ]
  %t359 = phi { %NativeEnum*, i64 }* [ %t356, %then22 ], [ %t209, %else23 ]
  store i8* %t357, i8** %l17
  store { i8**, i64 }* %t358, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t359, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge21:
  br label %loop.latch2
loop.latch2:
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t361 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t362 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t366 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t367 = insertvalue %LayoutManifest undef, { i8**, i64 }* null, 0
  %t368 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t369 = insertvalue %LayoutManifest %t367, { i8**, i64 }* null, 1
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t371 = insertvalue %LayoutManifest %t369, { i8**, i64 }* %t370, 2
  ret %LayoutManifest %t371
}

define i1 @is_trim_char(i8* %ch) {
entry:
  ret i1 false
}

define i1 @starts_with(i8* %value, i8* %prefix) {
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
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  br label %loop.latch2
loop.latch2:
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

define double @last_index_of(i8* %value, i8* %target) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
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
  br label %loop.body7
loop.body7:
  %t9 = load double, double* %l1
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t10 = load i1, i1* %l2
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  %t13 = load i1, i1* %l2
  br i1 %t10, label %then10, label %merge11
then10:
  %t14 = load double, double* %l0
  ret double %t14
merge11:
  %t15 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = sitofp i64 -1 to double
  ret double %t16
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
