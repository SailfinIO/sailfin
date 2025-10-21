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

@runtime = external global i8**

@.str.0 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.3 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.8 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.14 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.20 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.329 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.24 = private unnamed_addr constant [1 x i8] c"\00"
@.str.7 = private unnamed_addr constant [1 x i8] c"\00"
@.str.72 = private unnamed_addr constant [1 x i8] c"\00"
@.str.18 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.25 = private unnamed_addr constant [1 x i8] c"\00"
@.str.6 = private unnamed_addr constant [1 x i8] c"\00"
@.str.80 = private unnamed_addr constant [1 x i8] c"\00"
@.str.31 = private unnamed_addr constant [1 x i8] c"\00"
@.str.32 = private unnamed_addr constant [1 x i8] c"\00"
@.str.118 = private unnamed_addr constant [1 x i8] c"\00"
@.str.44 = private unnamed_addr constant [1 x i8] c"\00"
@.str.17 = private unnamed_addr constant [1 x i8] c"\00"
@.str.77 = private unnamed_addr constant [1 x i8] c"\00"

define %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %artifacts) {
entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t4 = extractvalue { %NativeArtifact*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t11 = extractvalue { %NativeArtifact*, i64 } %t10, 0
  %t12 = extractvalue { %NativeArtifact*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %NativeArtifact, %NativeArtifact* %t11, i64 %t9
  %t15 = load %NativeArtifact, %NativeArtifact* %t14
  store %NativeArtifact %t15, %NativeArtifact* %l1
  %t16 = load %NativeArtifact, %NativeArtifact* %l1
  %t17 = extractvalue %NativeArtifact %t16, 1
  %s18 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.18, i32 0, i32 0
  %t19 = icmp eq i8* %t17, %s18
  %t20 = load double, double* %l0
  %t21 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load %NativeArtifact, %NativeArtifact* %l1
  %t23 = alloca %NativeArtifact
  store %NativeArtifact %t22, %NativeArtifact* %t23
  ret %NativeArtifact* %t23
merge7:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t29
}

define %NativeArtifact* @select_layout_manifest_artifact({ %NativeArtifact*, i64 }* %artifacts) {
entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t4 = extractvalue { %NativeArtifact*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t11 = extractvalue { %NativeArtifact*, i64 } %t10, 0
  %t12 = extractvalue { %NativeArtifact*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %NativeArtifact, %NativeArtifact* %t11, i64 %t9
  %t15 = load %NativeArtifact, %NativeArtifact* %t14
  store %NativeArtifact %t15, %NativeArtifact* %l1
  %t16 = load %NativeArtifact, %NativeArtifact* %l1
  %t17 = extractvalue %NativeArtifact %t16, 1
  %s18 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.18, i32 0, i32 0
  %t19 = icmp eq i8* %t17, %s18
  %t20 = load double, double* %l0
  %t21 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  %t22 = load %NativeArtifact, %NativeArtifact* %l1
  %t23 = alloca %NativeArtifact
  store %NativeArtifact %t22, %NativeArtifact* %t23
  ret %NativeArtifact* %t23
merge7:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t29
}

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
  %l8 = alloca %NativeFunction*
  %l9 = alloca %NativeSourceSpan*
  %l10 = alloca %NativeSourceSpan*
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca %NativeImport*
  %l15 = alloca %NativeImport*
  %l16 = alloca %NativeSourceSpan*
  %l17 = alloca %NativeSourceSpan*
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
  %l29 = alloca %NativeSourceSpan*
  %l30 = alloca %NativeParameter*
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
  %t36 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t36, %NativeFunction** %l8
  %t37 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t37, %NativeSourceSpan** %l9
  %t38 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t38, %NativeSourceSpan** %l10
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l11
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t43 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t44 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t45 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t46 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t47 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t48 = load %NativeFunction*, %NativeFunction** %l8
  %t49 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t50 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t51 = load double, double* %l11
  br label %loop.header0
loop.header0:
  %t1370 = phi double [ %t51, %entry ], [ %t1359, %loop.latch2 ]
  %t1371 = phi { i8**, i64 }* [ %t41, %entry ], [ %t1360, %loop.latch2 ]
  %t1372 = phi { %NativeImport*, i64 }* [ %t43, %entry ], [ %t1361, %loop.latch2 ]
  %t1373 = phi %NativeSourceSpan* [ %t49, %entry ], [ %t1362, %loop.latch2 ]
  %t1374 = phi %NativeSourceSpan* [ %t50, %entry ], [ %t1363, %loop.latch2 ]
  %t1375 = phi { %NativeStruct*, i64 }* [ %t44, %entry ], [ %t1364, %loop.latch2 ]
  %t1376 = phi { %NativeInterface*, i64 }* [ %t45, %entry ], [ %t1365, %loop.latch2 ]
  %t1377 = phi { %NativeEnum*, i64 }* [ %t46, %entry ], [ %t1366, %loop.latch2 ]
  %t1378 = phi %NativeFunction* [ %t48, %entry ], [ %t1367, %loop.latch2 ]
  %t1379 = phi { %NativeFunction*, i64 }* [ %t42, %entry ], [ %t1368, %loop.latch2 ]
  %t1380 = phi { %NativeBinding*, i64 }* [ %t47, %entry ], [ %t1369, %loop.latch2 ]
  store double %t1370, double* %l11
  store { i8**, i64 }* %t1371, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1372, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1373, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1374, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1375, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1376, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1377, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1378, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1379, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1380, { %NativeBinding*, i64 }** %l7
  br label %loop.body1
loop.body1:
  %t52 = load double, double* %l11
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load { i8**, i64 }, { i8**, i64 }* %t53
  %t55 = extractvalue { i8**, i64 } %t54, 1
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t61 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t62 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t63 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t64 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t65 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t66 = load %NativeFunction*, %NativeFunction** %l8
  %t67 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t68 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t69 = load double, double* %l11
  br i1 %t57, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load double, double* %l11
  %t72 = fptosi double %t71 to i64
  %t73 = load { i8**, i64 }, { i8**, i64 }* %t70
  %t74 = extractvalue { i8**, i64 } %t73, 0
  %t75 = extractvalue { i8**, i64 } %t73, 1
  %t76 = icmp uge i64 %t72, %t75
  ; bounds check: %t76 (if true, out of bounds)
  %t77 = getelementptr i8*, i8** %t74, i64 %t72
  %t78 = load i8*, i8** %t77
  store i8* %t78, i8** %l12
  %t79 = load i8*, i8** %l12
  %t80 = call i8* @trim_text(i8* %t79)
  store i8* %t80, i8** %l13
  %t81 = load i8*, i8** %l13
  %t82 = call i64 @sailfin_runtime_string_length(i8* %t81)
  %t83 = icmp eq i64 %t82, 0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t87 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t88 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t89 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t90 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t91 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t92 = load %NativeFunction*, %NativeFunction** %l8
  %t93 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t94 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t95 = load double, double* %l11
  %t96 = load i8*, i8** %l12
  %t97 = load i8*, i8** %l13
  br i1 %t83, label %then6, label %merge7
then6:
  %t98 = load double, double* %l11
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l11
  br label %loop.latch2
merge7:
  %t101 = load i8*, i8** %l13
  %t102 = alloca [2 x i8], align 1
  %t103 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 0
  store i8 59, i8* %t103
  %t104 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 1
  store i8 0, i8* %t104
  %t105 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 0
  %t106 = call i1 @starts_with(i8* %t101, i8* %t105)
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t109 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t110 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t111 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t112 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t114 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t115 = load %NativeFunction*, %NativeFunction** %l8
  %t116 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t117 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t118 = load double, double* %l11
  %t119 = load i8*, i8** %l12
  %t120 = load i8*, i8** %l13
  br i1 %t106, label %then8, label %merge9
then8:
  %t121 = load double, double* %l11
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l11
  br label %loop.latch2
merge9:
  %t124 = load i8*, i8** %l13
  %s125 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.125, i32 0, i32 0
  %t126 = call i1 @starts_with(i8* %t124, i8* %s125)
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t130 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t131 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t132 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t133 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t134 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t135 = load %NativeFunction*, %NativeFunction** %l8
  %t136 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t137 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t138 = load double, double* %l11
  %t139 = load i8*, i8** %l12
  %t140 = load i8*, i8** %l13
  br i1 %t126, label %then10, label %merge11
then10:
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
  %t155 = load %NativeFunction*, %NativeFunction** %l8
  %t156 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t157 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t158 = load double, double* %l11
  %t159 = load i8*, i8** %l12
  %t160 = load i8*, i8** %l13
  br i1 %t146, label %then12, label %merge13
then12:
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.161, i32 0, i32 0
  %t162 = load i8*, i8** %l13
  %s163 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.163, i32 0, i32 0
  %t164 = call i8* @strip_prefix(i8* %t162, i8* %s163)
  %t165 = call %NativeImport* @parse_import_entry(i8* %s161, i8* %t164)
  store %NativeImport* %t165, %NativeImport** %l14
  %t166 = load %NativeImport*, %NativeImport** %l14
  %t167 = bitcast i8* null to %NativeImport*
  %t168 = icmp eq %NativeImport* %t166, %t167
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t172 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t173 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t174 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t175 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t176 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t177 = load %NativeFunction*, %NativeFunction** %l8
  %t178 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t179 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t180 = load double, double* %l11
  %t181 = load i8*, i8** %l12
  %t182 = load i8*, i8** %l13
  %t183 = load %NativeImport*, %NativeImport** %l14
  br i1 %t168, label %then14, label %else15
then14:
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s185 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.185, i32 0, i32 0
  %t186 = load i8*, i8** %l13
  %t187 = add i8* %s185, %t186
  %t188 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t184, i8* %t187)
  store { i8**, i64 }* %t188, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t189 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t190 = load %NativeImport*, %NativeImport** %l14
  %t191 = load %NativeImport, %NativeImport* %t190
  %t192 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t189, %NativeImport %t191)
  store { %NativeImport*, i64 }* %t192, { %NativeImport*, i64 }** %l3
  br label %merge16
merge16:
  %t193 = phi { i8**, i64 }* [ %t188, %then14 ], [ %t170, %else15 ]
  %t194 = phi { %NativeImport*, i64 }* [ %t172, %then14 ], [ %t192, %else15 ]
  store { i8**, i64 }* %t193, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t194, { %NativeImport*, i64 }** %l3
  %t195 = load double, double* %l11
  %t196 = sitofp i64 1 to double
  %t197 = fadd double %t195, %t196
  store double %t197, double* %l11
  br label %loop.latch2
merge13:
  %t198 = load i8*, i8** %l13
  %s199 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.199, i32 0, i32 0
  %t200 = call i1 @starts_with(i8* %t198, i8* %s199)
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t203 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t204 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t205 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t206 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t207 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t208 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t209 = load %NativeFunction*, %NativeFunction** %l8
  %t210 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t211 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t212 = load double, double* %l11
  %t213 = load i8*, i8** %l12
  %t214 = load i8*, i8** %l13
  br i1 %t200, label %then17, label %merge18
then17:
  %s215 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.215, i32 0, i32 0
  %t216 = load i8*, i8** %l13
  %s217 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.217, i32 0, i32 0
  %t218 = call i8* @strip_prefix(i8* %t216, i8* %s217)
  %t219 = call %NativeImport* @parse_import_entry(i8* %s215, i8* %t218)
  store %NativeImport* %t219, %NativeImport** %l15
  %t220 = load %NativeImport*, %NativeImport** %l15
  %t221 = bitcast i8* null to %NativeImport*
  %t222 = icmp eq %NativeImport* %t220, %t221
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t226 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t227 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t228 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t229 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t230 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t231 = load %NativeFunction*, %NativeFunction** %l8
  %t232 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t233 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t234 = load double, double* %l11
  %t235 = load i8*, i8** %l12
  %t236 = load i8*, i8** %l13
  %t237 = load %NativeImport*, %NativeImport** %l15
  br i1 %t222, label %then19, label %else20
then19:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s239 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.239, i32 0, i32 0
  %t240 = load i8*, i8** %l13
  %t241 = add i8* %s239, %t240
  %t242 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %t241)
  store { i8**, i64 }* %t242, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t243 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t244 = load %NativeImport*, %NativeImport** %l15
  %t245 = load %NativeImport, %NativeImport* %t244
  %t246 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t243, %NativeImport %t245)
  store { %NativeImport*, i64 }* %t246, { %NativeImport*, i64 }** %l3
  br label %merge21
merge21:
  %t247 = phi { i8**, i64 }* [ %t242, %then19 ], [ %t224, %else20 ]
  %t248 = phi { %NativeImport*, i64 }* [ %t226, %then19 ], [ %t246, %else20 ]
  store { i8**, i64 }* %t247, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t248, { %NativeImport*, i64 }** %l3
  %t249 = load double, double* %l11
  %t250 = sitofp i64 1 to double
  %t251 = fadd double %t249, %t250
  store double %t251, double* %l11
  br label %loop.latch2
merge18:
  %t252 = load i8*, i8** %l13
  %s253 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.253, i32 0, i32 0
  %t254 = call i1 @starts_with(i8* %t252, i8* %s253)
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t257 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t258 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t259 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t260 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t261 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t262 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t263 = load %NativeFunction*, %NativeFunction** %l8
  %t264 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t265 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t266 = load double, double* %l11
  %t267 = load i8*, i8** %l12
  %t268 = load i8*, i8** %l13
  br i1 %t254, label %then22, label %merge23
then22:
  %t269 = load i8*, i8** %l13
  %s270 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.270, i32 0, i32 0
  %t271 = call i8* @strip_prefix(i8* %t269, i8* %s270)
  %t272 = call %NativeSourceSpan* @parse_source_span(i8* %t271)
  store %NativeSourceSpan* %t272, %NativeSourceSpan** %l16
  %t273 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  %t274 = bitcast i8* null to %NativeSourceSpan*
  %t275 = icmp eq %NativeSourceSpan* %t273, %t274
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t278 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t279 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t280 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t281 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t282 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t283 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t284 = load %NativeFunction*, %NativeFunction** %l8
  %t285 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t286 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t287 = load double, double* %l11
  %t288 = load i8*, i8** %l12
  %t289 = load i8*, i8** %l13
  %t290 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  br i1 %t275, label %then24, label %else25
then24:
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s292 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.292, i32 0, i32 0
  %t293 = load i8*, i8** %l13
  %t294 = add i8* %s292, %t293
  %t295 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t291, i8* %t294)
  store { i8**, i64 }* %t295, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t296 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  store %NativeSourceSpan* %t296, %NativeSourceSpan** %l9
  br label %merge26
merge26:
  %t297 = phi { i8**, i64 }* [ %t295, %then24 ], [ %t277, %else25 ]
  %t298 = phi %NativeSourceSpan* [ %t285, %then24 ], [ %t296, %else25 ]
  store { i8**, i64 }* %t297, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t298, %NativeSourceSpan** %l9
  %t299 = load double, double* %l11
  %t300 = sitofp i64 1 to double
  %t301 = fadd double %t299, %t300
  store double %t301, double* %l11
  br label %loop.latch2
merge23:
  %t302 = load i8*, i8** %l13
  %s303 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.303, i32 0, i32 0
  %t304 = call i1 @starts_with(i8* %t302, i8* %s303)
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t307 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t308 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t309 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t310 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t311 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t312 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t313 = load %NativeFunction*, %NativeFunction** %l8
  %t314 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t315 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t316 = load double, double* %l11
  %t317 = load i8*, i8** %l12
  %t318 = load i8*, i8** %l13
  br i1 %t304, label %then27, label %merge28
then27:
  %t319 = load i8*, i8** %l13
  %s320 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.320, i32 0, i32 0
  %t321 = call i8* @strip_prefix(i8* %t319, i8* %s320)
  %t322 = call %NativeSourceSpan* @parse_source_span(i8* %t321)
  store %NativeSourceSpan* %t322, %NativeSourceSpan** %l17
  %t323 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  %t324 = bitcast i8* null to %NativeSourceSpan*
  %t325 = icmp eq %NativeSourceSpan* %t323, %t324
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t329 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t330 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t331 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t332 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t333 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t334 = load %NativeFunction*, %NativeFunction** %l8
  %t335 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t336 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t337 = load double, double* %l11
  %t338 = load i8*, i8** %l12
  %t339 = load i8*, i8** %l13
  %t340 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  br i1 %t325, label %then29, label %else30
then29:
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s342 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.342, i32 0, i32 0
  %t343 = load i8*, i8** %l13
  %t344 = add i8* %s342, %t343
  %t345 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t341, i8* %t344)
  store { i8**, i64 }* %t345, { i8**, i64 }** %l1
  br label %merge31
else30:
  %t346 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  store %NativeSourceSpan* %t346, %NativeSourceSpan** %l10
  br label %merge31
merge31:
  %t347 = phi { i8**, i64 }* [ %t345, %then29 ], [ %t327, %else30 ]
  %t348 = phi %NativeSourceSpan* [ %t336, %then29 ], [ %t346, %else30 ]
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t348, %NativeSourceSpan** %l10
  %t349 = load double, double* %l11
  %t350 = sitofp i64 1 to double
  %t351 = fadd double %t349, %t350
  store double %t351, double* %l11
  br label %loop.latch2
merge28:
  %t352 = load i8*, i8** %l13
  %s353 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.353, i32 0, i32 0
  %t354 = call i1 @starts_with(i8* %t352, i8* %s353)
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t357 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t358 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t359 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t360 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t361 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t362 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t363 = load %NativeFunction*, %NativeFunction** %l8
  %t364 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t365 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t366 = load double, double* %l11
  %t367 = load i8*, i8** %l12
  %t368 = load i8*, i8** %l13
  br i1 %t354, label %then32, label %merge33
then32:
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t370 = load double, double* %l11
  %t371 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t369, double %t370)
  store %StructParseResult %t371, %StructParseResult* %l18
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t373 = load %StructParseResult, %StructParseResult* %l18
  %t374 = extractvalue %StructParseResult %t373, 2
  %t375 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t372, { i8**, i64 }* %t374)
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  %t376 = load %StructParseResult, %StructParseResult* %l18
  %t377 = extractvalue %StructParseResult %t376, 0
  %t378 = bitcast i8* null to %NativeStruct*
  %t379 = icmp ne %NativeStruct* %t377, %t378
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t383 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t384 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t385 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t386 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t387 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t388 = load %NativeFunction*, %NativeFunction** %l8
  %t389 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t390 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t391 = load double, double* %l11
  %t392 = load i8*, i8** %l12
  %t393 = load i8*, i8** %l13
  %t394 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t379, label %then34, label %merge35
then34:
  %t395 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t396 = load %StructParseResult, %StructParseResult* %l18
  %t397 = extractvalue %StructParseResult %t396, 0
  %t398 = load %NativeStruct, %NativeStruct* %t397
  %t399 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t395, %NativeStruct %t398)
  store { %NativeStruct*, i64 }* %t399, { %NativeStruct*, i64 }** %l4
  br label %merge35
merge35:
  %t400 = phi { %NativeStruct*, i64 }* [ %t399, %then34 ], [ %t384, %then32 ]
  store { %NativeStruct*, i64 }* %t400, { %NativeStruct*, i64 }** %l4
  %t401 = load %StructParseResult, %StructParseResult* %l18
  %t402 = extractvalue %StructParseResult %t401, 1
  store double %t402, double* %l11
  br label %loop.latch2
merge33:
  %t403 = load i8*, i8** %l13
  %s404 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.404, i32 0, i32 0
  %t405 = call i1 @starts_with(i8* %t403, i8* %s404)
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t408 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t409 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t410 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t411 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t412 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t413 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t414 = load %NativeFunction*, %NativeFunction** %l8
  %t415 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t416 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t417 = load double, double* %l11
  %t418 = load i8*, i8** %l12
  %t419 = load i8*, i8** %l13
  br i1 %t405, label %then36, label %merge37
then36:
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load double, double* %l11
  %t422 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t420, double %t421)
  store %InterfaceParseResult %t422, %InterfaceParseResult* %l19
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t424 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t425 = extractvalue %InterfaceParseResult %t424, 2
  %t426 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t423, { i8**, i64 }* %t425)
  store { i8**, i64 }* %t426, { i8**, i64 }** %l1
  %t427 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t428 = extractvalue %InterfaceParseResult %t427, 0
  %t429 = bitcast i8* null to %NativeInterface*
  %t430 = icmp ne %NativeInterface* %t428, %t429
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t433 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t434 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t435 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t436 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t437 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t438 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t439 = load %NativeFunction*, %NativeFunction** %l8
  %t440 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t441 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t442 = load double, double* %l11
  %t443 = load i8*, i8** %l12
  %t444 = load i8*, i8** %l13
  %t445 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t430, label %then38, label %merge39
then38:
  %t446 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t447 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t448 = extractvalue %InterfaceParseResult %t447, 0
  %t449 = load %NativeInterface, %NativeInterface* %t448
  %t450 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t446, %NativeInterface %t449)
  store { %NativeInterface*, i64 }* %t450, { %NativeInterface*, i64 }** %l5
  br label %merge39
merge39:
  %t451 = phi { %NativeInterface*, i64 }* [ %t450, %then38 ], [ %t436, %then36 ]
  store { %NativeInterface*, i64 }* %t451, { %NativeInterface*, i64 }** %l5
  %t452 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t453 = extractvalue %InterfaceParseResult %t452, 1
  store double %t453, double* %l11
  br label %loop.latch2
merge37:
  %t454 = load i8*, i8** %l13
  %s455 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.455, i32 0, i32 0
  %t456 = call i1 @starts_with(i8* %t454, i8* %s455)
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t459 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t460 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t461 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t462 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t463 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t464 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t465 = load %NativeFunction*, %NativeFunction** %l8
  %t466 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t467 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t468 = load double, double* %l11
  %t469 = load i8*, i8** %l12
  %t470 = load i8*, i8** %l13
  br i1 %t456, label %then40, label %merge41
then40:
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t472 = load double, double* %l11
  %t473 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t471, double %t472)
  store %EnumParseResult %t473, %EnumParseResult* %l20
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load %EnumParseResult, %EnumParseResult* %l20
  %t476 = extractvalue %EnumParseResult %t475, 2
  %t477 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t474, { i8**, i64 }* %t476)
  store { i8**, i64 }* %t477, { i8**, i64 }** %l1
  %t478 = load %EnumParseResult, %EnumParseResult* %l20
  %t479 = extractvalue %EnumParseResult %t478, 0
  %t480 = bitcast i8* null to %NativeEnum*
  %t481 = icmp ne %NativeEnum* %t479, %t480
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t484 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t485 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t486 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t487 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t488 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t489 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t490 = load %NativeFunction*, %NativeFunction** %l8
  %t491 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t492 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t493 = load double, double* %l11
  %t494 = load i8*, i8** %l12
  %t495 = load i8*, i8** %l13
  %t496 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t481, label %then42, label %merge43
then42:
  %t497 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t498 = load %EnumParseResult, %EnumParseResult* %l20
  %t499 = extractvalue %EnumParseResult %t498, 0
  %t500 = load %NativeEnum, %NativeEnum* %t499
  %t501 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t497, %NativeEnum %t500)
  store { %NativeEnum*, i64 }* %t501, { %NativeEnum*, i64 }** %l6
  br label %merge43
merge43:
  %t502 = phi { %NativeEnum*, i64 }* [ %t501, %then42 ], [ %t488, %then40 ]
  store { %NativeEnum*, i64 }* %t502, { %NativeEnum*, i64 }** %l6
  %t503 = load %EnumParseResult, %EnumParseResult* %l20
  %t504 = extractvalue %EnumParseResult %t503, 1
  store double %t504, double* %l11
  br label %loop.latch2
merge41:
  %t505 = load i8*, i8** %l13
  %s506 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.506, i32 0, i32 0
  %t507 = call i1 @starts_with(i8* %t505, i8* %s506)
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t511 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t512 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t513 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t514 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t515 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t516 = load %NativeFunction*, %NativeFunction** %l8
  %t517 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t518 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t519 = load double, double* %l11
  %t520 = load i8*, i8** %l12
  %t521 = load i8*, i8** %l13
  br i1 %t507, label %then44, label %merge45
then44:
  %t522 = load %NativeFunction*, %NativeFunction** %l8
  %t523 = bitcast i8* null to %NativeFunction*
  %t524 = icmp ne %NativeFunction* %t522, %t523
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t527 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t528 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t529 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t530 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t531 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t532 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t533 = load %NativeFunction*, %NativeFunction** %l8
  %t534 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t535 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t536 = load double, double* %l11
  %t537 = load i8*, i8** %l12
  %t538 = load i8*, i8** %l13
  br i1 %t524, label %then46, label %merge47
then46:
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s540 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.540, i32 0, i32 0
  %t541 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t539, i8* %s540)
  store { i8**, i64 }* %t541, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t542 = phi { i8**, i64 }* [ %t541, %then46 ], [ %t526, %then44 ]
  store { i8**, i64 }* %t542, { i8**, i64 }** %l1
  %t543 = load i8*, i8** %l13
  %s544 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.544, i32 0, i32 0
  %t545 = call i8* @strip_prefix(i8* %t543, i8* %s544)
  %t546 = call i8* @parse_function_name(i8* %t545)
  %t547 = insertvalue %NativeFunction undef, i8* %t546, 0
  %t548 = alloca [0 x %NativeParameter*]
  %t549 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t548, i32 0, i32 0
  %t550 = alloca { %NativeParameter**, i64 }
  %t551 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t550, i32 0, i32 0
  store %NativeParameter** %t549, %NativeParameter*** %t551
  %t552 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t550, i32 0, i32 1
  store i64 0, i64* %t552
  %t553 = insertvalue %NativeFunction %t547, { %NativeParameter**, i64 }* %t550, 1
  %s554 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.554, i32 0, i32 0
  %t555 = insertvalue %NativeFunction %t553, i8* %s554, 2
  %t556 = alloca [0 x i8*]
  %t557 = getelementptr [0 x i8*], [0 x i8*]* %t556, i32 0, i32 0
  %t558 = alloca { i8**, i64 }
  %t559 = getelementptr { i8**, i64 }, { i8**, i64 }* %t558, i32 0, i32 0
  store i8** %t557, i8*** %t559
  %t560 = getelementptr { i8**, i64 }, { i8**, i64 }* %t558, i32 0, i32 1
  store i64 0, i64* %t560
  %t561 = insertvalue %NativeFunction %t555, { i8**, i64 }* %t558, 3
  %t562 = alloca [0 x %NativeInstruction*]
  %t563 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* %t562, i32 0, i32 0
  %t564 = alloca { %NativeInstruction**, i64 }
  %t565 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t564, i32 0, i32 0
  store %NativeInstruction** %t563, %NativeInstruction*** %t565
  %t566 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t564, i32 0, i32 1
  store i64 0, i64* %t566
  %t567 = insertvalue %NativeFunction %t561, { %NativeInstruction**, i64 }* %t564, 4
  %t568 = alloca %NativeFunction
  store %NativeFunction %t567, %NativeFunction* %t568
  store %NativeFunction* %t568, %NativeFunction** %l8
  %t569 = load double, double* %l11
  %t570 = sitofp i64 1 to double
  %t571 = fadd double %t569, %t570
  store double %t571, double* %l11
  br label %loop.latch2
merge45:
  %t572 = load i8*, i8** %l13
  %s573 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.573, i32 0, i32 0
  %t574 = call i1 @starts_with(i8* %t572, i8* %s573)
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t577 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t578 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t579 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t580 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t581 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t582 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t583 = load %NativeFunction*, %NativeFunction** %l8
  %t584 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t585 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t586 = load double, double* %l11
  %t587 = load i8*, i8** %l12
  %t588 = load i8*, i8** %l13
  br i1 %t574, label %then48, label %merge49
then48:
  %t589 = load %NativeFunction*, %NativeFunction** %l8
  %t590 = bitcast i8* null to %NativeFunction*
  %t591 = icmp eq %NativeFunction* %t589, %t590
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t593 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t594 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t595 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t596 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t597 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t598 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t599 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t600 = load %NativeFunction*, %NativeFunction** %l8
  %t601 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t602 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t603 = load double, double* %l11
  %t604 = load i8*, i8** %l12
  %t605 = load i8*, i8** %l13
  br i1 %t591, label %then50, label %else51
then50:
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s607 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.607, i32 0, i32 0
  %t608 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t606, i8* %s607)
  store { i8**, i64 }* %t608, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t609 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t610 = load %NativeFunction*, %NativeFunction** %l8
  %t611 = load %NativeFunction, %NativeFunction* %t610
  %t612 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t609, %NativeFunction %t611)
  store { %NativeFunction*, i64 }* %t612, { %NativeFunction*, i64 }** %l2
  %t613 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t613, %NativeFunction** %l8
  br label %merge52
merge52:
  %t614 = phi { i8**, i64 }* [ %t608, %then50 ], [ %t593, %else51 ]
  %t615 = phi { %NativeFunction*, i64 }* [ %t594, %then50 ], [ %t612, %else51 ]
  %t616 = phi %NativeFunction* [ %t600, %then50 ], [ %t613, %else51 ]
  store { i8**, i64 }* %t614, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t615, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t616, %NativeFunction** %l8
  %t617 = load double, double* %l11
  %t618 = sitofp i64 1 to double
  %t619 = fadd double %t617, %t618
  store double %t619, double* %l11
  br label %loop.latch2
merge49:
  %t620 = load i8*, i8** %l13
  %s621 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.621, i32 0, i32 0
  %t622 = call i1 @starts_with(i8* %t620, i8* %s621)
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t624 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t625 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t626 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t627 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t628 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t629 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t630 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t631 = load %NativeFunction*, %NativeFunction** %l8
  %t632 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t633 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t634 = load double, double* %l11
  %t635 = load i8*, i8** %l12
  %t636 = load i8*, i8** %l13
  br i1 %t622, label %then53, label %merge54
then53:
  %t637 = load %NativeFunction*, %NativeFunction** %l8
  %t638 = bitcast i8* null to %NativeFunction*
  %t639 = icmp ne %NativeFunction* %t637, %t638
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t642 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t643 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t644 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t645 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t646 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t647 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t648 = load %NativeFunction*, %NativeFunction** %l8
  %t649 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t650 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t651 = load double, double* %l11
  %t652 = load i8*, i8** %l12
  %t653 = load i8*, i8** %l13
  br i1 %t639, label %then55, label %else56
then55:
  %t654 = load %NativeFunction*, %NativeFunction** %l8
  %t655 = load i8*, i8** %l13
  %s656 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.656, i32 0, i32 0
  %t657 = call i8* @strip_prefix(i8* %t655, i8* %s656)
  %t658 = load %NativeFunction, %NativeFunction* %t654
  %t659 = call %NativeFunction @apply_meta(%NativeFunction %t658, i8* %t657)
  %t660 = alloca %NativeFunction
  store %NativeFunction %t659, %NativeFunction* %t660
  store %NativeFunction* %t660, %NativeFunction** %l8
  br label %merge57
else56:
  %t661 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s662 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.662, i32 0, i32 0
  %t663 = load i8*, i8** %l13
  %t664 = add i8* %s662, %t663
  %t665 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t661, i8* %t664)
  store { i8**, i64 }* %t665, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t666 = phi %NativeFunction* [ %t660, %then55 ], [ %t648, %else56 ]
  %t667 = phi { i8**, i64 }* [ %t641, %then55 ], [ %t665, %else56 ]
  store %NativeFunction* %t666, %NativeFunction** %l8
  store { i8**, i64 }* %t667, { i8**, i64 }** %l1
  %t668 = load double, double* %l11
  %t669 = sitofp i64 1 to double
  %t670 = fadd double %t668, %t669
  store double %t670, double* %l11
  br label %loop.latch2
merge54:
  %t671 = load i8*, i8** %l13
  %s672 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.672, i32 0, i32 0
  %t673 = call i1 @starts_with(i8* %t671, i8* %s672)
  %t674 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t675 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t676 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t677 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t678 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t679 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t680 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t681 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t682 = load %NativeFunction*, %NativeFunction** %l8
  %t683 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t684 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t685 = load double, double* %l11
  %t686 = load i8*, i8** %l12
  %t687 = load i8*, i8** %l13
  br i1 %t673, label %then58, label %merge59
then58:
  %t688 = load %NativeFunction*, %NativeFunction** %l8
  %t689 = bitcast i8* null to %NativeFunction*
  %t690 = icmp ne %NativeFunction* %t688, %t689
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t692 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t693 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t694 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t695 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t696 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t697 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t698 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t699 = load %NativeFunction*, %NativeFunction** %l8
  %t700 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t701 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t702 = load double, double* %l11
  %t703 = load i8*, i8** %l12
  %t704 = load i8*, i8** %l13
  br i1 %t690, label %then60, label %else61
then60:
  %t705 = load i8*, i8** %l13
  %s706 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.706, i32 0, i32 0
  %t707 = call i8* @strip_prefix(i8* %t705, i8* %s706)
  store i8* %t707, i8** %l21
  %t708 = load double, double* %l11
  %t709 = sitofp i64 1 to double
  %t710 = fadd double %t708, %t709
  store double %t710, double* %l22
  %t711 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t713 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t714 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t715 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t716 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t717 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t718 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t719 = load %NativeFunction*, %NativeFunction** %l8
  %t720 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t721 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t722 = load double, double* %l11
  %t723 = load i8*, i8** %l12
  %t724 = load i8*, i8** %l13
  %t725 = load i8*, i8** %l21
  %t726 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t840 = phi double [ %t726, %then60 ], [ %t838, %loop.latch65 ]
  %t841 = phi i8* [ %t725, %then60 ], [ %t839, %loop.latch65 ]
  store double %t840, double* %l22
  store i8* %t841, i8** %l21
  br label %loop.body64
loop.body64:
  %t727 = load double, double* %l22
  %t728 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t729 = load { i8**, i64 }, { i8**, i64 }* %t728
  %t730 = extractvalue { i8**, i64 } %t729, 1
  %t731 = sitofp i64 %t730 to double
  %t732 = fcmp oge double %t727, %t731
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t734 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t735 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t736 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t737 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t738 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t739 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t740 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t741 = load %NativeFunction*, %NativeFunction** %l8
  %t742 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t743 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t744 = load double, double* %l11
  %t745 = load i8*, i8** %l12
  %t746 = load i8*, i8** %l13
  %t747 = load i8*, i8** %l21
  %t748 = load double, double* %l22
  br i1 %t732, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t749 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t750 = load double, double* %l22
  %t751 = fptosi double %t750 to i64
  %t752 = load { i8**, i64 }, { i8**, i64 }* %t749
  %t753 = extractvalue { i8**, i64 } %t752, 0
  %t754 = extractvalue { i8**, i64 } %t752, 1
  %t755 = icmp uge i64 %t751, %t754
  ; bounds check: %t755 (if true, out of bounds)
  %t756 = getelementptr i8*, i8** %t753, i64 %t751
  %t757 = load i8*, i8** %t756
  store i8* %t757, i8** %l23
  %t758 = load i8*, i8** %l23
  %t759 = call i64 @sailfin_runtime_string_length(i8* %t758)
  %t760 = icmp eq i64 %t759, 0
  %t761 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t762 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t763 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t764 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t765 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t766 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t767 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t768 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t769 = load %NativeFunction*, %NativeFunction** %l8
  %t770 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t771 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t772 = load double, double* %l11
  %t773 = load i8*, i8** %l12
  %t774 = load i8*, i8** %l13
  %t775 = load i8*, i8** %l21
  %t776 = load double, double* %l22
  %t777 = load i8*, i8** %l23
  br i1 %t760, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t778 = load i8*, i8** %l23
  %t779 = call i8* @trim_text(i8* %t778)
  store i8* %t779, i8** %l24
  %t780 = load i8*, i8** %l24
  %t781 = call i64 @sailfin_runtime_string_length(i8* %t780)
  %t782 = icmp eq i64 %t781, 0
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t784 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t785 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t786 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t787 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t788 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t789 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t790 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t791 = load %NativeFunction*, %NativeFunction** %l8
  %t792 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t793 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t794 = load double, double* %l11
  %t795 = load i8*, i8** %l12
  %t796 = load i8*, i8** %l13
  %t797 = load i8*, i8** %l21
  %t798 = load double, double* %l22
  %t799 = load i8*, i8** %l23
  %t800 = load i8*, i8** %l24
  br i1 %t782, label %then71, label %merge72
then71:
  %t801 = load double, double* %l22
  %t802 = sitofp i64 1 to double
  %t803 = fadd double %t801, %t802
  store double %t803, double* %l22
  br label %loop.latch65
merge72:
  %t804 = load i8*, i8** %l24
  %t805 = call i1 @line_looks_like_parameter_entry(i8* %t804)
  %t806 = xor i1 %t805, 1
  %t807 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t808 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t809 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t810 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t811 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t812 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t813 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t814 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t815 = load %NativeFunction*, %NativeFunction** %l8
  %t816 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t817 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t818 = load double, double* %l11
  %t819 = load i8*, i8** %l12
  %t820 = load i8*, i8** %l13
  %t821 = load i8*, i8** %l21
  %t822 = load double, double* %l22
  %t823 = load i8*, i8** %l23
  %t824 = load i8*, i8** %l24
  br i1 %t806, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t825 = load i8*, i8** %l21
  %t826 = load i8, i8* %t825
  %t827 = add i8 %t826, 32
  %t828 = load i8*, i8** %l24
  %t829 = load i8, i8* %t828
  %t830 = add i8 %t827, %t829
  %t831 = alloca [2 x i8], align 1
  %t832 = getelementptr [2 x i8], [2 x i8]* %t831, i32 0, i32 0
  store i8 %t830, i8* %t832
  %t833 = getelementptr [2 x i8], [2 x i8]* %t831, i32 0, i32 1
  store i8 0, i8* %t833
  %t834 = getelementptr [2 x i8], [2 x i8]* %t831, i32 0, i32 0
  store i8* %t834, i8** %l21
  %t835 = load double, double* %l22
  %t836 = sitofp i64 1 to double
  %t837 = fadd double %t835, %t836
  store double %t837, double* %l22
  br label %loop.latch65
loop.latch65:
  %t838 = load double, double* %l22
  %t839 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t842 = load i8*, i8** %l21
  %t843 = call { i8**, i64 }* @split_parameter_entries(i8* %t842)
  store { i8**, i64 }* %t843, { i8**, i64 }** %l25
  %t844 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t845 = load { i8**, i64 }, { i8**, i64 }* %t844
  %t846 = extractvalue { i8**, i64 } %t845, 1
  %t847 = icmp eq i64 %t846, 0
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t849 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t850 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t851 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t852 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t853 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t854 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t855 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t856 = load %NativeFunction*, %NativeFunction** %l8
  %t857 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t858 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t859 = load double, double* %l11
  %t860 = load i8*, i8** %l12
  %t861 = load i8*, i8** %l13
  %t862 = load i8*, i8** %l21
  %t863 = load double, double* %l22
  %t864 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t847, label %then75, label %else76
then75:
  %t865 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s866 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.866, i32 0, i32 0
  %t867 = load i8*, i8** %l13
  %t868 = add i8* %s866, %t867
  %t869 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t865, i8* %t868)
  store { i8**, i64 }* %t869, { i8**, i64 }** %l1
  %t870 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t870, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t871 = sitofp i64 0 to double
  store double %t871, double* %l26
  store i1 0, i1* %l27
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t873 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t874 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t875 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t876 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t877 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t878 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t879 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t880 = load %NativeFunction*, %NativeFunction** %l8
  %t881 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t882 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t883 = load double, double* %l11
  %t884 = load i8*, i8** %l12
  %t885 = load i8*, i8** %l13
  %t886 = load i8*, i8** %l21
  %t887 = load double, double* %l22
  %t888 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t889 = load double, double* %l26
  %t890 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1027 = phi { i8**, i64 }* [ %t873, %else76 ], [ %t1023, %loop.latch80 ]
  %t1028 = phi %NativeFunction* [ %t880, %else76 ], [ %t1024, %loop.latch80 ]
  %t1029 = phi i1 [ %t890, %else76 ], [ %t1025, %loop.latch80 ]
  %t1030 = phi double [ %t889, %else76 ], [ %t1026, %loop.latch80 ]
  store { i8**, i64 }* %t1027, { i8**, i64 }** %l1
  store %NativeFunction* %t1028, %NativeFunction** %l8
  store i1 %t1029, i1* %l27
  store double %t1030, double* %l26
  br label %loop.body79
loop.body79:
  %t891 = load double, double* %l26
  %t892 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t893 = load { i8**, i64 }, { i8**, i64 }* %t892
  %t894 = extractvalue { i8**, i64 } %t893, 1
  %t895 = sitofp i64 %t894 to double
  %t896 = fcmp oge double %t891, %t895
  %t897 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t898 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t899 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t900 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t901 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t902 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t903 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t904 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t905 = load %NativeFunction*, %NativeFunction** %l8
  %t906 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t907 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t908 = load double, double* %l11
  %t909 = load i8*, i8** %l12
  %t910 = load i8*, i8** %l13
  %t911 = load i8*, i8** %l21
  %t912 = load double, double* %l22
  %t913 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t914 = load double, double* %l26
  %t915 = load i1, i1* %l27
  br i1 %t896, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t916 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t917 = load double, double* %l26
  %t918 = fptosi double %t917 to i64
  %t919 = load { i8**, i64 }, { i8**, i64 }* %t916
  %t920 = extractvalue { i8**, i64 } %t919, 0
  %t921 = extractvalue { i8**, i64 } %t919, 1
  %t922 = icmp uge i64 %t918, %t921
  ; bounds check: %t922 (if true, out of bounds)
  %t923 = getelementptr i8*, i8** %t920, i64 %t918
  %t924 = load i8*, i8** %t923
  store i8* %t924, i8** %l28
  %t925 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t925, %NativeSourceSpan** %l29
  %t926 = load i1, i1* %l27
  %t927 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t928 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t929 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t930 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t931 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t932 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t933 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t934 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t935 = load %NativeFunction*, %NativeFunction** %l8
  %t936 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t937 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t938 = load double, double* %l11
  %t939 = load i8*, i8** %l12
  %t940 = load i8*, i8** %l13
  %t941 = load i8*, i8** %l21
  %t942 = load double, double* %l22
  %t943 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t944 = load double, double* %l26
  %t945 = load i1, i1* %l27
  %t946 = load i8*, i8** %l28
  %t947 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t926, label %then84, label %merge85
then84:
  %t948 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t948, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t949 = phi %NativeSourceSpan* [ %t948, %then84 ], [ %t947, %loop.body79 ]
  store %NativeSourceSpan* %t949, %NativeSourceSpan** %l29
  %t950 = load i8*, i8** %l28
  %t951 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t952 = call %NativeParameter* @parse_parameter_entry(i8* %t950, %NativeSourceSpan* %t951)
  store %NativeParameter* %t952, %NativeParameter** %l30
  %t953 = load %NativeParameter*, %NativeParameter** %l30
  %t954 = bitcast i8* null to %NativeParameter*
  %t955 = icmp eq %NativeParameter* %t953, %t954
  %t956 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t957 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t958 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t959 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t960 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t961 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t962 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t963 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t964 = load %NativeFunction*, %NativeFunction** %l8
  %t965 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t966 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t967 = load double, double* %l11
  %t968 = load i8*, i8** %l12
  %t969 = load i8*, i8** %l13
  %t970 = load i8*, i8** %l21
  %t971 = load double, double* %l22
  %t972 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t973 = load double, double* %l26
  %t974 = load i1, i1* %l27
  %t975 = load i8*, i8** %l28
  %t976 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t977 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t955, label %then86, label %else87
then86:
  %t978 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s979 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.979, i32 0, i32 0
  %t980 = load i8*, i8** %l28
  %t981 = add i8* %s979, %t980
  %t982 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t978, i8* %t981)
  store { i8**, i64 }* %t982, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t983 = load %NativeFunction*, %NativeFunction** %l8
  %t984 = load %NativeParameter*, %NativeParameter** %l30
  %t985 = load %NativeFunction, %NativeFunction* %t983
  %t986 = load %NativeParameter, %NativeParameter* %t984
  %t987 = call %NativeFunction @append_parameter(%NativeFunction %t985, %NativeParameter %t986)
  %t988 = alloca %NativeFunction
  store %NativeFunction %t987, %NativeFunction* %t988
  store %NativeFunction* %t988, %NativeFunction** %l8
  %t989 = load %NativeParameter*, %NativeParameter** %l30
  %t990 = getelementptr %NativeParameter, %NativeParameter* %t989, i32 0, i32 4
  %t991 = load %NativeSourceSpan*, %NativeSourceSpan** %t990
  %t992 = bitcast i8* null to %NativeSourceSpan*
  %t993 = icmp ne %NativeSourceSpan* %t991, %t992
  %t994 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t995 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t996 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t997 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t998 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t999 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1000 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1001 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1002 = load %NativeFunction*, %NativeFunction** %l8
  %t1003 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1004 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1005 = load double, double* %l11
  %t1006 = load i8*, i8** %l12
  %t1007 = load i8*, i8** %l13
  %t1008 = load i8*, i8** %l21
  %t1009 = load double, double* %l22
  %t1010 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1011 = load double, double* %l26
  %t1012 = load i1, i1* %l27
  %t1013 = load i8*, i8** %l28
  %t1014 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1015 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t993, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  br label %merge90
merge90:
  %t1016 = phi i1 [ 1, %then89 ], [ %t1012, %else87 ]
  store i1 %t1016, i1* %l27
  br label %merge88
merge88:
  %t1017 = phi { i8**, i64 }* [ %t982, %then86 ], [ %t957, %else87 ]
  %t1018 = phi %NativeFunction* [ %t964, %then86 ], [ %t988, %else87 ]
  %t1019 = phi i1 [ %t974, %then86 ], [ 1, %else87 ]
  store { i8**, i64 }* %t1017, { i8**, i64 }** %l1
  store %NativeFunction* %t1018, %NativeFunction** %l8
  store i1 %t1019, i1* %l27
  %t1020 = load double, double* %l26
  %t1021 = sitofp i64 1 to double
  %t1022 = fadd double %t1020, %t1021
  store double %t1022, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1023 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1024 = load %NativeFunction*, %NativeFunction** %l8
  %t1025 = load i1, i1* %l27
  %t1026 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1031 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1031, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1032 = phi { i8**, i64 }* [ %t869, %then75 ], [ %t982, %else76 ]
  %t1033 = phi %NativeSourceSpan* [ %t870, %then75 ], [ %t1031, %else76 ]
  %t1034 = phi %NativeFunction* [ %t856, %then75 ], [ %t988, %else76 ]
  store { i8**, i64 }* %t1032, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1033, %NativeSourceSpan** %l9
  store %NativeFunction* %t1034, %NativeFunction** %l8
  %t1035 = load double, double* %l22
  %t1036 = sitofp i64 1 to double
  %t1037 = fsub double %t1035, %t1036
  store double %t1037, double* %l11
  br label %merge62
else61:
  %t1038 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1039 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.1039, i32 0, i32 0
  %t1040 = load i8*, i8** %l13
  %t1041 = add i8* %s1039, %t1040
  %t1042 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1038, i8* %t1041)
  store { i8**, i64 }* %t1042, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1043 = phi { i8**, i64 }* [ %t869, %then60 ], [ %t1042, %else61 ]
  %t1044 = phi %NativeSourceSpan* [ %t870, %then60 ], [ %t700, %else61 ]
  %t1045 = phi %NativeFunction* [ %t988, %then60 ], [ %t699, %else61 ]
  %t1046 = phi double [ %t1037, %then60 ], [ %t702, %else61 ]
  store { i8**, i64 }* %t1043, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1044, %NativeSourceSpan** %l9
  store %NativeFunction* %t1045, %NativeFunction** %l8
  store double %t1046, double* %l11
  %t1047 = load double, double* %l11
  %t1048 = sitofp i64 1 to double
  %t1049 = fadd double %t1047, %t1048
  store double %t1049, double* %l11
  br label %loop.latch2
merge59:
  %t1050 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1051 = load double, double* %l11
  %t1052 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1050, double %t1051)
  store %InstructionGatherResult %t1052, %InstructionGatherResult* %l31
  %t1053 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1054 = extractvalue %InstructionGatherResult %t1053, 0
  store i8* %t1054, i8** %l13
  %t1055 = load double, double* %l11
  %t1056 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1057 = extractvalue %InstructionGatherResult %t1056, 1
  %t1058 = fadd double %t1055, %t1057
  store double %t1058, double* %l11
  %t1059 = load i8*, i8** %l13
  %t1060 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1061 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1062 = call %InstructionParseResult @parse_instruction(i8* %t1059, %NativeSourceSpan* %t1060, %NativeSourceSpan* %t1061)
  store %InstructionParseResult %t1062, %InstructionParseResult* %l32
  %t1063 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1064 = extractvalue %InstructionParseResult %t1063, 0
  store { %NativeInstruction**, i64 }* %t1064, { %NativeInstruction**, i64 }** %l33
  %t1065 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1066 = extractvalue %InstructionParseResult %t1065, 1
  %t1067 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1068 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1069 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1070 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1071 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1072 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1073 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1074 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1075 = load %NativeFunction*, %NativeFunction** %l8
  %t1076 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1077 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1078 = load double, double* %l11
  %t1079 = load i8*, i8** %l12
  %t1080 = load i8*, i8** %l13
  %t1081 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1082 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1083 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1066, label %then91, label %else92
then91:
  %t1084 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1084, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1085 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1086 = bitcast i8* null to %NativeSourceSpan*
  %t1087 = icmp ne %NativeSourceSpan* %t1085, %t1086
  %t1088 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1089 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1090 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1091 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1092 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1093 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1094 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1095 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1096 = load %NativeFunction*, %NativeFunction** %l8
  %t1097 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1098 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1099 = load double, double* %l11
  %t1100 = load i8*, i8** %l12
  %t1101 = load i8*, i8** %l13
  %t1102 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1103 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1104 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1087, label %then94, label %merge95
then94:
  %t1105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1106 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.1106, i32 0, i32 0
  %t1107 = load i8*, i8** %l13
  %t1108 = add i8* %s1106, %t1107
  %t1109 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1105, i8* %t1108)
  store { i8**, i64 }* %t1109, { i8**, i64 }** %l1
  %t1110 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1110, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1111 = phi { i8**, i64 }* [ %t1109, %then94 ], [ %t1089, %else92 ]
  %t1112 = phi %NativeSourceSpan* [ %t1110, %then94 ], [ %t1097, %else92 ]
  store { i8**, i64 }* %t1111, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1112, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1113 = phi %NativeSourceSpan* [ %t1084, %then91 ], [ %t1110, %else92 ]
  %t1114 = phi { i8**, i64 }* [ %t1068, %then91 ], [ %t1109, %else92 ]
  store %NativeSourceSpan* %t1113, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1114, { i8**, i64 }** %l1
  %t1115 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1116 = extractvalue %InstructionParseResult %t1115, 2
  %t1117 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1119 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1120 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1121 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1122 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1123 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1124 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1125 = load %NativeFunction*, %NativeFunction** %l8
  %t1126 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1127 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1128 = load double, double* %l11
  %t1129 = load i8*, i8** %l12
  %t1130 = load i8*, i8** %l13
  %t1131 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1132 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1133 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1116, label %then96, label %else97
then96:
  %t1134 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1134, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1135 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1136 = bitcast i8* null to %NativeSourceSpan*
  %t1137 = icmp ne %NativeSourceSpan* %t1135, %t1136
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1140 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1141 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1142 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1143 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1144 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1145 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1146 = load %NativeFunction*, %NativeFunction** %l8
  %t1147 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1148 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1149 = load double, double* %l11
  %t1150 = load i8*, i8** %l12
  %t1151 = load i8*, i8** %l13
  %t1152 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1153 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1154 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1137, label %then99, label %merge100
then99:
  %t1155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1156 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.1156, i32 0, i32 0
  %t1157 = load i8*, i8** %l13
  %t1158 = add i8* %s1156, %t1157
  %t1159 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1155, i8* %t1158)
  store { i8**, i64 }* %t1159, { i8**, i64 }** %l1
  %t1160 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1160, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1161 = phi { i8**, i64 }* [ %t1159, %then99 ], [ %t1139, %else97 ]
  %t1162 = phi %NativeSourceSpan* [ %t1160, %then99 ], [ %t1148, %else97 ]
  store { i8**, i64 }* %t1161, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1162, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1163 = phi %NativeSourceSpan* [ %t1134, %then96 ], [ %t1160, %else97 ]
  %t1164 = phi { i8**, i64 }* [ %t1118, %then96 ], [ %t1159, %else97 ]
  store %NativeSourceSpan* %t1163, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1164, { i8**, i64 }** %l1
  %t1165 = load %NativeFunction*, %NativeFunction** %l8
  %t1166 = bitcast i8* null to %NativeFunction*
  %t1167 = icmp eq %NativeFunction* %t1165, %t1166
  %t1168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1170 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1171 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1172 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1173 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1174 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1175 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1176 = load %NativeFunction*, %NativeFunction** %l8
  %t1177 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1178 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1179 = load double, double* %l11
  %t1180 = load i8*, i8** %l12
  %t1181 = load i8*, i8** %l13
  %t1182 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1183 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1184 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1167, label %then101, label %merge102
then101:
  %t1186 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1187 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1186
  %t1188 = extractvalue { %NativeInstruction**, i64 } %t1187, 1
  %t1189 = icmp eq i64 %t1188, 1
  br label %logical_and_entry_1185

logical_and_entry_1185:
  br i1 %t1189, label %logical_and_right_1185, label %logical_and_merge_1185

logical_and_right_1185:
  %t1190 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1191 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1190
  %t1192 = extractvalue { %NativeInstruction**, i64 } %t1191, 0
  %t1193 = extractvalue { %NativeInstruction**, i64 } %t1191, 1
  %t1194 = icmp uge i64 0, %t1193
  ; bounds check: %t1194 (if true, out of bounds)
  %t1195 = getelementptr %NativeInstruction*, %NativeInstruction** %t1192, i64 0
  %t1196 = load %NativeInstruction*, %NativeInstruction** %t1195
  %t1197 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1196, i32 0, i32 0
  %t1198 = load i32, i32* %t1197
  %t1199 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1200 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1198, 0
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1198, 1
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1198, 2
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1198, 3
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1198, 4
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1198, 5
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1198, 6
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1198, 7
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1198, 8
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %t1227 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1228 = icmp eq i32 %t1198, 9
  %t1229 = select i1 %t1228, i8* %t1227, i8* %t1226
  %t1230 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1231 = icmp eq i32 %t1198, 10
  %t1232 = select i1 %t1231, i8* %t1230, i8* %t1229
  %t1233 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1234 = icmp eq i32 %t1198, 11
  %t1235 = select i1 %t1234, i8* %t1233, i8* %t1232
  %t1236 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1237 = icmp eq i32 %t1198, 12
  %t1238 = select i1 %t1237, i8* %t1236, i8* %t1235
  %t1239 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1240 = icmp eq i32 %t1198, 13
  %t1241 = select i1 %t1240, i8* %t1239, i8* %t1238
  %t1242 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1243 = icmp eq i32 %t1198, 14
  %t1244 = select i1 %t1243, i8* %t1242, i8* %t1241
  %t1245 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1198, 15
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1198, 16
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %s1251 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1251, i32 0, i32 0
  %t1252 = icmp eq i8* %t1250, %s1251
  br label %logical_and_right_end_1185

logical_and_right_end_1185:
  br label %logical_and_merge_1185

logical_and_merge_1185:
  %t1253 = phi i1 [ false, %logical_and_entry_1185 ], [ %t1252, %logical_and_right_end_1185 ]
  %t1254 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1256 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1257 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1258 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1259 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1260 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1261 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1262 = load %NativeFunction*, %NativeFunction** %l8
  %t1263 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1264 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1265 = load double, double* %l11
  %t1266 = load i8*, i8** %l12
  %t1267 = load i8*, i8** %l13
  %t1268 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1269 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1270 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1253, label %then103, label %else104
then103:
  %t1271 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1272 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1273 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1272
  %t1274 = extractvalue { %NativeInstruction**, i64 } %t1273, 0
  %t1275 = extractvalue { %NativeInstruction**, i64 } %t1273, 1
  %t1276 = icmp uge i64 0, %t1275
  ; bounds check: %t1276 (if true, out of bounds)
  %t1277 = getelementptr %NativeInstruction*, %NativeInstruction** %t1274, i64 0
  %t1278 = load %NativeInstruction*, %NativeInstruction** %t1277
  %t1279 = load %NativeInstruction, %NativeInstruction* %t1278
  %t1280 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1279)
  %t1281 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1271, %NativeBinding %t1280)
  store { %NativeBinding*, i64 }* %t1281, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1283 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.1283, i32 0, i32 0
  %t1284 = load i8*, i8** %l13
  %t1285 = add i8* %s1283, %t1284
  %t1286 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1282, i8* %t1285)
  store { i8**, i64 }* %t1286, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1287 = phi { %NativeBinding*, i64 }* [ %t1281, %then103 ], [ %t1261, %else104 ]
  %t1288 = phi { i8**, i64 }* [ %t1255, %then103 ], [ %t1286, %else104 ]
  store { %NativeBinding*, i64 }* %t1287, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1288, { i8**, i64 }** %l1
  %t1289 = load double, double* %l11
  %t1290 = sitofp i64 1 to double
  %t1291 = fadd double %t1289, %t1290
  store double %t1291, double* %l11
  br label %loop.latch2
merge102:
  %t1292 = sitofp i64 0 to double
  store double %t1292, double* %l34
  %t1293 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1295 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1296 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1297 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1298 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1299 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1300 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1301 = load %NativeFunction*, %NativeFunction** %l8
  %t1302 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1303 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1304 = load double, double* %l11
  %t1305 = load i8*, i8** %l12
  %t1306 = load i8*, i8** %l13
  %t1307 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1308 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1309 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1310 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1354 = phi %NativeFunction* [ %t1301, %loop.body1 ], [ %t1352, %loop.latch108 ]
  %t1355 = phi double [ %t1310, %loop.body1 ], [ %t1353, %loop.latch108 ]
  store %NativeFunction* %t1354, %NativeFunction** %l8
  store double %t1355, double* %l34
  br label %loop.body107
loop.body107:
  %t1311 = load double, double* %l34
  %t1312 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1313 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1312
  %t1314 = extractvalue { %NativeInstruction**, i64 } %t1313, 1
  %t1315 = sitofp i64 %t1314 to double
  %t1316 = fcmp oge double %t1311, %t1315
  %t1317 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1319 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1320 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1321 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1322 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1323 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1324 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1325 = load %NativeFunction*, %NativeFunction** %l8
  %t1326 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1327 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1328 = load double, double* %l11
  %t1329 = load i8*, i8** %l12
  %t1330 = load i8*, i8** %l13
  %t1331 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1332 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1333 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1334 = load double, double* %l34
  br i1 %t1316, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1335 = load %NativeFunction*, %NativeFunction** %l8
  %t1336 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1337 = load double, double* %l34
  %t1338 = fptosi double %t1337 to i64
  %t1339 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1336
  %t1340 = extractvalue { %NativeInstruction**, i64 } %t1339, 0
  %t1341 = extractvalue { %NativeInstruction**, i64 } %t1339, 1
  %t1342 = icmp uge i64 %t1338, %t1341
  ; bounds check: %t1342 (if true, out of bounds)
  %t1343 = getelementptr %NativeInstruction*, %NativeInstruction** %t1340, i64 %t1338
  %t1344 = load %NativeInstruction*, %NativeInstruction** %t1343
  %t1345 = load %NativeFunction, %NativeFunction* %t1335
  %t1346 = load %NativeInstruction, %NativeInstruction* %t1344
  %t1347 = call %NativeFunction @append_instruction(%NativeFunction %t1345, %NativeInstruction %t1346)
  %t1348 = alloca %NativeFunction
  store %NativeFunction %t1347, %NativeFunction* %t1348
  store %NativeFunction* %t1348, %NativeFunction** %l8
  %t1349 = load double, double* %l34
  %t1350 = sitofp i64 1 to double
  %t1351 = fadd double %t1349, %t1350
  store double %t1351, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1352 = load %NativeFunction*, %NativeFunction** %l8
  %t1353 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1356 = load double, double* %l11
  %t1357 = sitofp i64 1 to double
  %t1358 = fadd double %t1356, %t1357
  store double %t1358, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1359 = load double, double* %l11
  %t1360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1361 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1362 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1363 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1364 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1365 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1366 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1367 = load %NativeFunction*, %NativeFunction** %l8
  %t1368 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1369 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1381 = load %NativeFunction*, %NativeFunction** %l8
  %t1382 = bitcast i8* null to %NativeFunction*
  %t1383 = icmp ne %NativeFunction* %t1381, %t1382
  %t1384 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1386 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1387 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1388 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1389 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1390 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1391 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1392 = load %NativeFunction*, %NativeFunction** %l8
  %t1393 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1394 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1395 = load double, double* %l11
  br i1 %t1383, label %then112, label %merge113
then112:
  %t1396 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1397 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.1397, i32 0, i32 0
  %t1398 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1396, i8* %s1397)
  store { i8**, i64 }* %t1398, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1399 = phi { i8**, i64 }* [ %t1398, %then112 ], [ %t1385, %entry ]
  store { i8**, i64 }* %t1399, { i8**, i64 }** %l1
  %t1400 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1401 = bitcast { %NativeFunction*, i64 }* %t1400 to { %NativeFunction**, i64 }*
  %t1402 = insertvalue %ParseNativeResult undef, { %NativeFunction**, i64 }* %t1401, 0
  %t1403 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1404 = bitcast { %NativeImport*, i64 }* %t1403 to { %NativeImport**, i64 }*
  %t1405 = insertvalue %ParseNativeResult %t1402, { %NativeImport**, i64 }* %t1404, 1
  %t1406 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1407 = bitcast { %NativeStruct*, i64 }* %t1406 to { %NativeStruct**, i64 }*
  %t1408 = insertvalue %ParseNativeResult %t1405, { %NativeStruct**, i64 }* %t1407, 2
  %t1409 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1410 = bitcast { %NativeInterface*, i64 }* %t1409 to { %NativeInterface**, i64 }*
  %t1411 = insertvalue %ParseNativeResult %t1408, { %NativeInterface**, i64 }* %t1410, 3
  %t1412 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1413 = bitcast { %NativeEnum*, i64 }* %t1412 to { %NativeEnum**, i64 }*
  %t1414 = insertvalue %ParseNativeResult %t1411, { %NativeEnum**, i64 }* %t1413, 4
  %t1415 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1416 = bitcast { %NativeBinding*, i64 }* %t1415 to { %NativeBinding**, i64 }*
  %t1417 = insertvalue %ParseNativeResult %t1414, { %NativeBinding**, i64 }* %t1416, 5
  %t1418 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1419 = insertvalue %ParseNativeResult %t1417, { i8**, i64 }* %t1418, 6
  ret %ParseNativeResult %t1419
}

define %NativeSourceSpan* @parse_source_span(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NumberParseResult
  %l3 = alloca %NumberParseResult
  %l4 = alloca %NumberParseResult
  %l5 = alloca %NumberParseResult
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = call { i8**, i64 }* @split_whitespace(i8* %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t8
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = icmp ne i64 %t10, 4
  %t12 = load i8*, i8** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t14
merge3:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 0, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 0
  %t21 = load i8*, i8** %t20
  %t22 = call %NumberParseResult @parse_decimal_number(i8* %t21)
  store %NumberParseResult %t22, %NumberParseResult* %l2
  %t23 = load %NumberParseResult, %NumberParseResult* %l2
  %t24 = extractvalue %NumberParseResult %t23, 0
  %t25 = xor i1 %t24, 1
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NumberParseResult, %NumberParseResult* %l2
  br i1 %t25, label %then4, label %merge5
then4:
  %t29 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t29
merge5:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 1, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 1
  %t36 = load i8*, i8** %t35
  %t37 = call %NumberParseResult @parse_decimal_number(i8* %t36)
  store %NumberParseResult %t37, %NumberParseResult* %l3
  %t38 = load %NumberParseResult, %NumberParseResult* %l3
  %t39 = extractvalue %NumberParseResult %t38, 0
  %t40 = xor i1 %t39, 1
  %t41 = load i8*, i8** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load %NumberParseResult, %NumberParseResult* %l2
  %t44 = load %NumberParseResult, %NumberParseResult* %l3
  br i1 %t40, label %then6, label %merge7
then6:
  %t45 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t45
merge7:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 0
  %t49 = extractvalue { i8**, i64 } %t47, 1
  %t50 = icmp uge i64 2, %t49
  ; bounds check: %t50 (if true, out of bounds)
  %t51 = getelementptr i8*, i8** %t48, i64 2
  %t52 = load i8*, i8** %t51
  %t53 = call %NumberParseResult @parse_decimal_number(i8* %t52)
  store %NumberParseResult %t53, %NumberParseResult* %l4
  %t54 = load %NumberParseResult, %NumberParseResult* %l4
  %t55 = extractvalue %NumberParseResult %t54, 0
  %t56 = xor i1 %t55, 1
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %NumberParseResult, %NumberParseResult* %l2
  %t60 = load %NumberParseResult, %NumberParseResult* %l3
  %t61 = load %NumberParseResult, %NumberParseResult* %l4
  br i1 %t56, label %then8, label %merge9
then8:
  %t62 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t62
merge9:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t63
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 3, %t66
  ; bounds check: %t67 (if true, out of bounds)
  %t68 = getelementptr i8*, i8** %t65, i64 3
  %t69 = load i8*, i8** %t68
  %t70 = call %NumberParseResult @parse_decimal_number(i8* %t69)
  store %NumberParseResult %t70, %NumberParseResult* %l5
  %t71 = load %NumberParseResult, %NumberParseResult* %l5
  %t72 = extractvalue %NumberParseResult %t71, 0
  %t73 = xor i1 %t72, 1
  %t74 = load i8*, i8** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load %NumberParseResult, %NumberParseResult* %l2
  %t77 = load %NumberParseResult, %NumberParseResult* %l3
  %t78 = load %NumberParseResult, %NumberParseResult* %l4
  %t79 = load %NumberParseResult, %NumberParseResult* %l5
  br i1 %t73, label %then10, label %merge11
then10:
  %t80 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t80
merge11:
  %t81 = load %NumberParseResult, %NumberParseResult* %l2
  %t82 = extractvalue %NumberParseResult %t81, 1
  %t83 = insertvalue %NativeSourceSpan undef, double %t82, 0
  %t84 = load %NumberParseResult, %NumberParseResult* %l3
  %t85 = extractvalue %NumberParseResult %t84, 1
  %t86 = insertvalue %NativeSourceSpan %t83, double %t85, 1
  %t87 = load %NumberParseResult, %NumberParseResult* %l4
  %t88 = extractvalue %NumberParseResult %t87, 1
  %t89 = insertvalue %NativeSourceSpan %t86, double %t88, 2
  %t90 = load %NumberParseResult, %NumberParseResult* %l5
  %t91 = extractvalue %NumberParseResult %t90, 1
  %t92 = insertvalue %NativeSourceSpan %t89, double %t91, 3
  %t93 = alloca %NativeSourceSpan
  store %NativeSourceSpan %t92, %NativeSourceSpan* %t93
  ret %NativeSourceSpan* %t93
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

define %InstructionParseResult @parse_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
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
  %t249 = call %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span)
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
  %t272 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t266, i32 0, i32 1
  %t273 = bitcast [16 x i8]* %t272 to i8*
  %t274 = getelementptr inbounds i8, i8* %t273, i64 8
  %t275 = bitcast i8* %t274 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t275
  %t276 = load %NativeInstruction, %NativeInstruction* %t266
  %t277 = alloca [1 x %NativeInstruction]
  %t278 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t277, i32 0, i32 0
  %t279 = getelementptr %NativeInstruction, %NativeInstruction* %t278, i64 0
  store %NativeInstruction %t276, %NativeInstruction* %t279
  %t280 = alloca { %NativeInstruction*, i64 }
  %t281 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t280, i32 0, i32 0
  store %NativeInstruction* %t278, %NativeInstruction** %t281
  %t282 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t280, i32 0, i32 1
  store i64 1, i64* %t282
  %t283 = bitcast { %NativeInstruction*, i64 }* %t280 to { %NativeInstruction**, i64 }*
  %t284 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t283, 0
  %t285 = insertvalue %InstructionParseResult %t284, i1 1, 1
  %t286 = insertvalue %InstructionParseResult %t285, i1 0, 2
  ret %InstructionParseResult %t286
merge33:
  %t287 = getelementptr i8, i8* %line, i64 3
  %t288 = load i8, i8* %t287
  store i8 %t288, i8* %l7
  %t290 = load i8, i8* %l7
  %t291 = icmp eq i8 %t290, 32
  br label %logical_or_entry_289

logical_or_entry_289:
  br i1 %t291, label %logical_or_merge_289, label %logical_or_right_289

logical_or_right_289:
  %t292 = load i8, i8* %l7
  %t293 = icmp eq i8 %t292, 9
  br label %logical_or_right_end_289

logical_or_right_end_289:
  br label %logical_or_merge_289

logical_or_merge_289:
  %t294 = phi i1 [ true, %logical_or_entry_289 ], [ %t293, %logical_or_right_end_289 ]
  %t295 = load i8, i8* %l7
  br i1 %t294, label %then34, label %merge35
then34:
  %t296 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t297 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t296)
  %t298 = call i8* @trim_text(i8* %t297)
  store i8* %t298, i8** %l8
  %t299 = load i8*, i8** %l8
  %t300 = call i64 @sailfin_runtime_string_length(i8* %t299)
  %t301 = icmp eq i64 %t300, 0
  %t302 = load i8, i8* %l7
  %t303 = load i8*, i8** %l8
  br i1 %t301, label %then36, label %merge37
then36:
  %t304 = alloca %NativeInstruction
  %t305 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t304, i32 0, i32 0
  store i32 0, i32* %t305
  %s306 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.306, i32 0, i32 0
  %t307 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t304, i32 0, i32 1
  %t308 = bitcast [16 x i8]* %t307 to i8*
  %t309 = bitcast i8* %t308 to i8**
  store i8* %s306, i8** %t309
  %t310 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t304, i32 0, i32 1
  %t311 = bitcast [16 x i8]* %t310 to i8*
  %t312 = getelementptr inbounds i8, i8* %t311, i64 8
  %t313 = bitcast i8* %t312 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t313
  %t314 = load %NativeInstruction, %NativeInstruction* %t304
  %t315 = alloca [1 x %NativeInstruction]
  %t316 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t315, i32 0, i32 0
  %t317 = getelementptr %NativeInstruction, %NativeInstruction* %t316, i64 0
  store %NativeInstruction %t314, %NativeInstruction* %t317
  %t318 = alloca { %NativeInstruction*, i64 }
  %t319 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t318, i32 0, i32 0
  store %NativeInstruction* %t316, %NativeInstruction** %t319
  %t320 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t318, i32 0, i32 1
  store i64 1, i64* %t320
  %t321 = bitcast { %NativeInstruction*, i64 }* %t318 to { %NativeInstruction**, i64 }*
  %t322 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t321, 0
  %t323 = insertvalue %InstructionParseResult %t322, i1 1, 1
  %t324 = insertvalue %InstructionParseResult %t323, i1 0, 2
  ret %InstructionParseResult %t324
merge37:
  %t325 = alloca %NativeInstruction
  %t326 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t325, i32 0, i32 0
  store i32 0, i32* %t326
  %t327 = load i8*, i8** %l8
  %t328 = call i8* @trim_trailing_delimiters(i8* %t327)
  %t329 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t325, i32 0, i32 1
  %t330 = bitcast [16 x i8]* %t329 to i8*
  %t331 = bitcast i8* %t330 to i8**
  store i8* %t328, i8** %t331
  %t332 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t325, i32 0, i32 1
  %t333 = bitcast [16 x i8]* %t332 to i8*
  %t334 = getelementptr inbounds i8, i8* %t333, i64 8
  %t335 = bitcast i8* %t334 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t335
  %t336 = load %NativeInstruction, %NativeInstruction* %t325
  %t337 = alloca [1 x %NativeInstruction]
  %t338 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t337, i32 0, i32 0
  %t339 = getelementptr %NativeInstruction, %NativeInstruction* %t338, i64 0
  store %NativeInstruction %t336, %NativeInstruction* %t339
  %t340 = alloca { %NativeInstruction*, i64 }
  %t341 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t340, i32 0, i32 0
  store %NativeInstruction* %t338, %NativeInstruction** %t341
  %t342 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t340, i32 0, i32 1
  store i64 1, i64* %t342
  %t343 = bitcast { %NativeInstruction*, i64 }* %t340 to { %NativeInstruction**, i64 }*
  %t344 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t343, 0
  %t345 = insertvalue %InstructionParseResult %t344, i1 1, 1
  %t346 = insertvalue %InstructionParseResult %t345, i1 0, 2
  ret %InstructionParseResult %t346
merge35:
  br label %merge31
merge31:
  %s347 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.347, i32 0, i32 0
  %t348 = call i1 @starts_with(i8* %line, i8* %s347)
  br i1 %t348, label %then38, label %merge39
then38:
  %s349 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.349, i32 0, i32 0
  %t350 = call i8* @strip_prefix(i8* %line, i8* %s349)
  %t351 = call i8* @trim_text(i8* %t350)
  store i8* %t351, i8** %l9
  store i1 0, i1* %l10
  %t352 = load i8*, i8** %l9
  %s353 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.353, i32 0, i32 0
  %t354 = call i1 @starts_with(i8* %t352, i8* %s353)
  %t355 = load i8*, i8** %l9
  %t356 = load i1, i1* %l10
  br i1 %t354, label %then40, label %merge41
then40:
  store i1 1, i1* %l10
  %t357 = load i8*, i8** %l9
  %s358 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.358, i32 0, i32 0
  %t359 = call i8* @strip_prefix(i8* %t357, i8* %s358)
  %t360 = call i8* @trim_text(i8* %t359)
  store i8* %t360, i8** %l9
  br label %merge41
merge41:
  %t361 = phi i1 [ 1, %then40 ], [ %t356, %then38 ]
  %t362 = phi i8* [ %t360, %then40 ], [ %t355, %then38 ]
  store i1 %t361, i1* %l10
  store i8* %t362, i8** %l9
  %t363 = load i8*, i8** %l9
  %t364 = call %BindingComponents @parse_binding_components(i8* %t363)
  store %BindingComponents %t364, %BindingComponents* %l11
  %t365 = alloca %NativeInstruction
  %t366 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 0
  store i32 2, i32* %t366
  %t367 = load %BindingComponents, %BindingComponents* %l11
  %t368 = extractvalue %BindingComponents %t367, 0
  %t369 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 1
  %t370 = bitcast [48 x i8]* %t369 to i8*
  %t371 = bitcast i8* %t370 to i8**
  store i8* %t368, i8** %t371
  %t372 = load i1, i1* %l10
  %t373 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 1
  %t374 = bitcast [48 x i8]* %t373 to i8*
  %t375 = getelementptr inbounds i8, i8* %t374, i64 8
  %t376 = bitcast i8* %t375 to i1*
  store i1 %t372, i1* %t376
  %t377 = load %BindingComponents, %BindingComponents* %l11
  %t378 = extractvalue %BindingComponents %t377, 1
  %t379 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 1
  %t380 = bitcast [48 x i8]* %t379 to i8*
  %t381 = getelementptr inbounds i8, i8* %t380, i64 16
  %t382 = bitcast i8* %t381 to i8**
  store i8* %t378, i8** %t382
  %t383 = load %BindingComponents, %BindingComponents* %l11
  %t384 = extractvalue %BindingComponents %t383, 2
  %t385 = call i8* @maybe_trim_trailing(i8* %t384)
  %t386 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 1
  %t387 = bitcast [48 x i8]* %t386 to i8*
  %t388 = getelementptr inbounds i8, i8* %t387, i64 24
  %t389 = bitcast i8* %t388 to i8**
  store i8* %t385, i8** %t389
  %t390 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 1
  %t391 = bitcast [48 x i8]* %t390 to i8*
  %t392 = getelementptr inbounds i8, i8* %t391, i64 32
  %t393 = bitcast i8* %t392 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t393
  %t394 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t365, i32 0, i32 1
  %t395 = bitcast [48 x i8]* %t394 to i8*
  %t396 = getelementptr inbounds i8, i8* %t395, i64 40
  %t397 = bitcast i8* %t396 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t397
  %t398 = load %NativeInstruction, %NativeInstruction* %t365
  %t399 = alloca [1 x %NativeInstruction]
  %t400 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t399, i32 0, i32 0
  %t401 = getelementptr %NativeInstruction, %NativeInstruction* %t400, i64 0
  store %NativeInstruction %t398, %NativeInstruction* %t401
  %t402 = alloca { %NativeInstruction*, i64 }
  %t403 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t402, i32 0, i32 0
  store %NativeInstruction* %t400, %NativeInstruction** %t403
  %t404 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t402, i32 0, i32 1
  store i64 1, i64* %t404
  %t405 = bitcast { %NativeInstruction*, i64 }* %t402 to { %NativeInstruction**, i64 }*
  %t406 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t405, 0
  %t407 = insertvalue %InstructionParseResult %t406, i1 1, 1
  %t408 = insertvalue %InstructionParseResult %t407, i1 1, 2
  ret %InstructionParseResult %t408
merge39:
  %s409 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.409, i32 0, i32 0
  %t410 = call i1 @starts_with(i8* %line, i8* %s409)
  br i1 %t410, label %then42, label %merge43
then42:
  %t411 = alloca %NativeInstruction
  %t412 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t411, i32 0, i32 0
  store i32 1, i32* %t412
  %s413 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.413, i32 0, i32 0
  %t414 = call i8* @strip_prefix(i8* %line, i8* %s413)
  %t415 = call i8* @trim_text(i8* %t414)
  %t416 = call i8* @trim_trailing_delimiters(i8* %t415)
  %t417 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t411, i32 0, i32 1
  %t418 = bitcast [16 x i8]* %t417 to i8*
  %t419 = bitcast i8* %t418 to i8**
  store i8* %t416, i8** %t419
  %t420 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t411, i32 0, i32 1
  %t421 = bitcast [16 x i8]* %t420 to i8*
  %t422 = getelementptr inbounds i8, i8* %t421, i64 8
  %t423 = bitcast i8* %t422 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t423
  %t424 = load %NativeInstruction, %NativeInstruction* %t411
  %t425 = alloca [1 x %NativeInstruction]
  %t426 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t425, i32 0, i32 0
  %t427 = getelementptr %NativeInstruction, %NativeInstruction* %t426, i64 0
  store %NativeInstruction %t424, %NativeInstruction* %t427
  %t428 = alloca { %NativeInstruction*, i64 }
  %t429 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t428, i32 0, i32 0
  store %NativeInstruction* %t426, %NativeInstruction** %t429
  %t430 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t428, i32 0, i32 1
  store i64 1, i64* %t430
  %t431 = bitcast { %NativeInstruction*, i64 }* %t428 to { %NativeInstruction**, i64 }*
  %t432 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t431, 0
  %t433 = insertvalue %InstructionParseResult %t432, i1 1, 1
  %t434 = insertvalue %InstructionParseResult %t433, i1 0, 2
  ret %InstructionParseResult %t434
merge43:
  %s435 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.435, i32 0, i32 0
  %t436 = call double @index_of(i8* %line, i8* %s435)
  %t437 = sitofp i64 0 to double
  %t438 = fcmp oge double %t436, %t437
  br i1 %t438, label %then44, label %merge45
then44:
  %t439 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t440 = bitcast { %NativeInstruction*, i64 }* %t439 to { %NativeInstruction**, i64 }*
  %t441 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t440, 0
  %t442 = insertvalue %InstructionParseResult %t441, i1 0, 1
  %t443 = insertvalue %InstructionParseResult %t442, i1 0, 2
  ret %InstructionParseResult %t443
merge45:
  %t444 = alloca %NativeInstruction
  %t445 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t444, i32 0, i32 0
  store i32 16, i32* %t445
  %t446 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t444, i32 0, i32 1
  %t447 = bitcast [8 x i8]* %t446 to i8*
  %t448 = bitcast i8* %t447 to i8**
  store i8* %line, i8** %t448
  %t449 = load %NativeInstruction, %NativeInstruction* %t444
  %t450 = alloca [1 x %NativeInstruction]
  %t451 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* %t450, i32 0, i32 0
  %t452 = getelementptr %NativeInstruction, %NativeInstruction* %t451, i64 0
  store %NativeInstruction %t449, %NativeInstruction* %t452
  %t453 = alloca { %NativeInstruction*, i64 }
  %t454 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t453, i32 0, i32 0
  store %NativeInstruction* %t451, %NativeInstruction** %t454
  %t455 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t453, i32 0, i32 1
  store i64 1, i64* %t455
  %t456 = bitcast { %NativeInstruction*, i64 }* %t453 to { %NativeInstruction**, i64 }*
  %t457 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t456, 0
  %t458 = insertvalue %InstructionParseResult %t457, i1 0, 1
  %t459 = insertvalue %InstructionParseResult %t458, i1 0, 2
  ret %InstructionParseResult %t459
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

define %NativeImport* @parse_import_entry(i8* %kind, i8* %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t5
merge1:
  %t6 = load i8*, i8** %l0
  store i8* %t6, i8** %l1
  %t7 = alloca [0 x %NativeImportSpecifier]
  %t8 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* %t7, i32 0, i32 0
  %t9 = alloca { %NativeImportSpecifier*, i64 }
  %t10 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t9, i32 0, i32 0
  store %NativeImportSpecifier* %t8, %NativeImportSpecifier** %t10
  %t11 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %NativeImportSpecifier*, i64 }* %t9, { %NativeImportSpecifier*, i64 }** %l2
  %t12 = load i8*, i8** %l0
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 123, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call double @index_of(i8* %t12, i8* %t16)
  store double %t17, double* %l3
  %t18 = load double, double* %l3
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oge double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t24 = load double, double* %l3
  br i1 %t20, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l0
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 125, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call double @last_index_of(i8* %t25, i8* %t29)
  store double %t30, double* %l4
  %t32 = load double, double* %l4
  %t33 = sitofp i64 0 to double
  %t34 = fcmp olt double %t32, %t33
  br label %logical_or_entry_31

logical_or_entry_31:
  br i1 %t34, label %logical_or_merge_31, label %logical_or_right_31

logical_or_right_31:
  %t35 = load double, double* %l4
  %t36 = load double, double* %l3
  %t37 = fcmp ole double %t35, %t36
  br label %logical_or_right_end_31

logical_or_right_end_31:
  br label %logical_or_merge_31

logical_or_merge_31:
  %t38 = phi i1 [ true, %logical_or_entry_31 ], [ %t37, %logical_or_right_end_31 ]
  %t39 = load i8*, i8** %l0
  %t40 = load i8*, i8** %l1
  %t41 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t42 = load double, double* %l3
  %t43 = load double, double* %l4
  br i1 %t38, label %then4, label %merge5
then4:
  %t44 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t44
merge5:
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l3
  %t47 = fptosi double %t46 to i64
  %t48 = call i8* @sailfin_runtime_substring(i8* %t45, i64 0, i64 %t47)
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l1
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l3
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  %t54 = load double, double* %l4
  %t55 = fptosi double %t53 to i64
  %t56 = fptosi double %t54 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t50, i64 %t55, i64 %t56)
  store i8* %t57, i8** %l5
  %t58 = load i8*, i8** %l5
  %t59 = call { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %t58)
  store { %NativeImportSpecifier*, i64 }* %t59, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge3
merge3:
  %t60 = phi i8* [ %t49, %then2 ], [ %t22, %entry ]
  %t61 = phi { %NativeImportSpecifier*, i64 }* [ %t59, %then2 ], [ %t23, %entry ]
  store i8* %t60, i8** %l1
  store { %NativeImportSpecifier*, i64 }* %t61, { %NativeImportSpecifier*, i64 }** %l2
  %t62 = load i8*, i8** %l1
  %t63 = call i8* @trim_text(i8* %t62)
  %t64 = call i8* @strip_quotes(i8* %t63)
  store i8* %t64, i8** %l1
  %t65 = insertvalue %NativeImport undef, i8* %kind, 0
  %t66 = load i8*, i8** %l1
  %t67 = insertvalue %NativeImport %t65, i8* %t66, 1
  %t68 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t69 = bitcast { %NativeImportSpecifier*, i64 }* %t68 to { %NativeImportSpecifier**, i64 }*
  %t70 = insertvalue %NativeImport %t67, { %NativeImportSpecifier**, i64 }* %t69, 2
  %t71 = alloca %NativeImport
  store %NativeImport %t70, %NativeImport* %t71
  ret %NativeImport* %t71
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
  %l8 = alloca %NativeFunction*
  %l9 = alloca %NativeSourceSpan*
  %l10 = alloca %NativeSourceSpan*
  %l11 = alloca { %NativeStructLayoutField*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i1
  %l15 = alloca i1
  %l16 = alloca double
  %l17 = alloca %NativeStructLayout*
  %l18 = alloca i8*
  %l19 = alloca %NativeParameter*
  %l20 = alloca %NativeSourceSpan*
  %l21 = alloca %NativeSourceSpan*
  %l22 = alloca %InstructionParseResult
  %l23 = alloca double
  %l24 = alloca i8*
  %l25 = alloca %StructLayoutHeaderParse
  %l26 = alloca %StructLayoutFieldParse
  %l27 = alloca %NativeStructField*
  %l28 = alloca i8*
  %l29 = alloca %NativeStructLayout*
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
  %t41 = bitcast i8* null to %NativeStruct*
  %t42 = insertvalue %StructParseResult undef, %NativeStruct* %t41, 0
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %start_index, %t43
  %t45 = insertvalue %StructParseResult %t42, double %t44, 1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = insertvalue %StructParseResult %t45, { i8**, i64 }* %t46, 2
  ret %StructParseResult %t47
merge1:
  %t48 = alloca [0 x %NativeStructField]
  %t49 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* %t48, i32 0, i32 0
  %t50 = alloca { %NativeStructField*, i64 }
  %t51 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t50, i32 0, i32 0
  store %NativeStructField* %t49, %NativeStructField** %t51
  %t52 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { %NativeStructField*, i64 }* %t50, { %NativeStructField*, i64 }** %l6
  %t53 = alloca [0 x %NativeFunction]
  %t54 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* %t53, i32 0, i32 0
  %t55 = alloca { %NativeFunction*, i64 }
  %t56 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t55, i32 0, i32 0
  store %NativeFunction* %t54, %NativeFunction** %t56
  %t57 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %NativeFunction*, i64 }* %t55, { %NativeFunction*, i64 }** %l7
  %t58 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t58, %NativeFunction** %l8
  %t59 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t59, %NativeSourceSpan** %l9
  %t60 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t60, %NativeSourceSpan** %l10
  %t61 = alloca [0 x %NativeStructLayoutField]
  %t62 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* %t61, i32 0, i32 0
  %t63 = alloca { %NativeStructLayoutField*, i64 }
  %t64 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t63, i32 0, i32 0
  store %NativeStructLayoutField* %t62, %NativeStructLayoutField** %t64
  %t65 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t63, i32 0, i32 1
  store i64 0, i64* %t65
  store { %NativeStructLayoutField*, i64 }* %t63, { %NativeStructLayoutField*, i64 }** %l11
  %t66 = sitofp i64 0 to double
  store double %t66, double* %l12
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %start_index, %t68
  store double %t69, double* %l16
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load i8*, i8** %l2
  %t73 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t74 = load i8*, i8** %l4
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t76 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t77 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t78 = load %NativeFunction*, %NativeFunction** %l8
  %t79 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t80 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t81 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t82 = load double, double* %l12
  %t83 = load double, double* %l13
  %t84 = load i1, i1* %l14
  %t85 = load i1, i1* %l15
  %t86 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t1170 = phi { i8**, i64 }* [ %t70, %entry ], [ %t1158, %loop.latch4 ]
  %t1171 = phi double [ %t86, %entry ], [ %t1159, %loop.latch4 ]
  %t1172 = phi { %NativeFunction*, i64 }* [ %t77, %entry ], [ %t1160, %loop.latch4 ]
  %t1173 = phi %NativeFunction* [ %t78, %entry ], [ %t1161, %loop.latch4 ]
  %t1174 = phi %NativeSourceSpan* [ %t79, %entry ], [ %t1162, %loop.latch4 ]
  %t1175 = phi %NativeSourceSpan* [ %t80, %entry ], [ %t1163, %loop.latch4 ]
  %t1176 = phi double [ %t82, %entry ], [ %t1164, %loop.latch4 ]
  %t1177 = phi double [ %t83, %entry ], [ %t1165, %loop.latch4 ]
  %t1178 = phi i1 [ %t84, %entry ], [ %t1166, %loop.latch4 ]
  %t1179 = phi { %NativeStructLayoutField*, i64 }* [ %t81, %entry ], [ %t1167, %loop.latch4 ]
  %t1180 = phi i1 [ %t85, %entry ], [ %t1168, %loop.latch4 ]
  %t1181 = phi { %NativeStructField*, i64 }* [ %t76, %entry ], [ %t1169, %loop.latch4 ]
  store { i8**, i64 }* %t1170, { i8**, i64 }** %l0
  store double %t1171, double* %l16
  store { %NativeFunction*, i64 }* %t1172, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1173, %NativeFunction** %l8
  store %NativeSourceSpan* %t1174, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1175, %NativeSourceSpan** %l10
  store double %t1176, double* %l12
  store double %t1177, double* %l13
  store i1 %t1178, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1179, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1180, i1* %l15
  store { %NativeStructField*, i64 }* %t1181, { %NativeStructField*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t87 = load double, double* %l16
  %t88 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t89 = extractvalue { i8**, i64 } %t88, 1
  %t90 = sitofp i64 %t89 to double
  %t91 = fcmp oge double %t87, %t90
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l1
  %t94 = load i8*, i8** %l2
  %t95 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t96 = load i8*, i8** %l4
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t98 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t99 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t100 = load %NativeFunction*, %NativeFunction** %l8
  %t101 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t102 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t103 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t104 = load double, double* %l12
  %t105 = load double, double* %l13
  %t106 = load i1, i1* %l14
  %t107 = load i1, i1* %l15
  %t108 = load double, double* %l16
  br i1 %t91, label %then6, label %merge7
then6:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s110 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.110, i32 0, i32 0
  %t111 = load i8*, i8** %l4
  %t112 = add i8* %s110, %t111
  %t113 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t109, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l0
  %t114 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t114, %NativeStructLayout** %l17
  %t115 = load i1, i1* %l14
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load i8*, i8** %l2
  %t119 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t120 = load i8*, i8** %l4
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t122 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t123 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t124 = load %NativeFunction*, %NativeFunction** %l8
  %t125 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t126 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t127 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t128 = load double, double* %l12
  %t129 = load double, double* %l13
  %t130 = load i1, i1* %l14
  %t131 = load i1, i1* %l15
  %t132 = load double, double* %l16
  %t133 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br i1 %t115, label %then8, label %merge9
then8:
  %t134 = load double, double* %l12
  %t135 = insertvalue %NativeStructLayout undef, double %t134, 0
  %t136 = load double, double* %l13
  %t137 = insertvalue %NativeStructLayout %t135, double %t136, 1
  %t138 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t139 = bitcast { %NativeStructLayoutField*, i64 }* %t138 to { %NativeStructLayoutField**, i64 }*
  %t140 = insertvalue %NativeStructLayout %t137, { %NativeStructLayoutField**, i64 }* %t139, 2
  %t141 = alloca %NativeStructLayout
  store %NativeStructLayout %t140, %NativeStructLayout* %t141
  store %NativeStructLayout* %t141, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t142 = phi %NativeStructLayout* [ %t141, %then8 ], [ %t133, %then6 ]
  store %NativeStructLayout* %t142, %NativeStructLayout** %l17
  %t143 = load i8*, i8** %l4
  %t144 = insertvalue %NativeStruct undef, i8* %t143, 0
  %t145 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t146 = bitcast { %NativeStructField*, i64 }* %t145 to { %NativeStructField**, i64 }*
  %t147 = insertvalue %NativeStruct %t144, { %NativeStructField**, i64 }* %t146, 1
  %t148 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t149 = bitcast { %NativeFunction*, i64 }* %t148 to { %NativeFunction**, i64 }*
  %t150 = insertvalue %NativeStruct %t147, { %NativeFunction**, i64 }* %t149, 2
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t152 = insertvalue %NativeStruct %t150, { i8**, i64 }* %t151, 3
  %t153 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t154 = insertvalue %NativeStruct %t152, %NativeStructLayout* %t153, 4
  %t155 = alloca %NativeStruct
  store %NativeStruct %t154, %NativeStruct* %t155
  %t156 = insertvalue %StructParseResult undef, %NativeStruct* %t155, 0
  %t157 = load double, double* %l16
  %t158 = insertvalue %StructParseResult %t156, double %t157, 1
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = insertvalue %StructParseResult %t158, { i8**, i64 }* %t159, 2
  ret %StructParseResult %t160
merge7:
  %t161 = load double, double* %l16
  %t162 = fptosi double %t161 to i64
  %t163 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t164 = extractvalue { i8**, i64 } %t163, 0
  %t165 = extractvalue { i8**, i64 } %t163, 1
  %t166 = icmp uge i64 %t162, %t165
  ; bounds check: %t166 (if true, out of bounds)
  %t167 = getelementptr i8*, i8** %t164, i64 %t162
  %t168 = load i8*, i8** %t167
  %t169 = call i8* @trim_text(i8* %t168)
  store i8* %t169, i8** %l18
  %t171 = load i8*, i8** %l18
  %t172 = call i64 @sailfin_runtime_string_length(i8* %t171)
  %t173 = icmp eq i64 %t172, 0
  br label %logical_or_entry_170

logical_or_entry_170:
  br i1 %t173, label %logical_or_merge_170, label %logical_or_right_170

logical_or_right_170:
  %t174 = load i8*, i8** %l18
  %t175 = alloca [2 x i8], align 1
  %t176 = getelementptr [2 x i8], [2 x i8]* %t175, i32 0, i32 0
  store i8 59, i8* %t176
  %t177 = getelementptr [2 x i8], [2 x i8]* %t175, i32 0, i32 1
  store i8 0, i8* %t177
  %t178 = getelementptr [2 x i8], [2 x i8]* %t175, i32 0, i32 0
  %t179 = call i1 @starts_with(i8* %t174, i8* %t178)
  br label %logical_or_right_end_170

logical_or_right_end_170:
  br label %logical_or_merge_170

logical_or_merge_170:
  %t180 = phi i1 [ true, %logical_or_entry_170 ], [ %t179, %logical_or_right_end_170 ]
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = load i8*, i8** %l1
  %t183 = load i8*, i8** %l2
  %t184 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t185 = load i8*, i8** %l4
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t187 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t188 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t189 = load %NativeFunction*, %NativeFunction** %l8
  %t190 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t191 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t192 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t193 = load double, double* %l12
  %t194 = load double, double* %l13
  %t195 = load i1, i1* %l14
  %t196 = load i1, i1* %l15
  %t197 = load double, double* %l16
  %t198 = load i8*, i8** %l18
  br i1 %t180, label %then10, label %merge11
then10:
  %t199 = load double, double* %l16
  %t200 = sitofp i64 1 to double
  %t201 = fadd double %t199, %t200
  store double %t201, double* %l16
  br label %loop.latch4
merge11:
  %t202 = load i8*, i8** %l18
  %s203 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.203, i32 0, i32 0
  %t204 = icmp eq i8* %t202, %s203
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load i8*, i8** %l1
  %t207 = load i8*, i8** %l2
  %t208 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t209 = load i8*, i8** %l4
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t211 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t212 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t213 = load %NativeFunction*, %NativeFunction** %l8
  %t214 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t215 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t216 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t217 = load double, double* %l12
  %t218 = load double, double* %l13
  %t219 = load i1, i1* %l14
  %t220 = load i1, i1* %l15
  %t221 = load double, double* %l16
  %t222 = load i8*, i8** %l18
  br i1 %t204, label %then12, label %merge13
then12:
  %t223 = load %NativeFunction*, %NativeFunction** %l8
  %t224 = bitcast i8* null to %NativeFunction*
  %t225 = icmp ne %NativeFunction* %t223, %t224
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t227 = load i8*, i8** %l1
  %t228 = load i8*, i8** %l2
  %t229 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t230 = load i8*, i8** %l4
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t232 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t233 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t234 = load %NativeFunction*, %NativeFunction** %l8
  %t235 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t236 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t237 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t238 = load double, double* %l12
  %t239 = load double, double* %l13
  %t240 = load i1, i1* %l14
  %t241 = load i1, i1* %l15
  %t242 = load double, double* %l16
  %t243 = load i8*, i8** %l18
  br i1 %t225, label %then14, label %merge15
then14:
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s245 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.245, i32 0, i32 0
  %t246 = load i8*, i8** %l4
  %t247 = add i8* %s245, %t246
  %t248 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t244, i8* %t247)
  store { i8**, i64 }* %t248, { i8**, i64 }** %l0
  %t249 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t250 = load %NativeFunction*, %NativeFunction** %l8
  %t251 = load %NativeFunction, %NativeFunction* %t250
  %t252 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t249, %NativeFunction %t251)
  store { %NativeFunction*, i64 }* %t252, { %NativeFunction*, i64 }** %l7
  %t253 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t253, %NativeFunction** %l8
  %t254 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t254, %NativeSourceSpan** %l9
  %t255 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t255, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t256 = phi { i8**, i64 }* [ %t248, %then14 ], [ %t226, %then12 ]
  %t257 = phi { %NativeFunction*, i64 }* [ %t252, %then14 ], [ %t233, %then12 ]
  %t258 = phi %NativeFunction* [ %t253, %then14 ], [ %t234, %then12 ]
  %t259 = phi %NativeSourceSpan* [ %t254, %then14 ], [ %t235, %then12 ]
  %t260 = phi %NativeSourceSpan* [ %t255, %then14 ], [ %t236, %then12 ]
  store { i8**, i64 }* %t256, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t257, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t258, %NativeFunction** %l8
  store %NativeSourceSpan* %t259, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t260, %NativeSourceSpan** %l10
  %t261 = load double, double* %l16
  %t262 = sitofp i64 1 to double
  %t263 = fadd double %t261, %t262
  store double %t263, double* %l16
  br label %afterloop5
merge13:
  %t264 = load %NativeFunction*, %NativeFunction** %l8
  %t265 = bitcast i8* null to %NativeFunction*
  %t266 = icmp ne %NativeFunction* %t264, %t265
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load i8*, i8** %l1
  %t269 = load i8*, i8** %l2
  %t270 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t271 = load i8*, i8** %l4
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t273 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t274 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t275 = load %NativeFunction*, %NativeFunction** %l8
  %t276 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t277 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t278 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t279 = load double, double* %l12
  %t280 = load double, double* %l13
  %t281 = load i1, i1* %l14
  %t282 = load i1, i1* %l15
  %t283 = load double, double* %l16
  %t284 = load i8*, i8** %l18
  br i1 %t266, label %then16, label %merge17
then16:
  %t285 = load i8*, i8** %l18
  %s286 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.286, i32 0, i32 0
  %t287 = icmp eq i8* %t285, %s286
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t289 = load i8*, i8** %l1
  %t290 = load i8*, i8** %l2
  %t291 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t292 = load i8*, i8** %l4
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t294 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t295 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t296 = load %NativeFunction*, %NativeFunction** %l8
  %t297 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t298 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t299 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t300 = load double, double* %l12
  %t301 = load double, double* %l13
  %t302 = load i1, i1* %l14
  %t303 = load i1, i1* %l15
  %t304 = load double, double* %l16
  %t305 = load i8*, i8** %l18
  br i1 %t287, label %then18, label %merge19
then18:
  %t306 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t307 = load %NativeFunction*, %NativeFunction** %l8
  %t308 = load %NativeFunction, %NativeFunction* %t307
  %t309 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t306, %NativeFunction %t308)
  store { %NativeFunction*, i64 }* %t309, { %NativeFunction*, i64 }** %l7
  %t310 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t310, %NativeFunction** %l8
  %t311 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t311, %NativeSourceSpan** %l9
  %t312 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t312, %NativeSourceSpan** %l10
  %t313 = load double, double* %l16
  %t314 = sitofp i64 1 to double
  %t315 = fadd double %t313, %t314
  store double %t315, double* %l16
  br label %loop.latch4
merge19:
  %t316 = load i8*, i8** %l18
  %s317 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.317, i32 0, i32 0
  %t318 = call i1 @starts_with(i8* %t316, i8* %s317)
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t320 = load i8*, i8** %l1
  %t321 = load i8*, i8** %l2
  %t322 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t323 = load i8*, i8** %l4
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t325 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t326 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t327 = load %NativeFunction*, %NativeFunction** %l8
  %t328 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t329 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t330 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t331 = load double, double* %l12
  %t332 = load double, double* %l13
  %t333 = load i1, i1* %l14
  %t334 = load i1, i1* %l15
  %t335 = load double, double* %l16
  %t336 = load i8*, i8** %l18
  br i1 %t318, label %then20, label %merge21
then20:
  %t337 = load %NativeFunction*, %NativeFunction** %l8
  %t338 = load i8*, i8** %l18
  %s339 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.339, i32 0, i32 0
  %t340 = call i8* @strip_prefix(i8* %t338, i8* %s339)
  %t341 = load %NativeFunction, %NativeFunction* %t337
  %t342 = call %NativeFunction @apply_meta(%NativeFunction %t341, i8* %t340)
  %t343 = alloca %NativeFunction
  store %NativeFunction %t342, %NativeFunction* %t343
  store %NativeFunction* %t343, %NativeFunction** %l8
  %t344 = load double, double* %l16
  %t345 = sitofp i64 1 to double
  %t346 = fadd double %t344, %t345
  store double %t346, double* %l16
  br label %loop.latch4
merge21:
  %t347 = load i8*, i8** %l18
  %s348 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.348, i32 0, i32 0
  %t349 = call i1 @starts_with(i8* %t347, i8* %s348)
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t351 = load i8*, i8** %l1
  %t352 = load i8*, i8** %l2
  %t353 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t354 = load i8*, i8** %l4
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t356 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t357 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t358 = load %NativeFunction*, %NativeFunction** %l8
  %t359 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t360 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t361 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t362 = load double, double* %l12
  %t363 = load double, double* %l13
  %t364 = load i1, i1* %l14
  %t365 = load i1, i1* %l15
  %t366 = load double, double* %l16
  %t367 = load i8*, i8** %l18
  br i1 %t349, label %then22, label %merge23
then22:
  %t368 = load i8*, i8** %l18
  %s369 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.369, i32 0, i32 0
  %t370 = call i8* @strip_prefix(i8* %t368, i8* %s369)
  %t371 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t372 = call %NativeParameter* @parse_parameter_entry(i8* %t370, %NativeSourceSpan* %t371)
  store %NativeParameter* %t372, %NativeParameter** %l19
  %t373 = load %NativeParameter*, %NativeParameter** %l19
  %t374 = bitcast i8* null to %NativeParameter*
  %t375 = icmp eq %NativeParameter* %t373, %t374
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t377 = load i8*, i8** %l1
  %t378 = load i8*, i8** %l2
  %t379 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t380 = load i8*, i8** %l4
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t382 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t383 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t384 = load %NativeFunction*, %NativeFunction** %l8
  %t385 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t386 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t387 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t388 = load double, double* %l12
  %t389 = load double, double* %l13
  %t390 = load i1, i1* %l14
  %t391 = load i1, i1* %l15
  %t392 = load double, double* %l16
  %t393 = load i8*, i8** %l18
  %t394 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t375, label %then24, label %else25
then24:
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s396 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.396, i32 0, i32 0
  %t397 = load i8*, i8** %l18
  %t398 = add i8* %s396, %t397
  %t399 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t395, i8* %t398)
  store { i8**, i64 }* %t399, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t400 = load %NativeFunction*, %NativeFunction** %l8
  %t401 = load %NativeParameter*, %NativeParameter** %l19
  %t402 = load %NativeFunction, %NativeFunction* %t400
  %t403 = load %NativeParameter, %NativeParameter* %t401
  %t404 = call %NativeFunction @append_parameter(%NativeFunction %t402, %NativeParameter %t403)
  %t405 = alloca %NativeFunction
  store %NativeFunction %t404, %NativeFunction* %t405
  store %NativeFunction* %t405, %NativeFunction** %l8
  br label %merge26
merge26:
  %t406 = phi { i8**, i64 }* [ %t399, %then24 ], [ %t376, %else25 ]
  %t407 = phi %NativeFunction* [ %t384, %then24 ], [ %t405, %else25 ]
  store { i8**, i64 }* %t406, { i8**, i64 }** %l0
  store %NativeFunction* %t407, %NativeFunction** %l8
  %t408 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t408, %NativeSourceSpan** %l9
  %t409 = load double, double* %l16
  %t410 = sitofp i64 1 to double
  %t411 = fadd double %t409, %t410
  store double %t411, double* %l16
  br label %loop.latch4
merge23:
  %t412 = load i8*, i8** %l18
  %s413 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.413, i32 0, i32 0
  %t414 = call i1 @starts_with(i8* %t412, i8* %s413)
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t416 = load i8*, i8** %l1
  %t417 = load i8*, i8** %l2
  %t418 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t419 = load i8*, i8** %l4
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t421 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t422 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t423 = load %NativeFunction*, %NativeFunction** %l8
  %t424 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t425 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t426 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t427 = load double, double* %l12
  %t428 = load double, double* %l13
  %t429 = load i1, i1* %l14
  %t430 = load i1, i1* %l15
  %t431 = load double, double* %l16
  %t432 = load i8*, i8** %l18
  br i1 %t414, label %then27, label %merge28
then27:
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s434 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.434, i32 0, i32 0
  %t435 = load i8*, i8** %l4
  %t436 = add i8* %s434, %t435
  %t437 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t433, i8* %t436)
  store { i8**, i64 }* %t437, { i8**, i64 }** %l0
  %t438 = load double, double* %l16
  %t439 = sitofp i64 1 to double
  %t440 = fadd double %t438, %t439
  store double %t440, double* %l16
  br label %loop.latch4
merge28:
  %t441 = load i8*, i8** %l18
  %s442 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.442, i32 0, i32 0
  %t443 = call i1 @starts_with(i8* %t441, i8* %s442)
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t445 = load i8*, i8** %l1
  %t446 = load i8*, i8** %l2
  %t447 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t448 = load i8*, i8** %l4
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t450 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t451 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t452 = load %NativeFunction*, %NativeFunction** %l8
  %t453 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t454 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t455 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t456 = load double, double* %l12
  %t457 = load double, double* %l13
  %t458 = load i1, i1* %l14
  %t459 = load i1, i1* %l15
  %t460 = load double, double* %l16
  %t461 = load i8*, i8** %l18
  br i1 %t443, label %then29, label %merge30
then29:
  %t462 = load i8*, i8** %l18
  %s463 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.463, i32 0, i32 0
  %t464 = call i8* @strip_prefix(i8* %t462, i8* %s463)
  %t465 = call %NativeSourceSpan* @parse_source_span(i8* %t464)
  store %NativeSourceSpan* %t465, %NativeSourceSpan** %l20
  %t466 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t467 = bitcast i8* null to %NativeSourceSpan*
  %t468 = icmp eq %NativeSourceSpan* %t466, %t467
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t470 = load i8*, i8** %l1
  %t471 = load i8*, i8** %l2
  %t472 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t473 = load i8*, i8** %l4
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t475 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t476 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t477 = load %NativeFunction*, %NativeFunction** %l8
  %t478 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t479 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t480 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t481 = load double, double* %l12
  %t482 = load double, double* %l13
  %t483 = load i1, i1* %l14
  %t484 = load i1, i1* %l15
  %t485 = load double, double* %l16
  %t486 = load i8*, i8** %l18
  %t487 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t468, label %then31, label %else32
then31:
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s489 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.489, i32 0, i32 0
  %t490 = load i8*, i8** %l18
  %t491 = add i8* %s489, %t490
  %t492 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t488, i8* %t491)
  store { i8**, i64 }* %t492, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t493 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t493, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t494 = phi { i8**, i64 }* [ %t492, %then31 ], [ %t469, %else32 ]
  %t495 = phi %NativeSourceSpan* [ %t478, %then31 ], [ %t493, %else32 ]
  store { i8**, i64 }* %t494, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t495, %NativeSourceSpan** %l9
  %t496 = load double, double* %l16
  %t497 = sitofp i64 1 to double
  %t498 = fadd double %t496, %t497
  store double %t498, double* %l16
  br label %loop.latch4
merge30:
  %t499 = load i8*, i8** %l18
  %s500 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.500, i32 0, i32 0
  %t501 = call i1 @starts_with(i8* %t499, i8* %s500)
  %t502 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t503 = load i8*, i8** %l1
  %t504 = load i8*, i8** %l2
  %t505 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t506 = load i8*, i8** %l4
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t508 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t509 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t510 = load %NativeFunction*, %NativeFunction** %l8
  %t511 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t512 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t513 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t514 = load double, double* %l12
  %t515 = load double, double* %l13
  %t516 = load i1, i1* %l14
  %t517 = load i1, i1* %l15
  %t518 = load double, double* %l16
  %t519 = load i8*, i8** %l18
  br i1 %t501, label %then34, label %merge35
then34:
  %t520 = load i8*, i8** %l18
  %s521 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.521, i32 0, i32 0
  %t522 = call i8* @strip_prefix(i8* %t520, i8* %s521)
  %t523 = call %NativeSourceSpan* @parse_source_span(i8* %t522)
  store %NativeSourceSpan* %t523, %NativeSourceSpan** %l21
  %t524 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t525 = bitcast i8* null to %NativeSourceSpan*
  %t526 = icmp eq %NativeSourceSpan* %t524, %t525
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t528 = load i8*, i8** %l1
  %t529 = load i8*, i8** %l2
  %t530 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t531 = load i8*, i8** %l4
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t533 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t534 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t535 = load %NativeFunction*, %NativeFunction** %l8
  %t536 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t537 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t538 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t539 = load double, double* %l12
  %t540 = load double, double* %l13
  %t541 = load i1, i1* %l14
  %t542 = load i1, i1* %l15
  %t543 = load double, double* %l16
  %t544 = load i8*, i8** %l18
  %t545 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t526, label %then36, label %else37
then36:
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s547 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.547, i32 0, i32 0
  %t548 = load i8*, i8** %l18
  %t549 = add i8* %s547, %t548
  %t550 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t546, i8* %t549)
  store { i8**, i64 }* %t550, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t551 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t551, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t552 = phi { i8**, i64 }* [ %t550, %then36 ], [ %t527, %else37 ]
  %t553 = phi %NativeSourceSpan* [ %t537, %then36 ], [ %t551, %else37 ]
  store { i8**, i64 }* %t552, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t553, %NativeSourceSpan** %l10
  %t554 = load double, double* %l16
  %t555 = sitofp i64 1 to double
  %t556 = fadd double %t554, %t555
  store double %t556, double* %l16
  br label %loop.latch4
merge35:
  %t557 = load i8*, i8** %l18
  %t558 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t559 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t560 = call %InstructionParseResult @parse_instruction(i8* %t557, %NativeSourceSpan* %t558, %NativeSourceSpan* %t559)
  store %InstructionParseResult %t560, %InstructionParseResult* %l22
  %t561 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t562 = extractvalue %InstructionParseResult %t561, 1
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t564 = load i8*, i8** %l1
  %t565 = load i8*, i8** %l2
  %t566 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t567 = load i8*, i8** %l4
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t569 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t570 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t571 = load %NativeFunction*, %NativeFunction** %l8
  %t572 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t573 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t574 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t575 = load double, double* %l12
  %t576 = load double, double* %l13
  %t577 = load i1, i1* %l14
  %t578 = load i1, i1* %l15
  %t579 = load double, double* %l16
  %t580 = load i8*, i8** %l18
  %t581 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t562, label %then39, label %else40
then39:
  %t582 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t582, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t583 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t584 = bitcast i8* null to %NativeSourceSpan*
  %t585 = icmp ne %NativeSourceSpan* %t583, %t584
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t587 = load i8*, i8** %l1
  %t588 = load i8*, i8** %l2
  %t589 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t590 = load i8*, i8** %l4
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t592 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t593 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t594 = load %NativeFunction*, %NativeFunction** %l8
  %t595 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t596 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t597 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t598 = load double, double* %l12
  %t599 = load double, double* %l13
  %t600 = load i1, i1* %l14
  %t601 = load i1, i1* %l15
  %t602 = load double, double* %l16
  %t603 = load i8*, i8** %l18
  %t604 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t585, label %then42, label %merge43
then42:
  %t605 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s606 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.606, i32 0, i32 0
  %t607 = load i8*, i8** %l18
  %t608 = add i8* %s606, %t607
  %t609 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t605, i8* %t608)
  store { i8**, i64 }* %t609, { i8**, i64 }** %l0
  %t610 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t610, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t611 = phi { i8**, i64 }* [ %t609, %then42 ], [ %t586, %else40 ]
  %t612 = phi %NativeSourceSpan* [ %t610, %then42 ], [ %t595, %else40 ]
  store { i8**, i64 }* %t611, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t612, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t613 = phi %NativeSourceSpan* [ %t582, %then39 ], [ %t610, %else40 ]
  %t614 = phi { i8**, i64 }* [ %t563, %then39 ], [ %t609, %else40 ]
  store %NativeSourceSpan* %t613, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t614, { i8**, i64 }** %l0
  %t615 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t616 = extractvalue %InstructionParseResult %t615, 2
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t618 = load i8*, i8** %l1
  %t619 = load i8*, i8** %l2
  %t620 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t621 = load i8*, i8** %l4
  %t622 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t623 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t624 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t625 = load %NativeFunction*, %NativeFunction** %l8
  %t626 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t627 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t628 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t629 = load double, double* %l12
  %t630 = load double, double* %l13
  %t631 = load i1, i1* %l14
  %t632 = load i1, i1* %l15
  %t633 = load double, double* %l16
  %t634 = load i8*, i8** %l18
  %t635 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t616, label %then44, label %else45
then44:
  %t636 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t636, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t637 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t638 = bitcast i8* null to %NativeSourceSpan*
  %t639 = icmp ne %NativeSourceSpan* %t637, %t638
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t641 = load i8*, i8** %l1
  %t642 = load i8*, i8** %l2
  %t643 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t644 = load i8*, i8** %l4
  %t645 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t646 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t647 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t648 = load %NativeFunction*, %NativeFunction** %l8
  %t649 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t650 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t651 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t652 = load double, double* %l12
  %t653 = load double, double* %l13
  %t654 = load i1, i1* %l14
  %t655 = load i1, i1* %l15
  %t656 = load double, double* %l16
  %t657 = load i8*, i8** %l18
  %t658 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t639, label %then47, label %merge48
then47:
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s660 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.660, i32 0, i32 0
  %t661 = load i8*, i8** %l18
  %t662 = add i8* %s660, %t661
  %t663 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t659, i8* %t662)
  store { i8**, i64 }* %t663, { i8**, i64 }** %l0
  %t664 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t664, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t665 = phi { i8**, i64 }* [ %t663, %then47 ], [ %t640, %else45 ]
  %t666 = phi %NativeSourceSpan* [ %t664, %then47 ], [ %t650, %else45 ]
  store { i8**, i64 }* %t665, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t666, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t667 = phi %NativeSourceSpan* [ %t636, %then44 ], [ %t664, %else45 ]
  %t668 = phi { i8**, i64 }* [ %t617, %then44 ], [ %t663, %else45 ]
  store %NativeSourceSpan* %t667, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t668, { i8**, i64 }** %l0
  %t669 = sitofp i64 0 to double
  store double %t669, double* %l23
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t671 = load i8*, i8** %l1
  %t672 = load i8*, i8** %l2
  %t673 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t674 = load i8*, i8** %l4
  %t675 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t676 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t677 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t678 = load %NativeFunction*, %NativeFunction** %l8
  %t679 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t680 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t681 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t682 = load double, double* %l12
  %t683 = load double, double* %l13
  %t684 = load i1, i1* %l14
  %t685 = load i1, i1* %l15
  %t686 = load double, double* %l16
  %t687 = load i8*, i8** %l18
  %t688 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t689 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t737 = phi %NativeFunction* [ %t678, %then16 ], [ %t735, %loop.latch51 ]
  %t738 = phi double [ %t689, %then16 ], [ %t736, %loop.latch51 ]
  store %NativeFunction* %t737, %NativeFunction** %l8
  store double %t738, double* %l23
  br label %loop.body50
loop.body50:
  %t690 = load double, double* %l23
  %t691 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t692 = extractvalue %InstructionParseResult %t691, 0
  %t693 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t692
  %t694 = extractvalue { %NativeInstruction**, i64 } %t693, 1
  %t695 = sitofp i64 %t694 to double
  %t696 = fcmp oge double %t690, %t695
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t698 = load i8*, i8** %l1
  %t699 = load i8*, i8** %l2
  %t700 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t701 = load i8*, i8** %l4
  %t702 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t703 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t704 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t705 = load %NativeFunction*, %NativeFunction** %l8
  %t706 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t707 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t708 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t709 = load double, double* %l12
  %t710 = load double, double* %l13
  %t711 = load i1, i1* %l14
  %t712 = load i1, i1* %l15
  %t713 = load double, double* %l16
  %t714 = load i8*, i8** %l18
  %t715 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t716 = load double, double* %l23
  br i1 %t696, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t717 = load %NativeFunction*, %NativeFunction** %l8
  %t718 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t719 = extractvalue %InstructionParseResult %t718, 0
  %t720 = load double, double* %l23
  %t721 = fptosi double %t720 to i64
  %t722 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t719
  %t723 = extractvalue { %NativeInstruction**, i64 } %t722, 0
  %t724 = extractvalue { %NativeInstruction**, i64 } %t722, 1
  %t725 = icmp uge i64 %t721, %t724
  ; bounds check: %t725 (if true, out of bounds)
  %t726 = getelementptr %NativeInstruction*, %NativeInstruction** %t723, i64 %t721
  %t727 = load %NativeInstruction*, %NativeInstruction** %t726
  %t728 = load %NativeFunction, %NativeFunction* %t717
  %t729 = load %NativeInstruction, %NativeInstruction* %t727
  %t730 = call %NativeFunction @append_instruction(%NativeFunction %t728, %NativeInstruction %t729)
  %t731 = alloca %NativeFunction
  store %NativeFunction %t730, %NativeFunction* %t731
  store %NativeFunction* %t731, %NativeFunction** %l8
  %t732 = load double, double* %l23
  %t733 = sitofp i64 1 to double
  %t734 = fadd double %t732, %t733
  store double %t734, double* %l23
  br label %loop.latch51
loop.latch51:
  %t735 = load %NativeFunction*, %NativeFunction** %l8
  %t736 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t739 = load double, double* %l16
  %t740 = sitofp i64 1 to double
  %t741 = fadd double %t739, %t740
  store double %t741, double* %l16
  br label %loop.latch4
merge17:
  %t742 = load i8*, i8** %l18
  %s743 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.743, i32 0, i32 0
  %t744 = call i1 @starts_with(i8* %t742, i8* %s743)
  %t745 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t746 = load i8*, i8** %l1
  %t747 = load i8*, i8** %l2
  %t748 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t749 = load i8*, i8** %l4
  %t750 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t751 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t752 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t753 = load %NativeFunction*, %NativeFunction** %l8
  %t754 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t755 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t756 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t757 = load double, double* %l12
  %t758 = load double, double* %l13
  %t759 = load i1, i1* %l14
  %t760 = load i1, i1* %l15
  %t761 = load double, double* %l16
  %t762 = load i8*, i8** %l18
  br i1 %t744, label %then55, label %merge56
then55:
  %t763 = load i8*, i8** %l18
  %s764 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.764, i32 0, i32 0
  %t765 = call i8* @strip_prefix(i8* %t763, i8* %s764)
  store i8* %t765, i8** %l24
  %t766 = load i8*, i8** %l24
  %s767 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.767, i32 0, i32 0
  %t768 = call i1 @starts_with(i8* %t766, i8* %s767)
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t770 = load i8*, i8** %l1
  %t771 = load i8*, i8** %l2
  %t772 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t773 = load i8*, i8** %l4
  %t774 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t775 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t776 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t777 = load %NativeFunction*, %NativeFunction** %l8
  %t778 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t779 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t780 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t781 = load double, double* %l12
  %t782 = load double, double* %l13
  %t783 = load i1, i1* %l14
  %t784 = load i1, i1* %l15
  %t785 = load double, double* %l16
  %t786 = load i8*, i8** %l18
  %t787 = load i8*, i8** %l24
  br i1 %t768, label %then57, label %merge58
then57:
  %t788 = load i8*, i8** %l24
  %s789 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.789, i32 0, i32 0
  %t790 = call i8* @strip_prefix(i8* %t788, i8* %s789)
  %t791 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t790)
  store %StructLayoutHeaderParse %t791, %StructLayoutHeaderParse* %l25
  %t792 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t793 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t794 = extractvalue %StructLayoutHeaderParse %t793, 4
  %t795 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t792, { i8**, i64 }* %t794)
  store { i8**, i64 }* %t795, { i8**, i64 }** %l0
  %t796 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t797 = extractvalue %StructLayoutHeaderParse %t796, 0
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t799 = load i8*, i8** %l1
  %t800 = load i8*, i8** %l2
  %t801 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t802 = load i8*, i8** %l4
  %t803 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t804 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t805 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t806 = load %NativeFunction*, %NativeFunction** %l8
  %t807 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t808 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t809 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t810 = load double, double* %l12
  %t811 = load double, double* %l13
  %t812 = load i1, i1* %l14
  %t813 = load i1, i1* %l15
  %t814 = load double, double* %l16
  %t815 = load i8*, i8** %l18
  %t816 = load i8*, i8** %l24
  %t817 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t797, label %then59, label %merge60
then59:
  %t818 = load i1, i1* %l14
  %t819 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t820 = load i8*, i8** %l1
  %t821 = load i8*, i8** %l2
  %t822 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t823 = load i8*, i8** %l4
  %t824 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t825 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t826 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t827 = load %NativeFunction*, %NativeFunction** %l8
  %t828 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t829 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t830 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t831 = load double, double* %l12
  %t832 = load double, double* %l13
  %t833 = load i1, i1* %l14
  %t834 = load i1, i1* %l15
  %t835 = load double, double* %l16
  %t836 = load i8*, i8** %l18
  %t837 = load i8*, i8** %l24
  %t838 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t818, label %then61, label %else62
then61:
  %t839 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s840 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.840, i32 0, i32 0
  %t841 = load i8*, i8** %l4
  %t842 = add i8* %s840, %t841
  %t843 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t839, i8* %t842)
  store { i8**, i64 }* %t843, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t844 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t845 = extractvalue %StructLayoutHeaderParse %t844, 2
  store double %t845, double* %l12
  %t846 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t847 = extractvalue %StructLayoutHeaderParse %t846, 3
  store double %t847, double* %l13
  store i1 1, i1* %l14
  br label %merge63
merge63:
  %t848 = phi { i8**, i64 }* [ %t843, %then61 ], [ %t819, %else62 ]
  %t849 = phi double [ %t831, %then61 ], [ %t845, %else62 ]
  %t850 = phi double [ %t832, %then61 ], [ %t847, %else62 ]
  %t851 = phi i1 [ %t833, %then61 ], [ 1, %else62 ]
  store { i8**, i64 }* %t848, { i8**, i64 }** %l0
  store double %t849, double* %l12
  store double %t850, double* %l13
  store i1 %t851, i1* %l14
  br label %merge60
merge60:
  %t852 = phi { i8**, i64 }* [ %t843, %then59 ], [ %t798, %then57 ]
  %t853 = phi double [ %t845, %then59 ], [ %t810, %then57 ]
  %t854 = phi double [ %t847, %then59 ], [ %t811, %then57 ]
  %t855 = phi i1 [ 1, %then59 ], [ %t812, %then57 ]
  store { i8**, i64 }* %t852, { i8**, i64 }** %l0
  store double %t853, double* %l12
  store double %t854, double* %l13
  store i1 %t855, i1* %l14
  %t856 = load double, double* %l16
  %t857 = sitofp i64 1 to double
  %t858 = fadd double %t856, %t857
  store double %t858, double* %l16
  br label %loop.latch4
merge58:
  %t859 = load i8*, i8** %l24
  %s860 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.860, i32 0, i32 0
  %t861 = call i1 @starts_with(i8* %t859, i8* %s860)
  %t862 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t863 = load i8*, i8** %l1
  %t864 = load i8*, i8** %l2
  %t865 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t866 = load i8*, i8** %l4
  %t867 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t868 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t869 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t870 = load %NativeFunction*, %NativeFunction** %l8
  %t871 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t872 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t873 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t874 = load double, double* %l12
  %t875 = load double, double* %l13
  %t876 = load i1, i1* %l14
  %t877 = load i1, i1* %l15
  %t878 = load double, double* %l16
  %t879 = load i8*, i8** %l18
  %t880 = load i8*, i8** %l24
  br i1 %t861, label %then64, label %merge65
then64:
  %t881 = load i8*, i8** %l24
  %s882 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.882, i32 0, i32 0
  %t883 = call i8* @strip_prefix(i8* %t881, i8* %s882)
  %t884 = load i8*, i8** %l4
  %t885 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t883, i8* %t884)
  store %StructLayoutFieldParse %t885, %StructLayoutFieldParse* %l26
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t887 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t888 = extractvalue %StructLayoutFieldParse %t887, 2
  %t889 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t886, { i8**, i64 }* %t888)
  store { i8**, i64 }* %t889, { i8**, i64 }** %l0
  %t890 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t891 = extractvalue %StructLayoutFieldParse %t890, 0
  %t892 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t893 = load i8*, i8** %l1
  %t894 = load i8*, i8** %l2
  %t895 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t896 = load i8*, i8** %l4
  %t897 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t898 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t899 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t900 = load %NativeFunction*, %NativeFunction** %l8
  %t901 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t902 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t903 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t904 = load double, double* %l12
  %t905 = load double, double* %l13
  %t906 = load i1, i1* %l14
  %t907 = load i1, i1* %l15
  %t908 = load double, double* %l16
  %t909 = load i8*, i8** %l18
  %t910 = load i8*, i8** %l24
  %t911 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t891, label %then66, label %merge67
then66:
  %t912 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t913 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t914 = extractvalue %StructLayoutFieldParse %t913, 1
  %t915 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t912, %NativeStructLayoutField %t914)
  store { %NativeStructLayoutField*, i64 }* %t915, { %NativeStructLayoutField*, i64 }** %l11
  %t916 = load i1, i1* %l14
  %t917 = xor i1 %t916, 1
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t919 = load i8*, i8** %l1
  %t920 = load i8*, i8** %l2
  %t921 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t922 = load i8*, i8** %l4
  %t923 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t924 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t925 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t926 = load %NativeFunction*, %NativeFunction** %l8
  %t927 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t928 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t929 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t930 = load double, double* %l12
  %t931 = load double, double* %l13
  %t932 = load i1, i1* %l14
  %t933 = load i1, i1* %l15
  %t934 = load double, double* %l16
  %t935 = load i8*, i8** %l18
  %t936 = load i8*, i8** %l24
  %t937 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t917, label %then68, label %merge69
then68:
  %t938 = load i1, i1* %l15
  %t939 = xor i1 %t938, 1
  %t940 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t941 = load i8*, i8** %l1
  %t942 = load i8*, i8** %l2
  %t943 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t944 = load i8*, i8** %l4
  %t945 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t946 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t947 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t948 = load %NativeFunction*, %NativeFunction** %l8
  %t949 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t950 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t951 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t952 = load double, double* %l12
  %t953 = load double, double* %l13
  %t954 = load i1, i1* %l14
  %t955 = load i1, i1* %l15
  %t956 = load double, double* %l16
  %t957 = load i8*, i8** %l18
  %t958 = load i8*, i8** %l24
  %t959 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t939, label %then70, label %merge71
then70:
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s961 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.961, i32 0, i32 0
  %t962 = load i8*, i8** %l4
  %t963 = add i8* %s961, %t962
  %s964 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.964, i32 0, i32 0
  %t965 = add i8* %t963, %s964
  %t966 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t960, i8* %t965)
  store { i8**, i64 }* %t966, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  br label %merge71
merge71:
  %t967 = phi { i8**, i64 }* [ %t966, %then70 ], [ %t940, %then68 ]
  %t968 = phi i1 [ 1, %then70 ], [ %t955, %then68 ]
  store { i8**, i64 }* %t967, { i8**, i64 }** %l0
  store i1 %t968, i1* %l15
  br label %merge69
merge69:
  %t969 = phi { i8**, i64 }* [ %t966, %then68 ], [ %t918, %then66 ]
  %t970 = phi i1 [ 1, %then68 ], [ %t933, %then66 ]
  store { i8**, i64 }* %t969, { i8**, i64 }** %l0
  store i1 %t970, i1* %l15
  br label %merge67
merge67:
  %t971 = phi { %NativeStructLayoutField*, i64 }* [ %t915, %then66 ], [ %t903, %then64 ]
  %t972 = phi { i8**, i64 }* [ %t966, %then66 ], [ %t892, %then64 ]
  %t973 = phi i1 [ 1, %then66 ], [ %t907, %then64 ]
  store { %NativeStructLayoutField*, i64 }* %t971, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t972, { i8**, i64 }** %l0
  store i1 %t973, i1* %l15
  %t974 = load double, double* %l16
  %t975 = sitofp i64 1 to double
  %t976 = fadd double %t974, %t975
  store double %t976, double* %l16
  br label %loop.latch4
merge65:
  %t977 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s978 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.978, i32 0, i32 0
  %t979 = load i8*, i8** %l18
  %t980 = add i8* %s978, %t979
  %t981 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t977, i8* %t980)
  store { i8**, i64 }* %t981, { i8**, i64 }** %l0
  %t982 = load double, double* %l16
  %t983 = sitofp i64 1 to double
  %t984 = fadd double %t982, %t983
  store double %t984, double* %l16
  br label %loop.latch4
merge56:
  %t985 = load i8*, i8** %l18
  %s986 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.986, i32 0, i32 0
  %t987 = icmp eq i8* %t985, %s986
  %t988 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t989 = load i8*, i8** %l1
  %t990 = load i8*, i8** %l2
  %t991 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t992 = load i8*, i8** %l4
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t994 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t995 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t996 = load %NativeFunction*, %NativeFunction** %l8
  %t997 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t998 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t999 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1000 = load double, double* %l12
  %t1001 = load double, double* %l13
  %t1002 = load i1, i1* %l14
  %t1003 = load i1, i1* %l15
  %t1004 = load double, double* %l16
  %t1005 = load i8*, i8** %l18
  br i1 %t987, label %then72, label %merge73
then72:
  %t1006 = load double, double* %l16
  %t1007 = sitofp i64 1 to double
  %t1008 = fadd double %t1006, %t1007
  store double %t1008, double* %l16
  br label %loop.latch4
merge73:
  %t1009 = load i8*, i8** %l18
  %s1010 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1010, i32 0, i32 0
  %t1011 = call i1 @starts_with(i8* %t1009, i8* %s1010)
  %t1012 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1013 = load i8*, i8** %l1
  %t1014 = load i8*, i8** %l2
  %t1015 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1016 = load i8*, i8** %l4
  %t1017 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1018 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1019 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1020 = load %NativeFunction*, %NativeFunction** %l8
  %t1021 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1022 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1023 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1024 = load double, double* %l12
  %t1025 = load double, double* %l13
  %t1026 = load i1, i1* %l14
  %t1027 = load i1, i1* %l15
  %t1028 = load double, double* %l16
  %t1029 = load i8*, i8** %l18
  br i1 %t1011, label %then74, label %merge75
then74:
  %t1030 = load i8*, i8** %l18
  %s1031 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1031, i32 0, i32 0
  %t1032 = call i8* @strip_prefix(i8* %t1030, i8* %s1031)
  %t1033 = call %NativeStructField* @parse_struct_field_line(i8* %t1032)
  store %NativeStructField* %t1033, %NativeStructField** %l27
  %t1034 = load %NativeStructField*, %NativeStructField** %l27
  %t1035 = bitcast i8* null to %NativeStructField*
  %t1036 = icmp eq %NativeStructField* %t1034, %t1035
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1038 = load i8*, i8** %l1
  %t1039 = load i8*, i8** %l2
  %t1040 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1041 = load i8*, i8** %l4
  %t1042 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1043 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1044 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1045 = load %NativeFunction*, %NativeFunction** %l8
  %t1046 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1047 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1048 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1049 = load double, double* %l12
  %t1050 = load double, double* %l13
  %t1051 = load i1, i1* %l14
  %t1052 = load i1, i1* %l15
  %t1053 = load double, double* %l16
  %t1054 = load i8*, i8** %l18
  %t1055 = load %NativeStructField*, %NativeStructField** %l27
  br i1 %t1036, label %then76, label %else77
then76:
  %t1056 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1057 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.1057, i32 0, i32 0
  %t1058 = load i8*, i8** %l18
  %t1059 = add i8* %s1057, %t1058
  %t1060 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1056, i8* %t1059)
  store { i8**, i64 }* %t1060, { i8**, i64 }** %l0
  br label %merge78
else77:
  %t1061 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1062 = load %NativeStructField*, %NativeStructField** %l27
  %t1063 = load %NativeStructField, %NativeStructField* %t1062
  %t1064 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1061, %NativeStructField %t1063)
  store { %NativeStructField*, i64 }* %t1064, { %NativeStructField*, i64 }** %l6
  br label %merge78
merge78:
  %t1065 = phi { i8**, i64 }* [ %t1060, %then76 ], [ %t1037, %else77 ]
  %t1066 = phi { %NativeStructField*, i64 }* [ %t1043, %then76 ], [ %t1064, %else77 ]
  store { i8**, i64 }* %t1065, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1066, { %NativeStructField*, i64 }** %l6
  %t1067 = load double, double* %l16
  %t1068 = sitofp i64 1 to double
  %t1069 = fadd double %t1067, %t1068
  store double %t1069, double* %l16
  br label %loop.latch4
merge75:
  %t1070 = load i8*, i8** %l18
  %s1071 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1071, i32 0, i32 0
  %t1072 = call i1 @starts_with(i8* %t1070, i8* %s1071)
  %t1073 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1074 = load i8*, i8** %l1
  %t1075 = load i8*, i8** %l2
  %t1076 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1077 = load i8*, i8** %l4
  %t1078 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1079 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1080 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1081 = load %NativeFunction*, %NativeFunction** %l8
  %t1082 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1083 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1084 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1085 = load double, double* %l12
  %t1086 = load double, double* %l13
  %t1087 = load i1, i1* %l14
  %t1088 = load i1, i1* %l15
  %t1089 = load double, double* %l16
  %t1090 = load i8*, i8** %l18
  br i1 %t1072, label %then79, label %merge80
then79:
  %t1091 = load %NativeFunction*, %NativeFunction** %l8
  %t1092 = bitcast i8* null to %NativeFunction*
  %t1093 = icmp ne %NativeFunction* %t1091, %t1092
  %t1094 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1095 = load i8*, i8** %l1
  %t1096 = load i8*, i8** %l2
  %t1097 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1098 = load i8*, i8** %l4
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1100 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1101 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1102 = load %NativeFunction*, %NativeFunction** %l8
  %t1103 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1104 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1105 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1106 = load double, double* %l12
  %t1107 = load double, double* %l13
  %t1108 = load i1, i1* %l14
  %t1109 = load i1, i1* %l15
  %t1110 = load double, double* %l16
  %t1111 = load i8*, i8** %l18
  br i1 %t1093, label %then81, label %merge82
then81:
  %t1112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1113 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.1113, i32 0, i32 0
  %t1114 = load i8*, i8** %l4
  %t1115 = add i8* %s1113, %t1114
  %t1116 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1112, i8* %t1115)
  store { i8**, i64 }* %t1116, { i8**, i64 }** %l0
  br label %merge82
merge82:
  %t1117 = phi { i8**, i64 }* [ %t1116, %then81 ], [ %t1094, %then79 ]
  store { i8**, i64 }* %t1117, { i8**, i64 }** %l0
  %t1118 = load i8*, i8** %l18
  %s1119 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1119, i32 0, i32 0
  %t1120 = call i8* @strip_prefix(i8* %t1118, i8* %s1119)
  %t1121 = call i8* @parse_function_name(i8* %t1120)
  store i8* %t1121, i8** %l28
  %t1122 = load i8*, i8** %l28
  %t1123 = insertvalue %NativeFunction undef, i8* %t1122, 0
  %t1124 = alloca [0 x %NativeParameter*]
  %t1125 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* %t1124, i32 0, i32 0
  %t1126 = alloca { %NativeParameter**, i64 }
  %t1127 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1126, i32 0, i32 0
  store %NativeParameter** %t1125, %NativeParameter*** %t1127
  %t1128 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1126, i32 0, i32 1
  store i64 0, i64* %t1128
  %t1129 = insertvalue %NativeFunction %t1123, { %NativeParameter**, i64 }* %t1126, 1
  %s1130 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1130, i32 0, i32 0
  %t1131 = insertvalue %NativeFunction %t1129, i8* %s1130, 2
  %t1132 = alloca [0 x i8*]
  %t1133 = getelementptr [0 x i8*], [0 x i8*]* %t1132, i32 0, i32 0
  %t1134 = alloca { i8**, i64 }
  %t1135 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1134, i32 0, i32 0
  store i8** %t1133, i8*** %t1135
  %t1136 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1134, i32 0, i32 1
  store i64 0, i64* %t1136
  %t1137 = insertvalue %NativeFunction %t1131, { i8**, i64 }* %t1134, 3
  %t1138 = alloca [0 x %NativeInstruction*]
  %t1139 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* %t1138, i32 0, i32 0
  %t1140 = alloca { %NativeInstruction**, i64 }
  %t1141 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1140, i32 0, i32 0
  store %NativeInstruction** %t1139, %NativeInstruction*** %t1141
  %t1142 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1140, i32 0, i32 1
  store i64 0, i64* %t1142
  %t1143 = insertvalue %NativeFunction %t1137, { %NativeInstruction**, i64 }* %t1140, 4
  %t1144 = alloca %NativeFunction
  store %NativeFunction %t1143, %NativeFunction* %t1144
  store %NativeFunction* %t1144, %NativeFunction** %l8
  %t1145 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1145, %NativeSourceSpan** %l9
  %t1146 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1146, %NativeSourceSpan** %l10
  %t1147 = load double, double* %l16
  %t1148 = sitofp i64 1 to double
  %t1149 = fadd double %t1147, %t1148
  store double %t1149, double* %l16
  br label %loop.latch4
merge80:
  %t1150 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1151 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.1151, i32 0, i32 0
  %t1152 = load i8*, i8** %l18
  %t1153 = add i8* %s1151, %t1152
  %t1154 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1150, i8* %t1153)
  store { i8**, i64 }* %t1154, { i8**, i64 }** %l0
  %t1155 = load double, double* %l16
  %t1156 = sitofp i64 1 to double
  %t1157 = fadd double %t1155, %t1156
  store double %t1157, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1159 = load double, double* %l16
  %t1160 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1161 = load %NativeFunction*, %NativeFunction** %l8
  %t1162 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1163 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1164 = load double, double* %l12
  %t1165 = load double, double* %l13
  %t1166 = load i1, i1* %l14
  %t1167 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1168 = load i1, i1* %l15
  %t1169 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1182 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1182, %NativeStructLayout** %l29
  %t1183 = load i1, i1* %l14
  %t1184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1185 = load i8*, i8** %l1
  %t1186 = load i8*, i8** %l2
  %t1187 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1188 = load i8*, i8** %l4
  %t1189 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1190 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1191 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1192 = load %NativeFunction*, %NativeFunction** %l8
  %t1193 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1194 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1195 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1196 = load double, double* %l12
  %t1197 = load double, double* %l13
  %t1198 = load i1, i1* %l14
  %t1199 = load i1, i1* %l15
  %t1200 = load double, double* %l16
  %t1201 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br i1 %t1183, label %then83, label %merge84
then83:
  %t1202 = load double, double* %l12
  %t1203 = insertvalue %NativeStructLayout undef, double %t1202, 0
  %t1204 = load double, double* %l13
  %t1205 = insertvalue %NativeStructLayout %t1203, double %t1204, 1
  %t1206 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1207 = bitcast { %NativeStructLayoutField*, i64 }* %t1206 to { %NativeStructLayoutField**, i64 }*
  %t1208 = insertvalue %NativeStructLayout %t1205, { %NativeStructLayoutField**, i64 }* %t1207, 2
  %t1209 = alloca %NativeStructLayout
  store %NativeStructLayout %t1208, %NativeStructLayout* %t1209
  store %NativeStructLayout* %t1209, %NativeStructLayout** %l29
  br label %merge84
merge84:
  %t1210 = phi %NativeStructLayout* [ %t1209, %then83 ], [ %t1201, %entry ]
  store %NativeStructLayout* %t1210, %NativeStructLayout** %l29
  %t1211 = load i8*, i8** %l4
  %t1212 = insertvalue %NativeStruct undef, i8* %t1211, 0
  %t1213 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1214 = bitcast { %NativeStructField*, i64 }* %t1213 to { %NativeStructField**, i64 }*
  %t1215 = insertvalue %NativeStruct %t1212, { %NativeStructField**, i64 }* %t1214, 1
  %t1216 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1217 = bitcast { %NativeFunction*, i64 }* %t1216 to { %NativeFunction**, i64 }*
  %t1218 = insertvalue %NativeStruct %t1215, { %NativeFunction**, i64 }* %t1217, 2
  %t1219 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1220 = insertvalue %NativeStruct %t1218, { i8**, i64 }* %t1219, 3
  %t1221 = load %NativeStructLayout*, %NativeStructLayout** %l29
  %t1222 = insertvalue %NativeStruct %t1220, %NativeStructLayout* %t1221, 4
  %t1223 = alloca %NativeStruct
  store %NativeStruct %t1222, %NativeStruct* %t1223
  %t1224 = insertvalue %StructParseResult undef, %NativeStruct* %t1223, 0
  %t1225 = load double, double* %l16
  %t1226 = insertvalue %StructParseResult %t1224, double %t1225, 1
  %t1227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1228 = insertvalue %StructParseResult %t1226, { i8**, i64 }* %t1227, 2
  ret %StructParseResult %t1228
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
  %t38 = bitcast i8* null to %NativeInterface*
  %t39 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t38, 0
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %start_index, %t40
  %t42 = insertvalue %InterfaceParseResult %t39, double %t41, 1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = insertvalue %InterfaceParseResult %t42, { i8**, i64 }* %t43, 2
  ret %InterfaceParseResult %t44
merge1:
  %t45 = alloca [0 x %NativeInterfaceSignature]
  %t46 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* %t45, i32 0, i32 0
  %t47 = alloca { %NativeInterfaceSignature*, i64 }
  %t48 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t47, i32 0, i32 0
  store %NativeInterfaceSignature* %t46, %NativeInterfaceSignature** %t48
  %t49 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  store { %NativeInterfaceSignature*, i64 }* %t47, { %NativeInterfaceSignature*, i64 }** %l5
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %start_index, %t50
  store double %t51, double* %l6
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t58 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t208 = phi { i8**, i64 }* [ %t52, %entry ], [ %t205, %loop.latch4 ]
  %t209 = phi double [ %t58, %entry ], [ %t206, %loop.latch4 ]
  %t210 = phi { %NativeInterfaceSignature*, i64 }* [ %t57, %entry ], [ %t207, %loop.latch4 ]
  store { i8**, i64 }* %t208, { i8**, i64 }** %l0
  store double %t209, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t210, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t59 = load double, double* %l6
  %t60 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t61 = extractvalue { i8**, i64 } %t60, 1
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp oge double %t59, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load i8*, i8** %l2
  %t67 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t70 = load double, double* %l6
  br i1 %t63, label %then6, label %merge7
then6:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s72 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.72, i32 0, i32 0
  %t73 = load i8*, i8** %l4
  %t74 = add i8* %s72, %t73
  %t75 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t71, i8* %t74)
  store { i8**, i64 }* %t75, { i8**, i64 }** %l0
  %t76 = load i8*, i8** %l4
  %t77 = insertvalue %NativeInterface undef, i8* %t76, 0
  %t78 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t79 = extractvalue %InterfaceHeaderParse %t78, 1
  %t80 = insertvalue %NativeInterface %t77, { i8**, i64 }* %t79, 1
  %t81 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t82 = bitcast { %NativeInterfaceSignature*, i64 }* %t81 to { %NativeInterfaceSignature**, i64 }*
  %t83 = insertvalue %NativeInterface %t80, { %NativeInterfaceSignature**, i64 }* %t82, 2
  %t84 = alloca %NativeInterface
  store %NativeInterface %t83, %NativeInterface* %t84
  %t85 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t84, 0
  %t86 = load double, double* %l6
  %t87 = insertvalue %InterfaceParseResult %t85, double %t86, 1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = insertvalue %InterfaceParseResult %t87, { i8**, i64 }* %t88, 2
  ret %InterfaceParseResult %t89
merge7:
  %t90 = load double, double* %l6
  %t91 = fptosi double %t90 to i64
  %t92 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t93 = extractvalue { i8**, i64 } %t92, 0
  %t94 = extractvalue { i8**, i64 } %t92, 1
  %t95 = icmp uge i64 %t91, %t94
  ; bounds check: %t95 (if true, out of bounds)
  %t96 = getelementptr i8*, i8** %t93, i64 %t91
  %t97 = load i8*, i8** %t96
  %t98 = call i8* @trim_text(i8* %t97)
  store i8* %t98, i8** %l7
  %t100 = load i8*, i8** %l7
  %t101 = call i64 @sailfin_runtime_string_length(i8* %t100)
  %t102 = icmp eq i64 %t101, 0
  br label %logical_or_entry_99

logical_or_entry_99:
  br i1 %t102, label %logical_or_merge_99, label %logical_or_right_99

logical_or_right_99:
  %t103 = load i8*, i8** %l7
  %t104 = alloca [2 x i8], align 1
  %t105 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 0
  store i8 59, i8* %t105
  %t106 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 1
  store i8 0, i8* %t106
  %t107 = getelementptr [2 x i8], [2 x i8]* %t104, i32 0, i32 0
  %t108 = call i1 @starts_with(i8* %t103, i8* %t107)
  br label %logical_or_right_end_99

logical_or_right_end_99:
  br label %logical_or_merge_99

logical_or_merge_99:
  %t109 = phi i1 [ true, %logical_or_entry_99 ], [ %t108, %logical_or_right_end_99 ]
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load i8*, i8** %l2
  %t113 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t114 = load i8*, i8** %l4
  %t115 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t116 = load double, double* %l6
  %t117 = load i8*, i8** %l7
  br i1 %t109, label %then8, label %merge9
then8:
  %t118 = load double, double* %l6
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l6
  br label %loop.latch4
merge9:
  %t121 = load i8*, i8** %l7
  %s122 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.122, i32 0, i32 0
  %t123 = icmp eq i8* %t121, %s122
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load i8*, i8** %l2
  %t127 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t128 = load i8*, i8** %l4
  %t129 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load i8*, i8** %l7
  br i1 %t123, label %then10, label %merge11
then10:
  %t132 = load double, double* %l6
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l6
  br label %afterloop5
merge11:
  %t135 = load i8*, i8** %l7
  %s136 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.136, i32 0, i32 0
  %t137 = icmp eq i8* %t135, %s136
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load i8*, i8** %l1
  %t140 = load i8*, i8** %l2
  %t141 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t142 = load i8*, i8** %l4
  %t143 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t144 = load double, double* %l6
  %t145 = load i8*, i8** %l7
  br i1 %t137, label %then12, label %merge13
then12:
  %t146 = load double, double* %l6
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l6
  br label %loop.latch4
merge13:
  %t149 = load i8*, i8** %l7
  %s150 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.150, i32 0, i32 0
  %t151 = call i1 @starts_with(i8* %t149, i8* %s150)
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load i8*, i8** %l2
  %t155 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t156 = load i8*, i8** %l4
  %t157 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t158 = load double, double* %l6
  %t159 = load i8*, i8** %l7
  br i1 %t151, label %then14, label %merge15
then14:
  %t160 = load i8*, i8** %l7
  %s161 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.161, i32 0, i32 0
  %t162 = call i8* @strip_prefix(i8* %t160, i8* %s161)
  %t163 = load i8*, i8** %l4
  %t164 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t162, i8* %t163)
  store %InterfaceSignatureParse %t164, %InterfaceSignatureParse* %l8
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t167 = extractvalue %InterfaceSignatureParse %t166, 2
  %t168 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t165, { i8**, i64 }* %t167)
  store { i8**, i64 }* %t168, { i8**, i64 }** %l0
  %t169 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t170 = extractvalue %InterfaceSignatureParse %t169, 0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load i8*, i8** %l1
  %t173 = load i8*, i8** %l2
  %t174 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t175 = load i8*, i8** %l4
  %t176 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t177 = load double, double* %l6
  %t178 = load i8*, i8** %l7
  %t179 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t170, label %then16, label %merge17
then16:
  %t180 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t181 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t182 = extractvalue %InterfaceSignatureParse %t181, 1
  %t183 = alloca [1 x %NativeInterfaceSignature]
  %t184 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* %t183, i32 0, i32 0
  %t185 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t184, i64 0
  store %NativeInterfaceSignature %t182, %NativeInterfaceSignature* %t185
  %t186 = alloca { %NativeInterfaceSignature*, i64 }
  %t187 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t186, i32 0, i32 0
  store %NativeInterfaceSignature* %t184, %NativeInterfaceSignature** %t187
  %t188 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t186, i32 0, i32 1
  store i64 1, i64* %t188
  %t189 = bitcast { %NativeInterfaceSignature*, i64 }* %t180 to { i8**, i64 }*
  %t190 = bitcast { %NativeInterfaceSignature*, i64 }* %t186 to { i8**, i64 }*
  %t191 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t189, { i8**, i64 }* %t190)
  %t192 = bitcast { i8**, i64 }* %t191 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t192, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t193 = phi { %NativeInterfaceSignature*, i64 }* [ %t192, %then16 ], [ %t176, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t193, { %NativeInterfaceSignature*, i64 }** %l5
  %t194 = load double, double* %l6
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l6
  br label %loop.latch4
merge15:
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s198 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.198, i32 0, i32 0
  %t199 = load i8*, i8** %l7
  %t200 = add i8* %s198, %t199
  %t201 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t197, i8* %t200)
  store { i8**, i64 }* %t201, { i8**, i64 }** %l0
  %t202 = load double, double* %l6
  %t203 = sitofp i64 1 to double
  %t204 = fadd double %t202, %t203
  store double %t204, double* %l6
  br label %loop.latch4
loop.latch4:
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load double, double* %l6
  %t207 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t211 = load i8*, i8** %l4
  %t212 = insertvalue %NativeInterface undef, i8* %t211, 0
  %t213 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t214 = extractvalue %InterfaceHeaderParse %t213, 1
  %t215 = insertvalue %NativeInterface %t212, { i8**, i64 }* %t214, 1
  %t216 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t217 = bitcast { %NativeInterfaceSignature*, i64 }* %t216 to { %NativeInterfaceSignature**, i64 }*
  %t218 = insertvalue %NativeInterface %t215, { %NativeInterfaceSignature**, i64 }* %t217, 2
  %t219 = alloca %NativeInterface
  store %NativeInterface %t218, %NativeInterface* %t219
  %t220 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t219, 0
  %t221 = load double, double* %l6
  %t222 = insertvalue %InterfaceParseResult %t220, double %t221, 1
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = insertvalue %InterfaceParseResult %t222, { i8**, i64 }* %t223, 2
  ret %InterfaceParseResult %t224
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
  %l15 = alloca %NativeParameter*
  %l16 = alloca i8*
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca %NativeInterfaceSignature
  %l24 = alloca i1
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
  %t324 = phi { i8**, i64 }* [ %t220, %then12 ], [ %t321, %loop.latch16 ]
  %t325 = phi { %NativeParameter*, i64 }* [ %t231, %then12 ], [ %t322, %loop.latch16 ]
  %t326 = phi double [ %t234, %then12 ], [ %t323, %loop.latch16 ]
  store { i8**, i64 }* %t324, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t325, { %NativeParameter*, i64 }** %l11
  store double %t326, double* %l14
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
  %t265 = bitcast i8* null to %NativeSourceSpan*
  %t266 = call %NativeParameter* @parse_parameter_entry(i8* %t264, %NativeSourceSpan* %t265)
  store %NativeParameter* %t266, %NativeParameter** %l15
  %t267 = load %NativeParameter*, %NativeParameter** %l15
  %t268 = bitcast i8* null to %NativeParameter*
  %t269 = icmp eq %NativeParameter* %t267, %t268
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t272 = load i8*, i8** %l2
  %t273 = load i8*, i8** %l3
  %t274 = load i1, i1* %l4
  %t275 = load double, double* %l5
  %t276 = load double, double* %l6
  %t277 = load i8*, i8** %l7
  %t278 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t279 = load i8*, i8** %l9
  %t280 = load i8*, i8** %l10
  %t281 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t282 = load i8*, i8** %l12
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t284 = load double, double* %l14
  %t285 = load %NativeParameter*, %NativeParameter** %l15
  br i1 %t269, label %then20, label %else21
then20:
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s287 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.287, i32 0, i32 0
  %t288 = add i8* %s287, %interface_name
  %s289 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.289, i32 0, i32 0
  %t290 = add i8* %t288, %s289
  %t291 = load i8*, i8** %l9
  %t292 = add i8* %t290, %t291
  %s293 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.293, i32 0, i32 0
  %t294 = add i8* %t292, %s293
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t296 = load double, double* %l14
  %t297 = fptosi double %t296 to i64
  %t298 = load { i8**, i64 }, { i8**, i64 }* %t295
  %t299 = extractvalue { i8**, i64 } %t298, 0
  %t300 = extractvalue { i8**, i64 } %t298, 1
  %t301 = icmp uge i64 %t297, %t300
  ; bounds check: %t301 (if true, out of bounds)
  %t302 = getelementptr i8*, i8** %t299, i64 %t297
  %t303 = load i8*, i8** %t302
  %t304 = add i8* %t294, %t303
  %t305 = load i8, i8* %t304
  %t306 = add i8 %t305, 96
  %t307 = alloca [2 x i8], align 1
  %t308 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 0
  store i8 %t306, i8* %t308
  %t309 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 1
  store i8 0, i8* %t309
  %t310 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 0
  %t311 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t286, i8* %t310)
  store { i8**, i64 }* %t311, { i8**, i64 }** %l0
  br label %merge22
else21:
  %t312 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t313 = load %NativeParameter*, %NativeParameter** %l15
  %t314 = load %NativeParameter, %NativeParameter* %t313
  %t315 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t312, %NativeParameter %t314)
  store { %NativeParameter*, i64 }* %t315, { %NativeParameter*, i64 }** %l11
  br label %merge22
merge22:
  %t316 = phi { i8**, i64 }* [ %t311, %then20 ], [ %t270, %else21 ]
  %t317 = phi { %NativeParameter*, i64 }* [ %t281, %then20 ], [ %t315, %else21 ]
  store { i8**, i64 }* %t316, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t317, { %NativeParameter*, i64 }** %l11
  %t318 = load double, double* %l14
  %t319 = sitofp i64 1 to double
  %t320 = fadd double %t318, %t319
  store double %t320, double* %l14
  br label %loop.latch16
loop.latch16:
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t322 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t323 = load double, double* %l14
  br label %loop.header14
afterloop17:
  br label %merge13
merge13:
  %t327 = phi { i8**, i64 }* [ %t311, %then12 ], [ %t204, %entry ]
  %t328 = phi { %NativeParameter*, i64 }* [ %t315, %then12 ], [ %t215, %entry ]
  store { i8**, i64 }* %t327, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t328, { %NativeParameter*, i64 }** %l11
  %s329 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.329, i32 0, i32 0
  store i8* %s329, i8** %l16
  %t330 = alloca [0 x i8*]
  %t331 = getelementptr [0 x i8*], [0 x i8*]* %t330, i32 0, i32 0
  %t332 = alloca { i8**, i64 }
  %t333 = getelementptr { i8**, i64 }, { i8**, i64 }* %t332, i32 0, i32 0
  store i8** %t331, i8*** %t333
  %t334 = getelementptr { i8**, i64 }, { i8**, i64 }* %t332, i32 0, i32 1
  store i64 0, i64* %t334
  store { i8**, i64 }* %t332, { i8**, i64 }** %l17
  %t335 = load i8*, i8** %l3
  %t336 = load double, double* %l6
  %t337 = sitofp i64 1 to double
  %t338 = fadd double %t336, %t337
  %t339 = load i8*, i8** %l3
  %t340 = call i64 @sailfin_runtime_string_length(i8* %t339)
  %t341 = fptosi double %t338 to i64
  %t342 = call i8* @sailfin_runtime_substring(i8* %t335, i64 %t341, i64 %t340)
  %t343 = call i8* @trim_text(i8* %t342)
  store i8* %t343, i8** %l18
  %t344 = load i8*, i8** %l18
  %t345 = call i64 @sailfin_runtime_string_length(i8* %t344)
  %t346 = icmp sgt i64 %t345, 0
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t348 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t349 = load i8*, i8** %l2
  %t350 = load i8*, i8** %l3
  %t351 = load i1, i1* %l4
  %t352 = load double, double* %l5
  %t353 = load double, double* %l6
  %t354 = load i8*, i8** %l7
  %t355 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t356 = load i8*, i8** %l9
  %t357 = load i8*, i8** %l10
  %t358 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t359 = load i8*, i8** %l12
  %t360 = load i8*, i8** %l16
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t362 = load i8*, i8** %l18
  br i1 %t346, label %then23, label %merge24
then23:
  %t363 = load i8*, i8** %l18
  %s364 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.364, i32 0, i32 0
  %t365 = call double @index_of(i8* %t363, i8* %s364)
  store double %t365, double* %l19
  %s366 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.366, i32 0, i32 0
  store i8* %s366, i8** %l20
  %t367 = load double, double* %l19
  %t368 = sitofp i64 0 to double
  %t369 = fcmp oge double %t367, %t368
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t372 = load i8*, i8** %l2
  %t373 = load i8*, i8** %l3
  %t374 = load i1, i1* %l4
  %t375 = load double, double* %l5
  %t376 = load double, double* %l6
  %t377 = load i8*, i8** %l7
  %t378 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t379 = load i8*, i8** %l9
  %t380 = load i8*, i8** %l10
  %t381 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t382 = load i8*, i8** %l12
  %t383 = load i8*, i8** %l16
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t385 = load i8*, i8** %l18
  %t386 = load double, double* %l19
  %t387 = load i8*, i8** %l20
  br i1 %t369, label %then25, label %merge26
then25:
  %t388 = load i8*, i8** %l18
  %t389 = load double, double* %l19
  %t390 = load i8*, i8** %l18
  %t391 = call i64 @sailfin_runtime_string_length(i8* %t390)
  %t392 = fptosi double %t389 to i64
  %t393 = call i8* @sailfin_runtime_substring(i8* %t388, i64 %t392, i64 %t391)
  %t394 = call i8* @trim_text(i8* %t393)
  store i8* %t394, i8** %l20
  %t395 = load i8*, i8** %l18
  %t396 = load double, double* %l19
  %t397 = fptosi double %t396 to i64
  %t398 = call i8* @sailfin_runtime_substring(i8* %t395, i64 0, i64 %t397)
  %t399 = call i8* @trim_text(i8* %t398)
  store i8* %t399, i8** %l18
  br label %merge26
merge26:
  %t400 = phi i8* [ %t394, %then25 ], [ %t387, %then23 ]
  %t401 = phi i8* [ %t399, %then25 ], [ %t385, %then23 ]
  store i8* %t400, i8** %l20
  store i8* %t401, i8** %l18
  %t402 = load i8*, i8** %l18
  %t403 = call i64 @sailfin_runtime_string_length(i8* %t402)
  %t404 = icmp sgt i64 %t403, 0
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t406 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t407 = load i8*, i8** %l2
  %t408 = load i8*, i8** %l3
  %t409 = load i1, i1* %l4
  %t410 = load double, double* %l5
  %t411 = load double, double* %l6
  %t412 = load i8*, i8** %l7
  %t413 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t414 = load i8*, i8** %l9
  %t415 = load i8*, i8** %l10
  %t416 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t417 = load i8*, i8** %l12
  %t418 = load i8*, i8** %l16
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t420 = load i8*, i8** %l18
  %t421 = load double, double* %l19
  %t422 = load i8*, i8** %l20
  br i1 %t404, label %then27, label %merge28
then27:
  %t423 = load i8*, i8** %l18
  %s424 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.424, i32 0, i32 0
  %t425 = call i1 @starts_with(i8* %t423, i8* %s424)
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t427 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t428 = load i8*, i8** %l2
  %t429 = load i8*, i8** %l3
  %t430 = load i1, i1* %l4
  %t431 = load double, double* %l5
  %t432 = load double, double* %l6
  %t433 = load i8*, i8** %l7
  %t434 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t435 = load i8*, i8** %l9
  %t436 = load i8*, i8** %l10
  %t437 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t438 = load i8*, i8** %l12
  %t439 = load i8*, i8** %l16
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t441 = load i8*, i8** %l18
  %t442 = load double, double* %l19
  %t443 = load i8*, i8** %l20
  br i1 %t425, label %then29, label %else30
then29:
  %t444 = load i8*, i8** %l18
  %s445 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.445, i32 0, i32 0
  %t446 = call i8* @strip_prefix(i8* %t444, i8* %s445)
  %t447 = call i8* @trim_text(i8* %t446)
  store i8* %t447, i8** %l21
  %t448 = load i8*, i8** %l21
  %t449 = call i64 @sailfin_runtime_string_length(i8* %t448)
  %t450 = icmp sgt i64 %t449, 0
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t452 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t453 = load i8*, i8** %l2
  %t454 = load i8*, i8** %l3
  %t455 = load i1, i1* %l4
  %t456 = load double, double* %l5
  %t457 = load double, double* %l6
  %t458 = load i8*, i8** %l7
  %t459 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t460 = load i8*, i8** %l9
  %t461 = load i8*, i8** %l10
  %t462 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t463 = load i8*, i8** %l12
  %t464 = load i8*, i8** %l16
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t466 = load i8*, i8** %l18
  %t467 = load double, double* %l19
  %t468 = load i8*, i8** %l20
  %t469 = load i8*, i8** %l21
  br i1 %t450, label %then32, label %merge33
then32:
  %t470 = load i8*, i8** %l21
  store i8* %t470, i8** %l16
  br label %merge33
merge33:
  %t471 = phi i8* [ %t470, %then32 ], [ %t464, %then29 ]
  store i8* %t471, i8** %l16
  br label %merge31
else30:
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s473 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.473, i32 0, i32 0
  %t474 = add i8* %s473, %interface_name
  %s475 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.475, i32 0, i32 0
  %t476 = add i8* %t474, %s475
  %t477 = load i8*, i8** %l9
  %t478 = add i8* %t476, %t477
  %s479 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.479, i32 0, i32 0
  %t480 = add i8* %t478, %s479
  %t481 = load i8*, i8** %l18
  %t482 = add i8* %t480, %t481
  %t483 = load i8, i8* %t482
  %t484 = add i8 %t483, 96
  %t485 = alloca [2 x i8], align 1
  %t486 = getelementptr [2 x i8], [2 x i8]* %t485, i32 0, i32 0
  store i8 %t484, i8* %t486
  %t487 = getelementptr [2 x i8], [2 x i8]* %t485, i32 0, i32 1
  store i8 0, i8* %t487
  %t488 = getelementptr [2 x i8], [2 x i8]* %t485, i32 0, i32 0
  %t489 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t472, i8* %t488)
  store { i8**, i64 }* %t489, { i8**, i64 }** %l0
  br label %merge31
merge31:
  %t490 = phi i8* [ %t470, %then29 ], [ %t439, %else30 ]
  %t491 = phi { i8**, i64 }* [ %t426, %then29 ], [ %t489, %else30 ]
  store i8* %t490, i8** %l16
  store { i8**, i64 }* %t491, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t492 = phi i8* [ %t470, %then27 ], [ %t418, %then23 ]
  %t493 = phi { i8**, i64 }* [ %t489, %then27 ], [ %t405, %then23 ]
  store i8* %t492, i8** %l16
  store { i8**, i64 }* %t493, { i8**, i64 }** %l0
  %t494 = load i8*, i8** %l20
  %t495 = call i64 @sailfin_runtime_string_length(i8* %t494)
  %t496 = icmp sgt i64 %t495, 0
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t498 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t499 = load i8*, i8** %l2
  %t500 = load i8*, i8** %l3
  %t501 = load i1, i1* %l4
  %t502 = load double, double* %l5
  %t503 = load double, double* %l6
  %t504 = load i8*, i8** %l7
  %t505 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t506 = load i8*, i8** %l9
  %t507 = load i8*, i8** %l10
  %t508 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t509 = load i8*, i8** %l12
  %t510 = load i8*, i8** %l16
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t512 = load i8*, i8** %l18
  %t513 = load double, double* %l19
  %t514 = load i8*, i8** %l20
  br i1 %t496, label %then34, label %merge35
then34:
  %t516 = load i8*, i8** %l20
  %s517 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.517, i32 0, i32 0
  %t518 = call i1 @starts_with(i8* %t516, i8* %s517)
  br label %logical_and_entry_515

logical_and_entry_515:
  br i1 %t518, label %logical_and_right_515, label %logical_and_merge_515

logical_and_right_515:
  %t519 = load i8*, i8** %l20
  %t520 = load i8*, i8** %l20
  %t521 = call i64 @sailfin_runtime_string_length(i8* %t520)
  %t522 = sub i64 %t521, 1
  %t523 = getelementptr i8, i8* %t519, i64 %t522
  %t524 = load i8, i8* %t523
  %t525 = icmp eq i8 %t524, 93
  br label %logical_and_right_end_515

logical_and_right_end_515:
  br label %logical_and_merge_515

logical_and_merge_515:
  %t526 = phi i1 [ false, %logical_and_entry_515 ], [ %t525, %logical_and_right_end_515 ]
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t528 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t529 = load i8*, i8** %l2
  %t530 = load i8*, i8** %l3
  %t531 = load i1, i1* %l4
  %t532 = load double, double* %l5
  %t533 = load double, double* %l6
  %t534 = load i8*, i8** %l7
  %t535 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t536 = load i8*, i8** %l9
  %t537 = load i8*, i8** %l10
  %t538 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t539 = load i8*, i8** %l12
  %t540 = load i8*, i8** %l16
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t542 = load i8*, i8** %l18
  %t543 = load double, double* %l19
  %t544 = load i8*, i8** %l20
  br i1 %t526, label %then36, label %else37
then36:
  %t545 = load i8*, i8** %l20
  %t546 = load i8*, i8** %l20
  %t547 = call i64 @sailfin_runtime_string_length(i8* %t546)
  %t548 = sub i64 %t547, 1
  %t549 = call i8* @sailfin_runtime_substring(i8* %t545, i64 2, i64 %t548)
  store i8* %t549, i8** %l22
  %t550 = load i8*, i8** %l22
  %t551 = call { i8**, i64 }* @parse_effect_list(i8* %t550)
  store { i8**, i64 }* %t551, { i8**, i64 }** %l17
  br label %merge38
else37:
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s553 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.553, i32 0, i32 0
  %t554 = add i8* %s553, %interface_name
  %s555 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.555, i32 0, i32 0
  %t556 = add i8* %t554, %s555
  %t557 = load i8*, i8** %l9
  %t558 = add i8* %t556, %t557
  %s559 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.559, i32 0, i32 0
  %t560 = add i8* %t558, %s559
  %t561 = load i8*, i8** %l20
  %t562 = add i8* %t560, %t561
  %t563 = load i8, i8* %t562
  %t564 = add i8 %t563, 96
  %t565 = alloca [2 x i8], align 1
  %t566 = getelementptr [2 x i8], [2 x i8]* %t565, i32 0, i32 0
  store i8 %t564, i8* %t566
  %t567 = getelementptr [2 x i8], [2 x i8]* %t565, i32 0, i32 1
  store i8 0, i8* %t567
  %t568 = getelementptr [2 x i8], [2 x i8]* %t565, i32 0, i32 0
  %t569 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t552, i8* %t568)
  store { i8**, i64 }* %t569, { i8**, i64 }** %l0
  br label %merge38
merge38:
  %t570 = phi { i8**, i64 }* [ %t551, %then36 ], [ %t541, %else37 ]
  %t571 = phi { i8**, i64 }* [ %t527, %then36 ], [ %t569, %else37 ]
  store { i8**, i64 }* %t570, { i8**, i64 }** %l17
  store { i8**, i64 }* %t571, { i8**, i64 }** %l0
  br label %merge35
merge35:
  %t572 = phi { i8**, i64 }* [ %t551, %then34 ], [ %t511, %then23 ]
  %t573 = phi { i8**, i64 }* [ %t569, %then34 ], [ %t497, %then23 ]
  store { i8**, i64 }* %t572, { i8**, i64 }** %l17
  store { i8**, i64 }* %t573, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t574 = phi i8* [ %t399, %then23 ], [ %t362, %entry ]
  %t575 = phi i8* [ %t470, %then23 ], [ %t360, %entry ]
  %t576 = phi { i8**, i64 }* [ %t489, %then23 ], [ %t347, %entry ]
  %t577 = phi { i8**, i64 }* [ %t551, %then23 ], [ %t361, %entry ]
  %t578 = phi { i8**, i64 }* [ %t569, %then23 ], [ %t347, %entry ]
  store i8* %t574, i8** %l18
  store i8* %t575, i8** %l16
  store { i8**, i64 }* %t576, { i8**, i64 }** %l0
  store { i8**, i64 }* %t577, { i8**, i64 }** %l17
  store { i8**, i64 }* %t578, { i8**, i64 }** %l0
  %t579 = load i8*, i8** %l9
  %t580 = insertvalue %NativeInterfaceSignature undef, i8* %t579, 0
  %t581 = load i1, i1* %l4
  %t582 = insertvalue %NativeInterfaceSignature %t580, i1 %t581, 1
  %t583 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t584 = extractvalue %HeaderNameParse %t583, 1
  %t585 = insertvalue %NativeInterfaceSignature %t582, { i8**, i64 }* %t584, 2
  %t586 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t587 = bitcast { %NativeParameter*, i64 }* %t586 to { %NativeParameter**, i64 }*
  %t588 = insertvalue %NativeInterfaceSignature %t585, { %NativeParameter**, i64 }* %t587, 3
  %t589 = load i8*, i8** %l16
  %t590 = insertvalue %NativeInterfaceSignature %t588, i8* %t589, 4
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t592 = insertvalue %NativeInterfaceSignature %t590, { i8**, i64 }* %t591, 5
  store %NativeInterfaceSignature %t592, %NativeInterfaceSignature* %l23
  %t594 = load i8*, i8** %l9
  %t595 = call i64 @sailfin_runtime_string_length(i8* %t594)
  %t596 = icmp sgt i64 %t595, 0
  br label %logical_and_entry_593

logical_and_entry_593:
  br i1 %t596, label %logical_and_right_593, label %logical_and_merge_593

logical_and_right_593:
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t598 = load { i8**, i64 }, { i8**, i64 }* %t597
  %t599 = extractvalue { i8**, i64 } %t598, 1
  %t600 = icmp eq i64 %t599, 0
  br label %logical_and_right_end_593

logical_and_right_end_593:
  br label %logical_and_merge_593

logical_and_merge_593:
  %t601 = phi i1 [ false, %logical_and_entry_593 ], [ %t600, %logical_and_right_end_593 ]
  store i1 %t601, i1* %l24
  %t602 = load i1, i1* %l24
  %t603 = insertvalue %InterfaceSignatureParse undef, i1 %t602, 0
  %t604 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l23
  %t605 = insertvalue %InterfaceSignatureParse %t603, %NativeInterfaceSignature %t604, 1
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t607 = insertvalue %InterfaceSignatureParse %t605, { i8**, i64 }* %t606, 2
  ret %InterfaceSignatureParse %t607
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
  %t484 = phi i8* [ %t13, %entry ], [ %t476, %loop.latch2 ]
  %t485 = phi double [ %t14, %entry ], [ %t477, %loop.latch2 ]
  %t486 = phi i8* [ %t15, %entry ], [ %t478, %loop.latch2 ]
  %t487 = phi double [ %t16, %entry ], [ %t479, %loop.latch2 ]
  %t488 = phi double [ %t17, %entry ], [ %t480, %loop.latch2 ]
  %t489 = phi double [ %t18, %entry ], [ %t481, %loop.latch2 ]
  %t490 = phi double [ %t19, %entry ], [ %t482, %loop.latch2 ]
  %t491 = phi { i8**, i64 }* [ %t12, %entry ], [ %t483, %loop.latch2 ]
  store i8* %t484, i8** %l1
  store double %t485, double* %l2
  store i8* %t486, i8** %l3
  store double %t487, double* %l4
  store double %t488, double* %l5
  store double %t489, double* %l6
  store double %t490, double* %l7
  store { i8**, i64 }* %t491, { i8**, i64 }** %l0
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
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  %t86 = fptosi double %t85 to i64
  %t87 = getelementptr i8, i8* %text, i64 %t86
  %t88 = load i8, i8* %t87
  %t89 = load i8, i8* %t82
  %t90 = add i8 %t89, %t88
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 %t90, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8* %t94, i8** %l1
  %t95 = load double, double* %l2
  %t96 = sitofp i64 2 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t98 = phi i8* [ %t94, %then8 ], [ %t59, %then6 ]
  %t99 = phi double [ %t97, %then8 ], [ %t60, %then6 ]
  store i8* %t98, i8** %l1
  store double %t99, double* %l2
  %t100 = load i8, i8* %l8
  %t101 = load i8*, i8** %l3
  %t102 = load i8, i8* %t101
  %t103 = icmp eq i8 %t100, %t102
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  %t107 = load i8*, i8** %l3
  %t108 = load double, double* %l4
  %t109 = load double, double* %l5
  %t110 = load double, double* %l6
  %t111 = load double, double* %l7
  %t112 = load i8, i8* %l8
  br i1 %t103, label %then12, label %merge13
then12:
  %s113 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.113, i32 0, i32 0
  store i8* %s113, i8** %l3
  br label %merge13
merge13:
  %t114 = phi i8* [ %s113, %then12 ], [ %t107, %then6 ]
  store i8* %t114, i8** %l3
  %t115 = load double, double* %l2
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l2
  br label %loop.latch2
merge7:
  %t119 = load i8, i8* %l8
  %t120 = icmp eq i8 %t119, 34
  br label %logical_or_entry_118

logical_or_entry_118:
  br i1 %t120, label %logical_or_merge_118, label %logical_or_right_118

logical_or_right_118:
  %t121 = load i8, i8* %l8
  %t122 = icmp eq i8 %t121, 39
  br label %logical_or_right_end_118

logical_or_right_end_118:
  br label %logical_or_merge_118

logical_or_merge_118:
  %t123 = phi i1 [ true, %logical_or_entry_118 ], [ %t122, %logical_or_right_end_118 ]
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load double, double* %l2
  %t127 = load i8*, i8** %l3
  %t128 = load double, double* %l4
  %t129 = load double, double* %l5
  %t130 = load double, double* %l6
  %t131 = load double, double* %l7
  %t132 = load i8, i8* %l8
  br i1 %t123, label %then14, label %merge15
then14:
  %t133 = load i8, i8* %l8
  %t134 = alloca [2 x i8], align 1
  %t135 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  store i8 %t133, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 1
  store i8 0, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  store i8* %t137, i8** %l3
  %t138 = load i8*, i8** %l1
  %t139 = load i8, i8* %l8
  %t140 = load i8, i8* %t138
  %t141 = add i8 %t140, %t139
  %t142 = alloca [2 x i8], align 1
  %t143 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8 %t141, i8* %t143
  %t144 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 1
  store i8 0, i8* %t144
  %t145 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8* %t145, i8** %l1
  %t146 = load double, double* %l2
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l2
  br label %loop.latch2
merge15:
  %t149 = load i8, i8* %l8
  %t150 = icmp eq i8 %t149, 60
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load i8*, i8** %l1
  %t153 = load double, double* %l2
  %t154 = load i8*, i8** %l3
  %t155 = load double, double* %l4
  %t156 = load double, double* %l5
  %t157 = load double, double* %l6
  %t158 = load double, double* %l7
  %t159 = load i8, i8* %l8
  br i1 %t150, label %then16, label %merge17
then16:
  %t160 = load double, double* %l4
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l4
  %t163 = load i8*, i8** %l1
  %t164 = load i8, i8* %l8
  %t165 = load i8, i8* %t163
  %t166 = add i8 %t165, %t164
  %t167 = alloca [2 x i8], align 1
  %t168 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  store i8 %t166, i8* %t168
  %t169 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 1
  store i8 0, i8* %t169
  %t170 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  store i8* %t170, i8** %l1
  %t171 = load double, double* %l2
  %t172 = sitofp i64 1 to double
  %t173 = fadd double %t171, %t172
  store double %t173, double* %l2
  br label %loop.latch2
merge17:
  %t174 = load i8, i8* %l8
  %t175 = icmp eq i8 %t174, 62
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load i8*, i8** %l1
  %t178 = load double, double* %l2
  %t179 = load i8*, i8** %l3
  %t180 = load double, double* %l4
  %t181 = load double, double* %l5
  %t182 = load double, double* %l6
  %t183 = load double, double* %l7
  %t184 = load i8, i8* %l8
  br i1 %t175, label %then18, label %merge19
then18:
  %t185 = load double, double* %l4
  %t186 = sitofp i64 0 to double
  %t187 = fcmp ogt double %t185, %t186
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load i8*, i8** %l1
  %t190 = load double, double* %l2
  %t191 = load i8*, i8** %l3
  %t192 = load double, double* %l4
  %t193 = load double, double* %l5
  %t194 = load double, double* %l6
  %t195 = load double, double* %l7
  %t196 = load i8, i8* %l8
  br i1 %t187, label %then20, label %merge21
then20:
  %t197 = load double, double* %l4
  %t198 = sitofp i64 1 to double
  %t199 = fsub double %t197, %t198
  store double %t199, double* %l4
  br label %merge21
merge21:
  %t200 = phi double [ %t199, %then20 ], [ %t192, %then18 ]
  store double %t200, double* %l4
  %t201 = load i8*, i8** %l1
  %t202 = load i8, i8* %l8
  %t203 = load i8, i8* %t201
  %t204 = add i8 %t203, %t202
  %t205 = alloca [2 x i8], align 1
  %t206 = getelementptr [2 x i8], [2 x i8]* %t205, i32 0, i32 0
  store i8 %t204, i8* %t206
  %t207 = getelementptr [2 x i8], [2 x i8]* %t205, i32 0, i32 1
  store i8 0, i8* %t207
  %t208 = getelementptr [2 x i8], [2 x i8]* %t205, i32 0, i32 0
  store i8* %t208, i8** %l1
  %t209 = load double, double* %l2
  %t210 = sitofp i64 1 to double
  %t211 = fadd double %t209, %t210
  store double %t211, double* %l2
  br label %loop.latch2
merge19:
  %t212 = load i8, i8* %l8
  %t213 = icmp eq i8 %t212, 40
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load i8*, i8** %l1
  %t216 = load double, double* %l2
  %t217 = load i8*, i8** %l3
  %t218 = load double, double* %l4
  %t219 = load double, double* %l5
  %t220 = load double, double* %l6
  %t221 = load double, double* %l7
  %t222 = load i8, i8* %l8
  br i1 %t213, label %then22, label %merge23
then22:
  %t223 = load double, double* %l5
  %t224 = sitofp i64 1 to double
  %t225 = fadd double %t223, %t224
  store double %t225, double* %l5
  %t226 = load i8*, i8** %l1
  %t227 = load i8, i8* %l8
  %t228 = load i8, i8* %t226
  %t229 = add i8 %t228, %t227
  %t230 = alloca [2 x i8], align 1
  %t231 = getelementptr [2 x i8], [2 x i8]* %t230, i32 0, i32 0
  store i8 %t229, i8* %t231
  %t232 = getelementptr [2 x i8], [2 x i8]* %t230, i32 0, i32 1
  store i8 0, i8* %t232
  %t233 = getelementptr [2 x i8], [2 x i8]* %t230, i32 0, i32 0
  store i8* %t233, i8** %l1
  %t234 = load double, double* %l2
  %t235 = sitofp i64 1 to double
  %t236 = fadd double %t234, %t235
  store double %t236, double* %l2
  br label %loop.latch2
merge23:
  %t237 = load i8, i8* %l8
  %t238 = icmp eq i8 %t237, 41
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  %t242 = load i8*, i8** %l3
  %t243 = load double, double* %l4
  %t244 = load double, double* %l5
  %t245 = load double, double* %l6
  %t246 = load double, double* %l7
  %t247 = load i8, i8* %l8
  br i1 %t238, label %then24, label %merge25
then24:
  %t248 = load double, double* %l5
  %t249 = sitofp i64 0 to double
  %t250 = fcmp ogt double %t248, %t249
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
  %t260 = load double, double* %l5
  %t261 = sitofp i64 1 to double
  %t262 = fsub double %t260, %t261
  store double %t262, double* %l5
  br label %merge27
merge27:
  %t263 = phi double [ %t262, %then26 ], [ %t256, %then24 ]
  store double %t263, double* %l5
  %t264 = load i8*, i8** %l1
  %t265 = load i8, i8* %l8
  %t266 = load i8, i8* %t264
  %t267 = add i8 %t266, %t265
  %t268 = alloca [2 x i8], align 1
  %t269 = getelementptr [2 x i8], [2 x i8]* %t268, i32 0, i32 0
  store i8 %t267, i8* %t269
  %t270 = getelementptr [2 x i8], [2 x i8]* %t268, i32 0, i32 1
  store i8 0, i8* %t270
  %t271 = getelementptr [2 x i8], [2 x i8]* %t268, i32 0, i32 0
  store i8* %t271, i8** %l1
  %t272 = load double, double* %l2
  %t273 = sitofp i64 1 to double
  %t274 = fadd double %t272, %t273
  store double %t274, double* %l2
  br label %loop.latch2
merge25:
  %t275 = load i8, i8* %l8
  %t276 = icmp eq i8 %t275, 91
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load i8*, i8** %l1
  %t279 = load double, double* %l2
  %t280 = load i8*, i8** %l3
  %t281 = load double, double* %l4
  %t282 = load double, double* %l5
  %t283 = load double, double* %l6
  %t284 = load double, double* %l7
  %t285 = load i8, i8* %l8
  br i1 %t276, label %then28, label %merge29
then28:
  %t286 = load double, double* %l6
  %t287 = sitofp i64 1 to double
  %t288 = fadd double %t286, %t287
  store double %t288, double* %l6
  %t289 = load i8*, i8** %l1
  %t290 = load i8, i8* %l8
  %t291 = load i8, i8* %t289
  %t292 = add i8 %t291, %t290
  %t293 = alloca [2 x i8], align 1
  %t294 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 0
  store i8 %t292, i8* %t294
  %t295 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 1
  store i8 0, i8* %t295
  %t296 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 0
  store i8* %t296, i8** %l1
  %t297 = load double, double* %l2
  %t298 = sitofp i64 1 to double
  %t299 = fadd double %t297, %t298
  store double %t299, double* %l2
  br label %loop.latch2
merge29:
  %t300 = load i8, i8* %l8
  %t301 = icmp eq i8 %t300, 93
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t303 = load i8*, i8** %l1
  %t304 = load double, double* %l2
  %t305 = load i8*, i8** %l3
  %t306 = load double, double* %l4
  %t307 = load double, double* %l5
  %t308 = load double, double* %l6
  %t309 = load double, double* %l7
  %t310 = load i8, i8* %l8
  br i1 %t301, label %then30, label %merge31
then30:
  %t311 = load double, double* %l6
  %t312 = sitofp i64 0 to double
  %t313 = fcmp ogt double %t311, %t312
  %t314 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t315 = load i8*, i8** %l1
  %t316 = load double, double* %l2
  %t317 = load i8*, i8** %l3
  %t318 = load double, double* %l4
  %t319 = load double, double* %l5
  %t320 = load double, double* %l6
  %t321 = load double, double* %l7
  %t322 = load i8, i8* %l8
  br i1 %t313, label %then32, label %merge33
then32:
  %t323 = load double, double* %l6
  %t324 = sitofp i64 1 to double
  %t325 = fsub double %t323, %t324
  store double %t325, double* %l6
  br label %merge33
merge33:
  %t326 = phi double [ %t325, %then32 ], [ %t320, %then30 ]
  store double %t326, double* %l6
  %t327 = load i8*, i8** %l1
  %t328 = load i8, i8* %l8
  %t329 = load i8, i8* %t327
  %t330 = add i8 %t329, %t328
  %t331 = alloca [2 x i8], align 1
  %t332 = getelementptr [2 x i8], [2 x i8]* %t331, i32 0, i32 0
  store i8 %t330, i8* %t332
  %t333 = getelementptr [2 x i8], [2 x i8]* %t331, i32 0, i32 1
  store i8 0, i8* %t333
  %t334 = getelementptr [2 x i8], [2 x i8]* %t331, i32 0, i32 0
  store i8* %t334, i8** %l1
  %t335 = load double, double* %l2
  %t336 = sitofp i64 1 to double
  %t337 = fadd double %t335, %t336
  store double %t337, double* %l2
  br label %loop.latch2
merge31:
  %t338 = load i8, i8* %l8
  %t339 = icmp eq i8 %t338, 123
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t341 = load i8*, i8** %l1
  %t342 = load double, double* %l2
  %t343 = load i8*, i8** %l3
  %t344 = load double, double* %l4
  %t345 = load double, double* %l5
  %t346 = load double, double* %l6
  %t347 = load double, double* %l7
  %t348 = load i8, i8* %l8
  br i1 %t339, label %then34, label %merge35
then34:
  %t349 = load double, double* %l7
  %t350 = sitofp i64 1 to double
  %t351 = fadd double %t349, %t350
  store double %t351, double* %l7
  %t352 = load i8*, i8** %l1
  %t353 = load i8, i8* %l8
  %t354 = load i8, i8* %t352
  %t355 = add i8 %t354, %t353
  %t356 = alloca [2 x i8], align 1
  %t357 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 0
  store i8 %t355, i8* %t357
  %t358 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 1
  store i8 0, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t356, i32 0, i32 0
  store i8* %t359, i8** %l1
  %t360 = load double, double* %l2
  %t361 = sitofp i64 1 to double
  %t362 = fadd double %t360, %t361
  store double %t362, double* %l2
  br label %loop.latch2
merge35:
  %t363 = load i8, i8* %l8
  %t364 = icmp eq i8 %t363, 125
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load i8*, i8** %l1
  %t367 = load double, double* %l2
  %t368 = load i8*, i8** %l3
  %t369 = load double, double* %l4
  %t370 = load double, double* %l5
  %t371 = load double, double* %l6
  %t372 = load double, double* %l7
  %t373 = load i8, i8* %l8
  br i1 %t364, label %then36, label %merge37
then36:
  %t374 = load double, double* %l7
  %t375 = sitofp i64 0 to double
  %t376 = fcmp ogt double %t374, %t375
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t378 = load i8*, i8** %l1
  %t379 = load double, double* %l2
  %t380 = load i8*, i8** %l3
  %t381 = load double, double* %l4
  %t382 = load double, double* %l5
  %t383 = load double, double* %l6
  %t384 = load double, double* %l7
  %t385 = load i8, i8* %l8
  br i1 %t376, label %then38, label %merge39
then38:
  %t386 = load double, double* %l7
  %t387 = sitofp i64 1 to double
  %t388 = fsub double %t386, %t387
  store double %t388, double* %l7
  br label %merge39
merge39:
  %t389 = phi double [ %t388, %then38 ], [ %t384, %then36 ]
  store double %t389, double* %l7
  %t390 = load i8*, i8** %l1
  %t391 = load i8, i8* %l8
  %t392 = load i8, i8* %t390
  %t393 = add i8 %t392, %t391
  %t394 = alloca [2 x i8], align 1
  %t395 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 0
  store i8 %t393, i8* %t395
  %t396 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 1
  store i8 0, i8* %t396
  %t397 = getelementptr [2 x i8], [2 x i8]* %t394, i32 0, i32 0
  store i8* %t397, i8** %l1
  %t398 = load double, double* %l2
  %t399 = sitofp i64 1 to double
  %t400 = fadd double %t398, %t399
  store double %t400, double* %l2
  br label %loop.latch2
merge37:
  %t401 = load i8, i8* %l8
  %t402 = icmp eq i8 %t401, 44
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t404 = load i8*, i8** %l1
  %t405 = load double, double* %l2
  %t406 = load i8*, i8** %l3
  %t407 = load double, double* %l4
  %t408 = load double, double* %l5
  %t409 = load double, double* %l6
  %t410 = load double, double* %l7
  %t411 = load i8, i8* %l8
  br i1 %t402, label %then40, label %merge41
then40:
  %t413 = load double, double* %l4
  %t414 = sitofp i64 0 to double
  %t415 = fcmp oeq double %t413, %t414
  br label %logical_and_entry_412

logical_and_entry_412:
  br i1 %t415, label %logical_and_right_412, label %logical_and_merge_412

logical_and_right_412:
  %t417 = load double, double* %l5
  %t418 = sitofp i64 0 to double
  %t419 = fcmp oeq double %t417, %t418
  br label %logical_and_entry_416

logical_and_entry_416:
  br i1 %t419, label %logical_and_right_416, label %logical_and_merge_416

logical_and_right_416:
  %t421 = load double, double* %l6
  %t422 = sitofp i64 0 to double
  %t423 = fcmp oeq double %t421, %t422
  br label %logical_and_entry_420

logical_and_entry_420:
  br i1 %t423, label %logical_and_right_420, label %logical_and_merge_420

logical_and_right_420:
  %t424 = load double, double* %l7
  %t425 = sitofp i64 0 to double
  %t426 = fcmp oeq double %t424, %t425
  br label %logical_and_right_end_420

logical_and_right_end_420:
  br label %logical_and_merge_420

logical_and_merge_420:
  %t427 = phi i1 [ false, %logical_and_entry_420 ], [ %t426, %logical_and_right_end_420 ]
  br label %logical_and_right_end_416

logical_and_right_end_416:
  br label %logical_and_merge_416

logical_and_merge_416:
  %t428 = phi i1 [ false, %logical_and_entry_416 ], [ %t427, %logical_and_right_end_416 ]
  br label %logical_and_right_end_412

logical_and_right_end_412:
  br label %logical_and_merge_412

logical_and_merge_412:
  %t429 = phi i1 [ false, %logical_and_entry_412 ], [ %t428, %logical_and_right_end_412 ]
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t431 = load i8*, i8** %l1
  %t432 = load double, double* %l2
  %t433 = load i8*, i8** %l3
  %t434 = load double, double* %l4
  %t435 = load double, double* %l5
  %t436 = load double, double* %l6
  %t437 = load double, double* %l7
  %t438 = load i8, i8* %l8
  br i1 %t429, label %then42, label %merge43
then42:
  %t439 = load i8*, i8** %l1
  %t440 = call i8* @trim_text(i8* %t439)
  store i8* %t440, i8** %l9
  %t441 = load i8*, i8** %l9
  %t442 = call i64 @sailfin_runtime_string_length(i8* %t441)
  %t443 = icmp sgt i64 %t442, 0
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t445 = load i8*, i8** %l1
  %t446 = load double, double* %l2
  %t447 = load i8*, i8** %l3
  %t448 = load double, double* %l4
  %t449 = load double, double* %l5
  %t450 = load double, double* %l6
  %t451 = load double, double* %l7
  %t452 = load i8, i8* %l8
  %t453 = load i8*, i8** %l9
  br i1 %t443, label %then44, label %merge45
then44:
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t455 = load i8*, i8** %l9
  %t456 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t454, i8* %t455)
  store { i8**, i64 }* %t456, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t457 = phi { i8**, i64 }* [ %t456, %then44 ], [ %t444, %then42 ]
  store { i8**, i64 }* %t457, { i8**, i64 }** %l0
  %s458 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.458, i32 0, i32 0
  store i8* %s458, i8** %l1
  %t459 = load double, double* %l2
  %t460 = sitofp i64 1 to double
  %t461 = fadd double %t459, %t460
  store double %t461, double* %l2
  br label %loop.latch2
merge43:
  br label %merge41
merge41:
  %t462 = phi { i8**, i64 }* [ %t456, %then40 ], [ %t403, %loop.body1 ]
  %t463 = phi i8* [ %s458, %then40 ], [ %t404, %loop.body1 ]
  %t464 = phi double [ %t461, %then40 ], [ %t405, %loop.body1 ]
  store { i8**, i64 }* %t462, { i8**, i64 }** %l0
  store i8* %t463, i8** %l1
  store double %t464, double* %l2
  %t465 = load i8*, i8** %l1
  %t466 = load i8, i8* %l8
  %t467 = load i8, i8* %t465
  %t468 = add i8 %t467, %t466
  %t469 = alloca [2 x i8], align 1
  %t470 = getelementptr [2 x i8], [2 x i8]* %t469, i32 0, i32 0
  store i8 %t468, i8* %t470
  %t471 = getelementptr [2 x i8], [2 x i8]* %t469, i32 0, i32 1
  store i8 0, i8* %t471
  %t472 = getelementptr [2 x i8], [2 x i8]* %t469, i32 0, i32 0
  store i8* %t472, i8** %l1
  %t473 = load double, double* %l2
  %t474 = sitofp i64 1 to double
  %t475 = fadd double %t473, %t474
  store double %t475, double* %l2
  br label %loop.latch2
loop.latch2:
  %t476 = load i8*, i8** %l1
  %t477 = load double, double* %l2
  %t478 = load i8*, i8** %l3
  %t479 = load double, double* %l4
  %t480 = load double, double* %l5
  %t481 = load double, double* %l6
  %t482 = load double, double* %l7
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t492 = load i8*, i8** %l1
  %t493 = call i8* @trim_text(i8* %t492)
  store i8* %t493, i8** %l10
  %t494 = load i8*, i8** %l10
  %t495 = call i64 @sailfin_runtime_string_length(i8* %t494)
  %t496 = icmp sgt i64 %t495, 0
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t498 = load i8*, i8** %l1
  %t499 = load double, double* %l2
  %t500 = load i8*, i8** %l3
  %t501 = load double, double* %l4
  %t502 = load double, double* %l5
  %t503 = load double, double* %l6
  %t504 = load double, double* %l7
  %t505 = load i8*, i8** %l10
  br i1 %t496, label %then46, label %merge47
then46:
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t507 = load i8*, i8** %l10
  %t508 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t506, i8* %t507)
  store { i8**, i64 }* %t508, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t509 = phi { i8**, i64 }* [ %t508, %then46 ], [ %t497, %entry ]
  store { i8**, i64 }* %t509, { i8**, i64 }** %l0
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t510
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
  %l15 = alloca %NativeEnumLayout*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %EnumLayoutHeaderParse
  %l19 = alloca %EnumLayoutVariantParse
  %l20 = alloca double
  %l21 = alloca %EnumLayoutPayloadParse
  %l22 = alloca double
  %l23 = alloca %NativeEnumVariant*
  %l24 = alloca %NativeEnumLayout*
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
  %t53 = bitcast i8* null to %NativeEnum*
  %t54 = insertvalue %EnumParseResult undef, %NativeEnum* %t53, 0
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %start_index, %t55
  %t57 = insertvalue %EnumParseResult %t54, double %t56, 1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = insertvalue %EnumParseResult %t57, { i8**, i64 }* %t58, 2
  ret %EnumParseResult %t59
merge3:
  %t60 = alloca [0 x %NativeEnumVariant]
  %t61 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* %t60, i32 0, i32 0
  %t62 = alloca { %NativeEnumVariant*, i64 }
  %t63 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t62, i32 0, i32 0
  store %NativeEnumVariant* %t61, %NativeEnumVariant** %t63
  %t64 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t62, i32 0, i32 1
  store i64 0, i64* %t64
  store { %NativeEnumVariant*, i64 }* %t62, { %NativeEnumVariant*, i64 }** %l5
  %t65 = alloca [0 x %NativeEnumVariantLayout]
  %t66 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t65, i32 0, i32 0
  %t67 = alloca { %NativeEnumVariantLayout*, i64 }
  %t68 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t67, i32 0, i32 0
  store %NativeEnumVariantLayout* %t66, %NativeEnumVariantLayout** %t68
  %t69 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  store { %NativeEnumVariantLayout*, i64 }* %t67, { %NativeEnumVariantLayout*, i64 }** %l6
  %t70 = sitofp i64 0 to double
  store double %t70, double* %l7
  %t71 = sitofp i64 0 to double
  store double %t71, double* %l8
  %s72 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.72, i32 0, i32 0
  store i8* %s72, i8** %l9
  %t73 = sitofp i64 0 to double
  store double %t73, double* %l10
  %t74 = sitofp i64 0 to double
  store double %t74, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %start_index, %t75
  store double %t76, double* %l14
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load i8*, i8** %l1
  %t79 = load i8*, i8** %l2
  %t80 = load i8*, i8** %l3
  %t81 = load double, double* %l4
  %t82 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t83 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t84 = load double, double* %l7
  %t85 = load double, double* %l8
  %t86 = load i8*, i8** %l9
  %t87 = load double, double* %l10
  %t88 = load double, double* %l11
  %t89 = load i1, i1* %l12
  %t90 = load i1, i1* %l13
  %t91 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t762 = phi { i8**, i64 }* [ %t77, %entry ], [ %t751, %loop.latch6 ]
  %t763 = phi double [ %t91, %entry ], [ %t752, %loop.latch6 ]
  %t764 = phi double [ %t84, %entry ], [ %t753, %loop.latch6 ]
  %t765 = phi double [ %t85, %entry ], [ %t754, %loop.latch6 ]
  %t766 = phi i8* [ %t86, %entry ], [ %t755, %loop.latch6 ]
  %t767 = phi double [ %t87, %entry ], [ %t756, %loop.latch6 ]
  %t768 = phi double [ %t88, %entry ], [ %t757, %loop.latch6 ]
  %t769 = phi i1 [ %t89, %entry ], [ %t758, %loop.latch6 ]
  %t770 = phi { %NativeEnumVariantLayout*, i64 }* [ %t83, %entry ], [ %t759, %loop.latch6 ]
  %t771 = phi i1 [ %t90, %entry ], [ %t760, %loop.latch6 ]
  %t772 = phi { %NativeEnumVariant*, i64 }* [ %t82, %entry ], [ %t761, %loop.latch6 ]
  store { i8**, i64 }* %t762, { i8**, i64 }** %l0
  store double %t763, double* %l14
  store double %t764, double* %l7
  store double %t765, double* %l8
  store i8* %t766, i8** %l9
  store double %t767, double* %l10
  store double %t768, double* %l11
  store i1 %t769, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t770, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t771, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t772, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t92 = load double, double* %l14
  %t93 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t94 = extractvalue { i8**, i64 } %t93, 1
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp oge double %t92, %t95
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load i8*, i8** %l1
  %t99 = load i8*, i8** %l2
  %t100 = load i8*, i8** %l3
  %t101 = load double, double* %l4
  %t102 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t103 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t104 = load double, double* %l7
  %t105 = load double, double* %l8
  %t106 = load i8*, i8** %l9
  %t107 = load double, double* %l10
  %t108 = load double, double* %l11
  %t109 = load i1, i1* %l12
  %t110 = load i1, i1* %l13
  %t111 = load double, double* %l14
  br i1 %t96, label %then8, label %merge9
then8:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s113 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.113, i32 0, i32 0
  %t114 = load i8*, i8** %l3
  %t115 = add i8* %s113, %t114
  %t116 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t112, i8* %t115)
  store { i8**, i64 }* %t116, { i8**, i64 }** %l0
  %t117 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t117, %NativeEnumLayout** %l15
  %t118 = load i1, i1* %l12
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load i8*, i8** %l1
  %t121 = load i8*, i8** %l2
  %t122 = load i8*, i8** %l3
  %t123 = load double, double* %l4
  %t124 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t125 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t126 = load double, double* %l7
  %t127 = load double, double* %l8
  %t128 = load i8*, i8** %l9
  %t129 = load double, double* %l10
  %t130 = load double, double* %l11
  %t131 = load i1, i1* %l12
  %t132 = load i1, i1* %l13
  %t133 = load double, double* %l14
  %t134 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br i1 %t118, label %then10, label %merge11
then10:
  %t135 = load double, double* %l7
  %t136 = insertvalue %NativeEnumLayout undef, double %t135, 0
  %t137 = load double, double* %l8
  %t138 = insertvalue %NativeEnumLayout %t136, double %t137, 1
  %t139 = load i8*, i8** %l9
  %t140 = insertvalue %NativeEnumLayout %t138, i8* %t139, 2
  %t141 = load double, double* %l10
  %t142 = insertvalue %NativeEnumLayout %t140, double %t141, 3
  %t143 = load double, double* %l11
  %t144 = insertvalue %NativeEnumLayout %t142, double %t143, 4
  %t145 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t146 = bitcast { %NativeEnumVariantLayout*, i64 }* %t145 to { %NativeEnumVariantLayout**, i64 }*
  %t147 = insertvalue %NativeEnumLayout %t144, { %NativeEnumVariantLayout**, i64 }* %t146, 5
  %t148 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t147, %NativeEnumLayout* %t148
  store %NativeEnumLayout* %t148, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t149 = phi %NativeEnumLayout* [ %t148, %then10 ], [ %t134, %then8 ]
  store %NativeEnumLayout* %t149, %NativeEnumLayout** %l15
  %t150 = load i8*, i8** %l3
  %t151 = insertvalue %NativeEnum undef, i8* %t150, 0
  %t152 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t153 = bitcast { %NativeEnumVariant*, i64 }* %t152 to { %NativeEnumVariant**, i64 }*
  %t154 = insertvalue %NativeEnum %t151, { %NativeEnumVariant**, i64 }* %t153, 1
  %t155 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t156 = insertvalue %NativeEnum %t154, %NativeEnumLayout* %t155, 2
  %t157 = alloca %NativeEnum
  store %NativeEnum %t156, %NativeEnum* %t157
  %t158 = insertvalue %EnumParseResult undef, %NativeEnum* %t157, 0
  %t159 = load double, double* %l14
  %t160 = insertvalue %EnumParseResult %t158, double %t159, 1
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = insertvalue %EnumParseResult %t160, { i8**, i64 }* %t161, 2
  ret %EnumParseResult %t162
merge9:
  %t163 = load double, double* %l14
  %t164 = fptosi double %t163 to i64
  %t165 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t166 = extractvalue { i8**, i64 } %t165, 0
  %t167 = extractvalue { i8**, i64 } %t165, 1
  %t168 = icmp uge i64 %t164, %t167
  ; bounds check: %t168 (if true, out of bounds)
  %t169 = getelementptr i8*, i8** %t166, i64 %t164
  %t170 = load i8*, i8** %t169
  %t171 = call i8* @trim_text(i8* %t170)
  store i8* %t171, i8** %l16
  %t173 = load i8*, i8** %l16
  %t174 = call i64 @sailfin_runtime_string_length(i8* %t173)
  %t175 = icmp eq i64 %t174, 0
  br label %logical_or_entry_172

logical_or_entry_172:
  br i1 %t175, label %logical_or_merge_172, label %logical_or_right_172

logical_or_right_172:
  %t176 = load i8*, i8** %l16
  %t177 = alloca [2 x i8], align 1
  %t178 = getelementptr [2 x i8], [2 x i8]* %t177, i32 0, i32 0
  store i8 59, i8* %t178
  %t179 = getelementptr [2 x i8], [2 x i8]* %t177, i32 0, i32 1
  store i8 0, i8* %t179
  %t180 = getelementptr [2 x i8], [2 x i8]* %t177, i32 0, i32 0
  %t181 = call i1 @starts_with(i8* %t176, i8* %t180)
  br label %logical_or_right_end_172

logical_or_right_end_172:
  br label %logical_or_merge_172

logical_or_merge_172:
  %t182 = phi i1 [ true, %logical_or_entry_172 ], [ %t181, %logical_or_right_end_172 ]
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = load i8*, i8** %l1
  %t185 = load i8*, i8** %l2
  %t186 = load i8*, i8** %l3
  %t187 = load double, double* %l4
  %t188 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t189 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t190 = load double, double* %l7
  %t191 = load double, double* %l8
  %t192 = load i8*, i8** %l9
  %t193 = load double, double* %l10
  %t194 = load double, double* %l11
  %t195 = load i1, i1* %l12
  %t196 = load i1, i1* %l13
  %t197 = load double, double* %l14
  %t198 = load i8*, i8** %l16
  br i1 %t182, label %then12, label %merge13
then12:
  %t199 = load double, double* %l14
  %t200 = sitofp i64 1 to double
  %t201 = fadd double %t199, %t200
  store double %t201, double* %l14
  br label %loop.latch6
merge13:
  %t202 = load i8*, i8** %l16
  %s203 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.203, i32 0, i32 0
  %t204 = icmp eq i8* %t202, %s203
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
  br i1 %t204, label %then14, label %merge15
then14:
  %t221 = load double, double* %l14
  %t222 = sitofp i64 1 to double
  %t223 = fadd double %t221, %t222
  store double %t223, double* %l14
  br label %loop.latch6
merge15:
  %t224 = load i8*, i8** %l16
  %s225 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.225, i32 0, i32 0
  %t226 = call i1 @starts_with(i8* %t224, i8* %s225)
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
  %t242 = load i8*, i8** %l16
  br i1 %t226, label %then16, label %merge17
then16:
  %t243 = load i8*, i8** %l16
  %s244 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.244, i32 0, i32 0
  %t245 = call i8* @strip_prefix(i8* %t243, i8* %s244)
  store i8* %t245, i8** %l17
  %t246 = load i8*, i8** %l17
  %s247 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.247, i32 0, i32 0
  %t248 = call i1 @starts_with(i8* %t246, i8* %s247)
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = load i8*, i8** %l1
  %t251 = load i8*, i8** %l2
  %t252 = load i8*, i8** %l3
  %t253 = load double, double* %l4
  %t254 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t255 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t256 = load double, double* %l7
  %t257 = load double, double* %l8
  %t258 = load i8*, i8** %l9
  %t259 = load double, double* %l10
  %t260 = load double, double* %l11
  %t261 = load i1, i1* %l12
  %t262 = load i1, i1* %l13
  %t263 = load double, double* %l14
  %t264 = load i8*, i8** %l16
  %t265 = load i8*, i8** %l17
  br i1 %t248, label %then18, label %merge19
then18:
  %t266 = load i8*, i8** %l17
  %s267 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.267, i32 0, i32 0
  %t268 = call i8* @strip_prefix(i8* %t266, i8* %s267)
  %t269 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t268)
  store %EnumLayoutHeaderParse %t269, %EnumLayoutHeaderParse* %l18
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t272 = extractvalue %EnumLayoutHeaderParse %t271, 7
  %t273 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t270, { i8**, i64 }* %t272)
  store { i8**, i64 }* %t273, { i8**, i64 }** %l0
  %t274 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t275 = extractvalue %EnumLayoutHeaderParse %t274, 0
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = load i8*, i8** %l1
  %t278 = load i8*, i8** %l2
  %t279 = load i8*, i8** %l3
  %t280 = load double, double* %l4
  %t281 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t282 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t283 = load double, double* %l7
  %t284 = load double, double* %l8
  %t285 = load i8*, i8** %l9
  %t286 = load double, double* %l10
  %t287 = load double, double* %l11
  %t288 = load i1, i1* %l12
  %t289 = load i1, i1* %l13
  %t290 = load double, double* %l14
  %t291 = load i8*, i8** %l16
  %t292 = load i8*, i8** %l17
  %t293 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t275, label %then20, label %merge21
then20:
  %t294 = load i1, i1* %l12
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load i8*, i8** %l1
  %t297 = load i8*, i8** %l2
  %t298 = load i8*, i8** %l3
  %t299 = load double, double* %l4
  %t300 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t301 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t302 = load double, double* %l7
  %t303 = load double, double* %l8
  %t304 = load i8*, i8** %l9
  %t305 = load double, double* %l10
  %t306 = load double, double* %l11
  %t307 = load i1, i1* %l12
  %t308 = load i1, i1* %l13
  %t309 = load double, double* %l14
  %t310 = load i8*, i8** %l16
  %t311 = load i8*, i8** %l17
  %t312 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t294, label %then22, label %else23
then22:
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s314 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.314, i32 0, i32 0
  %t315 = load i8*, i8** %l3
  %t316 = add i8* %s314, %t315
  %t317 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t313, i8* %t316)
  store { i8**, i64 }* %t317, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t318 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t319 = extractvalue %EnumLayoutHeaderParse %t318, 2
  store double %t319, double* %l7
  %t320 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t321 = extractvalue %EnumLayoutHeaderParse %t320, 3
  store double %t321, double* %l8
  %t322 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t323 = extractvalue %EnumLayoutHeaderParse %t322, 4
  store i8* %t323, i8** %l9
  %t324 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t325 = extractvalue %EnumLayoutHeaderParse %t324, 5
  store double %t325, double* %l10
  %t326 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t327 = extractvalue %EnumLayoutHeaderParse %t326, 6
  store double %t327, double* %l11
  store i1 1, i1* %l12
  br label %merge24
merge24:
  %t328 = phi { i8**, i64 }* [ %t317, %then22 ], [ %t295, %else23 ]
  %t329 = phi double [ %t302, %then22 ], [ %t319, %else23 ]
  %t330 = phi double [ %t303, %then22 ], [ %t321, %else23 ]
  %t331 = phi i8* [ %t304, %then22 ], [ %t323, %else23 ]
  %t332 = phi double [ %t305, %then22 ], [ %t325, %else23 ]
  %t333 = phi double [ %t306, %then22 ], [ %t327, %else23 ]
  %t334 = phi i1 [ %t307, %then22 ], [ 1, %else23 ]
  store { i8**, i64 }* %t328, { i8**, i64 }** %l0
  store double %t329, double* %l7
  store double %t330, double* %l8
  store i8* %t331, i8** %l9
  store double %t332, double* %l10
  store double %t333, double* %l11
  store i1 %t334, i1* %l12
  br label %merge21
merge21:
  %t335 = phi { i8**, i64 }* [ %t317, %then20 ], [ %t276, %then18 ]
  %t336 = phi double [ %t319, %then20 ], [ %t283, %then18 ]
  %t337 = phi double [ %t321, %then20 ], [ %t284, %then18 ]
  %t338 = phi i8* [ %t323, %then20 ], [ %t285, %then18 ]
  %t339 = phi double [ %t325, %then20 ], [ %t286, %then18 ]
  %t340 = phi double [ %t327, %then20 ], [ %t287, %then18 ]
  %t341 = phi i1 [ 1, %then20 ], [ %t288, %then18 ]
  store { i8**, i64 }* %t335, { i8**, i64 }** %l0
  store double %t336, double* %l7
  store double %t337, double* %l8
  store i8* %t338, i8** %l9
  store double %t339, double* %l10
  store double %t340, double* %l11
  store i1 %t341, i1* %l12
  %t342 = load double, double* %l14
  %t343 = sitofp i64 1 to double
  %t344 = fadd double %t342, %t343
  store double %t344, double* %l14
  br label %loop.latch6
merge19:
  %t345 = load i8*, i8** %l17
  %s346 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.346, i32 0, i32 0
  %t347 = call i1 @starts_with(i8* %t345, i8* %s346)
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t349 = load i8*, i8** %l1
  %t350 = load i8*, i8** %l2
  %t351 = load i8*, i8** %l3
  %t352 = load double, double* %l4
  %t353 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t354 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t355 = load double, double* %l7
  %t356 = load double, double* %l8
  %t357 = load i8*, i8** %l9
  %t358 = load double, double* %l10
  %t359 = load double, double* %l11
  %t360 = load i1, i1* %l12
  %t361 = load i1, i1* %l13
  %t362 = load double, double* %l14
  %t363 = load i8*, i8** %l16
  %t364 = load i8*, i8** %l17
  br i1 %t347, label %then25, label %merge26
then25:
  %t365 = load i8*, i8** %l17
  %s366 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.366, i32 0, i32 0
  %t367 = call i8* @strip_prefix(i8* %t365, i8* %s366)
  %t368 = load i8*, i8** %l3
  %t369 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t367, i8* %t368)
  store %EnumLayoutVariantParse %t369, %EnumLayoutVariantParse* %l19
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t372 = extractvalue %EnumLayoutVariantParse %t371, 2
  %t373 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t370, { i8**, i64 }* %t372)
  store { i8**, i64 }* %t373, { i8**, i64 }** %l0
  %t374 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t375 = extractvalue %EnumLayoutVariantParse %t374, 0
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t377 = load i8*, i8** %l1
  %t378 = load i8*, i8** %l2
  %t379 = load i8*, i8** %l3
  %t380 = load double, double* %l4
  %t381 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t382 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t383 = load double, double* %l7
  %t384 = load double, double* %l8
  %t385 = load i8*, i8** %l9
  %t386 = load double, double* %l10
  %t387 = load double, double* %l11
  %t388 = load i1, i1* %l12
  %t389 = load i1, i1* %l13
  %t390 = load double, double* %l14
  %t391 = load i8*, i8** %l16
  %t392 = load i8*, i8** %l17
  %t393 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t375, label %then27, label %merge28
then27:
  %t394 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t395 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t396 = extractvalue %EnumLayoutVariantParse %t395, 1
  %t397 = extractvalue %NativeEnumVariantLayout %t396, 0
  %t398 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t394, i8* %t397)
  store double %t398, double* %l20
  %t399 = load double, double* %l20
  %t400 = sitofp i64 0 to double
  %t401 = fcmp oge double %t399, %t400
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t403 = load i8*, i8** %l1
  %t404 = load i8*, i8** %l2
  %t405 = load i8*, i8** %l3
  %t406 = load double, double* %l4
  %t407 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t408 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t409 = load double, double* %l7
  %t410 = load double, double* %l8
  %t411 = load i8*, i8** %l9
  %t412 = load double, double* %l10
  %t413 = load double, double* %l11
  %t414 = load i1, i1* %l12
  %t415 = load i1, i1* %l13
  %t416 = load double, double* %l14
  %t417 = load i8*, i8** %l16
  %t418 = load i8*, i8** %l17
  %t419 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t420 = load double, double* %l20
  br i1 %t401, label %then29, label %else30
then29:
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s422 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.422, i32 0, i32 0
  %t423 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t424 = extractvalue %EnumLayoutVariantParse %t423, 1
  %t425 = extractvalue %NativeEnumVariantLayout %t424, 0
  %t426 = add i8* %s422, %t425
  %s427 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.427, i32 0, i32 0
  %t428 = add i8* %t426, %s427
  %t429 = load i8*, i8** %l3
  %t430 = add i8* %t428, %t429
  %t431 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t421, i8* %t430)
  store { i8**, i64 }* %t431, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t432 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t433 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t434 = extractvalue %EnumLayoutVariantParse %t433, 1
  %t435 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t432, %NativeEnumVariantLayout %t434)
  store { %NativeEnumVariantLayout*, i64 }* %t435, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t436 = phi { i8**, i64 }* [ %t431, %then29 ], [ %t402, %else30 ]
  %t437 = phi { %NativeEnumVariantLayout*, i64 }* [ %t408, %then29 ], [ %t435, %else30 ]
  store { i8**, i64 }* %t436, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t437, { %NativeEnumVariantLayout*, i64 }** %l6
  %t438 = load i1, i1* %l12
  %t439 = xor i1 %t438, 1
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
  %t455 = load i8*, i8** %l16
  %t456 = load i8*, i8** %l17
  %t457 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t458 = load double, double* %l20
  br i1 %t439, label %then32, label %merge33
then32:
  %t459 = load i1, i1* %l13
  %t460 = xor i1 %t459, 1
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t462 = load i8*, i8** %l1
  %t463 = load i8*, i8** %l2
  %t464 = load i8*, i8** %l3
  %t465 = load double, double* %l4
  %t466 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t467 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t468 = load double, double* %l7
  %t469 = load double, double* %l8
  %t470 = load i8*, i8** %l9
  %t471 = load double, double* %l10
  %t472 = load double, double* %l11
  %t473 = load i1, i1* %l12
  %t474 = load i1, i1* %l13
  %t475 = load double, double* %l14
  %t476 = load i8*, i8** %l16
  %t477 = load i8*, i8** %l17
  %t478 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t479 = load double, double* %l20
  br i1 %t460, label %then34, label %merge35
then34:
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s481 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.481, i32 0, i32 0
  %t482 = load i8*, i8** %l3
  %t483 = add i8* %s481, %t482
  %s484 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.484, i32 0, i32 0
  %t485 = add i8* %t483, %s484
  %t486 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t480, i8* %t485)
  store { i8**, i64 }* %t486, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge35
merge35:
  %t487 = phi { i8**, i64 }* [ %t486, %then34 ], [ %t461, %then32 ]
  %t488 = phi i1 [ 1, %then34 ], [ %t474, %then32 ]
  store { i8**, i64 }* %t487, { i8**, i64 }** %l0
  store i1 %t488, i1* %l13
  br label %merge33
merge33:
  %t489 = phi { i8**, i64 }* [ %t486, %then32 ], [ %t440, %then27 ]
  %t490 = phi i1 [ 1, %then32 ], [ %t453, %then27 ]
  store { i8**, i64 }* %t489, { i8**, i64 }** %l0
  store i1 %t490, i1* %l13
  br label %merge28
merge28:
  %t491 = phi { i8**, i64 }* [ %t431, %then27 ], [ %t376, %then25 ]
  %t492 = phi { %NativeEnumVariantLayout*, i64 }* [ %t435, %then27 ], [ %t382, %then25 ]
  %t493 = phi { i8**, i64 }* [ %t486, %then27 ], [ %t376, %then25 ]
  %t494 = phi i1 [ 1, %then27 ], [ %t389, %then25 ]
  store { i8**, i64 }* %t491, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t492, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t493, { i8**, i64 }** %l0
  store i1 %t494, i1* %l13
  %t495 = load double, double* %l14
  %t496 = sitofp i64 1 to double
  %t497 = fadd double %t495, %t496
  store double %t497, double* %l14
  br label %loop.latch6
merge26:
  %t498 = load i8*, i8** %l17
  %s499 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.499, i32 0, i32 0
  %t500 = call i1 @starts_with(i8* %t498, i8* %s499)
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t502 = load i8*, i8** %l1
  %t503 = load i8*, i8** %l2
  %t504 = load i8*, i8** %l3
  %t505 = load double, double* %l4
  %t506 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t507 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t508 = load double, double* %l7
  %t509 = load double, double* %l8
  %t510 = load i8*, i8** %l9
  %t511 = load double, double* %l10
  %t512 = load double, double* %l11
  %t513 = load i1, i1* %l12
  %t514 = load i1, i1* %l13
  %t515 = load double, double* %l14
  %t516 = load i8*, i8** %l16
  %t517 = load i8*, i8** %l17
  br i1 %t500, label %then36, label %merge37
then36:
  %t518 = load i8*, i8** %l17
  %s519 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.519, i32 0, i32 0
  %t520 = call i8* @strip_prefix(i8* %t518, i8* %s519)
  %t521 = load i8*, i8** %l3
  %t522 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t520, i8* %t521)
  store %EnumLayoutPayloadParse %t522, %EnumLayoutPayloadParse* %l21
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t524 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t525 = extractvalue %EnumLayoutPayloadParse %t524, 3
  %t526 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t523, { i8**, i64 }* %t525)
  store { i8**, i64 }* %t526, { i8**, i64 }** %l0
  %t527 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t528 = extractvalue %EnumLayoutPayloadParse %t527, 0
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t530 = load i8*, i8** %l1
  %t531 = load i8*, i8** %l2
  %t532 = load i8*, i8** %l3
  %t533 = load double, double* %l4
  %t534 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t535 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t536 = load double, double* %l7
  %t537 = load double, double* %l8
  %t538 = load i8*, i8** %l9
  %t539 = load double, double* %l10
  %t540 = load double, double* %l11
  %t541 = load i1, i1* %l12
  %t542 = load i1, i1* %l13
  %t543 = load double, double* %l14
  %t544 = load i8*, i8** %l16
  %t545 = load i8*, i8** %l17
  %t546 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t528, label %then38, label %merge39
then38:
  %t547 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t548 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t549 = extractvalue %EnumLayoutPayloadParse %t548, 1
  %t550 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t547, i8* %t549)
  store double %t550, double* %l22
  %t551 = load double, double* %l22
  %t552 = sitofp i64 0 to double
  %t553 = fcmp olt double %t551, %t552
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t555 = load i8*, i8** %l1
  %t556 = load i8*, i8** %l2
  %t557 = load i8*, i8** %l3
  %t558 = load double, double* %l4
  %t559 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t560 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t561 = load double, double* %l7
  %t562 = load double, double* %l8
  %t563 = load i8*, i8** %l9
  %t564 = load double, double* %l10
  %t565 = load double, double* %l11
  %t566 = load i1, i1* %l12
  %t567 = load i1, i1* %l13
  %t568 = load double, double* %l14
  %t569 = load i8*, i8** %l16
  %t570 = load i8*, i8** %l17
  %t571 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t572 = load double, double* %l22
  br i1 %t553, label %then40, label %else41
then40:
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s574 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.574, i32 0, i32 0
  %t575 = load i8*, i8** %l3
  %t576 = add i8* %s574, %t575
  %s577 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.577, i32 0, i32 0
  %t578 = add i8* %t576, %s577
  %t579 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t580 = extractvalue %EnumLayoutPayloadParse %t579, 1
  %t581 = add i8* %t578, %t580
  %t582 = load i8, i8* %t581
  %t583 = add i8 %t582, 96
  %t584 = alloca [2 x i8], align 1
  %t585 = getelementptr [2 x i8], [2 x i8]* %t584, i32 0, i32 0
  store i8 %t583, i8* %t585
  %t586 = getelementptr [2 x i8], [2 x i8]* %t584, i32 0, i32 1
  store i8 0, i8* %t586
  %t587 = getelementptr [2 x i8], [2 x i8]* %t584, i32 0, i32 0
  %t588 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t573, i8* %t587)
  store { i8**, i64 }* %t588, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t589 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t590 = load double, double* %l22
  %t591 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t592 = extractvalue %EnumLayoutPayloadParse %t591, 2
  %t593 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t589, double %t590, %NativeStructLayoutField %t592)
  store { %NativeEnumVariantLayout*, i64 }* %t593, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t594 = phi { i8**, i64 }* [ %t588, %then40 ], [ %t554, %else41 ]
  %t595 = phi { %NativeEnumVariantLayout*, i64 }* [ %t560, %then40 ], [ %t593, %else41 ]
  store { i8**, i64 }* %t594, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t595, { %NativeEnumVariantLayout*, i64 }** %l6
  %t596 = load i1, i1* %l12
  %t597 = xor i1 %t596, 1
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t599 = load i8*, i8** %l1
  %t600 = load i8*, i8** %l2
  %t601 = load i8*, i8** %l3
  %t602 = load double, double* %l4
  %t603 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t604 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t605 = load double, double* %l7
  %t606 = load double, double* %l8
  %t607 = load i8*, i8** %l9
  %t608 = load double, double* %l10
  %t609 = load double, double* %l11
  %t610 = load i1, i1* %l12
  %t611 = load i1, i1* %l13
  %t612 = load double, double* %l14
  %t613 = load i8*, i8** %l16
  %t614 = load i8*, i8** %l17
  %t615 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t616 = load double, double* %l22
  br i1 %t597, label %then43, label %merge44
then43:
  %t617 = load i1, i1* %l13
  %t618 = xor i1 %t617, 1
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t620 = load i8*, i8** %l1
  %t621 = load i8*, i8** %l2
  %t622 = load i8*, i8** %l3
  %t623 = load double, double* %l4
  %t624 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t625 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t626 = load double, double* %l7
  %t627 = load double, double* %l8
  %t628 = load i8*, i8** %l9
  %t629 = load double, double* %l10
  %t630 = load double, double* %l11
  %t631 = load i1, i1* %l12
  %t632 = load i1, i1* %l13
  %t633 = load double, double* %l14
  %t634 = load i8*, i8** %l16
  %t635 = load i8*, i8** %l17
  %t636 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t637 = load double, double* %l22
  br i1 %t618, label %then45, label %merge46
then45:
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s639 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.639, i32 0, i32 0
  %t640 = load i8*, i8** %l3
  %t641 = add i8* %s639, %t640
  %s642 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.642, i32 0, i32 0
  %t643 = add i8* %t641, %s642
  %t644 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t638, i8* %t643)
  store { i8**, i64 }* %t644, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  br label %merge46
merge46:
  %t645 = phi { i8**, i64 }* [ %t644, %then45 ], [ %t619, %then43 ]
  %t646 = phi i1 [ 1, %then45 ], [ %t632, %then43 ]
  store { i8**, i64 }* %t645, { i8**, i64 }** %l0
  store i1 %t646, i1* %l13
  br label %merge44
merge44:
  %t647 = phi { i8**, i64 }* [ %t644, %then43 ], [ %t598, %then38 ]
  %t648 = phi i1 [ 1, %then43 ], [ %t611, %then38 ]
  store { i8**, i64 }* %t647, { i8**, i64 }** %l0
  store i1 %t648, i1* %l13
  br label %merge39
merge39:
  %t649 = phi { i8**, i64 }* [ %t588, %then38 ], [ %t529, %then36 ]
  %t650 = phi { %NativeEnumVariantLayout*, i64 }* [ %t593, %then38 ], [ %t535, %then36 ]
  %t651 = phi { i8**, i64 }* [ %t644, %then38 ], [ %t529, %then36 ]
  %t652 = phi i1 [ 1, %then38 ], [ %t542, %then36 ]
  store { i8**, i64 }* %t649, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t650, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t651, { i8**, i64 }** %l0
  store i1 %t652, i1* %l13
  %t653 = load double, double* %l14
  %t654 = sitofp i64 1 to double
  %t655 = fadd double %t653, %t654
  store double %t655, double* %l14
  br label %loop.latch6
merge37:
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s657 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.657, i32 0, i32 0
  %t658 = load i8*, i8** %l16
  %t659 = add i8* %s657, %t658
  %t660 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t656, i8* %t659)
  store { i8**, i64 }* %t660, { i8**, i64 }** %l0
  %t661 = load double, double* %l14
  %t662 = sitofp i64 1 to double
  %t663 = fadd double %t661, %t662
  store double %t663, double* %l14
  br label %loop.latch6
merge17:
  %t664 = load i8*, i8** %l16
  %s665 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.665, i32 0, i32 0
  %t666 = icmp eq i8* %t664, %s665
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t668 = load i8*, i8** %l1
  %t669 = load i8*, i8** %l2
  %t670 = load i8*, i8** %l3
  %t671 = load double, double* %l4
  %t672 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t673 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t674 = load double, double* %l7
  %t675 = load double, double* %l8
  %t676 = load i8*, i8** %l9
  %t677 = load double, double* %l10
  %t678 = load double, double* %l11
  %t679 = load i1, i1* %l12
  %t680 = load i1, i1* %l13
  %t681 = load double, double* %l14
  %t682 = load i8*, i8** %l16
  br i1 %t666, label %then47, label %merge48
then47:
  %t683 = load double, double* %l14
  %t684 = sitofp i64 1 to double
  %t685 = fadd double %t683, %t684
  store double %t685, double* %l14
  br label %afterloop7
merge48:
  %t686 = load i8*, i8** %l16
  %s687 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.687, i32 0, i32 0
  %t688 = call i1 @starts_with(i8* %t686, i8* %s687)
  %t689 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t690 = load i8*, i8** %l1
  %t691 = load i8*, i8** %l2
  %t692 = load i8*, i8** %l3
  %t693 = load double, double* %l4
  %t694 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t695 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t696 = load double, double* %l7
  %t697 = load double, double* %l8
  %t698 = load i8*, i8** %l9
  %t699 = load double, double* %l10
  %t700 = load double, double* %l11
  %t701 = load i1, i1* %l12
  %t702 = load i1, i1* %l13
  %t703 = load double, double* %l14
  %t704 = load i8*, i8** %l16
  br i1 %t688, label %then49, label %merge50
then49:
  %t705 = load i8*, i8** %l16
  %s706 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.706, i32 0, i32 0
  %t707 = call i8* @strip_prefix(i8* %t705, i8* %s706)
  %t708 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t707)
  store %NativeEnumVariant* %t708, %NativeEnumVariant** %l23
  %t709 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t710 = bitcast i8* null to %NativeEnumVariant*
  %t711 = icmp eq %NativeEnumVariant* %t709, %t710
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
  %t727 = load i8*, i8** %l16
  %t728 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  br i1 %t711, label %then51, label %else52
then51:
  %t729 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s730 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.730, i32 0, i32 0
  %t731 = load i8*, i8** %l16
  %t732 = add i8* %s730, %t731
  %t733 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t729, i8* %t732)
  store { i8**, i64 }* %t733, { i8**, i64 }** %l0
  br label %merge53
else52:
  %t734 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t735 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t736 = load %NativeEnumVariant, %NativeEnumVariant* %t735
  %t737 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t734, %NativeEnumVariant %t736)
  store { %NativeEnumVariant*, i64 }* %t737, { %NativeEnumVariant*, i64 }** %l5
  br label %merge53
merge53:
  %t738 = phi { i8**, i64 }* [ %t733, %then51 ], [ %t712, %else52 ]
  %t739 = phi { %NativeEnumVariant*, i64 }* [ %t717, %then51 ], [ %t737, %else52 ]
  store { i8**, i64 }* %t738, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t739, { %NativeEnumVariant*, i64 }** %l5
  %t740 = load double, double* %l14
  %t741 = sitofp i64 1 to double
  %t742 = fadd double %t740, %t741
  store double %t742, double* %l14
  br label %loop.latch6
merge50:
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s744 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.744, i32 0, i32 0
  %t745 = load i8*, i8** %l16
  %t746 = add i8* %s744, %t745
  %t747 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t743, i8* %t746)
  store { i8**, i64 }* %t747, { i8**, i64 }** %l0
  %t748 = load double, double* %l14
  %t749 = sitofp i64 1 to double
  %t750 = fadd double %t748, %t749
  store double %t750, double* %l14
  br label %loop.latch6
loop.latch6:
  %t751 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t752 = load double, double* %l14
  %t753 = load double, double* %l7
  %t754 = load double, double* %l8
  %t755 = load i8*, i8** %l9
  %t756 = load double, double* %l10
  %t757 = load double, double* %l11
  %t758 = load i1, i1* %l12
  %t759 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t760 = load i1, i1* %l13
  %t761 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t773 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t773, %NativeEnumLayout** %l24
  %t774 = load i1, i1* %l12
  %t775 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t776 = load i8*, i8** %l1
  %t777 = load i8*, i8** %l2
  %t778 = load i8*, i8** %l3
  %t779 = load double, double* %l4
  %t780 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t781 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t782 = load double, double* %l7
  %t783 = load double, double* %l8
  %t784 = load i8*, i8** %l9
  %t785 = load double, double* %l10
  %t786 = load double, double* %l11
  %t787 = load i1, i1* %l12
  %t788 = load i1, i1* %l13
  %t789 = load double, double* %l14
  %t790 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br i1 %t774, label %then54, label %merge55
then54:
  %t791 = load double, double* %l7
  %t792 = insertvalue %NativeEnumLayout undef, double %t791, 0
  %t793 = load double, double* %l8
  %t794 = insertvalue %NativeEnumLayout %t792, double %t793, 1
  %t795 = load i8*, i8** %l9
  %t796 = insertvalue %NativeEnumLayout %t794, i8* %t795, 2
  %t797 = load double, double* %l10
  %t798 = insertvalue %NativeEnumLayout %t796, double %t797, 3
  %t799 = load double, double* %l11
  %t800 = insertvalue %NativeEnumLayout %t798, double %t799, 4
  %t801 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t802 = bitcast { %NativeEnumVariantLayout*, i64 }* %t801 to { %NativeEnumVariantLayout**, i64 }*
  %t803 = insertvalue %NativeEnumLayout %t800, { %NativeEnumVariantLayout**, i64 }* %t802, 5
  %t804 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t803, %NativeEnumLayout* %t804
  store %NativeEnumLayout* %t804, %NativeEnumLayout** %l24
  br label %merge55
merge55:
  %t805 = phi %NativeEnumLayout* [ %t804, %then54 ], [ %t790, %entry ]
  store %NativeEnumLayout* %t805, %NativeEnumLayout** %l24
  %t806 = load i8*, i8** %l3
  %t807 = insertvalue %NativeEnum undef, i8* %t806, 0
  %t808 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t809 = bitcast { %NativeEnumVariant*, i64 }* %t808 to { %NativeEnumVariant**, i64 }*
  %t810 = insertvalue %NativeEnum %t807, { %NativeEnumVariant**, i64 }* %t809, 1
  %t811 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  %t812 = insertvalue %NativeEnum %t810, %NativeEnumLayout* %t811, 2
  %t813 = alloca %NativeEnum
  store %NativeEnum %t812, %NativeEnum* %t813
  %t814 = insertvalue %EnumParseResult undef, %NativeEnum* %t813, 0
  %t815 = load double, double* %l14
  %t816 = insertvalue %EnumParseResult %t814, double %t815, 1
  %t817 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t818 = insertvalue %EnumParseResult %t816, { i8**, i64 }* %t817, 2
  ret %EnumParseResult %t818
}

define %NativeEnumVariant* @parse_enum_variant_line(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %NativeEnumVariantField*, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca %NativeEnumVariantField*
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call i8* @trim_trailing_delimiters(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t6
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 123, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call double @index_of(i8* %t7, i8* %t11)
  store double %t12, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 0 to double
  %t15 = fcmp olt double %t13, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = call i8* @strip_generics(i8* %t18)
  %t20 = insertvalue %NativeEnumVariant undef, i8* %t19, 0
  %t21 = alloca [0 x %NativeEnumVariantField*]
  %t22 = getelementptr [0 x %NativeEnumVariantField*], [0 x %NativeEnumVariantField*]* %t21, i32 0, i32 0
  %t23 = alloca { %NativeEnumVariantField**, i64 }
  %t24 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t23, i32 0, i32 0
  store %NativeEnumVariantField** %t22, %NativeEnumVariantField*** %t24
  %t25 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  %t26 = insertvalue %NativeEnumVariant %t20, { %NativeEnumVariantField**, i64 }* %t23, 1
  %t27 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t26, %NativeEnumVariant* %t27
  ret %NativeEnumVariant* %t27
merge3:
  %t28 = load i8*, i8** %l0
  %t29 = alloca [2 x i8], align 1
  %t30 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  store i8 125, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 1
  store i8 0, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  %t33 = call double @last_index_of(i8* %t28, i8* %t32)
  store double %t33, double* %l2
  %t35 = load double, double* %l2
  %t36 = sitofp i64 0 to double
  %t37 = fcmp olt double %t35, %t36
  br label %logical_or_entry_34

logical_or_entry_34:
  br i1 %t37, label %logical_or_merge_34, label %logical_or_right_34

logical_or_right_34:
  %t38 = load double, double* %l2
  %t39 = load double, double* %l1
  %t40 = fcmp ole double %t38, %t39
  br label %logical_or_right_end_34

logical_or_right_end_34:
  br label %logical_or_merge_34

logical_or_merge_34:
  %t41 = phi i1 [ true, %logical_or_entry_34 ], [ %t40, %logical_or_right_end_34 ]
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then4, label %merge5
then4:
  %t45 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t45
merge5:
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = fptosi double %t47 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t46, i64 0, i64 %t48)
  %t50 = call i8* @trim_text(i8* %t49)
  %t51 = call i8* @strip_generics(i8* %t50)
  store i8* %t51, i8** %l3
  %t52 = load i8*, i8** %l3
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp eq i64 %t53, 0
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load i8*, i8** %l3
  br i1 %t54, label %then6, label %merge7
then6:
  %t59 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t59
merge7:
  %t60 = load i8*, i8** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  %t64 = load double, double* %l2
  %t65 = fptosi double %t63 to i64
  %t66 = fptosi double %t64 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %t60, i64 %t65, i64 %t66)
  store i8* %t67, i8** %l4
  %t68 = load i8*, i8** %l4
  %t69 = call { i8**, i64 }* @split_enum_field_entries(i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l5
  %t70 = alloca [0 x %NativeEnumVariantField]
  %t71 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* %t70, i32 0, i32 0
  %t72 = alloca { %NativeEnumVariantField*, i64 }
  %t73 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t72, i32 0, i32 0
  store %NativeEnumVariantField* %t71, %NativeEnumVariantField** %t73
  %t74 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t72, i32 0, i32 1
  store i64 0, i64* %t74
  store { %NativeEnumVariantField*, i64 }* %t72, { %NativeEnumVariantField*, i64 }** %l6
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l7
  %t76 = load i8*, i8** %l0
  %t77 = load double, double* %l1
  %t78 = load double, double* %l2
  %t79 = load i8*, i8** %l3
  %t80 = load i8*, i8** %l4
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t82 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t83 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t149 = phi double [ %t83, %entry ], [ %t147, %loop.latch10 ]
  %t150 = phi { %NativeEnumVariantField*, i64 }* [ %t82, %entry ], [ %t148, %loop.latch10 ]
  store double %t149, double* %l7
  store { %NativeEnumVariantField*, i64 }* %t150, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t84 = load double, double* %l7
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t85
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = sitofp i64 %t87 to double
  %t89 = fcmp oge double %t84, %t88
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l1
  %t92 = load double, double* %l2
  %t93 = load i8*, i8** %l3
  %t94 = load i8*, i8** %l4
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t97 = load double, double* %l7
  br i1 %t89, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t99 = load double, double* %l7
  %t100 = fptosi double %t99 to i64
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t98
  %t102 = extractvalue { i8**, i64 } %t101, 0
  %t103 = extractvalue { i8**, i64 } %t101, 1
  %t104 = icmp uge i64 %t100, %t103
  ; bounds check: %t104 (if true, out of bounds)
  %t105 = getelementptr i8*, i8** %t102, i64 %t100
  %t106 = load i8*, i8** %t105
  %t107 = call i8* @trim_text(i8* %t106)
  %t108 = call i8* @trim_trailing_delimiters(i8* %t107)
  store i8* %t108, i8** %l8
  %t109 = load i8*, i8** %l8
  %t110 = call i64 @sailfin_runtime_string_length(i8* %t109)
  %t111 = icmp eq i64 %t110, 0
  %t112 = load i8*, i8** %l0
  %t113 = load double, double* %l1
  %t114 = load double, double* %l2
  %t115 = load i8*, i8** %l3
  %t116 = load i8*, i8** %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t118 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t119 = load double, double* %l7
  %t120 = load i8*, i8** %l8
  br i1 %t111, label %then14, label %merge15
then14:
  %t121 = load double, double* %l7
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l7
  br label %loop.latch10
merge15:
  %t124 = load i8*, i8** %l8
  %t125 = call %NativeEnumVariantField* @parse_enum_variant_field(i8* %t124)
  store %NativeEnumVariantField* %t125, %NativeEnumVariantField** %l9
  %t126 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t127 = bitcast i8* null to %NativeEnumVariantField*
  %t128 = icmp eq %NativeEnumVariantField* %t126, %t127
  %t129 = load i8*, i8** %l0
  %t130 = load double, double* %l1
  %t131 = load double, double* %l2
  %t132 = load i8*, i8** %l3
  %t133 = load i8*, i8** %l4
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t135 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t136 = load double, double* %l7
  %t137 = load i8*, i8** %l8
  %t138 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  br i1 %t128, label %then16, label %merge17
then16:
  %t139 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t139
merge17:
  %t140 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t141 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t142 = load %NativeEnumVariantField, %NativeEnumVariantField* %t141
  %t143 = call { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %t140, %NativeEnumVariantField %t142)
  store { %NativeEnumVariantField*, i64 }* %t143, { %NativeEnumVariantField*, i64 }** %l6
  %t144 = load double, double* %l7
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l7
  br label %loop.latch10
loop.latch10:
  %t147 = load double, double* %l7
  %t148 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t151 = load i8*, i8** %l3
  %t152 = insertvalue %NativeEnumVariant undef, i8* %t151, 0
  %t153 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t154 = bitcast { %NativeEnumVariantField*, i64 }* %t153 to { %NativeEnumVariantField**, i64 }*
  %t155 = insertvalue %NativeEnumVariant %t152, { %NativeEnumVariantField**, i64 }* %t154, 1
  %t156 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t155, %NativeEnumVariant* %t156
  ret %NativeEnumVariant* %t156
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

define %NativeEnumVariantField* @parse_enum_variant_field(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
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
  %t5 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  br label %merge3
merge3:
  %t15 = phi i1 [ 1, %then2 ], [ %t10, %entry ]
  %t16 = phi i8* [ %t14, %then2 ], [ %t9, %entry ]
  store i1 %t15, i1* %l1
  store i8* %t16, i8** %l0
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = call double @index_of(i8* %t17, i8* %s18)
  store double %t19, double* %l2
  %t20 = load double, double* %l2
  %t21 = sitofp i64 0 to double
  %t22 = fcmp olt double %t20, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load i1, i1* %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then4, label %merge5
then4:
  %t26 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t26
merge5:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l2
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 0, i64 %t29)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l3
  %t32 = load i8*, i8** %l3
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load i8*, i8** %l0
  %t36 = load i1, i1* %l1
  %t37 = load double, double* %l2
  %t38 = load i8*, i8** %l3
  br i1 %t34, label %then6, label %merge7
then6:
  %t39 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t39
merge7:
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l2
  %t42 = sitofp i64 2 to double
  %t43 = fadd double %t41, %t42
  %t44 = load i8*, i8** %l0
  %t45 = call i64 @sailfin_runtime_string_length(i8* %t44)
  %t46 = fptosi double %t43 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %t40, i64 %t46, i64 %t45)
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l4
  %t49 = load i8*, i8** %l3
  %t50 = insertvalue %NativeEnumVariantField undef, i8* %t49, 0
  %t51 = load i8*, i8** %l4
  %t52 = insertvalue %NativeEnumVariantField %t50, i8* %t51, 1
  %t53 = load i1, i1* %l1
  %t54 = insertvalue %NativeEnumVariantField %t52, i1 %t53, 2
  %t55 = alloca %NativeEnumVariantField
  store %NativeEnumVariantField %t54, %NativeEnumVariantField* %t55
  ret %NativeEnumVariantField* %t55
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

define i8* @maybe_trim_trailing(i8* %value) {
entry:
  %l0 = alloca i8*
  %t0 = icmp eq i8* %value, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t1 = call i8* @trim_trailing_delimiters(i8* %value)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  ret i8* %t2
}

define %NativeStructField* @parse_struct_field_line(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
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
  %t5 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  br label %merge3
merge3:
  %t15 = phi i1 [ 1, %then2 ], [ %t10, %entry ]
  %t16 = phi i8* [ %t14, %then2 ], [ %t9, %entry ]
  store i1 %t15, i1* %l1
  store i8* %t16, i8** %l0
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = call double @index_of(i8* %t17, i8* %s18)
  store double %t19, double* %l2
  %t20 = load double, double* %l2
  %t21 = sitofp i64 0 to double
  %t22 = fcmp olt double %t20, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load i1, i1* %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then4, label %merge5
then4:
  %t26 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t26
merge5:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l2
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 0, i64 %t29)
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l3
  %t32 = load i8*, i8** %l3
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load i8*, i8** %l0
  %t36 = load i1, i1* %l1
  %t37 = load double, double* %l2
  %t38 = load i8*, i8** %l3
  br i1 %t34, label %then6, label %merge7
then6:
  %t39 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t39
merge7:
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l2
  %t42 = sitofp i64 2 to double
  %t43 = fadd double %t41, %t42
  %t44 = load i8*, i8** %l0
  %t45 = call i64 @sailfin_runtime_string_length(i8* %t44)
  %t46 = fptosi double %t43 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %t40, i64 %t46, i64 %t45)
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l4
  %t49 = load i8*, i8** %l3
  %t50 = insertvalue %NativeStructField undef, i8* %t49, 0
  %t51 = load i8*, i8** %l4
  %t52 = insertvalue %NativeStructField %t50, i8* %t51, 1
  %t53 = load i1, i1* %l1
  %t54 = insertvalue %NativeStructField %t52, i1 %t53, 2
  %t55 = alloca %NativeStructField
  store %NativeStructField %t54, %NativeStructField* %t55
  ret %NativeStructField* %t55
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

define %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
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
  %t45 = bitcast i8* %t44 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t45
  %t46 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t18, i32 0, i32 1
  %t47 = bitcast [48 x i8]* %t46 to i8*
  %t48 = getelementptr inbounds i8, i8* %t47, i64 40
  %t49 = bitcast i8* %t48 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t49
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

define %NativeParameter* @parse_parameter_entry(i8* %body, %NativeSourceSpan* %span) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %t0 = call i8* @trim_text(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  br label %merge3
merge3:
  %t15 = phi i1 [ 1, %then2 ], [ %t10, %entry ]
  %t16 = phi i8* [ %t14, %then2 ], [ %t9, %entry ]
  store i1 %t15, i1* %l1
  store i8* %t16, i8** %l0
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.17, i32 0, i32 0
  store i8* %s17, i8** %l2
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l3
  %t19 = load i8*, i8** %l0
  %t20 = load i1, i1* %l1
  %t21 = load i8*, i8** %l2
  %t22 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t65 = phi i8* [ %t21, %entry ], [ %t63, %loop.latch6 ]
  %t66 = phi double [ %t22, %entry ], [ %t64, %loop.latch6 ]
  store i8* %t65, i8** %l2
  store double %t66, double* %l3
  br label %loop.body5
loop.body5:
  %t23 = load double, double* %l3
  %t24 = load i8*, i8** %l0
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t23, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load i1, i1* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l3
  %t34 = fptosi double %t33 to i64
  %t35 = getelementptr i8, i8* %t32, i64 %t34
  %t36 = load i8, i8* %t35
  store i8 %t36, i8* %l4
  %t38 = load i8, i8* %l4
  %t39 = icmp eq i8 %t38, 32
  br label %logical_or_entry_37

logical_or_entry_37:
  br i1 %t39, label %logical_or_merge_37, label %logical_or_right_37

logical_or_right_37:
  %t41 = load i8, i8* %l4
  %t42 = icmp eq i8 %t41, 45
  br label %logical_or_entry_40

logical_or_entry_40:
  br i1 %t42, label %logical_or_merge_40, label %logical_or_right_40

logical_or_right_40:
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 61
  br label %logical_or_right_end_40

logical_or_right_end_40:
  br label %logical_or_merge_40

logical_or_merge_40:
  %t45 = phi i1 [ true, %logical_or_entry_40 ], [ %t44, %logical_or_right_end_40 ]
  br label %logical_or_right_end_37

logical_or_right_end_37:
  br label %logical_or_merge_37

logical_or_merge_37:
  %t46 = phi i1 [ true, %logical_or_entry_37 ], [ %t45, %logical_or_right_end_37 ]
  %t47 = load i8*, i8** %l0
  %t48 = load i1, i1* %l1
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l3
  %t51 = load i8, i8* %l4
  br i1 %t46, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t52 = load i8*, i8** %l2
  %t53 = load i8, i8* %l4
  %t54 = load i8, i8* %t52
  %t55 = add i8 %t54, %t53
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 %t55, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8* %t59, i8** %l2
  %t60 = load double, double* %l3
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l3
  br label %loop.latch6
loop.latch6:
  %t63 = load i8*, i8** %l2
  %t64 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t67 = load i8*, i8** %l2
  %t68 = call i8* @trim_text(i8* %t67)
  store i8* %t68, i8** %l2
  %t69 = load i8*, i8** %l2
  %t70 = call i64 @sailfin_runtime_string_length(i8* %t69)
  %t71 = icmp eq i64 %t70, 0
  %t72 = load i8*, i8** %l0
  %t73 = load i1, i1* %l1
  %t74 = load i8*, i8** %l2
  %t75 = load double, double* %l3
  br i1 %t71, label %then12, label %merge13
then12:
  %t76 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t76
merge13:
  %s77 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.77, i32 0, i32 0
  store i8* %s77, i8** %l5
  store i8* null, i8** %l6
  %t78 = load i8*, i8** %l0
  %t79 = load double, double* %l3
  %t80 = load i8*, i8** %l0
  %t81 = call i64 @sailfin_runtime_string_length(i8* %t80)
  %t82 = fptosi double %t79 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %t78, i64 %t82, i64 %t81)
  %t84 = call i8* @trim_text(i8* %t83)
  store i8* %t84, i8** %l7
  %t85 = load i8*, i8** %l7
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = icmp sgt i64 %t86, 0
  %t88 = load i8*, i8** %l0
  %t89 = load i1, i1* %l1
  %t90 = load i8*, i8** %l2
  %t91 = load double, double* %l3
  %t92 = load i8*, i8** %l5
  %t93 = load i8*, i8** %l6
  %t94 = load i8*, i8** %l7
  br i1 %t87, label %then14, label %merge15
then14:
  %t95 = load i8*, i8** %l7
  %s96 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.96, i32 0, i32 0
  %t97 = call i1 @starts_with(i8* %t95, i8* %s96)
  %t98 = load i8*, i8** %l0
  %t99 = load i1, i1* %l1
  %t100 = load i8*, i8** %l2
  %t101 = load double, double* %l3
  %t102 = load i8*, i8** %l5
  %t103 = load i8*, i8** %l6
  %t104 = load i8*, i8** %l7
  br i1 %t97, label %then16, label %else17
then16:
  %t105 = load i8*, i8** %l7
  %s106 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.106, i32 0, i32 0
  %t107 = call i8* @strip_prefix(i8* %t105, i8* %s106)
  %t108 = call i8* @trim_text(i8* %t107)
  store i8* %t108, i8** %l7
  %t109 = load i8*, i8** %l7
  %t110 = alloca [2 x i8], align 1
  %t111 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 0
  store i8 61, i8* %t111
  %t112 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 1
  store i8 0, i8* %t112
  %t113 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 0
  %t114 = call double @index_of(i8* %t109, i8* %t113)
  store double %t114, double* %l8
  %t115 = load double, double* %l8
  %t116 = sitofp i64 0 to double
  %t117 = fcmp oge double %t115, %t116
  %t118 = load i8*, i8** %l0
  %t119 = load i1, i1* %l1
  %t120 = load i8*, i8** %l2
  %t121 = load double, double* %l3
  %t122 = load i8*, i8** %l5
  %t123 = load i8*, i8** %l6
  %t124 = load i8*, i8** %l7
  %t125 = load double, double* %l8
  br i1 %t117, label %then19, label %else20
then19:
  %t126 = load i8*, i8** %l7
  %t127 = load double, double* %l8
  %t128 = fptosi double %t127 to i64
  %t129 = call i8* @sailfin_runtime_substring(i8* %t126, i64 0, i64 %t128)
  %t130 = call i8* @trim_text(i8* %t129)
  store i8* %t130, i8** %l5
  %t131 = load i8*, i8** %l7
  %t132 = load double, double* %l8
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  %t135 = load i8*, i8** %l7
  %t136 = call i64 @sailfin_runtime_string_length(i8* %t135)
  %t137 = fptosi double %t134 to i64
  %t138 = call i8* @sailfin_runtime_substring(i8* %t131, i64 %t137, i64 %t136)
  %t139 = call i8* @trim_text(i8* %t138)
  store i8* %t139, i8** %l9
  %t140 = load i8*, i8** %l9
  %t141 = call i64 @sailfin_runtime_string_length(i8* %t140)
  %t142 = icmp sgt i64 %t141, 0
  %t143 = load i8*, i8** %l0
  %t144 = load i1, i1* %l1
  %t145 = load i8*, i8** %l2
  %t146 = load double, double* %l3
  %t147 = load i8*, i8** %l5
  %t148 = load i8*, i8** %l6
  %t149 = load i8*, i8** %l7
  %t150 = load double, double* %l8
  %t151 = load i8*, i8** %l9
  br i1 %t142, label %then22, label %merge23
then22:
  %t152 = load i8*, i8** %l9
  store i8* %t152, i8** %l6
  br label %merge23
merge23:
  %t153 = phi i8* [ %t152, %then22 ], [ %t148, %then19 ]
  store i8* %t153, i8** %l6
  br label %merge21
else20:
  %t154 = load i8*, i8** %l7
  %t155 = call i8* @trim_text(i8* %t154)
  store i8* %t155, i8** %l5
  br label %merge21
merge21:
  %t156 = phi i8* [ %t130, %then19 ], [ %t155, %else20 ]
  %t157 = phi i8* [ %t152, %then19 ], [ %t123, %else20 ]
  store i8* %t156, i8** %l5
  store i8* %t157, i8** %l6
  br label %merge18
else17:
  %t158 = load i8*, i8** %l7
  %t159 = alloca [2 x i8], align 1
  %t160 = getelementptr [2 x i8], [2 x i8]* %t159, i32 0, i32 0
  store i8 61, i8* %t160
  %t161 = getelementptr [2 x i8], [2 x i8]* %t159, i32 0, i32 1
  store i8 0, i8* %t161
  %t162 = getelementptr [2 x i8], [2 x i8]* %t159, i32 0, i32 0
  %t163 = call i1 @starts_with(i8* %t158, i8* %t162)
  %t164 = load i8*, i8** %l0
  %t165 = load i1, i1* %l1
  %t166 = load i8*, i8** %l2
  %t167 = load double, double* %l3
  %t168 = load i8*, i8** %l5
  %t169 = load i8*, i8** %l6
  %t170 = load i8*, i8** %l7
  br i1 %t163, label %then24, label %merge25
then24:
  %t171 = load i8*, i8** %l7
  %t172 = alloca [2 x i8], align 1
  %t173 = getelementptr [2 x i8], [2 x i8]* %t172, i32 0, i32 0
  store i8 61, i8* %t173
  %t174 = getelementptr [2 x i8], [2 x i8]* %t172, i32 0, i32 1
  store i8 0, i8* %t174
  %t175 = getelementptr [2 x i8], [2 x i8]* %t172, i32 0, i32 0
  %t176 = call i8* @strip_prefix(i8* %t171, i8* %t175)
  %t177 = call i8* @trim_text(i8* %t176)
  store i8* %t177, i8** %l10
  %t178 = load i8*, i8** %l10
  %t179 = call i64 @sailfin_runtime_string_length(i8* %t178)
  %t180 = icmp sgt i64 %t179, 0
  %t181 = load i8*, i8** %l0
  %t182 = load i1, i1* %l1
  %t183 = load i8*, i8** %l2
  %t184 = load double, double* %l3
  %t185 = load i8*, i8** %l5
  %t186 = load i8*, i8** %l6
  %t187 = load i8*, i8** %l7
  %t188 = load i8*, i8** %l10
  br i1 %t180, label %then26, label %merge27
then26:
  %t189 = load i8*, i8** %l10
  store i8* %t189, i8** %l6
  br label %merge27
merge27:
  %t190 = phi i8* [ %t189, %then26 ], [ %t186, %then24 ]
  store i8* %t190, i8** %l6
  br label %merge25
merge25:
  %t191 = phi i8* [ %t189, %then24 ], [ %t169, %else17 ]
  store i8* %t191, i8** %l6
  br label %merge18
merge18:
  %t192 = phi i8* [ %t108, %then16 ], [ %t104, %else17 ]
  %t193 = phi i8* [ %t130, %then16 ], [ %t102, %else17 ]
  %t194 = phi i8* [ %t152, %then16 ], [ %t189, %else17 ]
  store i8* %t192, i8** %l7
  store i8* %t193, i8** %l5
  store i8* %t194, i8** %l6
  br label %merge15
merge15:
  %t195 = phi i8* [ %t108, %then14 ], [ %t94, %entry ]
  %t196 = phi i8* [ %t130, %then14 ], [ %t92, %entry ]
  %t197 = phi i8* [ %t152, %then14 ], [ %t93, %entry ]
  %t198 = phi i8* [ %t155, %then14 ], [ %t92, %entry ]
  %t199 = phi i8* [ %t189, %then14 ], [ %t93, %entry ]
  store i8* %t195, i8** %l7
  store i8* %t196, i8** %l5
  store i8* %t197, i8** %l6
  store i8* %t198, i8** %l5
  store i8* %t199, i8** %l6
  %t200 = load i8*, i8** %l2
  %t201 = insertvalue %NativeParameter undef, i8* %t200, 0
  %t202 = load i8*, i8** %l5
  %t203 = insertvalue %NativeParameter %t201, i8* %t202, 1
  %t204 = load i1, i1* %l1
  %t205 = insertvalue %NativeParameter %t203, i1 %t204, 2
  %t206 = load i8*, i8** %l6
  %t207 = insertvalue %NativeParameter %t205, i8* %t206, 3
  %t208 = insertvalue %NativeParameter %t207, %NativeSourceSpan* %span, 4
  %t209 = alloca %NativeParameter
  store %NativeParameter %t208, %NativeParameter* %t209
  ret %NativeParameter* %t209
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
  %t251 = phi i8* [ %t10, %entry ], [ %t246, %loop.latch2 ]
  %t252 = phi double [ %t11, %entry ], [ %t247, %loop.latch2 ]
  %t253 = phi i8* [ %t13, %entry ], [ %t248, %loop.latch2 ]
  %t254 = phi double [ %t12, %entry ], [ %t249, %loop.latch2 ]
  %t255 = phi { i8**, i64 }* [ %t9, %entry ], [ %t250, %loop.latch2 ]
  store i8* %t251, i8** %l1
  store double %t252, double* %l2
  store i8* %t253, i8** %l4
  store double %t254, double* %l3
  store { i8**, i64 }* %t255, { i8**, i64 }** %l0
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
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  %t68 = fptosi double %t67 to i64
  %t69 = getelementptr i8, i8* %body, i64 %t68
  %t70 = load i8, i8* %t69
  %t71 = load i8, i8* %t64
  %t72 = add i8 %t71, %t70
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 %t72, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l2
  %t78 = sitofp i64 2 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l2
  br label %loop.latch2
merge11:
  br label %merge9
merge9:
  %t80 = phi i8* [ %t76, %then8 ], [ %t47, %then6 ]
  %t81 = phi double [ %t79, %then8 ], [ %t48, %then6 ]
  store i8* %t80, i8** %l1
  store double %t81, double* %l2
  %t82 = load i8, i8* %l5
  %t83 = load i8*, i8** %l4
  %t84 = load i8, i8* %t83
  %t85 = icmp eq i8 %t82, %t84
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load i8*, i8** %l4
  %t91 = load i8, i8* %l5
  br i1 %t85, label %then12, label %merge13
then12:
  %s92 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.92, i32 0, i32 0
  store i8* %s92, i8** %l4
  br label %merge13
merge13:
  %t93 = phi i8* [ %s92, %then12 ], [ %t90, %then6 ]
  store i8* %t93, i8** %l4
  %t94 = load double, double* %l2
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l2
  br label %loop.latch2
merge7:
  %t98 = load i8, i8* %l5
  %t99 = icmp eq i8 %t98, 34
  br label %logical_or_entry_97

logical_or_entry_97:
  br i1 %t99, label %logical_or_merge_97, label %logical_or_right_97

logical_or_right_97:
  %t100 = load i8, i8* %l5
  %t101 = icmp eq i8 %t100, 39
  br label %logical_or_right_end_97

logical_or_right_end_97:
  br label %logical_or_merge_97

logical_or_merge_97:
  %t102 = phi i1 [ true, %logical_or_entry_97 ], [ %t101, %logical_or_right_end_97 ]
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load i8*, i8** %l4
  %t108 = load i8, i8* %l5
  br i1 %t102, label %then14, label %merge15
then14:
  %t109 = load i8, i8* %l5
  %t110 = alloca [2 x i8], align 1
  %t111 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 0
  store i8 %t109, i8* %t111
  %t112 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 1
  store i8 0, i8* %t112
  %t113 = getelementptr [2 x i8], [2 x i8]* %t110, i32 0, i32 0
  store i8* %t113, i8** %l4
  %t114 = load i8*, i8** %l1
  %t115 = load i8, i8* %l5
  %t116 = load i8, i8* %t114
  %t117 = add i8 %t116, %t115
  %t118 = alloca [2 x i8], align 1
  %t119 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  store i8 %t117, i8* %t119
  %t120 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 1
  store i8 0, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  store i8* %t121, i8** %l1
  %t122 = load double, double* %l2
  %t123 = sitofp i64 1 to double
  %t124 = fadd double %t122, %t123
  store double %t124, double* %l2
  br label %loop.latch2
merge15:
  %t126 = load i8, i8* %l5
  %t127 = icmp eq i8 %t126, 40
  br label %logical_or_entry_125

logical_or_entry_125:
  br i1 %t127, label %logical_or_merge_125, label %logical_or_right_125

logical_or_right_125:
  %t129 = load i8, i8* %l5
  %t130 = icmp eq i8 %t129, 91
  br label %logical_or_entry_128

logical_or_entry_128:
  br i1 %t130, label %logical_or_merge_128, label %logical_or_right_128

logical_or_right_128:
  %t131 = load i8, i8* %l5
  %t132 = icmp eq i8 %t131, 123
  br label %logical_or_right_end_128

logical_or_right_end_128:
  br label %logical_or_merge_128

logical_or_merge_128:
  %t133 = phi i1 [ true, %logical_or_entry_128 ], [ %t132, %logical_or_right_end_128 ]
  br label %logical_or_right_end_125

logical_or_right_end_125:
  br label %logical_or_merge_125

logical_or_merge_125:
  %t134 = phi i1 [ true, %logical_or_entry_125 ], [ %t133, %logical_or_right_end_125 ]
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load i8*, i8** %l1
  %t137 = load double, double* %l2
  %t138 = load double, double* %l3
  %t139 = load i8*, i8** %l4
  %t140 = load i8, i8* %l5
  br i1 %t134, label %then16, label %merge17
then16:
  %t141 = load double, double* %l3
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l3
  %t144 = load i8*, i8** %l1
  %t145 = load i8, i8* %l5
  %t146 = load i8, i8* %t144
  %t147 = add i8 %t146, %t145
  %t148 = alloca [2 x i8], align 1
  %t149 = getelementptr [2 x i8], [2 x i8]* %t148, i32 0, i32 0
  store i8 %t147, i8* %t149
  %t150 = getelementptr [2 x i8], [2 x i8]* %t148, i32 0, i32 1
  store i8 0, i8* %t150
  %t151 = getelementptr [2 x i8], [2 x i8]* %t148, i32 0, i32 0
  store i8* %t151, i8** %l1
  %t152 = load double, double* %l2
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l2
  br label %loop.latch2
merge17:
  %t156 = load i8, i8* %l5
  %t157 = icmp eq i8 %t156, 41
  br label %logical_or_entry_155

logical_or_entry_155:
  br i1 %t157, label %logical_or_merge_155, label %logical_or_right_155

logical_or_right_155:
  %t159 = load i8, i8* %l5
  %t160 = icmp eq i8 %t159, 93
  br label %logical_or_entry_158

logical_or_entry_158:
  br i1 %t160, label %logical_or_merge_158, label %logical_or_right_158

logical_or_right_158:
  %t161 = load i8, i8* %l5
  %t162 = icmp eq i8 %t161, 125
  br label %logical_or_right_end_158

logical_or_right_end_158:
  br label %logical_or_merge_158

logical_or_merge_158:
  %t163 = phi i1 [ true, %logical_or_entry_158 ], [ %t162, %logical_or_right_end_158 ]
  br label %logical_or_right_end_155

logical_or_right_end_155:
  br label %logical_or_merge_155

logical_or_merge_155:
  %t164 = phi i1 [ true, %logical_or_entry_155 ], [ %t163, %logical_or_right_end_155 ]
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  %t168 = load double, double* %l3
  %t169 = load i8*, i8** %l4
  %t170 = load i8, i8* %l5
  br i1 %t164, label %then18, label %merge19
then18:
  %t171 = load double, double* %l3
  %t172 = sitofp i64 0 to double
  %t173 = fcmp ogt double %t171, %t172
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t175 = load i8*, i8** %l1
  %t176 = load double, double* %l2
  %t177 = load double, double* %l3
  %t178 = load i8*, i8** %l4
  %t179 = load i8, i8* %l5
  br i1 %t173, label %then20, label %merge21
then20:
  %t180 = load double, double* %l3
  %t181 = sitofp i64 1 to double
  %t182 = fsub double %t180, %t181
  store double %t182, double* %l3
  br label %merge21
merge21:
  %t183 = phi double [ %t182, %then20 ], [ %t177, %then18 ]
  store double %t183, double* %l3
  %t184 = load i8*, i8** %l1
  %t185 = load i8, i8* %l5
  %t186 = load i8, i8* %t184
  %t187 = add i8 %t186, %t185
  %t188 = alloca [2 x i8], align 1
  %t189 = getelementptr [2 x i8], [2 x i8]* %t188, i32 0, i32 0
  store i8 %t187, i8* %t189
  %t190 = getelementptr [2 x i8], [2 x i8]* %t188, i32 0, i32 1
  store i8 0, i8* %t190
  %t191 = getelementptr [2 x i8], [2 x i8]* %t188, i32 0, i32 0
  store i8* %t191, i8** %l1
  %t192 = load double, double* %l2
  %t193 = sitofp i64 1 to double
  %t194 = fadd double %t192, %t193
  store double %t194, double* %l2
  br label %loop.latch2
merge19:
  %t195 = load i8, i8* %l5
  %t196 = icmp eq i8 %t195, 44
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load i8*, i8** %l1
  %t199 = load double, double* %l2
  %t200 = load double, double* %l3
  %t201 = load i8*, i8** %l4
  %t202 = load i8, i8* %l5
  br i1 %t196, label %then22, label %merge23
then22:
  %t203 = load double, double* %l3
  %t204 = sitofp i64 0 to double
  %t205 = fcmp oeq double %t203, %t204
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t207 = load i8*, i8** %l1
  %t208 = load double, double* %l2
  %t209 = load double, double* %l3
  %t210 = load i8*, i8** %l4
  %t211 = load i8, i8* %l5
  br i1 %t205, label %then24, label %merge25
then24:
  %t212 = load i8*, i8** %l1
  %t213 = call i8* @trim_text(i8* %t212)
  store i8* %t213, i8** %l6
  %t214 = load i8*, i8** %l6
  %t215 = call i64 @sailfin_runtime_string_length(i8* %t214)
  %t216 = icmp sgt i64 %t215, 0
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l1
  %t219 = load double, double* %l2
  %t220 = load double, double* %l3
  %t221 = load i8*, i8** %l4
  %t222 = load i8, i8* %l5
  %t223 = load i8*, i8** %l6
  br i1 %t216, label %then26, label %merge27
then26:
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t225 = load i8*, i8** %l6
  %t226 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t224, i8* %t225)
  store { i8**, i64 }* %t226, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t227 = phi { i8**, i64 }* [ %t226, %then26 ], [ %t217, %then24 ]
  store { i8**, i64 }* %t227, { i8**, i64 }** %l0
  %s228 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.228, i32 0, i32 0
  store i8* %s228, i8** %l1
  %t229 = load double, double* %l2
  %t230 = sitofp i64 1 to double
  %t231 = fadd double %t229, %t230
  store double %t231, double* %l2
  br label %loop.latch2
merge25:
  br label %merge23
merge23:
  %t232 = phi { i8**, i64 }* [ %t226, %then22 ], [ %t197, %loop.body1 ]
  %t233 = phi i8* [ %s228, %then22 ], [ %t198, %loop.body1 ]
  %t234 = phi double [ %t231, %then22 ], [ %t199, %loop.body1 ]
  store { i8**, i64 }* %t232, { i8**, i64 }** %l0
  store i8* %t233, i8** %l1
  store double %t234, double* %l2
  %t235 = load i8*, i8** %l1
  %t236 = load i8, i8* %l5
  %t237 = load i8, i8* %t235
  %t238 = add i8 %t237, %t236
  %t239 = alloca [2 x i8], align 1
  %t240 = getelementptr [2 x i8], [2 x i8]* %t239, i32 0, i32 0
  store i8 %t238, i8* %t240
  %t241 = getelementptr [2 x i8], [2 x i8]* %t239, i32 0, i32 1
  store i8 0, i8* %t241
  %t242 = getelementptr [2 x i8], [2 x i8]* %t239, i32 0, i32 0
  store i8* %t242, i8** %l1
  %t243 = load double, double* %l2
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l2
  br label %loop.latch2
loop.latch2:
  %t246 = load i8*, i8** %l1
  %t247 = load double, double* %l2
  %t248 = load i8*, i8** %l4
  %t249 = load double, double* %l3
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t256 = load i8*, i8** %l1
  %t257 = call i8* @trim_text(i8* %t256)
  store i8* %t257, i8** %l7
  %t258 = load i8*, i8** %l7
  %t259 = call i64 @sailfin_runtime_string_length(i8* %t258)
  %t260 = icmp sgt i64 %t259, 0
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load i8*, i8** %l1
  %t263 = load double, double* %l2
  %t264 = load double, double* %l3
  %t265 = load i8*, i8** %l4
  %t266 = load i8*, i8** %l7
  br i1 %t260, label %then28, label %merge29
then28:
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load i8*, i8** %l7
  %t269 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t267, i8* %t268)
  store { i8**, i64 }* %t269, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t270 = phi { i8**, i64 }* [ %t269, %then28 ], [ %t261, %entry ]
  store { i8**, i64 }* %t270, { i8**, i64 }** %l0
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t271
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
  %l3 = alloca i8
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
  %t54 = phi double [ %t29, %entry ], [ %t53, %loop.latch10 ]
  store double %t54, double* %l1
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
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fsub double %t35, %t36
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %value, i64 %t38
  %t40 = load i8, i8* %t39
  store i8 %t40, i8* %l3
  %t41 = load i8, i8* %l3
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i1 @is_trim_char(i8* %t45)
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load i8, i8* %l3
  br i1 %t46, label %then14, label %merge15
then14:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fsub double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t53 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t56 = load double, double* %l0
  %t57 = sitofp i64 0 to double
  %t58 = fcmp oeq double %t56, %t57
  br label %logical_and_entry_55

logical_and_entry_55:
  br i1 %t58, label %logical_and_right_55, label %logical_and_merge_55

logical_and_right_55:
  %t59 = load double, double* %l1
  %t60 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t61 = sitofp i64 %t60 to double
  %t62 = fcmp oeq double %t59, %t61
  br label %logical_and_right_end_55

logical_and_right_end_55:
  br label %logical_and_merge_55

logical_and_merge_55:
  %t63 = phi i1 [ false, %logical_and_entry_55 ], [ %t62, %logical_and_right_end_55 ]
  %t64 = load double, double* %l0
  %t65 = load double, double* %l1
  br i1 %t63, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  %t68 = fptosi double %t66 to i64
  %t69 = fptosi double %t67 to i64
  %t70 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t68, i64 %t69)
  ret i8* %t70
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
  %t625 = phi double [ %t21, %entry ], [ %t621, %loop.latch2 ]
  %t626 = phi { i8**, i64 }* [ %t18, %entry ], [ %t622, %loop.latch2 ]
  %t627 = phi { %NativeStruct*, i64 }* [ %t19, %entry ], [ %t623, %loop.latch2 ]
  %t628 = phi { %NativeEnum*, i64 }* [ %t20, %entry ], [ %t624, %loop.latch2 ]
  store double %t625, double* %l4
  store { i8**, i64 }* %t626, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t627, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t628, { %NativeEnum*, i64 }** %l3
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
  %t279 = alloca %NativeStructLayout
  store %NativeStructLayout %t278, %NativeStructLayout* %t279
  %t280 = insertvalue %NativeStruct %t269, %NativeStructLayout* %t279, 4
  store %NativeStruct %t280, %NativeStruct* %l16
  %t281 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t282 = load %NativeStruct, %NativeStruct* %l16
  %t283 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t281, %NativeStruct %t282)
  store { %NativeStruct*, i64 }* %t283, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t284 = phi double [ %t129, %then14 ], [ %t114, %then12 ]
  %t285 = phi i8* [ %t205, %then14 ], [ %t117, %then12 ]
  %t286 = phi { i8**, i64 }* [ %t215, %then14 ], [ %t111, %then12 ]
  %t287 = phi double [ %t241, %then14 ], [ %t114, %then12 ]
  %t288 = phi { %NativeStruct*, i64 }* [ %t283, %then14 ], [ %t112, %then12 ]
  store double %t284, double* %l4
  store i8* %t285, i8** %l7
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  store double %t287, double* %l4
  store { %NativeStruct*, i64 }* %t288, { %NativeStruct*, i64 }** %l2
  %t289 = load double, double* %l4
  %t290 = sitofp i64 1 to double
  %t291 = fadd double %t289, %t290
  store double %t291, double* %l4
  br label %loop.latch2
merge13:
  %t292 = load i8*, i8** %l6
  %s293 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.293, i32 0, i32 0
  %t294 = call i1 @starts_with(i8* %t292, i8* %s293)
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t298 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t299 = load double, double* %l4
  %t300 = load i8*, i8** %l5
  %t301 = load i8*, i8** %l6
  br i1 %t294, label %then28, label %merge29
then28:
  %t302 = load i8*, i8** %l6
  %s303 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.303, i32 0, i32 0
  %t304 = call i8* @strip_prefix(i8* %t302, i8* %s303)
  store i8* %t304, i8** %l17
  %t305 = load i8*, i8** %l17
  %s306 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.306, i32 0, i32 0
  %t307 = call i8* @strip_prefix(i8* %t305, i8* %s306)
  store i8* %t307, i8** %l18
  %t308 = load i8*, i8** %l18
  %t309 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t308)
  store %EnumLayoutHeaderParse %t309, %EnumLayoutHeaderParse* %l19
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t311 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t312 = extractvalue %EnumLayoutHeaderParse %t311, 7
  %t313 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t310, { i8**, i64 }* %t312)
  store { i8**, i64 }* %t313, { i8**, i64 }** %l1
  %t314 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t315 = extractvalue %EnumLayoutHeaderParse %t314, 0
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t318 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t319 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t320 = load double, double* %l4
  %t321 = load i8*, i8** %l5
  %t322 = load i8*, i8** %l6
  %t323 = load i8*, i8** %l17
  %t324 = load i8*, i8** %l18
  %t325 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t315, label %then30, label %else31
then30:
  %t326 = alloca [0 x %NativeEnumVariantLayout]
  %t327 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* %t326, i32 0, i32 0
  %t328 = alloca { %NativeEnumVariantLayout*, i64 }
  %t329 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t328, i32 0, i32 0
  store %NativeEnumVariantLayout* %t327, %NativeEnumVariantLayout** %t329
  %t330 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t328, i32 0, i32 1
  store i64 0, i64* %t330
  store { %NativeEnumVariantLayout*, i64 }* %t328, { %NativeEnumVariantLayout*, i64 }** %l20
  %t331 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t332 = extractvalue %EnumLayoutHeaderParse %t331, 1
  store i8* %t332, i8** %l21
  %t333 = load double, double* %l4
  %t334 = sitofp i64 1 to double
  %t335 = fadd double %t333, %t334
  store double %t335, double* %l4
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
  br label %loop.header33
loop.header33:
  %t576 = phi double [ %t340, %then30 ], [ %t572, %loop.latch35 ]
  %t577 = phi i8* [ %t343, %then30 ], [ %t573, %loop.latch35 ]
  %t578 = phi { i8**, i64 }* [ %t337, %then30 ], [ %t574, %loop.latch35 ]
  %t579 = phi { %NativeEnumVariantLayout*, i64 }* [ %t346, %then30 ], [ %t575, %loop.latch35 ]
  store double %t576, double* %l4
  store i8* %t577, i8** %l17
  store { i8**, i64 }* %t578, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t579, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t348 = load double, double* %l4
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t350 = load { i8**, i64 }, { i8**, i64 }* %t349
  %t351 = extractvalue { i8**, i64 } %t350, 1
  %t352 = sitofp i64 %t351 to double
  %t353 = fcmp oge double %t348, %t352
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t356 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t357 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t358 = load double, double* %l4
  %t359 = load i8*, i8** %l5
  %t360 = load i8*, i8** %l6
  %t361 = load i8*, i8** %l17
  %t362 = load i8*, i8** %l18
  %t363 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t364 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t365 = load i8*, i8** %l21
  br i1 %t353, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t367 = load double, double* %l4
  %t368 = fptosi double %t367 to i64
  %t369 = load { i8**, i64 }, { i8**, i64 }* %t366
  %t370 = extractvalue { i8**, i64 } %t369, 0
  %t371 = extractvalue { i8**, i64 } %t369, 1
  %t372 = icmp uge i64 %t368, %t371
  ; bounds check: %t372 (if true, out of bounds)
  %t373 = getelementptr i8*, i8** %t370, i64 %t368
  %t374 = load i8*, i8** %t373
  %t375 = call i8* @trim_text(i8* %t374)
  store i8* %t375, i8** %l22
  %t376 = load i8*, i8** %l22
  %t377 = call i64 @sailfin_runtime_string_length(i8* %t376)
  %t378 = icmp eq i64 %t377, 0
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t381 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t382 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t383 = load double, double* %l4
  %t384 = load i8*, i8** %l5
  %t385 = load i8*, i8** %l6
  %t386 = load i8*, i8** %l17
  %t387 = load i8*, i8** %l18
  %t388 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t389 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t390 = load i8*, i8** %l21
  %t391 = load i8*, i8** %l22
  br i1 %t378, label %then39, label %merge40
then39:
  %t392 = load double, double* %l4
  %t393 = sitofp i64 1 to double
  %t394 = fadd double %t392, %t393
  store double %t394, double* %l4
  br label %afterloop36
merge40:
  %t396 = load i8*, i8** %l22
  %s397 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.397, i32 0, i32 0
  %t398 = call i1 @starts_with(i8* %t396, i8* %s397)
  br label %logical_and_entry_395

logical_and_entry_395:
  br i1 %t398, label %logical_and_right_395, label %logical_and_merge_395

logical_and_right_395:
  %t399 = load i8*, i8** %l22
  %s400 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.400, i32 0, i32 0
  %t401 = call i1 @starts_with(i8* %t399, i8* %s400)
  %t402 = xor i1 %t401, 1
  br label %logical_and_right_end_395

logical_and_right_end_395:
  br label %logical_and_merge_395

logical_and_merge_395:
  %t403 = phi i1 [ false, %logical_and_entry_395 ], [ %t402, %logical_and_right_end_395 ]
  %t404 = xor i1 %t403, 1
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t407 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t408 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t409 = load double, double* %l4
  %t410 = load i8*, i8** %l5
  %t411 = load i8*, i8** %l6
  %t412 = load i8*, i8** %l17
  %t413 = load i8*, i8** %l18
  %t414 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t415 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t416 = load i8*, i8** %l21
  %t417 = load i8*, i8** %l22
  br i1 %t404, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t418 = load i8*, i8** %l22
  %s419 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.419, i32 0, i32 0
  %t420 = call i1 @starts_with(i8* %t418, i8* %s419)
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t423 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t424 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t425 = load double, double* %l4
  %t426 = load i8*, i8** %l5
  %t427 = load i8*, i8** %l6
  %t428 = load i8*, i8** %l17
  %t429 = load i8*, i8** %l18
  %t430 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t431 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t432 = load i8*, i8** %l21
  %t433 = load i8*, i8** %l22
  br i1 %t420, label %then43, label %else44
then43:
  %t434 = load i8*, i8** %l22
  %s435 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.435, i32 0, i32 0
  %t436 = call i8* @strip_prefix(i8* %t434, i8* %s435)
  store i8* %t436, i8** %l23
  %t437 = load i8*, i8** %l17
  %s438 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.438, i32 0, i32 0
  %t439 = call i8* @strip_prefix(i8* %t437, i8* %s438)
  store i8* %t439, i8** %l24
  %t440 = load i8*, i8** %l24
  %t441 = load i8*, i8** %l21
  %t442 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t440, i8* %t441)
  store %EnumLayoutVariantParse %t442, %EnumLayoutVariantParse* %l25
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t444 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t445 = extractvalue %EnumLayoutVariantParse %t444, 2
  %t446 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t443, { i8**, i64 }* %t445)
  store { i8**, i64 }* %t446, { i8**, i64 }** %l1
  %t447 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t448 = extractvalue %EnumLayoutVariantParse %t447, 0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t452 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t453 = load double, double* %l4
  %t454 = load i8*, i8** %l5
  %t455 = load i8*, i8** %l6
  %t456 = load i8*, i8** %l17
  %t457 = load i8*, i8** %l18
  %t458 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t459 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t460 = load i8*, i8** %l21
  %t461 = load i8*, i8** %l22
  %t462 = load i8*, i8** %l23
  %t463 = load i8*, i8** %l24
  %t464 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t448, label %then46, label %merge47
then46:
  %t465 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t466 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t467 = extractvalue %EnumLayoutVariantParse %t466, 1
  %t468 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t465, %NativeEnumVariantLayout %t467)
  store { %NativeEnumVariantLayout*, i64 }* %t468, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t469 = phi { %NativeEnumVariantLayout*, i64 }* [ %t468, %then46 ], [ %t459, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t469, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t470 = load i8*, i8** %l22
  %s471 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.471, i32 0, i32 0
  %t472 = call i1 @starts_with(i8* %t470, i8* %s471)
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t476 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t477 = load double, double* %l4
  %t478 = load i8*, i8** %l5
  %t479 = load i8*, i8** %l6
  %t480 = load i8*, i8** %l17
  %t481 = load i8*, i8** %l18
  %t482 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t483 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t484 = load i8*, i8** %l21
  %t485 = load i8*, i8** %l22
  br i1 %t472, label %then48, label %merge49
then48:
  %t486 = load i8*, i8** %l22
  %s487 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.487, i32 0, i32 0
  %t488 = call i8* @strip_prefix(i8* %t486, i8* %s487)
  store i8* %t488, i8** %l26
  %t489 = load i8*, i8** %l17
  %s490 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.490, i32 0, i32 0
  %t491 = call i8* @strip_prefix(i8* %t489, i8* %s490)
  store i8* %t491, i8** %l27
  %t492 = load i8*, i8** %l27
  %t493 = load i8*, i8** %l21
  %t494 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t492, i8* %t493)
  store %EnumLayoutPayloadParse %t494, %EnumLayoutPayloadParse* %l28
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t496 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t497 = extractvalue %EnumLayoutPayloadParse %t496, 3
  %t498 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t495, { i8**, i64 }* %t497)
  store { i8**, i64 }* %t498, { i8**, i64 }** %l1
  %t500 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t501 = extractvalue %EnumLayoutPayloadParse %t500, 0
  br label %logical_and_entry_499

logical_and_entry_499:
  br i1 %t501, label %logical_and_right_499, label %logical_and_merge_499

logical_and_right_499:
  %t502 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t503 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t502
  %t504 = extractvalue { %NativeEnumVariantLayout*, i64 } %t503, 1
  %t505 = icmp sgt i64 %t504, 0
  br label %logical_and_right_end_499

logical_and_right_end_499:
  br label %logical_and_merge_499

logical_and_merge_499:
  %t506 = phi i1 [ false, %logical_and_entry_499 ], [ %t505, %logical_and_right_end_499 ]
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t509 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t510 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t511 = load double, double* %l4
  %t512 = load i8*, i8** %l5
  %t513 = load i8*, i8** %l6
  %t514 = load i8*, i8** %l17
  %t515 = load i8*, i8** %l18
  %t516 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t517 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t518 = load i8*, i8** %l21
  %t519 = load i8*, i8** %l22
  %t520 = load i8*, i8** %l26
  %t521 = load i8*, i8** %l27
  %t522 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t506, label %then50, label %merge51
then50:
  %t523 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t524 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t523
  %t525 = extractvalue { %NativeEnumVariantLayout*, i64 } %t524, 1
  %t526 = sub i64 %t525, 1
  store i64 %t526, i64* %l29
  %t527 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t528 = load i64, i64* %l29
  %t529 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t527
  %t530 = extractvalue { %NativeEnumVariantLayout*, i64 } %t529, 0
  %t531 = extractvalue { %NativeEnumVariantLayout*, i64 } %t529, 1
  %t532 = icmp uge i64 %t528, %t531
  ; bounds check: %t532 (if true, out of bounds)
  %t533 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t530, i64 %t528
  %t534 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t533
  store %NativeEnumVariantLayout %t534, %NativeEnumVariantLayout* %l30
  %t535 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t536 = extractvalue %NativeEnumVariantLayout %t535, 5
  %t537 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t538 = extractvalue %EnumLayoutPayloadParse %t537, 2
  %t539 = bitcast { %NativeStructLayoutField**, i64 }* %t536 to { %NativeStructLayoutField*, i64 }*
  %t540 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t539, %NativeStructLayoutField %t538)
  store { %NativeStructLayoutField*, i64 }* %t540, { %NativeStructLayoutField*, i64 }** %l31
  %t541 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t542 = extractvalue %NativeEnumVariantLayout %t541, 0
  %t543 = insertvalue %NativeEnumVariantLayout undef, i8* %t542, 0
  %t544 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t545 = extractvalue %NativeEnumVariantLayout %t544, 1
  %t546 = insertvalue %NativeEnumVariantLayout %t543, double %t545, 1
  %t547 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t548 = extractvalue %NativeEnumVariantLayout %t547, 2
  %t549 = insertvalue %NativeEnumVariantLayout %t546, double %t548, 2
  %t550 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t551 = extractvalue %NativeEnumVariantLayout %t550, 3
  %t552 = insertvalue %NativeEnumVariantLayout %t549, double %t551, 3
  %t553 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t554 = extractvalue %NativeEnumVariantLayout %t553, 4
  %t555 = insertvalue %NativeEnumVariantLayout %t552, double %t554, 4
  %t556 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l31
  %t557 = bitcast { %NativeStructLayoutField*, i64 }* %t556 to { %NativeStructLayoutField**, i64 }*
  %t558 = insertvalue %NativeEnumVariantLayout %t555, { %NativeStructLayoutField**, i64 }* %t557, 5
  %t559 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t560 = load i64, i64* %l29
  %t561 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t559, i32 0, i32 0
  %t563 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t561
  %t562 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t563, i64 %t560
  store %NativeEnumVariantLayout %t558, %NativeEnumVariantLayout* %t562
  br label %merge51
merge51:
  br label %merge49
merge49:
  %t564 = phi i8* [ %t488, %then48 ], [ %t480, %else44 ]
  %t565 = phi { i8**, i64 }* [ %t498, %then48 ], [ %t474, %else44 ]
  store i8* %t564, i8** %l17
  store { i8**, i64 }* %t565, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t566 = phi i8* [ %t436, %then43 ], [ %t488, %else44 ]
  %t567 = phi { i8**, i64 }* [ %t446, %then43 ], [ %t498, %else44 ]
  %t568 = phi { %NativeEnumVariantLayout*, i64 }* [ %t468, %then43 ], [ %t431, %else44 ]
  store i8* %t566, i8** %l17
  store { i8**, i64 }* %t567, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t568, { %NativeEnumVariantLayout*, i64 }** %l20
  %t569 = load double, double* %l4
  %t570 = sitofp i64 1 to double
  %t571 = fadd double %t569, %t570
  store double %t571, double* %l4
  br label %loop.latch35
loop.latch35:
  %t572 = load double, double* %l4
  %t573 = load i8*, i8** %l17
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t575 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t580 = load i8*, i8** %l21
  %t581 = insertvalue %NativeEnum undef, i8* %t580, 0
  %t582 = alloca [0 x %NativeEnumVariant*]
  %t583 = getelementptr [0 x %NativeEnumVariant*], [0 x %NativeEnumVariant*]* %t582, i32 0, i32 0
  %t584 = alloca { %NativeEnumVariant**, i64 }
  %t585 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t584, i32 0, i32 0
  store %NativeEnumVariant** %t583, %NativeEnumVariant*** %t585
  %t586 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t584, i32 0, i32 1
  store i64 0, i64* %t586
  %t587 = insertvalue %NativeEnum %t581, { %NativeEnumVariant**, i64 }* %t584, 1
  %t588 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t589 = extractvalue %EnumLayoutHeaderParse %t588, 2
  %t590 = insertvalue %NativeEnumLayout undef, double %t589, 0
  %t591 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t592 = extractvalue %EnumLayoutHeaderParse %t591, 3
  %t593 = insertvalue %NativeEnumLayout %t590, double %t592, 1
  %t594 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t595 = extractvalue %EnumLayoutHeaderParse %t594, 4
  %t596 = insertvalue %NativeEnumLayout %t593, i8* %t595, 2
  %t597 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t598 = extractvalue %EnumLayoutHeaderParse %t597, 5
  %t599 = insertvalue %NativeEnumLayout %t596, double %t598, 3
  %t600 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t601 = extractvalue %EnumLayoutHeaderParse %t600, 6
  %t602 = insertvalue %NativeEnumLayout %t599, double %t601, 4
  %t603 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t604 = bitcast { %NativeEnumVariantLayout*, i64 }* %t603 to { %NativeEnumVariantLayout**, i64 }*
  %t605 = insertvalue %NativeEnumLayout %t602, { %NativeEnumVariantLayout**, i64 }* %t604, 5
  %t606 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t605, %NativeEnumLayout* %t606
  %t607 = insertvalue %NativeEnum %t587, %NativeEnumLayout* %t606, 2
  store %NativeEnum %t607, %NativeEnum* %l32
  %t608 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t609 = load %NativeEnum, %NativeEnum* %l32
  %t610 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t608, %NativeEnum %t609)
  store { %NativeEnum*, i64 }* %t610, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t611 = load double, double* %l4
  %t612 = sitofp i64 1 to double
  %t613 = fadd double %t611, %t612
  store double %t613, double* %l4
  br label %merge32
merge32:
  %t614 = phi double [ %t335, %then30 ], [ %t613, %else31 ]
  %t615 = phi i8* [ %t436, %then30 ], [ %t323, %else31 ]
  %t616 = phi { i8**, i64 }* [ %t446, %then30 ], [ %t317, %else31 ]
  %t617 = phi { %NativeEnum*, i64 }* [ %t610, %then30 ], [ %t319, %else31 ]
  store double %t614, double* %l4
  store i8* %t615, i8** %l17
  store { i8**, i64 }* %t616, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t617, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t618 = load double, double* %l4
  %t619 = sitofp i64 1 to double
  %t620 = fadd double %t618, %t619
  store double %t620, double* %l4
  br label %loop.latch2
loop.latch2:
  %t621 = load double, double* %l4
  %t622 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t623 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t624 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t629 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t630 = bitcast { %NativeStruct*, i64 }* %t629 to { %NativeStruct**, i64 }*
  %t631 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t630, 0
  %t632 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t633 = bitcast { %NativeEnum*, i64 }* %t632 to { %NativeEnum**, i64 }*
  %t634 = insertvalue %LayoutManifest %t631, { %NativeEnum**, i64 }* %t633, 1
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t636 = insertvalue %LayoutManifest %t634, { i8**, i64 }* %t635, 2
  ret %LayoutManifest %t636
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
  %t54 = phi double [ %t4, %entry ], [ %t53, %loop.latch4 ]
  store double %t54, double* %l0
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
  %t43 = phi i1 [ %t16, %loop.body3 ], [ %t41, %loop.latch10 ]
  %t44 = phi double [ %t15, %loop.body3 ], [ %t42, %loop.latch10 ]
  store i1 %t43, i1* %l2
  store double %t44, double* %l1
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
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = fadd double %t24, %t25
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %value, i64 %t27
  %t29 = load i8, i8* %t28
  %t30 = load double, double* %l1
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %target, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = icmp ne i8 %t29, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i1, i1* %l2
  br i1 %t34, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch10
loop.latch10:
  %t41 = load i1, i1* %l2
  %t42 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t45 = load i1, i1* %l2
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = load i1, i1* %l2
  br i1 %t45, label %then16, label %merge17
then16:
  %t49 = load double, double* %l0
  ret double %t49
merge17:
  %t50 = load double, double* %l0
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l0
  br label %loop.latch4
loop.latch4:
  %t53 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t55 = sitofp i64 -1 to double
  ret double %t55
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
  %t54 = phi double [ %t8, %entry ], [ %t53, %loop.latch4 ]
  store double %t54, double* %l0
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
  %t43 = phi i1 [ %t16, %loop.body3 ], [ %t41, %loop.latch10 ]
  %t44 = phi double [ %t15, %loop.body3 ], [ %t42, %loop.latch10 ]
  store i1 %t43, i1* %l2
  store double %t44, double* %l1
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
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = fadd double %t24, %t25
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %value, i64 %t27
  %t29 = load i8, i8* %t28
  %t30 = load double, double* %l1
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %target, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = icmp ne i8 %t29, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i1, i1* %l2
  br i1 %t34, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch10
loop.latch10:
  %t41 = load i1, i1* %l2
  %t42 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t45 = load i1, i1* %l2
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = load i1, i1* %l2
  br i1 %t45, label %then16, label %merge17
then16:
  %t49 = load double, double* %l0
  ret double %t49
merge17:
  %t50 = load double, double* %l0
  %t51 = sitofp i64 1 to double
  %t52 = fsub double %t50, %t51
  store double %t52, double* %l0
  br label %loop.latch4
loop.latch4:
  %t53 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t55 = sitofp i64 -1 to double
  ret double %t55
}

define i8* @strip_quotes(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca i8
  %l2 = alloca i1
  %l3 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp sge i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr i8, i8* %value, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = sub i64 %t4, 1
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l1
  %t9 = load i8, i8* %l0
  %t10 = icmp eq i8 %t9, 34
  br label %logical_and_entry_8

logical_and_entry_8:
  br i1 %t10, label %logical_and_right_8, label %logical_and_merge_8

logical_and_right_8:
  %t11 = load i8, i8* %l1
  %t12 = icmp eq i8 %t11, 34
  br label %logical_and_right_end_8

logical_and_right_end_8:
  br label %logical_and_merge_8

logical_and_merge_8:
  %t13 = phi i1 [ false, %logical_and_entry_8 ], [ %t12, %logical_and_right_end_8 ]
  store i1 %t13, i1* %l2
  %t15 = load i8, i8* %l0
  %t16 = icmp eq i8 %t15, 39
  br label %logical_and_entry_14

logical_and_entry_14:
  br i1 %t16, label %logical_and_right_14, label %logical_and_merge_14

logical_and_right_14:
  %t17 = load i8, i8* %l1
  %t18 = icmp eq i8 %t17, 39
  br label %logical_and_right_end_14

logical_and_right_end_14:
  br label %logical_and_merge_14

logical_and_merge_14:
  %t19 = phi i1 [ false, %logical_and_entry_14 ], [ %t18, %logical_and_right_end_14 ]
  store i1 %t19, i1* %l3
  %t21 = load i1, i1* %l2
  br label %logical_or_entry_20

logical_or_entry_20:
  br i1 %t21, label %logical_or_merge_20, label %logical_or_right_20

logical_or_right_20:
  %t22 = load i1, i1* %l3
  br label %logical_or_right_end_20

logical_or_right_end_20:
  br label %logical_or_merge_20

logical_or_merge_20:
  %t23 = phi i1 [ true, %logical_or_entry_20 ], [ %t22, %logical_or_right_end_20 ]
  %t24 = load i8, i8* %l0
  %t25 = load i8, i8* %l1
  %t26 = load i1, i1* %l2
  %t27 = load i1, i1* %l3
  br i1 %t23, label %then2, label %merge3
then2:
  %t28 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t29 = sub i64 %t28, 1
  %t30 = call i8* @sailfin_runtime_substring(i8* %value, i64 1, i64 %t29)
  ret i8* %t30
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
