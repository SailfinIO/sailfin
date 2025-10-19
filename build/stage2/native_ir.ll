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
@.str.8 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.13 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.241 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.24 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.60 = private unnamed_addr constant [1 x i8] c"\00"
@.str.25 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [1 x i8] c"\00"
@.str.80 = private unnamed_addr constant [1 x i8] c"\00"
@.str.31 = private unnamed_addr constant [1 x i8] c"\00"
@.str.32 = private unnamed_addr constant [1 x i8] c"\00"
@.str.114 = private unnamed_addr constant [1 x i8] c"\00"
@.str.40 = private unnamed_addr constant [1 x i8] c"\00"

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
  %t990 = phi double [ %t48, %entry ], [ %t981, %loop.latch2 ]
  %t991 = phi { i8**, i64 }* [ %t38, %entry ], [ %t982, %loop.latch2 ]
  %t992 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t983, %loop.latch2 ]
  %t993 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t984, %loop.latch2 ]
  %t994 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t985, %loop.latch2 ]
  %t995 = phi i8* [ %t45, %entry ], [ %t986, %loop.latch2 ]
  %t996 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t987, %loop.latch2 ]
  %t997 = phi i8* [ %t46, %entry ], [ %t988, %loop.latch2 ]
  %t998 = phi i8* [ %t47, %entry ], [ %t989, %loop.latch2 ]
  store double %t990, double* %l11
  store { i8**, i64 }* %t991, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t992, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t993, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t994, { %NativeEnum*, i64 }** %l6
  store i8* %t995, i8** %l8
  store { %NativeFunction*, i64 }* %t996, { %NativeFunction*, i64 }** %l2
  store i8* %t997, i8** %l9
  store i8* %t998, i8** %l10
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
  %t78 = call i64 @sailfin_runtime_string_length(i8* %t77)
  %t79 = icmp eq i64 %t78, 0
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
  %t98 = call i1 @starts_with(i8* %t97, i8* null)
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t102 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t103 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t104 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t105 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t106 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t107 = load i8*, i8** %l8
  %t108 = load i8*, i8** %l9
  %t109 = load i8*, i8** %l10
  %t110 = load double, double* %l11
  %t111 = load i8*, i8** %l12
  %t112 = load i8*, i8** %l13
  br i1 %t98, label %then8, label %merge9
then8:
  %t113 = load double, double* %l11
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l11
  br label %loop.latch2
merge9:
  %t116 = load i8*, i8** %l13
  %s117 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.117, i32 0, i32 0
  %t118 = call i1 @starts_with(i8* %t116, i8* %s117)
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t122 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t123 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t124 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t125 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t126 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t127 = load i8*, i8** %l8
  %t128 = load i8*, i8** %l9
  %t129 = load i8*, i8** %l10
  %t130 = load double, double* %l11
  %t131 = load i8*, i8** %l12
  %t132 = load i8*, i8** %l13
  br i1 %t118, label %then10, label %merge11
then10:
  %t133 = load double, double* %l11
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l11
  br label %loop.latch2
merge11:
  %t136 = load i8*, i8** %l13
  %s137 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.137, i32 0, i32 0
  %t138 = call i1 @starts_with(i8* %t136, i8* %s137)
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t142 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t143 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t144 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t145 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t146 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t147 = load i8*, i8** %l8
  %t148 = load i8*, i8** %l9
  %t149 = load i8*, i8** %l10
  %t150 = load double, double* %l11
  %t151 = load i8*, i8** %l12
  %t152 = load i8*, i8** %l13
  br i1 %t138, label %then12, label %merge13
then12:
  %s153 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.153, i32 0, i32 0
  %t154 = load i8*, i8** %l13
  %s155 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.155, i32 0, i32 0
  %t156 = call i8* @strip_prefix(i8* %t154, i8* %s155)
  %t157 = call double @parse_import_entry(i8* %s153, i8* %t156)
  store double %t157, double* %l14
  %t158 = load double, double* %l14
  %t159 = load double, double* %l11
  %t160 = sitofp i64 1 to double
  %t161 = fadd double %t159, %t160
  store double %t161, double* %l11
  br label %loop.latch2
merge13:
  %t162 = load i8*, i8** %l13
  %s163 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.163, i32 0, i32 0
  %t164 = call i1 @starts_with(i8* %t162, i8* %s163)
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t168 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t169 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t170 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t171 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t172 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t173 = load i8*, i8** %l8
  %t174 = load i8*, i8** %l9
  %t175 = load i8*, i8** %l10
  %t176 = load double, double* %l11
  %t177 = load i8*, i8** %l12
  %t178 = load i8*, i8** %l13
  br i1 %t164, label %then14, label %merge15
then14:
  %s179 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.179, i32 0, i32 0
  %t180 = load i8*, i8** %l13
  %s181 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.181, i32 0, i32 0
  %t182 = call i8* @strip_prefix(i8* %t180, i8* %s181)
  %t183 = call double @parse_import_entry(i8* %s179, i8* %t182)
  store double %t183, double* %l15
  %t184 = load double, double* %l15
  %t185 = load double, double* %l11
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  store double %t187, double* %l11
  br label %loop.latch2
merge15:
  %t188 = load i8*, i8** %l13
  %s189 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.189, i32 0, i32 0
  %t190 = call i1 @starts_with(i8* %t188, i8* %s189)
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t193 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t194 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t195 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t196 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t197 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t198 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t199 = load i8*, i8** %l8
  %t200 = load i8*, i8** %l9
  %t201 = load i8*, i8** %l10
  %t202 = load double, double* %l11
  %t203 = load i8*, i8** %l12
  %t204 = load i8*, i8** %l13
  br i1 %t190, label %then16, label %merge17
then16:
  %t205 = load i8*, i8** %l13
  %s206 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.206, i32 0, i32 0
  %t207 = call i8* @strip_prefix(i8* %t205, i8* %s206)
  %t208 = call double @parse_source_span(i8* %t207)
  store double %t208, double* %l16
  %t209 = load double, double* %l16
  %t210 = load double, double* %l11
  %t211 = sitofp i64 1 to double
  %t212 = fadd double %t210, %t211
  store double %t212, double* %l11
  br label %loop.latch2
merge17:
  %t213 = load i8*, i8** %l13
  %t214 = load i8*, i8** %l13
  %s215 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.215, i32 0, i32 0
  %t216 = call i1 @starts_with(i8* %t214, i8* %s215)
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t220 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t221 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t222 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t223 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t224 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t225 = load i8*, i8** %l8
  %t226 = load i8*, i8** %l9
  %t227 = load i8*, i8** %l10
  %t228 = load double, double* %l11
  %t229 = load i8*, i8** %l12
  %t230 = load i8*, i8** %l13
  br i1 %t216, label %then18, label %merge19
then18:
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load double, double* %l11
  %t233 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t231, double %t232)
  store %StructParseResult %t233, %StructParseResult* %l17
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t235 = load %StructParseResult, %StructParseResult* %l17
  %t236 = extractvalue %StructParseResult %t235, 2
  %t237 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t234, { i8**, i64 }* %t236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l1
  %t238 = load %StructParseResult, %StructParseResult* %l17
  %t239 = extractvalue %StructParseResult %t238, 0
  %t240 = icmp ne i8* %t239, null
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t244 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t245 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t246 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t247 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t248 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t249 = load i8*, i8** %l8
  %t250 = load i8*, i8** %l9
  %t251 = load i8*, i8** %l10
  %t252 = load double, double* %l11
  %t253 = load i8*, i8** %l12
  %t254 = load i8*, i8** %l13
  %t255 = load %StructParseResult, %StructParseResult* %l17
  br i1 %t240, label %then20, label %merge21
then20:
  %t256 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t257 = load %StructParseResult, %StructParseResult* %l17
  %t258 = extractvalue %StructParseResult %t257, 0
  %t259 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t256, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t259, { %NativeStruct*, i64 }** %l4
  br label %merge21
merge21:
  %t260 = phi { %NativeStruct*, i64 }* [ %t259, %then20 ], [ %t245, %then18 ]
  store { %NativeStruct*, i64 }* %t260, { %NativeStruct*, i64 }** %l4
  %t261 = load %StructParseResult, %StructParseResult* %l17
  %t262 = extractvalue %StructParseResult %t261, 1
  store double %t262, double* %l11
  br label %loop.latch2
merge19:
  %t263 = load i8*, i8** %l13
  %s264 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.264, i32 0, i32 0
  %t265 = call i1 @starts_with(i8* %t263, i8* %s264)
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t268 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t269 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t270 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t271 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t272 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t273 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t274 = load i8*, i8** %l8
  %t275 = load i8*, i8** %l9
  %t276 = load i8*, i8** %l10
  %t277 = load double, double* %l11
  %t278 = load i8*, i8** %l12
  %t279 = load i8*, i8** %l13
  br i1 %t265, label %then22, label %merge23
then22:
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load double, double* %l11
  %t282 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t280, double %t281)
  store %InterfaceParseResult %t282, %InterfaceParseResult* %l18
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t284 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t285 = extractvalue %InterfaceParseResult %t284, 2
  %t286 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t283, { i8**, i64 }* %t285)
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  %t287 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t288 = extractvalue %InterfaceParseResult %t287, 0
  %t289 = icmp ne i8* %t288, null
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t292 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t293 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t294 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t295 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t296 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t297 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t298 = load i8*, i8** %l8
  %t299 = load i8*, i8** %l9
  %t300 = load i8*, i8** %l10
  %t301 = load double, double* %l11
  %t302 = load i8*, i8** %l12
  %t303 = load i8*, i8** %l13
  %t304 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  br i1 %t289, label %then24, label %merge25
then24:
  %t305 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t306 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t307 = extractvalue %InterfaceParseResult %t306, 0
  %t308 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t305, %NativeInterface zeroinitializer)
  store { %NativeInterface*, i64 }* %t308, { %NativeInterface*, i64 }** %l5
  br label %merge25
merge25:
  %t309 = phi { %NativeInterface*, i64 }* [ %t308, %then24 ], [ %t295, %then22 ]
  store { %NativeInterface*, i64 }* %t309, { %NativeInterface*, i64 }** %l5
  %t310 = load %InterfaceParseResult, %InterfaceParseResult* %l18
  %t311 = extractvalue %InterfaceParseResult %t310, 1
  store double %t311, double* %l11
  br label %loop.latch2
merge23:
  %t312 = load i8*, i8** %l13
  %s313 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.313, i32 0, i32 0
  %t314 = call i1 @starts_with(i8* %t312, i8* %s313)
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t317 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t318 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t319 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t320 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t321 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t322 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t323 = load i8*, i8** %l8
  %t324 = load i8*, i8** %l9
  %t325 = load i8*, i8** %l10
  %t326 = load double, double* %l11
  %t327 = load i8*, i8** %l12
  %t328 = load i8*, i8** %l13
  br i1 %t314, label %then26, label %merge27
then26:
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t330 = load double, double* %l11
  %t331 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t329, double %t330)
  store %EnumParseResult %t331, %EnumParseResult* %l19
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t333 = load %EnumParseResult, %EnumParseResult* %l19
  %t334 = extractvalue %EnumParseResult %t333, 2
  %t335 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t332, { i8**, i64 }* %t334)
  store { i8**, i64 }* %t335, { i8**, i64 }** %l1
  %t336 = load %EnumParseResult, %EnumParseResult* %l19
  %t337 = extractvalue %EnumParseResult %t336, 0
  %t338 = icmp ne i8* %t337, null
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t341 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t342 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t343 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t344 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t345 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t346 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t347 = load i8*, i8** %l8
  %t348 = load i8*, i8** %l9
  %t349 = load i8*, i8** %l10
  %t350 = load double, double* %l11
  %t351 = load i8*, i8** %l12
  %t352 = load i8*, i8** %l13
  %t353 = load %EnumParseResult, %EnumParseResult* %l19
  br i1 %t338, label %then28, label %merge29
then28:
  %t354 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t355 = load %EnumParseResult, %EnumParseResult* %l19
  %t356 = extractvalue %EnumParseResult %t355, 0
  %t357 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t354, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t357, { %NativeEnum*, i64 }** %l6
  br label %merge29
merge29:
  %t358 = phi { %NativeEnum*, i64 }* [ %t357, %then28 ], [ %t345, %then26 ]
  store { %NativeEnum*, i64 }* %t358, { %NativeEnum*, i64 }** %l6
  %t359 = load %EnumParseResult, %EnumParseResult* %l19
  %t360 = extractvalue %EnumParseResult %t359, 1
  store double %t360, double* %l11
  br label %loop.latch2
merge27:
  %t361 = load i8*, i8** %l13
  %s362 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.362, i32 0, i32 0
  %t363 = call i1 @starts_with(i8* %t361, i8* %s362)
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t366 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t367 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t368 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t369 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t370 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t371 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t372 = load i8*, i8** %l8
  %t373 = load i8*, i8** %l9
  %t374 = load i8*, i8** %l10
  %t375 = load double, double* %l11
  %t376 = load i8*, i8** %l12
  %t377 = load i8*, i8** %l13
  br i1 %t363, label %then30, label %merge31
then30:
  %t378 = load i8*, i8** %l8
  %t379 = icmp ne i8* %t378, null
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t383 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t384 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t385 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t386 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t387 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t388 = load i8*, i8** %l8
  %t389 = load i8*, i8** %l9
  %t390 = load i8*, i8** %l10
  %t391 = load double, double* %l11
  %t392 = load i8*, i8** %l12
  %t393 = load i8*, i8** %l13
  br i1 %t379, label %then32, label %merge33
then32:
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s395 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.395, i32 0, i32 0
  %t396 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t394, i8* %s395)
  store { i8**, i64 }* %t396, { i8**, i64 }** %l1
  br label %merge33
merge33:
  %t397 = phi { i8**, i64 }* [ %t396, %then32 ], [ %t381, %then30 ]
  store { i8**, i64 }* %t397, { i8**, i64 }** %l1
  %t398 = load double, double* %l11
  %t399 = sitofp i64 1 to double
  %t400 = fadd double %t398, %t399
  store double %t400, double* %l11
  br label %loop.latch2
merge31:
  %t401 = load i8*, i8** %l13
  %s402 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.402, i32 0, i32 0
  %t403 = call i1 @starts_with(i8* %t401, i8* %s402)
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t407 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t408 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t409 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t410 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t411 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t412 = load i8*, i8** %l8
  %t413 = load i8*, i8** %l9
  %t414 = load i8*, i8** %l10
  %t415 = load double, double* %l11
  %t416 = load i8*, i8** %l12
  %t417 = load i8*, i8** %l13
  br i1 %t403, label %then34, label %merge35
then34:
  %t418 = load i8*, i8** %l8
  %t419 = icmp eq i8* %t418, null
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t422 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t423 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t424 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t425 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t426 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t427 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t428 = load i8*, i8** %l8
  %t429 = load i8*, i8** %l9
  %t430 = load i8*, i8** %l10
  %t431 = load double, double* %l11
  %t432 = load i8*, i8** %l12
  %t433 = load i8*, i8** %l13
  br i1 %t419, label %then36, label %else37
then36:
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s435 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.435, i32 0, i32 0
  %t436 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t434, i8* %s435)
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  br label %merge38
else37:
  %t437 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t438 = load i8*, i8** %l8
  %t439 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t437, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t439, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge38
merge38:
  %t440 = phi { i8**, i64 }* [ %t436, %then36 ], [ %t421, %else37 ]
  %t441 = phi { %NativeFunction*, i64 }* [ %t422, %then36 ], [ %t439, %else37 ]
  %t442 = phi i8* [ %t428, %then36 ], [ null, %else37 ]
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t441, { %NativeFunction*, i64 }** %l2
  store i8* %t442, i8** %l8
  %t443 = load double, double* %l11
  %t444 = sitofp i64 1 to double
  %t445 = fadd double %t443, %t444
  store double %t445, double* %l11
  br label %loop.latch2
merge35:
  %t446 = load i8*, i8** %l13
  %s447 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.447, i32 0, i32 0
  %t448 = call i1 @starts_with(i8* %t446, i8* %s447)
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t452 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t453 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t454 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t455 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t456 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t457 = load i8*, i8** %l8
  %t458 = load i8*, i8** %l9
  %t459 = load i8*, i8** %l10
  %t460 = load double, double* %l11
  %t461 = load i8*, i8** %l12
  %t462 = load i8*, i8** %l13
  br i1 %t448, label %then39, label %merge40
then39:
  %t463 = load i8*, i8** %l8
  %t464 = icmp ne i8* %t463, null
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t467 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t468 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t469 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t470 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t471 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t472 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t473 = load i8*, i8** %l8
  %t474 = load i8*, i8** %l9
  %t475 = load i8*, i8** %l10
  %t476 = load double, double* %l11
  %t477 = load i8*, i8** %l12
  %t478 = load i8*, i8** %l13
  br i1 %t464, label %then41, label %else42
then41:
  %t479 = load i8*, i8** %l8
  %t480 = load i8*, i8** %l13
  %s481 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.481, i32 0, i32 0
  %t482 = call i8* @strip_prefix(i8* %t480, i8* %s481)
  %t483 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t482)
  store i8* null, i8** %l8
  br label %merge43
else42:
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s485 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.485, i32 0, i32 0
  %t486 = load i8*, i8** %l13
  %t487 = add i8* %s485, %t486
  %t488 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t484, i8* %t487)
  store { i8**, i64 }* %t488, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t489 = phi i8* [ null, %then41 ], [ %t473, %else42 ]
  %t490 = phi { i8**, i64 }* [ %t466, %then41 ], [ %t488, %else42 ]
  store i8* %t489, i8** %l8
  store { i8**, i64 }* %t490, { i8**, i64 }** %l1
  %t491 = load double, double* %l11
  %t492 = sitofp i64 1 to double
  %t493 = fadd double %t491, %t492
  store double %t493, double* %l11
  br label %loop.latch2
merge40:
  %t494 = load i8*, i8** %l13
  %s495 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.495, i32 0, i32 0
  %t496 = call i1 @starts_with(i8* %t494, i8* %s495)
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t499 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t500 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t501 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t502 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t503 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t504 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t505 = load i8*, i8** %l8
  %t506 = load i8*, i8** %l9
  %t507 = load i8*, i8** %l10
  %t508 = load double, double* %l11
  %t509 = load i8*, i8** %l12
  %t510 = load i8*, i8** %l13
  br i1 %t496, label %then44, label %merge45
then44:
  %t511 = load i8*, i8** %l8
  %t512 = icmp ne i8* %t511, null
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t515 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t516 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t517 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t518 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t519 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t520 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t521 = load i8*, i8** %l8
  %t522 = load i8*, i8** %l9
  %t523 = load i8*, i8** %l10
  %t524 = load double, double* %l11
  %t525 = load i8*, i8** %l12
  %t526 = load i8*, i8** %l13
  br i1 %t512, label %then46, label %else47
then46:
  %t527 = load i8*, i8** %l13
  %s528 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.528, i32 0, i32 0
  %t529 = call i8* @strip_prefix(i8* %t527, i8* %s528)
  store i8* %t529, i8** %l20
  %t530 = load double, double* %l11
  %t531 = sitofp i64 1 to double
  %t532 = fadd double %t530, %t531
  store double %t532, double* %l21
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
  br label %loop.header49
loop.header49:
  %t659 = phi double [ %t548, %then46 ], [ %t657, %loop.latch51 ]
  %t660 = phi i8* [ %t547, %then46 ], [ %t658, %loop.latch51 ]
  store double %t659, double* %l21
  store i8* %t660, i8** %l20
  br label %loop.body50
loop.body50:
  %t549 = load double, double* %l21
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t551 = load { i8**, i64 }, { i8**, i64 }* %t550
  %t552 = extractvalue { i8**, i64 } %t551, 1
  %t553 = sitofp i64 %t552 to double
  %t554 = fcmp oge double %t549, %t553
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t557 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t558 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t559 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t560 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t561 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t562 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t563 = load i8*, i8** %l8
  %t564 = load i8*, i8** %l9
  %t565 = load i8*, i8** %l10
  %t566 = load double, double* %l11
  %t567 = load i8*, i8** %l12
  %t568 = load i8*, i8** %l13
  %t569 = load i8*, i8** %l20
  %t570 = load double, double* %l21
  br i1 %t554, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t571 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t572 = load double, double* %l21
  %t573 = load { i8**, i64 }, { i8**, i64 }* %t571
  %t574 = extractvalue { i8**, i64 } %t573, 0
  %t575 = extractvalue { i8**, i64 } %t573, 1
  %t576 = icmp uge i64 %t572, %t575
  ; bounds check: %t576 (if true, out of bounds)
  %t577 = getelementptr i8*, i8** %t574, i64 %t572
  %t578 = load i8*, i8** %t577
  store i8* %t578, i8** %l22
  %t579 = load i8*, i8** %l22
  %t580 = call i64 @sailfin_runtime_string_length(i8* %t579)
  %t581 = icmp eq i64 %t580, 0
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t584 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t585 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t586 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t587 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t588 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t589 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t590 = load i8*, i8** %l8
  %t591 = load i8*, i8** %l9
  %t592 = load i8*, i8** %l10
  %t593 = load double, double* %l11
  %t594 = load i8*, i8** %l12
  %t595 = load i8*, i8** %l13
  %t596 = load i8*, i8** %l20
  %t597 = load double, double* %l21
  %t598 = load i8*, i8** %l22
  br i1 %t581, label %then55, label %merge56
then55:
  br label %afterloop52
merge56:
  %t599 = load i8*, i8** %l22
  %t600 = call i8* @trim_text(i8* %t599)
  store i8* %t600, i8** %l23
  %t601 = load i8*, i8** %l23
  %t602 = call i64 @sailfin_runtime_string_length(i8* %t601)
  %t603 = icmp eq i64 %t602, 0
  %t604 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t605 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t606 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t607 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t608 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t609 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t610 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t611 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t612 = load i8*, i8** %l8
  %t613 = load i8*, i8** %l9
  %t614 = load i8*, i8** %l10
  %t615 = load double, double* %l11
  %t616 = load i8*, i8** %l12
  %t617 = load i8*, i8** %l13
  %t618 = load i8*, i8** %l20
  %t619 = load double, double* %l21
  %t620 = load i8*, i8** %l22
  %t621 = load i8*, i8** %l23
  br i1 %t603, label %then57, label %merge58
then57:
  %t622 = load double, double* %l21
  %t623 = sitofp i64 1 to double
  %t624 = fadd double %t622, %t623
  store double %t624, double* %l21
  br label %loop.latch51
merge58:
  %t625 = load i8*, i8** %l23
  %t626 = call i1 @line_looks_like_parameter_entry(i8* %t625)
  %t627 = xor i1 %t626, 1
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t630 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t631 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t632 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t633 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t634 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t635 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t636 = load i8*, i8** %l8
  %t637 = load i8*, i8** %l9
  %t638 = load i8*, i8** %l10
  %t639 = load double, double* %l11
  %t640 = load i8*, i8** %l12
  %t641 = load i8*, i8** %l13
  %t642 = load i8*, i8** %l20
  %t643 = load double, double* %l21
  %t644 = load i8*, i8** %l22
  %t645 = load i8*, i8** %l23
  br i1 %t627, label %then59, label %merge60
then59:
  br label %afterloop52
merge60:
  %t646 = load i8*, i8** %l20
  %t647 = getelementptr i8, i8* %t646, i64 0
  %t648 = load i8, i8* %t647
  %t649 = add i8 %t648, 32
  %t650 = load i8*, i8** %l23
  %t651 = getelementptr i8, i8* %t650, i64 0
  %t652 = load i8, i8* %t651
  %t653 = add i8 %t649, %t652
  store i8* null, i8** %l20
  %t654 = load double, double* %l21
  %t655 = sitofp i64 1 to double
  %t656 = fadd double %t654, %t655
  store double %t656, double* %l21
  br label %loop.latch51
loop.latch51:
  %t657 = load double, double* %l21
  %t658 = load i8*, i8** %l20
  br label %loop.header49
afterloop52:
  %t661 = load i8*, i8** %l20
  %t662 = call { i8**, i64 }* @split_parameter_entries(i8* %t661)
  store { i8**, i64 }* %t662, { i8**, i64 }** %l24
  %t663 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t664 = load { i8**, i64 }, { i8**, i64 }* %t663
  %t665 = extractvalue { i8**, i64 } %t664, 1
  %t666 = icmp eq i64 %t665, 0
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t669 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t670 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t671 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t672 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t673 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t674 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t675 = load i8*, i8** %l8
  %t676 = load i8*, i8** %l9
  %t677 = load i8*, i8** %l10
  %t678 = load double, double* %l11
  %t679 = load i8*, i8** %l12
  %t680 = load i8*, i8** %l13
  %t681 = load i8*, i8** %l20
  %t682 = load double, double* %l21
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l24
  br i1 %t666, label %then61, label %else62
then61:
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s685 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.685, i32 0, i32 0
  %t686 = load i8*, i8** %l13
  %t687 = add i8* %s685, %t686
  %t688 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t684, i8* %t687)
  store { i8**, i64 }* %t688, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge63
else62:
  %t689 = sitofp i64 0 to double
  store double %t689, double* %l25
  store i1 0, i1* %l26
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t692 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t693 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t694 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t695 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t696 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t697 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t698 = load i8*, i8** %l8
  %t699 = load i8*, i8** %l9
  %t700 = load i8*, i8** %l10
  %t701 = load double, double* %l11
  %t702 = load i8*, i8** %l12
  %t703 = load i8*, i8** %l13
  %t704 = load i8*, i8** %l20
  %t705 = load double, double* %l21
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t707 = load double, double* %l25
  %t708 = load i1, i1* %l26
  br label %loop.header64
loop.header64:
  %t774 = phi double [ %t707, %else62 ], [ %t773, %loop.latch66 ]
  store double %t774, double* %l25
  br label %loop.body65
loop.body65:
  %t709 = load double, double* %l25
  %t710 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t711 = load { i8**, i64 }, { i8**, i64 }* %t710
  %t712 = extractvalue { i8**, i64 } %t711, 1
  %t713 = sitofp i64 %t712 to double
  %t714 = fcmp oge double %t709, %t713
  %t715 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t717 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t718 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t719 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t720 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t721 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t722 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t723 = load i8*, i8** %l8
  %t724 = load i8*, i8** %l9
  %t725 = load i8*, i8** %l10
  %t726 = load double, double* %l11
  %t727 = load i8*, i8** %l12
  %t728 = load i8*, i8** %l13
  %t729 = load i8*, i8** %l20
  %t730 = load double, double* %l21
  %t731 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t732 = load double, double* %l25
  %t733 = load i1, i1* %l26
  br i1 %t714, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t734 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t735 = load double, double* %l25
  %t736 = load { i8**, i64 }, { i8**, i64 }* %t734
  %t737 = extractvalue { i8**, i64 } %t736, 0
  %t738 = extractvalue { i8**, i64 } %t736, 1
  %t739 = icmp uge i64 %t735, %t738
  ; bounds check: %t739 (if true, out of bounds)
  %t740 = getelementptr i8*, i8** %t737, i64 %t735
  %t741 = load i8*, i8** %t740
  store i8* %t741, i8** %l27
  %t742 = load i8*, i8** %l9
  store i8* %t742, i8** %l28
  %t743 = load i1, i1* %l26
  %t744 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t745 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t746 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t747 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t748 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t749 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t750 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t751 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t752 = load i8*, i8** %l8
  %t753 = load i8*, i8** %l9
  %t754 = load i8*, i8** %l10
  %t755 = load double, double* %l11
  %t756 = load i8*, i8** %l12
  %t757 = load i8*, i8** %l13
  %t758 = load i8*, i8** %l20
  %t759 = load double, double* %l21
  %t760 = load { i8**, i64 }*, { i8**, i64 }** %l24
  %t761 = load double, double* %l25
  %t762 = load i1, i1* %l26
  %t763 = load i8*, i8** %l27
  %t764 = load i8*, i8** %l28
  br i1 %t743, label %then70, label %merge71
then70:
  store i8* null, i8** %l28
  br label %merge71
merge71:
  %t765 = phi i8* [ null, %then70 ], [ %t764, %loop.body65 ]
  store i8* %t765, i8** %l28
  %t766 = load i8*, i8** %l27
  %t767 = load i8*, i8** %l28
  %t768 = call double @parse_parameter_entry(i8* %t766, i8* %t767)
  store double %t768, double* %l29
  %t769 = load double, double* %l29
  %t770 = load double, double* %l25
  %t771 = sitofp i64 1 to double
  %t772 = fadd double %t770, %t771
  store double %t772, double* %l25
  br label %loop.latch66
loop.latch66:
  %t773 = load double, double* %l25
  br label %loop.header64
afterloop67:
  store i8* null, i8** %l9
  br label %merge63
merge63:
  %t775 = phi { i8**, i64 }* [ %t688, %then61 ], [ %t668, %else62 ]
  %t776 = phi i8* [ null, %then61 ], [ null, %else62 ]
  store { i8**, i64 }* %t775, { i8**, i64 }** %l1
  store i8* %t776, i8** %l9
  %t777 = load double, double* %l21
  %t778 = sitofp i64 1 to double
  %t779 = fsub double %t777, %t778
  store double %t779, double* %l11
  br label %merge48
else47:
  %t780 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s781 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.781, i32 0, i32 0
  %t782 = load i8*, i8** %l13
  %t783 = add i8* %s781, %t782
  %t784 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t780, i8* %t783)
  store { i8**, i64 }* %t784, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t785 = phi { i8**, i64 }* [ %t688, %then46 ], [ %t784, %else47 ]
  %t786 = phi i8* [ null, %then46 ], [ %t522, %else47 ]
  %t787 = phi double [ %t779, %then46 ], [ %t524, %else47 ]
  store { i8**, i64 }* %t785, { i8**, i64 }** %l1
  store i8* %t786, i8** %l9
  store double %t787, double* %l11
  %t788 = load double, double* %l11
  %t789 = sitofp i64 1 to double
  %t790 = fadd double %t788, %t789
  store double %t790, double* %l11
  br label %loop.latch2
merge45:
  %t791 = load i8*, i8** %l13
  %t792 = load i8*, i8** %l9
  %t793 = load i8*, i8** %l10
  %t794 = call %InstructionParseResult @parse_instruction(i8* %t791, i8* %t792, i8* %t793)
  store %InstructionParseResult %t794, %InstructionParseResult* %l30
  %t795 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t796 = extractvalue %InstructionParseResult %t795, 0
  store { i8**, i64 }* %t796, { i8**, i64 }** %l31
  %t797 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t798 = extractvalue %InstructionParseResult %t797, 1
  %t799 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t800 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t801 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t802 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t803 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t804 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t805 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t806 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t807 = load i8*, i8** %l8
  %t808 = load i8*, i8** %l9
  %t809 = load i8*, i8** %l10
  %t810 = load double, double* %l11
  %t811 = load i8*, i8** %l12
  %t812 = load i8*, i8** %l13
  %t813 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t798, label %then72, label %else73
then72:
  store i8* null, i8** %l9
  br label %merge74
else73:
  %t815 = load i8*, i8** %l9
  %t816 = icmp ne i8* %t815, null
  %t817 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t818 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t819 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t820 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t821 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t822 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t823 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t824 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t825 = load i8*, i8** %l8
  %t826 = load i8*, i8** %l9
  %t827 = load i8*, i8** %l10
  %t828 = load double, double* %l11
  %t829 = load i8*, i8** %l12
  %t830 = load i8*, i8** %l13
  %t831 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t832 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t816, label %then75, label %merge76
then75:
  %t833 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s834 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.834, i32 0, i32 0
  %t835 = load i8*, i8** %l13
  %t836 = add i8* %s834, %t835
  %t837 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t833, i8* %t836)
  store { i8**, i64 }* %t837, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge76
merge76:
  %t838 = phi { i8**, i64 }* [ %t837, %then75 ], [ %t818, %else73 ]
  %t839 = phi i8* [ null, %then75 ], [ %t826, %else73 ]
  store { i8**, i64 }* %t838, { i8**, i64 }** %l1
  store i8* %t839, i8** %l9
  br label %merge74
merge74:
  %t840 = phi i8* [ null, %then72 ], [ null, %else73 ]
  %t841 = phi { i8**, i64 }* [ %t800, %then72 ], [ %t837, %else73 ]
  store i8* %t840, i8** %l9
  store { i8**, i64 }* %t841, { i8**, i64 }** %l1
  %t842 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t843 = extractvalue %InstructionParseResult %t842, 2
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
  %t858 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t859 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t843, label %then77, label %else78
then77:
  store i8* null, i8** %l10
  br label %merge79
else78:
  %t860 = load i8*, i8** %l10
  %t861 = icmp ne i8* %t860, null
  %t862 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t863 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t864 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t865 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t866 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t867 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t868 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t869 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t870 = load i8*, i8** %l8
  %t871 = load i8*, i8** %l9
  %t872 = load i8*, i8** %l10
  %t873 = load double, double* %l11
  %t874 = load i8*, i8** %l12
  %t875 = load i8*, i8** %l13
  %t876 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t877 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t861, label %then80, label %merge81
then80:
  %t878 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s879 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.879, i32 0, i32 0
  %t880 = load i8*, i8** %l13
  %t881 = add i8* %s879, %t880
  %t882 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t878, i8* %t881)
  store { i8**, i64 }* %t882, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge81
merge81:
  %t883 = phi { i8**, i64 }* [ %t882, %then80 ], [ %t863, %else78 ]
  %t884 = phi i8* [ null, %then80 ], [ %t872, %else78 ]
  store { i8**, i64 }* %t883, { i8**, i64 }** %l1
  store i8* %t884, i8** %l10
  br label %merge79
merge79:
  %t885 = phi i8* [ null, %then77 ], [ null, %else78 ]
  %t886 = phi { i8**, i64 }* [ %t845, %then77 ], [ %t882, %else78 ]
  store i8* %t885, i8** %l10
  store { i8**, i64 }* %t886, { i8**, i64 }** %l1
  %t887 = load i8*, i8** %l8
  %t888 = icmp eq i8* %t887, null
  %t889 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t890 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t891 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t892 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t893 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t894 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t895 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t896 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t897 = load i8*, i8** %l8
  %t898 = load i8*, i8** %l9
  %t899 = load i8*, i8** %l10
  %t900 = load double, double* %l11
  %t901 = load i8*, i8** %l12
  %t902 = load i8*, i8** %l13
  %t903 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t904 = load { i8**, i64 }*, { i8**, i64 }** %l31
  br i1 %t888, label %then82, label %merge83
then82:
  %t906 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t907 = load { i8**, i64 }, { i8**, i64 }* %t906
  %t908 = extractvalue { i8**, i64 } %t907, 1
  %t909 = icmp eq i64 %t908, 1
  br label %logical_and_entry_905

logical_and_entry_905:
  br i1 %t909, label %logical_and_right_905, label %logical_and_merge_905

logical_and_right_905:
  %t910 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t911 = load { i8**, i64 }, { i8**, i64 }* %t910
  %t912 = extractvalue { i8**, i64 } %t911, 0
  %t913 = extractvalue { i8**, i64 } %t911, 1
  %t914 = icmp uge i64 0, %t913
  ; bounds check: %t914 (if true, out of bounds)
  %t915 = getelementptr i8*, i8** %t912, i64 0
  %t916 = load i8*, i8** %t915
  %t917 = load double, double* %l11
  %t918 = sitofp i64 1 to double
  %t919 = fadd double %t917, %t918
  store double %t919, double* %l11
  br label %loop.latch2
merge83:
  %t920 = sitofp i64 0 to double
  store double %t920, double* %l32
  %t921 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t923 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t924 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t925 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t926 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t927 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t928 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t929 = load i8*, i8** %l8
  %t930 = load i8*, i8** %l9
  %t931 = load i8*, i8** %l10
  %t932 = load double, double* %l11
  %t933 = load i8*, i8** %l12
  %t934 = load i8*, i8** %l13
  %t935 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t936 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t937 = load double, double* %l32
  br label %loop.header84
loop.header84:
  %t976 = phi i8* [ %t929, %loop.body1 ], [ %t974, %loop.latch86 ]
  %t977 = phi double [ %t937, %loop.body1 ], [ %t975, %loop.latch86 ]
  store i8* %t976, i8** %l8
  store double %t977, double* %l32
  br label %loop.body85
loop.body85:
  %t938 = load double, double* %l32
  %t939 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t940 = load { i8**, i64 }, { i8**, i64 }* %t939
  %t941 = extractvalue { i8**, i64 } %t940, 1
  %t942 = sitofp i64 %t941 to double
  %t943 = fcmp oge double %t938, %t942
  %t944 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t945 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t946 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t947 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t948 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t949 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t950 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t951 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t952 = load i8*, i8** %l8
  %t953 = load i8*, i8** %l9
  %t954 = load i8*, i8** %l10
  %t955 = load double, double* %l11
  %t956 = load i8*, i8** %l12
  %t957 = load i8*, i8** %l13
  %t958 = load %InstructionParseResult, %InstructionParseResult* %l30
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t960 = load double, double* %l32
  br i1 %t943, label %then88, label %merge89
then88:
  br label %afterloop87
merge89:
  %t961 = load i8*, i8** %l8
  %t962 = load { i8**, i64 }*, { i8**, i64 }** %l31
  %t963 = load double, double* %l32
  %t964 = load { i8**, i64 }, { i8**, i64 }* %t962
  %t965 = extractvalue { i8**, i64 } %t964, 0
  %t966 = extractvalue { i8**, i64 } %t964, 1
  %t967 = icmp uge i64 %t963, %t966
  ; bounds check: %t967 (if true, out of bounds)
  %t968 = getelementptr i8*, i8** %t965, i64 %t963
  %t969 = load i8*, i8** %t968
  %t970 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t971 = load double, double* %l32
  %t972 = sitofp i64 1 to double
  %t973 = fadd double %t971, %t972
  store double %t973, double* %l32
  br label %loop.latch86
loop.latch86:
  %t974 = load i8*, i8** %l8
  %t975 = load double, double* %l32
  br label %loop.header84
afterloop87:
  %t978 = load double, double* %l11
  %t979 = sitofp i64 1 to double
  %t980 = fadd double %t978, %t979
  store double %t980, double* %l11
  br label %loop.latch2
loop.latch2:
  %t981 = load double, double* %l11
  %t982 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t983 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t984 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t985 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t986 = load i8*, i8** %l8
  %t987 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t988 = load i8*, i8** %l9
  %t989 = load i8*, i8** %l10
  br label %loop.header0
afterloop3:
  %t999 = load i8*, i8** %l8
  %t1000 = icmp ne i8* %t999, null
  %t1001 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1002 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1003 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1004 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1005 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1006 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1007 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1008 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1009 = load i8*, i8** %l8
  %t1010 = load i8*, i8** %l9
  %t1011 = load i8*, i8** %l10
  %t1012 = load double, double* %l11
  br i1 %t1000, label %then90, label %merge91
then90:
  %t1013 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1014 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.1014, i32 0, i32 0
  %t1015 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1013, i8* %s1014)
  store { i8**, i64 }* %t1015, { i8**, i64 }** %l1
  br label %merge91
merge91:
  %t1016 = phi { i8**, i64 }* [ %t1015, %then90 ], [ %t1002, %entry ]
  store { i8**, i64 }* %t1016, { i8**, i64 }** %l1
  %t1017 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1018 = bitcast { %NativeFunction*, i64 }* %t1017 to { i8**, i64 }*
  %t1019 = insertvalue %ParseNativeResult undef, { i8**, i64 }* %t1018, 0
  %t1020 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1021 = bitcast { %NativeImport*, i64 }* %t1020 to { i8**, i64 }*
  %t1022 = insertvalue %ParseNativeResult %t1019, { i8**, i64 }* %t1021, 1
  %t1023 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1024 = bitcast { %NativeStruct*, i64 }* %t1023 to { i8**, i64 }*
  %t1025 = insertvalue %ParseNativeResult %t1022, { i8**, i64 }* %t1024, 2
  %t1026 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1027 = bitcast { %NativeInterface*, i64 }* %t1026 to { i8**, i64 }*
  %t1028 = insertvalue %ParseNativeResult %t1025, { i8**, i64 }* %t1027, 3
  %t1029 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1030 = bitcast { %NativeEnum*, i64 }* %t1029 to { i8**, i64 }*
  %t1031 = insertvalue %ParseNativeResult %t1028, { i8**, i64 }* %t1030, 4
  %t1032 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1033 = bitcast { %NativeBinding*, i64 }* %t1032 to { i8**, i64 }*
  %t1034 = insertvalue %ParseNativeResult %t1031, { i8**, i64 }* %t1033, 5
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1036 = insertvalue %ParseNativeResult %t1034, { i8**, i64 }* %t1035, 6
  ret %ParseNativeResult %t1036
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
  %t68 = phi { %NativeImportSpecifier*, i64 }* [ %t20, %entry ], [ %t66, %loop.latch4 ]
  %t69 = phi double [ %t21, %entry ], [ %t67, %loop.latch4 ]
  store { %NativeImportSpecifier*, i64 }* %t68, { %NativeImportSpecifier*, i64 }** %l2
  store double %t69, double* %l3
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
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  %t40 = call %NativeImportSpecifier @parse_single_specifier(i8* %t39)
  store %NativeImportSpecifier %t40, %NativeImportSpecifier* %l4
  %t41 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t42 = extractvalue %NativeImportSpecifier %t41, 0
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = icmp sgt i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t48 = load double, double* %l3
  %t49 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  br i1 %t44, label %then8, label %merge9
then8:
  %t50 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t51 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t52 = alloca [1 x %NativeImportSpecifier]
  %t53 = getelementptr [1 x %NativeImportSpecifier], [1 x %NativeImportSpecifier]* %t52, i32 0, i32 0
  %t54 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t53, i64 0
  store %NativeImportSpecifier %t51, %NativeImportSpecifier* %t54
  %t55 = alloca { %NativeImportSpecifier*, i64 }
  %t56 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t55, i32 0, i32 0
  store %NativeImportSpecifier* %t53, %NativeImportSpecifier** %t56
  %t57 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = bitcast { %NativeImportSpecifier*, i64 }* %t50 to { i8**, i64 }*
  %t59 = bitcast { %NativeImportSpecifier*, i64 }* %t55 to { i8**, i64 }*
  %t60 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t58, { i8**, i64 }* %t59)
  %t61 = bitcast { i8**, i64 }* %t60 to { %NativeImportSpecifier*, i64 }*
  store { %NativeImportSpecifier*, i64 }* %t61, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge9
merge9:
  %t62 = phi { %NativeImportSpecifier*, i64 }* [ %t61, %then8 ], [ %t47, %loop.body3 ]
  store { %NativeImportSpecifier*, i64 }* %t62, { %NativeImportSpecifier*, i64 }** %l2
  %t63 = load double, double* %l3
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  store double %t65, double* %l3
  br label %loop.latch4
loop.latch4:
  %t66 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t67 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t70 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t70
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
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = icmp eq i64 %t27, 0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load i8*, i8** %l1
  %t31 = load i8*, i8** %l2
  %t32 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t33 = load i8*, i8** %l4
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t28, label %then0, label %merge1
then0:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s36 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.36, i32 0, i32 0
  %t37 = load i8*, i8** %l1
  %t38 = add i8* %s36, %t37
  %t39 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t35, i8* %t38)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  ret %StructParseResult zeroinitializer
merge1:
  %t40 = alloca [0 x %NativeStructField]
  %t41 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* %t40, i32 0, i32 0
  %t42 = alloca { %NativeStructField*, i64 }
  %t43 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t42, i32 0, i32 0
  store %NativeStructField* %t41, %NativeStructField** %t43
  %t44 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t42, i32 0, i32 1
  store i64 0, i64* %t44
  store { %NativeStructField*, i64 }* %t42, { %NativeStructField*, i64 }** %l6
  %t45 = alloca [0 x %NativeFunction]
  %t46 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t45, i32 0, i32 0
  %t47 = alloca { %NativeFunction*, i64 }
  %t48 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t47, i32 0, i32 0
  store %NativeFunction* %t46, %NativeFunction** %t48
  %t49 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  store { %NativeFunction*, i64 }* %t47, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t50 = alloca [0 x %NativeStructLayoutField]
  %t51 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t50, i32 0, i32 0
  %t52 = alloca { %NativeStructLayoutField*, i64 }
  %t53 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t52, i32 0, i32 0
  store %NativeStructLayoutField* %t51, %NativeStructLayoutField** %t53
  %t54 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  store { %NativeStructLayoutField*, i64 }* %t52, { %NativeStructLayoutField*, i64 }** %l11
  %t55 = sitofp i64 0 to double
  store double %t55, double* %l12
  %t56 = sitofp i64 0 to double
  store double %t56, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %start_index, %t57
  store double %t58, double* %l16
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load i8*, i8** %l2
  %t62 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t63 = load i8*, i8** %l4
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t65 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t66 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t67 = load i8*, i8** %l8
  %t68 = load i8*, i8** %l9
  %t69 = load i8*, i8** %l10
  %t70 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t71 = load double, double* %l12
  %t72 = load double, double* %l13
  %t73 = load i1, i1* %l14
  %t74 = load i1, i1* %l15
  %t75 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t949 = phi { i8**, i64 }* [ %t59, %entry ], [ %t938, %loop.latch4 ]
  %t950 = phi double [ %t75, %entry ], [ %t939, %loop.latch4 ]
  %t951 = phi { %NativeFunction*, i64 }* [ %t66, %entry ], [ %t940, %loop.latch4 ]
  %t952 = phi i8* [ %t67, %entry ], [ %t941, %loop.latch4 ]
  %t953 = phi i8* [ %t68, %entry ], [ %t942, %loop.latch4 ]
  %t954 = phi i8* [ %t69, %entry ], [ %t943, %loop.latch4 ]
  %t955 = phi double [ %t71, %entry ], [ %t944, %loop.latch4 ]
  %t956 = phi double [ %t72, %entry ], [ %t945, %loop.latch4 ]
  %t957 = phi i1 [ %t73, %entry ], [ %t946, %loop.latch4 ]
  %t958 = phi { %NativeStructLayoutField*, i64 }* [ %t70, %entry ], [ %t947, %loop.latch4 ]
  %t959 = phi i1 [ %t74, %entry ], [ %t948, %loop.latch4 ]
  store { i8**, i64 }* %t949, { i8**, i64 }** %l0
  store double %t950, double* %l16
  store { %NativeFunction*, i64 }* %t951, { %NativeFunction*, i64 }** %l7
  store i8* %t952, i8** %l8
  store i8* %t953, i8** %l9
  store i8* %t954, i8** %l10
  store double %t955, double* %l12
  store double %t956, double* %l13
  store i1 %t957, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t958, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t959, i1* %l15
  br label %loop.body3
loop.body3:
  %t76 = load double, double* %l16
  %t77 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t78 = extractvalue { i8**, i64 } %t77, 1
  %t79 = sitofp i64 %t78 to double
  %t80 = fcmp oge double %t76, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load i8*, i8** %l2
  %t84 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t85 = load i8*, i8** %l4
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t87 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t88 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t89 = load i8*, i8** %l8
  %t90 = load i8*, i8** %l9
  %t91 = load i8*, i8** %l10
  %t92 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t93 = load double, double* %l12
  %t94 = load double, double* %l13
  %t95 = load i1, i1* %l14
  %t96 = load i1, i1* %l15
  %t97 = load double, double* %l16
  br i1 %t80, label %then6, label %merge7
then6:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s99 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.99, i32 0, i32 0
  %t100 = load i8*, i8** %l4
  %t101 = add i8* %s99, %t100
  %t102 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t98, i8* %t101)
  store { i8**, i64 }* %t102, { i8**, i64 }** %l0
  store i8* null, i8** %l17
  %t103 = load i1, i1* %l14
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load i8*, i8** %l2
  %t107 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t108 = load i8*, i8** %l4
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t110 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t111 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t112 = load i8*, i8** %l8
  %t113 = load i8*, i8** %l9
  %t114 = load i8*, i8** %l10
  %t115 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t116 = load double, double* %l12
  %t117 = load double, double* %l13
  %t118 = load i1, i1* %l14
  %t119 = load i1, i1* %l15
  %t120 = load double, double* %l16
  %t121 = load i8*, i8** %l17
  br i1 %t103, label %then8, label %merge9
then8:
  %t122 = load double, double* %l12
  %t123 = insertvalue %NativeStructLayout undef, double %t122, 0
  %t124 = load double, double* %l13
  %t125 = insertvalue %NativeStructLayout %t123, double %t124, 1
  %t126 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t127 = bitcast { %NativeStructLayoutField*, i64 }* %t126 to { i8**, i64 }*
  %t128 = insertvalue %NativeStructLayout %t125, { i8**, i64 }* %t127, 2
  store i8* null, i8** %l17
  br label %merge9
merge9:
  %t129 = phi i8* [ null, %then8 ], [ %t121, %then6 ]
  store i8* %t129, i8** %l17
  %t130 = load i8*, i8** %l4
  %t131 = insertvalue %NativeStruct undef, i8* %t130, 0
  %t132 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t133 = bitcast { %NativeStructField*, i64 }* %t132 to { i8**, i64 }*
  %t134 = insertvalue %NativeStruct %t131, { i8**, i64 }* %t133, 1
  %t135 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t136 = bitcast { %NativeFunction*, i64 }* %t135 to { i8**, i64 }*
  %t137 = insertvalue %NativeStruct %t134, { i8**, i64 }* %t136, 2
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t139 = insertvalue %NativeStruct %t137, { i8**, i64 }* %t138, 3
  %t140 = load i8*, i8** %l17
  %t141 = insertvalue %NativeStruct %t139, i8* %t140, 4
  %t142 = insertvalue %StructParseResult undef, i8* null, 0
  %t143 = load double, double* %l16
  %t144 = insertvalue %StructParseResult %t142, double %t143, 1
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = insertvalue %StructParseResult %t144, { i8**, i64 }* %t145, 2
  ret %StructParseResult %t146
merge7:
  %t147 = load double, double* %l16
  %t148 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t149 = extractvalue { i8**, i64 } %t148, 0
  %t150 = extractvalue { i8**, i64 } %t148, 1
  %t151 = icmp uge i64 %t147, %t150
  ; bounds check: %t151 (if true, out of bounds)
  %t152 = getelementptr i8*, i8** %t149, i64 %t147
  %t153 = load i8*, i8** %t152
  %t154 = call i8* @trim_text(i8* %t153)
  store i8* %t154, i8** %l18
  %t156 = load i8*, i8** %l18
  %t157 = call i64 @sailfin_runtime_string_length(i8* %t156)
  %t158 = icmp eq i64 %t157, 0
  br label %logical_or_entry_155

logical_or_entry_155:
  br i1 %t158, label %logical_or_merge_155, label %logical_or_right_155

logical_or_right_155:
  %t159 = load i8*, i8** %l18
  %t160 = call i1 @starts_with(i8* %t159, i8* null)
  br label %logical_or_right_end_155

logical_or_right_end_155:
  br label %logical_or_merge_155

logical_or_merge_155:
  %t161 = phi i1 [ true, %logical_or_entry_155 ], [ %t160, %logical_or_right_end_155 ]
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load i8*, i8** %l1
  %t164 = load i8*, i8** %l2
  %t165 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t166 = load i8*, i8** %l4
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t168 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t169 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t170 = load i8*, i8** %l8
  %t171 = load i8*, i8** %l9
  %t172 = load i8*, i8** %l10
  %t173 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t174 = load double, double* %l12
  %t175 = load double, double* %l13
  %t176 = load i1, i1* %l14
  %t177 = load i1, i1* %l15
  %t178 = load double, double* %l16
  %t179 = load i8*, i8** %l18
  br i1 %t161, label %then10, label %merge11
then10:
  %t180 = load double, double* %l16
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l16
  br label %loop.latch4
merge11:
  %t183 = load i8*, i8** %l18
  %s184 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.184, i32 0, i32 0
  %t185 = icmp eq i8* %t183, %s184
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = load i8*, i8** %l1
  %t188 = load i8*, i8** %l2
  %t189 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t190 = load i8*, i8** %l4
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t192 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t193 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t194 = load i8*, i8** %l8
  %t195 = load i8*, i8** %l9
  %t196 = load i8*, i8** %l10
  %t197 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t198 = load double, double* %l12
  %t199 = load double, double* %l13
  %t200 = load i1, i1* %l14
  %t201 = load i1, i1* %l15
  %t202 = load double, double* %l16
  %t203 = load i8*, i8** %l18
  br i1 %t185, label %then12, label %merge13
then12:
  %t204 = load i8*, i8** %l8
  %t205 = icmp ne i8* %t204, null
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t207 = load i8*, i8** %l1
  %t208 = load i8*, i8** %l2
  %t209 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t210 = load i8*, i8** %l4
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t212 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t213 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t214 = load i8*, i8** %l8
  %t215 = load i8*, i8** %l9
  %t216 = load i8*, i8** %l10
  %t217 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t218 = load double, double* %l12
  %t219 = load double, double* %l13
  %t220 = load i1, i1* %l14
  %t221 = load i1, i1* %l15
  %t222 = load double, double* %l16
  %t223 = load i8*, i8** %l18
  br i1 %t205, label %then14, label %merge15
then14:
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s225 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.225, i32 0, i32 0
  %t226 = load i8*, i8** %l4
  %t227 = add i8* %s225, %t226
  %t228 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t224, i8* %t227)
  store { i8**, i64 }* %t228, { i8**, i64 }** %l0
  %t229 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t230 = load i8*, i8** %l8
  %t231 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t229, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t231, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  br label %merge15
merge15:
  %t232 = phi { i8**, i64 }* [ %t228, %then14 ], [ %t206, %then12 ]
  %t233 = phi { %NativeFunction*, i64 }* [ %t231, %then14 ], [ %t213, %then12 ]
  %t234 = phi i8* [ null, %then14 ], [ %t214, %then12 ]
  %t235 = phi i8* [ null, %then14 ], [ %t215, %then12 ]
  %t236 = phi i8* [ null, %then14 ], [ %t216, %then12 ]
  store { i8**, i64 }* %t232, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t233, { %NativeFunction*, i64 }** %l7
  store i8* %t234, i8** %l8
  store i8* %t235, i8** %l9
  store i8* %t236, i8** %l10
  %t237 = load double, double* %l16
  %t238 = sitofp i64 1 to double
  %t239 = fadd double %t237, %t238
  store double %t239, double* %l16
  br label %afterloop5
merge13:
  %t240 = load i8*, i8** %l8
  %t241 = icmp ne i8* %t240, null
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load i8*, i8** %l1
  %t244 = load i8*, i8** %l2
  %t245 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t246 = load i8*, i8** %l4
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t248 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t249 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t250 = load i8*, i8** %l8
  %t251 = load i8*, i8** %l9
  %t252 = load i8*, i8** %l10
  %t253 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t254 = load double, double* %l12
  %t255 = load double, double* %l13
  %t256 = load i1, i1* %l14
  %t257 = load i1, i1* %l15
  %t258 = load double, double* %l16
  %t259 = load i8*, i8** %l18
  br i1 %t241, label %then16, label %merge17
then16:
  %t260 = load i8*, i8** %l18
  %s261 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.261, i32 0, i32 0
  %t262 = icmp eq i8* %t260, %s261
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t264 = load i8*, i8** %l1
  %t265 = load i8*, i8** %l2
  %t266 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t267 = load i8*, i8** %l4
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t269 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t270 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t271 = load i8*, i8** %l8
  %t272 = load i8*, i8** %l9
  %t273 = load i8*, i8** %l10
  %t274 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t275 = load double, double* %l12
  %t276 = load double, double* %l13
  %t277 = load i1, i1* %l14
  %t278 = load i1, i1* %l15
  %t279 = load double, double* %l16
  %t280 = load i8*, i8** %l18
  br i1 %t262, label %then18, label %merge19
then18:
  %t281 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t282 = load i8*, i8** %l8
  %t283 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t281, %NativeFunction zeroinitializer)
  store { %NativeFunction*, i64 }* %t283, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t284 = load double, double* %l16
  %t285 = sitofp i64 1 to double
  %t286 = fadd double %t284, %t285
  store double %t286, double* %l16
  br label %loop.latch4
merge19:
  %t287 = load i8*, i8** %l18
  %s288 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.288, i32 0, i32 0
  %t289 = call i1 @starts_with(i8* %t287, i8* %s288)
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load i8*, i8** %l1
  %t292 = load i8*, i8** %l2
  %t293 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t294 = load i8*, i8** %l4
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t296 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t297 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t298 = load i8*, i8** %l8
  %t299 = load i8*, i8** %l9
  %t300 = load i8*, i8** %l10
  %t301 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t302 = load double, double* %l12
  %t303 = load double, double* %l13
  %t304 = load i1, i1* %l14
  %t305 = load i1, i1* %l15
  %t306 = load double, double* %l16
  %t307 = load i8*, i8** %l18
  br i1 %t289, label %then20, label %merge21
then20:
  %t308 = load i8*, i8** %l8
  %t309 = load i8*, i8** %l18
  %s310 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.310, i32 0, i32 0
  %t311 = call i8* @strip_prefix(i8* %t309, i8* %s310)
  %t312 = call %NativeFunction @apply_meta(%NativeFunction zeroinitializer, i8* %t311)
  store i8* null, i8** %l8
  %t313 = load double, double* %l16
  %t314 = sitofp i64 1 to double
  %t315 = fadd double %t313, %t314
  store double %t315, double* %l16
  br label %loop.latch4
merge21:
  %t316 = load i8*, i8** %l18
  %s317 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.317, i32 0, i32 0
  %t318 = call i1 @starts_with(i8* %t316, i8* %s317)
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t320 = load i8*, i8** %l1
  %t321 = load i8*, i8** %l2
  %t322 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t323 = load i8*, i8** %l4
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t325 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t326 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t327 = load i8*, i8** %l8
  %t328 = load i8*, i8** %l9
  %t329 = load i8*, i8** %l10
  %t330 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t331 = load double, double* %l12
  %t332 = load double, double* %l13
  %t333 = load i1, i1* %l14
  %t334 = load i1, i1* %l15
  %t335 = load double, double* %l16
  %t336 = load i8*, i8** %l18
  br i1 %t318, label %then22, label %merge23
then22:
  %t337 = load i8*, i8** %l18
  %s338 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.338, i32 0, i32 0
  %t339 = call i8* @strip_prefix(i8* %t337, i8* %s338)
  %t340 = load i8*, i8** %l9
  %t341 = call double @parse_parameter_entry(i8* %t339, i8* %t340)
  store double %t341, double* %l19
  %t342 = load double, double* %l19
  store i8* null, i8** %l9
  %t343 = load double, double* %l16
  %t344 = sitofp i64 1 to double
  %t345 = fadd double %t343, %t344
  store double %t345, double* %l16
  br label %loop.latch4
merge23:
  %t346 = load i8*, i8** %l18
  %s347 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.347, i32 0, i32 0
  %t348 = call i1 @starts_with(i8* %t346, i8* %s347)
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t350 = load i8*, i8** %l1
  %t351 = load i8*, i8** %l2
  %t352 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t353 = load i8*, i8** %l4
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t355 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t356 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t357 = load i8*, i8** %l8
  %t358 = load i8*, i8** %l9
  %t359 = load i8*, i8** %l10
  %t360 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t361 = load double, double* %l12
  %t362 = load double, double* %l13
  %t363 = load i1, i1* %l14
  %t364 = load i1, i1* %l15
  %t365 = load double, double* %l16
  %t366 = load i8*, i8** %l18
  br i1 %t348, label %then24, label %merge25
then24:
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s368 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.368, i32 0, i32 0
  %t369 = load i8*, i8** %l4
  %t370 = add i8* %s368, %t369
  %t371 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t367, i8* %t370)
  store { i8**, i64 }* %t371, { i8**, i64 }** %l0
  %t372 = load double, double* %l16
  %t373 = sitofp i64 1 to double
  %t374 = fadd double %t372, %t373
  store double %t374, double* %l16
  br label %loop.latch4
merge25:
  %t375 = load i8*, i8** %l18
  %s376 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.376, i32 0, i32 0
  %t377 = call i1 @starts_with(i8* %t375, i8* %s376)
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t379 = load i8*, i8** %l1
  %t380 = load i8*, i8** %l2
  %t381 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t382 = load i8*, i8** %l4
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t384 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t385 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t386 = load i8*, i8** %l8
  %t387 = load i8*, i8** %l9
  %t388 = load i8*, i8** %l10
  %t389 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t390 = load double, double* %l12
  %t391 = load double, double* %l13
  %t392 = load i1, i1* %l14
  %t393 = load i1, i1* %l15
  %t394 = load double, double* %l16
  %t395 = load i8*, i8** %l18
  br i1 %t377, label %then26, label %merge27
then26:
  %t396 = load i8*, i8** %l18
  %s397 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.397, i32 0, i32 0
  %t398 = call i8* @strip_prefix(i8* %t396, i8* %s397)
  %t399 = call double @parse_source_span(i8* %t398)
  store double %t399, double* %l20
  %t400 = load double, double* %l20
  %t401 = load double, double* %l16
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  store double %t403, double* %l16
  br label %loop.latch4
merge27:
  %t404 = load i8*, i8** %l18
  %t405 = load i8*, i8** %l18
  %t406 = load i8*, i8** %l9
  %t407 = load i8*, i8** %l10
  %t408 = call %InstructionParseResult @parse_instruction(i8* %t405, i8* %t406, i8* %t407)
  store %InstructionParseResult %t408, %InstructionParseResult* %l21
  %t409 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t410 = extractvalue %InstructionParseResult %t409, 1
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t412 = load i8*, i8** %l1
  %t413 = load i8*, i8** %l2
  %t414 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t415 = load i8*, i8** %l4
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t417 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t418 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t419 = load i8*, i8** %l8
  %t420 = load i8*, i8** %l9
  %t421 = load i8*, i8** %l10
  %t422 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t423 = load double, double* %l12
  %t424 = load double, double* %l13
  %t425 = load i1, i1* %l14
  %t426 = load i1, i1* %l15
  %t427 = load double, double* %l16
  %t428 = load i8*, i8** %l18
  %t429 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t410, label %then28, label %else29
then28:
  store i8* null, i8** %l9
  br label %merge30
else29:
  %t430 = load i8*, i8** %l9
  %t431 = icmp ne i8* %t430, null
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load i8*, i8** %l1
  %t434 = load i8*, i8** %l2
  %t435 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t436 = load i8*, i8** %l4
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t438 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t439 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t440 = load i8*, i8** %l8
  %t441 = load i8*, i8** %l9
  %t442 = load i8*, i8** %l10
  %t443 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t444 = load double, double* %l12
  %t445 = load double, double* %l13
  %t446 = load i1, i1* %l14
  %t447 = load i1, i1* %l15
  %t448 = load double, double* %l16
  %t449 = load i8*, i8** %l18
  %t450 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t431, label %then31, label %merge32
then31:
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s452 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.452, i32 0, i32 0
  %t453 = load i8*, i8** %l18
  %t454 = add i8* %s452, %t453
  %t455 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t451, i8* %t454)
  store { i8**, i64 }* %t455, { i8**, i64 }** %l0
  store i8* null, i8** %l9
  br label %merge32
merge32:
  %t456 = phi { i8**, i64 }* [ %t455, %then31 ], [ %t432, %else29 ]
  %t457 = phi i8* [ null, %then31 ], [ %t441, %else29 ]
  store { i8**, i64 }* %t456, { i8**, i64 }** %l0
  store i8* %t457, i8** %l9
  br label %merge30
merge30:
  %t458 = phi i8* [ null, %then28 ], [ null, %else29 ]
  %t459 = phi { i8**, i64 }* [ %t411, %then28 ], [ %t455, %else29 ]
  store i8* %t458, i8** %l9
  store { i8**, i64 }* %t459, { i8**, i64 }** %l0
  %t460 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t461 = extractvalue %InstructionParseResult %t460, 2
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t463 = load i8*, i8** %l1
  %t464 = load i8*, i8** %l2
  %t465 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t466 = load i8*, i8** %l4
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t468 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t469 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t470 = load i8*, i8** %l8
  %t471 = load i8*, i8** %l9
  %t472 = load i8*, i8** %l10
  %t473 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t474 = load double, double* %l12
  %t475 = load double, double* %l13
  %t476 = load i1, i1* %l14
  %t477 = load i1, i1* %l15
  %t478 = load double, double* %l16
  %t479 = load i8*, i8** %l18
  %t480 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t461, label %then33, label %else34
then33:
  store i8* null, i8** %l10
  br label %merge35
else34:
  %t481 = load i8*, i8** %l10
  %t482 = icmp ne i8* %t481, null
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t484 = load i8*, i8** %l1
  %t485 = load i8*, i8** %l2
  %t486 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t487 = load i8*, i8** %l4
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t489 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t490 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t491 = load i8*, i8** %l8
  %t492 = load i8*, i8** %l9
  %t493 = load i8*, i8** %l10
  %t494 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t495 = load double, double* %l12
  %t496 = load double, double* %l13
  %t497 = load i1, i1* %l14
  %t498 = load i1, i1* %l15
  %t499 = load double, double* %l16
  %t500 = load i8*, i8** %l18
  %t501 = load %InstructionParseResult, %InstructionParseResult* %l21
  br i1 %t482, label %then36, label %merge37
then36:
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s503 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.503, i32 0, i32 0
  %t504 = load i8*, i8** %l18
  %t505 = add i8* %s503, %t504
  %t506 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t502, i8* %t505)
  store { i8**, i64 }* %t506, { i8**, i64 }** %l0
  store i8* null, i8** %l10
  br label %merge37
merge37:
  %t507 = phi { i8**, i64 }* [ %t506, %then36 ], [ %t483, %else34 ]
  %t508 = phi i8* [ null, %then36 ], [ %t493, %else34 ]
  store { i8**, i64 }* %t507, { i8**, i64 }** %l0
  store i8* %t508, i8** %l10
  br label %merge35
merge35:
  %t509 = phi i8* [ null, %then33 ], [ null, %else34 ]
  %t510 = phi { i8**, i64 }* [ %t462, %then33 ], [ %t506, %else34 ]
  store i8* %t509, i8** %l10
  store { i8**, i64 }* %t510, { i8**, i64 }** %l0
  %t511 = sitofp i64 0 to double
  store double %t511, double* %l22
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t513 = load i8*, i8** %l1
  %t514 = load i8*, i8** %l2
  %t515 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t516 = load i8*, i8** %l4
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t518 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t519 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t520 = load i8*, i8** %l8
  %t521 = load i8*, i8** %l9
  %t522 = load i8*, i8** %l10
  %t523 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t524 = load double, double* %l12
  %t525 = load double, double* %l13
  %t526 = load i1, i1* %l14
  %t527 = load i1, i1* %l15
  %t528 = load double, double* %l16
  %t529 = load i8*, i8** %l18
  %t530 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t531 = load double, double* %l22
  br label %loop.header38
loop.header38:
  %t575 = phi i8* [ %t520, %then16 ], [ %t573, %loop.latch40 ]
  %t576 = phi double [ %t531, %then16 ], [ %t574, %loop.latch40 ]
  store i8* %t575, i8** %l8
  store double %t576, double* %l22
  br label %loop.body39
loop.body39:
  %t532 = load double, double* %l22
  %t533 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t534 = extractvalue %InstructionParseResult %t533, 0
  %t535 = load { i8**, i64 }, { i8**, i64 }* %t534
  %t536 = extractvalue { i8**, i64 } %t535, 1
  %t537 = sitofp i64 %t536 to double
  %t538 = fcmp oge double %t532, %t537
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t540 = load i8*, i8** %l1
  %t541 = load i8*, i8** %l2
  %t542 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t543 = load i8*, i8** %l4
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t545 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t546 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t547 = load i8*, i8** %l8
  %t548 = load i8*, i8** %l9
  %t549 = load i8*, i8** %l10
  %t550 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t551 = load double, double* %l12
  %t552 = load double, double* %l13
  %t553 = load i1, i1* %l14
  %t554 = load i1, i1* %l15
  %t555 = load double, double* %l16
  %t556 = load i8*, i8** %l18
  %t557 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t558 = load double, double* %l22
  br i1 %t538, label %then42, label %merge43
then42:
  br label %afterloop41
merge43:
  %t559 = load i8*, i8** %l8
  %t560 = load %InstructionParseResult, %InstructionParseResult* %l21
  %t561 = extractvalue %InstructionParseResult %t560, 0
  %t562 = load double, double* %l22
  %t563 = load { i8**, i64 }, { i8**, i64 }* %t561
  %t564 = extractvalue { i8**, i64 } %t563, 0
  %t565 = extractvalue { i8**, i64 } %t563, 1
  %t566 = icmp uge i64 %t562, %t565
  ; bounds check: %t566 (if true, out of bounds)
  %t567 = getelementptr i8*, i8** %t564, i64 %t562
  %t568 = load i8*, i8** %t567
  %t569 = call %NativeFunction @append_instruction(%NativeFunction zeroinitializer, %NativeInstruction zeroinitializer)
  store i8* null, i8** %l8
  %t570 = load double, double* %l22
  %t571 = sitofp i64 1 to double
  %t572 = fadd double %t570, %t571
  store double %t572, double* %l22
  br label %loop.latch40
loop.latch40:
  %t573 = load i8*, i8** %l8
  %t574 = load double, double* %l22
  br label %loop.header38
afterloop41:
  %t577 = load double, double* %l16
  %t578 = sitofp i64 1 to double
  %t579 = fadd double %t577, %t578
  store double %t579, double* %l16
  br label %loop.latch4
merge17:
  %t580 = load i8*, i8** %l18
  %s581 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.581, i32 0, i32 0
  %t582 = call i1 @starts_with(i8* %t580, i8* %s581)
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t584 = load i8*, i8** %l1
  %t585 = load i8*, i8** %l2
  %t586 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t587 = load i8*, i8** %l4
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t589 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t590 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t591 = load i8*, i8** %l8
  %t592 = load i8*, i8** %l9
  %t593 = load i8*, i8** %l10
  %t594 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t595 = load double, double* %l12
  %t596 = load double, double* %l13
  %t597 = load i1, i1* %l14
  %t598 = load i1, i1* %l15
  %t599 = load double, double* %l16
  %t600 = load i8*, i8** %l18
  br i1 %t582, label %then44, label %merge45
then44:
  %t601 = load i8*, i8** %l18
  %s602 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.602, i32 0, i32 0
  %t603 = call i8* @strip_prefix(i8* %t601, i8* %s602)
  store i8* %t603, i8** %l23
  %t604 = load i8*, i8** %l23
  %s605 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.605, i32 0, i32 0
  %t606 = call i1 @starts_with(i8* %t604, i8* %s605)
  %t607 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t608 = load i8*, i8** %l1
  %t609 = load i8*, i8** %l2
  %t610 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t611 = load i8*, i8** %l4
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t613 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t614 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t615 = load i8*, i8** %l8
  %t616 = load i8*, i8** %l9
  %t617 = load i8*, i8** %l10
  %t618 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t619 = load double, double* %l12
  %t620 = load double, double* %l13
  %t621 = load i1, i1* %l14
  %t622 = load i1, i1* %l15
  %t623 = load double, double* %l16
  %t624 = load i8*, i8** %l18
  %t625 = load i8*, i8** %l23
  br i1 %t606, label %then46, label %merge47
then46:
  %t626 = load i8*, i8** %l23
  %s627 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.627, i32 0, i32 0
  %t628 = call i8* @strip_prefix(i8* %t626, i8* %s627)
  %t629 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t628)
  store %StructLayoutHeaderParse %t629, %StructLayoutHeaderParse* %l24
  %t630 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t631 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t632 = extractvalue %StructLayoutHeaderParse %t631, 4
  %t633 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t630, { i8**, i64 }* %t632)
  store { i8**, i64 }* %t633, { i8**, i64 }** %l0
  %t634 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t635 = extractvalue %StructLayoutHeaderParse %t634, 0
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t637 = load i8*, i8** %l1
  %t638 = load i8*, i8** %l2
  %t639 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t640 = load i8*, i8** %l4
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t642 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t643 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t644 = load i8*, i8** %l8
  %t645 = load i8*, i8** %l9
  %t646 = load i8*, i8** %l10
  %t647 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t648 = load double, double* %l12
  %t649 = load double, double* %l13
  %t650 = load i1, i1* %l14
  %t651 = load i1, i1* %l15
  %t652 = load double, double* %l16
  %t653 = load i8*, i8** %l18
  %t654 = load i8*, i8** %l23
  %t655 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t635, label %then48, label %merge49
then48:
  %t656 = load i1, i1* %l14
  %t657 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t658 = load i8*, i8** %l1
  %t659 = load i8*, i8** %l2
  %t660 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t661 = load i8*, i8** %l4
  %t662 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t663 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t664 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t665 = load i8*, i8** %l8
  %t666 = load i8*, i8** %l9
  %t667 = load i8*, i8** %l10
  %t668 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t669 = load double, double* %l12
  %t670 = load double, double* %l13
  %t671 = load i1, i1* %l14
  %t672 = load i1, i1* %l15
  %t673 = load double, double* %l16
  %t674 = load i8*, i8** %l18
  %t675 = load i8*, i8** %l23
  %t676 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  br i1 %t656, label %then50, label %else51
then50:
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s678 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.678, i32 0, i32 0
  %t679 = load i8*, i8** %l4
  %t680 = add i8* %s678, %t679
  %t681 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t677, i8* %t680)
  store { i8**, i64 }* %t681, { i8**, i64 }** %l0
  br label %merge52
else51:
  %t682 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t683 = extractvalue %StructLayoutHeaderParse %t682, 2
  store double %t683, double* %l12
  %t684 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l24
  %t685 = extractvalue %StructLayoutHeaderParse %t684, 3
  store double %t685, double* %l13
  store i1 1, i1* %l14
  br label %merge52
merge52:
  %t686 = phi { i8**, i64 }* [ %t681, %then50 ], [ %t657, %else51 ]
  %t687 = phi double [ %t669, %then50 ], [ %t683, %else51 ]
  %t688 = phi double [ %t670, %then50 ], [ %t685, %else51 ]
  %t689 = phi i1 [ %t671, %then50 ], [ 1, %else51 ]
  store { i8**, i64 }* %t686, { i8**, i64 }** %l0
  store double %t687, double* %l12
  store double %t688, double* %l13
  store i1 %t689, i1* %l14
  br label %merge49
merge49:
  %t690 = phi { i8**, i64 }* [ %t681, %then48 ], [ %t636, %then46 ]
  %t691 = phi double [ %t683, %then48 ], [ %t648, %then46 ]
  %t692 = phi double [ %t685, %then48 ], [ %t649, %then46 ]
  %t693 = phi i1 [ 1, %then48 ], [ %t650, %then46 ]
  store { i8**, i64 }* %t690, { i8**, i64 }** %l0
  store double %t691, double* %l12
  store double %t692, double* %l13
  store i1 %t693, i1* %l14
  %t694 = load double, double* %l16
  %t695 = sitofp i64 1 to double
  %t696 = fadd double %t694, %t695
  store double %t696, double* %l16
  br label %loop.latch4
merge47:
  %t697 = load i8*, i8** %l23
  %s698 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.698, i32 0, i32 0
  %t699 = call i1 @starts_with(i8* %t697, i8* %s698)
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t701 = load i8*, i8** %l1
  %t702 = load i8*, i8** %l2
  %t703 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t704 = load i8*, i8** %l4
  %t705 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t706 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t707 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t708 = load i8*, i8** %l8
  %t709 = load i8*, i8** %l9
  %t710 = load i8*, i8** %l10
  %t711 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t712 = load double, double* %l12
  %t713 = load double, double* %l13
  %t714 = load i1, i1* %l14
  %t715 = load i1, i1* %l15
  %t716 = load double, double* %l16
  %t717 = load i8*, i8** %l18
  %t718 = load i8*, i8** %l23
  br i1 %t699, label %then53, label %merge54
then53:
  %t719 = load i8*, i8** %l23
  %s720 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.720, i32 0, i32 0
  %t721 = call i8* @strip_prefix(i8* %t719, i8* %s720)
  %t722 = load i8*, i8** %l4
  %t723 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t721, i8* %t722)
  store %StructLayoutFieldParse %t723, %StructLayoutFieldParse* %l25
  %t724 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t725 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t726 = extractvalue %StructLayoutFieldParse %t725, 2
  %t727 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t724, { i8**, i64 }* %t726)
  store { i8**, i64 }* %t727, { i8**, i64 }** %l0
  %t728 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t729 = extractvalue %StructLayoutFieldParse %t728, 0
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t731 = load i8*, i8** %l1
  %t732 = load i8*, i8** %l2
  %t733 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t734 = load i8*, i8** %l4
  %t735 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t736 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t737 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t738 = load i8*, i8** %l8
  %t739 = load i8*, i8** %l9
  %t740 = load i8*, i8** %l10
  %t741 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t742 = load double, double* %l12
  %t743 = load double, double* %l13
  %t744 = load i1, i1* %l14
  %t745 = load i1, i1* %l15
  %t746 = load double, double* %l16
  %t747 = load i8*, i8** %l18
  %t748 = load i8*, i8** %l23
  %t749 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t729, label %then55, label %merge56
then55:
  %t750 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t751 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  %t752 = extractvalue %StructLayoutFieldParse %t751, 1
  %t753 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t750, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t753, { %NativeStructLayoutField*, i64 }** %l11
  %t754 = load i1, i1* %l14
  %t755 = xor i1 %t754, 1
  %t756 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t757 = load i8*, i8** %l1
  %t758 = load i8*, i8** %l2
  %t759 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t760 = load i8*, i8** %l4
  %t761 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t762 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t763 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t764 = load i8*, i8** %l8
  %t765 = load i8*, i8** %l9
  %t766 = load i8*, i8** %l10
  %t767 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t768 = load double, double* %l12
  %t769 = load double, double* %l13
  %t770 = load i1, i1* %l14
  %t771 = load i1, i1* %l15
  %t772 = load double, double* %l16
  %t773 = load i8*, i8** %l18
  %t774 = load i8*, i8** %l23
  %t775 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t755, label %then57, label %merge58
then57:
  %t776 = load i1, i1* %l15
  %t777 = xor i1 %t776, 1
  %t778 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t779 = load i8*, i8** %l1
  %t780 = load i8*, i8** %l2
  %t781 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t782 = load i8*, i8** %l4
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t784 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t785 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t786 = load i8*, i8** %l8
  %t787 = load i8*, i8** %l9
  %t788 = load i8*, i8** %l10
  %t789 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t790 = load double, double* %l12
  %t791 = load double, double* %l13
  %t792 = load i1, i1* %l14
  %t793 = load i1, i1* %l15
  %t794 = load double, double* %l16
  %t795 = load i8*, i8** %l18
  %t796 = load i8*, i8** %l23
  %t797 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l25
  br i1 %t777, label %then59, label %merge60
then59:
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s799 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.799, i32 0, i32 0
  %t800 = load i8*, i8** %l4
  %t801 = add i8* %s799, %t800
  %s802 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.802, i32 0, i32 0
  %t803 = add i8* %t801, %s802
  %t804 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t798, i8* %t803)
  store { i8**, i64 }* %t804, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge60
merge60:
  %t805 = phi { i8**, i64 }* [ %t804, %then59 ], [ %t778, %then57 ]
  %t806 = phi i1 [ 1, %then59 ], [ %t793, %then57 ]
  store { i8**, i64 }* %t805, { i8**, i64 }** %l0
  store i1 %t806, i1* %l15
  br label %merge58
merge58:
  %t807 = phi { i8**, i64 }* [ %t804, %then57 ], [ %t756, %then55 ]
  %t808 = phi i1 [ 1, %then57 ], [ %t771, %then55 ]
  store { i8**, i64 }* %t807, { i8**, i64 }** %l0
  store i1 %t808, i1* %l15
  br label %merge56
merge56:
  %t809 = phi { %NativeStructLayoutField*, i64 }* [ %t753, %then55 ], [ %t741, %then53 ]
  %t810 = phi { i8**, i64 }* [ %t804, %then55 ], [ %t730, %then53 ]
  %t811 = phi i1 [ 1, %then55 ], [ %t745, %then53 ]
  store { %NativeStructLayoutField*, i64 }* %t809, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t810, { i8**, i64 }** %l0
  store i1 %t811, i1* %l15
  %t812 = load double, double* %l16
  %t813 = sitofp i64 1 to double
  %t814 = fadd double %t812, %t813
  store double %t814, double* %l16
  br label %loop.latch4
merge54:
  %t815 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s816 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.816, i32 0, i32 0
  %t817 = load i8*, i8** %l18
  %t818 = add i8* %s816, %t817
  %t819 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t815, i8* %t818)
  store { i8**, i64 }* %t819, { i8**, i64 }** %l0
  %t820 = load double, double* %l16
  %t821 = sitofp i64 1 to double
  %t822 = fadd double %t820, %t821
  store double %t822, double* %l16
  br label %loop.latch4
merge45:
  %t823 = load i8*, i8** %l18
  %s824 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.824, i32 0, i32 0
  %t825 = icmp eq i8* %t823, %s824
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t827 = load i8*, i8** %l1
  %t828 = load i8*, i8** %l2
  %t829 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t830 = load i8*, i8** %l4
  %t831 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t832 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t833 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t834 = load i8*, i8** %l8
  %t835 = load i8*, i8** %l9
  %t836 = load i8*, i8** %l10
  %t837 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t838 = load double, double* %l12
  %t839 = load double, double* %l13
  %t840 = load i1, i1* %l14
  %t841 = load i1, i1* %l15
  %t842 = load double, double* %l16
  %t843 = load i8*, i8** %l18
  br i1 %t825, label %then61, label %merge62
then61:
  %t844 = load double, double* %l16
  %t845 = sitofp i64 1 to double
  %t846 = fadd double %t844, %t845
  store double %t846, double* %l16
  br label %loop.latch4
merge62:
  %t847 = load i8*, i8** %l18
  %s848 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.848, i32 0, i32 0
  %t849 = call i1 @starts_with(i8* %t847, i8* %s848)
  %t850 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t851 = load i8*, i8** %l1
  %t852 = load i8*, i8** %l2
  %t853 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t854 = load i8*, i8** %l4
  %t855 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t856 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t857 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t858 = load i8*, i8** %l8
  %t859 = load i8*, i8** %l9
  %t860 = load i8*, i8** %l10
  %t861 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t862 = load double, double* %l12
  %t863 = load double, double* %l13
  %t864 = load i1, i1* %l14
  %t865 = load i1, i1* %l15
  %t866 = load double, double* %l16
  %t867 = load i8*, i8** %l18
  br i1 %t849, label %then63, label %merge64
then63:
  %t868 = load i8*, i8** %l18
  %s869 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.869, i32 0, i32 0
  %t870 = call i8* @strip_prefix(i8* %t868, i8* %s869)
  %t871 = call double @parse_struct_field_line(i8* %t870)
  store double %t871, double* %l26
  %t872 = load double, double* %l26
  %t873 = load double, double* %l16
  %t874 = sitofp i64 1 to double
  %t875 = fadd double %t873, %t874
  store double %t875, double* %l16
  br label %loop.latch4
merge64:
  %t876 = load i8*, i8** %l18
  %s877 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.877, i32 0, i32 0
  %t878 = call i1 @starts_with(i8* %t876, i8* %s877)
  %t879 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t880 = load i8*, i8** %l1
  %t881 = load i8*, i8** %l2
  %t882 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t883 = load i8*, i8** %l4
  %t884 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t885 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t886 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t887 = load i8*, i8** %l8
  %t888 = load i8*, i8** %l9
  %t889 = load i8*, i8** %l10
  %t890 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t891 = load double, double* %l12
  %t892 = load double, double* %l13
  %t893 = load i1, i1* %l14
  %t894 = load i1, i1* %l15
  %t895 = load double, double* %l16
  %t896 = load i8*, i8** %l18
  br i1 %t878, label %then65, label %merge66
then65:
  %t897 = load i8*, i8** %l8
  %t898 = icmp ne i8* %t897, null
  %t899 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t900 = load i8*, i8** %l1
  %t901 = load i8*, i8** %l2
  %t902 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t903 = load i8*, i8** %l4
  %t904 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t905 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t906 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t907 = load i8*, i8** %l8
  %t908 = load i8*, i8** %l9
  %t909 = load i8*, i8** %l10
  %t910 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t911 = load double, double* %l12
  %t912 = load double, double* %l13
  %t913 = load i1, i1* %l14
  %t914 = load i1, i1* %l15
  %t915 = load double, double* %l16
  %t916 = load i8*, i8** %l18
  br i1 %t898, label %then67, label %merge68
then67:
  %t917 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s918 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.918, i32 0, i32 0
  %t919 = load i8*, i8** %l4
  %t920 = add i8* %s918, %t919
  %t921 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t917, i8* %t920)
  store { i8**, i64 }* %t921, { i8**, i64 }** %l0
  br label %merge68
merge68:
  %t922 = phi { i8**, i64 }* [ %t921, %then67 ], [ %t899, %then65 ]
  store { i8**, i64 }* %t922, { i8**, i64 }** %l0
  %t923 = load i8*, i8** %l18
  %s924 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.924, i32 0, i32 0
  %t925 = call i8* @strip_prefix(i8* %t923, i8* %s924)
  %t926 = call i8* @parse_function_name(i8* %t925)
  store i8* %t926, i8** %l27
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t927 = load double, double* %l16
  %t928 = sitofp i64 1 to double
  %t929 = fadd double %t927, %t928
  store double %t929, double* %l16
  br label %loop.latch4
merge66:
  %t930 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s931 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.931, i32 0, i32 0
  %t932 = load i8*, i8** %l18
  %t933 = add i8* %s931, %t932
  %t934 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t930, i8* %t933)
  store { i8**, i64 }* %t934, { i8**, i64 }** %l0
  %t935 = load double, double* %l16
  %t936 = sitofp i64 1 to double
  %t937 = fadd double %t935, %t936
  store double %t937, double* %l16
  br label %loop.latch4
loop.latch4:
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t939 = load double, double* %l16
  %t940 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t941 = load i8*, i8** %l8
  %t942 = load i8*, i8** %l9
  %t943 = load i8*, i8** %l10
  %t944 = load double, double* %l12
  %t945 = load double, double* %l13
  %t946 = load i1, i1* %l14
  %t947 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t948 = load i1, i1* %l15
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l28
  %t960 = load i1, i1* %l14
  %t961 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t962 = load i8*, i8** %l1
  %t963 = load i8*, i8** %l2
  %t964 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t965 = load i8*, i8** %l4
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t967 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t968 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t969 = load i8*, i8** %l8
  %t970 = load i8*, i8** %l9
  %t971 = load i8*, i8** %l10
  %t972 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t973 = load double, double* %l12
  %t974 = load double, double* %l13
  %t975 = load i1, i1* %l14
  %t976 = load i1, i1* %l15
  %t977 = load double, double* %l16
  %t978 = load i8*, i8** %l28
  br i1 %t960, label %then69, label %merge70
then69:
  %t979 = load double, double* %l12
  %t980 = insertvalue %NativeStructLayout undef, double %t979, 0
  %t981 = load double, double* %l13
  %t982 = insertvalue %NativeStructLayout %t980, double %t981, 1
  %t983 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t984 = bitcast { %NativeStructLayoutField*, i64 }* %t983 to { i8**, i64 }*
  %t985 = insertvalue %NativeStructLayout %t982, { i8**, i64 }* %t984, 2
  store i8* null, i8** %l28
  br label %merge70
merge70:
  %t986 = phi i8* [ null, %then69 ], [ %t978, %entry ]
  store i8* %t986, i8** %l28
  %t987 = load i8*, i8** %l4
  %t988 = insertvalue %NativeStruct undef, i8* %t987, 0
  %t989 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t990 = bitcast { %NativeStructField*, i64 }* %t989 to { i8**, i64 }*
  %t991 = insertvalue %NativeStruct %t988, { i8**, i64 }* %t990, 1
  %t992 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t993 = bitcast { %NativeFunction*, i64 }* %t992 to { i8**, i64 }*
  %t994 = insertvalue %NativeStruct %t991, { i8**, i64 }* %t993, 2
  %t995 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t996 = insertvalue %NativeStruct %t994, { i8**, i64 }* %t995, 3
  %t997 = load i8*, i8** %l28
  %t998 = insertvalue %NativeStruct %t996, i8* %t997, 4
  %t999 = insertvalue %StructParseResult undef, i8* null, 0
  %t1000 = load double, double* %l16
  %t1001 = insertvalue %StructParseResult %t999, double %t1000, 1
  %t1002 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1003 = insertvalue %StructParseResult %t1001, { i8**, i64 }* %t1002, 2
  ret %StructParseResult %t1003
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
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = icmp eq i64 %t25, 0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t31 = load i8*, i8** %l4
  br i1 %t26, label %then0, label %merge1
then0:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s33 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.33, i32 0, i32 0
  %t34 = load i8*, i8** %l1
  %t35 = add i8* %s33, %t34
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t32, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  ret %InterfaceParseResult zeroinitializer
merge1:
  %t37 = alloca [0 x %NativeInterfaceSignature]
  %t38 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* %t37, i32 0, i32 0
  %t39 = alloca { %NativeInterfaceSignature*, i64 }
  %t40 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t39, i32 0, i32 0
  store %NativeInterfaceSignature* %t38, %NativeInterfaceSignature** %t40
  %t41 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  store { %NativeInterfaceSignature*, i64 }* %t39, { %NativeInterfaceSignature*, i64 }** %l5
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %start_index, %t42
  store double %t43, double* %l6
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i8*, i8** %l2
  %t47 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t50 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t193 = phi { i8**, i64 }* [ %t44, %entry ], [ %t190, %loop.latch4 ]
  %t194 = phi double [ %t50, %entry ], [ %t191, %loop.latch4 ]
  %t195 = phi { %NativeInterfaceSignature*, i64 }* [ %t49, %entry ], [ %t192, %loop.latch4 ]
  store { i8**, i64 }* %t193, { i8**, i64 }** %l0
  store double %t194, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t195, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t51 = load double, double* %l6
  %t52 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t53 = extractvalue { i8**, i64 } %t52, 1
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp oge double %t51, %t54
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load i8*, i8** %l2
  %t59 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t60 = load i8*, i8** %l4
  %t61 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t62 = load double, double* %l6
  br i1 %t55, label %then6, label %merge7
then6:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s64 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.64, i32 0, i32 0
  %t65 = load i8*, i8** %l4
  %t66 = add i8* %s64, %t65
  %t67 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l4
  %t69 = insertvalue %NativeInterface undef, i8* %t68, 0
  %t70 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t71 = extractvalue %InterfaceHeaderParse %t70, 1
  %t72 = insertvalue %NativeInterface %t69, { i8**, i64 }* %t71, 1
  %t73 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t74 = bitcast { %NativeInterfaceSignature*, i64 }* %t73 to { i8**, i64 }*
  %t75 = insertvalue %NativeInterface %t72, { i8**, i64 }* %t74, 2
  %t76 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t77 = load double, double* %l6
  %t78 = insertvalue %InterfaceParseResult %t76, double %t77, 1
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = insertvalue %InterfaceParseResult %t78, { i8**, i64 }* %t79, 2
  ret %InterfaceParseResult %t80
merge7:
  %t81 = load double, double* %l6
  %t82 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t83 = extractvalue { i8**, i64 } %t82, 0
  %t84 = extractvalue { i8**, i64 } %t82, 1
  %t85 = icmp uge i64 %t81, %t84
  ; bounds check: %t85 (if true, out of bounds)
  %t86 = getelementptr i8*, i8** %t83, i64 %t81
  %t87 = load i8*, i8** %t86
  %t88 = call i8* @trim_text(i8* %t87)
  store i8* %t88, i8** %l7
  %t90 = load i8*, i8** %l7
  %t91 = call i64 @sailfin_runtime_string_length(i8* %t90)
  %t92 = icmp eq i64 %t91, 0
  br label %logical_or_entry_89

logical_or_entry_89:
  br i1 %t92, label %logical_or_merge_89, label %logical_or_right_89

logical_or_right_89:
  %t93 = load i8*, i8** %l7
  %t94 = call i1 @starts_with(i8* %t93, i8* null)
  br label %logical_or_right_end_89

logical_or_right_end_89:
  br label %logical_or_merge_89

logical_or_merge_89:
  %t95 = phi i1 [ true, %logical_or_entry_89 ], [ %t94, %logical_or_right_end_89 ]
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
  br label %loop.latch4
merge9:
  %t107 = load i8*, i8** %l7
  %s108 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.108, i32 0, i32 0
  %t109 = icmp eq i8* %t107, %s108
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
  %t118 = load double, double* %l6
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l6
  br label %afterloop5
merge11:
  %t121 = load i8*, i8** %l7
  %s122 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.122, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load i8*, i8** %l2
  %t127 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t128 = load i8*, i8** %l4
  %t129 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load i8*, i8** %l7
  br i1 %t123, label %then12, label %merge13
then12:
  %t132 = load double, double* %l6
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l6
  br label %loop.latch4
merge13:
  %t135 = load i8*, i8** %l7
  %s136 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.136, i32 0, i32 0
  %t137 = call i1 @starts_with(i8* %t135, i8* %s136)
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load i8*, i8** %l1
  %t140 = load i8*, i8** %l2
  %t141 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t142 = load i8*, i8** %l4
  %t143 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t144 = load double, double* %l6
  %t145 = load i8*, i8** %l7
  br i1 %t137, label %then14, label %merge15
then14:
  %t146 = load i8*, i8** %l7
  %s147 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.147, i32 0, i32 0
  %t148 = call i8* @strip_prefix(i8* %t146, i8* %s147)
  %t149 = load i8*, i8** %l4
  %t150 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t148, i8* %t149)
  store %InterfaceSignatureParse %t150, %InterfaceSignatureParse* %l8
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t153 = extractvalue %InterfaceSignatureParse %t152, 2
  %t154 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t151, { i8**, i64 }* %t153)
  store { i8**, i64 }* %t154, { i8**, i64 }** %l0
  %t155 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t156 = extractvalue %InterfaceSignatureParse %t155, 0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load i8*, i8** %l2
  %t160 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t161 = load i8*, i8** %l4
  %t162 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t163 = load double, double* %l6
  %t164 = load i8*, i8** %l7
  %t165 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t156, label %then16, label %merge17
then16:
  %t166 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t167 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t168 = extractvalue %InterfaceSignatureParse %t167, 1
  %t169 = alloca [1 x i8*]
  %t170 = getelementptr [1 x i8*], [1 x i8*]* %t169, i32 0, i32 0
  %t171 = getelementptr i8*, i8** %t170, i64 0
  store i8* %t168, i8** %t171
  %t172 = alloca { i8**, i64 }
  %t173 = getelementptr { i8**, i64 }, { i8**, i64 }* %t172, i32 0, i32 0
  store i8** %t170, i8*** %t173
  %t174 = getelementptr { i8**, i64 }, { i8**, i64 }* %t172, i32 0, i32 1
  store i64 1, i64* %t174
  %t175 = bitcast { %NativeInterfaceSignature*, i64 }* %t166 to { i8**, i64 }*
  %t176 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t175, { i8**, i64 }* %t172)
  %t177 = bitcast { i8**, i64 }* %t176 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t177, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t178 = phi { %NativeInterfaceSignature*, i64 }* [ %t177, %then16 ], [ %t162, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t178, { %NativeInterfaceSignature*, i64 }** %l5
  %t179 = load double, double* %l6
  %t180 = sitofp i64 1 to double
  %t181 = fadd double %t179, %t180
  store double %t181, double* %l6
  br label %loop.latch4
merge15:
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s183 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.183, i32 0, i32 0
  %t184 = load i8*, i8** %l7
  %t185 = add i8* %s183, %t184
  %t186 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t182, i8* %t185)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l0
  %t187 = load double, double* %l6
  %t188 = sitofp i64 1 to double
  %t189 = fadd double %t187, %t188
  store double %t189, double* %l6
  br label %loop.latch4
loop.latch4:
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load double, double* %l6
  %t192 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t196 = load i8*, i8** %l4
  %t197 = insertvalue %NativeInterface undef, i8* %t196, 0
  %t198 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t199 = extractvalue %InterfaceHeaderParse %t198, 1
  %t200 = insertvalue %NativeInterface %t197, { i8**, i64 }* %t199, 1
  %t201 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t202 = bitcast { %NativeInterfaceSignature*, i64 }* %t201 to { i8**, i64 }*
  %t203 = insertvalue %NativeInterface %t200, { i8**, i64 }* %t202, 2
  %t204 = insertvalue %InterfaceParseResult undef, i8* null, 0
  %t205 = load double, double* %l6
  %t206 = insertvalue %InterfaceParseResult %t204, double %t205, 1
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = insertvalue %InterfaceParseResult %t206, { i8**, i64 }* %t207, 2
  ret %InterfaceParseResult %t208
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
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca double
  %l22 = alloca i1
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
  %t8 = call i64 @sailfin_runtime_string_length(i8* %t7)
  %t9 = icmp eq i64 %t8, 0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  %t12 = load i8*, i8** %l2
  br i1 %t9, label %then0, label %merge1
then0:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s14 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %s14, %interface_name
  %s16 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.16, i32 0, i32 0
  %t17 = add i8* %t15, %s16
  %t18 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t13, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t20 = load double, double* %l1
  %t21 = insertvalue %InterfaceSignatureParse %t19, i8* null, 1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = insertvalue %InterfaceSignatureParse %t21, { i8**, i64 }* %t22, 2
  ret %InterfaceSignatureParse %t23
merge1:
  %t24 = load i8*, i8** %l2
  store i8* %t24, i8** %l3
  store i1 0, i1* %l4
  %t25 = load i8*, i8** %l3
  %s26 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.26, i32 0, i32 0
  %t27 = call i1 @starts_with(i8* %t25, i8* %s26)
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l3
  %t32 = load i1, i1* %l4
  br i1 %t27, label %then2, label %merge3
then2:
  store i1 1, i1* %l4
  %t33 = load i8*, i8** %l3
  %s34 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.34, i32 0, i32 0
  %t35 = call i8* @strip_prefix(i8* %t33, i8* %s34)
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l3
  br label %merge3
merge3:
  %t37 = phi i1 [ 1, %then2 ], [ %t32, %entry ]
  %t38 = phi i8* [ %t36, %then2 ], [ %t31, %entry ]
  store i1 %t37, i1* %l4
  store i8* %t38, i8** %l3
  %t39 = load i8*, i8** %l3
  %t40 = call double @index_of(i8* %t39, i8* null)
  store double %t40, double* %l5
  %t41 = load double, double* %l5
  %t42 = sitofp i64 0 to double
  %t43 = fcmp olt double %t41, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load i8*, i8** %l2
  %t47 = load i8*, i8** %l3
  %t48 = load i1, i1* %l4
  %t49 = load double, double* %l5
  br i1 %t43, label %then4, label %merge5
then4:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s51 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.51, i32 0, i32 0
  %t52 = add i8* %s51, %interface_name
  %s53 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
  %t55 = load i8*, i8** %l2
  %t56 = add i8* %t54, %t55
  %t57 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t50, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  %t58 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t59 = load double, double* %l1
  %t60 = insertvalue %InterfaceSignatureParse %t58, i8* null, 1
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = insertvalue %InterfaceSignatureParse %t60, { i8**, i64 }* %t61, 2
  ret %InterfaceSignatureParse %t62
merge5:
  %t63 = load i8*, i8** %l3
  %t64 = load double, double* %l5
  %t65 = call double @find_matching_paren(i8* %t63, double %t64)
  store double %t65, double* %l6
  %t66 = load double, double* %l6
  %t67 = sitofp i64 0 to double
  %t68 = fcmp olt double %t66, %t67
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l1
  %t71 = load i8*, i8** %l2
  %t72 = load i8*, i8** %l3
  %t73 = load i1, i1* %l4
  %t74 = load double, double* %l5
  %t75 = load double, double* %l6
  br i1 %t68, label %then6, label %merge7
then6:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s77 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.77, i32 0, i32 0
  %t78 = add i8* %s77, %interface_name
  %s79 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.79, i32 0, i32 0
  %t80 = add i8* %t78, %s79
  %t81 = load i8*, i8** %l2
  %t82 = add i8* %t80, %t81
  %t83 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t76, i8* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  %t84 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t85 = load double, double* %l1
  %t86 = insertvalue %InterfaceSignatureParse %t84, i8* null, 1
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t88 = insertvalue %InterfaceSignatureParse %t86, { i8**, i64 }* %t87, 2
  ret %InterfaceSignatureParse %t88
merge7:
  %t89 = load i8*, i8** %l3
  %t90 = load double, double* %l5
  %t91 = fptosi double %t90 to i64
  %t92 = call i8* @sailfin_runtime_substring(i8* %t89, i64 0, i64 %t91)
  %t93 = call i8* @trim_text(i8* %t92)
  store i8* %t93, i8** %l7
  %t94 = load i8*, i8** %l7
  %t95 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t94)
  store %HeaderNameParse %t95, %HeaderNameParse* %l8
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t97 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t98 = extractvalue %HeaderNameParse %t97, 3
  %t99 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t96, { i8**, i64 }* %t98)
  store { i8**, i64 }* %t99, { i8**, i64 }** %l0
  %t100 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t101 = extractvalue %HeaderNameParse %t100, 2
  %t102 = call i64 @sailfin_runtime_string_length(i8* %t101)
  %t103 = icmp sgt i64 %t102, 0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load double, double* %l1
  %t106 = load i8*, i8** %l2
  %t107 = load i8*, i8** %l3
  %t108 = load i1, i1* %l4
  %t109 = load double, double* %l5
  %t110 = load double, double* %l6
  %t111 = load i8*, i8** %l7
  %t112 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t103, label %then8, label %merge9
then8:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s114 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.114, i32 0, i32 0
  %t115 = add i8* %s114, %interface_name
  %s116 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.116, i32 0, i32 0
  %t117 = add i8* %t115, %s116
  %t118 = load i8*, i8** %l2
  %t119 = add i8* %t117, %t118
  %s120 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.120, i32 0, i32 0
  %t121 = add i8* %t119, %s120
  %t122 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t123 = extractvalue %HeaderNameParse %t122, 2
  %t124 = add i8* %t121, %t123
  %t125 = getelementptr i8, i8* %t124, i64 0
  %t126 = load i8, i8* %t125
  %t127 = add i8 %t126, 96
  %t128 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t113, i8* null)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t129 = phi { i8**, i64 }* [ %t128, %then8 ], [ %t104, %entry ]
  store { i8**, i64 }* %t129, { i8**, i64 }** %l0
  %t130 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t131 = extractvalue %HeaderNameParse %t130, 0
  store i8* %t131, i8** %l9
  %t132 = load i8*, i8** %l9
  %t133 = call i64 @sailfin_runtime_string_length(i8* %t132)
  %t134 = icmp eq i64 %t133, 0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load double, double* %l1
  %t137 = load i8*, i8** %l2
  %t138 = load i8*, i8** %l3
  %t139 = load i1, i1* %l4
  %t140 = load double, double* %l5
  %t141 = load double, double* %l6
  %t142 = load i8*, i8** %l7
  %t143 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t144 = load i8*, i8** %l9
  br i1 %t134, label %then10, label %merge11
then10:
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s146 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.146, i32 0, i32 0
  %t147 = add i8* %s146, %interface_name
  %s148 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.148, i32 0, i32 0
  %t149 = add i8* %t147, %s148
  %t150 = load i8*, i8** %l2
  %t151 = add i8* %t149, %t150
  %s152 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.152, i32 0, i32 0
  %t153 = add i8* %t151, %s152
  %t154 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t145, i8* %t153)
  store { i8**, i64 }* %t154, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t155 = phi { i8**, i64 }* [ %t154, %then10 ], [ %t135, %entry ]
  store { i8**, i64 }* %t155, { i8**, i64 }** %l0
  %t156 = load i8*, i8** %l3
  %t157 = load double, double* %l5
  %t158 = sitofp i64 1 to double
  %t159 = fadd double %t157, %t158
  %t160 = load double, double* %l6
  %t161 = fptosi double %t159 to i64
  %t162 = fptosi double %t160 to i64
  %t163 = call i8* @sailfin_runtime_substring(i8* %t156, i64 %t161, i64 %t162)
  store i8* %t163, i8** %l10
  %t164 = alloca [0 x %NativeParameter]
  %t165 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t164, i32 0, i32 0
  %t166 = alloca { %NativeParameter*, i64 }
  %t167 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t166, i32 0, i32 0
  store %NativeParameter* %t165, %NativeParameter** %t167
  %t168 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t166, i32 0, i32 1
  store i64 0, i64* %t168
  store { %NativeParameter*, i64 }* %t166, { %NativeParameter*, i64 }** %l11
  %t169 = load i8*, i8** %l10
  %t170 = call i8* @trim_text(i8* %t169)
  store i8* %t170, i8** %l12
  %t171 = load i8*, i8** %l12
  %t172 = call i64 @sailfin_runtime_string_length(i8* %t171)
  %t173 = icmp sgt i64 %t172, 0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t175 = load double, double* %l1
  %t176 = load i8*, i8** %l2
  %t177 = load i8*, i8** %l3
  %t178 = load i1, i1* %l4
  %t179 = load double, double* %l5
  %t180 = load double, double* %l6
  %t181 = load i8*, i8** %l7
  %t182 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t183 = load i8*, i8** %l9
  %t184 = load i8*, i8** %l10
  %t185 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t186 = load i8*, i8** %l12
  br i1 %t173, label %then12, label %merge13
then12:
  %t187 = load i8*, i8** %l12
  %t188 = call { i8**, i64 }* @split_parameter_entries(i8* %t187)
  store { i8**, i64 }* %t188, { i8**, i64 }** %l13
  %t189 = sitofp i64 0 to double
  store double %t189, double* %l14
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load double, double* %l1
  %t192 = load i8*, i8** %l2
  %t193 = load i8*, i8** %l3
  %t194 = load i1, i1* %l4
  %t195 = load double, double* %l5
  %t196 = load double, double* %l6
  %t197 = load i8*, i8** %l7
  %t198 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t199 = load i8*, i8** %l9
  %t200 = load i8*, i8** %l10
  %t201 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t202 = load i8*, i8** %l12
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t204 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t240 = phi double [ %t204, %then12 ], [ %t239, %loop.latch16 ]
  store double %t240, double* %l14
  br label %loop.body15
loop.body15:
  %t205 = load double, double* %l14
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t207 = load { i8**, i64 }, { i8**, i64 }* %t206
  %t208 = extractvalue { i8**, i64 } %t207, 1
  %t209 = sitofp i64 %t208 to double
  %t210 = fcmp oge double %t205, %t209
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t212 = load double, double* %l1
  %t213 = load i8*, i8** %l2
  %t214 = load i8*, i8** %l3
  %t215 = load i1, i1* %l4
  %t216 = load double, double* %l5
  %t217 = load double, double* %l6
  %t218 = load i8*, i8** %l7
  %t219 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t220 = load i8*, i8** %l9
  %t221 = load i8*, i8** %l10
  %t222 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t223 = load i8*, i8** %l12
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t225 = load double, double* %l14
  br i1 %t210, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t227 = load double, double* %l14
  %t228 = load { i8**, i64 }, { i8**, i64 }* %t226
  %t229 = extractvalue { i8**, i64 } %t228, 0
  %t230 = extractvalue { i8**, i64 } %t228, 1
  %t231 = icmp uge i64 %t227, %t230
  ; bounds check: %t231 (if true, out of bounds)
  %t232 = getelementptr i8*, i8** %t229, i64 %t227
  %t233 = load i8*, i8** %t232
  %t234 = call double @parse_parameter_entry(i8* %t233, i8* null)
  store double %t234, double* %l15
  %t235 = load double, double* %l15
  %t236 = load double, double* %l14
  %t237 = sitofp i64 1 to double
  %t238 = fadd double %t236, %t237
  store double %t238, double* %l14
  br label %loop.latch16
loop.latch16:
  %t239 = load double, double* %l14
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %s241 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.241, i32 0, i32 0
  store i8* %s241, i8** %l16
  %t242 = alloca [0 x i8*]
  %t243 = getelementptr [0 x i8*], [0 x i8*]* %t242, i32 0, i32 0
  %t244 = alloca { i8**, i64 }
  %t245 = getelementptr { i8**, i64 }, { i8**, i64 }* %t244, i32 0, i32 0
  store i8** %t243, i8*** %t245
  %t246 = getelementptr { i8**, i64 }, { i8**, i64 }* %t244, i32 0, i32 1
  store i64 0, i64* %t246
  store { i8**, i64 }* %t244, { i8**, i64 }** %l17
  %t247 = load i8*, i8** %l3
  %t248 = load double, double* %l6
  %t249 = sitofp i64 1 to double
  %t250 = fadd double %t248, %t249
  %t251 = load i8*, i8** %l3
  %t252 = call i64 @sailfin_runtime_string_length(i8* %t251)
  %t253 = fptosi double %t250 to i64
  %t254 = call i8* @sailfin_runtime_substring(i8* %t247, i64 %t253, i64 %t252)
  %t255 = call i8* @trim_text(i8* %t254)
  store i8* %t255, i8** %l18
  %t256 = load i8*, i8** %l18
  %t257 = call i64 @sailfin_runtime_string_length(i8* %t256)
  %t258 = icmp sgt i64 %t257, 0
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t260 = load double, double* %l1
  %t261 = load i8*, i8** %l2
  %t262 = load i8*, i8** %l3
  %t263 = load i1, i1* %l4
  %t264 = load double, double* %l5
  %t265 = load double, double* %l6
  %t266 = load i8*, i8** %l7
  %t267 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t268 = load i8*, i8** %l9
  %t269 = load i8*, i8** %l10
  %t270 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t271 = load i8*, i8** %l12
  %t272 = load i8*, i8** %l16
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t274 = load i8*, i8** %l18
  br i1 %t258, label %then20, label %merge21
then20:
  %t275 = load i8*, i8** %l18
  %s276 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.276, i32 0, i32 0
  %t277 = call double @index_of(i8* %t275, i8* %s276)
  store double %t277, double* %l19
  %s278 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.278, i32 0, i32 0
  store i8* %s278, i8** %l20
  %t279 = load double, double* %l19
  %t280 = sitofp i64 0 to double
  %t281 = fcmp oge double %t279, %t280
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load double, double* %l1
  %t284 = load i8*, i8** %l2
  %t285 = load i8*, i8** %l3
  %t286 = load i1, i1* %l4
  %t287 = load double, double* %l5
  %t288 = load double, double* %l6
  %t289 = load i8*, i8** %l7
  %t290 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t291 = load i8*, i8** %l9
  %t292 = load i8*, i8** %l10
  %t293 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t294 = load i8*, i8** %l12
  %t295 = load i8*, i8** %l16
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t297 = load i8*, i8** %l18
  %t298 = load double, double* %l19
  %t299 = load i8*, i8** %l20
  br i1 %t281, label %then22, label %merge23
then22:
  %t300 = load i8*, i8** %l18
  %t301 = load double, double* %l19
  %t302 = load i8*, i8** %l18
  %t303 = call i64 @sailfin_runtime_string_length(i8* %t302)
  %t304 = fptosi double %t301 to i64
  %t305 = call i8* @sailfin_runtime_substring(i8* %t300, i64 %t304, i64 %t303)
  %t306 = call i8* @trim_text(i8* %t305)
  store i8* %t306, i8** %l20
  %t307 = load i8*, i8** %l18
  %t308 = load double, double* %l19
  %t309 = fptosi double %t308 to i64
  %t310 = call i8* @sailfin_runtime_substring(i8* %t307, i64 0, i64 %t309)
  %t311 = call i8* @trim_text(i8* %t310)
  store i8* %t311, i8** %l18
  br label %merge23
merge23:
  %t312 = phi i8* [ %t306, %then22 ], [ %t299, %then20 ]
  %t313 = phi i8* [ %t311, %then22 ], [ %t297, %then20 ]
  store i8* %t312, i8** %l20
  store i8* %t313, i8** %l18
  %t314 = load i8*, i8** %l18
  %t315 = call i64 @sailfin_runtime_string_length(i8* %t314)
  %t316 = icmp sgt i64 %t315, 0
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t318 = load double, double* %l1
  %t319 = load i8*, i8** %l2
  %t320 = load i8*, i8** %l3
  %t321 = load i1, i1* %l4
  %t322 = load double, double* %l5
  %t323 = load double, double* %l6
  %t324 = load i8*, i8** %l7
  %t325 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t326 = load i8*, i8** %l9
  %t327 = load i8*, i8** %l10
  %t328 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t329 = load i8*, i8** %l12
  %t330 = load i8*, i8** %l16
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t332 = load i8*, i8** %l18
  %t333 = load double, double* %l19
  %t334 = load i8*, i8** %l20
  br i1 %t316, label %then24, label %merge25
then24:
  %t335 = load i8*, i8** %l18
  br label %merge25
merge25:
  %t336 = load i8*, i8** %l20
  %t337 = call i64 @sailfin_runtime_string_length(i8* %t336)
  %t338 = icmp sgt i64 %t337, 0
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t340 = load double, double* %l1
  %t341 = load i8*, i8** %l2
  %t342 = load i8*, i8** %l3
  %t343 = load i1, i1* %l4
  %t344 = load double, double* %l5
  %t345 = load double, double* %l6
  %t346 = load i8*, i8** %l7
  %t347 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t348 = load i8*, i8** %l9
  %t349 = load i8*, i8** %l10
  %t350 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t351 = load i8*, i8** %l12
  %t352 = load i8*, i8** %l16
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t354 = load i8*, i8** %l18
  %t355 = load double, double* %l19
  %t356 = load i8*, i8** %l20
  br i1 %t338, label %then26, label %merge27
then26:
  %t358 = load i8*, i8** %l20
  %s359 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.359, i32 0, i32 0
  %t360 = call i1 @starts_with(i8* %t358, i8* %s359)
  br label %logical_and_entry_357

logical_and_entry_357:
  br i1 %t360, label %logical_and_right_357, label %logical_and_merge_357

logical_and_right_357:
  br label %merge27
merge27:
  br label %merge21
merge21:
  %t361 = phi i8* [ %t311, %then20 ], [ %t274, %entry ]
  store i8* %t361, i8** %l18
  store double 0.0, double* %l21
  %t363 = load i8*, i8** %l9
  %t364 = call i64 @sailfin_runtime_string_length(i8* %t363)
  %t365 = icmp sgt i64 %t364, 0
  br label %logical_and_entry_362

logical_and_entry_362:
  br i1 %t365, label %logical_and_right_362, label %logical_and_merge_362

logical_and_right_362:
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t367 = load { i8**, i64 }, { i8**, i64 }* %t366
  %t368 = extractvalue { i8**, i64 } %t367, 1
  %t369 = icmp eq i64 %t368, 0
  br label %logical_and_right_end_362

logical_and_right_end_362:
  br label %logical_and_merge_362

logical_and_merge_362:
  %t370 = phi i1 [ false, %logical_and_entry_362 ], [ %t369, %logical_and_right_end_362 ]
  store i1 %t370, i1* %l22
  %t371 = load i1, i1* %l22
  %t372 = insertvalue %InterfaceSignatureParse undef, i1 %t371, 0
  %t373 = load double, double* %l21
  %t374 = insertvalue %InterfaceSignatureParse %t372, i8* null, 1
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t376 = insertvalue %InterfaceSignatureParse %t374, { i8**, i64 }* %t375, 2
  ret %InterfaceSignatureParse %t376
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
  %t379 = phi i8* [ %t13, %entry ], [ %t372, %loop.latch2 ]
  %t380 = phi double [ %t14, %entry ], [ %t373, %loop.latch2 ]
  %t381 = phi i8* [ %t15, %entry ], [ %t374, %loop.latch2 ]
  %t382 = phi double [ %t17, %entry ], [ %t375, %loop.latch2 ]
  %t383 = phi double [ %t18, %entry ], [ %t376, %loop.latch2 ]
  %t384 = phi double [ %t19, %entry ], [ %t377, %loop.latch2 ]
  %t385 = phi { i8**, i64 }* [ %t12, %entry ], [ %t378, %loop.latch2 ]
  store i8* %t379, i8** %l1
  store double %t380, double* %l2
  store i8* %t381, i8** %l3
  store double %t382, double* %l5
  store double %t383, double* %l6
  store double %t384, double* %l7
  store { i8**, i64 }* %t385, { i8**, i64 }** %l0
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
  %t33 = getelementptr i8, i8* %text, i64 %t32
  %t34 = load i8, i8* %t33
  store i8 %t34, i8* %l8
  %t35 = load i8*, i8** %l3
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp sgt i64 %t36, 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l2
  %t41 = load i8*, i8** %l3
  %t42 = load double, double* %l4
  %t43 = load double, double* %l5
  %t44 = load double, double* %l6
  %t45 = load double, double* %l7
  %t46 = load i8, i8* %l8
  br i1 %t37, label %then6, label %merge7
then6:
  %t47 = load i8*, i8** %l1
  %t48 = load i8, i8* %l8
  %t49 = getelementptr i8, i8* %t47, i64 0
  %t50 = load i8, i8* %t49
  %t51 = add i8 %t50, %t48
  store i8* null, i8** %l1
  %t52 = load i8, i8* %l8
  %t53 = icmp eq i8 %t52, 92
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load i8*, i8** %l3
  %t58 = load double, double* %l4
  %t59 = load double, double* %l5
  %t60 = load double, double* %l6
  %t61 = load double, double* %l7
  %t62 = load i8, i8* %l8
  br i1 %t53, label %then8, label %merge9
then8:
  %t63 = load double, double* %l2
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  %t66 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t67 = sitofp i64 %t66 to double
  %t68 = fcmp olt double %t65, %t67
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l3
  %t73 = load double, double* %l4
  %t74 = load double, double* %l5
  %t75 = load double, double* %l6
  %t76 = load double, double* %l7
  %t77 = load i8, i8* %l8
  br i1 %t68, label %then10, label %merge11
then10:
  %t78 = load i8*, i8** %l1
  %t79 = load double, double* %l2
  %t80 = sitofp i64 2 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t82 = phi i8* [ null, %then8 ], [ %t55, %then6 ]
  %t83 = phi double [ %t81, %then8 ], [ %t56, %then6 ]
  store i8* %t82, i8** %l1
  store double %t83, double* %l2
  %t84 = load i8, i8* %l8
  %t85 = load i8*, i8** %l3
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = icmp eq i8 %t84, %t87
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load i8*, i8** %l3
  %t93 = load double, double* %l4
  %t94 = load double, double* %l5
  %t95 = load double, double* %l6
  %t96 = load double, double* %l7
  %t97 = load i8, i8* %l8
  br i1 %t88, label %then12, label %merge13
then12:
  %s98 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.98, i32 0, i32 0
  store i8* %s98, i8** %l3
  br label %merge13
merge13:
  %t99 = phi i8* [ %s98, %then12 ], [ %t92, %then6 ]
  store i8* %t99, i8** %l3
  %t100 = load double, double* %l2
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l2
  br label %loop.latch2
merge7:
  %t104 = load i8, i8* %l8
  %t105 = icmp eq i8 %t104, 34
  br label %logical_or_entry_103

logical_or_entry_103:
  br i1 %t105, label %logical_or_merge_103, label %logical_or_right_103

logical_or_right_103:
  %t106 = load i8, i8* %l8
  %t107 = icmp eq i8 %t106, 39
  br label %logical_or_right_end_103

logical_or_right_end_103:
  br label %logical_or_merge_103

logical_or_merge_103:
  %t108 = phi i1 [ true, %logical_or_entry_103 ], [ %t107, %logical_or_right_end_103 ]
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load i8*, i8** %l1
  %t111 = load double, double* %l2
  %t112 = load i8*, i8** %l3
  %t113 = load double, double* %l4
  %t114 = load double, double* %l5
  %t115 = load double, double* %l6
  %t116 = load double, double* %l7
  %t117 = load i8, i8* %l8
  br i1 %t108, label %then14, label %merge15
then14:
  %t118 = load i8, i8* %l8
  store i8* null, i8** %l3
  %t119 = load i8*, i8** %l1
  %t120 = load i8, i8* %l8
  %t121 = getelementptr i8, i8* %t119, i64 0
  %t122 = load i8, i8* %t121
  %t123 = add i8 %t122, %t120
  store i8* null, i8** %l1
  %t124 = load double, double* %l2
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  store double %t126, double* %l2
  br label %loop.latch2
merge15:
  %t127 = load i8, i8* %l8
  %t128 = load i8, i8* %l8
  %t129 = load i8, i8* %l8
  %t130 = icmp eq i8 %t129, 40
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load i8*, i8** %l3
  %t135 = load double, double* %l4
  %t136 = load double, double* %l5
  %t137 = load double, double* %l6
  %t138 = load double, double* %l7
  %t139 = load i8, i8* %l8
  br i1 %t130, label %then16, label %merge17
then16:
  %t140 = load double, double* %l5
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l5
  %t143 = load i8*, i8** %l1
  %t144 = load i8, i8* %l8
  %t145 = getelementptr i8, i8* %t143, i64 0
  %t146 = load i8, i8* %t145
  %t147 = add i8 %t146, %t144
  store i8* null, i8** %l1
  %t148 = load double, double* %l2
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l2
  br label %loop.latch2
merge17:
  %t151 = load i8, i8* %l8
  %t152 = icmp eq i8 %t151, 41
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = load i8*, i8** %l1
  %t155 = load double, double* %l2
  %t156 = load i8*, i8** %l3
  %t157 = load double, double* %l4
  %t158 = load double, double* %l5
  %t159 = load double, double* %l6
  %t160 = load double, double* %l7
  %t161 = load i8, i8* %l8
  br i1 %t152, label %then18, label %merge19
then18:
  %t162 = load double, double* %l5
  %t163 = sitofp i64 0 to double
  %t164 = fcmp ogt double %t162, %t163
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  %t168 = load i8*, i8** %l3
  %t169 = load double, double* %l4
  %t170 = load double, double* %l5
  %t171 = load double, double* %l6
  %t172 = load double, double* %l7
  %t173 = load i8, i8* %l8
  br i1 %t164, label %then20, label %merge21
then20:
  %t174 = load double, double* %l5
  %t175 = sitofp i64 1 to double
  %t176 = fsub double %t174, %t175
  store double %t176, double* %l5
  br label %merge21
merge21:
  %t177 = phi double [ %t176, %then20 ], [ %t170, %then18 ]
  store double %t177, double* %l5
  %t178 = load i8*, i8** %l1
  %t179 = load i8, i8* %l8
  %t180 = getelementptr i8, i8* %t178, i64 0
  %t181 = load i8, i8* %t180
  %t182 = add i8 %t181, %t179
  store i8* null, i8** %l1
  %t183 = load double, double* %l2
  %t184 = sitofp i64 1 to double
  %t185 = fadd double %t183, %t184
  store double %t185, double* %l2
  br label %loop.latch2
merge19:
  %t186 = load i8, i8* %l8
  %t187 = icmp eq i8 %t186, 91
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load i8*, i8** %l1
  %t190 = load double, double* %l2
  %t191 = load i8*, i8** %l3
  %t192 = load double, double* %l4
  %t193 = load double, double* %l5
  %t194 = load double, double* %l6
  %t195 = load double, double* %l7
  %t196 = load i8, i8* %l8
  br i1 %t187, label %then22, label %merge23
then22:
  %t197 = load double, double* %l6
  %t198 = sitofp i64 1 to double
  %t199 = fadd double %t197, %t198
  store double %t199, double* %l6
  %t200 = load i8*, i8** %l1
  %t201 = load i8, i8* %l8
  %t202 = getelementptr i8, i8* %t200, i64 0
  %t203 = load i8, i8* %t202
  %t204 = add i8 %t203, %t201
  store i8* null, i8** %l1
  %t205 = load double, double* %l2
  %t206 = sitofp i64 1 to double
  %t207 = fadd double %t205, %t206
  store double %t207, double* %l2
  br label %loop.latch2
merge23:
  %t208 = load i8, i8* %l8
  %t209 = icmp eq i8 %t208, 93
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l2
  %t213 = load i8*, i8** %l3
  %t214 = load double, double* %l4
  %t215 = load double, double* %l5
  %t216 = load double, double* %l6
  %t217 = load double, double* %l7
  %t218 = load i8, i8* %l8
  br i1 %t209, label %then24, label %merge25
then24:
  %t219 = load double, double* %l6
  %t220 = sitofp i64 0 to double
  %t221 = fcmp ogt double %t219, %t220
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l2
  %t225 = load i8*, i8** %l3
  %t226 = load double, double* %l4
  %t227 = load double, double* %l5
  %t228 = load double, double* %l6
  %t229 = load double, double* %l7
  %t230 = load i8, i8* %l8
  br i1 %t221, label %then26, label %merge27
then26:
  %t231 = load double, double* %l6
  %t232 = sitofp i64 1 to double
  %t233 = fsub double %t231, %t232
  store double %t233, double* %l6
  br label %merge27
merge27:
  %t234 = phi double [ %t233, %then26 ], [ %t228, %then24 ]
  store double %t234, double* %l6
  %t235 = load i8*, i8** %l1
  %t236 = load i8, i8* %l8
  %t237 = getelementptr i8, i8* %t235, i64 0
  %t238 = load i8, i8* %t237
  %t239 = add i8 %t238, %t236
  store i8* null, i8** %l1
  %t240 = load double, double* %l2
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  store double %t242, double* %l2
  br label %loop.latch2
merge25:
  %t243 = load i8, i8* %l8
  %t244 = icmp eq i8 %t243, 123
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t246 = load i8*, i8** %l1
  %t247 = load double, double* %l2
  %t248 = load i8*, i8** %l3
  %t249 = load double, double* %l4
  %t250 = load double, double* %l5
  %t251 = load double, double* %l6
  %t252 = load double, double* %l7
  %t253 = load i8, i8* %l8
  br i1 %t244, label %then28, label %merge29
then28:
  %t254 = load double, double* %l7
  %t255 = sitofp i64 1 to double
  %t256 = fadd double %t254, %t255
  store double %t256, double* %l7
  %t257 = load i8*, i8** %l1
  %t258 = load i8, i8* %l8
  %t259 = getelementptr i8, i8* %t257, i64 0
  %t260 = load i8, i8* %t259
  %t261 = add i8 %t260, %t258
  store i8* null, i8** %l1
  %t262 = load double, double* %l2
  %t263 = sitofp i64 1 to double
  %t264 = fadd double %t262, %t263
  store double %t264, double* %l2
  br label %loop.latch2
merge29:
  %t265 = load i8, i8* %l8
  %t266 = icmp eq i8 %t265, 125
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load i8*, i8** %l1
  %t269 = load double, double* %l2
  %t270 = load i8*, i8** %l3
  %t271 = load double, double* %l4
  %t272 = load double, double* %l5
  %t273 = load double, double* %l6
  %t274 = load double, double* %l7
  %t275 = load i8, i8* %l8
  br i1 %t266, label %then30, label %merge31
then30:
  %t276 = load double, double* %l7
  %t277 = sitofp i64 0 to double
  %t278 = fcmp ogt double %t276, %t277
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t280 = load i8*, i8** %l1
  %t281 = load double, double* %l2
  %t282 = load i8*, i8** %l3
  %t283 = load double, double* %l4
  %t284 = load double, double* %l5
  %t285 = load double, double* %l6
  %t286 = load double, double* %l7
  %t287 = load i8, i8* %l8
  br i1 %t278, label %then32, label %merge33
then32:
  %t288 = load double, double* %l7
  %t289 = sitofp i64 1 to double
  %t290 = fsub double %t288, %t289
  store double %t290, double* %l7
  br label %merge33
merge33:
  %t291 = phi double [ %t290, %then32 ], [ %t286, %then30 ]
  store double %t291, double* %l7
  %t292 = load i8*, i8** %l1
  %t293 = load i8, i8* %l8
  %t294 = getelementptr i8, i8* %t292, i64 0
  %t295 = load i8, i8* %t294
  %t296 = add i8 %t295, %t293
  store i8* null, i8** %l1
  %t297 = load double, double* %l2
  %t298 = sitofp i64 1 to double
  %t299 = fadd double %t297, %t298
  store double %t299, double* %l2
  br label %loop.latch2
merge31:
  %t300 = load i8, i8* %l8
  %t301 = icmp eq i8 %t300, 44
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t303 = load i8*, i8** %l1
  %t304 = load double, double* %l2
  %t305 = load i8*, i8** %l3
  %t306 = load double, double* %l4
  %t307 = load double, double* %l5
  %t308 = load double, double* %l6
  %t309 = load double, double* %l7
  %t310 = load i8, i8* %l8
  br i1 %t301, label %then34, label %merge35
then34:
  %t314 = load double, double* %l4
  %t315 = sitofp i64 0 to double
  %t316 = fcmp oeq double %t314, %t315
  br label %logical_and_entry_313

logical_and_entry_313:
  br i1 %t316, label %logical_and_right_313, label %logical_and_merge_313

logical_and_right_313:
  %t317 = load double, double* %l5
  %t318 = sitofp i64 0 to double
  %t319 = fcmp oeq double %t317, %t318
  br label %logical_and_right_end_313

logical_and_right_end_313:
  br label %logical_and_merge_313

logical_and_merge_313:
  %t320 = phi i1 [ false, %logical_and_entry_313 ], [ %t319, %logical_and_right_end_313 ]
  br label %logical_and_entry_312

logical_and_entry_312:
  br i1 %t320, label %logical_and_right_312, label %logical_and_merge_312

logical_and_right_312:
  %t321 = load double, double* %l6
  %t322 = sitofp i64 0 to double
  %t323 = fcmp oeq double %t321, %t322
  br label %logical_and_right_end_312

logical_and_right_end_312:
  br label %logical_and_merge_312

logical_and_merge_312:
  %t324 = phi i1 [ false, %logical_and_entry_312 ], [ %t323, %logical_and_right_end_312 ]
  br label %logical_and_entry_311

logical_and_entry_311:
  br i1 %t324, label %logical_and_right_311, label %logical_and_merge_311

logical_and_right_311:
  %t325 = load double, double* %l7
  %t326 = sitofp i64 0 to double
  %t327 = fcmp oeq double %t325, %t326
  br label %logical_and_right_end_311

logical_and_right_end_311:
  br label %logical_and_merge_311

logical_and_merge_311:
  %t328 = phi i1 [ false, %logical_and_entry_311 ], [ %t327, %logical_and_right_end_311 ]
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t330 = load i8*, i8** %l1
  %t331 = load double, double* %l2
  %t332 = load i8*, i8** %l3
  %t333 = load double, double* %l4
  %t334 = load double, double* %l5
  %t335 = load double, double* %l6
  %t336 = load double, double* %l7
  %t337 = load i8, i8* %l8
  br i1 %t328, label %then36, label %merge37
then36:
  %t338 = load i8*, i8** %l1
  %t339 = call i8* @trim_text(i8* %t338)
  store i8* %t339, i8** %l9
  %t340 = load i8*, i8** %l9
  %t341 = call i64 @sailfin_runtime_string_length(i8* %t340)
  %t342 = icmp sgt i64 %t341, 0
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t344 = load i8*, i8** %l1
  %t345 = load double, double* %l2
  %t346 = load i8*, i8** %l3
  %t347 = load double, double* %l4
  %t348 = load double, double* %l5
  %t349 = load double, double* %l6
  %t350 = load double, double* %l7
  %t351 = load i8, i8* %l8
  %t352 = load i8*, i8** %l9
  br i1 %t342, label %then38, label %merge39
then38:
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t354 = load i8*, i8** %l9
  %t355 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t353, i8* %t354)
  store { i8**, i64 }* %t355, { i8**, i64 }** %l0
  br label %merge39
merge39:
  %t356 = phi { i8**, i64 }* [ %t355, %then38 ], [ %t343, %then36 ]
  store { i8**, i64 }* %t356, { i8**, i64 }** %l0
  %s357 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.357, i32 0, i32 0
  store i8* %s357, i8** %l1
  %t358 = load double, double* %l2
  %t359 = sitofp i64 1 to double
  %t360 = fadd double %t358, %t359
  store double %t360, double* %l2
  br label %loop.latch2
merge37:
  br label %merge35
merge35:
  %t361 = phi { i8**, i64 }* [ %t355, %then34 ], [ %t302, %loop.body1 ]
  %t362 = phi i8* [ %s357, %then34 ], [ %t303, %loop.body1 ]
  %t363 = phi double [ %t360, %then34 ], [ %t304, %loop.body1 ]
  store { i8**, i64 }* %t361, { i8**, i64 }** %l0
  store i8* %t362, i8** %l1
  store double %t363, double* %l2
  %t364 = load i8*, i8** %l1
  %t365 = load i8, i8* %l8
  %t366 = getelementptr i8, i8* %t364, i64 0
  %t367 = load i8, i8* %t366
  %t368 = add i8 %t367, %t365
  store i8* null, i8** %l1
  %t369 = load double, double* %l2
  %t370 = sitofp i64 1 to double
  %t371 = fadd double %t369, %t370
  store double %t371, double* %l2
  br label %loop.latch2
loop.latch2:
  %t372 = load i8*, i8** %l1
  %t373 = load double, double* %l2
  %t374 = load i8*, i8** %l3
  %t375 = load double, double* %l5
  %t376 = load double, double* %l6
  %t377 = load double, double* %l7
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t386 = load i8*, i8** %l1
  %t387 = call i8* @trim_text(i8* %t386)
  store i8* %t387, i8** %l10
  %t388 = load i8*, i8** %l10
  %t389 = call i64 @sailfin_runtime_string_length(i8* %t388)
  %t390 = icmp sgt i64 %t389, 0
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t392 = load i8*, i8** %l1
  %t393 = load double, double* %l2
  %t394 = load i8*, i8** %l3
  %t395 = load double, double* %l4
  %t396 = load double, double* %l5
  %t397 = load double, double* %l6
  %t398 = load double, double* %l7
  %t399 = load i8*, i8** %l10
  br i1 %t390, label %then40, label %merge41
then40:
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t401 = load i8*, i8** %l10
  %t402 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t400, i8* %t401)
  store { i8**, i64 }* %t402, { i8**, i64 }** %l0
  br label %merge41
merge41:
  %t403 = phi { i8**, i64 }* [ %t402, %then40 ], [ %t391, %entry ]
  store { i8**, i64 }* %t403, { i8**, i64 }** %l0
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t404
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
  %t17 = phi double [ %t2, %entry ], [ %t16, %loop.latch2 ]
  store double %t17, double* %l1
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
  %t10 = getelementptr i8, i8* %text, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l2
  %t12 = load i8, i8* %l2
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t18 = sitofp i64 -1 to double
  ret double %t18
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
  %t105 = phi double [ %t2, %entry ], [ %t103, %loop.latch2 ]
  %t106 = phi double [ %t1, %entry ], [ %t104, %loop.latch2 ]
  store double %t105, double* %l1
  store double %t106, double* %l0
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
  %t10 = getelementptr i8, i8* %text, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l2
  %t13 = load i8, i8* %l2
  %t14 = icmp eq i8 %t13, 34
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 39
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t17 = phi i1 [ true, %logical_or_entry_12 ], [ %t16, %logical_or_right_end_12 ]
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load i8, i8* %l2
  br i1 %t17, label %then6, label %else7
then6:
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l3
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  %t27 = load double, double* %l3
  br label %loop.header9
loop.header9:
  %t64 = phi double [ %t27, %then6 ], [ %t62, %loop.latch11 ]
  %t65 = phi double [ %t25, %then6 ], [ %t63, %loop.latch11 ]
  store double %t64, double* %l3
  store double %t65, double* %l1
  br label %loop.body10
loop.body10:
  %t28 = load double, double* %l3
  %t29 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t30 = sitofp i64 %t29 to double
  %t31 = fcmp oge double %t28, %t30
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load i8, i8* %l2
  %t35 = load double, double* %l3
  br i1 %t31, label %then13, label %merge14
then13:
  %t36 = sitofp i64 -1 to double
  ret double %t36
merge14:
  %t37 = load double, double* %l3
  %t38 = getelementptr i8, i8* %text, i64 %t37
  %t39 = load i8, i8* %t38
  store i8 %t39, i8* %l4
  %t40 = load i8, i8* %l4
  %t41 = icmp eq i8 %t40, 92
  %t42 = load double, double* %l0
  %t43 = load double, double* %l1
  %t44 = load i8, i8* %l2
  %t45 = load double, double* %l3
  %t46 = load i8, i8* %l4
  br i1 %t41, label %then15, label %merge16
then15:
  %t47 = load double, double* %l3
  %t48 = sitofp i64 2 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l3
  br label %loop.latch11
merge16:
  %t50 = load i8, i8* %l4
  %t51 = load i8, i8* %l2
  %t52 = icmp eq i8 %t50, %t51
  %t53 = load double, double* %l0
  %t54 = load double, double* %l1
  %t55 = load i8, i8* %l2
  %t56 = load double, double* %l3
  %t57 = load i8, i8* %l4
  br i1 %t52, label %then17, label %merge18
then17:
  %t58 = load double, double* %l3
  store double %t58, double* %l1
  br label %afterloop12
merge18:
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch11
loop.latch11:
  %t62 = load double, double* %l3
  %t63 = load double, double* %l1
  br label %loop.header9
afterloop12:
  br label %merge8
else7:
  %t66 = load i8, i8* %l2
  %t67 = icmp eq i8 %t66, 40
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = load i8, i8* %l2
  br i1 %t67, label %then19, label %else20
then19:
  %t71 = load double, double* %l0
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l0
  br label %merge21
else20:
  %t74 = load i8, i8* %l2
  %t75 = icmp eq i8 %t74, 41
  %t76 = load double, double* %l0
  %t77 = load double, double* %l1
  %t78 = load i8, i8* %l2
  br i1 %t75, label %then22, label %merge23
then22:
  %t79 = load double, double* %l0
  %t80 = sitofp i64 0 to double
  %t81 = fcmp ogt double %t79, %t80
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i8, i8* %l2
  br i1 %t81, label %then24, label %else25
then24:
  %t85 = load double, double* %l0
  %t86 = sitofp i64 1 to double
  %t87 = fsub double %t85, %t86
  store double %t87, double* %l0
  %t88 = load double, double* %l0
  %t89 = sitofp i64 0 to double
  %t90 = fcmp oeq double %t88, %t89
  %t91 = load double, double* %l0
  %t92 = load double, double* %l1
  %t93 = load i8, i8* %l2
  br i1 %t90, label %then27, label %merge28
then27:
  %t94 = load double, double* %l1
  ret double %t94
merge28:
  br label %merge26
else25:
  %t95 = sitofp i64 -1 to double
  ret double %t95
merge26:
  br label %merge23
merge23:
  %t96 = phi double [ %t87, %then22 ], [ %t76, %else20 ]
  store double %t96, double* %l0
  br label %merge21
merge21:
  %t97 = phi double [ %t73, %then19 ], [ %t87, %else20 ]
  store double %t97, double* %l0
  br label %merge8
merge8:
  %t98 = phi double [ %t58, %then6 ], [ %t19, %else7 ]
  %t99 = phi double [ %t18, %then6 ], [ %t73, %else7 ]
  store double %t98, double* %l1
  store double %t99, double* %l0
  %t100 = load double, double* %l1
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l1
  br label %loop.latch2
loop.latch2:
  %t103 = load double, double* %l1
  %t104 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t107 = sitofp i64 -1 to double
  ret double %t107
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
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp eq i64 %t36, 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load i8*, i8** %l2
  %t41 = load i8*, i8** %l3
  %t42 = load double, double* %l4
  br i1 %t37, label %then2, label %merge3
then2:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s44 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.44, i32 0, i32 0
  %t45 = load i8*, i8** %l1
  %t46 = add i8* %s44, %t45
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  ret %EnumParseResult zeroinitializer
merge3:
  %t48 = alloca [0 x %NativeEnumVariant]
  %t49 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* %t48, i32 0, i32 0
  %t50 = alloca { %NativeEnumVariant*, i64 }
  %t51 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t50, i32 0, i32 0
  store %NativeEnumVariant* %t49, %NativeEnumVariant** %t51
  %t52 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { %NativeEnumVariant*, i64 }* %t50, { %NativeEnumVariant*, i64 }** %l5
  %t53 = alloca [0 x %NativeEnumVariantLayout]
  %t54 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t53, i32 0, i32 0
  %t55 = alloca { %NativeEnumVariantLayout*, i64 }
  %t56 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t55, i32 0, i32 0
  store %NativeEnumVariantLayout* %t54, %NativeEnumVariantLayout** %t56
  %t57 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %NativeEnumVariantLayout*, i64 }* %t55, { %NativeEnumVariantLayout*, i64 }** %l6
  %t58 = sitofp i64 0 to double
  store double %t58, double* %l7
  %t59 = sitofp i64 0 to double
  store double %t59, double* %l8
  %s60 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.60, i32 0, i32 0
  store i8* %s60, i8** %l9
  %t61 = sitofp i64 0 to double
  store double %t61, double* %l10
  %t62 = sitofp i64 0 to double
  store double %t62, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %start_index, %t63
  store double %t64, double* %l14
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l1
  %t67 = load i8*, i8** %l2
  %t68 = load i8*, i8** %l3
  %t69 = load double, double* %l4
  %t70 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t71 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t72 = load double, double* %l7
  %t73 = load double, double* %l8
  %t74 = load i8*, i8** %l9
  %t75 = load double, double* %l10
  %t76 = load double, double* %l11
  %t77 = load i1, i1* %l12
  %t78 = load i1, i1* %l13
  %t79 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t686 = phi { i8**, i64 }* [ %t65, %entry ], [ %t676, %loop.latch6 ]
  %t687 = phi double [ %t79, %entry ], [ %t677, %loop.latch6 ]
  %t688 = phi double [ %t72, %entry ], [ %t678, %loop.latch6 ]
  %t689 = phi double [ %t73, %entry ], [ %t679, %loop.latch6 ]
  %t690 = phi i8* [ %t74, %entry ], [ %t680, %loop.latch6 ]
  %t691 = phi double [ %t75, %entry ], [ %t681, %loop.latch6 ]
  %t692 = phi double [ %t76, %entry ], [ %t682, %loop.latch6 ]
  %t693 = phi i1 [ %t77, %entry ], [ %t683, %loop.latch6 ]
  %t694 = phi { %NativeEnumVariantLayout*, i64 }* [ %t71, %entry ], [ %t684, %loop.latch6 ]
  %t695 = phi i1 [ %t78, %entry ], [ %t685, %loop.latch6 ]
  store { i8**, i64 }* %t686, { i8**, i64 }** %l0
  store double %t687, double* %l14
  store double %t688, double* %l7
  store double %t689, double* %l8
  store i8* %t690, i8** %l9
  store double %t691, double* %l10
  store double %t692, double* %l11
  store i1 %t693, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t694, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t695, i1* %l13
  br label %loop.body5
loop.body5:
  %t80 = load double, double* %l14
  %t81 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t82 = extractvalue { i8**, i64 } %t81, 1
  %t83 = sitofp i64 %t82 to double
  %t84 = fcmp oge double %t80, %t83
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load i8*, i8** %l1
  %t87 = load i8*, i8** %l2
  %t88 = load i8*, i8** %l3
  %t89 = load double, double* %l4
  %t90 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t91 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t92 = load double, double* %l7
  %t93 = load double, double* %l8
  %t94 = load i8*, i8** %l9
  %t95 = load double, double* %l10
  %t96 = load double, double* %l11
  %t97 = load i1, i1* %l12
  %t98 = load i1, i1* %l13
  %t99 = load double, double* %l14
  br i1 %t84, label %then8, label %merge9
then8:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s101 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.101, i32 0, i32 0
  %t102 = load i8*, i8** %l3
  %t103 = add i8* %s101, %t102
  %t104 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* %t103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  store i8* null, i8** %l15
  %t105 = load i1, i1* %l12
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load i8*, i8** %l2
  %t109 = load i8*, i8** %l3
  %t110 = load double, double* %l4
  %t111 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t112 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t113 = load double, double* %l7
  %t114 = load double, double* %l8
  %t115 = load i8*, i8** %l9
  %t116 = load double, double* %l10
  %t117 = load double, double* %l11
  %t118 = load i1, i1* %l12
  %t119 = load i1, i1* %l13
  %t120 = load double, double* %l14
  %t121 = load i8*, i8** %l15
  br i1 %t105, label %then10, label %merge11
then10:
  br label %merge11
merge11:
  %t122 = phi i8* [ null, %then10 ], [ %t121, %then8 ]
  store i8* %t122, i8** %l15
  %t123 = load i8*, i8** %l3
  %t124 = insertvalue %NativeEnum undef, i8* %t123, 0
  %t125 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t126 = bitcast { %NativeEnumVariant*, i64 }* %t125 to { i8**, i64 }*
  %t127 = insertvalue %NativeEnum %t124, { i8**, i64 }* %t126, 1
  %t128 = load i8*, i8** %l15
  %t129 = insertvalue %NativeEnum %t127, i8* %t128, 2
  %t130 = insertvalue %EnumParseResult undef, i8* null, 0
  %t131 = load double, double* %l14
  %t132 = insertvalue %EnumParseResult %t130, double %t131, 1
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = insertvalue %EnumParseResult %t132, { i8**, i64 }* %t133, 2
  ret %EnumParseResult %t134
merge9:
  %t135 = load double, double* %l14
  %t136 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t137 = extractvalue { i8**, i64 } %t136, 0
  %t138 = extractvalue { i8**, i64 } %t136, 1
  %t139 = icmp uge i64 %t135, %t138
  ; bounds check: %t139 (if true, out of bounds)
  %t140 = getelementptr i8*, i8** %t137, i64 %t135
  %t141 = load i8*, i8** %t140
  %t142 = call i8* @trim_text(i8* %t141)
  store i8* %t142, i8** %l16
  %t144 = load i8*, i8** %l16
  %t145 = call i64 @sailfin_runtime_string_length(i8* %t144)
  %t146 = icmp eq i64 %t145, 0
  br label %logical_or_entry_143

logical_or_entry_143:
  br i1 %t146, label %logical_or_merge_143, label %logical_or_right_143

logical_or_right_143:
  %t147 = load i8*, i8** %l16
  %t148 = call i1 @starts_with(i8* %t147, i8* null)
  br label %logical_or_right_end_143

logical_or_right_end_143:
  br label %logical_or_merge_143

logical_or_merge_143:
  %t149 = phi i1 [ true, %logical_or_entry_143 ], [ %t148, %logical_or_right_end_143 ]
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
  %t165 = load i8*, i8** %l16
  br i1 %t149, label %then12, label %merge13
then12:
  %t166 = load double, double* %l14
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l14
  br label %loop.latch6
merge13:
  %t169 = load i8*, i8** %l16
  %s170 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.170, i32 0, i32 0
  %t171 = icmp eq i8* %t169, %s170
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t173 = load i8*, i8** %l1
  %t174 = load i8*, i8** %l2
  %t175 = load i8*, i8** %l3
  %t176 = load double, double* %l4
  %t177 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t178 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t179 = load double, double* %l7
  %t180 = load double, double* %l8
  %t181 = load i8*, i8** %l9
  %t182 = load double, double* %l10
  %t183 = load double, double* %l11
  %t184 = load i1, i1* %l12
  %t185 = load i1, i1* %l13
  %t186 = load double, double* %l14
  %t187 = load i8*, i8** %l16
  br i1 %t171, label %then14, label %merge15
then14:
  %t188 = load double, double* %l14
  %t189 = sitofp i64 1 to double
  %t190 = fadd double %t188, %t189
  store double %t190, double* %l14
  br label %loop.latch6
merge15:
  %t191 = load i8*, i8** %l16
  %s192 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.192, i32 0, i32 0
  %t193 = call i1 @starts_with(i8* %t191, i8* %s192)
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load i8*, i8** %l1
  %t196 = load i8*, i8** %l2
  %t197 = load i8*, i8** %l3
  %t198 = load double, double* %l4
  %t199 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t200 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t201 = load double, double* %l7
  %t202 = load double, double* %l8
  %t203 = load i8*, i8** %l9
  %t204 = load double, double* %l10
  %t205 = load double, double* %l11
  %t206 = load i1, i1* %l12
  %t207 = load i1, i1* %l13
  %t208 = load double, double* %l14
  %t209 = load i8*, i8** %l16
  br i1 %t193, label %then16, label %merge17
then16:
  %t210 = load i8*, i8** %l16
  %s211 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.211, i32 0, i32 0
  %t212 = call i8* @strip_prefix(i8* %t210, i8* %s211)
  store i8* %t212, i8** %l17
  %t213 = load i8*, i8** %l17
  %s214 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.214, i32 0, i32 0
  %t215 = call i1 @starts_with(i8* %t213, i8* %s214)
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t217 = load i8*, i8** %l1
  %t218 = load i8*, i8** %l2
  %t219 = load i8*, i8** %l3
  %t220 = load double, double* %l4
  %t221 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t222 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t223 = load double, double* %l7
  %t224 = load double, double* %l8
  %t225 = load i8*, i8** %l9
  %t226 = load double, double* %l10
  %t227 = load double, double* %l11
  %t228 = load i1, i1* %l12
  %t229 = load i1, i1* %l13
  %t230 = load double, double* %l14
  %t231 = load i8*, i8** %l16
  %t232 = load i8*, i8** %l17
  br i1 %t215, label %then18, label %merge19
then18:
  %t233 = load i8*, i8** %l17
  %s234 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.234, i32 0, i32 0
  %t235 = call i8* @strip_prefix(i8* %t233, i8* %s234)
  %t236 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t235)
  store %EnumLayoutHeaderParse %t236, %EnumLayoutHeaderParse* %l18
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t238 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t239 = extractvalue %EnumLayoutHeaderParse %t238, 7
  %t240 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t237, { i8**, i64 }* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  %t241 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t242 = extractvalue %EnumLayoutHeaderParse %t241, 0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t244 = load i8*, i8** %l1
  %t245 = load i8*, i8** %l2
  %t246 = load i8*, i8** %l3
  %t247 = load double, double* %l4
  %t248 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t249 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t250 = load double, double* %l7
  %t251 = load double, double* %l8
  %t252 = load i8*, i8** %l9
  %t253 = load double, double* %l10
  %t254 = load double, double* %l11
  %t255 = load i1, i1* %l12
  %t256 = load i1, i1* %l13
  %t257 = load double, double* %l14
  %t258 = load i8*, i8** %l16
  %t259 = load i8*, i8** %l17
  %t260 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t242, label %then20, label %merge21
then20:
  %t261 = load i1, i1* %l12
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t263 = load i8*, i8** %l1
  %t264 = load i8*, i8** %l2
  %t265 = load i8*, i8** %l3
  %t266 = load double, double* %l4
  %t267 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t268 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t269 = load double, double* %l7
  %t270 = load double, double* %l8
  %t271 = load i8*, i8** %l9
  %t272 = load double, double* %l10
  %t273 = load double, double* %l11
  %t274 = load i1, i1* %l12
  %t275 = load i1, i1* %l13
  %t276 = load double, double* %l14
  %t277 = load i8*, i8** %l16
  %t278 = load i8*, i8** %l17
  %t279 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t261, label %then22, label %else23
then22:
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s281 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.281, i32 0, i32 0
  %t282 = load i8*, i8** %l3
  %t283 = add i8* %s281, %t282
  %t284 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t280, i8* %t283)
  store { i8**, i64 }* %t284, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t285 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t286 = extractvalue %EnumLayoutHeaderParse %t285, 2
  store double %t286, double* %l7
  %t287 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t288 = extractvalue %EnumLayoutHeaderParse %t287, 3
  store double %t288, double* %l8
  %t289 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t290 = extractvalue %EnumLayoutHeaderParse %t289, 4
  store i8* %t290, i8** %l9
  %t291 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t292 = extractvalue %EnumLayoutHeaderParse %t291, 5
  store double %t292, double* %l10
  %t293 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t294 = extractvalue %EnumLayoutHeaderParse %t293, 6
  store double %t294, double* %l11
  store i1 1, i1* %l12
  br label %merge24
merge24:
  %t295 = phi { i8**, i64 }* [ %t284, %then22 ], [ %t262, %else23 ]
  %t296 = phi double [ %t269, %then22 ], [ %t286, %else23 ]
  %t297 = phi double [ %t270, %then22 ], [ %t288, %else23 ]
  %t298 = phi i8* [ %t271, %then22 ], [ %t290, %else23 ]
  %t299 = phi double [ %t272, %then22 ], [ %t292, %else23 ]
  %t300 = phi double [ %t273, %then22 ], [ %t294, %else23 ]
  %t301 = phi i1 [ %t274, %then22 ], [ 1, %else23 ]
  store { i8**, i64 }* %t295, { i8**, i64 }** %l0
  store double %t296, double* %l7
  store double %t297, double* %l8
  store i8* %t298, i8** %l9
  store double %t299, double* %l10
  store double %t300, double* %l11
  store i1 %t301, i1* %l12
  br label %merge21
merge21:
  %t302 = phi { i8**, i64 }* [ %t284, %then20 ], [ %t243, %then18 ]
  %t303 = phi double [ %t286, %then20 ], [ %t250, %then18 ]
  %t304 = phi double [ %t288, %then20 ], [ %t251, %then18 ]
  %t305 = phi i8* [ %t290, %then20 ], [ %t252, %then18 ]
  %t306 = phi double [ %t292, %then20 ], [ %t253, %then18 ]
  %t307 = phi double [ %t294, %then20 ], [ %t254, %then18 ]
  %t308 = phi i1 [ 1, %then20 ], [ %t255, %then18 ]
  store { i8**, i64 }* %t302, { i8**, i64 }** %l0
  store double %t303, double* %l7
  store double %t304, double* %l8
  store i8* %t305, i8** %l9
  store double %t306, double* %l10
  store double %t307, double* %l11
  store i1 %t308, i1* %l12
  %t309 = load double, double* %l14
  %t310 = sitofp i64 1 to double
  %t311 = fadd double %t309, %t310
  store double %t311, double* %l14
  br label %loop.latch6
merge19:
  %t312 = load i8*, i8** %l17
  %s313 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.313, i32 0, i32 0
  %t314 = call i1 @starts_with(i8* %t312, i8* %s313)
  %t315 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t316 = load i8*, i8** %l1
  %t317 = load i8*, i8** %l2
  %t318 = load i8*, i8** %l3
  %t319 = load double, double* %l4
  %t320 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t321 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t322 = load double, double* %l7
  %t323 = load double, double* %l8
  %t324 = load i8*, i8** %l9
  %t325 = load double, double* %l10
  %t326 = load double, double* %l11
  %t327 = load i1, i1* %l12
  %t328 = load i1, i1* %l13
  %t329 = load double, double* %l14
  %t330 = load i8*, i8** %l16
  %t331 = load i8*, i8** %l17
  br i1 %t314, label %then25, label %merge26
then25:
  %t332 = load i8*, i8** %l17
  %s333 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.333, i32 0, i32 0
  %t334 = call i8* @strip_prefix(i8* %t332, i8* %s333)
  %t335 = load i8*, i8** %l3
  %t336 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t334, i8* %t335)
  store %EnumLayoutVariantParse %t336, %EnumLayoutVariantParse* %l19
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t338 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t339 = extractvalue %EnumLayoutVariantParse %t338, 2
  %t340 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t337, { i8**, i64 }* %t339)
  store { i8**, i64 }* %t340, { i8**, i64 }** %l0
  %t341 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t342 = extractvalue %EnumLayoutVariantParse %t341, 0
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t344 = load i8*, i8** %l1
  %t345 = load i8*, i8** %l2
  %t346 = load i8*, i8** %l3
  %t347 = load double, double* %l4
  %t348 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t349 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t350 = load double, double* %l7
  %t351 = load double, double* %l8
  %t352 = load i8*, i8** %l9
  %t353 = load double, double* %l10
  %t354 = load double, double* %l11
  %t355 = load i1, i1* %l12
  %t356 = load i1, i1* %l13
  %t357 = load double, double* %l14
  %t358 = load i8*, i8** %l16
  %t359 = load i8*, i8** %l17
  %t360 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t342, label %then27, label %merge28
then27:
  %t361 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t362 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t363 = extractvalue %EnumLayoutVariantParse %t362, 1
  store double 0.0, double* %l20
  %t364 = load double, double* %l20
  %t365 = sitofp i64 0 to double
  %t366 = fcmp oge double %t364, %t365
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t368 = load i8*, i8** %l1
  %t369 = load i8*, i8** %l2
  %t370 = load i8*, i8** %l3
  %t371 = load double, double* %l4
  %t372 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t373 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t374 = load double, double* %l7
  %t375 = load double, double* %l8
  %t376 = load i8*, i8** %l9
  %t377 = load double, double* %l10
  %t378 = load double, double* %l11
  %t379 = load i1, i1* %l12
  %t380 = load i1, i1* %l13
  %t381 = load double, double* %l14
  %t382 = load i8*, i8** %l16
  %t383 = load i8*, i8** %l17
  %t384 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t385 = load double, double* %l20
  br i1 %t366, label %then29, label %else30
then29:
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s387 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.387, i32 0, i32 0
  %t388 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t389 = extractvalue %EnumLayoutVariantParse %t388, 1
  br label %merge31
else30:
  %t390 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t391 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t392 = extractvalue %EnumLayoutVariantParse %t391, 1
  %t393 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t390, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t393, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t394 = phi { i8**, i64 }* [ null, %then29 ], [ %t367, %else30 ]
  %t395 = phi { %NativeEnumVariantLayout*, i64 }* [ %t373, %then29 ], [ %t393, %else30 ]
  store { i8**, i64 }* %t394, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t395, { %NativeEnumVariantLayout*, i64 }** %l6
  %t396 = load i1, i1* %l12
  %t397 = xor i1 %t396, 1
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t399 = load i8*, i8** %l1
  %t400 = load i8*, i8** %l2
  %t401 = load i8*, i8** %l3
  %t402 = load double, double* %l4
  %t403 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t404 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t405 = load double, double* %l7
  %t406 = load double, double* %l8
  %t407 = load i8*, i8** %l9
  %t408 = load double, double* %l10
  %t409 = load double, double* %l11
  %t410 = load i1, i1* %l12
  %t411 = load i1, i1* %l13
  %t412 = load double, double* %l14
  %t413 = load i8*, i8** %l16
  %t414 = load i8*, i8** %l17
  %t415 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t416 = load double, double* %l20
  br i1 %t397, label %then32, label %merge33
then32:
  %t417 = load i1, i1* %l13
  %t418 = xor i1 %t417, 1
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t420 = load i8*, i8** %l1
  %t421 = load i8*, i8** %l2
  %t422 = load i8*, i8** %l3
  %t423 = load double, double* %l4
  %t424 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t425 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t426 = load double, double* %l7
  %t427 = load double, double* %l8
  %t428 = load i8*, i8** %l9
  %t429 = load double, double* %l10
  %t430 = load double, double* %l11
  %t431 = load i1, i1* %l12
  %t432 = load i1, i1* %l13
  %t433 = load double, double* %l14
  %t434 = load i8*, i8** %l16
  %t435 = load i8*, i8** %l17
  %t436 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t437 = load double, double* %l20
  br i1 %t418, label %then34, label %merge35
then34:
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s439 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.439, i32 0, i32 0
  %t440 = load i8*, i8** %l3
  %t441 = add i8* %s439, %t440
  %s442 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.442, i32 0, i32 0
  %t443 = add i8* %t441, %s442
  %t444 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t438, i8* %t443)
  store { i8**, i64 }* %t444, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge35
merge35:
  %t445 = phi { i8**, i64 }* [ %t444, %then34 ], [ %t419, %then32 ]
  %t446 = phi i1 [ 1, %then34 ], [ %t432, %then32 ]
  store { i8**, i64 }* %t445, { i8**, i64 }** %l0
  store i1 %t446, i1* %l13
  br label %merge33
merge33:
  %t447 = phi { i8**, i64 }* [ %t444, %then32 ], [ %t398, %then27 ]
  %t448 = phi i1 [ 1, %then32 ], [ %t411, %then27 ]
  store { i8**, i64 }* %t447, { i8**, i64 }** %l0
  store i1 %t448, i1* %l13
  br label %merge28
merge28:
  %t449 = phi { i8**, i64 }* [ null, %then27 ], [ %t343, %then25 ]
  %t450 = phi { %NativeEnumVariantLayout*, i64 }* [ %t393, %then27 ], [ %t349, %then25 ]
  %t451 = phi { i8**, i64 }* [ %t444, %then27 ], [ %t343, %then25 ]
  %t452 = phi i1 [ 1, %then27 ], [ %t356, %then25 ]
  store { i8**, i64 }* %t449, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t450, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t451, { i8**, i64 }** %l0
  store i1 %t452, i1* %l13
  %t453 = load double, double* %l14
  %t454 = sitofp i64 1 to double
  %t455 = fadd double %t453, %t454
  store double %t455, double* %l14
  br label %loop.latch6
merge26:
  %t456 = load i8*, i8** %l17
  %s457 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.457, i32 0, i32 0
  %t458 = call i1 @starts_with(i8* %t456, i8* %s457)
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t460 = load i8*, i8** %l1
  %t461 = load i8*, i8** %l2
  %t462 = load i8*, i8** %l3
  %t463 = load double, double* %l4
  %t464 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t465 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t466 = load double, double* %l7
  %t467 = load double, double* %l8
  %t468 = load i8*, i8** %l9
  %t469 = load double, double* %l10
  %t470 = load double, double* %l11
  %t471 = load i1, i1* %l12
  %t472 = load i1, i1* %l13
  %t473 = load double, double* %l14
  %t474 = load i8*, i8** %l16
  %t475 = load i8*, i8** %l17
  br i1 %t458, label %then36, label %merge37
then36:
  %t476 = load i8*, i8** %l17
  %s477 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.477, i32 0, i32 0
  %t478 = call i8* @strip_prefix(i8* %t476, i8* %s477)
  %t479 = load i8*, i8** %l3
  %t480 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t478, i8* %t479)
  store %EnumLayoutPayloadParse %t480, %EnumLayoutPayloadParse* %l21
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t482 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t483 = extractvalue %EnumLayoutPayloadParse %t482, 3
  %t484 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t481, { i8**, i64 }* %t483)
  store { i8**, i64 }* %t484, { i8**, i64 }** %l0
  %t485 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t486 = extractvalue %EnumLayoutPayloadParse %t485, 0
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t488 = load i8*, i8** %l1
  %t489 = load i8*, i8** %l2
  %t490 = load i8*, i8** %l3
  %t491 = load double, double* %l4
  %t492 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t493 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t494 = load double, double* %l7
  %t495 = load double, double* %l8
  %t496 = load i8*, i8** %l9
  %t497 = load double, double* %l10
  %t498 = load double, double* %l11
  %t499 = load i1, i1* %l12
  %t500 = load i1, i1* %l13
  %t501 = load double, double* %l14
  %t502 = load i8*, i8** %l16
  %t503 = load i8*, i8** %l17
  %t504 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t486, label %then38, label %merge39
then38:
  %t505 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t506 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t507 = extractvalue %EnumLayoutPayloadParse %t506, 1
  %t508 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t505, i8* %t507)
  store double %t508, double* %l22
  %t509 = load double, double* %l22
  %t510 = sitofp i64 0 to double
  %t511 = fcmp olt double %t509, %t510
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
  br i1 %t511, label %then40, label %else41
then40:
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s532 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.532, i32 0, i32 0
  %t533 = load i8*, i8** %l3
  %t534 = add i8* %s532, %t533
  %s535 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.535, i32 0, i32 0
  %t536 = add i8* %t534, %s535
  %t537 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t538 = extractvalue %EnumLayoutPayloadParse %t537, 1
  %t539 = add i8* %t536, %t538
  %t540 = getelementptr i8, i8* %t539, i64 0
  %t541 = load i8, i8* %t540
  %t542 = add i8 %t541, 96
  %t543 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t531, i8* null)
  store { i8**, i64 }* %t543, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t544 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t545 = load double, double* %l22
  %t546 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t547 = extractvalue %EnumLayoutPayloadParse %t546, 2
  %t548 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t544, double %t545, %NativeStructLayoutField zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t548, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t549 = phi { i8**, i64 }* [ %t543, %then40 ], [ %t512, %else41 ]
  %t550 = phi { %NativeEnumVariantLayout*, i64 }* [ %t518, %then40 ], [ %t548, %else41 ]
  store { i8**, i64 }* %t549, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t550, { %NativeEnumVariantLayout*, i64 }** %l6
  %t551 = load i1, i1* %l12
  %t552 = xor i1 %t551, 1
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t554 = load i8*, i8** %l1
  %t555 = load i8*, i8** %l2
  %t556 = load i8*, i8** %l3
  %t557 = load double, double* %l4
  %t558 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t559 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t560 = load double, double* %l7
  %t561 = load double, double* %l8
  %t562 = load i8*, i8** %l9
  %t563 = load double, double* %l10
  %t564 = load double, double* %l11
  %t565 = load i1, i1* %l12
  %t566 = load i1, i1* %l13
  %t567 = load double, double* %l14
  %t568 = load i8*, i8** %l16
  %t569 = load i8*, i8** %l17
  %t570 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t571 = load double, double* %l22
  br i1 %t552, label %then43, label %merge44
then43:
  %t572 = load i1, i1* %l13
  %t573 = xor i1 %t572, 1
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t575 = load i8*, i8** %l1
  %t576 = load i8*, i8** %l2
  %t577 = load i8*, i8** %l3
  %t578 = load double, double* %l4
  %t579 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t580 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t581 = load double, double* %l7
  %t582 = load double, double* %l8
  %t583 = load i8*, i8** %l9
  %t584 = load double, double* %l10
  %t585 = load double, double* %l11
  %t586 = load i1, i1* %l12
  %t587 = load i1, i1* %l13
  %t588 = load double, double* %l14
  %t589 = load i8*, i8** %l16
  %t590 = load i8*, i8** %l17
  %t591 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t592 = load double, double* %l22
  br i1 %t573, label %then45, label %merge46
then45:
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s594 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.594, i32 0, i32 0
  %t595 = load i8*, i8** %l3
  %t596 = add i8* %s594, %t595
  %s597 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.597, i32 0, i32 0
  %t598 = add i8* %t596, %s597
  %t599 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t593, i8* %t598)
  store { i8**, i64 }* %t599, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge46
merge46:
  %t600 = phi { i8**, i64 }* [ %t599, %then45 ], [ %t574, %then43 ]
  %t601 = phi i1 [ 1, %then45 ], [ %t587, %then43 ]
  store { i8**, i64 }* %t600, { i8**, i64 }** %l0
  store i1 %t601, i1* %l13
  br label %merge44
merge44:
  %t602 = phi { i8**, i64 }* [ %t599, %then43 ], [ %t553, %then38 ]
  %t603 = phi i1 [ 1, %then43 ], [ %t566, %then38 ]
  store { i8**, i64 }* %t602, { i8**, i64 }** %l0
  store i1 %t603, i1* %l13
  br label %merge39
merge39:
  %t604 = phi { i8**, i64 }* [ %t543, %then38 ], [ %t487, %then36 ]
  %t605 = phi { %NativeEnumVariantLayout*, i64 }* [ %t548, %then38 ], [ %t493, %then36 ]
  %t606 = phi { i8**, i64 }* [ %t599, %then38 ], [ %t487, %then36 ]
  %t607 = phi i1 [ 1, %then38 ], [ %t500, %then36 ]
  store { i8**, i64 }* %t604, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t605, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t606, { i8**, i64 }** %l0
  store i1 %t607, i1* %l13
  %t608 = load double, double* %l14
  %t609 = sitofp i64 1 to double
  %t610 = fadd double %t608, %t609
  store double %t610, double* %l14
  br label %loop.latch6
merge37:
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s612 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.612, i32 0, i32 0
  %t613 = load i8*, i8** %l16
  %t614 = add i8* %s612, %t613
  %t615 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t611, i8* %t614)
  store { i8**, i64 }* %t615, { i8**, i64 }** %l0
  %t616 = load double, double* %l14
  %t617 = sitofp i64 1 to double
  %t618 = fadd double %t616, %t617
  store double %t618, double* %l14
  br label %loop.latch6
merge17:
  %t619 = load i8*, i8** %l16
  %s620 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.620, i32 0, i32 0
  %t621 = icmp eq i8* %t619, %s620
  %t622 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t623 = load i8*, i8** %l1
  %t624 = load i8*, i8** %l2
  %t625 = load i8*, i8** %l3
  %t626 = load double, double* %l4
  %t627 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t628 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t629 = load double, double* %l7
  %t630 = load double, double* %l8
  %t631 = load i8*, i8** %l9
  %t632 = load double, double* %l10
  %t633 = load double, double* %l11
  %t634 = load i1, i1* %l12
  %t635 = load i1, i1* %l13
  %t636 = load double, double* %l14
  %t637 = load i8*, i8** %l16
  br i1 %t621, label %then47, label %merge48
then47:
  %t638 = load double, double* %l14
  %t639 = sitofp i64 1 to double
  %t640 = fadd double %t638, %t639
  store double %t640, double* %l14
  br label %afterloop7
merge48:
  %t641 = load i8*, i8** %l16
  %s642 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.642, i32 0, i32 0
  %t643 = call i1 @starts_with(i8* %t641, i8* %s642)
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t645 = load i8*, i8** %l1
  %t646 = load i8*, i8** %l2
  %t647 = load i8*, i8** %l3
  %t648 = load double, double* %l4
  %t649 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t650 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t651 = load double, double* %l7
  %t652 = load double, double* %l8
  %t653 = load i8*, i8** %l9
  %t654 = load double, double* %l10
  %t655 = load double, double* %l11
  %t656 = load i1, i1* %l12
  %t657 = load i1, i1* %l13
  %t658 = load double, double* %l14
  %t659 = load i8*, i8** %l16
  br i1 %t643, label %then49, label %merge50
then49:
  %t660 = load i8*, i8** %l16
  %s661 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.661, i32 0, i32 0
  %t662 = call i8* @strip_prefix(i8* %t660, i8* %s661)
  %t663 = call double @parse_enum_variant_line(i8* %t662)
  store double %t663, double* %l23
  %t664 = load double, double* %l23
  %t665 = load double, double* %l14
  %t666 = sitofp i64 1 to double
  %t667 = fadd double %t665, %t666
  store double %t667, double* %l14
  br label %loop.latch6
merge50:
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s669 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.669, i32 0, i32 0
  %t670 = load i8*, i8** %l16
  %t671 = add i8* %s669, %t670
  %t672 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t668, i8* %t671)
  store { i8**, i64 }* %t672, { i8**, i64 }** %l0
  %t673 = load double, double* %l14
  %t674 = sitofp i64 1 to double
  %t675 = fadd double %t673, %t674
  store double %t675, double* %l14
  br label %loop.latch6
loop.latch6:
  %t676 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t677 = load double, double* %l14
  %t678 = load double, double* %l7
  %t679 = load double, double* %l8
  %t680 = load i8*, i8** %l9
  %t681 = load double, double* %l10
  %t682 = load double, double* %l11
  %t683 = load i1, i1* %l12
  %t684 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t685 = load i1, i1* %l13
  br label %loop.header4
afterloop7:
  store i8* null, i8** %l24
  %t696 = load i1, i1* %l12
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t698 = load i8*, i8** %l1
  %t699 = load i8*, i8** %l2
  %t700 = load i8*, i8** %l3
  %t701 = load double, double* %l4
  %t702 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t703 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t704 = load double, double* %l7
  %t705 = load double, double* %l8
  %t706 = load i8*, i8** %l9
  %t707 = load double, double* %l10
  %t708 = load double, double* %l11
  %t709 = load i1, i1* %l12
  %t710 = load i1, i1* %l13
  %t711 = load double, double* %l14
  %t712 = load i8*, i8** %l24
  br i1 %t696, label %then51, label %merge52
then51:
  br label %merge52
merge52:
  %t713 = phi i8* [ null, %then51 ], [ %t712, %entry ]
  store i8* %t713, i8** %l24
  %t714 = load i8*, i8** %l3
  %t715 = insertvalue %NativeEnum undef, i8* %t714, 0
  %t716 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t717 = bitcast { %NativeEnumVariant*, i64 }* %t716 to { i8**, i64 }*
  %t718 = insertvalue %NativeEnum %t715, { i8**, i64 }* %t717, 1
  %t719 = load i8*, i8** %l24
  %t720 = insertvalue %NativeEnum %t718, i8* %t719, 2
  %t721 = insertvalue %EnumParseResult undef, i8* null, 0
  %t722 = load double, double* %l14
  %t723 = insertvalue %EnumParseResult %t721, double %t722, 1
  %t724 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t725 = insertvalue %EnumParseResult %t723, { i8**, i64 }* %t724, 2
  ret %EnumParseResult %t725
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
  %t74 = phi double [ %t10, %entry ], [ %t70, %loop.latch2 ]
  %t75 = phi { i8**, i64 }* [ %t8, %entry ], [ %t71, %loop.latch2 ]
  %t76 = phi i8* [ %t9, %entry ], [ %t72, %loop.latch2 ]
  %t77 = phi double [ %t11, %entry ], [ %t73, %loop.latch2 ]
  store double %t74, double* %l2
  store { i8**, i64 }* %t75, { i8**, i64 }** %l0
  store i8* %t76, i8** %l1
  store double %t77, double* %l3
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
  %t21 = getelementptr i8, i8* %text, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l4
  %t25 = load i8, i8* %l4
  %t26 = icmp eq i8 %t25, 123
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t26, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t27 = load i8, i8* %l4
  %t28 = icmp eq i8 %t27, 91
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t29 = phi i1 [ true, %logical_or_entry_24 ], [ %t28, %logical_or_right_end_24 ]
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t29, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t30 = load i8, i8* %l4
  %t31 = icmp eq i8 %t30, 40
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t32 = phi i1 [ true, %logical_or_entry_23 ], [ %t31, %logical_or_right_end_23 ]
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  %t37 = load i8, i8* %l4
  br i1 %t32, label %then6, label %else7
then6:
  %t38 = load double, double* %l2
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l2
  br label %merge8
else7:
  %t41 = load i8, i8* %l4
  br label %merge8
merge8:
  %t43 = phi double [ %t40, %then6 ], [ %t35, %else7 ]
  store double %t43, double* %l2
  %t45 = load i8, i8* %l4
  %t46 = icmp eq i8 %t45, 59
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t46, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t47 = load double, double* %l2
  %t48 = sitofp i64 0 to double
  %t49 = fcmp oeq double %t47, %t48
  br label %logical_and_right_end_44

logical_and_right_end_44:
  br label %logical_and_merge_44

logical_and_merge_44:
  %t50 = phi i1 [ false, %logical_and_entry_44 ], [ %t49, %logical_and_right_end_44 ]
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load double, double* %l2
  %t54 = load double, double* %l3
  %t55 = load i8, i8* %l4
  br i1 %t50, label %then9, label %else10
then9:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t56, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.59, i32 0, i32 0
  store i8* %s59, i8** %l1
  br label %merge11
else10:
  %t60 = load i8*, i8** %l1
  %t61 = load i8, i8* %l4
  %t62 = getelementptr i8, i8* %t60, i64 0
  %t63 = load i8, i8* %t62
  %t64 = add i8 %t63, %t61
  store i8* null, i8** %l1
  br label %merge11
merge11:
  %t65 = phi { i8**, i64 }* [ %t58, %then9 ], [ %t51, %else10 ]
  %t66 = phi i8* [ %s59, %then9 ], [ null, %else10 ]
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  store i8* %t66, i8** %l1
  %t67 = load double, double* %l3
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l3
  br label %loop.latch2
loop.latch2:
  %t70 = load double, double* %l2
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t78 = load i8*, i8** %l1
  %t79 = call i64 @sailfin_runtime_string_length(i8* %t78)
  %t80 = icmp sgt i64 %t79, 0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  br i1 %t80, label %then12, label %merge13
then12:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load i8*, i8** %l1
  %t87 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t85, i8* %t86)
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  br label %merge13
merge13:
  %t88 = phi { i8**, i64 }* [ %t87, %then12 ], [ %t81, %entry ]
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t89
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
  %t204 = phi i8* [ %t34, %entry ], [ %t196, %loop.latch4 ]
  %t205 = phi i1 [ %t31, %entry ], [ %t197, %loop.latch4 ]
  %t206 = phi i1 [ %t32, %entry ], [ %t198, %loop.latch4 ]
  %t207 = phi double [ %t35, %entry ], [ %t199, %loop.latch4 ]
  %t208 = phi { i8**, i64 }* [ %t30, %entry ], [ %t200, %loop.latch4 ]
  %t209 = phi i1 [ %t33, %entry ], [ %t201, %loop.latch4 ]
  %t210 = phi double [ %t36, %entry ], [ %t202, %loop.latch4 ]
  %t211 = phi double [ %t37, %entry ], [ %t203, %loop.latch4 ]
  store i8* %t204, i8** %l5
  store i1 %t205, i1* %l2
  store i1 %t206, i1* %l3
  store double %t207, double* %l6
  store { i8**, i64 }* %t208, { i8**, i64 }** %l1
  store i1 %t209, i1* %l4
  store double %t210, double* %l7
  store double %t211, double* %l8
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
  %t76 = call i64 @sailfin_runtime_string_length(i8* %t75)
  %t77 = call i8* @sailfin_runtime_substring(i8* %t74, i64 5, i64 %t76)
  store i8* %t77, i8** %l5
  store i1 1, i1* %l2
  br label %merge10
else9:
  %t78 = load i8*, i8** %l9
  %s79 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @starts_with(i8* %t78, i8* %s79)
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load i1, i1* %l2
  %t84 = load i1, i1* %l3
  %t85 = load i1, i1* %l4
  %t86 = load i8*, i8** %l5
  %t87 = load double, double* %l6
  %t88 = load double, double* %l7
  %t89 = load double, double* %l8
  %t90 = load i8*, i8** %l9
  br i1 %t80, label %then11, label %else12
then11:
  %t91 = load i8*, i8** %l9
  %t92 = load i8*, i8** %l9
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = call i8* @sailfin_runtime_substring(i8* %t91, i64 5, i64 %t93)
  store i8* %t94, i8** %l10
  %t95 = load i8*, i8** %l10
  %t96 = call %NumberParseResult @parse_decimal_number(i8* %t95)
  store %NumberParseResult %t96, %NumberParseResult* %l11
  %t97 = load %NumberParseResult, %NumberParseResult* %l11
  %t98 = extractvalue %NumberParseResult %t97, 0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load i1, i1* %l2
  %t102 = load i1, i1* %l3
  %t103 = load i1, i1* %l4
  %t104 = load i8*, i8** %l5
  %t105 = load double, double* %l6
  %t106 = load double, double* %l7
  %t107 = load double, double* %l8
  %t108 = load i8*, i8** %l9
  %t109 = load i8*, i8** %l10
  %t110 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t98, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t111 = load %NumberParseResult, %NumberParseResult* %l11
  %t112 = extractvalue %NumberParseResult %t111, 1
  store double %t112, double* %l6
  br label %merge16
else15:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s114 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.114, i32 0, i32 0
  %t115 = load i8*, i8** %l10
  %t116 = add i8* %s114, %t115
  %t117 = getelementptr i8, i8* %t116, i64 0
  %t118 = load i8, i8* %t117
  %t119 = add i8 %t118, 96
  %t120 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t113, i8* null)
  store { i8**, i64 }* %t120, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t121 = phi i1 [ 1, %then14 ], [ %t102, %else15 ]
  %t122 = phi double [ %t112, %then14 ], [ %t105, %else15 ]
  %t123 = phi { i8**, i64 }* [ %t100, %then14 ], [ %t120, %else15 ]
  store i1 %t121, i1* %l3
  store double %t122, double* %l6
  store { i8**, i64 }* %t123, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t124 = load i8*, i8** %l9
  %s125 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.125, i32 0, i32 0
  %t126 = call i1 @starts_with(i8* %t124, i8* %s125)
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = load i1, i1* %l2
  %t130 = load i1, i1* %l3
  %t131 = load i1, i1* %l4
  %t132 = load i8*, i8** %l5
  %t133 = load double, double* %l6
  %t134 = load double, double* %l7
  %t135 = load double, double* %l8
  %t136 = load i8*, i8** %l9
  br i1 %t126, label %then17, label %else18
then17:
  %t137 = load i8*, i8** %l9
  %t138 = load i8*, i8** %l9
  %t139 = call i64 @sailfin_runtime_string_length(i8* %t138)
  %t140 = call i8* @sailfin_runtime_substring(i8* %t137, i64 6, i64 %t139)
  store i8* %t140, i8** %l12
  %t141 = load i8*, i8** %l12
  %t142 = call %NumberParseResult @parse_decimal_number(i8* %t141)
  store %NumberParseResult %t142, %NumberParseResult* %l13
  %t143 = load %NumberParseResult, %NumberParseResult* %l13
  %t144 = extractvalue %NumberParseResult %t143, 0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load i1, i1* %l2
  %t148 = load i1, i1* %l3
  %t149 = load i1, i1* %l4
  %t150 = load i8*, i8** %l5
  %t151 = load double, double* %l6
  %t152 = load double, double* %l7
  %t153 = load double, double* %l8
  %t154 = load i8*, i8** %l9
  %t155 = load i8*, i8** %l12
  %t156 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t144, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t157 = load %NumberParseResult, %NumberParseResult* %l13
  %t158 = extractvalue %NumberParseResult %t157, 1
  store double %t158, double* %l7
  br label %merge22
else21:
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s160 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.160, i32 0, i32 0
  %t161 = load i8*, i8** %l12
  %t162 = add i8* %s160, %t161
  %t163 = getelementptr i8, i8* %t162, i64 0
  %t164 = load i8, i8* %t163
  %t165 = add i8 %t164, 96
  %t166 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t159, i8* null)
  store { i8**, i64 }* %t166, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t167 = phi i1 [ 1, %then20 ], [ %t149, %else21 ]
  %t168 = phi double [ %t158, %then20 ], [ %t152, %else21 ]
  %t169 = phi { i8**, i64 }* [ %t146, %then20 ], [ %t166, %else21 ]
  store i1 %t167, i1* %l4
  store double %t168, double* %l7
  store { i8**, i64 }* %t169, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s171 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.171, i32 0, i32 0
  %t172 = load i8*, i8** %l9
  %t173 = add i8* %s171, %t172
  %t174 = getelementptr i8, i8* %t173, i64 0
  %t175 = load i8, i8* %t174
  %t176 = add i8 %t175, 96
  %t177 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t170, i8* null)
  store { i8**, i64 }* %t177, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t178 = phi i1 [ 1, %then17 ], [ %t131, %else18 ]
  %t179 = phi double [ %t158, %then17 ], [ %t134, %else18 ]
  %t180 = phi { i8**, i64 }* [ %t166, %then17 ], [ %t177, %else18 ]
  store i1 %t178, i1* %l4
  store double %t179, double* %l7
  store { i8**, i64 }* %t180, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t181 = phi i1 [ 1, %then11 ], [ %t84, %else12 ]
  %t182 = phi double [ %t112, %then11 ], [ %t87, %else12 ]
  %t183 = phi { i8**, i64 }* [ %t120, %then11 ], [ %t166, %else12 ]
  %t184 = phi i1 [ %t85, %then11 ], [ 1, %else12 ]
  %t185 = phi double [ %t88, %then11 ], [ %t158, %else12 ]
  store i1 %t181, i1* %l3
  store double %t182, double* %l6
  store { i8**, i64 }* %t183, { i8**, i64 }** %l1
  store i1 %t184, i1* %l4
  store double %t185, double* %l7
  br label %merge10
merge10:
  %t186 = phi i8* [ %t77, %then8 ], [ %t69, %else9 ]
  %t187 = phi i1 [ 1, %then8 ], [ %t66, %else9 ]
  %t188 = phi i1 [ %t67, %then8 ], [ 1, %else9 ]
  %t189 = phi double [ %t70, %then8 ], [ %t112, %else9 ]
  %t190 = phi { i8**, i64 }* [ %t65, %then8 ], [ %t120, %else9 ]
  %t191 = phi i1 [ %t68, %then8 ], [ 1, %else9 ]
  %t192 = phi double [ %t71, %then8 ], [ %t158, %else9 ]
  store i8* %t186, i8** %l5
  store i1 %t187, i1* %l2
  store i1 %t188, i1* %l3
  store double %t189, double* %l6
  store { i8**, i64 }* %t190, { i8**, i64 }** %l1
  store i1 %t191, i1* %l4
  store double %t192, double* %l7
  %t193 = load double, double* %l8
  %t194 = sitofp i64 1 to double
  %t195 = fadd double %t193, %t194
  store double %t195, double* %l8
  br label %loop.latch4
loop.latch4:
  %t196 = load i8*, i8** %l5
  %t197 = load i1, i1* %l2
  %t198 = load i1, i1* %l3
  %t199 = load double, double* %l6
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t201 = load i1, i1* %l4
  %t202 = load double, double* %l7
  %t203 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t212 = load i1, i1* %l3
  %t213 = xor i1 %t212, 1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t216 = load i1, i1* %l2
  %t217 = load i1, i1* %l3
  %t218 = load i1, i1* %l4
  %t219 = load i8*, i8** %l5
  %t220 = load double, double* %l6
  %t221 = load double, double* %l7
  %t222 = load double, double* %l8
  br i1 %t213, label %then23, label %merge24
then23:
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s224 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.224, i32 0, i32 0
  %t225 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t223, i8* %s224)
  store { i8**, i64 }* %t225, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t226 = phi { i8**, i64 }* [ %t225, %then23 ], [ %t215, %entry ]
  store { i8**, i64 }* %t226, { i8**, i64 }** %l1
  %t227 = load i1, i1* %l4
  %t228 = xor i1 %t227, 1
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t231 = load i1, i1* %l2
  %t232 = load i1, i1* %l3
  %t233 = load i1, i1* %l4
  %t234 = load i8*, i8** %l5
  %t235 = load double, double* %l6
  %t236 = load double, double* %l7
  %t237 = load double, double* %l8
  br i1 %t228, label %then25, label %merge26
then25:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s239 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.239, i32 0, i32 0
  %t240 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %s239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t241 = phi { i8**, i64 }* [ %t240, %then25 ], [ %t230, %entry ]
  store { i8**, i64 }* %t241, { i8**, i64 }** %l1
  %t244 = load i1, i1* %l3
  br label %logical_and_entry_243

logical_and_entry_243:
  br i1 %t244, label %logical_and_right_243, label %logical_and_merge_243

logical_and_right_243:
  %t245 = load i1, i1* %l4
  br label %logical_and_right_end_243

logical_and_right_end_243:
  br label %logical_and_merge_243

logical_and_merge_243:
  %t246 = phi i1 [ false, %logical_and_entry_243 ], [ %t245, %logical_and_right_end_243 ]
  br label %logical_and_entry_242

logical_and_entry_242:
  br i1 %t246, label %logical_and_right_242, label %logical_and_merge_242

logical_and_right_242:
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load { i8**, i64 }, { i8**, i64 }* %t247
  %t249 = extractvalue { i8**, i64 } %t248, 1
  %t250 = icmp eq i64 %t249, 0
  br label %logical_and_right_end_242

logical_and_right_end_242:
  br label %logical_and_merge_242

logical_and_merge_242:
  %t251 = phi i1 [ false, %logical_and_entry_242 ], [ %t250, %logical_and_right_end_242 ]
  store i1 %t251, i1* %l14
  %t252 = load i1, i1* %l14
  %t253 = insertvalue %StructLayoutHeaderParse undef, i1 %t252, 0
  %t254 = load i8*, i8** %l5
  %t255 = insertvalue %StructLayoutHeaderParse %t253, i8* %t254, 1
  %t256 = load double, double* %l6
  %t257 = insertvalue %StructLayoutHeaderParse %t255, double %t256, 2
  %t258 = load double, double* %l7
  %t259 = insertvalue %StructLayoutHeaderParse %t257, double %t258, 3
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t261 = insertvalue %StructLayoutHeaderParse %t259, { i8**, i64 }* %t260, 4
  ret %StructLayoutHeaderParse %t261
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
  %t379 = phi i8* [ %t90, %entry ], [ %t370, %loop.latch8 ]
  %t380 = phi i1 [ %t91, %entry ], [ %t371, %loop.latch8 ]
  %t381 = phi double [ %t94, %entry ], [ %t372, %loop.latch8 ]
  %t382 = phi { i8**, i64 }* [ %t86, %entry ], [ %t373, %loop.latch8 ]
  %t383 = phi i1 [ %t92, %entry ], [ %t374, %loop.latch8 ]
  %t384 = phi double [ %t95, %entry ], [ %t375, %loop.latch8 ]
  %t385 = phi i1 [ %t93, %entry ], [ %t376, %loop.latch8 ]
  %t386 = phi double [ %t96, %entry ], [ %t377, %loop.latch8 ]
  %t387 = phi double [ %t97, %entry ], [ %t378, %loop.latch8 ]
  store i8* %t379, i8** %l5
  store i1 %t380, i1* %l6
  store double %t381, double* %l9
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  store i1 %t383, i1* %l7
  store double %t384, double* %l10
  store i1 %t385, i1* %l8
  store double %t386, double* %l11
  store double %t387, double* %l12
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
  %t119 = load { i8**, i64 }, { i8**, i64 }* %t117
  %t120 = extractvalue { i8**, i64 } %t119, 0
  %t121 = extractvalue { i8**, i64 } %t119, 1
  %t122 = icmp uge i64 %t118, %t121
  ; bounds check: %t122 (if true, out of bounds)
  %t123 = getelementptr i8*, i8** %t120, i64 %t118
  %t124 = load i8*, i8** %t123
  store i8* %t124, i8** %l13
  %t125 = load i8*, i8** %l13
  %s126 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.126, i32 0, i32 0
  %t127 = call i1 @starts_with(i8* %t125, i8* %s126)
  %t128 = load i8*, i8** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t132 = load i8*, i8** %l4
  %t133 = load i8*, i8** %l5
  %t134 = load i1, i1* %l6
  %t135 = load i1, i1* %l7
  %t136 = load i1, i1* %l8
  %t137 = load double, double* %l9
  %t138 = load double, double* %l10
  %t139 = load double, double* %l11
  %t140 = load double, double* %l12
  %t141 = load i8*, i8** %l13
  br i1 %t127, label %then12, label %else13
then12:
  %t142 = load i8*, i8** %l13
  %t143 = load i8*, i8** %l13
  %t144 = call i64 @sailfin_runtime_string_length(i8* %t143)
  %t145 = call i8* @sailfin_runtime_substring(i8* %t142, i64 5, i64 %t144)
  store i8* %t145, i8** %l5
  br label %merge14
else13:
  %t146 = load i8*, i8** %l13
  %s147 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.147, i32 0, i32 0
  %t148 = call i1 @starts_with(i8* %t146, i8* %s147)
  %t149 = load i8*, i8** %l0
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t151 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t153 = load i8*, i8** %l4
  %t154 = load i8*, i8** %l5
  %t155 = load i1, i1* %l6
  %t156 = load i1, i1* %l7
  %t157 = load i1, i1* %l8
  %t158 = load double, double* %l9
  %t159 = load double, double* %l10
  %t160 = load double, double* %l11
  %t161 = load double, double* %l12
  %t162 = load i8*, i8** %l13
  br i1 %t148, label %then15, label %else16
then15:
  %t163 = load i8*, i8** %l13
  %t164 = load i8*, i8** %l13
  %t165 = call i64 @sailfin_runtime_string_length(i8* %t164)
  %t166 = call i8* @sailfin_runtime_substring(i8* %t163, i64 7, i64 %t165)
  store i8* %t166, i8** %l14
  %t167 = load i8*, i8** %l14
  %t168 = call %NumberParseResult @parse_decimal_number(i8* %t167)
  store %NumberParseResult %t168, %NumberParseResult* %l15
  %t169 = load %NumberParseResult, %NumberParseResult* %l15
  %t170 = extractvalue %NumberParseResult %t169, 0
  %t171 = load i8*, i8** %l0
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t173 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t175 = load i8*, i8** %l4
  %t176 = load i8*, i8** %l5
  %t177 = load i1, i1* %l6
  %t178 = load i1, i1* %l7
  %t179 = load i1, i1* %l8
  %t180 = load double, double* %l9
  %t181 = load double, double* %l10
  %t182 = load double, double* %l11
  %t183 = load double, double* %l12
  %t184 = load i8*, i8** %l13
  %t185 = load i8*, i8** %l14
  %t186 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t170, label %then18, label %else19
then18:
  store i1 1, i1* %l6
  %t187 = load %NumberParseResult, %NumberParseResult* %l15
  %t188 = extractvalue %NumberParseResult %t187, 1
  store double %t188, double* %l9
  br label %merge20
else19:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s190 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.190, i32 0, i32 0
  %t191 = add i8* %s190, %struct_name
  %s192 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.192, i32 0, i32 0
  %t193 = add i8* %t191, %s192
  %t194 = load i8*, i8** %l4
  %t195 = add i8* %t193, %t194
  %s196 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.196, i32 0, i32 0
  %t197 = add i8* %t195, %s196
  %t198 = load i8*, i8** %l14
  %t199 = add i8* %t197, %t198
  %t200 = getelementptr i8, i8* %t199, i64 0
  %t201 = load i8, i8* %t200
  %t202 = add i8 %t201, 96
  %t203 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t189, i8* null)
  store { i8**, i64 }* %t203, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t204 = phi i1 [ 1, %then18 ], [ %t177, %else19 ]
  %t205 = phi double [ %t188, %then18 ], [ %t180, %else19 ]
  %t206 = phi { i8**, i64 }* [ %t172, %then18 ], [ %t203, %else19 ]
  store i1 %t204, i1* %l6
  store double %t205, double* %l9
  store { i8**, i64 }* %t206, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t207 = load i8*, i8** %l13
  %s208 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.208, i32 0, i32 0
  %t209 = call i1 @starts_with(i8* %t207, i8* %s208)
  %t210 = load i8*, i8** %l0
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t212 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t214 = load i8*, i8** %l4
  %t215 = load i8*, i8** %l5
  %t216 = load i1, i1* %l6
  %t217 = load i1, i1* %l7
  %t218 = load i1, i1* %l8
  %t219 = load double, double* %l9
  %t220 = load double, double* %l10
  %t221 = load double, double* %l11
  %t222 = load double, double* %l12
  %t223 = load i8*, i8** %l13
  br i1 %t209, label %then21, label %else22
then21:
  %t224 = load i8*, i8** %l13
  %t225 = load i8*, i8** %l13
  %t226 = call i64 @sailfin_runtime_string_length(i8* %t225)
  %t227 = call i8* @sailfin_runtime_substring(i8* %t224, i64 5, i64 %t226)
  store i8* %t227, i8** %l16
  %t228 = load i8*, i8** %l16
  %t229 = call %NumberParseResult @parse_decimal_number(i8* %t228)
  store %NumberParseResult %t229, %NumberParseResult* %l17
  %t230 = load %NumberParseResult, %NumberParseResult* %l17
  %t231 = extractvalue %NumberParseResult %t230, 0
  %t232 = load i8*, i8** %l0
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t234 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t236 = load i8*, i8** %l4
  %t237 = load i8*, i8** %l5
  %t238 = load i1, i1* %l6
  %t239 = load i1, i1* %l7
  %t240 = load i1, i1* %l8
  %t241 = load double, double* %l9
  %t242 = load double, double* %l10
  %t243 = load double, double* %l11
  %t244 = load double, double* %l12
  %t245 = load i8*, i8** %l13
  %t246 = load i8*, i8** %l16
  %t247 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t231, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t248 = load %NumberParseResult, %NumberParseResult* %l17
  %t249 = extractvalue %NumberParseResult %t248, 1
  store double %t249, double* %l10
  br label %merge26
else25:
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s251 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.251, i32 0, i32 0
  %t252 = add i8* %s251, %struct_name
  %s253 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.253, i32 0, i32 0
  %t254 = add i8* %t252, %s253
  %t255 = load i8*, i8** %l4
  %t256 = add i8* %t254, %t255
  %s257 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.257, i32 0, i32 0
  %t258 = add i8* %t256, %s257
  %t259 = load i8*, i8** %l16
  %t260 = add i8* %t258, %t259
  %t261 = getelementptr i8, i8* %t260, i64 0
  %t262 = load i8, i8* %t261
  %t263 = add i8 %t262, 96
  %t264 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t250, i8* null)
  store { i8**, i64 }* %t264, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t265 = phi i1 [ 1, %then24 ], [ %t239, %else25 ]
  %t266 = phi double [ %t249, %then24 ], [ %t242, %else25 ]
  %t267 = phi { i8**, i64 }* [ %t233, %then24 ], [ %t264, %else25 ]
  store i1 %t265, i1* %l7
  store double %t266, double* %l10
  store { i8**, i64 }* %t267, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t268 = load i8*, i8** %l13
  %s269 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.269, i32 0, i32 0
  %t270 = call i1 @starts_with(i8* %t268, i8* %s269)
  %t271 = load i8*, i8** %l0
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t275 = load i8*, i8** %l4
  %t276 = load i8*, i8** %l5
  %t277 = load i1, i1* %l6
  %t278 = load i1, i1* %l7
  %t279 = load i1, i1* %l8
  %t280 = load double, double* %l9
  %t281 = load double, double* %l10
  %t282 = load double, double* %l11
  %t283 = load double, double* %l12
  %t284 = load i8*, i8** %l13
  br i1 %t270, label %then27, label %else28
then27:
  %t285 = load i8*, i8** %l13
  %t286 = load i8*, i8** %l13
  %t287 = call i64 @sailfin_runtime_string_length(i8* %t286)
  %t288 = call i8* @sailfin_runtime_substring(i8* %t285, i64 6, i64 %t287)
  store i8* %t288, i8** %l18
  %t289 = load i8*, i8** %l18
  %t290 = call %NumberParseResult @parse_decimal_number(i8* %t289)
  store %NumberParseResult %t290, %NumberParseResult* %l19
  %t291 = load %NumberParseResult, %NumberParseResult* %l19
  %t292 = extractvalue %NumberParseResult %t291, 0
  %t293 = load i8*, i8** %l0
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t295 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t297 = load i8*, i8** %l4
  %t298 = load i8*, i8** %l5
  %t299 = load i1, i1* %l6
  %t300 = load i1, i1* %l7
  %t301 = load i1, i1* %l8
  %t302 = load double, double* %l9
  %t303 = load double, double* %l10
  %t304 = load double, double* %l11
  %t305 = load double, double* %l12
  %t306 = load i8*, i8** %l13
  %t307 = load i8*, i8** %l18
  %t308 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t292, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t309 = load %NumberParseResult, %NumberParseResult* %l19
  %t310 = extractvalue %NumberParseResult %t309, 1
  store double %t310, double* %l11
  br label %merge32
else31:
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s312 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.312, i32 0, i32 0
  %t313 = add i8* %s312, %struct_name
  %s314 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.314, i32 0, i32 0
  %t315 = add i8* %t313, %s314
  %t316 = load i8*, i8** %l4
  %t317 = add i8* %t315, %t316
  %s318 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.318, i32 0, i32 0
  %t319 = add i8* %t317, %s318
  %t320 = load i8*, i8** %l18
  %t321 = add i8* %t319, %t320
  %t322 = getelementptr i8, i8* %t321, i64 0
  %t323 = load i8, i8* %t322
  %t324 = add i8 %t323, 96
  %t325 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t311, i8* null)
  store { i8**, i64 }* %t325, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t326 = phi i1 [ 1, %then30 ], [ %t301, %else31 ]
  %t327 = phi double [ %t310, %then30 ], [ %t304, %else31 ]
  %t328 = phi { i8**, i64 }* [ %t294, %then30 ], [ %t325, %else31 ]
  store i1 %t326, i1* %l8
  store double %t327, double* %l11
  store { i8**, i64 }* %t328, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s330 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.330, i32 0, i32 0
  %t331 = add i8* %s330, %struct_name
  %s332 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.332, i32 0, i32 0
  %t333 = add i8* %t331, %s332
  %t334 = load i8*, i8** %l4
  %t335 = add i8* %t333, %t334
  %s336 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.336, i32 0, i32 0
  %t337 = add i8* %t335, %s336
  %t338 = load i8*, i8** %l13
  %t339 = add i8* %t337, %t338
  %t340 = getelementptr i8, i8* %t339, i64 0
  %t341 = load i8, i8* %t340
  %t342 = add i8 %t341, 96
  %t343 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t329, i8* null)
  store { i8**, i64 }* %t343, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t344 = phi i1 [ 1, %then27 ], [ %t279, %else28 ]
  %t345 = phi double [ %t310, %then27 ], [ %t282, %else28 ]
  %t346 = phi { i8**, i64 }* [ %t325, %then27 ], [ %t343, %else28 ]
  store i1 %t344, i1* %l8
  store double %t345, double* %l11
  store { i8**, i64 }* %t346, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t347 = phi i1 [ 1, %then21 ], [ %t217, %else22 ]
  %t348 = phi double [ %t249, %then21 ], [ %t220, %else22 ]
  %t349 = phi { i8**, i64 }* [ %t264, %then21 ], [ %t325, %else22 ]
  %t350 = phi i1 [ %t218, %then21 ], [ 1, %else22 ]
  %t351 = phi double [ %t221, %then21 ], [ %t310, %else22 ]
  store i1 %t347, i1* %l7
  store double %t348, double* %l10
  store { i8**, i64 }* %t349, { i8**, i64 }** %l1
  store i1 %t350, i1* %l8
  store double %t351, double* %l11
  br label %merge17
merge17:
  %t352 = phi i1 [ 1, %then15 ], [ %t155, %else16 ]
  %t353 = phi double [ %t188, %then15 ], [ %t158, %else16 ]
  %t354 = phi { i8**, i64 }* [ %t203, %then15 ], [ %t264, %else16 ]
  %t355 = phi i1 [ %t156, %then15 ], [ 1, %else16 ]
  %t356 = phi double [ %t159, %then15 ], [ %t249, %else16 ]
  %t357 = phi i1 [ %t157, %then15 ], [ 1, %else16 ]
  %t358 = phi double [ %t160, %then15 ], [ %t310, %else16 ]
  store i1 %t352, i1* %l6
  store double %t353, double* %l9
  store { i8**, i64 }* %t354, { i8**, i64 }** %l1
  store i1 %t355, i1* %l7
  store double %t356, double* %l10
  store i1 %t357, i1* %l8
  store double %t358, double* %l11
  br label %merge14
merge14:
  %t359 = phi i8* [ %t145, %then12 ], [ %t133, %else13 ]
  %t360 = phi i1 [ %t134, %then12 ], [ 1, %else13 ]
  %t361 = phi double [ %t137, %then12 ], [ %t188, %else13 ]
  %t362 = phi { i8**, i64 }* [ %t129, %then12 ], [ %t203, %else13 ]
  %t363 = phi i1 [ %t135, %then12 ], [ 1, %else13 ]
  %t364 = phi double [ %t138, %then12 ], [ %t249, %else13 ]
  %t365 = phi i1 [ %t136, %then12 ], [ 1, %else13 ]
  %t366 = phi double [ %t139, %then12 ], [ %t310, %else13 ]
  store i8* %t359, i8** %l5
  store i1 %t360, i1* %l6
  store double %t361, double* %l9
  store { i8**, i64 }* %t362, { i8**, i64 }** %l1
  store i1 %t363, i1* %l7
  store double %t364, double* %l10
  store i1 %t365, i1* %l8
  store double %t366, double* %l11
  %t367 = load double, double* %l12
  %t368 = sitofp i64 1 to double
  %t369 = fadd double %t367, %t368
  store double %t369, double* %l12
  br label %loop.latch8
loop.latch8:
  %t370 = load i8*, i8** %l5
  %t371 = load i1, i1* %l6
  %t372 = load double, double* %l9
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t374 = load i1, i1* %l7
  %t375 = load double, double* %l10
  %t376 = load i1, i1* %l8
  %t377 = load double, double* %l11
  %t378 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t388 = load i8*, i8** %l5
  %t389 = call i64 @sailfin_runtime_string_length(i8* %t388)
  %t390 = icmp eq i64 %t389, 0
  %t391 = load i8*, i8** %l0
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t393 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t395 = load i8*, i8** %l4
  %t396 = load i8*, i8** %l5
  %t397 = load i1, i1* %l6
  %t398 = load i1, i1* %l7
  %t399 = load i1, i1* %l8
  %t400 = load double, double* %l9
  %t401 = load double, double* %l10
  %t402 = load double, double* %l11
  %t403 = load double, double* %l12
  br i1 %t390, label %then33, label %merge34
then33:
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s405 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.405, i32 0, i32 0
  %t406 = add i8* %s405, %struct_name
  %s407 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.407, i32 0, i32 0
  %t408 = add i8* %t406, %s407
  %t409 = load i8*, i8** %l4
  %t410 = add i8* %t408, %t409
  %s411 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.411, i32 0, i32 0
  %t412 = add i8* %t410, %s411
  %t413 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t404, i8* %t412)
  store { i8**, i64 }* %t413, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t414 = phi { i8**, i64 }* [ %t413, %then33 ], [ %t392, %entry ]
  store { i8**, i64 }* %t414, { i8**, i64 }** %l1
  %t415 = load i1, i1* %l6
  %t416 = xor i1 %t415, 1
  %t417 = load i8*, i8** %l0
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t419 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t421 = load i8*, i8** %l4
  %t422 = load i8*, i8** %l5
  %t423 = load i1, i1* %l6
  %t424 = load i1, i1* %l7
  %t425 = load i1, i1* %l8
  %t426 = load double, double* %l9
  %t427 = load double, double* %l10
  %t428 = load double, double* %l11
  %t429 = load double, double* %l12
  br i1 %t416, label %then35, label %merge36
then35:
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s431 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.431, i32 0, i32 0
  %t432 = add i8* %s431, %struct_name
  %s433 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.433, i32 0, i32 0
  %t434 = add i8* %t432, %s433
  %t435 = load i8*, i8** %l4
  %t436 = add i8* %t434, %t435
  %s437 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.437, i32 0, i32 0
  %t438 = add i8* %t436, %s437
  %t439 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t430, i8* %t438)
  store { i8**, i64 }* %t439, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t440 = phi { i8**, i64 }* [ %t439, %then35 ], [ %t418, %entry ]
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  %t441 = load i1, i1* %l7
  %t442 = xor i1 %t441, 1
  %t443 = load i8*, i8** %l0
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t445 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t447 = load i8*, i8** %l4
  %t448 = load i8*, i8** %l5
  %t449 = load i1, i1* %l6
  %t450 = load i1, i1* %l7
  %t451 = load i1, i1* %l8
  %t452 = load double, double* %l9
  %t453 = load double, double* %l10
  %t454 = load double, double* %l11
  %t455 = load double, double* %l12
  br i1 %t442, label %then37, label %merge38
then37:
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s457 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.457, i32 0, i32 0
  %t458 = add i8* %s457, %struct_name
  %s459 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.459, i32 0, i32 0
  %t460 = add i8* %t458, %s459
  %t461 = load i8*, i8** %l4
  %t462 = add i8* %t460, %t461
  %s463 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.463, i32 0, i32 0
  %t464 = add i8* %t462, %s463
  %t465 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t456, i8* %t464)
  store { i8**, i64 }* %t465, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t466 = phi { i8**, i64 }* [ %t465, %then37 ], [ %t444, %entry ]
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  %t467 = load i1, i1* %l8
  %t468 = xor i1 %t467, 1
  %t469 = load i8*, i8** %l0
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t471 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t473 = load i8*, i8** %l4
  %t474 = load i8*, i8** %l5
  %t475 = load i1, i1* %l6
  %t476 = load i1, i1* %l7
  %t477 = load i1, i1* %l8
  %t478 = load double, double* %l9
  %t479 = load double, double* %l10
  %t480 = load double, double* %l11
  %t481 = load double, double* %l12
  br i1 %t468, label %then39, label %merge40
then39:
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s483 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.483, i32 0, i32 0
  %t484 = add i8* %s483, %struct_name
  %s485 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.485, i32 0, i32 0
  %t486 = add i8* %t484, %s485
  %t487 = load i8*, i8** %l4
  %t488 = add i8* %t486, %t487
  %s489 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.489, i32 0, i32 0
  %t490 = add i8* %t488, %s489
  %t491 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t482, i8* %t490)
  store { i8**, i64 }* %t491, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t492 = phi { i8**, i64 }* [ %t491, %then39 ], [ %t470, %entry ]
  store { i8**, i64 }* %t492, { i8**, i64 }** %l1
  %t497 = load i8*, i8** %l5
  %t498 = call i64 @sailfin_runtime_string_length(i8* %t497)
  %t499 = icmp sgt i64 %t498, 0
  br label %logical_and_entry_496

logical_and_entry_496:
  br i1 %t499, label %logical_and_right_496, label %logical_and_merge_496

logical_and_right_496:
  %t500 = load i1, i1* %l6
  br label %logical_and_right_end_496

logical_and_right_end_496:
  br label %logical_and_merge_496

logical_and_merge_496:
  %t501 = phi i1 [ false, %logical_and_entry_496 ], [ %t500, %logical_and_right_end_496 ]
  br label %logical_and_entry_495

logical_and_entry_495:
  br i1 %t501, label %logical_and_right_495, label %logical_and_merge_495

logical_and_right_495:
  %t502 = load i1, i1* %l7
  br label %logical_and_right_end_495

logical_and_right_end_495:
  br label %logical_and_merge_495

logical_and_merge_495:
  %t503 = phi i1 [ false, %logical_and_entry_495 ], [ %t502, %logical_and_right_end_495 ]
  br label %logical_and_entry_494

logical_and_entry_494:
  br i1 %t503, label %logical_and_right_494, label %logical_and_merge_494

logical_and_right_494:
  %t504 = load i1, i1* %l8
  br label %logical_and_right_end_494

logical_and_right_end_494:
  br label %logical_and_merge_494

logical_and_merge_494:
  %t505 = phi i1 [ false, %logical_and_entry_494 ], [ %t504, %logical_and_right_end_494 ]
  br label %logical_and_entry_493

logical_and_entry_493:
  br i1 %t505, label %logical_and_right_493, label %logical_and_merge_493

logical_and_right_493:
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t507 = load { i8**, i64 }, { i8**, i64 }* %t506
  %t508 = extractvalue { i8**, i64 } %t507, 1
  %t509 = icmp eq i64 %t508, 0
  br label %logical_and_right_end_493

logical_and_right_end_493:
  br label %logical_and_merge_493

logical_and_merge_493:
  %t510 = phi i1 [ false, %logical_and_entry_493 ], [ %t509, %logical_and_right_end_493 ]
  store i1 %t510, i1* %l20
  %t511 = load i8*, i8** %l4
  %t512 = insertvalue %NativeStructLayoutField undef, i8* %t511, 0
  %t513 = load i8*, i8** %l5
  %t514 = insertvalue %NativeStructLayoutField %t512, i8* %t513, 1
  %t515 = load double, double* %l9
  %t516 = insertvalue %NativeStructLayoutField %t514, double %t515, 2
  %t517 = load double, double* %l10
  %t518 = insertvalue %NativeStructLayoutField %t516, double %t517, 3
  %t519 = load double, double* %l11
  %t520 = insertvalue %NativeStructLayoutField %t518, double %t519, 4
  store %NativeStructLayoutField %t520, %NativeStructLayoutField* %l21
  %t521 = load i1, i1* %l20
  %t522 = insertvalue %StructLayoutFieldParse undef, i1 %t521, 0
  %t523 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t524 = insertvalue %StructLayoutFieldParse %t522, i8* null, 1
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t526 = insertvalue %StructLayoutFieldParse %t524, { i8**, i64 }* %t525, 2
  ret %StructLayoutFieldParse %t526
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
  %t416 = phi i8* [ %t43, %entry ], [ %t403, %loop.latch4 ]
  %t417 = phi i1 [ %t40, %entry ], [ %t404, %loop.latch4 ]
  %t418 = phi i1 [ %t41, %entry ], [ %t405, %loop.latch4 ]
  %t419 = phi double [ %t47, %entry ], [ %t406, %loop.latch4 ]
  %t420 = phi { i8**, i64 }* [ %t39, %entry ], [ %t407, %loop.latch4 ]
  %t421 = phi i1 [ %t42, %entry ], [ %t408, %loop.latch4 ]
  %t422 = phi double [ %t48, %entry ], [ %t409, %loop.latch4 ]
  %t423 = phi i8* [ %t44, %entry ], [ %t410, %loop.latch4 ]
  %t424 = phi i1 [ %t45, %entry ], [ %t411, %loop.latch4 ]
  %t425 = phi double [ %t49, %entry ], [ %t412, %loop.latch4 ]
  %t426 = phi i1 [ %t46, %entry ], [ %t413, %loop.latch4 ]
  %t427 = phi double [ %t50, %entry ], [ %t414, %loop.latch4 ]
  %t428 = phi double [ %t51, %entry ], [ %t415, %loop.latch4 ]
  store i8* %t416, i8** %l5
  store i1 %t417, i1* %l2
  store i1 %t418, i1* %l3
  store double %t419, double* %l9
  store { i8**, i64 }* %t420, { i8**, i64 }** %l1
  store i1 %t421, i1* %l4
  store double %t422, double* %l10
  store i8* %t423, i8** %l6
  store i1 %t424, i1* %l7
  store double %t425, double* %l11
  store i1 %t426, i1* %l8
  store double %t427, double* %l12
  store double %t428, double* %l13
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
  %t100 = call i64 @sailfin_runtime_string_length(i8* %t99)
  %t101 = call i8* @sailfin_runtime_substring(i8* %t98, i64 5, i64 %t100)
  store i8* %t101, i8** %l5
  store i1 1, i1* %l2
  br label %merge10
else9:
  %t102 = load i8*, i8** %l14
  %s103 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.103, i32 0, i32 0
  %t104 = call i1 @starts_with(i8* %t102, i8* %s103)
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load i1, i1* %l2
  %t108 = load i1, i1* %l3
  %t109 = load i1, i1* %l4
  %t110 = load i8*, i8** %l5
  %t111 = load i8*, i8** %l6
  %t112 = load i1, i1* %l7
  %t113 = load i1, i1* %l8
  %t114 = load double, double* %l9
  %t115 = load double, double* %l10
  %t116 = load double, double* %l11
  %t117 = load double, double* %l12
  %t118 = load double, double* %l13
  %t119 = load i8*, i8** %l14
  br i1 %t104, label %then11, label %else12
then11:
  %t120 = load i8*, i8** %l14
  %t121 = load i8*, i8** %l14
  %t122 = call i64 @sailfin_runtime_string_length(i8* %t121)
  %t123 = call i8* @sailfin_runtime_substring(i8* %t120, i64 5, i64 %t122)
  store i8* %t123, i8** %l15
  %t124 = load i8*, i8** %l15
  %t125 = call %NumberParseResult @parse_decimal_number(i8* %t124)
  store %NumberParseResult %t125, %NumberParseResult* %l16
  %t126 = load %NumberParseResult, %NumberParseResult* %l16
  %t127 = extractvalue %NumberParseResult %t126, 0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load i1, i1* %l2
  %t131 = load i1, i1* %l3
  %t132 = load i1, i1* %l4
  %t133 = load i8*, i8** %l5
  %t134 = load i8*, i8** %l6
  %t135 = load i1, i1* %l7
  %t136 = load i1, i1* %l8
  %t137 = load double, double* %l9
  %t138 = load double, double* %l10
  %t139 = load double, double* %l11
  %t140 = load double, double* %l12
  %t141 = load double, double* %l13
  %t142 = load i8*, i8** %l14
  %t143 = load i8*, i8** %l15
  %t144 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t127, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t145 = load %NumberParseResult, %NumberParseResult* %l16
  %t146 = extractvalue %NumberParseResult %t145, 1
  store double %t146, double* %l9
  br label %merge16
else15:
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s148 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.148, i32 0, i32 0
  %t149 = load i8*, i8** %l15
  %t150 = add i8* %s148, %t149
  %t151 = getelementptr i8, i8* %t150, i64 0
  %t152 = load i8, i8* %t151
  %t153 = add i8 %t152, 96
  %t154 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t147, i8* null)
  store { i8**, i64 }* %t154, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t155 = phi i1 [ 1, %then14 ], [ %t131, %else15 ]
  %t156 = phi double [ %t146, %then14 ], [ %t137, %else15 ]
  %t157 = phi { i8**, i64 }* [ %t129, %then14 ], [ %t154, %else15 ]
  store i1 %t155, i1* %l3
  store double %t156, double* %l9
  store { i8**, i64 }* %t157, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t158 = load i8*, i8** %l14
  %s159 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.159, i32 0, i32 0
  %t160 = call i1 @starts_with(i8* %t158, i8* %s159)
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load i1, i1* %l2
  %t164 = load i1, i1* %l3
  %t165 = load i1, i1* %l4
  %t166 = load i8*, i8** %l5
  %t167 = load i8*, i8** %l6
  %t168 = load i1, i1* %l7
  %t169 = load i1, i1* %l8
  %t170 = load double, double* %l9
  %t171 = load double, double* %l10
  %t172 = load double, double* %l11
  %t173 = load double, double* %l12
  %t174 = load double, double* %l13
  %t175 = load i8*, i8** %l14
  br i1 %t160, label %then17, label %else18
then17:
  %t176 = load i8*, i8** %l14
  %t177 = load i8*, i8** %l14
  %t178 = call i64 @sailfin_runtime_string_length(i8* %t177)
  %t179 = call i8* @sailfin_runtime_substring(i8* %t176, i64 6, i64 %t178)
  store i8* %t179, i8** %l17
  %t180 = load i8*, i8** %l17
  %t181 = call %NumberParseResult @parse_decimal_number(i8* %t180)
  store %NumberParseResult %t181, %NumberParseResult* %l18
  %t182 = load %NumberParseResult, %NumberParseResult* %l18
  %t183 = extractvalue %NumberParseResult %t182, 0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = load i1, i1* %l2
  %t187 = load i1, i1* %l3
  %t188 = load i1, i1* %l4
  %t189 = load i8*, i8** %l5
  %t190 = load i8*, i8** %l6
  %t191 = load i1, i1* %l7
  %t192 = load i1, i1* %l8
  %t193 = load double, double* %l9
  %t194 = load double, double* %l10
  %t195 = load double, double* %l11
  %t196 = load double, double* %l12
  %t197 = load double, double* %l13
  %t198 = load i8*, i8** %l14
  %t199 = load i8*, i8** %l17
  %t200 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t183, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t201 = load %NumberParseResult, %NumberParseResult* %l18
  %t202 = extractvalue %NumberParseResult %t201, 1
  store double %t202, double* %l10
  br label %merge22
else21:
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s204 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.204, i32 0, i32 0
  %t205 = load i8*, i8** %l17
  %t206 = add i8* %s204, %t205
  %t207 = getelementptr i8, i8* %t206, i64 0
  %t208 = load i8, i8* %t207
  %t209 = add i8 %t208, 96
  %t210 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t203, i8* null)
  store { i8**, i64 }* %t210, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t211 = phi i1 [ 1, %then20 ], [ %t188, %else21 ]
  %t212 = phi double [ %t202, %then20 ], [ %t194, %else21 ]
  %t213 = phi { i8**, i64 }* [ %t185, %then20 ], [ %t210, %else21 ]
  store i1 %t211, i1* %l4
  store double %t212, double* %l10
  store { i8**, i64 }* %t213, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t214 = load i8*, i8** %l14
  %s215 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.215, i32 0, i32 0
  %t216 = call i1 @starts_with(i8* %t214, i8* %s215)
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load i1, i1* %l2
  %t220 = load i1, i1* %l3
  %t221 = load i1, i1* %l4
  %t222 = load i8*, i8** %l5
  %t223 = load i8*, i8** %l6
  %t224 = load i1, i1* %l7
  %t225 = load i1, i1* %l8
  %t226 = load double, double* %l9
  %t227 = load double, double* %l10
  %t228 = load double, double* %l11
  %t229 = load double, double* %l12
  %t230 = load double, double* %l13
  %t231 = load i8*, i8** %l14
  br i1 %t216, label %then23, label %else24
then23:
  %t232 = load i8*, i8** %l14
  %t233 = load i8*, i8** %l14
  %t234 = call i64 @sailfin_runtime_string_length(i8* %t233)
  %t235 = call i8* @sailfin_runtime_substring(i8* %t232, i64 9, i64 %t234)
  store i8* %t235, i8** %l6
  br label %merge25
else24:
  %t236 = load i8*, i8** %l14
  %s237 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.237, i32 0, i32 0
  %t238 = call i1 @starts_with(i8* %t236, i8* %s237)
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t241 = load i1, i1* %l2
  %t242 = load i1, i1* %l3
  %t243 = load i1, i1* %l4
  %t244 = load i8*, i8** %l5
  %t245 = load i8*, i8** %l6
  %t246 = load i1, i1* %l7
  %t247 = load i1, i1* %l8
  %t248 = load double, double* %l9
  %t249 = load double, double* %l10
  %t250 = load double, double* %l11
  %t251 = load double, double* %l12
  %t252 = load double, double* %l13
  %t253 = load i8*, i8** %l14
  br i1 %t238, label %then26, label %else27
then26:
  %t254 = load i8*, i8** %l14
  %t255 = load i8*, i8** %l14
  %t256 = call i64 @sailfin_runtime_string_length(i8* %t255)
  %t257 = call i8* @sailfin_runtime_substring(i8* %t254, i64 9, i64 %t256)
  store i8* %t257, i8** %l19
  %t258 = load i8*, i8** %l19
  %t259 = call %NumberParseResult @parse_decimal_number(i8* %t258)
  store %NumberParseResult %t259, %NumberParseResult* %l20
  %t260 = load %NumberParseResult, %NumberParseResult* %l20
  %t261 = extractvalue %NumberParseResult %t260, 0
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = load i1, i1* %l2
  %t265 = load i1, i1* %l3
  %t266 = load i1, i1* %l4
  %t267 = load i8*, i8** %l5
  %t268 = load i8*, i8** %l6
  %t269 = load i1, i1* %l7
  %t270 = load i1, i1* %l8
  %t271 = load double, double* %l9
  %t272 = load double, double* %l10
  %t273 = load double, double* %l11
  %t274 = load double, double* %l12
  %t275 = load double, double* %l13
  %t276 = load i8*, i8** %l14
  %t277 = load i8*, i8** %l19
  %t278 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t261, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t279 = load %NumberParseResult, %NumberParseResult* %l20
  %t280 = extractvalue %NumberParseResult %t279, 1
  store double %t280, double* %l11
  br label %merge31
else30:
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s282 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.282, i32 0, i32 0
  %t283 = load i8*, i8** %l19
  %t284 = add i8* %s282, %t283
  %t285 = getelementptr i8, i8* %t284, i64 0
  %t286 = load i8, i8* %t285
  %t287 = add i8 %t286, 96
  %t288 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t281, i8* null)
  store { i8**, i64 }* %t288, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t289 = phi i1 [ 1, %then29 ], [ %t269, %else30 ]
  %t290 = phi double [ %t280, %then29 ], [ %t273, %else30 ]
  %t291 = phi { i8**, i64 }* [ %t263, %then29 ], [ %t288, %else30 ]
  store i1 %t289, i1* %l7
  store double %t290, double* %l11
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t292 = load i8*, i8** %l14
  %s293 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.293, i32 0, i32 0
  %t294 = call i1 @starts_with(i8* %t292, i8* %s293)
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load i1, i1* %l2
  %t298 = load i1, i1* %l3
  %t299 = load i1, i1* %l4
  %t300 = load i8*, i8** %l5
  %t301 = load i8*, i8** %l6
  %t302 = load i1, i1* %l7
  %t303 = load i1, i1* %l8
  %t304 = load double, double* %l9
  %t305 = load double, double* %l10
  %t306 = load double, double* %l11
  %t307 = load double, double* %l12
  %t308 = load double, double* %l13
  %t309 = load i8*, i8** %l14
  br i1 %t294, label %then32, label %else33
then32:
  %t310 = load i8*, i8** %l14
  %t311 = load i8*, i8** %l14
  %t312 = call i64 @sailfin_runtime_string_length(i8* %t311)
  %t313 = call i8* @sailfin_runtime_substring(i8* %t310, i64 10, i64 %t312)
  store i8* %t313, i8** %l21
  %t314 = load i8*, i8** %l21
  %t315 = call %NumberParseResult @parse_decimal_number(i8* %t314)
  store %NumberParseResult %t315, %NumberParseResult* %l22
  %t316 = load %NumberParseResult, %NumberParseResult* %l22
  %t317 = extractvalue %NumberParseResult %t316, 0
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t320 = load i1, i1* %l2
  %t321 = load i1, i1* %l3
  %t322 = load i1, i1* %l4
  %t323 = load i8*, i8** %l5
  %t324 = load i8*, i8** %l6
  %t325 = load i1, i1* %l7
  %t326 = load i1, i1* %l8
  %t327 = load double, double* %l9
  %t328 = load double, double* %l10
  %t329 = load double, double* %l11
  %t330 = load double, double* %l12
  %t331 = load double, double* %l13
  %t332 = load i8*, i8** %l14
  %t333 = load i8*, i8** %l21
  %t334 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t317, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t335 = load %NumberParseResult, %NumberParseResult* %l22
  %t336 = extractvalue %NumberParseResult %t335, 1
  store double %t336, double* %l12
  br label %merge37
else36:
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s338 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.338, i32 0, i32 0
  %t339 = load i8*, i8** %l21
  %t340 = add i8* %s338, %t339
  %t341 = getelementptr i8, i8* %t340, i64 0
  %t342 = load i8, i8* %t341
  %t343 = add i8 %t342, 96
  %t344 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t337, i8* null)
  store { i8**, i64 }* %t344, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t345 = phi i1 [ 1, %then35 ], [ %t326, %else36 ]
  %t346 = phi double [ %t336, %then35 ], [ %t330, %else36 ]
  %t347 = phi { i8**, i64 }* [ %t319, %then35 ], [ %t344, %else36 ]
  store i1 %t345, i1* %l8
  store double %t346, double* %l12
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s349 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.349, i32 0, i32 0
  %t350 = load i8*, i8** %l14
  %t351 = add i8* %s349, %t350
  %t352 = getelementptr i8, i8* %t351, i64 0
  %t353 = load i8, i8* %t352
  %t354 = add i8 %t353, 96
  %t355 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t348, i8* null)
  store { i8**, i64 }* %t355, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t356 = phi i1 [ 1, %then32 ], [ %t303, %else33 ]
  %t357 = phi double [ %t336, %then32 ], [ %t307, %else33 ]
  %t358 = phi { i8**, i64 }* [ %t344, %then32 ], [ %t355, %else33 ]
  store i1 %t356, i1* %l8
  store double %t357, double* %l12
  store { i8**, i64 }* %t358, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t359 = phi i1 [ 1, %then26 ], [ %t246, %else27 ]
  %t360 = phi double [ %t280, %then26 ], [ %t250, %else27 ]
  %t361 = phi { i8**, i64 }* [ %t288, %then26 ], [ %t344, %else27 ]
  %t362 = phi i1 [ %t247, %then26 ], [ 1, %else27 ]
  %t363 = phi double [ %t251, %then26 ], [ %t336, %else27 ]
  store i1 %t359, i1* %l7
  store double %t360, double* %l11
  store { i8**, i64 }* %t361, { i8**, i64 }** %l1
  store i1 %t362, i1* %l8
  store double %t363, double* %l12
  br label %merge25
merge25:
  %t364 = phi i8* [ %t235, %then23 ], [ %t223, %else24 ]
  %t365 = phi i1 [ %t224, %then23 ], [ 1, %else24 ]
  %t366 = phi double [ %t228, %then23 ], [ %t280, %else24 ]
  %t367 = phi { i8**, i64 }* [ %t218, %then23 ], [ %t288, %else24 ]
  %t368 = phi i1 [ %t225, %then23 ], [ 1, %else24 ]
  %t369 = phi double [ %t229, %then23 ], [ %t336, %else24 ]
  store i8* %t364, i8** %l6
  store i1 %t365, i1* %l7
  store double %t366, double* %l11
  store { i8**, i64 }* %t367, { i8**, i64 }** %l1
  store i1 %t368, i1* %l8
  store double %t369, double* %l12
  br label %merge19
merge19:
  %t370 = phi i1 [ 1, %then17 ], [ %t165, %else18 ]
  %t371 = phi double [ %t202, %then17 ], [ %t171, %else18 ]
  %t372 = phi { i8**, i64 }* [ %t210, %then17 ], [ %t288, %else18 ]
  %t373 = phi i8* [ %t167, %then17 ], [ %t235, %else18 ]
  %t374 = phi i1 [ %t168, %then17 ], [ 1, %else18 ]
  %t375 = phi double [ %t172, %then17 ], [ %t280, %else18 ]
  %t376 = phi i1 [ %t169, %then17 ], [ 1, %else18 ]
  %t377 = phi double [ %t173, %then17 ], [ %t336, %else18 ]
  store i1 %t370, i1* %l4
  store double %t371, double* %l10
  store { i8**, i64 }* %t372, { i8**, i64 }** %l1
  store i8* %t373, i8** %l6
  store i1 %t374, i1* %l7
  store double %t375, double* %l11
  store i1 %t376, i1* %l8
  store double %t377, double* %l12
  br label %merge13
merge13:
  %t378 = phi i1 [ 1, %then11 ], [ %t108, %else12 ]
  %t379 = phi double [ %t146, %then11 ], [ %t114, %else12 ]
  %t380 = phi { i8**, i64 }* [ %t154, %then11 ], [ %t210, %else12 ]
  %t381 = phi i1 [ %t109, %then11 ], [ 1, %else12 ]
  %t382 = phi double [ %t115, %then11 ], [ %t202, %else12 ]
  %t383 = phi i8* [ %t111, %then11 ], [ %t235, %else12 ]
  %t384 = phi i1 [ %t112, %then11 ], [ 1, %else12 ]
  %t385 = phi double [ %t116, %then11 ], [ %t280, %else12 ]
  %t386 = phi i1 [ %t113, %then11 ], [ 1, %else12 ]
  %t387 = phi double [ %t117, %then11 ], [ %t336, %else12 ]
  store i1 %t378, i1* %l3
  store double %t379, double* %l9
  store { i8**, i64 }* %t380, { i8**, i64 }** %l1
  store i1 %t381, i1* %l4
  store double %t382, double* %l10
  store i8* %t383, i8** %l6
  store i1 %t384, i1* %l7
  store double %t385, double* %l11
  store i1 %t386, i1* %l8
  store double %t387, double* %l12
  br label %merge10
merge10:
  %t388 = phi i8* [ %t101, %then8 ], [ %t88, %else9 ]
  %t389 = phi i1 [ 1, %then8 ], [ %t85, %else9 ]
  %t390 = phi i1 [ %t86, %then8 ], [ 1, %else9 ]
  %t391 = phi double [ %t92, %then8 ], [ %t146, %else9 ]
  %t392 = phi { i8**, i64 }* [ %t84, %then8 ], [ %t154, %else9 ]
  %t393 = phi i1 [ %t87, %then8 ], [ 1, %else9 ]
  %t394 = phi double [ %t93, %then8 ], [ %t202, %else9 ]
  %t395 = phi i8* [ %t89, %then8 ], [ %t235, %else9 ]
  %t396 = phi i1 [ %t90, %then8 ], [ 1, %else9 ]
  %t397 = phi double [ %t94, %then8 ], [ %t280, %else9 ]
  %t398 = phi i1 [ %t91, %then8 ], [ 1, %else9 ]
  %t399 = phi double [ %t95, %then8 ], [ %t336, %else9 ]
  store i8* %t388, i8** %l5
  store i1 %t389, i1* %l2
  store i1 %t390, i1* %l3
  store double %t391, double* %l9
  store { i8**, i64 }* %t392, { i8**, i64 }** %l1
  store i1 %t393, i1* %l4
  store double %t394, double* %l10
  store i8* %t395, i8** %l6
  store i1 %t396, i1* %l7
  store double %t397, double* %l11
  store i1 %t398, i1* %l8
  store double %t399, double* %l12
  %t400 = load double, double* %l13
  %t401 = sitofp i64 1 to double
  %t402 = fadd double %t400, %t401
  store double %t402, double* %l13
  br label %loop.latch4
loop.latch4:
  %t403 = load i8*, i8** %l5
  %t404 = load i1, i1* %l2
  %t405 = load i1, i1* %l3
  %t406 = load double, double* %l9
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t408 = load i1, i1* %l4
  %t409 = load double, double* %l10
  %t410 = load i8*, i8** %l6
  %t411 = load i1, i1* %l7
  %t412 = load double, double* %l11
  %t413 = load i1, i1* %l8
  %t414 = load double, double* %l12
  %t415 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t429 = load i1, i1* %l3
  %t430 = xor i1 %t429, 1
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t433 = load i1, i1* %l2
  %t434 = load i1, i1* %l3
  %t435 = load i1, i1* %l4
  %t436 = load i8*, i8** %l5
  %t437 = load i8*, i8** %l6
  %t438 = load i1, i1* %l7
  %t439 = load i1, i1* %l8
  %t440 = load double, double* %l9
  %t441 = load double, double* %l10
  %t442 = load double, double* %l11
  %t443 = load double, double* %l12
  %t444 = load double, double* %l13
  br i1 %t430, label %then38, label %merge39
then38:
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s446 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.446, i32 0, i32 0
  %t447 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t445, i8* %s446)
  store { i8**, i64 }* %t447, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t448 = phi { i8**, i64 }* [ %t447, %then38 ], [ %t432, %entry ]
  store { i8**, i64 }* %t448, { i8**, i64 }** %l1
  %t449 = load i1, i1* %l4
  %t450 = xor i1 %t449, 1
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t453 = load i1, i1* %l2
  %t454 = load i1, i1* %l3
  %t455 = load i1, i1* %l4
  %t456 = load i8*, i8** %l5
  %t457 = load i8*, i8** %l6
  %t458 = load i1, i1* %l7
  %t459 = load i1, i1* %l8
  %t460 = load double, double* %l9
  %t461 = load double, double* %l10
  %t462 = load double, double* %l11
  %t463 = load double, double* %l12
  %t464 = load double, double* %l13
  br i1 %t450, label %then40, label %merge41
then40:
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s466 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.466, i32 0, i32 0
  %t467 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t465, i8* %s466)
  store { i8**, i64 }* %t467, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t468 = phi { i8**, i64 }* [ %t467, %then40 ], [ %t452, %entry ]
  store { i8**, i64 }* %t468, { i8**, i64 }** %l1
  %t469 = load i8*, i8** %l6
  %t470 = call i64 @sailfin_runtime_string_length(i8* %t469)
  %t471 = icmp eq i64 %t470, 0
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
  br i1 %t471, label %then42, label %merge43
then42:
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s487 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.487, i32 0, i32 0
  %t488 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t486, i8* %s487)
  store { i8**, i64 }* %t488, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t489 = phi { i8**, i64 }* [ %t488, %then42 ], [ %t473, %entry ]
  store { i8**, i64 }* %t489, { i8**, i64 }** %l1
  %t490 = load i1, i1* %l7
  %t491 = xor i1 %t490, 1
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = load i1, i1* %l2
  %t495 = load i1, i1* %l3
  %t496 = load i1, i1* %l4
  %t497 = load i8*, i8** %l5
  %t498 = load i8*, i8** %l6
  %t499 = load i1, i1* %l7
  %t500 = load i1, i1* %l8
  %t501 = load double, double* %l9
  %t502 = load double, double* %l10
  %t503 = load double, double* %l11
  %t504 = load double, double* %l12
  %t505 = load double, double* %l13
  br i1 %t491, label %then44, label %merge45
then44:
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s507 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.507, i32 0, i32 0
  %t508 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t506, i8* %s507)
  store { i8**, i64 }* %t508, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t509 = phi { i8**, i64 }* [ %t508, %then44 ], [ %t493, %entry ]
  store { i8**, i64 }* %t509, { i8**, i64 }** %l1
  %t510 = load i1, i1* %l8
  %t511 = xor i1 %t510, 1
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load i1, i1* %l2
  %t515 = load i1, i1* %l3
  %t516 = load i1, i1* %l4
  %t517 = load i8*, i8** %l5
  %t518 = load i8*, i8** %l6
  %t519 = load i1, i1* %l7
  %t520 = load i1, i1* %l8
  %t521 = load double, double* %l9
  %t522 = load double, double* %l10
  %t523 = load double, double* %l11
  %t524 = load double, double* %l12
  %t525 = load double, double* %l13
  br i1 %t511, label %then46, label %merge47
then46:
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s527 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.527, i32 0, i32 0
  %t528 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t526, i8* %s527)
  store { i8**, i64 }* %t528, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t529 = phi { i8**, i64 }* [ %t528, %then46 ], [ %t513, %entry ]
  store { i8**, i64 }* %t529, { i8**, i64 }** %l1
  %t535 = load i1, i1* %l3
  br label %logical_and_entry_534

logical_and_entry_534:
  br i1 %t535, label %logical_and_right_534, label %logical_and_merge_534

logical_and_right_534:
  %t536 = load i1, i1* %l4
  br label %logical_and_right_end_534

logical_and_right_end_534:
  br label %logical_and_merge_534

logical_and_merge_534:
  %t537 = phi i1 [ false, %logical_and_entry_534 ], [ %t536, %logical_and_right_end_534 ]
  br label %logical_and_entry_533

logical_and_entry_533:
  br i1 %t537, label %logical_and_right_533, label %logical_and_merge_533

logical_and_right_533:
  %t538 = load i8*, i8** %l6
  %t539 = call i64 @sailfin_runtime_string_length(i8* %t538)
  %t540 = icmp sgt i64 %t539, 0
  br label %logical_and_right_end_533

logical_and_right_end_533:
  br label %logical_and_merge_533

logical_and_merge_533:
  %t541 = phi i1 [ false, %logical_and_entry_533 ], [ %t540, %logical_and_right_end_533 ]
  br label %logical_and_entry_532

logical_and_entry_532:
  br i1 %t541, label %logical_and_right_532, label %logical_and_merge_532

logical_and_right_532:
  %t542 = load i1, i1* %l7
  br label %logical_and_right_end_532

logical_and_right_end_532:
  br label %logical_and_merge_532

logical_and_merge_532:
  %t543 = phi i1 [ false, %logical_and_entry_532 ], [ %t542, %logical_and_right_end_532 ]
  br label %logical_and_entry_531

logical_and_entry_531:
  br i1 %t543, label %logical_and_right_531, label %logical_and_merge_531

logical_and_right_531:
  %t544 = load i1, i1* %l8
  br label %logical_and_right_end_531

logical_and_right_end_531:
  br label %logical_and_merge_531

logical_and_merge_531:
  %t545 = phi i1 [ false, %logical_and_entry_531 ], [ %t544, %logical_and_right_end_531 ]
  br label %logical_and_entry_530

logical_and_entry_530:
  br i1 %t545, label %logical_and_right_530, label %logical_and_merge_530

logical_and_right_530:
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t547 = load { i8**, i64 }, { i8**, i64 }* %t546
  %t548 = extractvalue { i8**, i64 } %t547, 1
  %t549 = icmp eq i64 %t548, 0
  br label %logical_and_right_end_530

logical_and_right_end_530:
  br label %logical_and_merge_530

logical_and_merge_530:
  %t550 = phi i1 [ false, %logical_and_entry_530 ], [ %t549, %logical_and_right_end_530 ]
  store i1 %t550, i1* %l23
  %t551 = load i1, i1* %l23
  %t552 = insertvalue %EnumLayoutHeaderParse undef, i1 %t551, 0
  %t553 = load i8*, i8** %l5
  %t554 = insertvalue %EnumLayoutHeaderParse %t552, i8* %t553, 1
  %t555 = load double, double* %l9
  %t556 = insertvalue %EnumLayoutHeaderParse %t554, double %t555, 2
  %t557 = load double, double* %l10
  %t558 = insertvalue %EnumLayoutHeaderParse %t556, double %t557, 3
  %t559 = load i8*, i8** %l6
  %t560 = insertvalue %EnumLayoutHeaderParse %t558, i8* %t559, 4
  %t561 = load double, double* %l11
  %t562 = insertvalue %EnumLayoutHeaderParse %t560, double %t561, 5
  %t563 = load double, double* %l12
  %t564 = insertvalue %EnumLayoutHeaderParse %t562, double %t563, 6
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t566 = insertvalue %EnumLayoutHeaderParse %t564, { i8**, i64 }* %t565, 7
  ret %EnumLayoutHeaderParse %t566
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
  %t437 = phi i1 [ %t96, %entry ], [ %t427, %loop.latch8 ]
  %t438 = phi double [ %t100, %entry ], [ %t428, %loop.latch8 ]
  %t439 = phi { i8**, i64 }* [ %t92, %entry ], [ %t429, %loop.latch8 ]
  %t440 = phi i1 [ %t97, %entry ], [ %t430, %loop.latch8 ]
  %t441 = phi double [ %t101, %entry ], [ %t431, %loop.latch8 ]
  %t442 = phi i1 [ %t98, %entry ], [ %t432, %loop.latch8 ]
  %t443 = phi double [ %t102, %entry ], [ %t433, %loop.latch8 ]
  %t444 = phi i1 [ %t99, %entry ], [ %t434, %loop.latch8 ]
  %t445 = phi double [ %t103, %entry ], [ %t435, %loop.latch8 ]
  %t446 = phi double [ %t104, %entry ], [ %t436, %loop.latch8 ]
  store i1 %t437, i1* %l5
  store double %t438, double* %l9
  store { i8**, i64 }* %t439, { i8**, i64 }** %l1
  store i1 %t440, i1* %l6
  store double %t441, double* %l10
  store i1 %t442, i1* %l7
  store double %t443, double* %l11
  store i1 %t444, i1* %l8
  store double %t445, double* %l12
  store double %t446, double* %l13
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
  %t127 = load { i8**, i64 }, { i8**, i64 }* %t125
  %t128 = extractvalue { i8**, i64 } %t127, 0
  %t129 = extractvalue { i8**, i64 } %t127, 1
  %t130 = icmp uge i64 %t126, %t129
  ; bounds check: %t130 (if true, out of bounds)
  %t131 = getelementptr i8*, i8** %t128, i64 %t126
  %t132 = load i8*, i8** %t131
  store i8* %t132, i8** %l14
  %t133 = load i8*, i8** %l14
  %s134 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.134, i32 0, i32 0
  %t135 = call i1 @starts_with(i8* %t133, i8* %s134)
  %t136 = load i8*, i8** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t140 = load i8*, i8** %l4
  %t141 = load i1, i1* %l5
  %t142 = load i1, i1* %l6
  %t143 = load i1, i1* %l7
  %t144 = load i1, i1* %l8
  %t145 = load double, double* %l9
  %t146 = load double, double* %l10
  %t147 = load double, double* %l11
  %t148 = load double, double* %l12
  %t149 = load double, double* %l13
  %t150 = load i8*, i8** %l14
  br i1 %t135, label %then12, label %else13
then12:
  %t151 = load i8*, i8** %l14
  %t152 = load i8*, i8** %l14
  %t153 = call i64 @sailfin_runtime_string_length(i8* %t152)
  %t154 = call i8* @sailfin_runtime_substring(i8* %t151, i64 4, i64 %t153)
  store i8* %t154, i8** %l15
  %t155 = load i8*, i8** %l15
  %t156 = call %NumberParseResult @parse_decimal_number(i8* %t155)
  store %NumberParseResult %t156, %NumberParseResult* %l16
  %t157 = load %NumberParseResult, %NumberParseResult* %l16
  %t158 = extractvalue %NumberParseResult %t157, 0
  %t159 = load i8*, i8** %l0
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t163 = load i8*, i8** %l4
  %t164 = load i1, i1* %l5
  %t165 = load i1, i1* %l6
  %t166 = load i1, i1* %l7
  %t167 = load i1, i1* %l8
  %t168 = load double, double* %l9
  %t169 = load double, double* %l10
  %t170 = load double, double* %l11
  %t171 = load double, double* %l12
  %t172 = load double, double* %l13
  %t173 = load i8*, i8** %l14
  %t174 = load i8*, i8** %l15
  %t175 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t158, label %then15, label %else16
then15:
  store i1 1, i1* %l5
  %t176 = load %NumberParseResult, %NumberParseResult* %l16
  %t177 = extractvalue %NumberParseResult %t176, 1
  store double %t177, double* %l9
  br label %merge17
else16:
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s179 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.179, i32 0, i32 0
  %t180 = add i8* %s179, %enum_name
  %s181 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.181, i32 0, i32 0
  %t182 = add i8* %t180, %s181
  %t183 = load i8*, i8** %l4
  %t184 = add i8* %t182, %t183
  %s185 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.185, i32 0, i32 0
  %t186 = add i8* %t184, %s185
  %t187 = load i8*, i8** %l15
  %t188 = add i8* %t186, %t187
  %t189 = getelementptr i8, i8* %t188, i64 0
  %t190 = load i8, i8* %t189
  %t191 = add i8 %t190, 96
  %t192 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t178, i8* null)
  store { i8**, i64 }* %t192, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t193 = phi i1 [ 1, %then15 ], [ %t164, %else16 ]
  %t194 = phi double [ %t177, %then15 ], [ %t168, %else16 ]
  %t195 = phi { i8**, i64 }* [ %t160, %then15 ], [ %t192, %else16 ]
  store i1 %t193, i1* %l5
  store double %t194, double* %l9
  store { i8**, i64 }* %t195, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t196 = load i8*, i8** %l14
  %s197 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.197, i32 0, i32 0
  %t198 = call i1 @starts_with(i8* %t196, i8* %s197)
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
  br i1 %t198, label %then18, label %else19
then18:
  %t214 = load i8*, i8** %l14
  %t215 = load i8*, i8** %l14
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
  %t224 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t226 = load i8*, i8** %l4
  %t227 = load i1, i1* %l5
  %t228 = load i1, i1* %l6
  %t229 = load i1, i1* %l7
  %t230 = load i1, i1* %l8
  %t231 = load double, double* %l9
  %t232 = load double, double* %l10
  %t233 = load double, double* %l11
  %t234 = load double, double* %l12
  %t235 = load double, double* %l13
  %t236 = load i8*, i8** %l14
  %t237 = load i8*, i8** %l17
  %t238 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t221, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t239 = load %NumberParseResult, %NumberParseResult* %l18
  %t240 = extractvalue %NumberParseResult %t239, 1
  store double %t240, double* %l10
  br label %merge23
else22:
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s242 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.242, i32 0, i32 0
  %t243 = add i8* %s242, %enum_name
  %s244 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.244, i32 0, i32 0
  %t245 = add i8* %t243, %s244
  %t246 = load i8*, i8** %l4
  %t247 = add i8* %t245, %t246
  %s248 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.248, i32 0, i32 0
  %t249 = add i8* %t247, %s248
  %t250 = load i8*, i8** %l17
  %t251 = add i8* %t249, %t250
  %t252 = getelementptr i8, i8* %t251, i64 0
  %t253 = load i8, i8* %t252
  %t254 = add i8 %t253, 96
  %t255 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t241, i8* null)
  store { i8**, i64 }* %t255, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t256 = phi i1 [ 1, %then21 ], [ %t228, %else22 ]
  %t257 = phi double [ %t240, %then21 ], [ %t232, %else22 ]
  %t258 = phi { i8**, i64 }* [ %t223, %then21 ], [ %t255, %else22 ]
  store i1 %t256, i1* %l6
  store double %t257, double* %l10
  store { i8**, i64 }* %t258, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t259 = load i8*, i8** %l14
  %s260 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.260, i32 0, i32 0
  %t261 = call i1 @starts_with(i8* %t259, i8* %s260)
  %t262 = load i8*, i8** %l0
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t266 = load i8*, i8** %l4
  %t267 = load i1, i1* %l5
  %t268 = load i1, i1* %l6
  %t269 = load i1, i1* %l7
  %t270 = load i1, i1* %l8
  %t271 = load double, double* %l9
  %t272 = load double, double* %l10
  %t273 = load double, double* %l11
  %t274 = load double, double* %l12
  %t275 = load double, double* %l13
  %t276 = load i8*, i8** %l14
  br i1 %t261, label %then24, label %else25
then24:
  %t277 = load i8*, i8** %l14
  %t278 = load i8*, i8** %l14
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
  %t287 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t289 = load i8*, i8** %l4
  %t290 = load i1, i1* %l5
  %t291 = load i1, i1* %l6
  %t292 = load i1, i1* %l7
  %t293 = load i1, i1* %l8
  %t294 = load double, double* %l9
  %t295 = load double, double* %l10
  %t296 = load double, double* %l11
  %t297 = load double, double* %l12
  %t298 = load double, double* %l13
  %t299 = load i8*, i8** %l14
  %t300 = load i8*, i8** %l19
  %t301 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t284, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t302 = load %NumberParseResult, %NumberParseResult* %l20
  %t303 = extractvalue %NumberParseResult %t302, 1
  store double %t303, double* %l11
  br label %merge29
else28:
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s305 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.305, i32 0, i32 0
  %t306 = add i8* %s305, %enum_name
  %s307 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.307, i32 0, i32 0
  %t308 = add i8* %t306, %s307
  %t309 = load i8*, i8** %l4
  %t310 = add i8* %t308, %t309
  %s311 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.311, i32 0, i32 0
  %t312 = add i8* %t310, %s311
  %t313 = load i8*, i8** %l19
  %t314 = add i8* %t312, %t313
  %t315 = getelementptr i8, i8* %t314, i64 0
  %t316 = load i8, i8* %t315
  %t317 = add i8 %t316, 96
  %t318 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t304, i8* null)
  store { i8**, i64 }* %t318, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t319 = phi i1 [ 1, %then27 ], [ %t292, %else28 ]
  %t320 = phi double [ %t303, %then27 ], [ %t296, %else28 ]
  %t321 = phi { i8**, i64 }* [ %t286, %then27 ], [ %t318, %else28 ]
  store i1 %t319, i1* %l7
  store double %t320, double* %l11
  store { i8**, i64 }* %t321, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t322 = load i8*, i8** %l14
  %s323 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.323, i32 0, i32 0
  %t324 = call i1 @starts_with(i8* %t322, i8* %s323)
  %t325 = load i8*, i8** %l0
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t327 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t329 = load i8*, i8** %l4
  %t330 = load i1, i1* %l5
  %t331 = load i1, i1* %l6
  %t332 = load i1, i1* %l7
  %t333 = load i1, i1* %l8
  %t334 = load double, double* %l9
  %t335 = load double, double* %l10
  %t336 = load double, double* %l11
  %t337 = load double, double* %l12
  %t338 = load double, double* %l13
  %t339 = load i8*, i8** %l14
  br i1 %t324, label %then30, label %else31
then30:
  %t340 = load i8*, i8** %l14
  %t341 = load i8*, i8** %l14
  %t342 = call i64 @sailfin_runtime_string_length(i8* %t341)
  %t343 = call i8* @sailfin_runtime_substring(i8* %t340, i64 6, i64 %t342)
  store i8* %t343, i8** %l21
  %t344 = load i8*, i8** %l21
  %t345 = call %NumberParseResult @parse_decimal_number(i8* %t344)
  store %NumberParseResult %t345, %NumberParseResult* %l22
  %t346 = load %NumberParseResult, %NumberParseResult* %l22
  %t347 = extractvalue %NumberParseResult %t346, 0
  %t348 = load i8*, i8** %l0
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t350 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t352 = load i8*, i8** %l4
  %t353 = load i1, i1* %l5
  %t354 = load i1, i1* %l6
  %t355 = load i1, i1* %l7
  %t356 = load i1, i1* %l8
  %t357 = load double, double* %l9
  %t358 = load double, double* %l10
  %t359 = load double, double* %l11
  %t360 = load double, double* %l12
  %t361 = load double, double* %l13
  %t362 = load i8*, i8** %l14
  %t363 = load i8*, i8** %l21
  %t364 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t347, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t365 = load %NumberParseResult, %NumberParseResult* %l22
  %t366 = extractvalue %NumberParseResult %t365, 1
  store double %t366, double* %l12
  br label %merge35
else34:
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s368 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.368, i32 0, i32 0
  %t369 = add i8* %s368, %enum_name
  %s370 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.370, i32 0, i32 0
  %t371 = add i8* %t369, %s370
  %t372 = load i8*, i8** %l4
  %t373 = add i8* %t371, %t372
  %s374 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.374, i32 0, i32 0
  %t375 = add i8* %t373, %s374
  %t376 = load i8*, i8** %l21
  %t377 = add i8* %t375, %t376
  %t378 = getelementptr i8, i8* %t377, i64 0
  %t379 = load i8, i8* %t378
  %t380 = add i8 %t379, 96
  %t381 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t367, i8* null)
  store { i8**, i64 }* %t381, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t382 = phi i1 [ 1, %then33 ], [ %t356, %else34 ]
  %t383 = phi double [ %t366, %then33 ], [ %t360, %else34 ]
  %t384 = phi { i8**, i64 }* [ %t349, %then33 ], [ %t381, %else34 ]
  store i1 %t382, i1* %l8
  store double %t383, double* %l12
  store { i8**, i64 }* %t384, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s386 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.386, i32 0, i32 0
  %t387 = add i8* %s386, %enum_name
  %s388 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.388, i32 0, i32 0
  %t389 = add i8* %t387, %s388
  %t390 = load i8*, i8** %l4
  %t391 = add i8* %t389, %t390
  %s392 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.392, i32 0, i32 0
  %t393 = add i8* %t391, %s392
  %t394 = load i8*, i8** %l14
  %t395 = add i8* %t393, %t394
  %t396 = getelementptr i8, i8* %t395, i64 0
  %t397 = load i8, i8* %t396
  %t398 = add i8 %t397, 96
  %t399 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t385, i8* null)
  store { i8**, i64 }* %t399, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t400 = phi i1 [ 1, %then30 ], [ %t333, %else31 ]
  %t401 = phi double [ %t366, %then30 ], [ %t337, %else31 ]
  %t402 = phi { i8**, i64 }* [ %t381, %then30 ], [ %t399, %else31 ]
  store i1 %t400, i1* %l8
  store double %t401, double* %l12
  store { i8**, i64 }* %t402, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t403 = phi i1 [ 1, %then24 ], [ %t269, %else25 ]
  %t404 = phi double [ %t303, %then24 ], [ %t273, %else25 ]
  %t405 = phi { i8**, i64 }* [ %t318, %then24 ], [ %t381, %else25 ]
  %t406 = phi i1 [ %t270, %then24 ], [ 1, %else25 ]
  %t407 = phi double [ %t274, %then24 ], [ %t366, %else25 ]
  store i1 %t403, i1* %l7
  store double %t404, double* %l11
  store { i8**, i64 }* %t405, { i8**, i64 }** %l1
  store i1 %t406, i1* %l8
  store double %t407, double* %l12
  br label %merge20
merge20:
  %t408 = phi i1 [ 1, %then18 ], [ %t205, %else19 ]
  %t409 = phi double [ %t240, %then18 ], [ %t209, %else19 ]
  %t410 = phi { i8**, i64 }* [ %t255, %then18 ], [ %t318, %else19 ]
  %t411 = phi i1 [ %t206, %then18 ], [ 1, %else19 ]
  %t412 = phi double [ %t210, %then18 ], [ %t303, %else19 ]
  %t413 = phi i1 [ %t207, %then18 ], [ 1, %else19 ]
  %t414 = phi double [ %t211, %then18 ], [ %t366, %else19 ]
  store i1 %t408, i1* %l6
  store double %t409, double* %l10
  store { i8**, i64 }* %t410, { i8**, i64 }** %l1
  store i1 %t411, i1* %l7
  store double %t412, double* %l11
  store i1 %t413, i1* %l8
  store double %t414, double* %l12
  br label %merge14
merge14:
  %t415 = phi i1 [ 1, %then12 ], [ %t141, %else13 ]
  %t416 = phi double [ %t177, %then12 ], [ %t145, %else13 ]
  %t417 = phi { i8**, i64 }* [ %t192, %then12 ], [ %t255, %else13 ]
  %t418 = phi i1 [ %t142, %then12 ], [ 1, %else13 ]
  %t419 = phi double [ %t146, %then12 ], [ %t240, %else13 ]
  %t420 = phi i1 [ %t143, %then12 ], [ 1, %else13 ]
  %t421 = phi double [ %t147, %then12 ], [ %t303, %else13 ]
  %t422 = phi i1 [ %t144, %then12 ], [ 1, %else13 ]
  %t423 = phi double [ %t148, %then12 ], [ %t366, %else13 ]
  store i1 %t415, i1* %l5
  store double %t416, double* %l9
  store { i8**, i64 }* %t417, { i8**, i64 }** %l1
  store i1 %t418, i1* %l6
  store double %t419, double* %l10
  store i1 %t420, i1* %l7
  store double %t421, double* %l11
  store i1 %t422, i1* %l8
  store double %t423, double* %l12
  %t424 = load double, double* %l13
  %t425 = sitofp i64 1 to double
  %t426 = fadd double %t424, %t425
  store double %t426, double* %l13
  br label %loop.latch8
loop.latch8:
  %t427 = load i1, i1* %l5
  %t428 = load double, double* %l9
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t430 = load i1, i1* %l6
  %t431 = load double, double* %l10
  %t432 = load i1, i1* %l7
  %t433 = load double, double* %l11
  %t434 = load i1, i1* %l8
  %t435 = load double, double* %l12
  %t436 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t447 = load i1, i1* %l5
  %t448 = xor i1 %t447, 1
  %t449 = load i8*, i8** %l0
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t453 = load i8*, i8** %l4
  %t454 = load i1, i1* %l5
  %t455 = load i1, i1* %l6
  %t456 = load i1, i1* %l7
  %t457 = load i1, i1* %l8
  %t458 = load double, double* %l9
  %t459 = load double, double* %l10
  %t460 = load double, double* %l11
  %t461 = load double, double* %l12
  %t462 = load double, double* %l13
  br i1 %t448, label %then36, label %merge37
then36:
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s464 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.464, i32 0, i32 0
  %t465 = add i8* %s464, %enum_name
  %s466 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.466, i32 0, i32 0
  %t467 = add i8* %t465, %s466
  %t468 = load i8*, i8** %l4
  %t469 = add i8* %t467, %t468
  %s470 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.470, i32 0, i32 0
  %t471 = add i8* %t469, %s470
  %t472 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t463, i8* %t471)
  store { i8**, i64 }* %t472, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t473 = phi { i8**, i64 }* [ %t472, %then36 ], [ %t450, %entry ]
  store { i8**, i64 }* %t473, { i8**, i64 }** %l1
  %t474 = load i1, i1* %l6
  %t475 = xor i1 %t474, 1
  %t476 = load i8*, i8** %l0
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t480 = load i8*, i8** %l4
  %t481 = load i1, i1* %l5
  %t482 = load i1, i1* %l6
  %t483 = load i1, i1* %l7
  %t484 = load i1, i1* %l8
  %t485 = load double, double* %l9
  %t486 = load double, double* %l10
  %t487 = load double, double* %l11
  %t488 = load double, double* %l12
  %t489 = load double, double* %l13
  br i1 %t475, label %then38, label %merge39
then38:
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s491 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.491, i32 0, i32 0
  %t492 = add i8* %s491, %enum_name
  %s493 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.493, i32 0, i32 0
  %t494 = add i8* %t492, %s493
  %t495 = load i8*, i8** %l4
  %t496 = add i8* %t494, %t495
  %s497 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.497, i32 0, i32 0
  %t498 = add i8* %t496, %s497
  %t499 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t490, i8* %t498)
  store { i8**, i64 }* %t499, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t500 = phi { i8**, i64 }* [ %t499, %then38 ], [ %t477, %entry ]
  store { i8**, i64 }* %t500, { i8**, i64 }** %l1
  %t501 = load i1, i1* %l7
  %t502 = xor i1 %t501, 1
  %t503 = load i8*, i8** %l0
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t505 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t507 = load i8*, i8** %l4
  %t508 = load i1, i1* %l5
  %t509 = load i1, i1* %l6
  %t510 = load i1, i1* %l7
  %t511 = load i1, i1* %l8
  %t512 = load double, double* %l9
  %t513 = load double, double* %l10
  %t514 = load double, double* %l11
  %t515 = load double, double* %l12
  %t516 = load double, double* %l13
  br i1 %t502, label %then40, label %merge41
then40:
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s518 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.518, i32 0, i32 0
  %t519 = add i8* %s518, %enum_name
  %s520 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.520, i32 0, i32 0
  %t521 = add i8* %t519, %s520
  %t522 = load i8*, i8** %l4
  %t523 = add i8* %t521, %t522
  %s524 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.524, i32 0, i32 0
  %t525 = add i8* %t523, %s524
  %t526 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t517, i8* %t525)
  store { i8**, i64 }* %t526, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t527 = phi { i8**, i64 }* [ %t526, %then40 ], [ %t504, %entry ]
  store { i8**, i64 }* %t527, { i8**, i64 }** %l1
  %t528 = load i1, i1* %l8
  %t529 = xor i1 %t528, 1
  %t530 = load i8*, i8** %l0
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t532 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t534 = load i8*, i8** %l4
  %t535 = load i1, i1* %l5
  %t536 = load i1, i1* %l6
  %t537 = load i1, i1* %l7
  %t538 = load i1, i1* %l8
  %t539 = load double, double* %l9
  %t540 = load double, double* %l10
  %t541 = load double, double* %l11
  %t542 = load double, double* %l12
  %t543 = load double, double* %l13
  br i1 %t529, label %then42, label %merge43
then42:
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s545 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.545, i32 0, i32 0
  %t546 = add i8* %s545, %enum_name
  %s547 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.547, i32 0, i32 0
  %t548 = add i8* %t546, %s547
  %t549 = load i8*, i8** %l4
  %t550 = add i8* %t548, %t549
  %s551 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.551, i32 0, i32 0
  %t552 = add i8* %t550, %s551
  %t553 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t544, i8* %t552)
  store { i8**, i64 }* %t553, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t554 = phi { i8**, i64 }* [ %t553, %then42 ], [ %t531, %entry ]
  store { i8**, i64 }* %t554, { i8**, i64 }** %l1
  %t559 = load i1, i1* %l5
  br label %logical_and_entry_558

logical_and_entry_558:
  br i1 %t559, label %logical_and_right_558, label %logical_and_merge_558

logical_and_right_558:
  %t560 = load i1, i1* %l6
  br label %logical_and_right_end_558

logical_and_right_end_558:
  br label %logical_and_merge_558

logical_and_merge_558:
  %t561 = phi i1 [ false, %logical_and_entry_558 ], [ %t560, %logical_and_right_end_558 ]
  br label %logical_and_entry_557

logical_and_entry_557:
  br i1 %t561, label %logical_and_right_557, label %logical_and_merge_557

logical_and_right_557:
  %t562 = load i1, i1* %l7
  br label %logical_and_right_end_557

logical_and_right_end_557:
  br label %logical_and_merge_557

logical_and_merge_557:
  %t563 = phi i1 [ false, %logical_and_entry_557 ], [ %t562, %logical_and_right_end_557 ]
  br label %logical_and_entry_556

logical_and_entry_556:
  br i1 %t563, label %logical_and_right_556, label %logical_and_merge_556

logical_and_right_556:
  %t564 = load i1, i1* %l8
  br label %logical_and_right_end_556

logical_and_right_end_556:
  br label %logical_and_merge_556

logical_and_merge_556:
  %t565 = phi i1 [ false, %logical_and_entry_556 ], [ %t564, %logical_and_right_end_556 ]
  br label %logical_and_entry_555

logical_and_entry_555:
  br i1 %t565, label %logical_and_right_555, label %logical_and_merge_555

logical_and_right_555:
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t567 = load { i8**, i64 }, { i8**, i64 }* %t566
  %t568 = extractvalue { i8**, i64 } %t567, 1
  %t569 = icmp eq i64 %t568, 0
  br label %logical_and_right_end_555

logical_and_right_end_555:
  br label %logical_and_merge_555

logical_and_merge_555:
  %t570 = phi i1 [ false, %logical_and_entry_555 ], [ %t569, %logical_and_right_end_555 ]
  store i1 %t570, i1* %l23
  %t571 = load i8*, i8** %l4
  %t572 = insertvalue %NativeEnumVariantLayout undef, i8* %t571, 0
  %t573 = load double, double* %l9
  %t574 = insertvalue %NativeEnumVariantLayout %t572, double %t573, 1
  %t575 = load double, double* %l10
  %t576 = insertvalue %NativeEnumVariantLayout %t574, double %t575, 2
  %t577 = load double, double* %l11
  %t578 = insertvalue %NativeEnumVariantLayout %t576, double %t577, 3
  %t579 = load double, double* %l12
  %t580 = insertvalue %NativeEnumVariantLayout %t578, double %t579, 4
  %t581 = alloca [0 x i8*]
  %t582 = getelementptr [0 x i8*], [0 x i8*]* %t581, i32 0, i32 0
  %t583 = alloca { i8**, i64 }
  %t584 = getelementptr { i8**, i64 }, { i8**, i64 }* %t583, i32 0, i32 0
  store i8** %t582, i8*** %t584
  %t585 = getelementptr { i8**, i64 }, { i8**, i64 }* %t583, i32 0, i32 1
  store i64 0, i64* %t585
  %t586 = insertvalue %NativeEnumVariantLayout %t580, { i8**, i64 }* %t583, 5
  store %NativeEnumVariantLayout %t586, %NativeEnumVariantLayout* %l24
  %t587 = load i1, i1* %l23
  %t588 = insertvalue %EnumLayoutVariantParse undef, i1 %t587, 0
  %t589 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t590 = insertvalue %EnumLayoutVariantParse %t588, i8* null, 1
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t592 = insertvalue %EnumLayoutVariantParse %t590, { i8**, i64 }* %t591, 2
  ret %EnumLayoutVariantParse %t592
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
  %t440 = phi i8* [ %t127, %entry ], [ %t431, %loop.latch8 ]
  %t441 = phi i1 [ %t128, %entry ], [ %t432, %loop.latch8 ]
  %t442 = phi double [ %t131, %entry ], [ %t433, %loop.latch8 ]
  %t443 = phi { i8**, i64 }* [ %t120, %entry ], [ %t434, %loop.latch8 ]
  %t444 = phi i1 [ %t129, %entry ], [ %t435, %loop.latch8 ]
  %t445 = phi double [ %t132, %entry ], [ %t436, %loop.latch8 ]
  %t446 = phi i1 [ %t130, %entry ], [ %t437, %loop.latch8 ]
  %t447 = phi double [ %t133, %entry ], [ %t438, %loop.latch8 ]
  %t448 = phi double [ %t134, %entry ], [ %t439, %loop.latch8 ]
  store i8* %t440, i8** %l8
  store i1 %t441, i1* %l9
  store double %t442, double* %l12
  store { i8**, i64 }* %t443, { i8**, i64 }** %l1
  store i1 %t444, i1* %l10
  store double %t445, double* %l13
  store i1 %t446, i1* %l11
  store double %t447, double* %l14
  store double %t448, double* %l15
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
  %t159 = load { i8**, i64 }, { i8**, i64 }* %t157
  %t160 = extractvalue { i8**, i64 } %t159, 0
  %t161 = extractvalue { i8**, i64 } %t159, 1
  %t162 = icmp uge i64 %t158, %t161
  ; bounds check: %t162 (if true, out of bounds)
  %t163 = getelementptr i8*, i8** %t160, i64 %t158
  %t164 = load i8*, i8** %t163
  store i8* %t164, i8** %l16
  %t165 = load i8*, i8** %l16
  %s166 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.166, i32 0, i32 0
  %t167 = call i1 @starts_with(i8* %t165, i8* %s166)
  %t168 = load i8*, i8** %l0
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t170 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t172 = load i8*, i8** %l4
  %t173 = load double, double* %l5
  %t174 = load i8*, i8** %l6
  %t175 = load i8*, i8** %l7
  %t176 = load i8*, i8** %l8
  %t177 = load i1, i1* %l9
  %t178 = load i1, i1* %l10
  %t179 = load i1, i1* %l11
  %t180 = load double, double* %l12
  %t181 = load double, double* %l13
  %t182 = load double, double* %l14
  %t183 = load double, double* %l15
  %t184 = load i8*, i8** %l16
  br i1 %t167, label %then12, label %else13
then12:
  %t185 = load i8*, i8** %l16
  %t186 = load i8*, i8** %l16
  %t187 = call i64 @sailfin_runtime_string_length(i8* %t186)
  %t188 = call i8* @sailfin_runtime_substring(i8* %t185, i64 5, i64 %t187)
  store i8* %t188, i8** %l8
  br label %merge14
else13:
  %t189 = load i8*, i8** %l16
  %s190 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.190, i32 0, i32 0
  %t191 = call i1 @starts_with(i8* %t189, i8* %s190)
  %t192 = load i8*, i8** %l0
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t194 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t196 = load i8*, i8** %l4
  %t197 = load double, double* %l5
  %t198 = load i8*, i8** %l6
  %t199 = load i8*, i8** %l7
  %t200 = load i8*, i8** %l8
  %t201 = load i1, i1* %l9
  %t202 = load i1, i1* %l10
  %t203 = load i1, i1* %l11
  %t204 = load double, double* %l12
  %t205 = load double, double* %l13
  %t206 = load double, double* %l14
  %t207 = load double, double* %l15
  %t208 = load i8*, i8** %l16
  br i1 %t191, label %then15, label %else16
then15:
  %t209 = load i8*, i8** %l16
  %t210 = load i8*, i8** %l16
  %t211 = call i64 @sailfin_runtime_string_length(i8* %t210)
  %t212 = call i8* @sailfin_runtime_substring(i8* %t209, i64 7, i64 %t211)
  store i8* %t212, i8** %l17
  %t213 = load i8*, i8** %l17
  %t214 = call %NumberParseResult @parse_decimal_number(i8* %t213)
  store %NumberParseResult %t214, %NumberParseResult* %l18
  %t215 = load %NumberParseResult, %NumberParseResult* %l18
  %t216 = extractvalue %NumberParseResult %t215, 0
  %t217 = load i8*, i8** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t221 = load i8*, i8** %l4
  %t222 = load double, double* %l5
  %t223 = load i8*, i8** %l6
  %t224 = load i8*, i8** %l7
  %t225 = load i8*, i8** %l8
  %t226 = load i1, i1* %l9
  %t227 = load i1, i1* %l10
  %t228 = load i1, i1* %l11
  %t229 = load double, double* %l12
  %t230 = load double, double* %l13
  %t231 = load double, double* %l14
  %t232 = load double, double* %l15
  %t233 = load i8*, i8** %l16
  %t234 = load i8*, i8** %l17
  %t235 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t216, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t236 = load %NumberParseResult, %NumberParseResult* %l18
  %t237 = extractvalue %NumberParseResult %t236, 1
  store double %t237, double* %l12
  br label %merge20
else19:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s239 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.239, i32 0, i32 0
  %t240 = add i8* %s239, %enum_name
  %s241 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.241, i32 0, i32 0
  %t242 = add i8* %t240, %s241
  %t243 = load i8*, i8** %l4
  %t244 = add i8* %t242, %t243
  %s245 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.245, i32 0, i32 0
  %t246 = add i8* %t244, %s245
  %t247 = load i8*, i8** %l17
  %t248 = add i8* %t246, %t247
  %t249 = getelementptr i8, i8* %t248, i64 0
  %t250 = load i8, i8* %t249
  %t251 = add i8 %t250, 96
  %t252 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* null)
  store { i8**, i64 }* %t252, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t253 = phi i1 [ 1, %then18 ], [ %t226, %else19 ]
  %t254 = phi double [ %t237, %then18 ], [ %t229, %else19 ]
  %t255 = phi { i8**, i64 }* [ %t218, %then18 ], [ %t252, %else19 ]
  store i1 %t253, i1* %l9
  store double %t254, double* %l12
  store { i8**, i64 }* %t255, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t256 = load i8*, i8** %l16
  %s257 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.257, i32 0, i32 0
  %t258 = call i1 @starts_with(i8* %t256, i8* %s257)
  %t259 = load i8*, i8** %l0
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t261 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t263 = load i8*, i8** %l4
  %t264 = load double, double* %l5
  %t265 = load i8*, i8** %l6
  %t266 = load i8*, i8** %l7
  %t267 = load i8*, i8** %l8
  %t268 = load i1, i1* %l9
  %t269 = load i1, i1* %l10
  %t270 = load i1, i1* %l11
  %t271 = load double, double* %l12
  %t272 = load double, double* %l13
  %t273 = load double, double* %l14
  %t274 = load double, double* %l15
  %t275 = load i8*, i8** %l16
  br i1 %t258, label %then21, label %else22
then21:
  %t276 = load i8*, i8** %l16
  %t277 = load i8*, i8** %l16
  %t278 = call i64 @sailfin_runtime_string_length(i8* %t277)
  %t279 = call i8* @sailfin_runtime_substring(i8* %t276, i64 5, i64 %t278)
  store i8* %t279, i8** %l19
  %t280 = load i8*, i8** %l19
  %t281 = call %NumberParseResult @parse_decimal_number(i8* %t280)
  store %NumberParseResult %t281, %NumberParseResult* %l20
  %t282 = load %NumberParseResult, %NumberParseResult* %l20
  %t283 = extractvalue %NumberParseResult %t282, 0
  %t284 = load i8*, i8** %l0
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t286 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t288 = load i8*, i8** %l4
  %t289 = load double, double* %l5
  %t290 = load i8*, i8** %l6
  %t291 = load i8*, i8** %l7
  %t292 = load i8*, i8** %l8
  %t293 = load i1, i1* %l9
  %t294 = load i1, i1* %l10
  %t295 = load i1, i1* %l11
  %t296 = load double, double* %l12
  %t297 = load double, double* %l13
  %t298 = load double, double* %l14
  %t299 = load double, double* %l15
  %t300 = load i8*, i8** %l16
  %t301 = load i8*, i8** %l19
  %t302 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t283, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t303 = load %NumberParseResult, %NumberParseResult* %l20
  %t304 = extractvalue %NumberParseResult %t303, 1
  store double %t304, double* %l13
  br label %merge26
else25:
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
  br label %merge26
merge26:
  %t320 = phi i1 [ 1, %then24 ], [ %t294, %else25 ]
  %t321 = phi double [ %t304, %then24 ], [ %t297, %else25 ]
  %t322 = phi { i8**, i64 }* [ %t285, %then24 ], [ %t319, %else25 ]
  store i1 %t320, i1* %l10
  store double %t321, double* %l13
  store { i8**, i64 }* %t322, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t323 = load i8*, i8** %l16
  %s324 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.324, i32 0, i32 0
  %t325 = call i1 @starts_with(i8* %t323, i8* %s324)
  %t326 = load i8*, i8** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t330 = load i8*, i8** %l4
  %t331 = load double, double* %l5
  %t332 = load i8*, i8** %l6
  %t333 = load i8*, i8** %l7
  %t334 = load i8*, i8** %l8
  %t335 = load i1, i1* %l9
  %t336 = load i1, i1* %l10
  %t337 = load i1, i1* %l11
  %t338 = load double, double* %l12
  %t339 = load double, double* %l13
  %t340 = load double, double* %l14
  %t341 = load double, double* %l15
  %t342 = load i8*, i8** %l16
  br i1 %t325, label %then27, label %else28
then27:
  %t343 = load i8*, i8** %l16
  %t344 = load i8*, i8** %l16
  %t345 = call i64 @sailfin_runtime_string_length(i8* %t344)
  %t346 = call i8* @sailfin_runtime_substring(i8* %t343, i64 6, i64 %t345)
  store i8* %t346, i8** %l21
  %t347 = load i8*, i8** %l21
  %t348 = call %NumberParseResult @parse_decimal_number(i8* %t347)
  store %NumberParseResult %t348, %NumberParseResult* %l22
  %t349 = load %NumberParseResult, %NumberParseResult* %l22
  %t350 = extractvalue %NumberParseResult %t349, 0
  %t351 = load i8*, i8** %l0
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t353 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t355 = load i8*, i8** %l4
  %t356 = load double, double* %l5
  %t357 = load i8*, i8** %l6
  %t358 = load i8*, i8** %l7
  %t359 = load i8*, i8** %l8
  %t360 = load i1, i1* %l9
  %t361 = load i1, i1* %l10
  %t362 = load i1, i1* %l11
  %t363 = load double, double* %l12
  %t364 = load double, double* %l13
  %t365 = load double, double* %l14
  %t366 = load double, double* %l15
  %t367 = load i8*, i8** %l16
  %t368 = load i8*, i8** %l21
  %t369 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t350, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t370 = load %NumberParseResult, %NumberParseResult* %l22
  %t371 = extractvalue %NumberParseResult %t370, 1
  store double %t371, double* %l14
  br label %merge32
else31:
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s373 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.373, i32 0, i32 0
  %t374 = add i8* %s373, %enum_name
  %s375 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.375, i32 0, i32 0
  %t376 = add i8* %t374, %s375
  %t377 = load i8*, i8** %l4
  %t378 = add i8* %t376, %t377
  %s379 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.379, i32 0, i32 0
  %t380 = add i8* %t378, %s379
  %t381 = load i8*, i8** %l21
  %t382 = add i8* %t380, %t381
  %t383 = getelementptr i8, i8* %t382, i64 0
  %t384 = load i8, i8* %t383
  %t385 = add i8 %t384, 96
  %t386 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t372, i8* null)
  store { i8**, i64 }* %t386, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t387 = phi i1 [ 1, %then30 ], [ %t362, %else31 ]
  %t388 = phi double [ %t371, %then30 ], [ %t365, %else31 ]
  %t389 = phi { i8**, i64 }* [ %t352, %then30 ], [ %t386, %else31 ]
  store i1 %t387, i1* %l11
  store double %t388, double* %l14
  store { i8**, i64 }* %t389, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s391 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.391, i32 0, i32 0
  %t392 = add i8* %s391, %enum_name
  %s393 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.393, i32 0, i32 0
  %t394 = add i8* %t392, %s393
  %t395 = load i8*, i8** %l4
  %t396 = add i8* %t394, %t395
  %s397 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.397, i32 0, i32 0
  %t398 = add i8* %t396, %s397
  %t399 = load i8*, i8** %l16
  %t400 = add i8* %t398, %t399
  %t401 = getelementptr i8, i8* %t400, i64 0
  %t402 = load i8, i8* %t401
  %t403 = add i8 %t402, 96
  %t404 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t390, i8* null)
  store { i8**, i64 }* %t404, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t405 = phi i1 [ 1, %then27 ], [ %t337, %else28 ]
  %t406 = phi double [ %t371, %then27 ], [ %t340, %else28 ]
  %t407 = phi { i8**, i64 }* [ %t386, %then27 ], [ %t404, %else28 ]
  store i1 %t405, i1* %l11
  store double %t406, double* %l14
  store { i8**, i64 }* %t407, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t408 = phi i1 [ 1, %then21 ], [ %t269, %else22 ]
  %t409 = phi double [ %t304, %then21 ], [ %t272, %else22 ]
  %t410 = phi { i8**, i64 }* [ %t319, %then21 ], [ %t386, %else22 ]
  %t411 = phi i1 [ %t270, %then21 ], [ 1, %else22 ]
  %t412 = phi double [ %t273, %then21 ], [ %t371, %else22 ]
  store i1 %t408, i1* %l10
  store double %t409, double* %l13
  store { i8**, i64 }* %t410, { i8**, i64 }** %l1
  store i1 %t411, i1* %l11
  store double %t412, double* %l14
  br label %merge17
merge17:
  %t413 = phi i1 [ 1, %then15 ], [ %t201, %else16 ]
  %t414 = phi double [ %t237, %then15 ], [ %t204, %else16 ]
  %t415 = phi { i8**, i64 }* [ %t252, %then15 ], [ %t319, %else16 ]
  %t416 = phi i1 [ %t202, %then15 ], [ 1, %else16 ]
  %t417 = phi double [ %t205, %then15 ], [ %t304, %else16 ]
  %t418 = phi i1 [ %t203, %then15 ], [ 1, %else16 ]
  %t419 = phi double [ %t206, %then15 ], [ %t371, %else16 ]
  store i1 %t413, i1* %l9
  store double %t414, double* %l12
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  store i1 %t416, i1* %l10
  store double %t417, double* %l13
  store i1 %t418, i1* %l11
  store double %t419, double* %l14
  br label %merge14
merge14:
  %t420 = phi i8* [ %t188, %then12 ], [ %t176, %else13 ]
  %t421 = phi i1 [ %t177, %then12 ], [ 1, %else13 ]
  %t422 = phi double [ %t180, %then12 ], [ %t237, %else13 ]
  %t423 = phi { i8**, i64 }* [ %t169, %then12 ], [ %t252, %else13 ]
  %t424 = phi i1 [ %t178, %then12 ], [ 1, %else13 ]
  %t425 = phi double [ %t181, %then12 ], [ %t304, %else13 ]
  %t426 = phi i1 [ %t179, %then12 ], [ 1, %else13 ]
  %t427 = phi double [ %t182, %then12 ], [ %t371, %else13 ]
  store i8* %t420, i8** %l8
  store i1 %t421, i1* %l9
  store double %t422, double* %l12
  store { i8**, i64 }* %t423, { i8**, i64 }** %l1
  store i1 %t424, i1* %l10
  store double %t425, double* %l13
  store i1 %t426, i1* %l11
  store double %t427, double* %l14
  %t428 = load double, double* %l15
  %t429 = sitofp i64 1 to double
  %t430 = fadd double %t428, %t429
  store double %t430, double* %l15
  br label %loop.latch8
loop.latch8:
  %t431 = load i8*, i8** %l8
  %t432 = load i1, i1* %l9
  %t433 = load double, double* %l12
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t435 = load i1, i1* %l10
  %t436 = load double, double* %l13
  %t437 = load i1, i1* %l11
  %t438 = load double, double* %l14
  %t439 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t449 = load i8*, i8** %l8
  %t450 = call i64 @sailfin_runtime_string_length(i8* %t449)
  %t451 = icmp eq i64 %t450, 0
  %t452 = load i8*, i8** %l0
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t454 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t456 = load i8*, i8** %l4
  %t457 = load double, double* %l5
  %t458 = load i8*, i8** %l6
  %t459 = load i8*, i8** %l7
  %t460 = load i8*, i8** %l8
  %t461 = load i1, i1* %l9
  %t462 = load i1, i1* %l10
  %t463 = load i1, i1* %l11
  %t464 = load double, double* %l12
  %t465 = load double, double* %l13
  %t466 = load double, double* %l14
  %t467 = load double, double* %l15
  br i1 %t451, label %then33, label %merge34
then33:
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s469 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.469, i32 0, i32 0
  %t470 = add i8* %s469, %enum_name
  %s471 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.471, i32 0, i32 0
  %t472 = add i8* %t470, %s471
  %t473 = load i8*, i8** %l4
  %t474 = add i8* %t472, %t473
  %s475 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.475, i32 0, i32 0
  %t476 = add i8* %t474, %s475
  %t477 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t468, i8* %t476)
  store { i8**, i64 }* %t477, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t478 = phi { i8**, i64 }* [ %t477, %then33 ], [ %t453, %entry ]
  store { i8**, i64 }* %t478, { i8**, i64 }** %l1
  %t479 = load i1, i1* %l9
  %t480 = xor i1 %t479, 1
  %t481 = load i8*, i8** %l0
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t485 = load i8*, i8** %l4
  %t486 = load double, double* %l5
  %t487 = load i8*, i8** %l6
  %t488 = load i8*, i8** %l7
  %t489 = load i8*, i8** %l8
  %t490 = load i1, i1* %l9
  %t491 = load i1, i1* %l10
  %t492 = load i1, i1* %l11
  %t493 = load double, double* %l12
  %t494 = load double, double* %l13
  %t495 = load double, double* %l14
  %t496 = load double, double* %l15
  br i1 %t480, label %then35, label %merge36
then35:
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s498 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.498, i32 0, i32 0
  %t499 = add i8* %s498, %enum_name
  %s500 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.500, i32 0, i32 0
  %t501 = add i8* %t499, %s500
  %t502 = load i8*, i8** %l4
  %t503 = add i8* %t501, %t502
  %s504 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.504, i32 0, i32 0
  %t505 = add i8* %t503, %s504
  %t506 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t497, i8* %t505)
  store { i8**, i64 }* %t506, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t507 = phi { i8**, i64 }* [ %t506, %then35 ], [ %t482, %entry ]
  store { i8**, i64 }* %t507, { i8**, i64 }** %l1
  %t508 = load i1, i1* %l10
  %t509 = xor i1 %t508, 1
  %t510 = load i8*, i8** %l0
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t512 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t514 = load i8*, i8** %l4
  %t515 = load double, double* %l5
  %t516 = load i8*, i8** %l6
  %t517 = load i8*, i8** %l7
  %t518 = load i8*, i8** %l8
  %t519 = load i1, i1* %l9
  %t520 = load i1, i1* %l10
  %t521 = load i1, i1* %l11
  %t522 = load double, double* %l12
  %t523 = load double, double* %l13
  %t524 = load double, double* %l14
  %t525 = load double, double* %l15
  br i1 %t509, label %then37, label %merge38
then37:
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s527 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.527, i32 0, i32 0
  %t528 = add i8* %s527, %enum_name
  %s529 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.529, i32 0, i32 0
  %t530 = add i8* %t528, %s529
  %t531 = load i8*, i8** %l4
  %t532 = add i8* %t530, %t531
  %s533 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.533, i32 0, i32 0
  %t534 = add i8* %t532, %s533
  %t535 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t526, i8* %t534)
  store { i8**, i64 }* %t535, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t536 = phi { i8**, i64 }* [ %t535, %then37 ], [ %t511, %entry ]
  store { i8**, i64 }* %t536, { i8**, i64 }** %l1
  %t537 = load i1, i1* %l11
  %t538 = xor i1 %t537, 1
  %t539 = load i8*, i8** %l0
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t541 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t543 = load i8*, i8** %l4
  %t544 = load double, double* %l5
  %t545 = load i8*, i8** %l6
  %t546 = load i8*, i8** %l7
  %t547 = load i8*, i8** %l8
  %t548 = load i1, i1* %l9
  %t549 = load i1, i1* %l10
  %t550 = load i1, i1* %l11
  %t551 = load double, double* %l12
  %t552 = load double, double* %l13
  %t553 = load double, double* %l14
  %t554 = load double, double* %l15
  br i1 %t538, label %then39, label %merge40
then39:
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s556 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.556, i32 0, i32 0
  %t557 = add i8* %s556, %enum_name
  %s558 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.558, i32 0, i32 0
  %t559 = add i8* %t557, %s558
  %t560 = load i8*, i8** %l4
  %t561 = add i8* %t559, %t560
  %s562 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.562, i32 0, i32 0
  %t563 = add i8* %t561, %s562
  %t564 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t555, i8* %t563)
  store { i8**, i64 }* %t564, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t565 = phi { i8**, i64 }* [ %t564, %then39 ], [ %t540, %entry ]
  store { i8**, i64 }* %t565, { i8**, i64 }** %l1
  %t570 = load i8*, i8** %l8
  %t571 = call i64 @sailfin_runtime_string_length(i8* %t570)
  %t572 = icmp sgt i64 %t571, 0
  br label %logical_and_entry_569

logical_and_entry_569:
  br i1 %t572, label %logical_and_right_569, label %logical_and_merge_569

logical_and_right_569:
  %t573 = load i1, i1* %l9
  br label %logical_and_right_end_569

logical_and_right_end_569:
  br label %logical_and_merge_569

logical_and_merge_569:
  %t574 = phi i1 [ false, %logical_and_entry_569 ], [ %t573, %logical_and_right_end_569 ]
  br label %logical_and_entry_568

logical_and_entry_568:
  br i1 %t574, label %logical_and_right_568, label %logical_and_merge_568

logical_and_right_568:
  %t575 = load i1, i1* %l10
  br label %logical_and_right_end_568

logical_and_right_end_568:
  br label %logical_and_merge_568

logical_and_merge_568:
  %t576 = phi i1 [ false, %logical_and_entry_568 ], [ %t575, %logical_and_right_end_568 ]
  br label %logical_and_entry_567

logical_and_entry_567:
  br i1 %t576, label %logical_and_right_567, label %logical_and_merge_567

logical_and_right_567:
  %t577 = load i1, i1* %l11
  br label %logical_and_right_end_567

logical_and_right_end_567:
  br label %logical_and_merge_567

logical_and_merge_567:
  %t578 = phi i1 [ false, %logical_and_entry_567 ], [ %t577, %logical_and_right_end_567 ]
  br label %logical_and_entry_566

logical_and_entry_566:
  br i1 %t578, label %logical_and_right_566, label %logical_and_merge_566

logical_and_right_566:
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t580 = load { i8**, i64 }, { i8**, i64 }* %t579
  %t581 = extractvalue { i8**, i64 } %t580, 1
  %t582 = icmp eq i64 %t581, 0
  br label %logical_and_right_end_566

logical_and_right_end_566:
  br label %logical_and_merge_566

logical_and_merge_566:
  %t583 = phi i1 [ false, %logical_and_entry_566 ], [ %t582, %logical_and_right_end_566 ]
  store i1 %t583, i1* %l23
  %t584 = load i8*, i8** %l7
  %t585 = insertvalue %NativeStructLayoutField undef, i8* %t584, 0
  %t586 = load i8*, i8** %l8
  %t587 = insertvalue %NativeStructLayoutField %t585, i8* %t586, 1
  %t588 = load double, double* %l12
  %t589 = insertvalue %NativeStructLayoutField %t587, double %t588, 2
  %t590 = load double, double* %l13
  %t591 = insertvalue %NativeStructLayoutField %t589, double %t590, 3
  %t592 = load double, double* %l14
  %t593 = insertvalue %NativeStructLayoutField %t591, double %t592, 4
  store %NativeStructLayoutField %t593, %NativeStructLayoutField* %l24
  %t594 = load i1, i1* %l23
  %t595 = insertvalue %EnumLayoutPayloadParse undef, i1 %t594, 0
  %t596 = load i8*, i8** %l6
  %t597 = insertvalue %EnumLayoutPayloadParse %t595, i8* %t596, 1
  %t598 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t599 = insertvalue %EnumLayoutPayloadParse %t597, i8* null, 2
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t601 = insertvalue %EnumLayoutPayloadParse %t599, { i8**, i64 }* %t600, 3
  ret %EnumLayoutPayloadParse %t601
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
  %t36 = phi i8* [ %t2, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t3, %entry ], [ %t35, %loop.latch2 ]
  store i8* %t36, i8** %l0
  store double %t37, double* %l1
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
  %t11 = getelementptr i8, i8* %text, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 32
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t16, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t17 = load i8, i8* %l2
  %t18 = icmp eq i8 %t17, 58
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t19 = phi i1 [ true, %logical_or_entry_14 ], [ %t18, %logical_or_right_end_14 ]
  br label %logical_or_entry_13

logical_or_entry_13:
  br i1 %t19, label %logical_or_merge_13, label %logical_or_right_13

logical_or_right_13:
  %t20 = load i8, i8* %l2
  %t21 = icmp eq i8 %t20, 61
  br label %logical_or_right_end_13

logical_or_right_end_13:
  br label %logical_or_merge_13

logical_or_merge_13:
  %t22 = phi i1 [ true, %logical_or_entry_13 ], [ %t21, %logical_or_right_end_13 ]
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load i8, i8* %l2
  br i1 %t22, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t26 = load i8*, i8** %l0
  %t27 = load i8, i8* %l2
  %t28 = getelementptr i8, i8* %t26, i64 0
  %t29 = load i8, i8* %t28
  %t30 = add i8 %t29, %t27
  store i8* null, i8** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load i8*, i8** %l0
  %t39 = call i8* @trim_text(i8* %t38)
  store i8* %t39, i8** %l0
  %s40 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.40, i32 0, i32 0
  store i8* %s40, i8** %l3
  store i8* null, i8** %l4
  %t41 = load double, double* %l1
  %t42 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t43 = fptosi double %t41 to i64
  %t44 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t43, i64 %t42)
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l5
  %t46 = load i8*, i8** %l5
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = icmp sgt i64 %t47, 0
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load i8*, i8** %l3
  %t52 = load i8*, i8** %l4
  %t53 = load i8*, i8** %l5
  br i1 %t48, label %then8, label %merge9
then8:
  %t54 = load i8*, i8** %l5
  br label %merge9
merge9:
  %t55 = load i8*, i8** %l0
  %t56 = insertvalue %BindingComponents undef, i8* %t55, 0
  %t57 = load i8*, i8** %l3
  %t58 = insertvalue %BindingComponents %t56, i8* %t57, 1
  %t59 = load i8*, i8** %l4
  %t60 = insertvalue %BindingComponents %t58, i8* %t59, 2
  ret %BindingComponents %t60
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
  %t220 = phi i8* [ %t10, %entry ], [ %t215, %loop.latch2 ]
  %t221 = phi double [ %t11, %entry ], [ %t216, %loop.latch2 ]
  %t222 = phi i8* [ %t13, %entry ], [ %t217, %loop.latch2 ]
  %t223 = phi double [ %t12, %entry ], [ %t218, %loop.latch2 ]
  %t224 = phi { i8**, i64 }* [ %t9, %entry ], [ %t219, %loop.latch2 ]
  store i8* %t220, i8** %l1
  store double %t221, double* %l2
  store i8* %t222, i8** %l4
  store double %t223, double* %l3
  store { i8**, i64 }* %t224, { i8**, i64 }** %l0
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
  %t24 = getelementptr i8, i8* %body, i64 %t23
  %t25 = load i8, i8* %t24
  store i8 %t25, i8* %l5
  %t26 = load i8*, i8** %l4
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = icmp sgt i64 %t27, 0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load i8*, i8** %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load i8*, i8** %l4
  %t34 = load i8, i8* %l5
  br i1 %t28, label %then6, label %merge7
then6:
  %t35 = load i8*, i8** %l1
  %t36 = load i8, i8* %l5
  %t37 = getelementptr i8, i8* %t35, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, %t36
  store i8* null, i8** %l1
  %t40 = load i8, i8* %l5
  %t41 = icmp eq i8 %t40, 92
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i8*, i8** %l4
  %t47 = load i8, i8* %l5
  br i1 %t41, label %then8, label %merge9
then8:
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  %t51 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t52 = sitofp i64 %t51 to double
  %t53 = fcmp olt double %t50, %t52
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load i8*, i8** %l4
  %t59 = load i8, i8* %l5
  br i1 %t53, label %then10, label %merge11
then10:
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l2
  %t62 = sitofp i64 2 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t64 = phi i8* [ null, %then8 ], [ %t43, %then6 ]
  %t65 = phi double [ %t63, %then8 ], [ %t44, %then6 ]
  store i8* %t64, i8** %l1
  store double %t65, double* %l2
  %t66 = load i8, i8* %l5
  %t67 = load i8*, i8** %l4
  %t68 = getelementptr i8, i8* %t67, i64 0
  %t69 = load i8, i8* %t68
  %t70 = icmp eq i8 %t66, %t69
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load i8*, i8** %l4
  %t76 = load i8, i8* %l5
  br i1 %t70, label %then12, label %merge13
then12:
  %s77 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.77, i32 0, i32 0
  store i8* %s77, i8** %l4
  br label %merge13
merge13:
  %t78 = phi i8* [ %s77, %then12 ], [ %t75, %then6 ]
  store i8* %t78, i8** %l4
  %t79 = load double, double* %l2
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l2
  br label %loop.latch2
merge7:
  %t83 = load i8, i8* %l5
  %t84 = icmp eq i8 %t83, 34
  br label %logical_or_entry_82

logical_or_entry_82:
  br i1 %t84, label %logical_or_merge_82, label %logical_or_right_82

logical_or_right_82:
  %t85 = load i8, i8* %l5
  %t86 = icmp eq i8 %t85, 39
  br label %logical_or_right_end_82

logical_or_right_end_82:
  br label %logical_or_merge_82

logical_or_merge_82:
  %t87 = phi i1 [ true, %logical_or_entry_82 ], [ %t86, %logical_or_right_end_82 ]
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load i8*, i8** %l4
  %t93 = load i8, i8* %l5
  br i1 %t87, label %then14, label %merge15
then14:
  %t94 = load i8, i8* %l5
  store i8* null, i8** %l4
  %t95 = load i8*, i8** %l1
  %t96 = load i8, i8* %l5
  %t97 = getelementptr i8, i8* %t95, i64 0
  %t98 = load i8, i8* %t97
  %t99 = add i8 %t98, %t96
  store i8* null, i8** %l1
  %t100 = load double, double* %l2
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l2
  br label %loop.latch2
merge15:
  %t105 = load i8, i8* %l5
  %t106 = icmp eq i8 %t105, 40
  br label %logical_or_entry_104

logical_or_entry_104:
  br i1 %t106, label %logical_or_merge_104, label %logical_or_right_104

logical_or_right_104:
  %t107 = load i8, i8* %l5
  %t108 = icmp eq i8 %t107, 91
  br label %logical_or_right_end_104

logical_or_right_end_104:
  br label %logical_or_merge_104

logical_or_merge_104:
  %t109 = phi i1 [ true, %logical_or_entry_104 ], [ %t108, %logical_or_right_end_104 ]
  br label %logical_or_entry_103

logical_or_entry_103:
  br i1 %t109, label %logical_or_merge_103, label %logical_or_right_103

logical_or_right_103:
  %t110 = load i8, i8* %l5
  %t111 = icmp eq i8 %t110, 123
  br label %logical_or_right_end_103

logical_or_right_end_103:
  br label %logical_or_merge_103

logical_or_merge_103:
  %t112 = phi i1 [ true, %logical_or_entry_103 ], [ %t111, %logical_or_right_end_103 ]
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load i8*, i8** %l1
  %t115 = load double, double* %l2
  %t116 = load double, double* %l3
  %t117 = load i8*, i8** %l4
  %t118 = load i8, i8* %l5
  br i1 %t112, label %then16, label %merge17
then16:
  %t119 = load double, double* %l3
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l3
  %t122 = load i8*, i8** %l1
  %t123 = load i8, i8* %l5
  %t124 = getelementptr i8, i8* %t122, i64 0
  %t125 = load i8, i8* %t124
  %t126 = add i8 %t125, %t123
  store i8* null, i8** %l1
  %t127 = load double, double* %l2
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l2
  br label %loop.latch2
merge17:
  %t132 = load i8, i8* %l5
  %t133 = icmp eq i8 %t132, 41
  br label %logical_or_entry_131

logical_or_entry_131:
  br i1 %t133, label %logical_or_merge_131, label %logical_or_right_131

logical_or_right_131:
  %t134 = load i8, i8* %l5
  %t135 = icmp eq i8 %t134, 93
  br label %logical_or_right_end_131

logical_or_right_end_131:
  br label %logical_or_merge_131

logical_or_merge_131:
  %t136 = phi i1 [ true, %logical_or_entry_131 ], [ %t135, %logical_or_right_end_131 ]
  br label %logical_or_entry_130

logical_or_entry_130:
  br i1 %t136, label %logical_or_merge_130, label %logical_or_right_130

logical_or_right_130:
  %t137 = load i8, i8* %l5
  %t138 = icmp eq i8 %t137, 125
  br label %logical_or_right_end_130

logical_or_right_end_130:
  br label %logical_or_merge_130

logical_or_merge_130:
  %t139 = phi i1 [ true, %logical_or_entry_130 ], [ %t138, %logical_or_right_end_130 ]
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load i8*, i8** %l1
  %t142 = load double, double* %l2
  %t143 = load double, double* %l3
  %t144 = load i8*, i8** %l4
  %t145 = load i8, i8* %l5
  br i1 %t139, label %then18, label %merge19
then18:
  %t146 = load double, double* %l3
  %t147 = sitofp i64 0 to double
  %t148 = fcmp ogt double %t146, %t147
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t150 = load i8*, i8** %l1
  %t151 = load double, double* %l2
  %t152 = load double, double* %l3
  %t153 = load i8*, i8** %l4
  %t154 = load i8, i8* %l5
  br i1 %t148, label %then20, label %merge21
then20:
  %t155 = load double, double* %l3
  %t156 = sitofp i64 1 to double
  %t157 = fsub double %t155, %t156
  store double %t157, double* %l3
  br label %merge21
merge21:
  %t158 = phi double [ %t157, %then20 ], [ %t152, %then18 ]
  store double %t158, double* %l3
  %t159 = load i8*, i8** %l1
  %t160 = load i8, i8* %l5
  %t161 = getelementptr i8, i8* %t159, i64 0
  %t162 = load i8, i8* %t161
  %t163 = add i8 %t162, %t160
  store i8* null, i8** %l1
  %t164 = load double, double* %l2
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l2
  br label %loop.latch2
merge19:
  %t167 = load i8, i8* %l5
  %t168 = icmp eq i8 %t167, 44
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load i8*, i8** %l1
  %t171 = load double, double* %l2
  %t172 = load double, double* %l3
  %t173 = load i8*, i8** %l4
  %t174 = load i8, i8* %l5
  br i1 %t168, label %then22, label %merge23
then22:
  %t175 = load double, double* %l3
  %t176 = sitofp i64 0 to double
  %t177 = fcmp oeq double %t175, %t176
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t179 = load i8*, i8** %l1
  %t180 = load double, double* %l2
  %t181 = load double, double* %l3
  %t182 = load i8*, i8** %l4
  %t183 = load i8, i8* %l5
  br i1 %t177, label %then24, label %merge25
then24:
  %t184 = load i8*, i8** %l1
  %t185 = call i8* @trim_text(i8* %t184)
  store i8* %t185, i8** %l6
  %t186 = load i8*, i8** %l6
  %t187 = call i64 @sailfin_runtime_string_length(i8* %t186)
  %t188 = icmp sgt i64 %t187, 0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i8*, i8** %l4
  %t194 = load i8, i8* %l5
  %t195 = load i8*, i8** %l6
  br i1 %t188, label %then26, label %merge27
then26:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l6
  %t198 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t199 = phi { i8**, i64 }* [ %t198, %then26 ], [ %t189, %then24 ]
  store { i8**, i64 }* %t199, { i8**, i64 }** %l0
  %s200 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.200, i32 0, i32 0
  store i8* %s200, i8** %l1
  %t201 = load double, double* %l2
  %t202 = sitofp i64 1 to double
  %t203 = fadd double %t201, %t202
  store double %t203, double* %l2
  br label %loop.latch2
merge25:
  br label %merge23
merge23:
  %t204 = phi { i8**, i64 }* [ %t198, %then22 ], [ %t169, %loop.body1 ]
  %t205 = phi i8* [ %s200, %then22 ], [ %t170, %loop.body1 ]
  %t206 = phi double [ %t203, %then22 ], [ %t171, %loop.body1 ]
  store { i8**, i64 }* %t204, { i8**, i64 }** %l0
  store i8* %t205, i8** %l1
  store double %t206, double* %l2
  %t207 = load i8*, i8** %l1
  %t208 = load i8, i8* %l5
  %t209 = getelementptr i8, i8* %t207, i64 0
  %t210 = load i8, i8* %t209
  %t211 = add i8 %t210, %t208
  store i8* null, i8** %l1
  %t212 = load double, double* %l2
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  store double %t214, double* %l2
  br label %loop.latch2
loop.latch2:
  %t215 = load i8*, i8** %l1
  %t216 = load double, double* %l2
  %t217 = load i8*, i8** %l4
  %t218 = load double, double* %l3
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t225 = load i8*, i8** %l1
  %t226 = call i8* @trim_text(i8* %t225)
  store i8* %t226, i8** %l7
  %t227 = load i8*, i8** %l7
  %t228 = call i64 @sailfin_runtime_string_length(i8* %t227)
  %t229 = icmp sgt i64 %t228, 0
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t231 = load i8*, i8** %l1
  %t232 = load double, double* %l2
  %t233 = load double, double* %l3
  %t234 = load i8*, i8** %l4
  %t235 = load i8*, i8** %l7
  br i1 %t229, label %then28, label %merge29
then28:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load i8*, i8** %l7
  %t238 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t236, i8* %t237)
  store { i8**, i64 }* %t238, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t239 = phi { i8**, i64 }* [ %t238, %then28 ], [ %t230, %entry ]
  store { i8**, i64 }* %t239, { i8**, i64 }** %l0
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t240
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
  %t80 = phi { i8**, i64 }* [ %t11, %entry ], [ %t77, %loop.latch4 ]
  %t81 = phi double [ %t12, %entry ], [ %t78, %loop.latch4 ]
  %t82 = phi double [ %t13, %entry ], [ %t79, %loop.latch4 ]
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  store double %t81, double* %l1
  store double %t82, double* %l2
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
  %t22 = getelementptr i8, i8* %value, i64 %t21
  %t23 = load i8, i8* %t22
  store i8 %t23, i8* %l3
  %t27 = load i8, i8* %l3
  %t28 = icmp eq i8 %t27, 32
  br label %logical_or_entry_26

logical_or_entry_26:
  br i1 %t28, label %logical_or_merge_26, label %logical_or_right_26

logical_or_right_26:
  %t29 = load i8, i8* %l3
  %t30 = icmp eq i8 %t29, 9
  br label %logical_or_right_end_26

logical_or_right_end_26:
  br label %logical_or_merge_26

logical_or_merge_26:
  %t31 = phi i1 [ true, %logical_or_entry_26 ], [ %t30, %logical_or_right_end_26 ]
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t31, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t32 = load i8, i8* %l3
  %t33 = icmp eq i8 %t32, 10
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t34 = phi i1 [ true, %logical_or_entry_25 ], [ %t33, %logical_or_right_end_25 ]
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t34, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t35 = load i8, i8* %l3
  %t36 = icmp eq i8 %t35, 13
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t37 = phi i1 [ true, %logical_or_entry_24 ], [ %t36, %logical_or_right_end_24 ]
  store i1 %t37, i1* %l4
  %t38 = load i1, i1* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l2
  %t42 = load i8, i8* %l3
  %t43 = load i1, i1* %l4
  br i1 %t38, label %then8, label %else9
then8:
  %t44 = load double, double* %l1
  %t45 = sitofp i64 0 to double
  %t46 = fcmp oge double %t44, %t45
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load i8, i8* %l3
  %t51 = load i1, i1* %l4
  br i1 %t46, label %then11, label %merge12
then11:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = fptosi double %t53 to i64
  %t56 = fptosi double %t54 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t55, i64 %t56)
  %t58 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t52, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  %t59 = sitofp i64 -1 to double
  store double %t59, double* %l1
  br label %merge12
merge12:
  %t60 = phi { i8**, i64 }* [ %t58, %then11 ], [ %t47, %then8 ]
  %t61 = phi double [ %t59, %then11 ], [ %t48, %then8 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  store double %t61, double* %l1
  br label %merge10
else9:
  %t62 = load double, double* %l1
  %t63 = sitofp i64 0 to double
  %t64 = fcmp olt double %t62, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = load double, double* %l2
  %t68 = load i8, i8* %l3
  %t69 = load i1, i1* %l4
  br i1 %t64, label %then13, label %merge14
then13:
  %t70 = load double, double* %l2
  store double %t70, double* %l1
  br label %merge14
merge14:
  %t71 = phi double [ %t70, %then13 ], [ %t66, %else9 ]
  store double %t71, double* %l1
  br label %merge10
merge10:
  %t72 = phi { i8**, i64 }* [ %t58, %then8 ], [ %t39, %else9 ]
  %t73 = phi double [ %t59, %then8 ], [ %t70, %else9 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store double %t73, double* %l1
  %t74 = load double, double* %l2
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l2
  br label %loop.latch4
loop.latch4:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t83 = load double, double* %l1
  %t84 = sitofp i64 0 to double
  %t85 = fcmp oge double %t83, %t84
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l2
  br i1 %t85, label %then15, label %merge16
then15:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load double, double* %l1
  %t91 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t92 = fptosi double %t90 to i64
  %t93 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t92, i64 %t91)
  %t94 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t93)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l0
  br label %merge16
merge16:
  %t95 = phi { i8**, i64 }* [ %t94, %then15 ], [ %t86, %entry ]
  store { i8**, i64 }* %t95, { i8**, i64 }** %l0
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t96
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
  %t64 = phi double [ %t16, %entry ], [ %t62, %loop.latch4 ]
  %t65 = phi double [ %t15, %entry ], [ %t63, %loop.latch4 ]
  store double %t64, double* %l4
  store double %t65, double* %l3
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
  %t29 = getelementptr i8, i8* %t27, i64 %t28
  %t30 = load i8, i8* %t29
  store i8 %t30, i8* %l5
  %t31 = load i8, i8* %l5
  %t32 = call double @char_code(i8 %t31)
  store double %t32, double* %l6
  %t34 = load double, double* %l6
  %t35 = load double, double* %l1
  %t36 = fcmp olt double %t34, %t35
  br label %logical_or_entry_33

logical_or_entry_33:
  br i1 %t36, label %logical_or_merge_33, label %logical_or_right_33

logical_or_right_33:
  %t37 = load double, double* %l6
  %t38 = load double, double* %l2
  %t39 = fcmp ogt double %t37, %t38
  br label %logical_or_right_end_33

logical_or_right_end_33:
  br label %logical_or_merge_33

logical_or_merge_33:
  %t40 = phi i1 [ true, %logical_or_entry_33 ], [ %t39, %logical_or_right_end_33 ]
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  %t46 = load i8, i8* %l5
  %t47 = load double, double* %l6
  br i1 %t40, label %then8, label %merge9
then8:
  %t48 = insertvalue %NumberParseResult undef, i1 0, 0
  %t49 = sitofp i64 0 to double
  %t50 = insertvalue %NumberParseResult %t48, double %t49, 1
  ret %NumberParseResult %t50
merge9:
  %t51 = load double, double* %l6
  %t52 = load double, double* %l1
  %t53 = fsub double %t51, %t52
  store double %t53, double* %l7
  %t54 = load double, double* %l4
  %t55 = sitofp i64 10 to double
  %t56 = fmul double %t54, %t55
  %t57 = load double, double* %l7
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l4
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch4
loop.latch4:
  %t62 = load double, double* %l4
  %t63 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t66 = insertvalue %NumberParseResult undef, i1 1, 0
  %t67 = load double, double* %l4
  %t68 = insertvalue %NumberParseResult %t66, double %t67, 1
  ret %NumberParseResult %t68
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
  %t43 = phi { i8**, i64 }* [ %t7, %entry ], [ %t40, %loop.latch2 ]
  %t44 = phi i8* [ %t8, %entry ], [ %t41, %loop.latch2 ]
  %t45 = phi double [ %t9, %entry ], [ %t42, %loop.latch2 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  store i8* %t44, i8** %l1
  store double %t45, double* %l2
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
  %t18 = getelementptr i8, i8* %value, i64 %t17
  %t19 = load i8, i8* %t18
  store i8 %t19, i8* %l3
  %t20 = load i8, i8* %l3
  %t21 = icmp eq i8 %t20, 10
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  %t25 = load i8, i8* %l3
  br i1 %t21, label %then6, label %else7
then6:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %s29 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.29, i32 0, i32 0
  store i8* %s29, i8** %l1
  br label %merge8
else7:
  %t30 = load i8*, i8** %l1
  %t31 = load i8, i8* %l3
  %t32 = getelementptr i8, i8* %t30, i64 0
  %t33 = load i8, i8* %t32
  %t34 = add i8 %t33, %t31
  store i8* null, i8** %l1
  br label %merge8
merge8:
  %t35 = phi { i8**, i64 }* [ %t28, %then6 ], [ %t22, %else7 ]
  %t36 = phi i8* [ %s29, %then6 ], [ null, %else7 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store i8* %t36, i8** %l1
  %t37 = load double, double* %l2
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l2
  br label %loop.latch2
loop.latch2:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t49
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
  %t18 = getelementptr i8, i8* %value, i64 %t17
  %t19 = load i8, i8* %t18
  store i8 %t19, i8* %l3
  %t20 = load i8, i8* %l3
  %t21 = icmp eq i8 %t20, 44
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  %t25 = load i8, i8* %l3
  br i1 %t21, label %then6, label %else7
then6:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = call i8* @trim_text(i8* %t27)
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t28)
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
  %t36 = phi { i8**, i64 }* [ %t29, %then6 ], [ %t22, %else7 ]
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
  %t47 = load i8*, i8** %l1
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp sgt i64 %t48, 0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then9, label %merge10
then9:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = call i8* @trim_text(i8* %t54)
  %t56 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t53, i8* %t55)
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t57 = phi { i8**, i64 }* [ %t56, %then9 ], [ %t50, %entry ]
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  %t58 = alloca [0 x i8*]
  %t59 = getelementptr [0 x i8*], [0 x i8*]* %t58, i32 0, i32 0
  %t60 = alloca { i8**, i64 }
  %t61 = getelementptr { i8**, i64 }, { i8**, i64 }* %t60, i32 0, i32 0
  store i8** %t59, i8*** %t61
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* %t60, i32 0, i32 1
  store i64 0, i64* %t62
  store { i8**, i64 }* %t60, { i8**, i64 }** %l4
  %t63 = sitofp i64 0 to double
  store double %t63, double* %l2
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t103 = phi { i8**, i64 }* [ %t67, %entry ], [ %t101, %loop.latch13 ]
  %t104 = phi double [ %t66, %entry ], [ %t102, %loop.latch13 ]
  store { i8**, i64 }* %t103, { i8**, i64 }** %l4
  store double %t104, double* %l2
  br label %loop.body12
loop.body12:
  %t68 = load double, double* %l2
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load { i8**, i64 }, { i8**, i64 }* %t69
  %t71 = extractvalue { i8**, i64 } %t70, 1
  %t72 = sitofp i64 %t71 to double
  %t73 = fcmp oge double %t68, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load double, double* %l2
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t73, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load double, double* %l2
  %t80 = load { i8**, i64 }, { i8**, i64 }* %t78
  %t81 = extractvalue { i8**, i64 } %t80, 0
  %t82 = extractvalue { i8**, i64 } %t80, 1
  %t83 = icmp uge i64 %t79, %t82
  ; bounds check: %t83 (if true, out of bounds)
  %t84 = getelementptr i8*, i8** %t81, i64 %t79
  %t85 = load i8*, i8** %t84
  store i8* %t85, i8** %l5
  %t86 = load i8*, i8** %l5
  %t87 = call i64 @sailfin_runtime_string_length(i8* %t86)
  %t88 = icmp sgt i64 %t87, 0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t93 = load i8*, i8** %l5
  br i1 %t88, label %then17, label %merge18
then17:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t95 = load i8*, i8** %l5
  %t96 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t94, i8* %t95)
  store { i8**, i64 }* %t96, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t97 = phi { i8**, i64 }* [ %t96, %then17 ], [ %t92, %loop.body12 ]
  store { i8**, i64 }* %t97, { i8**, i64 }** %l4
  %t98 = load double, double* %l2
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l2
  br label %loop.latch13
loop.latch13:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t102 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t105
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
  %t36 = phi i8* [ %t3, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t5, %entry ], [ %t35, %loop.latch2 ]
  store i8* %t36, i8** %l0
  store double %t37, double* %l2
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
  %t14 = getelementptr i8, i8* %name, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l3
  %t16 = load i8, i8* %l3
  %t17 = load i8, i8* %l3
  %t18 = load double, double* %l1
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oeq double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load double, double* %l2
  %t24 = load i8, i8* %l3
  br i1 %t20, label %then6, label %merge7
then6:
  %t25 = load i8*, i8** %l0
  %t26 = load i8, i8* %l3
  %t27 = getelementptr i8, i8* %t25, i64 0
  %t28 = load i8, i8* %t27
  %t29 = add i8 %t28, %t26
  store i8* null, i8** %l0
  br label %merge7
merge7:
  %t30 = phi i8* [ null, %then6 ], [ %t21, %loop.body1 ]
  store i8* %t30, i8** %l0
  %t31 = load double, double* %l2
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l2
  br label %loop.latch2
loop.latch2:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t38 = load i8*, i8** %l0
  %t39 = call i8* @trim_text(i8* %t38)
  ret i8* %t39
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
  %t22 = phi double [ %t3, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  store i8 %t12, i8* %l2
  %t13 = load i8, i8* %l2
  %t14 = call i1 @is_trim_char(i8* null)
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t39 = phi double [ %t24, %entry ], [ %t38, %loop.latch10 ]
  store double %t39, double* %l1
  br label %loop.body9
loop.body9:
  %t25 = load double, double* %l1
  %t26 = load double, double* %l0
  %t27 = fcmp ole double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  br i1 %t27, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t30 = load double, double* %l3
  %t31 = call i1 @is_trim_char(i8* null)
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l3
  br i1 %t31, label %then14, label %merge15
then14:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fsub double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t38 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t41 = load double, double* %l0
  %t42 = sitofp i64 0 to double
  %t43 = fcmp oeq double %t41, %t42
  br label %logical_and_entry_40

logical_and_entry_40:
  br i1 %t43, label %logical_and_right_40, label %logical_and_merge_40

logical_and_right_40:
  %t44 = load double, double* %l1
  %t45 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oeq double %t44, %t46
  br label %logical_and_right_end_40

logical_and_right_end_40:
  br label %logical_and_merge_40

logical_and_merge_40:
  %t48 = phi i1 [ false, %logical_and_entry_40 ], [ %t47, %logical_and_right_end_40 ]
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  br i1 %t48, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = fptosi double %t51 to i64
  %t54 = fptosi double %t52 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t53, i64 %t54)
  ret i8* %t55
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
  %t536 = phi double [ %t21, %entry ], [ %t532, %loop.latch2 ]
  %t537 = phi { i8**, i64 }* [ %t18, %entry ], [ %t533, %loop.latch2 ]
  %t538 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t534, %loop.latch2 ]
  %t539 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t535, %loop.latch2 ]
  store double %t536, double* %l4
  store { i8**, i64 }* %t537, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t538, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t539, { %NativeEnum*, i64 }** %l3
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
  %t44 = call i64 @sailfin_runtime_string_length(i8* %t43)
  %t45 = icmp eq i64 %t44, 0
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
  %t57 = call i1 @starts_with(i8* %t56, i8* null)
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t61 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t62 = load double, double* %l4
  %t63 = load i8*, i8** %l5
  %t64 = load i8*, i8** %l6
  br i1 %t57, label %then8, label %merge9
then8:
  %t65 = load double, double* %l4
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l4
  br label %loop.latch2
merge9:
  %t68 = load i8*, i8** %l6
  %s69 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.69, i32 0, i32 0
  %t70 = call i1 @starts_with(i8* %t68, i8* %s69)
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t74 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t75 = load double, double* %l4
  %t76 = load i8*, i8** %l5
  %t77 = load i8*, i8** %l6
  br i1 %t70, label %then10, label %merge11
then10:
  %t78 = load double, double* %l4
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l4
  br label %loop.latch2
merge11:
  %t81 = load i8*, i8** %l6
  %s82 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.82, i32 0, i32 0
  %t83 = call i1 @starts_with(i8* %t81, i8* %s82)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t87 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t88 = load double, double* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  br i1 %t83, label %then12, label %merge13
then12:
  %t91 = load i8*, i8** %l6
  %s92 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.92, i32 0, i32 0
  %t93 = call i8* @strip_prefix(i8* %t91, i8* %s92)
  store i8* %t93, i8** %l7
  %t94 = load i8*, i8** %l7
  %s95 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.95, i32 0, i32 0
  %t96 = call i8* @strip_prefix(i8* %t94, i8* %s95)
  store i8* %t96, i8** %l8
  %t97 = load i8*, i8** %l8
  %t98 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t97)
  store %StructLayoutHeaderParse %t98, %StructLayoutHeaderParse* %l9
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t101 = extractvalue %StructLayoutHeaderParse %t100, 4
  %t102 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t99, { i8**, i64 }* %t101)
  store { i8**, i64 }* %t102, { i8**, i64 }** %l1
  %t103 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t104 = extractvalue %StructLayoutHeaderParse %t103, 0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t108 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t109 = load double, double* %l4
  %t110 = load i8*, i8** %l5
  %t111 = load i8*, i8** %l6
  %t112 = load i8*, i8** %l7
  %t113 = load i8*, i8** %l8
  %t114 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t104, label %then14, label %merge15
then14:
  %t115 = alloca [0 x %NativeStructLayoutField]
  %t116 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t115, i32 0, i32 0
  %t117 = alloca { %NativeStructLayoutField*, i64 }
  %t118 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t117, i32 0, i32 0
  store %NativeStructLayoutField* %t116, %NativeStructLayoutField** %t118
  %t119 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t117, i32 0, i32 1
  store i64 0, i64* %t119
  store { %NativeStructLayoutField*, i64 }* %t117, { %NativeStructLayoutField*, i64 }** %l10
  %t120 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t121 = extractvalue %StructLayoutHeaderParse %t120, 1
  store i8* %t121, i8** %l11
  %t122 = load double, double* %l4
  %t123 = sitofp i64 1 to double
  %t124 = fadd double %t122, %t123
  store double %t124, double* %l4
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t128 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t129 = load double, double* %l4
  %t130 = load i8*, i8** %l5
  %t131 = load i8*, i8** %l6
  %t132 = load i8*, i8** %l7
  %t133 = load i8*, i8** %l8
  %t134 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t135 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t136 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t240 = phi i8* [ %t132, %then14 ], [ %t236, %loop.latch18 ]
  %t241 = phi { i8**, i64 }* [ %t126, %then14 ], [ %t237, %loop.latch18 ]
  %t242 = phi { %NativeStructLayoutField*, i64 }* [ %t135, %then14 ], [ %t238, %loop.latch18 ]
  %t243 = phi double [ %t129, %then14 ], [ %t239, %loop.latch18 ]
  store i8* %t240, i8** %l7
  store { i8**, i64 }* %t241, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t242, { %NativeStructLayoutField*, i64 }** %l10
  store double %t243, double* %l4
  br label %loop.body17
loop.body17:
  %t137 = load double, double* %l4
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load { i8**, i64 }, { i8**, i64 }* %t138
  %t140 = extractvalue { i8**, i64 } %t139, 1
  %t141 = sitofp i64 %t140 to double
  %t142 = fcmp oge double %t137, %t141
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t145 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t146 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t147 = load double, double* %l4
  %t148 = load i8*, i8** %l5
  %t149 = load i8*, i8** %l6
  %t150 = load i8*, i8** %l7
  %t151 = load i8*, i8** %l8
  %t152 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t153 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t154 = load i8*, i8** %l11
  br i1 %t142, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load double, double* %l4
  %t157 = load { i8**, i64 }, { i8**, i64 }* %t155
  %t158 = extractvalue { i8**, i64 } %t157, 0
  %t159 = extractvalue { i8**, i64 } %t157, 1
  %t160 = icmp uge i64 %t156, %t159
  ; bounds check: %t160 (if true, out of bounds)
  %t161 = getelementptr i8*, i8** %t158, i64 %t156
  %t162 = load i8*, i8** %t161
  %t163 = call i8* @trim_text(i8* %t162)
  store i8* %t163, i8** %l12
  %t164 = load i8*, i8** %l12
  %t165 = call i64 @sailfin_runtime_string_length(i8* %t164)
  %t166 = icmp eq i64 %t165, 0
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t169 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t170 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t171 = load double, double* %l4
  %t172 = load i8*, i8** %l5
  %t173 = load i8*, i8** %l6
  %t174 = load i8*, i8** %l7
  %t175 = load i8*, i8** %l8
  %t176 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t177 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t178 = load i8*, i8** %l11
  %t179 = load i8*, i8** %l12
  br i1 %t166, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t180 = load i8*, i8** %l12
  %s181 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.181, i32 0, i32 0
  %t182 = call i1 @starts_with(i8* %t180, i8* %s181)
  %t183 = xor i1 %t182, 1
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
  br i1 %t183, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t197 = load i8*, i8** %l12
  %s198 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.198, i32 0, i32 0
  %t199 = call i8* @strip_prefix(i8* %t197, i8* %s198)
  store i8* %t199, i8** %l13
  %t200 = load i8*, i8** %l7
  %s201 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.201, i32 0, i32 0
  %t202 = call i8* @strip_prefix(i8* %t200, i8* %s201)
  store i8* %t202, i8** %l14
  %t203 = load i8*, i8** %l14
  %t204 = load i8*, i8** %l11
  %t205 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t203, i8* %t204)
  store %StructLayoutFieldParse %t205, %StructLayoutFieldParse* %l15
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t207 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t208 = extractvalue %StructLayoutFieldParse %t207, 2
  %t209 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t206, { i8**, i64 }* %t208)
  store { i8**, i64 }* %t209, { i8**, i64 }** %l1
  %t210 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t211 = extractvalue %StructLayoutFieldParse %t210, 0
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t214 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t215 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t216 = load double, double* %l4
  %t217 = load i8*, i8** %l5
  %t218 = load i8*, i8** %l6
  %t219 = load i8*, i8** %l7
  %t220 = load i8*, i8** %l8
  %t221 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t222 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t223 = load i8*, i8** %l11
  %t224 = load i8*, i8** %l12
  %t225 = load i8*, i8** %l13
  %t226 = load i8*, i8** %l14
  %t227 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t211, label %then26, label %merge27
then26:
  %t228 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t229 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t230 = extractvalue %StructLayoutFieldParse %t229, 1
  %t231 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t228, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t231, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t232 = phi { %NativeStructLayoutField*, i64 }* [ %t231, %then26 ], [ %t222, %loop.body17 ]
  store { %NativeStructLayoutField*, i64 }* %t232, { %NativeStructLayoutField*, i64 }** %l10
  %t233 = load double, double* %l4
  %t234 = sitofp i64 1 to double
  %t235 = fadd double %t233, %t234
  store double %t235, double* %l4
  br label %loop.latch18
loop.latch18:
  %t236 = load i8*, i8** %l7
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t238 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t239 = load double, double* %l4
  br label %loop.header16
afterloop19:
  store double 0.0, double* %l16
  %t244 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t245 = load double, double* %l16
  %t246 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t244, %NativeStruct zeroinitializer)
  store { %NativeStruct*, i64 }* %t246, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t247 = phi double [ %t124, %then14 ], [ %t109, %then12 ]
  %t248 = phi i8* [ %t199, %then14 ], [ %t112, %then12 ]
  %t249 = phi { i8**, i64 }* [ %t209, %then14 ], [ %t106, %then12 ]
  %t250 = phi double [ %t235, %then14 ], [ %t109, %then12 ]
  %t251 = phi { %NativeStruct*, i64 }* [ %t246, %then14 ], [ %t107, %then12 ]
  store double %t247, double* %l4
  store i8* %t248, i8** %l7
  store { i8**, i64 }* %t249, { i8**, i64 }** %l1
  store double %t250, double* %l4
  store { %NativeStruct*, i64 }* %t251, { %NativeStruct*, i64 }** %l2
  %t252 = load double, double* %l4
  %t253 = sitofp i64 1 to double
  %t254 = fadd double %t252, %t253
  store double %t254, double* %l4
  br label %loop.latch2
merge13:
  %t255 = load i8*, i8** %l6
  %s256 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.256, i32 0, i32 0
  %t257 = call i1 @starts_with(i8* %t255, i8* %s256)
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t260 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t261 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t262 = load double, double* %l4
  %t263 = load i8*, i8** %l5
  %t264 = load i8*, i8** %l6
  br i1 %t257, label %then28, label %merge29
then28:
  %t265 = load i8*, i8** %l6
  %s266 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.266, i32 0, i32 0
  %t267 = call i8* @strip_prefix(i8* %t265, i8* %s266)
  store i8* %t267, i8** %l17
  %t268 = load i8*, i8** %l17
  %s269 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.269, i32 0, i32 0
  %t270 = call i8* @strip_prefix(i8* %t268, i8* %s269)
  store i8* %t270, i8** %l18
  %t271 = load i8*, i8** %l18
  %t272 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t271)
  store %EnumLayoutHeaderParse %t272, %EnumLayoutHeaderParse* %l19
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t275 = extractvalue %EnumLayoutHeaderParse %t274, 7
  %t276 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t273, { i8**, i64 }* %t275)
  store { i8**, i64 }* %t276, { i8**, i64 }** %l1
  %t277 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t278 = extractvalue %EnumLayoutHeaderParse %t277, 0
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
  br i1 %t278, label %then30, label %else31
then30:
  %t289 = alloca [0 x %NativeEnumVariantLayout]
  %t290 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t289, i32 0, i32 0
  %t291 = alloca { %NativeEnumVariantLayout*, i64 }
  %t292 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t291, i32 0, i32 0
  store %NativeEnumVariantLayout* %t290, %NativeEnumVariantLayout** %t292
  %t293 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t291, i32 0, i32 1
  store i64 0, i64* %t293
  store { %NativeEnumVariantLayout*, i64 }* %t291, { %NativeEnumVariantLayout*, i64 }** %l20
  %t294 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t295 = extractvalue %EnumLayoutHeaderParse %t294, 1
  store i8* %t295, i8** %l21
  %t296 = load double, double* %l4
  %t297 = sitofp i64 1 to double
  %t298 = fadd double %t296, %t297
  store double %t298, double* %l4
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t301 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t302 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t303 = load double, double* %l4
  %t304 = load i8*, i8** %l5
  %t305 = load i8*, i8** %l6
  %t306 = load i8*, i8** %l17
  %t307 = load i8*, i8** %l18
  %t308 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t309 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t310 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t515 = phi double [ %t303, %then30 ], [ %t511, %loop.latch35 ]
  %t516 = phi i8* [ %t306, %then30 ], [ %t512, %loop.latch35 ]
  %t517 = phi { i8**, i64 }* [ %t300, %then30 ], [ %t513, %loop.latch35 ]
  %t518 = phi { %NativeEnumVariantLayout*, i64 }* [ %t309, %then30 ], [ %t514, %loop.latch35 ]
  store double %t515, double* %l4
  store i8* %t516, i8** %l17
  store { i8**, i64 }* %t517, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t518, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t311 = load double, double* %l4
  %t312 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t313 = load { i8**, i64 }, { i8**, i64 }* %t312
  %t314 = extractvalue { i8**, i64 } %t313, 1
  %t315 = sitofp i64 %t314 to double
  %t316 = fcmp oge double %t311, %t315
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t319 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t320 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t321 = load double, double* %l4
  %t322 = load i8*, i8** %l5
  %t323 = load i8*, i8** %l6
  %t324 = load i8*, i8** %l17
  %t325 = load i8*, i8** %l18
  %t326 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t327 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t328 = load i8*, i8** %l21
  br i1 %t316, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t330 = load double, double* %l4
  %t331 = load { i8**, i64 }, { i8**, i64 }* %t329
  %t332 = extractvalue { i8**, i64 } %t331, 0
  %t333 = extractvalue { i8**, i64 } %t331, 1
  %t334 = icmp uge i64 %t330, %t333
  ; bounds check: %t334 (if true, out of bounds)
  %t335 = getelementptr i8*, i8** %t332, i64 %t330
  %t336 = load i8*, i8** %t335
  %t337 = call i8* @trim_text(i8* %t336)
  store i8* %t337, i8** %l22
  %t338 = load i8*, i8** %l22
  %t339 = call i64 @sailfin_runtime_string_length(i8* %t338)
  %t340 = icmp eq i64 %t339, 0
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t343 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t344 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t345 = load double, double* %l4
  %t346 = load i8*, i8** %l5
  %t347 = load i8*, i8** %l6
  %t348 = load i8*, i8** %l17
  %t349 = load i8*, i8** %l18
  %t350 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t351 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t352 = load i8*, i8** %l21
  %t353 = load i8*, i8** %l22
  br i1 %t340, label %then39, label %merge40
then39:
  %t354 = load double, double* %l4
  %t355 = sitofp i64 1 to double
  %t356 = fadd double %t354, %t355
  store double %t356, double* %l4
  br label %afterloop36
merge40:
  %t358 = load i8*, i8** %l22
  %s359 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.359, i32 0, i32 0
  %t360 = call i1 @starts_with(i8* %t358, i8* %s359)
  br label %logical_and_entry_357

logical_and_entry_357:
  br i1 %t360, label %logical_and_right_357, label %logical_and_merge_357

logical_and_right_357:
  %t361 = load i8*, i8** %l22
  %s362 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.362, i32 0, i32 0
  %t363 = call i1 @starts_with(i8* %t361, i8* %s362)
  %t364 = xor i1 %t363, 1
  br label %logical_and_right_end_357

logical_and_right_end_357:
  br label %logical_and_merge_357

logical_and_merge_357:
  %t365 = phi i1 [ false, %logical_and_entry_357 ], [ %t364, %logical_and_right_end_357 ]
  %t366 = xor i1 %t365, 1
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t369 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t370 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t371 = load double, double* %l4
  %t372 = load i8*, i8** %l5
  %t373 = load i8*, i8** %l6
  %t374 = load i8*, i8** %l17
  %t375 = load i8*, i8** %l18
  %t376 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t377 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t378 = load i8*, i8** %l21
  %t379 = load i8*, i8** %l22
  br i1 %t366, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t380 = load i8*, i8** %l22
  %s381 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.381, i32 0, i32 0
  %t382 = call i1 @starts_with(i8* %t380, i8* %s381)
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t385 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t386 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t387 = load double, double* %l4
  %t388 = load i8*, i8** %l5
  %t389 = load i8*, i8** %l6
  %t390 = load i8*, i8** %l17
  %t391 = load i8*, i8** %l18
  %t392 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t393 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t394 = load i8*, i8** %l21
  %t395 = load i8*, i8** %l22
  br i1 %t382, label %then43, label %else44
then43:
  %t396 = load i8*, i8** %l22
  %s397 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.397, i32 0, i32 0
  %t398 = call i8* @strip_prefix(i8* %t396, i8* %s397)
  store i8* %t398, i8** %l23
  %t399 = load i8*, i8** %l17
  %s400 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.400, i32 0, i32 0
  %t401 = call i8* @strip_prefix(i8* %t399, i8* %s400)
  store i8* %t401, i8** %l24
  %t402 = load i8*, i8** %l24
  %t403 = load i8*, i8** %l21
  %t404 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t402, i8* %t403)
  store %EnumLayoutVariantParse %t404, %EnumLayoutVariantParse* %l25
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t407 = extractvalue %EnumLayoutVariantParse %t406, 2
  %t408 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t405, { i8**, i64 }* %t407)
  store { i8**, i64 }* %t408, { i8**, i64 }** %l1
  %t409 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t410 = extractvalue %EnumLayoutVariantParse %t409, 0
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t413 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t414 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t415 = load double, double* %l4
  %t416 = load i8*, i8** %l5
  %t417 = load i8*, i8** %l6
  %t418 = load i8*, i8** %l17
  %t419 = load i8*, i8** %l18
  %t420 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t421 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t422 = load i8*, i8** %l21
  %t423 = load i8*, i8** %l22
  %t424 = load i8*, i8** %l23
  %t425 = load i8*, i8** %l24
  %t426 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t410, label %then46, label %merge47
then46:
  %t427 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t428 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t429 = extractvalue %EnumLayoutVariantParse %t428, 1
  %t430 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t427, %NativeEnumVariantLayout zeroinitializer)
  store { %NativeEnumVariantLayout*, i64 }* %t430, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t431 = phi { %NativeEnumVariantLayout*, i64 }* [ %t430, %then46 ], [ %t421, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t431, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t432 = load i8*, i8** %l22
  %s433 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.433, i32 0, i32 0
  %t434 = call i1 @starts_with(i8* %t432, i8* %s433)
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t436 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t437 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t438 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t439 = load double, double* %l4
  %t440 = load i8*, i8** %l5
  %t441 = load i8*, i8** %l6
  %t442 = load i8*, i8** %l17
  %t443 = load i8*, i8** %l18
  %t444 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t445 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t446 = load i8*, i8** %l21
  %t447 = load i8*, i8** %l22
  br i1 %t434, label %then48, label %merge49
then48:
  %t448 = load i8*, i8** %l22
  %s449 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.449, i32 0, i32 0
  %t450 = call i8* @strip_prefix(i8* %t448, i8* %s449)
  store i8* %t450, i8** %l26
  %t451 = load i8*, i8** %l17
  %s452 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.452, i32 0, i32 0
  %t453 = call i8* @strip_prefix(i8* %t451, i8* %s452)
  store i8* %t453, i8** %l27
  %t454 = load i8*, i8** %l27
  %t455 = load i8*, i8** %l21
  %t456 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t454, i8* %t455)
  store %EnumLayoutPayloadParse %t456, %EnumLayoutPayloadParse* %l28
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t458 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t459 = extractvalue %EnumLayoutPayloadParse %t458, 3
  %t460 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t457, { i8**, i64 }* %t459)
  store { i8**, i64 }* %t460, { i8**, i64 }** %l1
  %t462 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t463 = extractvalue %EnumLayoutPayloadParse %t462, 0
  br label %logical_and_entry_461

logical_and_entry_461:
  br i1 %t463, label %logical_and_right_461, label %logical_and_merge_461

logical_and_right_461:
  %t464 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t465 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t464
  %t466 = extractvalue { %NativeEnumVariantLayout*, i64 } %t465, 1
  %t467 = icmp sgt i64 %t466, 0
  br label %logical_and_right_end_461

logical_and_right_end_461:
  br label %logical_and_merge_461

logical_and_merge_461:
  %t468 = phi i1 [ false, %logical_and_entry_461 ], [ %t467, %logical_and_right_end_461 ]
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t471 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t472 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t473 = load double, double* %l4
  %t474 = load i8*, i8** %l5
  %t475 = load i8*, i8** %l6
  %t476 = load i8*, i8** %l17
  %t477 = load i8*, i8** %l18
  %t478 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t479 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t480 = load i8*, i8** %l21
  %t481 = load i8*, i8** %l22
  %t482 = load i8*, i8** %l26
  %t483 = load i8*, i8** %l27
  %t484 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t468, label %then50, label %merge51
then50:
  %t485 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t486 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t485
  %t487 = extractvalue { %NativeEnumVariantLayout*, i64 } %t486, 1
  %t488 = sub i64 %t487, 1
  store i64 %t488, i64* %l29
  %t489 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t490 = load i64, i64* %l29
  %t491 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t489
  %t492 = extractvalue { %NativeEnumVariantLayout*, i64 } %t491, 0
  %t493 = extractvalue { %NativeEnumVariantLayout*, i64 } %t491, 1
  %t494 = icmp uge i64 %t490, %t493
  ; bounds check: %t494 (if true, out of bounds)
  %t495 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t492, i64 %t490
  %t496 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t495
  store %NativeEnumVariantLayout %t496, %NativeEnumVariantLayout* %l30
  %t497 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t498 = extractvalue %NativeEnumVariantLayout %t497, 5
  %t499 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t500 = extractvalue %EnumLayoutPayloadParse %t499, 2
  %t501 = bitcast { i8**, i64 }* %t498 to { %NativeStructLayoutField*, i64 }*
  %t502 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t501, %NativeStructLayoutField zeroinitializer)
  store { %NativeStructLayoutField*, i64 }* %t502, { %NativeStructLayoutField*, i64 }** %l31
  br label %merge51
merge51:
  br label %merge49
merge49:
  %t503 = phi i8* [ %t450, %then48 ], [ %t442, %else44 ]
  %t504 = phi { i8**, i64 }* [ %t460, %then48 ], [ %t436, %else44 ]
  store i8* %t503, i8** %l17
  store { i8**, i64 }* %t504, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t505 = phi i8* [ %t398, %then43 ], [ %t450, %else44 ]
  %t506 = phi { i8**, i64 }* [ %t408, %then43 ], [ %t460, %else44 ]
  %t507 = phi { %NativeEnumVariantLayout*, i64 }* [ %t430, %then43 ], [ %t393, %else44 ]
  store i8* %t505, i8** %l17
  store { i8**, i64 }* %t506, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t507, { %NativeEnumVariantLayout*, i64 }** %l20
  %t508 = load double, double* %l4
  %t509 = sitofp i64 1 to double
  %t510 = fadd double %t508, %t509
  store double %t510, double* %l4
  br label %loop.latch35
loop.latch35:
  %t511 = load double, double* %l4
  %t512 = load i8*, i8** %l17
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  store double 0.0, double* %l32
  %t519 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t520 = load double, double* %l32
  %t521 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t519, %NativeEnum zeroinitializer)
  store { %NativeEnum*, i64 }* %t521, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t522 = load double, double* %l4
  %t523 = sitofp i64 1 to double
  %t524 = fadd double %t522, %t523
  store double %t524, double* %l4
  br label %merge32
merge32:
  %t525 = phi double [ %t298, %then30 ], [ %t524, %else31 ]
  %t526 = phi i8* [ %t398, %then30 ], [ %t286, %else31 ]
  %t527 = phi { i8**, i64 }* [ %t408, %then30 ], [ %t280, %else31 ]
  %t528 = phi { %NativeEnum*, i64 }* [ %t521, %then30 ], [ %t282, %else31 ]
  store double %t525, double* %l4
  store i8* %t526, i8** %l17
  store { i8**, i64 }* %t527, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t528, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t529 = load double, double* %l4
  %t530 = sitofp i64 1 to double
  %t531 = fadd double %t529, %t530
  store double %t531, double* %l4
  br label %loop.latch2
loop.latch2:
  %t532 = load double, double* %l4
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t534 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t535 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t540 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t541 = bitcast { %NativeStruct*, i64 }* %t540 to { i8**, i64 }*
  %t542 = insertvalue %LayoutManifest undef, { i8**, i64 }* %t541, 0
  %t543 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t544 = bitcast { %NativeEnum*, i64 }* %t543 to { i8**, i64 }*
  %t545 = insertvalue %LayoutManifest %t542, { i8**, i64 }* %t544, 1
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t547 = insertvalue %LayoutManifest %t545, { i8**, i64 }* %t546, 2
  ret %LayoutManifest %t547
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
  %t24 = phi double [ %t6, %entry ], [ %t23, %loop.latch6 ]
  store double %t24, double* %l0
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
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load double, double* %l0
  %t16 = getelementptr i8, i8* %prefix, i64 %t15
  %t17 = load i8, i8* %t16
  %t18 = icmp ne i8 %t14, %t17
  %t19 = load double, double* %l0
  br i1 %t18, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch6
loop.latch6:
  %t23 = load double, double* %l0
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
