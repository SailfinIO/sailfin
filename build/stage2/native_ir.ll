; ModuleID = 'sailfin'
source_filename = "sailfin"

%NativeSourceSpan = type { double, double, double, double }
%NativeParameter = type { i8*, i8*, i1, i8*, %NativeSourceSpan* }
%NativeFunction = type { i8*, { %NativeParameter**, i64 }*, i8*, { i8**, i64 }*, { %NativeInstruction**, i64 }* }
%NativeImportSpecifier = type { i8*, i8* }
%NativeImport = type { i8*, i8*, { %NativeImportSpecifier**, i64 }* }
%NativeStructField = type { i8*, i8*, i1 }
%NativeStructLayoutField = type { i8*, i8*, double, double, double }
%NativeStructLayout = type { double, double, { %NativeStructLayoutField**, i64 }* }
%NativeStruct = type { i8*, { %NativeStructField**, i64 }*, { %NativeFunction**, i64 }*, { i8**, i64 }*, %NativeStructLayout* }
%NativeInterfaceSignature = type { i8*, i1, { i8**, i64 }*, { %NativeParameter**, i64 }*, i8*, { i8**, i64 }* }
%NativeInterface = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature**, i64 }* }
%NativeEnumVariantField = type { i8*, i8*, i1 }
%NativeEnumVariant = type { i8*, { %NativeEnumVariantField**, i64 }* }
%NativeEnumVariantLayout = type { i8*, double, double, double, double, { %NativeStructLayoutField**, i64 }* }
%NativeEnumLayout = type { double, double, i8*, double, double, { %NativeEnumVariantLayout**, i64 }* }
%NativeEnum = type { i8*, { %NativeEnumVariant**, i64 }*, %NativeEnumLayout* }
%NativeBinding = type { i8*, i1, i8*, i8* }
%EnumParseResult = type { %NativeEnum*, double, { i8**, i64 }* }
%CaseComponents = type { i8*, i8* }
%InstructionParseResult = type { { %NativeInstruction**, i64 }*, i1, i1 }
%InstructionGatherResult = type { i8*, double }
%InstructionDepthState = type { double, double, double, i1, i1 }
%StructParseResult = type { %NativeStruct*, double, { i8**, i64 }* }
%InterfaceParseResult = type { %NativeInterface*, double, { i8**, i64 }* }
%InterfaceSignatureParse = type { i1, %NativeInterfaceSignature, { i8**, i64 }* }
%StructHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%InterfaceHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%HeaderNameParse = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%StructLayoutHeaderParse = type { i1, i8*, double, double, { i8**, i64 }* }
%StructLayoutFieldParse = type { i1, %NativeStructLayoutField, { i8**, i64 }* }
%ParseNativeResult = type { { %NativeFunction**, i64 }*, { %NativeImport**, i64 }*, { %NativeStruct**, i64 }*, { %NativeInterface**, i64 }*, { %NativeEnum**, i64 }*, { %NativeBinding**, i64 }*, { i8**, i64 }* }
%EnumLayoutHeaderParse = type { i1, i8*, double, double, i8*, double, double, { i8**, i64 }* }
%EnumLayoutVariantParse = type { i1, %NativeEnumVariantLayout, { i8**, i64 }* }
%EnumLayoutPayloadParse = type { i1, i8*, %NativeStructLayoutField, { i8**, i64 }* }
%NumberParseResult = type { i1, double }
%LayoutManifest = type { { %NativeStruct**, i64 }*, { %NativeEnum**, i64 }*, { i8**, i64 }* }
%BindingComponents = type { i8*, i8*, i8* }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder, { i8**, i64 }*, %LayoutContext }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { %StructFieldLayoutDescriptor**, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { %StructFieldLayoutDescriptor**, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { %EnumVariantLayoutDescriptor**, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { %LayoutFieldInput**, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { %LayoutFieldInput**, i64 }* }
%LayoutEnumDefinition = type { i8*, { %LayoutEnumVariantDefinition**, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { %LayoutStructDefinition**, i64 }*, { %LayoutEnumDefinition**, i64 }* }

%NativeInstruction = type { i32, [48 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.3 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.8 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.14 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.20 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.272 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.24 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.65 = private unnamed_addr constant [1 x i8] c"\00"
@.str.25 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [1 x i8] c"\00"
@.str.80 = private unnamed_addr constant [1 x i8] c"\00"
@.str.31 = private unnamed_addr constant [1 x i8] c"\00"
@.str.32 = private unnamed_addr constant [1 x i8] c"\00"
@.str.118 = private unnamed_addr constant [1 x i8] c"\00"
@.str.44 = private unnamed_addr constant [1 x i8] c"\00"

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
  %l17 = alloca double
  %l18 = alloca %StructParseResult
  %l19 = alloca %InterfaceParseResult
  %l20 = alloca %EnumParseResult
  %l21 = alloca i8*
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca { i8**, i64 }*
  %l26 = alloca double
  %l27 = alloca i1
  %l28 = alloca i8*
  %l29 = alloca i8*
  %l30 = alloca double
  %l31 = alloca %InstructionGatherResult
  %l32 = alloca %InstructionParseResult
  %l33 = alloca { %NativeInstruction**, i64 }*
  %l34 = alloca double
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
  %t1165 = phi double [ %t48, %entry ], [ %t1155, %loop.latch2 ]
  %t1166 = phi { i8**, i64 }* [ %t38, %entry ], [ %t1156, %loop.latch2 ]
  %t1167 = phi { %NativeStruct*, i64 }* [ %t41, %entry ], [ %t1157, %loop.latch2 ]
  %t1168 = phi { %NativeInterface*, i64 }* [ %t42, %entry ], [ %t1158, %loop.latch2 ]
  %t1169 = phi { %NativeEnum*, i64 }* [ %t43, %entry ], [ %t1159, %loop.latch2 ]
  %t1170 = phi i8* [ %t45, %entry ], [ %t1160, %loop.latch2 ]
  %t1171 = phi { %NativeFunction*, i64 }* [ %t39, %entry ], [ %t1161, %loop.latch2 ]
  %t1172 = phi i8* [ %t46, %entry ], [ %t1162, %loop.latch2 ]
  %t1173 = phi i8* [ %t47, %entry ], [ %t1163, %loop.latch2 ]
  %t1174 = phi { %NativeBinding*, i64 }* [ %t44, %entry ], [ %t1164, %loop.latch2 ]
  store double %t1165, double* %l11
  store { i8**, i64 }* %t1166, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t1167, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1168, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1169, { %NativeEnum*, i64 }** %l6
  store i8* %t1170, i8** %l8
  store { %NativeFunction*, i64 }* %t1171, { %NativeFunction*, i64 }** %l2
  store i8* %t1172, i8** %l9
  store i8* %t1173, i8** %l10
  store { %NativeBinding*, i64 }* %t1174, { %NativeBinding*, i64 }** %l7
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
  %s219 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.219, i32 0, i32 0
  %t220 = call i1 @starts_with(i8* %t218, i8* %s219)
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
  br i1 %t220, label %then18, label %merge19
then18:
  %t235 = load i8*, i8** %l13
  %s236 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.236, i32 0, i32 0
  %t237 = call i8* @strip_prefix(i8* %t235, i8* %s236)
  %t238 = call double @parse_source_span(i8* %t237)
  store double %t238, double* %l17
  %t239 = load double, double* %l17
  %t240 = load double, double* %l11
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  store double %t242, double* %l11
  br label %loop.latch2
merge19:
  %t243 = load i8*, i8** %l13
  %s244 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.244, i32 0, i32 0
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
  %t262 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t260, double %t261)
  store %StructParseResult %t262, %StructParseResult* %l18
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = load %StructParseResult, %StructParseResult* %l18
  %t265 = extractvalue %StructParseResult %t264, 2
  %t266 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t263, { i8**, i64 }* %t265)
  store { i8**, i64 }* %t266, { i8**, i64 }** %l1
  %t267 = load %StructParseResult, %StructParseResult* %l18
  %t268 = extractvalue %StructParseResult %t267, 0
  %t269 = bitcast i8* null to %NativeStruct*
  %t270 = icmp ne %NativeStruct* %t268, %t269
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
  %t285 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t270, label %then22, label %merge23
then22:
  %t286 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t287 = load %StructParseResult, %StructParseResult* %l18
  %t288 = extractvalue %StructParseResult %t287, 0
  %t289 = load %NativeStruct, %NativeStruct* %t288
  %t290 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t286, %NativeStruct %t289)
  store { %NativeStruct*, i64 }* %t290, { %NativeStruct*, i64 }** %l4
  br label %merge23
merge23:
  %t291 = phi { %NativeStruct*, i64 }* [ %t290, %then22 ], [ %t275, %then20 ]
  store { %NativeStruct*, i64 }* %t291, { %NativeStruct*, i64 }** %l4
  %t292 = load %StructParseResult, %StructParseResult* %l18
  %t293 = extractvalue %StructParseResult %t292, 1
  store double %t293, double* %l11
  br label %loop.latch2
merge21:
  %t294 = load i8*, i8** %l13
  %s295 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.295, i32 0, i32 0
  %t296 = call i1 @starts_with(i8* %t294, i8* %s295)
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t299 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t300 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t301 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t302 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t303 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t304 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t305 = load i8*, i8** %l8
  %t306 = load i8*, i8** %l9
  %t307 = load i8*, i8** %l10
  %t308 = load double, double* %l11
  %t309 = load i8*, i8** %l12
  %t310 = load i8*, i8** %l13
  br i1 %t296, label %then24, label %merge25
then24:
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t312 = load double, double* %l11
  %t313 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t311, double %t312)
  store %InterfaceParseResult %t313, %InterfaceParseResult* %l19
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t315 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t316 = extractvalue %InterfaceParseResult %t315, 2
  %t317 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t314, { i8**, i64 }* %t316)
  store { i8**, i64 }* %t317, { i8**, i64 }** %l1
  %t318 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t319 = extractvalue %InterfaceParseResult %t318, 0
  %t320 = bitcast i8* null to %NativeInterface*
  %t321 = icmp ne %NativeInterface* %t319, %t320
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t324 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t325 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t326 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t327 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t328 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t329 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t330 = load i8*, i8** %l8
  %t331 = load i8*, i8** %l9
  %t332 = load i8*, i8** %l10
  %t333 = load double, double* %l11
  %t334 = load i8*, i8** %l12
  %t335 = load i8*, i8** %l13
  %t336 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t321, label %then26, label %merge27
then26:
  %t337 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t338 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t339 = extractvalue %InterfaceParseResult %t338, 0
  %t340 = load %NativeInterface, %NativeInterface* %t339
  %t341 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t337, %NativeInterface %t340)
  store { %NativeInterface*, i64 }* %t341, { %NativeInterface*, i64 }** %l5
  br label %merge27
merge27:
  %t342 = phi { %NativeInterface*, i64 }* [ %t341, %then26 ], [ %t327, %then24 ]
  store { %NativeInterface*, i64 }* %t342, { %NativeInterface*, i64 }** %l5
  %t343 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t344 = extractvalue %InterfaceParseResult %t343, 1
  store double %t344, double* %l11
  br label %loop.latch2
merge25:
  %t345 = load i8*, i8** %l13
  %s346 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.346, i32 0, i32 0
  %t347 = call i1 @starts_with(i8* %t345, i8* %s346)
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t350 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t351 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t352 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t353 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t354 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t355 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t356 = load i8*, i8** %l8
  %t357 = load i8*, i8** %l9
  %t358 = load i8*, i8** %l10
  %t359 = load double, double* %l11
  %t360 = load i8*, i8** %l12
  %t361 = load i8*, i8** %l13
  br i1 %t347, label %then28, label %merge29
then28:
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t363 = load double, double* %l11
  %t364 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t362, double %t363)
  store %EnumParseResult %t364, %EnumParseResult* %l20
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t366 = load %EnumParseResult, %EnumParseResult* %l20
  %t367 = extractvalue %EnumParseResult %t366, 2
  %t368 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t365, { i8**, i64 }* %t367)
  store { i8**, i64 }* %t368, { i8**, i64 }** %l1
  %t369 = load %EnumParseResult, %EnumParseResult* %l20
  %t370 = extractvalue %EnumParseResult %t369, 0
  %t371 = bitcast i8* null to %NativeEnum*
  %t372 = icmp ne %NativeEnum* %t370, %t371
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
  %t387 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t372, label %then30, label %merge31
then30:
  %t388 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t389 = load %EnumParseResult, %EnumParseResult* %l20
  %t390 = extractvalue %EnumParseResult %t389, 0
  %t391 = load %NativeEnum, %NativeEnum* %t390
  %t392 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t388, %NativeEnum %t391)
  store { %NativeEnum*, i64 }* %t392, { %NativeEnum*, i64 }** %l6
  br label %merge31
merge31:
  %t393 = phi { %NativeEnum*, i64 }* [ %t392, %then30 ], [ %t379, %then28 ]
  store { %NativeEnum*, i64 }* %t393, { %NativeEnum*, i64 }** %l6
  %t394 = load %EnumParseResult, %EnumParseResult* %l20
  %t395 = extractvalue %EnumParseResult %t394, 1
  store double %t395, double* %l11
  br label %loop.latch2
merge29:
  %t396 = load i8*, i8** %l13
  %s397 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.397, i32 0, i32 0
  %t398 = call i1 @starts_with(i8* %t396, i8* %s397)
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
  br i1 %t398, label %then32, label %merge33
then32:
  %t413 = load i8*, i8** %l8
  %t414 = icmp ne i8* %t413, null
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t417 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t418 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t419 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t420 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t421 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t422 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t423 = load i8*, i8** %l8
  %t424 = load i8*, i8** %l9
  %t425 = load i8*, i8** %l10
  %t426 = load double, double* %l11
  %t427 = load i8*, i8** %l12
  %t428 = load i8*, i8** %l13
  br i1 %t414, label %then34, label %merge35
then34:
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s430 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.430, i32 0, i32 0
  %t431 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t429, i8* %s430)
  store { i8**, i64 }* %t431, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t432 = phi { i8**, i64 }* [ %t431, %then34 ], [ %t416, %then32 ]
  store { i8**, i64 }* %t432, { i8**, i64 }** %l1
  %t433 = load i8*, i8** %l13
  %s434 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.434, i32 0, i32 0
  %t435 = call i8* @strip_prefix(i8* %t433, i8* %s434)
  %t436 = call i8* @parse_function_name(i8* %t435)
  %t437 = insertvalue %NativeFunction undef, i8* %t436, 0
  %t438 = alloca [0 x %NativeParameter*]
  %t439 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t438, i32 0, i32 0
  %t440 = alloca { %NativeParameter**, i64 }
  %t441 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t440, i32 0, i32 0
  store %NativeParameter** %t439, %NativeParameter*** %t441
  %t442 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t440, i32 0, i32 1
  store i64 0, i64* %t442
  %t443 = insertvalue %NativeFunction %t437, { %NativeParameter**, i64 }* %t440, 1
  %s444 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.444, i32 0, i32 0
  %t445 = insertvalue %NativeFunction %t443, i8* %s444, 2
  %t446 = alloca [0 x i8*]
  %t447 = getelementptr [0 x i8*], [0 x i8*]* %t446, i32 0, i32 0
  %t448 = alloca { i8**, i64 }
  %t449 = getelementptr { i8**, i64 }, { i8**, i64 }* %t448, i32 0, i32 0
  store i8** %t447, i8*** %t449
  %t450 = getelementptr { i8**, i64 }, { i8**, i64 }* %t448, i32 0, i32 1
  store i64 0, i64* %t450
  %t451 = insertvalue %NativeFunction %t445, { i8**, i64 }* %t448, 3
  %t452 = alloca [0 x %NativeInstruction*]
  %t453 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* %t452, i32 0, i32 0
  %t454 = alloca { %NativeInstruction**, i64 }
  %t455 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t454, i32 0, i32 0
  store %NativeInstruction** %t453, %NativeInstruction*** %t455
  %t456 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t454, i32 0, i32 1
  store i64 0, i64* %t456
  %t457 = insertvalue %NativeFunction %t451, { %NativeInstruction**, i64 }* %t454, 4
  store i8* null, i8** %l8
  %t458 = load double, double* %l11
  %t459 = sitofp i64 1 to double
  %t460 = fadd double %t458, %t459
  store double %t460, double* %l11
  br label %loop.latch2
merge33:
  %t461 = load i8*, i8** %l13
  %s462 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.462, i32 0, i32 0
  %t463 = call i1 @starts_with(i8* %t461, i8* %s462)
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t466 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t467 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t468 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t469 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t470 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t471 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t472 = load i8*, i8** %l8
  %t473 = load i8*, i8** %l9
  %t474 = load i8*, i8** %l10
  %t475 = load double, double* %l11
  %t476 = load i8*, i8** %l12
  %t477 = load i8*, i8** %l13
  br i1 %t463, label %then36, label %merge37
then36:
  %t478 = load i8*, i8** %l8
  %t479 = icmp eq i8* %t478, null
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t482 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t483 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t484 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t485 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t486 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t487 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t488 = load i8*, i8** %l8
  %t489 = load i8*, i8** %l9
  %t490 = load i8*, i8** %l10
  %t491 = load double, double* %l11
  %t492 = load i8*, i8** %l12
  %t493 = load i8*, i8** %l13
  br i1 %t479, label %then38, label %else39
then38:
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s495 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.495, i32 0, i32 0
  %t496 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t494, i8* %s495)
  store { i8**, i64 }* %t496, { i8**, i64 }** %l1
  br label %merge40
else39:
  %t497 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t498 = load i8*, i8** %l8
  %t499 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t497, i8* null)
  store { %NativeFunction*, i64 }* %t499, { %NativeFunction*, i64 }** %l2
  store i8* null, i8** %l8
  br label %merge40
merge40:
  %t500 = phi { i8**, i64 }* [ %t496, %then38 ], [ %t481, %else39 ]
  %t501 = phi { %NativeFunction*, i64 }* [ %t482, %then38 ], [ %t499, %else39 ]
  %t502 = phi i8* [ %t488, %then38 ], [ null, %else39 ]
  store { i8**, i64 }* %t500, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t501, { %NativeFunction*, i64 }** %l2
  store i8* %t502, i8** %l8
  %t503 = load double, double* %l11
  %t504 = sitofp i64 1 to double
  %t505 = fadd double %t503, %t504
  store double %t505, double* %l11
  br label %loop.latch2
merge37:
  %t506 = load i8*, i8** %l13
  %s507 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.507, i32 0, i32 0
  %t508 = call i1 @starts_with(i8* %t506, i8* %s507)
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t511 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t512 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t513 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t514 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t515 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t516 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t517 = load i8*, i8** %l8
  %t518 = load i8*, i8** %l9
  %t519 = load i8*, i8** %l10
  %t520 = load double, double* %l11
  %t521 = load i8*, i8** %l12
  %t522 = load i8*, i8** %l13
  br i1 %t508, label %then41, label %merge42
then41:
  %t523 = load i8*, i8** %l8
  %t524 = icmp ne i8* %t523, null
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t527 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t528 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t529 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t530 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t531 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t532 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t533 = load i8*, i8** %l8
  %t534 = load i8*, i8** %l9
  %t535 = load i8*, i8** %l10
  %t536 = load double, double* %l11
  %t537 = load i8*, i8** %l12
  %t538 = load i8*, i8** %l13
  br i1 %t524, label %then43, label %else44
then43:
  %t539 = load i8*, i8** %l8
  %t540 = load i8*, i8** %l13
  %s541 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.541, i32 0, i32 0
  %t542 = call i8* @strip_prefix(i8* %t540, i8* %s541)
  %t543 = call %NativeFunction @apply_meta(i8* null, i8* %t542)
  store i8* null, i8** %l8
  br label %merge45
else44:
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s545 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.545, i32 0, i32 0
  %t546 = load i8*, i8** %l13
  %t547 = add i8* %s545, %t546
  %t548 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t544, i8* %t547)
  store { i8**, i64 }* %t548, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t549 = phi i8* [ null, %then43 ], [ %t533, %else44 ]
  %t550 = phi { i8**, i64 }* [ %t526, %then43 ], [ %t548, %else44 ]
  store i8* %t549, i8** %l8
  store { i8**, i64 }* %t550, { i8**, i64 }** %l1
  %t551 = load double, double* %l11
  %t552 = sitofp i64 1 to double
  %t553 = fadd double %t551, %t552
  store double %t553, double* %l11
  br label %loop.latch2
merge42:
  %t554 = load i8*, i8** %l13
  %s555 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.555, i32 0, i32 0
  %t556 = call i1 @starts_with(i8* %t554, i8* %s555)
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t559 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t560 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t561 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t562 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t563 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t564 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t565 = load i8*, i8** %l8
  %t566 = load i8*, i8** %l9
  %t567 = load i8*, i8** %l10
  %t568 = load double, double* %l11
  %t569 = load i8*, i8** %l12
  %t570 = load i8*, i8** %l13
  br i1 %t556, label %then46, label %merge47
then46:
  %t571 = load i8*, i8** %l8
  %t572 = icmp ne i8* %t571, null
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t575 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t576 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t577 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t578 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t579 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t580 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t581 = load i8*, i8** %l8
  %t582 = load i8*, i8** %l9
  %t583 = load i8*, i8** %l10
  %t584 = load double, double* %l11
  %t585 = load i8*, i8** %l12
  %t586 = load i8*, i8** %l13
  br i1 %t572, label %then48, label %else49
then48:
  %t587 = load i8*, i8** %l13
  %s588 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.588, i32 0, i32 0
  %t589 = call i8* @strip_prefix(i8* %t587, i8* %s588)
  store i8* %t589, i8** %l21
  %t590 = load double, double* %l11
  %t591 = sitofp i64 1 to double
  %t592 = fadd double %t590, %t591
  store double %t592, double* %l22
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t595 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t596 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t597 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t598 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t599 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t600 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t601 = load i8*, i8** %l8
  %t602 = load i8*, i8** %l9
  %t603 = load i8*, i8** %l10
  %t604 = load double, double* %l11
  %t605 = load i8*, i8** %l12
  %t606 = load i8*, i8** %l13
  %t607 = load i8*, i8** %l21
  %t608 = load double, double* %l22
  br label %loop.header51
loop.header51:
  %t722 = phi double [ %t608, %then48 ], [ %t720, %loop.latch53 ]
  %t723 = phi i8* [ %t607, %then48 ], [ %t721, %loop.latch53 ]
  store double %t722, double* %l22
  store i8* %t723, i8** %l21
  br label %loop.body52
loop.body52:
  %t609 = load double, double* %l22
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t611 = load { i8**, i64 }, { i8**, i64 }* %t610
  %t612 = extractvalue { i8**, i64 } %t611, 1
  %t613 = sitofp i64 %t612 to double
  %t614 = fcmp oge double %t609, %t613
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t617 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t618 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t619 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t620 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t621 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t622 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t623 = load i8*, i8** %l8
  %t624 = load i8*, i8** %l9
  %t625 = load i8*, i8** %l10
  %t626 = load double, double* %l11
  %t627 = load i8*, i8** %l12
  %t628 = load i8*, i8** %l13
  %t629 = load i8*, i8** %l21
  %t630 = load double, double* %l22
  br i1 %t614, label %then55, label %merge56
then55:
  br label %afterloop54
merge56:
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t632 = load double, double* %l22
  %t633 = fptosi double %t632 to i64
  %t634 = load { i8**, i64 }, { i8**, i64 }* %t631
  %t635 = extractvalue { i8**, i64 } %t634, 0
  %t636 = extractvalue { i8**, i64 } %t634, 1
  %t637 = icmp uge i64 %t633, %t636
  ; bounds check: %t637 (if true, out of bounds)
  %t638 = getelementptr i8*, i8** %t635, i64 %t633
  %t639 = load i8*, i8** %t638
  store i8* %t639, i8** %l23
  %t640 = load i8*, i8** %l23
  %t641 = call i64 @sailfin_runtime_string_length(i8* %t640)
  %t642 = icmp eq i64 %t641, 0
  %t643 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t645 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t646 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t647 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t648 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t649 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t650 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t651 = load i8*, i8** %l8
  %t652 = load i8*, i8** %l9
  %t653 = load i8*, i8** %l10
  %t654 = load double, double* %l11
  %t655 = load i8*, i8** %l12
  %t656 = load i8*, i8** %l13
  %t657 = load i8*, i8** %l21
  %t658 = load double, double* %l22
  %t659 = load i8*, i8** %l23
  br i1 %t642, label %then57, label %merge58
then57:
  br label %afterloop54
merge58:
  %t660 = load i8*, i8** %l23
  %t661 = call i8* @trim_text(i8* %t660)
  store i8* %t661, i8** %l24
  %t662 = load i8*, i8** %l24
  %t663 = call i64 @sailfin_runtime_string_length(i8* %t662)
  %t664 = icmp eq i64 %t663, 0
  %t665 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t667 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t668 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t669 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t670 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t671 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t672 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t673 = load i8*, i8** %l8
  %t674 = load i8*, i8** %l9
  %t675 = load i8*, i8** %l10
  %t676 = load double, double* %l11
  %t677 = load i8*, i8** %l12
  %t678 = load i8*, i8** %l13
  %t679 = load i8*, i8** %l21
  %t680 = load double, double* %l22
  %t681 = load i8*, i8** %l23
  %t682 = load i8*, i8** %l24
  br i1 %t664, label %then59, label %merge60
then59:
  %t683 = load double, double* %l22
  %t684 = sitofp i64 1 to double
  %t685 = fadd double %t683, %t684
  store double %t685, double* %l22
  br label %loop.latch53
merge60:
  %t686 = load i8*, i8** %l24
  %t687 = call i1 @line_looks_like_parameter_entry(i8* %t686)
  %t688 = xor i1 %t687, 1
  %t689 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t691 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t692 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t693 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t694 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t695 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t696 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t697 = load i8*, i8** %l8
  %t698 = load i8*, i8** %l9
  %t699 = load i8*, i8** %l10
  %t700 = load double, double* %l11
  %t701 = load i8*, i8** %l12
  %t702 = load i8*, i8** %l13
  %t703 = load i8*, i8** %l21
  %t704 = load double, double* %l22
  %t705 = load i8*, i8** %l23
  %t706 = load i8*, i8** %l24
  br i1 %t688, label %then61, label %merge62
then61:
  br label %afterloop54
merge62:
  %t707 = load i8*, i8** %l21
  %t708 = load i8, i8* %t707
  %t709 = add i8 %t708, 32
  %t710 = load i8*, i8** %l24
  %t711 = load i8, i8* %t710
  %t712 = add i8 %t709, %t711
  %t713 = alloca [2 x i8], align 1
  %t714 = getelementptr [2 x i8], [2 x i8]* %t713, i32 0, i32 0
  store i8 %t712, i8* %t714
  %t715 = getelementptr [2 x i8], [2 x i8]* %t713, i32 0, i32 1
  store i8 0, i8* %t715
  %t716 = getelementptr [2 x i8], [2 x i8]* %t713, i32 0, i32 0
  store i8* %t716, i8** %l21
  %t717 = load double, double* %l22
  %t718 = sitofp i64 1 to double
  %t719 = fadd double %t717, %t718
  store double %t719, double* %l22
  br label %loop.latch53
loop.latch53:
  %t720 = load double, double* %l22
  %t721 = load i8*, i8** %l21
  br label %loop.header51
afterloop54:
  %t724 = load i8*, i8** %l21
  %t725 = call { i8**, i64 }* @split_parameter_entries(i8* %t724)
  store { i8**, i64 }* %t725, { i8**, i64 }** %l25
  %t726 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t727 = load { i8**, i64 }, { i8**, i64 }* %t726
  %t728 = extractvalue { i8**, i64 } %t727, 1
  %t729 = icmp eq i64 %t728, 0
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t731 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t732 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t733 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t734 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t735 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t736 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t737 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t738 = load i8*, i8** %l8
  %t739 = load i8*, i8** %l9
  %t740 = load i8*, i8** %l10
  %t741 = load double, double* %l11
  %t742 = load i8*, i8** %l12
  %t743 = load i8*, i8** %l13
  %t744 = load i8*, i8** %l21
  %t745 = load double, double* %l22
  %t746 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t729, label %then63, label %else64
then63:
  %t747 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s748 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.748, i32 0, i32 0
  %t749 = load i8*, i8** %l13
  %t750 = add i8* %s748, %t749
  %t751 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t747, i8* %t750)
  store { i8**, i64 }* %t751, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge65
else64:
  %t752 = sitofp i64 0 to double
  store double %t752, double* %l26
  store i1 0, i1* %l27
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
  %t767 = load i8*, i8** %l21
  %t768 = load double, double* %l22
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t770 = load double, double* %l26
  %t771 = load i1, i1* %l27
  br label %loop.header66
loop.header66:
  %t838 = phi double [ %t770, %else64 ], [ %t837, %loop.latch68 ]
  store double %t838, double* %l26
  br label %loop.body67
loop.body67:
  %t772 = load double, double* %l26
  %t773 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t774 = load { i8**, i64 }, { i8**, i64 }* %t773
  %t775 = extractvalue { i8**, i64 } %t774, 1
  %t776 = sitofp i64 %t775 to double
  %t777 = fcmp oge double %t772, %t776
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
  %t792 = load i8*, i8** %l21
  %t793 = load double, double* %l22
  %t794 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t795 = load double, double* %l26
  %t796 = load i1, i1* %l27
  br i1 %t777, label %then70, label %merge71
then70:
  br label %afterloop69
merge71:
  %t797 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t798 = load double, double* %l26
  %t799 = fptosi double %t798 to i64
  %t800 = load { i8**, i64 }, { i8**, i64 }* %t797
  %t801 = extractvalue { i8**, i64 } %t800, 0
  %t802 = extractvalue { i8**, i64 } %t800, 1
  %t803 = icmp uge i64 %t799, %t802
  ; bounds check: %t803 (if true, out of bounds)
  %t804 = getelementptr i8*, i8** %t801, i64 %t799
  %t805 = load i8*, i8** %t804
  store i8* %t805, i8** %l28
  %t806 = load i8*, i8** %l9
  store i8* %t806, i8** %l29
  %t807 = load i1, i1* %l27
  %t808 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t809 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t810 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t811 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t812 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t813 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t814 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t815 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t816 = load i8*, i8** %l8
  %t817 = load i8*, i8** %l9
  %t818 = load i8*, i8** %l10
  %t819 = load double, double* %l11
  %t820 = load i8*, i8** %l12
  %t821 = load i8*, i8** %l13
  %t822 = load i8*, i8** %l21
  %t823 = load double, double* %l22
  %t824 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t825 = load double, double* %l26
  %t826 = load i1, i1* %l27
  %t827 = load i8*, i8** %l28
  %t828 = load i8*, i8** %l29
  br i1 %t807, label %then72, label %merge73
then72:
  store i8* null, i8** %l29
  br label %merge73
merge73:
  %t829 = phi i8* [ null, %then72 ], [ %t828, %loop.body67 ]
  store i8* %t829, i8** %l29
  %t830 = load i8*, i8** %l28
  %t831 = load i8*, i8** %l29
  %t832 = call double @parse_parameter_entry(i8* %t830, i8* %t831)
  store double %t832, double* %l30
  %t833 = load double, double* %l30
  %t834 = load double, double* %l26
  %t835 = sitofp i64 1 to double
  %t836 = fadd double %t834, %t835
  store double %t836, double* %l26
  br label %loop.latch68
loop.latch68:
  %t837 = load double, double* %l26
  br label %loop.header66
afterloop69:
  store i8* null, i8** %l9
  br label %merge65
merge65:
  %t839 = phi { i8**, i64 }* [ %t751, %then63 ], [ %t731, %else64 ]
  %t840 = phi i8* [ null, %then63 ], [ null, %else64 ]
  store { i8**, i64 }* %t839, { i8**, i64 }** %l1
  store i8* %t840, i8** %l9
  %t841 = load double, double* %l22
  %t842 = sitofp i64 1 to double
  %t843 = fsub double %t841, %t842
  store double %t843, double* %l11
  br label %merge50
else49:
  %t844 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s845 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.845, i32 0, i32 0
  %t846 = load i8*, i8** %l13
  %t847 = add i8* %s845, %t846
  %t848 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t844, i8* %t847)
  store { i8**, i64 }* %t848, { i8**, i64 }** %l1
  br label %merge50
merge50:
  %t849 = phi { i8**, i64 }* [ %t751, %then48 ], [ %t848, %else49 ]
  %t850 = phi i8* [ null, %then48 ], [ %t582, %else49 ]
  %t851 = phi double [ %t843, %then48 ], [ %t584, %else49 ]
  store { i8**, i64 }* %t849, { i8**, i64 }** %l1
  store i8* %t850, i8** %l9
  store double %t851, double* %l11
  %t852 = load double, double* %l11
  %t853 = sitofp i64 1 to double
  %t854 = fadd double %t852, %t853
  store double %t854, double* %l11
  br label %loop.latch2
merge47:
  %t855 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t856 = load double, double* %l11
  %t857 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t855, double %t856)
  store %InstructionGatherResult %t857, %InstructionGatherResult* %l31
  %t858 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t859 = extractvalue %InstructionGatherResult %t858, 0
  store i8* %t859, i8** %l13
  %t860 = load double, double* %l11
  %t861 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t862 = extractvalue %InstructionGatherResult %t861, 1
  %t863 = fadd double %t860, %t862
  store double %t863, double* %l11
  %t864 = load i8*, i8** %l13
  %t865 = load i8*, i8** %l9
  %t866 = load i8*, i8** %l10
  %t867 = call %InstructionParseResult @parse_instruction(i8* %t864, i8* %t865, i8* %t866)
  store %InstructionParseResult %t867, %InstructionParseResult* %l32
  %t868 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t869 = extractvalue %InstructionParseResult %t868, 0
  store { %NativeInstruction**, i64 }* %t869, { %NativeInstruction**, i64 }** %l33
  %t870 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t871 = extractvalue %InstructionParseResult %t870, 1
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t873 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t874 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t875 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t876 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t877 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t878 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t879 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t880 = load i8*, i8** %l8
  %t881 = load i8*, i8** %l9
  %t882 = load i8*, i8** %l10
  %t883 = load double, double* %l11
  %t884 = load i8*, i8** %l12
  %t885 = load i8*, i8** %l13
  %t886 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t887 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t888 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t871, label %then74, label %else75
then74:
  store i8* null, i8** %l9
  br label %merge76
else75:
  %t889 = load i8*, i8** %l9
  %t890 = icmp ne i8* %t889, null
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
  %t905 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t906 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t907 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t890, label %then77, label %merge78
then77:
  %t908 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s909 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.909, i32 0, i32 0
  %t910 = load i8*, i8** %l13
  %t911 = add i8* %s909, %t910
  %t912 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t908, i8* %t911)
  store { i8**, i64 }* %t912, { i8**, i64 }** %l1
  store i8* null, i8** %l9
  br label %merge78
merge78:
  %t913 = phi { i8**, i64 }* [ %t912, %then77 ], [ %t892, %else75 ]
  %t914 = phi i8* [ null, %then77 ], [ %t900, %else75 ]
  store { i8**, i64 }* %t913, { i8**, i64 }** %l1
  store i8* %t914, i8** %l9
  br label %merge76
merge76:
  %t915 = phi i8* [ null, %then74 ], [ null, %else75 ]
  %t916 = phi { i8**, i64 }* [ %t873, %then74 ], [ %t912, %else75 ]
  store i8* %t915, i8** %l9
  store { i8**, i64 }* %t916, { i8**, i64 }** %l1
  %t917 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t918 = extractvalue %InstructionParseResult %t917, 2
  %t919 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t921 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t922 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t923 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t924 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t925 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t926 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t927 = load i8*, i8** %l8
  %t928 = load i8*, i8** %l9
  %t929 = load i8*, i8** %l10
  %t930 = load double, double* %l11
  %t931 = load i8*, i8** %l12
  %t932 = load i8*, i8** %l13
  %t933 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t934 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t935 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t918, label %then79, label %else80
then79:
  store i8* null, i8** %l10
  br label %merge81
else80:
  %t936 = load i8*, i8** %l10
  %t937 = icmp ne i8* %t936, null
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
  %t952 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t953 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t954 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t937, label %then82, label %merge83
then82:
  %t955 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s956 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.956, i32 0, i32 0
  %t957 = load i8*, i8** %l13
  %t958 = add i8* %s956, %t957
  %t959 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t955, i8* %t958)
  store { i8**, i64 }* %t959, { i8**, i64 }** %l1
  store i8* null, i8** %l10
  br label %merge83
merge83:
  %t960 = phi { i8**, i64 }* [ %t959, %then82 ], [ %t939, %else80 ]
  %t961 = phi i8* [ null, %then82 ], [ %t948, %else80 ]
  store { i8**, i64 }* %t960, { i8**, i64 }** %l1
  store i8* %t961, i8** %l10
  br label %merge81
merge81:
  %t962 = phi i8* [ null, %then79 ], [ null, %else80 ]
  %t963 = phi { i8**, i64 }* [ %t920, %then79 ], [ %t959, %else80 ]
  store i8* %t962, i8** %l10
  store { i8**, i64 }* %t963, { i8**, i64 }** %l1
  %t964 = load i8*, i8** %l8
  %t965 = icmp eq i8* %t964, null
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t967 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t968 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t969 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t970 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t971 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t972 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t973 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t974 = load i8*, i8** %l8
  %t975 = load i8*, i8** %l9
  %t976 = load i8*, i8** %l10
  %t977 = load double, double* %l11
  %t978 = load i8*, i8** %l12
  %t979 = load i8*, i8** %l13
  %t980 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t981 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t982 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t965, label %then84, label %merge85
then84:
  %t984 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t985 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t984
  %t986 = extractvalue { %NativeInstruction**, i64 } %t985, 1
  %t987 = icmp eq i64 %t986, 1
  br label %logical_and_entry_983

logical_and_entry_983:
  br i1 %t987, label %logical_and_right_983, label %logical_and_merge_983

logical_and_right_983:
  %t988 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t989 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t988
  %t990 = extractvalue { %NativeInstruction**, i64 } %t989, 0
  %t991 = extractvalue { %NativeInstruction**, i64 } %t989, 1
  %t992 = icmp uge i64 0, %t991
  ; bounds check: %t992 (if true, out of bounds)
  %t993 = getelementptr %NativeInstruction*, %NativeInstruction** %t990, i64 0
  %t994 = load %NativeInstruction*, %NativeInstruction** %t993
  %t995 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t994, i32 0, i32 0
  %t996 = load i32, i32* %t995
  %t997 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t998 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t996, 0
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t996, 1
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t996, 2
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t996, 3
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t996, 4
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t996, 5
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t996, 6
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1020 = icmp eq i32 %t996, 7
  %t1021 = select i1 %t1020, i8* %t1019, i8* %t1018
  %t1022 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1023 = icmp eq i32 %t996, 8
  %t1024 = select i1 %t1023, i8* %t1022, i8* %t1021
  %t1025 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1026 = icmp eq i32 %t996, 9
  %t1027 = select i1 %t1026, i8* %t1025, i8* %t1024
  %t1028 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1029 = icmp eq i32 %t996, 10
  %t1030 = select i1 %t1029, i8* %t1028, i8* %t1027
  %t1031 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1032 = icmp eq i32 %t996, 11
  %t1033 = select i1 %t1032, i8* %t1031, i8* %t1030
  %t1034 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1035 = icmp eq i32 %t996, 12
  %t1036 = select i1 %t1035, i8* %t1034, i8* %t1033
  %t1037 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1038 = icmp eq i32 %t996, 13
  %t1039 = select i1 %t1038, i8* %t1037, i8* %t1036
  %t1040 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1041 = icmp eq i32 %t996, 14
  %t1042 = select i1 %t1041, i8* %t1040, i8* %t1039
  %t1043 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1044 = icmp eq i32 %t996, 15
  %t1045 = select i1 %t1044, i8* %t1043, i8* %t1042
  %t1046 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1047 = icmp eq i32 %t996, 16
  %t1048 = select i1 %t1047, i8* %t1046, i8* %t1045
  %s1049 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1049, i32 0, i32 0
  %t1050 = icmp eq i8* %t1048, %s1049
  br label %logical_and_right_end_983

logical_and_right_end_983:
  br label %logical_and_merge_983

logical_and_merge_983:
  %t1051 = phi i1 [ false, %logical_and_entry_983 ], [ %t1050, %logical_and_right_end_983 ]
  %t1052 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1053 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1054 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1055 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1056 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1057 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1058 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1059 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1060 = load i8*, i8** %l8
  %t1061 = load i8*, i8** %l9
  %t1062 = load i8*, i8** %l10
  %t1063 = load double, double* %l11
  %t1064 = load i8*, i8** %l12
  %t1065 = load i8*, i8** %l13
  %t1066 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1067 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1068 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1051, label %then86, label %else87
then86:
  %t1069 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1070 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1071 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1070
  %t1072 = extractvalue { %NativeInstruction**, i64 } %t1071, 0
  %t1073 = extractvalue { %NativeInstruction**, i64 } %t1071, 1
  %t1074 = icmp uge i64 0, %t1073
  ; bounds check: %t1074 (if true, out of bounds)
  %t1075 = getelementptr %NativeInstruction*, %NativeInstruction** %t1072, i64 0
  %t1076 = load %NativeInstruction*, %NativeInstruction** %t1075
  %t1077 = load %NativeInstruction, %NativeInstruction* %t1076
  %t1078 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1077)
  %t1079 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1069, %NativeBinding %t1078)
  store { %NativeBinding*, i64 }* %t1079, { %NativeBinding*, i64 }** %l7
  br label %merge88
else87:
  %t1080 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1081 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.1081, i32 0, i32 0
  %t1082 = load i8*, i8** %l13
  %t1083 = add i8* %s1081, %t1082
  %t1084 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1080, i8* %t1083)
  store { i8**, i64 }* %t1084, { i8**, i64 }** %l1
  br label %merge88
merge88:
  %t1085 = phi { %NativeBinding*, i64 }* [ %t1079, %then86 ], [ %t1059, %else87 ]
  %t1086 = phi { i8**, i64 }* [ %t1053, %then86 ], [ %t1084, %else87 ]
  store { %NativeBinding*, i64 }* %t1085, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1086, { i8**, i64 }** %l1
  %t1087 = load double, double* %l11
  %t1088 = sitofp i64 1 to double
  %t1089 = fadd double %t1087, %t1088
  store double %t1089, double* %l11
  br label %loop.latch2
merge85:
  %t1090 = sitofp i64 0 to double
  store double %t1090, double* %l34
  %t1091 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1092 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1093 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1094 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1095 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1096 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1097 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1098 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1099 = load i8*, i8** %l8
  %t1100 = load i8*, i8** %l9
  %t1101 = load i8*, i8** %l10
  %t1102 = load double, double* %l11
  %t1103 = load i8*, i8** %l12
  %t1104 = load i8*, i8** %l13
  %t1105 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1106 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1107 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1108 = load double, double* %l34
  br label %loop.header89
loop.header89:
  %t1150 = phi i8* [ %t1099, %loop.body1 ], [ %t1148, %loop.latch91 ]
  %t1151 = phi double [ %t1108, %loop.body1 ], [ %t1149, %loop.latch91 ]
  store i8* %t1150, i8** %l8
  store double %t1151, double* %l34
  br label %loop.body90
loop.body90:
  %t1109 = load double, double* %l34
  %t1110 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1111 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1110
  %t1112 = extractvalue { %NativeInstruction**, i64 } %t1111, 1
  %t1113 = sitofp i64 %t1112 to double
  %t1114 = fcmp oge double %t1109, %t1113
  %t1115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1117 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1118 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1119 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1120 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1121 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1122 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1123 = load i8*, i8** %l8
  %t1124 = load i8*, i8** %l9
  %t1125 = load i8*, i8** %l10
  %t1126 = load double, double* %l11
  %t1127 = load i8*, i8** %l12
  %t1128 = load i8*, i8** %l13
  %t1129 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1130 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1131 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1132 = load double, double* %l34
  br i1 %t1114, label %then93, label %merge94
then93:
  br label %afterloop92
merge94:
  %t1133 = load i8*, i8** %l8
  %t1134 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1135 = load double, double* %l34
  %t1136 = fptosi double %t1135 to i64
  %t1137 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1134
  %t1138 = extractvalue { %NativeInstruction**, i64 } %t1137, 0
  %t1139 = extractvalue { %NativeInstruction**, i64 } %t1137, 1
  %t1140 = icmp uge i64 %t1136, %t1139
  ; bounds check: %t1140 (if true, out of bounds)
  %t1141 = getelementptr %NativeInstruction*, %NativeInstruction** %t1138, i64 %t1136
  %t1142 = load %NativeInstruction*, %NativeInstruction** %t1141
  %t1143 = load %NativeInstruction, %NativeInstruction* %t1142
  %t1144 = call %NativeFunction @append_instruction(i8* null, %NativeInstruction %t1143)
  store i8* null, i8** %l8
  %t1145 = load double, double* %l34
  %t1146 = sitofp i64 1 to double
  %t1147 = fadd double %t1145, %t1146
  store double %t1147, double* %l34
  br label %loop.latch91
loop.latch91:
  %t1148 = load i8*, i8** %l8
  %t1149 = load double, double* %l34
  br label %loop.header89
afterloop92:
  %t1152 = load double, double* %l11
  %t1153 = sitofp i64 1 to double
  %t1154 = fadd double %t1152, %t1153
  store double %t1154, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1155 = load double, double* %l11
  %t1156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1157 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1158 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1159 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1160 = load i8*, i8** %l8
  %t1161 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1162 = load i8*, i8** %l9
  %t1163 = load i8*, i8** %l10
  %t1164 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1175 = load i8*, i8** %l8
  %t1176 = icmp ne i8* %t1175, null
  %t1177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1179 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1180 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1181 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1182 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1183 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1184 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1185 = load i8*, i8** %l8
  %t1186 = load i8*, i8** %l9
  %t1187 = load i8*, i8** %l10
  %t1188 = load double, double* %l11
  br i1 %t1176, label %then95, label %merge96
then95:
  %t1189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1190 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.1190, i32 0, i32 0
  %t1191 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1189, i8* %s1190)
  store { i8**, i64 }* %t1191, { i8**, i64 }** %l1
  br label %merge96
merge96:
  %t1192 = phi { i8**, i64 }* [ %t1191, %then95 ], [ %t1178, %entry ]
  store { i8**, i64 }* %t1192, { i8**, i64 }** %l1
  %t1193 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1194 = bitcast { %NativeFunction*, i64 }* %t1193 to { %NativeFunction**, i64 }*
  %t1195 = insertvalue %ParseNativeResult undef, { %NativeFunction**, i64 }* %t1194, 0
  %t1196 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1197 = bitcast { %NativeImport*, i64 }* %t1196 to { %NativeImport**, i64 }*
  %t1198 = insertvalue %ParseNativeResult %t1195, { %NativeImport**, i64 }* %t1197, 1
  %t1199 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1200 = bitcast { %NativeStruct*, i64 }* %t1199 to { %NativeStruct**, i64 }*
  %t1201 = insertvalue %ParseNativeResult %t1198, { %NativeStruct**, i64 }* %t1200, 2
  %t1202 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1203 = bitcast { %NativeInterface*, i64 }* %t1202 to { %NativeInterface**, i64 }*
  %t1204 = insertvalue %ParseNativeResult %t1201, { %NativeInterface**, i64 }* %t1203, 3
  %t1205 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1206 = bitcast { %NativeEnum*, i64 }* %t1205 to { %NativeEnum**, i64 }*
  %t1207 = insertvalue %ParseNativeResult %t1204, { %NativeEnum**, i64 }* %t1206, 4
  %t1208 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1209 = bitcast { %NativeBinding*, i64 }* %t1208 to { %NativeBinding**, i64 }*
  %t1210 = insertvalue %ParseNativeResult %t1207, { %NativeBinding**, i64 }* %t1209, 5
  %t1211 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1212 = insertvalue %ParseNativeResult %t1210, { i8**, i64 }* %t1211, 6
  ret %ParseNativeResult %t1212
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
  %t44 = bitcast { %NativeStructLayoutField**, i64 }* %t43 to { %NativeStructLayoutField*, i64 }*
  %t45 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t44, %NativeStructLayoutField %field)
  %t46 = bitcast { %NativeStructLayoutField*, i64 }* %t45 to { %NativeStructLayoutField**, i64 }*
  %t47 = insertvalue %NativeEnumVariantLayout %t41, { %NativeStructLayoutField**, i64 }* %t46, 5
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
  %t1 = bitcast { %NativeParameter**, i64 }* %t0 to { %NativeParameter*, i64 }*
  %t2 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t1, %NativeParameter %parameter)
  store { %NativeParameter*, i64 }* %t2, { %NativeParameter*, i64 }** %l0
  %t3 = extractvalue %NativeFunction %function, 0
  %t4 = insertvalue %NativeFunction undef, i8* %t3, 0
  %t5 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l0
  %t6 = bitcast { %NativeParameter*, i64 }* %t5 to { %NativeParameter**, i64 }*
  %t7 = insertvalue %NativeFunction %t4, { %NativeParameter**, i64 }* %t6, 1
  %t8 = extractvalue %NativeFunction %function, 2
  %t9 = insertvalue %NativeFunction %t7, i8* %t8, 2
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = insertvalue %NativeFunction %t9, { i8**, i64 }* %t10, 3
  %t12 = extractvalue %NativeFunction %function, 4
  %t13 = insertvalue %NativeFunction %t11, { %NativeInstruction**, i64 }* %t12, 4
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
  %t7 = bitcast { %NativeInstruction**, i64 }* %t0 to { i8**, i64 }*
  %t8 = bitcast { %NativeInstruction*, i64 }* %t4 to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t7, { i8**, i64 }* %t8)
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t10 = extractvalue %NativeFunction %function, 0
  %t11 = insertvalue %NativeFunction undef, i8* %t10, 0
  %t12 = extractvalue %NativeFunction %function, 1
  %t13 = insertvalue %NativeFunction %t11, { %NativeParameter**, i64 }* %t12, 1
  %t14 = extractvalue %NativeFunction %function, 2
  %t15 = insertvalue %NativeFunction %t13, i8* %t14, 2
  %t16 = extractvalue %NativeFunction %function, 3
  %t17 = insertvalue %NativeFunction %t15, { i8**, i64 }* %t16, 3
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = bitcast { i8**, i64 }* %t18 to { %NativeInstruction**, i64 }*
  %t20 = insertvalue %NativeFunction %t17, { %NativeInstruction**, i64 }* %t19, 4
  ret %NativeFunction %t20
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
  %t3 = insertvalue %NativeFunction %t1, { %NativeParameter**, i64 }* %t2, 1
  %t4 = insertvalue %NativeFunction %t3, i8* %return_type, 2
  %t5 = insertvalue %NativeFunction %t4, { i8**, i64 }* %effects, 3
  %t6 = extractvalue %NativeFunction %function, 4
  %t7 = insertvalue %NativeFunction %t5, { %NativeInstruction**, i64 }* %t6, 4
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
  %t122 = phi i8* [ %t50, %entry ], [ %t118, %loop.latch10 ]
  %t123 = phi %InstructionDepthState [ %t49, %entry ], [ %t119, %loop.latch10 ]
  %t124 = phi double [ %t51, %entry ], [ %t120, %loop.latch10 ]
  %t125 = phi double [ %t52, %entry ], [ %t121, %loop.latch10 ]
  store i8* %t122, i8** %l2
  store %InstructionDepthState %t123, %InstructionDepthState* %l1
  store double %t124, double* %l3
  store double %t125, double* %l4
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
  %t82 = load i8, i8* %t81
  %t83 = add i8 %t82, 10
  %t84 = alloca [2 x i8], align 1
  %t85 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  store i8 %t83, i8* %t85
  %t86 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 1
  store i8 0, i8* %t86
  %t87 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  store i8* %t87, i8** %l2
  br label %merge16
else15:
  %t88 = load i8*, i8** %l2
  %t89 = load i8, i8* %t88
  %t90 = add i8 %t89, 10
  %t91 = load i8*, i8** %l5
  %t92 = load i8, i8* %t91
  %t93 = add i8 %t90, %t92
  %t94 = alloca [2 x i8], align 1
  %t95 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8 %t93, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 1
  store i8 0, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8* %t97, i8** %l2
  %t98 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t99 = load i8*, i8** %l5
  %t100 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t98, i8* %t99)
  store %InstructionDepthState %t100, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t101 = phi i8* [ %t87, %then14 ], [ %t97, %else15 ]
  %t102 = phi %InstructionDepthState [ %t76, %then14 ], [ %t100, %else15 ]
  store i8* %t101, i8** %l2
  store %InstructionDepthState %t102, %InstructionDepthState* %l1
  %t103 = load double, double* %l3
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l3
  %t106 = load double, double* %l4
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l4
  %t109 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t110 = call i1 @instruction_requires_continuation(%InstructionDepthState %t109)
  %t111 = xor i1 %t110, 1
  %t112 = load i8*, i8** %l0
  %t113 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t114 = load i8*, i8** %l2
  %t115 = load double, double* %l3
  %t116 = load double, double* %l4
  %t117 = load i8*, i8** %l5
  br i1 %t111, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t118 = load i8*, i8** %l2
  %t119 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t120 = load double, double* %l3
  %t121 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t126 = load i8*, i8** %l2
  %t127 = call i8* @trim_text(i8* %t126)
  store i8* %t127, i8** %l6
  %t128 = load i8*, i8** %l6
  %t129 = insertvalue %InstructionGatherResult undef, i8* %t128, 0
  %t130 = load double, double* %l3
  %t131 = insertvalue %InstructionGatherResult %t129, double %t130, 1
  ret %InstructionGatherResult %t131
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
  %t3 = call noalias i8* @malloc(i64 56)
  %t4 = bitcast i8* %t3 to %NativeInstruction*
  store %NativeInstruction %t2, %NativeInstruction* %t4
  %t5 = bitcast i8* %t3 to %NativeInstruction*
  %t6 = alloca [1 x %NativeInstruction*]
  %t7 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t6, i32 0, i32 0
  %t8 = getelementptr %NativeInstruction*, %NativeInstruction** %t7, i64 0
  store %NativeInstruction* %t5, %NativeInstruction** %t8
  %t9 = alloca { %NativeInstruction**, i64 }
  %t10 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t9, i32 0, i32 0
  store %NativeInstruction** %t7, %NativeInstruction*** %t10
  %t11 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t9, 0
  %t13 = insertvalue %InstructionParseResult %t12, i1 0, 1
  %t14 = insertvalue %InstructionParseResult %t13, i1 0, 2
  ret %InstructionParseResult %t14
merge1:
  %s15 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.15, i32 0, i32 0
  %t16 = call i1 @starts_with(i8* %line, i8* %s15)
  br i1 %t16, label %then2, label %merge3
then2:
  %s17 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.17, i32 0, i32 0
  %t18 = call i8* @strip_prefix(i8* %line, i8* %s17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l0
  %t20 = alloca %NativeInstruction
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 0
  store i32 3, i32* %t21
  %t22 = load i8*, i8** %l0
  %t23 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t24 = bitcast [8 x i8]* %t23 to i8*
  %t25 = bitcast i8* %t24 to i8**
  store i8* %t22, i8** %t25
  %t26 = load %NativeInstruction, %NativeInstruction* %t20
  %t27 = alloca [1 x %NativeInstruction]
  %t28 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t27, i32 0, i32 0
  %t29 = getelementptr %NativeInstruction, %NativeInstruction* %t28, i64 0
  store %NativeInstruction %t26, %NativeInstruction* %t29
  %t30 = alloca { %NativeInstruction*, i64 }
  %t31 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t30, i32 0, i32 0
  store %NativeInstruction* %t28, %NativeInstruction** %t31
  %t32 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t30, i32 0, i32 1
  store i64 1, i64* %t32
  %t33 = bitcast { %NativeInstruction*, i64 }* %t30 to { %NativeInstruction**, i64 }*
  %t34 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t33, 0
  %t35 = insertvalue %InstructionParseResult %t34, i1 0, 1
  %t36 = insertvalue %InstructionParseResult %t35, i1 0, 2
  ret %InstructionParseResult %t36
merge3:
  %s37 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.37, i32 0, i32 0
  %t38 = icmp eq i8* %line, %s37
  br i1 %t38, label %then4, label %merge5
then4:
  %t39 = insertvalue %NativeInstruction undef, i32 4, 0
  %t40 = call noalias i8* @malloc(i64 56)
  %t41 = bitcast i8* %t40 to %NativeInstruction*
  store %NativeInstruction %t39, %NativeInstruction* %t41
  %t42 = bitcast i8* %t40 to %NativeInstruction*
  %t43 = alloca [1 x %NativeInstruction*]
  %t44 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t43, i32 0, i32 0
  %t45 = getelementptr %NativeInstruction*, %NativeInstruction** %t44, i64 0
  store %NativeInstruction* %t42, %NativeInstruction** %t45
  %t46 = alloca { %NativeInstruction**, i64 }
  %t47 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t46, i32 0, i32 0
  store %NativeInstruction** %t44, %NativeInstruction*** %t47
  %t48 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t46, i32 0, i32 1
  store i64 1, i64* %t48
  %t49 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t46, 0
  %t50 = insertvalue %InstructionParseResult %t49, i1 0, 1
  %t51 = insertvalue %InstructionParseResult %t50, i1 0, 2
  ret %InstructionParseResult %t51
merge5:
  %s52 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.52, i32 0, i32 0
  %t53 = icmp eq i8* %line, %s52
  br i1 %t53, label %then6, label %merge7
then6:
  %t54 = insertvalue %NativeInstruction undef, i32 5, 0
  %t55 = call noalias i8* @malloc(i64 56)
  %t56 = bitcast i8* %t55 to %NativeInstruction*
  store %NativeInstruction %t54, %NativeInstruction* %t56
  %t57 = bitcast i8* %t55 to %NativeInstruction*
  %t58 = alloca [1 x %NativeInstruction*]
  %t59 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t58, i32 0, i32 0
  %t60 = getelementptr %NativeInstruction*, %NativeInstruction** %t59, i64 0
  store %NativeInstruction* %t57, %NativeInstruction** %t60
  %t61 = alloca { %NativeInstruction**, i64 }
  %t62 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t61, i32 0, i32 0
  store %NativeInstruction** %t59, %NativeInstruction*** %t62
  %t63 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t61, 0
  %t65 = insertvalue %InstructionParseResult %t64, i1 0, 1
  %t66 = insertvalue %InstructionParseResult %t65, i1 0, 2
  ret %InstructionParseResult %t66
merge7:
  %s67 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.67, i32 0, i32 0
  %t68 = call i1 @starts_with(i8* %line, i8* %s67)
  br i1 %t68, label %then8, label %merge9
then8:
  %s69 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.69, i32 0, i32 0
  %t70 = call i8* @strip_prefix(i8* %line, i8* %s69)
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l1
  %s72 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.72, i32 0, i32 0
  store i8* %s72, i8** %l2
  %t73 = load i8*, i8** %l1
  %t74 = load i8*, i8** %l2
  %t75 = call double @index_of(i8* %t73, i8* %t74)
  store double %t75, double* %l3
  %t76 = load double, double* %l3
  %t77 = sitofp i64 0 to double
  %t78 = fcmp oge double %t76, %t77
  %t79 = load i8*, i8** %l1
  %t80 = load i8*, i8** %l2
  %t81 = load double, double* %l3
  br i1 %t78, label %then10, label %merge11
then10:
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l3
  %t84 = fptosi double %t83 to i64
  %t85 = call i8* @sailfin_runtime_substring(i8* %t82, i64 0, i64 %t84)
  %t86 = call i8* @trim_text(i8* %t85)
  store i8* %t86, i8** %l4
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l2
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = sitofp i64 %t90 to double
  %t92 = fadd double %t88, %t91
  %t93 = load i8*, i8** %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = fptosi double %t92 to i64
  %t96 = call i8* @sailfin_runtime_substring(i8* %t87, i64 %t95, i64 %t94)
  %t97 = call i8* @trim_text(i8* %t96)
  store i8* %t97, i8** %l5
  %t98 = alloca %NativeInstruction
  %t99 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t98, i32 0, i32 0
  store i32 6, i32* %t99
  %t100 = load i8*, i8** %l4
  %t101 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t98, i32 0, i32 1
  %t102 = bitcast [16 x i8]* %t101 to i8*
  %t103 = bitcast i8* %t102 to i8**
  store i8* %t100, i8** %t103
  %t104 = load i8*, i8** %l5
  %t105 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t98, i32 0, i32 1
  %t106 = bitcast [16 x i8]* %t105 to i8*
  %t107 = getelementptr inbounds i8, i8* %t106, i64 8
  %t108 = bitcast i8* %t107 to i8**
  store i8* %t104, i8** %t108
  %t109 = load %NativeInstruction, %NativeInstruction* %t98
  %t110 = alloca [1 x %NativeInstruction]
  %t111 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t110, i32 0, i32 0
  %t112 = getelementptr %NativeInstruction, %NativeInstruction* %t111, i64 0
  store %NativeInstruction %t109, %NativeInstruction* %t112
  %t113 = alloca { %NativeInstruction*, i64 }
  %t114 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t113, i32 0, i32 0
  store %NativeInstruction* %t111, %NativeInstruction** %t114
  %t115 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t113, i32 0, i32 1
  store i64 1, i64* %t115
  %t116 = bitcast { %NativeInstruction*, i64 }* %t113 to { %NativeInstruction**, i64 }*
  %t117 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t116, 0
  %t118 = insertvalue %InstructionParseResult %t117, i1 0, 1
  %t119 = insertvalue %InstructionParseResult %t118, i1 0, 2
  ret %InstructionParseResult %t119
merge11:
  br label %merge9
merge9:
  %s120 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.120, i32 0, i32 0
  %t121 = icmp eq i8* %line, %s120
  br i1 %t121, label %then12, label %merge13
then12:
  %t122 = insertvalue %NativeInstruction undef, i32 7, 0
  %t123 = call noalias i8* @malloc(i64 56)
  %t124 = bitcast i8* %t123 to %NativeInstruction*
  store %NativeInstruction %t122, %NativeInstruction* %t124
  %t125 = bitcast i8* %t123 to %NativeInstruction*
  %t126 = alloca [1 x %NativeInstruction*]
  %t127 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t126, i32 0, i32 0
  %t128 = getelementptr %NativeInstruction*, %NativeInstruction** %t127, i64 0
  store %NativeInstruction* %t125, %NativeInstruction** %t128
  %t129 = alloca { %NativeInstruction**, i64 }
  %t130 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t129, i32 0, i32 0
  store %NativeInstruction** %t127, %NativeInstruction*** %t130
  %t131 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t129, i32 0, i32 1
  store i64 1, i64* %t131
  %t132 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t129, 0
  %t133 = insertvalue %InstructionParseResult %t132, i1 0, 1
  %t134 = insertvalue %InstructionParseResult %t133, i1 0, 2
  ret %InstructionParseResult %t134
merge13:
  %s135 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.135, i32 0, i32 0
  %t136 = icmp eq i8* %line, %s135
  br i1 %t136, label %then14, label %merge15
then14:
  %t137 = insertvalue %NativeInstruction undef, i32 8, 0
  %t138 = call noalias i8* @malloc(i64 56)
  %t139 = bitcast i8* %t138 to %NativeInstruction*
  store %NativeInstruction %t137, %NativeInstruction* %t139
  %t140 = bitcast i8* %t138 to %NativeInstruction*
  %t141 = alloca [1 x %NativeInstruction*]
  %t142 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t141, i32 0, i32 0
  %t143 = getelementptr %NativeInstruction*, %NativeInstruction** %t142, i64 0
  store %NativeInstruction* %t140, %NativeInstruction** %t143
  %t144 = alloca { %NativeInstruction**, i64 }
  %t145 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t144, i32 0, i32 0
  store %NativeInstruction** %t142, %NativeInstruction*** %t145
  %t146 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t144, i32 0, i32 1
  store i64 1, i64* %t146
  %t147 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t144, 0
  %t148 = insertvalue %InstructionParseResult %t147, i1 0, 1
  %t149 = insertvalue %InstructionParseResult %t148, i1 0, 2
  ret %InstructionParseResult %t149
merge15:
  %s150 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.150, i32 0, i32 0
  %t151 = icmp eq i8* %line, %s150
  br i1 %t151, label %then16, label %merge17
then16:
  %t152 = insertvalue %NativeInstruction undef, i32 9, 0
  %t153 = call noalias i8* @malloc(i64 56)
  %t154 = bitcast i8* %t153 to %NativeInstruction*
  store %NativeInstruction %t152, %NativeInstruction* %t154
  %t155 = bitcast i8* %t153 to %NativeInstruction*
  %t156 = alloca [1 x %NativeInstruction*]
  %t157 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t156, i32 0, i32 0
  %t158 = getelementptr %NativeInstruction*, %NativeInstruction** %t157, i64 0
  store %NativeInstruction* %t155, %NativeInstruction** %t158
  %t159 = alloca { %NativeInstruction**, i64 }
  %t160 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t159, i32 0, i32 0
  store %NativeInstruction** %t157, %NativeInstruction*** %t160
  %t161 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t159, i32 0, i32 1
  store i64 1, i64* %t161
  %t162 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t159, 0
  %t163 = insertvalue %InstructionParseResult %t162, i1 0, 1
  %t164 = insertvalue %InstructionParseResult %t163, i1 0, 2
  ret %InstructionParseResult %t164
merge17:
  %s165 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.165, i32 0, i32 0
  %t166 = icmp eq i8* %line, %s165
  br i1 %t166, label %then18, label %merge19
then18:
  %t167 = insertvalue %NativeInstruction undef, i32 10, 0
  %t168 = call noalias i8* @malloc(i64 56)
  %t169 = bitcast i8* %t168 to %NativeInstruction*
  store %NativeInstruction %t167, %NativeInstruction* %t169
  %t170 = bitcast i8* %t168 to %NativeInstruction*
  %t171 = alloca [1 x %NativeInstruction*]
  %t172 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t171, i32 0, i32 0
  %t173 = getelementptr %NativeInstruction*, %NativeInstruction** %t172, i64 0
  store %NativeInstruction* %t170, %NativeInstruction** %t173
  %t174 = alloca { %NativeInstruction**, i64 }
  %t175 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t174, i32 0, i32 0
  store %NativeInstruction** %t172, %NativeInstruction*** %t175
  %t176 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t174, i32 0, i32 1
  store i64 1, i64* %t176
  %t177 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t174, 0
  %t178 = insertvalue %InstructionParseResult %t177, i1 0, 1
  %t179 = insertvalue %InstructionParseResult %t178, i1 0, 2
  ret %InstructionParseResult %t179
merge19:
  %s180 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.180, i32 0, i32 0
  %t181 = icmp eq i8* %line, %s180
  br i1 %t181, label %then20, label %merge21
then20:
  %t182 = insertvalue %NativeInstruction undef, i32 11, 0
  %t183 = call noalias i8* @malloc(i64 56)
  %t184 = bitcast i8* %t183 to %NativeInstruction*
  store %NativeInstruction %t182, %NativeInstruction* %t184
  %t185 = bitcast i8* %t183 to %NativeInstruction*
  %t186 = alloca [1 x %NativeInstruction*]
  %t187 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t186, i32 0, i32 0
  %t188 = getelementptr %NativeInstruction*, %NativeInstruction** %t187, i64 0
  store %NativeInstruction* %t185, %NativeInstruction** %t188
  %t189 = alloca { %NativeInstruction**, i64 }
  %t190 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t189, i32 0, i32 0
  store %NativeInstruction** %t187, %NativeInstruction*** %t190
  %t191 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t189, i32 0, i32 1
  store i64 1, i64* %t191
  %t192 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t189, 0
  %t193 = insertvalue %InstructionParseResult %t192, i1 0, 1
  %t194 = insertvalue %InstructionParseResult %t193, i1 0, 2
  ret %InstructionParseResult %t194
merge21:
  %s195 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.195, i32 0, i32 0
  %t196 = call i1 @starts_with(i8* %line, i8* %s195)
  br i1 %t196, label %then22, label %merge23
then22:
  %s197 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.197, i32 0, i32 0
  %t198 = call i8* @strip_prefix(i8* %line, i8* %s197)
  %t199 = call i8* @trim_text(i8* %t198)
  store i8* %t199, i8** %l6
  %t200 = alloca %NativeInstruction
  %t201 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t200, i32 0, i32 0
  store i32 12, i32* %t201
  %t202 = load i8*, i8** %l6
  %t203 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t200, i32 0, i32 1
  %t204 = bitcast [8 x i8]* %t203 to i8*
  %t205 = bitcast i8* %t204 to i8**
  store i8* %t202, i8** %t205
  %t206 = load %NativeInstruction, %NativeInstruction* %t200
  %t207 = alloca [1 x %NativeInstruction]
  %t208 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t207, i32 0, i32 0
  %t209 = getelementptr %NativeInstruction, %NativeInstruction* %t208, i64 0
  store %NativeInstruction %t206, %NativeInstruction* %t209
  %t210 = alloca { %NativeInstruction*, i64 }
  %t211 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t210, i32 0, i32 0
  store %NativeInstruction* %t208, %NativeInstruction** %t211
  %t212 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t210, i32 0, i32 1
  store i64 1, i64* %t212
  %t213 = bitcast { %NativeInstruction*, i64 }* %t210 to { %NativeInstruction**, i64 }*
  %t214 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t213, 0
  %t215 = insertvalue %InstructionParseResult %t214, i1 0, 1
  %t216 = insertvalue %InstructionParseResult %t215, i1 0, 2
  ret %InstructionParseResult %t216
merge23:
  %s217 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.217, i32 0, i32 0
  %t218 = call i1 @starts_with(i8* %line, i8* %s217)
  br i1 %t218, label %then24, label %merge25
then24:
  %t219 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t220 = call noalias i8* @malloc(i64 56)
  %t221 = bitcast i8* %t220 to %NativeInstruction*
  store %NativeInstruction %t219, %NativeInstruction* %t221
  %t222 = bitcast i8* %t220 to %NativeInstruction*
  %t223 = alloca [1 x %NativeInstruction*]
  %t224 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t223, i32 0, i32 0
  %t225 = getelementptr %NativeInstruction*, %NativeInstruction** %t224, i64 0
  store %NativeInstruction* %t222, %NativeInstruction** %t225
  %t226 = alloca { %NativeInstruction**, i64 }
  %t227 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t226, i32 0, i32 0
  store %NativeInstruction** %t224, %NativeInstruction*** %t227
  %t228 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t226, i32 0, i32 1
  store i64 1, i64* %t228
  %t229 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t226, 0
  %t230 = insertvalue %InstructionParseResult %t229, i1 0, 1
  %t231 = insertvalue %InstructionParseResult %t230, i1 0, 2
  ret %InstructionParseResult %t231
merge25:
  %s232 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.232, i32 0, i32 0
  %t233 = icmp eq i8* %line, %s232
  br i1 %t233, label %then26, label %merge27
then26:
  %t234 = insertvalue %NativeInstruction undef, i32 14, 0
  %t235 = call noalias i8* @malloc(i64 56)
  %t236 = bitcast i8* %t235 to %NativeInstruction*
  store %NativeInstruction %t234, %NativeInstruction* %t236
  %t237 = bitcast i8* %t235 to %NativeInstruction*
  %t238 = alloca [1 x %NativeInstruction*]
  %t239 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t238, i32 0, i32 0
  %t240 = getelementptr %NativeInstruction*, %NativeInstruction** %t239, i64 0
  store %NativeInstruction* %t237, %NativeInstruction** %t240
  %t241 = alloca { %NativeInstruction**, i64 }
  %t242 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t241, i32 0, i32 0
  store %NativeInstruction** %t239, %NativeInstruction*** %t242
  %t243 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t241, i32 0, i32 1
  store i64 1, i64* %t243
  %t244 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t241, 0
  %t245 = insertvalue %InstructionParseResult %t244, i1 0, 1
  %t246 = insertvalue %InstructionParseResult %t245, i1 0, 2
  ret %InstructionParseResult %t246
merge27:
  %s247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.247, i32 0, i32 0
  %t248 = call i1 @starts_with(i8* %line, i8* %s247)
  br i1 %t248, label %then28, label %merge29
then28:
  %t249 = call %NativeInstruction @parse_let_instruction(i8* %line, i8* %span, i8* %value_span)
  %t250 = call noalias i8* @malloc(i64 56)
  %t251 = bitcast i8* %t250 to %NativeInstruction*
  store %NativeInstruction %t249, %NativeInstruction* %t251
  %t252 = bitcast i8* %t250 to %NativeInstruction*
  %t253 = alloca [1 x %NativeInstruction*]
  %t254 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* %t253, i32 0, i32 0
  %t255 = getelementptr %NativeInstruction*, %NativeInstruction** %t254, i64 0
  store %NativeInstruction* %t252, %NativeInstruction** %t255
  %t256 = alloca { %NativeInstruction**, i64 }
  %t257 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t256, i32 0, i32 0
  store %NativeInstruction** %t254, %NativeInstruction*** %t257
  %t258 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t256, i32 0, i32 1
  store i64 1, i64* %t258
  %t259 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t256, 0
  %t260 = insertvalue %InstructionParseResult %t259, i1 1, 1
  %t261 = insertvalue %InstructionParseResult %t260, i1 1, 2
  ret %InstructionParseResult %t261
merge29:
  %s262 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.262, i32 0, i32 0
  %t263 = call i1 @starts_with(i8* %line, i8* %s262)
  br i1 %t263, label %then30, label %merge31
then30:
  %t264 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t265 = icmp eq i64 %t264, 3
  br i1 %t265, label %then32, label %merge33
then32:
  %t266 = alloca %NativeInstruction
  %t267 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 0
  store i32 0, i32* %t267
  %s268 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.268, i32 0, i32 0
  %t269 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t270 = bitcast [16 x i8]* %t269 to i8*
  %t271 = bitcast i8* %t270 to i8**
  store i8* %s268, i8** %t271
  %t272 = bitcast i8* %span to %NativeSourceSpan*
  %t273 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t274 = bitcast [16 x i8]* %t273 to i8*
  %t275 = getelementptr inbounds i8, i8* %t274, i64 8
  %t276 = bitcast i8* %t275 to %NativeSourceSpan**
  store %NativeSourceSpan* %t272, %NativeSourceSpan** %t276
  %t277 = load %NativeInstruction, %NativeInstruction* %t266
  %t278 = alloca [1 x %NativeInstruction]
  %t279 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t278, i32 0, i32 0
  %t280 = getelementptr %NativeInstruction, %NativeInstruction* %t279, i64 0
  store %NativeInstruction %t277, %NativeInstruction* %t280
  %t281 = alloca { %NativeInstruction*, i64 }
  %t282 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t281, i32 0, i32 0
  store %NativeInstruction* %t279, %NativeInstruction** %t282
  %t283 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t281, i32 0, i32 1
  store i64 1, i64* %t283
  %t284 = bitcast { %NativeInstruction*, i64 }* %t281 to { %NativeInstruction**, i64 }*
  %t285 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t284, 0
  %t286 = insertvalue %InstructionParseResult %t285, i1 1, 1
  %t287 = insertvalue %InstructionParseResult %t286, i1 0, 2
  ret %InstructionParseResult %t287
merge33:
  %t288 = getelementptr i8, i8* %line, i64 3
  %t289 = load i8, i8* %t288
  store i8 %t289, i8* %l7
  %t291 = load i8, i8* %l7
  %t292 = icmp eq i8 %t291, 32
  br label %logical_or_entry_290

logical_or_entry_290:
  br i1 %t292, label %logical_or_merge_290, label %logical_or_right_290

logical_or_right_290:
  %t293 = load i8, i8* %l7
  %t294 = icmp eq i8 %t293, 9
  br label %logical_or_right_end_290

logical_or_right_end_290:
  br label %logical_or_merge_290

logical_or_merge_290:
  %t295 = phi i1 [ true, %logical_or_entry_290 ], [ %t294, %logical_or_right_end_290 ]
  %t296 = load i8, i8* %l7
  br i1 %t295, label %then34, label %merge35
then34:
  %t297 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t298 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t297)
  %t299 = call i8* @trim_text(i8* %t298)
  store i8* %t299, i8** %l8
  %t300 = load i8*, i8** %l8
  %t301 = call i64 @sailfin_runtime_string_length(i8* %t300)
  %t302 = icmp eq i64 %t301, 0
  %t303 = load i8, i8* %l7
  %t304 = load i8*, i8** %l8
  br i1 %t302, label %then36, label %merge37
then36:
  %t305 = alloca %NativeInstruction
  %t306 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t305, i32 0, i32 0
  store i32 0, i32* %t306
  %s307 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.307, i32 0, i32 0
  %t308 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t305, i32 0, i32 1
  %t309 = bitcast [16 x i8]* %t308 to i8*
  %t310 = bitcast i8* %t309 to i8**
  store i8* %s307, i8** %t310
  %t311 = bitcast i8* %span to %NativeSourceSpan*
  %t312 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t305, i32 0, i32 1
  %t313 = bitcast [16 x i8]* %t312 to i8*
  %t314 = getelementptr inbounds i8, i8* %t313, i64 8
  %t315 = bitcast i8* %t314 to %NativeSourceSpan**
  store %NativeSourceSpan* %t311, %NativeSourceSpan** %t315
  %t316 = load %NativeInstruction, %NativeInstruction* %t305
  %t317 = alloca [1 x %NativeInstruction]
  %t318 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t317, i32 0, i32 0
  %t319 = getelementptr %NativeInstruction, %NativeInstruction* %t318, i64 0
  store %NativeInstruction %t316, %NativeInstruction* %t319
  %t320 = alloca { %NativeInstruction*, i64 }
  %t321 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t320, i32 0, i32 0
  store %NativeInstruction* %t318, %NativeInstruction** %t321
  %t322 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t320, i32 0, i32 1
  store i64 1, i64* %t322
  %t323 = bitcast { %NativeInstruction*, i64 }* %t320 to { %NativeInstruction**, i64 }*
  %t324 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t323, 0
  %t325 = insertvalue %InstructionParseResult %t324, i1 1, 1
  %t326 = insertvalue %InstructionParseResult %t325, i1 0, 2
  ret %InstructionParseResult %t326
merge37:
  %t327 = alloca %NativeInstruction
  %t328 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t327, i32 0, i32 0
  store i32 0, i32* %t328
  %t329 = load i8*, i8** %l8
  %t330 = call i8* @trim_trailing_delimiters(i8* %t329)
  %t331 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t327, i32 0, i32 1
  %t332 = bitcast [16 x i8]* %t331 to i8*
  %t333 = bitcast i8* %t332 to i8**
  store i8* %t330, i8** %t333
  %t334 = bitcast i8* %span to %NativeSourceSpan*
  %t335 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t327, i32 0, i32 1
  %t336 = bitcast [16 x i8]* %t335 to i8*
  %t337 = getelementptr inbounds i8, i8* %t336, i64 8
  %t338 = bitcast i8* %t337 to %NativeSourceSpan**
  store %NativeSourceSpan* %t334, %NativeSourceSpan** %t338
  %t339 = load %NativeInstruction, %NativeInstruction* %t327
  %t340 = alloca [1 x %NativeInstruction]
  %t341 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t340, i32 0, i32 0
  %t342 = getelementptr %NativeInstruction, %NativeInstruction* %t341, i64 0
  store %NativeInstruction %t339, %NativeInstruction* %t342
  %t343 = alloca { %NativeInstruction*, i64 }
  %t344 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t343, i32 0, i32 0
  store %NativeInstruction* %t341, %NativeInstruction** %t344
  %t345 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t343, i32 0, i32 1
  store i64 1, i64* %t345
  %t346 = bitcast { %NativeInstruction*, i64 }* %t343 to { %NativeInstruction**, i64 }*
  %t347 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t346, 0
  %t348 = insertvalue %InstructionParseResult %t347, i1 1, 1
  %t349 = insertvalue %InstructionParseResult %t348, i1 0, 2
  ret %InstructionParseResult %t349
merge35:
  br label %merge31
merge31:
  %s350 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.350, i32 0, i32 0
  %t351 = call i1 @starts_with(i8* %line, i8* %s350)
  br i1 %t351, label %then38, label %merge39
then38:
  %s352 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.352, i32 0, i32 0
  %t353 = call i8* @strip_prefix(i8* %line, i8* %s352)
  %t354 = call i8* @trim_text(i8* %t353)
  store i8* %t354, i8** %l9
  store i1 0, i1* %l10
  %t355 = load i8*, i8** %l9
  %s356 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.356, i32 0, i32 0
  %t357 = call i1 @starts_with(i8* %t355, i8* %s356)
  %t358 = load i8*, i8** %l9
  %t359 = load i1, i1* %l10
  br i1 %t357, label %then40, label %merge41
then40:
  store i1 1, i1* %l10
  %t360 = load i8*, i8** %l9
  %s361 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.361, i32 0, i32 0
  %t362 = call i8* @strip_prefix(i8* %t360, i8* %s361)
  %t363 = call i8* @trim_text(i8* %t362)
  store i8* %t363, i8** %l9
  br label %merge41
merge41:
  %t364 = phi i1 [ 1, %then40 ], [ %t359, %then38 ]
  %t365 = phi i8* [ %t363, %then40 ], [ %t358, %then38 ]
  store i1 %t364, i1* %l10
  store i8* %t365, i8** %l9
  %t366 = load i8*, i8** %l9
  %t367 = call %BindingComponents @parse_binding_components(i8* %t366)
  store %BindingComponents %t367, %BindingComponents* %l11
  %t368 = alloca %NativeInstruction
  %t369 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 0
  store i32 2, i32* %t369
  %t370 = load %BindingComponents, %BindingComponents* %l11
  %t371 = extractvalue %BindingComponents %t370, 0
  %t372 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 1
  %t373 = bitcast [48 x i8]* %t372 to i8*
  %t374 = bitcast i8* %t373 to i8**
  store i8* %t371, i8** %t374
  %t375 = load i1, i1* %l10
  %t376 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 1
  %t377 = bitcast [48 x i8]* %t376 to i8*
  %t378 = getelementptr inbounds i8, i8* %t377, i64 8
  %t379 = bitcast i8* %t378 to i1*
  store i1 %t375, i1* %t379
  %t380 = load %BindingComponents, %BindingComponents* %l11
  %t381 = extractvalue %BindingComponents %t380, 1
  %t382 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 1
  %t383 = bitcast [48 x i8]* %t382 to i8*
  %t384 = getelementptr inbounds i8, i8* %t383, i64 16
  %t385 = bitcast i8* %t384 to i8**
  store i8* %t381, i8** %t385
  %t386 = load %BindingComponents, %BindingComponents* %l11
  %t387 = extractvalue %BindingComponents %t386, 2
  %t388 = call double @maybe_trim_trailing(i8* %t387)
  %t389 = call noalias i8* @malloc(i64 8)
  %t390 = bitcast i8* %t389 to double*
  store double %t388, double* %t390
  %t391 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 1
  %t392 = bitcast [48 x i8]* %t391 to i8*
  %t393 = getelementptr inbounds i8, i8* %t392, i64 24
  %t394 = bitcast i8* %t393 to i8**
  store i8* %t389, i8** %t394
  %t395 = bitcast i8* %span to %NativeSourceSpan*
  %t396 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 1
  %t397 = bitcast [48 x i8]* %t396 to i8*
  %t398 = getelementptr inbounds i8, i8* %t397, i64 32
  %t399 = bitcast i8* %t398 to %NativeSourceSpan**
  store %NativeSourceSpan* %t395, %NativeSourceSpan** %t399
  %t400 = bitcast i8* %value_span to %NativeSourceSpan*
  %t401 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t368, i32 0, i32 1
  %t402 = bitcast [48 x i8]* %t401 to i8*
  %t403 = getelementptr inbounds i8, i8* %t402, i64 40
  %t404 = bitcast i8* %t403 to %NativeSourceSpan**
  store %NativeSourceSpan* %t400, %NativeSourceSpan** %t404
  %t405 = load %NativeInstruction, %NativeInstruction* %t368
  %t406 = alloca [1 x %NativeInstruction]
  %t407 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t406, i32 0, i32 0
  %t408 = getelementptr %NativeInstruction, %NativeInstruction* %t407, i64 0
  store %NativeInstruction %t405, %NativeInstruction* %t408
  %t409 = alloca { %NativeInstruction*, i64 }
  %t410 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t409, i32 0, i32 0
  store %NativeInstruction* %t407, %NativeInstruction** %t410
  %t411 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t409, i32 0, i32 1
  store i64 1, i64* %t411
  %t412 = bitcast { %NativeInstruction*, i64 }* %t409 to { %NativeInstruction**, i64 }*
  %t413 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t412, 0
  %t414 = insertvalue %InstructionParseResult %t413, i1 1, 1
  %t415 = insertvalue %InstructionParseResult %t414, i1 1, 2
  ret %InstructionParseResult %t415
merge39:
  %s416 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.416, i32 0, i32 0
  %t417 = call i1 @starts_with(i8* %line, i8* %s416)
  br i1 %t417, label %then42, label %merge43
then42:
  %t418 = alloca %NativeInstruction
  %t419 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t418, i32 0, i32 0
  store i32 1, i32* %t419
  %s420 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.420, i32 0, i32 0
  %t421 = call i8* @strip_prefix(i8* %line, i8* %s420)
  %t422 = call i8* @trim_text(i8* %t421)
  %t423 = call i8* @trim_trailing_delimiters(i8* %t422)
  %t424 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t418, i32 0, i32 1
  %t425 = bitcast [16 x i8]* %t424 to i8*
  %t426 = bitcast i8* %t425 to i8**
  store i8* %t423, i8** %t426
  %t427 = bitcast i8* %span to %NativeSourceSpan*
  %t428 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t418, i32 0, i32 1
  %t429 = bitcast [16 x i8]* %t428 to i8*
  %t430 = getelementptr inbounds i8, i8* %t429, i64 8
  %t431 = bitcast i8* %t430 to %NativeSourceSpan**
  store %NativeSourceSpan* %t427, %NativeSourceSpan** %t431
  %t432 = load %NativeInstruction, %NativeInstruction* %t418
  %t433 = alloca [1 x %NativeInstruction]
  %t434 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t433, i32 0, i32 0
  %t435 = getelementptr %NativeInstruction, %NativeInstruction* %t434, i64 0
  store %NativeInstruction %t432, %NativeInstruction* %t435
  %t436 = alloca { %NativeInstruction*, i64 }
  %t437 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t436, i32 0, i32 0
  store %NativeInstruction* %t434, %NativeInstruction** %t437
  %t438 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t436, i32 0, i32 1
  store i64 1, i64* %t438
  %t439 = bitcast { %NativeInstruction*, i64 }* %t436 to { %NativeInstruction**, i64 }*
  %t440 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t439, 0
  %t441 = insertvalue %InstructionParseResult %t440, i1 1, 1
  %t442 = insertvalue %InstructionParseResult %t441, i1 0, 2
  ret %InstructionParseResult %t442
merge43:
  %s443 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.443, i32 0, i32 0
  %t444 = call double @index_of(i8* %line, i8* %s443)
  %t445 = sitofp i64 0 to double
  %t446 = fcmp oge double %t444, %t445
  br i1 %t446, label %then44, label %merge45
then44:
  %t447 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t448 = bitcast { %NativeInstruction*, i64 }* %t447 to { %NativeInstruction**, i64 }*
  %t449 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t448, 0
  %t450 = insertvalue %InstructionParseResult %t449, i1 0, 1
  %t451 = insertvalue %InstructionParseResult %t450, i1 0, 2
  ret %InstructionParseResult %t451
merge45:
  %t452 = alloca %NativeInstruction
  %t453 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t452, i32 0, i32 0
  store i32 16, i32* %t453
  %t454 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t452, i32 0, i32 1
  %t455 = bitcast [8 x i8]* %t454 to i8*
  %t456 = bitcast i8* %t455 to i8**
  store i8* %line, i8** %t456
  %t457 = load %NativeInstruction, %NativeInstruction* %t452
  %t458 = alloca [1 x %NativeInstruction]
  %t459 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t458, i32 0, i32 0
  %t460 = getelementptr %NativeInstruction, %NativeInstruction* %t459, i64 0
  store %NativeInstruction %t457, %NativeInstruction* %t460
  %t461 = alloca { %NativeInstruction*, i64 }
  %t462 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t461, i32 0, i32 0
  store %NativeInstruction* %t459, %NativeInstruction** %t462
  %t463 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t461, i32 0, i32 1
  store i64 1, i64* %t463
  %t464 = bitcast { %NativeInstruction*, i64 }* %t461 to { %NativeInstruction**, i64 }*
  %t465 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t464, 0
  %t466 = insertvalue %InstructionParseResult %t465, i1 0, 1
  %t467 = insertvalue %InstructionParseResult %t466, i1 0, 2
  ret %InstructionParseResult %t467
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
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @index_of(i8* %t2, i8* %s3)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = alloca %NativeInstruction
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 0
  store i32 16, i32* %t11
  %t12 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t13 = bitcast [8 x i8]* %t12 to i8*
  %t14 = bitcast i8* %t13 to i8**
  store i8* %line, i8** %t14
  %t15 = load %NativeInstruction, %NativeInstruction* %t10
  %t16 = alloca [1 x %NativeInstruction]
  %t17 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t16, i32 0, i32 0
  %t18 = getelementptr %NativeInstruction, %NativeInstruction* %t17, i64 0
  store %NativeInstruction %t15, %NativeInstruction* %t18
  %t19 = alloca { %NativeInstruction*, i64 }
  %t20 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t19, i32 0, i32 0
  store %NativeInstruction* %t17, %NativeInstruction** %t20
  %t21 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t19, i32 0, i32 1
  store i64 1, i64* %t21
  ret { %NativeInstruction*, i64 }* %t19
merge1:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = call i8* @sailfin_runtime_substring(i8* %t22, i64 0, i64 %t24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 2 to double
  %t30 = fadd double %t28, %t29
  %t31 = load i8*, i8** %l0
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = fptosi double %t30 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %t27, i64 %t33, i64 %t32)
  %t35 = call i8* @trim_text(i8* %t34)
  %t36 = call i8* @trim_trailing_delimiters(i8* %t35)
  store i8* %t36, i8** %l3
  %t37 = load i8*, i8** %l2
  %t38 = call %CaseComponents @split_case_components(i8* %t37)
  store %CaseComponents %t38, %CaseComponents* %l4
  %t39 = alloca [0 x %NativeInstruction]
  %t40 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* %t39, i32 0, i32 0
  %t41 = alloca { %NativeInstruction*, i64 }
  %t42 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t41, i32 0, i32 0
  store %NativeInstruction* %t40, %NativeInstruction** %t42
  %t43 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t41, i32 0, i32 1
  store i64 0, i64* %t43
  store { %NativeInstruction*, i64 }* %t41, { %NativeInstruction*, i64 }** %l5
  %t44 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t45 = alloca %NativeInstruction
  %t46 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t45, i32 0, i32 0
  store i32 13, i32* %t46
  %t47 = load %CaseComponents, %CaseComponents* %l4
  %t48 = extractvalue %CaseComponents %t47, 0
  %t49 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t45, i32 0, i32 1
  %t50 = bitcast [16 x i8]* %t49 to i8*
  %t51 = bitcast i8* %t50 to i8**
  store i8* %t48, i8** %t51
  %t52 = load %CaseComponents, %CaseComponents* %l4
  %t53 = extractvalue %CaseComponents %t52, 1
  %t54 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t45, i32 0, i32 1
  %t55 = bitcast [16 x i8]* %t54 to i8*
  %t56 = getelementptr inbounds i8, i8* %t55, i64 8
  %t57 = bitcast i8* %t56 to i8**
  store i8* %t53, i8** %t57
  %t58 = load %NativeInstruction, %NativeInstruction* %t45
  %t59 = alloca [1 x %NativeInstruction]
  %t60 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t59, i32 0, i32 0
  %t61 = getelementptr %NativeInstruction, %NativeInstruction* %t60, i64 0
  store %NativeInstruction %t58, %NativeInstruction* %t61
  %t62 = alloca { %NativeInstruction*, i64 }
  %t63 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t62, i32 0, i32 0
  store %NativeInstruction* %t60, %NativeInstruction** %t63
  %t64 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t62, i32 0, i32 1
  store i64 1, i64* %t64
  %t65 = bitcast { %NativeInstruction*, i64 }* %t44 to { i8**, i64 }*
  %t66 = bitcast { %NativeInstruction*, i64 }* %t62 to { i8**, i64 }*
  %t67 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t65, { i8**, i64 }* %t66)
  %t68 = bitcast { i8**, i64 }* %t67 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t68, { %NativeInstruction*, i64 }** %l5
  %t69 = load i8*, i8** %l3
  %t70 = call i64 @sailfin_runtime_string_length(i8* %t69)
  %t71 = icmp eq i64 %t70, 0
  %t72 = load i8*, i8** %l0
  %t73 = load double, double* %l1
  %t74 = load i8*, i8** %l2
  %t75 = load i8*, i8** %l3
  %t76 = load %CaseComponents, %CaseComponents* %l4
  %t77 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t71, label %then2, label %merge3
then2:
  %t78 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t79 = insertvalue %NativeInstruction undef, i32 15, 0
  %t80 = alloca [1 x %NativeInstruction]
  %t81 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t80, i32 0, i32 0
  %t82 = getelementptr %NativeInstruction, %NativeInstruction* %t81, i64 0
  store %NativeInstruction %t79, %NativeInstruction* %t82
  %t83 = alloca { %NativeInstruction*, i64 }
  %t84 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t83, i32 0, i32 0
  store %NativeInstruction* %t81, %NativeInstruction** %t84
  %t85 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t83, i32 0, i32 1
  store i64 1, i64* %t85
  %t86 = bitcast { %NativeInstruction*, i64 }* %t78 to { i8**, i64 }*
  %t87 = bitcast { %NativeInstruction*, i64 }* %t83 to { i8**, i64 }*
  %t88 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t86, { i8**, i64 }* %t87)
  %t89 = bitcast { i8**, i64 }* %t88 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t89, { %NativeInstruction*, i64 }** %l5
  %t90 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t90
merge3:
  %t91 = load i8*, i8** %l3
  %t92 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t91)
  store %NativeInstruction %t92, %NativeInstruction* %l6
  %t93 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t94 = load %NativeInstruction, %NativeInstruction* %l6
  %t95 = alloca [1 x %NativeInstruction]
  %t96 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t95, i32 0, i32 0
  %t97 = getelementptr %NativeInstruction, %NativeInstruction* %t96, i64 0
  store %NativeInstruction %t94, %NativeInstruction* %t97
  %t98 = alloca { %NativeInstruction*, i64 }
  %t99 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t98, i32 0, i32 0
  store %NativeInstruction* %t96, %NativeInstruction** %t99
  %t100 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t98, i32 0, i32 1
  store i64 1, i64* %t100
  %t101 = bitcast { %NativeInstruction*, i64 }* %t93 to { i8**, i64 }*
  %t102 = bitcast { %NativeInstruction*, i64 }* %t98 to { i8**, i64 }*
  %t103 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t101, { i8**, i64 }* %t102)
  %t104 = bitcast { i8**, i64 }* %t103 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t104, { %NativeInstruction*, i64 }** %l5
  %t105 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t105
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
  %t16 = bitcast i8* null to %NativeSourceSpan*
  %t17 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t18 = bitcast [16 x i8]* %t17 to i8*
  %t19 = getelementptr inbounds i8, i8* %t18, i64 8
  %t20 = bitcast i8* %t19 to %NativeSourceSpan**
  store %NativeSourceSpan* %t16, %NativeSourceSpan** %t20
  %t21 = load %NativeInstruction, %NativeInstruction* %t10
  ret %NativeInstruction %t21
merge1:
  %t22 = load i8*, i8** %l0
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @starts_with(i8* %t22, i8* %s23)
  %t25 = load i8*, i8** %l0
  br i1 %t24, label %then2, label %merge3
then2:
  %t26 = alloca %NativeInstruction
  %t27 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 0
  store i32 1, i32* %t27
  %t28 = load i8*, i8** %l0
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.29, i32 0, i32 0
  %t30 = call i8* @strip_prefix(i8* %t28, i8* %s29)
  %t31 = call i8* @trim_text(i8* %t30)
  %t32 = call i8* @trim_trailing_delimiters(i8* %t31)
  %t33 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 1
  %t34 = bitcast [16 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to i8**
  store i8* %t32, i8** %t35
  %t36 = bitcast i8* null to %NativeSourceSpan*
  %t37 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 1
  %t38 = bitcast [16 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 8
  %t40 = bitcast i8* %t39 to %NativeSourceSpan**
  store %NativeSourceSpan* %t36, %NativeSourceSpan** %t40
  %t41 = load %NativeInstruction, %NativeInstruction* %t26
  ret %NativeInstruction %t41
merge3:
  %t42 = alloca %NativeInstruction
  %t43 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 0
  store i32 1, i32* %t43
  %t44 = load i8*, i8** %l0
  %t45 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 1
  %t46 = bitcast [16 x i8]* %t45 to i8*
  %t47 = bitcast i8* %t46 to i8**
  store i8* %t44, i8** %t47
  %t48 = bitcast i8* null to %NativeSourceSpan*
  %t49 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 1
  %t50 = bitcast [16 x i8]* %t49 to i8*
  %t51 = getelementptr inbounds i8, i8* %t50, i64 8
  %t52 = bitcast i8* %t51 to %NativeSourceSpan**
  store %NativeSourceSpan* %t48, %NativeSourceSpan** %t52
  %t53 = load %NativeInstruction, %NativeInstruction* %t42
  ret %NativeInstruction %t53
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
  %l21 = alloca double
  %l22 = alloca %InstructionParseResult
  %l23 = alloca double
  %l24 = alloca i8*
  %l25 = alloca %StructLayoutHeaderParse
  %l26 = alloca %StructLayoutFieldParse
  %l27 = alloca double
  %l28 = alloca i8*
  %l29 = alloca i8*
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
  %t1008 = phi { i8**, i64 }* [ %t60, %entry ], [ %t997, %loop.latch4 ]
  %t1009 = phi double [ %t76, %entry ], [ %t998, %loop.latch4 ]
  %t1010 = phi { %NativeFunction*, i64 }* [ %t67, %entry ], [ %t999, %loop.latch4 ]
  %t1011 = phi i8* [ %t68, %entry ], [ %t1000, %loop.latch4 ]
  %t1012 = phi i8* [ %t69, %entry ], [ %t1001, %loop.latch4 ]
  %t1013 = phi i8* [ %t70, %entry ], [ %t1002, %loop.latch4 ]
  %t1014 = phi double [ %t72, %entry ], [ %t1003, %loop.latch4 ]
  %t1015 = phi double [ %t73, %entry ], [ %t1004, %loop.latch4 ]
  %t1016 = phi i1 [ %t74, %entry ], [ %t1005, %loop.latch4 ]
  %t1017 = phi { %NativeStructLayoutField*, i64 }* [ %t71, %entry ], [ %t1006, %loop.latch4 ]
  %t1018 = phi i1 [ %t75, %entry ], [ %t1007, %loop.latch4 ]
  store { i8**, i64 }* %t1008, { i8**, i64 }** %l0
  store double %t1009, double* %l16
  store { %NativeFunction*, i64 }* %t1010, { %NativeFunction*, i64 }** %l7
  store i8* %t1011, i8** %l8
  store i8* %t1012, i8** %l9
  store i8* %t1013, i8** %l10
  store double %t1014, double* %l12
  store double %t1015, double* %l13
  store i1 %t1016, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1017, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1018, i1* %l15
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
  %t128 = bitcast { %NativeStructLayoutField*, i64 }* %t127 to { %NativeStructLayoutField**, i64 }*
  %t129 = insertvalue %NativeStructLayout %t126, { %NativeStructLayoutField**, i64 }* %t128, 2
  store i8* null, i8** %l17
  br label %merge9
merge9:
  %t130 = phi i8* [ null, %then8 ], [ %t122, %then6 ]
  store i8* %t130, i8** %l17
  %t131 = load i8*, i8** %l4
  %t132 = insertvalue %NativeStruct undef, i8* %t131, 0
  %t133 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t134 = bitcast { %NativeStructField*, i64 }* %t133 to { %NativeStructField**, i64 }*
  %t135 = insertvalue %NativeStruct %t132, { %NativeStructField**, i64 }* %t134, 1
  %t136 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t137 = bitcast { %NativeFunction*, i64 }* %t136 to { %NativeFunction**, i64 }*
  %t138 = insertvalue %NativeStruct %t135, { %NativeFunction**, i64 }* %t137, 2
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t140 = insertvalue %NativeStruct %t138, { i8**, i64 }* %t139, 3
  %t141 = load i8*, i8** %l17
  %t142 = bitcast i8* %t141 to %NativeStructLayout*
  %t143 = insertvalue %NativeStruct %t140, %NativeStructLayout* %t142, 4
  %t144 = insertvalue %StructParseResult undef, %NativeStruct* null, 0
  %t145 = load double, double* %l16
  %t146 = insertvalue %StructParseResult %t144, double %t145, 1
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = insertvalue %StructParseResult %t146, { i8**, i64 }* %t147, 2
  ret %StructParseResult %t148
merge7:
  %t149 = load double, double* %l16
  %t150 = fptosi double %t149 to i64
  %t151 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t152 = extractvalue { i8**, i64 } %t151, 0
  %t153 = extractvalue { i8**, i64 } %t151, 1
  %t154 = icmp uge i64 %t150, %t153
  ; bounds check: %t154 (if true, out of bounds)
  %t155 = getelementptr i8*, i8** %t152, i64 %t150
  %t156 = load i8*, i8** %t155
  %t157 = call i8* @trim_text(i8* %t156)
  store i8* %t157, i8** %l18
  %t159 = load i8*, i8** %l18
  %t160 = call i64 @sailfin_runtime_string_length(i8* %t159)
  %t161 = icmp eq i64 %t160, 0
  br label %logical_or_entry_158

logical_or_entry_158:
  br i1 %t161, label %logical_or_merge_158, label %logical_or_right_158

logical_or_right_158:
  %t162 = load i8*, i8** %l18
  %t163 = alloca [2 x i8], align 1
  %t164 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 0
  store i8 59, i8* %t164
  %t165 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 1
  store i8 0, i8* %t165
  %t166 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 0
  %t167 = call i1 @starts_with(i8* %t162, i8* %t166)
  br label %logical_or_right_end_158

logical_or_right_end_158:
  br label %logical_or_merge_158

logical_or_merge_158:
  %t168 = phi i1 [ true, %logical_or_entry_158 ], [ %t167, %logical_or_right_end_158 ]
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load i8*, i8** %l1
  %t171 = load i8*, i8** %l2
  %t172 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t173 = load i8*, i8** %l4
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t175 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t176 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t177 = load i8*, i8** %l8
  %t178 = load i8*, i8** %l9
  %t179 = load i8*, i8** %l10
  %t180 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t181 = load double, double* %l12
  %t182 = load double, double* %l13
  %t183 = load i1, i1* %l14
  %t184 = load i1, i1* %l15
  %t185 = load double, double* %l16
  %t186 = load i8*, i8** %l18
  br i1 %t168, label %then10, label %merge11
then10:
  %t187 = load double, double* %l16
  %t188 = sitofp i64 1 to double
  %t189 = fadd double %t187, %t188
  store double %t189, double* %l16
  br label %loop.latch4
merge11:
  %t190 = load i8*, i8** %l18
  %s191 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.191, i32 0, i32 0
  %t192 = icmp eq i8* %t190, %s191
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t194 = load i8*, i8** %l1
  %t195 = load i8*, i8** %l2
  %t196 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t197 = load i8*, i8** %l4
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t199 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t200 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t201 = load i8*, i8** %l8
  %t202 = load i8*, i8** %l9
  %t203 = load i8*, i8** %l10
  %t204 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t205 = load double, double* %l12
  %t206 = load double, double* %l13
  %t207 = load i1, i1* %l14
  %t208 = load i1, i1* %l15
  %t209 = load double, double* %l16
  %t210 = load i8*, i8** %l18
  br i1 %t192, label %then12, label %merge13
then12:
  %t211 = load i8*, i8** %l8
  %t212 = icmp ne i8* %t211, null
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load i8*, i8** %l1
  %t215 = load i8*, i8** %l2
  %t216 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t217 = load i8*, i8** %l4
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t219 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t220 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t221 = load i8*, i8** %l8
  %t222 = load i8*, i8** %l9
  %t223 = load i8*, i8** %l10
  %t224 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t225 = load double, double* %l12
  %t226 = load double, double* %l13
  %t227 = load i1, i1* %l14
  %t228 = load i1, i1* %l15
  %t229 = load double, double* %l16
  %t230 = load i8*, i8** %l18
  br i1 %t212, label %then14, label %merge15
then14:
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s232 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.232, i32 0, i32 0
  %t233 = load i8*, i8** %l4
  %t234 = add i8* %s232, %t233
  %t235 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t231, i8* %t234)
  store { i8**, i64 }* %t235, { i8**, i64 }** %l0
  %t236 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t237 = load i8*, i8** %l8
  %t238 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t236, i8* null)
  store { %NativeFunction*, i64 }* %t238, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  br label %merge15
merge15:
  %t239 = phi { i8**, i64 }* [ %t235, %then14 ], [ %t213, %then12 ]
  %t240 = phi { %NativeFunction*, i64 }* [ %t238, %then14 ], [ %t220, %then12 ]
  %t241 = phi i8* [ null, %then14 ], [ %t221, %then12 ]
  %t242 = phi i8* [ null, %then14 ], [ %t222, %then12 ]
  %t243 = phi i8* [ null, %then14 ], [ %t223, %then12 ]
  store { i8**, i64 }* %t239, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t240, { %NativeFunction*, i64 }** %l7
  store i8* %t241, i8** %l8
  store i8* %t242, i8** %l9
  store i8* %t243, i8** %l10
  %t244 = load double, double* %l16
  %t245 = sitofp i64 1 to double
  %t246 = fadd double %t244, %t245
  store double %t246, double* %l16
  br label %afterloop5
merge13:
  %t247 = load i8*, i8** %l8
  %t248 = icmp ne i8* %t247, null
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = load i8*, i8** %l1
  %t251 = load i8*, i8** %l2
  %t252 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t253 = load i8*, i8** %l4
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t255 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t256 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t257 = load i8*, i8** %l8
  %t258 = load i8*, i8** %l9
  %t259 = load i8*, i8** %l10
  %t260 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t261 = load double, double* %l12
  %t262 = load double, double* %l13
  %t263 = load i1, i1* %l14
  %t264 = load i1, i1* %l15
  %t265 = load double, double* %l16
  %t266 = load i8*, i8** %l18
  br i1 %t248, label %then16, label %merge17
then16:
  %t267 = load i8*, i8** %l18
  %s268 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.268, i32 0, i32 0
  %t269 = icmp eq i8* %t267, %s268
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load i8*, i8** %l1
  %t272 = load i8*, i8** %l2
  %t273 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t274 = load i8*, i8** %l4
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t276 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t277 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t278 = load i8*, i8** %l8
  %t279 = load i8*, i8** %l9
  %t280 = load i8*, i8** %l10
  %t281 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t282 = load double, double* %l12
  %t283 = load double, double* %l13
  %t284 = load i1, i1* %l14
  %t285 = load i1, i1* %l15
  %t286 = load double, double* %l16
  %t287 = load i8*, i8** %l18
  br i1 %t269, label %then18, label %merge19
then18:
  %t288 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t289 = load i8*, i8** %l8
  %t290 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t288, i8* null)
  store { %NativeFunction*, i64 }* %t290, { %NativeFunction*, i64 }** %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t291 = load double, double* %l16
  %t292 = sitofp i64 1 to double
  %t293 = fadd double %t291, %t292
  store double %t293, double* %l16
  br label %loop.latch4
merge19:
  %t294 = load i8*, i8** %l18
  %s295 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.295, i32 0, i32 0
  %t296 = call i1 @starts_with(i8* %t294, i8* %s295)
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load i8*, i8** %l1
  %t299 = load i8*, i8** %l2
  %t300 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t301 = load i8*, i8** %l4
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t303 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t304 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t305 = load i8*, i8** %l8
  %t306 = load i8*, i8** %l9
  %t307 = load i8*, i8** %l10
  %t308 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t309 = load double, double* %l12
  %t310 = load double, double* %l13
  %t311 = load i1, i1* %l14
  %t312 = load i1, i1* %l15
  %t313 = load double, double* %l16
  %t314 = load i8*, i8** %l18
  br i1 %t296, label %then20, label %merge21
then20:
  %t315 = load i8*, i8** %l8
  %t316 = load i8*, i8** %l18
  %s317 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.317, i32 0, i32 0
  %t318 = call i8* @strip_prefix(i8* %t316, i8* %s317)
  %t319 = call %NativeFunction @apply_meta(i8* null, i8* %t318)
  store i8* null, i8** %l8
  %t320 = load double, double* %l16
  %t321 = sitofp i64 1 to double
  %t322 = fadd double %t320, %t321
  store double %t322, double* %l16
  br label %loop.latch4
merge21:
  %t323 = load i8*, i8** %l18
  %s324 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.324, i32 0, i32 0
  %t325 = call i1 @starts_with(i8* %t323, i8* %s324)
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load i8*, i8** %l1
  %t328 = load i8*, i8** %l2
  %t329 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t330 = load i8*, i8** %l4
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t332 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t333 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t334 = load i8*, i8** %l8
  %t335 = load i8*, i8** %l9
  %t336 = load i8*, i8** %l10
  %t337 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t338 = load double, double* %l12
  %t339 = load double, double* %l13
  %t340 = load i1, i1* %l14
  %t341 = load i1, i1* %l15
  %t342 = load double, double* %l16
  %t343 = load i8*, i8** %l18
  br i1 %t325, label %then22, label %merge23
then22:
  %t344 = load i8*, i8** %l18
  %s345 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.345, i32 0, i32 0
  %t346 = call i8* @strip_prefix(i8* %t344, i8* %s345)
  %t347 = load i8*, i8** %l9
  %t348 = call double @parse_parameter_entry(i8* %t346, i8* %t347)
  store double %t348, double* %l19
  %t349 = load double, double* %l19
  store i8* null, i8** %l9
  %t350 = load double, double* %l16
  %t351 = sitofp i64 1 to double
  %t352 = fadd double %t350, %t351
  store double %t352, double* %l16
  br label %loop.latch4
merge23:
  %t353 = load i8*, i8** %l18
  %s354 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.354, i32 0, i32 0
  %t355 = call i1 @starts_with(i8* %t353, i8* %s354)
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t357 = load i8*, i8** %l1
  %t358 = load i8*, i8** %l2
  %t359 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t360 = load i8*, i8** %l4
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t362 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t363 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t364 = load i8*, i8** %l8
  %t365 = load i8*, i8** %l9
  %t366 = load i8*, i8** %l10
  %t367 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t368 = load double, double* %l12
  %t369 = load double, double* %l13
  %t370 = load i1, i1* %l14
  %t371 = load i1, i1* %l15
  %t372 = load double, double* %l16
  %t373 = load i8*, i8** %l18
  br i1 %t355, label %then24, label %merge25
then24:
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s375 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.375, i32 0, i32 0
  %t376 = load i8*, i8** %l4
  %t377 = add i8* %s375, %t376
  %t378 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t374, i8* %t377)
  store { i8**, i64 }* %t378, { i8**, i64 }** %l0
  %t379 = load double, double* %l16
  %t380 = sitofp i64 1 to double
  %t381 = fadd double %t379, %t380
  store double %t381, double* %l16
  br label %loop.latch4
merge25:
  %t382 = load i8*, i8** %l18
  %s383 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.383, i32 0, i32 0
  %t384 = call i1 @starts_with(i8* %t382, i8* %s383)
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t386 = load i8*, i8** %l1
  %t387 = load i8*, i8** %l2
  %t388 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t389 = load i8*, i8** %l4
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t391 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t392 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t393 = load i8*, i8** %l8
  %t394 = load i8*, i8** %l9
  %t395 = load i8*, i8** %l10
  %t396 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t397 = load double, double* %l12
  %t398 = load double, double* %l13
  %t399 = load i1, i1* %l14
  %t400 = load i1, i1* %l15
  %t401 = load double, double* %l16
  %t402 = load i8*, i8** %l18
  br i1 %t384, label %then26, label %merge27
then26:
  %t403 = load i8*, i8** %l18
  %s404 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.404, i32 0, i32 0
  %t405 = call i8* @strip_prefix(i8* %t403, i8* %s404)
  %t406 = call double @parse_source_span(i8* %t405)
  store double %t406, double* %l20
  %t407 = load double, double* %l20
  %t408 = load double, double* %l16
  %t409 = sitofp i64 1 to double
  %t410 = fadd double %t408, %t409
  store double %t410, double* %l16
  br label %loop.latch4
merge27:
  %t411 = load i8*, i8** %l18
  %s412 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.412, i32 0, i32 0
  %t413 = call i1 @starts_with(i8* %t411, i8* %s412)
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t415 = load i8*, i8** %l1
  %t416 = load i8*, i8** %l2
  %t417 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t418 = load i8*, i8** %l4
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t420 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t421 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t422 = load i8*, i8** %l8
  %t423 = load i8*, i8** %l9
  %t424 = load i8*, i8** %l10
  %t425 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t426 = load double, double* %l12
  %t427 = load double, double* %l13
  %t428 = load i1, i1* %l14
  %t429 = load i1, i1* %l15
  %t430 = load double, double* %l16
  %t431 = load i8*, i8** %l18
  br i1 %t413, label %then28, label %merge29
then28:
  %t432 = load i8*, i8** %l18
  %s433 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.433, i32 0, i32 0
  %t434 = call i8* @strip_prefix(i8* %t432, i8* %s433)
  %t435 = call double @parse_source_span(i8* %t434)
  store double %t435, double* %l21
  %t436 = load double, double* %l21
  %t437 = load double, double* %l16
  %t438 = sitofp i64 1 to double
  %t439 = fadd double %t437, %t438
  store double %t439, double* %l16
  br label %loop.latch4
merge29:
  %t440 = load i8*, i8** %l18
  %t441 = load i8*, i8** %l9
  %t442 = load i8*, i8** %l10
  %t443 = call %InstructionParseResult @parse_instruction(i8* %t440, i8* %t441, i8* %t442)
  store %InstructionParseResult %t443, %InstructionParseResult* %l22
  %t444 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t445 = extractvalue %InstructionParseResult %t444, 1
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t447 = load i8*, i8** %l1
  %t448 = load i8*, i8** %l2
  %t449 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t450 = load i8*, i8** %l4
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t452 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t453 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t454 = load i8*, i8** %l8
  %t455 = load i8*, i8** %l9
  %t456 = load i8*, i8** %l10
  %t457 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t458 = load double, double* %l12
  %t459 = load double, double* %l13
  %t460 = load i1, i1* %l14
  %t461 = load i1, i1* %l15
  %t462 = load double, double* %l16
  %t463 = load i8*, i8** %l18
  %t464 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t445, label %then30, label %else31
then30:
  store i8* null, i8** %l9
  br label %merge32
else31:
  %t465 = load i8*, i8** %l9
  %t466 = icmp ne i8* %t465, null
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t468 = load i8*, i8** %l1
  %t469 = load i8*, i8** %l2
  %t470 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t471 = load i8*, i8** %l4
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t473 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t474 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t475 = load i8*, i8** %l8
  %t476 = load i8*, i8** %l9
  %t477 = load i8*, i8** %l10
  %t478 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t479 = load double, double* %l12
  %t480 = load double, double* %l13
  %t481 = load i1, i1* %l14
  %t482 = load i1, i1* %l15
  %t483 = load double, double* %l16
  %t484 = load i8*, i8** %l18
  %t485 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t466, label %then33, label %merge34
then33:
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s487 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.487, i32 0, i32 0
  %t488 = load i8*, i8** %l18
  %t489 = add i8* %s487, %t488
  %t490 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t486, i8* %t489)
  store { i8**, i64 }* %t490, { i8**, i64 }** %l0
  store i8* null, i8** %l9
  br label %merge34
merge34:
  %t491 = phi { i8**, i64 }* [ %t490, %then33 ], [ %t467, %else31 ]
  %t492 = phi i8* [ null, %then33 ], [ %t476, %else31 ]
  store { i8**, i64 }* %t491, { i8**, i64 }** %l0
  store i8* %t492, i8** %l9
  br label %merge32
merge32:
  %t493 = phi i8* [ null, %then30 ], [ null, %else31 ]
  %t494 = phi { i8**, i64 }* [ %t446, %then30 ], [ %t490, %else31 ]
  store i8* %t493, i8** %l9
  store { i8**, i64 }* %t494, { i8**, i64 }** %l0
  %t495 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t496 = extractvalue %InstructionParseResult %t495, 2
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t498 = load i8*, i8** %l1
  %t499 = load i8*, i8** %l2
  %t500 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t501 = load i8*, i8** %l4
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t503 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t504 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t505 = load i8*, i8** %l8
  %t506 = load i8*, i8** %l9
  %t507 = load i8*, i8** %l10
  %t508 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t509 = load double, double* %l12
  %t510 = load double, double* %l13
  %t511 = load i1, i1* %l14
  %t512 = load i1, i1* %l15
  %t513 = load double, double* %l16
  %t514 = load i8*, i8** %l18
  %t515 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t496, label %then35, label %else36
then35:
  store i8* null, i8** %l10
  br label %merge37
else36:
  %t516 = load i8*, i8** %l10
  %t517 = icmp ne i8* %t516, null
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
  %t536 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t517, label %then38, label %merge39
then38:
  %t537 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s538 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.538, i32 0, i32 0
  %t539 = load i8*, i8** %l18
  %t540 = add i8* %s538, %t539
  %t541 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t537, i8* %t540)
  store { i8**, i64 }* %t541, { i8**, i64 }** %l0
  store i8* null, i8** %l10
  br label %merge39
merge39:
  %t542 = phi { i8**, i64 }* [ %t541, %then38 ], [ %t518, %else36 ]
  %t543 = phi i8* [ null, %then38 ], [ %t528, %else36 ]
  store { i8**, i64 }* %t542, { i8**, i64 }** %l0
  store i8* %t543, i8** %l10
  br label %merge37
merge37:
  %t544 = phi i8* [ null, %then35 ], [ null, %else36 ]
  %t545 = phi { i8**, i64 }* [ %t497, %then35 ], [ %t541, %else36 ]
  store i8* %t544, i8** %l10
  store { i8**, i64 }* %t545, { i8**, i64 }** %l0
  %t546 = sitofp i64 0 to double
  store double %t546, double* %l23
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t548 = load i8*, i8** %l1
  %t549 = load i8*, i8** %l2
  %t550 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t551 = load i8*, i8** %l4
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t553 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t554 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t555 = load i8*, i8** %l8
  %t556 = load i8*, i8** %l9
  %t557 = load i8*, i8** %l10
  %t558 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t559 = load double, double* %l12
  %t560 = load double, double* %l13
  %t561 = load i1, i1* %l14
  %t562 = load i1, i1* %l15
  %t563 = load double, double* %l16
  %t564 = load i8*, i8** %l18
  %t565 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t566 = load double, double* %l23
  br label %loop.header40
loop.header40:
  %t612 = phi i8* [ %t555, %then16 ], [ %t610, %loop.latch42 ]
  %t613 = phi double [ %t566, %then16 ], [ %t611, %loop.latch42 ]
  store i8* %t612, i8** %l8
  store double %t613, double* %l23
  br label %loop.body41
loop.body41:
  %t567 = load double, double* %l23
  %t568 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t569 = extractvalue %InstructionParseResult %t568, 0
  %t570 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t569
  %t571 = extractvalue { %NativeInstruction**, i64 } %t570, 1
  %t572 = sitofp i64 %t571 to double
  %t573 = fcmp oge double %t567, %t572
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t575 = load i8*, i8** %l1
  %t576 = load i8*, i8** %l2
  %t577 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t578 = load i8*, i8** %l4
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t580 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t581 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t582 = load i8*, i8** %l8
  %t583 = load i8*, i8** %l9
  %t584 = load i8*, i8** %l10
  %t585 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t586 = load double, double* %l12
  %t587 = load double, double* %l13
  %t588 = load i1, i1* %l14
  %t589 = load i1, i1* %l15
  %t590 = load double, double* %l16
  %t591 = load i8*, i8** %l18
  %t592 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t593 = load double, double* %l23
  br i1 %t573, label %then44, label %merge45
then44:
  br label %afterloop43
merge45:
  %t594 = load i8*, i8** %l8
  %t595 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t596 = extractvalue %InstructionParseResult %t595, 0
  %t597 = load double, double* %l23
  %t598 = fptosi double %t597 to i64
  %t599 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t596
  %t600 = extractvalue { %NativeInstruction**, i64 } %t599, 0
  %t601 = extractvalue { %NativeInstruction**, i64 } %t599, 1
  %t602 = icmp uge i64 %t598, %t601
  ; bounds check: %t602 (if true, out of bounds)
  %t603 = getelementptr %NativeInstruction*, %NativeInstruction** %t600, i64 %t598
  %t604 = load %NativeInstruction*, %NativeInstruction** %t603
  %t605 = load %NativeInstruction, %NativeInstruction* %t604
  %t606 = call %NativeFunction @append_instruction(i8* null, %NativeInstruction %t605)
  store i8* null, i8** %l8
  %t607 = load double, double* %l23
  %t608 = sitofp i64 1 to double
  %t609 = fadd double %t607, %t608
  store double %t609, double* %l23
  br label %loop.latch42
loop.latch42:
  %t610 = load i8*, i8** %l8
  %t611 = load double, double* %l23
  br label %loop.header40
afterloop43:
  %t614 = load double, double* %l16
  %t615 = sitofp i64 1 to double
  %t616 = fadd double %t614, %t615
  store double %t616, double* %l16
  br label %loop.latch4
merge17:
  %t617 = load i8*, i8** %l18
  %s618 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.618, i32 0, i32 0
  %t619 = call i1 @starts_with(i8* %t617, i8* %s618)
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t621 = load i8*, i8** %l1
  %t622 = load i8*, i8** %l2
  %t623 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t624 = load i8*, i8** %l4
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t626 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t627 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t628 = load i8*, i8** %l8
  %t629 = load i8*, i8** %l9
  %t630 = load i8*, i8** %l10
  %t631 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t632 = load double, double* %l12
  %t633 = load double, double* %l13
  %t634 = load i1, i1* %l14
  %t635 = load i1, i1* %l15
  %t636 = load double, double* %l16
  %t637 = load i8*, i8** %l18
  br i1 %t619, label %then46, label %merge47
then46:
  %t638 = load i8*, i8** %l18
  %s639 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.639, i32 0, i32 0
  %t640 = call i8* @strip_prefix(i8* %t638, i8* %s639)
  store i8* %t640, i8** %l24
  %t641 = load i8*, i8** %l24
  %s642 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.642, i32 0, i32 0
  %t643 = call i1 @starts_with(i8* %t641, i8* %s642)
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t645 = load i8*, i8** %l1
  %t646 = load i8*, i8** %l2
  %t647 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t648 = load i8*, i8** %l4
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t650 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t651 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t652 = load i8*, i8** %l8
  %t653 = load i8*, i8** %l9
  %t654 = load i8*, i8** %l10
  %t655 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t656 = load double, double* %l12
  %t657 = load double, double* %l13
  %t658 = load i1, i1* %l14
  %t659 = load i1, i1* %l15
  %t660 = load double, double* %l16
  %t661 = load i8*, i8** %l18
  %t662 = load i8*, i8** %l24
  br i1 %t643, label %then48, label %merge49
then48:
  %t663 = load i8*, i8** %l24
  %s664 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.664, i32 0, i32 0
  %t665 = call i8* @strip_prefix(i8* %t663, i8* %s664)
  %t666 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t665)
  store %StructLayoutHeaderParse %t666, %StructLayoutHeaderParse* %l25
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t668 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t669 = extractvalue %StructLayoutHeaderParse %t668, 4
  %t670 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t667, { i8**, i64 }* %t669)
  store { i8**, i64 }* %t670, { i8**, i64 }** %l0
  %t671 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t672 = extractvalue %StructLayoutHeaderParse %t671, 0
  %t673 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t674 = load i8*, i8** %l1
  %t675 = load i8*, i8** %l2
  %t676 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t677 = load i8*, i8** %l4
  %t678 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t679 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t680 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t681 = load i8*, i8** %l8
  %t682 = load i8*, i8** %l9
  %t683 = load i8*, i8** %l10
  %t684 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t685 = load double, double* %l12
  %t686 = load double, double* %l13
  %t687 = load i1, i1* %l14
  %t688 = load i1, i1* %l15
  %t689 = load double, double* %l16
  %t690 = load i8*, i8** %l18
  %t691 = load i8*, i8** %l24
  %t692 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t672, label %then50, label %merge51
then50:
  %t693 = load i1, i1* %l14
  %t694 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t695 = load i8*, i8** %l1
  %t696 = load i8*, i8** %l2
  %t697 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t698 = load i8*, i8** %l4
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t700 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t701 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t702 = load i8*, i8** %l8
  %t703 = load i8*, i8** %l9
  %t704 = load i8*, i8** %l10
  %t705 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t706 = load double, double* %l12
  %t707 = load double, double* %l13
  %t708 = load i1, i1* %l14
  %t709 = load i1, i1* %l15
  %t710 = load double, double* %l16
  %t711 = load i8*, i8** %l18
  %t712 = load i8*, i8** %l24
  %t713 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t693, label %then52, label %else53
then52:
  %t714 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s715 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.715, i32 0, i32 0
  %t716 = load i8*, i8** %l4
  %t717 = add i8* %s715, %t716
  %t718 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t714, i8* %t717)
  store { i8**, i64 }* %t718, { i8**, i64 }** %l0
  br label %merge54
else53:
  %t719 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t720 = extractvalue %StructLayoutHeaderParse %t719, 2
  store double %t720, double* %l12
  %t721 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t722 = extractvalue %StructLayoutHeaderParse %t721, 3
  store double %t722, double* %l13
  store i1 1, i1* %l14
  br label %merge54
merge54:
  %t723 = phi { i8**, i64 }* [ %t718, %then52 ], [ %t694, %else53 ]
  %t724 = phi double [ %t706, %then52 ], [ %t720, %else53 ]
  %t725 = phi double [ %t707, %then52 ], [ %t722, %else53 ]
  %t726 = phi i1 [ %t708, %then52 ], [ 1, %else53 ]
  store { i8**, i64 }* %t723, { i8**, i64 }** %l0
  store double %t724, double* %l12
  store double %t725, double* %l13
  store i1 %t726, i1* %l14
  br label %merge51
merge51:
  %t727 = phi { i8**, i64 }* [ %t718, %then50 ], [ %t673, %then48 ]
  %t728 = phi double [ %t720, %then50 ], [ %t685, %then48 ]
  %t729 = phi double [ %t722, %then50 ], [ %t686, %then48 ]
  %t730 = phi i1 [ 1, %then50 ], [ %t687, %then48 ]
  store { i8**, i64 }* %t727, { i8**, i64 }** %l0
  store double %t728, double* %l12
  store double %t729, double* %l13
  store i1 %t730, i1* %l14
  %t731 = load double, double* %l16
  %t732 = sitofp i64 1 to double
  %t733 = fadd double %t731, %t732
  store double %t733, double* %l16
  br label %loop.latch4
merge49:
  %t734 = load i8*, i8** %l24
  %s735 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.735, i32 0, i32 0
  %t736 = call i1 @starts_with(i8* %t734, i8* %s735)
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
  %t755 = load i8*, i8** %l24
  br i1 %t736, label %then55, label %merge56
then55:
  %t756 = load i8*, i8** %l24
  %s757 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.757, i32 0, i32 0
  %t758 = call i8* @strip_prefix(i8* %t756, i8* %s757)
  %t759 = load i8*, i8** %l4
  %t760 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t758, i8* %t759)
  store %StructLayoutFieldParse %t760, %StructLayoutFieldParse* %l26
  %t761 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t762 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t763 = extractvalue %StructLayoutFieldParse %t762, 2
  %t764 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t761, { i8**, i64 }* %t763)
  store { i8**, i64 }* %t764, { i8**, i64 }** %l0
  %t765 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t766 = extractvalue %StructLayoutFieldParse %t765, 0
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t768 = load i8*, i8** %l1
  %t769 = load i8*, i8** %l2
  %t770 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t771 = load i8*, i8** %l4
  %t772 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t773 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t774 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t775 = load i8*, i8** %l8
  %t776 = load i8*, i8** %l9
  %t777 = load i8*, i8** %l10
  %t778 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t779 = load double, double* %l12
  %t780 = load double, double* %l13
  %t781 = load i1, i1* %l14
  %t782 = load i1, i1* %l15
  %t783 = load double, double* %l16
  %t784 = load i8*, i8** %l18
  %t785 = load i8*, i8** %l24
  %t786 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t766, label %then57, label %merge58
then57:
  %t787 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t788 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t789 = extractvalue %StructLayoutFieldParse %t788, 1
  %t790 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t787, %NativeStructLayoutField %t789)
  store { %NativeStructLayoutField*, i64 }* %t790, { %NativeStructLayoutField*, i64 }** %l11
  %t791 = load i1, i1* %l14
  %t792 = xor i1 %t791, 1
  %t793 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t794 = load i8*, i8** %l1
  %t795 = load i8*, i8** %l2
  %t796 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t797 = load i8*, i8** %l4
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t799 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t800 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t801 = load i8*, i8** %l8
  %t802 = load i8*, i8** %l9
  %t803 = load i8*, i8** %l10
  %t804 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t805 = load double, double* %l12
  %t806 = load double, double* %l13
  %t807 = load i1, i1* %l14
  %t808 = load i1, i1* %l15
  %t809 = load double, double* %l16
  %t810 = load i8*, i8** %l18
  %t811 = load i8*, i8** %l24
  %t812 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t792, label %then59, label %merge60
then59:
  %t813 = load i1, i1* %l15
  %t814 = xor i1 %t813, 1
  %t815 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t816 = load i8*, i8** %l1
  %t817 = load i8*, i8** %l2
  %t818 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t819 = load i8*, i8** %l4
  %t820 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t821 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t822 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t823 = load i8*, i8** %l8
  %t824 = load i8*, i8** %l9
  %t825 = load i8*, i8** %l10
  %t826 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t827 = load double, double* %l12
  %t828 = load double, double* %l13
  %t829 = load i1, i1* %l14
  %t830 = load i1, i1* %l15
  %t831 = load double, double* %l16
  %t832 = load i8*, i8** %l18
  %t833 = load i8*, i8** %l24
  %t834 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t814, label %then61, label %merge62
then61:
  %t835 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s836 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.836, i32 0, i32 0
  %t837 = load i8*, i8** %l4
  %t838 = add i8* %s836, %t837
  %s839 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.839, i32 0, i32 0
  %t840 = add i8* %t838, %s839
  %t841 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t835, i8* %t840)
  store { i8**, i64 }* %t841, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge62
merge62:
  %t842 = phi { i8**, i64 }* [ %t841, %then61 ], [ %t815, %then59 ]
  %t843 = phi i1 [ 1, %then61 ], [ %t830, %then59 ]
  store { i8**, i64 }* %t842, { i8**, i64 }** %l0
  store i1 %t843, i1* %l15
  br label %merge60
merge60:
  %t844 = phi { i8**, i64 }* [ %t841, %then59 ], [ %t793, %then57 ]
  %t845 = phi i1 [ 1, %then59 ], [ %t808, %then57 ]
  store { i8**, i64 }* %t844, { i8**, i64 }** %l0
  store i1 %t845, i1* %l15
  br label %merge58
merge58:
  %t846 = phi { %NativeStructLayoutField*, i64 }* [ %t790, %then57 ], [ %t778, %then55 ]
  %t847 = phi { i8**, i64 }* [ %t841, %then57 ], [ %t767, %then55 ]
  %t848 = phi i1 [ 1, %then57 ], [ %t782, %then55 ]
  store { %NativeStructLayoutField*, i64 }* %t846, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t847, { i8**, i64 }** %l0
  store i1 %t848, i1* %l15
  %t849 = load double, double* %l16
  %t850 = sitofp i64 1 to double
  %t851 = fadd double %t849, %t850
  store double %t851, double* %l16
  br label %loop.latch4
merge56:
  %t852 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s853 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.853, i32 0, i32 0
  %t854 = load i8*, i8** %l18
  %t855 = add i8* %s853, %t854
  %t856 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t852, i8* %t855)
  store { i8**, i64 }* %t856, { i8**, i64 }** %l0
  %t857 = load double, double* %l16
  %t858 = sitofp i64 1 to double
  %t859 = fadd double %t857, %t858
  store double %t859, double* %l16
  br label %loop.latch4
merge47:
  %t860 = load i8*, i8** %l18
  %s861 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.861, i32 0, i32 0
  %t862 = icmp eq i8* %t860, %s861
  %t863 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t864 = load i8*, i8** %l1
  %t865 = load i8*, i8** %l2
  %t866 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t867 = load i8*, i8** %l4
  %t868 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t869 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t870 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t871 = load i8*, i8** %l8
  %t872 = load i8*, i8** %l9
  %t873 = load i8*, i8** %l10
  %t874 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t875 = load double, double* %l12
  %t876 = load double, double* %l13
  %t877 = load i1, i1* %l14
  %t878 = load i1, i1* %l15
  %t879 = load double, double* %l16
  %t880 = load i8*, i8** %l18
  br i1 %t862, label %then63, label %merge64
then63:
  %t881 = load double, double* %l16
  %t882 = sitofp i64 1 to double
  %t883 = fadd double %t881, %t882
  store double %t883, double* %l16
  br label %loop.latch4
merge64:
  %t884 = load i8*, i8** %l18
  %s885 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.885, i32 0, i32 0
  %t886 = call i1 @starts_with(i8* %t884, i8* %s885)
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t888 = load i8*, i8** %l1
  %t889 = load i8*, i8** %l2
  %t890 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t891 = load i8*, i8** %l4
  %t892 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t893 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t894 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t895 = load i8*, i8** %l8
  %t896 = load i8*, i8** %l9
  %t897 = load i8*, i8** %l10
  %t898 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t899 = load double, double* %l12
  %t900 = load double, double* %l13
  %t901 = load i1, i1* %l14
  %t902 = load i1, i1* %l15
  %t903 = load double, double* %l16
  %t904 = load i8*, i8** %l18
  br i1 %t886, label %then65, label %merge66
then65:
  %t905 = load i8*, i8** %l18
  %s906 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.906, i32 0, i32 0
  %t907 = call i8* @strip_prefix(i8* %t905, i8* %s906)
  %t908 = call double @parse_struct_field_line(i8* %t907)
  store double %t908, double* %l27
  %t909 = load double, double* %l27
  %t910 = load double, double* %l16
  %t911 = sitofp i64 1 to double
  %t912 = fadd double %t910, %t911
  store double %t912, double* %l16
  br label %loop.latch4
merge66:
  %t913 = load i8*, i8** %l18
  %s914 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.914, i32 0, i32 0
  %t915 = call i1 @starts_with(i8* %t913, i8* %s914)
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
  %t933 = load i8*, i8** %l18
  br i1 %t915, label %then67, label %merge68
then67:
  %t934 = load i8*, i8** %l8
  %t935 = icmp ne i8* %t934, null
  %t936 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t937 = load i8*, i8** %l1
  %t938 = load i8*, i8** %l2
  %t939 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t940 = load i8*, i8** %l4
  %t941 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t942 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t943 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t944 = load i8*, i8** %l8
  %t945 = load i8*, i8** %l9
  %t946 = load i8*, i8** %l10
  %t947 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t948 = load double, double* %l12
  %t949 = load double, double* %l13
  %t950 = load i1, i1* %l14
  %t951 = load i1, i1* %l15
  %t952 = load double, double* %l16
  %t953 = load i8*, i8** %l18
  br i1 %t935, label %then69, label %merge70
then69:
  %t954 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s955 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.955, i32 0, i32 0
  %t956 = load i8*, i8** %l4
  %t957 = add i8* %s955, %t956
  %t958 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t954, i8* %t957)
  store { i8**, i64 }* %t958, { i8**, i64 }** %l0
  br label %merge70
merge70:
  %t959 = phi { i8**, i64 }* [ %t958, %then69 ], [ %t936, %then67 ]
  store { i8**, i64 }* %t959, { i8**, i64 }** %l0
  %t960 = load i8*, i8** %l18
  %s961 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.961, i32 0, i32 0
  %t962 = call i8* @strip_prefix(i8* %t960, i8* %s961)
  %t963 = call i8* @parse_function_name(i8* %t962)
  store i8* %t963, i8** %l28
  %t964 = load i8*, i8** %l28
  %t965 = insertvalue %NativeFunction undef, i8* %t964, 0
  %t966 = alloca [0 x %NativeParameter*]
  %t967 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t966, i32 0, i32 0
  %t968 = alloca { %NativeParameter**, i64 }
  %t969 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t968, i32 0, i32 0
  store %NativeParameter** %t967, %NativeParameter*** %t969
  %t970 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t968, i32 0, i32 1
  store i64 0, i64* %t970
  %t971 = insertvalue %NativeFunction %t965, { %NativeParameter**, i64 }* %t968, 1
  %s972 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.972, i32 0, i32 0
  %t973 = insertvalue %NativeFunction %t971, i8* %s972, 2
  %t974 = alloca [0 x i8*]
  %t975 = getelementptr [0 x i8*], [0 x i8*]* %t974, i32 0, i32 0
  %t976 = alloca { i8**, i64 }
  %t977 = getelementptr { i8**, i64 }, { i8**, i64 }* %t976, i32 0, i32 0
  store i8** %t975, i8*** %t977
  %t978 = getelementptr { i8**, i64 }, { i8**, i64 }* %t976, i32 0, i32 1
  store i64 0, i64* %t978
  %t979 = insertvalue %NativeFunction %t973, { i8**, i64 }* %t976, 3
  %t980 = alloca [0 x %NativeInstruction*]
  %t981 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* %t980, i32 0, i32 0
  %t982 = alloca { %NativeInstruction**, i64 }
  %t983 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t982, i32 0, i32 0
  store %NativeInstruction** %t981, %NativeInstruction*** %t983
  %t984 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t982, i32 0, i32 1
  store i64 0, i64* %t984
  %t985 = insertvalue %NativeFunction %t979, { %NativeInstruction**, i64 }* %t982, 4
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  store i8* null, i8** %l10
  %t986 = load double, double* %l16
  %t987 = sitofp i64 1 to double
  %t988 = fadd double %t986, %t987
  store double %t988, double* %l16
  br label %loop.latch4
merge68:
  %t989 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s990 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.990, i32 0, i32 0
  %t991 = load i8*, i8** %l18
  %t992 = add i8* %s990, %t991
  %t993 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t989, i8* %t992)
  store { i8**, i64 }* %t993, { i8**, i64 }** %l0
  %t994 = load double, double* %l16
  %t995 = sitofp i64 1 to double
  %t996 = fadd double %t994, %t995
  store double %t996, double* %l16
  br label %loop.latch4
loop.latch4:
  %t997 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t998 = load double, double* %l16
  %t999 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1000 = load i8*, i8** %l8
  %t1001 = load i8*, i8** %l9
  %t1002 = load i8*, i8** %l10
  %t1003 = load double, double* %l12
  %t1004 = load double, double* %l13
  %t1005 = load i1, i1* %l14
  %t1006 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1007 = load i1, i1* %l15
  br label %loop.header2
afterloop5:
  store i8* null, i8** %l29
  %t1019 = load i1, i1* %l14
  %t1020 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1021 = load i8*, i8** %l1
  %t1022 = load i8*, i8** %l2
  %t1023 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1024 = load i8*, i8** %l4
  %t1025 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1026 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1027 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1028 = load i8*, i8** %l8
  %t1029 = load i8*, i8** %l9
  %t1030 = load i8*, i8** %l10
  %t1031 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1032 = load double, double* %l12
  %t1033 = load double, double* %l13
  %t1034 = load i1, i1* %l14
  %t1035 = load i1, i1* %l15
  %t1036 = load double, double* %l16
  %t1037 = load i8*, i8** %l29
  br i1 %t1019, label %then71, label %merge72
then71:
  %t1038 = load double, double* %l12
  %t1039 = insertvalue %NativeStructLayout undef, double %t1038, 0
  %t1040 = load double, double* %l13
  %t1041 = insertvalue %NativeStructLayout %t1039, double %t1040, 1
  %t1042 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1043 = bitcast { %NativeStructLayoutField*, i64 }* %t1042 to { %NativeStructLayoutField**, i64 }*
  %t1044 = insertvalue %NativeStructLayout %t1041, { %NativeStructLayoutField**, i64 }* %t1043, 2
  store i8* null, i8** %l29
  br label %merge72
merge72:
  %t1045 = phi i8* [ null, %then71 ], [ %t1037, %entry ]
  store i8* %t1045, i8** %l29
  %t1046 = load i8*, i8** %l4
  %t1047 = insertvalue %NativeStruct undef, i8* %t1046, 0
  %t1048 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1049 = bitcast { %NativeStructField*, i64 }* %t1048 to { %NativeStructField**, i64 }*
  %t1050 = insertvalue %NativeStruct %t1047, { %NativeStructField**, i64 }* %t1049, 1
  %t1051 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1052 = bitcast { %NativeFunction*, i64 }* %t1051 to { %NativeFunction**, i64 }*
  %t1053 = insertvalue %NativeStruct %t1050, { %NativeFunction**, i64 }* %t1052, 2
  %t1054 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1055 = insertvalue %NativeStruct %t1053, { i8**, i64 }* %t1054, 3
  %t1056 = load i8*, i8** %l29
  %t1057 = bitcast i8* %t1056 to %NativeStructLayout*
  %t1058 = insertvalue %NativeStruct %t1055, %NativeStructLayout* %t1057, 4
  %t1059 = insertvalue %StructParseResult undef, %NativeStruct* null, 0
  %t1060 = load double, double* %l16
  %t1061 = insertvalue %StructParseResult %t1059, double %t1060, 1
  %t1062 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1063 = insertvalue %StructParseResult %t1061, { i8**, i64 }* %t1062, 2
  ret %StructParseResult %t1063
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
  %t200 = phi { i8**, i64 }* [ %t45, %entry ], [ %t197, %loop.latch4 ]
  %t201 = phi double [ %t51, %entry ], [ %t198, %loop.latch4 ]
  %t202 = phi { %NativeInterfaceSignature*, i64 }* [ %t50, %entry ], [ %t199, %loop.latch4 ]
  store { i8**, i64 }* %t200, { i8**, i64 }** %l0
  store double %t201, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t202, { %NativeInterfaceSignature*, i64 }** %l5
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
  %t75 = bitcast { %NativeInterfaceSignature*, i64 }* %t74 to { %NativeInterfaceSignature**, i64 }*
  %t76 = insertvalue %NativeInterface %t73, { %NativeInterfaceSignature**, i64 }* %t75, 2
  %t77 = insertvalue %InterfaceParseResult undef, %NativeInterface* null, 0
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
  %t175 = alloca [1 x %NativeInterfaceSignature]
  %t176 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* %t175, i32 0, i32 0
  %t177 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t176, i64 0
  store %NativeInterfaceSignature %t174, %NativeInterfaceSignature* %t177
  %t178 = alloca { %NativeInterfaceSignature*, i64 }
  %t179 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t178, i32 0, i32 0
  store %NativeInterfaceSignature* %t176, %NativeInterfaceSignature** %t179
  %t180 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t178, i32 0, i32 1
  store i64 1, i64* %t180
  %t181 = bitcast { %NativeInterfaceSignature*, i64 }* %t172 to { i8**, i64 }*
  %t182 = bitcast { %NativeInterfaceSignature*, i64 }* %t178 to { i8**, i64 }*
  %t183 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t181, { i8**, i64 }* %t182)
  %t184 = bitcast { i8**, i64 }* %t183 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t184, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t185 = phi { %NativeInterfaceSignature*, i64 }* [ %t184, %then16 ], [ %t168, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t185, { %NativeInterfaceSignature*, i64 }** %l5
  %t186 = load double, double* %l6
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  store double %t188, double* %l6
  br label %loop.latch4
merge15:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s190 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.190, i32 0, i32 0
  %t191 = load i8*, i8** %l7
  %t192 = add i8* %s190, %t191
  %t193 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t189, i8* %t192)
  store { i8**, i64 }* %t193, { i8**, i64 }** %l0
  %t194 = load double, double* %l6
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l6
  br label %loop.latch4
loop.latch4:
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load double, double* %l6
  %t199 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t203 = load i8*, i8** %l4
  %t204 = insertvalue %NativeInterface undef, i8* %t203, 0
  %t205 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t206 = extractvalue %InterfaceHeaderParse %t205, 1
  %t207 = insertvalue %NativeInterface %t204, { i8**, i64 }* %t206, 1
  %t208 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t209 = bitcast { %NativeInterfaceSignature*, i64 }* %t208 to { %NativeInterfaceSignature**, i64 }*
  %t210 = insertvalue %NativeInterface %t207, { %NativeInterfaceSignature**, i64 }* %t209, 2
  %t211 = insertvalue %InterfaceParseResult undef, %NativeInterface* null, 0
  %t212 = load double, double* %l6
  %t213 = insertvalue %InterfaceParseResult %t211, double %t212, 1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = insertvalue %InterfaceParseResult %t213, { i8**, i64 }* %t214, 2
  ret %InterfaceParseResult %t215
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
  %t56 = load i8, i8* %t55
  %t57 = add i8 %t56, 96
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t57, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t63 = phi { i8**, i64 }* [ %t41, %then2 ], [ %t62, %else3 ]
  %t64 = phi { i8**, i64 }* [ %t43, %then2 ], [ %t21, %else3 ]
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  store { i8**, i64 }* %t64, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t65 = phi { i8**, i64 }* [ %t41, %then0 ], [ %t13, %entry ]
  %t66 = phi { i8**, i64 }* [ %t43, %then0 ], [ %t14, %entry ]
  %t67 = phi { i8**, i64 }* [ %t62, %then0 ], [ %t13, %entry ]
  store { i8**, i64 }* %t65, { i8**, i64 }** %l1
  store { i8**, i64 }* %t66, { i8**, i64 }** %l2
  store { i8**, i64 }* %t67, { i8**, i64 }** %l1
  %t68 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t69 = extractvalue %HeaderNameParse %t68, 0
  %t70 = insertvalue %StructHeaderParse undef, i8* %t69, 0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t72 = insertvalue %StructHeaderParse %t70, { i8**, i64 }* %t71, 1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = insertvalue %StructHeaderParse %t72, { i8**, i64 }* %t73, 2
  ret %StructHeaderParse %t74
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
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t19, 96
  %t21 = alloca [2 x i8], align 1
  %t22 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  store i8 %t20, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 1
  store i8 0, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  %t25 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t26 = phi { i8**, i64 }* [ %t25, %then0 ], [ %t8, %entry ]
  store { i8**, i64 }* %t26, { i8**, i64 }** %l1
  %t27 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t28 = extractvalue %HeaderNameParse %t27, 0
  %t29 = insertvalue %InterfaceHeaderParse undef, i8* %t28, 0
  %t30 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t31 = extractvalue %HeaderNameParse %t30, 1
  %t32 = insertvalue %InterfaceHeaderParse %t29, { i8**, i64 }* %t31, 1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = insertvalue %InterfaceHeaderParse %t32, { i8**, i64 }* %t33, 2
  ret %InterfaceHeaderParse %t34
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
  %l21 = alloca i8*
  %l22 = alloca %NativeInterfaceSignature
  %l23 = alloca i1
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
  %t14 = alloca [0 x %NativeParameter*]
  %t15 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t14, i32 0, i32 0
  %t16 = alloca { %NativeParameter**, i64 }
  %t17 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t16, i32 0, i32 0
  store %NativeParameter** %t15, %NativeParameter*** %t17
  %t18 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  %t19 = insertvalue %NativeInterfaceSignature %t13, { %NativeParameter**, i64 }* %t16, 3
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
  %t44 = insertvalue %InterfaceSignatureParse %t42, %NativeInterfaceSignature %t43, 1
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
  %t87 = insertvalue %InterfaceSignatureParse %t85, %NativeInterfaceSignature %t86, 1
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
  %t113 = insertvalue %InterfaceSignatureParse %t111, %NativeInterfaceSignature %t112, 1
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
  %t152 = load i8, i8* %t151
  %t153 = add i8 %t152, 96
  %t154 = alloca [2 x i8], align 1
  %t155 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 0
  store i8 %t153, i8* %t155
  %t156 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 1
  store i8 0, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 0
  %t158 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t140, i8* %t157)
  store { i8**, i64 }* %t158, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t159 = phi { i8**, i64 }* [ %t158, %then8 ], [ %t131, %entry ]
  store { i8**, i64 }* %t159, { i8**, i64 }** %l0
  %t160 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t161 = extractvalue %HeaderNameParse %t160, 0
  store i8* %t161, i8** %l9
  %t162 = load i8*, i8** %l9
  %t163 = call i64 @sailfin_runtime_string_length(i8* %t162)
  %t164 = icmp eq i64 %t163, 0
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t167 = load i8*, i8** %l2
  %t168 = load i8*, i8** %l3
  %t169 = load i1, i1* %l4
  %t170 = load double, double* %l5
  %t171 = load double, double* %l6
  %t172 = load i8*, i8** %l7
  %t173 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t174 = load i8*, i8** %l9
  br i1 %t164, label %then10, label %merge11
then10:
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s176 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.176, i32 0, i32 0
  %t177 = add i8* %s176, %interface_name
  %s178 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.178, i32 0, i32 0
  %t179 = add i8* %t177, %s178
  %t180 = load i8*, i8** %l2
  %t181 = add i8* %t179, %t180
  %s182 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.182, i32 0, i32 0
  %t183 = add i8* %t181, %s182
  %t184 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t175, i8* %t183)
  store { i8**, i64 }* %t184, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t185 = phi { i8**, i64 }* [ %t184, %then10 ], [ %t165, %entry ]
  store { i8**, i64 }* %t185, { i8**, i64 }** %l0
  %t186 = load i8*, i8** %l3
  %t187 = load double, double* %l5
  %t188 = sitofp i64 1 to double
  %t189 = fadd double %t187, %t188
  %t190 = load double, double* %l6
  %t191 = fptosi double %t189 to i64
  %t192 = fptosi double %t190 to i64
  %t193 = call i8* @sailfin_runtime_substring(i8* %t186, i64 %t191, i64 %t192)
  store i8* %t193, i8** %l10
  %t194 = alloca [0 x %NativeParameter]
  %t195 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* %t194, i32 0, i32 0
  %t196 = alloca { %NativeParameter*, i64 }
  %t197 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t196, i32 0, i32 0
  store %NativeParameter* %t195, %NativeParameter** %t197
  %t198 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t196, i32 0, i32 1
  store i64 0, i64* %t198
  store { %NativeParameter*, i64 }* %t196, { %NativeParameter*, i64 }** %l11
  %t199 = load i8*, i8** %l10
  %t200 = call i8* @trim_text(i8* %t199)
  store i8* %t200, i8** %l12
  %t201 = load i8*, i8** %l12
  %t202 = call i64 @sailfin_runtime_string_length(i8* %t201)
  %t203 = icmp sgt i64 %t202, 0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t205 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t206 = load i8*, i8** %l2
  %t207 = load i8*, i8** %l3
  %t208 = load i1, i1* %l4
  %t209 = load double, double* %l5
  %t210 = load double, double* %l6
  %t211 = load i8*, i8** %l7
  %t212 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t213 = load i8*, i8** %l9
  %t214 = load i8*, i8** %l10
  %t215 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t216 = load i8*, i8** %l12
  br i1 %t203, label %then12, label %merge13
then12:
  %t217 = load i8*, i8** %l12
  %t218 = call { i8**, i64 }* @split_parameter_entries(i8* %t217)
  store { i8**, i64 }* %t218, { i8**, i64 }** %l13
  %t219 = sitofp i64 0 to double
  store double %t219, double* %l14
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t222 = load i8*, i8** %l2
  %t223 = load i8*, i8** %l3
  %t224 = load i1, i1* %l4
  %t225 = load double, double* %l5
  %t226 = load double, double* %l6
  %t227 = load i8*, i8** %l7
  %t228 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t229 = load i8*, i8** %l9
  %t230 = load i8*, i8** %l10
  %t231 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t232 = load i8*, i8** %l12
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t234 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t271 = phi double [ %t234, %then12 ], [ %t270, %loop.latch16 ]
  store double %t271, double* %l14
  br label %loop.body15
loop.body15:
  %t235 = load double, double* %l14
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t237 = load { i8**, i64 }, { i8**, i64 }* %t236
  %t238 = extractvalue { i8**, i64 } %t237, 1
  %t239 = sitofp i64 %t238 to double
  %t240 = fcmp oge double %t235, %t239
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t243 = load i8*, i8** %l2
  %t244 = load i8*, i8** %l3
  %t245 = load i1, i1* %l4
  %t246 = load double, double* %l5
  %t247 = load double, double* %l6
  %t248 = load i8*, i8** %l7
  %t249 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t250 = load i8*, i8** %l9
  %t251 = load i8*, i8** %l10
  %t252 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t253 = load i8*, i8** %l12
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t255 = load double, double* %l14
  br i1 %t240, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t257 = load double, double* %l14
  %t258 = fptosi double %t257 to i64
  %t259 = load { i8**, i64 }, { i8**, i64 }* %t256
  %t260 = extractvalue { i8**, i64 } %t259, 0
  %t261 = extractvalue { i8**, i64 } %t259, 1
  %t262 = icmp uge i64 %t258, %t261
  ; bounds check: %t262 (if true, out of bounds)
  %t263 = getelementptr i8*, i8** %t260, i64 %t258
  %t264 = load i8*, i8** %t263
  %t265 = call double @parse_parameter_entry(i8* %t264, i8* null)
  store double %t265, double* %l15
  %t266 = load double, double* %l15
  %t267 = load double, double* %l14
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  store double %t269, double* %l14
  br label %loop.latch16
loop.latch16:
  %t270 = load double, double* %l14
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %s272 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.272, i32 0, i32 0
  store i8* %s272, i8** %l16
  %t273 = alloca [0 x i8*]
  %t274 = getelementptr [0 x i8*], [0 x i8*]* %t273, i32 0, i32 0
  %t275 = alloca { i8**, i64 }
  %t276 = getelementptr { i8**, i64 }, { i8**, i64 }* %t275, i32 0, i32 0
  store i8** %t274, i8*** %t276
  %t277 = getelementptr { i8**, i64 }, { i8**, i64 }* %t275, i32 0, i32 1
  store i64 0, i64* %t277
  store { i8**, i64 }* %t275, { i8**, i64 }** %l17
  %t278 = load i8*, i8** %l3
  %t279 = load double, double* %l6
  %t280 = sitofp i64 1 to double
  %t281 = fadd double %t279, %t280
  %t282 = load i8*, i8** %l3
  %t283 = call i64 @sailfin_runtime_string_length(i8* %t282)
  %t284 = fptosi double %t281 to i64
  %t285 = call i8* @sailfin_runtime_substring(i8* %t278, i64 %t284, i64 %t283)
  %t286 = call i8* @trim_text(i8* %t285)
  store i8* %t286, i8** %l18
  %t287 = load i8*, i8** %l18
  %t288 = call i64 @sailfin_runtime_string_length(i8* %t287)
  %t289 = icmp sgt i64 %t288, 0
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t292 = load i8*, i8** %l2
  %t293 = load i8*, i8** %l3
  %t294 = load i1, i1* %l4
  %t295 = load double, double* %l5
  %t296 = load double, double* %l6
  %t297 = load i8*, i8** %l7
  %t298 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t299 = load i8*, i8** %l9
  %t300 = load i8*, i8** %l10
  %t301 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t302 = load i8*, i8** %l12
  %t303 = load i8*, i8** %l16
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t305 = load i8*, i8** %l18
  br i1 %t289, label %then20, label %merge21
then20:
  %t306 = load i8*, i8** %l18
  %s307 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.307, i32 0, i32 0
  %t308 = call double @index_of(i8* %t306, i8* %s307)
  store double %t308, double* %l19
  %s309 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.309, i32 0, i32 0
  store i8* %s309, i8** %l20
  %t310 = load double, double* %l19
  %t311 = sitofp i64 0 to double
  %t312 = fcmp oge double %t310, %t311
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t314 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t315 = load i8*, i8** %l2
  %t316 = load i8*, i8** %l3
  %t317 = load i1, i1* %l4
  %t318 = load double, double* %l5
  %t319 = load double, double* %l6
  %t320 = load i8*, i8** %l7
  %t321 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t322 = load i8*, i8** %l9
  %t323 = load i8*, i8** %l10
  %t324 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t325 = load i8*, i8** %l12
  %t326 = load i8*, i8** %l16
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t328 = load i8*, i8** %l18
  %t329 = load double, double* %l19
  %t330 = load i8*, i8** %l20
  br i1 %t312, label %then22, label %merge23
then22:
  %t331 = load i8*, i8** %l18
  %t332 = load double, double* %l19
  %t333 = load i8*, i8** %l18
  %t334 = call i64 @sailfin_runtime_string_length(i8* %t333)
  %t335 = fptosi double %t332 to i64
  %t336 = call i8* @sailfin_runtime_substring(i8* %t331, i64 %t335, i64 %t334)
  %t337 = call i8* @trim_text(i8* %t336)
  store i8* %t337, i8** %l20
  %t338 = load i8*, i8** %l18
  %t339 = load double, double* %l19
  %t340 = fptosi double %t339 to i64
  %t341 = call i8* @sailfin_runtime_substring(i8* %t338, i64 0, i64 %t340)
  %t342 = call i8* @trim_text(i8* %t341)
  store i8* %t342, i8** %l18
  br label %merge23
merge23:
  %t343 = phi i8* [ %t337, %then22 ], [ %t330, %then20 ]
  %t344 = phi i8* [ %t342, %then22 ], [ %t328, %then20 ]
  store i8* %t343, i8** %l20
  store i8* %t344, i8** %l18
  %t345 = load i8*, i8** %l18
  %t346 = call i64 @sailfin_runtime_string_length(i8* %t345)
  %t347 = icmp sgt i64 %t346, 0
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t349 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t350 = load i8*, i8** %l2
  %t351 = load i8*, i8** %l3
  %t352 = load i1, i1* %l4
  %t353 = load double, double* %l5
  %t354 = load double, double* %l6
  %t355 = load i8*, i8** %l7
  %t356 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t357 = load i8*, i8** %l9
  %t358 = load i8*, i8** %l10
  %t359 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t360 = load i8*, i8** %l12
  %t361 = load i8*, i8** %l16
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t363 = load i8*, i8** %l18
  %t364 = load double, double* %l19
  %t365 = load i8*, i8** %l20
  br i1 %t347, label %then24, label %merge25
then24:
  %t366 = load i8*, i8** %l18
  %s367 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.367, i32 0, i32 0
  %t368 = call i1 @starts_with(i8* %t366, i8* %s367)
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t370 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t371 = load i8*, i8** %l2
  %t372 = load i8*, i8** %l3
  %t373 = load i1, i1* %l4
  %t374 = load double, double* %l5
  %t375 = load double, double* %l6
  %t376 = load i8*, i8** %l7
  %t377 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t378 = load i8*, i8** %l9
  %t379 = load i8*, i8** %l10
  %t380 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t381 = load i8*, i8** %l12
  %t382 = load i8*, i8** %l16
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t384 = load i8*, i8** %l18
  %t385 = load double, double* %l19
  %t386 = load i8*, i8** %l20
  br i1 %t368, label %then26, label %else27
then26:
  %t387 = load i8*, i8** %l18
  %s388 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.388, i32 0, i32 0
  %t389 = call i8* @strip_prefix(i8* %t387, i8* %s388)
  %t390 = call i8* @trim_text(i8* %t389)
  store i8* %t390, i8** %l21
  %t391 = load i8*, i8** %l21
  %t392 = call i64 @sailfin_runtime_string_length(i8* %t391)
  %t393 = icmp sgt i64 %t392, 0
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t395 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t396 = load i8*, i8** %l2
  %t397 = load i8*, i8** %l3
  %t398 = load i1, i1* %l4
  %t399 = load double, double* %l5
  %t400 = load double, double* %l6
  %t401 = load i8*, i8** %l7
  %t402 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t403 = load i8*, i8** %l9
  %t404 = load i8*, i8** %l10
  %t405 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t406 = load i8*, i8** %l12
  %t407 = load i8*, i8** %l16
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t409 = load i8*, i8** %l18
  %t410 = load double, double* %l19
  %t411 = load i8*, i8** %l20
  %t412 = load i8*, i8** %l21
  br i1 %t393, label %then29, label %merge30
then29:
  %t413 = load i8*, i8** %l21
  store i8* %t413, i8** %l16
  br label %merge30
merge30:
  %t414 = phi i8* [ %t413, %then29 ], [ %t407, %then26 ]
  store i8* %t414, i8** %l16
  br label %merge28
else27:
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s416 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.416, i32 0, i32 0
  %t417 = add i8* %s416, %interface_name
  %s418 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.418, i32 0, i32 0
  %t419 = add i8* %t417, %s418
  %t420 = load i8*, i8** %l9
  %t421 = add i8* %t419, %t420
  %s422 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.422, i32 0, i32 0
  %t423 = add i8* %t421, %s422
  %t424 = load i8*, i8** %l18
  %t425 = add i8* %t423, %t424
  %t426 = load i8, i8* %t425
  %t427 = add i8 %t426, 96
  %t428 = alloca [2 x i8], align 1
  %t429 = getelementptr [2 x i8], [2 x i8]* %t428, i32 0, i32 0
  store i8 %t427, i8* %t429
  %t430 = getelementptr [2 x i8], [2 x i8]* %t428, i32 0, i32 1
  store i8 0, i8* %t430
  %t431 = getelementptr [2 x i8], [2 x i8]* %t428, i32 0, i32 0
  %t432 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t415, i8* %t431)
  store { i8**, i64 }* %t432, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t433 = phi i8* [ %t413, %then26 ], [ %t382, %else27 ]
  %t434 = phi { i8**, i64 }* [ %t369, %then26 ], [ %t432, %else27 ]
  store i8* %t433, i8** %l16
  store { i8**, i64 }* %t434, { i8**, i64 }** %l0
  br label %merge25
merge25:
  %t435 = phi i8* [ %t413, %then24 ], [ %t361, %then20 ]
  %t436 = phi { i8**, i64 }* [ %t432, %then24 ], [ %t348, %then20 ]
  store i8* %t435, i8** %l16
  store { i8**, i64 }* %t436, { i8**, i64 }** %l0
  %t437 = load i8*, i8** %l20
  %t438 = call i64 @sailfin_runtime_string_length(i8* %t437)
  %t439 = icmp sgt i64 %t438, 0
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t441 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t442 = load i8*, i8** %l2
  %t443 = load i8*, i8** %l3
  %t444 = load i1, i1* %l4
  %t445 = load double, double* %l5
  %t446 = load double, double* %l6
  %t447 = load i8*, i8** %l7
  %t448 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t449 = load i8*, i8** %l9
  %t450 = load i8*, i8** %l10
  %t451 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t452 = load i8*, i8** %l12
  %t453 = load i8*, i8** %l16
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t455 = load i8*, i8** %l18
  %t456 = load double, double* %l19
  %t457 = load i8*, i8** %l20
  br i1 %t439, label %then31, label %merge32
then31:
  %t459 = load i8*, i8** %l20
  %s460 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.460, i32 0, i32 0
  %t461 = call i1 @starts_with(i8* %t459, i8* %s460)
  br label %logical_and_entry_458

logical_and_entry_458:
  br i1 %t461, label %logical_and_right_458, label %logical_and_merge_458

logical_and_right_458:
  br label %merge32
merge32:
  br label %merge21
merge21:
  %t462 = phi i8* [ %t342, %then20 ], [ %t305, %entry ]
  %t463 = phi i8* [ %t413, %then20 ], [ %t303, %entry ]
  %t464 = phi { i8**, i64 }* [ %t432, %then20 ], [ %t290, %entry ]
  store i8* %t462, i8** %l18
  store i8* %t463, i8** %l16
  store { i8**, i64 }* %t464, { i8**, i64 }** %l0
  %t465 = load i8*, i8** %l9
  %t466 = insertvalue %NativeInterfaceSignature undef, i8* %t465, 0
  %t467 = load i1, i1* %l4
  %t468 = insertvalue %NativeInterfaceSignature %t466, i1 %t467, 1
  %t469 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t470 = extractvalue %HeaderNameParse %t469, 1
  %t471 = insertvalue %NativeInterfaceSignature %t468, { i8**, i64 }* %t470, 2
  %t472 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t473 = bitcast { %NativeParameter*, i64 }* %t472 to { %NativeParameter**, i64 }*
  %t474 = insertvalue %NativeInterfaceSignature %t471, { %NativeParameter**, i64 }* %t473, 3
  %t475 = load i8*, i8** %l16
  %t476 = insertvalue %NativeInterfaceSignature %t474, i8* %t475, 4
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t478 = insertvalue %NativeInterfaceSignature %t476, { i8**, i64 }* %t477, 5
  store %NativeInterfaceSignature %t478, %NativeInterfaceSignature* %l22
  %t480 = load i8*, i8** %l9
  %t481 = call i64 @sailfin_runtime_string_length(i8* %t480)
  %t482 = icmp sgt i64 %t481, 0
  br label %logical_and_entry_479

logical_and_entry_479:
  br i1 %t482, label %logical_and_right_479, label %logical_and_merge_479

logical_and_right_479:
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t484 = load { i8**, i64 }, { i8**, i64 }* %t483
  %t485 = extractvalue { i8**, i64 } %t484, 1
  %t486 = icmp eq i64 %t485, 0
  br label %logical_and_right_end_479

logical_and_right_end_479:
  br label %logical_and_merge_479

logical_and_merge_479:
  %t487 = phi i1 [ false, %logical_and_entry_479 ], [ %t486, %logical_and_right_end_479 ]
  store i1 %t487, i1* %l23
  %t488 = load i1, i1* %l23
  %t489 = insertvalue %InterfaceSignatureParse undef, i1 %t488, 0
  %t490 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l22
  %t491 = insertvalue %InterfaceSignatureParse %t489, %NativeInterfaceSignature %t490, 1
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t493 = insertvalue %InterfaceSignatureParse %t491, { i8**, i64 }* %t492, 2
  ret %InterfaceSignatureParse %t493
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
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 60, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call double @index_of(i8* %t30, i8* %t34)
  store double %t35, double* %l5
  %t36 = load double, double* %l5
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oge double %t36, %t37
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load i8*, i8** %l2
  %t42 = load i8*, i8** %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t44 = load double, double* %l5
  br i1 %t38, label %then2, label %else3
then2:
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l5
  %t47 = call double @find_matching_angle(i8* %t45, double %t46)
  store double %t47, double* %l6
  %t48 = load double, double* %l6
  %t49 = sitofp i64 0 to double
  %t50 = fcmp olt double %t48, %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load i8*, i8** %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t56 = load double, double* %l5
  %t57 = load double, double* %l6
  br i1 %t50, label %then5, label %merge6
then5:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.59, i32 0, i32 0
  %t60 = add i8* %s59, %text
  %s61 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.61, i32 0, i32 0
  %t62 = add i8* %t60, %s61
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  %t64 = load i8*, i8** %l1
  %t65 = call i8* @strip_generics(i8* %t64)
  store i8* %t65, i8** %l2
  %t66 = load i8*, i8** %l2
  %t67 = insertvalue %HeaderNameParse undef, i8* %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t69 = insertvalue %HeaderNameParse %t67, { i8**, i64 }* %t68, 1
  %t70 = load i8*, i8** %l3
  %t71 = insertvalue %HeaderNameParse %t69, i8* %t70, 2
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = insertvalue %HeaderNameParse %t71, { i8**, i64 }* %t72, 3
  ret %HeaderNameParse %t73
merge6:
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l5
  %t76 = fptosi double %t75 to i64
  %t77 = call i8* @sailfin_runtime_substring(i8* %t74, i64 0, i64 %t76)
  %t78 = call i8* @trim_text(i8* %t77)
  store i8* %t78, i8** %l2
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l5
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  %t83 = load double, double* %l6
  %t84 = fptosi double %t82 to i64
  %t85 = fptosi double %t83 to i64
  %t86 = call i8* @sailfin_runtime_substring(i8* %t79, i64 %t84, i64 %t85)
  store i8* %t86, i8** %l7
  %t87 = load i8*, i8** %l7
  %t88 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l4
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l6
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  %t93 = load i8*, i8** %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = fptosi double %t92 to i64
  %t96 = call i8* @sailfin_runtime_substring(i8* %t89, i64 %t95, i64 %t94)
  %t97 = call i8* @trim_text(i8* %t96)
  store i8* %t97, i8** %l3
  br label %merge4
else3:
  %t98 = load i8*, i8** %l1
  %t99 = alloca [2 x i8], align 1
  %t100 = getelementptr [2 x i8], [2 x i8]* %t99, i32 0, i32 0
  store i8 32, i8* %t100
  %t101 = getelementptr [2 x i8], [2 x i8]* %t99, i32 0, i32 1
  store i8 0, i8* %t101
  %t102 = getelementptr [2 x i8], [2 x i8]* %t99, i32 0, i32 0
  %t103 = call double @index_of(i8* %t98, i8* %t102)
  store double %t103, double* %l8
  %t104 = load double, double* %l8
  %t105 = sitofp i64 0 to double
  %t106 = fcmp oge double %t104, %t105
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load i8*, i8** %l1
  %t109 = load i8*, i8** %l2
  %t110 = load i8*, i8** %l3
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t112 = load double, double* %l5
  %t113 = load double, double* %l8
  br i1 %t106, label %then7, label %merge8
then7:
  %t114 = load i8*, i8** %l1
  %t115 = load double, double* %l8
  %t116 = fptosi double %t115 to i64
  %t117 = call i8* @sailfin_runtime_substring(i8* %t114, i64 0, i64 %t116)
  %t118 = call i8* @trim_text(i8* %t117)
  store i8* %t118, i8** %l2
  %t119 = load i8*, i8** %l1
  %t120 = load double, double* %l8
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  %t123 = load i8*, i8** %l1
  %t124 = call i64 @sailfin_runtime_string_length(i8* %t123)
  %t125 = fptosi double %t122 to i64
  %t126 = call i8* @sailfin_runtime_substring(i8* %t119, i64 %t125, i64 %t124)
  %t127 = call i8* @trim_text(i8* %t126)
  store i8* %t127, i8** %l3
  br label %merge8
merge8:
  %t128 = phi i8* [ %t118, %then7 ], [ %t109, %else3 ]
  %t129 = phi i8* [ %t127, %then7 ], [ %t110, %else3 ]
  store i8* %t128, i8** %l2
  store i8* %t129, i8** %l3
  br label %merge4
merge4:
  %t130 = phi { i8**, i64 }* [ %t63, %then2 ], [ %t39, %else3 ]
  %t131 = phi i8* [ %t65, %then2 ], [ %t118, %else3 ]
  %t132 = phi { i8**, i64 }* [ %t88, %then2 ], [ %t43, %else3 ]
  %t133 = phi i8* [ %t97, %then2 ], [ %t127, %else3 ]
  store { i8**, i64 }* %t130, { i8**, i64 }** %l0
  store i8* %t131, i8** %l2
  store { i8**, i64 }* %t132, { i8**, i64 }** %l4
  store i8* %t133, i8** %l3
  %t134 = load i8*, i8** %l2
  %t135 = call i8* @strip_generics(i8* %t134)
  store i8* %t135, i8** %l2
  %t136 = load i8*, i8** %l2
  %t137 = insertvalue %HeaderNameParse undef, i8* %t136, 0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t139 = insertvalue %HeaderNameParse %t137, { i8**, i64 }* %t138, 1
  %t140 = load i8*, i8** %l3
  %t141 = insertvalue %HeaderNameParse %t139, i8* %t140, 2
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = insertvalue %HeaderNameParse %t141, { i8**, i64 }* %t142, 3
  ret %HeaderNameParse %t143
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
  %t472 = phi i8* [ %t13, %entry ], [ %t464, %loop.latch2 ]
  %t473 = phi double [ %t14, %entry ], [ %t465, %loop.latch2 ]
  %t474 = phi i8* [ %t15, %entry ], [ %t466, %loop.latch2 ]
  %t475 = phi double [ %t16, %entry ], [ %t467, %loop.latch2 ]
  %t476 = phi double [ %t17, %entry ], [ %t468, %loop.latch2 ]
  %t477 = phi double [ %t18, %entry ], [ %t469, %loop.latch2 ]
  %t478 = phi double [ %t19, %entry ], [ %t470, %loop.latch2 ]
  %t479 = phi { i8**, i64 }* [ %t12, %entry ], [ %t471, %loop.latch2 ]
  store i8* %t472, i8** %l1
  store double %t473, double* %l2
  store i8* %t474, i8** %l3
  store double %t475, double* %l4
  store double %t476, double* %l5
  store double %t477, double* %l6
  store double %t478, double* %l7
  store { i8**, i64 }* %t479, { i8**, i64 }** %l0
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
  %t50 = load i8, i8* %t48
  %t51 = add i8 %t50, %t49
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 %t51, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8* %t55, i8** %l1
  %t56 = load i8, i8* %l8
  %t57 = icmp eq i8 %t56, 92
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l2
  %t61 = load i8*, i8** %l3
  %t62 = load double, double* %l4
  %t63 = load double, double* %l5
  %t64 = load double, double* %l6
  %t65 = load double, double* %l7
  %t66 = load i8, i8* %l8
  br i1 %t57, label %then8, label %merge9
then8:
  %t67 = load double, double* %l2
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  %t70 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t71 = sitofp i64 %t70 to double
  %t72 = fcmp olt double %t69, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l2
  %t76 = load i8*, i8** %l3
  %t77 = load double, double* %l4
  %t78 = load double, double* %l5
  %t79 = load double, double* %l6
  %t80 = load double, double* %l7
  %t81 = load i8, i8* %l8
  br i1 %t72, label %then10, label %merge11
then10:
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = sitofp i64 2 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t86 = phi i8* [ null, %then8 ], [ %t59, %then6 ]
  %t87 = phi double [ %t85, %then8 ], [ %t60, %then6 ]
  store i8* %t86, i8** %l1
  store double %t87, double* %l2
  %t88 = load i8, i8* %l8
  %t89 = load i8*, i8** %l3
  %t90 = load i8, i8* %t89
  %t91 = icmp eq i8 %t88, %t90
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l2
  %t95 = load i8*, i8** %l3
  %t96 = load double, double* %l4
  %t97 = load double, double* %l5
  %t98 = load double, double* %l6
  %t99 = load double, double* %l7
  %t100 = load i8, i8* %l8
  br i1 %t91, label %then12, label %merge13
then12:
  %s101 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.101, i32 0, i32 0
  store i8* %s101, i8** %l3
  br label %merge13
merge13:
  %t102 = phi i8* [ %s101, %then12 ], [ %t95, %then6 ]
  store i8* %t102, i8** %l3
  %t103 = load double, double* %l2
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l2
  br label %loop.latch2
merge7:
  %t107 = load i8, i8* %l8
  %t108 = icmp eq i8 %t107, 34
  br label %logical_or_entry_106

logical_or_entry_106:
  br i1 %t108, label %logical_or_merge_106, label %logical_or_right_106

logical_or_right_106:
  %t109 = load i8, i8* %l8
  %t110 = icmp eq i8 %t109, 39
  br label %logical_or_right_end_106

logical_or_right_end_106:
  br label %logical_or_merge_106

logical_or_merge_106:
  %t111 = phi i1 [ true, %logical_or_entry_106 ], [ %t110, %logical_or_right_end_106 ]
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l2
  %t115 = load i8*, i8** %l3
  %t116 = load double, double* %l4
  %t117 = load double, double* %l5
  %t118 = load double, double* %l6
  %t119 = load double, double* %l7
  %t120 = load i8, i8* %l8
  br i1 %t111, label %then14, label %merge15
then14:
  %t121 = load i8, i8* %l8
  %t122 = alloca [2 x i8], align 1
  %t123 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  store i8 %t121, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 1
  store i8 0, i8* %t124
  %t125 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  store i8* %t125, i8** %l3
  %t126 = load i8*, i8** %l1
  %t127 = load i8, i8* %l8
  %t128 = load i8, i8* %t126
  %t129 = add i8 %t128, %t127
  %t130 = alloca [2 x i8], align 1
  %t131 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 0
  store i8 %t129, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 1
  store i8 0, i8* %t132
  %t133 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 0
  store i8* %t133, i8** %l1
  %t134 = load double, double* %l2
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l2
  br label %loop.latch2
merge15:
  %t137 = load i8, i8* %l8
  %t138 = icmp eq i8 %t137, 60
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t140 = load i8*, i8** %l1
  %t141 = load double, double* %l2
  %t142 = load i8*, i8** %l3
  %t143 = load double, double* %l4
  %t144 = load double, double* %l5
  %t145 = load double, double* %l6
  %t146 = load double, double* %l7
  %t147 = load i8, i8* %l8
  br i1 %t138, label %then16, label %merge17
then16:
  %t148 = load double, double* %l4
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l4
  %t151 = load i8*, i8** %l1
  %t152 = load i8, i8* %l8
  %t153 = load i8, i8* %t151
  %t154 = add i8 %t153, %t152
  %t155 = alloca [2 x i8], align 1
  %t156 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  store i8 %t154, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 1
  store i8 0, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  store i8* %t158, i8** %l1
  %t159 = load double, double* %l2
  %t160 = sitofp i64 1 to double
  %t161 = fadd double %t159, %t160
  store double %t161, double* %l2
  br label %loop.latch2
merge17:
  %t162 = load i8, i8* %l8
  %t163 = icmp eq i8 %t162, 62
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t165 = load i8*, i8** %l1
  %t166 = load double, double* %l2
  %t167 = load i8*, i8** %l3
  %t168 = load double, double* %l4
  %t169 = load double, double* %l5
  %t170 = load double, double* %l6
  %t171 = load double, double* %l7
  %t172 = load i8, i8* %l8
  br i1 %t163, label %then18, label %merge19
then18:
  %t173 = load double, double* %l4
  %t174 = sitofp i64 0 to double
  %t175 = fcmp ogt double %t173, %t174
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load i8*, i8** %l1
  %t178 = load double, double* %l2
  %t179 = load i8*, i8** %l3
  %t180 = load double, double* %l4
  %t181 = load double, double* %l5
  %t182 = load double, double* %l6
  %t183 = load double, double* %l7
  %t184 = load i8, i8* %l8
  br i1 %t175, label %then20, label %merge21
then20:
  %t185 = load double, double* %l4
  %t186 = sitofp i64 1 to double
  %t187 = fsub double %t185, %t186
  store double %t187, double* %l4
  br label %merge21
merge21:
  %t188 = phi double [ %t187, %then20 ], [ %t180, %then18 ]
  store double %t188, double* %l4
  %t189 = load i8*, i8** %l1
  %t190 = load i8, i8* %l8
  %t191 = load i8, i8* %t189
  %t192 = add i8 %t191, %t190
  %t193 = alloca [2 x i8], align 1
  %t194 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  store i8 %t192, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 1
  store i8 0, i8* %t195
  %t196 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  store i8* %t196, i8** %l1
  %t197 = load double, double* %l2
  %t198 = sitofp i64 1 to double
  %t199 = fadd double %t197, %t198
  store double %t199, double* %l2
  br label %loop.latch2
merge19:
  %t200 = load i8, i8* %l8
  %t201 = icmp eq i8 %t200, 40
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t203 = load i8*, i8** %l1
  %t204 = load double, double* %l2
  %t205 = load i8*, i8** %l3
  %t206 = load double, double* %l4
  %t207 = load double, double* %l5
  %t208 = load double, double* %l6
  %t209 = load double, double* %l7
  %t210 = load i8, i8* %l8
  br i1 %t201, label %then22, label %merge23
then22:
  %t211 = load double, double* %l5
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l5
  %t214 = load i8*, i8** %l1
  %t215 = load i8, i8* %l8
  %t216 = load i8, i8* %t214
  %t217 = add i8 %t216, %t215
  %t218 = alloca [2 x i8], align 1
  %t219 = getelementptr [2 x i8], [2 x i8]* %t218, i32 0, i32 0
  store i8 %t217, i8* %t219
  %t220 = getelementptr [2 x i8], [2 x i8]* %t218, i32 0, i32 1
  store i8 0, i8* %t220
  %t221 = getelementptr [2 x i8], [2 x i8]* %t218, i32 0, i32 0
  store i8* %t221, i8** %l1
  %t222 = load double, double* %l2
  %t223 = sitofp i64 1 to double
  %t224 = fadd double %t222, %t223
  store double %t224, double* %l2
  br label %loop.latch2
merge23:
  %t225 = load i8, i8* %l8
  %t226 = icmp eq i8 %t225, 41
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t228 = load i8*, i8** %l1
  %t229 = load double, double* %l2
  %t230 = load i8*, i8** %l3
  %t231 = load double, double* %l4
  %t232 = load double, double* %l5
  %t233 = load double, double* %l6
  %t234 = load double, double* %l7
  %t235 = load i8, i8* %l8
  br i1 %t226, label %then24, label %merge25
then24:
  %t236 = load double, double* %l5
  %t237 = sitofp i64 0 to double
  %t238 = fcmp ogt double %t236, %t237
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  %t242 = load i8*, i8** %l3
  %t243 = load double, double* %l4
  %t244 = load double, double* %l5
  %t245 = load double, double* %l6
  %t246 = load double, double* %l7
  %t247 = load i8, i8* %l8
  br i1 %t238, label %then26, label %merge27
then26:
  %t248 = load double, double* %l5
  %t249 = sitofp i64 1 to double
  %t250 = fsub double %t248, %t249
  store double %t250, double* %l5
  br label %merge27
merge27:
  %t251 = phi double [ %t250, %then26 ], [ %t244, %then24 ]
  store double %t251, double* %l5
  %t252 = load i8*, i8** %l1
  %t253 = load i8, i8* %l8
  %t254 = load i8, i8* %t252
  %t255 = add i8 %t254, %t253
  %t256 = alloca [2 x i8], align 1
  %t257 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 0
  store i8 %t255, i8* %t257
  %t258 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 1
  store i8 0, i8* %t258
  %t259 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 0
  store i8* %t259, i8** %l1
  %t260 = load double, double* %l2
  %t261 = sitofp i64 1 to double
  %t262 = fadd double %t260, %t261
  store double %t262, double* %l2
  br label %loop.latch2
merge25:
  %t263 = load i8, i8* %l8
  %t264 = icmp eq i8 %t263, 91
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t266 = load i8*, i8** %l1
  %t267 = load double, double* %l2
  %t268 = load i8*, i8** %l3
  %t269 = load double, double* %l4
  %t270 = load double, double* %l5
  %t271 = load double, double* %l6
  %t272 = load double, double* %l7
  %t273 = load i8, i8* %l8
  br i1 %t264, label %then28, label %merge29
then28:
  %t274 = load double, double* %l6
  %t275 = sitofp i64 1 to double
  %t276 = fadd double %t274, %t275
  store double %t276, double* %l6
  %t277 = load i8*, i8** %l1
  %t278 = load i8, i8* %l8
  %t279 = load i8, i8* %t277
  %t280 = add i8 %t279, %t278
  %t281 = alloca [2 x i8], align 1
  %t282 = getelementptr [2 x i8], [2 x i8]* %t281, i32 0, i32 0
  store i8 %t280, i8* %t282
  %t283 = getelementptr [2 x i8], [2 x i8]* %t281, i32 0, i32 1
  store i8 0, i8* %t283
  %t284 = getelementptr [2 x i8], [2 x i8]* %t281, i32 0, i32 0
  store i8* %t284, i8** %l1
  %t285 = load double, double* %l2
  %t286 = sitofp i64 1 to double
  %t287 = fadd double %t285, %t286
  store double %t287, double* %l2
  br label %loop.latch2
merge29:
  %t288 = load i8, i8* %l8
  %t289 = icmp eq i8 %t288, 93
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load i8*, i8** %l1
  %t292 = load double, double* %l2
  %t293 = load i8*, i8** %l3
  %t294 = load double, double* %l4
  %t295 = load double, double* %l5
  %t296 = load double, double* %l6
  %t297 = load double, double* %l7
  %t298 = load i8, i8* %l8
  br i1 %t289, label %then30, label %merge31
then30:
  %t299 = load double, double* %l6
  %t300 = sitofp i64 0 to double
  %t301 = fcmp ogt double %t299, %t300
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t303 = load i8*, i8** %l1
  %t304 = load double, double* %l2
  %t305 = load i8*, i8** %l3
  %t306 = load double, double* %l4
  %t307 = load double, double* %l5
  %t308 = load double, double* %l6
  %t309 = load double, double* %l7
  %t310 = load i8, i8* %l8
  br i1 %t301, label %then32, label %merge33
then32:
  %t311 = load double, double* %l6
  %t312 = sitofp i64 1 to double
  %t313 = fsub double %t311, %t312
  store double %t313, double* %l6
  br label %merge33
merge33:
  %t314 = phi double [ %t313, %then32 ], [ %t308, %then30 ]
  store double %t314, double* %l6
  %t315 = load i8*, i8** %l1
  %t316 = load i8, i8* %l8
  %t317 = load i8, i8* %t315
  %t318 = add i8 %t317, %t316
  %t319 = alloca [2 x i8], align 1
  %t320 = getelementptr [2 x i8], [2 x i8]* %t319, i32 0, i32 0
  store i8 %t318, i8* %t320
  %t321 = getelementptr [2 x i8], [2 x i8]* %t319, i32 0, i32 1
  store i8 0, i8* %t321
  %t322 = getelementptr [2 x i8], [2 x i8]* %t319, i32 0, i32 0
  store i8* %t322, i8** %l1
  %t323 = load double, double* %l2
  %t324 = sitofp i64 1 to double
  %t325 = fadd double %t323, %t324
  store double %t325, double* %l2
  br label %loop.latch2
merge31:
  %t326 = load i8, i8* %l8
  %t327 = icmp eq i8 %t326, 123
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t329 = load i8*, i8** %l1
  %t330 = load double, double* %l2
  %t331 = load i8*, i8** %l3
  %t332 = load double, double* %l4
  %t333 = load double, double* %l5
  %t334 = load double, double* %l6
  %t335 = load double, double* %l7
  %t336 = load i8, i8* %l8
  br i1 %t327, label %then34, label %merge35
then34:
  %t337 = load double, double* %l7
  %t338 = sitofp i64 1 to double
  %t339 = fadd double %t337, %t338
  store double %t339, double* %l7
  %t340 = load i8*, i8** %l1
  %t341 = load i8, i8* %l8
  %t342 = load i8, i8* %t340
  %t343 = add i8 %t342, %t341
  %t344 = alloca [2 x i8], align 1
  %t345 = getelementptr [2 x i8], [2 x i8]* %t344, i32 0, i32 0
  store i8 %t343, i8* %t345
  %t346 = getelementptr [2 x i8], [2 x i8]* %t344, i32 0, i32 1
  store i8 0, i8* %t346
  %t347 = getelementptr [2 x i8], [2 x i8]* %t344, i32 0, i32 0
  store i8* %t347, i8** %l1
  %t348 = load double, double* %l2
  %t349 = sitofp i64 1 to double
  %t350 = fadd double %t348, %t349
  store double %t350, double* %l2
  br label %loop.latch2
merge35:
  %t351 = load i8, i8* %l8
  %t352 = icmp eq i8 %t351, 125
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t354 = load i8*, i8** %l1
  %t355 = load double, double* %l2
  %t356 = load i8*, i8** %l3
  %t357 = load double, double* %l4
  %t358 = load double, double* %l5
  %t359 = load double, double* %l6
  %t360 = load double, double* %l7
  %t361 = load i8, i8* %l8
  br i1 %t352, label %then36, label %merge37
then36:
  %t362 = load double, double* %l7
  %t363 = sitofp i64 0 to double
  %t364 = fcmp ogt double %t362, %t363
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load i8*, i8** %l1
  %t367 = load double, double* %l2
  %t368 = load i8*, i8** %l3
  %t369 = load double, double* %l4
  %t370 = load double, double* %l5
  %t371 = load double, double* %l6
  %t372 = load double, double* %l7
  %t373 = load i8, i8* %l8
  br i1 %t364, label %then38, label %merge39
then38:
  %t374 = load double, double* %l7
  %t375 = sitofp i64 1 to double
  %t376 = fsub double %t374, %t375
  store double %t376, double* %l7
  br label %merge39
merge39:
  %t377 = phi double [ %t376, %then38 ], [ %t372, %then36 ]
  store double %t377, double* %l7
  %t378 = load i8*, i8** %l1
  %t379 = load i8, i8* %l8
  %t380 = load i8, i8* %t378
  %t381 = add i8 %t380, %t379
  %t382 = alloca [2 x i8], align 1
  %t383 = getelementptr [2 x i8], [2 x i8]* %t382, i32 0, i32 0
  store i8 %t381, i8* %t383
  %t384 = getelementptr [2 x i8], [2 x i8]* %t382, i32 0, i32 1
  store i8 0, i8* %t384
  %t385 = getelementptr [2 x i8], [2 x i8]* %t382, i32 0, i32 0
  store i8* %t385, i8** %l1
  %t386 = load double, double* %l2
  %t387 = sitofp i64 1 to double
  %t388 = fadd double %t386, %t387
  store double %t388, double* %l2
  br label %loop.latch2
merge37:
  %t389 = load i8, i8* %l8
  %t390 = icmp eq i8 %t389, 44
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t392 = load i8*, i8** %l1
  %t393 = load double, double* %l2
  %t394 = load i8*, i8** %l3
  %t395 = load double, double* %l4
  %t396 = load double, double* %l5
  %t397 = load double, double* %l6
  %t398 = load double, double* %l7
  %t399 = load i8, i8* %l8
  br i1 %t390, label %then40, label %merge41
then40:
  %t401 = load double, double* %l4
  %t402 = sitofp i64 0 to double
  %t403 = fcmp oeq double %t401, %t402
  br label %logical_and_entry_400

logical_and_entry_400:
  br i1 %t403, label %logical_and_right_400, label %logical_and_merge_400

logical_and_right_400:
  %t405 = load double, double* %l5
  %t406 = sitofp i64 0 to double
  %t407 = fcmp oeq double %t405, %t406
  br label %logical_and_entry_404

logical_and_entry_404:
  br i1 %t407, label %logical_and_right_404, label %logical_and_merge_404

logical_and_right_404:
  %t409 = load double, double* %l6
  %t410 = sitofp i64 0 to double
  %t411 = fcmp oeq double %t409, %t410
  br label %logical_and_entry_408

logical_and_entry_408:
  br i1 %t411, label %logical_and_right_408, label %logical_and_merge_408

logical_and_right_408:
  %t412 = load double, double* %l7
  %t413 = sitofp i64 0 to double
  %t414 = fcmp oeq double %t412, %t413
  br label %logical_and_right_end_408

logical_and_right_end_408:
  br label %logical_and_merge_408

logical_and_merge_408:
  %t415 = phi i1 [ false, %logical_and_entry_408 ], [ %t414, %logical_and_right_end_408 ]
  br label %logical_and_right_end_404

logical_and_right_end_404:
  br label %logical_and_merge_404

logical_and_merge_404:
  %t416 = phi i1 [ false, %logical_and_entry_404 ], [ %t415, %logical_and_right_end_404 ]
  br label %logical_and_right_end_400

logical_and_right_end_400:
  br label %logical_and_merge_400

logical_and_merge_400:
  %t417 = phi i1 [ false, %logical_and_entry_400 ], [ %t416, %logical_and_right_end_400 ]
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t419 = load i8*, i8** %l1
  %t420 = load double, double* %l2
  %t421 = load i8*, i8** %l3
  %t422 = load double, double* %l4
  %t423 = load double, double* %l5
  %t424 = load double, double* %l6
  %t425 = load double, double* %l7
  %t426 = load i8, i8* %l8
  br i1 %t417, label %then42, label %merge43
then42:
  %t427 = load i8*, i8** %l1
  %t428 = call i8* @trim_text(i8* %t427)
  store i8* %t428, i8** %l9
  %t429 = load i8*, i8** %l9
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
  %t440 = load i8, i8* %l8
  %t441 = load i8*, i8** %l9
  br i1 %t431, label %then44, label %merge45
then44:
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t443 = load i8*, i8** %l9
  %t444 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t442, i8* %t443)
  store { i8**, i64 }* %t444, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t445 = phi { i8**, i64 }* [ %t444, %then44 ], [ %t432, %then42 ]
  store { i8**, i64 }* %t445, { i8**, i64 }** %l0
  %s446 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.446, i32 0, i32 0
  store i8* %s446, i8** %l1
  %t447 = load double, double* %l2
  %t448 = sitofp i64 1 to double
  %t449 = fadd double %t447, %t448
  store double %t449, double* %l2
  br label %loop.latch2
merge43:
  br label %merge41
merge41:
  %t450 = phi { i8**, i64 }* [ %t444, %then40 ], [ %t391, %loop.body1 ]
  %t451 = phi i8* [ %s446, %then40 ], [ %t392, %loop.body1 ]
  %t452 = phi double [ %t449, %then40 ], [ %t393, %loop.body1 ]
  store { i8**, i64 }* %t450, { i8**, i64 }** %l0
  store i8* %t451, i8** %l1
  store double %t452, double* %l2
  %t453 = load i8*, i8** %l1
  %t454 = load i8, i8* %l8
  %t455 = load i8, i8* %t453
  %t456 = add i8 %t455, %t454
  %t457 = alloca [2 x i8], align 1
  %t458 = getelementptr [2 x i8], [2 x i8]* %t457, i32 0, i32 0
  store i8 %t456, i8* %t458
  %t459 = getelementptr [2 x i8], [2 x i8]* %t457, i32 0, i32 1
  store i8 0, i8* %t459
  %t460 = getelementptr [2 x i8], [2 x i8]* %t457, i32 0, i32 0
  store i8* %t460, i8** %l1
  %t461 = load double, double* %l2
  %t462 = sitofp i64 1 to double
  %t463 = fadd double %t461, %t462
  store double %t463, double* %l2
  br label %loop.latch2
loop.latch2:
  %t464 = load i8*, i8** %l1
  %t465 = load double, double* %l2
  %t466 = load i8*, i8** %l3
  %t467 = load double, double* %l4
  %t468 = load double, double* %l5
  %t469 = load double, double* %l6
  %t470 = load double, double* %l7
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t480 = load i8*, i8** %l1
  %t481 = call i8* @trim_text(i8* %t480)
  store i8* %t481, i8** %l10
  %t482 = load i8*, i8** %l10
  %t483 = call i64 @sailfin_runtime_string_length(i8* %t482)
  %t484 = icmp sgt i64 %t483, 0
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t486 = load i8*, i8** %l1
  %t487 = load double, double* %l2
  %t488 = load i8*, i8** %l3
  %t489 = load double, double* %l4
  %t490 = load double, double* %l5
  %t491 = load double, double* %l6
  %t492 = load double, double* %l7
  %t493 = load i8*, i8** %l10
  br i1 %t484, label %then46, label %merge47
then46:
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t495 = load i8*, i8** %l10
  %t496 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t494, i8* %t495)
  store { i8**, i64 }* %t496, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t497 = phi { i8**, i64 }* [ %t496, %then46 ], [ %t485, %entry ]
  store { i8**, i64 }* %t497, { i8**, i64 }** %l0
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t498
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
  %t50 = phi double [ %t1, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t2, %entry ], [ %t49, %loop.latch2 ]
  store double %t50, double* %l0
  store double %t51, double* %l1
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
  %t14 = icmp eq i8 %t13, 60
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then6, label %else7
then6:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %merge8
else7:
  %t21 = load i8, i8* %l2
  %t22 = icmp eq i8 %t21, 62
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i8, i8* %l2
  br i1 %t22, label %then9, label %merge10
then9:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 0 to double
  %t28 = fcmp ogt double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8, i8* %l2
  br i1 %t28, label %then11, label %else12
then11:
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fsub double %t32, %t33
  store double %t34, double* %l0
  %t35 = load double, double* %l0
  %t36 = sitofp i64 0 to double
  %t37 = fcmp oeq double %t35, %t36
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = load i8, i8* %l2
  br i1 %t37, label %then14, label %merge15
then14:
  %t41 = load double, double* %l1
  ret double %t41
merge15:
  br label %merge13
else12:
  %t42 = load double, double* %l1
  ret double %t42
merge13:
  br label %merge10
merge10:
  %t43 = phi double [ %t34, %then9 ], [ %t23, %else7 ]
  store double %t43, double* %l0
  br label %merge8
merge8:
  %t44 = phi double [ %t20, %then6 ], [ %t34, %else7 ]
  store double %t44, double* %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = sitofp i64 -1 to double
  ret double %t52
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
  %t722 = phi { i8**, i64 }* [ %t70, %entry ], [ %t712, %loop.latch6 ]
  %t723 = phi double [ %t84, %entry ], [ %t713, %loop.latch6 ]
  %t724 = phi double [ %t77, %entry ], [ %t714, %loop.latch6 ]
  %t725 = phi double [ %t78, %entry ], [ %t715, %loop.latch6 ]
  %t726 = phi i8* [ %t79, %entry ], [ %t716, %loop.latch6 ]
  %t727 = phi double [ %t80, %entry ], [ %t717, %loop.latch6 ]
  %t728 = phi double [ %t81, %entry ], [ %t718, %loop.latch6 ]
  %t729 = phi i1 [ %t82, %entry ], [ %t719, %loop.latch6 ]
  %t730 = phi { %NativeEnumVariantLayout*, i64 }* [ %t76, %entry ], [ %t720, %loop.latch6 ]
  %t731 = phi i1 [ %t83, %entry ], [ %t721, %loop.latch6 ]
  store { i8**, i64 }* %t722, { i8**, i64 }** %l0
  store double %t723, double* %l14
  store double %t724, double* %l7
  store double %t725, double* %l8
  store i8* %t726, i8** %l9
  store double %t727, double* %l10
  store double %t728, double* %l11
  store i1 %t729, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t730, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t731, i1* %l13
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
  %t138 = bitcast { %NativeEnumVariantLayout*, i64 }* %t137 to { %NativeEnumVariantLayout**, i64 }*
  %t139 = insertvalue %NativeEnumLayout %t136, { %NativeEnumVariantLayout**, i64 }* %t138, 5
  store i8* null, i8** %l15
  br label %merge11
merge11:
  %t140 = phi i8* [ null, %then10 ], [ %t126, %then8 ]
  store i8* %t140, i8** %l15
  %t141 = load i8*, i8** %l3
  %t142 = insertvalue %NativeEnum undef, i8* %t141, 0
  %t143 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t144 = bitcast { %NativeEnumVariant*, i64 }* %t143 to { %NativeEnumVariant**, i64 }*
  %t145 = insertvalue %NativeEnum %t142, { %NativeEnumVariant**, i64 }* %t144, 1
  %t146 = load i8*, i8** %l15
  %t147 = bitcast i8* %t146 to %NativeEnumLayout*
  %t148 = insertvalue %NativeEnum %t145, %NativeEnumLayout* %t147, 2
  %t149 = insertvalue %EnumParseResult undef, %NativeEnum* null, 0
  %t150 = load double, double* %l14
  %t151 = insertvalue %EnumParseResult %t149, double %t150, 1
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = insertvalue %EnumParseResult %t151, { i8**, i64 }* %t152, 2
  ret %EnumParseResult %t153
merge9:
  %t154 = load double, double* %l14
  %t155 = fptosi double %t154 to i64
  %t156 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t157 = extractvalue { i8**, i64 } %t156, 0
  %t158 = extractvalue { i8**, i64 } %t156, 1
  %t159 = icmp uge i64 %t155, %t158
  ; bounds check: %t159 (if true, out of bounds)
  %t160 = getelementptr i8*, i8** %t157, i64 %t155
  %t161 = load i8*, i8** %t160
  %t162 = call i8* @trim_text(i8* %t161)
  store i8* %t162, i8** %l16
  %t164 = load i8*, i8** %l16
  %t165 = call i64 @sailfin_runtime_string_length(i8* %t164)
  %t166 = icmp eq i64 %t165, 0
  br label %logical_or_entry_163

logical_or_entry_163:
  br i1 %t166, label %logical_or_merge_163, label %logical_or_right_163

logical_or_right_163:
  %t167 = load i8*, i8** %l16
  %t168 = alloca [2 x i8], align 1
  %t169 = getelementptr [2 x i8], [2 x i8]* %t168, i32 0, i32 0
  store i8 59, i8* %t169
  %t170 = getelementptr [2 x i8], [2 x i8]* %t168, i32 0, i32 1
  store i8 0, i8* %t170
  %t171 = getelementptr [2 x i8], [2 x i8]* %t168, i32 0, i32 0
  %t172 = call i1 @starts_with(i8* %t167, i8* %t171)
  br label %logical_or_right_end_163

logical_or_right_end_163:
  br label %logical_or_merge_163

logical_or_merge_163:
  %t173 = phi i1 [ true, %logical_or_entry_163 ], [ %t172, %logical_or_right_end_163 ]
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t175 = load i8*, i8** %l1
  %t176 = load i8*, i8** %l2
  %t177 = load i8*, i8** %l3
  %t178 = load double, double* %l4
  %t179 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t180 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t181 = load double, double* %l7
  %t182 = load double, double* %l8
  %t183 = load i8*, i8** %l9
  %t184 = load double, double* %l10
  %t185 = load double, double* %l11
  %t186 = load i1, i1* %l12
  %t187 = load i1, i1* %l13
  %t188 = load double, double* %l14
  %t189 = load i8*, i8** %l16
  br i1 %t173, label %then12, label %merge13
then12:
  %t190 = load double, double* %l14
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l14
  br label %loop.latch6
merge13:
  %t193 = load i8*, i8** %l16
  %s194 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.194, i32 0, i32 0
  %t195 = icmp eq i8* %t193, %s194
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l1
  %t198 = load i8*, i8** %l2
  %t199 = load i8*, i8** %l3
  %t200 = load double, double* %l4
  %t201 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t202 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t203 = load double, double* %l7
  %t204 = load double, double* %l8
  %t205 = load i8*, i8** %l9
  %t206 = load double, double* %l10
  %t207 = load double, double* %l11
  %t208 = load i1, i1* %l12
  %t209 = load i1, i1* %l13
  %t210 = load double, double* %l14
  %t211 = load i8*, i8** %l16
  br i1 %t195, label %then14, label %merge15
then14:
  %t212 = load double, double* %l14
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  store double %t214, double* %l14
  br label %loop.latch6
merge15:
  %t215 = load i8*, i8** %l16
  %s216 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.216, i32 0, i32 0
  %t217 = call i1 @starts_with(i8* %t215, i8* %s216)
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load i8*, i8** %l1
  %t220 = load i8*, i8** %l2
  %t221 = load i8*, i8** %l3
  %t222 = load double, double* %l4
  %t223 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t224 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t225 = load double, double* %l7
  %t226 = load double, double* %l8
  %t227 = load i8*, i8** %l9
  %t228 = load double, double* %l10
  %t229 = load double, double* %l11
  %t230 = load i1, i1* %l12
  %t231 = load i1, i1* %l13
  %t232 = load double, double* %l14
  %t233 = load i8*, i8** %l16
  br i1 %t217, label %then16, label %merge17
then16:
  %t234 = load i8*, i8** %l16
  %s235 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.235, i32 0, i32 0
  %t236 = call i8* @strip_prefix(i8* %t234, i8* %s235)
  store i8* %t236, i8** %l17
  %t237 = load i8*, i8** %l17
  %s238 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.238, i32 0, i32 0
  %t239 = call i1 @starts_with(i8* %t237, i8* %s238)
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t241 = load i8*, i8** %l1
  %t242 = load i8*, i8** %l2
  %t243 = load i8*, i8** %l3
  %t244 = load double, double* %l4
  %t245 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t246 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t247 = load double, double* %l7
  %t248 = load double, double* %l8
  %t249 = load i8*, i8** %l9
  %t250 = load double, double* %l10
  %t251 = load double, double* %l11
  %t252 = load i1, i1* %l12
  %t253 = load i1, i1* %l13
  %t254 = load double, double* %l14
  %t255 = load i8*, i8** %l16
  %t256 = load i8*, i8** %l17
  br i1 %t239, label %then18, label %merge19
then18:
  %t257 = load i8*, i8** %l17
  %s258 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.258, i32 0, i32 0
  %t259 = call i8* @strip_prefix(i8* %t257, i8* %s258)
  %t260 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t259)
  store %EnumLayoutHeaderParse %t260, %EnumLayoutHeaderParse* %l18
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t263 = extractvalue %EnumLayoutHeaderParse %t262, 7
  %t264 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t261, { i8**, i64 }* %t263)
  store { i8**, i64 }* %t264, { i8**, i64 }** %l0
  %t265 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t266 = extractvalue %EnumLayoutHeaderParse %t265, 0
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load i8*, i8** %l1
  %t269 = load i8*, i8** %l2
  %t270 = load i8*, i8** %l3
  %t271 = load double, double* %l4
  %t272 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t273 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t274 = load double, double* %l7
  %t275 = load double, double* %l8
  %t276 = load i8*, i8** %l9
  %t277 = load double, double* %l10
  %t278 = load double, double* %l11
  %t279 = load i1, i1* %l12
  %t280 = load i1, i1* %l13
  %t281 = load double, double* %l14
  %t282 = load i8*, i8** %l16
  %t283 = load i8*, i8** %l17
  %t284 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t266, label %then20, label %merge21
then20:
  %t285 = load i1, i1* %l12
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t287 = load i8*, i8** %l1
  %t288 = load i8*, i8** %l2
  %t289 = load i8*, i8** %l3
  %t290 = load double, double* %l4
  %t291 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t292 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t293 = load double, double* %l7
  %t294 = load double, double* %l8
  %t295 = load i8*, i8** %l9
  %t296 = load double, double* %l10
  %t297 = load double, double* %l11
  %t298 = load i1, i1* %l12
  %t299 = load i1, i1* %l13
  %t300 = load double, double* %l14
  %t301 = load i8*, i8** %l16
  %t302 = load i8*, i8** %l17
  %t303 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t285, label %then22, label %else23
then22:
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s305 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.305, i32 0, i32 0
  %t306 = load i8*, i8** %l3
  %t307 = add i8* %s305, %t306
  %t308 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t304, i8* %t307)
  store { i8**, i64 }* %t308, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t309 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t310 = extractvalue %EnumLayoutHeaderParse %t309, 2
  store double %t310, double* %l7
  %t311 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t312 = extractvalue %EnumLayoutHeaderParse %t311, 3
  store double %t312, double* %l8
  %t313 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t314 = extractvalue %EnumLayoutHeaderParse %t313, 4
  store i8* %t314, i8** %l9
  %t315 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t316 = extractvalue %EnumLayoutHeaderParse %t315, 5
  store double %t316, double* %l10
  %t317 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t318 = extractvalue %EnumLayoutHeaderParse %t317, 6
  store double %t318, double* %l11
  store i1 1, i1* %l12
  br label %merge24
merge24:
  %t319 = phi { i8**, i64 }* [ %t308, %then22 ], [ %t286, %else23 ]
  %t320 = phi double [ %t293, %then22 ], [ %t310, %else23 ]
  %t321 = phi double [ %t294, %then22 ], [ %t312, %else23 ]
  %t322 = phi i8* [ %t295, %then22 ], [ %t314, %else23 ]
  %t323 = phi double [ %t296, %then22 ], [ %t316, %else23 ]
  %t324 = phi double [ %t297, %then22 ], [ %t318, %else23 ]
  %t325 = phi i1 [ %t298, %then22 ], [ 1, %else23 ]
  store { i8**, i64 }* %t319, { i8**, i64 }** %l0
  store double %t320, double* %l7
  store double %t321, double* %l8
  store i8* %t322, i8** %l9
  store double %t323, double* %l10
  store double %t324, double* %l11
  store i1 %t325, i1* %l12
  br label %merge21
merge21:
  %t326 = phi { i8**, i64 }* [ %t308, %then20 ], [ %t267, %then18 ]
  %t327 = phi double [ %t310, %then20 ], [ %t274, %then18 ]
  %t328 = phi double [ %t312, %then20 ], [ %t275, %then18 ]
  %t329 = phi i8* [ %t314, %then20 ], [ %t276, %then18 ]
  %t330 = phi double [ %t316, %then20 ], [ %t277, %then18 ]
  %t331 = phi double [ %t318, %then20 ], [ %t278, %then18 ]
  %t332 = phi i1 [ 1, %then20 ], [ %t279, %then18 ]
  store { i8**, i64 }* %t326, { i8**, i64 }** %l0
  store double %t327, double* %l7
  store double %t328, double* %l8
  store i8* %t329, i8** %l9
  store double %t330, double* %l10
  store double %t331, double* %l11
  store i1 %t332, i1* %l12
  %t333 = load double, double* %l14
  %t334 = sitofp i64 1 to double
  %t335 = fadd double %t333, %t334
  store double %t335, double* %l14
  br label %loop.latch6
merge19:
  %t336 = load i8*, i8** %l17
  %s337 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.337, i32 0, i32 0
  %t338 = call i1 @starts_with(i8* %t336, i8* %s337)
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
  %t354 = load i8*, i8** %l16
  %t355 = load i8*, i8** %l17
  br i1 %t338, label %then25, label %merge26
then25:
  %t356 = load i8*, i8** %l17
  %s357 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.357, i32 0, i32 0
  %t358 = call i8* @strip_prefix(i8* %t356, i8* %s357)
  %t359 = load i8*, i8** %l3
  %t360 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t358, i8* %t359)
  store %EnumLayoutVariantParse %t360, %EnumLayoutVariantParse* %l19
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t362 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t363 = extractvalue %EnumLayoutVariantParse %t362, 2
  %t364 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t361, { i8**, i64 }* %t363)
  store { i8**, i64 }* %t364, { i8**, i64 }** %l0
  %t365 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t366 = extractvalue %EnumLayoutVariantParse %t365, 0
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
  br i1 %t366, label %then27, label %merge28
then27:
  %t385 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t386 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t387 = extractvalue %EnumLayoutVariantParse %t386, 1
  %t388 = extractvalue %NativeEnumVariantLayout %t387, 0
  %t389 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t385, i8* %t388)
  store double %t389, double* %l20
  %t390 = load double, double* %l20
  %t391 = sitofp i64 0 to double
  %t392 = fcmp oge double %t390, %t391
  %t393 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t394 = load i8*, i8** %l1
  %t395 = load i8*, i8** %l2
  %t396 = load i8*, i8** %l3
  %t397 = load double, double* %l4
  %t398 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t399 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t400 = load double, double* %l7
  %t401 = load double, double* %l8
  %t402 = load i8*, i8** %l9
  %t403 = load double, double* %l10
  %t404 = load double, double* %l11
  %t405 = load i1, i1* %l12
  %t406 = load i1, i1* %l13
  %t407 = load double, double* %l14
  %t408 = load i8*, i8** %l16
  %t409 = load i8*, i8** %l17
  %t410 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t411 = load double, double* %l20
  br i1 %t392, label %then29, label %else30
then29:
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s413 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.413, i32 0, i32 0
  %t414 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t415 = extractvalue %EnumLayoutVariantParse %t414, 1
  %t416 = extractvalue %NativeEnumVariantLayout %t415, 0
  %t417 = add i8* %s413, %t416
  %s418 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.418, i32 0, i32 0
  %t419 = add i8* %t417, %s418
  %t420 = load i8*, i8** %l3
  %t421 = add i8* %t419, %t420
  %t422 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t412, i8* %t421)
  store { i8**, i64 }* %t422, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t423 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t424 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t425 = extractvalue %EnumLayoutVariantParse %t424, 1
  %t426 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t423, %NativeEnumVariantLayout %t425)
  store { %NativeEnumVariantLayout*, i64 }* %t426, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t427 = phi { i8**, i64 }* [ %t422, %then29 ], [ %t393, %else30 ]
  %t428 = phi { %NativeEnumVariantLayout*, i64 }* [ %t399, %then29 ], [ %t426, %else30 ]
  store { i8**, i64 }* %t427, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t428, { %NativeEnumVariantLayout*, i64 }** %l6
  %t429 = load i1, i1* %l12
  %t430 = xor i1 %t429, 1
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t432 = load i8*, i8** %l1
  %t433 = load i8*, i8** %l2
  %t434 = load i8*, i8** %l3
  %t435 = load double, double* %l4
  %t436 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t437 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t438 = load double, double* %l7
  %t439 = load double, double* %l8
  %t440 = load i8*, i8** %l9
  %t441 = load double, double* %l10
  %t442 = load double, double* %l11
  %t443 = load i1, i1* %l12
  %t444 = load i1, i1* %l13
  %t445 = load double, double* %l14
  %t446 = load i8*, i8** %l16
  %t447 = load i8*, i8** %l17
  %t448 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t449 = load double, double* %l20
  br i1 %t430, label %then32, label %merge33
then32:
  %t450 = load i1, i1* %l13
  %t451 = xor i1 %t450, 1
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t453 = load i8*, i8** %l1
  %t454 = load i8*, i8** %l2
  %t455 = load i8*, i8** %l3
  %t456 = load double, double* %l4
  %t457 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t458 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t459 = load double, double* %l7
  %t460 = load double, double* %l8
  %t461 = load i8*, i8** %l9
  %t462 = load double, double* %l10
  %t463 = load double, double* %l11
  %t464 = load i1, i1* %l12
  %t465 = load i1, i1* %l13
  %t466 = load double, double* %l14
  %t467 = load i8*, i8** %l16
  %t468 = load i8*, i8** %l17
  %t469 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t470 = load double, double* %l20
  br i1 %t451, label %then34, label %merge35
then34:
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s472 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.472, i32 0, i32 0
  %t473 = load i8*, i8** %l3
  %t474 = add i8* %s472, %t473
  %s475 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.475, i32 0, i32 0
  %t476 = add i8* %t474, %s475
  %t477 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t471, i8* %t476)
  store { i8**, i64 }* %t477, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge35
merge35:
  %t478 = phi { i8**, i64 }* [ %t477, %then34 ], [ %t452, %then32 ]
  %t479 = phi i1 [ 1, %then34 ], [ %t465, %then32 ]
  store { i8**, i64 }* %t478, { i8**, i64 }** %l0
  store i1 %t479, i1* %l13
  br label %merge33
merge33:
  %t480 = phi { i8**, i64 }* [ %t477, %then32 ], [ %t431, %then27 ]
  %t481 = phi i1 [ 1, %then32 ], [ %t444, %then27 ]
  store { i8**, i64 }* %t480, { i8**, i64 }** %l0
  store i1 %t481, i1* %l13
  br label %merge28
merge28:
  %t482 = phi { i8**, i64 }* [ %t422, %then27 ], [ %t367, %then25 ]
  %t483 = phi { %NativeEnumVariantLayout*, i64 }* [ %t426, %then27 ], [ %t373, %then25 ]
  %t484 = phi { i8**, i64 }* [ %t477, %then27 ], [ %t367, %then25 ]
  %t485 = phi i1 [ 1, %then27 ], [ %t380, %then25 ]
  store { i8**, i64 }* %t482, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t483, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t484, { i8**, i64 }** %l0
  store i1 %t485, i1* %l13
  %t486 = load double, double* %l14
  %t487 = sitofp i64 1 to double
  %t488 = fadd double %t486, %t487
  store double %t488, double* %l14
  br label %loop.latch6
merge26:
  %t489 = load i8*, i8** %l17
  %s490 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.490, i32 0, i32 0
  %t491 = call i1 @starts_with(i8* %t489, i8* %s490)
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t493 = load i8*, i8** %l1
  %t494 = load i8*, i8** %l2
  %t495 = load i8*, i8** %l3
  %t496 = load double, double* %l4
  %t497 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t498 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t499 = load double, double* %l7
  %t500 = load double, double* %l8
  %t501 = load i8*, i8** %l9
  %t502 = load double, double* %l10
  %t503 = load double, double* %l11
  %t504 = load i1, i1* %l12
  %t505 = load i1, i1* %l13
  %t506 = load double, double* %l14
  %t507 = load i8*, i8** %l16
  %t508 = load i8*, i8** %l17
  br i1 %t491, label %then36, label %merge37
then36:
  %t509 = load i8*, i8** %l17
  %s510 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.510, i32 0, i32 0
  %t511 = call i8* @strip_prefix(i8* %t509, i8* %s510)
  %t512 = load i8*, i8** %l3
  %t513 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t511, i8* %t512)
  store %EnumLayoutPayloadParse %t513, %EnumLayoutPayloadParse* %l21
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t515 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t516 = extractvalue %EnumLayoutPayloadParse %t515, 3
  %t517 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t514, { i8**, i64 }* %t516)
  store { i8**, i64 }* %t517, { i8**, i64 }** %l0
  %t518 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t519 = extractvalue %EnumLayoutPayloadParse %t518, 0
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t521 = load i8*, i8** %l1
  %t522 = load i8*, i8** %l2
  %t523 = load i8*, i8** %l3
  %t524 = load double, double* %l4
  %t525 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t526 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t527 = load double, double* %l7
  %t528 = load double, double* %l8
  %t529 = load i8*, i8** %l9
  %t530 = load double, double* %l10
  %t531 = load double, double* %l11
  %t532 = load i1, i1* %l12
  %t533 = load i1, i1* %l13
  %t534 = load double, double* %l14
  %t535 = load i8*, i8** %l16
  %t536 = load i8*, i8** %l17
  %t537 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t519, label %then38, label %merge39
then38:
  %t538 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t539 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t540 = extractvalue %EnumLayoutPayloadParse %t539, 1
  %t541 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t538, i8* %t540)
  store double %t541, double* %l22
  %t542 = load double, double* %l22
  %t543 = sitofp i64 0 to double
  %t544 = fcmp olt double %t542, %t543
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t546 = load i8*, i8** %l1
  %t547 = load i8*, i8** %l2
  %t548 = load i8*, i8** %l3
  %t549 = load double, double* %l4
  %t550 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t551 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t552 = load double, double* %l7
  %t553 = load double, double* %l8
  %t554 = load i8*, i8** %l9
  %t555 = load double, double* %l10
  %t556 = load double, double* %l11
  %t557 = load i1, i1* %l12
  %t558 = load i1, i1* %l13
  %t559 = load double, double* %l14
  %t560 = load i8*, i8** %l16
  %t561 = load i8*, i8** %l17
  %t562 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t563 = load double, double* %l22
  br i1 %t544, label %then40, label %else41
then40:
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s565 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.565, i32 0, i32 0
  %t566 = load i8*, i8** %l3
  %t567 = add i8* %s565, %t566
  %s568 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.568, i32 0, i32 0
  %t569 = add i8* %t567, %s568
  %t570 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t571 = extractvalue %EnumLayoutPayloadParse %t570, 1
  %t572 = add i8* %t569, %t571
  %t573 = load i8, i8* %t572
  %t574 = add i8 %t573, 96
  %t575 = alloca [2 x i8], align 1
  %t576 = getelementptr [2 x i8], [2 x i8]* %t575, i32 0, i32 0
  store i8 %t574, i8* %t576
  %t577 = getelementptr [2 x i8], [2 x i8]* %t575, i32 0, i32 1
  store i8 0, i8* %t577
  %t578 = getelementptr [2 x i8], [2 x i8]* %t575, i32 0, i32 0
  %t579 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t564, i8* %t578)
  store { i8**, i64 }* %t579, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t580 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t581 = load double, double* %l22
  %t582 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t583 = extractvalue %EnumLayoutPayloadParse %t582, 2
  %t584 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t580, double %t581, %NativeStructLayoutField %t583)
  store { %NativeEnumVariantLayout*, i64 }* %t584, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t585 = phi { i8**, i64 }* [ %t579, %then40 ], [ %t545, %else41 ]
  %t586 = phi { %NativeEnumVariantLayout*, i64 }* [ %t551, %then40 ], [ %t584, %else41 ]
  store { i8**, i64 }* %t585, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t586, { %NativeEnumVariantLayout*, i64 }** %l6
  %t587 = load i1, i1* %l12
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
  br i1 %t588, label %then43, label %merge44
then43:
  %t608 = load i1, i1* %l13
  %t609 = xor i1 %t608, 1
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t611 = load i8*, i8** %l1
  %t612 = load i8*, i8** %l2
  %t613 = load i8*, i8** %l3
  %t614 = load double, double* %l4
  %t615 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t616 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t617 = load double, double* %l7
  %t618 = load double, double* %l8
  %t619 = load i8*, i8** %l9
  %t620 = load double, double* %l10
  %t621 = load double, double* %l11
  %t622 = load i1, i1* %l12
  %t623 = load i1, i1* %l13
  %t624 = load double, double* %l14
  %t625 = load i8*, i8** %l16
  %t626 = load i8*, i8** %l17
  %t627 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t628 = load double, double* %l22
  br i1 %t609, label %then45, label %merge46
then45:
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s630 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.630, i32 0, i32 0
  %t631 = load i8*, i8** %l3
  %t632 = add i8* %s630, %t631
  %s633 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.633, i32 0, i32 0
  %t634 = add i8* %t632, %s633
  %t635 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t629, i8* %t634)
  store { i8**, i64 }* %t635, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge46
merge46:
  %t636 = phi { i8**, i64 }* [ %t635, %then45 ], [ %t610, %then43 ]
  %t637 = phi i1 [ 1, %then45 ], [ %t623, %then43 ]
  store { i8**, i64 }* %t636, { i8**, i64 }** %l0
  store i1 %t637, i1* %l13
  br label %merge44
merge44:
  %t638 = phi { i8**, i64 }* [ %t635, %then43 ], [ %t589, %then38 ]
  %t639 = phi i1 [ 1, %then43 ], [ %t602, %then38 ]
  store { i8**, i64 }* %t638, { i8**, i64 }** %l0
  store i1 %t639, i1* %l13
  br label %merge39
merge39:
  %t640 = phi { i8**, i64 }* [ %t579, %then38 ], [ %t520, %then36 ]
  %t641 = phi { %NativeEnumVariantLayout*, i64 }* [ %t584, %then38 ], [ %t526, %then36 ]
  %t642 = phi { i8**, i64 }* [ %t635, %then38 ], [ %t520, %then36 ]
  %t643 = phi i1 [ 1, %then38 ], [ %t533, %then36 ]
  store { i8**, i64 }* %t640, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t641, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  store i1 %t643, i1* %l13
  %t644 = load double, double* %l14
  %t645 = sitofp i64 1 to double
  %t646 = fadd double %t644, %t645
  store double %t646, double* %l14
  br label %loop.latch6
merge37:
  %t647 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s648 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.648, i32 0, i32 0
  %t649 = load i8*, i8** %l16
  %t650 = add i8* %s648, %t649
  %t651 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t647, i8* %t650)
  store { i8**, i64 }* %t651, { i8**, i64 }** %l0
  %t652 = load double, double* %l14
  %t653 = sitofp i64 1 to double
  %t654 = fadd double %t652, %t653
  store double %t654, double* %l14
  br label %loop.latch6
merge17:
  %t655 = load i8*, i8** %l16
  %s656 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.656, i32 0, i32 0
  %t657 = icmp eq i8* %t655, %s656
  %t658 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t659 = load i8*, i8** %l1
  %t660 = load i8*, i8** %l2
  %t661 = load i8*, i8** %l3
  %t662 = load double, double* %l4
  %t663 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t664 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t665 = load double, double* %l7
  %t666 = load double, double* %l8
  %t667 = load i8*, i8** %l9
  %t668 = load double, double* %l10
  %t669 = load double, double* %l11
  %t670 = load i1, i1* %l12
  %t671 = load i1, i1* %l13
  %t672 = load double, double* %l14
  %t673 = load i8*, i8** %l16
  br i1 %t657, label %then47, label %merge48
then47:
  %t674 = load double, double* %l14
  %t675 = sitofp i64 1 to double
  %t676 = fadd double %t674, %t675
  store double %t676, double* %l14
  br label %afterloop7
merge48:
  %t677 = load i8*, i8** %l16
  %s678 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.678, i32 0, i32 0
  %t679 = call i1 @starts_with(i8* %t677, i8* %s678)
  %t680 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t681 = load i8*, i8** %l1
  %t682 = load i8*, i8** %l2
  %t683 = load i8*, i8** %l3
  %t684 = load double, double* %l4
  %t685 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t686 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t687 = load double, double* %l7
  %t688 = load double, double* %l8
  %t689 = load i8*, i8** %l9
  %t690 = load double, double* %l10
  %t691 = load double, double* %l11
  %t692 = load i1, i1* %l12
  %t693 = load i1, i1* %l13
  %t694 = load double, double* %l14
  %t695 = load i8*, i8** %l16
  br i1 %t679, label %then49, label %merge50
then49:
  %t696 = load i8*, i8** %l16
  %s697 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.697, i32 0, i32 0
  %t698 = call i8* @strip_prefix(i8* %t696, i8* %s697)
  %t699 = call double @parse_enum_variant_line(i8* %t698)
  store double %t699, double* %l23
  %t700 = load double, double* %l23
  %t701 = load double, double* %l14
  %t702 = sitofp i64 1 to double
  %t703 = fadd double %t701, %t702
  store double %t703, double* %l14
  br label %loop.latch6
merge50:
  %t704 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s705 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.705, i32 0, i32 0
  %t706 = load i8*, i8** %l16
  %t707 = add i8* %s705, %t706
  %t708 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t704, i8* %t707)
  store { i8**, i64 }* %t708, { i8**, i64 }** %l0
  %t709 = load double, double* %l14
  %t710 = sitofp i64 1 to double
  %t711 = fadd double %t709, %t710
  store double %t711, double* %l14
  br label %loop.latch6
loop.latch6:
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t713 = load double, double* %l14
  %t714 = load double, double* %l7
  %t715 = load double, double* %l8
  %t716 = load i8*, i8** %l9
  %t717 = load double, double* %l10
  %t718 = load double, double* %l11
  %t719 = load i1, i1* %l12
  %t720 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t721 = load i1, i1* %l13
  br label %loop.header4
afterloop7:
  store i8* null, i8** %l24
  %t732 = load i1, i1* %l12
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t734 = load i8*, i8** %l1
  %t735 = load i8*, i8** %l2
  %t736 = load i8*, i8** %l3
  %t737 = load double, double* %l4
  %t738 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t739 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t740 = load double, double* %l7
  %t741 = load double, double* %l8
  %t742 = load i8*, i8** %l9
  %t743 = load double, double* %l10
  %t744 = load double, double* %l11
  %t745 = load i1, i1* %l12
  %t746 = load i1, i1* %l13
  %t747 = load double, double* %l14
  %t748 = load i8*, i8** %l24
  br i1 %t732, label %then51, label %merge52
then51:
  %t749 = load double, double* %l7
  %t750 = insertvalue %NativeEnumLayout undef, double %t749, 0
  %t751 = load double, double* %l8
  %t752 = insertvalue %NativeEnumLayout %t750, double %t751, 1
  %t753 = load i8*, i8** %l9
  %t754 = insertvalue %NativeEnumLayout %t752, i8* %t753, 2
  %t755 = load double, double* %l10
  %t756 = insertvalue %NativeEnumLayout %t754, double %t755, 3
  %t757 = load double, double* %l11
  %t758 = insertvalue %NativeEnumLayout %t756, double %t757, 4
  %t759 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t760 = bitcast { %NativeEnumVariantLayout*, i64 }* %t759 to { %NativeEnumVariantLayout**, i64 }*
  %t761 = insertvalue %NativeEnumLayout %t758, { %NativeEnumVariantLayout**, i64 }* %t760, 5
  store i8* null, i8** %l24
  br label %merge52
merge52:
  %t762 = phi i8* [ null, %then51 ], [ %t748, %entry ]
  store i8* %t762, i8** %l24
  %t763 = load i8*, i8** %l3
  %t764 = insertvalue %NativeEnum undef, i8* %t763, 0
  %t765 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t766 = bitcast { %NativeEnumVariant*, i64 }* %t765 to { %NativeEnumVariant**, i64 }*
  %t767 = insertvalue %NativeEnum %t764, { %NativeEnumVariant**, i64 }* %t766, 1
  %t768 = load i8*, i8** %l24
  %t769 = bitcast i8* %t768 to %NativeEnumLayout*
  %t770 = insertvalue %NativeEnum %t767, %NativeEnumLayout* %t769, 2
  %t771 = insertvalue %EnumParseResult undef, %NativeEnum* null, 0
  %t772 = load double, double* %l14
  %t773 = insertvalue %EnumParseResult %t771, double %t772, 1
  %t774 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t775 = insertvalue %EnumParseResult %t773, { i8**, i64 }* %t774, 2
  ret %EnumParseResult %t775
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
  %t104 = phi double [ %t10, %entry ], [ %t100, %loop.latch2 ]
  %t105 = phi { i8**, i64 }* [ %t8, %entry ], [ %t101, %loop.latch2 ]
  %t106 = phi i8* [ %t9, %entry ], [ %t102, %loop.latch2 ]
  %t107 = phi double [ %t11, %entry ], [ %t103, %loop.latch2 ]
  store double %t104, double* %l2
  store { i8**, i64 }* %t105, { i8**, i64 }** %l0
  store i8* %t106, i8** %l1
  store double %t107, double* %l3
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
  %t25 = load i8, i8* %l4
  %t26 = icmp eq i8 %t25, 123
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t26, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t28 = load i8, i8* %l4
  %t29 = icmp eq i8 %t28, 91
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t29, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t30 = load i8, i8* %l4
  %t31 = icmp eq i8 %t30, 40
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t32 = phi i1 [ true, %logical_or_entry_27 ], [ %t31, %logical_or_right_end_27 ]
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
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 125
  br label %logical_or_entry_42

logical_or_entry_42:
  br i1 %t44, label %logical_or_merge_42, label %logical_or_right_42

logical_or_right_42:
  %t46 = load i8, i8* %l4
  %t47 = icmp eq i8 %t46, 93
  br label %logical_or_entry_45

logical_or_entry_45:
  br i1 %t47, label %logical_or_merge_45, label %logical_or_right_45

logical_or_right_45:
  %t48 = load i8, i8* %l4
  %t49 = icmp eq i8 %t48, 41
  br label %logical_or_right_end_45

logical_or_right_end_45:
  br label %logical_or_merge_45

logical_or_merge_45:
  %t50 = phi i1 [ true, %logical_or_entry_45 ], [ %t49, %logical_or_right_end_45 ]
  br label %logical_or_right_end_42

logical_or_right_end_42:
  br label %logical_or_merge_42

logical_or_merge_42:
  %t51 = phi i1 [ true, %logical_or_entry_42 ], [ %t50, %logical_or_right_end_42 ]
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load i8, i8* %l4
  br i1 %t51, label %then9, label %merge10
then9:
  %t57 = load double, double* %l2
  %t58 = sitofp i64 0 to double
  %t59 = fcmp ogt double %t57, %t58
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  %t63 = load double, double* %l3
  %t64 = load i8, i8* %l4
  br i1 %t59, label %then11, label %merge12
then11:
  %t65 = load double, double* %l2
  %t66 = sitofp i64 1 to double
  %t67 = fsub double %t65, %t66
  store double %t67, double* %l2
  br label %merge12
merge12:
  %t68 = phi double [ %t67, %then11 ], [ %t62, %then9 ]
  store double %t68, double* %l2
  br label %merge10
merge10:
  %t69 = phi double [ %t67, %then9 ], [ %t54, %else7 ]
  store double %t69, double* %l2
  br label %merge8
merge8:
  %t70 = phi double [ %t41, %then6 ], [ %t67, %else7 ]
  store double %t70, double* %l2
  %t72 = load i8, i8* %l4
  %t73 = icmp eq i8 %t72, 59
  br label %logical_and_entry_71

logical_and_entry_71:
  br i1 %t73, label %logical_and_right_71, label %logical_and_merge_71

logical_and_right_71:
  %t74 = load double, double* %l2
  %t75 = sitofp i64 0 to double
  %t76 = fcmp oeq double %t74, %t75
  br label %logical_and_right_end_71

logical_and_right_end_71:
  br label %logical_and_merge_71

logical_and_merge_71:
  %t77 = phi i1 [ false, %logical_and_entry_71 ], [ %t76, %logical_and_right_end_71 ]
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l2
  %t81 = load double, double* %l3
  %t82 = load i8, i8* %l4
  br i1 %t77, label %then13, label %else14
then13:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load i8*, i8** %l1
  %t85 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t83, i8* %t84)
  store { i8**, i64 }* %t85, { i8**, i64 }** %l0
  %s86 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.86, i32 0, i32 0
  store i8* %s86, i8** %l1
  br label %merge15
else14:
  %t87 = load i8*, i8** %l1
  %t88 = load i8, i8* %l4
  %t89 = load i8, i8* %t87
  %t90 = add i8 %t89, %t88
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 %t90, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8* %t94, i8** %l1
  br label %merge15
merge15:
  %t95 = phi { i8**, i64 }* [ %t85, %then13 ], [ %t78, %else14 ]
  %t96 = phi i8* [ %s86, %then13 ], [ %t94, %else14 ]
  store { i8**, i64 }* %t95, { i8**, i64 }** %l0
  store i8* %t96, i8** %l1
  %t97 = load double, double* %l3
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l3
  br label %loop.latch2
loop.latch2:
  %t100 = load double, double* %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  %t103 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t108 = load i8*, i8** %l1
  %t109 = call i64 @sailfin_runtime_string_length(i8* %t108)
  %t110 = icmp sgt i64 %t109, 0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load double, double* %l3
  br i1 %t110, label %then16, label %merge17
then16:
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load i8*, i8** %l1
  %t117 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t115, i8* %t116)
  store { i8**, i64 }* %t117, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t118 = phi { i8**, i64 }* [ %t117, %then16 ], [ %t111, %entry ]
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t119
}

define i8* @text_char_at(i8* %value, double %index) {
entry:
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %index, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge3:
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %index, %t7
  %t9 = fptosi double %index to i64
  %t10 = fptosi double %t8 to i64
  %t11 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t9, i64 %t10)
  ret i8* %t11
}

define i8* @trim_trailing_delimiters(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t2, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
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
  %t7 = load double, double* %l0
  %t8 = sitofp i64 1 to double
  %t9 = fsub double %t7, %t8
  %t10 = call i8* @text_char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l1
  %t12 = load i8*, i8** %l1
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 44
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t15 = load i8*, i8** %l1
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 59
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t18 = phi i1 [ true, %logical_or_entry_11 ], [ %t17, %logical_or_right_end_11 ]
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t24 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oeq double %t26, %t28
  %t30 = load double, double* %l0
  br i1 %t29, label %then8, label %merge9
then8:
  ret i8* %text
merge9:
  %t31 = load double, double* %l0
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t32)
  ret i8* %t33
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
  %t214 = phi i8* [ %t34, %entry ], [ %t206, %loop.latch4 ]
  %t215 = phi i1 [ %t31, %entry ], [ %t207, %loop.latch4 ]
  %t216 = phi i1 [ %t32, %entry ], [ %t208, %loop.latch4 ]
  %t217 = phi double [ %t35, %entry ], [ %t209, %loop.latch4 ]
  %t218 = phi { i8**, i64 }* [ %t30, %entry ], [ %t210, %loop.latch4 ]
  %t219 = phi i1 [ %t33, %entry ], [ %t211, %loop.latch4 ]
  %t220 = phi double [ %t36, %entry ], [ %t212, %loop.latch4 ]
  %t221 = phi double [ %t37, %entry ], [ %t213, %loop.latch4 ]
  store i8* %t214, i8** %l5
  store i1 %t215, i1* %l2
  store i1 %t216, i1* %l3
  store double %t217, double* %l6
  store { i8**, i64 }* %t218, { i8**, i64 }** %l1
  store i1 %t219, i1* %l4
  store double %t220, double* %l7
  store double %t221, double* %l8
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
  %t118 = load i8, i8* %t117
  %t119 = add i8 %t118, 96
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 %t119, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  %t124 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t114, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t125 = phi i1 [ 1, %then14 ], [ %t103, %else15 ]
  %t126 = phi double [ %t113, %then14 ], [ %t106, %else15 ]
  %t127 = phi { i8**, i64 }* [ %t101, %then14 ], [ %t124, %else15 ]
  store i1 %t125, i1* %l3
  store double %t126, double* %l6
  store { i8**, i64 }* %t127, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t128 = load i8*, i8** %l9
  %s129 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.129, i32 0, i32 0
  %t130 = call i1 @starts_with(i8* %t128, i8* %s129)
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load i1, i1* %l2
  %t134 = load i1, i1* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load double, double* %l6
  %t138 = load double, double* %l7
  %t139 = load double, double* %l8
  %t140 = load i8*, i8** %l9
  br i1 %t130, label %then17, label %else18
then17:
  %t141 = load i8*, i8** %l9
  %t142 = load i8*, i8** %l9
  %t143 = call i64 @sailfin_runtime_string_length(i8* %t142)
  %t144 = call i8* @sailfin_runtime_substring(i8* %t141, i64 6, i64 %t143)
  store i8* %t144, i8** %l12
  %t145 = load i8*, i8** %l12
  %t146 = call %NumberParseResult @parse_decimal_number(i8* %t145)
  store %NumberParseResult %t146, %NumberParseResult* %l13
  %t147 = load %NumberParseResult, %NumberParseResult* %l13
  %t148 = extractvalue %NumberParseResult %t147, 0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t151 = load i1, i1* %l2
  %t152 = load i1, i1* %l3
  %t153 = load i1, i1* %l4
  %t154 = load i8*, i8** %l5
  %t155 = load double, double* %l6
  %t156 = load double, double* %l7
  %t157 = load double, double* %l8
  %t158 = load i8*, i8** %l9
  %t159 = load i8*, i8** %l12
  %t160 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t148, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t161 = load %NumberParseResult, %NumberParseResult* %l13
  %t162 = extractvalue %NumberParseResult %t161, 1
  store double %t162, double* %l7
  br label %merge22
else21:
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s164 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.164, i32 0, i32 0
  %t165 = load i8*, i8** %l12
  %t166 = add i8* %s164, %t165
  %t167 = load i8, i8* %t166
  %t168 = add i8 %t167, 96
  %t169 = alloca [2 x i8], align 1
  %t170 = getelementptr [2 x i8], [2 x i8]* %t169, i32 0, i32 0
  store i8 %t168, i8* %t170
  %t171 = getelementptr [2 x i8], [2 x i8]* %t169, i32 0, i32 1
  store i8 0, i8* %t171
  %t172 = getelementptr [2 x i8], [2 x i8]* %t169, i32 0, i32 0
  %t173 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t163, i8* %t172)
  store { i8**, i64 }* %t173, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t174 = phi i1 [ 1, %then20 ], [ %t153, %else21 ]
  %t175 = phi double [ %t162, %then20 ], [ %t156, %else21 ]
  %t176 = phi { i8**, i64 }* [ %t150, %then20 ], [ %t173, %else21 ]
  store i1 %t174, i1* %l4
  store double %t175, double* %l7
  store { i8**, i64 }* %t176, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s178 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.178, i32 0, i32 0
  %t179 = load i8*, i8** %l9
  %t180 = add i8* %s178, %t179
  %t181 = load i8, i8* %t180
  %t182 = add i8 %t181, 96
  %t183 = alloca [2 x i8], align 1
  %t184 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  store i8 %t182, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 1
  store i8 0, i8* %t185
  %t186 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  %t187 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t177, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t188 = phi i1 [ 1, %then17 ], [ %t135, %else18 ]
  %t189 = phi double [ %t162, %then17 ], [ %t138, %else18 ]
  %t190 = phi { i8**, i64 }* [ %t173, %then17 ], [ %t187, %else18 ]
  store i1 %t188, i1* %l4
  store double %t189, double* %l7
  store { i8**, i64 }* %t190, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t191 = phi i1 [ 1, %then11 ], [ %t85, %else12 ]
  %t192 = phi double [ %t113, %then11 ], [ %t88, %else12 ]
  %t193 = phi { i8**, i64 }* [ %t124, %then11 ], [ %t173, %else12 ]
  %t194 = phi i1 [ %t86, %then11 ], [ 1, %else12 ]
  %t195 = phi double [ %t89, %then11 ], [ %t162, %else12 ]
  store i1 %t191, i1* %l3
  store double %t192, double* %l6
  store { i8**, i64 }* %t193, { i8**, i64 }** %l1
  store i1 %t194, i1* %l4
  store double %t195, double* %l7
  br label %merge10
merge10:
  %t196 = phi i8* [ %t78, %then8 ], [ %t70, %else9 ]
  %t197 = phi i1 [ 1, %then8 ], [ %t67, %else9 ]
  %t198 = phi i1 [ %t68, %then8 ], [ 1, %else9 ]
  %t199 = phi double [ %t71, %then8 ], [ %t113, %else9 ]
  %t200 = phi { i8**, i64 }* [ %t66, %then8 ], [ %t124, %else9 ]
  %t201 = phi i1 [ %t69, %then8 ], [ 1, %else9 ]
  %t202 = phi double [ %t72, %then8 ], [ %t162, %else9 ]
  store i8* %t196, i8** %l5
  store i1 %t197, i1* %l2
  store i1 %t198, i1* %l3
  store double %t199, double* %l6
  store { i8**, i64 }* %t200, { i8**, i64 }** %l1
  store i1 %t201, i1* %l4
  store double %t202, double* %l7
  %t203 = load double, double* %l8
  %t204 = sitofp i64 1 to double
  %t205 = fadd double %t203, %t204
  store double %t205, double* %l8
  br label %loop.latch4
loop.latch4:
  %t206 = load i8*, i8** %l5
  %t207 = load i1, i1* %l2
  %t208 = load i1, i1* %l3
  %t209 = load double, double* %l6
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t211 = load i1, i1* %l4
  %t212 = load double, double* %l7
  %t213 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t222 = load i1, i1* %l3
  %t223 = xor i1 %t222, 1
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t226 = load i1, i1* %l2
  %t227 = load i1, i1* %l3
  %t228 = load i1, i1* %l4
  %t229 = load i8*, i8** %l5
  %t230 = load double, double* %l6
  %t231 = load double, double* %l7
  %t232 = load double, double* %l8
  br i1 %t223, label %then23, label %merge24
then23:
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s234 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.234, i32 0, i32 0
  %t235 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t233, i8* %s234)
  store { i8**, i64 }* %t235, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t236 = phi { i8**, i64 }* [ %t235, %then23 ], [ %t225, %entry ]
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  %t237 = load i1, i1* %l4
  %t238 = xor i1 %t237, 1
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t241 = load i1, i1* %l2
  %t242 = load i1, i1* %l3
  %t243 = load i1, i1* %l4
  %t244 = load i8*, i8** %l5
  %t245 = load double, double* %l6
  %t246 = load double, double* %l7
  %t247 = load double, double* %l8
  br i1 %t238, label %then25, label %merge26
then25:
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s249 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.249, i32 0, i32 0
  %t250 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t248, i8* %s249)
  store { i8**, i64 }* %t250, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t251 = phi { i8**, i64 }* [ %t250, %then25 ], [ %t240, %entry ]
  store { i8**, i64 }* %t251, { i8**, i64 }** %l1
  %t253 = load i1, i1* %l3
  br label %logical_and_entry_252

logical_and_entry_252:
  br i1 %t253, label %logical_and_right_252, label %logical_and_merge_252

logical_and_right_252:
  %t255 = load i1, i1* %l4
  br label %logical_and_entry_254

logical_and_entry_254:
  br i1 %t255, label %logical_and_right_254, label %logical_and_merge_254

logical_and_right_254:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t257 = load { i8**, i64 }, { i8**, i64 }* %t256
  %t258 = extractvalue { i8**, i64 } %t257, 1
  %t259 = icmp eq i64 %t258, 0
  br label %logical_and_right_end_254

logical_and_right_end_254:
  br label %logical_and_merge_254

logical_and_merge_254:
  %t260 = phi i1 [ false, %logical_and_entry_254 ], [ %t259, %logical_and_right_end_254 ]
  br label %logical_and_right_end_252

logical_and_right_end_252:
  br label %logical_and_merge_252

logical_and_merge_252:
  %t261 = phi i1 [ false, %logical_and_entry_252 ], [ %t260, %logical_and_right_end_252 ]
  store i1 %t261, i1* %l14
  %t262 = load i1, i1* %l14
  %t263 = insertvalue %StructLayoutHeaderParse undef, i1 %t262, 0
  %t264 = load i8*, i8** %l5
  %t265 = insertvalue %StructLayoutHeaderParse %t263, i8* %t264, 1
  %t266 = load double, double* %l6
  %t267 = insertvalue %StructLayoutHeaderParse %t265, double %t266, 2
  %t268 = load double, double* %l7
  %t269 = insertvalue %StructLayoutHeaderParse %t267, double %t268, 3
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = insertvalue %StructLayoutHeaderParse %t269, { i8**, i64 }* %t270, 4
  ret %StructLayoutHeaderParse %t271
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
  %t30 = insertvalue %StructLayoutFieldParse %t28, %NativeStructLayoutField %t29, 1
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
  %t51 = insertvalue %StructLayoutFieldParse %t49, %NativeStructLayoutField %t50, 1
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
  %t77 = insertvalue %StructLayoutFieldParse %t75, %NativeStructLayoutField %t76, 1
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
  %t392 = phi i8* [ %t90, %entry ], [ %t383, %loop.latch8 ]
  %t393 = phi i1 [ %t91, %entry ], [ %t384, %loop.latch8 ]
  %t394 = phi double [ %t94, %entry ], [ %t385, %loop.latch8 ]
  %t395 = phi { i8**, i64 }* [ %t86, %entry ], [ %t386, %loop.latch8 ]
  %t396 = phi i1 [ %t92, %entry ], [ %t387, %loop.latch8 ]
  %t397 = phi double [ %t95, %entry ], [ %t388, %loop.latch8 ]
  %t398 = phi i1 [ %t93, %entry ], [ %t389, %loop.latch8 ]
  %t399 = phi double [ %t96, %entry ], [ %t390, %loop.latch8 ]
  %t400 = phi double [ %t97, %entry ], [ %t391, %loop.latch8 ]
  store i8* %t392, i8** %l5
  store i1 %t393, i1* %l6
  store double %t394, double* %l9
  store { i8**, i64 }* %t395, { i8**, i64 }** %l1
  store i1 %t396, i1* %l7
  store double %t397, double* %l10
  store i1 %t398, i1* %l8
  store double %t399, double* %l11
  store double %t400, double* %l12
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
  %t201 = load i8, i8* %t200
  %t202 = add i8 %t201, 96
  %t203 = alloca [2 x i8], align 1
  %t204 = getelementptr [2 x i8], [2 x i8]* %t203, i32 0, i32 0
  store i8 %t202, i8* %t204
  %t205 = getelementptr [2 x i8], [2 x i8]* %t203, i32 0, i32 1
  store i8 0, i8* %t205
  %t206 = getelementptr [2 x i8], [2 x i8]* %t203, i32 0, i32 0
  %t207 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* %t206)
  store { i8**, i64 }* %t207, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t208 = phi i1 [ 1, %then18 ], [ %t178, %else19 ]
  %t209 = phi double [ %t189, %then18 ], [ %t181, %else19 ]
  %t210 = phi { i8**, i64 }* [ %t173, %then18 ], [ %t207, %else19 ]
  store i1 %t208, i1* %l6
  store double %t209, double* %l9
  store { i8**, i64 }* %t210, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t211 = load i8*, i8** %l13
  %s212 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.212, i32 0, i32 0
  %t213 = call i1 @starts_with(i8* %t211, i8* %s212)
  %t214 = load i8*, i8** %l0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t216 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t218 = load i8*, i8** %l4
  %t219 = load i8*, i8** %l5
  %t220 = load i1, i1* %l6
  %t221 = load i1, i1* %l7
  %t222 = load i1, i1* %l8
  %t223 = load double, double* %l9
  %t224 = load double, double* %l10
  %t225 = load double, double* %l11
  %t226 = load double, double* %l12
  %t227 = load i8*, i8** %l13
  br i1 %t213, label %then21, label %else22
then21:
  %t228 = load i8*, i8** %l13
  %t229 = load i8*, i8** %l13
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = call i8* @sailfin_runtime_substring(i8* %t228, i64 5, i64 %t230)
  store i8* %t231, i8** %l16
  %t232 = load i8*, i8** %l16
  %t233 = call %NumberParseResult @parse_decimal_number(i8* %t232)
  store %NumberParseResult %t233, %NumberParseResult* %l17
  %t234 = load %NumberParseResult, %NumberParseResult* %l17
  %t235 = extractvalue %NumberParseResult %t234, 0
  %t236 = load i8*, i8** %l0
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t238 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t240 = load i8*, i8** %l4
  %t241 = load i8*, i8** %l5
  %t242 = load i1, i1* %l6
  %t243 = load i1, i1* %l7
  %t244 = load i1, i1* %l8
  %t245 = load double, double* %l9
  %t246 = load double, double* %l10
  %t247 = load double, double* %l11
  %t248 = load double, double* %l12
  %t249 = load i8*, i8** %l13
  %t250 = load i8*, i8** %l16
  %t251 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t235, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t252 = load %NumberParseResult, %NumberParseResult* %l17
  %t253 = extractvalue %NumberParseResult %t252, 1
  store double %t253, double* %l10
  br label %merge26
else25:
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s255 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.255, i32 0, i32 0
  %t256 = add i8* %s255, %struct_name
  %s257 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.257, i32 0, i32 0
  %t258 = add i8* %t256, %s257
  %t259 = load i8*, i8** %l4
  %t260 = add i8* %t258, %t259
  %s261 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.261, i32 0, i32 0
  %t262 = add i8* %t260, %s261
  %t263 = load i8*, i8** %l16
  %t264 = add i8* %t262, %t263
  %t265 = load i8, i8* %t264
  %t266 = add i8 %t265, 96
  %t267 = alloca [2 x i8], align 1
  %t268 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  store i8 %t266, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 1
  store i8 0, i8* %t269
  %t270 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  %t271 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t254, i8* %t270)
  store { i8**, i64 }* %t271, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t272 = phi i1 [ 1, %then24 ], [ %t243, %else25 ]
  %t273 = phi double [ %t253, %then24 ], [ %t246, %else25 ]
  %t274 = phi { i8**, i64 }* [ %t237, %then24 ], [ %t271, %else25 ]
  store i1 %t272, i1* %l7
  store double %t273, double* %l10
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t275 = load i8*, i8** %l13
  %s276 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.276, i32 0, i32 0
  %t277 = call i1 @starts_with(i8* %t275, i8* %s276)
  %t278 = load i8*, i8** %l0
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t280 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t282 = load i8*, i8** %l4
  %t283 = load i8*, i8** %l5
  %t284 = load i1, i1* %l6
  %t285 = load i1, i1* %l7
  %t286 = load i1, i1* %l8
  %t287 = load double, double* %l9
  %t288 = load double, double* %l10
  %t289 = load double, double* %l11
  %t290 = load double, double* %l12
  %t291 = load i8*, i8** %l13
  br i1 %t277, label %then27, label %else28
then27:
  %t292 = load i8*, i8** %l13
  %t293 = load i8*, i8** %l13
  %t294 = call i64 @sailfin_runtime_string_length(i8* %t293)
  %t295 = call i8* @sailfin_runtime_substring(i8* %t292, i64 6, i64 %t294)
  store i8* %t295, i8** %l18
  %t296 = load i8*, i8** %l18
  %t297 = call %NumberParseResult @parse_decimal_number(i8* %t296)
  store %NumberParseResult %t297, %NumberParseResult* %l19
  %t298 = load %NumberParseResult, %NumberParseResult* %l19
  %t299 = extractvalue %NumberParseResult %t298, 0
  %t300 = load i8*, i8** %l0
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t302 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t304 = load i8*, i8** %l4
  %t305 = load i8*, i8** %l5
  %t306 = load i1, i1* %l6
  %t307 = load i1, i1* %l7
  %t308 = load i1, i1* %l8
  %t309 = load double, double* %l9
  %t310 = load double, double* %l10
  %t311 = load double, double* %l11
  %t312 = load double, double* %l12
  %t313 = load i8*, i8** %l13
  %t314 = load i8*, i8** %l18
  %t315 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t299, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t316 = load %NumberParseResult, %NumberParseResult* %l19
  %t317 = extractvalue %NumberParseResult %t316, 1
  store double %t317, double* %l11
  br label %merge32
else31:
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s319 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.319, i32 0, i32 0
  %t320 = add i8* %s319, %struct_name
  %s321 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.321, i32 0, i32 0
  %t322 = add i8* %t320, %s321
  %t323 = load i8*, i8** %l4
  %t324 = add i8* %t322, %t323
  %s325 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.325, i32 0, i32 0
  %t326 = add i8* %t324, %s325
  %t327 = load i8*, i8** %l18
  %t328 = add i8* %t326, %t327
  %t329 = load i8, i8* %t328
  %t330 = add i8 %t329, 96
  %t331 = alloca [2 x i8], align 1
  %t332 = getelementptr [2 x i8], [2 x i8]* %t331, i32 0, i32 0
  store i8 %t330, i8* %t332
  %t333 = getelementptr [2 x i8], [2 x i8]* %t331, i32 0, i32 1
  store i8 0, i8* %t333
  %t334 = getelementptr [2 x i8], [2 x i8]* %t331, i32 0, i32 0
  %t335 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t318, i8* %t334)
  store { i8**, i64 }* %t335, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t336 = phi i1 [ 1, %then30 ], [ %t308, %else31 ]
  %t337 = phi double [ %t317, %then30 ], [ %t311, %else31 ]
  %t338 = phi { i8**, i64 }* [ %t301, %then30 ], [ %t335, %else31 ]
  store i1 %t336, i1* %l8
  store double %t337, double* %l11
  store { i8**, i64 }* %t338, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s340 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.340, i32 0, i32 0
  %t341 = add i8* %s340, %struct_name
  %s342 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.342, i32 0, i32 0
  %t343 = add i8* %t341, %s342
  %t344 = load i8*, i8** %l4
  %t345 = add i8* %t343, %t344
  %s346 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.346, i32 0, i32 0
  %t347 = add i8* %t345, %s346
  %t348 = load i8*, i8** %l13
  %t349 = add i8* %t347, %t348
  %t350 = load i8, i8* %t349
  %t351 = add i8 %t350, 96
  %t352 = alloca [2 x i8], align 1
  %t353 = getelementptr [2 x i8], [2 x i8]* %t352, i32 0, i32 0
  store i8 %t351, i8* %t353
  %t354 = getelementptr [2 x i8], [2 x i8]* %t352, i32 0, i32 1
  store i8 0, i8* %t354
  %t355 = getelementptr [2 x i8], [2 x i8]* %t352, i32 0, i32 0
  %t356 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t339, i8* %t355)
  store { i8**, i64 }* %t356, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t357 = phi i1 [ 1, %then27 ], [ %t286, %else28 ]
  %t358 = phi double [ %t317, %then27 ], [ %t289, %else28 ]
  %t359 = phi { i8**, i64 }* [ %t335, %then27 ], [ %t356, %else28 ]
  store i1 %t357, i1* %l8
  store double %t358, double* %l11
  store { i8**, i64 }* %t359, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t360 = phi i1 [ 1, %then21 ], [ %t221, %else22 ]
  %t361 = phi double [ %t253, %then21 ], [ %t224, %else22 ]
  %t362 = phi { i8**, i64 }* [ %t271, %then21 ], [ %t335, %else22 ]
  %t363 = phi i1 [ %t222, %then21 ], [ 1, %else22 ]
  %t364 = phi double [ %t225, %then21 ], [ %t317, %else22 ]
  store i1 %t360, i1* %l7
  store double %t361, double* %l10
  store { i8**, i64 }* %t362, { i8**, i64 }** %l1
  store i1 %t363, i1* %l8
  store double %t364, double* %l11
  br label %merge17
merge17:
  %t365 = phi i1 [ 1, %then15 ], [ %t156, %else16 ]
  %t366 = phi double [ %t189, %then15 ], [ %t159, %else16 ]
  %t367 = phi { i8**, i64 }* [ %t207, %then15 ], [ %t271, %else16 ]
  %t368 = phi i1 [ %t157, %then15 ], [ 1, %else16 ]
  %t369 = phi double [ %t160, %then15 ], [ %t253, %else16 ]
  %t370 = phi i1 [ %t158, %then15 ], [ 1, %else16 ]
  %t371 = phi double [ %t161, %then15 ], [ %t317, %else16 ]
  store i1 %t365, i1* %l6
  store double %t366, double* %l9
  store { i8**, i64 }* %t367, { i8**, i64 }** %l1
  store i1 %t368, i1* %l7
  store double %t369, double* %l10
  store i1 %t370, i1* %l8
  store double %t371, double* %l11
  br label %merge14
merge14:
  %t372 = phi i8* [ %t146, %then12 ], [ %t134, %else13 ]
  %t373 = phi i1 [ %t135, %then12 ], [ 1, %else13 ]
  %t374 = phi double [ %t138, %then12 ], [ %t189, %else13 ]
  %t375 = phi { i8**, i64 }* [ %t130, %then12 ], [ %t207, %else13 ]
  %t376 = phi i1 [ %t136, %then12 ], [ 1, %else13 ]
  %t377 = phi double [ %t139, %then12 ], [ %t253, %else13 ]
  %t378 = phi i1 [ %t137, %then12 ], [ 1, %else13 ]
  %t379 = phi double [ %t140, %then12 ], [ %t317, %else13 ]
  store i8* %t372, i8** %l5
  store i1 %t373, i1* %l6
  store double %t374, double* %l9
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  store i1 %t376, i1* %l7
  store double %t377, double* %l10
  store i1 %t378, i1* %l8
  store double %t379, double* %l11
  %t380 = load double, double* %l12
  %t381 = sitofp i64 1 to double
  %t382 = fadd double %t380, %t381
  store double %t382, double* %l12
  br label %loop.latch8
loop.latch8:
  %t383 = load i8*, i8** %l5
  %t384 = load i1, i1* %l6
  %t385 = load double, double* %l9
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t387 = load i1, i1* %l7
  %t388 = load double, double* %l10
  %t389 = load i1, i1* %l8
  %t390 = load double, double* %l11
  %t391 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t401 = load i8*, i8** %l5
  %t402 = call i64 @sailfin_runtime_string_length(i8* %t401)
  %t403 = icmp eq i64 %t402, 0
  %t404 = load i8*, i8** %l0
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t408 = load i8*, i8** %l4
  %t409 = load i8*, i8** %l5
  %t410 = load i1, i1* %l6
  %t411 = load i1, i1* %l7
  %t412 = load i1, i1* %l8
  %t413 = load double, double* %l9
  %t414 = load double, double* %l10
  %t415 = load double, double* %l11
  %t416 = load double, double* %l12
  br i1 %t403, label %then33, label %merge34
then33:
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s418 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.418, i32 0, i32 0
  %t419 = add i8* %s418, %struct_name
  %s420 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.420, i32 0, i32 0
  %t421 = add i8* %t419, %s420
  %t422 = load i8*, i8** %l4
  %t423 = add i8* %t421, %t422
  %s424 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.424, i32 0, i32 0
  %t425 = add i8* %t423, %s424
  %t426 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t417, i8* %t425)
  store { i8**, i64 }* %t426, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t427 = phi { i8**, i64 }* [ %t426, %then33 ], [ %t405, %entry ]
  store { i8**, i64 }* %t427, { i8**, i64 }** %l1
  %t428 = load i1, i1* %l6
  %t429 = xor i1 %t428, 1
  %t430 = load i8*, i8** %l0
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t432 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t434 = load i8*, i8** %l4
  %t435 = load i8*, i8** %l5
  %t436 = load i1, i1* %l6
  %t437 = load i1, i1* %l7
  %t438 = load i1, i1* %l8
  %t439 = load double, double* %l9
  %t440 = load double, double* %l10
  %t441 = load double, double* %l11
  %t442 = load double, double* %l12
  br i1 %t429, label %then35, label %merge36
then35:
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s444 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.444, i32 0, i32 0
  %t445 = add i8* %s444, %struct_name
  %s446 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.446, i32 0, i32 0
  %t447 = add i8* %t445, %s446
  %t448 = load i8*, i8** %l4
  %t449 = add i8* %t447, %t448
  %s450 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.450, i32 0, i32 0
  %t451 = add i8* %t449, %s450
  %t452 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t443, i8* %t451)
  store { i8**, i64 }* %t452, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t453 = phi { i8**, i64 }* [ %t452, %then35 ], [ %t431, %entry ]
  store { i8**, i64 }* %t453, { i8**, i64 }** %l1
  %t454 = load i1, i1* %l7
  %t455 = xor i1 %t454, 1
  %t456 = load i8*, i8** %l0
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t458 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t460 = load i8*, i8** %l4
  %t461 = load i8*, i8** %l5
  %t462 = load i1, i1* %l6
  %t463 = load i1, i1* %l7
  %t464 = load i1, i1* %l8
  %t465 = load double, double* %l9
  %t466 = load double, double* %l10
  %t467 = load double, double* %l11
  %t468 = load double, double* %l12
  br i1 %t455, label %then37, label %merge38
then37:
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s470 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.470, i32 0, i32 0
  %t471 = add i8* %s470, %struct_name
  %s472 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.472, i32 0, i32 0
  %t473 = add i8* %t471, %s472
  %t474 = load i8*, i8** %l4
  %t475 = add i8* %t473, %t474
  %s476 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.476, i32 0, i32 0
  %t477 = add i8* %t475, %s476
  %t478 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t469, i8* %t477)
  store { i8**, i64 }* %t478, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t479 = phi { i8**, i64 }* [ %t478, %then37 ], [ %t457, %entry ]
  store { i8**, i64 }* %t479, { i8**, i64 }** %l1
  %t480 = load i1, i1* %l8
  %t481 = xor i1 %t480, 1
  %t482 = load i8*, i8** %l0
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t484 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t486 = load i8*, i8** %l4
  %t487 = load i8*, i8** %l5
  %t488 = load i1, i1* %l6
  %t489 = load i1, i1* %l7
  %t490 = load i1, i1* %l8
  %t491 = load double, double* %l9
  %t492 = load double, double* %l10
  %t493 = load double, double* %l11
  %t494 = load double, double* %l12
  br i1 %t481, label %then39, label %merge40
then39:
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s496 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.496, i32 0, i32 0
  %t497 = add i8* %s496, %struct_name
  %s498 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.498, i32 0, i32 0
  %t499 = add i8* %t497, %s498
  %t500 = load i8*, i8** %l4
  %t501 = add i8* %t499, %t500
  %s502 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.502, i32 0, i32 0
  %t503 = add i8* %t501, %s502
  %t504 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t495, i8* %t503)
  store { i8**, i64 }* %t504, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t505 = phi { i8**, i64 }* [ %t504, %then39 ], [ %t483, %entry ]
  store { i8**, i64 }* %t505, { i8**, i64 }** %l1
  %t507 = load i8*, i8** %l5
  %t508 = call i64 @sailfin_runtime_string_length(i8* %t507)
  %t509 = icmp sgt i64 %t508, 0
  br label %logical_and_entry_506

logical_and_entry_506:
  br i1 %t509, label %logical_and_right_506, label %logical_and_merge_506

logical_and_right_506:
  %t511 = load i1, i1* %l6
  br label %logical_and_entry_510

logical_and_entry_510:
  br i1 %t511, label %logical_and_right_510, label %logical_and_merge_510

logical_and_right_510:
  %t513 = load i1, i1* %l7
  br label %logical_and_entry_512

logical_and_entry_512:
  br i1 %t513, label %logical_and_right_512, label %logical_and_merge_512

logical_and_right_512:
  %t515 = load i1, i1* %l8
  br label %logical_and_entry_514

logical_and_entry_514:
  br i1 %t515, label %logical_and_right_514, label %logical_and_merge_514

logical_and_right_514:
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t517 = load { i8**, i64 }, { i8**, i64 }* %t516
  %t518 = extractvalue { i8**, i64 } %t517, 1
  %t519 = icmp eq i64 %t518, 0
  br label %logical_and_right_end_514

logical_and_right_end_514:
  br label %logical_and_merge_514

logical_and_merge_514:
  %t520 = phi i1 [ false, %logical_and_entry_514 ], [ %t519, %logical_and_right_end_514 ]
  br label %logical_and_right_end_512

logical_and_right_end_512:
  br label %logical_and_merge_512

logical_and_merge_512:
  %t521 = phi i1 [ false, %logical_and_entry_512 ], [ %t520, %logical_and_right_end_512 ]
  br label %logical_and_right_end_510

logical_and_right_end_510:
  br label %logical_and_merge_510

logical_and_merge_510:
  %t522 = phi i1 [ false, %logical_and_entry_510 ], [ %t521, %logical_and_right_end_510 ]
  br label %logical_and_right_end_506

logical_and_right_end_506:
  br label %logical_and_merge_506

logical_and_merge_506:
  %t523 = phi i1 [ false, %logical_and_entry_506 ], [ %t522, %logical_and_right_end_506 ]
  store i1 %t523, i1* %l20
  %t524 = load i8*, i8** %l4
  %t525 = insertvalue %NativeStructLayoutField undef, i8* %t524, 0
  %t526 = load i8*, i8** %l5
  %t527 = insertvalue %NativeStructLayoutField %t525, i8* %t526, 1
  %t528 = load double, double* %l9
  %t529 = insertvalue %NativeStructLayoutField %t527, double %t528, 2
  %t530 = load double, double* %l10
  %t531 = insertvalue %NativeStructLayoutField %t529, double %t530, 3
  %t532 = load double, double* %l11
  %t533 = insertvalue %NativeStructLayoutField %t531, double %t532, 4
  store %NativeStructLayoutField %t533, %NativeStructLayoutField* %l21
  %t534 = load i1, i1* %l20
  %t535 = insertvalue %StructLayoutFieldParse undef, i1 %t534, 0
  %t536 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t537 = insertvalue %StructLayoutFieldParse %t535, %NativeStructLayoutField %t536, 1
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t539 = insertvalue %StructLayoutFieldParse %t537, { i8**, i64 }* %t538, 2
  ret %StructLayoutFieldParse %t539
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
  %t432 = phi i8* [ %t43, %entry ], [ %t419, %loop.latch4 ]
  %t433 = phi i1 [ %t40, %entry ], [ %t420, %loop.latch4 ]
  %t434 = phi i1 [ %t41, %entry ], [ %t421, %loop.latch4 ]
  %t435 = phi double [ %t47, %entry ], [ %t422, %loop.latch4 ]
  %t436 = phi { i8**, i64 }* [ %t39, %entry ], [ %t423, %loop.latch4 ]
  %t437 = phi i1 [ %t42, %entry ], [ %t424, %loop.latch4 ]
  %t438 = phi double [ %t48, %entry ], [ %t425, %loop.latch4 ]
  %t439 = phi i8* [ %t44, %entry ], [ %t426, %loop.latch4 ]
  %t440 = phi i1 [ %t45, %entry ], [ %t427, %loop.latch4 ]
  %t441 = phi double [ %t49, %entry ], [ %t428, %loop.latch4 ]
  %t442 = phi i1 [ %t46, %entry ], [ %t429, %loop.latch4 ]
  %t443 = phi double [ %t50, %entry ], [ %t430, %loop.latch4 ]
  %t444 = phi double [ %t51, %entry ], [ %t431, %loop.latch4 ]
  store i8* %t432, i8** %l5
  store i1 %t433, i1* %l2
  store i1 %t434, i1* %l3
  store double %t435, double* %l9
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  store i1 %t437, i1* %l4
  store double %t438, double* %l10
  store i8* %t439, i8** %l6
  store i1 %t440, i1* %l7
  store double %t441, double* %l11
  store i1 %t442, i1* %l8
  store double %t443, double* %l12
  store double %t444, double* %l13
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
  %t152 = load i8, i8* %t151
  %t153 = add i8 %t152, 96
  %t154 = alloca [2 x i8], align 1
  %t155 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 0
  store i8 %t153, i8* %t155
  %t156 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 1
  store i8 0, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 0
  %t158 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t148, i8* %t157)
  store { i8**, i64 }* %t158, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t159 = phi i1 [ 1, %then14 ], [ %t132, %else15 ]
  %t160 = phi double [ %t147, %then14 ], [ %t138, %else15 ]
  %t161 = phi { i8**, i64 }* [ %t130, %then14 ], [ %t158, %else15 ]
  store i1 %t159, i1* %l3
  store double %t160, double* %l9
  store { i8**, i64 }* %t161, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t162 = load i8*, i8** %l14
  %s163 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.163, i32 0, i32 0
  %t164 = call i1 @starts_with(i8* %t162, i8* %s163)
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load i1, i1* %l2
  %t168 = load i1, i1* %l3
  %t169 = load i1, i1* %l4
  %t170 = load i8*, i8** %l5
  %t171 = load i8*, i8** %l6
  %t172 = load i1, i1* %l7
  %t173 = load i1, i1* %l8
  %t174 = load double, double* %l9
  %t175 = load double, double* %l10
  %t176 = load double, double* %l11
  %t177 = load double, double* %l12
  %t178 = load double, double* %l13
  %t179 = load i8*, i8** %l14
  br i1 %t164, label %then17, label %else18
then17:
  %t180 = load i8*, i8** %l14
  %t181 = load i8*, i8** %l14
  %t182 = call i64 @sailfin_runtime_string_length(i8* %t181)
  %t183 = call i8* @sailfin_runtime_substring(i8* %t180, i64 6, i64 %t182)
  store i8* %t183, i8** %l17
  %t184 = load i8*, i8** %l17
  %t185 = call %NumberParseResult @parse_decimal_number(i8* %t184)
  store %NumberParseResult %t185, %NumberParseResult* %l18
  %t186 = load %NumberParseResult, %NumberParseResult* %l18
  %t187 = extractvalue %NumberParseResult %t186, 0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t190 = load i1, i1* %l2
  %t191 = load i1, i1* %l3
  %t192 = load i1, i1* %l4
  %t193 = load i8*, i8** %l5
  %t194 = load i8*, i8** %l6
  %t195 = load i1, i1* %l7
  %t196 = load i1, i1* %l8
  %t197 = load double, double* %l9
  %t198 = load double, double* %l10
  %t199 = load double, double* %l11
  %t200 = load double, double* %l12
  %t201 = load double, double* %l13
  %t202 = load i8*, i8** %l14
  %t203 = load i8*, i8** %l17
  %t204 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t187, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t205 = load %NumberParseResult, %NumberParseResult* %l18
  %t206 = extractvalue %NumberParseResult %t205, 1
  store double %t206, double* %l10
  br label %merge22
else21:
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s208 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.208, i32 0, i32 0
  %t209 = load i8*, i8** %l17
  %t210 = add i8* %s208, %t209
  %t211 = load i8, i8* %t210
  %t212 = add i8 %t211, 96
  %t213 = alloca [2 x i8], align 1
  %t214 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8 %t212, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 1
  store i8 0, i8* %t215
  %t216 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  %t217 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t207, i8* %t216)
  store { i8**, i64 }* %t217, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t218 = phi i1 [ 1, %then20 ], [ %t192, %else21 ]
  %t219 = phi double [ %t206, %then20 ], [ %t198, %else21 ]
  %t220 = phi { i8**, i64 }* [ %t189, %then20 ], [ %t217, %else21 ]
  store i1 %t218, i1* %l4
  store double %t219, double* %l10
  store { i8**, i64 }* %t220, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t221 = load i8*, i8** %l14
  %s222 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.222, i32 0, i32 0
  %t223 = call i1 @starts_with(i8* %t221, i8* %s222)
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t226 = load i1, i1* %l2
  %t227 = load i1, i1* %l3
  %t228 = load i1, i1* %l4
  %t229 = load i8*, i8** %l5
  %t230 = load i8*, i8** %l6
  %t231 = load i1, i1* %l7
  %t232 = load i1, i1* %l8
  %t233 = load double, double* %l9
  %t234 = load double, double* %l10
  %t235 = load double, double* %l11
  %t236 = load double, double* %l12
  %t237 = load double, double* %l13
  %t238 = load i8*, i8** %l14
  br i1 %t223, label %then23, label %else24
then23:
  %t239 = load i8*, i8** %l14
  %t240 = load i8*, i8** %l14
  %t241 = call i64 @sailfin_runtime_string_length(i8* %t240)
  %t242 = call i8* @sailfin_runtime_substring(i8* %t239, i64 9, i64 %t241)
  store i8* %t242, i8** %l6
  br label %merge25
else24:
  %t243 = load i8*, i8** %l14
  %s244 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.244, i32 0, i32 0
  %t245 = call i1 @starts_with(i8* %t243, i8* %s244)
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load i1, i1* %l2
  %t249 = load i1, i1* %l3
  %t250 = load i1, i1* %l4
  %t251 = load i8*, i8** %l5
  %t252 = load i8*, i8** %l6
  %t253 = load i1, i1* %l7
  %t254 = load i1, i1* %l8
  %t255 = load double, double* %l9
  %t256 = load double, double* %l10
  %t257 = load double, double* %l11
  %t258 = load double, double* %l12
  %t259 = load double, double* %l13
  %t260 = load i8*, i8** %l14
  br i1 %t245, label %then26, label %else27
then26:
  %t261 = load i8*, i8** %l14
  %t262 = load i8*, i8** %l14
  %t263 = call i64 @sailfin_runtime_string_length(i8* %t262)
  %t264 = call i8* @sailfin_runtime_substring(i8* %t261, i64 9, i64 %t263)
  store i8* %t264, i8** %l19
  %t265 = load i8*, i8** %l19
  %t266 = call %NumberParseResult @parse_decimal_number(i8* %t265)
  store %NumberParseResult %t266, %NumberParseResult* %l20
  %t267 = load %NumberParseResult, %NumberParseResult* %l20
  %t268 = extractvalue %NumberParseResult %t267, 0
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = load i1, i1* %l2
  %t272 = load i1, i1* %l3
  %t273 = load i1, i1* %l4
  %t274 = load i8*, i8** %l5
  %t275 = load i8*, i8** %l6
  %t276 = load i1, i1* %l7
  %t277 = load i1, i1* %l8
  %t278 = load double, double* %l9
  %t279 = load double, double* %l10
  %t280 = load double, double* %l11
  %t281 = load double, double* %l12
  %t282 = load double, double* %l13
  %t283 = load i8*, i8** %l14
  %t284 = load i8*, i8** %l19
  %t285 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t268, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t286 = load %NumberParseResult, %NumberParseResult* %l20
  %t287 = extractvalue %NumberParseResult %t286, 1
  store double %t287, double* %l11
  br label %merge31
else30:
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s289 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.289, i32 0, i32 0
  %t290 = load i8*, i8** %l19
  %t291 = add i8* %s289, %t290
  %t292 = load i8, i8* %t291
  %t293 = add i8 %t292, 96
  %t294 = alloca [2 x i8], align 1
  %t295 = getelementptr [2 x i8], [2 x i8]* %t294, i32 0, i32 0
  store i8 %t293, i8* %t295
  %t296 = getelementptr [2 x i8], [2 x i8]* %t294, i32 0, i32 1
  store i8 0, i8* %t296
  %t297 = getelementptr [2 x i8], [2 x i8]* %t294, i32 0, i32 0
  %t298 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t288, i8* %t297)
  store { i8**, i64 }* %t298, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t299 = phi i1 [ 1, %then29 ], [ %t276, %else30 ]
  %t300 = phi double [ %t287, %then29 ], [ %t280, %else30 ]
  %t301 = phi { i8**, i64 }* [ %t270, %then29 ], [ %t298, %else30 ]
  store i1 %t299, i1* %l7
  store double %t300, double* %l11
  store { i8**, i64 }* %t301, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t302 = load i8*, i8** %l14
  %s303 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.303, i32 0, i32 0
  %t304 = call i1 @starts_with(i8* %t302, i8* %s303)
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t307 = load i1, i1* %l2
  %t308 = load i1, i1* %l3
  %t309 = load i1, i1* %l4
  %t310 = load i8*, i8** %l5
  %t311 = load i8*, i8** %l6
  %t312 = load i1, i1* %l7
  %t313 = load i1, i1* %l8
  %t314 = load double, double* %l9
  %t315 = load double, double* %l10
  %t316 = load double, double* %l11
  %t317 = load double, double* %l12
  %t318 = load double, double* %l13
  %t319 = load i8*, i8** %l14
  br i1 %t304, label %then32, label %else33
then32:
  %t320 = load i8*, i8** %l14
  %t321 = load i8*, i8** %l14
  %t322 = call i64 @sailfin_runtime_string_length(i8* %t321)
  %t323 = call i8* @sailfin_runtime_substring(i8* %t320, i64 10, i64 %t322)
  store i8* %t323, i8** %l21
  %t324 = load i8*, i8** %l21
  %t325 = call %NumberParseResult @parse_decimal_number(i8* %t324)
  store %NumberParseResult %t325, %NumberParseResult* %l22
  %t326 = load %NumberParseResult, %NumberParseResult* %l22
  %t327 = extractvalue %NumberParseResult %t326, 0
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t330 = load i1, i1* %l2
  %t331 = load i1, i1* %l3
  %t332 = load i1, i1* %l4
  %t333 = load i8*, i8** %l5
  %t334 = load i8*, i8** %l6
  %t335 = load i1, i1* %l7
  %t336 = load i1, i1* %l8
  %t337 = load double, double* %l9
  %t338 = load double, double* %l10
  %t339 = load double, double* %l11
  %t340 = load double, double* %l12
  %t341 = load double, double* %l13
  %t342 = load i8*, i8** %l14
  %t343 = load i8*, i8** %l21
  %t344 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t327, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t345 = load %NumberParseResult, %NumberParseResult* %l22
  %t346 = extractvalue %NumberParseResult %t345, 1
  store double %t346, double* %l12
  br label %merge37
else36:
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s348 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.348, i32 0, i32 0
  %t349 = load i8*, i8** %l21
  %t350 = add i8* %s348, %t349
  %t351 = load i8, i8* %t350
  %t352 = add i8 %t351, 96
  %t353 = alloca [2 x i8], align 1
  %t354 = getelementptr [2 x i8], [2 x i8]* %t353, i32 0, i32 0
  store i8 %t352, i8* %t354
  %t355 = getelementptr [2 x i8], [2 x i8]* %t353, i32 0, i32 1
  store i8 0, i8* %t355
  %t356 = getelementptr [2 x i8], [2 x i8]* %t353, i32 0, i32 0
  %t357 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t347, i8* %t356)
  store { i8**, i64 }* %t357, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t358 = phi i1 [ 1, %then35 ], [ %t336, %else36 ]
  %t359 = phi double [ %t346, %then35 ], [ %t340, %else36 ]
  %t360 = phi { i8**, i64 }* [ %t329, %then35 ], [ %t357, %else36 ]
  store i1 %t358, i1* %l8
  store double %t359, double* %l12
  store { i8**, i64 }* %t360, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s362 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.362, i32 0, i32 0
  %t363 = load i8*, i8** %l14
  %t364 = add i8* %s362, %t363
  %t365 = load i8, i8* %t364
  %t366 = add i8 %t365, 96
  %t367 = alloca [2 x i8], align 1
  %t368 = getelementptr [2 x i8], [2 x i8]* %t367, i32 0, i32 0
  store i8 %t366, i8* %t368
  %t369 = getelementptr [2 x i8], [2 x i8]* %t367, i32 0, i32 1
  store i8 0, i8* %t369
  %t370 = getelementptr [2 x i8], [2 x i8]* %t367, i32 0, i32 0
  %t371 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t361, i8* %t370)
  store { i8**, i64 }* %t371, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t372 = phi i1 [ 1, %then32 ], [ %t313, %else33 ]
  %t373 = phi double [ %t346, %then32 ], [ %t317, %else33 ]
  %t374 = phi { i8**, i64 }* [ %t357, %then32 ], [ %t371, %else33 ]
  store i1 %t372, i1* %l8
  store double %t373, double* %l12
  store { i8**, i64 }* %t374, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t375 = phi i1 [ 1, %then26 ], [ %t253, %else27 ]
  %t376 = phi double [ %t287, %then26 ], [ %t257, %else27 ]
  %t377 = phi { i8**, i64 }* [ %t298, %then26 ], [ %t357, %else27 ]
  %t378 = phi i1 [ %t254, %then26 ], [ 1, %else27 ]
  %t379 = phi double [ %t258, %then26 ], [ %t346, %else27 ]
  store i1 %t375, i1* %l7
  store double %t376, double* %l11
  store { i8**, i64 }* %t377, { i8**, i64 }** %l1
  store i1 %t378, i1* %l8
  store double %t379, double* %l12
  br label %merge25
merge25:
  %t380 = phi i8* [ %t242, %then23 ], [ %t230, %else24 ]
  %t381 = phi i1 [ %t231, %then23 ], [ 1, %else24 ]
  %t382 = phi double [ %t235, %then23 ], [ %t287, %else24 ]
  %t383 = phi { i8**, i64 }* [ %t225, %then23 ], [ %t298, %else24 ]
  %t384 = phi i1 [ %t232, %then23 ], [ 1, %else24 ]
  %t385 = phi double [ %t236, %then23 ], [ %t346, %else24 ]
  store i8* %t380, i8** %l6
  store i1 %t381, i1* %l7
  store double %t382, double* %l11
  store { i8**, i64 }* %t383, { i8**, i64 }** %l1
  store i1 %t384, i1* %l8
  store double %t385, double* %l12
  br label %merge19
merge19:
  %t386 = phi i1 [ 1, %then17 ], [ %t169, %else18 ]
  %t387 = phi double [ %t206, %then17 ], [ %t175, %else18 ]
  %t388 = phi { i8**, i64 }* [ %t217, %then17 ], [ %t298, %else18 ]
  %t389 = phi i8* [ %t171, %then17 ], [ %t242, %else18 ]
  %t390 = phi i1 [ %t172, %then17 ], [ 1, %else18 ]
  %t391 = phi double [ %t176, %then17 ], [ %t287, %else18 ]
  %t392 = phi i1 [ %t173, %then17 ], [ 1, %else18 ]
  %t393 = phi double [ %t177, %then17 ], [ %t346, %else18 ]
  store i1 %t386, i1* %l4
  store double %t387, double* %l10
  store { i8**, i64 }* %t388, { i8**, i64 }** %l1
  store i8* %t389, i8** %l6
  store i1 %t390, i1* %l7
  store double %t391, double* %l11
  store i1 %t392, i1* %l8
  store double %t393, double* %l12
  br label %merge13
merge13:
  %t394 = phi i1 [ 1, %then11 ], [ %t109, %else12 ]
  %t395 = phi double [ %t147, %then11 ], [ %t115, %else12 ]
  %t396 = phi { i8**, i64 }* [ %t158, %then11 ], [ %t217, %else12 ]
  %t397 = phi i1 [ %t110, %then11 ], [ 1, %else12 ]
  %t398 = phi double [ %t116, %then11 ], [ %t206, %else12 ]
  %t399 = phi i8* [ %t112, %then11 ], [ %t242, %else12 ]
  %t400 = phi i1 [ %t113, %then11 ], [ 1, %else12 ]
  %t401 = phi double [ %t117, %then11 ], [ %t287, %else12 ]
  %t402 = phi i1 [ %t114, %then11 ], [ 1, %else12 ]
  %t403 = phi double [ %t118, %then11 ], [ %t346, %else12 ]
  store i1 %t394, i1* %l3
  store double %t395, double* %l9
  store { i8**, i64 }* %t396, { i8**, i64 }** %l1
  store i1 %t397, i1* %l4
  store double %t398, double* %l10
  store i8* %t399, i8** %l6
  store i1 %t400, i1* %l7
  store double %t401, double* %l11
  store i1 %t402, i1* %l8
  store double %t403, double* %l12
  br label %merge10
merge10:
  %t404 = phi i8* [ %t102, %then8 ], [ %t89, %else9 ]
  %t405 = phi i1 [ 1, %then8 ], [ %t86, %else9 ]
  %t406 = phi i1 [ %t87, %then8 ], [ 1, %else9 ]
  %t407 = phi double [ %t93, %then8 ], [ %t147, %else9 ]
  %t408 = phi { i8**, i64 }* [ %t85, %then8 ], [ %t158, %else9 ]
  %t409 = phi i1 [ %t88, %then8 ], [ 1, %else9 ]
  %t410 = phi double [ %t94, %then8 ], [ %t206, %else9 ]
  %t411 = phi i8* [ %t90, %then8 ], [ %t242, %else9 ]
  %t412 = phi i1 [ %t91, %then8 ], [ 1, %else9 ]
  %t413 = phi double [ %t95, %then8 ], [ %t287, %else9 ]
  %t414 = phi i1 [ %t92, %then8 ], [ 1, %else9 ]
  %t415 = phi double [ %t96, %then8 ], [ %t346, %else9 ]
  store i8* %t404, i8** %l5
  store i1 %t405, i1* %l2
  store i1 %t406, i1* %l3
  store double %t407, double* %l9
  store { i8**, i64 }* %t408, { i8**, i64 }** %l1
  store i1 %t409, i1* %l4
  store double %t410, double* %l10
  store i8* %t411, i8** %l6
  store i1 %t412, i1* %l7
  store double %t413, double* %l11
  store i1 %t414, i1* %l8
  store double %t415, double* %l12
  %t416 = load double, double* %l13
  %t417 = sitofp i64 1 to double
  %t418 = fadd double %t416, %t417
  store double %t418, double* %l13
  br label %loop.latch4
loop.latch4:
  %t419 = load i8*, i8** %l5
  %t420 = load i1, i1* %l2
  %t421 = load i1, i1* %l3
  %t422 = load double, double* %l9
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t424 = load i1, i1* %l4
  %t425 = load double, double* %l10
  %t426 = load i8*, i8** %l6
  %t427 = load i1, i1* %l7
  %t428 = load double, double* %l11
  %t429 = load i1, i1* %l8
  %t430 = load double, double* %l12
  %t431 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t445 = load i1, i1* %l3
  %t446 = xor i1 %t445, 1
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t449 = load i1, i1* %l2
  %t450 = load i1, i1* %l3
  %t451 = load i1, i1* %l4
  %t452 = load i8*, i8** %l5
  %t453 = load i8*, i8** %l6
  %t454 = load i1, i1* %l7
  %t455 = load i1, i1* %l8
  %t456 = load double, double* %l9
  %t457 = load double, double* %l10
  %t458 = load double, double* %l11
  %t459 = load double, double* %l12
  %t460 = load double, double* %l13
  br i1 %t446, label %then38, label %merge39
then38:
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s462 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.462, i32 0, i32 0
  %t463 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t461, i8* %s462)
  store { i8**, i64 }* %t463, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t464 = phi { i8**, i64 }* [ %t463, %then38 ], [ %t448, %entry ]
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  %t465 = load i1, i1* %l4
  %t466 = xor i1 %t465, 1
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t469 = load i1, i1* %l2
  %t470 = load i1, i1* %l3
  %t471 = load i1, i1* %l4
  %t472 = load i8*, i8** %l5
  %t473 = load i8*, i8** %l6
  %t474 = load i1, i1* %l7
  %t475 = load i1, i1* %l8
  %t476 = load double, double* %l9
  %t477 = load double, double* %l10
  %t478 = load double, double* %l11
  %t479 = load double, double* %l12
  %t480 = load double, double* %l13
  br i1 %t466, label %then40, label %merge41
then40:
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s482 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.482, i32 0, i32 0
  %t483 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t481, i8* %s482)
  store { i8**, i64 }* %t483, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t484 = phi { i8**, i64 }* [ %t483, %then40 ], [ %t468, %entry ]
  store { i8**, i64 }* %t484, { i8**, i64 }** %l1
  %t485 = load i8*, i8** %l6
  %t486 = call i64 @sailfin_runtime_string_length(i8* %t485)
  %t487 = icmp eq i64 %t486, 0
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t490 = load i1, i1* %l2
  %t491 = load i1, i1* %l3
  %t492 = load i1, i1* %l4
  %t493 = load i8*, i8** %l5
  %t494 = load i8*, i8** %l6
  %t495 = load i1, i1* %l7
  %t496 = load i1, i1* %l8
  %t497 = load double, double* %l9
  %t498 = load double, double* %l10
  %t499 = load double, double* %l11
  %t500 = load double, double* %l12
  %t501 = load double, double* %l13
  br i1 %t487, label %then42, label %merge43
then42:
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s503 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.503, i32 0, i32 0
  %t504 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t502, i8* %s503)
  store { i8**, i64 }* %t504, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t505 = phi { i8**, i64 }* [ %t504, %then42 ], [ %t489, %entry ]
  store { i8**, i64 }* %t505, { i8**, i64 }** %l1
  %t506 = load i1, i1* %l7
  %t507 = xor i1 %t506, 1
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load i1, i1* %l2
  %t511 = load i1, i1* %l3
  %t512 = load i1, i1* %l4
  %t513 = load i8*, i8** %l5
  %t514 = load i8*, i8** %l6
  %t515 = load i1, i1* %l7
  %t516 = load i1, i1* %l8
  %t517 = load double, double* %l9
  %t518 = load double, double* %l10
  %t519 = load double, double* %l11
  %t520 = load double, double* %l12
  %t521 = load double, double* %l13
  br i1 %t507, label %then44, label %merge45
then44:
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s523 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.523, i32 0, i32 0
  %t524 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t522, i8* %s523)
  store { i8**, i64 }* %t524, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t525 = phi { i8**, i64 }* [ %t524, %then44 ], [ %t509, %entry ]
  store { i8**, i64 }* %t525, { i8**, i64 }** %l1
  %t526 = load i1, i1* %l8
  %t527 = xor i1 %t526, 1
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t530 = load i1, i1* %l2
  %t531 = load i1, i1* %l3
  %t532 = load i1, i1* %l4
  %t533 = load i8*, i8** %l5
  %t534 = load i8*, i8** %l6
  %t535 = load i1, i1* %l7
  %t536 = load i1, i1* %l8
  %t537 = load double, double* %l9
  %t538 = load double, double* %l10
  %t539 = load double, double* %l11
  %t540 = load double, double* %l12
  %t541 = load double, double* %l13
  br i1 %t527, label %then46, label %merge47
then46:
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s543 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.543, i32 0, i32 0
  %t544 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t542, i8* %s543)
  store { i8**, i64 }* %t544, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t545 = phi { i8**, i64 }* [ %t544, %then46 ], [ %t529, %entry ]
  store { i8**, i64 }* %t545, { i8**, i64 }** %l1
  %t547 = load i1, i1* %l3
  br label %logical_and_entry_546

logical_and_entry_546:
  br i1 %t547, label %logical_and_right_546, label %logical_and_merge_546

logical_and_right_546:
  %t549 = load i1, i1* %l4
  br label %logical_and_entry_548

logical_and_entry_548:
  br i1 %t549, label %logical_and_right_548, label %logical_and_merge_548

logical_and_right_548:
  %t551 = load i8*, i8** %l6
  %t552 = call i64 @sailfin_runtime_string_length(i8* %t551)
  %t553 = icmp sgt i64 %t552, 0
  br label %logical_and_entry_550

logical_and_entry_550:
  br i1 %t553, label %logical_and_right_550, label %logical_and_merge_550

logical_and_right_550:
  %t555 = load i1, i1* %l7
  br label %logical_and_entry_554

logical_and_entry_554:
  br i1 %t555, label %logical_and_right_554, label %logical_and_merge_554

logical_and_right_554:
  %t557 = load i1, i1* %l8
  br label %logical_and_entry_556

logical_and_entry_556:
  br i1 %t557, label %logical_and_right_556, label %logical_and_merge_556

logical_and_right_556:
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t559 = load { i8**, i64 }, { i8**, i64 }* %t558
  %t560 = extractvalue { i8**, i64 } %t559, 1
  %t561 = icmp eq i64 %t560, 0
  br label %logical_and_right_end_556

logical_and_right_end_556:
  br label %logical_and_merge_556

logical_and_merge_556:
  %t562 = phi i1 [ false, %logical_and_entry_556 ], [ %t561, %logical_and_right_end_556 ]
  br label %logical_and_right_end_554

logical_and_right_end_554:
  br label %logical_and_merge_554

logical_and_merge_554:
  %t563 = phi i1 [ false, %logical_and_entry_554 ], [ %t562, %logical_and_right_end_554 ]
  br label %logical_and_right_end_550

logical_and_right_end_550:
  br label %logical_and_merge_550

logical_and_merge_550:
  %t564 = phi i1 [ false, %logical_and_entry_550 ], [ %t563, %logical_and_right_end_550 ]
  br label %logical_and_right_end_548

logical_and_right_end_548:
  br label %logical_and_merge_548

logical_and_merge_548:
  %t565 = phi i1 [ false, %logical_and_entry_548 ], [ %t564, %logical_and_right_end_548 ]
  br label %logical_and_right_end_546

logical_and_right_end_546:
  br label %logical_and_merge_546

logical_and_merge_546:
  %t566 = phi i1 [ false, %logical_and_entry_546 ], [ %t565, %logical_and_right_end_546 ]
  store i1 %t566, i1* %l23
  %t567 = load i1, i1* %l23
  %t568 = insertvalue %EnumLayoutHeaderParse undef, i1 %t567, 0
  %t569 = load i8*, i8** %l5
  %t570 = insertvalue %EnumLayoutHeaderParse %t568, i8* %t569, 1
  %t571 = load double, double* %l9
  %t572 = insertvalue %EnumLayoutHeaderParse %t570, double %t571, 2
  %t573 = load double, double* %l10
  %t574 = insertvalue %EnumLayoutHeaderParse %t572, double %t573, 3
  %t575 = load i8*, i8** %l6
  %t576 = insertvalue %EnumLayoutHeaderParse %t574, i8* %t575, 4
  %t577 = load double, double* %l11
  %t578 = insertvalue %EnumLayoutHeaderParse %t576, double %t577, 5
  %t579 = load double, double* %l12
  %t580 = insertvalue %EnumLayoutHeaderParse %t578, double %t579, 6
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t582 = insertvalue %EnumLayoutHeaderParse %t580, { i8**, i64 }* %t581, 7
  ret %EnumLayoutHeaderParse %t582
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
  %t16 = alloca [0 x %NativeStructLayoutField*]
  %t17 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* %t16, i32 0, i32 0
  %t18 = alloca { %NativeStructLayoutField**, i64 }
  %t19 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t18, i32 0, i32 0
  store %NativeStructLayoutField** %t17, %NativeStructLayoutField*** %t19
  %t20 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  %t21 = insertvalue %NativeEnumVariantLayout %t15, { %NativeStructLayoutField**, i64 }* %t18, 5
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
  %t36 = insertvalue %EnumLayoutVariantParse %t34, %NativeEnumVariantLayout %t35, 1
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
  %t57 = insertvalue %EnumLayoutVariantParse %t55, %NativeEnumVariantLayout %t56, 1
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
  %t83 = insertvalue %EnumLayoutVariantParse %t81, %NativeEnumVariantLayout %t82, 1
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
  %t453 = phi i1 [ %t96, %entry ], [ %t443, %loop.latch8 ]
  %t454 = phi double [ %t100, %entry ], [ %t444, %loop.latch8 ]
  %t455 = phi { i8**, i64 }* [ %t92, %entry ], [ %t445, %loop.latch8 ]
  %t456 = phi i1 [ %t97, %entry ], [ %t446, %loop.latch8 ]
  %t457 = phi double [ %t101, %entry ], [ %t447, %loop.latch8 ]
  %t458 = phi i1 [ %t98, %entry ], [ %t448, %loop.latch8 ]
  %t459 = phi double [ %t102, %entry ], [ %t449, %loop.latch8 ]
  %t460 = phi i1 [ %t99, %entry ], [ %t450, %loop.latch8 ]
  %t461 = phi double [ %t103, %entry ], [ %t451, %loop.latch8 ]
  %t462 = phi double [ %t104, %entry ], [ %t452, %loop.latch8 ]
  store i1 %t453, i1* %l5
  store double %t454, double* %l9
  store { i8**, i64 }* %t455, { i8**, i64 }** %l1
  store i1 %t456, i1* %l6
  store double %t457, double* %l10
  store i1 %t458, i1* %l7
  store double %t459, double* %l11
  store i1 %t460, i1* %l8
  store double %t461, double* %l12
  store double %t462, double* %l13
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
  %t190 = load i8, i8* %t189
  %t191 = add i8 %t190, 96
  %t192 = alloca [2 x i8], align 1
  %t193 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 0
  store i8 %t191, i8* %t193
  %t194 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 1
  store i8 0, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 0
  %t196 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t179, i8* %t195)
  store { i8**, i64 }* %t196, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t197 = phi i1 [ 1, %then15 ], [ %t165, %else16 ]
  %t198 = phi double [ %t178, %then15 ], [ %t169, %else16 ]
  %t199 = phi { i8**, i64 }* [ %t161, %then15 ], [ %t196, %else16 ]
  store i1 %t197, i1* %l5
  store double %t198, double* %l9
  store { i8**, i64 }* %t199, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t200 = load i8*, i8** %l14
  %s201 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.201, i32 0, i32 0
  %t202 = call i1 @starts_with(i8* %t200, i8* %s201)
  %t203 = load i8*, i8** %l0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t207 = load i8*, i8** %l4
  %t208 = load i1, i1* %l5
  %t209 = load i1, i1* %l6
  %t210 = load i1, i1* %l7
  %t211 = load i1, i1* %l8
  %t212 = load double, double* %l9
  %t213 = load double, double* %l10
  %t214 = load double, double* %l11
  %t215 = load double, double* %l12
  %t216 = load double, double* %l13
  %t217 = load i8*, i8** %l14
  br i1 %t202, label %then18, label %else19
then18:
  %t218 = load i8*, i8** %l14
  %t219 = load i8*, i8** %l14
  %t220 = call i64 @sailfin_runtime_string_length(i8* %t219)
  %t221 = call i8* @sailfin_runtime_substring(i8* %t218, i64 7, i64 %t220)
  store i8* %t221, i8** %l17
  %t222 = load i8*, i8** %l17
  %t223 = call %NumberParseResult @parse_decimal_number(i8* %t222)
  store %NumberParseResult %t223, %NumberParseResult* %l18
  %t224 = load %NumberParseResult, %NumberParseResult* %l18
  %t225 = extractvalue %NumberParseResult %t224, 0
  %t226 = load i8*, i8** %l0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t228 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t230 = load i8*, i8** %l4
  %t231 = load i1, i1* %l5
  %t232 = load i1, i1* %l6
  %t233 = load i1, i1* %l7
  %t234 = load i1, i1* %l8
  %t235 = load double, double* %l9
  %t236 = load double, double* %l10
  %t237 = load double, double* %l11
  %t238 = load double, double* %l12
  %t239 = load double, double* %l13
  %t240 = load i8*, i8** %l14
  %t241 = load i8*, i8** %l17
  %t242 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t225, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t243 = load %NumberParseResult, %NumberParseResult* %l18
  %t244 = extractvalue %NumberParseResult %t243, 1
  store double %t244, double* %l10
  br label %merge23
else22:
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s246 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.246, i32 0, i32 0
  %t247 = add i8* %s246, %enum_name
  %s248 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.248, i32 0, i32 0
  %t249 = add i8* %t247, %s248
  %t250 = load i8*, i8** %l4
  %t251 = add i8* %t249, %t250
  %s252 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.252, i32 0, i32 0
  %t253 = add i8* %t251, %s252
  %t254 = load i8*, i8** %l17
  %t255 = add i8* %t253, %t254
  %t256 = load i8, i8* %t255
  %t257 = add i8 %t256, 96
  %t258 = alloca [2 x i8], align 1
  %t259 = getelementptr [2 x i8], [2 x i8]* %t258, i32 0, i32 0
  store i8 %t257, i8* %t259
  %t260 = getelementptr [2 x i8], [2 x i8]* %t258, i32 0, i32 1
  store i8 0, i8* %t260
  %t261 = getelementptr [2 x i8], [2 x i8]* %t258, i32 0, i32 0
  %t262 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t245, i8* %t261)
  store { i8**, i64 }* %t262, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t263 = phi i1 [ 1, %then21 ], [ %t232, %else22 ]
  %t264 = phi double [ %t244, %then21 ], [ %t236, %else22 ]
  %t265 = phi { i8**, i64 }* [ %t227, %then21 ], [ %t262, %else22 ]
  store i1 %t263, i1* %l6
  store double %t264, double* %l10
  store { i8**, i64 }* %t265, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t266 = load i8*, i8** %l14
  %s267 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.267, i32 0, i32 0
  %t268 = call i1 @starts_with(i8* %t266, i8* %s267)
  %t269 = load i8*, i8** %l0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t273 = load i8*, i8** %l4
  %t274 = load i1, i1* %l5
  %t275 = load i1, i1* %l6
  %t276 = load i1, i1* %l7
  %t277 = load i1, i1* %l8
  %t278 = load double, double* %l9
  %t279 = load double, double* %l10
  %t280 = load double, double* %l11
  %t281 = load double, double* %l12
  %t282 = load double, double* %l13
  %t283 = load i8*, i8** %l14
  br i1 %t268, label %then24, label %else25
then24:
  %t284 = load i8*, i8** %l14
  %t285 = load i8*, i8** %l14
  %t286 = call i64 @sailfin_runtime_string_length(i8* %t285)
  %t287 = call i8* @sailfin_runtime_substring(i8* %t284, i64 5, i64 %t286)
  store i8* %t287, i8** %l19
  %t288 = load i8*, i8** %l19
  %t289 = call %NumberParseResult @parse_decimal_number(i8* %t288)
  store %NumberParseResult %t289, %NumberParseResult* %l20
  %t290 = load %NumberParseResult, %NumberParseResult* %l20
  %t291 = extractvalue %NumberParseResult %t290, 0
  %t292 = load i8*, i8** %l0
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t294 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t296 = load i8*, i8** %l4
  %t297 = load i1, i1* %l5
  %t298 = load i1, i1* %l6
  %t299 = load i1, i1* %l7
  %t300 = load i1, i1* %l8
  %t301 = load double, double* %l9
  %t302 = load double, double* %l10
  %t303 = load double, double* %l11
  %t304 = load double, double* %l12
  %t305 = load double, double* %l13
  %t306 = load i8*, i8** %l14
  %t307 = load i8*, i8** %l19
  %t308 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t291, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t309 = load %NumberParseResult, %NumberParseResult* %l20
  %t310 = extractvalue %NumberParseResult %t309, 1
  store double %t310, double* %l11
  br label %merge29
else28:
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s312 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.312, i32 0, i32 0
  %t313 = add i8* %s312, %enum_name
  %s314 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.314, i32 0, i32 0
  %t315 = add i8* %t313, %s314
  %t316 = load i8*, i8** %l4
  %t317 = add i8* %t315, %t316
  %s318 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.318, i32 0, i32 0
  %t319 = add i8* %t317, %s318
  %t320 = load i8*, i8** %l19
  %t321 = add i8* %t319, %t320
  %t322 = load i8, i8* %t321
  %t323 = add i8 %t322, 96
  %t324 = alloca [2 x i8], align 1
  %t325 = getelementptr [2 x i8], [2 x i8]* %t324, i32 0, i32 0
  store i8 %t323, i8* %t325
  %t326 = getelementptr [2 x i8], [2 x i8]* %t324, i32 0, i32 1
  store i8 0, i8* %t326
  %t327 = getelementptr [2 x i8], [2 x i8]* %t324, i32 0, i32 0
  %t328 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t311, i8* %t327)
  store { i8**, i64 }* %t328, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t329 = phi i1 [ 1, %then27 ], [ %t299, %else28 ]
  %t330 = phi double [ %t310, %then27 ], [ %t303, %else28 ]
  %t331 = phi { i8**, i64 }* [ %t293, %then27 ], [ %t328, %else28 ]
  store i1 %t329, i1* %l7
  store double %t330, double* %l11
  store { i8**, i64 }* %t331, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t332 = load i8*, i8** %l14
  %s333 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.333, i32 0, i32 0
  %t334 = call i1 @starts_with(i8* %t332, i8* %s333)
  %t335 = load i8*, i8** %l0
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t337 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t339 = load i8*, i8** %l4
  %t340 = load i1, i1* %l5
  %t341 = load i1, i1* %l6
  %t342 = load i1, i1* %l7
  %t343 = load i1, i1* %l8
  %t344 = load double, double* %l9
  %t345 = load double, double* %l10
  %t346 = load double, double* %l11
  %t347 = load double, double* %l12
  %t348 = load double, double* %l13
  %t349 = load i8*, i8** %l14
  br i1 %t334, label %then30, label %else31
then30:
  %t350 = load i8*, i8** %l14
  %t351 = load i8*, i8** %l14
  %t352 = call i64 @sailfin_runtime_string_length(i8* %t351)
  %t353 = call i8* @sailfin_runtime_substring(i8* %t350, i64 6, i64 %t352)
  store i8* %t353, i8** %l21
  %t354 = load i8*, i8** %l21
  %t355 = call %NumberParseResult @parse_decimal_number(i8* %t354)
  store %NumberParseResult %t355, %NumberParseResult* %l22
  %t356 = load %NumberParseResult, %NumberParseResult* %l22
  %t357 = extractvalue %NumberParseResult %t356, 0
  %t358 = load i8*, i8** %l0
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t360 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t362 = load i8*, i8** %l4
  %t363 = load i1, i1* %l5
  %t364 = load i1, i1* %l6
  %t365 = load i1, i1* %l7
  %t366 = load i1, i1* %l8
  %t367 = load double, double* %l9
  %t368 = load double, double* %l10
  %t369 = load double, double* %l11
  %t370 = load double, double* %l12
  %t371 = load double, double* %l13
  %t372 = load i8*, i8** %l14
  %t373 = load i8*, i8** %l21
  %t374 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t357, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t375 = load %NumberParseResult, %NumberParseResult* %l22
  %t376 = extractvalue %NumberParseResult %t375, 1
  store double %t376, double* %l12
  br label %merge35
else34:
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s378 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.378, i32 0, i32 0
  %t379 = add i8* %s378, %enum_name
  %s380 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.380, i32 0, i32 0
  %t381 = add i8* %t379, %s380
  %t382 = load i8*, i8** %l4
  %t383 = add i8* %t381, %t382
  %s384 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.384, i32 0, i32 0
  %t385 = add i8* %t383, %s384
  %t386 = load i8*, i8** %l21
  %t387 = add i8* %t385, %t386
  %t388 = load i8, i8* %t387
  %t389 = add i8 %t388, 96
  %t390 = alloca [2 x i8], align 1
  %t391 = getelementptr [2 x i8], [2 x i8]* %t390, i32 0, i32 0
  store i8 %t389, i8* %t391
  %t392 = getelementptr [2 x i8], [2 x i8]* %t390, i32 0, i32 1
  store i8 0, i8* %t392
  %t393 = getelementptr [2 x i8], [2 x i8]* %t390, i32 0, i32 0
  %t394 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t377, i8* %t393)
  store { i8**, i64 }* %t394, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t395 = phi i1 [ 1, %then33 ], [ %t366, %else34 ]
  %t396 = phi double [ %t376, %then33 ], [ %t370, %else34 ]
  %t397 = phi { i8**, i64 }* [ %t359, %then33 ], [ %t394, %else34 ]
  store i1 %t395, i1* %l8
  store double %t396, double* %l12
  store { i8**, i64 }* %t397, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s399 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.399, i32 0, i32 0
  %t400 = add i8* %s399, %enum_name
  %s401 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.401, i32 0, i32 0
  %t402 = add i8* %t400, %s401
  %t403 = load i8*, i8** %l4
  %t404 = add i8* %t402, %t403
  %s405 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.405, i32 0, i32 0
  %t406 = add i8* %t404, %s405
  %t407 = load i8*, i8** %l14
  %t408 = add i8* %t406, %t407
  %t409 = load i8, i8* %t408
  %t410 = add i8 %t409, 96
  %t411 = alloca [2 x i8], align 1
  %t412 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 0
  store i8 %t410, i8* %t412
  %t413 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 1
  store i8 0, i8* %t413
  %t414 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 0
  %t415 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t398, i8* %t414)
  store { i8**, i64 }* %t415, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t416 = phi i1 [ 1, %then30 ], [ %t343, %else31 ]
  %t417 = phi double [ %t376, %then30 ], [ %t347, %else31 ]
  %t418 = phi { i8**, i64 }* [ %t394, %then30 ], [ %t415, %else31 ]
  store i1 %t416, i1* %l8
  store double %t417, double* %l12
  store { i8**, i64 }* %t418, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t419 = phi i1 [ 1, %then24 ], [ %t276, %else25 ]
  %t420 = phi double [ %t310, %then24 ], [ %t280, %else25 ]
  %t421 = phi { i8**, i64 }* [ %t328, %then24 ], [ %t394, %else25 ]
  %t422 = phi i1 [ %t277, %then24 ], [ 1, %else25 ]
  %t423 = phi double [ %t281, %then24 ], [ %t376, %else25 ]
  store i1 %t419, i1* %l7
  store double %t420, double* %l11
  store { i8**, i64 }* %t421, { i8**, i64 }** %l1
  store i1 %t422, i1* %l8
  store double %t423, double* %l12
  br label %merge20
merge20:
  %t424 = phi i1 [ 1, %then18 ], [ %t209, %else19 ]
  %t425 = phi double [ %t244, %then18 ], [ %t213, %else19 ]
  %t426 = phi { i8**, i64 }* [ %t262, %then18 ], [ %t328, %else19 ]
  %t427 = phi i1 [ %t210, %then18 ], [ 1, %else19 ]
  %t428 = phi double [ %t214, %then18 ], [ %t310, %else19 ]
  %t429 = phi i1 [ %t211, %then18 ], [ 1, %else19 ]
  %t430 = phi double [ %t215, %then18 ], [ %t376, %else19 ]
  store i1 %t424, i1* %l6
  store double %t425, double* %l10
  store { i8**, i64 }* %t426, { i8**, i64 }** %l1
  store i1 %t427, i1* %l7
  store double %t428, double* %l11
  store i1 %t429, i1* %l8
  store double %t430, double* %l12
  br label %merge14
merge14:
  %t431 = phi i1 [ 1, %then12 ], [ %t142, %else13 ]
  %t432 = phi double [ %t178, %then12 ], [ %t146, %else13 ]
  %t433 = phi { i8**, i64 }* [ %t196, %then12 ], [ %t262, %else13 ]
  %t434 = phi i1 [ %t143, %then12 ], [ 1, %else13 ]
  %t435 = phi double [ %t147, %then12 ], [ %t244, %else13 ]
  %t436 = phi i1 [ %t144, %then12 ], [ 1, %else13 ]
  %t437 = phi double [ %t148, %then12 ], [ %t310, %else13 ]
  %t438 = phi i1 [ %t145, %then12 ], [ 1, %else13 ]
  %t439 = phi double [ %t149, %then12 ], [ %t376, %else13 ]
  store i1 %t431, i1* %l5
  store double %t432, double* %l9
  store { i8**, i64 }* %t433, { i8**, i64 }** %l1
  store i1 %t434, i1* %l6
  store double %t435, double* %l10
  store i1 %t436, i1* %l7
  store double %t437, double* %l11
  store i1 %t438, i1* %l8
  store double %t439, double* %l12
  %t440 = load double, double* %l13
  %t441 = sitofp i64 1 to double
  %t442 = fadd double %t440, %t441
  store double %t442, double* %l13
  br label %loop.latch8
loop.latch8:
  %t443 = load i1, i1* %l5
  %t444 = load double, double* %l9
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load i1, i1* %l6
  %t447 = load double, double* %l10
  %t448 = load i1, i1* %l7
  %t449 = load double, double* %l11
  %t450 = load i1, i1* %l8
  %t451 = load double, double* %l12
  %t452 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t463 = load i1, i1* %l5
  %t464 = xor i1 %t463, 1
  %t465 = load i8*, i8** %l0
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t467 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t469 = load i8*, i8** %l4
  %t470 = load i1, i1* %l5
  %t471 = load i1, i1* %l6
  %t472 = load i1, i1* %l7
  %t473 = load i1, i1* %l8
  %t474 = load double, double* %l9
  %t475 = load double, double* %l10
  %t476 = load double, double* %l11
  %t477 = load double, double* %l12
  %t478 = load double, double* %l13
  br i1 %t464, label %then36, label %merge37
then36:
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s480 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.480, i32 0, i32 0
  %t481 = add i8* %s480, %enum_name
  %s482 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.482, i32 0, i32 0
  %t483 = add i8* %t481, %s482
  %t484 = load i8*, i8** %l4
  %t485 = add i8* %t483, %t484
  %s486 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.486, i32 0, i32 0
  %t487 = add i8* %t485, %s486
  %t488 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t479, i8* %t487)
  store { i8**, i64 }* %t488, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t489 = phi { i8**, i64 }* [ %t488, %then36 ], [ %t466, %entry ]
  store { i8**, i64 }* %t489, { i8**, i64 }** %l1
  %t490 = load i1, i1* %l6
  %t491 = xor i1 %t490, 1
  %t492 = load i8*, i8** %l0
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t496 = load i8*, i8** %l4
  %t497 = load i1, i1* %l5
  %t498 = load i1, i1* %l6
  %t499 = load i1, i1* %l7
  %t500 = load i1, i1* %l8
  %t501 = load double, double* %l9
  %t502 = load double, double* %l10
  %t503 = load double, double* %l11
  %t504 = load double, double* %l12
  %t505 = load double, double* %l13
  br i1 %t491, label %then38, label %merge39
then38:
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s507 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.507, i32 0, i32 0
  %t508 = add i8* %s507, %enum_name
  %s509 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.509, i32 0, i32 0
  %t510 = add i8* %t508, %s509
  %t511 = load i8*, i8** %l4
  %t512 = add i8* %t510, %t511
  %s513 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.513, i32 0, i32 0
  %t514 = add i8* %t512, %s513
  %t515 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t506, i8* %t514)
  store { i8**, i64 }* %t515, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t516 = phi { i8**, i64 }* [ %t515, %then38 ], [ %t493, %entry ]
  store { i8**, i64 }* %t516, { i8**, i64 }** %l1
  %t517 = load i1, i1* %l7
  %t518 = xor i1 %t517, 1
  %t519 = load i8*, i8** %l0
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t521 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t523 = load i8*, i8** %l4
  %t524 = load i1, i1* %l5
  %t525 = load i1, i1* %l6
  %t526 = load i1, i1* %l7
  %t527 = load i1, i1* %l8
  %t528 = load double, double* %l9
  %t529 = load double, double* %l10
  %t530 = load double, double* %l11
  %t531 = load double, double* %l12
  %t532 = load double, double* %l13
  br i1 %t518, label %then40, label %merge41
then40:
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s534 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.534, i32 0, i32 0
  %t535 = add i8* %s534, %enum_name
  %s536 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.536, i32 0, i32 0
  %t537 = add i8* %t535, %s536
  %t538 = load i8*, i8** %l4
  %t539 = add i8* %t537, %t538
  %s540 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.540, i32 0, i32 0
  %t541 = add i8* %t539, %s540
  %t542 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t533, i8* %t541)
  store { i8**, i64 }* %t542, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t543 = phi { i8**, i64 }* [ %t542, %then40 ], [ %t520, %entry ]
  store { i8**, i64 }* %t543, { i8**, i64 }** %l1
  %t544 = load i1, i1* %l8
  %t545 = xor i1 %t544, 1
  %t546 = load i8*, i8** %l0
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t548 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t550 = load i8*, i8** %l4
  %t551 = load i1, i1* %l5
  %t552 = load i1, i1* %l6
  %t553 = load i1, i1* %l7
  %t554 = load i1, i1* %l8
  %t555 = load double, double* %l9
  %t556 = load double, double* %l10
  %t557 = load double, double* %l11
  %t558 = load double, double* %l12
  %t559 = load double, double* %l13
  br i1 %t545, label %then42, label %merge43
then42:
  %t560 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s561 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.561, i32 0, i32 0
  %t562 = add i8* %s561, %enum_name
  %s563 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.563, i32 0, i32 0
  %t564 = add i8* %t562, %s563
  %t565 = load i8*, i8** %l4
  %t566 = add i8* %t564, %t565
  %s567 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.567, i32 0, i32 0
  %t568 = add i8* %t566, %s567
  %t569 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t560, i8* %t568)
  store { i8**, i64 }* %t569, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t570 = phi { i8**, i64 }* [ %t569, %then42 ], [ %t547, %entry ]
  store { i8**, i64 }* %t570, { i8**, i64 }** %l1
  %t572 = load i1, i1* %l5
  br label %logical_and_entry_571

logical_and_entry_571:
  br i1 %t572, label %logical_and_right_571, label %logical_and_merge_571

logical_and_right_571:
  %t574 = load i1, i1* %l6
  br label %logical_and_entry_573

logical_and_entry_573:
  br i1 %t574, label %logical_and_right_573, label %logical_and_merge_573

logical_and_right_573:
  %t576 = load i1, i1* %l7
  br label %logical_and_entry_575

logical_and_entry_575:
  br i1 %t576, label %logical_and_right_575, label %logical_and_merge_575

logical_and_right_575:
  %t578 = load i1, i1* %l8
  br label %logical_and_entry_577

logical_and_entry_577:
  br i1 %t578, label %logical_and_right_577, label %logical_and_merge_577

logical_and_right_577:
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t580 = load { i8**, i64 }, { i8**, i64 }* %t579
  %t581 = extractvalue { i8**, i64 } %t580, 1
  %t582 = icmp eq i64 %t581, 0
  br label %logical_and_right_end_577

logical_and_right_end_577:
  br label %logical_and_merge_577

logical_and_merge_577:
  %t583 = phi i1 [ false, %logical_and_entry_577 ], [ %t582, %logical_and_right_end_577 ]
  br label %logical_and_right_end_575

logical_and_right_end_575:
  br label %logical_and_merge_575

logical_and_merge_575:
  %t584 = phi i1 [ false, %logical_and_entry_575 ], [ %t583, %logical_and_right_end_575 ]
  br label %logical_and_right_end_573

logical_and_right_end_573:
  br label %logical_and_merge_573

logical_and_merge_573:
  %t585 = phi i1 [ false, %logical_and_entry_573 ], [ %t584, %logical_and_right_end_573 ]
  br label %logical_and_right_end_571

logical_and_right_end_571:
  br label %logical_and_merge_571

logical_and_merge_571:
  %t586 = phi i1 [ false, %logical_and_entry_571 ], [ %t585, %logical_and_right_end_571 ]
  store i1 %t586, i1* %l23
  %t587 = load i8*, i8** %l4
  %t588 = insertvalue %NativeEnumVariantLayout undef, i8* %t587, 0
  %t589 = load double, double* %l9
  %t590 = insertvalue %NativeEnumVariantLayout %t588, double %t589, 1
  %t591 = load double, double* %l10
  %t592 = insertvalue %NativeEnumVariantLayout %t590, double %t591, 2
  %t593 = load double, double* %l11
  %t594 = insertvalue %NativeEnumVariantLayout %t592, double %t593, 3
  %t595 = load double, double* %l12
  %t596 = insertvalue %NativeEnumVariantLayout %t594, double %t595, 4
  %t597 = alloca [0 x %NativeStructLayoutField*]
  %t598 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* %t597, i32 0, i32 0
  %t599 = alloca { %NativeStructLayoutField**, i64 }
  %t600 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t599, i32 0, i32 0
  store %NativeStructLayoutField** %t598, %NativeStructLayoutField*** %t600
  %t601 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t599, i32 0, i32 1
  store i64 0, i64* %t601
  %t602 = insertvalue %NativeEnumVariantLayout %t596, { %NativeStructLayoutField**, i64 }* %t599, 5
  store %NativeEnumVariantLayout %t602, %NativeEnumVariantLayout* %l24
  %t603 = load i1, i1* %l23
  %t604 = insertvalue %EnumLayoutVariantParse undef, i1 %t603, 0
  %t605 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t606 = insertvalue %EnumLayoutVariantParse %t604, %NativeEnumVariantLayout %t605, 1
  %t607 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t608 = insertvalue %EnumLayoutVariantParse %t606, { i8**, i64 }* %t607, 2
  ret %EnumLayoutVariantParse %t608
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
  %t32 = insertvalue %EnumLayoutPayloadParse %t30, %NativeStructLayoutField %t31, 2
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
  %t55 = insertvalue %EnumLayoutPayloadParse %t53, %NativeStructLayoutField %t54, 2
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
  %t103 = insertvalue %EnumLayoutPayloadParse %t101, %NativeStructLayoutField %t102, 2
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
  %t457 = phi i8* [ %t131, %entry ], [ %t448, %loop.latch8 ]
  %t458 = phi i1 [ %t132, %entry ], [ %t449, %loop.latch8 ]
  %t459 = phi double [ %t135, %entry ], [ %t450, %loop.latch8 ]
  %t460 = phi { i8**, i64 }* [ %t124, %entry ], [ %t451, %loop.latch8 ]
  %t461 = phi i1 [ %t133, %entry ], [ %t452, %loop.latch8 ]
  %t462 = phi double [ %t136, %entry ], [ %t453, %loop.latch8 ]
  %t463 = phi i1 [ %t134, %entry ], [ %t454, %loop.latch8 ]
  %t464 = phi double [ %t137, %entry ], [ %t455, %loop.latch8 ]
  %t465 = phi double [ %t138, %entry ], [ %t456, %loop.latch8 ]
  store i8* %t457, i8** %l8
  store i1 %t458, i1* %l9
  store double %t459, double* %l12
  store { i8**, i64 }* %t460, { i8**, i64 }** %l1
  store i1 %t461, i1* %l10
  store double %t462, double* %l13
  store i1 %t463, i1* %l11
  store double %t464, double* %l14
  store double %t465, double* %l15
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
  %t254 = load i8, i8* %t253
  %t255 = add i8 %t254, 96
  %t256 = alloca [2 x i8], align 1
  %t257 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 0
  store i8 %t255, i8* %t257
  %t258 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 1
  store i8 0, i8* %t258
  %t259 = getelementptr [2 x i8], [2 x i8]* %t256, i32 0, i32 0
  %t260 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t243, i8* %t259)
  store { i8**, i64 }* %t260, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t261 = phi i1 [ 1, %then18 ], [ %t231, %else19 ]
  %t262 = phi double [ %t242, %then18 ], [ %t234, %else19 ]
  %t263 = phi { i8**, i64 }* [ %t223, %then18 ], [ %t260, %else19 ]
  store i1 %t261, i1* %l9
  store double %t262, double* %l12
  store { i8**, i64 }* %t263, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t264 = load i8*, i8** %l16
  %s265 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.265, i32 0, i32 0
  %t266 = call i1 @starts_with(i8* %t264, i8* %s265)
  %t267 = load i8*, i8** %l0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t271 = load i8*, i8** %l4
  %t272 = load double, double* %l5
  %t273 = load i8*, i8** %l6
  %t274 = load i8*, i8** %l7
  %t275 = load i8*, i8** %l8
  %t276 = load i1, i1* %l9
  %t277 = load i1, i1* %l10
  %t278 = load i1, i1* %l11
  %t279 = load double, double* %l12
  %t280 = load double, double* %l13
  %t281 = load double, double* %l14
  %t282 = load double, double* %l15
  %t283 = load i8*, i8** %l16
  br i1 %t266, label %then21, label %else22
then21:
  %t284 = load i8*, i8** %l16
  %t285 = load i8*, i8** %l16
  %t286 = call i64 @sailfin_runtime_string_length(i8* %t285)
  %t287 = call i8* @sailfin_runtime_substring(i8* %t284, i64 5, i64 %t286)
  store i8* %t287, i8** %l19
  %t288 = load i8*, i8** %l19
  %t289 = call %NumberParseResult @parse_decimal_number(i8* %t288)
  store %NumberParseResult %t289, %NumberParseResult* %l20
  %t290 = load %NumberParseResult, %NumberParseResult* %l20
  %t291 = extractvalue %NumberParseResult %t290, 0
  %t292 = load i8*, i8** %l0
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t294 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t296 = load i8*, i8** %l4
  %t297 = load double, double* %l5
  %t298 = load i8*, i8** %l6
  %t299 = load i8*, i8** %l7
  %t300 = load i8*, i8** %l8
  %t301 = load i1, i1* %l9
  %t302 = load i1, i1* %l10
  %t303 = load i1, i1* %l11
  %t304 = load double, double* %l12
  %t305 = load double, double* %l13
  %t306 = load double, double* %l14
  %t307 = load double, double* %l15
  %t308 = load i8*, i8** %l16
  %t309 = load i8*, i8** %l19
  %t310 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t291, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t311 = load %NumberParseResult, %NumberParseResult* %l20
  %t312 = extractvalue %NumberParseResult %t311, 1
  store double %t312, double* %l13
  br label %merge26
else25:
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
  %t324 = load i8, i8* %t323
  %t325 = add i8 %t324, 96
  %t326 = alloca [2 x i8], align 1
  %t327 = getelementptr [2 x i8], [2 x i8]* %t326, i32 0, i32 0
  store i8 %t325, i8* %t327
  %t328 = getelementptr [2 x i8], [2 x i8]* %t326, i32 0, i32 1
  store i8 0, i8* %t328
  %t329 = getelementptr [2 x i8], [2 x i8]* %t326, i32 0, i32 0
  %t330 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t313, i8* %t329)
  store { i8**, i64 }* %t330, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t331 = phi i1 [ 1, %then24 ], [ %t302, %else25 ]
  %t332 = phi double [ %t312, %then24 ], [ %t305, %else25 ]
  %t333 = phi { i8**, i64 }* [ %t293, %then24 ], [ %t330, %else25 ]
  store i1 %t331, i1* %l10
  store double %t332, double* %l13
  store { i8**, i64 }* %t333, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t334 = load i8*, i8** %l16
  %s335 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.335, i32 0, i32 0
  %t336 = call i1 @starts_with(i8* %t334, i8* %s335)
  %t337 = load i8*, i8** %l0
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t339 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t341 = load i8*, i8** %l4
  %t342 = load double, double* %l5
  %t343 = load i8*, i8** %l6
  %t344 = load i8*, i8** %l7
  %t345 = load i8*, i8** %l8
  %t346 = load i1, i1* %l9
  %t347 = load i1, i1* %l10
  %t348 = load i1, i1* %l11
  %t349 = load double, double* %l12
  %t350 = load double, double* %l13
  %t351 = load double, double* %l14
  %t352 = load double, double* %l15
  %t353 = load i8*, i8** %l16
  br i1 %t336, label %then27, label %else28
then27:
  %t354 = load i8*, i8** %l16
  %t355 = load i8*, i8** %l16
  %t356 = call i64 @sailfin_runtime_string_length(i8* %t355)
  %t357 = call i8* @sailfin_runtime_substring(i8* %t354, i64 6, i64 %t356)
  store i8* %t357, i8** %l21
  %t358 = load i8*, i8** %l21
  %t359 = call %NumberParseResult @parse_decimal_number(i8* %t358)
  store %NumberParseResult %t359, %NumberParseResult* %l22
  %t360 = load %NumberParseResult, %NumberParseResult* %l22
  %t361 = extractvalue %NumberParseResult %t360, 0
  %t362 = load i8*, i8** %l0
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t364 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t366 = load i8*, i8** %l4
  %t367 = load double, double* %l5
  %t368 = load i8*, i8** %l6
  %t369 = load i8*, i8** %l7
  %t370 = load i8*, i8** %l8
  %t371 = load i1, i1* %l9
  %t372 = load i1, i1* %l10
  %t373 = load i1, i1* %l11
  %t374 = load double, double* %l12
  %t375 = load double, double* %l13
  %t376 = load double, double* %l14
  %t377 = load double, double* %l15
  %t378 = load i8*, i8** %l16
  %t379 = load i8*, i8** %l21
  %t380 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t361, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t381 = load %NumberParseResult, %NumberParseResult* %l22
  %t382 = extractvalue %NumberParseResult %t381, 1
  store double %t382, double* %l14
  br label %merge32
else31:
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s384 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.384, i32 0, i32 0
  %t385 = add i8* %s384, %enum_name
  %s386 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.386, i32 0, i32 0
  %t387 = add i8* %t385, %s386
  %t388 = load i8*, i8** %l4
  %t389 = add i8* %t387, %t388
  %s390 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.390, i32 0, i32 0
  %t391 = add i8* %t389, %s390
  %t392 = load i8*, i8** %l21
  %t393 = add i8* %t391, %t392
  %t394 = load i8, i8* %t393
  %t395 = add i8 %t394, 96
  %t396 = alloca [2 x i8], align 1
  %t397 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 0
  store i8 %t395, i8* %t397
  %t398 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 1
  store i8 0, i8* %t398
  %t399 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 0
  %t400 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t383, i8* %t399)
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t401 = phi i1 [ 1, %then30 ], [ %t373, %else31 ]
  %t402 = phi double [ %t382, %then30 ], [ %t376, %else31 ]
  %t403 = phi { i8**, i64 }* [ %t363, %then30 ], [ %t400, %else31 ]
  store i1 %t401, i1* %l11
  store double %t402, double* %l14
  store { i8**, i64 }* %t403, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s405 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.405, i32 0, i32 0
  %t406 = add i8* %s405, %enum_name
  %s407 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.407, i32 0, i32 0
  %t408 = add i8* %t406, %s407
  %t409 = load i8*, i8** %l4
  %t410 = add i8* %t408, %t409
  %s411 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.411, i32 0, i32 0
  %t412 = add i8* %t410, %s411
  %t413 = load i8*, i8** %l16
  %t414 = add i8* %t412, %t413
  %t415 = load i8, i8* %t414
  %t416 = add i8 %t415, 96
  %t417 = alloca [2 x i8], align 1
  %t418 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 0
  store i8 %t416, i8* %t418
  %t419 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 1
  store i8 0, i8* %t419
  %t420 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 0
  %t421 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t404, i8* %t420)
  store { i8**, i64 }* %t421, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t422 = phi i1 [ 1, %then27 ], [ %t348, %else28 ]
  %t423 = phi double [ %t382, %then27 ], [ %t351, %else28 ]
  %t424 = phi { i8**, i64 }* [ %t400, %then27 ], [ %t421, %else28 ]
  store i1 %t422, i1* %l11
  store double %t423, double* %l14
  store { i8**, i64 }* %t424, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t425 = phi i1 [ 1, %then21 ], [ %t277, %else22 ]
  %t426 = phi double [ %t312, %then21 ], [ %t280, %else22 ]
  %t427 = phi { i8**, i64 }* [ %t330, %then21 ], [ %t400, %else22 ]
  %t428 = phi i1 [ %t278, %then21 ], [ 1, %else22 ]
  %t429 = phi double [ %t281, %then21 ], [ %t382, %else22 ]
  store i1 %t425, i1* %l10
  store double %t426, double* %l13
  store { i8**, i64 }* %t427, { i8**, i64 }** %l1
  store i1 %t428, i1* %l11
  store double %t429, double* %l14
  br label %merge17
merge17:
  %t430 = phi i1 [ 1, %then15 ], [ %t206, %else16 ]
  %t431 = phi double [ %t242, %then15 ], [ %t209, %else16 ]
  %t432 = phi { i8**, i64 }* [ %t260, %then15 ], [ %t330, %else16 ]
  %t433 = phi i1 [ %t207, %then15 ], [ 1, %else16 ]
  %t434 = phi double [ %t210, %then15 ], [ %t312, %else16 ]
  %t435 = phi i1 [ %t208, %then15 ], [ 1, %else16 ]
  %t436 = phi double [ %t211, %then15 ], [ %t382, %else16 ]
  store i1 %t430, i1* %l9
  store double %t431, double* %l12
  store { i8**, i64 }* %t432, { i8**, i64 }** %l1
  store i1 %t433, i1* %l10
  store double %t434, double* %l13
  store i1 %t435, i1* %l11
  store double %t436, double* %l14
  br label %merge14
merge14:
  %t437 = phi i8* [ %t193, %then12 ], [ %t181, %else13 ]
  %t438 = phi i1 [ %t182, %then12 ], [ 1, %else13 ]
  %t439 = phi double [ %t185, %then12 ], [ %t242, %else13 ]
  %t440 = phi { i8**, i64 }* [ %t174, %then12 ], [ %t260, %else13 ]
  %t441 = phi i1 [ %t183, %then12 ], [ 1, %else13 ]
  %t442 = phi double [ %t186, %then12 ], [ %t312, %else13 ]
  %t443 = phi i1 [ %t184, %then12 ], [ 1, %else13 ]
  %t444 = phi double [ %t187, %then12 ], [ %t382, %else13 ]
  store i8* %t437, i8** %l8
  store i1 %t438, i1* %l9
  store double %t439, double* %l12
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  store i1 %t441, i1* %l10
  store double %t442, double* %l13
  store i1 %t443, i1* %l11
  store double %t444, double* %l14
  %t445 = load double, double* %l15
  %t446 = sitofp i64 1 to double
  %t447 = fadd double %t445, %t446
  store double %t447, double* %l15
  br label %loop.latch8
loop.latch8:
  %t448 = load i8*, i8** %l8
  %t449 = load i1, i1* %l9
  %t450 = load double, double* %l12
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t452 = load i1, i1* %l10
  %t453 = load double, double* %l13
  %t454 = load i1, i1* %l11
  %t455 = load double, double* %l14
  %t456 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t466 = load i8*, i8** %l8
  %t467 = call i64 @sailfin_runtime_string_length(i8* %t466)
  %t468 = icmp eq i64 %t467, 0
  %t469 = load i8*, i8** %l0
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t471 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t473 = load i8*, i8** %l4
  %t474 = load double, double* %l5
  %t475 = load i8*, i8** %l6
  %t476 = load i8*, i8** %l7
  %t477 = load i8*, i8** %l8
  %t478 = load i1, i1* %l9
  %t479 = load i1, i1* %l10
  %t480 = load i1, i1* %l11
  %t481 = load double, double* %l12
  %t482 = load double, double* %l13
  %t483 = load double, double* %l14
  %t484 = load double, double* %l15
  br i1 %t468, label %then33, label %merge34
then33:
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s486 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.486, i32 0, i32 0
  %t487 = add i8* %s486, %enum_name
  %s488 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.488, i32 0, i32 0
  %t489 = add i8* %t487, %s488
  %t490 = load i8*, i8** %l4
  %t491 = add i8* %t489, %t490
  %s492 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.492, i32 0, i32 0
  %t493 = add i8* %t491, %s492
  %t494 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t485, i8* %t493)
  store { i8**, i64 }* %t494, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t495 = phi { i8**, i64 }* [ %t494, %then33 ], [ %t470, %entry ]
  store { i8**, i64 }* %t495, { i8**, i64 }** %l1
  %t496 = load i1, i1* %l9
  %t497 = xor i1 %t496, 1
  %t498 = load i8*, i8** %l0
  %t499 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t500 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t502 = load i8*, i8** %l4
  %t503 = load double, double* %l5
  %t504 = load i8*, i8** %l6
  %t505 = load i8*, i8** %l7
  %t506 = load i8*, i8** %l8
  %t507 = load i1, i1* %l9
  %t508 = load i1, i1* %l10
  %t509 = load i1, i1* %l11
  %t510 = load double, double* %l12
  %t511 = load double, double* %l13
  %t512 = load double, double* %l14
  %t513 = load double, double* %l15
  br i1 %t497, label %then35, label %merge36
then35:
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s515 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.515, i32 0, i32 0
  %t516 = add i8* %s515, %enum_name
  %s517 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.517, i32 0, i32 0
  %t518 = add i8* %t516, %s517
  %t519 = load i8*, i8** %l4
  %t520 = add i8* %t518, %t519
  %s521 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.521, i32 0, i32 0
  %t522 = add i8* %t520, %s521
  %t523 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t514, i8* %t522)
  store { i8**, i64 }* %t523, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t524 = phi { i8**, i64 }* [ %t523, %then35 ], [ %t499, %entry ]
  store { i8**, i64 }* %t524, { i8**, i64 }** %l1
  %t525 = load i1, i1* %l10
  %t526 = xor i1 %t525, 1
  %t527 = load i8*, i8** %l0
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t529 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t531 = load i8*, i8** %l4
  %t532 = load double, double* %l5
  %t533 = load i8*, i8** %l6
  %t534 = load i8*, i8** %l7
  %t535 = load i8*, i8** %l8
  %t536 = load i1, i1* %l9
  %t537 = load i1, i1* %l10
  %t538 = load i1, i1* %l11
  %t539 = load double, double* %l12
  %t540 = load double, double* %l13
  %t541 = load double, double* %l14
  %t542 = load double, double* %l15
  br i1 %t526, label %then37, label %merge38
then37:
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s544 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.544, i32 0, i32 0
  %t545 = add i8* %s544, %enum_name
  %s546 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.546, i32 0, i32 0
  %t547 = add i8* %t545, %s546
  %t548 = load i8*, i8** %l4
  %t549 = add i8* %t547, %t548
  %s550 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.550, i32 0, i32 0
  %t551 = add i8* %t549, %s550
  %t552 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t543, i8* %t551)
  store { i8**, i64 }* %t552, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t553 = phi { i8**, i64 }* [ %t552, %then37 ], [ %t528, %entry ]
  store { i8**, i64 }* %t553, { i8**, i64 }** %l1
  %t554 = load i1, i1* %l11
  %t555 = xor i1 %t554, 1
  %t556 = load i8*, i8** %l0
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t558 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t559 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t560 = load i8*, i8** %l4
  %t561 = load double, double* %l5
  %t562 = load i8*, i8** %l6
  %t563 = load i8*, i8** %l7
  %t564 = load i8*, i8** %l8
  %t565 = load i1, i1* %l9
  %t566 = load i1, i1* %l10
  %t567 = load i1, i1* %l11
  %t568 = load double, double* %l12
  %t569 = load double, double* %l13
  %t570 = load double, double* %l14
  %t571 = load double, double* %l15
  br i1 %t555, label %then39, label %merge40
then39:
  %t572 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s573 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.573, i32 0, i32 0
  %t574 = add i8* %s573, %enum_name
  %s575 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.575, i32 0, i32 0
  %t576 = add i8* %t574, %s575
  %t577 = load i8*, i8** %l4
  %t578 = add i8* %t576, %t577
  %s579 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.579, i32 0, i32 0
  %t580 = add i8* %t578, %s579
  %t581 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t572, i8* %t580)
  store { i8**, i64 }* %t581, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t582 = phi { i8**, i64 }* [ %t581, %then39 ], [ %t557, %entry ]
  store { i8**, i64 }* %t582, { i8**, i64 }** %l1
  %t584 = load i8*, i8** %l8
  %t585 = call i64 @sailfin_runtime_string_length(i8* %t584)
  %t586 = icmp sgt i64 %t585, 0
  br label %logical_and_entry_583

logical_and_entry_583:
  br i1 %t586, label %logical_and_right_583, label %logical_and_merge_583

logical_and_right_583:
  %t588 = load i1, i1* %l9
  br label %logical_and_entry_587

logical_and_entry_587:
  br i1 %t588, label %logical_and_right_587, label %logical_and_merge_587

logical_and_right_587:
  %t590 = load i1, i1* %l10
  br label %logical_and_entry_589

logical_and_entry_589:
  br i1 %t590, label %logical_and_right_589, label %logical_and_merge_589

logical_and_right_589:
  %t592 = load i1, i1* %l11
  br label %logical_and_entry_591

logical_and_entry_591:
  br i1 %t592, label %logical_and_right_591, label %logical_and_merge_591

logical_and_right_591:
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t594 = load { i8**, i64 }, { i8**, i64 }* %t593
  %t595 = extractvalue { i8**, i64 } %t594, 1
  %t596 = icmp eq i64 %t595, 0
  br label %logical_and_right_end_591

logical_and_right_end_591:
  br label %logical_and_merge_591

logical_and_merge_591:
  %t597 = phi i1 [ false, %logical_and_entry_591 ], [ %t596, %logical_and_right_end_591 ]
  br label %logical_and_right_end_589

logical_and_right_end_589:
  br label %logical_and_merge_589

logical_and_merge_589:
  %t598 = phi i1 [ false, %logical_and_entry_589 ], [ %t597, %logical_and_right_end_589 ]
  br label %logical_and_right_end_587

logical_and_right_end_587:
  br label %logical_and_merge_587

logical_and_merge_587:
  %t599 = phi i1 [ false, %logical_and_entry_587 ], [ %t598, %logical_and_right_end_587 ]
  br label %logical_and_right_end_583

logical_and_right_end_583:
  br label %logical_and_merge_583

logical_and_merge_583:
  %t600 = phi i1 [ false, %logical_and_entry_583 ], [ %t599, %logical_and_right_end_583 ]
  store i1 %t600, i1* %l23
  %t601 = load i8*, i8** %l7
  %t602 = insertvalue %NativeStructLayoutField undef, i8* %t601, 0
  %t603 = load i8*, i8** %l8
  %t604 = insertvalue %NativeStructLayoutField %t602, i8* %t603, 1
  %t605 = load double, double* %l12
  %t606 = insertvalue %NativeStructLayoutField %t604, double %t605, 2
  %t607 = load double, double* %l13
  %t608 = insertvalue %NativeStructLayoutField %t606, double %t607, 3
  %t609 = load double, double* %l14
  %t610 = insertvalue %NativeStructLayoutField %t608, double %t609, 4
  store %NativeStructLayoutField %t610, %NativeStructLayoutField* %l24
  %t611 = load i1, i1* %l23
  %t612 = insertvalue %EnumLayoutPayloadParse undef, i1 %t611, 0
  %t613 = load i8*, i8** %l6
  %t614 = insertvalue %EnumLayoutPayloadParse %t612, i8* %t613, 1
  %t615 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t616 = insertvalue %EnumLayoutPayloadParse %t614, %NativeStructLayoutField %t615, 2
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t618 = insertvalue %EnumLayoutPayloadParse %t616, { i8**, i64 }* %t617, 3
  ret %EnumLayoutPayloadParse %t618
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
  %t42 = bitcast i8* %span to %NativeSourceSpan*
  %t43 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t44 = bitcast [48 x i8]* %t43 to i8*
  %t45 = getelementptr inbounds i8, i8* %t44, i64 32
  %t46 = bitcast i8* %t45 to %NativeSourceSpan**
  store %NativeSourceSpan* %t42, %NativeSourceSpan** %t46
  %t47 = bitcast i8* %value_span to %NativeSourceSpan*
  %t48 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t49 = bitcast [48 x i8]* %t48 to i8*
  %t50 = getelementptr inbounds i8, i8* %t49, i64 40
  %t51 = bitcast i8* %t50 to %NativeSourceSpan**
  store %NativeSourceSpan* %t47, %NativeSourceSpan** %t51
  %t52 = load %NativeInstruction, %NativeInstruction* %t18
  ret %NativeInstruction %t52
}

define %BindingComponents @parse_binding_components(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi i8* [ %t2, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t3, %entry ], [ %t39, %loop.latch2 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
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
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 32
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t16, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t18 = load i8, i8* %l2
  %t19 = icmp eq i8 %t18, 58
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t19, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t20 = load i8, i8* %l2
  %t21 = icmp eq i8 %t20, 61
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t22 = phi i1 [ true, %logical_or_entry_17 ], [ %t21, %logical_or_right_end_17 ]
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
  %t29 = load i8, i8* %t27
  %t30 = add i8 %t29, %t28
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t30, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8* %t34, i8** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load i8*, i8** %l0
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l0
  %s44 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.44, i32 0, i32 0
  store i8* %s44, i8** %l3
  store i8* null, i8** %l4
  %t45 = load double, double* %l1
  %t46 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t47 = fptosi double %t45 to i64
  %t48 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t47, i64 %t46)
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l5
  %t50 = load i8*, i8** %l5
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = icmp sgt i64 %t51, 0
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l3
  %t56 = load i8*, i8** %l4
  %t57 = load i8*, i8** %l5
  br i1 %t52, label %then8, label %merge9
then8:
  %t58 = load i8*, i8** %l5
  %s59 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.59, i32 0, i32 0
  %t60 = call i1 @starts_with(i8* %t58, i8* %s59)
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l3
  %t64 = load i8*, i8** %l4
  %t65 = load i8*, i8** %l5
  br i1 %t60, label %then10, label %else11
then10:
  %t66 = load i8*, i8** %l5
  %s67 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.67, i32 0, i32 0
  %t68 = call i8* @strip_prefix(i8* %t66, i8* %s67)
  %t69 = call i8* @trim_text(i8* %t68)
  store i8* %t69, i8** %l5
  %t70 = load i8*, i8** %l5
  %t71 = alloca [2 x i8], align 1
  %t72 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  store i8 61, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 1
  store i8 0, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  %t75 = call double @index_of(i8* %t70, i8* %t74)
  store double %t75, double* %l6
  %t76 = load double, double* %l6
  %t77 = sitofp i64 0 to double
  %t78 = fcmp oge double %t76, %t77
  %t79 = load i8*, i8** %l0
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l3
  %t82 = load i8*, i8** %l4
  %t83 = load i8*, i8** %l5
  %t84 = load double, double* %l6
  br i1 %t78, label %then13, label %else14
then13:
  %t85 = load i8*, i8** %l5
  %t86 = load double, double* %l6
  %t87 = fptosi double %t86 to i64
  %t88 = call i8* @sailfin_runtime_substring(i8* %t85, i64 0, i64 %t87)
  %t89 = call i8* @trim_text(i8* %t88)
  store i8* %t89, i8** %l3
  %t90 = load i8*, i8** %l5
  %t91 = load double, double* %l6
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  %t94 = load i8*, i8** %l5
  %t95 = call i64 @sailfin_runtime_string_length(i8* %t94)
  %t96 = fptosi double %t93 to i64
  %t97 = call i8* @sailfin_runtime_substring(i8* %t90, i64 %t96, i64 %t95)
  %t98 = call i8* @trim_text(i8* %t97)
  store i8* %t98, i8** %l7
  %t99 = load i8*, i8** %l7
  %t100 = call i64 @sailfin_runtime_string_length(i8* %t99)
  %t101 = icmp sgt i64 %t100, 0
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l1
  %t104 = load i8*, i8** %l3
  %t105 = load i8*, i8** %l4
  %t106 = load i8*, i8** %l5
  %t107 = load double, double* %l6
  %t108 = load i8*, i8** %l7
  br i1 %t101, label %then16, label %merge17
then16:
  %t109 = load i8*, i8** %l7
  store i8* %t109, i8** %l4
  br label %merge17
merge17:
  %t110 = phi i8* [ %t109, %then16 ], [ %t105, %then13 ]
  store i8* %t110, i8** %l4
  br label %merge15
else14:
  %t111 = load i8*, i8** %l5
  %t112 = call i8* @trim_text(i8* %t111)
  store i8* %t112, i8** %l3
  br label %merge15
merge15:
  %t113 = phi i8* [ %t89, %then13 ], [ %t112, %else14 ]
  %t114 = phi i8* [ %t109, %then13 ], [ %t82, %else14 ]
  store i8* %t113, i8** %l3
  store i8* %t114, i8** %l4
  br label %merge12
else11:
  %t115 = load i8*, i8** %l5
  %t116 = alloca [2 x i8], align 1
  %t117 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 0
  store i8 58, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 1
  store i8 0, i8* %t118
  %t119 = getelementptr [2 x i8], [2 x i8]* %t116, i32 0, i32 0
  %t120 = call i1 @starts_with(i8* %t115, i8* %t119)
  %t121 = load i8*, i8** %l0
  %t122 = load double, double* %l1
  %t123 = load i8*, i8** %l3
  %t124 = load i8*, i8** %l4
  %t125 = load i8*, i8** %l5
  br i1 %t120, label %then18, label %else19
then18:
  %t126 = load i8*, i8** %l5
  %t127 = alloca [2 x i8], align 1
  %t128 = getelementptr [2 x i8], [2 x i8]* %t127, i32 0, i32 0
  store i8 58, i8* %t128
  %t129 = getelementptr [2 x i8], [2 x i8]* %t127, i32 0, i32 1
  store i8 0, i8* %t129
  %t130 = getelementptr [2 x i8], [2 x i8]* %t127, i32 0, i32 0
  %t131 = call i8* @strip_prefix(i8* %t126, i8* %t130)
  %t132 = call i8* @trim_text(i8* %t131)
  store i8* %t132, i8** %l5
  %t133 = load i8*, i8** %l5
  %t134 = alloca [2 x i8], align 1
  %t135 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  store i8 61, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 1
  store i8 0, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  %t138 = call double @index_of(i8* %t133, i8* %t137)
  store double %t138, double* %l8
  %t139 = load double, double* %l8
  %t140 = sitofp i64 0 to double
  %t141 = fcmp oge double %t139, %t140
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load i8*, i8** %l3
  %t145 = load i8*, i8** %l4
  %t146 = load i8*, i8** %l5
  %t147 = load double, double* %l8
  br i1 %t141, label %then21, label %else22
then21:
  %t148 = load i8*, i8** %l5
  %t149 = load double, double* %l8
  %t150 = fptosi double %t149 to i64
  %t151 = call i8* @sailfin_runtime_substring(i8* %t148, i64 0, i64 %t150)
  %t152 = call i8* @trim_text(i8* %t151)
  store i8* %t152, i8** %l3
  %t153 = load i8*, i8** %l5
  %t154 = load double, double* %l8
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  %t157 = load i8*, i8** %l5
  %t158 = call i64 @sailfin_runtime_string_length(i8* %t157)
  %t159 = fptosi double %t156 to i64
  %t160 = call i8* @sailfin_runtime_substring(i8* %t153, i64 %t159, i64 %t158)
  %t161 = call i8* @trim_text(i8* %t160)
  store i8* %t161, i8** %l9
  %t162 = load i8*, i8** %l9
  %t163 = call i64 @sailfin_runtime_string_length(i8* %t162)
  %t164 = icmp sgt i64 %t163, 0
  %t165 = load i8*, i8** %l0
  %t166 = load double, double* %l1
  %t167 = load i8*, i8** %l3
  %t168 = load i8*, i8** %l4
  %t169 = load i8*, i8** %l5
  %t170 = load double, double* %l8
  %t171 = load i8*, i8** %l9
  br i1 %t164, label %then24, label %merge25
then24:
  %t172 = load i8*, i8** %l9
  store i8* %t172, i8** %l4
  br label %merge25
merge25:
  %t173 = phi i8* [ %t172, %then24 ], [ %t168, %then21 ]
  store i8* %t173, i8** %l4
  br label %merge23
else22:
  %t174 = load i8*, i8** %l5
  %t175 = call i8* @trim_text(i8* %t174)
  store i8* %t175, i8** %l3
  br label %merge23
merge23:
  %t176 = phi i8* [ %t152, %then21 ], [ %t175, %else22 ]
  %t177 = phi i8* [ %t172, %then21 ], [ %t145, %else22 ]
  store i8* %t176, i8** %l3
  store i8* %t177, i8** %l4
  br label %merge20
else19:
  %t178 = load i8*, i8** %l5
  %t179 = alloca [2 x i8], align 1
  %t180 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 0
  store i8 61, i8* %t180
  %t181 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 1
  store i8 0, i8* %t181
  %t182 = getelementptr [2 x i8], [2 x i8]* %t179, i32 0, i32 0
  %t183 = call i1 @starts_with(i8* %t178, i8* %t182)
  %t184 = load i8*, i8** %l0
  %t185 = load double, double* %l1
  %t186 = load i8*, i8** %l3
  %t187 = load i8*, i8** %l4
  %t188 = load i8*, i8** %l5
  br i1 %t183, label %then26, label %else27
then26:
  %t189 = load i8*, i8** %l5
  %t190 = alloca [2 x i8], align 1
  %t191 = getelementptr [2 x i8], [2 x i8]* %t190, i32 0, i32 0
  store i8 61, i8* %t191
  %t192 = getelementptr [2 x i8], [2 x i8]* %t190, i32 0, i32 1
  store i8 0, i8* %t192
  %t193 = getelementptr [2 x i8], [2 x i8]* %t190, i32 0, i32 0
  %t194 = call i8* @strip_prefix(i8* %t189, i8* %t193)
  %t195 = call i8* @trim_text(i8* %t194)
  store i8* %t195, i8** %l10
  %t196 = load i8*, i8** %l10
  %t197 = call i64 @sailfin_runtime_string_length(i8* %t196)
  %t198 = icmp sgt i64 %t197, 0
  %t199 = load i8*, i8** %l0
  %t200 = load double, double* %l1
  %t201 = load i8*, i8** %l3
  %t202 = load i8*, i8** %l4
  %t203 = load i8*, i8** %l5
  %t204 = load i8*, i8** %l10
  br i1 %t198, label %then29, label %merge30
then29:
  %t205 = load i8*, i8** %l10
  store i8* %t205, i8** %l4
  br label %merge30
merge30:
  %t206 = phi i8* [ %t205, %then29 ], [ %t202, %then26 ]
  store i8* %t206, i8** %l4
  br label %merge28
else27:
  %t207 = load i8*, i8** %l5
  store i8* %t207, i8** %l4
  br label %merge28
merge28:
  %t208 = phi i8* [ %t205, %then26 ], [ %t207, %else27 ]
  store i8* %t208, i8** %l4
  br label %merge20
merge20:
  %t209 = phi i8* [ %t132, %then18 ], [ %t125, %else19 ]
  %t210 = phi i8* [ %t152, %then18 ], [ %t123, %else19 ]
  %t211 = phi i8* [ %t172, %then18 ], [ %t205, %else19 ]
  store i8* %t209, i8** %l5
  store i8* %t210, i8** %l3
  store i8* %t211, i8** %l4
  br label %merge12
merge12:
  %t212 = phi i8* [ %t69, %then10 ], [ %t132, %else11 ]
  %t213 = phi i8* [ %t89, %then10 ], [ %t152, %else11 ]
  %t214 = phi i8* [ %t109, %then10 ], [ %t172, %else11 ]
  store i8* %t212, i8** %l5
  store i8* %t213, i8** %l3
  store i8* %t214, i8** %l4
  br label %merge9
merge9:
  %t215 = phi i8* [ %t69, %then8 ], [ %t57, %entry ]
  %t216 = phi i8* [ %t89, %then8 ], [ %t55, %entry ]
  %t217 = phi i8* [ %t109, %then8 ], [ %t56, %entry ]
  %t218 = phi i8* [ %t112, %then8 ], [ %t55, %entry ]
  %t219 = phi i8* [ %t132, %then8 ], [ %t57, %entry ]
  %t220 = phi i8* [ %t152, %then8 ], [ %t55, %entry ]
  %t221 = phi i8* [ %t172, %then8 ], [ %t56, %entry ]
  %t222 = phi i8* [ %t175, %then8 ], [ %t55, %entry ]
  %t223 = phi i8* [ %t205, %then8 ], [ %t56, %entry ]
  %t224 = phi i8* [ %t207, %then8 ], [ %t56, %entry ]
  store i8* %t215, i8** %l5
  store i8* %t216, i8** %l3
  store i8* %t217, i8** %l4
  store i8* %t218, i8** %l3
  store i8* %t219, i8** %l5
  store i8* %t220, i8** %l3
  store i8* %t221, i8** %l4
  store i8* %t222, i8** %l3
  store i8* %t223, i8** %l4
  store i8* %t224, i8** %l4
  %t225 = load i8*, i8** %l0
  %t226 = insertvalue %BindingComponents undef, i8* %t225, 0
  %t227 = load i8*, i8** %l3
  %t228 = insertvalue %BindingComponents %t226, i8* %t227, 1
  %t229 = load i8*, i8** %l4
  %t230 = insertvalue %BindingComponents %t228, i8* %t229, 2
  ret %BindingComponents %t230
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
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.20, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l1
  %t22 = load double, double* %l1
  %t23 = sitofp i64 0 to double
  %t24 = fcmp oge double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 0, i64 %t29)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t38 = load i8*, i8** %l2
  %s39 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.39, i32 0, i32 0
  %t40 = call i1 @starts_with(i8* %t38, i8* %s39)
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then10, label %merge11
then10:
  %t44 = load i8*, i8** %l2
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i8* @strip_prefix(i8* %t44, i8* %s45)
  %t47 = call i8* @trim_text(i8* %t46)
  store i8* %t47, i8** %l2
  br label %merge11
merge11:
  %t48 = phi i8* [ %t47, %then10 ], [ %t43, %then6 ]
  store i8* %t48, i8** %l2
  %t49 = load i8*, i8** %l2
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = icmp eq i64 %t50, 0
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  br i1 %t51, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t55 = load i8*, i8** %l2
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 32, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  %t60 = call double @index_of(i8* %t55, i8* %t59)
  %t61 = sitofp i64 0 to double
  %t62 = fcmp oge double %t60, %t61
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load i8*, i8** %l2
  br i1 %t62, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t66 = load i8*, i8** %l2
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 9, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  %t71 = call double @index_of(i8* %t66, i8* %t70)
  %t72 = sitofp i64 0 to double
  %t73 = fcmp oge double %t71, %t72
  %t74 = load i8*, i8** %l0
  %t75 = load double, double* %l1
  %t76 = load i8*, i8** %l2
  br i1 %t73, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t77 = load i8*, i8** %l0
  %t78 = alloca [2 x i8], align 1
  %t79 = getelementptr [2 x i8], [2 x i8]* %t78, i32 0, i32 0
  store i8 61, i8* %t79
  %t80 = getelementptr [2 x i8], [2 x i8]* %t78, i32 0, i32 1
  store i8 0, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t78, i32 0, i32 0
  %t82 = call double @index_of(i8* %t77, i8* %t81)
  store double %t82, double* %l3
  %t83 = load double, double* %l3
  %t84 = sitofp i64 0 to double
  %t85 = fcmp oge double %t83, %t84
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l3
  br i1 %t85, label %then18, label %merge19
then18:
  %t89 = load i8*, i8** %l0
  %t90 = load double, double* %l3
  %t91 = fptosi double %t90 to i64
  %t92 = call i8* @sailfin_runtime_substring(i8* %t89, i64 0, i64 %t91)
  %t93 = call i8* @trim_text(i8* %t92)
  store i8* %t93, i8** %l4
  %t94 = load i8*, i8** %l4
  %t95 = call i64 @sailfin_runtime_string_length(i8* %t94)
  %t96 = icmp eq i64 %t95, 0
  %t97 = load i8*, i8** %l0
  %t98 = load double, double* %l1
  %t99 = load double, double* %l3
  %t100 = load i8*, i8** %l4
  br i1 %t96, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t101 = load i8*, i8** %l4
  %s102 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.102, i32 0, i32 0
  %t103 = call i1 @starts_with(i8* %t101, i8* %s102)
  %t104 = load i8*, i8** %l0
  %t105 = load double, double* %l1
  %t106 = load double, double* %l3
  %t107 = load i8*, i8** %l4
  br i1 %t103, label %then22, label %merge23
then22:
  %t108 = load i8*, i8** %l4
  %s109 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.109, i32 0, i32 0
  %t110 = call i8* @strip_prefix(i8* %t108, i8* %s109)
  %t111 = call i8* @trim_text(i8* %t110)
  store i8* %t111, i8** %l4
  br label %merge23
merge23:
  %t112 = phi i8* [ %t111, %then22 ], [ %t107, %then18 ]
  store i8* %t112, i8** %l4
  %t113 = load i8*, i8** %l4
  %t114 = call i64 @sailfin_runtime_string_length(i8* %t113)
  %t115 = icmp eq i64 %t114, 0
  %t116 = load i8*, i8** %l0
  %t117 = load double, double* %l1
  %t118 = load double, double* %l3
  %t119 = load i8*, i8** %l4
  br i1 %t115, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t120 = load i8*, i8** %l4
  %t121 = alloca [2 x i8], align 1
  %t122 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8 32, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 1
  store i8 0, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  %t125 = call double @index_of(i8* %t120, i8* %t124)
  %t126 = sitofp i64 0 to double
  %t127 = fcmp oge double %t125, %t126
  %t128 = load i8*, i8** %l0
  %t129 = load double, double* %l1
  %t130 = load double, double* %l3
  %t131 = load i8*, i8** %l4
  br i1 %t127, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t132 = load i8*, i8** %l4
  %t133 = alloca [2 x i8], align 1
  %t134 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  store i8 9, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 1
  store i8 0, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t133, i32 0, i32 0
  %t137 = call double @index_of(i8* %t132, i8* %t136)
  %t138 = sitofp i64 0 to double
  %t139 = fcmp oge double %t137, %t138
  %t140 = load i8*, i8** %l0
  %t141 = load double, double* %l1
  %t142 = load double, double* %l3
  %t143 = load i8*, i8** %l4
  br i1 %t139, label %then28, label %merge29
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
  %t239 = phi i8* [ %t10, %entry ], [ %t234, %loop.latch2 ]
  %t240 = phi double [ %t11, %entry ], [ %t235, %loop.latch2 ]
  %t241 = phi i8* [ %t13, %entry ], [ %t236, %loop.latch2 ]
  %t242 = phi double [ %t12, %entry ], [ %t237, %loop.latch2 ]
  %t243 = phi { i8**, i64 }* [ %t9, %entry ], [ %t238, %loop.latch2 ]
  store i8* %t239, i8** %l1
  store double %t240, double* %l2
  store i8* %t241, i8** %l4
  store double %t242, double* %l3
  store { i8**, i64 }* %t243, { i8**, i64 }** %l0
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
  %t38 = load i8, i8* %t36
  %t39 = add i8 %t38, %t37
  %t40 = alloca [2 x i8], align 1
  %t41 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8 %t39, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 1
  store i8 0, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t40, i32 0, i32 0
  store i8* %t43, i8** %l1
  %t44 = load i8, i8* %l5
  %t45 = icmp eq i8 %t44, 92
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load i8*, i8** %l4
  %t51 = load i8, i8* %l5
  br i1 %t45, label %then8, label %merge9
then8:
  %t52 = load double, double* %l2
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  %t55 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp olt double %t54, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load i8*, i8** %l4
  %t63 = load i8, i8* %l5
  br i1 %t57, label %then10, label %merge11
then10:
  %t64 = load i8*, i8** %l1
  %t65 = load double, double* %l2
  %t66 = sitofp i64 2 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t68 = phi i8* [ null, %then8 ], [ %t47, %then6 ]
  %t69 = phi double [ %t67, %then8 ], [ %t48, %then6 ]
  store i8* %t68, i8** %l1
  store double %t69, double* %l2
  %t70 = load i8, i8* %l5
  %t71 = load i8*, i8** %l4
  %t72 = load i8, i8* %t71
  %t73 = icmp eq i8 %t70, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load double, double* %l2
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l4
  %t79 = load i8, i8* %l5
  br i1 %t73, label %then12, label %merge13
then12:
  %s80 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.80, i32 0, i32 0
  store i8* %s80, i8** %l4
  br label %merge13
merge13:
  %t81 = phi i8* [ %s80, %then12 ], [ %t78, %then6 ]
  store i8* %t81, i8** %l4
  %t82 = load double, double* %l2
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l2
  br label %loop.latch2
merge7:
  %t86 = load i8, i8* %l5
  %t87 = icmp eq i8 %t86, 34
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t87, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t88 = load i8, i8* %l5
  %t89 = icmp eq i8 %t88, 39
  br label %logical_or_right_end_85

logical_or_right_end_85:
  br label %logical_or_merge_85

logical_or_merge_85:
  %t90 = phi i1 [ true, %logical_or_entry_85 ], [ %t89, %logical_or_right_end_85 ]
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load double, double* %l2
  %t94 = load double, double* %l3
  %t95 = load i8*, i8** %l4
  %t96 = load i8, i8* %l5
  br i1 %t90, label %then14, label %merge15
then14:
  %t97 = load i8, i8* %l5
  %t98 = alloca [2 x i8], align 1
  %t99 = getelementptr [2 x i8], [2 x i8]* %t98, i32 0, i32 0
  store i8 %t97, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t98, i32 0, i32 1
  store i8 0, i8* %t100
  %t101 = getelementptr [2 x i8], [2 x i8]* %t98, i32 0, i32 0
  store i8* %t101, i8** %l4
  %t102 = load i8*, i8** %l1
  %t103 = load i8, i8* %l5
  %t104 = load i8, i8* %t102
  %t105 = add i8 %t104, %t103
  %t106 = alloca [2 x i8], align 1
  %t107 = getelementptr [2 x i8], [2 x i8]* %t106, i32 0, i32 0
  store i8 %t105, i8* %t107
  %t108 = getelementptr [2 x i8], [2 x i8]* %t106, i32 0, i32 1
  store i8 0, i8* %t108
  %t109 = getelementptr [2 x i8], [2 x i8]* %t106, i32 0, i32 0
  store i8* %t109, i8** %l1
  %t110 = load double, double* %l2
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l2
  br label %loop.latch2
merge15:
  %t114 = load i8, i8* %l5
  %t115 = icmp eq i8 %t114, 40
  br label %logical_or_entry_113

logical_or_entry_113:
  br i1 %t115, label %logical_or_merge_113, label %logical_or_right_113

logical_or_right_113:
  %t117 = load i8, i8* %l5
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_entry_116

logical_or_entry_116:
  br i1 %t118, label %logical_or_merge_116, label %logical_or_right_116

logical_or_right_116:
  %t119 = load i8, i8* %l5
  %t120 = icmp eq i8 %t119, 123
  br label %logical_or_right_end_116

logical_or_right_end_116:
  br label %logical_or_merge_116

logical_or_merge_116:
  %t121 = phi i1 [ true, %logical_or_entry_116 ], [ %t120, %logical_or_right_end_116 ]
  br label %logical_or_right_end_113

logical_or_right_end_113:
  br label %logical_or_merge_113

logical_or_merge_113:
  %t122 = phi i1 [ true, %logical_or_entry_113 ], [ %t121, %logical_or_right_end_113 ]
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load i8*, i8** %l1
  %t125 = load double, double* %l2
  %t126 = load double, double* %l3
  %t127 = load i8*, i8** %l4
  %t128 = load i8, i8* %l5
  br i1 %t122, label %then16, label %merge17
then16:
  %t129 = load double, double* %l3
  %t130 = sitofp i64 1 to double
  %t131 = fadd double %t129, %t130
  store double %t131, double* %l3
  %t132 = load i8*, i8** %l1
  %t133 = load i8, i8* %l5
  %t134 = load i8, i8* %t132
  %t135 = add i8 %t134, %t133
  %t136 = alloca [2 x i8], align 1
  %t137 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8 %t135, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 1
  store i8 0, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8* %t139, i8** %l1
  %t140 = load double, double* %l2
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l2
  br label %loop.latch2
merge17:
  %t144 = load i8, i8* %l5
  %t145 = icmp eq i8 %t144, 41
  br label %logical_or_entry_143

logical_or_entry_143:
  br i1 %t145, label %logical_or_merge_143, label %logical_or_right_143

logical_or_right_143:
  %t147 = load i8, i8* %l5
  %t148 = icmp eq i8 %t147, 93
  br label %logical_or_entry_146

logical_or_entry_146:
  br i1 %t148, label %logical_or_merge_146, label %logical_or_right_146

logical_or_right_146:
  %t149 = load i8, i8* %l5
  %t150 = icmp eq i8 %t149, 125
  br label %logical_or_right_end_146

logical_or_right_end_146:
  br label %logical_or_merge_146

logical_or_merge_146:
  %t151 = phi i1 [ true, %logical_or_entry_146 ], [ %t150, %logical_or_right_end_146 ]
  br label %logical_or_right_end_143

logical_or_right_end_143:
  br label %logical_or_merge_143

logical_or_merge_143:
  %t152 = phi i1 [ true, %logical_or_entry_143 ], [ %t151, %logical_or_right_end_143 ]
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = load i8*, i8** %l1
  %t155 = load double, double* %l2
  %t156 = load double, double* %l3
  %t157 = load i8*, i8** %l4
  %t158 = load i8, i8* %l5
  br i1 %t152, label %then18, label %merge19
then18:
  %t159 = load double, double* %l3
  %t160 = sitofp i64 0 to double
  %t161 = fcmp ogt double %t159, %t160
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load i8*, i8** %l1
  %t164 = load double, double* %l2
  %t165 = load double, double* %l3
  %t166 = load i8*, i8** %l4
  %t167 = load i8, i8* %l5
  br i1 %t161, label %then20, label %merge21
then20:
  %t168 = load double, double* %l3
  %t169 = sitofp i64 1 to double
  %t170 = fsub double %t168, %t169
  store double %t170, double* %l3
  br label %merge21
merge21:
  %t171 = phi double [ %t170, %then20 ], [ %t165, %then18 ]
  store double %t171, double* %l3
  %t172 = load i8*, i8** %l1
  %t173 = load i8, i8* %l5
  %t174 = load i8, i8* %t172
  %t175 = add i8 %t174, %t173
  %t176 = alloca [2 x i8], align 1
  %t177 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 0
  store i8 %t175, i8* %t177
  %t178 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 1
  store i8 0, i8* %t178
  %t179 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 0
  store i8* %t179, i8** %l1
  %t180 = load double, double* %l2
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l2
  br label %loop.latch2
merge19:
  %t183 = load i8, i8* %l5
  %t184 = icmp eq i8 %t183, 44
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load i8*, i8** %l1
  %t187 = load double, double* %l2
  %t188 = load double, double* %l3
  %t189 = load i8*, i8** %l4
  %t190 = load i8, i8* %l5
  br i1 %t184, label %then22, label %merge23
then22:
  %t191 = load double, double* %l3
  %t192 = sitofp i64 0 to double
  %t193 = fcmp oeq double %t191, %t192
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  %t197 = load double, double* %l3
  %t198 = load i8*, i8** %l4
  %t199 = load i8, i8* %l5
  br i1 %t193, label %then24, label %merge25
then24:
  %t200 = load i8*, i8** %l1
  %t201 = call i8* @trim_text(i8* %t200)
  store i8* %t201, i8** %l6
  %t202 = load i8*, i8** %l6
  %t203 = call i64 @sailfin_runtime_string_length(i8* %t202)
  %t204 = icmp sgt i64 %t203, 0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load i8*, i8** %l1
  %t207 = load double, double* %l2
  %t208 = load double, double* %l3
  %t209 = load i8*, i8** %l4
  %t210 = load i8, i8* %l5
  %t211 = load i8*, i8** %l6
  br i1 %t204, label %then26, label %merge27
then26:
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load i8*, i8** %l6
  %t214 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t212, i8* %t213)
  store { i8**, i64 }* %t214, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t215 = phi { i8**, i64 }* [ %t214, %then26 ], [ %t205, %then24 ]
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  %s216 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.216, i32 0, i32 0
  store i8* %s216, i8** %l1
  %t217 = load double, double* %l2
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l2
  br label %loop.latch2
merge25:
  br label %merge23
merge23:
  %t220 = phi { i8**, i64 }* [ %t214, %then22 ], [ %t185, %loop.body1 ]
  %t221 = phi i8* [ %s216, %then22 ], [ %t186, %loop.body1 ]
  %t222 = phi double [ %t219, %then22 ], [ %t187, %loop.body1 ]
  store { i8**, i64 }* %t220, { i8**, i64 }** %l0
  store i8* %t221, i8** %l1
  store double %t222, double* %l2
  %t223 = load i8*, i8** %l1
  %t224 = load i8, i8* %l5
  %t225 = load i8, i8* %t223
  %t226 = add i8 %t225, %t224
  %t227 = alloca [2 x i8], align 1
  %t228 = getelementptr [2 x i8], [2 x i8]* %t227, i32 0, i32 0
  store i8 %t226, i8* %t228
  %t229 = getelementptr [2 x i8], [2 x i8]* %t227, i32 0, i32 1
  store i8 0, i8* %t229
  %t230 = getelementptr [2 x i8], [2 x i8]* %t227, i32 0, i32 0
  store i8* %t230, i8** %l1
  %t231 = load double, double* %l2
  %t232 = sitofp i64 1 to double
  %t233 = fadd double %t231, %t232
  store double %t233, double* %l2
  br label %loop.latch2
loop.latch2:
  %t234 = load i8*, i8** %l1
  %t235 = load double, double* %l2
  %t236 = load i8*, i8** %l4
  %t237 = load double, double* %l3
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t244 = load i8*, i8** %l1
  %t245 = call i8* @trim_text(i8* %t244)
  store i8* %t245, i8** %l7
  %t246 = load i8*, i8** %l7
  %t247 = call i64 @sailfin_runtime_string_length(i8* %t246)
  %t248 = icmp sgt i64 %t247, 0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = load i8*, i8** %l1
  %t251 = load double, double* %l2
  %t252 = load double, double* %l3
  %t253 = load i8*, i8** %l4
  %t254 = load i8*, i8** %l7
  br i1 %t248, label %then28, label %merge29
then28:
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t256 = load i8*, i8** %l7
  %t257 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t255, i8* %t256)
  store { i8**, i64 }* %t257, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t258 = phi { i8**, i64 }* [ %t257, %then28 ], [ %t249, %entry ]
  store { i8**, i64 }* %t258, { i8**, i64 }** %l0
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t259
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
  %l3 = alloca i8*
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
  %t83 = phi { i8**, i64 }* [ %t11, %entry ], [ %t80, %loop.latch4 ]
  %t84 = phi double [ %t12, %entry ], [ %t81, %loop.latch4 ]
  %t85 = phi double [ %t13, %entry ], [ %t82, %loop.latch4 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  store double %t84, double* %l1
  store double %t85, double* %l2
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
  %t22 = call i8* @text_char_at(i8* %value, double %t21)
  store i8* %t22, i8** %l3
  %t24 = load i8*, i8** %l3
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 32
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t26, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t28 = load i8*, i8** %l3
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 9
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t32 = load i8*, i8** %l3
  %t33 = load i8, i8* %t32
  %t34 = icmp eq i8 %t33, 10
  br label %logical_or_entry_31

logical_or_entry_31:
  br i1 %t34, label %logical_or_merge_31, label %logical_or_right_31

logical_or_right_31:
  %t35 = load i8*, i8** %l3
  %t36 = load i8, i8* %t35
  %t37 = icmp eq i8 %t36, 13
  br label %logical_or_right_end_31

logical_or_right_end_31:
  br label %logical_or_merge_31

logical_or_merge_31:
  %t38 = phi i1 [ true, %logical_or_entry_31 ], [ %t37, %logical_or_right_end_31 ]
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t39 = phi i1 [ true, %logical_or_entry_27 ], [ %t38, %logical_or_right_end_27 ]
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t40 = phi i1 [ true, %logical_or_entry_23 ], [ %t39, %logical_or_right_end_23 ]
  store i1 %t40, i1* %l4
  %t41 = load i1, i1* %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  %t45 = load i8*, i8** %l3
  %t46 = load i1, i1* %l4
  br i1 %t41, label %then8, label %else9
then8:
  %t47 = load double, double* %l1
  %t48 = sitofp i64 0 to double
  %t49 = fcmp oge double %t47, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load double, double* %l2
  %t53 = load i8*, i8** %l3
  %t54 = load i1, i1* %l4
  br i1 %t49, label %then11, label %merge12
then11:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = fptosi double %t56 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t58, i64 %t59)
  %t61 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t55, i8* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  %t62 = sitofp i64 -1 to double
  store double %t62, double* %l1
  br label %merge12
merge12:
  %t63 = phi { i8**, i64 }* [ %t61, %then11 ], [ %t50, %then8 ]
  %t64 = phi double [ %t62, %then11 ], [ %t51, %then8 ]
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  store double %t64, double* %l1
  br label %merge10
else9:
  %t65 = load double, double* %l1
  %t66 = sitofp i64 0 to double
  %t67 = fcmp olt double %t65, %t66
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l3
  %t72 = load i1, i1* %l4
  br i1 %t67, label %then13, label %merge14
then13:
  %t73 = load double, double* %l2
  store double %t73, double* %l1
  br label %merge14
merge14:
  %t74 = phi double [ %t73, %then13 ], [ %t69, %else9 ]
  store double %t74, double* %l1
  br label %merge10
merge10:
  %t75 = phi { i8**, i64 }* [ %t61, %then8 ], [ %t42, %else9 ]
  %t76 = phi double [ %t62, %then8 ], [ %t73, %else9 ]
  store { i8**, i64 }* %t75, { i8**, i64 }** %l0
  store double %t76, double* %l1
  %t77 = load double, double* %l2
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l2
  br label %loop.latch4
loop.latch4:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load double, double* %l1
  %t82 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t86 = load double, double* %l1
  %t87 = sitofp i64 0 to double
  %t88 = fcmp oge double %t86, %t87
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load double, double* %l1
  %t91 = load double, double* %l2
  br i1 %t88, label %then15, label %merge16
then15:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load double, double* %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t95 = fptosi double %t93 to i64
  %t96 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t95, i64 %t94)
  %t97 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t92, i8* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l0
  br label %merge16
merge16:
  %t98 = phi { i8**, i64 }* [ %t97, %then15 ], [ %t89, %entry ]
  store { i8**, i64 }* %t98, { i8**, i64 }** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t99
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
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 48, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call double @char_code(i8* %t11)
  store double %t12, double* %l1
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 57, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call double @char_code(i8* %t16)
  store double %t17, double* %l2
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l3
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l4
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t77 = phi double [ %t24, %entry ], [ %t75, %loop.latch4 ]
  %t78 = phi double [ %t23, %entry ], [ %t76, %loop.latch4 ]
  store double %t77, double* %l4
  store double %t78, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l3
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %t35, i64 %t37
  %t39 = load i8, i8* %t38
  store i8 %t39, i8* %l5
  %t40 = load i8, i8* %l5
  %t41 = alloca [2 x i8], align 1
  %t42 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8 %t40, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 1
  store i8 0, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  %t45 = call double @char_code(i8* %t44)
  store double %t45, double* %l6
  %t47 = load double, double* %l6
  %t48 = load double, double* %l1
  %t49 = fcmp olt double %t47, %t48
  br label %logical_or_entry_46

logical_or_entry_46:
  br i1 %t49, label %logical_or_merge_46, label %logical_or_right_46

logical_or_right_46:
  %t50 = load double, double* %l6
  %t51 = load double, double* %l2
  %t52 = fcmp ogt double %t50, %t51
  br label %logical_or_right_end_46

logical_or_right_end_46:
  br label %logical_or_merge_46

logical_or_merge_46:
  %t53 = phi i1 [ true, %logical_or_entry_46 ], [ %t52, %logical_or_right_end_46 ]
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l4
  %t59 = load i8, i8* %l5
  %t60 = load double, double* %l6
  br i1 %t53, label %then8, label %merge9
then8:
  %t61 = insertvalue %NumberParseResult undef, i1 0, 0
  %t62 = sitofp i64 0 to double
  %t63 = insertvalue %NumberParseResult %t61, double %t62, 1
  ret %NumberParseResult %t63
merge9:
  %t64 = load double, double* %l6
  %t65 = load double, double* %l1
  %t66 = fsub double %t64, %t65
  store double %t66, double* %l7
  %t67 = load double, double* %l4
  %t68 = sitofp i64 10 to double
  %t69 = fmul double %t67, %t68
  %t70 = load double, double* %l7
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l4
  %t72 = load double, double* %l3
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l3
  br label %loop.latch4
loop.latch4:
  %t75 = load double, double* %l4
  %t76 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t79 = insertvalue %NumberParseResult undef, i1 1, 0
  %t80 = load double, double* %l4
  %t81 = insertvalue %NumberParseResult %t79, double %t80, 1
  ret %NumberParseResult %t81
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
  %t47 = phi { i8**, i64 }* [ %t7, %entry ], [ %t44, %loop.latch2 ]
  %t48 = phi i8* [ %t8, %entry ], [ %t45, %loop.latch2 ]
  %t49 = phi double [ %t9, %entry ], [ %t46, %loop.latch2 ]
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  store i8* %t48, i8** %l1
  store double %t49, double* %l2
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
  %t33 = load i8, i8* %t31
  %t34 = add i8 %t33, %t32
  %t35 = alloca [2 x i8], align 1
  %t36 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 0
  store i8 %t34, i8* %t36
  %t37 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 1
  store i8 0, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t35, i32 0, i32 0
  store i8* %t38, i8** %l1
  br label %merge8
merge8:
  %t39 = phi { i8**, i64 }* [ %t29, %then6 ], [ %t23, %else7 ]
  %t40 = phi i8* [ %s30, %then6 ], [ %t38, %else7 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store i8* %t40, i8** %l1
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l2
  br label %loop.latch2
loop.latch2:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t50, i8* %t51)
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t53
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
  %t34 = load i8, i8* %t32
  %t35 = add i8 %t34, %t33
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 %t35, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8* %t39, i8** %l1
  br label %merge8
merge8:
  %t40 = phi { i8**, i64 }* [ %t30, %then6 ], [ %t23, %else7 ]
  %t41 = phi i8* [ %s31, %then6 ], [ %t39, %else7 ]
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
  %t51 = load i8*, i8** %l1
  %t52 = call i64 @sailfin_runtime_string_length(i8* %t51)
  %t53 = icmp sgt i64 %t52, 0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  br i1 %t53, label %then9, label %merge10
then9:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load i8*, i8** %l1
  %t59 = call i8* @trim_text(i8* %t58)
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t61 = phi { i8**, i64 }* [ %t60, %then9 ], [ %t54, %entry ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  %t62 = alloca [0 x i8*]
  %t63 = getelementptr [0 x i8*], [0 x i8*]* %t62, i32 0, i32 0
  %t64 = alloca { i8**, i64 }
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 0
  store i8** %t63, i8*** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  store { i8**, i64 }* %t64, { i8**, i64 }** %l4
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l2
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t108 = phi { i8**, i64 }* [ %t71, %entry ], [ %t106, %loop.latch13 ]
  %t109 = phi double [ %t70, %entry ], [ %t107, %loop.latch13 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l4
  store double %t109, double* %l2
  br label %loop.body12
loop.body12:
  %t72 = load double, double* %l2
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }, { i8**, i64 }* %t73
  %t75 = extractvalue { i8**, i64 } %t74, 1
  %t76 = sitofp i64 %t75 to double
  %t77 = fcmp oge double %t72, %t76
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l2
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t77, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load double, double* %l2
  %t84 = fptosi double %t83 to i64
  %t85 = load { i8**, i64 }, { i8**, i64 }* %t82
  %t86 = extractvalue { i8**, i64 } %t85, 0
  %t87 = extractvalue { i8**, i64 } %t85, 1
  %t88 = icmp uge i64 %t84, %t87
  ; bounds check: %t88 (if true, out of bounds)
  %t89 = getelementptr i8*, i8** %t86, i64 %t84
  %t90 = load i8*, i8** %t89
  store i8* %t90, i8** %l5
  %t91 = load i8*, i8** %l5
  %t92 = call i64 @sailfin_runtime_string_length(i8* %t91)
  %t93 = icmp sgt i64 %t92, 0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l2
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t98 = load i8*, i8** %l5
  br i1 %t93, label %then17, label %merge18
then17:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t100 = load i8*, i8** %l5
  %t101 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t99, i8* %t100)
  store { i8**, i64 }* %t101, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t102 = phi { i8**, i64 }* [ %t101, %then17 ], [ %t97, %loop.body12 ]
  store { i8**, i64 }* %t102, { i8**, i64 }** %l4
  %t103 = load double, double* %l2
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l2
  br label %loop.latch13
loop.latch13:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t107 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t110
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
  %t71 = phi double [ %t4, %entry ], [ %t68, %loop.latch2 ]
  %t72 = phi double [ %t5, %entry ], [ %t69, %loop.latch2 ]
  %t73 = phi i8* [ %t3, %entry ], [ %t70, %loop.latch2 ]
  store double %t71, double* %l1
  store double %t72, double* %l2
  store i8* %t73, i8** %l0
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
  %t18 = icmp eq i8 %t17, 60
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  %t22 = load i8, i8* %l3
  br i1 %t18, label %then6, label %merge7
then6:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l1
  %t26 = load double, double* %l2
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l2
  br label %loop.latch2
merge7:
  %t29 = load i8, i8* %l3
  %t30 = icmp eq i8 %t29, 62
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  %t34 = load i8, i8* %l3
  br i1 %t30, label %then8, label %merge9
then8:
  %t35 = load double, double* %l1
  %t36 = sitofp i64 0 to double
  %t37 = fcmp ogt double %t35, %t36
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l2
  %t41 = load i8, i8* %l3
  br i1 %t37, label %then10, label %merge11
then10:
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fsub double %t42, %t43
  store double %t44, double* %l1
  br label %merge11
merge11:
  %t45 = phi double [ %t44, %then10 ], [ %t39, %then8 ]
  store double %t45, double* %l1
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l2
  br label %loop.latch2
merge9:
  %t49 = load double, double* %l1
  %t50 = sitofp i64 0 to double
  %t51 = fcmp oeq double %t49, %t50
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = load i8, i8* %l3
  br i1 %t51, label %then12, label %merge13
then12:
  %t56 = load i8*, i8** %l0
  %t57 = load i8, i8* %l3
  %t58 = load i8, i8* %t56
  %t59 = add i8 %t58, %t57
  %t60 = alloca [2 x i8], align 1
  %t61 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8 %t59, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 1
  store i8 0, i8* %t62
  %t63 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8* %t63, i8** %l0
  br label %merge13
merge13:
  %t64 = phi i8* [ %t63, %then12 ], [ %t52, %loop.body1 ]
  store i8* %t64, i8** %l0
  %t65 = load double, double* %l2
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l2
  br label %loop.latch2
loop.latch2:
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t74 = load i8*, i8** %l0
  %t75 = call i8* @trim_text(i8* %t74)
  ret i8* %t75
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
  %t237 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t234, %NativeStructLayoutField %t236)
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
  %t252 = alloca [0 x %NativeStructField*]
  %t253 = getelementptr [0 x %NativeStructField*], [0 x %NativeStructField*]* %t252, i32 0, i32 0
  %t254 = alloca { %NativeStructField**, i64 }
  %t255 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t254, i32 0, i32 0
  store %NativeStructField** %t253, %NativeStructField*** %t255
  %t256 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t254, i32 0, i32 1
  store i64 0, i64* %t256
  %t257 = insertvalue %NativeStruct %t251, { %NativeStructField**, i64 }* %t254, 1
  %t258 = alloca [0 x %NativeFunction*]
  %t259 = getelementptr [0 x %NativeFunction*], [0 x %NativeFunction*]* %t258, i32 0, i32 0
  %t260 = alloca { %NativeFunction**, i64 }
  %t261 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t260, i32 0, i32 0
  store %NativeFunction** %t259, %NativeFunction*** %t261
  %t262 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t260, i32 0, i32 1
  store i64 0, i64* %t262
  %t263 = insertvalue %NativeStruct %t257, { %NativeFunction**, i64 }* %t260, 2
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
  %t277 = bitcast { %NativeStructLayoutField*, i64 }* %t276 to { %NativeStructLayoutField**, i64 }*
  %t278 = insertvalue %NativeStructLayout %t275, { %NativeStructLayoutField**, i64 }* %t277, 2
  %t279 = insertvalue %NativeStruct %t269, %NativeStructLayout* null, 4
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
  %t467 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t464, %NativeEnumVariantLayout %t466)
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
  %t538 = bitcast { %NativeStructLayoutField**, i64 }* %t535 to { %NativeStructLayoutField*, i64 }*
  %t539 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t538, %NativeStructLayoutField %t537)
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
  %t558 = alloca [0 x %NativeEnumVariant*]
  %t559 = getelementptr [0 x %NativeEnumVariant*], [0 x %NativeEnumVariant*]* %t558, i32 0, i32 0
  %t560 = alloca { %NativeEnumVariant**, i64 }
  %t561 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t560, i32 0, i32 0
  store %NativeEnumVariant** %t559, %NativeEnumVariant*** %t561
  %t562 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t560, i32 0, i32 1
  store i64 0, i64* %t562
  %t563 = insertvalue %NativeEnum %t557, { %NativeEnumVariant**, i64 }* %t560, 1
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
  %t580 = bitcast { %NativeEnumVariantLayout*, i64 }* %t579 to { %NativeEnumVariantLayout**, i64 }*
  %t581 = insertvalue %NativeEnumLayout %t578, { %NativeEnumVariantLayout**, i64 }* %t580, 5
  %t582 = insertvalue %NativeEnum %t563, %NativeEnumLayout* null, 2
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
  %t605 = bitcast { %NativeStruct*, i64 }* %t604 to { %NativeStruct**, i64 }*
  %t606 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t605, 0
  %t607 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t608 = bitcast { %NativeEnum*, i64 }* %t607 to { %NativeEnum**, i64 }*
  %t609 = insertvalue %LayoutManifest %t606, { %NativeEnum**, i64 }* %t608, 1
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t611 = insertvalue %LayoutManifest %t609, { i8**, i64 }* %t610, 2
  ret %LayoutManifest %t611
}

define i1 @is_trim_char(i8* %ch) {
entry:
  %t1 = load i8, i8* %ch
  %t2 = icmp eq i8 %t1, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 10
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8, i8* %ch
  %t8 = icmp eq i8 %t7, 13
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 9
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t11 = phi i1 [ true, %logical_or_entry_6 ], [ %t10, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t12 = phi i1 [ true, %logical_or_entry_3 ], [ %t11, %logical_or_right_end_3 ]
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
