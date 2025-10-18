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
@.str.6 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.6 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.24 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.102 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.8 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.11 = private unnamed_addr constant [2 x i8] c" \00"
@.str.21 = private unnamed_addr constant [2 x i8] c".\00"
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
  %l12 = alloca double
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
  %t385 = phi { i8**, i64 }* [ %t38, %entry ], [ %t380, %loop.latch2 ]
  %t386 = phi double [ %t48, %entry ], [ %t381, %loop.latch2 ]
  %t387 = phi double [ %t45, %entry ], [ %t382, %loop.latch2 ]
  %t388 = phi double [ %t46, %entry ], [ %t383, %loop.latch2 ]
  %t389 = phi double [ %t47, %entry ], [ %t384, %loop.latch2 ]
  store { i8**, i64 }* %t385, { i8**, i64 }** %l1
  store double %t386, double* %l11
  store double %t387, double* %l8
  store double %t388, double* %l9
  store double %t389, double* %l10
  br label %loop.body1
loop.body1:
  %t49 = load double, double* %l11
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l12
  %t51 = load double, double* %l12
  %t52 = call i8* @trim_text(i8* null)
  store i8* %t52, i8** %l13
  %t53 = load i8*, i8** %l13
  %t54 = load i8*, i8** %l13
  %s55 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.55, i32 0, i32 0
  %t56 = call i1 @starts_with(i8* %t54, i8* %s55)
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t60 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t61 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t62 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t63 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t64 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t65 = load double, double* %l8
  %t66 = load double, double* %l9
  %t67 = load double, double* %l10
  %t68 = load double, double* %l11
  %t69 = load double, double* %l12
  %t70 = load i8*, i8** %l13
  br i1 %t56, label %then4, label %merge5
then4:
  br label %loop.latch2
merge5:
  %t71 = load i8*, i8** %l13
  %s72 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.72, i32 0, i32 0
  %t73 = call i1 @starts_with(i8* %t71, i8* %s72)
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t77 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t78 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t79 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t80 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t81 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t82 = load double, double* %l8
  %t83 = load double, double* %l9
  %t84 = load double, double* %l10
  %t85 = load double, double* %l11
  %t86 = load double, double* %l12
  %t87 = load i8*, i8** %l13
  br i1 %t73, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t88 = load i8*, i8** %l13
  %s89 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.89, i32 0, i32 0
  %t90 = call i1 @starts_with(i8* %t88, i8* %s89)
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t94 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t95 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t96 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t97 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t98 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t99 = load double, double* %l8
  %t100 = load double, double* %l9
  %t101 = load double, double* %l10
  %t102 = load double, double* %l11
  %t103 = load double, double* %l12
  %t104 = load i8*, i8** %l13
  br i1 %t90, label %then8, label %merge9
then8:
  %s105 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.105, i32 0, i32 0
  %t106 = load i8*, i8** %l13
  %s107 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.107, i32 0, i32 0
  %t108 = call i8* @strip_prefix(i8* %t106, i8* %s107)
  %t109 = call double @parse_import_entry(i8* %s105, i8* %t108)
  store double %t109, double* %l14
  %t110 = load double, double* %l14
  br label %loop.latch2
merge9:
  %t111 = load i8*, i8** %l13
  %s112 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.112, i32 0, i32 0
  %t113 = call i1 @starts_with(i8* %t111, i8* %s112)
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t116 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t117 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t118 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t119 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t120 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t121 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t122 = load double, double* %l8
  %t123 = load double, double* %l9
  %t124 = load double, double* %l10
  %t125 = load double, double* %l11
  %t126 = load double, double* %l12
  %t127 = load i8*, i8** %l13
  br i1 %t113, label %then10, label %merge11
then10:
  %s128 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.128, i32 0, i32 0
  %t129 = load i8*, i8** %l13
  %s130 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.130, i32 0, i32 0
  %t131 = call i8* @strip_prefix(i8* %t129, i8* %s130)
  %t132 = call double @parse_import_entry(i8* %s128, i8* %t131)
  store double %t132, double* %l15
  %t133 = load double, double* %l15
  br label %loop.latch2
merge11:
  %t134 = load i8*, i8** %l13
  %s135 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.135, i32 0, i32 0
  %t136 = call i1 @starts_with(i8* %t134, i8* %s135)
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t140 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t141 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t142 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t143 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t144 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t145 = load double, double* %l8
  %t146 = load double, double* %l9
  %t147 = load double, double* %l10
  %t148 = load double, double* %l11
  %t149 = load double, double* %l12
  %t150 = load i8*, i8** %l13
  br i1 %t136, label %then12, label %merge13
then12:
  %t151 = load i8*, i8** %l13
  %s152 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.152, i32 0, i32 0
  %t153 = call i8* @strip_prefix(i8* %t151, i8* %s152)
  %t154 = call double @parse_source_span(i8* %t153)
  store double %t154, double* %l16
  %t155 = load double, double* %l16
  br label %loop.latch2
merge13:
  %t156 = load i8*, i8** %l13
  %t157 = load i8*, i8** %l13
  %s158 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.158, i32 0, i32 0
  %t159 = call i1 @starts_with(i8* %t157, i8* %s158)
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t163 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t164 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t165 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t166 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t167 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t168 = load double, double* %l8
  %t169 = load double, double* %l9
  %t170 = load double, double* %l10
  %t171 = load double, double* %l11
  %t172 = load double, double* %l12
  %t173 = load i8*, i8** %l13
  br i1 %t159, label %then14, label %merge15
then14:
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t175 = load double, double* %l11
  %t176 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t174, double %t175)
  store %StructParseResult %t176, %StructParseResult* %l17
  %t177 = load %StructParseResult, %StructParseResult* %l17
  %t178 = extractvalue %StructParseResult %t177, 2
  %t179 = call double @diagnosticsconcat({ i8**, i64 }* %t178)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t180 = load %StructParseResult, %StructParseResult* %l17
  %t181 = extractvalue %StructParseResult %t180, 0
  %t182 = load %StructParseResult, %StructParseResult* %l17
  %t183 = extractvalue %StructParseResult %t182, 1
  store double %t183, double* %l11
  br label %loop.latch2
merge15:
  %t184 = load i8*, i8** %l13
  %s185 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.185, i32 0, i32 0
  %t186 = call i1 @starts_with(i8* %t184, i8* %s185)
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t189 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t190 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t191 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t192 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t193 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t194 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t195 = load double, double* %l8
  %t196 = load double, double* %l9
  %t197 = load double, double* %l10
  %t198 = load double, double* %l11
  %t199 = load double, double* %l12
  %t200 = load i8*, i8** %l13
  br i1 %t186, label %then16, label %merge17
then16:
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load double, double* %l11
  %t203 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t201, double %t202)
  store %InterfaceParseResult %t203, %InterfaceParseResult* %l18
  %t204 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t205 = extractvalue %InterfaceParseResult %t204, 2
  %t206 = call double @diagnosticsconcat({ i8**, i64 }* %t205)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t207 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t208 = extractvalue %InterfaceParseResult %t207, 0
  %t209 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t210 = extractvalue %InterfaceParseResult %t209, 1
  store double %t210, double* %l11
  br label %loop.latch2
merge17:
  %t211 = load i8*, i8** %l13
  %s212 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.212, i32 0, i32 0
  %t213 = call i1 @starts_with(i8* %t211, i8* %s212)
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t216 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t217 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t218 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t219 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t220 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t221 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t222 = load double, double* %l8
  %t223 = load double, double* %l9
  %t224 = load double, double* %l10
  %t225 = load double, double* %l11
  %t226 = load double, double* %l12
  %t227 = load i8*, i8** %l13
  br i1 %t213, label %then18, label %merge19
then18:
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load double, double* %l11
  %t230 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t228, double %t229)
  store %EnumParseResult %t230, %EnumParseResult* %l19
  %t231 = load %EnumParseResult, %EnumParseResult* %l19
  %t232 = extractvalue %EnumParseResult %t231, 2
  %t233 = call double @diagnosticsconcat({ i8**, i64 }* %t232)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t234 = load %EnumParseResult, %EnumParseResult* %l19
  %t235 = extractvalue %EnumParseResult %t234, 0
  %t236 = load %EnumParseResult, %EnumParseResult* %l19
  %t237 = extractvalue %EnumParseResult %t236, 1
  store double %t237, double* %l11
  br label %loop.latch2
merge19:
  %t238 = load i8*, i8** %l13
  %s239 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.239, i32 0, i32 0
  %t240 = call i1 @starts_with(i8* %t238, i8* %s239)
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t244 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t245 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t246 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t247 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t248 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t249 = load double, double* %l8
  %t250 = load double, double* %l9
  %t251 = load double, double* %l10
  %t252 = load double, double* %l11
  %t253 = load double, double* %l12
  %t254 = load i8*, i8** %l13
  br i1 %t240, label %then20, label %merge21
then20:
  %t255 = load double, double* %l8
  br label %loop.latch2
merge21:
  %t256 = load i8*, i8** %l13
  %s257 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.257, i32 0, i32 0
  %t258 = call i1 @starts_with(i8* %t256, i8* %s257)
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t261 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t262 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t263 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t264 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t265 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t266 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t267 = load double, double* %l8
  %t268 = load double, double* %l9
  %t269 = load double, double* %l10
  %t270 = load double, double* %l11
  %t271 = load double, double* %l12
  %t272 = load i8*, i8** %l13
  br i1 %t258, label %then22, label %merge23
then22:
  %t273 = load double, double* %l8
  br label %loop.latch2
merge23:
  %t274 = load i8*, i8** %l13
  %s275 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.275, i32 0, i32 0
  %t276 = call i1 @starts_with(i8* %t274, i8* %s275)
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t279 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t280 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t281 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t282 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t283 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t284 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t285 = load double, double* %l8
  %t286 = load double, double* %l9
  %t287 = load double, double* %l10
  %t288 = load double, double* %l11
  %t289 = load double, double* %l12
  %t290 = load i8*, i8** %l13
  br i1 %t276, label %then24, label %merge25
then24:
  %t291 = load double, double* %l8
  br label %loop.latch2
merge25:
  %t292 = load i8*, i8** %l13
  %s293 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.293, i32 0, i32 0
  %t294 = call i1 @starts_with(i8* %t292, i8* %s293)
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t298 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t299 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t300 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t301 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t302 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t303 = load double, double* %l8
  %t304 = load double, double* %l9
  %t305 = load double, double* %l10
  %t306 = load double, double* %l11
  %t307 = load double, double* %l12
  %t308 = load i8*, i8** %l13
  br i1 %t294, label %then26, label %merge27
then26:
  %t309 = load double, double* %l8
  br label %loop.latch2
merge27:
  %t310 = load i8*, i8** %l13
  %t311 = load double, double* %l9
  %t312 = load double, double* %l10
  %t313 = call %InstructionParseResult @parse_instruction(i8* %t310, double %t311, double %t312)
  store %InstructionParseResult %t313, %InstructionParseResult* %l20
  %t314 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t315 = extractvalue %InstructionParseResult %t314, 0
  store { i8**, i64 }* %t315, { i8**, i64 }** %l21
  %t316 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t317 = extractvalue %InstructionParseResult %t316, 1
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t320 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t321 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t322 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t323 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t324 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t325 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t326 = load double, double* %l8
  %t327 = load double, double* %l9
  %t328 = load double, double* %l10
  %t329 = load double, double* %l11
  %t330 = load double, double* %l12
  %t331 = load i8*, i8** %l13
  %t332 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t333 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t317, label %then28, label %else29
then28:
  br label %merge30
else29:
  %t334 = load double, double* %l9
  br label %merge30
merge30:
  %t335 = phi double [ 0.0, %then28 ], [ %t327, %else29 ]
  store double %t335, double* %l9
  %t336 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t337 = extractvalue %InstructionParseResult %t336, 2
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t340 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t341 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t342 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t343 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t344 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t345 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t346 = load double, double* %l8
  %t347 = load double, double* %l9
  %t348 = load double, double* %l10
  %t349 = load double, double* %l11
  %t350 = load double, double* %l12
  %t351 = load i8*, i8** %l13
  %t352 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l21
  br i1 %t337, label %then31, label %else32
then31:
  br label %merge33
else32:
  %t354 = load double, double* %l10
  br label %merge33
merge33:
  %t355 = phi double [ 0.0, %then31 ], [ %t348, %else32 ]
  store double %t355, double* %l10
  %t356 = load double, double* %l8
  %t357 = sitofp i64 0 to double
  store double %t357, double* %l22
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t360 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t361 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t362 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t363 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t364 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t365 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t366 = load double, double* %l8
  %t367 = load double, double* %l9
  %t368 = load double, double* %l10
  %t369 = load double, double* %l11
  %t370 = load double, double* %l12
  %t371 = load i8*, i8** %l13
  %t372 = load %InstructionParseResult, %InstructionParseResult* %l20
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t374 = load double, double* %l22
  br label %loop.header34
loop.header34:
  %t379 = phi double [ %t366, %loop.body1 ], [ %t378, %loop.latch36 ]
  store double %t379, double* %l8
  br label %loop.body35
loop.body35:
  %t375 = load double, double* %l22
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l21
  %t377 = load double, double* %l8
  br label %loop.latch36
loop.latch36:
  %t378 = load double, double* %l8
  br label %loop.header34
afterloop37:
  br label %loop.latch2
loop.latch2:
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t381 = load double, double* %l11
  %t382 = load double, double* %l8
  %t383 = load double, double* %l9
  %t384 = load double, double* %l10
  br label %loop.header0
afterloop3:
  %t390 = load double, double* %l8
  %t391 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t392 = insertvalue %ParseNativeResult undef, { i8**, i64 }* null, 0
  %t393 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t394 = insertvalue %ParseNativeResult %t392, { i8**, i64 }* null, 1
  %t395 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t396 = insertvalue %ParseNativeResult %t394, { i8**, i64 }* null, 2
  %t397 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t398 = insertvalue %ParseNativeResult %t396, { i8**, i64 }* null, 3
  %t399 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t400 = insertvalue %ParseNativeResult %t398, { i8**, i64 }* null, 4
  %t401 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t402 = insertvalue %ParseNativeResult %t400, { i8**, i64 }* null, 5
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t404 = insertvalue %ParseNativeResult %t402, { i8**, i64 }* %t403, 6
  ret %ParseNativeResult %t404
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t3 = sitofp i64 -1 to double
  ret double %t3
}

define { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %variants, double %index, %NativeStructLayoutField %field) {
entry:
  %l0 = alloca { %NativeEnumVariantLayout*, i64 }*
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
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi { %NativeEnumVariantLayout*, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t19, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = fcmp oeq double %t9, %index
  %t11 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %else5
then4:
  store double 0.0, double* %l2
  store double 0.0, double* %l3
  %t13 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t14 = load double, double* %l3
  %t15 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t13, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t15, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge6
else5:
  %t16 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge6
merge6:
  %t17 = phi { %NativeEnumVariantLayout*, i64 }* [ %t15, %then4 ], [ null, %else5 ]
  store { %NativeEnumVariantLayout*, i64 }* %t17, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t20 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t20
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
  %l7 = alloca double
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
  store double 0.0, double* %l7
  %t123 = load double, double* %l7
  br label %merge13
merge13:
  %s124 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.124, i32 0, i32 0
  %t125 = call i1 @starts_with(i8* %line, i8* %s124)
  br i1 %t125, label %then14, label %merge15
then14:
  %s126 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %t127 = call i8* @strip_prefix(i8* %line, i8* %s126)
  %t128 = call i8* @trim_text(i8* %t127)
  store i8* %t128, i8** %l8
  store i1 0, i1* %l9
  %t129 = load i8*, i8** %l8
  %s130 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.130, i32 0, i32 0
  %t131 = call i1 @starts_with(i8* %t129, i8* %s130)
  %t132 = load i8*, i8** %l8
  %t133 = load i1, i1* %l9
  br i1 %t131, label %then16, label %merge17
then16:
  store i1 1, i1* %l9
  %t134 = load i8*, i8** %l8
  %s135 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.135, i32 0, i32 0
  %t136 = call i8* @strip_prefix(i8* %t134, i8* %s135)
  %t137 = call i8* @trim_text(i8* %t136)
  store i8* %t137, i8** %l8
  br label %merge17
merge17:
  %t138 = phi i1 [ 1, %then16 ], [ %t133, %then14 ]
  %t139 = phi i8* [ %t137, %then16 ], [ %t132, %then14 ]
  store i1 %t138, i1* %l9
  store i8* %t139, i8** %l8
  %t140 = load i8*, i8** %l8
  %t141 = call %BindingComponents @parse_binding_components(i8* %t140)
  store %BindingComponents %t141, %BindingComponents* %l10
  %t142 = alloca %NativeInstruction
  %t143 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 0
  store i32 2, i32* %t143
  %t144 = load %BindingComponents, %BindingComponents* %l10
  %t145 = extractvalue %BindingComponents %t144, 0
  %t146 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 1
  %t147 = bitcast [48 x i8]* %t146 to i8*
  %t148 = bitcast i8* %t147 to i8**
  store i8* %t145, i8** %t148
  %t149 = load i1, i1* %l9
  %t150 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 1
  %t151 = bitcast [48 x i8]* %t150 to i8*
  %t152 = getelementptr inbounds i8, i8* %t151, i64 8
  %t153 = bitcast i8* %t152 to i1*
  store i1 %t149, i1* %t153
  %t154 = load %BindingComponents, %BindingComponents* %l10
  %t155 = extractvalue %BindingComponents %t154, 1
  %t156 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 1
  %t157 = bitcast [48 x i8]* %t156 to i8*
  %t158 = getelementptr inbounds i8, i8* %t157, i64 16
  %t159 = bitcast i8* %t158 to i8**
  store i8* %t155, i8** %t159
  %t160 = load %BindingComponents, %BindingComponents* %l10
  %t161 = extractvalue %BindingComponents %t160, 2
  %t162 = call double @maybe_trim_trailing(double 0.0)
  %t163 = call noalias i8* @malloc(i64 8)
  %t164 = bitcast i8* %t163 to double*
  store double %t162, double* %t164
  %t165 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 1
  %t166 = bitcast [48 x i8]* %t165 to i8*
  %t167 = getelementptr inbounds i8, i8* %t166, i64 24
  %t168 = bitcast i8* %t167 to i8**
  store i8* %t163, i8** %t168
  %t169 = call noalias i8* @malloc(i64 8)
  %t170 = bitcast i8* %t169 to double*
  store double %span, double* %t170
  %t171 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 1
  %t172 = bitcast [48 x i8]* %t171 to i8*
  %t173 = getelementptr inbounds i8, i8* %t172, i64 32
  %t174 = bitcast i8* %t173 to i8**
  store i8* %t169, i8** %t174
  %t175 = call noalias i8* @malloc(i64 8)
  %t176 = bitcast i8* %t175 to double*
  store double %value_span, double* %t176
  %t177 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t142, i32 0, i32 1
  %t178 = bitcast [48 x i8]* %t177 to i8*
  %t179 = getelementptr inbounds i8, i8* %t178, i64 40
  %t180 = bitcast i8* %t179 to i8**
  store i8* %t175, i8** %t180
  %t181 = load %NativeInstruction, %NativeInstruction* %t142
  %t182 = alloca [1 x %NativeInstruction]
  %t183 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t182, i32 0, i32 0
  %t184 = getelementptr %NativeInstruction, %NativeInstruction* %t183, i64 0
  store %NativeInstruction %t181, %NativeInstruction* %t184
  %t185 = alloca { %NativeInstruction*, i64 }
  %t186 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t185, i32 0, i32 0
  store %NativeInstruction* %t183, %NativeInstruction** %t186
  %t187 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t185, i32 0, i32 1
  store i64 1, i64* %t187
  %t188 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t189 = insertvalue %InstructionParseResult %t188, i1 1, 1
  %t190 = insertvalue %InstructionParseResult %t189, i1 1, 2
  ret %InstructionParseResult %t190
merge15:
  %s191 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.191, i32 0, i32 0
  %t192 = call i1 @starts_with(i8* %line, i8* %s191)
  br i1 %t192, label %then18, label %merge19
then18:
  %t193 = alloca %NativeInstruction
  %t194 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t193, i32 0, i32 0
  store i32 1, i32* %t194
  %s195 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.195, i32 0, i32 0
  %t196 = call i8* @strip_prefix(i8* %line, i8* %s195)
  %t197 = call i8* @trim_text(i8* %t196)
  %t198 = call i8* @trim_trailing_delimiters(i8* %t197)
  %t199 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t193, i32 0, i32 1
  %t200 = bitcast [16 x i8]* %t199 to i8*
  %t201 = bitcast i8* %t200 to i8**
  store i8* %t198, i8** %t201
  %t202 = call noalias i8* @malloc(i64 8)
  %t203 = bitcast i8* %t202 to double*
  store double %span, double* %t203
  %t204 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t193, i32 0, i32 1
  %t205 = bitcast [16 x i8]* %t204 to i8*
  %t206 = getelementptr inbounds i8, i8* %t205, i64 8
  %t207 = bitcast i8* %t206 to i8**
  store i8* %t202, i8** %t207
  %t208 = load %NativeInstruction, %NativeInstruction* %t193
  %t209 = alloca [1 x %NativeInstruction]
  %t210 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t209, i32 0, i32 0
  %t211 = getelementptr %NativeInstruction, %NativeInstruction* %t210, i64 0
  store %NativeInstruction %t208, %NativeInstruction* %t211
  %t212 = alloca { %NativeInstruction*, i64 }
  %t213 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t212, i32 0, i32 0
  store %NativeInstruction* %t210, %NativeInstruction** %t213
  %t214 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t212, i32 0, i32 1
  store i64 1, i64* %t214
  %t215 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t216 = insertvalue %InstructionParseResult %t215, i1 1, 1
  %t217 = insertvalue %InstructionParseResult %t216, i1 0, 2
  ret %InstructionParseResult %t217
merge19:
  %t218 = alloca %NativeInstruction
  %t219 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 0
  store i32 16, i32* %t219
  %t220 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t221 = bitcast [8 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to i8**
  store i8* %line, i8** %t222
  %t223 = load %NativeInstruction, %NativeInstruction* %t218
  %t224 = alloca [1 x %NativeInstruction]
  %t225 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t224, i32 0, i32 0
  %t226 = getelementptr %NativeInstruction, %NativeInstruction* %t225, i64 0
  store %NativeInstruction %t223, %NativeInstruction* %t226
  %t227 = alloca { %NativeInstruction*, i64 }
  %t228 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t227, i32 0, i32 0
  store %NativeInstruction* %t225, %NativeInstruction** %t228
  %t229 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t227, i32 0, i32 1
  store i64 1, i64* %t229
  %t230 = insertvalue %InstructionParseResult undef, { i8**, i64 }* null, 0
  %t231 = insertvalue %InstructionParseResult %t230, i1 0, 1
  %t232 = insertvalue %InstructionParseResult %t231, i1 0, 2
  ret %InstructionParseResult %t232
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
  %l4 = alloca double
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
  store double 0.0, double* %l4
  %t16 = load double, double* %l4
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t17 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t17
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
  %l1 = alloca double
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
  %l17 = alloca double
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
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %s6 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* null, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l2
  %t9 = load i8*, i8** %l2
  %t10 = call %StructHeaderParse @parse_struct_header(i8* %t9)
  store %StructHeaderParse %t10, %StructHeaderParse* %l3
  %t11 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t12 = extractvalue %StructHeaderParse %t11, 2
  %t13 = call double @diagnosticsconcat({ i8**, i64 }* %t12)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t14 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t15 = extractvalue %StructHeaderParse %t14, 0
  store i8* %t15, i8** %l4
  %t16 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t17 = extractvalue %StructHeaderParse %t16, 1
  store { i8**, i64 }* %t17, { i8**, i64 }** %l5
  %t18 = load i8*, i8** %l4
  %t19 = alloca [0 x double]
  %t20 = getelementptr [0 x double], [0 x double]* %t19, i32 0, i32 0
  %t21 = alloca { double*, i64 }
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t21, i32 0, i32 0
  store double* %t20, double** %t22
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %NativeStructField*, i64 }* null, { %NativeStructField*, i64 }** %l6
  %t24 = alloca [0 x double]
  %t25 = getelementptr [0 x double], [0 x double]* %t24, i32 0, i32 0
  %t26 = alloca { double*, i64 }
  %t27 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 0
  store double* %t25, double** %t27
  %t28 = getelementptr { double*, i64 }, { double*, i64 }* %t26, i32 0, i32 1
  store i64 0, i64* %t28
  store { %NativeFunction*, i64 }* null, { %NativeFunction*, i64 }** %l7
  store double 0.0, double* %l8
  store double 0.0, double* %l9
  store double 0.0, double* %l10
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { %NativeStructLayoutField*, i64 }* null, { %NativeStructLayoutField*, i64 }** %l11
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l12
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %start_index, %t36
  store double %t37, double* %l16
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t42 = load i8*, i8** %l4
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t44 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t45 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t46 = load double, double* %l8
  %t47 = load double, double* %l9
  %t48 = load double, double* %l10
  %t49 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t50 = load double, double* %l12
  %t51 = load double, double* %l13
  %t52 = load i1, i1* %l14
  %t53 = load i1, i1* %l15
  %t54 = load double, double* %l16
  br label %loop.header0
loop.header0:
  %t298 = phi { i8**, i64 }* [ %t38, %entry ], [ %t290, %loop.latch2 ]
  %t299 = phi double [ %t50, %entry ], [ %t291, %loop.latch2 ]
  %t300 = phi double [ %t51, %entry ], [ %t292, %loop.latch2 ]
  %t301 = phi i1 [ %t52, %entry ], [ %t293, %loop.latch2 ]
  %t302 = phi { %NativeStructLayoutField*, i64 }* [ %t49, %entry ], [ %t294, %loop.latch2 ]
  %t303 = phi double [ %t46, %entry ], [ %t295, %loop.latch2 ]
  %t304 = phi double [ %t47, %entry ], [ %t296, %loop.latch2 ]
  %t305 = phi double [ %t48, %entry ], [ %t297, %loop.latch2 ]
  store { i8**, i64 }* %t298, { i8**, i64 }** %l0
  store double %t299, double* %l12
  store double %t300, double* %l13
  store i1 %t301, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t302, { %NativeStructLayoutField*, i64 }** %l11
  store double %t303, double* %l8
  store double %t304, double* %l9
  store double %t305, double* %l10
  br label %loop.body1
loop.body1:
  %t55 = load double, double* %l16
  store double 0.0, double* %l17
  %t56 = load double, double* %l17
  %t57 = load double, double* %l17
  %s58 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.58, i32 0, i32 0
  %t59 = load double, double* %l8
  %t60 = load double, double* %l17
  %s61 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* null, i8* %s61)
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load double, double* %l1
  %t65 = load i8*, i8** %l2
  %t66 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t67 = load i8*, i8** %l4
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t69 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t70 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t71 = load double, double* %l8
  %t72 = load double, double* %l9
  %t73 = load double, double* %l10
  %t74 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t75 = load double, double* %l12
  %t76 = load double, double* %l13
  %t77 = load i1, i1* %l14
  %t78 = load i1, i1* %l15
  %t79 = load double, double* %l16
  %t80 = load double, double* %l17
  br i1 %t62, label %then4, label %merge5
then4:
  %t81 = load double, double* %l17
  %s82 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.82, i32 0, i32 0
  %t83 = call i8* @strip_prefix(i8* null, i8* %s82)
  store i8* %t83, i8** %l18
  %t84 = load i8*, i8** %l18
  %s85 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.85, i32 0, i32 0
  %t86 = call i1 @starts_with(i8* %t84, i8* %s85)
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load double, double* %l1
  %t89 = load i8*, i8** %l2
  %t90 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t91 = load i8*, i8** %l4
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t93 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t94 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t95 = load double, double* %l8
  %t96 = load double, double* %l9
  %t97 = load double, double* %l10
  %t98 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t99 = load double, double* %l12
  %t100 = load double, double* %l13
  %t101 = load i1, i1* %l14
  %t102 = load i1, i1* %l15
  %t103 = load double, double* %l16
  %t104 = load double, double* %l17
  %t105 = load i8*, i8** %l18
  br i1 %t86, label %then6, label %merge7
then6:
  %t106 = load i8*, i8** %l18
  %s107 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.107, i32 0, i32 0
  %t108 = call i8* @strip_prefix(i8* %t106, i8* %s107)
  %t109 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t108)
  store %StructLayoutHeaderParse %t109, %StructLayoutHeaderParse* %l19
  %t110 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t111 = extractvalue %StructLayoutHeaderParse %t110, 4
  %t112 = call double @diagnosticsconcat({ i8**, i64 }* %t111)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t113 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t114 = extractvalue %StructLayoutHeaderParse %t113, 0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load double, double* %l1
  %t117 = load i8*, i8** %l2
  %t118 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t119 = load i8*, i8** %l4
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t121 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t122 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t123 = load double, double* %l8
  %t124 = load double, double* %l9
  %t125 = load double, double* %l10
  %t126 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t127 = load double, double* %l12
  %t128 = load double, double* %l13
  %t129 = load i1, i1* %l14
  %t130 = load i1, i1* %l15
  %t131 = load double, double* %l16
  %t132 = load double, double* %l17
  %t133 = load i8*, i8** %l18
  %t134 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  br i1 %t114, label %then8, label %merge9
then8:
  %t135 = load i1, i1* %l14
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t137 = load double, double* %l1
  %t138 = load i8*, i8** %l2
  %t139 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t140 = load i8*, i8** %l4
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t142 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t143 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t144 = load double, double* %l8
  %t145 = load double, double* %l9
  %t146 = load double, double* %l10
  %t147 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t148 = load double, double* %l12
  %t149 = load double, double* %l13
  %t150 = load i1, i1* %l14
  %t151 = load i1, i1* %l15
  %t152 = load double, double* %l16
  %t153 = load double, double* %l17
  %t154 = load i8*, i8** %l18
  %t155 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  br i1 %t135, label %then10, label %else11
then10:
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s157 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.157, i32 0, i32 0
  %t158 = load i8*, i8** %l4
  %t159 = add i8* %s157, %t158
  %t160 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t156, i8* %t159)
  store { i8**, i64 }* %t160, { i8**, i64 }** %l0
  br label %merge12
else11:
  %t161 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t162 = extractvalue %StructLayoutHeaderParse %t161, 2
  store double %t162, double* %l12
  %t163 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l19
  %t164 = extractvalue %StructLayoutHeaderParse %t163, 3
  store double %t164, double* %l13
  store i1 1, i1* %l14
  br label %merge12
merge12:
  %t165 = phi { i8**, i64 }* [ %t160, %then10 ], [ %t136, %else11 ]
  %t166 = phi double [ %t148, %then10 ], [ %t162, %else11 ]
  %t167 = phi double [ %t149, %then10 ], [ %t164, %else11 ]
  %t168 = phi i1 [ %t150, %then10 ], [ 1, %else11 ]
  store { i8**, i64 }* %t165, { i8**, i64 }** %l0
  store double %t166, double* %l12
  store double %t167, double* %l13
  store i1 %t168, i1* %l14
  br label %merge9
merge9:
  %t169 = phi { i8**, i64 }* [ %t160, %then8 ], [ %t115, %then6 ]
  %t170 = phi double [ %t162, %then8 ], [ %t127, %then6 ]
  %t171 = phi double [ %t164, %then8 ], [ %t128, %then6 ]
  %t172 = phi i1 [ 1, %then8 ], [ %t129, %then6 ]
  store { i8**, i64 }* %t169, { i8**, i64 }** %l0
  store double %t170, double* %l12
  store double %t171, double* %l13
  store i1 %t172, i1* %l14
  br label %loop.latch2
merge7:
  %t173 = load i8*, i8** %l18
  %s174 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.174, i32 0, i32 0
  %t175 = call i1 @starts_with(i8* %t173, i8* %s174)
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load double, double* %l1
  %t178 = load i8*, i8** %l2
  %t179 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t180 = load i8*, i8** %l4
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t182 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t183 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t184 = load double, double* %l8
  %t185 = load double, double* %l9
  %t186 = load double, double* %l10
  %t187 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t188 = load double, double* %l12
  %t189 = load double, double* %l13
  %t190 = load i1, i1* %l14
  %t191 = load i1, i1* %l15
  %t192 = load double, double* %l16
  %t193 = load double, double* %l17
  %t194 = load i8*, i8** %l18
  br i1 %t175, label %then13, label %merge14
then13:
  %t195 = load i8*, i8** %l18
  %s196 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.196, i32 0, i32 0
  %t197 = call i8* @strip_prefix(i8* %t195, i8* %s196)
  %t198 = load i8*, i8** %l4
  %t199 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t197, i8* %t198)
  store %StructLayoutFieldParse %t199, %StructLayoutFieldParse* %l20
  %t200 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t201 = extractvalue %StructLayoutFieldParse %t200, 2
  %t202 = call double @diagnosticsconcat({ i8**, i64 }* %t201)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t203 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t204 = extractvalue %StructLayoutFieldParse %t203, 0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load double, double* %l1
  %t207 = load i8*, i8** %l2
  %t208 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t209 = load i8*, i8** %l4
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t211 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t212 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t213 = load double, double* %l8
  %t214 = load double, double* %l9
  %t215 = load double, double* %l10
  %t216 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t217 = load double, double* %l12
  %t218 = load double, double* %l13
  %t219 = load i1, i1* %l14
  %t220 = load i1, i1* %l15
  %t221 = load double, double* %l16
  %t222 = load double, double* %l17
  %t223 = load i8*, i8** %l18
  %t224 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  br i1 %t204, label %then15, label %merge16
then15:
  %t225 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t226 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l20
  %t227 = extractvalue %StructLayoutFieldParse %t226, 1
  %t228 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t225, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t228, { %NativeStructLayoutField*, i64 }** %l11
  br label %merge16
merge16:
  %t229 = phi { %NativeStructLayoutField*, i64 }* [ %t228, %then15 ], [ %t216, %then13 ]
  store { %NativeStructLayoutField*, i64 }* %t229, { %NativeStructLayoutField*, i64 }** %l11
  br label %loop.latch2
merge14:
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s231 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.231, i32 0, i32 0
  %t232 = load double, double* %l17
  br label %loop.latch2
merge5:
  %t233 = load double, double* %l17
  %s234 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.234, i32 0, i32 0
  %t235 = load double, double* %l17
  %s236 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.236, i32 0, i32 0
  %t237 = call i1 @starts_with(i8* null, i8* %s236)
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load double, double* %l1
  %t240 = load i8*, i8** %l2
  %t241 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t242 = load i8*, i8** %l4
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t244 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t245 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t246 = load double, double* %l8
  %t247 = load double, double* %l9
  %t248 = load double, double* %l10
  %t249 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t250 = load double, double* %l12
  %t251 = load double, double* %l13
  %t252 = load i1, i1* %l14
  %t253 = load i1, i1* %l15
  %t254 = load double, double* %l16
  %t255 = load double, double* %l17
  br i1 %t237, label %then17, label %merge18
then17:
  %t256 = load double, double* %l17
  %s257 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.257, i32 0, i32 0
  %t258 = call i8* @strip_prefix(i8* null, i8* %s257)
  %t259 = call double @parse_struct_field_line(i8* %t258)
  store double %t259, double* %l21
  %t260 = load double, double* %l21
  br label %loop.latch2
merge18:
  %t261 = load double, double* %l17
  %s262 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.262, i32 0, i32 0
  %t263 = call i1 @starts_with(i8* null, i8* %s262)
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t265 = load double, double* %l1
  %t266 = load i8*, i8** %l2
  %t267 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t268 = load i8*, i8** %l4
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t270 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t271 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t272 = load double, double* %l8
  %t273 = load double, double* %l9
  %t274 = load double, double* %l10
  %t275 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t276 = load double, double* %l12
  %t277 = load double, double* %l13
  %t278 = load i1, i1* %l14
  %t279 = load i1, i1* %l15
  %t280 = load double, double* %l16
  %t281 = load double, double* %l17
  br i1 %t263, label %then19, label %merge20
then19:
  %t282 = load double, double* %l8
  %t283 = load double, double* %l17
  %s284 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.284, i32 0, i32 0
  %t285 = call i8* @strip_prefix(i8* null, i8* %s284)
  %t286 = call i8* @parse_function_name(i8* %t285)
  store i8* %t286, i8** %l22
  br label %loop.latch2
merge20:
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s288 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.288, i32 0, i32 0
  %t289 = load double, double* %l17
  br label %loop.latch2
loop.latch2:
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load double, double* %l12
  %t292 = load double, double* %l13
  %t293 = load i1, i1* %l14
  %t294 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t295 = load double, double* %l8
  %t296 = load double, double* %l9
  %t297 = load double, double* %l10
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l23
  %t306 = load i1, i1* %l14
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t308 = load double, double* %l1
  %t309 = load i8*, i8** %l2
  %t310 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t311 = load i8*, i8** %l4
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t313 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t314 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t315 = load double, double* %l8
  %t316 = load double, double* %l9
  %t317 = load double, double* %l10
  %t318 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t319 = load double, double* %l12
  %t320 = load double, double* %l13
  %t321 = load i1, i1* %l14
  %t322 = load i1, i1* %l15
  %t323 = load double, double* %l16
  %t324 = load double, double* %l23
  br i1 %t306, label %then21, label %merge22
then21:
  %t325 = load double, double* %l12
  %t326 = insertvalue %NativeStructLayout undef, double %t325, 0
  %t327 = load double, double* %l13
  %t328 = insertvalue %NativeStructLayout %t326, double %t327, 1
  %t329 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t330 = insertvalue %NativeStructLayout %t328, { i8**, i64 }* null, 2
  store double 0.0, double* %l23
  br label %merge22
merge22:
  %t331 = phi double [ 0.0, %then21 ], [ %t324, %entry ]
  store double %t331, double* %l23
  %t332 = load i8*, i8** %l4
  %t333 = insertvalue %NativeStruct undef, i8* %t332, 0
  %t334 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t335 = insertvalue %NativeStruct %t333, { i8**, i64 }* null, 1
  %t336 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t337 = insertvalue %NativeStruct %t335, { i8**, i64 }* null, 2
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t339 = insertvalue %NativeStruct %t337, { i8**, i64 }* %t338, 3
  %t340 = load double, double* %l23
  %t341 = insertvalue %NativeStruct %t339, i8* null, 4
  %t342 = insertvalue %StructParseResult undef, i8* null, 0
  %t343 = load double, double* %l16
  %t344 = insertvalue %StructParseResult %t342, double %t343, 1
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t346 = insertvalue %StructParseResult %t344, { i8**, i64 }* %t345, 2
  ret %StructParseResult %t346
}

define %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca %InterfaceHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { %NativeInterfaceSignature*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %InterfaceSignatureParse
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
  %s6 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* null, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l2
  %t9 = load i8*, i8** %l2
  %t10 = call %InterfaceHeaderParse @parse_interface_header(i8* %t9)
  store %InterfaceHeaderParse %t10, %InterfaceHeaderParse* %l3
  %t11 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t12 = extractvalue %InterfaceHeaderParse %t11, 2
  %t13 = call double @diagnosticsconcat({ i8**, i64 }* %t12)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t14 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t15 = extractvalue %InterfaceHeaderParse %t14, 0
  store i8* %t15, i8** %l4
  %t16 = load i8*, i8** %l4
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { %NativeInterfaceSignature*, i64 }* null, { %NativeInterfaceSignature*, i64 }** %l5
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %start_index, %t22
  store double %t23, double* %l6
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t28 = load i8*, i8** %l4
  %t29 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t30 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t82 = phi { i8**, i64 }* [ %t24, %entry ], [ %t80, %loop.latch2 ]
  %t83 = phi { %NativeInterfaceSignature*, i64 }* [ %t29, %entry ], [ %t81, %loop.latch2 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l0
  store { %NativeInterfaceSignature*, i64 }* %t83, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body1
loop.body1:
  %t31 = load double, double* %l6
  store double 0.0, double* %l7
  %t32 = load double, double* %l7
  %t33 = load double, double* %l7
  %s34 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.34, i32 0, i32 0
  %t35 = load double, double* %l7
  %s36 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.36, i32 0, i32 0
  %t37 = load double, double* %l7
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i1 @starts_with(i8* null, i8* %s38)
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  %t43 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t44 = load i8*, i8** %l4
  %t45 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t46 = load double, double* %l6
  %t47 = load double, double* %l7
  br i1 %t39, label %then4, label %merge5
then4:
  %t48 = load double, double* %l7
  %s49 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.49, i32 0, i32 0
  %t50 = call i8* @strip_prefix(i8* null, i8* %s49)
  %t51 = load i8*, i8** %l4
  %t52 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t50, i8* %t51)
  store %InterfaceSignatureParse %t52, %InterfaceSignatureParse* %l8
  %t53 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t54 = extractvalue %InterfaceSignatureParse %t53, 2
  %t55 = call double @diagnosticsconcat({ i8**, i64 }* %t54)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t56 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t57 = extractvalue %InterfaceSignatureParse %t56, 0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = load i8*, i8** %l2
  %t61 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t62 = load i8*, i8** %l4
  %t63 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t64 = load double, double* %l6
  %t65 = load double, double* %l7
  %t66 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t57, label %then6, label %merge7
then6:
  %t67 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t68 = extractvalue %InterfaceSignatureParse %t67, 1
  %t69 = alloca [1 x i8*]
  %t70 = getelementptr [1 x i8*], [1 x i8*]* %t69, i32 0, i32 0
  %t71 = getelementptr i8*, i8** %t70, i64 0
  store i8* %t68, i8** %t71
  %t72 = alloca { i8**, i64 }
  %t73 = getelementptr { i8**, i64 }, { i8**, i64 }* %t72, i32 0, i32 0
  store i8** %t70, i8*** %t73
  %t74 = getelementptr { i8**, i64 }, { i8**, i64 }* %t72, i32 0, i32 1
  store i64 1, i64* %t74
  %t75 = call double @signaturesconcat({ i8**, i64 }* %t72)
  store { %NativeInterfaceSignature*, i64 }* null, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge7
merge7:
  %t76 = phi { %NativeInterfaceSignature*, i64 }* [ null, %then6 ], [ %t63, %then4 ]
  store { %NativeInterfaceSignature*, i64 }* %t76, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.latch2
merge5:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s78 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.78, i32 0, i32 0
  %t79 = load double, double* %l7
  br label %loop.latch2
loop.latch2:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header0
afterloop3:
  %t84 = load i8*, i8** %l4
  %t85 = insertvalue %NativeInterface undef, i8* %t84, 0
  %t86 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t87 = extractvalue %InterfaceHeaderParse %t86, 1
  %t88 = insertvalue %NativeInterface %t85, { i8**, i64 }* %t87, 1
  %t89 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t90 = insertvalue %NativeInterface %t88, { i8**, i64 }* null, 2
  %t91 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t92 = load double, double* %l6
  %t93 = insertvalue %InterfaceParseResult %t91, double %t92, 1
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = insertvalue %InterfaceParseResult %t93, { i8**, i64 }* %t94, 2
  ret %InterfaceParseResult %t95
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
  %t42 = phi i8* [ %t13, %entry ], [ %t41, %loop.latch2 ]
  store i8* %t42, i8** %l1
  br label %loop.body1
loop.body1:
  %t20 = load double, double* %l2
  store double 0.0, double* %l8
  %t21 = load i8*, i8** %l3
  %t22 = load double, double* %l8
  %t23 = load double, double* %l8
  %t24 = load double, double* %l8
  %t25 = load double, double* %l8
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = load double, double* %l8
  %s28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.28, i32 0, i32 0
  %t29 = load double, double* %l8
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = load double, double* %l8
  %s32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.32, i32 0, i32 0
  %t33 = load double, double* %l8
  %s34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.34, i32 0, i32 0
  %t35 = load double, double* %l8
  %s36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.36, i32 0, i32 0
  %t37 = load double, double* %l8
  %s38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.38, i32 0, i32 0
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l8
  br label %loop.latch2
loop.latch2:
  %t41 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t43 = load i8*, i8** %l1
  %t44 = call i8* @trim_text(i8* %t43)
  store i8* %t44, i8** %l9
  %t45 = load i8*, i8** %l9
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t46
}

define double @find_matching_angle(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
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
  store double 0.0, double* %l2
  %t4 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t5 = sitofp i64 -1 to double
  ret double %t5
}

define double @find_matching_paren(i8* %text, double %start_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
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
  store double 0.0, double* %l2
  %t4 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t5 = sitofp i64 -1 to double
  ret double %t5
}

define %EnumParseResult @parse_enum_definition({ i8**, i64 }* %lines, double %start_index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %l15 = alloca double
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
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* null, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l2
  %t9 = load i8*, i8** %l2
  store i8* %t9, i8** %l3
  %t10 = load i8*, i8** %l3
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = call double @index_of(i8* %t10, i8* %s11)
  store double %t12, double* %l4
  %t13 = load double, double* %l4
  %t14 = sitofp i64 0 to double
  %t15 = fcmp oge double %t13, %t14
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load i8*, i8** %l2
  %t19 = load i8*, i8** %l3
  %t20 = load double, double* %l4
  br i1 %t15, label %then0, label %merge1
then0:
  %t21 = load i8*, i8** %l3
  %t22 = load double, double* %l4
  %t23 = call double @substring(i8* %t21, i64 0, double %t22)
  %t24 = call i8* @trim_text(i8* null)
  store i8* %t24, i8** %l3
  br label %merge1
merge1:
  %t25 = phi i8* [ %t24, %then0 ], [ %t19, %entry ]
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = call i8* @strip_generics(i8* %t26)
  store i8* %t27, i8** %l3
  %t28 = load i8*, i8** %l3
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { %NativeEnumVariant*, i64 }* null, { %NativeEnumVariant*, i64 }** %l5
  %t34 = alloca [0 x double]
  %t35 = getelementptr [0 x double], [0 x double]* %t34, i32 0, i32 0
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t35, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l6
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l7
  %t40 = sitofp i64 0 to double
  store double %t40, double* %l8
  %s41 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.41, i32 0, i32 0
  store i8* %s41, i8** %l9
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l10
  %t43 = sitofp i64 0 to double
  store double %t43, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %start_index, %t44
  store double %t45, double* %l14
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load i8*, i8** %l3
  %t50 = load double, double* %l4
  %t51 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t52 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t53 = load double, double* %l7
  %t54 = load double, double* %l8
  %t55 = load i8*, i8** %l9
  %t56 = load double, double* %l10
  %t57 = load double, double* %l11
  %t58 = load i1, i1* %l12
  %t59 = load i1, i1* %l13
  %t60 = load double, double* %l14
  br label %loop.header2
loop.header2:
  %t402 = phi { i8**, i64 }* [ %t46, %entry ], [ %t394, %loop.latch4 ]
  %t403 = phi double [ %t53, %entry ], [ %t395, %loop.latch4 ]
  %t404 = phi double [ %t54, %entry ], [ %t396, %loop.latch4 ]
  %t405 = phi i8* [ %t55, %entry ], [ %t397, %loop.latch4 ]
  %t406 = phi double [ %t56, %entry ], [ %t398, %loop.latch4 ]
  %t407 = phi double [ %t57, %entry ], [ %t399, %loop.latch4 ]
  %t408 = phi i1 [ %t58, %entry ], [ %t400, %loop.latch4 ]
  %t409 = phi { %NativeEnumVariantLayout*, i64 }* [ %t52, %entry ], [ %t401, %loop.latch4 ]
  store { i8**, i64 }* %t402, { i8**, i64 }** %l0
  store double %t403, double* %l7
  store double %t404, double* %l8
  store i8* %t405, i8** %l9
  store double %t406, double* %l10
  store double %t407, double* %l11
  store i1 %t408, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t409, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t61 = load double, double* %l14
  store double 0.0, double* %l15
  %t62 = load double, double* %l15
  %t63 = load double, double* %l15
  %s64 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.64, i32 0, i32 0
  %t65 = load double, double* %l15
  %s66 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.66, i32 0, i32 0
  %t67 = call i1 @starts_with(i8* null, i8* %s66)
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = load i8*, i8** %l2
  %t71 = load i8*, i8** %l3
  %t72 = load double, double* %l4
  %t73 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t74 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t75 = load double, double* %l7
  %t76 = load double, double* %l8
  %t77 = load i8*, i8** %l9
  %t78 = load double, double* %l10
  %t79 = load double, double* %l11
  %t80 = load i1, i1* %l12
  %t81 = load i1, i1* %l13
  %t82 = load double, double* %l14
  %t83 = load double, double* %l15
  br i1 %t67, label %then6, label %merge7
then6:
  %t84 = load double, double* %l15
  %s85 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.85, i32 0, i32 0
  %t86 = call i8* @strip_prefix(i8* null, i8* %s85)
  store i8* %t86, i8** %l16
  %t87 = load i8*, i8** %l16
  %s88 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.88, i32 0, i32 0
  %t89 = call i1 @starts_with(i8* %t87, i8* %s88)
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load double, double* %l1
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
  %t105 = load double, double* %l15
  %t106 = load i8*, i8** %l16
  br i1 %t89, label %then8, label %merge9
then8:
  %t107 = load i8*, i8** %l16
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.108, i32 0, i32 0
  %t109 = call i8* @strip_prefix(i8* %t107, i8* %s108)
  %t110 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t109)
  store %EnumLayoutHeaderParse %t110, %EnumLayoutHeaderParse* %l17
  %t111 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t112 = extractvalue %EnumLayoutHeaderParse %t111, 7
  %t113 = call double @diagnosticsconcat({ i8**, i64 }* %t112)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t114 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t115 = extractvalue %EnumLayoutHeaderParse %t114, 0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load double, double* %l1
  %t118 = load i8*, i8** %l2
  %t119 = load i8*, i8** %l3
  %t120 = load double, double* %l4
  %t121 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t122 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t123 = load double, double* %l7
  %t124 = load double, double* %l8
  %t125 = load i8*, i8** %l9
  %t126 = load double, double* %l10
  %t127 = load double, double* %l11
  %t128 = load i1, i1* %l12
  %t129 = load i1, i1* %l13
  %t130 = load double, double* %l14
  %t131 = load double, double* %l15
  %t132 = load i8*, i8** %l16
  %t133 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  br i1 %t115, label %then10, label %merge11
then10:
  %t134 = load i1, i1* %l12
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load double, double* %l1
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
  %t150 = load double, double* %l15
  %t151 = load i8*, i8** %l16
  %t152 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  br i1 %t134, label %then12, label %else13
then12:
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s154 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.154, i32 0, i32 0
  %t155 = load i8*, i8** %l3
  %t156 = add i8* %s154, %t155
  %t157 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t153, i8* %t156)
  store { i8**, i64 }* %t157, { i8**, i64 }** %l0
  br label %merge14
else13:
  %t158 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t159 = extractvalue %EnumLayoutHeaderParse %t158, 2
  store double %t159, double* %l7
  %t160 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t161 = extractvalue %EnumLayoutHeaderParse %t160, 3
  store double %t161, double* %l8
  %t162 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t163 = extractvalue %EnumLayoutHeaderParse %t162, 4
  store i8* %t163, i8** %l9
  %t164 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t165 = extractvalue %EnumLayoutHeaderParse %t164, 5
  store double %t165, double* %l10
  %t166 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l17
  %t167 = extractvalue %EnumLayoutHeaderParse %t166, 6
  store double %t167, double* %l11
  store i1 1, i1* %l12
  br label %merge14
merge14:
  %t168 = phi { i8**, i64 }* [ %t157, %then12 ], [ %t135, %else13 ]
  %t169 = phi double [ %t142, %then12 ], [ %t159, %else13 ]
  %t170 = phi double [ %t143, %then12 ], [ %t161, %else13 ]
  %t171 = phi i8* [ %t144, %then12 ], [ %t163, %else13 ]
  %t172 = phi double [ %t145, %then12 ], [ %t165, %else13 ]
  %t173 = phi double [ %t146, %then12 ], [ %t167, %else13 ]
  %t174 = phi i1 [ %t147, %then12 ], [ 1, %else13 ]
  store { i8**, i64 }* %t168, { i8**, i64 }** %l0
  store double %t169, double* %l7
  store double %t170, double* %l8
  store i8* %t171, i8** %l9
  store double %t172, double* %l10
  store double %t173, double* %l11
  store i1 %t174, i1* %l12
  br label %merge11
merge11:
  %t175 = phi { i8**, i64 }* [ %t157, %then10 ], [ %t116, %then8 ]
  %t176 = phi double [ %t159, %then10 ], [ %t123, %then8 ]
  %t177 = phi double [ %t161, %then10 ], [ %t124, %then8 ]
  %t178 = phi i8* [ %t163, %then10 ], [ %t125, %then8 ]
  %t179 = phi double [ %t165, %then10 ], [ %t126, %then8 ]
  %t180 = phi double [ %t167, %then10 ], [ %t127, %then8 ]
  %t181 = phi i1 [ 1, %then10 ], [ %t128, %then8 ]
  store { i8**, i64 }* %t175, { i8**, i64 }** %l0
  store double %t176, double* %l7
  store double %t177, double* %l8
  store i8* %t178, i8** %l9
  store double %t179, double* %l10
  store double %t180, double* %l11
  store i1 %t181, i1* %l12
  br label %loop.latch4
merge9:
  %t182 = load i8*, i8** %l16
  %s183 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.183, i32 0, i32 0
  %t184 = call i1 @starts_with(i8* %t182, i8* %s183)
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load double, double* %l1
  %t187 = load i8*, i8** %l2
  %t188 = load i8*, i8** %l3
  %t189 = load double, double* %l4
  %t190 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t191 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t192 = load double, double* %l7
  %t193 = load double, double* %l8
  %t194 = load i8*, i8** %l9
  %t195 = load double, double* %l10
  %t196 = load double, double* %l11
  %t197 = load i1, i1* %l12
  %t198 = load i1, i1* %l13
  %t199 = load double, double* %l14
  %t200 = load double, double* %l15
  %t201 = load i8*, i8** %l16
  br i1 %t184, label %then15, label %merge16
then15:
  %t202 = load i8*, i8** %l16
  %s203 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.203, i32 0, i32 0
  %t204 = call i8* @strip_prefix(i8* %t202, i8* %s203)
  %t205 = load i8*, i8** %l3
  %t206 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t204, i8* %t205)
  store %EnumLayoutVariantParse %t206, %EnumLayoutVariantParse* %l18
  %t207 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t208 = extractvalue %EnumLayoutVariantParse %t207, 2
  %t209 = call double @diagnosticsconcat({ i8**, i64 }* %t208)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t210 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t211 = extractvalue %EnumLayoutVariantParse %t210, 0
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load double, double* %l1
  %t214 = load i8*, i8** %l2
  %t215 = load i8*, i8** %l3
  %t216 = load double, double* %l4
  %t217 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t218 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t219 = load double, double* %l7
  %t220 = load double, double* %l8
  %t221 = load i8*, i8** %l9
  %t222 = load double, double* %l10
  %t223 = load double, double* %l11
  %t224 = load i1, i1* %l12
  %t225 = load i1, i1* %l13
  %t226 = load double, double* %l14
  %t227 = load double, double* %l15
  %t228 = load i8*, i8** %l16
  %t229 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  br i1 %t211, label %then17, label %merge18
then17:
  %t230 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t231 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t232 = extractvalue %EnumLayoutVariantParse %t231, 1
  store double 0.0, double* %l19
  %t233 = load double, double* %l19
  %t234 = sitofp i64 0 to double
  %t235 = fcmp oge double %t233, %t234
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load double, double* %l1
  %t238 = load i8*, i8** %l2
  %t239 = load i8*, i8** %l3
  %t240 = load double, double* %l4
  %t241 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t242 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t243 = load double, double* %l7
  %t244 = load double, double* %l8
  %t245 = load i8*, i8** %l9
  %t246 = load double, double* %l10
  %t247 = load double, double* %l11
  %t248 = load i1, i1* %l12
  %t249 = load i1, i1* %l13
  %t250 = load double, double* %l14
  %t251 = load double, double* %l15
  %t252 = load i8*, i8** %l16
  %t253 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t254 = load double, double* %l19
  br i1 %t235, label %then19, label %else20
then19:
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s256 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.256, i32 0, i32 0
  %t257 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t258 = extractvalue %EnumLayoutVariantParse %t257, 1
  br label %merge21
else20:
  %t259 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t260 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l18
  %t261 = extractvalue %EnumLayoutVariantParse %t260, 1
  %t262 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t259, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t262, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge21
merge21:
  %t263 = phi { i8**, i64 }* [ null, %then19 ], [ %t236, %else20 ]
  %t264 = phi { %NativeEnumVariantLayout*, i64 }* [ %t242, %then19 ], [ %t262, %else20 ]
  store { i8**, i64 }* %t263, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t264, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge18
merge18:
  %t265 = phi { i8**, i64 }* [ null, %then17 ], [ %t212, %then15 ]
  %t266 = phi { %NativeEnumVariantLayout*, i64 }* [ %t262, %then17 ], [ %t218, %then15 ]
  store { i8**, i64 }* %t265, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t266, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.latch4
merge16:
  %t267 = load i8*, i8** %l16
  %s268 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.268, i32 0, i32 0
  %t269 = call i1 @starts_with(i8* %t267, i8* %s268)
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load double, double* %l1
  %t272 = load i8*, i8** %l2
  %t273 = load i8*, i8** %l3
  %t274 = load double, double* %l4
  %t275 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t276 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t277 = load double, double* %l7
  %t278 = load double, double* %l8
  %t279 = load i8*, i8** %l9
  %t280 = load double, double* %l10
  %t281 = load double, double* %l11
  %t282 = load i1, i1* %l12
  %t283 = load i1, i1* %l13
  %t284 = load double, double* %l14
  %t285 = load double, double* %l15
  %t286 = load i8*, i8** %l16
  br i1 %t269, label %then22, label %merge23
then22:
  %t287 = load i8*, i8** %l16
  %s288 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.288, i32 0, i32 0
  %t289 = call i8* @strip_prefix(i8* %t287, i8* %s288)
  %t290 = load i8*, i8** %l3
  %t291 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t289, i8* %t290)
  store %EnumLayoutPayloadParse %t291, %EnumLayoutPayloadParse* %l20
  %t292 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t293 = extractvalue %EnumLayoutPayloadParse %t292, 3
  %t294 = call double @diagnosticsconcat({ i8**, i64 }* %t293)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t295 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t296 = extractvalue %EnumLayoutPayloadParse %t295, 0
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load double, double* %l1
  %t299 = load i8*, i8** %l2
  %t300 = load i8*, i8** %l3
  %t301 = load double, double* %l4
  %t302 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t303 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t304 = load double, double* %l7
  %t305 = load double, double* %l8
  %t306 = load i8*, i8** %l9
  %t307 = load double, double* %l10
  %t308 = load double, double* %l11
  %t309 = load i1, i1* %l12
  %t310 = load i1, i1* %l13
  %t311 = load double, double* %l14
  %t312 = load double, double* %l15
  %t313 = load i8*, i8** %l16
  %t314 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  br i1 %t296, label %then24, label %merge25
then24:
  %t315 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t316 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t317 = extractvalue %EnumLayoutPayloadParse %t316, 1
  %t318 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t315, i8* %t317)
  store double %t318, double* %l21
  %t319 = load double, double* %l21
  %t320 = sitofp i64 0 to double
  %t321 = fcmp olt double %t319, %t320
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t323 = load double, double* %l1
  %t324 = load i8*, i8** %l2
  %t325 = load i8*, i8** %l3
  %t326 = load double, double* %l4
  %t327 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t328 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t329 = load double, double* %l7
  %t330 = load double, double* %l8
  %t331 = load i8*, i8** %l9
  %t332 = load double, double* %l10
  %t333 = load double, double* %l11
  %t334 = load i1, i1* %l12
  %t335 = load i1, i1* %l13
  %t336 = load double, double* %l14
  %t337 = load double, double* %l15
  %t338 = load i8*, i8** %l16
  %t339 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t340 = load double, double* %l21
  br i1 %t321, label %then26, label %else27
then26:
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s342 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.342, i32 0, i32 0
  %t343 = load i8*, i8** %l3
  %t344 = add i8* %s342, %t343
  %s345 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.345, i32 0, i32 0
  %t346 = add i8* %t344, %s345
  %t347 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t348 = extractvalue %EnumLayoutPayloadParse %t347, 1
  %t349 = add i8* %t346, %t348
  %s350 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.350, i32 0, i32 0
  %t351 = add i8* %t349, %s350
  %t352 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t341, i8* %t351)
  store { i8**, i64 }* %t352, { i8**, i64 }** %l0
  br label %merge28
else27:
  %t353 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t354 = load double, double* %l21
  %t355 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l20
  %t356 = extractvalue %EnumLayoutPayloadParse %t355, 2
  %t357 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t353, double %t354, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t357, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge28
merge28:
  %t358 = phi { i8**, i64 }* [ %t352, %then26 ], [ %t322, %else27 ]
  %t359 = phi { %NativeEnumVariantLayout*, i64 }* [ %t328, %then26 ], [ %t357, %else27 ]
  store { i8**, i64 }* %t358, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t359, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge25
merge25:
  %t360 = phi { i8**, i64 }* [ %t352, %then24 ], [ %t297, %then22 ]
  %t361 = phi { %NativeEnumVariantLayout*, i64 }* [ %t357, %then24 ], [ %t303, %then22 ]
  store { i8**, i64 }* %t360, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t361, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.latch4
merge23:
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s363 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.363, i32 0, i32 0
  %t364 = load double, double* %l15
  br label %loop.latch4
merge7:
  %t365 = load double, double* %l15
  %s366 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.366, i32 0, i32 0
  %t367 = load double, double* %l15
  %s368 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.368, i32 0, i32 0
  %t369 = call i1 @starts_with(i8* null, i8* %s368)
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load double, double* %l1
  %t372 = load i8*, i8** %l2
  %t373 = load i8*, i8** %l3
  %t374 = load double, double* %l4
  %t375 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t376 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t377 = load double, double* %l7
  %t378 = load double, double* %l8
  %t379 = load i8*, i8** %l9
  %t380 = load double, double* %l10
  %t381 = load double, double* %l11
  %t382 = load i1, i1* %l12
  %t383 = load i1, i1* %l13
  %t384 = load double, double* %l14
  %t385 = load double, double* %l15
  br i1 %t369, label %then29, label %merge30
then29:
  %t386 = load double, double* %l15
  %s387 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.387, i32 0, i32 0
  %t388 = call i8* @strip_prefix(i8* null, i8* %s387)
  %t389 = call double @parse_enum_variant_line(i8* %t388)
  store double %t389, double* %l22
  %t390 = load double, double* %l22
  br label %loop.latch4
merge30:
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s392 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.392, i32 0, i32 0
  %t393 = load double, double* %l15
  br label %loop.latch4
loop.latch4:
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t395 = load double, double* %l7
  %t396 = load double, double* %l8
  %t397 = load i8*, i8** %l9
  %t398 = load double, double* %l10
  %t399 = load double, double* %l11
  %t400 = load i1, i1* %l12
  %t401 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %loop.header2
afterloop5:
  store double 0.0, double* %l23
  %t410 = load i1, i1* %l12
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t412 = load double, double* %l1
  %t413 = load i8*, i8** %l2
  %t414 = load i8*, i8** %l3
  %t415 = load double, double* %l4
  %t416 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t417 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t418 = load double, double* %l7
  %t419 = load double, double* %l8
  %t420 = load i8*, i8** %l9
  %t421 = load double, double* %l10
  %t422 = load double, double* %l11
  %t423 = load i1, i1* %l12
  %t424 = load i1, i1* %l13
  %t425 = load double, double* %l14
  %t426 = load double, double* %l23
  br i1 %t410, label %then31, label %merge32
then31:
  br label %merge32
merge32:
  %t427 = phi double [ 0.0, %then31 ], [ %t426, %entry ]
  store double %t427, double* %l23
  %t428 = load i8*, i8** %l3
  %t429 = insertvalue %NativeEnum undef, i8* %t428, 0
  %t430 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t431 = insertvalue %NativeEnum %t429, { i8**, i64 }* null, 1
  %t432 = load double, double* %l23
  %t433 = insertvalue %NativeEnum %t431, i8* null, 2
  %t434 = insertvalue %EnumParseResult undef, i8* null, 0
  %t435 = load double, double* %l14
  %t436 = insertvalue %EnumParseResult %t434, double %t435, 1
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t438 = insertvalue %EnumParseResult %t436, { i8**, i64 }* %t437, 2
  ret %EnumParseResult %t438
}

define { i8**, i64 }* @split_enum_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
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
  store double 0.0, double* %l4
  %t13 = load double, double* %l4
  %t14 = load double, double* %l4
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t15 = load i8*, i8** %l1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t16
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
  %l9 = alloca double
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
  %t141 = phi i8* [ %t17, %entry ], [ %t134, %loop.latch2 ]
  %t142 = phi i1 [ %t14, %entry ], [ %t135, %loop.latch2 ]
  %t143 = phi i1 [ %t15, %entry ], [ %t136, %loop.latch2 ]
  %t144 = phi double [ %t18, %entry ], [ %t137, %loop.latch2 ]
  %t145 = phi { i8**, i64 }* [ %t13, %entry ], [ %t138, %loop.latch2 ]
  %t146 = phi i1 [ %t16, %entry ], [ %t139, %loop.latch2 ]
  %t147 = phi double [ %t19, %entry ], [ %t140, %loop.latch2 ]
  store i8* %t141, i8** %l5
  store i1 %t142, i1* %l2
  store i1 %t143, i1* %l3
  store double %t144, double* %l6
  store { i8**, i64 }* %t145, { i8**, i64 }** %l1
  store i1 %t146, i1* %l4
  store double %t147, double* %l7
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l8
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l9
  %t23 = load double, double* %l9
  %s24 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.24, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* null, i8* %s24)
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load i1, i1* %l2
  %t29 = load i1, i1* %l3
  %t30 = load i1, i1* %l4
  %t31 = load i8*, i8** %l5
  %t32 = load double, double* %l6
  %t33 = load double, double* %l7
  %t34 = load double, double* %l8
  %t35 = load double, double* %l9
  br i1 %t25, label %then4, label %else5
then4:
  %t36 = load double, double* %l9
  %t37 = load double, double* %l9
  store i1 1, i1* %l2
  br label %merge6
else5:
  %t38 = load double, double* %l9
  %s39 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.39, i32 0, i32 0
  %t40 = call i1 @starts_with(i8* null, i8* %s39)
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load i1, i1* %l2
  %t44 = load i1, i1* %l3
  %t45 = load i1, i1* %l4
  %t46 = load i8*, i8** %l5
  %t47 = load double, double* %l6
  %t48 = load double, double* %l7
  %t49 = load double, double* %l8
  %t50 = load double, double* %l9
  br i1 %t40, label %then7, label %else8
then7:
  %t51 = load double, double* %l9
  %t52 = load double, double* %l9
  store double 0.0, double* %l10
  %t53 = load double, double* %l10
  %t54 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t54, %NumberParseResult* %l11
  %t55 = load %NumberParseResult, %NumberParseResult* %l11
  %t56 = extractvalue %NumberParseResult %t55, 0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load i1, i1* %l2
  %t60 = load i1, i1* %l3
  %t61 = load i1, i1* %l4
  %t62 = load i8*, i8** %l5
  %t63 = load double, double* %l6
  %t64 = load double, double* %l7
  %t65 = load double, double* %l8
  %t66 = load double, double* %l9
  %t67 = load double, double* %l10
  %t68 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t56, label %then10, label %else11
then10:
  store i1 1, i1* %l3
  %t69 = load %NumberParseResult, %NumberParseResult* %l11
  %t70 = extractvalue %NumberParseResult %t69, 1
  store double %t70, double* %l6
  br label %merge12
else11:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s72 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.72, i32 0, i32 0
  %t73 = load double, double* %l10
  br label %merge12
merge12:
  %t74 = phi i1 [ 1, %then10 ], [ %t60, %else11 ]
  %t75 = phi double [ %t70, %then10 ], [ %t63, %else11 ]
  %t76 = phi { i8**, i64 }* [ %t58, %then10 ], [ null, %else11 ]
  store i1 %t74, i1* %l3
  store double %t75, double* %l6
  store { i8**, i64 }* %t76, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t77 = load double, double* %l9
  %s78 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.78, i32 0, i32 0
  %t79 = call i1 @starts_with(i8* null, i8* %s78)
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load i1, i1* %l2
  %t83 = load i1, i1* %l3
  %t84 = load i1, i1* %l4
  %t85 = load i8*, i8** %l5
  %t86 = load double, double* %l6
  %t87 = load double, double* %l7
  %t88 = load double, double* %l8
  %t89 = load double, double* %l9
  br i1 %t79, label %then13, label %else14
then13:
  %t90 = load double, double* %l9
  %t91 = load double, double* %l9
  store double 0.0, double* %l12
  %t92 = load double, double* %l12
  %t93 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t93, %NumberParseResult* %l13
  %t94 = load %NumberParseResult, %NumberParseResult* %l13
  %t95 = extractvalue %NumberParseResult %t94, 0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t98 = load i1, i1* %l2
  %t99 = load i1, i1* %l3
  %t100 = load i1, i1* %l4
  %t101 = load i8*, i8** %l5
  %t102 = load double, double* %l6
  %t103 = load double, double* %l7
  %t104 = load double, double* %l8
  %t105 = load double, double* %l9
  %t106 = load double, double* %l12
  %t107 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t95, label %then16, label %else17
then16:
  store i1 1, i1* %l4
  %t108 = load %NumberParseResult, %NumberParseResult* %l13
  %t109 = extractvalue %NumberParseResult %t108, 1
  store double %t109, double* %l7
  br label %merge18
else17:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s111 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.111, i32 0, i32 0
  %t112 = load double, double* %l12
  br label %merge18
merge18:
  %t113 = phi i1 [ 1, %then16 ], [ %t100, %else17 ]
  %t114 = phi double [ %t109, %then16 ], [ %t103, %else17 ]
  %t115 = phi { i8**, i64 }* [ %t97, %then16 ], [ null, %else17 ]
  store i1 %t113, i1* %l4
  store double %t114, double* %l7
  store { i8**, i64 }* %t115, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s117 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.117, i32 0, i32 0
  %t118 = load double, double* %l9
  br label %merge15
merge15:
  %t119 = phi i1 [ 1, %then13 ], [ %t84, %else14 ]
  %t120 = phi double [ %t109, %then13 ], [ %t87, %else14 ]
  %t121 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  store i1 %t119, i1* %l4
  store double %t120, double* %l7
  store { i8**, i64 }* %t121, { i8**, i64 }** %l1
  br label %merge9
merge9:
  %t122 = phi i1 [ 1, %then7 ], [ %t44, %else8 ]
  %t123 = phi double [ %t70, %then7 ], [ %t47, %else8 ]
  %t124 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t125 = phi i1 [ %t45, %then7 ], [ 1, %else8 ]
  %t126 = phi double [ %t48, %then7 ], [ %t109, %else8 ]
  store i1 %t122, i1* %l3
  store double %t123, double* %l6
  store { i8**, i64 }* %t124, { i8**, i64 }** %l1
  store i1 %t125, i1* %l4
  store double %t126, double* %l7
  br label %merge6
merge6:
  %t127 = phi i8* [ null, %then4 ], [ %t31, %else5 ]
  %t128 = phi i1 [ 1, %then4 ], [ %t28, %else5 ]
  %t129 = phi i1 [ %t29, %then4 ], [ 1, %else5 ]
  %t130 = phi double [ %t32, %then4 ], [ %t70, %else5 ]
  %t131 = phi { i8**, i64 }* [ %t27, %then4 ], [ null, %else5 ]
  %t132 = phi i1 [ %t30, %then4 ], [ 1, %else5 ]
  %t133 = phi double [ %t33, %then4 ], [ %t109, %else5 ]
  store i8* %t127, i8** %l5
  store i1 %t128, i1* %l2
  store i1 %t129, i1* %l3
  store double %t130, double* %l6
  store { i8**, i64 }* %t131, { i8**, i64 }** %l1
  store i1 %t132, i1* %l4
  store double %t133, double* %l7
  br label %loop.latch2
loop.latch2:
  %t134 = load i8*, i8** %l5
  %t135 = load i1, i1* %l2
  %t136 = load i1, i1* %l3
  %t137 = load double, double* %l6
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load i1, i1* %l4
  %t140 = load double, double* %l7
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l14
  %t148 = load double, double* %l14
  %t149 = fcmp one double %t148, 0.0
  %t150 = insertvalue %StructLayoutHeaderParse undef, i1 %t149, 0
  %t151 = load i8*, i8** %l5
  %t152 = insertvalue %StructLayoutHeaderParse %t150, i8* %t151, 1
  %t153 = load double, double* %l6
  %t154 = insertvalue %StructLayoutHeaderParse %t152, double %t153, 2
  %t155 = load double, double* %l7
  %t156 = insertvalue %StructLayoutHeaderParse %t154, double %t155, 3
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = insertvalue %StructLayoutHeaderParse %t156, { i8**, i64 }* %t157, 4
  ret %StructLayoutHeaderParse %t158
}

define %StructLayoutFieldParse @parse_struct_layout_field(i8* %text, i8* %struct_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
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
  store double 0.0, double* %l4
  %t20 = load double, double* %l4
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l9
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l10
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l11
  %t25 = sitofp i64 1 to double
  store double %t25, double* %l12
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = load double, double* %l4
  %t31 = load i8*, i8** %l5
  %t32 = load i1, i1* %l6
  %t33 = load i1, i1* %l7
  %t34 = load i1, i1* %l8
  %t35 = load double, double* %l9
  %t36 = load double, double* %l10
  %t37 = load double, double* %l11
  %t38 = load double, double* %l12
  br label %loop.header0
loop.header0:
  %t247 = phi i8* [ %t31, %entry ], [ %t239, %loop.latch2 ]
  %t248 = phi i1 [ %t32, %entry ], [ %t240, %loop.latch2 ]
  %t249 = phi double [ %t35, %entry ], [ %t241, %loop.latch2 ]
  %t250 = phi { i8**, i64 }* [ %t27, %entry ], [ %t242, %loop.latch2 ]
  %t251 = phi i1 [ %t33, %entry ], [ %t243, %loop.latch2 ]
  %t252 = phi double [ %t36, %entry ], [ %t244, %loop.latch2 ]
  %t253 = phi i1 [ %t34, %entry ], [ %t245, %loop.latch2 ]
  %t254 = phi double [ %t37, %entry ], [ %t246, %loop.latch2 ]
  store i8* %t247, i8** %l5
  store i1 %t248, i1* %l6
  store double %t249, double* %l9
  store { i8**, i64 }* %t250, { i8**, i64 }** %l1
  store i1 %t251, i1* %l7
  store double %t252, double* %l10
  store i1 %t253, i1* %l8
  store double %t254, double* %l11
  br label %loop.body1
loop.body1:
  %t39 = load double, double* %l12
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  store double 0.0, double* %l13
  %t41 = load double, double* %l13
  %s42 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.42, i32 0, i32 0
  %t43 = call i1 @starts_with(i8* null, i8* %s42)
  %t44 = load i8*, i8** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t48 = load double, double* %l4
  %t49 = load i8*, i8** %l5
  %t50 = load i1, i1* %l6
  %t51 = load i1, i1* %l7
  %t52 = load i1, i1* %l8
  %t53 = load double, double* %l9
  %t54 = load double, double* %l10
  %t55 = load double, double* %l11
  %t56 = load double, double* %l12
  %t57 = load double, double* %l13
  br i1 %t43, label %then4, label %else5
then4:
  %t58 = load double, double* %l13
  %t59 = load double, double* %l13
  br label %merge6
else5:
  %t60 = load double, double* %l13
  %s61 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* null, i8* %s61)
  %t63 = load i8*, i8** %l0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t67 = load double, double* %l4
  %t68 = load i8*, i8** %l5
  %t69 = load i1, i1* %l6
  %t70 = load i1, i1* %l7
  %t71 = load i1, i1* %l8
  %t72 = load double, double* %l9
  %t73 = load double, double* %l10
  %t74 = load double, double* %l11
  %t75 = load double, double* %l12
  %t76 = load double, double* %l13
  br i1 %t62, label %then7, label %else8
then7:
  %t77 = load double, double* %l13
  %t78 = load double, double* %l13
  store double 0.0, double* %l14
  %t79 = load double, double* %l14
  %t80 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t80, %NumberParseResult* %l15
  %t81 = load %NumberParseResult, %NumberParseResult* %l15
  %t82 = extractvalue %NumberParseResult %t81, 0
  %t83 = load i8*, i8** %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t87 = load double, double* %l4
  %t88 = load i8*, i8** %l5
  %t89 = load i1, i1* %l6
  %t90 = load i1, i1* %l7
  %t91 = load i1, i1* %l8
  %t92 = load double, double* %l9
  %t93 = load double, double* %l10
  %t94 = load double, double* %l11
  %t95 = load double, double* %l12
  %t96 = load double, double* %l13
  %t97 = load double, double* %l14
  %t98 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t82, label %then10, label %else11
then10:
  store i1 1, i1* %l6
  %t99 = load %NumberParseResult, %NumberParseResult* %l15
  %t100 = extractvalue %NumberParseResult %t99, 1
  store double %t100, double* %l9
  br label %merge12
else11:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s102 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.102, i32 0, i32 0
  %t103 = add i8* %s102, %struct_name
  %s104 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.104, i32 0, i32 0
  %t105 = add i8* %t103, %s104
  %t106 = load double, double* %l4
  br label %merge12
merge12:
  %t107 = phi i1 [ 1, %then10 ], [ %t89, %else11 ]
  %t108 = phi double [ %t100, %then10 ], [ %t92, %else11 ]
  %t109 = phi { i8**, i64 }* [ %t84, %then10 ], [ null, %else11 ]
  store i1 %t107, i1* %l6
  store double %t108, double* %l9
  store { i8**, i64 }* %t109, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t110 = load double, double* %l13
  %s111 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.111, i32 0, i32 0
  %t112 = call i1 @starts_with(i8* null, i8* %s111)
  %t113 = load i8*, i8** %l0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t115 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t117 = load double, double* %l4
  %t118 = load i8*, i8** %l5
  %t119 = load i1, i1* %l6
  %t120 = load i1, i1* %l7
  %t121 = load i1, i1* %l8
  %t122 = load double, double* %l9
  %t123 = load double, double* %l10
  %t124 = load double, double* %l11
  %t125 = load double, double* %l12
  %t126 = load double, double* %l13
  br i1 %t112, label %then13, label %else14
then13:
  %t127 = load double, double* %l13
  %t128 = load double, double* %l13
  store double 0.0, double* %l16
  %t129 = load double, double* %l16
  %t130 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t130, %NumberParseResult* %l17
  %t131 = load %NumberParseResult, %NumberParseResult* %l17
  %t132 = extractvalue %NumberParseResult %t131, 0
  %t133 = load i8*, i8** %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t137 = load double, double* %l4
  %t138 = load i8*, i8** %l5
  %t139 = load i1, i1* %l6
  %t140 = load i1, i1* %l7
  %t141 = load i1, i1* %l8
  %t142 = load double, double* %l9
  %t143 = load double, double* %l10
  %t144 = load double, double* %l11
  %t145 = load double, double* %l12
  %t146 = load double, double* %l13
  %t147 = load double, double* %l16
  %t148 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t132, label %then16, label %else17
then16:
  store i1 1, i1* %l7
  %t149 = load %NumberParseResult, %NumberParseResult* %l17
  %t150 = extractvalue %NumberParseResult %t149, 1
  store double %t150, double* %l10
  br label %merge18
else17:
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s152 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.152, i32 0, i32 0
  %t153 = add i8* %s152, %struct_name
  %s154 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.154, i32 0, i32 0
  %t155 = add i8* %t153, %s154
  %t156 = load double, double* %l4
  br label %merge18
merge18:
  %t157 = phi i1 [ 1, %then16 ], [ %t140, %else17 ]
  %t158 = phi double [ %t150, %then16 ], [ %t143, %else17 ]
  %t159 = phi { i8**, i64 }* [ %t134, %then16 ], [ null, %else17 ]
  store i1 %t157, i1* %l7
  store double %t158, double* %l10
  store { i8**, i64 }* %t159, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t160 = load double, double* %l13
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.161, i32 0, i32 0
  %t162 = call i1 @starts_with(i8* null, i8* %s161)
  %t163 = load i8*, i8** %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t167 = load double, double* %l4
  %t168 = load i8*, i8** %l5
  %t169 = load i1, i1* %l6
  %t170 = load i1, i1* %l7
  %t171 = load i1, i1* %l8
  %t172 = load double, double* %l9
  %t173 = load double, double* %l10
  %t174 = load double, double* %l11
  %t175 = load double, double* %l12
  %t176 = load double, double* %l13
  br i1 %t162, label %then19, label %else20
then19:
  %t177 = load double, double* %l13
  %t178 = load double, double* %l13
  store double 0.0, double* %l18
  %t179 = load double, double* %l18
  %t180 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t180, %NumberParseResult* %l19
  %t181 = load %NumberParseResult, %NumberParseResult* %l19
  %t182 = extractvalue %NumberParseResult %t181, 0
  %t183 = load i8*, i8** %l0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t187 = load double, double* %l4
  %t188 = load i8*, i8** %l5
  %t189 = load i1, i1* %l6
  %t190 = load i1, i1* %l7
  %t191 = load i1, i1* %l8
  %t192 = load double, double* %l9
  %t193 = load double, double* %l10
  %t194 = load double, double* %l11
  %t195 = load double, double* %l12
  %t196 = load double, double* %l13
  %t197 = load double, double* %l18
  %t198 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t182, label %then22, label %else23
then22:
  store i1 1, i1* %l8
  %t199 = load %NumberParseResult, %NumberParseResult* %l19
  %t200 = extractvalue %NumberParseResult %t199, 1
  store double %t200, double* %l11
  br label %merge24
else23:
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s202 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.202, i32 0, i32 0
  %t203 = add i8* %s202, %struct_name
  %s204 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.204, i32 0, i32 0
  %t205 = add i8* %t203, %s204
  %t206 = load double, double* %l4
  br label %merge24
merge24:
  %t207 = phi i1 [ 1, %then22 ], [ %t191, %else23 ]
  %t208 = phi double [ %t200, %then22 ], [ %t194, %else23 ]
  %t209 = phi { i8**, i64 }* [ %t184, %then22 ], [ null, %else23 ]
  store i1 %t207, i1* %l8
  store double %t208, double* %l11
  store { i8**, i64 }* %t209, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s211 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.211, i32 0, i32 0
  %t212 = add i8* %s211, %struct_name
  %s213 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.213, i32 0, i32 0
  %t214 = add i8* %t212, %s213
  %t215 = load double, double* %l4
  br label %merge21
merge21:
  %t216 = phi i1 [ 1, %then19 ], [ %t171, %else20 ]
  %t217 = phi double [ %t200, %then19 ], [ %t174, %else20 ]
  %t218 = phi { i8**, i64 }* [ null, %then19 ], [ null, %else20 ]
  store i1 %t216, i1* %l8
  store double %t217, double* %l11
  store { i8**, i64 }* %t218, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t219 = phi i1 [ 1, %then13 ], [ %t120, %else14 ]
  %t220 = phi double [ %t150, %then13 ], [ %t123, %else14 ]
  %t221 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t222 = phi i1 [ %t121, %then13 ], [ 1, %else14 ]
  %t223 = phi double [ %t124, %then13 ], [ %t200, %else14 ]
  store i1 %t219, i1* %l7
  store double %t220, double* %l10
  store { i8**, i64 }* %t221, { i8**, i64 }** %l1
  store i1 %t222, i1* %l8
  store double %t223, double* %l11
  br label %merge9
merge9:
  %t224 = phi i1 [ 1, %then7 ], [ %t69, %else8 ]
  %t225 = phi double [ %t100, %then7 ], [ %t72, %else8 ]
  %t226 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t227 = phi i1 [ %t70, %then7 ], [ 1, %else8 ]
  %t228 = phi double [ %t73, %then7 ], [ %t150, %else8 ]
  %t229 = phi i1 [ %t71, %then7 ], [ 1, %else8 ]
  %t230 = phi double [ %t74, %then7 ], [ %t200, %else8 ]
  store i1 %t224, i1* %l6
  store double %t225, double* %l9
  store { i8**, i64 }* %t226, { i8**, i64 }** %l1
  store i1 %t227, i1* %l7
  store double %t228, double* %l10
  store i1 %t229, i1* %l8
  store double %t230, double* %l11
  br label %merge6
merge6:
  %t231 = phi i8* [ null, %then4 ], [ %t49, %else5 ]
  %t232 = phi i1 [ %t50, %then4 ], [ 1, %else5 ]
  %t233 = phi double [ %t53, %then4 ], [ %t100, %else5 ]
  %t234 = phi { i8**, i64 }* [ %t45, %then4 ], [ null, %else5 ]
  %t235 = phi i1 [ %t51, %then4 ], [ 1, %else5 ]
  %t236 = phi double [ %t54, %then4 ], [ %t150, %else5 ]
  %t237 = phi i1 [ %t52, %then4 ], [ 1, %else5 ]
  %t238 = phi double [ %t55, %then4 ], [ %t200, %else5 ]
  store i8* %t231, i8** %l5
  store i1 %t232, i1* %l6
  store double %t233, double* %l9
  store { i8**, i64 }* %t234, { i8**, i64 }** %l1
  store i1 %t235, i1* %l7
  store double %t236, double* %l10
  store i1 %t237, i1* %l8
  store double %t238, double* %l11
  br label %loop.latch2
loop.latch2:
  %t239 = load i8*, i8** %l5
  %t240 = load i1, i1* %l6
  %t241 = load double, double* %l9
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = load i1, i1* %l7
  %t244 = load double, double* %l10
  %t245 = load i1, i1* %l8
  %t246 = load double, double* %l11
  br label %loop.header0
afterloop3:
  %t255 = load i8*, i8** %l5
  %t256 = load i8*, i8** %l5
  store double 0.0, double* %l20
  %t257 = load double, double* %l4
  %t258 = insertvalue %NativeStructLayoutField undef, i8* null, 0
  %t259 = load i8*, i8** %l5
  %t260 = insertvalue %NativeStructLayoutField %t258, i8* %t259, 1
  %t261 = load double, double* %l9
  %t262 = insertvalue %NativeStructLayoutField %t260, double %t261, 2
  %t263 = load double, double* %l10
  %t264 = insertvalue %NativeStructLayoutField %t262, double %t263, 3
  %t265 = load double, double* %l11
  %t266 = insertvalue %NativeStructLayoutField %t264, double %t265, 4
  store %NativeStructLayoutField %t266, %NativeStructLayoutField* %l21
  %t267 = load double, double* %l20
  %t268 = fcmp one double %t267, 0.0
  %t269 = insertvalue %StructLayoutFieldParse undef, i1 %t268, 0
  %t270 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t271 = insertvalue %StructLayoutFieldParse %t269, i8* null, 1
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = insertvalue %StructLayoutFieldParse %t271, { i8**, i64 }* %t272, 2
  ret %StructLayoutFieldParse %t273
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
  %l14 = alloca double
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
  %t326 = phi i8* [ %t20, %entry ], [ %t314, %loop.latch2 ]
  %t327 = phi i1 [ %t17, %entry ], [ %t315, %loop.latch2 ]
  %t328 = phi i1 [ %t18, %entry ], [ %t316, %loop.latch2 ]
  %t329 = phi double [ %t24, %entry ], [ %t317, %loop.latch2 ]
  %t330 = phi { i8**, i64 }* [ %t16, %entry ], [ %t318, %loop.latch2 ]
  %t331 = phi i1 [ %t19, %entry ], [ %t319, %loop.latch2 ]
  %t332 = phi double [ %t25, %entry ], [ %t320, %loop.latch2 ]
  %t333 = phi i8* [ %t21, %entry ], [ %t321, %loop.latch2 ]
  %t334 = phi i1 [ %t22, %entry ], [ %t322, %loop.latch2 ]
  %t335 = phi double [ %t26, %entry ], [ %t323, %loop.latch2 ]
  %t336 = phi i1 [ %t23, %entry ], [ %t324, %loop.latch2 ]
  %t337 = phi double [ %t27, %entry ], [ %t325, %loop.latch2 ]
  store i8* %t326, i8** %l5
  store i1 %t327, i1* %l2
  store i1 %t328, i1* %l3
  store double %t329, double* %l9
  store { i8**, i64 }* %t330, { i8**, i64 }** %l1
  store i1 %t331, i1* %l4
  store double %t332, double* %l10
  store i8* %t333, i8** %l6
  store i1 %t334, i1* %l7
  store double %t335, double* %l11
  store i1 %t336, i1* %l8
  store double %t337, double* %l12
  br label %loop.body1
loop.body1:
  %t29 = load double, double* %l13
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l14
  %t31 = load double, double* %l14
  %s32 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.32, i32 0, i32 0
  %t33 = call i1 @starts_with(i8* null, i8* %s32)
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load i1, i1* %l2
  %t37 = load i1, i1* %l3
  %t38 = load i1, i1* %l4
  %t39 = load i8*, i8** %l5
  %t40 = load i8*, i8** %l6
  %t41 = load i1, i1* %l7
  %t42 = load i1, i1* %l8
  %t43 = load double, double* %l9
  %t44 = load double, double* %l10
  %t45 = load double, double* %l11
  %t46 = load double, double* %l12
  %t47 = load double, double* %l13
  %t48 = load double, double* %l14
  br i1 %t33, label %then4, label %else5
then4:
  %t49 = load double, double* %l14
  %t50 = load double, double* %l14
  store i1 1, i1* %l2
  br label %merge6
else5:
  %t51 = load double, double* %l14
  %s52 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.52, i32 0, i32 0
  %t53 = call i1 @starts_with(i8* null, i8* %s52)
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load i1, i1* %l2
  %t57 = load i1, i1* %l3
  %t58 = load i1, i1* %l4
  %t59 = load i8*, i8** %l5
  %t60 = load i8*, i8** %l6
  %t61 = load i1, i1* %l7
  %t62 = load i1, i1* %l8
  %t63 = load double, double* %l9
  %t64 = load double, double* %l10
  %t65 = load double, double* %l11
  %t66 = load double, double* %l12
  %t67 = load double, double* %l13
  %t68 = load double, double* %l14
  br i1 %t53, label %then7, label %else8
then7:
  %t69 = load double, double* %l14
  %t70 = load double, double* %l14
  store double 0.0, double* %l15
  %t71 = load double, double* %l15
  %t72 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t72, %NumberParseResult* %l16
  %t73 = load %NumberParseResult, %NumberParseResult* %l16
  %t74 = extractvalue %NumberParseResult %t73, 0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load i1, i1* %l2
  %t78 = load i1, i1* %l3
  %t79 = load i1, i1* %l4
  %t80 = load i8*, i8** %l5
  %t81 = load i8*, i8** %l6
  %t82 = load i1, i1* %l7
  %t83 = load i1, i1* %l8
  %t84 = load double, double* %l9
  %t85 = load double, double* %l10
  %t86 = load double, double* %l11
  %t87 = load double, double* %l12
  %t88 = load double, double* %l13
  %t89 = load double, double* %l14
  %t90 = load double, double* %l15
  %t91 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t74, label %then10, label %else11
then10:
  store i1 1, i1* %l3
  %t92 = load %NumberParseResult, %NumberParseResult* %l16
  %t93 = extractvalue %NumberParseResult %t92, 1
  store double %t93, double* %l9
  br label %merge12
else11:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s95 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.95, i32 0, i32 0
  %t96 = load double, double* %l15
  br label %merge12
merge12:
  %t97 = phi i1 [ 1, %then10 ], [ %t78, %else11 ]
  %t98 = phi double [ %t93, %then10 ], [ %t84, %else11 ]
  %t99 = phi { i8**, i64 }* [ %t76, %then10 ], [ null, %else11 ]
  store i1 %t97, i1* %l3
  store double %t98, double* %l9
  store { i8**, i64 }* %t99, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t100 = load double, double* %l14
  %s101 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.101, i32 0, i32 0
  %t102 = call i1 @starts_with(i8* null, i8* %s101)
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
  %t117 = load double, double* %l14
  br i1 %t102, label %then13, label %else14
then13:
  %t118 = load double, double* %l14
  %t119 = load double, double* %l14
  store double 0.0, double* %l17
  %t120 = load double, double* %l17
  %t121 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t121, %NumberParseResult* %l18
  %t122 = load %NumberParseResult, %NumberParseResult* %l18
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
  %t138 = load double, double* %l14
  %t139 = load double, double* %l17
  %t140 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t123, label %then16, label %else17
then16:
  store i1 1, i1* %l4
  %t141 = load %NumberParseResult, %NumberParseResult* %l18
  %t142 = extractvalue %NumberParseResult %t141, 1
  store double %t142, double* %l10
  br label %merge18
else17:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s144 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.144, i32 0, i32 0
  %t145 = load double, double* %l17
  br label %merge18
merge18:
  %t146 = phi i1 [ 1, %then16 ], [ %t128, %else17 ]
  %t147 = phi double [ %t142, %then16 ], [ %t134, %else17 ]
  %t148 = phi { i8**, i64 }* [ %t125, %then16 ], [ null, %else17 ]
  store i1 %t146, i1* %l4
  store double %t147, double* %l10
  store { i8**, i64 }* %t148, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t149 = load double, double* %l14
  %s150 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.150, i32 0, i32 0
  %t151 = call i1 @starts_with(i8* null, i8* %s150)
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
  %t166 = load double, double* %l14
  br i1 %t151, label %then19, label %else20
then19:
  %t167 = load double, double* %l14
  %t168 = load double, double* %l14
  br label %merge21
else20:
  %t169 = load double, double* %l14
  %s170 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.170, i32 0, i32 0
  %t171 = call i1 @starts_with(i8* null, i8* %s170)
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load i1, i1* %l2
  %t175 = load i1, i1* %l3
  %t176 = load i1, i1* %l4
  %t177 = load i8*, i8** %l5
  %t178 = load i8*, i8** %l6
  %t179 = load i1, i1* %l7
  %t180 = load i1, i1* %l8
  %t181 = load double, double* %l9
  %t182 = load double, double* %l10
  %t183 = load double, double* %l11
  %t184 = load double, double* %l12
  %t185 = load double, double* %l13
  %t186 = load double, double* %l14
  br i1 %t171, label %then22, label %else23
then22:
  %t187 = load double, double* %l14
  %t188 = load double, double* %l14
  store double 0.0, double* %l19
  %t189 = load double, double* %l19
  %t190 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t190, %NumberParseResult* %l20
  %t191 = load %NumberParseResult, %NumberParseResult* %l20
  %t192 = extractvalue %NumberParseResult %t191, 0
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t195 = load i1, i1* %l2
  %t196 = load i1, i1* %l3
  %t197 = load i1, i1* %l4
  %t198 = load i8*, i8** %l5
  %t199 = load i8*, i8** %l6
  %t200 = load i1, i1* %l7
  %t201 = load i1, i1* %l8
  %t202 = load double, double* %l9
  %t203 = load double, double* %l10
  %t204 = load double, double* %l11
  %t205 = load double, double* %l12
  %t206 = load double, double* %l13
  %t207 = load double, double* %l14
  %t208 = load double, double* %l19
  %t209 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t192, label %then25, label %else26
then25:
  store i1 1, i1* %l7
  %t210 = load %NumberParseResult, %NumberParseResult* %l20
  %t211 = extractvalue %NumberParseResult %t210, 1
  store double %t211, double* %l11
  br label %merge27
else26:
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s213 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.213, i32 0, i32 0
  %t214 = load double, double* %l19
  br label %merge27
merge27:
  %t215 = phi i1 [ 1, %then25 ], [ %t200, %else26 ]
  %t216 = phi double [ %t211, %then25 ], [ %t204, %else26 ]
  %t217 = phi { i8**, i64 }* [ %t194, %then25 ], [ null, %else26 ]
  store i1 %t215, i1* %l7
  store double %t216, double* %l11
  store { i8**, i64 }* %t217, { i8**, i64 }** %l1
  br label %merge24
else23:
  %t218 = load double, double* %l14
  %s219 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.219, i32 0, i32 0
  %t220 = call i1 @starts_with(i8* null, i8* %s219)
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
  %t235 = load double, double* %l14
  br i1 %t220, label %then28, label %else29
then28:
  %t236 = load double, double* %l14
  %t237 = load double, double* %l14
  store double 0.0, double* %l21
  %t238 = load double, double* %l21
  %t239 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t239, %NumberParseResult* %l22
  %t240 = load %NumberParseResult, %NumberParseResult* %l22
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
  %t256 = load double, double* %l14
  %t257 = load double, double* %l21
  %t258 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t241, label %then31, label %else32
then31:
  store i1 1, i1* %l8
  %t259 = load %NumberParseResult, %NumberParseResult* %l22
  %t260 = extractvalue %NumberParseResult %t259, 1
  store double %t260, double* %l12
  br label %merge33
else32:
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s262 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.262, i32 0, i32 0
  %t263 = load double, double* %l21
  br label %merge33
merge33:
  %t264 = phi i1 [ 1, %then31 ], [ %t250, %else32 ]
  %t265 = phi double [ %t260, %then31 ], [ %t254, %else32 ]
  %t266 = phi { i8**, i64 }* [ %t243, %then31 ], [ null, %else32 ]
  store i1 %t264, i1* %l8
  store double %t265, double* %l12
  store { i8**, i64 }* %t266, { i8**, i64 }** %l1
  br label %merge30
else29:
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s268 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.268, i32 0, i32 0
  %t269 = load double, double* %l14
  br label %merge30
merge30:
  %t270 = phi i1 [ 1, %then28 ], [ %t229, %else29 ]
  %t271 = phi double [ %t260, %then28 ], [ %t233, %else29 ]
  %t272 = phi { i8**, i64 }* [ null, %then28 ], [ null, %else29 ]
  store i1 %t270, i1* %l8
  store double %t271, double* %l12
  store { i8**, i64 }* %t272, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t273 = phi i1 [ 1, %then22 ], [ %t179, %else23 ]
  %t274 = phi double [ %t211, %then22 ], [ %t183, %else23 ]
  %t275 = phi { i8**, i64 }* [ null, %then22 ], [ null, %else23 ]
  %t276 = phi i1 [ %t180, %then22 ], [ 1, %else23 ]
  %t277 = phi double [ %t184, %then22 ], [ %t260, %else23 ]
  store i1 %t273, i1* %l7
  store double %t274, double* %l11
  store { i8**, i64 }* %t275, { i8**, i64 }** %l1
  store i1 %t276, i1* %l8
  store double %t277, double* %l12
  br label %merge21
merge21:
  %t278 = phi i8* [ null, %then19 ], [ %t158, %else20 ]
  %t279 = phi i1 [ %t159, %then19 ], [ 1, %else20 ]
  %t280 = phi double [ %t163, %then19 ], [ %t211, %else20 ]
  %t281 = phi { i8**, i64 }* [ %t153, %then19 ], [ null, %else20 ]
  %t282 = phi i1 [ %t160, %then19 ], [ 1, %else20 ]
  %t283 = phi double [ %t164, %then19 ], [ %t260, %else20 ]
  store i8* %t278, i8** %l6
  store i1 %t279, i1* %l7
  store double %t280, double* %l11
  store { i8**, i64 }* %t281, { i8**, i64 }** %l1
  store i1 %t282, i1* %l8
  store double %t283, double* %l12
  br label %merge15
merge15:
  %t284 = phi i1 [ 1, %then13 ], [ %t107, %else14 ]
  %t285 = phi double [ %t142, %then13 ], [ %t113, %else14 ]
  %t286 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t287 = phi i8* [ %t109, %then13 ], [ null, %else14 ]
  %t288 = phi i1 [ %t110, %then13 ], [ 1, %else14 ]
  %t289 = phi double [ %t114, %then13 ], [ %t211, %else14 ]
  %t290 = phi i1 [ %t111, %then13 ], [ 1, %else14 ]
  %t291 = phi double [ %t115, %then13 ], [ %t260, %else14 ]
  store i1 %t284, i1* %l4
  store double %t285, double* %l10
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  store i8* %t287, i8** %l6
  store i1 %t288, i1* %l7
  store double %t289, double* %l11
  store i1 %t290, i1* %l8
  store double %t291, double* %l12
  br label %merge9
merge9:
  %t292 = phi i1 [ 1, %then7 ], [ %t57, %else8 ]
  %t293 = phi double [ %t93, %then7 ], [ %t63, %else8 ]
  %t294 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t295 = phi i1 [ %t58, %then7 ], [ 1, %else8 ]
  %t296 = phi double [ %t64, %then7 ], [ %t142, %else8 ]
  %t297 = phi i8* [ %t60, %then7 ], [ null, %else8 ]
  %t298 = phi i1 [ %t61, %then7 ], [ 1, %else8 ]
  %t299 = phi double [ %t65, %then7 ], [ %t211, %else8 ]
  %t300 = phi i1 [ %t62, %then7 ], [ 1, %else8 ]
  %t301 = phi double [ %t66, %then7 ], [ %t260, %else8 ]
  store i1 %t292, i1* %l3
  store double %t293, double* %l9
  store { i8**, i64 }* %t294, { i8**, i64 }** %l1
  store i1 %t295, i1* %l4
  store double %t296, double* %l10
  store i8* %t297, i8** %l6
  store i1 %t298, i1* %l7
  store double %t299, double* %l11
  store i1 %t300, i1* %l8
  store double %t301, double* %l12
  br label %merge6
merge6:
  %t302 = phi i8* [ null, %then4 ], [ %t39, %else5 ]
  %t303 = phi i1 [ 1, %then4 ], [ %t36, %else5 ]
  %t304 = phi i1 [ %t37, %then4 ], [ 1, %else5 ]
  %t305 = phi double [ %t43, %then4 ], [ %t93, %else5 ]
  %t306 = phi { i8**, i64 }* [ %t35, %then4 ], [ null, %else5 ]
  %t307 = phi i1 [ %t38, %then4 ], [ 1, %else5 ]
  %t308 = phi double [ %t44, %then4 ], [ %t142, %else5 ]
  %t309 = phi i8* [ %t40, %then4 ], [ null, %else5 ]
  %t310 = phi i1 [ %t41, %then4 ], [ 1, %else5 ]
  %t311 = phi double [ %t45, %then4 ], [ %t211, %else5 ]
  %t312 = phi i1 [ %t42, %then4 ], [ 1, %else5 ]
  %t313 = phi double [ %t46, %then4 ], [ %t260, %else5 ]
  store i8* %t302, i8** %l5
  store i1 %t303, i1* %l2
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
  br label %loop.latch2
loop.latch2:
  %t314 = load i8*, i8** %l5
  %t315 = load i1, i1* %l2
  %t316 = load i1, i1* %l3
  %t317 = load double, double* %l9
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t319 = load i1, i1* %l4
  %t320 = load double, double* %l10
  %t321 = load i8*, i8** %l6
  %t322 = load i1, i1* %l7
  %t323 = load double, double* %l11
  %t324 = load i1, i1* %l8
  %t325 = load double, double* %l12
  br label %loop.header0
afterloop3:
  %t338 = load i8*, i8** %l6
  store double 0.0, double* %l23
  %t339 = load double, double* %l23
  %t340 = fcmp one double %t339, 0.0
  %t341 = insertvalue %EnumLayoutHeaderParse undef, i1 %t340, 0
  %t342 = load i8*, i8** %l5
  %t343 = insertvalue %EnumLayoutHeaderParse %t341, i8* %t342, 1
  %t344 = load double, double* %l9
  %t345 = insertvalue %EnumLayoutHeaderParse %t343, double %t344, 2
  %t346 = load double, double* %l10
  %t347 = insertvalue %EnumLayoutHeaderParse %t345, double %t346, 3
  %t348 = load i8*, i8** %l6
  %t349 = insertvalue %EnumLayoutHeaderParse %t347, i8* %t348, 4
  %t350 = load double, double* %l11
  %t351 = insertvalue %EnumLayoutHeaderParse %t349, double %t350, 5
  %t352 = load double, double* %l12
  %t353 = insertvalue %EnumLayoutHeaderParse %t351, double %t352, 6
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t355 = insertvalue %EnumLayoutHeaderParse %t353, { i8**, i64 }* %t354, 7
  ret %EnumLayoutHeaderParse %t355
}

define %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i1
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
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
  store double 0.0, double* %l4
  %t26 = load double, double* %l4
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l9
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l10
  %t29 = sitofp i64 0 to double
  store double %t29, double* %l11
  %t30 = sitofp i64 0 to double
  store double %t30, double* %l12
  %t31 = sitofp i64 1 to double
  store double %t31, double* %l13
  %t32 = load i8*, i8** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t36 = load double, double* %l4
  %t37 = load i1, i1* %l5
  %t38 = load i1, i1* %l6
  %t39 = load i1, i1* %l7
  %t40 = load i1, i1* %l8
  %t41 = load double, double* %l9
  %t42 = load double, double* %l10
  %t43 = load double, double* %l11
  %t44 = load double, double* %l12
  %t45 = load double, double* %l13
  br label %loop.header0
loop.header0:
  %t295 = phi i1 [ %t37, %entry ], [ %t286, %loop.latch2 ]
  %t296 = phi double [ %t41, %entry ], [ %t287, %loop.latch2 ]
  %t297 = phi { i8**, i64 }* [ %t33, %entry ], [ %t288, %loop.latch2 ]
  %t298 = phi i1 [ %t38, %entry ], [ %t289, %loop.latch2 ]
  %t299 = phi double [ %t42, %entry ], [ %t290, %loop.latch2 ]
  %t300 = phi i1 [ %t39, %entry ], [ %t291, %loop.latch2 ]
  %t301 = phi double [ %t43, %entry ], [ %t292, %loop.latch2 ]
  %t302 = phi i1 [ %t40, %entry ], [ %t293, %loop.latch2 ]
  %t303 = phi double [ %t44, %entry ], [ %t294, %loop.latch2 ]
  store i1 %t295, i1* %l5
  store double %t296, double* %l9
  store { i8**, i64 }* %t297, { i8**, i64 }** %l1
  store i1 %t298, i1* %l6
  store double %t299, double* %l10
  store i1 %t300, i1* %l7
  store double %t301, double* %l11
  store i1 %t302, i1* %l8
  store double %t303, double* %l12
  br label %loop.body1
loop.body1:
  %t46 = load double, double* %l13
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l3
  store double 0.0, double* %l14
  %t48 = load double, double* %l14
  %s49 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.49, i32 0, i32 0
  %t50 = call i1 @starts_with(i8* null, i8* %s49)
  %t51 = load i8*, i8** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l4
  %t56 = load i1, i1* %l5
  %t57 = load i1, i1* %l6
  %t58 = load i1, i1* %l7
  %t59 = load i1, i1* %l8
  %t60 = load double, double* %l9
  %t61 = load double, double* %l10
  %t62 = load double, double* %l11
  %t63 = load double, double* %l12
  %t64 = load double, double* %l13
  %t65 = load double, double* %l14
  br i1 %t50, label %then4, label %else5
then4:
  %t66 = load double, double* %l14
  %t67 = load double, double* %l14
  store double 0.0, double* %l15
  %t68 = load double, double* %l15
  %t69 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t69, %NumberParseResult* %l16
  %t70 = load %NumberParseResult, %NumberParseResult* %l16
  %t71 = extractvalue %NumberParseResult %t70, 0
  %t72 = load i8*, i8** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t76 = load double, double* %l4
  %t77 = load i1, i1* %l5
  %t78 = load i1, i1* %l6
  %t79 = load i1, i1* %l7
  %t80 = load i1, i1* %l8
  %t81 = load double, double* %l9
  %t82 = load double, double* %l10
  %t83 = load double, double* %l11
  %t84 = load double, double* %l12
  %t85 = load double, double* %l13
  %t86 = load double, double* %l14
  %t87 = load double, double* %l15
  %t88 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t71, label %then7, label %else8
then7:
  store i1 1, i1* %l5
  %t89 = load %NumberParseResult, %NumberParseResult* %l16
  %t90 = extractvalue %NumberParseResult %t89, 1
  store double %t90, double* %l9
  br label %merge9
else8:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s92 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.92, i32 0, i32 0
  %t93 = add i8* %s92, %enum_name
  %s94 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.94, i32 0, i32 0
  %t95 = add i8* %t93, %s94
  %t96 = load double, double* %l4
  br label %merge9
merge9:
  %t97 = phi i1 [ 1, %then7 ], [ %t77, %else8 ]
  %t98 = phi double [ %t90, %then7 ], [ %t81, %else8 ]
  %t99 = phi { i8**, i64 }* [ %t73, %then7 ], [ null, %else8 ]
  store i1 %t97, i1* %l5
  store double %t98, double* %l9
  store { i8**, i64 }* %t99, { i8**, i64 }** %l1
  br label %merge6
else5:
  %t100 = load double, double* %l14
  %s101 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.101, i32 0, i32 0
  %t102 = call i1 @starts_with(i8* null, i8* %s101)
  %t103 = load i8*, i8** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load double, double* %l4
  %t108 = load i1, i1* %l5
  %t109 = load i1, i1* %l6
  %t110 = load i1, i1* %l7
  %t111 = load i1, i1* %l8
  %t112 = load double, double* %l9
  %t113 = load double, double* %l10
  %t114 = load double, double* %l11
  %t115 = load double, double* %l12
  %t116 = load double, double* %l13
  %t117 = load double, double* %l14
  br i1 %t102, label %then10, label %else11
then10:
  %t118 = load double, double* %l14
  %t119 = load double, double* %l14
  store double 0.0, double* %l17
  %t120 = load double, double* %l17
  %t121 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t121, %NumberParseResult* %l18
  %t122 = load %NumberParseResult, %NumberParseResult* %l18
  %t123 = extractvalue %NumberParseResult %t122, 0
  %t124 = load i8*, i8** %l0
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t128 = load double, double* %l4
  %t129 = load i1, i1* %l5
  %t130 = load i1, i1* %l6
  %t131 = load i1, i1* %l7
  %t132 = load i1, i1* %l8
  %t133 = load double, double* %l9
  %t134 = load double, double* %l10
  %t135 = load double, double* %l11
  %t136 = load double, double* %l12
  %t137 = load double, double* %l13
  %t138 = load double, double* %l14
  %t139 = load double, double* %l17
  %t140 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t123, label %then13, label %else14
then13:
  store i1 1, i1* %l6
  %t141 = load %NumberParseResult, %NumberParseResult* %l18
  %t142 = extractvalue %NumberParseResult %t141, 1
  store double %t142, double* %l10
  br label %merge15
else14:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s144 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.144, i32 0, i32 0
  %t145 = add i8* %s144, %enum_name
  %s146 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.146, i32 0, i32 0
  %t147 = add i8* %t145, %s146
  %t148 = load double, double* %l4
  br label %merge15
merge15:
  %t149 = phi i1 [ 1, %then13 ], [ %t130, %else14 ]
  %t150 = phi double [ %t142, %then13 ], [ %t134, %else14 ]
  %t151 = phi { i8**, i64 }* [ %t125, %then13 ], [ null, %else14 ]
  store i1 %t149, i1* %l6
  store double %t150, double* %l10
  store { i8**, i64 }* %t151, { i8**, i64 }** %l1
  br label %merge12
else11:
  %t152 = load double, double* %l14
  %s153 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.153, i32 0, i32 0
  %t154 = call i1 @starts_with(i8* null, i8* %s153)
  %t155 = load i8*, i8** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t159 = load double, double* %l4
  %t160 = load i1, i1* %l5
  %t161 = load i1, i1* %l6
  %t162 = load i1, i1* %l7
  %t163 = load i1, i1* %l8
  %t164 = load double, double* %l9
  %t165 = load double, double* %l10
  %t166 = load double, double* %l11
  %t167 = load double, double* %l12
  %t168 = load double, double* %l13
  %t169 = load double, double* %l14
  br i1 %t154, label %then16, label %else17
then16:
  %t170 = load double, double* %l14
  %t171 = load double, double* %l14
  store double 0.0, double* %l19
  %t172 = load double, double* %l19
  %t173 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t173, %NumberParseResult* %l20
  %t174 = load %NumberParseResult, %NumberParseResult* %l20
  %t175 = extractvalue %NumberParseResult %t174, 0
  %t176 = load i8*, i8** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t180 = load double, double* %l4
  %t181 = load i1, i1* %l5
  %t182 = load i1, i1* %l6
  %t183 = load i1, i1* %l7
  %t184 = load i1, i1* %l8
  %t185 = load double, double* %l9
  %t186 = load double, double* %l10
  %t187 = load double, double* %l11
  %t188 = load double, double* %l12
  %t189 = load double, double* %l13
  %t190 = load double, double* %l14
  %t191 = load double, double* %l19
  %t192 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t175, label %then19, label %else20
then19:
  store i1 1, i1* %l7
  %t193 = load %NumberParseResult, %NumberParseResult* %l20
  %t194 = extractvalue %NumberParseResult %t193, 1
  store double %t194, double* %l11
  br label %merge21
else20:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s196 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.196, i32 0, i32 0
  %t197 = add i8* %s196, %enum_name
  %s198 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.198, i32 0, i32 0
  %t199 = add i8* %t197, %s198
  %t200 = load double, double* %l4
  br label %merge21
merge21:
  %t201 = phi i1 [ 1, %then19 ], [ %t183, %else20 ]
  %t202 = phi double [ %t194, %then19 ], [ %t187, %else20 ]
  %t203 = phi { i8**, i64 }* [ %t177, %then19 ], [ null, %else20 ]
  store i1 %t201, i1* %l7
  store double %t202, double* %l11
  store { i8**, i64 }* %t203, { i8**, i64 }** %l1
  br label %merge18
else17:
  %t204 = load double, double* %l14
  %s205 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.205, i32 0, i32 0
  %t206 = call i1 @starts_with(i8* null, i8* %s205)
  %t207 = load i8*, i8** %l0
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t209 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t211 = load double, double* %l4
  %t212 = load i1, i1* %l5
  %t213 = load i1, i1* %l6
  %t214 = load i1, i1* %l7
  %t215 = load i1, i1* %l8
  %t216 = load double, double* %l9
  %t217 = load double, double* %l10
  %t218 = load double, double* %l11
  %t219 = load double, double* %l12
  %t220 = load double, double* %l13
  %t221 = load double, double* %l14
  br i1 %t206, label %then22, label %else23
then22:
  %t222 = load double, double* %l14
  %t223 = load double, double* %l14
  store double 0.0, double* %l21
  %t224 = load double, double* %l21
  %t225 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t225, %NumberParseResult* %l22
  %t226 = load %NumberParseResult, %NumberParseResult* %l22
  %t227 = extractvalue %NumberParseResult %t226, 0
  %t228 = load i8*, i8** %l0
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t230 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t232 = load double, double* %l4
  %t233 = load i1, i1* %l5
  %t234 = load i1, i1* %l6
  %t235 = load i1, i1* %l7
  %t236 = load i1, i1* %l8
  %t237 = load double, double* %l9
  %t238 = load double, double* %l10
  %t239 = load double, double* %l11
  %t240 = load double, double* %l12
  %t241 = load double, double* %l13
  %t242 = load double, double* %l14
  %t243 = load double, double* %l21
  %t244 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t227, label %then25, label %else26
then25:
  store i1 1, i1* %l8
  %t245 = load %NumberParseResult, %NumberParseResult* %l22
  %t246 = extractvalue %NumberParseResult %t245, 1
  store double %t246, double* %l12
  br label %merge27
else26:
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s248 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.248, i32 0, i32 0
  %t249 = add i8* %s248, %enum_name
  %s250 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.250, i32 0, i32 0
  %t251 = add i8* %t249, %s250
  %t252 = load double, double* %l4
  br label %merge27
merge27:
  %t253 = phi i1 [ 1, %then25 ], [ %t236, %else26 ]
  %t254 = phi double [ %t246, %then25 ], [ %t240, %else26 ]
  %t255 = phi { i8**, i64 }* [ %t229, %then25 ], [ null, %else26 ]
  store i1 %t253, i1* %l8
  store double %t254, double* %l12
  store { i8**, i64 }* %t255, { i8**, i64 }** %l1
  br label %merge24
else23:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s257 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.257, i32 0, i32 0
  %t258 = add i8* %s257, %enum_name
  %s259 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.259, i32 0, i32 0
  %t260 = add i8* %t258, %s259
  %t261 = load double, double* %l4
  br label %merge24
merge24:
  %t262 = phi i1 [ 1, %then22 ], [ %t215, %else23 ]
  %t263 = phi double [ %t246, %then22 ], [ %t219, %else23 ]
  %t264 = phi { i8**, i64 }* [ null, %then22 ], [ null, %else23 ]
  store i1 %t262, i1* %l8
  store double %t263, double* %l12
  store { i8**, i64 }* %t264, { i8**, i64 }** %l1
  br label %merge18
merge18:
  %t265 = phi i1 [ 1, %then16 ], [ %t162, %else17 ]
  %t266 = phi double [ %t194, %then16 ], [ %t166, %else17 ]
  %t267 = phi { i8**, i64 }* [ null, %then16 ], [ null, %else17 ]
  %t268 = phi i1 [ %t163, %then16 ], [ 1, %else17 ]
  %t269 = phi double [ %t167, %then16 ], [ %t246, %else17 ]
  store i1 %t265, i1* %l7
  store double %t266, double* %l11
  store { i8**, i64 }* %t267, { i8**, i64 }** %l1
  store i1 %t268, i1* %l8
  store double %t269, double* %l12
  br label %merge12
merge12:
  %t270 = phi i1 [ 1, %then10 ], [ %t109, %else11 ]
  %t271 = phi double [ %t142, %then10 ], [ %t113, %else11 ]
  %t272 = phi { i8**, i64 }* [ null, %then10 ], [ null, %else11 ]
  %t273 = phi i1 [ %t110, %then10 ], [ 1, %else11 ]
  %t274 = phi double [ %t114, %then10 ], [ %t194, %else11 ]
  %t275 = phi i1 [ %t111, %then10 ], [ 1, %else11 ]
  %t276 = phi double [ %t115, %then10 ], [ %t246, %else11 ]
  store i1 %t270, i1* %l6
  store double %t271, double* %l10
  store { i8**, i64 }* %t272, { i8**, i64 }** %l1
  store i1 %t273, i1* %l7
  store double %t274, double* %l11
  store i1 %t275, i1* %l8
  store double %t276, double* %l12
  br label %merge6
merge6:
  %t277 = phi i1 [ 1, %then4 ], [ %t56, %else5 ]
  %t278 = phi double [ %t90, %then4 ], [ %t60, %else5 ]
  %t279 = phi { i8**, i64 }* [ null, %then4 ], [ null, %else5 ]
  %t280 = phi i1 [ %t57, %then4 ], [ 1, %else5 ]
  %t281 = phi double [ %t61, %then4 ], [ %t142, %else5 ]
  %t282 = phi i1 [ %t58, %then4 ], [ 1, %else5 ]
  %t283 = phi double [ %t62, %then4 ], [ %t194, %else5 ]
  %t284 = phi i1 [ %t59, %then4 ], [ 1, %else5 ]
  %t285 = phi double [ %t63, %then4 ], [ %t246, %else5 ]
  store i1 %t277, i1* %l5
  store double %t278, double* %l9
  store { i8**, i64 }* %t279, { i8**, i64 }** %l1
  store i1 %t280, i1* %l6
  store double %t281, double* %l10
  store i1 %t282, i1* %l7
  store double %t283, double* %l11
  store i1 %t284, i1* %l8
  store double %t285, double* %l12
  br label %loop.latch2
loop.latch2:
  %t286 = load i1, i1* %l5
  %t287 = load double, double* %l9
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t289 = load i1, i1* %l6
  %t290 = load double, double* %l10
  %t291 = load i1, i1* %l7
  %t292 = load double, double* %l11
  %t293 = load i1, i1* %l8
  %t294 = load double, double* %l12
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l23
  %t304 = load double, double* %l4
  %t305 = insertvalue %NativeEnumVariantLayout undef, i8* null, 0
  %t306 = load double, double* %l9
  %t307 = insertvalue %NativeEnumVariantLayout %t305, double %t306, 1
  %t308 = load double, double* %l10
  %t309 = insertvalue %NativeEnumVariantLayout %t307, double %t308, 2
  %t310 = load double, double* %l11
  %t311 = insertvalue %NativeEnumVariantLayout %t309, double %t310, 3
  %t312 = load double, double* %l12
  %t313 = insertvalue %NativeEnumVariantLayout %t311, double %t312, 4
  %t314 = alloca [0 x double]
  %t315 = getelementptr [0 x double], [0 x double]* %t314, i32 0, i32 0
  %t316 = alloca { double*, i64 }
  %t317 = getelementptr { double*, i64 }, { double*, i64 }* %t316, i32 0, i32 0
  store double* %t315, double** %t317
  %t318 = getelementptr { double*, i64 }, { double*, i64 }* %t316, i32 0, i32 1
  store i64 0, i64* %t318
  %t319 = insertvalue %NativeEnumVariantLayout %t313, { i8**, i64 }* null, 5
  store %NativeEnumVariantLayout %t319, %NativeEnumVariantLayout* %l24
  %t320 = load double, double* %l23
  %t321 = fcmp one double %t320, 0.0
  %t322 = insertvalue %EnumLayoutVariantParse undef, i1 %t321, 0
  %t323 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t324 = insertvalue %EnumLayoutVariantParse %t322, i8* null, 1
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t326 = insertvalue %EnumLayoutVariantParse %t324, { i8**, i64 }* %t325, 2
  ret %EnumLayoutVariantParse %t326
}

define %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %text, i8* %enum_name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
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
  %l16 = alloca double
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
  store double 0.0, double* %l4
  %t20 = load double, double* %l4
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t22 = call double @index_of(i8* null, i8* %s21)
  store double %t22, double* %l5
  %t23 = load double, double* %l5
  %t24 = load double, double* %l4
  %t25 = load double, double* %l5
  %t26 = call double @substring(double %t24, i64 0, double %t25)
  store double %t26, double* %l6
  %t27 = load double, double* %l4
  %t28 = load double, double* %l5
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  %t31 = load double, double* %l4
  store double 0.0, double* %l7
  %s32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.32, i32 0, i32 0
  store i8* %s32, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t33 = sitofp i64 0 to double
  store double %t33, double* %l12
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l13
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l14
  %t36 = sitofp i64 1 to double
  store double %t36, double* %l15
  %t37 = load i8*, i8** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load double, double* %l4
  %t42 = load double, double* %l5
  %t43 = load double, double* %l6
  %t44 = load double, double* %l7
  %t45 = load i8*, i8** %l8
  %t46 = load i1, i1* %l9
  %t47 = load i1, i1* %l10
  %t48 = load i1, i1* %l11
  %t49 = load double, double* %l12
  %t50 = load double, double* %l13
  %t51 = load double, double* %l14
  %t52 = load double, double* %l15
  br label %loop.header0
loop.header0:
  %t282 = phi i8* [ %t45, %entry ], [ %t274, %loop.latch2 ]
  %t283 = phi i1 [ %t46, %entry ], [ %t275, %loop.latch2 ]
  %t284 = phi double [ %t49, %entry ], [ %t276, %loop.latch2 ]
  %t285 = phi { i8**, i64 }* [ %t38, %entry ], [ %t277, %loop.latch2 ]
  %t286 = phi i1 [ %t47, %entry ], [ %t278, %loop.latch2 ]
  %t287 = phi double [ %t50, %entry ], [ %t279, %loop.latch2 ]
  %t288 = phi i1 [ %t48, %entry ], [ %t280, %loop.latch2 ]
  %t289 = phi double [ %t51, %entry ], [ %t281, %loop.latch2 ]
  store i8* %t282, i8** %l8
  store i1 %t283, i1* %l9
  store double %t284, double* %l12
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  store i1 %t286, i1* %l10
  store double %t287, double* %l13
  store i1 %t288, i1* %l11
  store double %t289, double* %l14
  br label %loop.body1
loop.body1:
  %t53 = load double, double* %l15
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  store double 0.0, double* %l16
  %t55 = load double, double* %l16
  %s56 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.56, i32 0, i32 0
  %t57 = call i1 @starts_with(i8* null, i8* %s56)
  %t58 = load i8*, i8** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load double, double* %l4
  %t63 = load double, double* %l5
  %t64 = load double, double* %l6
  %t65 = load double, double* %l7
  %t66 = load i8*, i8** %l8
  %t67 = load i1, i1* %l9
  %t68 = load i1, i1* %l10
  %t69 = load i1, i1* %l11
  %t70 = load double, double* %l12
  %t71 = load double, double* %l13
  %t72 = load double, double* %l14
  %t73 = load double, double* %l15
  %t74 = load double, double* %l16
  br i1 %t57, label %then4, label %else5
then4:
  %t75 = load double, double* %l16
  %t76 = load double, double* %l16
  br label %merge6
else5:
  %t77 = load double, double* %l16
  %s78 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.78, i32 0, i32 0
  %t79 = call i1 @starts_with(i8* null, i8* %s78)
  %t80 = load i8*, i8** %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t84 = load double, double* %l4
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
  %t96 = load double, double* %l16
  br i1 %t79, label %then7, label %else8
then7:
  %t97 = load double, double* %l16
  %t98 = load double, double* %l16
  store double 0.0, double* %l17
  %t99 = load double, double* %l17
  %t100 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t100, %NumberParseResult* %l18
  %t101 = load %NumberParseResult, %NumberParseResult* %l18
  %t102 = extractvalue %NumberParseResult %t101, 0
  %t103 = load i8*, i8** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load double, double* %l4
  %t108 = load double, double* %l5
  %t109 = load double, double* %l6
  %t110 = load double, double* %l7
  %t111 = load i8*, i8** %l8
  %t112 = load i1, i1* %l9
  %t113 = load i1, i1* %l10
  %t114 = load i1, i1* %l11
  %t115 = load double, double* %l12
  %t116 = load double, double* %l13
  %t117 = load double, double* %l14
  %t118 = load double, double* %l15
  %t119 = load double, double* %l16
  %t120 = load double, double* %l17
  %t121 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t102, label %then10, label %else11
then10:
  store i1 1, i1* %l9
  %t122 = load %NumberParseResult, %NumberParseResult* %l18
  %t123 = extractvalue %NumberParseResult %t122, 1
  store double %t123, double* %l12
  br label %merge12
else11:
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s125 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.125, i32 0, i32 0
  %t126 = add i8* %s125, %enum_name
  %s127 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.127, i32 0, i32 0
  %t128 = add i8* %t126, %s127
  %t129 = load double, double* %l4
  br label %merge12
merge12:
  %t130 = phi i1 [ 1, %then10 ], [ %t112, %else11 ]
  %t131 = phi double [ %t123, %then10 ], [ %t115, %else11 ]
  %t132 = phi { i8**, i64 }* [ %t104, %then10 ], [ null, %else11 ]
  store i1 %t130, i1* %l9
  store double %t131, double* %l12
  store { i8**, i64 }* %t132, { i8**, i64 }** %l1
  br label %merge9
else8:
  %t133 = load double, double* %l16
  %s134 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.134, i32 0, i32 0
  %t135 = call i1 @starts_with(i8* null, i8* %s134)
  %t136 = load i8*, i8** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t140 = load double, double* %l4
  %t141 = load double, double* %l5
  %t142 = load double, double* %l6
  %t143 = load double, double* %l7
  %t144 = load i8*, i8** %l8
  %t145 = load i1, i1* %l9
  %t146 = load i1, i1* %l10
  %t147 = load i1, i1* %l11
  %t148 = load double, double* %l12
  %t149 = load double, double* %l13
  %t150 = load double, double* %l14
  %t151 = load double, double* %l15
  %t152 = load double, double* %l16
  br i1 %t135, label %then13, label %else14
then13:
  %t153 = load double, double* %l16
  %t154 = load double, double* %l16
  store double 0.0, double* %l19
  %t155 = load double, double* %l19
  %t156 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t156, %NumberParseResult* %l20
  %t157 = load %NumberParseResult, %NumberParseResult* %l20
  %t158 = extractvalue %NumberParseResult %t157, 0
  %t159 = load i8*, i8** %l0
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t163 = load double, double* %l4
  %t164 = load double, double* %l5
  %t165 = load double, double* %l6
  %t166 = load double, double* %l7
  %t167 = load i8*, i8** %l8
  %t168 = load i1, i1* %l9
  %t169 = load i1, i1* %l10
  %t170 = load i1, i1* %l11
  %t171 = load double, double* %l12
  %t172 = load double, double* %l13
  %t173 = load double, double* %l14
  %t174 = load double, double* %l15
  %t175 = load double, double* %l16
  %t176 = load double, double* %l19
  %t177 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t158, label %then16, label %else17
then16:
  store i1 1, i1* %l10
  %t178 = load %NumberParseResult, %NumberParseResult* %l20
  %t179 = extractvalue %NumberParseResult %t178, 1
  store double %t179, double* %l13
  br label %merge18
else17:
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s181 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.181, i32 0, i32 0
  %t182 = add i8* %s181, %enum_name
  %s183 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.183, i32 0, i32 0
  %t184 = add i8* %t182, %s183
  %t185 = load double, double* %l4
  br label %merge18
merge18:
  %t186 = phi i1 [ 1, %then16 ], [ %t169, %else17 ]
  %t187 = phi double [ %t179, %then16 ], [ %t172, %else17 ]
  %t188 = phi { i8**, i64 }* [ %t160, %then16 ], [ null, %else17 ]
  store i1 %t186, i1* %l10
  store double %t187, double* %l13
  store { i8**, i64 }* %t188, { i8**, i64 }** %l1
  br label %merge15
else14:
  %t189 = load double, double* %l16
  %s190 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.190, i32 0, i32 0
  %t191 = call i1 @starts_with(i8* null, i8* %s190)
  %t192 = load i8*, i8** %l0
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t194 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t196 = load double, double* %l4
  %t197 = load double, double* %l5
  %t198 = load double, double* %l6
  %t199 = load double, double* %l7
  %t200 = load i8*, i8** %l8
  %t201 = load i1, i1* %l9
  %t202 = load i1, i1* %l10
  %t203 = load i1, i1* %l11
  %t204 = load double, double* %l12
  %t205 = load double, double* %l13
  %t206 = load double, double* %l14
  %t207 = load double, double* %l15
  %t208 = load double, double* %l16
  br i1 %t191, label %then19, label %else20
then19:
  %t209 = load double, double* %l16
  %t210 = load double, double* %l16
  store double 0.0, double* %l21
  %t211 = load double, double* %l21
  %t212 = call %NumberParseResult @parse_decimal_number(i8* null)
  store %NumberParseResult %t212, %NumberParseResult* %l22
  %t213 = load %NumberParseResult, %NumberParseResult* %l22
  %t214 = extractvalue %NumberParseResult %t213, 0
  %t215 = load i8*, i8** %l0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t217 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t219 = load double, double* %l4
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
  %t231 = load double, double* %l16
  %t232 = load double, double* %l21
  %t233 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t214, label %then22, label %else23
then22:
  store i1 1, i1* %l11
  %t234 = load %NumberParseResult, %NumberParseResult* %l22
  %t235 = extractvalue %NumberParseResult %t234, 1
  store double %t235, double* %l14
  br label %merge24
else23:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s237 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.237, i32 0, i32 0
  %t238 = add i8* %s237, %enum_name
  %s239 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.239, i32 0, i32 0
  %t240 = add i8* %t238, %s239
  %t241 = load double, double* %l4
  br label %merge24
merge24:
  %t242 = phi i1 [ 1, %then22 ], [ %t226, %else23 ]
  %t243 = phi double [ %t235, %then22 ], [ %t229, %else23 ]
  %t244 = phi { i8**, i64 }* [ %t216, %then22 ], [ null, %else23 ]
  store i1 %t242, i1* %l11
  store double %t243, double* %l14
  store { i8**, i64 }* %t244, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s246 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.246, i32 0, i32 0
  %t247 = add i8* %s246, %enum_name
  %s248 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.248, i32 0, i32 0
  %t249 = add i8* %t247, %s248
  %t250 = load double, double* %l4
  br label %merge21
merge21:
  %t251 = phi i1 [ 1, %then19 ], [ %t203, %else20 ]
  %t252 = phi double [ %t235, %then19 ], [ %t206, %else20 ]
  %t253 = phi { i8**, i64 }* [ null, %then19 ], [ null, %else20 ]
  store i1 %t251, i1* %l11
  store double %t252, double* %l14
  store { i8**, i64 }* %t253, { i8**, i64 }** %l1
  br label %merge15
merge15:
  %t254 = phi i1 [ 1, %then13 ], [ %t146, %else14 ]
  %t255 = phi double [ %t179, %then13 ], [ %t149, %else14 ]
  %t256 = phi { i8**, i64 }* [ null, %then13 ], [ null, %else14 ]
  %t257 = phi i1 [ %t147, %then13 ], [ 1, %else14 ]
  %t258 = phi double [ %t150, %then13 ], [ %t235, %else14 ]
  store i1 %t254, i1* %l10
  store double %t255, double* %l13
  store { i8**, i64 }* %t256, { i8**, i64 }** %l1
  store i1 %t257, i1* %l11
  store double %t258, double* %l14
  br label %merge9
merge9:
  %t259 = phi i1 [ 1, %then7 ], [ %t89, %else8 ]
  %t260 = phi double [ %t123, %then7 ], [ %t92, %else8 ]
  %t261 = phi { i8**, i64 }* [ null, %then7 ], [ null, %else8 ]
  %t262 = phi i1 [ %t90, %then7 ], [ 1, %else8 ]
  %t263 = phi double [ %t93, %then7 ], [ %t179, %else8 ]
  %t264 = phi i1 [ %t91, %then7 ], [ 1, %else8 ]
  %t265 = phi double [ %t94, %then7 ], [ %t235, %else8 ]
  store i1 %t259, i1* %l9
  store double %t260, double* %l12
  store { i8**, i64 }* %t261, { i8**, i64 }** %l1
  store i1 %t262, i1* %l10
  store double %t263, double* %l13
  store i1 %t264, i1* %l11
  store double %t265, double* %l14
  br label %merge6
merge6:
  %t266 = phi i8* [ null, %then4 ], [ %t66, %else5 ]
  %t267 = phi i1 [ %t67, %then4 ], [ 1, %else5 ]
  %t268 = phi double [ %t70, %then4 ], [ %t123, %else5 ]
  %t269 = phi { i8**, i64 }* [ %t59, %then4 ], [ null, %else5 ]
  %t270 = phi i1 [ %t68, %then4 ], [ 1, %else5 ]
  %t271 = phi double [ %t71, %then4 ], [ %t179, %else5 ]
  %t272 = phi i1 [ %t69, %then4 ], [ 1, %else5 ]
  %t273 = phi double [ %t72, %then4 ], [ %t235, %else5 ]
  store i8* %t266, i8** %l8
  store i1 %t267, i1* %l9
  store double %t268, double* %l12
  store { i8**, i64 }* %t269, { i8**, i64 }** %l1
  store i1 %t270, i1* %l10
  store double %t271, double* %l13
  store i1 %t272, i1* %l11
  store double %t273, double* %l14
  br label %loop.latch2
loop.latch2:
  %t274 = load i8*, i8** %l8
  %t275 = load i1, i1* %l9
  %t276 = load double, double* %l12
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t278 = load i1, i1* %l10
  %t279 = load double, double* %l13
  %t280 = load i1, i1* %l11
  %t281 = load double, double* %l14
  br label %loop.header0
afterloop3:
  %t290 = load i8*, i8** %l8
  %t291 = load i8*, i8** %l8
  store double 0.0, double* %l23
  %t292 = load double, double* %l7
  %t293 = insertvalue %NativeStructLayoutField undef, i8* null, 0
  %t294 = load i8*, i8** %l8
  %t295 = insertvalue %NativeStructLayoutField %t293, i8* %t294, 1
  %t296 = load double, double* %l12
  %t297 = insertvalue %NativeStructLayoutField %t295, double %t296, 2
  %t298 = load double, double* %l13
  %t299 = insertvalue %NativeStructLayoutField %t297, double %t298, 3
  %t300 = load double, double* %l14
  %t301 = insertvalue %NativeStructLayoutField %t299, double %t300, 4
  store %NativeStructLayoutField %t301, %NativeStructLayoutField* %l24
  %t302 = load double, double* %l23
  %t303 = fcmp one double %t302, 0.0
  %t304 = insertvalue %EnumLayoutPayloadParse undef, i1 %t303, 0
  %t305 = load double, double* %l6
  %t306 = insertvalue %EnumLayoutPayloadParse %t304, i8* null, 1
  %t307 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t308 = insertvalue %EnumLayoutPayloadParse %t306, i8* null, 2
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = insertvalue %EnumLayoutPayloadParse %t308, { i8**, i64 }* %t309, 3
  ret %EnumLayoutPayloadParse %t310
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
  %l2 = alloca double
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
  %t9 = phi i8* [ %t2, %entry ], [ %t8, %loop.latch2 ]
  store i8* %t9, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t8 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @trim_text(i8* %t10)
  store i8* %t11, i8** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.12, i32 0, i32 0
  store i8* %s12, i8** %l3
  store double 0.0, double* %l4
  %t13 = load double, double* %l1
  store i8* null, i8** %l5
  %t14 = load i8*, i8** %l5
  %t15 = load i8*, i8** %l0
  %t16 = insertvalue %BindingComponents undef, i8* %t15, 0
  %t17 = load i8*, i8** %l3
  %t18 = insertvalue %BindingComponents %t16, i8* %t17, 1
  %t19 = load double, double* %l4
  %t20 = insertvalue %BindingComponents %t18, i8* null, 2
  ret %BindingComponents %t20
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
  %t25 = phi i8* [ %t10, %entry ], [ %t24, %loop.latch2 ]
  store i8* %t25, i8** %l1
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  store double 0.0, double* %l5
  %t15 = load i8*, i8** %l4
  %t16 = load double, double* %l5
  %t17 = load double, double* %l5
  %s18 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.18, i32 0, i32 0
  %t19 = load double, double* %l5
  %t20 = load double, double* %l5
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  %t24 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t26 = load i8*, i8** %l1
  %t27 = call i8* @trim_text(i8* %t26)
  store i8* %t27, i8** %l6
  %t28 = load i8*, i8** %l6
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t29
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
  %t5 = sitofp i64 -1 to double
  store double %t5, double* %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t49 = phi { i8**, i64 }* [ %t7, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t8, %entry ], [ %t48, %loop.latch2 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store double %t50, double* %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  store double 0.0, double* %l4
  %t12 = load double, double* %l4
  %t13 = fcmp one double %t12, 0.0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  br i1 %t13, label %then4, label %else5
then4:
  %t19 = load double, double* %l1
  %t20 = sitofp i64 0 to double
  %t21 = fcmp oge double %t19, %t20
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  %t25 = load double, double* %l3
  %t26 = load double, double* %l4
  br i1 %t21, label %then7, label %merge8
then7:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = call double @substring(i8* %value, double %t28, double %t29)
  %t31 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t27, i8* null)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = sitofp i64 -1 to double
  store double %t32, double* %l1
  br label %merge8
merge8:
  %t33 = phi { i8**, i64 }* [ %t31, %then7 ], [ %t22, %then4 ]
  %t34 = phi double [ %t32, %then7 ], [ %t23, %then4 ]
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  store double %t34, double* %l1
  br label %merge6
else5:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 0 to double
  %t37 = fcmp olt double %t35, %t36
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l2
  %t41 = load double, double* %l3
  %t42 = load double, double* %l4
  br i1 %t37, label %then9, label %merge10
then9:
  %t43 = load double, double* %l2
  store double %t43, double* %l1
  br label %merge10
merge10:
  %t44 = phi double [ %t43, %then9 ], [ %t39, %else5 ]
  store double %t44, double* %l1
  br label %merge6
merge6:
  %t45 = phi { i8**, i64 }* [ %t31, %then4 ], [ %t14, %else5 ]
  %t46 = phi double [ %t32, %then4 ], [ %t43, %else5 ]
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 0 to double
  %t53 = fcmp oge double %t51, %t52
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  br i1 %t53, label %then11, label %merge12
then11:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  br label %merge12
merge12:
  %t59 = phi { i8**, i64 }* [ null, %then11 ], [ %t54, %entry ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t60
}

define %NumberParseResult @parse_decimal_number(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  %t27 = phi double [ %t12, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l4
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l3
  %t14 = load i8*, i8** %l0
  store double 0.0, double* %l5
  %t15 = load double, double* %l5
  %t16 = call double @char_code(double %t15)
  store double %t16, double* %l6
  %t17 = load double, double* %l6
  %t18 = load double, double* %l6
  %t19 = load double, double* %l1
  %t20 = fsub double %t18, %t19
  store double %t20, double* %l7
  %t21 = load double, double* %l4
  %t22 = sitofp i64 10 to double
  %t23 = fmul double %t21, %t22
  %t24 = load double, double* %l7
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l4
  br label %loop.latch2
loop.latch2:
  %t26 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t28 = insertvalue %NumberParseResult undef, i1 1, 0
  %t29 = load double, double* %l4
  %t30 = insertvalue %NumberParseResult %t28, double %t29, 1
  ret %NumberParseResult %t30
}

define { i8**, i64 }* @split_lines(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
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
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load i8*, i8** %l1
  %t15 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t13, i8* %t14)
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t16
}

define { i8**, i64 }* @split_comma_separated(i8* %value) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
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
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = load i8*, i8** %l1
  %t14 = alloca [0 x double]
  %t15 = getelementptr [0 x double], [0 x double]* %t14, i32 0, i32 0
  %t16 = alloca { double*, i64 }
  %t17 = getelementptr { double*, i64 }, { double*, i64 }* %t16, i32 0, i32 0
  store double* %t15, double** %t17
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l2
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load double, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t24 = load double, double* %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l5
  %t26 = load double, double* %l5
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t27
}

define i8* @strip_generics(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
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
  %t20 = phi i8* [ %t3, %entry ], [ %t19, %loop.latch2 ]
  store i8* %t20, i8** %l0
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  store double 0.0, double* %l3
  %t7 = load double, double* %l3
  %t8 = load double, double* %l3
  %t9 = load double, double* %l1
  %t10 = sitofp i64 0 to double
  %t11 = fcmp oeq double %t9, %t10
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = load double, double* %l3
  br i1 %t11, label %then4, label %merge5
then4:
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l3
  br label %merge5
merge5:
  %t18 = phi i8* [ null, %then4 ], [ %t12, %loop.body1 ]
  store i8* %t18, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t19 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @trim_text(i8* %t21)
  ret i8* %t22
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

define %LayoutManifest @parse_layout_manifest(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeStruct*, i64 }*
  %l3 = alloca { %NativeEnum*, i64 }*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca %StructLayoutHeaderParse
  %l10 = alloca { %NativeStructLayoutField*, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %StructLayoutFieldParse
  %l16 = alloca double
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca %EnumLayoutHeaderParse
  %l20 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l21 = alloca i8*
  %l22 = alloca double
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
  %t337 = phi { i8**, i64 }* [ %t18, %entry ], [ %t334, %loop.latch2 ]
  %t338 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t335, %loop.latch2 ]
  %t339 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t336, %loop.latch2 ]
  store { i8**, i64 }* %t337, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t338, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t339, { %NativeEnum*, i64 }** %l3
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l5
  %t24 = load double, double* %l5
  %t25 = call i8* @trim_text(i8* null)
  store i8* %t25, i8** %l6
  %t26 = load i8*, i8** %l6
  %t27 = load i8*, i8** %l6
  %s28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.28, i32 0, i32 0
  %t29 = call i1 @starts_with(i8* %t27, i8* %s28)
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t33 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load i8*, i8** %l6
  br i1 %t29, label %then4, label %merge5
then4:
  br label %loop.latch2
merge5:
  %t37 = load i8*, i8** %l6
  %s38 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i1 @starts_with(i8* %t37, i8* %s38)
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t43 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t44 = load double, double* %l4
  %t45 = load double, double* %l5
  %t46 = load i8*, i8** %l6
  br i1 %t39, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  %t47 = load i8*, i8** %l6
  %s48 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.48, i32 0, i32 0
  %t49 = call i1 @starts_with(i8* %t47, i8* %s48)
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t53 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t54 = load double, double* %l4
  %t55 = load double, double* %l5
  %t56 = load i8*, i8** %l6
  br i1 %t49, label %then8, label %merge9
then8:
  %t57 = load i8*, i8** %l6
  %s58 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.58, i32 0, i32 0
  %t59 = call i8* @strip_prefix(i8* %t57, i8* %s58)
  store i8* %t59, i8** %l7
  %t60 = load i8*, i8** %l7
  %s61 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i8* @strip_prefix(i8* %t60, i8* %s61)
  store i8* %t62, i8** %l8
  %t63 = load i8*, i8** %l8
  %t64 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t63)
  store %StructLayoutHeaderParse %t64, %StructLayoutHeaderParse* %l9
  %t65 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t66 = extractvalue %StructLayoutHeaderParse %t65, 4
  %t67 = call double @diagnosticsconcat({ i8**, i64 }* %t66)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t68 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t69 = extractvalue %StructLayoutHeaderParse %t68, 0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t73 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t74 = load double, double* %l4
  %t75 = load double, double* %l5
  %t76 = load i8*, i8** %l6
  %t77 = load i8*, i8** %l7
  %t78 = load i8*, i8** %l8
  %t79 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t69, label %then10, label %merge11
then10:
  %t80 = alloca [0 x double]
  %t81 = getelementptr [0 x double], [0 x double]* %t80, i32 0, i32 0
  %t82 = alloca { double*, i64 }
  %t83 = getelementptr { double*, i64 }, { double*, i64 }* %t82, i32 0, i32 0
  store double* %t81, double** %t83
  %t84 = getelementptr { double*, i64 }, { double*, i64 }* %t82, i32 0, i32 1
  store i64 0, i64* %t84
  store { %NativeStructLayoutField*, i64 }* null, { %NativeStructLayoutField*, i64 }** %l10
  %t85 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t86 = extractvalue %StructLayoutHeaderParse %t85, 1
  store i8* %t86, i8** %l11
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t90 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t91 = load double, double* %l4
  %t92 = load double, double* %l5
  %t93 = load i8*, i8** %l6
  %t94 = load i8*, i8** %l7
  %t95 = load i8*, i8** %l8
  %t96 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t97 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t98 = load i8*, i8** %l11
  br label %loop.header12
loop.header12:
  %t157 = phi i8* [ %t94, %then10 ], [ %t154, %loop.latch14 ]
  %t158 = phi { i8**, i64 }* [ %t88, %then10 ], [ %t155, %loop.latch14 ]
  %t159 = phi { %NativeStructLayoutField*, i64 }* [ %t97, %then10 ], [ %t156, %loop.latch14 ]
  store i8* %t157, i8** %l7
  store { i8**, i64 }* %t158, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t159, { %NativeStructLayoutField*, i64 }** %l10
  br label %loop.body13
loop.body13:
  %t99 = load double, double* %l4
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l12
  %t101 = load double, double* %l12
  %t102 = load double, double* %l12
  %s103 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.103, i32 0, i32 0
  %t104 = call double @starts_with(double %t102, i8* %s103)
  %t105 = fcmp one double %t104, 0.0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t108 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t109 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t110 = load double, double* %l4
  %t111 = load double, double* %l5
  %t112 = load i8*, i8** %l6
  %t113 = load i8*, i8** %l7
  %t114 = load i8*, i8** %l8
  %t115 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t116 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t117 = load i8*, i8** %l11
  %t118 = load double, double* %l12
  br i1 %t105, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t119 = load double, double* %l12
  %s120 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i8* @strip_prefix(i8* null, i8* %s120)
  store i8* %t121, i8** %l13
  %t122 = load i8*, i8** %l7
  %s123 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.123, i32 0, i32 0
  %t124 = call i8* @strip_prefix(i8* %t122, i8* %s123)
  store i8* %t124, i8** %l14
  %t125 = load i8*, i8** %l14
  %t126 = load i8*, i8** %l11
  %t127 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t125, i8* %t126)
  store %StructLayoutFieldParse %t127, %StructLayoutFieldParse* %l15
  %t128 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t129 = extractvalue %StructLayoutFieldParse %t128, 2
  %t130 = call double @diagnosticsconcat({ i8**, i64 }* %t129)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t131 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t132 = extractvalue %StructLayoutFieldParse %t131, 0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t136 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t137 = load double, double* %l4
  %t138 = load double, double* %l5
  %t139 = load i8*, i8** %l6
  %t140 = load i8*, i8** %l7
  %t141 = load i8*, i8** %l8
  %t142 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t143 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t144 = load i8*, i8** %l11
  %t145 = load double, double* %l12
  %t146 = load i8*, i8** %l13
  %t147 = load i8*, i8** %l14
  %t148 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t132, label %then18, label %merge19
then18:
  %t149 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t150 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t151 = extractvalue %StructLayoutFieldParse %t150, 1
  %t152 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t149, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t152, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge19
merge19:
  %t153 = phi { %NativeStructLayoutField*, i64 }* [ %t152, %then18 ], [ %t143, %loop.body13 ]
  store { %NativeStructLayoutField*, i64 }* %t153, { %NativeStructLayoutField*, i64 }** %l10
  br label %loop.latch14
loop.latch14:
  %t154 = load i8*, i8** %l7
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  br label %loop.header12
afterloop15:
  store double 0.0, double* %l16
  %t160 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t161 = load double, double* %l16
  %t162 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t160, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t162, { %NativeStruct*, i64 }** %l2
  br label %merge11
merge11:
  %t163 = phi i8* [ %t121, %then10 ], [ %t77, %then8 ]
  %t164 = phi { i8**, i64 }* [ null, %then10 ], [ %t71, %then8 ]
  %t165 = phi { %NativeStruct*, i64 }* [ %t162, %then10 ], [ %t72, %then8 ]
  store i8* %t163, i8** %l7
  store { i8**, i64 }* %t164, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t165, { %NativeStruct*, i64 }** %l2
  br label %loop.latch2
merge9:
  %t166 = load i8*, i8** %l6
  %s167 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.167, i32 0, i32 0
  %t168 = call i1 @starts_with(i8* %t166, i8* %s167)
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t172 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t173 = load double, double* %l4
  %t174 = load double, double* %l5
  %t175 = load i8*, i8** %l6
  br i1 %t168, label %then20, label %merge21
then20:
  %t176 = load i8*, i8** %l6
  %s177 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.177, i32 0, i32 0
  %t178 = call i8* @strip_prefix(i8* %t176, i8* %s177)
  store i8* %t178, i8** %l17
  %t179 = load i8*, i8** %l17
  %s180 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.180, i32 0, i32 0
  %t181 = call i8* @strip_prefix(i8* %t179, i8* %s180)
  store i8* %t181, i8** %l18
  %t182 = load i8*, i8** %l18
  %t183 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t182)
  store %EnumLayoutHeaderParse %t183, %EnumLayoutHeaderParse* %l19
  %t184 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t185 = extractvalue %EnumLayoutHeaderParse %t184, 7
  %t186 = call double @diagnosticsconcat({ i8**, i64 }* %t185)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t187 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t188 = extractvalue %EnumLayoutHeaderParse %t187, 0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t191 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t192 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t193 = load double, double* %l4
  %t194 = load double, double* %l5
  %t195 = load i8*, i8** %l6
  %t196 = load i8*, i8** %l17
  %t197 = load i8*, i8** %l18
  %t198 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t188, label %then22, label %else23
then22:
  %t199 = alloca [0 x double]
  %t200 = getelementptr [0 x double], [0 x double]* %t199, i32 0, i32 0
  %t201 = alloca { double*, i64 }
  %t202 = getelementptr { double*, i64 }, { double*, i64 }* %t201, i32 0, i32 0
  store double* %t200, double** %t202
  %t203 = getelementptr { double*, i64 }, { double*, i64 }* %t201, i32 0, i32 1
  store i64 0, i64* %t203
  store { %NativeEnumVariantLayout*, i64 }* null, { %NativeEnumVariantLayout*, i64 }** %l20
  %t204 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t205 = extractvalue %EnumLayoutHeaderParse %t204, 1
  store i8* %t205, i8** %l21
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t208 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t209 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t210 = load double, double* %l4
  %t211 = load double, double* %l5
  %t212 = load i8*, i8** %l6
  %t213 = load i8*, i8** %l17
  %t214 = load i8*, i8** %l18
  %t215 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t216 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t217 = load i8*, i8** %l21
  br label %loop.header25
loop.header25:
  %t325 = phi i8* [ %t213, %then22 ], [ %t322, %loop.latch27 ]
  %t326 = phi { i8**, i64 }* [ %t207, %then22 ], [ %t323, %loop.latch27 ]
  %t327 = phi { %NativeEnumVariantLayout*, i64 }* [ %t216, %then22 ], [ %t324, %loop.latch27 ]
  store i8* %t325, i8** %l17
  store { i8**, i64 }* %t326, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t327, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body26
loop.body26:
  %t218 = load double, double* %l4
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  store double 0.0, double* %l22
  %t220 = load double, double* %l22
  %t221 = load double, double* %l22
  %s222 = getelementptr inbounds [67 x i8], [67 x i8]* @.str.222, i32 0, i32 0
  %t223 = call double @starts_with(double %t221, i8* %s222)
  %t224 = fcmp one double %t223, 0.0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t227 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t228 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t229 = load double, double* %l4
  %t230 = load double, double* %l5
  %t231 = load i8*, i8** %l6
  %t232 = load i8*, i8** %l17
  %t233 = load i8*, i8** %l18
  %t234 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t235 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t236 = load i8*, i8** %l21
  %t237 = load double, double* %l22
  br i1 %t224, label %then29, label %merge30
then29:
  br label %afterloop28
merge30:
  %t238 = load double, double* %l22
  %s239 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.239, i32 0, i32 0
  %t240 = call i1 @starts_with(i8* null, i8* %s239)
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t244 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t245 = load double, double* %l4
  %t246 = load double, double* %l5
  %t247 = load i8*, i8** %l6
  %t248 = load i8*, i8** %l17
  %t249 = load i8*, i8** %l18
  %t250 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t251 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t252 = load i8*, i8** %l21
  %t253 = load double, double* %l22
  br i1 %t240, label %then31, label %else32
then31:
  %t254 = load double, double* %l22
  %s255 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.255, i32 0, i32 0
  %t256 = call i8* @strip_prefix(i8* null, i8* %s255)
  store i8* %t256, i8** %l23
  %t257 = load i8*, i8** %l17
  %s258 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.258, i32 0, i32 0
  %t259 = call i8* @strip_prefix(i8* %t257, i8* %s258)
  store i8* %t259, i8** %l24
  %t260 = load i8*, i8** %l24
  %t261 = load i8*, i8** %l21
  %t262 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t260, i8* %t261)
  store %EnumLayoutVariantParse %t262, %EnumLayoutVariantParse* %l25
  %t263 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t264 = extractvalue %EnumLayoutVariantParse %t263, 2
  %t265 = call double @diagnosticsconcat({ i8**, i64 }* %t264)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t266 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t267 = extractvalue %EnumLayoutVariantParse %t266, 0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t270 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t271 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t272 = load double, double* %l4
  %t273 = load double, double* %l5
  %t274 = load i8*, i8** %l6
  %t275 = load i8*, i8** %l17
  %t276 = load i8*, i8** %l18
  %t277 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t278 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t279 = load i8*, i8** %l21
  %t280 = load double, double* %l22
  %t281 = load i8*, i8** %l23
  %t282 = load i8*, i8** %l24
  %t283 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t267, label %then34, label %merge35
then34:
  %t284 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t285 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t286 = extractvalue %EnumLayoutVariantParse %t285, 1
  %t287 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t284, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t287, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge35
merge35:
  %t288 = phi { %NativeEnumVariantLayout*, i64 }* [ %t287, %then34 ], [ %t278, %then31 ]
  store { %NativeEnumVariantLayout*, i64 }* %t288, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge33
else32:
  %t289 = load double, double* %l22
  %s290 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.290, i32 0, i32 0
  %t291 = call i1 @starts_with(i8* null, i8* %s290)
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t294 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t295 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t296 = load double, double* %l4
  %t297 = load double, double* %l5
  %t298 = load i8*, i8** %l6
  %t299 = load i8*, i8** %l17
  %t300 = load i8*, i8** %l18
  %t301 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t302 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t303 = load i8*, i8** %l21
  %t304 = load double, double* %l22
  br i1 %t291, label %then36, label %merge37
then36:
  %t305 = load double, double* %l22
  %s306 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.306, i32 0, i32 0
  %t307 = call i8* @strip_prefix(i8* null, i8* %s306)
  store i8* %t307, i8** %l26
  %t308 = load i8*, i8** %l17
  %s309 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.309, i32 0, i32 0
  %t310 = call i8* @strip_prefix(i8* %t308, i8* %s309)
  store i8* %t310, i8** %l27
  %t311 = load i8*, i8** %l27
  %t312 = load i8*, i8** %l21
  %t313 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t311, i8* %t312)
  store %EnumLayoutPayloadParse %t313, %EnumLayoutPayloadParse* %l28
  %t314 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t315 = extractvalue %EnumLayoutPayloadParse %t314, 3
  %t316 = call double @diagnosticsconcat({ i8**, i64 }* %t315)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t317 = phi i8* [ %t307, %then36 ], [ %t299, %else32 ]
  %t318 = phi { i8**, i64 }* [ null, %then36 ], [ %t293, %else32 ]
  store i8* %t317, i8** %l17
  store { i8**, i64 }* %t318, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t319 = phi i8* [ %t256, %then31 ], [ %t307, %else32 ]
  %t320 = phi { i8**, i64 }* [ null, %then31 ], [ null, %else32 ]
  %t321 = phi { %NativeEnumVariantLayout*, i64 }* [ %t287, %then31 ], [ %t251, %else32 ]
  store i8* %t319, i8** %l17
  store { i8**, i64 }* %t320, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t321, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.latch27
loop.latch27:
  %t322 = load i8*, i8** %l17
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t324 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header25
afterloop28:
  store double 0.0, double* %l29
  %t328 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t329 = load double, double* %l29
  %t330 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t328, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t330, { %NativeEnum*, i64 }** %l3
  br label %merge24
else23:
  br label %merge24
merge24:
  %t331 = phi i8* [ %t256, %then22 ], [ %t196, %else23 ]
  %t332 = phi { i8**, i64 }* [ null, %then22 ], [ %t190, %else23 ]
  %t333 = phi { %NativeEnum*, i64 }* [ %t330, %then22 ], [ %t192, %else23 ]
  store i8* %t331, i8** %l17
  store { i8**, i64 }* %t332, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t333, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge21:
  br label %loop.latch2
loop.latch2:
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t335 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t336 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t340 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t341 = insertvalue %LayoutManifest undef, { i8**, i64 }* null, 0
  %t342 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t343 = insertvalue %LayoutManifest %t341, { i8**, i64 }* null, 1
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t345 = insertvalue %LayoutManifest %t343, { i8**, i64 }* %t344, 2
  ret %LayoutManifest %t345
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
